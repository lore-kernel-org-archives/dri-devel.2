Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5F8CA5FEC
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB3210F9EA;
	Fri,  2 Oct 2026 19:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fJItptgC";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1651810F9E0;
 Fri,  2 Oct 2026 19:02:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVAWG65PkBF8+VZKynkB/9grCo4dNb4EK9ZcgF35DU+yDvaNhJTtpvkpp/vIZ5YDm1grLtwQ0VIUhR+zlvYyYPpzJHgXMpd7ZQUGk7xNiWfuWnbmhzMsuTAC8LaDBsb3few/DSuc3AVqWo7EOWaiD8+3yKwRFR5nQrjTFJLhvYD4qybYXwU4aVC5DH+bQH7KSkQA4lsqQIZtrOswQnSPy+dvFwe2Kn1rFytnfCN7P5B/U6qgHYpRMHiUWP/s3B9Cfr9alFfIzt8OYRNt4hQO6NSO3NNIDHrQqXP6e8fb5OFdVm0NEI2LJFNwZsIlhA0prTQcKNM8DstqKDQ1QnZzmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/G4R0A85UtzLrPEumDeAEeXzg6NhUsjyoeO5M2/Bx0=;
 b=EVISodsWdidbcZQVSDqtP8PMv8Qs2LkrnoKKs+M6CnNeHq/rd5RF70XtndPYVeyYp6pAN68piXXr5AcD4yhWbygboLiFgQFZH/hNYCEPziGwqGK0Q+wB2iaAfSKyAUuH4HgQ/3+Q4vybPb2baeaIlY4v34NAGbm7czfc0WI8xSrLqjCcybJE30H3xFCryrL2tcElBfyajakn44LA6daBKgdahD1bmBnLuKddBcQJK74brgt/V+aGu3S82U5CT4z+Khw0cZ1xghDGleIpZnzhAuqDl5Bo1nBmH1zx95wd+CM6B3XwSfz9awx4gcUe6zU3GmocpUhK6+Lh0V4f8ZioUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/G4R0A85UtzLrPEumDeAEeXzg6NhUsjyoeO5M2/Bx0=;
 b=fJItptgC16aT/BoUhRIIzJHT/hi19rV/fZ9fvwaoBZ+eXu/VrHuDcksYXnOy8WUeXSUDtpBi+0+JufcUDEEz0NhXzsfchCzpO+hbsZRIWwyHSByjkOgF93jgAPVJ41cost3UlZW2FAUVrDrmQvIcI6KqcLVZCWC78rQ8uw/7nfs=
