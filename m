Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 474ADC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:30:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F0810E72A;
	Mon,  7 Sep 2026 09:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tq/xG2HO";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37D1910E726
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:30:21 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id F2C9AC45;
 Mon,  7 Sep 2026 11:28:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788773325;
 bh=Yr1AiuMHmmJPJiHFWFVOs/8XEtrzWZT4k4WVIpQ24w8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=tq/xG2HOXn2YhcIMAAWJo2sdDxM5ygzxzBu+TSdXjCDDHzWj5uEW/ywvL88IA7Gt4
 uZX2nLxUeqYJuXIephQEtoHmLpvWWrEe50CIfAzFe8O9BDY3XcRKwMCECprkQKSfBm
 jkP8VgaFkYc4qRW8KS85TAkpz1bPr4CFtFmmJBTY=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Mon, 07 Sep 2026 12:29:40 +0300
Subject: [PATCH v6 1/6] dt-bindings: display: bridge: Document Renesas
 R-Car V4H DSC bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-rcar-du-dsc-v6-1-f8ef711a7494@ideasonboard.com>
References: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
In-Reply-To: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3325;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=/lmCdoPQ0JpVpdqYUEzSqPQ94ZquEeApfn16xdLovjk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnoQmx1MLHtnxj1nzm/hIUy3cMmZxcJL1pUQPk
 eG4maRpSOaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6EJgAKCRD6PaqMvJYe
 9bjPD/9iS3IjIfw7csr523bVxzfUZMDC2HNijIMfNC6nz4YBVjWyym9zyjmaPRquJOTC8hRRmEi
 BPQcCIGV4JZt+RX7qBV75aVcGSvCiNnr9SPdcx6M2JetyUGCl0oygP5xmvZ7zVIdaOgPHUz+n/x
 Fp9MtXfeVbyF1zWbjQkhuS9NEGeo1ioxjgbBvFT/hBhiVZ5yRvjTSonuDFtIfjhQCQsV03H/cfP
 luG8a7jSD1DkF8aAdTTxVUAN3MWw0MiVF7Yee/60eQSMrtueH8yjPViAFTwzTXTNpZABb6zU2kl
 cPTtncw77NLEipAsYZziRZ5cBvNrQgECLh67JYi01BAZDMaJ1HSgNDDb+cKcNf9rQiPnr8zuu+k
 Md7BaIW4lgCbWWilkfLAgERTzwfNThE2D3FWgVw06+ekOzWymlxYLI9xv/yU0i2f2vz13R0Qr3v
 2hzm7qUuFYJP7uV+ffJX5Ci/LzufqS6HjaSF0//JCeTl/jqGVW7y11iPU7Plm/tDyeZriyLWMuo
 kwa02Hmbwp/ZP7zJDdzyCjL5aEvwyug6b+ZbIv8lmLcLAuTLXDiA04/wyL0bGRz88TmmeRD8wQx
 Gj+rIwWki+lhb3RGTwCfWMm0RcftSRFUOexY46xMhFZQMymg29E1e9dNJ/3UxAjqu+/lNfMAISC
 23Wo3OpL+cBql3A==
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
8k or 400 Mpixel/s.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[tomi.valkeinen: fix the example]
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 .../display/bridge/renesas,r8a779g0-dsc.yaml       | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,r8a779g0-dsc.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,r8a779g0-dsc.yaml
new file mode 100644
index 000000000000..6ce2444409a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,r8a779g0-dsc.yaml
@@ -0,0 +1,96 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/renesas,r8a779g0-dsc.yaml#
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
+    bridge@feb8d000 {
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

