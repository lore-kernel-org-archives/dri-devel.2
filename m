Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45886C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AC5E10EF69;
	Wed,  1 Jul 2026 12:21:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="UiX8SXsX";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E9710EF60
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908488;
 bh=HY6SqikaeT4oUgt2kVfe/4uDj3n9vy195L4GZqCxuk4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UiX8SXsXUDWGOihpySqWHs0dFoHFl6zZQQaShGBbzGX3uHNnpVHGG3S9XEI/ntYEr
 Q88e65I+Xdnr0jGXnr6RJY72+xG8CwfVYucSxDmM7CnFV+pxxGNT2kr8929PyJqPvB
 nzH/T78aFrcqCw2yjHayfYX25jmotDrc17ul48bXJHyPN0kbwphPXH/XPrtPB8y2gV
 0SsEnj85WyqmPJmaSPsOJEBiMzYRY4iZTKthXY84aYeLf0B/VFhajjKHofohSkc/UK
 3Xtc0JtCcXNRCxJj5WmzxcPiPVH3a/gnv6EakkbaYynFKjgSdo6OfH34fXvo8FdOGx
 q5Pj7iJhe30lQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C117217E0FB0;
 Wed,  1 Jul 2026 14:21:27 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com,
 jason-jh.lin@mediatek.com, kernel@collabora.com
Subject: [PATCH 21/42] drm/mediatek: mtk_dpi: Fully separate HW setup from
 common code
Date: Wed,  1 Jul 2026 14:20:36 +0200
Message-ID: <20260701122057.19648-22-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
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

As a preparation step for adding support for DVO and creating a
mtk_dpi_common library, fully separate all of the register writing
mechanisms from commonizable hardware setup functions.

While at it, also perform some spare code style cleanups and also
remove the mtk_dpi_config_vsync_{l,r}{odd,even}() functions and
open-code the single line found in each of those, as now all of
the parameters are clearly labeled and won't have any meaningful
impact on human readability.

This change brings no functional differences.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 172 ++++++++++++++---------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index ecd13ea782c2..077e8a42a044 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -246,33 +246,6 @@ static void mtk_dpi_config_vsync(struct mtk_dpi *dpi,
 		     dpi->conf->dimension_mask << VSYNC_FRONT_PORCH_SHIFT);
 }
 
-static void mtk_dpi_config_vsync_lodd(struct mtk_dpi *dpi,
-				      struct mtk_dpi_sync_param *sync)
-{
-	mtk_dpi_config_vsync(dpi, sync, DPI_TGEN_VWIDTH, DPI_TGEN_VPORCH);
-}
-
-static void mtk_dpi_config_vsync_leven(struct mtk_dpi *dpi,
-				       struct mtk_dpi_sync_param *sync)
-{
-	mtk_dpi_config_vsync(dpi, sync, DPI_TGEN_VWIDTH_LEVEN,
-			     DPI_TGEN_VPORCH_LEVEN);
-}
-
-static void mtk_dpi_config_vsync_rodd(struct mtk_dpi *dpi,
-				      struct mtk_dpi_sync_param *sync)
-{
-	mtk_dpi_config_vsync(dpi, sync, DPI_TGEN_VWIDTH_RODD,
-			     DPI_TGEN_VPORCH_RODD);
-}
-
-static void mtk_dpi_config_vsync_reven(struct mtk_dpi *dpi,
-				       struct mtk_dpi_sync_param *sync)
-{
-	mtk_dpi_config_vsync(dpi, sync, DPI_TGEN_VWIDTH_REVEN,
-			     DPI_TGEN_VPORCH_REVEN);
-}
-
 static void mtk_dpi_config_pol(struct mtk_dpi *dpi,
 			       struct mtk_dpi_polarities *dpi_pol)
 {
@@ -311,30 +284,15 @@ static void mtk_dpi_config_fb_size(struct mtk_dpi *dpi, u32 width, u32 height)
 		     dpi->conf->hvsize_mask << VSIZE);
 }
 
