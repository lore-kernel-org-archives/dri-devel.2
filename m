Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14A7C44508
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 13:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C663310F0C5;
	Wed, 15 Jul 2026 13:57:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="VYHDFgnD";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AF1A10F0C1
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 13:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784123835;
 bh=iz0KnuVGcck2z6u+H3eYklRaAOtKKQAC++LigpNKgoM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VYHDFgnDiTDGuNhqHOrjzVfDmHpQed5jFqI7r7BVNWaQ8BCihN3pJ5v6pg68DoAJu
 gw5tdwKBvfnG4bWx0pbhjleZ2Bd2iPTueJNFdgA2cBHwcxgtopakdv62uQi5AZKGnS
 kV1uLbRJhnffkcLwn8Kj0J/H4OEABvX+3XUOW+V401mtQjXPUJVDVpU8HjVKtcyqRj
 e5NT0ExYxPVJ3Z5GIYv+yZ9x0r8GrSZOoI90pnA9nMEg7LwWAJLsnBfHUK63Ps3mcg
 tUdrmmWqIfhYW7mjv12EjmIRWI2Y95q8t7RIyhWyMkQvmSt4QTbz7nzQzB+9ddWf4O
 TLIcUNuj6c61g==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 904BA17E0720;
 Wed, 15 Jul 2026 15:57:14 +0200 (CEST)
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
Subject: [PATCH v6 07/11] drm/mediatek: mtk_dsi: Add support for MT8189
Date: Wed, 15 Jul 2026 15:56:59 +0200
Message-ID: <20260715135703.46540-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
References: <20260715135703.46540-1-angelogioacchino.delregno@collabora.com>
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

Add support for the DSI IP found in the MT8189 SoC: this one is
similar to the IPs found in the most recent already supported SoCs
with the only difference being that it supports a higher link rate
of 2.5Gbps instead of 1.5Gbps.

To support the higher rate, add a new "max_link_rate_mbps" member
to the mtk_dsi_driver_data, assign the correct one to all of the
supported SoCs, other than to the newly introduced MT8189, and
use it in the .mode_valid() callback in place of the hardcoded
1.5Gbps value.

Since .mode_valid() is supposed to run just for resolution changes
the link rate was expressed in Mbps and gets multiplied on the fly
to save some bits.

As a note, starting with MT8189, higher maximum pixel clock rates
are achievable: while at it, also make sure that calculations are
not overflowing by casting to u64 where needed.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 ++
 drivers/gpu/drm/mediatek/mtk_dsi.c     | 29 ++++++++++++++++++++++++--
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index bd2d17017bd2..08f6be311dd1 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -826,6 +826,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8188-dsi",
 	  .data = (void *)MTK_DSI },
+	{ .compatible = "mediatek,mt8189-dsi",
+	  .data = (void *)MTK_DSI },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index c5db63b93ff9..3f58683be70f 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -235,6 +235,8 @@ struct mtk_dsi_driver_data {
 	const u16 *reg_main;
 	const u16 *reg_adv;
 
+	const u16 max_link_rate_mbps;
+
 	bool has_size_ctl;
 	bool cmdq_long_packet_ctl;
 	bool support_per_frame_lp;
@@ -926,7 +928,7 @@ static int mtk_dsi_poweron(struct mtk_dsi *dsi)
 	}
 	bit_per_pixel = ret;
 
-	dsi->data_rate = DIV_ROUND_UP_ULL(dsi->vm.pixelclock * bit_per_pixel,
+	dsi->data_rate = DIV_ROUND_UP_ULL((u64)dsi->vm.pixelclock * bit_per_pixel,
 					  dsi->lanes);
 
 	ret = clk_set_rate(dsi->hs_clk, dsi->data_rate);
@@ -1101,13 +1103,21 @@ mtk_dsi_bridge_mode_valid(struct drm_bridge *bridge,
 			  const struct drm_display_mode *mode)
 {
 	struct mtk_dsi *dsi = bridge_to_dsi(bridge);
+	const struct mtk_dsi_driver_data *data = dsi->driver_data;
+	u64 wanted_link_rate, max_link_rate;
 	int bpp;
 
 	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
 	if (bpp < 0)
 		return MODE_ERROR;
 
-	if (mode->clock * bpp / dsi->lanes > 1500000)
+	wanted_link_rate = mode->clock;
+	wanted_link_rate *= bpp;
+	max_link_rate = data->max_link_rate_mbps;
+	max_link_rate *= dsi->lanes;
+	max_link_rate *= KILO;
+
+	if (wanted_link_rate > max_link_rate)
 		return MODE_CLOCK_HIGH;
 
 	if (dsi->dsc) {
@@ -1547,28 +1557,42 @@ static void mtk_dsi_remove(struct platform_device *pdev)
 static const struct mtk_dsi_driver_data mt8173_dsi_driver_data = {
 	.reg_main = mtk_dsi_regs_main_v1,
 	.reg_adv = mtk_dsi_regs_mt8173,
+	.max_link_rate_mbps = 1500,
 };
 
 static const struct mtk_dsi_driver_data mt2701_dsi_driver_data = {
 	.reg_main = mtk_dsi_regs_main_v1,
 	.reg_adv = mtk_dsi_regs_mt2701,
+	.max_link_rate_mbps = 1500,
 };
 
 static const struct mtk_dsi_driver_data mt8183_dsi_driver_data = {
 	.reg_main = mtk_dsi_regs_main_v1,
 	.reg_adv = mtk_dsi_regs_mt8183,
+	.max_link_rate_mbps = 1500,
 	.has_size_ctl = true,
 };
 
 static const struct mtk_dsi_driver_data mt8186_dsi_driver_data = {
 	.reg_main = mtk_dsi_regs_main_v1,
 	.reg_adv = mtk_dsi_regs_mt8186,
+	.max_link_rate_mbps = 1500,
 	.has_size_ctl = true,
 };
 
 static const struct mtk_dsi_driver_data mt8188_dsi_driver_data = {
 	.reg_main = mtk_dsi_regs_main_v1,
 	.reg_adv = mtk_dsi_regs_mt8186,
+	.max_link_rate_mbps = 1500,
+	.has_size_ctl = true,
+	.cmdq_long_packet_ctl = true,
+	.support_per_frame_lp = true,
+};
+
+static const struct mtk_dsi_driver_data mt8189_dsi_driver_data = {
+	.reg_main = mtk_dsi_regs_main_v1,
+	.reg_adv = mtk_dsi_regs_mt8186,
+	.max_link_rate_mbps = 2500,
 	.has_size_ctl = true,
 	.cmdq_long_packet_ctl = true,
 	.support_per_frame_lp = true,
@@ -1581,6 +1605,7 @@ static const struct of_device_id mtk_dsi_of_match[] = {
 	{ .compatible = "mediatek,mt8183-dsi", .data = &mt8183_dsi_driver_data },
 	{ .compatible = "mediatek,mt8186-dsi", .data = &mt8186_dsi_driver_data },
 	{ .compatible = "mediatek,mt8188-dsi", .data = &mt8188_dsi_driver_data },
+	{ .compatible = "mediatek,mt8189-dsi", .data = &mt8189_dsi_driver_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_dsi_of_match);
-- 
2.54.0

