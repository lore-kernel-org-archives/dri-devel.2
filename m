Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ABAC79F8E
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 016B010F963;
	Fri,  4 Sep 2026 13:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="noWUt+NS";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9AA10F9B6
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:27:45 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260904132743euoutp012b4616ffd017ae0aa9b319a14bb63717~SISlvLNbK0653306533euoutp01W;
 Fri,  4 Sep 2026 13:27:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260904132743euoutp012b4616ffd017ae0aa9b319a14bb63717~SISlvLNbK0653306533euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1788528463;
 bh=Jr2wEe6l73xUNZ6aiejF5cyEoIwvzekHVHO47+7fd+k=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=noWUt+NSZx6jtj7QRgfqZr4wmkNoQ3plnPvXwsiAj5XJtIl9pDlfzrXGtNl+BZ0ii
 BG2MxNOKnWYRbjogAATKpxlboo/1a6yITzPnkqJaxTpQgdHpUFvvRgWjLxuuIV5Ys3
 ZN3aydc/eRO8AfSRRk3o+i4W9g4gTIOCvC6h0/wA=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20260904132743eucas1p1e02218d3fb38af95c3dd4bfa24904cab~SISlefGA11560415604eucas1p10;
 Fri,  4 Sep 2026 13:27:43 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260904132741eusmtip111132fc36bcf11ef733fed16ce659593~SISjt8GYW1303913039eusmtip1a;
 Fri,  4 Sep 2026 13:27:41 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 04 Sep 2026 15:27:19 +0200
Subject: [PATCH v3 18/19] riscv: dts: starfive: jh7110: Update DT for
 display subsystem
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-jh7110-clean-send-v3-18-484f9ae72715@samsung.com>
In-Reply-To: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
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
 Belhachemi <db@domibel.de>, Brian Masney <bmasney+clk@redhat.com>,  Jerome
 Brunet <jbrunet+clk@baylibre.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 mfd@lists.linux.dev, linux-clk@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-riscv@lists.infradead.org, Andy Yan <andyshrk@163.com>,  Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Graham Markall <hello@big-grey.co.uk>,  Icenowy
 Zheng <zhengxingda@iscas.ac.cn>,  Michal Wilczynski
 <m.wilczynski@samsung.com>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20260904132743eucas1p1e02218d3fb38af95c3dd4bfa24904cab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260904132743eucas1p1e02218d3fb38af95c3dd4bfa24904cab
X-EPHeader: CA
X-CMS-RootMailID: 20260904132743eucas1p1e02218d3fb38af95c3dd4bfa24904cab
References: <20260904-jh7110-clean-send-v3-0-484f9ae72715@samsung.com>
 <CGME20260904132743eucas1p1e02218d3fb38af95c3dd4bfa24904cab@eucas1p1.samsung.com>
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

Activate the display subsystem by describing the video output subsystem,
which the documentation calls dom_vout_top, as a bus node covering the
whole 0x29400000 region, with dc8200, the HDMI block, the video output
system controller and voutcrg as its children.

The subsystem node owns the resources its children share: the NoC display
bus clock and reset that gate access to every register in the region, and
the PD_VOUT power domain. Modelling it this way keeps a shared gate owned
by the block that shares it rather than by whichever consumer happens to
probe first, and lets dc8200 inherit dma-noncoherent for framebuffer DMA
from the bus it sits on.

The monolithic hdmi node is in turn modelled as a container with hdmi_phy
and hdmi_controller children. This lets the PHY (clock provider,
depending only on xin24m) and the controller (clock consumer) probe
independently, breaking the circular clock dependency with voutcrg.

voutcrg consumes the pixel clock from the &hdmi_phy node instead of the
old fixed-clock, and dc8200 gets its pixel clocks from voutcrg's MUXes.
The old, incorrect hdmitx0-pixel-clock fixed-clock node is removed.

The HDMI controller gets a phandle to the video output system controller,
which holds the mux selecting the DC8200 output that drives the HDMI
transmitter.

CMA is enlarged and constrained to memory the display controller can
address, because the default pool is too small for its framebuffers.

