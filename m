Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469CB606A334
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WG5uHRWY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79B6C11292D;
	Fri, 27 Nov 2026 09:54:51 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 377AC10E6BD
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 09:53:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A172D61DD7;
 Fri, 27 Nov 2026 09:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3801F0089B;
 Fri, 27 Nov 2026 09:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795773213;
 bh=8GJHF6PawPECxNvytO2q3lVNDJs7z/lh89dzWiIG0j4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=WG5uHRWYq1ZtpqB8tGqd/4sO6w8nkBm6N9SOGE38LnxZOh/9JumIFofeeNeaS49kJ
 DscSKlKzsvuNqTCDFXuh2HQ4S30pseLwix48eHsgmoVswJ/ae0OGhw8qtmX0K27ICb
 cB5abuB+CMb9F061WF3Te91v6H4cOZ6MCtgaHngEdR7ofIG+kW23CpORH5o9Fq/LJx
 OO5CdkhfKBRQVLZJaRmGmQcqOoAkE16s1vOqPJeIDvCcXK5G4ueZC1Fo66LNJZpwkq
 VWimFPHGSEw/aZjiDnrNPD2zp5L+feViJT9GfKflQ+Vw3+94m5j+3Ri4WHT8iTRTAA
 zXXzMGHNP+3jg==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 27 Nov 2026 10:52:46 +0100
