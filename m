Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A12DC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B3F210E861;
	Mon, 28 Sep 2026 09:56:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.b="GWCN68O8";
	dkim-atps=neutral
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2161710E909
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 09:56:25 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 0112F2001F2;
 Mon, 28 Sep 2026 11:56:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1790589384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LuymVPYOeFAgj5ouYzllJ1mO8H9HkFW/AWhP83jbnI=;
 b=GWCN68O8Zb6p/9/DXqR3kOKZWFjSnABczRl9jhLdMrKz7uAWw4+4bnRmVrRds3d4eT+0Wo
 CPkrBdO0S30RcX7/grHcCchBUKq9AcxSjUr2bZp79PdGJFned7UAIDwI8bpbMyimmSB5PK
 4PqSjlqpe3ssoUHCn5UjJRCLEfuF+ymk5gJ2a2eTXSIa6Pl244+6vQtDQhJPpBTfTkCE0b
 emQC6b5GWQOnY2I7hMUXPNvj8aqzBAiLlm2dWW2ogIA95GfBugpYr+1Pm1vZhWqMTW3GMU
 KeUGJKRb9k0qxShEUJeBIXDPQRTOhDsonVMkKYjPWRgVNjjNF+GEktu2QDkY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1790589384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6LuymVPYOeFAgj5ouYzllJ1mO8H9HkFW/AWhP83jbnI=;
 b=cwifMkiBvbVBYCKb0nVPnTur6/uQz+5veMWsqrcuqAcqVyQj1hKonxiz+TtMRHrT/j36MF
 O098vXUDHj2lYgO+4XRwniAngMhFIpGkvE2BUGAih5ZNhf3+e0vK6wAr2cNcZFg1WAWFrS
 8hgLZWkYVaDhbR5sRo9qV7uszD4AI80zJkDck7a11cSxT5Z5i3S4M8QHecEYwtobU2glW6
 j54u88detZPjXcKau9N9aC5hz/16+mr/N5yYULKzfE1H6ySN2proHCr3zEF2IvxJKgZEyZ
 x80vDGbTdKt4eCFyJczDOgGPuCeeqX09c7DyyFj06X/2IHrwYfpvIK/EfBRBEg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790589384; a=rsa-sha256;
 cv=none;
 b=dEkMY0j2VqybOpRFC0MZQnXvjh6ZmIVQ/dP5vmSLXT+wxkazFCpa/UKHmoQVnt/s1zt/r5
 VngR+zBn1TZaEVGeeikmwWpRDvEN5xwNO9mcSuIYfBpwUcUUT/VeX4sf10gLQ3JSwR7rHf
 CpXyyrT9FtKcz2+ruFQnExliEhzOZfTaOFJkKaJ7RkuMA/9udYJZZSi8rEuLsxPn6S2XBV
 Gz4ZmpRpttpVMLCsU9Wa3LCXaTLRxwnSP2HojO9fU6dxmguiBmgh03VeyLfJ4R0l690um4
 +AxOn85Gum2wKAq5PV4mZm+WONHPbe94JvPfMuLEsMCZ22KHfftzPDC0ZXwZYw==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de
 smtp.mailfrom=p.zabel@pengutronix.de
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e])
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1xB85v-003Cfy-2m;
 Mon, 28 Sep 2026 11:56:23 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yi Zhang <zhanyi@qti.qualcomm.com>,
 Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH] drm/bridge: lt9211: drop delayed work
Date: Mon, 28 Sep 2026 11:56:22 +0200
Message-ID: <20260928095622.38130-1-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260924-add-lt9211c-bridge-v9-2-d78b39677a61@oss.qualcomm.com>
References: <20260924-add-lt9211c-bridge-v9-2-d78b39677a61@oss.qualcomm.com>
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

Replace the asynchronous work item with synchronous initialization in
lt9211_atomic_enable. This should fix 3 issues flagged by sashiko [1].

The next bridge or panel in the chain may depend on the LVDS signal
being active after atomic_enable, so arbitrarily deferring bridge
initialization is not an option.

If deferring initialization into an asynchronous work item fixes DSI
stream detection, there might be a bug in the upstream display
controller or MIPI DSI host controller bridge drivers, as the DSI
signal should already be streaming when lt9211_atomic_enable is called.

[1] https://lore.kernel.org/all/20260924160816.ED8F31F0089E@smtp.kernel.org/

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/bridge/lontium-lt9211.c | 121 ++++++++----------------
 1 file changed, 38 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index 9226d967b271..244979fb9ae6 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -20,7 +20,6 @@
 #include <linux/of_graph.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
