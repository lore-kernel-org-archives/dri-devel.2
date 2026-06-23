Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DB6CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 16:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7643310EBFA;
	Tue, 23 Jun 2026 16:46:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lPQXAokh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2E5810EBF9;
 Tue, 23 Jun 2026 16:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782233181; x=1813769181;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4D71NyygQury52iLzuahDD0nXvQwiZibptMGH2tkR/c=;
 b=lPQXAokhIzaOisaMcVW75QImTVYaUii2pSniycpkg99nUc/KCYE1V37M
 tgEAK4UrzYUM1mcEChq2dTMV2bTiz56EIpKZ+/oQx47sI+nnHs97QHTFj
 k7egjG3+EptXH5Vrb9L+b9GU4whzqR6G2HckfGhcrcfFOad4XD4dUNfUd
 qm4X4Sb0Y8fOJoYeHdP0S48/mc+giJlktfe4+K7/gyuyEefMZB7LpKBoC
 tne2GvWf2TIZlIXtOXGdTxTuM/ptP4I9Jjke4wwWZJPtx8x7trfyU5kDV
 ZKFmrVlBZwZifwH0hlrREea+FpFnyAOmRm/Xx2BLP9FASp6SPFqi4zyWi Q==;
X-CSE-ConnectionGUID: wYVZXCbASmimlP80QnqW1Q==
X-CSE-MsgGUID: 5hEgSaDGRKO0IbZUHWxMzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82089364"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="82089364"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:46:20 -0700
X-CSE-ConnectionGUID: hjKUKcP1SKCYx2y4vYSu0A==
X-CSE-MsgGUID: ZPkhxGoSQdCxQzYf4ZrBbg==
X-ExtLoop1: 1
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 09:46:17 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Rodrigo.vivi@intel.com, matthew.brost@intel.com,
 maarten.lankhorst@linux.intel.com, thomas.hellstrom@linux.intel.com,
 tzimmermann@suse.de
Subject: [PATCH v5 1/2] drm/xe/pagefault: Add SRCID to pagefault struct
Date: Wed, 24 Jun 2026 00:46:09 +0800
Message-ID: <20260623164610.1019512-2-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623164610.1019512-1-jonathan.cavitt@intel.com>
References: <20260623164610.1019512-1-jonathan.cavitt@intel.com>
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

Add SRCID information to pagefault struct for the purpose of reporting
the hardware unit that resulted in the pagefault.

v2:
- Squash SRCID with ASID to keep the struct compact (Matthew)

v3:
- Use BUILD_BUG_ON and move ASID definition in one function (Matthew)

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/xe/xe_guc_pagefault.c   |  8 +++++++-
 drivers/gpu/drm/xe/xe_pagefault.c       | 23 +++++++++++++++--------
 drivers/gpu/drm/xe/xe_pagefault_types.h |  9 +++++++--
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_pagefault.c b/drivers/gpu/drm/xe/xe_guc_pagefault.c
index 607e32392f46..f36aa17b5b3e 100644
--- a/drivers/gpu/drm/xe/xe_guc_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_guc_pagefault.c
@@ -78,7 +78,13 @@ int xe_guc_pagefault_handler(struct xe_guc *guc, u32 *msg, u32 len)
 				      << PFD_VIRTUAL_ADDR_HI_SHIFT) |
 		(FIELD_GET(PFD_VIRTUAL_ADDR_LO, msg[2]) <<
 		 PFD_VIRTUAL_ADDR_LO_SHIFT);
-	pf.consumer.asid = FIELD_GET(PFD_ASID, msg[1]);
+
+	BUILD_BUG_ON(XE_MAX_ASID > XE_PAGEFAULT_ASID_MASK);
+
+	pf.consumer.id = FIELD_PREP(XE_PAGEFAULT_ASID_MASK,
+				    FIELD_GET(PFD_ASID, msg[1])) |
+			 FIELD_PREP(XE_PAGEFAULT_SRCID_MASK,
+				    FIELD_GET(PFD_SRC_ID, msg[0]));
 	pf.consumer.access_type = FIELD_GET(PFD_ACCESS_TYPE, msg[2]) |
 		(FIELD_GET(PFD_PREFETCH, msg[2]) ? XE_PAGEFAULT_ACCESS_PREFETCH : 0);
 	if (FIELD_GET(XE2_PFD_TRVA_FAULT, msg[0]))
diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index dd3c068e1a39..3b0510f2a72e 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -175,12 +175,13 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
 	struct xe_vma *vma = NULL;
 	int err;
 	bool atomic;
