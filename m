Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24872C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D87010F04E;
	Thu, 17 Sep 2026 18:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nVQ920wb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19A9010F04E
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 18:25:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C89F94077D;
 Thu, 17 Sep 2026 18:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCA41F000FF;
 Thu, 17 Sep 2026 18:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789669514;
 bh=nliSKxFZh2JAd1BQbV49d/qN4uVnAXPBbk34c6rCbMM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nVQ920wb+dowaLH/qs2cWIA7YoaZOQHYNeAlGc4CysCOj6seQvuD2ISte6nKH7g0t
 ERdZHnz83WoVskB8Usa+orZEBfJr311mfOvWnXULGeL25khbhr2g0kVROOrrmroALg
 LU63Y3ZjpaB10MtX4lLXZHLstctmEMoNGdnHo7WP1tBkOpYElb2vBiBSIroYIxKsIw
 pIX4YpF9dZj/b+D+hLFuQBVhhBy6+nRd/GfX1zg10fe2BnbuJ4FyN7qW7XLSAivJCM
 67CuiiaUoDbGIKp8Bi2fphDEEgnqQ2cH+8hs+Jj0zDvVkyiwt0gRX45CCyf80/7Buh
 8G3bizUfJum7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vmwgfx: Fix GEM_CLOSE returning -EINVAL for
 PRIME-imported surfaces
To: "Claire DuSoleil" <claire.m.dusoleil@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260917181312.12473-1-claire.m.dusoleil@gmail.com>
References: <20260917181312.12473-1-claire.m.dusoleil@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 18:25:14 +0000
Message-Id: <20260917182514.7FCA41F000FF@smtp.kernel.org>
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
- [Critical] drm/vmwgfx: handle namespace collision leads to object hijacki=
ng and UAF
- [Critical] drm/vmwgfx: TOCTOU race in prime import allows cross-process s=
urface hijacking
- [High] drm/vmwgfx: PRIME_HANDLE_TO_FD fails on bridge GEM handles
- [High] drm/vmwgfx: memory leaks of surface and bridge objects during PRIM=
E cleanup
- [Medium] drm/vmwgfx: violation of PRIME_FD_TO_HANDLE caching semantics
--

commit 1a74f33f037015680dfd44a4127992d0bec7eedf
Author: Claire DuSoleil <claire.m.dusoleil@gmail.com>

drm/vmwgfx: Fix GEM_CLOSE returning -EINVAL for PRIME-imported surfaces

