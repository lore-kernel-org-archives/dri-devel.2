Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB72FFF885A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 22:10:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 634CA10F6DF;
	Fri, 24 Apr 2026 22:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xjyyNDwR";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E14010F6CF;
 Fri, 24 Apr 2026 22:10:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qczyz7UolD1NKHsBADYueJkV0XeMKIdzb4iQ/0b28Ywx87Blygw0izrRltCEzB4Ri8jwjYAcS7sRQ8oGbn64cCOFxOM+oQFZ9oeZzUv0DExBFJJyZmJZcm1RuBSkXdy1ZuwLgbEZc/YJLV6Xgr8WQkmeaqN1ieMYesc/PU6dkKIA7iCE9xztqGpaKiIZRDDmBp2EXP4+rTYlBnMII8b7owgByCR5oyTytjBbkUBariDNO35Q0OYaelcAN7K/PRLfhGEEOY9glYkB99GtA+lkPAQYgfnwatdLW8koaKz4b68FlErzUPwxH0R6gYXaXrLAFZUxColqYJ9EKpPWKC1cHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxUbTYd9HdZQJtmZw6mYE64sYkMdimuSMYF0u8xzGxw=;
 b=hW4GlkhfgpfFMpkoyWiEVllbsm9N46kGKx4LijX9QTR3UXDgGlNZqAHg+/gb07g7HuKsUiUxICkPfXbDZXi/EcPhUIgrpMip2fl11RFo/r8KEN1ECnOtkfXphnBZdXOS2swjkESHjhOUQzB8k/bhTv0Kh9d3aD2sW5utw713CoDiXChq1OZ0/R4+MG3efF+27D4844OfBmUh0tG2j9gKlPmCS89XqGyirzzuv6pWevRfU3hYWlNhOQFkzBir6y8rtLf2tpXTsKnyKMo1TgEFiZonV2T+1ncnpy50ANg/gh5y/IRWkN4r7bytPoALUdRoAkDlmpUc61ONEbmV+Euwlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxUbTYd9HdZQJtmZw6mYE64sYkMdimuSMYF0u8xzGxw=;
 b=xjyyNDwRQTKhXoAGkuJEgA8BDJlJg5o7U1gC0FpI1hdgo6BpysS4mjsjxru1BZLPw+n2P5RyiUVjGX+s+S22TXMoJUb94eUDgcn1O3ikG604hkcAQpsytehrCAFHlNRvZzQyOTW8JEC4I1ooht/ZJRyXl8Za3Z9soljn3s6Rf9g=
Received: from CH5PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:1f1::18)
 by SA1PR12MB5672.namprd12.prod.outlook.com (2603:10b6:806:23c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Fri, 24 Apr
 2026 22:10:17 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::3c) by CH5PR03CA0018.outlook.office365.com
 (2603:10b6:610:1f1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.22 via Frontend Transport; Fri,
 24 Apr 2026 22:10:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Fri, 24 Apr 2026 22:10:16 +0000
Received: from ausmlimonci-lx1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 24 Apr
 2026 17:10:13 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <dri-devel@lists.freedesktop.org>
CC: <harry.wentland@amd.com>, Xaver Hugl <xaver.hugl@gmail.com>,
 <amd-gfx@lists.freedesktop.org>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH v3 3/8] drm: link connectors to backlight devices
