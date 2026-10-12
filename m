Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE285CC6B01
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:11:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D597F10F28E;
	Mon, 12 Oct 2026 18:11:22 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15F7010F2BA
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:11:17 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so2861875a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1791828675; x=1792433475; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3a82ddz5GrnUXDGUPzMm5pep0Z9lqtKy5jkX8QwoyUY=;
 b=qwrkM1HC7FaekbdM6ZWfcI4t7BFSH02wJ4tAqcv2/4Xngq1eutSrYz3QCC8nfcgFq9
 cut+xwoCoVYfrDOJBy7sNTMJsljWFkl0cG0stqY3KDCjjPdgPNzkgHWY0l4z6jypc601
 sSHlTH1TgbxP6dsqtAx2oYESEAgw+5ZaUp777qHmO2YKNs+wlpWT7Y686FGm3wfgmGQA
 YMojmuLf/gB49WQVk+6xxdJW2qoerPAtkrz8Y0fivUMsGaOrLeoXoDDtGSGNDwTglbrS
 oZfjaetKXylR+y4rboZ/J1WM+Q7zLab3IUFRzkfNYpBIsYI8MZfSGr45U83x8khCQ9nC
 93yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791828675; x=1792433475;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3a82ddz5GrnUXDGUPzMm5pep0Z9lqtKy5jkX8QwoyUY=;
 b=UIhb0OsJMhv8uVd3R/gohNscbGPcTCQ2qGy0Lg8TtTzuIehT3RO89Z6Z7J6qA2OkKX
 PTle5KkB9VqgoXQe+AKsGMX9OHIbFZTrHytgw0SNncZSz2jzhgOHLFXmBoxcz1AjWV4b
 jXqAmxNcArPJUcWdAZVRUbfADBhYAHzx6xXZwiorAFIt9zEsV/LVseGoJJkfr4SuCOuV
 mk+PHM/4mVdB83anE7JBw4e/uphs7QTah+0R32tI1xuOn5aPe4U5rnyhYSUyHTYPrmEn
 9AYt9v9FPGehPaFf5UMGw1q08BrJnO57oKljhtR/a3/h8odzQIjLZlo7da7Q4fgurzpS
 MlZA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQgaESgASul4hhCWOzXNcnUWDgqukR0nyfYkxTTXjryqlSKwJJwR7Lfiq/ZXsugViR/b3IR+YhYLQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJRY6iknJSGTdcx6jAiT10MKR4dyN8SAJWHAOkYgIRsZcmHjXpW
 3c+WcUMoRxjdSX8kNDUz1WmV1f1VA9klGkhCa43PlbTgEL9I4YJ1BvYw/kHpcnYmSwU=
X-Gm-Gg: AYBFou0+TdA5DP8xW5v8K4Kw5qtfxg9LyzmzQbAbq0IdlbMKm+9+o3bSoxvHIpzhQQi
 HvXh4zgJ5eo4pjvM1Dp++CI2MuH87ZynreovFAiO0RqgrD5CPzh8kRF1DSQY42EZ/SirxJzgqc/
 DQ5gLL70siQe/LASyAYypS+HAlR45W6FWZajFI1H1JXlHGHcxEHCtATGmf1iwoTVLCCA9Chhep5
 fWBu+nOYpjyjzc+7bnsIAQXp7ndk5QMSVcOolzbdT7FikRdaMtXHY4+eCse4gioGdLJju0V6l/C
 9txZ9wlZugcPWU3gpHpQX+BnuVPXIUC1EfS+UJDtC9IWk8Nic9MAgYz00vfmnceiln+fgWDo4ML
 GLGlkoHjZoIFd7f7biV0//upsq39/o2gJsDbS1ccOuM7xQY8jel6nyq8aTHx/ihFqGLiuR/1tcw
 R3xVdtIfM9Fzt2WFHVNdPVlALflctTZ9lA/0CgyCw0LRMqfWUNvXvg2hX/pLq1g6YZYMSU9TXDB
 nFWj54ldnenYFUQ41yLThV/rBlvzAHQL+9S+KoZ/lEdRxGWK/oiZhBmoOz1Rxyq/64hEO+HuSov
 HaquEQIo9RvZTvbjSns9
