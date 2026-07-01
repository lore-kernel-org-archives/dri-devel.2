Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D53BC43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B42210EF31;
	Wed,  1 Jul 2026 12:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="i1O9Zak7";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 638E110EF1A
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908412;
 bh=rlrocfrwUi1WdDzcOfpioxB0V1rUVL+jREcY40uW8uk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i1O9Zak7jFbTBKUZP6O0DBiG4fCRjEyDlAqLDtZlfJ/xVqZeyHPlDZWQo9DYTO4Wx
 XA8toww+wU9shq1e68MJfPcwnuGRTYY0I6vBP/dpMUum2VoypsQI9s6Gji8D3COhzC
 G2z2HDjWno22q87YmPP7dvzUJt2/fvAgzikkDLuZeEEAY41FmKUUrwQ7m9l072+via
 g5cm1TJNARLfMIgYa01J3sjdlcRwxT/IVPTmOEVigvSeW03+c7ht/s/YCg/a807nAb
 TOSR/LCc+K2tJALN+MztTfTweK8GUgsRGhVk9uNgvQc7qiAzzpWxQdFXCDkqhqJFQ6
 VmYwTjZ3c+W+Q==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 77CDB17E0CA0;
 Wed,  1 Jul 2026 14:20:11 +0200 (CEST)
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
Subject: [PATCH 01/12] dt-bindings: phy: Document MT8195 and MT8196
 DisplayPort PHYs
Date: Wed,  1 Jul 2026 14:19:57 +0200
Message-ID: <20260701122008.19509-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
References: <20260701122008.19509-1-angelogioacchino.delregno@collabora.com>
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

This adds bindings for the DisplayPort and Embedded DisplayPort
PHYs found in the MediaTek MT8195 SoC (and variants of) and for
the Embedded DisplayPort found in the MT8196 SoC (and variants).

This PHY supports varying impedance calibrations for the various
signals to reach an optimal EYE signal pattern for any specific
board(s), especially useful for very high bitrates such as HBR3
and higher, depending on board design.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/phy/mediatek,mt8195-dp-phy.yaml  | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.yaml
new file mode 100644
index 000000000000..5847963a7085
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/mediatek,mt8195-dp-phy.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/mediatek,mt8195-dp-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek SoC DisplayPort Transmitter PHY
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt8195-dp-phy
+      - mediatek,mt8196-edp-phy
+
+  reg:
+    maxItems: 1
+
+  "#phy-cells":
+    const: 0
+
+  nvmem-cells:
+    description: PHY calibrations from eFuse for optimal EYE signal pattern
+    items:
+      - description: PHY-Global Reference Bias trim
+      - description: PHY-Global AUX Transmitter clock impedance adjustment
+      - description: Lane 0 Transmitter impedance selection (P-MOSFET)
+      - description: Lane 0 Transmitter impedance selection (N-MOSFET)
+      - description: Lane 1 Transmitter impedance selection (P-MOSFET)
+      - description: Lane 1 Transmitter impedance selection (N-MOSFET)
+      - description: Lane 2 Transmitter impedance selection (P-MOSFET)
+      - description: Lane 2 Transmitter impedance selection (N-MOSFET)
+      - description: Lane 3 Transmitter impedance selection (P-MOSFET)
+      - description: Lane 3 Transmitter impedance selection (N-MOSFET)
+
+  nvmem-cell-names:
+    items:
+      - const: rbias-trim
+      - const: impedance-txclk
+      - const: impedance-lane0p
+      - const: impedance-lane0n
+      - const: impedance-lane1p
+      - const: impedance-lane1n
+      - const: impedance-lane2p
+      - const: impedance-lane2n
+      - const: impedance-lane3p
+      - const: impedance-lane3n
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@1c500000 {
+        compatible = "mediatek,mt8195-dp-phy";
+        reg = <0 0x1c500000 0 0x2000>;
+        #phy-cells = <0>;
+        nvmem-cells = <&edp_glb_bias_trim>, <&edp_clktx_impsel>,
+                      <&edp_imp_ln0_pmos>, <&edp_imp_ln0_nmos>,
+                      <&edp_imp_ln1_pmos>, <&edp_imp_ln1_nmos>,
+                      <&edp_imp_ln2_pmos>, <&edp_imp_ln2_nmos>,
+                      <&edp_imp_ln3_pmos>, <&edp_imp_ln3_nmos>;
+        nvmem-cell-names = "rbias-trim", "impedance-txclk",
+                           "impedance-lane0p", "impedance-lane0n",
+                           "impedance-lane1p", "impedance-lane1n",
+                           "impedance-lane2p", "impedance-lane2n",
+                           "impedance-lane3p", "impedance-lane3n";
+    };
-- 
2.54.0

