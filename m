Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816BACDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D50110ED05;
	Tue, 23 Jun 2026 22:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BjdrtiN6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6508210ECDF;
 Tue, 23 Jun 2026 22:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782253660; x=1813789660;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JF1KBaUYcnQlhUIab7d6oSG/+nHTf5L8D2+tc00mix0=;
 b=BjdrtiN61J2wr8WEkFc3i3jTcCNV46UDNMJmeI+eGZeaGUqwgR5CbDP6
 Z/fAYIkXYrSBFeU77R7q/9s1cL1uV4lZAMZUnOrICTDIeR2xl9XqMNOco
 zYi7w+mVU/I9upCrqvkJJsiZG1Apw63mbNwVKV0XOb6vXoqv5PdNPBJog
 84Zyl8h3cFjNZMMovMpjEw39eW8OZQ1Hdvg8imdO8bs+BWNIZMTmCiTHC
 kbA9CvV2XeO0ioEAyWkczEQGn/VMPhPJLoJJD+1NNOryI2GGL1/jeDvVF
 o6tXbp1cFz6bfQgae5lSiOGrlloaHKA6IOe3t48l6ZXaD+p8wr61Hc/9S Q==;
X-CSE-ConnectionGUID: haxSQBGwTbKbzgykUnUutg==
X-CSE-MsgGUID: AS5XXJPsSI69wHpbPvMxsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83048830"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83048830"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:39 -0700
X-CSE-ConnectionGUID: iHcaf1y/TIm1x7iwTHudCw==
X-CSE-MsgGUID: jIrwNPFzR5qieYQfBFpPng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="273335811"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:40 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 10/12] drm/xe: Add defrag GT stats
Date: Tue, 23 Jun 2026 15:27:30 -0700
Message-Id: <20260623222732.360872-11-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623222732.360872-1-matthew.brost@intel.com>
References: <20260623222732.360872-1-matthew.brost@intel.com>
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

Introduce three primary-GT statistics counters: defrag_added_count
(BOs queued onto the defrag list after being backed at a sub-optimal
page order), defrag_success_count (BOs successfully re-backed at the
beneficial order) and defrag_failed_count (attempts that failed and
leave the BO on its original backing). The ineligible/already-removed
fast path is intentionally not counted as either success or failure.

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
 drivers/gpu/drm/xe/xe_bo.c             |  7 +++++++
 drivers/gpu/drm/xe/xe_gt_stats.c       |  3 +++
 drivers/gpu/drm/xe/xe_gt_stats_types.h | 10 ++++++++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 097cd2ad7c1a..1612e4ece1e1 100644
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
@@ -1042,6 +1043,8 @@ static void xe_bo_defrag_add(struct xe_bo *bo)
 				xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
 			list_add_tail(&bo->defrag_link, &xe->mem.defrag.list);
 			atomic_inc(&xe->mem.defrag.count);
+			xe_gt_stats_incr(xe_root_mmio_gt(xe),
+					 XE_GT_STATS_ID_DEFRAG_ADDED_COUNT, 1);
 		}
 	}
 
@@ -1136,6 +1139,10 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo)
 	xe_dbg(xe, "Defrag attempt on BO size=%lu: ret=%pe\n", xe_bo_size(bo),
 	       ERR_PTR(ret));
 
+	xe_gt_stats_incr(xe_root_mmio_gt(xe),
+			 ret ? XE_GT_STATS_ID_DEFRAG_FAILED_COUNT :
+			       XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT, 1);
+
 unlock:
 	xe_bo_unlock(bo);
 	return ret;
diff --git a/drivers/gpu/drm/xe/xe_gt_stats.c b/drivers/gpu/drm/xe/xe_gt_stats.c
index 789397514f3e..08e79881f5e5 100644
--- a/drivers/gpu/drm/xe/xe_gt_stats.c
+++ b/drivers/gpu/drm/xe/xe_gt_stats.c
@@ -154,6 +154,9 @@ static const char *const stat_description[__XE_GT_STATS_NUM_IDS] = {
 	DEF_STAT_STR(PRL_2M_ENTRY_COUNT, "prl_2m_entry_count"),
 	DEF_STAT_STR(PRL_ISSUED_COUNT, "prl_issued_count"),
 	DEF_STAT_STR(PRL_ABORTED_COUNT, "prl_aborted_count"),
+	DEF_STAT_STR(DEFRAG_ADDED_COUNT, "defrag_added_count"),
+	DEF_STAT_STR(DEFRAG_SUCCESS_COUNT, "defrag_success_count"),
+	DEF_STAT_STR(DEFRAG_FAILED_COUNT, "defrag_failed_count"),
 };
 
 /**
diff --git a/drivers/gpu/drm/xe/xe_gt_stats_types.h b/drivers/gpu/drm/xe/xe_gt_stats_types.h
index 425491bed6c4..cc23fcc58c8b 100644
--- a/drivers/gpu/drm/xe/xe_gt_stats_types.h
+++ b/drivers/gpu/drm/xe/xe_gt_stats_types.h
@@ -122,6 +122,13 @@
  * @XE_GT_STATS_ID_PRL_ABORTED_COUNT: Times the page reclaim process was
  *   aborted.
  *
+ * @XE_GT_STATS_ID_DEFRAG_ADDED_COUNT: Times a buffer object was added to the
+ *   page defragmentation list after being backed at a sub-optimal page order.
+ * @XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT: Times the defrag worker successfully
+ *   re-backed a buffer object at the beneficial page order.
+ * @XE_GT_STATS_ID_DEFRAG_FAILED_COUNT: Times the defrag worker failed to
+ *   re-back a buffer object at the beneficial page order.
+ *
  * @__XE_GT_STATS_NUM_IDS: Number of valid IDs; not a real counter.
  *
  * See Documentation/gpu/xe/xe_gt_stats.rst.
@@ -181,6 +188,9 @@ enum xe_gt_stats_id {
 	XE_GT_STATS_ID_PRL_2M_ENTRY_COUNT,
 	XE_GT_STATS_ID_PRL_ISSUED_COUNT,
 	XE_GT_STATS_ID_PRL_ABORTED_COUNT,
+	XE_GT_STATS_ID_DEFRAG_ADDED_COUNT,
+	XE_GT_STATS_ID_DEFRAG_SUCCESS_COUNT,
+	XE_GT_STATS_ID_DEFRAG_FAILED_COUNT,
 	/* must be the last entry */
 	__XE_GT_STATS_NUM_IDS,
 };
-- 
2.34.1

