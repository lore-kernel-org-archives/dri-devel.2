Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589BFCC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:09:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 677E410E1BB;
	Thu, 15 Oct 2026 15:09:30 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D3A10E1BB
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 15:09:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C62C960120;
 Thu, 15 Oct 2026 15:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCE01F000C4;
 Thu, 15 Oct 2026 15:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792076962;
 bh=Y7YDRtwxhavrn1YGW2XF5pettRK/hGd8kmLj5IeFExM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=BxLfC1AI6VAkQhXxooWRDHZekmOgf1GDZSAqJmD3TfVHAPSg4eenlopj1ez8bV52N
 kf/H7vGbKglSsK+/zwyuwUehhButFG4qF5faq1986xX2XRZb9c0q29lSWDTT5SatVA
 sjc55qun2DoScP6v+hhUODv/3P1oAenXStxbsD+eZgBe3aAXgeHcBsx2VQRD2AIqF9
 ZMeCF9oTU2AdR0n6rU4MGLkmPf2/c24az4eRfm/DTNXC6SGwGdTza2tOwIHC0SVr52
 j8j1LOXT75Sikb9uMrJ3aLmA5CCXHMSnAwwpNAaRGIEifAHR3KBEJso6KPGCDmu/38
 XEREcSY3eSyTg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 15 Oct 2026 17:08:54 +0200
Subject: [PATCH v6 02/28] drm/atomic: Add drm_private_obj name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-drm-state-readout-v6-2-6cc02cd10998@kernel.org>
References: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
In-Reply-To: <20261015-drm-state-readout-v6-0-6cc02cd10998@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=17240; i=mripard@kernel.org;
 h=from:subject:message-id; bh=STkI5L1u9l8BJwR/zNxF6U0G+OImgXUi9LqfMB9+RAQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFkX3nT3L3/xj1H2XlbrMpcr2lJXxXap3ck4Zv2KUebVs
 ZA0Q7aNHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiXzgZG35w6FmEN7AnMz/S
 NgjsYZC0Md+RXM4tWvT6xi4m33v8dZzpm5J3OnncPBZnrct2+NISxoZPEp7TX29JnDFFOVPSP74
 hdErU7kfPGnoCnTR6DGfWXpvhsOL9wbSDS26pXGq9f9j+mx4A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

drm_private_obj does not carry a human-readable name, which makes
debug messages hard to interpret when multiple private objects are
registered on the same device.

