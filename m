Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C13EC61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20F9510EB2E;
	Mon, 31 Aug 2026 21:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hr0SuJTg";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013002.outbound.protection.outlook.com
 [40.93.201.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81D9C10EB34;
 Mon, 31 Aug 2026 21:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSCRwBIiiy8h0GKMZUj9sFlrodrg6oUOWirSpvNbpY7+co5gXJ1Lv5Y7pMY34hh3UFVD1ZeU5khBTIuo/gOnQvjqnnwtmYHr8WpfY3CUMWKhSNoGzsCDWlDvQAli6zF7oSjNnLHesq2K1HUq15dTN7vzQE8JTcrHUylZ8nIzi6++MKzMP+TkF3b1GuzEsp/EIOe9frDqxv0BV+a2SR3qXMO8Rbzw7/120pO71kis5/O+9UEDrXtqYV4N5erGBMPX5ZNBjpu7GeuParRQOck0aTsCUIPQudfht4le1omheCCyOA2+H6xzW321eO9DI+6VBPGVJvTWOyN2tbGS76MlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZo8I75W+2/gOlDpvj7cE82LSCy3v731sOAFrK4DrwA=;
 b=tR8E62smXV+JkYmHZUDugidXPw2/ITzvuOMzjoliE2hV+OPTG5riO+zmZ+LSywTaYUkViTJ27dfkpLRmQox7ks/fAH6JZeVzFirbYI9sIKlnURpte71IeCgixoZwYD+mELXMlg2HZO2EJ7JSKzWmTJXYnfsP5dhY2dPR+0xehdJpDRJEHt1LvC8NVpEfoo3b/UTCdT2uYUjBsuiARIHh5/xqVDz2WSazlMWn8QhXMGVbfK5Rmxr99cfFB0G640cOR4XdHMRnlg744J4Phiq/KR2rutZv5zlRpxeSxARV5eU/xXwVesac5sgwAypX2WKxTeNBHKhnPFMansdh3eDLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZo8I75W+2/gOlDpvj7cE82LSCy3v731sOAFrK4DrwA=;
 b=hr0SuJTgVKiJZ235VNDXA14LtRzZJRxamOcGBH8WqEDLrK88tnRA00AMCq9BnhflJknN1ojsghechq09Wi7k7/R6jlOliulKN0E1qbZpPUNziot2z2k39ddbG1NpaGBbr2YY5Fbxv2zn+wQFLVO+KdK9Fviql5EYGW38QcG2z8Q=
Received: from BN9PR03CA0209.namprd03.prod.outlook.com (2603:10b6:408:f9::34)
 by CH3PR12MB9080.namprd12.prod.outlook.com (2603:10b6:610:1a7::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:06:09 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::af) by BN9PR03CA0209.outlook.office365.com
 (2603:10b6:408:f9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:06:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:06:09 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:06:07 -0500
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
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v7 12/12] drm/i915/display: use drm backlight
Date: Mon, 31 Aug 2026 16:05:31 -0500
Message-ID: <20260831210531.2334221-13-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831210531.2334221-1-mario.limonciello@amd.com>
References: <20260831210531.2334221-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|CH3PR12MB9080:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a726278-19ef-47f6-54cf-08df07a3ae2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|1800799024|82310400026|36860700016|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: jyIIiLJ38cKN//blaPAJf/IBD6bcGqYujmJCPNOpLuUZp8y3LbVXrehRl2ZE/nHQraI0YtU2dUZTtD8SpElkxI7anq5JQ+eVtce5wngVz7Bs4/ZUHX29EuiX2DGrWLzkgB7n04M03SDBhGpokWj307opCLrH0oEQCltFviUhqddVbpTiJVjIiJoIyPz4gseaS/VJtZo5Jsh5+lXIdBeSJpcJ/U4X48X5Uf7z2XIyKashkPxz84lk2owumFE7VVR+K3+iuh5Sx2BvRJ7fOp63AKLHlHMlUk1fJFbJmaZRZBsCS8F0BL8kjpp/Fc84DTzM1DdHnb238Qh67/tSR0yxU19+bIa8zlNINsj6FlU7i8W1tteCYDGHXrrBPRGbvXma2EgrcqsS8OiPVyxfaf2toieS8jCPS3uQbzLjft4+WPlsxldctHyeqQHamElENloW+d+OmswPzqmelwocOPk84rO/+wgT2VVrtNlStX2FmxpRNhFM5W0DyuRvidWYsi9YEVsDT5AyQODrvQ2NwozL5KKsg0nUZp4eFJ0Ik6DoSG65JTTpmmhf/hdXjetj2zde4lhT7y04+jZCMAsnRHR6q5pUnZ3y6phwWbk3dy2WR3b3eShUC+qwvQIm7qu7p8tHm3ufSLNF3dL46USEkOdmzPMAYtsaiu0SlaBFC50VhVzsq1xQRJH5eoUbmwRTs+4mjR25RuHwJsnMRpO0nj31Rw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vLt3vmt9iw320+FigYT79YFvEqf9cX3HIcdNtE2Ak7PtxSwSBrqvxu8iZ1EgikeKbI7hzjFa/LwIIiCc3z3zuEc/jj+6SRgQhj+Y78Ey6Yc7NTxN9bhc52U44rjDb8w2Xar1UV2W9pBRjHdbY0/r2fyZQVNUlax2LvjxIwvU+ZEMKc5ksDYUBcsweQ3lb5HnR2w1kD0teHkyVzrPaMkHTLdR1cDmpGUmlkZcpgOEt2BFseJ/LWeh+RW5GfzSukYhU/aozz7/LtpGfW6SzO6ZwwvouA+8Z+Qps+0G00DkqUguCbQJgQd/SjPZfFuHE56Aa1QkncvUjC77j7kNEt6l3d6v1QRoCy/KUq2AjpABX5FyphaZvUP3i+8UabD/vNFl4Rfy0hGYMG7/nilzoqCXsTeZfVNHP0WvpSXBFD2Xhnz3+wZv/J99whEv4UDUpg05
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:06:09.2592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a726278-19ef-47f6-54cf-08df07a3ae2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9080
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

Convert the Intel display drivers (i915 and xe) to the DRM backlight
infrastructure so brightness can be controlled through the connector
LUMINANCE property. Link the backlight device to the eDP connector on
registration and unlink it on unregistration; the DRM core owns the
embedded backlight state and its property.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/i915/display/intel_backlight.c | 4 ++++
 drivers/gpu/drm/i915/display/intel_display.c   | 7 ++++++-
 drivers/gpu/drm/i915/display/intel_dp.c        | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index b128896cb1c2d..b0cd4dc3adc00 100644
--- a/drivers/gpu/drm/i915/display/intel_backlight.c
+++ b/drivers/gpu/drm/i915/display/intel_backlight.c
@@ -9,6 +9,7 @@
 #include <linux/string_helpers.h>
 #include <acpi/video.h>
 
+#include <drm/drm_backlight.h>
 #include <drm/drm_file.h>
 #include <drm/drm_print.h>
 #include <drm/intel/pci_config.h>
@@ -1004,6 +1005,8 @@ int intel_backlight_device_register(struct intel_connector *connector)
 		    "[CONNECTOR:%d:%s] backlight device %s registered\n",
 		    connector->base.base.id, connector->base.name, name);
 
