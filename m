Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A558ACDE000
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548FA10EDD3;
	Wed, 24 Jun 2026 07:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBbVkJgo";
	dkim-atps=neutral
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6B610E36C
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 19:58:37 +0000 (UTC)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-1363fe80fe8so570078c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782244717; x=1782849517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uq8bbh6aLPw7xItUXqYkRP3ERWtfg5d1F8ZxaWAUzYU=;
 b=UBbVkJgonRX1XPs5Xbvrz5ibk7C4OkE1/8QT1WmCLF/aneIPZoy6S3cHEAfw9cvhcT
 1CuN2vh5atFW2ACdqNIkfI4MtPwdz2cJsnTnJqHyC0yboJGB4K6TwE7J8vmu6mbbzaPp
 QpwofXyMLzCkKbsCmywz7BUuLYAINH9Q0zOOdsjEGMUkrBZfy5tvvDtok1kTFhQhCfL/
 g33gaS/Bdnlo6CmRZCAiNBMc1GEbWSI0QnfgO8chN4LXGcojz5hTs/O3M8zG5/plrdZ8
 KYA4qkNxayryZOWTiIbvSAsuRFi/vtdZn4TCYvzcyV+E0KfUlmiq2f5ohgr9a+L3risx
 a0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782244717; x=1782849517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uq8bbh6aLPw7xItUXqYkRP3ERWtfg5d1F8ZxaWAUzYU=;
 b=smpsVk2x5yjkAy8leI5tRw4lfc6AmvHq95KJIJRXGD2nxghemmF02lBqqiaGEbqMR3
 jMbr2d3HEo5lYPnD35lqs6gjS6l6Oj0gzJYnVCjYRdt+41q9wgjrav1oDlVBRSALUj+D
 11CFhcHnjVyXKeT31Rp2+aiAlChFabqeoR3L9SPxXyaKbbn1go3nVvTtYdybJc/i+19B
 z1ET6e5DQFJqhDtjCERD+QVcEpvxWZUr4thPMGT5M7qmdwVgW09q1Lu508UmadsbQfMS
 x8PJjGMUaFbhQNxqKfTy3/WkEpho1v+14n8WDSJUIxwa95J3pnbATPDGaJmEt5ho9F40
 7FPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jD4uNpSnV/VqfmVcW3YnRoj72r9RQVbjANUT1hqtfKXSg+AteqJvc6ktWWIjzRj7yriz6poew5ZQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4AgUhpOLijnQLBp0bbi53Bh9j3ZFwPYON35jVgesdjmtH43wR
 VGWFpK1hpcRUz/9f6TKH76RM7O5lcRSEEAsrCmMV3jaS9Q+ndVTanGqt
X-Gm-Gg: AfdE7cngAKN12ywS3TBitBuV1oET1OEa9A1UabqXmu1GCHVHXKzH2/LfGmh4FbW4D6b
 k5UCo7yAHR6UbQyPBiC2/SnUrXyrmbNeQX6W019IYZQvZKx3bNxS/gE77FasXUActCluaT9FhgZ
 vYT+sS2BNuCzNNIfN9rTHnhKRwCttlit6BdV2kk0ja4aPApryhUtWj5rEQOaSEu3vKz8bGtmZS+
 W6ebA7miPXQHEuXCE+yY2OdnXC9x5HJH3sP5nOKZs+lgvZHBNTzakAmVlhwRvWP6Cw1w1sqRz/+
 tuE/ox3PUO3hwyyt7kbsujp0lAFVpKFMahSbDA/RSfD4YaCkmtBgSy2+XWQbaXSu7gMpPlLxpAo
 5RcFNiZy9cZwZsFZIRJ2alingi6jcQaVcVJyxxWhdrZMXbg7IGiGvMtvObeOO1kB0Ie3F7y8GRX
 RuyEYq6NsErb0kCOnLP2CXHe13F41ZnXzeDiE7ViSeIpTWUrKcIfcanaV8qOmvzMXh6a1jXaqGL
 VeGiD8rQ4lUEJ49cEYlkeyFssZm7CQiWp/yBFYpRA0=
X-Received: by 2002:a05:7022:203:b0:132:5d31:dcb4 with SMTP id
 a92af1059eb24-139d0c780a0mr163196c88.23.1782244716536; 
 Tue, 23 Jun 2026 12:58:36 -0700 (PDT)
Received: from leonardoc-nb (201-68-197-145.dsl.telesp.net.br.
 [201.68.197.145]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add85c40sm15730896c88.15.2026.06.23.12.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 12:58:36 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
To: laurent.pinchart@ideasonboard.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nm@ti.com, vigneshr@ti.com, kristo@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, thierry.reding@gmail.com,
 sam@ravnborg.org
Cc: leonardo.costa@toradex.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] arm64: dts: ti: k3-am62-verdin: Add Toradex Capacitive
 Touch Display 10.1" LVDS V2
Date: Tue, 23 Jun 2026 16:57:39 -0300
Message-ID: <20260623195741.495734-4-leoreis.costa@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623195741.495734-1-leoreis.costa@gmail.com>
References: <20260623195741.495734-1-leoreis.costa@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

From: Leonardo Costa <leonardo.costa@toradex.com>

Add a device tree overlay for the Toradex Capacitive Touch Display 10.1"
LVDS V2 connected via Verdin AM62 OLDI on carrier boards exposing LVDS
interface (e.g., Mallow). The panel is an Opto Logic SCX1001511GGC49 10.1"
WXGA TFT LCD and the touch input is provided by an ILITEK ILI251x
capacitive touch controller.

