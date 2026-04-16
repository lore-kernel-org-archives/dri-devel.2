Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F629F8DFCB
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 21:45:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B620A10E934;
	Thu, 16 Apr 2026 21:45:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Ucv7yDvQ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB9610E933
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 21:45:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776375911; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dRreHvg0kPBk7b6FXdhA//CHqa6UtRByHa/R7X8b2V4YqOGwKOexG0nV7wfAXZUTqnuGfcmD8lc42hNUTOyT5s9r+KRkI6oUUOH1dk/2Z98SyernLM5gR0RwpzJF7f3dMP4u6rq2bXO4SSpvJi6/fL7Us8T3cGKKLMd0uovo5+0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776375911;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pdXQf0JUF3Ul3GBd2eg5onO+xAyZIeria+FMMMSVKQA=; 
 b=a9gbLgXjQGL7KmNzeOOvhx/ECddI0iOz9Uno6xDpcEUgW4z+eMnDorCN0FxiOUtZSdAkyFsx/tngcOGVUzpQsm8dFjK9nwi/vbR5R0FN43gz+Hr4bt9sf6kZkR87UopXhvuog2DrI1dEfRdYiB66eDG1fcHPH0ervcQSARUn9jg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776375911; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=pdXQf0JUF3Ul3GBd2eg5onO+xAyZIeria+FMMMSVKQA=;
 b=Ucv7yDvQ8pHIojcZcib0kVmH3uOo6VwZlnnk9wYWB9DY6nyqOYekRajdvaTKo1mr
 PexA/vgX5jgG6r4pPCD3v+UbawkOBCm+dSi++N97evqErFHtoRwLLnNRRVWrF5RLZCE
 89seLjWkMt668vrwjPuRmQsolQ+ERglNKBFJsZ3Q=
Received: by mx.zohomail.com with SMTPS id 17763759105391000.3242032632928;
 Thu, 16 Apr 2026 14:45:10 -0700 (PDT)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v8 2/6] drm/panthor: Pass vm_bind_op to vm_prepare_map_op_ctx
Date: Thu, 16 Apr 2026 22:43:48 +0100
Message-ID: <20260416214453.112332-3-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416214453.112332-1-adrian.larumbe@collabora.com>
References: <20260416214453.112332-1-adrian.larumbe@collabora.com>
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

Reviewed-by: Steven Price <steven.price@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index dad56a01c597..400e9652cd3b 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1275,9 +1275,7 @@ static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
 static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 					 struct panthor_vm *vm,
 					 struct panthor_gem_object *bo,
-					 u64 offset,
-					 u64 size, u64 va,
-					 u32 flags)
+					 const struct drm_panthor_vm_bind_op *op)
 {
 	struct drm_gpuvm_bo *preallocated_vm_bo;
 	struct sg_table *sgt = NULL;
@@ -1286,12 +1284,12 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	if (!bo)
 		return -EINVAL;
 
-	if ((flags & ~PANTHOR_VM_BIND_OP_MAP_FLAGS) ||
-	    (flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
+	if ((op->flags & ~PANTHOR_VM_BIND_OP_MAP_FLAGS) ||
+	    (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
 		return -EINVAL;
 
 	/* Make sure the VA and size are in-bounds. */
-	if (size > bo->base.size || offset > bo->base.size - size)
+	if (op->size > bo->base.size || op->bo_offset > bo->base.size - op->size)
 		return -EINVAL;
 
 	/* If the BO has an exclusive VM attached, it can't be mapped to other VMs. */
@@ -1299,7 +1297,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	    bo->exclusive_vm_root_gem != panthor_vm_root_gem(vm))
 		return -EINVAL;
 
-	panthor_vm_init_op_ctx(op_ctx, size, va, flags);
+	panthor_vm_init_op_ctx(op_ctx, op->size, op->va, op->flags);
 
 	ret = panthor_vm_op_ctx_prealloc_vmas(op_ctx);
 	if (ret)
@@ -1328,7 +1326,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	}
 
 	op_ctx->map.vm_bo = drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
-	op_ctx->map.bo_offset = offset;
+	op_ctx->map.bo_offset = op->bo_offset;
 
 	ret = panthor_vm_op_ctx_prealloc_pts(op_ctx);
 	if (ret)
@@ -2830,10 +2828,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 		gem = drm_gem_object_lookup(file, op->bo_handle);
 		ret = panthor_vm_prepare_map_op_ctx(op_ctx, vm,
 						    gem ? to_panthor_bo(gem) : NULL,
-						    op->bo_offset,
-						    op->size,
-						    op->va,
-						    op->flags);
+						    op);
 		drm_gem_object_put(gem);
 		return ret;
 
@@ -3029,10 +3024,16 @@ int panthor_vm_bind_exec_sync_op(struct drm_file *file,
 int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_object *bo,
 			    u64 offset, u64 size, u64 va, u32 flags)
 {
+	struct drm_panthor_vm_bind_op op = {
+		.bo_offset = offset,
+		.size = size,
+		.va = va,
+		.flags = flags,
+	};
 	struct panthor_vm_op_ctx op_ctx;
 	int ret;
 
-	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, offset, size, va, flags);
+	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, &op);
 	if (ret)
 		return ret;
 
-- 
2.53.0

