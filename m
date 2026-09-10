Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFEAC88E45
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818CD10F3C4;
	Thu, 10 Sep 2026 09:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BuLSpnhj";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F46E10F3BE
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789032047;
 bh=fb+DanSgbv8qny1q3mk0CIt+Vgif5xemCM6o0zZJLEw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BuLSpnhjBo5K/Opk2TBySrsY5TbTmZ8j8F8FOVFACMG8+QxUR/HDC2Os6REBGqaXe
 IaSNNKW9BH3BMWp0wlyrcEly+2zg8FeZ+VyVGMtL/HSDxA2O2QCcZmj3eXDuKqPAlH
 36RtmEvDFsIz/iED2v8FnYJNVuqArjUzLcU4qLqcXxdotQQUkIjWe7xuJLzF+wXVQz
 Ysi2McT940UduhccjOKAFO0+mSjC09miki06ze0Ld5EHvBekuDtEbPqARMbrjcrITS
 zsaCZxmpVHUf5suYd9hxoXbzXeemAoSfyQ0M7fKQQRZZV0fOv7Udc2h4yPKTCm1BDu
 GcuJsXaQzw/6Q==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4F25217E0DA4;
 Thu, 10 Sep 2026 11:20:46 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: mani@kernel.org
Cc: chunfeng.yun@mediatek.com, vkoul@kernel.org, neil.armstrong@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chunkuang.hu@kernel.org, p.zabel@pengutronix.de, justin.yeh@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: [PATCH v4 05/12] phy: phy-mtk-dp: Implement power_on and power_off
 PHY callbacks
Date: Thu, 10 Sep 2026 11:20:31 +0200
Message-ID: <20260910092038.48291-6-angelogioacchino.delregno@collabora.com>
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

Add .power_on() and .power_off() callbacks to mtk_dp_phy_dev_ops
to be able to call those with phy_power_on() and phy_power_off()
API in the DisplayPort driver to be able to stop using all of
those hardcoded register writes in that external driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-dp.c | 68 +++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index 20974650d940..4247506ceb99 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -21,6 +21,9 @@
 
 #define MTK_DP_PHY_MAX_LANES		4
 
+/* DP_PHYA_GLB_FORCE_CTRL_1 */
+#define CKM_CKTX0_EN_FORCE_MODE		BIT(10)
+
 /* DP_PHYD_PLL_CTL_1 */
 #define TPLL_SSC_EN			BIT(3)
 
@@ -38,6 +41,11 @@
 #  define DP_GLB_SW_RST_XTAL_CLK	BIT(2)
 #  define DP_GLB_SW_RST_MAIN_LINK	BIT(3)
 
+/* DP_PHYD_AUX_RX_CTL */
+#define PHYD_DIG_DPAUX_RX_EN		BIT(0)
+#define PHYD_DIG_XTP_GLB_CKDET_EN	BIT(1)
+#define PHYD_DIG_DPAUX_RX_DEGLITCH_EN	BIT(2)
+
 #define DRIVING_PARAM_0_DEFAULT	0x0
 #define DRIVING_PARAM_1_DEFAULT	0x0
 #define DRIVING_PARAM_2_DEFAULT	0x0
@@ -88,6 +96,12 @@
 #define DRIVING_PARAM_8_DEFAULT	(XTP_LN_TX_LCTXCP1_SW2_PRE1_DEFAULT | \
 				 XTP_LN_TX_LCTXCP1_SW3_PRE0_DEFAULT)
 
