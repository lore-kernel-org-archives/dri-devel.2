Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E5606A323
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIa6RrQq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E3310E642;
	Fri, 13 Nov 2026 15:31:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9B010E642
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 15:31:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F04D160DEF;
 Fri, 13 Nov 2026 15:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B391F000C4;
 Fri, 13 Nov 2026 15:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794583891;
 bh=VXa/yIW8H/NEKoOfd/hl2hCly4hFI5NFV/pNijHTTuw=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=SIa6RrQqf31VS1OCws6vzuSToEIwpkUbRqhFWoL8jkvOOlwExf3M6Tjmb+pGJKS8W
 LpkF64cCiagK78/0MpVf+R6hfPqoKaHJ4zAigEOnBfbYX2akZXLQ5PZvQUljTQH7p+
 nhGPsp0AFDiO7py1vf5z8OHdOLELyytm3eJsYH6pASqWHPc8xGza2zv2d0DlBoWLb6
 h2e4w+rQ8ZU8jJ3/qpnUFRwP+uGBaNhTJEl3+Gr5Gltl779nhkWYmGbxIuxLhPTD3l
 Yo6dvQU31FNoseMt4AlgdfB/SR2YhFsvrCwDXQBN0HN2jrtuYIf55O2BRMAiL5xE/a
 bvnhaWJ3c5QNA==
Message-ID: <sashiko-outbox-213094@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] drm/gem: Fix and enable CHANGE_HANDLE
To: "David Francis" <David.Francis@amd.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261113150226.1123441-1-David.Francis@amd.com>
References: <20261113150226.1123441-1-David.Francis@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 15:31:31 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/gem: broken PRIME handling in
  drm_gem_change_handle_ioctl()
- [Medium] drm/gem: stale i915 VMA LUT cache in
  drm_gem_change_handle_ioctl()
- [Low] drm/gem: idr_alloc() -ENOMEM masked in
  drm_gem_change_handle_ioctl()
--

commit 7986c0e82ecacec73e2cd689a660b9387bc87689
Author: David Francis <David.Francis@amd.com>

drm/gem: Fix and enable CHANGE_HANDLE

This commit updates drm_gem_change_handle_ioctl() to reject invalid or
unchanged handles, preload the IDR before allocation, return -EBUSY when
new_handle is already in use, and re-enables DRM_IOCTL_GEM_CHANGE_HANDLE.

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 3ce38df7b8b85..66f69cf41aaf0 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -1017,44 +1017,33 @@ drm_gem_open_ioctl(struct drm_device *dev, void *=
data,
>  	return ret;
>  }
> =20
> -/*
> - * This ioctl is disabled for security reasons but also it failed
> - * to follow process in terms of adding testing in igt and verifying
> - * all the corner cases which made fixing security bugs in it even
> - * harder than necessary.
> - *
> - * To re-enable this ioctl
> - * 1. land working IGT tests in igt-gpu-tools that cover
> - *    all corner cases and race conditions.
> - * 2. handle idr_preload
> - * 3. handle =3D=3D 0
> - * 4. handle =3D=3D new_handle semantics definition.
> - */
>  int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
>  				struct drm_file *file_priv)
>  {
>  	struct drm_gem_change_handle *args =3D data;
>  	struct drm_gem_object *obj;
> -	int new_handle, ret;
> +	int ret;
> +	u32 new_handle;
> =20
>  	if (!drm_core_check_feature(dev, DRIVER_GEM))
>  		return -EOPNOTSUPP;
> =20
> -	/* idr_alloc() limitation. */
> -	if (args->new_handle > INT_MAX)
> -		return -EINVAL;
>  	new_handle =3D args->new_handle;
> =20
> -	if (args->handle =3D=3D new_handle)
> -		return 0;
> +	if (new_handle =3D=3D 0 || new_handle > INT_MAX ||
> +	    args->handle =3D=3D new_handle)
> +		return -EINVAL;
> =20
>  	mutex_lock(&file_priv->prime.lock);
> +	idr_preload(GFP_KERNEL);
>  	spin_lock(&file_priv->table_lock);
> -	ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle, new_handle =
+ 1,
> -			GFP_NOWAIT);
> +	ret =3D idr_alloc(&file_priv->object_idr, NULL, new_handle,
> +			new_handle + 1, GFP_NOWAIT);
> =20
>  	if (ret < 0) {
>  		spin_unlock(&file_priv->table_lock);
> +		idr_preload_end();
> +		ret =3D -EBUSY;
>  		goto out_unlock;
>  	}

[Severity: Low]
Does this mask -ENOMEM from idr_alloc()?  If idr_preload() fails to
allocate a radix tree node under memory pressure, idr_alloc() returns
-ENOMEM rather than -ENOSPC, so only -ENOSPC should be translated to
-EBUSY.

