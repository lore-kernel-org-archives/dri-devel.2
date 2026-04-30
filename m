Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FCACD13DE
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 18:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 425FE10F411;
	Thu, 30 Apr 2026 18:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="xZmcoZyp";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CF4010F411
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 18:34:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrNRJl0AV/IYy/oKjtDDxY/rWqLumuxRNKWLfQZxjK3RRgas0x04Ay+hFuoFWqLhVk6/3uQDIOze8m2IZErEa/Fhsa84wTvlq+Y5r8mZTvzy5p2FznFfK5Jvev1ZpKJH5LCRCeIQ3rant8FfjA2BRJ4TMPxQCl8EQ7LpSIlg3BPQkK6qjgk4ZeMxZL4ZkzpDllZQSQj4gnu9Wb4+k3jTqaa/Nfwj26K4in7Q/L2P0OD0aepdwlenq9ykAmXRDApyXQysax5eSBVfGPWgJg6o5p/w1mfr2Nrn5wf0mv2FAMCFtQHV+ee04hTnimKdom2AQen6R3/st18oyFvU4Ttrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iJNnskLQ02CCD3lKjxFQJuCvaj6DxdtgnwRip4cgmw=;
 b=yI3v0yOa/SI1LdVFPjPbCVErlwoN5Fp6Xq1kkvWHHPouLgJNcUfAZWlEDtdahxX1FTyE+ijufWTDSxTPt28AYQZpOCbQ2yEMou1Tl+HX/Nq6QBnoscqr4beZ3cn1CORMqTLwcqpfdPgVRKg8pQdELtRPfyDFyYVOv54OGYONBVmYEDqAuvwzOgdj/RhF957ara53QcbAce0EMKl81C1YJBy9NBlxyM1vwcQJingvKiB+QHFbLYtjl6z1EhfH3Db/TF0Ls9fYfZo26eXin8F45Z761vvfwNpaD+Z7HPec0mnRmYKwpKe4WPUSXPKrU4zU+6Py8GxFXXvGFf8vioxiLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iJNnskLQ02CCD3lKjxFQJuCvaj6DxdtgnwRip4cgmw=;
 b=xZmcoZyp5M18U4jILTHGpS/ZB8eZ5n0mKj2lZbodv9hmAO2JDV1lk8AC9xI2hyMCRiS8yqiprBMyWXbD6N9+Ie0lhDsOE3tiPQAbJKUNhXKcQAncJkr1ovCcl6M/U59TScXZ6U6HE/9ofktEOqy07f5lCp9+DIO9oRQqXsDGFqA=
