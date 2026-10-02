Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CE2CA5FEB
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 445E010F9E2;
	Fri,  2 Oct 2026 19:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lgXUhGaZ";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64E2410F9DE;
 Fri,  2 Oct 2026 19:02:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5sCyhxHJq8ZP+MbgAYfrVE6iP8XhJE0AFjtjugj2AkHIENHeLA0QYpJ7mmlQ/NuAtvzHzWwBjQgR7/eMLZRrVzyqxxt7P8splrm2DQTxCKo1fuugcFhNnOsvWWh1k5xpyp6ig6bkrjjLL5QInUJkIdU1zeTeo7Hz1q97O1oCtM+EfBPZjLRmgwzPahU5tHjpWZbIsNi2rrUQ9dQFA+xiBimElzcpD9iJJAV7pDbeAHFiklnG+GHjATvhaSXQNpH881jQrW+60z9eArGg+ifTQeE+DH97D95iTkyLYUYI85Cows4JB7cCZdmCyE9LzbJUBDaCT1O59eEUj1j6H/ERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s628hrZ71BPsBGVoLoq6CtvqdB/jbf+ci5Nxw/e4Lio=;
 b=o/L/S26CZt+h5IJsuKx39kPj+hBPBEqi4xOJMR0NH5Qvd2pe2UnvaZFXRIZ/VB/6OZS1lQ/zxz+16gF7m1l3PPreKBQ0V8CEV1R2yTx+nEEZCFuGa1DvCVas/g6tgdlzkLt79s2uRcuA0X8OisCYSmW0CaeEqfzBnPMGL4/udVyMJNJtkk1OtS1Xjv0D//VkwzM0j48rWUqkvkmyi/HtNxug0qWpPjqW3/3hBfQRGXdIYNHFms4WeJNtGMf4ZIwtdlV+PiKzYHtyg4zIxpZtdbtM63ejIfnMVvwzjmKPeJ/yZDBWwxFJd0Zg9ZDYiuSZ9hqSKJOpl+MuUHJc/s93qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s628hrZ71BPsBGVoLoq6CtvqdB/jbf+ci5Nxw/e4Lio=;
 b=lgXUhGaZMMDpcAkeVUq1KaaY7+mSMqpj2/275RdmuZZ3GkXWOiEbvsszwd2KGTzeqrPZCQfpLIXikQqvzOHF4hMt0+dUqqg+W1arpQ8ai1dnrnHcd1R3wzoMSSlZt+HaWODVcoRJ35S4kY+ohh7Di+OSx1raP2JihdY3USa9Wz4=