Date: Fri, 24 Apr 2026 17:09:48 -0500
Message-ID: <20260424220953.167058-4-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SA1PR12MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eec182a-3929-4e86-6d72-08dea24e43e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18096099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VrPK9vSukhziDjdbZ4kLFhdQUpO0CUAEizqsUn2pN7Lb1x+7ijXH5cxh0PsNc9ZYMLNQ51HEYZaHdwG70/hhLrk6wLYm4tPO4QrHKvBDQVOJkkaG7MkzhM2u5keCG4lXpowfLKXdtL6vFFGPs5kbRhE2PamXAVBrInExN1d6Roq9CbQd4vY6mBly+hsKY9veVc6eUx61WpZ2KxAxPq9JT//fKzfAOUBYpkGMgw7zPHpT2DFFElfLSYtgWZV542WzZNdRRVVbTB2rCrJg6pGMbc6G422FdflEhAXOyaiYG7RpMAUcJzIUovAu1eF1c8bYNdjfgb4/3Te00uWFQS4Poc1XLIaOq6eNKXmKrXOKZNq/56N5Tj8ydv8EkWGGkCKr0Y0v4lq7fGZu7y26VWNZnza9RlmeHW+anCfBDrY846LvGszZFtaAknmLkWPxEOox9fT4AmC/9DjK3WcODpOpjpgaw1bEUggdDl9G5XWYW71znerNHLh1Cb1EyJSUQbU0p8BNt5tZybvplG6hD1TQu6D7mGDvvgjhs63lC6Ie/5sJ3k4H2+PRydLsjb3GWzV0+g/W3wMmcYGA3MUwi3jqTl8xxfINXIo16TXrfrSKe025mYg2BScvJavaVzWBik6068wob8TP8H6Bm4Z+VKHf82dQinqHmJHwC+iT1qEd7BBf/rhSFIDVE3TRiSzik3GxJFGH0GdRNJ1//R0mQkKrJqd/vZtJMfI7+Skoksh4Eg1Yk3kD7FlzNg3z0C/j0EXJjewuGNY1GrG/bBhgwgNtfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18096099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PUit+Q4WbWT61L4cvHDGghaCNNcMJ2AnJtiBE85EQuQWn6phlrKQ1vD19SV9bYlsbGbm8s0x7LM4yBhhGjDdkJ+aqedw351CfxvCmjUjy6967lgSbZ9lEj69AU9YG7X6CqOqVhV6/Q4Z7IuaBidxQEk9ACV1HeKNsvzvSc41dc6I4x9qQGjH7bCndnFaoT6iJ8NoJcMvCED+Bccs4+CmpxBFh3W1UV4KqOxygh9fAQwBai78Xzt0qs0yEzb2ZkiOZDuySzz7yi62EhBHntSml59uvwYpUaol7cQKlh7LYxGjCu9PaXv1yTJq5t3jYMqhviDDhJ2Nj6CbGImMphRjY62LBetSQcchlCmdjIIWLdNtVMcA73KUwA6CK1nye0d0gzHD8LeZXxNJ7F3MAJ+SiuMhJfcbyHTnSVmGaSu5mGu+EksautH8QhXGYviYF++j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2026 22:10:16.2371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eec182a-3929-4e86-6d72-08dea24e43e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5672
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

This adds generic backlight-device support to DRM connectors. Drivers
that need to link backlight devices to DRM connectors can use the new
helpers to create a backlight property and link them at runtime.

Also add a brightness changed notification so that sysfs and DRM connector
can stay in sync and handle property updates around DPMS.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/Kconfig             |   1 +
 drivers/gpu/drm/Makefile            |   2 +
 drivers/gpu/drm/drm_backlight.c     | 406 ++++++++++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c     |  12 +
 drivers/gpu/drm/drm_drv.c           |   8 +
 drivers/gpu/drm/drm_mode_config.c   |   7 +
 drivers/gpu/drm/drm_mode_object.c   |  66 ++++-
 drivers/gpu/drm/drm_sysfs.c         |  54 ++++
 drivers/video/backlight/backlight.c |  17 ++
 include/drm/drm_backlight.h         |  45 +++
 include/drm/drm_connector.h         |   3 +
 include/drm/drm_mode_config.h       |   5 +
 include/linux/backlight.h           |  13 +
 13 files changed, 637 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_backlight.c
 create mode 100644 include/drm/drm_backlight.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 8f5a8d3012e41..8c00f534d50b8 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -17,6 +17,7 @@ menuconfig DRM
 # device and dmabuf fd. Let's make sure that is available for our userspace.
 	select KCMP
 	select VIDEO
+	select BACKLIGHT_CLASS_DEVICE
 	help
 	  Kernel-level support for the Direct Rendering Infrastructure (DRI)
 	  introduced in XFree86 4.0. If you say Y here, you need to select
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index e97faabcd7830..9912306e94950 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -78,6 +78,8 @@ drm-$(CONFIG_DRM_CLIENT) += \
 	drm_client_event.o \
 	drm_client_modeset.o \
 	drm_client_sysrq.o
