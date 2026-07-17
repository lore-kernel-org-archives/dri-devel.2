Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EB3C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:03:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED6810F57D;
	Fri, 17 Jul 2026 14:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="BnVKUaMp";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9BE10F57D
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784297016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YK0UElVQAi+rBDr+qdXgzYaaDbZtSZ/mtY5vOEzXsbY=;
 b=BnVKUaMpZzFDFDaLxVHMLtXf1hUNM3yBVKLP/2a9qwZp1Z5rY/X6Ks5+3S1y39BaOVFjb0
 6afKJzfRBuiMkhhIQOerlbY8vOQIMJ5ipKkNZ/DjhUsTEoU1k4P/0b0MsDRbQgXeDwVyyd
 aihx1OsXerhO4Ionha5S+O2p86xWSfk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-wGKLJ1nIN8KwvNUIWC06ug-1; Fri,
 17 Jul 2026 10:03:33 -0400
X-MC-Unique: wGKLJ1nIN8KwvNUIWC06ug-1
X-Mimecast-MFC-AGG-ID: wGKLJ1nIN8KwvNUIWC06ug_1784297004
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8DCB18009EA; Fri, 17 Jul 2026 14:03:23 +0000 (UTC)
Received: from [192.168.1.153] (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCEEC18005B3; Fri, 17 Jul 2026 14:03:09 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 17 Jul 2026 16:02:06 +0200
Subject: [PATCH v3 3/4] drm/panel: of_drm_find_panel() return a counted
 reference
MIME-Version: 1.0
Message-Id: <20260717-drm_refcount_wiring-v3-3-023900c32e01@redhat.com>
References: <20260717-drm_refcount_wiring-v3-0-023900c32e01@redhat.com>
In-Reply-To: <20260717-drm_refcount_wiring-v3-0-023900c32e01@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 Linus Walleij <linusw@kernel.org>, Marek Vasut <marex@denx.de>, 
 Stefan Agner <stefan@agner.ch>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Jyri Sarha <jyri.sarha@iki.fi>, Jingoo Han <jingoohan1@gmail.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Alison Wang <alison.wang@nxp.com>, 
 Paul Kocialkowski <paulk@sys-base.io>, 
 Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-sunxi@lists.linux.dev, 
 linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784296938; l=34080;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=3E/tqSH360XSqg1OCzjf9XdodE298Vql8IMXehxra3E=;
 b=K0m1nQAlYkRE4QiygvbHDnFyW0AzrdUAC2GZFYXkMMjANVthJtAYC/F344HfpQg5tUMlkqfpU
 7q/LsbQKzcVAghZalPT3FkEHEsUMuHyHzaeGAK7u2FaBGpz4XQf3kj/
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -LvcYm8B_V-F75Go2etT9Nf1Zsq58Sa2lcWx1lw6y9w_1784297004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Callers of of_drm_find_panel() and drm_of_find_panel_or_bridge()
receive a pointer with no reference held, creating a window where
the panel device can be unregistered and freed between the lookup
and first use (e.g., drm_panel_prepare()).

Fix the lookup function by acquiring a reference with drm_panel_get()
before returning, under panel_lock. Callers are now responsible for
calling drm_panel_put() when they no longer need the pointer.

For bridge drivers that immediately wrap the panel in a panel_bridge
(which acquires its own reference), release the lookup reference right
after the bridge creation call.

For analogix-anx6345, which stores the panel for direct use, release
the reference in the i2c remove path.

For platform drivers using analogix_dp_core with a component lifecycle
(exynos_dp, rockchip analogix_dp), release the lookup reference in the
platform remove() function. The panel_bridge created during bind() holds
a separate reference that devm cleanup releases after remove() returns.

Also fix devm_drm_of_get_bridge() and drmm_of_get_bridge() in
bridge/panel.c itself, update a second batch of drivers calling
of_drm_find_panel() or drm_of_find_panel_or_bridge() to release the
lookup reference after wrapping the panel in a bridge, and handle the
cases where a panel is found but cannot be used, dropping the reference
immediately in those paths.

Assisted-by: Claude:claude-opus-4-6
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 12 +++++++++++
 drivers/gpu/drm/bridge/fsl-ldb.c                   |  1 +
 drivers/gpu/drm/bridge/lontium-lt9211.c            |  1 +
 drivers/gpu/drm/bridge/lvds-codec.c                |  1 +
 drivers/gpu/drm/bridge/panel.c                     |  8 ++++++--
 drivers/gpu/drm/bridge/samsung-dsim.c              |  1 +
 drivers/gpu/drm/bridge/ssd2825.c                   |  1 +
 drivers/gpu/drm/bridge/tc358767.c                  |  2 ++
 drivers/gpu/drm/bridge/tc358768.c                  |  1 +
 drivers/gpu/drm/bridge/waveshare-dsi.c             |  1 +
 drivers/gpu/drm/drm_of.c                           |  3 ++-
 drivers/gpu/drm/drm_panel.c                        | 12 +++++++----
 drivers/gpu/drm/exynos/exynos_dp.c                 | 19 ++++++++++++++++-
 drivers/gpu/drm/exynos/exynos_drm_dpi.c            |  3 +++
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c          | 18 ++++++++++++++++
 drivers/gpu/drm/imx/dcss/dcss-kms.c                |  3 +++
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c          |  4 +++-
 drivers/gpu/drm/logicvc/logicvc_interface.c        | 12 +++++++++++
 drivers/gpu/drm/mcde/mcde_drv.c                    |  1 +
 drivers/gpu/drm/mcde/mcde_dsi.c                    |  1 +
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                  |  1 +
 drivers/gpu/drm/omapdrm/dss/output.c               |  1 +
 drivers/gpu/drm/pl111/pl111_drv.c                  |  1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c  |  1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c        |  1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c   |  1 +
 drivers/gpu/drm/rockchip/analogix_dp-rockchip.c    | 11 ++++++++++
 drivers/gpu/drm/rockchip/rockchip_lvds.c           |  4 ++++
 drivers/gpu/drm/rockchip/rockchip_rgb.c            |  3 +++
 drivers/gpu/drm/sti/sti_dvo.c                      |  3 +++
 drivers/gpu/drm/stm/ltdc.c                         |  1 +
 drivers/gpu/drm/stm/lvds.c                         | 12 ++++++++---
 drivers/gpu/drm/sun4i/sun4i_lvds.c                 | 13 ++++++++++++
 drivers/gpu/drm/sun4i/sun4i_rgb.c                  | 13 ++++++++++++
 drivers/gpu/drm/sun4i/sun4i_tcon.c                 |  2 ++
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c             |  6 +++++-
 drivers/gpu/drm/tegra/dsi.c                        |  5 +++++
 drivers/gpu/drm/tegra/output.c                     | 24 +++++++++++++++++++---
 drivers/gpu/drm/tidss/tidss_kms.c                  | 16 ++++++++++-----
 drivers/gpu/drm/tve200/tve200_drv.c                |  1 +
 40 files changed, 204 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index f3fe47b12edca..7330ccb2c74cf 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -658,6 +658,11 @@ static bool anx6345_get_chip_id(struct anx6345 *anx6345)
 	return false;
 }
 
