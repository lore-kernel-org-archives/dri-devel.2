Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C036F4198B
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:29:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F3810E6C6;
	Wed, 15 Apr 2026 11:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Gtk9NPKe";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A84B210E6C6
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 11:29:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776252571; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HTuobjd2YRoNQ9qxRno9JMJQj/qqG6x1nRV49Cu2JoFNy+0sT/BQi6V/cd+wGNRk8wDFyfO9yfThLRO3lRVquyJwQjkCCd/1Vr7sJk28tgB/GX7X27UcF89OESjam+4LB4xg/om5JODsvX0sZNFWGRJGhc3lr0xmzf+39G8sx50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776252571;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=xAGev2Qifxqa0aKReAbyNbQYeHnCz+Zkmy7+0LBa2mQ=; 
 b=lvShHwuFl+iCdLpcwUn4BgEZEIzV+0iaz6vfzbTzJbJSZhUDIVWL8HuufdWrXXdjBJVihPVpZtVfEnJqmxb1lfEPiDtREXZSyekrwPSHqTLkIwbP8GyQJuFNjZJOTkFpfvA3x3VfaiPRKVD1xUKgREiIwior5Y6JLqedsCz6HEk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776252570; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=xAGev2Qifxqa0aKReAbyNbQYeHnCz+Zkmy7+0LBa2mQ=;
 b=Gtk9NPKeMRftaJWVS4GnlgT8Cwx7uyyt8z7Y8dLGtwQnHwiFXroBBxOCa4E8e6bg
 rHioXkf/mz9jdVzpYFq4OJEKc6vyWwyT96evjzbOhTIfghynWPCLZMc1Q3dhVR8Fj6S
 rVpIEPb1nj4P3do7JlxeQxTTsUZAqGTYEBy0pcoc=
Received: by mx.zohomail.com with SMTPS id 1776252568679618.3062224182121;
 Wed, 15 Apr 2026 04:29:28 -0700 (PDT)
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
Subject: [PATCH v7 5/6] drm/panthor: Support sparse mappings
Date: Wed, 15 Apr 2026 12:28:49 +0100
Message-ID: <20260415112900.681834-6-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415112900.681834-1-adrian.larumbe@collabora.com>
References: <20260415112900.681834-1-adrian.larumbe@collabora.com>
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
virtual ranges over a kernel-allocated dummy BO. This alternative is
preferable to the old method of handling sparseness in the UMD, because it
relied on the creation of a buffer object to the same end, despite the fact
Vulkan sparse resources don't need to be backed by a driver BO.

The choice of backing sparsely-bound regions with a Panhtor BO was made so
as to profit from the existing shrinker reclaim code. That way no special
treatment must be given to the dummy sparse BOs when reclaiming memory, as
would be the case if we had chosen a raw kernel page implementation.

A new dummy BO is allocated per open file context, because even though the
Vulkan spec mandates that writes into sparsely bound regions must be
discarded, our implementation is still a workaround over the fact Mali CSF
GPUs cannot support this behaviour on the hardware level, so writes still
make it into the backing BO. If we had a global one, then it could be a
venue for information leaks between file contexts, which should never
happen in DRM.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_gem.c |  35 +++++
 drivers/gpu/drm/panthor/panthor_gem.h |   2 +
 drivers/gpu/drm/panthor/panthor_mmu.c | 192 ++++++++++++++++++++++----
 include/uapi/drm/panthor_drm.h        |  12 ++
 4 files changed, 215 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 13295d7a593d..e27251ef113b 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -1345,6 +1345,41 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 	return ERR_PTR(ret);
 }
 
