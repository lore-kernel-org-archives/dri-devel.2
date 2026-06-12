Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED200CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 530A610F312;
	Fri, 12 Jun 2026 08:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iSS1M+1F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17C8A10F312;
 Fri, 12 Jun 2026 08:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781251875; x=1812787875;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KizxIRBlt5hPgv1YjGPO26qdueXRYMZi8GJqfBMVHP0=;
 b=iSS1M+1FzVxRSh1l/2UVFLzIFiu7AHShvUb/mOnkOH7EO09DXZ8o+dmS
 NarQh7KWrk3/8+IThHtjHTFF7chBu5j8+wZqwM++5hsopYGNmQlh5yrcy
 OqDvpzXEcakVMpKMcFDuuU/yVgMuU5mY5gZ48Wvb1EcPhJPPcDicTFtdu
 U/NFhRv99/gwYYQcwk/sEIAaYszkPxAM1pEO69hbi59zFT8qFz78s7LoP
 10gJyDmvzcHnw7E60YaIv6lCjpGPtVp9M86KDgL5h78qBc9jz+qzFG7wN
 zd7UdhlNlB3Q74RUmElhByefeZ/TjMaX8FEmbDJUGPT5qduTslzpaRmSy g==;
X-CSE-ConnectionGUID: d+010Mg6Q0Ox2+OuF0t/HA==
X-CSE-MsgGUID: ixk5vYwzSA6jaGwwvsvxEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85921452"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="85921452"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2026 01:11:14 -0700
X-CSE-ConnectionGUID: rhQFELzQR7+axkbByY5Hnw==
X-CSE-MsgGUID: LqRMqULgQhusGrouMpJ6AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; d="scan'208";a="245667218"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa006.jf.intel.com with ESMTP; 12 Jun 2026 01:11:09 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v8 6/6] drm/xe/ras: Add debugfs entry to inject punit error
Date: Fri, 12 Jun 2026 13:37:29 +0530
Message-ID: <20260612080722.26726-14-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612080722.26726-8-mallesh.koujalagi@intel.com>
References: <20260612080722.26726-8-mallesh.koujalagi@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Add a write-only debugfs file 'inject_punit_error' under the DRI device
root that allows triggering punit_error_handler() manually for testing.
Writing 1 to the file invokes the handler, which suppresses spurious
Surprise Link Down AER events on slots and declares the
device wedged for a cold reset recovery.

Usage:
  echo 1 > /sys/kernel/debug/dri/<N>/inject_punit_error

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/xe/xe_debugfs.c |  3 +++
 drivers/gpu/drm/xe/xe_ras.c     | 35 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_ras.h     |  7 +++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 22b471303984..bf22985a9fcf 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -28,6 +28,7 @@
 #include "xe_sriov_pf_debugfs.h"
 #include "xe_sriov_vf.h"
 #include "xe_step.h"
+#include "xe_ras.h"
 #include "xe_tile_debugfs.h"
 #include "xe_vsec.h"
 #include "xe_wa.h"
@@ -610,6 +611,8 @@ void xe_debugfs_register(struct xe_device *xe)
 
 	xe_psmi_debugfs_register(xe);
 
+	xe_ras_debugfs_register(xe, root);
+
 	fault_create_debugfs_attr("fail_gt_reset", root, &gt_reset_failure);
 
 	if (IS_SRIOV_PF(xe))
diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
index 15c2fa0d323a..281ef4dce218 100644
--- a/drivers/gpu/drm/xe/xe_ras.c
+++ b/drivers/gpu/drm/xe/xe_ras.c
@@ -3,6 +3,8 @@
  * Copyright © 2026 Intel Corporation
  */
 
+#include <linux/debugfs.h>
+
 #include "xe_bo.h"
 #include "xe_assert.h"
 #include "xe_device_types.h"
@@ -552,6 +554,39 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
 	return XE_RAS_RECOVERY_ACTION_RESET;
 }
 
+#ifdef CONFIG_DRM_XE_DEBUG
+static ssize_t inject_punit_error_write(struct file *f, const char __user *ubuf,
+					size_t size, loff_t *pos)
+{
+	struct xe_device *xe = f->private_data;
+	u32 val;
+	int ret;
+
+	ret = kstrtouint_from_user(ubuf, size, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val != 1)
+		return -EINVAL;
+
+	punit_error_handler(xe);
+
+	return size;
+}
+
+static const struct file_operations inject_punit_error_fops = {
+	.owner = THIS_MODULE,
+	.open = simple_open,
+	.write = inject_punit_error_write,
+};
+
+void xe_ras_debugfs_register(struct xe_device *xe, struct dentry *root)
+{
+	debugfs_create_file("inject_punit_error", 0200, root, xe,
+			    &inject_punit_error_fops);
+}
+#endif /* CONFIG_DRM_XE_DEBUG */
+
 static void aer_unmask_and_downgrade_internal_error(struct xe_device *xe)
 {
 	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
diff --git a/drivers/gpu/drm/xe/xe_ras.h b/drivers/gpu/drm/xe/xe_ras.h
index 8d106c708ff1..c9f84ef238c4 100644
--- a/drivers/gpu/drm/xe/xe_ras.h
+++ b/drivers/gpu/drm/xe/xe_ras.h
@@ -16,4 +16,11 @@ void xe_ras_counter_threshold_crossed(struct xe_device *xe,
 void xe_ras_init(struct xe_device *xe);
 enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe);
 
+#ifdef CONFIG_DRM_XE_DEBUG
+struct dentry;
+void xe_ras_debugfs_register(struct xe_device *xe, struct dentry *root);
+#else
+static inline void xe_ras_debugfs_register(struct xe_device *xe, struct dentry *root) {}
+#endif
+
 #endif
-- 
2.34.1

