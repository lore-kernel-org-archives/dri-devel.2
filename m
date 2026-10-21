Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E83606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g+QxOL+u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC7610FD3D;
	Wed, 21 Oct 2026 10:04:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD6710FD2D;
 Wed, 21 Oct 2026 10:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792577036; x=1824113036;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/knIfiMjLaGfibHLqNAXPobTBZtECfzhW860bNULUjo=;
 b=g+QxOL+udOxp4y/5WY1HGusdjCKTntt4FphPjHHpOalz482X+ikhqIEu
 1Az9BmSLh1bXK2PQbg+bIH7kz0YJ1IlKoUlG1sXRct+w8/yHrPGY2crWJ
 inETLnkLXk5iqwApO4XrFGpB2j5+TaQu3xHheXMuZBqYghlbEmOISInEj
 nbqQDL7YNiwGbDg7GjEmEy/Ffzb7siufF3VXpPkbR6eS5LhHp7HcpiAg/
 MgQKY6OE4hTyTY6oMiD9dgrBjOQtbB5qBAEFD7FJmUjiJZl1L0kI29LRN
 6n7cgCSHJ64XVS38aOYOiioAY9hCWoHKcEhBifGnsx8wpb7pZiZ87awrq g==;
X-CSE-ConnectionGUID: 1OPaaV4lS2m8ks/vlM29pg==
X-CSE-MsgGUID: r2V2Gf0TR/SXY+D4cpFAFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1290291"
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="1290291"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:56 -0700
X-CSE-ConnectionGUID: jilK+7BjQG+lIAKFOdFkYg==
X-CSE-MsgGUID: MS3YvztsQXW4w7iQcNVmUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,169,1787036400"; 
   d="scan'208";a="3382087"
Received: from varungup-desk.iind.intel.com ([10.190.238.71])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 03:03:53 -0700
From: Arvind Yadav <arvind.yadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: matthew.brost@intel.com, himal.prasad.ghimiray@intel.com,
 thomas.hellstrom@linux.intel.com, rodrigo.vivi@intel.com
Subject: [RFC v3 07/17] drm/xe/ggtt: Stop GGTT removal MMIO during wedge and
 AER
Date: Wed, 21 Oct 2026 15:33:08 +0530
Message-ID: <20261021100322.1014449-8-arvind.yadav@intel.com>
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

GGTT node removal can clear entries and invalidate TLBs after wedge
isolation or after AER disables the PCI device.

Check the wedge state inside drm_dev_enter()/drm_dev_exit() so isolation
can drain hardware cleanup admitted before the wedge. Software node
removal and drm_mm bookkeeping still run when hardware access is skipped.

For AER, take the old GGTT offline under ggtt->lock before draining
readers and disabling PCI. Node removal checks the online state under
the same lock, so later removals skip hardware access. Re-probe creates
a new online GGTT and preserves cleanup on the recovered instance.

v3:
 - Take the old GGTT offline before AER drains readers and disables PCI.
 - Preserve GGTT cleanup on the recovered instance.

Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
---
 drivers/gpu/drm/xe/xe_ggtt.c      | 43 ++++++++++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_ggtt.h      |  1 +
 drivers/gpu/drm/xe/xe_pci_error.c |  8 ++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_ggtt.c b/drivers/gpu/drm/xe/xe_ggtt.c
index 773777afc68a..6fec8a90e4cf 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.c
+++ b/drivers/gpu/drm/xe/xe_ggtt.c
@@ -20,6 +20,7 @@
 #include "regs/xe_regs.h"
 #include "xe_assert.h"
 #include "xe_bo.h"
+#include "xe_device.h"
 #include "xe_gt.h"
 #include "xe_gt_printk.h"
 #include "xe_gt_types.h"
@@ -370,12 +371,25 @@ int xe_ggtt_init_kunit(struct xe_ggtt *ggtt, u32 start, u32 size)
 }
 EXPORT_SYMBOL_IF_KUNIT(xe_ggtt_init_kunit);
 
+/**
+ * xe_ggtt_offline - Stop hardware access from GGTT node removal
+ * @ggtt: the &xe_ggtt to take offline
+ *
+ * Node removal keeps clearing entries and invalidating TLBs while the GGTT
+ * is online. Take it offline before disabling PCI access, and drain the DRM
+ * device SRCU afterwards so users already admitted finish first.
+ */
+void xe_ggtt_offline(struct xe_ggtt *ggtt)
+{
+	guard(mutex)(&ggtt->lock);
+	ggtt->flags &= ~XE_GGTT_FLAGS_ONLINE;
+}
+
 static void dev_fini_ggtt(void *arg)
 {
 	struct xe_ggtt *ggtt = arg;
 
-	scoped_guard(mutex, &ggtt->lock)
-		ggtt->flags &= ~XE_GGTT_FLAGS_ONLINE;
+	xe_ggtt_offline(ggtt);
 	drain_workqueue(ggtt->wq);
 }
 
