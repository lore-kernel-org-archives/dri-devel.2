Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB48C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD4310E562;
	Mon, 13 Jul 2026 05:55:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XrnAmor/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 088D510E562
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:55:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 80FF943798;
 Mon, 13 Jul 2026 05:55:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 398B01F000E9;
 Mon, 13 Jul 2026 05:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783922102;
 bh=+oizzyTtDxu1LCssAAVEdQihxqrssO66jfTJHNW5I7A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XrnAmor/+sRLzPj2ctgNnqQs+2vaFuRZ59ccj2NscupnjRXAIpBhSFw2xQ7PMlNv4
 nzxN7vGc0c7FYIkQ78ox+VJxACkV4jfaYxY1xg4DPYL0vkP9yvYE9riu4/FsqhFCTM
 5YHyXnsANCXbg+inSDW6M5zjTnNBHgmkOBrv62g+FkqrbOaTztca0TPmmST6X0K+/h
 MWpxo0BCyeMxPtbBPTcvvaYQeFV2nC0DMG5LTbbi/AzTAWqnwEdYWcGi1xG08cY1ne
 dLmRG/Uv3qu5wfQ69oN4XAE6z3xj6rGXpoSWg05QKE4W6MjfmGMbrUwQnjCNCCnaW+
 k9zPTDJtaqNRg==
From: sashiko-bot@kernel.org
Subject: Re: [CI v4 07/14] drm/i915/color: Add YCbCr limited-to-full range
 color block support
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713051516.4087420-8-chaitanya.kumar.borah@intel.com>
References: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
 <20260713051516.4087420-8-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 05:55:01 +0000
Message-Id: <20260713055502.398B01F000E9@smtp.kernel.org>
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
- [Medium] Hardware state for YUV range correction is incorrectly restricte=
d to SDR planes when a color pipeline is active, preventing HDR planes from=
 bypassing range correction.
- [Low] The new YUV range correction color block (INTEL_PLANE_CB_YUV_RANGE_=
CORRECT) is never added to any plane's color pipeline, making the feature u=
nreachable.

Pre-existing issues:
- [High] Error paths in colorop initialization lead to a kernel panic becau=
se they unconditionally clean up partially initialized colorop objects.
- [High] Missing `drm_mode_object_unregister()` in the colorop teardown seq=
uence leaks modeset IDR identifiers, resulting in a Use-After-Free.
--

--- Patch [7]: [CI v4 07/14] drm/i915/color: Add YCbCr limited-to-full rang=
e color block support ---
commit 0f5fc4ef9d6c7498eb8e7e7dcd0a849594fe9377
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: drm/i915/color: Add YCbCr limited-to-full range color block support

This patch adds support for a color block that performs YCbCr limited-to-fu=
ll
range expansion in the plane color pipeline. It represents this new color
block using the DRM_COLOROP_FIXED_MATRIX colorop.

> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/driver=
s/gpu/drm/i915/display/intel_color_pipeline.c
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
> +		break;

[Severity: Low]
Is this new color block missing from the pipeline definition arrays?

It appears INTEL_PLANE_CB_YUV_RANGE_CORRECT is defined and its configuration
is implemented, but it is never added to the static pipeline definition arr=
ays
like sdr_plane_pipeline.=20

Without being appended to the arrays that dictate pipeline construction, do=
es
this feature remain uninstantiated and unreachable by userspace?

[Severity: High]
This isn't a bug introduced by this patch, but can the error path here lead=
 to
a kernel panic?

If drm_plane_colorop_fixed_matrix_init() fails, colorop->dev remains
uninitialized. The error path jumps to the cleanup label and calls
intel_colorop_destroy(), which then calls drm_colorop_cleanup():

drm_colorop_cleanup()
    struct drm_device *dev =3D colorop->dev;
    struct drm_mode_config *config =3D &dev->mode_config;
    list_del(&colorop->head);

Since dev is NULL, will this blindly dereference a zero-initialized structu=
re
and oops on the driver probe error path?

[Severity: High]
This is a pre-existing issue, but does the colorop teardown sequence leak
modeset IDR identifiers and cause a Use-After-Free?

When drm_plane_colorop_init() is called, it generates an ID for the
colorop->base pointer via drm_mode_object_add().

During teardown, drm_colorop_cleanup() is called but it omits the
drm_mode_object_unregister() call. Then, intel_colorop_destroy() frees the
memory:

intel_colorop_destroy()
    drm_colorop_cleanup(colorop);
    kfree(to_intel_colorop(colorop));

Does this leave a dangling pointer in the modeset IDR, where a subsequent
userspace lookup of the object ID would fetch and use freed memory?

[ ... ]
> diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers=
/gpu/drm/i915/display/skl_universal_plane.c
> --- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
> +++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
> @@ -1296,6 +1296,8 @@ static u32 glk_plane_color_ctl_input_csc(const stru=
ct intel_plane_state *plane_s
>  	} else if (!icl_is_hdr_plane(display, plane->id)) {
>  		if (plane_state->hw.csc_ff_enable)
>  			ctl |=3D intel_csc_ff_type_to_csc_mode(plane_state->hw.csc_ff_type);
> +		if (plane_state->hw.yuv_range_correction_disable)
> +			ctl |=3D PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
>  	}
> =20
>  	return ctl;

[Severity: Medium]
Does this restrict the YUV range correction bypass to SDR planes only?

The new check for hw.yuv_range_correction_disable is placed strictly inside
the else if (!icl_is_hdr_plane()) block. This seems to force range correcti=
on
on for HDR planes when a color pipeline is active, bypassing the disable fl=
ag
completely.

Should this check be moved outside the SDR-only restriction to match the le=
gacy
path which correctly applies the bypass to both?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713051516.4087=
420-1-chaitanya.kumar.borah@intel.com?part=3D7
