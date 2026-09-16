Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C898C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2D1610E382;
	Wed, 16 Sep 2026 13:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="giAtyJTt";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA45610E3D2
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 13:46:22 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 158C2C5CD58;
 Wed, 16 Sep 2026 13:47:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 19BBC60337;
 Wed, 16 Sep 2026 13:46:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4E70211C7B03B; 
 Wed, 16 Sep 2026 15:46:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789566378; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=3xBHxsCRyr84YHaw6tjcPJ9RXMm/arg2boGclpQZ+A8=;
 b=giAtyJTtFIK7EFES8JZ/BOpGE0jJJieKTSyX0voJBQU4joDirMvwI5KX32whlMgZmg6boD
 7sRtgR7AfRjqpvczrX3zXRDcnWvy7BuHGa4JeEESzvJszY0sMtLwLLozM4qNuwDlj6PMNX
 IrST0cpfj0CK+6UPSDlDUnmY6xjY+/NxqKj9z+9y0ZSjv0+nTl8LkybOvLT5KLqCr68G6n
 GzKlga2Nf35b9/gCPF5q71tIQM+Ty6HaGJajVm0dqq4GGNbdo+2XGzv/q5U3HamlGjnKCQ
 H9nwCRS1fJ+vYKEDW8RG2nJFK27jssrTZVZoaoBKhs1nMV8u7t9BLpQ9mFJ4EQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Wed, 16 Sep 2026 15:45:29 +0200