-static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi)
+static void mtk_dpi_config_channel_limit(struct mtk_dpi *dpi, struct mtk_dpi_yc_limit *limit)
 {
-	struct mtk_dpi_yc_limit limit;
-
-	if (drm_default_rgb_quant_range(&dpi->mode) ==
-	    HDMI_QUANTIZATION_RANGE_LIMITED) {
-		limit.y_bottom = 0x10;
-		limit.y_top = 0xfe0;
-		limit.c_bottom = 0x10;
-		limit.c_top = 0xfe0;
-	} else {
-		limit.y_bottom = 0;
-		limit.y_top = 0xfff;
-		limit.c_bottom = 0;
-		limit.c_top = 0xfff;
-	}
-
-	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit.y_bottom << Y_LIMINT_BOT,
+	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit->y_bottom << Y_LIMINT_BOT,
 		     Y_LIMINT_BOT_MASK);
-	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit.y_top << Y_LIMINT_TOP,
+	mtk_dpi_mask(dpi, DPI_Y_LIMIT, limit->y_top << Y_LIMINT_TOP,
 		     Y_LIMINT_TOP_MASK);
-	mtk_dpi_mask(dpi, DPI_C_LIMIT, limit.c_bottom << C_LIMIT_BOT,
+	mtk_dpi_mask(dpi, DPI_C_LIMIT, limit->c_bottom << C_LIMIT_BOT,
 		     C_LIMIT_BOT_MASK);
-	mtk_dpi_mask(dpi, DPI_C_LIMIT, limit.c_top << C_LIMIT_TOP,
+	mtk_dpi_mask(dpi, DPI_C_LIMIT, limit->c_top << C_LIMIT_TOP,
 		     C_LIMIT_TOP_MASK);
 }
 
@@ -516,7 +474,6 @@ static void mtk_dpi_power_off(struct mtk_dpi *dpi)
 	if (--dpi->refcount != 0)
 		return;
 
-	mtk_dpi_disable(dpi);
 	clk_disable_unprepare(dpi->pixel_clk);
 	clk_disable_unprepare(dpi->tvd_clk);
 	clk_disable_unprepare(dpi->engine_clk);
@@ -607,40 +564,40 @@ static void mtk_dpi_set_pixel_clk(struct mtk_dpi *dpi, struct videomode *vm, int
 		pll_rate, vm->pixelclock);
 }
 
-static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
+static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi, struct videomode *vm,
 				    struct mtk_dpi_sync *sync,
