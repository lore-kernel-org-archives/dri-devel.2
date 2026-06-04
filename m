Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1548CD6E68
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 09:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C8FE10E5FC;
	Thu,  4 Jun 2026 09:50:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PnyJ5uXQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C5EC112755;
 Thu,  4 Jun 2026 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780566642; x=1812102642;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2kxQsuJAGg34AMTlr4geEF0AHmggJJRghF/UtqI3zeM=;
 b=PnyJ5uXQQUiF5vJ2Kc1NDBlDR8z4C0qDIm1qcts0rV2EUb2ZP+jVHDcW
 KTTxcKbiU5+64LosIMHds/o+h1rJzeRcl5YbzVyqXUAvmM9NU7LnIOUo1
 WudPF3v3cI9xgu91jYsUGX8NQ/UAEnzQ8x6h3IAvO/Vm4dx9wVsUUvP4B
 QeXCRTL7Foac9IYxqeh4NGqK7631hi3kAiU62He6QikSecxPsHqhwCfko
 s2/kEjlwcPHiyxzskgtmA0Gc8OoAcJHIdwGffogozzTvNueELTMdndYSn
 K77n/ckXoh0rpeYODe+G1onFqGdpz21jRnOuoMedCrysbFMBYx23LIc9D g==;
X-CSE-ConnectionGUID: /CZckNrlS6OUBT1sPyhlFA==
X-CSE-MsgGUID: UDcOdWcqTfaKxPDcOz7gQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="98810528"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="98810528"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:41 -0700
X-CSE-ConnectionGUID: liH5yW9WTgGMS9DlEsu4tA==
X-CSE-MsgGUID: vmY/6emQSUq+vQvNdKN8Zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="282602416"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 02:50:39 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com
Subject: [RFC v3 7/7] drm/xe/svm: Correct memory attribute reset for partial
 unmap
Date: Thu,  4 Jun 2026 15:20:12 +0530
Message-ID: <20260604095012.367231-8-arvind.yadav@intel.com>
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

From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>

When performing a partial unmap of an SVM range, the memory attributes
were being reset for the entire range instead of just the portion
being unmapped. This could lead to unintended side effects and behaviour.

Fix this by restricting the attribute reset to only the affected subrange
that is being unmapped.

v3:
  - Coalesce partial_unmap range via min/max instead of blind overwrite (Matt)
  - Restore range_debug() in xe_svm_garbage_collector_add_range() (Matt)
  - Update partial_unmap under garbage_collector.lock to avoid races with
    the worker.
  - Clear consumed partial_unmap state before dropping the GC lock.
  - Continue processing remaining queued ranges on non-fatal set_default_attr
    failure instead of stranding them.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_svm.c | 87 ++++++++++++++++++++++++++++++-------
 drivers/gpu/drm/xe/xe_svm.h | 10 +++++
 2 files changed, 82 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
index 4169cfae7b51..beabae3db2dc 100644
--- a/drivers/gpu/drm/xe/xe_svm.c
+++ b/drivers/gpu/drm/xe/xe_svm.c
@@ -58,6 +58,8 @@ void *xe_svm_private_page_owner(struct xe_vm *vm, bool force_smem)
 	return force_smem ? NULL : vm->svm.peer.owner;
 }
 
+#define XE_SVM_ATTR_RETRY_MAX 3
+
 static bool xe_svm_range_in_vram(struct xe_svm_range *range)
 {
 	/*
@@ -127,6 +129,34 @@ static void xe_svm_range_free(struct drm_gpusvm_range *range)
 	kfree(range);
 }
 
+static void xe_svm_range_set_unmapped(struct xe_svm_range *range,
+				      const struct mmu_notifier_range *mmu_range)
+{
+	u64 new_start = max_t(u64, xe_svm_range_start(range), mmu_range->start);
+	u64 new_end = min_t(u64, xe_svm_range_end(range), mmu_range->end);
+
+	drm_gpusvm_range_set_unmapped(&range->base, mmu_range);
+	if (range->base.pages.flags.partial_unmap) {
+		if (range->partial_unmap.start || range->partial_unmap.end) {
+			/*
+			 * Coalesce overlapping or adjacent intervals.
+			 * Disjoint ranges cannot be tracked in one interval
+			 * without covering still-mapped memory.
+			 */
+			if (new_start <= range->partial_unmap.end &&
+			    new_end >= range->partial_unmap.start) {
+				range->partial_unmap.start =
+					min(range->partial_unmap.start, new_start);
+				range->partial_unmap.end =
+					max(range->partial_unmap.end, new_end);
+			}
+		} else {
+			range->partial_unmap.start = new_start;
+			range->partial_unmap.end = new_end;
+		}
+	}
+}
+
 static void
 xe_svm_garbage_collector_add_range(struct xe_vm *vm, struct xe_svm_range *range,
 				   const struct mmu_notifier_range *mmu_range)
