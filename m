Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 259D6C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 785CB10E879;
	Mon, 20 Jul 2026 10:22:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="esWM+vVW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A2CB10E865;
 Mon, 20 Jul 2026 10:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784542934; x=1816078934;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jOz7uoTcrwD3wi0VtmMQCc3Fq0fktM3nR0yPctpU+3A=;
 b=esWM+vVWUSdZPGokvgna1XNdyjPgUvfINk4h2QVKyX/7u+bocy/2/E97
 Y77RkSQQCdzSBunDLRKEzbq4pBKPMLzeH968o4DQV1QLHUpvfEiJ9mIIx
 NP4h2aLFxYLhXs2KIodX2Gcdq/Adsqp2wbBbW1QyhF8OOju4icX1Hwtyd
 M3bCbd1Nc8Fx0MbNdzd9Whh+1XpCxgLi1AKe+reTK+7s0Wq34hGMDjgml
 B3yb+U2S88IaGVtD+HUlmgvw7C6TDJSgh7ftH2jOJYEFWzATQyvzx5hD9
 GZ0amefzXU/9bRHY96uQ5QROlPYqiEpxTMVQGvwjv7AZpUgOKUicJGWwh Q==;
X-CSE-ConnectionGUID: qis4aqqGQn+tQV9iuqVaVg==
X-CSE-MsgGUID: 5V9Qs5uLTda6p83R21vHRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85070521"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85070521"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 03:22:14 -0700
X-CSE-ConnectionGUID: ZYMj3QinT7+2bRiyyh6YwA==
X-CSE-MsgGUID: 1xqJPIMLSwurSInZx2okvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="287475790"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa002.jf.intel.com with ESMTP; 20 Jul 2026 03:22:11 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v11 1/3] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method
Date: Mon, 20 Jul 2026 15:48:17 +0530
Message-ID: <20260720101815.526813-6-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720101815.526813-5-mallesh.koujalagi@intel.com>
References: <20260720101815.526813-5-mallesh.koujalagi@intel.com>
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

Introduce DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)) recovery method to handle
scenarios requiring device power cycle.

This method addresses cases where other recovery mechanisms
(driver reload, PCIe reset, etc.) are insufficient to restore device
functionality. When set, it indicates to userspace that only device power
cycle can recover the device from its current error state.

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
---
v3:
- Update any scenario that requires cold-reset. (Riana)

v4:
- Rename cold reset to power cycle. (Raag)

v5:
- Make it consistent with consumer expectations. (Raag)

v6:
- Drop "last resort" wording. (Riana)
---
 drivers/gpu/drm/drm_drv.c | 2 ++
 include/drm/drm_device.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index e51ed959da89..8519e97ef5d3 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -545,6 +545,8 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
 		return "bus-reset";
 	case DRM_WEDGE_RECOVERY_VENDOR:
 		return "vendor-specific";
+	case DRM_WEDGE_RECOVERY_COLD_RESET:
+		return "cold-reset";
 	default:
 		return NULL;
 	}
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 768a8dae83c5..75f030d027ee 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -37,6 +37,7 @@ struct pci_controller;
 #define DRM_WEDGE_RECOVERY_REBIND	BIT(1)	/* unbind + bind driver */
 #define DRM_WEDGE_RECOVERY_BUS_RESET	BIT(2)	/* unbind + reset bus device + bind */
 #define DRM_WEDGE_RECOVERY_VENDOR	BIT(3)	/* vendor specific recovery method */
+#define DRM_WEDGE_RECOVERY_COLD_RESET	BIT(4)	/* remove device + slot power cycle + rescan */
 
 /**
  * struct drm_wedge_task_info - information about the guilty task of a wedge dev
-- 
2.48.1

