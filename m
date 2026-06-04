Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88846CD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FA910E5F5;
	Thu,  4 Jun 2026 09:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EF51F3GF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36B010E5FC;
 Thu,  4 Jun 2026 09:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780566635; x=1812102635;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ll8drnyeBryf4kDN3u8tWRIODiDKyXfp2y05shUFQSc=;
 b=EF51F3GFXecnIoDywZhf0pRt9gQSPTB4e+ie68fx+HHgppxRpd8Z/BYL
 oo9BIvP4FzQILiQs2xKKBErlSf0U/bh8l0MQpqYoZqM7batTmizLODWDr
 XPgP5rKqroOOufTnT32WOtdl/ljlxF7ni918LgifAWlde9hZnVuEvgnxB
 HA5zCyNlMhu8maukZLwp9OHnVDxS3jXAQ1z2gQE1xJZee25spLmf+t+fj
 Xp+W0P92i7lut3m2nxHKgVRG8Zlie0cVGbklztJ7nU/AAS9U2S1gBmO1M
 paUh+cjaQj6jmDKmp+176FI7YmtJcKhGx22tNECxuNNjFPk65KgFxIIVt A==;
X-CSE-ConnectionGUID: 5HDjUsBlRw6gqKCPYcaqXg==
X-CSE-MsgGUID: P7lP3I/IRKqeIuj7oezJFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98810524"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="98810524"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:35 -0700
X-CSE-ConnectionGUID: 65DltthZTyeggHwZRnJxRw==
X-CSE-MsgGUID: hN8qikISRtm0aAIj4cSzAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="282602377"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:32 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com
Subject: [RFC v3 4/7] drm/xe/vm: Add madvise autoreset notifier worker
Date: Thu,  4 Jun 2026 15:20:09 +0530
Message-ID: <20260604095012.367231-5-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095012.367231-1-arvind.yadav@intel.com>
References: <20260604095012.367231-1-arvind.yadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Reset madvise-managed VMA attributes when userspace unmaps CPU-only
mirror ranges.

The MMU notifier callback cannot take vm->lock and does not allocate.
It records a pending range in the preallocated notifier and queues the
embedded worker.

If multiple unmap events arrive before the worker runs, the pending range
is widened. The worker then walks the CPU mm and resets only real holes,
leaving ranges still covered by a CPU VMA unchanged.

Use a maple tree for range lookup and a VM-owned list for notifier
lifetime, so teardown does not depend on maple-tree entries.

v2:
  - Replace closing state with teardown_rwsem. (Matt)
  - Use maple_tree for notifier tracking. (Matt)
  - Embed work_struct in notifier; no allocation in callback. (Thomas)
  - Coalesce overlapping munmap events via min/max.
  - Run notifier removal and workqueue drain outside teardown_rwsem. (Matt)

v3:
  - Keep a VM-owned notifier list for teardown.
  - Widen pending ranges in the callback and reset only CPU holes in the worker.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_vm_madvise.c | 504 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_vm_madvise.h |   8 +
 drivers/gpu/drm/xe/xe_vm_types.h   |  61 ++++
 3 files changed, 573 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index c4fb29004195..c2abe712598a 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -6,6 +6,8 @@
 #include "xe_vm_madvise.h"
 
 #include <linux/nospec.h>
+#include <linux/maple_tree.h>
+#include <linux/workqueue.h>
 #include <drm/xe_drm.h>
 
 #include "xe_bo.h"
@@ -14,6 +16,10 @@
 #include "xe_svm.h"
 #include "xe_tlb_inval.h"
 #include "xe_vm.h"
+#include "xe_macros.h"
+
+/* Lockdep class for teardown_rwsem */
+static struct lock_class_key xe_madvise_teardown_key;
 
 struct xe_vmas_in_madvise_range {
 	u64 addr;
@@ -732,3 +738,501 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data, struct drm_file *fil
 	xe_vm_put(vm);
 	return err;
 }
