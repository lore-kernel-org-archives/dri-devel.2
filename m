Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF80C44507
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8050410EF7D;
	Wed,  1 Jul 2026 12:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="IrjuEJRv";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4000210EF7D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908515;
 bh=e3Z9m+QO6oALXjCTZ9btiFkkCilthehE/G8hd2YzjvU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IrjuEJRvALH32UfKmOETlaj/x4sCm+OyoVfp+AFvbhog5ITsuW6EpRivkrEKIUeMf
 SZXTJ79S/P+5ATnx13UqwAAxwrBkv3uIihloaLiSiaAA5KhM+MCOMTnuqpL/bOEuhT
 6NAQDrbI0ca6bE/X1+J1u+cFWs9M9BwwyhZyNgKj7vbKQc+NB2fPvnDk0kzV61Pgd4
 JH8f+o6L7YjZpcixAK+oSuxOvOPSzjaN702/UINN3Dp3gtgMnFDa3z+L/VMUfnnasZ
 XGFPVtYF994q8x7nICUxLlS2ZOo2iaq7YQB74LtoeaHQUsciYDN4qAhwoEywN2HBPH
 aYxAXm9HFTBJg==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id F2E4817E35E4;
 Wed,  1 Jul 2026 14:21:53 +0200 (CEST)
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
Subject: [PATCH 39/42] drm/mediatek: Add Two-Dimension Sharpness Processor
 (TDSHP) driver
Date: Wed,  1 Jul 2026 14:20:54 +0200
Message-ID: <20260701122057.19648-40-angelogioacchino.delregno@collabora.com>
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

The MediaTek 2D Sharpness Processor (TDSHP) is responsible for
performing image sharpness adjustments/enhancements in a display
pipeline.

Even though this hardware block supports adjusting the luma and
contour 2D histograms, frequency weighting, luma-chroma gain and
others, this only introduces a basic configuration which allows
to bypass TDSHP processing in an effort to forward the data from
this block to others.

That is necessary because some components cannot be connected
directly in specific pipelines; for example, in MT8196/MT6991
pipelines, when Display Resizer (RSZ) and Color Correction (CCORR)
components are required, it is necessary to pass through TDSHP as
direct connection between RSZ and CCORR is not possible due to HW
limitations.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/Makefile         |   1 +
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c   |  10 ++
 drivers/gpu/drm/mediatek/mtk_disp_drv.h   |   8 ++
 drivers/gpu/drm/mediatek/mtk_disp_tdshp.c | 167 ++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c    |   3 +
 drivers/gpu/drm/mediatek/mtk_drm_drv.h    |   1 +
 include/linux/soc/mediatek/mtk-mmsys.h    |   2 +
 7 files changed, 192 insertions(+)
 create mode 100644 drivers/gpu/drm/mediatek/mtk_disp_tdshp.c

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index e9478fa1a2ba..47ba6bc17d9e 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -15,6 +15,7 @@ mediatek-drm-y := mtk_crtc.o \
 		  mtk_disp_ovl.o \
 		  mtk_disp_ovl_adaptor.o \
 		  mtk_disp_rdma.o \
+		  mtk_disp_tdshp.o \
 		  mtk_disp_wdma.o \
 		  mtk_drm_drv.o \
 		  mtk_drm_legacy.o \
diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index 7e12ddffbe77..ea09af8d4705 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -414,6 +414,14 @@ static const struct mtk_ddp_comp_funcs ddp_rdma = {
 	.get_num_formats = mtk_rdma_get_num_formats,
 };
 
+static const struct mtk_ddp_comp_funcs ddp_tdshp = {
+	.clk_enable = mtk_tdshp_clk_enable,
+	.clk_disable = mtk_tdshp_clk_disable,
+	.config = mtk_tdshp_config,
+	.start = mtk_tdshp_start,
+	.stop = mtk_tdshp_stop,
+};
+
 static const struct mtk_ddp_comp_funcs ddp_wdma = {
 	.clk_enable = mtk_wdma_clk_enable,
 	.clk_disable = mtk_wdma_clk_disable,
@@ -481,6 +489,7 @@ static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_POSTMASK] = "postmask",
 	[MTK_DISP_PWM] = "pwm",
 	[MTK_DISP_RDMA] = "rdma",
+	[MTK_DISP_TDSHP] = "tdshp",
 	[MTK_DISP_UFOE] = "ufoe",
 	[MTK_DISP_WDMA] = "wdma",
 	[MTK_DISP_DP_INTF] = "dp-intf",
@@ -508,6 +517,7 @@ static const struct mtk_ddp_comp_funcs *mtk_ddp_funcs[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_POSTMASK]		= &ddp_postmask,
 	[MTK_DISP_PWM]			= NULL,
 	[MTK_DISP_RDMA]			= &ddp_rdma,
