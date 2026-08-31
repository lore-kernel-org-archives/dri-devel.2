Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AAB7C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 21:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164CE10EB09;
	Mon, 31 Aug 2026 21:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GtIuCKOq";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010006.outbound.protection.outlook.com
 [52.101.193.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DE810EB04;
 Mon, 31 Aug 2026 21:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZdYk4av38N4H+2NZTAGE00WqhI6wZLNQanjfruz94/IfvBvbQqYcmMsmUmbj4hbfHtevzakWkSTTWoZ8EE69kMfqm4HmAFLpuawJqJCOnV9ZWm0ItvWrNpVN6aemO0WdUWXwmkwCLkDdvI9q1mSssIUlL3I/4PbtFVbD0fxUkmMsyk+BRHC21KIiMeFJtTBoWlY50cpBv5BFccbGLplh0UCCiJeLqJAtUZAV8cNsLGzP/Mc1gxOgzhflb4b/30CvYB1oDiRE2j0S3yi8wb7mCZe6NoDjESpn25nlDayZP0Go5r2nztir+m79+PRwt1mznfbsnu7CG8QmkUJ3DHBCZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR9PrU97KDclizQsm+d5hS/EjhiH2xivfY3OLPIxPig=;
 b=Hy67ajoZNoOUHRXqz4Gq3Cv3Ow28lOm9JAPP8GMTr5x+FLUGvv+P9kWNLIVXHP6QV2CqnE+HJWOCJHyRKoVyiJc3O3cW5BWEfYDGqr9zTREjqviXp+Mnk9rtCq4E4tKuzWh5hxBjNdbMKCfMJkcN23dyhK2UEUhkJHco4q2HJHR8nmmVhTqgM7b1E54apgfYVvep3cTFbvf9nmLN2bDGgNle9D8pcwm4lqqIdL9q2lkG3+50zVaM/Jdrs1ZA4NriyiNGW/Dv9KzAAC8eAgmykzOvLBnVOY1IbsibpuawouGGTwu/eHKOfP9C9qHySYxPqjcETO6l7fRb5mv2iND8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR9PrU97KDclizQsm+d5hS/EjhiH2xivfY3OLPIxPig=;
 b=GtIuCKOqXZ8BkpwzVYflVzopPxIqC9R/m8kfd7Qs8uDX/CjMCrj/JCdcJrbkttFaqr8Fp2dGrARqDyzc5pxMySdVWCzPKJM3NCsECB8SPaCGFH2jb1TxVVgGIBOHRObVLJeKcRlXJ12Uhm4rXfEty31QEA7vCZ9abrxuR7617Pg=
Received: from BN0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:408:e4::22)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 21:05:52 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::89) by BN0PR02CA0017.outlook.office365.com
 (2603:10b6:408:e4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 21:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 21:05:52 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 16:05:50 -0500
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
 Herrmann" <dh.herrmann@gmail.com>, Marta Lofstedt <marta.lofstedt@intel.com>, 
 Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v7 02/12] backlight: add kernel-internal backlight API
