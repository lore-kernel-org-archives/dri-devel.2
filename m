Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC336D58B2D
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 04:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E53A10E2C9;
	Mon, 16 Mar 2026 04:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DVBYzUIt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B181B10E2B9;
 Mon, 16 Mar 2026 04:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773635583; x=1805171583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1XrjHkZEbYJpayicUHtscP/YYq9uHZqPLCAC3eYg4YE=;
 b=DVBYzUIt7pcq7NdmJqVxmSAqFRncxIgbCmi9DXdD5AWGnizZRdGDSwJh
 PqdWstE3nWBUKweX6JZKKiWITXuWchdBclxfhvkuGQ9dPucOcGC00+NUZ
 vXbX+x2YalfVncLyhGjwk5b+lFpKf+CwniJdJw8Mn47fND+LsRdyIDNl+
 Gylr83f4918czuBa9mjDlZ1ixYIawSpdf2Fkvgf02nKgba/yFpqqhr3uM
 6gGpRAcG9cmRZhQ3F09N5QYjj9c3Ohocs1mkUTD65cHm/gVMYntfLPMXp
 YTRdqKxSQabTPc5+8aOedM9RDkSgJBiHUsuDFAczbseVKm2OjU0gU2Uwp Q==;
X-CSE-ConnectionGUID: eNOQZyzHTw2EDpsGuFrSZQ==
X-CSE-MsgGUID: A/zYcUUQR/WKkB3+W0rfgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74683482"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="74683482"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:02 -0700
X-CSE-ConnectionGUID: S8BEmlHFQjajtuUSkDvwsQ==
X-CSE-MsgGUID: uYxWwU9+Sl2srZNECtQRdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="221022165"
Received: from lstrano-desk.jf.intel.com ([10.54.39.91])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Mar 2026 21:33:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 03/12] drm/xe: Use WQ_MEM_WARN_ON_RECLAIM on all
 workqueues in the reclaim path
Date: Sun, 15 Mar 2026 21:32:46 -0700
Message-Id: <20260316043255.226352-4-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316043255.226352-1-matthew.brost@intel.com>
References: <20260316043255.226352-1-matthew.brost@intel.com>
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

Mark all workqueues in the reclaim path with WQ_MEM_WARN_ON_RECLAIM to
ensure that reclaim rules are properly enforced via lockdep on these
workqueues.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_device.c    | 3 ++-
 drivers/gpu/drm/xe/xe_ggtt.c      | 3 ++-
 drivers/gpu/drm/xe/xe_gt.c        | 3 ++-
 drivers/gpu/drm/xe/xe_guc_ct.c    | 3 ++-
 drivers/gpu/drm/xe/xe_tlb_inval.c | 3 ++-
 5 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index e77a3a3db73d..00b966744d25 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -507,7 +507,8 @@ struct xe_device *xe_device_create(struct pci_dev *pdev,
 		return ERR_PTR(err);
 
 	xe->preempt_fence_wq = alloc_ordered_workqueue("xe-preempt-fence-wq",
-						       WQ_MEM_RECLAIM);
+						       WQ_MEM_RECLAIM |
+						       WQ_MEM_WARN_ON_RECLAIM);
 	xe->ordered_wq = alloc_ordered_workqueue("xe-ordered-wq", 0);
 	xe->unordered_wq = alloc_workqueue("xe-unordered-wq", WQ_PERCPU, 0);
 	xe->destroy_wq = alloc_workqueue("xe-destroy-wq", WQ_PERCPU, 0);
diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 21071b64b09d..017f679ba13f 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -434,7 +434,8 @@ int xe_ggtt_init_early(struct xe_ggtt *ggtt)
 	else
 		ggtt->pt_ops = &xelp_pt_ops;
 
-	ggtt->wq = alloc_workqueue("xe-ggtt-wq", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
+	ggtt->wq = alloc_workqueue("xe-ggtt-wq", WQ_MEM_RECLAIM | WQ_PERCPU |
+				   WQ_MEM_WARN_ON_RECLAIM, 0);
 	if (!ggtt->wq)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index bae895fa066a..79f4128fe325 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -84,7 +84,8 @@ struct xe_gt *xe_gt_alloc(struct xe_tile *tile)
 		ordered_wq = tile->primary_gt->ordered_wq;
 	else
 		ordered_wq = drmm_alloc_ordered_workqueue(drm, "gt-ordered-wq",
-							  WQ_MEM_RECLAIM);
+							  WQ_MEM_RECLAIM |
+							  WQ_MEM_WARN_ON_RECLAIM);
 	if (IS_ERR(ordered_wq))
 		return ERR_CAST(ordered_wq);
 
diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index 3b1c03743f83..7ec34ac00f59 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -325,7 +325,8 @@ int xe_guc_ct_init_noalloc(struct xe_guc_ct *ct)
 
 	primelockdep(ct);
 
-	ct->g2h_wq = alloc_ordered_workqueue("xe-g2h-wq", WQ_MEM_RECLAIM);
+	ct->g2h_wq = alloc_ordered_workqueue("xe-g2h-wq", WQ_MEM_RECLAIM |
+					     WQ_MEM_WARN_ON_RECLAIM);
 	if (!ct->g2h_wq)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
index 10dcd4abb00f..10dff2d8cf45 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
@@ -154,7 +154,8 @@ int xe_gt_tlb_inval_init_early(struct xe_gt *gt)
 
 	tlb_inval->job_wq = drmm_alloc_ordered_workqueue(&xe->drm,
 							 "gt-tbl-inval-job-wq",
-							 WQ_MEM_RECLAIM);
+							 WQ_MEM_RECLAIM |
+							 WQ_MEM_WARN_ON_RECLAIM);
 	if (IS_ERR(tlb_inval->job_wq))
 		return PTR_ERR(tlb_inval->job_wq);
 
-- 
2.34.1

