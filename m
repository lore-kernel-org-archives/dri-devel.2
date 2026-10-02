Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56DECA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:02:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E65BA10F9DE;
	Fri,  2 Oct 2026 19:02:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c47uqBOn";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F8010F9D5;
 Fri,  2 Oct 2026 19:02:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kpz8dkRnGTWvKo3Dww75DZN2pbRMhZzP7uTu+aaI+xMglFKxhnA6b01kV3PiU77UTOqUalWQ6A3nJXDd/xOoId+P75bCjes8lXUni/ZlTDZvw3ZZbasHvBidi+TD1njPw3OeetkeqB3rT51GyklYbr8LiRHSwC5Veczmy+pycuKDQ/fSeBwVm9seQbKd0jxxtlIXFBzkyazN87Bw4aqYdj59Fit5pSLtgtdlCe+EN3NG9lVZRSspDzv4b10sGO06pGGC6bwAeoZW+j0Z/MPuXXFHdESKoz+njExbx9IS3qEKgIfH0E29YhOzSufxwnndd5+FYxCl/FwD3NTqTzQ5eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTYAHfBvxj59O0SB0AiKb0VjjVanv8gqHLY86+4UYmI=;
 b=iJpXK7WZNm8LlDEApjoSGUG1EcE3SmbiN2EVu3VK5TDbewnAY6nJO6BDZf6zY2bOgNTNk75e72xE4BcKJHavN4lyD3+ez2sR3DgRhI5+4ntPpaIWzv5bOrfgvZJjM9l6stOYuCV1S5VqXt9r1lq5Qed9a2wT6PTu9dVuBgawN6iBq3Pithr9JPVeKdwnSZ9NR3EwQV8ytRa33QLnh5NOVU9/mW4GVoACbAbmEYYptPdudsQEj5BmCAOptfzSAabIt8lY8aWYLC9L0NKgKcV1mx0Kq3LD9dDGkqRfQKxavDJnTWf+RXsn0geHTbFHdYIfvlJ5aEz+LZNXobc2TztSZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTYAHfBvxj59O0SB0AiKb0VjjVanv8gqHLY86+4UYmI=;
 b=c47uqBOnp5GqYy+jH0umQabWuT+ZEnnZpiR94wfG4uw6SrZ9JS10gVHuNdqtrPSezk9tbPW2XbEbW6ZfOo2uR7QzOQl8Gu0rwVd4BXXQeO1DOEFeVV38f2IKSzgdvrCGXqOMxppIvEITzGbxFkpjgWBBRngdREiVgEy919QQsjg=
