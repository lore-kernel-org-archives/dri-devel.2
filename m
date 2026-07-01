Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72A49C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB43710EF48;
	Wed,  1 Jul 2026 12:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gQd/7xDI";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB1C10EF3B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908440;
 bh=jQy/s+Wa0N+vBrNJSbms88UU/+YTA+LoponyC7JERYY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gQd/7xDIr4wYZP66kr13Q3tWzpt1gFmvxN/llhrFPm+8QtI6H1GRU5KDgoV3KLeXn
 DrEuWaXX5IiVVuCePC7gfBNXEVaOwnp4+0ucUSPDv3xMT9NhW79zgZvcOp8WVpJJzl
 8szwtOPxrq8sZhlsDP2ujl5tTclhfCMSsiQPQQgK1mk4Y6ItcfDyu+Ygkq7MaQ0Ii4
 In5tEEL8+kke2L5KxNHEoPDclWHsK/WAzINn2mda8BmF8Kna+YJV0qei2s8z6gZr7Z
 iR/aGTE2XTWSLumrUTeeFQf738LWfQiLHf0QlffnoouLf6dkNzYEbWU3mxIaF4Lw6k
 o8P+OEOqv58hA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A0EBA17E0CD4;
 Wed,  1 Jul 2026 14:20:38 +0200 (CEST)
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
Subject: [PATCH 10/11] drm/mediatek: mtk_dp: Add support for eDP1.5 IPs and
 MT8196 SoC
Date: Wed,  1 Jul 2026 14:20:23 +0200
Message-ID: <20260701122024.19557-11-angelogioacchino.delregno@collabora.com>
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

Add support for MediaTek's Embedded DisplayPort (eDP) v1.5 IP as
found in the MT8196 SoC and other variants, and enclose some of
the new register writes in specific platform data booleans, as:
 - SDP on Encoder1 can be supported by both old and new IPs
   but it was chosen to use Encoder0 for SDP in the new ones
   in order to decrease the load on the secondary encoder;
 - PSR can be supported by older IPs as well, but was not tested
   on those yet (requires a display with PSR support connected
   to a device with older SoC, and I don't have it right now);
 - Power State forcing may not be needed on newer revisions of
   the eDP/DP IP (in SoCs newer than MT8196/MT6991).

As a note, even if this effectively adds some partial support for
the DisplayPort 1.4 IP from the same SoC (because the DP1.4 and
eDP1.5 IPs in this SoC have some little common parts in common),
there is still a long road ahead to actually enable support for
the DP1.4 IP itself.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c     | 283 +++++++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_dp_reg.h |  61 +++++-
 2 files changed, 310 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 2d58eacb3d3e..605ead7fa9bf 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2,6 +2,8 @@
 /*
  * Copyright (c) 2019-2022 MediaTek Inc.
  * Copyright (c) 2022 BayLibre
+ * Copyright (c) 2026 Collabora Ltd
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  */
 
 #include <drm/display/drm_dp_aux_bus.h>
@@ -57,6 +59,8 @@
 #define MTK_DP_TOP_OFFSET_LEGACY	0x2000
 
 #define MTK_DP_SIP_CONTROL_AARCH32	MTK_SIP_SMC_CMD(0x523)
+#define MTK_DP_SIP_ATF_EDP_SET_VID_MUTE	34
+#  define MTK_DP_SIP_REQ_VIDEO_UNMUTE	0xfefd
 #define MTK_DP_SIP_ATF_EDP_VIDEO_UNMUTE	33
 #define MTK_DP_SIP_ATF_VIDEO_UNMUTE	32
 
@@ -168,7 +172,11 @@ struct mtk_dp_data {
 	bool audio_pkt_in_hblank_area;
 	u16 audio_m_div2_bit;
 	u8 hw_max_link_rate;
+	bool hwip_v1p4;
 	bool aux_hpd_supported;
+	bool sdp_encoder1_enable;
+	bool force_pwr_states;
+	bool psr_supported;
 };
 
 static const struct mtk_dp_efuse_fmt mt8188_dp_efuse_fmt[MTK_DP_CAL_MAX] = {
@@ -507,6 +515,7 @@ static void mtk_dp_msa_bypass_enable(struct mtk_dp *mtk_dp, bool enable)
 
 static void mtk_dp_set_msa(struct mtk_dp *mtk_dp)
 {
+	u32 fde_start_val;
 	struct drm_display_mode mode;
 	struct videomode *vm = &mtk_dp->info.vm;
 
@@ -549,9 +558,14 @@ static void mtk_dp_set_msa(struct mtk_dp *mtk_dp)
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_315C,
 			   vm->hsync_len,
 			   PGEN_HSYNC_PULSE_WIDTH_DP_ENC0_P0_MASK);
+
+	fde_start_val = vm->hback_porch + vm->hsync_len;
+	if (mtk_dp->data->psr_supported)
+		fde_start_val += vm->hfront_porch;
+
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3160,
-			   vm->hback_porch + vm->hsync_len,
-			   PGEN_HFDE_START_DP_ENC0_P0_MASK);
+			   fde_start_val, PGEN_HFDE_START_DP_ENC0_P0_MASK);
+
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3164,
 			   vm->hactive,
 			   PGEN_HFDE_ACTIVE_WIDTH_DP_ENC0_P0_MASK);
