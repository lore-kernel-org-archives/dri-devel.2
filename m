Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277C1CDE001
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5199410EDDB;
	Wed, 24 Jun 2026 07:48:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fTieKVFR";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98A210E36C
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 19:58:51 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-13810b63a1aso585013c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782244731; x=1782849531; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z/fp9uYhKIZVODXjBwNwAyAJlbCISy/3icMoMCSqHfo=;
 b=fTieKVFRbsaoBXVi/1mA/tegCO/baGtkMRAQ9rjH6a5Vyk3cI1B5g9FaES9vhR0UAX
 w7o6MuK32X8vse/VtN2EBbGog4h7R8rrP7XKiaLLm0c83/eK584wlLCTb2eHrYZmfvtG
 o2uOMRnRpjauR1ezL5bsoARUbfNKsKEzrS+edQewBHerBItLlY/QkUz4ge0radDZBU16
 Qce7RnvRNHHCLTHeodufDM5Lj/xigiJl8Gr8EX84ViIKFIkDnXhk9JTJprZXceee1XNG
 /qyrf7rJn1T0xsvCKL22sv9lXNzXHh1t2RykPlRW/s08QIOvRw6qW6lEPRepWqSF6MuH
 objQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782244731; x=1782849531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z/fp9uYhKIZVODXjBwNwAyAJlbCISy/3icMoMCSqHfo=;
 b=h2yY6ofrL+tHpOOouEw0Zo0IDYbZlWw+JpzL/hBNoHFIUBBwVCu5X2joNvnpJP3QKc
 nTqhn0KlJNu6xID9D+CZf3Lc+iEcFHJD9nIofSO0LK+iRaGW1Jqx/rOkqLmWEx7ONC7H
 opRL9LNPSkRbdw7t/FZrc+LsEvcQY6RmtDS+QGcwJZlN1hk9bt2qF6s2zmJUDv1UJGzX
 g4N1Tak0oMDMEDX0v3rGQIpsRM0NShdb7ansCmS5dbQzGjRntn+PgNOerwatg346MM5K
 /ORasapDGvJxNszbHK9UqGemL2pz4W8AFvxzyiZWdXVMcsgiVQtR0/36k57HLiLej0wn
 EFnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ96FRlt29+3pOuDZcUJcU9G5Akfun10lN5zfwc/BoTS8MnKlkx7oMgmYYrQ3AfU5cAFUH+wAOr0afQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDV7N94xyjwp43vd8bz+6ZQbZJKBhfojbS7mpgNLt7ft04p6L0
 gtc/E9qC8OYObQpdP8+EJeWEaqg+R5iOJGR1vY1VqOAhaTvI6kkL68+N
X-Gm-Gg: AfdE7clsrWq7Zr0fBp4SRimqEGcWHxG6R7Wrqe5HRG/qHJKyRso8cVWWTBoIBPPaScs
 M7QB8IS/HolSymJAIphD2iFUAja5LxDkxPExhoV+WoKQgmY+28jZ4W2zb5ufS3+vqs4vO1SzTKT
 mwhdCJQbM1P3hh3z8rLR1bf4niWj01+yVOQwfJpsBqe5XqZklwusbHDF29zWZCS+5QmdrdFnaji
 JAgw9+F2QEzAqFGRCQ5QvkIq5c7WdturtwlitSldS/U5JCBkX7NnmA90K3P/CoRQbRiqLNUGsGm
 t9EjEp1XsJAxrHZYZic7cxJHj8/zliuqJ4t24Q2/F+mvcP8mp/1PphYvvY61ZgOij0DHD0sz6us
 ybru5+D77TBf2mKoIvpzMhRX0aG9Chb+g3FE4+Jw45knYAqyoNaUtOtPZpEl895Na2qHg2AMPwV
 ORE94bHC96UGV2ck//DSNoBeRJo+VowibmxjiMgpUZIdqyeOFmzgMTw32+hg2SldY9e/lQ3Fbx4
 fm75RGfPlmXflSqL0wzWcZ2RwVV4c2z7jTPqqrTZbg=
X-Received: by 2002:a05:7022:4397:b0:138:5ae:3eaa with SMTP id
 a92af1059eb24-139ad6961c2mr13263116c88.9.1782244731170; 
 Tue, 23 Jun 2026 12:58:51 -0700 (PDT)
Received: from leonardoc-nb (201-68-197-145.dsl.telesp.net.br.
 [201.68.197.145]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add85c40sm15730896c88.15.2026.06.23.12.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 12:58:50 -0700 (PDT)
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
Subject: [PATCH 5/5] arm64: dts: ti: k3-am62-verdin: Add Mezzanine with
 Toradex Display 10.1" LVDS
Date: Tue, 23 Jun 2026 16:57:41 -0300
Message-ID: <20260623195741.495734-6-leoreis.costa@gmail.com>
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

Add a device tree overlay enabling the Toradex Capacitive Touch Display
10.1" LVDS V2 on the Verdin Development Board with Verdin AM62 Mezzanine
expansion board. The panel connects via the AM62 OLDI0 on the Mezzanine
LVDS interface (J10). The panel is an Opto Logic SCX1001511GGC49 10.1" WXGA
TFT LCD LVDS and the touch input is provided by an ILITEK ILI251x
capacitive touch controller.

Link: https://developer.toradex.com/hardware/accessories/displays/capacitive-touch-display-101inch-lvds
Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 arch/arm64/boot/dts/ti/Makefile               |   5 +
 ...zanine-panel-cap-touch-10inch-lvds-v2.dtso | 109 ++++++++++++++++++
 2 files changed, 114 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 8b90fef11cb32..d9e0b1b80b28d 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -31,6 +31,7 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-sk.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-tqma62xx-mba62xx.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-can.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dev-nau8822-btl.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-hdmi.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtbo
@@ -240,6 +241,9 @@ k3-am625-verdin-wifi-dev-mezzanine-can-dtbs := k3-am625-verdin-wifi-dev.dtb \
 k3-am625-verdin-wifi-dev-mezzanine-panel-cap-touch-10inch-lvds-dtbs := \
 	k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtbo
+k3-am625-verdin-wifi-dev-mezzanine-panel-cap-touch-10inch-lvds-v2-dtbs := \
+	k3-am625-verdin-wifi-dev.dtb \
+	k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtbo
 k3-am625-verdin-wifi-dev-nau8822-btl-dtbs := k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dev-nau8822-btl.dtbo
 k3-am625-verdin-wifi-dev-ov5640-24mhz-dtbs := k3-am625-verdin-wifi-dev.dtb \
@@ -362,6 +366,7 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-verdin-wifi-dev-dsi-to-lvds-v2-panel-cap-touch-10inch.dtb \
 	k3-am625-verdin-wifi-dev-mezzanine-can.dtb \
 	k3-am625-verdin-wifi-dev-mezzanine-panel-cap-touch-10inch-lvds.dtb \
+	k3-am625-verdin-wifi-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtb \
 	k3-am625-verdin-wifi-dev-nau8822-btl.dtb \
 	k3-am625-verdin-wifi-dev-ov5640-24mhz.dtb \
 	k3-am625-verdin-wifi-dev-ov5640.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtso
new file mode 100644
index 0000000000000..26f6715463986
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds-v2.dtso
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Toradex Capacitive Touch Display 10.1" LVDS V2 on the Verdin AM62 Mezzanine
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
+		/* Verdin GPIO_3 (SODIMM 210) - LVDS_TOUCH_INT# */
+		interrupt-parent = <&mcu_gpio0>;
+		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
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
