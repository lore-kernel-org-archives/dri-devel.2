Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBC5E8538E
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 19:28:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7C2910E2AE;
	Fri,  3 Apr 2026 19:28:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="boOHWZyr";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9078110E3BE
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 19:28:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1775244486; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CWEPTfmTSNz5LCTXMSP+3atHm3SIGsN3/Vjl7eOlMlvjfloYDBCoPcyFi1RZnl+vfSLPz5aeNCuPNHocy1m/e6tm1CZxSyd0xaGjBffauYn5r4eC4gVcQH162cmW4sZUo6jzYK8OxHy2HoJxv59o6WGglOnbVgQA4awGTBc9jZc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1775244486;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lO5/eTiFFEzPpQdaJvQXE2yn657Nel0wx8BqGIBsio0=; 
 b=lTqC08QKD0WwyeMaEK6GGdmZK2FtmzrZq6cjpgUY0bmXLRNsH43u7HqkgZnMaJ7VtbX5grE9ywDv5V6XGH204ZU5mBvL5XReW2YQcVwNttjZvRxQDcTpYTGPLPCqZHZuaQYeEeQxqaKQilcnzm4Za7BTfR2nTa4fFs3oo4TIPBM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775244486; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=lO5/eTiFFEzPpQdaJvQXE2yn657Nel0wx8BqGIBsio0=;
 b=boOHWZyrZbqSHSDPFsBhhce5WypOc/7MKYl4jgawExlNPeDa2t6Una/358Zf7Dl4
 hyF9Ym9qxquhTcqaJS2xFDXXuXGKuO50LINi2PkmMDRtZ3D2TFqW833SbaujsQg4MZS
 GYT+MDKNBusOpip2yH0m4kzQgEwS/czrty6ulsh8=
Received: by mx.zohomail.com with SMTPS id 1775244484271526.1050989488903;
 Fri, 3 Apr 2026 12:28:04 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v6 3/4] drm/panthor: Support sparse mappings
Date: Fri,  3 Apr 2026 20:27:28 +0100
Message-ID: <20260403192743.3572062-4-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403192743.3572062-1-adrian.larumbe@collabora.com>
References: <20260403192743.3572062-1-adrian.larumbe@collabora.com>
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

Allow UM to bind sparsely populated memory regions by cyclically mapping
virtual ranges over a set of zero-initialised dummy pages. This alternative
is preferable to the old method of handling sparseness in the UMD, because
it relied on the creation of a buffer object to the same end, despite the
fact Vulkan sparse resources don't need to be backed by a driver BO.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 267 +++++++++++++++++++-------
 include/uapi/drm/panthor_drm.h        |  13 +-
 2 files changed, 206 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 10da2f021d9d..e73657aebfb0 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -104,6 +104,11 @@ struct panthor_mmu {
 		/** @vm.wq: Workqueue used for the VM_BIND queues. */
 		struct workqueue_struct *wq;
 	} vm;
+
+	struct {
+		struct page *pages;
+		struct sg_table *sgt;
+	} dummy;
 };
 
 /**
@@ -1028,6 +1033,34 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 	return 0;
 }
 
+static int
+panthor_vm_repeated_map_pages(struct panthor_vm *vm, u64 iova, int prot,
+			      struct sg_table *sgt, u64 size)
+{
+	u64 first_iova = iova;
+	u64 first_size = size;
+	int ret;
+
+	/* FIXME: we really need to optimize this at the io_pgtable level. */
+	while (size > 0) {
+		u64 next_size = min(size, sgt->sgl->length);
+
+		ret = panthor_vm_map_pages(vm, iova, prot,
+					   sgt, 0, next_size);
+		if (ret)
+			goto err_unmap;
+
+		size -= next_size;
+		iova += next_size;
+	}
+
+	return 0;
+
+err_unmap:
+	panthor_vm_unmap_pages(vm, first_iova, first_size - size);
+	return ret;
+}
+
 static int flags_to_prot(u32 flags)
 {
 	int prot = 0;
@@ -1270,6 +1303,7 @@ static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
 	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
 	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
 	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED | \
+	 DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE | \
 	 DRM_PANTHOR_VM_BIND_OP_TYPE_MASK)
 
 static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
