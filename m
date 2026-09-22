Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8318AC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:17:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8594210E742;
	Tue, 22 Sep 2026 06:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="DEijqZdH";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F262C10E35D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
 Reply-To:Content-ID:Content-Description;
 bh=vJZZJlgqSTq1ItDpGK2L5K9Nw6kWH7euwhjPFDICo3Y=; t=1790057855; x=1791267455; 
 b=DEijqZdH0MH47R62IAs/BGdvFNC4thBIk3Us2xc+mAai0KedDrPuBBcc5nc/LMbi2aDmlRuiu7t
 An3rZUI9zLmXWmXXcq7sEKwJcvUwkahmbBoXHKEokxgikL8+/OcaHL1YYyym9NmspcCJk99RFgDnM
 9Y5TEGQ6BxnlLd6OHd2a6nYFvuH8TQmQDxdY1dTLzX04PawpIRChURIr6wlFWl31rI9Cjxe6p4U6L
 fD2J8clP0vG9zaBg/BhgkKxDdDfmsXk4ylswT6oVtgDTZfRkAHP7AXH41YCzUp0bIfWPPUmRUyHRj
 LnQDE9ncD6AK9yN6RXJhEhGaiuzxqVrgafsw==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:17:05 +0200
Subject: [PATCH RFC 8/9] drm/bridge: tc358762: Basic support for 2 lanes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-8-45ff36b364cf@kemnade.info>
References: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
In-Reply-To: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 hns@goldelico.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.16.1-dev-53874
X-Developer-Signature: v=1; a=openpgp-sha256; l=6006; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=ZJ58LzJ2jrYN033jXkMli6AXdpzXramyNMhGzt3PCbE=; 
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBPj7of3ZlyqFj2o/DC94IoQo27kwiqVmbuO86hOk
 tS38LrdUcrCIMbFICumyPLLWsHtk8qz3OCpEfYwc1iZQIYwcHEKwEQW1DL8T1/AZjnlda681uzJ
 VZM11r1YUdkdvfNq4L0veSab+hhYYxkZerz+TA5S0LEralA/uXLjorQbKxcXWJa9/dMemVf1aXs
 MGwA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
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

Add support for 2 data lanes. Enabling the PLL is required. This are just
the values working for the Epson Moverio BT-200. With the standard mode
flags, the panel mode was deemed unusable, adjust them to have more freedom
in case of 2 data lanes operation.
Nice looking values for the input clock for the PLL were not found.

Setting the required register needs special sequences, entering ULPS in
between is the way to do it in the vendor kernel. It seems that some
stop mode transitions are also enough. This all seems not to work
if LPM is used for writing the register, to temporarily disable that.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/bridge/tc358762.c | 87 +++++++++++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 194785bff997..632597fec20d 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -100,6 +100,8 @@
 #define SYSCTRL_PCLKDIV_DIV_2	2
 #define SYSCTRL_PCLKDIV_DIV_3	4
 
+#define SYSPLL3                         0x0470          /*  */
+
 #define IDREG			0x04A0 /* Chip and Revision ID */
 
 struct tc358762 {
@@ -183,6 +185,7 @@ static void tc358762_post_disable(struct drm_bridge *bridge,
 	if (!ctx->pre_enabled)
 		return;
 
+	to_mipi_dsi_device(ctx->dev)->mode_flags |= MIPI_DSI_MODE_LPM;
 	ctx->pre_enabled = false;
 
 	/* Turn off the DPI output */
@@ -208,7 +211,9 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 	u32 lcdctrl;
 	int ret;
 	u32 id;
+	u32 sysctrl;
 
+	to_mipi_dsi_device(ctx->dev)->mode_flags |= MIPI_DSI_MODE_LPM;
 	ret = regulator_enable(ctx->regulator);
 	if (ret < 0)
 		dev_err(ctx->dev, "error enabling regulators (%d)\n", ret);
@@ -233,15 +238,26 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 
 	tc358762_write(ctx, RDPKTLN, 3);
 
-	tc358762_write(ctx, SYSCTRL,
-		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
-		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
-		       FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_3));
+	sysctrl = FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
+		  FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA);
+
+	if (to_mipi_dsi_device(ctx->dev)->lanes == 2)
+		sysctrl |= FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_2);
+	else
+		sysctrl |= FIELD_PREP(SYSCTRL_PCLKDIV_MASK, SYSCTRL_PCLKDIV_DIV_3);
+
+	tc358762_write(ctx, SYSCTRL, sysctrl);
 
 	msleep(100);
 
