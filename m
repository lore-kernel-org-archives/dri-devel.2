Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A66CD98F6
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C33DD10F338;
	Thu, 18 Jun 2026 15:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dRwzc0O1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C6F10F333;
 Thu, 18 Jun 2026 15:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781796803; x=1813332803;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NLxmMIAcvEuy+qce/54+QECwsVnjEkDUsxF71PiHoYQ=;
 b=dRwzc0O1l59O+mt7yPhIHgusrRfBMfGtr1t2FL5lCcAcU5QdajsneP4z
 WYAGMvTFLqLBNsw8rJd3jcnuNjLKY9XCUBiQsqp6C1iVS1UtmCUuDx/kw
 7KLttGvTjZaQS2VekXg9c9V0KHXFjs/vA/j+iyjH7z/1NUX5HbcMRcN1R
 2LCHw0/mN+n1V/su2h8Z83eGR5Ekuu1jRfEcvvi6+D1Z9schaspEnL3Sy
 0RBl7Pn7Wk5EGSVBRhpAu8oj4oqzbhV2pV8HohHOyj7AwRN9OhE4LSrFk
 3kC2ZFCLZ4eE40if9zuE8i+5wZsZxhfiW+AECeP9bmH5uGYodciqbJJ9s g==;
X-CSE-ConnectionGUID: N36+cxEQQhOXhezBXiTKRQ==
X-CSE-MsgGUID: qxkZdagCTnW3bke6CCmkXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="82403587"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="82403587"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 08:33:22 -0700
X-CSE-ConnectionGUID: SPPUWjtxR1W51i9NkB1zew==
X-CSE-MsgGUID: eaw3F69pSsyjABA45+j9nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="244045813"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 08:33:19 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: saurabhg.gupta@intel.com, alex.zuo@intel.com, jonathan.cavitt@intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 Rodrigo.vivi@intel.com, matthew.brost@intel.com,
 maarten.lankhorst@linux.intel.com, thomas.hellstrom@linux.intel.com,
 tzimmermann@suse.de
Subject: [PATCH v4 1/2] drm/xe/pagefault: Add SRCID to pagefault struct
Date: Thu, 18 Jun 2026 23:33:11 +0800
Message-ID: <20260618153312.877948-2-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618153312.877948-1-jonathan.cavitt@intel.com>
References: <20260618153312.877948-1-jonathan.cavitt@intel.com>
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

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/xe/xe_guc_pagefault.c   |  5 ++++-
 drivers/gpu/drm/xe/xe_pagefault.c       | 23 +++++++++++++++--------
 drivers/gpu/drm/xe/xe_pagefault_types.h |  9 +++++++--
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_pagefault.c b/drivers/gpu/drm/xe/xe_guc_pagefault.c
index 607e32392f46..7d24bd828e5b 100644
--- a/drivers/gpu/drm/xe/xe_guc_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_guc_pagefault.c
@@ -78,7 +78,10 @@ int xe_guc_pagefault_handler(struct xe_guc *guc, u32 *msg, u32 len)
 				      << PFD_VIRTUAL_ADDR_HI_SHIFT) |
 		(FIELD_GET(PFD_VIRTUAL_ADDR_LO, msg[2]) <<
 		 PFD_VIRTUAL_ADDR_LO_SHIFT);
-	pf.consumer.asid = FIELD_GET(PFD_ASID, msg[1]);
+	pf.consumer.id = FIELD_PREP(XE_PAGEFAULT_ASID_MASK,
+				    FIELD_GET(PFD_ASID, msg[1])) |
+			 FIELD_PREP(XE_PAGEFAULT_SRCID_MASK,
+				    FIELD_GET(PFD_SRC_ID, msg[0]));
 	pf.consumer.access_type = FIELD_GET(PFD_ACCESS_TYPE, msg[2]) |
 		(FIELD_GET(PFD_PREFETCH, msg[2]) ? XE_PAGEFAULT_ACCESS_PREFETCH : 0);
 	if (FIELD_GET(XE2_PFD_TRVA_FAULT, msg[0]))
diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index dd3c068e1a39..2a21203b1a2a 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -169,6 +169,7 @@ static struct xe_vm *xe_pagefault_asid_to_vm(struct xe_device *xe, u32 asid)
 
 static int xe_pagefault_service(struct xe_pagefault *pf)
 {
+	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
 	struct xe_gt *gt = pf->gt;
 	struct xe_device *xe = gt_to_xe(gt);
 	struct xe_vm *vm;
@@ -180,7 +181,7 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
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

