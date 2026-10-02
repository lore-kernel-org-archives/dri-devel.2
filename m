Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3550DCA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D18510E66C;
	Fri,  2 Oct 2026 19:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0qNmoOUA";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013029.outbound.protection.outlook.com
 [40.93.201.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C3C10E66C;
 Fri,  2 Oct 2026 19:01:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WpGg9r0HvZB50O79WC/2iMQuQXOvVmH5mliTpRxOwChPiGJXyvo6FV75eTw0aVtwVf5Vscf36qkBoRp52k1PgFEbabsboJfFd9gNUeMH7DH+IgmBdV12MF0J6S5VMBzG/tV2oHBOT4vEV7KPJ0nVuaziFT+xv2ysz63k8tihKAuorCsn56Gn/mr9wJZZY4DS6EdM7Prfp4HqqhHb9gAhlXfMccE/+1gA9204Sp0JUXO+ogUt4FTQqnWoaVr1NuDK8JaFUgWFI/AX2ZbQqXOsfDGNFF9fme+U29Wsy7+FzCBB9kmfuBfDqz8q4DVPZve1pbrBgF8n7+HxKLAbHe15PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOy8DWFicgcpKyuHuv9EbWLATxDc2HHSbVoDK17SWbw=;
 b=kgjFRyzXKvKU0m4aCsrCbApew5IEso//xYyNEFBLhec2CFNi15OJuM16bm46lduHRdlR/dSNdAOh6aunRTYEVPKFEz8BL3ln43OQBvcd1+/2kOTur80nOsvCG6TBYxNYeJQg2xFW0Tmk2z2S8HhHwuFpWXLdPGz3+z2ea/ka4uwvwJ4NEDAV1zoo92UkrpDMqklq+PMni41Otj9Cbt/gRzZVh7tObzMKTk20L4cTB3+osRzBD8gAwav6aFT8SYfLkOcRDHCdlJ7wcY17cv7n7JIaZXvVAtcp74NcMeidpDUKV9nl1Hmjb6rsMrAiAbLVqZiRzhL7fKUSTFbnIBL5xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOy8DWFicgcpKyuHuv9EbWLATxDc2HHSbVoDK17SWbw=;
 b=0qNmoOUAMloSPqNoQa0Kn7OmpE3FPTd+PHrvIh0HduieAQR/NZKOVPQghEFli4lQtP1luXMtHbyJfMVLGFy4sJiIuX+RZIzjmKGXVJtPGLyddWpcy+YTXtM16RcDq7fcao6PyNEEgx0igZqqAdL4Yt88lSBHb34/zpSXmX0UllQ=
Received: from PH7P221CA0052.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::23)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Fri, 2 Oct
 2026 19:01:10 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::4b) by PH7P221CA0052.outlook.office365.com
 (2603:10b6:510:33c::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:01:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615E.mail.protection.outlook.com (10.167.249.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:09 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:06 -0500
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
Subject: [PATCH v9 03/21] drm/amd: add luminance property support
Date: Fri, 2 Oct 2026 14:00:12 -0500
Message-ID: <20261002190030.211356-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: bc322956-40ac-4175-3eb5-08df20b78581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|7416014|82310400026|376014|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zaAG7k2EhzB19SnjRTB1ZZqWhcnDccbr28eac7M/g7ZAtA7YtdY4hrsYPLpUUx12/HyoGKav6QvOcRH7mrX8hkfipnrm/03jAlvNoz+Zy2OGn2QKOZeAKLdBfAHeqUSSDaNEA7o32fG+HRYUi9S+70L02DRkYL9WWLn6/MNuQrYXIpPSWDwIDAuP8Q7ZVOfIfqhIEHKAAclYcZvj6CKmuYwv5miunXhlPgonQBcDzCgniIXtaHUq1PRa77eolgDnLK1bCc5XqYQKrPLXfR1hvwHNhFSs3B7kDEih/SiVmbYtC3HJ4vMTg6NzCTsG2XSq/HAmK4OLwsyEY9IYxKemux8oe94RvH2C7kW43Vt7hn9JdLDyLhGqJwTPVh/682MAZaU6VpdYOrlBTTD/C9J1FPIqBRHVviVbGi4kaAXXN672dFvKcJVYl/GcogZ8xyguXYFsEQHc+lSUobknhk3btwWBUM3TGxLcQh28TD4sAsIX4vVLsYTnDeBIKU0JwJVzTcMQcYg7mmxP/Cmqq+/ji1nr1dA5AzQZbia7j2f1G53hjS3u340LItk536tGLN2KLRoUfylSt7eV5iKO8NCTkHbCAkrbRxMI8VZW0wi03ypa66sFrudI/N5+CKuQP+EDCdEzeLx8mI7Bq7P0CeBmfKGqpPzTd985FMuC2p3MGNkhCJ6b6C24NAgeB3xuYZ2yzJEN4xqMviBPgl44rRLcyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(7416014)(82310400026)(376014)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1apvFYUgKFb53fwsvsmACwPTcNw+AVXqSjO3eKQ8hq9cgJftAV8yUzK3B/G6ed7swEGwvVRZPb60Mg3thvCMoosriTgUwY0Btz5+HenY/i6h5HZsxGO9ULl1s1MxUQPVD56npcn0B/mf06PUKX4LSUldvzO4XaCQlzH4SYdKEZ12p9mDC6ycPTn/B9Vx2aLOYXuRxrA2wpAtAx7oZVXwO1NQdN7u0x+pXqHOHZxl1wE32VgMTxsi3YTc0UZCRw4PLHw8UWtHveR4pzW0pGCpVnaSpYgWKptnC4Gzwqe2NFerZe9kTYOsIrvNHElndRzX4DGfX8/zNnQzxgLDvTmdDjaPvAKti4zePilOSl2FNrhkaRNz5T9TXZ/ZukVL9stVp3/rlphv6oCudTKC9jOK58gWyLy9wKjz0KeTRxL5Ap5nff+hB2hrcAx9JV19C6M9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:09.9475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc322956-40ac-4175-3eb5-08df20b78581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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

Expose the DRM LUMINANCE connector property for internal panels when
CONFIG_DRM_LUMINANCE is enabled. Keep registering the existing backlight
class device otherwise, preserving its userspace ABI.

Use the existing brightness scaling and programming paths from connector
helper callbacks in both Display Core and legacy display. Apply atomic
luminance after the display pipeline is enabled so changes made while a
connector is inactive take effect on the next enable.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig            |  2 +-
 .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 20 +++++++++
 .../gpu/drm/amd/amdgpu/atombios_encoders.c    | 17 +++++++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++----
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   | 42 +++++++++++++++++--
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |  2 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  7 +++-
 7 files changed, 96 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 12e4a41bf1f04..f273fb79c0e02 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -20,7 +20,7 @@ config DRM_AMDGPU
 	select I2C
 	select I2C_ALGOBIT
 	select CRC16
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	select INTERVAL_TREE
 	select DRM_BUDDY
 	select DRM_SUBALLOC_HELPER
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 92c98e999efe9..209a7a6c246db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -798,11 +798,31 @@ static int amdgpu_connector_set_lcd_property(struct drm_connector *connector,
 	return 0;
 }
 
+static void amdgpu_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_encoder *encoder =
+		amdgpu_connector_best_single_encoder(conn_state->connector);
+
+	if (encoder)
+		amdgpu_atombios_encoder_set_backlight_level(to_amdgpu_encoder(encoder),
+							    conn_state->luminance);
+}
+
+static void amdgpu_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_encoder *encoder =
+		amdgpu_connector_best_single_encoder(conn_state->connector);
+
+	if (encoder)
+		amdgpu_atombios_encoder_set_backlight_level(to_amdgpu_encoder(encoder), 0);
+}
 
 static const struct drm_connector_helper_funcs amdgpu_connector_lvds_helper_funcs = {
 	.get_modes = amdgpu_connector_lvds_get_modes,
 	.mode_valid = amdgpu_connector_lvds_mode_valid,
 	.best_encoder = amdgpu_connector_best_single_encoder,
+	.set_luminance = amdgpu_connector_set_luminance,
+	.disable_luminance = amdgpu_connector_disable_luminance,
 };
 
 static const struct drm_connector_funcs amdgpu_connector_lvds_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