Co-developed-by: Dominique Belhachemi <db@domibel.de>
Signed-off-by: Dominique Belhachemi <db@domibel.de>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 121 +++++++++++++++++++++++-
 arch/riscv/boot/dts/starfive/jh7110.dtsi        | 102 ++++++++++++++++----
 2 files changed, 200 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index a7a1c09a2c9075711f3a214a49618911fdc7b421..5105a7c29120ddec4770b6a712563b6ee421768e 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -33,6 +33,27 @@ memory@40000000 {
 		bootph-pre-ram;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * The display controller allocates its framebuffers from CMA,
+		 * and the default pool is too small for them. Keep the pool
+		 * inside the range the controller can address; it fits in the
+		 * memory every VisionFive 2 variant has.
+		 */
+		linux,cma {
+			compatible = "shared-dma-pool";
+			reusable;
+			size = <0x0 0x20000000>;
+			alignment = <0x0 0x1000>;
+			alloc-ranges = <0x0 0x70000000 0x0 0x20000000>;
+			linux,cma-default;
+		};
+	};
+
 	gpio-restart {
 		compatible = "gpio-restart";
 		gpios = <&sysgpio 35 GPIO_ACTIVE_HIGH>;
@@ -73,12 +94,47 @@ codec {
 			};
 		};
 	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
 };
 
 &cpus {
 	timebase-frequency = <4000000>;
 };
 
+&dc8200 {
+	status = "okay";
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		dpu_port0: port@0 {
+			reg = <0>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			dpu_out_dpi0: endpoint@0 {
+				reg = <0>;
+				remote-endpoint = <&hdmi_in>;
+			};
+		};
+
+		dpu_port1: port@1 {
+			reg = <1>;
+		};
+	};
+};
+
 &dvp_clk {
 	clock-frequency = <74250000>;
 };
@@ -99,8 +155,31 @@ &gmac1_rmii_refin {
 	clock-frequency = <50000000>;
 };
 