Subject: [PATCH v10 04/36] drm/atomic: Add drm_private_obj name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-drm-state-readout-v10-4-0259582d45a8@kernel.org>
References: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
In-Reply-To: <20261127-drm-state-readout-v10-0-0259582d45a8@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=18120; i=mripard@kernel.org;
 h=from:subject:message-id; bh=zx57053S+NacZmU7n8f+3nJZ1G4JhY95JDHtZGv4N2M=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDNmcQf8KD7c+nR276PuNRzlTJf62+gVaOx6V3Wmy2yxEf
 416St2KjqksDMKcDLJiiixPZMJOL29fXOVgv/IHzBxWJpAhDFycAjCRNR2MDUeqcl8k9K01YXi4
 tVd5/aIZyvuk+y5K8vRrsU9bb3H5D1+EQ0HSshP+dQ4fq8r43aSLGOurm6pdTXrede9sS5qbY3B
 uXbmNwMHCusNXTFQ/z1l4rbhV+YXNE/69nduuz98Tv9wiqQUA
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

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c       |  1 +
 drivers/gpu/drm/arm/display/komeda/komeda_private_obj.c |  8 ++++++++
 drivers/gpu/drm/display/drm_dp_mst_topology.c           |  2 +-
 drivers/gpu/drm/display/drm_dp_tunnel.c                 | 15 +++++++++++++--
 drivers/gpu/drm/drm_atomic.c                            | 13 +++++++++++++
 drivers/gpu/drm/drm_bridge.c                            | 10 +++++++++-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c               |  1 +
 drivers/gpu/drm/ingenic/ingenic-ipu.c                   |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c                 |  1 +
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c                |  1 +
 drivers/gpu/drm/omapdrm/omap_drv.c                      |  1 +
 drivers/gpu/drm/tegra/hub.c                             |  1 +
 drivers/gpu/drm/vc4/vc4_kms.c                           |  3 +++
 include/drm/drm_atomic.h                                |  7 +++++++
 include/drm/drm_bridge.h                                |  2 ++
 15 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 019022fba6f1..db626c08edf4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2299,10 +2299,11 @@ STATIC_IFN_KUNIT int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
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
index d29ad4116e64..381b68f6c3a3 100644
--- a/drivers/gpu/drm/display/drm_dp_tunnel.c
+++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
@@ -1725,16 +1725,27 @@ drm_dp_tunnel_atomic_get_new_state(struct drm_atomic_commit *state,
 }
 EXPORT_SYMBOL(drm_dp_tunnel_atomic_get_new_state);
 
 static bool init_group(struct drm_dp_tunnel_mgr *mgr, struct drm_dp_tunnel_group *group)
 {
+	char name[32];
+
 	group->mgr = mgr;
 	group->available_bw = -1;
 	INIT_LIST_HEAD(&group->tunnels);
 
-	drm_atomic_private_obj_init(mgr->dev, &group->base,
-				    &tunnel_group_funcs);
+	/*
+	 * The group identifier, and thus the group name, is only known
+	 * once a tunnel has been added to the group. Name the private
+	 * object after the group index.
+	 */
+	snprintf(name, sizeof(name), "dp-tunnel-group-%d",
+		 (int)(group - mgr->groups));
+
+	if (drm_atomic_private_obj_init(mgr->dev, &group->base, name,
+					&tunnel_group_funcs))
+		return false;
 
 	return true;
 }
 
 static void cleanup_group(struct drm_dp_tunnel_group *group)
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 1c3fe07b327e..61381faf1186 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -1047,10 +1047,11 @@ void drm_atomic_plane_print_state(struct drm_printer *p,
 
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
@@ -1058,10 +1059,11 @@ void drm_atomic_plane_print_state(struct drm_printer *p,
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
 
@@ -1076,10 +1078,16 @@ int drm_atomic_private_obj_init(struct drm_device *dev,
 
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
@@ -1090,10 +1098,13 @@ int drm_atomic_private_obj_init(struct drm_device *dev,
 
 	return 0;
 
 err_list_del:
 	list_del_init(&obj->head);
+	kfree(obj->name);
+	obj->name = NULL;
+err_lock_fini:
 	drm_modeset_lock_fini(&obj->lock);
 	return ret;
 }
 EXPORT_SYMBOL(drm_atomic_private_obj_init);
 
@@ -1117,10 +1128,12 @@ drm_atomic_private_obj_fini(struct drm_private_obj *obj)
 	if (list_empty(&obj->head))
 		return;
 
 	list_del_init(&obj->head);
 	obj->funcs->atomic_destroy_state(obj, obj->state);
+	kfree(obj->name);
+	obj->name = NULL;
 	drm_modeset_lock_fini(&obj->lock);
 }
 EXPORT_SYMBOL(drm_atomic_private_obj_fini);
 
 static int drm_atomic_commit_set_private_obj_state(struct drm_atomic_commit *commit,
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 3cd6757dffb8..21219958c0dd 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -316,10 +316,11 @@ static void __drm_bridge_free(struct kref *kref)
 	if (bridge->funcs->destroy)
 		bridge->funcs->destroy(bridge);
 
 	drm_bridge_put(bridge->next_bridge);
 
+	kfree(bridge->name);
 	kfree(bridge->container);
 }
 
 /**
  * drm_bridge_get - Acquire a bridge reference
@@ -417,10 +418,17 @@ void *__devm_drm_bridge_alloc(struct device *dev, size_t size, size_t offset,
 	container = kzalloc(size, GFP_KERNEL);
 	if (!container)
 		return ERR_PTR(-ENOMEM);
 
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
 	bridge->funcs = funcs;
 	kref_init(&bridge->refcount);
 
@@ -667,11 +675,11 @@ int drm_bridge_attach(struct drm_encoder *encoder, struct drm_bridge *bridge,
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
index 752cb7f80d67..f6af9c29e531 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1363,10 +1363,11 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 		dev_err(dev, "Failed calling drm_vblank_init()\n");
 		goto err_drvdata;
 	}
 
 	ret = drm_atomic_private_obj_init(drm, &priv->private_obj,
+					  "ingenic_drm",
 					  &ingenic_drm_private_state_funcs);
 	if (ret)
 		goto err_drvdata;
 
 	ret = drmm_add_action_or_reset(drm, ingenic_drm_atomic_private_obj_fini,
diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
index 7f3cc8a75898..0b17a7875d9f 100644
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
index 1b6286dccfc0..f14fb619ebb6 100644
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
index ff6751b2ae62..1dc6d36e4de7 100644
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
index 12429ca53ead..b220e298d27a 100644
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
index c8d0f18fd0fd..6babffaa7733 100644
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
@@ -755,11 +760,13 @@ struct drm_connector_state * __must_check
 drm_atomic_get_connector_state(struct drm_atomic_commit *state,
 			       struct drm_connector *connector);
 
 int drm_atomic_private_obj_init(struct drm_device *dev,
 				struct drm_private_obj *obj,
+				const char *name,
 				const struct drm_private_state_funcs *funcs);
+
 void drm_atomic_private_obj_fini(struct drm_private_obj *obj);
 
 struct drm_private_state * __must_check
 drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
 				 struct drm_private_obj *obj);
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 12ca7f6fb524..a22a0bdf3251 100644
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
2.56.1

