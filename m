Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B2CFF885E
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0402110F6C2;
	Fri, 24 Apr 2026 22:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gWmuKa8N";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F32010E414;
 Fri, 24 Apr 2026 22:10:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKfYmaiqgrXAh7zw9sqPi5RZ1ATQCfCOQ12tnh4JL6B/+1EAP2S3t19YtNykz+Gfbla6qev6uBUe/DEr+QRdEaKLo4dRa/uFYsZGQbKFFP03l4t3FwuGVM/Krp6shvqNLVSde3nxuAmSUa8o3A6sT0VsAPD0Nh11pYhL7zcrSnfWqz/caI++VTXOcLr67R6uJG8xtAzrVe+ScWj2sVKzik99IUc2pAUu79Ge1XDDdquKc2KpqBZY+fqXari5Ge3YAfnEHUMleilW3Tj/m6icgWwgih808BkH6MOhRIh+HGigKH8WPhN7miO5XNHqSaqrpdUE2l0g3ZBpPoB4mMPR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsYTChLALU6lXYFq95OCbQ3p3hfVTjXA9mx96VH69JI=;
 b=fFPep2BV81gmYskhQk0cayy4pyzrsbk+A7JN3tiTXJZiEym6psz90+6owuscm+7Kyjv3oQUQQi1r4C1eYZi3+nOmMnCNCRxLgUyLX7uxWZdJMcw8HcSMsZey6MeduUBPXInoxYDB77RTxbCe+owH9hanLDa53PvINkHhpWj9NiJwTKv4En1JvW6VyT0YzSedmR0SQxjq5Fy8J4tQ4epg8e0yL4AucjMv5St/lw0vrKCJ6wEnC+nEtQmuk0vnJ/rFwde/XdNf2D7/ucT+nupGpPhC5n+k8YO2mtWrQ7STiNgsVYhv5D4+TVRQBW3J2mOFm0geHo7LmhhbSpvb91xqBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsYTChLALU6lXYFq95OCbQ3p3hfVTjXA9mx96VH69JI=;
 b=gWmuKa8NAEb6B2l2Idw6mSoldwQuaoOsD7PYIMP6GMPhN8l1U98Gor7Ai3UL1s+0cdCoSW12j8eGhnHzfH5YUOWD4Mc8asNsfc1k9VJ0TKEpacz3dDfCbCCi57PPv4LISqKz5E09J/d08yasnOV9TA09KLjmDvORKhw3FLofqGo=
Received: from CH5PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:1f1::8)
 by DM6PR12MB4059.namprd12.prod.outlook.com (2603:10b6:5:215::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 22:10:17 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::73) by CH5PR03CA0022.outlook.office365.com
 (2603:10b6:610:1f1::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 22:10:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 22:10:17 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 17:10:15 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v3 4/8] DRM: Add support for client and driver indicating
 support for luminance
