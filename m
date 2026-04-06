Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D68F46C46
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFFA910E256;
	Mon,  6 Apr 2026 14:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GZGOHFvF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17E0810E254;
 Mon,  6 Apr 2026 14:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775485560; x=1807021560;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ES7wHzMgzb5rsi8fXx5GmItVbXrkVnb4NG9yKlBmK0I=;
 b=GZGOHFvFZDRefUMXHFjD+W9Nm+/Irt0NVlYfQuyd3XGwxJ8Jg1Wk8tR1
 X8MPpHDaYECNXm4ax5v6Dy+XM7WCHeGiUSMna0sPUL7kPoaPD3Uu/G8cJ
 lY7ar3cD5NjZbv6wiwJIre+iswTOn/2H66m6CsNJFgeyNOfk3JOQmbuE6
 XBsN1bHoJjYjPIPfBaOdy2gJ30a/tFzEvdcAq6W4CFHgW6NiuTOhOQaSD
 SaS/e5/rXm014m0XysNxkqdz1zaZoM+UshPxIckaYQBmu0drNYTj6vxb3
 XGaRRbuAUbinq6rSljiUpl/tBYqBuFkjlaDua/6aJ4b2zfiFLJ14LyM9j g==;
X-CSE-ConnectionGUID: quX+BCwwTA6/bqd5f7wiNQ==
X-CSE-MsgGUID: sykcSmBuQ2qGW3Rg+rhixQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="75603908"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="75603908"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 07:26:00 -0700
X-CSE-ConnectionGUID: XPKCMNE7SKu5I367sQSwZA==
X-CSE-MsgGUID: GR/jc45kRB2TZvKy8oxukA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="221309243"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa009.fm.intel.com with ESMTP; 06 Apr 2026 07:25:56 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org, anshuman.gupta@intel.com,
 badal.nilawar@intel.com, riana.tauro@intel.com, karthik.poosa@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v3 2/4] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method
Date: Mon,  6 Apr 2026 19:53:28 +0530
Message-ID: <20260406142325.157035-8-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406142325.157035-6-mallesh.koujalagi@intel.com>
References: <20260406142325.157035-6-mallesh.koujalagi@intel.com>
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

Introduce DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)) recovery
method to handle scenarios requiring complete cold reset.

This method addresses cases where other recovery mechanisms
(driver reload, PCIe reset, etc.) are insufficient to restore
device functionality. When set, it indicates to userspace that
only a full cold reset can recover the device from its current
error state. The cold reset method serves as a last resort
when all other recovery options have been exhausted.

v3:
- Update any scenario that requires cold-reset. (Riana)

Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
---
 drivers/gpu/drm/drm_drv.c | 2 ++
 include/drm/drm_device.h  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 985c283cf59f..8c0236e2e6a6 100644
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

