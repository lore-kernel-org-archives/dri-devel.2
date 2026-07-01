Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAE0C44506
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D9F10EF6F;
	Wed,  1 Jul 2026 12:21:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="f/FSdYij";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260BE10EF6B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908504;
 bh=BletofGxTLJKLtOCpRi+bIeuCm9Svwd3CTzjPRNS3zs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=f/FSdYijfGUmt0/hjbGg38KesEluMgbvlg7gpLIRdltr09Kna6h27IwH1IGW0+Smr
 HSfQ52Znb37OtzM64K+zSGhV5SEPxIBrEL2ouZxrZNjPzxNNM8WE4DtuLpeDL8tv5R
 J3mMbwPIXmO6CGF4Zjs7z05Lznb4g1hHbAYW06m4GPuJfBch7dbJWL6bsHtIGC4yAb
 2zMrX2TjcQUW9i/RY0Jk+ElxlU/6E8EsZmvJYZEgQbE9bx5T05zE2ZSOeRg2qteDXE
 pKE7P1AmPFlUtoSkNAyo8Q8oEx+ZPvt/6+vyuDrUweda9jXqqiknVj3LiOsFLHxUWz
 M0N+FDDAlHuXQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 22C7B17E35D6;
 Wed,  1 Jul 2026 14:21:44 +0200 (CEST)
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
Subject: [PATCH 32/42] drm/mediatek: mtk_crtc: Dynamically find suitable CRTC
 DMA device
Date: Wed,  1 Jul 2026 14:20:47 +0200
Message-ID: <20260701122057.19648-33-angelogioacchino.delregno@collabora.com>
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

Now that the vblank and config components are being dynamically
selected, the only hardcoded strategy that is left is selecting
a DMA device for a CRTC that is being created.

In order to support pipelines including an embedded multimedia
controller (like MDP3) chained with the display controller and
pipelines chaining multiple display controllers together, stop
assuming that the first component in the pipeline is suited to
do DMA operations and implement support to dynamically find not
only a suitable DMA device, but also the best one.

This finds the first device that provides DMA and the first one
that is also behind an IOMMU.

The criteria for selecting the best device is to prefer a DMA
device behind an IOMMU; if not found, the first DMA capable
one is selected instead.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_crtc.c | 68 ++++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_crtc.c b/drivers/gpu/drm/mediatek/mtk_crtc.c
index ee23a50cf4d1..3f70d11270e9 100644
--- a/drivers/gpu/drm/mediatek/mtk_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_crtc.c
@@ -1131,6 +1131,60 @@ struct device *mtk_crtc_dma_dev_get(struct drm_crtc *crtc)
 	return mtk_crtc->dma_dev;
 }
 
+static int mtk_crtc_find_suitable_dma_dev(struct mtk_drm_private *priv,
+					  struct mtk_crtc *mtk_crtc,
+					  const struct mtk_drm_path_definition *path)
+{
+	struct mtk_ddp_comp *dma_comp = NULL, *dma_comp_mmu = NULL;
+	int i;
+
+	for (i = 0; i < mtk_crtc->ddp_comp_nr; i++) {
+		const struct mtk_drm_comp_definition *cdef = path[i].comp;
+		struct mtk_ddp_comp *comp;
+
+		comp = mtk_ddp_comp_find_by_id(&priv->hlist,
+					       cdef->type, cdef->inst_id);
+		if (!comp)
+			continue;
+
+		/*
+		 * Check if this is a legacy OVL_ADAPTOR component and, if so, this
+		 * has to forcefully be the DMA device for this CRTC: assign it to
+		 * dma_comp_mmu to force that.
+		 */
+		if (comp->type == MTK_DISP_OVL_ADAPTOR) {
+			dma_comp_mmu = comp;
+			break;
+		}
+
+		if (!comp->dev || !comp->dev->of_node)
+			continue;
+
+		/* Find the first device provides DMA... */
+		if (!dma_comp) {
+			if (of_property_present(comp->dev->of_node, "#dma-cells"))
+				dma_comp = comp;
+		}
+
+		/* ...and check if that device is also behind an IOMMU */
+		if (!of_property_present(comp->dev->of_node, "iommus"))
+			continue;
+
+		/* If a device behind IOMMU is found, this is the best outcome */
+		dma_comp_mmu = comp;
+		break;
+	}
+
+	if (dma_comp_mmu)
+		mtk_crtc->dma_dev = mtk_ddp_comp_dma_dev_get(dma_comp_mmu);
+	else if (dma_comp)
+		mtk_crtc->dma_dev = mtk_ddp_comp_dma_dev_get(dma_comp);
+	else
+		return -EINVAL;
+
+	return 0;
+}
+
 int mtk_crtc_create(struct drm_device *drm_dev,
 		    enum mtk_crtc_path path_sel, int priv_data_index,
 		    const struct mtk_drm_route *conn_routes,
@@ -1139,7 +1193,6 @@ int mtk_crtc_create(struct drm_device *drm_dev,
 	struct mtk_drm_private *priv = drm_dev->dev_private;
 	const struct mtk_drm_path_definition *output_path;
 	struct device *dev = drm_dev->dev;
-	struct mtk_ddp_comp *dma_comp;
 	struct mtk_crtc *mtk_crtc;
 	unsigned int num_comp_planes = 0;
 	unsigned int max_comp_stages = 0;
@@ -1309,20 +1362,11 @@ int mtk_crtc_create(struct drm_device *drm_dev,
 	dev_dbg(dev, "Found %u layers composed by maximum of %u stage(s) each.\n",
 		mtk_crtc->hwlayer_nr, max_comp_stages);
 
-	/*
-	 * Default to use the first component as the dma dev.
-	 * In the case of ovl_adaptor sub driver, it needs to use the
-	 * dma_dev_get function to get representative dma dev.
-	 */
-	dma_comp = mtk_ddp_comp_find_by_id(&priv->hlist,
-					   output_path->comp[0].type,
-					   output_path->comp[0].inst_id);
-	if (dma_comp == NULL) {
+	ret = mtk_crtc_find_suitable_dma_dev(priv, mtk_crtc, output_path);
+	if (ret) {
 		dev_err(dev, "Could not find appropriate DMA device!\n");
 		return -EINVAL;
 	}
-
-	mtk_crtc->dma_dev = mtk_ddp_comp_dma_dev_get(dma_comp);
 	dev_dbg(dev, "Using DMA device %pOF\n", mtk_crtc->dma_dev->of_node);
 
 	ret = mtk_crtc_init(drm_dev, mtk_crtc, crtc_i);
-- 
2.54.0

