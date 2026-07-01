Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE44C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B869D10EF73;
	Wed,  1 Jul 2026 12:21:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gFA8ps4C";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA5910EF77
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908508;
 bh=H0YjiKWbdllY47LT78hf1mUxnC6kw+S5TuNe9UzUjGs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gFA8ps4CmyshSg8UtgYk5WFdrKSwcprh5e+kAtvCQi644F2K7W5AvIjXYsxgJBrA9
 ourW3SHSY3pXlpddvj6v5Sehl+6EQTi5YIbwBzvT6kcq/deWdEiTmF3T15XLqA6hCl
 2sQ/zIfJSV1YaRHH3gIWbQDDCZ62bJ7OVgihCJqUYrFjvC+nkBx9DpQ9TXGM5WNnty
 Jrh9g6GKMccuJ6QM75Oa8a4PjGk2/Fpz55J2mBqFaPeK4XJYfTsCPCkwfPUoXnzM1F
 Ib1TWUhfZK16y1Xa+h+PtQHkhtEAK0JDxK2SMlv1Dcvfi6fo+qcxFvYRWTbmyXd/uL
 PiZYvMRVklQ3w==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EA61E17E35DB;
 Wed,  1 Jul 2026 14:21:46 +0200 (CEST)
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
Subject: [PATCH 34/42] drm/mediatek: Enable bring-up of multi-controller CRTC
 paths
Date: Wed,  1 Jul 2026 14:20:49 +0200
Message-ID: <20260701122057.19648-35-angelogioacchino.delregno@collabora.com>
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

Introduce support for actaully bringing up a full crtc path that
features multiple display controllers: this enables acquisition
and writing to multiple MMSYS and MuteX instances to connect the
multiple display controllers and enable trigger signals from the
various hardware sub-components at the same time.

This currently only works for rather rare display pipelines that
can make use of multi-controller without DirectLink architecture.

