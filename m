Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4800DC55ABF
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E5E010E99D;
	Tue,  4 Aug 2026 10:10:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="kuWSd9aG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C88010E99A
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785838200;
 bh=XaYyKv1F9ZM5pSCD5EAZxniq21grwW5GRmcaEWbO/70=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=kuWSd9aG/dXZvBkp7mEutnDeYVGTFNgVZK4CvebFiBwwg17K3pcoQQ/OBbA4BwoNi
 N532rwbRhod2LzbCyAwoN2VY5RmTbfBsjX3KKqP3B3XTXDwf/rN5/i8NZxNzYArrFY
 SuFLLmjMaJ/5fZdwV9lZSg1liGbRaQtzpUtUrWsZ8NnGfLlsl7oc/nGNWSMBgwj0rB
 THsR3FOiKZvjYSY3EaS36SRG7YGhTz0AjZBWuSN5vHr+gqHkA/hHmdhoOTCc7mUb9e
 h2dgTccTA9GufjZQzO3W76rVb4J1lbXXcy9F8eqwP0/EJpA3ptd+L7lhubT7H3Y4Pn
 B3qI4EngmzPtw==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A127717E1104;
 Tue, 04 Aug 2026 12:09:59 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 04 Aug 2026 12:09:49 +0200
Subject: [PATCH 10/12] drm/panthor: Make the VM cleanup path more robust
 against UAF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-panthor-unplug-fixes-v1-10-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
In-Reply-To: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785838194; l=10483;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=XaYyKv1F9ZM5pSCD5EAZxniq21grwW5GRmcaEWbO/70=;
 b=lVNksuBR5mrOjHCkfKLappJt8v7VUmCneys5C0TIPwMeFf2H9BIz27W34qbTnfp7tPAqGuatp
 lSLD0W8BW5+DZDdqpZtp5XTG9MZJParyHwj8VL6Kh0vsr4mTMS1BcbL
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The VM cleanup tries to gracefully evict the page table from its
AS slot to make sure the HW doesn't have access to the memory anymore.
But it might happen that the eviction fails because the HW hung, and
in that case, we have no guarantee that the HW won't access the memory
until we've properly reset the GPU.

Defer the cleanup of VMs after the reset is effective when this situation
happens.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 226 +++++++++++++++++++++++++---------
 1 file changed, 167 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 2ad8b15de0da..de242ff124ed 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -92,6 +92,17 @@ struct panthor_mmu {
 		 * TLB/cache flushes.
 		 */
 		struct list_head lru_list;
+
+		/**
+		 * @cleanup_list: List containing VMs waiting for cleanup.
+		 *
+		 * This list is used to keep track of VMs that got released but
+		 * couldn't be evicted from their AS slot because the HW hanged.
+		 * In that case, we add the VM to the list, and wait for the next
+		 * post_reset, at which point we're sure the HW is idle and the
+		 * VM resources can go away.
+		 */
+		struct list_head cleanup_list;
 	} as;
 
 	/** @vm: VMs management fields */
@@ -107,6 +118,12 @@ struct panthor_mmu {
 
 		/** @vm.wq: Workqueue used for the VM_BIND queues. */
 		struct workqueue_struct *wq;
+
+		/**
+		 * @vm.cleanup_work: Used to cleanup the VMs that are in
+		 * panthor_mmu::as::cleanup_list.
+		 */
+		struct work_struct cleanup_work;
 	} vm;
 };
 
@@ -2059,6 +2076,35 @@ void panthor_mmu_pre_reset(struct panthor_device *ptdev)
 	mutex_unlock(&ptdev->mmu->vm.lock);
 }
 
+static void mmu_post_reset_cleanup(struct panthor_device *ptdev, bool on_unplug)
+{
+	guard(mutex)(&ptdev->mmu->as.slots_lock);
+
+	/* Now that the reset is effective, we can assume that none of the
+	 * AS slots are setup, and clear the faulty flags too.
+	 */
+	ptdev->mmu->as.alloc_mask = 0;
+	ptdev->mmu->as.faulty_mask = 0;
+
+	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
+		struct panthor_as *as = ptdev->mmu->as.slots[i].as;
+
+		if (!as)
+			continue;
+
+		panthor_as_release_hw_slot_locked(as);
+
+		/* FIXME: We shouldn't drop the no-unmap restriction if
+		 * we're in the unplug path and the device wasn't properly
+		 * stopped with a SOFT_RESET.
+		 */
+		atomic_and(~PANTHOR_AS_FORBID_UNMAP, &as->restrictions);
+	}
+
+	if (!list_empty(&ptdev->mmu->as.cleanup_list))
+		queue_work(panthor_cleanup_wq, &ptdev->mmu->vm.cleanup_work);
+}
+
 /**
  * panthor_mmu_post_reset() - Restore things after a reset
  * @ptdev: Device.
@@ -2070,22 +2116,7 @@ void panthor_mmu_post_reset(struct panthor_device *ptdev)
 {
 	struct panthor_vm *vm;
 
-	mutex_lock(&ptdev->mmu->as.slots_lock);
-
-	/* Now that the reset is effective, we can assume that none of the
-	 * AS slots are setup, and clear the faulty flags too.
-	 */
-	ptdev->mmu->as.alloc_mask = 0;
-	ptdev->mmu->as.faulty_mask = 0;
-
-	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
-		struct panthor_as *as = ptdev->mmu->as.slots[i].as;
-
-		if (as)
-			panthor_as_release_hw_slot_locked(as);
-	}
-
-	mutex_unlock(&ptdev->mmu->as.slots_lock);
+	mmu_post_reset_cleanup(ptdev, false);
 
 	panthor_mmu_irq_resume(&ptdev->mmu->irq);
 
