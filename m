Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE06606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QUGhdt0V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0083D10FFDD;
	Thu, 29 Oct 2026 07:34:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 498DD10FFD0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:34:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 30BFF43834;
 Thu, 29 Oct 2026 07:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894851F01828;
 Thu, 29 Oct 2026 07:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259282;
 bh=zCh22juezXc/PRPLknYi6ENmcB1gUpHhTODwIIEdZrA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=QUGhdt0Vp4rCjxwO4Dog9huQBH4tTCtb/oyW5I9VTIG3y2ku6jQU1Zy3EBUlKsKNe
 b4zAxvPe5KxFHlvKvS8Slt0DnRRHtoQ8Igf0NaQrBSCSm/IlupdhtUYe1cpcfuYjMf
 UfzYI+PG3WwMbRGfy2AlRufIY3+EPIQuPkXhsVA2j/Hhc9U5JIwYopSpM+JqnfMKBM
 fP69+YZDOAKKChbb8yccVjb+er6h8yDELGjpZUg3gXBxBwHgd1fy4vkUcuq2hHP5V/
 49L5mnqz2UIUmP/j2RDJEyx9dM2GdLuYeGqKu5dSb2FbmxJd2e904tV91sf+rtkUxY
 KrhmeCpu3M2Dg==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:33:55 +0100
Subject: [PATCH v7 05/34] drm/atomic: Add drm_private_obj name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-5-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
In-Reply-To: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12370; i=mripard@kernel.org;
 h=from:subject:message-id; bh=yR2seJNJQg/pW9/nd5/aLAsC8A79Dun73sQmiizd6k0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvr2/cqzwLesP9YalmaWhbVOUbesnBVbmxx8sSPHZ2
 vMmQW55x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIoDFjvZ+bzwOleUJ1H/kW
 X7ha++1L4TqD6p3FMVXxb8N3ik4J2v222lF7k5zvUr6SwndSJxqnMdaKy8xsMbp8d4H+lVV820r
 aNjDtsf3wUsk9wfHwGhO9+vuGKy6d9G49rcyqKLvB7jDb/xwA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

drm_private_obj does not carry a human-readable name, which makes
debug messages hard to interpret when multiple private objects are
registered on the same device.

