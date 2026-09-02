Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9EBC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 21:44:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAE0010E7D8;
	Wed,  2 Sep 2026 21:44:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kuUAASsm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB0D10E7D8;
 Wed,  2 Sep 2026 21:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788385448; x=1819921448;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hADbGKsG2GNP7ZSOHpEyR14RG0xZoJNeZoGIfYBdNS4=;
 b=kuUAASsmCpWebFEivOwdPQ/DIPrmXA+oQ02Sfboh28m+6lESpcBlyX4Q
 hY+u2n0C5Z/GvsKjIMvxplAG2MvqvztDmixB6byMd77qPcp21xo5spMBM
 yv3El1FX18Hh+eHam+k5fIgHNRBq6JBmgkB7FDQKFjPwj7WlmEq3zoHD3
 6QMU38LQ/+k0bhjPSkosjlTMkCjx80j1zJHKEMyJ6mCIfWsPvwK3eKzYm
 KA+Bo+OkxKhbag6F/gysqwmy5KnVgcwuD+I3Uc2vx8HLv2LGb8mU3cAsF
 zprmMjNQIbaGVDMqz/V/GG0mIfrc/xcoBICS5i6lwfh86Ta0uCN4ikvC5 w==;
X-CSE-ConnectionGUID: uqmvZKqgQVGCv3mJpwxzCw==
X-CSE-MsgGUID: L2UC3VNGQQ6rq89VK0ARuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="87997784"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="87997784"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 14:44:08 -0700
X-CSE-ConnectionGUID: 1VCRX1apSk61TTh8Lfm+Vw==
X-CSE-MsgGUID: ggOZ/a0bStqUtVcQGqjxTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; d="scan'208";a="266929181"
Received: from osgc-sh-dragon.sh.intel.com ([10.239.81.44])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 14:44:04 -0700
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: alex.zuo@intel.com, jonathan.cavitt@intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org, Rodrigo.vivi@intel.com,
 matthew.brost@intel.com, maarten.lankhorst@linux.intel.com,
 thomas.hellstrom@linux.intel.com, tzimmermann@suse.de
Subject: [PATCH v7 1/2] drm/xe/pagefault: Add SRCID to pagefault struct
Date: Thu,  3 Sep 2026 05:43:57 +0800
Message-ID: <20260902214358.348399-2-jonathan.cavitt@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902214358.348399-1-jonathan.cavitt@intel.com>
References: <20260902214358.348399-1-jonathan.cavitt@intel.com>
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

v4:
- Various formatting fixes

Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/xe/xe_guc_pagefault.c   |  8 +++++++-
 drivers/gpu/drm/xe/xe_pagefault.c       | 24 +++++++++++++++---------
 drivers/gpu/drm/xe/xe_pagefault_types.h |  9 +++++++--
 3 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_pagefault.c b/drivers/gpu/drm/xe/xe_guc_pagefault.c
index 8f8210a732e98..df237fd405519 100644
--- a/drivers/gpu/drm/xe/xe_guc_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_guc_pagefault.c
@@ -108,7 +108,13 @@ int xe_guc_pagefault_handler(struct xe_guc *guc, u32 *msg, u32 len)
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
index 2e415995f067b..e81ca24df37fc 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -252,12 +252,13 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
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
 
