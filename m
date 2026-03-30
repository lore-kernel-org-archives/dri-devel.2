Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D16FB3CEB
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B95FD10E57C;
	Mon, 30 Mar 2026 09:49:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qHku1bhJ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 367EE10E5AC
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 09:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774864141;
 bh=CyEpjtm1mi2dgCJ7yTQokBx8HTePUh1AC3OUc4v9Dnw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qHku1bhJleqOvlkxs2S0CPwNv/4XzM/chLdvgOqkGn26Cchg1QWUBmhOV2iGLLopA
 2iCwbG7guZ0yjSI/16azMV2zwx7GVDxLUrclegjWODWGhSlKaBFxTazPAZCmNMbtJ3
 YcdR/4JFdTl0YL86WNKncJugMOOh9s/KpRSDafvDp6NAjO5B27X/H+T93hVW4ai2cX
 q7ryd4EEAad/mP9xxw1kvSPwKTDpQeO0DJsB+e5fy7V0n4HepgLeoFTwRxgU+tT/3Q
 t/meyn6mhVbD9z2Ld+HUeFk+NyfmuUEyoDU2P+W/FPyjGjmEfSkFCqDFWOixOSif7c
 LJe9hSqpFLlZw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:a2a7:f53:ebb0:945e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4155717E410F;
 Mon, 30 Mar 2026 11:49:00 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Chris Diamand <chris.diamand@arm.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Chia-I Wu <olvaffe@gmail.com>,
 kernel@collabora.com
Subject: [PATCH v6 3/9] drm/panthor: Group panthor_kernel_bo_xxx() helpers
Date: Mon, 30 Mar 2026 11:48:42 +0200
Message-ID: <20260330094848.2169422-4-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330094848.2169422-1-boris.brezillon@collabora.com>
References: <20260330094848.2169422-1-boris.brezillon@collabora.com>
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

Move all panthor_kernel_bo_xxx() helpers at the end of the file, just
before the debugfs init logic. This will make further panthor_gem.c
refactoring more readable.

v2:
- Collect R-bs

v3:
- No changes

v4:
- No changes

v5:
- No changes

v6:
- No changes

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c | 212 +++++++++++++-------------
 1 file changed, 106 insertions(+), 106 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index c7b8b84a8f8b..5065f99c9bc4 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -132,112 +132,6 @@ static void panthor_gem_free_object(struct drm_gem_object *obj)
 	drm_gem_object_put(vm_root_gem);
 }
 
-/**
- * panthor_kernel_bo_destroy() - Destroy a kernel buffer object
- * @bo: Kernel buffer object to destroy. If NULL or an ERR_PTR(), the destruction
- * is skipped.
- */
-void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
-{
-	struct panthor_vm *vm;
-
-	if (IS_ERR_OR_NULL(bo))
-		return;
-
-	vm = bo->vm;
-	panthor_kernel_bo_vunmap(bo);
-
-	drm_WARN_ON(bo->obj->dev,
-		    to_panthor_bo(bo->obj)->exclusive_vm_root_gem != panthor_vm_root_gem(vm));
-	panthor_vm_unmap_range(vm, bo->va_node.start, bo->va_node.size);
-	panthor_vm_free_va(vm, &bo->va_node);
-	drm_gem_object_put(bo->obj);
-	panthor_vm_put(vm);
-	kfree(bo);
-}
-
-/**
- * panthor_kernel_bo_create() - Create and map a GEM object to a VM
- * @ptdev: Device.
- * @vm: VM to map the GEM to. If NULL, the kernel object is not GPU mapped.
- * @size: Size of the buffer object.
- * @bo_flags: Combination of drm_panthor_bo_flags flags.
- * @vm_map_flags: Combination of drm_panthor_vm_bind_op_flags (only those
- * that are related to map operations).
- * @gpu_va: GPU address assigned when mapping to the VM.
- * If gpu_va == PANTHOR_VM_KERNEL_AUTO_VA, the virtual address will be
- * automatically allocated.
- * @name: Descriptive label of the BO's contents
- *
- * Return: A valid pointer in case of success, an ERR_PTR() otherwise.
- */
-struct panthor_kernel_bo *
-panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
-			 size_t size, u32 bo_flags, u32 vm_map_flags,
-			 u64 gpu_va, const char *name)
-{
-	struct drm_gem_shmem_object *obj;
-	struct panthor_kernel_bo *kbo;
-	struct panthor_gem_object *bo;
-	u32 debug_flags = PANTHOR_DEBUGFS_GEM_USAGE_FLAG_KERNEL;
-	int ret;
-
-	if (drm_WARN_ON(&ptdev->base, !vm))
-		return ERR_PTR(-EINVAL);
-
-	kbo = kzalloc_obj(*kbo);
-	if (!kbo)
-		return ERR_PTR(-ENOMEM);
-
-	obj = drm_gem_shmem_create(&ptdev->base, size);
-	if (IS_ERR(obj)) {
-		ret = PTR_ERR(obj);
-		goto err_free_bo;
-	}
-
-	bo = to_panthor_bo(&obj->base);
-	kbo->obj = &obj->base;
-	bo->flags = bo_flags;
-	bo->base.map_wc = should_map_wc(bo, vm);
-	bo->exclusive_vm_root_gem = panthor_vm_root_gem(vm);
-	drm_gem_object_get(bo->exclusive_vm_root_gem);
-	bo->base.base.resv = bo->exclusive_vm_root_gem->resv;
-
-	if (vm == panthor_fw_vm(ptdev))
-		debug_flags |= PANTHOR_DEBUGFS_GEM_USAGE_FLAG_FW_MAPPED;
-
-	panthor_gem_kernel_bo_set_label(kbo, name);
-	panthor_gem_debugfs_set_usage_flags(to_panthor_bo(kbo->obj), debug_flags);
-
-	/* The system and GPU MMU page size might differ, which becomes a
-	 * problem for FW sections that need to be mapped at explicit address
-	 * since our PAGE_SIZE alignment might cover a VA range that's
-	 * expected to be used for another section.
-	 * Make sure we never map more than we need.
-	 */
-	size = ALIGN(size, panthor_vm_page_size(vm));
-	ret = panthor_vm_alloc_va(vm, gpu_va, size, &kbo->va_node);
-	if (ret)
-		goto err_put_obj;
-
-	ret = panthor_vm_map_bo_range(vm, bo, 0, size, kbo->va_node.start, vm_map_flags);
-	if (ret)
-		goto err_free_va;
-
-	kbo->vm = panthor_vm_get(vm);
-	return kbo;
-
-err_free_va:
-	panthor_vm_free_va(vm, &kbo->va_node);
-
-err_put_obj:
-	drm_gem_object_put(&obj->base);
-
-err_free_bo:
-	kfree(kbo);
-	return ERR_PTR(ret);
-}
-
 static struct sg_table *
 panthor_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
 			      enum dma_data_direction dir)
