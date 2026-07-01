Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F008C44503
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B334B10EF42;
	Wed,  1 Jul 2026 12:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WV9dC6NL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D204410EF42
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908433;
 bh=MLc0kWNMV4tVyc59kPBBxZjsT5YZB/hM41omMFL2IN4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WV9dC6NL4yAOPy0y8vqk0QQ+RLHiVCukPG3YEGZq2I1b/bqz78QrG6slAG0dv+iR7
 BUHctEbHhHI5eZNOnaF3m1XWzWhGy88ZbjcMu8EejnMhfO40EUyrUhs1LIg3wEgkPP
 XWXFu9BUR1i8Wx9VwxwkXKhXFZ6/0tgEmh9ldOSgS5mcREVlviSgL3OSq2zBJlAGwu
 p1NbyLMWA+kpXgRd8YnHvPf3DhckEJUDCpQJ02wVd1+jKjA484wpCszLnVP3BXDvzz
 aWJAVwZbc++p6nTtBwV//VLemV3BzjMrXekESWy+AwC0LhngAkUo3tZ1L9BUiGveKV
 /b0yKBTdpODmQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E288C17E1553;
 Wed,  1 Jul 2026 14:20:31 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 jitao.shi@mediatek.com, granquet@baylibre.com, rex-bc.chen@mediatek.com,
 dmitry.osipenko@collabora.com, ck.hu@mediatek.com, amergnat@baylibre.com,
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 05/11] drm/mediatek: mtk_dp: Rework register offsets for
 proper PHY usage
Date: Wed,  1 Jul 2026 14:20:18 +0200
Message-ID: <20260701122024.19557-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701122024.19557-1-angelogioacchino.delregno@collabora.com>
References: <20260701122024.19557-1-angelogioacchino.delregno@collabora.com>
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

Rework all of the register offsets to subtract the DP PHY register
range from the MediaTek DisplayPort IP register range which starts
from TOP_OFFSET instead.

This is done in preparation for adding support for registering the
PHY from devicetree, and also for properly handling PHY registers
in the PHY driver (instead of half and half...), which is also one
prerogative to add support for new IP versions in the future.

Note that the current regmap_config was renamed to make sure that
it being legacy is mentioned, as a new config will be required in
future changes.

Of course, with the TOP offset being related to hardware registers
this will never change for the currently supported SoCs, hence for
simplifying code, the MTK_DP_TOP_OFFSET_LEGACY is added statically
to the legacy regmap configuration while, on the other hand, it is
added dynamically to the mtk_dp structure, as the latter is used
to add an offset to every register write in the mtk_dp driver.

The regmap_config provided reg_base (which does exactly the same)
cannot be used here, because the PHY driver is using the very same
regmap pointer, and the offset shall not be taken into account in
writes performed by the PHY driver (only ones performed by mtk_dp!).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c     |  60 ++++--
 drivers/gpu/drm/mediatek/mtk_dp_reg.h | 255 ++++++++++++--------------
 2 files changed, 164 insertions(+), 151 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index f551c4543f4e..97bce8966a1f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -35,6 +35,27 @@
 
 #include "mtk_dp_reg.h"
 
+/* PHY Registers - for legacy only */
+#define DP_PHY_GLB_BIAS_GEN_00		0x0
+#  define RG_XTP_GLB_BIAS_INTR_CTRL	GENMASK(20, 16)
+#define DP_PHY_GLB_DPAUX_TX		0x8
+#  define RG_CKM_PT0_CKTX_IMPSEL	GENMASK(23, 20)
+#define MTK_DP_0034			0x34
+#  define DA_CKM_CKTX0_EN_FORCE_EN	BIT(10)
+#define DP_PHY_LANE_TX_0		0x104
+#define DP_PHY_LANE_TX_1		0x204
+#define DP_PHY_LANE_TX_2		0x304
+#define DP_PHY_LANE_TX_3		0x404
+#  define RG_XTP_LNx_TX_IMPSEL_PMOS	GENMASK(15, 12)
+#  define RG_XTP_LNx_TX_IMPSEL_NMOS	GENMASK(19, 16)
+#define DP_PHY_AUX_RX_CTL		0x1040
+#  define RG_DPAUX_RX_VALID_DEGLITCH_EN	BIT(2)
+#  define RG_XTP_GLB_CKDET_EN		BIT(1)
+#  define RG_DPAUX_RX_EN		BIT(0)
+
+/* TOP Register offset - for legacy only */
+#define MTK_DP_TOP_OFFSET_LEGACY	0x2000
+
 #define MTK_DP_SIP_CONTROL_AARCH32	MTK_SIP_SMC_CMD(0x523)
 #define MTK_DP_SIP_ATF_EDP_VIDEO_UNMUTE	33
 #define MTK_DP_SIP_ATF_VIDEO_UNMUTE	32
@@ -126,6 +147,9 @@ struct mtk_dp {
 	struct regmap *regs;
 	struct timer_list debounce_timer;
 
+	/* For legacy devicetree compatibility */
+	u16 legacy_regoff;
+
 	/* For audio */
 	bool audio_enable;
 	hdmi_codec_plugged_cb plugged_cb;
@@ -394,11 +418,11 @@ static const struct mtk_dp_efuse_fmt mt8195_dp_efuse_fmt[MTK_DP_CAL_MAX] = {
 	},
 };
 
-static const struct regmap_config mtk_dp_regmap_config = {
+static const struct regmap_config mtk_dp_regmap_legacy_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.max_register = SEC_OFFSET + 0x90,
+	.max_register = MTK_DP_TOP_OFFSET_LEGACY + SEC_OFFSET + 0x90,
 	.name = "mtk-dp-registers",
 };
 
@@ -412,7 +436,7 @@ static u32 mtk_dp_read(struct mtk_dp *mtk_dp, u32 offset)
 	u32 read_val;
 	int ret;
 
