Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C417C44501
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1A210EF63;
	Wed,  1 Jul 2026 12:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DabRBmi8";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45CCC10EF62
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908479;
 bh=CKJ5I6uQ68CgKm/R3tnSMzhCWfvit4LoKchnHeA31KU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DabRBmi8JdJIjiChiC8W0O7EaR5IEubCqaB3LjjuhajgpAhwHb87ACr2Fp5d01/4Y
 tyIzBNTGEfcVCOPT2O2z/xF9z2qFYrhmi6Y2VFZ9GHcfL1zf0ZL0JIT08XxRfGnKot
 Zb7e3AfBdjP/nmYPjneBRWXd+Z9F8B+9MZT1DknUfCKMYpjrNjnio6ExYDHSa1euhd
 EFBVpyZYfUQl4A/sOluwdMKbfWEy/5QPzPB3s1ITUzyjLyYSvjqdgRhYg7mAwGTAqh
 36NAWoCdzQbFkhIil6wl45iAUHaI7h7B+Ko+j5RJ1VZzjABUPrOyHvbZ1YKoN0SUJV
 pTNTsLT6naxXQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A9CA117E0CF4;
 Wed,  1 Jul 2026 14:21:17 +0200 (CEST)
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
Subject: [PATCH 14/42] drm/mediatek: Add support for hardware multi-stage
 layers
Date: Wed,  1 Jul 2026 14:20:29 +0200
Message-ID: <20260701122057.19648-15-angelogioacchino.delregno@collabora.com>
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

In preparation for adding support for newer, more complex, display
controllers like the ones found in the MediaTek Kompanio Ultra and
Genio Pro 5100 (MT8196/MT8894), add support for multi-stage layers
as in newer hardware, there is a special strategy using multiple
hardware components of one (or multiple) display controller(s) to
form one single layer.

Multi-stage layers are one more step towards extra flexibility of
the Display Subsystem, making it possible to change capabilities
of Display Controller Pipelines depending on the final application
of a board: for example, one board may choose to use fewer layers
per pipeline to achieve more pipelines (more concurrent outputs),
or more layers to achieve less, but more capable (as in offloading
and in achievable bandwidth) concurrent outputs.

This currently adds boilerplate to support this hardware, but does
not yet implement the IP-specific support for MT8196/8894, which
will be done after all preparation is done.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c           | 304 ++++++++++++------
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h       |  15 +-
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       |  12 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  12 +-
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   |   2 +-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |   9 +-
 drivers/gpu/drm/mediatek/mtk_disp_wdma.c      |   2 +-
 7 files changed, 246 insertions(+), 110 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index 5e243550d35e..8656b56618a2 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/mailbox_controller.h>
+#include <linux/minmax.h>
 #include <linux/of.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/mediatek/mtk-cmdq.h>
@@ -28,12 +29,24 @@
 #include "mtk_drm_drv.h"
 #include "mtk_plane.h"
 
