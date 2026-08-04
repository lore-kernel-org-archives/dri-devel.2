Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CE7C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 10:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 175DF10E9A1;
	Tue,  4 Aug 2026 10:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GpT+u6Eg";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF86210E992
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785838198;
 bh=nGwY/4G2VwI8VrkXPuOYB5yY2bEnLxfjdzwnjauwB4k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=GpT+u6EgojHF1JRC8wqYHT/0gkVN0pYyNyY0s+9Ch+jWRs/WoF7z+DDwufJEbEcUU
 KzwEgKdRd5Via7aOwKx8Od12u/yKObxa9Rgsu4kMI74DylF4HW7jHMoAlZZ8HwkpN3
 Bd3sEvqNedbAlgGv4fk743dIPLoX0RXwbov0OeQTPyhNGZdIQ1dQl2E/1ExzBOJPw0
 7QxLaq7wkuoydXcRMCWk0Nbj8X5jg9WfjzwS9opDBfj78ycZc1Y44hsXgkPZ26uzrX
 P7hNmXQRdIJQXa+E5wLBN+GacKBGcQew+X6yabFaIprDkPk+WSeQifDx9t5dmJs/4t
 62AtWxDLhqUWQ==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2492F17E10BE;
 Tue, 04 Aug 2026 12:09:58 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 04 Aug 2026 12:09:46 +0200
Subject: [PATCH 07/12] drm/panthor: Add fine-grained restrictions on VMs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-panthor-unplug-fixes-v1-7-abbbd2d41b13@collabora.com>
References: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
In-Reply-To: <20260804-panthor-unplug-fixes-v1-0-abbbd2d41b13@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785838194; l=8230;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=nGwY/4G2VwI8VrkXPuOYB5yY2bEnLxfjdzwnjauwB4k=;
 b=3+j0u9C7qfUPv5XKgXd5/KnG3tGmW15ecqDIUtWrD6RyjnwQgWbQC5t/2vTesUj4Jil8REU9m
 LxiwQW+adRHBqhj46z2Wo6gRiLFh2xh4GkhNY2+GiKo4KSuHhjL74gD
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
 drivers/gpu/drm/panthor/panthor_mmu.c | 101 ++++++++++++++++++++++++----------
 1 file changed, 73 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 2d462813a711..9a9025b02e28 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -215,6 +215,25 @@ struct panthor_as_op_ctx {
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
@@ -295,6 +314,9 @@ struct panthor_as {
 	 */
 	bool unusable;
 
+	/** @restrictions: Bitmask of panthor_as_restriction flags. */
+	atomic_t restrictions;
+
 	/**
 	 * @unhandled_fault: Unhandled fault happened.
 	 *
@@ -411,13 +433,6 @@ struct panthor_vm {
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
@@ -693,7 +708,9 @@ bool panthor_vm_has_unhandled_faults(struct panthor_vm *vm)
  */
 bool panthor_vm_is_unusable(struct panthor_vm *vm)
 {
-	return vm->as->unusable;
+	return (atomic_read(&vm->as->restrictions) &
+		(PANTHOR_AS_FORBID_USE | PANTHOR_AS_FORBID_MAP |
+		 PANTHOR_AS_FORBID_UNMAP));
 }
 
 static void panthor_as_release_hw_slot_locked(struct panthor_as *as)
@@ -752,6 +769,11 @@ int panthor_vm_active(struct panthor_vm *vm)
 	mutex_lock(&as->op_lock);
 	mutex_lock(&ptdev->mmu->as.slots_lock);
 
+	if (atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_USE) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	if (refcount_inc_not_zero(&as->active_cnt))
 		goto out_unlock;
 
@@ -920,21 +942,27 @@ static size_t get_pgsize(u64 addr, size_t size, size_t *count)
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
-
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
@@ -970,7 +998,9 @@ static void panthor_as_unmap_pages(struct panthor_as *as, u64 iova, u64 size)
 			 * so flag the VM unusable to make sure it's not going
 			 * to be used anymore.
 			 */
-			panthor_as_declare_unusable(as);
+			panthor_as_restrict_usage_locked(as,
+							 PANTHOR_AS_FORBID_USE |
+							 PANTHOR_AS_FORBID_MAP);
 
 			/* If we don't make progress, we're screwed. That also means
 			 * something else prevents us from unmapping the region, but
@@ -1046,7 +1076,9 @@ panthor_as_map_pages(struct panthor_as *as, u64 iova, int prot,
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
@@ -1339,6 +1371,9 @@ static int panthor_as_prepare_map_op_ctx(struct panthor_as_op_ctx *op_ctx,
 	struct sg_table *sgt = NULL;
 	int ret;
 
+	if (atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_MAP)
+		return -EINVAL;
+
 	if (!bo)
 		return -EINVAL;
 
@@ -1431,6 +1466,9 @@ static int panthor_as_prepare_unmap_op_ctx(struct panthor_as_op_ctx *op_ctx,
 	u32 pt_count = 0;
 	int ret;
 
+	if (atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_UNMAP)
+		return -EINVAL;
+
 	memset(op_ctx, 0, sizeof(*op_ctx));
 	op_ctx->va.range = size;
 	op_ctx->va.addr = va;
@@ -1640,7 +1678,9 @@ static void panthor_vm_destroy(struct panthor_vm *vm)
 
 	as = vm->as;
 	ptdev = container_of(as->base.drm, struct panthor_device, base);
-	vm->destroyed = true;
+	panthor_as_restrict_usage_locked(as,
+					 PANTHOR_AS_FORBID_USE |
+					 PANTHOR_AS_FORBID_MAP);
 
 	/* Tell scheduler to stop all GPU work related to this VM */
 	if (refcount_read(&as->active_cnt) > 0)
@@ -2150,7 +2190,7 @@ struct panthor_heap_pool *panthor_vm_get_heap_pool(struct panthor_vm *vm, bool c
 
 	mutex_lock(&vm->heaps.lock);
 	if (!vm->heaps.pool && create) {
-		if (vm->destroyed)
+		if (panthor_vm_is_unusable(vm))
 			pool = ERR_PTR(-EINVAL);
 		else
 			pool = panthor_heap_pool_create(ptdev, vm);
@@ -2769,7 +2809,7 @@ static int panthor_as_exec_op(struct panthor_as *as,
 			.map.gem.offset = op->map.bo_offset,
 		};
 
-		if (as->unusable) {
+		if (atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_MAP) {
 			ret = -EINVAL;
 			break;
 		}
@@ -2779,6 +2819,11 @@ static int panthor_as_exec_op(struct panthor_as *as,
 	}
 
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP:
+		if (atomic_read(&as->restrictions) & PANTHOR_AS_FORBID_UNMAP) {
+			ret = -EINVAL;
+			break;
+		}
+
 		ret = drm_gpuvm_sm_unmap(&as->base, as, op->va.addr, op->va.range);
 		break;
 
@@ -2790,8 +2835,11 @@ static int panthor_as_exec_op(struct panthor_as *as,
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
@@ -3113,9 +3161,6 @@ panthor_vm_bind_job_create(struct drm_file *file,
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

