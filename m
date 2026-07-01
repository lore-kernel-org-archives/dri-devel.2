Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17592C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E6B310EF70;
	Wed,  1 Jul 2026 12:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="jBJkXSJh";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C91B10EF73
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908506;
 bh=plVCc9IZ6OyTYv+01aTAc+ze+rBF5NHMz2diaZ69Ehk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jBJkXSJhsphwlOXUyD/MLZ4AGR3udQSHTUCd0W/b4Rm/7Nrn3n7C+aaCS2LVJqZ0r
 azcvcvaz59aVFyb8DgzxxBLh7mBzORI6XcyyecF9k3A5lPWblKcgeOPx++JYlxxdl5
 m7lXDLN7il9zqP0HBfZ5wuH4X6fAzePhHwzmu7LuLycjHBMSJAEc7QECVCmxjrdU0R
 t6cPIe+eLjEHmwEgS5+z0PHemKLPCpoyCLrBMwCFl4BcRywImC44pUnzpXJvBYJyuT
 SAyczQ5TSNGmAPdwhcBRaojvxn3oPlGJcThW5T6PIKg8qhYb9tajs8HVYE5cS/0l6A
 aTKr2iBwkhKeg==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 163F717E35D9;
 Wed,  1 Jul 2026 14:21:45 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, justin.yeh@mediatek.com,
 jason-jh.lin@mediatek.com, kernel@collabora.com
Subject: [PATCH 33/42] drm/mediatek: Prepare path builder for multi-controller
 architecture
Date: Wed,  1 Jul 2026 14:20:48 +0200
Message-ID: <20260701122057.19648-34-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
References: <20260701122057.19648-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

In preparation for adding support for the new display controllers
featuring multi-controller w/DirectLink architecture, expand the
path builder to recognize whether a hardware component in display
controller related output path is getting its input from internal
or from any external (to itself, but still internal to the SoC)
display controller component.

When an output path is found, it is also necessary to understand
the enablement order (in terms of mmsys/mutex other than PM) of
the controllers, as that cannot be done randomly: for this, the
initial path builder will start storing an indication to whether
a component is either in a leader or in a follower controller,
and then a new function mtk_drm_set_path_orders(), called when
binding all components, when initializing KMS, takes care of the
looping through the path and setting up the order between all
of the follower display controllers.

