Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8865C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FAA110E675;
	Mon, 20 Jul 2026 05:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ASOI10vs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92F7910E675
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 05:34:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 335F64346B;
 Mon, 20 Jul 2026 05:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BE51F000E9;
 Mon, 20 Jul 2026 05:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784525641;
 bh=Rr/+gFmPMr2eLi0Xn2fJkFSIQ+dwZgvknoxrtrqGFw0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ASOI10vsjy7XOKLvQps+RQuBgJe0WNQRwn4fhej12WrufFOwFzdc6IY6UKV5cSk9I
 6RhSfAiDTwNpc2RTBd/0Zm2XObhxTbNY2Uq8gN5hwFmv9WJi4YGlgMv8VLuxqJKn+l
 j4ojm6jrtCnfCMLJsHJGnXYxXEF4DFvvxKI5oB4ham+6+yYBfvr/wCLbEKXbtQ754/
 Lf7m047OgFY6sI/ew/trbRCdbfgzxx8jxWPBVYG8VYcSDZ8eaeNYKKMDaTNyZPe1p9
 2SNFKQlKcFvugq8Xg4lwUfild+O9mV6URT9HsD2962FGgw3r+3HlgHW/GFHrqS6rVz
 UthXvKzDJljBg==
From: sashiko-bot@kernel.org
Subject: Re: [v5 02/14] drm/i915/color: Add CSC on SDR plane color pipeline
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720045131.971650-3-chaitanya.kumar.borah@intel.com>
References: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
 <20260720045131.971650-3-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 05:33:59 +0000
Message-Id: <20260720053400.E0BE51F000E9@smtp.kernel.org>
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
- [High] Missing backend implementation for exposed `INTEL_PLANE_CB_CSC_FF`=
 colorop.
- [Medium] Unreachable SDR plane color pipeline logic.
- [Medium] Validation bypass for 64-bit bitmasks on 32-bit architectures.

Pre-existing issues:
- [High] NULL pointer dereference in error cleanup path of `intel_color_pip=
eline_plane_add_colorop`.
- [High] Leaked DRM mode object ID on colorop cleanup leads to a Use-After-=
Free.
--

--- Patch [2]: [v5 02/14] drm/i915/color: Add CSC on SDR plane color pipeli=
ne ---
commit 406763c8b5fb35d6a8f9c41091f76f4b8453fc5a
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/color: Add CSC on SDR plane color pipeline
   =20
Add the fixed-function CSC block to color pipeline in SDR planes
as a DRM_COLOROP_FIXED_MATRIX colorop.

> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/driver=
s/gpu/drm/i915/display/intel_color_pipeline.c
> index 6cf8080ee8000..2ef42a133a987 100644
> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
[ ... ]
> @@ -92,6 +102,12 @@ struct intel_colorop *intel_color_pipeline_plane_add_=
colorop(struct drm_plane *p
>  							  DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
>  							  DRM_COLOROP_FLAG_ALLOW_BYPASS);
>  		break;
> +	case INTEL_PLANE_CB_CSC_FF:
> +		ret =3D drm_plane_colorop_fixed_matrix_init(dev, &colorop->base, plane,
> +							  &intel_colorop_funcs,
> +							  intel_plane_supported_csc_ff,
> +							  DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +		break;

[Severity: Medium]
Can this bypass validation for invalid upper bits on 32-bit architectures?

When calling drm_plane_colorop_fixed_matrix_init() and passing the 64-bit m=
ask
intel_plane_supported_csc_ff, the validation check uses the BIT() macro:

drivers/gpu/drm/drm_colorop.c:drm_plane_colorop_fixed_matrix_init() {
	...
	if ((supported_fm & -BIT(DRM_COLOROP_FM_COUNT)) !=3D 0) {
	...
}

Since BIT() returns an unsigned long, which is 32 bits on 32-bit
architectures, negating it produces a 32-bit mask (0xFFFFFFFx) that is
zero-extended when ANDed with the 64-bit supported_fm mask. Does this silen=
tly
ignore bits 32-63 during validation?

[Severity: High]
Does the i915 driver have the backend implementation to process this newly
exposed fixed-matrix colorop?

The INTEL_PLANE_CB_CSC_FF colorop exposes the fixed_matrix_type property to
userspace. However, looking at the parsing logic:

drivers/gpu/drm/i915/display/intel_plane.c:
intel_plane_color_copy_uapi_to_hw_state() {
	...
	blob =3D new_colorop_state->bypass ? NULL : new_colorop_state->data;
	intel_colorop =3D to_intel_colorop(colorop);
	changed |=3D intel_plane_colorop_replace_blob(plane_state,
						    intel_colorop,
						    blob);
	...
}

This appears to only handle blobs (LUTs, CTMs) and completely ignores the
fixed_matrix_type state. Could this cause the userspace configuration to be
silently discarded and never programmed to the hardware?

[Severity: High]
This isn't a bug introduced by this patch, but if
drm_plane_colorop_fixed_matrix_init() fails, will the cleanup path trigger
a NULL pointer dereference?

If initialization fails, it jumps to the cleanup label:

drivers/gpu/drm/i915/display/intel_color_pipeline.c:
intel_color_pipeline_plane_add_colorop() {
	...
cleanup:
	intel_colorop_destroy(&colorop->base);
	return ERR_PTR(ret);
}

Which then calls drm_colorop_cleanup():

drivers/gpu/drm/drm_colorop.c:drm_colorop_cleanup() {
	struct drm_device *dev =3D colorop->dev;
	struct drm_mode_config *config =3D &dev->mode_config;

	list_del(&colorop->head);
	...
}

If the failure happens early in initialization before colorop->dev or
colorop->head are set, dev will be NULL and this will crash.

[Severity: High]
This is a pre-existing issue, but does drm_colorop_cleanup() leak the DRM
mode object ID?

When drm_plane_colorop_init() executes successfully, it allocates an ID in =
the
DRM device's IDR by calling drm_mode_object_add(). However,
drm_colorop_cleanup() appears to be missing a call to
drm_mode_object_unregister(dev, &colorop->base).

Does this mean the ID remains allocated forever, potentially leading to a
use-after-free if userspace later queries the leaked ID after the memory is
freed?

>  	default:
>  		drm_err(plane->dev, "Invalid colorop id [%d]", id);
>  		ret =3D -EINVAL;
> @@ -126,9 +142,12 @@ int _intel_color_pipeline_plane_init(struct drm_plan=
e *plane, struct drm_prop_en
>  	if (plane_has_3dlut(display, pipe, plane)) {
>  		pipeline =3D xe3plpd_primary_plane_pipeline;
>  		pipeline_len =3D ARRAY_SIZE(xe3plpd_primary_plane_pipeline);
> -	} else {
> +	} else if (icl_is_hdr_plane(display, to_intel_plane(plane)->id)) {
>  		pipeline =3D hdr_plane_pipeline;
>  		pipeline_len =3D ARRAY_SIZE(hdr_plane_pipeline);
> +	} else {
> +		pipeline =3D sdr_plane_pipeline;
> +		pipeline_len =3D ARRAY_SIZE(sdr_plane_pipeline);
>  	}

[Severity: Medium]
Will this else branch ever be executed for SDR planes?

Looking at the caller, intel_color_pipeline_plane_init(), there is an expli=
cit
early return for non-HDR planes:

drivers/gpu/drm/i915/display/intel_color_pipeline.c:
intel_color_pipeline_plane_init() {
	...
	/* Currently expose pipeline only for HDR planes */
	if (!icl_is_hdr_plane(display, to_intel_plane(plane)->id))
		return 0;
	...
}

It seems this prevents the newly added SDR logic from ever being reached.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720045131.9716=
50-1-chaitanya.kumar.borah@intel.com?part=3D2
