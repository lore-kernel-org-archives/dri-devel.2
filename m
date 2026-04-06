Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 502DAEF4ECD
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 11:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9636810E22A;
	Mon,  6 Apr 2026 11:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HaHPsqfm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 876E910E1DB;
 Mon,  6 Apr 2026 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775475928; x=1807011928;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hEOpPQH07n6Jlspt8pjwlDev0/dOobnLlkBe05pj2H0=;
 b=HaHPsqfm2czLoz0r8rz9I8WFvha7X7AXqEqKYnhZb/gw7orKlwKnrhPc
 l46drtTcTJTEX/iLlyKjEmdUs1EPOwPTSDeh9mroFAoK/+w5ChBndFnPA
 3clKT0rWykfm5k+XY1tJonF4Fweep09UwVYZS3wrP4jq89XButsEwjN2q
 fKab3x1L6s3Dy0d/RQ1E5GKKtGHgGktBakZCWPaC3NYjkuDGWfjy3mt2T
 J+HaA0B7KIcoO39WMXeFiS/2zqU+kk8s5XfJMP/WdgCW7bVsfUbTrkCaE
 1vigSaAVP+5iJVYXtTX4y5FYD4QTuhOMZR0dtbTwfzxiYmKmx+9VFXPQk w==;
X-CSE-ConnectionGUID: 1COAjWvjQG6vMb8JFHg9CA==
X-CSE-MsgGUID: B9ovX4EhRTGC9pnd9HfC9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="87047422"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="87047422"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 04:45:28 -0700
X-CSE-ConnectionGUID: kwYnbsm7Sn6AmkefENRnwQ==
X-CSE-MsgGUID: iqUkODDWRoC4QHU5Q+W4sw==
X-ExtLoop1: 1
Received: from gsd-build.iind.intel.com ([10.190.229.141])
 by fmviesa003.fm.intel.com with ESMTP; 06 Apr 2026 04:45:24 -0700
From: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 =?UTF-8?q?Piotr=20Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
 Dunajski Bartosz <bartosz.dunajski@intel.com>,
 Ashutosh Dixit <ashutosh.dixit@intel.com>, dri-devel@lists.freedesktop.org
Subject: [PATCH v9 1/3] drm/xe/pf: Restrict device query responses in
 admin-only PF mode
Date: Mon,  6 Apr 2026 11:45:17 +0000
Message-ID: <20260406114515.1043145-6-satyanarayana.k.v.p@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406114515.1043145-5-satyanarayana.k.v.p@intel.com>
References: <20260406114515.1043145-5-satyanarayana.k.v.p@intel.com>
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

When a PF is configured in admin-only mode, it is intended for management
only and must not expose workload-facing capabilities to userspace.

Limit the exposed ioctl set in admin-only PF mode to XE_DEVICE_QUERY and
XE_OBSERVATION, and suppress capability-bearing query payloads so that
the userspace cannot discover execution-related device details in this
mode.

Enable admin-only mode with:
echo <B:D:F> | sudo tee /sys/bus/pci/drivers/xe/unbind
sudo mkdir /sys/kernel/config/xe/<B:D:F>
echo yes | sudo tee /sys/kernel/config/xe/<B:D:F>/sriov/admin_only_pf
echo <B:D:F> | sudo tee /sys/bus/pci/drivers/xe/bind

Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Piotr Piórkowski <piotr.piorkowski@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Michał Winiarski <michal.winiarski@intel.com>
Cc: Dunajski Bartosz <bartosz.dunajski@intel.com>
Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: dri-devel@lists.freedesktop.org
Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>

---
V8 -> V9:
- Memory regions are skipped in case of admin_only_pf mode (Michal)
- removed .dumb_create, .dumb_map_offset and .show_fdinfo device specific
operations in admin-only mode (Michal).

V7 -> V8:
- Fixed issues reported by CI.Hooks
- Updated commit message (Ashutosh)
- Removed gem_prime_import from admin_only_driver structure (Michal)

