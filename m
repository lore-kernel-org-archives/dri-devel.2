Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D344FCD5BB6
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 16:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA51E10F6BB;
	Fri, 22 May 2026 16:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L4mJCz6U";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84AB310F61A
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:11:59 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so85126815e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779466318; x=1780071118; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GnOH4oi9MCTSp//zOnHHBdVKY0oDkBkYij1oiK/rQm8=;
 b=L4mJCz6UxRqjwMvzsGUhCDgV0mM+hZYBBXX9BDcgdCl/ssTqclXbzAoPWS0rhcmwIF
 Lp/FWSufWD1uZVPs00lDbzFM15Q7UkZDp52Mdhp0NGlO5Zm5eJLwfFuhCU8jJyDyPN32
 fZcjYM6xyjH8fMdQPwpxw8KGAeYlSN/adO4di2mc+yYP8g7/iCbcU4iKBG2Mg0yB/sOT
 5SdShR+lUkq38azqvIFrClm2N3MX0FJh59WFTZzK1uYPsuxBpWIYWZp1nzY7gfaw/tSs
 QjQwhEdSuisJZceRX8TdI6EkXsxDYIfRMP3jaskQfIZZmpl2M+AAfRBDLqVLgHqXKa4+
 q/7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779466318; x=1780071118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GnOH4oi9MCTSp//zOnHHBdVKY0oDkBkYij1oiK/rQm8=;
 b=oopVuFA6c4ny12t3b5JZPgmPvjWeg/G+hDKcAYRZgfikRBgWyemA4dP5E/XaoUN0Vf
 Js0FrvLuZ0VL0nonLU18UMNbz18+zuKIbnrET5m1yBjtfXXGJjg2r3OUxGs2CenLiAsL
 oak47XdIVbylMKjPkuDmErU8Rzl7mOpz5wM3KYlcV45HW3Y9F+bYblT9d49atAZW3bV+
 ly1LaGDGw54U/CI1nK+xwhpl5OLalmP+QSP2obPorTNBalb9596kHabdr1r0m91PX4cj
 /rVtUjW1y0WKyelNwpzLiBieJlk7B8/bVcRsKGCoXWxaBXJf6ju7VDBJF3OFTvFGKyHN
 jo2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+EZc2NGv4dPk/nZrHV9XS7DLYxurfFEBeyUJDqPd+7IvuwqiJ2I3LM3nCibJVAd1W6VnktOrrqpV8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwV8VXPx+XWhQcW+hkiTA1sfWstn5lw/syu9BMI2dmIcTCAhhSN
 eGSTQJuVAw1/pOxgOnfuVnJ7a8oPrNIdD8ViIekoCh1yBNDKoMbfECoZ
X-Gm-Gg: Acq92OFzdosA8wUIHgtY8NFLEp+aP+UtkURHGexrmRpmQ5Cd/Bf5/nyotq0pRE6nIQi
 RVoEvzXVs8E2DoDDxR+AQfqwK5P+NU7Va8iNxMVNGSTHhZHMiDr0QGLPzm/+waBN8JavxIeMIJ2
 yW1NIfBfVZKmMmLeKDD+2mJ6nkjidFR1qnZIoQLXVN21aRvpc06aH8RYgT15nxOOLGHDtwrBltz
 xcbXbvtyzdqoX0fhXqyLtqYHWDi0UpHXPgBqu9FDC5gcsmKdkPL4vTTA5+N6zH40cVcv30J0CTJ
 S1RDG0p2AWhlORJLj+sOGmyUyc46xfKrLlMbtsIcTGXIVvoOcAkz80hdbgX9sWDW4mErRsNDbTJ
 w2sMYYiKoyYMFwA4e00kEiks/+uiwG+rr/EQvLPEri5w90eDtlqVZaXjN/4ZB97SArG2p74tmFs
 UVQmxI00GrEHP7GINbJauTAfUt/oODLCNdY3zFCTr72A==
X-Received: by 2002:a05:600c:3e12:b0:490:40f1:5314 with SMTP id
 5b1f17b1804b1-49042482845mr63876345e9.1.1779466317936; 
 Fri, 22 May 2026 09:11:57 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm51042755e9.11.2026.05.22.09.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 09:11:57 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 11/11] arm64: dts: ti: k3-am62-verdin: Add Mezzanine with
 Toradex Display 10.1" LVDS
