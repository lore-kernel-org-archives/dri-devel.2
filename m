Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A6606A325
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzvKirmt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACEAB10FB0A;
	Wed, 28 Oct 2026 09:52:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A3A810FB09
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:52:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 330FB41655;
 Wed, 28 Oct 2026 09:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A491F031E0;
 Wed, 28 Oct 2026 09:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793181157;
 bh=BMzeR5XwTVSEdnpmJzgxnKNf7Qx+ASdfSFIXqpGMQH8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lzvKirmtRNjU+bKWx/JjbWiTboBwrLo1f+UEZ0U1Ceukmth/Y9jIrmb2ffRlUt9xh
 SCGzVlYEhrLDkZYGL4P9BYOEAHw3zHqO1WdqV2u8s0yj5LppRaHM1WQesNbbtyr7+P
 jf2zp6bJLqqu0MGAlTPKKFiYcRCgURAQKA42zLxI4g5sGkgvrrRuLSdm3/NmkSzNr4
 kvN03KbY9TuGZaNeI3I+drmi8VYyhgrpUX9jveg+gQ/uuSUtO9gTIraoQfK+a5dydg
 pYyKu2lGj41BoFoZyMoL84uGzdJsVcoHjqefHcso6/OLRyDS126nNf2Q4/FWTUDRqH
 OzRRU7a8umyFw==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Ritesh Kumar <quic_riteshk@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH 7/8] arm64: dts: qcom: sm8450-hdk: Add display card overlay
Date: Wed, 28 Oct 2026 11:51:50 +0200
Message-ID: <20261028095151.1682096-8-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261028095151.1682096-1-vz@kernel.org>
References: <20261028095151.1682096-1-vz@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The SM8450 HDK board can be connected to an external display card, which
carries a 1080x2400 LCD panel module powered by the Novatek NT36672E
display driver IC with an integrated touchscreen controller.

The panel is connected to DSI0 over a 3-trio MIPI C-PHY link, power is
supplied by VREG_L12C_1P8, the bias supplies are on the panel module,
and they are enabled by signal PM8350 GPIO8 (LCD_BIAS_EN).

The backlight is controlled by the PM8350 GPIO9 (LCD_WLED_EN) signal and
the PM8350C LPG PWM on PM8350C GPIO8 (LCD_PWM).

As documented in the panel binding, the reset GPIO is described as
active high, although the panel reset signal is active low.

The DSI0 output is shared with the on-board Lontium LT9611UXC HDMI
bridge, thus disable the bridge and its power supplies in the overlay.

The touchscreen controller is not described, since there is no binding
or driver support for it yet.

Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |   4 +
 .../dts/qcom/sm8450-hdk-display-card.dtso     | 144 ++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-hdk-display-card.dtso

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 88230c4e00ea..93abf21132c1 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -422,6 +422,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-microsoft-surface-duo2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx214.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-sony-xperia-sagami-pdx215.dtb
+
+sm8450-hdk-display-card-dtbs	:= sm8450-hdk.dtb sm8450-hdk-display-card.dtbo
+
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk-display-card.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-samsung-r0q.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk-display-card.dtso b/arch/arm64/boot/dts/qcom/sm8450-hdk-display-card.dtso
new file mode 100644
index 000000000000..0e7b48b8357a
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk-display-card.dtso
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Linaro Limited
+ * Copyright (c) Vladimir Zapolskiy <vz@kernel.org>
+ */
+
+/*
+ * Display Card kit overlay
+ *
+ * S5702 switch 7 should be turned OFF to route DSI0 to the display panel
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	lcd_backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pm8350c_pwm 3 65535>;
+		enable-gpios = <&pm8350_gpios 9 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&lcd_wled_en>;
+		pinctrl-names = "default";
+	};
+};
+
+/* Disable HDMI bridge related nodes (mutually exclusive with the display card) */
+
+&i2c9 {
+	status = "disabled";
+};
+
+&lt9611_1v2 {
+	status = "disabled";
+};
+
+&lt9611_3v3 {
+	status = "disabled";
+};
+
+&lt9611_codec {
+	status = "disabled";
+};
+
+&mdss_dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel@0 {
+		compatible = "novatek,nt36672e";
+		reg = <0>;
+
+		enable-gpios = <&pm8350_gpios 8 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&tlmm 0 GPIO_ACTIVE_HIGH>;
+
+		vddi-supply = <&vreg_l12c_1p8>;
+
+		backlight = <&lcd_backlight>;
+
+		pinctrl-0 = <&disp0_reset_n_active>, <&mdp_vsync>, <&lcd_bias_en>;
+		pinctrl-1 = <&disp0_reset_n_suspend>, <&mdp_vsync>, <&lcd_bias_en>;
+		pinctrl-names = "default", "sleep";
+
+		port {
+			panel0_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
+	data-lanes = <0 1 2>;
+};
+
+&mdss_dsi0_phy {
+	phy-type = <PHY_TYPE_CPHY>;
+};
+
+&pm8350_gpios {
+	lcd_bias_en: lcd-bias-en-state {
+		pins = "gpio8";
+		function = "normal";
+		output-low;
+		bias-disable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		power-source = <0>;
+	};
+
+	lcd_wled_en: lcd-wled-en-state {
+		pins = "gpio9";
+		function = "normal";
+		output-low;
+		bias-disable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		power-source = <0>;
+	};
+};
+
+&pm8350c_gpios {
+	lcd_pwm: lcd-pwm-state {
+		pins = "gpio8";
+		function = "func1";
+		output-low;
+		bias-disable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		power-source = <0>;
+	};
+};
+
+&pm8350c_pwm {
+	pinctrl-0 = <&lcd_pwm>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&tlmm {
+	disp0_reset_n_active: disp0-reset-n-active-state {
+		pins = "gpio0";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	disp0_reset_n_suspend: disp0-reset-n-suspend-state {
+		pins = "gpio0";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdp_vsync: mdp-vsync-state {
+		pins = "gpio86";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};
-- 
2.51.0

