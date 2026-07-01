Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC28C44502
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:19:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB9310E375;
	Wed,  1 Jul 2026 12:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="hhfwmhvI";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9507410E373
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908387;
 bh=e6EW3G1noluvUbsf4mXKsPJ8a0ez3clxF+2eHH/FFqg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hhfwmhvIQ7qY87NQNIV7UZmDdBWYVH7l1gwP+cCNFU9b08NjP9GoOUNmVB9jo8pGg
 5PCt10kI7dzZGHzqgWEAxaAgMYJbl85p8lExaFyPZJKP8BjP7lsOf3pHfE0zouzW5r
 dxG+IlZNmINnhT7UrvMdsTxSIS1JQVcCOqADBakF9/7CBgURQmZQDPee/hYVvO0nHi
 5sOaTG5933eytsFfOPZuEGTq7AERCeUXexgGpmPty7RPfuGDeebnG2+4Y5DwmqeW4q
 N5yShbn9ohp4QRY0maizegIeaY7dCFgEsYwRB3kW02+pzdydgkMynJkPXyPGsD56vZ
 8GM7wIKBn+44A==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9132517E0CD4;
 Wed,  1 Jul 2026 14:19:46 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, justin.yeh@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: [PATCH 2/2] phy: mediatek: Add support for MT8196 MIPI DSI PHY
Date: Wed,  1 Jul 2026 14:19:43 +0200
Message-ID: <20260701121943.19430-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701121943.19430-1-angelogioacchino.delregno@collabora.com>
References: <20260701121943.19430-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add support for the MIPI DSI PHY found in the MediaTek MT8196 SoC
and its variants.
This PHY has a different register layout and provides support for
more hardware features compared to the previous generation.

This initial driver only adds support for basic functionality that
is necessary to drive MIPI DSI displays as a D-PHY.

Feature additions like lane-swap, DPHY/CPHY switching, dual-port,
and others, may be done in the future.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/Makefile                 |   1 +
 .../phy/mediatek/phy-mtk-mipi-dsi-mt8196.c    | 196 ++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c       |   1 +
 drivers/phy/mediatek/phy-mtk-mipi-dsi.h       |   2 +-
 4 files changed, 199 insertions(+), 1 deletion(-)
 create mode 100644 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8196.c

diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
index 1b8088df71e8..ed0da708759b 100644
--- a/drivers/phy/mediatek/Makefile
+++ b/drivers/phy/mediatek/Makefile
@@ -21,4 +21,5 @@ obj-$(CONFIG_PHY_MTK_MIPI_CSI_0_5)	+= phy-mtk-mipi-csi-0-5.o
 phy-mtk-mipi-dsi-drv-y			:= phy-mtk-mipi-dsi.o
 phy-mtk-mipi-dsi-drv-y			+= phy-mtk-mipi-dsi-mt8173.o
 phy-mtk-mipi-dsi-drv-y			+= phy-mtk-mipi-dsi-mt8183.o
