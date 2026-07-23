Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A2AC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C4F10F097;
	Thu, 23 Jul 2026 10:31:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96DBD10F08C
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:31:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E18440BF5;
 Thu, 23 Jul 2026 10:31:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE181F000E9;
 Thu, 23 Jul 2026 10:31:40 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/6] drm/ttm: Hook up a cgroup-aware reclaim callback
 for the dmem controller
To: =?utf-8?b?VGhvbWFzIEhlbGxzdHLDtm0=?= <thomas.hellstrom@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, tj@kernel.org, mkoutny@suse.com,
 hannes@cmpxchg.org
In-Reply-To: <20260723100350.16895-5-thomas.hellstrom@linux.intel.com>
References: <20260723100350.16895-1-thomas.hellstrom@linux.intel.com>
 <20260723100350.16895-5-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 10:31:30 +0000
Message-Id: <20260723103140.DCE181F000E9@smtp.kernel.org>
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
- [High] ttm_resource_manager_set_dmem_region(man, NULL) fails to prevent a=
 Use-After-Free in the reclaim callback when the dmem region outlives the r=
esource manager.
- [High] AMDGPU's eviction_valuable callback dereferences the `place` point=
er without checking for NULL, which crashes during cgroup reclaim.
- [High] Incorrect check in `ttm_resource_free()` causes cgroup charge leak=
s when a region is detached, or potential crashes when a region is attached=
 post-allocation.
--

--- Patch [4]: [PATCH v8 4/6] drm/ttm: Hook up a cgroup-aware reclaim callb=
ack for the dmem controller ---
commit 2a3c858c74bfd2816b989356ca73920f98d725df
Author: Thomas Hellstr=C3=B6m <thomas.hellstrom@linux.intel.com>
Subject: drm/ttm: Hook up a cgroup-aware reclaim callback for the dmem cont=
roller

This commit introduces a cgroup-aware reclaim callback for the TTM dmem
controller to evict buffer objects based on cgroup pools. It adds a new
sleeping lock mode for the LRU walker and provides functions to associate
dmem regions with resource managers.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> --- a/drivers/gpu/drm/ttm/ttm_bo.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
[ ... ]
> @@ -515,12 +515,20 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *wal=
k, struct ttm_buffer_object *
[ ... ]
> +	/*
> +	 * evict_walk->place is NULL in cgroup drain mode.  Drivers'
> +	 * eviction_valuable() callbacks must handle a NULL place, treating it
> +	 * as "any placement": the TTM base implementation already does so via
> +	 * ttm_resource_intersects().
> +	 */
>  	if (bo->pin_count || !bo->bdev->funcs->eviction_valuable(bo, evict_walk=
->place))
>  		return 0;

[Severity: High]
Will this crash in AMDGPU when it evaluates KFD fences?

While the TTM base implementation handles a NULL place, the AMDGPU
implementation does not seem to do so. In amdgpu_ttm_bo_eviction_valuable(),
the place pointer is unconditionally dereferenced:

amdgpu_ttm_bo_eviction_valuable()
	if (amdkfd_fence_check_mm(f, current->mm) &&
	    !(place->flags & TTM_PL_FLAG_CONTIGUOUS))
		return false;

Does the driver callback need to be updated to handle the NULL place during
cgroup drain, or should TTM provide a dummy place?

[ ... ]
> diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm=
_resource.c
> --- a/drivers/gpu/drm/ttm/ttm_resource.c
> +++ b/drivers/gpu/drm/ttm/ttm_resource.c
[ ... ]
> @@ -953,3 +953,55 @@ void ttm_resource_manager_create_debugfs(struct ttm_=
resource_manager *man,
[ ... ]
> +void ttm_resource_manager_set_dmem_region(struct ttm_resource_manager *m=
an,
> +					  struct dmem_cgroup_region *region)
> +{
> +	if (!IS_ERR(region))
> +		man->cg =3D region;

[Severity: High]
Does setting the region to NULL properly detach the reclaim callback?

When ttm_resource_manager_set_dmem_region() is called with a NULL region to
detach it before teardown, it clears man->cg, but it doesn't appear to
unregister the callback from the cgroup region. If the manager is destroyed
before the region, could background reclaim or sysfs writes to dmem.max
invoke the callback with a dangling priv pointer?

Additionally, can modifying man->cg here cause cgroup charge leaks when
resources are freed?

Looking at ttm_resource_free(), the uncharge path checks man->cg instead of
the resource's pool:

ttm_resource_free()
	pool =3D (*res)->css;
	man =3D ttm_manager_type(bo->bdev, (*res)->mem_type);
	man->func->free(man, *res);
	*res =3D NULL;
	if (man->cg)
		dmem_cgroup_uncharge(pool, bo->base.size);

If a region is detached (man->cg becomes NULL) after a resource was
allocated, it skips uncharging a valid pool pointer, permanently leaking the
charge. Conversely, if man->cg is attached after allocation (so pool is
NULL), it might call dmem_cgroup_uncharge() with a NULL pool.

Should ttm_resource_free() check if the resource itself has a valid css pool
rather than checking man->cg?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723100350.1689=
5-1-thomas.hellstrom@linux.intel.com?part=3D4
