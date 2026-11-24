Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787F606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A9010F52B;
	Tue, 24 Nov 2026 12:01:24 +0000 (UTC)
Received: from TYDPR03CU002.outbound.protection.outlook.com
 (mail-japaneastazon11023075.outbound.protection.outlook.com [52.101.127.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7E3310F52B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:01:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8jXoxTSKV4uGl4CrPB6yAzQy2i4zBnYD+oq/NYXOsNhlDKx5C9bm5dTkohPRGwYCEdd+/wU12IRSTCn+4O2IwmqarR+73M8hyaSHXO17DFd0w0m9yqWUftoMIgihH6oaGcgy6K/Rvn+HD1v8RZ9W7SpnONOou1VLZSk4uVXHTUvbf9M8NuN7x2PjDe1j6ZFkhWbklLQSypD8qCaNKH3BmlbbFFoskqwKoglnuHaC9tV9dB9LsR8OBngswmq+n0ksNUs6rimV2QKqHaQrEFJEA1E/emza2pE7ODDKi4J1+360kMv45ysMcIdhHOhgqcYSAXcGN/47eGt5xzLHCP0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bWq7uEINQlyFWW7M0vGrGymqGTiEvwNXM7Pva8PVY6M=;
 b=NhFaTBqTm6bq4LgmcxxUdGQFwHbuE6csGdrJNxHPdoF0zCfdWQ1WxcLP8f3vtnQKF9gp/SBXGwAN/GoxWnMCuNqaWkMjrULaxttDUeEjgA3jfaXovpugAsEFtEjeK9zX18sBhw73M6eFpBeCSrkeUSkVzCNAMhcLnk0TtCF9YMbAOxMMzueKB6VES+hCNqNfhMtAr7lEJcgjGfl8xFpEKYIGYridgw+yqZTMEvW+2eoov4Q1bR8xB4Jc6RiEzezoQa8rDzy0sE3azCL4YL0oYc9U5nQ6JRnAFTAtESbIT5IMwnOS56pdHdnRn9/d8Y6xSODpZsK5ELHS5zwFf7//tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from KUZPR02CA0003.apcprd02.prod.outlook.com (2603:1096:d10:33::15)
 by KL1PR06MB6555.apcprd06.prod.outlook.com (2603:1096:820:f1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Tue, 24 Nov
 2026 12:01:17 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:d10:33:cafe::48) by KUZPR02CA0003.outlook.office365.com
 (2603:1096:d10:33::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Tue,
 24 Nov 2026 12:01:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 12:01:15 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id D5C3D40920E2;
 Tue, 24 Nov 2026 20:01:14 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
Subject: [PATCH v3 3/5] drm/bridge: trilinear: add the DPTX DRM bridge
Date: Tue, 24 Nov 2026 20:01:12 +0800
Message-Id: <20261124120114.3273161-4-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
References: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|KL1PR06MB6555:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 15617cf6-8853-4d84-0ced-08df4a22a49b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|42112799006|36860700016|1800799024|82310400026|7416014|376014|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261026140227099003|261026121527099003|261022105027099003|5023799004|56012099006|10067099003|261022075727099003|18092099006|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: VOP3/tv2cjAy0pOcBnMac0mdjde+xrHsdzVUphvpqVh4rGvhxVL+BuujW6XFrZBF3i9JBeBPoAyv0TZ5wZvbYFSy4GGhGJ5LgjObVWKRVddGoOCt5Sed654PbfozaWZE2lpYQ4JKjIKZPZRNAdSwQBjuLxhvutmxM/VwXN9HFYs63GVPvmH0jTXUGotWJL0X6dvjhXRSvMBKn6hm3mQz0Ju6jcnvDCAyigP7LwWcrcJ9CrFsTR25kimj+j2+5uWYNFv3cxNZZ83vDdgTWExTpvfYwbSZNk8fa4gT0nep9cRSQkq28Sxk84stId2YFkrwnbpDQ+1QniaiFA4o5fmxDUfQMMaEG7QFuhTZuOWt/Nzp5d9NnBpw1d9hNaEYyidUca77jYEF6+4L/BY1zeijDQD5VXZN6cmrRUntOvuvu/2djExFaeIAomQGzMfnxm4nQ//b3rKY/6HmmWu93NOKBXQf7BkDPt5ggMMhlgM7e6Q1/s7tVufLlnVgyXN+5U8SVq8y3WpvWugmIREiuWk40mVubaoK1q7zun0gDemOrdHkpbegSX9R6H1IWWBsM9r8ZdNLtd9LkBxx7vp5QEaT0Or7u8xSSMmM/Ex/SBWSLPuPhk1wIkDhoLRhpDzwawwvLnr0A9k3tcy401tIMFhS7Ty7aIInCXgjBrRGH4YlQx/oRe8gTyIvH4wnq48tu8DEyjfEuAhFElbSim4SviUcOg==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(42112799006)(36860700016)(1800799024)(82310400026)(7416014)(376014)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261026140227099003)(261026121527099003)(261022105027099003)(5023799004)(56012099006)(10067099003)(261022075727099003)(18092099006)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9DYszmxZ/8mbd6L1xkLwlzqh4FNo1JjLZFLAL8y+uoH0Dt+YV2mWfSE+DCXBeg17bl5KxiZpw4oRCETXm3T5fJbHTVYv/gdNVsg/fPumguFvkbvwS2FTsd2hRMezMepRaSRT/V+FOhSRtjH7lzmAZdmHygs1P/BZLgTyUzb+1r31pOTPu8g3zfMciINtSaQTYXIMrZZuFKYL/d4KJWypyn1NkbqeVOAm8PP80N+YTogs0m9BgjkcJd02MdsLTzhMEK14XtxEOL9KiWghvfDJlUiYahmqVvmO2he2+53oRs4CHgxHg4vDd7kpk8KU1eWOEKHa9gdg/JkFM8DMHrqeW3T4vZ+XrLuXtrcgIe0xGZTgxcIOa6+r00l9Kzg9ke+wi5x0e8AyA6/SSChC1HB+U8YfEMlyedQc03rgFh2ZAxrqYJ6WX30VuQzDd1kJtAbt
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:01:15.8540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15617cf6-8853-4d84-0ced-08df4a22a49b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6555
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

Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
---
 drivers/gpu/drm/bridge/trilinear/dptx_drm.c | 623 ++++++++++++++++++++
 drivers/gpu/drm/bridge/trilinear/dptx_drm.h |  17 +
 2 files changed, 640 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_drm.c
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_drm.h

diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_drm.c b/drivers/gpu/drm/bridge/trilinear/dptx_drm.c
new file mode 100644
index 000000000000..fde34bac1230
--- /dev/null
+++ b/drivers/gpu/drm/bridge/trilinear/dptx_drm.c
@@ -0,0 +1,623 @@
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
+
+	return dp->ops->detect_status(dp);
+}
+
+static void dptx_hpd_notify(struct dptx_dev *dp,
+			    enum drm_connector_status hpd_state)
+{
+	dp->ops->lock(dp);
+	if (READ_ONCE(dp->hpd_stopped)) {
+		dp->ops->unlock(dp);
+		return;
+	}
+
+	if (dp->state & DPTX_STATE_SUSPENDED) {
+		dp->force_hpd = connector_status_disconnected;
+		dp->ops->unlock(dp);
+		return;
+	}
+
+	if (hpd_state != dp->status) {
+		dp->force_hpd = hpd_state;
+		schedule_delayed_work(&dp->hpd_event_work, 0);
+
+		if (hpd_state == connector_status_connected)
+			schedule_delayed_work(&dp->sw_hpd_irq_work, 1);
+	}
+	dp->ops->unlock(dp);
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
+	edid = drm_edid_read(connector);
+	if (!edid) {
+		drm_edid_connector_update(connector, NULL);
+
+		mode = drm_dp_downstream_mode(connector->dev, dp->hw->dpcd,
+					      dp->hw->downstream_ports);
+		if (!mode)
+			return 0;
+
+		drm_mode_probed_add(connector, mode);
+		return 1;
+	}
+
+	drm_edid_connector_update(connector, edid);
+	ret = drm_edid_connector_add_modes(connector);
+	drm_edid_free(edid);
+
+	return ret;
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
+static enum drm_mode_status
+dptx_bridge_mode_valid(struct drm_bridge *bridge,
+		       const struct drm_display_info *info,
+		       const struct drm_display_mode *mode)
+{
+	struct dptx_dev *dp = bridge_to_dp(bridge);
+	int max_lanes = dp->link_max_lanes;
+	int max_rate = dp->link_max_rate;
+	int clock = mode->clock;
+	u32 pixel_per_cycle = dptx_pick_ppc(mode, DP_PIXELFORMAT_RGB);
+	int minbpp = DPTX_MIN_BPP;
+
+	if (drm_mode_is_420_only(info, mode)) {
+		if (!bridge->ycbcr_420_allowed ||
+		    !dp->hw->ops->vsc_supported(dp->hw))
+			return MODE_NO_420;
+
+		minbpp = 8 * 3 / 2;
+		pixel_per_cycle = 1;
+	}
+
+	if (pixel_per_cycle == 1 && clock > DPTX_MAX_FREQ) {
+		drm_mode_debug_printmodeline(mode);
+		return MODE_CLOCK_HIGH;
+	}
+
+	if (clock > DPTX_MAX_RATE(max_rate, max_lanes, minbpp)) {
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
+static int dptx_cal_bpc(struct drm_connector_state *connector_state, int bpc)
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
+static void dptx_adjust_mode(struct drm_display_mode *mode,
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
+	/* The sync polarities are inverted with respect to the source mode. */
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
+		adjusted_mode->flags &= ~DRM_MODE_FLAG_PVSYNC;
+	else
+		adjusted_mode->flags |= DRM_MODE_FLAG_PVSYNC;
+
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
+		adjusted_mode->flags &= ~DRM_MODE_FLAG_PHSYNC;
+	else
+		adjusted_mode->flags |= DRM_MODE_FLAG_PHSYNC;
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
+	bpc = dptx_cal_bpc(conn_state, suggest_bpc);
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
+	dp->ops->lock(dp);
+
+	ret = dptx_pick_config(dp, conn_state, &crtc_state->mode,
+			       adjusted_mode, &color_format, &bpc, &bpp);
+	if (ret)
+		goto out;
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
+		goto out;
+
+	dev_dbg(dp->dev,
+		"%dx%d@%d fmt=%d bpc=%d bpp=%d link=%u lanes=%u ppc=%u\n",
+		adjusted_mode->hdisplay, adjusted_mode->vdisplay,
+		drm_mode_vrefresh(adjusted_mode), dp->config.format,
+		bpc, bpp, bw_code, dp->mode.lane_cnt,
+		dp->pixel_per_cycle);
+out:
+	dp->ops->unlock(dp);
+	return ret;
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
+
+	if (!conn_state->crtc)
+		return 0;
+
+	dptx_adjust_mode(&crtc_state->mode, &crtc_state->adjusted_mode);
+
+	ret = dptx_pick_config(dp, conn_state, &crtc_state->mode,
+			       &crtc_state->adjusted_mode,
+			       NULL, &bpc, &bpp);
+	if (ret)
+		return ret;
+
+	if (dp->hw->ops->vsc_supported(dp->hw)) {
+		const struct drm_connector_state *old_conn_state;
+
+		old_conn_state =
+			drm_atomic_get_old_connector_state(bridge_state->base.state,
+							   conn_state->connector);
+		if (old_conn_state &&
+		    old_conn_state->colorspace != conn_state->colorspace)
+			crtc_state->mode_changed = true;
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
+	dp->ops->lock(dp);
+	dp->ops->unprepare(dp);
+	dp->ops->unlock(dp);
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
+	WRITE_ONCE(dp->hpd_stopped, false);
+
+	ret = dp->hw->ops->aux_register(dp->hw, bridge->dev);
+	if (ret)
+		return ret;
+
+	WRITE_ONCE(dp->attached, true);
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
+
+	/* Stop workers before the connector goes away. */
+	dp->ops->quiesce_hpd(dp);
+
+	WRITE_ONCE(dp->attached, false);
+
+	dp->hw->ops->aux_unregister(dp->hw);
+}
+
+static const struct drm_bridge_funcs dptx_bridge_funcs = {
+	.attach = dptx_bridge_attach,
+	.detach = dptx_bridge_detach,
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
-- 
2.25.1

