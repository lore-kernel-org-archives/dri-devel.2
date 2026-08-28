Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2FEC61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:48:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FAEC10F382;
	Fri, 28 Aug 2026 13:48:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Z75NmrQc";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B79DF10E15A
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 13:48:21 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260828134820euoutp01c6dd8c216fa79e8b57b2653deaa7c7ac~P-DlOOk112621826218euoutp01A;
 Fri, 28 Aug 2026 13:48:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260828134820euoutp01c6dd8c216fa79e8b57b2653deaa7c7ac~P-DlOOk112621826218euoutp01A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787924900;
 bh=CZQ6g0SOIss6kTyIBXZOKF9vf1VOCtlImKy5V/nnOQY=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=Z75NmrQcWgbs6EYo61jSxtdQ7WUBcrWTC2fS/ckMPz7zvfTnXZNBm9q6yn+aq6wDB
 KsaUaLl0fosIiYs+W7oJokoSXUimaPKl0BsHALlSNXq7MZX+34e9Q9EbQ2I0ZC/1I8
 iAOm+1/vwKAsBndNSOUkckrgTZZLSTwXeUkOhbkI=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260828134819eucas1p2c8e2bb95dd957981ec5e60e1da03223c~P-DkwkiRx1640516405eucas1p2I;
 Fri, 28 Aug 2026 13:48:19 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260828134817eusmtip1ad736395c6f4339d7910b9f526dd37bc~P-DizugV62831928319eusmtip1W;
 Fri, 28 Aug 2026 13:48:17 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 28 Aug 2026 15:47:27 +0200
Subject: [PATCH v2 03/15] dt-bindings: mfd: Add starfive,jh7110-hdmi-subsystem
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-jh7110-clean-send-v2-3-331680c8b9d1@samsung.com>
In-Reply-To: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
To: Vinod Koul <vkoul@kernel.org>,  Neil Armstrong
 <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>, Andrzej
 Hajda <andrzej.hajda@intel.com>,  Robert Foss <rfoss@kernel.org>,  Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>,  Simona
 Vetter <simona@ffwll.ch>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Lee Jones <lee@kernel.org>, Andy
 Yan <andy.yan@rock-chips.com>,  Philipp Zabel <p.zabel@pengutronix.de>, 
 Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>,  Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,  Heiko
 Stuebner <heiko@sntech.de>, Conor Dooley <conor@kernel.org>,  Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Icenowy Zheng <uwu@icenowy.me>,  Andy Yan
 <andyshrk@163.com>, Marek Szyprowski <m.szyprowski@samsung.com>,  Maud
 Spierings <maudspierings@gocontroll.com>,  Graham Markall
 <hello@big-grey.co.uk>,  Michal Wilczynski <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260828134819eucas1p2c8e2bb95dd957981ec5e60e1da03223c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260828134819eucas1p2c8e2bb95dd957981ec5e60e1da03223c
X-EPHeader: CA
X-CMS-RootMailID: 20260828134819eucas1p2c8e2bb95dd957981ec5e60e1da03223c
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134819eucas1p2c8e2bb95dd957981ec5e60e1da03223c@eucas1p2.samsung.com>
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

Add the dt-binding for the StarFive JH7110 HDMI subsystem.

The JH7110 HDMI IP is a monolithic block containing both the digital
controller and analog PHY in a single register space. This binding
defines the parent device, which holds the shared register map and
populates its two children: the PHY and the controller. This is
necessary to resolve a circular clock dependency between the HDMI block
and the VOUT clock generator.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 .../mfd/starfive,jh7110-hdmi-subsystem.yaml        | 116 +++++++++++++++++++++
 1 file changed, 116 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-subsystem.yaml b/Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-subsystem.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..01f079160ab8c13c6fa4ce3abaac6607021b3792
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/starfive,jh7110-hdmi-subsystem.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/starfive,jh7110-hdmi-subsystem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: StarFive JH7110 HDMI subsystem
+
+maintainers:
+  - Michal Wilczynski <m.wilczynski@samsung.com>
+
+description:
+  The StarFive JH7110 HDMI block is a monolithic IP containing both
+  the digital controller logic and the analog PHY logic in a single
+  register space.
+
+properties:
+  compatible:
+    const: starfive,jh7110-hdmi-subsystem
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      NoC display bus clock, which gates access to the whole vout
+      register region.
+
+  resets:
+    maxItems: 1
+    description:
+      NoC display bus reset, which gates access to the whole vout
+      register region.
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - power-domains
+
+patternProperties:
+  "^phy(@[0-9a-f]+)?$":
+    $ref: /schemas/phy/starfive,jh7110-inno-hdmi-phy.yaml#
+  "^controller(@[0-9a-f]+)?$":
+    $ref: /schemas/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml#
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh7110-crg.h>
+    #include <dt-bindings/power/starfive,jh7110-pmu.h>
+    #include <dt-bindings/reset/starfive,jh7110-crg.h>
+
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        hdmi@29590000 {
+            compatible = "starfive,jh7110-hdmi-subsystem";
+            reg = <0x29590000 0x4000>;
+            clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_DISP_AXI>;
+            power-domains = <&pwrc JH7110_PD_VOUT>;
+            resets = <&syscrg JH7110_SYSRST_NOC_BUS_DISP_AXI>;
+
+            controller {
+                compatible = "starfive,jh7110-inno-hdmi-controller";
+                clocks = <&voutcrg JH7110_VOUTCLK_HDMI_TX_SYS>,
+                         <&voutcrg JH7110_VOUTCLK_HDMI_TX_MCLK>,
+                         <&voutcrg JH7110_VOUTCLK_HDMI_TX_BCLK>,
+                         <&hdmi_phy>;
+                clock-names = "sys", "mclk", "bclk", "pclk";
+                interrupts = <99>;
+                phys = <&hdmi_phy>;
+                phy-names = "hdmi-phy";
+                resets = <&voutcrg JH7110_VOUTRST_HDMI_TX_HDMI>;
+                reset-names = "hdmi_tx";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+
+                        endpoint {
+                            remote-endpoint = <&dpu_out_dpi0>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        endpoint {
+                            remote-endpoint = <&hdmi_con_in>;
+                        };
+                    };
+                };
+            };
+
+            hdmi_phy: phy {
+                compatible = "starfive,jh7110-inno-hdmi-phy";
+                #clock-cells = <0>;
+                clock-output-names = "hdmi_pclk";
+                clocks = <&xin24m>;
+                clock-names = "refoclk";
+                #phy-cells = <0>;
+            };
+        };
+    };
+...

-- 
2.34.1

