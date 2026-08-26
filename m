Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB79C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 14:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35C9710ED32;
	Wed, 26 Aug 2026 14:57:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="d1fspJKq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7215110E2EA
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787756184;
 bh=G2achh0f3MYFtXE+WaiCZVFD2Pub02bvhe+Q/Id6CfA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=d1fspJKqnANWW+8tCF/Y+NWp+8/F6anFH4Qv3l5sD1yE9HilR0HeOdubQB59LMlMX
 UadFZPtG65XHh+qwcfAG6GELejOslqUqIhanJa/ZihIhCXtR8fIQzMfsCvgMSbySK0
 xRdURI+e3IO4Vjs9eRLoD7VsQaIWCOLktlNxoir+2gXFp1SYBI+v3FlnBpfbKtp72b
 qG+EzDopwILzHEeFeaDTy8HRuCuS/WFWhkA4GUw2N2yQbF2QOPvfdOX30EXtl5utND
 aaUUBGx9FFS840zpC8MyMBttMz1lbwMOo+CWakKNgN27AtnLbPWPAyXioa1JPksYkJ
 zSo6DcS8Znvug==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 76F8C17E1003;
 Wed, 26 Aug 2026 16:56:24 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, 26 Aug 2026 16:56:08 +0200
Subject: [PATCH v4 09/18] drm/panthor: Add fine-grained restrictions on VMs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-panthor-unplug-fixes-v4-9-982cc8f4234b@collabora.com>
References: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
In-Reply-To: <20260826-panthor-unplug-fixes-v4-0-982cc8f4234b@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Chris Diamand <chris.diamand@arm.com>, Akash Goel <akash.goel@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787756178; l=10100;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=G2achh0f3MYFtXE+WaiCZVFD2Pub02bvhe+Q/Id6CfA=;
 b=Aphkssgwi2rSkVf3X0wt6joYbuDaSUdXq02e9vQVDgHNWcGwte6unw6HEE5xstzQfTULchpCB
 k+pkkJkhTHPDTqzJZ1oD8Kwlu77Mnzskg0jWz9DILfydRBexZ4aEuSZ
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

We currently restrict what a VM is allowed to do based on two states:
panthor_vm::destroyed and panthor_vm_pgtable::unusable, but we'll soon
need a no-unmap restriction to fix the unplug logic.

Instead of adding a third boolean that would reflect this new limitation,
let's overhaul the current restriction logic by adding separate
restriction flags representing the operations we want to prevent (map,
unmap and use).

Map and use restrictions are set everywhere we were previously
calling panthor_vm_pgtable_declare_unusable() or setting ::destroyed
to true, since that's what those two flags were preventing.

We also add restriction checks in
panthor_vm_pgtable_prepare_[un]map_op_ctx() and
panthor_vm_pgtable_exec_op() and drop the ones we had in
panthor_vm_bind_job_create() since they are redundant.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 134 ++++++++++++++++++++++------------
 1 file changed, 88 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 933cb820926d..3d9f9bf29e1d 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -225,6 +225,25 @@ struct panthor_as_op_ctx {
 	} map;
 };
 
+/**
+ * enum panthor_as_restriction - List of restrictions that can apply to an AS.
+ *
+ * An AS always starts unrestricted, but based on the faults or device state
+ * changes, restrictions can be added over time. Restrictions can't be removed
+ * though. Once a VM is restricted, a new one must be created to lift the
+ * restrictions.
+ */
+enum panthor_as_restriction {
+	/** @PANTHOR_AS_FORBID_MAP: The AS can't map new buffers. */
+	PANTHOR_AS_FORBID_MAP = BIT(0),
+
+	/** @PANTHOR_AS_FORBID_UNMAP: The AS can't remove existing mappings. */
+	PANTHOR_AS_FORBID_UNMAP = BIT(1),
+
+	/** @PANTHOR_AS_FORBID_USE: The AS can't become active again. */
+	PANTHOR_AS_FORBID_USE = BIT(2),
+};
+
 /**
  * struct panthor_as - Used to managed a GPU address space.
  */
@@ -285,25 +304,8 @@ struct panthor_as {
 		struct list_head lru_node;
 	} hw_slot;
 
