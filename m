Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5185DC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95F1C10EF6B;
	Wed,  1 Jul 2026 12:21:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="AyXeMM9w";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B2E10EF73
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908504;
 bh=n8Y1F/7yJz5bZfK3i2dMMM7pnc4ZZ3VfCwKaBMTtCrI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AyXeMM9weop3co4ZggBCG4/ONXUSUnIkhPL+BITnWYy8i/wMcW5agZ1w3erk+Z5EN
 LPT6S3IpsoV1eEiriTncD/Avq1wnNz7irQ91otmh1SE/XlJBBb8hglsSRw7DOO0MHk
 Y9qVgGAlUydopnlagf93FmGqjmPxTMGwiMOOGhzHKS3QgnY2DkeluSKqHQb1BCOYxR
 TA1R1dm15W+pfcXFwzxWrkQIMKb9JvCs2LMzlM3vKtJCltKarMv/EcJ0QWf5+iONY8
 +kejXJmeUuDnw2A2Xy38z92QN10P9lPqCR27R3J3er6vqY02OxC0BjtcK8pL+OMtpA
 3aeIK/DVxviEA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CEC6B17E35CD;
 Wed,  1 Jul 2026 14:21:42 +0200 (CEST)
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
Subject: [PATCH 31/42] drm/mediatek: Add support for Display Output Processor
 component
Date: Wed,  1 Jul 2026 14:20:46 +0200
Message-ID: <20260701122057.19648-32-angelogioacchino.delregno@collabora.com>
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

Add support for the Display Output Processor hardware component,
found in the MediaTek Kompanio Ultra MT8196, Genio Pro 5100 MT8894,
Dimensity 9400 MT6991 and others.

This hardware handles the post-stage of pixel processing in the
layer overlaying process and is also capable of performing gamma
correction, ensuring that the per-pixel values are within the
expected gamma range.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/Makefile           |   1 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c     |  14 ++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h     |  14 ++
 drivers/gpu/drm/mediatek/mtk_disp_outproc.c | 247 ++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c      |   3 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.h      |   1 +
 include/linux/soc/mediatek/mtk-mmsys.h      |   1 +
 7 files changed, 281 insertions(+)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_outproc.c

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index 5506f306a7b6..bec46e981ae1 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -10,6 +10,7 @@ mediatek-drm-y := mtk_crtc.o \
 		  mtk_disp_exdma.o \
 		  mtk_disp_gamma.o \
 		  mtk_disp_merge.o \
+		  mtk_disp_outproc.o \
 		  mtk_disp_ovl.o \
 		  mtk_disp_ovl_adaptor.o \
 		  mtk_disp_rdma.o \
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index 9896420f902d..0ecb942d6129 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -345,6 +345,18 @@ static const struct mtk_ddp_comp_funcs ddp_od = {
 	.start = mtk_od_start,
 };
 
+static const struct mtk_ddp_comp_funcs ddp_outproc = {
+	.clk_enable = mtk_outproc_clk_enable,
+	.clk_disable = mtk_outproc_clk_disable,
+	.start = mtk_outproc_start,
+	.stop = mtk_outproc_stop,
+	.config = mtk_outproc_config,
+	.register_vblank_cb = mtk_outproc_register_vblank_cb,
+	.unregister_vblank_cb = mtk_outproc_unregister_vblank_cb,
+	.enable_vblank = mtk_outproc_enable_vblank,
+	.disable_vblank = mtk_outproc_disable_vblank,
+};
+
 static const struct mtk_ddp_comp_funcs ddp_ovl = {
 	.clk_enable = mtk_ovl_clk_enable,
 	.clk_disable = mtk_ovl_clk_disable,
@@ -451,6 +463,7 @@ static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_MERGE] = "merge",
 	[MTK_DISP_MUTEX] = "mutex",
 	[MTK_DISP_OD] = "od",