+	drm_backlight_link(&connector->base, bd);
+
 out:
 	kfree(name);
 
@@ -1015,6 +1018,7 @@ void intel_backlight_device_unregister(struct intel_connector *connector)
 	struct intel_panel *panel = &connector->panel;
 
 	if (panel->backlight.device) {
+		drm_backlight_link(&connector->base, NULL);
 		backlight_device_unregister(panel->backlight.device);
 		panel->backlight.device = NULL;
 	}
diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
index 9dfd095f325f7..d53e5f4bdf57d 100644
--- a/drivers/gpu/drm/i915/display/intel_display.c
+++ b/drivers/gpu/drm/i915/display/intel_display.c
@@ -7496,10 +7496,12 @@ static void intel_atomic_commit_tail(struct intel_atomic_state *state)
 	struct intel_display *display = to_intel_display(state);
 	struct intel_uncore *uncore = to_intel_uncore(display->drm);
 	struct intel_crtc_state *new_crtc_state, *old_crtc_state;
+	struct drm_connector_state *new_conn_state;
+	struct drm_connector *connector;
 	struct intel_crtc *crtc;
 	struct intel_power_domain_mask put_domains[I915_MAX_PIPES] = {};
 	struct ref_tracker *wakeref = NULL;
-	int power_async_delay;
+	int power_async_delay, i;
 
 	for_each_new_intel_crtc_in_state(state, crtc, new_crtc_state)
 		intel_atomic_dsb_prepare(state, crtc);
@@ -7608,6 +7610,9 @@ static void intel_atomic_commit_tail(struct intel_atomic_state *state)
 	/* Now enable the clocks, plane, pipe, and connectors that we set up. */
 	display->modeset.funcs->commit_modeset_enables(state);
 
+	for_each_new_connector_in_state(&state->base, connector, new_conn_state, i)
+		drm_atomic_helper_connector_apply_luminance(new_conn_state);
+
 	intel_display_power_dc3co_compute(state);
 
 	/* FIXME probably need to sequence this properly */
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 113d767e62e9c..2381a80a4e671 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -43,6 +43,7 @@
 #include <drm/display/drm_dsc_helper.h>
 #include <drm/display/drm_hdmi_helper.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_fixed.h>
-- 
2.43.0

