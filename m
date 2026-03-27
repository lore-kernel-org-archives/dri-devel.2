Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B1410ED656
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4803010ED3B;
	Fri, 27 Mar 2026 10:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CaG4DDru";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1795810ED20
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:22:35 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0EBEC7CA;
 Fri, 27 Mar 2026 11:21:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774606874;
 bh=vJa1wHX0BnyPQsL6cv2chd2cFvvWt5+Mje7IlZp67Qk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=CaG4DDruDXmo20yo1VBfBXU7zpTpMKEik6AEt75SeolORQpL+3Zx7HV9aEesWzOVh
 Qzwpfd6XHfICltX+CLaAmf5OCB+xSc3Fo9rzVF+ozFzrmxXYSoH6lHCI9t8Fopo/Wr
 tZYTF6Frqe8fh3kd/AZlFei6OCHF8jEOYMGYAOL4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:21:59 +0200
Subject: [PATCH v2 11/12] drm/bridge: tc358762: Drop drm_bridge_funcs.mode_set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-tc358762-fixes-v2-11-3589d3c45f4a@ideasonboard.com>
References: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
In-Reply-To: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
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
 bh=vJa1wHX0BnyPQsL6cv2chd2cFvvWt5+Mje7IlZp67Qk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxlpdALRp4f/55SnqSwKMz6Q60bp0KmlGLO3dL
 s5zcAl8SGOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZaXQAKCRD6PaqMvJYe
 9U+6D/4g0z7ApAIWaHQcBBJ59qkyCMTzDtExdYKYMf8rzNeo5douYdL/QRkMBMv005Vjkm2fOVD
 /LMGAet06tuTjlV4+XhJjFfGm12Y4arBboyD2WHywYWjas2RVasstOOyL94NCmkvsckT0aXg1/P
 Y4QJW+m9d1OLQvf3EsreEro73mFnMTLm4GRranW1J/7biTN+SJkriJNnjZpZyoBotkbgAyTs+Dh
 RxtbmfgfHO/tDeaP2F/DMKni6ouYJg1XUbE03PumvZqWhISGOBFC40SEJTiaqcQ0YZSkzu/8mEZ
 il0oWH2h66p1uLyRQUcejPpmi5lzXl94I3DlpSQePkuIwmly+2f1M/QiR75k6zhirTn4avAlqwM
 0svwJe7Q+XiC8t31gP7kQRnfvLMqzQh+SKUXbfYrVoLCK1HLlkhTKNDTooXpaTm7un45JJ97eya
 IYIphant18pszZfH6L7NXfmUHbvEWGTfKKFAwQ4/ThrpqPDIJ7JfoWd/6ePMJ3M+Fy+vRaQrZkX
 z1ueuI7RWlVSVbTD+6QALj3/FzqfSQWTvHhXI+iR3a8JUGxzBqP8sR2mpztNu+sjI7C7M6pVvOt
 AVSGSGgvVwdYe6Sf2oTY7lW4mFY5/+l4Gx3XA5nuLmByi8UFSFgyIm42WIx/8sAQwn0XCVWeugr
 IMrT0v499/Prfyg==
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
index 1e16d5b2d5fe..eba910ce8bd7 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -98,7 +98,6 @@ struct tc358762 {
 	struct regulator *regulator;
 	struct drm_bridge *panel_bridge;
 	struct gpio_desc *reset_gpio;
-	struct drm_display_mode mode;
 	bool pre_enabled;
 	int error;
 	bool use_vtg;
@@ -186,9 +185,18 @@ static void tc358762_enable(struct drm_bridge *bridge,
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
@@ -213,7 +221,7 @@ static void tc358762_enable(struct drm_bridge *bridge,
 	if (ctx->use_vtg) {
 		struct videomode vm = { 0 };
 
-		drm_display_mode_to_videomode(&ctx->mode, &vm);
+		drm_display_mode_to_videomode(mode, &vm);
 
 		tc358762_write(ctx, LCDC_HSR_HBPR,
 			       vm.hsync_len | (vm.hback_porch << 16));
@@ -237,10 +245,10 @@ static void tc358762_enable(struct drm_bridge *bridge,
 
 	lcdctrl |= LCDCTRL_DCLK_POL;
 
-	if (ctx->mode.flags & DRM_MODE_FLAG_PHSYNC)
+	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
 		lcdctrl |= LCDCTRL_HSYNC_POL;
 
-	if (ctx->mode.flags & DRM_MODE_FLAG_PVSYNC)
+	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		lcdctrl |= LCDCTRL_VSYNC_POL;
 
 	tc358762_write(ctx, LCDCTRL, lcdctrl);
@@ -265,15 +273,6 @@ static int tc358762_attach(struct drm_bridge *bridge,
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
@@ -282,7 +281,6 @@ static const struct drm_bridge_funcs tc358762_bridge_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.attach = tc358762_attach,
-	.mode_set = tc358762_bridge_mode_set,
 };
 
 static int tc358762_parse_dt(struct tc358762 *ctx)

-- 
2.43.0

