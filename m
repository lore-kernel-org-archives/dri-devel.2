Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D6606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ygz4dYiy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6654310FD24;
	Wed, 21 Oct 2026 10:03:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BF4310F9D3;
 Wed, 21 Oct 2026 10:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577032; x=1824113032;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LoS5kMiiUFIER/QHzmxDyI9QVJ3s3ba2yo6155hFo+Y=;
 b=Ygz4dYiyqp7dj4caIG+9lpqeT5frPu+O53RtSaWUCpnx/tgyHYP3OysM
 4QN5ysz57nJkr/W5Tk8PQmwV+LrcXKVmwmZZ03BXaU1YoI9C2u1J7z/k7
 WhV3Fau2wlflVuFapwzLFY2b01ERrt3mB8XdyQTMSLBx3ke8ngfPCozeS
 a66kdFhrq8ujOys+XNXKvrb0m06Mm4uB93ZQUk6SjpmjsnB4h1XA+49Tl
 +YoEm4aTen/I1bNdGX9wCNj3KkJQvXLjJV2T3vN+tW80F48xmp3SzCI9c
 mAmIYSb6vz+pGC27xouDMF15jKQADn17S0siBPUl3jyqW9W4qrUkEfvaw g==;
X-CSE-ConnectionGUID: tFaaYZuySWePCOfw3u/oXA==
X-CSE-MsgGUID: Pt8f554kSG2v1LGLQJEk9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290276"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290276"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:51 -0700
X-CSE-ConnectionGUID: YZ55BeetRcWCBBZerQ4JDg==
X-CSE-MsgGUID: H/uROJHVRdWM22P59zgfIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382070"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:49 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 05/17] drm/xe: Drop queued page faults when device I/O is
 blocked
Date: Wed, 21 Oct 2026 15:33:06 +0530
Message-ID: <20261021100322.1014449-6-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021100322.1014449-1-arvind.yadav@intel.com>
References: <20261021100322.1014449-1-arvind.yadav@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v3:
- Hold the common device I/O gate across fault servicing. (Thomas)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_pagefault.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index 5247321c805e..c9458688684b 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -270,6 +270,7 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
 	struct xe_device *xe = gt_to_xe(gt);
 	struct xe_vm *vm;
 	struct xe_vma *vma = NULL;
+	int io_idx;
 	int err;
 	bool atomic;
 	u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
@@ -278,13 +279,17 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
 	if (pf->consumer.fault_type_level == XE_PAGEFAULT_TYPE_LEVEL_NACK)
 		return -EFAULT;
 
+	err = xe_device_io_get(xe, &io_idx);
+	if (err)
+		return err;
+
 	vm = xe_pagefault_asid_to_vm(pf, asid);
 	if (IS_ERR(vm)) {
 		err = PTR_ERR(vm);
 		trace_xe_pagefault_fail(xe, NULL, NULL, asid,
 					xe_pagefault_addr(pf),
 					xe_pagefault_get_error(pf), err);
-		return err;
+		goto out_io;
 	}
 
 	xe_migrate_ulls_enter(gt_to_tile(gt)->migrate);
@@ -328,6 +333,8 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
 	up_read(&vm->lock);
 	xe_vm_put(vm);
 
+out_io:
+	xe_device_io_put(io_idx);
 	return err;
 }
 
@@ -517,6 +524,12 @@ static bool xe_pagefault_queue_pop(struct xe_pagefault_queue *pf_queue,
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