+	[MTK_DISP_OUTPROC] = "outproc",
 	[MTK_DISP_OVL] = "ovl",
 	[MTK_DISP_OVL_2L] = "ovl-2l",
 	[MTK_DISP_OVL_ADAPTOR] = "ovl_adaptor",
@@ -477,6 +490,7 @@ static const struct mtk_ddp_comp_funcs *mtk_ddp_funcs[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_GAMMA]		= &ddp_gamma,
 	[MTK_DISP_MERGE]		= &ddp_merge,
 	[MTK_DISP_OD]			= &ddp_od,
+	[MTK_DISP_OUTPROC]		= &ddp_outproc,
 	[MTK_DISP_OVL]			= &ddp_ovl,
 	[MTK_DISP_OVL_2L]		= &ddp_ovl,
 	[MTK_DISP_OVL_ADAPTOR]		= &ddp_ovl_adaptor,
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index df4357b0954b..7b16f46ce9e2 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -121,6 +121,20 @@ void mtk_merge_stop_cmdq(struct device *dev, struct cmdq_pkt *cmdq_pkt);
 enum drm_mode_status mtk_merge_mode_valid(struct device *dev,
 					  const struct drm_display_mode *mode);
 
+void mtk_outproc_start(struct device *dev);
+void mtk_outproc_stop(struct device *dev);
+int mtk_outproc_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_outproc_clk_disable(struct mtk_ddp_comp *comp);
+void mtk_outproc_config(struct mtk_ddp_comp *comp, unsigned int w,
+			     unsigned int h, unsigned int vrefresh,
+			     unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
+void mtk_outproc_register_vblank_cb(struct device *dev,
+					 void (*vblank_cb)(void *),
+					 void *vblank_cb_data);
+void mtk_outproc_unregister_vblank_cb(struct device *dev);
+void mtk_outproc_enable_vblank(struct device *dev);
+void mtk_outproc_disable_vblank(struct device *dev);
+
 void mtk_ovl_bgclr_in_on(struct device *dev);
 void mtk_ovl_bgclr_in_off(struct device *dev);
 void mtk_ovl_bypass_shadow(struct device *dev);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_outproc.c b/drivers/gpu/drm/mediatek/mtk_disp_outproc.c
new file mode 100644
index 000000000000..b8eeefd69964
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_disp_outproc.c
@@ -0,0 +1,247 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 MediaTek Inc.
+ *                    Nancy Lin <nancy.lin@mediatek.com>
+ * Copyright (c) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
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
+#include "mtk_drm_drv.h"
+
+#define DISP_REG_OVL_OUTPROC_INTEN			0x004
+#define DISP_REG_OVL_OUTPROC_INTSTA			0x008
+#  define OVL_OUTPROC_FME_CPL_INTEN			BIT(1)
+
+#define DISP_REG_OVL_OUTPROC_DATAPATH_CON		0x010
+#  define OVL_OUTPROC_DATAPATH_CON_OUTPUT_CLAMP		BIT(26)
+
+#define DISP_REG_OVL_OUTPROC_EN				0x020
+#  define OVL_OUTPROC_OVL_EN				BIT(0)
+
+#define DISP_REG_OVL_OUTPROC_RST			0x024
+#  define OVL_OUTPROC_RST				BIT(0)
+
+#define DISP_REG_OVL_OUTPROC_SHADOW_CTRL		0x028
+#  define OVL_OUTPROC_BYPASS_SHADOW			BIT(2)
+
+#define DISP_REG_OVL_OUTPROC_ROI_SIZE			0x030
+
+struct mtk_disp_outproc {
+	void __iomem		*regs;
+	struct clk		*clk;
+	void			(*vblank_cb)(void *data);
+	void			*vblank_cb_data;
+	int			irq;
+	struct cmdq_client_reg	cmdq_reg;
+};
+
+void mtk_outproc_register_vblank_cb(struct device *dev, void (*vblank_cb)(void *),
+				    void *vblank_cb_data)
+{
+	struct mtk_disp_outproc *priv = dev_get_drvdata(dev);
+
+	priv->vblank_cb = vblank_cb;
+	priv->vblank_cb_data = vblank_cb_data;
+}
+
+void mtk_outproc_unregister_vblank_cb(struct device *dev)
+{
+	struct mtk_disp_outproc *priv = dev_get_drvdata(dev);
+
+	priv->vblank_cb = NULL;
+	priv->vblank_cb_data = NULL;
+}
+
+void mtk_outproc_enable_vblank(struct device *dev)
+{
+	struct mtk_disp_outproc *priv = dev_get_drvdata(dev);
+
+	writel(0x0, priv->regs + DISP_REG_OVL_OUTPROC_INTSTA);
+	writel(OVL_OUTPROC_FME_CPL_INTEN, priv->regs + DISP_REG_OVL_OUTPROC_INTEN);
+}
+
+void mtk_outproc_disable_vblank(struct device *dev)
+{
+	struct mtk_disp_outproc *priv = dev_get_drvdata(dev);
+
+	writel(0x0, priv->regs + DISP_REG_OVL_OUTPROC_INTEN);
+}
+
+static irqreturn_t mtk_outproc_irq_handler(int irq, void *dev_id)
+{
+	struct mtk_disp_outproc *priv = dev_id;
+	u32 val;
+
+	val = readl(priv->regs + DISP_REG_OVL_OUTPROC_INTSTA);
+	if (val == 0)
+		return IRQ_NONE;
+
+	writel(0, priv->regs + DISP_REG_OVL_OUTPROC_INTSTA);
+
+	if (priv->vblank_cb)
+		priv->vblank_cb(priv->vblank_cb_data);
+
+	return IRQ_HANDLED;
+}
+
+void mtk_outproc_config(struct mtk_ddp_comp *comp, unsigned int w,
+			unsigned int h, unsigned int vrefresh,
+			unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
+{
+	struct mtk_disp_outproc *priv = dev_get_drvdata(comp->dev);
+
+	writel(((h & GENMASK(15, 0)) << 16) | (w & GENMASK(15, 0)),
+	       priv->regs + DISP_REG_OVL_OUTPROC_ROI_SIZE);
+
+	writel(OVL_OUTPROC_DATAPATH_CON_OUTPUT_CLAMP,
+	       priv->regs + DISP_REG_OVL_OUTPROC_DATAPATH_CON);
+}
+
+void mtk_outproc_start(struct device *dev)
+{
+	struct mtk_disp_outproc *priv = dev_get_drvdata(dev);
+	u32 val;
+
+	writel(OVL_OUTPROC_RST, priv->regs + DISP_REG_OVL_OUTPROC_RST);
+	writel(0, priv->regs + DISP_REG_OVL_OUTPROC_RST);
+
+	val = readl(priv->regs + DISP_REG_OVL_OUTPROC_SHADOW_CTRL);
+	val |= OVL_OUTPROC_BYPASS_SHADOW;
+	writel(val, priv->regs + DISP_REG_OVL_OUTPROC_SHADOW_CTRL);
+
+	writel(OVL_OUTPROC_OVL_EN, priv->regs + DISP_REG_OVL_OUTPROC_EN);
+}
+
+void mtk_outproc_stop(struct device *dev)
+{
+	struct mtk_disp_outproc *priv = dev_get_drvdata(dev);
+
+	/* Don't reset at stop time to avoid vblank timeouts */
+	writel(0, priv->regs + DISP_REG_OVL_OUTPROC_EN);
+}
+
+int mtk_outproc_clk_enable(struct mtk_ddp_comp *comp)
+{
+	struct mtk_disp_outproc *priv = dev_get_drvdata(comp->dev);
+
+	return clk_prepare_enable(priv->clk);
+}
+
+void mtk_outproc_clk_disable(struct mtk_ddp_comp *comp)
+{
+	struct mtk_disp_outproc *priv = dev_get_drvdata(comp->dev);
+
+	clk_disable_unprepare(priv->clk);
+}
+
+static int mtk_outproc_bind(struct device *dev, struct device *master,
+				 void *data)
+{
+	struct mtk_disp_outproc *priv = dev_get_drvdata(dev);
+
+	if (priv->irq)
+		enable_irq(priv->irq);
+
+	return 0;
+}
+
+static void mtk_outproc_unbind(struct device *dev, struct device *master, void *data)
+{
+	struct mtk_disp_outproc *priv = dev_get_drvdata(dev);
+
+	if (priv->irq)
+		disable_irq(priv->irq);
+}
+
+static const struct component_ops mtk_disp_outproc_component_ops = {
+	.bind	= mtk_outproc_bind,
+	.unbind = mtk_outproc_unbind,
+};
+
+static int mtk_disp_outproc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_disp_outproc *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->regs))
+		return dev_err_probe(dev, PTR_ERR(priv->regs), "Cannot get reg resource\n");
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
+
+	priv->irq = platform_get_irq_optional(pdev, 0);
+	if (priv->irq > 0) {
+		ret = devm_request_irq(dev, priv->irq, mtk_outproc_irq_handler,
+				       IRQF_NO_AUTOEN, dev_name(dev), priv);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to request irq\n");
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = component_add(dev, &mtk_disp_outproc_component_ops);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add component\n");
+
+	return ret;
+}
+
+static void mtk_disp_outproc_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &mtk_disp_outproc_component_ops);
+}
+
+static const struct of_device_id mtk_disp_outproc_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt8196-disp-outproc" },
+	{ /* sentinel */},
+};
+
+MODULE_DEVICE_TABLE(of, mtk_disp_outproc_driver_dt_match);
+
+struct platform_driver mtk_disp_outproc_driver = {
+	.probe		= mtk_disp_outproc_probe,
+	.remove		= mtk_disp_outproc_remove,
+	.driver		= {
+		.name	= "mediatek-disp-outproc",
+		.owner	= THIS_MODULE,
+		.of_match_table = mtk_disp_outproc_driver_dt_match,
+	},
+};
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_AUTHOR("Nancy Lin <nancy.lin@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek Display Controller Output Processing Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 9f1264bb1d5e..3ed0e3f45fe2 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -557,6 +557,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8173-disp-od",
 	  .data = (void *)MTK_DISP_OD },
