Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BD5C79FAB
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861AB10E9CB;
	Tue,  8 Sep 2026 04:41:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uQn2RN02";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D272A10E9B9;
 Tue,  8 Sep 2026 04:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xag9Jp4geXFZMQTulTmxZ7V0Da1u2gsMdo/PpJRM/XQmddLUq1mcj4kniw76pH43KQ1cL1D3CjSF2prQaVX+5F56+CNNoRlg1fgns0hHUpD7mOMFIzkrkEKfmqybhgSI0xXdmDh6gE7MFGCeuaPdIaFQ5TW9Q/O25Crh50YYfXBZWmFe0Mo22SopXgNOw1LKUTV1wSNXkhT7xEqpZPHpdHwrkNKzBLzSLorp66rpjCJow72y1LOR9VeaplNysU1iaKupaeQgr50Vqr64U+gpwIbFRVWukcuLrCV8/f2+awpZi1r48gn/j7SeZJ5IVtr5je0wOc6Lpll6npTXuTrjYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpDFZwMxc6/l++xbOlznzEluNR4ZVRp/FQRnJRMVEHI=;
 b=VUvQ0CnTX384ufDenCpQ1iiIl61VOD4DcpkpEopFeouinUAc4spTu/DJIviWapdxStCcbNhIykPdSkicAGgkfmwNa7gXO8HELyEvXDb6DLgGFIungerXFYMp0w8riED7kCrpCdR9QYETtOBeO5wQ04OKip+Ena8q6M9IIwH2RYlh06ttqQwlGI+5IPpq4dhcZQ/VhbQDmJzjbVG8FGMLG65zoAcmbuhZJhB1ZZzeESmk65ccg0KoBach6FEvrRvBm0TjAPlpGt1gkQOvVTyF2mwZFj8FcGBw83owXRYLLcxFIaoUbfk//dBJj+BV8KgfuMwEeTGHn9qZgP78s0ZTqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpDFZwMxc6/l++xbOlznzEluNR4ZVRp/FQRnJRMVEHI=;
 b=uQn2RN02FhCUP1Kpg4ZJ0hoInoXRJV2qVAII2K1NihxWi3ElBwEINFrn3/O6qh1SXIMVGplzUSGMBjnqBdh9InBJHbDWH/2onGnpxp9lu5xfMzmS41YKWwf/+L2rKN0pkhDTYIO1Nxw8JQeJLPso9WrOwCwj1oLQdj7wAQKKfmU=
Received: from CY5PR15CA0028.namprd15.prod.outlook.com (2603:10b6:930:14::24)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 04:41:05 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::27) by CY5PR15CA0028.outlook.office365.com
 (2603:10b6:930:14::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:41:05 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:41:03 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>, <harry.wentland@amd.com>, Simona Vetter
 <simona@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>
CC: Xaver Hugl <xaver.hugl@gmail.com>, <amd-gfx@lists.freedesktop.org>, "open
 list:INTEL DRM DISPLAY FOR XE AND I915 DRIVERS"
 <intel-gfx@lists.freedesktop.org>, "open list:INTEL DRM DISPLAY FOR XE AND
 I915 DRIVERS" <intel-xe@lists.freedesktop.org>, Hans de Goede
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>
Subject: [PATCH v8 08/14] drm/amd/display: use drm backlight
Date: Mon, 7 Sep 2026 23:40:29 -0500
Message-ID: <20260908044035.62093-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908044035.62093-1-mario.limonciello@amd.com>
References: <20260908044035.62093-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6006c3-fef3-4bc6-34f6-08df0d6364f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|23010399003|376014|1800799024|82310400026|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UldN7RoS2dfqsdx+MLvC/Zge6s4gXq2jkFJfxp5yenvfOjzwpq9x8z2TiMgdMPPmWYb4wvZZ5+LQeUQU7QRJq1QaKWjgZUchnX5N7uruzr3VMi/wQkS1K2YWkRBGEU4x2Gqq2rmt9TfYbw4mlqBfLr/h80+6hzFJMyDTA/SU2sUvXHgvAHxSrDyj33+g39ImniedwCKmN9rgStjUo6RfXn5QZ6hb/KLdYcmm0opIRa7tCQpfk5ZbJLTIczdyLUU7w9OBBULfpsHqUW74f2ykFu1ilwt3+pmGomuBC7yKH26yt4cAGcEXEH6EB2NTTbH3huZ0HG26LKFWujejHVM+g/U4Ew8JvZJE9QuRE5Vuz2wVtoua3uHggfFlaeTQM2VUA3V9u1K9FtRyA74i/OIunMcxMsZ9nFCQb0Xsv+UVlkfkqPBo6z2rVP1tNbiyf0tSao6kBIVxR2h6TM8l1V44wPtRIDyqmWQ9dUyZ3zP1Q0DXhTgy0f4HaUfn38zTG1e07/1bWm7Qww7O7gMpX79btzBJ/ZbRaF9tnkFqmwt7koHqZ19Eo607QNxfbCdE7ocVYTziDQipiPO04uxIePsKRVrRV/eGY3utj0Q52M750nnajYI4iqBEP8UcRODGrP+8nJG6sRGx5UK/5T9+N7VftOzDbXPQnb8dhDFzVe0jl0xpkq+hCq3/AeStHIOuTfJ1CTYmayXcAliCZf1IE1OukQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yMxzCYWteUh4A47hQD7r0erQU4CNbvPoHMvx13EoRCKyGUEowrYXQ90UjKypQ2k4cPCPwWec6sm1HXe3Uqyr8aGdaV4PvsiLLPGzE+0yGuuvyjrugGd2CmwLGJpWdekOjGazHhXZi0GFdXzB1CV6B44QTfo7niZGLeJEaXEsoM0Ayuq648+OADOPVL1C2MBPAaAY46nx6F/uuU9v9q5Xs7LeC+OF3/odyuKd6QL+udl4eJGHxAm0nunLNHRfUTqDLVyWXRZeP9dUlE5TSQ+kz7cSNm5n6Fjg+HXR9ikraiOQ9dOArPsjmKY2SEKAaryV1GVeyrviguA0uaHmMgWOVT/sA6zBHN46zilEP5E3Tmq11caxAyoDdkY/gzN3MU1CcjuK+BGZ40PCGavQoGFlsUv7xhb1w4W26k1YrqP3bncK6u+vN7z3asQZuohEqGRk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:41:05.5979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6006c3-fef3-4bc6-34f6-08df0d6364f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
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

Convert the AMD display driver to the DRM backlight infrastructure so
brightness can be controlled through the connector LUMINANCE property.
Link the registered backlight_device to the eDP connector and unlink it
on teardown; the DRM core owns the embedded backlight state and its
property, so no explicit allocation or failure handling is needed.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++---
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   | 23 ++++++++++++++++---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  2 ++
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2fe934036e363..f7b1eaf34b59d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5050,10 +5050,21 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
 		}
 