@@ -566,9 +580,14 @@ static void mtk_dp_set_msa(struct mtk_dp *mtk_dp)
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3170,
 			   vm->vsync_len,
 			   PGEN_VSYNC_PULSE_WIDTH_DP_ENC0_P0_MASK);
+
+	fde_start_val = vm->vback_porch + vm->vsync_len;
+	if (mtk_dp->data->psr_supported)
+		fde_start_val += vm->vfront_porch;
+
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3174,
-			   vm->vback_porch + vm->vsync_len,
-			   PGEN_VFDE_START_DP_ENC0_P0_MASK);
+			   fde_start_val, PGEN_VFDE_START_DP_ENC0_P0_MASK);
+
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3178,
 			   vm->vactive,
 			   PGEN_VFDE_ACTIVE_WIDTH_DP_ENC0_P0_MASK);
@@ -632,6 +651,8 @@ static void mtk_dp_set_sram_read_start(struct mtk_dp *mtk_dp, u32 val)
 
 static void mtk_dp_setup_encoder(struct mtk_dp *mtk_dp)
 {
+	u32 val, mask;
+
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_303C,
 			   VIDEO_MN_GEN_EN_DP_ENC0_P0,
 			   VIDEO_MN_GEN_EN_DP_ENC0_P0);
@@ -647,7 +668,16 @@ static void mtk_dp_setup_encoder(struct mtk_dp *mtk_dp)
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC1_P0_3364,
 			   FIFO_READ_START_POINT_DP_ENC1_P0_VAL << 12,
 			   FIFO_READ_START_POINT_DP_ENC1_P0_MASK);
-	mtk_dp_write(mtk_dp, MTK_DP_ENC1_P0_3368, DP_ENC1_P0_3368_VAL);
+
+	mask = VIDEO_SRAM_FIFO_CNT_RESET_SEL_DP_ENC1_P0 | VIDEO_STABLE_CNT_THRD_DP_ENC1_P0;
+	mask |= BS2BS_MODE_DP_ENC1_P0;
+
+	val = mask;
+
+	if (mtk_dp->data->sdp_encoder1_enable)
+		val |= SDP_DP13_EN_DP_ENC1_P0;
+
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC1_P0_3368, val, mask);
 }
 
 static void mtk_dp_pg_enable(struct mtk_dp *mtk_dp, bool enable)
@@ -1106,6 +1136,72 @@ static void mtk_dp_hwirq_enable(struct mtk_dp *mtk_dp, bool enable)
 			   IRQ_MASK_DP_TRANS_P0_MASK);
 }
 
