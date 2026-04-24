Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E80FF885C
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0451F10F6DC;
	Fri, 24 Apr 2026 22:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PXXmGoaG";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013051.outbound.protection.outlook.com
 [40.107.201.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F5EC10F6DA;
 Fri, 24 Apr 2026 22:10:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kw4w1VsiCWCrkShVMAIkGDTXMK3BAOMd2G+aj2fa1YooVe1dPI4L7Za92JS4b+Nk4x108oteAOFGjsWoJcBm4TLsjtPWgxKnhEFFWyUwJKmYgrcsHc4bE9ATag7mb6v2kscKvL1vZ7/81Esmdy7JzyIZaFJ1bcOBJi65PMTWt4SZwzyHdNP4QOmdBPrggti8vFNbVuUjVUmgfVNCum7TtUWmxjpBi56d3Yte8PKdA9jfs5gDEjpUc2OkiA5jK0sjXmNJX+lVggWb47eiXLpTPQ8C82vK91qsWvlvS4OwooPBOnTW/GETC2NTA5ctqP3yK3M4OesDAzGSIi4swEyvvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjtWysE4kTRb6UtmnVW4lZwkJWhc+80p9pzHYrz/TL0=;
 b=DcqKKB8+idqkXl4/5VWBgbylV6DJtp+nWS7h+UDKi7ikm5Pwc+DBVaH0x190OoB/hV6o81jY/AOqxfyUPy95MSKW820U1DpXmR7+zDqsfjD6yRfgU5i4kMNQ+2o38Yh1FdNz8kYO0EhLaz7hHJwEFBnPUN4tQwnwvXO+EkYnj4wcgQRb7bfoFtrE8iZkXckSxKvXLsvxBt0BbCnXFN4AqTYz37d1U50ibdH9G07RlizQ2GlGCYJbWYjr89OfJkqMiIYgX69D/oLbu/H3OFzrD/9kUHviDnDXEgbmByVazIEWpGYgRGMqjN5ueUWMTx9nhcJhV3l+fEeAZsGFXjGULA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjtWysE4kTRb6UtmnVW4lZwkJWhc+80p9pzHYrz/TL0=;
 b=PXXmGoaGazs6Wgn/rwdh4C12zqf1hT0MGLzz7Mwxn1KA1y9wZDskKP8OOseYTsd08ApfCtNlBT7VO+1szc1aTC/EeQb1S4M9RFV78MO2CIkrMCsq6Ch3GwXCeb6XvO2QYRSYIQeAQYEC0yJNev3OcP77+OSh/fIwumyfqHUuJKs=
Received: from CH0PR03CA0071.namprd03.prod.outlook.com (2603:10b6:610:cc::16)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 22:10:21 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::30) by CH0PR03CA0071.outlook.office365.com
 (2603:10b6:610:cc::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 22:10:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 22:10:21 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 17:10:19 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v3 8/8] drm/amd/display: use drm backlight
