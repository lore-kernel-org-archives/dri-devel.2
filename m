Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724F0CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB16310E9D4;
	Tue, 29 Sep 2026 10:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="C/np18Cx";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58DFB10E9CA
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:32:12 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260929103211euoutp013e4b727d148dfe4bdcc9951da544ba1c~ZxBdMcdNz2203722037euoutp01H;
 Tue, 29 Sep 2026 10:32:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260929103211euoutp013e4b727d148dfe4bdcc9951da544ba1c~ZxBdMcdNz2203722037euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1790677931;
 bh=MKLvsZDTxV7ybpoebvLT9Kn8X92Nr0i8VDIIMmcjFSw=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=C/np18Cxn1f7JYp81uWOLbc9E7T880CmaOg0AGI5d3VZb4ADgtLzksFhwB5eZ8136
 YNwv9QtW02XP54ImM4RhKZgzDCuZzks07f5A57Xqvwqouo1l7B0ZO1kCXs9WEHF//M
 sylLVxT/CBGvUPJ+NrejGZ6otA/PS8caVb2CVprU=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260929103210eucas1p2d7e77f1147a03dac0536f6069505ea51~ZxBcOOZcF0813908139eucas1p2G;
 Tue, 29 Sep 2026 10:32:10 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260929103207eusmtip12ebef0a7d688c53091a782c11596334b~ZxBZ6a0s62914029140eusmtip1f;
 Tue, 29 Sep 2026 10:32:07 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Tue, 29 Sep 2026 12:31:01 +0200
Subject: [PATCH v5 04/21] dt-bindings: soc: starfive: Add
 starfive,jh7110-hdmi-subsystem
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-jh7110-clean-send-v5-4-82b4d8e3c6c7@samsung.com>
In-Reply-To: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
To: Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,  Robert Foss
 <rfoss@kernel.org>,  Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Andy Yan
 <andy.yan@rock-chips.com>, Philipp Zabel <p.zabel@pengutronix.de>,  Emil
 Renner Berthing <kernel@esmil.dk>,  Hal Feng <hal.feng@starfivetech.com>, 
 Michael Turquette <mturquette@baylibre.com>,  Stephen Boyd
 <sboyd@kernel.org>, Heiko Stuebner <heiko@sntech.de>,  Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,  Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,  Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Graham Markall <hello@big-grey.co.uk>,  Icenowy
 Zheng <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260929103210eucas1p2d7e77f1147a03dac0536f6069505ea51
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260929103210eucas1p2d7e77f1147a03dac0536f6069505ea51
X-EPHeader: CA
X-CMS-RootMailID: 20260929103210eucas1p2d7e77f1147a03dac0536f6069505ea51
References: <20260929-jh7110-clean-send-v5-0-82b4d8e3c6c7@samsung.com>
 <CGME20260929103210eucas1p2d7e77f1147a03dac0536f6069505ea51@eucas1p2.samsung.com>
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
 .../starfive/starfive,jh7110-hdmi-subsystem.yaml   | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-hdmi-subsystem.yaml b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-hdmi-subsystem.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..2ff8b0b920aec41a83f0aeaa0ed9c4249fe87f46
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-hdmi-subsystem.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/starfive/starfive,jh7110-hdmi-subsystem.yaml#
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
+  register space. It sits inside the video output subsystem, which owns
+  the NoC bus clock and reset gating this region and the power domain it
+  belongs to.
+
+properties:
+  compatible:
+    const: starfive,jh7110-hdmi-subsystem
+
+  reg:
+    maxItems: 1
+
+  phy:
+    $ref: /schemas/phy/starfive,jh7110-inno-hdmi-phy.yaml#
+
+  controller:
+    $ref: /schemas/display/bridge/starfive,jh7110-inno-hdmi-controller.yaml#
+
+required:
+  - compatible
+  - reg
+  - phy
+  - controller
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/starfive,jh7110-crg.h>
+    #include <dt-bindings/reset/starfive,jh7110-crg.h>
+
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        hdmi@29590000 {
+            compatible = "starfive,jh7110-hdmi-subsystem";
+            reg = <0x29590000 0x4000>;
+
+            controller {
+                compatible = "starfive,jh7110-inno-hdmi-controller";
+                clocks = <&voutcrg JH7110_VOUTCLK_HDMI_TX_SYS>,
+                         <&voutcrg JH7110_VOUTCLK_HDMI_TX_MCLK>,
+                         <&voutcrg JH7110_VOUTCLK_HDMI_TX_BCLK>,
+                         <&hdmi_phy>;
+                clock-names = "pclk", "mclk", "bclk", "pixel";
+                interrupts = <99>;
+                phys = <&hdmi_phy>;
+                resets = <&voutcrg JH7110_VOUTRST_HDMI_TX_HDMI>;
+                starfive,vout-syscon = <&vout_syscon>;
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
+                clocks = <&xin24m>;
+                #phy-cells = <0>;
+            };
+        };
+    };
+...

-- 
2.34.1