@@ -1277,74 +1311,87 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 					 struct panthor_gem_object *bo,
 					 const struct drm_panthor_vm_bind_op *op)
 {
+	bool is_sparse = op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
 	struct drm_gpuvm_bo *preallocated_vm_bo;
 	struct sg_table *sgt = NULL;
 	int ret;
 
-	if (!bo)
-		return -EINVAL;
-
 	if ((op->flags & ~PANTHOR_VM_BIND_OP_MAP_FLAGS) ||
 	    (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
 		return -EINVAL;
 
-	/* Make sure the VA and size are in-bounds. */
-	if (op->size > bo->base.size || op->bo_offset > bo->base.size - op->size)
-		return -EINVAL;
+	if (!is_sparse) {
+		/* Make sure the VA and size are in-bounds. */
+		if (!bo || op->size > bo->base.size ||
+		    op->bo_offset > bo->base.size - op->size)
+			return -EINVAL;
+	} else {
+		if (bo || op->bo_handle || op->bo_offset)
+			return -EINVAL;
+	}
 
 	/* If the BO has an exclusive VM attached, it can't be mapped to other VMs. */
-	if (bo->exclusive_vm_root_gem &&
+	if (!is_sparse && bo->exclusive_vm_root_gem &&
 	    bo->exclusive_vm_root_gem != panthor_vm_root_gem(vm))
 		return -EINVAL;
 
-	panthor_vm_init_op_ctx(op_ctx, op->size, op->va, op->flags);
+	panthor_vm_init_op_ctx(op_ctx, op->size, op->va, op->flags
+			       | ((is_sparse) ? DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC : 0));
 
 	ret = panthor_vm_op_ctx_prealloc_vmas(op_ctx);
 	if (ret)
 		goto err_cleanup;
 
-	/* Pre-reserve the BO pages, so the map operation doesn't have to
-	 * allocate.
-	 */
-	ret = panthor_gem_pin(bo);
-	if (ret)
-		goto err_cleanup;
+	if (!is_sparse) {
+		/* Pre-reserve the BO pages, so the map operation doesn't have to
+		 * allocate.
+		 */
+		ret = panthor_gem_pin(bo);
+		if (ret)
+			goto err_cleanup;
 
-	drm_gem_object_get(&bo->base);
-	op_ctx->map.bo = bo;
+		drm_gem_object_get(&bo->base);
+		op_ctx->map.bo = bo;
 
-	sgt = panthor_gem_get_dev_sgt(bo);
-	if (IS_ERR(sgt)) {
-		ret = PTR_ERR(sgt);
-		goto err_cleanup;
-	}
+		sgt = panthor_gem_get_dev_sgt(bo);
+		if (IS_ERR(sgt)) {
+			ret = PTR_ERR(sgt);
+			goto err_cleanup;
+		}
+		op_ctx->map.sgt = sgt;
 
-	preallocated_vm_bo = drm_gpuvm_bo_create(&vm->base, &bo->base);
-	if (!preallocated_vm_bo) {
-		ret = -ENOMEM;
-		goto err_cleanup;
-	}
+		preallocated_vm_bo = drm_gpuvm_bo_create(&vm->base, &bo->base);
+		if (!preallocated_vm_bo) {
+			ret = -ENOMEM;
+			goto err_cleanup;
+		}
 
-	op_ctx->map.vm_bo = drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
-	op_ctx->map.bo_offset = op->bo_offset;
+		op_ctx->map.vm_bo =
+			drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
+		op_ctx->map.bo_offset = op->bo_offset;
+	}  else {
+		op_ctx->map.sgt = vm->ptdev->mmu->dummy.sgt;
+	}
 
 	ret = panthor_vm_op_ctx_prealloc_pts(op_ctx);
 	if (ret)
 		goto err_cleanup;
 
-	/* Insert BO into the extobj list last, when we know nothing can fail. */
-	if (bo->base.resv != panthor_vm_resv(vm)) {
-		dma_resv_lock(panthor_vm_resv(vm), NULL);
-		drm_gpuvm_bo_extobj_add(op_ctx->map.vm_bo);
-		dma_resv_unlock(panthor_vm_resv(vm));
-	}
+	if (!is_sparse) {
+		/* Insert BO into the extobj list last, when we know nothing can fail. */
+		if (bo->base.resv != panthor_vm_resv(vm)) {
+			dma_resv_lock(panthor_vm_resv(vm), NULL);
+			drm_gpuvm_bo_extobj_add(op_ctx->map.vm_bo);
+			dma_resv_unlock(panthor_vm_resv(vm));
+		}
 
-	/* And finally update the BO state. */
-	dma_resv_lock(bo->base.resv, NULL);
-	mutex_lock(&bo->base.gpuva.lock);
-	panthor_gem_update_reclaim_state_locked(bo, NULL);
-	mutex_unlock(&bo->base.gpuva.lock);
-	dma_resv_unlock(bo->base.resv);
+		/* And finally update the BO state. */
+		dma_resv_lock(bo->base.resv, NULL);
+		mutex_lock(&bo->base.gpuva.lock);
+		panthor_gem_update_reclaim_state_locked(bo, NULL);
+		mutex_unlock(&bo->base.gpuva.lock);
+		dma_resv_unlock(bo->base.resv);
+	}
 
 	return 0;
 
@@ -2148,13 +2195,43 @@ static void panthor_vma_init(struct panthor_vma *vma, u32 flags)
 #define PANTHOR_VM_MAP_FLAGS \
 	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
 	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
-	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED)
+	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED | \
+	 DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
+
+static int
+panthor_vm_map(struct panthor_vm *vm, bool sparse, struct sg_table *sgt,
+	       u64 addr, u64 offset, u64 size, int prot)
+{
+	int ret;
+
+	if (!size)
+		return 0;
+
+	if (!sparse)
+		return panthor_vm_map_pages(vm, addr, prot, sgt, offset, size);
+
+	drm_WARN_ON(&vm->ptdev->base, sgt->sgl->length != SZ_2M);
+
+	if (addr & (SZ_2M - 1)) {
+		u64 unaligned_size = min(ALIGN(addr, SZ_2M) - addr, size);
+
+		ret = panthor_vm_map_pages(vm, addr, prot, sgt,
+					   0, unaligned_size);
+		if (ret)
+			return ret;
+
+		size -= unaligned_size;
+	}
+
+	return panthor_vm_repeated_map_pages(vm, addr, prot, sgt, size);
+}
 
 static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
 {
 	struct panthor_vm *vm = priv;
 	struct panthor_vm_op_ctx *op_ctx = vm->op_ctx;
 	struct panthor_vma *vma = panthor_vm_op_ctx_get_vma(op_ctx);
+	bool is_sparse = op_ctx->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
 	int ret;
 
 	if (!vma)
@@ -2162,19 +2239,20 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
 
 	panthor_vma_init(vma, op_ctx->flags & PANTHOR_VM_MAP_FLAGS);
 
-	ret = panthor_vm_map_pages(vm, op->map.va.addr, flags_to_prot(vma->flags),
-				   op_ctx->map.bo->dmap.sgt, op->map.gem.offset,
-				   op->map.va.range);
+	ret = panthor_vm_map(vm, is_sparse, op_ctx->map.sgt, op->map.va.addr,
+			     op->map.gem.offset, op->map.va.range, flags_to_prot(vma->flags));
 	if (ret) {
 		panthor_vm_op_ctx_return_vma(op_ctx, vma);
 		return ret;
 	}
 
 	drm_gpuva_map(&vm->base, &vma->base, &op->map);
-	panthor_vma_link(vm, vma, op_ctx->map.vm_bo);
 
-	drm_gpuvm_bo_put_deferred(op_ctx->map.vm_bo);
-	op_ctx->map.vm_bo = NULL;
+	if (!is_sparse) {
+		panthor_vma_link(vm, vma, op_ctx->map.vm_bo);
+		drm_gpuvm_bo_put_deferred(op_ctx->map.vm_bo);
+		op_ctx->map.vm_bo = NULL;
+	}
 
 	return 0;
 }
@@ -2194,7 +2272,7 @@ iova_mapped_as_huge_page(struct drm_gpuva_op_map *op, u64 addr)
 
 static void
 unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
-		     u64 *unmap_start, u64 *unmap_range)
+		     u64 *unmap_start, u64 *unmap_range, bool sparse)
 {
 	u64 aligned_unmap_start, aligned_unmap_end, unmap_end;
 
@@ -2207,7 +2285,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
 	 */
 	if (op->prev && aligned_unmap_start < *unmap_start &&
 	    op->prev->va.addr <= aligned_unmap_start &&
-	    iova_mapped_as_huge_page(op->prev, *unmap_start)) {
+	    (sparse || iova_mapped_as_huge_page(op->prev, *unmap_start))) {
 		*unmap_range += *unmap_start - aligned_unmap_start;
 		*unmap_start = aligned_unmap_start;
 	}
@@ -2217,7 +2295,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
 	 */
 	if (op->next && aligned_unmap_end > unmap_end &&
 	    op->next->va.addr + op->next->va.range >= aligned_unmap_end &&
-	    iova_mapped_as_huge_page(op->next, unmap_end - 1)) {
+	    (sparse || iova_mapped_as_huge_page(op->next, *unmap_start))) {
 		*unmap_range += aligned_unmap_end - unmap_end;
 	}
 }
@@ -2229,6 +2307,8 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 	struct panthor_vm *vm = priv;
 	struct panthor_vm_op_ctx *op_ctx = vm->op_ctx;
 	struct panthor_vma *prev_vma = NULL, *next_vma = NULL;
+	struct sg_table *sgt = vm->ptdev->mmu->dummy.sgt;
+	bool is_sparse = unmap_vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
 	u64 unmap_start, unmap_range;
 	int ret;
 
@@ -2241,7 +2321,7 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 	 * unmap region. Calculating the right start address and range for the expanded
 	 * unmap operation is the responsibility of the following function.
 	 */
-	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
+	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range, is_sparse);
 
 	/* If the range changed, we might have to lock a wider region to guarantee
 	 * atomicity. panthor_vm_lock_region() bails out early if the new region
@@ -2253,14 +2333,15 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 	}
 
 	if (op->remap.prev) {
-		struct panthor_gem_object *bo = to_panthor_bo(op->remap.prev->gem.obj);
 		u64 offset = op->remap.prev->gem.offset + unmap_start - op->remap.prev->va.addr;
 		u64 size = op->remap.prev->va.addr + op->remap.prev->va.range - unmap_start;
 
+		if (!is_sparse)
+			sgt = to_panthor_bo(op->remap.prev->gem.obj)->dmap.sgt;
+
 		if (!unmap_vma->evicted) {
-			ret = panthor_vm_map_pages(vm, unmap_start,
-						   flags_to_prot(unmap_vma->flags),
-						   bo->dmap.sgt, offset, size);
+			ret = panthor_vm_map(vm, is_sparse, sgt, unmap_start, offset,
+					     size, flags_to_prot(unmap_vma->flags));
 			if (ret)
 				return ret;
 		}
@@ -2271,14 +2352,16 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 	}
 
 	if (op->remap.next) {
-		struct panthor_gem_object *bo = to_panthor_bo(op->remap.next->gem.obj);
 		u64 addr = op->remap.next->va.addr;
 		u64 size = unmap_start + unmap_range - op->remap.next->va.addr;
 
+		if (!is_sparse)
+			sgt = to_panthor_bo(op->remap.next->gem.obj)->dmap.sgt;
+
 		if (!unmap_vma->evicted) {
-			ret = panthor_vm_map_pages(vm, addr, flags_to_prot(unmap_vma->flags),
-						   bo->dmap.sgt, op->remap.next->gem.offset,
-						   size);
+			ret = panthor_vm_map(vm, is_sparse, sgt, addr,
+					     op->remap.next->gem.offset, size,
+					     flags_to_prot(unmap_vma->flags));
 			if (ret)
 				return ret;
 		}
@@ -2292,20 +2375,22 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 			next_vma ? &next_vma->base : NULL,
 			&op->remap);
 
-	if (prev_vma) {
-		/* panthor_vma_link() transfers the vm_bo ownership to
-		 * the VMA object. Since the vm_bo we're passing is still
-		 * owned by the old mapping which will be released when this
-		 * mapping is destroyed, we need to grab a ref here.
-		 */
-		panthor_vma_link(vm, prev_vma, op->remap.unmap->va->vm_bo);
-	}
+	if (!is_sparse) {
+		if (prev_vma) {
+			/* panthor_vma_link() transfers the vm_bo ownership to
+			 * the VMA object. Since the vm_bo we're passing is still
+			 * owned by the old mapping which will be released when this
+			 * mapping is destroyed, we need to grab a ref here.
+			 */
+			panthor_vma_link(vm, prev_vma, op->remap.unmap->va->vm_bo);
+		}
+
+		if (next_vma)
+			panthor_vma_link(vm, next_vma, op->remap.unmap->va->vm_bo);
 
-	if (next_vma) {
-		panthor_vma_link(vm, next_vma, op->remap.unmap->va->vm_bo);
+		panthor_vma_unlink(unmap_vma);
 	}
 
-	panthor_vma_unlink(unmap_vma);
 	return 0;
 }
 
