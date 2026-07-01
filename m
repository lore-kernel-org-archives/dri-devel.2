Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7DDC44503
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9BC310EF47;
	Wed,  1 Jul 2026 12:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="L8OwNSNK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D9610EF45
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908438;
 bh=IZ38iVAfqH1Pp/kF7fOfMZyN1IgdrwvmijD1xOoZa30=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=L8OwNSNKgjYK07UyikxGzL8dLRKhqiPOi+VgXotln+gvdAOUUjCfWWiyhFxERkd+9
 yon4cReW7aaeT62i+j/9B2s3xD57XPUTarm4S1wCQmud3r3VZlHOGfOYW6k+eDOZqF
 6an/SdSF8tQOo6endNhxdnX41/rJxLJD0YUtpz20FZS0ES5hPWUvx6jmeWhA1ZrNts
 Q4+Fh4U02HKlnOaHyD115c7v1RSMhYMUFKZvXUB76un9yVQqsw9COaFAwSAanSgMG/
 XUnhQfAnjeqkdyRW9+8cTPulI11Uy6UWnSVtbqzyB9U20XTT9IpnoQHLel+t2Qz1zL
 oPSeMT5T83fwA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4AD1B17E0CA2;
 Wed,  1 Jul 2026 14:20:37 +0200 (CEST)
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
Subject: [PATCH 09/11] drm/mediatek: mtk_dp: Add support for HotPlug Detection
 in DP AUX
Date: Wed,  1 Jul 2026 14:20:22 +0200
Message-ID: <20260701122024.19557-10-angelogioacchino.delregno@collabora.com>
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

Newer MediaTek DisplayPort IPs can finally use the AUX to perform
hotplug detection (HPD) without having to power up the entire eDP
or DP IP (transmitter, encoder, etc).

Enable support for configuring and performing HPD in AUX and check
the correct HPD strategy with a new platform data variable.
This is done in preparation for adding support for the embedded
DisplayPort (eDP) IP found in the MT8196 SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c     | 96 ++++++++++++++++++++++++---
 drivers/gpu/drm/mediatek/mtk_dp_reg.h | 18 +++++
 2 files changed, 103 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 5272e717bfda..2d58eacb3d3e 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -168,6 +168,7 @@ struct mtk_dp_data {
 	bool audio_pkt_in_hblank_area;
 	u16 audio_m_div2_bit;
 	u8 hw_max_link_rate;
+	bool aux_hpd_supported;
 };
 
 static const struct mtk_dp_efuse_fmt mt8188_dp_efuse_fmt[MTK_DP_CAL_MAX] = {
@@ -1046,7 +1047,21 @@ static u32 mtk_dp_swirq_get_clear(struct mtk_dp *mtk_dp)
 	return irq_status;
 }
 
-static u32 mtk_dp_hwirq_get_clear(struct mtk_dp *mtk_dp)
+static u32 mtk_dp_aux_hwirq_get_clear(struct mtk_dp *mtk_dp)
+{
+	u32 irq_status = mtk_dp_read(mtk_dp, MTK_DP_AUX_TX_P0_INT_STA);
+
+	if (irq_status) {
+		mtk_dp_update_bits(mtk_dp, MTK_DP_AUX_TX_P0_INT_CLR,
+				   irq_status, irq_status);
+		mtk_dp_update_bits(mtk_dp, MTK_DP_AUX_TX_P0_INT_CLR,
+				   0, irq_status);
+	}
+
+	return irq_status;
+}
+
+static u32 mtk_dp_trans_hwirq_get_clear(struct mtk_dp *mtk_dp)
 {
 	u32 irq_status = (mtk_dp_read(mtk_dp, MTK_DP_TRANS_P0_3418) &
 			  IRQ_STATUS_DP_TRANS_P0_MASK) >> 12;
@@ -1061,8 +1076,28 @@ static u32 mtk_dp_hwirq_get_clear(struct mtk_dp *mtk_dp)
 	return irq_status;
 }
 
+static inline u32 mtk_dp_hwirq_get_clear(struct mtk_dp *mtk_dp)
+{
+	if (mtk_dp->data->aux_hpd_supported)
+		return mtk_dp_aux_hwirq_get_clear(mtk_dp);
+
+	return mtk_dp_trans_hwirq_get_clear(mtk_dp);
+}
+
 static void mtk_dp_hwirq_enable(struct mtk_dp *mtk_dp, bool enable)
 {
+	u32 mask, val;
+
+	/* Valid only for SoCs with working AUX HPD, this register is ignored on the others */
+	if (enable) {
+		mask = HPD_CONNECT_EVENT | HPD_INTERRUPT_EVENT | HPD_DISCONNECT_EVENT;
+		val = 0;
+	} else {
+		mask = DP_TX_AUX_INT_MASK;
+		val = DP_TX_AUX_INT_MASK;
+	}
+	mtk_dp_update_bits(mtk_dp, MTK_DP_TX_AUX_INT_MASKING, val, mask);
+
 	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3418,
 			   enable ? 0 :
 			   IRQ_MASK_DP_TRANS_P0_DISC_IRQ |
@@ -1088,9 +1123,34 @@ static void mtk_dp_initialize_settings(struct mtk_dp *mtk_dp)
 			   IRQ_MASK_AUX_TOP_IRQ, IRQ_MASK_AUX_TOP_IRQ);
 }
 
