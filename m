Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D051C61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 13:48:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FD6010F3A7;
	Fri, 28 Aug 2026 13:48:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="OuSE0sbB";
	dkim-atps=neutral
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35B1A10F39D
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 13:48:41 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20260828134839euoutp0176e5981555e5cf18da35671d55adc57f~P-D3mrIux3071330713euoutp01G;
 Fri, 28 Aug 2026 13:48:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20260828134839euoutp0176e5981555e5cf18da35671d55adc57f~P-D3mrIux3071330713euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1787924919;
 bh=FVW+IthoCWYlGIWY+ho3Ua+WhD1ThrlaWSmrCvvW92g=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=OuSE0sbBIBJD46bR7asK+3q7aNIhwrj+7X9uqtSd/iGUiGfnamLcZjVmRk4ajVilC
 HxYHxF2Ldm8kD8ZOwp5I8BNJJEanm3Hi9c1tR4mJq6jiHv4B/F93l2YT2RicptC16K
 JaYru0mWVgEJAS2xFjukcC0BD8Jjqm2emzCOSBpk=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260828134839eucas1p2d19363d17d4dbf5a7ae5228444af16fa~P-D29-efo2418124181eucas1p28;
 Fri, 28 Aug 2026 13:48:39 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260828134837eusmtip1b44523cdf3362d057bfa273a1f379f7d~P-D1W3mg42856028560eusmtip15;
 Fri, 28 Aug 2026 13:48:37 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Fri, 28 Aug 2026 15:47:38 +0200
Subject: [PATCH v2 14/15] riscv: dts: starfive: jh7110: Update DT for
 display subsystem
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-jh7110-clean-send-v2-14-331680c8b9d1@samsung.com>
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
X-CMS-MailID: 20260828134839eucas1p2d19363d17d4dbf5a7ae5228444af16fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260828134839eucas1p2d19363d17d4dbf5a7ae5228444af16fa
X-EPHeader: CA
X-CMS-RootMailID: 20260828134839eucas1p2d19363d17d4dbf5a7ae5228444af16fa
References: <20260828-jh7110-clean-send-v2-0-331680c8b9d1@samsung.com>
 <CGME20260828134839eucas1p2d19363d17d4dbf5a7ae5228444af16fa@eucas1p2.samsung.com>
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

Activate the display subsystem by adding the dc8200, hdmi and voutcrg
nodes as direct soc children. Each references the PD_VOUT power domain
through power-domains, so genpd powers the domain on demand, and the
HDMI-PHY -> voutcrg -> HDMI-controller probe order is resolved by
deferred probe.

The monolithic hdmi node is modelled as a container with hdmi_phy
and hdmi_controller children. This lets the PHY (clock provider,
depending only on xin24m) and the controller (clock consumer) probe
independently, breaking the circular clock dependency with voutcrg.

voutcrg consumes the pixel clock from the &hdmi_phy node instead of the
old fixed-clock, and dc8200 gets its pixel clocks from voutcrg's MUXes
and is marked dma-noncoherent for framebuffer DMA. The old, incorrect
hdmitx0-pixel-clock fixed-clock node is removed.

