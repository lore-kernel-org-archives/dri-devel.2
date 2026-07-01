Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 751C6C44502
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E9210EF5D;
	Wed,  1 Jul 2026 12:21:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Am69PpRf";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B82510EF52
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908468;
 bh=ETeDveAi352+eUqFcbUcX+/+P02EOgq/WMfGuTgfLLA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Am69PpRfsFz2MPi2M4Ms+txFlBnqtOio1nSVjQSm2YWT9sWTgGxo4xKkoTBjdtDSo
 r8SkvyEIuT3gG0E7SutSjdDtbvp6PvPAarW96AKgEt6d1EwXZegJs6DqZOZ/CDvRk9
 YiWrv8SS2aLMQhKo07wtSEhGrKcbVwvDqsUhMCIMdeOhX0Qu3slFlDd8ySZeQsI8ok
 0g/gibsQPkdaUlK5YuHMj1D/2D8+gx+yeQHcNQmsr+ZxM2t9AyPHBU07hVhvP0fTu2
 mXfzr3plkasRO6DbnX7gcz3X42th4b0LD3Ga1SFuQgI0izNiWddIBGk9FgGpE5pPPD
 hKrbCHoW+siGA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0E86017E15A5;
 Wed,  1 Jul 2026 14:21:07 +0200 (CEST)
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
Subject: [PATCH 06/42] drm/mediatek: Use hashtable for components discovery
 and registration
Date: Wed,  1 Jul 2026 14:20:21 +0200
Message-ID: <20260701122057.19648-7-angelogioacchino.delregno@collabora.com>
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