Subject: [PATCH v3 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-drm-bridge-every-panel-v3-5-83afb4f1a707@bootlin.com>
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

Adding a drm_panel does currently not add a panel_bridge wrapping
it. Usually the panel_bridge creation happens later, when some other driver
(e.g. the previous bridge or the encoder) calls *_of_get_bridge() and the
following element in the pipeline is a panel.

This has some drawbacks:

 * the bridge API is currently the best practice to access various
   components of the pipeline, especially with complex cards where bridges
   can be combined in different ways on different hardware
 * the panel_bridge is not created in the context of the driver of the
   underlying physical device (the panel driver), but of some other driver
 * that other driver is not aware of whether the returned drm_bridge
   pointer is a panel_bridge created on the fly, a pre-existing
   panel_bridge or a non-panel bridge
 * removal of a panel_bridge requires calling drm_panel_bridge_remove(),
   but that other driver doesn't know whether this is needed because it
   doesn't know whether it has created a panel_bridge or not

Other drivers call [a variant of] drm_panel_bridge_add(), which also has
some of the above drawbacks.

So far the current approach was working mostly because devm and drmm ensure
the panel bridge would be dealloacted at some later point. However with the
upcoming implementation of bridge hotplug and dynamic bridge lifetime this
won't happen as needed.

Switch to the new approach: embed a drm_bridge inside every drm_panel,
which behaves just like the current drm_panel_bridge. Do this by adapting
the panel_bridge code, doing the minimal adaptations needed.

Currently drm_bridge and drm_panel have independent refcounted
allocation. As they now become a single struct, just change
drm_panel_get/put() to get/put the bridge. As a result, the refcount for a
drm_bridge embedded in a drm_panel is:

  bridge.refcount == number of drm_bridge_get() calls
                   + number of drm_panel_get() calls
                   - number of drm_bridge_put() calls
                   - number of drm_panel_put() calls

Now drivers should progressively stop using the panel_bridge API. Until
that happens, that API becomes now a wrapper to the new embedded
drm_bridge:

 * drm_panel_bridge_add() and derivatives don't create a bridge, they
   just drm_bridge_get() and return a pointer to the existing one
 * drm_panel_bridge_remove() and devm_drm_panel_bridge_release() don't
   remove the bridge, they just drm-bridge_put() it
 * The other panel_bridge functions stack on those listed in the previous 2
   bullets, so their behaviour is changed correspondingly; they include:
   - all drm_panel_bridge_add() variants
   - their removal counterparts
   - *_of_get_bridge().

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
- previous patches don't duplicate but rather move the panel_bridge code
  to drm_bridge.c, so adapt to that: as there are no more 2 versions of
  that code we need to handle right now the fact that existing users of
  panel_bridge need to be transparently use the embedded bridge
- add missing panel->bridge initializations to drm_panel_add()

This patch is new in v2, and replaces "drm/bridge: panel: add a
panel_bridge to every panel" which was based on a different approach.
---
 drivers/gpu/drm/drm_panel.c | 184 +++++++++++++++++++-------------------------
 include/drm/drm_panel.h     |  29 ++++---
 2 files changed, 96 insertions(+), 117 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 30e7dc81dd15..707ad9aa907a 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -38,6 +38,18 @@ static LIST_HEAD(panel_list);
  * take look at drm_panel_bridge_add() and devm_drm_panel_bridge_add().
  */
 
+static inline struct drm_panel *
+drm_bridge_to_panel(const struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct drm_panel, bridge);
+}
+
+static inline struct drm_panel *
+drm_connector_to_panel(const struct drm_connector *connector)
+{
+	return container_of(connector, struct drm_panel, connector);
+}
+
 struct panel_bridge {
 	struct drm_bridge bridge;
 	struct drm_connector connector;
@@ -45,24 +57,11 @@ struct panel_bridge {
 	u32 connector_type;
 };
 
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
 static int panel_bridge_connector_get_modes(struct drm_connector *connector)
 {
-	struct panel_bridge *panel_bridge =
-		drm_connector_to_panel_bridge(connector);
+	struct drm_panel *panel = drm_connector_to_panel(connector);
 
-	return drm_panel_get_modes(panel_bridge->panel, connector);
+	return drm_panel_get_modes(panel, connector);
 }
 
 static const struct drm_connector_helper_funcs
@@ -82,8 +81,8 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 			       struct drm_encoder *encoder,
 			       enum drm_bridge_attach_flags flags)
 {
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	struct drm_connector *connector = &panel_bridge->connector;
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
+	struct drm_connector *connector = &panel->connector;
 	int ret;
 
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
@@ -94,7 +93,7 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 
 	ret = drm_connector_init(bridge->dev, connector,
 				 &panel_bridge_connector_funcs,
-				 panel_bridge->connector_type);
+				 panel->connector_type);
 	if (ret) {
 		DRM_ERROR("Failed to initialize connector\n");
 		return ret;
@@ -102,8 +101,7 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 
 	drm_panel_bridge_set_orientation(connector, bridge);
 
-	drm_connector_attach_encoder(&panel_bridge->connector,
-				     encoder);
+	drm_connector_attach_encoder(connector, encoder);
 
 	if (bridge->dev->registered) {
 		if (connector->funcs->reset)
@@ -116,16 +114,10 @@ static int panel_bridge_attach(struct drm_bridge *bridge,
 
 static void panel_bridge_detach(struct drm_bridge *bridge)
 {
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	struct drm_connector *connector = &panel_bridge->connector;
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
+	struct drm_connector *connector = &panel->connector;
 
-	/*
-	 * Cleanup the connector if we know it was initialized.
-	 *
-	 * FIXME: This wouldn't be needed if the panel_bridge structure was
-	 * allocated with drmm_kzalloc(). This might be tricky since the
-	 * drm_device pointer can only be retrieved when the bridge is attached.
-	 */
+	/* Cleanup the connector if we know it was initialized */
 	if (connector->dev)
 		drm_connector_cleanup(connector);
 }
@@ -133,7 +125,7 @@ static void panel_bridge_detach(struct drm_bridge *bridge)
 static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 					   struct drm_atomic_commit *atomic_state)
 {
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
 	struct drm_encoder *encoder = bridge->encoder;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
@@ -146,13 +138,13 @@ static void panel_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	if (old_crtc_state && old_crtc_state->self_refresh_active)
 		return;
 
-	drm_panel_prepare(panel_bridge->panel);
+	drm_panel_prepare(panel);
 }
 
 static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
 				       struct drm_atomic_commit *atomic_state)
 {
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
 	struct drm_encoder *encoder = bridge->encoder;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *old_crtc_state;
@@ -165,13 +157,13 @@ static void panel_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (old_crtc_state && old_crtc_state->self_refresh_active)
 		return;
 
-	drm_panel_enable(panel_bridge->panel);
+	drm_panel_enable(panel);
 }
 
 static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
 					struct drm_atomic_commit *atomic_state)
 {
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
 	struct drm_encoder *encoder = bridge->encoder;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *new_crtc_state;
@@ -184,13 +176,13 @@ static void panel_bridge_atomic_disable(struct drm_bridge *bridge,
 	if (new_crtc_state && new_crtc_state->self_refresh_active)
 		return;
 
-	drm_panel_disable(panel_bridge->panel);
+	drm_panel_disable(panel);
 }
 
 static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
 					     struct drm_atomic_commit *atomic_state)
 {
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
 	struct drm_encoder *encoder = bridge->encoder;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *new_crtc_state;
@@ -203,22 +195,21 @@ static void panel_bridge_atomic_post_disable(struct drm_bridge *bridge,
 	if (new_crtc_state && new_crtc_state->self_refresh_active)
 		return;
 
-	drm_panel_unprepare(panel_bridge->panel);
+	drm_panel_unprepare(panel);
 }
 
 static int panel_bridge_get_modes(struct drm_bridge *bridge,
 				  struct drm_connector *connector)
 {
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
 
-	return drm_panel_get_modes(panel_bridge->panel, connector);
+	return drm_panel_get_modes(panel, connector);
 }
 
 static void panel_bridge_debugfs_init(struct drm_bridge *bridge,
 				      struct dentry *root)
 {
-	struct panel_bridge *panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	struct drm_panel *panel = panel_bridge->panel;
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
 
 	root = debugfs_create_dir("panel", root);
 	if (panel->funcs->debugfs_init)
@@ -288,7 +279,7 @@ struct drm_bridge *drm_panel_bridge_add(struct drm_panel *panel)
 EXPORT_SYMBOL(drm_panel_bridge_add);
 
 /**
- * drm_panel_bridge_add_typed - Creates a &drm_bridge and &drm_connector with
+ * drm_panel_bridge_add_typed - Pretend to create a &drm_bridge and &drm_connector with
  * an explicit connector type.
  * @panel: The drm_panel being wrapped.  Must be non-NULL.
  * @connector_type: The connector type (DRM_MODE_CONNECTOR_*)
@@ -303,27 +294,10 @@ EXPORT_SYMBOL(drm_panel_bridge_add);
 struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
 					      u32 connector_type)
 {
-	struct panel_bridge *panel_bridge;
-
 	if (!panel)
 		return ERR_PTR(-EINVAL);
 
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
+	return drm_bridge_get(&panel->bridge);
 }
 EXPORT_SYMBOL(drm_panel_bridge_add_typed);
 
@@ -335,9 +309,6 @@ EXPORT_SYMBOL(drm_panel_bridge_add_typed);
  */
 void drm_panel_bridge_remove(struct drm_bridge *bridge)
 {
-	struct panel_bridge *panel_bridge;
-	struct drm_panel *panel;
-
 	if (!bridge)
 		return;
 
@@ -346,13 +317,7 @@ void drm_panel_bridge_remove(struct drm_bridge *bridge)
 		return;
 	}
 
-	panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	panel = panel_bridge->panel;
-
-	drm_bridge_remove(bridge);
-	/* TODO remove this after reworking panel_bridge lifetime */
-	devm_drm_put_bridge(panel->dev, bridge);
-	drm_panel_put(panel);
+	drm_bridge_put(bridge);
 }
 EXPORT_SYMBOL(drm_panel_bridge_remove);
 
@@ -361,35 +326,27 @@ EXPORT_SYMBOL(drm_panel_bridge_remove);
  * from the bridge that can be transformed to panel bridge.
  *
  * @connector: The connector to be set panel orientation.
- * @bridge: The drm_bridge to be transformed to panel bridge.
+ * @bridge: The drm_bridge whose orientation should be set.
  *
  * Returns 0 on success, negative errno on failure.
  */
 int drm_panel_bridge_set_orientation(struct drm_connector *connector,
 				     struct drm_bridge *bridge)
 {
-	struct panel_bridge *panel_bridge;
+	struct drm_panel *panel = drm_bridge_to_panel(bridge);
 
-	panel_bridge = drm_bridge_to_panel_bridge(bridge);
-
-	return drm_connector_set_orientation_from_panel(connector,
-							panel_bridge->panel);
+	return drm_connector_set_orientation_from_panel(connector, panel);
 }
 EXPORT_SYMBOL(drm_panel_bridge_set_orientation);
 
 static void devm_drm_panel_bridge_release(struct device *dev, void *res)
 {
 	struct drm_bridge *bridge = *(struct drm_bridge **)res;
-	struct panel_bridge *panel_bridge;
-	struct drm_panel *panel;
 
 	if (!bridge)
 		return;
 
-	panel_bridge = drm_bridge_to_panel_bridge(bridge);
-	panel = panel_bridge->panel;
-	drm_bridge_remove(bridge);
-	drm_panel_put(panel);
+	drm_bridge_put(bridge);
 }
 
 /**
@@ -446,7 +403,7 @@ struct drm_bridge *devm_drm_panel_bridge_add_typed(struct device *dev,
 	*ptr = bridge;
 	devres_add(dev, ptr);
 
-	return bridge;
+	return &panel->bridge;
 }
 EXPORT_SYMBOL(devm_drm_panel_bridge_add_typed);
 
@@ -489,21 +446,21 @@ struct drm_bridge *drmm_panel_bridge_add(struct drm_device *drm,
 EXPORT_SYMBOL(drmm_panel_bridge_add);
 
 /**
- * drm_panel_bridge_connector - return the connector for the panel bridge
+ * drm_panel_bridge_connector - return the connector for the panel (for
+ * legacy drivers not using DRM_BRIDGE_ATTACH_NO_CONNECTOR)
  * @bridge: The drm_bridge.
  *
- * drm_panel_bridge creates the connector.
  * This function gives external access to the connector.
  *
  * Returns: Pointer to drm_connector
  */
 struct drm_connector *drm_panel_bridge_connector(struct drm_bridge *bridge)
 {
-	struct panel_bridge *panel_bridge;
+	struct drm_panel *panel;
 
-	panel_bridge = drm_bridge_to_panel_bridge(bridge);
+	panel = drm_bridge_to_panel(bridge);
 
-	return &panel_bridge->connector;
+	return &panel->connector;
 }
 EXPORT_SYMBOL(drm_panel_bridge_connector);
 
@@ -622,6 +579,13 @@ void drm_panel_add(struct drm_panel *panel)
 	mutex_lock(&panel_lock);
 	list_add_tail(&panel->list, &panel_list);
 	mutex_unlock(&panel_lock);
+
+	panel->bridge.of_node = panel->dev->of_node;
+	panel->bridge.ops = DRM_BRIDGE_OP_MODES;
+	panel->bridge.type = panel->connector_type;
+	panel->bridge.pre_enable_prev_first = panel->prepare_prev_first;
+
+	drm_bridge_add(&panel->bridge);
 }
 EXPORT_SYMBOL(drm_panel_add);
 
