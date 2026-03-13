Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39983105F7B3
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9954A10E177;
	Fri, 13 Mar 2026 15:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="XeE91emf";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 200A010E177
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:11:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773414678; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Bh6c7GmVpy04A+MYlCnYgCx2DOmQ4gXk9ueRwhwDSnAvWdECq4+nPCyLrstMyIA23jezmrSQEDxOXjcV/RkBvc2slFS4hj/DhJ5bPNKBbgzyvZSSN1f84dZUevLc7mvWApHD0M013XKOEk1kwZe6pj07k2SJJHC5fYcOq51FK9M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773414678;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Y2E0wsyv9RRhn9eDVmJKT3KYQMgMU8DrKRtF/d1Ct/8=; 
 b=g1Y+Bu6/QpcgoRlO+oFoo0nONyutojn/+W5KgjZh6mVLSLmRGotjkqB7IFylfyr/ddON7G7Xm2WdZkFHmAP3CJ8tXjZaQ29StElJjuAGnsW4s5m3Z+ccLLGUPaFUR6CLKnL6VmfruHM3o/2hWHTQhT4bqU/2Qe8PeWLgKb8NavU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773414678; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=Y2E0wsyv9RRhn9eDVmJKT3KYQMgMU8DrKRtF/d1Ct/8=;
 b=XeE91emfI/hvotxiF1t1ln9rmjv3ac8J/Y3NxdYpfU3fhn5qw8S66HpMJRIhAq+r
 8sZ8eMfPIKdoCkEKvs2fHlwKIWBBrVSHFEufTNqzxRK70PI4j/fld2Fd44Hp6UXFzVO
 LPEp6PyK5R/jv8KXvisTsWEH/txw/5bDKG4VvXS8=
Received: by mx.zohomail.com with SMTPS id 177341467546464.77577555718221;
 Fri, 13 Mar 2026 08:11:15 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Caterina Shablia <caterina.shablia@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Subject: [PATCH v5 08/11] drm/panthor: Add support for repeated mappings
Date: Fri, 13 Mar 2026 15:09:45 +0000
Message-ID: <20260313150956.1618635-9-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
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

This allows us to optimize mapping of a relatively small
portion of a BO over and over in a large VA range, which
is useful to support Vulkan sparse bindings in an efficient
way.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Caterina Shablia <caterina.shablia@collabora.com>
Signed-off-by: Caterina Shablia <caterina.shablia@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 109 +++++++++++++++++++++++---
 include/uapi/drm/panthor_drm.h        |  20 +++++
 2 files changed, 120 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 07c520475f14..a357063bb9f6 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -190,6 +190,9 @@ struct panthor_vm_op_ctx {
 		/** @map.bo_offset: Offset in the buffer object. */
 		u64 bo_offset;
 
+		/** @map.bo_repeat_range: Repeated BO range. */
+		u32 bo_repeat_range;
+
 		/**
 		 * @map.sgt: sg-table pointing to pages backing the GEM object.
 		 *
@@ -1003,6 +1006,29 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
 	return 0;
 }
 
+static int
+panthor_vm_repeated_map_pages(struct panthor_vm *vm, u64 iova, int prot,
+			      struct sg_table *sgt, u64 offset, u64 size,
+			      u64 count)
+{
+	int ret;
+	u64 i;
+
+	/* FIXME: we really need to optimize this at the io_pgtable level. */
+	for (i = 0; i < count; i++) {
+		ret = panthor_vm_map_pages(vm, iova + (size * i), prot,
+					   sgt, offset, size);
+		if (ret)
+			goto err_unmap;
+	}
+
+	return 0;
+
+err_unmap:
+	panthor_vm_unmap_pages(vm, iova, size * (i - 1));
+	return ret;
+}
+
 static int flags_to_prot(u32 flags)
 {
 	int prot = 0;
@@ -1184,12 +1210,14 @@ panthor_vm_op_ctx_prealloc_vmas(struct panthor_vm_op_ctx *op_ctx)
 	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
 	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
 	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED | \
+	 DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT | \
 	 DRM_PANTHOR_VM_BIND_OP_TYPE_MASK)
 
 static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 					 struct panthor_vm *vm,
 					 struct panthor_gem_object *bo,
 					 u64 offset,
