Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7FFCA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:07:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1767010F49C;
	Wed,  7 Oct 2026 08:07:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="cbJHnp+F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F269D10F49C;
 Wed,  7 Oct 2026 08:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791360438; x=1822896438;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=h3XeqzLQr2Dnh68LHZo4toKb9Q+xrSLzQiqXcIgpcn0=;
 b=cbJHnp+FNzqtPpm+BY4eeGtAsi5pCROF2pwJmiNrp+1DkCOJ0EuR2BLl
 RQ9UvpgHgmoVqQrToxojdEThMJV9ej90yN/bLo2y36cByhh2IqPm2Bvwg
 +lhrO7Xm6fr8URDJqWsy32pbsIRm6jpzOIGIFDIldD6CL4RLBOtPxAL7u
 U1P2PKNLWJw0bBapqLvZ4UKExkA1YQezfIR+DYoIh6yhHyFcYZtz4KjqH
 IqK8rvaYd1K6mSAMr6skSEul53xeEShQ5m+5pQcu0m5UFdRRwGXmMpw9a
 SmEpxhwEj6WOu2h2xptxGdw/5AOoZEmwBUd3oTG5RgWd/vLTNv5OgmV7l Q==;
X-CSE-ConnectionGUID: AKaz7QR3SqSn1tFxM6BilA==
X-CSE-MsgGUID: YObTddjmQR+Cf7S85GRfwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="108555"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="108555"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 01:07:17 -0700
X-CSE-ConnectionGUID: 10Sy+sIbQ6aw/SgeXn0k4w==
X-CSE-MsgGUID: UcxzR5lzQZakjOu3lsUCBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; d="scan'208";a="315405505"
Received: from aravind-dev.iind.intel.com ([10.190.239.36])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2026 01:07:12 -0700
From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, amd-gfx@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, airlied@gmail.com, tejas.upadhyay@intel.com,
 himal.prasad.ghimiray@intel.com, rodrigo.vivi@intel.com,
 riana.tauro@intel.com, raag.jadav@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 pratik.bari@intel.com, Hawking.Zhang@amd.com, tao.zhou1@amd.com,
 YiPeng.Chai@amd.com, jinzhou.su@amd.com, cesun102@amd.com,
 lijo.lazar@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Subject: [PATCH v2 2/2] drm/xe: Remove bad VRAM pages debugfs interface
Date: Wed,  7 Oct 2026 13:33:54 +0530
Message-Id: <20261007080354.3072751-3-aravind.iddamsetty@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
References: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
MIME-Version: 1.0
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

Drop the "vram_bad_pages" debugfs file added by commit fb19798cc366e
("drm/xe: Expose bad VRAM pages via debugfs"). The retired VRAM pages
are now exported through the drm-ras generic netlink interface, which
is a stable ABI, making the debugfs-only readback redundant.

This is a partial revert of fb19798cc366e: it removes vram_bad_pages_show(),
its DEFINE_SHOW_ATTRIBUTE(), xe_ttm_vram_debugfs_init() and its call site
and declaration, and the now-unused <linux/debugfs.h> include in
xe_ttm_vram_mgr.c. The struct xe_ttm_vram_mgr.max_pages field introduced
by the same commit is intentionally retained: it is the FW-provided
offline-page limit and is now consumed by the drm-ras retired-resources
capacity summary (xe_ttm_vram_get_max_bad_pages()).

The fault-injection debugfs interface (inject_mempage_offline) is left
untouched; it remains the mechanism for triggering page offlining in
test.

Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
Assisted-by: Copilot:claude-opus-4.8
---
 drivers/gpu/drm/xe/xe_debugfs.c      |  2 -
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c | 71 ----------------------------
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.h |  1 -
 3 files changed, 74 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 926020c7526e..6a19737104fb 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -823,8 +823,6 @@ void xe_debugfs_register(struct xe_device *xe)
 	if (man)
 		ttm_resource_manager_create_debugfs(man, root, "stolen_mm");
 
