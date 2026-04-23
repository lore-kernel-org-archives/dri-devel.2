Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1F9F99367
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4192F10F043;
	Thu, 23 Apr 2026 10:07:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MiRdeuCH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F8AF10F036
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 10:07:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 405DF419AB;
 Thu, 23 Apr 2026 10:07:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6667C2BCB2;
 Thu, 23 Apr 2026 10:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776938853;
 bh=8Um5jm6/pPpXUqr5LcfqQ0vX4F+G2aZnGx6nrOgt1ME=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=MiRdeuCH/8WwF84+pa7cPLROJcbTO0g3LCOzJcyxhMvXF62HxErzvCodc6CJEUKSh
 ESPLrim+emOgOKKz5Eh9DcuqYlqTfsdzV0QlnLuI34yAzQ6hvNT5KN3wQgCj8ZEyf6
 IH2+T+LcPpWgNGtq8HL7N7J/AGZcyy/+QTH4z6p+/CGUw92eO5OWMfkj9gKRbQcXn3
 nIgSS+b+aG2szMHQYF1CnSqrD6jbMuC5NSJ98wk0BdvyHfi+Zos4FRmLKEJ6H3VpLb
 eJTEwl0aM9+X2ofBVP84jewI+G7lhZJTUuRag0o6Pw+wrQWCfxmXNynPP3XkvdL1ST
 DBFqqZqNyB1Iw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Apr 2026 12:06:43 +0200
Subject: [PATCH v2 05/28] drm/atomic: Add drm_private_obj name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-drm-state-readout-v2-5-6cde1a9910ed@kernel.org>
References: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
In-Reply-To: <20260423-drm-state-readout-v2-0-6cde1a9910ed@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=16333; i=mripard@kernel.org;
 h=from:subject:message-id; bh=8Um5jm6/pPpXUqr5LcfqQ0vX4F+G2aZnGx6nrOgt1ME=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJkv33sUH0h6md4Y9fqKC8cjxZAZ9fFOG7buZOysD3cQu
 bfWOWttx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjISR/GOsXrFuxKk+WuLs9V
 +Hk7Yr22l+upY44/UzS/3p678rVWcXnoslM1zLMeTNn/qb/srdv8ZsaG7aqVNjn//JXl+ITiQgs
 mNpv2MnuoB57ZpDRn/+N5aet3eDCd2lShMGGKr9O5bU51FSIA
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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       | 1 +
 drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c | 8 ++++++++
 drivers/gpu/drm/display/drm_dp_mst_topology.c           | 2 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c                 | 1 +
 drivers/gpu/drm/drm_atomic.c                            | 4 ++++
 drivers/gpu/drm/drm_bridge.c                            | 3 ++-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c               | 1 +
 drivers/gpu/drm/ingenic/ingenic-ipu.c                   | 1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                 | 1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c                | 1 +
 drivers/gpu/drm/omapdrm/omap_drv.c                      | 1 +
 drivers/gpu/drm/tegra/hub.c                             | 1 +
 drivers/gpu/drm/vc4/vc4_kms.c                           | 3 +++
 include/drm/drm_atomic.h                                | 7 ++++++-
 include/drm/drm_bridge.h                                | 2 ++
 15 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c2066319772b..d993f6e5f3e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5020,10 +5020,11 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
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
index 8757972e8e24..7936bb7e0bf6 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -5762,11 +5762,11 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
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
index 6519b4244728..ff32ac855780 100644
--- a/drivers/gpu/drm/display/drm_dp_tunnel.c
+++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
@@ -1599,10 +1599,11 @@ static bool init_group(struct drm_dp_tunnel_mgr *mgr, struct drm_dp_tunnel_group
 	group->mgr = mgr;
 	group->available_bw = -1;
 	INIT_LIST_HEAD(&group->tunnels);
 
 	drm_atomic_private_obj_init(mgr->dev, &group->base,
+				    group->name,
 				    &tunnel_group_funcs);
 
 	return true;
 }
 
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 84bc91886b4c..0a9f5e9fc69b 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -985,10 +985,11 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
 
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
@@ -996,17 +997,19 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
  * RETURNS:
  * Zero on success, error code on failure
  */
 int drm_atomic_private_obj_init(struct drm_device *dev,
 				struct drm_private_obj *obj,
+				const char *name,
 				const struct drm_private_state_funcs *funcs)
 {
 	memset(obj, 0, sizeof(*obj));
 
 	drm_modeset_lock_init(&obj->lock);
 
 	obj->dev = dev;
+	obj->name = kstrdup(name, GFP_KERNEL);
 	obj->funcs = funcs;
 	list_add_tail(&obj->head, &dev->mode_config.privobj_list);
 
 	return 0;
 }
