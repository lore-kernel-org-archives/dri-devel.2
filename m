Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA7AC61DC7
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 13:13:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D0610F043;
	Thu, 27 Aug 2026 13:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BlRuVbP2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5878810F033;
 Thu, 27 Aug 2026 13:13:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 057F4417B3;
 Thu, 27 Aug 2026 13:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB091F000E9;
 Thu, 27 Aug 2026 13:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787836395;
 bh=Vjl3JIo7fSL8qy6MLLEaaNJjwY/54mWv9KLB8wYToKk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BlRuVbP25RLbaFFwhEnO7TcSK6heEXx3Wttmw1qYP/dvTdRa93hNCD9kx5i/FjDyO
 235AwQnk1ybh2SrRplke44H810GK4cprU4a1sCDQT5GDE6dTzfNNbapqaqwgLLwDG+
 2Uh7W0pqZOVJ8VsGH76sirm1o48fsXzMR8S4mzUk8HYHBYRgTxRP0WcCgsEzWqyOh7
 X5XK/iubs23h2CyjSCloUZAnezyzOFbB3xczuKLzW/dCmSJe1jIJjoiu9N4Krl6mwZ
 zYC2sX18pJ9p9q3OYkHhWPYrvFZ3SDo0TVUyRaheJ4uBlSqllTFQMHW63oLGr+UWdl
 ulPNrby5JI5nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/10] drm/gem: Use dynamic allocation for GEM object
 dma_resv
To: =?utf-8?b?Q2hyaXN0aWFuIEvDtm5pZw==?= <ckoenig.leichtzumerken@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260827124910.2245-6-christian.koenig@amd.com>
References: <20260827124910.2245-1-christian.koenig@amd.com>
 <20260827124910.2245-6-christian.koenig@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 13:13:15 +0000
Message-Id: <20260827131315.9CB091F000E9@smtp.kernel.org>
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
- [Critical] Uninitialized `dma_resv` for internal Nouveau buffer objects c=
auses NULL pointer dereferences and memory leaks.
- [Critical] Massive memory leak of dynamically allocated `dma_resv` object=
s for all i915 GEM objects.
- [High] Memory leak of `dma_resv` object in TTM ghost objects due to missi=
ng `dma_resv_put()` in `ttm_transfered_destroy()`.
- [Medium] KUnit test runtime crash and compilation failure due to comparin=
g `struct dma_resv *` with `struct dma_resv **`.
--

commit ea9a73424b175ca45f706102b9727e26c5e65f0b
Author: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

drm/gem: Use dynamic allocation for GEM object dma_resv

This patch removes the embedded dma_resv from struct drm_gem_object and
replaces it with a dynamically allocated reservation object. It updates
GEM object initialization to allocate the object and cleans up references
appropriately. It also updates TTM and driver-specific code to handle
the dynamically allocated individual_resv.

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm=
/i915/gem/i915_gem_object.c
> index 384c74794fdc1..5e48e169f2de0 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> @@ -144,7 +144,6 @@ void __i915_gem_object_fini(struct drm_i915_gem_objec=
t *obj)
>  {
>  	mutex_destroy(&obj->mm.get_page.lock);
>  	mutex_destroy(&obj->mm.get_dma_page.lock);
> -	dma_resv_put(&obj->base._resv);
>  }

[Severity: Critical]
Does this code completely leak the dynamically allocated dma_resv object for
all i915 GEM objects?

Since the custom destruction logic in __i915_gem_object_fini() no longer
calls dma_resv_put() for the base GEM resv object, and
drm_gem_private_object_fini() is bypassed by i915, it seems the resv alloca=
ted
in drm_gem_private_object_init() is permanently lost upon destruction.

[ ... ]

> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouve=
au/nouveau_bo.c
> index 67c9d32f4f27b..65e1f0c2f984d 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
[ ... ]
> @@ -385,7 +383,6 @@ nouveau_bo_new(struct nouveau_cli *cli, u64 size, int=
 align,
>  		return PTR_ERR(nvbo);
> =20
>  	nvbo->bo.base.size =3D size;
> -	dma_resv_init(&nvbo->bo.base._resv);
>  	drm_vma_node_reset(&nvbo->bo.base.vma_node);

[Severity: Critical]
Does this leave the dma_resv pointer uninitialized (NULL) for internal
Nouveau buffer objects?

Because nouveau_bo_alloc() uses kzalloc() and bypasses standard GEM
initialization, bo->base.resv remains NULL without this initialization.
Later, when ttm_bo_init_reserved() evaluates
WARN_ON(!dma_resv_trylock(bo->base.resv)), won't this result in an
immediate NULL pointer dereference because bo->base.resv is NULL?

[ ... ]

> diff --git a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c b/drivers/g=
pu/drm/ttm/tests/ttm_bo_validate_test.c
> index bb430763e7a52..6fc381a9d2da6 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_bo_validate_test.c
> @@ -637,7 +637,7 @@ static void ttm_bo_validate_no_placement_not_signaled=
(struct kunit *test)
>  	KUNIT_EXPECT_EQ(test, ctx.bytes_moved, 0);
> =20
>  	if (bo->type !=3D ttm_bo_type_sg)
> -		KUNIT_ASSERT_PTR_EQ(test, bo->base.resv, &bo->base._resv);
> +		KUNIT_ASSERT_PTR_EQ(test, bo->base.resv, &bo->individual_resv);

[Severity: Medium]
Can this compile cleanly or pass at runtime?

The variable bo->individual_resv is now a pointer to struct dma_resv. By
using the address-of operator here, this assertion attempts to compare a
struct dma_resv pointer with a double pointer, which will unconditionally
fail the test and break the KUnit suite.

[ ... ]

> diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_=
bo_util.c
> index af5732f9e489e..7457a16b744f5 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_util.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
> @@ -207,7 +207,7 @@ static void ttm_transfered_destroy(struct ttm_buffer_=
object *bo)
>  	struct ttm_transfer_obj *fbo;
> =20
>  	fbo =3D container_of(bo, struct ttm_transfer_obj, base);
> -	dma_resv_put(&fbo->base.base._resv);
> +	dma_resv_put(fbo->base.individual_resv);
>  	ttm_bo_put(fbo->bo);
>  	kfree(fbo);
>  }

[Severity: High]
Does this code permanently leak the dma_resv object dynamically allocated
for a ghost object?

In ttm_buffer_object_transfer(), the ghost object acquires an extra referen=
ce
to fbo->base.base.resv:

fbo->base.individual_resv =3D dma_resv_alloc();
...
fbo->base.base.resv =3D dma_resv_get(fbo->base.individual_resv);

However, when the ghost object is destroyed, ttm_bo_release() sets
bo->individual_resv to NULL before calling the destroyer callback. As a
result, when ttm_transfered_destroy() calls
dma_resv_put(fbo->base.individual_resv), it is operating on a NULL pointer.
This leaves the reference on the base GEM dma_resv unreleased, causing a
memory leak during buffer evictions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827124910.2245=
-1-christian.koenig@amd.com?part=3D5
