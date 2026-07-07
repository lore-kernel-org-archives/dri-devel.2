Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46E4C44502
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E8C10ED9D;
	Tue,  7 Jul 2026 14:20:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gAYBUVS5";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D41F10ED99
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783433990;
 bh=1mFwOiUnJoBtpdzPigcW8ucCsQx6xBaelg4YAbDZAJw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gAYBUVS5YAHxL44NpBbw6lJESG2MwC+fA1bhwtE4X8RoSiQzZ1kNWUAOXATS7sp9z
 ME4SsMDnDv9QWmWnDIw0z9qWhmAGEbHhygDwoMW+5rcInMHS9sOM1cRV5rF2NLS39K
 YwAsqMOaLWllP8B8JW60RadNMXDfuDDRpYGBfro4i5rUN3wWJoSEwm+8VIlR9nZfid
 XX8hbHDZaWOWfPBduDpCXQWPPZAZA0+0ScrvS/bsnmeUc9tDuSuaUV5sf8Eufwc3yD
 b6G3W88qtXEurUpzvGTds6vRttS1mQOLi0VrvBzXJBHX5hBk2pdtCZ54jB6sp0sX3b
 tn1pMR2uwkDOA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5B3BB17E0076;
 Tue, 07 Jul 2026 16:19:49 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, justin.yeh@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: [PATCH v2 10/12] phy: phy-mtk-dp: Add bitrate register val
 definitions to SoC data
Date: Tue,  7 Jul 2026 16:19:29 +0200
Message-ID: <20260707141931.191172-11-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707141931.191172-1-angelogioacchino.delregno@collabora.com>
References: <20260707141931.191172-1-angelogioacchino.delregno@collabora.com>
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

In preparation for adding support for the eDP PHY found in newer
SoCs, transfer the bitrate register value definitions to SoC
specific data.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-dp.c | 36 +++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index 9a800d6b91c3..8ac086360138 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -42,10 +42,6 @@
 
 /* DP_PHYD_BIT_RATE */
 #define PHYD_DIG_RG_BIT_RATE		GENMASK(1, 0)
-#  define BIT_RATE_RBR			0
-#  define BIT_RATE_HBR			1
-#  define BIT_RATE_HBR2			2
-#  define BIT_RATE_HBR3			3
 
 /* DP_PHYD_SW_RST */
 #define PHYD_DIG_GLB_SW_RST_B		GENMASK(7, 0)
@@ -157,6 +153,14 @@ enum mtk_dp_phyd_dig_glb_regidx {
 	DP_PHYD_GLOBAL_MAX
 };
 
+enum mtk_dp_phyd_bit_rate_regval {
+	DP_PHYD_BIT_RATE_RBR,
+	DP_PHYD_BIT_RATE_HBR,
+	DP_PHYD_BIT_RATE_HBR2,
+	DP_PHYD_BIT_RATE_HBR3,
+	DP_PHYD_BIT_RATE_MAX,
+};
+
 static const u8 mt8195_phy_ana_glb_regs[DP_PHYA_GLOBAL_MAX] = {
 	[DP_PHYA_GLB_BIAS_GEN_0] = 0x0,
 	[DP_PHYA_GLB_BIAS_GEN_1] = 0x4,
@@ -183,6 +187,13 @@ static const u8 mt8195_phy_dig_glb_regs[DP_PHYD_GLOBAL_MAX] = {
 	[DP_PHYD_TX_CTL_0] = 0x44,
 };
 
+static const u8 mt8195_phy_dig_bitrate_val[DP_PHYD_BIT_RATE_MAX] = {
+	[DP_PHYD_BIT_RATE_RBR] = 0,
+	[DP_PHYD_BIT_RATE_HBR] = 1,
+	[DP_PHYD_BIT_RATE_HBR2] = 2,
+	[DP_PHYD_BIT_RATE_HBR3] = 3
+};
+
 /**
  * struct mtk_dp_phya_imp_sel - Per-Lane Impedance Selection
  * @pmos: Impedance selection for P-Channel MOSFET
@@ -203,6 +214,7 @@ struct mtk_dp_phya_imp_sel {
  * @regs_ana_lane:  Register (layout) offsets for ana_lan
  * @regs_dig_glb:   Register (layout) offsets for dig_glb
  * @regs_dig_lane:  Register (layout) offsets for dig_lan
+ * @val_dig_bitrate:IP Version specific register values for Bit Rate setting
  * @ana_bias_r:     Internal resistance "R" Selection Settings (global)
  * @ana_cktx_imp:   TX Clock Impedance Selection Settings (global)
  * @ana_lanes_imp:  TX Impedance Selection Settings (for all lanes)
@@ -221,6 +233,9 @@ struct mtk_dp_phy_pdata {
 	const u8 *regs_dig_glb;
 	const u8 *regs_dig_lane;
 
+	/* IP-Version specific register value arrays */
+	const u8 *val_dig_bitrate;
+
 	/* Calibration defaults */
 	u8 ana_bias_r;
 	u8 ana_cktx_imp;
@@ -326,6 +341,7 @@ static int mtk_dp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
 
 	if (opts->dp.set_rate) {
 		const u32 reg_bit_rate = pdata->regs_dig_glb[DP_PHYD_BIT_RATE];
+		enum mtk_dp_phyd_bit_rate_regval regval_idx;
 
 		switch (opts->dp.link_rate) {
 		default:
@@ -334,19 +350,20 @@ static int mtk_dp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
 				opts->dp.link_rate);
 			return -EINVAL;
 		case 1620:
-			val = BIT_RATE_RBR;
+			regval_idx = DP_PHYD_BIT_RATE_RBR;
 			break;
 		case 2700:
-			val = BIT_RATE_HBR;
+			regval_idx = DP_PHYD_BIT_RATE_HBR;
 			break;
 		case 5400:
-			val = BIT_RATE_HBR2;
+			regval_idx = DP_PHYD_BIT_RATE_HBR2;
 			break;
 		case 8100:
-			val = BIT_RATE_HBR3;
+			regval_idx = DP_PHYD_BIT_RATE_HBR3;
 			break;
 		}
-		regmap_write(dp_phy->regmap, pdata->off_dig_glb + reg_bit_rate, val);
+		regmap_write(dp_phy->regmap, pdata->off_dig_glb + reg_bit_rate,
+			     pdata->val_dig_bitrate[regval_idx]);
 	}
 
 	if (opts->dp.set_lanes) {
@@ -744,6 +761,7 @@ static const struct mtk_dp_phy_pdata mt8195_dp_phy_data = {
 	.regs_ana_lane = mt8195_phy_ana_lane_regs,
 	.regs_dig_glb = mt8195_phy_dig_glb_regs,
 	.regs_dig_lane = mt8195_phy_dig_lane_regs,
+	.val_dig_bitrate = mt8195_phy_dig_bitrate_val,
 	.ana_bias_r = 15,
 	.ana_cktx_imp = 8,
 	.ana_lanes_imp = {
-- 
2.54.0