Received: from PH8P220CA0032.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::10)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:01:55 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:348:cafe::5d) by PH8P220CA0032.outlook.office365.com
 (2603:10b6:510:348::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:01:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615B.mail.protection.outlook.com (10.167.249.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:54 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:24 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v9 19/21] drm/gma500: add connector luminance support
Date: Fri, 2 Oct 2026 14:00:28 -0500
Message-ID: <20261002190030.211356-20-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002190030.211356-1-mario.limonciello@amd.com>
References: <20261002190030.211356-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: f18aeacc-80d2-4000-625e-08df20b7a005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|7416014|376014|36860700016|56012099006|10067099003|11063799006|18002099003|22082099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: PxFW4v8hnQ0ch4AI3P3myWqMNcj1jgxjsdZQD29t+aFH/uJuuMiUbb7T5vlByNvMuFQGgDNaJDgfo6V9xckfNqeyhDZfBSOytUsbTdkGRnEAvps5jKpa7CobwaraQaxsvUg47wMgWFOxvYHMXyyLfbP+nhgQTZ6j9SX4o8Cw8Fj1VsVzRsA+LTrQba2ZvS0Ba9UUlgWccg20b+4HodGIBlZ4VsaW1kgZaIh1qoL6vXv2L5mcvUIuHI1s08APOuxCESBqPrEK60oCHqXpiGHXyewKr+ebGeP70B1XX+tcxRp+OHgxOuCl+WEUd9VouYfOduBn5ddKmI6sZoboeKwjK4mEA8klz09gEOzMQJbvcaJtgATTAH6b/qjD3dxhMo8HRC3x1ziIVXN548EUzQ9XSzX+jdM4yLcsDK+k+7/rh465LMTC3krJKEfyU0lZyxWiYYUaE2Mz/1bcCBJnewxv1s4s8AqhMXUpUKRBccEvV8cPb/n/w9XHJWnKE6EDNBfZwlbs74C9N864JVmMkViigCFJjYXP90yV9oN5OJWK1EgWsSru4lRZdQw8ifsv9K/q+SlRc+rKdAjzcJjyuLVRLhaSL+6ervnO3uK/qBn+GXaYC0rn8xzK4/rnEN4UtSROAesMqM6M3AHjNaEdieb6rCIuLPoY3bXkUw1p6eD+9rKgz0ElPqW6TFlsS/SMK7qGy46+n5NqsBKHJAd2Z5e1Sw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(7416014)(376014)(36860700016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6jr43SPxOPHuHft1MB6609vOmUwU8iQin8fPvI828E1gX4o+2joStg0YZo6RaADUi9Q/keZRiQYSJWeFd9z5uLXUZx48n9SoMkZgDsc59ppqtFG6hxxebwNeergFxotjG63BUn+1TIXI9XgutwoizvXKRe/jNJWODrSWS0h8Twc/GBvkCAuzsxfFACm0VC4+17kvxgrt73moZs4hRzol5gMMMVyGHZGXkGrwjXCgZuxHG1fmtero47pYazUa7LXHvYGu4PBZLFkoQvUnK45FbRJPR9mYFgBlT3sD3/iQUlUQ3uZq6zWpvTTONv/0dQiI4W2DOeDiT+eHJkbmrw9muxiu8kk36cAp4AmY2SujUw/L8kt1BeodGop59hmq6X8nIAdyzwB3LkMMj14fpg+QXFxgfg8DObTltHhmrzFR9rvY++9aAckBmj5oRN9rQgXH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:54.4614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f18aeacc-80d2-4000-625e-08df20b7a005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

Expose GMA500 panel brightness through the connector LUMINANCE property
when DRM_LUMINANCE is enabled. Route updates through the existing platform
backlight operations and preserve legacy registration otherwise.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/gma500/Kconfig          |  2 +-
 drivers/gpu/drm/gma500/backlight.c      | 45 ++++++++++++++++---------
 drivers/gpu/drm/gma500/cdv_intel_lvds.c |  2 ++
 drivers/gpu/drm/gma500/psb_drv.c        |  2 +-
 drivers/gpu/drm/gma500/psb_drv.h        |  4 ++-
 drivers/gpu/drm/gma500/psb_intel_lvds.c |  3 +-
 6 files changed, 38 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
index a2acaa699dd58..72b14a7d07d5c 100644
--- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -9,7 +9,7 @@ config DRM_GMA500
 	select I2C_ALGOBIT
 	# GMA500 depends on ACPI_VIDEO when ACPI is enabled, just like i915
 	select ACPI_VIDEO if ACPI
-	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select BACKLIGHT_CLASS_DEVICE if ACPI && !DRM_LUMINANCE
 	select INPUT if ACPI
 	select X86_PLATFORM_DEVICES if ACPI
 	select ACPI_WMI if ACPI
diff --git a/drivers/gpu/drm/gma500/backlight.c b/drivers/gpu/drm/gma500/backlight.c
index c8f1716a12d52..4bb39fba04539 100644
--- a/drivers/gpu/drm/gma500/backlight.c
+++ b/drivers/gpu/drm/gma500/backlight.c
@@ -8,7 +8,6 @@
  */
 
 #include <linux/backlight.h>
-
 #include <acpi/video.h>
 
 #include <drm/drm_print.h>
@@ -73,10 +72,9 @@ static const struct backlight_ops gma_backlight_ops __maybe_unused = {
 	.update_status  = gma_backlight_update_status,
 };
 
-int gma_backlight_init(struct drm_device *dev)
+int gma_backlight_init(struct drm_device *dev, struct drm_connector *connector)
 {
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
-	struct backlight_properties props __maybe_unused = {};
 	int ret;
 
 	dev_priv->backlight_enabled = true;
@@ -92,28 +90,43 @@ int gma_backlight_init(struct drm_device *dev)
 		return 0;
 	}
 
-#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
-	props.brightness = dev_priv->backlight_level;
-	props.max_brightness = PSB_MAX_BRIGHTNESS;
-	props.type = BACKLIGHT_RAW;
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE))
+		return drm_connector_attach_luminance_property(connector, 0,
+							 PSB_MAX_BRIGHTNESS,
+							 dev_priv->backlight_level);
+
+	{
+		struct backlight_properties props = {};
 
-	dev_priv->backlight_device =
-		backlight_device_register(dev_priv->ops->backlight_name,
-					  dev->dev, dev,
-					  &gma_backlight_ops, &props);
-	if (IS_ERR(dev_priv->backlight_device))
-		return PTR_ERR(dev_priv->backlight_device);
-#endif
+		props.brightness = dev_priv->backlight_level;
+		props.max_brightness = PSB_MAX_BRIGHTNESS;
+		props.type = BACKLIGHT_RAW;
+
+		dev_priv->backlight_device =
+			backlight_device_register(dev_priv->ops->backlight_name,
+						  dev->dev, dev,
+						  &gma_backlight_ops, &props);
+		if (IS_ERR(dev_priv->backlight_device))
+			return PTR_ERR(dev_priv->backlight_device);
+	}
 
 	return 0;
 }
 