-	/**
-	 * @unusable: True if the AS has turned unusable because something
-	 * bad happened during an asynchronous request.
-	 *
-	 * We don't try to recover from such failures, because this implies
-	 * informing userspace about the specific operation that failed, and
-	 * hoping the userspace driver can replay things from there. This all
-	 * sounds very complicated for little gain.
-	 *
-	 * Instead, we should just flag the AS as unusable, and fail any
-	 * further request targeting this AS.
-	 *
-	 * We also provide a way to query an AS state, so userspace can
-	 * destroy it and create a new one.
-	 *
-	 * As an analogy, this would be mapped to a VK_ERROR_DEVICE_LOST
-	 * situation, where the logical device needs to be re-created.
-	 */
-	bool unusable;
+	/** @restrictions: Bitmask of panthor_as_restriction flags. */
+	atomic_t restrictions;
 
 	/**
 	 * @unhandled_fault: Unhandled fault happened.
@@ -431,13 +433,6 @@ struct panthor_vm {
 	/** @for_mcu: True if this is the MCU VM. */
 	bool for_mcu;
 
-	/**
-	 * @destroyed: True if the VM was destroyed.
-	 *
-	 * No further bind requests should be queued to a destroyed VM.
-	 */
-	bool destroyed;
-
 	/**
 	 * @dummy: Dummy object used for sparse mappings.
 	 *
@@ -699,7 +694,9 @@ bool panthor_vm_has_unhandled_faults(struct panthor_vm *vm)
  */
 bool panthor_vm_is_unusable(struct panthor_vm *vm)
 {
-	return vm->as->unusable;
+	return (atomic_read(&vm->as->restrictions) &
+		(PANTHOR_AS_FORBID_USE | PANTHOR_AS_FORBID_MAP |
+		 PANTHOR_AS_FORBID_UNMAP));
 }
 
 static void panthor_as_release_hw_slot_locked(struct panthor_as *as)
@@ -758,6 +755,11 @@ int panthor_vm_active(struct panthor_vm *vm)
 	mutex_lock(&as->op_lock);
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 
+	if (atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_USE) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	if (refcount_inc_not_zero(&as->active_cnt))
 		goto out_unlock;
 
@@ -926,21 +928,29 @@ static size_t get_pgsize(u64 addr, size_t size, size_t *count)
 	return SZ_2M;
 }
 
-static void panthor_as_declare_unusable(struct panthor_as *as)
+static void panthor_as_restrict_usage_locked(struct panthor_as *as,
+					     u32 new_restrictions)
 {
 	struct panthor_device *ptdev = container_of(as->base.drm, struct panthor_device, base);
 	int cookie;
 
-	if (as->unusable)
-		return;
+	lockdep_assert_held(&as->op_lock);
 
-	as->unusable = true;
-	mutex_lock(&ptdev->mmu->as.slots_lock);
-	if (as->hw_slot.id >= 0 && drm_dev_enter(&ptdev->base, &cookie)) {
-		panthor_mmu_as_disable(ptdev, as->hw_slot.id, false);
-		drm_dev_exit(cookie);
+	if (new_restrictions & PANTHOR_AS_FORBID_USE) {
+		guard(mutex)(&ptdev->mmu->as.slots_lock);
+		if (as->hw_slot.id >= 0 && drm_dev_enter(&ptdev->base, &cookie)) {
+			/* Try to disable the AS. If as_disable() passed, this should cause
+			 * a fault on the next memory access. If it failed, a reset is
+			 * scheduled to recover from the GPU hang.
+			 * We intentionally don't call release_as_locked() here, because
+			 * this would mess up with the active_cnt refcount.
+			 */
+			panthor_mmu_as_disable(ptdev, as->hw_slot.id, false);
+			drm_dev_exit(cookie);
+		}
 	}
-	mutex_unlock(&ptdev->mmu->as.slots_lock);
+
+	atomic_or(new_restrictions, &as->restrictions);
 }
 
 static void panthor_as_unmap_pages(struct panthor_as *as, u64 iova, u64 size)
@@ -976,7 +986,9 @@ static void panthor_as_unmap_pages(struct panthor_as *as, u64 iova, u64 size)
 			 * so flag the VM unusable to make sure it's not going
 			 * to be used anymore.
 			 */
-			panthor_as_declare_unusable(as);
+			panthor_as_restrict_usage_locked(as,
+							 PANTHOR_AS_FORBID_USE |
+							 PANTHOR_AS_FORBID_MAP);
 
 			/* If we don't make progress, we're screwed. That also means
 			 * something else prevents us from unmapping the region, but
@@ -1052,7 +1064,9 @@ panthor_as_map_pages(struct panthor_as *as, u64 iova, int prot,
 				 * table pages behind.
 				 */
 				panthor_as_unmap_pages(as, start_iova, iova - start_iova);
-				panthor_as_declare_unusable(as);
+				panthor_as_restrict_usage_locked(as,
+								 PANTHOR_AS_FORBID_USE |
+								 PANTHOR_AS_FORBID_MAP);
 				return ret;
 			}
 		}
