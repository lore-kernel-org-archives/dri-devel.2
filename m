Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B05EECD5BB1
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0527E10F55A;
	Fri, 22 May 2026 13:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J4RANoKb";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B0110F55A
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:20:56 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so18717385e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779456055; x=1780060855; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mT2TeAGB5r/QQzUONQHaRVtIxNJg6PZJsffLV09ADoQ=;
 b=J4RANoKbp6RC0L6nnBtj5S383KNmkyrib+d4ASts7IYAOnrCV0PKJh5MuFEGO8Ms19
 us64gglvW0WAEV5lz1tzWuPFtQmGqpKeqIiajfN76Gs4G79Bs35+zm7f5OO1G24BPyPu
 9NDAQyDEQ54MN0+6O24TRs4oBK/rmIpNKRgi2J/k6Q2vOM8+vI/cvmAUmY+sU1h3fToa
 DqYpoe3C4rzTKY5C7VjafRW09cK4/odOsPD7t344lJxqDnQy6o19iU2zbTixj3/9b8At
 QTtEfl6AZZ0dto1ba93mfzCi/sdnMGt9iSPGPF5xivX+Gh2Tgil2yn+TiP7Jki3Mq6kM
 mUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779456055; x=1780060855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mT2TeAGB5r/QQzUONQHaRVtIxNJg6PZJsffLV09ADoQ=;
 b=m/BWtxef35VZx1MtiMUfgGruRROinfvyy5bmgLFQngXfjYujlFOS2WYbpfPKr1fj9K
 05a0M+FQWFzbK+vnINOstAjR7+HN8jhVCTLIRkb0OFXySc3f6DzDi8mAKs+a0flsdOFi
 TDbJXFUE54vTpIoJpqfAqRGrzLFovjKZdW5UllOE8Ud4POnGnwNCqfbUitN0EWdVg84Z
 w8m03QiAhoZxU20jYCi1rnmMR773cCj5bK25LJlxfaVQVMgGv/Y1J/R5pltHTJxqjfc9
 zBQJQdw0JTt3C3EKMJlJ77JvwmEyKFJaxdzHAN73bCDS4lfLU7eG7CNQX+pwK3o7GAUY
 +g/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/H0qnaxh6Wb1nHlvQA7pHgCRbr+hdX+NGqyrUO1VuxL2SJJe47Q2QTMhhG7r2Haa0QsfDCQjBB4Fw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbaVMg3KdW23X9nRaAy8wdTFVztfibb0nTxvrU7cKFqDW4g6Tm
 teH711vLooUgYGB4ul40zoN8QbkpdzOSm4X87YOpZu5t5iTMPQXYbA9K
X-Gm-Gg: Acq92OHJtf/K8cQXYZkVaiqfcm5u3scwy01QstwCreG5f6gOCnUxNC4ljLzLwTEwTlu
 rNA26NaJkIEaX2rb27lzxfLRXJIVKapssmDiayEZsME0RaJcip/lAfk7cwcjDRhvxB9nuy0h51h
 vvJB5OcRjkyQ5B+HFoWtTbA0FWbV5UECVYL+GcqFJ3/bIy2vvHmXtCpNxJde/07/dxbNho3QjHD
 QALn+x/ADcYqdOqJYmtjrCiLVBeeBNE3VvnqcOyYCzUXuAvjum2hVRE2wnnIXihC1OSEnomkT5T
 X0JDbNzoGw9PgKfsKs0Z9KRWepbrEFD4MrNNZKgHZY//e47XM6QAzl1nPzgjL0ze1Upmb85MYQE
 V+RLCH41IkjD2lhGBea9AGr2H+fbgXWKWkNaqjFhHu4GJVjSQY4ld+FJHhmZ1iCGoiojDc5KrsJ
 O5tXqKdaH77vxMhG4BFV1fQmmNYD7PiWlhzJ/RUnVGEQ==
X-Received: by 2002:a05:600c:a402:b0:48f:e6de:1cba with SMTP id
 5b1f17b1804b1-490426c5b3emr40882445e9.17.1779456054568; 
 Fri, 22 May 2026 06:20:54 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0cd5sm52220755e9.10.2026.05.22.06.20.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 06:20:54 -0700 (PDT)
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
Subject: [PATCH v2 11/11] arm64: dts: ti: k3-am62-verdin: Add Mezzanine with
 Toradex Display 10.1" LVDS
Date: Fri, 22 May 2026 14:20:24 +0100
Message-ID: <20260522132014.226721-24-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522132014.226721-13-ivitro@gmail.com>
References: <20260522132014.226721-13-ivitro@gmail.com>
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
Changes in v2:
- Use panel-simple compatible form

 arch/arm64/boot/dts/ti/Makefile               |  5 +
 ...mezzanine-panel-cap-touch-10inch-lvds.dtso | 97 +++++++++++++++++++
 2 files changed, 102 insertions(+)
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
index 000000000000..f15231ef68f9
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-dev-mezzanine-panel-cap-touch-10inch-lvds.dtso
@@ -0,0 +1,97 @@
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
+		power-supply = <&reg_3v3_lvds_native>;
+
+		port {
+			panel_lvds_native_in: endpoint {
+				remote-endpoint = <&oldi0_out>;
+			};
+		};
+	};
+
+	reg_3v3_lvds_native: regulator-3v3-lvds-native {
+		compatible = "regulator-fixed";
+		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <3300000>;
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
+	touch@4a {
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

