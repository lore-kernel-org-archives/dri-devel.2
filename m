Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A0A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D5CB1127C7;
	Fri, 27 Nov 2026 07:46:57 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022122.outbound.protection.outlook.com [52.101.126.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B8911262C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 07:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=geQOOduP0E/mYRCRVMZzwdRMWLsCwMMKoGpfT8gQTE3hes20XXU2SsTPGmFS6+lIdfMCB7uLf0WyH5aLN1HJOR7X++xduFoVgDu/grFs8AF2DVTTA8rASJWvRVI8MOeR+aiF04k49G9rj93bPmNup+7Dvrj/vgIBxpEh1JkNpe9u4fp0aY0Nz5N1XqmIUnegnnt9EuwghM9qW9K/alfKFlsdVzP3VUGcyZLFF2Y/T1IrVM/laBISuln9quLY6i/pLE2o7Y4gduUOOdoLI3EV/jt/7ZJoU+UHZLvE4ZF939+An/kRwJpx2BePc+LEHJ3ll2WArwYj0UYioCYSAR52cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8SdkqALBpHEAsP4ZTmWBnGgpEd577t4bvvkwEPLn6E=;
 b=lzWsxA+Bb8fThc1dzmRjPX8zjZe6gEjIjuqKhgV8wS5mPwcJGerELE3U2CsXg8PeAFwW26KKnYBabSVWlrr0610U8i68gElPyshWpzNPafB8odSZwBsHNlE+LItC4qEexqtTCs9hNU7nvf0Nno1kxDHpe25M6/elopRvGsXcJu72OmTIpXkeFBgjYxehXX8TbqAjlb0QYe0oHDpk8C8YNSWl+wDE4QrqGWCMHnMp4MnIHBSBiNGlTzhRSlbBda9Fc6uqLA/Z5KbNsx1fPX7/z0bR2dxj56X5FCdRL5/FYajoqPffLO7rQI1YLIyWmccKibHMHzZ6oZJ+wTvDSrVJnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI2PR02CA0039.apcprd02.prod.outlook.com (2603:1096:4:196::9) by
 TYNPR06MB8830.apcprd06.prod.outlook.com (2603:1096:405:3c7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3; Fri, 27 Nov 2026 07:46:42 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:196:cafe::81) by SI2PR02CA0039.outlook.office365.com
 (2603:1096:4:196::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 07:46:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 07:46:40 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 453CE40920E7;
 Fri, 27 Nov 2026 15:46:40 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
Subject: [PATCH v7 3/5] drm/bridge: trilinear: add the DPTX DRM bridge
Date: Fri, 27 Nov 2026 15:46:37 +0800
Message-Id: <20261127074639.277959-4-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261127074639.277959-1-Luo.Liu@cixtech.com>
References: <20261127074639.277959-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|TYNPR06MB8830:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f512486c-4fa1-497e-816e-08df4c5a9351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|82310400026|7416014|1800799024|36860700016|376014|23010399003|6133799003|22082099003|18092099006|18002099003|3023799007|56012099006|5023799004|261028144727099003|261022075727099003|261026121527099003|261022105027099003|261026140227099003|261021123027099003|261009221227099003|261021121427099003|261102123227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: vZIAThpJFoJ+5eEI6XF6M6LTtsnElTg1pFawJc8+o6Z9FZH7nTr29TE4fZdjZ1/Cdzdzoc3cHwBzId+2oMT2nL3Fd508TFuhUmDcSGeuWljFDvEUrortZUIs+A3QuxXmoEbRpzwbXiTI4jZgQltnt2j3KVI/41EZG0K8+RTAitp/jKSjY78tZJ+k8a4ET5B1n4cCRW2e0vRwjUBtG0/7u4Vjhn4niZcQStLw7OPL82W2LhT8D8QWaqdHv31f0UBHEW10XPmXiA6c6GFM5b3CS2TJT9902hnauW86WjADklZyOC/cV5h4GsAwQliTDqvTqlH1cpSVGCvtlSc2PC7jkA95mmHtskzia+Bk+TUrlVdFt0do1PFU9Kr4LvcANPaBsxlMmlylmRGTyB4RUqu7Z6X/t70htEpOJz7FMitGxpLyIQkLZydiXuJ1WXFNxcrNCZCxYOASjauUMoftmW5co1FRtOj7wZg2sh3ayMOoxby8c5qgEYn3uVQVn3JlluUEw7H7Kx6VnMmjWa1blyVU7bdnLxuoWJOxTC83pGz7zN/sko4gawmB3dJHpIE7thkEs3Up5IRs3UT6twzRnlL8ZrMvZcfRucvs+TWf2kV89Y+W0MwXrkf7a9SnLVK8Tuz5rJClxt2sokCHm5/3rZ7ZXBv+/hG1kkZ+4xdHJZVILG0GrQOh72l9zMAk5ZvYJDt246oRy67oz0OzmITFe4K39w==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(42112799006)(82310400026)(7416014)(1800799024)(36860700016)(376014)(23010399003)(6133799003)(22082099003)(18092099006)(18002099003)(3023799007)(56012099006)(5023799004)(261028144727099003)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261021123027099003)(261009221227099003)(261021121427099003)(261102123227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BW6DhETkm/Cc56wARylQ6GrK+isTwOmYgdc83RJsWurQEQ1T9kOXS9aweT4BmXUmxzW7F6uSP0JCmcrhcJj6HaKtgfDngszbXW/ePY8nnWJnzxEP4jeHsg/jbek7lUOt6gbzHGLcwBclhZgbM3PeZQcKUPIyi7UHoNN7EVw+PWxMMtTtcAkyKqUsfSQof3DG6qxfjPEXL4L4GJRGoGoLRcdFqjlHkoiSSQvs4DRHEGFe9uXK7Dm+Eex21OvcHhH4GyOqbTOy4Zu5mOsYkDJbt/APDEYFRUmPLe5vlHBMohu/cMYIRPGpGqf/DBINQybeDpdB8lFlkB2IJHyoK2ZMghRd+YVEy1lwqWhnAyHt38xdZjOGw2B3/6BR3JO3/yOWe0hFDXq+9ep2DK/pVZzZiA7cZU1EZ4zsI/2OmHx9EikYPZ6jcx4144wPgp94mEJ/
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 07:46:40.9719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f512486c-4fa1-497e-816e-08df4c5a9351
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYNPR06MB8830
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the DRM bridge that exposes the transmitter to KMS: connector
detection, EDID mode enumeration with a downstream timing fallback,
validation of a mode against the sink link capabilities, and the atomic
enable and disable paths.

The bridge is meant to be attached with DRM_BRIDGE_ATTACH_NO_CONNECTOR;
the connector is created by drm_bridge_connector_init() from the bridge
operations, so the driver only implements the bridge side and never
creates a connector of its own.

The bridge adds a device link to the controller on attach, so the
transmitter resumes before the controller's resume commit and is
suspended after the controller has stopped issuing commits. The link is
created only if the transmitter has not been released, and is dropped
on detach.

Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
---
 MAINTAINERS                                 |   1 +
 drivers/gpu/drm/bridge/trilinear/dptx.h     | 113 +++
 drivers/gpu/drm/bridge/trilinear/dptx_drm.c | 734 ++++++++++++++++++++
 drivers/gpu/drm/bridge/trilinear/dptx_drm.h |  17 +
 include/drm/bridge/trilinear_dp.h           |  74 ++
 5 files changed, 939 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx.h
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_drm.c
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_drm.h
 create mode 100644 include/drm/bridge/trilinear_dp.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 01ff0666f63b..6ebb17dd18e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6530,6 +6530,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/cix,sky1-dp.yaml
 F:	drivers/gpu/drm/bridge/trilinear/
+F:	include/drm/bridge/trilinear_dp.h
 
 CLANG CONTEXT ANALYSIS
 M:	Marco Elver <elver@google.com>
diff --git a/drivers/gpu/drm/bridge/trilinear/dptx.h b/drivers/gpu/drm/bridge/trilinear/dptx.h
new file mode 100644
index 000000000000..ac4199142c33
--- /dev/null
+++ b/drivers/gpu/drm/bridge/trilinear/dptx.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * DisplayPort transmitter driver
+ *
+ * Copyright (C) 2026 Trilinear Technologies
+ * Copyright 2026 Cix Technology Group Co., Ltd.
+ */
+
+#ifndef DPTX_H
+#define DPTX_H
+
+#include <linux/bits.h>
+#include <linux/mutex.h>
+
+#include <drm/bridge/trilinear_dp.h>
+#include <drm/display/drm_dp_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+
+#include "dptx_hw.h"
+
+#define DPTX_MAX_RATE(rate, lanes, bpp) ((rate) * (lanes) * 8 / (bpp))
+
+#define bridge_to_dp(_bridge) \
+	container_of(_bridge, struct dptx_dev, bridge)
+
+#define DPTX_MAX_FREQ 600000
+#define DP_MAX_TRAINING_LOOP 3
+
+enum dptx_state {
+	DPTX_STATE_DISCONNECTED = 0,
+	DPTX_STATE_CONFIGURED = BIT(0),
+	DPTX_STATE_INITIALIZED = BIT(1),
+	DPTX_STATE_READY = BIT(2),
+	DPTX_STATE_CONNECTED = BIT(3),
+	DPTX_STATE_ENABLED = BIT(6),
+	DPTX_STATE_SUSPENDED = BIT(7),
+	DPTX_STATE_SHUTDOWN = BIT(9),
+};
+
+struct dptx_mode {
+	u8 bw_code;
+	u8 lane_cnt;
+	int pclock;
+	int link_rate;
+};
+
+struct dptx_config {
+	int bpp;
+	int bpc;
+	enum dp_pixelformat format;
+	u32 colorspace;
+	u8 content_type;
+};
+
+struct dptx_dev;
+struct device_link;
+struct dp_hw;
+struct phy;
+struct task_struct;
+
+struct dptx_ops {
+	int (*detect)(struct dptx_dev *dp);
+	enum drm_connector_status (*detect_status)(struct dptx_dev *dp);
+	int (*prepare)(struct dptx_dev *dp);
+	int (*unprepare)(struct dptx_dev *dp);
+	int (*encoder_enable)(struct dptx_dev *dp, unsigned int stream_id,
+			      int enable);
+	int (*mode_configure)(struct dptx_dev *dp, int pclk, u8 bw, u8 bpp,
+			      bool downshift);
+	void (*replay_deferred_hotplug)(struct dptx_dev *dp);
+	void (*quiesce_hpd)(struct dptx_dev *dp);
+};
+
+struct dptx_dev {
+	struct drm_bridge bridge;
+	struct device *dev;
+	struct phy *phy;
+	int irq;
+	bool irq_suspended;
+	bool hpd_stopped;
+	bool attached;
+	struct device_link *link;
+	/* Set when the platform device is gone; the bridge may still be in use. */
+	bool released;
+	/* Link limits of the current sink, clamped to the controller ones. */
+	int link_max_rate;
+	int link_max_lanes;
+
+	struct delayed_work hpd_event_work;
+	struct delayed_work hpd_irq_work;
+	enum drm_connector_status force_hpd;
+	/* Tasks whose detect or hpd_notify result is currently echoing back. */
+	struct task_struct *detect_task;
+	struct task_struct *notify_task;
+	struct dptx_mode mode;
+	/* Adjusted mode of the enabled stream, cached for the hotplug workers. */
+	struct drm_display_mode adjusted_mode;
+	enum dptx_state state;
+	u32 pixel_per_cycle;
+	u32 active_stream_cnt;
+	/* Serializes the DP state against the hotplug workers. */
+	struct mutex lock;
+	u32 active_streams;
+	struct dptx_config config;
+	const struct dptx_ops *ops;
+	struct dp_hw *hw;
+	const struct dptx_plat_data *soc_data;
+	bool oob_hpd;
+	void *soc_priv;
+};
+
+#endif /* DPTX_H */
diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_drm.c b/drivers/gpu/drm/bridge/trilinear/dptx_drm.c
new file mode 100644
index 000000000000..7a081873560b
--- /dev/null
+++ b/drivers/gpu/drm/bridge/trilinear/dptx_drm.c
@@ -0,0 +1,734 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * DisplayPort DRM bridge helpers
+ *
+ * Copyright 2026 Cix Technology Group Co., Ltd.
+ */
+
+#include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_edid.h>
+
+#include "dptx.h"
+#include "dptx_drm.h"
+
+#define DPTX_MIN_H_BACKPORCH 12
+#define DPTX_MIN_BPP		(6 * 3)
+
+struct fmt_prio_entry {
+	int format;
+	int bpc;
+};
+
+/* SST: RGB -> YUV422 10 -> YUV422 8 -> RGB 6 -> YUV420 8 */
+static const struct fmt_prio_entry fmt_prio[] = {
+	{ DRM_OUTPUT_COLOR_FORMAT_RGB444, 0 },
+	{ DRM_OUTPUT_COLOR_FORMAT_YCBCR422, 10 },
+	{ DRM_OUTPUT_COLOR_FORMAT_YCBCR422, 8 },
+	{ DRM_OUTPUT_COLOR_FORMAT_RGB444, 6 },
+	{ DRM_OUTPUT_COLOR_FORMAT_YCBCR420, 8 },
+};
+
+static const u8 dp_common_link_bw[] = {
+	DP_LINK_BW_1_62,
+	DP_LINK_BW_2_7,
+	DP_LINK_BW_5_4,
+	DP_LINK_BW_8_1,
+};
+
+static enum drm_connector_status dptx_bridge_detect(struct drm_bridge *bridge,
+						    struct drm_connector *connector)
+{
+	struct dptx_dev *dp = bridge_to_dp(bridge);
+	enum drm_connector_status status;
+
+	status = dp->ops->detect_status(dp);
+	WRITE_ONCE(dp->detect_task, current);
+
+	return status;
+}
+
+static void dptx_hpd_notify(struct dptx_dev *dp,
+			    enum drm_connector_status hpd_state)
+{
+	if (READ_ONCE(dp->detect_task) == current) {
+		WRITE_ONCE(dp->detect_task, NULL);
+		return;
+	}
+
+	if (READ_ONCE(dp->notify_task) == current) {
+		WRITE_ONCE(dp->notify_task, NULL);
+		return;
+	}
+
+	if (!dp->oob_hpd)
+		return;
+
+	guard(mutex)(&dp->lock);
+
+	if (dp->hpd_stopped ||
+	    hpd_state == connector_status_unknown)
+		return;
+
+	dp->force_hpd = hpd_state;
+
+	if (!(dp->state & DPTX_STATE_SUSPENDED)) {
+		queue_delayed_work(system_freezable_wq, &dp->hpd_event_work, 0);
+		if (hpd_state == connector_status_connected)
+			queue_delayed_work(system_freezable_wq,
+					   &dp->hpd_irq_work,
+					   msecs_to_jiffies(20));
+	}
+}
+
+static void dptx_bridge_hpd_notify(struct drm_bridge *bridge,
+				   struct drm_connector *connector,
+				   enum drm_connector_status status)
+{
+	dptx_hpd_notify(bridge_to_dp(bridge), status);
+}
+
+static int dptx_bridge_get_modes(struct drm_bridge *bridge,
+				 struct drm_connector *connector)
+{
+	struct dptx_dev *dp = bridge_to_dp(bridge);
+	const struct drm_edid *edid;
+	struct drm_display_mode *mode;
+	int ret;
+
+	scoped_guard(mutex, &dp->lock) {
+		if (dp->released ||
+		    (dp->state & DPTX_STATE_SUSPENDED) ||
+		    !(dp->state & DPTX_STATE_INITIALIZED) ||
+		    !(dp->state & DPTX_STATE_CONNECTED))
+			return 0;
+
+		edid = drm_edid_read(connector);
+	}
+
+	if (edid) {
+		drm_edid_connector_update(connector, edid);
+		ret = drm_edid_connector_add_modes(connector);
+		drm_edid_free(edid);
+
+		return ret;
+	}
+
+	drm_edid_connector_update(connector, NULL);
+
+	scoped_guard(mutex, &dp->lock) {
+		if (dp->released || !(dp->state & DPTX_STATE_CONNECTED))
+			return 0;
+
+		mode = drm_dp_downstream_mode(connector->dev, dp->hw->dpcd,
+					      dp->hw->downstream_ports);
+	}
+	if (!mode)
+		return 0;
+
+	drm_mode_probed_add(connector, mode);
+
+	return 1;
+}
+
+static u32 dptx_pick_ppc(const struct drm_display_mode *mode,
+			 enum dp_pixelformat format)
+{
+	if (mode->clock > DPTX_MAX_FREQ &&
+	    mode->clock < DPTX_MAX_FREQ * 2 &&
+	    format != DP_PIXELFORMAT_YUV420)
+		return 2;
+
+	return 1;
+}
+
+static void dptx_adjust_mode(const struct drm_display_mode *mode,
+			     struct drm_display_mode *adjusted_mode)
+{
+	int diff = mode->htotal - mode->hsync_end;
+
+	if (diff < DPTX_MIN_H_BACKPORCH) {
+		adjusted_mode->htotal = mode->htotal +
+					DPTX_MIN_H_BACKPORCH - diff;
+		adjusted_mode->clock =
+			div_u64(mul_u32_u32(mode->clock, adjusted_mode->htotal),
+				mode->htotal);
+	}
+
+	adjusted_mode->flags &= ~(DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC);
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		adjusted_mode->flags |= DRM_MODE_FLAG_NVSYNC;
+	else
+		adjusted_mode->flags |= DRM_MODE_FLAG_PVSYNC;
+
+	adjusted_mode->flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NHSYNC);
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+		adjusted_mode->flags |= DRM_MODE_FLAG_NHSYNC;
+	else
+		adjusted_mode->flags |= DRM_MODE_FLAG_PHSYNC;
+}
+
+static enum drm_mode_status
+dptx_bridge_mode_valid(struct drm_bridge *bridge,
+		       const struct drm_display_info *info,
+		       const struct drm_display_mode *mode)
+{
+	struct dptx_dev *dp = bridge_to_dp(bridge);
+	struct drm_display_mode adjusted;
+	int max_lanes;
+	int max_rate;
+	u32 pixel_per_cycle;
+	int bpc = info->bpc ? info->bpc : 8;
+	int minbpp = DPTX_MIN_BPP;
+	bool vsc_supported;
+	bool can_420;
+
+	adjusted = *mode;
+	dptx_adjust_mode(mode, &adjusted);
+
+	scoped_guard(mutex, &dp->lock) {
+		max_lanes = dp->link_max_lanes;
+		max_rate = dp->link_max_rate;
+		vsc_supported = dp->hw->ops->vsc_supported(dp->hw);
+	}
+
+	pixel_per_cycle = dptx_pick_ppc(&adjusted, DP_PIXELFORMAT_RGB);
+
+	can_420 = drm_mode_is_420(info, mode) && bridge->ycbcr_420_allowed &&
+		  vsc_supported;
+
+	if (drm_mode_is_420_only(info, mode)) {
+		if (!can_420 || bpc < 8)
+			return MODE_NO_420;
+
+		minbpp = 8 * 3 / 2;
+		pixel_per_cycle = 1;
+	} else if (bpc >= 8 && can_420 && adjusted.clock <= DPTX_MAX_FREQ) {
+		minbpp = 8 * 3 / 2;
+	} else if (bpc >= 8 &&
+		   info->color_formats &
+		   BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422)) {
+		minbpp = 8 * 2;
+	}
+
+	if (pixel_per_cycle == 1 && adjusted.clock > DPTX_MAX_FREQ) {
+		drm_mode_debug_printmodeline(mode);
+		return MODE_CLOCK_HIGH;
+	}
+
+	if (adjusted.clock > DPTX_MAX_RATE(max_rate, max_lanes, minbpp)) {
+		drm_mode_debug_printmodeline(mode);
+		return MODE_CLOCK_HIGH;
+	}
+
+	return MODE_OK;
+}
+
+static bool dptx_bt2020_colorspace(const struct drm_connector_state *state)
+{
+	return state->colorspace >= DRM_MODE_COLORIMETRY_BT2020_CYCC &&
+	       state->colorspace <= DRM_MODE_COLORIMETRY_BT2020_YCC;
+}
+
+static int dptx_cal_bpc(struct drm_connector_state *connector_state,
+			int format, int bpc)
+{
+	struct drm_display_info *info =
+		&connector_state->connector->display_info;
+
+	if (dptx_bt2020_colorspace(connector_state))
+		bpc = min(bpc, 10);
+
+	if (info->bpc)
+		bpc = min_t(int, bpc, info->bpc);
+
+	if (connector_state->max_requested_bpc)
+		bpc = min(bpc, connector_state->max_requested_bpc);
+
+	if (bpc < 6)
+		return -EINVAL;
+
+	if (bpc < 8 && format != DRM_OUTPUT_COLOR_FORMAT_RGB444)
+		return -EINVAL;
+
+	return bpc;
+}
+
+static int dptx_cal_bpp(struct dptx_dev *dp, int bpc, int format)
+{
+	int bpp = bpc * 3;
+
+	switch (format) {
+	case DRM_OUTPUT_COLOR_FORMAT_RGB444:
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
+		bpp = bpc * 3;
+		break;
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
+		bpp = bpc * 2;
+		break;
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
+		bpp = bpc * 3 / 2;
+		break;
+	default:
+		dev_warn(dp->dev, "invalid color format %d\n", format);
+	}
+	return bpp;
+}
+
+static int compute_available_clock_rate(struct dptx_dev *dp,
+					struct drm_connector_state *conn_state,
+					int suggest_bpc, int clock,
+					int color_format, int *rt_bpc,
+					int *rt_bpp)
+{
+	int max_lanes = dp->link_max_lanes;
+	int max_rate = dp->link_max_rate;
+	int rate;
+	int bpc;
+	int bpp;
+
+	bpc = dptx_cal_bpc(conn_state, color_format, suggest_bpc);
+	if (bpc < 0)
+		return bpc;
+	bpp = dptx_cal_bpp(dp, bpc, color_format);
+	rate = DPTX_MAX_RATE(max_rate, max_lanes, bpp);
+
+	if (clock <= rate) {
+		*rt_bpc = bpc;
+		*rt_bpp = bpp;
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/*
+ * @mode still has the CEA timings and sync flags. adjusted_mode has had
+ * its polarities inverted, so it no longer matches a VIC.
+ */
+static bool dptx_format_ok(struct dptx_dev *dp,
+			   const struct drm_display_info *info,
+			   const struct drm_display_mode *mode,
+			   const struct drm_display_mode *adjusted_mode,
+			   int info_formats, int format)
+{
+	if (format == DRM_OUTPUT_COLOR_FORMAT_YCBCR420) {
+		if (!dp->hw->ops->vsc_supported(dp->hw))
+			return false;
+
+		/*
+		 * Y420VDB sets the sink-wide 420 bit for every mode. This
+		 * VIC has to be 420-only or 420-also. 420 is one pixel
+		 * per cycle.
+		 */
+		if (!drm_mode_is_420(info, mode))
+			return false;
+
+		return adjusted_mode->clock <= DPTX_MAX_FREQ;
+	}
+
+	if (drm_mode_is_420_only(info, mode))
+		return false;
+
+	if (adjusted_mode->clock >= DPTX_MAX_FREQ * 2)
+		return false;
+
+	return info_formats & BIT(format);
+}
+
+static int dptx_pick_format_bpc(struct dptx_dev *dp,
+				struct drm_connector_state *conn_state,
+				const struct drm_display_mode *mode,
+				struct drm_display_mode *adjusted_mode,
+				int info_formats, int suggest_bpc,
+				int *color_format, int *bpc, int *bpp)
+{
+	struct drm_display_info *info =
+		&conn_state->connector->display_info;
+	int curr_bpc;
+	int format;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fmt_prio); i++) {
+		format = fmt_prio[i].format;
+		curr_bpc = fmt_prio[i].bpc ? fmt_prio[i].bpc : suggest_bpc;
+
+		if (!dptx_format_ok(dp, info, mode, adjusted_mode,
+				    info_formats, format))
+			continue;
+
+		/*
+		 * First entry (RGB): prefer 10bit before falling back to
+		 * suggest_bpc, and step down to 8bit before giving up on RGB.
+		 * BT.2020 also tries 10 first when suggest_bpc is lower.
+		 * The DPU always outputs RGB, so a lower RGB depth is still
+		 * preferable to a converted YUV format.
+		 */
+		if (i == 0) {
+			if (dptx_bt2020_colorspace(conn_state) &&
+			    suggest_bpc < 10 &&
+			    !compute_available_clock_rate(dp, conn_state, 10,
+							  adjusted_mode->clock,
+							  format, bpc, bpp)) {
+				if (color_format)
+					*color_format = format;
+				return 0;
+			}
+
+			if (suggest_bpc > 10 &&
+			    !compute_available_clock_rate(dp, conn_state, 10,
+							  adjusted_mode->clock,
+							  format, bpc, bpp)) {
+				if (color_format)
+					*color_format = format;
+				return 0;
+			}
+
+			if (!compute_available_clock_rate(dp, conn_state,
+							  suggest_bpc,
+							  adjusted_mode->clock,
+							  format, bpc, bpp)) {
+				if (color_format)
+					*color_format = format;
+				return 0;
+			}
+
+			if (suggest_bpc > 8 &&
+			    !compute_available_clock_rate(dp, conn_state, 8,
+							  adjusted_mode->clock,
+							  format, bpc, bpp)) {
+				if (color_format)
+					*color_format = format;
+				return 0;
+			}
+
+			continue;
+		}
+
+		if (!compute_available_clock_rate(dp, conn_state, curr_bpc,
+						  adjusted_mode->clock,
+						  format, bpc, bpp)) {
+			if (color_format)
+				*color_format = format;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static enum dp_pixelformat dptx_drm_format_to_dp(int color_format)
+{
+	switch (color_format) {
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR444:
+		return DP_PIXELFORMAT_YUV444;
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR422:
+		return DP_PIXELFORMAT_YUV422;
+	case DRM_OUTPUT_COLOR_FORMAT_YCBCR420:
+		return DP_PIXELFORMAT_YUV420;
+	default:
+		return DP_PIXELFORMAT_RGB;
+	}
+}
+
+static int dptx_pick_link_rate(struct dptx_dev *dp,
+			       struct drm_display_mode *adjusted_mode,
+			       int bpp)
+{
+	int max_rate = dp->link_max_rate;
+	int max_lanes = dp->link_max_lanes;
+	int link_rate = max_rate;
+	int rate;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(dp_common_link_bw); i++) {
+		rate = drm_dp_bw_code_to_link_rate(dp_common_link_bw[i]);
+		if (rate > max_rate)
+			break;
+		if (adjusted_mode->clock <= DPTX_MAX_RATE(rate, max_lanes, bpp)) {
+			link_rate = rate;
+			break;
+		}
+	}
+
+	return link_rate;
+}
+
+static int dptx_pick_config(struct dptx_dev *dp,
+			    struct drm_connector_state *conn_state,
+			    const struct drm_display_mode *mode,
+			    struct drm_display_mode *adjusted_mode,
+			    int *color_format, int *bpc, int *bpp)
+{
+	struct drm_display_info *info = &conn_state->connector->display_info;
+	u32 color_formats = info->color_formats;
+	int suggest_bpc;
+
+	color_formats |= BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
+
+	/* bpc 0 is unspecified. Start at 8, and never below 6. */
+	suggest_bpc = info->bpc ? info->bpc : 8;
+	if (suggest_bpc < 6)
+		suggest_bpc = 6;
+
+	return dptx_pick_format_bpc(dp, conn_state, mode, adjusted_mode,
+				      color_formats, suggest_bpc,
+				      color_format, bpc, bpp);
+}
+
+static int dptx_bridge_mode_set(struct dptx_dev *dp,
+				struct drm_crtc_state *crtc_state,
+				struct drm_connector_state *conn_state)
+{
+	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+	int color_format;
+	int link_rate;
+	int bw_code;
+	int bpc;
+	int bpp;
+	int ret;
+
+	ret = dp->ops->detect(dp);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&dp->lock);
+
+	ret = dptx_pick_config(dp, conn_state, &crtc_state->mode,
+			       adjusted_mode, &color_format, &bpc, &bpp);
+	if (ret)
+		return ret;
+
+	dp->config.format = dptx_drm_format_to_dp(color_format);
+	dp->config.colorspace = conn_state->colorspace;
+	dp->config.content_type = conn_state->content_type;
+	dp->config.bpc = bpc;
+	dp->config.bpp = bpp;
+	drm_mode_copy(&dp->adjusted_mode, adjusted_mode);
+	dp->pixel_per_cycle = dptx_pick_ppc(adjusted_mode, dp->config.format);
+
+	link_rate = dptx_pick_link_rate(dp, adjusted_mode, bpp);
+	bw_code = drm_dp_link_rate_to_bw_code(link_rate);
+
+	ret = dp->ops->mode_configure(dp, adjusted_mode->clock, bw_code,
+				      bpp, false);
+	if (ret)
+		return ret;
+
+	dev_dbg(dp->dev,
+		"%dx%d@%d fmt=%d bpc=%d bpp=%d link=%u lanes=%u ppc=%u\n",
+		adjusted_mode->hdisplay, adjusted_mode->vdisplay,
+		drm_mode_vrefresh(adjusted_mode), dp->config.format,
+		bpc, bpp, bw_code, dp->mode.lane_cnt,
+		dp->pixel_per_cycle);
+
+	return 0;
+}
+
+static int dptx_bridge_atomic_check(struct drm_bridge *bridge,
+				    struct drm_bridge_state *bridge_state,
+				    struct drm_crtc_state *crtc_state,
+				    struct drm_connector_state *conn_state)
+{
+	struct dptx_dev *dp = bridge_to_dp(bridge);
+	int bpc;
+	int bpp;
+	int ret;
+	bool vsc_supported;
+
+	if (!conn_state->crtc)
+		return 0;
+
+	dptx_adjust_mode(&crtc_state->mode, &crtc_state->adjusted_mode);
+
+	scoped_guard(mutex, &dp->lock) {
+		ret = dptx_pick_config(dp, conn_state, &crtc_state->mode,
+				       &crtc_state->adjusted_mode,
+				       NULL, &bpc, &bpp);
+		vsc_supported = dp->hw->ops->vsc_supported(dp->hw);
+	}
+	if (ret)
+		return ret;
+
+	if (vsc_supported) {
+		const struct drm_connector_state *old_conn_state;
+
+		old_conn_state =
+			drm_atomic_get_old_connector_state(bridge_state->base.state,
+							   conn_state->connector);
+		if (old_conn_state &&
+		    old_conn_state->colorspace != conn_state->colorspace) {
+			crtc_state->mode_changed = true;
+
+			ret = drm_atomic_add_affected_planes(bridge_state->base.state,
+							     crtc_state->crtc);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static void
+dptx_bridge_atomic_enable(struct drm_bridge *bridge,
+			  struct drm_atomic_commit *state)
+{
+	struct dptx_dev *dp = bridge_to_dp(bridge);
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
+	int ret;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state,
+							     bridge->encoder);
+	if (!connector)
+		return;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (!conn_state || !conn_state->crtc)
+		return;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	if (!crtc_state)
+		return;
+
+	ret = dp->ops->prepare(dp);
+	if (ret) {
+		if (ret != -ENODEV)
+			dev_err(dp->dev, "failed to prepare DP output: %d\n",
+				ret);
+		return;
+	}
+
+	ret = dptx_bridge_mode_set(dp, crtc_state, conn_state);
+	if (ret) {
+		dev_err(dp->dev, "failed to set DP mode: %d\n", ret);
+		goto err_unprepare;
+	}
+
+	ret = dp->ops->encoder_enable(dp, 0, true);
+	if (ret) {
+		dev_err(dp->dev, "failed to enable DP output: %d\n", ret);
+		goto err_unprepare;
+	}
+
+	return;
+
+err_unprepare:
+	mutex_lock(&dp->lock);
+	dp->ops->unprepare(dp);
+	mutex_unlock(&dp->lock);
+}
+
+static void
+dptx_bridge_atomic_disable(struct drm_bridge *bridge,
+			   struct drm_atomic_commit *state)
+{
+	struct dptx_dev *dp = bridge_to_dp(bridge);
+
+	dp->ops->encoder_enable(dp, 0, false);
+}
+
+static int dptx_bridge_attach(struct drm_bridge *bridge,
+			      struct drm_encoder *encoder,
+			      enum drm_bridge_attach_flags flags)
+{
+	struct dptx_dev *dp = bridge_to_dp(bridge);
+	int ret;
+
+	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
+		return -EINVAL;
+
+	scoped_guard(mutex, &dp->lock) {
+		if (dp->released) {
+			ret = -ENODEV;
+		} else {
+			ret = dp->hw->ops->aux_register(dp->hw, bridge->dev);
+			if (!ret) {
+				dp->link = device_link_add(bridge->dev->dev,
+							   dp->dev,
+							   DL_FLAG_STATELESS);
+				if (dp->link) {
+					WRITE_ONCE(dp->hpd_stopped, false);
+					dp->attached = true;
+				} else {
+					dp->hw->ops->aux_unregister(dp->hw);
+					ret = -EINVAL;
+				}
+			}
+		}
+	}
+	if (ret)
+		return ret;
+
+	/* The bridge may have been attached long after the sink was plugged. */
+	dp->ops->replay_deferred_hotplug(dp);
+
+	return 0;
+}
+
+static void dptx_bridge_detach(struct drm_bridge *bridge)
+{
+	struct dptx_dev *dp = bridge_to_dp(bridge);
+	struct device_link *link;
+
+	/* Stop workers before the connector goes away. */
+	dp->ops->quiesce_hpd(dp);
+
+	scoped_guard(mutex, &dp->lock) {
+		dp->attached = false;
+
+		if (!dp->released)
+			dp->hw->ops->aux_unregister(dp->hw);
+
+		link = dp->link;
+		dp->link = NULL;
+	}
+
+	if (link)
+		device_link_del(link);
+}
+
+static void dptx_bridge_destroy(struct drm_bridge *bridge)
+{
+	struct dptx_dev *dp = bridge_to_dp(bridge);
+
+	mutex_destroy(&dp->lock);
+
+	if (!dp->hw)
+		return;
+
+	kfree(dp->hw->aux.name);
+	kfree(dp->hw);
+}
+
+static const struct drm_bridge_funcs dptx_bridge_funcs = {
+	.attach = dptx_bridge_attach,
+	.detach = dptx_bridge_detach,
+	.destroy = dptx_bridge_destroy,
+	.detect = dptx_bridge_detect,
+	.get_modes = dptx_bridge_get_modes,
+	.mode_valid = dptx_bridge_mode_valid,
+	.hpd_notify = dptx_bridge_hpd_notify,
+	.atomic_check = dptx_bridge_atomic_check,
+	.atomic_enable = dptx_bridge_atomic_enable,
+	.atomic_disable = dptx_bridge_atomic_disable,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+};
+
+struct dptx_dev *dptx_bridge_alloc(struct device *dev)
+{
+	return devm_drm_bridge_alloc(dev, struct dptx_dev, bridge,
+				     &dptx_bridge_funcs);
+}
diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_drm.h b/drivers/gpu/drm/bridge/trilinear/dptx_drm.h
new file mode 100644
index 000000000000..fc30a7ce6e99
--- /dev/null
+++ b/drivers/gpu/drm/bridge/trilinear/dptx_drm.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * DisplayPort DRM helpers
+ *
+ * Copyright 2026 Cix Technology Group Co., Ltd.
+ */
+
+#ifndef DPTX_DRM_H
+#define DPTX_DRM_H
+
+#include <linux/device.h>
+
+#include "dptx.h"
+
+struct dptx_dev *dptx_bridge_alloc(struct device *dev);
+
+#endif /* DPTX_DRM_H */
diff --git a/include/drm/bridge/trilinear_dp.h b/include/drm/bridge/trilinear_dp.h
new file mode 100644
index 000000000000..c65ebd103f47
--- /dev/null
+++ b/include/drm/bridge/trilinear_dp.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * DisplayPort transmitter bridge driver
+ *
+ * Copyright (C) 2026 Trilinear Technologies
+ * Copyright 2026 Cix Technology Group Co., Ltd.
+ */
+
+#ifndef DRM_BRIDGE_TRILINEAR_DP_H
+#define DRM_BRIDGE_TRILINEAR_DP_H
+
+#include <linux/types.h>
+
+#include <drm/display/drm_dp.h>
+
+struct device;
+struct dptx_dev;
+
+/**
+ * struct dptx_plat_data - platform glue for the DPTX bridge
+ * @adapter_config: programs the SoC side pixel format and pixel-per-clock
+ *                  mode for a stream; @stream_id is the SST stream index,
+ *                  @format the pixel format carried on the link and @ppc2
+ *                  whether the stream runs at two pixels per clock
+ * @oob_hpd: HPD is reported out of band, for example through a USB-C port
+ *           controller, instead of being wired to the transmitter
+ * @max_bw_code: highest DP link bandwidth code (DP_LINK_BW_*) the platform's
+ *               DP output supports
+ *
+ * The bridge driver owns the DP protocol and the DRM bridge; the platform
+ * integration fills in the parts that are wired differently between SoCs.
+ */
+struct dptx_plat_data {
+	void (*adapter_config)(void *priv, unsigned int stream_id,
+			       enum dp_pixelformat format, bool ppc2);
+	bool oob_hpd;
+	u8 max_bw_code;
+};
+
+/**
+ * trilinear_dptx_probe - allocate and register a DPTX bridge
+ * @dev: device backing the transmitter
+ * @soc_data: platform glue for this transmitter
+ * @priv: opaque context passed back to &dptx_plat_data.adapter_config
+ *
+ * Return: the DPTX device on success, or an ERR_PTR() on failure.
+ */
+struct dptx_dev *trilinear_dptx_probe(struct device *dev,
+				      const struct dptx_plat_data *soc_data,
+				      void *priv);
+
+/**
+ * trilinear_dptx_suspend - prepare a DPTX bridge for system sleep
+ * @dp: DPTX device returned by trilinear_dptx_probe()
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+int trilinear_dptx_suspend(struct dptx_dev *dp);
+
+/**
+ * trilinear_dptx_resume - restore a DPTX bridge after system sleep
+ * @dp: DPTX device returned by trilinear_dptx_probe()
+ *
+ * Return: 0 on success, or a negative error code.
+ */
+int trilinear_dptx_resume(struct dptx_dev *dp);
+
+/**
+ * trilinear_dptx_shutdown - stop a DPTX bridge on system shutdown
+ * @dp: DPTX device returned by trilinear_dptx_probe()
+ */
+void trilinear_dptx_shutdown(struct dptx_dev *dp);
+
+#endif /* DRM_BRIDGE_TRILINEAR_DP_H */
-- 
2.25.1

