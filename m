Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA18F588C8
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5CF110E5B0;
	Mon, 20 Apr 2026 12:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Td/n/nE0";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF2410E5A3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:54:52 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A6E99312A;
 Mon, 20 Apr 2026 14:53:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776689594;
 bh=8J+VqbKIZnuNKJTfQMG3Tz1bHzMlB/oCigDNqinSXf8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Td/n/nE08rfm0hYZ38+ubC1sbIEphAOIWWncN4EpB1hw4VGnSYA1qmc7jYmZCCRuu
 jWmdbt6V29QIrJh9wFHawT9kynBIUaXh71/4mJKQy/+VbBt8pQiffOv2RpK7YRotkr
 uVK4/fTWZVSkrENDOhE1ygJovBfe5E97/HdDXl4E=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 20 Apr 2026 15:54:22 +0300
Subject: [PATCH 15/15] arm64: dts: ti: beagley-ai: Enable HDMI display and
 audio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-beagley-ai-display-v1-15-f628543dfd14@ideasonboard.com>
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
In-Reply-To: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Andrew Davis <afd@ti.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=7630;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=ef00AEEpZLBoZS13pee46fVX47tvacOEQxIpd0yH3/4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp5iIIpMXK+ys3lB6QqFrLhAroXUwaPU9mySplY
 8qXUHRF3umJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeYiCAAKCRD6PaqMvJYe
 9eMYD/4xWdOQUmY/A99L949Yd+Z93eoPbFuQihhQZcI7w8PKRrLRuWKx24XT0uQnocVejlteWlm
 vhQP4xSO2z6hNe/ubS8kuY0/Fk5vpK4sxVCJEsISAq+3cSRgIqJIOcWkxkwC/eg/e40e3kh58cw
 HhtT0y5oeExyLGYTSBUpRRJlA4RQmn6h3ms1oIG7divwDxhWmSdRyf6QnQrYs5MZsoKVn/mx9Ai
 3AFXhp/23OS4wQpv4m9cADwp4CM5Y7yTUQS5sSWNZUalnmRCdrns4WpieyjTXKofNA6EtxvIat3
 8oBt21ag+/5tegsclp61rYRZ32Mk36aLOrFf5M3CFBJl6t5IOdUWyFKqlr7CFUG2lVPjzxEBq3M
 kIl6HSUbtZ0iHd7s5WAd8hY37eW1Is6ojHw1jrsBvhU1m6WALQjvpV0fu+dqxfoc0G68T7mMgYx
 boqpvibQPToTGq0NMVA+Rnn4oe4HPMNzbIfDt4ssAFZ2CU3eE/HCfW730zZjaxUdMjksy/ALQ2/
 tVRYRi6d0WyjdgKRJtueh8oJfusN48Z7qZkqYhy0WFrFDqVivU45oTThAnwryvbwp9r4KUdwByZ
 H2NC5lmPI7l8WpdIW7rUfUlV0A4OwmVcgx89e/mgav4AQITo5zUPBxiTeCO/hGDw8+P2KGtl3yM
 Q2lP9PXK93rbRVw==
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
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts | 197 +++++++++++++++++++++++++
 1 file changed, 197 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
index 5255e04b9ac7..b7bcc90005d7 100644
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
@@ -185,6 +213,20 @@ J722S_IOPAD(0x0240, PIN_INPUT, 7) /* (B24) MMC1_SDCD.GPIO1_48 */
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
+	main_gpio0_ioexp_intr_pins_default: main-gpio0-ioexp-intr-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x0110, PIN_INPUT, 7) /* (G27) MMC2_DAT1.GPIO0_67 */
+		>;
+	};
+
 	mdio_pins_default: mdio-default-pins {
 		pinctrl-single,pins = <
 			J722S_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AC24) MDIO0_MDC */
@@ -227,6 +269,47 @@ vdd_3v3_sd_pins_default: vdd-3v3-sd-default-pins {
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
+			J722S_IOPAD(0x008c, PIN_INPUT, 2) /* (N23) GPMC0_WEn.MCASP1_AXR0 */
+		>;
+	};
 };
 
 &cpsw3g {
@@ -284,6 +367,13 @@ J722S_MCU_IOPAD(0x050, PIN_INPUT_PULLUP, 0)	/* (C6) WKUP_I2C1_SDA */
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
@@ -385,6 +475,63 @@ rtc: rtc@68 {
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
+			 * For now, we will service it with DSS1 VP1.
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
@@ -399,4 +546,54 @@ &sdhci1 {
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
+		/* DSS1-VP1: DPI/HDMI Output */
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