+		/*
+		 * Apply the LUMINANCE property first: a brightness-only commit
+		 * does not pull the CRTC into the atomic state (so new_crtc_state
+		 * is NULL), and a modeset is skipped below - in both cases the
+		 * backlight must still follow the requested luminance.
+		 */
+		drm_atomic_helper_connector_apply_luminance(new_con_state);
+
 		/* Skip any modesets/resets */
-		if (!acrtc || drm_atomic_crtc_needs_modeset(new_crtc_state))
+		if (!acrtc || !new_crtc_state ||
+		    drm_atomic_crtc_needs_modeset(new_crtc_state))
 			continue;
 
+		drm_connector_update_privacy_screen(new_con_state);
+
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 		dm_old_crtc_state = to_dm_crtc_state(old_crtc_state);
 
@@ -5133,8 +5144,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_commit *state)
 					    &stream_update);
 		mutex_unlock(&dm->dc_lock);
 		kfree(dummy_updates);
-
-		drm_connector_update_privacy_screen(new_con_state);
 	}
 
 	/**
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
index 406a821d03cd6..1fefe3837e4cf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlight.c
@@ -40,6 +40,7 @@
 
 #include <linux/backlight.h>
 #include <linux/power_supply.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_utils.h>
 
@@ -224,13 +225,17 @@ struct dc_stream_state *dm_find_stream_with_link(
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
 
@@ -284,7 +289,7 @@ void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 
 	dm->brightness[bl_idx] = user_brightness;
 	/* update scratch register */
-	if (bl_idx == 0)
+	if (bl_idx == 0 && dm->adev && dm->adev->rmmio && dm->adev->bios_scratch_reg_offset)
 		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
 	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
 	link = (struct dc_link *)dm->backlight_link[bl_idx];
@@ -496,6 +501,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 			dm->actual_brightness[aconnector->bl_idx] = real_brightness;
 			dm->brightness[aconnector->bl_idx] = real_brightness;
 		}
+		/* Link the registered backlight device to the DRM connector. */
+		drm_backlight_link(&aconnector->base, dm->backlight_dev[aconnector->bl_idx]);
+
 		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
 	}
 }
@@ -582,6 +590,8 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 {
 	struct dc_link *link = aconnector->dc_link;
 	int bl_idx = dm->num_of_edps;
+	struct backlight_properties props = { 0 };
+	struct amdgpu_dm_backlight_caps *caps;
 
 	if (!(link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) ||
 	    link->type == dc_connection_none)
@@ -600,6 +610,13 @@ void amdgpu_dm_setup_backlight_device(struct amdgpu_display_manager *dm,
 
 	amdgpu_dm_update_connector_ext_caps(aconnector);
 
+	caps = &dm->backlight_caps[bl_idx];
+	amdgpu_dm_backlight_fill_props(caps, power_supply_is_system_supplied() > 0,
+				       !(amdgpu_dc_debug_mask &
+					 DC_DISABLE_CUSTOM_BRIGHTNESS_CURVE),
+				       &props);
+	drm_backlight_create_property(&aconnector->base, props.max_brightness, false);
+
 	/* Offer ABM property when user didn't turn off by module parameter.
 	 * OLED panels are included to support CACP (Content Adaptive
 	 * Contrast and Power) feature via set_abm_level.
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index c8a1ab8c3b169..fe4ab55f5130f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -58,6 +58,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_eld.h>
 #include <drm/drm_fixed.h>
@@ -1911,6 +1912,7 @@ STATIC_IFN_KUNIT void amdgpu_dm_connector_destroy(struct drm_connector *connecto
 	}
 
 	if (aconnector->bl_idx != -1) {
+		drm_backlight_link(&aconnector->base, NULL);
 		backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
 		dm->backlight_dev[aconnector->bl_idx] = NULL;
 	}
-- 
2.43.0

