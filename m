Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE244C79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30F4F10E9A5;
	Tue,  8 Sep 2026 04:41:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CP2evrq4";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010054.outbound.protection.outlook.com
 [40.93.198.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03A1810E9A4;
 Tue,  8 Sep 2026 04:41:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6iTQAkptfHJkZg+jbPsuBMI7xmRDqDyBI/bcrhY+O6aC93BZdoJCnlIuLpPzRB+SpdMw/ekBnuY+uJiEcO6LkeWztJhIh5bR4rLaIOwkszQ+HCscJ6fGPo/NQ3VdOFgSE1ZIxpetvGxiFmMW3rltIlUEpTPsovRURee89uSrXPW2ktr74xfBnkJwKrctO9YeXtLIX+Oq9KjiDxepGrgVyGdjRgRH9FkBT59CwxiAh9HhghKsuuC4+TO/ArGWpxYoccbm+aR8XFcLpnS/4h8aJ5aH5lC/FrKsxMT1qlRPmHDoNME5gJseLNt5lqyZpFLRvFa9+lgqLP8YB9qF5O/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYxXaCGTi59omKgoOLgrMzr70ol9x3ZmLWi0qg21CV0=;
 b=do862C4/g8+gJwjwyi7C3BSsBwY+aGZRugLbqeisgbebKBcim5Jh52Yg5NEE8AvuB3GFGyYhV7ssaIcff0u15qHVDCAMFYOf8lO4wUs0G02oBvvbwBOHxr5T2ra6jXETQCFrDzDpK8zdUY/dsZqm8bxIEnPfmJcfo+uQk8MPSnA4abfa2S0fjKpne2ICSPVGuOjr01MkJEj9YIdbDbEas4kDg/C6qHky3WAdjLpBtmYgLVKJUWVDP3DGJ4fYeHxfSd4CnCnGxfe6YmooEiDZHSb7ibqH0eTqkW+NkI5qteOdAjcVhZRKqaXeknLjYTfllCZwSmNXKV2ARjke9CFqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYxXaCGTi59omKgoOLgrMzr70ol9x3ZmLWi0qg21CV0=;
 b=CP2evrq4md/Vzn1AeRy5L4hM9a3Fw7YlFGRbno8pT7XZRYdaEbwxpnDk4NsVVuRTDDdgd2wxlvWDLTOtQ71VfJrhfE3Tit30nS7xyjXcEaXUrlT5rSNPC1lgOwhGAgVkPkVMxRLNcBzr8eCK1Di2Kc7NKPxyQsUYRIr5pJuEMXQ=
Received: from CY5PR15CA0011.namprd15.prod.outlook.com (2603:10b6:930:14::23)
 by CY8PR12MB8194.namprd12.prod.outlook.com (2603:10b6:930:76::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:41:00 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::7e) by CY5PR15CA0011.outlook.office365.com
 (2603:10b6:930:14::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:41:00 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:40:59 -0500
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
Subject: [PATCH v8 05/14] drm: add DRM_CLIENT_CAP_LUMINANCE
Date: Mon, 7 Sep 2026 23:40:26 -0500
Message-ID: <20260908044035.62093-6-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|CY8PR12MB8194:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dbe877f-2baf-41cf-5f26-08df0d636209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|7416014|10067099003|56012099006|11063799006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FwVrSAlBAB/kHxRlDQnF87SAmgfZIP8sgQpbCFWV6l2eY+4ZHI+/o4jpI57cAZ6chVZ/OUfRhNe+apBjp4rUWjKu8mEP5bA1L+ilUCt+qinSrjQr6NLNMdCvTL8hkJIbc0h51Zpo53PvSbuKGnp1IyQhuNvpbepl9QjHlqP0Fk0hONpHjB6THsgnhbtCt7KBjVfLbHtjaEdK7/lo+MgHqnFACsm40we5Fq3+RzQtyYllCbOKjoyqjmr8H/UPq8ygiktuea4iCeMozN6PEWDQa3qmOVnIXZhqfLVBvVq3i7H/Hh0cdkNLp2uMUQfYHlJAg5i+HATkg1ihu9124yEfIAXU4fSW218DNGmEAS9neNaRXc1VSC2j5zm5pD92B+M4P4DcKXz2VGsePE7sGSK78QI/JJXSueOCSbOWa68O+eD/X/s9KRrf493xhcMCoryEfJsc//EGhFCqGY5JaW8R2jDraST55SLkGM2s6F3EfSxo0DPONL0AqRvXoiQqu0BI4n8Ngc9dvLaysXE7DOao9JYLt3L8D9BzQr0UIM+GSEQTkM6ibbGX0k6b4u2e0kj3T0VpeLT7/l1sfsBn7OT9BEEkVLjqeLpqhODNnr2pkYJ5Opt+B2p2h++wLG+H/5AFST9Qt6w5YD3xYequGDM6a17nzMfxSG9GEId1vrg4pqR/YZBwzD3uSaWX+G0RYt+CswbUH+y6/OAF6R87ljEmhQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(56012099006)(11063799006)(5023799004)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DFdw0L3synnGGeLXeM1xfkSvvcLBtbwMl1Bx9g9t9M35yuOWSS/8wZV2QEzXqsEVHos8/YEpQABSpMkLhuB0EMr4EUUcVetuo/IOf6as2nxFh2Ak0+jAcWtXtVIYJghNTPysqCKEQ39FNwpklbFvaAINOUQXgSOHY38B8dOGEZtSjgjTlF4o4eH200F1T0aHU1u+L0B9KfwDM2eNeV4IxtLE3DWes48xp4989ZPrgTlC/gkSkjMdi9Ateu0cSJ5041GyiwNCVrZ90H52ALYX2rgtsDtpaDKFVSlnxagHo3tQboIkiHYeCErvX+wx1nHCqy55JR+nTEIF9GHXVvbY14MduvGTY2rpLtPRwz/qP5BBU8Yue+HZpoJoCS7lKEzofzUgr2t9pDV9wpE79XfG1r7+LmtoeYqyk/YXi6a820mdNbsI2npfqJ16HuNRbMEY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:41:00.6727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbe877f-2baf-41cf-5f26-08df0d636209
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8194
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
 drivers/gpu/drm/drm_ioctl.c | 24 ++++++++++++++++++++++++
 include/drm/drm_drv.h       |  7 +++++++
 include/drm/drm_file.h      |  8 ++++++++
 include/uapi/drm/drm.h      | 22 ++++++++++++++++++++++
 5 files changed, 66 insertions(+)

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
index 9039a39c43243..de2c9d9ab5285 100644
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
@@ -392,6 +394,28 @@ drm_setclientcap(struct drm_device *dev, void *data, struct drm_file *file_priv)
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
+
+		/*
+		 * Serialize the compare-and-act so concurrent ioctls on a shared
+		 * fd cannot unbalance the device-wide inhibit count.
+		 */
+		mutex_lock(&dev->mode_config.mutex);
+		if (req->value != file_priv->supports_luminance_control) {
+			if (req->value)
+				drm_backlight_inhibit_legacy_all(dev);
+			else
+				drm_backlight_uninhibit_legacy_all(dev);
+			file_priv->supports_luminance_control = req->value;
+		}
+		mutex_unlock(&dev->mode_config.mutex);
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

