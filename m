Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F7FC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F98510F04D;
	Thu, 27 Aug 2026 13:22:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HDMYJ/cB";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 382EF10F04D;
 Thu, 27 Aug 2026 13:22:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E7B05402FA;
 Thu, 27 Aug 2026 13:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2B31F000E9;
 Thu, 27 Aug 2026 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787836932;
 bh=0rO/YP64JqJweCYgvnEhcNhv9rAhdVPkCqrUD1+fvIQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HDMYJ/cBEZI5eLlEDfLPmSJHw4qSkF40ktHAOcbG5bNZCbJ6iUP5Cyimz4TaIloGo
 4HuvREdR9ZWsmHN/6q2CmbY3wVgS8apZbb8fEzg2yV6P7IeZ2a2Xq4mvWDWj6XOGDe
 a2YneLT4/cLhhOzbYHgNbRKrHg0zJpbzYLLqL1D1Y7kw5v/QHou5yGdZ2dVkVMsvfX
 ZcPcmDqBN57WLrg7GuYllHZdwJmVZ1pL+k3/0oobHOsJFex3YoUDPl4wYkOYvXNmt3
 9xSqNvz3Dv/Xgd5otP6tipMAZBrJuhFBokMT+TX6pOhHjyKLQEbFaAjHeTNyua4aQD
 kGmN2UED2bSwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/10] drm/gem: Add helper for drm_gem_object resv
 assignment
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260827124910.2245-4-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-4-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:22:12 +0000
Message-Id: <20260827132212.8C2B31F000E9@smtp.kernel.org>
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
- [Critical] Direct assignments to `obj->resv` bypass `drm_gem_object_set_r=
esv()`, causing reference counting underflows and memory leaks.
- [High] i915 driver open-coded GEM teardown misses `dma_resv_put(obj->base=
.resv)`, permanently leaking the reservation object references for all i915=
 GEM objects.
- [High] Memory leaks on the error path in virtgpu_gem_prime_import().
- [High] Calling drm_gem_object_set_resv() under a spinlock can trigger dma=
_resv and fence release callbacks, causing potential deadlocks.
--

commit ad191ee55ce616a6f881f13681e85331c2eeb4ec
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

drm/gem: Add helper for drm_gem_object resv assignment
   =20
Introduce drm_gem_object_set_resv() to safely assign reservation objects
to GEM objects with proper reference counting. This helper replaces all
direct assignments to drm_gem_object.resv throughout the DRM subsystem.

[ ... ]

> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index 88d60fb17f43b..bc87cc8fbeffa 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -230,7 +230,7 @@ void drm_gem_private_object_init(struct drm_device *d=
ev,
>  	mutex_init(&obj->gpuva.lock);
>  	dma_resv_init(&obj->_resv);
>  	if (!obj->resv)
> -		obj->resv =3D &obj->_resv;
> +		obj->resv =3D dma_resv_get(&obj->_resv);

[Severity: Critical]
With this change, obj->resv holds a reference that must be released. It loo=
ks
like some drivers still use direct assignment (e.g., obj->resv =3D dma_buf-=
>resv)
which will leak this initial reference and fail to acquire a reference on t=
he
new object.

For example, these assignments appear to remain:
- drivers/accel/amdxdna/amdxdna_gem.c: gobj->resv =3D dma_buf->resv;
- drivers/accel/ivpu/ivpu_gem.c: obj->resv =3D dma_buf->resv;
- drivers/accel/qaic/qaic_data.c: obj->resv =3D dma_buf->resv;
- drivers/gpu/drm/i915/gt/intel_gtt.c: obj->base.resv =3D i915_vm_resv_get(=
vm);
- rust/kernel/drm/gem/shmem.rs: unsafe { (*obj.obj.get()).base.resv =3D par=
ent_resv.raw_dma_resv() };

When these GEM objects are destroyed, drm_gem_private_object_fini() will ca=
ll
dma_resv_put() on the external reservation object. Since a reference was ne=
ver
acquired during assignment, could this cause a use-after-free? Should these
callers also be updated to use drm_gem_object_set_resv()?

> =20
>  	drm_gem_gpuva_init(obj);
> =20
> @@ -249,11 +249,40 @@ void drm_gem_private_object_fini(struct drm_gem_obj=
ect *obj)
>  {
>  	WARN_ON(obj->dma_buf);
> =20
> +	dma_resv_put(obj->resv);
>  	dma_resv_put(&obj->_resv);
>  	mutex_destroy(&obj->gpuva.lock);
>  }

[Severity: High]
This correctly releases the reference for objects using the standard teardo=
wn
path. However, the i915 driver open-codes GEM teardown and doesn't call
drm_gem_private_object_fini():

drivers/gpu/drm/i915/gem/i915_gem_object.c:__i915_gem_object_fini() {
    mutex_destroy(&obj->mm.get_page.lock);
    mutex_destroy(&obj->mm.get_dma_page.lock);
    dma_resv_put(&obj->base._resv);
}

Does __i915_gem_object_fini() also need a dma_resv_put(obj->base.resv) call=
 to
prevent permanently leaking the reservation object references for i915 GEM
objects?

[ ... ]

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> index ef56c18ded1b8..216c83bb0a0bb 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> @@ -209,7 +209,7 @@ static int ttm_bo_individualize_resv(struct ttm_buffe=
r_object *bo)
>  		 * the resv object while holding the lru_lock.
>  		 */
>  		spin_lock(&bo->bdev->lru_lock);
> -		bo->base.resv =3D &bo->base._resv;
> +		drm_gem_object_set_resv(&bo->base, &bo->base._resv);
>  		spin_unlock(&bo->bdev->lru_lock);
>  	}

[Severity: High]
Calling drm_gem_object_set_resv() here drops the reference to the old
reservation object while holding bo->bdev->lru_lock. If this drops the last
reference to a shared reservation object, dma_resv_release() will be invoked
synchronously under the spinlock.

Since dma_resv_release() frees the fence list and drops all attached fences,
could this invoke fence release callbacks that attempt to acquire the same
lru_lock (e.g., via ttm_bo_release()), leading to a deadlock?

[ ... ]

> diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/vir=
tio/virtgpu_prime.c
> index 216c77cd0d21b..79964b4362439 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_prime.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
> @@ -361,7 +361,7 @@ struct drm_gem_object *virtgpu_gem_prime_import(struc=
t drm_device *dev,
>  	INIT_LIST_HEAD(&bo->restore_node);
> =20
>  	obj =3D &bo->base.base;
> -	obj->resv =3D buf->resv;
> +	drm_gem_object_set_resv(obj, buf->resv);
>  	obj->funcs =3D &virtgpu_gem_dma_buf_funcs;
>  	drm_gem_private_object_init(dev, obj, buf->size);
> =20

[Severity: High]
If the subsequent calls to drm_gem_private_object_init() or
dma_buf_dynamic_attach() fail, the error paths just call kfree(bo):

	ret =3D drm_gem_private_object_init(dev, obj, buf->size);
	if (ret) {
		kfree(bo);
		return ERR_PTR(ret);
	}

	attach =3D dma_buf_dynamic_attach(buf, dev->dev,
					&virtgpu_dma_buf_attach_ops, obj);
	if (IS_ERR(attach)) {
		kfree(bo);
		return ERR_CAST(attach);
	}

Does this leak the new reference acquired by drm_gem_object_set_resv() to
buf->resv, as well as the resources initialized by drm_gem_private_object_i=
nit()
in the latter case?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827124910.2245=
-1-christian.koenig@amd.com?part=3D3
