Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8073105F7B3
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30C7910E17C;
	Fri, 13 Mar 2026 15:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Z4KUCYpi";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99D5410E17C
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:11:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773414684; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=izjpo6W6RF0UMwnOVS96ZTBAu3nCxWPmEyB5CriytlChhQvrMpiQchIa2BiYfcKrVWxgQzwvWCpAN8MKXkMwSrfBCwWMLqupaa8sqbttL5meJQsnHLvu2q9H/ey2kpJSzRIXoDdbHtV/T9UywntpGqfCM37jYwgkm5v/yItEXgM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773414684;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=qnDjhJwB7YQsAc4SJP4zeR66d3AGj+viwzL0mvH3ZSw=; 
 b=ibMDVZDyo0qt7YHB/Kloox15PgpgZYyB94m+HtxHwSCkQ24EBrTjOsPeYSf3wwxeIk4Zz1pyObjpqBL9rT8IIBXrG3TKdq7duYwQzSG2CMcdE9f7JNtDDUBteo0gzS5iGX1YCFB5VhvRonOEOkhjwm2J2LQUxR2eP03pRSUvlqM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773414684; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=qnDjhJwB7YQsAc4SJP4zeR66d3AGj+viwzL0mvH3ZSw=;
 b=Z4KUCYpi0BK3Q6ed/qDpnkSqp6XWSbvpKVXWO7PlhrUiad2ckrbgU9e2X9joXTVl
 RPg6giPrqq3hGsi0cRf7RSq2QxmV4xKvBovJEPlloWYEx5jwQZ17NArWKwjxwU3dJMm
 FbuSn+tMMSYQ5AHnYb0CHrXtgwpFim8CRHOGToqs=
Received: by mx.zohomail.com with SMTPS id 1773414681811353.32437567271097;
 Fri, 13 Mar 2026 08:11:21 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v5 10/11] drm/panthor: Pass vm_bind_op to vm_prepare_map_op_ctx
Date: Fri, 13 Mar 2026 15:09:47 +0000
Message-ID: <20260313150956.1618635-11-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
References: <20260313150956.1618635-1-adrian.larumbe@collabora.com>
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

Instead of passing its constituent elements, pass the whole struct to
simplify the function prototype.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 57 ++++++++++++++-------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index ba322e2029b9..a62ac715265b 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1216,10 +1216,7 @@ panthor_vm_op_ctx_prealloc_vmas(struct panthor_vm_op_ctx *op_ctx)
 static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 					 struct panthor_vm *vm,
 					 struct panthor_gem_object *bo,
