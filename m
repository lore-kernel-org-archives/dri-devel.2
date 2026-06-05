Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB889CD6E7D
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 12:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA1011A820;
	Fri,  5 Jun 2026 12:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S1Z8i49V";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0E811A821;
 Fri,  5 Jun 2026 12:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780662558; x=1812198558;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=j2HndnUF15cqQQ18C2h0dS7otYN5RsQPXveV9Kn14co=;
 b=S1Z8i49VWhk9NmcPjXrT4eurWjJq/PglJZxY0NvG2NUXwVXrbG64daTo
 Pn7TwuVkzqbD+YJJdkb83U9wj7LPfpVxCt38gKKXKkRH92Agxyg1aIKr4
 Lgrqtqc2yUhxFPifmNy1TiubTz+I+rXjiMNOzFOnzj+nAfWdWh7rtHjDA
 xc/0FGcC69HzRoEOb+N4bvKYOLWSyyLgJl04Xc7bZ77dkcE9dhq2CE8XW
 asAxx9UeDuYg1hkg4caq+Mxxne6BtA6J3YrN7vVV4MUYfUOqNLXVm9x3u
 jGJ56zoc0VXHlZfgx7fIH0B1FiaWsbhbiqct5FetAvG5QJSx8Z7IX7yHJ A==;
X-CSE-ConnectionGUID: 2CaIp6LGRyeOvtCvGJuJrw==
X-CSE-MsgGUID: KK+A6XOzSp6MNectNXfLmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="81527064"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="81527064"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2026 05:29:18 -0700
X-CSE-ConnectionGUID: D8WgSaLbSAa8zFPbSgOxMQ==
X-CSE-MsgGUID: xRUE84oRSXmV0BN4TbZYpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; d="scan'208";a="240383686"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
 by fmviesa006.fm.intel.com with ESMTP; 05 Jun 2026 05:29:14 -0700
From: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 rodrigo.vivi@intel.com
Cc: andrealmeid@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona.vetter@ffwll.ch, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 anshuman.gupta@intel.com, badal.nilawar@intel.com, riana.tauro@intel.com,
 karthik.poosa@intel.com, sk.anirban@intel.com, raag.jadav@intel.com,
 Mallesh Koujalagi <mallesh.koujalagi@intel.com>
Subject: [PATCH v7 2/6] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method
Date: Fri,  5 Jun 2026 17:55:46 +0530
Message-ID: <20260605122544.1021695-10-mallesh.koujalagi@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605122544.1021695-8-mallesh.koujalagi@intel.com>
References: <20260605122544.1021695-8-mallesh.koujalagi@intel.com>
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
index 1ff0bf7cba6a..94abe7a811a5 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -537,6 +537,8 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
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

