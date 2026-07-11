Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3311DC44513
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2618110E2B9;
	Sat, 11 Jul 2026 02:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="koWfNTOZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8664110E2DA;
 Sat, 11 Jul 2026 02:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738591; x=1815274591;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NnGBJqLmLrh3K576tGR1UiVssx1rM70mzMQyFFY8CGo=;
 b=koWfNTOZ1Fx7RqUhlN8xpTm4LSywIE41p8PZGSmvMsOznYChBuN03J3q
 mvLRQwN1fnzhxaChKJLMesFuo6iAVJjS31QMPjIVtxgEdnXl6L0ebSFxW
 ecVrErMw/2p+Nd2s324bWuEWL/uVlpZ8W83BYC5wMSs1GbbSyyFGGfsAm
 Iu5CdWinlwtPZQlhM4ITAmPDEdROatiD/iT7eWuz8f3a/KxtcqFawNUpe
 0KEf308RjK86Tt8B+qnVdiCyY9yLbvFq1pVHQnIAil9DQTWUOUzMfmQFl
 /s7bClveqCdu/V+ho7Bvfxa5q4/WUZR5nSSWs3RejBihyga7EIcPw9F4o w==;
X-CSE-ConnectionGUID: 2tq5oceXToG1odFVl5uSow==
X-CSE-MsgGUID: mEE0RvNmTdWGcDr3+QRz2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986299"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986299"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:30 -0700
X-CSE-ConnectionGUID: 1MIKDwX1Sy6Tq/92JiflqQ==
X-CSE-MsgGUID: alDg4Ep0T+O+HqZ/H9fy2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987758"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:29 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v3 19/33] drm/xe: Skip self-copies for borrowed pages on
 defrag moves
Date: Fri, 10 Jul 2026 19:56:05 -0700
Message-Id: <20260711025619.2540575-20-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
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

A defrag move may harvest already beneficial-order chunks from the old
tt, so the freshly reallocated backing borrows (references) some of the
same physical pages. For those pages the source and destination GPU
mappings alias the same memory, making the data blit a pointless
self-copy.

Pass the source (old) tt into __xe_migrate_copy() instead of just its sg
table, so the data pass can compare the src and dst tt page arrays at the
matching offset and only blit runs of pages that actually differ. A new
emit_copy_chunks() helper walks each L0 chunk, skips borrowed-page runs,
and coalesces contiguous to-copy pages into a single emit_copy(). It runs
twice per chunk: once with a NULL batch buffer to count the blits for
batch sizing, then again to emit them.

When an entire L0 chunk turns out to be borrowed, skip it outright: no
batch buffer is allocated and no GPU commands are issued, the cursors are
just advanced past the chunk. If every chunk of the move is borrowed the
copy is a complete no-op, so hand back a signaled stub fence.

The comparison is a cheap per-page pointer test (src page != dst page)
that coalesces contiguous to-copy pages into a single blit. PTEs are
still emitted for partially borrowed chunks, since that setup is cheap and
only the data copies are worth skipping. Only the defrag data pass is
affected; the separate CCS pass still migrates all aux state.

Since the Xe tt sg lives in the xe_ttm_tt subclass rather than the base
ttm_tt, add an xe_tt_sg() helper to fetch it from a struct ttm_tt.

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

----

v3:
 - Fix start_page page-shift and blit pitch for src-natural to
   dst-packed copies (Sashiko)
---
 drivers/gpu/drm/xe/xe_bo.c      |  22 +++++-
 drivers/gpu/drm/xe/xe_bo.h      |   2 +
 drivers/gpu/drm/xe/xe_migrate.c | 136 ++++++++++++++++++++++++++++----
 drivers/gpu/drm/xe/xe_migrate.h |   3 +-
 4 files changed, 142 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index bdcc9bed5d36..7f6ee9b8d12e 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -473,6 +473,22 @@ struct sg_table *xe_bo_sg(struct xe_bo *bo)
 	return xe_tt->sg;
 }
 