@@ -603,6 +497,112 @@ panthor_gem_sync(struct drm_gem_object *obj, u32 type,
 	return 0;
 }
 
+/**
+ * panthor_kernel_bo_destroy() - Destroy a kernel buffer object
+ * @bo: Kernel buffer object to destroy. If NULL or an ERR_PTR(), the destruction
+ * is skipped.
+ */
+void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
+{
+	struct panthor_vm *vm;
+
+	if (IS_ERR_OR_NULL(bo))
+		return;
+
+	vm = bo->vm;
+	panthor_kernel_bo_vunmap(bo);
+
+	drm_WARN_ON(bo->obj->dev,
+		    to_panthor_bo(bo->obj)->exclusive_vm_root_gem != panthor_vm_root_gem(vm));
+	panthor_vm_unmap_range(vm, bo->va_node.start, bo->va_node.size);
+	panthor_vm_free_va(vm, &bo->va_node);
+	drm_gem_object_put(bo->obj);
+	panthor_vm_put(vm);
+	kfree(bo);
+}
+
+/**
+ * panthor_kernel_bo_create() - Create and map a GEM object to a VM
+ * @ptdev: Device.
+ * @vm: VM to map the GEM to. If NULL, the kernel object is not GPU mapped.
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
+	struct drm_gem_shmem_object *obj;
+	struct panthor_kernel_bo *kbo;
+	struct panthor_gem_object *bo;
+	u32 debug_flags = PANTHOR_DEBUGFS_GEM_USAGE_FLAG_KERNEL;
+	int ret;
+
+	if (drm_WARN_ON(&ptdev->base, !vm))
+		return ERR_PTR(-EINVAL);
+
+	kbo = kzalloc_obj(*kbo);
+	if (!kbo)
+		return ERR_PTR(-ENOMEM);
+
+	obj = drm_gem_shmem_create(&ptdev->base, size);
+	if (IS_ERR(obj)) {
+		ret = PTR_ERR(obj);
+		goto err_free_bo;
+	}
+
+	bo = to_panthor_bo(&obj->base);
+	kbo->obj = &obj->base;
+	bo->flags = bo_flags;
+	bo->base.map_wc = should_map_wc(bo, vm);
+	bo->exclusive_vm_root_gem = panthor_vm_root_gem(vm);
+	drm_gem_object_get(bo->exclusive_vm_root_gem);
+	bo->base.base.resv = bo->exclusive_vm_root_gem->resv;
+
+	if (vm == panthor_fw_vm(ptdev))
+		debug_flags |= PANTHOR_DEBUGFS_GEM_USAGE_FLAG_FW_MAPPED;
+
+	panthor_gem_kernel_bo_set_label(kbo, name);
+	panthor_gem_debugfs_set_usage_flags(to_panthor_bo(kbo->obj), debug_flags);
+
+	/* The system and GPU MMU page size might differ, which becomes a
+	 * problem for FW sections that need to be mapped at explicit address
+	 * since our PAGE_SIZE alignment might cover a VA range that's
+	 * expected to be used for another section.
+	 * Make sure we never map more than we need.
+	 */
+	size = ALIGN(size, panthor_vm_page_size(vm));
+	ret = panthor_vm_alloc_va(vm, gpu_va, size, &kbo->va_node);
+	if (ret)
+		goto err_put_obj;
+
+	ret = panthor_vm_map_bo_range(vm, bo, 0, size, kbo->va_node.start, vm_map_flags);
+	if (ret)
+		goto err_free_va;
+
+	kbo->vm = panthor_vm_get(vm);
+	return kbo;
+
+err_free_va:
+	panthor_vm_free_va(vm, &kbo->va_node);
+
+err_put_obj:
+	drm_gem_object_put(&obj->base);
+
+err_free_bo:
+	kfree(kbo);
+	return ERR_PTR(ret);
+}
+
 #ifdef CONFIG_DEBUG_FS
 struct gem_size_totals {
 	size_t size;
-- 
2.53.0