As of this point, no multi-controller SoCs are introduced yet,
so this code will not bring any functional change on any of the
currently supported SoCs / display controllers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c   |   2 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h   |   2 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c    | 351 ++++++++++++++++++++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.h    |   2 +
 drivers/gpu/drm/mediatek/mtk_drm_legacy.c |   3 +-
 5 files changed, 332 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index 0ecb942d6129..3f25f1c34633 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -680,6 +680,7 @@ static int mtk_ddp_comp_init_internal_comp(struct device *dev, struct device *co
 
 int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 		      struct mtk_drm_comp_list *hlist,
+		      u8 comp_controller_id,
 		      enum mtk_ddp_comp_type comp_type, int comp_inst_id)
 {
 	struct platform_device *comp_pdev;
@@ -695,6 +696,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 
 	comp->type = comp_type;
 	comp->inst_id = comp_inst_id;
+	comp->controller_id = comp_controller_id;
 	comp->funcs = mtk_ddp_funcs[comp_type];
 	/* Not all drm components have a DTS device node, such as ovl_adaptor,
 	 * which is the drm bring up sub driver
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
index 1297db252821..e94bcf6922c1 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
@@ -87,6 +87,7 @@ struct mtk_ddp_comp {
 	enum mtk_ddp_comp_type type;
 	u8 inst_id;
 	u8 mtx_trig_id;
+	u8 controller_id;
 	int encoder_index;
 	const struct mtk_ddp_comp_funcs *funcs;
 
@@ -375,6 +376,7 @@ int mtk_ddp_comp_get_id(struct device_node *node,
 int mtk_find_possible_crtcs(struct drm_device *drm, struct device *dev);
 int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 		      struct mtk_drm_comp_list *hlist,
+		      u8 comp_controller_id,
 		      enum mtk_ddp_comp_type comp_type, int comp_inst_id);
 int mtk_ddp_comp_get_mutex_trigger(struct device_node *node, unsigned int index);
 enum mtk_ddp_comp_type mtk_ddp_comp_get_type(unsigned int comp_id);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 3ed0e3f45fe2..3bee730cd34f 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -185,7 +185,7 @@ static int mtk_drm_match(struct device *dev, const void *data)
 static bool mtk_drm_get_all_drm_priv(struct device *dev)
 {
 	struct mtk_drm_private *drm_priv = dev_get_drvdata(dev);
-	struct mtk_drm_private *all_drm_priv[MAX_CRTC];
+	struct mtk_drm_private *all_drm_priv[drm_priv->data->mmsys_dev_num];
 	struct mtk_drm_private *temp_drm_priv;
 	struct device_node *phandle = dev->parent->of_node;
 	const struct of_device_id *of_id;
@@ -194,8 +194,10 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 	unsigned int cnt = 0;
 	int i, j;
 
+	dev_vdbg(dev, "Populating private data for all controllers on ID%u\n",
+		 drm_priv->data->mmsys_id);
+
 	for_each_child_of_node(phandle->parent, node) {
-		const struct mtk_drm_path_definition *output_path;
 		struct platform_device *pdev;
 
 		of_id = of_match_node(mtk_drm_of_ids, node);
@@ -216,19 +218,12 @@ static bool mtk_drm_get_all_drm_priv(struct device *dev)
 		if (!temp_drm_priv)
 			continue;
 
-		for (i = 0; i < MAX_CRTC; i++) {
-			output_path = &temp_drm_priv->data->output_paths[i];
-
-			if (!output_path->len)
-				continue;
-
-			all_drm_priv[i] = temp_drm_priv;
-		}
+		all_drm_priv[temp_drm_priv->data->mmsys_id] = temp_drm_priv;
 
 		if (temp_drm_priv->mtk_drm_bound)
 			cnt++;
 
-		if (cnt == MAX_CRTC) {
+		if (cnt == drm_priv->data->mmsys_dev_num) {
 			of_node_put(node);
 			break;
 		}
@@ -272,6 +267,98 @@ static bool mtk_drm_find_mmsys_comp(struct mtk_drm_private *private,
 	return false;
 }
 
+static struct mtk_drm_private *
+mtk_drm_find_matching_controller(struct mtk_drm_private **all_drm_private,
+				 struct device_node *target_node)
+{
+	for (int i = 0; i < all_drm_private[0]->data->mmsys_dev_num; i++) {
+		struct mtk_drm_private *priv = all_drm_private[i];
+		struct device_node *cur_mmsys_node = priv->mmsys_dev->of_node;
+
+		if (target_node == cur_mmsys_node)
+			return priv;
+	}
+
+	return NULL;
+}
+
+static void mtk_drm_set_path_orders(struct mtk_drm_private **all_drm_private)
+{
+	struct mtk_drm_private *private = all_drm_private[0];
+	unsigned short i, j;
+
+	/*
+	 * If the SoC has multiple display controllers w/DirectLink architecture
+	 * at this point all controllers have been registered and it is now safe
+	 * to iterate through and setup the outputs order so that the data path
+	 * follows the correct controllers sequence.
+	 *
+	 * At the end of this, the controllers are always ordered 0..N hence the
+	 * data, for each different display controller output (as each support
+	 * multiple different outputs as well) always travels through consecutive
+	 * controller indices, like CTRLRx_OUTPUTy -> ... -> CTRLRx+n_OUTPUTy,
+	 * where:
+	 *
+	 *  - The first one (0) is responsible for getting input frames from DRM
+	 *    and dispatching to image processing HW(s) and/or next controller;
+	 *  - The last one (N) is responsible for output to a physical display
+	 *
+	 * Note that one controller may also output to a different out-number of
+	 * its consecutive, so a display controller-I/O sequence like
+	 *
+	 *    CTRLR0_OUTPUT0 -> CTRLR1_OUTPUT3 -> CTRLR3_OUTPUT2 (-> DISPLAY)
+	 *          0        ->        1       ->       2
+	 *
+	 * should also considered as being valid since the hardware is capable of
+	 * doing so, but this is a corner case that is currently not handled to
+	 * simplify the implementation.
+	 */
+	for (i = 0; i < MAX_CRTC; i++) {
+		unsigned short max_iterations = private->data->mmsys_dev_num;
+		bool order_found;
+
+		do {
+			order_found = false;
+
+			for (j = 0; j < private->data->mmsys_dev_num; j++) {
+				const struct mtk_drm_path_definition *src_path;
+				struct mtk_drm_private *cur_priv, *src_priv;
+				struct mtk_drm_path_definition *cur_path;
+				unsigned int src_order;
+
+				cur_priv = all_drm_private[j];
+				if (!cur_priv)
+					continue;
+
+				cur_path = &cur_priv->data->output_paths[i];
+
+				if (!cur_path->len || !cur_path->input_controller)
+					continue;
+
+				src_priv = mtk_drm_find_matching_controller(all_drm_private,
+								cur_path->input_controller);
+				if (!src_priv)
+					continue;
+
+				/*
+				 * Paths are per-output: set order for the new output
+				 * by finding the order of the same output number of
+				 * the previous controller and incrementing it by one
+				 */
+				src_path = &src_priv->data->output_paths[i];
+				src_order = src_path->len ? src_path->order : 0;
+				if (cur_path->order <= src_order) {
+					cur_path->order = src_order + 1;
+
+					/* Order found: check next CRTC now! */
+					order_found = true;
+					break;
+				}
+			}
+		} while (!order_found && max_iterations--);
+	}
+}
+
 static int mtk_drm_kms_init(struct drm_device *drm)
 {
 	struct mtk_drm_private *private = drm->dev_private;
@@ -316,6 +403,9 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	 */
 	drm_helper_move_panel_connectors_to_head(drm);
 
+	/* Set controllers order for multi-controller architecture */
+	mtk_drm_set_path_orders(private->all_drm_private);
+
 	/*
 	 * 1. We currently support two fixed data streams, each optional,
 	 *    and each statically assigned to a crtc:
@@ -653,18 +743,108 @@ static int mtk_drm_of_get_ddp_comp_type(struct device_node *node, enum mtk_ddp_c
 	return 0;
 }
 
+/**
+ * mtk_drm_of_get_ep_external_controller() - Get parent controller if external
+ * @dev:         Device pointer to leading display controller
+ * @ep_dev_node: OF Node pointer to a display controller sub-component hardware
+ *               The caller is responsible for dropping the refcount.
+ *
+ * Return: External Display Controller (mmsys) device_node or NULL if the given
+ *         sub-component resides in the same Display Controller as *dev.
+ */
+static struct device_node
+*mtk_drm_of_get_ep_external_controller(struct device *dev,
+				       struct device_node *ep_dev_node)
+{
+	struct device_node *leader_controller_node = dev->parent->of_node;
+	struct device_node *ep_parent_node;
+
+	ep_parent_node = of_get_parent(ep_dev_node);
+	if (ep_parent_node == leader_controller_node) {
+		of_node_put(ep_parent_node);
+		return NULL;
+	}
+
+	return ep_parent_node;
+}
+
+static int mtk_drm_of_get_first_input(struct device *dev, struct device_node *node,
+				      enum mtk_crtc_path crtc_endpoint,
+				      struct mtk_drm_comp_definition *comp_def)
+{
+	struct device_node *ep_dev_node, *ep_in;
+	enum mtk_ddp_comp_type comp_type;
+	int inst_id, ret;
+
+	ep_in = of_graph_get_endpoint_by_regs(node, 0, crtc_endpoint);
+	if (!ep_in)
+		return -ENOENT;
+
+	ep_dev_node = of_graph_get_port_parent(ep_in);
+	of_node_put(ep_in);
+	if (!ep_dev_node)
+		return -EINVAL;
+
+	/*
+	 * If the first input has no HW component specific driver go out with
+	 * -ENOENT: depending on the SoC (for arch gen2), this may be expected.
+	 */
+	ret = mtk_drm_of_get_ddp_comp_type(ep_dev_node, &comp_type);
+	of_node_put(ep_dev_node);
+	if (ret)
+		return -ENOENT;
+
+	inst_id = mtk_ddp_comp_get_id(ep_dev_node, comp_type);
+	if (inst_id < 0)
+		return inst_id;
+
+	/* All ok! Pass the Component ID to the caller. */
+	comp_def->type = comp_type;
+	comp_def->inst_id = inst_id;
+
+	dev_dbg(dev, "Found first input component %pOF with ID=%u SubID=%u\n",
+		ep_dev_node, comp_def->type, comp_def->inst_id);
+
+	return 0;
+}
+
+/**
+ * mtk_drm_of_get_ddp_ep_cid - Parse HW component connection information
+ * @dev:          The mediatek-drm device
+ * @node:         The device node of the display controller component to parse
+ * @output_port:  The number of the port, corresponding to an output, to parse
+ * @crtc_endpoint:The number of the current endpoint corresponding to CRTC
+ * @next:         Pointer to a struct device_node, used to pass the next node,
+ *                corresponding to the next component's input, to the caller
+ * @comp_def:     Pointer to the last, uninitialized, entry of the temporary
+ *                structure array holding the Display Controller Path that is
+ *                being built.
+ * @controller_arch_v2: Check if DirectLink architecture or legacy VDO/MMSYS
+ *
+ * Return:
+ * * %0        - Component connection parsed fully: the currently parsed Display
+ *               Controller hardware component is interconnected with a next one
+ * * %-ENOENT  - The component's remote endpoint was not found
+ * * %-EINVAL  - Component information is not valid, hence not usable
+ * * %-ENODEV  - The identified component is a valid connection, but its DT node
+ *               is disabled, hence not usable
+ * * %-EREMOTE - The component is interconnected with a next one residing in a
+ *               different Display Controller, remote to the current one, hence
+ *               cannot be added to the path of the current controller
+ */
 static int mtk_drm_of_get_ddp_ep_cid(struct device *dev, struct device_node *node,
-				     int output_port, enum mtk_crtc_path crtc_path,
+				     int output_port, enum mtk_crtc_path crtc_endpoint,
 				     struct device_node **next,
-				     struct mtk_drm_comp_definition *comp_def)
+				     struct mtk_drm_comp_definition *comp_def,
+				     bool controller_arch_v2)
 {
 	struct device_node *ep_dev_node, *ep_out;
 	enum mtk_ddp_comp_type comp_type;
 	int ret;
 
-	ep_out = of_graph_get_endpoint_by_regs(node, output_port, crtc_path);
+	ep_out = of_graph_get_endpoint_by_regs(node, output_port, crtc_endpoint);
 	if (!ep_out)
-		return -ENOENT;
+		return -EINVAL;
 
 	ep_dev_node = of_graph_get_remote_port_parent(ep_out);
 	of_node_put(ep_out);
@@ -678,6 +858,21 @@ static int mtk_drm_of_get_ddp_ep_cid(struct device *dev, struct device_node *nod
 	 */
 	*next = ep_dev_node;
 
+	if (controller_arch_v2) {
+		struct device_node *rmt_ctrlr_node;
+
+		rmt_ctrlr_node = mtk_drm_of_get_ep_external_controller(dev, ep_dev_node);
+		if (rmt_ctrlr_node) {
+			/* The device is from a different mmsys (remote from this one) */
+			dev_dbg(dev, "Found connection to external mmsys %pOF\n",
+				rmt_ctrlr_node);
+
+			of_node_put(ep_dev_node);
+			of_node_put(rmt_ctrlr_node);
+			return -EREMOTE;
+		}
+	}
+
 	if (!of_device_is_available(ep_dev_node))
 		return -ENODEV;
 
@@ -708,9 +903,13 @@ static int mtk_drm_of_get_ddp_ep_cid(struct device *dev, struct device_node *nod
 
 /**
  * mtk_drm_of_ddp_path_build_one - Build a Display HW Pipeline for a CRTC Path
- * @dev:          The mediatek-drm device
- * @cpath:        CRTC Path relative to a VDO or MMSYS
+ * @dev:          The mediatek-drm device, corresponding to leading controller
+ *                instance of the current display HW pipeline
+ * @node:         The device node containing the first port/endpoint
+ * @cpath:        CRTC Path relative to a VDO or MMSYS, also used as
+ *                number of the initial endpoint for this CRTC path
  * @out_path:     Pointer to the structure that will contain the new pipeline
+ * @controller_arch_v2: Check if DirectLink architecture or legacy VDO/MMSYS
  *
  * MediaTek SoCs can use different DDP hardware pipelines (or paths) depending
  * on the board-specific desired display configuration; this function walks
@@ -723,18 +922,62 @@ static int mtk_drm_of_get_ddp_ep_cid(struct device *dev, struct device_node *nod
  * * %-EINVAL - Display pipeline built but validation failed
  * * %-ENOMEM - Failure to allocate pipeline array to pass to the caller
  */
-static int mtk_drm_of_ddp_path_build_one(struct device *dev, enum mtk_crtc_path cpath,
-					 struct mtk_drm_path_definition *out_path)
+static int mtk_drm_of_ddp_path_build_one(struct device *dev, struct device_node *node,
+					 enum mtk_crtc_path cpath,
+					 struct mtk_drm_path_definition *out_path,
+					 bool controller_arch_v2)
 {
 	struct mtk_drm_comp_definition temp_path[MTK_DISP_CONTROLLER_MAX_COMP_PER_PATH];
-	struct device_node *next = NULL, *prev, *vdo = dev->parent->of_node;
+	struct device_node *next = NULL, *prev;
 	bool ovl_adaptor_comp_added = false;
 	unsigned short int idx = 0;
 	size_t final_comp_sz;
+	u8 temp_order;
 	int ret;
 
-	/* Get the first entry for the temp_path array */
-	ret = mtk_drm_of_get_ddp_ep_cid(dev, vdo, 0, cpath, &next, &temp_path[idx]);
+	dev_vdbg(dev, "Building DDP Path for CRTC%d\n", cpath);
+
+	if (controller_arch_v2) {
+		/* Check if the starting input is already a usable component */
+		ret = mtk_drm_of_get_first_input(dev, node, cpath, &temp_path[idx]);
+		if (ret == 0) {
+			idx++;
+		} else if (ret != -ENOENT) {
+			dev_err(dev, "Cannot parse first input HW component: %d\n", ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * Get the first remote for the temp_path array: for leader controllers
+	 * this will be an output, while for follower controllers this will be
+	 * an input from a DirectLink connection coming from either a leader or
+	 * a follower display controller.
+	 *
+	 * In case this is an input from any remote (leader/follower) controller
+	 * this will return EREMOTE and a different port (expressing a relay of
+	 * a crossbar) will be used to continue building the path.
+	 */
+	ret = mtk_drm_of_get_ddp_ep_cid(dev, node, 0, cpath, &next,
+					&temp_path[idx], controller_arch_v2);
+	if (ret == -EREMOTE) {
+		out_path->input_controller = mtk_drm_of_get_ep_external_controller(dev, next);
+
+		/*
+		 * Any follower controller gets the order set to 1 to avoid
+		 * iterating once again later when the actual full ordering
+		 * is calculated.
+		 */
+		temp_order = 1;
+		dev_dbg(dev, "Got external mmsys %pOF\n", out_path->input_controller);
+
+		ret = mtk_drm_of_get_ddp_ep_cid(dev, node, 2, cpath, &next,
+						&temp_path[idx], controller_arch_v2);
+	} else {
+		/* A leader controller gets, of course, its order set to 0 */
+		temp_order = 0;
+	}
+
 	if (ret) {
 		if (next && temp_path[idx].type == MTK_DISP_OVL_ADAPTOR) {
 			dev_dbg(dev, "Adding OVL Adaptor for %pOF\n", next);
@@ -743,7 +986,9 @@ static int mtk_drm_of_ddp_path_build_one(struct device *dev, enum mtk_crtc_path
 			if (next)
 				dev_err(dev, "Invalid component %pOF\n", next);
 			else
-				dev_err(dev, "Cannot find first endpoint for path %d\n", cpath);
+				dev_err(dev,
+					"Cannot find first endpoint for path %d on %pOF\n",
+					cpath, node);
 
 			return ret;
 		}
@@ -756,7 +1001,11 @@ static int mtk_drm_of_ddp_path_build_one(struct device *dev, enum mtk_crtc_path
 	 */
 	do {
 		prev = next;
-		ret = mtk_drm_of_get_ddp_ep_cid(dev, next, 1, cpath, &next, &temp_path[idx]);
+		ret = mtk_drm_of_get_ddp_ep_cid(dev, next, 1, cpath, &next,
+						&temp_path[idx], controller_arch_v2);
+		if (ret == -EREMOTE)
+			ret = mtk_drm_of_get_ddp_ep_cid(dev, prev, 3, cpath, &next,
+							&temp_path[idx], controller_arch_v2);
 		of_node_put(prev);
 		if (ret) {
 			dev_vdbg(dev, "Invalid comp reached with result %d\n", ret);
@@ -806,11 +1055,27 @@ static int mtk_drm_of_ddp_path_build_one(struct device *dev, enum mtk_crtc_path
 	if (!out_path->comp)
 		return -ENOMEM;
 
+	/*
+	 * Anything that is not the primary controller gets order set to 1:
+	 * this is done to avoid iterating once again later when the actual
+	 * full controllers ordering is calculated.
+	 */
+	out_path->order = temp_order;
+
 	dev_dbg(dev, "Display HW Pipeline built with %d components.\n", idx);
 
 	return 0;
 }
 
+static bool mtk_drm_of_ddp_is_arch_v2(struct device_node *cur_mmsys_node)
+{
+	for_each_child_of_node_scoped(cur_mmsys_node, mmsys_child)
+		if (of_property_present(mmsys_child, "compatible"))
+			return true;
+
+	return false;
+}
+
 static int mtk_drm_of_ddp_path_build(struct device *dev, struct device_node *node,
 				     struct mtk_mmsys_driver_data *data)
 {
@@ -819,8 +1084,15 @@ static int mtk_drm_of_ddp_path_build(struct device *dev, struct device_node *nod
 	struct of_endpoint of_ep;
 	bool output_present[MAX_CRTC] = { false };
 	u8 num_outputs_present = 0;
+	u8 num_outputs_skipped = 0;
+	bool controller_arch_v2;
 	int i, ret;
 
+	controller_arch_v2 = mtk_drm_of_ddp_is_arch_v2(dev->parent->of_node);
+
+	dev_dbg(dev, "Building Display Controller v%d Path starting from %pOF\n",
+		controller_arch_v2 ? 2 : 1, node);
+
 	for_each_endpoint_of_node(node, ep_node) {
 		ret = of_graph_parse_endpoint(ep_node, &of_ep);
 		if (ret) {
@@ -854,10 +1126,34 @@ static int mtk_drm_of_ddp_path_build(struct device *dev, struct device_node *nod
 		if (!output_present[i])
 			continue;
 
-		ret = mtk_drm_of_ddp_path_build_one(dev, i, &output_paths[i]);
-		if (ret && ret != -ENODEV)
-			return ret;
+		ret = mtk_drm_of_ddp_path_build_one(dev, node, i, &output_paths[i],
+						    controller_arch_v2);
+		/*
+		 * For -ENODEV, this could mean that the device is not yet registered,
+		 * but that may be just because of a probe deferral, so it is possible
+		 * to continue building the path as such failures are properly handled
+		 * later when enabling outputs.
+		 * For -ENOENT, it means that the devicetree declares a partial output
+		 * which is - of course - not okay, but failing entirely is a bit too
+		 * much: do a print to advertise invalid outputs, but fail probing
+		 * only if there is no valid output at all.
+		 */
+		if (ret && ret != -ENODEV) {
+			if (ret == -ENOENT) {
+				dev_dbg(dev, "Skipping invalid output for CRTC%u\n", i);
+				num_outputs_skipped++;
+			} else {
+				dev_err(dev, "Pipeline build failure on CRTC%u\n", i);
+				return ret;
+			}
+		}
+	}
+
+	if (num_outputs_skipped == num_outputs_present) {
+		dev_err(dev, "No valid display output found!\n");
+		return -ENOENT;
 	}
+
 	data->output_paths = output_paths;
 
 	return 0;
@@ -968,6 +1264,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 		}
 
 		ret = mtk_ddp_comp_init(dev, node, &private->hlist,
+					private->data->mmsys_id,
 					comp_type, comp_inst_id);
 		if (ret) {
 			of_node_put(node);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index 3f84384f8569..3c403bc8f4fe 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -39,7 +39,9 @@ struct mtk_drm_comp_definition {
 
 struct mtk_drm_path_definition {
 	const struct mtk_drm_comp_definition *comp;
+	struct device_node *input_controller;
 	u8 len;
+	u8 order;
 };
 
 struct mtk_mmsys_driver_data {
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_legacy.c b/drivers/gpu/drm/mediatek/mtk_drm_legacy.c
index 801e0ab43ff5..85bc432568f0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_legacy.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_legacy.c
@@ -873,6 +873,7 @@ void mtk_drm_legacy_ovl_adaptor_probe(struct device *dev, struct mtk_drm_private
 						    PLATFORM_DEVID_AUTO,
 						    (void *)priv, sizeof(*priv));
 
-	mtk_ddp_comp_init(&ovl_adaptor->dev, NULL, &priv->hlist, MTK_DISP_OVL_ADAPTOR, 0);
+	mtk_ddp_comp_init(&ovl_adaptor->dev, NULL, &priv->hlist, priv->data->mmsys_id,
+			  MTK_DISP_OVL_ADAPTOR, 0);
 	component_match_add(dev, match, component_compare_dev, &ovl_adaptor->dev);
 }
-- 
2.54.0

