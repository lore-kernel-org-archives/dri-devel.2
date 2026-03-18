Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B7CFCD0C1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC57B10E288;
	Wed, 18 Mar 2026 06:43:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TrLyygvn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C77E510E2E6;
 Wed, 18 Mar 2026 06:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773816202; x=1805352202;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=155QVqWJODU8xNNHlRgsyV1D+Cl0ClQaziyIdBDaolc=;
 b=TrLyygvnTX3gULMAj23DyKj97lAUiQ0k/FK1BJfHrKa7G/R+KAVVVYhZ
 tXzDkz1iAx40EJPIKXBmD4pj2G8HvGYlScrpF+WoP+e+9yPDQ8wvRfriG
 Vfed3BoAm0xiBSli/TF6gOUshtKE70PWe1xevAZFqW/sxcr3TP7wFGA/+
 9KPNjLUPFwo7MlaL4Szys+Lsl4BqRvh/jL4zwuAe61t1q51nhp+ZeuglW
 0Yx81BLKwxkKzXg1OzSdWMAcZrtNCjQ39/gUYbD44iQZ0hg6Vj2Mkle4Z
 3t7Q7JZV/9sbpxd41wWQSyJW7ChxMOO8V382IhsLcyErQJgEEMeQQxiuv w==;
X-CSE-ConnectionGUID: s8QJz3J0TT6ylxzf1As1SA==
X-CSE-MsgGUID: 2eTCJPfuSXeB6r06jShykg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78723370"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="78723370"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 23:43:22 -0700
X-CSE-ConnectionGUID: mHRb6TJCRKSoqL1NDoQ3nA==
X-CSE-MsgGUID: /WSCWPn1Q4ytZY5hylSoPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="227464669"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa005.jf.intel.com with ESMTP; 17 Mar 2026 23:43:17 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v2 5/5] drm/xe/debugfs: Add interface to trigger power
 management unit error handler
Date: Wed, 18 Mar 2026 12:10:22 +0530
Message-ID: <20260318064016.374656-12-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
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

Add a debugfs interface to manually trigger power management unit error
handler for testing cold reset recovery paths. This is useful for
validating the error recovery mechanism.

The new debugfs entry 'trigger_punit_error' is located at:
  /sys/kernel/debug/dri/N/trigger_punit_error

Reading the file displays usage instructions. Writing '1' invokes
xe_punit_error_handler(), which marks the device as wedged with
DRM_WEDGE_RECOVERY_COLD_RESET method and sends a uevent to userspace
indicating that a complete device power cycle is required for recovery.

Writing '0' or any other false value has no effect.

This interface is intended for development, testing, and validation
of power management unit error recovery code.

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/xe/xe_debugfs.c | 38 +++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
index 844cfafe1ec7..390bbed9c1af 100644
--- a/drivers/gpu/drm/xe/xe_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_debugfs.c
@@ -18,6 +18,7 @@
 #include "xe_gt_debugfs.h"
 #include "xe_gt_printk.h"
 #include "xe_guc_ads.h"
+#include "xe_hw_error.h"
 #include "xe_mmio.h"
 #include "xe_pm.h"
 #include "xe_psmi.h"
@@ -509,6 +510,40 @@ static const struct file_operations disable_late_binding_fops = {
 	.write = disable_late_binding_set,
 };
 
+static ssize_t trigger_punit_error_show(struct file *f, char __user *ubuf,
+					size_t size, loff_t *pos)
+{
+	const char *msg = "Write 1 to trigger power management unit error handler\n";
+
+	return simple_read_from_buffer(ubuf, size, pos, msg, strlen(msg));
+}
+
+static ssize_t trigger_punit_error_set(struct file *f,
+				       const char __user *ubuf,
+				       size_t size, loff_t *pos)
+{
+	struct xe_device *xe = file_inode(f)->i_private;
+	bool trigger;
+	ssize_t ret;
+
+	ret = kstrtobool_from_user(ubuf, size, &trigger);
+	if (ret)
+		return ret;
+
+	if (trigger) {
+		xe_punit_error_handler(xe);
+		drm_info(&xe->drm, "PMU error handler triggered via debugfs\n");
+	}
+
+	return size;
+}
+
+static const struct file_operations trigger_punit_error_fops = {
+	.owner = THIS_MODULE,
+	.read = trigger_punit_error_show,
+	.write = trigger_punit_error_set,
+};
+
 void xe_debugfs_register(struct xe_device *xe)
 {
 	struct ttm_device *bdev = &xe->ttm;
@@ -550,6 +585,9 @@ void xe_debugfs_register(struct xe_device *xe)
 	debugfs_create_file("disable_late_binding", 0600, root, xe,
 			    &disable_late_binding_fops);
 
+	debugfs_create_file("trigger_punit_error", 0600, root, xe,
+			    &trigger_punit_error_fops);
+
 	/*
 	 * Don't expose page reclaim configuration file if not supported by the
 	 * hardware initially.
-- 
2.34.1