+static void mtk_dp_initialize_aux_hpd_detect_settings(struct mtk_dp *mtk_dp)
+{
+	/* Set interrupt debounce threshold time */
+	mtk_dp_update_bits(mtk_dp, MTK_DP_AUX_P0_364C,
+			   FIELD_PREP_CONST(HPD_INT_LOW_TIME_THD, 2) |
+			   FIELD_PREP_CONST(HPD_INT_HIGH_TIME_THD, 6),
+			   HPD_INT_LOW_TIME_THD | HPD_INT_HIGH_TIME_THD);
+
+	/* Connection detect threshold time: 1.5ms + (0.1 * (x)) ms*/
+	mtk_dp_update_bits(mtk_dp, MTK_DP_AUX_P0_367C,
+			   FIELD_PREP(HPD_CONN_THD_DP_TX_AUX_MASK, 5),
+			   HPD_CONN_THD_DP_TX_AUX_MASK);
+
+	/* Disconnection detect threshold and debounce time */
+	mtk_dp_write(mtk_dp, MTK_DP_AUX_P0_37A0,
+		     FIELD_PREP_CONST(HPD_DISC_THD_AUX_TX, 5) |
+		     FIELD_PREP_CONST(HPD_DISC_DEB_AUX_TX, 8));
+
+	/* Crystal frequency for 1us timing normalization: set to 26MHz */
+	mtk_dp_update_bits(mtk_dp, REG_366C_AUX_TX_P0,
+			   FIELD_PREP_CONST(XTAL_FREQ_DP_TX_AUX_MASK, XTAL_FREQ_DP_TX_AUX_VAL),
+			   XTAL_FREQ_DP_TX_AUX_MASK);
+}
+
 static void mtk_dp_initialize_hpd_detect_settings(struct mtk_dp *mtk_dp)
 {
 	u32 val;
+
 	/* Debounce threshold */
 	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_3410,
 			   8, HPD_DEB_THD_DP_TRANS_P0_MASK);
@@ -2024,7 +2084,11 @@ static void mtk_dp_init_port(struct mtk_dp *mtk_dp)
 	mtk_dp_initialize_settings(mtk_dp);
 	mtk_dp_initialize_aux_settings(mtk_dp);
 	mtk_dp_initialize_digital_settings(mtk_dp);
-	mtk_dp_initialize_hpd_detect_settings(mtk_dp);
+
+	if (mtk_dp->data->aux_hpd_supported)
+		mtk_dp_initialize_aux_hpd_detect_settings(mtk_dp);
+	else
+		mtk_dp_initialize_hpd_detect_settings(mtk_dp);
 
 	mtk_dp_digital_sw_reset(mtk_dp);
 }
@@ -2091,6 +2155,7 @@ static irqreturn_t mtk_dp_hpd_event(int hpd, void *dev)
 	unsigned long flags;
 	u32 irq_status = mtk_dp_swirq_get_clear(mtk_dp) |
 			 mtk_dp_hwirq_get_clear(mtk_dp);
+	u32 val;
 
 	if (!irq_status)
 		return IRQ_HANDLED;
@@ -2109,11 +2174,15 @@ static irqreturn_t mtk_dp_hpd_event(int hpd, void *dev)
 	spin_unlock_irqrestore(&mtk_dp->irq_thread_lock, flags);
 
 	if (cable_sta_chg) {
-		if (!!(mtk_dp_read(mtk_dp, MTK_DP_TRANS_P0_3414) &
-		       HPD_DB_DP_TRANS_P0_MASK))
-			mtk_dp->train_info.cable_plugged_in = true;
-		else
-			mtk_dp->train_info.cable_plugged_in = false;
+		if (mtk_dp->data->aux_hpd_supported) {
+			val = mtk_dp_read(mtk_dp, MTK_DP_AUX_P0_364C);
+			val &= HPD_STATUS_DP_AUX_TX_P0_MASK;
+		} else {
+			val = mtk_dp_read(mtk_dp, MTK_DP_TRANS_P0_3414);
+			val &= HPD_DB_DP_TRANS_P0_MASK;
+		}
+
+		mtk_dp->train_info.cable_plugged_in = val > 0;
 	}
 
 	return IRQ_WAKE_THREAD;
