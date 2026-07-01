Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B35C44506
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B1C10EF71;
	Wed,  1 Jul 2026 12:21:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JJI0Vbm+";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8767A10EF72
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908499;
 bh=Qeno2l8N+ioUaRPaFlMfs/IlW8Ev+IkQ/70zshGvKsA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JJI0Vbm+ni+r4XX99iWt1MYBNBLbWxOGNpKkfUM0Pfp+DkTOtz8O/yZsLDm4Kfp50
 TSjlwbuR47ttnrYVKybxeGS8zNsoSsEb6BuC23cQWO5B5bvuA7AlILRSwk6p2E/Lln
 Lsb3g2bg/4RKc1zp3YuLSCL5SXTbu6SiiKd3/jwkMpf9dX/xQn4qz2jf4qCYTo5R8R
 cUdbVz0rLkzzUAXl2xV6oepEfOOoV8+0SpK63Hi/xRUUAAqWQzh5OUam5ABR5DtnVD
 XYMob+/iziGrb359SePyfi73bZhla7nZXQLgrtPof8TAVOKrV9RjLrNXAbYLGECrPa
 azw6NJ37+mTWA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3174717E1411;
 Wed,  1 Jul 2026 14:21:38 +0200 (CEST)
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
Subject: [PATCH 27/42] drm/mediatek: Add support for Display Layer Blender
 component
Date: Wed,  1 Jul 2026 14:20:42 +0200
Message-ID: <20260701122057.19648-28-angelogioacchino.delregno@collabora.com>
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

Add support for the Layer Blender hardware component, found in the
MediaTek Kompanio Ultra MT8196, Genio Pro 5100 MT8894, Dimensity
9400 MT6991 and others.

This component is responsible for managing blending of single
layer stages and therefore implements one full layer stage which
gets completed by an exDMA hardware component.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/Makefile           |   1 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c     |  14 +
 drivers/gpu/drm/mediatek/mtk_disp_blender.c | 318 ++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  15 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   3 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
 include/linux/soc/mediatek/mtk-mmsys.h      |   1 +
 7 files changed, 353 insertions(+)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_blender.c

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index c48ac3ab08cc..a3c1285e8f33 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -3,6 +3,7 @@
 mediatek-drm-y := mtk_crtc.o \
 		  mtk_ddp_comp.o \
 		  mtk_disp_aal.o \
+		  mtk_disp_blender.o \
 		  mtk_disp_ccorr.o \
 		  mtk_disp_color.o \
 		  mtk_disp_dsc.o \
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index 8b9228084828..6a312f3ddb09 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -246,6 +246,18 @@ static const struct mtk_ddp_comp_funcs ddp_aal = {
 	.stop = mtk_aal_stop,
 };
 
