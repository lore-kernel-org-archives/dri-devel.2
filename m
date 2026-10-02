Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3225BCA5FE5
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7264C10E695;
	Fri,  2 Oct 2026 19:01:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BXPqJb7v";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E39910F9BC;
 Fri,  2 Oct 2026 19:01:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnNnUWYNVsPPZOn+e0GANOE1tHjYoCCO2TwqmfZC3AKJ3ZHiZsbwLEAE7jm8HIb6xvjyUE72TH9+uYPktai3Fz+vOG7JsioXIibpIAWN2p11u0WZSf3hi9cmKGuZ8XRfympE0r1BaDtTgdz58q0EZzRaLx66nW5OZVjh+2j8jemn2VIAniH5ky2GJbRJuSw4DriCoq91oGs4UJmo089MJWuxa2udINmE2mAEXILlZvokIf3FsKzWtopRNYD/IQo0KFsG42ovT+8jwQXgPFiDpj/XwDVGKtiDrylcyskZ0KEbMHp4f+07VxebM6O6eshoRBS263qYaK+QXeDcd9vEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VblMuIFlG/lyMmQDTmnH7YtlyHlGoL3aoNqdD2nAILQ=;
 b=K5O1oWE9MoQ56YgS1oBgrIQNlwLcx37QUSFYm9WBwd2Ll7w20g7pnmImqmkzSOOQqxwzvCkDhQIeXAcTR3VClt5KPcKGbDrkSIuGrFG68a7S0HFDWEMTWwR7PC0O73Ig3ssigZDKZyi+a/tsl81iWsIiLMUE4u4g9JhMDLB84w60piC5KKbkwIuTmN85c/LyeSq5vPGvYrBH49ReUrBoc6T+st8AHHFuc68b8yy4sZI8lyflfAOMBSTGGuEmxdX2kzlSeOOR0aeVZAqQOF7Ns2D7dmY4Ii1aLvl+Meeio2dpRiqmbUixGTPpQtkEWEANP7SNrBs1bCOHCXvFqAOh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VblMuIFlG/lyMmQDTmnH7YtlyHlGoL3aoNqdD2nAILQ=;
 b=BXPqJb7v8OsRs8ySe1+qsV1jHMCujORAJdDyxD6zPrcPU5nGccf5OqcZXCe7Egf2mUy3TWCuvqvarCCOQlkp6H2F15lPKcexRgBbJDMVBk/RdoX3SK6KAMZOqhhu6SDKnp0HtTS0LU7HoSOisQ3hMSw5lOA7HQr5viu4zP7EPwg=