+static void mtk_dp_encoder_force_bias_power_on(struct mtk_dp *mtk_dp)
+{
+	/* Force MCU to enable BIAS */
+	mtk_dp_update_bits(mtk_dp, REG_3F44_DP_ENC_P0_3,
+			   ENC_PHY_PWR_OVERWRITE_EN, ENC_PHY_PWR_OVERWRITE_EN);
+	mtk_dp_update_bits(mtk_dp, REG_3F44_DP_ENC_P0_3,
+			   FIELD_PREP_CONST(ENC_PHY_PWR_STATE_OVERWRITE_MASK,
+					    ENC_PHY_BIAS_PWR_ON),
+			   ENC_PHY_PWR_STATE_OVERWRITE_MASK);
+
+	/* Wait for the MCU to get LDO ready in PHYD */
+	msleep(50);
+
+	mtk_dp_update_bits(mtk_dp, REG_3F44_DP_ENC_P0_3,
+			   0, ENC_PHY_PWR_OVERWRITE_EN);
+}
+
+static void mtk_dp_encoder_force_bias_power_off(struct mtk_dp *mtk_dp)
+{
+	/* Force MCU to disable power */
+	mtk_dp_update_bits(mtk_dp, REG_3F44_DP_ENC_P0_3,
+			   ENC_PHY_PWR_OVERWRITE_EN, ENC_PHY_PWR_OVERWRITE_EN);
+	mtk_dp_update_bits(mtk_dp, REG_3F44_DP_ENC_P0_3,
+			   FIELD_PREP_CONST(ENC_PHY_PWR_STATE_OVERWRITE_MASK,
+					    ENC_PHY_ALL_PWR_OFF),
+			   ENC_PHY_PWR_STATE_OVERWRITE_MASK);
+	mtk_dp_update_bits(mtk_dp, REG_3F44_DP_ENC_P0_3,
+			   0, ENC_PHY_PWR_OVERWRITE_EN);
+}
+
+static void mtk_dp_initialize_psr_settings(struct mtk_dp *mtk_dp)
+{
+	mtk_dp_update_bits(mtk_dp, MTK_DP_PSR_FRAME_START_MARKER_0, 0,
+			   DP_ENC_P0_3_FRAME_MARKER_MASK);
+	mtk_dp_update_bits(mtk_dp, MTK_DP_PSR_FRAME_END_MARKER_0, 1,
+			   DP_ENC_P0_3_FRAME_MARKER_MASK);
+
+	mtk_dp_update_bits(mtk_dp, MTK_DP_PSR_FRAME_START_MARKER_1, 8,
+			   DP_ENC_P0_3_FRAME_MARKER_MASK);
+	mtk_dp_update_bits(mtk_dp, MTK_DP_PSR_FRAME_END_MARKER_1, 9,
+			   DP_ENC_P0_3_FRAME_MARKER_MASK);
+
+	mtk_dp_update_bits(mtk_dp, REG_33C0_DP_ENCODER1_P0, 0,
+			   SDP_TESTBUS_SEL_DP_ENC_MASK);
+	mtk_dp_update_bits(mtk_dp, REG_33C4_DP_ENCODER1_P0,
+			   DP_TX_ENCODER_TESTBUS_SEL_DP_ENC,
+			   DP_TX_ENCODER_TESTBUS_SEL_DP_ENC_MASK);
+	mtk_dp_update_bits(mtk_dp, REG_3F28_DP_ENC_P0_3,
+			   DP_TX_SDP_PSR_AS_TESTBUS << 2,
+			   DP_TX_SDP_PSR_AS_TESTBUS_MASK);
+}
+
+static void mtk_dp_initialize_settings_v2p1(struct mtk_dp *mtk_dp)
+{
+	/* For DP2.1 and eDP1.5 IPs, reset all and enable probing */
+	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_RESET_AND_PROBE,
+			   RG_SW_RST_ALL, RG_SW_RST_ALL);
+
+	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_RESET_AND_PROBE,
+			   FIELD_PREP_CONST(RG_PROBE_LOW_SEL_MASK, RG_PROBE_ENCODER0),
+			   RG_PROBE_LOW_SEL_MASK);
+
+	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_RESET_AND_PROBE,
+			   RG_PROBE_LOW_HIGH_SWAP, RG_PROBE_LOW_HIGH_SWAP);
+}
+
 static void mtk_dp_initialize_settings(struct mtk_dp *mtk_dp)
 {
 	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_342C,
@@ -1119,12 +1215,15 @@ static void mtk_dp_initialize_settings(struct mtk_dp *mtk_dp)
 			   AUDIO_CH_SRC_SEL_DP_ENC0_P0);
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_304C,
 			   0, SDP_VSYNC_RISING_MASK_DP_ENC0_P0_MASK);
