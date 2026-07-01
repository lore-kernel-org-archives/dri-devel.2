Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDDFC4450B
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:19:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48CA010E373;
	Wed,  1 Jul 2026 12:19:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Ke5dK4aU";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62DB10E372
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908386;
 bh=N9qgTD2hCOq6phgEAOhZ0sHaU3HIB5GFM6z3BqTcBcQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ke5dK4aUjJAAyxOCMHrVw+wFCSjKctNVXNUUd3oWnDuL8t2IHkB2g30mKK+SoCWtN
 CCw/nWwMppgS55qcOd8TO0ooye19JVtUaN4G+60zM2eoi3SRQIWCuBqXXsEUnhlr3m
 Da6VsdtHiuaHQNEJJf/QY7fJ2NKm/nsmWlKGdwqsDBefrF1NLKe/gCtpfkN/tG2f6F
 66dRwm0ltM6f4zm9zyGT6yavcHjYi+F41TLzrPqSsuY2MonSLpiDh6lhgaM/OvIP9e
 1AirmzWy24MVgvRMpJq/LFBHeQuHulUkNGm303r1Ytj77+WIC7JzViCCzE9IdhG/ua
 5k+vFXg9OKV0g==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B15D817E0CA2;
 Wed,  1 Jul 2026 14:19:45 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunfeng.yun@mediatek.com
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, justin.yeh@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: [PATCH 1/2] dt-bindings: phy: mediatek,
 dsi-phy: Add support for MT8196
Date: Wed,  1 Jul 2026 14:19:42 +0200
Message-ID: <20260701121943.19430-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701121943.19430-1-angelogioacchino.delregno@collabora.com>
References: <20260701121943.19430-1-angelogioacchino.delregno@collabora.com>
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

Add support for the MediaTek Kompanio Ultra (MT8196) SoC: this
chip features a DSI PHY that is similar to the one found in the
MT8183 SoC, but is a new (incremental) revision with a different
register layout.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
index c6d0bbdbe0e2..9df1dbe1253b 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
@@ -39,6 +39,7 @@ properties:
       - const: mediatek,mt2701-mipi-tx
       - const: mediatek,mt8173-mipi-tx
       - const: mediatek,mt8183-mipi-tx
+      - const: mediatek,mt8196-mipi-tx
 
   reg:
     maxItems: 1
-- 
2.54.0