+	{ .compatible = "mediatek,mt8196-disp-outproc",
+	  .data = (void *)MTK_DISP_OUTPROC },
 	{ .compatible = "mediatek,mt2701-disp-ovl",
 	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8167-disp-ovl",
@@ -1070,6 +1072,7 @@ static struct platform_driver * const mtk_drm_drivers[] = {
 	&mtk_disp_exdma_driver,
 	&mtk_disp_gamma_driver,
 	&mtk_disp_merge_driver,
+	&mtk_disp_outproc_driver,
 	&mtk_disp_ovl_adaptor_driver,
 	&mtk_disp_ovl_driver,
 	&mtk_disp_rdma_driver,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index 4ef61c1e33e3..3f84384f8569 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -80,6 +80,7 @@ extern struct platform_driver mtk_disp_dsc_driver;
 extern struct platform_driver mtk_disp_exdma_driver;
 extern struct platform_driver mtk_disp_gamma_driver;
 extern struct platform_driver mtk_disp_merge_driver;
+extern struct platform_driver mtk_disp_outproc_driver;
 extern struct platform_driver mtk_disp_ovl_adaptor_driver;
 extern struct platform_driver mtk_disp_ovl_driver;
 extern struct platform_driver mtk_disp_rdma_driver;
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index d5c082d920c4..a1c8a436b3dc 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -99,6 +99,7 @@ enum mtk_ddp_comp_type {
 	MTK_DISP_MERGE,
 	MTK_DISP_MUTEX,
 	MTK_DISP_OD,
+	MTK_DISP_OUTPROC,
 	MTK_DISP_OVL,
 	MTK_DISP_OVL_2L,
 	MTK_DISP_OVL_ADAPTOR,
-- 
2.54.0