@@ -1349,6 +1363,9 @@ static int panthor_as_prepare_map_op_ctx(struct panthor_as_op_ctx *op_ctx,
 	struct sg_table *sgt = NULL;
 	int ret;
 
+	if (atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_MAP)
+		return -EINVAL;
+
 	if (!bo)
 		return -EINVAL;
 
@@ -1442,6 +1459,9 @@ static int panthor_as_prepare_unmap_op_ctx(struct panthor_as_op_ctx *op_ctx,
 	u32 pt_count = 0;
 	int ret;
 
+	if (atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_UNMAP)
+		return -EINVAL;
+
 	memset(op_ctx, 0, sizeof(*op_ctx));
 	op_ctx->va.range = size;
 	op_ctx->va.addr = va;
@@ -1652,7 +1672,12 @@ static void panthor_vm_destroy(struct panthor_vm *vm)
 
 	as = vm->as;
 	ptdev = container_of(as->base.drm, struct panthor_device, base);
-	vm->destroyed = true;
+
+	scoped_guard(mutex, &as->op_lock) {
+		panthor_as_restrict_usage_locked(as,
+						 PANTHOR_AS_FORBID_USE |
+						 PANTHOR_AS_FORBID_MAP);
+	}
 
 	/* Tell scheduler to stop all GPU work related to this VM */
 	if (refcount_read(&as->active_cnt) > 0)
@@ -2169,7 +2194,7 @@ struct panthor_heap_pool *panthor_vm_get_heap_pool(struct panthor_vm *vm, bool c
 
 	mutex_lock(&vm->heaps.lock);
 	if (!vm->heaps.pool && create) {
-		if (vm->destroyed)
+		if (panthor_vm_is_unusable(vm))
 			pool = ERR_PTR(-EINVAL);
 		else
 			pool = panthor_heap_pool_create(ptdev, vm);
@@ -2546,6 +2571,17 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo)
 		if (!mutex_trylock(&as->op_lock))
 			return -EDEADLK;
 
+		/* Unmaps are forbidden when we failed to communicate with the GPU,
+		 * meaning we can't guarantee that the GPU will see our page table
+		 * updates which might lead to UAF situations. In that case, we
+		 * just skip eviction on this VM. Things should go back to normal
+		 * after a GPU reset.
+		 */
+		if (atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_UNMAP) {
+			ret = -EBUSY;
+			goto unlock_op;
+		}
+
 		/* It can be that the vm_bo was already evicted but a new
 		 * mapping pointing to this BO got created in the meantime,
 		 * thus turning the vm_bo in partially evicted state. In that case
@@ -2581,6 +2617,7 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo)
 			vma->evicted = true;
 		}
 
+unlock_op:
 		mutex_unlock(&as->op_lock);
 
 		if (ret)
@@ -2795,7 +2832,7 @@ static int panthor_as_exec_op(struct panthor_as *as,
 			.map.gem.offset = op->map.bo_offset,
 		};
 
-		if (as->unusable) {
+		if (atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_MAP) {
 			ret = -EINVAL;
 			break;
 		}
@@ -2805,6 +2842,11 @@ static int panthor_as_exec_op(struct panthor_as *as,
 	}
 
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP:
+		if (atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_UNMAP) {
+			ret = -EINVAL;
+			break;
+		}
+
 		ret = drm_gpuvm_sm_unmap(&as->base, as, op->va.addr, op->va.range);
 		break;
 
@@ -2816,8 +2858,11 @@ static int panthor_as_exec_op(struct panthor_as *as,
 	panthor_as_unlock_region(as);
 
 out:
-	if (ret && flag_vm_unusable_on_failure)
-		panthor_as_declare_unusable(as);
+	if (ret && flag_vm_unusable_on_failure) {
+		panthor_as_restrict_usage_locked(as,
+						 PANTHOR_AS_FORBID_USE |
+						 PANTHOR_AS_FORBID_MAP);
+	}
 
 	as->op_ctx = NULL;
 	mutex_unlock(&as->op_lock);
@@ -3141,9 +3186,6 @@ panthor_vm_bind_job_create(struct drm_file *file,
 	if (!vm)
 		return ERR_PTR(-EINVAL);
 
-	if (vm->destroyed || vm->as->unusable)
-		return ERR_PTR(-EINVAL);
-
 	job = kzalloc_obj(*job);
 	if (!job)
 		return ERR_PTR(-ENOMEM);

-- 
2.55.0

