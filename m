Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02763CA5FE5
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F282A10F995;
	Fri,  2 Oct 2026 19:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gp5N46J9";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D03D210F9AD;
 Fri,  2 Oct 2026 19:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQ8XnUKS1gFcvO2FnOuwQ9s54IvRk5hLZSctlOwU9/eRmog7OCUfkDUyQxl1vFwvp2X+phJFz+ASsG10PNf1TreLMnrtQGR7JliA7MKV82azOToXgrBtBWEJM9fpR/MG18m1jhpx7SUC7oLO1b05pTW4h99ICd4P10mmU1NAD0F8KfGS34qIM/eTaoIRpP10U2zVLDBd0BzddWgrrQ0PKaRbTJ/dqbZkdQcFVWtWEoapUdPCOKMoQ5vRgD5QEciGkGtMVJN0kfRhP4fwNPQ7voh2OpiId4qXY7V2CdixWFEzrE6bfWfxc9Dg5O3JqV7LekBwApTdUQxybfNicTitqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G177DHaoF0xAc/p3mdYZFJiOAd+6NrxUa2kNeOxAiRI=;
 b=RClPyaYNjZq1O1xuhJzGVps2CpagQFiICvSf1yrFt5o6ZgI0/HteQ2V4XjKaXbECs7pMBrG+sWVf14duqW6XSI5wSWPYULEOdIshM+s1fb/wYb3TNxqLHPSH3Nbg6caMJM/NsrIrvapWEe0mv2OmEG9hUS1kXug9cYuK4eqisZ3b1ZXY5S4skLoVeq6gP2/Hti8lo7dcD173okm6Dd478l2qjLFl8NS0hUsTojlGCnr+Yq0wsnCIyl5eCvMsBrY3kFTyQu81/z7XPvAnUTOplHc8dzftsmmPkCaZOz4ZlXbsGpOF4j6LrBv0DLUz5djoaB5ryh9RVF3BWsQOxo1WyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G177DHaoF0xAc/p3mdYZFJiOAd+6NrxUa2kNeOxAiRI=;
 b=Gp5N46J9cs9pAX4pdxxr95LpjJY5hR0CqeNi6IGhZpoWGCkuHT5xatgSZ2PcRSVbij9qSh5HdyBRYMKzkqoGh+HW9oBF/9WTEMO3EFsTvIC3DI73Iu38YrbTGzul+gGxZqehki/pVEa+qKpKURBWGv3slXj6GtHXbNoWEjRwnGI=
