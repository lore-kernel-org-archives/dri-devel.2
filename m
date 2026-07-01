Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D444C44509
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AFB710E35A;
	Wed,  1 Jul 2026 12:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DFb0BMjU";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1426B10EF1F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908401;
 bh=oicLzQI1HRwxnR+j6TEA/BwogndBNOfdRjAIDTmIHfk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DFb0BMjU80Dy5gYcANyjmMPxkAtQu5ds2eq8+NnWkERY4SAruP2VR6aY1y0dPNtfg
 OckrFm1KeDeurIfpVJQg75P2vkCGgP0lphTk/unxb29XtLuG1XUnZoxFVsWDJMajrT
 GvQYYIl5HgpVYICgon2KW+Oh6l/EOtK/GW4UGKa8PE7rRn4XIL135NYOhVoi+mKzyg
 i8qNJpYGmYqRHiNj4ajG9z1xkYeMKQFejJfkhvcUbP+zn3Wi1BOqbQodXbiB8uYKoy
 qejljt5Tsmd1AsD4QMBP7g64gWmZSGvbhQr73qMa9g4GrEmmLpY8gphUUG0HuHgX5y
 fzJ/7IWn3jAag==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id AE91D17E116D;
 Wed,  1 Jul 2026 14:20:00 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 jitao.shi@mediatek.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, justin.yeh@mediatek.com, jason-jh.lin@mediatek.com
Subject: [PATCH 07/10] drm/mediatek: mtk_dsi: Add support for MT8196
Date: Wed,  1 Jul 2026 14:19:47 +0200
Message-ID: <20260701121950.19454-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701121950.19454-1-angelogioacchino.delregno@collabora.com>
References: <20260701121950.19454-1-angelogioacchino.delregno@collabora.com>
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

Add support for the new DSI IP found in the Kompanio Ultra MT8196
SoC and its Dimensity and Genio variants.

Differently from the older DSI IPs, the one from MT8196 requires
the initialization of all of the QoS parameters and can make use
of a DSI SRAM reserved buffer (present also on older SoCs but not
mandatory on those).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |   2 +
 drivers/gpu/drm/mediatek/mtk_dsi.c     | 197 +++++++++++++++++++++++++
 2 files changed, 199 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index bd2d17017bd2..9a4c59849c4b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -826,6 +826,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8188-dsi",
 	  .data = (void *)MTK_DSI },
+	{ .compatible = "mediatek,mt8196-dsi",
+	  .data = (void *)MTK_DSI },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index ba96c12a8ceb..fc6f846208d6 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -153,6 +153,18 @@
 #define FORCE_COMMIT			BIT(0)
 #define BYPASS_SHADOW			BIT(1)
 
+/* DSI_VDE */
+#define VDE_BLOCK_ULTRA			BIT(29)
+
+/* DSI_BUF_CON0 */
+#define DSI_QOS_BUF_EN			BIT(0)
+
+/* DSI_BUF_CON1 */
+#define BUF_OUT_VALID_THRESH		GENMASK(14, 0)
+
+/* DSI_BUF_SODI_HIGH, SODI_LOW and other BUF registers */
+#define BUF_THRESHOLD_PARAM		GENMASK(19, 0)
+
 /* CMDQ related bits */
 #define CONFIG				GENMASK(7, 0)
 #define SHORT_PACKET			0
@@ -165,6 +177,16 @@
 
 #define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
 
