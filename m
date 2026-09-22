Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB343C982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 10:17:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C1610EC3B;
	Tue, 22 Sep 2026 10:17:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="THyd2cQa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 978F210EC37;
 Tue, 22 Sep 2026 10:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790072274; x=1821608274;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RF/x3uPTaPksudetQkGU5H9b+hPj7CcmI7poMoN/Md4=;
 b=THyd2cQa/IXF87HgJSQGE94CSRz98f/twem1fp3qqajGm4PcN+z5/t4h
 3byjZNUk8vQeh64r6MRVjqGYL5JP4U9F0oNc4Zf4wy6vdmJtSdnO39ipk
 I/cIJNlXisITUrAjfh547W0QMUAaUcWkqDk+8mr4e3W9rjDGV+kdTOM0r
 uPS+W4PcninxeCFnDF8WSGTAbPIFlqSkdBf6Ekqjm7VPGWBK5mysFQ1El
 QUO8QyuiztK+Xluq5S7a/MsVOGAMI1n2dnnzHabdCOi7lil7+hhjIWWnt
 KpoZuYg3PQLpcFN6JwdDybuiNuE8KI8rrtR8v3hfEYyfq9gtTxzbM5J6X w==;
X-CSE-ConnectionGUID: Qqh6iXtBSqO+6vmyDKnL3A==
X-CSE-MsgGUID: CDE+zksmRee8bxbsTIbY0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="101322823"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="101322823"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:54 -0700
X-CSE-ConnectionGUID: DaH6KAQuSkOBDt+yh8ZeXQ==
X-CSE-MsgGUID: X5BtTduOTzuGja3LHwTgiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; d="scan'208";a="299307882"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2026 03:17:52 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [PATCH v2 09/15] drm/xe: Invalidate existing VRAM mappings on wedge
Date: Tue, 22 Sep 2026 15:46:54 +0530
Message-ID: <20260922101721.1583542-10-arvind.yadav@intel.com>
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

CPU mappings created before a device wedge can keep valid PTEs and
continue accessing VRAM. Mapping new faults to a dummy page does not
replace these existing mappings.

Use the common device I/O SRCU gate to wait for active CPU faults to
finish. Then invalidate all tracked VRAM mappings. Faults starting
after the wedge use the per-BO dummy page.

This ensures userspace is notified only after existing VRAM mappings
have been removed.

v2:
- Drain active faults before invalidating VRAM mappings

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c     | 20 ++++++++++++++++++++
 drivers/gpu/drm/xe/xe_bo.h     |  1 +
 drivers/gpu/drm/xe/xe_device.c |  4 ++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 7902ce3fe012..73dcd397dc13 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -4155,6 +4155,26 @@ void xe_bo_runtime_pm_release_mmap_offset(struct xe_bo *bo)
 	list_del_init(&bo->vram_userfault_link);
 }
 
+/**
+ * xe_bo_wedged_invalidate_mmaps - Invalidate CPU mappings backed by VRAM
+ * @xe: xe device instance
+ *
+ * The caller must drain the common device I/O gate before calling this
+ * function. Remove all tracked VRAM mappings so later faults map the
+ * per-BO dummy page.
+ */
+void xe_bo_wedged_invalidate_mmaps(struct xe_device *xe)
+{
+	struct xe_bo *bo, *next;
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
index 290ca624e2a7..103eaacb56f2 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -449,6 +449,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 int xe_gem_mmap_offset_ioctl(struct drm_device *dev, void *data,
 			     struct drm_file *file);
 void xe_bo_runtime_pm_release_mmap_offset(struct xe_bo *bo);
+void xe_bo_wedged_invalidate_mmaps(struct xe_device *xe);
 
 int xe_bo_dumb_create(struct drm_file *file_priv,
 		      struct drm_device *dev,
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 045b5844e5c3..3549cf89a353 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -896,6 +896,10 @@ static void xe_device_wedged_work(struct work_struct *work)
 	unsigned long method;
 	int err;
 
+	/* Drain active faults before invalidating VRAM mappings. */
+	xe_device_io_drain(xe);
+	xe_bo_wedged_invalidate_mmaps(xe);
+
 	/* Report at most one recovery method per worker invocation. */
 	method = READ_ONCE(xe->wedged.method);
 	if (method != READ_ONCE(xe->wedged.reported_method)) {
-- 
2.43.0