+static void anx6345_panel_put_action(void *data)
+{
+	drm_panel_put(data);
+}
+
 static int anx6345_i2c_probe(struct i2c_client *client)
 {
 	struct anx6345 *anx6345;
@@ -686,6 +691,13 @@ static int anx6345_i2c_probe(struct i2c_client *client)
 	if (err)
 		DRM_DEBUG("No panel found\n");
 
+	if (anx6345->panel) {
+		err = devm_add_action_or_reset(dev, anx6345_panel_put_action,
+					       anx6345->panel);
+		if (err)
+			return err;
+	}
+
 	/* 1.2V digital core power regulator  */
 	anx6345->dvdd12 = devm_regulator_get(dev, "dvdd12");
 	if (IS_ERR(anx6345->dvdd12)) {
diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 9bfaa3f933709..27d7ba252927b 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -348,6 +348,7 @@ static int fsl_ldb_probe(struct platform_device *pdev)
 		fsl_ldb->use_termination_resistor = true;
 
 	fsl_ldb->panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+	drm_panel_put(panel);
 	if (IS_ERR(fsl_ldb->panel_bridge))
 		return PTR_ERR(fsl_ldb->panel_bridge);
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index 870175a848390..ae4aeba032a33 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -660,6 +660,7 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
 		return ret;
 	if (panel) {
 		panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+		drm_panel_put(panel);
 		if (IS_ERR(panel_bridge))
 			return PTR_ERR(panel_bridge);
 	}
diff --git a/drivers/gpu/drm/bridge/lvds-codec.c b/drivers/gpu/drm/bridge/lvds-codec.c
index e6a7147e141b6..72ac427e7b88b 100644
--- a/drivers/gpu/drm/bridge/lvds-codec.c
+++ b/drivers/gpu/drm/bridge/lvds-codec.c
@@ -154,6 +154,7 @@ static int lvds_codec_probe(struct platform_device *pdev)
 	lvds_codec->panel_bridge =
 		devm_drm_panel_bridge_add_typed(dev, panel,
 						lvds_codec->connector_type);
+	drm_panel_put(panel);
 	if (IS_ERR(lvds_codec->panel_bridge))
 		return PTR_ERR(lvds_codec->panel_bridge);
 
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
index 3bfa18167dd26..218445528a57a 100644
--- a/drivers/gpu/drm/bridge/panel.c
+++ b/drivers/gpu/drm/bridge/panel.c
@@ -515,8 +515,10 @@ struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (panel)
+	if (panel) {
 		bridge = devm_drm_panel_bridge_add(dev, panel);
+		drm_panel_put(panel);
+	}
 
 	return bridge;
 }
@@ -549,8 +551,10 @@ struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (panel)
+	if (panel) {
 		bridge = drmm_panel_bridge_add(drm, panel);
+		drm_panel_put(panel);
+	}
 
 	return bridge;
 }
diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
index 9ee0515074c78..0cd2a7e195061 100644
--- a/drivers/gpu/drm/bridge/samsung-dsim.c
+++ b/drivers/gpu/drm/bridge/samsung-dsim.c
@@ -1934,6 +1934,7 @@ static int samsung_dsim_host_attach(struct mipi_dsi_host *host,
 	panel = of_drm_find_panel(remote);
 	if (!IS_ERR(panel)) {
 		next_bridge = devm_drm_panel_bridge_add(dev, panel);
+		drm_panel_put(panel);
 		if (IS_ERR(next_bridge)) {
 			ret = PTR_ERR(next_bridge);
 			next_bridge = NULL; // Inhibit the cleanup action on an ERR_PTR
diff --git a/drivers/gpu/drm/bridge/ssd2825.c b/drivers/gpu/drm/bridge/ssd2825.c
index 54ca6bd6883ae..ac6d9b9d1f9e1 100644
--- a/drivers/gpu/drm/bridge/ssd2825.c
+++ b/drivers/gpu/drm/bridge/ssd2825.c
@@ -301,6 +301,7 @@ static int ssd2825_dsi_host_attach(struct mipi_dsi_host *host, struct mipi_dsi_d
 
 	if (panel) {
 		bridge = drm_panel_bridge_add_typed(panel, DRM_MODE_CONNECTOR_DSI);
+		drm_panel_put(panel);
 		if (IS_ERR(bridge))
 			return PTR_ERR(bridge);
 	}
diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 7188935fdb826..29c0a58b907cc 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2329,6 +2329,7 @@ static int tc_probe_dpi_bridge_endpoint(struct tc_data *tc)
 
 	if (panel) {
 		bridge = devm_drm_panel_bridge_add(dev, panel);
+		drm_panel_put(panel);
 		if (IS_ERR(bridge))
 			return PTR_ERR(bridge);
 	}
@@ -2359,6 +2360,7 @@ static int tc_probe_edp_bridge_endpoint(struct tc_data *tc)
 		struct drm_bridge *panel_bridge;
 
 		panel_bridge = devm_drm_panel_bridge_add(dev, panel);
+		drm_panel_put(panel);
 		if (IS_ERR(panel_bridge))
 			return PTR_ERR(panel_bridge);
 
diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 0f2820b373029..560cf2ab12079 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -479,6 +479,7 @@ static int tc358768_dsi_host_attach(struct mipi_dsi_host *host,
 	if (panel) {
 		bridge = drm_panel_bridge_add_typed(panel,
 						    DRM_MODE_CONNECTOR_DSI);
+		drm_panel_put(panel);
 		if (IS_ERR(bridge))
 			return PTR_ERR(bridge);
 
diff --git a/drivers/gpu/drm/bridge/waveshare-dsi.c b/drivers/gpu/drm/bridge/waveshare-dsi.c
index ded57f298d640..650d9be7ae661 100644
--- a/drivers/gpu/drm/bridge/waveshare-dsi.c
+++ b/drivers/gpu/drm/bridge/waveshare-dsi.c
@@ -163,6 +163,7 @@ static int ws_bridge_probe(struct i2c_client *i2c)
 		return dev_err_probe(dev, ret, "Failed to find remote panel\n");
 
 	ws->next_bridge = devm_drm_panel_bridge_add(dev, panel);
+	drm_panel_put(panel);
 	if (IS_ERR(ws->next_bridge))
 		return PTR_ERR(ws->next_bridge);
 
diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index d03ada82eac96..1873a84514a68 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -225,7 +225,8 @@ EXPORT_SYMBOL_GPL(drm_of_encoder_active_endpoint);
  * @np: device tree node containing encoder output ports
  * @port: port in the device tree node
  * @endpoint: endpoint in the device tree node
- * @panel: pointer to hold returned drm_panel, must not be NULL
+ * @panel: pointer to hold returned drm_panel, must not be NULL. On success
+ *         the caller must call drm_panel_put() when done with the panel
  * @bridge: pointer to hold returned drm_bridge
  *
  * Given a DT node's port and endpoint number, find the connected node and
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 545fe93dc28fe..72cf86253c0cd 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -458,14 +458,17 @@ EXPORT_SYMBOL(__devm_drm_panel_alloc);
 
 #ifdef CONFIG_OF
 /**
- * of_drm_find_panel - look up a panel using a device tree node
+ * of_drm_find_panel - look up and reference a panel by device tree node
  * @np: device tree node of the panel
  *
  * Searches the set of registered panels for one that matches the given device
- * tree node. If a matching panel is found, return a pointer to it.
+ * tree node. If a matching panel is found, the panel's reference count is
+ * incremented before returning a pointer to it. The caller must call
+ * drm_panel_put() when it no longer needs the panel pointer.
  *
- * Return: A pointer to the panel registered for the specified device tree
- * node or an ERR_PTR() if no panel matching the device tree node can be found.
+ * Return: A reference-counted pointer to the panel registered for the specified
+ * device tree node or an ERR_PTR() if no panel matching the device tree node
+ * can be found.
  *
  * Possible error codes returned by this function:
  *
@@ -484,6 +487,7 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
 
 	list_for_each_entry(panel, &panel_list, list) {
 		if (panel->dev->of_node == np) {
+			drm_panel_get(panel);
 			mutex_unlock(&panel_lock);
 			return panel;
 		}
diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index b805403281504..a418011f7d4d6 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -182,8 +182,15 @@ static int exynos_dp_probe(struct platform_device *pdev)
 
 out:
 	dp->adp = analogix_dp_probe(dev, &dp->plat_data);
-	if (IS_ERR(dp->adp))
+	if (IS_ERR(dp->adp)) {
+		/*
+		 * The driver core does not invoke remove() for failed probes,
+		 * so release the probe-time panel reference here.
+		 */
+		if (dp->plat_data.panel)
+			drm_panel_put(dp->plat_data.panel);
 		return PTR_ERR(dp->adp);
+	}
 
 	if (dp->plat_data.panel || dp->plat_data.next_bridge)
 		return component_add(&pdev->dev, &exynos_dp_ops);
@@ -193,6 +200,16 @@ static int exynos_dp_probe(struct platform_device *pdev)
 
 static void exynos_dp_remove(struct platform_device *pdev)
 {
+	struct exynos_dp_device *dp = platform_get_drvdata(pdev);
+
+	/*
+	 * Release the probe-time reference from of_drm_find_panel(). If bind
+	 * ran, the panel_bridge holds a second reference that devm cleanup
+	 * will release when the bridge is destroyed after remove() returns.
+	 */
+	if (dp->plat_data.panel)
+		drm_panel_put(dp->plat_data.panel);
+
 	component_del(&pdev->dev, &exynos_dp_ops);
 }
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_dpi.c b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
index 0dc36df6ada34..9d15a0035ea99 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dpi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dpi.c
@@ -245,5 +245,8 @@ int exynos_dpi_remove(struct drm_encoder *encoder)
 
 	exynos_dpi_disable(&ctx->encoder);
 
+	if (ctx->panel)
+		drm_panel_put(ctx->panel);
+
 	return 0;
 }
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index 84eff7519e322..ec71fbbb0eb89 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -109,6 +109,13 @@ static int fsl_dcu_attach_panel(struct fsl_dcu_drm_device *fsl_dev,
 	return ret;
 }
 
+static void fsl_dcu_panel_put_action(void *data)
+{
+	struct drm_panel *panel = data;
+
+	drm_panel_put(panel);
+}
+
 int fsl_dcu_create_outputs(struct fsl_dcu_drm_device *fsl_dev)
 {
 	struct device_node *panel_node;
@@ -124,6 +131,12 @@ int fsl_dcu_create_outputs(struct fsl_dcu_drm_device *fsl_dev)
 		if (IS_ERR(fsl_dev->connector.panel))
 			return PTR_ERR(fsl_dev->connector.panel);
 
+		ret = devm_add_action_or_reset(fsl_dev->dev,
+					       fsl_dcu_panel_put_action,
+					       fsl_dev->connector.panel);
+		if (ret)
+			return ret;
+
 		return fsl_dcu_attach_panel(fsl_dev, fsl_dev->connector.panel);
 	}
 
@@ -132,6 +145,11 @@ int fsl_dcu_create_outputs(struct fsl_dcu_drm_device *fsl_dev)
 		return ret;
 
 	if (panel) {
+		ret = devm_add_action_or_reset(fsl_dev->dev,
+					       fsl_dcu_panel_put_action, panel);
+		if (ret)
+			return ret;
+
 		fsl_dev->connector.panel = panel;
 		return fsl_dcu_attach_panel(fsl_dev, panel);
 	}
diff --git a/drivers/gpu/drm/imx/dcss/dcss-kms.c b/drivers/gpu/drm/imx/dcss/dcss-kms.c
index 50bd7f36d36dd..01e0c10b6ea1a 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-kms.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-kms.c
@@ -77,6 +77,9 @@ static int dcss_kms_bridge_connector_init(struct dcss_kms_dev *kms)
 	if (ret)
 		return ret;
 
+	if (panel)
+		drm_panel_put(panel);
+
 	if (!bridge) {
 		dev_err(ddev->dev, "No bridge found %d.\n", ret);
 		return -ENODEV;
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 42c86f195c66b..1887e01d29701 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1297,9 +1297,11 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 			goto err_drvdata;
 		}
 
-		if (panel)
+		if (panel) {
 			bridge = devm_drm_panel_bridge_add_typed(dev, panel,
 								 DRM_MODE_CONNECTOR_DPI);
+			drm_panel_put(panel);
+		}
 
 		ib = drmm_encoder_alloc(drm, struct ingenic_drm_bridge, encoder,
 					NULL, DRM_MODE_ENCODER_DPI, NULL);
diff --git a/drivers/gpu/drm/logicvc/logicvc_interface.c b/drivers/gpu/drm/logicvc/logicvc_interface.c
index 689049d395c0d..81f760dc07f8d 100644
--- a/drivers/gpu/drm/logicvc/logicvc_interface.c
+++ b/drivers/gpu/drm/logicvc/logicvc_interface.c
@@ -28,6 +28,11 @@
 #define logicvc_interface_from_drm_connector(c) \
 	container_of(c, struct logicvc_interface, drm_connector)
 
+static void logicvc_panel_put_action(void *data)
+{
+	drm_panel_put(data);
+}
+
 static void logicvc_encoder_enable(struct drm_encoder *drm_encoder)
 {
 	struct logicvc_drm *logicvc = logicvc_drm(drm_encoder->dev);
@@ -160,6 +165,13 @@ int logicvc_interface_init(struct logicvc_drm *logicvc)
 	if (ret == -EPROBE_DEFER)
 		goto error_early;
 
+	if (interface->drm_panel) {
+		ret = devm_add_action_or_reset(dev, logicvc_panel_put_action,
+					       interface->drm_panel);
+		if (ret)
+			goto error_early;
+	}
+
 	ret = drm_encoder_init(drm_dev, &interface->drm_encoder,
 			       &logicvc_encoder_funcs, encoder_type, NULL);
 	if (ret) {
diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 5f2c462bad7e1..53275b575f0cb 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -153,6 +153,7 @@ static int mcde_modeset_init(struct drm_device *drm)
 		if (panel) {
 			bridge = drm_panel_bridge_add_typed(panel,
 					DRM_MODE_CONNECTOR_DPI);
+			drm_panel_put(panel);
 			if (IS_ERR(bridge)) {
 				dev_err(drm->dev,
 					"Could not connect panel bridge\n");
diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index 47d45897ed069..d9a454f226f79 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -1124,6 +1124,7 @@ static int mcde_dsi_bind(struct device *dev, struct device *master,
 	if (panel) {
 		bridge = drm_panel_bridge_add_typed(panel,
 						    DRM_MODE_CONNECTOR_DSI);
+		drm_panel_put(panel);
 		if (IS_ERR(bridge)) {
 			dev_err(dev, "error adding panel bridge\n");
 			return PTR_ERR(bridge);
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 9b8fbda85d28a..7cb19c15bf39e 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -127,6 +127,7 @@ static int mxsfb_attach_bridge(struct mxsfb_drm_private *mxsfb)
 	if (panel) {
 		bridge = devm_drm_panel_bridge_add_typed(drm->dev, panel,
 							 DRM_MODE_CONNECTOR_DPI);
+		drm_panel_put(panel);
 		if (IS_ERR(bridge))
 			return PTR_ERR(bridge);
 	}
diff --git a/drivers/gpu/drm/omapdrm/dss/output.c b/drivers/gpu/drm/omapdrm/dss/output.c
index ca891aba38209..6e9bc605ee22f 100644
--- a/drivers/gpu/drm/omapdrm/dss/output.c
+++ b/drivers/gpu/drm/omapdrm/dss/output.c
@@ -43,6 +43,7 @@ int omapdss_device_init_output(struct omap_dss_device *out,
 		struct drm_bridge *bridge;
 
 		bridge = drm_panel_bridge_add(out->panel);
+		drm_panel_put(out->panel);
 		if (IS_ERR(bridge)) {
 			dev_err(out->dev,
 				"unable to create panel bridge (%ld)\n",
diff --git a/drivers/gpu/drm/pl111/pl111_drv.c b/drivers/gpu/drm/pl111/pl111_drv.c
index ac7b1d12a0f59..8ec659b3c08eb 100644
--- a/drivers/gpu/drm/pl111/pl111_drv.c
+++ b/drivers/gpu/drm/pl111/pl111_drv.c
@@ -145,6 +145,7 @@ static int pl111_modeset_init(struct drm_device *dev)
 	if (panel) {
 		bridge = drm_panel_bridge_add_typed(panel,
 						    DRM_MODE_CONNECTOR_Unknown);
+		drm_panel_put(panel);
 		if (IS_ERR(bridge)) {
 			ret = PTR_ERR(bridge);
 			goto finish;
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
index db2088529b480..d8e7e9877ba86 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c
@@ -69,6 +69,7 @@ int rcar_du_encoder_init(struct rcar_du_device *rcdu,
 
 		bridge = devm_drm_panel_bridge_add_typed(rcdu->dev, panel,
 							 DRM_MODE_CONNECTOR_DPI);
+		drm_panel_put(panel);
 		if (IS_ERR(bridge))
 			return PTR_ERR(no_free_ptr(bridge));
 
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c b/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c
index 154410745a74b..cc2996f044721 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c
@@ -791,6 +791,7 @@ static int rcar_lvds_parse_dt(struct rcar_lvds *lvds)
 	if (lvds->panel) {
 		lvds->next_bridge = devm_drm_panel_bridge_add(lvds->dev,
 							      lvds->panel);
+		drm_panel_put(lvds->panel);
 		if (IS_ERR_OR_NULL(lvds->next_bridge)) {
 			ret = -EINVAL;
 			goto done;
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
index f50d166b764f5..3d0999e4fcfdf 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -90,6 +90,7 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
 
 		bridge = devm_drm_panel_bridge_add_typed(rcdu->dev, panel,
 							 DRM_MODE_CONNECTOR_DPI);
+		drm_panel_put(panel);
 		if (IS_ERR(bridge))
 			return PTR_ERR(no_free_ptr(bridge));
 
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 06072efd7fca3..4b2795a6caf8c 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -27,6 +27,7 @@
 #include <drm/drm_bridge_connector.h>
 #include <drm/bridge/analogix_dp.h>
 #include <drm/drm_of.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
@@ -472,6 +473,16 @@ static int rockchip_dp_probe(struct platform_device *pdev)
 
 static void rockchip_dp_remove(struct platform_device *pdev)
 {
+	struct rockchip_dp_device *dp = platform_get_drvdata(pdev);
+
+	/*
+	 * Release the probe-time reference from of_drm_find_panel(). If bind
+	 * ran, the panel_bridge holds a second reference that devm cleanup
+	 * will release when the bridge is destroyed after remove() returns.
+	 */
+	if (dp->plat_data.panel)
+		drm_panel_put(dp->plat_data.panel);
+
 	component_del(&pdev->dev, &rockchip_dp_component_ops);
 }
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 7a0c4fa29f2f0..d99dc708572e1 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -605,6 +605,8 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 
 	if (lvds->panel) {
 		lvds->bridge = drm_panel_bridge_add_typed(lvds->panel, DRM_MODE_CONNECTOR_LVDS);
+		drm_panel_put(lvds->panel);
+		lvds->panel = NULL;
 		if (IS_ERR(lvds->bridge)) {
 			ret = PTR_ERR(lvds->bridge);
 			goto err_free_encoder;
@@ -641,6 +643,8 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 err_free_encoder:
 	drm_encoder_cleanup(encoder);
 err_put_remote:
+	if (lvds->panel)
+		drm_panel_put(lvds->panel);
 	of_node_put(remote);
 err_put_port:
 	of_node_put(port);
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index add3123e5ce70..c908ea4cfa67a 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -131,6 +131,8 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 	if (ret < 0) {
 		DRM_DEV_ERROR(drm_dev->dev,
 			      "failed to initialize encoder: %d\n", ret);
+		if (panel)
+			drm_panel_put(panel);
 		return ERR_PTR(ret);
 	}
 
@@ -139,6 +141,7 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 	if (panel) {
 		bridge = drm_panel_bridge_add_typed(panel,
 						    DRM_MODE_CONNECTOR_LVDS);
+		drm_panel_put(panel);
 		if (IS_ERR(bridge))
 			return ERR_CAST(bridge);
 	}
diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index 7484d3c3f4ed5..64a9da0362fb8 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -492,6 +492,9 @@ static void sti_dvo_unbind(struct device *dev,
 {
 	struct sti_dvo *dvo = dev_get_drvdata(dev);
 
+	if (dvo->panel)
+		drm_panel_put(dvo->panel);
+
 	drm_bridge_remove(&dvo->bridge);
 }
 
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 95fcfa48d8be3..daf198edb42f5 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1982,6 +1982,7 @@ int ltdc_load(struct drm_device *ddev)
 
 		if (panel) {
 			bridge = drmm_panel_bridge_add(ddev, panel);
+			drm_panel_put(panel);
 			if (IS_ERR(bridge)) {
 				drm_err(ddev, "panel-bridge endpoint %d\n", i);
 				ret = PTR_ERR(bridge);
diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
index 50a878688e477..f887a708afb73 100644
--- a/drivers/gpu/drm/stm/lvds.c
+++ b/drivers/gpu/drm/stm/lvds.c
@@ -1068,20 +1068,20 @@ static int lvds_probe(struct platform_device *pdev)
 	if (IS_ERR(lvds->base)) {
 		ret = PTR_ERR(lvds->base);
 		dev_err(dev, "Unable to get regs %d\n", ret);
-		return ret;
+		goto err_put_panel;
 	}
 
 	lvds->pclk = devm_clk_get(dev, "pclk");
 	if (IS_ERR(lvds->pclk)) {
 		ret = PTR_ERR(lvds->pclk);
 		dev_err(dev, "Unable to get peripheral clock: %d\n", ret);
-		return ret;
+		goto err_put_panel;
 	}
 
 	ret = clk_prepare_enable(lvds->pclk);
 	if (ret) {
 		dev_err(dev, "%s: Failed to enable peripheral clk\n", __func__);
-		return ret;
+		goto err_put_panel;
 	}
 
 	rstc = devm_reset_control_get_exclusive(dev, NULL);
@@ -1181,6 +1181,9 @@ static int lvds_probe(struct platform_device *pdev)
 
 err_lvds_probe:
 	clk_disable_unprepare(lvds->pclk);
+err_put_panel:
+	if (lvds->panel)
+		drm_panel_put(lvds->panel);
 
 	return ret;
 }
@@ -1189,6 +1192,9 @@ static void lvds_remove(struct platform_device *pdev)
 {
 	struct stm_lvds *lvds = platform_get_drvdata(pdev);
 
+	if (lvds->panel)
+		drm_panel_put(lvds->panel);
+
 	lvds_pixel_clk_unregister(lvds);
 
 	drm_bridge_remove(&lvds->lvds_bridge);
diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index 6716e895ae8a4..e1b342c922224 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -18,6 +18,11 @@
 #include "sun4i_tcon.h"
 #include "sun4i_lvds.h"
 
+static void sun4i_panel_put_action(void *data)
+{
+	drm_panel_put(data);
+}
+
 struct sun4i_lvds {
 	struct drm_connector	connector;
 	struct drm_encoder	encoder;
@@ -113,6 +118,14 @@ int sun4i_lvds_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 		return 0;
 	}
 
+	if (lvds->panel) {
+		ret = devm_add_action_or_reset(tcon->dev,
+					       sun4i_panel_put_action,
+					       lvds->panel);
+		if (ret)
+			return ret;
+	}
+
 	drm_encoder_helper_add(&lvds->encoder,
 			       &sun4i_lvds_enc_helper_funcs);
 	ret = drm_simple_encoder_init(drm, &lvds->encoder,
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index dfb6acc42f02e..0066bec5a9e5a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -43,6 +43,11 @@ drm_encoder_to_sun4i_rgb(struct drm_encoder *encoder)
 			    encoder);
 }
 
+static void sun4i_panel_put_action(void *data)
+{
+	drm_panel_put(data);
+}
+
 static int sun4i_rgb_get_modes(struct drm_connector *connector)
 {
 	struct sun4i_rgb *rgb =
@@ -205,6 +210,14 @@ int sun4i_rgb_init(struct drm_device *drm, struct sun4i_tcon *tcon)
 		return 0;
 	}
 
+	if (rgb->panel) {
+		ret = devm_add_action_or_reset(tcon->dev,
+					       sun4i_panel_put_action,
+					       rgb->panel);
+		if (ret)
+			return ret;
+	}
+
 	drm_encoder_helper_add(&rgb->encoder,
 			       &sun4i_rgb_enc_helper_funcs);
 	ret = drm_simple_encoder_init(drm, &rgb->encoder,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 960e83c8291da..d4c1723c5e3d8 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -1326,6 +1326,8 @@ static int sun4i_tcon_probe(struct platform_device *pdev)
 		ret = drm_of_find_panel_or_bridge(node, 1, 0, &panel, &bridge);
 		if (ret == -EPROBE_DEFER)
 			return ret;
+		if (panel)
+			drm_panel_put(panel);
 	}
 
 	return component_add(&pdev->dev, &sun4i_tcon_ops);
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index c35b70d83e53b..09c2a48b59128 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -967,8 +967,10 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
 
 	if (IS_ERR(panel))
 		return PTR_ERR(panel);
-	if (!dsi->drm || !dsi->drm->registered)
+	if (!dsi->drm || !dsi->drm->registered) {
+		drm_panel_put(panel);
 		return -EPROBE_DEFER;
+	}
 
 	dsi->panel = panel;
 	dsi->device = device;
@@ -985,6 +987,8 @@ static int sun6i_dsi_detach(struct mipi_dsi_host *host,
 {
 	struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
 
+	if (dsi->panel)
+		drm_panel_put(dsi->panel);
 	dsi->panel = NULL;
 	dsi->device = NULL;
 
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index 7f25c50621c94..500d7afd86db1 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1498,6 +1498,10 @@ static int tegra_dsi_host_attach(struct mipi_dsi_host *host,
 	if (!dsi->master) {
 		struct tegra_output *output = &dsi->output;
 
+		/*
+		 * tegra_output_probe() never populates a panel for DSI
+		 * outputs, so output->panel is always NULL here.
+		 */
 		output->panel = of_drm_find_panel(device->dev.of_node);
 		if (IS_ERR(output->panel))
 			output->panel = NULL;
@@ -1516,6 +1520,7 @@ static int tegra_dsi_host_detach(struct mipi_dsi_host *host,
 	struct tegra_output *output = &dsi->output;
 
 	if (output->panel && &device->dev == output->panel->dev) {
+		drm_panel_put(output->panel);
 		output->panel = NULL;
 
 		if (output->connector.dev)
diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index 49e4f63a5550d..d0ba3bd0aab8f 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -117,11 +117,19 @@ int tegra_output_probe(struct tegra_output *output)
 		 */
 		WARN_ON(output->panel || output->bridge);
 
+		if (output->panel) {
+			drm_panel_put(output->panel);
+			output->panel = NULL;
+		}
+
 		output->panel = of_drm_find_panel(panel);
 		of_node_put(panel);
 
-		if (IS_ERR(output->panel))
-			return PTR_ERR(output->panel);
+		if (IS_ERR(output->panel)) {
+			err = PTR_ERR(output->panel);
+			output->panel = NULL;
+			return err;
+		}
 	}
 
 	ddc = of_parse_phandle(output->of_node, "nvidia,ddc-i2c-bus", 0);
@@ -131,7 +139,7 @@ int tegra_output_probe(struct tegra_output *output)
 
 		if (!output->ddc) {
 			err = -EPROBE_DEFER;
-			return err;
+			goto put_i2c;
 		}
 	}
 
@@ -185,6 +193,11 @@ int tegra_output_probe(struct tegra_output *output)
 	return 0;
 
 put_i2c:
+	if (output->panel) {
+		drm_panel_put(output->panel);
+		output->panel = NULL;
+	}
+
 	if (output->ddc)
 		i2c_put_adapter(output->ddc);
 
@@ -195,6 +208,11 @@ int tegra_output_probe(struct tegra_output *output)
 
 void tegra_output_remove(struct tegra_output *output)
 {
+	if (output->panel) {
+		drm_panel_put(output->panel);
+		output->panel = NULL;
+	}
+
 	if (output->hpd_gpio)
 		free_irq(output->hpd_irq, output);
 
diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index 1512ee2574b66..70c14c3be10d5 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -162,6 +162,7 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 
 		if (panel) {
 			u32 conn_type;
+			int ret;
 
 			dev_dbg(dev, "Setting up panel for port %d\n", i);
 
@@ -176,7 +177,8 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 				break;
 			default:
 				WARN_ON(1);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto put_panel;
 			}
 
 			if (panel->connector_type != conn_type) {
@@ -184,16 +186,20 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 					"%s: Panel %s has incompatible connector type for vp%d (%d != %d)\n",
 					 __func__, dev_name(panel->dev), i,
 					 panel->connector_type, conn_type);
-				return -EINVAL;
+				ret = -EINVAL;
+				goto put_panel;
 			}
 
 			bridge = devm_drm_panel_bridge_add(dev, panel);
-			if (IS_ERR(bridge)) {
+			ret = PTR_ERR_OR_ZERO(bridge);
+			if (ret)
 				dev_err(dev,
 					"failed to set up panel bridge for port %d\n",
 					i);
-				return PTR_ERR(bridge);
-			}
+put_panel:
+			drm_panel_put(panel);
+			if (ret)
+				return ret;
 		}
 
 		pipes[num_pipes].hw_videoport = i;
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 562f3f11812a3..f858c58ccb994 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -84,6 +84,7 @@ static int tve200_modeset_init(struct drm_device *dev)
 	if (panel) {
 		bridge = drm_panel_bridge_add_typed(panel,
 						    DRM_MODE_CONNECTOR_Unknown);
+		drm_panel_put(panel);
 		if (IS_ERR(bridge)) {
 			ret = PTR_ERR(bridge);
 			goto out_bridge;

-- 
2.55.0

