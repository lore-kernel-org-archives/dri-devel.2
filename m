Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14E4C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 938A910E9DB;
	Tue,  8 Sep 2026 04:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XBdqpzJH";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8706010E9C8;
 Tue,  8 Sep 2026 04:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvYhJQ+Ru3+522OltMfLACkBZX6NGiwMPiUuM2zNrxPyhsiKI6UvZgo1Nt2Ms1xHXLpKjNqUKQQbVh8U8Isrsp2McVfHWr62SrxKpgk2Vfy3tBHmZdr/JJcJlf0UwW5+MJCJtAN4We72oYRNuPljh0TszBl6/1VlO0sZ31GPnDzw8FV0xudjz7XTZ7J4q+4w2DL87OfmeBwBuVWnsUE9OnLEPSTpVTpfSzSXS5T+Gnu0HcqLvunTTBWuc8SCW8IBWW5UiLOJQGmH57DIAGJydhUEdISWvceog0i8MrKWDDnfY+MLZiYkBcvnp/muMR0zSRl3V+zTFfhqAEwPvp+Pcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f1snRTPQk0QZ9/kSGzjFRZHdaQ1t1A+9LRQWdULndog=;
 b=Sh0NYI9uRl76Hpfm5TAVxT4HGRp0O+WRruoZ7irN66KdrIT2Xb/kzuvoW8EmamDTDiOlEib0PTo2b0g4xpY5ac8u9kNZAHkzXfb5HP2aoGeHSU1tq6mhHedcRynB+M69EiAkHRjPI5NlIbVmfQiz2AEniXjGRi+EL1Ez2aGLxwLBuHdaTm81DBMcd5ze7p2RQu//XvVFyPpSKUvv8NI1TU99P6MUyuRIz39VmVGhhlBurVLQAwV/XdVJSHgW1OunJ1Usep3EuczIDVrzMzB7YN2kHYc6Ov8ieNYyyJexwK9gvosiRvbw6ReP+AjQ2D6x5N5pg/j28DFNopOeYn43aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f1snRTPQk0QZ9/kSGzjFRZHdaQ1t1A+9LRQWdULndog=;
 b=XBdqpzJHGMKYNBxf2GZjnvKt1TZNel5j3R4MO2ZC5oaAIqUo7hJsClFLLQQPSQajDgRXFtf7bgPni7zLBzgUurej4kWYdC1UHpMDk9IqdgvXlV/2AtainZXM7eVc5dfDWWrI11Swh6kxstKgPOUf1bVqkJBflvS1NkRI/jqTmQc=
Received: from CY8PR12CA0048.namprd12.prod.outlook.com (2603:10b6:930:49::11)
 by CY3PR12MB9629.namprd12.prod.outlook.com (2603:10b6:930:101::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:41:12 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::67) by CY8PR12CA0048.outlook.office365.com
 (2603:10b6:930:49::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:41:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:41:12 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:41:10 -0500
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
Subject: [PATCH v8 14/14] drm/i915/display: use drm backlight
Date: Mon, 7 Sep 2026 23:40:35 -0500
Message-ID: <20260908044035.62093-15-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|CY3PR12MB9629:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7da662-2b1f-4bbd-4c97-08df0d636932
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JTU0NmYqvhWo8yJdmX3+/s9cj1CF3JatGlXzge4QKN5z6jrpKUY2sPWr1KuPDVZroSmlzpDoimUKKYQL/4M1oEEKFHxTqCqIkrXoDLRbuZZioFkVgTUpi1yaUjwWtXlQO+9emYBeai3jYz5N+Zx89/KLt19JXOpsoK3DWVWwqznU007utMB61cwjpabAR8n9OclFkSGcQLD9RgVzyHIcg5NeyLNU3hisxVhfZPRVv3xR8L/SO+13+qMukXf5V35saEvb0v/nuY6gqdhEXAZAJLUZX5IhxiRyFtibKM/2B46O01/Nls94cTqbtbrEwSiNBLinzxS413VjxdUr0Uq5HDF4tes6XqC2auplA0p1LDKidJRywLKjMzxIeCOnTrU4J7Qxj77G7TjXfwpT0ZoDoery9PUu6lP7xXJR/JlvWwifT9DGESrvpyLOYBVpyRhzTzvcWjLpo3s8x1hKfe6S2KqSiU4aThZ5wuJ7+1YTBuS5pr++fFd3X+U3cN7LcBjkk9D53xCFlN4oe9ovVBRKinYvGisA0CditoQ/bPVElMJcqZN1nKOKLLN9JFcts98ZD9W4z83IQJ/7jFmrY3/iCLu/zue0F9rfOyC4rb1k4Z/AW9zx7cZ817T2Z8uNU+8XSP75aBsJdDGC76NcdvozNa9XJWwprl1zAiY0dq6SCMz4UeS7NEDjCd8ObrK7a6aa4iEVEUuh6ErAxKlM++IetQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: G5HVP41uvCCAH/joMqKvQIg0lGVs2UjIub6PkJMTGci9UWNDHSMsOQVfm4Y2RqEkj65LY62XftTwlmFvCZLfljLasyt4l/536+2/mmshdS9N8WQss8UAHn0kFZikbcHG0OVQ/ejYKF05/s0HZaoNShujy/0r6/J2zBcHRK548v5FIOCGQqB6Kiq/Ig7PtM8V3hF0EFxjHl7TkZwDrXNDcz5GXMTrvbfoqBzEDYN343jdkssRki+6KhyBTmOdibNpcDGw6eL+eBalWslkDfAvQ03yTHdCaBopMfZY8916GibX8/vnZMtknV9mFFhZlQzD8qqqZgWQhu2PO2OwVQpcY2YP09ozU+g4rWPMs6WtnAyXPJbotqjyzyEe1JZNOP6E2xtbrttVFQXa2RUtMXx4oL+rIbTgaNkPFhhvo/Q7kgieIV2kZVC0VaAlPh2mdLrY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:41:12.6842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7da662-2b1f-4bbd-4c97-08df0d636932
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9629
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
 drivers/gpu/drm/i915/display/intel_backlight.c | 6 ++++++
 drivers/gpu/drm/i915/display/intel_display.c   | 7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_backlight.c b/drivers/gpu/drm/i915/display/intel_backlight.c
index b128896cb1c2d..3ed8c4f7af425 100644
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
@@ -1703,6 +1707,8 @@ int intel_backlight_setup(struct intel_connector *connector, enum pipe pipe)
 
 	panel->backlight.present = true;
 
+	drm_backlight_create_property(&connector->base, panel->backlight.max, false);
+
 	drm_dbg_kms(display->drm,
 		    "[CONNECTOR:%d:%s] backlight initialized, %s, brightness %u/%u\n",
 		    connector->base.base.id, connector->base.name,
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
-- 
2.43.0

