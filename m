Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3519CD4F54
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 388A410E7AE;
	Mon, 18 May 2026 10:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NXJzaM7k";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5954F10E7AE;
 Mon, 18 May 2026 10:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779101279; x=1810637279;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Qqp/uUc8AMvfjWJmMdf+Dw67ntEZ8oxGXZYlwxpMdW8=;
 b=NXJzaM7k16uGPBkUeFD5SXrYvJ/JrqCItgGjjNLsaTtcgi6lQHSRr1gT
 BcM0m8yB/v8EVLxekiZqRsUyPViGqwtOgDurrFvo2DbI5ReZU6PxlBz6J
 AZb1soRoU5Dt12isc8q2yRTXV2oJMv7G9eZWBSgm4VuaGoXBkbYniOwSQ
 UoqeuGQNl6T3K6iA2QbzcsR4KHdD24vXkvGh4uEBK2lD237kkr4H8oiLr
 vutQ5Yr3/PZ8YMNL4/jg/HpEarwjxlW3CmnrSMOGMvahCLhhMZIvsK5F+
 OmbIHX/aQFRHLGNLUM6ejoqpb9+uzcxX4CFrjdPwUilEMSHBP5Mqb2jiO g==;
X-CSE-ConnectionGUID: nnFH8eDgTFasF+OSDtPSAA==
X-CSE-MsgGUID: AexkObJxTJO6rDROb6E6YA==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79802404"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="79802404"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 03:47:59 -0700
X-CSE-ConnectionGUID: nRKpuH9AS1WuxBU8IjUZ0A==
X-CSE-MsgGUID: hhEWInr/RF+EpPev18YAVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; d="scan'208";a="243688595"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 03:47:54 -0700
From: Riana Tauro <riana.tauro@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org
Cc: aravind.iddamsetty@linux.intel.com, anshuman.gupta@intel.com,
 rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com, kuba@kernel.org,
 simona.vetter@ffwll.ch, airlied@gmail.com, pratik.bari@intel.com,
 joshua.santosh.ranjan@intel.com, ashwin.kumar.kulkarni@intel.com,
 shubham.kumar@intel.com, ravi.kishore.koppuravuri@intel.com,
 raag.jadav@intel.com, maarten.lankhorst@linux.intel.com,
 mallesh.koujalagi@intel.com, soham.purkait@intel.com,
 Riana Tauro <riana.tauro@intel.com>
Subject: [PATCH 2/2] drm/xe/xe_drm_ras: Add error-event support in XE drm_ras
Date: Mon, 18 May 2026 16:50:51 +0530
Message-ID: <20260518112048.1746280-6-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260518112048.1746280-4-riana.tauro@intel.com>
References: <20260518112048.1746280-4-riana.tauro@intel.com>
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

Add error-event support in XE drm_ras to notify userspace
whenever a GT or SoC error occurs.

$ sudo ./tools/net/ynl/pyynl/cli.py --family drm_ras --output-json \
--subscribe error-notify

{
    "name": "error-event",
     "msg": {
         "device-name": "0000:03:00.0",
         "node-id": 1,
         "node-name": "uncorrectable-errors",
         "error-id": 1,
         "error-name": "core-compute",
         "error-value": 1
     }
}

Signed-off-by: Riana Tauro <riana.tauro@intel.com>
---
 drivers/gpu/drm/xe/xe_drm_ras.c  | 29 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h  |  6 ++++++
 drivers/gpu/drm/xe/xe_hw_error.c |  7 ++++++-
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index c21c8b428de6..68d9f561d61d 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -181,6 +181,35 @@ static void xe_drm_ras_unregister_nodes(struct drm_device *device, void *arg)
 	}
 }
 
+/**
+ * xe_drm_ras_event() - Notify userspace of an error event
+ * @xe: xe device structure
+ * @error_id: error id
+ * @severity: error severity
+ * @flags: flags for allocation
+ *
+ * Notifies userspace of an error.
+ */
+void xe_drm_ras_event(struct xe_device *xe, u32 error_id,
+		      enum drm_xe_ras_error_severity severity, gfp_t flags)
+{
+	struct xe_drm_ras *ras = &xe->ras;
+	struct drm_ras_node *node = &ras->node[severity];
+	struct xe_drm_ras_counter *info = ras->info[severity];
+	u32 value;
+	int ret;
+
+	if (!info || !info[error_id].name)
+		return;
+
+	value = atomic_read(&info[error_id].counter);
+
+	ret = drm_ras_nl_error_event(node, error_id, info[error_id].name, value, flags);
+	if (ret)
+		drm_err(&xe->drm, "Failed to send RAS error event for error %s: %d\n",
+			info[error_id].name, ret);
+}
+
 /**
  * xe_drm_ras_init() - Initialize DRM RAS
  * @xe: xe device instance
diff --git a/drivers/gpu/drm/xe/xe_drm_ras.h b/drivers/gpu/drm/xe/xe_drm_ras.h
index 365c70e93e82..b9b8b541d591 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.h
+++ b/drivers/gpu/drm/xe/xe_drm_ras.h
@@ -5,11 +5,17 @@
 #ifndef _XE_DRM_RAS_H_
 #define _XE_DRM_RAS_H_
 
+#include <linux/types.h>
+
+#include <drm/xe_drm.h>
+
 struct xe_device;
 
 #define for_each_error_severity(i)	\
 	for (i = 0; i < DRM_XE_RAS_ERR_SEV_MAX; i++)
 
 int xe_drm_ras_init(struct xe_device *xe);
+void xe_drm_ras_event(struct xe_device *xe, u32 error_id,
+		      enum drm_xe_ras_error_severity severity, gfp_t flags);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 5135e8e4093f..c0fda18601cd 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -279,7 +279,7 @@ static void gt_hw_error_handler(struct xe_tile *tile, const enum hardware_error
 	if (hw_err == HARDWARE_ERROR_NONFATAL) {
 		atomic_inc(&info[error_id].counter);
 		log_hw_error(tile, info[error_id].name, severity);
-		return;
+		goto notify;
 	}
 
 	for (i = 0; i < PVC_GT_VECTOR_LEN(hw_err); i++) {
@@ -336,6 +336,9 @@ static void gt_hw_error_handler(struct xe_tile *tile, const enum hardware_error
 
 		xe_mmio_write32(mmio, ERR_STAT_GT_VECTOR_REG(hw_err, i), vector);
 	}
+
+notify:
+	xe_drm_ras_event(xe, error_id, severity, GFP_ATOMIC);
 }
 
 static void soc_slave_ieh_handler(struct xe_tile *tile, const enum hardware_error hw_err, u32 error_id)
@@ -418,6 +421,8 @@ static void soc_hw_error_handler(struct xe_tile *tile, const enum hardware_error
 
 	xe_mmio_write32(mmio, SOC_GLOBAL_ERR_STAT_REG(master, hw_err), master_global_errstat);
 
+	xe_drm_ras_event(xe, error_id, severity, GFP_ATOMIC);
+
 unmask_gsysevtctl:
 	for (i = 0; i < XE_SOC_NUM_IEH; i++)
 		xe_mmio_write32(mmio, SOC_GSYSEVTCTL_REG(master, slave, i),
-- 
2.47.1