This commit addresses a bug where DRM_IOCTL_GEM_CLOSE fails for PRIME-impor=
ted
surfaces in vmwgfx. It fixes this by wrapping the private handle in a
non-TTM-backed GEM object registered in the standard per-file handle table.

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c b/drivers/gpu/drm/vmwg=
fx/vmwgfx_prime.c
> index 598b90ac7590b..531525122fda3 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
[ ... ]
> +uint32_t vmw_prime_resolve_handle(struct drm_file *file_priv, uint32_t h=
andle)
> +{
> +	struct drm_gem_object *gobj =3D drm_gem_object_lookup(file_priv, handle=
);
> +	uint32_t real_handle =3D handle;
> +
> +	if (gobj) {
> +		if (gobj->funcs =3D=3D &vmw_prime_import_bridge_funcs) {
> +			struct vmw_prime_import_bridge *bridge =3D
> +				container_of(gobj, struct vmw_prime_import_bridge, base);
> +			real_handle =3D bridge->ttm_handle;
> +		}

[Severity: Critical]
Does this code silently intercept legitimate TTM handles of the same numeri=
cal
value?=20

GEM handles and TTM handles share the same 32-bit integer space but are
allocated from independent IDRs, so collisions are highly likely.

By checking the GEM IDR first, if a new TTM surface is allocated with an ID
that matches an existing bridge GEM handle, vmw_user_resource_lookup_handle=
()
will resolve it to the bridge's surface instead of the new surface.

[Severity: High]
Can DRM_IOCTL_PRIME_HANDLE_TO_FD fail on these bridge GEM handles?

When exporting, vmw_prime_handle_to_fd() routes handles <=3D VMWGFX_NUM_MOB
to vmw_user_bo_lookup(), which explicitly rejects bridge handles (-ESRCH).
Handles > VMWGFX_NUM_MOB are routed to ttm_prime_handle_to_fd(), which look=
s up
the GEM handle in the TTM namespace, causing a failure or exporting an
unrelated surface.=20

This breaks the generic PRIME round-trip property for imported surfaces.

> +		drm_gem_object_put(gobj);
> +	}
> +
> +	return real_handle;
> +}
> +
>  int vmw_prime_fd_to_handle(struct drm_device *dev,
>  			   struct drm_file *file_priv,
>  			   int fd, u32 *handle)
>  {
> +	struct vmw_private *dev_priv =3D vmw_priv(dev);
>  	struct ttm_object_file *tfile =3D vmw_fpriv(file_priv)->tfile;
> -	int ret =3D ttm_prime_fd_to_handle(tfile, fd, handle);
> +	struct vmw_prime_import_bridge *bridge;
> +	struct ttm_base_object *base_obj;
> +	uint32_t ttm_handle;
> +	int ret =3D ttm_prime_fd_to_handle(tfile, fd, &ttm_handle);
> +
> +	if (ret)
> +		return drm_gem_prime_fd_to_handle(dev, file_priv, fd, handle);
> +
> +	/*
> +	 * Take our own independent reference before dropping the transient
> +	 * one ttm_prime_fd_to_handle() just created, so the object can never
> +	 * be dropped to zero in between.
> +	 */
> +	base_obj =3D ttm_base_object_lookup_for_ref(dev_priv->tdev, ttm_handle);

[Severity: Critical]
Is there a TOCTOU race here that allows cross-process surface hijacking?

Between the return of ttm_prime_fd_to_handle() and this IDR lookup, the obj=
ect
is only kept alive by the userspace fd and the tfile ref.

If a malicious user closes the fd and calls DRM_VMW_UNREF_SURFACE(ttm_handl=
e)
concurrently, they can destroy the surface and free the ID. Another process
can create a new surface, re-acquiring the same ID.=20

When this thread resumes and calls ttm_base_object_lookup_for_ref(), it fin=
ds
the new surface and wraps it in a bridge GEM object, granting unauthorized
cross-process access to the innocent user's GPU memory.

> +	if (!base_obj) {
> +		ttm_ref_object_base_unref(tfile, ttm_handle);
> +		return -EINVAL;
> +	}
> +
> +	bridge =3D kzalloc(sizeof(*bridge), GFP_KERNEL);
> +	if (!bridge) {

[Severity: Medium]
Does unconditionally allocating a new bridge and GEM handle violate
PRIME_FD_TO_HANDLE caching semantics?=20

The standard DRM PRIME API contract guarantees that importing the same
DMA-BUF fd multiple times within the same drm_file returns the identical GEM
handle, allowing userspace to deduplicate buffers.=20

This bypasses the generic caching and creates multiple unique GEM handles
wrapping the same buffer, breaking buffer tracking logic in compositors and
leaking resources.

> +		ttm_base_object_unref(&base_obj);
> +		ttm_ref_object_base_unref(tfile, ttm_handle);
> +		return -ENOMEM;
> +	}
[ ... ]
> +	/*
> +	 * On success, deliberately leave the transient ttm_ref_object entry
> +	 * ttm_prime_fd_to_handle() created in place -- do not touch it.

[Severity: High]
Does intentionally skipping cleanup of the TTM reference cause a memory leak
when GEM_CLOSE is called?=20

Generic userspace calling DRM_IOCTL_GEM_CLOSE invokes
vmw_prime_import_bridge_free(), which frees the bridge but fails to release=
 the
ttm_ref_object left alive here, leaking the surface indefinitely.

> +	 * vmw_surface_handle_reference()'s DRM_VMW_REF_SURFACE path forces
[ ... ]
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vm=
wgfx/vmwgfx_surface.c
> index bd0563741e89d..5aabb369e83ca 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
> @@ -689,8 +689,9 @@ int vmw_surface_destroy_ioctl(struct drm_device *dev,=
 void *data,
>  {
>  	struct drm_vmw_surface_arg *arg =3D (struct drm_vmw_surface_arg *)data;
>  	struct ttm_object_file *tfile =3D vmw_fpriv(file_priv)->tfile;
> +	uint32_t sid =3D vmw_prime_resolve_handle(file_priv, arg->sid);
> =20
> -	return ttm_ref_object_base_unref(tfile, arg->sid);
> +	return ttm_ref_object_base_unref(tfile, sid);

[Severity: High]
Does dropping the TTM ref without deleting the GEM handle permanently leak =
the
bridge object?=20

Legacy userspace calling DRM_VMW_UNREF_SURFACE invokes this ioctl, which dr=
ops
the ttm_ref_object but does not close the GEM handle.

>  }
> =20
>  /**
[ ... ]
> @@ -2321,7 +2328,7 @@ int vmw_dumb_create(struct drm_file *file_priv,
>  	args->size =3D arg.rep.buffer_size;
>  	args->pitch =3D vmw_surface_calculate_pitch(desc, &drm_size);
> =20
> -	ret =3D vmw_user_resource_lookup_handle(dev_priv, tfile, arg.rep.handle,
> +	ret =3D vmw_user_resource_lookup_handle(dev_priv, file_priv, tfile, arg=
.rep.handle,
>  					      user_surface_converter,
>  					      &res);

[Severity: Critical]
If vmw_prime_resolve_handle() intercepts the ID in
vmw_user_resource_lookup_handle() and resolves it to an unrelated bridge
surface instead of the new surface, does this lead to dropping a reference =
on
the wrong BO later in vmw_dumb_create(), causing a Use-After-Free and
cross-process data corruption?

vmw_dumb_create() mutates the resolved surface and then executes
drm_gem_object_put(&vbo->tbo.base) on it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917181312.1247=
3-1-claire.m.dusoleil@gmail.com?part=3D1
