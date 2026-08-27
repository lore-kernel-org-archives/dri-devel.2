Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEDDC61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:18:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1398610E64B;
	Thu, 27 Aug 2026 10:18:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ldNzna5n";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07AC710E3DC;
 Thu, 27 Aug 2026 10:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787825924; x=1819361924;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6gd8PgoogoXX2qDPRJqbTKyoAQQEQIVZcu2fjMW1L0g=;
 b=ldNzna5nFrelxzJLJ5foprpmK28Z+B5uJlkV/R32YYePLFLPsUzjIxBX
 l3cPFYh7BUP9K822KPCMG2GIUvNFxKfvQO7k5w/1er6MPznXDO+gpVTW4
 uLkd6W4yrylAwOSD3+ySax+jRZsPBiui4Hke+n5b2ypCTa9//xTEpBAmk
 kBTK3Ivs8EmcN96uA4xFc6OXXJ4K9+GOSldFY0qoVTwOHud5QGET688ps
 dfry5jzF7cXBQxAhDmpRzExIi2yZlmIkQ0qN+TNa0gNOYrwtXuuoPCxj4
 tTFfu9Bb8VCnYymb+YYe69xdPQRFykxTskf9C05uf2ii/Ir6G8xNg/nos g==;
X-CSE-ConnectionGUID: k4F9gc1VSMKJhvt+kgyaYw==
X-CSE-MsgGUID: cpDjCoyLRC6mO2jKc9vgtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88445869"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88445869"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:43 -0700
X-CSE-ConnectionGUID: 6X58Zfe8RK+d9dKHSC1bFQ==
X-CSE-MsgGUID: vyVXpayOQWm7r5doGwzk0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="306057636"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 03:18:42 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH 07/13] drm/xe: Invalidate existing VRAM mappings on wedge
Date: Thu, 27 Aug 2026 15:47:55 +0530
Message-ID: <20260827101801.1247654-8-arvind.yadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827101801.1247654-1-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
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

CPU mappings created before a device wedge may keep valid PTEs and
continue accessing VRAM. Redirecting new faults to a dummy page does not
protect these existing mappings.

Use SRCU to synchronize CPU faults with wedge handling. The wedge worker
waits for in-flight faults and then invalidates all tracked VRAM
mappings. Faults starting after the wedge use the BO's dummy page.

SRCU allows the fault path to sleep during TTM fault handling. Notify
userspace only after the existing mappings have been invalidated.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c           | 30 +++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_bo.h           |  1 +
 drivers/gpu/drm/xe/xe_device.c       |  3 +++
 drivers/gpu/drm/xe/xe_device_types.h |  7 +++++++
 drivers/gpu/drm/xe/xe_pm.c           | 17 ++++++++++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 1f6ea9f5afe6..1eabece56f6c 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -2140,9 +2140,14 @@ static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 	vm_fault_t ret;
 	int err = 0;
 	int idx;
+	int srcu_idx;
 
-	if (xe_device_io_blocked(xe) || !drm_dev_enter(&xe->drm, &idx))
+	srcu_idx = srcu_read_lock(&xe->mem_access.vram_userfault.srcu);
+	if (xe_device_io_blocked(xe) || !drm_dev_enter(&xe->drm, &idx)) {
+		srcu_read_unlock(&xe->mem_access.vram_userfault.srcu,
+				 srcu_idx);
 		return xe_bo_vm_dummy_page(vmf, bo);
+	}
 
 	ret = xe_bo_cpu_fault_fastpath(vmf, xe, bo, needs_rpm);
 	if (ret != VM_FAULT_RETRY)
@@ -2229,6 +2234,7 @@ static vm_fault_t xe_bo_cpu_fault(struct vm_fault *vmf)
 		xe_bo_put(bo);
 out:
 	drm_dev_exit(idx);
+	srcu_read_unlock(&xe->mem_access.vram_userfault.srcu, srcu_idx);
 
 	return ret;
 }
@@ -4136,6 +4142,28 @@ void xe_bo_runtime_pm_release_mmap_offset(struct xe_bo *bo)
 	list_del_init(&bo->vram_userfault_link);
 }
 
