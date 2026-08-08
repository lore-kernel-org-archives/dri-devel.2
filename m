Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF661C55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 17:36:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425CB10E050;
	Sat,  8 Aug 2026 17:36:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dj2FHK0N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDA3610E050
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 17:36:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83FAB409ED;
 Sat,  8 Aug 2026 17:36:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E661F000E9;
 Sat,  8 Aug 2026 17:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786210596;
 bh=V8nSMtjBBed8KS6Xkf7UxSfws2ZIaUtj6/rZRwY25Kg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dj2FHK0NsteXOnfv4BjMfnE2losdPAz49F6is7SeQZAhrp8MnEJdeMCXVdgi53Ml0
 SU1hAUGUR6msM8bucV8JK+45LyZ41BVLWdVIfAuAVFa7bGLsJQ1Oxyi+f/BvQJzThE
 w0u2eAzpefITxWlZsCSZfLINbMqNzTkPB5IGe0FBOa4e3xWVQXZtLFppcsHR4XsJ4L
 gCgbXG4wXh861d82XRO3In2RaIUASbhpm4MDedVAFdPQHe5/+7j94UPqjSe1zr1MoT
 rhMi7GEzLr4wu0Uik0kL4QkNEIxCT2sNDNcS+REynnWWq+/hB2fFo16hXe6VPDhoYD
 O3vF9W7dMYuZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dp: skip PUSH_IDLE when the link was never enabled
To: "Jesse Casco" <jesse.casco@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808171325.133041-1-jesse.casco@gmail.com>
References: <20260808171325.133041-1-jesse.casco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 17:36:35 +0000
Message-Id: <20260808173636.46E661F000E9@smtp.kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Clock references and mainlink hardware state are leaked if stream =
initialization fails.
- [High] Unbalanced pm_runtime_put_sync() when atomic_enable fails, causing=
 PM usage count underflow.
- [High] Unbalanced pm_runtime_put_sync() in HPD disable path causing PM co=
unt underflow.
- [High] Use-after-free of dp->aux in the IRQ handler due to premature manu=
al cleanup.
- [High] The bridge atomic disable callback calls a sleeping function, viol=
ating DRM atomic context constraints.
- [High] msm_dp_bridge_detect leaks a runtime PM reference on every success=
ful probe of a connected display.
--

--- Patch [1]: [PATCH] drm/msm/dp: skip PUSH_IDLE when the link was never e=
nabled ---
commit 439afaff7381d5903b6066c5f4c3f708d9f34ffd
Author: Jesse Casco <jesse.casco@gmail.com>

drm/msm/dp: skip PUSH_IDLE when the link was never enabled

msm_dp_display_atomic_enable() returns early when link training fails,
leaving ->power_on false and the main link down.
msm_dp_display_atomic_disable() nevertheless writes DP_STATE_CTRL_PUSH_IDLE
and waits for an idle-pattern completion that cannot arrive, so every failed
enable is followed by "PUSH_IDLE pattern timedout".

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index dc6f33809ca5f..17e0410126ce8 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1416,6 +1416,20 @@ void msm_dp_bridge_atomic_disable(struct drm_bridg=
e *drm_bridge,
> =20
>  	msm_dp_display =3D container_of(dp, struct msm_dp_display_private, msm_=
dp_display);
> =20
> +	/*
> +	 * If .atomic_enable() bailed out - link training failure is the common
> +	 * case - the mainlink was never brought up and ->power_on stayed false.
> +	 * Driving the PUSH_IDLE pattern into a controller that was never
> +	 * enabled times out, and .atomic_post_disable() then drops the
> +	 * controller's runtime-PM reference without tearing the PHY back down,
> +	 * because msm_dp_display_disable() returns early on !power_on.  On
> +	 * glymur (Snapdragon X2 Elite) that combination is answered by a
> +	 * TrustZone-level SOCCP/ADSP force-stop and a silent SoC reset.
> +	 * There is nothing to push idle, so leave it alone.
> +	 */
> +	if (!dp->power_on)
> +		return;
> +
>  	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);

[Severity: High]
This isn't a bug introduced by this patch, but does this function violate
DRM atomic context constraints?

In msm_dp_bridge_atomic_disable(), there is a call to msm_dp_ctrl_push_idle=
()
which pushes an idle pattern and waits:

