Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4AC606A330
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:00:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67CF10E089;
	Thu, 26 Nov 2026 06:00:12 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022088.outbound.protection.outlook.com [40.107.75.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7409210E008
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:00:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Losvl/tKISF2T5S7g2LBdBXWZnMSQ9Xn0d/kvkNtsgCUEa0uBHJY9fWsVPtCLKCob6HCAvg+foyO+aUXSwjAAUEW5spihkukvBVf0pLpPxVDqcAYWniIgKxJvpPOguyI0dOtlMGD/GcbZHAEvAsETy6YhG0HCuN8cpZcS7nxDsppnXpp5EomgG8S9B9kMbB1TuBuWOZryxxlByvTrYtMV5+8Hp3OEi7T19e+c0QXnoEx2UyAxkbt3lRmaCZTuiOnjrAbnhiqoJXUDsO0K5ie/utACHSr5HPg6rpHlhDD2a+oVfoNWb5seplaCwh6UQWbPYMY3wjjjryv36SpsoiW1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkGO0/qz+nsXSf31kk7nlrooZ0HUXHo27h1GRCMxfzs=;
 b=l9i+EMjCb+L8quZfVeYbsJn86cCNOI0ODNSC7Ej25M5a/AWmeamhpgQJjEFX1fopaGpsIFA72NOkxCLdS41eY4/tB7PcW1KUZL2hKKqglaiTcDDBZoJ0Z57oWNRUGRpZyJInJcu5vZIlWQTQbauA1t+4AyXmP9hE4Y0At64FNXmREZaRqNuW2GWbopFrvbGg0WPzn89NdAlK8iAGgRxBG5VqIYT5Jq93CQWi4776IZ/z3Bf5fOmh11zI8Cs6ojEUgtE4aBFFi+NhJ6Ka+VZhi4uw5MO8ZKLScaUNb/bEfiq38B4MNGmjQbrtN74xRPf0k5ylRdwVyBXeuIXFKGhpHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:300:58::15) by SE2PPFD2E6A0907.apcprd06.prod.outlook.com
 (2603:1096:108:1::7ed) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 06:00:07 +0000
