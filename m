Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E392C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E1910E66C;
	Mon, 20 Jul 2026 05:28:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gjoPxciB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A58F610E66C
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:28:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26D9660103;
 Mon, 20 Jul 2026 05:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B12B71F000E9;
 Mon, 20 Jul 2026 05:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784525336;
 bh=JTIjICLCLC8e8xqcYxkrE/9DtAeeLk80aSOLnvJuit8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gjoPxciBhEFJ/atRIf8ygJU4DP2ZX+Ubn7F+0RrXyAqX5I8F0bVVpnA9F/oWSdpFa
 vls4cpzHGQ1Z1ddSg0XXRTiyTh8NMqEBv4c2ORixMBV1V3Ch2Daf2Jrxi1fPW3pPp6
 +KxjfBOUoM3SAmkcPvNrXMG+c3LgtzBhzjymqAd3SDr7eX+aSt0dj1H9Mydx9ygaXV
 AK0x6mcKkpz7UGEu90wHrFaU71am4Gu01k6hU5iVr0kJ0mvtVRms+0rZxNuPsL0AtD
 OzyAEcUMOD+xzryhAhR5/OV+ewguB/ylbStyu/6xeqhxi+vIeiOodZ8UgT6flC/p4N
 1fB21putRv5nw==
From: sashiko-bot@kernel.org
Subject: Re: [v5 07/14] drm/i915/color: Add YCbCr limited-to-full range
 color block support
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720045131.971650-8-chaitanya.kumar.borah@intel.com>
References: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
 <20260720045131.971650-8-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 05:28:56 +0000
Message-Id: <20260720052856.B12B71F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] YUV range correction is incorrectly enabled by default for all col=
or pipelines, corrupting both RGB and YUV surfaces.
- [Medium] The INTEL_PLANE_CB_YUV_RANGE_CORRECT color block is never added =
to the plane color pipeline arrays, making the feature unreachable.

Pre-existing issues:
- [Critical] Use-After-Free via leaked DRM IDR pointer during colorop clean=
up.
- [High] NULL Pointer Dereference on colorop initialization error path.
--

--- Patch [7]: [v5 07/14] drm/i915/color: Add YCbCr limited-to-full range c=
olor block support ---
commit 63b36f46939531b2add35ef940340e77707f342a
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/color: Add YCbCr limited-to-full range color block support

Add support for color block which performs YCbCr limited-to-full
range expansion in the plane color pipeline. The color block is
represented using DRM_COLOROP_FIXED_MATRIX colorop.

> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/driver=
s/gpu/drm/i915/display/intel_color_pipeline.c
> index 2ef42a133a987..7d25f4fbfa9b7 100644
> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> @@ -108,6 +108,12 @@ struct intel_colorop *intel_color_pipeline_plane_add=
_colorop(struct drm_plane *p
>  							  intel_plane_supported_csc_ff,
>  							  DRM_COLOROP_FLAG_ALLOW_BYPASS);
>  		break;
> +	case INTEL_PLANE_CB_YUV_RANGE_CORRECT:
> +		ret =3D drm_plane_colorop_fixed_matrix_init(dev, &colorop->base, plane,
> +							  &intel_colorop_funcs,
> +							  BIT(DRM_COLOROP_FM_YCBCR_LIMITED_FULL),
> +							  DRM_COLOROP_FLAG_ALLOW_BYPASS);

[Severity: Medium]
Is INTEL_PLANE_CB_YUV_RANGE_CORRECT actually reachable? It appears this col=
or
block is omitted from the pipeline definition arrays like sdr_plane_pipelin=
e,
which means it will never be added to the pipeline.

[Severity: High]
This is a pre-existing issue, but does drm_colorop_cleanup() dereference a
NULL pointer if drm_plane_colorop_fixed_matrix_init() fails?

If drm_mode_object_add() fails during initialization, it returns an error
before colorop->dev is set. The cleanup path calls drm_colorop_cleanup(),
which unconditionally dereferences colorop->dev:

void drm_colorop_cleanup(struct drm_colorop *colorop)
{
	struct drm_device *dev =3D colorop->dev;
	struct drm_mode_config *config =3D &dev->mode_config;

This would result in a crash during device probe.

[Severity: Critical]
This is also a pre-existing issue, but does drm_colorop_cleanup() leak the
DRM IDR pointer?

drm_plane_colorop_fixed_matrix_init() registers the colorop with the DRM IDR
via drm_mode_object_add(). However, drm_colorop_cleanup() fails to call
drm_mode_object_unregister(), leaving a dangling pointer in the IDR:

void drm_colorop_cleanup(struct drm_colorop *colorop)
{
    ...
	list_del(&colorop->head);
	config->num_colorop--;

	if (colorop->state)
		drm_colorop_atomic_destroy_state(colorop, colorop->state);
}

Could this lead to a Use-After-Free if userspace invokes DRM IOCTLs (like
DRM_IOCTL_MODE_OBJ_GETPROPERTIES) using the leaked ID?

> +		break;
>  	default:
>  		drm_err(plane->dev, "Invalid colorop id [%d]", id);
>  		ret =3D -EINVAL;

[ ... ]

> diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers=
/gpu/drm/i915/display/skl_universal_plane.c
> index 9893b061da5fa..88df4a76a0ab8 100644
> --- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
> +++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
> @@ -1295,6 +1295,8 @@ static u32 glk_plane_color_ctl_input_csc(const stru=
ct intel_plane_state *plane_s
>  	} else if (!icl_is_hdr_plane(display, plane->id)) {
>  		if (plane_state->hw.csc_ff_enable)
>  			ctl |=3D intel_csc_ff_type_to_csc_mode(plane_state->hw.csc_ff_type);
> +		if (plane_state->hw.yuv_range_correction_disable)
> +			ctl |=3D PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;

[Severity: High]
Does this logic inadvertently enable YUV range correction by default for all
color pipelines, corrupting RGB and YUV surfaces?

When a color pipeline is active, the early return for non-YUV surfaces is
skipped in glk_plane_color_ctl_input_csc():

    if (!fb->format->is_yuv)
        return 0;

Since INTEL_PLANE_CB_YUV_RANGE_CORRECT is missing from the pipeline array,
yuv_range_correction_disable defaults to false. This leaves the
PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE bit unset (meaning enabled).

Furthermore, HDR planes skip this bit assignment entirely due to the
!icl_is_hdr_plane() check, meaning range correction is unconditionally enab=
led
for them as well.

>  	}
> =20
>  	return ctl;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720045131.9716=
50-1-chaitanya.kumar.borah@intel.com?part=3D7