+/**
+ * panthor_dummy_bo_create() - Create a Panthor BO meant to back sparse bindings.
+ * @ptdev: Device.
+ *
+ * Return: A valid pointer in case of success, an ERR_PTR() otherwise.
+ */
+struct panthor_gem_object *
+panthor_dummy_bo_create(struct panthor_device *ptdev)
+{
+	u32 dummy_flags = DRM_PANTHOR_BO_NO_MMAP;
+	struct panthor_gem_object *bo;
+	struct page **pages;
+
+	bo = panthor_gem_create(&ptdev->base, SZ_2M, dummy_flags, NULL, 0);
+	if (IS_ERR_OR_NULL(bo))
+		return bo;
+
+	pages = drm_gem_get_pages(&bo->base);
+	if (PTR_ERR(pages) == -ENOMEM) {
+		drm_gem_object_put(&bo->base);
+		bo = panthor_gem_create(&ptdev->base, SZ_4K, dummy_flags, NULL, 0);
+		if (IS_ERR_OR_NULL(bo))
+			return bo;
+		pages = drm_gem_get_pages(&bo->base);
+	}
+
+	if (IS_ERR_OR_NULL(pages)) {
+		drm_gem_object_put(&bo->base);
+		return ERR_CAST(pages);
+	}
+
+	bo->backing.pages = pages;
+	return bo;
+}
+
 static bool can_swap(void)
 {
 	return get_nr_swap_pages() > 0;
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index ae0491d0b121..dcf9cdd51d93 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -264,6 +264,8 @@ void panthor_gem_kernel_bo_set_label(struct panthor_kernel_bo *bo, const char *l
 int panthor_gem_sync(struct drm_gem_object *obj,
 		     u32 type, u64 offset, u64 size);
 
+struct panthor_gem_object *panthor_dummy_bo_create(struct panthor_device *ptdev);
+
 struct drm_gem_object *
 panthor_gem_prime_import(struct drm_device *dev,
 			 struct dma_buf *dma_buf);
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index cea78e5f0591..6585fd6b5d04 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -112,6 +112,23 @@ struct panthor_mmu {
 struct panthor_vm_pool {
 	/** @xa: Array used for VM handle tracking. */
 	struct xarray xa;
+
+	/** @dummy: Dummy drm object related fields
+	 *
+	 * Sparse bindings map virtual address ranges onto a dummy
+	 * BO in a modulo fashion. Even though sparse writes are meant
+	 * to be discarded and reads undefined, writes are still reflected
+	 * in the dummy buffer. That means we must keep a dummy object per
+	 * file context, to avoid data leaks between them.
+	 *
+	 */
+	struct {
+		/** @dummy.obj: Dummy object used for sparse mappings. */
+		struct panthor_gem_object *obj;
+
+		/** @dummy.lock: Lock protecting against races on dummy object. */
+		struct mutex lock;
+	} dummy;
 };
 
 /**
@@ -391,6 +408,15 @@ struct panthor_vm {
 		 */
 		struct list_head lru_node;
 	} reclaim;
+
+	/** @dummy: Dummy object used for sparse mappings.
+	 *
+	 * VM's must keep a reference to the file context-wide dummy BO because
+	 * they can outlive the file context, which includes the VM pool holding
+	 * the original dummy BO reference.
+	 *
+	 */
+	struct panthor_gem_object *dummy;
 };
 
 /**
@@ -1020,6 +1046,46 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 	return 0;
 }
 
+static int
+panthor_vm_map_sparse(struct panthor_vm *vm, u64 iova, int prot,
+		      struct sg_table *sgt, u64 size)
+{
+	u64 first_iova = iova;
+	u64 first_size = size;
+	int ret;
+
+	if (iova & (SZ_2M - 1)) {
+		u64 unaligned_size = min(ALIGN(iova, SZ_2M) - iova, size);
+
+		ret = panthor_vm_map_pages(vm, iova, prot, sgt,
+					   0, unaligned_size);
+		if (ret)
+			return ret;
+
+		size -= unaligned_size;
+		iova += unaligned_size;
+	}
+
+	/* TODO: we should probably optimize this at the io_pgtable level. */
+	while (size > 0) {
+		u64 next_size = min(size, sg_dma_len(sgt->sgl));
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
@@ -1258,38 +1324,71 @@ static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
 	return 0;
 }
 
+static struct panthor_gem_object *
+panthor_vm_get_dummy_obj(struct panthor_vm_pool *pool,
+			 struct panthor_vm *vm)
+{
+	scoped_guard(mutex, &pool->dummy.lock) {
+		if (!vm->dummy) {
+			if (!pool->dummy.obj) {
+				struct panthor_gem_object *obj =
+					panthor_dummy_bo_create(vm->ptdev);
+				if (IS_ERR(obj))
+					return obj;
+
+				pool->dummy.obj = obj;
+			}
+
+			drm_gem_object_get(&pool->dummy.obj->base);
+			vm->dummy = pool->dummy.obj;
+		}
+	}
+
+	return vm->dummy;
+}
+
 #define PANTHOR_VM_BIND_OP_MAP_FLAGS \
 	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
 	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
 	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED | \
+	 DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE | \
 	 DRM_PANTHOR_VM_BIND_OP_TYPE_MASK)
 
 static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
+					 struct panthor_vm_pool *pool,
 					 struct panthor_vm *vm,
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
 
 	/* Make sure the VA and size are in-bounds. */
-	if (op->size > bo->base.size || op->bo_offset > bo->base.size - op->size)
+	if (bo && (is_sparse || op->size > bo->base.size ||
+		   op->bo_offset > bo->base.size - op->size))
 		return -EINVAL;
