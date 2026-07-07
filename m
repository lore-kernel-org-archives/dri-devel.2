Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A4BC44506
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 14:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 561A710ED97;
	Tue,  7 Jul 2026 14:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="P3rCZigG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFF0210ED82
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 14:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783433983;
 bh=WveJIKcSDFtln6moBUm4mMfeMv6Y8I/JiesYCykNM8g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=P3rCZigGNePOeVqgXIfA27gU7VeZpSthMnDYkEbWFAuhC7/2UvIWyq0dXHDtST9qv
 DtDeWyQlcUD7f4CB6f81QCUbzrzfrsWnL9mUaPZlRzSr82Te9B+5PApGOza9A9CR7o
 1kOqZ3+difP6MCv+Lkx+/GKjnrpqcJBadMxTJkHLPaCoZCbJrCzM3TRxAOmsdIj9rO
 IvFuEhKiTML0w/SAqYDXTAk3ga0uw88gNXdeMuGpTtyuwsFDLbHu8rNJMFdnNPkRqc
 3jmA8YYVogqR8zBXyM46p1Moy3GAjGOxmrBTDTD5F+xhTABTaPnkMYzpPp78bHq7hd
 irAHCGLAfAWrA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C4FB417E018C;
 Tue, 07 Jul 2026 16:19:42 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, justin.yeh@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: [PATCH v2 02/12] phy: phy-mtk-dp: Rename regs to regmap in struct
 mtk_dp_phy
Date: Tue,  7 Jul 2026 16:19:21 +0200
Message-ID: <20260707141931.191172-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707141931.191172-1-angelogioacchino.delregno@collabora.com>
References: <20260707141931.191172-1-angelogioacchino.delregno@collabora.com>
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

In preparation to perform further cleanups and to extend the
driver to support more SoCs, rename the `regs` member to `regmap`
to improve readability, as this is a common name across many
kernel drivers for a struct regmap.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-dp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index d7024a144335..bf7b3a95e72d 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -79,7 +79,7 @@
 				 XTP_LN_TX_LCTXCP1_SW3_PRE0_DEFAULT)
 
 struct mtk_dp_phy {
-	struct regmap *regs;
+	struct regmap *regmap;
 };
 
 static int mtk_dp_phy_init(struct phy *phy)
@@ -94,13 +94,13 @@ static int mtk_dp_phy_init(struct phy *phy)
 		DRIVING_PARAM_8_DEFAULT
 	};
 
-	regmap_bulk_write(dp_phy->regs, MTK_DP_LANE0_DRIVING_PARAM_3,
+	regmap_bulk_write(dp_phy->regmap, MTK_DP_LANE0_DRIVING_PARAM_3,
 			  driving_params, ARRAY_SIZE(driving_params));
-	regmap_bulk_write(dp_phy->regs, MTK_DP_LANE1_DRIVING_PARAM_3,
+	regmap_bulk_write(dp_phy->regmap, MTK_DP_LANE1_DRIVING_PARAM_3,
 			  driving_params, ARRAY_SIZE(driving_params));
-	regmap_bulk_write(dp_phy->regs, MTK_DP_LANE2_DRIVING_PARAM_3,
+	regmap_bulk_write(dp_phy->regmap, MTK_DP_LANE2_DRIVING_PARAM_3,
 			  driving_params, ARRAY_SIZE(driving_params));
-	regmap_bulk_write(dp_phy->regs, MTK_DP_LANE3_DRIVING_PARAM_3,
+	regmap_bulk_write(dp_phy->regmap, MTK_DP_LANE3_DRIVING_PARAM_3,
 			  driving_params, ARRAY_SIZE(driving_params));
 
 	return 0;
@@ -131,10 +131,10 @@ static int mtk_dp_phy_configure(struct phy *phy, union phy_configure_opts *opts)
 			val = BIT_RATE_HBR3;
 			break;
 		}
-		regmap_write(dp_phy->regs, MTK_DP_PHY_DIG_BIT_RATE, val);
+		regmap_write(dp_phy->regmap, MTK_DP_PHY_DIG_BIT_RATE, val);
 	}
 
-	regmap_update_bits(dp_phy->regs, MTK_DP_PHY_DIG_PLL_CTL_1,
+	regmap_update_bits(dp_phy->regmap, MTK_DP_PHY_DIG_PLL_CTL_1,
 			   TPLL_SSC_EN, opts->dp.ssc ? TPLL_SSC_EN : 0);
 
 	return 0;
@@ -144,10 +144,10 @@ static int mtk_dp_phy_reset(struct phy *phy)
 {
 	struct mtk_dp_phy *dp_phy = phy_get_drvdata(phy);
 
-	regmap_update_bits(dp_phy->regs, MTK_DP_PHY_DIG_SW_RST,
+	regmap_update_bits(dp_phy->regmap, MTK_DP_PHY_DIG_SW_RST,
 			   DP_GLB_SW_RST_PHYD, 0);
 	usleep_range(50, 200);
-	regmap_update_bits(dp_phy->regs, MTK_DP_PHY_DIG_SW_RST,
+	regmap_update_bits(dp_phy->regmap, MTK_DP_PHY_DIG_SW_RST,
 			   DP_GLB_SW_RST_PHYD, 1);
 
 	return 0;
@@ -176,7 +176,7 @@ static int mtk_dp_phy_probe(struct platform_device *pdev)
 	if (!dp_phy)
 		return -ENOMEM;
 
-	dp_phy->regs = regs;
+	dp_phy->regmap = regs;
 	phy = devm_phy_create(dev, NULL, &mtk_dp_phy_dev_ops);
 	if (IS_ERR(phy))
 		return dev_err_probe(dev, PTR_ERR(phy),
-- 
2.54.0