+drm-y += drm_backlight.o
+drm-$(CONFIG_DRM_LIB_RANDOM) += lib/drm_random.o
 drm-$(CONFIG_COMPAT) += drm_ioc32.o
 drm-$(CONFIG_DRM_PANEL) += drm_panel.o
 drm-$(CONFIG_OF) += drm_of.o
diff --git a/drivers/gpu/drm/drm_backlight.c b/drivers/gpu/drm/drm_backlight.c
new file mode 100644
index 0000000000000..cbc6a855ed332
--- /dev/null
+++ b/drivers/gpu/drm/drm_backlight.c
@@ -0,0 +1,406 @@
+// SPDX-License-Identifier: MIT
+/*
+ * DRM Backlight Helpers
+ * Copyright (c) 2014 David Herrmann
+ * Copyright (c) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/backlight.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <drm/drm_backlight.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_device.h>
+#include <drm/drm_mode_config.h>
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
+ * This DRM backlight interface implements generic backlight properties on
+ * connectors. It does not handle any hardware backends but simply forwards
+ * the requests to an available and linked backlight device. The links between
+ * connectors and backlight devices have to be established by DRM drivers and
+ * can be modified by user-space via sysfs (and udev rules). The name of the
+ * backlight device can be written to a sysfs attribute called 'backlight'.
+ * The device is looked up and linked to the connector (replacing a possible
+ * previous backlight device). A 'change' uevent is sent whenever a link is
+ * modified.
+ *
+ * Drivers have to call drm_backlight_alloc() after allocating a connector via
+ * drm_connector_init(). This will automatically add a backlight device to the
+ * given connector. No hardware device is linked to the connector by default.
+ * Drivers can set up a default device via drm_backlight_set_name(), but are
+ * free to leave it empty. User-space will then have to set up the link.
+ */
+
+struct drm_backlight {
+	struct list_head list;
+	struct drm_connector *connector;
+	char *link_name;
+	struct backlight_device *link;
+	struct work_struct work;
+	unsigned int set_value;
+	bool changed : 1;
+};
+
+static LIST_HEAD(drm_backlight_list);
+static DEFINE_SPINLOCK(drm_backlight_lock);
+
+/* caller must hold @drm_backlight_lock */
+static bool __drm_backlight_is_registered(struct drm_backlight *b)
+{
+	lockdep_assert_held(&drm_backlight_lock);
+	/* a device is live if it is linked to @drm_backlight_list */
+	return !list_empty(&b->list);
+}
+
+/* caller must hold @drm_backlight_lock */
+static void __drm_backlight_schedule(struct drm_backlight *b)
+{
+	lockdep_assert_held(&drm_backlight_lock);
+	if (__drm_backlight_is_registered(b))
+		schedule_work(&b->work);
+}
+
+static void __drm_backlight_worker(struct work_struct *w)
+{
+	struct drm_backlight *b = container_of(w, struct drm_backlight, work);
+	static char *ep[] = { "BACKLIGHT=1", NULL };
+	struct backlight_device *bd;
+	bool send_uevent;
+	unsigned int v;
+
+	scoped_guard(spinlock, &drm_backlight_lock) {
+		send_uevent = b->changed;
+		b->changed = false;
+		v = b->set_value;
+		bd = b->link;
+		backlight_device_ref(bd);
+	}
+
+	if (bd) {
+		backlight_set_brightness(bd, v, BACKLIGHT_UPDATE_DRM);
+		backlight_device_unref(bd);
+	}
+
+	if (send_uevent)
+		kobject_uevent_env(&b->connector->kdev->kobj, KOBJ_CHANGE, ep);
+}
+
+/* caller must hold @drm_backlight_lock */
+static void __drm_backlight_prop_changed(struct drm_backlight *b, uint64_t v)
+{
+	uint64_t max;
+
+	lockdep_assert_held(&drm_backlight_lock);
+
+	if (!b || !b->link)
+		return;
+
+	max = b->link->props.max_brightness;
+	if (v >= U16_MAX)
+		b->set_value = max;
+	else
+		b->set_value = ((uint64_t)v * max) / U16_MAX;
+	__drm_backlight_schedule(b);
+}
+
+/* caller must hold @drm_backlight_lock */
+static void __drm_backlight_real_changed(struct drm_backlight *b, uint64_t v)
+{
+	struct drm_connector *connector = b->connector;
+	unsigned int max, set;
+
+	lockdep_assert_held(&drm_backlight_lock);
+
+	if (!b->link)
+		return;
+
+	set = v;
+	max = b->link->props.max_brightness;
+	if (max < 1)
+		return;
+
+	if (set >= max)
+		set = U16_MAX;
+	else
+		set = ((uint64_t)set * U16_MAX) / max;
+
+	/* Update the atomic state directly.
+	 * For atomic drivers, the luminance value is stored in
+	 * connector->state->luminance, not in the legacy property array.
+	 * We update it unconditionally to reflect the hardware state,
+	 * regardless of DPMS.
+	 */
+	if (connector->state)
+		connector->state->luminance = set;
+}
+
+/* caller must hold @drm_backlight_lock */
+static void __drm_backlight_link(struct drm_backlight *b,
+				 struct backlight_device *bd)
+{
+	if (bd == b->link)
+		return;
+
+	backlight_device_unref(b->link);
+	b->link = bd;
+	backlight_device_ref(b->link);
+	if (bd)
+		__drm_backlight_real_changed(b, bd->props.brightness);
+	b->changed = true;
+	__drm_backlight_schedule(b);
+}
+
+/* caller must hold @drm_backlight_lock */
+static void __drm_backlight_lookup(struct drm_backlight *b)
+{
+	struct backlight_device *bd;
+
+	if (b->link_name)
+		bd = backlight_device_lookup(b->link_name);
+	else
+		bd = NULL;
+
+	__drm_backlight_link(b, bd);
+	backlight_device_unref(bd);
+}
+
+/**
+ * drm_backlight_alloc - add backlight capability to a connector
+ * @connector: connector to add backlight to
+ *
+ * This allocates a new DRM-backlight device and links it to @connector. This
+ * *must* be called before registering the connector. The backlight device will
+ * be automatically registered in sync with the connector. It will also get
+ * removed once the connector is removed.
+ *
+ * The connector will not have any hardware backlight linked by default. You
+ * need to call drm_backlight_set_name() if you want to set a default
+ * backlight. User-space can overwrite those via sysfs.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int drm_backlight_alloc(struct drm_connector *connector)
+{
+	struct drm_mode_config *config = &connector->dev->mode_config;
+	struct drm_backlight *b;
+
+	b = kzalloc_obj(*b, GFP_KERNEL);
+	if (!b)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&b->list);
+	INIT_WORK(&b->work, __drm_backlight_worker);
+	b->connector = connector;
+	connector->backlight = b;
+
+	drm_object_attach_property(&connector->base,
+				   config->luminance_property, U16_MAX);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_backlight_alloc);
+
+void drm_backlight_free(struct drm_connector *connector)
+{
+	struct drm_backlight *b = connector->backlight;
+
+	if (!b)
+		return;
+
+	WARN_ON(__drm_backlight_is_registered(b));
+	WARN_ON(b->link);
+
+	kfree(b->link_name);
+	kfree(b);
+	connector->backlight = NULL;
+}
+EXPORT_SYMBOL(drm_backlight_free);
+
+void drm_backlight_register(struct drm_backlight *b)
+{
+	if (!b)
+		return;
+
+	WARN_ON(__drm_backlight_is_registered(b));
+
+	guard(spinlock)(&drm_backlight_lock);
+	list_add(&b->list, &drm_backlight_list);
+	__drm_backlight_lookup(b);
+}
+EXPORT_SYMBOL(drm_backlight_register);
+
+void drm_backlight_unregister(struct drm_backlight *b)
+{
+	if (!b)
+		return;
+
+	WARN_ON(!__drm_backlight_is_registered(b));
+
+	scoped_guard(spinlock, &drm_backlight_lock) {
+		list_del_init(&b->list);
+		__drm_backlight_link(b, NULL);
+	}
+
+	cancel_work_sync(&b->work);
+}
+EXPORT_SYMBOL(drm_backlight_unregister);
+
+/**
+ * drm_backlight_get_name - retrieve name of linked backlight device
+ * @b: DRM backlight to retrieve name of
+ * @buf: target buffer for name
+ * @max: size of the target buffer
+ *
+ * This retrieves the name of the backlight device linked to @b and writes it
+ * into @buf. If @buf is NULL or @max is 0, no name will be retrieved, but this
+ * function only tests whether a link is set.
+ * Otherwise, the name will always be written into @buf and will always be
+ * zero-terminated (truncated if too long).
+ *
+ * If no backlight device is linked to @b, this returns -ENOENT. Otherwise, the
+ * length of the written name (excluding the terminating 0 character) is
+ * returned.
+ * Note that if a device name has been set but the underlying backlight device
+ * does not exist, this will still return the linked name. -ENOENT is only
+ * returned if no device name has been set, yet (or has been cleared).
+ *
+ * Returns: On success the length of the written name, on failure a negative
+ *          error code.
+ */
+int drm_backlight_get_name(struct drm_backlight *b, char *buf, size_t max)
+{
+	int r;
+
+	guard(spinlock)(&drm_backlight_lock);
+
+	if (!b || !b->link_name)
+		return -ENOENT;
+
+	if (!buf || !max)
+		return -EINVAL;
+
+	r = strlen(b->link_name);
+
+	if (r + 1 > max)
+		r = max - 1;
+	buf[r] = 0;
+	memcpy(buf, b->link_name, r);
+
+	return r;
+}
+EXPORT_SYMBOL(drm_backlight_get_name);
+
+/**
+ * drm_backlight_set_name - Change the device link of a DRM backlight
+ * @b: DRM backlight to modify
+ * @name: name of backlight device
+ *
+ * This changes the backlight device-link on @b to the hardware device with
+ * name @name. @name is stored on the backlight device, even if no such
+ * hardware device is registered, yet. If a backlight device appears later on,
+ * it will be automatically linked to all matching DRM backlight devices. If a
+ * real hardware backlight device already exists with such a name, it is linked
+ * with immediate effect.
+ *
+ * Whenever a real hardware backlight is linked or unlinked from a DRM connector
+ * an uevent with "BACKLIGHT=1" is generated on the connector.
+ *
+ * Returns: 0 on success, negative error code on failure.
+ */
+int drm_backlight_set_name(struct drm_backlight *b, const char *name)
+{
+	char *namecopy;
+
+	if (name && *name) {
+		namecopy = kstrdup(name, GFP_KERNEL);
+		if (!namecopy)
+			return -ENOMEM;
+	} else {
+		namecopy = NULL;
+	}
+
+	guard(spinlock)(&drm_backlight_lock);
+
+	kfree(b->link_name);
+	b->link_name = namecopy;
+	if (__drm_backlight_is_registered(b))
+		__drm_backlight_lookup(b);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_backlight_set_name);
+
+void drm_backlight_set_luminance(struct drm_backlight *b, uint64_t value)
+{
+	guard(spinlock)(&drm_backlight_lock);
+	__drm_backlight_prop_changed(b, value);
+}
+EXPORT_SYMBOL(drm_backlight_set_luminance);
+
+static int drm_backlight_notify(struct notifier_block *self,
+				unsigned long event, void *data)
+{
+	struct backlight_device *bd = data;
+	struct drm_backlight *b;
+	const char *name;
+
+	guard(spinlock)(&drm_backlight_lock);
+
+	switch (event) {
+	case BACKLIGHT_REGISTERED:
+		name = dev_name(&bd->dev);
+		if (!name)
+			break;
+
+		list_for_each_entry(b, &drm_backlight_list, list)
+			if (!b->link && b->link_name &&
+			    !strcmp(name, b->link_name))
+				__drm_backlight_link(b, bd);
+
+		break;
+	case BACKLIGHT_UNREGISTERED:
+		list_for_each_entry(b, &drm_backlight_list, list)
+			if (b->link == bd)
+				__drm_backlight_link(b, NULL);
+
+		break;
+	case BACKLIGHT_BRIGHTNESS_CHANGED:
+		/* Update DRM property value when hardware backlight changes */
+		list_for_each_entry(b, &drm_backlight_list, list)
+			if (b->link == bd)
+				__drm_backlight_real_changed(b, bd->props.brightness);
+
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
index 47dc53c4a738f..d76878548728a 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -21,6 +21,7 @@
  */
 
 #include <drm/drm_auth.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
@@ -760,6 +761,7 @@ void drm_connector_cleanup(struct drm_connector *connector)
 	struct drm_device *dev = connector->dev;
 	struct drm_display_mode *mode, *t;
 
+	drm_backlight_free(connector);
 	/* The connector should have been removed from userspace long before
 	 * it is finally destroyed.
 	 */
@@ -845,6 +847,8 @@ int drm_connector_register(struct drm_connector *connector)
 	if (connector->registration_state != DRM_CONNECTOR_INITIALIZING)
 		goto unlock;
 
+	drm_backlight_register(connector->backlight);
+
 	ret = drm_sysfs_connector_add(connector);
 	if (ret)
 		goto unlock;
@@ -931,6 +935,8 @@ EXPORT_SYMBOL(drm_connector_dynamic_register);
 void drm_connector_unregister(struct drm_connector *connector)
 {
 	mutex_lock(&connector->mutex);
+	drm_backlight_unregister(connector->backlight);
+
 	if (connector->registration_state != DRM_CONNECTOR_REGISTERED) {
 		mutex_unlock(&connector->mutex);
 		return;
@@ -3257,10 +3263,16 @@ int drm_connector_set_obj_prop(struct drm_mode_object *obj,
 {
 	int ret = -EINVAL;
 	struct drm_connector *connector = obj_to_connector(obj);
+	struct drm_mode_config *config = &connector->dev->mode_config;
 
 	/* Do DPMS ourselves */
 	if (property == connector->dev->mode_config.dpms_property) {
 		ret = (*connector->funcs->dpms)(connector, (int)value);
+	} else if (property == config->brightness_property) {
+		if (connector->backlight && connector->dpms == DRM_MODE_DPMS_ON)
+			drm_backlight_set_brightness(connector->backlight,
+						     value);
+		ret = 0;
 	} else if (connector->funcs->set_property)
 		ret = connector->funcs->set_property(connector, property, value);
 
diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 985c283cf59fa..4fd8c2590d154 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -42,6 +42,7 @@
 #include <linux/xarray.h>
 
 #include <drm/drm_accel.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_cache.h>
 #include <drm/drm_client_event.h>
@@ -1228,6 +1229,7 @@ static void drm_core_exit(void)
 	drm_privacy_screen_lookup_exit();
 	drm_panic_exit();
 	accel_core_exit();
+	drm_backlight_exit();
 	unregister_chrdev(DRM_MAJOR, "drm");
 	drm_debugfs_remove_root();
 	drm_sysfs_destroy();
@@ -1251,6 +1253,12 @@ static int __init drm_core_init(void)
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
index 66f7dc37b5970..585d80e3c1330 100644
--- a/drivers/gpu/drm/drm_mode_config.c
+++ b/drivers/gpu/drm/drm_mode_config.c
@@ -32,6 +32,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_colorop.h>
 #include <linux/dma-resv.h>
+#include <drm/drm_backlight.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
@@ -407,6 +408,12 @@ static int drm_mode_create_standard_properties(struct drm_device *dev)
 		return -ENOMEM;
 	dev->mode_config.size_hints_property = prop;
 
+	prop = drm_property_create_range(dev, DRM_MODE_PROP_ATOMIC,
+					 "LUMINANCE", 0, U16_MAX);
+	if (!prop)
+		return -ENOMEM;
+	dev->mode_config.luminance_property = prop;
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/drm_mode_object.c b/drivers/gpu/drm/drm_mode_object.c
index 2d943a610b88b..e6f0027d70cb5 100644
--- a/drivers/gpu/drm/drm_mode_object.c
+++ b/drivers/gpu/drm/drm_mode_object.c
@@ -30,6 +30,7 @@
 #include <drm/drm_mode_object.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
+#include <drm/drm_backlight.h>
 
 #include "drm_crtc_internal.h"
 
@@ -287,11 +288,72 @@ int drm_object_property_set_value(struct drm_mode_object *obj,
 {
 	int i;
 
-	WARN_ON(drm_drv_uses_atomic_modeset(property->dev) &&
-		!(property->flags & DRM_MODE_PROP_IMMUTABLE));
+	/* Exempt dpms and luminance properties from the atomic warning, as these
+	 * have special interdependencies managed internally in this function
+	 */
+	if (obj->type == DRM_MODE_OBJECT_CONNECTOR) {
+		struct drm_connector *connector = obj_to_connector(obj);
+		struct drm_mode_config *config = &connector->dev->mode_config;
+
+		if (property != config->dpms_property &&
+		    property != config->luminance_property) {
+			WARN_ON(drm_drv_uses_atomic_modeset(property->dev) &&
+				!(property->flags & DRM_MODE_PROP_IMMUTABLE));
+		}
+	} else {
+		WARN_ON(drm_drv_uses_atomic_modeset(property->dev) &&
+			!(property->flags & DRM_MODE_PROP_IMMUTABLE));
+	}
 
 	for (i = 0; i < obj->properties->count; i++) {
+		/* If properties depends on each other
+		 * this is where to resolve that issue
+		 */
 		if (obj->properties->properties[i] == property) {
+			/* Connector-specific property interdependencies */
+			if (obj->type == DRM_MODE_OBJECT_CONNECTOR) {
+				struct drm_connector *connector = obj_to_connector(obj);
+				struct drm_property *dpms_property =
+					connector->dev->mode_config.dpms_property;
+				struct drm_property *luminance_property =
+					connector->dev->mode_config.luminance_property;
+
+				if (property == dpms_property) {
+					/* When DPMS goes from ON -> OFF,
+					 * set the brightness to the minimum possible
+					 * to save power.
+					 */
+					if (obj->properties->values[i] !=
+					    DRM_MODE_DPMS_OFF &&
+					    val == DRM_MODE_DPMS_OFF)
+						drm_backlight_set_luminance(
+							connector->backlight, 0);
+					/* When DPMS OFF -> ON, reset the brightness
+					 * to the original level
+					 */
+					else if (obj->properties->values[i] ==
+						 DRM_MODE_DPMS_OFF &&
+						 val != DRM_MODE_DPMS_OFF) {
+						uint64_t value;
+
+						drm_object_property_get_value(
+							obj, luminance_property,
+							&value);
+						drm_backlight_set_luminance(
+							connector->backlight, value);
+					}
+				} else if (property == luminance_property) {
+					/* Always update the property value to remember
+					 * the user's desired brightness, but only update
+					 * hardware when DPMS is ON.
+					 */
+					obj->properties->values[i] = val;
+					if (connector->dpms == DRM_MODE_DPMS_ON)
+						drm_backlight_set_luminance(
+							connector->backlight, val);
+					return 0;
+				}
+			}
 			obj->properties->values[i] = val;
 			return 0;
 		}
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index ef4e923a87284..eb7d54d991272 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 
 #include <drm/drm_accel.h>
+#include <drm/drm_backlight.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
@@ -303,11 +304,63 @@ static ssize_t connector_id_show(struct device *device,
 	return sysfs_emit(buf, "%d\n", connector->base.id);
 }
 
+static ssize_t backlight_show(struct device *device,
+			      struct device_attribute *attr,
+			      char *buf)
+{
+	struct drm_connector *connector = to_drm_connector(device);
+	int r;
+
+	if (!connector->backlight)
+		return -EOPNOTSUPP;
+
+	r = drm_backlight_get_name(connector->backlight, buf, PAGE_SIZE);
+	if (r < 0)
+		return r;
+
+	if (r + 1 < PAGE_SIZE) {
+		buf[r++] = '\n';
+		buf[r] = 0;
+	}
+
+	return r;
+}
+
+static ssize_t backlight_store(struct device *device,
+			       struct device_attribute *attr,
+			       const char *buf, size_t size)
+{
+	struct drm_connector *connector = to_drm_connector(device);
+	const char *t;
+	char *name;
+	size_t len;
+	int r;
+
+	if (!connector->backlight)
+		return -EOPNOTSUPP;
+
+	t = strchrnul(buf, '\n');
+	len = t - buf;
+
+	name = kstrndup(buf, len, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	r = drm_backlight_set_name(connector->backlight, name);
+	kfree(name);
+
+	if (r < 0)
+		return r;
+
+	return size;
+}
+
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(enabled);
 static DEVICE_ATTR_RO(dpms);
 static DEVICE_ATTR_RO(modes);
 static DEVICE_ATTR_RO(connector_id);
+static DEVICE_ATTR_RW(backlight);
 
 static struct attribute *connector_dev_attrs[] = {
 	&dev_attr_status.attr,
@@ -315,6 +368,7 @@ static struct attribute *connector_dev_attrs[] = {
 	&dev_attr_dpms.attr,
 	&dev_attr_modes.attr,
 	&dev_attr_connector_id.attr,
+	&dev_attr_backlight.attr,
 	NULL
 };
 
diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 9bbfc16cf2d74..1557dfb3a3bf3 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -125,6 +125,9 @@ static void backlight_generate_event(struct backlight_device *bd,
 	case BACKLIGHT_UPDATE_HOTKEY:
 		envp[0] = "SOURCE=hotkey";
 		break;
+	case BACKLIGHT_UPDATE_DRM:
+		envp[0] = "SOURCE=drm";
+		break;
 	default:
 		envp[0] = "SOURCE=unknown";
 		break;
@@ -613,6 +616,20 @@ int backlight_unregister_notifier(struct notifier_block *nb)
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
diff --git a/include/drm/drm_backlight.h b/include/drm/drm_backlight.h
new file mode 100644
index 0000000000000..42f00a930584b
--- /dev/null
+++ b/include/drm/drm_backlight.h
@@ -0,0 +1,45 @@
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
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+struct drm_backlight;
+struct drm_connector;
+struct drm_mode_object;
+
+int drm_backlight_init(void);
+void drm_backlight_exit(void);
+
+int drm_backlight_alloc(struct drm_connector *connector);
+void drm_backlight_free(struct drm_connector *connector);
+void drm_backlight_register(struct drm_backlight *b);
+void drm_backlight_unregister(struct drm_backlight *b);
+
+int drm_backlight_get_name(struct drm_backlight *b, char *buf, size_t max);
+int drm_backlight_set_name(struct drm_backlight *b, const char *name);
+void drm_backlight_set_luminance(struct drm_backlight *b, uint64_t value);
+#endif /* __DRM_BACKLIGHT_H__ */
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f83f28cae2075..10daf088b8f1a 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2410,6 +2410,9 @@ struct drm_connector {
 	 * @cec: CEC-related data.
 	 */
 	struct drm_connector_cec cec;
+
+	/* backlight link */
+	struct drm_backlight *backlight;
 };
 
 #define obj_to_connector(x) container_of(x, struct drm_connector, base)
diff --git a/include/drm/drm_mode_config.h b/include/drm/drm_mode_config.h
index 687c0ee163d25..b340dc93f8148 100644
--- a/include/drm/drm_mode_config.h
+++ b/include/drm/drm_mode_config.h
@@ -852,6 +852,11 @@ struct drm_mode_config {
 	 * the position of the output on the host's screen.
 	 */
 	struct drm_property *suggested_y_property;
+	/**
+	 * @luminance_property: Default connector property to control the
+	 * connector's backlight luminance.
+	 */
+	struct drm_property *luminance_property;
 
 	/**
 	 * @non_desktop_property: Optional connector property with a hint
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 851570b39d041..f7f1e18909460 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -29,6 +29,7 @@ enum backlight_update_reason {
 	 * @BACKLIGHT_UPDATE_SYSFS: The backlight was updated using sysfs.
 	 */
 	BACKLIGHT_UPDATE_SYSFS,
+	BACKLIGHT_UPDATE_DRM,
 };
 
 /**
@@ -80,6 +81,11 @@ enum backlight_notification {
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
@@ -310,6 +316,9 @@ struct backlight_device {
 	int use_count;
 };
 
+/* Forward declaration for backlight_update_status */
+void backlight_notify_brightness(struct backlight_device *bd);
+
 /**
  * backlight_update_status - force an update of the backlight device status
  * @bd: the backlight device
@@ -323,6 +332,10 @@ static inline int backlight_update_status(struct backlight_device *bd)
 		ret = bd->ops->update_status(bd);
 	mutex_unlock(&bd->update_lock);
 
+	/* Notify DRM and other listeners that brightness changed */
+	if (ret == 0)
+		backlight_notify_brightness(bd);
+
 	return ret;
 }
 
-- 
2.43.0