index a1d05df0ac99b..dbff532ac1bcd 100644
--- a/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
+++ b/drivers/gpu/drm/amd/amdgpu/atombios_encoders.c
@@ -191,6 +191,21 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 		goto register_acpi_backlight;
 	}
 
+	dig = amdgpu_encoder->enc_priv;
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		unsigned int brightness;
+
+		brightness = amdgpu_atombios_encoder_get_backlight_level(amdgpu_encoder);
+		if (drm_connector_attach_luminance_property(drm_connector, 0,
+							    AMDGPU_MAX_BL_LEVEL,
+							     brightness))
+			return;
+
+		dig->backlight_level = brightness;
+		dig->bl_dev = NULL;
+		return;
+	}
+
 	pdata = kmalloc_obj(struct amdgpu_backlight_privdata);
 	if (!pdata) {
 		DRM_ERROR("Memory allocation failed\n");
@@ -211,7 +226,6 @@ void amdgpu_atombios_encoder_init_backlight(struct amdgpu_encoder *amdgpu_encode
 
 	pdata->encoder = amdgpu_encoder;
 
-	dig = amdgpu_encoder->enc_priv;
 	dig->bl_dev = bd;
 
 	bd->props.brightness = amdgpu_atombios_encoder_get_backlight_brightness(bd);
@@ -2123,4 +2137,3 @@ amdgpu_atombios_encoder_get_dig_info(struct amdgpu_encoder *amdgpu_encoder)
 
 	return dig;
 }
-
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2b0686bcc7fd2..e79920ca17ac5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5175,9 +5175,12 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 		}
 
 		/* Skip any modesets/resets */
