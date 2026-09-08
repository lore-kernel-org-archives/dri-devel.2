Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D568C79FAC
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 04:41:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9B1F10E989;
	Tue,  8 Sep 2026 04:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YZ7xlRwd";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B071710E989;
 Tue,  8 Sep 2026 04:41:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v99fJUIcqNvnkyLT/OFlrIpSFbBSMOT1ctHssy2/GFbxKcdpnyBmDp6rAoo7SLX4B3sl3T9O26OdMtoA+oDVoMnHAD/sfhQvn44cZ7FM/RjTOEpZhaTBoGXbyZ4zO6Nm2TyftCNGsnhuPAN8Q7GUKCRgchRmHnYwlypyI8madoyOlzZ71AA/l028iQDGe9dahv8schIlfXbtST1F3x0k3ohnmTY6zITu/Cuoz6F4T8xSZnGMDDPOrEUJ+cRF0AhPDzyrtedt5u9gcseurF1a4ARByCATnzFvQlHFySuVLsEhOMxGiUpzKpX2BDluDaujKWfDO9XDX8DLV0czkUwNPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnMkDdXucdrP/LVeqPrAPx3T3bPhA7jibVoaWfY4Qt4=;
 b=dhF/4LzF1x9+JVMuAVy+TRlZJLBa4tHEyswrvsEGHaK0gT05f5atBzPky02M3e3hSRCcHvix39vaFmJ6sgM6P9a6du/x9H/N3BUr6e2NiUm8wsjZMzo5CKazBe5392emiA0F1nPfBlvZOFXIqsFgftv2YBo0Lg+/Psj0HuNoWUg6WG21MBSgI/IYjpfhtKE/Fpq203u8gu8yLcFbuot68d/iulGtEMpB8WxIvxZQxy6Va48AC0uRbGhIg8LhEAgLsJoN2W/Wt/8lII8I4YWLOerKsVwptJWdx2XDaedUo9nA9Ud37P4dQQqOKxRSWYaJENv2AQciOI6WVagULxtsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnMkDdXucdrP/LVeqPrAPx3T3bPhA7jibVoaWfY4Qt4=;
 b=YZ7xlRwd+cKdjKMon3zFhiE2gAUr8w+D49O6G0+QEOkgpD1Zda8cDiZH7kXBpDqq7cRynWuI/fzI2WvtC5VwWiLnh4tT1lxnvP8bU0VAprod5v9STcGI75UuWxC7h9O1rtxSXSB8v9KQMklGN7uLVhGIC1qkfL/DFbEPYjpwA3I=
