Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0096CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04CA010EA1A;
	Wed, 30 Sep 2026 13:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W/Ipctzr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C65310EA1A
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:01:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E735B60008;
 Wed, 30 Sep 2026 13:01:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730061F000FF;
 Wed, 30 Sep 2026 13:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790773310;
 bh=/91u4n0Bm6ASk16TdGtgElm0IgS1QK93vgW6Nwgr+nY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W/IpctzrWw2tSW4a4r9r4ELwfkb6nRXCt3D2Q2yOdCohItVi1oP6DRNZgThtly1wD
 qfc5R9ukM0A+ZUJeb5tBX91AJUuZSHpLHt9QWSf2N0zheRWg7PmT3G81irz5WKrs+a
 qD1JAy7tnYJH+CILssdABoGmKV/w9FYlYNFb/EOA86ESuSeW8hmzGYjQv+/dBpN4kX
 P3Oh0uLI7X5Zto03eiV7jHKISbfNpQ9figZZ80m+EKDxi7yMW1tQbwxqT1gV8ATSA7
 PHqDhnwoRzTEqUI0Ty3vCO24S1GXdWxDIy7IUFQYFdzskpRAvsqjonCmsHYT/aeoFN
 xCE5DElefO3CA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] drm/msm/dp: Track output bit depth in bridge
 atomic state
To: "Xilin Wu" <sophon@radxa.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260930-msm-dp-hdr10-v1-9-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
 <20260930-msm-dp-hdr10-v1-9-dbbf8b2b42bc@radxa.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:01:49 +0000
Message-Id: <20260930130150.730061F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm/dp: Atomic semantics violation by deferring bandwidth check
--

commit 90a8ee3f0617fe6a0415caee72e5905ba2709743
Author: Xilin Wu <sophon@radxa.com>
drm/msm/dp: Track output bit depth in bridge atomic state

This commit tracks the output bit depth in the bridge atomic state to expose
max bpc on DP and eDP, and selects a supported component depth. It reads
cached capabilities under a lock and defers bandwidth checks if they are not
yet valid, rechecking the selected depth against the trained link before
enabling video.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 16c9165b5f311..f41924e75854c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -2620,6 +2621,20 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_=
dp_ctrl, struct msm_dp_panel *
> =20
>  	ctrl =3D container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_c=
trl);
> =20
> +	/* Link training may have reduced the available bandwidth. */
> +	if (!panel->video_test) {
> +		u32 clock =3D panel->msm_dp_mode.drm_mode.clock;
> +
> +		if (panel->msm_dp_mode.out_fmt_is_yuv_420)
> +			clock /=3D 2;
> +		ret =3D msm_dp_utils_select_bpp(panel->msm_dp_mode.bpp / 3, 10,
> +					      clock, ctrl->link->link_params.rate,
> +					      ctrl->link->link_params.num_lanes);
> +		if (ret < 0)
> +			return ret;

[Severity: High]
Does this error path abort the stream setup during the atomic_enable phase?

Userspace can trigger this by requesting a modeset via the atomic API with a
mode or bpp that exceeds the hardware DP link rate while the panel is off.
Because the validation was bypassed in msm_dp_display_atomic_check(),
msm_dp_ctrl_on_stream() now re-evaluates the bandwidth using the actual
trained rate.=20

If the requested mode exceeds the trained link bandwidth, this returns
-EINVAL during atomic_enable, which aborts the stream setup. Bypassing
validation in atomic_check and failing during atomic_enable violates the
fundamental guarantee of DRM atomic modesetting, which requires that
atomic_check rejects all unsupported configurations so that atomic_enable is
infallible. This can result in state desynchronization between the DRM core
and the driver, leading to a blank screen and potential vblank timeouts.

> +		panel->msm_dp_mode.bpp =3D ret;
> +	}
> +
>  	pixel_rate_orig =3D panel->msm_dp_mode.drm_mode.clock;
>  	pixel_rate =3D pixel_rate_orig;
> =20
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 9c5b1cd200f85..af6bc179723cc 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -682,6 +684,34 @@ static int msm_dp_display_set_mode(struct msm_dp *ms=
m_dp_display,
>  	return 0;
>  }
> =20
> +int msm_dp_display_atomic_check(struct msm_dp *msm_dp_display,
> +				struct msm_dp_bridge_state *state,
> +				const struct drm_display_mode *mode,
> +				const struct drm_connector_state *conn_state)
> +{
> +	const struct drm_display_info *info =3D &conn_state->connector->display=
_info;
> +	struct msm_dp_display_private *dp;
> +	unsigned int clock =3D mode->clock;
> +	int bpp;
> +
> +	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> +
> +	if (drm_mode_is_420_only(info, mode))
> +		clock /=3D 2;
> +
> +	guard(mutex)(&dp->plugged_lock);
> +
> +	bpp =3D msm_dp_utils_select_bpp(info->bpc, conn_state->max_requested_bp=
c,
> +				      clock, dp->panel->link_caps_valid ?
> +				      dp->panel->link_info.rate : 0,
> +				      dp->panel->link_info.num_lanes);

[Severity: High]
Can this defer the bandwidth check to the enable phase and violate DRM atom=
ic
semantics?

When an eDP panel is powered down and its link capabilities have not yet be=
en
probed (link_caps_valid is false), this passes 0 for the rate to
msm_dp_utils_select_bpp(). This causes the bandwidth verification to be
skipped, allowing the commit to be accepted by the kernel.

> +	if (bpp < 0)
> +		return bpp;
> +
> +	state->bpp =3D bpp;
> +	return 0;
> +}
> +
>  static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
>  {
>  	struct msm_dp *msm_dp_display =3D &dp->msm_dp_display;
> diff --git a/drivers/gpu/drm/msm/dp/dp_utils.c b/drivers/gpu/drm/msm/dp/d=
p_utils.c
> index 72bae48a1fe0b..3e49854d73fb9 100644
> --- a/drivers/gpu/drm/msm/dp/dp_utils.c
> +++ b/drivers/gpu/drm/msm/dp/dp_utils.c
[ ... ]
> @@ -89,6 +89,26 @@ void msm_dp_utils_pack_sdp_header(const struct dp_sdp_=
header *sdp_header,
>  		FIELD_PREP(PARITY_3_MASK, msm_dp_utils_calculate_parity(sdp_header->HB=
3));
>  }
> =20
> +/* A zero link rate means that a powered-down eDP panel has not been pro=
bed. */
> +int msm_dp_utils_select_bpp(unsigned int bpc, unsigned int max_bpc,
> +			    unsigned int clock, unsigned int rate,
> +			    unsigned int lanes)
> +{
> +	unsigned int bpp;
> +
> +	bpc =3D min3(bpc ? bpc : 8, max_bpc, 10U);
> +	bpc =3D round_down(bpc, 2);
> +	if (bpc < 6)
> +		return -EINVAL;
> +
> +	for (bpp =3D bpc * 3; bpp >=3D 18; bpp -=3D 6) {
> +		if (!rate || (u64)clock * bpp <=3D (u64)rate * lanes * 8)
> +			return bpp;

[Severity: High]
Does this code allow bypassing the bandwidth validation?

When rate is 0, the check automatically bypasses bandwidth validation,
returning success unconditionally.

> +	}
> +
> +	return -EINVAL;
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-msm-dp-hdr=
10-v1-0-dbbf8b2b42bc@radxa.com?part=3D9