@@ -2098,58 +2129,26 @@ void panthor_mmu_post_reset(struct panthor_device *ptdev)
 	mutex_unlock(&ptdev->mmu->vm.lock);
 }
 
-static void panthor_vm_release(struct kref *kref)
+static void vm_cleanup(struct panthor_vm *vm)
 {
-	struct panthor_vm *vm = container_of(kref, struct panthor_vm, refcount);
 	struct panthor_as *as = vm->as;
 	struct panthor_device *ptdev = container_of(as->base.drm, struct panthor_device, base);
 
-	/* Make sure the page table behind this VM doesn't participate in reclaim
-	 * after that point, since we're about to release everything anyway.
-	 */
-	mutex_lock(&ptdev->base.gem_lru_mutex);
-	list_del_init(&as->reclaim.lru_node);
-	mutex_unlock(&ptdev->base.gem_lru_mutex);
+	if (!(atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_UNMAP)) {
+		/* Unmap everything in case some BOs were still mapped. */
+		drm_WARN_ON(&ptdev->base,
+			    panthor_vm_unmap_range(vm, as->base.mm_start, as->base.mm_range));
+	}
 
-	/* Unmap everything in case some BOs were still mapped. */
-	drm_WARN_ON(&ptdev->base,
-		    panthor_vm_unmap_range(vm, as->base.mm_start, as->base.mm_range));
-
-	mutex_lock(&vm->heaps.lock);
-	if (drm_WARN_ON(&ptdev->base, vm->heaps.pool))
-		panthor_heap_pool_destroy(vm->heaps.pool);
-	mutex_unlock(&vm->heaps.lock);
+	scoped_guard(mutex, &vm->heaps.lock) {
+		if (drm_WARN_ON(&ptdev->base, vm->heaps.pool))
+			panthor_heap_pool_destroy(vm->heaps.pool);
+	}
 	mutex_destroy(&vm->heaps.lock);
 
-	mutex_lock(&ptdev->mmu->vm.lock);
-	list_del(&vm->node);
-	/* Restore the scheduler state so we can call drm_sched_entity_destroy()
-	 * and drm_sched_fini(). If get there, that means we have no job left
-	 * and no new jobs can be queued, so we can start the scheduler without
-	 * risking interfering with the reset.
-	 */
-	if (ptdev->mmu->vm.reset_in_progress)
-		panthor_vm_start(vm);
-	mutex_unlock(&ptdev->mmu->vm.lock);
-
 	drm_sched_entity_destroy(&vm->entity);
 	drm_sched_fini(&vm->sched);
 
-	mutex_lock(&vm->as->op_lock);
-	mutex_lock(&ptdev->mmu->as.slots_lock);
-	if (as->hw_slot.id >= 0) {
-		int cookie;
-
-		if (drm_dev_enter(&ptdev->base, &cookie)) {
-			panthor_mmu_as_disable(ptdev, as->hw_slot.id, false);
-			drm_dev_exit(cookie);
-		}
-
-		panthor_as_release_hw_slot_locked(as);
-	}
-	mutex_unlock(&ptdev->mmu->as.slots_lock);
-	mutex_unlock(&vm->as->op_lock);
-
 	if (vm->dummy)
 		drm_gem_object_put(&vm->dummy->base);
 
@@ -2158,6 +2157,88 @@ static void panthor_vm_release(struct kref *kref)
 	kfree(vm);
 }
 