Date: Mon, 31 Aug 2026 16:05:21 -0500
Message-ID: <20260831210531.2334221-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f48382-6af2-4dc7-02d8-08df07a3a43e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|82310400026|376014|36860700016|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: QTt20XOmZT++rnBK9tZTV5cwH5P+ge+j22FQI17KqPhWSYvRHhVAoHbDr1BRbPfKYFRh8FLI9VTekBLH2QRN+DNdTDfze7crBi/y2D5L7o074GubXvbhuap5Mj4X+yTEUUz5EeGcqW5S6oLBiHLtBYWh5+nt1sxk7znFnh7FJvmDY6LwjEhkgsGz7yP75W/M4cceUaQhOdOuqXQ+YSda+zou70SgK4Z82u3ECvsiAWzjm9CbzTqvFhPW4BU2wHudGnREodGvKIsWOlSW6DR7XvygK/iPyfLAcaVQ2aw8nUFe5wTDuOKK27JIGXlbLFOtk8LjJcOeCc15FNW3UQw7w2gKXKKRy3s+4FOMfw351IbEu3yr17FpImXsTn/ho6BnONuYaLX/8bgoXCknASckH3OQc1T+gEyazQJRR4dXbeB5AwHpXwJBiyjqZYzqQNay93rrqy+ped3ZQCOJVCayco9PCRoV1YejTEJAj126R6msKt2VTMMaPL+M+K2LyZmzByNZGNN/3JX8EM3iGC6FlFiBepWnGqk64T/rdvrsOSzqUkDJv0Y/FcXwvsSiTF7eA1d5rki8UWlaCEm6SL6IuitL3j5RXKVpzxppl8teBdHFBXpTr5ssWjH2FRS2icyI8zmIWoaY/F5hBM1W1CV2WvlcgNVbrcF0rmZYpUwLiwCzGQnUb8UEO8PDXmHEjRPz8LpNCKGxAksluUb83DntVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tW7EPKwwtngB+EezDEobfVxQObCflgmK5pJ83X4CSEfjR+Rbv3sIEmo/e5gmXPn6NYTdKYSzaq0MDhoRkHnDdQaUZ+N+O3gDxNnDcoe8vrLdkIUaokrOpHNPBV3Kqgt31xHHcxwGznFQMQVj1hsw0f/AXsA/Wa1p4R9Psa4U7gkF3lvTKQ3ajOHVMvAt/jYDcBfnCXeLZUOs1ICnhxD+jJ3hVMMlCZkWP6bT+P5ZhvSwiTz3CQcPgR8FQ04g8+xSciz8sLYS1xnFNd/j0bLa11EhxrWLlo+LpS3A+lresHOy5lvio0QBnPvnRKAqLjyQgzyjgbWfWen8xlvsyD7fdhFooPJBv8iGqyaXR9hJN0ONFLuNJpo1cdZT0N/GfMc8KDzGBcFJBgiDzHK5BhKTcURzZSkmViZH/7EqyXG0BT5Rsa173IBpu0iLchNz5TD2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 21:05:52.6021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f48382-6af2-4dc7-02d8-08df07a3a43e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708
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

So far backlights have only been controlled via sysfs. However, sysfs is
not a proper user-space API for runtime modifications, and never was
intended to provide such. The DRM drivers are now prepared to provide
such a backlight link so user-space can control backlight via DRM
connector properties. This allows us to employ the same access-management
we use for mode-setting.

This patch adds a few kernel-internal backlight helpers so we can modify
backlights from within DRM, a brightness-changed notification, and a
per-device takeover count so that legacy sysfs writes can be inhibited
(-EBUSY) while a luminance-aware DRM client is in control.

Signed-off-by: David Herrmann <dh.herrmann@gmail.com>

V2: Marta Lofstedt <marta.lofstedt@intel.com>
- rebase
- minor edit for checkpatch warning

Signed-off-by: Marta Lofstedt <marta.lofstedt@intel.com>

V3: Mario Limonciello (AMD) <superm1@kernel.org>
 - rebase
 - Use guard(mutex)