+void gma_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	gma_backlight_set(conn_state->connector->dev, conn_state->luminance);
+}
+
+void gma_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	gma_backlight_disable(conn_state->connector->dev);
+}
+
 void gma_backlight_exit(struct drm_device *dev)
 {
-#ifdef CONFIG_BACKLIGHT_CLASS_DEVICE
 	struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
 
 	if (dev_priv->backlight_device)
 		backlight_device_unregister(dev_priv->backlight_device);
-#endif
 }
diff --git a/drivers/gpu/drm/gma500/cdv_intel_lvds.c b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
index 336ab411d6995..cef97f1532358 100644
--- a/drivers/gpu/drm/gma500/cdv_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/cdv_intel_lvds.c
@@ -412,6 +412,8 @@ static const struct drm_connector_helper_funcs
 	.get_modes = cdv_intel_lvds_get_modes,
 	.mode_valid = cdv_intel_lvds_mode_valid,
 	.best_encoder = gma_best_encoder,
+	.set_luminance = gma_connector_set_luminance,
+	.disable_luminance = gma_connector_disable_luminance,
 };
 
 static const struct drm_connector_funcs cdv_intel_lvds_connector_funcs = {
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index d17cb5b4a4bf2..5de7af651ac39 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -396,7 +396,7 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
 
 		if (gma_encoder->type == INTEL_OUTPUT_LVDS ||
 		    gma_encoder->type == INTEL_OUTPUT_MIPI) {
-			ret = gma_backlight_init(dev);
+			ret = gma_backlight_init(dev, connector);
 			if (ret == 0)
 				acpi_video_register_backlight();
 			break;
diff --git a/drivers/gpu/drm/gma500/psb_drv.h b/drivers/gpu/drm/gma500/psb_drv.h
index db197b865b90a..4fc22c66e6c8f 100644
--- a/drivers/gpu/drm/gma500/psb_drv.h
+++ b/drivers/gpu/drm/gma500/psb_drv.h
@@ -604,11 +604,13 @@ int psb_fbdev_driver_fbdev_probe(struct drm_fb_helper *fb_helper,
 #endif
 
 /* backlight.c */
-int gma_backlight_init(struct drm_device *dev);
+int gma_backlight_init(struct drm_device *dev, struct drm_connector *connector);
 void gma_backlight_exit(struct drm_device *dev);
 void gma_backlight_disable(struct drm_device *dev);
 void gma_backlight_enable(struct drm_device *dev);
 void gma_backlight_set(struct drm_device *dev, int v);
+void gma_connector_set_luminance(const struct drm_connector_state *conn_state);
+void gma_connector_disable_luminance(const struct drm_connector_state *conn_state);
 
 /* oaktrail_crtc.c */
 extern const struct drm_crtc_helper_funcs oaktrail_helper_funcs;
diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
index cd882786d9461..fa0bc8492ff7f 100644
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -610,6 +610,8 @@ const struct drm_connector_helper_funcs
 	.get_modes = psb_intel_lvds_get_modes,
 	.mode_valid = psb_intel_lvds_mode_valid,
 	.best_encoder = gma_best_encoder,
+	.set_luminance = gma_connector_set_luminance,
+	.disable_luminance = gma_connector_disable_luminance,
 };
 
 const struct drm_connector_funcs psb_intel_lvds_connector_funcs = {
@@ -808,4 +810,3 @@ void psb_intel_lvds_init(struct drm_device *dev,
 err_free_encoder:
 	kfree(gma_encoder);
 }
-
-- 
2.43.0

