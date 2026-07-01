Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65BB9C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 872D610EF60;
	Wed,  1 Jul 2026 12:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="aGppXzUp";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2F0710EF60
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908487;
 bh=IFQMzo5MMk1S1Mty+oUI7UnGCWEBa2j8dJeUROqw7Cs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aGppXzUpwXh3xOiHnUCnfrLjloFRcsANxhSqm2gShnzUS72hqQVUifwzj0dtKIwBy
 GGC9H6Oo1ZKLiH16+XxNAg6Wl01LLLF9Jg1IK/VZTcCOgydwgvP90ANKwGyScCIkK/
 Gnjc9yn9vfmxDip2P0aDhz/NJxGqCAjCxtbt+TKL9GjnkyzyvL5646Fo+Nhm1A1o/K
 cOsnw6fIEUnGssA2vXfH9sN5JYJ88tLmKjLYagxrM84sqJi/wHkVhlu/8EwiGD63zL
 ZIRN8OldB6nurRqL/SBEoz7gKik4Jph1scDHNxv0Xyvq2q1RMiPd0qlTiwcl4sqnf4
 jNoLtzVdQIqtw==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9D15017E0F44;
 Wed,  1 Jul 2026 14:21:26 +0200 (CEST)
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
Subject: [PATCH 20/42] drm/mediatek: mtk_dpi: Pass parameters with new
 mtk_dpi_sync structure
Date: Wed,  1 Jul 2026 14:20:35 +0200
Message-ID: <20260701122057.19648-21-angelogioacchino.delregno@collabora.com>
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

In preparation for moving common code between DPI and DVO into a
new mtk_dpi_common library, add a new mtk_dpi_sync structure which
contains all of the sync parameters, such as HSYNC and Left/Right
Odd and Even VSYNC.

This is now passed as parameter of mtk_dpi_set_display_mode() and
stack initialized in mtk_dpi_bridge_enable(): future preparation
changes will add abstraction for hardware specific configuration
which purpose will be to interpret the generic parameters to write
those to the hardware specific registers.

This brings no functional change.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c | 76 +++++++++++++++---------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index cc6d74ce8b5e..ecd13ea782c2 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -112,6 +112,14 @@ struct mtk_dpi_sync_param {
 	bool shift_half_line;
 };
 