+enum mtk_dp_phya_ana_glb_regidx {
+	DP_PHYA_GLB_FORCE_CTRL_0,
+	DP_PHYA_GLB_FORCE_CTRL_1,
+	DP_PHYA_GLOBAL_MAX
+};
+
 enum mtk_dp_phyd_dig_lane_regidx {
 	DP_PHYD_LAN_DRIVING_PARAM_0,
 	DP_PHYD_LAN_MAX
@@ -98,9 +112,15 @@ enum mtk_dp_phyd_dig_glb_regidx {
 	DP_PHYD_PLL_CTL_1,
 	DP_PHYD_SW_RST,
 	DP_PHYD_BIT_RATE,
+	DP_PHYD_AUX_RX_CTL,
 	DP_PHYD_GLOBAL_MAX
 };
 
+static const u8 mt8195_phy_ana_glb_regs[DP_PHYA_GLOBAL_MAX] = {
+	[DP_PHYA_GLB_FORCE_CTRL_0] = 0x30,
+	[DP_PHYA_GLB_FORCE_CTRL_1] = 0x34,
+};
+
 static const u8 mt8195_phy_dig_lane_regs[DP_PHYD_LAN_MAX] = {
 	[DP_PHYD_LAN_DRIVING_PARAM_0] = 0x2c,
 };
@@ -110,21 +130,26 @@ static const u8 mt8195_phy_dig_glb_regs[DP_PHYD_GLOBAL_MAX] = {
 	[DP_PHYD_PLL_CTL_1] = 0x14,
 	[DP_PHYD_SW_RST] = 0x38,
 	[DP_PHYD_BIT_RATE] = 0x3c,
+	[DP_PHYD_AUX_RX_CTL] = 0x40,
 };
 
 /**
  * struct mtk_dp_phy_pdata - Platform data and defaults for MediaTek DP/eDP PHY
+ * @off_ana_glb:    Base offset for dptx_phyd_sifslv_ana_glb
  * @off_dig_glb:    Base offset for dptx_phyd_sifslv_dig_glb
  * @off_dig_lane:   Base offsets for dptx_phyd_sifslv_dig_lan (for each lane)
+ * @regs_ana_glb:   Register (layout) offsets for ana_glb
  * @regs_dig_glb:   Register (layout) offsets for dig_glb
  * @regs_dig_lane:  Register (layout) offsets for dig_lan
  */
 struct mtk_dp_phy_pdata {
 	/* Register offsets */
+	u16 off_ana_glb;
 	u16 off_dig_glb;
 	u16 off_dig_lane[MTK_DP_PHY_MAX_LANES];
 
 	/* Register maps */
+	const u8 *regs_ana_glb;
 	const u8 *regs_dig_glb;
 	const u8 *regs_dig_lane;
 };
@@ -208,6 +233,45 @@ static int mtk_dp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
 	return 0;
 }
 
+static int mtk_dp_phy_power_on(struct phy *phy)
+{
+	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
+	const struct mtk_dp_phy_pdata *pdata = dp_phy->pdata;
+	const u8 *regs_dig = pdata->regs_dig_glb;
+	const u8 *regs_ana = pdata->regs_ana_glb;
+
+	/* Enable AUX Channel with RX De-Glitch and input clock detection */
+	regmap_write(dp_phy->regmap,
+		     pdata->off_dig_glb + regs_dig[DP_PHYD_AUX_RX_CTL],
+		     PHYD_DIG_DPAUX_RX_EN |
+		     PHYD_DIG_XTP_GLB_CKDET_EN |
+		     PHYD_DIG_DPAUX_RX_DEGLITCH_EN);
+
+	regmap_clear_bits(dp_phy->regmap,
+			  pdata->off_ana_glb + regs_ana[DP_PHYA_GLB_FORCE_CTRL_1],
+			  CKM_CKTX0_EN_FORCE_MODE);
+
+	return 0;
+}
+
+static int mtk_dp_phy_power_off(struct phy *phy)
+{
+	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
+	const struct mtk_dp_phy_pdata *pdata = dp_phy->pdata;
+	const u8 *regs_dig = pdata->regs_dig_glb;
+	const u8 *regs_ana = pdata->regs_ana_glb;
+
+	regmap_set_bits(dp_phy->regmap,
+			pdata->off_ana_glb + regs_ana[DP_PHYA_GLB_FORCE_CTRL_1],
+			CKM_CKTX0_EN_FORCE_MODE);
+
+	/* Disable RX unconditionally */
+	regmap_write(dp_phy->regmap,
+		     pdata->off_dig_glb + regs_dig[DP_PHYD_AUX_RX_CTL], 0);
+
+	return 0;
+}
+
 static int mtk_dp_phy_reset(struct phy *phy)
 {
 	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
@@ -228,6 +292,8 @@ static int mtk_dp_phy_reset(struct phy *phy)
 
 static const struct phy_ops mtk_dp_phy_dev_ops = {
 	.init = mtk_dp_phy_init,
+	.power_on = mtk_dp_phy_power_on,
+	.power_off = mtk_dp_phy_power_off,
 	.configure = mtk_dp_phy_configure,
 	.reset = mtk_dp_phy_reset,
 	.owner = THIS_MODULE,
@@ -330,8 +396,10 @@ static int mtk_dp_phy_probe(struct platform_device *pdev)
 }
 
 static const struct mtk_dp_phy_pdata mt8195_dp_phy_data = {
+	.off_ana_glb = 0x0,
 	.off_dig_glb = 0x1000,
 	.off_dig_lane = (const u16[]) { 0x1100, 0x1200, 0x1300, 0x1400 },
+	.regs_ana_glb = mt8195_phy_ana_glb_regs,
 	.regs_dig_glb = mt8195_phy_dig_glb_regs,
 	.regs_dig_lane = mt8195_phy_dig_lane_regs,
 };
-- 
2.55.0

