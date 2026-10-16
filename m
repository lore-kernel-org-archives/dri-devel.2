Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D485BCCA490
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 22:53:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 375E3112A25;
	Fri, 16 Oct 2026 22:53:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FCE2112A25
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 22:53:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C568B41F9F;
 Fri, 16 Oct 2026 22:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEEA1F000C4;
 Fri, 16 Oct 2026 22:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792191205;
 bh=LlRv1xJEwDddClJTCDo5Ouo4+3MiXlrKRB5a+2iBEKk=;
 h=From:To:Cc:Subject:Date;
 b=ceQKm5lH6M+Xu5deEou0hc2LxHDX84IQGBJjpp/QK3VaQrIxa/qhhLmPx/NB0c7gX
 OT7REVHs+jwon0rov5g5zlHw3bJI+MPQ1znIeQTbKpDF9FG5pgLGl1ITosZnHubrAj
 vZ4KWFH4kDYYZSYMmBFdUNY50D16gZdrMdZR3BSmH0w4D+bRp38cSrUhwFaeclNCL/
 QH7R/z8r7NOKEU+7fZFPxlVHaR3hOu/kD78I0DOoTxjNPxZBIrhAQL8NLlEr38zJed
 XEnV7RDgwwc4H6Ad25JH01fB89QlwqvMIespEYyMyRMf4IW1aahTZEWQ6cvgEqKkIH
 IA4rvJykCQ4bA==
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
 hi6220-dsi to DT schema
Date: Fri, 16 Oct 2026 17:53:18 -0500
Message-ID: <20261016225320.1607923-1-robh@kernel.org>
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

Convert the hisilicon,hi6220-dsi binding to DT schema format. It's a
straight forward conversion.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/display/hisilicon/dw-dsi.txt     | 72 -------------------
 .../hisilicon/hisilicon,hi6220-dsi.yaml       | 68 ++++++++++++++++++
 2 files changed, 68 insertions(+), 72 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
 create mode 100644 Documentation/devicetree/bindings/display/hisilicon/hisilicon,hi6220-dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt b/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
deleted file mode 100644
index d270bfe4e4e0..000000000000
--- a/Documentation/devicetree/bindings/display/hisilicon/dw-dsi.txt
+++ /dev/null
@@ -1,72 +0,0 @@
-Device-Tree bindings for DesignWare DSI Host Controller v1.20a driver
-
-A DSI Host Controller resides in the middle of display controller and external
-HDMI converter or panel.
-
-Required properties:
-- compatible: value should be "hisilicon,hi6220-dsi".
-- reg: physical base address and length of dsi controller's registers.
-- clocks: contains APB clock phandle + clock-specifier pair.
-- clock-names: should be "pclk".
-- ports: contains DSI controller input and output sub port.
-  The input port connects to ADE output port with the reg value "0".
-  The output port with the reg value "1", it could connect to panel or
-  any other bridge endpoints.
-  See Documentation/devicetree/bindings/graph.txt for more device graph info.
-
-A example of HiKey board hi6220 SoC and board specific DT entry:
-Example:
-
-SoC specific:
-	dsi: dsi@f4107800 {
-		compatible = "hisilicon,hi6220-dsi";
-		reg = <0x0 0xf4107800 0x0 0x100>;
-		clocks = <&media_ctrl  HI6220_DSI_PCLK>;
-		clock-names = "pclk";
-		status = "disabled";
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			/* 0 for input port */
-			port@0 {
-				reg = <0>;
-				dsi_in: endpoint {
-					remote-endpoint = <&ade_out>;
-				};
-			};
-		};
-	};
-
-
-Board specific:
-	&dsi {
-		status = "ok";
-
-		ports {
-			/* 1 for output port */
-			port@1 {
-				reg = <1>;
-
-				dsi_out0: endpoint@0 {
-					remote-endpoint = <&adv7533_in>;
-				};
-			};
-		};
-	};
-
-	&i2c2 {
-		...
-
-		adv7533: adv7533@39 {
-			...
-
-			port {
-				adv7533_in: endpoint {
-					remote-endpoint = <&dsi_out0>;
-				};
-			};
-		};
-	};
-
diff --git a/Documentation/devicetree/bindings/display/hisilicon/hisilicon,hi6220-dsi.yaml b/Documentation/devicetree/bindings/display/hisilicon/hisilicon,hi6220-dsi.yaml
new file mode 100644
index 000000000000..868ab185a71a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/hisilicon/hisilicon,hi6220-dsi.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/hisilicon/hisilicon,hi6220-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiSilicon DesignWare DSI Host Controller
+
+maintainers:
+  - Xinliang Liu <z.liuxinliang@hisilicon.com>
+
+properties:
+  compatible:
+    const: hisilicon,hi6220-dsi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: pclk
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        description: Input port, connects to ADE output endpoint.
+        $ref: /schemas/graph.yaml#/properties/port
+
+      port@1:
+        description: Output port, connects to panel or bridge endpoints.
+        $ref: /schemas/graph.yaml#/properties/port
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/hi6220-clock.h>
+
+    dsi@f4107800 {
+        compatible = "hisilicon,hi6220-dsi";
+        reg = <0xf4107800 0x100>;
+        clocks = <&media_ctrl HI6220_DSI_PCLK>;
+        clock-names = "pclk";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                dsi_in: endpoint {
+                    remote-endpoint = <&ade_out>;
+                };
+            };
+        };
+    };
-- 
2.53.0

