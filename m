Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BED5CD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 11:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E18EC10F030;
	Wed, 20 May 2026 11:37:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X9r0a0/m";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF46310F036;
 Wed, 20 May 2026 11:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779277023; x=1810813023;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mz5NcjZNG/vYAVYPLO+OUG6I+E4194dJNpOB1dQ03wY=;
 b=X9r0a0/m/rFIsnN6+rVzg4AXVPogg5cSZmJdd9865y6d9Cn2fHaRqr8O
 xOLs0GBhLhZ7fX47XnyTNASzL9+gpfEKpRkgXHDkN34BDJoKt9iH3+GOq
 PSjR6GkAFJKtPKeSsSSXeBwxh7joCsjjjHtkoZnIU1Hbwv0frWkGc9iXL
 FsonT7sX6n0BrXdV0/MMHHfNgM0F90yzNlrC3+VdEdX83I5sQCYyQMajJ
 oz/BmDrDEDkaObUCGjuRrXv1duRX/NOpkT5g4ZjK4J/Qww/f3+4zRrYc8
 F8aRDH7Of0PZWJosXoxQ1WESwuhFLeU9W92/uZrROyMc1GLSlHjsV+JaL Q==;
X-CSE-ConnectionGUID: HfmaonMzSC+ayqPNdymbdQ==
X-CSE-MsgGUID: VwFkpeRiRGmhO2TRvPsCRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="84027482"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="84027482"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 04:37:03 -0700
X-CSE-ConnectionGUID: dWf+s9D9ShetT5kdoi9E0Q==
X-CSE-MsgGUID: +KxNBrcqRF+w8DwRJNj0BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="237153518"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa007.fm.intel.com with ESMTP; 20 May 2026 04:36:58 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v6 2/5] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method
Date: Wed, 20 May 2026 17:03:54 +0530
Message-ID: <20260520113351.171119-9-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520113351.171119-7-mallesh.koujalagi@intel.com>
References: <20260520113351.171119-7-mallesh.koujalagi@intel.com>
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
- Rename cold reset to power cyclce. (Raag)

v5:
- Make it consistent with consumer expectations. (Raag)

v6:
- Drop "last resort" wording. (Riana)
---
 drivers/gpu/drm/drm_drv.c | 2 ++
 include/drm/drm_device.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 675675480da4..19c25366635e 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -535,6 +535,8 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
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
2.34.1