-	ret = regmap_read(mtk_dp->regs, offset, &read_val);
+	ret = regmap_read(mtk_dp->regs, offset + mtk_dp->legacy_regoff, &read_val);
 	if (ret) {
 		dev_err(mtk_dp->dev, "Failed to read register 0x%x: %d\n",
 			offset, ret);
@@ -424,7 +448,7 @@ static u32 mtk_dp_read(struct mtk_dp *mtk_dp, u32 offset)
 
 static int mtk_dp_write(struct mtk_dp *mtk_dp, u32 offset, u32 val)
 {
-	int ret = regmap_write(mtk_dp->regs, offset, val);
+	int ret = regmap_write(mtk_dp->regs, offset + mtk_dp->legacy_regoff, val);
 
 	if (ret)
 		dev_err(mtk_dp->dev,
@@ -436,7 +460,7 @@ static int mtk_dp_write(struct mtk_dp *mtk_dp, u32 offset, u32 val)
 static int mtk_dp_update_bits(struct mtk_dp *mtk_dp, u32 offset,
 			      u32 val, u32 mask)
 {
-	int ret = regmap_update_bits(mtk_dp->regs, offset, mask, val);
+	int ret = regmap_update_bits(mtk_dp->regs, offset + mtk_dp->legacy_regoff, mask, val);
 
 	if (ret)
 		dev_err(mtk_dp->dev,
@@ -1229,28 +1253,28 @@ static void mtk_dp_set_calibration_data(struct mtk_dp *mtk_dp)
 			   RG_XTP_GLB_BIAS_INTR_CTRL);
 	mtk_dp_update_bits(mtk_dp, DP_PHY_LANE_TX_0,
 			   cal_data[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_0] << 12,
-			   RG_XTP_LN0_TX_IMPSEL_PMOS);
+			   RG_XTP_LNx_TX_IMPSEL_PMOS);
 	mtk_dp_update_bits(mtk_dp, DP_PHY_LANE_TX_0,
 			   cal_data[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_0] << 16,
-			   RG_XTP_LN0_TX_IMPSEL_NMOS);
+			   RG_XTP_LNx_TX_IMPSEL_NMOS);
 	mtk_dp_update_bits(mtk_dp, DP_PHY_LANE_TX_1,
 			   cal_data[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_1] << 12,
-			   RG_XTP_LN1_TX_IMPSEL_PMOS);
+			   RG_XTP_LNx_TX_IMPSEL_PMOS);
 	mtk_dp_update_bits(mtk_dp, DP_PHY_LANE_TX_1,
 			   cal_data[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_1] << 16,
-			   RG_XTP_LN1_TX_IMPSEL_NMOS);
+			   RG_XTP_LNx_TX_IMPSEL_NMOS);
 	mtk_dp_update_bits(mtk_dp, DP_PHY_LANE_TX_2,
 			   cal_data[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_2] << 12,
-			   RG_XTP_LN2_TX_IMPSEL_PMOS);
+			   RG_XTP_LNx_TX_IMPSEL_PMOS);
 	mtk_dp_update_bits(mtk_dp, DP_PHY_LANE_TX_2,
 			   cal_data[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_2] << 16,
-			   RG_XTP_LN2_TX_IMPSEL_NMOS);
+			   RG_XTP_LNx_TX_IMPSEL_NMOS);
 	mtk_dp_update_bits(mtk_dp, DP_PHY_LANE_TX_3,
 			   cal_data[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_3] << 12,
-			   RG_XTP_LN3_TX_IMPSEL_PMOS);
+			   RG_XTP_LNx_TX_IMPSEL_PMOS);
 	mtk_dp_update_bits(mtk_dp, DP_PHY_LANE_TX_3,
 			   cal_data[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_3] << 16,
-			   RG_XTP_LN3_TX_IMPSEL_NMOS);
+			   RG_XTP_LNx_TX_IMPSEL_NMOS);
 }
 
 static int mtk_dp_phy_configure(struct mtk_dp *mtk_dp,
@@ -1401,7 +1425,7 @@ static void mtk_dp_power_enable(struct mtk_dp *mtk_dp)
 			   SW_RST_B_PHYD, SW_RST_B_PHYD);
 	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
 			   DP_PWR_STATE_BANDGAP_TPLL, DP_PWR_STATE_MASK);
-	mtk_dp_write(mtk_dp, MTK_DP_1040,
+	mtk_dp_write(mtk_dp, DP_PHY_AUX_RX_CTL,
 		     RG_DPAUX_RX_VALID_DEGLITCH_EN | RG_XTP_GLB_CKDET_EN |
 		     RG_DPAUX_RX_EN);
 	mtk_dp_update_bits(mtk_dp, MTK_DP_0034, 0, DA_CKM_CKTX0_EN_FORCE_EN);
@@ -1415,7 +1439,7 @@ static void mtk_dp_power_disable(struct mtk_dp *mtk_dp)
 			   DA_CKM_CKTX0_EN_FORCE_EN, DA_CKM_CKTX0_EN_FORCE_EN);
 
 	/* Disable RX */
-	mtk_dp_write(mtk_dp, MTK_DP_1040, 0);
+	mtk_dp_write(mtk_dp, DP_PHY_AUX_RX_CTL, 0);
 	mtk_dp_write(mtk_dp, MTK_DP_TOP_MEM_PD,
 		     0x550 | FUSE_SEL | MEM_ISO_EN);
 }