+/**
+ * xe_tt_sg() - Return the DMA scatter-gather table backing a ttm_tt.
+ * @tt: The ttm_tt to query.
+ *
+ * Like xe_bo_sg(), but takes the ttm_tt directly. Used by the defrag copy
+ * path which needs the old (source) tt's sg table without a backing xe_bo.
+ *
+ * Return: The sg table, or NULL if the tt is not currently mapped.
+ */
+struct sg_table *xe_tt_sg(struct ttm_tt *tt)
+{
+	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
+
+	return xe_tt->sg;
+}
+
 /*
  * Account ttm pages against the device shrinker's shrinkable and
  * purgeable counts.
@@ -1290,11 +1306,9 @@ static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
 
 		fence = xe_migrate_clear(migrate, bo, new_mem, flags);
 	} else if (ttm_bo->defrag_old_tt) {
-		struct xe_ttm_tt *old_xe_tt =
-			container_of(ttm_bo->defrag_old_tt, struct xe_ttm_tt, ttm);
-
 		fence = xe_migrate_copy_defrag(migrate, bo, old_mem, new_mem,
-					       old_xe_tt->sg, handle_system_ccs);
+					       ttm_bo->defrag_old_tt,
+					       handle_system_ccs);
 	} else {
 		fence = xe_migrate_copy(migrate, bo, bo, old_mem, new_mem,
 					handle_system_ccs);
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 4186cb51af87..32211016a722 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -110,6 +110,7 @@ enum xe_madv_purgeable_state {
 };
 
 struct sg_table;
+struct ttm_tt;
 
 struct xe_bo *xe_bo_alloc(void);
 void xe_bo_free(struct xe_bo *bo);
@@ -547,6 +548,7 @@ void xe_bo_dev_init(struct xe_bo_dev *bo_device);
 void xe_bo_dev_fini(struct xe_bo_dev *bo_device);
 
 struct sg_table *xe_bo_sg(struct xe_bo *bo);
+struct sg_table *xe_tt_sg(struct ttm_tt *tt);
 
 /*
  * xe_sg_segment_size() - Provides upper limit for sg segment size.
diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
index 305c6e1942fb..9990a7144a9f 100644
--- a/drivers/gpu/drm/xe/xe_migrate.c
+++ b/drivers/gpu/drm/xe/xe_migrate.c
@@ -811,6 +811,63 @@ static void emit_copy(struct xe_gt *gt, struct xe_bb *bb,
 		emit_xy_fast_copy(gt, bb, src_ofs, dst_ofs, size, pitch);
 }
 
+/*
+ * emit_copy_chunks() - Emit the data blits for one defrag L0 chunk, skipping
+ * borrowed pages.
+ * @gt: The GT.
+ * @bb: The batch buffer to emit into, or NULL to only count the blits needed.
+ * @src_L0_ofs: GPU offset of the source pages mapped for this L0 chunk.
+ * @dst_L0_ofs: GPU offset of the destination pages mapped for this L0 chunk.
+ * @src_L0: Byte size of the L0 chunk (page aligned).
+ * @src_tt: Source (old) tt providing the page pointers.
+ * @dst_tt: Destination (new) tt providing the page pointers.
+ * @start_page: Page offset of this L0 chunk within the tt page arrays.
+ *
+ * A defragmentation move may harvest already beneficial-order chunks from the
+ * old tt, so the new tt references (borrows) some of the same physical pages.
+ * For those pages the source and destination GPU mappings alias the same
+ * memory and the data blit is a pointless self-copy. Walk the L0 chunk and
+ * only blit runs of pages that actually differ (src page != dst page),
+ * coalescing contiguous to-copy pages into a single blit.
+ *
+ * Return: The number of blits emitted (or that would be emitted when @bb is
+ * NULL).
+ */
+static u32 emit_copy_chunks(struct xe_gt *gt, struct xe_bb *bb,
+			    u64 src_L0_ofs, u64 dst_L0_ofs, u32 src_L0,
+			    struct ttm_tt *src_tt, struct ttm_tt *dst_tt,
+			    pgoff_t start_page)
+{
+	u32 npages = src_L0 >> PAGE_SHIFT;
+	u32 i = 0, nblits = 0;
+
+	while (i < npages) {
+		u32 run = 0;
+
+		/* Skip a run of borrowed pages (src and dst alias). */
+		if (src_tt->pages[start_page + i] ==
+		    dst_tt->pages[start_page + i]) {
+			i++;
+			continue;
+		}
+
+		/* Coalesce a run of pages that actually need copying. */
+		while (i + run < npages &&
+		       src_tt->pages[start_page + i + run] !=
+		       dst_tt->pages[start_page + i + run])
+			run++;
+
+		if (bb)
+			emit_copy(gt, bb, src_L0_ofs + (u64)i * PAGE_SIZE,
+				  dst_L0_ofs + (u64)i * PAGE_SIZE,
+				  run * PAGE_SIZE, XE_PAGE_SIZE);
+		nblits++;
+		i += run;
+	}
+
+	return nblits;
+}
+
 static u64 xe_migrate_batch_base(struct xe_migrate *m, bool usm)
 {
 	return usm ? m->usm_batch_base_ofs : m->batch_base_ofs;
@@ -865,13 +922,15 @@ static u32 xe_migrate_ccs_copy(struct xe_migrate *m,
  * @is_vram_resolve: Decompression (VRAM -> system) resolve; always uses the
  * compression PAT index for the data copy.
  * @defrag_ccs: Defrag move pass that migrates only the CCS aux state between
- * two distinct page sets (old @src_sg pages -> new pages). The data blit is
+ * two distinct page sets (old @src_tt pages -> new pages). The data blit is
  * skipped (the data was copied by the @defrag_copy pass) and both the source
  * and destination data pages are mapped with the compression PAT so the aux
  * state is copied indirect -> indirect.
  * @defrag_copy: Defrag move pass that copies the data pages between two
- * distinct page sets (old @src_sg pages -> new pages) without touching the CCS
- * aux state. The data pages are mapped without the compression PAT so the
+ * distinct page sets (old @src_tt pages -> new pages) without touching the CCS
+ * aux state. Pages the new tt borrowed from @src_tt (harvested already
+ * beneficial-order chunks) alias the same memory on both sides and are skipped.
+ * The data pages are mapped without the compression PAT so the
  * (possibly compressed) bytes are copied verbatim rather than being
  * decompressed and recompressed, and no CCS aux copy is appended; the aux
  * state is migrated separately by the @defrag_ccs pass. The two passes need
@@ -889,7 +948,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
 					   struct xe_bo *dst_bo,
 					   struct ttm_resource *src,
 					   struct ttm_resource *dst,
-					   struct sg_table *src_sg,
+					   struct ttm_tt *src_tt,
 					   struct xe_migrate_copy_flags flags)
 {
 	struct xe_gt *gt = m->tile->primary_gt;
@@ -914,6 +973,14 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
 		!flags.defrag_copy;
 	bool copy_system_ccs = copy_ccs && (!src_is_vram || !dst_is_vram) &&
 		!flags.defrag_ccs && !flags.defrag_copy;
+	/*
+	 * On the defrag data pass the new (destination) tt may have borrowed
+	 * already beneficial-order pages from the old (source) tt, so skip the
+	 * self-copy for any page they share. Compare the tt page arrays at the
+	 * matching offset.
+	 */
+	struct ttm_tt *dst_tt = dst_bo->ttm.ttm;
+	bool skip_borrowed = flags.defrag_copy && src_tt && dst_tt;
 
 	/*
 	 * For decompression operation, always use the compression PAT index.
@@ -926,7 +993,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
 
 	/*
 	 * The defrag CCS pass migrates the aux state from the old pages
-	 * (@src_sg) to the new pages with both sides accessed indirectly, so
+	 * (@src_tt) to the new pages with both sides accessed indirectly, so
 	 * keep both src_is_pltt and dst_is_pltt set (no direct staging side).
 	 */
 
@@ -938,7 +1005,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
 		return ERR_PTR(-EINVAL);
 
 	if (!src_is_vram)
-		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo), 0, size, &src_it);
+		xe_res_first_sg(src_tt ? xe_tt_sg(src_tt) : xe_bo_sg(src_bo), 0, size, &src_it);
 	else
 		xe_res_first(src, 0, size, &src_it);
 	if (!dst_is_vram)
