Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38BE107637F
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A98710EB96;
	Wed,  1 Apr 2026 13:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="AxpO8cbJ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29FED10EB72
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775051353;
 bh=X48OHC3BclZGwL+PhdyvwaPYaDFTGr1D2J8SIXDpbRI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AxpO8cbJoPro+/Bw1xEbYzNZs3yEl2pqCrJ4Gz1H1dtUpbuV4en8RYSa1g9XchD/V
 FfMzbz+OLUdLDUX0ajNztmXdeLQflLUN+KfDzGdYsEv3xTJxBCc+QXSz7RhH1V5Z36
 Ls4tsZ4uw/2H2lSjCHPibhTtoA0LerIkHEQs8p5nXNSwHTrOWw2KhVFCxZGVo/av3g
 yKvORKUE/3Y/F+d2mFD5dNW98fYt+4Vpl3KqxJcGN6c9PSY2aw2dF7d+hEgstr39+P
 s34pL5MS4JkdXn11WUHaDICnlpOqNdatDiMio4nOiX0KgOIOpmbL3AS+Zb7VP86Zre
 InOtswFXVHzYw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:a2a7:f53:ebb0:945e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 00F4A17E7670;
 Wed,  1 Apr 2026 15:49:12 +0200 (CEST)
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
Subject: [PATCH v7 08/10] drm/panthor: Split panthor_vm_prepare_map_op_ctx()
 to prepare for reclaim
Date: Wed,  1 Apr 2026 15:48:52 +0200
Message-ID: <20260401134854.2275433-9-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401134854.2275433-1-boris.brezillon@collabora.com>
References: <20260401134854.2275433-1-boris.brezillon@collabora.com>
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

We're gonna need just the page table reservation logic when we restore
evicted BO mappings, so let's prepare for that by extracting the
op_ctx init and page table pre-allocation into separate helpers.

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

v7:
- No changes

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 68 ++++++++++++++++-----------
 1 file changed, 41 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 1f42ff505883..b78f694ca92b 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1175,6 +1175,44 @@ panthor_vm_op_ctx_prealloc_vmas(struct panthor_vm_op_ctx *op_ctx)
 	return 0;
 }
 
+static void panthor_vm_init_op_ctx(struct panthor_vm_op_ctx *op_ctx,
+				   u64 size, u64 va, u32 flags)
+{
+	memset(op_ctx, 0, sizeof(*op_ctx));
+	op_ctx->flags = flags;
+	op_ctx->va.range = size;
+	op_ctx->va.addr = va;
+}
+
+static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
+{
+	u64 size = op_ctx->va.range;
+	u64 va = op_ctx->va.addr;
+	int ret;
+
+	/* L1, L2 and L3 page tables.
+	 * We could optimize L3 allocation by iterating over the sgt and merging
+	 * 2M contiguous blocks, but it's simpler to over-provision and return
+	 * the pages if they're not used.
+	 */
+	u64 pt_count = ((ALIGN(va + size, 1ull << 39) - ALIGN_DOWN(va, 1ull << 39)) >> 39) +
+		       ((ALIGN(va + size, 1ull << 30) - ALIGN_DOWN(va, 1ull << 30)) >> 30) +
+		       ((ALIGN(va + size, 1ull << 21) - ALIGN_DOWN(va, 1ull << 21)) >> 21);
+
+	op_ctx->rsvd_page_tables.pages = kzalloc_objs(*op_ctx->rsvd_page_tables.pages,
+						      pt_count);
+	if (!op_ctx->rsvd_page_tables.pages)
+		return -ENOMEM;
+
+	ret = kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, pt_count,
+				    op_ctx->rsvd_page_tables.pages);
+	op_ctx->rsvd_page_tables.count = ret;
+	if (ret != pt_count)
+		return -ENOMEM;
+
+	return 0;
+}
+
 #define PANTHOR_VM_BIND_OP_MAP_FLAGS \
 	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
 	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
@@ -1190,7 +1228,6 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 {
 	struct drm_gpuvm_bo *preallocated_vm_bo;
 	struct sg_table *sgt = NULL;
-	u64 pt_count;
 	int ret;
 
 	if (!bo)
@@ -1209,10 +1246,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	    bo->exclusive_vm_root_gem != panthor_vm_root_gem(vm))
 		return -EINVAL;
 
-	memset(op_ctx, 0, sizeof(*op_ctx));
-	op_ctx->flags = flags;
-	op_ctx->va.range = size;
-	op_ctx->va.addr = va;
+	panthor_vm_init_op_ctx(op_ctx, size, va, flags);
 
 	ret = panthor_vm_op_ctx_prealloc_vmas(op_ctx);
 	if (ret)
@@ -1244,29 +1278,9 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	op_ctx->map.vm_bo = drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
 	op_ctx->map.bo_offset = offset;
 
-	/* L1, L2 and L3 page tables.
-	 * We could optimize L3 allocation by iterating over the sgt and merging
-	 * 2M contiguous blocks, but it's simpler to over-provision and return
-	 * the pages if they're not used.
-	 */
-	pt_count = ((ALIGN(va + size, 1ull << 39) - ALIGN_DOWN(va, 1ull << 39)) >> 39) +
-		   ((ALIGN(va + size, 1ull << 30) - ALIGN_DOWN(va, 1ull << 30)) >> 30) +
-		   ((ALIGN(va + size, 1ull << 21) - ALIGN_DOWN(va, 1ull << 21)) >> 21);
-
-	op_ctx->rsvd_page_tables.pages = kzalloc_objs(*op_ctx->rsvd_page_tables.pages,
-						      pt_count);
-	if (!op_ctx->rsvd_page_tables.pages) {
-		ret = -ENOMEM;
+	ret = panthor_vm_op_ctx_prealloc_pts(op_ctx);
+	if (ret)
 		goto err_cleanup;
-	}
-
-	ret = kmem_cache_alloc_bulk(pt_cache, GFP_KERNEL, pt_count,
-				    op_ctx->rsvd_page_tables.pages);
-	op_ctx->rsvd_page_tables.count = ret;
-	if (ret != pt_count) {
-		ret = -ENOMEM;
-		goto err_cleanup;
-	}
 
 	/* Insert BO into the extobj list last, when we know nothing can fail. */
 	if (bo->base.resv != panthor_vm_resv(vm)) {
-- 
2.53.0

