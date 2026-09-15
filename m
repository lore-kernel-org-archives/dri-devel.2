Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E81C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8F8710E116;
	Tue, 15 Sep 2026 15:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="XNNy/GcJ";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A80710E116
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:32:20 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260915153218euoutp02a56d102fe7322ba9814edfc78d92f21c~ViFgES5eb3259832598euoutp029;
 Tue, 15 Sep 2026 15:32:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260915153218euoutp02a56d102fe7322ba9814edfc78d92f21c~ViFgES5eb3259832598euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789486338;
 bh=0YIg7pt08eXrFYYUAxipoEMl7cjGgsygcTSVs2pACjU=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=XNNy/GcJ9TvZVz9bcwojbyOOaovWm3gYJRW6lLCCKY6v0/Cw3YujvzBgmRKNnIsUX
 TKWOCdg2UuGItog2w8FG7ME+TimRiXR2QWiGRnuwsh8WrU3SKOCTu201OftIiU/fDK
 i/LyJRPpH/kO3pyn7xtNE+z/kEtsJpzjOjXPv7d4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260915153216eucas1p2388b49e6b4c064ea49639d21f987e05e~ViFeeqKfc0983909839eucas1p2Z;
 Tue, 15 Sep 2026 15:32:16 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260915153215eusmtip1690279a7417c82d889d8ed0d10baca87~ViFcyFEyP0616306163eusmtip1a;
 Tue, 15 Sep 2026 15:32:14 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 15 Sep 2026 17:32:10 +0200
Subject: [PATCH v4 02/20] dt-bindings: display: bridge: Add
 starfive,jh7110-inno-hdmi-controller
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-jh7110-clean-send-v4-2-f0e4fd6f2cc8@samsung.com>
In-Reply-To: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
To: Vinod Koul <vkoul@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>,  Robert Foss <rfoss@kernel.org>,  Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>,  Philipp Zabel <p.zabel@pengutronix.de>, 
 Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>,  Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,  Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,  Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org,  Marek Szyprowski
 <m.szyprowski@samsung.com>,  Maud Spierings <maud_spierings@murena.io>, 
 Graham Markall <hello@big-grey.co.uk>,  Icenowy Zheng
 <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260915153216eucas1p2388b49e6b4c064ea49639d21f987e05e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260915153216eucas1p2388b49e6b4c064ea49639d21f987e05e
X-EPHeader: CA
X-CMS-RootMailID: 20260915153216eucas1p2388b49e6b4c064ea49639d21f987e05e
References: <20260915-jh7110-clean-send-v4-0-f0e4fd6f2cc8@samsung.com>
 <CGME20260915153216eucas1p2388b49e6b4c064ea49639d21f987e05e@eucas1p2.samsung.com>
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

Add the dt-binding for the StarFive JH7110 Innosilicon HDMI controller
(DRM bridge).

This device is the second child of the starfive,jh7110-hdmi-subsystem node.
It consumes its register access, audio master and audio bit clocks
(pclk, mclk, bclk) from voutcrg, and both the pixel clock (pixel) and
the PHY from its hdmi_phy sibling.

Reviewed-by: Joshua Peisach <jpeisach@ubuntu.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../starfive,jh7110-inno-hdmi-controller.yaml      | 121 +++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml b/Documentation/devicetree/bindings/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ea489a7722d0279b3ed67bc2576ec144e31bd05d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml
@@ -0,0 +1,121 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 Innosilicon HDMI Controller
+
+maintainers:
+  - Michal Wilczynski <m.wilczynski@samsung.com>
+
+description:
+  The controller portion of the StarFive JH7110 INNO HDMI IP.
+
+properties:
+  compatible:
+    const: starfive,jh7110-inno-hdmi-controller
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: The HDMI controller main clock
+      - description: Audio master clock
+      - description: Audio bit clock, from the I2S transmitter
+      - description: The pixel clock, generated by the PHY
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: mclk
+      - const: bclk
+      - const: pixel
+
+  resets:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  starfive,vout-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the dom_vout_syscon system controller, which holds the mux
+      selecting the DC8200 output that drives the HDMI transmitter.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          Input from the DC8200. The remote port number selects the DC8200
+          panel and the remote endpoint number the interface on that panel,
+          0 for DPI and 1 for DP.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Output to the HDMI connector.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - phys
+  - starfive,vout-syscon
+  - ports
+
+additionalProperties: false
+
+examples:
+  # Shown as a child of the HDMI subsystem node; see
+  # Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-subsystem.yaml
+  # for the full node.
+  - |
+    #include <dt-bindings/clock/starfive,jh7110-crg.h>
+    #include <dt-bindings/reset/starfive,jh7110-crg.h>
+
+    controller {
+        compatible = "starfive,jh7110-inno-hdmi-controller";
+        clocks = <&voutcrg JH7110_VOUTCLK_HDMI_TX_SYS>,
+                 <&voutcrg JH7110_VOUTCLK_HDMI_TX_MCLK>,
+                 <&voutcrg JH7110_VOUTCLK_HDMI_TX_BCLK>,
+                 <&hdmi_phy>;
+        clock-names = "pclk", "mclk", "bclk", "pixel";
+        interrupts = <99>;
+        phys = <&hdmi_phy>;
+        resets = <&voutcrg JH7110_VOUTRST_HDMI_TX_HDMI>;
+        starfive,vout-syscon = <&vout_syscon>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                endpoint {
+                    remote-endpoint = <&dpu_out_dpi0>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+
+                endpoint {
+                    remote-endpoint = <&hdmi_con_in>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.34.1

