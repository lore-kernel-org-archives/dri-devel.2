Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B698CA5FE9
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E812210F9A3;
	Fri,  2 Oct 2026 19:01:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xAstdmtm";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010027.outbound.protection.outlook.com
 [40.93.198.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF2CC10F9A3;
 Fri,  2 Oct 2026 19:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2L6ttfbvRf9dxFUox4NUik+8+hUAtyYkCbRL5gX9EN423VxhOY+u1xcnTqtlzPSdnUNp647oRhyw0wNPkiIObF/jnvnHWaA6DoTfTmwSsn/oKOWPbIhXCD+qHXKdLxAwtdedGiFzznmdRrcNT6wunCd9XcnUPcL07B3vZW0NRTpzz8qC0ED3+pviLsn8lgh2YETd9cnGl+M3WI1vqw0b9Q/21L92LJiuXjCykCfdKVVi5HohSPILtxbJSKsaCt4ldV36ZnlUjjHbZf9BS/8+CObO8tAG0kV/KL3JoM+eg1as/p1Gk2ohGh1FBVOIq8UQSg596Zv55l1eeRNnRAvNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrKbHQOdwqPTwJKdRFAFNjrid/aTJk/nZgM+fA9AUpM=;
 b=R+TI+hOdcBqo413lpdo5EKQ/8ti1v1zjjFbb+WXTQFyezovEZ8L5FO4O1cptFtz2e0vzzhQLgC1xTcA30v+bS+2cxVZk6NfpqgM2Ni3PLYv5Ngbj4KCJiTTeDckQjUWAQFpJXAPHD9Vbu2PuBjiWm+mxFQFuo2KjjCoeShGRip6FM5dFvCrsrOWa8gjBIZy8w06rpSmAc5vSU5Bqxk+H78C8DdZ6dd4zz34sUYEeOAEEBlwCSdaqNjjiSs3p1rOlJoqLF/EQwtqhKDj+paVednQku/JDo9GDSiZVSQON8LTbcosKJDhQUxgPcZYZWDr3wRlbuSyO1ufMIRdYAxS9iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrKbHQOdwqPTwJKdRFAFNjrid/aTJk/nZgM+fA9AUpM=;
 b=xAstdmtmBwT8droM/vOcHsNh4bXX9IY7zYRm1SAGe9BBPaROKyABZVgUe/nUhGaA/wD3C23I0uADsZXjhYcwGw0cH5ZENBKd90lcxlC8bkIEX/DMHOF4Jf6O4UDOxs2xB46xcoDsj1AjY5zOGOWoTlJRbE2eHoi/diixBxWNJ7s=
Received: from PH7P220CA0048.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::19)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Fri, 2 Oct
 2026 19:01:24 +0000