Received: from PH8P220CA0033.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:348::11)
 by DS4PR12MB9770.namprd12.prod.outlook.com (2603:10b6:8:29d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:01:57 +0000
Received: from MW1PEPF0001615B.namprd21.prod.outlook.com
 (2603:10b6:510:348:cafe::8) by PH8P220CA0033.outlook.office365.com
 (2603:10b6:510:348::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:01:57 +0000
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
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:56 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:26 -0500
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
Subject: [PATCH v9 21/21] drm/solomon: add SSD130x connector luminance support
Date: Fri, 2 Oct 2026 14:00:30 -0500
Message-ID: <20261002190030.211356-22-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615B:EE_|DS4PR12MB9770:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f0d25dd-8201-4ae3-4304-08df20b7a17d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|7416014|82310400026|1800799024|376014|6133799003|11063799006|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: j3aLRSGFgBtgkUucs7yzZkw11LZy7b6FylF8e4lCjXYxMIo+nDZlk9Y5rqWi1lpp/VCnQ7QEEz+GFqstuM8yoi6LG2mIKoGZuWaJss54UeRrULlh0SBgGVGCM8HhsMrngyfcchRo91nU7LkyE4FtTDtirCF1vL2bB/Hqw7ZlPVlUahJeM/AeMC4fnEaUhvLh56lI48TuR1HTTFblxb1NRuKW+J9QmdU3LpuOnWb0ehgrugv5ptfWHiFreRmYeTwK5DV3o3/kwaY8MQihhmdUFJ9e8w30aT968L3an8MEHUJ0VWK9jK7RyrNHVrDPN0bJr4t3Z8r+6XFTfOpJJn1q7W2B13fcdS9zMxeJ0xhcORkB0kGAXMbtAzQ88A27W6f8vsWnVVvIesU6JK5W1E8/JTXM/6rY5XBJk+izYv12B74gWTCub8P1ZIMWNQYy7bfTEvXfkeOd3ZAWpdFRZ7xeSpLhu9l2/8sRyEtaiijxpXhpd2qMAwMqF1PcdAmbU0pu6ivlNxnysCO0r51t50brkJFmkWAieFQZrd1wqxZaVy+jYrmfks5Eoy1+d/vgpGFcpeWqT2Xi3G9O3t2+WhXwJRQX23HUgFCNwczJ7Uq884uqcXtsqshwW6FKvf4TZ2WoFm/03VD0eE4/2mW8SvgJTknQ8rKimcl28jyMHQc0h3REuxyL7x9bNGGSABHK04y/+jkRVms4uZ1aAYEHI1bRLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(7416014)(82310400026)(1800799024)(376014)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MonugbOm1jI61EuSa2UtUOlBm4q35tI4AovoxYKMNcjgm6Z09s328kEw7hYEoqt2fMuzMH69zVkxN9/O4QqYOTttZhU/8+xP6VpP7vVG2tZ5D14dhzADfqxpxtLHOl9M5rhOb4votXzoNyyiNr2v/D+hS8dm+bT5C9qP3ckQsnrG7zZVPgVqo9k1Bqt6EouFPmAaciNXPS3YSkd0gVWsJc5hNLd7Le94v4f3kvQbTTeS9PgUzi4eV4hPntiWJdr2CFD+K03XzUNoCqMZwdvyNuROFf/x0DoMrFZX189PLb4MatEHEr5gqChqR4Hczm1e+nFFJgv9Z3lbPg8qnKpdqGLz8Y6mv01mrCBgakmx4rlNAYlO/pFpkmxn1dInQorTVsAU0sX/atS/rSI5P48uwCip0WsxUdHAwysQZ2Zsoma7VsPtWeL4LPHNTgg7F349
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:56.9232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f0d25dd-8201-4ae3-4304-08df20b7a17d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9770
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

Expose SSD130x contrast through the connector LUMINANCE property when
DRM_LUMINANCE is enabled. Program contrast directly and retain the
backlight class interface otherwise.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/solomon/Kconfig   |  2 +-
 drivers/gpu/drm/solomon/ssd130x.c | 79 +++++++++++++++++++++++--------
 2 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/solomon/Kconfig b/drivers/gpu/drm/solomon/Kconfig
index 400a6cab3a671..f0d52bc71cdfc 100644
--- a/drivers/gpu/drm/solomon/Kconfig
+++ b/drivers/gpu/drm/solomon/Kconfig
@@ -1,7 +1,7 @@
 config DRM_SSD130X
 	tristate "DRM support for Solomon SSD13xx OLED displays"
 	depends on DRM && MMU
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 324467ae9309f..8aec74ecdcb6d 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -1831,7 +1831,8 @@ static void ssd130x_encoder_atomic_enable(struct drm_encoder *encoder,
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
-	backlight_enable(ssd130x->bl_dev);
+	if (ssd130x->bl_dev)
+		backlight_enable(ssd130x->bl_dev);
 
 	return;
 
@@ -1857,7 +1858,8 @@ static void ssd132x_encoder_atomic_enable(struct drm_encoder *encoder,
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
-	backlight_enable(ssd130x->bl_dev);
+	if (ssd130x->bl_dev)
+		backlight_enable(ssd130x->bl_dev);
 
 	return;
 
@@ -1882,7 +1884,8 @@ static void ssd133x_encoder_atomic_enable(struct drm_encoder *encoder,
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
-	backlight_enable(ssd130x->bl_dev);
+	if (ssd130x->bl_dev)
+		backlight_enable(ssd130x->bl_dev);
 
 	return;
 
@@ -1907,7 +1910,8 @@ static void ssd135x_encoder_atomic_enable(struct drm_encoder *encoder,
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_ON);
 
-	backlight_enable(ssd130x->bl_dev);
+	if (ssd130x->bl_dev)
+		backlight_enable(ssd130x->bl_dev);
 
 	return;
 
@@ -1921,7 +1925,8 @@ static void ssd130x_encoder_atomic_disable(struct drm_encoder *encoder,
 	struct drm_device *drm = encoder->dev;
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
 
-	backlight_disable(ssd130x->bl_dev);
+	if (ssd130x->bl_dev)
+		backlight_disable(ssd130x->bl_dev);
 
 	ssd130x_write_cmd(ssd130x, 1, SSD13XX_DISPLAY_OFF);
 
@@ -1958,8 +1963,44 @@ static int ssd130x_connector_get_modes(struct drm_connector *connector)
 	return drm_connector_helper_get_modes_fixed(connector, &ssd130x->mode);
 }
 
+static int ssd130x_set_luminance_value(struct ssd130x_device *ssd130x,
+				       unsigned int luminance)
+{
+	int ret;
+
+	ssd130x->contrast = luminance;
+
+	switch (ssd130x->device_info->family_id) {
+	case SSD133X_FAMILY:
+		return ssd133x_set_contrast(ssd130x, luminance);
+	case SSD135X_FAMILY:
+		return ssd135x_set_contrast(ssd130x, luminance);
+	default:
+		ret = ssd130x_write_cmd(ssd130x, 1, SSD13XX_CONTRAST);
+		if (ret < 0)
+			return ret;
+		return ssd130x_write_cmd(ssd130x, 1, luminance);
+	}
+}
+
+static void ssd130x_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(conn_state->connector->dev);
+
+	ssd130x_set_luminance_value(ssd130x, conn_state->luminance);
+}
+
+static void ssd130x_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct ssd130x_device *ssd130x = drm_to_ssd130x(conn_state->connector->dev);
+
+	ssd130x_set_luminance_value(ssd130x, 0);
+}
+
 static const struct drm_connector_helper_funcs ssd130x_connector_helper_funcs = {
 	.get_modes = ssd130x_connector_get_modes,
+	.set_luminance = ssd130x_connector_set_luminance,
+	.disable_luminance = ssd130x_connector_disable_luminance,
 };
 
 static const struct drm_connector_funcs ssd130x_connector_funcs = {
@@ -1996,20 +2037,9 @@ static const struct drm_driver ssd130x_drm_driver = {
 static int ssd130x_update_bl(struct backlight_device *bdev)
 {
 	struct ssd130x_device *ssd130x = bl_get_data(bdev);
-	int brightness = backlight_get_brightness(bdev);
-	int ret;
-
-	ssd130x->contrast = brightness;
-
-	ret = ssd130x_write_cmd(ssd130x, 1, SSD13XX_CONTRAST);
-	if (ret < 0)
-		return ret;
 
-	ret = ssd130x_write_cmd(ssd130x, 1, ssd130x->contrast);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ssd130x_set_luminance_value(ssd130x,
+					  backlight_get_brightness(bdev));
 }
 
 static int ssd133x_update_bl(struct backlight_device *bdev)
@@ -2030,7 +2060,7 @@ static int ssd135x_update_bl(struct backlight_device *bdev)
 	return ssd135x_set_contrast(ssd130x, ssd130x->contrast);
 }
 
-static const struct backlight_ops ssd130xfb_bl_ops[] = {
+static const struct backlight_ops ssd130xfb_bl_ops[] __maybe_unused = {
 	[SSD130X_FAMILY] = {
 		.update_status	= ssd130x_update_bl,
 	},
@@ -2191,6 +2221,13 @@ static int ssd130x_init_modeset(struct ssd130x_device *ssd130x)
 	}
 
 	drm_connector_helper_add(connector, &ssd130x_connector_helper_funcs);
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		ret = drm_connector_attach_luminance_property(connector, 0,
+							      MAX_CONTRAST,
+							     ssd130x->contrast);
+		if (ret)
+			return ret;
+	}
 
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret) {
@@ -2223,7 +2260,9 @@ static int ssd130x_get_resources(struct ssd130x_device *ssd130x)
 struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 {
 	struct ssd130x_device *ssd130x;
+#ifndef CONFIG_DRM_LUMINANCE
 	struct backlight_device *bl;
+#endif
 	struct drm_device *drm;
 	int ret;
 
@@ -2248,6 +2287,7 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 	if (ret)
 		return ERR_PTR(ret);
 
+#ifndef CONFIG_DRM_LUMINANCE
 	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ssd130x,
 					    &ssd130xfb_bl_ops[ssd130x->device_info->family_id],
 					    NULL);
@@ -2258,6 +2298,7 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 	bl->props.brightness = ssd130x->contrast;
 	bl->props.max_brightness = MAX_CONTRAST;
 	ssd130x->bl_dev = bl;
+#endif
 
 	ret = ssd130x_init_modeset(ssd130x);
 	if (ret)
-- 
2.43.0

