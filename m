Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FDAC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 22:02:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6790E10E040;
	Thu, 13 Aug 2026 22:02:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A/AQvLAI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DFB210E040
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 22:02:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 110F3407BA;
 Thu, 13 Aug 2026 22:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76AA1F000E9;
 Thu, 13 Aug 2026 22:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786658563;
 bh=uztOojXZ1yE517xBpsBW5dq1952Xh4MfmPRSI32O1a8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A/AQvLAI+krzqfv6Uh4ikqRwiHtELE/Y0HONZWqB38KMFjHnSszM3Og8odwJxIzAB
 OS1YcpFGSBvgNrFJJ/SzkS35OfZsL/+XuqvJgUnY/u6HixrlamfJnvvyrNawSVZ9Bs
 9kdlHpxqQnhyEcSB0QC6udE+vm52BtOMO/HUw1e1QGEjLpJUqvMfXWM3svVeKNPsFR
 vR4abfxgp6ILCLkheiVooMYKWqZ0hYiWIZjaCSQ+RcSeQg3UwZZPexwcWFBNLUx8Wq
 d6tCq+0mIjy0lTEqmBaa5m7X8+kqGTCa6z2uBs1K8jm/e60yE7RPz42YcTkLionIcG
 3pR/drzGcEABw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/10] drm/msm/dp: Move link training to atomic_enable()
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260314-hpd-refactor-v5-4-0c8450737d64@oss.qualcomm.com>
References: <20260314-hpd-refactor-v5-4-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:02:39 +0000
Message-Id: <20260813220239.E76AA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Silent link training failure in atomic_enable leaves userspace wit=
h a broken display state.
- [High] Moving DP link training to `atomic_enable()` leaves the unplug han=
dler performing unbalanced clock disable and PHY power off, which corrupts =
the PHY power state.
- [Medium] Commit message and implementation mismatch regarding hpd_notify(=
).

Pre-existing issues:
- [High] Missing PM runtime put on error paths in `msm_dp_bridge_atomic_ena=
ble` causes a usage counter leak.
- [High] Failure during `msm_dp_ctrl_on_stream()` permanently leaks link cl=
ocks, stream clocks, and PHY power.
--

--- Patch [4]: [PATCH v5 04/10] drm/msm/dp: Move link training to atomic_en=
able() ---
commit c64d2d707d517a12463d9c1b31e96a4e25a831e3
Author: Jessica Zhang <jesszhan0024@gmail.com>

drm/msm/dp: Move link training to atomic_enable()

This commit moves DP link training from the HPD handler into atomic_enable(=
).
It also states that plug and unplug handlers are called directly in
hpd_notify() to prevent preemption by other events.

> Finally, call the plug/unplug handlers directly in hpd_notify() instead
> of queueing them in the event thread so that they aren't preempted by
> other events.

[Severity: Medium]
Is this description accurate regarding hpd_notify()?

Looking at msm_dp_bridge_hpd_notify(), the code continues to queue events v=
ia
msm_dp_add_event() rather than calling the handlers directly:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_hpd_notify() {
    if (!msm_dp_display->link_ready && status =3D=3D connector_status_conne=
cted)
        msm_dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
    else if (msm_dp_display->link_ready && status =3D=3D connector_status_d=
isconnected)
        msm_dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
}

Could the commit message or implementation be updated to match?

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index a05144de3b93f..e7b1ed5491c49 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -436,11 +436,6 @@ static int msm_dp_display_process_hpd_high(struct ms=
m_dp_display_private *dp)
>  	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
> =20
>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
> -	rc =3D msm_dp_ctrl_on_link(dp->ctrl);
> -	if (rc) {
> -		DRM_ERROR("failed to complete DP link training\n");
> -		goto end;
> -	}

[Severity: High]
Does removing the link training here leave the unplug handler performing an
unbalanced clock disable and PHY power off?

If a user unplugs the display while in ST_MAINLINK_READY (before userspace
issues an atomic commit), msm_dp_hpd_unplug_handle() will call
msm_dp_ctrl_off_link().

This blindly calls clk_bulk_disable_unprepare() and phy_power_off() on cloc=
ks
and PHYs that were never enabled, leading to an unbalanced clock disable
warning and decrementing the PHY power_count to a negative value. Once the
power_count drops to -1, the next phy_power_on() increments it to 0 and
bypasses the actual hardware callback, which seems like it would break the
display until reboot.

> =20
>  	msm_dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
> =20

[ ... ]

> @@ -1695,6 +1690,11 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge=
 *drm_bridge,
>  		force_link_train =3D true;
>  	}
> =20
> +	rc =3D msm_dp_ctrl_on_link(msm_dp_display->ctrl);
> +	if (rc)
> +		DRM_ERROR("Failed link training (rc=3D%d)\n", rc);
> +	// TODO: schedule drm_connector_set_link_status_property()
> +

[Severity: High]
Will this leave userspace with a silently broken display state if
msm_dp_ctrl_on_link() fails?

The error is logged, but execution proceeds to enable the display anyway.
Without the mentioned drm_connector_set_link_status_property() update to ma=
rk
the link as BAD, does userspace have any way to know it must trigger a
recovery modeset?

[Severity: High]
This is a pre-existing issue, but does this function leak a PM runtime usage
counter on its error paths?

Earlier in msm_dp_bridge_atomic_enable(), a reference is acquired via
pm_runtime_resume_and_get(), but the early returns do not release it:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_bridge_atomic_enable() {
    ...
    hpd_state =3D msm_dp_display->hpd_state;
    if (hpd_state !=3D ST_DISPLAY_OFF && hpd_state !=3D ST_MAINLINK_READY) {
        mutex_unlock(&msm_dp_display->event_mutex);
        return;
    }

    rc =3D msm_dp_display_set_mode(dp, &msm_dp_display->msm_dp_mode);
    if (rc) {
        DRM_ERROR("Failed to perform a mode set, rc=3D%d\n", rc);
        mutex_unlock(&msm_dp_display->event_mutex);
        return;
    }
    ...
}

If either condition fails, the function returns early without calling
pm_runtime_put_sync(). Will this permanently prevent the display controller
from entering suspend states?

[Severity: High]
This is also a pre-existing issue, but can a failure during stream setup
permanently leak link clocks, stream clocks, and PHY power?

In msm_dp_ctrl_on_stream():

drivers/gpu/drm/msm/dp/dp_ctrl.c:msm_dp_ctrl_on_stream() {
    ...
    msm_dp_ctrl_enable_mainlink_clks(ctrl);

    ret =3D msm_dp_ctrl_set_tu(ctrl);
    if (ret)
        return ret;
    ...
}

If msm_dp_ctrl_set_tu() (or a subsequent step) fails, the function returns
without disabling the clocks and PHY power enabled earlier.

The caller (msm_dp_display_enable) then skips setting
msm_dp_display->power_on =3D true.

Later, msm_dp_display_disable() bypasses teardown:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_disable() {
    if (!msm_dp_display->power_on)
        return 0;
    ...
}

Does this bypass cement the resource leak and permanently block PM?

>  	msm_dp_display_enable(msm_dp_display, force_link_train);
> =20
>  	rc =3D msm_dp_display_post_enable(dp);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260314-hpd-refact=
or-v5-0-0c8450737d64@oss.qualcomm.com?part=3D4