@@ -947,7 +1014,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
 		xe_res_first(dst, 0, size, &dst_it);
 
 	if (copy_system_ccs)
-		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo),
+		xe_res_first_sg(src_tt ? xe_tt_sg(src_tt) : xe_bo_sg(src_bo),
 				xe_bo_ccs_pages_start(src_bo),
 				PAGE_ALIGN(xe_device_ccs_bytes(xe, size)),
 				&ccs_it);
@@ -961,6 +1028,8 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
 		u64 ccs_ofs, ccs_size;
 		u32 ccs_pt;
 		u32 pte_flags;
+		pgoff_t start_page = (xe_bo_size(src_bo) - size) >> PAGE_SHIFT;
+		u32 ndata_blits = 1;
 
 		bool usm = xe->info.has_usm;
 		u32 avail_pts = max_mem_transfer_per_pass(xe) / LEVEL0_PAGE_TABLE_ENCODE_SIZE;
@@ -998,9 +1067,30 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
 			xe_assert(xe, IS_ALIGNED(ccs_it.start, PAGE_SIZE));
 		}
 
-		/* Add copy commands size here */
+		/*
+		 * Add copy commands size here. On the defrag data pass the blit
+		 * is split into one command per run of non-borrowed pages, so
+		 * size for the number of runs actually needed.
+		 */
+		if (skip_borrowed)
+			ndata_blits = emit_copy_chunks(gt, NULL, 0, 0, src_L0,
+						       src_tt, dst_tt, start_page);
+
+		/*
+		 * If every page in this chunk was borrowed there is nothing to
+		 * copy: don't build a batch or issue any GPU commands, just
+		 * advance the cursors past the chunk. The non-vram tt cursors
+		 * would otherwise be advanced by emit_pte().
+		 */
+		if (skip_borrowed && !ndata_blits) {
+			xe_res_next(&src_it, src_L0);
+			xe_res_next(&dst_it, src_L0);
+			size -= src_L0;
+			continue;
+		}
+
 		batch_size += ((flags.copy_only_ccs || flags.defrag_ccs) ? 0 :
-			       emit_copy_cmd_len(xe)) +
+			       ndata_blits * emit_copy_cmd_len(xe)) +
 			((needs_ccs_emit ? EMIT_COPY_CCS_DW : 0));
 
 		bb = xe_bb_new(gt, batch_size, usm);