Received: from MW4PR03CA0010.namprd03.prod.outlook.com (2603:10b6:303:8f::15)
 by MW4PR12MB7118.namprd12.prod.outlook.com (2603:10b6:303:213::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:01:22 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::2d) by MW4PR03CA0010.outlook.office365.com
 (2603:10b6:303:8f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:01:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615D.mail.protection.outlook.com (10.167.249.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:22 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:20 -0500
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
Subject: [PATCH v9 16/21] drm/nouveau: add connector luminance support
Date: Fri, 2 Oct 2026 14:00:25 -0500
Message-ID: <20261002190030.211356-17-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|MW4PR12MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 59fb32a3-c836-4f06-514c-08df20b78d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: an2GIZI29bMMjnORfPyZe8Gcc6da+x2RrQ3l+nEAtnt7Ifbnfme+thV9q3ogkMH2RW4X6OSFSaFoip5bPPxNGSXaGRCwVhMIpFSSFgu9V+ZeJYnhU652d51jncCWtLR+KDPN4p1fftpBhTT7ZN1sN89oR73Wa4hw00alwML973N9LF1CfGnapByz2no9eieMwzQ8X/ypLpmv3pF6J8bWhueFx4cKmHpj2SNe0UoVg6hoyeNEGX21+lepvWQNq/nC0yZv27UDZaq+XqlaK1Q6uRvWTcZKuMkmtAPgMEt9D+OVDHPO2swUcgIyORM869vXh0ramhwtB1Xco0QvlSAkpJfcS2cWXhEWTpeSFf19UyZleaP22M2GOzrozIjZxObg+2ZsWNCEm37K3WR9uOieK+J3lrE5CdWcqsM9ebNU9pjFCHEXUkQ9REO3HFbLlOqqxWsQtJ4bs50XjqCf2GcKPlIyEZV8zJzFU5Fr7JCd++eppJe26h0IVBBiZfll0q9ZiWtcgQNLZO8j4CtQwcCO1s6OvDrxA4I5m25Dv2DV4zjO/RhkTu3EHSNlju5Obgrno1s9r1r2vT2hYFHiV7xdCD4frQs1uGHUtSI63u/feVgRZeHMEDRkUR7LlKlodClXayctaCgliAmVT8XXdbghCd1BHOH2mDF17e/aqVmVRVcuG/WWp/9mln4rOMCjucYa1uZJ5Sp7QAI4hXmFaGU1dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ou+MmtLKdCqvytaPucB74iLKeEswTVww8svr3rl4tW4BBZC/GOq6MNUwj222pKR1aWU3mwdd+KJoC9WUUL49bWMmd+1lhxIqZBLuauGQ2HSZO4SnKwqdAOi5KsuU5EJoRQMWVNYgvD9MgOhQooIHBbcjL2Jgt3hZIWvpYkQH4ZFmcL0RmwkxBMiZRqpyC7QPvCxij5tham7hDjLqZBoJasO9Dv5E/uvYe3DeFNLoqNc8bUlzRMvxAZONUzY7TnLUPX8kNHh3RwO3jboH+Pd9eIA+Ew6ZiA1w5HbUaLMczR2+CGBRXguKtZ8IqVOI9CyOe6eAU6f9dxu9UiYPYmt/VV4/fSdrmXDHLWfdcKn9MWb7Uj5lDsNOCDzePDVw3Tr7pOO2S7aGYDen6L98k0PjG6A7IjEWLuO2BytdL3KayXzpSoMOyqhkhZNm/RArkFZp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:22.6915 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59fb32a3-c836-4f06-514c-08df20b78d25
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7118
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

Expose Nouveau panel brightness through the connector LUMINANCE property
when DRM_LUMINANCE is enabled. Reuse the existing NV40, NV50, and DPCD
hardware paths while preserving the backlight class interface otherwise.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/nouveau/Kconfig             |   4 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |   2 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c | 110 ++++++++++++++++----
 drivers/gpu/drm/nouveau/nouveau_connector.c |   2 +
 drivers/gpu/drm/nouveau/nouveau_connector.h |  14 +++
 5 files changed, 108 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index 3b5757aed9c84..2dcb7c5344f48 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -17,13 +17,13 @@ config DRM_NOUVEAU
 	select DRM_SCHED
 	select I2C
 	select I2C_ALGOBIT
-	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT
+	select BACKLIGHT_CLASS_DEVICE if DRM_NOUVEAU_BACKLIGHT && !DRM_LUMINANCE
 	select X86_PLATFORM_DEVICES if ACPI && X86
 	select ACPI_WMI if ACPI && X86
 	select MXM_WMI if ACPI && X86
 	select POWER_SUPPLY
 	# Similar to i915, we need to select ACPI_VIDEO and it's dependencies
-	select BACKLIGHT_CLASS_DEVICE if ACPI && X86
+	select BACKLIGHT_CLASS_DEVICE if ACPI && X86 && !DRM_LUMINANCE
 	select INPUT if ACPI && X86
 	select THERMAL if ACPI && X86
 	select ACPI_VIDEO if ACPI && X86
diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index add19d479ebe4..3810083daefdc 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -1839,7 +1839,7 @@ nv50_sor_atomic_enable(struct drm_encoder *encoder, struct drm_atomic_commit *st
 		backlight = nv_connector->backlight;
 		if (backlight && backlight->uses_dpcd)
 			drm_edp_backlight_enable(&nv_connector->aux, &backlight->edp_info,
-						 backlight->dev->props.brightness);
+						 backlight->brightness);
 #endif
 
 		break;
diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
index da1ee24a2531d..fefcfa8c2a3a9 100644
--- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
+++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
@@ -73,12 +73,10 @@ nv40_get_intensity(struct backlight_device *bd)
 }
 
 static int
-nv40_set_intensity(struct backlight_device *bd)
+nv40_set_intensity_value(struct nouveau_encoder *nv_encoder, int val)
 {
-	struct nouveau_encoder *nv_encoder = bl_get_data(bd);
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
 	struct nvif_object *device = &drm->client.device.object;
-	int val = bd->props.brightness;
 	int reg = nvif_rd32(device, NV40_PMC_BACKLIGHT);
 
 	nvif_wr32(device, NV40_PMC_BACKLIGHT,
@@ -87,6 +85,12 @@ nv40_set_intensity(struct backlight_device *bd)
 	return 0;
 }
 
+static int
+nv40_set_intensity(struct backlight_device *bd)
+{
+	return nv40_set_intensity_value(bl_get_data(bd), bd->props.brightness);
+}
+
 static const struct backlight_ops nv40_bl_ops = {
 	.options = BL_CORE_SUSPENDRESUME,
 	.get_brightness = nv40_get_intensity,
@@ -105,6 +109,8 @@ nv40_backlight_init(struct nouveau_encoder *encoder,
 		return -ENODEV;
 
 	props->max_brightness = 31;
+	props->brightness = (nvif_rd32(device, NV40_PMC_BACKLIGHT) &
+			     NV40_PMC_BACKLIGHT_MASK) >> 16;
 	*ops = &nv40_bl_ops;
 	return 0;
 }
@@ -234,12 +240,15 @@ nv50_backlight_init(struct nouveau_backlight *bl,
 		    const struct backlight_ops **ops)
 {
 	struct nouveau_drm *drm = nouveau_drm(nv_encoder->base.base.dev);
+	int brightness;
+
+	brightness = nvif_outp_bl_get(&nv_encoder->outp);
 
 	/*
 	 * Note when this runs the connectors have not been probed yet,
 	 * so nv_conn->base.status is not set yet.
 	 */
-	if (nvif_outp_bl_get(&nv_encoder->outp) < 0 ||
+	if (brightness < 0 ||
 	    drm_helper_probe_detect(&nv_conn->base, NULL, false) != connector_status_connected)
 		return -ENODEV;
 
@@ -284,6 +293,7 @@ nv50_backlight_init(struct nouveau_backlight *bl,
 
 	*ops = &nv50_bl_ops;
 	props->max_brightness = 100;
+	props->brightness = brightness;
 	return 0;
 }
 
@@ -317,10 +327,13 @@ nouveau_backlight_init(struct drm_connector *connector)
 	bl = kzalloc_obj(*bl);
 	if (!bl)
 		return -ENOMEM;
+	bl->id = -1;
+	bl->encoder = nv_encoder;
 
 	switch (device->info.family) {
 	case NV_DEVICE_INFO_V0_CURIE:
 		ret = nv40_backlight_init(nv_encoder, &props, &ops);
+		bl->uses_nv40 = true;
 		break;
 	case NV_DEVICE_INFO_V0_TESLA:
 	case NV_DEVICE_INFO_V0_FERMI:
@@ -349,26 +362,39 @@ nouveau_backlight_init(struct drm_connector *connector)
 		goto fail_alloc;
 	}
 
-	if (!nouveau_get_backlight_name(backlight_name, bl)) {
-		NV_ERROR(drm, "Failed to retrieve a unique name for the backlight interface\n");
-		goto fail_alloc;
-	}
-
 	props.type = BACKLIGHT_RAW;
-	bl->dev = backlight_device_register(backlight_name, connector->kdev,
-					    nv_encoder, ops, &props);
-	if (IS_ERR(bl->dev)) {
-		if (bl->id >= 0)
-			ida_free(&bl_ida, bl->id);
-		ret = PTR_ERR(bl->dev);
-		goto fail_alloc;
+	bl->brightness = props.brightness;
+	bl->max_brightness = props.max_brightness;
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		ret = drm_connector_attach_luminance_property(connector, 0, props.max_brightness,
+							      props.brightness);
+		if (ret)
+			goto fail_alloc;
+	} else {
+		if (!nouveau_get_backlight_name(backlight_name, bl)) {
+			NV_ERROR(drm,
+				 "Failed to retrieve a unique name for the backlight interface\n");
+			goto fail_alloc;
+		}
+
+		bl->dev = backlight_device_register(backlight_name, connector->kdev,
+						    nv_encoder, ops, &props);
+		if (IS_ERR(bl->dev)) {
+			if (bl->id >= 0)
+				ida_free(&bl_ida, bl->id);
+			ret = PTR_ERR(bl->dev);
+			goto fail_alloc;
+		}
 	}
 
 	nouveau_connector(connector)->backlight = bl;
-	if (!bl->dev->props.brightness)
-		bl->dev->props.brightness =
-			bl->dev->ops->get_brightness(bl->dev);
-	backlight_update_status(bl->dev);
+	if (bl->dev) {
+		if (!bl->dev->props.brightness)
+			bl->dev->props.brightness =
+				bl->dev->ops->get_brightness(bl->dev);
+		bl->brightness = bl->dev->props.brightness;
+		backlight_update_status(bl->dev);
+	}
 
 	return 0;
 
@@ -396,7 +422,9 @@ nouveau_backlight_fini(struct drm_connector *connector)
 	if (bl->id >= 0)
 		ida_free(&bl_ida, bl->id);
 
-	backlight_device_unregister(bl->dev);
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE))
+		backlight_device_unregister(bl->dev);
+
 	nv_conn->backlight = NULL;
 	kfree(bl);
 }
@@ -412,3 +440,43 @@ nouveau_backlight_dtor(void)
 {
 	ida_destroy(&bl_ida);
 }
+
+void
+nouveau_backlight_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct nouveau_connector *nv_connector = nouveau_connector(conn_state->connector);
+	struct nouveau_backlight *bl = nv_connector->backlight;
+	unsigned int luminance = conn_state->luminance;
+
+	if (!bl || !bl->max_brightness)
+		return;
+
+	bl->brightness = luminance;
+	if (bl->uses_dpcd) {
+		drm_edp_backlight_set_level(&nv_connector->aux, &bl->edp_info,
+					    luminance);
+		return;
+	}
+
+	if (bl->uses_nv40)
+		nv40_set_intensity_value(bl->encoder, luminance);
+	else
+		nvif_outp_bl_set(&bl->encoder->outp, luminance);
+}
+
+void
+nouveau_backlight_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct nouveau_connector *nv_connector = nouveau_connector(conn_state->connector);
+	struct nouveau_backlight *bl = nv_connector->backlight;
+
+	if (!bl)
+		return;
+
+	if (bl->uses_dpcd)
+		drm_edp_backlight_disable(&nv_connector->aux, &bl->edp_info);
+	else if (bl->uses_nv40)
+		nv40_set_intensity_value(bl->encoder, 0);
+	else
+		nvif_outp_bl_set(&bl->encoder->outp, 0);
+}
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index cc3caf8de64b0..56ee579ea7909 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -1225,6 +1225,8 @@ nouveau_connector_helper_funcs = {
 	.mode_valid = nouveau_connector_mode_valid,
 	.best_encoder = nouveau_connector_best_encoder,
 	.atomic_check = nouveau_connector_atomic_check,
+	.set_luminance = nouveau_backlight_set_luminance,
+	.disable_luminance = nouveau_backlight_disable_luminance,
 };
 
 static const struct drm_connector_funcs
diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.h b/drivers/gpu/drm/nouveau/nouveau_connector.h
index eb292d2ba4bcd..0cee3e4c1d11c 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.h
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.h
@@ -50,9 +50,13 @@ struct nouveau_backlight {
 	struct backlight_device *dev;
 
 	struct drm_edp_backlight_info edp_info;
+	struct nouveau_encoder *encoder;
 	bool uses_dpcd : 1;
+	bool uses_nv40 : 1;
 
 	int id;
+	int brightness;
+	int max_brightness;
 };
 #endif
 
@@ -239,6 +243,8 @@ extern int nouveau_backlight_init(struct drm_connector *);
 extern void nouveau_backlight_fini(struct drm_connector *);
 extern void nouveau_backlight_ctor(void);
 extern void nouveau_backlight_dtor(void);
+void nouveau_backlight_set_luminance(const struct drm_connector_state *conn_state);
+void nouveau_backlight_disable_luminance(const struct drm_connector_state *conn_state);
 #else
 static inline int
 nouveau_backlight_init(struct drm_connector *connector)
@@ -257,6 +263,14 @@ nouveau_backlight_ctor(void) {
 static inline void
 nouveau_backlight_dtor(void) {
 }
+
+static inline void
+nouveau_backlight_set_luminance(const struct drm_connector_state *conn_state) {
+}
+
+static inline void
+nouveau_backlight_disable_luminance(const struct drm_connector_state *conn_state) {
+}
 #endif
 
 #endif /* __NOUVEAU_CONNECTOR_H__ */
-- 
2.43.0

