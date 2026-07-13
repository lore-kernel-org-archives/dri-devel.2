Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212A0C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:56:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E91710E798;
	Mon, 13 Jul 2026 05:56:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kmD3UfUF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6805210E798
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:56:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA82560018;
 Mon, 13 Jul 2026 05:56:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 539841F000E9;
 Mon, 13 Jul 2026 05:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783922200;
 bh=3HJE2JsRdWeAikyGnWo/DxOadR3s/51a0NfFKY9QXPY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kmD3UfUFHFP6h8/emq3iGJliRgBMjiTEnsBjcDfX0LDqNS20rT0KZ4bKrfbqwfUex
 LkXsjGqsQ55Wub3Kp1jZZukyGAzv9s/BYf8H9V8+g1TnieRAzYVuIpfuMk+ZyX3Qou
 57UteTTVuX6NsKjNxKI9ip0KUE5u89+wVUtky+qryzMYCuNmjEf0FFeIrCCkQUmKxs
 Bnakwx33i178NuI4ujTr0JGRvbMaN45q2zRgI+ONQovBpG8ZNrzozUV+w8KHVOajHI
 HSfYZjcLv+Bn2JzBPEsfhzSvR3FHV4/Kc4WWfq2Bcb4W6jlmSpF2VhuSHS04c/Vb+t
 iIRzK0Bb2u8Jg==
From: sashiko-bot@kernel.org
Subject: Re: [CI v4 09/14] drm/i915/color: Add support for 1D LUT in SDR planes
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713051516.4087420-10-chaitanya.kumar.borah@intel.com>
References: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
 <20260713051516.4087420-10-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 05:56:40 +0000
Message-Id: <20260713055640.539841F000E9@smtp.kernel.org>
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
- [High] NULL pointer dereference and list corruption when tearing down a p=
artially initialized colorop.
- [High] Missing `drm_mode_object_unregister()` in `drm_colorop_cleanup()` =
leaks IDR entries and causes Use-After-Free.
--

--- Patch [9]: [CI v4 09/14] drm/i915/color: Add support for 1D LUT in SDR =
planes ---
commit 774f8cae80cb667cc0804c605f7a0135e70d21fa
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/color: Add support for 1D LUT in SDR planes

Extend the SDR plane color pipeline to include pre- and post-CSC
1D LUT blocks.

SDR planes use a smaller LUT size than HDR planes and therefore
initialize the 1D LUT colorops with the appropriate hardware
capacity.

> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/driver=
s/gpu/drm/i915/display/intel_color_pipeline.c
> index 7457fa51cb97a..136b9378ca484 100644
> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
[ ... ]
> @@ -81,7 +86,9 @@ struct intel_colorop *intel_color_pipeline_plane_add_co=
lorop(struct drm_plane *p
>  		ret =3D drm_plane_colorop_curve_1d_lut_init(dev,
>  							  &colorop->base, plane,
>  							  &intel_colorop_funcs,
> -							  PLANE_DEGAMMA_SIZE,
> +							  is_hdr ?
> +							  PLANE_DEGAMMA_SIZE :
> +							  PLANE_DEGAMMA_SIZE_SDR,
>  							  DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
>  							  DRM_COLOROP_FLAG_ALLOW_BYPASS);
>  		break;

[Severity: High]
This is a pre-existing issue, but can the error path for this initialization
lead to a null pointer dereference?

If drm_plane_colorop_curve_1d_lut_init() fails early (for example, if memory
allocation in drm_mode_object_add() fails), colorop->dev remains null and t=
he
object is never added to the list.

The error path in this function unconditionally goes to cleanup and calls
intel_colorop_destroy(), which eventually calls drm_colorop_cleanup():

drivers/gpu/drm/drm_colorop.c:drm_colorop_cleanup() {
	struct drm_device *dev =3D colorop->dev;
	struct drm_mode_config *config =3D &dev->mode_config;

	list_del(&colorop->head);
	...
}

Will this dereference the null colorop->dev and corrupt the list by calling
list_del() on an uninitialized list head?


[Severity: High]
This is another pre-existing issue, but does the cleanup path leave a dangl=
ing
pointer in the DRM mode object IDR?

If drm_plane_colorop_curve_1d_lut_init() successfully adds the colorop to t=
he
device's mode object IDR via drm_mode_object_add(), but a subsequent proper=
ty
creation fails (like drm_property_create_enum()), the cleanup path is
triggered.

The error path calls drm_colorop_cleanup() and subsequently frees the color=
op
object. However, drm_colorop_cleanup() does not seem to call
drm_mode_object_unregister():

drivers/gpu/drm/drm_colorop.c:drm_colorop_cleanup() {
	struct drm_device *dev =3D colorop->dev;
	struct drm_mode_config *config =3D &dev->mode_config;

	list_del(&colorop->head);
	config->num_colorop--;

	if (colorop->state)
		drm_colorop_atomic_destroy_state(colorop, colorop->state);
}

Could this result in a use-after-free if the IDR continues to hold a pointer
to the freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713051516.4087=
420-1-chaitanya.kumar.borah@intel.com?part=3D9
