Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE01FF60CF
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 06:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A422B10E852;
	Tue, 31 Mar 2026 06:16:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PD7LWBeK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B331810E852;
 Tue, 31 Mar 2026 06:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774937809; x=1806473809;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jJKYUJrYVIu1eA0fB9t9rxYy+ZTk7KuuC3vh77Xdkuo=;
 b=PD7LWBeKcYmpSaCZl1Km1InijGin5olyrb6qkNYoI2dOEBHmqC/wAjEj
 QxkiRvI3qFl62XIwaAGk8EJzERiQ7aBjz3A1tmf7nOBCeRhaS4d6oMson
 +HPFbnCa49tVPjfF0lKxSOUtMNrP3Fe7XXH7ntT+jX64cNVscogVCkBD5
 4W+wj7kkGdOhIx7gVQ5QeXRWO5I4++kCVZdhr20t44tDudNFHq+zHrhGA
 qqNDQgm1sj8MJuM2G3ES04KELGpj4qYSVQwb+TASHTrsm1JTb4uvwbAzI
 Pcf0V7A6KSXbyoGvqFH0+03h6sxIvYVUSBtnbgb1cXJYocEyQ0Oexh0o/ g==;
X-CSE-ConnectionGUID: YgolRwn+R4++5sYx1y4XVA==
X-CSE-MsgGUID: lcNBnuaaRuq0hb0COP2iIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76001055"
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="76001055"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 23:16:49 -0700
X-CSE-ConnectionGUID: ojNXwX4GSzm3lw6Th/o6ng==
X-CSE-MsgGUID: b0rc3eIqQt6z9NfAL2hexg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,151,1770624000"; d="scan'208";a="264202813"
Received: from ksatya-dev.iind.intel.com ([10.190.229.161])
 by orviesa001.jf.intel.com with ESMTP; 30 Mar 2026 23:16:46 -0700
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
Subject: [RFC v7 1/1] drm/xe/pf: Restrict device query responses in admin-only
 PF mode
Date: Tue, 31 Mar 2026 06:17:36 +0000
Message-ID: <20260331061736.1218962-2-satyanarayana.k.v.p@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331061736.1218962-1-satyanarayana.k.v.p@intel.com>
References: <20260331061736.1218962-1-satyanarayana.k.v.p@intel.com>
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

Limit the exposed ioctl set in admin-only PF mode to XE_DEVICE_QUERY, and
suppress capability-bearing query payloads so that the userspace cannot
discover execution-related device details in this mode.

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

---
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
 drivers/gpu/drm/xe/xe_device.c | 61 +++++++++++++++++++++++++++++++---
 drivers/gpu/drm/xe/xe_device.h |  1 +
 drivers/gpu/drm/xe/xe_query.c  |  6 ++++
 3 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index cbce1d0ffe48..910a0aa4c3d0 100644
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
@@ -415,6 +421,40 @@ static struct drm_driver driver = {
 	.patchlevel = DRIVER_PATCHLEVEL,
 };
 
+static struct drm_driver admin_only_driver = {
+	.driver_features =
+	    DRIVER_GEM | DRIVER_RENDER | DRIVER_GEM_GPUVA,
+	.open = xe_file_open,
+	.postclose = xe_file_close,
+
+	.gem_prime_import = xe_gem_prime_import,
+
+	.dumb_create = xe_bo_dumb_create,
+	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo = xe_drm_client_fdinfo,
+#endif
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
@@ -439,16 +479,24 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
 struct xe_device *xe_device_create(struct pci_dev *pdev,
 				   const struct pci_device_id *ent)
 {
+	struct drm_driver *driver = &regular_driver;
 	struct xe_device *xe;
 	int err;
 
-	xe_display_driver_set_hooks(&driver);
+	/*
+	 * Since XE device is not initialized yet, read from configfs
+	 * directly to decide whether we are in admin-only PF mode or not.
+	 */
+	if (xe_configfs_admin_only_pf(pdev))
+		driver = &admin_only_driver;
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
 
@@ -708,6 +756,11 @@ int xe_device_probe_early(struct xe_device *xe)
 
 	xe_sriov_probe_early(xe);
 
+	if (xe_configfs_admin_only_pf(to_pci_dev(xe->drm.dev)) && !IS_SRIOV_PF(xe)) {
+		drm_err(&xe->drm, "Admin-only PF mode is enabled in non PF mode\n");
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
diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
index d84d6a422c45..40c7ab9fecf8 100644
--- a/drivers/gpu/drm/xe/xe_query.c
+++ b/drivers/gpu/drm/xe/xe_query.c
@@ -217,6 +217,9 @@ static int query_engines(struct xe_device *xe,
 
 	engines->num_engines = i;
 
+	if (xe_device_is_admin_only(xe))
+		memset(engines, 0, size);
+
 	if (copy_to_user(query_ptr, engines, size)) {
 		kfree(engines);
 		return -EFAULT;
@@ -297,6 +300,9 @@ static int query_mem_regions(struct xe_device *xe,
 		}
 	}
 
+	if (xe_device_is_admin_only(xe))
+		memset(mem_regions, 0, size);
+
 	if (!copy_to_user(query_ptr, mem_regions, size))
 		ret = 0;
 	else
-- 
2.43.0

