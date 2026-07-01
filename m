Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F5CC44500
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3647410EF44;
	Wed,  1 Jul 2026 12:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="e2kPL7Mn";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C25210EF40
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908436;
 bh=5qrR17bDP11PF0Y+AWGupsl3Ns6N2I8PqUxjSFIFbA0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=e2kPL7MnT2+MWveBSV0kY0rYIVauYSqzQ6zmGgJAnbd76UlhZ2PxS2PvZBSa4rkHg
 xHy5g6sN41ZRPZBWxQbKqSXoZxkB6Wassddep/2xT/ZGUxsDS+OX/JcZyE9tLRvzOq
 sVe+HrxgXEyN2M4FT43cFh8e5oJsVb5q+eYDVGaa35ELmScxxscZmB9Z0+WqRXjOoH
 Ph/Ffs2zieRN1L7knpO03t/GxLuHQlIaTVhara3PXQhNc9tLMDpT8//J6wnrxX7WiN
 /c85/rKFf09TXBpv+OLh4XZTdSoOYT5FkmhP1mVCRcao3eG64xPU9edt0esiBXrsJ/
 OTVW0FESC9YTQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0671B17E0857;
 Wed,  1 Jul 2026 14:20:34 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 jitao.shi@mediatek.com, granquet@baylibre.com, rex-bc.chen@mediatek.com,
 dmitry.osipenko@collabora.com, ck.hu@mediatek.com, amergnat@baylibre.com,
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 07/11] drm/mediatek: mtk_dp: Add support for PHY from
 devicetree
Date: Wed,  1 Jul 2026 14:20:20 +0200
Message-ID: <20260701122024.19557-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701122024.19557-1-angelogioacchino.delregno@collabora.com>
References: <20260701122024.19557-1-angelogioacchino.delregno@collabora.com>
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

Add support for specifying `phys` in devicetree to pass handle
to the DisplayPort PHY.

In order to retain compatibility with older devicetrees, check if
`phys` was specified: if not, initialize the regmap_mmio with the
legacy configuration and register the mediatek-dp-phy platform
device from this driver, and get the PHY calibration data.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 50 ++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 3b5348ab487d..bf3a4b15f3ec 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -426,6 +426,15 @@ static const struct regmap_config mtk_dp_regmap_legacy_config = {
 	.name = "mtk-dp-registers",
 };
 
+static const struct regmap_config mtk_dp_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = SEC_OFFSET + 0x90,
+	.name = "mtk-dp-registers",
+};
+
+
 static struct mtk_dp *mtk_dp_from_bridge(struct drm_bridge *b)
 {
 	return container_of(b, struct mtk_dp, bridge);
@@ -1298,7 +1307,13 @@ static int mtk_dp_phy_configure(struct mtk_dp *mtk_dp,
 	if (ret)
 		return ret;
 
-	mtk_dp_set_calibration_data(mtk_dp);
+	/*
+	 * For legacy, deprecated strategy, set partial PHY calibration here.
+	 * New-style will set all PHY calibrations with phy ops instead.
+	 */
+	if (mtk_dp->phy_dev)
+		mtk_dp_set_calibration_data(mtk_dp);
+
 	mtk_dp_update_bits(mtk_dp, MTK_DP_TOP_PWR_STATE,
 			   DP_PWR_STATE_BANDGAP_TPLL_LANE, DP_PWR_STATE_MASK);
 
@@ -2132,8 +2147,9 @@ static int mtk_dp_wait_hpd_asserted(struct drm_dp_aux *mtk_aux, unsigned long wa
 static int mtk_dp_dt_parse(struct mtk_dp *mtk_dp,
 			   struct platform_device *pdev)
 {
-	struct device_node *endpoint;
+	const struct regmap_config *regmap_cfg;
 	struct device *dev = &pdev->dev;
+	struct device_node *endpoint;
 	int ret;
 	void __iomem *base;
 	u32 linkrate;
@@ -2143,7 +2159,12 @@ static int mtk_dp_dt_parse(struct mtk_dp *mtk_dp,
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	mtk_dp->regs = devm_regmap_init_mmio(dev, base, &mtk_dp_regmap_legacy_config);
+	if (!mtk_dp->legacy_regoff)
+		regmap_cfg = &mtk_dp_regmap_config;
+	else
+		regmap_cfg = &mtk_dp_regmap_legacy_config;
+
+	mtk_dp->regs = devm_regmap_init_mmio(dev, base, regmap_cfg);
 	if (IS_ERR(mtk_dp->regs))
 		return PTR_ERR(mtk_dp->regs);
 
@@ -2769,6 +2790,7 @@ static int mtk_dp_register_phy(struct mtk_dp *mtk_dp)
 				     "Failed to add phy unregister devm action");
 	}
 
+	/* PHY calibration data is in mtk_dp only for legacy devicetree */
 	mtk_dp_get_calibration_data(mtk_dp);
 
 	mtk_dp->phy = devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
@@ -2821,7 +2843,12 @@ static int mtk_dp_probe(struct platform_device *pdev)
 
 	mtk_dp->dev = dev;
 	mtk_dp->data = (struct mtk_dp_data *)of_device_get_match_data(dev);
-	mtk_dp->legacy_regoff = MTK_DP_TOP_OFFSET_LEGACY;
+
+	/* Prefer PHY from devicetree - if not found, this is legacy */
+	if (of_property_present(dev->of_node, "phys"))
+		mtk_dp->legacy_regoff = 0;
+	else
+		mtk_dp->legacy_regoff = MTK_DP_TOP_OFFSET_LEGACY;
 
 	ret = mtk_dp_dt_parse(mtk_dp, pdev);
 	if (ret)
@@ -2872,9 +2899,18 @@ static int mtk_dp_probe(struct platform_device *pdev)
 					     "Failed to register audio driver\n");
 	}
 
-	ret = mtk_dp_register_phy(mtk_dp);
-	if (ret)
-		return ret;
+	if (!mtk_dp->legacy_regoff) {
+		mtk_dp->phy = devm_phy_get(dev, NULL);
+		if (IS_ERR(mtk_dp->phy))
+			return dev_err_probe(dev, PTR_ERR(mtk_dp->phy),
+					     "Failed to get phy\n");
+
+		mtk_dp->phy_dev = NULL;
+	} else {
+		ret = mtk_dp_register_phy(mtk_dp);
+		if (ret)
+			return ret;
+	}
 
 	mtk_dp->bridge.of_node = dev->of_node;
 	mtk_dp->bridge.type = mtk_dp->data->bridge_type;
-- 
2.54.0

