Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C186C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9139F10E78C;
	Mon, 13 Jul 2026 06:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EA33/WV+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172CA10E78C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 06:01:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5288A6004E;
 Mon, 13 Jul 2026 06:01:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36111F000E9;
 Mon, 13 Jul 2026 06:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783922504;
 bh=FLntpqDtzcAN/onUBp6tpIq3YtBawT7fMBONtCKQd+0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EA33/WV+DdDi2GenBdYd31D3i4ajWw+9dQ4J+ofuDuwEgxb5JlzvhQnqa4kC1GsHv
 YdZzdD2hfT9D1VFeJSNGfBu2H5c4dTburCfMFuGVNUzHY0plaAg0W+SUO1oLLVgFjF
 9AJGtHoKvuf4KyYDEz84jkB6roEKU4s9mEbslZN+EmIaMOifaroviDSw+JbfQqJw/i
 d7kHtYFFdAJOtmsR92lIRQ7U+FK/r4X7/ZBDHSfMb8wA56KvaP8iISS7+exsXpuaYl
 gI/T14v21xT93W4rPbpzto7NXtqnK9jagXwp5e7pPUTWsVLv8YQijm87NXmRky+Lx3
 Hj3qBBHrxbUCQ==
From: sashiko-bot@kernel.org
Subject: Re: [CI v4 02/14] drm/i915/color: Add CSC on SDR plane color pipeline
To: "Chaitanya Kumar Borah" <chaitanya.kumar.borah@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713051516.4087420-3-chaitanya.kumar.borah@intel.com>
References: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
 <20260713051516.4087420-3-chaitanya.kumar.borah@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 06:01:43 +0000
Message-Id: <20260713060143.D36111F000E9@smtp.kernel.org>
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
- [Medium] The newly added SDR plane color pipeline logic is completely unr=
eachable due to an early return for non-HDR planes in the caller function.
- [Medium] The driver exposes the `CSC_FF` colorop but fails to extract and=
 apply its atomic state, violating the DRM API contract.

Pre-existing issues:
- [Critical] `drm_colorop_cleanup()` fails to unregister the DRM mode objec=
t, leading to a Use-After-Free via stale object IDs.
- [High] `drm_colorop_cleanup` assumes `colorop->dev` and `colorop->head` a=
re fully initialized, causing a NULL pointer dereference and crash on early=
 initialization failures.
- [High] Unchecked return value from `kasprintf()` leads to a NULL pointer =
dereference during DRM property creation.
--

--- Patch [2]: [CI v4 02/14] drm/i915/color: Add CSC on SDR plane color pip=
eline ---
commit ed94f2ef5daa2b6a1fe43a799710d164ac1323d4
Author: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

drm/i915/color: Add CSC on SDR plane color pipeline

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
Will intel_plane_color_copy_uapi_to_hw_state() successfully extract the
state for INTEL_PLANE_CB_CSC_FF?

Looking at intel_plane_colorop_replace_blob() in
drivers/gpu/drm/i915/display/intel_plane.c, it handles blob-based colorops
like INTEL_PLANE_CB_CSC, but lacks a case for INTEL_PLANE_CB_CSC_FF.

Could this cause userspace settings for fixed_matrix_type and bypass on this
colorop to be silently ignored when applying the pipeline?

[Severity: High]
This is a pre-existing issue, but if drm_plane_colorop_fixed_matrix_init()
or other initialization functions fail early (e.g. due to OOM), the code
jumps to the cleanup label in this function and calls intel_colorop_destroy=
().

This calls drm_colorop_cleanup(), which unconditionally dereferences
colorop->dev and colorop->head via list_del().

Since these fields might not be initialized on early failure, is it possible
for this to cause a NULL pointer dereference?

[Severity: Critical]
This is another pre-existing issue on the cleanup path. When
drm_colorop_cleanup() runs, it never calls drm_mode_object_unregister().

Because the object was registered in drm_mode_object_add() during init,
does omitting drm_mode_object_unregister() leave a dangling pointer in the
device's IDR, allowing userspace to trigger a use-after-free by querying
the freed object ID?

>  	default:
>  		drm_err(plane->dev, "Invalid colorop id [%d]", id);
>  		ret =3D -EINVAL;

[ ... ]

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
Will this newly added sdr_plane_pipeline ever execute?

The caller of this function, intel_color_pipeline_plane_init(), has an early
return:

intel_color_pipeline_plane_init()
    if (!icl_is_hdr_plane(display, to_intel_plane(plane)->id))
        return 0;
       =20
    ret =3D _intel_color_pipeline_plane_init(plane, &pipelines[len], pipe);

Because it skips all non-HDR planes before calling this function, doesn't
that make this else branch for SDR planes completely unreachable?

[Severity: High]
This isn't a bug introduced by this patch, but immediately below this block
in _intel_color_pipeline_plane_init(), kasprintf() is called:

    list->name =3D kasprintf(GFP_KERNEL, "Color Pipeline %d", ...);

The return value is not checked for NULL.

If kasprintf() fails, it passes the NULL pointer to
drm_plane_create_color_pipeline_property(), which passes it to
drm_property_create_enum().

Will this cause a panic when strlen(name) is called on the NULL pointer
inside drm_property_add_enum()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713051516.4087=
420-1-chaitanya.kumar.borah@intel.com?part=3D2
