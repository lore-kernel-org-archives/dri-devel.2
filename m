Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F55C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD83010E79B;
	Mon, 31 Aug 2026 09:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YY6di7fH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B31610E79C
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:21:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE402407D4;
 Mon, 31 Aug 2026 09:21:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 950D41F000E9;
 Mon, 31 Aug 2026 09:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788168084;
 bh=poKTcqAOg+12oDOBCS7dAOgYzuf0QVQRkun6pmtXtoo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YY6di7fHcJ+H3ebJPHDc6zMkBhlswT2WJPY8fwSwKQln6zYCygtsAT8Bcae6PSXMg
 EJbwtTaYATcq9dqLrLy5+g2KG8DOF8jzGAZlX0x5pg43pzZfZAe0s+yXCLGRgBMXB6
 NtkVsPS86QyNsFI4SkNi4CZAoFC5/hEJoS6Fp4EPx4N7B23Rz3+UU/BGOoBVSf3FqD
 Is757DH6X329gaJK98iivsDZRTtq0moU55v5PuL0AxC+m6SnfSXQAjcKCPgvo9379N
 GWrwTXUslbsFWD+yNRH5hlXTdLvjjQqeJxRimNIND7vIWgqdiJ8MGl9zFP92mpDAEt
 P/E53+FwVLHGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/29] drm/msm/dp: factor out _helper variants of
 bridge ops accepting a panel
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-15-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-15-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:21:24 +0000
Message-Id: <20260831092124.950D41F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Unclocked register access and system crash in atomic_disable i=
f link preparation fails.
- [High] Sleeping function called from atomic context in the atomic_post_di=
sable path.
--

commit e10b321045ec4e6478af1b4a9b441fca4e712881
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: drm/msm/dp: factor out _helper variants of bridge ops accepting a =
panel

This commit factors out helper variants of DP bridge operations to accept
arbitrary panels, facilitating MST support. It updates the atomic callbacks
to act as thin wrappers around these helpers and modifies prepare/unprepare
functions to use the generic msm_dp structure.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 9c5563dcb856e..6103fa67f3ee9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> +void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
> +				   struct msm_dp_panel *msm_dp_panel)
> +{
> +	struct msm_dp_display_private *dp;
> +
> +	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> +
> +	msm_dp_ctrl_push_vcpf(dp->ctrl, msm_dp_panel);
> +	msm_dp_ctrl_mst_timeslot_setup(dp->ctrl);
> +	msm_dp_ctrl_mst_send_act(dp->ctrl, msm_dp_panel);
> +}

[Severity: Critical]
This isn't a bug introduced by this patch, but does this sequence
unconditionally write to hardware registers without ensuring the link
is prepared?

If msm_dp_display_prepare_link() fails earlier in the atomic commit path,
the hardware clocks and power domains are not enabled. Because the
atomic_pre_enable() callback returns void, the DRM core still considers
the display enabled.

On a subsequent disable, msm_dp_display_atomic_disable() unconditionally
calls this helper. Accessing hardware MMIO registers like REG_DP_STATE_CTRL
via msm_dp_ctrl_push_vcpf() when the clocks are disabled causes a
synchronous external abort (kernel panic).

Could we add a link readiness check to safely skip these MMIO writes if the
display is not powered on?

[ ... ]
> -static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
> +void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
>  {
[ ... ]
>  	if (msm_dp_display->active_stream_cnt) {
>  		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
> @@ -1530,11 +1561,9 @@ static void msm_dp_display_unprepare(struct msm_dp=
_display_private *dp)
>  		msm_dp_display_host_phy_exit(dp);
> =20
>  	pm_runtime_put_sync(&msm_dp_display->pdev->dev);

[Severity: High]
This is a pre-existing issue, but does this call chain execute sleeping
operations from an atomic context?

The atomic_post_disable() callback executes in an atomic context where
sleeping is explicitly forbidden. However, it calls
msm_dp_display_unprepare(), which in turn calls pm_runtime_put_sync().

This synchronous put operation suspends the device via:
pm_runtime_put_sync() -> msm_dp_pm_runtime_suspend() -> disable_irq()

Since disable_irq() can sleep, this causes kernel warnings and potential
deadlocks during the atomic modeset.=20

Should this synchronous power management operation be deferred or handled
outside of the atomic disable path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D15
