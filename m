Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0413EC4450D
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1915810E6FA;
	Sat, 11 Jul 2026 02:56:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nuRB7F9s";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20D2F10E2DA;
 Sat, 11 Jul 2026 02:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738591; x=1815274591;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jUP46rCXR5p1gO8AkvSmHQmoyTlzoqte4KPKu2WTmp8=;
 b=nuRB7F9sDwt6ziHkOSwzVdBDe3UqSN58L4fgRjX1hXtkBxynojvlIUEM
 mKGxq2D/uSJrDm/JpaFHul71M7s6INCLC/ybqVx+HZo6Dnrz20qbqqNvI
 anV5vAPfP4CedywlombnjqVV8XwBCM5vQAwvDD6HFRJjPL+npwPtGGH7l
 g+N/lMCoNw0mpmATCtYytTfpirl3Hh4X5xpHvrZ49isEM8CKdLMMjJ3zz
 NYedvoQua0MfjP+msNx02Fd3xCVwUhUgn1gkWYzYuF69pCZAsaTzRqody
 OrIYzy52xx5qyadGzoapU7EjeBwiT3rdzzGWF3vPhWKMugCxfQO5rT+Xu w==;
X-CSE-ConnectionGUID: QxGPS28sSRSvOd9JVwZNTg==
X-CSE-MsgGUID: JEQoQ2iOQ9CDL6fbB0EjcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986315"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986315"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:31 -0700
X-CSE-ConnectionGUID: dQVDfjTAQuWoSiYkAj9KoA==
X-CSE-MsgGUID: kr458sBhTEGlVxy46APNPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987764"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:30 -0700
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
Subject: [PATCH v3 21/33] drm/xe: Add defrag GT stats
Date: Fri, 10 Jul 2026 19:56:07 -0700
Message-Id: <20260711025619.2540575-22-matthew.brost@intel.com>
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

Add observability for the page defragmentation worker.

Introduce four primary-GT statistics counters: defrag_added_count
(BOs queued onto the defrag list after being backed at a sub-optimal
page order), defrag_success_count (BOs fully re-backed at the beneficial
order), defrag_partial_success_count (BOs only partially re-backed at the
beneficial order) defrag_failed_count (attempts that failed and left the
BO on its original backing) and defrag_mb_moved. The
ineligible/already-removed fast path is intentionally not counted as
either success or failure.

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
---
 drivers/gpu/drm/xe/xe_bo.c             | 18 +++++++++++++++++-
 drivers/gpu/drm/xe/xe_gt_stats.c       |  5 +++++
 drivers/gpu/drm/xe/xe_gt_stats_types.h | 17 +++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 907cfa57481f..073d926ef9ac 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -26,6 +26,7 @@
 #include "xe_dma_buf.h"
 #include "xe_drm_client.h"
 #include "xe_ggtt.h"
+#include "xe_gt_stats.h"
 #include "xe_map.h"
 #include "xe_migrate.h"
 #include "xe_pat.h"
@@ -1160,6 +1161,8 @@ static void xe_bo_defrag_add(struct xe_bo *bo)
 				xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
 			list_add_tail(&bo->defrag_link, &xe->mem.defrag.list);
 			atomic_inc(&xe->mem.defrag.count);
+			xe_gt_stats_incr(xe_root_mmio_gt(xe),
+					 XE_GT_STATS_ID_DEFRAG_ADDED_COUNT, 1);
 		}
 	}
 
@@ -1274,8 +1277,21 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
 	xe_dbg(xe, "Defrag attempt on BO size=%zu: ret=%pe consumed=%llu\n",
 	       xe_bo_size(bo), ERR_PTR(ret), *consumed);
 
-	if (!ret && ttm_tt_is_beneficial_order_failed(bo->ttm.ttm))
+	if (!ret && ttm_tt_is_beneficial_order_failed(bo->ttm.ttm)) {
 		*needs_more = true;
+		xe_gt_stats_incr(xe_root_mmio_gt(xe),
+				 XE_GT_STATS_ID_DEFRAG_PARTIAL_SUCCESS_COUNT,
+				 1);
+	} else {
+		xe_gt_stats_incr(xe_root_mmio_gt(xe),
+				 ret ? XE_GT_STATS_ID_DEFRAG_FAILED_COUNT :
+				       XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT, 1);
+	}
+
+	if (!ret)
+		xe_gt_stats_incr(xe_root_mmio_gt(xe),
+				 XE_GT_STATS_ID_DEFRAG_MB_MOVED,
+				 *consumed >> 20);
 
 unlock:
 	xe_bo_unlock(bo);