As a preparation for refactoring the concept of hardware component
identification, search, and final usage, remove the ddp_comp array
of components and replace it with a hashtable, indexed by ID.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c     | 44 ++++++++++++++++-------
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c | 48 ++++++++++++++++++-------
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h | 23 +++++++++++-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  7 ++--
 drivers/gpu/drm/mediatek/mtk_drm_drv.h  |  2 +-
 5 files changed, 94 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index f39f197057a7..3f4d6ab1bfc2 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -725,8 +725,12 @@ static void mtk_crtc_update_output(struct drm_crtc *crtc,
 		crtc_state->connectors_changed, encoder_mask, crtc_index);
 
 	for (i = 0; i < mtk_crtc->num_conn_routes; i++) {
-		unsigned int comp_id = mtk_crtc->conn_routes[i].route_ddp;
-		struct mtk_ddp_comp *comp = &priv->ddp_comp[comp_id];
+		const struct mtk_drm_route *conn_route = &mtk_crtc->conn_routes[i];
+		struct mtk_ddp_comp *comp;
+
+		comp = mtk_ddp_comp_find_by_id(&priv->hlist, conn_route->route_ddp);
+		if (!comp)
+			continue;
 
 		if (comp->encoder_index >= 0 &&
 		    (encoder_mask & BIT(comp->encoder_index))) {
@@ -1028,10 +1032,11 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 {
 	struct mtk_drm_private *priv = drm_dev->dev_private;
 	struct device *dev = drm_dev->dev;
+	struct mtk_ddp_comp *dma_comp;
 	struct mtk_crtc *mtk_crtc;
 	unsigned int num_comp_planes = 0;
 	int ret;
-	int i;
+	int i, j;
 	bool has_ctm = false;
 	uint gamma_lut_size = 0;
 	struct drm_crtc *tmp;
@@ -1051,7 +1056,7 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 		struct mtk_ddp_comp *comp;
 
 		node = priv->comp_node[comp_id];
-		comp = &priv->ddp_comp[comp_id];
+		comp = mtk_ddp_comp_find_by_id(&priv->hlist, comp_id);
 
 		/* Not all drm components have a DTS device node, such as ovl_adaptor,
 		 * which is the drm bring up sub driver
@@ -1063,7 +1068,7 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 			return 0;
 		}
 
-		if (!comp->dev) {
+		if (!comp || !comp->dev) {
 			dev_err(dev, "Component %pOF not initialized\n", node);
 			return -ENODEV;
 		}
@@ -1089,12 +1094,17 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 		return ret;
 	}
 
-	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
+	for (i = 0, j = 0; i < mtk_crtc->ddp_comp_nr; i++, j++) {
 		unsigned int comp_id = path[i];
 		struct mtk_ddp_comp *comp;
 
-		comp = &priv->ddp_comp[comp_id];
-		mtk_crtc->ddp_comp[i] = comp;
+		comp = mtk_ddp_comp_find_by_id(&priv->hlist, comp_id);
+		if (!comp) {
+			j--;
+			dev_dbg(dev, "Cannot find component %d.\n", comp_id);
+			continue;
+		}
+		mtk_crtc->ddp_comp[j] = comp;
 
 		if (comp->funcs) {
 			if (comp->funcs->gamma_set && comp->funcs->gamma_get_lut_size) {
@@ -1131,7 +1141,14 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 	 * In the case of ovl_adaptor sub driver, it needs to use the
 	 * dma_dev_get function to get representative dma dev.
 	 */
-	mtk_crtc->dma_dev = mtk_ddp_comp_dma_dev_get(&priv->ddp_comp[path[0]]);
+	dma_comp = mtk_ddp_comp_find_by_id(&priv->hlist, path[0]);
+	if (dma_comp == NULL) {
+		dev_err(dev, "Could not find appropriate DMA device!\n");
+		return -EINVAL;
+	}
+
+	mtk_crtc->dma_dev = mtk_ddp_comp_dma_dev_get(dma_comp);
+	dev_dbg(dev, "Using DMA device %pOF\n", mtk_crtc->dma_dev->of_node);
 
 	ret = mtk_crtc_init(drm_dev, mtk_crtc, crtc_i);
 	if (ret < 0)
@@ -1188,17 +1205,18 @@ int mtk_crtc_create(struct drm_device *drm_dev, const unsigned int *path,
 		for (i = 0; i < num_conn_routes; i++) {
 			unsigned int comp_id = conn_routes[i].route_ddp;
 			struct device_node *node = priv->comp_node[comp_id];
-			struct mtk_ddp_comp *comp = &priv->ddp_comp[comp_id];
+			struct mtk_ddp_comp *comp = mtk_ddp_comp_find_by_id(&priv->hlist, comp_id);
 
-			if (!comp->dev) {
+			if (!comp || !comp->dev) {
 				dev_dbg(dev, "comp_id:%d, Component %pOF not initialized\n",
 					comp_id, node);
 				/* mark encoder_index to -1, if route comp device is not enabled */
-				comp->encoder_index = -1;
+				if (comp)
+					comp->encoder_index = -1;
 				continue;
 			}
 
-			mtk_ddp_comp_encoder_index_set(&priv->ddp_comp[comp_id]);
+			mtk_ddp_comp_encoder_index_set(comp);
 		}
 
 		mtk_crtc->num_conn_routes = num_conn_routes;
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index a6c1815ffa39..d716fd9f8a70 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -480,10 +480,24 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_DRM_ID_MAX]
 	[DDP_COMPONENT_WDMA1]		= { MTK_DISP_WDMA,		1, &ddp_wdma },
 };
 
+static bool mtk_ddp_find_comp_dev_in_table(const struct mtk_drm_comp_list *hlist,
+					   const unsigned int comp_id,
+					   struct device *dev)
+{
+	struct mtk_ddp_comp *ddp_comp;
+
+	hash_for_each_possible(hlist->ddp_list, ddp_comp, lnode, comp_id) {
+		if (ddp_comp->dev == dev)
+			return true;
+	}
+
+	return false;
+}
+
 static bool mtk_ddp_comp_find(struct device *dev,
 			      const unsigned int *path,
 			      unsigned int path_len,
-			      struct mtk_ddp_comp *ddp_comp)
+			      const struct mtk_drm_comp_list *hlist)
 {
 	unsigned int i;
 
@@ -491,7 +505,7 @@ static bool mtk_ddp_comp_find(struct device *dev,
 		return false;
 
 	for (i = 0U; i < path_len; i++)
-		if (dev == ddp_comp[path[i]].dev)
+		if (mtk_ddp_find_comp_dev_in_table(hlist, path[i], dev))
 			return true;
 
 	return false;
@@ -500,7 +514,7 @@ static bool mtk_ddp_comp_find(struct device *dev,
 static int mtk_ddp_comp_find_in_route(struct device *dev,
 				      const struct mtk_drm_route *routes,
 				      unsigned int num_routes,
-				      struct mtk_ddp_comp *ddp_comp)
+				      const struct mtk_drm_comp_list *hlist)
 {
 	unsigned int i;
 
@@ -508,7 +522,7 @@ static int mtk_ddp_comp_find_in_route(struct device *dev,
 		return -EINVAL;
 
 	for (i = 0; i < num_routes; i++)
-		if (dev == ddp_comp[routes[i].route_ddp].dev)
+		if (mtk_ddp_find_comp_dev_in_table(hlist, routes[i].route_ddp, dev))
 			return BIT(routes[i].crtc_id);
 
 	return -ENODEV;
@@ -566,7 +580,7 @@ int mtk_find_possible_crtcs(struct drm_device *drm, struct device *dev)
 					   priv_n->comp_node)) {
 			if (mtk_ddp_comp_find(dev, data->main_path,
 					      data->main_len,
-					      priv_n->ddp_comp))
+					      &priv_n->hlist))
 				return BIT(i);
 			i++;
 		}
@@ -575,7 +589,7 @@ int mtk_find_possible_crtcs(struct drm_device *drm, struct device *dev)
 					   priv_n->comp_node)) {
 			if (mtk_ddp_comp_find(dev, data->ext_path,
 					      data->ext_len,
-					      priv_n->ddp_comp))
+					      &priv_n->hlist))
 				return BIT(i);
 			i++;
 		}