>  	obj =3D idr_replace(&file_priv->object_idr, NULL, args->handle);
>  	if (IS_ERR_OR_NULL(obj)) {
>  		idr_remove(&file_priv->object_idr, new_handle);
>  		spin_unlock(&file_priv->table_lock);
> +		idr_preload_end();
>  		ret =3D -ENOENT;
>  		goto out_unlock;
>  	}
>  	spin_unlock(&file_priv->table_lock);
> +	idr_preload_end();
> =20
>  	if (obj->dma_buf) {

[Severity: Medium]
Can checking obj->dma_buf here race with concurrent PRIME export and
corrupt file_priv->prime?

obj->dma_buf is a device-wide field protected by dev->object_name_lock,
whereas drm_gem_change_handle_ioctl() only holds the per-file
file_priv->prime.lock:

CPU0                                  CPU1
drm_gem_change_handle_ioctl()         drm_gem_prime_handle_to_fd()
  mutex_lock(&file_priv1->prime.lock)   mutex_lock(&file_priv2->prime.lock)
                                        mutex_lock(&dev->object_name_lock)
                                        export_and_register_object()
  if (obj->dma_buf)                       obj->dma_buf =3D dmabuf;
    <-- data race

Keying the file_priv->prime update on obj->dma_buf rather than checking
whether args->handle is present in file_priv->prime via
drm_prime_lookup_buf_by_handle() also mismanages the per-file PRIME cache:

1. If obj->dma_buf was set by exporting on another drm_file (or via
   another handle H1 on the same file_priv), changing a non-PRIME handle
   H2 (e.g. from DRM_IOCTL_GEM_OPEN or DRM_IOCTL_MODE_GETFB2) to H3 calls
   drm_prime_add_buf_handle() for H3 while drm_prime_remove_buf_handle()
   for H2 is a no-op.  When H1 is already in file_priv->prime, this inserts
   a duplicate dma_buf entry into file_priv->prime.dmabufs.

2. Conversely, when a PRIME-imported object (obj->import_attach !=3D NULL)
   has obj->dma_buf =3D=3D NULL (for example, if a handle is re-obtained via
   DRM_IOCTL_MODE_GETFB2 after handle_count previously dropped to zero)
   and is exported via drm_gem_prime_handle_to_dmabuf(), the
   (obj->import_attach->dmabuf, args->handle) entry is added to
   file_priv->prime without setting obj->dma_buf:

drivers/gpu/drm/drm_prime.c:drm_gem_prime_handle_to_dmabuf() {
    ...
	if (obj->import_attach) {
		dmabuf =3D obj->import_attach->dmabuf;
		get_dma_buf(dmabuf);
		goto out_have_obj;
	}
    ...
out_have_obj:
    ...
	ret =3D drm_prime_add_buf_handle(&file_priv->prime,
				       dmabuf, handle);
}

   Changing args->handle then skips the if (obj->dma_buf) block and leaves
   args->handle orphaned in file_priv->prime, triggering the WARN_ON() in
   drm_prime_destroy_file_private() and leaking the drm_prime_member and
   its dma_buf reference when the file is closed.

> diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
> index 9039a39c43243..bb350895625ce 100644
> --- a/drivers/gpu/drm/drm_ioctl.c
> +++ b/drivers/gpu/drm/drm_ioctl.c
> @@ -672,8 +672,7 @@ static const struct drm_ioctl_desc drm_ioctls[] =3D {
>  	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CLOSE, drm_gem_close_ioctl, DRM_RENDER_ALLO=
W),
>  	DRM_IOCTL_DEF(DRM_IOCTL_GEM_FLINK, drm_gem_flink_ioctl, DRM_AUTH),
>  	DRM_IOCTL_DEF(DRM_IOCTL_GEM_OPEN, drm_gem_open_ioctl, DRM_AUTH),
> -	/* see drm_gem.c:drm_gem_change_handle_ioctl for why this is invalid */
> -	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_invalid_op, DRM_RENDER_A=
LLOW),
> +	DRM_IOCTL_DEF(DRM_IOCTL_GEM_CHANGE_HANDLE, drm_gem_change_handle_ioctl,=
 DRM_RENDER_ALLOW),

[Severity: Medium]
Does re-enabling DRM_IOCTL_GEM_CHANGE_HANDLE leave stale entries in i915's
per-context VMA lookup cache (eb->gem_context->handles_vma)?

In i915, eb_lookup_vma() caches (handle -> vma) in
eb->gem_context->handles_vma and checks that radix tree before consulting
eb->file->object_idr:

drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:eb_lookup_vma() {
    ...
	if (likely(!eb->lut_size)) {
		rcu_read_lock();
		vma =3D radix_tree_lookup(&eb->gem_context->handles_vma, handle);
		if (likely(vma))
			vma =3D i915_vma_tryget(vma);
		rcu_read_unlock();
		if (likely(vma))
			return vma;
	}
    ...
}

Entries are only removed from ctx->handles_vma when the context is closed
or when obj->funcs->close (i915_gem_close_object()) runs.  Because
drm_gem_change_handle_ioctl() moves the handle in file_priv->object_idr
without invoking obj->funcs->close or notifying the driver, subsequent
DRM_IOCTL_I915_GEM_EXECBUFFER2 calls using the old handle (even after a
newly created object is assigned that handle ID) will resolve to the old
object's VMA, and repeated handle changes accumulate i915_lut_handle
entries on obj->lut_list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113150226.1123=
441-1-David.Francis@amd.com?part=3D1