+/*
+ * struct mtk_crtc_hw_layer - MediaTek specific layer structure
+ * @plane:           DRM Plane
+ * @layer_stages:    HW Components layer stage indices to form one full layer/plane
+ * @layer_stages_nr: Number of layer stages in array
+ */
+struct mtk_crtc_hw_layer {
+	struct drm_plane plane;
+	u8 *layer_stages;
+	u8 layer_stages_nr;
+};
+
 /*
  * struct mtk_crtc - MediaTek specific crtc structure.
  * @base: crtc object.
  * @enabled: records whether crtc_enable succeeded
- * @planes: array of 4 drm_plane structures, one for each overlay plane
- * @pending_planes: whether any plane has pending changes to be applied
+ * @hwlayers:        Array of mtk_crtc_hw_layer structures, one for each overlay plane
+ * @hwlayer_nr:      Number of hwlayers
  * @mmsys_dev: pointer to the mmsys device for configuration registers
  * @mutex: handle to one of the ten disp_mutex streams
  * @ddp_comp_nr: number of components in ddp_comp
@@ -48,8 +61,8 @@ struct mtk_crtc {
 	bool				pending_needs_vblank;
 	struct drm_pending_vblank_event	*event;
 
-	struct drm_plane		*planes;
-	unsigned int			layer_nr;
+	struct mtk_crtc_hw_layer	*hwlayers;
+	unsigned int			hwlayer_nr;
 	bool				pending_planes;
 	bool				pending_async_planes;
 
@@ -254,29 +267,6 @@ static void mtk_crtc_ddp_clk_disable(struct mtk_crtc *mtk_crtc)
 		mtk_ddp_comp_clk_disable(mtk_crtc->ddp_comp[i]);
 }
 
-static
-struct mtk_ddp_comp *mtk_ddp_comp_for_plane(struct drm_crtc *crtc,
-					    struct drm_plane *plane,
-					    unsigned int *local_layer)
-{
-	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
-	struct mtk_ddp_comp *comp;
-	int i, count = 0;
-	unsigned int local_index = plane - mtk_crtc->planes;
-
-	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
-		comp = mtk_crtc->ddp_comp[i];
-		if (local_index < (count + mtk_ddp_comp_layer_nr(comp))) {
-			*local_layer = local_index - count;
-			return comp;
-		}
-		count += mtk_ddp_comp_layer_nr(comp);
-	}
-
-	WARN(1, "Failed to find component for plane %d\n", plane->index);
-	return NULL;
-}
-
 #if IS_REACHABLE(CONFIG_MTK_CMDQ)
 static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 {
@@ -303,8 +293,8 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 	state->pending_config = false;
 
 	if (mtk_crtc->pending_planes) {
-		for (i = 0; i < mtk_crtc->layer_nr; i++) {
-			struct drm_plane *plane = &mtk_crtc->planes[i];
+		for (i = 0; i < mtk_crtc->hwlayer_nr; i++) {
+			struct drm_plane *plane = &mtk_crtc->hwlayers[i].plane;
 			struct mtk_plane_state *plane_state;
 
 			plane_state = to_mtk_plane_state(plane->state);
@@ -315,8 +305,8 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 	}
 
 	if (mtk_crtc->pending_async_planes) {
-		for (i = 0; i < mtk_crtc->layer_nr; i++) {
-			struct drm_plane *plane = &mtk_crtc->planes[i];
+		for (i = 0; i < mtk_crtc->hwlayer_nr; i++) {
+			struct drm_plane *plane = &mtk_crtc->hwlayers[i].plane;
 			struct mtk_plane_state *plane_state;
 
 			plane_state = to_mtk_plane_state(plane->state);
@@ -340,6 +330,21 @@ static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
 }
 #endif
 
+static void mtk_crtc_config_layer(struct mtk_crtc *mtk_crtc,
+				  struct mtk_plane_state *plane_state,
+				  int layer_num, struct cmdq_pkt *cmdq_pkt)
+{
+	u8 *layer_stages = mtk_crtc->hwlayers[layer_num].layer_stages;
+	u8 i = 0;
+
+	do {
+		mtk_ddp_comp_layer_config(mtk_crtc->ddp_comp[layer_stages[i]],
+					  layer_num, plane_state, cmdq_pkt);
+	} while (++i < mtk_crtc->hwlayers[layer_num].layer_stages_nr);
+
+	return;
+}
+
 static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
 {
 	struct drm_crtc *crtc = &mtk_crtc->base;
@@ -436,20 +441,16 @@ static int mtk_crtc_ddp_hw_init(struct mtk_crtc *mtk_crtc)
 	}
 
 	/* Initially configure all planes */