Link: https://developer.toradex.com/hardware/accessories/displays/capacitive-touch-display-101inch-lvds
Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   5 +
 ...verdin-panel-cap-touch-10inch-lvds-v2.dtso | 129 ++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 371f9a043fe52..61ae9039e561d 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -47,6 +47,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-ov5640-24mhz.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-10inch-dsi.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-10inch-lvds.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-7inch-dsi.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-uart4-mcu.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-wifi-dahlia-dsi-to-hdmi.dtb
@@ -249,6 +250,9 @@ k3-am625-verdin-wifi-dev-uart4-mcu-dtbs := k3-am625-verdin-wifi-dev.dtb \
 k3-am625-verdin-wifi-mallow-panel-cap-touch-10inch-lvds-dtbs := \
 	k3-am625-verdin-wifi-mallow.dtb \
 	k3-am625-verdin-panel-cap-touch-10inch-lvds.dtbo
+k3-am625-verdin-wifi-mallow-panel-cap-touch-10inch-lvds-v2-dtbs := \
+	k3-am625-verdin-wifi-mallow.dtb \
+	k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtbo
 k3-am62-lp-sk-hdmi-audio-dtbs := k3-am62-lp-sk.dtb k3-am62x-sk-hdmi-audio.dtbo
 k3-am62-lp-sk-nand-dtbs := k3-am62-lp-sk.dtb k3-am62-lp-sk-nand.dtbo
 k3-am62a7-phyboard-lyra-disable-eth-phy-dtbs := k3-am62a7-phyboard-lyra-rdk.dtb \
@@ -359,6 +363,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-verdin-wifi-dev-panel-cap-touch-7inch-dsi.dtb \
 	k3-am625-verdin-wifi-dev-uart4-mcu.dtb \
 	k3-am625-verdin-wifi-mallow-panel-cap-touch-10inch-lvds.dtb \
+	k3-am625-verdin-wifi-mallow-panel-cap-touch-10inch-lvds-v2.dtb \
 	k3-am62-lp-sk-hdmi-audio.dtb \
 	k3-am62-lp-sk-nand.dtb \
 	k3-am62a7-phyboard-lyra-disable-eth-phy.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtso
new file mode 100644
index 0000000000000..3ea8ccb8bff99
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-panel-cap-touch-10inch-lvds-v2.dtso
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Toradex Capacitive Touch Display 10.1" V2 connected via Verdin AM62 OLDI
+ * on carrier boards with a Toradex standard LVDS display connector
+ *
+ * https://developer.toradex.com/hardware/accessories/displays/capacitive-touch-display-101inch-lvds
+ * https://www.toradex.com/accessories/capacitive-touch-display-10.1-inch-lvds
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pwm/pwm.h>
+#include "k3-pinctrl.h"
+
+&{/} {
+	backlight_pwm2: backlight-pwm2 {
+		compatible = "pwm-backlight";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2s_2_d_out_gpio>;
+		brightness-levels = <0 45 63 88 119 158 203 255>;
+		default-brightness-level = <4>;
+		/* Verdin I2S_2_D_OUT as GPIO (SODIMM 46) */
+		enable-gpios = <&main_gpio0 34 GPIO_ACTIVE_HIGH>;
+		/* Verdin PWM_2 (SODIMM 16) */
+		pwms = <&epwm0 1 6666667 0>;
+	};
+
+	panel-lvds-native {
+		compatible = "optologic,scx1001511ggc49", "panel-lvds";
+		backlight = <&backlight_pwm2>;
+		data-mapping = "vesa-24";
+		height-mm = <136>;
+		width-mm = <217>;
+
+		panel-timing {
+			clock-frequency = <64500000>;
+			hactive = <1280>;
+			hback-porch = <20>;
+			hfront-porch = <20>;
+			hsync-len = <2>;
+			vactive = <800>;
+			vback-porch = <5>;
+			vfront-porch = <5>;
+			vsync-len = <3>;
+			de-active = <1>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			pixelclk-active = <0>;
+		};
+
+		port {
+			panel_lvds_native_in: endpoint {
+				remote-endpoint = <&oldi0_out>;
+			};
+		};
+	};
+};
+
+&dss {
+	status = "okay";
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* DSS VP1: internal DPI output to OLDIx */
+	port@0 {
+		reg = <0>;
+
+		dss0_out: endpoint {
+			remote-endpoint = <&oldi0_in>;
+		};
+	};
+};
+
+/* Verdin I2C_2_DSI */
+&main_i2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	touchscreen@41 {
+		compatible = "ilitek,ili251x";
+		reg = <0x41>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_i2s_2_d_in_gpio>,
+			    <&pinctrl_i2s_2_sync_gpio>;
+		/* Verdin I2S_2_SYNC as GPIO (SODIMM 44) */
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <37 IRQ_TYPE_EDGE_RISING>;
+		/* Verdin I2S_2_D_IN as GPIO(SODIMM 48) */
+		reset-gpios = <&main_gpio0 33 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&main_pmx0 {
+	pinctrl_i2s_2_d_in_gpio: main-gpio0-33-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0088, PIN_INPUT, 7) /* (L24) GPMC0_OEn_REn.GPIO0_33 */ /* SODIMM 48 */
+		>;
+	};
+
+	pinctrl_i2s_2_sync_gpio: main-gpio0-37-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0098, PIN_INPUT, 7) /* (U23) GPMC0_WAIT0.GPIO0_37 */ /* SODIMM 44 */
+		>;
+	};
+};
+
+&oldi0 {
+	status = "okay";
+};
+
+&oldi0_port0 {
+	oldi0_in: endpoint {
+		remote-endpoint = <&dss0_out>;
+	};
+};
+
+&oldi0_port1 {
+	oldi0_out: endpoint {
+		remote-endpoint = <&panel_lvds_native_in>;
+	};
+};
