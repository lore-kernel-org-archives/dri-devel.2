Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EBCC61DC6
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3F3C10F033;
	Thu, 27 Aug 2026 13:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dZ5fydcn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C617B10F033;
 Thu, 27 Aug 2026 13:19:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 93AB642D72;
 Thu, 27 Aug 2026 13:19:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AC81F000E9;
 Thu, 27 Aug 2026 13:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787836755;
 bh=8l6s2dYN0FiR9p5UAd+4kjWPBVjasCj/Opzn3WlrhJ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dZ5fydcndgSV9k4SIgJwxkyeb6ygR+0jm+tbplnKotppGln1Z9nD1JB6JpTpcrZ8h
 +7wVod1oIy9FpnfB9abImAj50oNfmZZSiurRRs3ktApK/otKsrwL8pTYZR87q4Z2qp
 cgixIa2afQloBsMRCi+F8m9yNpWbI3htq0AyyDE6x8d+f0dcx5mKEzJiO40Xx5MAOw
 bQ2AU5vhxPvj9JRi9t5qoaliV/EM5o2XuGnqfkC8NnDu3W7D0USWSQYvPLQg8UdhQW
 ePNl3gsyhM6UvOu8sssEQmEJzY34utH/aOw3mNJRbVz4EqrHFPclqPgY1vKcMA7XHD
 VTZ/Liwtofm7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] drm/gem: Convert drm_gem_private_object_init to
 return error code
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20260827124910.2245-5-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-5-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:19:14 +0000
Message-Id: <20260827131915.40AC81F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Memory leak in xe_bo_init_locked() on drm_gem_private_object_ini=
t() failure.
- [Medium] Memory leak in vmw_bo_create() when vmw_bo_init() fails at GEM i=
nitialization.
- [Medium] Heap allocation leak in amdxdna_drm_create_dev_bo() when drm_gem=
_private_object_init() fails.
--

commit 31f8fb9f49fa7d6352b54fca867dc5132c27a261
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

drm/gem: Convert drm_gem_private_object_init to return error code

This commit changes drm_gem_private_object_init() to return an error code
instead of void, allowing it to gracefully fail rather than crashing the
kernel with BUG_ON. Call sites across various DRM and accelerator drivers
have been updated to check the return value and handle errors appropriately.

[ ... ]

> diff --git a/drivers/accel/amdxdna/amdxdna_gem.c b/drivers/accel/amdxdna/=
amdxdna_gem.c
> index b01f5d95fac83..96490aa0af1be 100644
> --- a/drivers/accel/amdxdna/amdxdna_gem.c
> +++ b/drivers/accel/amdxdna/amdxdna_gem.c
> @@ -1050,7 +1050,11 @@ amdxdna_drm_create_dev_bo(struct drm_device *dev,
>  		return ERR_PTR(ret);
>  	}
> =20
> -	drm_gem_private_object_init(dev, gobj, aligned_sz);
> +	ret =3D drm_gem_private_object_init(dev, gobj, aligned_sz);
> +	if (ret) {
> +		amdxdna_gem_destroy_obj(abo);
> +		return ERR_PTR(ret);
> +	}

[Severity: Medium]
Does this code leak the heap allocation? In amdxdna_drm_create_dev_bo(),=20
there is an earlier successful call to amdxdna_gem_heap_alloc(). If=20
drm_gem_private_object_init() fails, the error handler only calls=20
amdxdna_gem_destroy_obj() and skips calling amdxdna_gem_heap_free(),=20
which leaves a persistent resource leak in the client's heap tracking.

[ ... ]

> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/=
vmwgfx_bo.c
> index 9c7a73c0b0dc3..e4e4b87e738d3 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
> @@ -426,7 +426,9 @@ static int vmw_bo_init(struct vmw_private *dev_priv,
>  	atomic_set(&vmw_bo->map_count, 0);
> =20
>  	params->size =3D ALIGN(params->size, PAGE_SIZE);
> -	drm_gem_private_object_init(vdev, &vmw_bo->tbo.base, params->size);
> +	ret =3D drm_gem_private_object_init(vdev, &vmw_bo->tbo.base, params->si=
ze);
> +	if (ret)
> +		return ret;
> =20
>  	vmw_bo_placement_set(vmw_bo, params->domain, params->busy_domain);
>  	ret =3D ttm_bo_init_reserved(bdev, &vmw_bo->tbo, params->bo_type,

[Severity: Medium]
Could this early return cause the vmw_bo structure to be leaked?=20
When vmw_bo_create() allocates the object, it passes it to vmw_bo_init()
with a destruction callback. If drm_gem_private_object_init() fails and
returns early here, it bypasses the ttm_bo_init_reserved() setup. Because
TTM never receives the destruction callback, the caller receives the error=
=20
and nullifies the pointer without actually freeing it, permanently leaking=
=20
the struct.

[ ... ]

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index dde309821237b..85e49b48f9d3a 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -2400,7 +2400,9 @@ struct xe_bo *xe_bo_init_locked(struct xe_device *x=
e, struct xe_bo *bo,
>  	/* Initialize purge advisory state */
>  	bo->purgeable.state =3D XE_MADV_PURGEABLE_WILLNEED;
> =20
> -	drm_gem_private_object_init(&xe->drm, &bo->ttm.base, size);
> +	err =3D drm_gem_private_object_init(&xe->drm, &bo->ttm.base, size);
> +	if (err)
> +		return ERR_PTR(err);
> =20
>  	if (resv) {
>  		ctx.allow_res_evict =3D !(flags & XE_BO_FLAG_NO_RESV_EVICT);

[Severity: Medium]
Can this error path leak the xe_bo struct? If xe_bo_init_locked() is called
with a NULL bo pointer, such as from xe_bo_create_locked(), it allocates a
new xe_bo structure internally. If drm_gem_private_object_init() then fails,
returning ERR_PTR(err) immediately means the newly allocated bo reference i=
s=20
lost before it can be freed with xe_bo_free().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827124910.2245=
-1-christian.koenig@amd.com?part=3D4
