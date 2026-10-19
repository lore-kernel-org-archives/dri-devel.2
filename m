Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A836CCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:29:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B704510E9A6;
	Mon, 19 Oct 2026 10:28:55 +0000 (UTC)
Received: from mail-m8190.xmail.ntesmail.com (mail-m8190.xmail.ntesmail.com
 [156.224.81.90])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE6110E9A6
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:28:49 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 518d3dd93;
 Mon, 19 Oct 2026 18:28:44 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dave Jones <s.dave.jones@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v2 2/6] dt-bindings: phy: Add rockchip,rk3568-edp-phy
Date: Mon, 19 Oct 2026 18:28:20 +0800
Message-Id: <20261019102824.3157044-3-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019102824.3157044-1-damon.ding@rock-chips.com>
References: <20261019102824.3157044-1-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa153b4dcab03a8kunme348c01b2f6c23
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHxgYVkNIThlMThpPHUxJSVYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=OsrTuEvGRar69oVJvDEGrHyGHJx0cRXhFo3RZDydmmLlOhxprf5M5JS8BIV8sxhtA+Ov7BB80zmj0ic9xAoXpXEKyJpJOaNH81zVu7Azg0KnZ4E7a881tK/1ZJkIGllwUWYzwpuayoG/5BmHLRxLVDSiI58B6NcqJppU17oXVyM=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=V6YTkuc+JQ/Q5NgJoM+Ztyfr/5wVw30o5S+KA6zRLSw=;
 h=date:mime-version:subject:message-id:from;
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

Document the eDP transmitter PHY with NaNeng IP block found on the
RK3568 SoC.  The PHY is controlled through the eDP PHY GRF registers,
so its node is modeled as a child of the eDP PHY GRF syscon.  Also
add the "rockchip,rk3568-edp-phy-grf" compatible and the "edp-phy"
child node reference to the Rockchip GRF schema.

Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
---
 .../bindings/phy/rockchip,rk3568-edp-phy.yaml | 59 +++++++++++++++++++
 .../devicetree/bindings/soc/rockchip/grf.yaml | 15 +++++
 2 files changed, 74 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml
new file mode 100644
index 000000000000..afe7bc3d839e
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/rockchip,rk3568-edp-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Rockchip eDP Transmitter PHY with NaNeng IP block
+
+maintainers:
+  - Damon Ding <damon.ding@rock-chips.com>
+  - Heiko Stuebner <heiko@sntech.de>
+
+description:
+  On the RK3568 SoC the eDP PHY is controlled through the eDP PHY GRF
+  registers, therefore the PHY node is expected to be a child of the
+  eDP PHY GRF syscon node.
+
+properties:
+  compatible:
+    const: rockchip,rk3568-edp-phy
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: refclk
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      edp_phy_grf: syscon@fdcb0000 {
+        compatible = "rockchip,rk3568-edp-phy-grf", "syscon", "simple-mfd";
+        reg = <0x0 0xfdcb0000 0x0 0x100>;
+        clocks = <&cru PCLK_EDPPHY_GRF>;
+
+        edp_phy: edp-phy {
+          compatible = "rockchip,rk3568-edp-phy";
+          clocks = <&pmucru XIN_OSC0_EDPPHY_G>;
+          clock-names = "refclk";
+          #phy-cells = <0>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 7bcb4e2f47ec..8d4ced0145b8 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -93,6 +93,7 @@ properties:
               - rockchip,rk3399-grf
               - rockchip,rk3399-pmugrf
               - rockchip,rk3562-pmu-grf
+              - rockchip,rk3568-edp-phy-grf
               - rockchip,rk3568-grf
               - rockchip,rk3568-pmugrf
               - rockchip,rk3576-ioc-grf
@@ -156,6 +157,19 @@ allOf:
           $ref: /schemas/phy/rockchip,rk3288-dp-phy.yaml#
           unevaluatedProperties: false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: rockchip,rk3568-edp-phy-grf
+
+    then:
+      properties:
+        edp-phy:
+          type: object
+          $ref: /schemas/phy/rockchip,rk3568-edp-phy.yaml#
+          unevaluatedProperties: false
+
   - if:
       properties:
         compatible:
@@ -309,6 +323,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - rockchip,rk3568-edp-phy-grf
               - rockchip,rk3576-dcphy-grf
               - rockchip,rk3576-vo1-grf
               - rockchip,rk3588-vo-grf
-- 
2.34.1

