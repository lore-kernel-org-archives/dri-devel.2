Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD055606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dancol.org header.i=@dancol.org header.a=rsa-sha256 header.s=x header.b=hegwxAFm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22832112054;
	Thu, 29 Oct 2026 07:59:13 +0000 (UTC)
X-Greylist: delayed 1170 seconds by postgrey-1.36 at gabe;
 Wed, 28 Oct 2026 05:10:04 UTC
Received: from dancol.org (dancol.org [96.126.100.184])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1989610E17E;
 Wed, 28 Oct 2026 05:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dancol.org; 
 s=x;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:To:From; 
 bh=iPcml1MP8Ls9urv5n5lLtmn/ChRnyi9qwTe5mQUbNZQ=; b=hegwxAFmmjmEZp2QBxnU+tBobg
 nz9nUeocnDjycdvamubq5Sgc0C+2zxbYifrG7dl5LhtyI6QbKKxxJtymX0IsodYklXVrblsfAqjBS
 nHJgEihOGG6h8b+BteXnEBNWyiOV8Z+jKZgXl0kuwtISrFPkDMVIJUxUlNSYEkItIuPuYCEabPJ+y
 Uk1NicagfIBxCCsnd9FI8EAe7HWfbZFFhCkzmH3kXcp4dFgJtdR8bm1FVtJs/ARaQY4S3NWM1POgW
 NLElKGRMi5LuIEUOVwRYwqB+gfBCUmK082EjsxiV0hXhrI0s2YRF8Twhs9m4gsAJvbezzuPx0WUPX
 nTrWziqg==;