+struct mtk_dpi_sync {
+	struct mtk_dpi_sync_param hsync;
+	struct mtk_dpi_sync_param vsync_l_odd;
+	struct mtk_dpi_sync_param vsync_l_even;
+	struct mtk_dpi_sync_param vsync_r_odd;
+	struct mtk_dpi_sync_param vsync_r_even;
+};
+
 struct mtk_dpi_yc_limit {
 	u16 y_top;
 	u16 y_bottom;
@@ -600,14 +608,10 @@ static void mtk_dpi_set_pixel_clk(struct mtk_dpi *dpi, struct videomode *vm, int
 }
 
 static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
+				    struct mtk_dpi_sync *sync,
 				    struct drm_display_mode *mode)
 {
 	struct mtk_dpi_polarities dpi_pol;
-	struct mtk_dpi_sync_param hsync;
-	struct mtk_dpi_sync_param vsync_lodd = { 0 };
-	struct mtk_dpi_sync_param vsync_leven = { 0 };
-	struct mtk_dpi_sync_param vsync_rodd = { 0 };
-	struct mtk_dpi_sync_param vsync_reven = { 0 };
 	struct videomode vm = { 0 };
 
 	drm_display_mode_to_videomode(mode, &vm);
@@ -624,42 +628,39 @@ static int mtk_dpi_set_display_mode(struct mtk_dpi *dpi,
 
 	/*
 	 * Depending on the IP version, we may output a different amount of
-	 * pixels for each iteration: divide the clock by this number and
-	 * adjust the display porches accordingly.
+	 * pixels for each iteration: adjust the display porches accordingly.
 	 */
-	hsync.sync_width = vm.hsync_len / dpi->conf->pixels_per_iter;
-	hsync.back_porch = vm.hback_porch / dpi->conf->pixels_per_iter;
-	hsync.front_porch = vm.hfront_porch / dpi->conf->pixels_per_iter;
-
-	hsync.shift_half_line = false;
-	vsync_lodd.sync_width = vm.vsync_len;
-	vsync_lodd.back_porch = vm.vback_porch;
-	vsync_lodd.front_porch = vm.vfront_porch;
-	vsync_lodd.shift_half_line = false;
-
-	if (vm.flags & DISPLAY_FLAGS_INTERLACED &&
-	    mode->flags & DRM_MODE_FLAG_3D_MASK) {
-		vsync_leven = vsync_lodd;
-		vsync_rodd = vsync_lodd;
-		vsync_reven = vsync_lodd;
-		vsync_leven.shift_half_line = true;
-		vsync_reven.shift_half_line = true;
-	} else if (vm.flags & DISPLAY_FLAGS_INTERLACED &&
-		   !(mode->flags & DRM_MODE_FLAG_3D_MASK)) {
-		vsync_leven = vsync_lodd;
-		vsync_leven.shift_half_line = true;
-	} else if (!(vm.flags & DISPLAY_FLAGS_INTERLACED) &&
-		   mode->flags & DRM_MODE_FLAG_3D_MASK) {
-		vsync_rodd = vsync_lodd;
+	sync->hsync.sync_width = vm.hsync_len / dpi->conf->pixels_per_iter;
+	sync->hsync.back_porch = vm.hback_porch / dpi->conf->pixels_per_iter;
+	sync->hsync.front_porch = vm.hfront_porch / dpi->conf->pixels_per_iter;
+	sync->hsync.shift_half_line = false;
+
+	sync->vsync_l_odd.sync_width = vm.vsync_len;
+	sync->vsync_l_odd.back_porch = vm.vback_porch;
+	sync->vsync_l_odd.front_porch = vm.vfront_porch;
+	sync->vsync_l_odd.shift_half_line = false;
+
+	if (vm.flags & DISPLAY_FLAGS_INTERLACED) {
+		sync->vsync_l_even = sync->vsync_l_odd;
+		sync->vsync_l_even.shift_half_line = true;
+
+		if (mode->flags & DRM_MODE_FLAG_3D_MASK) {
+			sync->vsync_r_odd = sync->vsync_l_odd;
+			sync->vsync_r_even = sync->vsync_l_odd;
+			sync->vsync_r_even.shift_half_line = true;
+		}
+	} else if (mode->flags & DRM_MODE_FLAG_3D_MASK) {
+		sync->vsync_r_odd = sync->vsync_l_odd;
 	}
+
 	mtk_dpi_sw_reset(dpi, true);
 	mtk_dpi_config_pol(dpi, &dpi_pol);
 
-	mtk_dpi_config_hsync(dpi, &hsync);
-	mtk_dpi_config_vsync_lodd(dpi, &vsync_lodd);
-	mtk_dpi_config_vsync_rodd(dpi, &vsync_rodd);
-	mtk_dpi_config_vsync_leven(dpi, &vsync_leven);
-	mtk_dpi_config_vsync_reven(dpi, &vsync_reven);
+	mtk_dpi_config_hsync(dpi, &sync->hsync);
+	mtk_dpi_config_vsync_lodd(dpi, &sync->vsync_l_odd);
+	mtk_dpi_config_vsync_rodd(dpi, &sync->vsync_r_odd);
+	mtk_dpi_config_vsync_leven(dpi, &sync->vsync_l_even);
+	mtk_dpi_config_vsync_reven(dpi, &sync->vsync_r_even);
 
 	mtk_dpi_config_3d(dpi, !!(mode->flags & DRM_MODE_FLAG_3D_MASK));
 	mtk_dpi_config_interface(dpi, !!(vm.flags &
@@ -863,12 +864,13 @@ static void mtk_dpi_bridge_disable(struct drm_bridge *bridge)
 static void mtk_dpi_bridge_enable(struct drm_bridge *bridge)
 {
 	struct mtk_dpi *dpi = bridge_to_dpi(bridge);
+	struct mtk_dpi_sync sync = { 0 };
 
 	if (dpi->pinctrl && dpi->pins_dpi)
 		pinctrl_select_state(dpi->pinctrl, dpi->pins_dpi);
 
 	mtk_dpi_power_on(dpi);
-	mtk_dpi_set_display_mode(dpi, &dpi->mode);
+	mtk_dpi_set_display_mode(dpi, &sync, &dpi->mode);
 	mtk_dpi_enable(dpi);
 }
 
-- 
2.54.0