-					 u64 offset,
-					 u64 repeat_range,
-					 u64 size, u64 va,
-					 u32 flags)
+					 const struct drm_panthor_vm_bind_op *op)
 {
 	struct drm_gpuvm_bo *preallocated_vm_bo;
 	struct sg_table *sgt = NULL;
@@ -1229,30 +1226,32 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	if (!bo)
 		return -EINVAL;
 
-	if ((flags & ~PANTHOR_VM_BIND_OP_MAP_FLAGS) ||
-	    (flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
+	if ((op->flags & ~PANTHOR_VM_BIND_OP_MAP_FLAGS) ||
+	    (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
 		return -EINVAL;
 
-	if (!(flags & DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT)) {
+	if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT)) {
 		/* Make sure the VA and size are in-bounds. */
-		if (size > bo->base.base.size || offset > bo->base.base.size - size)
+		if (op->size > bo->base.base.size || op->bo_offset > bo->base.base.size - op->size)
 			return -EINVAL;
 	} else {
 		/* Current drm api uses 32-bit for repeat range, */
-		if (repeat_range > U32_MAX)
+		if (op->bo_repeat_range > U32_MAX)
 			return -EINVAL;
 
 		/* Make sure the repeat_range is in-bounds. */
-		if (repeat_range > bo->base.base.size || offset > bo->base.base.size - repeat_range)
+		if (op->bo_repeat_range > bo->base.base.size ||
+		    op->bo_offset > bo->base.base.size - op->bo_repeat_range)
 			return -EINVAL;
 
 		/* Repeat range must a multiple of the minimum GPU page size */
-		if (repeat_range & ((1u << (ffs(vm->ptdev->mmu_info.page_size_bitmap) - 1)) - 1))
+		if (op->bo_repeat_range &
+		    ((1u << (ffs(vm->ptdev->mmu_info.page_size_bitmap) - 1)) - 1))
 			return -EINVAL;
 
-		u64 repeat_count = size;
+		u64 repeat_count = op->size;
 
-		if (do_div(repeat_count, repeat_range))
+		if (do_div(repeat_count, op->bo_repeat_range))
 			return -EINVAL;
 	}
 
@@ -1262,9 +1261,9 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 		return -EINVAL;
 
 	memset(op_ctx, 0, sizeof(*op_ctx));
-	op_ctx->flags = flags;
-	op_ctx->va.range = size;
-	op_ctx->va.addr = va;
+	op_ctx->flags = op->flags;
+	op_ctx->va.range = op->size;
+	op_ctx->va.addr = op->va;
 
 	ret = panthor_vm_op_ctx_prealloc_vmas(op_ctx);
 	if (ret)
@@ -1303,17 +1302,17 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 
 	op_ctx->map.vm_bo = drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
 
-	op_ctx->map.bo_offset = offset;
-	op_ctx->map.bo_repeat_range = repeat_range;
+	op_ctx->map.bo_offset = op->bo_offset;
+	op_ctx->map.bo_repeat_range = op->bo_repeat_range;
 
 	/* L1, L2 and L3 page tables.
 	 * We could optimize L3 allocation by iterating over the sgt and merging
 	 * 2M contiguous blocks, but it's simpler to over-provision and return
 	 * the pages if they're not used.
 	 */
-	pt_count = ((ALIGN(va + size, 1ull << 39) - ALIGN_DOWN(va, 1ull << 39)) >> 39) +
-		   ((ALIGN(va + size, 1ull << 30) - ALIGN_DOWN(va, 1ull << 30)) >> 30) +
-		   ((ALIGN(va + size, 1ull << 21) - ALIGN_DOWN(va, 1ull << 21)) >> 21);
+	pt_count = ((ALIGN(op->va + op->size, 1ull << 39) - ALIGN_DOWN(op->va, 1ull << 39)) >> 39) +
+		   ((ALIGN(op->va + op->size, 1ull << 30) - ALIGN_DOWN(op->va, 1ull << 30)) >> 30) +
+		   ((ALIGN(op->va + op->size, 1ull << 21) - ALIGN_DOWN(op->va, 1ull << 21)) >> 21);
 
 	op_ctx->rsvd_page_tables.pages = kcalloc(pt_count,
 						 sizeof(*op_ctx->rsvd_page_tables.pages),
@@ -2645,11 +2644,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 		gem = drm_gem_object_lookup(file, op->bo_handle);
 		ret = panthor_vm_prepare_map_op_ctx(op_ctx, vm,
 						    gem ? to_panthor_bo(gem) : NULL,
-						    op->bo_offset,
-						    op->bo_repeat_range,
-						    op->size,
-						    op->va,
-						    op->flags);
+						    op);
 		drm_gem_object_put(gem);
 		return ret;
 
@@ -2845,13 +2840,21 @@ int panthor_vm_bind_exec_sync_op(struct drm_file *file,
 int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_object *bo,
 			    u64 offset, u64 size, u64 va, u32 flags)
 {
+	struct drm_panthor_vm_bind_op op = {0};
 	struct panthor_vm_op_ctx op_ctx;
 	int ret;
 
 	if (drm_WARN_ON(&vm->ptdev->base, flags & DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT))
 		return -EINVAL;
 
-	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, offset, 0, size, va, flags);
+	op = (struct drm_panthor_vm_bind_op){
+		.bo_offset = offset,
+		.size = size,
+		.va = va,
+		.flags = flags,
+	};
+
+	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, &op);
 	if (ret)
 		return ret;
 
-- 
2.53.0