-	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_IRQ_MASK,
-			   IRQ_MASK_AUX_TOP_IRQ, IRQ_MASK_AUX_TOP_IRQ);
 }
 
 static void mtk_dp_initialize_aux_hpd_detect_settings(struct mtk_dp *mtk_dp)
 {
+	/* Mask Encoder and Transmitter interrupts, unmask AUX TOP */
+	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_IRQ_MASK,
+			   ENCODER0_IRQ_MSK | TRANS_IRQ_MSK,
+			   ENCODER0_IRQ_MSK | TRANS_IRQ_MSK | AUX_TOP_IRQ_MSK);
+
 	/* Set interrupt debounce threshold time */
 	mtk_dp_update_bits(mtk_dp, MTK_DP_AUX_P0_364C,
 			   FIELD_PREP_CONST(HPD_INT_LOW_TIME_THD, 2) |
@@ -1151,6 +1250,10 @@ static void mtk_dp_initialize_hpd_detect_settings(struct mtk_dp *mtk_dp)
 {
 	u32 val;
 
+	/* Mask AUX TOP interrupt, as this uses transmitter for HPD */
+	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_IRQ_MASK,
+			   AUX_TOP_IRQ_MSK, AUX_TOP_IRQ_MSK);
+
 	/* Debounce threshold */
 	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3410,
 			   8, HPD_DEB_THD_DP_TRANS_P0_MASK);
@@ -1200,24 +1303,87 @@ static void mtk_dp_initialize_aux_settings(struct mtk_dp *mtk_dp)
 			   RX_REPLY_COMPLETE_MODE_AUX_TX_P0);
 }
 
-static void mtk_dp_initialize_digital_settings(struct mtk_dp *mtk_dp)
+static void mtk_dp_initialize_common_digital_settings(struct mtk_dp *mtk_dp)
 {
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_304C,
 			   0, VBID_VIDEO_MUTE_DP_ENC0_P0_MASK);
 
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC1_P0_3368,
-			   BS2BS_MODE_DP_ENC1_P0_VAL << 12,
-			   BS2BS_MODE_DP_ENC1_P0_MASK);
+			   BS2BS_MODE_DP_ENC1_P0, BS2BS_MODE_DP_ENC1_P0_MASK);
+}
+
+static void mtk_dp_initialize_digital_settings_v2p1(struct mtk_dp *mtk_dp)
+{
+	/* Set XTAL frequency for Panel Self Refresh (PSR) */
+	if (mtk_dp->data->psr_supported)
+		mtk_dp_update_bits(mtk_dp, REG_3FF8_DP_ENC_P0_3,
+				   FIELD_PREP(DP_ENCODER_PSR_XTAL_FREQ_MHZ_MASK, 25),
+				   DP_ENCODER_PSR_XTAL_FREQ_MHZ_MASK);
+
+	/* Enable I-Mode */
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3000,
+			   DP_I_MODE_ENABLE, DP_I_MODE_ENABLE);
+
+	/* Reset Video SRAM and Symbol count */
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3000,
+			   REG_BS_SYMBOL_CNT_RESET, REG_BS_SYMBOL_CNT_RESET);
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC1_P0_3368,
+			   VIDEO_SRAM_FIFO_CNT_RESET_SEL_DP_ENC1_P0,
+			   VIDEO_SRAM_FIFO_CNT_RESET_SEL_MASK);
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC1_P0_3368,
+			   BS_FOLLOW_SEL_DP_ENC0_P0, BS_FOLLOW_SEL_DP_ENC0_P0);
+
+	/* [5:0] Video SRAM start address */
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_303C,
+			   0x8, SRAM_START_READ_THRD_DP_ENC0_P0_MASK);
+
+	/* Disable Pattern Generator in Panel Self Refresh mode */
+	if (mtk_dp->data->psr_supported)
+		mtk_dp_update_bits(mtk_dp, REG_3F80_DP_ENC_P0_3,
+				   0, PSR_PATGEN_AVT_EN_FLDMASK);
+
+	/* Force MCU to enable BIAS and PLL */
+	mtk_dp_encoder_force_bias_power_on(mtk_dp);
+
+	mtk_dp_update_bits(mtk_dp, REG_3FF8_DP_ENC_P0_3,
+			   PHY_STATE_W_1_DP_ENC_P0_3, PHY_STATE_W_1_DP_ENC_P0_3);
 
+	/* Force enable Digital Video Output */
+	mtk_dp_update_bits(mtk_dp, REG_3FF8_DP_ENC_P0_3,
+			   DP_ENCODER_DVO_ON_W_1, DP_ENCODER_DVO_ON_W_1);
+}
+
+static void mtk_dp_encoder_reset(struct mtk_dp *mtk_dp)
+{
 	/* dp tx encoder reset all sw */
 	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
 			   DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0,
 			   DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0);
 
+	if (mtk_dp->data->hwip_v1p4) {
+		mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004, 0,
+				   DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0);
+		mtk_dp_update_bits(mtk_dp, REG_3FF8_DP_ENC_P0_3,
+				   ENC_PHY_STATE_RESET_ALL_MASK,
+				   ENC_PHY_STATE_RESET_ALL_MASK);
+	}
+
 	/* Wait for sw reset to complete */
 	usleep_range(1000, 5000);