drivers/gpu/drm/msm/dp/dp_ctrl.c:msm_dp_ctrl_push_idle() {
    ...
    if (!wait_for_completion_timeout(&ctrl->idle_comp,
            IDLE_PATTERN_COMPLETION_TIMEOUT_JIFFIES))
    ...
}

Since bridge atomic disable callbacks execute in atomic context, sleeping
functions like wait_for_completion_timeout() are forbidden. While the patch
adds an early return for the !power_on case, won't this still sleep and cau=
se
kernel warnings or deadlocks during normal display teardown paths?

>  }

[Severity: High]
This is a pre-existing issue, but does the error handling in
msm_dp_bridge_atomic_enable() leak clock references and mainlink hardware
state?

When msm_dp_display_enable() fails (e.g., wait4video_ready times out), it
leaves the pixel clock enabled but returns an error. The atomic enable
callback ignores this error:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_atomic_enable() {
    ...
    msm_dp_display_enable(msm_dp_display, force_link_train);
    rc =3D msm_dp_display_post_enable(dp);
    ...
}

Because the error is ignored and power_on remains false, the subsequent
teardown in msm_dp_display_disable() skips teardown entirely:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_disable() {
    ...
    if (!msm_dp_display->power_on)
        return 0;
    ...
}

Does this leave the clocks and PHY permanently enabled?

[Severity: High]
This is a pre-existing issue, but is there an unbalanced PM runtime put when
msm_dp_bridge_atomic_enable() bails out early?

If msm_dp_bridge_atomic_enable() returns early due to missing clock
parameters or if pm_runtime_resume_and_get() fails, it does not acquire a
PM reference:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_atomic_enable() {
    ...
    if (!msm_dp_display->msm_dp_mode.drm_mode.clock) {
        DRM_ERROR("invalid params\n");
        return;
    }
    ...
}

Since the DRM core still considers the enable step complete, the disable pa=
th
will later call msm_dp_bridge_atomic_post_disable(), which unconditionally
drops a reference:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_atomic_post_disable() {
    ...
    pm_runtime_put_sync(&dp->pdev->dev);
    ...
}

Will this cause the device's PM usage counter to underflow?

[Severity: High]
This isn't a bug introduced by this patch, but does the HPD disable path
suffer from a similar PM reference underflow?

If pm_runtime_resume_and_get() fails in msm_dp_bridge_hpd_enable(), it
returns early without acquiring the reference:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_hpd_enable() {
    ...
    if (pm_runtime_resume_and_get(&msm_dp_display->pdev->dev)) {
        DRM_ERROR("failed to resume power\n");
        return;
    }
    ...
}

Then msm_dp_bridge_hpd_disable() unconditionally drops the reference later:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_hpd_disable() {
    ...
    pm_runtime_put_sync(&msm_dp_display->pdev->dev);
    ...
}

Can this destabilize the device power state by dropping an unacquired
reference?

[Severity: High]
This is a pre-existing issue, but is there a use-after-free risk during
driver removal?

In msm_dp_display_remove(), the sub-modules (including dp->aux) are manually
freed:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_remove() {
    ...
    msm_dp_display_deinit_sub_modules(dp);
    ...
}

Because the IRQ was registered with devm_request_threaded_irq(), the
interrupt remains active until devres cleanup runs after remove() returns.
If an interrupt fires in this window, msm_dp_display_irq_handler() will
dereference the freed aux pointer:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_irq_handler() {
    ...
    hpd_isr_status =3D msm_dp_aux_get_hpd_intr_status(dp->aux);
    ...
}

Could this lead to memory corruption or a kernel panic if the hardware
interrupt fires during unbind?

[Severity: High]
This is a pre-existing issue, but does msm_dp_bridge_detect() leak a runtime
PM reference on every successful probe of a connected display?

The function unconditionally acquires a PM reference at the start, and if a
connected display is detected, it skips dropping the reference:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_detect() {
    ...
    if (!priv->plugged) {
        if (phy_deinit) {
            msm_dp_aux_enable_xfers(priv->aux, false);
            msm_dp_display_host_phy_exit(priv);
        }

        pm_runtime_put_sync(&dp->pdev->dev);
    }
    ...
}

Does this mean every time userspace polls the connector state while a displ=
ay
is connected, a new PM reference is acquired and never dropped, permanently
preventing the device from suspending?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808171325.1330=
41-1-jesse.casco@gmail.com?part=3D1
