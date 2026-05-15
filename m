Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E2DCD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:10:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 234A010E00F;
	Fri, 15 May 2026 09:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DHKkwbeS";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFA310E00F
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:10:01 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0A0508FA;
 Fri, 15 May 2026 11:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778836190;
 bh=kHksZJfpFMV47h8nwdHcFDKgVfCurmMft/yFeQpokLU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=DHKkwbeSS5VYcx4gG5/X+1z7Y/8pVMELOaeTkpby2KYZcrKfSEZzBUOBOHWotYAMx
 M0sGiedY/dy1qwq4TaVD4qbhi/jDtxdj+akVcK9sUSaddgjACvJa9rKZQwdzl00saV
 5nxi5M/woIWNq9VIK7B69IFUGh3742lRAwK1rzWg=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Fri, 15 May 2026 12:09:27 +0300
Subject: [PATCH v3 2/7] dt-bindings: display: bridge: Document Renesas
 R-Car V4H DSC bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-rcar-du-dsc-v3-2-164157820498@ideasonboard.com>
References: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
In-Reply-To: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3100;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=2I8UDeCqT/cBmhnGJPNLMM2v8v1+nikKwEBiZMwtls4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBuLhbW1mhCjr09AFE2KgytB8mnKa6AjvIuikT
 NyD2PGebFmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagbi4QAKCRD6PaqMvJYe
 9TSfD/0YKMJMP2O2NflaziOWV6m+6vSbdgJxqk1w/6BmTL8dSzVAeNYs03V0D7qyb6+dgYdwpwQ
 oE1QxE5RbhQbgScVDrFRpy5CzjLQG5ivXgq3fbGE5VOSDXQdgu5Y4BjimG2Z1LY9uml8LUjRMhf
 2a2AyCJuitisvfvXAvOklFqax+njfL7bEEENgIUdyOMXq3xHEmtjBqniVpYb2xDATFjbr8NSh9g
 LmTUYLU7HfYrv9vw8CsHAwBkBpqPrmPvgytbTHFOsW3/eclBhNLJWvQg8N/6sZPVtoGmWSFv3DT
 9+Gz2BBr/Cm8BK1yro6z0Pb72vuukaIIOS9Tz7V+i9DT0jyTZgzene86mwD22kkKeUgtcq00ikw
 xqh7kRnag/g2zUVUJxNblJZW80+l+ACfl5lxif2f8FW+ep2TYta2bhjP8iUo+x7xmPwu/wyy2Nw
 l1tzkCQKRagba9DJPqM8IUmvoF2nrtA8lq2JmsbHhZtOZTUtWFJ2RKgtkPCXO/MamEeApKlahO8
 XM0l4G9/0Bqwf7jJtpZgicyD3YbPSY6sQULQKnrlHVSBwJnV7xhCLT+BRPCVetsr1y1bB3yvloh
 ZCmji19tyhi8gaCNj0esJJA7Unuc7slB+pH8dns88nVkEuX1jBk8piw3ZorJlfZu+haZSGIWeRt
 H7CCBOKyMrV3b7g==
X-Developer-Key: i=tomi.valkeinen+renesas@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

The Renesas DSC Display Stream Compression is a bridge embedded in the
Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
8k or 400 Mpixel/s .

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[tomi.valkeinen: fix the example]
Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 .../bindings/display/bridge/renesas,dsc.yaml       | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml
new file mode 100644
index 000000000000..2918d592732b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsc.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/renesas,dsc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Car DSC Display Stream Compression
+
+maintainers:
+  - Marek Vasut <marek.vasut+renesas@mailbox.org>
+
+description: |
+  This binding describes the VESA DSC Display Stream Compression encoder
+  embedded in the Renesas R-Car V4H SoC. The encoder supports all DSC1.1
+  encoding mechanisms, configurable bits-per-pixel, resolution up to 8k.
+
+properties:
+  compatible:
+    const: renesas,r8a779g0-dsc
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: R-Car DU input port
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: R-Car DSI output port
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+  - power-domains
+  - resets
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a779g0-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a779g0-sysc.h>
+
+    dsc@feb8d000 {
+        compatible = "renesas,r8a779g0-dsc";
+        reg = <0xfeb8d000 0x400>;
+        interrupts = <GIC_SPI 559 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&cpg CPG_MOD 2819>;
+        power-domains = <&sysc R8A779G0_PD_ALWAYS_ON>;
+        resets = <&cpg 2819>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                dsc_in_dsi1: endpoint {
+                    remote-endpoint = <&du_out_dsi1>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                dsc_out_dsi1: endpoint {
+                    remote-endpoint = <&dsi1_in>;
+                };
+            };
+        };
+    };
+...

-- 
2.43.0