X-Received: by 2002:a17:907:d8f:b0:c29:d31f:7d73 with SMTP id
 a640c23a62f3a-c31a9fd5dc1mr1021443466b.9.1791828675437; 
 Mon, 12 Oct 2026 11:11:15 -0700 (PDT)
Received: from [192.168.101.179]
 (2001-1c04-0504-7401-4b2e-1820-6d24-b264.cable.dynamic.v6.ziggo.nl.
 [2001:1c04:504:7401:4b2e:1820:6d24:b264])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9ac924dsm498415466b.70.2026.10.12.11.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 11:11:15 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Mon, 12 Oct 2026 20:11:05 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: Add Samsung Galaxy Book2 Go
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-book2go-v1-3-7188e7ea7a15@fairphone.com>
References: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
In-Reply-To: <20261012-book2go-v1-0-7188e7ea7a15@fairphone.com>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, Jasper Korten <jja2000@gmail.com>, 
 Federico Amedeo Izzo <federico@izzo.pro>, Luca Weiss <luca@lucaweiss.eu>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791828669; l=15911;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Y6IkfJVo8OdD/E5asQkmfMjQa0Pptj/sIYcLSB1GiEQ=;
 b=o8udCmoEQniTklG5LQtU4+NXjB49mpF3nyRi64VwOB8PpUs055HvzbRuiXWA85PEQtGHO6Hwd
 jphrC+pmASJDkI/Vtf6gP99mcKGUKXg/Hmmixmbu6il54Z52LXYBvfe
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

From: Jasper Korten <jja2000@gmail.com>

The Samsung Galaxy Book2 Go is a laptop with a Snapdragon 7c+ Gen 3 SoC
(SC7280).

Add initial functionality:
* Display (with backlight, GPU)
* Touchpad & keyboard (without Fn key mapping support)
* UFS storage
* SD card
* USB Type-A port
* Modem and mobile data
* WiFi & Bluetooth
* ADSP & CDSP bootup
* Battery fuel gauge
* Venus/Iris
* Lid switch
* RGB LED (Operating status LED)
* Webcam (USB UVC)

Notably missing:
* Speaker & microphone
* Charging
* USB Type-C ports (except when active at boot)
* DisplayPort on right-side USB-C port

Signed-off-by: Jasper Korten <jja2000@gmail.com>
Co-developed-by: Federico Amedeo Izzo <federico@izzo.pro>
Signed-off-by: Federico Amedeo Izzo <federico@izzo.pro>
Co-developed-by: Luca Weiss <luca@lucaweiss.eu>
Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   1 +
 .../dts/qcom/sc7280-samsung-galaxy-book2-go.dts    | 643 +++++++++++++++++++++
 2 files changed, 644 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1c86e7e98f55..8e54d9ce5f3d 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -287,6 +287,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-zombie-nvme-lte.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-samsung-galaxy-book2-go.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-lenovo-flex-5g.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-primus.dtb
 sc8280xp-crd-el2-dtbs	:= sc8280xp-crd.dtb sc8280xp-el2.dtbo
