Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7984C624D6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC38310EB24;
	Mon, 31 Aug 2026 21:06:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nQC1PQUs";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010068.outbound.protection.outlook.com
 [40.93.198.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA80010EB18;
 Mon, 31 Aug 2026 21:06:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdbQF6fo8PzRett1bIGGXh7ySbFxx1Y+CQzpyGvADDsvyu1frRynts8DCO397f/u8sb4yqNusSt/5J99cuNc+lBT0tXcIZ69fp17QzXHr5M6qXTmzhgkBn9VsPU+PcsTCSDxmYJTMI1ygdM5Tk9eFOLwZjLUsMt4z6xLac6YI5ZhGTnDfvIgR53Kyru1gzWVcuQNR0qOYsreagx+w3Xu5QYmlHdyM6tx3uJqr1TivN6Ya3cEXEItc4sxBJaCzKL2lNJe8KAEUZr4NdYPv573aW2Px/H1bESon3l8/oTCcQ/B9hfJgeX4DIXHneCoc3Pu4OruovhFL29hX7QEtPJLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5eVMoF6pXb/mUoOVasxnb7iSv9PCJsuOq0CJzc6gdZo=;
 b=NtZglIsNE5pfJImbrW/4Mm+dGXYBeyBSUjRyDw7GIBYpj/JMuowcwVJ7+5f3sOxWUFKHbI8EJAp2Ro5E/843v7Kb6ZxqQB4jkFkJcLXxPE3nqqLhyguovNZx4eMi8g1Nd2Y+qNwViPCwFYjcRQgVPOh6serfsqL/n0NmIbmyypTpeNrNZDE36+agslEqNtvweWr2CSopSuqzU9wmXnDreHPf0zrSRdu7pqzAjXqxT8x7MeWYzEzUR7bV4KkcH8w2Rprhem4mxCF7G2ZMuxGoeZ1UfxsppL+J8gxLCKwPNMJ2AaJ5CgtejSNPu3fZpp2+QIafgIJN4muKIc/Y1+lSIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5eVMoF6pXb/mUoOVasxnb7iSv9PCJsuOq0CJzc6gdZo=;
 b=nQC1PQUsn+dTYClvsYpZ7M4+gNGwqN2NgcoGa9/uy4KXNNSxXXJAMC8vrvcJDl9u715HwYApnbCpNmwP7LeGxvDwP8G6+zviwCBih8BOZBchZF7aAFOkeb17fWUF9SC/6rjOm1bNTcBliHgmOGmHqbhzh2A7G6UqOZuMQy5N2GY=
Received: from BN0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:408:e4::20)
 by PH0PR12MB8099.namprd12.prod.outlook.com (2603:10b6:510:29d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Mon, 31 Aug
 2026 21:05:59 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::1a) by BN0PR02CA0015.outlook.office365.com
 (2603:10b6:408:e4::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:05:58 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:05:57 -0500
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
Subject: [PATCH v7 05/12] drm: add DRM_CLIENT_CAP_LUMINANCE
Date: Mon, 31 Aug 2026 16:05:24 -0500
Message-ID: <20260831210531.2334221-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|PH0PR12MB8099:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c13630f-29d9-49f7-b500-08df07a3a7df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006|5023799004|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: orU1dH03yBMkatAcpqRsm+gY9Sh9vpmySK9liQsdtyRZZF5JNGD0BSr09vs7Ds/lB3wgPPLeyHsc9OG6Mac/gAjRqZAa/waIu14zpwQBINQaFifDjg3rw29Yarc3dR+pNndLNVWRfV08k0D4LLpdxH5kxedvsvCZdmEB2rXYVPCWZ+4aD7FZi0t+0IH/+GDFZeXGPUWxwt5FB9bZQ5ISQ0CP9BCFMqI7k3A7BtqnCh0PPy9G6/AMyv1y7/W2Dq6isXx55/fiazlPEFuQR5k3EsJ+9WXhatbdfI9byGiI6I4G9wtGBmUvlRxdqr1M2B51L8oFNu+X7YQ8bJdKrcdZSgwCKfIas9mY6UYIGiU/fyC4QxHwZE4y0So7MdgndbBv4ggf0WRmtMvTL0w6RwkiZZtQH31Br7Nmf5pWR4GRFM3Jrv+a9dYQEw6pwObyi0TOURce4trOWDa0Dv49eDNWoDdCuRIr0QVGIDSKXKALb0Pp6dD2R1BfGHLqabclTBX4R6441FANYJrKN0t7FDVzLxAV287uB8ab1eAEg3qCWCIWFR0pHQBLgJxrTDCwfBdlZf+7JvK3x1R+N4z1mCx1sWo25U10w7iHTXRoMtLsdtQ7aUm3sE9jwge9t5zFgP67gZ3yLDA84SlECqEUjyms0mve0ZKQO1lIcsNE882xfy3/5a1ngEfa00Ig9B38iaxY6Wu+h3SG2Ffl8lRliG3o5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ao1HW64vuZO5xAV05afISFrlPgGAwjakCXY2YMuDWXzJpMTaYzyIiHewJTypkfxzuvLvDfIG98aXv2XuDXBKAFlYnTpebI8EwEdah1KlkmfzDkVv8Rb65iHw8Ynru+nPPkoQNuFeVSzI8lo4jkV76MKb/Tl53R3jBlg9KzahPeu0RJZmy8c6wuok6vwE1pGfhWuGADiQjCGyttk/fkj172pROawgrqTkJBBC9UNnZjuNWOYtbC33j40WvrjfwOaOJdBRJR3Mak58COjhxEaUIBRNNizvTucXJraP/Lk+necZDm8mxlblgDK0lSP85Ylh3Jw8s2kF/+0xNKQL+Smm7W6MD9v226eqrcLBpfvY1zRGOpVedIlOQVmD0IW0/r3KieMQ43VdtqnaiYQmibafigiy9WRBUmCLeCZR2nTou3VJLuJcjWILFjAPSIFBPwsN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:05:58.6987 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c13630f-29d9-49f7-b500-08df07a3a7df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8099
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

The legacy backlight control interface can only be disabled when both the
client and the driver agree that luminance can be set during a modeset.
Add a DRIVER_CONNECTOR_LUMINANCE driver feature for the driver to
advertise support, and a DRM_CLIENT_CAP_LUMINANCE client capability for
a luminance-aware client to opt in.

When a client sets DRM_CLIENT_CAP_LUMINANCE, every DRM-connected
backlight on the device is marked as taken over; writes to the legacy
/sys/class/backlight/<dev>/brightness attribute then return -EBUSY until
the last luminance-aware client clears the capability or closes its DRM
file. The takeover follows the active backlight_device when
drm_backlight_link() retargets the link.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/drm_file.c  |  5 +++++
 drivers/gpu/drm/drm_ioctl.c | 17 +++++++++++++++++
 include/drm/drm_drv.h       |  7 +++++++
 include/drm/drm_file.h      |  8 ++++++++
 include/uapi/drm/drm.h      | 22 ++++++++++++++++++++++
 5 files changed, 59 insertions(+)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index ec820686b3021..4d2520de7614c 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -41,6 +41,7 @@
 #include <linux/slab.h>
 #include <linux/vga_switcheroo.h>
 
+#include <drm/drm_backlight.h>
 #include <drm/drm_client_event.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
@@ -252,6 +253,10 @@ void drm_file_free(struct drm_file *file)
 	if (drm_core_check_feature(dev, DRIVER_MODESET)) {
 		drm_fb_release(file);
 		drm_property_destroy_user_blobs(dev, file);
+		if (file->supports_luminance_control) {
+			drm_backlight_uninhibit_legacy_all(dev);
+			file->supports_luminance_control = false;
+		}
 	}
 
 	if (drm_core_check_feature(dev, DRIVER_SYNCOBJ))
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 9039a39c43243..b09f4a3b9a955 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -28,12 +28,14 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include "drm/drm.h"
 #include <linux/export.h>
 #include <linux/nospec.h>
 #include <linux/pci.h>
 #include <linux/uaccess.h>
 
 #include <drm/drm_auth.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
@@ -392,6 +394,21 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
 		file_priv->plane_color_pipeline = req->value;
 		break;
 	}
