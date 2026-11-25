Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15338606A334
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A6110EF6E;
	Wed, 25 Nov 2026 03:32:55 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023084.outbound.protection.outlook.com
 [40.107.44.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB70210E868
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhlYhD+UtYwhIY8CnbxrOLpWVBroKi9DjG2B/5AEjZzmY21O9OY2m6v+uxBMxurF+iv0ZMYW6kcenHUcqL9R6q8QTGBqiP5J7caujAH++YjRr89sk/epWlvlgrmGNbFrpVZUUh2JqKFo35BbbFHNWxwDoRKKQNprsVHgvl2lT4kwmB5Jv/RBXKhBIj84Brs0EkB30PgrJJcbz8moN8hQecoACHEMf1Bv08jP7EEcnXdxZjQrmP2B2UtLbS3MaX6LN26VynsO2I1F48IIJkKI0nmdUuagzgfCt4PKNy3JKhLmBsxVIFiUi7p3TXKFTnofFeXzancHpLQMEiKUOn18dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKUcfW4N4RsRSzniNphpYaus548Q520fm63ONthK3Pk=;
 b=wcnEM++FsBH3LtPcNTYnE7wxEjGZiY//hH7UsQNhnY4Pwf4X+X3swQYwPm9KUhGFiwFUNtxFxHOaoNm5oH/e8sCUAOQLfEgfOhpF9S+/2sIs5L/FREUzywxxGVIO6b5DCeifgD3epBwxnnAIJaF16UsIUDfOZkfnlXxrl1zczzxGFoLYeRvTsEyeUPkW6eNJl+pN67M4CM7NMHNZfokMeKLYJcbNDBsd+E0gXjrLtL1wVimsVMcbt/41Y75uGjK+uf3NmSDtJB4HFIZj1hR3C52RAGMxzcvQMKAc5jWEs6Q4F/Dazgbh2oQZaI7KmUEKUQ6EqdIzf/bLWpstXTp9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from KU0P306CA0076.MYSP306.PROD.OUTLOOK.COM (2603:1096:d10:2b::7) by
 TYZPR06MB5273.apcprd06.prod.outlook.com (2603:1096:400:1fe::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3; Wed, 25 Nov 2026 03:32:42 +0000
Received: from SG1PEPF000082E6.apcprd02.prod.outlook.com
 (2603:1096:d10:2b:cafe::1f) by KU0P306CA0076.outlook.office365.com
 (2603:1096:d10:2b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 03:32:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG1PEPF000082E6.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 03:32:39 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3441040920E1;
 Wed, 25 Nov 2026 11:32:39 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
Subject: [PATCH v4 3/5] drm/bridge: trilinear: add the DPTX DRM bridge
Date: Wed, 25 Nov 2026 11:32:36 +0800
Message-Id: <20261125033238.3436046-4-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261125033238.3436046-1-Luo.Liu@cixtech.com>
References: <20261125033238.3436046-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E6:EE_|TYZPR06MB5273:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aff24d51-a060-4910-e6ae-08df4aa4c21b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|376014|42112799006|36860700016|23010399003|261009223027099003|6133799003|18002099003|18092099006|22082099003|3023799007|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|56012099006|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info: /WFI+3Q3opqe1tv5d181Bmq4LHYX/UmpOylRAXora0MTR41XbS1ouAsNihJPm3s47Y4MJIwY8NQ1YymKqe700zJkL17lYiNWzDcVtwnHLQBRi2H2gNcwTgD8K3tHynv3dMeRFDn1AlmDKrTpaqB1WsyYEzsal3VWjJg7zVl5UK1Q6Z7JrwmyLH7ZJ5MJN0fg4ZY/qGlEcwdXPTi2RNdPwUjFRdlwUhKUcQALhIdYNjido7XDiPZ/22PYqomOkqhb2ErpYEMga8nN/clvu0YOr1SjUl5dogYQ00mCjkJ1w95WDlT8OPd1Wdknik8atWwVkpaRNQKlKmijwxAOx8gWLTHNmyZxQPPBF9HZS4ApKWTvU9a+/omEZUjWQi2GsyQFhCbLpUq3FGEDX1oSDSoDxK+neO1Rm3199YFVf/GFl391nMtU7q+OtQpJFAwB9ukOk7c+Y3Am4JyyRmUpr1Jfa/OLtZuVsMcP1mbNt8wOuG4b/Xv8wGsB6Ge13uMqEmQgw8SekBtKtJ4ZBYGwOlkAHF4pya6Xu5GRyxNMC0+5rtEqsd65ZBqoc4ye+lI4OpUbD4aJZ8yGe7PBJvoa1IFmk1He9VBmZv0jIEt59uggiLPUPqFbH3JdfBz3rvumBy3vTLVJ5kWUt2CCpv8/rbqYVsW3ye1A4S6Uzq2u8jjS7gO1xA57l9KXAamVCPjkawmWHaEe1DADQomsjcAHgyZeYw==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(42112799006)(36860700016)(23010399003)(261009223027099003)(6133799003)(18002099003)(18092099006)(22082099003)(3023799007)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(56012099006)(5023799004)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YnXjXsW/YYs0Foy5lEeFdBGIK2kIlPsqNiTrKZOz48a5jpzHLuRNfoCVWS1I1Vife/Mf6GH/JvcqXFE1toUFYGiBf+JVhYwUAsoVOvNk3r4kltMCIh20TnmqCdWtJu+SB8eZ5qtS7oODfjTdurv1vG9FmwcQL3TNKnXoWzn91EKJFUJa0Bu4FBpkdgYG/rjo1e0UZMKjLpKDYQS0RwkmpMHpxaSgTuy+t03J4Zyos9UFO6oKYnKNRq+O8ssTMdcmZOW1A5vap2TT5T944iOyMxSyqWAS2Xt65Vo8S+rEj1yxvR+VvfolaXb1wQXc2eEZmJyUmjcIEXZiOhfxk6Jhxm+honArF5boQS56MM03gjxfew8QJAClgYNAFD3vXvb5KY/ul8dvdzt8sTMLy2sp6aXv9FtUjHMrJhvOS3/5gAXW4KpubvHmFt0OA/HDuUCh
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 03:32:39.9288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aff24d51-a060-4910-e6ae-08df4aa4c21b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5273
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
 drivers/gpu/drm/bridge/trilinear/dptx_drm.c | 664 ++++++++++++++++++++
 drivers/gpu/drm/bridge/trilinear/dptx_drm.h |  17 +
 2 files changed, 681 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_drm.c
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_drm.h

diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_drm.c b/drivers/gpu/drm/bridge/trilinear/dptx_drm.c
new file mode 100644
index 000000000000..099dd53eb2d4
--- /dev/null
+++ b/drivers/gpu/drm/bridge/trilinear/dptx_drm.c
@@ -0,0 +1,664 @@
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
+		dp->force_hpd = hpd_state;
+		dp->ops->unlock(dp);
+		return;
+	}
+
+	if (hpd_state != dp->status) {
+		dp->force_hpd = hpd_state;
+		queue_delayed_work(system_freezable_wq, &dp->hpd_event_work, 0);
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
+	dp->ops->lock(dp);
+	if (dp->state & DPTX_STATE_SUSPENDED) {
+		dp->ops->unlock(dp);
+		return 0;
+	}
+
+	edid = drm_edid_read(connector);
+	dp->ops->unlock(dp);
+
+	if (!edid) {
+		drm_edid_connector_update(connector, NULL);
+
+		dp->ops->lock(dp);
+		mode = drm_dp_downstream_mode(connector->dev, dp->hw->dpcd,
+					      dp->hw->downstream_ports);
+		dp->ops->unlock(dp);
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
+	int minbpp = DPTX_MIN_BPP;
+	bool vsc_supported;
+	bool can_420;
+
+	adjusted = *mode;
+	dptx_adjust_mode(mode, &adjusted);
+
+	dp->ops->lock(dp);
+	max_lanes = dp->link_max_lanes;
+	max_rate = dp->link_max_rate;
+	vsc_supported = dp->hw->ops->vsc_supported(dp->hw);
+	dp->ops->unlock(dp);
+
+	pixel_per_cycle = dptx_pick_ppc(&adjusted, DP_PIXELFORMAT_RGB);
+
+	can_420 = drm_mode_is_420(info, mode) && bridge->ycbcr_420_allowed &&
+		  vsc_supported;
+
+	if (drm_mode_is_420_only(info, mode)) {
+		if (!can_420)
+			return MODE_NO_420;
+
+		minbpp = 8 * 3 / 2;
+		pixel_per_cycle = 1;
+	} else if (can_420 && adjusted.clock <= DPTX_MAX_FREQ) {
+		minbpp = 8 * 3 / 2;
+	} else if (info->color_formats &
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
+	bool vsc_supported;
+
+	if (!conn_state->crtc)
+		return 0;
+
+	dptx_adjust_mode(&crtc_state->mode, &crtc_state->adjusted_mode);
+
+	dp->ops->lock(dp);
+	ret = dptx_pick_config(dp, conn_state, &crtc_state->mode,
+			       &crtc_state->adjusted_mode,
+			       NULL, &bpc, &bpp);
+	vsc_supported = dp->hw->ops->vsc_supported(dp->hw);
+	dp->ops->unlock(dp);
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

