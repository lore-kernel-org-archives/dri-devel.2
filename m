Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 623ABC79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEF7B10F3BD;
	Thu, 10 Sep 2026 09:20:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EhwJKaD3";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EEB010F3BD
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789032045;
 bh=HAFCIlvbN2dc3YOTNS3f1xU94js5Nu7PxNVA7m6vO/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EhwJKaD3Rg79euKBLroowzkjFZJzVpn+qftHHTJX4VDRc87gY6vZnGmqLEO9LPkN6
 /NrEYTGL/9TI3YfrZCgJzPkWP1j8fpkuSej9QcmMUrRLurwlELYj2XobEa3YKTUTC2
 TvK+F0yanH2bcD6n56zfhjFFbtCT8u9DrReuWcMRpoUEm6gQdRbQQ/jpxDVMIXB/FQ
 wbrvcK4DKwXc7kIsH9IMiLFZ6fGzrOiZBuZwnzOfF07WJtdS09CYACsXuH0XOzpMgI
 7ak6EWpegTnxWscT9Dx38a7cmYe/UcqNiTfkPnt9NSqFY0bqK8lwKPmf/r9Erud/k0
 cqH2EiJpyCzdA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F6F817E0D7F;
 Thu, 10 Sep 2026 11:20:44 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: mani@kernel.org
Cc: chunfeng.yun@mediatek.com, vkoul@kernel.org, neil.armstrong@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chunkuang.hu@kernel.org, p.zabel@pengutronix.de, justin.yeh@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v4 03/12] phy: phy-mtk-dp: Allow probing with devicetree match
Date: Thu, 10 Sep 2026 11:20:29 +0200
Message-ID: <20260910092038.48291-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
References: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
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

Make it possible to decouple the registration of the DisplayPort
PHY driver from the DisplayPort IP driver by adding a devicetree
match to probe the PHY, registering an OF PHY provider and this
device's own MMIO regmap - if, and only if, this PHY driver was
registered with an OF match.

In order to retain compatibility with older devicetrees that are
not declaring the DisplayPort PHY as a separate node, the legacy
code was moved in a `mtk_dp_phy_legacy_probe()` function, which
gets called if the driver was registered by the DisplayPort one.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-dp.c | 88 +++++++++++++++++++++++++++----
 1 file changed, 78 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index bf7b3a95e72d..d241004e2828 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
 #define PHY_OFFSET			0x1000
@@ -79,6 +80,7 @@
 				 XTP_LN_TX_LCTXCP1_SW3_PRE0_DEFAULT)
 
 struct mtk_dp_phy {
+	struct device *dev;
 	struct regmap *regmap;
 };
 
@@ -160,43 +162,109 @@ static const struct phy_ops mtk_dp_phy_dev_ops = {
 	.owner = THIS_MODULE,
 };
 
+static void mtk_dp_phy_legacy_remove_lookup(void *data)
+{
+	struct phy *phy = data;
+	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
+
+	phy_remove_lookup(phy, "dp", dev_name(dp_phy->dev));
+}
+
+static int mtk_dp_phy_legacy_probe(struct platform_device *pdev, struct mtk_dp_phy *dp_phy)
+{
+	struct device *dev = &pdev->dev;
+	struct phy *phy;
+	int ret;
+
+	dp_phy->regmap = *(struct regmap **)dev->platform_data;
+	if (!dp_phy->regmap)
+		return dev_err_probe(dev, -EINVAL, "No platform data available\n");
+
+	phy = devm_phy_create(dev, NULL, &mtk_dp_phy_dev_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy),
+				     "Failed to create DP PHY\n");
+
+	phy_set_drvdata(phy, dp_phy);
+	ret = phy_create_lookup(phy, "dp", dev_name(dev));
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, mtk_dp_phy_legacy_remove_lookup, phy);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct regmap_config mtk_dp_phy_regmap_cfg = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.disable_locking = true,
+};
+
 static int mtk_dp_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct phy_provider *provider;
 	struct mtk_dp_phy *dp_phy;
+	void __iomem *base;
 	struct phy *phy;
-	struct regmap *regs;
-
-	regs = *(struct regmap **)dev->platform_data;
-	if (!regs)
-		return dev_err_probe(dev, -EINVAL,
-				     "No data passed, requires struct regmap**\n");
+	int ret;
 
 	dp_phy = devm_kzalloc(dev, sizeof(*dp_phy), GFP_KERNEL);
 	if (!dp_phy)
 		return -ENOMEM;
 
-	dp_phy->regmap = regs;
+	dp_phy->dev = dev;
+
+	/* If there's no devicetree, go for legacy pdev probe */
+	if (!dev->of_node)
+		return mtk_dp_phy_legacy_probe(pdev, dp_phy);
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	dp_phy->regmap = devm_regmap_init_mmio(dev, base, &mtk_dp_phy_regmap_cfg);
+	if (IS_ERR(dp_phy->regmap))
+		return PTR_ERR(dp_phy->regmap);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
 	phy = devm_phy_create(dev, NULL, &mtk_dp_phy_dev_ops);
 	if (IS_ERR(phy))
 		return dev_err_probe(dev, PTR_ERR(phy),
 				     "Failed to create DP PHY\n");
 
 	phy_set_drvdata(phy, dp_phy);
-	if (!dev->of_node)
-		phy_create_lookup(phy, "dp", dev_name(dev));
+
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(provider))
+		return PTR_ERR(provider);
 
 	return 0;
 }
 
+static const struct of_device_id mtk_dp_phy_of_match[] = {
+	{ .compatible = "mediatek,mt8195-dp-phy" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mtk_dp_phy_of_match);
+
 static struct platform_driver mtk_dp_phy_driver = {
 	.probe = mtk_dp_phy_probe,
 	.driver = {
 		.name = "mediatek-dp-phy",
+		.of_match_table = mtk_dp_phy_of_match,
 	},
 };
 module_platform_driver(mtk_dp_phy_driver);
 
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
 MODULE_AUTHOR("Markus Schneider-Pargmann <msp@baylibre.com>");
-MODULE_DESCRIPTION("MediaTek DP PHY Driver");
+MODULE_DESCRIPTION("MediaTek DisplayPort PHY Driver");
 MODULE_LICENSE("GPL");
-- 
2.55.0

