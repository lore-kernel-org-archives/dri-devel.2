Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C604606A33C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F15F10E868;
	Wed, 25 Nov 2026 03:32:54 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com
 (mail-japaneastazon11022133.outbound.protection.outlook.com [52.101.126.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F1210E345
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:32:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrRN4F0BURXIV9gt303Xj7Sw0VBcXQ5YM9/8HGUL9K1DXC/z4irHYnWIYnYGqd723Xct7BL0EoPmg0ah0xrvK4GCEDxs8V76n3wgI5g+19cs//hFE1E9qKM4UTre4gJ+VNPKqrv7WvACrPu0j3NISz78fkT/AsdW4QPYTYXQ7uXgsDtRKRG/XR+Wdwy47vZGr7aLQN319z3l2DNneylj25PSOC3wDmDpoQdNIBkcdLYzd/TSICVjCYeCvnM/6mhBrB0WyRAST2z9RVe5SaKJs5w+SN/+Pn19CvC1txO+rhOOjIG1DXyXpxcq5/H/FkhvVNLR5jkKlnCeI6kxynV8yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0osvqPdmdRv8LthDRUNYDF6Csx/rupdH9bJQf/C1ZI=;
 b=NQNjz1y07xySIiiqg1mhvmPDHmB5C2lW2JObuZcKDQtfSb2XvgKE4osa7F8+C1qxGlrkOTXf5u8Vs6cA3Y+gRTlPuNRjm70B3s3I/g97PiYIzcXE17qcq6/e3BkgzlrVTBeQtTaqQqtU4N1DvGgS4HZBl7CYxuVZbilFCb+2mdRJ7jaacq04Rs8/Ae+pCqUCFtYV08DraL6dxy37KAMA0owCuSTQ2sQ2+sCt7hNg199byeUHkSq1SNSD/GdLpMdAsuc0qSd/SLTNKnP5A3nlOv6Wp1uX+ZQ/Phlow1AtG8Q2nT0sPQRLBvPTRJ+y50EFcziPIfjIY4jbroVflsnlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0056.apcprd02.prod.outlook.com (2603:1096:4:1f5::7) by
 KL1PR06MB5924.apcprd06.prod.outlook.com (2603:1096:820:d4::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.4; Wed, 25 Nov 2026 03:32:41 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:1f5:cafe::7d) by SI1PR02CA0056.outlook.office365.com
 (2603:1096:4:1f5::7) with Microsoft SMTP Server (version=TLS1_3,
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
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 03:32:40 +0000
Received: from localhost.localdomain (unknown [172.16.66.33])
 by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id 59CFA40920E5;
 Wed, 25 Nov 2026 11:32:39 +0800 (CST)
From: Luo Liu <Luo.Liu@cixtech.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, luca.ceresoli@bootlin.com, wuyi.shen@cixtech.com,
 cix-kernel-upstream@cixtech.com
Subject: [PATCH v4 5/5] drm/cix: add the Sky1 DisplayPort platform glue
Date: Wed, 25 Nov 2026 11:32:38 +0800
Message-Id: <20261125033238.3436046-6-Luo.Liu@cixtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261125033238.3436046-1-Luo.Liu@cixtech.com>
References: <20261125033238.3436046-1-Luo.Liu@cixtech.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|KL1PR06MB5924:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 38915514-d69b-4c5f-ffb8-08df4aa4c25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|42112799006|82310400026|376014|1800799024|7416014|18002099003|22082099003|3023799007|261021121427099003|56012099006|261102123227099003|261022105027099003|261009220027099003|261026121527099003|261026140227099003|261009223027099003|261009221227099003|261009223327099003|261022075727099003|261009221727099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info: vc9tsC+CqC8YXtI7tT9QnbhlZrerRKunXZRvAscuPbvOmyCC8/YR5BbkQrTJA5wyVdCvLHpytbJybf2SzVbppflaAeqQ04q9OPLTSLNJAeCC0GozwDsVaj87NKQv0AwL44EZqga4Wxh9FsMD0p+uV4gQWwmKIngK+wHtavzGXxJ61fhRDNUyuDfNHQ2Jw6AkTeB48n9fraCBTvF5JL+BNlN2MeV1hSRX3AKfLBTL+9d5dFenaKVd60uq8twD9ldjGKsstuhCi0rmbr+72F1fon4X2NYalJGsTOTtvrunCNJ67OGqJucbGwkRRvfC0EjIaGJ1BXDnye2c7eR5NQyIzIWhW2ZUaQjoymJ0oL8ZiNrkDuLYnOVIrgItLe0gJUlxerA81jN+jQlaZc58ft9q8VRCMNiLK0DVjXLQuWjB5nlyRixr6x5a5QGbgagrw3V7XMJLOTo1nK/8YVy/Yi2srKYAGUFV71NDtdk5l8cYL297AZE2lE2YVF0N6xkzdtdNLwanrnJ0F0xLeZSwNdr06u19Xndgdvqe09CItHX0s0/BFDsNPT6G+bpXmV+o7jSug7cF6Ptul9TTz3sIBPDzK/cN71BHYMHxL5w7dLJvGBU7TZ8iBM2ZFcjy/qkwsvre/ElXh8OCcV4c/3SEJvm0qpbj/LZc96m2XIUXTyceYAYvcpBxEt3H4nPZoZBzvSB0hYt7CGBGLjJdTKpN7POfvQ==
X-Forefront-Antispam-Report: CIP:222.71.101.198; CTRY:CN; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtprelay.cixcomputing.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(42112799006)(82310400026)(376014)(1800799024)(7416014)(18002099003)(22082099003)(3023799007)(261021121427099003)(56012099006)(261102123227099003)(261022105027099003)(261009220027099003)(261026121527099003)(261026140227099003)(261009223027099003)(261009221227099003)(261009223327099003)(261022075727099003)(261009221727099003)(261028144727099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yFo9v9G+7E8aGFyGqUhJLdDc08VCdSD8cTfVYkI7VqSH7J/UG7otX+Vpal4V1rfzZxmsl2YjyWmU3/sFBL3r7PRMs8PvfW/eYp+9sGoKfTL5mVn6cd/wPGC7eaSaIBuMEn06IgNXJx6viAkz7PxBx7EuROXdH6ZWaMvmw3kocAJHatv1UoeKt16SyP+HZMeUZEA3aK3Y8xiG+YKYNg824MGYFyxuJ6l9F4hGDciYR+urkcy1m96UbJRX/RS6cKbbyFnTAmf8468rjEyQQ1mhgM8ob3kvScwKqQBDbOA1E3laD7CpNP5inUXMwaHPVMBrZHONMxH7GpXWdOw9ryhtLrsN9O5OIGu5rYbi4rTSN5LGc/B1qbuUA8xJMDQ0umXCm10wn0OsE6sx88rkjzNADCfM/vn+9o+D6lAZTtB1OE7SeXUMIxALtfgBLJRJpIra
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 03:32:40.3256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38915514-d69b-4c5f-ffb8-08df4aa4c25b
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811; Ip=[222.71.101.198];
 Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource: SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB5924
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
index 000000000000..0e79c0579950
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

