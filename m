Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6BB606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=dj0dQGZ0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CCFC1121C4;
	Thu, 29 Oct 2026 10:20:09 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1135D112195
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:19:26 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C0204C4A;
 Thu, 29 Oct 2026 11:17:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793269031;
 bh=xoTWdeNEm+I4pj50SHZiPb0ElVYsJaI8KWjVRUcnqxw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=dj0dQGZ05WnUSJ9blbjQ8i+cMZ3P1ZHJsUv8yZNVh92P85eSgosI/yz6Pgazamgwe
 o8i9L8ubpkY1HZkub2VXZItIIB11ow88vbZ3IGSJyHYxyzRBMhlV9+1HAlta0/v2uN
 QdKfjSbAbx93qD2zpL/A0HRm/Hzp2jJOh5+WYMT4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 29 Oct 2026 12:19:00 +0200
Subject: [PATCH v4 14/14] arm64: dts: ti: beagley-ai: Enable HDMI display
 and audio
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-beagley-ai-display-v4-14-dc7f2b532478@ideasonboard.com>
References: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
In-Reply-To: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7374;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=g7T7xLDJz+T9EUK9a9YSCQo4F1o4IpRfssGuj9B1glE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq4x2aIQegpvRGYLFVBhbaM4JEh0lCR/ioMnCrK
 sBzQUqIZ+qJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCauMdmgAKCRD6PaqMvJYe
 9efeD/9vknA/5GxbZFaOwTSG36tHQckbGKKq4s4Lryrfw3aBzWmc/tuIes3jFzKFfxFOonOwoA0
 0l82d8jqPzqgjl95FjLVGC7Ll4TGpTkrKtQsAR834vNsV+H9678M4Jo3XmvHTB6ztODLdBaRPo0
 xQovd6fYy5PPKC2+qCxmAjidFQ4sG+2PJlupMmZcqR8ESFgaw9vC4WyPXFqSztQA/hCTmsIOgYW
 7zQlbo2+kWCeAjSEQ4AUmEDZY7jD/J2DSOohXdUmVvmX4dB7uMwF0hc09NjGHumNtm2nYAboM4A
 ML6OJTS8ZqeY/WUsAvweO6f4WaUrFguPexmuxeZ+UGDSUtsTEoLhd1pur1ai5gAgoKskm5m1Zrb
 BGzlgCG1EAIJT1MattFuhRuYUd4ItUAzoQGmvsTjH00XVLeoZv1ZSonbRIY+8Kwnbt2e2BcrFJj
 Q9puIsk/ngRN7ELlpt/I2WyoMsoQQJVK7GGqPJV9e9q1eQLdqk4IDU2/jB+DulE2hFswZlNxHyP
 tSIUtsOyPsOiXjOoHR1qBVAlu+Nl0yCy1FEvqyJRcuYD6bs8yaad7qz6D7QMdIRe404op7ek4fS
 HtuwE+QKsevYzpQkk/rPV+qIIm9PlXZxH1ECnNAREO+hb+Jc8Q/vWlYCMKGriOjnJBy14EwLw71
 PNqkxctpFLBuNKQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrew Davis <afd@ti.com>

Enable HDMI support for BeagleY-AI platform. The display controller used is
TIDSS and the HDMI bridge used is IT66122.

Based on DT by: Robert Nelson <robertcnelson@gmail.com>

Signed-off-by: Andrew Davis <afd@ti.com>
Signed-off-by: Swamil Jain <s-jain1@ti.com>
[tomi.valkeinen: cosmetic fixes]
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts | 180 +++++++++++++++++++++++++
 1 file changed, 180 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
index 8b4b3b80a29d..be3f5349345f 100644
--- a/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
+++ b/arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts
@@ -159,6 +159,34 @@ dsi_csi_mux: mux-controller {
 		/* state = SEL + 2*OE : 0 = DSI0, 1 = CSI1, 2,3 = off */
 		idle-state = <2>;
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
@@ -205,6 +233,13 @@ J722S_IOPAD(0x0240, PIN_INPUT, 7) /* (B24) MMC1_SDCD.GPIO1_48 */
 		bootph-all;
 	};
 
+	main_i2c1_pins_default: main-i2c1-default-pins {
+		pinctrl-single,pins = <
+			J722S_IOPAD(0x01e8, PIN_INPUT_PULLUP, 0) /* (C24) I2C1_SCL */
+			J722S_IOPAD(0x01ec, PIN_INPUT_PULLUP, 0) /* (A22) I2C1_SDA */
+		>;
+	};
+
 	mdio_pins_default: mdio-default-pins {
 		pinctrl-single,pins = <
 			J722S_IOPAD(0x0160, PIN_OUTPUT, 0) /* (AC24) MDIO0_MDC */
@@ -254,6 +289,47 @@ vdd_3v3_sd_pins_default: vdd-3v3-sd-default-pins {
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
@@ -334,6 +410,13 @@ J722S_MCU_IOPAD(0x050, PIN_INPUT_PULLUP, 0)	/* (C6) WKUP_I2C1_SDA */
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
@@ -435,6 +518,54 @@ rtc: rtc@68 {
 	};
 };
 
+&main_i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_i2c1_pins_default>;
+	clock-frequency = <400000>;
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
 &sdhci1 {
 	/* SD/MMC */
 	vmmc-supply = <&vdd_mmc1>;
@@ -467,4 +598,53 @@ &main_i2c2 {
 	status = "disabled";
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