-	xe_ttm_vram_debugfs_init(xe, root);
-
 	for_each_tile(tile, xe, tile_id)
 		xe_tile_debugfs_register(tile);
 
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
index b56b543a56a2..9fbdf1dcde8a 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/cgroup_dmem.h>
-#include <linux/debugfs.h>
 
 #include <drm/drm_managed.h>
 #include <drm/drm_drv.h>
@@ -1120,73 +1119,3 @@ int xe_ttm_vram_inject_fault(struct xe_device *xe)
 	return -ENOSPC;
 }
 EXPORT_SYMBOL(xe_ttm_vram_inject_fault);
-
-static int vram_bad_pages_show(struct seq_file *m, void *unused)
-{
-	struct xe_device *xe = m->private;
-	struct xe_ttm_vram_offline_resource *pos;
-	struct ttm_resource_manager *man;
-	struct xe_ttm_vram_mgr *mgr;
-	struct xe_tile *tile;
-	u8 id;
-
-	man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0);
-	if (man)
-		/* TODO Hook with RAS to show max_pages fetched from FW */
-		seq_printf(m, "max_pages: %d\n",
-			   to_xe_ttm_vram_mgr(man)->max_pages);
-
-	for_each_tile(tile, xe, id) {
-		struct xe_vram_region *vr = tile->mem.vram;
-
-		man = ttm_manager_type(&xe->ttm, XE_PL_VRAM0 + id);
-		if (!man || !vr)
-			continue;
-		mgr = to_xe_ttm_vram_mgr(man);
-
-		rcu_read_lock();
-
-		list_for_each_entry_rcu(pos, &mgr->offlined_pages, offlined_link) {
-			u64 pfn;
-
-			pfn = (pos->addr + vr->dpa_base) >> PAGE_SHIFT;
-			seq_printf(m, "0x%016llx : 0x%016lx : R\n", pfn, PAGE_SIZE);
-		}
-
-		list_for_each_entry_rcu(pos, &mgr->queued_pages, queued_link) {
-			u64 pfn;
-
-			pfn = (pos->addr + vr->dpa_base) >> PAGE_SHIFT;
-			seq_printf(m, "0x%016llx : 0x%016lx : %c\n",
-				   pfn, PAGE_SIZE, pos->status ? 'F' : 'P');
-		}
-
-		rcu_read_unlock();
-	}
-
-	return 0;
-}
-DEFINE_SHOW_ATTRIBUTE(vram_bad_pages);
-
-/**
- * xe_ttm_vram_debugfs_init - Initialize VRAM debugfs interfaces
- * @xe: The xe device structure pointer
- * @root: The root dentry of the debugfs directory
- *
- * This function registers platform-specific VRAM debugfs files used for
- * testing and debugging. Currently, it exposes the "vram_bad_pages" interface
- * to inspect marked faulty memory pages, restricted specifically to the
- * %XE_CRESCENTISLAND platform.
- *
- * Return: Void.
- */
-void xe_ttm_vram_debugfs_init(struct xe_device *xe, struct dentry *root)
-{
-	/*
-	 * TODO: Replace platform check with xe->info
-	 * once the feature flag is plumbed through device info.
-	 */
-	if (xe->info.platform != XE_CRESCENTISLAND)
-		return;
-	debugfs_create_file("vram_bad_pages", 0444, root, xe, &vram_bad_pages_fops);
-}
diff --git a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
index 70fae023d6a3..7a4a041b8218 100644
--- a/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
+++ b/drivers/gpu/drm/xe/xe_ttm_vram_mgr.h
@@ -17,7 +17,6 @@ int __xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_ttm_vram_mgr *mgr,
 			   u32 mem_type, u64 size, u64 io_size,
 			   u64 default_page_size);
 int xe_ttm_vram_mgr_init(struct xe_device *xe, struct xe_vram_region *vram);
-void xe_ttm_vram_debugfs_init(struct xe_device *xe, struct dentry *root);
 int xe_ttm_vram_mgr_alloc_sgt(struct xe_device *xe,
 			      struct ttm_resource *res,
 			      u64 offset, u64 length,
-- 
2.25.1

