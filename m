Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13F60A261E
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=orpiiK+A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D146F1127B9;
	Thu, 19 Nov 2026 23:28:14 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012064.outbound.protection.outlook.com
 [40.93.195.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072CB10E2CC;
 Thu, 19 Nov 2026 23:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNRy42VaYaOiUYkjCuB9En8YgJgD/oRqPX0lHJ+Ho6X7m/TrPF6w59NdhnpvBXhFyBGXxvxYv8Cn8FMQ+FFAxTYdeJRJF/EK5qM62v8863LFySQwryQUuYdnpNo/26DwC3P0xbom33cZXFmq33gsPDdOQoWZudGsesdJDPXhpE7cmTbGB/Vz8TOkmpF+5/McX0cITRgnTSf/W8plMPdRU/hTPrO9Vmi5aRSVDSk7XhcwDYiWC07DCW7x3kbn5kpH+OI0TGf2Ijr2fmTsyOThdB7ZdcTOgyb/nIAtk/pyBBxeWw4zkc5zygtffgwf1esqiILoyaQNI3i3cpHUBRG+qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERZyO7yO5EMzjVQCSnlgOBEhxsOi0QrEfbDM/XQD/hQ=;
 b=fYtCMgGYnK7FaR70sq+5TQcBk8QTnhztd1A3EwgKfqXqvNDc7pIpbN8GCvRnGA3u+HSH1/nfZIR7frwwdxP1nbhSspUI3lebulPhTv1AQOw81ZK7cvo9/mlahuc1koUHMai5mayV6jUGITjTl1FebPgWPHGqduCvpIKHS78kHnQPFUMsW2/me28dD0mSDRFg4yGFtsCvmDYk/gmH6D3BZG4HGGkgCpZco0YaIA5F2DIW73PM/w30JDQI8MX0C84sTJo5ZyEtQ/TW1D1WMlgS6+qGOLdJb3b13IYX9ZLhed4H4LS5Y0rpc1pEmFcn/MZUPZ7I+cPlE+Wh08zRks2wRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERZyO7yO5EMzjVQCSnlgOBEhxsOi0QrEfbDM/XQD/hQ=;
 b=orpiiK+AFE3dZxo89X7206uhfQNfgHfd0T6CxWqmDTl9NaVlJliDbVhpqeQudA+2cDX0fWojlz4WVFIOuGcQc9mC9j2OEnlLTo2f9KsuGR8nk0cLzOII87KVY1WW3qr0Te+BOIY771EU1cFc8k1GxWipLLhae+vx/Yc8lRrhslA=
Received: from SJ0PR03CA0107.namprd03.prod.outlook.com (2603:10b6:a03:333::22)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 23:27:51 +0000
Received: from PH7PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::36) by SJ0PR03CA0107.outlook.office365.com
 (2603:10b6:a03:333::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Thu,
 19 Nov 2026 23:27:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF0000000B.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 23:27:49 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 17:27:47 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Thu, 19 Nov 2026 17:27:32 -0600
Subject: [PATCH v12 05/12] drm/i915/display: add luminance property support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261119-superm1-backlight-property-v12-5-89d5217d3618@amd.com>
References: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
In-Reply-To: <20261119-superm1-backlight-property-v12-0-89d5217d3618@amd.com>
To: Maxime Ripard <mripard@kernel.org>, Alex Deucher
 <alexander.deucher@amd.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Javier Martinez Canillas <javierm@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, "Harry
 Wentland" <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, "Rodrigo
 Siqueira" <siqueira@igalia.com>
CC: Mario Limonciello <superm1@kernel.org>, Xaver Hugl <xaver.hugl@gmail.com>, 
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <amd-gfx@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <nouveau@lists.freedesktop.org>, "Mario
 Limonciello" <mario.limonciello@amd.com>
X-Mailer: b4 0.15.1
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000B:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 4536aa96-ce4c-4e55-2682-08df4694b9f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|7416014|23010399003|82310400026|36860700016|921020|261022105027099003|5023799004|56012099006|11063799006|261102123227099003|261026121527099003|261009223027099003|261026140227099003|261021123027099003|261021121427099003|261028144727099003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 0myWxen7P8lqT2IGeZZgjyPZp2mExH47QZhmqKkyAYpGHLw/G55tqyx2h3y5+PeZPszmWdAQYn1X5Ii8CirAx4VskDTctwwg51K/LygbcslYacnHUYSeVdRRdJ/DpCUXx9xm3imILCzJMV53oi5Q2Izm55mltQIiTcMELKpLnzJrOnAzmRqlCgFY+ergSqC8tYAs8TptGempfWIM+/gdaj3BE9Q4Q8xNrPGtdj912REUFYe2cFpsU25D06lao0q1RRgNikI9DHcfXjcXyy/8HFCo6yHYxECs4ej3R6EfGYF9EMdt0UasEHUsN+LbyQ9rd8WtuxkXcw3gY6FUXlT+xb962CzXJ/CBk3hQ2DsHBa/TKGQHFRYJmcaVapzfOwa5TX2Grqz8xOLS8JHYi8eylgiOPRfKsxhMErQKtCFxyDfw6T/i3iIO6FodzUjpYjVDQhZe3A+tv1cq99HeO/uGmB+puY00RnWllPmwHhSjJLRH6HogtUdFH60oXURuZYr11/V3HSAzN18/UG4dlDYxSTUX60ednLZhu0Mo67ZZlm1AVfPqEWRkYw6ktfDxVwhwoWeqN3oUpEMj5fMORK39aVB1egx6UVzVkZwarCaVlaRWgPf5BORhPnhfkR9repYAOAnZR0JOzLoqjdpQdwVB0yBucwFUwRRbWzaZBmyWQ3WVwd0xRY7gPfhUI7v3NbSpjVAkUYa0190BYby+BChYlUOPFR2vECCCmMBQTcH24syWlNHp4PdsrvaAhedD2l0U
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(23010399003)(82310400026)(36860700016)(921020)(261022105027099003)(5023799004)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261009223027099003)(261026140227099003)(261021123027099003)(261021121427099003)(261028144727099003)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4W9zzitRDjQIYIYE1CbyTtUXbKM+mgexSia5KTZSaiadjyhO/4T1H4d6leSFm7nXfvQB4Wo8P1c2xPOsTwohnH1ZnVpRg/2hDN8RPlLoljxlebTLiUwv/yRz+bQee13up7HiJZHwQGlSlAdpn/ppncxD7LHgp+/2vqPdl/PHqVUTd/0N+OzsJJ7snzO378TKIw096feiPtMeY0W7VEO2eSAaFX7yMbJC0Nqyyo44L3RbMpqNvEJjdkrYnqDr6zK8rUfiOLi5XcLuo/iqEkCLPo55v1s8xx2lZGBdO+MkcGb6WIimY62enGKf3LPrHixAZR3SsQ2uHa29G8hfBLw62oVu3jbkLpLTQIIroGeEm3WdeXoqk0y+/g5/Di+poSZGUpFPAUrAhI3MuSW4uVMKoQfee3pjIiBnDRgzidKI5CuXEfM9F6JPu0ZMq2L5rfjy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 23:27:49.7732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4536aa96-ce4c-4e55-2682-08df4694b9f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose the DRM LUMINANCE connector property for eDP, LVDS, and DSI panels
when CONFIG_DRM_LUMINANCE is enabled. Keep registering the existing
backlight class device otherwise, preserving its userspace ABI.

