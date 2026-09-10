Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF4EC88E4C
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:21:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1714110F3C9;
	Thu, 10 Sep 2026 09:20:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Ca8DBvRt";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05B0F10F3BB
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789032048;
 bh=WTVMQxnGADESJuhn7zz/Hiaj/YXUMi4pSU91iU+djqM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ca8DBvRtV5wXcgzxRYPqpbUIYFRrzQyL9gkw+mu+feBFiW+VwC6OzzykVpUxiJVmU
 0MTHmH6sohdxtH6C1J+QPl9v56kCMQgfki4MDJBFxCy04ByCxOfTLPACtouet0QXm8
 vxUQkjWpei+nt8cR+Xa4POxfAmmNVZL4XuLR7bdRmD6I83V8LZ44w3hwS/AepKLQkY
 /R411VgA3vO0VG+b4WVRbf3aRBBK5Zrmn8mViVTwhujZsIsAzV2ch4d6EGphVYjgjK
 jmkFmRcjRzxoKHolBe46AHfMSJpE3qfHokSXdaAhaFomzvISKOn5SeCe8GSh67stGx
 nK+33VNovo+/g==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0F55617E124A;
 Thu, 10 Sep 2026 11:20:48 +0200 (CEST)
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
Subject: [PATCH v4 07/12] phy: phy-mtk-dp: Support setting volt swing and
 preemphasis values
Date: Thu, 10 Sep 2026 11:20:33 +0200
Message-ID: <20260910092038.48291-8-angelogioacchino.delregno@collabora.com>
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

Add support for honoring the set_voltages request to set the
voltage swing and preemphasis values in the .configure() callback.

For proper hardware cleanup, reset both in the .reset() callback.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-dp.c | 44 ++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index 276391d991aa..692049f78833 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -54,6 +54,11 @@
 /* DP_PHYD_TX_CTL_0 */
 #define PHYD_TX_LN_EN			GENMASK(7, 4)
 
+/* DP_PHYD_DRIVING_FORCE */
+#define PHYD_DP_TX_FORCE_VOLT_SWING_EN	BIT(0)
+#define PHYD_DP_TX_FORCE_VOLT_SWING_VAL	GENMASK(2, 1)
+#define PHYD_DP_TX_FORCE_PRE_EMPH_VAL	GENMASK(4, 3)
+
 #define XTP_LN_TX_LCTXC0_SW0_PRE0_DEFAULT	BIT(4)
 #define XTP_LN_TX_LCTXC0_SW0_PRE1_DEFAULT	(BIT(10) | BIT(12))
 #define XTP_LN_TX_LCTXC0_SW0_PRE2_DEFAULT	GENMASK(20, 19)
@@ -107,6 +112,7 @@ enum mtk_dp_phya_ana_glb_regidx {
 };
 
 enum mtk_dp_phyd_dig_lane_regidx {
+	DP_PHYD_LAN_DRIVING_FORCE,
 	DP_PHYD_LAN_DRIVING_PARAM_0,
 	DP_PHYD_LAN_MAX
 };
@@ -127,6 +133,7 @@ static const u8 mt8195_phy_ana_glb_regs[DP_PHYA_GLOBAL_MAX] = {
 };
 
 static const u8 mt8195_phy_dig_lane_regs[DP_PHYD_LAN_MAX] = {
+	[DP_PHYD_LAN_DRIVING_FORCE] = 0x18,
 	[DP_PHYD_LAN_DRIVING_PARAM_0] = 0x2c,
 };
 
@@ -244,6 +251,30 @@ static int mtk_dp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
 				   PHYD_TX_LN_EN, val);
 	}
 
+	if (opts->dp.set_voltages) {
+		const u32 reg_drv_force = pdata->regs_dig_lane[DP_PHYD_LAN_DRIVING_FORCE];
+
+		if (opts->dp.lanes > 4) {
+			dev_err(&phy->dev, "Wrong lanes config %u\n", opts->dp.lanes);
+			return -EINVAL;
+		}
+
+		for (i = 0; i < opts->dp.lanes; i++) {
+			const u32 off_dig_lane = pdata->off_dig_lane[i];
+			u32 val;
+
+			val = FIELD_PREP(PHYD_DP_TX_FORCE_VOLT_SWING_VAL, opts->dp.voltage[i]);
+			val |= FIELD_PREP(PHYD_DP_TX_FORCE_PRE_EMPH_VAL, opts->dp.pre[i]);
+			val |= PHYD_DP_TX_FORCE_VOLT_SWING_EN;
+
+			regmap_update_bits(dp_phy->regmap, off_dig_lane + reg_drv_force,
+					   PHYD_DP_TX_FORCE_VOLT_SWING_EN |
+					   PHYD_DP_TX_FORCE_VOLT_SWING_VAL |
+					   PHYD_DP_TX_FORCE_PRE_EMPH_VAL,
+					   val);
+		}
+	}
+
 	regmap_update_bits(dp_phy->regmap,
 			   pdata->off_dig_glb + pdata->regs_dig_glb[DP_PHYD_PLL_CTL_1],
 			   TPLL_SSC_EN, opts->dp.ssc ? TPLL_SSC_EN : 0);
@@ -328,7 +359,8 @@ static int mtk_dp_phy_reset(struct phy *phy)
 	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
 	const struct mtk_dp_phy_pdata *pdata = dp_phy->pdata;
 	const u32 reg_rst = pdata->regs_dig_glb[DP_PHYD_SW_RST];
-	int ret;
+	const u32 reg_drv_force = pdata->regs_dig_lane[DP_PHYD_LAN_DRIVING_FORCE];
+	int i, ret;
 
 	/* Clearing bits sets reset state */
 	regmap_clear_bits(dp_phy->regmap, pdata->off_dig_glb + reg_rst, DP_GLB_SW_RST_PHYD);
@@ -344,6 +376,16 @@ static int mtk_dp_phy_reset(struct phy *phy)
 	if (ret)
 		dev_err(dp_phy->dev, "Could not disable lanes during reset!\n");
 
+	/* Reset Voltage Swing and Preemphasis values */
+	for (i = 0; i < MTK_DP_PHY_MAX_LANES; i++) {
+		const u32 off_dig_lane = pdata->off_dig_lane[i];
+
+		regmap_clear_bits(dp_phy->regmap, off_dig_lane + reg_drv_force,
+				   PHYD_DP_TX_FORCE_VOLT_SWING_EN |
+				   PHYD_DP_TX_FORCE_VOLT_SWING_VAL |
+				   PHYD_DP_TX_FORCE_PRE_EMPH_VAL);
+	}
+
 	return 0;
 }
 
-- 
2.55.0

