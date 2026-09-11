Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26887C79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF8F10F504;
	Fri, 11 Sep 2026 07:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="po0tBroq";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9016810F504
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 07:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789112452;
 bh=0oqwV4n087TkcdE7smt77VXoCFhNFiNEr2EbMxZFD4Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=po0tBroqkvLelMZmwCQ9WY3xbdOJ3a40sY2PKdyRNnUl11BmACIbJfP+PbLHdMnS+
 ZFTMHhqawslg1E4RjkaQrOpTLVLjNRsD4Ey8HPiYJTc0uFPeS+k4RNM/oTIURRepZY
 O61bREKmshLrFzaMw8J7QPi8z00IX5sc4EPSbcQxjHPUuVlJHMYrRhjvHors3rvN+n
 acbB3f7u8pRVWgEJwJLU256wcO8EeS7+heaZKdCfDk/gOmCX1xR9k+kk842602Arxm
 GXKC7alwI8+SPk3LMmPNnT59vGaGuEWW/9H1XE4vgKb9twl6xP1OdFc3yNqJq+G2Gy
 pdvMnP/DiJcxw==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A7E9917E0CA6;
 Fri, 11 Sep 2026 09:40:51 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: vkoul@kernel.org
Cc: chunfeng.yun@mediatek.com, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
 neil.armstrong@linaro.org, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, granquet@baylibre.com,
 justin.yeh@mediatek.com, dri-devel@lists.freedesktop.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v2 2/2] phy: mediatek: phy-mtk-hdmi-mt8195: Fix TMDS clk bit
 ratio setting
Date: Fri, 11 Sep 2026 09:40:15 +0200
Message-ID: <20260911074015.9994-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911074015.9994-1-angelogioacchino.delregno@collabora.com>
References: <20260911074015.9994-1-angelogioacchino.delregno@collabora.com>
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

The comment in the mtk_phy_tmds_clk_ratio() function clearly and
correctly explains that the TMDS ratio has to be 1/10 for data
rates under 3.4Gbps, and 1/40 over that.

Unfortunately though, the TXC_DIV register setting was wrong, as
in value 3 means to divide by 8 and, in order to achieve the in
spec 1/40 (tmds) data rate, this has to divide by 4 instead!

Add definitions for the TXC_DIV register values clearly explaining
the meanings (DIV2, DIV4, DIV8), and program the correct, DIV 4,
value to the register in mtk_phy_tmds_clk_ratio().

This fixes out of spec clocking and, with this change, SoCs using
the MT8195 class HDMI PHYs can now successfully be configured to
output 3840x2160@60Hz over HDMI.

Fixes: 45810d486bb4 ("phy: mediatek: add support for phy-mtk-hdmi-mt8195")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 2 +-
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index e6ee8e080022..a4bc1268946d 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
@@ -36,7 +36,7 @@ mtk_phy_tmds_clk_ratio(struct mtk_hdmi_phy *hdmi_phy, bool enable)
 	 * clock bit ratio 1:40, under 3.4Gbps, clock bit ratio 1:10
 	 */
 	if (enable)
-		mtk_phy_update_field(regs + HDMI20_CLK_CFG, REG_TXC_DIV, 3);
+		mtk_phy_update_field(regs + HDMI20_CLK_CFG, REG_TXC_DIV, VAL_TXC_DIV4);
 	else
 		mtk_phy_clear_bits(regs + HDMI20_CLK_CFG, REG_TXC_DIV);
 }
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h
index e26caaf4d104..58800d7659ca 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.h
@@ -17,6 +17,9 @@
 
 #define HDMI20_CLK_CFG 0x70
 #define REG_TXC_DIV GENMASK(31, 30)
+#define VAL_TXC_DIV2 1
+#define VAL_TXC_DIV4 2
+#define VAL_TXC_DIV8 3
 
 #define HDMI_1_CFG_0 0x00
 #define RG_HDMITX21_DRV_IBIAS_CLK GENMASK(10, 5)
-- 
2.55.0

