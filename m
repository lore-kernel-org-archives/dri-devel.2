Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB158C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 11:37:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B360110F2D6;
	Thu, 13 Aug 2026 11:37:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JCQihjpe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B2A10F2D6
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 11:37:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DBF540DEC;
 Thu, 13 Aug 2026 11:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1031F000E9;
 Thu, 13 Aug 2026 11:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786621032;
 bh=tOjBQ56EugzGusqth8E0PlQBi7s+A3YCbbI08tTp1gE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JCQihjpe85He5r9yKJ9XpQVrEWtZBIABK99kY05SFgQc+AH7H0H4p/Q7ue48BX37M
 2taeUIG4TfVfEE9T6IYn4UhUovZ86Ini21/o3GNushI2LVq2SxmYmI5JX5JHRw5oKo
 2hGN9aUop6bT2LoqLv/JczYL6WnpU6dTFIyOx08YH9+3Ll4XQnjDOEfHDq29tY5UTN
 oj14fsIkLkBhClfIzVt73WIKRmLyVbK/bThDk4G+RYKcz2BVsZw9um7r5R7KJk91ns
 SCTm/vlwNiIh5A0scXj/dBXr7yVCYnQyHxh3rEcRDzSQ676s+OOabBYWdL84+9Jdc6
 kfZi0kAWS6JdA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/17] drm/panthor: Split panthor_vm
To: "Boris Brezillon" <boris.brezillon@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813-panthor-unplug-fixes-v3-8-3ed4e961bbe7@collabora.com>
References: <20260813-panthor-unplug-fixes-v3-0-3ed4e961bbe7@collabora.com>
 <20260813-panthor-unplug-fixes-v3-8-3ed4e961bbe7@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 11:37:11 +0000
Message-Id: <20260813113712.3D1031F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Premature removal of the AS from the reclaim list allows it to be =
re-added concurrently, leading to a Use-After-Free when the AS is subsequen=
tly freed.

Pre-existing issues:
- [High] If a VM is released concurrently with device unplug, the hardware =
MMU slot is left enabled and pointing to freed page tables.
--

--- Patch [8]: [PATCH v3 08/17] drm/panthor: Split panthor_vm ---
commit 7c73a792e45cba201c66a596be6469687f3cb78d
Author: Boris Brezillon <boris.brezillon@collabora.com>
Subject: drm/panthor: Split panthor_vm

This commit splits the panthor_vm object into panthor_vm and panthor_as
to manage address spaces and page table residency separately. This prepares
the cleanup logic for future unplug robustness improvements.

> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 6c48e88ad17fb..0418365529538 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c

[ ... ]

> @@ -2031,15 +2044,23 @@ void panthor_mmu_post_reset(struct panthor_device=
 *ptdev)
>  	mutex_unlock(&ptdev->mmu->vm.lock);
>  }
> =20
> -static void panthor_vm_free(struct drm_gpuvm *gpuvm)
> +static void panthor_vm_release(struct kref *kref)
>  {
> -	struct panthor_vm *vm =3D container_of(gpuvm, struct panthor_vm, base);
> -	struct panthor_device *ptdev =3D vm->ptdev;
> +	struct panthor_vm *vm =3D container_of(kref, struct panthor_vm, refcoun=
t);
> +	struct panthor_as *as =3D vm->as;
> +	struct panthor_device *ptdev =3D container_of(as->base.drm, struct pant=
hor_device, base);
> =20
> +	/* Make sure the page table behind this VM doesn't participate in recla=
im
> +	 * after that point, since we're about to release everything anyway.
> +	 */
>  	mutex_lock(&ptdev->base.gem_lru_mutex);
> -	list_del_init(&vm->reclaim.lru_node);
> +	list_del_init(&as->reclaim.lru_node);
>  	mutex_unlock(&ptdev->base.gem_lru_mutex);
> =20
> +	/* Unmap everything in case some BOs were still mapped. */
> +	drm_WARN_ON(&ptdev->base,
> +		    panthor_vm_unmap_range(vm, as->base.mm_start, as->base.mm_range));
> +

[Severity: High]
Can this cause a use-after-free if another thread modifies a shared BO's
reclaim state?=20

Because the AS is removed from the reclaim list before its BO mappings are
unmapped, couldn't a concurrent call to
panthor_vm_update_bo_reclaim_lru_locked() see the empty list node and re-add
the AS to ptdev->reclaim.vms?=20

Once panthor_as_free() executes later, the AS would be freed while it is
still linked in the global reclaim list.

>  	mutex_lock(&vm->heaps.lock);
>  	if (drm_WARN_ON(&ptdev->base, vm->heaps.pool))
>  		panthor_heap_pool_destroy(vm->heaps.pool);
> @@ -2060,29 +2081,26 @@ static void panthor_vm_free(struct drm_gpuvm *gpu=
vm)
>  	drm_sched_entity_destroy(&vm->entity);
>  	drm_sched_fini(&vm->sched);
> =20
> -	mutex_lock(&vm->op_lock);
> +	mutex_lock(&vm->as->op_lock);
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
> -	if (vm->as.id >=3D 0) {
> +	if (as->hw_slot.id >=3D 0) {
>  		int cookie;
> =20
>  		if (drm_dev_enter(&ptdev->base, &cookie)) {
> -			panthor_mmu_as_disable(ptdev, vm->as.id, false);
> +			panthor_mmu_as_disable(ptdev, as->hw_slot.id, false);
>  			drm_dev_exit(cookie);
>  		}
> =20
> -		ptdev->mmu->as.slots[vm->as.id].vm =3D NULL;
> -		clear_bit(vm->as.id, &ptdev->mmu->as.alloc_mask);
> -		list_del(&vm->as.lru_node);
> +		panthor_as_release_hw_slot_locked(as);
>  	}
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);

[Severity: High]
This is a pre-existing issue, but what happens to the hardware MMU slot if
drm_dev_enter() fails during an unplug?

It looks like the code skips panthor_mmu_as_disable() but still calls
panthor_as_release_hw_slot_locked(as) directly below it.

If the slot tracking is cleared here, won't panthor_mmu_unplug() also skip
disabling the slot because it appears unused, leaving the GPU MMU active on
freed page tables?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-panthor-un=
plug-fixes-v3-0-3ed4e961bbe7@collabora.com?part=3D8