+
+/**
+ * xe_vma_reset_to_default_attrs - Reset madvise attrs to defaults
+ * @vma: VMA to reset
+ */
+static void xe_vma_reset_to_default_attrs(struct xe_vma *vma)
+{
+	struct xe_vma_mem_attr default_attr = {
+		.preferred_loc.devmem_fd = DRM_XE_PREFERRED_LOC_DEFAULT_DEVICE,
+		.preferred_loc.migration_policy = DRM_XE_MIGRATE_ALL_PAGES,
+		.default_pat_index = vma->attr.default_pat_index,
+		.pat_index = vma->attr.default_pat_index,
+		.atomic_access = DRM_XE_ATOMIC_UNDEFINED,
+		.purgeable_state = XE_MADV_PURGEABLE_WILLNEED,
+	};
+
+	xe_vma_mem_attr_copy(&vma->attr, &default_attr);
+}
+
+/**
+ * xe_vm_madvise_process_unmap - Reset attrs for a GPUVA range
+ * @vm: VM
+ * @start: start of range
+ * @end: end of range
+ *
+ * Process CPU-only VMAs overlapping [@start, @end).
+ *
+ * Return: 0 on success, negative error otherwise.
+ */
+static int xe_vm_madvise_process_unmap(struct xe_vm *vm, u64 start, u64 end)
+{
+	u64 addr = start;
+	int err;
+
+	lockdep_assert_held_write(&vm->lock);
+
+	if (xe_vm_is_closed_or_banned(vm))
+		return 0;
+
+	while (addr < end) {
+		struct xe_vma *vma;
+		u64 seg_start, seg_end;
+		bool has_default_attr;
+
+		vma = xe_vm_find_overlapping_vma(vm, addr, end - addr);
+		if (!vma)
+			break;
+
+		/* GPU-touched VMAs are handled by SVM. */
+		if (!xe_vma_has_cpu_autoreset_active(vma)) {
+			addr = xe_vma_end(vma);
+			continue;
+		}
+
+		has_default_attr = xe_vma_has_default_mem_attrs(vma);
+		seg_start = max(addr, xe_vma_start(vma));
+		seg_end = min(end, xe_vma_end(vma));
+
+		/* Merge adjacent default-attr VMAs when possible. */
+		if (has_default_attr &&
+		    xe_vma_start(vma) >= start &&
+		    xe_vma_end(vma) <= end) {
+			seg_start = xe_vma_start(vma);
+			seg_end = xe_vma_end(vma);
+			xe_vm_find_cpu_addr_mirror_vma_range(vm, &seg_start, &seg_end);
+			if (xe_vma_start(vma) == seg_start && xe_vma_end(vma) == seg_end) {
+				/* Nothing to merge. */
+				addr = seg_end;
+				continue;
+			}
+		} else if (xe_vma_start(vma) == seg_start && xe_vma_end(vma) == seg_end) {
+			/* Exact VMA match, reset in place. */
+			xe_vma_reset_to_default_attrs(vma);
+			addr = seg_end;
+			continue;
+		}
+
+		err = xe_vm_alloc_cpu_addr_mirror_vma(vm, seg_start, seg_end - seg_start);
+		if (err) {
+			if (err == -ENOENT) {
+				/* VMA was removed before the worker ran. */
+				addr = seg_end;
+				continue;
+			}
+			return err;
+		}
+
+		addr = seg_end;
+	}
+
+	return 0;
+}
+
+/**
+ * xe_vm_madvise_process_unmap_holes - Reset attrs for CPU holes
+ * @vm: VM
+ * @mm: mm backing the CPU mirror
+ * @start: start of the pending interval
+ * @end: end of the pending interval
+ *
+ * Walk [@start, @end) and process only ranges not covered by a CPU VMA.
+ * Mapped ranges are skipped so partial-unmap siblings keep their attrs.
+ *
+ * Caller must hold vm->lock for write and mmap_read_lock(@mm).
+ *
+ * Return: 0 on success, negative error otherwise.
+ */
+static int xe_vm_madvise_process_unmap_holes(struct xe_vm *vm,
+					     struct mm_struct *mm,
+					     u64 start, u64 end)
+{
+	u64 addr = start;
+
+	lockdep_assert_held_write(&vm->lock);
+	mmap_assert_locked(mm);
+
+	while (addr < end) {
+		struct vm_area_struct *cpu_vma;
+		u64 hole_start, hole_end;
+		int err;
+
+		cpu_vma = find_vma(mm, addr);
+
+		if (cpu_vma && cpu_vma->vm_start <= addr) {
+			addr = min_t(u64, cpu_vma->vm_end, end);
+			continue;
+		}
+
+		hole_start = addr;
+		hole_end = cpu_vma ? min_t(u64, cpu_vma->vm_start, end) : end;
+
+		err = xe_vm_madvise_process_unmap(vm, hole_start, hole_end);
+		if (err)
+			return err;
+
+		addr = hole_end;
+	}
+
+	return 0;
+}
+
+/**
+ * xe_madvise_work_func - Worker to process pending unmap events
+ * @w: work_struct embedded in xe_madvise_notifier
+ *
+ * Drains pending intervals recorded by the callback. The worker loops so
+ * events queued while it is running are not lost.
+ */
+static void xe_madvise_work_func(struct work_struct *w)
+{
+	struct xe_madvise_notifier *notifier =
+		container_of(w, struct xe_madvise_notifier, work);
+	struct xe_vm *vm = notifier->vm;
+
+	for (;;) {
+		struct mm_struct *mm;
+		u64 start, end;
+		int err;
+
+		spin_lock(&notifier->work_lock);
+		if (!notifier->work_pending) {
+			spin_unlock(&notifier->work_lock);
+			break;
+		}
+		start = notifier->work_start;
+		end = notifier->work_end;
+		notifier->work_pending = false;
+		spin_unlock(&notifier->work_lock);
+
+		/* The mm is going away, teardown will clean up. */
+		mm = vm->svm.gpusvm.mm;
+		if (!mm || !mmget_not_zero(mm))
+			break;
+
+		down_write(&vm->lock);
+		mmap_read_lock(mm);
+
+		err = xe_vm_madvise_process_unmap_holes(vm, mm, start, end);
+
+		mmap_read_unlock(mm);
+		up_write(&vm->lock);
+		mmput(mm);
+
+		if (err)
+			drm_warn(&vm->xe->drm,
+				 "madvise autoreset failed [%#llx-%#llx]: %d\n",
+				 start, end, err);
+	}
+}
+
+/**
+ * xe_madvise_notifier_callback - MMU notifier callback for CPU munmap
+ * @mni: mmu_interval_notifier
+ * @range: mmu_notifier_range
+ * @cur_seq: current sequence number
+ *
+ * Records one pending interval without allocating. Later events widen it.
+ * The worker checks the CPU mm before resetting attributes.
+ *
+ * Return: false for non-blockable invalidations, true otherwise.
+ */
+static bool xe_madvise_notifier_callback(struct mmu_interval_notifier *mni,
+					 const struct mmu_notifier_range *range,
+					 unsigned long cur_seq)
+{
+	struct xe_madvise_notifier *notifier =
+		container_of(mni, struct xe_madvise_notifier, mmu_notifier);
+	struct xe_vm *vm = notifier->vm;
+	u64 adj_start, adj_end;
+
+	if (range->event != MMU_NOTIFY_UNMAP)
+		return true;
+
+	if (!mmu_notifier_range_blockable(range))
+		return false;
+
+	if (xe_vm_is_closed(vm))
+		return true;
+
+	mmu_interval_set_seq(mni, cur_seq);
+
+	/* Clamp to notifier boundaries and ignore non-overlap. */
+	adj_start = max_t(u64, range->start, notifier->vma_start);
+	adj_end = min_t(u64, range->end, notifier->vma_end);
+
+	if (adj_start >= adj_end)
+		return true;
+
+	/* Bail if teardown started; trylock fails once fini holds write. */
+	if (!down_read_trylock(&vm->svm.madvise_work.teardown_rwsem))
+		return true;
+
+	/* fini may have NULLed wq before we got here; check under read lock. */
+	if (!vm->svm.madvise_work.wq)
+		goto out;
+
+	spin_lock(&notifier->work_lock);
+	if (notifier->work_pending) {
+		/*
+		 * Widen pending work. The worker only resets CPU holes,
+		 * so mapped siblings are left untouched.
+		 */
+		notifier->work_start = min(notifier->work_start, adj_start);
+		notifier->work_end = max(notifier->work_end, adj_end);
+	} else {
+		notifier->work_start = adj_start;
+		notifier->work_end = adj_end;
+		notifier->work_pending = true;
+	}
+	spin_unlock(&notifier->work_lock);
+
+	queue_work(vm->svm.madvise_work.wq, &notifier->work);
+
+out:
+	up_read(&vm->svm.madvise_work.teardown_rwsem);
+	return true;
+}
+
+static const struct mmu_interval_notifier_ops xe_madvise_notifier_ops = {
+	.invalidate = xe_madvise_notifier_callback,
+};
+
+/**
+ * xe_vm_madvise_init - Initialize madvise notifier infrastructure
+ * @vm: VM
+ *
+ * Sets up workqueue for async munmap processing.
+ *
+ * Return: 0 on success, -ENOMEM on failure
+ */
+int xe_vm_madvise_init(struct xe_vm *vm)
+{
+	/* Already initialized. */
+	if (vm->svm.madvise_work.wq)
+		return 0;
+
+	mt_init(&vm->svm.madvise_notifiers);
+	INIT_LIST_HEAD(&vm->svm.madvise_notifier_list);
+
+	/* Separate class for notifier teardown. */
+	__init_rwsem(&vm->svm.madvise_work.teardown_rwsem,
+		     "xe_madvise_teardown", &xe_madvise_teardown_key);
+
+	/* Not used from reclaim paths. */
+	vm->svm.madvise_work.wq = alloc_workqueue("xe_madvise", WQ_UNBOUND, 0);
+	if (!vm->svm.madvise_work.wq) {
+		mtree_destroy(&vm->svm.madvise_notifiers);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void xe_madvise_notifier_free(struct xe_madvise_notifier *notifier)
+{
+	xe_vm_put(notifier->vm);
+	kfree(notifier);
+}
+
+static void xe_madvise_notifier_remove_and_free(struct xe_madvise_notifier *notifier)
+{
+	mmu_interval_notifier_remove(&notifier->mmu_notifier);
+	cancel_work_sync(&notifier->work);
+	xe_madvise_notifier_free(notifier);
+}
+
+static struct xe_madvise_notifier *
+xe_madvise_notifier_alloc(struct xe_vm *vm, u64 start, u64 end)
+{
+	struct xe_madvise_notifier *notifier;
+
+	notifier = kzalloc_obj(*notifier, GFP_KERNEL);
+	if (!notifier)
+		return NULL;
+
+	notifier->vm = xe_vm_get(vm);
+	notifier->vma_start = start;
+	notifier->vma_end = end;
+	INIT_LIST_HEAD(&notifier->link);
+	spin_lock_init(&notifier->work_lock);
+	notifier->work_pending = false;
+	INIT_WORK(&notifier->work, xe_madvise_work_func);
+
+	return notifier;
+}
+
+static bool xe_madvise_notifier_exact(const struct xe_madvise_notifier *notifier,
+				      u64 start, u64 end)
+{
+	return notifier->vma_start == start && notifier->vma_end == end;
+}
+
+static bool xe_madvise_notifier_fully_covered(const struct xe_madvise_notifier *notifier,
+					      u64 start, u64 end)
+{
+	/*
+	 * Broader notifiers may still cover split siblings, so only remove
+	 * notifiers fully covered by the new range.
+	 */
+	return notifier->vma_start >= start && notifier->vma_end <= end;
+}
+
+/**
+ * xe_vm_madvise_fini - Cleanup all madvise notifiers
+ * @vm: VM
+ *
+ * Tears down notifiers and drains workqueue. Safe if init partially failed.
+ */
+void xe_vm_madvise_fini(struct xe_vm *vm)
+{
+	struct xe_madvise_notifier *notifier, *next;
+	struct workqueue_struct *wq;
+	LIST_HEAD(tmp);
+
+	/* Nothing to do if init never ran. */
+	if (!vm->svm.madvise_work.wq)
+		return;
+
+	/* Block new callbacks. */
+	down_write(&vm->svm.madvise_work.teardown_rwsem);
+
+	/* Stage all owned notifiers from the VM list. */
+	list_for_each_entry_safe(notifier, next,
+				 &vm->svm.madvise_notifier_list, link) {
+		list_del_init(&notifier->link);
+		list_add_tail(&notifier->link, &tmp);
+	}
+
+	/* VM is closed; safe to destroy the tree. */
+	mtree_destroy(&vm->svm.madvise_notifiers);
+
+	/* NULL wq so late callbacks bail. */
+	wq = vm->svm.madvise_work.wq;
+	vm->svm.madvise_work.wq = NULL;
+
+	up_write(&vm->svm.madvise_work.teardown_rwsem);
+
+	/*
+	 * Remove notifiers outside rwsem; remove() may block on mmap_lock.
+	 */
+	list_for_each_entry(notifier, &tmp, link)
+		mmu_interval_notifier_remove(&notifier->mmu_notifier);
+
+	/* Drain work before freeing; workers reference notifier via container_of. */
+	if (wq) {
+		drain_workqueue(wq);
+		destroy_workqueue(wq);
+	}
+
+	/* Safe to free now: no callbacks can fire, no workers are running. */
+	list_for_each_entry_safe(notifier, next, &tmp, link) {
+		list_del(&notifier->link);
+		xe_madvise_notifier_free(notifier);
+	}
+}
+
+/**
+ * xe_vm_madvise_register_notifier_range - Register MMU notifier for address range
+ * @vm: VM
+ * @start: Start address (page-aligned)
+ * @end: End address (page-aligned)
+ *
+ * Registers interval notifier for munmap tracking. Uses addresses (not VMA pointers)
+ * to avoid UAF after dropping vm->lock. Deduplicates by range.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int xe_vm_madvise_register_notifier_range(struct xe_vm *vm, u64 start, u64 end)
+{
+	struct xe_madvise_notifier *notifier, *old, *tmp;
+	struct xe_madvise_notifier *existing;
+	LIST_HEAD(displaced);
+	int err;
+
+	if (!IS_ALIGNED(start, PAGE_SIZE) || !IS_ALIGNED(end, PAGE_SIZE))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(end <= start))
+		return -EINVAL;
+
+	if (!vm->svm.gpusvm.mm)
+		return -EINVAL;
+
+	notifier = xe_madvise_notifier_alloc(vm, start, end);
+	if (!notifier)
+		return -ENOMEM;
+
+	/* Insert before vm->lock, this may take mmap_lock. */
+	err = mmu_interval_notifier_insert(&notifier->mmu_notifier,
+					   vm->svm.gpusvm.mm,
+					   start, end - start,
+					   &xe_madvise_notifier_ops);
+	if (err) {
+		xe_madvise_notifier_free(notifier);
+		return err;
+	}
+
+	/* Dedup and store under vm->lock. */
+	down_write(&vm->lock);
+
+	if (xe_vm_is_closed_or_banned(vm)) {
+		err = -ENOENT;
+		goto unlock_remove_new;
+	}
+
+	/* Dedup by stored range; tree slots can be fragmented by partial overlap. */
+	list_for_each_entry(existing, &vm->svm.madvise_notifier_list, link) {
+		if (xe_madvise_notifier_exact(existing, start, end)) {
+			err = 0;
+			goto unlock_remove_new;
+		}
+	}
+
+	/*
+	 * Store first. The VM list owns notifier lifetime, so there is
+	 * nothing to restore on failure.
+	 */
+	err = mtree_store_range(&vm->svm.madvise_notifiers, start, end - 1,
+				notifier, GFP_KERNEL);
+	if (err)
+		goto unlock_remove_new;
+
+	/* Keep the new notifier reachable for teardown. */
+	list_add_tail(&notifier->link, &vm->svm.madvise_notifier_list);
+
+	/*
+	 * Drop fully covered old notifiers. Broader notifiers may still cover
+	 * split siblings, so leave them alive.
+	 */
+	list_for_each_entry_safe(old, tmp, &vm->svm.madvise_notifier_list, link) {
+		if (old == notifier)
+			continue;
+		if (!xe_madvise_notifier_fully_covered(old, start, end))
+			continue;
+
+		list_del_init(&old->link);
+		list_add(&old->link, &displaced);
+	}
+
+	up_write(&vm->lock);
+
+	/*
+	 * Remove outside vm->lock. remove_and_free() drains callbacks and
+	 * work before freeing the notifier.
+	 */
+	list_for_each_entry_safe(old, tmp, &displaced, link) {
+		list_del_init(&old->link);
+		xe_madvise_notifier_remove_and_free(old);
+	}
+
+	return 0;
+
+unlock_remove_new:
+	up_write(&vm->lock);
+	xe_madvise_notifier_remove_and_free(notifier);
+
+	return err;
+}
diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.h b/drivers/gpu/drm/xe/xe_vm_madvise.h
index a3078f634c7e..e2013605e190 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.h
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.h
@@ -6,11 +6,19 @@
 #ifndef _XE_VM_MADVISE_H_
 #define _XE_VM_MADVISE_H_
 
+#include <linux/types.h>
+
 struct drm_device;
 struct drm_file;
 struct xe_bo;
+struct xe_vm;
+struct xe_vma;
 
 int xe_vm_madvise_ioctl(struct drm_device *dev, void *data,
 			struct drm_file *file);
 
+int xe_vm_madvise_init(struct xe_vm *vm);
+void xe_vm_madvise_fini(struct xe_vm *vm);
+int xe_vm_madvise_register_notifier_range(struct xe_vm *vm, u64 start, u64 end);
+
 #endif
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index e6380458272e..d47bc338628d 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -12,6 +12,7 @@
 
 #include <linux/dma-resv.h>
 #include <linux/kref.h>
+#include <linux/maple_tree.h>
 #include <linux/mmu_notifier.h>
 #include <linux/scatterlist.h>
 
@@ -31,6 +32,36 @@ struct xe_user_fence;
 struct xe_vm;
 struct xe_vm_pgtable_update_op;
 
+/**
+ * struct xe_madvise_notifier - MMU notifier for madvise autoreset
+ *
+ * Tracks CPU munmap on CPU mirror VMAs and queues work to reset attrs.
+ * The callback stores one widened interval without allocating. The worker
+ * walks the CPU mm and resets only holes inside that interval.
+ */
+struct xe_madvise_notifier {
+	/** @mmu_notifier: MMU interval notifier */
+	struct mmu_interval_notifier mmu_notifier;
+	/** @vm: VM this notifier belongs to (holds reference via xe_vm_get) */
+	struct xe_vm *vm;
+	/** @vma_start: Start address of VMA being tracked */
+	u64 vma_start;
+	/** @vma_end: End address of VMA being tracked */
+	u64 vma_end;
+	/** @link: Entry on vm->svm.madvise_notifier_list. */
+	struct list_head link;
+	/** @work_lock: Serialises pending interval state. */
+	spinlock_t work_lock;
+	/** @work_pending: Pending interval is available for the worker. */
+	bool work_pending;
+	/** @work_start: Start of the pending interval. */
+	u64 work_start;
+	/** @work_end: End of the pending interval. */
+	u64 work_end;
+	/** @work: Work item queued on CPU munmap. */
+	struct work_struct work;
+};
+
 #if IS_ENABLED(CONFIG_DRM_XE_DEBUG)
 #define TEST_VM_OPS_ERROR
 #define FORCE_OP_ERROR	BIT(31)
@@ -248,6 +279,36 @@ struct xe_vm {
 		struct xe_pagemap *pagemaps[XE_MAX_TILES_PER_DEVICE];
 		/** @svm.peer: Used for pagemap connectivity computations. */
 		struct drm_pagemap_peer peer;
+
+		/**
+		 * @svm.madvise_notifiers: Active madvise notifiers, keyed by
+		 * [vma_start, vma_end - 1]. The maple tree uses its own internal
+		 * spinlock for data integrity. Insertions happen under vm->lock
+		 * write; teardown is serialized by teardown_rwsem write.
+		 */
+		struct maple_tree madvise_notifiers;
+
+		/**
+		 * @svm.madvise_notifier_list: VM-owned list of all madvise notifiers.
+		 *
+		 * The maple tree is only a lookup index. Teardown walks this list.
+		 * Protected by vm->lock.
+		 */
+		struct list_head madvise_notifier_list;
+
+		/** @svm.madvise_work: Workqueue for async munmap processing */
+		struct {
+			/** @svm.madvise_work.wq: Workqueue */
+			struct workqueue_struct *wq;
+
+			/**
+			 * @svm.madvise_work.teardown_rwsem: Guards VM teardown.
+			 *
+			 * Callbacks take read via trylock; fini takes write.
+			 * A failed trylock means teardown started; bail immediately.
+			 */
+			struct rw_semaphore teardown_rwsem;
+		} madvise_work;
 	} svm;
 
 	struct xe_device *xe;
-- 
2.43.0