+static bool vm_prep_for_cleanup(struct panthor_vm *vm)
+{
+	struct panthor_as *as = vm->as;
+	struct panthor_device *ptdev = container_of(as->base.drm, struct panthor_device, base);
+	bool ready_for_cleanup;
+	int cookie, ret;
+
+	/* First we forbid any kind of use on the VM that's about to be
+	 * released. UNMAP will be restored later if we manage to evict
+	 * the page table from its AS slot.
+	 */
+	atomic_or(PANTHOR_AS_FORBID_USE |
+		  PANTHOR_AS_FORBID_MAP |
+		  PANTHOR_AS_FORBID_UNMAP,
+		  &vm->as->restrictions);
+
+	/* Make sure the page table behind this VM doesn't participate in reclaim
+	 * after that point, since we're about to release everything anyway.
+	 */
+	scoped_guard(mutex, &ptdev->base.gem_lru_mutex)
+		list_del_init(&as->reclaim.lru_node);
+
+	scoped_guard(mutex, &ptdev->mmu->vm.lock) {
+		/* Remove the VM from the list early, so it can't be seen by the VM list
+		 * walkers after that point.
+		 */
+		list_del(&vm->node);
+
+		/* Restore the scheduler state so we can call drm_sched_entity_destroy()
+		 * and drm_sched_fini(). If get there, that means we have no job left
+		 * and no new jobs can be queued, so we can start the scheduler without
+		 * risking interfering with the reset.
+		 */
+		if (ptdev->mmu->vm.reset_in_progress)
+			panthor_vm_start(vm);
+	}
+
+	if (!drm_dev_enter(&ptdev->base, &cookie)) {
+		guard(mutex)(&ptdev->mmu->as.slots_lock);
+
+		/* We're in the unplug path and can't recover from
+		 * that, so we just forcibly evict the pgtable. The
+		 * no-unmap restriction will leak resources if
+		 * we can't guarantee the HW stopped.
+		 */
+		if (as->hw_slot.id >= 0)
+			panthor_as_release_hw_slot_locked(as);
+
+		return true;
+	}
+
+	scoped_guard(mutex, &ptdev->mmu->as.slots_lock) {
+		if (as->hw_slot.id >= 0) {
+			ret = panthor_mmu_as_disable(ptdev, as->hw_slot.id, false);
+			if (!ret) {
+				panthor_as_release_hw_slot_locked(as);
+			} else {
+				list_add_tail(&vm->node, &ptdev->mmu->as.cleanup_list);
+				panthor_device_schedule_reset(ptdev);
+			}
+		}
+
+		/* Page table is no longer resident, we can relax the no-unmap
+		 * restriction.
+		 */
+		ready_for_cleanup = as->hw_slot.id < 0;
+		if (ready_for_cleanup)
+			atomic_and(~PANTHOR_AS_FORBID_UNMAP, &as->restrictions);
+	}
+
+	drm_dev_exit(cookie);
+	return ready_for_cleanup;
+}
+
+static void panthor_vm_release(struct kref *kref)
+{
+	struct panthor_vm *vm = container_of(kref, struct panthor_vm, refcount);
+
+	if (vm_prep_for_cleanup(vm))
+		vm_cleanup(vm);
+}
+
 /**
  * panthor_vm_put() - Release a reference on a VM
  * @vm: VM to release the reference on. Can be NULL.
@@ -2762,7 +2843,11 @@ static void panthor_as_free(struct drm_gpuvm *gpuvm)
 {
 	struct panthor_as *as = container_of(gpuvm, struct panthor_as, base);
 
-	if (as->pt.ops)
+	/* If we get to that point and we're still not allowed to unmap,
+	 * this means the HW is still running and has a access to the page
+	 * table, so we just leak it to avoid UAF.
+	 */
+	if (as->pt.ops && !(atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_UNMAP))
 		free_io_pgtable_ops(as->pt.ops);
 
 	mutex_destroy(&as->op_lock);
@@ -3488,6 +3573,27 @@ static void panthor_mmu_info_init(struct panthor_device *ptdev)
 	ptdev->mmu_info.page_size_bitmap = SZ_4K | SZ_2M;
 }
 
+static void mmu_cleanup_vms_work(struct work_struct *work)
+{
+	struct panthor_mmu *mmu =
+		container_of(work, struct panthor_mmu, vm.cleanup_work);
+	struct panthor_vm *vm, *tmp;
+	LIST_HEAD(cleanup_list);
+
+	/* Collect the VMs to cleanup first. */
+	scoped_guard(mutex, &mmu->as.slots_lock) {
+		list_for_each_entry_safe(vm, tmp, &mmu->as.cleanup_list, node) {
+			if (vm->as->hw_slot.id < 0)
+				list_move_tail(&vm->node, &cleanup_list);
+		}
+	}
+
+	list_for_each_entry_safe(vm, tmp, &cleanup_list, node) {
+		list_del(&vm->node);
+		vm_cleanup(vm);
+	}
+}
+
 /**
  * panthor_mmu_init() - Initialize the MMU logic.
  * @ptdev: Device.
@@ -3506,7 +3612,9 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 	if (!mmu)
 		return -ENOMEM;
 
+	INIT_WORK(&mmu->vm.cleanup_work, mmu_cleanup_vms_work);
 	INIT_LIST_HEAD(&mmu->as.lru_list);
+	INIT_LIST_HEAD(&mmu->as.cleanup_list);
 
 	ret = drmm_mutex_init(&ptdev->base, &mmu->as.slots_lock);
 	if (ret)

-- 
2.55.0