@@ -2125,10 +2194,15 @@ static int mtk_dp_wait_hpd_asserted(struct drm_dp_aux *mtk_aux, unsigned long wa
 	u32 val;
 	int ret;
 
-	ret = regmap_read_poll_timeout(mtk_dp->regs,
-				       MTK_DP_TRANS_P0_3414 + mtk_dp->legacy_regoff,
-				       val, !!(val & HPD_DB_DP_TRANS_P0_MASK),
-				       wait_us / 100, wait_us);
+	if (mtk_dp->data->aux_hpd_supported)
+		ret = regmap_read_poll_timeout(mtk_dp->regs, MTK_DP_AUX_P0_364C,
+					       val, !!(val & HPD_STATUS_DP_AUX_TX_P0_MASK),
+					       wait_us / 100, wait_us);
+	else
+		ret = regmap_read_poll_timeout(mtk_dp->regs,
+					       MTK_DP_TRANS_P0_3414 + mtk_dp->legacy_regoff,
+					       val, !!(val & HPD_DB_DP_TRANS_P0_MASK),
+					       wait_us / 100, wait_us);
 	if (ret) {
 		mtk_dp->train_info.cable_plugged_in = false;
 		return ret;
diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
index 616ea6440b08..5a3b3e2b4f49 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
+++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
@@ -276,6 +276,11 @@
 #define DP_TRANS_DUMMY_RW_0_MASK				GENMASK(3, 2)
 
 /* offset: AUX_OFFSET (0x1600) */
+#define MTK_DP_AUX_TX_P0_INT_STA			0x1608
+#define HPD_CONNECT_EVENT				BIT(0)
+#define HPD_INTERRUPT_EVENT				BIT(2)
+#define HPD_DISCONNECT_EVENT				BIT(10)
+#define DP_TX_AUX_INT_MASK				GENMASK(15, 0)
 #define MTK_DP_AUX_P0_360C			0x160c
 #define AUX_TIMEOUT_THR_AUX_TX_P0_MASK			GENMASK(12, 0)
 #define AUX_TIMEOUT_THR_AUX_TX_P0_VAL			0x1595
@@ -323,6 +328,9 @@
 #define MTK_DP_AUX_P0_3648			0x1648
 #define MCU_REQUEST_ADDRESS_LSB_AUX_TX_P0_MASK		GENMASK(15, 0)
 #define MTK_DP_AUX_P0_364C			0x164c
+#define HPD_STATUS_DP_AUX_TX_P0_MASK			BIT(15)
+#define HPD_INT_HIGH_TIME_THD				GENMASK(9, 7)
+#define HPD_INT_LOW_TIME_THD				GENMASK(6, 4)
 #define MCU_REQUEST_ADDRESS_MSB_AUX_TX_P0_MASK		GENMASK(3, 0)
 #define MTK_DP_AUX_P0_3650			0x1650
 #define MCU_REQ_DATA_NUM_AUX_TX_P0_MASK			GENMASK(15, 12)
@@ -330,6 +338,13 @@
 #define MCU_ACK_TRAN_COMPLETE_AUX_TX_P0			BIT(8)
 #define MTK_DP_AUX_P0_3658			0x1658
 #define AUX_TX_OV_EN_AUX_TX_P0_MASK			BIT(0)
+#define MTK_DP_TX_AUX_INT_MASKING		0x1660
+#define MTK_DP_AUX_TX_P0_INT_CLR		0x1668
+#define REG_366C_AUX_TX_P0			0x166c
+#define XTAL_FREQ_DP_TX_AUX_VAL				0x68
+#define XTAL_FREQ_DP_TX_AUX_MASK			GENMASK(15, 8)
+#define MTK_DP_AUX_P0_367C			0x167c
+#define HPD_CONN_THD_DP_TX_AUX_MASK			GENMASK(9, 6)
 #define MTK_DP_AUX_P0_3690			0x1690
 #define RX_REPLY_COMPLETE_MODE_AUX_TX_P0		BIT(8)
 
@@ -340,6 +355,9 @@
 #define AUX_TX_FIFO_WDATA_NEW_MODE_T_AUX_TX_P0_MASK	BIT(1)
 #define AUX_TX_FIFO_NEW_MODE_EN_AUX_TX_P0		BIT(2)
 #define MTK_DP_AUX_P0_3708			0x1708
+#define MTK_DP_AUX_P0_37A0			0x17a0
+#define HPD_DISC_THD_AUX_TX				GENMASK(7, 4)
+#define HPD_DISC_DEB_AUX_TX				GENMASK(3, 0)
 #define MTK_DP_AUX_P0_37C8			0x17c8
 #define MTK_ATOP_EN_AUX_TX_P0				BIT(0)
 
-- 
2.54.0

