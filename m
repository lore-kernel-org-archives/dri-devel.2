Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606F8C88E42
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:20:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D16210F3C1;
	Thu, 10 Sep 2026 09:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EM7Ivvod";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FDF210F3BD
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789032046;
 bh=GaPBiWzQJR3OEHQxJ/VaePgCeu6QCU+D2EOPr8uRypk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EM7IvvodYXwFiu+ynHQZRxAgoWSEfsXTpN0h52mWBliPpN/REgcqH6KIprI3knbBq
 6oywYLTajMP+o/Q97ark6OBOkrXKON6n2Jgg+TUqrJ//qca7d/LghWZ3DmIInmE3lK
 nwNSzdynNTM1T76OHDPP3jg1Z/ls6g/VMo2TqaLlIFNQH3TZrQ+kmGKOYVZQ4+nSX2
 AHbmO38EDheOt4isvnuu3Mb65+k1wyfPdfnEfyFigED2K672MdxnnNLtyaLEFCuubc
 r4zP5ZsgcobShyDJLwugGePm3kBVF0yXLHCfIMZqRUeuZkDFF9I1HVDIxYHHRHQXCK
 SXKs2D+8YgrzQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6697217E0D84;
 Thu, 10 Sep 2026 11:20:45 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: mani@kernel.org
Cc: chunfeng.yun@mediatek.com, vkoul@kernel.org, neil.armstrong@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chunkuang.hu@kernel.org, p.zabel@pengutronix.de, justin.yeh@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v4 04/12] phy: phy-mtk-dp: Migrate register offsets to SoC
 specific pdata
Date: Thu, 10 Sep 2026 11:20:30 +0200
Message-ID: <20260910092038.48291-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
References: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
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

In preparation for adding support for newer SoCs and for adding
more capabilities to this driver in an efficient manner, migrate
all of the hardcoded register offsets to SoC specific pdata and
assign that for both DT and platform probing.

While at it also cleanup writing the driving parameters to the PHY
by iterating through all lanes with a loop instead: note that for
that to happen the default 0/1/2 driving parameters were added,
those are really just zero.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-dp.c | 145 ++++++++++++++++++++++++------
 1 file changed, 116 insertions(+), 29 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index d241004e2828..20974650d940 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -4,6 +4,10 @@
  *
  * Copyright (c) 2022, BayLibre Inc.
  * Copyright (c) 2022, MediaTek Inc.
+ *
+ * Major refactoring
+ * Copyright (c) 2026, Collabora Ltd.
+ *                     AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  */
 
 #include <linux/delay.h>
@@ -15,24 +19,29 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
-#define PHY_OFFSET			0x1000
+#define MTK_DP_PHY_MAX_LANES		4
 
-#define MTK_DP_PHY_DIG_PLL_CTL_1	(PHY_OFFSET + 0x14)
+/* DP_PHYD_PLL_CTL_1 */
 #define TPLL_SSC_EN			BIT(3)
 
-#define MTK_DP_PHY_DIG_BIT_RATE		(PHY_OFFSET + 0x3C)
-#define BIT_RATE_RBR			0
-#define BIT_RATE_HBR			1
-#define BIT_RATE_HBR2			2
-#define BIT_RATE_HBR3			3
+/* DP_PHYD_BIT_RATE */
+#define PHYD_DIG_RG_BIT_RATE		GENMASK(1, 0)
+#  define BIT_RATE_RBR			0
+#  define BIT_RATE_HBR			1
+#  define BIT_RATE_HBR2			2
+#  define BIT_RATE_HBR3			3
+
+/* DP_PHYD_SW_RST */
+#define PHYD_DIG_GLB_SW_RST_B		GENMASK(7, 0)
+#  define DP_GLB_SW_RST_PHYD		BIT(0)
+#  define DP_GLB_SW_RST_TFIFO_ANA	BIT(1)
+#  define DP_GLB_SW_RST_XTAL_CLK	BIT(2)
+#  define DP_GLB_SW_RST_MAIN_LINK	BIT(3)
 
-#define MTK_DP_PHY_DIG_SW_RST		(PHY_OFFSET + 0x38)
-#define DP_GLB_SW_RST_PHYD		BIT(0)
+#define DRIVING_PARAM_0_DEFAULT	0x0
+#define DRIVING_PARAM_1_DEFAULT	0x0
+#define DRIVING_PARAM_2_DEFAULT	0x0
 
