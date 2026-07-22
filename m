Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB093C4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0149B10EC85;
	Wed, 22 Jul 2026 07:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cHMjB+e+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69D910EC85
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:04:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B24760A64;
 Wed, 22 Jul 2026 07:04:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87281F000E9;
 Wed, 22 Jul 2026 07:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784703839;
 bh=mi6FNoadZeC/8dg36kcPRzE27I/+1Lwdqs03CJNKve8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cHMjB+e+X1Xz+fVlAOA/ZkHcWPvWn7CcgaqWQO/kXnQWxZLhWuv2VFG0xGdaXDs6c
 T5Oc/UwXIKLjj802PdST75MAlUPqP6Q7wLVlCxfmE79UKPT4Akrkoq7nZZVRm/bbyU
 GtQF9xq/g7iHgJaiSKIGHy9gdKuyUructV/XKYv+s7kofwksfayND3PQ3ItYsS3ToA
 PQCJUno+YBvN+LusSO8N5xmh5pHgerFzJD7Adj4xVI098Yme00425amkcQHdWb1ebs
 G0x0OkzDza+RkRADugCH54OARM3+kwcQDgV4PlQI8zF19n85ERp3whTf3hnu6XJDJO
 36qN7Og3YrfPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/24] drm/msm/dp: do not reject wide-bus modes while a
 YUV420 mode is active
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-drm-msm-display-interface-v1-15-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
 <20260722-drm-msm-display-interface-v1-15-368c10fe62fd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:03:59 +0000
Message-Id: <20260722070359.B87281F000E9@smtp.kernel.org>
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
- [High] The state-dependent mode validation bug fixed in `msm_dp_bridge_mo=
de_valid` was missed in its eDP counterpart `msm_edp_bridge_mode_valid`.
- [High] Halving `mode_pclk_khz` for RGB wide-bus modes causes the DP link =
bandwidth requirement to be incorrectly evaluated as 50% of its true value,=
 allowing invalid modes to pass validation.
--

--- Patch [15]: [PATCH 15/24] drm/msm/dp: do not reject wide-bus modes whil=
e a YUV420 mode is active ---
commit 6dbb162c934d82f2d73ac5d225ee02599200aeac
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: drm/msm/dp: do not reject wide-bus modes while a YUV420 mode is ac=
tive

This commit fixes a bug in msm_dp_bridge_mode_valid() where candidate modes
requiring wide bus to stay under DP_MAX_PIXEL_CLK_KHZ were wrongly rejected
if the currently active mode used YUV 420 output. It replaces the
state-dependent msm_dp_wide_bus_available() check with a direct check of
wide_bus_supported.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -722,7 +722,7 @@ enum drm_mode_status msm_dp_bridge_mode_valid(struct =
drm_bridge *bridge,
>  	if (is_yuv_420 && !msm_dp_display->panel->vsc_sdp_supported)
>  		return MODE_NO_420;
> =20
> -	if (is_yuv_420 || msm_dp_wide_bus_available(dp))
> +	if (is_yuv_420 || msm_dp_display->wide_bus_supported)
>  		mode_pclk_khz /=3D 2;

[Severity: High]
This isn't a bug introduced by this patch, but should the same fix be
applied to the eDP counterpart?

Looking at msm_edp_bridge_mode_valid() in drivers/gpu/drm/msm/dp/dp_drm.c:

	if (msm_dp_wide_bus_available(dp))
		mode_pclk_khz /=3D 2;

Since eDP bridges also have ycbcr_420_allowed =3D true, could an eDP=20
sink enter a YUV 420 mode and cause subsequent candidate eDP modes requirin=
g=20
wide bus to be incorrectly rejected?

[Severity: High]
This is a pre-existing issue, but does halving mode_pclk_khz here corrupt=20
the link bandwidth validation further down in this function?

After mode_pclk_khz is halved, it is used to calculate mode_rate_khz:

	mode_bpp =3D msm_dp_panel_get_mode_bpp(msm_dp_display->panel,
			mode_bpp, mode_pclk_khz);

	mode_rate_khz =3D mode_pclk_khz * mode_bpp;
	supported_rate_khz =3D link_info->num_lanes * link_info->rate * 8;

	if (mode_rate_khz > supported_rate_khz)
		return MODE_BAD;

Since the physical DP serial link over the cable does not compress RGB data,
doesn't the physical link still need to transmit the full clock rate? Does=
=20
calculating mode_rate_khz with the halved clock allow modes to pass that=20
exceed the physical DP lanes' capacity?

> =20
>  	if (mode_pclk_khz > DP_MAX_PIXEL_CLK_KHZ)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-drm-msm-di=
splay-interface-v1-0-368c10fe62fd@oss.qualcomm.com?part=3D15
