Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EDDCD5BB6
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 16:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABCB10F694;
	Fri, 22 May 2026 16:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E+k9JfpO";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 642AD10F61A
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:11:56 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4903d5c67bfso9324865e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779466315; x=1780071115; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=feqCuYJiSrJNV96kUr6v72Q4V4YTTvof+UmoeS01S+w=;
 b=E+k9JfpOzyhP4MGRHiw0eYCIVa5ha86nzmwJ82ozItx2S2j5HUWys8FQLhZ0Qa/Wfx
 5+/5a6Y7/NTLkb0Ia0XbGVzgHp64RH8ssuiNrmilAMkve5F8RozJGZEXaIFmfyRxStLi
 2c35kQ5r/wycFwKZ1HAlNvzhoqlbMGU7QNOQ9JFBbI51dur0dCyBzz+aAgaXymQsYEQ+
 KJcLfBjyfyIEZIATGtUJ3EnYeiAJn3/f83MfApKM0ElSexumvYe4oj4pgOOwmViB76ho
 jRZjqThD16aoFBnuVh5STt8MWvHsEOqc/u/XY1AEvgFYQU+jq192n5tnF7zAHyESGucp
 X9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779466315; x=1780071115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=feqCuYJiSrJNV96kUr6v72Q4V4YTTvof+UmoeS01S+w=;
 b=Isemqk0jRaEVurEdluRy60KULB6A4T57RuZjIzDLj90XCu8h5+owavNR4hYuEsFtlP
 /Z1hXjK4XeIzpHNAVcybUi3CkK9grWmFctUxPLAyMNNmSUMDwir8wBxKBujVshXKrMAE
 SyVVT5MlOrkjUXiWsuNNhVzbgnxC1rY1rYasIvpZ27bcKmRoGVAuFWOsnW0iwcpeYMIn
 mSYnF/qJCugJOfMz7LZqZy0bWMl7dXMutXmzjiMKjc8kc0llMeaCp9zAPtJzJJb39y5U
 8FljzY/GIEffv7xYLhEvX/Fmpm/7UwrB4NjYhj7qtsPwpHlPBtbgrnamD5XvakJh5jNI
 EnHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jeB2a/szF9/b4gr7em//piPKBInwrzH3CFUho51Y65CjxMI6X+BpWZdJ8jd05m2uzooh03PbA4qI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6lnl7xJAGLHlt2eujU4V2/Hnhketz35NKVAYgAGfRERnwuIm8
 SNjfj8N2kXEUX+Fij7NnA3SpUcqcjC0O5Q5e8flkZLZi3MAkGXDrcxoQ
X-Gm-Gg: Acq92OEOVP3YdYmQlgDH6z0PSmZIC6AdnKcDCuSn+lsjOG08mVrOyNRSKWqZsmI7u/V
 X9eYBZaP4P5DVSBHE24p0vkpiGc3O/USzM0SakqbCFjJT69h0NULees6AXprMrAHBYc3rYbCr4g
 MZvykhqc3qTrTSntPw+lk2Hvjl/kn0g0QheIIp0A3RpOnXZ/M24S8haHKNKJc6z8a44q2A+YpvR
 tashOlUwLE2z+w1r6r/1Sv7lwK5Wr8GW6OQz35N/OFmO1fpWgWHjE4zSIeZ5M0faFmzLDzwQVZa
 y8aiNRolcWym+1NoPpQxLgKdqcLQOhGsa1k0gs76m4ZrzYoGeUYnGECSpb6sxJ527wr0m9j9TOw
 coBSGjJOaG9z+0jmBhG8q9JDlC4XHxwtvRiZogse/wHlt1YNfBoxxeVi8nPuKEvErr04LxU+gFB
 gOril7JEerpjM5ZsiFwoBLRoQ+3WUsFZj8VervqEPRlQ==
X-Received: by 2002:a05:600c:4ecc:b0:488:a824:fdff with SMTP id
 5b1f17b1804b1-490426d190cmr61481075e9.22.1779466314619; 
 Fri, 22 May 2026 09:11:54 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b9asm51042755e9.11.2026.05.22.09.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 09:11:54 -0700 (PDT)
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
Subject: [PATCH v3 09/11] arm64: dts: ti: k3-am62-verdin: Add Toradex OV5640
 CSI Cameras
Date: Fri, 22 May 2026 17:11:13 +0100
Message-ID: <20260522161105.277519-22-ivitro@gmail.com>
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

Add device tree overlays for the Toradex OV5640 CSI Cameras on Verdin
CSI_1. Two variants are supported: the current CSI Camera Set 5MP OV5640
with a 27 MHz oscillator and the legacy CSI Camera Module 5MP OV5640
with a 24 MHz oscillator.

Link: https://developer.toradex.com/hardware/accessories/cameras/csi-camera-module-5mp-ov5640-arducam
Link: https://developer.toradex.com/hardware/legacy-products/other/csi-camera-module-5mp-ov5640/
Assisted-by: Claude:claude-sonnet-4.6
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 arch/arm64/boot/dts/ti/Makefile               |  8 +++
 .../dts/ti/k3-am625-verdin-ov5640-24mhz.dtso  | 17 +++++
 .../boot/dts/ti/k3-am625-verdin-ov5640.dtsi   | 71 +++++++++++++++++++
 .../boot/dts/ti/k3-am625-verdin-ov5640.dtso   | 18 +++++
 4 files changed, 114 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640-24mhz.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640.dtso

diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
index 31c9bc1d48b1..60844951c9ce 100644
--- a/arch/arm64/boot/dts/ti/Makefile
+++ b/arch/arm64/boot/dts/ti/Makefile
@@ -41,6 +41,8 @@ dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-ivy.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-mallow.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-yavia.dtb
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-nonwifi-zinnia.dtb
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-ov5640-24mhz.dtbo
+dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-ov5640.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-10inch-dsi.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-10inch-lvds.dtbo
 dtb-$(CONFIG_ARCH_K3) += k3-am625-verdin-panel-cap-touch-7inch-dsi.dtbo
@@ -228,6 +230,10 @@ k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch-dtbs := \
 	k3-am625-verdin-dsi-to-lvds-panel-cap-touch-10inch.dtbo
 k3-am625-verdin-wifi-dev-nau8822-btl-dtbs := k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-dev-nau8822-btl.dtbo
+k3-am625-verdin-wifi-dev-ov5640-24mhz-dtbs := k3-am625-verdin-wifi-dev.dtb \
+	k3-am625-verdin-ov5640-24mhz.dtbo
+k3-am625-verdin-wifi-dev-ov5640-dtbs := k3-am625-verdin-wifi-dev.dtb \
+	k3-am625-verdin-ov5640.dtbo
 k3-am625-verdin-wifi-dev-panel-cap-touch-7inch-dsi-dtbs := \
 	k3-am625-verdin-wifi-dev.dtb \
 	k3-am625-verdin-panel-cap-touch-7inch-dsi.dtbo
@@ -339,6 +345,8 @@ dtb- += k3-am625-beagleplay-csi2-ov5640.dtb \
 	k3-am625-sk-hdmi-audio.dtb \
 	k3-am625-verdin-wifi-dev-dsi-to-lvds-panel-cap-touch-10inch.dtb \
 	k3-am625-verdin-wifi-dev-nau8822-btl.dtb \
+	k3-am625-verdin-wifi-dev-ov5640-24mhz.dtb \
+	k3-am625-verdin-wifi-dev-ov5640.dtb \
 	k3-am625-verdin-wifi-dev-panel-cap-touch-7inch-dsi.dtb \
 	k3-am625-verdin-wifi-dev-uart4-mcu.dtb \
 	k3-am625-verdin-wifi-mallow-panel-cap-touch-10inch-lvds.dtb \
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640-24mhz.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640-24mhz.dtso
new file mode 100644
index 000000000000..7089336fa5b4
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640-24mhz.dtso
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Toradex CSI Camera Module 5MP OV5640 on Verdin CSI_1.
+ *
+ * https://developer.toradex.com/hardware/legacy-products/other/csi-camera-module-5mp-ov5640/
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include "k3-am625-verdin-ov5640.dtsi"
+
+&clk_ov5640_osc {
+	clock-frequency = <24000000>;
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640.dtsi b/arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640.dtsi
new file mode 100644
index 000000000000..eb3df9d85517
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640.dtsi
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Common device tree include for Toradex OV5640 CSI camera on Verdin CSI_1.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+&{/} {
+	clk_ov5640_osc: ov5640-xclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+	};
+
+	regulator_camera: regulator-camera {
+		compatible = "regulator-fixed";
+		/* Verdin GPIO_8_CSI (SODIMM 222) - CAM_1_CON_PWRCTRL */
+		gpio = <&main_gpio0 42 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-name = "V_CSI";
+		startup-delay-us = <5000>;
+	};
+};
+
+&csi0_port0 {
+	status = "okay";
+
+	csi2rx0_in_sensor: endpoint {
+		remote-endpoint = <&csi2_cam0>;
+		bus-type = <4>; /* CSI2 DPHY */
+		clock-lanes = <0>;
+		data-lanes = <1 2>;
+	};
+};
+
+&dphy0 {
+	status = "okay";
+};
+
+&main_i2c3 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	camera@3c {
+		compatible = "ovti,ov5640";
+		reg = <0x3c>;
+
+		clocks = <&clk_ov5640_osc>;
+		clock-names = "xclk";
+		AVDD-supply = <&regulator_camera>;
+		DOVDD-supply = <&regulator_camera>;
+		DVDD-supply = <&regulator_camera>;
+		/* Verdin GPIO_6 (SODIMM 218) - CAM_1_CON_PWRDWN */
+		powerdown-gpios = <&main_gpio0 36 GPIO_ACTIVE_HIGH>;
+		/* Verdin GPIO_5 (SODIMM 216) - CAM_1_CON_RST */
+		reset-gpios = <&main_gpio0 40 GPIO_ACTIVE_LOW>;
+
+		port {
+			csi2_cam0: endpoint {
+				remote-endpoint = <&csi2rx0_in_sensor>;
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+			};
+		};
+	};
+};
+
+&ti_csi2rx0 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640.dtso b/arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640.dtso
new file mode 100644
index 000000000000..e7f02cfaa94f
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/k3-am625-verdin-ov5640.dtso
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) Toradex
+ *
+ * Toradex CSI Camera Set 5MP OV5640 on Verdin CSI_1.
+ *
+ * https://developer.toradex.com/hardware/accessories/cameras/csi-camera-module-5mp-ov5640-arducam
+ * https://www.toradex.com/accessories/csi-camera-ov5640
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include "k3-am625-verdin-ov5640.dtsi"
+
+&clk_ov5640_osc {
+	clock-frequency = <27000000>;
+};
-- 
2.54.0