Date: Fri, 22 May 2026 17:11:15 +0100
Message-ID: <20260522161105.277519-24-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522161105.277519-13-ivitro@gmail.com>
References: <20260522161105.277519-13-ivitro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Vitor Soares <vitor.soares@toradex.com>

Add a device tree overlay enabling the Toradex Capacitive Touch Display
10.1" LVDS on the Verdin Development Board with Verdin AM62 Mezzanine
expansion board. The panel connects via the AM62 OLDI0 on the Mezzanine
LVDS interface (J10). The panel is a LogicTechno LT170410-2WHC 10.1" WXGA
IPS LCD and the touch input is provided by an Atmel MaxTouch capacitive
touch controller.

Link: https://developer.toradex.com/hardware/accessories/displays/capacitive-touch-display-101inch-lvds
Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
Changes in v3:
- Add missing regulator-name property on fixed regulators
- Simplify regulator labels
- Rename touch@ nodes to touchscreen@

Changes in v2:
- Use panel-simple compatible form

 arch/arm64/boot/dts/ti/Makefile               |  5 +
 ...mezzanine-panel-cap-touch-10inch-lvds.dtso | 98 +++++++++++++++++++
 2 files changed, 103 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 90bb3b0522d3..371f9a043fe5 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -30,6 +30,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-phyboard-lyra-rdk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-tqma62xx-mba62xx.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-can.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-nau8822-btl.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-hdmi.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtbo
@@ -231,6 +232,9 @@ k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch-dtbs := \
 	k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtbo
 k3-am625-verdin-wifi-dev-mezzanine-can-dtbs := k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dev-mezzanine-can.dtbo
+k3-am625-verdin-wifi-dev-mezzanine-panel-cap-touch-10inch-lvds-dtbs := \
+	k3-am625-verdin-wifi-dev.dtb \
+	k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtbo
 k3-am625-verdin-wifi-dev-nau8822-btl-dtbs := k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dev-nau8822-btl.dtbo
 k3-am625-verdin-wifi-dev-ov5640-24mhz-dtbs := k3-am625-verdin-wifi-dev.dtb \
@@ -348,6 +352,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-sk-hdmi-audio.dtb \
 	k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch.dtb \
 	k3-am625-verdin-wifi-dev-mezzanine-can.dtb \
+	k3-am625-verdin-wifi-dev-mezzanine-panel-cap-touch-10inch-lvds.dtb \
 	k3-am625-verdin-wifi-dev-nau8822-btl.dtb \
 	k3-am625-verdin-wifi-dev-ov5640-24mhz.dtb \
 	k3-am625-verdin-wifi-dev-ov5640.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtso
new file mode 100644
index 000000000000..83fc4f3a24f5
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtso
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Toradex Capacitive Touch Display 10.1" LVDS on the Verdin AM62 Mezzanine
+ * LVDS interface (J10), used with the Verdin Development Board.
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
+
+&{/} {
+	backlight_pwm2: backlight-pwm2 {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 45 63 88 119 158 203 255>;
+		default-brightness-level = <4>;
+		/* Verdin GPIO_4 (SODIMM 212) - LVDS_BKL_EN */
+		enable-gpios = <&mcu_gpio0 4 GPIO_ACTIVE_HIGH>;
+		/* Verdin PWM_2 (SODIMM 16) - LVDS_PWM */
+		pwms = <&epwm0 1 6666667 PWM_POLARITY_INVERTED>;
+	};
+
+	panel-lvds-native {
+		compatible = "logictechno,lt170410-2whc";
+		backlight = <&backlight_pwm2>;
+		power-supply = <&reg_3v3_lvds>;
+
+		port {
+			panel_lvds_native_in: endpoint {
+				remote-endpoint = <&oldi0_out>;
+			};
+		};
+	};
+
+	reg_3v3_lvds: regulator-3v3-lvds {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-name = "+V3.3_LVDS";
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
+	touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+		/* Verdin GPIO_3 (SODIMM 210) - LVDS_TOUCH_INT# */
+		interrupt-parent = <&mcu_gpio0>;
+		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+		/* Verdin GPIO_2 (SODIMM 208) - LVDS_TOUCH_RST# */
+		reset-gpios = <&mcu_gpio0 2 GPIO_ACTIVE_LOW>;
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
-- 
2.54.0

