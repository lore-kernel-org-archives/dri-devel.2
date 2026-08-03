Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E273C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FDC110E6F7;
	Mon,  3 Aug 2026 14:57:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="h2PISO7U";
	dkim-atps=neutral
Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch
 [185.70.43.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7306110E6F0
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785769035; x=1786028235;
 bh=7J6ydw4tXYe53kVdrjkSOhg9eiJL2F6GMm09fOeodoA=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=h2PISO7U/FAotAeQjCcRMzflBxwPiEeQEwsZpuNZ9D8YbRRXzU/8I9yltIG/tD/0o
 I0DLPaFJpwuZ1OxtnuW+vkcV6fb1t0pxeVCIL3dVlWp2Nz72PNwDxKdGYwaLMAb7+K
 GFioobCAkXyprgwTxvCn+OVVHGx9c2t9pboSDLrZOztBuQBfIltadZRSUrFNvybyL7
 HCZKv6EPd4ZlDLlNJTTC8uac1H05hy2aiTLtV+K5iNSdgpQzivAqreitmUhunmB9rl
 AAfvoDPd+sv4Yyv0PI952rfN/xRAaN3PvB9blYXcQKCFnp+XNn/n9c8hSyCmL3rNhk
 I5Or4FDSqH3FA==
X-Pm-Submission-Id: 4hDKXC0hxHz1DFF3
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 03 Aug 2026 16:57:05 +0200
Subject: [PATCH v3 3/3] drm/bridge: ti-sn65dsi83: Support LVDS Channel B on
 SN65DSI84
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-ti-sn65dsi83-fixes-v3-3-9b403a405ccd@geanix.com>
References: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
In-Reply-To: <20260803-ti-sn65dsi83-fixes-v3-0-9b403a405ccd@geanix.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Linus Walleij <linusw@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785769029; l=3859;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=bqdZXy04IePD71NX1IPGcT1EZ39CRd/G13MuL02gH5w=;
 b=B1TsBn3U/VMAfax411RNuwNZU4OpyE8F98DRA+Osv0YSkU1V0Td2L3x05rkSHC76/CaCBoISw
 z8Hmz+N2paBDjr3jMS3e0jHbKc0P/LmuXivBMo3M3wh1udR0z4w3j+A
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
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

This adds support for using SN65DSI84 in single-link mode with output to
LVDS Channel B.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 5551845ea0dd..b830538b405b 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -11,6 +11,8 @@
  *   = 1x Single-link DSI ~ 2x Single-link or 1x Dual-link LVDS
  *   - Supported
  *   - Dual-link LVDS mode tested
+ *   - Single-link to LVDS Channel A tested
+ *   - Single-link to LVDS Channel B tested
  *   - 2x Single-link LVDS mode unsupported
  *     (should be easy to add by someone who has the HW)
  * - SN65DSI85
@@ -162,7 +164,7 @@ struct sn65dsi83 {
 	struct gpio_desc		*enable_gpio;
 	struct regulator		*vcc;
 	bool				lvds_dual_link;
-	bool				lvds_dual_link_even_odd_swap;
+	bool				lvds_channel_swap;
 	int				lvds_vod_swing_conf[2];
 	int				lvds_term_conf[2];
 	int				irq;
@@ -643,7 +645,7 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 			REG_LVDS_VCOM_CHA_LVDS_VOD_SWING(ctx->lvds_vod_swing_conf[CHANNEL_A]) |
 			REG_LVDS_VCOM_CHB_LVDS_VOD_SWING(ctx->lvds_vod_swing_conf[CHANNEL_B]));
 	regmap_write(ctx->regmap, REG_LVDS_LANE,
-		     (ctx->lvds_dual_link_even_odd_swap ?
+		     (ctx->lvds_channel_swap ?
 		      REG_LVDS_LANE_EVEN_ODD_SWAP : 0) |
 		     (ctx->lvds_term_conf[CHANNEL_A] ?
 			  REG_LVDS_LANE_CHA_LVDS_TERM : 0) |
@@ -894,6 +896,7 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
 {
 	struct drm_bridge *panel_bridge;
 	struct device *dev = ctx->dev;
+	u32 output_port = 2;
 	int ret;
 
 	ret = sn65dsi83_parse_lvds_endpoint(ctx, CHANNEL_A);
@@ -905,29 +908,38 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
 		return ret;
 
 	ctx->lvds_dual_link = false;
-	ctx->lvds_dual_link_even_odd_swap = false;
+	ctx->lvds_channel_swap = false;
 	if (model != MODEL_SN65DSI83) {
-		struct device_node *port2, *port3;
+		struct device_node *port0, *port1, *port2, *port3;
 		int dual_link;
 
+		port0 = of_graph_get_port_by_id(dev->of_node, 0);
+		port1 = of_graph_get_port_by_id(dev->of_node, 1);
 		port2 = of_graph_get_port_by_id(dev->of_node, 2);
 		port3 = of_graph_get_port_by_id(dev->of_node, 3);
 		dual_link = drm_of_lvds_get_dual_link_pixel_order(port2, port3);
-		of_node_put(port2);
-		of_node_put(port3);
 
 		if (dual_link == DRM_LVDS_DUAL_LINK_ODD_EVEN_PIXELS) {
-			ctx->lvds_dual_link = true;
 			/* Odd pixels to LVDS Channel A, even pixels to B */
-			ctx->lvds_dual_link_even_odd_swap = false;
-		} else if (dual_link == DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS) {
 			ctx->lvds_dual_link = true;
+		} else if (dual_link == DRM_LVDS_DUAL_LINK_EVEN_ODD_PIXELS) {
 			/* Even pixels to LVDS Channel A, odd pixels to B */
-			ctx->lvds_dual_link_even_odd_swap = true;
+			ctx->lvds_dual_link = true;
+			ctx->lvds_channel_swap = true;
+		} else if (port0 && !port1 && port2 && !port3) {
+			/* DSI Channel A to LVDS Channel A */
+		} else if (port0 && !port1 && !port2 && port3) {
+			/* DSI Channel A to LVDS Channel B */
+			ctx->lvds_channel_swap = true;
+			output_port = 3;
 		}
+		of_node_put(port0);
+		of_node_put(port1);
+		of_node_put(port2);
+		of_node_put(port3);
 	}
 
-	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
+	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, output_port, 0);
 	if (IS_ERR(panel_bridge))
 		return dev_err_probe(dev, PTR_ERR(panel_bridge), "Failed to get panel bridge\n");
 

-- 
2.55.0