Date: Fri, 24 Apr 2026 17:09:53 -0500
Message-ID: <20260424220953.167058-9-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424220953.167058-1-mario.limonciello@amd.com>
References: <20260424220953.167058-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eff198e-bf6b-42c2-9fe6-08dea24e46bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ifp3kYfBxjLmXiWDHgab1JBkN4pUyTMhg7dT7BUU0Jq7Ql+m7cMlyVM21GDHXk5v3ruxdDXaxEBWTKFR3fRwwTpkZBUvEz0BlungRrnyBxUP+3HzUaxArhm4YYICpGkkKlK9sBLeLwYXNi0QqGUUc9cysjmEHC4OoX0GHdBsB64KNNOwbi7m0qrqkNmuHdf30mdwP/l+iNccCudzQxVVywTlJw9dQX9vP4myFAi4gnEAUYdSLoTeRdm0zRH06JeMVmMMb8nE4/kNnQvPrFDq0FI2OXik1yC19YTihjSHyvEAudNixLKUAxaSONxesErja4gZw5BADj8lSyVyxirkpDl/zUCpy+enwBWk19+v17vvmGtR5i+Iil/zaI1QtUR792HfXAMqUGcMNWAfN34LOHMDViaxL2P00d//91cU7xiJ8QHrYjvziGMV1Mvai03EPwQZ2sruAO3FntdzF8BGOG2hs01mTTZxVsJeIPChUHywg5xkP0M+kFsmcmsHbBs89WOwLOvTi+CckjhXMpoLByhvHfptNCLIZ2xa7M8GOf/fpPFRIhxAem2DFLpB6TrVHM+/F9qmxkpDVwWt023FHiohFRJtxfbzV/7libE5gbyEaoVeHBx8hWD1wU9F4lJQWeAwFhuhM8+gpJs9mZ8Tq+GXLWnmjj2HqMOjIyZB5ngi7W+ilbmlFM6qgHcH1/I2piUcGq4EDgshyymnZJL/mxfB8DHhDbYOoyOtiqKf1OKxjIbvEhF5nMsVxMoutcAzAUgvCylXE8eXfsjbFuzuwQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qdV0VKVycMJN69v0EhANnKRa8zvD6g0i4qw4pZcn8fvU+clKB2U2i0ENvgV2PUa9JqlSJbfstwXWiI3Mi3mFLyARyWz+ct+dmeFESZCuFZB3r6TG/YBD8Ucf11Cp618qYThRlDUnBjqDNarp1O03WyhMNlLozo5NXNfVTmZuvRv2U2WoTKpPJq74nRo6mkODSvK2NBDCzq3cWokcF3wVsFOF/kKeXEzI0TTvQdiAVKDWbdV8awa76OSSqVuFS8OYIuNDqNrdxv4SWMZvop7x/gBzCvtBXTpsrNjK0JQzmxAXTSwa7T0jGVX1jjC96yI9h+Ow0a5drlbwHlOWDw42ZQ1UQNhxXJAXXyHaPGo/0XQox2MYuhBCEw2kIopCXiWPemBjy5DWiuSeFyehc3Om2p1aJh4p0KDycprHHjONABzll6Queszyjw6uC6MgLREp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:10:21.0752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eff198e-bf6b-42c2-9fe6-08dea24e46bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
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

Convert AMD display driver to use the new DRM backlight infrastructure.
This allows brightness control via DRM connector properties.

Includes fixes for backlight resource lifecycle management.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6b29e5b6b41e7..52854abc6bb60 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -86,6 +86,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_fourcc.h>
@@ -5424,9 +5425,32 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
 		dm->actual_brightness[aconnector->bl_idx] = real_brightness;
 		dm->brightness[aconnector->bl_idx] = real_brightness;
 	}
-	drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
+
+	/* Only set backlight name if DRM backlight was allocated successfully.
+	 * drm_backlight_alloc() may have failed earlier in init_helper, leaving
+	 * aconnector->base.backlight as NULL.
+	 */
+	if (aconnector->base.backlight) {
+		r = drm_backlight_set_name(aconnector->base.backlight, bl_name);
+		if (r)
+			goto error_cleanup_backlight;
+
+		drm_dbg_driver(drm, "DM: Registered Backlight device: %s\n", bl_name);
+	} else {
+		drm_warn(drm, "DM: Backlight device registration skipped - DRM backlight not allocated\n");
+	}
 
 	return 0;
+
+error_cleanup_backlight:
+	/* Clean up hardware backlight device if DRM backlight name setting failed */
+	backlight_device_unregister(dm->backlight_dev[aconnector->bl_idx]);
+	dm->backlight_dev[aconnector->bl_idx] = NULL;
+
+	/* Also clean up DRM backlight structure to avoid resource leak */
+	drm_backlight_free(&aconnector->base);
+
+	return r;
 }
 
 static int initialize_plane(struct amdgpu_display_manager *dm,
@@ -7880,6 +7904,10 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	aconnector->dc_sink = NULL;
 
 	drm_dp_cec_unregister_connector(&aconnector->dm_dp_aux.aux);
+	/* DRM core will handle drm_backlight cleanup via:
+	 * drm_connector_unregister() -> drm_backlight_unregister()
+	 * drm_connector_cleanup() -> drm_backlight_free()
+	 */
 	drm_connector_unregister(connector);
 	drm_connector_cleanup(connector);
 	kfree(aconnector->dm_dp_aux.aux.name);
@@ -9129,6 +9157,12 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	aconnector->base.state->max_bpc = 16;
 	aconnector->base.state->max_requested_bpc = aconnector->base.state->max_bpc;
 
+	if (connector_type == DRM_MODE_CONNECTOR_eDP) {
+		int r = drm_backlight_alloc(&aconnector->base);
+
+		if (r)
+			drm_err(dm->ddev, "Failed to allocate backlight: %d\n", r);
+	}
 	if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
 		/* Content Type is currently only implemented for HDMI. */
 		drm_connector_attach_content_type_property(&aconnector->base);
-- 
2.43.0

