Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A9A3C44501
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5F110EF5A;
	Wed,  1 Jul 2026 12:21:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="FuI23H95";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 522D710EF52
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908469;
 bh=qGaUZZGDMdPi15E0uv7JzAyEsx2eZTqS7P8cmGb9ccw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FuI23H95iqLw/2dnWfP/lE2fIJhvK0fh+crKKYR/vqvmjMImyjsPiowe/ifuuY5mV
 uMCMh/JXcZcCXrWwP9UlaZINhFkLpWDcYYEj8lMlP91cDlEf8KKlr+zM/gShxW0CEt
 wrFvJGxZaqgGI9h+eDPu5KMvAm25kcDBTsbF6TJcDgLHCrgc7RjZ1ZcRjweT+vcLi6
 adJKZniEmaE9atdrA6O5XeS1x1RtuJD/UYoVhjL6pz7Kv39M5W5nnHR/7BnKJf6YtX
 w18eNSCeY06ZuBZf2DWZj+W+k67oVJhSwRRshLrafduAMiy5Su+yF3ftE2weYr2xra
 Nx/z4j+nu25RQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 39F0A17E35C9;
 Wed,  1 Jul 2026 14:21:08 +0200 (CEST)
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
Subject: [PATCH 07/42] drm/mediatek: ddp_comp: Move internal component
 register in function
Date: Wed,  1 Jul 2026 14:20:22 +0200
Message-ID: <20260701122057.19648-8-angelogioacchino.delregno@collabora.com>
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

In preparation for adding an helper serving the purpose of finally
removing duplicated code to check for internal/simple components,
and for improving human readability in the up coming refactoring,
move the internal/simple component registration logic to its own
mtk_ddp_comp_init_internal_comp() function.

This brings no functional changes.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_ddp_comp.c | 55 +++++++++++++++----------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
index d716fd9f8a70..2ba2123238b3 100644
--- a/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_ddp_comp.c
@@ -629,6 +629,38 @@ static void mtk_ddp_comp_clk_put(void *_clk)
 	clk_put(clk);
 }
 
+static int mtk_ddp_comp_init_internal_comp(struct device *dev, struct device *comp_dev)
+{
+	struct device_node *comp_node = comp_dev->of_node;
+	struct mtk_ddp_comp_dev *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->regs = devm_of_iomap(dev, comp_node, 0, NULL);
+	if (IS_ERR(priv->regs))
+		return PTR_ERR(priv->regs);
+
+	priv->clk = of_clk_get(comp_node, 0);
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	ret = devm_add_action_or_reset(dev, mtk_ddp_comp_clk_put, priv->clk);
+	if (ret)
+		return ret;
+
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	ret = cmdq_dev_get_client_reg(comp_dev, &priv->cmdq_reg, 0);
+	if (ret)
+		dev_dbg(comp_dev, "get mediatek,gce-client-reg fail!\n");
+#endif
+	dev_set_drvdata(comp_dev, priv);
+
+	return 0;
+};
+
 int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 		      struct mtk_drm_comp_list *hlist,
 		      unsigned int comp_id)
@@ -636,7 +668,6 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	struct platform_device *comp_pdev;
 	struct mtk_ddp_comp *comp;
 	enum mtk_ddp_comp_type type;
-	struct mtk_ddp_comp_dev *priv;
 	int ret;
 
 	if (comp_id >= DDP_COMPONENT_DRM_ID_MAX)
@@ -686,29 +717,9 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
 	    type == MTK_DISP_DSI)
 		goto end;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->regs = devm_of_iomap(dev, node, 0, NULL);
-	if (IS_ERR(priv->regs))
-		return PTR_ERR(priv->regs);
-
-	priv->clk = of_clk_get(node, 0);
-	if (IS_ERR(priv->clk))
-		return PTR_ERR(priv->clk);
-
-	ret = devm_add_action_or_reset(dev, mtk_ddp_comp_clk_put, priv->clk);
+	ret = mtk_ddp_comp_init_internal_comp(dev, comp->dev);
 	if (ret)
 		return ret;
-
-#if IS_REACHABLE(CONFIG_MTK_CMDQ)
-	ret = cmdq_dev_get_client_reg(comp->dev, &priv->cmdq_reg, 0);
-	if (ret)
-		dev_dbg(comp->dev, "get mediatek,gce-client-reg fail!\n");
-#endif
-
-	platform_set_drvdata(comp_pdev, priv);
 end:
 	hash_add(hlist->ddp_list, &comp->lnode, comp->id);
 
-- 
2.54.0