diff --git a/arch/arm64/boot/dts/qcom/sc7280-samsung-galaxy-book2-go.dts b/arch/arm64/boot/dts/qcom/sc7280-samsung-galaxy-book2-go.dts
new file mode 100644
index 000000000000..fe1a1b01f67e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc7280-samsung-galaxy-book2-go.dts
@@ -0,0 +1,643 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2025, Jasper Korten <jja2000@gmail.com>
+ * Copyright (c) 2026, Luca Weiss <luca@lucaweiss.eu>
+ */
+
+/dts-v1/;
+
+/* PM7250B is configured to use SID8/9 */
+#define PM7250B_SID 8
+#define PM7250B_SID1 9
+
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "kodiak.dtsi"
+#include "qcs6490-audioreach.dtsi"
+#include "pm7250b.dtsi"
+#include "pm7325.dtsi"
+#include "pm8350c.dtsi"
+#include "pmk8350.dtsi"
+
+/delete-node/ &ipa_fw_mem;
+/delete-node/ &rmtfs_mem;
+/delete-node/ &wpss_mem;
+/delete-node/ &xbl_mem;
+
+/ {
+	model = "Samsung Galaxy Book2 Go";
+	compatible = "samsung,galaxy-book2-go", "qcom,sc7280";
+	chassis-type = "laptop";
+
+	aliases {
+		serial1 = &uart7;
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&hall_int_default>;
+		pinctrl-names = "default";
+
+		switch-lid {
+			label = "Switch Lid";
+			gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			wakeup-source;
+		};
+	};
+
+	pm8350c_pwm_backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pm8350c_pwm 3 65535>;
+		enable-gpios = <&pm8350c_gpios 7 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&pmic_lcd_bl_en>;
+		pinctrl-names = "default";
+	};
+
+	vreg_edp_3p3: regulator-edp-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_EDP_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&edp_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	reserved-memory {
+		wpss_mem: wpss@84800000 {
+			reg = <0x0 0x84800000 0x0 0x1900000>;
+			no-map;
+		};
+
+		rmtfs_mem: rmtfs@a0800000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0xa0800000 0x0 0x300000>;
+			no-map;
+
+			qcom,client-id = <1>;
+		};
+
+		ipa_fw_mem: ipa-fw@81800000 {
+			reg = <0x0 0x81800000 0x0 0x70000>;
+			no-map;
+		};
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm7325-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vreg_l1b_0p8: ldo1 {
+			regulator-name = "vreg_l1b";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+		};
+
+		vreg_l2b_3p0: ldo2 {
+			regulator-name = "vreg_l2b";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+		};
+
+		vreg_l6b_1p2: ldo6 {
+			regulator-name = "vreg_l6b";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		vreg_l7b_2p9: ldo7 {
+			regulator-name = "vreg_l7b";
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9b_1p2: ldo9 {
+			regulator-name = "vreg_l9b";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18b_1p8: ldo18 {
+			regulator-name = "vreg_l18b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l19b_1p8: ldo19 {
+			regulator-name = "vreg_l19b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_s1b_1p8: smps1 {
+			regulator-name = "vreg_s1b";
+			regulator-min-microvolt = <1872000>;
+			regulator-max-microvolt = <1872000>;
+		};
+
+		vreg_s7b_0p9: smps7 {
+			regulator-name = "vreg_s7b";
+			regulator-min-microvolt = <952000>;
+			regulator-max-microvolt = <952000>;
+		};
+
+		vreg_s8b_1p2: smps8 {
+			regulator-name = "vreg_s8b";
+			regulator-min-microvolt = <1256000>;
+			regulator-max-microvolt = <1256000>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8350c-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-name = "vreg_l1c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l6c_2p9: ldo6 {
+			regulator-name = "vreg_l6c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		vreg_l7c_3p0: ldo7 {
+			regulator-name = "vreg_l7c";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		vreg_l9c_2p9: ldo9 {
+			regulator-name = "vreg_l9c";
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l10c_0p8: ldo10 {
+			regulator-name = "vreg_l10c";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+		};
+
+		vreg_l12c_1p8: ldo12 {
+			regulator-name = "vreg_l12c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+	};
+};
+
+&gcc {
+	protected-clocks = <GCC_CFG_NOC_LPASS_CLK>,
+			   <GCC_EDP_CLKREF_EN>,
+			   <GCC_MSS_CFG_AHB_CLK>,
+			   <GCC_MSS_GPLL0_MAIN_DIV_CLK_SRC>,
+			   <GCC_MSS_OFFLINE_AXI_CLK>,
+			   <GCC_MSS_Q6SS_BOOT_CLK_SRC>,
+			   <GCC_MSS_Q6_MEMNOC_AXI_CLK>,
+			   <GCC_MSS_SNOC_AXI_CLK>,
+			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
+			   <GCC_QSPI_CORE_CLK>,
+			   <GCC_QSPI_CORE_CLK_SRC>,
+			   <GCC_SEC_CTRL_CLK_SRC>,
+			   <GCC_WPSS_AHB_BDG_MST_CLK>,
+			   <GCC_WPSS_AHB_CLK>,
+			   <GCC_WPSS_RSCP_CLK>;
+};
+
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/sc7280/Samsung/galaxy-book2-go/qcdxkmsuc7280.mbn";
+};
+
+&i2c0 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	/* SSTP0001 */
+	touchpad@40 {
+		compatible = "hid-over-i2c";
+		reg = <0x40>;
+		hid-descr-addr = <0x0e>;
+
+		interrupts-extended = <&tlmm 51 IRQ_TYPE_LEVEL_LOW>;
+
+		vdd-supply = <&vreg_l7c_3p0>;
+		vddl-supply = <&vreg_l18b_1p8>;
+
+		post-power-on-delay-ms = <2>;
+
+		pinctrl-0 = <&hid_touchpad_default>;
+		pinctrl-names = "default";
+
+		wakeup-source;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+
+	/* A96T396 Proximity @ 0x20 & 0x21 ? */
+};
+
+&i2c4 {
+	status = "okay";
+
+	/* LIS2DLC12 Accelerometer @ 0x1d ? */
+};
+
+&i2c9 {
+	status = "okay";
+
+	/* A96T396 Proximity @ 0x20 ? */
+};
+
+&i2c10 {
+	status = "okay";
+
+	/* ? @ 0x09 */
+
+	battery@b {
+		compatible = "sbs,sbs-battery";
+		reg = <0x0b>;
+	};
+};
+
+&i2c12 {
+	clock-frequency = <100000>;
+
+	status = "okay";
+
+	/* SSEC0001 */
+	keyboard@5 {
+		compatible = "hid-over-i2c";
+		reg = <0x5>;
+		hid-descr-addr = <0x20>;
+
+		interrupts-extended = <&tlmm 131 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-0 = <&hid_keyboard_default>;
+		pinctrl-names = "default";
+
+		wakeup-source;
+	};
+};
+
+&i2c14 {
+	status = "okay";
+
+	/* EC2 (?) @ 0x62 */
+};
+
+&ipa {
+	firmware-name = "qcom/sc7280/Samsung/galaxy-book2-go/ipa_fws.elf";
+
+	status = "okay";
+};
+
+&mdss {
+	status = "okay";
+};
+
+&mdss_edp {
+	status = "okay";
+
+	aux-bus {
+		edp_panel: panel {
+			compatible = "edp-panel";
+
+			power-supply = <&vreg_edp_3p3>;
+			backlight = <&pm8350c_pwm_backlight>;
+
+			port {
+				edp_panel_in: endpoint {
+					remote-endpoint = <&mdss_edp_out>;
+				};
+			};
+		};
+	};
+};
+
+&mdss_edp_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+	remote-endpoint = <&edp_panel_in>;
+};
+
+&mdss_edp_phy {
+	vdda-pll-supply = <&vreg_l10c_0p8>;
+	vdda-phy-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
+&pm8350c_gpios {
+	pmic_lcd_bl_en: pmic-lcd-bl-en-state {
+		pins = "gpio7";
+		function = "normal";
+		bias-disable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		output-low;
+		power-source = <0>;
+	};
+
+	pmic_lcd_bl_pwm: pmic-lcd-bl-pwm-state {
+		pins = "gpio8";
+		function = "func1";
+		bias-disable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
+		output-low;
+		power-source = <0>;
+	};
+};
+
+&pm8350c_pwm {
+	pinctrl-0 = <&pmic_lcd_bl_pwm>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	multi-led {
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		led@1 {
+			reg = <1>;
+			color = <LED_COLOR_ID_RED>;
+		};
+
+		led@2 {
+			reg = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+		};
+
+		led@3 {
+			reg = <3>;
+			color = <LED_COLOR_ID_BLUE>;
+		};
+	};
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sc7280/Samsung/galaxy-book2-go/qcadsp7280.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp {
+	firmware-name = "qcom/sc7280/Samsung/galaxy-book2-go/qccdsp7280.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/sc7280/Samsung/galaxy-book2-go/qcmpss7280.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_wpss {
+	firmware-name = "qcom/sc7280/Samsung/galaxy-book2-go/wpss.mbn";
+
+	status = "okay";
+};
+
+&sdc2_clk {
+	drive-strength = <16>;
+	bias-disable;
+};
+
+&sdc2_cmd {
+	drive-strength = <10>;
+	bias-pull-up;
+};
+
+&sdc2_data {
+	drive-strength = <10>;
+	bias-pull-up;
+};
+
+&sdhc_2 {
+	vmmc-supply = <&vreg_l9c_2p9>;
+	vqmmc-supply = <&vreg_l6c_2p9>;
+
+	pinctrl-0 = <&sdc2_clk>, <&sdc2_cmd>, <&sdc2_data>;
+	pinctrl-1 = <&sdc2_clk_sleep>, <&sdc2_cmd_sleep>, <&sdc2_data_sleep>;
+
+	status = "okay";
+};
+
+&tlmm {
+	qup_uart7_sleep_cts: qup-uart7-sleep-cts-state {
+		pins = "gpio28";
+		function = "gpio";
+		/*
+		 * Configure a bias-bus-hold on CTS to lower power
+		 * usage when Bluetooth is turned off. Bus hold will
+		 * maintain a low power state regardless of whether
+		 * the Bluetooth module drives the pin in either
+		 * direction or leaves the pin fully unpowered.
+		 */
+		bias-bus-hold;
+	};
+
+	qup_uart7_sleep_rts: qup-uart7-sleep-rts-state {
+		pins = "gpio29";
+		function = "gpio";
+		/*
+		 * Configure pull-down on RTS. As RTS is active low
+		 * signal, pull it low to indicate the BT SoC that it
+		 * can wakeup the system anytime from suspend state by
+		 * pulling RX low (by sending wakeup bytes).
+		 */
+		bias-pull-down;
+	};
+
+	qup_uart7_sleep_tx: qup-uart7-sleep-tx-state {
+		pins = "gpio30";
+		function = "gpio";
+		/*
+		 * Configure pull-up on TX when it isn't actively driven
+		 * to prevent BT SoC from receiving garbage during sleep.
+		 */
+		bias-pull-up;
+	};
+
+	qup_uart7_sleep_rx: qup-uart7-sleep-rx-state {
+		pins = "gpio31";
+		function = "gpio";
+		/*
+		 * Configure a pull-up on RX. This is needed to avoid
+		 * garbage data when the TX pin of the Bluetooth module
+		 * is floating which may cause spurious wakeups.
+		 */
+		bias-pull-up;
+	};
+
+	hall_int_default: hall-int-state {
+		pins = "gpio35";
+		function = "gpio";
+		bias-disable;
+	};
+
+	hid_touchpad_default: hid-touchpad-default-state {
+		pins = "gpio61";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	bluetooth_enable_default: bluetooth-enable-default-state {
+		pins = "gpio85";
+		function = "gpio";
+		output-low;
+		bias-disable;
+	};
+
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio86";
+		function = "gpio";
+		bias-pull-down;
+	};
+
+	edp_reg_en: edp-reg-en-state {
+		pins = "gpio96";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+	};
+
+	hid_keyboard_default: hid-keyboard-default-state {
+		pins = "gpio131";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
+&uart7 {
+	/delete-property/interrupts;
+	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
+			      <&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
+
+	pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>, <&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;
+	pinctrl-names = "default", "sleep";
+
+	status = "okay";
+
+	bluetooth: bluetooth {
+		compatible = "qcom,wcn6750-bt";
+
+		pinctrl-0 = <&bluetooth_enable_default>, <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_l19b_1p8>;
+		vddaon-supply = <&vreg_s7b_0p9>;
+		vddbtcxmx-supply = <&vreg_s7b_0p9>;
+		vddrfacmn-supply = <&vreg_s7b_0p9>;
+		vddrfa0p8-supply = <&vreg_s7b_0p9>;
+		vddrfa1p7-supply = <&vreg_s1b_1p8>;
+		vddrfa1p2-supply = <&vreg_s8b_1p2>;
+
+		max-speed = <3200000>;
+	};
+};
+
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l7b_2p9>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l9b_1p2>;
+	vccq-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l10c_0p8>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
+&usb_1 {
+	dr_mode = "host";
+
+	status = "okay";
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l10c_0p8>;
+	vdda33-supply = <&vreg_l2b_3p0>;
+	vdda18-supply = <&vreg_l1c_1p8>;
+	qcom,hs-rise-fall-time-bp = <0>;
+	qcom,squelch-detector-bp = <(-2090)>;
+	qcom,hs-disconnect-bp = <1743>;
+	qcom,hs-amplitude-bp = <1780>;
+	qcom,hs-crossover-voltage-microvolt = <(-31000)>;
+	qcom,hs-output-impedance-micro-ohms = <2600000>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l6b_1p2>;
+	vdda-pll-supply = <&vreg_l1b_0p8>;
+
+	status = "okay";
+};
+
+&venus {
+	firmware-name = "qcom/sc7280/Samsung/galaxy-book2-go/qcvss7280.mbn";
+
+	status = "okay";
+};
+
+&wifi {
+	status = "okay";
+};

-- 
2.56.0

