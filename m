Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C96606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mls7krgi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3450610FD3B;
	Wed, 21 Oct 2026 10:04:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 431E710FD30;
 Wed, 21 Oct 2026 10:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577045; x=1824113045;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0fJCh4Ab/cn4ahSh4qVUflUO+q8GywtkV0BOP68v880=;
 b=mls7krgikNUL09+STEEXHj+wL7rAzDMRO3NbozTxBjT0YKZhdX9Pd1DN
 B71sA+vDsPhf8b7O6aW5sdEjaTKZvSkVz2Eu4Ou9RckZzu8LqILHmqxHb
 dGOUwhoZ2e6bKSd5OpeSfH7666nE56qzrsPa4vIEcurp0gVw3QokWJRf5
 H9KjStwaRdLEXNPpnCs7LLMEH497po7RnhBYTca1+vmOYD1OWC2KpTXIM
 1wSMiQGUe1IfC08VOhXzpEYvA+5xSYK6a4Q+9cuKCtOQIwvecMW9DsHTe
 z+4JXZ/MEcecAUVER9NYix+Ni2a3ZvBm8bCRCtwNWXsK3YpckmviMyqPo Q==;
X-CSE-ConnectionGUID: X6shQDq6TamiEa52YczWaQ==
X-CSE-MsgGUID: SKKb7OpAQHaObVzzAv7N3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290314"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290314"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:05 -0700
X-CSE-ConnectionGUID: 02D1RCFSSPO/o4uyBWoGLQ==
X-CSE-MsgGUID: 280yrZYeRFyePieZYB7zpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382126"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:04:03 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 11/17] drm/xe: Invalidate VRAM CPU mappings on wedge and PCI
 reset
Date: Wed, 21 Oct 2026 15:33:12 +0530
Message-ID: <20261021100322.1014449-12-arvind.yadav@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

CPU mappings created before a device wedge can keep valid PTEs and
continue accessing VRAM. Mapping new faults to a dummy page does not
replace these existing mappings.

Use the common device I/O SRCU gate to wait for active CPU faults to
finish. Then invalidate all tracked VRAM mappings. Faults starting
after the wedge use the per-BO dummy page.

This ensures userspace is notified only after existing VRAM mappings
have been removed.

Also invalidate existing VRAM CPU mappings during PCI error recovery.
After setting in_reset and draining active faults, remove the mappings
before disabling PCI. Later faults use the dummy page because device
I/O is blocked.

v2:
- Drain active faults before invalidating VRAM mappings

v3:
- Use the common DRM device SRCU gate instead of a separate VRAM fault
  SRCU domain.
- Invalidate existing VRAM CPU mappings before PCI disable during AER.
  (Sashiko)

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c        | 20 ++++++++++++++++++++
 drivers/gpu/drm/xe/xe_bo.h        |  1 +
 drivers/gpu/drm/xe/xe_device.c    |  4 ++++
 drivers/gpu/drm/xe/xe_pci_error.c |  4 ++++
 4 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 6efcf3f5dda8..2b3c000b7f94 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -4235,6 +4235,26 @@ void xe_bo_runtime_pm_release_mmap_offset(struct xe_bo *bo)
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
index 77b3a02e9b8e..3bd19866819c 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -453,6 +453,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, void *data,
 int xe_gem_mmap_offset_ioctl(struct drm_device *dev, void *data,
 			     struct drm_file *file);
 void xe_bo_runtime_pm_release_mmap_offset(struct xe_bo *bo);
+void xe_bo_wedged_invalidate_mmaps(struct xe_device *xe);
 
 int xe_bo_dumb_create(struct drm_file *file_priv,
 		      struct drm_device *dev,
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 4d4139fa1be4..fa025da253d5 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -936,6 +936,10 @@ static void xe_device_wedged_work(struct work_struct *work)
 	unsigned long method;
 	int err;
 
+	/* Drain active faults before invalidating VRAM mappings. */
+	xe_device_io_drain(xe);
+	xe_bo_wedged_invalidate_mmaps(xe);
+
 	/* Report at most one recovery method per worker invocation. */
 	method = READ_ONCE(xe->wedged.method);
 	if (method != READ_ONCE(xe->wedged.reported_method)) {
diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pci_error.c
index 6606e2457503..ea55ce8114fa 100644
--- a/drivers/gpu/drm/xe/xe_pci_error.c
+++ b/drivers/gpu/drm/xe/xe_pci_error.c
@@ -5,6 +5,7 @@
 
 #include <linux/pci.h>
 
+#include "xe_bo.h"
 #include "xe_device.h"
 #include "xe_ggtt.h"
 #include "xe_gt.h"
@@ -40,6 +41,9 @@ static void prepare_device_for_reset(struct pci_dev *pdev)
 	 */
 	xe_device_io_drain(xe);
 
+	/* Remove existing VRAM CPU mappings before disabling PCI. */
+	xe_bo_wedged_invalidate_mmaps(xe);
+
 	pci_disable_device(pdev);
 }
 
-- 
2.43.0