-	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
-			   0, DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0);
+
+	if (!mtk_dp->data->hwip_v1p4)
+		mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
+				   0, DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0);
+}
+
+static void mtk_dp_initialize_digital_settings(struct mtk_dp *mtk_dp)
+{
+	mtk_dp_initialize_common_digital_settings(mtk_dp);
+
+	if (mtk_dp->data->hwip_v1p4)
+		mtk_dp_initialize_digital_settings_v2p1(mtk_dp);
+
+	mtk_dp_encoder_reset(mtk_dp);
 }
 
 static void mtk_dp_digital_sw_reset(struct mtk_dp *mtk_dp)
@@ -1230,6 +1396,26 @@ static void mtk_dp_digital_sw_reset(struct mtk_dp *mtk_dp)
 	usleep_range(1000, 5000);
 	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_340C,
 			   0, DP_TX_TRANSMITTER_4P_RESET_SW_DP_TRANS_P0);
+
+	/* Only for the new eDP 1.5 IP, set the internal clock generators */
+	if (mtk_dp->data->hwip_v1p4 &&
+	    mtk_dp->data->bridge_type == DRM_MODE_CONNECTOR_eDP) {
+		u32 val;
+
+		/* Enable internal clock outputs for AUX TOP, DATA and MUX */
+		val = EDP_TX_TOP_CLKGEN_AUX_P0_EN | EDP_TX_TOP_CLKGEN_AUX_MUX_DATA_EN |
+		      EDP_TX_TOP_CLKGEN_AUX_MUX_VALID_EN;
+
+		/* Enable XTAL output */
+		val |= EDP_TX_TOP_CLKGEN_XTAL_P0_EN;
+
+		/* VSC and Encoders */
+		val |= EDP_TX_TOP_CLKGEN_LS_VSC_W_0_EN;
+		val |= EDP_TX_TOP_CLKGEN_LS_ENCODER_L0_EN | EDP_TX_TOP_CLKGEN_LS_ENCODER_L1_EN;
+		val |= EDP_TX_TOP_CLKGEN_LS_ENCODER_L2_EN | EDP_TX_TOP_CLKGEN_LS_ENCODER_L3_EN;
+
+		mtk_dp_update_bits(mtk_dp, EDP_TX_TOP_CLKGEN_0, val, val);
+	}
 }
 
 static void mtk_dp_sdp_path_reset(struct mtk_dp *mtk_dp)
@@ -1246,6 +1432,9 @@ static void mtk_dp_sdp_path_reset(struct mtk_dp *mtk_dp)
 
 static void mtk_dp_set_lanes(struct mtk_dp *mtk_dp, int lanes)
 {
+	if (mtk_dp->data->force_pwr_states)
+		mtk_dp_encoder_force_bias_power_on(mtk_dp);
+
 	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_35F0,
 			   lanes == 0 ? 0 : DP_TRANS_DUMMY_RW_0,
 			   DP_TRANS_DUMMY_RW_0_MASK);
@@ -1361,8 +1550,10 @@ static int mtk_dp_phy_configure(struct mtk_dp *mtk_dp,
 		}
 	};
 
-	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE, DP_PWR_STATE_BANDGAP,
-			   DP_PWR_STATE_MASK);
+	/* Set power state requests only if power states are not forced */
+	if (!mtk_dp->data->force_pwr_states)
+		mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE, DP_PWR_STATE_BANDGAP,
+				   DP_PWR_STATE_MASK);
 
 	ret = phy_configure(mtk_dp->phy, &phy_opts);
 	if (ret)
@@ -1375,6 +1566,11 @@ static int mtk_dp_phy_configure(struct mtk_dp *mtk_dp,
 	if (mtk_dp->phy_dev)
 		mtk_dp_set_calibration_data(mtk_dp);
 
+	if (mtk_dp->data->force_pwr_states)
+		mtk_dp_update_bits(mtk_dp, REG_3FF8_DP_ENC_P0_3,
+				   PHY_STATE_W_1_DP_ENC_P0_3,
+				   PHY_STATE_W_1_DP_ENC_P0_3);
+
 	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
 			   DP_PWR_STATE_BANDGAP_TPLL_LANE, DP_PWR_STATE_MASK);
 