+	else if (is_sparse && (!pool || op->bo_handle || op->bo_offset))
+		return -EINVAL;
+
+	if (is_sparse) {
+		bo = panthor_vm_get_dummy_obj(pool, vm);
+		if (IS_ERR_OR_NULL(bo))
+			return PTR_ERR(bo);
+	}
 
 	/* If the BO has an exclusive VM attached, it can't be mapped to other VMs. */
 	if (bo->exclusive_vm_root_gem &&
 	    bo->exclusive_vm_root_gem != panthor_vm_root_gem(vm))
 		return -EINVAL;
 
-	panthor_vm_init_op_ctx(op_ctx, op->size, op->va, op->flags);
+	panthor_vm_init_op_ctx(op_ctx, op->size, op->va, op->flags
+			       | ((is_sparse) ? DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC : 0));
 
 	ret = panthor_vm_op_ctx_prealloc_vmas(op_ctx);
 	if (ret)
@@ -1634,6 +1733,13 @@ void panthor_vm_pool_destroy(struct panthor_file *pfile)
 	xa_for_each(&pfile->vms->xa, i, vm)
 		panthor_vm_destroy(vm);
 
+	scoped_guard(mutex, &pfile->vms->dummy.lock) {
+		struct panthor_gem_object *bo = pfile->vms->dummy.obj;
+
+		if (bo)
+			drm_gem_object_put(&bo->base);
+	}
+
 	xa_destroy(&pfile->vms->xa);
 	kfree(pfile->vms);
 }
@@ -1651,6 +1757,8 @@ int panthor_vm_pool_create(struct panthor_file *pfile)
 		return -ENOMEM;
 
 	xa_init_flags(&pfile->vms->xa, XA_FLAGS_ALLOC1);
+
+	mutex_init(&pfile->vms->dummy.lock);
 	return 0;
 }
 
@@ -1987,6 +2095,9 @@ static void panthor_vm_free(struct drm_gpuvm *gpuvm)
 
 	free_io_pgtable_ops(vm->pgtbl_ops);
 
+	if (vm->dummy)
+		drm_gem_object_put(&vm->dummy->base);
+
 	drm_mm_takedown(&vm->mm);
 	kfree(vm);
 }
@@ -2146,7 +2257,26 @@ static void panthor_vma_init(struct panthor_vma *vma, u32 flags)
 #define PANTHOR_VM_MAP_FLAGS \
 	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
 	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