+	case DRM_CLIENT_CAP_LUMINANCE:
+		if (!drm_core_check_feature(dev, DRIVER_CONNECTOR_LUMINANCE))
+			return -EOPNOTSUPP;
+		if (!file_priv->atomic)
+			return -EINVAL;
+		if (req->value > 1)
+			return -EINVAL;
+		if (req->value == file_priv->supports_luminance_control)
+			break;
+		if (req->value)
+			drm_backlight_inhibit_legacy_all(dev);
+		else
+			drm_backlight_uninhibit_legacy_all(dev);
+		file_priv->supports_luminance_control = req->value;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/include/drm/drm_drv.h b/include/drm/drm_drv.h
index b23830494ed41..449160b9863f6 100644
--- a/include/drm/drm_drv.h
+++ b/include/drm/drm_drv.h
@@ -118,6 +118,13 @@ enum drm_driver_feature {
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
index bc7ef7684099b..a3141d46d7d66 100644
--- a/include/uapi/drm/drm.h
+++ b/include/uapi/drm/drm.h
@@ -903,6 +903,28 @@ struct drm_get_cap {
  */
 #define DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE	7
 
+/**
+ * DRM_CLIENT_CAP_LUMINANCE
+ *
+ * If set to 1, the client declares support for the LUMINANCE connector property
+ * and will control backlight brightness through the DRM atomic interface. This
+ * enables the kernel to expose the LUMINANCE property on connectors that have
+ * an associated backlight device.
+ *
+ * When this capability is enabled:
+ *  - The LUMINANCE property becomes visible on supported connectors
+ *  - Legacy sysfs writes to /sys/class/backlight/{*}/brightness will return
+ *    -EBUSY to prevent conflicts with DRM-based brightness control
+ *  - The client should include luminance values as part of atomic commits
+ *  - Brightness changes are synchronized with display power state (DPMS)
+ *
+ * The LUMINANCE property accepts values from 0 to max_brightness, where 0 turns
+ * off the backlight, and 1 to max_brightness control the brightness level.
+ *
+ * This capability is supported starting in kernel 7.2.
+ */
+#define DRM_CLIENT_CAP_LUMINANCE		8
+
 /* DRM_IOCTL_SET_CLIENT_CAP ioctl argument type */
 struct drm_set_client_cap {
 	__u64 capability;
-- 
2.43.0