+					 u64 repeat_range,
 					 u64 size, u64 va,
 					 u32 flags)
 {
@@ -1205,9 +1233,28 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	    (flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
 		return -EINVAL;
 
-	/* Make sure the VA and size are in-bounds. */
-	if (size > bo->base.base.size || offset > bo->base.base.size - size)
-		return -EINVAL;
+	if (!(flags & DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT)) {
+		/* Make sure the VA and size are in-bounds. */
+		if (size > bo->base.base.size || offset > bo->base.base.size - size)
+			return -EINVAL;
+	} else {
+		/* Current drm api uses 32-bit for repeat range, */
+		if (repeat_range > U32_MAX)
+			return -EINVAL;
+
+		/* Make sure the repeat_range is in-bounds. */
+		if (repeat_range > bo->base.base.size || offset > bo->base.base.size - repeat_range)
+			return -EINVAL;
+
+		/* Repeat range must a multiple of the minimum GPU page size */
+		if (repeat_range & ((1u << (ffs(vm->ptdev->mmu_info.page_size_bitmap) - 1)) - 1))
+			return -EINVAL;
+
+		u64 repeat_count = size;
+
+		if (do_div(repeat_count, repeat_range))
+			return -EINVAL;
+	}
 
 	/* If the BO has an exclusive VM attached, it can't be mapped to other VMs. */
 	if (bo->exclusive_vm_root_gem &&
@@ -1257,6 +1304,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	op_ctx->map.vm_bo = drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
 
 	op_ctx->map.bo_offset = offset;
+	op_ctx->map.bo_repeat_range = repeat_range;
 
 	/* L1, L2 and L3 page tables.
 	 * We could optimize L3 allocation by iterating over the sgt and merging
@@ -2088,9 +2136,29 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
 
 	panthor_vma_init(vma, op_ctx->flags & PANTHOR_VM_MAP_FLAGS);
 
-	ret = panthor_vm_map_pages(vm, op->map.va.addr, flags_to_prot(vma->flags),
-				   op_ctx->map.sgt, op->map.gem.offset,
-				   op->map.va.range);
+	if (op_ctx->flags & DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT) {
+		u64 repeat_count = op->map.va.range;
+
+		do_div(repeat_count, op->map.gem.repeat_range);
+
+		if (drm_WARN_ON(&vm->ptdev->base, !repeat_count))
+			return -EINVAL;
+
+		ret = panthor_vm_repeated_map_pages(vm, op->map.va.addr,
+						    flags_to_prot(vma->flags),
+						    op_ctx->map.sgt,
+						    op->map.gem.offset,
+						    op->map.gem.repeat_range,
+						    repeat_count);
+		if (!ret)
+			vm->base.flags |= DRM_GPUVM_HAS_REPEAT_MAPS;
+	} else {
+		ret = panthor_vm_map_pages(vm, op->map.va.addr,
+					   flags_to_prot(vma->flags),
+					   op_ctx->map.sgt, op->map.gem.offset,
+					   op->map.va.range);
+	}
+
 	if (ret) {
 		panthor_vm_op_ctx_return_vma(op_ctx, vma);
 		return ret;
@@ -2165,8 +2233,22 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 	 * page and then remap the difference between the huge page minus the requested
 	 * unmap region. Calculating the right start address and range for the expanded
 	 * unmap operation is the responsibility of the following function.
+	 * However, we never allow partial unmaps of repeated regions.
 	 */
-	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
+	if (op->remap.next && op->remap.prev) {
+		if (drm_WARN_ON(&vm->ptdev->base,
+				(op->remap.next->flags & DRM_GPUVA_REPEAT) !=
+				(op->remap.prev->flags & DRM_GPUVA_REPEAT)))
+			return -EINVAL;
+		if (drm_WARN_ON(&vm->ptdev->base,
+				op->remap.next->gem.repeat_range !=
+				op->remap.prev->gem.repeat_range))
+			return -EINVAL;
+	}
+
+	if (!(op->remap.next && (op->remap.next->flags & DRM_GPUVA_REPEAT)) &&
+	    !(op->remap.prev && (op->remap.prev->flags & DRM_GPUVA_REPEAT)))
+		unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
 
 	/* If the range changed, we might have to lock a wider region to guarantee
 	 * atomicity. panthor_vm_lock_region() bails out early if the new region
@@ -2283,7 +2365,7 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 
 	switch (op_type) {
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP: {
-		const struct drm_gpuvm_map_req map_req = {
+		struct drm_gpuvm_map_req map_req = {
 			.map.va.addr = op->va.addr,
 			.map.va.range = op->va.range,
 			.map.gem.obj = op->map.vm_bo->obj,
@@ -2295,6 +2377,11 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct panthor_vm_op_ctx *op,
 			break;
 		}
 
+		if (op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT) {
+			map_req.map.flags |= DRM_GPUVA_REPEAT;
+			map_req.map.gem.repeat_range = op->map.bo_repeat_range;
+		}
+
 		ret = drm_gpuvm_sm_map(&vm->base, vm, &map_req);
 		break;
 	}
@@ -2544,6 +2631,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 		ret = panthor_vm_prepare_map_op_ctx(op_ctx, vm,
 						    gem ? to_panthor_bo(gem) : NULL,
 						    op->bo_offset,
+						    op->bo_repeat_range,
 						    op->size,
 						    op->va,
 						    op->flags);
@@ -2745,7 +2833,10 @@ int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_object *bo
 	struct panthor_vm_op_ctx op_ctx;
 	int ret;
 
-	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, offset, size, va, flags);
+	if (drm_WARN_ON(&vm->ptdev->base, flags & DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT))
+		return -EINVAL;
+
+	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, offset, 0, size, va, flags);
 	if (ret)
 		return ret;
 
diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
index 4089271f3d36..46217ce2c0f5 100644
--- a/include/uapi/drm/panthor_drm.h
+++ b/include/uapi/drm/panthor_drm.h
@@ -555,6 +555,17 @@ enum drm_panthor_vm_bind_op_flags {
 	 */
 	DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED = 1 << 2,
 
+	/**
+	 * @DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT: Repeat a BO range
+	 *
+	 * Only valid with DRM_PANTHOR_VM_BIND_OP_TYPE_MAP.
+	 *
+	 * When this is set, a BO range is repeated over the VA range.
+	 * drm_panthor_vm_bind_op::bo_repeat_range defines the size of the
+	 * BO range to repeat.
+	 */
+	DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT = 1 << 3,
+
 	/**
 	 * @DRM_PANTHOR_VM_BIND_OP_TYPE_MASK: Mask used to determine the type of operation.
 	 */
@@ -619,6 +630,15 @@ struct drm_panthor_vm_bind_op {
 	 */
 	struct drm_panthor_obj_array syncs;
 
+	/**
+	 * @bo_repeat_range: The size of the range to be repeated.
+	 *
+	 * Must be zero if DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT is not set in
+	 * flags.
+	 *
+	 * Size must be a multiple of bo_repeat_range.
+	 */
+	__u64 bo_repeat_range;
 };
 
 /**
-- 
2.53.0