-#define MTK_DP_LANE0_DRIVING_PARAM_3		(PHY_OFFSET + 0x138)
-#define MTK_DP_LANE1_DRIVING_PARAM_3		(PHY_OFFSET + 0x238)
-#define MTK_DP_LANE2_DRIVING_PARAM_3		(PHY_OFFSET + 0x338)
-#define MTK_DP_LANE3_DRIVING_PARAM_3		(PHY_OFFSET + 0x438)
 #define XTP_LN_TX_LCTXC0_SW0_PRE0_DEFAULT	BIT(4)
 #define XTP_LN_TX_LCTXC0_SW0_PRE1_DEFAULT	(BIT(10) | BIT(12))
 #define XTP_LN_TX_LCTXC0_SW0_PRE2_DEFAULT	GENMASK(20, 19)
@@ -79,15 +88,62 @@
 #define DRIVING_PARAM_8_DEFAULT	(XTP_LN_TX_LCTXCP1_SW2_PRE1_DEFAULT | \
 				 XTP_LN_TX_LCTXCP1_SW3_PRE0_DEFAULT)
 
+enum mtk_dp_phyd_dig_lane_regidx {
+	DP_PHYD_LAN_DRIVING_PARAM_0,
+	DP_PHYD_LAN_MAX
+};
+
+enum mtk_dp_phyd_dig_glb_regidx {
+	DP_PHYD_PLL_CTL_0,
+	DP_PHYD_PLL_CTL_1,
+	DP_PHYD_SW_RST,
+	DP_PHYD_BIT_RATE,
+	DP_PHYD_GLOBAL_MAX
+};
+
+static const u8 mt8195_phy_dig_lane_regs[DP_PHYD_LAN_MAX] = {
+	[DP_PHYD_LAN_DRIVING_PARAM_0] = 0x2c,
+};
+
+static const u8 mt8195_phy_dig_glb_regs[DP_PHYD_GLOBAL_MAX] = {
+	[DP_PHYD_PLL_CTL_0] = 0x10,
+	[DP_PHYD_PLL_CTL_1] = 0x14,
+	[DP_PHYD_SW_RST] = 0x38,
+	[DP_PHYD_BIT_RATE] = 0x3c,
+};
+
+/**
+ * struct mtk_dp_phy_pdata - Platform data and defaults for MediaTek DP/eDP PHY
+ * @off_dig_glb:    Base offset for dptx_phyd_sifslv_dig_glb
+ * @off_dig_lane:   Base offsets for dptx_phyd_sifslv_dig_lan (for each lane)
+ * @regs_dig_glb:   Register (layout) offsets for dig_glb
+ * @regs_dig_lane:  Register (layout) offsets for dig_lan
+ */
+struct mtk_dp_phy_pdata {
+	/* Register offsets */
+	u16 off_dig_glb;
+	u16 off_dig_lane[MTK_DP_PHY_MAX_LANES];
+
+	/* Register maps */
+	const u8 *regs_dig_glb;
+	const u8 *regs_dig_lane;
+};
+
 struct mtk_dp_phy {
 	struct device *dev;
 	struct regmap *regmap;
+	const struct mtk_dp_phy_pdata *pdata;
 };
 
 static int mtk_dp_phy_init(struct phy *phy)
 {
 	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
+	const struct mtk_dp_phy_pdata *pdata = dp_phy->pdata;
+	const u32 reg = pdata->regs_dig_lane[DP_PHYD_LAN_DRIVING_PARAM_0];
 	static const u32 driving_params[] = {
+		DRIVING_PARAM_0_DEFAULT,
+		DRIVING_PARAM_1_DEFAULT,
+		DRIVING_PARAM_2_DEFAULT,
 		DRIVING_PARAM_3_DEFAULT,
 		DRIVING_PARAM_4_DEFAULT,
 		DRIVING_PARAM_5_DEFAULT,
@@ -95,15 +151,21 @@ static int mtk_dp_phy_init(struct phy *phy)
 		DRIVING_PARAM_7_DEFAULT,
 		DRIVING_PARAM_8_DEFAULT
 	};
-
-	regmap_bulk_write(dp_phy->regmap, MTK_DP_LANE0_DRIVING_PARAM_3,
-			  driving_params, ARRAY_SIZE(driving_params));
-	regmap_bulk_write(dp_phy->regmap, MTK_DP_LANE1_DRIVING_PARAM_3,
-			  driving_params, ARRAY_SIZE(driving_params));
-	regmap_bulk_write(dp_phy->regmap, MTK_DP_LANE2_DRIVING_PARAM_3,
-			  driving_params, ARRAY_SIZE(driving_params));
-	regmap_bulk_write(dp_phy->regmap, MTK_DP_LANE3_DRIVING_PARAM_3,
-			  driving_params, ARRAY_SIZE(driving_params));
+	int i, ret;
+
+	/*
+	 * Assume that all lanes need the same driving parameters: this
+	 * will bulk write from DRIVING_PARAM_0 to DRIVING_PARAM_8 on
+	 * all lanes (a grand total of [9 * num_lanes] 32-bit writes)
+	 */
+	for (i = 0; i < MTK_DP_PHY_MAX_LANES; i++) {
+		ret = regmap_bulk_write(dp_phy->regmap,
+					pdata->off_dig_lane[i] + reg,
+					driving_params,
+					ARRAY_SIZE(driving_params));
+		if (ret)
+			return ret;
+	};
 
 	return 0;
 }
