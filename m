Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB19C5AD44
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 23:33:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A352610E0A7;
	Sat,  8 Aug 2026 23:33:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fG0+o7WU";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADAC610E0A7
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 23:33:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C17540896;
 Sat,  8 Aug 2026 23:33:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209DD1F000E9;
 Sat,  8 Aug 2026 23:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786232027;
 bh=wkx6iPNHmeMxG4tLtWs1q9Eq8B0iaqNOIjUMRkqw4h8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fG0+o7WUfvsKjYm0hKVeB07C4jCAB/6lcIjSWeABGcdxx3HLhD0oVsXcoqayeGmbt
 lw4Srp6lZZucToXs8DVLLef+jJIzmCLOzm2AnFzYb4cvsEEqFwgG7e2RL/ZhVUg9qc
 MZwohdT6Ckjga1p5ASTmDct9Dwyll9PWgwizpaTFet9pAm1cae7iJF/JpXTt6oPfCx
 776LRt1fn9IWKC7HnGIbgRX20R47LxA3f0lxaE1px99vuk4khm/fY5/oGnnMwjj5Tk
 NO60CVRb93OOJWcT7irtJd8/728v5ATE0ujenjqMb0v2i+drHfqTWjA5yUMDcKnLPt
 j05WRkVyVtEhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: return an error when a shared GB surface
 has no backup buffer
To: "Aldo Ariel Panzardo" <qwe.aldo@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808231002.67559-1-qwe.aldo@gmail.com>
References: <20260808231002.67559-1-qwe.aldo@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 23:33:46 +0000
Message-Id: <20260808233347.209DD1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] TOCTOU race on `srf->res.guest_memory_bo` leading to a NULL po=
inter dereference in `drm_gem_handle_create`.
- [Critical] Lockless accesses to `guest_memory_bo` after releasing `cmdbuf=
_mutex` can lead to a Use-After-Free or NULL pointer dereference.
- [High] Leaked DRM handle on error paths in `vmw_gb_surface_reference_inte=
rnal` when processing a PRIME file descriptor.
- [High] GEM handle leak in `vmw_gb_surface_define_internal` when initializ=
ation fails after handle creation.
- [Medium] The function `vmw_gb_surface_reference_internal` fails to popula=
te the `buffer_byte_stride` field in the extended reply structure.
--

--- Patch [1]: [PATCH] drm/vmwgfx: return an error when a shared GB surface=
 has no backup buffer ---
commit 6bbaf49225562d900a468ed3b35d8995cea03c99
Author: Aldo Ariel Panzardo <qwe.aldo@gmail.com>

drm/vmwgfx: return an error when a shared GB surface has no backup buffer

This commit fixes a missing error assignment in
vmw_gb_surface_reference_internal() when a shared GB surface lacks a backup
buffer. By returning -EINVAL instead of 0, it prevents the ioctl from
returning uninitialized stack memory to userspace.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index bd0563741e89d..014f674744ac3 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -1720,6 +1720,7 @@ vmw_gb_surface_reference_internal(struct drm_device=
 *dev,
>  	srf =3D &user_srf->srf;
>  	if (!srf->res.guest_memory_bo) {
>  		DRM_ERROR("Shared GB surface is missing a backup buffer.\n");
> +		ret =3D -EINVAL;
>  		goto out_bad_resource;
>  	}

[Severity: Critical]
This is a pre-existing issue, but does this lockless check create a TOCTOU
race?

If a concurrent thread detaches the backup buffer and sets guest_memory_bo =
to
NULL under cmdbuf_mutex, the lockless check here might pass, but a NULL poi=
nter
would then be dereferenced in drm_gem_handle_create():

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_gb_surface_reference_internal()=
 {
...
	mutex_lock(&dev_priv->cmdbuf_mutex);
	ret =3D drm_gem_handle_create(file_priv,
				    &srf->res.guest_memory_bo->tbo.base,
				    &backup_handle);
	mutex_unlock(&dev_priv->cmdbuf_mutex);
...
}

[Severity: High]
This isn't a bug introduced by this patch, but does taking this error path =
leak
a DRM handle?

When handle_type =3D=3D DRM_VMW_HANDLE_PRIME, vmw_surface_handle_reference(=
) adds a
reference to the file's handle table. The cleanup path at out_bad_resource
drops the object reference but doesn't remove the newly created handle from=
 the
file:

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_gb_surface_reference_internal()=
 {
...
out_bad_resource:
	ttm_base_object_unref(&base);

	return ret;
}

>  	metadata =3D &srf->metadata;

[Severity: Critical]
This is a pre-existing issue, but are there unsafe lockless accesses to
guest_memory_bo later in this function?

After releasing cmdbuf_mutex, the function populates mapping handles and si=
zes
by locklessly dereferencing srf->res.guest_memory_bo:

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_gb_surface_reference_internal()=
 {
...
	rep->crep.buffer_map_handle =3D
		drm_vma_node_offset_addr(
			&srf->res.guest_memory_bo->tbo.base.vma_node);
	rep->crep.buffer_size =3D srf->res.guest_memory_bo->tbo.base.size;
...
}

Could this lead to a NULL pointer dereference or Use-After-Free if another
thread detaches or frees the backup buffer concurrently?

[Severity: Medium]
This isn't a bug introduced by this patch, but does this function fail to
populate the buffer_byte_stride field in the extended reply structure?

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_gb_surface_reference_internal()=
 {
...
	rep->creq.version =3D drm_vmw_gb_surface_v1;
	rep->creq.svga3d_flags_upper_32_bits =3D
		SVGA3D_FLAGS_UPPER_32(metadata->flags);
	rep->creq.multisample_pattern =3D metadata->multisample_pattern;
	rep->creq.quality_level =3D metadata->quality_level;
	rep->creq.must_be_zero =3D 0;
...
}

[Severity: High]
This is a pre-existing issue, but does vmw_gb_surface_define_internal() lea=
k a
GEM handle when initialization fails?

If any initialization fails after vmw_gem_object_create_with_handle()
successfully allocates a GEM buffer object and registers backup_handle, the
cleanup path fails to call drm_gem_handle_delete():

drivers/gpu/drm/vmwgfx/vmwgfx_surface.c:vmw_gb_surface_define_internal() {
...
		ret =3D vmw_gem_object_create_with_handle(dev_priv, file_priv,
							res->guest_memory_size,
							&backup_handle,
							&res->guest_memory_bo);
	}

	if (unlikely(ret !=3D 0)) {
		vmw_resource_unreference(&res);
		goto out_unlock;
	}
...
out_unlock:
	vmw_resource_unreference(&tmp);
	vmw_resource_unreference(&res);
	return ret;
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808231002.6755=
9-1-qwe.aldo@gmail.com?part=3D1
