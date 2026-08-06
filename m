Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEC2C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 13:17:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3A4010E8B9;
	Thu,  6 Aug 2026 13:17:29 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6EF610E8B9
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 13:17:28 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 642C2202055;
 Thu, 06 Aug 2026 15:17:23 +0200 (CEST)
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1wrxyN-000664-11;
 Thu, 06 Aug 2026 15:17:23 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 Yi Zhang <zhanyi@qti.qualcomm.com>,
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
 linux-kernel@vger.kernel.org, Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH 1/7] drm/bridge: lt9211: drop delayed work
Date: Thu,  6 Aug 2026 15:17:09 +0200
Message-ID: <20260806131715.508557-2-p.zabel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260806131715.508557-1-p.zabel@pengutronix.de>
References: <20260719-add-lt9211c-bridge-v6-2-e56d22152586@oss.qualcomm.com>
 <20260806131715.508557-1-p.zabel@pengutronix.de>
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

Replace the delayed work with a delay and synchronous initialization
in atomic_enable. This should fix all 5 issues sashiko flagged as
high priority [1].

The next bridge or panel in the chain may depend on the LVDS signal
being active after atomic_enable, so arbitrarily deferring bridge
initialization is not an option.

[1] https://sashiko.dev/#/patchset/20260719-add-lt9211c-bridge-v6-0-e56d22152586%40oss.qualcomm.com

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/bridge/lontium-lt9211.c | 93 ++++++++-----------------
 1 file changed, 30 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index ffd0f9f08e2d..1b5cb601adde 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -62,14 +62,7 @@ struct lt9211 {
 	struct regulator		*vccio;
 	bool				lvds_dual_link;
 	bool				lvds_dual_link_even_odd_swap;
-	/* LT9211C specific fields */
 	enum lt9211_chip_type		chip_type;
-	struct workqueue_struct		*wq;
-	struct delayed_work		lt9211_dw;
-	struct drm_display_mode		mode;
-	bool				bpp24;
-	bool				jeida;
-	bool				de;
 };
 
 static const struct regmap_range lt9211_rw_ranges[] = {
@@ -154,8 +147,6 @@ static const struct regmap_config lt9211c_regmap_config = {
 	.max_register = 0xda00,
 };
 
-static void lt9211_delayed_work_func(struct work_struct *work);
-
 static struct lt9211 *bridge_to_lt9211(struct drm_bridge *bridge)
 {
 	return container_of(bridge, struct lt9211, bridge);
@@ -896,8 +887,8 @@ static int lt9211c_configure_plls(struct lt9211 *ctx,
 	return ret;
 }
 
-static int lt9211c_configure_tx(struct lt9211 *ctx,
-				const struct drm_display_mode *mode)
+static int lt9211c_configure_tx(struct lt9211 *ctx, bool jeida, bool bpp24,
+				bool de, const struct drm_display_mode *mode)
 {
 	const struct reg_sequence lt9211c_tx_phy_off_seq[] = {
 		{ 0x8236, 0x00 },
@@ -949,10 +940,10 @@ static int lt9211c_configure_tx(struct lt9211 *ctx,
 		{ 0x8556, 0x20 },
 
 		{ 0x8568, 0x00 },
-		{ 0x856e, 0x10 | (ctx->de ? BIT(6) : 0) },
-		{ 0x856f, 0x81 | (ctx->jeida ? BIT(6) : 0) |
+		{ 0x856e, 0x10 | (de ? BIT(6) : 0) },
+		{ 0x856f, 0x81 | (jeida ? BIT(6) : 0) |
 				  (ctx->lvds_dual_link ? BIT(4) : 0) |
-				  (ctx->bpp24 ? BIT(2) : 0) },
+				  (bpp24 ? BIT(2) : 0) },
 	};
 
 	const struct reg_sequence lt9211c_tx_ssc_seq[] = {
@@ -995,7 +986,7 @@ static int lt9211c_configure_tx(struct lt9211 *ctx,
 	dev_info(ctx->dev,
 		 "dual_link=%d,even_odd_swap=%d,bpp24=%d,jeida=%d,de=%d\n",
 		 ctx->lvds_dual_link, ctx->lvds_dual_link_even_odd_swap,
-		 ctx->bpp24, ctx->jeida, ctx->de);
+		 bpp24, jeida, de);
 
 	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_phy_off_seq,
 				     ARRAY_SIZE(lt9211c_tx_phy_off_seq));
@@ -1138,39 +1129,6 @@ static int lt9211c_configure_tx(struct lt9211 *ctx,
 	return 0;
 }
 
-static void lt9211_delayed_work_func(struct work_struct *work)
-{
-	struct delayed_work *dw = to_delayed_work(work);
-	struct lt9211 *ctx = container_of(dw, struct lt9211, lt9211_dw);
-	const struct drm_display_mode *mode = &ctx->mode;
-	int ret;
-
-	if (ctx->chip_type != LT9211C) {
-		dev_err(ctx->dev, "LT9211: Delayed work called for non-LT9211C chip\n");
-		return;
-	}
-
-	ret = lt9211c_configure_rx(ctx);
-	if (ret)
-		return;
-
-	ret = lt9211c_autodetect_rx(ctx, mode);
-	if (ret)
-		return;
-
-	ret = lt9211c_configure_timing(ctx, mode);
-	if (ret)
-		return;
-
-	ret = lt9211c_configure_plls(ctx, mode);
-	if (ret)
-		return;
-
-	ret = lt9211c_configure_tx(ctx, mode);
-	if (ret)
-		return;
-}
-
 static void lt9211_atomic_enable(struct drm_bridge *bridge,
 				 struct drm_atomic_commit *state)
 {
@@ -1240,11 +1198,30 @@ static void lt9211_atomic_enable(struct drm_bridge *bridge,
 	if (ret)
 		return;
 
-	if (ctx->chip_type == LT9211C && ctx->wq) {
-		drm_mode_copy(&ctx->mode, mode);
-		/* LT9211C must enable after mipi clock enable */
-		queue_delayed_work(ctx->wq, &ctx->lt9211_dw,
-				   msecs_to_jiffies(100));
+	if (ctx->chip_type == LT9211C) {
+		msleep(100);
+
+		ret = lt9211c_configure_rx(ctx);
+		if (ret)
+			return;
+
+		ret = lt9211c_autodetect_rx(ctx, mode);
+		if (ret)
+			return;
+
+		ret = lt9211c_configure_timing(ctx, mode);
+		if (ret)
+			return;
+
+		ret = lt9211c_configure_plls(ctx, mode);
+		if (ret)
+			return;
+
+		ret = lt9211c_configure_tx(ctx, lvds_format_jeida, lvds_format_24bpp,
+					   bus_flags & DRM_BUS_FLAG_DE_HIGH, mode);
+		if (ret)
+			return;
+
 		dev_dbg(ctx->dev, "LT9211C enabled.\n");
 		return;
 	}
@@ -1501,13 +1478,6 @@ static int lt9211_probe(struct i2c_client *client)
 	if (IS_ERR(ctx->regmap))
 		return PTR_ERR(ctx->regmap);
 
-	if (ctx->chip_type == LT9211C) {
-		ctx->wq = create_workqueue("lt9211_work");
-		if (!ctx->wq)
-			return -ENOMEM;
-		INIT_DELAYED_WORK(&ctx->lt9211_dw, lt9211_delayed_work_func);
-	}
-
 	dev_set_drvdata(dev, ctx);
 	i2c_set_clientdata(client, ctx);
 
@@ -1525,9 +1495,6 @@ static void lt9211_remove(struct i2c_client *client)
 {
 	struct lt9211 *ctx = i2c_get_clientdata(client);
 
-	if (ctx->wq)
-		destroy_workqueue(ctx->wq);
-
 	drm_bridge_remove(&ctx->bridge);
 }
 
-- 
2.47.3

