Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC1DCD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 08:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA5210FB15;
	Fri, 29 May 2026 08:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="YIuAVdzf";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E14CB10FB15
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 08:47:33 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B8DCC7B6A;
 Fri, 29 May 2026 10:47:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780044432;
 bh=gvLfMhv4HQU6DTIrpERtFSiOVrvkNCT0l7ewEFG2l50=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=YIuAVdzfW5Iyl1sDds7AfTwz1bC7BIYaOeRPSHku4nkNIxD+sfA7av6oRdWBK9xM4
 bI+o/3IPLkYhRXUH0pmO3riUe3mSPBnn0c9vCP5OegojBqSj1KtkHjpOKWNUaYuQqW
 WUIVNixCnbUzilEruzRQLJI8zcqQRsYqS1ghstpg=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 29 May 2026 11:45:45 +0300
Subject: [PATCH v3 15/15] arm64: dts: ti: beagley-ai: Enable HDMI display
 and audio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-beagley-ai-display-v3-15-7fefdc5d1adf@ideasonboard.com>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
In-Reply-To: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Andrew Davis <afd@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7536;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=Ge4aPjOaQi2GtYQmIurGaY0c8IXbvBUBn4UOL1Y1VfU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqGVKQbYdNh4QagCbQ5M7DAm9e2x+K1X9j0S5P1
 LkJQUOs/pOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCahlSkAAKCRD6PaqMvJYe
 9YalEACaVfwiSw250f8We9JZAjWApwbtwDkh6rnlfLU7irzhDH7NlD+sbuoOs0L6FqSVfAnaUIW
 LWYr9+NJ8p7mCOSndxOAvvciFL8QN36iA3ZXY2F8UwVpNFLIG42hOTTBFmFKb0vEFEpIrohdBiT
 W4VDSK4rQbB3t7EWHn5Hxu7pkx/cmmXfTI/1VCSiPthzhcA6XB5HoZyNZi54vy5qtwham/9l/UY
 fe0YAern0KhjG7kfryDI8qzfMqc+34pBzd8qT3/2JHODQpXyslu01zyXggEp5bvAF7DsOV2p/dt
 TYuJ5V3Ml4n0FXRnK9nUMvlt/+CKZ134BdFY3zlyn4Rx0uMm7dPuZAFJTt9uhtSLhZefMbLVZXB
 zmJXAf8ZtsfnS7V3ufTBgGFP1jz9lQZ+zABeo44foe+0oCk1rryLSQeZLDg2xFFcalx40ewAxOo
 kMBE1TRbYpi2/FaJtaMLHYagnhqRq0Hlt036simluGRVuJP4jlfvxIYkSITJEub+9IQ82YyTWQe
 hXfmXf7SJHPoemI7Zi6IpdALxUjy0i8og2BnEHZPoZVd3oNpe9yyruy0McrRrz17jCGMy7BFMSR
 MeMqrpDTkIw+zQDtWvsiQ5hV2n6wCAg0mnDFUf3Z1jEVt7cykTgYS9zVE/XJo3g9fuwd6Rd/4Sq
 kuqbDKrLXVJKj3A==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
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

From: Andrew Davis <afd@ti.com>

Enable HDMI support for BeagleY-AI platform. The display controller used is
TIDSS and the HDMI bridge used is IT66122.

Based on DT by: Robert Nelson <robertcnelson@gmail.com>

Signed-off-by: Andrew Davis <afd@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
[tomi.valkeinen: cosmetic fixes]
Tested-by: Robert Nelson <robertcnelson@gmail.com>
Tested-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts | 191 +++++++++++++++++++++++++
 1 file changed, 191 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
index 5255e04b9ac7..f97e3bddf28f 100644
--- a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
+++ b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
@@ -146,6 +146,34 @@ led-1 {
 			default-state = "on";
 		};
 	};
+
+	hdmi0: connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "d";
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&it66122_out>;
+			};
+		};
+	};
+
+	sound0: sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "it66122 HDMI";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&hdmi_dailink_master>;
+		simple-audio-card,frame-master = <&hdmi_dailink_master>;
+
+		hdmi_dailink_master: simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+			system-clock-direction-out;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&it66122>;
+		};
+	};
 };
 
 &main_pmx0 {
@@ -185,6 +213,14 @@ J722S_IOPAD(0x0240, PIN_INPUT, 7) /* (B24) MMC1_SDCD.GPIO1_48 */
 		bootph-all;
 	};
 