-&hdmitx0_pixelclk {
-	clock-frequency = <297000000>;
+&hdmi_controller {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmi_pins>;
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			hdmi_in: endpoint {
+				remote-endpoint = <&dpu_out_dpi0>;
+			};
+		};
+
+		hdmi_out_port: port@1 {
+			reg = <1>;
+
+			hdmi_out_con: endpoint {
+				remote-endpoint = <&hdmi_con_in>;
+			};
+		};
+	};
 };
 
 &i2srx_bclk_ext {
@@ -351,6 +430,40 @@ &syscrg {
 };
 
 &sysgpio {
+	hdmi_pins: hdmi-0 {
+		hdmi-cec-pins {
+			pinmux = <GPIOMUX(14, GPOUT_SYS_HDMI_CEC_SDA,
+					      GPOEN_SYS_HDMI_CEC_SDA,
+					      GPI_SYS_HDMI_CEC_SDA)>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		hdmi-hpd-pins {
+			pinmux = <GPIOMUX(15, GPOUT_HIGH,
+					      GPOEN_ENABLE,
+					      GPI_SYS_HDMI_HPD)>;
+			input-enable;
+			bias-disable; /* external pull-up */
+		};
+
+		hdmi-scl-pins {
+			pinmux = <GPIOMUX(0, GPOUT_SYS_HDMI_DDC_SCL,
+					     GPOEN_SYS_HDMI_DDC_SCL,
+					     GPI_SYS_HDMI_DDC_SCL)>;
+			input-enable;
+			bias-pull-up;
+		};
+
+		hdmi-sda-pins {
+			pinmux = <GPIOMUX(1, GPOUT_SYS_HDMI_DDC_SDA,
+					     GPOEN_SYS_HDMI_DDC_SDA,
+					     GPI_SYS_HDMI_DDC_SDA)>;
+			input-enable;
+			bias-pull-up;
+		};
+	};
+
 	i2c0_pins: i2c0-0 {
 		i2c-pins {
 			pinmux = <GPIOMUX(57, GPOUT_LOW,
@@ -629,3 +742,7 @@ &U74_3 {
 &U74_4 {
 	cpu-supply = <&vdd_cpu>;
 };
+
+&voutcrg {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 9c3e4598747eb5541effe697044484715569a285..0f981f4c89586269b987be8591037c9461e04703 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -290,12 +290,6 @@ gmac1_rmii_refin: gmac1-rmii-refin-clock {
 		#clock-cells = <0>;
 	};
 
-	hdmitx0_pixelclk: hdmitx0-pixel-clock {
-		compatible = "fixed-clock";
-		clock-output-names = "hdmitx0_pixelclk";
-		#clock-cells = <0>;
-	};
-
 	i2srx_bclk_ext: i2srx-bclk-ext-clock {
 		compatible = "fixed-clock";
 		clock-output-names = "i2srx_bclk_ext";
@@ -352,6 +346,13 @@ tdm_ext: tdm-ext-clock {
 		#clock-cells = <0>;
 	};
 
+	xin24m: xin24m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "xin24m";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -1199,22 +1200,81 @@ csi_phy: phy@19820000 {
 			#phy-cells = <0>;
 		};
 
-		voutcrg: clock-controller@295c0000 {
-			compatible = "starfive,jh7110-voutcrg";
-			reg = <0x0 0x295c0000 0x0 0x10000>;
-			clocks = <&syscrg JH7110_SYSCLK_VOUT_SRC>,
-				 <&syscrg JH7110_SYSCLK_VOUT_TOP_AHB>,
-				 <&syscrg JH7110_SYSCLK_VOUT_TOP_AXI>,
-				 <&syscrg JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK>,
-				 <&syscrg JH7110_SYSCLK_I2STX0_BCLK>,
-				 <&hdmitx0_pixelclk>;
-			clock-names = "vout_src", "vout_top_ahb",
-				      "vout_top_axi", "vout_top_hdmitx0_mclk",
-				      "i2stx0_bclk", "hdmitx0_pixelclk";
-			resets = <&syscrg JH7110_SYSRST_VOUT_TOP_SRC>;
-			#clock-cells = <1>;
-			#reset-cells = <1>;
+		vout_subsystem: display-subsystem@29400000 {
+			compatible = "starfive,jh7110-vout-subsystem";
+			reg = <0x0 0x29400000 0x0 0x200000>;
+			ranges;
+			#address-cells = <2>;
+			#size-cells = <2>;
+			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_DISP_AXI>;
+			dma-noncoherent;
 			power-domains = <&pwrc JH7110_PD_VOUT>;
+			resets = <&syscrg JH7110_SYSRST_NOC_BUS_DISP_AXI>;
+
+			dc8200: display@29400000 {
+				compatible = "starfive,jh7110-dc8200", "verisilicon,dc";
+				reg = <0x0 0x29400000 0x0 0x2800>;
+				clocks = <&voutcrg JH7110_VOUTCLK_DC8200_CORE>,
+					 <&voutcrg JH7110_VOUTCLK_DC8200_AXI>,
+					 <&voutcrg JH7110_VOUTCLK_DC8200_AHB>,
+					 <&voutcrg JH7110_VOUTCLK_DC8200_PIX0>,
+					 <&voutcrg JH7110_VOUTCLK_DC8200_PIX1>;
+				clock-names = "core", "axi", "ahb", "pix0", "pix1";
+				interrupts = <95>;
+				resets = <&voutcrg JH7110_VOUTRST_DC8200_CORE>,
+					 <&voutcrg JH7110_VOUTRST_DC8200_AXI>,
+					 <&voutcrg JH7110_VOUTRST_DC8200_AHB>;
+				reset-names = "core", "axi", "ahb";
+			};
+
+			hdmi_subsystem: hdmi@29590000 {
+				compatible = "starfive,jh7110-hdmi-subsystem";
+				reg = <0x0 0x29590000 0x0 0x4000>;
+
+				hdmi_controller: controller {
+					compatible =
+						"starfive,jh7110-inno-hdmi-controller";
+					clocks = <&voutcrg JH7110_VOUTCLK_HDMI_TX_SYS>,
+						 <&voutcrg JH7110_VOUTCLK_HDMI_TX_MCLK>,
+						 <&voutcrg JH7110_VOUTCLK_HDMI_TX_BCLK>,
+						 <&hdmi_phy>;
+					clock-names = "pclk", "mclk", "bclk", "pixel";
+					interrupts = <99>;
+					phys = <&hdmi_phy>;
+					resets = <&voutcrg JH7110_VOUTRST_HDMI_TX_HDMI>;
+					starfive,vout-syscon = <&vout_syscon>;
+				};
+
+				hdmi_phy: phy {
+					compatible = "starfive,jh7110-inno-hdmi-phy";
+					clocks = <&xin24m>;
+					#clock-cells = <0>;
+					#phy-cells = <0>;
+				};
+			};
+
+			vout_syscon: syscon@295b0000 {
+				compatible = "starfive,jh7110-vout-syscon", "syscon";
+				reg = <0x0 0x295b0000 0x0 0x10000>;
+			};
+
+			voutcrg: clock-controller@295c0000 {
+				compatible = "starfive,jh7110-voutcrg";
+				reg = <0x0 0x295c0000 0x0 0x10000>;
+				clocks = <&syscrg JH7110_SYSCLK_VOUT_SRC>,
+					 <&syscrg JH7110_SYSCLK_VOUT_TOP_AHB>,
+					 <&syscrg JH7110_SYSCLK_VOUT_TOP_AXI>,
+					 <&syscrg JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK>,
+					 <&syscrg JH7110_SYSCLK_I2STX0_BCLK>,
+					 <&hdmi_phy>;
+				clock-names = "vout_src", "vout_top_ahb",
+					      "vout_top_axi", "vout_top_hdmitx0_mclk",
+					      "i2stx0_bclk", "hdmitx0_pixelclk";
+				power-domains = <&pwrc JH7110_PD_VOUT>;
+				resets = <&syscrg JH7110_SYSRST_VOUT_TOP_SRC>;
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
 		};
 
 		pcie0: pcie@940000000 {

-- 
2.34.1