-				    struct drm_display_mode *mode)
+				    struct mtk_dpi_polarities *dpi_pol,
+				    struct mtk_dpi_yc_limit *limit)
 {
-	struct mtk_dpi_polarities dpi_pol;
-	struct videomode vm = { 0 };
+	struct drm_display_mode *mode = &dpi->mode;
 
-	drm_display_mode_to_videomode(mode, &vm);
+	drm_display_mode_to_videomode(mode, vm);
 
 	if (!dpi->conf->clocked_by_hdmi)
-		mtk_dpi_set_pixel_clk(dpi, &vm, mode->clock);
+		mtk_dpi_set_pixel_clk(dpi, vm, mode->clock);
 
-	dpi_pol.ck_pol = MTK_DPI_POLARITY_FALLING;
-	dpi_pol.de_pol = MTK_DPI_POLARITY_RISING;
-	dpi_pol.hsync_pol = vm.flags & DISPLAY_FLAGS_HSYNC_HIGH ?
+	dpi_pol->ck_pol = MTK_DPI_POLARITY_FALLING;
+	dpi_pol->de_pol = MTK_DPI_POLARITY_RISING;
+	dpi_pol->hsync_pol = vm->flags & DISPLAY_FLAGS_HSYNC_HIGH ?
 			    MTK_DPI_POLARITY_FALLING : MTK_DPI_POLARITY_RISING;
-	dpi_pol.vsync_pol = vm.flags & DISPLAY_FLAGS_VSYNC_HIGH ?
+	dpi_pol->vsync_pol = vm->flags & DISPLAY_FLAGS_VSYNC_HIGH ?
 			    MTK_DPI_POLARITY_FALLING : MTK_DPI_POLARITY_RISING;
 
 	/*
 	 * Depending on the IP version, we may output a different amount of
 	 * pixels for each iteration: adjust the display porches accordingly.
 	 */
-	sync->hsync.sync_width = vm.hsync_len / dpi->conf->pixels_per_iter;
-	sync->hsync.back_porch = vm.hback_porch / dpi->conf->pixels_per_iter;
-	sync->hsync.front_porch = vm.hfront_porch / dpi->conf->pixels_per_iter;
+	sync->hsync.sync_width = vm->hsync_len / dpi->conf->pixels_per_iter;
+	sync->hsync.back_porch = vm->hback_porch / dpi->conf->pixels_per_iter;
+	sync->hsync.front_porch = vm->hfront_porch / dpi->conf->pixels_per_iter;
 	sync->hsync.shift_half_line = false;
 
-	sync->vsync_l_odd.sync_width = vm.vsync_len;
-	sync->vsync_l_odd.back_porch = vm.vback_porch;
-	sync->vsync_l_odd.front_porch = vm.vfront_porch;
+	sync->vsync_l_odd.sync_width = vm->vsync_len;
+	sync->vsync_l_odd.back_porch = vm->vback_porch;
+	sync->vsync_l_odd.front_porch = vm->vfront_porch;
 	sync->vsync_l_odd.shift_half_line = false;
 
-	if (vm.flags & DISPLAY_FLAGS_INTERLACED) {
+	if (vm->flags & DISPLAY_FLAGS_INTERLACED) {
 		sync->vsync_l_even = sync->vsync_l_odd;
 		sync->vsync_l_even.shift_half_line = true;
 
@@ -653,27 +610,55 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 		sync->vsync_r_odd = sync->vsync_l_odd;
 	}
 
+	if (drm_default_rgb_quant_range(&dpi->mode) == HDMI_QUANTIZATION_RANGE_LIMITED) {
+		limit->y_bottom = 0x10;
+		limit->y_top = 0xfe0;
+		limit->c_bottom = 0x10;
+		limit->c_top = 0xfe0;
+	} else {
+		limit->y_bottom = 0;
+		limit->y_top = 0xfff;
+		limit->c_bottom = 0;
+		limit->c_top = 0xfff;
+	}
+
+	return 0;
+}
+
+static void mtk_dpi_config_hw(struct mtk_dpi *dpi,
+			      struct videomode *vm, struct mtk_dpi_sync *sync,
+			      struct mtk_dpi_polarities *dpi_pol,
+			      struct mtk_dpi_yc_limit *limit)
+{
+	struct drm_display_mode *mode = &dpi->mode;
+	u32 vactive = vm->vactive;
+
 	mtk_dpi_sw_reset(dpi, true);
-	mtk_dpi_config_pol(dpi, &dpi_pol);
+	mtk_dpi_config_pol(dpi, dpi_pol);
 
 	mtk_dpi_config_hsync(dpi, &sync->hsync);
-	mtk_dpi_config_vsync_lodd(dpi, &sync->vsync_l_odd);
-	mtk_dpi_config_vsync_rodd(dpi, &sync->vsync_r_odd);
-	mtk_dpi_config_vsync_leven(dpi, &sync->vsync_l_even);
-	mtk_dpi_config_vsync_reven(dpi, &sync->vsync_r_even);
+
+	mtk_dpi_config_vsync(dpi, &sync->vsync_l_odd,
+			     DPI_TGEN_VWIDTH, DPI_TGEN_VPORCH);
+	mtk_dpi_config_vsync(dpi, &sync->vsync_r_odd,
+			     DPI_TGEN_VWIDTH_RODD, DPI_TGEN_VPORCH_RODD);
+	mtk_dpi_config_vsync(dpi, &sync->vsync_l_even,
+			     DPI_TGEN_VWIDTH_LEVEN, DPI_TGEN_VPORCH_LEVEN);
+	mtk_dpi_config_vsync(dpi, &sync->vsync_r_even,
+			     DPI_TGEN_VWIDTH_REVEN, DPI_TGEN_VPORCH_REVEN);
 
 	mtk_dpi_config_3d(dpi, !!(mode->flags & DRM_MODE_FLAG_3D_MASK));
-	mtk_dpi_config_interface(dpi, !!(vm.flags &
-					 DISPLAY_FLAGS_INTERLACED));
-	if (vm.flags & DISPLAY_FLAGS_INTERLACED)
-		mtk_dpi_config_fb_size(dpi, vm.hactive, vm.vactive >> 1);
-	else
-		mtk_dpi_config_fb_size(dpi, vm.hactive, vm.vactive);
+	mtk_dpi_config_interface(dpi, !!(vm->flags & DISPLAY_FLAGS_INTERLACED));
+
+	if (vm->flags & DISPLAY_FLAGS_INTERLACED)
+		vactive >>= 1;
 
-	mtk_dpi_config_channel_limit(dpi);
+	mtk_dpi_config_fb_size(dpi, vm->hactive, vactive);
+	mtk_dpi_config_channel_limit(dpi, limit);
 	mtk_dpi_config_bit_num(dpi, dpi->bit_num);
 	mtk_dpi_config_channel_swap(dpi, dpi->channel_swap);
 	mtk_dpi_config_color_format(dpi, dpi->color_format);
+
 	if (dpi->conf->support_direct_pin) {
 		mtk_dpi_config_yc_map(dpi, dpi->yc_map);
 		mtk_dpi_config_2n_h_fre(dpi);
@@ -686,13 +671,13 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 
 		mtk_dpi_config_disable_edge(dpi);
 	}
-	if (dpi->conf->input_2p_en_bit) {
+
+	if (dpi->conf->input_2p_en_bit)
 		mtk_dpi_mask(dpi, DPI_CON, dpi->conf->input_2p_en_bit,
 			     dpi->conf->input_2p_en_bit);
-	}
-	mtk_dpi_sw_reset(dpi, false);
 
-	return 0;
+	mtk_dpi_sw_reset(dpi, false);
+	return;
 }
 
 static u32 *mtk_dpi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
@@ -855,6 +840,7 @@ static void mtk_dpi_bridge_disable(struct drm_bridge *bridge)
 {
 	struct mtk_dpi *dpi = bridge_to_dpi(bridge);
 
+	mtk_dpi_disable(dpi);
 	mtk_dpi_power_off(dpi);
 
 	if (dpi->pinctrl && dpi->pins_gpio)
@@ -864,13 +850,22 @@ static void mtk_dpi_bridge_disable(struct drm_bridge *bridge)
 static void mtk_dpi_bridge_enable(struct drm_bridge *bridge)
 {
 	struct mtk_dpi *dpi = bridge_to_dpi(bridge);
+	struct mtk_dpi_polarities dpi_pol;
 	struct mtk_dpi_sync sync = { 0 };
+	struct mtk_dpi_yc_limit limit;
+	struct videomode vm;
 
 	if (dpi->pinctrl && dpi->pins_dpi)
 		pinctrl_select_state(dpi->pinctrl, dpi->pins_dpi);
 
 	mtk_dpi_power_on(dpi);
-	mtk_dpi_set_display_mode(dpi, &sync, &dpi->mode);
+
+	/* Set pixel clock and initialize parameters to send to the HW */
+	mtk_dpi_set_display_mode(dpi, &vm, &sync, &dpi_pol, &limit);
+
+	/* Format and send the parameters to the HW */
+	mtk_dpi_config_hw(dpi, &vm, &sync, &dpi_pol, &limit);
+
 	mtk_dpi_enable(dpi);
 }
 
@@ -999,16 +994,21 @@ void mtk_dpi_start(struct device *dev)
 {
 	struct mtk_dpi *dpi = dev_get_drvdata(dev);
 
-	if (!dpi->conf->clocked_by_hdmi)
-		mtk_dpi_power_on(dpi);
+	if (dpi->conf->clocked_by_hdmi)
+		return;
+
+	mtk_dpi_power_on(dpi);
 }
 
 void mtk_dpi_stop(struct device *dev)
 {
 	struct mtk_dpi *dpi = dev_get_drvdata(dev);
 
-	if (!dpi->conf->clocked_by_hdmi)
-		mtk_dpi_power_off(dpi);
+	if (dpi->conf->clocked_by_hdmi)
+		return;
+
+	mtk_dpi_disable(dpi);
+	mtk_dpi_power_off(dpi);
 }
 
 unsigned int mtk_dpi_encoder_index(struct device *dev)
-- 
2.54.0

