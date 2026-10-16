Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C733CCA490
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 22:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC453112A38;
	Fri, 16 Oct 2026 22:53:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9353112A38
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 22:53:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0CB2660238;
 Fri, 16 Oct 2026 22:53:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911C91F000C4;
 Fri, 16 Oct 2026 22:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792191213;
 bh=N1MYrDjXbE41ZMcf/y17zpem1qYEaBPUcFdCKtBTz10=;
 h=From:To:Cc:Subject:Date;
 b=Dq/aFsK9bMgGyRiQ/NRIQqYr8ifsHxF+LyLXrL2Rpj16A1oksUnN/ssJdol+vLXYY
 /OcM5D7UslgQyBFsAZ2q8b+MKbSrStHlTKPSWYsacqpB5Tp8pjkEpuPSPC/tKuZaXk
 IsIJX9yt92zzBneHLG7M3QVr0GYCFT845nbu9HrdQxeqkS1ERQsrAUm/69ReuhBcJU
 5wJ6Ikx2negXABjZhFlhRop0odKM75k2ucV+Cw7Zj4WsMeoQa8JnWB3AX8OrmhAzen
 0qd7SWPYL1WIvIv6//9tO/JRGhP8Z+s5+44xbCYrqXAmyNGIwWXdB0tMD0a5RF7xF+
 4GWwIsCOWaF2w==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Xinliang Liu <xinliang.liu@linaro.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: display: Convert hisilicon,
 hi6220-ade to DT schema
Date: Fri, 16 Oct 2026 17:53:29 -0500
Message-ID: <20261016225330.1609022-1-robh@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Convert the hisilicon,hi6220-ade binding to DT schema format. Drop the
assigned-clocks as those are implicit and should never be required.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/display/hisilicon/hisi-ade.txt   | 64 -------------
 .../hisilicon/hisilicon,hi6220-ade.yaml       | 95 +++++++++++++++++++
 2 files changed, 95 insertions(+), 64 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
 create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisilicon,hi6220-ade.yaml

diff --git a/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt b/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
deleted file mode 100644
index 305a0e72a900..000000000000
--- a/Documentation/devicetree/bindings/display/hisilicon/hisi-ade.txt
+++ /dev/null
@@ -1,64 +0,0 @@
-Device-Tree bindings for hisilicon ADE display controller driver
-
-ADE (Advanced Display Engine) is the display controller which grab image
-data from memory, do composition, do post image processing, generate RGB
-timing stream and transfer to DSI.
-
-Required properties:
-- compatible: value should be "hisilicon,hi6220-ade".
-- reg: physical base address and length of the ADE controller's registers.
-- hisilicon,noc-syscon: ADE NOC QoS syscon.
-- resets: The ADE reset controller node.
-- interrupt: the ldi vblank interrupt number used.
-- clocks: a list of phandle + clock-specifier pairs, one for each entry
-  in clock-names.
-- clock-names: should contain:
-  "clk_ade_core" for the ADE core clock.
-  "clk_codec_jpeg" for the media NOC QoS clock, which use the same clock with
-  jpeg codec.
-  "clk_ade_pix" for the ADE pixel clock.
-- assigned-clocks: Should contain "clk_ade_core" and "clk_codec_jpeg" clocks'
-  phandle + clock-specifier pairs.
-- assigned-clock-rates: clock rates, one for each entry in assigned-clocks.
-  The rate of "clk_ade_core" could be "360000000" or "180000000";
-  The rate of "clk_codec_jpeg" could be or less than "1440000000".
-  These rate values could be configured according to performance and power
-  consumption.
-- port: the output port. This contains one endpoint subnode, with its
-  remote-endpoint set to the phandle of the connected DSI input endpoint.
-  See Documentation/devicetree/bindings/graph.txt for more device graph info.
-
-Optional properties:
-- dma-coherent: Present if dma operations are coherent.
-
-
-A example of HiKey board hi6220 SoC specific DT entry:
-Example:
-
-	ade: ade@f4100000 {
-		compatible = "hisilicon,hi6220-ade";
-		reg = <0x0 0xf4100000 0x0 0x7800>;
-		reg-names = "ade_base";
-		hisilicon,noc-syscon = <&medianoc_ade>;
-		resets = <&media_ctrl MEDIA_ADE>;
-		interrupts = <0 115 4>; /* ldi interrupt */
-
-		clocks = <&media_ctrl HI6220_ADE_CORE>,
-			 <&media_ctrl HI6220_CODEC_JPEG>,
-			 <&media_ctrl HI6220_ADE_PIX_SRC>;
-		/*clock name*/
-		clock-names  = "clk_ade_core",
-			       "clk_codec_jpeg",
-			       "clk_ade_pix";
-
-		assigned-clocks = <&media_ctrl HI6220_ADE_CORE>,
-			<&media_ctrl HI6220_CODEC_JPEG>;
-		assigned-clock-rates = <360000000>, <288000000>;
-		dma-coherent;
-
-		port {
-			ade_out: endpoint {
-				remote-endpoint = <&dsi_in>;
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/display/hisilicon/hisilicon,hi6220-ade.yaml b/Documentation/devicetree/bindings/display/hisilicon/hisilicon,hi6220-ade.yaml
new file mode 100644
index 000000000000..ec3d4b775a88
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/hisilicon/hisilicon,hi6220-ade.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/hisilicon/hisilicon,hi6220-ade.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Hisilicon ADE Display Controller
+
+maintainers:
+  - Xinliang Liu <z.liuxinliang@hisilicon.com>
+
+description:
+  ADE (Advanced Display Engine) is the display controller which grab image
+  data from memory, do composition, do post image processing, generate RGB
+  timing stream and transfer to DSI.
+
+properties:
+  compatible:
+    const: hisilicon,hi6220-ade
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: ade_base
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: clk_ade_core
+      - const: clk_codec_jpeg
+      - const: clk_ade_pix
+
+  dma-coherent: true
+
+  interrupts:
+    items:
+      - description: LDI vblank interrupt specifier.
+
+  resets:
+    maxItems: 1
+
+  hisilicon,noc-syscon:
+    description: ADE NOC QoS syscon.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: Output port containing an endpoint subnode.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - interrupts
+  - resets
+  - hisilicon,noc-syscon
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/hi6220-clock.h>
+    #include <dt-bindings/reset/hisi,hi6220-resets.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        ade@f4100000 {
+            compatible = "hisilicon,hi6220-ade";
+            reg = <0x0 0xf4100000 0x0 0x7800>;
+            reg-names = "ade_base";
+            clocks = <&media_ctrl HI6220_ADE_CORE>,
+                     <&media_ctrl HI6220_CODEC_JPEG>,
+                     <&media_ctrl HI6220_ADE_PIX_SRC>;
+            clock-names = "clk_ade_core", "clk_codec_jpeg", "clk_ade_pix";
+            dma-coherent;
+            interrupts = <0 115 4>;
+            resets = <&media_ctrl MEDIA_ADE>;
+            hisilicon,noc-syscon = <&medianoc_ade>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&dsi_in>;
+                };
+            };
+        };
+    };
-- 
2.53.0

