Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D76606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=GSyzrYJ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFF9112018;
	Thu, 29 Oct 2026 07:55:02 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C97FB112009
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:54:25 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261029075424euoutp01e0e469c5c76436885423a0db8879ed1d~i8OQ7SXHT1385013850euoutp01H;
 Thu, 29 Oct 2026 07:54:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261029075424euoutp01e0e469c5c76436885423a0db8879ed1d~i8OQ7SXHT1385013850euoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793260464;
 bh=gYK/dE1PiupUwRUH2utBWTLymGN9VslKXGUiPm6oFks=;
 h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
 b=GSyzrYJ6ZyetPE+ItJyTnFOIQv+Pf3pLDwwIzVB+xfLfcMnlhI2vCAkBK5+n4khp2
 ZVp1ZV/D6Z8KnfppgnL6OwuRdPY+mxv09dsaSK24ypQvdiHtr4HUSTk1MfgKgandML
 o241S7ykJmMV/bsKeRJX81zyyj4i8e0A0XP1SVRE=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20261029075424eucas1p28bafc6e97bae9a01d4af728bbe7d690e~i8OQjt1sO2714827148eucas1p2n;
 Thu, 29 Oct 2026 07:54:24 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
 [106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261029075422eusmtip149e8c871cf95effc7e9d7f7570722b1b~i8OOk0kQ91314413144eusmtip1I;
 Thu, 29 Oct 2026 07:54:22 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Thu, 29 Oct 2026 08:53:51 +0100
Subject: [PATCH v6 17/18] riscv: dts: starfive: jh7110: Update DT for
 display subsystem
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-jh7110-clean-send-v6-17-759594e43acf@samsung.com>
In-Reply-To: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,  Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Andrzej Hajda
 <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>,  Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,  Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,  Philipp Zabel
 <p.zabel@pengutronix.de>,  Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
 <hal.feng@starfivetech.com>, Heiko Stuebner <heiko@sntech.de>,  Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,  Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,  Dominique
 Belhachemi <db@domibel.de>, Andy Yan <andyshrk@163.com>,  David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Yakir Yang
 <kuankuan.y@gmail.com>,  Dmitry Baryshkov
 <dmitry.baryshkov@oss.qualcomm.com>,  Michal Wilczynski
 <m.wilczynski@samsung.com>,  Conor Dooley <conor@kernel.org>, William Qiu
 <william.qiu@starfivetech.com>,  Xingyu Wu <xingyu.wu@starfivetech.com>,
 Sandy Huang <hjc@rock-chips.com>,  Manivannan Sadhasivam <mani@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org,  Marek
 Szyprowski <m.szyprowski@samsung.com>,  Maud Spierings
 <maud_spierings@murena.io>,  Graham Markall <hello@big-grey.co.uk>,  Icenowy
 Zheng <zhengxingda@iscas.ac.cn>,  Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Joshua Peisach <jpeisach@ubuntu.com>,  =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Byron Stanoszek <gandalf@winds.org>,
 OOHehir <oo.hehir@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=9910;
 i=m.wilczynski@samsung.com; h=from:subject:message-id;
 bh=SQKV4RpzYQsKCKY6gdzg0+t19yUI74LIt468SfCBcdY=;
 b=owGbwMvMwCGWumv6zndzRCIZT6slMWQ9+t3jwqpTp3nwvcxckWlhXsXLWl63f8nluBdqIrF7g
 0etW8qMjlIWBjEOBlkxRZazG6ONJP8xPC0//vgXzBxWJpAhDFycAjCRxg8M/5NsAt9t3bom91gO
 v7awj1O73Q6tg8Zv3GYtYbQw6P7pnsvIMENB5atK1PkTfbxvJi/9sa8uIkvOX0DldJJmwqEjhbs
 WMwAA
X-Developer-Key: i=m.wilczynski@samsung.com; a=openpgp;
 fpr=CDB15B3219FE00E577C7E3FA65BA97B9EE9C1459
X-CMS-MailID: 20261029075424eucas1p28bafc6e97bae9a01d4af728bbe7d690e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261029075424eucas1p28bafc6e97bae9a01d4af728bbe7d690e
X-EPHeader: CA
X-CMS-RootMailID: 20261029075424eucas1p28bafc6e97bae9a01d4af728bbe7d690e
References: <20261029-jh7110-clean-send-v6-0-759594e43acf@samsung.com>
 <CGME20261029075424eucas1p28bafc6e97bae9a01d4af728bbe7d690e@eucas1p2.samsung.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Activate the display subsystem by describing the video output subsystem,
which the documentation calls dom_vout_top, as a bus node covering the
whole 0x29400000 region, with dc8200, the HDMI block, the video output
system controller and voutcrg as its children.

The subsystem node owns the resources its children share: the NoC display
bus clock and reset that gate access to every register in the region, and
the PD_VOUT power domain. Modelling it this way keeps a shared gate owned
by the block that shares it, and lets dc8200 inherit dma-noncoherent for
framebuffer DMA from the bus it sits on.

The monolithic hdmi node is in turn modelled as a container with hdmi_phy
and hdmi_controller children, which share its register window: the PHY
takes only xin24m and provides the pixel clock and the phy, while the
controller takes its clocks from voutcrg.

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
Tested-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Tested-by: Byron Stanoszek <gandalf@winds.org>
Tested-by: OOHehir <oo.hehir@gmail.com>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 121 +++++++++++++++++++++++-
 arch/riscv/boot/dts/starfive/jh7110.dtsi        | 105 ++++++++++++++++----
 2 files changed, 203 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index a7a1c09a2c9075711f3a214a49618911fdc7b421..a4c3daf712a63b177f744e8c613416d22e0c9dbd 100644
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
+			pinmux = <GPIOMUX(15, GPOUT_LOW,
+					      GPOEN_DISABLE,
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
index 9c3e4598747eb5541effe697044484715569a285..bc2470963520eef30d7524370fcb013f0631f509 100644
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
 
+	xin24m: xin24m-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+		clock-output-names = "xin24m";
+	};
+
 	soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&plic>;
@@ -1199,22 +1200,84 @@ csi_phy: phy@19820000 {
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
+				assigned-clocks = <&voutcrg JH7110_VOUTCLK_DC8200_PIX0>,
+						  <&voutcrg JH7110_VOUTCLK_DC8200_PIX1>;
+				assigned-clock-parents = <&hdmi_phy>, <&hdmi_phy>;
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