+	[MTK_DISP_TDSHP]		= &ddp_tdshp,
 	[MTK_DISP_UFOE]			= &ddp_ufoe,
 	[MTK_DISP_WDMA]			= &ddp_wdma,
 	[MTK_DISP_DPI]			= &ddp_dpi,
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
index f78f12da08a8..0308094b29cd 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
@@ -243,6 +243,14 @@ void mtk_mdp_rdma_config(struct device *dev, struct mtk_mdp_rdma_cfg *cfg,
 const u32 *mtk_mdp_rdma_get_formats(struct device *dev);
 size_t mtk_mdp_rdma_get_num_formats(struct device *dev);
 
+int mtk_tdshp_clk_enable(struct mtk_ddp_comp *comp);
+void mtk_tdshp_clk_disable(struct mtk_ddp_comp *comp);
+void mtk_tdshp_config(struct mtk_ddp_comp *comp, unsigned int w,
+			   unsigned int h, unsigned int vrefresh,
+			   unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
+void mtk_tdshp_start(struct device *dev);
+void mtk_tdshp_stop(struct device *dev);
+
 int mtk_wdma_clk_enable(struct mtk_ddp_comp *comp);
 void mtk_wdma_clk_disable(struct mtk_ddp_comp *comp);
 void mtk_wdma_config(struct mtk_ddp_comp *comp, unsigned int width,
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_tdshp.c b/drivers/gpu/drm/mediatek/mtk_disp_tdshp.c
new file mode 100644
index 000000000000..31f57c567137
--- /dev/null
+++ b/drivers/gpu/drm/mediatek/mtk_disp_tdshp.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * MediaTek Two-Dimension Sharpness Processor (TDSHP)
+ *
+ * Copyright (c) 2025 MediaTek Inc.
+ * Copyright (c) 2026 Collabora Ltd.
+ *                    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/component.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
+
+#include "mtk_disp_drv.h"
+#include "mtk_disp_ovl.h"
+#include "mtk_drm_drv.h"
+
+#define DISP_REG_TDSHP_EN			0x0000
+#  define DISP_TDSHP_TDS_EN			BIT(31)
+#define DISP_REG_TDSHP_CTRL			0x0100
+#  define DISP_TDSHP_CTRL_EN			BIT(0)
+#  define DISP_TDSHP_PWR_SCL_EN			BIT(2)
+#define DISP_REG_TDSHP_CFG			0x0110
+#  define DISP_TDSHP_RELAY_MODE			BIT(0)
+#define DISP_REG_TDSHP_INPUT_SIZE		0x0120
+#define DISP_REG_TDSHP_OUTPUT_OFFSET		0x0124
+#define DISP_REG_TDSHP_OUTPUT_SIZE		0x0128
+
+struct mtk_disp_tdshp {
+	void __iomem *regs;
+	struct clk *clk;
+	struct cmdq_client_reg cmdq_reg;
+};
+
+void mtk_tdshp_config(struct mtk_ddp_comp *comp, unsigned int w,
+		      unsigned int h, unsigned int vrefresh,
+		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
+{
+	struct mtk_disp_tdshp *tdshp = dev_get_drvdata(comp->dev);
+	u32 val = bpc == 8 ? DISP_TDSHP_PWR_SCL_EN : 0;
+
+	/* Set basic parameters to at least pass the data on */
+	mtk_ddp_write(cmdq_pkt, val | DISP_TDSHP_CTRL_EN, &tdshp->cmdq_reg,
+		      tdshp->regs, DISP_REG_TDSHP_CTRL);
+
+	mtk_ddp_write(cmdq_pkt, w << 16 | h, &tdshp->cmdq_reg,
+		      tdshp->regs, DISP_REG_TDSHP_INPUT_SIZE);
+	mtk_ddp_write(cmdq_pkt, w << 16 | h, &tdshp->cmdq_reg,
+		      tdshp->regs, DISP_REG_TDSHP_OUTPUT_SIZE);
+	mtk_ddp_write(cmdq_pkt, 0x0, &tdshp->cmdq_reg,
+		      tdshp->regs, DISP_REG_TDSHP_OUTPUT_OFFSET);
+
+	/* Set RELAY mode to bypass 2D Sharpness processing */
+	mtk_ddp_write(cmdq_pkt, DISP_TDSHP_RELAY_MODE, &tdshp->cmdq_reg,
+		      tdshp->regs, DISP_REG_TDSHP_CFG);
+
+	mtk_ddp_write_mask(cmdq_pkt, DISP_TDSHP_TDS_EN, &tdshp->cmdq_reg,
+			   tdshp->regs, DISP_REG_TDSHP_EN, DISP_TDSHP_TDS_EN);
+}
+
+void mtk_tdshp_start(struct device *dev)
+{
+	struct mtk_disp_tdshp *tdshp = dev_get_drvdata(dev);
+
+	writel(DISP_TDSHP_CTRL_EN, tdshp->regs + DISP_REG_TDSHP_CTRL);
+}
+
+void mtk_tdshp_stop(struct device *dev)
+{
+	struct mtk_disp_tdshp *tdshp = dev_get_drvdata(dev);
+
+	writel(0, tdshp->regs + DISP_REG_TDSHP_CTRL);
+}
+
+int mtk_tdshp_clk_enable(struct mtk_ddp_comp *comp)
+{
+	struct mtk_disp_tdshp *tdshp = dev_get_drvdata(comp->dev);
+
+	return clk_prepare_enable(tdshp->clk);
+}
+
+void mtk_tdshp_clk_disable(struct mtk_ddp_comp *comp)
+{
+	struct mtk_disp_tdshp *tdshp = dev_get_drvdata(comp->dev);
+
+	clk_disable_unprepare(tdshp->clk);
+}
+
+static int mtk_tdshp_bind(struct device *dev, struct device *master, void *data)
+{
+	return 0;
+}
+
+static void mtk_tdshp_unbind(struct device *dev, struct device *master, void *data)
+{
+}
+
+static const struct component_ops mtk_disp_tdshp_component_ops = {
+	.bind	= mtk_tdshp_bind,
+	.unbind = mtk_tdshp_unbind,
+};
+
+static int mtk_disp_tdshp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mtk_disp_tdshp *tdshp;
+	int ret = 0;
+
+	tdshp = devm_kzalloc(dev, sizeof(*tdshp), GFP_KERNEL);
+	if (!tdshp)
+		return -ENOMEM;
+
+	tdshp->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tdshp->regs))
+		return dev_err_probe(dev, PTR_ERR(tdshp->regs), "Cannot get reg resource\n");
+
+	tdshp->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(tdshp->clk))
+		return dev_err_probe(dev, PTR_ERR(tdshp->clk), "Cannot get clocks\n");
+
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	ret = cmdq_dev_get_client_reg(dev, &tdshp->cmdq_reg, 0);
+	if (ret)
+		dev_dbg(dev, "No mediatek,gce-client-reg\n");
+#endif
+	platform_set_drvdata(pdev, tdshp);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	ret = component_add(dev, &mtk_disp_tdshp_component_ops);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add component\n");
+
+	return 0;
+}
+
+static void mtk_disp_tdshp_remove(struct platform_device *pdev)
+{
+	component_del(&pdev->dev, &mtk_disp_tdshp_component_ops);
+}
+
+static const struct of_device_id mtk_disp_tdshp_driver_dt_match[] = {
+	{ .compatible = "mediatek,mt8196-disp-tdshp", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mtk_disp_tdshp_driver_dt_match);
+
+struct platform_driver mtk_disp_tdshp_driver = {
+	.probe = mtk_disp_tdshp_probe,
+	.remove = mtk_disp_tdshp_remove,
+	.driver = {
+		.name = "mediatek-disp-tdshp",
+		.owner = THIS_MODULE,
+		.of_match_table = mtk_disp_tdshp_driver_dt_match,
+	},
+};
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_DESCRIPTION("MediaTek Display Controller 2D Sharpness Processor Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 50b4f79295b3..b96cf2f435e5 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -699,6 +699,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8195-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
+	{ .compatible = "mediatek,mt8196-disp-tdshp",
+	  .data = (void *)MTK_DISP_TDSHP },
 	{ .compatible = "mediatek,mt8173-disp-ufoe",
 	  .data = (void *)MTK_DISP_UFOE },
 	{ .compatible = "mediatek,mt6893-disp-wdma",
@@ -1521,6 +1523,7 @@ static struct platform_driver * const mtk_drm_drivers[] = {
 	&mtk_disp_ovl_adaptor_driver,
 	&mtk_disp_ovl_driver,
 	&mtk_disp_rdma_driver,
+	&mtk_disp_tdshp_driver,
 	&mtk_disp_wdma_driver,
 	&mtk_dpi_driver,
 	&mtk_dvo_driver,
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
index 76325d1be5f4..8bdd7f1017b9 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
@@ -87,6 +87,7 @@ extern struct platform_driver mtk_disp_outproc_driver;
 extern struct platform_driver mtk_disp_ovl_adaptor_driver;
 extern struct platform_driver mtk_disp_ovl_driver;
 extern struct platform_driver mtk_disp_rdma_driver;
+extern struct platform_driver mtk_disp_tdshp_driver;
 extern struct platform_driver mtk_disp_wdma_driver;
 extern struct platform_driver mtk_dpi_driver;
 extern struct platform_driver mtk_dsi_driver;
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index d6742ca39d86..e33cb5b2638c 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -109,6 +109,8 @@ enum mtk_ddp_comp_type {
 	MTK_DISP_POSTMASK,
 	MTK_DISP_PWM,
 	MTK_DISP_RDMA,
+	MTK_DISP_RSZ,
+	MTK_DISP_TDSHP,
 	MTK_DISP_UFOE,
 	MTK_DISP_WDMA,
 
-- 
2.54.0

