Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E23CD4F39
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C668E10EE6A;
	Wed, 13 May 2026 13:11:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bxeRoB2F";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEB1810EE66
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:10:52 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7B04027F9;
 Wed, 13 May 2026 15:10:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778677843;
 bh=sME8jnGcDPPyGaTdmBI8RVrz4b4ysmbXrSZfGsjjcWk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bxeRoB2FoxutOa5ajBqC1AHDKM/e2Nl6cPRfJh9/nnXR+Evt3jkCsNdzk1KSAdcJT
 71aTu3nm69TBrCYzOQzxEz+EWnTQHQUCK2zpOc0sih97MNfO2EtE/l/B6c/PQ3iZfs
 AO7ZuOwb+DaL5HKnQYmnYezELiMxrTY03web0qYA=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:10:20 +0300
Subject: [PATCH v3 11/13] drm/bridge: tc358762: Drop drm_bridge_funcs.mode_set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-tc358762-fixes-v3-11-6698b55008b9@ideasonboard.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
In-Reply-To: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3084;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=sME8jnGcDPPyGaTdmBI8RVrz4b4ysmbXrSZfGsjjcWk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHhOkIq+EjRfi9KJn6R2zlB02cLd9HGvDXhep
 OQFtTJo2MGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR4TgAKCRD6PaqMvJYe
 9b9wD/44lzz4lowzPWEJXH2q3M+GHcFgnZUjCrHSuCtsKNCXC4Om90wEtakW+RFSjTXAuBWwnY7
 E/5LA6xOiPPSdH75BzhO1QLZMEy9yDqTjYEMnQgCKP9bw/t4mpCnsQALanyrbXn+BJXZDFY8/Ku
 mpQ04CinYaLkd12jajjzyq5izpydrMjnRJ9ESXce6Sxive229phWxAeqM3S+uEM6LoPrQO7z6HK
 43jkoFxt7m/g6d2ECWxQybaedLRWK+3Eibe75qqR4BrEZC86F5u/mCj1yxe9Ur6547fXGwI5Ize
 l6MfW2fyqOPa/jy9+iALVPJwwYIN7Qknu0rT06+oUXeFbt8zVuwrWwJ/UB8ufozB2X+JG7p7Q0O
 Q0vxCghz5ObRx1/6YZZsgM6FEsWV1eR6a7Fr8cIJHeRBV4hEjm+aqDuvJNMdCC7sjxnR4WPWfqj
 YALbHxwJHpkBju/OjHj6zq9haiLj8h9UnKO6663X/NGjHb2+5UCDOauMMGuR5h8Y1qDWi3PDcvM
 dBMHNSWCq3II6qw4zTZiezpIX+rNjSpR7QyRgb3/ngllc8R1k5LuJBSITGzErZjsilDwVSTV7IS
 5CH8LD4HmlfHiwXkDBGtsLx+Bp35ocRxDcNSX0GKR2+8Yf6XVaCuw3c8ExCBnWAFCnV251XlU/x
 IzzSdcevEtxRdJw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

drm_bridge_funcs.mode_set is deprecated. Drop it and get the
drm_display_mode from the atomic state.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 89c02b2e6832..47ae706de4cb 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -99,7 +99,6 @@ struct tc358762 {
 	struct regulator *regulator;
 	struct drm_bridge *panel_bridge;
 	struct gpio_desc *reset_gpio;
-	struct drm_display_mode mode;
 	bool pre_enabled;
 	int error;
 	bool use_vtg;
@@ -187,9 +186,18 @@ static void tc358762_enable(struct drm_bridge *bridge,
 			    struct drm_atomic_state *state)
 {
 	struct tc358762 *ctx = bridge_to_tc358762(bridge);
+	struct drm_connector_state *conn_state;
+	struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
+	struct drm_display_mode *mode;
 	u32 lcdctrl;
 	int ret;
 
+	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	mode = &crtc_state->mode;
+
 	/*
 	 * DPIENABLE has reset default of 1. Make sure we don't output on
 	 * DPI until we have finished the coniguration.
@@ -214,7 +222,7 @@ static void tc358762_enable(struct drm_bridge *bridge,
 	if (ctx->use_vtg) {
 		struct videomode vm = { 0 };
 
-		drm_display_mode_to_videomode(&ctx->mode, &vm);
+		drm_display_mode_to_videomode(mode, &vm);
 
 		tc358762_write(ctx, LCDC_HSR_HBPR,
 			       vm.hsync_len | (vm.hback_porch << 16));
@@ -238,10 +246,10 @@ static void tc358762_enable(struct drm_bridge *bridge,
 
 	lcdctrl |= LCDCTRL_DCLK_POL;
 
-	if (ctx->mode.flags & DRM_MODE_FLAG_PHSYNC)
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
 		lcdctrl |= LCDCTRL_HSYNC_POL;
 
-	if (ctx->mode.flags & DRM_MODE_FLAG_PVSYNC)
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		lcdctrl |= LCDCTRL_VSYNC_POL;
 
 	tc358762_write(ctx, LCDCTRL, lcdctrl);
@@ -266,15 +274,6 @@ static int tc358762_attach(struct drm_bridge *bridge,
 				 bridge, flags);
 }
 
-static void tc358762_bridge_mode_set(struct drm_bridge *bridge,
-				     const struct drm_display_mode *mode,
-				     const struct drm_display_mode *adj)
-{
-	struct tc358762 *ctx = bridge_to_tc358762(bridge);
-
-	drm_mode_copy(&ctx->mode, mode);
-}
-
 static const struct drm_bridge_funcs tc358762_bridge_funcs = {
 	.atomic_post_disable = tc358762_post_disable,
 	.atomic_pre_enable = tc358762_pre_enable,
@@ -283,7 +282,6 @@ static const struct drm_bridge_funcs tc358762_bridge_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.attach = tc358762_attach,
-	.mode_set = tc358762_bridge_mode_set,
 };
 
 static int tc358762_parse_dt(struct tc358762 *ctx)

-- 
2.43.0

