Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5241EC624D5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8728510EB2D;
	Mon, 31 Aug 2026 21:06:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Xzcqm8nF";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012018.outbound.protection.outlook.com
 [40.93.195.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65DEB10EB16;
 Mon, 31 Aug 2026 21:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HFJpGOZqBUpdvxSsqKqG0lRZLF/qddo3FOn2yKbVJzx0G0umyy6p144NTMtLfJ2uzD9ayD4FzD9W63Q104VBQOatQaC8DS5qDRpAHoN+KuLDo6CD0fpqHe0KCEJjm6gYTkW4EpZybX7Er6vfhyh2tzuDHzHBJtQmd2aN3imLEG8srv6uUfEVZDTbPIxgABRCxTMcgW2snRLQTuQEi15OIx9rffOxNeZGXjTejud8dLbqkgyN2noJW+01Uiw+lY3/uWHYnG2ZUJNNRqggzgYTyfyf8utgWBS7n9jn9p7ZBYW5xSLC5kaEu7MLAntH2rBfA9xTkXgIw7CkTPj1ONfWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2oXsiVLqnVuWj5xAdeMUBrhsVGHnhvF7jl4FEdLDYc=;
 b=TYRMRcodk7Ps57ouYX4zgUKtdkdVKZhfM53aVoq4Ns6+bN8X9uOvrjqkGI9Ufi3WC7VjtSomQjGxDXF3rOJdb8dsRai/+eHVQVKp5CWQSq3a62N8qWQpC9BikDytJfvqmMLAsPx0zySnYmjSUIxn90Y+2QcihCoNhw8EAKgAeyeaDoBFB/eo/D1Av+RtqkUDwS4hdJQavEGxdmTxu+pMM71r4TWZ0ocCaDtRfnlcqkS/xDXiC0M1N8mQhE52sDnkCckLy6ql+XzI7qeKxlMwv+Osq7Fcaq14ZbFRoqqzoklohtJnnAuJOKgyckQ5GyK9tx0d6ey+eWlk1GYXVr/Ayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H2oXsiVLqnVuWj5xAdeMUBrhsVGHnhvF7jl4FEdLDYc=;
 b=Xzcqm8nFsL5npijUScXjaKKrt6PrTKQg7XJDYQYUgZ06XpNvZDvo2QY7tWzhHIXlDZGKIm2FRKcDB3gqdHfxPH2bYrq9m+oYs4/HtpnI3G966UWGksOin+L9jn1WbHbWWGEI37uGEFDyil4E+lh2RugGmv2pGSrKlAc7YYqFVDw=
Received: from LV3P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::33)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 31 Aug
 2026 21:05:57 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::42) by LV3P220CA0001.outlook.office365.com
 (2603:10b6:408:234::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:05:57 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:05:54 -0500
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
 <hansg@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, "David
 Herrmann" <dh.herrmann@gmail.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v7 04/12] drm: add connector backlight (LUMINANCE)
 infrastructure
Date: Mon, 31 Aug 2026 16:05:23 -0500
Message-ID: <20260831210531.2334221-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SJ2PR12MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb0ec56-518a-40e3-bbba-08df07a3a6f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|7416014|23010399003|18002099003|5023799004|56012099006|22082099003|3023799007|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 41rpgVRp7pgK2U8nG6VfDaxsFynEEa6fJFt3FE4lCrSAb5wf8QeFgjssN7vBhwW0/GQmniilyS2CaBMTjV7XYta3+AWaTlsxkWkXFqQBw03bMERpW0Uyi59oUgyMNxzR2+50OpflHFfObSIMQmA5nuF3e7IFsvcEi4HlembSvvM44Rs5vIK9yZAMf5nZT+BJiWJNaE8aCkuDuGn9TH0uvt6Wig/mBjkeOvyLitSZj2g3K012yHM+IA1BIeaz5198elPcno0b/SpKhjXm1nvZ7cPAcW6c6pJkvIwT+8I7HDP4AvPRjjgORET4XzWViOeKPLtlu8VSRzUhZFVMvqRZefl0BSWD4cetfWzbAD7YkgUNPve46D7o7erUxFQnjVWGawg8lKe7T4DtLnBzZo7apeiajimV7giS42FTX8XfN9FtWzBVLg4mc+3zLbu/RePUfK2WZjDURWNht75maVAZe/Y2tMC2fLRgMCZB3bPGutoG0+wBRIBmaCwNkRjoNjd3YM5B3vxHu/QcyUJwo54QUUNUtKjWuMfUTdxJobX6v3X/zG7GgDd+2fLwFmd5sn2Q7EaGVrhel3uWILXrYP70ds+voOf4pkt1NkCDYQmgwq+42YNg2e5R5nZxnB54Zkbad/p9Aiuhl56PI/8DBitt7WUrezFCCHqZuRRyH6MkFKloG1Tdl+TXcScs53eNEWzl+KvQBpChSjYUrcFCA2OmVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(7416014)(23010399003)(18002099003)(5023799004)(56012099006)(22082099003)(3023799007)(11063799006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FcuwGRnAyHn7HnnAmyGOf9C8qslhyyS+NffJxk0xeHFZG/6/f/r+kX3tgC0mfyIassDq+syWtkZIFwnGbLIjV4U/XSgvEJ+GH3nmesJZlugEUhJYCm+h6I1abpCN+PgIWDtBxfnP/glYkPdV9ymmToQ8PON5zkfxTOHiL4IbsejPT/25vEmP+IuQfveUn8ydfPYkdRfgCwgN/IHfZREMd/aoCirwEnz+P0GXQW61HZuIwCnE0M3Jc5ZxLEx0AnrNCAYKfjJmxr/DbnnRzn5LccVX6MOtG7J623iZYVnNJLy4q4YZV9820oQYwcWu2KsE7y9Yb1fWWbhQ96GNXvLZW1XXh60G9WybdAt2qh45YD/YBri9CTP7dvaaF+gNv19DXi+jjO5vDsH4hROQ6RRv2Aw3Jqth7LzCV9EWR5e8CFYFU8QwcGuUApdxiIewWv+U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:05:57.1623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb0ec56-518a-40e3-bbba-08df07a3a6f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183
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

Backlight brightness is a property of a display, and thus of a DRM
connector, yet it has historically only been controllable through the
separate backlight sysfs interface. Add a generic, backend-agnostic
per-connector LUMINANCE range property so brightness can be driven
through the atomic modeset path like any other connector state.

A struct drm_backlight is embedded in every connector and initialized by
the core; drivers do not allocate it. A driver links a backend (today a
backlight_device, in the future DDC/CI, MIPI-DCS, ...) with
drm_backlight_link(), which creates the connector's LUMINANCE property
with the backend's range. The property value is staged into the atomic
connector state and only pushed to the hardware from the commit/enable
path, via a workqueue so that slow backends never stall a commit. DPMS
off drives the backlight to 0 and DPMS on restores the committed value.

The property range is per-connector (created from the backend's
max_brightness), so multiple panels no longer share and corrupt a single
device-wide range. drm_backlight_link() also carries the legacy-sysfs
takeover accounting used by the client capability added in a later patch.

The whole feature is guarded by CONFIG_DRM_BACKLIGHT (which depends on,
rather than selects, BACKLIGHT_CLASS_DEVICE) so DRM does not pull the
backlight subsystem into the kernel when it is not wanted.

Co-developed-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/Kconfig             |  18 +
 drivers/gpu/drm/Makefile            |   2 +
 drivers/gpu/drm/drm_atomic_helper.c |  39 +++
 drivers/gpu/drm/drm_atomic_uapi.c   |  49 ++-
 drivers/gpu/drm/drm_backlight.c     | 515 ++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c     |  56 +++
 drivers/gpu/drm/drm_drv.c           |   8 +
 drivers/gpu/drm/drm_mode_config.c   |   1 +
 drivers/gpu/drm/drm_sysfs.c         |  26 +-
 include/drm/drm_atomic_helper.h     |   2 +
 include/drm/drm_backlight.h         | 158 +++++++++
 include/drm/drm_connector.h         |  20 ++
 12 files changed, 890 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_backlight.c
 create mode 100644 include/drm/drm_backlight.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 323422861e8f6..ddb6827d613f8 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -33,6 +33,24 @@ endmenu
 
 if DRM
 
+config DRM_BACKLIGHT
+	bool "DRM connector backlight (luminance) support"
+	depends on DRM
+	depends on BACKLIGHT_CLASS_DEVICE
+	default DRM
+	help
+	  Expose per-connector backlight brightness control through the DRM
+	  connector LUMINANCE property, backed by the backlight subsystem (and,
+	  in the future, other backends such as DDC/CI). This lets luminance
+	  changes go through the same atomic modeset path as the rest of the
+	  display state.
+
+	  This depends on BACKLIGHT_CLASS_DEVICE. When that is disabled, DRM is
+	  built without this support and does not pull the backlight subsystem
+	  into the kernel.
+
+	  If in doubt, say Y.
+
 config DRM_MIPI_DBI
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e635fcffd3790..bcb06dbb71343 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -78,6 +78,8 @@ drm-$(CONFIG_DRM_CLIENT) += \
 	drm_client_event.o \
 	drm_client_modeset.o \
 	drm_client_sysrq.o
+drm-$(CONFIG_DRM_BACKLIGHT) += drm_backlight.o
+drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
 drm-$(CONFIG_COMPAT) += drm_ioc32.o
 drm-$(CONFIG_DRM_PANEL) += drm_panel.o
 drm-$(CONFIG_OF) += drm_of.o
diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 285aac3554dfd..3603a8cce074e 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -33,6 +33,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_blend.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_colorop.h>
@@ -1230,6 +1231,10 @@ drm_atomic_helper_commit_encoder_bridge_disable(struct drm_device *dev,
 		 * it away), so we won't call disable hooks twice.
 		 */
 		bridge = drm_bridge_chain_get_first_bridge(encoder);
+
+		/* Turn the backlight off before disabling the pipeline. */
+		drm_backlight_set_luminance(connector, 0);
+
 		drm_atomic_bridge_chain_disable(bridge, state);
 		drm_bridge_put(bridge);
 
@@ -1744,6 +1749,10 @@ drm_atomic_helper_commit_encoder_bridge_enable(struct drm_device *dev, struct dr
 
 		drm_atomic_bridge_chain_enable(bridge, state);
 		drm_bridge_put(bridge);
+
+		/* Restore the backlight once the pipeline is enabled. */
+		if (connector->state)
+			drm_atomic_helper_connector_apply_luminance(connector->state);
 	}
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_encoder_bridge_enable);
@@ -1775,6 +1784,24 @@ void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_atomic_helper_commit_modeset_enables);
 