-	tc358762_write(ctx, DSI_LANEENABLE,
-		       DSI_LANEENABLE_L0EN | DSI_LANEENABLE_CLEN);
+	if (to_mipi_dsi_device(ctx->dev)->lanes == 2)  {
+		tc358762_write(ctx, DSI_LANEENABLE,
+			       DSI_LANEENABLE_L0EN | DSI_LANEENABLE_CLEN |
+			       DSI_LANEENABLE_L1EN);
+	} else {
+		tc358762_write(ctx, DSI_LANEENABLE,
+			       DSI_LANEENABLE_L0EN | DSI_LANEENABLE_CLEN);
+	}
 	tc358762_write(ctx, PPI_D0S_CLRSIPOCOUNT, 5);
 	tc358762_write(ctx, PPI_D1S_CLRSIPOCOUNT, 5);
 	tc358762_write(ctx, PPI_D0S_ATMR, 0);
@@ -329,6 +345,43 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 static void tc358762_enable(struct drm_bridge *bridge,
 			    struct drm_atomic_commit *state)
 {
+	struct tc358762 *ctx = bridge_to_tc358762(bridge);
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	int ret;
+	u32 syspll;
+
+	if (dsi->lanes == 2) {
+		tc358762_read(ctx, SYSPLL3, &syspll);
+		dev_dbg(ctx->dev, "syspll reg: %x\n", syspll);
+		/*
+		 * as handling of these registers is bound to certain
+		 * conditions, avoid write if already set
+		 */
+		if (syspll != 0xB8640000) {
+			dsi->mode_flags &= ~MIPI_DSI_MODE_LPM;
+			/*
+			 * SYSPLL3 seems to get set to 0x47000000 without it.
+			 * Also trigger some stop mode transitions
+			 * TODO: find some sane value for clock input and add proper dividers
+			 */
+			tc358762_write(ctx, SYSPLL3, 0xB8640000);
+			ret = tc358762_clear_error(ctx);
+			if (ret) {
+				dev_err(ctx->dev, "error writing to SYSPLL3: %d\n", ret);
+				return;
+			}
+
+			msleep(20);
+			/*
+			 * control read to see if this is wonky, probably also includes
+			 * stop mode transitions
+			 */
+			ret = tc358762_read(ctx, SYSPLL3, &syspll);
+
+			if ((ret) || (syspll != 0xB8640000))
+				dev_err(ctx->dev, "failed to configure PLL %d\n", ret);
+		}
+	}
 }
 
 static int tc358762_attach(struct drm_bridge *bridge,
@@ -355,6 +408,7 @@ static int tc358762_parse_dt(struct tc358762 *ctx)
 {
 	struct drm_bridge *panel_bridge;
 	struct device *dev = ctx->dev;
+	u32 lanes;
 
 	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
 	if (IS_ERR(panel_bridge))
@@ -367,6 +421,13 @@ static int tc358762_parse_dt(struct tc358762 *ctx)
 	if (IS_ERR(ctx->reset_gpio))
 		return PTR_ERR(ctx->reset_gpio);
 
+	if (!device_property_read_u32(dev, "dsi-lanes", &lanes)) {
+		if (lanes > 2)
+			return -EINVAL;
+
+		to_mipi_dsi_device(ctx->dev)->lanes = lanes;
+	}
+
 	ctx->lpx_period = 3;
 	device_property_read_u32(dev, "toshiba,lptxtimecnt", &ctx->lpx_period);
 
@@ -459,13 +520,21 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	 */
 	dsi->lanes = 1;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_VIDEO_HSE;
-
 	ret = tc358762_parse_dt(ctx);
 	if (ret < 0)
 		return ret;
 
+	if (dsi->lanes == 2) {
+		dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+				  MIPI_DSI_CLOCK_NON_CONTINUOUS |
+				  MIPI_DSI_MODE_LPM;
+
+		dsi->hs_rate = 800000000;
+		dsi->lp_rate = 9200000;
+	} else
+		dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+				  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_VIDEO_HSE;
+
 	ret = tc358762_configure_regulators(ctx);
 	if (ret < 0)
 		return ret;

-- 
2.47.3

