Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8CE1CD6E57
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:50:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375B010E5F9;
	Thu,  4 Jun 2026 09:50:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="T3tH75yD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E432010E5FC;
 Thu,  4 Jun 2026 09:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780566637; x=1812102637;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+KD1u4L2ascAtx1H+OeEFuoFeLFDIGIxtaILtIApJp8=;
 b=T3tH75yDk1pv0mDl/zIVDJPM456chPjpbmOf5eBmvqUQ6NU/dsNdV4ua
 eJY/0L1bo1udgNaNIpozIilEgf6qZk87M1FPQyDYP1+QVCDyWuyvuv+8r
 jLQzlujnrCvptvmBA01YPITuQIw/UbSuMQl9GHbob8x6i0hsdf9wu/y5+
 4b/kWTVPcejsaRpwmU32GjZqGgUZEwMolUF4PvT/Ya6yi4MGskjuhKDMl
 qCxIBWh3DUqKN1Xbz342ibAwBrPF5k+TeYy9zSftAgFQMCJFz54o/7F4A
 BhQUz3o74CWAg6/yz/vrgOgcslkVVBwFi4Cnb4slAR+mv4PwJQk9dRkJn Q==;
X-CSE-ConnectionGUID: bG0/cgxdQYC+fKXnh5gHGQ==
X-CSE-MsgGUID: yZNI9GlwQ7SpwExYa2MPKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98810525"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="98810525"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:37 -0700
X-CSE-ConnectionGUID: /b9mYsOWRxuoA3v5QFENuQ==
X-CSE-MsgGUID: 5WeGfA5YQCmR0mHpzQm2aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="282602389"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:35 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com
Subject: [RFC v3 5/7] drm/xe/vm: Disable madvise notifier on GPU touch
Date: Thu,  4 Jun 2026 15:20:10 +0530
Message-ID: <20260604095012.367231-6-arvind.yadav@intel.com>
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

MADVISE_AUTORESET notifiers are only needed while the VMA is
CPU-only. After the first GPU fault, later unmaps follow the
normal SVM path.

Add an active flag so GPU-touched VMAs stop queueing autoreset
work. Broader notifiers from split VMAs may still remain active,
but the worker rechecks cpu_autoreset_active under vm->lock
before resetting attrs.

v2:
  - Use plain bool active; callback reads it lockless. (Matt)
  - Use wq check and mt_for_each in deactivate path. (Matt)
  - Add lockdep_assert_held_write(&vm->lock) to xe_vm_madvise_gpu_touch().

v3:
  - Deactivate only exact-match notifiers to preserve split siblings.
  - Use READ_ONCE/WRITE_ONCE for notifier->active since the MMU notifier
    callback reads it locklessly.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_pagefault.c  |  5 +++-
 drivers/gpu/drm/xe/xe_svm.c        |  1 +
 drivers/gpu/drm/xe/xe_vm_madvise.c | 47 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_vm_madvise.h |  1 +
 drivers/gpu/drm/xe/xe_vm_types.h   |  7 +++++
 5 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index f64d3df08261..442a4fcad0c0 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -19,6 +19,7 @@
 #include "xe_svm.h"
 #include "xe_trace_bo.h"
 #include "xe_vm.h"
+#include "xe_vm_madvise.h"
 
 /**
  * DOC: Xe page faults
@@ -222,8 +223,10 @@ static int xe_pagefault_service(struct xe_pagefault *pf)
 
 		/* First successful GPU fault ends CPU-only state. */
 		if (vma && xe_vma_is_cpu_addr_mirror(vma) &&
-		    xe_vma_has_cpu_autoreset_active(vma))
+		    xe_vma_has_cpu_autoreset_active(vma)) {
 			xe_vma_gpu_touch(vma);
+			xe_vm_madvise_gpu_touch(vm, vma);
+		}
 	}
 	up_write(&vm->lock);
 	xe_vm_put(vm);
diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index e1651e70c8f0..b58857668d48 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -24,6 +24,7 @@
 #include "xe_vm.h"
 #include "xe_vm_types.h"
 #include "xe_vram_types.h"
+#include "xe_vm_madvise.h"
 
 /* Identifies subclasses of struct drm_pagemap_peer */
 #define XE_PEER_PAGEMAP ((void *)0ul)
diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.c b/drivers/gpu/drm/xe/xe_vm_madvise.c
index c2abe712598a..6c42ce8e3f52 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.c
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.c
@@ -948,7 +948,7 @@ static bool xe_madvise_notifier_callback(struct mmu_interval_notifier *mni,
 	struct xe_vm *vm = notifier->vm;
 	u64 adj_start, adj_end;
 
-	if (range->event != MMU_NOTIFY_UNMAP)
+	if (range->event != MMU_NOTIFY_UNMAP || !READ_ONCE(notifier->active))
 		return true;
 
 	if (!mmu_notifier_range_blockable(range))
@@ -1057,6 +1057,7 @@ xe_madvise_notifier_alloc(struct xe_vm *vm, u64 start, u64 end)
 	notifier->vma_start = start;
 	notifier->vma_end = end;
 	INIT_LIST_HEAD(&notifier->link);
+	WRITE_ONCE(notifier->active, true);
 	spin_lock_init(&notifier->work_lock);
 	notifier->work_pending = false;
 	INIT_WORK(&notifier->work, xe_madvise_work_func);
@@ -1186,6 +1187,7 @@ int xe_vm_madvise_register_notifier_range(struct xe_vm *vm, u64 start, u64 end)
 	/* Dedup by stored range; tree slots can be fragmented by partial overlap. */
 	list_for_each_entry(existing, &vm->svm.madvise_notifier_list, link) {
 		if (xe_madvise_notifier_exact(existing, start, end)) {
+			WRITE_ONCE(existing->active, true);
 			err = 0;
 			goto unlock_remove_new;
 		}
@@ -1236,3 +1238,46 @@ int xe_vm_madvise_register_notifier_range(struct xe_vm *vm, u64 start, u64 end)
 
 	return err;
 }
+
+/**
+ * xe_vm_deactivate_madvise_notifier_for_range - Disable callbacks for a VMA
+ * @vm: VM
+ * @start: VMA start
+ * @end: VMA end
+ */
+static void xe_vm_deactivate_madvise_notifier_for_range(struct xe_vm *vm, u64 start, u64 end)
+{
+	struct xe_madvise_notifier *notifier;
+	unsigned long index = start;
+
+	lockdep_assert_held_write(&vm->lock);
+
+	if (!vm->svm.madvise_work.wq)
+		return;
+
+	/*
+	 * Only exact-match notifiers are disabled. Broader notifiers may still
+	 * cover CPU-only split siblings.
+	 */
+	mt_for_each(&vm->svm.madvise_notifiers, notifier, index, end - 1)
+		if (notifier->vma_start == start && notifier->vma_end == end)
+			WRITE_ONCE(notifier->active, false);
+}
+
+/**
+ * xe_vm_madvise_gpu_touch - Disable madvise notifier after GPU touch
+ * @vm: VM
+ * @vma: GPU-touched VMA
+ */
+void xe_vm_madvise_gpu_touch(struct xe_vm *vm, struct xe_vma *vma)
+{
+	lockdep_assert_held_write(&vm->lock);
+
+	/* Only AUTORESET VMAs have madvise notifiers. */
+	if (!(vma->gpuva.flags & XE_VMA_MADV_AUTORESET))
+		return;
+
+	xe_vm_deactivate_madvise_notifier_for_range(vm,
+						xe_vma_start(vma),
+						xe_vma_end(vma));
+}
diff --git a/drivers/gpu/drm/xe/xe_vm_madvise.h b/drivers/gpu/drm/xe/xe_vm_madvise.h
index e2013605e190..d7ea6ff6b0c5 100644
--- a/drivers/gpu/drm/xe/xe_vm_madvise.h
+++ b/drivers/gpu/drm/xe/xe_vm_madvise.h
@@ -20,5 +20,6 @@ int xe_vm_madvise_ioctl(struct drm_device *dev, void *data,
 int xe_vm_madvise_init(struct xe_vm *vm);
 void xe_vm_madvise_fini(struct xe_vm *vm);
 int xe_vm_madvise_register_notifier_range(struct xe_vm *vm, u64 start, u64 end);
+void xe_vm_madvise_gpu_touch(struct xe_vm *vm, struct xe_vma *vma);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_vm_types.h b/drivers/gpu/drm/xe/xe_vm_types.h
index d47bc338628d..4cb3fd619acf 100644
--- a/drivers/gpu/drm/xe/xe_vm_types.h
+++ b/drivers/gpu/drm/xe/xe_vm_types.h
@@ -50,6 +50,13 @@ struct xe_madvise_notifier {
 	u64 vma_end;
 	/** @link: Entry on vm->svm.madvise_notifier_list. */
 	struct list_head link;
+	/**
+	 * @active: Fast-path callback gate.
+	 *
+	 * Read locklessly by the MMU notifier callback. The worker still checks
+	 * cpu_autoreset_active under vm->lock before resetting attrs.
+	 */
+	bool active;
 	/** @work_lock: Serialises pending interval state. */
 	spinlock_t work_lock;
 	/** @work_pending: Pending interval is available for the worker. */
-- 
2.43.0