+	main_i2c1_pins_default: main-i2c1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x01e8, PIN_INPUT_PULLUP, 0) /* (C24) I2C1_SCL */
+			J722S_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (A22) I2C1_SDA */
+		>;
+		bootph-all;
+	};
+
 	mdio_pins_default: mdio-default-pins {
 		pinctrl-single,pins = <
 			J722S_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AC24) MDIO0_MDC */
@@ -227,6 +263,47 @@ vdd_3v3_sd_pins_default: vdd-3v3-sd-default-pins {
 			J722S_IOPAD(0x0254, PIN_OUTPUT, 7) /* (E25) USB0_DRVVBUS.GPIO1_50 */
 		>;
 	};
+
+	dss1_pins_default: dss1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0100, PIN_OUTPUT, 0) /* (AB23) VOUT0_VSYNC */
+			J722S_IOPAD(0x00f8, PIN_OUTPUT, 0) /* (AB24) VOUT0_HSYNC */
+			J722S_IOPAD(0x0104, PIN_OUTPUT, 0) /* (AC26) VOUT0_PCLK */
+			J722S_IOPAD(0x00fc, PIN_OUTPUT, 0) /* (AC27) VOUT0_DE */
+			J722S_IOPAD(0x00b8, PIN_OUTPUT, 0) /* (W27) VOUT0_DATA0 */
+			J722S_IOPAD(0x00bc, PIN_OUTPUT, 0) /* (W25) VOUT0_DATA1 */
+			J722S_IOPAD(0x00c0, PIN_OUTPUT, 0) /* (W24) VOUT0_DATA2 */
+			J722S_IOPAD(0x00c4, PIN_OUTPUT, 0) /* (W23) VOUT0_DATA3 */
+			J722S_IOPAD(0x00c8, PIN_OUTPUT, 0) /* (W22) VOUT0_DATA4 */
+			J722S_IOPAD(0x00cc, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA5 */
+			J722S_IOPAD(0x00d0, PIN_OUTPUT, 0) /* (Y26) VOUT0_DATA6 */
+			J722S_IOPAD(0x00d4, PIN_OUTPUT, 0) /* (Y27) VOUT0_DATA7 */
+			J722S_IOPAD(0x00d8, PIN_OUTPUT, 0) /* (AA24) VOUT0_DATA8 */
+			J722S_IOPAD(0x00dc, PIN_OUTPUT, 0) /* (AA27) VOUT0_DATA9 */
+			J722S_IOPAD(0x00e0, PIN_OUTPUT, 0) /* (AA25) VOUT0_DATA10 */
+			J722S_IOPAD(0x00e4, PIN_OUTPUT, 0) /* (AB25) VOUT0_DATA11 */
+			J722S_IOPAD(0x00e8, PIN_OUTPUT, 0) /* (AA23) VOUT0_DATA12 */
+			J722S_IOPAD(0x00ec, PIN_OUTPUT, 0) /* (AA22) VOUT0_DATA13 */
+			J722S_IOPAD(0x00f0, PIN_OUTPUT, 0) /* (AB26) VOUT0_DATA14 */
+			J722S_IOPAD(0x00f4, PIN_OUTPUT, 0) /* (AB27) VOUT0_DATA15 */
+			J722S_IOPAD(0x005c, PIN_OUTPUT, 1) /* (AC25) GPMC0_AD8.VOUT0_DATA16 */
+			J722S_IOPAD(0x0060, PIN_OUTPUT, 1) /* (U26) GPMC0_AD9.VOUT0_DATA17 */
+			J722S_IOPAD(0x0064, PIN_OUTPUT, 1) /* (V27) GPMC0_AD10.VOUT0_DATA18 */
+			J722S_IOPAD(0x0068, PIN_OUTPUT, 1) /* (V25) GPMC0_AD11.VOUT0_DATA19 */
+			J722S_IOPAD(0x006c, PIN_OUTPUT, 1) /* (V26) GPMC0_AD12.VOUT0_DATA20 */
+			J722S_IOPAD(0x0070, PIN_OUTPUT, 1) /* (V24) GPMC0_AD13.VOUT0_DATA21 */
+			J722S_IOPAD(0x0074, PIN_OUTPUT, 1) /* (V22) GPMC0_AD14.VOUT0_DATA22 */
+			J722S_IOPAD(0x0078, PIN_OUTPUT, 1) /* (V23) GPMC0_AD15.VOUT0_DATA23 */
+		>;
+	};
+
+	main_mcasp1_pins_default: main-mcasp1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0090, PIN_INPUT, 2) /* (P27) GPMC0_BE0n_CLE.MCASP1_ACLKX */
+			J722S_IOPAD(0x0098, PIN_INPUT, 2) /* (V21) GPMC0_WAIT0.MCASP1_AFSX */
+			J722S_IOPAD(0x008c, PIN_OUTPUT, 2) /* (N23) GPMC0_WEn.MCASP1_AXR0 */
+		>;
+	};
 };
 
 &cpsw3g {
@@ -284,6 +361,13 @@ J722S_MCU_IOPAD(0x050, PIN_INPUT_PULLUP, 0)	/* (C6) WKUP_I2C1_SDA */
 		>;
 		bootph-all;
 	};