-	for (i = 0; i < mtk_crtc->layer_nr; i++) {
-		struct drm_plane *plane = &mtk_crtc->planes[i];
+	for (i = 0; i < mtk_crtc->hwlayer_nr; i++) {
+		struct drm_plane *plane = &mtk_crtc->hwlayers[i].plane;
 		struct mtk_plane_state *plane_state;
-		struct mtk_ddp_comp *comp;
-		unsigned int local_layer;
 
 		plane_state = to_mtk_plane_state(plane->state);
 
 		/* should not enable layer before crtc enabled */
 		plane_state->pending.enable = false;
-		comp = mtk_ddp_comp_for_plane(crtc, plane, &local_layer);
-		if (comp)
-			mtk_ddp_comp_layer_config(comp, local_layer,
-						  plane_state, NULL);
+
+		mtk_crtc_config_layer(mtk_crtc, plane_state, i, NULL);
 	}
 
 	return 0;
@@ -511,7 +512,6 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc,
 	struct mtk_crtc_state *state = to_mtk_crtc_state(mtk_crtc->base.state);
 	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[0];
 	unsigned int i;
-	unsigned int local_layer;
 
 	/*
 	 * TODO: instead of updating the registers here, we should prepare
@@ -529,8 +529,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc,
 	}
 
 	if (mtk_crtc->pending_planes) {
-		for (i = 0; i < mtk_crtc->layer_nr; i++) {
-			struct drm_plane *plane = &mtk_crtc->planes[i];
+		for (i = 0; i < mtk_crtc->hwlayer_nr; i++) {
+			struct drm_plane *plane = &mtk_crtc->hwlayers[i].plane;
 			struct mtk_plane_state *plane_state;
 
 			plane_state = to_mtk_plane_state(plane->state);
@@ -538,12 +538,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc,
 			if (!plane_state->pending.config)
 				continue;
 
-			comp = mtk_ddp_comp_for_plane(crtc, plane, &local_layer);
+			mtk_crtc_config_layer(mtk_crtc, plane_state, i, cmdq_handle);
 
-			if (comp)
-				mtk_ddp_comp_layer_config(comp, local_layer,
-							  plane_state,
-							  cmdq_handle);
 			if (!cmdq_handle)
 				plane_state->pending.config = false;
 		}
@@ -553,8 +549,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc,
 	}
 
 	if (mtk_crtc->pending_async_planes) {
-		for (i = 0; i < mtk_crtc->layer_nr; i++) {
-			struct drm_plane *plane = &mtk_crtc->planes[i];
+		for (i = 0; i < mtk_crtc->hwlayer_nr; i++) {
+			struct drm_plane *plane = &mtk_crtc->hwlayers[i].plane;
 			struct mtk_plane_state *plane_state;
 
 			plane_state = to_mtk_plane_state(plane->state);
@@ -562,12 +558,8 @@ static void mtk_crtc_ddp_config(struct drm_crtc *crtc,
 			if (!plane_state->pending.async_config)
 				continue;
 
-			comp = mtk_ddp_comp_for_plane(crtc, plane, &local_layer);
+			mtk_crtc_config_layer(mtk_crtc, plane_state, i, cmdq_handle);
 
-			if (comp)
-				mtk_ddp_comp_layer_config(comp, local_layer,
-							  plane_state,
-							  cmdq_handle);
 			if (!cmdq_handle)
 				plane_state->pending.async_config = false;
 		}
@@ -597,8 +589,8 @@ static void mtk_crtc_update_config(struct mtk_crtc *mtk_crtc, bool needs_vblank)
 	if (needs_vblank)
 		mtk_crtc->pending_needs_vblank = true;
 
-	for (i = 0; i < mtk_crtc->layer_nr; i++) {
-		struct drm_plane *plane = &mtk_crtc->planes[i];
+	for (i = 0; i < mtk_crtc->hwlayer_nr; i++) {
+		struct drm_plane *plane = &mtk_crtc->hwlayers[i].plane;
 		struct mtk_plane_state *plane_state;
 
 		plane_state = to_mtk_plane_state(plane->state);
@@ -747,12 +739,19 @@ static void mtk_crtc_update_output(struct drm_crtc *crtc,
 int mtk_crtc_plane_check(struct drm_crtc *crtc, struct drm_plane *plane,
 			 struct mtk_plane_state *state)
 {
-	unsigned int local_layer;
-	struct mtk_ddp_comp *comp;
+	struct mtk_crtc_hw_layer *hwlayer = container_of(plane, struct mtk_crtc_hw_layer, plane);
+	struct mtk_crtc *mtk_crtc = to_mtk_crtc(crtc);
+	u8 *layer_stages = hwlayer->layer_stages;
+	int i, ret;
+
+	for (i = 0; i < hwlayer->layer_stages_nr; i++) {
+		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[layer_stages[i]];
+
+		ret = mtk_ddp_comp_layer_check(comp, 0, state);
+		if (ret)
+			return ret;
+	}
 
-	comp = mtk_ddp_comp_for_plane(crtc, plane, &local_layer);
-	if (comp)
-		return mtk_ddp_comp_layer_check(comp, local_layer, state);
 	return 0;
 }
 
@@ -771,8 +770,8 @@ void mtk_crtc_plane_disable(struct drm_crtc *crtc, struct drm_plane *plane)
 		return;
 
 	/* set pending plane state to disabled */
-	for (i = 0; i < mtk_crtc->layer_nr; i++) {
-		struct drm_plane *mtk_plane = &mtk_crtc->planes[i];
+	for (i = 0; i < mtk_crtc->hwlayer_nr; i++) {
+		struct drm_plane *mtk_plane = &mtk_crtc->hwlayers[i].plane;
 		struct mtk_plane_state *mtk_plane_state = to_mtk_plane_state(mtk_plane->state);
 
 		if (mtk_plane->index == plane->index) {
@@ -841,8 +840,8 @@ static void mtk_crtc_atomic_disable(struct drm_crtc *crtc,
 		return;
 
 	/* Set all pending plane state to disabled */
-	for (i = 0; i < mtk_crtc->layer_nr; i++) {
-		struct drm_plane *plane = &mtk_crtc->planes[i];
+	for (i = 0; i < mtk_crtc->hwlayer_nr; i++) {
+		struct drm_plane *plane = &mtk_crtc->hwlayers[i].plane;
 		struct mtk_plane_state *plane_state;
 
 		plane_state = to_mtk_plane_state(plane->state);
@@ -936,11 +935,11 @@ static int mtk_crtc_init(struct drm_device *drm, struct mtk_crtc *mtk_crtc,
 	struct drm_plane *cursor = NULL;
 	int i, ret;
 
-	for (i = 0; i < mtk_crtc->layer_nr; i++) {
-		if (mtk_crtc->planes[i].type == DRM_PLANE_TYPE_PRIMARY)
-			primary = &mtk_crtc->planes[i];
-		else if (mtk_crtc->planes[i].type == DRM_PLANE_TYPE_CURSOR)
-			cursor = &mtk_crtc->planes[i];
+	for (i = 0; i < mtk_crtc->hwlayer_nr; i++) {
+		if (mtk_crtc->hwlayers[i].plane.type == DRM_PLANE_TYPE_PRIMARY)
+			primary = &mtk_crtc->hwlayers[i].plane;
+		else if (mtk_crtc->hwlayers[i].plane.type == DRM_PLANE_TYPE_CURSOR)
+			cursor = &mtk_crtc->hwlayers[i].plane;
 	}
 
 	ret = drm_crtc_init_with_planes(drm, &mtk_crtc->base, primary, cursor,
@@ -957,23 +956,6 @@ static int mtk_crtc_init(struct drm_device *drm, struct mtk_crtc *mtk_crtc,
 	return ret;
 }
 
-static int mtk_crtc_num_comp_planes(struct mtk_crtc *mtk_crtc, int comp_idx)
-{
-	struct mtk_ddp_comp *comp;
-
-	if (comp_idx > 1)
-		return 0;
-
-	comp = mtk_crtc->ddp_comp[comp_idx];
-	if (!comp->funcs)
-		return 0;
-
-	if (comp_idx == 1 && !comp->funcs->bgclr_in_on)
-		return 0;
-
-	return mtk_ddp_comp_layer_nr(comp);
-}
-
 static inline
 enum drm_plane_type mtk_crtc_plane_type(unsigned int plane_idx,
 					unsigned int num_planes)
@@ -991,15 +973,15 @@ static int mtk_crtc_init_comp_planes(struct drm_device *drm_dev,
 				     struct mtk_crtc *mtk_crtc,
 				     int comp_idx, int pipe)
 {
-	int num_planes = mtk_crtc_num_comp_planes(mtk_crtc, comp_idx);
 	struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[comp_idx];
+	unsigned int num_planes = mtk_ddp_comp_layer_nr(comp, comp_idx);
 	int i, ret;
 
 	for (i = 0; i < num_planes; i++) {
-		ret = mtk_plane_init(drm_dev,
-				&mtk_crtc->planes[mtk_crtc->layer_nr],
-				BIT(pipe),
-				mtk_crtc_plane_type(mtk_crtc->layer_nr, num_planes),
+		struct mtk_crtc_hw_layer *hwlayer = &mtk_crtc->hwlayers[mtk_crtc->hwlayer_nr];
+
+		ret = mtk_plane_init(drm_dev, &hwlayer->plane, BIT(pipe),
+				mtk_crtc_plane_type(mtk_crtc->hwlayer_nr, num_planes),
 				mtk_ddp_comp_supported_rotations(comp),
 				mtk_ddp_comp_get_blend_modes(comp),
 				mtk_ddp_comp_get_formats(comp),
@@ -1008,7 +990,98 @@ static int mtk_crtc_init_comp_planes(struct drm_device *drm_dev,
 		if (ret)
 			return ret;
 
-		mtk_crtc->layer_nr++;
+		hwlayer->layer_stages[hwlayer->layer_stages_nr] = comp_idx;
+		hwlayer->layer_stages_nr++;
+
+		mtk_crtc->hwlayer_nr++;
+	}
+	return 0;
+}
+
+static struct mtk_crtc_hw_layer
+*mtk_crtc_find_hwlayer_with_comp(struct mtk_crtc *mtk_crtc, int comp)
+{
+	struct mtk_crtc_hw_layer *hwlayer;
+	int i, j;
+
+	for (i = 0; i < mtk_crtc->hwlayer_nr; i++) {
+		hwlayer = &mtk_crtc->hwlayers[i];
+
+		for (j = 0; j < hwlayer->layer_stages_nr; j++) {
+			if (hwlayer->layer_stages[j] == comp)
+				return hwlayer;
+		}
+	}
+
+	return NULL;
+}
+
+static int mtk_crtc_init_layer_stages(struct mtk_crtc *mtk_crtc)
+{
+	unsigned int prev_master_layer_component = UINT_MAX;
+	unsigned int master_layer_component = 0;
+	unsigned int comp_idx;
+
+	for (comp_idx = 0; comp_idx < mtk_crtc->ddp_comp_nr; comp_idx++) {
+		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[comp_idx];
+		struct mtk_crtc_hw_layer *hwlayer = NULL;
+
+		/*
+		 * A hardware IP represented as a component with layer_nr > 0
+		 * is the master (and also the first layer stage), which may
+		 * then be composed of other multiple hardware-configurable
+		 * layer stages that are directly connected to it.
+		 *
+		 * Only quirk here is that, in some cases, some layer stages
+		 * may be connected together and hence not directly connected
+		 * to the master: this corner case is not getting a perfectly
+		 * accurate representation in the following code, as it treats
+		 * all of the additional layer stages as if they are directly
+		 * connected to the master.
+		 * That doesn't matter, because any special configuration for
+		 * this corner case is handled in the .connect handler of each
+		 * specific component driver.
+		 *
+		 * For example, this is a multi-component layer stage layout:
+		 *    FRAME_IN ->   _____ LAYER_MASTER ______ 
+		 *                 /       |        |        \  -> BLEND -> NEXT
+		 *              HW_STG1  HW_STG2  HW_STG3  HW_STGx    HW    HWIP
+		 *
+		 * And following, another one that gets handled (to simplify the
+		 * code) anyway like the first:
+		 * FRAME_IN -> LAYER_MASTER -> HW_STG1 -> HW_STG(x) -> NEXT HWIP
+		 *
+		 * For the moment, this also supposes that a component cannot be
+		 * both primary and secondary (so if it has layer_nr, stage_nr
+		 * will not be evaluated for such component).
+		 */
+		if (mtk_ddp_comp_layer_nr(comp, comp_idx)) {
+			master_layer_component = comp_idx;
+			continue;
+		}
+
+		/* If this component doesn't provide any stages, keep searching */
+		if (!mtk_ddp_comp_stage_nr(comp))
+			continue;
+
+		/*
+		 * If the index of the master layer component changed, find it
+		 * in the stack of registered layer components
+		 */ 
+		if (master_layer_component != prev_master_layer_component) {
+			hwlayer = mtk_crtc_find_hwlayer_with_comp(mtk_crtc, master_layer_component);
+			if (!hwlayer) {
+				drm_err(mtk_crtc->base.dev,
+					"Could not find layer master for %d!\n",
+					master_layer_component);
+				continue;
+			}
+			prev_master_layer_component = master_layer_component;
+		}
+
+		/* Add the newly found layer stage to the correct layer master */
+		hwlayer->layer_stages[hwlayer->layer_stages_nr] = comp_idx;
+		hwlayer->layer_stages_nr++;
 	}
 	return 0;
 }
@@ -1038,6 +1111,7 @@ int mtk_crtc_create(struct drm_device *drm_dev,
 	struct mtk_ddp_comp *dma_comp;
 	struct mtk_crtc *mtk_crtc;
 	unsigned int num_comp_planes = 0;
+	unsigned int max_comp_stages = 0;
 	int ret;
 	int i, j;
 	bool has_ctm = false;
@@ -1123,20 +1197,54 @@ int mtk_crtc_create(struct drm_device *drm_dev,
 						&mtk_crtc->base);
 	}
 
-	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++)
-		num_comp_planes += mtk_crtc_num_comp_planes(mtk_crtc, i);
+	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
+		struct mtk_ddp_comp *comp = mtk_crtc->ddp_comp[i];
+
+		num_comp_planes += mtk_ddp_comp_layer_nr(comp, 0);
+		max_comp_stages = MAX(mtk_ddp_comp_stage_nr(comp), max_comp_stages);
+	}
 
-	mtk_crtc->planes = devm_kcalloc(dev, num_comp_planes,
-					sizeof(struct drm_plane), GFP_KERNEL);
-	if (!mtk_crtc->planes)
+	/*
+	 * On the older and/or simpler display controllers, each layer is single
+	 * stage, while newer ones are more complex and may have multiple stages
+	 * to form one full layer.
+	 *
+	 * In both cases, anyway, in order to form a complete layer for plane,
+	 * there will always be at least one layer stage, so the maximum number
+	 * of stages is always (1 + max_comp_stages): for this reason, just add 1.
+	 */
+	max_comp_stages++;
+
+	mtk_crtc->hwlayers = devm_kcalloc(dev, num_comp_planes,
+					  sizeof(*mtk_crtc->hwlayers),
+					  GFP_KERNEL);
+	if (!mtk_crtc->hwlayers)
 		return -ENOMEM;
 
+	for (i = 0; i < num_comp_planes; i++) {
+		struct mtk_crtc_hw_layer *comp_plane = &mtk_crtc->hwlayers[i];
+		comp_plane->layer_stages = devm_kcalloc(dev, max_comp_stages,
+							sizeof(*comp_plane->layer_stages),
+							GFP_KERNEL);
+		if (!comp_plane->layer_stages)
+			return -ENOMEM;
+	}
+
 	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
 		ret = mtk_crtc_init_comp_planes(drm_dev, mtk_crtc, i, crtc_i);
 		if (ret)
 			return ret;
 	}
 
+	/* Initialize multi-stage only if present */
+	if (max_comp_stages > 1) {
+		ret = mtk_crtc_init_layer_stages(mtk_crtc);
+		if (ret)
+			return ret;
+	}
+	dev_dbg(dev, "Found %u layers composed by maximum of %u stage(s) each.\n",
+		mtk_crtc->hwlayer_nr, max_comp_stages);
+
 	/*
 	 * Default to use the first component as the dma dev.
 	 * In the case of ovl_adaptor sub driver, it needs to use the
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
index 5206445b7157..a7ed46a95037 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
@@ -50,7 +50,8 @@ struct mtk_ddp_comp_funcs {
 	void (*enable_vblank)(struct device *dev);
 	void (*disable_vblank)(struct device *dev);
 	unsigned int (*supported_rotations)(struct device *dev);
-	unsigned int (*layer_nr)(struct device *dev);
+	unsigned int (*layer_nr)(struct device *dev, int pipeline_index);
+	unsigned int (*layerstage_nr)(struct device *dev);
 	int (*layer_check)(struct device *dev,
 			   unsigned int idx,
 			   struct mtk_plane_state *state);
@@ -196,10 +197,18 @@ unsigned int mtk_ddp_comp_supported_rotations(struct mtk_ddp_comp *comp)
 	return DRM_MODE_ROTATE_0;
 }
 
-static inline unsigned int mtk_ddp_comp_layer_nr(struct mtk_ddp_comp *comp)
+static inline unsigned int mtk_ddp_comp_layer_nr(struct mtk_ddp_comp *comp, int pipeline_idx)
 {
 	if (comp->funcs && comp->funcs->layer_nr)
-		return comp->funcs->layer_nr(comp->dev);
+		return comp->funcs->layer_nr(comp->dev, pipeline_idx);
+
+	return 0;
+}
+
+static inline unsigned int mtk_ddp_comp_stage_nr(struct mtk_ddp_comp *comp)
+{
+	if (comp->funcs && comp->funcs->layerstage_nr)
+		return comp->funcs->layerstage_nr(comp->dev);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index e0c30c6c7cc8..7706d95b3be8 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * Copyright (c) 2020 MediaTek Inc.
+ * Copyright (c) 2020-2025 MediaTek Inc.
+ * Copyright (c) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  */
 
 #ifndef _MTK_DISP_DRV_H_
@@ -98,7 +100,7 @@ int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
 void mtk_ovl_layer_config(struct device *dev, unsigned int idx,
 			  struct mtk_plane_state *state,
 			  struct cmdq_pkt *cmdq_pkt);
-unsigned int mtk_ovl_layer_nr(struct device *dev);
+unsigned int mtk_ovl_layer_nr(struct device *dev, int pipeline_index);
 void mtk_ovl_layer_on(struct device *dev, unsigned int idx,
 		      struct cmdq_pkt *cmdq_pkt);
 void mtk_ovl_layer_off(struct device *dev, unsigned int idx,
@@ -141,7 +143,7 @@ void mtk_ovl_adaptor_enable_vblank(struct device *dev);
 void mtk_ovl_adaptor_disable_vblank(struct device *dev);
 void mtk_ovl_adaptor_start(struct device *dev);
 void mtk_ovl_adaptor_stop(struct device *dev);
-unsigned int mtk_ovl_adaptor_layer_nr(struct device *dev);
+unsigned int mtk_ovl_adaptor_layer_nr(struct device *dev, int pipeline_index);
 struct device *mtk_ovl_adaptor_dma_dev_get(struct device *dev);
 u32 mtk_ovl_adaptor_get_blend_modes(struct device *dev);
 const u32 *mtk_ovl_adaptor_get_formats(struct device *dev);
@@ -155,7 +157,7 @@ void mtk_rdma_clk_disable(struct device *dev);
 void mtk_rdma_config(struct device *dev, unsigned int width,
 		     unsigned int height, unsigned int vrefresh,
 		     unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
-unsigned int mtk_rdma_layer_nr(struct device *dev);
+unsigned int mtk_rdma_layer_nr(struct device *dev, int pipeline_index);
 void mtk_rdma_layer_config(struct device *dev, unsigned int idx,
 			   struct mtk_plane_state *state,
 			   struct cmdq_pkt *cmdq_pkt);
@@ -186,7 +188,7 @@ void mtk_wdma_clk_disable(struct device *dev);
 void mtk_wdma_config(struct device *dev, unsigned int width,
 		     unsigned int height, unsigned int vrefresh,
 		     unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
-unsigned int mtk_wdma_layer_nr(struct device *dev);
+unsigned int mtk_wdma_layer_nr(struct device *dev, int pipeline_index);
 void mtk_wdma_layer_config(struct device *dev, unsigned int idx,
 			   struct mtk_plane_state *state,
 			   struct cmdq_pkt *cmdq_pkt);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index fa4607304acb..489a209c4e55 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -348,10 +348,20 @@ void mtk_ovl_config(struct device *dev, unsigned int w,
 	mtk_ddp_write(cmdq_pkt, 0x0, &ovl->cmdq_reg, ovl->regs, DISP_REG_OVL_RST);
 }
 
-unsigned int mtk_ovl_layer_nr(struct device *dev)
+unsigned int mtk_ovl_layer_nr(struct device *dev, int pipeline_index)
 {
 	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
 
+	/*
+	 * Only the first OVL in a display pipeline can form layers, and it
+	 * must be either:
+	 *  - The first HW component in the pipeline; or
+	 *  - The second HW component in the pipeline, taking its input from
+	 *    a ReadDMA (RDMA) output.
+	 */
+	if (pipeline_index > 1)
+		return 0;
+
 	return ovl->data->layer_nr;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index bbf1d8ccda05..78bc3bee0794 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -360,7 +360,7 @@ enum drm_mode_status mtk_ovl_adaptor_mode_valid(struct device *dev,
 	return MODE_OK;
 }
 
-unsigned int mtk_ovl_adaptor_layer_nr(struct device *dev)
+unsigned int mtk_ovl_adaptor_layer_nr(struct device *dev, int pipeline_index)
 {
 	return MTK_OVL_ADAPTOR_LAYER_NUM;
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 9fd9bb1ee544..dce7a9bc3f11 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -251,8 +251,15 @@ static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
 	}
 }
 
-unsigned int mtk_rdma_layer_nr(struct device *dev)
+unsigned int mtk_rdma_layer_nr(struct device *dev, int pipeline_index)
 {
+	/*
+	 * ReadDMA may participate in forming a layer only if it is the first
+	 * component in a pipeline, usually passing data to a DispHW Overlay (OVL)
+	 */
+	if (pipeline_index > 0)
+		return 0;
+
 	return 1;
 }
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_wdma.c b/drivers/gpu/drm/mediatek/mtk_disp_wdma.c
index 761dbe0148d8..26c80e7e152b 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_wdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_wdma.c
@@ -259,7 +259,7 @@ static u32 wdma_fmt_convert(unsigned int fmt)
 	}
 }
 
-unsigned int mtk_wdma_layer_nr(struct device *dev)
+unsigned int mtk_wdma_layer_nr(struct device *dev, int pipeline_index)
 {
 	return 1;
 }
-- 
2.54.0