Date: Fri, 24 Apr 2026 17:09:49 -0500
Message-ID: <20260424220953.167058-5-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|DM6PR12MB4059:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dcbfef6-ee65-4451-2151-08dea24e44be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Nq3nCEfslOggDWm6M2WGoWWcX93ep7bn1sYouG0VuT77Pb80C6aNWeLcZw13jri2h3og0zpHuRpCLDxC/kNtaHcO+f4h94dV8eSmo70i3os9cUDofKjEuJH7LoEL2SU55K1rLScpkF8l1nQ7b71tHFsGFpvFwO6iayVwRK8B+BC7rFSLzfxbp8NZFCn5VMZhgTLBdatDgMNfNl6bosI99u0t+HQ3xyWb/GbVIYvdPHLDfsorfCw86bLXNCsAwt+n01LWyCZ2x2CzqfjblIWKDSkKu2MXjoSnH7AgL0bWF8UYyCSRBca3CDgWOzKnv8vvuftSLetEsgTt4/5PvZWoe/0ROWpEI4huwl3Vh6Mt7SMOf970WHZTY5WUCrX4ZvsL+lyoN2G6KaharSeiAVP+RGp6JME9LZjIfqtjNLoFmatcvGgLtbOkcrC9JVp8AtrDka+pniQWF1kUTkAG+S9WwuDcErhhFjyLJIgd2Ik9RKcs6RrccEp+iuqJpxWrfhIOeeZdW9++kCqYpea8OmZ43ZsgepRbfyq8ufeGV4oK/iJP/75vCVp1iE+29Ft6+aaNbcuDrOSnGjzgB9RPsgbZ4ujooIzwN4x4oRAxhGBmgyP5O6CXAr7+SEeSRqiORn3Xfti01YhSsEEg0kY7YYcNV403rkCZrZNzE2oiDZaqRcKnk2NS7tUD8fpIgPD2gG3gO8poFueNfKXzEjaTN0jnw/XwdAC8/mlgNEgeNq/xfQpg03N7YUdZ9N/KvpqxBb1K+i+rrnCox3c15MFTlxBfuw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UUiMsZfSEyUYmQInhkeqDL87FFhXiP+9I5q49Il81s8AmoHZadJsZOQ5qHxiB8OgbuhgFeMTK54pB7NqpenTP1Uk873f0nrca4PyKIAOyajtczWbpP+rn2dL0iNPZEvZKUmmQ4COMobIhGejPnc/u/CLNF52TVfbA9PST/QBgkrVtcFjsy2vy/cbeU1PvbDAU3eCW7YeJ7jtuuCKI4LFnt50CFTBIh7nBoOBNC6qhojD5kp0DeUVC2b8mYBN4jsB4PCCtnwlYfLGz0ZHQohToa4Wvev5+/2tDZhyDwVLQlEVBVD/Ha6BV4SFvpGgaJ8pbnlyvojux1lsEbOeHa2+5qCC4YsduvYFRzdGPHI7AlCF8+Zu7r5cs7+OKHRc8rN0XbYfgyzstNmmqUDTeq9zQOMB42b1dMCU7y4Ms5fWZvYOBDRADT3hpopLKyXTeqzl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:10:17.7197 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcbfef6-ee65-4451-2151-08dea24e44be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4059
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

The legacy backlight control interface can only be disabled when both
the client and driver have agreed that the luminance can be set during
a modeset. Add capability for the client to register and for the driver
to indicate support.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/drm_atomic_uapi.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c   |  4 ++--
 drivers/gpu/drm/drm_ioctl.c       | 10 ++++++++++
 include/drm/drm_connector.h       |  5 +++++
 include/drm/drm_drv.h             |  7 +++++++
 include/drm/drm_file.h            |  8 ++++++++
 include/uapi/drm/drm.h            | 10 ++++++++++
 7 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 5bd5bf6661df7..de218206cef7e 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -30,6 +30,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
 #include <drm/drm_drv.h>