This change is also the final preparation to introduce support
for handling DirectLink Display Controller paths, found in the
MediaTek Kompanio Ultra MT8196, Genio Pro 5100 MT8894 and also
in the Dimensity 9400 MT6991, Dimensity 9500 MT6993 SoCs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c     | 519 ++++++++++++++++++------
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c |   6 +-
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h |   4 +
 3 files changed, 403 insertions(+), 126 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 3f70d11270e9..fb6ced49bb4a 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -45,6 +45,9 @@ struct mtk_crtc_hw_layer {
  * struct mtk_crtc - MediaTek specific crtc structure.
  * @base:            CRTC object
  * @enabled:         Records whether crtc_enable succeeded
+ * @controller_idmap:Array that maps a controller's MMSYS ID to mtk_crtc per-controller
+ *                   arrays indices; this array is counted by num_controllers.
+ * @num_controllers: Records number of display controllers used by this pipeline
  * @pending_needs_vblank: Records whether pending config operation needs a VBlank to finish
  * @event:           VBlank event to signal upon completion of state update
  * @hwlayers:        Array of mtk_crtc_hw_layer structures, one for each overlay plane
@@ -58,7 +61,7 @@ struct mtk_crtc_hw_layer {
  * @cb_blocking_queue: Wait queue for sending blocking command packet through CMDQ Mailbox
  * @mmsys_dev:       Pointer to the MMSYS device for configuration registers
  * @dma_dev:         Pointer to the DMA device (usually linked to an IOMMU)
- * @mutex:           Pointer to the MediaTek MuteX device for HW triggers mute/unmuting
+ * @mutex:           Pointer to the MediaTek MuteX devices for HW triggers mute/unmuting
  * @ddp_comp_nr:     Number of HW components in ddp_comp structure
  * @ddp_comp:        Array of HW components used in one Display Controller pipeline
  * @vblank_comp_idx: Index of HW component where to enable sending VBlanks
@@ -72,6 +75,8 @@ struct mtk_crtc_hw_layer {
 struct mtk_crtc {
 	struct drm_crtc			base;
 	bool				enabled;
+	u8				*controller_idmap;
+	u8				num_controllers;
 
 	bool				pending_needs_vblank;
 	struct drm_pending_vblank_event	*event;
@@ -91,7 +96,7 @@ struct mtk_crtc {
 
 	struct device			*mmsys_dev;
 	struct device			*dma_dev;
-	struct mtk_mutex		*mutex;
+	struct mtk_mutex		**mutex;
 	unsigned int			ddp_comp_nr;
 	struct mtk_ddp_comp		**ddp_comp;
 	s8				vblank_comp_idx;
@@ -161,7 +166,8 @@ static void mtk_crtc_destroy(struct drm_crtc *crtc)
 	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
 	int i;
 
-	mtk_mutex_put(mtk_crtc->mutex);
+	for (i = 0; i < mtk_crtc->num_controllers; i++)
+		mtk_mutex_put(mtk_crtc->mutex[i]);
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	if (mtk_crtc->cmdq_client.chan) {
 		cmdq_pkt_destroy(&mtk_crtc->cmdq_client, &mtk_crtc->cmdq_handle);
@@ -361,6 +367,64 @@ static void mtk_crtc_config_layer(struct mtk_crtc *mtk_crtc,
 	return;
 }
 
+static struct mtk_drm_private
+*mtk_crtc_get_comp_priv(struct mtk_crtc *mtk_crtc, struct mtk_ddp_comp *comp)
+{
+	struct drm_crtc *crtc = &mtk_crtc->base;
+	struct mtk_drm_private *main_priv = crtc->dev->dev_private;
+
+	for (int i = 0; i < main_priv->data->mmsys_dev_num; i++) {
+		struct mtk_drm_private *priv = main_priv->all_drm_private[i];
+		bool comp_found;
+
+		if (!priv)
+			continue;
+
+		comp_found = mtk_ddp_find_comp_dev_in_table(&priv->hlist,
+							    comp->type,
+							    comp->dev);
+		if (comp_found)
+			return priv;
+	}
+
+	drm_warn(mtk_crtc->base.dev,
+		 "Could not find priv for component %u-%u - trying with main...\n",
+		 comp->type, comp->inst_id);
+
+	return main_priv;
+}
+
+static struct mtk_drm_private
+*mtk_crtc_get_controller_priv(struct mtk_crtc *mtk_crtc, unsigned int controller_id)
+{
+	struct drm_crtc *crtc = &mtk_crtc->base;
+	struct mtk_drm_private *main_priv = crtc->dev->dev_private;
+
+	for (int i = 0; i < main_priv->data->mmsys_dev_num; i++) {
+		struct mtk_drm_private *priv = main_priv->all_drm_private[i];
+
+		if (priv->data->mmsys_id == controller_id)
+			return priv;
+	}
+
+	/* This should never happen */
+	drm_warn(mtk_crtc->base.dev,
+		 "Could not find priv for Controller %u - trying with main..\n",
+		 controller_id);
+
+	return main_priv;
+}
+
+static unsigned int mtk_crtc_get_controller_map_idx(struct mtk_crtc *mtk_crtc,
+						    unsigned int controller_id)
+{
+	for (int i = 0; i < mtk_crtc->num_controllers; i++)
+		if (mtk_crtc->controller_idmap[i] == controller_id)
+			return i;
+
+	return 0;
+}
+
 static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
 {
 	struct drm_crtc *crtc = &mtk_crtc->base;
@@ -371,6 +435,9 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
 	struct drm_dsc_config *dsc_cfg;
 	struct drm_device *dev = mtk_crtc->base.dev;
 	unsigned int width, height, vrefresh, bpc = MTK_MAX_BPC;
+	struct mtk_drm_private *priv;
+	struct mtk_mutex *mtk_mutex;
+	u8 mutex_idx;
 	int ret;
 	int i;
 
@@ -402,10 +469,12 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
 		return ret;
 	}
 
-	ret = mtk_mutex_prepare(mtk_crtc->mutex);
-	if (ret < 0) {
-		drm_err(dev, "Failed to enable mutex clock: %d\n", ret);
-		goto err_pm_runtime_put;
+	for (i = 0; i < mtk_crtc->num_controllers; i++) {
+		ret = mtk_mutex_prepare(mtk_crtc->mutex[i]);
+		if (ret < 0) {
+			drm_err(dev, "Failed to enable mutex clock: %d\n", ret);
+			goto err_pm_runtime_put;
+		}
 	}
 
 	ret = mtk_crtc_ddp_clk_enable(mtk_crtc);
@@ -417,14 +486,21 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
 	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
 		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
 		struct mtk_ddp_comp *next = mtk_crtc->ddp_comp[i + 1];
+		struct device *mmsys_dev;
+
+		priv = mtk_crtc_get_comp_priv(mtk_crtc, comp);
+		mutex_idx = mtk_crtc_get_controller_map_idx(mtk_crtc,
+							    priv->data->mmsys_id);
+		mtk_mutex = mtk_crtc->mutex[mutex_idx];
+		mmsys_dev = priv->mmsys_dev;
 
-		if (!mtk_ddp_comp_connect(comp, mtk_crtc->mmsys_dev, next))
-			mtk_mmsys_hw_connect(mtk_crtc->mmsys_dev,
+		if (!mtk_ddp_comp_connect(comp, mmsys_dev, next))
+			mtk_mmsys_hw_connect(mmsys_dev,
 					     comp->type, comp->inst_id,
 					     next->type, next->inst_id);
 
-		if (!mtk_ddp_comp_add(comp, mtk_crtc->mutex))
-			mtk_mutex_add_trigger(mtk_crtc->mutex,
+		if (!mtk_ddp_comp_add(comp, mtk_mutex))
+			mtk_mutex_add_trigger(mtk_mutex,
 					      comp->type, comp->inst_id,
 					      comp->mtx_trig_id);
 
@@ -435,13 +511,19 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
 		if (comp->type == MTK_DISP_DSC && !comp_dsc)
 			comp_dsc = mtk_crtc->ddp_comp[i];
 	}
-	if (!mtk_ddp_comp_add(mtk_crtc->ddp_comp[i], mtk_crtc->mutex))
-		mtk_mutex_add_trigger(mtk_crtc->mutex,
+
+	priv = mtk_crtc_get_comp_priv(mtk_crtc, mtk_crtc->ddp_comp[i]);
+	mutex_idx = mtk_crtc_get_controller_map_idx(mtk_crtc, priv->data->mmsys_id);
+	mtk_mutex = mtk_crtc->mutex[mutex_idx];
+
+	if (!mtk_ddp_comp_add(mtk_crtc->ddp_comp[i], mtk_mutex))
+		mtk_mutex_add_trigger(mtk_mutex,
 				      mtk_crtc->ddp_comp[i]->type,
 				      mtk_crtc->ddp_comp[i]->inst_id,
 				      mtk_crtc->ddp_comp[i]->mtx_trig_id);
 
-	mtk_mutex_enable(mtk_crtc->mutex);
+	for (i = 0; i < mtk_crtc->num_controllers; i++)
+		mtk_mutex_enable(mtk_crtc->mutex[i]);
 
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
 		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
@@ -476,7 +558,8 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
 	return 0;
 
 err_mutex_unprepare:
-	mtk_mutex_unprepare(mtk_crtc->mutex);
+	for (i = 0; i < mtk_crtc->num_controllers; i++)
+		mtk_mutex_unprepare(mtk_crtc->mutex[i]);
 err_pm_runtime_put:
 	pm_runtime_put(crtc->dev->dev);
 	return ret;
@@ -486,44 +569,72 @@ static void mtk_crtc_ddp_hw_fini(struct mtk_crtc *mtk_crtc)
 {
 	struct drm_device *drm = mtk_crtc->base.dev;
 	struct drm_crtc *crtc = &mtk_crtc->base;
+	struct mtk_drm_private *priv;
+	struct mtk_mutex *mtk_mutex;
 	unsigned long flags;
+	u8 mutex_idx;
 	int i;
 
+
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
 		mtk_ddp_comp_stop(mtk_crtc->ddp_comp[i]);
 		if (i == 1)
 			mtk_ddp_comp_bgclr_in_off(mtk_crtc->ddp_comp[i]);
 	}
 
-	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
-		if (!mtk_ddp_comp_remove(mtk_crtc->ddp_comp[i], mtk_crtc->mutex))
-			mtk_mutex_remove_trigger(mtk_crtc->mutex,
+	for (i = 0; i < mtk_crtc->num_controllers; i++)
+		mtk_mutex_disable(mtk_crtc->mutex[i]);
+
+	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
+		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
+
+		priv = mtk_crtc_get_comp_priv(mtk_crtc, comp);
+		mutex_idx = mtk_crtc_get_controller_map_idx(mtk_crtc,
+							    priv->data->mmsys_id);
+		mtk_mutex = mtk_crtc->mutex[mutex_idx];
+
+		if (!mtk_ddp_comp_remove(mtk_crtc->ddp_comp[i], mtk_mutex))
+			mtk_mutex_remove_trigger(mtk_mutex,
 						 mtk_crtc->ddp_comp[i]->type,
 						 mtk_crtc->ddp_comp[i]->inst_id,
 						 mtk_crtc->ddp_comp[i]->mtx_trig_id);
-	mtk_mutex_disable(mtk_crtc->mutex);
+	}
+
 	for (i = 0; i < mtk_crtc->ddp_comp_nr - 1; i++) {
 		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
 		struct mtk_ddp_comp *next = mtk_crtc->ddp_comp[i + 1];
+		struct device *mmsys_dev;
+
+		priv = mtk_crtc_get_comp_priv(mtk_crtc, comp);
+		mutex_idx = mtk_crtc_get_controller_map_idx(mtk_crtc,
+							    priv->data->mmsys_id);
+		mtk_mutex = mtk_crtc->mutex[mutex_idx];
+		mmsys_dev = priv->mmsys_dev;
 
-		if (!mtk_ddp_comp_disconnect(comp, mtk_crtc->mmsys_dev, next))
-			mtk_mmsys_hw_disconnect(mtk_crtc->mmsys_dev,
+		if (!mtk_ddp_comp_disconnect(comp, mmsys_dev, next))
+			mtk_mmsys_hw_disconnect(mmsys_dev,
 						comp->type, comp->inst_id,
 						next->type, next->inst_id);
 
-		if (!mtk_ddp_comp_remove(mtk_crtc->ddp_comp[i], mtk_crtc->mutex))
-			mtk_mutex_remove_trigger(mtk_crtc->mutex,
+		if (!mtk_ddp_comp_remove(mtk_crtc->ddp_comp[i], mtk_mutex))
+			mtk_mutex_remove_trigger(mtk_mutex,
 						 mtk_crtc->ddp_comp[i]->type,
 						 mtk_crtc->ddp_comp[i]->inst_id,
 						 mtk_crtc->ddp_comp[i]->mtx_trig_id);
 	}
-	if (!mtk_ddp_comp_remove(mtk_crtc->ddp_comp[i], mtk_crtc->mutex))
-		mtk_mutex_remove_trigger(mtk_crtc->mutex,
+	priv = mtk_crtc_get_comp_priv(mtk_crtc, mtk_crtc->ddp_comp[i]);
+	mutex_idx = mtk_crtc_get_controller_map_idx(mtk_crtc, priv->data->mmsys_id);
+	mtk_mutex = mtk_crtc->mutex[mutex_idx];
+	if (!mtk_ddp_comp_remove(mtk_crtc->ddp_comp[i], mtk_mutex))
+		mtk_mutex_remove_trigger(mtk_mutex,
 					 mtk_crtc->ddp_comp[i]->type,
 					 mtk_crtc->ddp_comp[i]->inst_id,
 					 mtk_crtc->ddp_comp[i]->mtx_trig_id);
+
 	mtk_crtc_ddp_clk_disable(mtk_crtc);
-	mtk_mutex_unprepare(mtk_crtc->mutex);
+
+	for (i = 0; i < mtk_crtc->num_controllers; i++)
+		mtk_mutex_unprepare(mtk_crtc->mutex[i]);
 
 	pm_runtime_put(drm->dev);
 
@@ -640,9 +751,13 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 		mtk_crtc->pending_async_planes = true;
 
 	if (priv->data->shadow_register) {
-		mtk_mutex_acquire(mtk_crtc->mutex);
+		for (i = 0; i < mtk_crtc->num_controllers; i++)
+			mtk_mutex_acquire(mtk_crtc->mutex[i]);
+
 		mtk_crtc_ddp_config(crtc, NULL);
-		mtk_mutex_release(mtk_crtc->mutex);
+
+		for (i = 0; i < mtk_crtc->num_controllers; i++)
+			mtk_mutex_release(mtk_crtc->mutex[i]);
 	}
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 	if (mtk_crtc->cmdq_client.chan) {
@@ -959,8 +1074,8 @@ static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
 	.atomic_disable	= mtk_crtc_atomic_disable,
 };
 
-static int mtk_crtc_init(struct drm_device *drm, struct mtk_crtc *mtk_crtc,
-			 unsigned int pipe)
+static int mtk_crtc_init_drm_crtc(struct drm_device *drm, struct mtk_crtc *mtk_crtc,
+				  unsigned int pipe)
 {
 	struct drm_plane *primary = NULL;
 	struct drm_plane *cursor = NULL;
@@ -1131,21 +1246,13 @@ struct device *mtk_crtc_dma_dev_get(struct drm_crtc *crtc)
 	return mtk_crtc->dma_dev;
 }
 
-static int mtk_crtc_find_suitable_dma_dev(struct mtk_drm_private *priv,
-					  struct mtk_crtc *mtk_crtc,
-					  const struct mtk_drm_path_definition *path)
+static int mtk_crtc_find_suitable_dma_dev(struct mtk_crtc *mtk_crtc)
 {
 	struct mtk_ddp_comp *dma_comp = NULL, *dma_comp_mmu = NULL;
 	int i;
 
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
-		const struct mtk_drm_comp_definition *cdef = path[i].comp;
-		struct mtk_ddp_comp *comp;
-
-		comp = mtk_ddp_comp_find_by_id(&priv->hlist,
-					       cdef->type, cdef->inst_id);
-		if (!comp)
-			continue;
+		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
 
 		/*
 		 * Check if this is a legacy OVL_ADAPTOR component and, if so, this
@@ -1185,120 +1292,263 @@ static int mtk_crtc_find_suitable_dma_dev(struct mtk_drm_private *priv,
 	return 0;
 }
 
+static int mtk_crtc_init_multi_controller_properties(struct device *dev,
+						     struct mtk_crtc *mtk_crtc)
+{
+	struct drm_crtc *crtc = &mtk_crtc->base;
+	unsigned long controllers_mask = 0;
+	struct mtk_drm_private *priv;
+	unsigned int i, j, k, z;
+
+	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
+		u8 controller_id = mtk_crtc->ddp_comp[i]->controller_id;
+
+		if (controller_id > MTK_DISP_CONTROLLER_MAX_CONTROLLERS_NUM) {
+			dev_err(mtk_crtc->mmsys_dev, "Bad controller ID %u\n",
+				controller_id);
+			return -EINVAL;
+		}
+
+		if (!(controllers_mask & BIT(controller_id)))
+			mtk_crtc->num_controllers++;
+
+		controllers_mask |= BIT(controller_id);
+
+	}
+
+	mtk_crtc->controller_idmap = devm_kmalloc_array(dev, mtk_crtc->num_controllers,
+							sizeof(*mtk_crtc->controller_idmap),
+							GFP_KERNEL | __GFP_ZERO);
+	if (!mtk_crtc->controller_idmap)
+		return -ENOMEM;
+
+	dev_info(dev, "Bringing up %d Display Controllers for CRTC %u\n",
+		 mtk_crtc->num_controllers, crtc->base.id);
+
+	/* Shortcut: if this is a single controller pipelines, avoid iterating */
+	if (mtk_crtc->num_controllers == 1) {
+		mtk_crtc->controller_idmap[0] = mtk_crtc->ddp_comp[0]->controller_id;
+		return 0;
+	}
+
+	priv = crtc->dev->dev_private;
+
+	for_each_set_bit(i, &controllers_mask, MTK_DISP_CONTROLLER_MAX_CONTROLLERS_NUM) {
+		for (j = 0; j < mtk_crtc->ddp_comp_nr; j++) {
+			struct mtk_drm_private *controller_priv;
+
+			if (mtk_crtc->ddp_comp[j]->controller_id != i)
+				continue;
+
+			/* Find the matching Controller ID's mmsys device */
+			for (k = 0; k < priv->data->mmsys_dev_num; k++) {
+				controller_priv = priv->all_drm_private[k];
+
+				if (controller_priv->data->mmsys_id ==
+				    mtk_crtc->ddp_comp[j]->controller_id)
+					break;
+			}
+			if (k == priv->data->mmsys_dev_num)
+				continue;
+
+			mtk_crtc->controller_idmap[z] = mtk_crtc->ddp_comp[j]->controller_id;
+			z++;
+
+			/*
+			 * If this is a multi-controller path, link the follower
+			 * with the leader controller to make sure that any call
+			 * to Runtime PM acts on both.
+			 */
+			if (controller_priv->mmsys_dev != mtk_crtc->mmsys_dev)
+				device_link_add(controller_priv->mmsys_dev,
+						mtk_crtc->mmsys_dev,
+						DL_FLAG_PM_RUNTIME);
+
+			if (controller_priv->mutex_dev != priv->mutex_dev)
+				device_link_add(controller_priv->mutex_dev,
+						priv->mutex_dev,
+						DL_FLAG_PM_RUNTIME);
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int mtk_crtc_init_mutex(struct device *dev, struct mtk_crtc *mtk_crtc)
+{
+	unsigned int i;
+	int ret;
+
+	mtk_crtc->mutex = devm_kmalloc_array(dev, mtk_crtc->num_controllers,
+					     sizeof(*mtk_crtc->mutex), GFP_KERNEL);
+	if (!mtk_crtc->mutex)
+		return -ENOMEM;
+
+	for (i = 0; i < mtk_crtc->num_controllers; i++) {
+		u8 controller_num = mtk_crtc->controller_idmap[i];
+		struct mtk_drm_private *priv = mtk_crtc_get_controller_priv(mtk_crtc, controller_num);
+
+		if (!priv)
+			return -ENODEV;
+
+		mtk_crtc->mutex[i] = mtk_mutex_get(priv->mutex_dev);
+		if (IS_ERR(mtk_crtc->mutex[i])) {
+			ret = PTR_ERR(mtk_crtc->mutex[i]);
+			dev_err(dev, "Failed to get Controller %u MuteX: %d\n", i, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 int mtk_crtc_create(struct drm_device *drm_dev,
 		    enum mtk_crtc_path path_sel, int priv_data_index,
 		    const struct mtk_drm_route *conn_routes,
 		    unsigned int num_conn_routes)
 {
 	struct mtk_drm_private *priv = drm_dev->dev_private;
-	const struct mtk_drm_path_definition *output_path;
 	struct device *dev = drm_dev->dev;
 	struct mtk_crtc *mtk_crtc;
 	unsigned int num_comp_planes = 0;
 	unsigned int max_comp_stages = 0;
+	unsigned int output_path_len = 0;
 	int ret;
-	int i, j;
+	int i, j, k;
 	bool has_ctm = false;
 	uint gamma_lut_size = 0;
 	struct drm_crtc *tmp;
 	int crtc_i = 0;
 
 	priv = priv->all_drm_private[priv_data_index];
-	output_path = &priv->data->output_paths[path_sel];
 
 	drm_for_each_crtc(tmp, drm_dev)
 		crtc_i++;
 
-	for (i = 0; i < output_path[i].len; i++) {
-		enum mtk_ddp_comp_type comp_type = output_path->comp[i].type;
-		u8 comp_inst = output_path->comp[i].inst_id;
-		struct mtk_ddp_comp *comp;
+	for (j = 0; j < priv->data->mmsys_dev_num; j++) {
+		for (k = 0; k < priv->data->mmsys_dev_num; k++) {
+			struct mtk_drm_private *subsys_priv = priv->all_drm_private[k];
+			const struct mtk_drm_path_definition *ctrlr_path;
 
-		comp = mtk_ddp_comp_find_by_id(&priv->hlist, comp_type, comp_inst);
-		if (!comp || !comp->dev) {
-			dev_err(dev,
-				"CRTC%d: Component type=%u inst=%u not initialized\n",
-				crtc_i, comp_type, comp_inst);
-			return -ENODEV;
+			if (!subsys_priv)
+				continue;
+
+			ctrlr_path = &subsys_priv->data->output_paths[path_sel];
+			if (j != ctrlr_path->order)
+				continue;
+
+			output_path_len += ctrlr_path->len;
 		}
 	}
+	if (!output_path_len)
+		return 0;
 
 	mtk_crtc = devm_kzalloc(dev, sizeof(*mtk_crtc), GFP_KERNEL);
 	if (!mtk_crtc)
 		return -ENOMEM;
 
 	mtk_crtc->mmsys_dev = priv->mmsys_dev;
-	mtk_crtc->ddp_comp_nr = output_path->len;
+	mtk_crtc->ddp_comp_nr = output_path_len;
 	mtk_crtc->ddp_comp = devm_kcalloc(dev,
 					  mtk_crtc->ddp_comp_nr + (conn_routes ? 1 : 0),
 					  sizeof(*mtk_crtc->ddp_comp),
 					  GFP_KERNEL);
-	if (!mtk_crtc->ddp_comp)
-		return -ENOMEM;
+	if (!mtk_crtc->ddp_comp) {
+		ret = -ENOMEM;
+		goto err_free_crtc;
+	}
 
-	mtk_crtc->mutex = mtk_mutex_get(priv->mutex_dev);
-	if (IS_ERR(mtk_crtc->mutex)) {
-		ret = PTR_ERR(mtk_crtc->mutex);
-		dev_err(dev, "Failed to get mutex: %d\n", ret);
-		return ret;
+	/*
+	 * Reusing path_len to initialize the structure in the next loop to
+	 * reduce stack size of this function at least a little.
+	 */
+	output_path_len = 0;
+
+	for (j = 0; j < priv->data->mmsys_dev_num; j++) {
+		for (k = 0; k < priv->data->mmsys_dev_num; k++) {
+			struct mtk_drm_private *subsys_priv = priv->all_drm_private[k];
+			const struct mtk_drm_path_definition *ctrlr_path;
+
+			subsys_priv = priv->all_drm_private[k];
+			if (!subsys_priv)
+				continue;
+
+			ctrlr_path = &subsys_priv->data->output_paths[path_sel];
+
+			if (!ctrlr_path->len || ctrlr_path->order != j)
+				continue;
+
+			for (i = 0; i < ctrlr_path->len; i++) {
+				struct mtk_ddp_comp *comp;
+
+				comp = mtk_ddp_comp_find_by_id(&subsys_priv->hlist,
+							       ctrlr_path->comp[i].type,
+							       ctrlr_path->comp[i].inst_id);
+				if (!comp || !comp->dev) {
+					dev_err(dev,
+						"CRTC%d: Component %u-%u not initialized\n",
+						crtc_i, ctrlr_path->comp[i].type,
+						ctrlr_path->comp[i].inst_id);
+					ret = -ENODEV;
+					goto err_free_ddp_comp;
+				}
+				mtk_crtc->ddp_comp[output_path_len] = comp;
+				output_path_len++;
+			}
+		}
 	}
 
 	/* Component 0 would be valid so initialize vblank and config idx to -EINVAL */
 	mtk_crtc->vblank_comp_idx = -EINVAL;
 	mtk_crtc->config_comp_idx = -EINVAL;
 
-	for (i = 0, j = 0; i < mtk_crtc->ddp_comp_nr; i++, j++) {
-		enum mtk_ddp_comp_type comp_type = output_path->comp[i].type;
-		u8 comp_inst = output_path->comp[i].inst_id;
-		struct mtk_ddp_comp *comp;
+	for (j = 0; j < mtk_crtc->ddp_comp_nr; j++) {
+		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[j];
 
-		comp = mtk_ddp_comp_find_by_id(&priv->hlist, comp_type, comp_inst);
-		if (!comp) {
-			j--;
-			dev_dbg(dev, "Cannot find component %u-%u.\n", comp_type, comp_inst);
+		if (!comp->funcs)
 			continue;
-		}
-		mtk_crtc->ddp_comp[j] = comp;
 
-		if (comp->funcs) {
-			if (comp->funcs->gamma_set && comp->funcs->gamma_get_lut_size) {
-				unsigned int lut_sz = mtk_ddp_gamma_get_lut_size(comp);
+		if (comp->funcs->gamma_set && comp->funcs->gamma_get_lut_size) {
+			unsigned int lut_sz = mtk_ddp_gamma_get_lut_size(comp);
 
-				if (lut_sz)
-					gamma_lut_size = lut_sz;
-			}
+			if (lut_sz)
+				gamma_lut_size = lut_sz;
+		}
 
-			if (comp->funcs->ctm_set)
-				has_ctm = true;
+		if (comp->funcs->ctm_set)
+			has_ctm = true;
 
-			/*
-			 * Assumes that there can only be one vblank enabler per CRTC,
-			 * and that should there be more than one, the one that should
-			 * handle vblanks has to be the bottom-most HW component.
-			 */
-			if (mtk_crtc->vblank_comp_idx < 0 && comp->funcs->enable_vblank)
-				mtk_crtc->vblank_comp_idx = j;
+		/*
+		 * Assumes that there can only be one vblank enabler per CRTC,
+		 * and that should there be more than one, the one that should
+		 * handle vblanks has to be the bottom-most HW component.
+		 */
+		if (mtk_crtc->vblank_comp_idx < 0 && comp->funcs->enable_vblank)
+			mtk_crtc->vblank_comp_idx = j;
 
-			/*
-			 * Assumes that there can only be one main configuration
-			 * component per CRTC, and that if more than one has to
-			 * be configured for at each frame, the main one would
-			 * take care of the config chain.
-			 *
-			 * As a note, such component has specific characteristics:
-			 * - It is configurable, and supports per-layer properties;
-			 * - It is a main layer component and not a layer stage;
-			 * - It is always the first one (the bottom-most) in the
-			 *   pipeline that has the characteristics explaned above.
-			 *
-			 * Such hardware is usually an OVL, RDMA or exDMA.
-			 *
-			 * This may change in the future with more complex pipelines.
-			 */
-			if (mtk_crtc->config_comp_idx < 0 && comp->funcs->config &&
-			    comp->funcs->layer_config && comp->funcs->layer_nr)
-				mtk_crtc->config_comp_idx = j;
-		}
+		/*
+		 * Assumes that there can only be one main configuration
+		 * component per CRTC, and that if more than one has to
+		 * be configured for at each frame, the main one would
+		 * take care of the config chain.
+		 *
+		 * As a note, such component has specific characteristics:
+		 * - It is configurable, and supports per-layer properties;
+		 * - It is a main layer component and not a layer stage;
+		 * - It is always the first one (the bottom-most) in the
+		 *   pipeline that has the characteristics explaned above.
+		 *
+		 * Such hardware is usually an OVL, RDMA or exDMA.
+		 *
+		 * This may change in the future with more complex pipelines.
+		 */
+		if (mtk_crtc->config_comp_idx < 0 && comp->funcs->config &&
+		    comp->funcs->layer_config && comp->funcs->layer_nr)
+			mtk_crtc->config_comp_idx = j;
+
+		num_comp_planes += mtk_ddp_comp_layer_nr(comp, 0);
+		max_comp_stages = MAX(mtk_ddp_comp_stage_nr(comp), max_comp_stages);
 
 		mtk_ddp_comp_register_vblank_cb(comp, mtk_crtc_ddp_irq,
 						&mtk_crtc->base);
@@ -1306,7 +1556,8 @@ int mtk_crtc_create(struct drm_device *drm_dev,
 
 	if (mtk_crtc->config_comp_idx < 0) {
 		dev_err(dev, "No HW component for layer configuration. Bailing out.\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free_ddp_comp;
 	}
 
 	if (mtk_crtc->vblank_comp_idx < 0) {
@@ -1314,13 +1565,6 @@ int mtk_crtc_create(struct drm_device *drm_dev,
 		mtk_crtc->vblank_comp_idx = 0;
 	}
 
-	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
-		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
-
-		num_comp_planes += mtk_ddp_comp_layer_nr(comp, 0);
-		max_comp_stages = MAX(mtk_ddp_comp_stage_nr(comp), max_comp_stages);
-	}
-
 	/*
 	 * On the older and/or simpler display controllers, each layer is single
 	 * stage, while newer ones are more complex and may have multiple stages
@@ -1335,43 +1579,55 @@ int mtk_crtc_create(struct drm_device *drm_dev,
 	mtk_crtc->hwlayers = devm_kcalloc(dev, num_comp_planes,
 					  sizeof(*mtk_crtc->hwlayers),
 					  GFP_KERNEL);
-	if (!mtk_crtc->hwlayers)
-		return -ENOMEM;
+	if (!mtk_crtc->hwlayers) {
+		ret = -ENOMEM;
+		goto err_free_ddp_comp;
+	}
 
 	for (i = 0; i < num_comp_planes; i++) {
 		struct mtk_crtc_hw_layer *comp_plane = &mtk_crtc->hwlayers[i];
 		comp_plane->layer_stages = devm_kcalloc(dev, max_comp_stages,
 							sizeof(*comp_plane->layer_stages),
 							GFP_KERNEL);
-		if (!comp_plane->layer_stages)
-			return -ENOMEM;
+		if (!comp_plane->layer_stages) {
+			ret = -ENOMEM;
+			goto err_free_layer_stages;
+		}
 	}
 
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
 		ret = mtk_crtc_init_comp_planes(drm_dev, mtk_crtc, i, crtc_i);
 		if (ret)
-			return ret;
+			goto err_free_layer_stages;
 	}
 
 	/* Initialize multi-stage only if present */
 	if (max_comp_stages > 1) {
 		ret = mtk_crtc_init_layer_stages(mtk_crtc);
 		if (ret)
-			return ret;
+			goto err_free_layer_stages;
 	}
 	dev_dbg(dev, "Found %u layers composed by maximum of %u stage(s) each.\n",
 		mtk_crtc->hwlayer_nr, max_comp_stages);
 
-	ret = mtk_crtc_find_suitable_dma_dev(priv, mtk_crtc, output_path);
+	ret = mtk_crtc_find_suitable_dma_dev(mtk_crtc);
 	if (ret) {
 		dev_err(dev, "Could not find appropriate DMA device!\n");
 		return -EINVAL;
 	}
 	dev_dbg(dev, "Using DMA device %pOF\n", mtk_crtc->dma_dev->of_node);
 
-	ret = mtk_crtc_init(drm_dev, mtk_crtc, crtc_i);
+	ret = mtk_crtc_init_drm_crtc(drm_dev, mtk_crtc, crtc_i);
 	if (ret < 0)
-		return ret;
+		goto err_free_layer_stages;
+
+	ret = mtk_crtc_init_multi_controller_properties(dev, mtk_crtc);
+	if (ret)
+		goto err_free_layer_stages;
+
+	ret = mtk_crtc_init_mutex(dev, mtk_crtc);
+	if (ret)
+		goto err_free_idmap;
 
 	if (gamma_lut_size)
 		drm_mode_crtc_set_gamma_size(&mtk_crtc->base, gamma_lut_size);
@@ -1448,4 +1704,21 @@ int mtk_crtc_create(struct drm_device *drm_dev,
 	}
 
 	return 0;
+
+err_free_idmap:
+	devm_kfree(dev, mtk_crtc->controller_idmap);
+err_free_layer_stages:
+	for (i = 0; i < num_comp_planes; i++) {
+		struct mtk_crtc_hw_layer *comp_plane = &mtk_crtc->hwlayers[i];
+
+		if (comp_plane->layer_stages)
+			devm_kfree(dev, comp_plane->layer_stages);
+	}
+	devm_kfree(dev, mtk_crtc->hwlayers);
+err_free_ddp_comp:
+	devm_kfree(dev, mtk_crtc->ddp_comp);
+err_free_crtc:
+	devm_kfree(dev, mtk_crtc);
+
+	return ret;
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index 3f25f1c34633..a305b5f6a42d 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -505,9 +505,9 @@ static const struct mtk_ddp_comp_funcs *mtk_ddp_funcs[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_DVO]			= &ddp_dvo,
 };
 
-static bool mtk_ddp_find_comp_dev_in_table(const struct mtk_drm_comp_list *hlist,
-					   const unsigned int comp_type,
-					   struct device *dev)
+bool mtk_ddp_find_comp_dev_in_table(const struct mtk_drm_comp_list *hlist,
+				    const unsigned int comp_type,
+				    struct device *dev)
 {
 	struct mtk_ddp_comp *ddp_comp;
 
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
index e94bcf6922c1..165bf83ccd10 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
@@ -15,6 +15,7 @@
 
 #include <drm/drm_modes.h>
 
+#define MTK_DISP_CONTROLLER_MAX_CONTROLLERS_NUM		7
 #define MTK_DISP_CONTROLLER_MAX_COMP_PER_PATH		24
 #define MTK_DISP_CONTROLLER_MAX_HW_COMP_INSTANCE	32
 
@@ -370,6 +371,9 @@ static inline struct mtk_ddp_comp
 	return NULL;
 }
 
+bool mtk_ddp_find_comp_dev_in_table(const struct mtk_drm_comp_list *hlist,
+				    const unsigned int comp_type,
+				    struct device *dev);
 bool mtk_ddp_comp_is_internal_comp(enum mtk_ddp_comp_type type);
 int mtk_ddp_comp_get_id(struct device_node *node,
 			enum mtk_ddp_comp_type comp_type);
-- 
2.54.0