@@ -633,6 +597,7 @@ EXPORT_SYMBOL(drm_panel_add);
  */
 void drm_panel_remove(struct drm_panel *panel)
 {
+	drm_bridge_remove(&panel->bridge);
 	mutex_lock(&panel_lock);
 	list_del_init(&panel->list);
 	mutex_unlock(&panel_lock);
@@ -906,13 +871,6 @@ int drm_panel_get_modes(struct drm_panel *panel,
 }
 EXPORT_SYMBOL(drm_panel_get_modes);
 
-static void __drm_panel_free(struct kref *kref)
-{
-	struct drm_panel *panel = container_of(kref, struct drm_panel, refcount);
-
-	kfree(panel->container);
-}
-
 /**
  * drm_panel_get - Acquire a panel reference
  * @panel: DRM panel
@@ -923,10 +881,8 @@ static void __drm_panel_free(struct kref *kref)
  */
 struct drm_panel *drm_panel_get(struct drm_panel *panel)
 {
-	if (!panel)
-		return panel;
-
-	kref_get(&panel->refcount);
+	if (panel)
+		drm_bridge_get(&panel->bridge);
 
 	return panel;
 }
@@ -942,7 +898,7 @@ EXPORT_SYMBOL(drm_panel_get);
 void drm_panel_put(struct drm_panel *panel)
 {
 	if (panel)
-		kref_put(&panel->refcount, __drm_panel_free);
+		drm_bridge_put(&panel->bridge);
 }
 EXPORT_SYMBOL(drm_panel_put);
 
@@ -965,8 +921,22 @@ void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
 			     const struct drm_panel_funcs *funcs,
 			     int connector_type)
 {
-	void *container;
+	/*
+	 * Struct embedding and offsets:
+	 *
+	 *    |--------------- user container struct ------------|
+	 *    :    |---------- struct drm_panel ------------|
+	 *    :    :    |----- struct drm_bridge ------|
+	 *    A    B    C
+	 *
+	 * B - A = offset (passed as argument)
+	 * C - B = panel_bridge_offset
+	 * C - A = alloc_bridge_offset
+	 */
+	const size_t panel_bridge_offset = offsetof(struct drm_panel, bridge);
+	const size_t alloc_bridge_offset = offset + panel_bridge_offset;
 	struct drm_panel *panel;
+	void *container;
 	int err;
 
 	if (!funcs) {
@@ -974,14 +944,16 @@ void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,
 		return ERR_PTR(-EINVAL);
 	}
 
-	container = kzalloc(size, GFP_KERNEL);
-	if (!container)
-		return ERR_PTR(-ENOMEM);
+	container = __devm_drm_bridge_alloc(dev, size, alloc_bridge_offset,
+					    &panel_bridge_bridge_funcs);
+	if (IS_ERR(container))
+		return container;
 
 	panel = container + offset;
-	panel->container = container;
 	panel->funcs = funcs;
-	kref_init(&panel->refcount);
+	panel->bridge.of_node = dev->of_node;
+
+	drm_panel_get(panel);
 
 	err = devm_add_action_or_reset(dev, drm_panel_put_void, panel);
 	if (err)
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index bede046fb281..58113ea7d63a 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -30,6 +30,8 @@
 #include <linux/mutex.h>
 #include <linux/kref.h>
 
+#include <drm/drm_bridge.h>
+
 struct backlight_device;
 struct dentry;
 struct device_node;
@@ -230,6 +232,22 @@ struct drm_panel {
 	 */
 	const struct drm_panel_funcs *funcs;
 
+	/**
+	 * @bridge:
+	 *
+	 * Bridge to access the panel features through the drm_bridge API.
+	 */
+	struct drm_bridge bridge;
+
+	/**
+	 * @connector:
+	 *
+	 * Connector instantiated by the bridge (only for legacy code not
+	 * yet using the drm_bridge_connector and
+	 * DRM_BRIDGE_ATTACH_NO_CONNECTOR).
+	 */
+	struct drm_connector connector;
+
 	/**
 	 * @connector_type:
 	 *
@@ -283,17 +301,6 @@ struct drm_panel {
 	 * If true then the panel has been enabled.
 	 */
 	bool enabled;
-
-	/**
-	 * @container: Pointer to the private driver struct embedding this
-	 * @struct drm_panel.
-	 */
-	void *container;
-
-	/**
-	 * @refcount: reference count of users referencing this panel.
-	 */
-	struct kref refcount;
 };
 
 void *__devm_drm_panel_alloc(struct device *dev, size_t size, size_t offset,

-- 
2.55.0