@@ -1029,7 +1119,10 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
 		bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
 		update_idx = bb->len;
 
-		if (!flags.copy_only_ccs && !flags.defrag_ccs)
+		if (skip_borrowed)
+			emit_copy_chunks(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0,
+					 src_tt, dst_tt, start_page);
+		else if (!flags.copy_only_ccs && !flags.defrag_ccs)
 			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
 
 		if (needs_ccs_emit)
@@ -1088,6 +1181,14 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
 		return ERR_PTR(err);
 	}
 
+	/*
+	 * Every chunk of a defrag data pass may have been borrowed (nothing
+	 * copied), leaving no job and a NULL fence. Hand back a signaled stub
+	 * so callers always get a valid fence to wait on.
+	 */
+	if (!fence)
+		return dma_fence_get_stub();
+
 	return fence;
 }
 
@@ -1129,18 +1230,21 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
  * @bo: The buffer object being defragmented. Both @src and @dst belong to @bo.
  * @src: The source TTM resource (the old backing).
  * @dst: The dst TTM resource (the freshly reallocated backing).
- * @src_sg: Scatter-gather table of the source (old) backing pages.
+ * @src_tt: The source (old) backing tt, providing both the scatter-gather
+ * table and page pointers of the old pages.
  * @need_ccs: Whether the BO has CCS aux state that must be migrated too.
  *
  * Used by the defrag path where a single BO has its backing reallocated at a
  * more beneficial page order. The contents are relocated from the old pages
- * (@src_sg) to the new pages (the BO's current backing) entirely on the GPU,
+ * (@src_tt) to the new pages (the BO's current backing) entirely on the GPU,
  * in up to two passes:
  *
  *  - Data pass (always): copy the data pages verbatim. The pages are mapped
  *    without the compression PAT, so the (possibly compressed) bytes are copied
  *    as-is rather than being decompressed and recompressed, and no CCS aux copy
- *    is appended.
+ *    is appended. Pages the new backing borrowed from @src_tt (harvested
+ *    already beneficial-order chunks) alias the same memory on both sides and
+ *    are skipped.
  *
  *  - CCS pass (@need_ccs): copy the CCS aux (compression) state. Both the old
  *    and new data pages are mapped with the compression PAT so the copy engine
@@ -1159,11 +1263,11 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
 					 struct xe_bo *bo,
 					 struct ttm_resource *src,
 					 struct ttm_resource *dst,
-					 struct sg_table *src_sg,
+					 struct ttm_tt *src_tt,
 					 bool need_ccs)
 {
 	struct dma_fence *fence2, *fence =
-		__xe_migrate_copy(m, bo, bo, src, dst, src_sg,
+		__xe_migrate_copy(m, bo, bo, src, dst, src_tt,
 				  (struct xe_migrate_copy_flags) {
 					 .defrag_copy = true,
 					 });
@@ -1171,7 +1275,7 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
 	if (IS_ERR(fence) || !need_ccs)
 		return fence;
 
-	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_sg,
+	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_tt,
 				   (struct xe_migrate_copy_flags) {
 				   .defrag_ccs = true,
 				   });
diff --git a/drivers/gpu/drm/xe/xe_migrate.h b/drivers/gpu/drm/xe/xe_migrate.h
index e4f996942a6d..4094ea1c19c1 100644
--- a/drivers/gpu/drm/xe/xe_migrate.h
+++ b/drivers/gpu/drm/xe/xe_migrate.h
@@ -13,6 +13,7 @@ struct drm_pagemap_addr;
 struct iosys_map;
 struct sg_table;
 struct ttm_resource;
+struct ttm_tt;
 
 struct xe_bo;
 struct xe_gt;
@@ -137,7 +138,7 @@ struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
 					 struct xe_bo *bo,
 					 struct ttm_resource *src,
 					 struct ttm_resource *dst,
-					 struct sg_table *src_sg,
+					 struct ttm_tt *src_tt,
 					 bool need_ccs);
 
 struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
-- 
2.34.1

