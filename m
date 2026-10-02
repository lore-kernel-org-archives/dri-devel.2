Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FC5CA5FEC
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBAD10F9D6;
	Fri,  2 Oct 2026 19:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VcWtC1Gm";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010049.outbound.protection.outlook.com [52.101.85.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D98AE10F9BF;
 Fri,  2 Oct 2026 19:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxtTp40Opbt7TON65hm/1rqqZAC+3w2+DsSTa2HbHhsbhtGEmmxfgD69dD9i8t0ABY/gSM+YzBQEu9ZwpfvSyz+026L2++IpB1iNU2/EMvmo8G8PQ3WqTG4YwIzyHqUS0fFmtFAv2yl7Bn1INJjdyoEK51g296HMyvNArbh3waYwYntXtUzEHuKrYYS6vv2vWKq+s/N/XIUe9LZZ5LUH51jH1dd4h9ziHAwlDWw4GO1vZ/R8sfCPYXxlJaDpyvi814xlJPG8a44dr8np+F+95KorqC3dwWGByXqkEtBYuU9Xw/EYV1Nsce0wcs0yytMNuD5g5SLNQhTZZ7c1ouZL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KNmod+COQ2QvncxIpwT3mwalyPT0f5crUyTxrRvpkM=;
 b=sFTo4OoYe7DW202SZrMLvd/MVpozuaj8qSFAV/J1TdkaJzCbhV+1PBxBXcPynv5Asu4v2am8jjEFOh5TSeZfLmDiDA3qZn4xlomv2I6rPVi5oU30vDgu1kriTBe9XHe1GxxFq/EdqdlMM4PhnWaWbS8HdsPVGJKOmmajSu9gALUb9aZfCXfC9alSt54oYOmMAHCDfe7vTh0CWRtIPhQnC4UtDiN5Ka1q7xJPQ2zvoinuMbM0dKD81cV73UsrfpEVjPTrPsW7es6EiRJwAaChMwNHVeQcm65Dw5tK9NW6423T249nnHICqjj4ZVpukqR8YOJmB4APrurZnzK3g331sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KNmod+COQ2QvncxIpwT3mwalyPT0f5crUyTxrRvpkM=;
 b=VcWtC1GmoaHNVJr+UndQbxat1UdtICIsa7l0SN7GSM0v7LlY7FYO/R0SGFgGRXUXoSYsERB3c/07P8E1knKa+bAMxrfEXF/xMyhfdF7aZbfKtxGA+rnQ44sfRR32mbxL8sSQzUhxOcuA62P+Sh4s1XTjqHpRSzUId2QIGjt6sVM=
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by SJ1PR12MB6171.namprd12.prod.outlook.com (2603:10b6:a03:45a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Fri, 2 Oct
 2026 19:01:25 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::1d) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:01:25 +0000
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
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:25 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:23 -0500
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
Subject: [PATCH v9 18/21] drm/radeon: add connector luminance support
Date: Fri, 2 Oct 2026 14:00:27 -0500
Message-ID: <20261002190030.211356-19-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|SJ1PR12MB6171:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7a71c4-a709-4ccf-290d-08df20b78e77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|6133799003|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kTMD9Yji6pqA79jGAu2yKpC6Cqmxjjqd7v3/oMkZ6SwNN5Lei6ctyB9YkjY3Z1LtPZ+1uHYhJqz5UgqsVY9uQN/8YWFTieXCb+khwBmz+Xm2rcOvzWA7vDc9E/APDtX0JRrNPCGMQ5VPYNg3h/T89QKKGfY3xllAZgq9NKBSsETRW/d7QVAba+7AF7867mrQrR043feYrE77gFiETwDm6+1acOMrXmmKvmYwDnFeA2padrprPWGsUu9j/1GHclsxLz2jaHxQY8gpqRTrpHFZL3Az/mqFUnYiw6T7BhcP+kI58IN6q/rSbyPt1d/lWGlkZZzjVhZRUdIiVR2/FttgV+ce3rOET6vEpbohtI1uwL8gwRZWh1gvuvNlrYKhY4YwZDSj66IpoYO8elR2bS+CbKz82/kA87xHLhFj51jBCJjIczYC2WqYG9YO3ZGFU+1Isu48sgBnUeV3rAylojhbJ+kq5m10ZJgMZEQw4jVig/AmbE3y3URUI0WjUfCntFgbICHm4VCxxFc07iveacpvcW7iGF2ePp85WL77p8cWyE1z6MLObhp4jYBd5mrxTAWaydS0Xtg2KkwpyFmsFFnEipM4oNIJdUvnV2yBCBW2IUbf7dpLxh6DNJJqedFAwmHFfmvwBif9ONbqiP+8L7mD8Zs5HALQlfaLX9uLeNanoynrStFedP85d4CyOvGvEhWzWVmTLznKECgOOzx68zSg6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(6133799003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MpTB6sVJtDoPyNDPur8TZmkvLlLrPrvFsKMBOYn0ROEUeeQhWD9nX2SuaYeljivlIY7uE1Cp0gr6i8DJltcF8R+zh9JNRzVp7OUS3ErN0sRUqcNPHQFafM8Xb/+Kbo0Lr1ZpLlCaIPfB5IWutw8j67WJu3t7cjvVgQ+rfqao8syqiA7eqUBqr4HHLGqQmJC2kD3K/PwT8w1e/8XUzVHuz/uVB1Zv5k32L6jB9Wyu7i6V2tDLo4RU88e3XKkvniINBy/G8rHET+p0Y4liQGchy9BwdsZax902aXYFBFlpoodl8bngJVAdJh1jW10BB/dhfapnHA5LvZyFxOrAmbR8aLlIbmEg3NGoTf0a1ycyyUkhIKp9s2SGjzcuOW73+vDnIQiVz3+r0ibbkTPrbJQeiWRjYn9wM37wLTmFXFkMDwuiyIfiBcHuee8AUGy36SUE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:25.0086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7a71c4-a709-4ccf-290d-08df20b78e77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6171
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

Expose Radeon panel brightness through the connector LUMINANCE property
when DRM_LUMINANCE is enabled. Reuse the AtomBIOS and legacy hardware
programming paths and preserve the backlight class interface otherwise.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/radeon/Kconfig                |  2 +-
 drivers/gpu/drm/radeon/atombios_encoders.c    | 32 ++++++++++--
 drivers/gpu/drm/radeon/radeon_connectors.c    | 34 +++++++++++++
 .../gpu/drm/radeon/radeon_legacy_encoders.c   | 49 +++++++++++++++----
 drivers/gpu/drm/radeon/radeon_mode.h          |  2 +
 5 files changed, 106 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kconfig
index c479f0c0dd5c4..cfb0679066a12 100644
--- a/drivers/gpu/drm/radeon/Kconfig
+++ b/drivers/gpu/drm/radeon/Kconfig
@@ -17,7 +17,7 @@ config DRM_RADEON
 	select SND_HDA_COMPONENT if SND_HDA_CORE
 	select POWER_SUPPLY
 	select HWMON
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	select INTERVAL_TREE
 	select I2C
 	select I2C_ALGOBIT
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 5b9c72bf40994..e6f762625bf1a 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -227,6 +227,27 @@ void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
 	memset(&props, 0, sizeof(props));
 	props.max_brightness = RADEON_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
+	pdata->encoder = radeon_encoder;
+	pdata->atom = true;
+	radeon_encoder->backlight_priv = pdata;
+
+	dig = radeon_encoder->enc_priv;
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		props.brightness = atombios_get_backlight_level(radeon_encoder);
+		if (!props.brightness)
+			props.brightness = RADEON_MAX_BL_LEVEL;
+
+		if (drm_connector_attach_luminance_property(drm_connector, 0,
+							    props.max_brightness,
+							     props.brightness))
+			goto error;
+
+		atombios_set_backlight_level(radeon_encoder, props.brightness);
+		dig->bl_dev = NULL;
+		rdev->mode_info.bl_encoder = radeon_encoder;
+		return;
+	}
+
 	snprintf(bl_name, sizeof(bl_name),
 		 "radeon_bl%d", dev->primary->index);
 	bd = backlight_device_register(bl_name, drm_connector->kdev,
@@ -236,9 +257,6 @@ void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
 		goto error;
 	}
 
