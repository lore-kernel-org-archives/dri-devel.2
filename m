Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD66FFCD0C4
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 06:43:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B1CA10E2D2;
	Wed, 18 Mar 2026 06:43:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VPs2QdyL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B8610E2C6;
 Wed, 18 Mar 2026 06:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773816187; x=1805352187;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tCjuP0pIo+liDr/rNjDXrdJMic7met6Q1Np+lbM7vB4=;
 b=VPs2QdyL0uzuP7IAvDFltpdsatGeo8ZJYTvRURNugV567Bu1KcAs7IWR
 /LDrlrw4k+HkpW90F5kNr9bj1Q6xU0Wb5uN6OhSBm0is2uS6Obql5wbGO
 nwAxu1k7BxZ+5OYFzn6yYebKRn48zkQAlV95dUjcTX9tewGPf/sn+6K+4
 OlYeNVbopywE1hcAoCjrk46OsYGwrMymPji55nsgTBj8a21SDKyBEdXSP
 5xyKK29Z3/SWG6XYnEoAPrW2O4FjZI4TzGrDL1DeN7MAkpV5Wc450ceNf
 XixD/kpJmosZtAK9knGzFDMz7nbDfPaoPOWAt5wEL1Bs+sxfD2ayUw3FE g==;
X-CSE-ConnectionGUID: w/QYggC0QzOapaib/9i9dA==
X-CSE-MsgGUID: 6USoyqVtTdORYAwSY65Wrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78723344"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="78723344"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 23:43:07 -0700
X-CSE-ConnectionGUID: KLzzzdhpR8yJfgabHG2LSA==
X-CSE-MsgGUID: b0Z8Iqg5R4Ko2jy9g/Harw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="227464570"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa005.jf.intel.com with ESMTP; 17 Mar 2026 23:43:03 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v2 2/5] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET for power
 management unit error
Date: Wed, 18 Mar 2026 12:10:19 +0530
Message-ID: <20260318064016.374656-9-mallesh.koujalagi@intel.com>
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

Introduce DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)) recovery method to
handle power management unit errors requiring complete device power
cycling.

This method addresses scenarios where recovery mechanisms
(driver reload, PCIe reset, etc.) are insufficient to restore
device functionality. When set, it indicates to userspace that
only a full cold reset can recover the device from its current error
state. The cold reset method serves as a last resort for power management
unit errors.

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/drm_drv.c | 2 ++
 include/drm/drm_device.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 6b965c3d3307..2dace9070531 100644
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
index bc78fb77cc27..3e386eb42023 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -37,6 +37,7 @@ struct pci_controller;
 #define DRM_WEDGE_RECOVERY_REBIND	BIT(1)	/* unbind + bind driver */
 #define DRM_WEDGE_RECOVERY_BUS_RESET	BIT(2)	/* unbind + reset bus device + bind */
 #define DRM_WEDGE_RECOVERY_VENDOR	BIT(3)	/* vendor specific recovery method */
+#define DRM_WEDGE_RECOVERY_COLD_RESET	BIT(4)	/* full device cold reset */
 
 /**
  * struct drm_wedge_task_info - information about the guilty task of a wedge dev
-- 
2.34.1