@@ -1424,17 +1620,24 @@ static void mtk_dp_training_set_scramble(struct mtk_dp *mtk_dp, bool enable)
 static void mtk_dp_video_mute(struct mtk_dp *mtk_dp, bool enable)
 {
 	struct arm_smccc_res res;
-	u32 val = VIDEO_MUTE_SEL_DP_ENC0_P0 |
-		  (enable ? VIDEO_MUTE_SW_DP_ENC0_P0 : 0);
+	const u32 mask = VIDEO_MUTE_SEL_DP_ENC0_P0 | VIDEO_MUTE_SW_DP_ENC0_P0;
+	u32 val = VIDEO_MUTE_SEL_DP_ENC0_P0 | (enable ? VIDEO_MUTE_SW_DP_ENC0_P0 : 0);
+	u32 smc_para, smc_val;
 
-	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3000,
-			   val,
-			   VIDEO_MUTE_SEL_DP_ENC0_P0 |
-			   VIDEO_MUTE_SW_DP_ENC0_P0);
+	/* Set VIDEO_MUTE in unsecured world... */
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3000, val, mask);
+
+	/* ...and do the same in ATF as well */
+	if (mtk_dp->data->hwip_v1p4) {
+		smc_para = (mtk_dp->data->smc_cmd << 16) | enable;
+		smc_val = MTK_DP_SIP_REQ_VIDEO_UNMUTE;
+	} else {
+		smc_para = 0;
+		smc_val = 0;
+	}
 
-	arm_smccc_smc(MTK_DP_SIP_CONTROL_AARCH32,
-		      mtk_dp->data->smc_cmd, enable,
-		      0, 0, 0, 0, 0, &res);
+	arm_smccc_smc(MTK_DP_SIP_CONTROL_AARCH32, mtk_dp->data->smc_cmd, enable,
+		      smc_para, smc_val, 0, 0, 0, &res);
 
 	dev_dbg(mtk_dp->dev, "smc cmd: 0x%x, p1: %s, ret: 0x%lx-0x%lx\n",
 		mtk_dp->data->smc_cmd, enable ? "enable" : "disable", res.a0, res.a1);
@@ -1522,6 +1725,9 @@ static void mtk_dp_power_disable(struct mtk_dp *mtk_dp)
 
 	mtk_dp_write(mtk_dp, MTK_DP_TOP_PWR_STATE, 0);
 
+	if (mtk_dp->data->force_pwr_states)
+		mtk_dp_encoder_force_bias_power_off(mtk_dp);
+
 	if (unlikely(mtk_dp->phy_dev)) {
 		mtk_dp_update_bits(mtk_dp, MTK_DP_0034,
 			   DA_CKM_CKTX0_EN_FORCE_EN, DA_CKM_CKTX0_EN_FORCE_EN);
@@ -2081,7 +2287,14 @@ static void mtk_dp_init_port(struct mtk_dp *mtk_dp)
 	mtk_dp_set_idle_pattern(mtk_dp, true);
 	mtk_dp_initialize_priv_data(mtk_dp);
 
-	mtk_dp_initialize_settings(mtk_dp);
+	if (mtk_dp->data->psr_supported)
+		mtk_dp_initialize_psr_settings(mtk_dp);
+
+	if (mtk_dp->data->hwip_v1p4)
+		mtk_dp_initialize_settings_v2p1(mtk_dp);
+	else
+		mtk_dp_initialize_settings(mtk_dp);
+
 	mtk_dp_initialize_aux_settings(mtk_dp);
 	mtk_dp_initialize_digital_settings(mtk_dp);
 
@@ -2583,6 +2796,9 @@ static void mtk_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 	/* SDP path reset sw*/
 	mtk_dp_sdp_path_reset(mtk_dp);
 
+	if (mtk_dp->data->force_pwr_states)
+		mtk_dp_encoder_force_bias_power_on(mtk_dp);
+
 	/* Ensure the sink is muted */
 	msleep(20);
 }