Received: from [12.111.91.62] (port=37220 helo=localhost)
 by dancol.org with esmtpsa (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
 (Exim 4.98.2) (envelope-from <dancol@dancol.org>)
 id 1xLvcP-000000004VX-2Qd9; Wed, 28 Oct 2026 00:50:33 -0400
From: Daniel Colascione <dancol@dancol.org>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>, Thomas Hellstrom
 <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 dri-devel@lists.freedesktop.org
Subject: [RFC PATCH] drm/xe/ggtt: Cut GGTT initialization from 900 ms to 37 ms
User-Agent: mu4e 1.14.1; emacs 32.0.50
Date: Tue, 27 Oct 2026 21:50:31 -0700
Message-ID: <87v76m1l9k.fsf@dancol.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We initialize the GGTT GPU page tables on startup. On my LNL, doing
this one PTE at a time through the BAR takes about 900 ms and involves
a million small writes.

Use the GPU's copy engine to fill the PTEs in batches. We build
MI_UPDATE_GTT commands in normal memory, then send them to the GPU for
execution. This way, we avoid the per-PTE MMIO write and do the PTE fill
in 36.77 ms, ~24x faster.

The new path is enabled by default. xe.ggtt_init_gpu=0 uses the old
CPU-driven path.

LNL-only because I can test only LNL. Might it work elsewhere?

Signed-off-by: Daniel Colascione <dancol@dancol.org>
---
 drivers/gpu/drm/xe/instructions/xe_mi_commands.h |   2 +
 drivers/gpu/drm/xe/xe_ggtt.c                     | 128 +++++++++++++++++++++--
 drivers/gpu/drm/xe/xe_ggtt.h                     |   1 +
 drivers/gpu/drm/xe/xe_gt.c                       |   3 +-
 drivers/gpu/drm/xe/xe_module.c                   |   5 +
 drivers/gpu/drm/xe/xe_module.h                   |   1 +
 6 files changed, 130 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/xe/instructions/xe_mi_commands.h b/drivers/gpu/drm/xe/instructions/xe_mi_commands.h
index 835ef75bbeb1..04bd4225adef 100644
--- a/drivers/gpu/drm/xe/instructions/xe_mi_commands.h
+++ b/drivers/gpu/drm/xe/instructions/xe_mi_commands.h
@@ -62,6 +62,8 @@
 #define   MI_LRI_FORCE_POSTED		REG_BIT(12)
 #define   MI_LRI_LEN(x)			(((x) & 0xff) + 1)
 
+#define MI_UPDATE_GTT			__MI_INSTR(0x23)
+
 #define MI_STORE_REGISTER_MEM		(__MI_INSTR(0x24) | XE_INSTR_NUM_DW(4))
 #define   MI_SRM_USE_GGTT		REG_BIT(22)
 #define   MI_SRM_ADD_CS_OFFSET		REG_BIT(19)
diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 773777afc68a..3737d085ae68 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -15,20 +15,25 @@
 #include <drm/intel/i915_drm.h>
 #include <generated/xe_wa_oob.h>
 
+#include "instructions/xe_mi_commands.h"
 #include "regs/xe_gt_regs.h"
 #include "regs/xe_gtt_defs.h"
 #include "regs/xe_regs.h"
 #include "xe_assert.h"
+#include "xe_bb.h"
 #include "xe_bo.h"
+#include "xe_exec_queue.h"
 #include "xe_gt.h"
 #include "xe_gt_printk.h"
 #include "xe_gt_types.h"
 #include "xe_log.h"
 #include "xe_map.h"
 #include "xe_mmio.h"
+#include "xe_module.h"
 #include "xe_pat.h"
 #include "xe_pm.h"
 #include "xe_res_cursor.h"
+#include "xe_sched_job.h"
 #include "xe_sriov.h"
 #include "xe_tile_printk.h"
 #include "xe_tile_sriov_vf.h"
@@ -384,9 +389,9 @@ static void dev_fini_ggtt(void *arg)
  * @ggtt: the &xe_ggtt to be initialized
  *
  * It allows to create new mappings usable by the GuC.
- * Mappings are not usable by the HW engines, as it doesn't have scratch nor
- * initial clear done to it yet. That will happen in the regular, non-early
- * GGTT initialization.
+ * HW engines may only access explicitly mapped bootstrap buffers until the
+ * remaining holes have been cleared. Normally xe_ggtt_init() does this;
+ * the GPU clear finishes this work in xe_ggtt_init_late().
  *
  * Return: 0 on success or a negative error code on failure.
  */
@@ -456,18 +461,119 @@ ALLOW_ERROR_INJECTION(xe_ggtt_init_early, ERRNO); /* See xe_pci_probe() */
 static void xe_ggtt_invalidate(struct xe_ggtt *ggtt);
 static void xe_ggtt_invalidate_engine(struct xe_ggtt *ggtt);
 
-static void xe_ggtt_initial_clear(struct xe_ggtt *ggtt)
+static bool ggtt_use_gpu(struct xe_device *xe)
 {
+	return xe_modparam.ggtt_init_gpu && xe->info.platform == XE_LUNARLAKE;
+}
+
+/*
+ * MI_UPDATE_GTT takes at most 511 inline PTEs (ACM PRM, Vol. 2a,
+ * pp. 1096-1097). Limit batches to 512K to fit the kernel batch pool.
+ */
+#define GGTT_INIT_PTES_PER_PACKET	511
+#define GGTT_INIT_BATCH_DWORDS	(128 * (2 + 2 * GGTT_INIT_PTES_PER_PACKET))
+
+static int ggtt_clear_gpu(struct xe_exec_queue *q, struct xe_bb *bb,
+			  u64 pte, u64 start, u64 end)
+{
+	while (start < end) {
+		struct xe_sched_job *job;
+		int err;
+
+		bb->len = 0;
+		while (start < end && bb->len < GGTT_INIT_BATCH_DWORDS) {
+			u32 count = min_t(u64, (end - start) >> XE_PTE_SHIFT,
+					  GGTT_INIT_PTES_PER_PACKET);
+
+			bb->cs[bb->len++] = MI_UPDATE_GTT | (2 * count);
+			bb->cs[bb->len++] = start;
+			memset64((u64 *)&bb->cs[bb->len], pte, count);
+			bb->len += 2 * count;
+			start += (u64)count << XE_PTE_SHIFT;
+		}
+
+		job = xe_bb_create_job(q, bb);
+		if (IS_ERR(job))
+			return PTR_ERR(job);
+
+		xe_sched_job_arm(job);
+		xe_sched_job_get(job);
+		xe_sched_job_push(job);
+
+		dma_fence_wait(&job->drm.s_fence->finished, false);
+		err = dma_fence_get_status(&job->drm.s_fence->finished);
+		xe_sched_job_put(job);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+static int xe_ggtt_initial_clear(struct xe_ggtt *ggtt, struct xe_hw_engine *hwe)
+{
+	struct xe_device *xe = tile_to_xe(ggtt->tile);
+	struct xe_exec_queue *q = NULL;
+	struct xe_bb *bb = NULL;
 	struct drm_mm_node *hole;
-	u64 start, end;
+	u16 pat_index = xe_cache_pat_idx(xe, XE_CACHE_WB);
+	u64 start, end, pte = 0;
+	int err = 0;
+
+	if (hwe) {
+		q = xe_exec_queue_create(xe, NULL, BIT(hwe->logical_instance), 1,
+					 hwe, EXEC_QUEUE_FLAG_KERNEL, 0);
+		if (IS_ERR(q))
+			return PTR_ERR(q);
+
+		bb = xe_bb_new(hwe->gt, GGTT_INIT_BATCH_DWORDS, false);
+		if (IS_ERR(bb)) {
+			err = PTR_ERR(bb);
+			goto put_queue;
+		}
+	}
 
-	/* Display may have allocated inside ggtt, so be careful with clearing here */
+	if (ggtt->scratch)
+		pte = xe_bo_addr(ggtt->scratch, 0, XE_PAGE_SIZE) |
+		      ggtt->pt_ops->pte_encode_flags(ggtt->scratch, pat_index);
+
+	/* Preserve boot mappings and exclude allocator changes until completion. */
 	mutex_lock(&ggtt->lock);
-	drm_mm_for_each_hole(hole, &ggtt->mm, start, end)
-		xe_ggtt_clear(ggtt, ggtt->start + start, end - start);
+	drm_mm_for_each_hole(hole, &ggtt->mm, start, end) {
+		if (q)
+			err = ggtt_clear_gpu(q, bb, pte, ggtt->start + start, ggtt->start + end);
+		else
+			xe_ggtt_clear(ggtt, ggtt->start + start, end - start);
+		if (err)
+			goto unlock;
+	}
 
 	xe_ggtt_invalidate(ggtt);
+unlock:
 	mutex_unlock(&ggtt->lock);
+	xe_bb_free(bb, NULL);
+put_queue:
+	if (q)
+		xe_exec_queue_put(q);
+	return err;
+}
+
+/**
+ * xe_ggtt_init_late - Finish deferred GGTT initialization after GuC startup
+ * @ggtt: GGTT to initialize
+ *
+ * All default contexts must be recorded before waiting for a GPU clear with
+ * the GGTT mutex held, so reset recovery need not allocate context mappings.
+ *
+ * Return: 0 on success or a negative error code on failure.
+ */
+int xe_ggtt_init_late(struct xe_ggtt *ggtt)
+{
+	if (!ggtt_use_gpu(tile_to_xe(ggtt->tile)))
+		return 0;
+
+	return xe_ggtt_initial_clear(ggtt, xe_gt_hw_engine(ggtt->tile->primary_gt,
+							XE_ENGINE_CLASS_COPY, 0, false));
 }
 
 static void ggtt_node_fini(struct xe_ggtt_node *node)
@@ -536,6 +642,9 @@ void xe_ggtt_node_remove(struct xe_ggtt_node *node, bool invalidate)
  * xe_ggtt_init - Regular non-early GGTT initialization
  * @ggtt: the &xe_ggtt to be initialized
  *
+ * Allocate the scratch page if needed and clear unused entries, or defer
+ * the clear to xe_ggtt_init_late() when GPU initialization is enabled.
+ *
  * Return: 0 on success or a negative error code on failure.
  */
 int xe_ggtt_init(struct xe_ggtt *ggtt)
@@ -572,7 +681,8 @@ int xe_ggtt_init(struct xe_ggtt *ggtt)
 			      xe_bo_size(ggtt->scratch));
 	}
 
-	xe_ggtt_initial_clear(ggtt);
+	if (!ggtt_use_gpu(xe))
+		xe_ggtt_initial_clear(ggtt, NULL);
 
 	return devm_add_action_or_reset(xe->drm.dev, ggtt_fini, ggtt);
 err:
diff --git a/drivers/gpu/drm/xe/xe_ggtt.h b/drivers/gpu/drm/xe/xe_ggtt.h
index c864cc975a69..cae8600d7142 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.h
+++ b/drivers/gpu/drm/xe/xe_ggtt.h
@@ -17,6 +17,7 @@ struct xe_ggtt *xe_ggtt_alloc(struct xe_tile *tile);
 int xe_ggtt_init_early(struct xe_ggtt *ggtt);
 int xe_ggtt_init_kunit(struct xe_ggtt *ggtt, u32 reserved, u32 size);
 int xe_ggtt_init(struct xe_ggtt *ggtt);
+int xe_ggtt_init_late(struct xe_ggtt *ggtt);
 
 void xe_ggtt_shift_nodes(struct xe_ggtt *ggtt, u64 new_base);
 u64 xe_ggtt_start(struct xe_ggtt *ggtt);
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 45fb074812a2..d1c14a02de66 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -686,7 +686,8 @@ static int gt_init_with_all_forcewake(struct xe_gt *gt)
 	if (err)
 		return err;
 
-	return 0;
+	return xe_gt_is_main_type(gt) ?
+		xe_ggtt_init_late(gt_to_tile(gt)->mem.ggtt) : 0;
 }
 
 static void xe_gt_fini(void *arg)
diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
index 897724cb5cfb..44cc0107cf53 100644
--- a/drivers/gpu/drm/xe/xe_module.c
+++ b/drivers/gpu/drm/xe/xe_module.c
@@ -22,6 +22,7 @@
 #include "xe_sched_job.h"
 
 struct xe_modparam xe_modparam = {
+	.ggtt_init_gpu =		true,
 	.probe_display =	XE_DEFAULT_PROBE_DISPLAY,
 	.guc_log_level =	XE_DEFAULT_GUC_LOG_LEVEL,
 	.force_probe =		XE_DEFAULT_FORCE_PROBE,
@@ -34,6 +35,10 @@ struct xe_modparam xe_modparam = {
 	/* the rest are 0 by default */
 };
 
+module_param_named(ggtt_init_gpu, xe_modparam.ggtt_init_gpu, bool, 0444);
+MODULE_PARM_DESC(ggtt_init_gpu,
+		 "GPU GGTT initialization on Lunar Lake (default: true)");
+
 module_param_named(svm_notifier_size, xe_modparam.svm_notifier_size, uint, 0600);
 MODULE_PARM_DESC(svm_notifier_size, "Set the svm notifier size in MiB, must be power of 2 "
 		 "[default=" __stringify(XE_DEFAULT_SVM_NOTIFIER_SIZE) "]");
diff --git a/drivers/gpu/drm/xe/xe_module.h b/drivers/gpu/drm/xe/xe_module.h
index 6272d9e41207..8aa91822c35c 100644
--- a/drivers/gpu/drm/xe/xe_module.h
+++ b/drivers/gpu/drm/xe/xe_module.h
@@ -12,6 +12,7 @@ struct work_struct;
 
 /* Module modprobe variables */
 struct xe_modparam {
+	bool ggtt_init_gpu;
 	bool probe_display;
 	int force_vram_bar_size;
 	int guc_log_level;