+static const struct mtk_ddp_comp_funcs ddp_blender = {
+	.clk_enable = mtk_blender_clk_enable,
+	.clk_disable = mtk_blender_clk_disable,
+	.config = mtk_blender_config,
+	.start = mtk_blender_start,
+	.stop = mtk_blender_stop,
+	.layer_config = mtk_blender_layer_config,
+	.get_blend_modes = mtk_blender_get_blend_modes,
+	.layerstage_nr = mtk_blender_layerstage_nr,
+	.connect = mtk_blender_connect,
+};
+
 static const struct mtk_ddp_comp_funcs ddp_ccorr = {
 	.clk_enable = mtk_ccorr_clk_enable,
 	.clk_disable = mtk_ccorr_clk_disable,
@@ -416,6 +428,7 @@ static const struct mtk_ddp_comp_funcs ddp_ovl_adaptor = {
 
 static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_AAL] = "aal",
+	[MTK_DISP_BLENDER] = "blender",
 	[MTK_DISP_BLS] = "bls",
 	[MTK_DISP_CCORR] = "ccorr",
 	[MTK_DISP_COLOR] = "color",
@@ -441,6 +454,7 @@ static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
 
 static const struct mtk_ddp_comp_funcs *mtk_ddp_funcs[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_AAL]			= &ddp_aal,
+	[MTK_DISP_BLENDER]		= &ddp_blender,
 	[MTK_DISP_BLS]			= NULL,
 	[MTK_DISP_CCORR]		= &ddp_ccorr,
 	[MTK_DISP_COLOR]		= &ddp_color,
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_blender.c b/drivers/gpu/drm/mediatek/mtk_disp_blender.c
new file mode 100644
index 000000000000..74679b15a26c
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_disp_blender.c
@@ -0,0 +1,318 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ * Copyright (c) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <drm/drm_blend.h>
+#include <drm/drm_fourcc.h>
+#include <drm/drm_framebuffer.h>
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
+#include <linux/soc/mediatek/mtk-mmsys.h>
+
+#include "mtk_crtc.h"
+#include "mtk_ddp_comp.h"
+#include "mtk_disp_drv.h"
+#include "mtk_disp_ovl.h"
+#include "mtk_drm_drv.h"
+
+#define DISP_REG_OVL_BLD_DATAPATH_CON		0x010
+#  define OVL_BLD_BGCLR_IN_SEL			BIT(0)
+#  define OVL_BLD_BGCLR_OUT_TO_PROC		BIT(4)
+#  define OVL_BLD_BGCLR_OUT_TO_NEXT_LAYER	BIT(5)
+
+#define DISP_REG_OVL_BLD_EN			0x020
+#  define OVL_BLD_EN				BIT(0)
+#  define OVL_BLD_FORCE_RELAY_MODE		BIT(4)
+#  define OVL_BLD_RELAY_MODE			BIT(5)
+
+#define DISP_REG_OVL_BLD_RST			0x024
+#  define OVL_BLD_RST				BIT(0)
+
+#define DISP_REG_OVL_BLD_SHADOW_CTRL		0x028
+#  define OVL_BLD_BYPASS_SHADOW			BIT(2)
+
+#define DISP_REG_OVL_BLD_ROI_SIZE		0x030
+#define DISP_REG_OVL_BLD_L_EN			0x040
+#  define OVL_BLD_L_EN				BIT(0)
+
+#define DISP_REG_OVL_BLD_OFFSET			0x044
+#define DISP_REG_OVL_BLD_SRC_SIZE		0x048
+#define DISP_REG_OVL_BLD_L0_CLRFMT		0x050
+#  define OVL_BLD_CON_FLD_CLRFMT		GENMASK(3, 0)
+#  define OVL_BLD_CON_CLRFMT_MAN		BIT(4)
+#  define OVL_BLD_CON_FLD_CLRFMT_NB		GENMASK(9, 8)
+#  define OVL_BLD_CON_CLRFMT_NB_10_BIT		BIT(8)
+#  define OVL_BLD_CON_BYTE_SWAP			BIT(16)
+#  define OVL_BLD_CON_RGB_SWAP			BIT(17)
+
+#define DISP_REG_OVL_BLD_BGCLR_CLR		0x104
+#define DISP_REG_OVL_BLD_L_CON2			0x200
+#  define OVL_BLD_L_ALPHA			GENMASK(7, 0)
+#  define OVL_BLD_L_ALPHA_EN			BIT(12)
+
+#define DISP_REG_OVL_BLD_L0_ALPHA_SEL		0x208
+#  define OVL_BLD_L0_CONST			BIT(24)
+
+#define DISP_REG_OVL_BLD_L0_CLR			0x20c
+#  define OVL_BLD_BGCLR_BLACK			0xff000000
+#  define OVL_BLD_BGCLR_RED			0xffff0000
+
+#define BLENDER_MAX_SIZE 8191
+
+struct mtk_disp_blender {
+	void __iomem *regs;
+	struct clk *clk;
+	struct cmdq_client_reg cmdq_reg;
+};
+
+static void mtk_blender_unset_input_bgclr(struct mtk_disp_blender *priv)
+{
+	u32 val;
+
+	val = readl(priv->regs + DISP_REG_OVL_BLD_DATAPATH_CON);
+	val &= ~OVL_BLD_BGCLR_IN_SEL;
+	writel(val, priv->regs + DISP_REG_OVL_BLD_DATAPATH_CON);
+}
+
+void mtk_blender_layer_config(struct device *dev, unsigned int idx,
+			      struct mtk_plane_state *state,
+			      struct cmdq_pkt *cmdq_pkt)
+{
+	struct mtk_disp_blender *priv = dev_get_drvdata(dev);
+	struct mtk_plane_pending_state *pending = &state->pending;
+	u32 alpha, blend_mode, clrfmt, ignore_pixel_alpha;
+
+	/*
+	 * Deselect IN from OVL Background Color if this is the first Blender
+	 * to implicitly select input from exDMA instead.
+	 */
+	if (idx == 0)
+		mtk_blender_unset_input_bgclr(priv);
+
+	if (!pending->enable || pending->height == 0 || pending->width == 0 ||
+	    pending->x > BLENDER_MAX_SIZE || pending->y > BLENDER_MAX_SIZE) {
+		mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs, DISP_REG_OVL_BLD_L_EN);
+		return;
+	}
+
+	mtk_ddp_write(cmdq_pkt,
+		      ((pending->height & GENMASK(15, 0)) << 16) |
+		       (pending->width & GENMASK(15, 0)),
+		      &priv->cmdq_reg, priv->regs, DISP_REG_OVL_BLD_SRC_SIZE);
+	mtk_ddp_write(cmdq_pkt,
+		      ((pending->y & GENMASK(15, 0)) << 16) | (pending->x & GENMASK(15, 0)),
+		      &priv->cmdq_reg, priv->regs, DISP_REG_OVL_BLD_OFFSET);
+
+	blend_mode = mtk_ovl_get_blend_mode(state, MTK_OVL_SUPPORT_BLEND_MODES);
+	clrfmt = mtk_ovl_fmt_convert(pending->format, blend_mode, true, false, 0,
+				     OVL_BLD_CON_CLRFMT_MAN, OVL_BLD_CON_BYTE_SWAP,
+				     OVL_BLD_CON_RGB_SWAP);
+	clrfmt |= mtk_ovl_is_10bit_rgb(pending->format) ? OVL_BLD_CON_CLRFMT_NB_10_BIT : 0;
+	mtk_ddp_write_mask(cmdq_pkt, clrfmt, &priv->cmdq_reg, priv->regs,
+			   DISP_REG_OVL_BLD_L0_CLRFMT, OVL_BLD_CON_CLRFMT_MAN |
+			   OVL_BLD_CON_RGB_SWAP |  OVL_BLD_CON_BYTE_SWAP |
+			   OVL_BLD_CON_FLD_CLRFMT | OVL_BLD_CON_FLD_CLRFMT_NB);
+
+	if (mtk_ovl_is_ignore_pixel_alpha(state, blend_mode))
+		ignore_pixel_alpha = OVL_BLD_L0_CONST;
+	else
+		ignore_pixel_alpha = 0;
+
+	mtk_ddp_write_mask(cmdq_pkt, ignore_pixel_alpha, &priv->cmdq_reg, priv->regs,
+			   DISP_REG_OVL_BLD_L0_ALPHA_SEL, OVL_BLD_L0_CONST);
+
+	alpha = FIELD_PREP(OVL_BLD_L_ALPHA, (state->base.alpha >> 8));
+	alpha |= OVL_BLD_L_ALPHA_EN;
+	mtk_ddp_write_mask(cmdq_pkt, alpha, &priv->cmdq_reg, priv->regs,
+			   DISP_REG_OVL_BLD_L_CON2, OVL_BLD_L_ALPHA_EN | OVL_BLD_L_ALPHA);
+
+	mtk_ddp_write(cmdq_pkt, OVL_BLD_L_EN, &priv->cmdq_reg, priv->regs, DISP_REG_OVL_BLD_L_EN);
+}
+
+unsigned int mtk_blender_layerstage_nr(struct device *dev)
+{
+	return 1;
+}
+
+void mtk_blender_start(struct device *dev)
+{
+	struct mtk_disp_blender *priv = dev_get_drvdata(dev);
+	u32 val;
+
+	/* Bypass shadow registers and enable */
+	val = readl(priv->regs + DISP_REG_OVL_BLD_SHADOW_CTRL);
+	val |= OVL_BLD_BYPASS_SHADOW;
+	writel(val, priv->regs + DISP_REG_OVL_BLD_SHADOW_CTRL);
+
+	val = readl(priv->regs + DISP_REG_OVL_BLD_EN);
+	val |= OVL_BLD_EN;
+	writel(val, priv->regs + DISP_REG_OVL_BLD_EN);
+}
+
+void mtk_blender_stop(struct device *dev)
+{
+	struct mtk_disp_blender *priv = dev_get_drvdata(dev);
+	u32 val;
+
+	/* Disable and reset */
+	val = readl(priv->regs + DISP_REG_OVL_BLD_EN);
+	val = val & ~OVL_BLD_EN;
+	writel(val, priv->regs + DISP_REG_OVL_BLD_EN);
+
+	val = readl(priv->regs + DISP_REG_OVL_BLD_RST);
+	val |= OVL_BLD_RST;
+	writel(val, priv->regs + DISP_REG_OVL_BLD_RST);
+
+	val = readl(priv->regs + DISP_REG_OVL_BLD_RST);
+	val = val & ~OVL_BLD_RST;
+	writel(val, priv->regs + DISP_REG_OVL_BLD_RST);
+}
+
+void mtk_blender_config(struct mtk_ddp_comp *comp, unsigned int w,
+			     unsigned int h, unsigned int vrefresh,
+			     unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
+{
+	struct mtk_disp_blender *priv = dev_get_drvdata(comp->dev);
+	u32 val;
+
+	/* Set ROI for this Blender */
+	val = ((h & GENMASK(15, 0)) << 16) | (w & GENMASK(15, 0));
+	writel(val, priv->regs + DISP_REG_OVL_BLD_ROI_SIZE);
+
+	/*
+	 * Set both background color and constant layer color to Opaque Black
+	 * (ARGB) for eventual Alpha Blending to be effective
+	 */
+	writel(OVL_BLD_BGCLR_BLACK, priv->regs + DISP_REG_OVL_BLD_BGCLR_CLR);
+	writel(OVL_BLD_BGCLR_BLACK, priv->regs + DISP_REG_OVL_BLD_L0_CLR);
+}
+
+void mtk_blender_connect(struct mtk_ddp_comp *comp, struct device *mmsys_dev,
+			      struct mtk_ddp_comp *next)
+{
+	struct mtk_disp_blender *priv = dev_get_drvdata(comp->dev);
+	const u32 mask = OVL_BLD_BGCLR_OUT_TO_PROC |
+			 OVL_BLD_BGCLR_OUT_TO_NEXT_LAYER |
+			 OVL_BLD_BGCLR_IN_SEL;
+	u32 data_path = OVL_BLD_BGCLR_IN_SEL;
+	u32 val;
+
+	/* Usually the next component is either another OUTPROC or an exDMA */
+	if (next->type == MTK_DISP_OUTPROC)
+		data_path |= OVL_BLD_BGCLR_OUT_TO_PROC;
+	else
+		data_path |= OVL_BLD_BGCLR_OUT_TO_NEXT_LAYER;
+
+	val = readl(priv->regs + DISP_REG_OVL_BLD_DATAPATH_CON);
+	val = (val & ~mask) | data_path;
+	writel(val, priv->regs + DISP_REG_OVL_BLD_DATAPATH_CON);
+
+	mtk_mmsys_hw_connect(mmsys_dev,
+			     comp->type, comp->inst_id, next->type, next->inst_id);
+}
+
+int mtk_blender_clk_enable(struct mtk_ddp_comp *comp)
+{
+	struct mtk_disp_blender *priv = dev_get_drvdata(comp->dev);
+
+	return clk_prepare_enable(priv->clk);
+}
+
+void mtk_blender_clk_disable(struct mtk_ddp_comp *comp)
+{
+	struct mtk_disp_blender *priv = dev_get_drvdata(comp->dev);
+
+	clk_disable_unprepare(priv->clk);
+}
+
+u32 mtk_blender_get_blend_modes(struct device *dev)
+{
+	return MTK_OVL_SUPPORT_BLEND_MODES;
+}
+
+static int mtk_blender_bind(struct device *dev, struct device *master,
+				 void *data)
+{
+	return 0;
+}
+
+static void mtk_blender_unbind(struct device *dev, struct device *master, void *data)
+{
+}
+
+static const struct component_ops mtk_disp_blender_component_ops = {
+	.bind	= mtk_blender_bind,
+	.unbind = mtk_blender_unbind,
+};
+
+static int mtk_blender_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_disp_blender *priv;
+	int ret = 0;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->regs))
+		return dev_err_probe(dev, PTR_ERR(priv->regs), "Cannot get reg\n");
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk), "Cannot get clocks\n");
+
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	ret = cmdq_dev_get_client_reg(dev, &priv->cmdq_reg, 0);
+	if (ret)
+		dev_dbg(dev, "No mediatek,gce-client-reg\n");
+#endif
+	platform_set_drvdata(pdev, priv);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = component_add(dev, &mtk_disp_blender_component_ops);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add component\n");
+
+	return 0;
+}
+
+static void mtk_blender_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &mtk_disp_blender_component_ops);
+}
+
+static const struct of_device_id mtk_disp_blender_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt8196-disp-blender" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mtk_disp_blender_driver_dt_match);
+
+struct platform_driver mtk_disp_blender_driver = {
+	.probe		= mtk_blender_probe,
+	.remove		= mtk_blender_remove,
+	.driver		= {
+		.name	= "mediatek-disp-blender",
+		.owner	= THIS_MODULE,
+		.of_match_table = mtk_disp_blender_driver_dt_match,
+	},
+};
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_AUTHOR("Nancy Lin <nancy.lin@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek Display Controller Layer Blender Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index 62daf5ade9d1..e834bf17d86c 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -27,6 +27,21 @@ void mtk_aal_gamma_set(struct device *dev, struct drm_crtc_state *state);
 void mtk_aal_start(struct device *dev);
 void mtk_aal_stop(struct device *dev);
 
+int mtk_blender_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_blender_clk_disable(struct mtk_ddp_comp *comp);
+void mtk_blender_connect(struct mtk_ddp_comp *comp, struct device *mmsys_dev,
+			 struct mtk_ddp_comp *next);
+void mtk_blender_config(struct mtk_ddp_comp *comp, unsigned int w,
+			unsigned int h, unsigned int vrefresh,
+			unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
+u32 mtk_blender_get_blend_modes(struct device *dev);
+void mtk_blender_layer_config(struct device *dev, unsigned int idx,
+				   struct mtk_plane_state *state,
+				   struct cmdq_pkt *cmdq_pkt);
+unsigned int mtk_blender_layerstage_nr(struct device *dev);
+void mtk_blender_start(struct device *dev);
+void mtk_blender_stop(struct device *dev);
+
 void mtk_ccorr_ctm_set(struct device *dev, struct drm_crtc_state *state);
 int mtk_ccorr_clk_enable(struct mtk_ddp_comp *comp);
 void mtk_ccorr_clk_disable(struct mtk_ddp_comp *comp);
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index ee835ebbc18c..a70392c54bb9 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -503,6 +503,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_AAL},
 	{ .compatible = "mediatek,mt8192-disp-aal",
 	  .data = (void *)MTK_DISP_AAL},
+	{ .compatible = "mediatek,mt8196-disp-blender",
+	  .data = (void *)MTK_DISP_BLENDER },
 	{ .compatible = "mediatek,mt8167-disp-ccorr",
 	  .data = (void *)MTK_DISP_CCORR },
 	{ .compatible = "mediatek,mt8183-disp-ccorr",
@@ -1059,6 +1061,7 @@ static struct platform_driver mtk_drm_platform_driver = {
 
 static struct platform_driver * const mtk_drm_drivers[] = {
 	&mtk_disp_aal_driver,
+	&mtk_disp_blender_driver,
 	&mtk_disp_ccorr_driver,
 	&mtk_disp_color_driver,
 	&mtk_disp_dsc_driver,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index 4028268b3cc8..f36888fd7244 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -73,6 +73,7 @@ struct mtk_drm_private {
 };
 
 extern struct platform_driver mtk_disp_aal_driver;
+extern struct platform_driver mtk_disp_blender_driver;
 extern struct platform_driver mtk_disp_ccorr_driver;
 extern struct platform_driver mtk_disp_color_driver;
 extern struct platform_driver mtk_disp_dsc_driver;
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 0b3bef392ab8..b32f0c92f040 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -88,6 +88,7 @@ enum mtk_ddp_comp_type {
 	/* DISP Components */
 	MTK_DISP_AAL,
 	MTK_DISP_BLS,
+	MTK_DISP_BLENDER,
 	MTK_DISP_CCORR,
 	MTK_DISP_COLOR,
 	MTK_DISP_DITHER,
-- 
2.54.0

