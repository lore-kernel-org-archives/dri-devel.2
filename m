Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3007CCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:00:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F3310F0CC;
	Mon, 12 Oct 2026 13:00:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D14F310F0A6
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:00:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 449FC1655;
 Mon, 12 Oct 2026 06:00:16 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BF2B3F66F;
 Mon, 12 Oct 2026 06:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791810019; bh=OY4b9rx8njkewz7edHPqtfOF8iTdPo2fNGb90LhNQYU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C0gPS15O87hxl3kVvzGa0IMQ3LcqSbwlrv/boamrDkXnoWwy8wznFdfGieRVDYdGs
 xcjbysZc6c32PPDGTALwmAe7IlzW49O9kNWU8blEWtB74HlLmtjurB5ITTx1o0IEA7
 V6F9VPfSdb8BWayEAHHak9SdHv99Mk8UiXG7NNas=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH v4 09/12] drm/panthor: Create kernel BO from existing GEM
Date: Mon, 12 Oct 2026 14:59:37 +0200
Message-ID: <20261012125940.3291951-10-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012125940.3291951-1-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
MIME-Version: 1.0
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

From: Boris Brezillon <boris.brezillon@collabora.com>

Refactors/splits existing panthor_kernel_bo_create().
Adds panthor_kernel_bo_create_from_gem() so we can create kernel BOs
from imported protected memory in future change.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

---

v4:
- First version of this change as a separate commit
---
 drivers/gpu/drm/panthor/panthor_gem.c | 94 ++++++++++++++++++---------
 drivers/gpu/drm/panthor/panthor_gem.h |  7 ++
 2 files changed, 71 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 2e39a32fcd673..f1939b4aafed1 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -1033,7 +1033,6 @@ panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
 		bo->base.resv = bo->exclusive_vm_root_gem->resv;
 	}
 
-	panthor_gem_debugfs_add_usage_flags(bo, usage_flags);
 	panthor_gem_debugfs_bo_add(bo);
 	return bo;
 
@@ -1260,7 +1259,9 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
 	panthor_kernel_bo_vunmap(bo);
 
 	drm_WARN_ON(bo->obj->dev,
-		    to_panthor_bo(bo->obj)->exclusive_vm_root_gem != panthor_vm_root_gem(vm));
+		    to_panthor_bo(bo->obj)->exclusive_vm_root_gem &&
+			    (to_panthor_bo(bo->obj)->exclusive_vm_root_gem !=
+			     panthor_vm_root_gem(vm)));
 	panthor_vm_unmap_range(vm, bo->va_node.start, bo->va_node.size);
 	panthor_vm_free_va(vm, &bo->va_node);
 	if (vm == panthor_fw_vm(ptdev))
@@ -1271,46 +1272,33 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
 }
 
 /**
- * panthor_kernel_bo_create() - Create and map a GEM object to a VM
+ * panthor_kernel_bo_create_from_gem() - Create kernel BO from existing GEM object
  * @ptdev: Device.
  * @vm: VM to map the GEM to.
- * @size: Size of the buffer object.
- * @bo_flags: Combination of drm_panthor_bo_flags flags.
+ * @bo: BO to use for our kernel BO.
  * @vm_map_flags: Combination of drm_panthor_vm_bind_op_flags (only those
  * that are related to map operations).
  * @gpu_va: GPU address assigned when mapping to the VM.
  * If gpu_va == PANTHOR_VM_KERNEL_AUTO_VA, the virtual address will be
  * automatically allocated.
- * @name: Descriptive label of the BO's contents
+ * @vm_map_size: Size of the BO to map to the VM.
  *
  * Return: A valid pointer in case of success, an ERR_PTR() otherwise.
  */
 struct panthor_kernel_bo *
-panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
-			 size_t size, u32 bo_flags, u32 vm_map_flags,
-			 u64 gpu_va, const char *name)
+panthor_kernel_bo_create_from_gem(struct panthor_device *ptdev,
+				  struct panthor_vm *vm,
+				  struct panthor_gem_object *bo,
+				  u32 vm_map_flags, u64 gpu_va, u32 vm_map_size)
 {
 	struct panthor_kernel_bo *kbo;
-	struct panthor_gem_object *bo;
-	u32 debug_flags = PANTHOR_DEBUGFS_GEM_USAGE_FLAG_KERNEL;
 	int ret;
 
-	if (drm_WARN_ON(&ptdev->base, !vm))
-		return ERR_PTR(-EINVAL);
-
 	kbo = kzalloc_obj(*kbo);
 	if (!kbo)
 		return ERR_PTR(-ENOMEM);
 
-	if (vm == panthor_fw_vm(ptdev))
-		debug_flags |= PANTHOR_DEBUGFS_GEM_USAGE_FLAG_FW_MAPPED;
-
-	bo = panthor_gem_create(&ptdev->base, size, bo_flags, vm, debug_flags);
-	if (IS_ERR(bo)) {
-		ret = PTR_ERR(bo);
-		goto err_free_kbo;
-	}
-
+	drm_gem_object_get(&bo->base);
 	kbo->obj = &bo->base;
 
 	if (vm == panthor_fw_vm(ptdev)) {
@@ -1319,24 +1307,27 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 			goto err_put_obj;
 	}
 
-	panthor_gem_kernel_bo_set_label(kbo, name);
-
 	/* The system and GPU MMU page size might differ, which becomes a
 	 * problem for FW sections that need to be mapped at explicit address
 	 * since our PAGE_SIZE alignment might cover a VA range that's
 	 * expected to be used for another section.
 	 * Make sure we never map more than we need.
 	 */
-	size = ALIGN(size, panthor_vm_page_size(vm));
-	ret = panthor_vm_alloc_va(vm, gpu_va, size, &kbo->va_node);
+	vm_map_size = ALIGN(vm_map_size, panthor_vm_page_size(vm));
+	ret = panthor_vm_alloc_va(vm, gpu_va, vm_map_size, &kbo->va_node);
 	if (ret)
 		goto err_unpin;
 
-	ret = panthor_vm_map_bo_range(vm, bo, 0, size, kbo->va_node.start, vm_map_flags);
+	ret = panthor_vm_map_bo_range(vm, bo, 0, vm_map_size,
+				      kbo->va_node.start, vm_map_flags);
 	if (ret)
 		goto err_free_va;
 
 	kbo->vm = panthor_vm_get(vm);
+	if (vm == panthor_fw_vm(ptdev))
+		panthor_gem_debugfs_add_usage_flags(
+			bo, PANTHOR_DEBUGFS_GEM_USAGE_FLAG_FW_MAPPED);
+
 	return kbo;
 
 err_free_va:
@@ -1348,12 +1339,55 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 
 err_put_obj:
 	drm_gem_object_put(&bo->base);
-
-err_free_kbo:
 	kfree(kbo);
 	return ERR_PTR(ret);
 }
 
+/**
+ * panthor_kernel_bo_create() - Create and map a GEM object to a VM
+ * @ptdev: Device.
+ * @vm: VM to map the GEM to.
+ * @size: Size of the buffer object.
+ * @bo_flags: Combination of drm_panthor_bo_flags flags.
+ * @vm_map_flags: Combination of drm_panthor_vm_bind_op_flags (only those
+ * that are related to map operations).
+ * @gpu_va: GPU address assigned when mapping to the VM.
+ * If gpu_va == PANTHOR_VM_KERNEL_AUTO_VA, the virtual address will be
+ * automatically allocated.
+ * @name: Descriptive label of the BO's contents
+ *
+ * Return: A valid pointer in case of success, an ERR_PTR() otherwise.
+ */
+struct panthor_kernel_bo *
+panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
+			 size_t size, u32 bo_flags, u32 vm_map_flags,
+			 u64 gpu_va, const char *name)
+{
+	struct panthor_kernel_bo *kbo;
+	struct panthor_gem_object *bo;
+
+	if (drm_WARN_ON(&ptdev->base, !vm))
+		return ERR_PTR(-EINVAL);
+
+	bo = panthor_gem_create(&ptdev->base, size, bo_flags, vm, 0);
+	if (IS_ERR(bo))
+		return ERR_CAST(bo);
+
+	kbo = panthor_kernel_bo_create_from_gem(ptdev, vm, bo, vm_map_flags,
+						gpu_va, size);
+	if (!IS_ERR(kbo)) {
+		panthor_gem_debugfs_add_usage_flags(
+			bo, PANTHOR_DEBUGFS_GEM_USAGE_FLAG_KERNEL);
+		panthor_gem_kernel_bo_set_label(kbo, name);
+	}
+
+	/* panthor_kernel_bo_create_from_gem() acquires a GEM ref if the import
+	 * succeeds, so we can release it unconditionally here.
+	 */
+	drm_gem_object_put(&bo->base);
+	return kbo;
+}
+
 /**
  * panthor_dummy_bo_create() - Create a Panthor BO meant to back sparse bindings.
  * @ptdev: Device.
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index 4da3f59693ce4..03dd3927b5d16 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -318,6 +318,13 @@ panthor_kernel_bo_vunmap(struct panthor_kernel_bo *bo)
 	}
 }
 
+struct panthor_kernel_bo *
+panthor_kernel_bo_create_from_gem(struct panthor_device *ptdev,
+				  struct panthor_vm *vm,
+				  struct panthor_gem_object *bo,
+				  u32 vm_map_flags, u64 gpu_va,
+				  u32 vm_map_size);
+
 struct panthor_kernel_bo *
 panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 			 size_t size, u32 bo_flags, u32 vm_map_flags,
-- 
2.43.0