Received: from MW1PEPF00016160.namprd21.prod.outlook.com
 (2603:10b6:510:32b:cafe::91) by PH7P220CA0048.outlook.office365.com
 (2603:10b6:510:32b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:01:24 +0000
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
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:23 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:22 -0500
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
Subject: [PATCH v9 17/21] drm/gud: add connector luminance support
Date: Fri, 2 Oct 2026 14:00:26 -0500
Message-ID: <20261002190030.211356-18-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF00016160:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: c046351c-2a3e-4920-5069-08df20b78dde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|7416014|23010399003|376014|36860700016|56012099006|10067099003|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: c24bUwduSusnQpkOZgR3uCIn7xnNsl2afmgRw/muBqlM+GIZnmkf8TzA/xuHHwVubBKpFOrgM7AyzwnZbpscasL8jKgmd8AdJ2fN47fmWCUA0QY0SQ7gpku10+iafHmu57ysK8Ml1vu9pfd0+c4XGWXhFlPHbOwxEdc7PZO/vXIyVAUsr2EDD0wHNCutZqmN1CAv0EdoQoNHnWxpfwzIy67PcgNzsuH02OsMhaiiGpSUOETSHq1qlfBM9QRIIEbRk7cPFamPivLGUPrqXFlwgryWAg2XvIM0meG1znyKR6ToET1j/mcR4Z9iW1sA3BktK9piFbq0Yv4TXrCpqppClnGMS5fbIjXONgtx8Z+/Y1b7gaCHYiNUZJAdnwXWytYrjPqianJi2cPOlCSWe7yPfna1jWTis8ZwsH5va59lX1lfeyq02myfkraDy0aD5LX5AApaqLR74SHpMIKJiXJXWwUFOrDatgpgekFFxxMfkuxLFzfxT0crIJQJSQh2y+OpJRPcnJ5s0HKIuWl4AbLLfEFiBEYugqwsV6+OvcT5ILT+ZEy8jlCGP9Lw6zmsUj823RCk7V5hE2nnkvF+mKJXGFlAxRCmCg6caRreRcCtJFciyjgyBC1RbHnoqrnu6jfdmPDnZp2/nQwXOwFVzp1zPdpz62Tkh+wKez1f9L7GqiJwhQOqTBrHda+1TEEe9RbSsInKImuqMpiMNEtPolKWvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(7416014)(23010399003)(376014)(36860700016)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U05gARYX86ANuu7o4YOC3tSxRpINOURZdEHANuP78Yif172C8nhJTw9qkv3s12bEG3gxJ9rrHHlIf78xC1xdWTO8lOCiQ7yZh6z6Q6oihZXGkHmhqclCSmvk9RSsQtvFWLcU+BTXEpVHA5H1claLG/uavXUpRwsilwluJYLzEkkNOyTzQMUhuZ4K7TamT7TacSKvL+KMXLEsnWmTVJJE2vsLwCYpylTVZIlPWJq7UMqdcMe+ZOXQgwEWBinz3UtnyNpAxo16TZeJbwEx7+GrSIrEKr3gvQptn54DhQYL5854trdAJI3pUDoVejTPmPf+5dSxBBpAUefuquvGWrVfSECXBBYPfzmexfJHSbZ+ARBspMwmNXkepibnYnJNApwKq0c2K/0IR+/G5ABLlwZDEK15xiEEZrSrHGp2+Rcq8GuAYdyJXjMLE4pKg4ixP4ny
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:23.8701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c046351c-2a3e-4920-5069-08df20b78dde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016160.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
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

Expose GUD display brightness through the connector LUMINANCE property
when DRM_LUMINANCE is enabled. Keep brightness state in the connector and
retain the asynchronous USB update path.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/gud/Kconfig         |  2 +-
 drivers/gpu/drm/gud/gud_connector.c | 48 +++++++++++++++++++++++++++--
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gud/Kconfig b/drivers/gpu/drm/gud/Kconfig
index b4d2136942f0e..6c250d3d5e203 100644
--- a/drivers/gpu/drm/gud/Kconfig
+++ b/drivers/gpu/drm/gud/Kconfig
@@ -7,7 +7,7 @@ config DRM_GUD
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
-	select BACKLIGHT_CLASS_DEVICE
+	select BACKLIGHT_CLASS_DEVICE if !DRM_LUMINANCE
 	help
 	  This is a DRM display driver for GUD USB Displays or display
 	  adapters.
diff --git a/drivers/gpu/drm/gud/gud_connector.c b/drivers/gpu/drm/gud/gud_connector.c
index 8141c3a1e30ad..bd7688676e9e1 100644
--- a/drivers/gpu/drm/gud/gud_connector.c
+++ b/drivers/gpu/drm/gud/gud_connector.c
@@ -16,6 +16,7 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+
 #include <drm/gud.h>
 
 #include "gud_internal.h"
@@ -25,6 +26,7 @@ struct gud_connector {
 	struct drm_encoder encoder;
 	struct backlight_device *backlight;
 	struct work_struct backlight_work;
+	unsigned int brightness;
 
 	/* Supported properties */
 	u16 *properties;
@@ -84,7 +86,7 @@ static void gud_connector_backlight_update_status_work(struct work_struct *work)
 	}
 
 	/* Reuse tv.brightness to avoid having to subclass */
-	connector_state->tv.brightness = gconn->backlight->props.brightness;
+	connector_state->tv.brightness = READ_ONCE(gconn->brightness);
 
 	ret = drm_atomic_commit(state);
 out:
@@ -110,6 +112,8 @@ static int gud_connector_backlight_update_status(struct backlight_device *bd)
 	struct drm_connector *connector = bl_get_data(bd);
 	struct gud_connector *gconn = to_gud_connector(connector);
 
+	WRITE_ONCE(gconn->brightness, bd->props.brightness);
+
 	/* The USB timeout is 5 seconds so use system_long_wq for worst case scenario */
 	queue_work(system_long_wq, &gconn->backlight_work);
 
@@ -132,6 +136,19 @@ static int gud_connector_backlight_register(struct gud_connector *gconn)
 		.brightness = gconn->initial_brightness,
 	};
 
+	gconn->brightness = props.brightness;
+
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		int ret;
+
+		ret = drm_connector_attach_luminance_property(connector, 0, props.max_brightness,
+							      props.brightness);
+		if (ret)
+			return ret;
+
+		return 0;
+	}
+
 	name = kasprintf(GFP_KERNEL, "card%d-%s-backlight",
 			 connector->dev->primary->index, connector->name);
 	if (!name)
@@ -314,12 +331,37 @@ static int gud_connector_atomic_check(struct drm_connector *connector,
 	return 0;
 }
 
+static void gud_connector_set_luminance(const struct drm_connector_state *conn_state);
+static void gud_connector_disable_luminance(const struct drm_connector_state *conn_state);
+
 static const struct drm_connector_helper_funcs gud_connector_helper_funcs = {
 	.detect_ctx = gud_connector_detect,
 	.get_modes = gud_connector_get_modes,
 	.atomic_check = gud_connector_atomic_check,
+	.set_luminance = gud_connector_set_luminance,
+	.disable_luminance = gud_connector_disable_luminance,
 };
 
+static void gud_connector_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_connector *connector = conn_state->connector;
+	struct gud_connector *gconn = to_gud_connector(connector);
+	unsigned int luminance = conn_state->luminance;
+
+	WRITE_ONCE(gconn->brightness, luminance);
+
+	/* The workqueue will apply it to the hardware */
+	queue_work(system_long_wq, &gconn->backlight_work);
+}
+
+static void gud_connector_disable_luminance(const struct drm_connector_state *conn_state)
+{
+	struct gud_connector *gconn = to_gud_connector(conn_state->connector);
+
+	WRITE_ONCE(gconn->brightness, 0);
+	queue_work(system_long_wq, &gconn->backlight_work);
+}
+
 static int gud_connector_late_register(struct drm_connector *connector)
 {
 	struct gud_connector *gconn = to_gud_connector(connector);
@@ -334,7 +376,9 @@ static void gud_connector_early_unregister(struct drm_connector *connector)
 {
 	struct gud_connector *gconn = to_gud_connector(connector);
 
-	backlight_device_unregister(gconn->backlight);
+	if (gconn->backlight)
+		backlight_device_unregister(gconn->backlight);
+
 	cancel_work_sync(&gconn->backlight_work);
 }
 
-- 
2.43.0