diff --git a/drivers/gpu/drm/xe/xe_gt_stats.c b/drivers/gpu/drm/xe/xe_gt_stats.c
index 789397514f3e..68e60d9500c8 100644
--- a/drivers/gpu/drm/xe/xe_gt_stats.c
+++ b/drivers/gpu/drm/xe/xe_gt_stats.c
@@ -154,6 +154,11 @@ static const char *const stat_description[__XE_GT_STATS_NUM_IDS] = {
 	DEF_STAT_STR(PRL_2M_ENTRY_COUNT, "prl_2m_entry_count"),
 	DEF_STAT_STR(PRL_ISSUED_COUNT, "prl_issued_count"),
 	DEF_STAT_STR(PRL_ABORTED_COUNT, "prl_aborted_count"),
+	DEF_STAT_STR(DEFRAG_ADDED_COUNT, "defrag_added_count"),
+	DEF_STAT_STR(DEFRAG_SUCCESS_COUNT, "defrag_success_count"),
+	DEF_STAT_STR(DEFRAG_PARTIAL_SUCCESS_COUNT, "defrag_partial_success_count"),
+	DEF_STAT_STR(DEFRAG_FAILED_COUNT, "defrag_failed_count"),
+	DEF_STAT_STR(DEFRAG_MB_MOVED, "defrag_mb_moved"),
 };
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_gt_stats_types.h b/drivers/gpu/drm/xe/xe_gt_stats_types.h
index 425491bed6c4..c42b494390f8 100644
--- a/drivers/gpu/drm/xe/xe_gt_stats_types.h
+++ b/drivers/gpu/drm/xe/xe_gt_stats_types.h
@@ -122,6 +122,18 @@
  * @XE_GT_STATS_ID_PRL_ABORTED_COUNT: Times the page reclaim process was
  *   aborted.
  *
+ * @XE_GT_STATS_ID_DEFRAG_ADDED_COUNT: Times a buffer object was added to the
+ *   page defragmentation list after being backed at a sub-optimal page order.
+ * @XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT: Times the defrag worker successfully
+ *   re-backed a buffer object at the beneficial page order.
+ * @XE_GT_STATS_ID_DEFRAG_PARTIAL_SUCCESS_COUNT: Times the defrag worker
+ *   partially re-backed a buffer object at the beneficial page order.
+ * @XE_GT_STATS_ID_DEFRAG_FAILED_COUNT: Times the defrag worker failed to
+ *   re-back a buffer object at the beneficial page order.
+ * @XE_GT_STATS_ID_DEFRAG_MB_MOVED: Data (MiB) actually (re)allocated while
+ *   re-backing buffer objects at the beneficial page order. Chunks borrowed
+ *   from the old backing for free are not counted.
+ *
  * @__XE_GT_STATS_NUM_IDS: Number of valid IDs; not a real counter.
  *
  * See Documentation/gpu/xe/xe_gt_stats.rst.
@@ -181,6 +193,11 @@ enum xe_gt_stats_id {
 	XE_GT_STATS_ID_PRL_2M_ENTRY_COUNT,
 	XE_GT_STATS_ID_PRL_ISSUED_COUNT,
 	XE_GT_STATS_ID_PRL_ABORTED_COUNT,
+	XE_GT_STATS_ID_DEFRAG_ADDED_COUNT,
+	XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT,
+	XE_GT_STATS_ID_DEFRAG_PARTIAL_SUCCESS_COUNT,
+	XE_GT_STATS_ID_DEFRAG_FAILED_COUNT,
+	XE_GT_STATS_ID_DEFRAG_MB_MOVED,
 	/* must be the last entry */
 	__XE_GT_STATS_NUM_IDS,
 };
-- 
2.34.1