V6 -> V7:
- Allowed xe_observation_ioctl as well with admin-only PF (Ashutosh,
Michal).
- Updated commit message with steps to enable admin-only mode (Rodrigo).

V5 -> V6:
- Updated commit message.
- Return number of engines and memory regions as zero instead of
returning query size as zero (Michal Wajdeczko).
- Allow all other query IOCTLs excepts query_engines and
query_mem_regions (Michal Wajdeczko).

V4 -> V5:
- Updated commit message (Matt B).
- Introduced new driver_admin_only_pf structure (Michal Wajdeczko).
- Updated all query configs (Michal Wajdeczko).
- Renamed xe_device_is_admin_only() to xe_device_is_admin_only_pf()
- Fixed other review comments (Michal Wajdeczko).

V3 -> V4:
- Suppressed device capabilities in admin-only PF mode. (Wajdeczko)

V2 -> V3:
- Introduced new helper function xe_debugfs_create_files() to create
debugfs entries based on admin_only_pf mode or normal mode.

V1 -> V2:
- Rebased to latest drm-tip.
- Update update_minor_dev() to debugfs_minor_dev().
---
 drivers/gpu/drm/xe/xe_device.c    | 55 ++++++++++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_device.h    |  1 +
 drivers/gpu/drm/xe/xe_hw_engine.c |  3 ++
 drivers/gpu/drm/xe/xe_query.c     |  8 ++++-
 4 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index cbce1d0ffe48..b70fa3af6d15 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -25,6 +25,7 @@
 #include "regs/xe_regs.h"
 #include "xe_bo.h"
 #include "xe_bo_evict.h"
+#include "xe_configfs.h"
 #include "xe_debugfs.h"
 #include "xe_defaults.h"
 #include "xe_devcoredump.h"
@@ -216,6 +217,11 @@ static const struct drm_ioctl_desc xe_ioctls[] = {
 			  DRM_RENDER_ALLOW),
 };
 
+static const struct drm_ioctl_desc xe_ioctls_admin_only[] = {
+	DRM_IOCTL_DEF_DRV(XE_DEVICE_QUERY, xe_query_ioctl, DRM_RENDER_ALLOW),
+	DRM_IOCTL_DEF_DRV(XE_OBSERVATION, xe_observation_ioctl, DRM_RENDER_ALLOW),
+};
+
 static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct drm_file *file_priv = file->private_data;
@@ -390,7 +396,7 @@ bool xe_is_xe_file(const struct file *file)
 	return file->f_op == &xe_driver_fops;
 }
 