Co-developed-by: Dominique Belhachemi <db@domibel.de>
Signed-off-by: Dominique Belhachemi <db@domibel.de>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 119 +++++++++++++++++++++++-
 arch/riscv/boot/dts/starfive/jh7110.dtsi        |  87 +++++++++++++++--
 2 files changed, 196 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index a7a1c09a2c9075711f3a214a49618911fdc7b421..7aadc35f4a6aa724c86a868ef65c5c829e666ee2 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -33,6 +33,25 @@ memory@40000000 {
 		bootph-pre-ram;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* vout applies for space from this CMA
+		 * Without this CMA reservation,
+		 * vout may not work properly.
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
@@ -73,12 +92,47 @@ codec {
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
@@ -99,8 +153,31 @@ &gmac1_rmii_refin {
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
+			hdmi_out_con: endpoint {
+				remote-endpoint = <&hdmi_con_in>;
+			};
+
+		};
+	};
 };
 
 &i2srx_bclk_ext {
@@ -351,6 +428,40 @@ &syscrg {
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
@@ -629,3 +740,7 @@ &U74_3 {
 &U74_4 {
 	cpu-supply = <&vdd_cpu>;
 };
+
+&voutcrg {
+	status = "okay";
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 9c3e4598747eb5541effe697044484715569a285..024e33b0e97cb13928d69d1d8090ed14d22bb022 100644
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
@@ -1199,22 +1200,92 @@ csi_phy: phy@19820000 {
 			#phy-cells = <0>;
 		};
 
+		dc8200: display@29400000 {
+			compatible = "verisilicon,dc";
+			reg = <0x0 0x29400000 0x0 0x2800>;
+			interrupts = <95>;
+			dma-noncoherent;
+
+			power-domains = <&pwrc JH7110_PD_VOUT>;
+
+			clocks = <&voutcrg JH7110_VOUTCLK_DC8200_CORE>,
+				<&voutcrg JH7110_VOUTCLK_DC8200_AXI>,
+				<&voutcrg JH7110_VOUTCLK_DC8200_AHB>,
+				<&voutcrg JH7110_VOUTCLK_DC8200_PIX0>,
+				<&voutcrg JH7110_VOUTCLK_DC8200_PIX1>;
+			clock-names = "core", "axi", "ahb", "pix0", "pix1";
+
+			resets = <&voutcrg JH7110_VOUTRST_DC8200_CORE>,
+				 <&voutcrg JH7110_VOUTRST_DC8200_AXI>,
+				 <&voutcrg JH7110_VOUTRST_DC8200_AHB>;
+			reset-names = "core", "axi", "ahb";
+		};
+
+		hdmi_subsystem: hdmi@29590000 {
+			compatible = "starfive,jh7110-hdmi-subsystem";
+			reg = <0x0 0x29590000 0x0 0x4000>;
+
+			/*
+			 * This MFD's PHY child is the first device in the vout
+			 * region to touch registers, so it owns the NoC display
+			 * bus clock + reset that gate access to the region.
+			 * PD_VOUT is powered on by genpd via power-domains.
+			 */
+			power-domains = <&pwrc JH7110_PD_VOUT>;
+			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_DISP_AXI>;
+			resets = <&syscrg JH7110_SYSRST_NOC_BUS_DISP_AXI>;
+
+			hdmi_phy: phy {
+				compatible = "starfive,jh7110-inno-hdmi-phy";
+
+				clocks = <&xin24m>;
+				clock-names = "refoclk";
+
+				/* Output clock: The variable pixel clock */
+				#clock-cells = <0>;
+				clock-output-names = "hdmi_pclk";
+
+				/* PHY provider for the controller */
+				#phy-cells = <0>;
+			};
+
+			hdmi_controller: controller {
+				compatible = "starfive,jh7110-inno-hdmi-controller";
+				interrupts = <99>;
+
+				clocks = <&voutcrg JH7110_VOUTCLK_HDMI_TX_SYS>,
+					 <&voutcrg JH7110_VOUTCLK_HDMI_TX_MCLK>,
+					 <&voutcrg JH7110_VOUTCLK_HDMI_TX_BCLK>,
+					 <&hdmi_phy>;
+				clock-names = "sys", "mclk", "bclk", "pclk";
+
+				resets = <&voutcrg JH7110_VOUTRST_HDMI_TX_HDMI>;
+				reset-names = "hdmi_tx";
+
+				phys = <&hdmi_phy>;
+				phy-names = "hdmi-phy";
+			};
+		};
+
 		voutcrg: clock-controller@295c0000 {
 			compatible = "starfive,jh7110-voutcrg";
 			reg = <0x0 0x295c0000 0x0 0x10000>;
+
+			power-domains = <&pwrc JH7110_PD_VOUT>;
+
 			clocks = <&syscrg JH7110_SYSCLK_VOUT_SRC>,
 				 <&syscrg JH7110_SYSCLK_VOUT_TOP_AHB>,
 				 <&syscrg JH7110_SYSCLK_VOUT_TOP_AXI>,
 				 <&syscrg JH7110_SYSCLK_VOUT_TOP_HDMITX0_MCLK>,
 				 <&syscrg JH7110_SYSCLK_I2STX0_BCLK>,
-				 <&hdmitx0_pixelclk>;
+				 <&hdmi_phy>;
 			clock-names = "vout_src", "vout_top_ahb",
 				      "vout_top_axi", "vout_top_hdmitx0_mclk",
 				      "i2stx0_bclk", "hdmitx0_pixelclk";
+
 			resets = <&syscrg JH7110_SYSRST_VOUT_TOP_SRC>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-			power-domains = <&pwrc JH7110_PD_VOUT>;
 		};
 
 		pcie0: pcie@940000000 {

-- 
2.34.1