-		if (!acrtc || drm_atomic_crtc_needs_modeset(new_crtc_state))
+		if (!acrtc || !new_crtc_state ||
+		    drm_atomic_crtc_needs_modeset(new_crtc_state))
 			continue;
 
+		drm_connector_update_privacy_screen(new_con_state);
+
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
@@ -5257,8 +5260,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 					    &stream_update);
 		mutex_unlock(&dm->dc_lock);
 		kfree(dummy_updates);
-
-		drm_connector_update_privacy_screen(new_con_state);
 	}
 
 	/**
@@ -5376,11 +5377,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 	/* Update audio instances for each connector. */
 	amdgpu_dm_commit_audio(dev, state);
 
-	/* restore the backlight level */
-	for (i = 0; i < dm->num_of_edps; i++) {
-		if (dm->backlight_dev[i] &&
-		    (dm->actual_brightness[i] != dm->brightness[i]))
-			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		/* Apply brightness after the display pipeline is enabled. */
+		drm_atomic_helper_commit_luminance_enables(state);
+	} else {
+		/* Restore the legacy backlight level. */
+		for (i = 0; i < dm->num_of_edps; i++) {
+			if (dm->backlight_dev[i] &&
+			    dm->actual_brightness[i] != dm->brightness[i])
+				amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+		}
 	}
 
 	/*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 64a963c218c8b..7b9ab94244176 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -40,6 +40,7 @@
 
 #include <linux/backlight.h>
 #include <linux/power_supply.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_utils.h>
 
@@ -233,13 +234,17 @@ struct dc_stream_state *dm_find_stream_with_link(
 	struct amdgpu_display_manager *dm,
 	struct dc_link *link)
 {
-	struct dc_state *cur_dc_state = dm->dc->current_state;
+	struct dc_state *cur_dc_state;
 	struct dc_stream_state *stream = NULL;
 	int i;
 
+	if (!dm || !dm->dc || !dm->dc->current_state || !link)
+		return NULL;
+
+	cur_dc_state = dm->dc->current_state;
 	for (i = 0; i < cur_dc_state->stream_count; i++) {
 		stream = cur_dc_state->streams[i];
-		if (stream->link == link)
+		if (stream && stream->link == link)
 			return stream;
 	}
 
@@ -293,7 +298,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 
 	dm->brightness[bl_idx] = user_brightness;
 	/* update scratch register */