@@ -2579,11 +2664,9 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 
 	switch (op_type) {
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP: {
-		const struct drm_gpuvm_map_req map_req = {
+		struct drm_gpuvm_map_req map_req = {
 			.map.va.addr = op->va.addr,
 			.map.va.range = op->va.range,
-			.map.gem.obj = op->map.vm_bo->obj,
-			.map.gem.offset = op->map.bo_offset,
 		};
 
 		if (vm->unusable) {
@@ -2591,6 +2674,11 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 			break;
 		}
 
+		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {
+			map_req.map.gem.obj = op->map.vm_bo->obj;
+			map_req.map.gem.offset = op->map.bo_offset;
+		}
+
 		ret = drm_gpuvm_sm_map(&vm->base, vm, &map_req);
 		break;
 	}
@@ -3041,6 +3129,9 @@ int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_object *bo
 	struct panthor_vm_op_ctx op_ctx;
 	int ret;
 
+	if (drm_WARN_ON(&vm->ptdev->base, flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE))
+		return -EINVAL;
+
 	op = (struct drm_panthor_vm_bind_op){
 		.bo_offset = offset,
 		.size = size,
@@ -3204,6 +3295,10 @@ void panthor_mmu_unplug(struct panthor_device *ptdev)
 		}
 	}
 	mutex_unlock(&ptdev->mmu->as.slots_lock);
+
+	sg_free_table(ptdev->mmu->dummy.sgt);
+	kfree(ptdev->mmu->dummy.sgt);
+	__free_pages(ptdev->mmu->dummy.pages, get_order(SZ_2M));
 }
 
 static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
