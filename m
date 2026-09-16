Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC95DC88E7F
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 11:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D4C910E645;
	Wed, 16 Sep 2026 11:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XTSPRv/5";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C2910E645
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 11:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789556917;
 bh=ul005wTEdPt43cAI+ZA5rO+gbMxkaBWMkfTxjxBofQ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XTSPRv/5hl1diHRRMKyHasCD5ZfWhwYUhcTnME7zw2cgp/SCIedMMw/0uka8z5Nm6
 kKzIEiiN5h1aSwFHS3d4J+wLFxU6FGcKTpUoeqeRtIWBTIRr4rY2B8CtSawkAN43Gx
 A/grIJl4rwkbtQ/rUrrRthDCA94p7r2PEo/lqi8NoGWKDCIe50iMKMfOgGmwyq/E97
 dt/oog7fdMXW39p2uCj6DS2c+CzjHE2VLnvsJCCfnR66liM4zWQa9MdF2BK0zj4bN/
 yHAbpp1OEfeJzzYgRdBqK8OXPWXZdLjlmqLSOx5y+X0lAxybm9wHzv9vArANm/QUIC
 mQxPNMR5qF6rA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B439817E01D1;
 Wed, 16 Sep 2026 13:08:36 +0200 (CEST)
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
Subject: [PATCH v9 09/13] drm/mediatek: mtk_dsi: Add support for SRAM QoS
 setting
Date: Wed, 16 Sep 2026 13:08:21 +0200
Message-ID: <20260916110825.102631-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916110825.102631-1-angelogioacchino.delregno@collabora.com>
References: <20260916110825.102631-1-angelogioacchino.delregno@collabora.com>
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

Add support for automatically calculating and setting the Quality
of Service (QoS) parameters and DSI IP SRAM Line Buffering in the
newest DSI IPs like the one found on MT8196, MT6991 and variants.

This allows for a small reduction in memory (and display frames)
latency by limiting transmission bursts to a certain, number of
bytes, predefined as per the calculations based on the total data
rate (on all lanes), number of internal DSI IP buffer blocks and
bytes per pixel.

Note that the current algorithm does account for different values
of sram and buffer units but, since this was only tested on the
MT8196 SoC (which happens to have the same value for buffer and
sram unit), the same dsi_sram_bytes value was assigned to both
units: though the algorithm could've been simplified a little by
making it to assume that they're the same, at the time of writing
there are a few SoCs out in the wild that have different sizes.

Until those are implemented though, the platform data struct will
have only one parameter, assumed to be assigned to both units, in
order to keep both the structure and the code size smaller.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 145 +++++++++++++++++++++++++++++
 1 file changed, 145 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 9d701cadf7ea..64dfc100f033 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -52,6 +52,7 @@
 #define DSI_RESET			BIT(0)
 #define DSI_EN				BIT(1)
 #define DPHY_RESET			BIT(2)
+#define CMDMODE_WAIT_DATA_EVERY_LINE_EN	BIT(24)
 
 /* DSI_MODE_CTRL */
 #define MODE				(3)
@@ -152,6 +153,18 @@
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
@@ -164,6 +177,17 @@
 
 #define NS_TO_CYCLE(n, c)    ((n) / (c) + (((n) % (c)) ? 1 : 0))
 
+/* HW QoS and Anti-Latency Buffer related bits */
+#define MTK_DSI_MAX_FIFO_BYTES			1554
+#define MTK_DSI_DEFAULT_QOS_VALID_FIFO_US	25
+#define MTK_DSI_DEFAULT_QOS_SODI_LO_OVERHEAD	(23 + 5)
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
@@ -206,9 +230,26 @@ enum mtk_dsi_adv_regidx {
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
@@ -233,8 +274,12 @@ struct phy;
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
@@ -772,6 +817,102 @@ static int mtk_dsi_set_dsc_params(struct mtk_dsi *dsi)
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
+	u64 tmp;
+
+	/*
+	 * At the time of implementing, this was verified only on MT6991/MT8196
+	 * and, for this SoC, the buffer unit is equal to the SRAM bytes.
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
+	/* Read as: [Data rate (MHz)] * [Number of DSI lanes] / [8 buffer blocks] */
+	tmp = (u64)dsi->data_rate * dsi->lanes;
+	data_rate_per_buf = div_u64(tmp, 8 * buffer_unit * HZ_PER_MHZ);
+
+	/*
+	 * Anti-latency buffer output threshold for absolute timer mode: this
+	 * parameter controls the maximum amount of output data that the FIFO
+	 * can hold before running out of buffer space.
+	 *
+	 * The data will therefore be sent either when the DSI IP0s internal
+	 * vblank vs bus QoS timer expires or when it reaches the amount of
+	 * buffers set in BUF_OUT_VALID_THRESHOLD (regardless of QoS) to avoid
+	 * partially, or entirely, losing frame(s).
+	 */
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
+	fill_rate = div_u64((u64)pclk_mhz * data->pixels_per_iter * dsi_buf_bpp,
+			    buffer_unit);
+
+	/* Calculate QoS Anti-Latency parameters */
+	sodi_hi = MTK_DSI_MAX_FIFO_BYTES * num_hw_buffers;
+	sodi_hi -= (fill_rate - data_rate_per_buf) * 12 / 10;
+	sodi_lo = MTK_DSI_DEFAULT_QOS_SODI_LO_OVERHEAD * data_rate_per_buf;
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
@@ -957,6 +1098,10 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	mtk_dsi_reset_engine(dsi);
 	mtk_dsi_phy_timconfig(dsi);
 
+	/* Setup HW FIFO if DSI supports QoS Anti-Latency buffers */
+	if (data->dsi_sram_bytes && data->reg_qos)
+		mtk_dsi_config_hw_buffers(dsi);
+
 	mtk_dsi_ps_control(dsi, true);
 	mtk_dsi_set_vm_cmd(dsi);
 	ret = mtk_dsi_config_vdo_timing(dsi);
-- 
2.55.0

