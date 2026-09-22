Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5416EC982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42BF710EB79;
	Tue, 22 Sep 2026 06:17:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="D3mS4tkK";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D11710E742
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
 Reply-To:Content-ID:Content-Description;
 bh=AXgjdnDVE3P4oyz6CPuYyFf3otjEytHlCZ6PP8kE4jo=; t=1790057854; x=1791267454; 
 b=D3mS4tkK+O4GF+xNKV+v36HagtyRsimp/KcTBD9PpsthgL24By8t25WngR0PuPM1s5m7rbYQpZl
 JwZpEFjb7abF9r5WWLyupQTplsZpBlXeqnq2nUFk5NgoKZmydFKyEB56qf/cOCb3hFVkm49O5X1ee
 7TDVu4IcqsfUdN5/57Cv+nJfiZkPaeINullex1txQiIYZkkziOuKX5XItl3HyEUaplABku5+kR2I7
 9vINePuIYEzK7aFA3N3zhH2KFaioXwCYKEWLpxlM2kH4Tmpscm2tfWQYGnIZeCF2w77/YYlAP99oR
 EXANOUa9RMl+VjKAB4wdSGPuhW8CvkXGeA6Q==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:17:01 +0200
Subject: [PATCH RFC 4/9] drm/bridge: tc358762: Move initialisation to
 pre_enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-4-45ff36b364cf@kemnade.info>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2081; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=4czSwLJZTsPrde7Ae78uOhAxPABOjbRqzcFREuBtK58=; 
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBPaD98NTmXxXjQ96vrfZ/ZXTHsWb9Q2v79m7bmfv
 Cu3fNbg7yhlYRDjYpAVU2T5Za3g9knlWW7w1Ah7mDmsTCBDGLg4BWAiD6wZ/pcr75WfdHEuU3C5
 +AfmW/8O5MX++2/U+nxbTqZW+4rZJw8w/LM7vTjb7OGbh18NtJROcnu8WeKSz9p/RJO7wVf68sl
 97/kB
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

To allow panels to use SPI already in the prepare function, have things
already setup here.
Maybe setting LCDCTRL in enable might be an idea?

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/bridge/tc358762.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index e73be376e33c..ec72e6e92b46 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -167,6 +167,12 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 				struct drm_atomic_commit *state)
 {
 	struct tc358762 *ctx = bridge_to_tc358762(bridge);
+	struct drm_connector_state *conn_state;
+	struct drm_bridge_state *bridge_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
+	struct drm_display_mode *mode;
+	u32 lcdctrl;
 	int ret;
 
 	ret = regulator_enable(ctx->regulator);
@@ -178,21 +184,6 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 		usleep_range(5000, 10000);
 	}
 
-	ctx->pre_enabled = true;
-}
-
-static void tc358762_enable(struct drm_bridge *bridge,
-			    struct drm_atomic_commit *state)
-{
-	struct tc358762 *ctx = bridge_to_tc358762(bridge);
-	struct drm_connector_state *conn_state;
-	struct drm_bridge_state *bridge_state;
-	struct drm_crtc_state *crtc_state;
-	struct drm_connector *connector;
-	struct drm_display_mode *mode;
-	u32 lcdctrl;
-	int ret;
-
 	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
 
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
@@ -269,6 +260,13 @@ static void tc358762_enable(struct drm_bridge *bridge,
 	ret = tc358762_clear_error(ctx);
 	if (ret < 0)
 		dev_err(ctx->dev, "error initializing bridge (%d)\n", ret);
+
+	ctx->pre_enabled = true;
+}
+
+static void tc358762_enable(struct drm_bridge *bridge,
+			    struct drm_atomic_commit *state)
+{
 }
 
 static int tc358762_attach(struct drm_bridge *bridge,

-- 
2.47.3