+
+	hdmi_gpio_pins_default: hdmi-gpio-default-pins {
+		pinctrl-single,pins = <
+			J722S_MCU_IOPAD(0x0038, PIN_INPUT_PULLUP | PIN_DEBOUNCE_CONF6, 7) /* (D8) MCU_MCAN0_RX.MCU_GPIO0_14 HDMI_INTn */
+			J722S_MCU_IOPAD(0x0034, PIN_OUTPUT_PULLUP, 7) /* (B2) MCU_MCAN0_TX.MCU_GPIO0_13 HDMI_RSTn */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -385,6 +469,63 @@ rtc: rtc@68 {
 	};
 };
 
+&main_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <400000>;
+	bootph-all;
+
+	it66122: bridge-hdmi@4c {
+		compatible = "ite,it66122";
+		reg = <0x4c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_gpio_pins_default>;
+		vcn33-supply = <&vdd_3v3>;
+		vcn18-supply = <&buck2_reg>;
+		vrf12-supply = <&ldo2_reg>;
+		reset-gpios = <&mcu_gpio0 13 GPIO_ACTIVE_LOW>;
+		interrupt-parent = <&mcu_gpio0>;
+		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
+		#sound-dai-cells = <0>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/*
+			 * HDMI can be serviced with 3 potential VPs -
+			 * (DSS0 VP1 / DSS1 VP0 / DSS1 VP1).
+			 * For now, we will service it with DSS1 VP0.
+			 */
+			port@0 {
+				reg = <0>;
+
+				it66122_in: endpoint {
+					bus-width = <24>;
+					remote-endpoint = <&dss1_dpi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				it66122_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
+&main_gpio0 {
+	status = "okay";
+};
+
+&mcu_gpio0 {
+	status = "okay";
+};
+
 &sdhci1 {
 	/* SD/MMC */
 	vmmc-supply = <&vdd_mmc1>;
@@ -399,4 +540,54 @@ &sdhci1 {
 	status = "okay";
 };
 
+&dss1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dss1_pins_default>;
+
+	clocks = <&k3_clks 232 8>,
+		 <&k3_clks 232 0>,
+		 <&k3_clks 232 4>;
+
+	assigned-clocks = <&k3_clks 241 0>, /* DSS1-VP0 */
+			  <&k3_clks 240 0>, /* DSS1-VP1 */
+			  <&k3_clks 245 0>; /* DPI Output */
+
+	assigned-clock-parents = <&k3_clks 241 2>, /* PLL 17 HDMI */
+				 <&k3_clks 240 1>, /* PLL 18 DSI */
+				 <&k3_clks 245 2>; /* DSS1-DPI0 */
+
+	ports {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* DSS1-VP0: DPI/HDMI Output */
+		port@0 {
+			reg = <0>;
+
+			dss1_dpi0_out: endpoint {
+				remote-endpoint = <&it66122_in>;
+			};
+		};
+	};
+};
+
+&mcasp1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcasp1_pins_default>;
+	auxclk-fs-ratio = <2177>;
+	op-mode = <0>; /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+		1 0 0 0
+		0 0 0 0
+		0 0 0 0
+		0 0 0 0
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
+
 #include "k3-j722s-ti-ipc-firmware.dtsi"

-- 
2.43.0