@@ -135,12 +165,14 @@ xe_svm_garbage_collector_add_range(struct xe_vm *vm, struct xe_svm_range *range,
 
 	range_debug(range, "GARBAGE COLLECTOR ADD");
 
-	drm_gpusvm_range_set_unmapped(&range->base, mmu_range);
-
 	spin_lock(&vm->svm.garbage_collector.lock);
+
+	xe_svm_range_set_unmapped(range, mmu_range);
+
 	if (list_empty(&range->garbage_collector_link))
 		list_add_tail(&range->garbage_collector_link,
 			      &vm->svm.garbage_collector.range_list);
+
 	spin_unlock(&vm->svm.garbage_collector.lock);
 
 	queue_work(xe->usm.pf_wq, &vm->svm.garbage_collector.work);
@@ -380,9 +412,10 @@ static int xe_svm_range_set_default_attr(struct xe_vm *vm, u64 start, u64 end)
 static int xe_svm_garbage_collector(struct xe_vm *vm)
 {
 	struct xe_svm_range *range;
-	u64 range_start;
-	u64 range_end;
-	int err, ret = 0;
+	u64 unmap_start;
+	u64 unmap_end;
+	int err;
+	int retry_count;
 
 	lockdep_assert_held_write(&vm->lock);
 
@@ -397,8 +430,18 @@ static int xe_svm_garbage_collector(struct xe_vm *vm)
 		if (!range)
 			break;
 
-		range_start = xe_svm_range_start(range);
-		range_end = xe_svm_range_end(range);
+		if (range->base.pages.flags.partial_unmap &&
+		    range->partial_unmap.start && range->partial_unmap.end) {
+			unmap_start = range->partial_unmap.start;
+			unmap_end = range->partial_unmap.end;
+		} else {
+			unmap_start = xe_svm_range_start(range);
+			unmap_end = xe_svm_range_end(range);
+		}
+
+		/* Clear consumed state before dropping lock. */
+		range->partial_unmap.start = 0;
+		range->partial_unmap.end = 0;
 
 		list_del(&range->garbage_collector_link);
 		spin_unlock(&vm->svm.garbage_collector.lock);
@@ -412,17 +455,31 @@ static int xe_svm_garbage_collector(struct xe_vm *vm)
 			return err;
 		}
 
-		err = xe_svm_range_set_default_attr(vm, range_start, range_end);
-		if (err) {
-			if (err == -EAGAIN)
-				ret = -EAGAIN;
-			else
-				return err;
-		}
+		/*
+		 * Retry if the VMA was recreated while rebuilding attrs.
+		 * Repeated failures mean the topology is not converging.
+		 */
+		retry_count = 0;
+
+		do {
+			err = xe_svm_range_set_default_attr(vm, unmap_start, unmap_end);
+			if (err == -EAGAIN && ++retry_count > XE_SVM_ATTR_RETRY_MAX) {
+				drm_err(&vm->xe->drm,
+					"SET_ATTR retry limit exceeded for [0x%llx-0x%llx]\n",
+					unmap_start, unmap_end);
+				xe_vm_kill(vm, true);
+				return -EIO;
+			}
+		} while (err == -EAGAIN);
+
+		if (err)
+			drm_warn(&vm->xe->drm,
+				 "SET_ATTR failed for [0x%llx-0x%llx]: %pe\n",
+				 unmap_start, unmap_end, ERR_PTR(err));
 	}
 	spin_unlock(&vm->svm.garbage_collector.lock);
 
-	return ret;
+	return 0;
 }
 
 static void xe_svm_garbage_collector_work_func(struct work_struct *w)
diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
index b7b8eeacf196..4651e044cf53 100644
--- a/drivers/gpu/drm/xe/xe_svm.h
+++ b/drivers/gpu/drm/xe/xe_svm.h
@@ -46,6 +46,16 @@ struct xe_svm_range {
 	 * range. Protected by GPU SVM notifier lock.
 	 */
 	u8 tile_invalidated;
+	/**
+	 * @partial_unmap: Structure to hold partial unmap range info.
+	 * Valid only if partial unmap is in effect.
+	 */
+	struct {
+		/** @start: Start address of the partial unmap range */
+		u64 start;
+		/** @end: End address of the partial unmap range */
+		u64 end;
+	} partial_unmap;
 };
 
 /**
-- 
2.43.0

