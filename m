Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE55C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:01:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE3710E78D;
	Mon, 13 Jul 2026 06:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="niO0+JEW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E044C10E78D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 06:01:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9AF69413DE;
 Mon, 13 Jul 2026 06:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4F41F000E9;
 Mon, 13 Jul 2026 06:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783922515;
 bh=Ph6UNXsI8LGg+04rtyMQaWe8G80X8pg95mFF6TQatgQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=niO0+JEWJlmE9yuhzP7c9Kxwxqm8kHrLXrFggropgz1Yg5/Ws3ved1Q6bxR93iBEz
 6waqP5DdqwOjboucPGBLMxoqEFBIHyfsXmXHY1k8B2wDD/t1bbgrtcHnbvtD9V49kn
 mfhb4IY14197llk2WAb4ktkEcK9BM/YTi7vEJ6tw+VjYRIoBQpbz5kQUDDnMaP9pqJ
 Lsky/DgDWYkf6iobGxxm2npyPDhm+CdotJWY+KWlLznvveC5nvTto8JNpLZfYqqSQh
 8YrBaSlD0BQWczWxiZuPPRa3Fmanqj3ZmeVkVF4Q7/aI/Z4ljLYjZGTmRObok2gH3/
 dXfEQvryhCfQQ==
From: sashiko-bot@kernel.org
Subject: Re: [CI v4 06/14] drm/i915/display: Program input CSC on SDR planes
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713051516.4087420-7-chaitanya.kumar.borah@intel.com>
References: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
 <20260713051516.4087420-7-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 06:01:54 +0000
Message-Id: <20260713060155.5D4F41F000E9@smtp.kernel.org>
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
- [High] Hardware YUV-to-RGB conversion (Input CSC) is incorrectly disabled=
 for HDR planes when a color pipeline is active.
- [Medium] For SDR planes, when a color pipeline is active, the driver fail=
s to set the PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE bit for full-range YC=
bCr-to-RGB matrix conversions.
--

--- Patch [6]: [CI v4 06/14] drm/i915/display: Program input CSC on SDR pla=
nes ---
commit 840c01156b413fde2fac882f08e842c50840876f
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: drm/i915/display: Program input CSC on SDR planes

This commit programs the SDR plane fixed-function CSC when a color pipeline
is active. It also ensures the legacy color_encoding/color_range properties
remain mutually exclusive with the color pipeline uAPI.

> diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers=
/gpu/drm/i915/display/skl_universal_plane.c
> index da2df5be9848d..0e951b36cccad 100644
> --- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
> +++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
[ ... ]
> @@ -1240,33 +1240,63 @@ static u32 glk_plane_color_ctl_crtc(const struct =
intel_crtc_state *crtc_state)
[ ... ]
>  static u32 glk_plane_color_ctl_input_csc(const struct intel_plane_state =
*plane_state)
>  {
>  	struct intel_display *display =3D to_intel_display(plane_state);
>  	const struct drm_framebuffer *fb =3D plane_state->hw.fb;
>  	struct intel_plane *plane =3D to_intel_plane(plane_state->uapi.plane);
> +	bool color_pipeline =3D plane_state->uapi.state &&
> +		plane_state->uapi.state->plane_color_pipeline;
>  	u32 ctl =3D 0;
> =20
> -	if (!fb->format->is_yuv)
> -		return 0;
> +	if (!color_pipeline) {
> +		if (!fb->format->is_yuv)
> +			return 0;
> =20
> -	if (!icl_is_hdr_plane(display, plane->id)) {
> -		switch (plane_state->hw.color_encoding) {
> -		case DRM_COLOR_YCBCR_BT709:
> -			ctl |=3D PLANE_COLOR_CSC_MODE_YUV709_TO_RGB709;
> -			break;
> -		case DRM_COLOR_YCBCR_BT2020:
> -			ctl |=3D PLANE_COLOR_CSC_MODE_YUV2020_TO_RGB2020;
> -			break;
> -		default:
> -			ctl |=3D PLANE_COLOR_CSC_MODE_YUV601_TO_RGB601;
> +		if (!icl_is_hdr_plane(display, plane->id)) {
> +			switch (plane_state->hw.color_encoding) {
[ ... ]
> +			default:
> +				ctl |=3D PLANE_COLOR_CSC_MODE_YUV601_TO_RGB601;
> +			}
> +		} else {
> +			ctl |=3D PLANE_COLOR_INPUT_CSC_ENABLE;
>  		}
> -	} else {
> -		ctl |=3D PLANE_COLOR_INPUT_CSC_ENABLE;
> -	}
> =20
> -	if (plane_state->hw.color_range =3D=3D DRM_COLOR_YCBCR_FULL_RANGE)
> -		ctl |=3D PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
> +		if (plane_state->hw.color_range =3D=3D DRM_COLOR_YCBCR_FULL_RANGE)
> +			ctl |=3D PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;

[Severity: High]
Does this logic inadvertently disable hardware YUV-to-RGB conversion for HDR
planes when a color pipeline is active?

When color_pipeline is true for an HDR plane, the logic in
glk_plane_color_ctl_input_csc() skips the (!color_pipeline) branch entirely.
However, the else-if block below only handles SDR planes, which causes the
function to return 0 and fail to set the PLANE_COLOR_INPUT_CSC_ENABLE bit
for HDR planes.

Since the hardware coefficients might still be programmed in
icl_plane_update_noarm():

	if (fb->format->is_yuv && icl_is_hdr_plane(display, plane_id))
		icl_program_input_csc(dsb, plane, plane_state);

Could this allow raw YUV data to flow directly into the RGB pipeline without
conversion, causing visual corruption when a YUV framebuffer is assigned to
an HDR plane?

> +	} else if (!icl_is_hdr_plane(display, plane->id)) {
> +		if (plane_state->hw.csc_ff_enable)
> +			ctl |=3D intel_csc_ff_type_to_csc_mode(plane_state->hw.csc_ff_type);

[Severity: Medium]
For SDR planes with an active color pipeline, does this miss setting the
PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE bit for full-range YCbCr-to-RGB
conversions?

If full-range YCbCr input is processed without this bit, would the hardware=
's
default limited-to-full range correction be applied before the full-range
matrix, causing color distortion?

Even if this path is currently unreachable in practice because the color
pipeline property isn't exposed on SDR planes, should the disable bit still
be explicitly set when appropriate to prevent future issues?

> +	}
> =20
>  	return ctl;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713051516.4087=
420-1-chaitanya.kumar.borah@intel.com?part=3D6