Received: from PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::19)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 19:01:56 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:32b:cafe::c) by PH7P220CA0048.outlook.office365.com
 (2603:10b6:510:32b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:01:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016160.mail.protection.outlook.com (10.167.249.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:55 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:25 -0500
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
Subject: [PATCH v9 20/21] drm/bridge: add PS8622 connector luminance support
Date: Fri, 2 Oct 2026 14:00:29 -0500
Message-ID: <20261002190030.211356-21-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 66aa3da3-9e15-41c7-0d44-08df20b7a0cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|1800799024|23010399003|376014|82310400026|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: v4ox/QFJ95eVGktJi0UNbPyXQEA5XplkvY1BMNVuN17iJ6Xi/1BpFDilsw696NjuRCHWY86rR3Ld9EBxkMbBn7CS32+hMrfmC0us5TGauBukGsBwW9hFKPI8UnqLLLg6JINmJmCgOWgrMxc7AEOhjr31b306RKO/vREmeyC0wPecOJImzQedCvZhiZ5vn1iRkXLathIAeOj+wS9POqGOf970z56yTa4oY4rI26v9WjzxsVEFQs61f4+47ny99QcgFww3T92N370M1Jbpl8o5MLzbVEWj+L3lPR7TOOmwoH8awRn80S5JlggWuDxCCo8N1V6KKolkjf/4DNpQACCcLq1ZuVS152RZnXMQfu+9+wt7gUELoWaDZ6cT1QB8YJpJhJc4B3IJLgg/guklVhmwpfJ5u+1FMLuCoImYfBaJgG526k1Ay2bHzuds9QQu1zeGEiDFcAsKLEh0Y+huv3e/yIkBT8wchOeBnQHp+vEgmj0Pc/ht3NQG/eedFoBHXg+TA/aqc3AJDF079gnyhEx+e2dZgrkvXL8fqban+h4IieajFVbezKXCdeaxJ1lC19ueXYbsIXOj72OuScplvnNC/rvN0lwvZKKk7qF79udFe3wDZKs/y9VMFyEdpiIXZZ6/5WIbsqRcSXQXiixDi+aNXLgFh7vg4NG7/brpJqKeivvTQg3hd9IySivBHkwVmvPInx1yCjxgM/i3hTy80xIJ4w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(1800799024)(23010399003)(376014)(82310400026)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +slbPXnoV1m4M3LFlphOwEnGQwKHVlFvk3AEBowRaboPS/NicnAswfxNmaMB44nYeY3e1sNdhSsq1aIXAesY5rVwgpEZCeQJnUTGK7jBRyXXYc5jMgjnsrVN7jR3xoflksgl6Y/VCwPKH81ihyEGiiDw2b3CnnoQIfJ6X6xnuUJeE3Y2/sfOYkEGBvdfPra8qikXKzXGDM3a517cRlvIbwWjwc8EodsDm83p44LeaD5fds+KUp/rpYw9Oz8rNqup+Bwl8We16sYryX3xjk2XwjDk5dYdFw/6bp4wjAge7wl3okuqpu0qM0v6cSXTGfjItUwClM3crqbtk695YzgrLFm2/U7I4Xa7PldnA3fdN51M4R9yNnstONnmZ3He7HcB9M9a7suQDv6gifU1BfjqmYE7faoCw5G38Pc/lReKPzajQRm3QrHUPwkHj7cGbtT1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:55.7513 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66aa3da3-9e15-41c7-0d44-08df20b7a0cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716
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

Expose PS8622 brightness through bridge luminance operations when
DRM_LUMINANCE is enabled. Keep registering the backlight class device
otherwise.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/bridge/Kconfig         |  2 +-
 drivers/gpu/drm/bridge/parade-ps8622.c | 45 +++++++++++++++++++-------
 2 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 837db36cdf48e..d78eb9f117d1e 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -278,7 +278,7 @@ config DRM_PARADE_PS8622
 	depends on OF
 	select DRM_PANEL
 	select DRM_KMS_HELPER
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	help
 	  Parade eDP-LVDS bridge chip driver.
 
diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 3a2ec482037df..229d9d7218c4e 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -45,6 +45,7 @@ struct ps8622_bridge {
 	struct drm_bridge *panel_bridge;
 	struct regulator *v12;
 	struct backlight_device *bl;
+	u8 brightness;
 
 	struct gpio_desc *gpio_slp;
 	struct gpio_desc *gpio_rst;
@@ -276,7 +277,7 @@ static int ps8622_send_config(struct ps8622_bridge *ps8622)
 
 		/* FFh for 100% brightness, 0h for 0% brightness */
 		err = ps8622_set(cl, 0x01, 0xa7,
-				ps8622->bl->props.brightness);
+				ps8622->brightness);
 		if (err)
 			goto error;
 	} else {
@@ -324,6 +325,8 @@ static int ps8622_backlight_update(struct backlight_device *bl)
 	struct ps8622_bridge *ps8622 = dev_get_drvdata(&bl->dev);
 	int ret, brightness = backlight_get_brightness(bl);
 
+	ps8622->brightness = brightness;
+
 	if (!ps8622->enabled)
 		return -EINVAL;
 
@@ -332,6 +335,15 @@ static int ps8622_backlight_update(struct backlight_device *bl)
 	return ret;
 }
 
+static void ps8622_set_luminance(struct drm_bridge *bridge,
+				 unsigned int luminance)
+{
+	struct ps8622_bridge *ps8622 = bridge_to_ps8622(bridge);
+
+	ps8622->brightness = luminance;
+	ps8622_set(ps8622->client, 0x01, 0xa7, luminance);
+}
+
 static const struct backlight_ops ps8622_backlight_ops = {
 	.update_status	= ps8622_backlight_update,
 };
@@ -438,6 +450,7 @@ static const struct drm_bridge_funcs ps8622_bridge_funcs = {
 	.atomic_disable = ps8622_disable,
 	.atomic_post_disable = ps8622_post_disable,
 	.attach = ps8622_attach,
+	.set_luminance = ps8622_set_luminance,
 };
 
 static const struct of_device_id ps8622_devices[] = {
@@ -502,18 +515,25 @@ static int ps8622_probe(struct i2c_client *client)
 		ps8622->lane_count = ps8622->max_lane_count;
 	}
 
+	ps8622->brightness = PS8622_MAX_BRIGHTNESS;
 	if (!of_property_read_bool(dev->of_node, "use-external-pwm")) {
-		ps8622->bl = backlight_device_register("ps8622-backlight",
-				dev, ps8622, &ps8622_backlight_ops,
-				NULL);
-		if (IS_ERR(ps8622->bl)) {
-			DRM_ERROR("failed to register backlight\n");
-			ret = PTR_ERR(ps8622->bl);
-			ps8622->bl = NULL;
-			return ret;
+		if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+			ps8622->bridge.ops |= DRM_BRIDGE_OP_LUMINANCE;
+			ps8622->bridge.luminance_max = PS8622_MAX_BRIGHTNESS;
+			ps8622->bridge.luminance = ps8622->brightness;
+		} else {
+			ps8622->bl = backlight_device_register("ps8622-backlight",
+							       dev, ps8622,
+							 &ps8622_backlight_ops, NULL);
+			if (IS_ERR(ps8622->bl)) {
+				DRM_ERROR("failed to register backlight\n");
+				ret = PTR_ERR(ps8622->bl);
+				ps8622->bl = NULL;
+				return ret;
+			}
+			ps8622->bl->props.max_brightness = PS8622_MAX_BRIGHTNESS;
+			ps8622->bl->props.brightness = ps8622->brightness;
 		}
-		ps8622->bl->props.max_brightness = PS8622_MAX_BRIGHTNESS;
-		ps8622->bl->props.brightness = PS8622_MAX_BRIGHTNESS;
 	}
 
 	ps8622->bridge.type = DRM_MODE_CONNECTOR_LVDS;
@@ -529,7 +549,8 @@ static void ps8622_remove(struct i2c_client *client)
 {
 	struct ps8622_bridge *ps8622 = i2c_get_clientdata(client);
 
-	backlight_device_unregister(ps8622->bl);
+	if (ps8622->bl)
+		backlight_device_unregister(ps8622->bl);
 	drm_bridge_remove(&ps8622->bridge);
 }
 
-- 
2.43.0