@@ -584,7 +598,7 @@ int mtk_find_possible_crtcs(struct drm_device *drm, struct device *dev)
 					   priv_n->comp_node)) {
 			if (mtk_ddp_comp_find(dev, data->third_path,
 					      data->third_len,
-					      priv_n->ddp_comp))
+					      &priv_n->hlist))
 				return BIT(i);
 			i++;
 		}
@@ -593,7 +607,7 @@ int mtk_find_possible_crtcs(struct drm_device *drm, struct device *dev)
 	ret = mtk_ddp_comp_find_in_route(dev,
 					 private->data->conn_routes,
 					 private->data->num_conn_routes,
-					 private->ddp_comp);
+					 &private->hlist);
 
 	if (ret < 0)
 		DRM_INFO("Failed to find comp in ddp table, ret = %d\n", ret);
@@ -615,10 +629,12 @@ static void mtk_ddp_comp_clk_put(void *_clk)
 	clk_put(clk);
 }
 
-int mtk_ddp_comp_init(struct device *dev, struct device_node *node, struct mtk_ddp_comp *comp,
+int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
+		      struct mtk_drm_comp_list *hlist,
 		      unsigned int comp_id)
 {
 	struct platform_device *comp_pdev;
+	struct mtk_ddp_comp *comp;
 	enum mtk_ddp_comp_type type;
 	struct mtk_ddp_comp_dev *priv;
 	int ret;
@@ -626,6 +642,10 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node, struct mtk_d
 	if (comp_id >= DDP_COMPONENT_DRM_ID_MAX)
 		return -EINVAL;
 
+	comp = devm_kzalloc(dev, sizeof(*comp), GFP_KERNEL);
+	if (!comp)
+		return -ENOMEM;
+
 	type = mtk_ddp_matches[comp_id].type;
 
 	comp->id = comp_id;
@@ -633,8 +653,10 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node, struct mtk_d
 	/* Not all drm components have a DTS device node, such as ovl_adaptor,
 	 * which is the drm bring up sub driver
 	 */
-	if (!node)
-		return 0;
+	if (!node) {
+		comp->dev = dev;
+		goto end;
+	}
 
 	comp_pdev = of_find_device_by_node(node);
 	if (!comp_pdev) {
@@ -662,7 +684,7 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node, struct mtk_d
 	    type == MTK_DISP_DPI ||
 	    type == MTK_DISP_DP_INTF ||
 	    type == MTK_DISP_DSI)
-		return 0;
+		goto end;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -687,6 +709,8 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node, struct mtk_d
 #endif
 
 	platform_set_drvdata(comp_pdev, priv);
+end:
+	hash_add(hlist->ddp_list, &comp->lnode, comp->id);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
index bbc66072fe6b..4203eecb2a7b 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
@@ -6,6 +6,7 @@
 #ifndef MTK_DDP_COMP_H
 #define MTK_DDP_COMP_H
 
+#include <linux/hashtable.h>
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/mediatek/mtk-cmdq.h>
@@ -24,6 +25,11 @@ struct drm_dsc_config;
 
 struct mtk_ddp_comp;
 struct cmdq_pkt;
+
+struct mtk_drm_comp_list {
+	DECLARE_HASHTABLE(ddp_list, 8);
+};
+
 struct mtk_ddp_comp_funcs {
 	int (*power_on)(struct device *dev);
 	void (*power_off)(struct device *dev);
@@ -75,6 +81,8 @@ struct mtk_ddp_comp {
 	unsigned int id;
 	int encoder_index;
 	const struct mtk_ddp_comp_funcs *funcs;
+
+	struct hlist_node lnode;
 };
 
 static inline int mtk_ddp_comp_power_on(struct mtk_ddp_comp *comp)
@@ -331,10 +339,23 @@ static inline void mtk_ddp_comp_encoder_index_set(struct mtk_ddp_comp *comp)
 		comp->encoder_index = (int)comp->funcs->encoder_index(comp->dev);
 }
 
+static inline struct mtk_ddp_comp
+*mtk_ddp_comp_find_by_id(struct mtk_drm_comp_list *hlist,
+			 const unsigned int id)
+{
+	struct mtk_ddp_comp *ddp_comp;
+
+	hash_for_each_possible(hlist->ddp_list, ddp_comp, lnode, id)
+		return ddp_comp;
+
+	return NULL;
+}
+
 int mtk_ddp_comp_get_id(struct device_node *node,
 			enum mtk_ddp_comp_type comp_type);
 int mtk_find_possible_crtcs(struct drm_device *drm, struct device *dev);
-int mtk_ddp_comp_init(struct device *dev, struct device_node *comp_node, struct mtk_ddp_comp *comp,
+int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
+		      struct mtk_drm_comp_list *hlist,
 		      unsigned int comp_id);
 enum mtk_ddp_comp_type mtk_ddp_comp_get_type(unsigned int comp_id);
 void mtk_ddp_write(struct cmdq_pkt *cmdq_pkt, unsigned int value,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 9c6dfc1e384b..e956e1966b86 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -1086,6 +1086,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
 	if (!mtk_drm_data)
 		return -EINVAL;
 
+	hash_init(private->hlist.ddp_list);
+
 	/* Try to build the display pipeline from devicetree graphs */
 	if (of_graph_is_present(phandle)) {
 		dev_dbg(dev, "Building display pipeline for MMSYS %u\n",
@@ -1116,8 +1118,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 							    PLATFORM_DEVID_AUTO,
 							    (void *)private->mmsys_dev,
 							    sizeof(*private->mmsys_dev));
-		private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR].dev = &ovl_adaptor->dev;
-		mtk_ddp_comp_init(dev, NULL, &private->ddp_comp[DDP_COMPONENT_DRM_OVL_ADAPTOR],
+		mtk_ddp_comp_init(&ovl_adaptor->dev, NULL, &private->hlist,
 				  DDP_COMPONENT_DRM_OVL_ADAPTOR);
 		component_match_add(dev, &match, compare_dev, &ovl_adaptor->dev);
 	}
@@ -1185,7 +1186,7 @@ static int mtk_drm_probe(struct platform_device *pdev)
 						   node);
 		}
 
-		ret = mtk_ddp_comp_init(dev, node, &private->ddp_comp[comp_id], comp_id);
+		ret = mtk_ddp_comp_init(dev, node, &private->hlist, comp_id);
 		if (ret) {
 			of_node_put(node);
 			goto err_node;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index 8b5c51d93f72..a171126d580e 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -60,8 +60,8 @@ struct mtk_drm_private {
 	struct device_node *mutex_node;
 	struct device *mutex_dev;
 	struct device *mmsys_dev;
+	struct mtk_drm_comp_list hlist;
 	struct device_node *comp_node[DDP_COMPONENT_DRM_ID_MAX];
-	struct mtk_ddp_comp ddp_comp[DDP_COMPONENT_DRM_ID_MAX];
 	struct mtk_mmsys_driver_data *data;
 	struct drm_atomic_commit *suspend_state;
 	unsigned int mbox_index;
-- 
2.54.0

