Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E15606A32D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C668210F531;
	Tue, 24 Nov 2026 12:01:41 +0000 (UTC)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazon11023139.outbound.protection.outlook.com
 [40.107.44.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C8C810F52B
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:01:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=du5/yszgYWt6CnB1U0yNqEtMILxtIFc5UplTbp4U+yGDu5G7mHHW92Ljg40H7TmwWIqRl2HbUQYG2K+L1EW8vH2iuz4IWareCjYYjpfgCnZg6s3nboIwp6hIm+bzxhQp6auXgj59myehOWSalmfSlbUMJTmUQq7HQsKv2HR9Y1d7MWmWHu6ZVgRMZ3D6y6ir1UatuaxkPU/6AQTGU5BdDTlUVjKnVcvccCO4nBDY76keOKYm+rQHjx6OK3syG2kv78TaVY0YFR24LVQqvMH0xt58d3uC/DQg/5E3EYGbvkpTcHZKHmsnIhhNtcIrOeCTJZISii+7NK4bemM9U3xPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ediP/riIZcE3UzbR8mixiUHwGj1PBp8S9jytJehBYw4=;
 b=R/W4MzcUFAKErj2BBA4lpDgv2N5tDffYeneg9jCyd+Eq6KV8VjmmjDT7i597/gPTUj73exLwwuNyLV4Rm/i1kpYpzR1C+0mPiVtttn1LS5CiEZ7OyBVUBhWilqJb6VgHi5dcalpxnopAgubLstZhkGaX+QFmpeHMEGso+bvtxnMEHIfGklNalwuHpabQv2PbmJXUC9jAzBzbABk+pty0TH7xN5baJe0oZV+OsOW7OcBwhsqxAdHbuYQ0LxXk4bccDVsg638qcF+0cxvyGiV7+awDhwRgZGswDFKiMkpFcC1apCq9FFlD55/EQzV/1w2HksuTBmwiUeluzCDJOeRxzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from PS2PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::26) by TY0PR06MB5780.apcprd06.prod.outlook.com
 (2603:1096:400:27f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Tue, 24 Nov
 2026 12:01:18 +0000
Received: from TY2PEPF0000AB86.apcprd03.prod.outlook.com
 (2603:1096:300:2d:cafe::5f) by PS2PR01CA0014.outlook.office365.com
 (2603:1096:300:2d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Tue, 24
 Nov 2026 12:01:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 TY2PEPF0000AB86.mail.protection.outlook.com (10.167.253.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 12:01:17 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id EF7E940920E7;
 Tue, 24 Nov 2026 20:01:14 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
Subject: [PATCH v3 5/5] drm/cix: add the Sky1 DisplayPort platform glue
Date: Tue, 24 Nov 2026 20:01:14 +0800
Message-Id: <20261124120114.3273161-6-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
References: <20261124120114.3273161-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF0000AB86:EE_|TY0PR06MB5780:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 92759d55-65a1-4ebf-ebc4-08df4a22a551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|82310400026|23010399003|376014|7416014|1800799024|36860700016|10067099003|18002099003|22082099003|3023799007|261028144727099003|261021121427099003|261009220027099003|261022075727099003|261009221227099003|261009221727099003|261102123227099003|261009223027099003|56012099006|261009223327099003|261026121527099003|261022105027099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: juwNhV7H2YPB8vweI+6eDGSV3B3Kzhb1cJzy0OIShg4/BeBj+zo+VhBxvGCXCwKBFf+QPjpwNeEVm/eFJOnEF8vmpS1r9w96zamO9eRZqe7o8nKiSXDUReQ5jtQk7375cX4kvGRIB9b8EBaH+imwTAy/Nj/wc+g3Ors32TrmHGwplDp22S0IpiirE5G5Pi5EihVYgJePgNKfiYT8LM7+Q2cquy7UzlvXyKsNjkww+3gjx5a4vz+VzfT3LNYl7JBrznzZCx7xugG4LvIniv/r6yP7cqO+fJvtB3YROvmjBgrbXPbO+KkXLmfK/623MJi4OmXt//NOUgkVlbi/u84KPCUO5hqB4VWvMvj6+1ZZkgkNguWvhTB8V57P3sxdaZuFMaU268I4BQkqn0wLdeR7T6raccHDqFLCM4fIl8/bAbd/hI6EvtDVjaFFztjGJ1Cjj1aRaOuWt0PwyxqGDYlJc4mOPF00S+5Bn6puPTHD+ctTZNoFNtVGyC2XPOvq/p6iSqfdZ07dlibBmVzoKmwhj4At8QV59oG5pWEuP3YhtBmDU+UUhDvclUNpAUitaM5RVYh+XjwMSM8s4SKBtf5qoLB9a7ZBmXTouMN2l4M3KsjnVn81ZuKm+UoKGWLAwE9OJzyu3cglRYylF9iIlzrT+WEG/RbVnNzzl8BlZVT+FsOHtgb41O4zK3rxomMD5gydmOl9+myfPg2dJKD+RMeF1Q==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(42112799006)(82310400026)(23010399003)(376014)(7416014)(1800799024)(36860700016)(10067099003)(18002099003)(22082099003)(3023799007)(261028144727099003)(261021121427099003)(261009220027099003)(261022075727099003)(261009221227099003)(261009221727099003)(261102123227099003)(261009223027099003)(56012099006)(261009223327099003)(261026121527099003)(261022105027099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /6fbaQUktn7w+tBApCRDJF8Yt/SVmphrvF6rraoTjUHqwCTNzLKrHH0iDfMdesHUATWhwD/IHrgOKToAS9DlVaE/WkND2t6VvTn5WqhDREuJy8WHfmTy8r3H+nUu3bxJTSAcr4i7HGiUD2hOh6PofJEHMfYJP5bnoqeYSFYvhNXIFXHHCM6bKnnSpQoPvEkbnJGzQaklujIzsXvi+yKCsIFzKp8TqQ8fe8GpnyvLHPCjp1kniMZ7rJorvOTbzVuSDTHM7yqWPHcj9sZq6jNHoKOdCBFX5zdL2p+GOsvginFTJeY4FRDi58bazmBKFiYIv7ckETikg1gyco4nIjDDED1I8nKHgpTuG+WL2buH+KwBrFM2d/fh6sKdo5c72WIomfQUHPddDshAlXxxPeqTC0bKMWlENW+5iKhwP/9J/fLLijAFKk5aTzaSIIlzXm2J
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 12:01:17.0149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92759d55-65a1-4ebf-ebc4-08df4a22a551
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF0000AB86.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5780
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
through dptx_plat_data, declared in include/drm/bridge/dptx.h.

Signed-off-by: Luo Liu <Luo.Liu@cixtech.com>
---
 drivers/gpu/drm/Kconfig             |   1 +
 drivers/gpu/drm/Makefile            |   1 +
 drivers/gpu/drm/cix/Kconfig         |   3 +
 drivers/gpu/drm/cix/Makefile        |   3 +
 drivers/gpu/drm/cix/dptx/Kconfig    |  15 +++
 drivers/gpu/drm/cix/dptx/Makefile   |   4 +
 drivers/gpu/drm/cix/dptx/cix_dptx.c | 163 ++++++++++++++++++++++++++++
 7 files changed, 190 insertions(+)
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
index 000000000000..a93591fc49e8
--- /dev/null
+++ b/drivers/gpu/drm/cix/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
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
index 000000000000..f2a344999faf
--- /dev/null
+++ b/drivers/gpu/drm/cix/dptx/cix_dptx.c
@@ -0,0 +1,163 @@
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
+
+#include <drm/bridge/dptx.h>
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
+static void cix_dp_usbc_adapter_config(void *data, int pipe_id,
+				       enum dp_pixelformat format, bool ppc2)
+{
+	struct cix_dptx *priv = data;
+
+	cix_dp_adapter_fmt_set(priv->rcsu, &usbc_adapter_fmt[pipe_id], format,
+			       ppc2);
+}
+
+static void cix_dp_native_adapter_config(void *data, int pipe_id,
+					 enum dp_pixelformat format, bool ppc2)
+{
+	struct cix_dptx *priv = data;
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
+	dp = dptx_probe(dev, soc_data, priv);
+	if (IS_ERR(dp))
+		return PTR_ERR(dp);
+
+	return 0;
+}
+
+static int cix_dptx_pm_suspend(struct device *dev)
+{
+	return dptx_suspend(dev_get_drvdata(dev));
+}
+
+static int cix_dptx_pm_resume(struct device *dev)
+{
+	return dptx_resume(dev_get_drvdata(dev));
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(cix_dptx_pm_ops, cix_dptx_pm_suspend,
+				cix_dptx_pm_resume);
+
+static void cix_dptx_shutdown(struct platform_device *pdev)
+{
+	dptx_shutdown(platform_get_drvdata(pdev));
+}
+
+static const struct dptx_plat_data sky1_usbdp_data = {
+	.adapter_config = cix_dp_usbc_adapter_config,
+};
+
+static const struct dptx_plat_data sky1_dp_data = {
+	.adapter_config = cix_dp_native_adapter_config,
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