+/**
+ * xe_bo_wedged_invalidate_mmaps - Invalidate CPU mappings backed by VRAM
+ * @xe: xe device instance
+ *
+ * Wait for faults which may have observed the device before it was wedged,
+ * then remove all tracked VRAM mappings. Faults which start after the wedge
+ * map the per-BO dummy page and do not join the tracking list.
+ */
+void xe_bo_wedged_invalidate_mmaps(struct xe_device *xe)
+{
+	struct xe_bo *bo, *next;
+
+	synchronize_srcu(&xe->mem_access.vram_userfault.srcu);
+
+	mutex_lock(&xe->mem_access.vram_userfault.lock);
+	list_for_each_entry_safe(bo, next,
+				 &xe->mem_access.vram_userfault.list,
+				 vram_userfault_link)
+		xe_bo_runtime_pm_release_mmap_offset(bo);
+	mutex_unlock(&xe->mem_access.vram_userfault.lock);
+}
+
 #if IS_ENABLED(CONFIG_DRM_XE_KUNIT_TEST)
 #include "tests/xe_bo.c"
 #endif
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index e8081af5bfc1..071870ec8289 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -450,6 +450,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 int xe_gem_mmap_offset_ioctl(struct drm_device *dev, void *data,
 			     struct drm_file *file);
 void xe_bo_runtime_pm_release_mmap_offset(struct xe_bo *bo);
+void xe_bo_wedged_invalidate_mmaps(struct xe_device *xe);
 
 int xe_bo_dumb_create(struct drm_file *file_priv,
 		      struct drm_device *dev,
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index ffbaf85eaab1..98ef5123c841 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -964,6 +964,9 @@ static void xe_device_wedged_work(struct work_struct *work)
 			container_of(work, struct xe_device, wedged.work);
 	unsigned long method;
 
+	/* Drain faults and invalidate existing VRAM mappings. */
+	xe_bo_wedged_invalidate_mmaps(xe);
+
 	/* Report at most one recovery method per worker invocation. */
 	method = READ_ONCE(xe->wedged.method);
 	if (method != READ_ONCE(xe->wedged.reported_method)) {
diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
index 382a2b470647..43a86564adf0 100644
--- a/drivers/gpu/drm/xe/xe_device_types.h
+++ b/drivers/gpu/drm/xe/xe_device_types.h
@@ -7,6 +7,7 @@
 #define _XE_DEVICE_TYPES_H_
 
 #include <linux/pci.h>
+#include <linux/srcu.h>
 
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
@@ -391,6 +392,12 @@ struct xe_device {
 		 * related stuff
 		 */
 		struct {
+			/**
+			 * @mem_access.vram_userfault.srcu: Serializes CPU faults
+			 * against wedge-time mapping invalidation
+			 */
+			struct srcu_struct srcu;
+
 			/**
 			 * @mem_access.vram_userfault.lock: Protects access to
 			 * @mem_access.vram_userfault.list Using mutex instead of spinlock
diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index f517bf453b54..720e083cd279 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -350,6 +350,13 @@ static void xe_pm_runtime_init(struct xe_device *xe)
 	pm_runtime_put(dev);
 }
 
+static void xe_vram_userfault_srcu_fini(struct drm_device *drm, void *arg)
+{
+	struct srcu_struct *srcu = arg;
+
+	cleanup_srcu_struct(srcu);
+}
+
 /**
  * xe_pm_init_early() - Initialize Xe Power Management
  * @xe: the &xe_device instance
@@ -372,6 +379,16 @@ int xe_pm_init_early(struct xe_device *xe)
 	if (err)
 		return err;
 
+	err = init_srcu_struct(&xe->mem_access.vram_userfault.srcu);
+	if (err)
+		return err;
+
+	err = drmm_add_action_or_reset(&xe->drm,
+				       xe_vram_userfault_srcu_fini,
+				       &xe->mem_access.vram_userfault.srcu);
+	if (err)
+		return err;
+
 	err = drmm_mutex_init(&xe->drm, &xe->d3cold.lock);
 	if (err)
 		return err;
-- 
2.43.0