-static struct drm_driver driver = {
+static struct drm_driver regular_driver = {
 	.driver_features =
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_SYNCOBJ |
@@ -415,6 +421,32 @@ static struct drm_driver driver = {
 	.patchlevel = DRIVER_PATCHLEVEL,
 };
 
+static struct drm_driver admin_only_driver = {
+	.driver_features =
+	    DRIVER_GEM | DRIVER_RENDER | DRIVER_GEM_GPUVA,
+	.open = xe_file_open,
+	.postclose = xe_file_close,
+	.ioctls = xe_ioctls_admin_only,
+	.num_ioctls = ARRAY_SIZE(xe_ioctls_admin_only),
+	.fops = &xe_driver_fops,
+	.name = DRIVER_NAME,
+	.desc = DRIVER_DESC,
+	.major = DRIVER_MAJOR,
+	.minor = DRIVER_MINOR,
+	.patchlevel = DRIVER_PATCHLEVEL,
+};
+
+/**
+ * xe_device_is_admin_only() - Check whether device is admin only or not.
+ * @xe: the &xe_device to check
+ *
+ * Return: true if the device is admin only, false otherwise.
+ */
+bool xe_device_is_admin_only(const struct xe_device *xe)
+{
+	return xe->drm.driver == &admin_only_driver;
+}
+
 static void xe_device_destroy(struct drm_device *dev, void *dummy)
 {
 	struct xe_device *xe = to_xe_device(dev);
@@ -439,16 +471,26 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
 struct xe_device *xe_device_create(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
+	struct drm_driver *driver = &regular_driver;
 	struct xe_device *xe;
 	int err;
 
-	xe_display_driver_set_hooks(&driver);
+#ifdef CONFIG_PCI_IOV
+	/*
+	 * Since XE device is not initialized yet, read from configfs
+	 * directly to decide whether we are in admin-only PF mode or not.
+	 */
+	if (xe_configfs_admin_only_pf(pdev))
+		driver = &admin_only_driver;
+#endif
+
+	xe_display_driver_set_hooks(driver);
 
-	err = aperture_remove_conflicting_pci_devices(pdev, driver.name);
+	err = aperture_remove_conflicting_pci_devices(pdev, driver->name);
 	if (err)
 		return ERR_PTR(err);
 
-	xe = devm_drm_dev_alloc(&pdev->dev, &driver, struct xe_device, drm);
+	xe = devm_drm_dev_alloc(&pdev->dev, driver, struct xe_device, drm);
 	if (IS_ERR(xe))
 		return xe;
 
@@ -708,6 +750,11 @@ int xe_device_probe_early(struct xe_device *xe)
 
 	xe_sriov_probe_early(xe);
 
+	if (xe_device_is_admin_only(xe) && !IS_SRIOV_PF(xe)) {
+		xe_err(xe, "Can't run Admin-only mode without SR-IOV PF mode!\n");
+		return -ENODEV;
+	}
+
 	if (IS_SRIOV_VF(xe))
 		vf_update_device_info(xe);
 
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index e4b9de8d8e95..c220f2f1352f 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -43,6 +43,7 @@ static inline struct xe_device *ttm_to_xe_device(struct ttm_device *ttm)
 	return container_of(ttm, struct xe_device, ttm);
 }
 
+bool xe_device_is_admin_only(const struct xe_device *xe);
 struct xe_device *xe_device_create(struct pci_dev *pdev,
 				   const struct pci_device_id *ent);
 int xe_device_probe_early(struct xe_device *xe);
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index 337baf0a6e87..2c324acb1dd0 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -1027,6 +1027,9 @@ bool xe_hw_engine_is_reserved(struct xe_hw_engine *hwe)
 	struct xe_gt *gt = hwe->gt;
 	struct xe_device *xe = gt_to_xe(gt);
 
+	if (xe_device_is_admin_only(xe))
+		return true;
+
 	if (hwe->class == XE_ENGINE_CLASS_OTHER)
 		return true;
 
diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index d84d6a422c45..0dc5a9bb481a 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -231,6 +231,9 @@ static size_t calc_mem_regions_size(struct xe_device *xe)
 	u32 num_managers = 1;
 	int i;
 
+	if (xe_device_is_admin_only(xe))
+		return sizeof(struct drm_xe_query_mem_regions);
+
 	for (i = XE_PL_VRAM0; i <= XE_PL_VRAM1; ++i)
 		if (ttm_manager_type(&xe->ttm, i))
 			num_managers++;
@@ -259,6 +262,9 @@ static int query_mem_regions(struct xe_device *xe,
 	if (XE_IOCTL_DBG(xe, !mem_regions))
 		return -ENOMEM;
 
+	if (xe_device_is_admin_only(xe))
+		goto out;
+
 	man = ttm_manager_type(&xe->ttm, XE_PL_TT);
 	mem_regions->mem_regions[0].mem_class = DRM_XE_MEM_REGION_CLASS_SYSMEM;
 	/*
@@ -296,7 +302,7 @@ static int query_mem_regions(struct xe_device *xe,
 			mem_regions->num_mem_regions++;
 		}
 	}
-
+out:
 	if (!copy_to_user(query_ptr, mem_regions, size))
 		ret = 0;
 	else
-- 
2.43.0

