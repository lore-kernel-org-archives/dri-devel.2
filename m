Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E5EC44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F22E10EDC6;
	Wed, 22 Jul 2026 14:03:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VG6g1LbG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FED810EDC6
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 14:03:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D9B360A7F;
 Wed, 22 Jul 2026 14:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 187D61F000E9;
 Wed, 22 Jul 2026 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784729024;
 bh=trbHv/C8Hn9DQ3McFvJOdsOHDM7XU1JA6gL0tnmO6uU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VG6g1LbGljZ/Ta/J7guzGVv62PginyRz+kKcTOQGAavA1D/KokT0nrpVGXh67K/ni
 HxArHjVh09cURd2SoOhvs70nsiGjHWr/6FJVNXL8JLCZds+R4ZqbeIv2RibSpTbxl0
 f1yddTx7Ba9m1sUmjXXWLd8DBYSB6FJED5zXeMvav0ob1Ne79bgZcMnGjH53prxRs7
 2hz30CzlqvRay3i3b6WtzNTmNTxWxesLnNN3yzlbRtbY/1jNkfQmqzyA2kIcGmVAkj
 cKLcV0rlaCtdoZNVCIVLTj9JCt3AWC6PzqBp2B7aGa9hYSFF4znpzAdovIAOfCBL/2
 D6l3oiW7Vu9XA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/11] drm/amd/display: Add fixed matrix colorop to
 color pipeline
To: "Harry Wentland" <harry.wentland@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722134607.136293-7-harry.wentland@amd.com>
References: <20260722134607.136293-1-harry.wentland@amd.com>
 <20260722134607.136293-7-harry.wentland@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 14:03:43 +0000
Message-Id: <20260722140344.187D61F000E9@smtp.kernel.org>
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
- [High] The newly added Fixed Matrix (FM) colorop is unhandled by the AMD =
atomic check/commit logic, breaking the entire AMD color pipeline feature.
--

--- Patch [6]: [PATCH v4 06/11] drm/amd/display: Add fixed matrix colorop t=
o color pipeline ---
commit d87e1fc27fd29f8b37f2f841d69915be8eea3f32
Author: Harry Wentland <harry.wentland@amd.com>

drm/amd/display: Add fixed matrix colorop to color pipeline

This commit inserts a fixed matrix colorop as the first operation in the am=
dgpu
color pipeline, before the DEGAM 1D curve. This enables userspace to select
YUV-to-RGB conversion via the color pipeline for YCbCr framebuffers.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> index 056a76b88f438..1ed12cdce3172 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
[ ... ]
> @@ -73,6 +81,23 @@ amdgpu_dm_build_default_pipeline(struct drm_device *de=
v, struct drm_plane *plane
> =20
>  	memset(ops, 0, sizeof(ops));
> =20
> +	/* Fixed Matrix (YUV to RGB) */
> +	ops[i] =3D kzalloc_obj(*ops[0]);
> +	if (!ops[i]) {
> +		ret =3D -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	ret =3D drm_plane_colorop_fixed_matrix_init(dev, ops[i], plane, &dm_col=
orop_funcs,
> +						  amdgpu_dm_supported_fm,
> +						  DRM_COLOROP_FLAG_ALLOW_BYPASS);
> +	if (ret)
> +		goto cleanup;
> +
> +	list->type =3D ops[i]->base.id;
> +
> +	i++;

[Severity: High]
Will this cause atomic checks to unconditionally fail for the color pipelin=
e?

Because the fixed matrix colorop is now the first operation in the pipeline,
userspace will pass it in plane_state->color_pipeline.

However, looking at amdgpu_dm_plane_set_colorop_properties(), it expects the
first operation to be the DEGAM TF:

amdgpu_dm_color.c:amdgpu_dm_plane_set_colorop_properties() {
    ...
    /* 1D Curve - DEGAM TF */
    if (!colorop)
        return -EINVAL;

    ret =3D __set_dm_plane_colorop_degamma(plane_state, dc_plane_state,
                                         colorop);
    if (ret)
        return ret;
    ...
}

When this passes the new fixed matrix colorop to
__set_dm_plane_colorop_degamma(), it ultimately calls
__set_colorop_in_tf_1d_curve() which has a strict type check:

amdgpu_dm_color.c:__set_colorop_in_tf_1d_curve() {
    ...
    if (colorop->type !=3D DRM_COLOROP_1D_CURVE)
        return -EINVAL;
    ...
}

Since the first colorop is now DRM_COLOROP_FIXED_MATRIX, this type check wi=
ll
fail and return -EINVAL.

Does amdgpu_dm_plane_set_colorop_properties() need to be updated to parse a=
nd
handle the new fixed matrix colorop before processing the DEGAM TF?

> +
>  	/* 1D curve - DEGAM TF */
>  	ops[i] =3D kzalloc_obj(*ops[0]);
>  	if (!ops[i]) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722134607.1362=
93-1-harry.wentland@amd.com?part=3D6