@@ -374,7 +375,7 @@ static bool xe_pagefault_match(struct xe_pagefault *pf, u64 start,
 {
 	struct xe_device *xe = gt_to_xe(pf->gt);
 	u64 page_addr = pf->consumer.page_addr;
-	u32 pf_asid = pf->consumer.asid;
+	u32 pf_asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
 
 	xe_assert(xe, pf->consumer.alloc_state !=
 		  XE_PAGEFAULT_ALLOC_STATE_FREE);
@@ -499,7 +500,7 @@ static bool xe_pagefault_queue_pop(struct xe_pagefault_queue *pf_queue,
 		align = SZ_4K;
 	pf_work->cache.start = ALIGN_DOWN(lpf->consumer.page_addr, align);
 	pf_work->cache.end = pf_work->cache.start + align;
-	pf_work->cache.asid = lpf->consumer.asid;
+	pf_work->cache.asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, lpf->consumer.id);
 	pf_work->cache.pf = lpf;
 	lpf->consumer.alloc_state = XE_PAGEFAULT_ALLOC_STATE_ACTIVE;
 
@@ -545,14 +546,16 @@ static void xe_pagefault_print(struct xe_pagefault *pf)
 	u8 engine_class = FIELD_GET(XE_PAGEFAULT_ENGINE_CLASS_MASK,
 				    pf->consumer.engine_class_instance);
 
-	xe_gt_info(pf->gt, "\n\tASID: %d\n"
+	xe_gt_info(pf->gt, "\n\tASID: %lu\n"
 		   "\tFaulted Address: 0x%08x%08x\n"
 		   "\tFaultType: %lu\n"
 		   "\tAccessType: %lu\n"
 		   "\tFaultLevel: %lu\n"
 		   "\tEngineClass: %d %s\n"
-		   "\tEngineInstance: %lu\n",
-		   pf->consumer.asid,
+		   "\tEngineInstance: %lu\n"
+		   "\tSRCID: 0x%02lx\n",
+		   FIELD_GET(XE_PAGEFAULT_ASID_MASK,
+			     pf->consumer.id),
 		   upper_32_bits(pf->consumer.page_addr),
 		   lower_32_bits(pf->consumer.page_addr),
 		   FIELD_GET(XE_PAGEFAULT_TYPE_MASK,
@@ -564,7 +567,9 @@ static void xe_pagefault_print(struct xe_pagefault *pf)
 		   engine_class,
 		   xe_hw_engine_class_to_str(engine_class),
 		   FIELD_GET(XE_PAGEFAULT_ENGINE_INSTANCE_MASK,
-			     pf->consumer.engine_class_instance));
+			     pf->consumer.engine_class_instance),
+		   FIELD_GET(XE_PAGEFAULT_SRCID_MASK,
+			     pf->consumer.id));
 }
 
 static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *pf)
@@ -577,7 +582,8 @@ static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *p
 	 * mode, return VM anyways.
 	 */
 	down_read(&xe->usm.lock);
-	vm = xa_load(&xe->usm.asid_to_vm, pf->consumer.asid);
+	vm = xa_load(&xe->usm.asid_to_vm,
+		     FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id));
 	if (vm)
 		xe_vm_get(vm);
 	else
@@ -611,7 +617,7 @@ static void xe_pagefault_queue_work(struct work_struct *w)
 		const struct xe_pagefault_ops *ops = pf->producer.ops;
 		void *private = pf->producer.private;
 		struct xe_gt *gt = pf->gt;
-		u32 asid = pf->consumer.asid;
+		u32 asid = FIELD_GET(XE_PAGEFAULT_ASID_MASK, pf->consumer.id);
 		int err = 0;
 		bool invalidated = false;
 
diff --git a/drivers/gpu/drm/xe/xe_pagefault_types.h b/drivers/gpu/drm/xe/xe_pagefault_types.h
index efeba5c3a58ba..f16bab29bfc30 100644
--- a/drivers/gpu/drm/xe/xe_pagefault_types.h
+++ b/drivers/gpu/drm/xe/xe_pagefault_types.h
@@ -112,8 +112,13 @@ struct xe_pagefault {
 				u8 engine_class_instance;
 #define XE_PAGEFAULT_ENGINE_CLASS_MASK		GENMASK(3, 0)
 #define XE_PAGEFAULT_ENGINE_INSTANCE_MASK	GENMASK(7, 4)
-				/** @consumer.asid: address space ID */
-				u32 asid;
+				/**
+				 * @consumer.id: address space ID and SRCID, folded into one
+				 * to keep size compact
+				 */
+				u32 id;
+#define XE_PAGEFAULT_ASID_MASK	GENMASK(23, 0)
+#define XE_PAGEFAULT_SRCID_MASK	GENMASK(31, 24)
 			};
 			/**
 			 * @consumer.end_addr: end address of page fault,
-- 
2.53.0