+phy-mtk-mipi-dsi-drv-y			+= phy-mtk-mipi-dsi-mt8196.o
 obj-$(CONFIG_PHY_MTK_MIPI_DSI)		+= phy-mtk-mipi-dsi-drv.o
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8196.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8196.c
new file mode 100644
index 000000000000..273f236fa7e9
--- /dev/null
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8196.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Author: jitao.shi <jitao.shi@mediatek.com>
+ *
+ * Copyright (c) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include "phy-mtk-io.h"
+#include "phy-mtk-mipi-dsi.h"
+
+#define MIPITX_LANE_CON		0x0004
+#define RG_DSI_CPHY_T1DRV_EN		BIT(0)
+#define RG_DSI_ANA_CK_SEL		BIT(1)
+#define RG_DSI_PHY_CK_SEL		BIT(2)
+#define RG_DSI_CPHY_EN			BIT(3)
+#define RG_DSI_PHYCK_INV_EN		BIT(4)
+#define RG_DSI_PWR04_EN			BIT(5)
+#define RG_DSI_BG_LPF_EN		BIT(6)
+#define RG_DSI_BG_CORE_EN		BIT(7)
+#define RG_DSI_PAD_TIEL_SEL		BIT(8)
+
+#define MIPITX_VOLTAGE_SEL	0x0008
+#define RG_DSI_HSTX_LDO_REF_SEL		GENMASK(9, 6)
+#define RG_DSI_PRD_REF_SEL		GENMASK(5, 0)
+#define RG_DSI_PRD_REF_MINI		0
+#define RG_DSI_PRD_REF_DEF		4
+#define RG_DSI_PRD_REF_MAX		7
+
+#define MIPITX_PRESERVED	0x000c
+#define MIPITX_PRESERVED_DEF		0xffff0040
+#define MIPITX_PRESERVED_MINI		0xffff00f0
+
+#define MIPITX_PLL_PWR		0x0028
+#define AD_DSI_PLL_SDM_PWR_ON		BIT(0)
+#define AD_DSI_PLL_SDM_ISO_EN		BIT(1)
+#define MIPITX_PLL_CON0		0x002c
+#define MIPITX_PLL_CON1		0x0030
+#define RG_DSI_PLL_EN			BIT(0)
+#define RG_DSI_PLL_POSDIV		GENMASK(10, 8)
+#define MIPITX_PLL_CON2		0x0034
+#define MIPITX_PLL_CON3		0x0038
+#define MIPITX_PLL_CON4		0x003c
+#define RG_DSI_PLL_IBIAS		GENMASK(11, 10)
+
+#define MIPITX_D2_SW_CTL_EN	0x015c
+#define MIPITX_D0_SW_CTL_EN	0x025c
+#define MIPITX_CK_CKMODE_EN	0x0320
+#define DSI_CK_CKMODE_EN		BIT(0)
+#define MIPITX_CK_SW_CTL_EN	0x035c
+#define MIPITX_D1_SW_CTL_EN	0x045c
+#define MIPITX_D3_SW_CTL_EN	0x055c
+#define DSI_SW_CTL_EN			BIT(0)
+
+#define DSI_PHY_XTAL_CLK_HZ		26000000
+
+static int mtk_mipi_tx_pll_enable(struct clk_hw *hw)
+{
+	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
+	void __iomem *base = mipi_tx->regs;
+	u32 voltage = RG_DSI_PRD_REF_MINI;
+	u32 pres = MIPITX_PRESERVED_MINI;
+	unsigned long long pcw_calc;
+	unsigned int txdiv, txdiv0;
+	u32 pcw;
+
+	dev_dbg(mipi_tx->dev, "enable: %u bps\n", mipi_tx->data_rate);
+
+	if (mipi_tx->data_rate >= 2000000000) {
+		/* Select higher signaling voltage for fast data rates */
+		voltage = RG_DSI_PRD_REF_DEF;
+		pres = MIPITX_PRESERVED_DEF;
+		txdiv = 1;
+		txdiv0 = 0;
+	} else if (mipi_tx->data_rate >= 1000000000) {
+		txdiv = 2;
+		txdiv0 = 1;
+	} else if (mipi_tx->data_rate >= 500000000) {
+		txdiv = 4;
+		txdiv0 = 2;
+	} else if (mipi_tx->data_rate > 250000000) {
+		txdiv = 8;
+		txdiv0 = 3;
+	} else if (mipi_tx->data_rate >= 125000000) {
+		txdiv = 16;
+		txdiv0 = 4;
+	} else {
+		return -EINVAL;
+	}
+
+	pcw_calc = ((u64)(mipi_tx->data_rate / 2) * txdiv) << 24;
+	pcw_calc = div_u64(pcw_calc, DSI_PHY_XTAL_CLK_HZ);
+
+	if (pcw_calc > U32_MAX) {
+		dev_err(mipi_tx->dev, "Calculated PCW=%llu overflow!\n", pcw_calc);
+		return -EINVAL;
+	}
+	pcw = (u32)pcw_calc;
+
+	mtk_phy_update_field(base + MIPITX_VOLTAGE_SEL, RG_DSI_PRD_REF_SEL, voltage);
+	writel(pres, base + MIPITX_PRESERVED);
+
+	mtk_phy_set_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
+	mtk_phy_clear_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+	usleep_range(30, 60);
+
+	mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
+	writel(pcw, base + MIPITX_PLL_CON0);
+	mtk_phy_update_field(base + MIPITX_PLL_CON1, RG_DSI_PLL_POSDIV, txdiv0);
+	usleep_range(30, 60);
+
+	mtk_phy_set_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+	usleep_range(30, 60);
+
+	return 0;
+}
+
+static void mtk_mipi_tx_pll_disable(struct clk_hw *hw)
+{
+	struct mtk_mipi_tx *mipi_tx = mtk_mipi_tx_from_clk_hw(hw);
+	void __iomem *base = mipi_tx->regs;
+
+	mtk_phy_clear_bits(base + MIPITX_PLL_CON1, RG_DSI_PLL_EN);
+
+	mtk_phy_set_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_ISO_EN);
+	mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
+}
+
+static int mtk_mipi_tx_pll_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
+{
+	req->rate = clamp_val(req->rate, 125000000, 1600000000);
+
+	return 0;
+}
+
+static const struct clk_ops mtk_mipi_tx_pll_ops = {
+	.enable = mtk_mipi_tx_pll_enable,
+	.disable = mtk_mipi_tx_pll_disable,
+	.determine_rate = mtk_mipi_tx_pll_determine_rate,
+	.set_rate = mtk_mipi_tx_pll_set_rate,
+	.recalc_rate = mtk_mipi_tx_pll_recalc_rate,
+};
+
+static void mtk_mipi_tx_power_on_signal(struct phy *phy)
+{
+	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
+	void __iomem *base = mipi_tx->regs;
+
+	/* BG_LPF_EN / BG_CORE_EN */
+	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN, base + MIPITX_LANE_CON);
+	/* Wait for MIPI core to enable */
+	usleep_range(30, 100);
+	writel(RG_DSI_BG_CORE_EN | RG_DSI_BG_LPF_EN, base + MIPITX_LANE_CON);
+
+	/* Switch OFF each Lane */
+	mtk_phy_clear_bits(base + MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_clear_bits(base + MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
+
+	/*
+	 * The MIPI TX drive strength is in the range of 3000 ~ 6000 microamps:
+	 * RG_DSI_HSTX_LDO_REF_SEL expresses an offset from the minimum drive
+	 * strength (3000uA) and can add a maximum offset of 3000uA, reaching a
+	 * maximum drive strength of 3000+3000=6000uA.
+	 */
+	mtk_phy_update_field(base + MIPITX_VOLTAGE_SEL, RG_DSI_HSTX_LDO_REF_SEL,
+			     (mipi_tx->mipitx_drive - 3000) / 200);
+
+	mtk_phy_set_bits(base + MIPITX_CK_CKMODE_EN, DSI_CK_CKMODE_EN);
+}
+
+static void mtk_mipi_tx_power_off_signal(struct phy *phy)
+{
+	struct mtk_mipi_tx *mipi_tx = phy_get_drvdata(phy);
+	void __iomem *base = mipi_tx->regs;
+
+	/* Switch ON each lane one by one */
+	mtk_phy_set_bits(base + MIPITX_D0_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_D1_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_D2_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_D3_SW_CTL_EN, DSI_SW_CTL_EN);
+	mtk_phy_set_bits(base + MIPITX_CK_SW_CTL_EN, DSI_SW_CTL_EN);
+
+	writel(RG_DSI_PAD_TIEL_SEL | RG_DSI_BG_CORE_EN, base + MIPITX_LANE_CON);
+	writel(RG_DSI_PAD_TIEL_SEL, base + MIPITX_LANE_CON);
+}
+
+const struct mtk_mipitx_data mt8196_mipitx_data = {
+	.mipi_tx_clk_ops = &mtk_mipi_tx_pll_ops,
+	.mipi_tx_enable_signal = mtk_mipi_tx_power_on_signal,
+	.mipi_tx_disable_signal = mtk_mipi_tx_power_off_signal,
+};
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
index 065ea626093a..46f0cb3ac096 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.c
@@ -183,6 +183,7 @@ static const struct of_device_id mtk_mipi_tx_match[] = {
 	{ .compatible = "mediatek,mt2701-mipi-tx", .data = &mt2701_mipitx_data },
 	{ .compatible = "mediatek,mt8173-mipi-tx", .data = &mt8173_mipitx_data },
 	{ .compatible = "mediatek,mt8183-mipi-tx", .data = &mt8183_mipitx_data },
+	{ .compatible = "mediatek,mt8196-mipi-tx", .data = &mt8196_mipitx_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_mipi_tx_match);
diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi.h b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
index 5d4876f1dc95..e6f967078e3b 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi.h
@@ -42,5 +42,5 @@ unsigned long mtk_mipi_tx_pll_recalc_rate(struct clk_hw *hw,
 extern const struct mtk_mipitx_data mt2701_mipitx_data;
 extern const struct mtk_mipitx_data mt8173_mipitx_data;
 extern const struct mtk_mipitx_data mt8183_mipitx_data;
-
+extern const struct mtk_mipitx_data mt8196_mipitx_data;
 #endif
-- 
2.54.0

