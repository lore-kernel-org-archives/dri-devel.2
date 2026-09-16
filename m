Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7368CC982C4
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 910E710E3D1;
	Wed, 16 Sep 2026 13:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pLTpkrio";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7882510E39A
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:46:15 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id EBCE1C5CD63;
 Wed, 16 Sep 2026 13:46:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id F179F60337;
 Wed, 16 Sep 2026 13:46:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D02C211C7B038; 
 Wed, 16 Sep 2026 15:46:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789566371; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=EqvrIIoE0JyZcyBZuz3MkqU1PQw7VsonK4KhakoswrY=;
 b=pLTpkrioR3juEwJa1gE924mb0r+hJCIBDqsP01hfmi6IyzpF0VKMSf+tZQHwje5R8E75dN
 cmuxAEPrPLGsQ0RuIw2IzAx+wDknuvOTXlrXNpKIZfcXEsUu7FlaGD2o49pedCUFQ/nW8r
 FHZFZjVpRQ4RsgMWMcM/vUEinZk6TI7LIddIX2sCTL++JF82clYWh4ST9ysFP4NAcj4Wmm
 sSP0S2pV+Oy4Q8VmmN93mrkJUVkodf0z3GW48kQaaGDqrz2igjA+J5n93jPgKC7lB8W+xc
 3QPT3HHKIzLx608nTmBku2CF31yjVZD+1kDhv0Pl9jk5hp7WAcXG93tKt1uljQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 16 Sep 2026 15:45:28 +0200
Subject: [PATCH v3 04/19] drm/bridge: panel: move all code to drm_panel.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-bridge-every-panel-v3-4-83afb4f1a707@bootlin.com>
References: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
In-Reply-To: <20260916-drm-bridge-every-panel-v3-0-83afb4f1a707@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Paul Cercueil <paul@crapouillou.net>, 
 Paul Kocialkowski <paulk@sys-base.io>, Linus Walleij <linusw@kernel.org>, 
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, Sean Paul <sean@poorly.run>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: Albert Esteve <aesteve@redhat.com>, 
 Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-mips@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, asahi@lists.linux.dev, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

Work is in progress for every drm_panel to embed a drm_bridge, replacing
the panel_bridge entirely. However most of the panel_bridge code will be
reused for the drm_bridge embedded into the drm_panel, so just move the
code there.

Adapt users of the moved functions to include drm_panel.h when necessary.

No functional changes, just moving code around.

Suggested-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/Makefile                         |   1 -
 drivers/gpu/drm/adp/adp-mipi.c                   |   1 +
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c |   1 +
 drivers/gpu/drm/bridge/aux-bridge.c              |   1 +
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c   |   1 +
 drivers/gpu/drm/bridge/imx/imx93-pdfc.c          |   1 +
 drivers/gpu/drm/bridge/panel.c                   | 563 ----------------------
 drivers/gpu/drm/bridge/ti-tdp158.c               |   1 +
 drivers/gpu/drm/display/drm_bridge_connector.c   |   1 +
 drivers/gpu/drm/drm_panel.c                      | 574 ++++++++++++++++++++++-
 drivers/gpu/drm/imx/dc/dc-kms.c                  |   1 +
 drivers/gpu/drm/mcde/mcde_display.c              |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c              |   1 +
 drivers/gpu/drm/msm/dsi/dsi.c                    |   3 +-
 drivers/gpu/drm/tegra/rgb.c                      |   1 +
 include/drm/drm_bridge.h                         |  52 --
 include/drm/drm_of.h                             |   1 +
 include/drm/drm_panel.h                          |  53 +++
 18 files changed, 622 insertions(+), 636 deletions(-)

diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 29c9c1d90c11..4ac7b909bd61 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -156,7 +156,6 @@ drm_kms_helper-y := \
 	drm_self_refresh_helper.o \
 	drm_simple_kms_helper.o \
 	drm_vblank_helper.o
-drm_kms_helper-$(CONFIG_DRM_PANEL_BRIDGE) += bridge/panel.o
 drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
 obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 
diff --git a/drivers/gpu/drm/adp/adp-mipi.c b/drivers/gpu/drm/adp/adp-mipi.c
index 232bb9539423..956533870781 100644
--- a/drivers/gpu/drm/adp/adp-mipi.c
+++ b/drivers/gpu/drm/adp/adp-mipi.c
@@ -8,6 +8,7 @@
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
 
 #define DSI_GEN_HDR 0x6c
 #define DSI_GEN_PLD_DATA 0x70
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index 3d81b413efae..0fd069fc3386 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -15,6 +15,7 @@
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_panel.h>
 
 #include "komeda_dev.h"
 #include "komeda_kms.h"
diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge/aux-bridge.c
index 169939d23310..90f76bb529cc 100644
--- a/drivers/gpu/drm/bridge/aux-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-bridge.c
@@ -12,6 +12,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/bridge/aux-bridge.h>
+#include <drm/drm_panel.h>
 
 static DEFINE_IDA(drm_aux_bridge_ida);
 
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index c3e466ded84a..1e28ea579b06 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -7,6 +7,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 #include <video/mipi_display.h>
 #include <video/videomode.h>
diff --git a/drivers/gpu/drm/bridge/imx/imx93-pdfc.c b/drivers/gpu/drm/bridge/imx/imx93-pdfc.c
index 2d6ca95ed554..2e5019ed951a 100644
--- a/drivers/gpu/drm/bridge/imx/imx93-pdfc.c
+++ b/drivers/gpu/drm/bridge/imx/imx93-pdfc.c
@@ -16,6 +16,7 @@
 
 #include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_panel.h>
 
 #define IMX93_DISPLAY_MUX_REG		0x60
 #define PARALLEL_DISP_FORMAT		GENMASK(10, 8)
diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
deleted file mode 100644
index 02388a3de626..000000000000
--- a/drivers/gpu/drm/bridge/panel.c
+++ /dev/null
@@ -1,563 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2016 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
- * Copyright (C) 2017 Broadcom
- */
-
-#include <linux/debugfs.h>
-#include <linux/export.h>
-
-#include <drm/drm_atomic_helper.h>
-#include <drm/drm_bridge.h>
-#include <drm/drm_connector.h>
-#include <drm/drm_encoder.h>
-#include <drm/drm_managed.h>
-#include <drm/drm_modeset_helper_vtables.h>
-#include <drm/drm_of.h>
-#include <drm/drm_panel.h>
-#include <drm/drm_print.h>
-#include <drm/drm_probe_helper.h>
-
-struct panel_bridge {
-	struct drm_bridge bridge;
-	struct drm_connector connector;
-	struct drm_panel *panel;
-	u32 connector_type;
-};
-
-static inline struct panel_bridge *
-drm_bridge_to_panel_bridge(struct drm_bridge *bridge)
-{
-	return container_of(bridge, struct panel_bridge, bridge);
-}
-
-static inline struct panel_bridge *
-drm_connector_to_panel_bridge(struct drm_connector *connector)
-{
-	return container_of(connector, struct panel_bridge, connector);
-}
-
-static int panel_bridge_connector_get_modes(struct drm_connector *connector)
-{
-	struct panel_bridge *panel_bridge =
-		drm_connector_to_panel_bridge(connector);
-
-	return drm_panel_get_modes(panel_bridge->panel, connector);
-}
-
-static const struct drm_connector_helper_funcs
-panel_bridge_connector_helper_funcs = {
-	.get_modes = panel_bridge_connector_get_modes,
-};
-
-static const struct drm_connector_funcs panel_bridge_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
-	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
-};
-
-static int panel_bridge_attach(struct drm_bridge *bridge,
-			       struct drm_encoder *encoder,
-			       enum drm_bridge_attach_flags flags)
-{
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	struct drm_connector *connector = &panel_bridge->connector;
-	int ret;
-
-	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
-		return 0;
-
-	drm_connector_helper_add(connector,
-				 &panel_bridge_connector_helper_funcs);
-
-	ret = drm_connector_init(bridge->dev, connector,
-				 &panel_bridge_connector_funcs,
-				 panel_bridge->connector_type);
-	if (ret) {
-		DRM_ERROR("Failed to initialize connector\n");
-		return ret;
-	}
-
-	drm_panel_bridge_set_orientation(connector, bridge);
-
-	drm_connector_attach_encoder(&panel_bridge->connector,
-					  encoder);
-
-	if (bridge->dev->registered) {
-		if (connector->funcs->reset)
-			connector->funcs->reset(connector);
-		drm_connector_register(connector);
-	}
-
-	return 0;
-}
-
-static void panel_bridge_detach(struct drm_bridge *bridge)
-{
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	struct drm_connector *connector = &panel_bridge->connector;
-
-	/*
-	 * Cleanup the connector if we know it was initialized.
-	 *
-	 * FIXME: This wouldn't be needed if the panel_bridge structure was
-	 * allocated with drmm_kzalloc(). This might be tricky since the
-	 * drm_device pointer can only be retrieved when the bridge is attached.
-	 */
-	if (connector->dev)
-		drm_connector_cleanup(connector);
-}
-
-static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
-					   struct drm_atomic_commit *atomic_state)
-{
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	struct drm_encoder *encoder = bridge->encoder;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *old_crtc_state;
-
-	crtc = drm_atomic_get_new_crtc_for_encoder(atomic_state, encoder);
-	if (!crtc)
-		return;
-
-	old_crtc_state = drm_atomic_get_old_crtc_state(atomic_state, crtc);
-	if (old_crtc_state && old_crtc_state->self_refresh_active)
-		return;
-
-	drm_panel_prepare(panel_bridge->panel);
-}
-
-static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
-				       struct drm_atomic_commit *atomic_state)
-{
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	struct drm_encoder *encoder = bridge->encoder;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *old_crtc_state;
-
-	crtc = drm_atomic_get_new_crtc_for_encoder(atomic_state, encoder);
-	if (!crtc)
-		return;
-
-	old_crtc_state = drm_atomic_get_old_crtc_state(atomic_state, crtc);
-	if (old_crtc_state && old_crtc_state->self_refresh_active)
-		return;
-
-	drm_panel_enable(panel_bridge->panel);
-}
-
-static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
-					struct drm_atomic_commit *atomic_state)
-{
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	struct drm_encoder *encoder = bridge->encoder;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *new_crtc_state;
-
-	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_state, encoder);
-	if (!crtc)
-		return;
-
-	new_crtc_state = drm_atomic_get_new_crtc_state(atomic_state, crtc);
-	if (new_crtc_state && new_crtc_state->self_refresh_active)
-		return;
-
-	drm_panel_disable(panel_bridge->panel);
-}
-
-static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
-					     struct drm_atomic_commit *atomic_state)
-{
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	struct drm_encoder *encoder = bridge->encoder;
-	struct drm_crtc *crtc;
-	struct drm_crtc_state *new_crtc_state;
-
-	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_state, encoder);
-	if (!crtc)
-		return;
-
-	new_crtc_state = drm_atomic_get_new_crtc_state(atomic_state, crtc);
-	if (new_crtc_state && new_crtc_state->self_refresh_active)
-		return;
-
-	drm_panel_unprepare(panel_bridge->panel);
-}
-
-static int panel_bridge_get_modes(struct drm_bridge *bridge,
-				  struct drm_connector *connector)
-{
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
-
-	return drm_panel_get_modes(panel_bridge->panel, connector);
-}
-
-static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
-				      struct dentry *root)
-{
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	struct drm_panel *panel = panel_bridge->panel;
-
-	root = debugfs_create_dir("panel", root);
-	if (panel->funcs->debugfs_init)
-		panel->funcs->debugfs_init(panel, root);
-}
-
-static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
-	.attach = panel_bridge_attach,
-	.detach = panel_bridge_detach,
-	.atomic_pre_enable = panel_bridge_atomic_pre_enable,
-	.atomic_enable = panel_bridge_atomic_enable,
-	.atomic_disable = panel_bridge_atomic_disable,
-	.atomic_post_disable = panel_bridge_atomic_post_disable,
-	.get_modes = panel_bridge_get_modes,
-	.atomic_create_state = drm_atomic_helper_bridge_create_state,
-	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
-	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
-	.debugfs_init = panel_bridge_debugfs_init,
-};
-
-/**
- * drm_bridge_is_panel - Checks if a drm_bridge is a panel_bridge.
- *
- * @bridge: The drm_bridge to be checked.
- *
- * Returns true if the bridge is a panel bridge, or false otherwise.
- */
-bool drm_bridge_is_panel(const struct drm_bridge *bridge)
-{
-	return bridge->funcs == &panel_bridge_bridge_funcs;
-}
-EXPORT_SYMBOL(drm_bridge_is_panel);
-
-/**
- * drm_panel_bridge_add - Creates a &drm_bridge and &drm_connector that
- * just calls the appropriate functions from &drm_panel.
- *
- * @panel: The drm_panel being wrapped.  Must be non-NULL.
- *
- * For drivers converting from directly using drm_panel: The expected
- * usage pattern is that during either encoder module probe or DSI
- * host attach, a drm_panel will be looked up through
- * drm_of_find_panel_or_bridge().  drm_panel_bridge_add() is used to
- * wrap that panel in the new bridge, and the result can then be
- * passed to drm_bridge_attach().  The drm_panel_prepare() and related
- * functions can be dropped from the encoder driver (they're now
- * called by the KMS helpers before calling into the encoder), along
- * with connector creation.  When done with the bridge (after
- * drm_mode_config_cleanup() if the bridge has already been attached), then
- * drm_panel_bridge_remove() to free it.
- *
- * The connector type is set to @panel->connector_type, which must be set to a
- * known type. Calling this function with a panel whose connector type is
- * DRM_MODE_CONNECTOR_Unknown will return ERR_PTR(-EINVAL).
- *
- * See devm_drm_panel_bridge_add() for an automatically managed version of this
- * function.
- */
-struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel)
-{
-	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
-		return ERR_PTR(-EINVAL);
-
-	return drm_panel_bridge_add_typed(panel, panel->connector_type);
-}
-EXPORT_SYMBOL(drm_panel_bridge_add);
-
-/**
- * drm_panel_bridge_add_typed - Creates a &drm_bridge and &drm_connector with
- * an explicit connector type.
- * @panel: The drm_panel being wrapped.  Must be non-NULL.
- * @connector_type: The connector type (DRM_MODE_CONNECTOR_*)
- *
- * This is just like drm_panel_bridge_add(), but forces the connector type to
- * @connector_type instead of infering it from the panel.
- *
- * This function is deprecated and should not be used in new drivers. Use
- * drm_panel_bridge_add() instead, and fix panel drivers as necessary if they
- * don't report a connector type.
- */
-struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
-					      u32 connector_type)
-{
-	struct panel_bridge *panel_bridge;
-
-	if (!panel)
-		return ERR_PTR(-EINVAL);
-
-	panel_bridge = devm_drm_bridge_alloc(panel->dev, struct panel_bridge, bridge,
-					     &panel_bridge_bridge_funcs);
-	if (IS_ERR(panel_bridge))
-		return (void *)panel_bridge;
-
-	panel_bridge->connector_type = connector_type;
-	panel_bridge->panel = drm_panel_get(panel);
-
-	panel_bridge->bridge.of_node = panel->dev->of_node;
-	panel_bridge->bridge.ops = DRM_BRIDGE_OP_MODES;
-	panel_bridge->bridge.type = connector_type;
-	panel_bridge->bridge.pre_enable_prev_first = panel->prepare_prev_first;
-
-	drm_bridge_add(&panel_bridge->bridge);
-
-	return &panel_bridge->bridge;
-}
-EXPORT_SYMBOL(drm_panel_bridge_add_typed);
-
-/**
- * drm_panel_bridge_remove - Unregisters and frees a drm_bridge
- * created by drm_panel_bridge_add().
- *
- * @bridge: The drm_bridge being freed.
- */
-void drm_panel_bridge_remove(struct drm_bridge *bridge)
-{
-	struct panel_bridge *panel_bridge;
-	struct drm_panel *panel;
-
-	if (!bridge)
-		return;
-
-	if (!drm_bridge_is_panel(bridge)) {
-		drm_warn(bridge->dev, "%s: called on non-panel bridge!\n", __func__);
-		return;
-	}
-
-	panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	panel = panel_bridge->panel;
-
-	drm_bridge_remove(bridge);
-	/* TODO remove this after reworking panel_bridge lifetime */
-	devm_drm_put_bridge(panel->dev, bridge);
-	drm_panel_put(panel);
-}
-EXPORT_SYMBOL(drm_panel_bridge_remove);
-
-/**
- * drm_panel_bridge_set_orientation - Set the connector's panel orientation
- * from the bridge that can be transformed to panel bridge.
- *
- * @connector: The connector to be set panel orientation.
- * @bridge: The drm_bridge to be transformed to panel bridge.
- *
- * Returns 0 on success, negative errno on failure.
- */
-int drm_panel_bridge_set_orientation(struct drm_connector *connector,
-				     struct drm_bridge *bridge)
-{
-	struct panel_bridge *panel_bridge;
-
-	panel_bridge = drm_bridge_to_panel_bridge(bridge);
-
-	return drm_connector_set_orientation_from_panel(connector,
-							panel_bridge->panel);
-}
-EXPORT_SYMBOL(drm_panel_bridge_set_orientation);
-
-static void devm_drm_panel_bridge_release(struct device *dev, void *res)
-{
-	struct drm_bridge *bridge = *(struct drm_bridge **)res;
-	struct panel_bridge *panel_bridge;
-	struct drm_panel *panel;
-
-	if (!bridge)
-		return;
-
-	panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	panel = panel_bridge->panel;
-	drm_bridge_remove(bridge);
-	drm_panel_put(panel);
-}
-
-/**
- * devm_drm_panel_bridge_add - Creates a managed &drm_bridge and &drm_connector
- * that just calls the appropriate functions from &drm_panel.
- * @dev: device to tie the bridge lifetime to
- * @panel: The drm_panel being wrapped.  Must be non-NULL.
- *
- * This is the managed version of drm_panel_bridge_add() which automatically
- * calls drm_panel_bridge_remove() when @dev is unbound.
- */
-struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
-					     struct drm_panel *panel)
-{
-	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
-		return ERR_PTR(-EINVAL);
-
-	return devm_drm_panel_bridge_add_typed(dev, panel,
-					       panel->connector_type);
-}
-EXPORT_SYMBOL(devm_drm_panel_bridge_add);
-
-/**
- * devm_drm_panel_bridge_add_typed - Creates a managed &drm_bridge and
- * &drm_connector with an explicit connector type.
- * @dev: device to tie the bridge lifetime to
- * @panel: The drm_panel being wrapped.  Must be non-NULL.
- * @connector_type: The connector type (DRM_MODE_CONNECTOR_*)
- *
- * This is just like devm_drm_panel_bridge_add(), but forces the connector type
- * to @connector_type instead of infering it from the panel.
- *
- * This function is deprecated and should not be used in new drivers. Use
- * devm_drm_panel_bridge_add() instead, and fix panel drivers as necessary if
- * they don't report a connector type.
- */
-struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
-						   struct drm_panel *panel,
-						   u32 connector_type)
-{
-	struct drm_bridge **ptr, *bridge;
-
-	ptr = devres_alloc(devm_drm_panel_bridge_release, sizeof(*ptr),
-			   GFP_KERNEL);
-	if (!ptr)
-		return ERR_PTR(-ENOMEM);
-
-	bridge = drm_panel_bridge_add_typed(panel, connector_type);
-	if (IS_ERR(bridge)) {
-		devres_free(ptr);
-		return bridge;
-	}
-
-	*ptr = bridge;
-	devres_add(dev, ptr);
-
-	return bridge;
-}
-EXPORT_SYMBOL(devm_drm_panel_bridge_add_typed);
-
-static void drmm_drm_panel_bridge_release(struct drm_device *drm, void *ptr)
-{
-	struct drm_bridge *bridge = ptr;
-
-	drm_panel_bridge_remove(bridge);
-}
-
-/**
- * drmm_panel_bridge_add - Creates a DRM-managed &drm_bridge and
- *                         &drm_connector that just calls the
- *                         appropriate functions from &drm_panel.
- *
- * @drm: DRM device to tie the bridge lifetime to
- * @panel: The drm_panel being wrapped.  Must be non-NULL.
- *
- * This is the DRM-managed version of drm_panel_bridge_add() which
- * automatically calls drm_panel_bridge_remove() when @dev is cleaned
- * up.
- */
-struct drm_bridge *drmm_panel_bridge_add(struct drm_device *drm,
-					 struct drm_panel *panel)
-{
-	struct drm_bridge *bridge;
-	int ret;
-
-	bridge = drm_panel_bridge_add_typed(panel, panel->connector_type);
-	if (IS_ERR(bridge))
-		return bridge;
-
-	ret = drmm_add_action_or_reset(drm, drmm_drm_panel_bridge_release,
-				       bridge);
-	if (ret)
-		return ERR_PTR(ret);
-
-	return bridge;
-}
-EXPORT_SYMBOL(drmm_panel_bridge_add);
-
-/**
- * drm_panel_bridge_connector - return the connector for the panel bridge
- * @bridge: The drm_bridge.
- *
- * drm_panel_bridge creates the connector.
- * This function gives external access to the connector.
- *
- * Returns: Pointer to drm_connector
- */
-struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge)
-{
-	struct panel_bridge *panel_bridge;
-
-	panel_bridge = drm_bridge_to_panel_bridge(bridge);
-
-	return &panel_bridge->connector;
-}
-EXPORT_SYMBOL(drm_panel_bridge_connector);
-
-#ifdef CONFIG_OF
-/**
- * devm_drm_of_get_bridge - Return next bridge in the chain
- * @dev: device to tie the bridge lifetime to
- * @np: device tree node containing encoder output ports
- * @port: port in the device tree node
- * @endpoint: endpoint in the device tree node
- *
- * Given a DT node's port and endpoint number, finds the connected node
- * and returns the associated bridge if any, or creates and returns a
- * drm panel bridge instance if a panel is connected.
- *
- * Returns a pointer to the bridge if successful, or an error pointer
- * otherwise.
- */
-struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
-					  struct device_node *np,
-					  u32 port, u32 endpoint)
-{
-	struct drm_bridge *bridge;
-	struct drm_panel *panel;
-	int ret;
-
-	ret = drm_of_find_panel_or_bridge(np, port, endpoint,
-					  &panel, &bridge);
-	if (ret)
-		return ERR_PTR(ret);
-
-	if (panel) {
-		bridge = devm_drm_panel_bridge_add(dev, panel);
-		drm_panel_put(panel);
-	}
-
-	return bridge;
-}
-EXPORT_SYMBOL(devm_drm_of_get_bridge);
-
-/**
- * drmm_of_get_bridge - Return next bridge in the chain
- * @drm: device to tie the bridge lifetime to
- * @np: device tree node containing encoder output ports
- * @port: port in the device tree node
- * @endpoint: endpoint in the device tree node
- *
- * Given a DT node's port and endpoint number, finds the connected node
- * and returns the associated bridge if any, or creates and returns a
- * drm panel bridge instance if a panel is connected.
- *
- * Returns a drmm managed pointer to the bridge if successful, or an error
- * pointer otherwise.
- */
-struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
-				      struct device_node *np,
-				      u32 port, u32 endpoint)
-{
-	struct drm_bridge *bridge;
-	struct drm_panel *panel;
-	int ret;
-
-	ret = drm_of_find_panel_or_bridge(np, port, endpoint,
-					  &panel, &bridge);
-	if (ret)
-		return ERR_PTR(ret);
-
-	if (panel) {
-		bridge = drmm_panel_bridge_add(drm, panel);
-		drm_panel_put(panel);
-	}
-
-	return bridge;
-}
-EXPORT_SYMBOL(drmm_of_get_bridge);
-
-#endif
diff --git a/drivers/gpu/drm/bridge/ti-tdp158.c b/drivers/gpu/drm/bridge/ti-tdp158.c
index 01fc643bd78f..8e3e99cbe41a 100644
--- a/drivers/gpu/drm/bridge/ti-tdp158.c
+++ b/drivers/gpu/drm/bridge/ti-tdp158.c
@@ -8,6 +8,7 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_panel.h>
 
 struct tdp158 {
 	struct drm_bridge bridge;
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 00feb73e63d7..5b92ba848fa0 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -18,6 +18,7 @@
 #include <drm/drm_edid.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/display/drm_hdcp_helper.h>
diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index e1f8a4ff37d2..30e7dc81dd15 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -1,36 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2013, NVIDIA Corporation.  All rights reserved.
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sub license,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice (including the
- * next paragraph) shall be included in all copies or substantial portions
- * of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
- * DEALINGS IN THE SOFTWARE.
+ * Copyright (C) 2016 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+ * Copyright (C) 2017 Broadcom
  */
 
 #include <linux/backlight.h>
+#include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/of.h>
 
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
 
 static DEFINE_MUTEX(panel_lock);
 static LIST_HEAD(panel_list);
@@ -46,6 +38,550 @@ static LIST_HEAD(panel_list);
  * take look at drm_panel_bridge_add() and devm_drm_panel_bridge_add().
  */
 
+struct panel_bridge {
+	struct drm_bridge bridge;
+	struct drm_connector connector;
+	struct drm_panel *panel;
+	u32 connector_type;
+};
+
+static inline struct panel_bridge *
+drm_bridge_to_panel_bridge(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct panel_bridge, bridge);
+}
+
+static inline struct panel_bridge *
+drm_connector_to_panel_bridge(struct drm_connector *connector)
+{
+	return container_of(connector, struct panel_bridge, connector);
+}
+
+static int panel_bridge_connector_get_modes(struct drm_connector *connector)
+{
+	struct panel_bridge *panel_bridge =
+		drm_connector_to_panel_bridge(connector);
+
+	return drm_panel_get_modes(panel_bridge->panel, connector);
+}
+
+static const struct drm_connector_helper_funcs
+panel_bridge_connector_helper_funcs = {
+	.get_modes = panel_bridge_connector_get_modes,
+};
+
+static const struct drm_connector_funcs panel_bridge_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.fill_modes = drm_helper_probe_single_connector_modes,
+	.destroy = drm_connector_cleanup,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+static int panel_bridge_attach(struct drm_bridge *bridge,
+			       struct drm_encoder *encoder,
+			       enum drm_bridge_attach_flags flags)
+{
+	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_connector *connector = &panel_bridge->connector;
+	int ret;
+
+	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
+		return 0;
+
+	drm_connector_helper_add(connector,
+				 &panel_bridge_connector_helper_funcs);
+
+	ret = drm_connector_init(bridge->dev, connector,
+				 &panel_bridge_connector_funcs,
+				 panel_bridge->connector_type);
+	if (ret) {
+		DRM_ERROR("Failed to initialize connector\n");
+		return ret;
+	}
+
+	drm_panel_bridge_set_orientation(connector, bridge);
+
+	drm_connector_attach_encoder(&panel_bridge->connector,
+				     encoder);
+
+	if (bridge->dev->registered) {
+		if (connector->funcs->reset)
+			connector->funcs->reset(connector);
+		drm_connector_register(connector);
+	}
+
+	return 0;
+}
+
+static void panel_bridge_detach(struct drm_bridge *bridge)
+{
+	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_connector *connector = &panel_bridge->connector;
+
+	/*
+	 * Cleanup the connector if we know it was initialized.
+	 *
+	 * FIXME: This wouldn't be needed if the panel_bridge structure was
+	 * allocated with drmm_kzalloc(). This might be tricky since the
+	 * drm_device pointer can only be retrieved when the bridge is attached.
+	 */
+	if (connector->dev)
+		drm_connector_cleanup(connector);
+}
+
+static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					   struct drm_atomic_commit *atomic_state)
+{
+	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_crtc_state;
+
+	crtc = drm_atomic_get_new_crtc_for_encoder(atomic_state, encoder);
+	if (!crtc)
+		return;
+
+	old_crtc_state = drm_atomic_get_old_crtc_state(atomic_state, crtc);
+	if (old_crtc_state && old_crtc_state->self_refresh_active)
+		return;
+
+	drm_panel_prepare(panel_bridge->panel);
+}
+
+static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
+				       struct drm_atomic_commit *atomic_state)
+{
+	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_crtc_state;
+
+	crtc = drm_atomic_get_new_crtc_for_encoder(atomic_state, encoder);
+	if (!crtc)
+		return;
+
+	old_crtc_state = drm_atomic_get_old_crtc_state(atomic_state, crtc);
+	if (old_crtc_state && old_crtc_state->self_refresh_active)
+		return;
+
+	drm_panel_enable(panel_bridge->panel);
+}
+
+static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
+					struct drm_atomic_commit *atomic_state)
+{
+	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_crtc_state;
+
+	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_state, encoder);
+	if (!crtc)
+		return;
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(atomic_state, crtc);
+	if (new_crtc_state && new_crtc_state->self_refresh_active)
+		return;
+
+	drm_panel_disable(panel_bridge->panel);
+}
+
+static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
+					     struct drm_atomic_commit *atomic_state)
+{
+	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_encoder *encoder = bridge->encoder;
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *new_crtc_state;
+
+	crtc = drm_atomic_get_old_crtc_for_encoder(atomic_state, encoder);
+	if (!crtc)
+		return;
+
+	new_crtc_state = drm_atomic_get_new_crtc_state(atomic_state, crtc);
+	if (new_crtc_state && new_crtc_state->self_refresh_active)
+		return;
+
+	drm_panel_unprepare(panel_bridge->panel);
+}
+
+static int panel_bridge_get_modes(struct drm_bridge *bridge,
+				  struct drm_connector *connector)
+{
+	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+
+	return drm_panel_get_modes(panel_bridge->panel, connector);
+}
+
+static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
+				      struct dentry *root)
+{
+	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_panel *panel = panel_bridge->panel;
+
+	root = debugfs_create_dir("panel", root);
+	if (panel->funcs->debugfs_init)
+		panel->funcs->debugfs_init(panel, root);
+}
+
+static const struct drm_bridge_funcs panel_bridge_bridge_funcs = {
+	.attach = panel_bridge_attach,
+	.detach = panel_bridge_detach,
+	.atomic_pre_enable = panel_bridge_atomic_pre_enable,
+	.atomic_enable = panel_bridge_atomic_enable,
+	.atomic_disable = panel_bridge_atomic_disable,
+	.atomic_post_disable = panel_bridge_atomic_post_disable,
+	.get_modes = panel_bridge_get_modes,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_get_input_bus_fmts = drm_atomic_helper_bridge_propagate_bus_fmt,
+	.debugfs_init = panel_bridge_debugfs_init,
+};
+
+/**
+ * drm_bridge_is_panel - Checks if a drm_bridge is a panel_bridge.
+ *
+ * @bridge: The drm_bridge to be checked.
+ *
+ * Returns true if the bridge is a panel bridge, or false otherwise.
+ */
+bool drm_bridge_is_panel(const struct drm_bridge *bridge)
+{
+	return bridge->funcs == &panel_bridge_bridge_funcs;
+}
+EXPORT_SYMBOL(drm_bridge_is_panel);
+
+/**
+ * drm_panel_bridge_add - Creates a &drm_bridge and &drm_connector that
+ * just calls the appropriate functions from &drm_panel.
+ *
+ * @panel: The drm_panel being wrapped.  Must be non-NULL.
+ *
+ * For drivers converting from directly using drm_panel: The expected
+ * usage pattern is that during either encoder module probe or DSI
+ * host attach, a drm_panel will be looked up through
+ * drm_of_find_panel_or_bridge().  drm_panel_bridge_add() is used to
+ * wrap that panel in the new bridge, and the result can then be
+ * passed to drm_bridge_attach().  The drm_panel_prepare() and related
+ * functions can be dropped from the encoder driver (they're now
+ * called by the KMS helpers before calling into the encoder), along
+ * with connector creation.  When done with the bridge (after
+ * drm_mode_config_cleanup() if the bridge has already been attached), then
+ * drm_panel_bridge_remove() to free it.
+ *
+ * The connector type is set to @panel->connector_type, which must be set to a
+ * known type. Calling this function with a panel whose connector type is
+ * DRM_MODE_CONNECTOR_Unknown will return ERR_PTR(-EINVAL).
+ *
+ * See devm_drm_panel_bridge_add() for an automatically managed version of this
+ * function.
+ */
+struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel)
+{
+	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
+		return ERR_PTR(-EINVAL);
+
+	return drm_panel_bridge_add_typed(panel, panel->connector_type);
+}
+EXPORT_SYMBOL(drm_panel_bridge_add);
+
+/**
+ * drm_panel_bridge_add_typed - Creates a &drm_bridge and &drm_connector with
+ * an explicit connector type.
+ * @panel: The drm_panel being wrapped.  Must be non-NULL.
+ * @connector_type: The connector type (DRM_MODE_CONNECTOR_*)
+ *
+ * This is just like drm_panel_bridge_add(), but forces the connector type to
+ * @connector_type instead of infering it from the panel.
+ *
+ * This function is deprecated and should not be used in new drivers. Use
+ * drm_panel_bridge_add() instead, and fix panel drivers as necessary if they
+ * don't report a connector type.
+ */
+struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
+					      u32 connector_type)
+{
+	struct panel_bridge *panel_bridge;
+
+	if (!panel)
+		return ERR_PTR(-EINVAL);
+
+	panel_bridge = devm_drm_bridge_alloc(panel->dev, struct panel_bridge, bridge,
+					     &panel_bridge_bridge_funcs);
+	if (IS_ERR(panel_bridge))
+		return (void *)panel_bridge;
+
+	panel_bridge->connector_type = connector_type;
+	panel_bridge->panel = drm_panel_get(panel);
+
+	panel_bridge->bridge.of_node = panel->dev->of_node;
+	panel_bridge->bridge.ops = DRM_BRIDGE_OP_MODES;
+	panel_bridge->bridge.type = connector_type;
+	panel_bridge->bridge.pre_enable_prev_first = panel->prepare_prev_first;
+
+	drm_bridge_add(&panel_bridge->bridge);
+
+	return &panel_bridge->bridge;
+}
+EXPORT_SYMBOL(drm_panel_bridge_add_typed);
+
+/**
+ * drm_panel_bridge_remove - Unregisters and frees a drm_bridge
+ * created by drm_panel_bridge_add().
+ *
+ * @bridge: The drm_bridge being freed.
+ */
+void drm_panel_bridge_remove(struct drm_bridge *bridge)
+{
+	struct panel_bridge *panel_bridge;
+	struct drm_panel *panel;
+
+	if (!bridge)
+		return;
+
+	if (!drm_bridge_is_panel(bridge)) {
+		drm_warn(bridge->dev, "%s: called on non-panel bridge!\n", __func__);
+		return;
+	}
+
+	panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	panel = panel_bridge->panel;
+
+	drm_bridge_remove(bridge);
+	/* TODO remove this after reworking panel_bridge lifetime */
+	devm_drm_put_bridge(panel->dev, bridge);
+	drm_panel_put(panel);
+}
+EXPORT_SYMBOL(drm_panel_bridge_remove);
+
+/**
+ * drm_panel_bridge_set_orientation - Set the connector's panel orientation
+ * from the bridge that can be transformed to panel bridge.
+ *
+ * @connector: The connector to be set panel orientation.
+ * @bridge: The drm_bridge to be transformed to panel bridge.
+ *
+ * Returns 0 on success, negative errno on failure.
+ */
+int drm_panel_bridge_set_orientation(struct drm_connector *connector,
+				     struct drm_bridge *bridge)
+{
+	struct panel_bridge *panel_bridge;
+
+	panel_bridge = drm_bridge_to_panel_bridge(bridge);
+
+	return drm_connector_set_orientation_from_panel(connector,
+							panel_bridge->panel);
+}
+EXPORT_SYMBOL(drm_panel_bridge_set_orientation);
+
+static void devm_drm_panel_bridge_release(struct device *dev, void *res)
+{
+	struct drm_bridge *bridge = *(struct drm_bridge **)res;
+	struct panel_bridge *panel_bridge;
+	struct drm_panel *panel;
+
+	if (!bridge)
+		return;
+
+	panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	panel = panel_bridge->panel;
+	drm_bridge_remove(bridge);
+	drm_panel_put(panel);
+}
+
+/**
+ * devm_drm_panel_bridge_add - Creates a managed &drm_bridge and &drm_connector
+ * that just calls the appropriate functions from &drm_panel.
+ * @dev: device to tie the bridge lifetime to
+ * @panel: The drm_panel being wrapped.  Must be non-NULL.
+ *
+ * This is the managed version of drm_panel_bridge_add() which automatically
+ * calls drm_panel_bridge_remove() when @dev is unbound.
+ */
+struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
+					     struct drm_panel *panel)
+{
+	if (WARN_ON(panel->connector_type == DRM_MODE_CONNECTOR_Unknown))
+		return ERR_PTR(-EINVAL);
+
+	return devm_drm_panel_bridge_add_typed(dev, panel,
+					       panel->connector_type);
+}
+EXPORT_SYMBOL(devm_drm_panel_bridge_add);
+
+/**
+ * devm_drm_panel_bridge_add_typed - Creates a managed &drm_bridge and
+ * &drm_connector with an explicit connector type.
+ * @dev: device to tie the bridge lifetime to
+ * @panel: The drm_panel being wrapped.  Must be non-NULL.
+ * @connector_type: The connector type (DRM_MODE_CONNECTOR_*)
+ *
+ * This is just like devm_drm_panel_bridge_add(), but forces the connector type
+ * to @connector_type instead of infering it from the panel.
+ *
+ * This function is deprecated and should not be used in new drivers. Use
+ * devm_drm_panel_bridge_add() instead, and fix panel drivers as necessary if
+ * they don't report a connector type.
+ */
+struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
+						   struct drm_panel *panel,
+						   u32 connector_type)
+{
+	struct drm_bridge **ptr, *bridge;
+
+	ptr = devres_alloc(devm_drm_panel_bridge_release, sizeof(*ptr),
+			   GFP_KERNEL);
+	if (!ptr)
+		return ERR_PTR(-ENOMEM);
+
+	bridge = drm_panel_bridge_add_typed(panel, connector_type);
+	if (IS_ERR(bridge)) {
+		devres_free(ptr);
+		return bridge;
+	}
+
+	*ptr = bridge;
+	devres_add(dev, ptr);
+
+	return bridge;
+}
+EXPORT_SYMBOL(devm_drm_panel_bridge_add_typed);
+
+static void drmm_drm_panel_bridge_release(struct drm_device *drm, void *ptr)
+{
+	struct drm_bridge *bridge = ptr;
+
+	drm_panel_bridge_remove(bridge);
+}
+
+/**
+ * drmm_panel_bridge_add - Creates a DRM-managed &drm_bridge and
+ *                         &drm_connector that just calls the
+ *                         appropriate functions from &drm_panel.
+ *
+ * @drm: DRM device to tie the bridge lifetime to
+ * @panel: The drm_panel being wrapped.  Must be non-NULL.
+ *
+ * This is the DRM-managed version of drm_panel_bridge_add() which
+ * automatically calls drm_panel_bridge_remove() when @dev is cleaned
+ * up.
+ */
+struct drm_bridge *drmm_panel_bridge_add(struct drm_device *drm,
+					 struct drm_panel *panel)
+{
+	struct drm_bridge *bridge;
+	int ret;
+
+	bridge = drm_panel_bridge_add_typed(panel, panel->connector_type);
+	if (IS_ERR(bridge))
+		return bridge;
+
+	ret = drmm_add_action_or_reset(drm, drmm_drm_panel_bridge_release,
+				       bridge);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return bridge;
+}
+EXPORT_SYMBOL(drmm_panel_bridge_add);
+
+/**
+ * drm_panel_bridge_connector - return the connector for the panel bridge
+ * @bridge: The drm_bridge.
+ *
+ * drm_panel_bridge creates the connector.
+ * This function gives external access to the connector.
+ *
+ * Returns: Pointer to drm_connector
+ */
+struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge)
+{
+	struct panel_bridge *panel_bridge;
+
+	panel_bridge = drm_bridge_to_panel_bridge(bridge);
+
+	return &panel_bridge->connector;
+}
+EXPORT_SYMBOL(drm_panel_bridge_connector);
+
+#ifdef CONFIG_OF
+/**
+ * devm_drm_of_get_bridge - Return next bridge in the chain
+ * @dev: device to tie the bridge lifetime to
+ * @np: device tree node containing encoder output ports
+ * @port: port in the device tree node
+ * @endpoint: endpoint in the device tree node
+ *
+ * Given a DT node's port and endpoint number, finds the connected node
+ * and returns the associated bridge if any, or creates and returns a
+ * drm panel bridge instance if a panel is connected.
+ *
+ * Returns a pointer to the bridge if successful, or an error pointer
+ * otherwise.
+ */
+struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
+					  struct device_node *np,
+					  u32 port, u32 endpoint)
+{
+	struct drm_bridge *bridge;
+	struct drm_panel *panel;
+	int ret;
+
+	ret = drm_of_find_panel_or_bridge(np, port, endpoint,
+					  &panel, &bridge);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (panel) {
+		bridge = devm_drm_panel_bridge_add(dev, panel);
+		drm_panel_put(panel);
+	}
+
+	return bridge;
+}
+EXPORT_SYMBOL(devm_drm_of_get_bridge);
+
+/**
+ * drmm_of_get_bridge - Return next bridge in the chain
+ * @drm: device to tie the bridge lifetime to
+ * @np: device tree node containing encoder output ports
+ * @port: port in the device tree node
+ * @endpoint: endpoint in the device tree node
+ *
+ * Given a DT node's port and endpoint number, finds the connected node
+ * and returns the associated bridge if any, or creates and returns a
+ * drm panel bridge instance if a panel is connected.
+ *
+ * Returns a drmm managed pointer to the bridge if successful, or an error
+ * pointer otherwise.
+ */
+struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
+				      struct device_node *np,
+				      u32 port, u32 endpoint)
+{
+	struct drm_bridge *bridge;
+	struct drm_panel *panel;
+	int ret;
+
+	ret = drm_of_find_panel_or_bridge(np, port, endpoint,
+					  &panel, &bridge);
+	if (ret)
+		return ERR_PTR(ret);
+
+	if (panel) {
+		bridge = drmm_panel_bridge_add(drm, panel);
+		drm_panel_put(panel);
+	}
+
+	return bridge;
+}
+EXPORT_SYMBOL(drmm_of_get_bridge);
+
+#endif
+
 /**
  * drm_panel_init - initialize a panel
  * @panel: DRM panel
diff --git a/drivers/gpu/drm/imx/dc/dc-kms.c b/drivers/gpu/drm/imx/dc/dc-kms.c
index a9adcfc68b84..0e2ce6a42548 100644
--- a/drivers/gpu/drm/imx/dc/dc-kms.c
+++ b/drivers/gpu/drm/imx/dc/dc-kms.c
@@ -15,6 +15,7 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_mode_config.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/mcde_display.c
index d1d01f3d8ab4..b2455391bdd7 100644
--- a/drivers/gpu/drm/mcde/mcde_display.c
+++ b/drivers/gpu/drm/mcde/mcde_display.c
@@ -18,6 +18,7 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_vblank.h>
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bc646d172abe..525c188ac951 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -15,6 +15,7 @@
 #include <drm/display/drm_dp_aux_bus.h>
 #include <drm/display/drm_hdmi_audio_helper.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_panel.h>
 
 #include "msm_drv.h"
 #include "msm_kms.h"
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 3c9f01ed6271..c726fc628a08 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -5,6 +5,8 @@
 
 #include "dsi.h"
 
+#include <drm/drm_panel.h>
+
 bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi)
 {
 	unsigned long host_flags = msm_dsi_host_get_mode_flags(msm_dsi->host);
@@ -267,4 +269,3 @@ void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi
 	msm_dsi_host_snapshot(disp_state, msm_dsi->host);
 	msm_dsi_phy_snapshot(disp_state, msm_dsi->phy);
 }
-
diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index bc1c93c7554c..b6d09a8d8e5e 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -10,6 +10,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_encoder.h>
+#include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 
 #include "drm.h"
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 58fff047f43b..11c203391de5 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1473,58 +1473,6 @@ void drm_bridge_hpd_disable(struct drm_bridge *bridge);
 void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 			   enum drm_connector_status status);
 
-#ifdef CONFIG_DRM_PANEL_BRIDGE
-bool drm_bridge_is_panel(const struct drm_bridge *bridge);
-struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
-struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
-					      u32 connector_type);
-void drm_panel_bridge_remove(struct drm_bridge *bridge);
-int drm_panel_bridge_set_orientation(struct drm_connector *connector,
-				     struct drm_bridge *bridge);
-struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
-					     struct drm_panel *panel);
-struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
-						   struct drm_panel *panel,
-						   u32 connector_type);
-struct drm_bridge *drmm_panel_bridge_add(struct drm_device *drm,
-					     struct drm_panel *panel);
-struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge);
-#else
-static inline bool drm_bridge_is_panel(const struct drm_bridge *bridge)
-{
-	return false;
-}
-
-static inline int drm_panel_bridge_set_orientation(struct drm_connector *connector,
-						   struct drm_bridge *bridge)
-{
-	return -EINVAL;
-}
-#endif
-
-#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
-struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct device_node *node,
-					  u32 port, u32 endpoint);
-struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm, struct device_node *node,
-					  u32 port, u32 endpoint);
-#else
-static inline struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
-							struct device_node *node,
-							u32 port,
-							u32 endpoint)
-{
-	return ERR_PTR(-ENODEV);
-}
-
-static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
-						     struct device_node *node,
-						     u32 port,
-						     u32 endpoint)
-{
-	return ERR_PTR(-ENODEV);
-}
-#endif
-
 void devm_drm_put_bridge(struct device *dev, struct drm_bridge *bridge);
 
 void drm_bridge_debugfs_params(struct dentry *root);
diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
index f6dad2c6e9b9..002ba1b18eb1 100644
--- a/include/drm/drm_of.h
+++ b/include/drm/drm_of.h
@@ -7,6 +7,7 @@
 #if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DRM_PANEL_BRIDGE)
 #include <linux/of.h>
 #include <drm/drm_bridge.h>
+#include <drm/drm_panel.h>
 #endif
 
 struct component_master_ops;
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 34fcbcdda2c8..bede046fb281 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -35,6 +35,7 @@ struct dentry;
 struct device_node;
 struct drm_bridge;
 struct drm_connector;
+struct drm_device;
 struct drm_panel_follower;
 struct drm_panel;
 struct display_timing;
@@ -394,4 +395,56 @@ static inline int drm_panel_of_backlight(struct drm_panel *panel)
 }
 #endif
 
+#ifdef CONFIG_DRM_PANEL_BRIDGE
+bool drm_bridge_is_panel(const struct drm_bridge *bridge);
+struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel);
+struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
+					      u32 connector_type);
+void drm_panel_bridge_remove(struct drm_bridge *bridge);
+int drm_panel_bridge_set_orientation(struct drm_connector *connector,
+				     struct drm_bridge *bridge);
+struct drm_bridge *devm_drm_panel_bridge_add(struct device *dev,
+					     struct drm_panel *panel);
+struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
+						   struct drm_panel *panel,
+						   u32 connector_type);
+struct drm_bridge *drmm_panel_bridge_add(struct drm_device *drm,
+					 struct drm_panel *panel);
+struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge);
+#else
+static inline bool drm_bridge_is_panel(const struct drm_bridge *bridge)
+{
+	return false;
+}
+
+static inline int drm_panel_bridge_set_orientation(struct drm_connector *connector,
+						   struct drm_bridge *bridge)
+{
+	return -EINVAL;
+}
+#endif
+
+#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
+struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct device_node *node,
+					  u32 port, u32 endpoint);
+struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm, struct device_node *node,
+				      u32 port, u32 endpoint);
+#else
+static inline struct drm_bridge *devm_drm_of_get_bridge(struct device *dev,
+							struct device_node *node,
+							u32 port,
+							u32 endpoint)
+{
+	return ERR_PTR(-ENODEV);
+}
+
+static inline struct drm_bridge *drmm_of_get_bridge(struct drm_device *drm,
+						    struct device_node *node,
+						    u32 port,
+						    u32 endpoint)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
 #endif

-- 
2.55.0