V4: Mario Limonciello (AMD) <superm1@kernel.org>
 - Adjust return type for backlight_set_brightness() to return errors
 - Stop clamping in backlight_set_brightness()
 - Drop backlight_device_lookup()

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/video/backlight/backlight.c | 57 +++++++++++++++++++++++++++++
 include/linux/backlight.h           | 41 +++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 4401f6294ccc8..5735226c8b78d 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -126,6 +126,9 @@ static void backlight_generate_event(struct backlight_device *bd,
 	case BACKLIGHT_UPDATE_HOTKEY:
 		envp[0] = "SOURCE=hotkey";
 		break;
+	case BACKLIGHT_UPDATE_DRM:
+		envp[0] = "SOURCE=drm";
+		break;
 	default:
 		envp[0] = "SOURCE=unknown";
 		break;
@@ -214,6 +217,13 @@ static ssize_t brightness_store(struct device *dev,
 	struct backlight_device *bd = to_backlight_device(dev);
 	unsigned long brightness;
 
+	/* A luminance-aware DRM client has taken over this backlight; the
+	 * legacy sysfs interface is disabled until the last such client
+	 * goes away.
+	 */
+	if (atomic_read(&bd->drm_takeover) > 0)
+		return -EBUSY;
+
 	rc = kstrtoul(buf, 0, &brightness);
 	if (rc)
 		return rc;
@@ -514,6 +524,39 @@ static int devm_backlight_device_match(struct device *dev, void *res,
 	return *r == data;
 }
 
+/**
+ * backlight_set_brightness - set brightness on a backlight device
+ * @bd: backlight device to operate on
+ * @value: brightness value to set on the device
+ * @reason: backlight-change reason to use for notifications
+ *
+ * This is the in-kernel API equivalent of writing into the 'brightness' sysfs
+ * file. It calls into the underlying backlight driver to change the brightness
+ * value.
+ * A uevent notification is sent with the reason set to @reason.
+ * Return: 0 if successfully notified, -EINVAL for invalid values
+ */
+int backlight_set_brightness(struct backlight_device *bd, unsigned int value,
+			      enum backlight_update_reason reason)
+{
+	int rc = 0;
+
+	guard(mutex)(&bd->ops_lock);
+	if (bd->ops) {
+		if (value > bd->props.max_brightness)
+			return -EINVAL;
+
+		dev_dbg(&bd->dev, "set brightness to %u\n", value);
+		bd->props.brightness = value;
+		rc = backlight_update_status(bd);
+	}
+	if (rc == 0)
+		backlight_generate_event(bd, reason);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(backlight_set_brightness);
+
 /**
  * backlight_register_notifier - get notified of backlight (un)registration
  * @nb: notifier block with the notifier to call on backlight (un)registration
@@ -548,6 +591,20 @@ int backlight_unregister_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(backlight_unregister_notifier);
 
+/**
+ * backlight_notify_brightness - notify brightness change to listeners
+ * @bd: backlight device that changed
+ *
+ * Notify registered listeners that the backlight brightness has changed.
+ * This is called automatically after successful brightness updates.
+ */
+void backlight_notify_brightness(struct backlight_device *bd)
+{
+	blocking_notifier_call_chain(&backlight_notifier,
+				     BACKLIGHT_BRIGHTNESS_CHANGED, bd);
+}
+EXPORT_SYMBOL(backlight_notify_brightness);
+
 /**
  * devm_backlight_device_register - register a new backlight device
  * @dev: the device to register
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 015183d129f96..18d9145198b5f 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -31,6 +31,12 @@ enum backlight_update_reason {
 	 * @BACKLIGHT_UPDATE_SYSFS: The backlight was updated using sysfs.
 	 */
 	BACKLIGHT_UPDATE_SYSFS,
+
+	/**
+	 * @BACKLIGHT_UPDATE_DRM: The backlight was updated from DRM, i.e. through
+	 * a connector LUMINANCE property rather than the legacy sysfs interface.
+	 */
+	BACKLIGHT_UPDATE_DRM,
 };
 
 /**
@@ -82,6 +88,11 @@ enum backlight_notification {
 	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
 	 */
 	BACKLIGHT_UNREGISTERED,
+
+	/**
+	 * @BACKLIGHT_BRIGHTNESS_CHANGED: The backlight brightness has changed.
+	 */
+	BACKLIGHT_BRIGHTNESS_CHANGED,
 };
 
 /** enum backlight_scale - the type of scale used for brightness values
@@ -310,8 +321,19 @@ struct backlight_device {
 	 * @use_count: The number of unblanked displays.
 	 */
 	int use_count;
+
+	/**
+	 * @drm_takeover: Number of luminance-aware DRM clients that have
+	 * taken over brightness control of this device. When non-zero,
+	 * writes to the legacy sysfs ``brightness`` attribute return
+	 * ``-EBUSY``. Managed by the DRM backlight helpers.
+	 */
+	atomic_t drm_takeover;
 };
 
+/* Forward declaration for backlight_update_status */
+void backlight_notify_brightness(struct backlight_device *bd);
+
 /**
  * backlight_update_status - force an update of the backlight device status
  * @bd: the backlight device
@@ -325,6 +347,10 @@ static inline int backlight_update_status(struct backlight_device *bd)
 		ret = bd->ops->update_status(bd);
 	mutex_unlock(&bd->update_lock);
 
+	/* Notify DRM and other listeners that brightness changed */
+	if (ret == 0)
+		backlight_notify_brightness(bd);
+
 	return ret;
 }
 
@@ -431,6 +457,21 @@ static inline void backlight_notify_blank_all(struct device *display_dev,
 { }
 #endif
 
+int backlight_set_brightness(struct backlight_device *bd, unsigned int value,
+			      enum backlight_update_reason reason);
+
+static inline void backlight_device_ref(struct backlight_device *bd)
+{
+	if (bd)
+		get_device(&bd->dev);
+}
+
+static inline void backlight_device_unref(struct backlight_device *bd)
+{
+	if (bd)
+		put_device(&bd->dev);
+}
+
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
 
 /**
-- 
2.43.0