+	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
 
 	/* Producer flagged this fault to be nacked */
 	if (pf->consumer.fault_type_level == XE_PAGEFAULT_TYPE_LEVEL_NACK)
 		return -EFAULT;
 
-	vm = xe_pagefault_asid_to_vm(xe, pf->consumer.asid);
+	vm = xe_pagefault_asid_to_vm(xe, asid);
 	if (IS_ERR(vm))
 		return PTR_ERR(vm);
 
@@ -242,14 +243,16 @@ static bool xe_pagefault_queue_pop(struct xe_pagefault_queue *pf_queue,
 
 static void xe_pagefault_print(struct xe_pagefault *pf)
 {
-	xe_gt_info(pf->gt, "\n\tASID: %d\n"
+	xe_gt_info(pf->gt, "\n\tASID: %ld\n"
 		   "\tFaulted Address: 0x%08x%08x\n"
 		   "\tFaultType: %lu\n"
 		   "\tAccessType: %lu\n"
 		   "\tFaultLevel: %lu\n"
 		   "\tEngineClass: %d %s\n"
-		   "\tEngineInstance: %d\n",
-		   pf->consumer.asid,
+		   "\tEngineInstance: %d\n"
+		   "\tSRCID: 0x%02lx\n",
+		   FIELD_GET(XE_PAGEFAULT_ASID_MASK,
+			     pf->consumer.id),
 		   upper_32_bits(pf->consumer.page_addr),
 		   lower_32_bits(pf->consumer.page_addr),
 		   FIELD_GET(XE_PAGEFAULT_TYPE_MASK,
@@ -260,7 +263,9 @@ static void xe_pagefault_print(struct xe_pagefault *pf)
 			     pf->consumer.fault_type_level),
 		   pf->consumer.engine_class,
 		   xe_hw_engine_class_to_str(pf->consumer.engine_class),
-		   pf->consumer.engine_instance);
+		   pf->consumer.engine_instance,
+		   FIELD_GET(XE_PAGEFAULT_SRCID_MASK,
+			     pf->consumer.id));
 }
 
 static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *pf)
@@ -273,7 +278,8 @@ static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *p
 	 * mode, return VM anyways.
 	 */
 	down_read(&xe->usm.lock);
-	vm = xa_load(&xe->usm.asid_to_vm, pf->consumer.asid);
+	vm = xa_load(&xe->usm.asid_to_vm,
+		     FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id));
 	if (vm)
 		xe_vm_get(vm);
 	else
@@ -474,8 +480,9 @@ static bool xe_pagefault_queue_full(struct xe_pagefault_queue *pf_queue)
  */
 int xe_pagefault_handler(struct xe_device *xe, struct xe_pagefault *pf)
 {
+	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
 	struct xe_pagefault_queue *pf_queue = xe->usm.pf_queue +
-		(pf->consumer.asid % XE_PAGEFAULT_QUEUE_COUNT);
+		(asid % XE_PAGEFAULT_QUEUE_COUNT);
 	unsigned long flags;
 	bool full;
 
@@ -489,7 +496,7 @@ int xe_pagefault_handler(struct xe_device *xe, struct xe_pagefault *pf)
 	} else {
 		drm_warn(&xe->drm,
 			 "PageFault Queue (%d) full, shouldn't be possible\n",
-			 pf->consumer.asid % XE_PAGEFAULT_QUEUE_COUNT);
+			 asid % XE_PAGEFAULT_QUEUE_COUNT);
 	}
 	spin_unlock_irqrestore(&pf_queue->lock, flags);
 
diff --git a/drivers/gpu/drm/xe/xe_pagefault_types.h b/drivers/gpu/drm/xe/xe_pagefault_types.h
index c4ee625b93dd..2213cea886c7 100644
--- a/drivers/gpu/drm/xe/xe_pagefault_types.h
+++ b/drivers/gpu/drm/xe/xe_pagefault_types.h
@@ -65,8 +65,13 @@ struct xe_pagefault {
 	struct {
 		/** @consumer.page_addr: address of page fault */
 		u64 page_addr;
-		/** @consumer.asid: address space ID */
-		u32 asid;
+#define XE_PAGEFAULT_ASID_MASK	GENMASK(23, 0)
+#define XE_PAGEFAULT_SRCID_MASK	GENMASK(31, 24)
+		/**
+		 * @consumer.id: address space ID and SRCID, folded into one
+		 * to keep size compact
+		 */
+		u32 id;
 		/**
 		 * @consumer.access_type: access type and prefetch flag packed
 		 * into a u8.
-- 
2.53.0