-#include <linux/workqueue.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
@@ -72,14 +71,6 @@ struct lt9211 {
 	bool				lvds_dual_link;
 	bool				lvds_dual_link_even_odd_swap;
 	const struct lt9211_chip_data	*chip_data;
-	/* LT9211C specific fields */
-	struct workqueue_struct		*wq;
-	struct work_struct		lt9211_work;
-	struct drm_crtc			*lt9211c_crtc;
-	struct drm_display_mode	lt9211c_mode;
-	bool				lt9211c_bpp24;
-	bool				lt9211c_jeida;
-	bool				lt9211c_de_high;
 };
 
 static const struct regmap_range lt9211_rw_ranges[] = {
@@ -1157,51 +1148,6 @@ static int lt9211c_configure_tx(struct lt9211 *ctx, bool jeida, bool bpp24,
 	return 0;
 }
 
-static void lt9211_work_func(struct work_struct *work)
-{
-	struct lt9211 *ctx = container_of(work, struct lt9211, lt9211_work);
-	const struct drm_display_mode *mode = &ctx->lt9211c_mode;
-	int ret;
-
-	/* wait for vblank irq to correctly configure bridge and autodetect stream */
-	ret = drm_crtc_wait_one_vblank(ctx->lt9211c_crtc);
-	if (ret) {
-		dev_err(ctx->dev, "LT9211C: wait for vblank failed: %d\n", ret);
-		return;
-	}
-
-	ret = lt9211c_configure_rx(ctx);
-	if (ret) {
-		dev_err(ctx->dev, "LT9211C: configure_rx failed: %d\n", ret);
-		return;
-	}
-
-	ret = lt9211c_autodetect_rx(ctx, mode);
-	if (ret) {
-		dev_err(ctx->dev, "LT9211C: autodetect_rx failed: %d\n", ret);
-		return;
-	}
-
-	ret = lt9211c_configure_timing(ctx, mode);
-	if (ret) {
-		dev_err(ctx->dev, "LT9211C: configure_timing failed: %d\n", ret);
-		return;
-	}
-
-	ret = lt9211c_configure_plls(ctx, mode);
-	if (ret) {
-		dev_err(ctx->dev, "LT9211C: configure_plls failed: %d\n", ret);
-		return;
-	}
-
-	ret = lt9211c_configure_tx(ctx, ctx->lt9211c_jeida, ctx->lt9211c_bpp24,
-				   ctx->lt9211c_de_high, mode);
-	if (ret) {
-		dev_err(ctx->dev, "LT9211C: configure_tx failed: %d\n", ret);
-		return;
-	}
-}
-
 static void lt9211_atomic_enable(struct drm_bridge *bridge,
 				 struct drm_atomic_state *state)
 {
@@ -1272,17 +1218,45 @@ static void lt9211_atomic_enable(struct drm_bridge *bridge,
 		return;
 
 	if (ctx->chip_data->chip_type == LT9211C) {
-		drm_mode_copy(&ctx->lt9211c_mode, mode);
-		ctx->lt9211c_bpp24 = lvds_format_24bpp;
-		ctx->lt9211c_jeida = lvds_format_jeida;
-		ctx->lt9211c_de_high = !!(bus_flags & DRM_BUS_FLAG_DE_HIGH);
-		ctx->lt9211c_crtc = crtc;
+		/* wait for vblank irq to correctly configure bridge and autodetect stream */
+		ret = drm_crtc_wait_one_vblank(crtc);
+		if (ret) {
+			dev_err(ctx->dev, "LT9211C: wait for vblank failed: %d\n", ret);
+			return;
+		}
 
-		/*
-		 * Needs a live DSI stream to auto-detect RX resolution/format;
-		 * defer bridge configuration until vblank inside the work item.
-		 */
-		queue_work(ctx->wq, &ctx->lt9211_work);
+		ret = lt9211c_configure_rx(ctx);
+		if (ret) {
+			dev_err(ctx->dev, "LT9211C: configure_rx failed: %d\n", ret);
+			return;
+		}
+
+		ret = lt9211c_autodetect_rx(ctx, mode);
+		if (ret) {
+			dev_err(ctx->dev, "LT9211C: autodetect_rx failed: %d\n", ret);
+			return;
+		}
+
+		ret = lt9211c_configure_timing(ctx, mode);
+		if (ret) {
+			dev_err(ctx->dev, "LT9211C: configure_timing failed: %d\n", ret);
+			return;
+		}
+
+		ret = lt9211c_configure_plls(ctx, mode);
+		if (ret) {
+			dev_err(ctx->dev, "LT9211C: configure_plls failed: %d\n", ret);
+			return;
+		}
+
+		ret = lt9211c_configure_tx(ctx, lvds_format_jeida, lvds_format_24bpp,
+					   bus_flags & DRM_BUS_FLAG_DE_HIGH, mode);
+		if (ret) {
+			dev_err(ctx->dev, "LT9211C: configure_tx failed: %d\n", ret);
+			return;
+		}
+
+		dev_dbg(ctx->dev, "LT9211C enabled.\n");
 		return;
 	}
 
@@ -1320,9 +1294,6 @@ static void lt9211_atomic_disable(struct drm_bridge *bridge,
 	struct lt9211 *ctx = bridge_to_lt9211(bridge);
 	int ret;
 
-	if (ctx->chip_data->chip_type == LT9211C)
-		cancel_work_sync(&ctx->lt9211_work);
-
 	/*
 	 * Put the chip in reset, pull nRST line low,
 	 * and assure lengthy 10ms reset low timing.
@@ -1483,11 +1454,6 @@ static int lt9211_host_attach(struct lt9211 *ctx)
 	return 0;
 }
 
-static void lt9211_destroy_wq(void *data)
-{
-	destroy_workqueue(data);
-}
-
 static int lt9211_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -1532,17 +1498,6 @@ static int lt9211_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	if (ctx->chip_data->chip_type == LT9211C) {
-		ctx->wq = create_workqueue("lt9211_work");
-		if (!ctx->wq)
-			return -ENOMEM;
-		/* Register after DSI attach so devres flushes work before freeing ctx->dsi. */
-		ret = devm_add_action_or_reset(dev, lt9211_destroy_wq, ctx->wq);
-		if (ret)
-			return ret;
-		INIT_WORK(&ctx->lt9211_work, lt9211_work_func);
-	}
-
 	return 0;
 }
 
-- 
2.47.3

