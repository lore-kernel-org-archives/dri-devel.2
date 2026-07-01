Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39FDC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0701F10EF62;
	Wed,  1 Jul 2026 12:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Y23v5mno";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55D8510EF6E
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908497;
 bh=LQOLS0BAqpnfvkd+qHepkyIsbDDgt+ixh/Wa2TO192c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y23v5mno++vWFtcc5YSugMF74X5yLBhs0fccimw0NUXJAdWG2ClCXrJ7E/h/+HZGN
 VUZVqszrQ3RT7+H73S7qzJ8WbA104MrWSD/o1cczICSxq6pAhS1YxVS9WqEqHlwzhG
 +FYNJVCRokTIDmUYrBkZiI3e5/fCEISCEfCgPlogcjLwBhyINp5LV49bDIW8oEM5KW
 IMF3iJy7bVy6/07Su3w8PxR8Ag11h/A0AqfndTVuidOGkU/3VwlR1Hk43lXxv4EvBA
 DkKs9c5aq6niOkT9A9WKUgfIkFzLyNu7T3+HI7Gez5uBPOh74JkkQz/vQf44TDZNPe
 xMaReaYCRo1bg==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1E27F17E0CF4;
 Wed,  1 Jul 2026 14:21:35 +0200 (CEST)
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
Subject: [PATCH 25/42] drm/mediatek: Pass mtk_ddp_comp in clk and config
 callbacks
Date: Wed,  1 Jul 2026 14:20:40 +0200
Message-ID: <20260701122057.19648-26-angelogioacchino.delregno@collabora.com>
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

In preparation for adding support for new Display Controller HW
components found in newer-gen SoCs like MT8196/MT8894, change the
.clk_enable(), .clk_disable(), and .config() callbacks to pass a
struct mtk_ddp_comp pointer instead of a struct device, and update
all of the currently supported components to reflect this change.

This is done because some of the new drivers need to track more in
the status of the actual components, such as indexing for multiple
stages layer strategy and others.

Despite being a rather big change in terms of lines, this brings
no functional differences.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c       | 22 +++---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.h       | 20 +++---
 drivers/gpu/drm/mediatek/mtk_disp_aal.c       | 12 ++--
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c     | 12 ++--
 drivers/gpu/drm/mediatek/mtk_disp_color.c     | 12 ++--
 drivers/gpu/drm/mediatek/mtk_disp_drv.h       | 70 +++++++++----------
 drivers/gpu/drm/mediatek/mtk_disp_dsc.c       |  8 +--
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c     | 12 ++--
 drivers/gpu/drm/mediatek/mtk_disp_merge.c     | 18 ++---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       | 12 ++--
 .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 50 +++++++------
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c      | 12 ++--
 drivers/gpu/drm/mediatek/mtk_disp_wdma.c      | 12 ++--
 drivers/gpu/drm/mediatek/mtk_ethdr.c          | 10 +--
 drivers/gpu/drm/mediatek/mtk_ethdr.h          |  4 +-
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       |  8 +--
 drivers/gpu/drm/mediatek/mtk_padding.c        |  8 +--
 17 files changed, 155 insertions(+), 147 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index f8687f161953..8b9228084828 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -109,16 +109,16 @@ void mtk_ddp_write_mask(struct cmdq_pkt *cmdq_pkt, unsigned int value,
 #endif
 }
 
-static int mtk_ddp_clk_enable(struct device *dev)
+static int mtk_ddp_clk_enable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
+	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(comp->dev);
 
 	return clk_prepare_enable(priv->clk);
 }
 
-static void mtk_ddp_clk_disable(struct device *dev)
+static void mtk_ddp_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
+	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(comp->dev);
 
 	clk_disable_unprepare(priv->clk);
 }
@@ -149,11 +149,11 @@ void mtk_dither_set_common(void __iomem *regs, struct cmdq_client_reg *cmdq_reg,
 	}
 }
 
