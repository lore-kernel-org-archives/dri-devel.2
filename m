Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EE6105F7B1
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 15:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5337810E178;
	Fri, 13 Mar 2026 15:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Mv7vOoaE";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B585410E178
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 15:11:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773414680; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UV3yL518arnR0/TjctHYyB0rzN/vQblVHEmQ1s1j0n09hdcsqPhORPAr43cFUZ4DSusB6EiWv14VRqh4ErSwmU6ZHqUTogoUEWCtjgkTmOYbjhTNttojjgqECb73QNwZtMJh20LsfE2RhUI2egmr4d3A9ZwtMyUMsQZ8SCTGuX4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773414680;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SdVZB9xAx6kDE71K2UbMTmPRTxksVaVSVA3Iu9cKNPk=; 
 b=QaH/pWzQskk9ajUlqyjqrz36awrtv3pmNqIYIo/owLPHN7+pnbTAAgIlbh2FooLV5Nr8KnCSFKm3CwfD7fIrn2l9ixKzF8ysghPtDeNnTAPpgHxmiyyYIevieV6BYXRr+UxERbW6Cbh7VuYo1rutZynhAnrgVHWvARTSRwJKvyQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773414680; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=SdVZB9xAx6kDE71K2UbMTmPRTxksVaVSVA3Iu9cKNPk=;
 b=Mv7vOoaEkTKPFo6XUHzvZnHNHqjfnpUX8ErMTabRCH/TTGSCDE8IfYTKnx76+24P
 u/QzDS7GtpEOrSk3JQSDn2JWVXTi/V2ON/4CQ5szdxPTUuWkv4E8w2QNAgSJBmpf/Jk
 El5gup6wYr2yPgOLxvmFHbh4xhzwv1bcpiz5cHAs=
Received: by mx.zohomail.com with SMTPS id 1773414678777968.1023471391474;
 Fri, 13 Mar 2026 08:11:18 -0700 (PDT)
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
Subject: [PATCH v5 09/11] drm/panthor: Handle remap case for repeated mappings
Date: Fri, 13 Mar 2026 15:09:46 +0000
Message-ID: <20260313150956.1618635-10-adrian.larumbe@collabora.com>
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

When a GPUVA remap is triggered as a consequence of a VM operation
insersecting with existing VAs, when mapping the split VAs one must take
into account whether they were repeat-mapped.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 63 +++++++++++++++++----------
 1 file changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index a357063bb9f6..ba322e2029b9 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2124,41 +2124,52 @@ static void panthor_vma_init(struct panthor_vma *vma, u32 flags)
 	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
 	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED)
 
-static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
+static int
+panthor_vm_map_range(struct panthor_vm *vm, bool repeat, struct sg_table *sgt,
+		     u64 addr, u64 offset, u64 size, u32 repeat_range, int prot)
 {
-	struct panthor_vm *vm = priv;
-	struct panthor_vm_op_ctx *op_ctx = vm->op_ctx;
-	struct panthor_vma *vma = panthor_vm_op_ctx_get_vma(op_ctx);
 	int ret;
 
-	if (!vma)
-		return -EINVAL;
-
-	panthor_vma_init(vma, op_ctx->flags & PANTHOR_VM_MAP_FLAGS);
+	if (!size)
+		return 0;
 
-	if (op_ctx->flags & DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT) {
-		u64 repeat_count = op->map.va.range;
+	if (repeat) {
+		u64 repeat_count = size;
 
-		do_div(repeat_count, op->map.gem.repeat_range);
+		do_div(repeat_count, repeat_range);
 
 		if (drm_WARN_ON(&vm->ptdev->base, !repeat_count))
 			return -EINVAL;
 
-		ret = panthor_vm_repeated_map_pages(vm, op->map.va.addr,
-						    flags_to_prot(vma->flags),
-						    op_ctx->map.sgt,
-						    op->map.gem.offset,
-						    op->map.gem.repeat_range,
+		ret = panthor_vm_repeated_map_pages(vm, addr, prot, sgt,
+						    offset, repeat_range,
 						    repeat_count);
 		if (!ret)
 			vm->base.flags |= DRM_GPUVM_HAS_REPEAT_MAPS;
 	} else {
-		ret = panthor_vm_map_pages(vm, op->map.va.addr,
-					   flags_to_prot(vma->flags),
-					   op_ctx->map.sgt, op->map.gem.offset,
-					   op->map.va.range);
+		ret = panthor_vm_map_pages(vm, addr, prot, sgt,
+					   offset, size);
 	}
 
+	return ret;
+}
+
+static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
+{
+	struct panthor_vm *vm = priv;
+	struct panthor_vm_op_ctx *op_ctx = vm->op_ctx;
+	struct panthor_vma *vma = panthor_vm_op_ctx_get_vma(op_ctx);
+	int ret;
+
+	if (!vma)
+		return -EINVAL;
+
+	panthor_vma_init(vma, op_ctx->flags & PANTHOR_VM_MAP_FLAGS);
+
+	ret = panthor_vm_map_range(vm, op_ctx->flags & DRM_PANTHOR_VM_BIND_OP_MAP_REPEAT,
+				   op_ctx->map.sgt, op->map.va.addr, op->map.gem.offset,
+				   op->map.va.range, op->map.gem.repeat_range,
+				   flags_to_prot(vma->flags));
 	if (ret) {
 		panthor_vm_op_ctx_return_vma(op_ctx, vma);
 		return ret;
@@ -2262,8 +2273,10 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 		u64 offset = op->remap.prev->gem.offset + unmap_start - op->remap.prev->va.addr;
 		u64 size = op->remap.prev->va.addr + op->remap.prev->va.range - unmap_start;
 
-		ret = panthor_vm_map_pages(vm, unmap_start, flags_to_prot(unmap_vma->flags),
-					   bo->base.sgt, offset, size);
+		ret = panthor_vm_map_range(vm, op->remap.prev->flags & DRM_GPUVA_REPEAT,
+					   bo->base.sgt, op->remap.prev->va.addr, offset,
+					   size, op->remap.prev->gem.repeat_range,
+					   flags_to_prot(unmap_vma->flags));
 		if (ret)
 			return ret;
 
@@ -2276,8 +2289,10 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
 		u64 addr = op->remap.next->va.addr;
 		u64 size = unmap_start + unmap_range - op->remap.next->va.addr;
 
-		ret = panthor_vm_map_pages(vm, addr, flags_to_prot(unmap_vma->flags),
-					   bo->base.sgt, op->remap.next->gem.offset, size);
+		ret = panthor_vm_map_range(vm, op->remap.next->flags & DRM_GPUVA_REPEAT,
+					   bo->base.sgt, addr, op->remap.next->gem.offset,
+					   size, op->remap.next->gem.repeat_range,
+					   flags_to_prot(unmap_vma->flags));
 		if (ret)
 			return ret;
 
-- 
2.53.0