Received: from TY2PEPF0000AB83.apcprd03.prod.outlook.com
 (2603:1096:300:58:cafe::ae) by PS2PR01CA0027.outlook.office365.com
 (2603:1096:300:58::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 06:00:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB83.mail.protection.outlook.com (10.167.253.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 06:00:06 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 17F9940920EA;
 Thu, 26 Nov 2026 14:00:04 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
Subject: [PATCH v5 4/5] drm/bridge: trilinear: add the DPTX core and build glue
Date: Thu, 26 Nov 2026 14:00:02 +0800
Message-Id: <20261126060003.3979478-5-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261126060003.3979478-1-Luo.Liu@cixtech.com>
References: <20261126060003.3979478-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB83:EE_|SE2PPFD2E6A0907:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4ee84f3e-98fa-4e32-ddd3-08df4b82854f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|376014|36860700016|23010399003|42112799006|82310400026|261021121427099003|10067099003|56012099006|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261021123027099003|261102123227099003|261102130727099003|261022075727099003|261009223027099003|261009220027099003|261009223327099003|261009221727099003|261009221227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1itTEW8g6OGA42iEhwarQbBNzqGnwuJsAkBG1Vm6TtHDICTQvMdQ0B8aJQkia8A1tn2xmEstlTY5fNX7kH9STiYO8ybSrHFqXbFZEenMAN6UlPNVeJA3c8hLfezyxfMKXMQaVbpSEKJBkPpOgtcvkv0Ymo6APAglL+rxXiczdxQMrShPBAD8bFiM7sd7zXxsq/+Un9ggvDgpId/zNr+itw06Q6MCsStwCO8amdTEaCB2R+lqYwwmlvzod5KrSWYPmnzp4VxiUNg44pDosUN19xm4/pBp5o7uPKtQbaYP1vZPO3wpr0enFuJPTgSCPnbOk7leS8IHmZDmgloOXHZJAAyCskLldqD5VoaH+aC1C14SazY6EqwmZu2GUlvXyiLgcHw8fAKiW+32itAubd00Tf4qTpAIAkXq4sUnLa12ROU2c1pCKpJPDkCLAIjcBK9fC5pYqm2bSClFUOX5Fv8RuOUbtlNQD4kuhMmeKq+Qfq/lStXBOa0/WYHzMcCrrvkuWowDqz/lAI3r9gzBHWFMkdV2rLdRQiig9Nn3EbHHTfy8meZkNlgrbkhXeOKN+OZA97hur7a6wlZkJEBiJWjHEssraT2Ovz35OPeyiXBO6p31ugzbJ9RnfzjNhvTRvGc4x1bLSrTysX8AHiIMTbrTOtfV3FyivWEp8JjEtpV4Kf5X2P+E93pgnvbB68/8oUeYwJmPP/KVaBGZV3QogFh+Lg==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(376014)(36860700016)(23010399003)(42112799006)(82310400026)(261021121427099003)(10067099003)(56012099006)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261021123027099003)(261102123227099003)(261102130727099003)(261022075727099003)(261009223027099003)(261009220027099003)(261009223327099003)(261009221727099003)(261009221227099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w+47dOFyV0V1GazeN20DHs8ME4JAwN+Hlgi9OanqMIPlB+3a2TPlSdlb26MyFJaKOMKY7MwJ/yu8V8J8wlXP+aheh18S+3s+3CyDkOEYsDqomIy+EYibJQKPidilgmrVQIpgKShHDDBRWs5oVTOcKOJr2B9BPsiPmm5jzVPoTp1NVrlpd6bOAzJSkY+pAARkXPvZ2N92kqP+mY97qQZpOntLz8o3MvMSt752v4Zn+YXvkE6PCk3oegQyuS/Qb53G0N6gkcypY2SLbWQB1UuZqXNHwHajkvtJvH6r+RMYDKphUgrAxOyrDJ5qCiOB+yKGrld1qXKllaWkMlUv5S7B36nB4qSZ04D/IyUzR0jAKDhlsPoqlZ1fkbwPT4RWJiXLFw51X31kuAnLdrrInLF3ZNJVkSTYdi9ssJLb4JpxkyW0g0cZ1NVwLwTblcmhzffu
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 06:00:06.0602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee84f3e-98fa-4e32-ddd3-08df4b82854f
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB83.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFD2E6A0907
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

Add the probe path, system sleep handling, hotplug workers and the
stream state machine that tie the hardware layer to the DRM bridge, and
hook the driver into the DRM bridge Kconfig and Makefile.

Detection is driven by the controller's HPD interrupt. The USB-C
transmitters do not route HPD to the controller, so a sink that was
plugged in before the bridge was attached raises no event; replay that
plug once the common PHY is in DP mode and the AUX channel answers. The
native DP port wires HPD and is reported by the interrupt.

An atomic enable that races the system sleep callbacks re-initializes the
host on demand; the suspend path reinstates its suspended state afterwards
so the host is never powered down with its interrupt armed.

Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
---
 drivers/gpu/drm/bridge/Kconfig               |    2 +
 drivers/gpu/drm/bridge/Makefile              |    1 +
 drivers/gpu/drm/bridge/trilinear/Kconfig     |    9 +
 drivers/gpu/drm/bridge/trilinear/Makefile    |    4 +
 drivers/gpu/drm/bridge/trilinear/dptx_core.c | 1080 ++++++++++++++++++
 5 files changed, 1096 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/trilinear/Kconfig
 create mode 100644 drivers/gpu/drm/bridge/trilinear/Makefile
 create mode 100644 drivers/gpu/drm/bridge/trilinear/dptx_core.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index c7da6b02d7b6..d328d5f84dc7 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -510,4 +510,6 @@ source "drivers/gpu/drm/bridge/imx/Kconfig"
 
 source "drivers/gpu/drm/bridge/synopsys/Kconfig"
 
+source "drivers/gpu/drm/bridge/trilinear/Kconfig"
+
 endmenu
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 15cc821d85b7..9fe6bec55c51 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -53,3 +53,4 @@ obj-y += analogix/
 obj-y += cadence/
 obj-y += imx/
 obj-y += synopsys/
+obj-y += trilinear/
diff --git a/drivers/gpu/drm/bridge/trilinear/Kconfig b/drivers/gpu/drm/bridge/trilinear/Kconfig
new file mode 100644
index 000000000000..7e2bf1f27035
--- /dev/null
+++ b/drivers/gpu/drm/bridge/trilinear/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config DRM_TRILINEAR_DPTX
+	tristate
+	depends on COMMON_CLK && DRM && OF
+	depends on GENERIC_PHY
+	select DRM_KMS_HELPER
+	select DRM_DISPLAY_HELPER
+	select DRM_DISPLAY_DP_HELPER
diff --git a/drivers/gpu/drm/bridge/trilinear/Makefile b/drivers/gpu/drm/bridge/trilinear/Makefile
new file mode 100644
index 000000000000..415842b8465d
--- /dev/null
+++ b/drivers/gpu/drm/bridge/trilinear/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+trilinear-dptx-y := dptx_core.o dptx_drm.o dptx_hw.o
+obj-$(CONFIG_DRM_TRILINEAR_DPTX) += trilinear-dptx.o
diff --git a/drivers/gpu/drm/bridge/trilinear/dptx_core.c b/drivers/gpu/drm/bridge/trilinear/dptx_core.c
new file mode 100644
index 000000000000..532f4fe0577f
--- /dev/null
+++ b/drivers/gpu/drm/bridge/trilinear/dptx_core.c
@@ -0,0 +1,1080 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Trilinear Technologies
+ * Copyright 2026 Cix Technology Group Co., Ltd.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/phy/phy.h>
+#include <linux/sched.h>
+#include <linux/workqueue.h>
+
+#include <drm/drm_bridge.h>
+
+#include "dptx.h"
+#include "dptx_drm.h"
+#include "dptx_hw.h"
+
+#define DEFAULT_DP_POWER_ON_DELAY_MS 4
+#define DP_HPD_MAX_TRIES 100
+
+static unsigned int dptx_power_on_delay_ms = DEFAULT_DP_POWER_ON_DELAY_MS;
+module_param_named(power_on_delay_ms, dptx_power_on_delay_ms, uint, 0444);
+MODULE_PARM_DESC(power_on_delay_ms,
+		 "Delay after powering the sink up, in msec (default: 4)");
+
+static bool dptx_regs_accessible(struct dptx_dev *dp)
+{
+	return !(dp->state & DPTX_STATE_SUSPENDED) &&
+	       (dp->state & DPTX_STATE_INITIALIZED);
+}
+
+static bool dptx_get_hpd_state(struct dptx_dev *dp)
+{
+	return dp->hw->ops->hpd_state(dp->hw) ||
+	       dp->force_hpd == connector_status_connected;
+}
+
+static int dptx_get_lanes(struct dptx_dev *dp, int link_rate, int pclk, u8 bpp)
+{
+	int max_lanes = dp->link_max_lanes;
+	int i;
+
+	for (i = 1; i <= max_lanes; i <<= 1) {
+		if (pclk <= DPTX_MAX_RATE(link_rate, i, bpp ? bpp : 24))
+			return i;
+	}
+
+	return 0;
+}
+
+static int dptx_mode_configure(struct dptx_dev *dp, int pclk, u8 bw, u8 bpp,
+			       bool downshift)
+{
+	int max_rate = dp->link_max_rate;
+	int lane_cnt;
+	int bw_code;
+	int link_rate;
+
+	if (!downshift)
+		bw_code = bw;
+	else
+		switch (bw) {
+		case DP_LINK_BW_8_1:
+			bw_code = DP_LINK_BW_5_4;
+			break;
+		case DP_LINK_BW_5_4:
+			bw_code = DP_LINK_BW_2_7;
+			break;
+		case DP_LINK_BW_2_7:
+			bw_code = DP_LINK_BW_1_62;
+			break;
+		case DP_LINK_BW_1_62:
+			return -EINVAL;
+		default:
+			bw_code = drm_dp_link_rate_to_bw_code(max_rate);
+			break;
+		}
+
+	link_rate = drm_dp_bw_code_to_link_rate(bw_code);
+	lane_cnt = dptx_get_lanes(dp, link_rate, pclk, bpp);
+	if (!lane_cnt)
+		return -EINVAL;
+
+	dp->mode.bw_code = bw_code;
+	dp->mode.link_rate = link_rate;
+	dp->mode.lane_cnt = lane_cnt;
+	dp->mode.pclock = pclk;
+
+	return 0;
+}
+
+static struct drm_display_mode *dptx_get_mode(struct dptx_dev *dp,
+					      unsigned int stream_id)
+{
+	if (stream_id >= DPTX_MST_SOURCE_NUMBER)
+		return NULL;
+
+	if (!(dp->active_streams & BIT(stream_id)))
+		return NULL;
+
+	return &dp->adjusted_mode;
+}
+
+static void dptx_active_streams(struct dptx_dev *dp)
+{
+	struct drm_display_mode *mode;
+	int i;
+
+	if (!dp->attached)
+		return;
+
+	for (i = 0; i < DPTX_MST_SOURCE_NUMBER; i++) {
+		if (!(dp->active_streams & BIT(i)))
+			continue;
+
+		mode = dptx_get_mode(dp, i);
+		if (!mode)
+			continue;
+
+		dp->hw->ops->stream_timing(dp->hw, i, mode,
+					   dp->config.bpp,
+					   dp->mode.lane_cnt, dp->mode.link_rate,
+					   dp->pixel_per_cycle);
+	}
+}
+
+static int dptx_stream_hw_cfg(struct dptx_dev *dp, unsigned int stream_id)
+{
+	const struct dptx_config *config = &dp->config;
+	struct drm_display_mode *mode = dptx_get_mode(dp, stream_id);
+	int ret;
+
+	if (!mode)
+		return -EINVAL;
+
+	ret = dp->hw->ops->stream_format_set(dp->hw, stream_id, config->format,
+					     config->colorspace, config->bpc,
+					     config->content_type);
+	if (ret)
+		return ret;
+
+	dp->hw->ops->stream_timing(dp->hw, stream_id, mode,
+				   dp->config.bpp, dp->mode.lane_cnt,
+				   dp->mode.link_rate, dp->pixel_per_cycle);
+
+	dp->soc_data->adapter_config(dp->soc_priv, stream_id,
+				     config->format, dp->pixel_per_cycle == 2);
+
+	return 0;
+}
+
+static int dptx_ctrl_stream_on(struct dptx_dev *dp, unsigned int stream_id)
+{
+	struct drm_display_mode *mode;
+	unsigned long pixel_clock;
+	int ret;
+
+	if (stream_id >= DPTX_MST_SOURCE_NUMBER)
+		return -EINVAL;
+
+	mode = dptx_get_mode(dp, stream_id);
+	if (!mode)
+		return -EINVAL;
+
+	pixel_clock = (unsigned long)mode->clock * 1000;
+	ret = dp->hw->ops->stream_clock_rate_set(dp->hw, stream_id, pixel_clock);
+	if (ret)
+		return ret;
+
+	ret = dp->hw->ops->stream_clock_enable(dp->hw, stream_id, true);
+	if (ret)
+		return ret;
+
+	ret = dptx_stream_hw_cfg(dp, stream_id);
+	if (ret) {
+		dp->hw->ops->stream_clock_enable(dp->hw, stream_id, false);
+		return ret;
+	}
+
+	dp->hw->ops->stream_enable(dp->hw, stream_id, true);
+
+	dp->active_stream_cnt++;
+	return 0;
+}
+
+static void dptx_ctrl_stream_off(struct dptx_dev *dp, unsigned int stream_id)
+{
+	dp->hw->ops->stream_enable(dp->hw, stream_id, false);
+	dp->hw->ops->stream_clock_enable(dp->hw, stream_id, false);
+
+	dp->active_stream_cnt--;
+}
+
+static void dptx_stop_streams(struct dptx_dev *dp)
+{
+	int i;
+
+	if (!(dp->state & DPTX_STATE_INITIALIZED))
+		return;
+
+	for (i = 0; i < DPTX_MST_SOURCE_NUMBER; i++) {
+		if (!(dp->active_streams & BIT(i)))
+			continue;
+
+		dptx_ctrl_stream_off(dp, i);
+		dp->active_streams &= ~BIT(i);
+	}
+
+	if (!dp->active_stream_cnt)
+		dp->state &= ~DPTX_STATE_ENABLED;
+}
+
+static int dptx_enable(struct dptx_dev *dp, unsigned int stream_id)
+{
+	int ret;
+
+	if (stream_id >= DPTX_MST_SOURCE_NUMBER)
+		return -EINVAL;
+
+	if (dp->active_streams & BIT(stream_id))
+		return 0;
+
+	if (!(dp->state & DPTX_STATE_INITIALIZED) ||
+	    !(dp->state & DPTX_STATE_READY)) {
+		dev_dbg(dp->dev, "enable skipped, state=0x%x\n", dp->state);
+		return 0;
+	}
+
+	dp->active_streams |= BIT(stream_id);
+	ret = dptx_ctrl_stream_on(dp, stream_id);
+	if (ret) {
+		dp->active_streams &= ~BIT(stream_id);
+		return ret;
+	}
+
+	dp->state |= DPTX_STATE_ENABLED;
+
+	return 0;
+}
+
+static int dptx_disable(struct dptx_dev *dp, unsigned int stream_id)
+{
+	if (stream_id >= DPTX_MST_SOURCE_NUMBER)
+		return -EINVAL;
+
+	if (!(dp->state & DPTX_STATE_ENABLED) ||
+	    !(dp->state & DPTX_STATE_INITIALIZED))
+		return 0;
+
+	if (dp->active_stream_cnt && (dp->active_streams & BIT(stream_id))) {
+		dptx_ctrl_stream_off(dp, stream_id);
+		dp->active_streams &= ~BIT(stream_id);
+	}
+
+	return 0;
+}
+
+static int dptx_train_loop(struct dptx_dev *dp)
+{
+	struct dptx_mode *mode = &dp->mode;
+	struct dptx_mode orig = dp->mode;
+	u8 bpp = dp->config.bpp;
+	u8 prev_bw = mode->bw_code;
+	u8 prev_lanes = mode->lane_cnt;
+	u8 bw_code = mode->bw_code;
+	int i;
+	int j;
+	int ret;
+
+	for (i = 0; i < DP_MAX_TRAINING_LOOP; i++) {
+		for (j = 0; j <= 3; j++) {
+			if (!(dp->state & DPTX_STATE_READY)) {
+				ret = -ENODEV;
+				goto err_restore;
+			}
+
+			ret = dp->hw->ops->link_train(dp->hw, dp->phy,
+						      mode->bw_code,
+						      mode->lane_cnt,
+						      DPTX_MAX_LANES);
+			if (!ret) {
+				if (dp->active_stream_cnt &&
+				    (mode->bw_code != prev_bw ||
+				     mode->lane_cnt != prev_lanes))
+					dptx_active_streams(dp);
+				return 0;
+			}
+
+			ret = dptx_mode_configure(dp, mode->pclock, bw_code,
+						  bpp, true);
+			if (ret < 0)
+				break;
+
+			bw_code = dp->mode.bw_code;
+		}
+
+		ret = dptx_mode_configure(dp, mode->pclock,
+					  drm_dp_link_rate_to_bw_code(dp->link_max_rate),
+					  bpp, false);
+		if (ret < 0)
+			goto err_restore;
+
+		bw_code = dp->mode.bw_code;
+	}
+
+	ret = -EIO;
+err_restore:
+	dp->mode = orig;
+
+	return ret;
+}
+
+static int dptx_read_sink_caps(struct dptx_dev *dp)
+{
+	int max_rate;
+	int ret;
+
+	ret = dp->hw->ops->dpcd_sink_caps(dp->hw);
+	if (ret)
+		return ret;
+
+	if (!dp->hw->caps.max_lanes || !dp->hw->caps.max_rate)
+		return -EINVAL;
+
+	max_rate = drm_dp_bw_code_to_link_rate(dp->soc_data->max_bw_code);
+
+	dp->link_max_lanes = min_t(u8, dp->hw->caps.max_lanes, DPTX_MAX_LANES);
+	dp->link_max_rate = min_t(int, dp->hw->caps.max_rate, max_rate);
+
+	return 0;
+}
+
+static int dptx_core_on(struct dptx_dev *dp)
+{
+	int i, ret;
+
+	if (dp->state & DPTX_STATE_READY)
+		return 0;
+
+	dp->state |= DPTX_STATE_READY;
+
+	for (i = 0; i < DPTX_MST_SOURCE_NUMBER; i++)
+		dp->hw->ops->stream_enable(dp->hw, i, false);
+
+	ret = phy_power_on(dp->phy);
+	if (ret)
+		goto err;
+
+	ret = dp->hw->ops->dpcd_power_up(dp->hw, dptx_power_on_delay_ms);
+	if (ret)
+		goto err_power;
+
+	ret = dptx_read_sink_caps(dp);
+	if (ret)
+		goto err_power;
+
+	ret = dptx_train_loop(dp);
+	if (ret)
+		goto err_power;
+
+	dp->hw->ops->core_enable(dp->hw, 0, true);
+
+	dp->state |= DPTX_STATE_INIT_TRAIN;
+
+	return 0;
+
+err_power:
+	dp->hw->ops->dpcd_power_down(dp->hw, dptx_get_hpd_state(dp));
+	phy_power_off(dp->phy);
+err:
+	dp->state &= ~DPTX_STATE_READY;
+	return ret;
+}
+
+static int dptx_core_off(struct dptx_dev *dp)
+{
+	if (!(dp->state & DPTX_STATE_READY))
+		return 0;
+
+	dp->hw->ops->dpcd_power_down(dp->hw, dptx_get_hpd_state(dp));
+
+	phy_power_off(dp->phy);
+	dp->hw->ops->core_enable(dp->hw, 0, false);
+
+	dp->state &= ~(DPTX_STATE_READY | DPTX_STATE_INIT_TRAIN);
+
+	return 0;
+}
+
+static int dptx_host_reset(struct dptx_dev *dp)
+{
+	int ret;
+
+	dp->hw->ops->reset(dp->hw, true);
+	usleep_range(10, 20);
+	dp->hw->ops->reset(dp->hw, false);
+
+	ret = phy_reset(dp->phy);
+	if (ret)
+		return ret;
+
+	usleep_range(100, 200);
+	dp->hw->ops->host_enable(dp->hw, true);
+
+	ret = phy_init(dp->phy);
+	if (ret) {
+		dp->hw->ops->host_enable(dp->hw, false);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dptx_host_init(struct dptx_dev *dp)
+{
+	int ret;
+
+	if (dp->state & DPTX_STATE_INITIALIZED)
+		return 0;
+
+	ret = dp->hw->ops->apb_clock(dp->hw, true);
+	if (ret)
+		return ret;
+
+	ret = dptx_host_reset(dp);
+	if (ret) {
+		dp->hw->ops->apb_clock(dp->hw, false);
+		return ret;
+	}
+
+	drm_dp_dpcd_set_powered(&dp->hw->aux, true);
+	dp->state |= DPTX_STATE_INITIALIZED;
+
+	return 0;
+}
+
+static void dptx_host_deinit(struct dptx_dev *dp)
+{
+	if (dp->state & DPTX_STATE_READY)
+		dptx_core_off(dp);
+
+	if (!(dp->state & DPTX_STATE_INITIALIZED))
+		return;
+
+	dp->hw->ops->host_enable(dp->hw, false);
+	phy_exit(dp->phy);
+
+	drm_dp_dpcd_set_powered(&dp->hw->aux, false);
+	dp->hw->ops->apb_clock(dp->hw, false);
+
+	dp->state &= ~(DPTX_STATE_INITIALIZED | DPTX_STATE_INIT_TRAIN);
+}
+
+static int dptx_host_resume(struct dptx_dev *dp)
+{
+	int ret;
+
+	if (!(dp->state & DPTX_STATE_SUSPENDED))
+		return 0;
+
+	ret = dptx_host_init(dp);
+	if (ret)
+		return ret;
+
+	if (dp->irq_suspended) {
+		enable_irq(dp->irq);
+		dp->irq_suspended = false;
+	}
+
+	dp->state &= ~DPTX_STATE_SUSPENDED;
+	return 0;
+}
+
+static int dptx_handle_connect(struct dptx_dev *dp)
+{
+	int ret;
+
+	if (dp->state & DPTX_STATE_CONNECTED)
+		return 0;
+
+	if (dp->state & DPTX_STATE_SUSPENDED)
+		return 0;
+
+	ret = dptx_read_sink_caps(dp);
+	if (!ret)
+		dp->state |= DPTX_STATE_CONNECTED;
+
+	return ret;
+}
+
+static int dptx_handle_disconnect(struct dptx_dev *dp)
+{
+	dp->state &= ~DPTX_STATE_CONNECTED;
+
+	/*
+	 * The typec state can lag behind the PHY. Keep the forced state
+	 * unless the PHY is in DP mode, where an AUX probe can correct a
+	 * stale report.
+	 */
+	if (!dp->oob_hpd ||
+	    phy_get_mode(dp->phy) == PHY_MODE_DP)
+		dp->force_hpd = connector_status_unknown;
+
+	return 0;
+}
+
+static enum drm_connector_status dptx_ret_to_status(int ret)
+{
+	if (ret == -EBUSY)
+		return connector_status_unknown;
+	if (ret)
+		return connector_status_disconnected;
+
+	return connector_status_connected;
+}
+
+static int dptx_detect_locked(struct dptx_dev *dp)
+{
+	int ret;
+
+	if (dp->released) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (dp->state & DPTX_STATE_SUSPENDED) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (!(dp->state & DPTX_STATE_INITIALIZED)) {
+		dev_warn_once(dp->dev, "detect with uninitialized host\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (!dptx_get_hpd_state(dp)) {
+		dptx_handle_disconnect(dp);
+		ret = -ENODEV;
+		goto out;
+	}
+
+	ret = dptx_handle_connect(dp);
+
+out:
+	dp->status = dptx_ret_to_status(ret);
+
+	return ret;
+}
+
+static int dptx_detect(struct dptx_dev *dp)
+{
+	guard(mutex)(&dp->lock);
+
+	return dptx_detect_locked(dp);
+}
+
+static enum drm_connector_status dptx_detect_status(struct dptx_dev *dp)
+{
+	return dptx_ret_to_status(dptx_detect(dp));
+}
+
+static void dptx_notify_hpd(struct dptx_dev *dp,
+			    enum drm_connector_status status)
+{
+	WRITE_ONCE(dp->notify_task, current);
+	drm_bridge_hpd_notify(&dp->bridge, status);
+	WRITE_ONCE(dp->notify_task, NULL);
+}
+
+static bool dptx_hpd_work_aborted(struct dptx_dev *dp)
+{
+	return dp->hpd_stopped ||
+	       !dp->attached ||
+	       !dptx_regs_accessible(dp);
+}
+
+static bool dptx_hpd_wait_aborted(struct dptx_dev *dp)
+{
+	guard(mutex)(&dp->lock);
+
+	return dptx_hpd_work_aborted(dp) || !dptx_get_hpd_state(dp);
+}
+
+static bool dptx_wait_phy_dp_mode(struct dptx_dev *dp)
+{
+	enum phy_mode mode;
+
+	read_poll_timeout(phy_get_mode, mode,
+			  mode == PHY_MODE_DP || dptx_hpd_wait_aborted(dp),
+			  100 * USEC_PER_MSEC,
+			  DP_HPD_MAX_TRIES * 100 * USEC_PER_MSEC, false,
+			  dp->phy);
+
+	if (mode != PHY_MODE_DP || dptx_hpd_wait_aborted(dp)) {
+		dev_dbg(dp->dev, "PHY did not enter DP mode\n");
+		return false;
+	}
+
+	return true;
+}
+
+static void dptx_hpd_event_work_func(struct work_struct *work)
+{
+	struct dptx_dev *dp = container_of(work, struct dptx_dev,
+					 hpd_event_work.work);
+	enum drm_connector_status old_status;
+	enum drm_connector_status status;
+	bool hpd;
+
+	scoped_guard(mutex, &dp->lock) {
+		if (dptx_hpd_work_aborted(dp))
+			return;
+
+		old_status = dp->status;
+		hpd = dptx_get_hpd_state(dp);
+	}
+
+	if (hpd && dp->oob_hpd && !dptx_wait_phy_dp_mode(dp))
+		return;
+
+	scoped_guard(mutex, &dp->lock) {
+		if (dptx_hpd_work_aborted(dp))
+			return;
+
+		status = dptx_ret_to_status(dptx_detect_locked(dp));
+	}
+
+	if (old_status != status && dp->bridge.dev)
+		dptx_notify_hpd(dp, status);
+}
+
+static void dptx_hpd_irq_work_func(struct work_struct *work)
+{
+	struct dptx_dev *dp = container_of(work, struct dptx_dev,
+					 hpd_irq_work.work);
+
+	guard(mutex)(&dp->lock);
+
+	if (dp->hpd_stopped ||
+	    !dptx_regs_accessible(dp) ||
+	    !(dp->state & DPTX_STATE_ENABLED) ||
+	    !dptx_get_hpd_state(dp))
+		return;
+
+	if (dp->hw->ops->link_status(dp->hw, dp->mode.lane_cnt) > 0)
+		dptx_train_loop(dp);
+}
+
+static bool dptx_deferred_hotplug_pending(struct dptx_dev *dp)
+{
+	return !dptx_hpd_work_aborted(dp) &&
+	       !dp->released &&
+	       dp->force_hpd == connector_status_unknown;
+}
+
+/*
+ * USB-C combo PHY only. Its HPD pin is not wired to this controller, so a
+ * sink that was plugged in before the connector existed never raises
+ * HPD_EVENT. Replay that plug once the PHY is already in DP mode and AUX
+ * answers.
+ *
+ * A native DP port wires HPD to the controller and leaves the PHY mode at
+ * PHY_MODE_INVALID, so the checks below skip it. That port is reported by
+ * the HPD interrupt instead.
+ */
+static void dptx_replay_deferred_hotplug(struct dptx_dev *dp)
+{
+	guard(mutex)(&dp->lock);
+
+	if (!dptx_deferred_hotplug_pending(dp))
+		return;
+
+	if (dptx_get_hpd_state(dp)) {
+		queue_delayed_work(system_freezable_wq, &dp->hpd_event_work, 0);
+		return;
+	}
+
+	if (!dp->oob_hpd || phy_get_mode(dp->phy) != PHY_MODE_DP)
+		return;
+
+	if (!dp->hw->ops->sink_present(dp->hw))
+		return;
+
+	dp->force_hpd = connector_status_connected;
+	dp->status = connector_status_unknown;
+
+	queue_delayed_work(system_freezable_wq, &dp->hpd_event_work, 0);
+}
+
+static irqreturn_t dptx_irq_handler(int irq, void *data)
+{
+	struct dptx_dev *dp = data;
+
+	return dp->hw->ops->irq(dp->hw);
+}
+
+static void dptx_queue_hpd_event(void *data)
+{
+	struct dptx_dev *dp = data;
+
+	if (!READ_ONCE(dp->hpd_stopped))
+		queue_delayed_work(system_freezable_wq, &dp->hpd_event_work, 0);
+}
+
+static void dptx_queue_hpd_irq(void *data)
+{
+	struct dptx_dev *dp = data;
+
+	if (!READ_ONCE(dp->hpd_stopped))
+		queue_delayed_work(system_freezable_wq, &dp->hpd_irq_work, 0);
+}
+
+static void dptx_irq_off(struct dptx_dev *dp)
+{
+	if (dp->irq_suspended)
+		return;
+
+	disable_irq(dp->irq);
+	dp->irq_suspended = true;
+}
+
+static void dptx_cancel_hpd_works(struct dptx_dev *dp)
+{
+	cancel_delayed_work_sync(&dp->hpd_irq_work);
+	cancel_delayed_work_sync(&dp->hpd_event_work);
+}
+
+static void dptx_quiesce_hpd(struct dptx_dev *dp)
+{
+	scoped_guard(mutex, &dp->lock) {
+		WRITE_ONCE(dp->hpd_stopped, true);
+
+		if (!dp->released)
+			synchronize_irq(dp->irq);
+	}
+
+	dptx_cancel_hpd_works(dp);
+}
+
+static int dptx_pm_prepare(struct dptx_dev *dp)
+{
+	scoped_guard(mutex, &dp->lock) {
+		dptx_irq_off(dp);
+		dp->state |= DPTX_STATE_SUSPENDED;
+	}
+
+	dptx_cancel_hpd_works(dp);
+
+	scoped_guard(mutex, &dp->lock) {
+		if (!(dp->state & DPTX_STATE_SUSPENDED)) {
+			dptx_irq_off(dp);
+			dp->state |= DPTX_STATE_SUSPENDED;
+		}
+
+		if (!dp->active_stream_cnt)
+			dptx_host_deinit(dp);
+		dp->status = connector_status_unknown;
+		dp->force_hpd = connector_status_unknown;
+		dp->state &= ~DPTX_STATE_CONNECTED;
+	}
+
+	return 0;
+}
+
+static int dptx_pm_complete(struct dptx_dev *dp)
+{
+	bool replay = false;
+	int ret;
+
+	scoped_guard(mutex, &dp->lock) {
+		ret = dptx_host_resume(dp);
+		if (!ret)
+			replay = !dp->hpd_stopped && dp->attached;
+	}
+
+	if (ret)
+		return ret;
+
+	if (replay) {
+		dp->ops->replay_deferred_hotplug(dp);
+
+		scoped_guard(mutex, &dp->lock) {
+			if (!dptx_hpd_work_aborted(dp))
+				queue_delayed_work(system_freezable_wq,
+						   &dp->hpd_event_work, 0);
+		}
+	}
+
+	return 0;
+}
+
+static int dptx_prepare(struct dptx_dev *dp)
+{
+	int ret;
+
+	guard(mutex)(&dp->lock);
+
+	if (dp->released)
+		return -ENODEV;
+
+	/* The controller's resume commit can precede dptx_pm_complete(). */
+	ret = dptx_host_resume(dp);
+	if (ret)
+		return ret;
+
+	if (dp->state & DPTX_STATE_ENABLED)
+		return 0;
+
+	if (!(dp->state & DPTX_STATE_INITIALIZED)) {
+		ret = dptx_host_init(dp);
+		if (ret)
+			return ret;
+	} else if (dp->state & DPTX_STATE_READY) {
+		/* core_on() finished, but the stream never became ENABLED. */
+		dptx_core_off(dp);
+	}
+
+	if (!dptx_get_hpd_state(dp)) {
+		if (!dp->oob_hpd ||
+		    dp->force_hpd != connector_status_unknown ||
+		    phy_get_mode(dp->phy) != PHY_MODE_DP ||
+		    !dp->hw->ops->sink_present(dp->hw))
+			return -ENODEV;
+
+		dp->force_hpd = connector_status_connected;
+	}
+
+	return dptx_handle_connect(dp);
+}
+
+static int dptx_unprepare(struct dptx_dev *dp)
+{
+	if (dp->active_stream_cnt)
+		return 0;
+
+	if (!(dp->state & (DPTX_STATE_ENABLED | DPTX_STATE_READY)))
+		return 0;
+
+	dptx_core_off(dp);
+
+	/* dptx_pm_prepare() may have run before this suspend-time commit. */
+	if (dp->state & DPTX_STATE_SUSPENDED)
+		dptx_host_deinit(dp);
+
+	dp->state &= ~DPTX_STATE_ENABLED;
+
+	return 0;
+}
+
+static int dptx_encoder_enable(struct dptx_dev *dp, unsigned int stream_id,
+			       int enable)
+{
+	int ret;
+
+	guard(mutex)(&dp->lock);
+
+	if (enable) {
+		if (!dptx_regs_accessible(dp) ||
+		    !(dp->state & DPTX_STATE_CONNECTED))
+			return -ENODEV;
+
+		ret = dptx_core_on(dp);
+		if (ret)
+			return ret;
+
+		ret = dptx_enable(dp, stream_id);
+		if (ret)
+			dptx_unprepare(dp);
+	} else {
+		if (!(dp->state & DPTX_STATE_INITIALIZED))
+			return 0;
+
+		ret = dptx_disable(dp, stream_id);
+		if (ret)
+			return ret;
+
+		ret = dptx_unprepare(dp);
+	}
+
+	return ret;
+}
+
+static int dptx_init(struct dptx_dev *dp)
+{
+	int ret;
+
+	INIT_DELAYED_WORK(&dp->hpd_event_work, dptx_hpd_event_work_func);
+	INIT_DELAYED_WORK(&dp->hpd_irq_work, dptx_hpd_irq_work_func);
+
+	dp->state |= (DPTX_STATE_CONFIGURED);
+
+	ret = dptx_host_init(dp);
+	if (ret)
+		goto err_configured;
+
+	irq_set_status_flags(dp->irq, IRQ_DISABLE_UNLAZY);
+	ret = devm_request_threaded_irq(dp->dev, dp->irq, NULL,
+					dptx_irq_handler, IRQF_ONESHOT,
+				       dev_name(dp->dev), dp);
+	if (ret < 0)
+		goto err_deinit;
+
+	return 0;
+
+err_deinit:
+	dptx_host_deinit(dp);
+err_configured:
+	dp->state &= ~DPTX_STATE_CONFIGURED;
+	return ret;
+}
+
+static void dptx_deinit(struct dptx_dev *dp)
+{
+	if (!(dp->state & DPTX_STATE_CONFIGURED))
+		return;
+
+	scoped_guard(mutex, &dp->lock) {
+		WRITE_ONCE(dp->hpd_stopped, true);
+		dp->released = true;
+		dptx_irq_off(dp);
+	}
+
+	dptx_cancel_hpd_works(dp);
+
+	scoped_guard(mutex, &dp->lock) {
+		dptx_stop_streams(dp);
+		dptx_host_deinit(dp);
+		dp->hw->ops->aux_unregister(dp->hw);
+		dp->state &= ~(DPTX_STATE_CONFIGURED);
+	}
+}
+
+static void dptx_dev_release(void *res)
+{
+	struct dptx_dev *dp = res;
+
+	dptx_deinit(dp);
+}
+
+static int dptx_get_irq(struct dptx_dev *dp)
+{
+	int ret;
+
+	ret = of_irq_get(dp->dev->of_node, 0);
+	if (ret <= 0)
+		return dev_err_probe(dp->dev, ret ?: -EINVAL,
+				     "failed to get irq\n");
+
+	dp->irq = ret;
+
+	return 0;
+}
+
+static const struct dptx_ops dptx_impl_ops = {
+	.detect				= dptx_detect,
+	.detect_status			= dptx_detect_status,
+	.prepare			= dptx_prepare,
+	.unprepare			= dptx_unprepare,
+	.encoder_enable			= dptx_encoder_enable,
+	.mode_configure			= dptx_mode_configure,
+	.replay_deferred_hotplug	= dptx_replay_deferred_hotplug,
+	.quiesce_hpd			= dptx_quiesce_hpd,
+};
+
+struct dptx_dev *trilinear_dptx_probe(struct device *dev,
+				      const struct dptx_plat_data *soc_data,
+				      void *priv)
+{
+	struct dptx_dev *dp;
+	struct dp_hw *hw;
+	int ret;
+
+	if (!soc_data || !soc_data->adapter_config || !soc_data->max_bw_code)
+		return ERR_PTR(-EINVAL);
+
+	dp = dptx_bridge_alloc(dev);
+	if (IS_ERR(dp))
+		return dp;
+
+	mutex_init(&dp->lock);
+
+	dp->dev = dev;
+
+	dp->phy = devm_phy_get(dev, NULL);
+	if (IS_ERR(dp->phy))
+		return ERR_PTR(dev_err_probe(dev, PTR_ERR(dp->phy),
+					     "failed to get dp phy\n"));
+
+	hw = dptx_hw_init(dev, dp, dptx_queue_hpd_event, dptx_queue_hpd_irq);
+	if (IS_ERR(hw))
+		return ERR_CAST(hw);
+
+	dp->hw = hw;
+
+	dp->soc_data = soc_data;
+	dp->oob_hpd = soc_data->oob_hpd;
+	dp->soc_priv = priv;
+	dp->ops = &dptx_impl_ops;
+	dp->status = connector_status_unknown;
+	dp->force_hpd = connector_status_unknown;
+	dp->state = DPTX_STATE_DISCONNECTED;
+	dp->pixel_per_cycle = 1;
+
+	ret = dptx_get_irq(dp);
+	if (ret)
+		return ERR_PTR(ret);
+
+	dp->link_max_lanes = DPTX_MAX_LANES;
+	dp->link_max_rate =
+		drm_dp_bw_code_to_link_rate(soc_data->max_bw_code);
+
+	ret = dptx_init(dp);
+	if (ret)
+		return ERR_PTR(ret);
+
+	dev_set_drvdata(dev, dp);
+
+	dp->bridge.of_node = dev->of_node;
+	dp->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_MODES |
+			 DRM_BRIDGE_OP_HPD;
+	dp->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
+	dp->bridge.ddc = &dp->hw->aux.ddc;
+	dp->bridge.ycbcr_420_allowed = true;
+
+	ret = devm_drm_bridge_add(dev, &dp->bridge);
+	if (ret) {
+		dptx_deinit(dp);
+		return ERR_PTR(ret);
+	}
+
+	ret = devm_add_action_or_reset(dev, dptx_dev_release, dp);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return dp;
+}
+EXPORT_SYMBOL_GPL(trilinear_dptx_probe);
+
+int trilinear_dptx_suspend(struct dptx_dev *dp)
+{
+	if (!dp)
+		return 0;
+
+	return dptx_pm_prepare(dp);
+}
+EXPORT_SYMBOL_GPL(trilinear_dptx_suspend);
+
+int trilinear_dptx_resume(struct dptx_dev *dp)
+{
+	if (!dp)
+		return 0;
+
+	return dptx_pm_complete(dp);
+}
+EXPORT_SYMBOL_GPL(trilinear_dptx_resume);
+
+void trilinear_dptx_shutdown(struct dptx_dev *dp)
+{
+	if (!dp)
+		return;
+
+	scoped_guard(mutex, &dp->lock) {
+		dptx_stop_streams(dp);
+	}
+	dptx_pm_prepare(dp);
+}
+EXPORT_SYMBOL_GPL(trilinear_dptx_shutdown);
+
+MODULE_AUTHOR("Luo Liu <Luo.Liu@cixtech.com>");
+MODULE_AUTHOR("Wuyi Shen <wuyi.shen@cixtech.com>");
+MODULE_DESCRIPTION("DisplayPort transmitter bridge driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