Use the existing Intel brightness scaling and programming path from
connector helper callbacks. Apply atomic luminance after modeset enables
so updates made while a panel is inactive take effect when it is enabled
again. The shared display code provides the same behavior to i915 and Xe.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v11:
 * Call acpi_video_backlight_use_native() before attaching LUMINANCE and
   leave the panel to acpi_video otherwise (Sashiko)
 * Enable the backlight at the committed LUMINANCE level (Sashiko)
 * Fix build with CONFIG_BACKLIGHT_CLASS_DEVICE=n (Sashiko)
 * Keep selecting BACKLIGHT_CLASS_DEVICE if ACPI (Sashiko)
 * Fall back to the backlight class device if attaching LUMINANCE fails
---
 drivers/gpu/drm/i915/display/icl_dsi.c         |  1 +
 drivers/gpu/drm/i915/display/intel_backlight.c | 74 ++++++++++++++++++++++----
 drivers/gpu/drm/i915/display/intel_backlight.h |  1 +
 drivers/gpu/drm/i915/display/intel_display.c   |  2 +
 drivers/gpu/drm/i915/display/intel_dp.c        |  1 +
 drivers/gpu/drm/i915/display/intel_lvds.c      |  1 +
 drivers/gpu/drm/i915/display/intel_panel.c     |  8 +--
 drivers/gpu/drm/i915/display/vlv_dsi.c         |  1 +
 8 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/icl_dsi.c b/drivers/gpu/drm/i915/display/icl_dsi.c
