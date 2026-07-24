Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8782AC531FA
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D690D10F2CD;
	Fri, 24 Jul 2026 10:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ZfVgP/RH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B34DA10F2CB;
 Fri, 24 Jul 2026 10:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784887631; x=1816423631;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jOz7uoTcrwD3wi0VtmMQCc3Fq0fktM3nR0yPctpU+3A=;
 b=ZfVgP/RHi3/7tp+HVUgmrfJsspb48xrS7G0wpAViibcjSYsh6R9PbO4L
 O+OAcR8SCX+f8tLUTMEWpSt1sI++4A+27G2jiz4KDc8UUrWuC1qG0JQmL
 iDHY2c1x9u14xG4gEROzDFu+Ey3mQeNpbem+VHqX06Z1eTqqtlLyptvnH
 DGeT0gRDCsKnuzusrLf4ad9Z/AqlO8le2e2o/c5OUSlEnm0J4kBPtRqZC
 qlxLffyj3T7pN1P47Qa7tJWLeNykaQ4iHRFGWgQAUvmnfBHN07VVfoWv7
 ILqONGRfOykqsdnDy2EJR4To7DMNx10e5zoEPDeJ20NcYerLgr4xyN/VR g==;
X-CSE-ConnectionGUID: 9o6MUzy/QmqpdbNNYXs4+A==
X-CSE-MsgGUID: S4kW7ANDQfiIWB/QdXwSIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85668970"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="85668970"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jul 2026 03:07:11 -0700
X-CSE-ConnectionGUID: jrjBydeLSb2NQNrePJgvTA==
X-CSE-MsgGUID: 9P/EVyYgS2SN2Bdzawje/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; d="scan'208";a="262459867"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by orviesa004.jf.intel.com with ESMTP; 24 Jul 2026 03:07:05 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v12 1/4] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method
Date: Fri, 24 Jul 2026 15:33:04 +0530
Message-ID: <20260724100302.706685-7-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
References: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
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