@@ -475,13 +489,13 @@ static void ggtt_node_fini(struct xe_ggtt_node *node)
 	kfree(node);
 }
 
-static void ggtt_node_remove(struct xe_ggtt_node *node)
+static void __ggtt_node_remove(struct xe_ggtt_node *node, bool clear_hw)
 {
 	struct xe_ggtt *ggtt = node->ggtt;
 	bool bound;
 
 	mutex_lock(&ggtt->lock);
-	bound = ggtt->flags & XE_GGTT_FLAGS_ONLINE;
+	bound = clear_hw && (ggtt->flags & XE_GGTT_FLAGS_ONLINE);
 	if (bound)
 		xe_ggtt_clear(ggtt, xe_ggtt_node_addr(node), xe_ggtt_node_size(node));
 	drm_mm_remove_node(&node->base);
@@ -496,6 +510,27 @@ static void ggtt_node_remove(struct xe_ggtt_node *node)
 	ggtt_node_fini(node);
 }
 
+static void ggtt_node_remove(struct xe_ggtt_node *node)
+{
+	struct xe_device *xe = tile_to_xe(node->ggtt->tile);
+	int idx;
+
+	/*
+	 * GGTT updates write page table entries through the BAR and request a
+	 * TLB invalidation. Skip them after unplug, where the BAR is gone.
+	 * Keep them during PCI error recovery so a recovered device does not
+	 * inherit stale GGTT entries.
+	 */
+	if (!drm_dev_enter(&xe->drm, &idx)) {
+		__ggtt_node_remove(node, false);
+		return;
+	}
+
+	__ggtt_node_remove(node, !xe_device_wedged(xe));
+
+	drm_dev_exit(idx);
+}
+
 static void ggtt_node_remove_work_func(struct work_struct *work)
 {
 	struct xe_ggtt_node *node = container_of(work, typeof(*node),
diff --git a/drivers/gpu/drm/xe/xe_ggtt.h b/drivers/gpu/drm/xe/xe_ggtt.h
index c864cc975a69..48db1a8fc58d 100644
--- a/drivers/gpu/drm/xe/xe_ggtt.h
+++ b/drivers/gpu/drm/xe/xe_ggtt.h
@@ -17,6 +17,7 @@ struct xe_ggtt *xe_ggtt_alloc(struct xe_tile *tile);
 int xe_ggtt_init_early(struct xe_ggtt *ggtt);
 int xe_ggtt_init_kunit(struct xe_ggtt *ggtt, u32 reserved, u32 size);
 int xe_ggtt_init(struct xe_ggtt *ggtt);
+void xe_ggtt_offline(struct xe_ggtt *ggtt);
 
 void xe_ggtt_shift_nodes(struct xe_ggtt *ggtt, u64 new_base);
 u64 xe_ggtt_start(struct xe_ggtt *ggtt);
diff --git a/drivers/gpu/drm/xe/xe_pci_error.c b/drivers/gpu/drm/xe/xe_pci_error.c
index 3dfcef03850e..6606e2457503 100644
--- a/drivers/gpu/drm/xe/xe_pci_error.c
+++ b/drivers/gpu/drm/xe/xe_pci_error.c
@@ -6,17 +6,20 @@
 #include <linux/pci.h>
 
 #include "xe_device.h"
+#include "xe_ggtt.h"
 #include "xe_gt.h"
 #include "xe_log.h"
 #include "xe_pci.h"
 #include "xe_printk.h"
 #include "xe_ras.h"
 #include "xe_survivability_mode.h"
+#include "xe_tile.h"
 
 static void prepare_device_for_reset(struct pci_dev *pdev)
 {
 	struct xe_device *xe = pdev_to_xe_device(pdev);
 	struct xe_gt *gt;
+	struct xe_tile *tile;
 	u8 id;
 
 	/* Block device access until PCI error recovery completes. */
@@ -26,6 +29,11 @@ static void prepare_device_for_reset(struct pci_dev *pdev)
 	for_each_gt(gt, xe, id)
 		xe_gt_declare_wedged(gt);
 
+	/* Stop GGTT removal MMIO before draining users and disabling PCI. */
+	for_each_tile(tile, xe, id)
+		if (tile->mem.ggtt)
+			xe_ggtt_offline(tile->mem.ggtt);
+
 	/*
 	 * GT wedging signals pending fences. Existing hardware users can now
 	 * finish without blocking reset.
-- 
2.43.0

