Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18BAACC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 569E2112314;
	Thu, 15 Oct 2026 11:17:03 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AAFC112308
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 11:16:39 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 536C0166C;
 Thu, 15 Oct 2026 13:14:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1792062875;
 bh=qMp5HZDET6t4NRwZDDm2bhglOWdrH264jAdXSIODebA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=anVg+2s5u2rxs6DwGlz98i4idwwRcFZLWVywzNG6SmN6ZNqqH3NmpPj2Fgx/3K101
 UMVZGRACauQV984Lw6i0ibXioeemNZco5gEnkxqk9cwUNvkxzX4U4AQe6U8QMLrrj3
 mL056MVp6WxgVRzB4JCg+6YOkVFzvHsk+Yud+8Wc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 15 Oct 2026 14:16:02 +0300
Subject: [PATCH v5 11/13] drm/bridge: tc358762: Drop drm_bridge_funcs.mode_set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-tc358762-fixes-v5-11-7cd721a6451b@ideasonboard.com>
References: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
In-Reply-To: <20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3099;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=qMp5HZDET6t4NRwZDDm2bhglOWdrH264jAdXSIODebA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq0LYI909mUUQMoOcgdlVQjPqhB6F5uM1RcF04B
 Ds4XTq0n7mJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCatC2CAAKCRD6PaqMvJYe
 9ZDDEACSbXfyvrHW9HluMYvBM3jFf1F6Xoo68Bk06vq+ertctRsMoFYFP0Ccb7MR8DSbfqCuVxJ
 md82buOeOxndZQb8FIfrI1syKb6b1thBVe+vB+bB1YBba8+0KKzkDEhDkYbbcN+cwW6QYFuen3N
 /mbEJD1U+IkkYOQLqXvXmStjeFumyZDkzfeO71fH/x2vvZs6viSrBBTBH4I/2deJ/tBoUSOGk+F
 JnWL0bIVfF6EJd8TXdDxnliEyRFbU2kF8F0vPKnbDT+GEIX+ib6Tg3N9UYkHncHTbMdfTDYZC17
 0kbkOwRC0oMjKtkYZEwbs0XIHVC7GHzLnZCbkZkq1TY5OmdGsmvbMTbrMeyKWsvUBH7rj4g/UPS
 zQmV/+g6jxtj7BHQkY/JJUf7N/WkcLA+yIKkI1juldIZCKWov2o/mlAAJZpqPjza+Dycf470txo
 NvqsU199L1WE40mhbhtIp5O7cqC2RBY26eZL8GAMAftLWZniP9ch2NIQ9WJEmFOwqtwyx9FhT9C
 M5XrLFrNkbFxBaSKEf1na/JUcGUH3NxgPbPg2u4i9b8s0SVx2sdRIDNZupXzNrM3VprNU5xwQvj
 F9ArkIIYAsfOjVeGpCsczm+LFWv2TKZqtbspozEUfVMZq6UDbJWpNgBRtenmiokxBs8RIhEYXeg
 E2w4YT0Eu8eFyXg==
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
index a91cf159ba27..33312300e606 100644
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
 			    struct drm_atomic_commit *state)
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
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.attach = tc358762_attach,
-	.mode_set = tc358762_bridge_mode_set,
 };
 
 static int tc358762_parse_dt(struct tc358762 *ctx)

-- 
2.43.0