-	if (bl_idx == 0)
+	if (bl_idx == 0 && dm->adev && dm->adev->rmmio && dm->adev->bios_scratch_reg_offset)
 		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
 	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
 	link = (struct dc_link *)dm->backlight_link[bl_idx];
@@ -591,6 +596,10 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 {
 	struct dc_link *link = aconnector->dc_link;
 	int bl_idx = dm->num_of_edps;
+	struct backlight_properties props = { 0 };
+	struct amdgpu_dm_backlight_caps *caps;
+	struct drm_connector *connector = &aconnector->base;
+	int ret;
 
 	if (!(link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) ||
 	    link->type == dc_connection_none)
@@ -609,6 +618,19 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 
 	amdgpu_dm_update_connector_ext_caps(aconnector);
 
+	caps = &dm->backlight_caps[bl_idx];
+	amdgpu_dm_backlight_fill_props(caps, power_supply_is_system_supplied() > 0,
+				       !(amdgpu_dc_debug_mask &
+					 DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE),
+				       &props);
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		unsigned int max = props.max_brightness;
+		unsigned int value = props.brightness;
+
+		ret = drm_connector_attach_luminance_property(connector, 0, max, value);
+		drm_WARN_ON(adev_to_drm(dm->adev), ret);
+	}
+
 	/* Offer ABM property when user didn't turn off by module parameter.
 	 * OLED panels are included to support CACP (Content Adaptive
 	 * Contrast and Power) feature via set_abm_level.
@@ -620,6 +642,20 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 }
 EXPORT_IF_KUNIT(amdgpu_dm_setup_backlight_device);
 
+void amdgpu_dm_set_luminance(const struct drm_connector_state *state)
+{
+	struct amdgpu_dm_connector *aconnector =
+		to_amdgpu_dm_connector(state->connector);
+	struct amdgpu_display_manager *dm =
+		&drm_to_adev(state->connector->dev)->dm;
+
+	if (aconnector->bl_idx < 0)
+		return;
+
+	amdgpu_dm_backlight_set_level(dm, aconnector->bl_idx,
+				      state->luminance);
+}
+
 /**
  * DOC: panel power savings
  *
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
index 891749322191c..859224cb37988 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.h
@@ -33,6 +33,7 @@ struct dc_stream_state;
 struct device;
 struct device_attribute;
 struct drm_connector;
+struct drm_connector_state;
 struct attribute_group;
 
 #define AMDGPU_DM_DEFAULT_MIN_BACKLIGHT 12
@@ -47,6 +48,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 void amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector);
 void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 			    struct amdgpu_dm_connector *aconnector);
+void amdgpu_dm_set_luminance(const struct drm_connector_state *state);
 void amdgpu_dm_update_connector_ext_caps(struct amdgpu_dm_connector *aconnector);
 bool amdgpu_dm_should_create_sysfs(struct amdgpu_dm_connector *aconnector);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 2a63a1c9b79d8..41610bed02c6d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1922,7 +1922,8 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
 	}
 
 	if (aconnector->bl_idx != -1) {
-		backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
+		if (dm->backlight_dev[aconnector->bl_idx])
+			backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
 	}
 
@@ -2016,7 +2017,8 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 			return r;
 	}
 
-	amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE))
+		amdgpu_dm_register_backlight_device(amdgpu_dm_connector);
 
 	if ((connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort) ||
 	    (connector->connector_type == DRM_MODE_CONNECTOR_eDP)) {
@@ -2679,6 +2681,7 @@ amdgpu_dm_connector_helper_funcs = {
 	.get_modes = get_modes,
 	.mode_valid = amdgpu_dm_connector_mode_valid,
 	.atomic_check = amdgpu_dm_connector_atomic_check,
+	.set_luminance = amdgpu_dm_set_luminance,
 };
 
 int amdgpu_dm_convert_dc_color_depth_into_bpc(enum dc_color_depth display_color_depth)
-- 
2.43.0

