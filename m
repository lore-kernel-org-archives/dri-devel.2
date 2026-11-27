Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3773E606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:58:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9633610F0D2;
	Fri, 27 Nov 2026 05:58:16 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022121.outbound.protection.outlook.com [40.107.75.121])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DBE510EA69
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 05:58:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y+DW/u4cIwRwUrctsU/YCYPpZ1sfxbaWQR+5shq8c0fwoPk9AIyXeU7rShsR+Xe9xL6ar7OUFCdy6ONlMCZz7hMETF+ynVac+qAWKniMMawp8v/rI+/PAC0mZmESOB0HgrXUIy7Rhej8J5QS3RkqmWSFvbewcnmRgNDMcrHn1/GPainB9z1ie0o8lQuUD5RzsMOzBK6LXbGI60sgr/EGpaZjqg+BKb5qyPmPkZ26OicnuI0YvfdYWkKO80OmuzNlijQx/JtQafiDnmvpervDybr/73U+dyLpoTPVNo4jcGdw7xsoYBTp6CigqB/b311TSHQBrwf+MMFFqRVlqmiVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4Gsf7/xFgMlTGHK9IyaY6nLlECZgTImTv29V8is7OA=;
 b=pfqFAO+IkWL77py/Vh/YeLveUlPRxsKnsPN4Ci90qxZ66ozqopw8wmGXM4PS4+NIPGgPOi7ecqM1v1QJv3jd7csAftRRyrzJZF0CDM/gpuXlMNEr9EhiY4BUJQD4PffiijXc89RqE5mrJquV3dmbrP8T/W13T0X6dPX92j+cX0Zeim46XZx97z1rDo1hKHdn7gz2UExipYJsIRW5sEHQg0Hwx1IYnFzJe+TEjZPwXsBr1xmYPiu56K0xdkxkrVzZyBXXu9bMv4l4ZFqAlphaQ+QYX4vvUaZehVGzIarDTBNDjExu/D9GlsZxMr/Rs4KFGidL7rsVTkyn/VVZw+YyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SG2PR04CA0212.apcprd04.prod.outlook.com (2603:1096:4:187::8) by
 SEYPR06MB6982.apcprd06.prod.outlook.com (2603:1096:101:1e2::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.4; Fri, 27 Nov 2026 05:58:10 +0000
Received: from OSA0EPF000000C6.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::82) by SG2PR04CA0212.outlook.office365.com
 (2603:1096:4:187::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 05:58:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 OSA0EPF000000C6.mail.protection.outlook.com (10.167.240.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 05:58:08 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 3417140920E8;
 Fri, 27 Nov 2026 13:58:08 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
Subject: [PATCH v6 5/5] drm/cix: add the Sky1 DisplayPort platform glue
Date: Fri, 27 Nov 2026 13:58:07 +0800
Message-Id: <20261127055807.109667-6-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261127055807.109667-1-Luo.Liu@cixtech.com>
References: <20261127055807.109667-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSA0EPF000000C6:EE_|SEYPR06MB6982:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8142d772-7aed-4edc-1264-08df4c4b69d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|1800799024|23010399003|82310400026|42112799006|10067099003|261022105027099003|56012099006|261022075727099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|261021121427099003|261009223327099003|261009223027099003|261009220027099003|261009221727099003|261009221227099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: XB3CLEI/npenTrpUhnGmIl33lvkHbMos9ILAHh/8bYT0DSYHUy2ijO6kGFwFL0Eydc+yF6JO8WUZICVutrdP33T49JdTzPcXlqJxI1xaSSx+LCOaN255d4mJW3+4PzYPWRwRGLxCmj8RO3asCXiSAmSExtH7TF+e0E8v2UZ5apEScgecd4MxsGOHD9WIw9KswZx75qfLcD71m883PZsIVQszs7iTFZ1QReHQJcg4A/gi/Rih49qclTgG8TuCL2S9/dsH7sEe2LKcA1l0Tpgg6cyFZbGYSCFAyWW/Hqg0vDnRjVLKDmQ/AuI4nx8XiGCyZxq6i6kb9FpCBabirMqMF8ZgB7KJui8DX2fDJzlCELBrPxNzDfjNw1qLBAjrywAsFl7PAXqBCUkGXWGpNQilfEmC19SbBt+tj2Rx0CsCzPB4nqPtn7djn71sOL4X6xp8BkNTw1+elEc26zr9oe9LuHPSkg9Q5R3eSJyjhUFxQFfeZpB676WUN0VMZjWep2FnMmx+sQasSmq6GUr7t9a6b8AwwIe9YpBULAmsGe/Sx1JyxgA/tojR0oSTMK0uQuTdO9GVvXhpdncRIlQ0v7LdDKCZPiSE70CQVyPpCJQk0ScGN4UPiQ3j0WBacPExL3Tn6qL0nAwgWNpo7ONDLyETAkMBgTInLNRxzh5DmTu6ts4HKSRwEOsOqeIFwZAJmhylMPv6TSxJqnBw1Ajwu+j1Rg==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(1800799024)(23010399003)(82310400026)(42112799006)(10067099003)(261022105027099003)(56012099006)(261022075727099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(261021121427099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221727099003)(261009221227099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tuYVoi89E1QedhF9PBdPO6teKSQCiPfny4Q3tLFuqgpRf5mNDyO1WU9iEVy/vmlZ9+OVOy+MkVejd1IGf/JFERbFxcz4eAj1LI0y+0Utx4f+SWcuQ9X14bFHZh6El7vGajUTNKonBf5fHsVGJe/Tfee6RB7YDG4Q8T858rqhza9SATKLMs2l1LUm92ck7XriP9VRQpbNyZR4e5PmCK4RQFrHV0IALZO4urm+LfixM7jyg+WaaDYhW7A8F40zn4ENjFQnblStbq8kwc9IoN23kklaSYTD6o9t5X3VEZ3H+Q89+JDUzw8ILcQaHR6LyfbOOwE1Q5VGT2/G7DnnYHj7LNZvDHe5vmVHISjBqEZq7lv1pNkM10GMHvcs2+STopXTdlCUzcT3ZazP52ghNM9eYuVsIRsxBgrP/n5qmlEIHHtZXrtNj/cAc68QtyB+2h8s
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 05:58:08.9527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8142d772-7aed-4edc-1264-08df4c4b69d3
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: OSA0EPF000000C6.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6982
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

Add the platform driver that maps the Sky1 RCSU video adapter registers
and programs the pixel format and pixel-per-clock mode for the
Trilinear DisplayPort transmitter.

The DP protocol, link training and the DRM bridge live in the shared
Trilinear bridge driver. This glue only fills in the SoC-specific parts
through dptx_plat_data, declared in include/drm/bridge/trilinear_dp.h.

Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
---
 drivers/gpu/drm/Kconfig             |   1 +
 drivers/gpu/drm/Makefile            |   1 +
 drivers/gpu/drm/cix/Kconfig         |   3 +
 drivers/gpu/drm/cix/Makefile        |   3 +
 drivers/gpu/drm/cix/dptx/Kconfig    |  15 +++
 drivers/gpu/drm/cix/dptx/Makefile   |   4 +
 drivers/gpu/drm/cix/dptx/cix_dptx.c | 173 ++++++++++++++++++++++++++++
 7 files changed, 200 insertions(+)
 create mode 100644 drivers/gpu/drm/cix/Kconfig
 create mode 100644 drivers/gpu/drm/cix/Makefile
 create mode 100644 drivers/gpu/drm/cix/dptx/Kconfig
 create mode 100644 drivers/gpu/drm/cix/dptx/Makefile
 create mode 100644 drivers/gpu/drm/cix/dptx/cix_dptx.c

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 61111d50b1c6..a1808db8b9c8 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -311,6 +311,7 @@ source "drivers/gpu/drm/aspeed/Kconfig"
 source "drivers/gpu/drm/ast/Kconfig"
 source "drivers/gpu/drm/atmel-hlcdc/Kconfig"
 source "drivers/gpu/drm/bridge/Kconfig"
+source "drivers/gpu/drm/cix/Kconfig"
 source "drivers/gpu/drm/etnaviv/Kconfig"
 source "drivers/gpu/drm/exynos/Kconfig"
 source "drivers/gpu/drm/fsl-dcu/Kconfig"
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 2c6bc093a923..6ed7456bb993 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -169,6 +169,7 @@ obj-y			+= tests/
 obj-$(CONFIG_DRM_MIPI_DBI) += drm_mipi_dbi.o
 obj-$(CONFIG_DRM_MIPI_DSI) += drm_mipi_dsi.o
 obj-y			+= arm/
+obj-y			+= cix/
 obj-y			+= clients/
 obj-y			+= display/
 obj-$(CONFIG_DRM_TTM)	+= ttm/
diff --git a/drivers/gpu/drm/cix/Kconfig b/drivers/gpu/drm/cix/Kconfig
new file mode 100644
index 000000000000..6cbaa5bf9fe9
--- /dev/null
+++ b/drivers/gpu/drm/cix/Kconfig
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+source "drivers/gpu/drm/cix/dptx/Kconfig"
diff --git a/drivers/gpu/drm/cix/Makefile b/drivers/gpu/drm/cix/Makefile
new file mode 100644
index 000000000000..2cc5cba67848
--- /dev/null
+++ b/drivers/gpu/drm/cix/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_DRM_CIX_DP) += dptx/
diff --git a/drivers/gpu/drm/cix/dptx/Kconfig b/drivers/gpu/drm/cix/dptx/Kconfig
new file mode 100644
index 000000000000..f5d3afe5699f
--- /dev/null
+++ b/drivers/gpu/drm/cix/dptx/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config DRM_CIX_DP
+	tristate "Cix Sky1 DisplayPort platform glue"
+	depends on ARCH_CIX || COMPILE_TEST
+	depends on COMMON_CLK && DRM && OF
+	depends on GENERIC_PHY
+	select DRM_TRILINEAR_DPTX
+	help
+	  Platform glue for the Cix Sky1 DisplayPort output. It maps the
+	  SoC video adapter registers and binds the shared Trilinear DPTX
+	  bridge driver.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called cix-dptx.
diff --git a/drivers/gpu/drm/cix/dptx/Makefile b/drivers/gpu/drm/cix/dptx/Makefile
new file mode 100644
index 000000000000..64226bbd7c49
--- /dev/null
+++ b/drivers/gpu/drm/cix/dptx/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+cix-dptx-y := cix_dptx.o
+obj-$(CONFIG_DRM_CIX_DP) += cix-dptx.o
diff --git a/drivers/gpu/drm/cix/dptx/cix_dptx.c b/drivers/gpu/drm/cix/dptx/cix_dptx.c
new file mode 100644
index 000000000000..ca724ddc7e93
--- /dev/null
+++ b/drivers/gpu/drm/cix/dptx/cix_dptx.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CIX Sky1 DisplayPort platform glue
+ *
+ * Copyright 2026 Cix Technology Group Co., Ltd.
+ */
+
+#include <linux/bits.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+
+#include <drm/bridge/trilinear_dp.h>
+
+#define CFG_ADAPTER_VIDEO0_OFFSET 0x300
+#define CFG_ADAPTER_VIDEO1_OFFSET 0x304
+#define CFG_ADAPTER_VIDEO_OFFSET_DP2 0x320
+
+struct cix_dp_adapter_fmt {
+	int offset;
+	u32 shift;
+};
+
+struct cix_dptx {
+	void __iomem *rcsu;
+};
+
+static const struct cix_dp_adapter_fmt usbc_adapter_fmt[] = {
+	{ CFG_ADAPTER_VIDEO0_OFFSET, 30 },
+	{ CFG_ADAPTER_VIDEO1_OFFSET, 19 },
+};
+
+static const struct cix_dp_adapter_fmt dp2_adapter_fmt[] = {
+	{ CFG_ADAPTER_VIDEO_OFFSET_DP2, 17 },
+	{ CFG_ADAPTER_VIDEO_OFFSET_DP2, 20 },
+};
+
+static void cix_dp_adapter_fmt_set(void __iomem *rcsu,
+				   const struct cix_dp_adapter_fmt *adapter,
+				   enum dp_pixelformat format, bool ppc2)
+{
+	u32 fmt_mask;
+	u32 ppc_bit;
+	u32 value;
+
+	/* The PPC control bit sits directly below the pixel format field. */
+	fmt_mask = GENMASK(adapter->shift + 1, adapter->shift);
+	ppc_bit = BIT(adapter->shift - 1);
+
+	value = readl(rcsu + adapter->offset);
+
+	value &= ~fmt_mask;
+	if (format == DP_PIXELFORMAT_YUV422)
+		value |= 2U << adapter->shift;
+	else if (format == DP_PIXELFORMAT_YUV420)
+		value |= 3U << adapter->shift;
+
+	if (ppc2)
+		value |= ppc_bit;
+	else
+		value &= ~ppc_bit;
+
+	writel(value, rcsu + adapter->offset);
+}
+
+static void cix_dp_usbc_adapter_config(void *data, unsigned int pipe_id,
+				       enum dp_pixelformat format, bool ppc2)
+{
+	struct cix_dptx *priv = data;
+
+	if (pipe_id >= ARRAY_SIZE(usbc_adapter_fmt))
+		return;
+
+	cix_dp_adapter_fmt_set(priv->rcsu, &usbc_adapter_fmt[pipe_id], format,
+			       ppc2);
+}
+
+static void cix_dp_native_adapter_config(void *data, unsigned int pipe_id,
+					 enum dp_pixelformat format, bool ppc2)
+{
+	struct cix_dptx *priv = data;
+
+	if (pipe_id >= ARRAY_SIZE(dp2_adapter_fmt))
+		return;
+
+	cix_dp_adapter_fmt_set(priv->rcsu, &dp2_adapter_fmt[pipe_id], format,
+			       ppc2);
+}
+
+static int cix_dptx_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct dptx_plat_data *soc_data;
+	struct cix_dptx *priv;
+	struct dptx_dev *dp;
+	void __iomem *rcsu;
+
+	soc_data = of_device_get_match_data(dev);
+	if (!soc_data)
+		return -ENODEV;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	rcsu = devm_platform_ioremap_resource_byname(pdev, "rcsu");
+	if (IS_ERR(rcsu))
+		return dev_err_probe(dev, PTR_ERR(rcsu),
+				     "failed to map rcsu registers\n");
+
+	priv->rcsu = rcsu;
+
+	dp = trilinear_dptx_probe(dev, soc_data, priv);
+	if (IS_ERR(dp))
+		return PTR_ERR(dp);
+
+	return 0;
+}
+
+static int cix_dptx_pm_suspend(struct device *dev)
+{
+	return trilinear_dptx_suspend(dev_get_drvdata(dev));
+}
+
+static int cix_dptx_pm_resume(struct device *dev)
+{
+	return trilinear_dptx_resume(dev_get_drvdata(dev));
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(cix_dptx_pm_ops, cix_dptx_pm_suspend,
+				cix_dptx_pm_resume);
+
+static void cix_dptx_shutdown(struct platform_device *pdev)
+{
+	trilinear_dptx_shutdown(platform_get_drvdata(pdev));
+}
+
+static const struct dptx_plat_data sky1_usbdp_data = {
+	.adapter_config = cix_dp_usbc_adapter_config,
+	.oob_hpd = true,
+	.max_bw_code = DP_LINK_BW_5_4,
+};
+
+static const struct dptx_plat_data sky1_dp_data = {
+	.adapter_config = cix_dp_native_adapter_config,
+	.max_bw_code = DP_LINK_BW_5_4,
+};
+
+static const struct of_device_id cix_dptx_dt_ids[] = {
+	{ .compatible = "cix,sky1-usbdp", .data = &sky1_usbdp_data },
+	{ .compatible = "cix,sky1-dp", .data = &sky1_dp_data },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, cix_dptx_dt_ids);
+
+static struct platform_driver cix_dp_driver = {
+	.probe = cix_dptx_probe,
+	.shutdown = cix_dptx_shutdown,
+	.driver = {
+		.name = "cix-dptx",
+		.of_match_table = cix_dptx_dt_ids,
+		.pm = pm_sleep_ptr(&cix_dptx_pm_ops),
+	},
+};
+
+module_platform_driver(cix_dp_driver);
+
+MODULE_AUTHOR("Luo Liu <Luo.Liu@cixtech.com>");
+MODULE_AUTHOR("Wuyi Shen <wuyi.shen@cixtech.com>");
+MODULE_DESCRIPTION("Cix Sky1 DisplayPort platform glue");
+MODULE_LICENSE("GPL");
-- 
2.25.1