@@ -2067,7 +2091,8 @@ static int mtk_dp_wait_hpd_asserted(struct drm_dp_aux *mtk_aux, unsigned long wa
 	u32 val;
 	int ret;
 
-	ret = regmap_read_poll_timeout(mtk_dp->regs, MTK_DP_TRANS_P0_3414,
+	ret = regmap_read_poll_timeout(mtk_dp->regs,
+				       MTK_DP_TRANS_P0_3414 + mtk_dp->legacy_regoff,
 				       val, !!(val & HPD_DB_DP_TRANS_P0_MASK),
 				       wait_us / 100, wait_us);
 	if (ret) {
@@ -2100,7 +2125,7 @@ static int mtk_dp_dt_parse(struct mtk_dp *mtk_dp,
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	mtk_dp->regs = devm_regmap_init_mmio(dev, base, &mtk_dp_regmap_config);
+	mtk_dp->regs = devm_regmap_init_mmio(dev, base, &mtk_dp_regmap_legacy_config);
 	if (IS_ERR(mtk_dp->regs))
 		return PTR_ERR(mtk_dp->regs);
 
@@ -2778,6 +2803,7 @@ static int mtk_dp_probe(struct platform_device *pdev)
 
 	mtk_dp->dev = dev;
 	mtk_dp->data = (struct mtk_dp_data *)of_device_get_match_data(dev);
+	mtk_dp->legacy_regoff = MTK_DP_TOP_OFFSET_LEGACY;
 
 	ret = mtk_dp_dt_parse(mtk_dp, pdev);
 	if (ret)
diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
index 8ad7a9cc259e..616ea6440b08 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
+++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
@@ -2,62 +2,22 @@
 /*
  * Copyright (c) 2019-2022 MediaTek Inc.
  * Copyright (c) 2022 BayLibre
+ * Copyright (c) 2026 Collabora Ltd.
  */
 #ifndef _MTK_DP_REG_H_
 #define _MTK_DP_REG_H_
 
-#define SEC_OFFSET	0x4000
-
 #define MTK_DP_HPD_DISCONNECT		BIT(1)
 #define MTK_DP_HPD_CONNECT		BIT(2)
 #define MTK_DP_HPD_INTERRUPT		BIT(3)
 
-/* offset: 0x0 */
-#define DP_PHY_GLB_BIAS_GEN_00		0x0
-#define RG_XTP_GLB_BIAS_INTR_CTRL		GENMASK(20, 16)
-#define DP_PHY_GLB_DPAUX_TX		0x8
-#define RG_CKM_PT0_CKTX_IMPSEL			GENMASK(23, 20)
-#define MTK_DP_0034			0x34
-#define DA_XTP_GLB_CKDET_EN_FORCE_VAL		BIT(15)
-#define DA_XTP_GLB_CKDET_EN_FORCE_EN		BIT(14)
-#define DA_CKM_INTCKTX_EN_FORCE_VAL		BIT(13)
-#define DA_CKM_INTCKTX_EN_FORCE_EN		BIT(12)
-#define DA_CKM_CKTX0_EN_FORCE_VAL		BIT(11)
-#define DA_CKM_CKTX0_EN_FORCE_EN		BIT(10)
-#define DA_CKM_XTAL_CK_FORCE_VAL		BIT(9)
-#define DA_CKM_XTAL_CK_FORCE_EN			BIT(8)
-#define DA_CKM_BIAS_LPF_EN_FORCE_VAL		BIT(7)
-#define DA_CKM_BIAS_LPF_EN_FORCE_EN		BIT(6)
-#define DA_CKM_BIAS_EN_FORCE_VAL		BIT(5)
-#define DA_CKM_BIAS_EN_FORCE_EN			BIT(4)
-#define DA_XTP_GLB_AVD10_ON_FORCE_VAL		BIT(3)
-#define DA_XTP_GLB_AVD10_ON_FORCE		BIT(2)
-#define DA_XTP_GLB_LDO_EN_FORCE_VAL		BIT(1)
-#define DA_XTP_GLB_LDO_EN_FORCE_EN		BIT(0)
-#define DP_PHY_LANE_TX_0		0x104
-#define RG_XTP_LN0_TX_IMPSEL_PMOS		GENMASK(15, 12)
-#define RG_XTP_LN0_TX_IMPSEL_NMOS		GENMASK(19, 16)
-#define DP_PHY_LANE_TX_1		0x204
-#define RG_XTP_LN1_TX_IMPSEL_PMOS		GENMASK(15, 12)
-#define RG_XTP_LN1_TX_IMPSEL_NMOS		GENMASK(19, 16)
-#define DP_PHY_LANE_TX_2		0x304
-#define RG_XTP_LN2_TX_IMPSEL_PMOS		GENMASK(15, 12)
-#define RG_XTP_LN2_TX_IMPSEL_NMOS		GENMASK(19, 16)
-#define DP_PHY_LANE_TX_3		0x404
-#define RG_XTP_LN3_TX_IMPSEL_PMOS		GENMASK(15, 12)
-#define RG_XTP_LN3_TX_IMPSEL_NMOS		GENMASK(19, 16)
-#define MTK_DP_1040			0x1040
-#define RG_DPAUX_RX_VALID_DEGLITCH_EN		BIT(2)
-#define RG_XTP_GLB_CKDET_EN			BIT(1)
-#define RG_DPAUX_RX_EN				BIT(0)
-
-/* offset: TOP_OFFSET (0x2000) */
-#define MTK_DP_TOP_PWR_STATE		0x2000
+/* offset: TOP_OFFSET (0x0) */
+#define MTK_DP_TOP_PWR_STATE		0x0
 #define DP_PWR_STATE_MASK			GENMASK(1, 0)
 #define DP_PWR_STATE_BANDGAP			BIT(0)
 #define DP_PWR_STATE_BANDGAP_TPLL		BIT(1)
 #define DP_PWR_STATE_BANDGAP_TPLL_LANE		GENMASK(1, 0)
-#define MTK_DP_TOP_SWING_EMP		0x2004
+#define MTK_DP_TOP_SWING_EMP		0x4
 #define DP_TX0_VOLT_SWING_MASK			GENMASK(1, 0)
 #define DP_TX0_VOLT_SWING_SHIFT			0
 #define DP_TX0_PRE_EMPH_MASK			GENMASK(3, 2)
@@ -69,43 +29,59 @@
 #define DP_TX2_PRE_EMPH_MASK			GENMASK(19, 18)
 #define DP_TX3_VOLT_SWING_MASK			GENMASK(25, 24)
 #define DP_TX3_PRE_EMPH_MASK			GENMASK(27, 26)
-#define MTK_DP_TOP_RESET_AND_PROBE	0x2020
+#define MTK_DP_TOP_RESET_AND_PROBE	0x20
 #define SW_RST_B_PHYD				BIT(4)
-#define MTK_DP_TOP_IRQ_MASK		0x202c
+#define RG_SW_RST_MASK				GENMASK(7, 0)
+#define RG_SW_RST				0xff
+#define RG_PROBE_LOW_SEL_MASK			GENMASK(18, 16)
+#define RG_PROBE_LOW_SEL			BIT(16)
+#define RG_PROBE_LOW_HIGH_SWAP_MASK		BIT(23)
+#define RG_PROBE_LOW_HIGH_SWAP			BIT(23)
+
+#define MTK_DP_TOP_IRQ_MASK		0x2c
+#define ENCODER_IRQ_MSK				BIT(0)
+#define TRANS_IRQ_MSK				BIT(1)
 #define IRQ_MASK_AUX_TOP_IRQ			BIT(2)
-#define MTK_DP_TOP_MEM_PD		0x2038
+
+#define MTK_DP_TOP_MEM_PD		0x38
 #define MEM_ISO_EN				BIT(0)
 #define FUSE_SEL				BIT(2)
 
-/* offset: ENC0_OFFSET (0x3000) */
-#define MTK_DP_ENC0_P0_3000			0x3000
+#define EDP_TX_TOP_CLKGEN_0		0x74
+#define EDP_TX_TOP_CLKGEN_REST_MASK		0xf
+#define EDP_TX_TOP_CLKGEN_REST_VALUE		0xf
+
+/* offset: ENC0_OFFSET (0x1000) */
+#define MTK_DP_ENC0_P0_3000			0x1000
 #define LANE_NUM_DP_ENC0_P0_MASK			GENMASK(1, 0)
 #define VIDEO_MUTE_SW_DP_ENC0_P0			BIT(2)
 #define VIDEO_MUTE_SEL_DP_ENC0_P0			BIT(3)
 #define ENHANCED_FRAME_EN_DP_ENC0_P0			BIT(4)
-#define MTK_DP_ENC0_P0_3004			0x3004
+#define DP_I_MODE_ENABLE				BIT(6)
+#define REG_BS_SYMBOL_CNT_RESET				BIT(7)
+#define MTK_DP_ENC0_P0_3004			0x1004
 #define VIDEO_M_CODE_SEL_DP_ENC0_P0_MASK		BIT(8)
 #define DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0		BIT(9)
 #define SDP_RESET_SW_DP_ENC0_P0				BIT(13)
-#define MTK_DP_ENC0_P0_3010			0x3010
+#define MTK_DP_ENC0_P0_3010			0x1010
 #define HTOTAL_SW_DP_ENC0_P0_MASK			GENMASK(15, 0)
-#define MTK_DP_ENC0_P0_3014			0x3014
+#define MTK_DP_ENC0_P0_3014			0x1014
 #define VTOTAL_SW_DP_ENC0_P0_MASK			GENMASK(15, 0)
-#define MTK_DP_ENC0_P0_3018			0x3018
+#define MTK_DP_ENC0_P0_3018			0x1018
 #define HSTART_SW_DP_ENC0_P0_MASK			GENMASK(15, 0)
-#define MTK_DP_ENC0_P0_301C			0x301c
+#define MTK_DP_ENC0_P0_301C			0x101c
 #define VSTART_SW_DP_ENC0_P0_MASK			GENMASK(15, 0)
-#define MTK_DP_ENC0_P0_3020			0x3020
+#define MTK_DP_ENC0_P0_3020			0x1020
 #define HWIDTH_SW_DP_ENC0_P0_MASK			GENMASK(15, 0)
-#define MTK_DP_ENC0_P0_3024			0x3024
+#define MTK_DP_ENC0_P0_3024			0x1024
 #define VHEIGHT_SW_DP_ENC0_P0_MASK			GENMASK(15, 0)
-#define MTK_DP_ENC0_P0_3028			0x3028
+#define MTK_DP_ENC0_P0_3028			0x1028
 #define HSW_SW_DP_ENC0_P0_MASK				GENMASK(14, 0)
 #define HSP_SW_DP_ENC0_P0_MASK				BIT(15)
-#define MTK_DP_ENC0_P0_302C			0x302c
+#define MTK_DP_ENC0_P0_302C			0x102c
 #define VSW_SW_DP_ENC0_P0_MASK				GENMASK(14, 0)
 #define VSP_SW_DP_ENC0_P0_MASK				BIT(15)
-#define MTK_DP_ENC0_P0_3030			0x3030
+#define MTK_DP_ENC0_P0_3030			0x1030
 #define HTOTAL_SEL_DP_ENC0_P0				BIT(0)
 #define VTOTAL_SEL_DP_ENC0_P0				BIT(1)
 #define HSTART_SEL_DP_ENC0_P0				BIT(2)
@@ -118,10 +94,10 @@
 #define VSW_SEL_DP_ENC0_P0				BIT(9)
 #define VBID_AUDIO_MUTE_FLAG_SW_DP_ENC0_P0		BIT(11)
 #define VBID_AUDIO_MUTE_FLAG_SEL_DP_ENC0_P0		BIT(12)
-#define MTK_DP_ENC0_P0_3034			0x3034
-#define MTK_DP_ENC0_P0_3038			0x3038
+#define MTK_DP_ENC0_P0_3034			0x1034
+#define MTK_DP_ENC0_P0_3038			0x1038
 #define VIDEO_SOURCE_SEL_DP_ENC0_P0_MASK		BIT(11)
-#define MTK_DP_ENC0_P0_303C			0x303c
+#define MTK_DP_ENC0_P0_303C			0x103c
 #define SRAM_START_READ_THRD_DP_ENC0_P0_MASK		GENMASK(5, 0)
 #define VIDEO_COLOR_DEPTH_DP_ENC0_P0_MASK		GENMASK(10, 8)
 #define VIDEO_COLOR_DEPTH_DP_ENC0_P0_16BIT		(0 << 8)
@@ -130,34 +106,36 @@
 #define VIDEO_COLOR_DEPTH_DP_ENC0_P0_8BIT		(3 << 8)
 #define VIDEO_COLOR_DEPTH_DP_ENC0_P0_6BIT		(4 << 8)
 #define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_MASK		GENMASK(14, 12)
-#define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_RGB		(0 << 12)
-#define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YCBCR422		(1 << 12)
-#define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YCBCR420		(2 << 12)
+#  define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_RGB		0
+#  define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YCBCR422	1
+#  define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YCBCR420	2
+#  define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_YONLY		3
+#  define PIXEL_ENCODE_FORMAT_DP_ENC0_P0_RAW		4
 #define VIDEO_MN_GEN_EN_DP_ENC0_P0			BIT(15)
-#define MTK_DP_ENC0_P0_3040			0x3040
+#define MTK_DP_ENC0_P0_3040			0x1040
 #define SDP_DOWN_CNT_DP_ENC0_P0_VAL			0x20
 #define SDP_DOWN_CNT_INIT_DP_ENC0_P0_MASK		GENMASK(11, 0)
-#define MTK_DP_ENC0_P0_304C			0x304c
+#define MTK_DP_ENC0_P0_304C			0x104c
 #define VBID_VIDEO_MUTE_DP_ENC0_P0_MASK			BIT(2)
 #define SDP_VSYNC_RISING_MASK_DP_ENC0_P0_MASK		BIT(8)
-#define MTK_DP_ENC0_P0_3064			0x3064
+#define MTK_DP_ENC0_P0_3064			0x1064
 #define HDE_NUM_LAST_DP_ENC0_P0_MASK			GENMASK(15, 0)
-#define MTK_DP_ENC0_P0_3088			0x3088
+#define MTK_DP_ENC0_P0_3088			0x1088
 #define AU_EN_DP_ENC0_P0				BIT(6)
 #define AUDIO_8CH_EN_DP_ENC0_P0_MASK			BIT(7)
 #define AUDIO_8CH_SEL_DP_ENC0_P0_MASK			BIT(8)
 #define AUDIO_2CH_EN_DP_ENC0_P0_MASK			BIT(14)
 #define AUDIO_2CH_SEL_DP_ENC0_P0_MASK			BIT(15)
-#define MTK_DP_ENC0_P0_308C			0x308c
+#define MTK_DP_ENC0_P0_308C			0x108c
 #define CH_STATUS_0_DP_ENC0_P0_MASK			GENMASK(15, 0)
-#define MTK_DP_ENC0_P0_3090			0x3090
+#define MTK_DP_ENC0_P0_3090			0x1090
 #define CH_STATUS_1_DP_ENC0_P0_MASK			GENMASK(15, 0)
-#define MTK_DP_ENC0_P0_3094			0x3094
+#define MTK_DP_ENC0_P0_3094			0x1094
 #define CH_STATUS_2_DP_ENC0_P0_MASK			GENMASK(7, 0)
-#define MTK_DP_ENC0_P0_30A4			0x30a4
+#define MTK_DP_ENC0_P0_30A4			0x10a4
 #define AU_TS_CFG_DP_ENC0_P0_MASK			GENMASK(7, 0)
-#define MTK_DP_ENC0_P0_30A8			0x30a8
-#define MTK_DP_ENC0_P0_30BC			0x30bc
+#define MTK_DP_ENC0_P0_30A8			0x10a8
+#define MTK_DP_ENC0_P0_30BC			0x10bc
 #define ISRC_CONT_DP_ENC0_P0				BIT(0)
 #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MASK	GENMASK(10, 8)
 #define MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_2	(1 << 8)
@@ -172,63 +150,65 @@
 #define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2	(4 << 8)
 #define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_4	(5 << 8)
 #define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_8	(7 << 8)
-#define MTK_DP_ENC0_P0_30D8			0x30d8
-#define MTK_DP_ENC0_P0_312C			0x312c
+#define MTK_DP_ENC0_P0_30D8			0x10d8
+#define MTK_DP_ENC0_P0_312C			0x112c
 #define ASP_HB2_DP_ENC0_P0_MASK				GENMASK(7, 0)
 #define ASP_HB3_DP_ENC0_P0_MASK				GENMASK(15, 8)
-#define MTK_DP_ENC0_P0_3154			0x3154
+#define MTK_DP_ENC0_P0_3154			0x1154
 #define PGEN_HTOTAL_DP_ENC0_P0_MASK			GENMASK(13, 0)
-#define MTK_DP_ENC0_P0_3158			0x3158
+#define MTK_DP_ENC0_P0_3158			0x1158
 #define PGEN_HSYNC_RISING_DP_ENC0_P0_MASK		GENMASK(13, 0)
-#define MTK_DP_ENC0_P0_315C			0x315c
+#define MTK_DP_ENC0_P0_315C			0x115c
 #define PGEN_HSYNC_PULSE_WIDTH_DP_ENC0_P0_MASK		GENMASK(13, 0)
-#define MTK_DP_ENC0_P0_3160			0x3160
+#define MTK_DP_ENC0_P0_3160			0x1160
 #define PGEN_HFDE_START_DP_ENC0_P0_MASK			GENMASK(13, 0)
-#define MTK_DP_ENC0_P0_3164			0x3164
+#define MTK_DP_ENC0_P0_3164			0x1164
 #define PGEN_HFDE_ACTIVE_WIDTH_DP_ENC0_P0_MASK		GENMASK(13, 0)
-#define MTK_DP_ENC0_P0_3168			0x3168
+#define MTK_DP_ENC0_P0_3168			0x1168
 #define PGEN_VTOTAL_DP_ENC0_P0_MASK			GENMASK(12, 0)
-#define MTK_DP_ENC0_P0_316C			0x316c
+#define MTK_DP_ENC0_P0_316C			0x116c
 #define PGEN_VSYNC_RISING_DP_ENC0_P0_MASK		GENMASK(12, 0)
-#define MTK_DP_ENC0_P0_3170			0x3170
+#define MTK_DP_ENC0_P0_3170			0x1170
 #define PGEN_VSYNC_PULSE_WIDTH_DP_ENC0_P0_MASK		GENMASK(12, 0)
-#define MTK_DP_ENC0_P0_3174			0x3174
+#define MTK_DP_ENC0_P0_3174			0x1174
 #define PGEN_VFDE_START_DP_ENC0_P0_MASK			GENMASK(12, 0)
-#define MTK_DP_ENC0_P0_3178			0x3178
+#define MTK_DP_ENC0_P0_3178			0x1178
 #define PGEN_VFDE_ACTIVE_WIDTH_DP_ENC0_P0_MASK		GENMASK(12, 0)
-#define MTK_DP_ENC0_P0_31B0			0x31b0
+#define MTK_DP_ENC0_P0_31B0			0x11b0
 #define PGEN_PATTERN_SEL_VAL				4
 #define PGEN_PATTERN_SEL_MASK				GENMASK(6, 4)
-#define MTK_DP_ENC0_P0_31EC			0x31ec
+#define MTK_DP_ENC0_P0_31EC			0x11ec
 #define AUDIO_CH_SRC_SEL_DP_ENC0_P0			BIT(4)
 #define ISRC1_HB3_DP_ENC0_P0_MASK			GENMASK(15, 8)
 
-/* offset: ENC1_OFFSET (0x3200) */
-#define MTK_DP_ENC1_P0_3200			0x3200
-#define MTK_DP_ENC1_P0_3280			0x3280
+/* offset: ENC1_OFFSET (0x1200) */
+#define MTK_DP_ENC1_P0_3200			0x1200
+#define MTK_DP_ENC1_P0_3280			0x1280
 #define SDP_PACKET_TYPE_DP_ENC1_P0_MASK			GENMASK(4, 0)
 #define SDP_PACKET_W_DP_ENC1_P0				BIT(5)
 #define SDP_PACKET_W_DP_ENC1_P0_MASK			BIT(5)
-#define MTK_DP_ENC1_P0_3300			0x3300
+#define MTK_DP_ENC1_P0_3300			0x1300
 #define VIDEO_AFIFO_RDY_SEL_DP_ENC1_P0_VAL		2
 #define VIDEO_AFIFO_RDY_SEL_DP_ENC1_P0_MASK		GENMASK(9, 8)
-#define MTK_DP_ENC1_P0_3304			0x3304
+#define MTK_DP_ENC1_P0_3304			0x1304
 #define AU_PRTY_REGEN_DP_ENC1_P0_MASK			BIT(8)
 #define AU_CH_STS_REGEN_DP_ENC1_P0_MASK			BIT(9)
 #define AUDIO_SAMPLE_PRSENT_REGEN_DP_ENC1_P0_MASK	BIT(12)
-#define MTK_DP_ENC1_P0_3324			0x3324
+#define MTK_DP_ENC1_P0_3324			0x1324
 #define AUDIO_SOURCE_MUX_DP_ENC1_P0_MASK		GENMASK(9, 8)
 #define AUDIO_SOURCE_MUX_DP_ENC1_P0_DPRX		0
-#define MTK_DP_ENC1_P0_3364			0x3364
+#define MTK_DP_ENC1_P0_3364			0x1364
 #define SDP_DOWN_CNT_IN_HBLANK_DP_ENC1_P0_VAL		0x20
 #define SDP_DOWN_CNT_INIT_IN_HBLANK_DP_ENC1_P0_MASK	GENMASK(11, 0)
 #define FIFO_READ_START_POINT_DP_ENC1_P0_VAL		4
 #define FIFO_READ_START_POINT_DP_ENC1_P0_MASK		GENMASK(15, 12)
-#define MTK_DP_ENC1_P0_3368			0x3368
+#define MTK_DP_ENC1_P0_3368			0x1368
 #define VIDEO_SRAM_FIFO_CNT_RESET_SEL_DP_ENC1_P0	BIT(0)
+#define VIDEO_SRAM_FIFO_CNT_RESET_SEL_MASK		GENMASK(1, 0)
 #define VIDEO_STABLE_CNT_THRD_DP_ENC1_P0		BIT(4)
 #define SDP_DP13_EN_DP_ENC1_P0				BIT(8)
 #define BS2BS_MODE_DP_ENC1_P0				BIT(12)
+#define BS_FOLLOW_SEL_DP_ENC0_P0			BIT(15)
 #define BS2BS_MODE_DP_ENC1_P0_MASK			GENMASK(13, 12)
 #define BS2BS_MODE_DP_ENC1_P0_VAL			1
 #define DP_ENC1_P0_3368_VAL				(VIDEO_SRAM_FIFO_CNT_RESET_SEL_DP_ENC1_P0 | \
@@ -236,94 +216,94 @@
 							 SDP_DP13_EN_DP_ENC1_P0 | \
 							 BS2BS_MODE_DP_ENC1_P0)
 
-#define MTK_DP_ENC1_P0_3374			0x3374
+#define MTK_DP_ENC1_P0_3374			0x1374
 #define SDP_ASP_INSERT_IN_HBLANK_DP_ENC1_P0_MASK	BIT(12)
 #define SDP_DOWN_ASP_CNT_INIT_DP_ENC1_P0_MASK		GENMASK(11, 0)
 
-#define MTK_DP_ENC1_P0_33F4			0x33f4
+#define MTK_DP_ENC1_P0_33F4			0x13f4
 #define DP_ENC_DUMMY_RW_1_AUDIO_RST_EN			BIT(0)
 #define DP_ENC_DUMMY_RW_1				BIT(9)
 
-/* offset: TRANS_OFFSET (0x3400) */
-#define MTK_DP_TRANS_P0_3400				0x3400
+/* offset: TRANS_OFFSET (0x1400) */
+#define MTK_DP_TRANS_P0_3400				0x1400
 #define PATTERN1_EN_DP_TRANS_P0_MASK				BIT(12)
 #define PATTERN2_EN_DP_TRANS_P0_MASK				BIT(13)
 #define PATTERN3_EN_DP_TRANS_P0_MASK				BIT(14)
 #define PATTERN4_EN_DP_TRANS_P0_MASK				BIT(15)
-#define MTK_DP_TRANS_P0_3404				0x3404
+#define MTK_DP_TRANS_P0_3404				0x1404
 #define DP_SCR_EN_DP_TRANS_P0_MASK				BIT(0)
-#define MTK_DP_TRANS_P0_340C				0x340c
+#define MTK_DP_TRANS_P0_340C				0x140c
 #define DP_TX_TRANSMITTER_4P_RESET_SW_DP_TRANS_P0		BIT(13)
-#define MTK_DP_TRANS_P0_3410				0x3410
+#define MTK_DP_TRANS_P0_3410				0x1410
 #define HPD_DEB_THD_DP_TRANS_P0_MASK				GENMASK(3, 0)
 #define HPD_INT_THD_DP_TRANS_P0_MASK				GENMASK(7, 4)
 #define HPD_INT_THD_DP_TRANS_P0_LOWER_500US			(2 << 4)
 #define HPD_INT_THD_DP_TRANS_P0_UPPER_1100US			(2 << 6)
 #define HPD_DISC_THD_DP_TRANS_P0_MASK				GENMASK(11, 8)
 #define HPD_CONN_THD_DP_TRANS_P0_MASK				GENMASK(15, 12)
-#define MTK_DP_TRANS_P0_3414				0x3414
+#define MTK_DP_TRANS_P0_3414				0x1414
 #define HPD_DB_DP_TRANS_P0_MASK					BIT(2)
-#define MTK_DP_TRANS_P0_3418				0x3418
+#define MTK_DP_TRANS_P0_3418				0x1418
 #define IRQ_CLR_DP_TRANS_P0_MASK				GENMASK(3, 0)
 #define IRQ_MASK_DP_TRANS_P0_MASK				GENMASK(7, 4)
 #define IRQ_MASK_DP_TRANS_P0_DISC_IRQ				(BIT(1) << 4)
 #define IRQ_MASK_DP_TRANS_P0_CONN_IRQ				(BIT(2) << 4)
 #define IRQ_MASK_DP_TRANS_P0_INT_IRQ				(BIT(3) << 4)
 #define IRQ_STATUS_DP_TRANS_P0_MASK				GENMASK(15, 12)
-#define MTK_DP_TRANS_P0_342C				0x342c
+#define MTK_DP_TRANS_P0_342C				0x142c
 #define XTAL_FREQ_DP_TRANS_P0_DEFAULT				(BIT(0) | BIT(3) | BIT(5) | BIT(6))
 #define XTAL_FREQ_DP_TRANS_P0_MASK				GENMASK(7, 0)
-#define MTK_DP_TRANS_P0_3430				0x3430
+#define MTK_DP_TRANS_P0_3430				0x1430
 #define HPD_INT_THD_ECO_DP_TRANS_P0_MASK			GENMASK(1, 0)
 #define HPD_INT_THD_ECO_DP_TRANS_P0_HIGH_BOUND_EXT		BIT(1)
-#define MTK_DP_TRANS_P0_34A4				0x34a4
+#define MTK_DP_TRANS_P0_34A4				0x14a4
 #define LANE_NUM_DP_TRANS_P0_MASK				GENMASK(3, 2)
-#define MTK_DP_TRANS_P0_3540				0x3540
+#define MTK_DP_TRANS_P0_3540				0x1540
 #define FEC_EN_DP_TRANS_P0_MASK					BIT(0)
 #define FEC_CLOCK_EN_MODE_DP_TRANS_P0				BIT(3)
-#define MTK_DP_TRANS_P0_3580				0x3580
+#define MTK_DP_TRANS_P0_3580				0x1580
 #define POST_MISC_DATA_LANE0_OV_DP_TRANS_P0_MASK		BIT(8)
 #define POST_MISC_DATA_LANE1_OV_DP_TRANS_P0_MASK		BIT(9)
 #define POST_MISC_DATA_LANE2_OV_DP_TRANS_P0_MASK		BIT(10)
 #define POST_MISC_DATA_LANE3_OV_DP_TRANS_P0_MASK		BIT(11)
-#define MTK_DP_TRANS_P0_35C8				0x35c8
+#define MTK_DP_TRANS_P0_35C8				0x15c8
 #define SW_IRQ_CLR_DP_TRANS_P0_MASK				GENMASK(15, 0)
 #define SW_IRQ_STATUS_DP_TRANS_P0_MASK				GENMASK(15, 0)
-#define MTK_DP_TRANS_P0_35D0				0x35d0
+#define MTK_DP_TRANS_P0_35D0				0x15d0
 #define SW_IRQ_FINAL_STATUS_DP_TRANS_P0_MASK			GENMASK(15, 0)
-#define MTK_DP_TRANS_P0_35F0				0x35f0
+#define MTK_DP_TRANS_P0_35F0				0x15f0
 #define DP_TRANS_DUMMY_RW_0					BIT(3)
 #define DP_TRANS_DUMMY_RW_0_MASK				GENMASK(3, 2)
 
-/* offset: AUX_OFFSET (0x3600) */
-#define MTK_DP_AUX_P0_360C			0x360c
+/* offset: AUX_OFFSET (0x1600) */
+#define MTK_DP_AUX_P0_360C			0x160c
 #define AUX_TIMEOUT_THR_AUX_TX_P0_MASK			GENMASK(12, 0)
 #define AUX_TIMEOUT_THR_AUX_TX_P0_VAL			0x1595
-#define MTK_DP_AUX_P0_3614			0x3614
+#define MTK_DP_AUX_P0_3614			0x1614
 #define AUX_RX_UI_CNT_THR_AUX_TX_P0_MASK		GENMASK(6, 0)
 #define AUX_RX_UI_CNT_THR_AUX_FOR_26M			13
-#define MTK_DP_AUX_P0_3618			0x3618
+#define MTK_DP_AUX_P0_3618			0x1618
 #define AUX_RX_FIFO_FULL_AUX_TX_P0_MASK			BIT(9)
 #define AUX_RX_FIFO_WRITE_POINTER_AUX_TX_P0_MASK	GENMASK(3, 0)
-#define MTK_DP_AUX_P0_3620			0x3620
+#define MTK_DP_AUX_P0_3620			0x1620
 #define AUX_RD_MODE_AUX_TX_P0_MASK			BIT(9)
 #define AUX_RX_FIFO_READ_PULSE_TX_P0			BIT(8)
 #define AUX_RX_FIFO_READ_DATA_AUX_TX_P0_MASK		GENMASK(7, 0)
-#define MTK_DP_AUX_P0_3624			0x3624
+#define MTK_DP_AUX_P0_3624			0x1624
 #define AUX_RX_REPLY_COMMAND_AUX_TX_P0_MASK		GENMASK(3, 0)
-#define MTK_DP_AUX_P0_3628			0x3628
+#define MTK_DP_AUX_P0_3628			0x1628
 #define AUX_RX_PHY_STATE_AUX_TX_P0_MASK			GENMASK(9, 0)
 #define AUX_RX_PHY_STATE_AUX_TX_P0_RX_IDLE		BIT(0)
-#define MTK_DP_AUX_P0_362C			0x362c
+#define MTK_DP_AUX_P0_362C			0x162c
 #define AUX_NO_LENGTH_AUX_TX_P0				BIT(0)
 #define AUX_TX_AUXTX_OV_EN_AUX_TX_P0_MASK		BIT(1)
 #define AUX_RESERVED_RW_0_AUX_TX_P0_MASK		GENMASK(15, 2)
-#define MTK_DP_AUX_P0_3630			0x3630
+#define MTK_DP_AUX_P0_3630			0x1630
 #define AUX_TX_REQUEST_READY_AUX_TX_P0			BIT(3)
-#define MTK_DP_AUX_P0_3634			0x3634
+#define MTK_DP_AUX_P0_3634			0x1634
 #define AUX_TX_OVER_SAMPLE_RATE_AUX_TX_P0_MASK		GENMASK(15, 8)
 #define AUX_TX_OVER_SAMPLE_RATE_FOR_26M			25
-#define MTK_DP_AUX_P0_3640			0x3640
+#define MTK_DP_AUX_P0_3640			0x1640
 #define AUX_RX_AUX_RECV_COMPLETE_IRQ_AUX_TX_P0		BIT(6)
 #define AUX_RX_EDID_RECV_COMPLETE_IRQ_AUX_TX_P0		BIT(5)
 #define AUX_RX_MCCS_RECV_COMPLETE_IRQ_AUX_TX_P0		BIT(4)
@@ -338,25 +318,32 @@
 							 AUX_RX_MCCS_RECV_COMPLETE_IRQ_AUX_TX_P0 | \
 							 AUX_RX_EDID_RECV_COMPLETE_IRQ_AUX_TX_P0 | \
 							 AUX_RX_AUX_RECV_COMPLETE_IRQ_AUX_TX_P0)
-#define MTK_DP_AUX_P0_3644			0x3644
+#define MTK_DP_AUX_P0_3644			0x1644
 #define MCU_REQUEST_COMMAND_AUX_TX_P0_MASK		GENMASK(3, 0)
-#define MTK_DP_AUX_P0_3648			0x3648
+#define MTK_DP_AUX_P0_3648			0x1648
 #define MCU_REQUEST_ADDRESS_LSB_AUX_TX_P0_MASK		GENMASK(15, 0)
-#define MTK_DP_AUX_P0_364C			0x364c
+#define MTK_DP_AUX_P0_364C			0x164c
 #define MCU_REQUEST_ADDRESS_MSB_AUX_TX_P0_MASK		GENMASK(3, 0)
-#define MTK_DP_AUX_P0_3650			0x3650
+#define MTK_DP_AUX_P0_3650			0x1650
 #define MCU_REQ_DATA_NUM_AUX_TX_P0_MASK			GENMASK(15, 12)
 #define PHY_FIFO_RST_AUX_TX_P0_MASK			BIT(9)
 #define MCU_ACK_TRAN_COMPLETE_AUX_TX_P0			BIT(8)
-#define MTK_DP_AUX_P0_3658			0x3658
+#define MTK_DP_AUX_P0_3658			0x1658
 #define AUX_TX_OV_EN_AUX_TX_P0_MASK			BIT(0)
-#define MTK_DP_AUX_P0_3690			0x3690
+#define MTK_DP_AUX_P0_3690			0x1690
 #define RX_REPLY_COMPLETE_MODE_AUX_TX_P0		BIT(8)
-#define MTK_DP_AUX_P0_3704			0x3704
+
+#define REG_36A0_AUX_TX_P0			0x16a0
+#define DP_TX_INIT_MASK_15_TO_2				GENMASK(15, 2)
+
+#define MTK_DP_AUX_P0_3704			0x1704
 #define AUX_TX_FIFO_WDATA_NEW_MODE_T_AUX_TX_P0_MASK	BIT(1)
 #define AUX_TX_FIFO_NEW_MODE_EN_AUX_TX_P0		BIT(2)
-#define MTK_DP_AUX_P0_3708			0x3708
-#define MTK_DP_AUX_P0_37C8			0x37c8
+#define MTK_DP_AUX_P0_3708			0x1708
+#define MTK_DP_AUX_P0_37C8			0x17c8
 #define MTK_ATOP_EN_AUX_TX_P0				BIT(0)
 
+/* offset: SEC_OFFSET (0x2000) */
+#define SEC_OFFSET	0x2000
+
 #endif /*_MTK_DP_REG_H_*/
-- 
2.54.0