-	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED)
+	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED | \
+	 DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
+
+static int
+panthor_vm_exec_map_op(struct panthor_vm *vm, u32 flags,
+		       const struct drm_gpuva_op_map *op)
+{
+	struct panthor_gem_object *bo = to_panthor_bo(op->gem.obj);
+	int prot = flags_to_prot(flags);
+
+	if (!op->va.range)
+		return 0;
+
+	if (flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
+		return panthor_vm_map_sparse(vm, op->va.addr, prot,
+					     bo->dmap.sgt, op->va.range);
+
+	return panthor_vm_map_pages(vm, op->va.addr, prot, bo->dmap.sgt,
+				    op->gem.offset, op->va.range);
+}
 
 static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
 {
@@ -2160,9 +2290,7 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
 
 	panthor_vma_init(vma, op_ctx->flags & PANTHOR_VM_MAP_FLAGS);
 
-	ret = panthor_vm_map_pages(vm, op->map.va.addr, flags_to_prot(vma->flags),
-				   op_ctx->map.bo->dmap.sgt, op->map.gem.offset,
-				   op->map.va.range);
+	ret = panthor_vm_exec_map_op(vm, vma->flags, &op->map);
 	if (ret) {
 		panthor_vm_op_ctx_return_vma(op_ctx, vma);
 		return ret;
@@ -2178,13 +2306,15 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
 }
 
 static bool
-iova_mapped_as_huge_page(struct drm_gpuva_op_map *op, u64 addr)
+iova_mapped_as_huge_page(struct drm_gpuva_op_map *op, u64 addr, bool is_sparse)
 {
 	struct panthor_gem_object *bo = to_panthor_bo(op->gem.obj);
 	const struct page *pg;
 	pgoff_t bo_offset;
 
 	bo_offset = addr - op->va.addr + op->gem.offset;
+	if (is_sparse)
+		bo_offset %= bo->base.size;
 	pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
 
 	return folio_size(page_folio(pg)) >= SZ_2M;
@@ -2194,6 +2324,8 @@ static void
 unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
 		     u64 *unmap_start, u64 *unmap_range)
 {
+	struct panthor_vma *unmap_vma = container_of(op->unmap->va, struct panthor_vma, base);
+	bool is_sparse = unmap_vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
 	u64 aligned_unmap_start, aligned_unmap_end, unmap_end;
 
 	unmap_end = *unmap_start + *unmap_range;
@@ -2205,7 +2337,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
 	 */
 	if (op->prev && aligned_unmap_start < *unmap_start &&
 	    op->prev->va.addr <= aligned_unmap_start &&
-	    iova_mapped_as_huge_page(op->prev, *unmap_start)) {
+	    (iova_mapped_as_huge_page(op->prev, *unmap_start, is_sparse))) {
 		*unmap_range += *unmap_start - aligned_unmap_start;
 		*unmap_start = aligned_unmap_start;
 	}
@@ -2215,7 +2347,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
 	 */
 	if (op->next && aligned_unmap_end > unmap_end &&
 	    op->next->va.addr + op->next->va.range >= aligned_unmap_end &&
-	    iova_mapped_as_huge_page(op->next, unmap_end - 1)) {
+	    (iova_mapped_as_huge_page(op->next, *unmap_start, is_sparse))) {
 		*unmap_range += aligned_unmap_end - unmap_end;
 	}
 }
@@ -2251,14 +2383,17 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 	}
 
 	if (op->remap.prev) {
-		struct panthor_gem_object *bo = to_panthor_bo(op->remap.prev->gem.obj);
-		u64 offset = op->remap.prev->gem.offset + unmap_start - op->remap.prev->va.addr;
-		u64 size = op->remap.prev->va.addr + op->remap.prev->va.range - unmap_start;
+		const struct drm_gpuva_op_map map_op = {
+			.va.addr = unmap_start,
+			.va.range =
+			op->remap.prev->va.addr + op->remap.prev->va.range - unmap_start,
+			.gem.obj = op->remap.prev->gem.obj,
+			.gem.offset =
+			op->remap.prev->gem.offset + unmap_start - op->remap.prev->va.addr,
+		};
 
 		if (!unmap_vma->evicted) {
-			ret = panthor_vm_map_pages(vm, unmap_start,
-						   flags_to_prot(unmap_vma->flags),
-						   bo->dmap.sgt, offset, size);
+			ret = panthor_vm_exec_map_op(vm, unmap_vma->flags, &map_op);
 			if (ret)
 				return ret;
 		}
@@ -2269,14 +2404,15 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 	}
 
 	if (op->remap.next) {
-		struct panthor_gem_object *bo = to_panthor_bo(op->remap.next->gem.obj);
-		u64 addr = op->remap.next->va.addr;
-		u64 size = unmap_start + unmap_range - op->remap.next->va.addr;
+		const struct drm_gpuva_op_map map_op = {
+			.va.addr = op->remap.next->va.addr,
+			.va.range = unmap_start + unmap_range - op->remap.next->va.addr,
+			.gem.obj = op->remap.next->gem.obj,
+			.gem.offset = op->remap.next->gem.offset,
+		};
 
 		if (!unmap_vma->evicted) {
-			ret = panthor_vm_map_pages(vm, addr, flags_to_prot(unmap_vma->flags),
-						   bo->dmap.sgt, op->remap.next->gem.offset,
-						   size);
+			ret = panthor_vm_exec_map_op(vm, unmap_vma->flags, &map_op);
 			if (ret)
 				return ret;
 		}
@@ -2826,6 +2962,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 			       const struct drm_panthor_vm_bind_op *op,
 			       struct panthor_vm_op_ctx *op_ctx)
 {
+	struct panthor_file *pfile = file->driver_priv;
 	ssize_t vm_pgsz = panthor_vm_page_size(vm);
 	struct drm_gem_object *gem;
 	int ret;
@@ -2837,7 +2974,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
 		gem = drm_gem_object_lookup(file, op->bo_handle);
-		ret = panthor_vm_prepare_map_op_ctx(op_ctx, vm,
+		ret = panthor_vm_prepare_map_op_ctx(op_ctx, pfile->vms, vm,
 						    gem ? to_panthor_bo(gem) : NULL,
 						    op);
 		drm_gem_object_put(gem);
@@ -3044,7 +3181,10 @@ int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_object *bo
 	struct panthor_vm_op_ctx op_ctx;
 	int ret;
 
-	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, &op);
+	if (drm_WARN_ON(&vm->ptdev->base, flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE))
+		return -EINVAL;
+
+	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, NULL, vm, bo, &op);
 	if (ret)
 		return ret;
 
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 42c901ebdb7a..1a9bcfc8f4cd 100644
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
+	 * When this flag is set, the whole vm_bind range is mapped over a dummy  object in a cyclic
+	 * fashion, and all GPU reads from addresses in the range return undefined values. This flag
+	 * being set means drm_panthor_vm_bind_op:offset and drm_panthor_vm_bind_op::handle must
+	 * both be set to 0.
+	 */
+	DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE = 1 << 3,
+
 	/**
 	 * @DRM_PANTHOR_VM_BIND_OP_TYPE_MASK: Mask used to determine the type of operation.
 	 */
-- 
2.53.0