Add a name field to drm_private_obj, passed through
drm_atomic_private_obj_init() and freed in
drm_atomic_private_obj_fini(). Update the existing callers to pass a
name.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       |  1 +
 drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c |  8 ++++++++
 drivers/gpu/drm/display/drm_dp_mst_topology.c           |  2 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c                 |  1 +
 drivers/gpu/drm/drm_atomic.c                            | 12 ++++++++++++
 drivers/gpu/drm/drm_bridge.c                            |  4 +++-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c               |  1 +
 drivers/gpu/drm/ingenic/ingenic-ipu.c                   |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                 |  1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c                |  1 +
 drivers/gpu/drm/omapdrm/omap_drv.c                      |  1 +
 drivers/gpu/drm/tegra/hub.c                             |  1 +
 drivers/gpu/drm/vc4/vc4_kms.c                           |  3 +++
 include/drm/drm_atomic.h                                |  7 ++++++-
 include/drm/drm_bridge.h                                |  2 ++
 15 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5e106b65034d..32b582f31f0e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2311,10 +2311,11 @@ STATIC_IFN_KUNIT int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 	/* indicates support for immediate flip */
 	adev_to_drm(adev)->mode_config.async_page_flip = true;
 
 	drm_atomic_private_obj_init(adev_to_drm(adev),
 				    &adev->dm.atomic_obj,
+				    "amdgpu_dc_state",
 				    &dm_atomic_state_funcs);
 
 	r = amdgpu_display_modeset_create_props(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
index 77b3f361091f..8a3c9fcf3844 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
@@ -64,10 +64,11 @@ static const struct drm_private_state_funcs komeda_layer_obj_funcs = {
 
 static int komeda_layer_obj_add(struct komeda_kms_dev *kms,
 				struct komeda_layer *layer)
 {
 	drm_atomic_private_obj_init(&kms->base, &layer->base.obj,
+				    "komeda_layer",
 				    &komeda_layer_obj_funcs);
 	return 0;
 }
 
 static struct drm_private_state *
@@ -117,10 +118,11 @@ static const struct drm_private_state_funcs komeda_scaler_obj_funcs = {
 static int komeda_scaler_obj_add(struct komeda_kms_dev *kms,
 				 struct komeda_scaler *scaler)
 {
 	drm_atomic_private_obj_init(&kms->base,
 				    &scaler->base.obj,
+				    "komeda_scaler",
 				    &komeda_scaler_obj_funcs);
 	return 0;
 }
 
 static struct drm_private_state *
@@ -169,10 +171,11 @@ static const struct drm_private_state_funcs komeda_compiz_obj_funcs = {
 
 static int komeda_compiz_obj_add(struct komeda_kms_dev *kms,
 				 struct komeda_compiz *compiz)
 {
 	drm_atomic_private_obj_init(&kms->base, &compiz->base.obj,
+				    "komeda_compiz",
 				    &komeda_compiz_obj_funcs);
 
 	return 0;
 }
 
@@ -223,10 +226,11 @@ static const struct drm_private_state_funcs komeda_splitter_obj_funcs = {
 static int komeda_splitter_obj_add(struct komeda_kms_dev *kms,
 				   struct komeda_splitter *splitter)
 {
 	drm_atomic_private_obj_init(&kms->base,
 				    &splitter->base.obj,
+				    "komeda_splitter",
 				    &komeda_splitter_obj_funcs);
 
 	return 0;
 }
 
@@ -276,10 +280,11 @@ static const struct drm_private_state_funcs komeda_merger_obj_funcs = {
 static int komeda_merger_obj_add(struct komeda_kms_dev *kms,
 				 struct komeda_merger *merger)
 {
 	drm_atomic_private_obj_init(&kms->base,
 				    &merger->base.obj,
+				    "komeda_merger",
 				    &komeda_merger_obj_funcs);
 
 	return 0;
 }
 
@@ -329,10 +334,11 @@ static const struct drm_private_state_funcs komeda_improc_obj_funcs = {
 
 static int komeda_improc_obj_add(struct komeda_kms_dev *kms,
 				 struct komeda_improc *improc)
 {
 	drm_atomic_private_obj_init(&kms->base, &improc->base.obj,
+				    "komeda_improc",
 				    &komeda_improc_obj_funcs);
 
 	return 0;
 }
 
@@ -382,10 +388,11 @@ static const struct drm_private_state_funcs komeda_timing_ctrlr_obj_funcs = {
 
 static int komeda_timing_ctrlr_obj_add(struct komeda_kms_dev *kms,
 				       struct komeda_timing_ctrlr *ctrlr)
 {
 	drm_atomic_private_obj_init(&kms->base, &ctrlr->base.obj,
+				    "komeda_timing_ctrlr",
 				    &komeda_timing_ctrlr_obj_funcs);
 
 	return 0;
 }
 
@@ -436,10 +443,11 @@ static const struct drm_private_state_funcs komeda_pipeline_obj_funcs = {
 
 static int komeda_pipeline_obj_add(struct komeda_kms_dev *kms,
 				   struct komeda_pipeline *pipe)
 {
 	drm_atomic_private_obj_init(&kms->base, &pipe->obj,
+				    "komeda_pipeline",
 				    &komeda_pipeline_obj_funcs);
 
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index b7fce0bf8acc..c7c3f6b0cf76 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -5772,11 +5772,11 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 	mgr->aux = aux;
 	mgr->max_dpcd_transaction_bytes = max_dpcd_transaction_bytes;
 	mgr->max_payloads = max_payloads;
 	mgr->conn_base_id = conn_base_id;
 
-	drm_atomic_private_obj_init(dev, &mgr->base,
+	drm_atomic_private_obj_init(dev, &mgr->base, "drm_dp_mst_topology",
 				    &drm_dp_mst_topology_state_funcs);
 
 	return 0;
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_init);
diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
index d29ad4116e64..391d643793eb 100644
--- a/drivers/gpu/drm/display/drm_dp_tunnel.c
+++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
@@ -1730,10 +1730,11 @@ static bool init_group(struct drm_dp_tunnel_mgr *mgr, struct drm_dp_tunnel_group
 	group->mgr = mgr;
 	group->available_bw = -1;
 	INIT_LIST_HEAD(&group->tunnels);
 
 	drm_atomic_private_obj_init(mgr->dev, &group->base,
+				    group->name,
 				    &tunnel_group_funcs);
 
 	return true;
 }
 
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 9973becb75ae..53703b23be8f 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1013,10 +1013,11 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
 
 /**
  * drm_atomic_private_obj_init - initialize private object
  * @dev: DRM device this object will be attached to
  * @obj: private object
+ * @name: human-readable name for debug messages
  * @funcs: pointer to the struct of function pointers that identify the object
  * type
  *
  * Initialize the private object, which can be embedded into any
  * driver private object that needs its own atomic state.
@@ -1024,10 +1025,11 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
  * RETURNS:
  * Zero on success, error code on failure
  */
 int drm_atomic_private_obj_init(struct drm_device *dev,
 				struct drm_private_obj *obj,
+				const char *name,
 				const struct drm_private_state_funcs *funcs)
 {
 	struct drm_private_state *state;
 	int ret;
 
@@ -1035,10 +1037,16 @@ int drm_atomic_private_obj_init(struct drm_device *dev,
 
 	drm_modeset_lock_init(&obj->lock);
 
 	obj->dev = dev;
 	obj->funcs = funcs;
+	obj->name = kstrdup(name, GFP_KERNEL);
+	if (!obj->name) {
+		ret = -ENOMEM;
+		goto err_lock_fini;
+	}
+
 	list_add_tail(&obj->head, &dev->mode_config.privobj_list);
 
 	state = obj->funcs->atomic_create_state(obj);
 	if (IS_ERR(state)) {
 		ret = PTR_ERR(state);
@@ -1049,10 +1057,13 @@ int drm_atomic_private_obj_init(struct drm_device *dev,
 
 	return 0;
 
 err_list_del:
 	list_del(&obj->head);
+	kfree(obj->name);
+	obj->name = NULL;
+err_lock_fini:
 	drm_modeset_lock_fini(&obj->lock);
 	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_private_obj_init);
 
@@ -1065,10 +1076,11 @@ EXPORT_SYMBOL(drm_atomic_private_obj_init);
 void
 drm_atomic_private_obj_fini(struct drm_private_obj *obj)
 {
 	list_del(&obj->head);
 	obj->funcs->atomic_destroy_state(obj, obj->state);
+	kfree(obj->name);
 	drm_modeset_lock_fini(&obj->lock);
 }
 EXPORT_SYMBOL(drm_atomic_private_obj_fini);
 
 /**
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index e7f9e6d58927..d474d6020411 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -315,10 +315,11 @@ static void __drm_bridge_free(struct kref *kref)
 	if (bridge->funcs->destroy)
 		bridge->funcs->destroy(bridge);
 
 	drm_bridge_put(bridge->next_bridge);
 
+	kfree(bridge->name);
 	kfree(bridge->container);
 }
 
 /**
  * drm_bridge_get - Acquire a bridge reference
@@ -419,10 +420,11 @@ void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
 
 	bridge = container + offset;
 	INIT_LIST_HEAD(&bridge->list);
 	bridge->container = container;
 	bridge->funcs = funcs;
+	bridge->name = kasprintf(GFP_KERNEL, "bridge-%s", dev_name(dev));
 	kref_init(&bridge->refcount);
 
 	err = devm_add_action_or_reset(dev, drm_bridge_put_void, bridge);
 	if (err)
 		return ERR_PTR(err);
@@ -647,11 +649,11 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		ret = bridge->funcs->attach(bridge, encoder, flags);
 		if (ret < 0)
 			goto err_reset_bridge;
 	}
 
-	drm_atomic_private_obj_init(bridge->dev, &bridge->base,
+	drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
 				    &drm_bridge_priv_state_funcs);
 
 	return 0;
 
 err_reset_bridge:
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index fff1ba598e96..1afac110bc28 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1402,10 +1402,11 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 		dev_err(dev, "Unable to register clock notifier\n");
 		goto err_devclk_disable;
 	}
 
 	drm_atomic_private_obj_init(drm, &priv->private_obj,
+				    "ingenic_drm",
 				    &ingenic_drm_private_state_funcs);
 
 	ret = drmm_add_action_or_reset(drm, ingenic_drm_atomic_private_obj_fini,
 				       &priv->private_obj);
 	if (ret)
diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
index bf24882e8d9f..795f6db5ce59 100644
--- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
+++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
@@ -900,10 +900,11 @@ static int ingenic_ipu_bind(struct device *dev, struct device *master, void *d)
 		dev_err(dev, "Unable to prepare clock\n");
 		return err;
 	}
 
 	drm_atomic_private_obj_init(drm, &ipu->private_obj,
+				    "ingenic_ipu_state",
 				    &ingenic_ipu_private_state_funcs);
 
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..fb3a0c847a9e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1153,10 +1153,11 @@ static int dpu_kms_hw_init(struct msm_kms *kms)
 
 	dev->mode_config.cursor_width = 512;
 	dev->mode_config.cursor_height = 512;
 
 	drm_atomic_private_obj_init(dpu_kms->dev, &dpu_kms->global_state,
+				    "dpu_kms_global_state",
 				    &dpu_kms_global_state_funcs);
 
 	atomic_set(&dpu_kms->bandwidth_ref, 0);
 
 	rc = pm_runtime_resume_and_get(&dpu_kms->pdev->dev);
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 3934cd060b27..b53f59f25fb0 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -710,10 +710,11 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 	int ret;
 
 	mdp5_kms->dev = dev;
 
 	drm_atomic_private_obj_init(mdp5_kms->dev, &mdp5_kms->glob_state,
+				    "mdp5_global_state",
 				    &mdp5_global_state_funcs);
 
 	/* we need to set a default rate before enabling.  Set a safe
 	 * rate first, then figure out hw revision, and then set a
 	 * more optimal rate:
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index db216c888a8f..3f66cd66443f 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -297,10 +297,11 @@ static const struct drm_private_state_funcs omap_global_state_funcs = {
 static int omap_global_obj_init(struct drm_device *dev)
 {
 	struct omap_drm_private *priv = dev->dev_private;
 
 	drm_atomic_private_obj_init(dev, &priv->glob_obj,
+				    "omap_global",
 				    &omap_global_state_funcs);
 	return 0;
 }
 
 static void omap_global_obj_fini(struct omap_drm_private *priv)
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index 448f49f3a7d7..854b671dfec8 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -958,10 +958,11 @@ static int tegra_display_hub_init(struct host1x_client *client)
 	struct tegra_display_hub *hub = to_tegra_display_hub(client);
 	struct drm_device *drm = dev_get_drvdata(client->host);
 	struct tegra_drm *tegra = drm->dev_private;
 
 	drm_atomic_private_obj_init(drm, &hub->base,
+				    "tegra_display_hub",
 				    &tegra_display_hub_state_funcs);
 
 	tegra->hub = hub;
 
 	return 0;
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index ab551eb2da50..e43d59cff4df 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -115,10 +115,11 @@ static void vc4_ctm_obj_fini(struct drm_device *dev, void *unused)
 static int vc4_ctm_obj_init(struct vc4_dev *vc4)
 {
 	drm_modeset_lock_init(&vc4->ctm_state_lock);
 
 	drm_atomic_private_obj_init(&vc4->base, &vc4->ctm_manager,
+				    "vc4_ctm",
 				    &vc4_ctm_state_funcs);
 
 	return drmm_add_action_or_reset(&vc4->base, vc4_ctm_obj_fini, NULL);
 }
 
@@ -755,10 +756,11 @@ static void vc4_load_tracker_obj_fini(struct drm_device *dev, void *unused)
 }
 
 static int vc4_load_tracker_obj_init(struct vc4_dev *vc4)
 {
 	drm_atomic_private_obj_init(&vc4->base, &vc4->load_tracker,
+				    "vc4_load_tracker",
 				    &vc4_load_tracker_state_funcs);
 
 	return drmm_add_action_or_reset(&vc4->base, vc4_load_tracker_obj_fini, NULL);
 }
 
@@ -846,10 +848,11 @@ static void vc4_hvs_channels_obj_fini(struct drm_device *dev, void *unused)
 }
 
 static int vc4_hvs_channels_obj_init(struct vc4_dev *vc4)
 {
 	drm_atomic_private_obj_init(&vc4->base, &vc4->hvs_channels,
+				    "vc4_hvs_channels",
 				    &vc4_hvs_state_funcs);
 
 	return drmm_add_action_or_reset(&vc4->base, vc4_hvs_channels_obj_fini, NULL);
 }
 
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 3ae35b09c0cf..87f85a77e5f3 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -373,10 +373,15 @@ struct drm_private_obj {
 	/**
 	 * @dev: parent DRM device
 	 */
 	struct drm_device *dev;
 
+	/**
+	 * @name: human-readable name for debug messages
+	 */
+	const char *name;
+
 	/**
 	 * @head: List entry used to attach a private object to a &drm_device
 	 * (queued to &drm_mode_config.privobj_list).
 	 */
 	struct list_head head;
@@ -754,11 +759,11 @@ drm_atomic_get_new_colorop_state(struct drm_atomic_commit *state,
 struct drm_connector_state * __must_check
 drm_atomic_get_connector_state(struct drm_atomic_commit *state,
 			       struct drm_connector *connector);
 
 int drm_atomic_private_obj_init(struct drm_device *dev,
-				struct drm_private_obj *obj,
+				struct drm_private_obj *obj, const char *name,
 				const struct drm_private_state_funcs *funcs);
 void drm_atomic_private_obj_fini(struct drm_private_obj *obj);
 
 struct drm_private_state * __must_check
 drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 1981d24a700d..54cf0d223bba 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1029,10 +1029,12 @@ enum drm_bridge_ops {
 struct drm_bridge {
 	/** @base: inherit from &drm_private_object */
 	struct drm_private_obj base;
 	/** @dev: DRM device this bridge belongs to */
 	struct drm_device *dev;
+	/** @name: human-readable name for debug messages */
+	const char *name;
 	/** @encoder: encoder to which this bridge is connected */
 	struct drm_encoder *encoder;
 	/** @chain_node: used to form a bridge chain */
 	struct list_head chain_node;
 	/** @of_node: device node pointer to the bridge */

-- 
2.55.0