+/* HW QoS and Anti-Latency Buffer related bits */
+#define MTK_DSI_MAX_FIFO_BYTES			1554
+#define MTK_DSI_DEFAULT_QOS_VALID_FIFO_US	25
+#define MTK_DSI_DEFAULT_QOS_PREULTRA_HI_US	36
+#define MTK_DSI_DEFAULT_QOS_PREULTRA_LO_US	35
+#define MTK_DSI_DEFAULT_QOS_ULTRA_HI_US		26
+#define MTK_DSI_DEFAULT_QOS_ULTRA_LO_US		25
+#define MTK_DSI_DEFAULT_QOS_URGENT_LO_US	11
+#define MTK_DSI_DEFAULT_QOS_URGENT_HI_US	12
+
 #define MTK_DSI_HOST_IS_READ(type) \
 	((type == MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM) || \
 	(type == MIPI_DSI_GENERIC_READ_REQUEST_1_PARAM) || \
@@ -207,9 +229,26 @@ enum mtk_dsi_adv_regidx {
 	DSI_VM_CMD_CON,
 	DSI_SHADOW_DEBUG,
 	DSI_CMDQ,
+	DSI_VDE,
 	DSI_ADV_REG_MAX
 };
 
+enum mtk_dsi_qos_regidx {
+	DSI_QOS_BUF_CON0,
+	DSI_QOS_BUF_CON1,
+	DSI_QOS_TX_BUF_RW_TIMES,
+	DSI_QOS_SODI_HIGH,
+	DSI_QOS_SODI_LOW,
+	DSI_QOS_PREULTRA_HIGH,
+	DSI_QOS_PREULTRA_LOW,
+	DSI_QOS_ULTRA_HIGH,
+	DSI_QOS_ULTRA_LOW,
+	DSI_QOS_URGENT_HIGH,
+	DSI_QOS_URGENT_LOW,
+	DSI_QOS_PREURGENT_HIGH,
+	DSI_QOS_REG_MAX
+};
+
 struct mtk_phy_timing {
 	u32 lpx;
 	u32 da_hs_prepare;
@@ -234,8 +273,12 @@ struct phy;
 struct mtk_dsi_driver_data {
 	const u16 *reg_main;
 	const u16 *reg_adv;
+	const u16 *reg_qos;
 
 	const u16 max_link_rate_mbps;
+	const u8 dsi_sram_bytes;
+	const u8 pixels_per_iter;
+	const u8 num_burst_lines;
 
 	bool has_size_ctl;
 	bool cmdq_long_packet_ctl;
@@ -329,6 +372,59 @@ static const u16 mtk_dsi_regs_mt8186[DSI_ADV_REG_MAX] = {
 	[DSI_CMDQ] = 0xd00,
 };
 
+static const u16 mtk_dsi_regs_main_v2[DSI_MAIN_REG_MAX] = {
+	[DSI_START] = 0x00,
+	[DSI_INTEN] = 0x08,
+	[DSI_INTSTA] = 0x0c,
+	[DSI_CON_CTRL] = 0x30,
+	[DSI_MODE_CTRL] = 0x34,
+	[DSI_TXRX_CTRL] = 0x38,
+	[DSI_PSCTRL] = 0x3c,
+	[DSI_VSA_NL] = 0x60,
+	[DSI_VBP_NL] = 0x64,
+	[DSI_VFP_NL] = 0x68,
+	[DSI_VACT_NL] = 0x6c,
+	[DSI_SIZE_CON] = 0x2c,
+	[DSI_HSA_WC] = 0x80,
+	[DSI_HBP_WC] = 0x84,
+	[DSI_HFP_WC] = 0x88,
+	[DSI_CMDQ_SIZE] = 0x44,
+	[DSI_HSTX_CKL_WC] = 0x100,
+	[DSI_RX_DATA0] = 0xa4,
+	[DSI_RX_DATA1] = 0xa8,
+	[DSI_RX_DATA2] = 0xac,
+	[DSI_RX_DATA3] = 0xb0,
+	[DSI_RACK] = 0xb4,
+	[DSI_PHY_LCCON] = 0x7d0,
+	[DSI_PHY_LD0CON] = 0x7d4,
+	[DSI_PHY_TIMECON0] = 0x600,
+	[DSI_PHY_TIMECON1] = 0x604,
+	[DSI_PHY_TIMECON2] = 0x608,
+	[DSI_PHY_TIMECON3] = 0x60c,
+};
+
+static const u16 mtk_dsi_regs_qos_v2[DSI_QOS_REG_MAX] = {
+	[DSI_QOS_BUF_CON0] = 0x300,
+	[DSI_QOS_BUF_CON1] = 0x304,
+	[DSI_QOS_TX_BUF_RW_TIMES] = 0x310,
+	[DSI_QOS_SODI_HIGH] = 0x314,
+	[DSI_QOS_SODI_LOW] = 0x318,
+	[DSI_QOS_PREULTRA_HIGH] = 0x324,
+	[DSI_QOS_PREULTRA_LOW] = 0x328,
+	[DSI_QOS_ULTRA_HIGH] = 0x32c,
+	[DSI_QOS_ULTRA_LOW] = 0x330,
+	[DSI_QOS_URGENT_HIGH] = 0x334,
+	[DSI_QOS_URGENT_LOW] = 0x338,
+	[DSI_QOS_PREURGENT_HIGH] = 0x33c
+};
+
+static const u16 mtk_dsi_regs_mt8196[DSI_ADV_REG_MAX] = {
+	[DSI_VM_CMD_CON] = 0x110,
+	[DSI_SHADOW_DEBUG] = 0xd0,
+	[DSI_CMDQ] = 0x400,
+	[DSI_VDE] = 0x3f8,
+};
+
 static inline struct mtk_dsi *bridge_to_dsi(struct drm_bridge *b)
 {
 	return container_of(b, struct mtk_dsi, bridge);
@@ -752,6 +848,89 @@ static int mtk_dsi_set_dsc_params(struct mtk_dsi *dsi)
 	return drm_dsc_compute_rc_parameters(dsc);
 }
 
+static void mtk_dsi_config_hw_buffers(struct mtk_dsi *dsi)
+{
+	const struct mtk_dsi_driver_data *data = dsi->driver_data;
+	const u16 *reg_qos = data->reg_qos;
+	u32 buffer_unit, sram_unit, num_hw_buffers;
+	u32 preultra_hi, preultra_lo;
+	u32 urgent_hi, urgent_lo;
+	u32 ultra_hi, ultra_lo;
+	u32 sodi_hi, sodi_lo;
+	u32 data_rate_per_buf;
+	u32 out_valid_thresh;
+	u32 dsi_buf_bpp;
+	u32 fill_rate;
+	u32 pclk_mhz;
+	u32 rw_times;
+	u32 val;
+
+	/*
+	 * At the time of writing, only MT8196 is implemented and, for this SoC,
+	 * the buffer unit is equal to the SRAM bytes.
+	 *
+	 * There are other SoCs already out in the wild that do support the HW
+	 * buffers and that have different sizes, so keep the calculation as-is!
+	 */
+	buffer_unit = data->dsi_sram_bytes;
+	sram_unit = data->dsi_sram_bytes;
+	num_hw_buffers = sram_unit / buffer_unit;
+
+	if (data->support_per_frame_lp)
+		val = CMDMODE_WAIT_DATA_EVERY_LINE_EN;
+	else
+		val = 0;
+
+	mtk_dsi_mask(dsi, data->reg_main[DSI_CON_CTRL],
+		     CMDMODE_WAIT_DATA_EVERY_LINE_EN, val);
+
+	data_rate_per_buf = dsi->data_rate * dsi->lanes / 8 / buffer_unit;
+
+	/* Calculate valid threshold and avoid exceeding FIFO size */
+	out_valid_thresh = MTK_DSI_DEFAULT_QOS_VALID_FIFO_US * data_rate_per_buf;
+	out_valid_thresh = min(out_valid_thresh, MTK_DSI_MAX_FIFO_BYTES - 1);
+	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_BUF_CON1], BUF_OUT_VALID_THRESH, out_valid_thresh);
+
+	/* Enable ULTRA signal trigger between SOF and VACT */
+	mtk_dsi_mask(dsi, data->reg_adv[DSI_VDE], VDE_BLOCK_ULTRA, 0);
+
+	/* Calculate fill rate with line counter mode for DSI Video Mode */
+	if (dsi->format == MIPI_DSI_FMT_RGB565)
+		dsi_buf_bpp = 2;
+	else
+		dsi_buf_bpp = 3;
+
+	pclk_mhz = dsi->vm.pixelclock / HZ_PER_MHZ;
+	fill_rate = pclk_mhz * data->pixels_per_iter * dsi_buf_bpp / buffer_unit;
+
+	/* Calculate QoS Anti-Latency parameters */
+	sodi_hi = MTK_DSI_MAX_FIFO_BYTES * num_hw_buffers;
+	sodi_hi -= (fill_rate - data_rate_per_buf) * 12 / 10;
+	sodi_lo = (23 + 5) * data_rate_per_buf;
+	preultra_hi = MTK_DSI_DEFAULT_QOS_PREULTRA_HI_US * data_rate_per_buf;
+	preultra_lo = MTK_DSI_DEFAULT_QOS_PREULTRA_LO_US * data_rate_per_buf;
+	ultra_hi = MTK_DSI_DEFAULT_QOS_ULTRA_HI_US * data_rate_per_buf;
+	ultra_lo = MTK_DSI_DEFAULT_QOS_ULTRA_LO_US * data_rate_per_buf;
+	urgent_hi = MTK_DSI_DEFAULT_QOS_URGENT_HI_US * data_rate_per_buf;
+	urgent_lo = MTK_DSI_DEFAULT_QOS_URGENT_LO_US * data_rate_per_buf;
+	rw_times = dsi->vm.vactive * dsi_buf_bpp;
+	rw_times /= data->num_burst_lines * data->pixels_per_iter;
+
+	/* Write all QoS parameters: Screen On Deep Idle, (pre)Ultra, Urgent, RW times */
+	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_SODI_HIGH], BUF_THRESHOLD_PARAM, sodi_hi);
+	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_SODI_LOW], BUF_THRESHOLD_PARAM, sodi_lo);
+	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_PREULTRA_HIGH], BUF_THRESHOLD_PARAM, preultra_hi);
+	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_PREULTRA_LOW], BUF_THRESHOLD_PARAM, preultra_lo);
+	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_ULTRA_HIGH], BUF_THRESHOLD_PARAM, ultra_hi);
+	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_ULTRA_LOW], BUF_THRESHOLD_PARAM, ultra_lo);
+	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_URGENT_HIGH], BUF_THRESHOLD_PARAM, urgent_hi);
+	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_URGENT_LOW], BUF_THRESHOLD_PARAM, urgent_lo);
+	writel(rw_times, dsi->regs + reg_qos[DSI_QOS_TX_BUF_RW_TIMES]);
+
+	/* Finally, activate internal line-buffering */
+	mtk_dsi_mask(dsi, reg_qos[DSI_QOS_BUF_CON0], DSI_QOS_BUF_EN, DSI_QOS_BUF_EN);
+}
+
 static int mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
 {
 	const struct mtk_dsi_driver_data *data = dsi->driver_data;
@@ -929,6 +1108,10 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	mtk_dsi_reset_engine(dsi);
 	mtk_dsi_phy_timconfig(dsi);
 
+	/* Setup HW FIFO if DSI supports QoS Anti-Latency buffers */
+	if (data->dsi_sram_bytes && data->reg_qos)
+		mtk_dsi_config_hw_buffers(dsi);
+
 	mtk_dsi_ps_control(dsi, true);
 	mtk_dsi_set_vm_cmd(dsi);
 	ret = mtk_dsi_config_vdo_timing(dsi);
@@ -1549,6 +1732,19 @@ static const struct mtk_dsi_driver_data mt8189_dsi_driver_data = {
 	.support_per_frame_lp = true,
 };
 
+static const struct mtk_dsi_driver_data mt8196_dsi_driver_data = {
+	.reg_main = mtk_dsi_regs_main_v2,
+	.reg_qos = mtk_dsi_regs_qos_v2,
+	.reg_adv = mtk_dsi_regs_mt8196,
+	.max_link_rate_mbps = 2000,
+	.dsi_sram_bytes = 32,
+	.pixels_per_iter = 2,
+	.num_burst_lines = 8,
+	.has_size_ctl = true,
+	.cmdq_long_packet_ctl = true,
+	.support_per_frame_lp = true,
+};
+
 static const struct of_device_id mtk_dsi_of_match[] = {
 	{ .compatible = "mediatek,mt2701-dsi", .data = &mt2701_dsi_driver_data },
 	{ .compatible = "mediatek,mt8173-dsi", .data = &mt8173_dsi_driver_data },
@@ -1556,6 +1752,7 @@ static const struct of_device_id mtk_dsi_of_match[] = {
 	{ .compatible = "mediatek,mt8186-dsi", .data = &mt8186_dsi_driver_data },
 	{ .compatible = "mediatek,mt8188-dsi", .data = &mt8188_dsi_driver_data },
 	{ .compatible = "mediatek,mt8189-dsi", .data = &mt8189_dsi_driver_data },
+	{ .compatible = "mediatek,mt8196-dsi", .data = &mt8196_dsi_driver_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_dsi_of_match);
-- 
2.54.0

