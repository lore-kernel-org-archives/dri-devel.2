Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DABC98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB36A10EC31;
	Tue, 22 Sep 2026 10:17:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kVYWkOAW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2838410EC2C;
 Tue, 22 Sep 2026 10:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072266; x=1821608266;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dRTRYoqChd+4SIzmVRNR600spa6/Z8j4YaeFDLZL7Tc=;
 b=kVYWkOAWfDPhiWGDna+S2IBlzvYKZG4cSeqhxhSu3+ceEc+k9DziN5W1
 fOTuMILuvNFWZiTpP+aXiPP/OIUfdKymhVM1PtiPcYZJ12/PPhiNeftlL
 eN04FALGNXSLCsSZBvVMtq63RJxiIS1r4Ns3L2jASY9T01tBs+G44mtbP
 sAlM1iYsRrdbmsCWpmhpqeBgVP1v+UVBnO0bttySohfuH4qTjlTeQBPMn
 XBLpGtAWj63u9b9SZUuAYWB1d4xBJHfH++DQU4kYrb9KvmCM2gZnKj0Da
 5CBnP9pZxmej2k1YObR4/iWf39D81waO29WW8SFoxfnT7ekL0Xy6smdjx Q==;
X-CSE-ConnectionGUID: A6Q0roiHT/CMccun+BRoWw==
X-CSE-MsgGUID: /GNbynvbSbyJKquJRjIQig==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322794"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322794"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:46 -0700
X-CSE-ConnectionGUID: wfmXmyFNRjS3bKpRAo0wyQ==
X-CSE-MsgGUID: rF+hBCUfTbuVTNna5ybr/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307798"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:44 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 05/15] drm/xe: Drop queued page faults when device I/O is
 blocked
Date: Tue, 22 Sep 2026 15:46:50 +0530
Message-ID: <20260922101721.1583542-6-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922101721.1583542-1-arvind.yadav@intel.com>
References: <20260922101721.1583542-1-arvind.yadav@intel.com>
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

Page-fault work may still be queued when PCI error recovery starts or
the device becomes permanently wedged. Servicing these faults can migrate
memory or update page tables after device I/O has been blocked.

Check the device state while popping queued faults. Release queued
entries instead of passing them to a worker when device I/O is blocked.

Hold the device I/O gate across fault servicing so wedge isolation waits
for faults already in progress. Faults that start after the block are
rejected at the gate.

v2:
- Move the blocked-device check into the queue pop path. (Matt)
- Drop queued faults while holding the queue lock. (Matt)
- Remove weak checks around fault servicing. (Matt)
- Hold the device I/O gate across fault servicing. (Thomas)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_pagefault.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index c4aafdbdb518..fdb77291a30f 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -267,8 +267,10 @@ static struct xe_vm *xe_pagefault_asid_to_vm(struct xe_pagefault *pf, u32 asid)
 static int xe_pagefault_service(struct xe_pagefault *pf)
 {
 	struct xe_gt *gt = pf->gt;
+	struct xe_device *xe = gt_to_xe(gt);
 	struct xe_vm *vm;
 	struct xe_vma *vma = NULL;
+	int io_idx;
 	int err;
 	bool atomic;
 	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
@@ -277,9 +279,15 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
 	if (pf->consumer.fault_type_level == XE_PAGEFAULT_TYPE_LEVEL_NACK)
 		return -EFAULT;
 
+	err = xe_device_io_get(xe, &io_idx);
+	if (err)
+		return err;
+
 	vm = xe_pagefault_asid_to_vm(pf, asid);
-	if (IS_ERR(vm))
-		return PTR_ERR(vm);
+	if (IS_ERR(vm)) {
+		err = PTR_ERR(vm);
+		goto out_io;
+	}
 
 	down_read(&vm->lock);
 
@@ -315,6 +323,8 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
 	up_read(&vm->lock);
 	xe_vm_put(vm);
 
+out_io:
+	xe_device_io_put(io_idx);
 	return err;
 }
 
@@ -504,6 +514,12 @@ static bool xe_pagefault_queue_pop(struct xe_pagefault_queue *pf_queue,
 		    XE_PAGEFAULT_ALLOC_STATE_QUEUED)
 			continue;
 
+		if (xe_device_io_blocked(xe)) {
+			lpf->consumer.alloc_state =
+				XE_PAGEFAULT_ALLOC_STATE_FREE;
+			continue;
+		}
+
 		if (xe_pagefault_try_chain(pf_queue, lpf))
 			continue;
 
-- 
2.43.0