@@ -111,9 +173,12 @@ static int mtk_dp_phy_init(struct phy *phy)
 static int mtk_dp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
 {
 	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
+	const struct mtk_dp_phy_pdata *pdata = dp_phy->pdata;
 	u32 val;
 
 	if (opts->dp.set_rate) {
+		const u32 reg_bit_rate = pdata->regs_dig_glb[DP_PHYD_BIT_RATE];
+
 		switch (opts->dp.link_rate) {
 		default:
 			dev_err(&phy->dev,
@@ -133,10 +198,11 @@ static int mtk_dp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
 			val = BIT_RATE_HBR3;
 			break;
 		}
-		regmap_write(dp_phy->regmap, MTK_DP_PHY_DIG_BIT_RATE, val);
+		regmap_write(dp_phy->regmap, pdata->off_dig_glb + reg_bit_rate, val);
 	}
 
-	regmap_update_bits(dp_phy->regmap, MTK_DP_PHY_DIG_PLL_CTL_1,
+	regmap_update_bits(dp_phy->regmap,
+			   pdata->off_dig_glb + pdata->regs_dig_glb[DP_PHYD_PLL_CTL_1],
 			   TPLL_SSC_EN, opts->dp.ssc ? TPLL_SSC_EN : 0);
 
 	return 0;
@@ -145,12 +211,17 @@ static int mtk_dp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
 static int mtk_dp_phy_reset(struct phy *phy)
 {
 	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
+	const struct mtk_dp_phy_pdata *pdata = dp_phy->pdata;
+	const u32 reg_rst = pdata->regs_dig_glb[DP_PHYD_SW_RST];
+
+	/* Clearing bits sets reset state */
+	regmap_clear_bits(dp_phy->regmap, pdata->off_dig_glb + reg_rst, DP_GLB_SW_RST_PHYD);
 
-	regmap_update_bits(dp_phy->regmap, MTK_DP_PHY_DIG_SW_RST,
-			   DP_GLB_SW_RST_PHYD, 0);
+	/* PHYD needs 50uS to guarantee reset done */
 	usleep_range(50, 200);
-	regmap_update_bits(dp_phy->regmap, MTK_DP_PHY_DIG_SW_RST,
-			   DP_GLB_SW_RST_PHYD, 1);
+
+	/* Setting bits means go out of reset */
+	regmap_set_bits(dp_phy->regmap, pdata->off_dig_glb + reg_rst, DP_GLB_SW_RST_PHYD);
 
 	return 0;
 }
@@ -170,12 +241,19 @@ static void mtk_dp_phy_legacy_remove_lookup(void *data)
 	phy_remove_lookup(phy, "dp", dev_name(dp_phy->dev));
 }
 
+static const struct mtk_dp_phy_pdata mt8195_dp_phy_data;
+
 static int mtk_dp_phy_legacy_probe(struct platform_device *pdev, struct mtk_dp_phy *dp_phy)
 {
 	struct device *dev = &pdev->dev;
 	struct phy *phy;
 	int ret;
 
+	/*
+	 * If legacy platform driver probe, assume this is MT8195 or compatible
+	 * with a devicetree that was not migrated to the new, proper bindings.
+	 */
+	dp_phy->pdata = &mt8195_dp_phy_data;
 	dp_phy->regmap = *(struct regmap **)dev->platform_data;
 	if (!dp_phy->regmap)
 		return dev_err_probe(dev, -EINVAL, "No platform data available\n");
@@ -235,6 +313,8 @@ static int mtk_dp_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	dp_phy->pdata = device_get_match_data(dev);
+
 	phy = devm_phy_create(dev, NULL, &mtk_dp_phy_dev_ops);
 	if (IS_ERR(phy))
 		return dev_err_probe(dev, PTR_ERR(phy),
@@ -249,8 +329,15 @@ static int mtk_dp_phy_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct mtk_dp_phy_pdata mt8195_dp_phy_data = {
+	.off_dig_glb = 0x1000,
+	.off_dig_lane = (const u16[]) { 0x1100, 0x1200, 0x1300, 0x1400 },
+	.regs_dig_glb = mt8195_phy_dig_glb_regs,
+	.regs_dig_lane = mt8195_phy_dig_lane_regs,
+};
+
 static const struct of_device_id mtk_dp_phy_of_match[] = {
-	{ .compatible = "mediatek,mt8195-dp-phy" },
+	{ .compatible = "mediatek,mt8195-dp-phy", .data = &mt8195_dp_phy_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_dp_phy_of_match);
-- 
2.55.0