@@ -935,6 +936,14 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
 		state->privacy_screen_sw_state = val;
 	} else if (property == connector->broadcast_rgb_property) {
 		state->hdmi.broadcast_rgb = val;
+	} else if (property == config->luminance_property) {
+		state->luminance = val;
+		/* Update hardware backlight only when DPMS is ON.
+		 * Property value is always updated to remember the user's
+		 * desired brightness.
+		 */
+		if (connector->dpms == DRM_MODE_DPMS_ON)
+			drm_backlight_set_luminance(connector->backlight, val);
 	} else if (connector->funcs->atomic_set_property) {
 		return connector->funcs->atomic_set_property(connector,
 				state, property, val);
@@ -1020,6 +1029,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
 		*val = state->privacy_screen_sw_state;
 	} else if (property == connector->broadcast_rgb_property) {
 		*val = state->hdmi.broadcast_rgb;
+	} else if (property == config->luminance_property) {
+		*val = state->luminance;
 	} else if (connector->funcs->atomic_get_property) {
 		return connector->funcs->atomic_get_property(connector,
 				state, property, val);
@@ -1126,8 +1137,21 @@ int drm_atomic_connector_commit_dpms(struct drm_atomic_state *state,
 	if (connector->dpms == mode)
 		goto out;
 
+	/* Handle backlight brightness coordination with DPMS state changes */
+	if (old_mode != DRM_MODE_DPMS_OFF && mode == DRM_MODE_DPMS_OFF) {
+		/* DPMS ON -> OFF: dim backlight to 0 to save power */
+		drm_backlight_set_luminance(connector->backlight, 0);
+	}
+
 	connector->dpms = mode;
 
+	/* DPMS OFF -> ON: restore brightness to property value */
+	if (old_mode == DRM_MODE_DPMS_OFF && mode == DRM_MODE_DPMS_ON &&
+	    connector->state) {
+		drm_backlight_set_luminance(connector->backlight,
+					    connector->state->luminance);
+	}
+
 	crtc = connector->state->crtc;
 	if (!crtc)
 		goto out;
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index d76878548728a..5de33fc259b26 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -3268,9 +3268,9 @@ int drm_connector_set_obj_prop(struct drm_mode_object *obj,
 	/* Do DPMS ourselves */
 	if (property == connector->dev->mode_config.dpms_property) {
 		ret = (*connector->funcs->dpms)(connector, (int)value);
-	} else if (property == config->brightness_property) {
+	} else if (property == config->luminance_property) {
 		if (connector->backlight && connector->dpms == DRM_MODE_DPMS_ON)
-			drm_backlight_set_brightness(connector->backlight,
+			drm_backlight_set_luminance(connector->backlight,
 						     value);
 		ret = 0;
 	} else if (connector->funcs->set_property)
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index ff193155129e7..b4435c2bd6091 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -28,6 +28,7 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include "drm/drm.h"
 #include <linux/export.h>
 #include <linux/nospec.h>
 #include <linux/pci.h>
@@ -380,6 +381,15 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 			return -EINVAL;
 		file_priv->plane_color_pipeline = req->value;
 		break;
+	case DRM_CLIENT_CAP_LUMINANCE:
+		if (!drm_core_check_feature(dev, DRIVER_CONNECTOR_LUMINANCE))
+			return -EOPNOTSUPP;
+		if (!file_priv->atomic)
+			return -EINVAL;
+		if (req->value > 1)
+			return -EINVAL;
+		file_priv->supports_luminance_control = req->value;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 10daf088b8f1a..762a9e2ef6e30 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1209,6 +1209,11 @@ struct drm_connector_state {
 	 * @drm_atomic_helper_connector_hdmi_check().
 	 */
 	struct drm_connector_hdmi_state hdmi;
+
+	/**
+	 * @luminance: Luminance for the connector
+	 */
+	u16 luminance;
 };
 
 struct drm_connector_hdmi_audio_funcs {
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index 42fc085f986de..a6b668cb68c5e 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -123,6 +123,13 @@ enum drm_driver_feature {
 	 */
 	DRIVER_CURSOR_HOTSPOT           = BIT(9),
 
+	/**
+	 * @DRIVER_CONNECTOR_LUMINANCE:
+	 *
+	 * Driver supports luminance control on a per connector basis.
+	 */
+	DRIVER_CONNECTOR_LUMINANCE           = BIT(10),
+
 	/* IMPORTANT: Below are all the legacy flags, add new ones above. */
 
 	/**
diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
index 6ee70ad65e1fd..0bb1e53f36bec 100644
--- a/include/drm/drm_file.h
+++ b/include/drm/drm_file.h
@@ -248,6 +248,14 @@ struct drm_file {
 	 */
 	bool supports_virtualized_cursor_plane;
 
+	/**
+	 * @supports_luminance_control:
+	 *
+	 * This client is capable of setting the luminance for connectors.
+	 *
+	 */
+	bool supports_luminance_control;
+
 	/**
 	 * @master:
 	 *
diff --git a/include/uapi/drm/drm.h b/include/uapi/drm/drm.h
index 27cc159c1d275..b5e6d940f2816 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -921,6 +921,16 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
 
+/**
+ * DRM_CLIENT_CAP_LUMINANCE
+ *
+ * If set to 1, legacy sysfs interface for controlling backlight brightness will
+ * be disabled.  The client will include luminance values as part of the modeset.
+
+ * This capability is supported starting in kernel 7.2
+ */
+#define DRM_CLIENT_CAP_LUMINANCE		8
+
 /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
-- 
2.43.0

