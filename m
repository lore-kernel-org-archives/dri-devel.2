Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BCEC55822
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 13:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6197710EA4B;
	Tue,  4 Aug 2026 13:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XYsq0M5f";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E3D10EA4B
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 13:11:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0803C44FC9;
 Tue,  4 Aug 2026 13:11:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A87C1F00A3D;
 Tue,  4 Aug 2026 13:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785849080;
 bh=NQUUFWXQvsS96g0h3+XRjEVbqotkblBQHUYLJT2bMFU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XYsq0M5fbBbfGUuPj42z9fNV+nxzGuhNH30ZzEkIOpHrqK+iUcBXZpuoTtXCR3ly6
 KiUTck8kEdEPjoo42pIVao4Z8EQ13NQJX8tSwLgJaON3Z/fw6+N5Jawr+g/yhCx1AW
 5glN0Kj0gnP45iItOMyJlUEinnDS4lEofwQEauu9w/m18W0S6PJ8hkPza/YM+rhD9b
 UOSJ+Lqat9vEdPsT4uBRNxBlj4aVRNfkLFHAj8B5MFlqT5ABbBUp2w3MCEPl3DaD4W
 ZRL+p7FYbnKDq1uaeIZSreu+3PZDPDzux08l3UgajMTiAZwXlqiR1CF3LTige3THmL
 CHFV3oUGoJYEQ==
From: sashiko-bot@kernel.org
Subject: Re: [v6 2/9] drm/i915/color: Add CSC on SDR plane color pipeline
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260804123107.2256124-3-chaitanya.kumar.borah@intel.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
 <20260804123107.2256124-3-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 13:11:19 +0000
Message-Id: <20260804131120.3A87C1F00A3D@smtp.kernel.org>
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
- [Medium] The newly added SDR color pipeline is entirely unreachable becau=
se its initialization is blocked by an early return guard for non-HDR plane=
s.
- [Low] Validating a 64-bit mask (`supported_fm`) using `-BIT()` causes int=
eger truncation on 32-bit platforms, failing to check the upper 32 bits of =
the bitmask.

Pre-existing issues:
- [High] Error handling in `intel_color_pipeline_plane_add_colorop()` trigg=
ers multiple NULL pointer dereferences when tearing down partially initiali=
zed colorops.
- [High] Missing `drm_mode_object_unregister()` in `drm_colorop_cleanup()` =
causes IDR leaks and potential Use-After-Free of drm_colorop objects.
--

--- Patch [2]: [v6 2/9] drm/i915/color: Add CSC on SDR plane color pipeline=
 ---
commit 8f7cf1094859b74b7d23e60a46f2012f047db34f
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: drm/i915/color: Add CSC on SDR plane color pipeline

This commit adds the fixed-function CSC block to the color pipeline in SDR
planes as a DRM_COLOROP_FIXED_MATRIX colorop.

> diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/driver=
s/gpu/drm/i915/display/intel_color_pipeline.c
> --- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
> +++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c

[ ... ]

> @@ -92,6 +104,12 @@ struct intel_colorop *intel_color_pipeline_plane_add_=
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

[Severity: Low]
Does this call expose a truncation bug on 32-bit platforms?

Looking at drm_plane_colorop_fixed_matrix_init() in drm_colorop.c:

drm_colorop.c:drm_plane_colorop_fixed_matrix_init() {
    ...
    if ((supported_fm & -BIT(DRM_COLOROP_FM_COUNT)) !=3D 0) {
        drm_err(dev, "Unknown Fixed Matrix provided...\n");
        return -EINVAL;
    }
    ...
}

Since BIT() uses UL, on 32-bit systems -BIT() evaluates as an unsigned
32-bit value. When promoted to 64-bit to evaluate against supported_fm,
it zero-extends. This means the upper 32 bits are not checked properly,
which could silently allow invalid caller configurations where bits >=3D 32
are set.

[Severity: High]
This is a pre-existing issue, but does this error path cause a NULL pointer
dereference?

If drm_plane_colorop_fixed_matrix_init() fails and returns an error before
setting colorop->dev, we jump to the cleanup label in
intel_color_pipeline_plane_add_colorop():

intel_color_pipeline.c:intel_color_pipeline_plane_add_colorop() {
    ...
cleanup:
    intel_colorop_destroy(&colorop->base);
    return ERR_PTR(ret);
}

This calls drm_colorop_cleanup(), which unconditionally dereferences
colorop->dev:

drm_colorop.c:drm_colorop_cleanup() {
    struct drm_device *dev =3D colorop->dev;
    struct drm_mode_config *config =3D &dev->mode_config;
   =20
    list_del(&colorop->head);
    config->num_colorop--;
    ...
}

Since dev is not set yet, dev->mode_config will crash, and list_del() will
operate on a zero-initialized list head.

[Severity: High]
This is a pre-existing issue, but does drm_colorop_cleanup() leak the
mode object ID?

If a colorop init function successfully adds the mode object to the IDR via
drm_mode_object_add() but fails later, it calls drm_colorop_cleanup().

Since drm_colorop_cleanup() does not call drm_mode_object_unregister(), the
object ID remains in the DRM device's IDR. When the colorop memory is freed,
this leaves a dangling pointer in the IDR, which could lead to a Use-After-=
Free
if userspace queries it via DRM_IOCTL_MODE_OBJ_GETPROPERTIES.

[ ... ]

> @@ -126,9 +144,12 @@ int _intel_color_pipeline_plane_init(struct drm_plan=
e *plane, struct drm_prop_en
>  	if (plane_has_3dlut(display, pipe, plane)) {
>  		pipeline =3D xe3plpd_primary_plane_pipeline;
>  		pipeline_len =3D ARRAY_SIZE(xe3plpd_primary_plane_pipeline);
> -	} else {
> +	} else if (icl_is_hdr_plane(display, to_intel_plane(plane)->id)) {
>  		pipeline =3D hdr_plane_pipeline;
>  		pipeline_len =3D ARRAY_SIZE(hdr_plane_pipeline);
> +	} else {
> +		pipeline =3D sdr_plane_yuv_pipeline;
> +		pipeline_len =3D ARRAY_SIZE(sdr_plane_yuv_pipeline);
>  	}

[Severity: Medium]
Is this newly added SDR pipeline logic reachable?

Any initialization of an SDR plane calls intel_color_pipeline_plane_init(),
which appears to have an early return guard for non-HDR planes before it
calls _intel_color_pipeline_plane_init():

intel_color_pipeline.c:intel_color_pipeline_plane_init() {
    ...
    /* Currently expose pipeline only for HDR planes */
    if (!icl_is_hdr_plane(display, to_intel_plane(plane)->id))
        return 0;

    return _intel_color_pipeline_plane_init(plane, list, pipe);
}

Because of this check, _intel_color_pipeline_plane_init() will never be
reached for an SDR plane, making the new sdr_plane_yuv_pipeline dead code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804123107.2256=
124-1-chaitanya.kumar.borah@intel.com?part=3D2
