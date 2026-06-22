Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC876CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E4CB10E5F7;
	Mon, 22 Jun 2026 10:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E4vdFtQf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB4210E5F7;
 Mon, 22 Jun 2026 10:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782123468; x=1813659468;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dpWdwD8glnaSaD0+Nt7C4cch4B/syPLuvEE2WAFcqGE=;
 b=E4vdFtQfCeVWtOX/+h0uHo8uEpiN0neDFZfsKXymhaKawrcBR6E4qs0f
 vzrChS7kQwwhVDVckqiflO3jRCeh/0VYlu90GBeBCmpbKJBMfZCZvMR0v
 lFhe/hRQiEeyBebQsS9+n4FxtJxL1VS7nKGvGzS/AN8tM/qMFReZ/Vj1Y
 vLZca4Ofw7cK8iFvfKQPf3h/TA1g25PHZ+QmgvRiLa1JuEirBKE+gfv6n
 QWRYIjMdV0Z+SyIAc+eL4i+9RTSIzjEQvdkwTveBe+qL+7MxjDn+KDflk
 3S8PbS6SjKzaRQHmT4yyYnPH0opjdL/i7n8evwm1l75ZcIjlGt61sZHuY w==;
X-CSE-ConnectionGUID: r24nWH2hRy67uPU2AVxBQw==
X-CSE-MsgGUID: 92nMN1tqQPmSJL7Zppo/rQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="86532072"
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="86532072"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 03:17:48 -0700
X-CSE-ConnectionGUID: tJzNE0tJTVSR4sZtec9iqQ==
X-CSE-MsgGUID: sYQvSibyQvWqLp26PwjFww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,218,1774335600"; d="scan'208";a="242832408"
Received: from rtauro-desk.iind.intel.com ([10.190.238.50])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2026 03:17:43 -0700
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
Subject: [PATCH v3 2/3] drm/xe/xe_drm_ras: Add error-event support for PVC
Date: Mon, 22 Jun 2026 15:47:19 +0530
Message-ID: <20260622101716.3313496-7-riana.tauro@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260622101716.3313496-5-riana.tauro@intel.com>
References: <20260622101716.3313496-5-riana.tauro@intel.com>
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

Report drm_ras error event to userspace when an error occurs.
Add support for core-compute and SoC errors in PVC.

$ sudo ynl --family drm_ras --output-json --subscribe error-report

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
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
v2: use ynl (Raag)
    use value as function parameter
    move error event call to hw_error_source_handler 

v3: add has_drm_ras check
---
 drivers/gpu/drm/xe/xe_drm_ras.c  | 30 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_drm_ras.h  |  3 +++
 drivers/gpu/drm/xe/xe_hw_error.c |  5 ++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_ras.c
index 7937d8ba0ed9..36afdfb5e412 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.c
+++ b/drivers/gpu/drm/xe/xe_drm_ras.c
@@ -185,6 +185,36 @@ static int register_nodes(struct xe_device *xe)
 	return ret;
 }
 
+/**
+ * xe_drm_ras_event() - Report drm-ras error event to userspace
+ * @xe: xe device structure
+ * @component: error component (see &enum drm_xe_ras_error_component)
+ * @severity: error severity (see &enum drm_xe_ras_error_severity)
+ * @value: value of error counter
+ * @flags: flags for allocation
+ *
+ * Report an error-event to userspace.
+ */
+void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value, gfp_t flags)
+{
+	struct xe_drm_ras *ras = &xe->ras;
+	struct xe_drm_ras_counter *info = ras->info[severity];
+	struct drm_ras_node *node = &ras->node[severity];
+	int ret;
+
+	/* Event is supported only if drm_ras is enabled */
+	if (!xe->info.has_drm_ras)
+		return;
+
+	if (!info || !info[component].name)
+		return;
+
+	ret = drm_ras_nl_error_event(node, component, info[component].name, value, flags);
+	if (ret)
+		drm_err(&xe->drm, "RAS error-event failed: %d for %s %s\n", ret,
+			info[component].name, error_severity[severity]);
+}
+
 /**
  * xe_drm_ras_init() - Initialize DRM RAS
  * @xe: xe device instance
diff --git a/drivers/gpu/drm/xe/xe_drm_ras.h b/drivers/gpu/drm/xe/xe_drm_ras.h
index 365c70e93e82..2a694bf69478 100644
--- a/drivers/gpu/drm/xe/xe_drm_ras.h
+++ b/drivers/gpu/drm/xe/xe_drm_ras.h
@@ -5,11 +5,14 @@
 #ifndef _XE_DRM_RAS_H_
 #define _XE_DRM_RAS_H_
 
+#include <linux/types.h>
+
 struct xe_device;
 
 #define for_each_error_severity(i)	\
 	for (i = 0; i < DRM_XE_RAS_ERR_SEV_MAX; i++)
 
 int xe_drm_ras_init(struct xe_device *xe);
+void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity, u32 value, gfp_t flags);
 
 #endif
diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_error.c
index 4a4b363fc844..a833cecc74ec 100644
--- a/drivers/gpu/drm/xe/xe_hw_error.c
+++ b/drivers/gpu/drm/xe/xe_hw_error.c
@@ -432,7 +432,7 @@ static void hw_error_source_handler(struct xe_tile *tile, const enum hardware_er
 	struct xe_drm_ras *ras = &xe->ras;
 	struct xe_drm_ras_counter *info = ras->info[severity];
 	unsigned long flags, err_src;
-	u32 err_bit;
+	u32 err_bit, value;
 
 	if (!IS_DGFX(xe))
 		return;
@@ -495,6 +495,9 @@ static void hw_error_source_handler(struct xe_tile *tile, const enum hardware_er
 			gt_hw_error_handler(tile, hw_err, error_id);
 		if (err_bit == XE_SOC_ERROR)
 			soc_hw_error_handler(tile, hw_err, error_id);
+
+		value = atomic_read(&info[error_id].counter);
+		xe_drm_ras_event(xe, error_id, severity, value, GFP_ATOMIC);
 	}
 
 clear_reg:
-- 
2.47.1

