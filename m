Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B759EC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:21:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5B310EF6D;
	Wed,  1 Jul 2026 12:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="XCW5gznU";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F8BD10EF6B
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782908492;
 bh=GHTuSs66oG/01+0w93FaDKtJj2yb08VuTz9Ap4IIaZ0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XCW5gznUmLImn0YtTBTdj/QWVJpbW5bZQQhSE6WKcV/bfZd7E3k7x5ahTKQTC0/uJ
 EAxpMMGSl1ck5Tj1H1ER4Rgv/HNw71sTrvd6d2GbWJNMUW1tvFOSBtfsuF0XUisueI
 DFjJbQdTu4+Lc2bJLWPrewotoOrc06Qol32fuB1j3LNiH7Fo/KRKggS6CT8yBYfULQ
 CEZOF7nWawXk3iGvvtDmP0fbq4uhcIR2oiOUhyQfzbTYDQzW0hE3wQNV0DHLNR3HXD
 hUuOl/XXT3me2tsTsUczUeA0naGbJjXedScRGS9gkDW0QqF1I+BFPAmhUZbC5/teje
 uFAtOCH5QmUfQ==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 80C7E17E0FAA;
 Wed,  1 Jul 2026 14:21:31 +0200 (CEST)
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
Subject: [PATCH 23/42] dt-bindings: display: mediatek: Introduce Digital Video
 Output HW
Date: Wed,  1 Jul 2026 14:20:38 +0200
Message-ID: <20260701122057.19648-24-angelogioacchino.delregno@collabora.com>
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

Add documentation for the Digital Video Output (DVO) IP found in
the newer generation SoCs MT8196, MT8189 and their variants.

This is effectively a more capable block replacing the DisplayPort
Interface (DPI/DP_INTF) one found in older SoCs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../display/mediatek/mediatek,mt8196-dvo.yaml | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml
new file mode 100644
index 000000000000..8e73586e74b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mt8196-dvo.yaml
@@ -0,0 +1,142 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/mediatek/mediatek,mt8196-dvo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek Digital Video Output (DVO) Controller
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description:
+  The MediaTek Digital Video Output (DVO) hardware provides 120-bits (4P) data,
+  video timing and info data for the Embedded DisplayPort, hardware-abstracting
+  the previous generation Display Port Interface (DPI/DP_INTF) blocks, other
+  than providing new capabilities.
+  This hardware block supports 1/2/4 pixels per iteration in both its input and
+  output and provides 8/10-bit RGB, YUV422 and YUV444 data formats in output,
+  other than supporting input/output video window cropping and padding.
+  Digital Video Output also provides Panel Self Refresh (PSR) and Multi-SST
+  Operation (MSO) features for eDP 1.3/1.4.
+
+properties:
+  compatible:
+    - const: mediatek,mt8189-dp-dvo
+    - const: mediatek,mt8189-edp-dvo
+    - const: mediatek,mt8196-edp-dvo
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Pixel Clock
+      - description: Engine Clock
+      - description: DVO PLL
+
+  clock-names:
+    items:
+      - const: pixel
+      - const: engine
+      - const: pll
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  pinctrl-names:
+    items:
+      - const: default
+      - const: sleep
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Digital Video Output's input port
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: DVO output to an HDMI, LVDS or DisplayPort encoder input
+
+    required:
+      - port@0
+      - port@1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: dvo
+
+  trigger-sources:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/mediatek,mt8196-clock.h>
+    #include <dt-bindings/power/mediatek,mt8196-power.h>
+
+    dvo@324c0000 {
+        compatible = "mediatek,mt8196-edp-dvo";
+        reg = <0x324c0000 0x1000>;
+        interrupts = <GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&dispsys1 CLK_MM1_DISP_DVO0>,
+                 <&dispsys1 CLK_MM1_MOD6>,
+                 <&apmixedsys_gp2 CLK_APMIXED2_TVDPLL3>;
+        clock-names = "pixel", "engine", "pll";
+        power-domains = <&hpm_hwv MT8196_POWER_DOMAIN_DIS0_DORMANT>;
+        pinctrl-names = "default", "sleep";
+        pinctrl-0 = <&dvo_pins_default>;
+        pinctrl-1 = <&dvo_pin_sleep>;
+        trigger-sources = <&disp1_mutex 29>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <0>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&directlink_output>;
+                };
+            };
+
+            port@1 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                reg = <1>;
+
+                endpoint@0 {
+                    reg = <0>;
+                    remote-endpoint = <&displayport_input>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.54.0

