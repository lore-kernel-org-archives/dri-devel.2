Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA3ECA5FE0
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B008B10F9CB;
	Fri,  2 Oct 2026 19:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lHEaqWe7";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FD6410F9AD;
 Fri,  2 Oct 2026 19:01:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmhSDeJdSmss8SErMhdzdUGnIl4nwWGg/bmO4im9ZEMYmBR+B0ArCw/B1lapIS5PW1bVtiauUG/FzmUWBT7p/Hr+jWUUAXyrFVO1NjAHAkUNR53rUwiXyTVHCaK3TC+XQjhWcGVMEZKOoXm9FArxsk86PQizPDSJavfA0H/U4wu2iLkv7HoxpvLG5vp/sv3iMasWiM9lIBQC/CzvfOOzDEKPdJtUct2+cVzzoRdUdxa+5gGxP+DSC79WkQnXQaDyk6m8LLMaNnrNlfCHKMytJJpG/MiEADgC+fqBMn0tnwn/KK560Y+PVdDEolMKKJjyt2tX7rV6O+L98bkBBVSHQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3hKm6DzTNSZJrpGeDSjP80eVm7kdodUQr2diX3DJZw=;
 b=plB/Gj9Y2GYtyB7Leu5BWggMIswBbTA7/LvCwno6Ygod+/phfZQ/eHi0uhAn5mTyyxpwvpwLr73KMISEUEK3eCYkfbSsROar/Zt9oSGCiiIYNaSnAkXFiho9lldFOznqvfkZF6X+TJnHTJLA5VW47ZtnYM5jYYXv0YDz/mDRndG/XS77mQrXtnIJYkDvBJQSG6klZHsKvh+lcRHYSpbhRMBuQ/Yl9aOOv7yCl9MiXxTOVijyDKAR86Svs6Z8q+9+H8UqA7YfHhDC1svHnwG63FM/V7pIw9KqJ3Y8q9YkmNaMFL+LjYjQxJYeScnUioXkV/Az3Jyj7mhh+eeNYdHDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3hKm6DzTNSZJrpGeDSjP80eVm7kdodUQr2diX3DJZw=;
 b=lHEaqWe7w9YwHFN/0GaCdSzoBACgrTe7FVwZHsVu1VRuV4Nlp32Hhli5141qjJq+v/47O8anmxkG8qXhXYxxdwMTE276odF6dzVCnq5CjDmueFYKxlZUlWpRtXCshkLqNRbaen23+sh+QQaYlVAXQTtxAbwujlgPL+41UeqAusU=
Received: from MW4PR03CA0017.namprd03.prod.outlook.com (2603:10b6:303:8f::22)
 by CH1PPF989868826.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::61d) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:01:13 +0000
