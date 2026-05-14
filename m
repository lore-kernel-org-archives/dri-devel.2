Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5EE8CD4F3E
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 12:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E3B10F17C;
	Thu, 14 May 2026 12:25:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="lFtrB+Uo";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC11310E5FE
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:25:29 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5DBBA151C;
 Thu, 14 May 2026 14:25:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778761519;
 bh=gBQFB78X4KGzpd0DZyLsXnhD9qIE3f4obIum+k+GS5o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=lFtrB+UoqFuxTIzOBc7w8uMp9D6M0oCDm46BtRLfOT48Ku2grZvAOLFohMiJ91LK8
 CTQljzgnHec22wmwqehTBIRO5dL7U3v+5a3DA+DbXEcL0PJvWG1FjN5pnZYauJxnIY
 eswlw8GMkf4lamtQWDBF6Rfql9g8qHCOO3WUGOGY=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Thu, 14 May 2026 15:24:56 +0300
Subject: [PATCH 4/5] drm/rcar-du: dsi: Support DSC in the pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-rcar-du-dsc-v1-4-d65f7a9e9841@ideasonboard.com>
References: <20260514-rcar-du-dsc-v1-0-d65f7a9e9841@ideasonboard.com>
In-Reply-To: <20260514-rcar-du-dsc-v1-0-d65f7a9e9841@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=gBQFB78X4KGzpd0DZyLsXnhD9qIE3f4obIum+k+GS5o=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBb8w3bJxm5PYo0lOz2kVrpXAE4j/STeTDvAvI
 7fKVbe38WyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagW/MAAKCRD6PaqMvJYe
 9RU8EACauJKA2vSlMPd2p1f1rG/9tWTWFhNBbkgG0MtA/vkOcVLEjttOv2tVndqeccLdrep5shy
 tA40qu8QMyghGINJYDgUN2KGLNDkTJi3vpoFR5zxFPY1TVEx1llIXoGQJjmQvSHe1afHqbH9QgL
 qRNvkomdmM81TzQeiisz4EM5VopbOO+NyS3IPvh9miYqpvqa/rzlwkACC3GKvuHALz2OgH839V5
 AXV+VyY598Dzm9CDI68sdwOHBeffOJCHVybtElUFSqs3ekviFQMofAYHnkij6X15Je0j6hJ0liO
 wvKk1Quhue5gzQtqZQAvR5MK4np8ls+8egF0lHmBsGYOc3AO/2eB8rIfOV9xy3Aqzc9C2RMwMFO
 OD+kSzUE5qHrLnN9n2VHmTZicMzW/w0KjVFJA7/LnQR2CRZU4cwDFs08wBSObYOmbVQBV5VozoW
 dxxTeN9hFxuW8m9wg7OG04CGpa0z+Nwj1bIBygW3x23T7OvlfZVUD1x9VLGue6L/EIAdaciCA7M
 DyskWtYMnGKPdXphpp9/GrK9jQ/x4kVD/MVEXLxceqOXjQJFyw6ic6zxlB6Nh2tnvFzCBnGRRF2
 NkWleT3GqDr7FuPrFLYrng6I/BVeGRcB9r1pmZK/Bw1QE7U3jkKXOyUXEEHAx0XTmF7GCAca0GN
 aPW8jlWaj0GF0Qg==
X-Developer-Key: i=tomi.valkeinen+renesas@ideasonboard.com; a=openpgp;
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

Enabling DSI clocks on rcar-du needs some tricks as the DU dot clock is
provided by the DSI. Thus, we call rcar_mipi_dsi_pclk_enable() from the
crtc, when enabling the crtc.

With DSC (added in upcoming patch) in the pipeline, between the DU and
the DSI, the above call path is broken as the crtc tries to call
rcar_mipi_dsi_pclk_enable() on the DSC.

Adjust the rcar_mipi_dsi_pclk_enable() so that it detects the DSC, and
in that case gets the next bridge from the DSC, which is the DSI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c | 36 +++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
index 4ef2e3c129ed..085e229bcb0b 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c
@@ -88,6 +88,8 @@ struct dsi_setup_info {
 	const struct dsi_clk_config *clkset;
 };
 
+static const struct drm_bridge_funcs rcar_mipi_dsi_bridge_ops;
+
 static inline struct rcar_mipi_dsi *
 bridge_to_rcar_mipi_dsi(struct drm_bridge *bridge)
 {
@@ -844,15 +846,39 @@ static void rcar_mipi_dsi_atomic_disable(struct drm_bridge *bridge,
 	rcar_mipi_dsi_stop_video(dsi);
 }
 
+/*
+ * We need to skip the DSC bridge when we have DSC in between the DU and
+ * the DSI. We detect the DSI bridge via bridge->funcs, and assume the
+ * next_bridge is the DSI bridge. If this is not the case, the DT data
+ * is wrong (so it shouldn't really happen).
+ */
+static struct drm_bridge *
+rcar_mipi_dsi_resolve_bridge(struct drm_bridge *bridge)
+{
+	if (bridge->funcs != &rcar_mipi_dsi_bridge_ops)
+		bridge = bridge->next_bridge;
+
+	if (!bridge || bridge->funcs != &rcar_mipi_dsi_bridge_ops)
+		return NULL;
+
+	return bridge;
+}
+
 void rcar_mipi_dsi_pclk_enable(struct drm_bridge *bridge,
 			       struct drm_atomic_state *state)
 {
-	struct rcar_mipi_dsi *dsi = bridge_to_rcar_mipi_dsi(bridge);
 	const struct drm_display_mode *mode;
 	struct drm_connector *connector;
+	struct rcar_mipi_dsi *dsi;
 	struct drm_crtc *crtc;
 	int ret;
 
+	bridge = rcar_mipi_dsi_resolve_bridge(bridge);
+	if (WARN_ON(!bridge))
+		return;
+
+	dsi = bridge_to_rcar_mipi_dsi(bridge);
+
 	connector = drm_atomic_get_new_connector_for_encoder(state,
 							     bridge->encoder);
 	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
@@ -885,7 +911,13 @@ EXPORT_SYMBOL_GPL(rcar_mipi_dsi_pclk_enable);
 
 void rcar_mipi_dsi_pclk_disable(struct drm_bridge *bridge)
 {
-	struct rcar_mipi_dsi *dsi = bridge_to_rcar_mipi_dsi(bridge);
+	struct rcar_mipi_dsi *dsi;
+
+	bridge = rcar_mipi_dsi_resolve_bridge(bridge);
+	if (WARN_ON(!bridge))
+		return;
+
+	dsi = bridge_to_rcar_mipi_dsi(bridge);
 
 	rcar_mipi_dsi_shutdown(dsi);
 	rcar_mipi_dsi_clk_disable(dsi);

-- 
2.43.0