-static void mtk_dither_config(struct device *dev, unsigned int w,
+static void mtk_dither_config(struct mtk_ddp_comp *comp, unsigned int w,
 			      unsigned int h, unsigned int vrefresh,
 			      unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
-	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
+	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(comp->dev);
 
 	mtk_ddp_write(cmdq_pkt, w << 16 | h, &priv->cmdq_reg, priv->regs, DISP_REG_DITHER_SIZE);
 	mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, &priv->cmdq_reg, priv->regs,
@@ -185,15 +185,15 @@ static void mtk_dither_set(struct device *dev, unsigned int bpc,
 			      DISP_DITHERING, cmdq_pkt);
 }
 
-static void mtk_od_config(struct device *dev, unsigned int w,
+static void mtk_od_config(struct mtk_ddp_comp *comp, unsigned int w,
 			  unsigned int h, unsigned int vrefresh,
 			  unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
-	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
+	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(comp->dev);
 
 	mtk_ddp_write(cmdq_pkt, w << 16 | h, &priv->cmdq_reg, priv->regs, DISP_REG_OD_SIZE);
 	mtk_ddp_write(cmdq_pkt, OD_RELAYMODE, &priv->cmdq_reg, priv->regs, DISP_REG_OD_CFG);
-	mtk_dither_set(dev, bpc, DISP_REG_OD_CFG, cmdq_pkt);
+	mtk_dither_set(comp->dev, bpc, DISP_REG_OD_CFG, cmdq_pkt);
 }
 
 static void mtk_od_start(struct device *dev)
@@ -203,11 +203,11 @@ static void mtk_od_start(struct device *dev)
 	writel(1, priv->regs + DISP_REG_OD_EN);
 }
 
-static void mtk_postmask_config(struct device *dev, unsigned int w,
+static void mtk_postmask_config(struct mtk_ddp_comp *comp, unsigned int w,
 				unsigned int h, unsigned int vrefresh,
 				unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
-	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
+	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(comp->dev);
 
 	mtk_ddp_write(cmdq_pkt, w << 16 | h, &priv->cmdq_reg, priv->regs,
 		      DISP_REG_POSTMASK_SIZE);
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
index ab9d5e4dfb98..1297db252821 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.h
@@ -36,9 +36,9 @@ struct mtk_drm_comp_list {
 struct mtk_ddp_comp_funcs {
 	int (*power_on)(struct device *dev);
 	void (*power_off)(struct device *dev);
-	int (*clk_enable)(struct device *dev);
-	void (*clk_disable)(struct device *dev);
-	void (*config)(struct device *dev, unsigned int w,
+	int (*clk_enable)(struct mtk_ddp_comp *comp);
+	void (*clk_disable)(struct mtk_ddp_comp *comp);
+	void (*config)(struct mtk_ddp_comp *comp, unsigned int w,
 		       unsigned int h, unsigned int vrefresh,
 		       unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
 	void (*dsc_setup)(struct device *dev, struct drm_dsc_config *dsc);
@@ -75,8 +75,8 @@ struct mtk_ddp_comp_funcs {
 			struct mtk_ddp_comp *next);
 	void (*disconnect)(struct mtk_ddp_comp *comp, struct device *mmsys_dev,
 			   struct mtk_ddp_comp *next);
-	void (*add)(struct device *dev, struct mtk_mutex *mutex);
-	void (*remove)(struct device *dev, struct mtk_mutex *mutex);
+	void (*add)(struct mtk_ddp_comp *comp, struct mtk_mutex *mutex);
+	void (*remove)(struct mtk_ddp_comp *comp, struct mtk_mutex *mutex);
 	unsigned int (*encoder_index)(struct device *dev);
 	enum drm_mode_status (*mode_valid)(struct device *dev, const struct drm_display_mode *mode);
 };
@@ -113,7 +113,7 @@ static inline void mtk_ddp_comp_power_off(struct mtk_ddp_comp *comp)
 static inline int mtk_ddp_comp_clk_enable(struct mtk_ddp_comp *comp)
 {
 	if (comp->funcs && comp->funcs->clk_enable)
-		return comp->funcs->clk_enable(comp->dev);
+		return comp->funcs->clk_enable(comp);
 
 	return 0;
 }
@@ -121,7 +121,7 @@ static inline int mtk_ddp_comp_clk_enable(struct mtk_ddp_comp *comp)
 static inline void mtk_ddp_comp_clk_disable(struct mtk_ddp_comp *comp)
 {
 	if (comp->funcs && comp->funcs->clk_disable)
-		comp->funcs->clk_disable(comp->dev);
+		comp->funcs->clk_disable(comp);
 }
 
 static inline
@@ -139,7 +139,7 @@ static inline void mtk_ddp_comp_config(struct mtk_ddp_comp *comp,
 				       struct cmdq_pkt *cmdq_pkt)
 {
 	if (comp->funcs && comp->funcs->config)
-		comp->funcs->config(comp->dev, w, h, vrefresh, bpc, cmdq_pkt);
+		comp->funcs->config(comp, w, h, vrefresh, bpc, cmdq_pkt);
 }
 
 static inline void mtk_ddp_comp_dsc_setup(struct mtk_ddp_comp *comp,
@@ -314,7 +314,7 @@ static inline bool mtk_ddp_comp_is_afbc_supported(struct mtk_ddp_comp *comp)
 static inline bool mtk_ddp_comp_add(struct mtk_ddp_comp *comp, struct mtk_mutex *mutex)
 {
 	if (comp->funcs && comp->funcs->add) {
-		comp->funcs->add(comp->dev, mutex);
+		comp->funcs->add(comp, mutex);
 		return true;
 	}
 	return false;
@@ -323,7 +323,7 @@ static inline bool mtk_ddp_comp_add(struct mtk_ddp_comp *comp, struct mtk_mutex
 static inline bool mtk_ddp_comp_remove(struct mtk_ddp_comp *comp, struct mtk_mutex *mutex)
 {
 	if (comp->funcs && comp->funcs->remove) {
-		comp->funcs->remove(comp->dev, mutex);
+		comp->funcs->remove(comp, mutex);
 		return true;
 	}
 	return false;
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
index abc9e5525d03..5199354e7b51 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
@@ -50,25 +50,25 @@ struct mtk_disp_aal {
 	const struct mtk_disp_aal_data *data;
 };
 
-int mtk_aal_clk_enable(struct device *dev)
+int mtk_aal_clk_enable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_aal *aal = dev_get_drvdata(dev);
+	struct mtk_disp_aal *aal = dev_get_drvdata(comp->dev);
 
 	return clk_prepare_enable(aal->clk);
 }
 
-void mtk_aal_clk_disable(struct device *dev)
+void mtk_aal_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_aal *aal = dev_get_drvdata(dev);
+	struct mtk_disp_aal *aal = dev_get_drvdata(comp->dev);
 
 	clk_disable_unprepare(aal->clk);
 }
 
-void mtk_aal_config(struct device *dev, unsigned int w,
+void mtk_aal_config(struct mtk_ddp_comp *comp, unsigned int w,
 			   unsigned int h, unsigned int vrefresh,
 			   unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
-	struct mtk_disp_aal *aal = dev_get_drvdata(dev);
+	struct mtk_disp_aal *aal = dev_get_drvdata(comp->dev);
 	u32 sz;
 
 	sz = FIELD_PREP(DISP_AAL_SIZE_HSIZE, w);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 6d7bf4afa78d..81ce82ba6a9f 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -40,25 +40,25 @@ struct mtk_disp_ccorr {
 	const struct mtk_disp_ccorr_data	*data;
 };
 
-int mtk_ccorr_clk_enable(struct device *dev)
+int mtk_ccorr_clk_enable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_ccorr *ccorr = dev_get_drvdata(dev);
+	struct mtk_disp_ccorr *ccorr = dev_get_drvdata(comp->dev);
 
 	return clk_prepare_enable(ccorr->clk);
 }
 
-void mtk_ccorr_clk_disable(struct device *dev)
+void mtk_ccorr_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_ccorr *ccorr = dev_get_drvdata(dev);
+	struct mtk_disp_ccorr *ccorr = dev_get_drvdata(comp->dev);
 
 	clk_disable_unprepare(ccorr->clk);
 }
 
-void mtk_ccorr_config(struct device *dev, unsigned int w,
+void mtk_ccorr_config(struct mtk_ddp_comp *comp, unsigned int w,
 			     unsigned int h, unsigned int vrefresh,
 			     unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
-	struct mtk_disp_ccorr *ccorr = dev_get_drvdata(dev);
+	struct mtk_disp_ccorr *ccorr = dev_get_drvdata(comp->dev);
 
 	mtk_ddp_write(cmdq_pkt, w << 16 | h, &ccorr->cmdq_reg, ccorr->regs,
 		      DISP_CCORR_SIZE);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
index 39c7de4cdcc1..04ae5e528c34 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
@@ -43,25 +43,25 @@ struct mtk_disp_color {
 	const struct mtk_disp_color_data	*data;
 };
 
-int mtk_color_clk_enable(struct device *dev)
+int mtk_color_clk_enable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_color *color = dev_get_drvdata(dev);
+	struct mtk_disp_color *color = dev_get_drvdata(comp->dev);
 
 	return clk_prepare_enable(color->clk);
 }
 
-void mtk_color_clk_disable(struct device *dev)
+void mtk_color_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_color *color = dev_get_drvdata(dev);
+	struct mtk_disp_color *color = dev_get_drvdata(comp->dev);
 
 	clk_disable_unprepare(color->clk);
 }
 
-void mtk_color_config(struct device *dev, unsigned int w,
+void mtk_color_config(struct mtk_ddp_comp *comp, unsigned int w,
 		      unsigned int h, unsigned int vrefresh,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
-	struct mtk_disp_color *color = dev_get_drvdata(dev);
+	struct mtk_disp_color *color = dev_get_drvdata(comp->dev);
 
 	mtk_ddp_write(cmdq_pkt, w, &color->cmdq_reg, color->regs, DISP_COLOR_WIDTH(color));
 	mtk_ddp_write(cmdq_pkt, h, &color->cmdq_reg, color->regs, DISP_COLOR_HEIGHT(color));
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index abdce23fab17..62daf5ade9d1 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -17,9 +17,9 @@
 
 struct drm_dsc_config;
 
-int mtk_aal_clk_enable(struct device *dev);
-void mtk_aal_clk_disable(struct device *dev);
-void mtk_aal_config(struct device *dev, unsigned int w,
+int mtk_aal_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_aal_clk_disable(struct mtk_ddp_comp *comp);
+void mtk_aal_config(struct mtk_ddp_comp *comp, unsigned int w,
 		    unsigned int h, unsigned int vrefresh,
 		    unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
 unsigned int mtk_aal_gamma_get_lut_size(struct device *dev);
@@ -28,18 +28,18 @@ void mtk_aal_start(struct device *dev);
 void mtk_aal_stop(struct device *dev);
 
 void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state);
-int mtk_ccorr_clk_enable(struct device *dev);
-void mtk_ccorr_clk_disable(struct device *dev);
-void mtk_ccorr_config(struct device *dev, unsigned int w,
+int mtk_ccorr_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_ccorr_clk_disable(struct mtk_ddp_comp *comp);
+void mtk_ccorr_config(struct mtk_ddp_comp *comp, unsigned int w,
 		      unsigned int h, unsigned int vrefresh,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
 void mtk_ccorr_start(struct device *dev);
 void mtk_ccorr_stop(struct device *dev);
 
 void mtk_color_bypass_shadow(struct device *dev);
-int mtk_color_clk_enable(struct device *dev);
-void mtk_color_clk_disable(struct device *dev);
-void mtk_color_config(struct device *dev, unsigned int w,
+int mtk_color_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_color_clk_disable(struct mtk_ddp_comp *comp);
+void mtk_color_config(struct mtk_ddp_comp *comp, unsigned int w,
 		      unsigned int h, unsigned int vrefresh,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
 void mtk_color_start(struct device *dev);
@@ -52,8 +52,8 @@ void mtk_dpi_start(struct device *dev);
 void mtk_dpi_stop(struct device *dev);
 unsigned int mtk_dpi_encoder_index(struct device *dev);
 
-int mtk_dsc_clk_enable(struct device *dev);
-void mtk_dsc_clk_disable(struct device *dev);
+int mtk_dsc_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_dsc_clk_disable(struct mtk_ddp_comp *comp);
 void mtk_dsc_setup(struct device *dev, struct drm_dsc_config *dsc_cfg);
 void mtk_dsc_start(struct device *dev);
 void mtk_dsc_stop(struct device *dev);
@@ -67,9 +67,9 @@ void mtk_dvo_start(struct device *dev);
 void mtk_dvo_stop(struct device *dev);
 unsigned int mtk_dvo_encoder_index(struct device *dev);
 
-int mtk_gamma_clk_enable(struct device *dev);
-void mtk_gamma_clk_disable(struct device *dev);
-void mtk_gamma_config(struct device *dev, unsigned int w,
+int mtk_gamma_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_gamma_clk_disable(struct mtk_ddp_comp *comp);
+void mtk_gamma_config(struct mtk_ddp_comp *comp, unsigned int w,
 		      unsigned int h, unsigned int vrefresh,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
 unsigned int mtk_gamma_get_lut_size(struct device *dev);
@@ -77,9 +77,9 @@ void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state);
 void mtk_gamma_start(struct device *dev);
 void mtk_gamma_stop(struct device *dev);
 
-int mtk_merge_clk_enable(struct device *dev);
-void mtk_merge_clk_disable(struct device *dev);
-void mtk_merge_config(struct device *dev, unsigned int width,
+int mtk_merge_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_merge_clk_disable(struct mtk_ddp_comp *comp);
+void mtk_merge_config(struct mtk_ddp_comp *comp, unsigned int width,
 		      unsigned int height, unsigned int vrefresh,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
 void mtk_merge_start(struct device *dev);
@@ -95,9 +95,9 @@ enum drm_mode_status mtk_merge_mode_valid(struct device *dev,
 void mtk_ovl_bgclr_in_on(struct device *dev);
 void mtk_ovl_bgclr_in_off(struct device *dev);
 void mtk_ovl_bypass_shadow(struct device *dev);
-int mtk_ovl_clk_enable(struct device *dev);
-void mtk_ovl_clk_disable(struct device *dev);
-void mtk_ovl_config(struct device *dev, unsigned int w,
+int mtk_ovl_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_ovl_clk_disable(struct mtk_ddp_comp *comp);
+void mtk_ovl_config(struct mtk_ddp_comp *comp, unsigned int w,
 		    unsigned int h, unsigned int vrefresh,
 		    unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
 int mtk_ovl_layer_check(struct device *dev, unsigned int idx,
@@ -124,8 +124,8 @@ const u32 *mtk_ovl_get_formats(struct device *dev);
 size_t mtk_ovl_get_num_formats(struct device *dev);
 bool mtk_ovl_is_afbc_supported(struct device *dev);
 
-void mtk_ovl_adaptor_add_comp(struct device *dev, struct mtk_mutex *mutex);
-void mtk_ovl_adaptor_remove_comp(struct device *dev, struct mtk_mutex *mutex);
+void mtk_ovl_adaptor_add_comp(struct mtk_ddp_comp *comp, struct mtk_mutex *mutex);
+void mtk_ovl_adaptor_remove_comp(struct mtk_ddp_comp *comp, struct mtk_mutex *mutex);
 bool mtk_ovl_adaptor_is_comp_present(struct device_node *node);
 void mtk_ovl_adaptor_connect(struct mtk_ddp_comp *comp, struct device *mmsys_dev,
 			     struct mtk_ddp_comp *next);
@@ -133,9 +133,9 @@ void mtk_ovl_adaptor_disconnect(struct mtk_ddp_comp *comp, struct device *mmsys_
 				struct mtk_ddp_comp *next);
 int mtk_ovl_adaptor_power_on(struct device *dev);
 void mtk_ovl_adaptor_power_off(struct device *dev);
-int mtk_ovl_adaptor_clk_enable(struct device *dev);
-void mtk_ovl_adaptor_clk_disable(struct device *dev);
-void mtk_ovl_adaptor_config(struct device *dev, unsigned int w,
+int mtk_ovl_adaptor_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_ovl_adaptor_clk_disable(struct mtk_ddp_comp *comp);
+void mtk_ovl_adaptor_config(struct mtk_ddp_comp *comp, unsigned int w,
 			    unsigned int h, unsigned int vrefresh,
 			    unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
 void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
@@ -157,9 +157,9 @@ enum drm_mode_status mtk_ovl_adaptor_mode_valid(struct device *dev,
 						const struct drm_display_mode *mode);
 
 void mtk_rdma_bypass_shadow(struct device *dev);
-int mtk_rdma_clk_enable(struct device *dev);
-void mtk_rdma_clk_disable(struct device *dev);
-void mtk_rdma_config(struct device *dev, unsigned int width,
+int mtk_rdma_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_rdma_clk_disable(struct mtk_ddp_comp *comp);
+void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 		     unsigned int height, unsigned int vrefresh,
 		     unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
 unsigned int mtk_rdma_layer_nr(struct device *dev, int pipeline_index);
@@ -179,8 +179,8 @@ size_t mtk_rdma_get_num_formats(struct device *dev);
 
 int mtk_mdp_rdma_power_on(struct device *dev);
 void mtk_mdp_rdma_power_off(struct device *dev);
-int mtk_mdp_rdma_clk_enable(struct device *dev);
-void mtk_mdp_rdma_clk_disable(struct device *dev);
+int mtk_mdp_rdma_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_mdp_rdma_clk_disable(struct mtk_ddp_comp *comp);
 void mtk_mdp_rdma_start(struct device *dev, struct cmdq_pkt *cmdq_pkt);
 void mtk_mdp_rdma_stop(struct device *dev, struct cmdq_pkt *cmdq_pkt);
 void mtk_mdp_rdma_config(struct device *dev, struct mtk_mdp_rdma_cfg *cfg,
@@ -188,9 +188,9 @@ void mtk_mdp_rdma_config(struct device *dev, struct mtk_mdp_rdma_cfg *cfg,
 const u32 *mtk_mdp_rdma_get_formats(struct device *dev);
 size_t mtk_mdp_rdma_get_num_formats(struct device *dev);
 
-int mtk_wdma_clk_enable(struct device *dev);
-void mtk_wdma_clk_disable(struct device *dev);
-void mtk_wdma_config(struct device *dev, unsigned int width,
+int mtk_wdma_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_wdma_clk_disable(struct mtk_ddp_comp *comp);
+void mtk_wdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 		     unsigned int height, unsigned int vrefresh,
 		     unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
 unsigned int mtk_wdma_layer_nr(struct device *dev, int pipeline_index);
@@ -208,8 +208,8 @@ void mtk_wdma_disable_vblank(struct device *dev);
 const u32 *mtk_wdma_get_formats(struct device *dev);
 size_t mtk_wdma_get_num_formats(struct device *dev);
 
-int mtk_padding_clk_enable(struct device *dev);
-void mtk_padding_clk_disable(struct device *dev);
+int mtk_padding_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_padding_clk_disable(struct mtk_ddp_comp *comp);
 void mtk_padding_start(struct device *dev);
 void mtk_padding_stop(struct device *dev);
 #endif
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
index 79b66bd7e5f3..19d2e42861f0 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_dsc.c
@@ -135,16 +135,16 @@ struct mtk_dsc {
 	bool dsc_config_done;
 };
 
-int mtk_dsc_clk_enable(struct device *dev)
+int mtk_dsc_clk_enable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_dsc *disp_dsc = dev_get_drvdata(dev);
+	struct mtk_dsc *disp_dsc = dev_get_drvdata(comp->dev);
 
 	return clk_prepare_enable(disp_dsc->clk);
 }
 
-void mtk_dsc_clk_disable(struct device *dev)
+void mtk_dsc_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_dsc *disp_dsc = dev_get_drvdata(dev);
+	struct mtk_dsc *disp_dsc = dev_get_drvdata(comp->dev);
 
 	clk_disable_unprepare(disp_dsc->clk);
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 8afd15006df2..a30a032e6c35 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -64,16 +64,16 @@ struct mtk_disp_gamma {
 	const struct mtk_disp_gamma_data *data;
 };
 
-int mtk_gamma_clk_enable(struct device *dev)
+int mtk_gamma_clk_enable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
+	struct mtk_disp_gamma *gamma = dev_get_drvdata(comp->dev);
 
 	return clk_prepare_enable(gamma->clk);
 }
 
-void mtk_gamma_clk_disable(struct device *dev)
+void mtk_gamma_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
+	struct mtk_disp_gamma *gamma = dev_get_drvdata(comp->dev);
 
 	clk_disable_unprepare(gamma->clk);
 }
@@ -206,11 +206,11 @@ void mtk_gamma_set(struct device *dev, struct drm_crtc_state *state)
 	writel(cfg_val, gamma->regs + DISP_GAMMA_CFG);
 }
 
-void mtk_gamma_config(struct device *dev, unsigned int w,
+void mtk_gamma_config(struct mtk_ddp_comp *comp, unsigned int w,
 		      unsigned int h, unsigned int vrefresh,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
-	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
+	struct mtk_disp_gamma *gamma = dev_get_drvdata(comp->dev);
 	u32 sz;
 
 	sz = FIELD_PREP(DISP_GAMMA_SIZE_HSIZE, w);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
index b174dda091d3..947e5a95947b 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
@@ -126,11 +126,11 @@ static void mtk_merge_fifo_setting(struct mtk_disp_merge *priv,
 			   FLD_PREULTRA_TH_LOW | FLD_PREULTRA_TH_HIGH);
 }
 
-void mtk_merge_config(struct device *dev, unsigned int w,
+void mtk_merge_config(struct mtk_ddp_comp *comp, unsigned int w,
 		      unsigned int h, unsigned int vrefresh,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
-	mtk_merge_advance_config(dev, w, 0, h, vrefresh, bpc, cmdq_pkt);
+	mtk_merge_advance_config(comp->dev, w, 0, h, vrefresh, bpc, cmdq_pkt);
 }
 
 void mtk_merge_advance_config(struct device *dev, unsigned int l_w, unsigned int r_w,
@@ -191,14 +191,14 @@ void mtk_merge_advance_config(struct device *dev, unsigned int l_w, unsigned int
 			   DISP_REG_MERGE_CFG_12, FLD_CFG_MERGE_MODE);
 }
 
-int mtk_merge_clk_enable(struct device *dev)
+int mtk_merge_clk_enable(struct mtk_ddp_comp *comp)
 {
-	int ret = 0;
-	struct mtk_disp_merge *priv = dev_get_drvdata(dev);
+	struct mtk_disp_merge *priv = dev_get_drvdata(comp->dev);
+	int ret;
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret) {
-		dev_err(dev, "merge clk prepare enable failed\n");
+		dev_err(comp->dev, "merge clk prepare enable failed\n");
 		return ret;
 	}
 
@@ -207,16 +207,16 @@ int mtk_merge_clk_enable(struct device *dev)
 		/* should clean up the state of priv->clk */
 		clk_disable_unprepare(priv->clk);
 
-		dev_err(dev, "async clk prepare enable failed\n");
+		dev_err(comp->dev, "async clk prepare enable failed\n");
 		return ret;
 	}
 
 	return ret;
 }
 
-void mtk_merge_clk_disable(struct device *dev)
+void mtk_merge_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_merge *priv = dev_get_drvdata(dev);
+	struct mtk_disp_merge *priv = dev_get_drvdata(comp->dev);
 
 	clk_disable_unprepare(priv->async_clk);
 	clk_disable_unprepare(priv->clk);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 489a209c4e55..5ceba04a30b1 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -260,16 +260,16 @@ bool mtk_ovl_is_afbc_supported(struct device *dev)
 	return ovl->data->supports_afbc;
 }
 
-int mtk_ovl_clk_enable(struct device *dev)
+int mtk_ovl_clk_enable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
+	struct mtk_disp_ovl *ovl = dev_get_drvdata(comp->dev);
 
 	return clk_prepare_enable(ovl->clk);
 }
 
-void mtk_ovl_clk_disable(struct device *dev)
+void mtk_ovl_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
+	struct mtk_disp_ovl *ovl = dev_get_drvdata(comp->dev);
 
 	clk_disable_unprepare(ovl->clk);
 }
@@ -327,11 +327,11 @@ static void mtk_ovl_set_bit_depth(struct device *dev, int idx, u32 format,
 			   OVL_CON_CLRFMT_BIT_DEPTH_MASK(idx));
 }
 
-void mtk_ovl_config(struct device *dev, unsigned int w,
+void mtk_ovl_config(struct mtk_ddp_comp *comp, unsigned int w,
 		    unsigned int h, unsigned int vrefresh,
 		    unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
-	struct mtk_disp_ovl *ovl = dev_get_drvdata(dev);
+	struct mtk_disp_ovl *ovl = dev_get_drvdata(comp->dev);
 
 	if (w != 0 && h != 0)
 		mtk_ddp_write_relaxed(cmdq_pkt, h << 16 | w, &ovl->cmdq_reg, ovl->regs,
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
index 225ab87bca71..e0e956ec56a7 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
@@ -208,11 +208,11 @@ void mtk_ovl_adaptor_layer_config(struct device *dev, unsigned int idx,
 	mtk_ethdr_layer_config(ethdr, idx, state, cmdq_pkt);
 }
 
-void mtk_ovl_adaptor_config(struct device *dev, unsigned int w,
+void mtk_ovl_adaptor_config(struct mtk_ddp_comp *comp, unsigned int w,
 			    unsigned int h, unsigned int vrefresh,
 			    unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
-	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
+	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(comp->dev);
 
 	mtk_ethdr_config(ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_ETHDR0], w, h,
 			 vrefresh, bpc, cmdq_pkt);
@@ -306,41 +306,49 @@ void mtk_ovl_adaptor_power_off(struct device *dev)
 	power_off(dev, OVL_ADAPTOR_ID_MAX);
 }
 
-int mtk_ovl_adaptor_clk_enable(struct device *dev)
+int mtk_ovl_adaptor_clk_enable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
-	struct device *comp;
+	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(comp->dev);
 	int ret;
 	int i;
 
 	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
-		comp = ovl_adaptor->ovl_adaptor_comp[i];
-		if (!comp || !comp_matches[i].funcs->clk_enable)
+		struct mtk_ddp_comp adaptor_comp;
+
+		if (!ovl_adaptor->ovl_adaptor_comp[i] ||
+		    !comp_matches[i].funcs->clk_enable)
 			continue;
-		ret = comp_matches[i].funcs->clk_enable(comp);
+
+		adaptor_comp.dev = ovl_adaptor->ovl_adaptor_comp[i];
+
+		ret = comp_matches[i].funcs->clk_enable(&adaptor_comp);
 		if (ret) {
-			dev_err(dev, "Failed to enable clock %d, err %d\n", i, ret);
+			dev_err(comp->dev, "Failed to enable clock %d, err %d\n", i, ret);
 			while (--i >= 0)
-				comp_matches[i].funcs->clk_disable(comp);
+				comp_matches[i].funcs->clk_disable(&adaptor_comp);
 			return ret;
 		}
 	}
 	return 0;
 }
 
-void mtk_ovl_adaptor_clk_disable(struct device *dev)
+void mtk_ovl_adaptor_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
-	struct device *comp;
+	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(comp->dev);
 	int i;
 
 	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
-		comp = ovl_adaptor->ovl_adaptor_comp[i];
-		if (!comp || !comp_matches[i].funcs->clk_disable)
+		struct mtk_ddp_comp adaptor_comp;
+
+		if (!ovl_adaptor->ovl_adaptor_comp[i] ||
+		    !comp_matches[i].funcs->clk_disable)
 			continue;
-		comp_matches[i].funcs->clk_disable(comp);
+
+		adaptor_comp.dev = ovl_adaptor->ovl_adaptor_comp[i];
+
+		comp_matches[i].funcs->clk_disable(&adaptor_comp);
 		if (i < OVL_ADAPTOR_MERGE0)
-			pm_runtime_put(comp);
+			pm_runtime_put(adaptor_comp.dev);
 	}
 }
 
@@ -423,10 +431,10 @@ size_t mtk_ovl_adaptor_get_num_formats(struct device *dev)
 	return mtk_mdp_rdma_get_num_formats(ovl_adaptor->ovl_adaptor_comp[OVL_ADAPTOR_MDP_RDMA0]);
 }
 
-void mtk_ovl_adaptor_add_comp(struct device *dev, struct mtk_mutex *mutex)
+void mtk_ovl_adaptor_add_comp(struct mtk_ddp_comp *comp, struct mtk_mutex *mutex)
 {
 	int i;
-	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
+	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(comp->dev);
 
 	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
 		if (!ovl_adaptor->ovl_adaptor_comp[i])
@@ -439,10 +447,10 @@ void mtk_ovl_adaptor_add_comp(struct device *dev, struct mtk_mutex *mutex)
 	}
 }
 
-void mtk_ovl_adaptor_remove_comp(struct device *dev, struct mtk_mutex *mutex)
+void mtk_ovl_adaptor_remove_comp(struct mtk_ddp_comp *comp, struct mtk_mutex *mutex)
 {
 	int i;
-	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(dev);
+	struct mtk_disp_ovl_adaptor *ovl_adaptor = dev_get_drvdata(comp->dev);
 
 	for (i = 0; i < OVL_ADAPTOR_ID_MAX; i++) {
 		if (!ovl_adaptor->ovl_adaptor_comp[i])
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index dce7a9bc3f11..4b6ecd9bdd5f 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -157,16 +157,16 @@ size_t mtk_rdma_get_num_formats(struct device *dev)
 	return rdma->data->num_formats;
 }
 
-int mtk_rdma_clk_enable(struct device *dev)
+int mtk_rdma_clk_enable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_rdma *rdma = dev_get_drvdata(dev);
+	struct mtk_disp_rdma *rdma = dev_get_drvdata(comp->dev);
 
 	return clk_prepare_enable(rdma->clk);
 }
 
-void mtk_rdma_clk_disable(struct device *dev)
+void mtk_rdma_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_rdma *rdma = dev_get_drvdata(dev);
+	struct mtk_disp_rdma *rdma = dev_get_drvdata(comp->dev);
 
 	clk_disable_unprepare(rdma->clk);
 }
@@ -182,13 +182,13 @@ void mtk_rdma_stop(struct device *dev)
 	rdma_update_bits(dev, DISP_REG_RDMA_GLOBAL_CON, RDMA_ENGINE_EN, 0);
 }
 
-void mtk_rdma_config(struct device *dev, unsigned int width,
+void mtk_rdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 		     unsigned int height, unsigned int vrefresh,
 		     unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
 	unsigned int threshold;
 	unsigned int reg;
-	struct mtk_disp_rdma *rdma = dev_get_drvdata(dev);
+	struct mtk_disp_rdma *rdma = dev_get_drvdata(comp->dev);
 	u32 rdma_fifo_size;
 
 	mtk_ddp_write_mask(cmdq_pkt, width, &rdma->cmdq_reg, rdma->regs,
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_wdma.c b/drivers/gpu/drm/mediatek/mtk_disp_wdma.c
index 26c80e7e152b..d5ebd3e3d80f 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_wdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_wdma.c
@@ -189,16 +189,16 @@ size_t mtk_wdma_get_num_formats(struct device *dev)
 	return wdma->data->num_formats;
 }
 
-int mtk_wdma_clk_enable(struct device *dev)
+int mtk_wdma_clk_enable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_wdma *wdma = dev_get_drvdata(dev);
+	struct mtk_disp_wdma *wdma = dev_get_drvdata(comp->dev);
 
 	return clk_prepare_enable(wdma->clk);
 }
 
-void mtk_wdma_clk_disable(struct device *dev)
+void mtk_wdma_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_disp_wdma *wdma = dev_get_drvdata(dev);
+	struct mtk_disp_wdma *wdma = dev_get_drvdata(comp->dev);
 
 	clk_disable_unprepare(wdma->clk);
 }
@@ -214,11 +214,11 @@ void mtk_wdma_stop(struct device *dev)
 	wdma_update_bits(dev, DISP_REG_WDMA_EN, WDMA_ENGINE_EN, 0);
 }
 
-void mtk_wdma_config(struct device *dev, unsigned int width,
+void mtk_wdma_config(struct mtk_ddp_comp *comp, unsigned int width,
 		     unsigned int height, unsigned int vrefresh,
 		     unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
-	struct mtk_disp_wdma *wdma = dev_get_drvdata(dev);
+	struct mtk_disp_wdma *wdma = dev_get_drvdata(comp->dev);
 
 	writel(WDMA_FORCE_COMMIT | WDMA_BYPASS_SHADOW,
 	       wdma->regs + DISP_REG_WDMA_SHADOW_CTRL);
diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 96832d0cca37..aa257c3780b6 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -281,21 +281,21 @@ void mtk_ethdr_stop(struct device *dev)
 	writel(0, mixer->regs + MIX_RST);
 }
 
-int mtk_ethdr_clk_enable(struct device *dev)
+int mtk_ethdr_clk_enable(struct mtk_ddp_comp *comp)
 {
 	int ret;
-	struct mtk_ethdr *priv = dev_get_drvdata(dev);
+	struct mtk_ethdr *priv = dev_get_drvdata(comp->dev);
 
 	ret = clk_bulk_prepare_enable(ETHDR_CLK_NUM, priv->ethdr_clk);
 	if (ret)
-		dev_err(dev,
+		dev_err(comp->dev,
 			"ethdr_clk prepare enable failed\n");
 	return ret;
 }
 
-void mtk_ethdr_clk_disable(struct device *dev)
+void mtk_ethdr_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_ethdr *priv = dev_get_drvdata(dev);
+	struct mtk_ethdr *priv = dev_get_drvdata(comp->dev);
 
 	clk_bulk_disable_unprepare(ETHDR_CLK_NUM, priv->ethdr_clk);
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.h b/drivers/gpu/drm/mediatek/mtk_ethdr.h
index a72aeee46829..b81b75a092c1 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.h
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.h
@@ -8,8 +8,8 @@
 
 void mtk_ethdr_start(struct device *dev);
 void mtk_ethdr_stop(struct device *dev);
-int mtk_ethdr_clk_enable(struct device *dev);
-void mtk_ethdr_clk_disable(struct device *dev);
+int mtk_ethdr_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_ethdr_clk_disable(struct mtk_ddp_comp *comp);
 void mtk_ethdr_config(struct device *dev, unsigned int w,
 		      unsigned int h, unsigned int vrefresh,
 		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
index 7982788ae9df..62cc0abca5f3 100644
--- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
@@ -258,16 +258,16 @@ void mtk_mdp_rdma_power_off(struct device *dev)
 	pm_runtime_put(dev);
 }
 
-int mtk_mdp_rdma_clk_enable(struct device *dev)
+int mtk_mdp_rdma_clk_enable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_mdp_rdma *rdma = dev_get_drvdata(dev);
+	struct mtk_mdp_rdma *rdma = dev_get_drvdata(comp->dev);
 
 	return clk_prepare_enable(rdma->clk);
 }
 
-void mtk_mdp_rdma_clk_disable(struct device *dev)
+void mtk_mdp_rdma_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_mdp_rdma *rdma = dev_get_drvdata(dev);
+	struct mtk_mdp_rdma *rdma = dev_get_drvdata(comp->dev);
 
 	clk_disable_unprepare(rdma->clk);
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_padding.c b/drivers/gpu/drm/mediatek/mtk_padding.c
index b4e3e5a3428b..95183600d150 100644
--- a/drivers/gpu/drm/mediatek/mtk_padding.c
+++ b/drivers/gpu/drm/mediatek/mtk_padding.c
@@ -38,16 +38,16 @@ struct mtk_padding {
 	struct cmdq_client_reg	cmdq_reg;
 };
 
-int mtk_padding_clk_enable(struct device *dev)
+int mtk_padding_clk_enable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_padding *padding = dev_get_drvdata(dev);
+	struct mtk_padding *padding = dev_get_drvdata(comp->dev);
 
 	return clk_prepare_enable(padding->clk);
 }
 
-void mtk_padding_clk_disable(struct device *dev)
+void mtk_padding_clk_disable(struct mtk_ddp_comp *comp)
 {
-	struct mtk_padding *padding = dev_get_drvdata(dev);
+	struct mtk_padding *padding = dev_get_drvdata(comp->dev);
 
 	clk_disable_unprepare(padding->clk);
 }
-- 
2.54.0