Received: from MW1PEPF0001615D.namprd21.prod.outlook.com
 (2603:10b6:303:8f:cafe::26) by MW4PR03CA0017.outlook.office365.com
 (2603:10b6:303:8f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Fri, 2
 Oct 2026 19:01:13 +0000
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
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:13 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:11 -0500
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
Subject: [PATCH v9 08/21] drm/mipi-dbi: add connector luminance helpers
Date: Fri, 2 Oct 2026 14:00:17 -0500
Message-ID: <20261002190030.211356-9-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615D:EE_|CH1PPF989868826:EE_
X-MS-Office365-Filtering-Correlation-Id: e03bc0c7-731b-4b4d-c2f0-08df20b787ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|36860700016|376014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r2Rgk1rhk17Y/dotvQ9mX2iAKzQF7GvXb9kmWqe2SJWUAstzt2+UzvfmXWzRHx1dhuCr/cKnDU0bjboZWQMCMDPO9WBV36zcxZbXBYFXS69Ddal9BO/joVPg9koyShlRsXCzj+7um454qQjUC3spVwOCl4VqpiKxMBT32vy/fRzTowQaN23192V+uND014iJUiExfqSApW3X33ELAsMZfuR6JPqMc6GNIjGrv62RovVAw+IPwzULV2ziASiWfvfsism9leAxTUR4EdzLfzUsHj6uCsiGiEOnQVvsr2z8UVgak+4K0aE1CUhVtEv0SkSjU8TSi5Q43DlLJVedSioIBP4Uhs0MUb2KbShpJwtSZwIk6KmfKfNwblF2+8WaKfLvEM7bIKS8aSwGpeIog7g7ofJUUgXIOCJ8D1a8C9I5Sh+WTGxnzWGiQDNq8YfnE1/mM36fQ+8V4tfj9k677AT4nEqx+MJHnIZDj7bgzndJUeCnF3LHNV6zw+acfQ8naaAHlf29Br4LYhlsCt95Mw8yEoFFO3nOG6w+01ZQWT3F5WJEUo7i96pih3pWJCzz6L1SYrK0adcQaUvfsUmhYW5vXnF/o7araAKeYiimKtpguiTUidU5ClRgN6iaz1G2PPvypB8QL05G4gTGwnVNlyEptwjGbUmKKCubgYcNmelKJj5qkRw93ox5xW5FctQSF93NoV6Muzh3q6C1jOGoxcP8ZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NTopsDUDCV7xzb4K71EIB68YZ1CyWSmnL8Pb97d5tDzwjpJ6Txmdj3JQKlLQJ0cW3hRE/wCy3RCX3o1dS1NueNS8zdJIouJjSnU6pPDSfZrY6zwA4vXxIt7+FoHnVLSvoVgH3JSqQ4J+n1eOqghvr4rdRPI4+GsP5BGhpIPqppRzTwVSecHO9tD+3hFkMYUseGNE0sNFeL/rBNTzn+KkKTe19W+iYTS5nKQbT914N0AdNLYmgRv+ytcjxXr68+U4fFuBLNqgTpUAc38G1kHP9/xNIpXIyrtTBUnBGTIrFVv1w1YHPJKII84i7CJJnQ4jtlZoiSpWCyAMWZ8XVKAsBnokip4bSpZPXaWz/QgQCrvI9B9Pbcyj9mfND88q5uW3GGFMEpO4jW4RYhov18qWgdCd+rm9yKWZkdMugnH0wMMYgsWiMxhdcK2wX+bvxdEo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:13.5958 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e03bc0c7-731b-4b4d-c2f0-08df20b787ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF989868826
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

Add common helpers for MIPI DBI drivers to attach the connector LUMINANCE
property and forward updates to their backlight backend when
CONFIG_DRM_LUMINANCE is enabled.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 36 ++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dbi.h     |  7 ++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 25cf04d029f77..85e3b98a7ccb0 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -496,6 +496,42 @@ int drm_mipi_dbi_connector_helper_get_modes(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_mipi_dbi_connector_helper_get_modes);
 
+int drm_mipi_dbi_connector_attach_luminance_property(struct drm_connector *connector)
+{
+	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(connector->dev);
+	struct backlight_device *backlight = dbidev->backlight;
+
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE) || !backlight)
+		return 0;
+
+	return drm_connector_attach_luminance_property(connector, 0,
+					backlight->props.max_brightness,
+					backlight->props.brightness);
+}
+EXPORT_SYMBOL(drm_mipi_dbi_connector_attach_luminance_property);
+
+void drm_mipi_dbi_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct mipi_dbi_dev *dbidev =
+		drm_to_mipi_dbi_dev(conn_state->connector->dev);
+
+	if (!dbidev->backlight)
+		return;
+
+	dbidev->backlight->props.brightness = conn_state->luminance;
+	backlight_update_status(dbidev->backlight);
+}
+EXPORT_SYMBOL(drm_mipi_dbi_connector_set_luminance);
+
+void drm_mipi_dbi_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct mipi_dbi_dev *dbidev =
+		drm_to_mipi_dbi_dev(conn_state->connector->dev);
+
+	backlight_disable(dbidev->backlight);
+}
+EXPORT_SYMBOL(drm_mipi_dbi_connector_disable_luminance);
+
 static int mipi_dbi_rotate_mode(struct drm_display_mode *mode,
 				unsigned int rotation)
 {
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index d93e25fdc2e1e..8462c6bd6ca9e 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -263,9 +263,14 @@ void drm_mipi_dbi_crtc_helper_atomic_disable(struct drm_crtc *crtc,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state
 
 int drm_mipi_dbi_connector_helper_get_modes(struct drm_connector *connector);
+int drm_mipi_dbi_connector_attach_luminance_property(struct drm_connector *connector);
+void drm_mipi_dbi_connector_set_luminance(const struct drm_connector_state *conn_state);
+void drm_mipi_dbi_connector_disable_luminance(const struct drm_connector_state *conn_state);
 
 #define DRM_MIPI_DBI_CONNECTOR_HELPER_FUNCS \
-	.get_modes = drm_mipi_dbi_connector_helper_get_modes
+	.get_modes = drm_mipi_dbi_connector_helper_get_modes, \
+	.set_luminance = drm_mipi_dbi_connector_set_luminance, \
+	.disable_luminance = drm_mipi_dbi_connector_disable_luminance
 
 /*
  * Mode config
-- 
2.43.0