Received: from PH7P221CA0048.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::8)
 by DM6PR12MB4265.namprd12.prod.outlook.com (2603:10b6:5:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:01:12 +0000
Received: from MW1PEPF0001615E.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::a2) by PH7P221CA0048.outlook.office365.com
 (2603:10b6:510:33c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 19:01:11 +0000
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
 15.21.496.3 via Frontend Transport; Fri, 2 Oct 2026 19:01:11 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:01:09 -0500
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
Subject: [PATCH v9 06/21] drm/i915/display: add luminance property support
Date: Fri, 2 Oct 2026 14:00:15 -0500
Message-ID: <20261002190030.211356-7-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615E:EE_|DM6PR12MB4265:EE_
X-MS-Office365-Filtering-Correlation-Id: afe973ae-506a-4ba2-4099-08df20b7864f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|23010399003|82310400026|1800799024|18002099003|22082099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: d028qou99R4xFRBF6CH1Mv7SdFFj5Z3zSlXQeTlYNel3J/UACPSmJmHJeTIiKT8Oh8I2KcRvPBEPJA8swJZrRSzyAiN/JXJbffsdXW6gMyDkvniZ+uZJS9QzT2iTbhjabVfmzxRtqTPOnwrLWucxfCjwO1Y7RuRba8OSzR4H17Yf38DXhwkeQZW2ZjQk5FLJfeh5/MXKmIF1AwuiNS7+zN7fPCkOvQ+vUCoO3V9i9qxoyGQVsbPKp9ybyBMEsyOJ73zwS5Iim+DrRZ2kYj7nKJF2GAQSkijdW06hadpWNda8eKEzRNxDr7x6zzVte4m6WbbuloYFpgi/kE3ZyUlMUGzufmCLesbhu0k9q7/a0wpzMcusayIaz/J2rAoIpngjexPRBMR6YfqD1t1/9pF+WHLTVFwKRmuViMwDwS7TeitJjFkDWHbeOMsjExmBkknux5tT/+KNZEuBejFqeJ8BZpcGz6VKykzowzbK8xTkgXe1TvOAVcYWhiW0cYHtjM8Qd2XqDof2mJU1Y/t6FGjKtCg2j+W9jx4FYk9FpCwV84pset/8g4v5OZyZX4nR1Efa62Ttn39UF26ynxp4y/ZzuS+1R4nT9Nb6SJPzlHoNH/ZaspUyS5L1Fl1VUGMXfRkiS9lUn+JLGFrHEnSjGqffpx6s9+u+o5tp3McWQuLB+9P7MJ8P92mkdw1jBhv1o0Sg
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(82310400026)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rvmo968CS7MAEPSstwvIp+uA3K699Rihvn0qiaHLRe0fn3Ta6ouLCeGdm1Luor2I5No0IAjuiACeYzS1TjHWwhk/+5b3YIu9Xp7fMaL5bmYAwWL0PLWe5SJYZl058cUwXj8CaweYvsDwVljeoeAZkD8XhSMUjuwlWf2LgRGVTdFjK09pxQaqlHCdSHKj+Sqz0rnGIswH0DUuvjsVclaRZQJBYUltTI14gqWiuXxhzwmBZ4lr3ja5oYhL4fKDWxNkCLI2rIb/Iz+Dtq/WqVRT+hZE0dtMhXNQqnhZzEG4RYov9dOmU34NSomj9KA8cBpPMRRkLqhGhVRCa/ANuXpBjmD7jMjuQv/Do7FcmapaFEJgMgpHubSt3q/TGm37FgjKr1MIuJWKjWn3B1udy3matl38a4nZEH1C+3FyCLdHpdN8JUqjplvGkNbl9t5ijiZK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:01:11.3233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe973ae-506a-4ba2-4099-08df20b7864f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4265
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

Expose the DRM LUMINANCE connector property for eDP, LVDS, and DSI panels
when CONFIG_DRM_LUMINANCE is enabled. Keep registering the existing
backlight class device otherwise, preserving its userspace ABI.

Use the existing Intel brightness scaling and programming path from
connector helper callbacks. Apply atomic luminance after modeset enables
so updates made while a panel is inactive take effect when it is enabled
again. The shared display code provides the same behavior to i915 and Xe.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/i915/Kconfig                  |  2 +-
 drivers/gpu/drm/i915/display/icl_dsi.c        |  1 +
 .../gpu/drm/i915/display/intel_backlight.c    | 20 +++++++++++++++++++
 .../gpu/drm/i915/display/intel_backlight.h    |  1 +
 drivers/gpu/drm/i915/display/intel_display.c  |  2 ++
 drivers/gpu/drm/i915/display/intel_dp.c       |  1 +
 drivers/gpu/drm/i915/display/intel_lvds.c     |  1 +
 drivers/gpu/drm/i915/display/intel_panel.c    |  8 +++++---
 drivers/gpu/drm/i915/display/vlv_dsi.c        |  1 +
 drivers/gpu/drm/xe/Kconfig                    |  2 +-
 10 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 5e939004b6463..f2113642a7aa3 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -26,7 +26,7 @@ config DRM_I915
 	select IRQ_WORK
 	# i915 depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select BACKLIGHT_CLASS_DEVICE if ACPI && !DRM_LUMINANCE
 	select INPUT if ACPI
 	select X86_PLATFORM_DEVICES if ACPI
 	select ACPI_WMI if ACPI
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
index b128896cb1c2d..6d658c7b5d99f 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -9,6 +9,7 @@
 #include <linux/string_helpers.h>
 #include <acpi/video.h>
 
+#include <drm/drm_connector.h>
 #include <drm/drm_file.h>
 #include <drm/drm_print.h>
 #include <drm/intel/pci_config.h>
@@ -1670,6 +1671,9 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 {
 	struct intel_display *display = to_intel_display(connector);
 	struct intel_panel *panel = &connector->panel;
+	struct drm_connector *base = &connector->base;
+	u32 brightness;
+	u32 max;
 	int ret;
 
 	if (!connector->panel.vbt.backlight.present) {
@@ -1703,6 +1707,13 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 
 	panel->backlight.present = true;
 
+	max = panel->backlight.max;
+	brightness = scale_hw_to_user(connector, panel->backlight.level, max);
+	if (IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
+		ret = drm_connector_attach_luminance_property(base, 0, max, brightness);
+		drm_WARN_ON(display->drm, ret);
+	}
+
 	drm_dbg_kms(display->drm,
 		    "[CONNECTOR:%d:%s] backlight initialized, %s, brightness %u/%u\n",
 		    connector->base.base.id, connector->base.name,
@@ -1712,6 +1723,15 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 	return 0;
 }
 
+void intel_backlight_set_luminance(const struct drm_connector_state *conn_state)
+{
+	struct intel_connector *connector =
+		to_intel_connector(conn_state->connector);
+
+	intel_panel_set_backlight(conn_state, conn_state->luminance,
+				  connector->panel.backlight.max);
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
index fc30a455bed36..497d387bb6c0d 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7656,6 +7656,8 @@ static void intel_atomic_commit_tail(struct intel_atomic_state *state)
 	/* Now enable the clocks, plane, pipe, and connectors that we set up. */
 	display->modeset.funcs->commit_modeset_enables(state);
 
+	drm_atomic_helper_commit_luminance_enables(&state->base);
+
 	intel_display_power_dc3co_compute(state);
 
 	/* FIXME probably need to sequence this properly */
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 0cd5e6b5034cf..c800cffc6444d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6802,6 +6802,7 @@ static const struct drm_connector_helper_funcs intel_dp_connector_helper_funcs =
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
index 81e638d0c7b33..501573a75b89c 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -610,9 +610,11 @@ int intel_panel_register(struct intel_connector *connector)
 	struct intel_panel *panel = &connector->panel;
 	int ret;
 
-	ret = intel_backlight_device_register(connector);
-	if (ret)
-		return ret;
+	if (!IS_ENABLED(CONFIG_DRM_LUMINANCE)) {
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
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 4d7dcaff2b915..becb9a06d66bd 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -27,7 +27,7 @@ config DRM_XE
 	select IRQ_WORK
 	# xe depends on ACPI_VIDEO when ACPI is enabled
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
-	select BACKLIGHT_CLASS_DEVICE if ACPI
+	select BACKLIGHT_CLASS_DEVICE if ACPI && !DRM_LUMINANCE
 	select INPUT if ACPI
 	select ACPI_VIDEO if X86 && ACPI
 	select ACPI_WMI if X86 && ACPI
-- 
2.43.0