index ea0cdb7822f39..37ff84c03ce05 100644
--- a/drivers/gpu/drm/i915/display/icl_dsi.c
+++ b/drivers/gpu/drm/i915/display/icl_dsi.c
@@ -1801,6 +1801,7 @@ static const struct drm_connector_helper_funcs gen11_dsi_connector_helper_funcs
 	.get_modes = intel_dsi_get_modes,
 	.mode_valid = gen11_dsi_mode_valid,
 	.atomic_check = intel_digital_connector_atomic_check,
+	.set_luminance = intel_backlight_set_luminance,
 };
 
 static int gen11_dsi_host_attach(struct mipi_dsi_host *host,
diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index b128896cb1c2d..f9e84d17d3fb0 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -9,6 +9,7 @@
 #include <linux/string_helpers.h>
 #include <acpi/video.h>
 
+#include <drm/drm_connector.h>
 #include <drm/drm_file.h>
 #include <drm/drm_print.h>
 #include <drm/intel/pci_config.h>
@@ -76,6 +77,16 @@ static u32 clamp_user_to_hw(struct intel_connector *connector,
 	return hw_level;
 }
 
+/* Scale user_level in range [0..user_max] to [hw_min..hw_max]. */
+static u32 scale_user_to_hw(struct intel_connector *connector,
+			    u32 user_level, u32 user_max)
+{
+	struct intel_panel *panel = &connector->panel;
+
+	return scale(user_level, 0, user_max,
+		     panel->backlight.min, panel->backlight.max);
+}
+
 /* Scale hw_level in range [hw_min..hw_max] to [0..user_max]. */
 static u32 scale_hw_to_user(struct intel_connector *connector,
 			    u32 hw_level, u32 user_max)
@@ -778,6 +789,16 @@ static void __intel_backlight_enable(const struct intel_crtc_state *crtc_state,
 
 	WARN_ON(panel->backlight.max == 0);
 
+	/*
+	 * Enable at the luminance committed in this atomic state, rather than
+	 * at a stale level which would only be corrected afterwards by
+	 * drm_atomic_helper_commit_luminance_enables().
+	 */
+	if (connector->base.luminance_property)
+		panel->backlight.level =
+			scale_user_to_hw(connector, conn_state->luminance,
+					 panel->backlight.max);
+
 	if (panel->backlight.level < panel->backlight.min) {
 		panel->backlight.level = panel->backlight.min;
 		if (panel->backlight.device)
@@ -831,16 +852,6 @@ static u32 intel_panel_get_backlight(struct intel_connector *connector)
 	return val;
 }
 
-/* Scale user_level in range [0..user_max] to [hw_min..hw_max]. */
-static u32 scale_user_to_hw(struct intel_connector *connector,
-			    u32 user_level, u32 user_max)
-{
-	struct intel_panel *panel = &connector->panel;
-
-	return scale(user_level, 0, user_max,
-		     panel->backlight.min, panel->backlight.max);
-}
-
 /* set backlight brightness to level in range [0..max], scaling wrt hw min */
 static void intel_panel_set_backlight(const struct drm_connector_state *conn_state,
 				      u32 user_level, u32 user_max)
@@ -1670,6 +1681,9 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 {
 	struct intel_display *display = to_intel_display(connector);
 	struct intel_panel *panel = &connector->panel;
+	struct drm_connector *base = &connector->base;
+	u32 brightness;
+	u32 max;
 	int ret;
 
 	if (!connector->panel.vbt.backlight.present) {
@@ -1703,6 +1717,19 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 
 	panel->backlight.present = true;
 
+	/*
+	 * acpi_video_backlight_use_native() also tells the ACPI video code that
+	 * a native backlight is available. If native control should not be
+	 * used, leave the backlight to acpi_video, which is registered later
+	 * from intel_acpi_video_register().
+	 */
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE) && acpi_video_backlight_use_native()) {
+		max = panel->backlight.max;
+		brightness = scale_hw_to_user(connector, panel->backlight.level, max);
+		ret = drm_connector_attach_luminance_property(base, 0, max, brightness);
+		drm_WARN_ON(display->drm, ret);
+	}
+
 	drm_dbg_kms(display->drm,
 		    "[CONNECTOR:%d:%s] backlight initialized, %s, brightness %u/%u\n",
 		    connector->base.base.id, connector->base.name,
@@ -1712,6 +1739,33 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 	return 0;
 }
 
+void intel_backlight_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct intel_connector *connector =
+		to_intel_connector(conn_state->connector);
+	struct intel_display *display = to_intel_display(connector);
+	struct intel_panel *panel = &connector->panel;
+	u32 hw_level;
+
+	if (!panel->backlight.present)
+		return;
+
+	guard(mutex)(&display->backlight.lock);
+
+	/*
+	 * Nothing to do if __intel_backlight_enable() already programmed this
+	 * level as part of a modeset enable.
+	 */
+	hw_level = scale_user_to_hw(connector, conn_state->luminance,
+				    panel->backlight.max);
+	if (hw_level == panel->backlight.level)
+		return;
+
+	panel->backlight.level = hw_level;
+	if (panel->backlight.enabled)
+		intel_panel_actually_set_backlight(conn_state, hw_level);
+}
+
 void intel_backlight_destroy(struct intel_panel *panel)
 {
 	/* dispose of the pwm */
diff --git a/drivers/gpu/drm/i915/display/intel_backlight.h b/drivers/gpu/drm/i915/display/intel_backlight.h
index 339643f638978..1634ce414695a 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.h
+++ b/drivers/gpu/drm/i915/display/intel_backlight.h
@@ -32,6 +32,7 @@ void intel_backlight_set_acpi(const struct drm_connector_state *conn_state,
 			      u32 level, u32 max);
 void intel_backlight_set_pwm_level(const struct drm_connector_state *conn_state,
 				   u32 level);
+void intel_backlight_set_luminance(const struct drm_connector_state *conn_state);
 u32 intel_backlight_invert_pwm_level(struct intel_connector *connector, u32 level);
 u32 intel_backlight_level_to_pwm(struct intel_connector *connector, u32 level);
 u32 intel_backlight_level_from_pwm(struct intel_connector *connector, u32 val);
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index c1c2b99cfb53b..f87c78e316a5d 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7845,6 +7845,8 @@ static void intel_atomic_commit_tail(struct intel_atomic_state *state)
 	/* Now enable the clocks, plane, pipe, and connectors that we set up. */
 	display->modeset.funcs->commit_modeset_enables(state);
 
+	drm_atomic_helper_commit_luminance_enables(&state->base);
+
 	intel_display_power_dc3co_compute(state);
 
 	/* FIXME probably need to sequence this properly */
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index ef164a7976187..905c8743a2a2b 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -7060,6 +7060,7 @@ static const struct drm_connector_helper_funcs intel_dp_connector_helper_funcs =
 	.get_modes = intel_dp_get_modes,
 	.mode_valid = intel_dp_mode_valid,
 	.atomic_check = intel_dp_connector_atomic_check,
+	.set_luminance = intel_backlight_set_luminance,
 };
 
 enum irqreturn
diff --git a/drivers/gpu/drm/i915/display/intel_lvds.c b/drivers/gpu/drm/i915/display/intel_lvds.c
index 872753478cf21..fa668b1debb21 100644
--- a/drivers/gpu/drm/i915/display/intel_lvds.c
+++ b/drivers/gpu/drm/i915/display/intel_lvds.c
@@ -502,6 +502,7 @@ static const struct drm_connector_helper_funcs intel_lvds_connector_helper_funcs
 	.get_modes = intel_lvds_get_modes,
 	.mode_valid = intel_lvds_mode_valid,
 	.atomic_check = intel_digital_connector_atomic_check,
+	.set_luminance = intel_backlight_set_luminance,
 };
 
 static const struct drm_connector_funcs intel_lvds_connector_funcs = {
diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 81e638d0c7b33..9e2a53f300d39 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -610,9 +610,11 @@ int intel_panel_register(struct intel_connector *connector)
 	struct intel_panel *panel = &connector->panel;
 	int ret;
 
-	ret = intel_backlight_device_register(connector);
-	if (ret)
-		return ret;
+	if (!connector->base.luminance_property) {
+		ret = intel_backlight_device_register(connector);
+		if (ret)
+			return ret;
+	}
 
 	if (connector->base.connector_type == DRM_MODE_CONNECTOR_DSI ||
 	    connector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
diff --git a/drivers/gpu/drm/i915/display/vlv_dsi.c b/drivers/gpu/drm/i915/display/vlv_dsi.c
index 8829f365592ef..7e60407e0af4a 100644
--- a/drivers/gpu/drm/i915/display/vlv_dsi.c
+++ b/drivers/gpu/drm/i915/display/vlv_dsi.c
@@ -1555,6 +1555,7 @@ static const struct drm_connector_helper_funcs intel_dsi_connector_helper_funcs
 	.get_modes = intel_dsi_get_modes,
 	.mode_valid = vlv_dsi_mode_valid,
 	.atomic_check = intel_digital_connector_atomic_check,
+	.set_luminance = intel_backlight_set_luminance,
 };
 
 static const struct drm_connector_funcs intel_dsi_connector_funcs = {

-- 
2.43.0