@@ -1021,10 +1024,11 @@ EXPORT_SYMBOL(drm_atomic_private_obj_init);
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
index 986e4c79a4e0..44d53906e4c5 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -379,10 +379,11 @@ void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
 
 	bridge = container + offset;
 	INIT_LIST_HEAD(&bridge->list);
 	bridge->container = container;
 	bridge->funcs = funcs;
+	bridge->name = devm_kasprintf(dev, GFP_KERNEL, "bridge-%s", dev_name(dev));
 	kref_init(&bridge->refcount);
 
 	err = devm_add_action_or_reset(dev, drm_bridge_put_void, bridge);
 	if (err)
 		return ERR_PTR(err);
@@ -586,11 +587,11 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 		if (ret < 0)
 			goto err_reset_bridge;
 	}
 
 	if (drm_bridge_is_atomic(bridge))
-		drm_atomic_private_obj_init(bridge->dev, &bridge->base,
+		drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
 					    &drm_bridge_priv_state_funcs);
 
 	return 0;
 
 err_reset_bridge:
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 4068114adf8c..135d8b08f213 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1400,10 +1400,11 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
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
index 34545b9c8c33..17a0e5dc6df0 100644
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
index 35f7af4743d7..f72b94a60e9d 100644
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
index 2d26b07b06f5..1177f53a85fc 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -715,10 +715,11 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 	int ret;
 
 	mdp5_kms->dev = dev;
 
 	drm_atomic_private_obj_init(mdp5_kms->dev, &mdp5_kms->glob_state,
+				    "mdp5_global_state",
 				    &mdp5_global_state_funcs);
 
 	/* we need to set a default rate before enabling.  Set a safe
 	 * rate first, then figure out hw revision, and then set a
 	 * more optimal rate:
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index ae678696fbac..da7722e9b538 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -298,10 +298,11 @@ static const struct drm_private_state_funcs omap_global_state_funcs = {
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
index 10d993b8d043..94f9aa690f59 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -956,10 +956,11 @@ static int tegra_display_hub_init(struct host1x_client *client)
 	struct tegra_display_hub *hub = to_tegra_display_hub(client);
 	struct drm_device *drm = dev_get_drvdata(client->host);
 	struct tegra_drm *tegra = drm->dev_private;
 
 	drm_atomic_private_obj_init(drm, &hub->base,
+				    "tegra_display_hub",
 				    &tegra_display_hub_state_funcs);
 
 	tegra->hub = hub;
 
 	return 0;
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index 264b5e80c24d..f6ac2a20576e 100644
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
index 537092d3ed16..4f58289d3a34 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -354,10 +354,15 @@ struct drm_private_obj {
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
@@ -735,11 +740,11 @@ drm_atomic_get_new_colorop_state(struct drm_atomic_state *state,
 struct drm_connector_state * __must_check
 drm_atomic_get_connector_state(struct drm_atomic_state *state,
 			       struct drm_connector *connector);
 
 int drm_atomic_private_obj_init(struct drm_device *dev,
-				struct drm_private_obj *obj,
+				struct drm_private_obj *obj, const char *name,
 				const struct drm_private_state_funcs *funcs);
 void drm_atomic_private_obj_fini(struct drm_private_obj *obj);
 
 struct drm_private_state * __must_check
 drm_atomic_get_private_obj_state(struct drm_atomic_state *state,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index d6cd0f5af045..84b5517726c1 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1100,10 +1100,12 @@ enum drm_bridge_ops {
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
2.53.0