Received: from CY8PR12CA0034.namprd12.prod.outlook.com (2603:10b6:930:49::22)
 by SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 04:40:56 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::72) by CY8PR12CA0034.outlook.office365.com
 (2603:10b6:930:49::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 04:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 04:40:56 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 23:40:55 -0500
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
Subject: [PATCH v8 02/14] backlight: add kernel-internal backlight API
Date: Mon, 7 Sep 2026 23:40:23 -0500
Message-ID: <20260908044035.62093-3-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: be5df3d8-84cb-4dab-1a2b-08df0d635fa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|7416014|82310400026|1800799024|376014|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: oir7Na+fibBJbRvfH1Wqw4NLXpIGwhW8yrm5ydlEReqr2Z/XnEkNBJ4mC8l9zZaTYRZrYq2h58hUxBX1h9FXQo7JQ0RDVWRdwgIHAJfMhiFFVpjURf7IeX1w+LT+qA8qml+YPYovosaZrNZ/e+J/BDXzSODU0Al3DNJZgC/g+XkFuyb5xCbnsRoAws2yieZVgPM/kCM/LIPtw4CB59Xe1bt2V+NZar6fjWMiH4b+BIc0Fm7dI4qXLPslNMICnfbvn2bADAbrmgnVJtasqlkiSZwOAPJsabGuko8tnuR5XhGOhzew2+jKPCXG1xc81qA0V37latCm/Q6P1bAi5yEj3Eyv6XgbOXPK40nYlXwP+2cQXNMz3uhOhwsv6ZHYFWnnh44WEw8AlCYMgEluaB0Ta/eSDfzUMXOPgzkIATFy0ALh9bk+UThUkgwSGPtaUfNhYqeiExUFjdFS8LF1fVdiXqBTnXAFqr/xZydEegFRSQBrj1vMtGyu04ScIth0NUDyEL4a62mVREBdHMdtp+aYfqhYFCxBfsQ1JKKYyBl9zQFyNB5g/DMqDgjDmucb9G9NwYdFR4J65MemJifp1KNBscGS+9bCe/xAnnkxSAduIX93aDmfKFOLrDRvoJxPsPcCGB/+U6J60ZSgMGIATfmi3pACn5+7nsaoJ8K+XFDVr5uplzV6GcKOWEL4Ac//pGmv5mEP24KEpOXNUmS/Xhzvew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(7416014)(82310400026)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ArTSXc3ysnSUN/WXd8oPkeXf1VEQVLT+RF6MuDwnok6IKBLOpJXPXNUk9O7n0RvyF7mjLiljgaHHcsJWpTt6phzKV1W9koFyzCtoewNpK1v3buwR71v9ault/aBRvBsN5TGO9ec7Ul1qanD97Is+kc/iPJ+fCXfcyMhlTKIfoxMMwupffgdY5R8daNgNxLwZIjAfnde+GkhjkyfhiUxNzzespaByqDjK1uzbHmAY2AcNZeZnXhOXIAXYNOakR4upG1PdaiPtV8/cTDol6Ohge9BCZJZ8Vr4DNRMuvVhABnKYFY8WL37CGAuzz16G0zCaBpIzLwPtuHca7pAI29zjficU56sHjWegaT9WAZtdzfwSvIgLPr9Rtps0OsmZ1zwHV5dKcoLGhkWAIKthxBtDUn5/QL7eDp3+fzx6aA9W7Nlq3SYtVfU5/dc+7IQsAm7o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 04:40:56.6788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be5df3d8-84cb-4dab-1a2b-08df0d635fa4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942
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
 drivers/video/backlight/backlight.c | 66 +++++++++++++++++++++++++++++
 include/linux/backlight.h           | 45 ++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 4401f6294ccc8..1c700c1e77c3f 100644
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
@@ -150,6 +153,13 @@ static ssize_t bl_power_store(struct device *dev, struct device_attribute *attr,
 	struct backlight_device *bd = to_backlight_device(dev);
 	unsigned long power, old_power;
 
+	/* A luminance-aware DRM client has taken over this backlight; the
+	 * legacy sysfs interface is disabled until the last such client
+	 * goes away.
+	 */
+	if (atomic_read(&bd->drm_takeover) > 0)
+		return -EBUSY;
+
 	rc = kstrtoul(buf, 0, &power);
 	if (rc)
 		return rc;
@@ -214,6 +224,13 @@ static ssize_t brightness_store(struct device *dev,
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
@@ -514,6 +531,41 @@ static int devm_backlight_device_match(struct device *dev, void *res,
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
+ * Return: 0 if successfully notified, -EINVAL for invalid values, -ENXIO if the
+ * device has no ops (e.g. it is being unregistered)
+ */
+int backlight_set_brightness(struct backlight_device *bd, unsigned int value,
+			      enum backlight_update_reason reason)
+{
+	int rc = -ENXIO;
+
+	scoped_guard(mutex, &bd->ops_lock) {
+		if (bd->ops) {
+			if (value > bd->props.max_brightness)
+				return -EINVAL;
+
+			dev_dbg(&bd->dev, "set brightness to %u\n", value);
+			bd->props.brightness = value;
+			rc = backlight_update_status(bd);
+		}
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
@@ -548,6 +600,20 @@ int backlight_unregister_notifier(struct notifier_block *nb)
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
index 015183d129f96..fac1acbc698a1 100644
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
@@ -310,8 +321,23 @@ struct backlight_device {
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
+#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
+void backlight_notify_brightness(struct backlight_device *bd);
+#else
+static inline void backlight_notify_brightness(struct backlight_device *bd) {}
+#endif
+
 /**
  * backlight_update_status - force an update of the backlight device status
  * @bd: the backlight device
@@ -325,6 +351,10 @@ static inline int backlight_update_status(struct backlight_device *bd)
 		ret = bd->ops->update_status(bd);
 	mutex_unlock(&bd->update_lock);
 
+	/* Notify DRM and other listeners that brightness changed */
+	if (ret == 0)
+		backlight_notify_brightness(bd);
+
 	return ret;
 }
 
@@ -431,6 +461,21 @@ static inline void backlight_notify_blank_all(struct device *display_dev,
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