-	pdata->encoder = radeon_encoder;
-
-	dig = radeon_encoder->enc_priv;
 	dig->bl_dev = bd;
 
 	bd->props.brightness = radeon_atom_backlight_get_brightness(bd);
@@ -258,6 +276,7 @@ void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
 	return;
 
 error:
+	radeon_encoder->backlight_priv = NULL;
 	kfree(pdata);
 	return;
 }
@@ -282,12 +301,19 @@ static void radeon_atom_backlight_exit(struct radeon_encoder *radeon_encoder)
 	bd = dig->bl_dev;
 	dig->bl_dev = NULL;
 
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		kfree(radeon_encoder->backlight_priv);
+		radeon_encoder->backlight_priv = NULL;
+		return;
+	}
+
 	if (bd) {
 		struct radeon_legacy_backlight_privdata *pdata;
 
 		pdata = bl_get_data(bd);
 		backlight_device_unregister(bd);
 		kfree(pdata);
+		radeon_encoder->backlight_priv = NULL;
 
 		DRM_INFO("radeon atom LVDS backlight unloaded\n");
 	}
diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
index 16b048f58c9be..655361407b819 100644
--- a/drivers/gpu/drm/radeon/radeon_connectors.c
+++ b/drivers/gpu/drm/radeon/radeon_connectors.c
@@ -31,6 +31,7 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/radeon_drm.h>
 #include "radeon.h"
