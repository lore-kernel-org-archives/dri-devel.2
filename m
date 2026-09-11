Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A8BC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 346CE10F509;
	Fri, 11 Sep 2026 07:40:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oCl1nCDh";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5EE310F502
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 07:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789112451;
 bh=RctPS754DU/t+qBmFIbvj4yy7arbALAwJti9yGAZYSM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oCl1nCDhRSX+SvulyjiOudPqry3mT5cNq311NaiAP80DEwhr/NWalUuNrBv7N7YQ4
 l5iGq6tCUtO9T+PeKZVBvENp1xuC6TAPz5rVUOYRHQUQbS5kcUUQE6o0KwLnV871t7
 yoBRn69cI/oN7xZ1ox0e93NfyNgH7KVKdiKPBIGbqcU0nBl1Yrntug86fmtv8upbxL
 3ekLpbZOpSFHVviVGRGN/4F0tUL+8jNozGdA5nzECZtyTiTHNFkR4DQ+6OWdA+Z1ZP
 UiBMqxEP4v/trHTGLwF5tdD3UFHMCku1NnU0w12tEdOm7LdlMXYZ+JmVmEDZGoOVLs
 eYztcOz0N7bsA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DFB4417E0C7E;
 Fri, 11 Sep 2026 09:40:50 +0200 (CEST)
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
Subject: [PATCH v2 1/2] phy: mediatek: phy-mtk-hdmi-mt8195: Fix PLL calc
 divisor overflow
Date: Fri, 11 Sep 2026 09:40:14 +0200
Message-ID: <20260911074015.9994-2-angelogioacchino.delregno@collabora.com>
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

When trying to calculate a PLL rate for target display resolutions
above 2560x1440, 24bpp, 30Hz, the pixel clock value will be more
than 32-bits long but the division to finally calculate the digital
clock divider is being done with div_u64(), which expects a 32bit
unsigned divisor.

Fix the overflow by using div64_u64() instead.

Fixes: 9d9ff3d2a4a5 ("phy: mediatek: hdmi: mt8195: fix wrong pll calculus")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
index 1426a2db984d..e6ee8e080022 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
@@ -290,7 +290,7 @@ static int mtk_hdmi_pll_calc(struct mtk_hdmi_phy *hdmi_phy, struct clk_hw *hw,
 	posdiv2 = 1;
 
 	/* Digital clk divider, max /32 */
-	digital_div = div_u64(ns_hdmipll_ck, posdiv1 * posdiv2 * pixel_clk);
+	digital_div = div64_u64(ns_hdmipll_ck, posdiv1 * posdiv2 * pixel_clk);
 	if (!(digital_div <= 32 && digital_div >= 1))
 		return -EINVAL;
 
-- 
2.55.0