Received: from PH8P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::13)
 by DM6PR10MB4314.namprd10.prod.outlook.com (2603:10b6:5:216::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 18:33:57 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:2d7:cafe::35) by PH8P222CA0018.outlook.office365.com
 (2603:10b6:510:2d7::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 18:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Thu, 30 Apr 2026 18:33:55 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 13:33:55 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Apr
 2026 13:33:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Apr 2026 13:33:53 -0500
Received: from localhost (ti.dhcp.ti.com [172.24.233.157] (may be forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63UIXqW91698856;
 Thu, 30 Apr 2026 13:33:53 -0500
From: Devarsh Thakkar <devarsht@ti.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, "Bjorn
 Andersson" <bjorn.andersson@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <s-jain1@ti.com>, <s-wang12@ti.com>, 
 <r-donadkar@ti.com>, <r-sharma3@ti.com>, <devarsht@ti.com>, <afd@ti.com>
Subject: [PATCH 4/6] drm/tiny: panel-ssd16xx: Add power management support
Date: Fri, 1 May 2026 00:03:09 +0530
Message-ID: <20260430183311.2978142-5-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260430183311.2978142-1-devarsht@ti.com>
References: <20260430183311.2978142-1-devarsht@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DM6PR10MB4314:EE_
X-MS-Office365-Filtering-Correlation-Id: 435584cb-fc72-44a5-9736-08dea6e7095a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|921020|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: J9/pbKemK2w08mXixSZp9bI9R9L4s9pynJlV6GVqEBacrWjPlVH9PtEerxGBwwzFJzgbsni9UT7jzmw8qZ6qIUqXaWWpieVdKEJNF3bkv0Iio7o8xof/u4WmTZUXF7x/aSn7bAPa1Y5jmCP1chfwaqRgSezVZVJiN6SJj5jFX7CGtHuHUeezxrDUiC/0qsx5CMd/tAgEOeJEOFrlm883hIpQuXixtMp4xOEzw7zJ7xLLzMK0+Xvk0bzvMwODQsBokl1XInXMmiNzu4QiVTJSqTSX3i4PEbrXuO8J2dXi0YIYHI/tunlQWIMF3/jDQoYk/OHiKkYVUsFtWvKNv4lVvvngYKuNBnjXgOH5P+4jiDpkiJ5xEq5cM0mBz50N6k0uAvBKZEJSFLUv/yExF0k6bvh4KFMU/E9E50uPNFM6XcLB5hwHUx1QAoWmEI9NaHAonpao+DcKPXpDb+LD23fty5I+G8IY75tamMUUG/EqpK5HaHNyzeWNzkJH0LCU++sWvuRsFMev0dl6/7tQliyn3xncgXVHQd5tY8eVoKScaiXbv4FEKYro2gwVPEqTMXgJMgg6uepg7YZYqNx04K9bQUW6W8CuCvMzQ/Ssmp/Un8PVBprV4hHXGpPByQ9ygnUCiQrid4IFN0KvFdg3AAgpLXPn2+VKDFTKeqcOMcdQqdWVU6Wu8hsf/36mnPAxoCMQZ9zCKz3u+7J/4kQnj2LqTRKW6fGJhDaJNY0vP1yD8H8nry0azBfC2vti4tX5dngQfP6NpLouD7paU1/sR4HVjg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: K9DTttbWdcYEpVaz0E9RJRl5lsMncEdMxhlCPdGD5E+Ln0bKcrR8fvVSeRAHLMu1a3kdxPfxqU6dH3E6O/22euS0KQIg7h6krjiIrKey7kJD0RZEAuETCl6MF5//nWopTiapLCmTDYm4tQcPL6XmioEqGowCLTpLNTi71GR5qJQusHZ8K3WMem363wDR2TpiUp2j0/oIcxtXorCzrjo4rjQk746PyMHOf11TohJf966iXuBKegOABt7f0gjRbzAIgdJoGOVCLD9nJDQtFLMQYbEHAuOM0m0dVES0wk9O6qlw0v1h6cfM3kKFoO+dwdTzw/lHvi6FZwNa+9y1ylUbuJHRP3oxhoPk5zY8OKqQ3gYEsT3fTmSaB4Muk93amO4Gzbfg0C6cbZwsfUdg1P5D+ZwY8F4YjEj/mcbd1z6/LZSCWN5dQVpKbCVwwOHkOdYb
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 18:33:55.6867 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 435584cb-fc72-44a5-9736-08dea6e7095a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4314
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

Add system suspend/resume and runtime PM with idle timeout support to
the SSD16xx driver.

E-paper panels are bistable: they continue to display the last rendered
image indefinitely even in deep sleep or when power is cut to the
controller IC.  This makes it practical to suspend the controller
aggressively — including while a display application is still open and the
user is simply reading — without any visible disruption.  The driver
exploits this by firing the autosuspend timer after an idle timeout,
putting the controller into deep sleep regardless of CRTC state, and waking
it transparently on the next frame update.

The SSD16xx family supports two deep sleep modes:

Mode 1 (RAM retained): used for runtime idle.  Display RAM survives the
sleep, so resume only requires a hardware reset and re-initialisation; no
full redraw is needed, keeping wake latency minimal.

Mode 2 (RAM lost): used for system suspend.  Maximises power savings at
the cost of a complete controller re-init and repaint on resume.

Runtime PM: Each hardware-touching callback wraps its SPI access with
pm_runtime_resume_and_get() / pm_runtime_put_autosuspend() pairs so the PM
reference count drops to zero after every update.  This allows the
autosuspend timer to fire while the CRTC is still enabled, putting the
controller into Mode 1 deep sleep between updates without requiring the
application to close or the display pipeline to be torn down.

An autosuspend delay of 35 seconds keeps the panel active across typical
user-interaction gaps while still capturing long idle periods.

System suspend/resume: On system suspend the driver switches to Mode 2 and
quiesces the atomic pipeline via drm_mode_config_helper_suspend().  If the
autosuspend timer already fired (device is RPM_SUSPENDED), the driver wakes
the panel via HWRESET (the only exit from deep sleep since SPI is
unresponsive), sends Mode 2 directly, and tracks the state with a
pm_force_suspended flag so the matching force_resume is called only when
needed.  On resume, Mode 1 is restored for subsequent runtime PM cycles and
the atomic pipeline is rebuilt via drm_mode_config_helper_resume().

Per-client initialisation refresh: A drm_driver.master_set callback arms
init_refresh_pending when a new client opens the DRM device as a DRM
master, ensuring its first frame uses the configured init-refresh waveform.
A paired master_drop callback clears the flag on fd close by a DRM master.
This is kept separate from the runtime resume path since Mode 1 retains RAM
and a full refresh on every runtime wake would be wasteful.

Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 drivers/gpu/drm/tiny/panel-ssd16xx.c | 203 +++++++++++++++++++++++++--
 1 file changed, 193 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tiny/panel-ssd16xx.c b/drivers/gpu/drm/tiny/panel-ssd16xx.c
index b232837c54ff..6bf763667d82 100644
--- a/drivers/gpu/drm/tiny/panel-ssd16xx.c
+++ b/drivers/gpu/drm/tiny/panel-ssd16xx.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
 
@@ -88,6 +89,7 @@ MODULE_PARM_DESC(color_mode,
 
 /* SPI command codes (common) */
 #define SSD16XX_CMD_DRIVER_OUTPUT_CONTROL		0x01
+#define SSD16XX_CMD_DEEP_SLEEP_MODE			0x10
 #define SSD16XX_CMD_DATA_ENTRY_MODE			0x11
 #define SSD16XX_CMD_SW_RESET				0x12
 #define SSD16XX_CMD_MASTER_ACTIVATION			0x20
@@ -100,6 +102,9 @@ MODULE_PARM_DESC(color_mode,
 #define SSD16XX_CMD_SET_RAM_X_ADDRESS_COUNTER		0x4E
 #define SSD16XX_CMD_SET_RAM_Y_ADDRESS_COUNTER		0x4F
 
+/* Runtime PM autosuspend delay (ms): keep display active across typical gaps */
+#define SSD16XX_PM_AUTOSUSPEND_DELAY_MS			35000
+
 /*
  * Data Entry Mode (command 0x11) AM/IDY/IDX bit encoding (common).
  *
@@ -405,8 +410,10 @@ struct ssd16xx_panel {
 	bool init_refresh_pending; /* First frame after refresh_mode_init enable */
 	bool first_clear_done;  /* clear_on_init has already fired once */
 	bool display_cleared_on_deinit; /* Avoid redundant clear in atomic_disable/master_drop */
+	bool pm_force_suspended;  /* pm_runtime_force_suspend was called in pm_suspend */
 
-	int orientation; /* Display orientation in degrees: 0/90/180/270 */
+	int orientation;      /* Display orientation in degrees: 0/90/180/270 */
+	u8 deep_sleep_mode;   /* Deep sleep mode to use on next disable */
 	enum ssd16xx_refresh_mode refresh_mode; /* Active refresh mode */
 	enum ssd16xx_color_mode color_mode;     /* Active color mode (BW or 3-color) */
 	bool fast_lut_pending; /* LUT pre-load needed before next fast refresh */
@@ -1526,10 +1533,9 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 	struct drm_rect rect;
 	int ret;
 
-	drm_dbg(&panel->drm, "plane_atomic_update: fb=%p, initialized=%d\n",
-		fb, panel->initialized);
+	drm_dbg(&panel->drm, "plane_atomic_update: fb=%p\n", fb);
 
-	if (!fb || !panel->initialized)
+	if (!fb)
 		return;
 
 	/*
@@ -1541,6 +1547,12 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 		return;
 	}
 
+	ret = pm_runtime_resume_and_get(panel->drm.dev);
+	if (ret < 0) {
+		drm_err(&panel->drm, "plane_atomic_update: failed to resume: %d\n", ret);
+		return;
+	}
+
 	if (!drm_atomic_helper_damage_merged(old_state, new_state, &rect)) {
 		rect.x1 = 0;
 		rect.y1 = 0;
@@ -1598,6 +1610,9 @@ static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
 		panel->init_refresh_pending = false;
 		panel->border_waveform_pending = true;
 	}
+
+	pm_runtime_mark_last_busy(panel->drm.dev);
+	pm_runtime_put_autosuspend(panel->drm.dev);
 }
 
 static const struct drm_plane_helper_funcs ssd16xx_plane_helper_funcs = {
@@ -1656,6 +1671,10 @@ static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
 	if (panel->clear_on_disable < 0 || panel->display_cleared_on_deinit)
 		goto out;
 
+	ret = pm_runtime_resume_and_get(panel->drm.dev);
+	if (ret < 0)
+		goto out;
+
 	drm_dbg(&panel->drm, "clear_on_disable: running, mode=%d\n",
 		panel->clear_on_disable);
 	ret = ssd16xx_clear_display(panel,
@@ -1663,10 +1682,12 @@ static void ssd16xx_crtc_atomic_disable(struct drm_crtc *crtc,
 								  panel->clear_on_disable));
 	if (ret) {
 		drm_err(&panel->drm, "atomic_disable: clear failed: %d\n", ret);
+		pm_runtime_put_autosuspend(panel->drm.dev);
 		goto out;
 	}
 
 	panel->display_cleared_on_deinit = true;
+	pm_runtime_put_sync_suspend(panel->drm.dev);
 out:
 	drm_dev_exit(idx);
 }
@@ -1682,6 +1703,12 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 		return;
 
 	panel->display_cleared_on_deinit = false;
+	ret = pm_runtime_resume_and_get(panel->drm.dev);
+	if (ret < 0) {
+		drm_err(&panel->drm, "crtc_atomic_enable: failed to resume: %d\n", ret);
+		drm_dev_exit(idx);
+		return;
+	}
 
 	drm_dbg(&panel->drm, "atomic_enable: %dx%d\n",
 		crtc_state->mode.hdisplay, crtc_state->mode.vdisplay);
@@ -1689,12 +1716,19 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 	panel->width = crtc_state->mode.hdisplay;
 	panel->height = crtc_state->mode.vdisplay;
 
-	ret = ssd16xx_hw_init(panel);
-	if (ret) {
-		drm_err(&panel->drm, "crtc_atomic_enable: HW init failed: %d\n", ret);
-		goto out;
+	/*
+	 * pm_runtime_resume_and_get() triggers pm_runtime_resume which runs
+	 * hw_init and sets initialized. If runtime PM is disabled the callback
+	 * never fires, so fall back to running hw_init directly here.
+	 */
+	if (!panel->initialized) {
+		ret = ssd16xx_hw_init(panel);
+		if (ret) {
+			drm_err(&panel->drm, "crtc_atomic_enable: HW init failed: %d\n", ret);
+			goto out;
+		}
+		panel->initialized = true;
 	}
-	panel->initialized = true;
 
 	/* Clear display on first app launch if configured */
 	ret = ssd16xx_clear_display_on_init(panel);
@@ -1714,6 +1748,8 @@ static void ssd16xx_crtc_atomic_enable(struct drm_crtc *crtc,
 	}
 
 out:
+	pm_runtime_mark_last_busy(panel->drm.dev);
+	pm_runtime_put_autosuspend(panel->drm.dev);
 	drm_dev_exit(idx);
 }
 
@@ -1730,7 +1766,7 @@ static void ssd16xx_crtc_atomic_flush(struct drm_crtc *crtc,
 	struct drm_rect full;
 	int ret, idx;
 
-	if (!panel->reinit_pending || !panel->initialized)
+	if (!panel->reinit_pending)
 		return;
 
 	if (!drm_dev_enter(&panel->drm, &idx))
@@ -1738,6 +1774,13 @@ static void ssd16xx_crtc_atomic_flush(struct drm_crtc *crtc,
 
 	panel->reinit_pending = false;
 
+	ret = pm_runtime_resume_and_get(panel->drm.dev);
+	if (ret < 0) {
+		drm_err(&panel->drm, "atomic_flush: failed to resume: %d\n", ret);
+		drm_dev_exit(idx);
+		return;
+	}
+
 	drm_dbg(&panel->drm, "atomic_flush: reinit, orientation=%u°\n",
 		panel->orientation);
 
@@ -1762,6 +1805,8 @@ static void ssd16xx_crtc_atomic_flush(struct drm_crtc *crtc,
 	}
 
 out:
+	pm_runtime_mark_last_busy(panel->drm.dev);
+	pm_runtime_put_autosuspend(panel->drm.dev);
 	drm_dev_exit(idx);
 }
 
@@ -2189,11 +2234,17 @@ static void ssd16xx_drm_master_drop(struct drm_device *drm,
 	if (panel->clear_on_close < 0 || panel->display_cleared_on_deinit)
 		return;
 
+	ret = pm_runtime_resume_and_get(drm->dev);
+	if (ret < 0)
+		return;
+
 	ret = ssd16xx_clear_display_on_exit(panel);
 	if (ret)
 		drm_err(drm, "master_drop: clear on close failed: %d\n", ret);
 
 	panel->display_cleared_on_deinit = true;
+	/* sync suspend — bypass autosuspend, sleep immediately after clear */
+	pm_runtime_put_sync_suspend(drm->dev);
 }
 
 static struct drm_driver ssd16xx_drm_driver = {
@@ -2496,6 +2547,20 @@ static int ssd16xx_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	/* Default to runtime sleep mode (RAM retained if supported) */
+	panel->deep_sleep_mode = panel->controller_cfg->deep_sleep_mode_level1;
+	/*
+	 * Mark the device active before enabling runtime PM.  The SPI device
+	 * persists across module reload cycles; pm_runtime_enable() alone
+	 * does not clear a stale dev->power.runtime_error left by a previous
+	 * failed hw_init, which would cause pm_runtime_resume_and_get() to
+	 * return -EINVAL on every subsequent call.
+	 */
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+	pm_runtime_set_autosuspend_delay(dev, SSD16XX_PM_AUTOSUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(dev);
+
 	drm_dbg(drm, "SSD16xx e-paper display initialized (%dx%d, %d° rotation)\n",
 		panel->width, panel->height, panel->orientation);
 
@@ -2508,6 +2573,8 @@ static void ssd16xx_remove(struct spi_device *spi)
 {
 	struct ssd16xx_panel *panel = spi_get_drvdata(spi);
 
+	pm_runtime_dont_use_autosuspend(&spi->dev);
+	pm_runtime_disable(&spi->dev);
 	drm_dev_unplug(&panel->drm);
 	drm_atomic_helper_shutdown(&panel->drm);
 }
@@ -2516,9 +2583,124 @@ static void ssd16xx_shutdown(struct spi_device *spi)
 {
 	struct ssd16xx_panel *panel = spi_get_drvdata(spi);
 
+	pm_runtime_dont_use_autosuspend(&spi->dev);
+	pm_runtime_disable(&spi->dev);
 	drm_atomic_helper_shutdown(&panel->drm);
 }
 
+static int ssd16xx_pm_suspend(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct ssd16xx_panel *panel = to_ssd16xx_panel(drm);
+	int ret;
+
+	/* System suspend: Mode 2 (max savings, RAM lost, full re-init on resume). */
+	panel->deep_sleep_mode = panel->controller_cfg->deep_sleep_mode_level2;
+	dev_dbg(dev, "system suspend: entering deep sleep mode 0x%02x\n",
+		panel->deep_sleep_mode);
+
+	ret = drm_mode_config_helper_suspend(drm);
+	if (ret)
+		return ret;
+
+	/*
+	 * With per-update PM gating the panel may already be in MODE_1 deep
+	 * sleep (autosuspend fired while the user was reading).
+	 * pm_runtime_force_suspend() skips its callback when the device is
+	 * already RPM_SUSPENDED, so MODE_2 would never reach the hardware.
+	 *
+	 * Per the datasheet, HWRESET is the only way to exit deep sleep (SPI
+	 * is unresponsive in both modes).  After the reset, MODE_2 can be
+	 * sent immediately — no full hw_init is required.  The RPM state
+	 * remains RPM_SUSPENDED; pm_runtime_force_suspend() is skipped since
+	 * the device is already in the right state.
+	 */
+	if (pm_runtime_status_suspended(dev)) {
+		int err = 0;
+
+		dev_dbg(dev, "system suspend: upgrading MODE_1 -> MODE_2 via HWRESET\n");
+		ssd16xx_hw_reset(panel);
+		ssd16xx_send_cmd(panel, SSD16XX_CMD_DEEP_SLEEP_MODE, &err);
+		ssd16xx_send_data(panel, panel->controller_cfg->deep_sleep_mode_level2, &err);
+		panel->pm_force_suspended = false;  /* Skip force_resume on resume */
+		return err;
+	}
+
+	/* Force runtime-suspended state for clean resume. */
+	pm_runtime_force_suspend(dev);
+	panel->pm_force_suspended = true;  /* Resume must call force_resume */
+
+	return 0;
+}
+
+static int ssd16xx_pm_resume(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+	struct ssd16xx_panel *panel = to_ssd16xx_panel(drm);
+
+	dev_dbg(dev, "system resume: restoring state\n");
+
+	/*
+	 * Only call force_resume if we actually called force_suspend during
+	 * system suspend. The MODE_1->MODE_2 upgrade path skips force_suspend
+	 * since the device is already RPM_SUSPENDED.
+	 */
+	if (panel->pm_force_suspended) {
+		pm_runtime_force_resume(dev);
+		panel->pm_force_suspended = false;
+	}
+
+	/* Restore Mode 1 (RAM retained) for subsequent runtime PM cycles. */
+	panel->deep_sleep_mode = panel->controller_cfg->deep_sleep_mode_level1;
+
+	return drm_mode_config_helper_resume(drm);
+}
+
+static int ssd16xx_pm_runtime_suspend(struct device *dev)
+{
+	struct ssd16xx_panel *panel = to_ssd16xx_panel(dev_get_drvdata(dev));
+	int err = 0;
+
+	dev_dbg(dev, "runtime suspend: entering deep sleep mode 0x%02x\n",
+		panel->deep_sleep_mode);
+
+	ssd16xx_send_cmd(panel, SSD16XX_CMD_DEEP_SLEEP_MODE, &err);
+	ssd16xx_send_data(panel, panel->deep_sleep_mode, &err);
+	panel->initialized = false;
+
+	return err;
+}
+
+static int ssd16xx_pm_runtime_resume(struct device *dev)
+{
+	struct ssd16xx_panel *panel = to_ssd16xx_panel(dev_get_drvdata(dev));
+	int ret;
+
+	dev_dbg(dev, "runtime resume: initialized=%d%s\n",
+		panel->initialized,
+		!panel->initialized ? " (running hw_init)" : "");
+
+	/*
+	 * pm_runtime_suspend clears initialized after sending the deep sleep
+	 * command.  If a new app opens before the suspend fires (the put was
+	 * cancelled), initialized is still true and hw_init is unnecessary.
+	 */
+	if (!panel->initialized) {
+		ret = ssd16xx_hw_init(panel);
+		if (ret)
+			return ret;
+
+		panel->initialized = true;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops ssd16xx_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(ssd16xx_pm_suspend, ssd16xx_pm_resume)
+	RUNTIME_PM_OPS(ssd16xx_pm_runtime_suspend, ssd16xx_pm_runtime_resume, NULL)
+};
+
 static const struct of_device_id ssd16xx_of_match[] = {
 	{ .compatible = "gooddisplay,gdey042t81", .data = (void *)GDEY042T81 },
 	{ }
@@ -2535,6 +2717,7 @@ static struct spi_driver ssd16xx_spi_driver = {
 	.driver = {
 		.name = "ssd16xx",
 		.of_match_table = ssd16xx_of_match,
+		.pm = pm_ptr(&ssd16xx_pm_ops),
 	},
 	.probe = ssd16xx_probe,
 	.remove = ssd16xx_remove,
-- 
2.39.1

