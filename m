Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4E9CD6E57
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FD8610E5FB;
	Thu,  4 Jun 2026 09:50:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D+eu5qjR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B08F10E5FB;
 Thu,  4 Jun 2026 09:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780566633; x=1812102633;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iscvMmBYia52VxsUrY5YxqjB9QK1YeVVbNw7DwcOfqI=;
 b=D+eu5qjRFiNN4ZPfBwC6Zg2N2jmV6+Hg+3y9zkGIzo62OGD6Gxm7C+dk
 /HzaRrGTHMXhb8RSSreDS44LC5lkMP3MsDNyVIoTJ5wKOB37/NSpV3e3G
 CqwsS7dQ2B/4XhYL9dLJfbIVs77DwRQhk1jPcSgRSpEdKqqsqwt7yhZ88
 sVP98QDec3OtD/8fXO+NDdYecE9iL67fveCsUWRcTeHIGWBaPJe+rrtK0
 0BbSbIGImWa8EShVVCDIf0W3b9b7m7R6fqEUquKOlb9ejSp2rGCSoWo64
 zj3hAkYUz7vXSkfvhuIXHMgw4oBEE9wKVcArQNQfcbayBepHJW9ZJ1bN5 w==;
X-CSE-ConnectionGUID: 1Qse4oHsSMm33hM7QiXpVw==
X-CSE-MsgGUID: e0VMWzrqQe6mAzT8YvYryQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98810521"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="98810521"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:32 -0700
X-CSE-ConnectionGUID: UJi96a/+RkKf5K4QNuQ1Mg==
X-CSE-MsgGUID: XJkKjO2pRvCOGT5meiTyWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="282602357"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:30 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com
Subject: [RFC v3 3/7] drm/xe/svm: Clear CPU_AUTORESET_ACTIVE on first GPU fault
Date: Thu,  4 Jun 2026 15:20:08 +0530
Message-ID: <20260604095012.367231-4-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604095012.367231-1-arvind.yadav@intel.com>
References: <20260604095012.367231-1-arvind.yadav@intel.com>
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

CPU address mirror VMAs start with cpu_autoreset_active set, indicating
they are still CPU-only.

Clear cpu_autoreset_active after successful fault handling. A successful
return means the fault address already has a valid GPU mapping or PTEs
were installed. Prefetch faults that do not establish a mapping return an
error and do not transition the state.

v2:
  - Move xe_vma_gpu_touch() to the success path in
    xe_svm_handle_pagefault() so prefetch faults that find no range do
    not transition the state. (Matt)
  - Add xe_vma_gpu_touch() helper in xe_vm.h and use
    vma->cpu_autoreset_active instead of vma->gpuva.flags. (Matt)

v3:
  - Drop lockdep_assert_held_write from xe_svm_handle_pagefault. (Matt)
  - Re-fetch the VMA in xe_pagefault_service() before clearing state.
  - Move gpu_touch from xe_svm_handle_pagefault to xe_pagefault_service
    (Matt)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_pagefault.c | 10 +++++++++-
 drivers/gpu/drm/xe/xe_vm.h        | 13 +++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index dd3c068e1a39..f64d3df08261 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -215,8 +215,16 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
 		err = xe_pagefault_handle_vma(gt, vma, atomic);
 
 unlock_vm:
-	if (!err)
+	if (!err) {
+		/* Re-fetch, fault handling may have replaced the VMA. */
+		vma = xe_vm_find_vma_by_addr(vm, pf->consumer.page_addr);
 		vm->usm.last_fault_vma = vma;
+
+		/* First successful GPU fault ends CPU-only state. */
+		if (vma && xe_vma_is_cpu_addr_mirror(vma) &&
+		    xe_vma_has_cpu_autoreset_active(vma))
+			xe_vma_gpu_touch(vma);
+	}
 	up_write(&vm->lock);
 	xe_vm_put(vm);
 
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index 0dd201cce968..0ad704b05687 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -450,4 +450,17 @@ static inline struct drm_exec *xe_vm_validation_exec(struct xe_vm *vm)
 	((READ_ONCE(tile_present) & ~READ_ONCE(tile_invalidated)) & BIT((tile)->id))
 
 void xe_vma_mem_attr_copy(struct xe_vma_mem_attr *to, struct xe_vma_mem_attr *from);
+
+/**
+ * xe_vma_gpu_touch() - Mark a VMA as no longer CPU-only
+ * @vma: VMA to update
+ *
+ * Clear cpu_autoreset_active after the first successful GPU fault-in.
+ * Caller must hold vm->lock in write mode.
+ */
+static inline void xe_vma_gpu_touch(struct xe_vma *vma)
+{
+	lockdep_assert_held_write(&xe_vma_vm(vma)->lock);
+	vma->cpu_autoreset_active = false;
+}
 #endif
-- 
2.43.0

