Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D05606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9520F10F009;
	Tue, 24 Nov 2026 07:56:43 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9975A10EFEE
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:56:28 +0000 (UTC)
Received: from edelgard.fodlan.icenowy.me (unknown [120.85.97.139])
 by APP-01 (Coremail) with SMTP id qwCowABHbfcVQwVrAUaUAQ--.8758S3;
 Tue, 24 Nov 2026 15:56:07 +0800 (CST)
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Date: Tue, 24 Nov 2026 15:56:02 +0800
Subject: [PATCH v3 1/2] dt-bindings: display: bridge: document TH1520 MIPI
 DSI controller
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-th1520-dw-mipi-dsi-v3-1-ffcf2d87971b@iscas.ac.cn>
References: <20261124-th1520-dw-mipi-dsi-v3-0-ffcf2d87971b@iscas.ac.cn>
In-Reply-To: <20261124-th1520-dw-mipi-dsi-v3-0-ffcf2d87971b@iscas.ac.cn>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Icneowy Zheng <uwu@icenowy.me>, Han Gao <gaohan@iscas.ac.cn>, 
 Icenowy Zheng <zhengxingda@iscas.ac.cn>
X-Mailer: b4 0.15.0
X-CM-TRANSID: qwCowABHbfcVQwVrAUaUAQ--.8758S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1DZF4kWF1xur1kKFy7trb_yoW5Cr13pa
 yfGF4xJF18tFnxuan3Kr10yF43WrsYvFn8Ww17J340yayYg3W2q39IkF1YgFy8JF1xZa43
 ZF4jvry7Krnavw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUmF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
 x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
 Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
 A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
 e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
 8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
 jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
 kIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
 AY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
 cVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
 AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
 KfnxnUUI43ZEXa7sRiubytUUUUU==
X-CM-SenderInfo: x2kh0wp0lqwv3d6l2u1dvotugofq/
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T-Head TH1520 SoC contains two DesignWare MIPI DSI host controllers.

Add a binding document for them, referencing the common dw-mipi-dsi
binding file.

Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 .../display/bridge/thead,th1520-dw-mipi-dsi.yaml   | 103 +++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/thead,th1520-dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/bridge/thead,th1520-dw-mipi-dsi.yaml
new file mode 100644
index 0000000000000..c12afde5fc26b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/thead,th1520-dw-mipi-dsi.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/thead,th1520-dw-mipi-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: T-Head TH1520 DesignWare MIPI DSI Host Controller
+
+maintainers:
+  - Icenowy Zheng <zhengxingda@iscas.ac.cn>
+
+description:
+  The MIPI DSI host controller in TH1520 is a Synopsys DesignWare MIPI DSI
+  host controller paired with an integrated Synopsys MIPI D-PHY.
+
+allOf:
+  - $ref: snps,dw-mipi-dsi.yaml#
+
+properties:
+  compatible:
+    const: thead,th1520-dw-mipi-dsi
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: DSI controller APB clock
+      - description: PHY configuration clock
+      - description: PHY reference clock
+      - description: DSI controller input pixel clock gate
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: phy_cfg
+      - const: ref
+      - const: pixel
+
+  thead,vo-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the VO_SUBSYS system controller for accessing D-PHY sideband
+      signals.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - interrupts
+  - thead,vo-syscon
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/thead,th1520-clk-ap.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/reset/thead,th1520-reset.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      dsi0: dsi@ffef500000 {
+        compatible = "thead,th1520-dw-mipi-dsi";
+        reg = <0xff 0xef500000 0x0 0x1000>;
+        interrupts = <119 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk_vo CLK_MIPI_DSI0_PCLK>,
+                 <&clk_vo CLK_MIPI_DSI0_CFG>,
+                 <&clk_vo CLK_MIPI_DSI0_REFCLK>,
+                 <&clk_vo CLK_MIPIDSI0_PIXCLK>;
+        clock-names = "pclk", "phy_cfg", "ref", "pixel";
+        resets = <&rst TH1520_RESET_ID_DSI0_APB>;
+        reset-names = "apb";
+        thead,vo-syscon = <&syscon_vo>;
+
+        ports {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          port@0 {
+            reg = <0>;
+
+            dsi0_in: endpoint {
+              remote-endpoint = <&dpu_out_dpi0>;
+            };
+          };
+
+          dsi0_out_port: port@1 {
+            reg = <1>;
+
+            dsi0_out_panel: endpoint {
+              remote-endpoint = <&panel_in>;
+            };
+          };
+        };
+      };
+    };

-- 
2.56.0