@@ -3089,6 +3305,7 @@ static const struct mtk_dp_data mt8188_dp_data = {
 	.audio_pkt_in_hblank_area = true,
 	.audio_m_div2_bit = MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
 	.hw_max_link_rate = DP_LINK_BW_5_4,
+	.sdp_encoder1_enable = true,
 };
 
 static const struct mtk_dp_data mt8195_edp_data = {
@@ -3098,6 +3315,7 @@ static const struct mtk_dp_data mt8195_edp_data = {
 	.audio_supported = false,
 	.audio_m_div2_bit = MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
 	.hw_max_link_rate = DP_LINK_BW_5_4,
+	.sdp_encoder1_enable = true,
 };
 
 static const struct mtk_dp_data mt8195_dp_data = {
@@ -3107,6 +3325,19 @@ static const struct mtk_dp_data mt8195_dp_data = {
 	.audio_supported = true,
 	.audio_m_div2_bit = MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
 	.hw_max_link_rate = DP_LINK_BW_5_4,
+	.sdp_encoder1_enable = true,
+};
+
+static const struct mtk_dp_data mt8196_edp_data = {
+	.bridge_type = DRM_MODE_CONNECTOR_eDP,
+	.smc_cmd = MTK_DP_SIP_ATF_EDP_SET_VID_MUTE,
+	.audio_supported = false,
+	.audio_m_div2_bit = MT8195_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
+	.hw_max_link_rate = DP_LINK_BW_8_1,
+	.hwip_v1p4 = true,
+	.aux_hpd_supported = true,
+	.force_pwr_states = true,
+	.psr_supported = true,
 };
 
 static const struct of_device_id mtk_dp_of_match[] = {
@@ -3126,6 +3357,10 @@ static const struct of_device_id mtk_dp_of_match[] = {
 		.compatible = "mediatek,mt8195-dp-tx",
 		.data = &mt8195_dp_data,
 	},
+	{
+		.compatible = "mediatek,mt8196-edp-tx",
+		.data = &mt8196_edp_data,
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, mtk_dp_of_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
index 5a3b3e2b4f49..9caf743f4fe6 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
+++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
@@ -31,25 +31,38 @@
 #define DP_TX3_PRE_EMPH_MASK			GENMASK(27, 26)
 #define MTK_DP_TOP_RESET_AND_PROBE	0x20
 #define SW_RST_B_PHYD				BIT(4)
-#define RG_SW_RST_MASK				GENMASK(7, 0)
-#define RG_SW_RST				0xff
+#define RG_SW_RST_ALL				GENMASK(7, 0)
 #define RG_PROBE_LOW_SEL_MASK			GENMASK(18, 16)
+#  define RG_PROBE_SW				0
+#  define RG_PROBE_ENCODER0			1
+#  define RG_PROBE_TRANSMITTER			2
+#  define RG_PROBE_AUX_TOP			3
+#  define RG_PROBE_PHY				4
+#  define RG_PROBE_MST14			5
+#  define RG_PROBE_ENCODER1			6
 #define RG_PROBE_LOW_SEL			BIT(16)
-#define RG_PROBE_LOW_HIGH_SWAP_MASK		BIT(23)
 #define RG_PROBE_LOW_HIGH_SWAP			BIT(23)
 
 #define MTK_DP_TOP_IRQ_MASK		0x2c
-#define ENCODER_IRQ_MSK				BIT(0)
+#define ENCODER0_IRQ_MSK			BIT(0)
 #define TRANS_IRQ_MSK				BIT(1)
-#define IRQ_MASK_AUX_TOP_IRQ			BIT(2)
+#define AUX_TOP_IRQ_MSK				BIT(2)
+#define ENCODER1_IRQ_MSK			BIT(3)
 
 #define MTK_DP_TOP_MEM_PD		0x38
 #define MEM_ISO_EN				BIT(0)
 #define FUSE_SEL				BIT(2)
 
 #define EDP_TX_TOP_CLKGEN_0		0x74
-#define EDP_TX_TOP_CLKGEN_REST_MASK		0xf
-#define EDP_TX_TOP_CLKGEN_REST_VALUE		0xf
+#define EDP_TX_TOP_CLKGEN_AUX_P0_EN		BIT(0)
+#define EDP_TX_TOP_CLKGEN_AUX_MUX_DATA_EN	BIT(1)
+#define EDP_TX_TOP_CLKGEN_AUX_MUX_VALID_EN	BIT(2)
+#define EDP_TX_TOP_CLKGEN_XTAL_P0_EN		BIT(3)
+#define EDP_TX_TOP_CLKGEN_LS_VSC_W_0_EN		BIT(4)
+#define EDP_TX_TOP_CLKGEN_LS_ENCODER_L0_EN	BIT(5)
+#define EDP_TX_TOP_CLKGEN_LS_ENCODER_L1_EN	BIT(6)
+#define EDP_TX_TOP_CLKGEN_LS_ENCODER_L2_EN	BIT(7)
+#define EDP_TX_TOP_CLKGEN_LS_ENCODER_L3_EN	BIT(8)
 
 /* offset: ENC0_OFFSET (0x1000) */
 #define MTK_DP_ENC0_P0_3000			0x1000
@@ -210,16 +223,19 @@
 #define BS2BS_MODE_DP_ENC1_P0				BIT(12)
 #define BS_FOLLOW_SEL_DP_ENC0_P0			BIT(15)
 #define BS2BS_MODE_DP_ENC1_P0_MASK			GENMASK(13, 12)
-#define BS2BS_MODE_DP_ENC1_P0_VAL			1
 #define DP_ENC1_P0_3368_VAL				(VIDEO_SRAM_FIFO_CNT_RESET_SEL_DP_ENC1_P0 | \
 							 VIDEO_STABLE_CNT_THRD_DP_ENC1_P0 | \
 							 SDP_DP13_EN_DP_ENC1_P0 | \
 							 BS2BS_MODE_DP_ENC1_P0)
-
 #define MTK_DP_ENC1_P0_3374			0x1374
 #define SDP_ASP_INSERT_IN_HBLANK_DP_ENC1_P0_MASK	BIT(12)
 #define SDP_DOWN_ASP_CNT_INIT_DP_ENC1_P0_MASK		GENMASK(11, 0)
-
+#define REG_33C0_DP_ENCODER1_P0			0x13c0
+#define SDP_TESTBUS_SEL_DP_ENC_MASK			GENMASK(15, 12)
+#define SDP_TESTBUS_SEL_BIT_DP_ENC			BIT(7)
+#define REG_33C4_DP_ENCODER1_P0			0x13c4
+#define DP_TX_ENCODER_TESTBUS_SEL_DP_ENC_MASK		GENMASK(6, 5)
+#define DP_TX_ENCODER_TESTBUS_SEL_DP_ENC		BIT(5)
 #define MTK_DP_ENC1_P0_33F4			0x13f4
 #define DP_ENC_DUMMY_RW_1_AUDIO_RST_EN			BIT(0)
 #define DP_ENC_DUMMY_RW_1				BIT(9)
@@ -361,6 +377,31 @@
 #define MTK_DP_AUX_P0_37C8			0x17c8
 #define MTK_ATOP_EN_AUX_TX_P0				BIT(0)
 
+/* offset info queue */
+#define MTK_DP_PSR_FRAME_START_MARKER_0			0x1f04
+#define MTK_DP_PSR_FRAME_START_MARKER_1			0x1f08
+#define MTK_DP_PSR_FRAME_END_MARKER_0			0x1f0c
+#define MTK_DP_PSR_FRAME_END_MARKER_1			0x1f10
+#define DP_ENC_P0_3_FRAME_MARKER_MASK			GENMASK(15, 0)
+#define REG_3F28_DP_ENC_P0_3			0x1f28
+#define DP_TX_SDP_PSR_AS_TESTBUS_MASK			GENMASK(5, 2)
+#define DP_TX_SDP_PSR_AS_TESTBUS			10
+#define REG_3F40_DP_ENC_P0_3			0x1f40
+#define REG_3F44_DP_ENC_P0_3			0x1f44
+#define ENC_PHY_PWR_STATE_OVERWRITE_MASK		GENMASK(4, 3)
+#define ENC_PHY_ALL_PWR_OFF				0
+#define ENC_PHY_BIAS_PWR_ON				1
+#define ENC_PHY_BIAS_PLL_PWR_ON				2
+#define ENC_PHY_ALL_PWR_ON				3
+#define ENC_PHY_PWR_OVERWRITE_EN			BIT(2)
+#define REG_3F80_DP_ENC_P0_3			0x1f80
+#define PSR_PATGEN_AVT_EN_FLDMASK			0x20
+#define REG_3FF8_DP_ENC_P0_3			0x1ff8
+#define ENC_PHY_STATE_RESET_ALL_MASK			GENMASK(7, 0)
+#define PHY_STATE_W_1_DP_ENC_P0_3			BIT(6)
+#define DP_ENCODER_DVO_ON_W_1				BIT(5)
+#define DP_ENCODER_PSR_XTAL_FREQ_MHZ_MASK		GENMASK(13, 9)
+
 /* offset: SEC_OFFSET (0x2000) */
 #define SEC_OFFSET	0x2000
 
-- 
2.54.0