+/**
+ * drm_atomic_helper_connector_apply_luminance - apply connector luminance from atomic state
+ * @conn_state: atomic connector state to apply luminance for
+ *
+ * Updates the backlight luminance from the atomic connector state. If the
+ * connector has a linked backlight and is associated with an active CRTC,
+ * push the luminance value to hardware.
+ */
+void drm_atomic_helper_connector_apply_luminance(const struct drm_connector_state *conn_state)
+{
+	struct drm_connector *connector = conn_state->connector;
+
+	if (conn_state->crtc && conn_state->crtc->state &&
+	    conn_state->crtc->state->active)
+		drm_backlight_set_luminance(connector, conn_state->luminance);
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_apply_luminance);
+
 /*
  * For atomic updates which touch just a single CRTC, calculate the time of the
  * next vblank, and inform all the fences of the deadline.
@@ -1989,6 +2016,9 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_flip_done);
 void drm_atomic_helper_commit_tail(struct drm_atomic_commit *state)
 {
 	struct drm_device *dev = state->dev;
+	struct drm_connector *connector;
+	struct drm_connector_state *new_conn_state;
+	int i;
 
 	drm_atomic_helper_commit_modeset_disables(dev, state);
 
@@ -1996,6 +2026,9 @@ void drm_atomic_helper_commit_tail(struct drm_atomic_commit *state)
 
 	drm_atomic_helper_commit_modeset_enables(dev, state);
 
+	for_each_new_connector_in_state(state, connector, new_conn_state, i)
+		drm_atomic_helper_connector_apply_luminance(new_conn_state);
+
 	drm_atomic_helper_fake_vblank(state);
 
 	drm_atomic_helper_commit_hw_done(state);
@@ -2019,11 +2052,17 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_tail);
 void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_commit *state)
 {
 	struct drm_device *dev = state->dev;
+	struct drm_connector *connector;
+	struct drm_connector_state *new_conn_state;
+	int i;
 
 	drm_atomic_helper_commit_modeset_disables(dev, state);
 
 	drm_atomic_helper_commit_modeset_enables(dev, state);
 
+	for_each_new_connector_in_state(state, connector, new_conn_state, i)
+		drm_atomic_helper_connector_apply_luminance(new_conn_state);
+
 	drm_atomic_helper_commit_planes(dev, state,
 					DRM_PLANE_COMMIT_ACTIVE_ONLY);
 
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1050dddadb17e..5e687600ce45e 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -30,6 +30,8 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_backlight.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
@@ -962,6 +964,13 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->hdmi.broadcast_rgb = val;
 	} else if (property == connector->color_format_property) {
 		state->color_format = val;
+	} else if (property == connector->luminance_property) {
+		/*
+		 * Only stage the value into the atomic state; the hardware is
+		 * updated from the commit path (see
+		 * drm_atomic_helper_connector_apply_luminance()).
+		 */
+		state->luminance = val;
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -1049,6 +1058,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->hdmi.broadcast_rgb;
 	} else if (property == connector->color_format_property) {
 		*val = state->color_format;
+	} else if (property == connector->luminance_property) {
+		*val = state->luminance;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
@@ -1133,6 +1144,22 @@ static struct drm_pending_vblank_event *create_vblank_event(
 	return e;
 }
 
+static void drm_atomic_crtc_set_backlight(struct drm_crtc *crtc, bool active)
+{
+	struct drm_connector_list_iter conn_iter;
+	struct drm_connector *connector;
+
+	drm_connector_list_iter_begin(crtc->dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (!connector->state || connector->state->crtc != crtc)
+			continue;
+
+		drm_backlight_set_luminance(connector,
+					    active ? connector->state->luminance : 0);
+	}
+	drm_connector_list_iter_end(&conn_iter);
+}
+
 int drm_atomic_connector_commit_dpms(struct drm_atomic_commit *state,
 				     struct drm_connector *connector,
 				     int mode)
@@ -1155,9 +1182,29 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_commit *state,
 	if (connector->dpms == mode)
 		goto out;
 
+	crtc = connector->state ? connector->state->crtc : NULL;
+
+	/* Handle backlight brightness coordination with DPMS state changes */
+	if (old_mode != DRM_MODE_DPMS_OFF && mode == DRM_MODE_DPMS_OFF) {
+		/* DPMS ON -> OFF: dim all connectors driven by this CRTC. */
+		if (crtc)
+			drm_atomic_crtc_set_backlight(crtc, false);
+		else
+			drm_backlight_set_luminance(connector, 0);
+	}
+
 	connector->dpms = mode;
 
-	crtc = connector->state->crtc;
+	/* DPMS OFF -> ON: restore brightness to property value */
+	if (old_mode == DRM_MODE_DPMS_OFF && mode == DRM_MODE_DPMS_ON &&
+	    connector->state) {
+		if (crtc)
+			drm_atomic_crtc_set_backlight(crtc, true);
+		else
+			drm_backlight_set_luminance(connector,
+						    connector->state->luminance);
+	}
+
 	if (!crtc)
 		goto out;
 	ret = drm_atomic_add_affected_connectors(state, crtc);
diff --git a/drivers/gpu/drm/drm_backlight.c b/drivers/gpu/drm/drm_backlight.c
new file mode 100644
index 0000000000000..4251cb25079c3
--- /dev/null
+++ b/drivers/gpu/drm/drm_backlight.c
@@ -0,0 +1,515 @@
+// SPDX-License-Identifier: MIT
+/*
+ * DRM Backlight Helpers
+ * Copyright (c) 2014 David Herrmann
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/backlight.h>
+#include <linux/list.h>
+#include <linux/notifier.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+
+#include <drm/drm_backlight.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_device.h>
+#include <drm/drm_property.h>
+
+/**
+ * DOC: Backlight Devices
+ *
+ * Backlight devices have always been managed as a separate subsystem,
+ * independent of DRM. They are usually controlled via separate hardware
+ * interfaces than the display controller, so the split works out fine.
+ * However, backlight brightness is a property of a display, and thus a
+ * property of a DRM connector. We already manage DPMS states via connector
+ * properties, so it is natural to keep brightness control at the same place.
+ *
+ * This DRM backlight interface implements a generic per-connector LUMINANCE
+ * property. The core is backend-agnostic: it does not talk to any hardware
+ * itself, it only forwards luminance requests to a backend that a driver has
+ * linked. The backend is described by a &struct drm_backlight_funcs. Today the
+ * only backend is the backlight subsystem (&struct backlight_device), linked
+ * with drm_backlight_link(), but other backends (DDC/CI, MIPI-DCS, ...) can be
+ * added by providing a different set of operations without changing the core.
+ *
+ * A &struct drm_backlight is embedded in every &struct drm_connector and
+ * initialized by the DRM core (drm_backlight_connector_init()); drivers do not
+ * allocate it. Drivers link a backend once it is available by calling
+ * drm_backlight_link(); this creates the connector's LUMINANCE property with
+ * the backend's range. Passing NULL unlinks the backend. Hardware is only ever
+ * touched from a workqueue, so slow backends never stall an atomic commit.
+ */
+
+static LIST_HEAD(drm_backlight_list);
+static DEFINE_SPINLOCK(drm_backlight_lock);
+
+/* caller must hold @drm_backlight_lock */
+static bool __drm_backlight_is_linked(struct drm_backlight *b)
+{
+	lockdep_assert_held(&drm_backlight_lock);
+	/* a backlight is live while it is on @drm_backlight_list */
+	return !list_empty(&b->list);
+}
+
+/*
+ * Return the linked &backlight_device if the current backend is the backlight
+ * subsystem, or NULL otherwise. The legacy-sysfs takeover accounting only
+ * applies to that backend.
+ */
+static const struct drm_backlight_funcs drm_backlight_bd_funcs;
+
+static struct backlight_device *drm_backlight_bd(struct drm_backlight *b)
+{
+	if (b->funcs != &drm_backlight_bd_funcs)
+		return NULL;
+	return b->backend;
+}
+
+/* caller must hold @drm_backlight_lock */
+static void __drm_backlight_schedule(struct drm_backlight *b)
+{
+	lockdep_assert_held(&drm_backlight_lock);
+	if (__drm_backlight_is_linked(b))
+		schedule_work(&b->work);
+}
+
+static void __drm_backlight_worker(struct work_struct *w)
+{
+	struct drm_backlight *b = container_of(w, struct drm_backlight, work);
+	static char *ep[] = { "BACKLIGHT=1", NULL };
+	const struct drm_backlight_funcs *funcs;
+	bool send_uevent;
+	unsigned int v;
+
+	scoped_guard(spinlock, &drm_backlight_lock) {
+		send_uevent = b->changed;
+		b->changed = false;
+		v = b->set_value;
+		funcs = b->funcs;
+	}
+
+	/*
+	 * The backend stays valid here: drm_backlight_do_unlink() clears
+	 * @backend and drops its reference only after cancel_work_sync(), so an
+	 * in-flight worker always sees a live backend.
+	 */
+	if (funcs && funcs->set_luminance)
+		WARN_ON(funcs->set_luminance(b, v));
+
+	if (send_uevent && b->connector->kdev)
+		kobject_uevent_env(&b->connector->kdev->kobj, KOBJ_CHANGE, ep);
+}
+
+/* caller must hold @drm_backlight_lock */
+static void __drm_backlight_set(struct drm_backlight *b, unsigned int v)
+{
+	unsigned int max = 0;
+	bool can_disable = false;
+
+	lockdep_assert_held(&drm_backlight_lock);
+
+	if (!b->funcs || !b->funcs->get_range)
+		return;
+
+	b->funcs->get_range(b, &max, &can_disable);
+	if (!max)
+		return;
+
+	/* clamp to the backend maximum */
+	b->set_value = min(v, max);
+	__drm_backlight_schedule(b);
+}
+
+/* caller must hold @drm_backlight_lock */
+static void __drm_backlight_readback(struct drm_backlight *b, unsigned int v)
+{
+	struct drm_connector *connector = b->connector;
+	unsigned int max = 0;
+	bool can_disable = false;
+
+	lockdep_assert_held(&drm_backlight_lock);
+
+	if (!b->funcs || !b->funcs->get_range)
+		return;
+
+	b->funcs->get_range(b, &max, &can_disable);
+	if (!max)
+		return;
+
+	/*
+	 * Reflect a hardware-side brightness change (firmware hotkeys, or a
+	 * legacy sysfs write while not inhibited) back into the connector's
+	 * committed luminance so a read-back returns the real value.
+	 */
+	if (connector->state)
+		connector->state->luminance = min(v, max);
+}
+
+/*
+ * Create and attach the per-connector LUMINANCE property. Runs in process
+ * context (driver register path) with no spinlock held, since it allocates.
+ * The property's min/max are baked in for its lifetime, so it is never mutated
+ * afterwards (which would race &drm_mode_getproperty_ioctl); it is freed by
+ * drm_mode_config_cleanup().
+ */
+static int drm_backlight_create_property(struct drm_connector *connector,
+					 unsigned int max, bool can_disable)
+{
+	struct drm_device *dev = connector->dev;
+	struct drm_property *prop;
+	unsigned int min = can_disable ? 0 : 1;
+
+	prop = drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
+					 "LUMINANCE", min, max);
+	if (!prop)
+		return -ENOMEM;
+
+	prop->is_luminance = true;
+	connector->luminance_property = prop;
+	drm_object_attach_property(&connector->base, prop, min);
+	if (connector->state)
+		connector->state->luminance = min;
+
+	return 0;
+}
+
+static void drm_backlight_do_unlink(struct drm_backlight *b)
+{
+	struct backlight_device *bd;
+	unsigned int clients;
+
+	/*
+	 * Stop new work first, but leave @backend in place so an in-flight
+	 * worker keeps a valid backend to operate on. Capture the linked
+	 * backlight_device (if any) while @funcs is still set.
+	 */
+	scoped_guard(spinlock, &drm_backlight_lock) {
+		if (!b->funcs)
+			return;
+		bd = drm_backlight_bd(b);
+		clients = b->luminance_clients;
+		b->funcs = NULL;
+		list_del_init(&b->list);
+	}
+
+	cancel_work_sync(&b->work);
+
+	scoped_guard(spinlock, &drm_backlight_lock) {
+		if (clients && bd)
+			atomic_sub(clients, &bd->drm_takeover);
+		b->backend = NULL;
+	}
+
+	backlight_device_unref(bd);
+}
+
+/**
+ * drm_backlight_connector_init - initialize a connector's embedded backlight
+ * @connector: connector to initialize
+ *
+ * Called by the DRM core from drm_connector_init(). Drivers never call this.
+ */
+void drm_backlight_connector_init(struct drm_connector *connector)
+{
+	struct drm_backlight *b = &connector->backlight;
+
+	b->connector = connector;
+	INIT_LIST_HEAD(&b->list);
+	INIT_WORK(&b->work, __drm_backlight_worker);
+}
+
+/**
+ * drm_backlight_connector_cleanup - tear down a connector's embedded backlight
+ * @connector: connector being cleaned up
+ *
+ * Called by the DRM core from drm_connector_cleanup(). The LUMINANCE property
+ * itself is freed by drm_mode_config_cleanup().
+ */
+void drm_backlight_connector_cleanup(struct drm_connector *connector)
+{
+	struct drm_backlight *b = &connector->backlight;
+
+	WARN_ON(__drm_backlight_is_linked(b));
+	WARN_ON(b->funcs);
+	WARN_ON(b->luminance_clients);
+}
+
+/**
+ * drm_backlight_unregister - unlink a connector's backlight on unregister
+ * @connector: connector being unregistered
+ *
+ * Called by the DRM core from drm_connector_unregister() as a safety net in
+ * case a driver did not unlink its backend itself.
+ */
+void drm_backlight_unregister(struct drm_connector *connector)
+{
+	drm_backlight_do_unlink(&connector->backlight);
+}
+
+/**
+ * drm_backlight_link - link a backlight device to a connector
+ * @connector: connector to modify
+ * @bd: backlight device to link, or NULL to unlink
+ *
+ * Establish the link between a connector's LUMINANCE property and a registered
+ * backlight_device. On the first link the connector's LUMINANCE property is
+ * created with the backend's range. Passing NULL unlinks any linked device.
+ *
+ * User-space cannot create or modify this link.
+ *
+ * Returns: 0 on success, or a negative error code if the property could not be
+ * created (in which case no backend is linked).
+ */
+int drm_backlight_link(struct drm_connector *connector,
+		       struct backlight_device *bd)
+{
+	struct drm_backlight *b = &connector->backlight;
+	unsigned int max;
+	int ret;
+
+	if (!bd) {
+		drm_backlight_do_unlink(b);
+		return 0;
+	}
+
+	/* Retarget: drop any previously linked backend first. */
+	if (b->funcs)
+		drm_backlight_do_unlink(b);
+
+	max = bd->props.max_brightness;
+	if (max && !connector->luminance_property) {
+		ret = drm_backlight_create_property(connector, max, false);
+		if (ret)
+			return ret;
+	}
+
+	scoped_guard(spinlock, &drm_backlight_lock) {
+		b->funcs = &drm_backlight_bd_funcs;
+		b->backend = bd;
+		backlight_device_ref(bd);
+		list_add(&b->list, &drm_backlight_list);
+		if (b->luminance_clients)
+			atomic_add(b->luminance_clients, &bd->drm_takeover);
+		__drm_backlight_readback(b, bd->props.brightness);
+		b->changed = true;
+		__drm_backlight_set(b, bd->props.brightness);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_backlight_link);
+
+/**
+ * drm_backlight_get_device - get the backlight_device linked to a connector
+ * @connector: connector to query
+ *
+ * Returns the &backlight_device linked to @connector, or NULL if no backlight
+ * subsystem device is linked.
+ */
+struct backlight_device *drm_backlight_get_device(struct drm_connector *connector)
+{
+	guard(spinlock)(&drm_backlight_lock);
+	return drm_backlight_bd(&connector->backlight);
+}
+EXPORT_SYMBOL(drm_backlight_get_device);
+
+/**
+ * drm_backlight_inhibit_legacy - disable legacy sysfs control of the backend
+ * @connector: connector whose backlight should be inhibited
+ *
+ * Record that one more luminance-aware DRM client has taken over this
+ * connector's backlight. While any clients are recorded, writes to the linked
+ * backlight_device's legacy ``brightness`` sysfs attribute return ``-EBUSY``.
+ * The takeover follows the linked device if the link changes.
+ *
+ * Calls must be balanced with drm_backlight_uninhibit_legacy().
+ */
+void drm_backlight_inhibit_legacy(struct drm_connector *connector)
+{
+	struct drm_backlight *b = &connector->backlight;
+	struct backlight_device *bd;
+
+	guard(spinlock)(&drm_backlight_lock);
+	b->luminance_clients++;
+	bd = drm_backlight_bd(b);
+	if (bd)
+		atomic_inc(&bd->drm_takeover);
+}
+EXPORT_SYMBOL(drm_backlight_inhibit_legacy);
+
+/**
+ * drm_backlight_uninhibit_legacy - re-enable legacy sysfs control
+ * @connector: connector to uninhibit
+ *
+ * Balances a previous drm_backlight_inhibit_legacy() call.
+ */
+void drm_backlight_uninhibit_legacy(struct drm_connector *connector)
+{
+	struct drm_backlight *b = &connector->backlight;
+	struct backlight_device *bd;
+
+	guard(spinlock)(&drm_backlight_lock);
+	if (WARN_ON(b->luminance_clients == 0))
+		return;
+	b->luminance_clients--;
+	bd = drm_backlight_bd(b);
+	if (bd)
+		atomic_dec(&bd->drm_takeover);
+}
+EXPORT_SYMBOL(drm_backlight_uninhibit_legacy);
+
+/**
+ * drm_backlight_inhibit_legacy_all - inhibit legacy sysfs on every connector
+ * @dev: DRM device whose connectors should be inhibited
+ *
+ * Used when a client declares it is luminance-aware via
+ * DRM_CLIENT_CAP_LUMINANCE.
+ */
+void drm_backlight_inhibit_legacy_all(struct drm_device *dev)
+{
+	struct drm_connector_list_iter iter;
+	struct drm_connector *connector;
+
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter)
+		drm_backlight_inhibit_legacy(connector);
+	drm_connector_list_iter_end(&iter);
+}
+EXPORT_SYMBOL(drm_backlight_inhibit_legacy_all);
+
+/**
+ * drm_backlight_uninhibit_legacy_all - reverse drm_backlight_inhibit_legacy_all()
+ * @dev: DRM device whose connectors should be uninhibited
+ */
+void drm_backlight_uninhibit_legacy_all(struct drm_device *dev)
+{
+	struct drm_connector_list_iter iter;
+	struct drm_connector *connector;
+
+	drm_connector_list_iter_begin(dev, &iter);
+	drm_for_each_connector_iter(connector, &iter)
+		drm_backlight_uninhibit_legacy(connector);
+	drm_connector_list_iter_end(&iter);
+}
+EXPORT_SYMBOL(drm_backlight_uninhibit_legacy_all);
+
+/**
+ * drm_backlight_set_luminance - request a luminance change on a connector
+ * @connector: connector to update
+ * @value: luminance value to apply
+ *
+ * Clamp @value to the backend range and schedule the hardware update. Safe to
+ * call from an atomic commit tail: the actual hardware access happens later
+ * from a workqueue.
+ */
+void drm_backlight_set_luminance(struct drm_connector *connector,
+				 unsigned int value)
+{
+	guard(spinlock)(&drm_backlight_lock);
+	__drm_backlight_set(&connector->backlight, value);
+}
+EXPORT_SYMBOL(drm_backlight_set_luminance);
+
+/* backlight_device backend ------------------------------------------------- */
+
+static int drm_backlight_bd_set_luminance(struct drm_backlight *b,
+					  unsigned int value)
+{
+	struct backlight_device *bd = b->backend;
+	int rc;
+
+	rc = backlight_set_brightness(bd, value, BACKLIGHT_UPDATE_DRM);
+	if (rc)
+		backlight_set_brightness(bd, U16_MAX, BACKLIGHT_UPDATE_DRM);
+
+	return rc;
+}
+
+static int drm_backlight_bd_get_luminance(struct drm_backlight *b,
+					  unsigned int *value)
+{
+	struct backlight_device *bd = b->backend;
+
+	if (!bd)
+		return -ENODEV;
+	*value = bd->props.brightness;
+
+	return 0;
+}
+
+static void drm_backlight_bd_get_range(struct drm_backlight *b,
+				       unsigned int *max, bool *can_disable)
+{
+	struct backlight_device *bd = b->backend;
+
+	*max = bd ? bd->props.max_brightness : 0;
+	/*
+	 * A generic backlight_device gives no guarantee that a value of 0 turns
+	 * the panel fully off, so keep 0 reserved for the DPMS-off sentinel and
+	 * expose a 1..max range.
+	 */
+	*can_disable = false;
+}
+
+static const struct drm_backlight_funcs drm_backlight_bd_funcs = {
+	.set_luminance = drm_backlight_bd_set_luminance,
+	.get_luminance = drm_backlight_bd_get_luminance,
+	.get_range = drm_backlight_bd_get_range,
+};
+
+static int drm_backlight_notify(struct notifier_block *self,
+				unsigned long event, void *data)
+{
+	struct backlight_device *bd = data;
+	struct drm_backlight *b;
+
+	switch (event) {
+	case BACKLIGHT_UNREGISTERED:
+		/*
+		 * Unlink every connector using @bd. drm_backlight_do_unlink()
+		 * sleeps (cancel_work_sync()), so it cannot run under the list
+		 * spinlock; re-scan for the next match after each unlink.
+		 */
+		for (;;) {
+			struct drm_backlight *found = NULL;
+
+			scoped_guard(spinlock, &drm_backlight_lock) {
+				list_for_each_entry(b, &drm_backlight_list, list) {
+					if (drm_backlight_bd(b) == bd) {
+						found = b;
+						break;
+					}
+				}
+			}
+			if (!found)
+				break;
+			drm_backlight_do_unlink(found);
+		}
+		break;
+	case BACKLIGHT_BRIGHTNESS_CHANGED:
+		scoped_guard(spinlock, &drm_backlight_lock) {
+			list_for_each_entry(b, &drm_backlight_list, list)
+				if (drm_backlight_bd(b) == bd)
+					__drm_backlight_readback(b, bd->props.brightness);
+		}
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block drm_backlight_notifier = {
+	.notifier_call = drm_backlight_notify,
+};
+
+int drm_backlight_init(void)
+{
+	return backlight_register_notifier(&drm_backlight_notifier);
+}
+
+void drm_backlight_exit(void)
+{
+	backlight_unregister_notifier(&drm_backlight_notifier);
+}
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 8b4baed060f3a..92ed0c1879d53 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -21,6 +21,7 @@
  */
 
 #include <drm/drm_auth.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
@@ -316,6 +317,8 @@ static int drm_connector_init_only(struct drm_device *dev,
 		drm_object_attach_property(&connector->base, config->prop_crtc_id, 0);
 	}
 
+	drm_backlight_connector_init(connector);
+
 	connector->debugfs_entry = NULL;
 out_put_type_id:
 	if (ret)
@@ -773,6 +776,7 @@ void drm_connector_cleanup(struct drm_connector *connector)
 	struct drm_device *dev = connector->dev;
 	struct drm_display_mode *mode, *t;
 
+	drm_backlight_connector_cleanup(connector);
 	/* The connector should have been removed from userspace long before
 	 * it is finally destroyed.
 	 */
@@ -944,6 +948,8 @@ EXPORT_SYMBOL(drm_connector_dynamic_register);
 void drm_connector_unregister(struct drm_connector *connector)
 {
 	mutex_lock(&connector->mutex);
+	drm_backlight_unregister(connector);
+
 	if (connector->registration_state != DRM_CONNECTOR_REGISTERED) {
 		mutex_unlock(&connector->mutex);
 		return;
@@ -1532,6 +1538,56 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
  * 	Summarizing: Only set "DPMS" when the connector is known to be enabled,
  * 	assume that a successful SETCONFIG call also sets "DPMS" to on, and
  * 	never read back the value of "DPMS" because it can be incorrect.
+ * LUMINANCE:
+ * 	Atomic, per-connector range property for controlling the backlight
+ * 	brightness level of the connector's display. It provides unified access
+ * 	to the display backlight through the atomic modeset path, replacing the
+ * 	legacy sysfs interface for brightness control.
+ *
+ * 	The property value is an unsigned integer. Its valid range is baked in
+ * 	when a backlight backend is linked to the connector and reflects the
+ * 	backend's capabilities:
+ *
+ * 	- Range 1-N: Normal operation for a backend that cannot guarantee a full
+ * 	  off state. 1 is the minimum *visible* brightness and N is the backend
+ * 	  maximum. Drivers are expected never to program a duty cycle of 0 for a
+ * 	  value of 1.
+ * 	- Range 0-N: Used when the backend can also fully turn the panel off, so
+ * 	  0 is a normal in-range value.
+ *
+ * 	Value 0 is always accepted, even when the advertised range starts at 1:
+ * 	it is the sentinel used to turn the backlight off when the connector is
+ * 	powered down (DPMS off). Turning the backlight off this way may power the
+ * 	panel down entirely; unlike programming a legacy sysfs duty cycle of 0,
+ * 	this can stop vblank/pageflip events until the connector is enabled
+ * 	again, so luminance-aware clients must not rely on such events while the
+ * 	connector is off.
+ *
+ * 	Connectors without a linked backend do not expose this property at all.
+ *
+ * 	For atomic drivers the value is stored in &drm_connector_state.luminance
+ * 	and applied to the hardware from the atomic commit path once the
+ * 	connector is enabled. When DPMS transitions to OFF the backlight is set
+ * 	to 0; when it transitions back to ON the committed luminance is restored.
+ * 	Reading the property returns the last committed value (or the hardware's
+ * 	current state for backends that support reading brightness back).
+ *
+ * 	The property is created by the DRM core when a driver links a backlight
+ * 	backend with drm_backlight_link(); drivers do not create it directly.
+ *
+ * 	Client Capability:
+ * 		User-space must set the DRM_CLIENT_CAP_LUMINANCE client capability
+ * 		to 1 before using this property. When this capability is enabled,
+ * 		the legacy sysfs backlight interface is inhibited to prevent
+ * 		conflicts between multiple clients trying to control the same
+ * 		backlight. This ensures that only luminance-aware clients control
+ * 		the backlight through the DRM atomic interface.
+ *
+ * 		Legacy clients that do not set this capability should continue
+ * 		using the sysfs interface (if available).
+ *
+ * 	Note: This property can be set through the MODE_ATOMIC ioctl as part of
+ * 	the atomic state.
  * panel_type:
  * 	Immutable enum property to indicate the type of connected panel.
  * 	Possible values are "unknown" (default), "OLED", and "LCD".
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index c808958a2188e..c8aa6834c1f4e 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -42,6 +42,7 @@
 #include <linux/xarray.h>
 
 #include <drm/drm_accel.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_cache.h>
 #include <drm/drm_client_event.h>
@@ -1250,6 +1251,7 @@ static void drm_core_exit(void)
 	drm_privacy_screen_lookup_exit();
 	drm_panic_exit();
 	accel_core_exit();
+	drm_backlight_exit();
 	unregister_chrdev(DRM_MAJOR, "drm");
 	drm_debugfs_remove_root();
 	drm_sysfs_destroy();
@@ -1273,6 +1275,12 @@ static int __init drm_core_init(void)
 	drm_debugfs_init_root();
 	drm_debugfs_bridge_params();
 
+	ret = drm_backlight_init();
+	if (ret < 0) {
+		DRM_ERROR("Cannot initialize backlight interface\n");
+		goto error;
+	}
+
 	ret = register_chrdev(DRM_MAJOR, "drm", &drm_stub_fops);
 	if (ret < 0)
 		goto error;
diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode_config.c
index 366f6d8212425..36579e8a7c0e5 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -33,6 +33,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_colorop.h>
 #include <linux/dma-resv.h>
+#include <drm/drm_backlight.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index ef4e923a87284..06cdfe046ca89 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/backlight.h>
 #include <linux/component.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -27,6 +28,7 @@
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_print.h>
 #include <drm/drm_property.h>
 #include <drm/drm_sysfs.h>
@@ -391,15 +393,33 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
 
 int drm_sysfs_connector_add_late(struct drm_connector *connector)
 {
-	if (connector->ddc)
-		return sysfs_create_link(&connector->kdev->kobj,
-					 &connector->ddc->dev.kobj, "ddc");
+	struct backlight_device *bd = drm_backlight_get_device(connector);
+
+	if (connector->ddc) {
+		int ret = sysfs_create_link(&connector->kdev->kobj,
+					    &connector->ddc->dev.kobj, "ddc");
+		if (ret)
+			return ret;
+	}
+
+	if (bd) {
+		int ret = sysfs_create_link(&connector->kdev->kobj,
+					    &bd->dev.kobj, "backlight");
+		if (ret) {
+			if (connector->ddc)
+				sysfs_remove_link(&connector->kdev->kobj, "ddc");
+			return ret;
+		}
+	}
 
 	return 0;
 }
 
 void drm_sysfs_connector_remove_early(struct drm_connector *connector)
 {
+	if (drm_backlight_get_device(connector))
+		sysfs_remove_link(&connector->kdev->kobj, "backlight");
+
 	if (connector->ddc)
 		sysfs_remove_link(&connector->kdev->kobj, "ddc");
 }
diff --git a/include/drm/drm_atomic_helper.h b/include/drm/drm_atomic_helper.h
index 4cfeec70d648a..8a166ead13c55 100644
--- a/include/drm/drm_atomic_helper.h
+++ b/include/drm/drm_atomic_helper.h
@@ -116,6 +116,8 @@ void drm_atomic_helper_commit_encoder_bridge_enable(struct drm_device *dev,
 void drm_atomic_helper_commit_modeset_enables(struct drm_device *dev,
 					  struct drm_atomic_commit *old_state);
 
+void drm_atomic_helper_connector_apply_luminance(const struct drm_connector_state *conn_state);
+
 int drm_atomic_helper_prepare_planes(struct drm_device *dev,
 				     struct drm_atomic_commit *state);
 void drm_atomic_helper_unprepare_planes(struct drm_device *dev,
diff --git a/include/drm/drm_backlight.h b/include/drm/drm_backlight.h
new file mode 100644
index 0000000000000..5cc1912babed9
--- /dev/null
+++ b/include/drm/drm_backlight.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: MIT */
+#ifndef __DRM_BACKLIGHT_H__
+#define __DRM_BACKLIGHT_H__
+
+/*
+ * Copyright (c) 2014 David Herrmann <dh.herrmann at gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include <linux/list.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+
+struct backlight_device;
+struct drm_backlight;
+struct drm_connector;
+struct drm_device;
+
+/**
+ * struct drm_backlight_funcs - backend operations for a DRM backlight
+ *
+ * A DRM backlight is backend-agnostic: the core forwards luminance requests to
+ * whatever backend a driver has linked. Today the only backend is the backlight
+ * subsystem (&struct backlight_device), but the same core can drive other
+ * backends (DDC/CI, MIPI-DCS, ...) by providing a different set of these
+ * operations without any change to the core.
+ *
+ * All callbacks are invoked from process context (a workqueue), never from an
+ * atomic commit tail or while holding a spinlock, so they are allowed to sleep.
+ */
+struct drm_backlight_funcs {
+	/**
+	 * @set_luminance:
+	 *
+	 * Push @value (already clamped to the backend range) to the hardware.
+	 * Returns 0 on success or a negative error code.
+	 */
+	int (*set_luminance)(struct drm_backlight *b, unsigned int value);
+
+	/**
+	 * @get_luminance:
+	 *
+	 * Read the current hardware luminance into @value. Returns 0 on success
+	 * or a negative error code. May be NULL if the backend cannot be read
+	 * back.
+	 */
+	int (*get_luminance)(struct drm_backlight *b, unsigned int *value);
+
+	/**
+	 * @get_range:
+	 *
+	 * Report the backend's maximum luminance in @max and whether the
+	 * backend can turn the panel off at luminance 0 in @can_disable.
+	 */
+	void (*get_range)(struct drm_backlight *b, unsigned int *max,
+			  bool *can_disable);
+};
+
+/**
+ * struct drm_backlight - per-connector backlight state
+ *
+ * This structure is embedded in &struct drm_connector and initialized by the
+ * DRM core; drivers never allocate it. It becomes active once a driver links a
+ * backend with drm_backlight_link().
+ */
+struct drm_backlight {
+	/** @connector: connector this backlight belongs to */
+	struct drm_connector *connector;
+	/** @funcs: backend operations, or NULL while no backend is linked */
+	const struct drm_backlight_funcs *funcs;
+	/** @backend: backend private pointer (e.g. the &backlight_device) */
+	void *backend;
+	/** @list: entry on the global list of linked DRM backlights */
+	struct list_head list;
+	/** @work: deferred hardware update and uevent */
+	struct work_struct work;
+	/** @set_value: luminance value pending application by @work */
+	unsigned int set_value;
+	/**
+	 * @luminance_clients: number of luminance-aware DRM clients that have
+	 * taken this backlight over. While > 0, legacy sysfs writes to the
+	 * linked backend return -EBUSY.
+	 */
+	unsigned int luminance_clients;
+	/** @changed: a uevent is pending for @work to emit */
+	bool changed : 1;
+};
+
+#if IS_ENABLED(CONFIG_DRM_BACKLIGHT)
+
+int drm_backlight_init(void);
+void drm_backlight_exit(void);
+
+void drm_backlight_connector_init(struct drm_connector *connector);
+void drm_backlight_connector_cleanup(struct drm_connector *connector);
+void drm_backlight_unregister(struct drm_connector *connector);
+
+int drm_backlight_link(struct drm_connector *connector,
+		       struct backlight_device *bd);
+struct backlight_device *drm_backlight_get_device(struct drm_connector *connector);
+
+void drm_backlight_inhibit_legacy(struct drm_connector *connector);
+void drm_backlight_uninhibit_legacy(struct drm_connector *connector);
+void drm_backlight_inhibit_legacy_all(struct drm_device *dev);
+void drm_backlight_uninhibit_legacy_all(struct drm_device *dev);
+
+void drm_backlight_set_luminance(struct drm_connector *connector,
+				 unsigned int value);
+
+#else /* CONFIG_DRM_BACKLIGHT */
+
+static inline int drm_backlight_init(void) { return 0; }
+static inline void drm_backlight_exit(void) {}
+
+static inline void drm_backlight_connector_init(struct drm_connector *connector) {}
+static inline void drm_backlight_connector_cleanup(struct drm_connector *connector) {}
+static inline void drm_backlight_unregister(struct drm_connector *connector) {}
+
+static inline int drm_backlight_link(struct drm_connector *connector,
+				     struct backlight_device *bd)
+{
+	return 0;
+}
+
+static inline struct backlight_device *
+drm_backlight_get_device(struct drm_connector *connector)
+{
+	return NULL;
+}
+
+static inline void drm_backlight_inhibit_legacy(struct drm_connector *connector) {}
+static inline void drm_backlight_uninhibit_legacy(struct drm_connector *connector) {}
+static inline void drm_backlight_inhibit_legacy_all(struct drm_device *dev) {}
+static inline void drm_backlight_uninhibit_legacy_all(struct drm_device *dev) {}
+
+static inline void drm_backlight_set_luminance(struct drm_connector *connector,
+					       unsigned int value) {}
+
+#endif /* CONFIG_DRM_BACKLIGHT */
+
+#endif /* __DRM_BACKLIGHT_H__ */
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index a0cf0268de483..0535f20e7dba5 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -28,6 +28,7 @@
 #include <linux/ctype.h>
 #include <linux/hdmi.h>
 #include <linux/notifier.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_mode_object.h>
 #include <drm/drm_util.h>
 #include <drm/drm_property.h>
@@ -1290,6 +1291,11 @@ struct drm_connector_state {
 	 * @drm_atomic_helper_connector_hdmi_check().
 	 */
 	struct drm_connector_hdmi_state hdmi;
+
+	/**
+	 * @luminance: Luminance for the connector
+	 */
+	unsigned int luminance;
 };
 
 struct drm_connector_hdmi_audio_funcs {
@@ -2526,6 +2532,20 @@ struct drm_connector {
 	 * @cec: CEC-related data.
 	 */
 	struct drm_connector_cec cec;
+
+	/**
+	 * @backlight: DRM backlight state, embedded and initialized by the DRM
+	 * core. Becomes active once a driver links a backend with
+	 * drm_backlight_link().
+	 */
+	struct drm_backlight backlight;
+
+	/**
+	 * @luminance_property: Per-connector range property controlling the
+	 * connector's backlight luminance. Created with the backend's range
+	 * when a backlight is linked; NULL while no backlight is linked.
+	 */
+	struct drm_property *luminance_property;
 };
 
 #define obj_to_connector(x) container_of(x, struct drm_connector, base)
-- 
2.43.0