Add a name field to drm_private_obj, passed through
drm_atomic_private_obj_init() and freed in
drm_atomic_private_obj_fini(). Update the existing callers to pass a
name.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       |  1 +
 drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c |  8 ++++++++
 drivers/gpu/drm/display/drm_dp_mst_topology.c           |  2 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c                 |  1 +
 drivers/gpu/drm/drm_atomic.c                            | 12 ++++++++++++
 drivers/gpu/drm/drm_bridge.c                            | 10 +++++++++-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c               |  1 +
 drivers/gpu/drm/ingenic/ingenic-ipu.c                   |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                 |  1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c                |  1 +
 drivers/gpu/drm/omapdrm/omap_drv.c                      |  1 +
 drivers/gpu/drm/tegra/hub.c                             |  1 +
 drivers/gpu/drm/vc4/vc4_kms.c                           |  3 +++
 include/drm/drm_atomic.h                                |  7 ++++++-
 include/drm/drm_bridge.h                                |  2 ++
 15 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5e106b65034d..32b582f31f0e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2314,4 +2314,5 @@ STATIC_IFN_KUNIT int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 	drm_atomic_private_obj_init(adev_to_drm(adev),
 				    &adev->dm.atomic_obj,
+				    "amdgpu_dc_state",
 				    &dm_atomic_state_funcs);
 
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
index 77b3f361091f..8a3c9fcf3844 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c
@@ -67,4 +67,5 @@ static int komeda_layer_obj_add(struct komeda_kms_dev *kms,
 {
 	drm_atomic_private_obj_init(&kms->base, &layer->base.obj,
+				    "komeda_layer",
 				    &komeda_layer_obj_funcs);
 	return 0;
@@ -120,4 +121,5 @@ static int komeda_scaler_obj_add(struct komeda_kms_dev *kms,
 	drm_atomic_private_obj_init(&kms->base,
 				    &scaler->base.obj,
+				    "komeda_scaler",
 				    &komeda_scaler_obj_funcs);
 	return 0;
@@ -172,4 +174,5 @@ static int komeda_compiz_obj_add(struct komeda_kms_dev *kms,
 {
 	drm_atomic_private_obj_init(&kms->base, &compiz->base.obj,
+				    "komeda_compiz",
 				    &komeda_compiz_obj_funcs);
 
@@ -226,4 +229,5 @@ static int komeda_splitter_obj_add(struct komeda_kms_dev *kms,
 	drm_atomic_private_obj_init(&kms->base,
 				    &splitter->base.obj,
+				    "komeda_splitter",
 				    &komeda_splitter_obj_funcs);
 
@@ -279,4 +283,5 @@ static int komeda_merger_obj_add(struct komeda_kms_dev *kms,
 	drm_atomic_private_obj_init(&kms->base,
 				    &merger->base.obj,
+				    "komeda_merger",
 				    &komeda_merger_obj_funcs);
 
@@ -332,4 +337,5 @@ static int komeda_improc_obj_add(struct komeda_kms_dev *kms,
 {
 	drm_atomic_private_obj_init(&kms->base, &improc->base.obj,
+				    "komeda_improc",
 				    &komeda_improc_obj_funcs);
 
@@ -385,4 +391,5 @@ static int komeda_timing_ctrlr_obj_add(struct komeda_kms_dev *kms,
 {
 	drm_atomic_private_obj_init(&kms->base, &ctrlr->base.obj,
+				    "komeda_timing_ctrlr",
 				    &komeda_timing_ctrlr_obj_funcs);
 
@@ -439,4 +446,5 @@ static int komeda_pipeline_obj_add(struct komeda_kms_dev *kms,
 {
 	drm_atomic_private_obj_init(&kms->base, &pipe->obj,
+				    "komeda_pipeline",
 				    &komeda_pipeline_obj_funcs);
 
diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index b7fce0bf8acc..c7c3f6b0cf76 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -5775,5 +5775,5 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
 	mgr->conn_base_id = conn_base_id;
 
-	drm_atomic_private_obj_init(dev, &mgr->base,
+	drm_atomic_private_obj_init(dev, &mgr->base, "drm_dp_mst_topology",
 				    &drm_dp_mst_topology_state_funcs);
 
diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
index d29ad4116e64..391d643793eb 100644
--- a/drivers/gpu/drm/display/drm_dp_tunnel.c
+++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
@@ -1733,4 +1733,5 @@ static bool init_group(struct drm_dp_tunnel_mgr *mgr, struct drm_dp_tunnel_group
 
 	drm_atomic_private_obj_init(mgr->dev, &group->base,
+				    group->name,
 				    &tunnel_group_funcs);
 
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 8f9b17395b90..039be737fd07 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1016,4 +1016,5 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
  * @dev: DRM device this object will be attached to
  * @obj: private object
+ * @name: human-readable name for debug messages
  * @funcs: pointer to the struct of function pointers that identify the object
  * type
@@ -1027,4 +1028,5 @@ static void drm_atomic_plane_print_state(struct drm_printer *p,
 int drm_atomic_private_obj_init(struct drm_device *dev,
 				struct drm_private_obj *obj,
+				const char *name,
 				const struct drm_private_state_funcs *funcs)
 {
@@ -1045,4 +1047,10 @@ int drm_atomic_private_obj_init(struct drm_device *dev,
 	obj->dev = dev;
 	obj->funcs = funcs;
+	obj->name = kstrdup(name, GFP_KERNEL);
+	if (!obj->name) {
+		ret = -ENOMEM;
+		goto err_lock_fini;
+	}
+
 	list_add_tail(&obj->head, &dev->mode_config.privobj_list);
 
@@ -1059,4 +1067,7 @@ int drm_atomic_private_obj_init(struct drm_device *dev,
 err_list_del:
 	list_del_init(&obj->head);
+	kfree(obj->name);
+	obj->name = NULL;
+err_lock_fini:
 	drm_modeset_lock_fini(&obj->lock);
 	return ret;
@@ -1084,4 +1095,5 @@ drm_atomic_private_obj_fini(struct drm_private_obj *obj)
 	list_del(&obj->head);
 	obj->funcs->atomic_destroy_state(obj, obj->state);
+	kfree(obj->name);
 	drm_modeset_lock_fini(&obj->lock);
 }
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index e7f9e6d58927..ac65ac941691 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -318,4 +318,5 @@ static void __drm_bridge_free(struct kref *kref)
 	drm_bridge_put(bridge->next_bridge);
 
+	kfree(bridge->name);
 	kfree(bridge->container);
 }
@@ -419,4 +420,11 @@ void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
 
 	bridge = container + offset;
+
+	bridge->name = kasprintf(GFP_KERNEL, "bridge-%s", dev_name(dev));
+	if (!bridge->name) {
+		kfree(container);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	INIT_LIST_HEAD(&bridge->list);
 	bridge->container = container;
@@ -650,5 +658,5 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
 	}
 
-	drm_atomic_private_obj_init(bridge->dev, &bridge->base,
+	drm_atomic_private_obj_init(bridge->dev, &bridge->base, bridge->name,
 				    &drm_bridge_priv_state_funcs);
 
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index fff1ba598e96..1afac110bc28 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1405,4 +1405,5 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 
 	drm_atomic_private_obj_init(drm, &priv->private_obj,
+				    "ingenic_drm",
 				    &ingenic_drm_private_state_funcs);
 
diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
index bf24882e8d9f..795f6db5ce59 100644
--- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
+++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
@@ -903,4 +903,5 @@ static int ingenic_ipu_bind(struct device *dev, struct device *master, void *d)
 
 	drm_atomic_private_obj_init(drm, &ipu->private_obj,
+				    "ingenic_ipu_state",
 				    &ingenic_ipu_private_state_funcs);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..fb3a0c847a9e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1156,4 +1156,5 @@ static int dpu_kms_hw_init(struct msm_kms *kms)
 
 	drm_atomic_private_obj_init(dpu_kms->dev, &dpu_kms->global_state,
+				    "dpu_kms_global_state",
 				    &dpu_kms_global_state_funcs);
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 3934cd060b27..b53f59f25fb0 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -713,4 +713,5 @@ static int mdp5_init(struct platform_device *pdev, struct drm_device *dev)
 
 	drm_atomic_private_obj_init(mdp5_kms->dev, &mdp5_kms->glob_state,
+				    "mdp5_global_state",
 				    &mdp5_global_state_funcs);
 
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index db216c888a8f..3f66cd66443f 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -300,4 +300,5 @@ static int omap_global_obj_init(struct drm_device *dev)
 
 	drm_atomic_private_obj_init(dev, &priv->glob_obj,
+				    "omap_global",
 				    &omap_global_state_funcs);
 	return 0;
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index 448f49f3a7d7..854b671dfec8 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -961,4 +961,5 @@ static int tegra_display_hub_init(struct host1x_client *client)
 
 	drm_atomic_private_obj_init(drm, &hub->base,
+				    "tegra_display_hub",
 				    &tegra_display_hub_state_funcs);
 
diff --git a/drivers/gpu/drm/vc4/vc4_kms.c b/drivers/gpu/drm/vc4/vc4_kms.c
index ab551eb2da50..e43d59cff4df 100644
--- a/drivers/gpu/drm/vc4/vc4_kms.c
+++ b/drivers/gpu/drm/vc4/vc4_kms.c
@@ -118,4 +118,5 @@ static int vc4_ctm_obj_init(struct vc4_dev *vc4)
 
 	drm_atomic_private_obj_init(&vc4->base, &vc4->ctm_manager,
+				    "vc4_ctm",
 				    &vc4_ctm_state_funcs);
 
@@ -758,4 +759,5 @@ static int vc4_load_tracker_obj_init(struct vc4_dev *vc4)
 {
 	drm_atomic_private_obj_init(&vc4->base, &vc4->load_tracker,
+				    "vc4_load_tracker",
 				    &vc4_load_tracker_state_funcs);
 
@@ -849,4 +851,5 @@ static int vc4_hvs_channels_obj_init(struct vc4_dev *vc4)
 {
 	drm_atomic_private_obj_init(&vc4->base, &vc4->hvs_channels,
+				    "vc4_hvs_channels",
 				    &vc4_hvs_state_funcs);
 
diff --git a/include/drm/drm_atomic.h b/include/drm/drm_atomic.h
index 3ae35b09c0cf..87f85a77e5f3 100644
--- a/include/drm/drm_atomic.h
+++ b/include/drm/drm_atomic.h
@@ -376,4 +376,9 @@ struct drm_private_obj {
 	struct drm_device *dev;
 
+	/**
+	 * @name: human-readable name for debug messages
+	 */
+	const char *name;
+
 	/**
 	 * @head: List entry used to attach a private object to a &drm_device
@@ -757,5 +762,5 @@ drm_atomic_get_connector_state(struct drm_atomic_commit *state,
 
 int drm_atomic_private_obj_init(struct drm_device *dev,
-				struct drm_private_obj *obj,
+				struct drm_private_obj *obj, const char *name,
 				const struct drm_private_state_funcs *funcs);
 void drm_atomic_private_obj_fini(struct drm_private_obj *obj);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 1981d24a700d..54cf0d223bba 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -1032,4 +1032,6 @@ struct drm_bridge {
 	/** @dev: DRM device this bridge belongs to */
 	struct drm_device *dev;
+	/** @name: human-readable name for debug messages */
+	const char *name;
 	/** @encoder: encoder to which this bridge is connected */
 	struct drm_encoder *encoder;

-- 
2.55.0