+#include "radeon_asic.h"
 #include "radeon_audio.h"
 #include "atom.h"
 
@@ -931,11 +932,44 @@ static int radeon_lvds_set_property(struct drm_connector *connector,
 	return 0;
 }
 
+static void radeon_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_encoder *encoder = radeon_best_single_encoder(conn_state->connector);
+	struct radeon_encoder *radeon_encoder;
+	struct radeon_backlight_privdata *pdata;
+	u8 level = conn_state->luminance;
+
+	if (!encoder)
+		return;
+
+	radeon_encoder = to_radeon_encoder(encoder);
+	pdata = radeon_encoder->backlight_priv;
+	if (!pdata)
+		return;
+
+	if (pdata->atom) {
+		atombios_set_backlight_level(radeon_encoder, level);
+	} else {
+		if (pdata->negative)
+			level = RADEON_MAX_BL_LEVEL - level;
+		radeon_legacy_set_backlight_level(radeon_encoder, level);
+	}
+}
+
+static void radeon_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_connector_state state = *conn_state;
+
+	state.luminance = 0;
+	radeon_set_luminance(&state);
+}
 
 static const struct drm_connector_helper_funcs radeon_lvds_connector_helper_funcs = {
 	.get_modes = radeon_lvds_get_modes,
 	.mode_valid = radeon_lvds_mode_valid,
 	.best_encoder = radeon_best_single_encoder,
+	.set_luminance = radeon_set_luminance,
+	.disable_luminance = radeon_disable_luminance,
 };
 
 static const struct drm_connector_funcs radeon_lvds_connector_funcs = {
diff --git a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
index 1f82e2b57f5d5..96b0dfd8e3521 100644
--- a/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
+++ b/drivers/gpu/drm/radeon/radeon_legacy_encoders.c
@@ -403,16 +403,9 @@ void radeon_legacy_backlight_init(struct radeon_encoder *radeon_encoder,
 	memset(&props, 0, sizeof(props));
 	props.max_brightness = RADEON_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
-	snprintf(bl_name, sizeof(bl_name),
-		 "radeon_bl%d", dev->primary->index);
-	bd = backlight_device_register(bl_name, drm_connector->kdev,
-				       pdata, &radeon_backlight_ops, &props);
-	if (IS_ERR(bd)) {
-		DRM_ERROR("Backlight registration failed\n");
-		goto error;
-	}
-
 	pdata->encoder = radeon_encoder;
+	pdata->atom = false;
+	radeon_encoder->backlight_priv = pdata;
 
 	backlight_level = (RREG32(RADEON_LVDS_GEN_CNTL) >>
 			   RADEON_LVDS_BL_MOD_LEVEL_SHIFT) & 0xff;
@@ -441,6 +434,36 @@ void radeon_legacy_backlight_init(struct radeon_encoder *radeon_encoder,
 #endif
 	}
 
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		props.brightness = pdata->negative ?
+			RADEON_MAX_BL_LEVEL - backlight_level : backlight_level;
+		if (drm_connector_attach_luminance_property(drm_connector, 0,
+							    props.max_brightness,
+							     props.brightness))
+			goto error;
+
+		if (rdev->is_atom_bios) {
+			struct radeon_encoder_atom_dig *lvds = radeon_encoder->enc_priv;
+
+			lvds->bl_dev = NULL;
+		} else {
+			struct radeon_encoder_lvds *lvds = radeon_encoder->enc_priv;
+
+			lvds->bl_dev = NULL;
+		}
+		rdev->mode_info.bl_encoder = radeon_encoder;
+		return;
+	}
+
+	snprintf(bl_name, sizeof(bl_name),
+		 "radeon_bl%d", dev->primary->index);
+	bd = backlight_device_register(bl_name, drm_connector->kdev,
+				       pdata, &radeon_backlight_ops, &props);
+	if (IS_ERR(bd)) {
+		DRM_ERROR("Backlight registration failed\n");
+		goto error;
+	}
+
 	if (rdev->is_atom_bios) {
 		struct radeon_encoder_atom_dig *lvds = radeon_encoder->enc_priv;
 		lvds->bl_dev = bd;
@@ -459,6 +482,7 @@ void radeon_legacy_backlight_init(struct radeon_encoder *radeon_encoder,
 	return;
 
 error:
+	radeon_encoder->backlight_priv = NULL;
 	kfree(pdata);
 	return;
 }
@@ -482,12 +506,19 @@ static void radeon_legacy_backlight_exit(struct radeon_encoder *radeon_encoder)
 		lvds->bl_dev = NULL;
 	}
 
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		kfree(radeon_encoder->backlight_priv);
+		radeon_encoder->backlight_priv = NULL;
+		return;
+	}
+
 	if (bd) {
 		struct radeon_backlight_privdata *pdata;
 
 		pdata = bl_get_data(bd);
 		backlight_device_unregister(bd);
 		kfree(pdata);
+		radeon_encoder->backlight_priv = NULL;
 
 		DRM_INFO("radeon legacy LVDS backlight unloaded\n");
 	}
diff --git a/drivers/gpu/drm/radeon/radeon_mode.h b/drivers/gpu/drm/radeon/radeon_mode.h
index 031a3bf6fe0a4..c4e09e0dacba0 100644
--- a/drivers/gpu/drm/radeon/radeon_mode.h
+++ b/drivers/gpu/drm/radeon/radeon_mode.h
@@ -283,6 +283,7 @@ struct radeon_mode_info {
 struct radeon_backlight_privdata {
 	struct radeon_encoder *encoder;
 	uint8_t negative;
+	bool atom;
 };
 
 #define MAX_H_CODE_TIMING_LEN 32
@@ -455,6 +456,7 @@ struct radeon_encoder {
 	uint32_t underscan_vborder;
 	struct drm_display_mode native_mode;
 	void *enc_priv;
+	struct radeon_backlight_privdata *backlight_priv;
 	int audio_polling_active;
 	bool is_ext_encoder;
 	u16 caps;
-- 
2.43.0

