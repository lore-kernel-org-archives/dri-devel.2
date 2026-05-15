Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42B2CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C70F10F4A9;
	Fri, 15 May 2026 09:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="AAyx7CGT";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6128610F4A3
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:10:04 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2CD041123;
 Fri, 15 May 2026 11:09:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778836193;
 bh=gBQFB78X4KGzpd0DZyLsXnhD9qIE3f4obIum+k+GS5o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AAyx7CGTxMpwqNDXZpxdnJMoxnJHZdKCvwoVX3FV+UAkWyLYdxNP421KsHe3ZrXyt
 ZKWW7VxzQO9UwoLQbqLPTjdIrN+60iXpSTh1UDgrI0E0KL0pN0NCiOpDRk68mI6Fge
 V7Mh5NngRHBd6PyaIaktt7hiwOeaGjWJpWSbOh2s=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Fri, 15 May 2026 12:09:29 +0300
Subject: [PATCH v3 4/7] drm/rcar-du: dsi: Support DSC in the pipeline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-rcar-du-dsc-v3-4-164157820498@ideasonboard.com>
References: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
In-Reply-To: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=gBQFB78X4KGzpd0DZyLsXnhD9qIE3f4obIum+k+GS5o=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBuLhJ0hC8Yq7b2bP6uZ61PSSoK4QV30lgeyVu
 BikaFfnkS2JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagbi4QAKCRD6PaqMvJYe
 9Xr6D/4mgsmuvgX6IPeKR7i8IESTN8ojqf8HWHW57ABeqPGwELcOfYaGBCYwlsMGkNSepSbaJaR
 UQttkxQywK1v/IVm1N5vW1h35Cb34TEHhP/eA4+fHglR7XPe4yg+IZgci9yoz8UVzebO2sqmvl9
 7KKQDh+ggRSujarVj1gFpbTrQtSNyo23F6kdsdW/ph0dfMUuU6FCjYmLnhIolVmMDA73F7/7iPv
 Dg9+h/vCF6kfSBlsmmZKzq3fx/h77EO+7Tp6lWfc7gyduLtnYooDANLwdHFbBE6lmUS5Oo/BJuf
 a3jPIwAweqWQk2bAkh2cjKYt+91T3YyB8nwyGCevzs3adxxPBSyLdpZulkjvtA64lt6cwMTAJ4W
 y9LiVvzR0ArB+Y5BFNqKML1NH+IUQXZufaTiSyeYPmN6j7YubCwNAKnnQys4XkJf0ei65RqRLU1
 BhHByRJn8KTUjpHdhGx6MxYpY5aYSR2GN3QwVLJpToSwSCCQbfWNjgwzwqOtEquLmf7ii0MeM3T
 4Z9LoWynxK/jDCDBaPArVQhO/vUGbFy2zZOjO1poYzHZWJMOX8XHXIutakJIzU1Fz+dF3Ohflbx
 cAEW/2GPBS1MxU4BTdVhXtjiNIbXbJ95i4Hot9Pb/h07lvU+7eZjAwNXy/KQUNtMYTV4HJzXU0E
 7PuLktvFpEB9gfQ==
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

