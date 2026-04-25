Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD5CFF8850
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:47:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B742510E13F;
	Sun, 26 Apr 2026 06:46:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="Z0ly1OLe";
	dkim-atps=neutral
Received: from mail-dy1-f225.google.com (mail-dy1-f225.google.com
 [74.125.82.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F115810E0A0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 03:10:27 +0000 (UTC)
Received: by mail-dy1-f225.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so13532239eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 20:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1777086627; x=1777691427; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oR4jWMu75WRXwBMB4jMl/9EAS9gvi4/U+KUeptL7o1A=;
 b=Z0ly1OLeZCCV//cBv4YuqjgYU9I/mtC3TGj1Uehz+W8EWKjWuVrWHfKBuUfdxD3OPb
 13s71yG3tK2taLgXwms4tDqFd2ZsiSoPGEG26Zzp8iQdCDwsbPATIw5mr4YWbfqNBrhv
 WsXgd3WdJPDUwDfIPycA256bh9c4xIX7sfCJiCcDp4waMb3NShvpvLDP5Z5JKH0ySUt3
 WRYPV/peaotOS1pez6CikrisB2sTonyD8mtjsUBav75Bte9cSzabtkyWCt2hfPY9jBvT
 Ayp5tq8bXIljhHPvzESU8tYaMwoClSJ6C2E7jHMmChN8llWDCYDFd5kRPcfv3/gqguvi
 EtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777086627; x=1777691427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oR4jWMu75WRXwBMB4jMl/9EAS9gvi4/U+KUeptL7o1A=;
 b=CHsa3ma8QcH4g53sL73T9MI/fjBL6Su3Cn2D/Th/plP9F+WpncGte9bUkE0yl7L02e
 p6omyC9n6sEiZgEOeKpUmtDItsx896xVlTxzPNNTYz0EYvi34fjlG0mS7EKHgnKYZySJ
 5KmJjC6IeaqjuewcMvz2Tq2SYM+4WAx8NUp4o6WGQWNaVGckvV2pP34+z9R37xXgMS/L
 +n1G28P55V6AHvBGRElt7Z1QlqvVsb+cY1y6cklFTO9zktRHCLib2wObTsEDZnKui++w
 IlKITw6IMJPJ3D9n9VfXQb15aJPsq86HJq/ClSBmAO1HoHOeJhCsdMRvkBokZwNHFyrp
 OHUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Gyrxu9O1IN7KwJFuAH4Ciz+VdslD8Zc3p/Esjvn1n5pWAXe/NYU0bipFAnb2ApY06fGv8kEXaptE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywa2z0o31vSL71zCg5a6IEgiGt/lbZngf6qn+7qgX6MBatGIv73
 wEdLEHH5OrZ9mwqDwp6JatNzPDucrGPjJ+hIpiOmXdPKQiSnLTZ8yLHaTrzv0pr5n1lW9d21Nx1
 tb86zxD2ncJviZRSz3fjDuJ5fMKBZMVGL7gqK
X-Gm-Gg: AeBDieuqnNcwV3wpNt6MX9kDmWARDnKuA3G0uM3oKZoTOwmueEr4jc9LdWI0GoTNSZ9
 zspbsZVj/HhaehsWZ5c0O3rWAwxZ3uv6jr4L1VxLGHAEugOA+MLETt+Enq24XEX4VxLAwe2HUmc
 8RblrFaEv5jZbuRVewvYabggOq93rjVg6BkcHgbsJR3urdOzZtjS6jd7Wb7ovPI5to6n+G24tLs
 a8EyD5tUrBR77P9TJCLslFPe1JPMoMskci0RJfJ8sDcbvJai3PhxMk+y8muYzouJuJc4KF5Hq+N
 zeOhdRHxqBZVsIFBVqqledudRhPTcZzxqB1Jsp5Cpj3g9MLlrV9rFwaXrKpV4CKkmIPRXUiDeTR
 NVKeWF1LRdYlOL4mkVEAD1zBJlpFzPdaGs1SvQNvclPJUGLp5g3V+Lpc=
X-Received: by 2002:a05:7300:230c:b0:2d2:c60d:4fe5 with SMTP id
 5a478bee46e88-2e464ea4e10mr17155372eec.6.1777086627253; 
 Fri, 24 Apr 2026 20:10:27 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-2e53a3ae691sm1728646eec.11.2026.04.24.20.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 20:10:27 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>
Subject: [PATCH v8 6/6] arm64: dts: rockchip: Add Orange Pi 5 Pro board support
Date: Fri, 24 Apr 2026 22:10:11 -0500
Message-ID: <20260425031011.2529364-7-dennis@ausil.us>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260425031011.2529364-1-dennis@ausil.us>
References: <20260425031011.2529364-1-dennis@ausil.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:46:56 +0000
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

Add device tree for the Xunlong Orange Pi 5 Pro (RK3588S).

- eMMC module, you can optionally solder a SPI NOR in place and turn
 off the eMMC
- PCIe-attached NIC (pcie2x1l2)
- PCIe NVMe slot (pcie2x1l1)
- AP6256 WiFi (BCM43456) via SDIO with mmc-pwrseq
- BCM4345C5 Bluetooth
- es8388 audio
- USB 2.0 and USB 3.0
- Two HDMI ports, the second is connected to the SoC's DP controller
  driven through a Lontium LT8711UXD bridge.

Vendors schematics are available at:
https://drive.google.com/file/d/1qs1DratHuh7C6J6MEtQIwUsiSrg8qgTi/view

Signed-off-by: Dennis Gilmore <dennis@ausil.us>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3588s-orangepi-5-pro.dts   | 440 ++++++++++++++++++
 2 files changed, 441 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 4d384f153c13..c99dca2ae9e7 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -214,6 +214,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-odroid-m2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5b.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-5-pro.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-orangepi-cm5-base.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-radxa-cm5-io.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-roc-pc.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts
new file mode 100644
index 000000000000..67363709c4ca
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts
@@ -0,0 +1,440 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "rk3588s-orangepi-5.dtsi"
+
+/ {
+	model = "Xunlong Orange Pi 5 Pro";
+	compatible = "xunlong,orangepi-5-pro", "rockchip,rk3588s";
+
+	aliases {
+		mmc0 = &sdhci;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio;
+	};
+
+	hdmi1-con {
+		compatible = "hdmi-connector";
+		label = "HDMI1 OUT";
+		type = "a";
+
+		port {
+			hdmi1_con_in: endpoint {
+				remote-endpoint = <&lt8711uxd_out>;
+			};
+		};
+	};
+
+	hdmi-bridge {
+		compatible = "lontium,lt8711uxd";
+		vdd-supply = <&vcc3v3_dp>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				lt8711uxd_in: endpoint {
+					remote-endpoint = <&dp0_out_con>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				lt8711uxd_out: endpoint {
+					remote-endpoint = <&hdmi1_con_in>;
+				};
+			};
+		};
+	};
+
+	analog-sound {
+		compatible = "simple-audio-card";
+		pinctrl-names = "default";
+		pinctrl-0 = <&hp_detect>;
+		simple-audio-card,format = "i2s";
+		simple-audio-card,hp-det-gpios = <&gpio1 RK_PD5 GPIO_ACTIVE_HIGH>;
+		simple-audio-card,mclk-fs = <256>;
+		simple-audio-card,name = "rockchip,es8388";
+		simple-audio-card,routing =
+			"Headphones", "LOUT1",
+			"Headphones", "ROUT1",
+			"LINPUT1", "Microphone Jack",
+			"RINPUT1", "Microphone Jack",
+			"LINPUT2", "Onboard Microphone",
+			"RINPUT2", "Onboard Microphone";
+		simple-audio-card,widgets =
+			"Microphone", "Microphone Jack",
+			"Microphone", "Onboard Microphone",
+			"Headphone", "Headphones";
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s2_2ch>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&es8388>;
+			system-clock-frequency = <12288000>;
+		};
+	};
+
+	pwm-leds {
+		compatible = "pwm-leds";
+
+		led-0 {
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_STATUS;
+			linux,default-trigger = "heartbeat";
+			max-brightness = <255>;
+			pwms = <&pwm15 0 1000000 0>;
+		};
+
+		led-1 {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_ACTIVITY;
+			linux,default-trigger = "heartbeat";
+			max-brightness = <255>;
+			pwms = <&pwm3 0 1000000 0>;
+		};
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		#cooling-cells = <2>;
+		cooling-levels = <0 50 100 150 200 255>;
+		fan-supply = <&vcc5v0_sys>;
+		pwms = <&pwm2 0 20000000 0>;
+	};
+
+	vcc3v3_dp: regulator-vcc3v3-dp {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio3 RK_PC2 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&dp_bridge_en>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc3v3_dp";
+		regulator-always-on;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
+	vcc3v3_eth: regulator-vcc3v3-eth {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ethernet_en>;
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "vcc3v3_eth";
+		startup-delay-us = <50000>;
+		vin-supply = <&vcc_3v3_s3>;
+	};
+
+	vcc5v0_otg: regulator-vcc5v0-otg {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpios = <&gpio0 RK_PC4 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_otg_en>;
+		regulator-max-microvolt = <5000000>;
+		regulator-min-microvolt = <5000000>;
+		regulator-name = "vcc5v0_otg";
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&hym8563>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		post-power-on-delay-ms = <200>;
+		reset-gpios = <&gpio0 RK_PD0 GPIO_ACTIVE_LOW>;
+	};
+
+	typea_con: usb-a-connector {
+		compatible = "usb-a-connector";
+		data-role = "host";
+		label = "USB3 Type-A";
+		power-role = "source";
+		vbus-supply = <&vcc5v0_otg>;
+	};
+};
+
+&dp0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp0m0_pins>;
+	status = "okay";
+};
+
+&dp0_in {
+	dp0_in_vp1: endpoint {
+		remote-endpoint = <&vp1_out_dp0>;
+	};
+};
+
+&dp0_out {
+	dp0_out_con: endpoint {
+		remote-endpoint = <&lt8711uxd_in>;
+	};
+};
+
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1m4_xfer>;
+	status = "okay";
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3m0_xfer>;
+	status = "okay";
+
+	es8388: audio-codec@11 {
+		compatible = "everest,es8388", "everest,es8328";
+		reg = <0x11>;
+		#sound-dai-cells = <0>;
+		AVDD-supply = <&vcca_3v3_s0>;
+		DVDD-supply = <&vcca_1v8_s0>;
+		HPVDD-supply = <&vcca_3v3_s0>;
+		PVDD-supply = <&vcca_1v8_s0>;
+		assigned-clock-rates = <12288000>;
+		assigned-clocks = <&cru I2S2_2CH_MCLKOUT>;
+		clocks = <&cru I2S2_2CH_MCLKOUT>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s2m1_mclk>;
+	};
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4m3_xfer>;
+	status = "okay";
+};
+
+&i2s2_2ch {
+	pinctrl-0 = <&i2s2m1_lrck &i2s2m1_sclk
+		     &i2s2m1_sdi &i2s2m1_sdo>;
+	status = "okay";
+};
+
+&package_thermal {
+	polling-delay = <1000>;
+
+	cooling-maps {
+		map0 {
+			trip = <&package_fan0>;
+			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
+		};
+
+		map1 {
+			trip = <&package_fan1>;
+			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
+		};
+	};
+
+	trips {
+		package_fan0: package-fan0 {
+			hysteresis = <2000>;
+			temperature = <55000>;
+			type = "active";
+		};
+
+		package_fan1: package-fan1 {
+			hysteresis = <2000>;
+			temperature = <65000>;
+			type = "active";
+		};
+	};
+};
+
+/* NVMe */
+&pcie2x1l1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie30x1m1_1_perstn>, <&pcie30x1m1_1_clkreqn>,
+		    <&pcie30x1m1_1_waken>;
+	reset-gpios = <&gpio4 RK_PA2 GPIO_ACTIVE_HIGH>;
+	supports-clkreq;
+	vpcie3v3-supply = <&vcc_3v3_s3>;
+	status = "okay";
+};
+
+/* NIC */
+&pcie2x1l2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie20x1m0_perstn>, <&pcie20x1m0_clkreqn>,
+		    <&pcie20x1m0_waken>;
+	reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
+	vpcie3v3-supply = <&vcc3v3_eth>;
+	status = "okay";
+};
+
+&pinctrl {
+	bluetooth {
+		bt_wake_gpio: bt-wake-pin {
+			rockchip,pins = <0 RK_PC6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		bt_wake_host_irq: bt-wake-host-irq {
+			rockchip,pins = <0 RK_PC5 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	dp {
+		dp_bridge_en: dp-bridge-en {
+			rockchip,pins = <3 RK_PC2 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	ethernet {
+		ethernet_en: ethernet-en {
+			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	usb {
+		vcc5v0_otg_en: vcc5v0-otg-en {
+			rockchip,pins = <0 RK_PC4 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
+	wlan {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <0 RK_PD0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		wifi_host_wake_irq: wifi-host-wake-irq {
+			rockchip,pins = <0 RK_PA0 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+};
+
+&pwm15 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm15m2_pins>;
+	status = "okay";
+};
+
+&pwm2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm2m1_pins>;
+	status = "okay";
+};
+
+&pwm3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm3m2_pins>;
+	status = "okay";
+};
+
+&rk806_single {
+	regulators {
+		vcca_1v8_s0: pldo-reg1 {
+			regulator-name = "vcca_1v8_s0";
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+				regulator-suspend-microvolt = <1800000>;
+			};
+		};
+
+		vcc_1v8_s0: pldo-reg2 {
+			regulator-name = "vcc_1v8_s0";
+			regulator-always-on;
+			regulator-boot-on;
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+
+			regulator-state-mem {
+				regulator-off-in-suspend;
+			};
+		};
+	};
+};
+
+&sdhci {
+	status = "okay";
+};
+
+&sdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	max-frequency = <150000000>;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	no-mmc;
+	no-sd;
+	non-removable;
+	sd-uhs-sdr104;
+	status = "okay";
+
+	ap6256: wifi@1 {
+		compatible = "brcm,bcm43456-fmac", "brcm,bcm4329-fmac";
+		reg = <1>;
+		interrupt-names = "host-wake";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA0 IRQ_TYPE_LEVEL_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_host_wake_irq>;
+	};
+};
+
+&uart9 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart9m2_xfer &uart9m2_ctsn &uart9m2_rtsn>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4345c5";
+		clocks = <&hym8563>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&gpio0 RK_PC6 GPIO_ACTIVE_HIGH>;
+		interrupt-names = "host-wakeup";
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_HIGH>;
+		max-speed = <1500000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&bt_wake_host_irq &bt_wake_gpio>;
+		shutdown-gpios = <&gpio0 RK_PD5 GPIO_ACTIVE_HIGH>;
+		vbat-supply = <&vcc_3v3_s3>;
+		vddio-supply = <&vcc_1v8_s3>;
+	};
+};
+
+&u2phy0_otg {
+	phy-supply = <&vcc5v0_otg>;
+};
+
+&usb_host0_xhci {
+	dr_mode = "host";
+};
+
+&usbdp_phy0 {
+	/*
+	 * USBDP PHY0 is wired to a USB3 Type-A host connector via lanes 2/3.
+	 * Additionally lanes 0/1 and the aux channel are wired to the
+	 * Lontium LT8711UXD DP-to-HDMI bridge feeding the HDMI1 connector.
+	 */
+	rockchip,dp-lane-mux = <0 1>;
+};
+
+&vp1 {
+	vp1_out_dp0: endpoint@a {
+		reg = <ROCKCHIP_VOP2_EP_DP0>;
+		remote-endpoint = <&dp0_in_vp1>;
+	};
+};
-- 
2.53.0

