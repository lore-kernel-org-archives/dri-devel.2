Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFFAC4450E
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7284C10ED0E;
	Tue, 14 Jul 2026 11:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="QMCkAMUm";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1D710ED03
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 11:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784029529;
 bh=+RNvN8o+DorYUwnGLpKjtWAbtLk/FnYny1vFGbiWUe8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QMCkAMUmX6K4VU+LyCRTBlCh2EQQjTWvIf+IprGu27OgAuMTVaFzIvw1TZdGawaCt
 7nc24zK83WQccFmBlHNCGaqpcn8J3jwbou0R5KnBjucEzam7x6e4hKdObdbHlo+OYK
 QW9FTryoQEIfkWortzudSfm+U6SGJPwieZilETquv1EFOAijHn0ZtWXHf993KiPR5W
 dzlVk2QhcVJqOUohKlOnRJXXRIskIj+9Ei1XLrG3kVjlqDzLacizCWVJUY1ISCqNVv
 4zXkq9Wft1NrXVrlvJWVhWUdrTHYEi56xRVZQLFdVIwy4Cq53GpR4YCSVFtGxV3MpZ
 GLJl9Xj5Iva2Q==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9D33617E0FD2;
 Tue, 14 Jul 2026 13:45:28 +0200 (CEST)
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
Subject: [PATCH v2 45/46] drm/mediatek: Add support for Display Image Resizer
 (Scaler)
Date: Tue, 14 Jul 2026 13:44:13 +0200
Message-ID: <20260714114414.184512-46-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
References: <20260714114414.184512-1-angelogioacchino.delregno@collabora.com>
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

Add basic support for the Image Resizer hardware found in some
MediaTek Display Controller IPs, like the one found in MT8196.

This is currently set in bypass mode and used to pass the frame
buffer from a RSZ input component to supported RSZ outputs.
Full implementation of hardware-accelerated DRM scaling will be
done later.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index e1873a20e64b..453a4a9ad565 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -56,6 +56,10 @@
 #define POSTMASK_RELAY_MODE				BIT(0)
 #define DISP_REG_POSTMASK_SIZE			0x0030
 
+#define DISP_REG_RSZ_EN				0x0000
+#define DISP_REG_RSZ_INPUT_SIZE			0x0010
+#define DISP_REG_RSZ_OUTPUT_SIZE		0x0014
+
 #define DISP_REG_UFO_START			0x0000
 #define UFO_BYPASS				BIT(2)
 
@@ -230,6 +234,16 @@ static void mtk_postmask_stop(struct device *dev)
 	writel_relaxed(0x0, priv->regs + DISP_REG_POSTMASK_EN);
 }
 
+static void mtk_rsz_config(struct mtk_ddp_comp *comp, unsigned int w,
+			   unsigned int h, unsigned int vrefresh,
+			   unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
+{
+	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(comp->dev);
+
+	mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs, DISP_REG_RSZ_INPUT_SIZE);
+	mtk_ddp_write(cmdq_pkt, 0, &priv->cmdq_reg, priv->regs, DISP_REG_RSZ_OUTPUT_SIZE);
+}
+
 static void mtk_ufoe_start(struct device *dev)
 {
 	struct mtk_ddp_comp_dev *priv = dev_get_drvdata(dev);
@@ -414,6 +428,12 @@ static const struct mtk_ddp_comp_funcs ddp_rdma = {
 	.get_num_formats = mtk_rdma_get_num_formats,
 };
 
+static const struct mtk_ddp_comp_funcs ddp_rsz = {
+	.clk_enable = mtk_ddp_clk_enable,
+	.clk_disable = mtk_ddp_clk_disable,
+	.config = mtk_rsz_config,
+};
+
 static const struct mtk_ddp_comp_funcs ddp_tdshp = {
 	.clk_enable = mtk_tdshp_clk_enable,
 	.clk_disable = mtk_tdshp_clk_disable,
@@ -489,6 +509,7 @@ static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_POSTMASK] = "postmask",
 	[MTK_DISP_PWM] = "pwm",
 	[MTK_DISP_RDMA] = "rdma",
+	[MTK_DISP_RSZ] = "resizer",
 	[MTK_DISP_TDSHP] = "tdshp",
 	[MTK_DISP_UFOE] = "ufoe",
 	[MTK_DISP_WDMA] = "wdma",
@@ -517,6 +538,7 @@ static const struct mtk_ddp_comp_funcs *mtk_ddp_funcs[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_POSTMASK]		= &ddp_postmask,
 	[MTK_DISP_PWM]			= NULL,
 	[MTK_DISP_RDMA]			= &ddp_rdma,
+	[MTK_DISP_RSZ]			= &ddp_rsz,
 	[MTK_DISP_TDSHP]		= &ddp_tdshp,
 	[MTK_DISP_UFOE]			= &ddp_ufoe,
 	[MTK_DISP_WDMA]			= &ddp_wdma,
@@ -677,6 +699,7 @@ bool mtk_ddp_comp_is_internal_comp(enum mtk_ddp_comp_type type)
 	case MTK_DISP_DITHER:
 	case MTK_DISP_OD:
 	case MTK_DISP_POSTMASK:
+	case MTK_DISP_RSZ:
 	case MTK_DISP_UFOE:
 		return true;
 	default:
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 6cf285f1879d..82d844b6abf7 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -714,6 +714,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8195-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
+	{ .compatible = "mediatek,mt8196-disp-rsz",
+	  .data = (void *)MTK_DISP_RSZ },
 	{ .compatible = "mediatek,mt8196-disp-tdshp",
 	  .data = (void *)MTK_DISP_TDSHP },
 	{ .compatible = "mediatek,mt8173-disp-ufoe",
-- 
2.54.0