@@ -3269,7 +3364,33 @@ int panthor_mmu_init(struct panthor_device *ptdev)
 		ptdev->gpu_info.mmu_features |= BITS_PER_LONG;
 	}
 
+	mmu->dummy.pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(SZ_2M));
+	if (!mmu->dummy.pages)
+		return -ENOMEM;
+
+	mmu->dummy.sgt = kzalloc_obj(*mmu->dummy.sgt);
+	if (!mmu->dummy.sgt) {
+		ret = -ENOMEM;
+		goto mmu_init_free_pages;
+	}
+
+	ret = sg_alloc_table(mmu->dummy.sgt, 1, GFP_KERNEL);
+	if (ret) {
+		ret = -ENOMEM;
+		goto mmu_init_free_sgtable;
+	}
+
+	sg_set_page(mmu->dummy.sgt->sgl, mmu->dummy.pages, SZ_2M, 0);
+	sg_dma_address(mmu->dummy.sgt->sgl) = page_to_phys(mmu->dummy.pages);
+	sg_dma_len(mmu->dummy.sgt->sgl) = SZ_2M;
+
 	return drmm_add_action_or_reset(&ptdev->base, panthor_mmu_release_wq, mmu->vm.wq);
+
+mmu_init_free_sgtable:
+	kfree(mmu->dummy.sgt);
+mmu_init_free_pages:
+	__free_pages(mmu->dummy.pages, get_order(SZ_2M));
+	return ret;
 }
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index dc2704fc2829..9e7197845ea4 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -614,6 +614,18 @@ enum drm_panthor_vm_bind_op_flags {
 	 */
 	DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED = 1 << 2,
 
+	/**
+	 * @DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE: Repeat a BO range
+	 *
+	 * Only valid with DRM_PANTHOR_VM_BIND_OP_TYPE_MAP.
+	 *
+	 * When this flag is set, the whole vm_bind range is mapped over a dummy
+	 * object in a cyclic fashion, and all GPU reads from the addresses in the
+	 * range return 0. This flag being set means drm_panthor_vm_bind_op:offset
+	 * and drm_panthor_vm_bind_op::handle must both be set to 0.
+	 */
+	DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE = 1 << 3,
+
 	/**
 	 * @DRM_PANTHOR_VM_BIND_OP_TYPE_MASK: Mask used to determine the type of operation.
 	 */
@@ -677,7 +689,6 @@ struct drm_panthor_vm_bind_op {
 	 * This array shall not be empty for sync-only operations.
 	 */
 	struct drm_panthor_obj_array syncs;
-
 };
 
 /**
-- 
2.53.0

