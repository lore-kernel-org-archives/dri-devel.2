Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ADA7CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC55A10E382;
	Fri, 26 Jun 2026 12:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PvXy44Qx";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F6610E382
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 12:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782475533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tehUNq5ZbEdzZ2UahFaG3rRNIzcYgu6EZCbPtchbl9k=;
 b=PvXy44QxCQbZjBWC+DGxToKxKLQq1yEmmn04cTo17TxNHFJR68R4UBCj7nxeH5aWFH22UU
 V0fsfEFxQOlIkme9G0zollwihU4U8RwjfvtspIVih0b61HFMxicusXCEHxFyTsMuDJHXIL
 IAxe146cJenHNen8KKW27Eef3UfDwHU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-MHdTXZsqPY-XO5KtYnx3Sg-1; Fri,
 26 Jun 2026 08:05:31 -0400
X-MC-Unique: MHdTXZsqPY-XO5KtYnx3Sg-1
X-Mimecast-MFC-AGG-ID: MHdTXZsqPY-XO5KtYnx3Sg_1782475526
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9774F180059C; Fri, 26 Jun 2026 12:05:25 +0000 (UTC)
Received: from [192.168.1.153] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC4A818005B1; Fri, 26 Jun 2026 12:05:06 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Fri, 26 Jun 2026 14:03:27 +0200
Subject: [PATCH 5/5] drm: release panel reference after panel bridge creation
MIME-Version: 1.0
Message-Id: <20260626-drm_refcount_wiring-v1-5-cca1a7b3bdef@redhat.com>
References: <20260626-drm_refcount_wiring-v1-0-cca1a7b3bdef@redhat.com>
In-Reply-To: <20260626-drm_refcount_wiring-v1-0-cca1a7b3bdef@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782475410; l=10677;
 i=aesteve@redhat.com; s=20260303; h=from:subject:message-id;
 bh=6scmZ9j9U+06YnLSoU4k9QKFgpBcPiAlEhennC2B8y4=;
 b=sOpCxY2bLeUvPfxPkMPeicSMFpDUufT1NOftgzzbt/ErhfsmdnBFxDM/qyWZSlWt8I7unXXV1
 srGJDpgn5lzDcN6gpXD74BF+ukFCknmX8wtL/CayeGDImWSy31GYzqD
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=YSFz6sOHd2L45+Fr8DIvHTi6lSIjhLZ5T+rkxspJt1s=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ArElc_NgaBSIsyDCc8jxz4Jt0t3uL7ckYl1AJd5TSuw_1782475526
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

of_drm_find_panel() and drm_of_find_panel_or_bridge() now return a
counted reference. In drivers that immediately wrap the panel in a
bridge via devm_drm_panel_bridge_add() or equivalent, the bridge
acquires its own reference, so the caller's lookup reference must be
released right afterwards.

Also handle the cases where a panel is found but cannot be used,
dropping the reference immediately in those paths.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/gpu/drm/imx/dcss/dcss-kms.c               |  3 +++
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c         |  4 +++-
 drivers/gpu/drm/mcde/mcde_drv.c                   |  1 +
 drivers/gpu/drm/mcde/mcde_dsi.c                   |  1 +
 drivers/gpu/drm/mxsfb/mxsfb_drv.c                 |  1 +
 drivers/gpu/drm/omapdrm/dss/output.c              |  1 +
 drivers/gpu/drm/pl111/pl111_drv.c                 |  1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c |  1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_lvds.c       |  1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  1 +
 drivers/gpu/drm/rockchip/rockchip_lvds.c          |  1 +
 drivers/gpu/drm/rockchip/rockchip_rgb.c           |  1 +
 drivers/gpu/drm/stm/ltdc.c                        |  1 +
 drivers/gpu/drm/sun4i/sun4i_tcon.c                |  2 ++
 drivers/gpu/drm/tidss/tidss_kms.c                 | 16 +++++++++++-----
 drivers/gpu/drm/tve200/tve200_drv.c               |  1 +
 16 files changed, 31 insertions(+), 6 deletions(-)

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
index 0b756da2fec22..bfcdc0c237ee1 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -128,6 +128,7 @@ static int mxsfb_attach_bridge(struct mxsfb_drm_private *mxsfb)
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
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 7a0c4fa29f2f0..f754445d2631b 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -605,6 +605,7 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
 
 	if (lvds->panel) {
 		lvds->bridge = drm_panel_bridge_add_typed(lvds->panel, DRM_MODE_CONNECTOR_LVDS);
+		drm_panel_put(lvds->panel);
 		if (IS_ERR(lvds->bridge)) {
 			ret = PTR_ERR(lvds->bridge);
 			goto err_free_encoder;
diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index add3123e5ce70..ea66c70013787 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -139,6 +139,7 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 	if (panel) {
 		bridge = drm_panel_bridge_add_typed(panel,
 						    DRM_MODE_CONNECTOR_LVDS);
+		drm_panel_put(panel);
 		if (IS_ERR(bridge))
 			return ERR_CAST(bridge);
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
2.54.0

