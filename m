Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DA606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NH6Jy6oK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E0D10FCC0;
	Wed, 18 Nov 2026 13:47:10 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABFEC10F645
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:39:52 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so23637505e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919191; x=1795523991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0qh6b8xWE5s4NSuahM9vcqi/jo2yZx4jTaD46fezOa4=;
 b=NH6Jy6oKjjLRyboJzLeDUiVGbpQyEujq5GzKS2XYh9Q3yJBJ/7E72++0aPqm8kGSt3
 tI+pT/0jTST/1sP3h3RQIosrUlrXEXCepJQkikbrDJFC7TTfx2CTUPd0WMF2rcPAYLHC
 DQiQLdOdeHNkQrdfnQTpEYr4i3etL8D4a/QePkKagmjANdvCO9ya+DmBAzOBVla6FhDF
 mFnMmhZ5k6nDNCbnTbIYZ6jyubJhdOYIjRjTFFuYgAt/qwzrz6ijagy+ZDLUsQ+zpwGe
 QtzH5INSeID73N7zfCtU0itAE+Kq5qXrlx+DTDeVfVEvH6GG1DVvFc4b7OVitNpsN2kk
 WtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919191; x=1795523991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0qh6b8xWE5s4NSuahM9vcqi/jo2yZx4jTaD46fezOa4=;
 b=EFHTTyIA+inuOpezOHKjJiBu4LGe3ZOQaKsAXbMEPoMz1IJai/ML/AhGmD1TB47G/Q
 WEb3vTzySdnmNvavOdVuYOIYQCztZLbv8NTjOIAvTj60eZ0IxksEnrt73fPq2XeTqphy
 ub76eypy4GyVIFnW+Oht35KwtTX+iMu3cgOpN1Glzv86k3Sf13AKtYYxJFZ2xYtD1kig
 kurDm4QHXnqVAtp/s04d0/kZOpbZBMmHztf0nFMZlZjIwXDiQDIuw8/IaxEXVkpkVD6q
 t9geqgDK+Ffi/C0zjdohifB+jBsYtEGHkDGou6qW02elL+zEFp4t3Y+CYz/aSpbOVA4q
 kTvQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGCzDeGW/J9OuIyqiPpbrb3d6BEA/am2K/yFLvglyM2qtao212ptcJX1t1fvonk+oSZm1vA5Ht1etw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9pAGsYSHAnf4YIpiZS6G0SCI4smpSLjX7SlKHwwg0CY/VJ1wKL
 VjS+e/Frh98FD9avd6eXk1yeDA5vKSqioxDqwxpTjiOuX8vlsP50QiS8
X-Gm-Gg: AYBFou1PFtJoniFkdV3Nec3NNdXtuo5V0ETMD9ztl49tLroDV98nFJ5cPKaFePFWTYa
 aZ/oCgob3mcXMlV6gLCm/bfr6SrMJJjrchZL4IhoOI9JA9617aihqymkRBaaumT1RZXTTh7WDs4
 ex+9JlAsoMmBY6EmlNkL8q3onC8zxQUb2XEPOdGouFZ1iVoSLhjMRcphB4m7g7VGBnSAAVQ20vP
 a16aoqTTVR7FWR608QETGSIRvUzs06lQlHp7kYWCJt7HS8GGdbYCpFbCGDBEfeQ3QfQkrZO04tt
 3wXs5geyS6W2+A0k1EMqSnn3+ckqebqzLA3vul5slx5K1UKGvC4wIA+UEegTF+ZCTtDdygQOYTt
 6Je2SzTa04g+HIgyYK59hZQ4ad0gC2c3rL6UqLrBZYMbilAYOQI8hSUBTQi2Nw3NlkWvO5AJ89z
 IhrzLIl4fZB3hEY+N/E/BFuuZKPIAWm3AMRKmfqlUYQo95zxOT/eAWMSrmhSAtB7EiCndeI7GU0
 W2Bt8qw31BAXOUVlBmW2oDj8Z0RfxXBxIfStxUSUVfFsriq/fpYND42C7BtCj2/V2S/cwqCa2Sp
 OQdSpdHeEj1W1OW6huIZEuVCUEVjW6qr2N1Mw8Ok+55eooO9z+NboaFbAytXvdDbAxk6/A==
X-Received: by 2002:a05:600c:4752:b0:4a3:59c9:a754 with SMTP id
 5b1f17b1804b1-4bb55ab2b89mr286218165e9.22.1794919190906; 
 Tue, 17 Nov 2026 04:39:50 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu.
 [94.21.223.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:39:50 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 02/11] arm64: dts: qcom: add LG V60 ThinQ 5G (timelm)
 support
Date: Tue, 17 Nov 2026 13:39:37 +0100
Message-Id: <20261117123946.668557-3-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 13:47:08 +0000
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add initial support for the LG V60 ThinQ 5G (timelm), based on the
Qualcomm SM8250 SoC.

Describe the memory layout, PMIC regulators, buttons, serial console,
UFS, SD card, and USB.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 MAINTAINERS                                   |   6 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../arm64/boot/dts/qcom/sm8250-lge-timelm.dts | 543 ++++++++++++++++++
 3 files changed, 550 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index ccbcdc0799b9f..315a4a000b405 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15231,6 +15231,12 @@ Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/mkrufky/tuners.git
 F:	drivers/media/dvb-frontends/lgdt3305.*
 
+LG V60 THINQ 5G (TIMELM) SUPPORT
+M:	rofikkerneldev <rofikcoga@gmail.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	arch/arm64/boot/dts/qcom/sm8250-lge-timelm*
+
 LIBATA PATA ARASAN COMPACT FLASH CONTROLLER
 M:	Viresh Kumar <vireshk@kernel.org>
 L:	linux-ide@vger.kernel.org
diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 88230c4e00ea9..91c9d95696f2a 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -409,6 +409,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-bahamut.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-griffin.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-lge-timelm.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-samsung-r8q.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-samsung-x1q.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
new file mode 100644
index 0000000000000..74b673ebbeb9d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8250-lge-timelm.dts
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2026 rofikkerneldev <rofikcoga@gmail.com>
+ * Device Tree for LG V60 ThinQ 5G (timelm / LM-V600)
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/phy/phy.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+#include <dt-bindings/usb/pd.h>
+#include "sm8250.dtsi"
+#include "pm8150.dtsi"
+#include "pm8150b.dtsi"
+#include "pm8150l.dtsi"
+#include "pm8009.dtsi"
+
+/*
+ * Delete upstream reserved-memory nodes that differ on LG V60.
+ */
+/delete-node/ &adsp_mem;
+/delete-node/ &spss_mem;
+/delete-node/ &cdsp_secure_heap;
+
+/ {
+	model = "LG V60 ThinQ 5G";
+	compatible = "lge,timelm", "qcom,sm8250";
+	chassis-type = "handset";
+
+	aliases {
+		serial0 = &uart12;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		framebuffer: framebuffer@9c000000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x9c000000 0 0x1200000>;
+			width = <1080>;
+			height = <2460>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+			clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&gcc GCC_DISP_SF_AXI_CLK>,
+				 <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
+				 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+				 <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
+				 <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
+				 <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
+				 <&dispcc DISP_CC_MDSS_ESC0_CLK>;
+			power-domains = <&dispcc MDSS_GDSC>;
+		};
+	};
+
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <4900000>;
+		energy-full-design-microwatt-hours = <18800000>;
+		voltage-min-design-microvolt = <3400000>;
+		voltage-max-design-microvolt = <4450000>;
+	};
+
+	gpio_keys: gpio-keys {
+		compatible = "gpio-keys";
+
+		pinctrl-0 = <&vol_up_n &hot1_key_n>;
+		pinctrl-names = "default";
+
+		key-vol-up {
+			label = "Volume Up";
+			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+
+		key-assistant {
+			label = "Google Assistant";
+			gpios = <&pm8150_gpios 1 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_ASSISTANT>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	reserved-memory {
+		ramoops: ramoops@b0000000 {
+			compatible = "ramoops";
+			reg = <0x0 0xb0000000 0x0 0x280000>;
+			record-size = <0x1000>;
+			console-size = <0x40000>;
+			ftrace-size = <0x40000>;
+			pmsg-size = <0x200000>;
+		};
+
+		adsp_mem: memory@8a100000 {
+			reg = <0x0 0x8a100000 0x0 0x2500000>;
+			no-map;
+		};
+
+		spss_mem: memory@8c600000 {
+			reg = <0x0 0x8c600000 0x0 0x100000>;
+			no-map;
+		};
+
+		cdsp_secure_heap: memory@8c700000 {
+			reg = <0x0 0x8c700000 0x0 0x4600000>;
+			no-map;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	/* S6c is really ebi.lvl but it's there for supply map completeness sake. */
+	vreg_s6c_0p88: smpc6-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s6c_0p88";
+		regulator-min-microvolt = <880000>;
+		regulator-max-microvolt = <880000>;
+		regulator-always-on;
+		vin-supply = <&vph_pwr>;
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+		vdd-l1-l8-l11-supply = <&vreg_s6c_0p88>;
+		vdd-l2-l10-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s6a_0p6>;
+		vdd-l6-l9-supply = <&vreg_s8c_1p2>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_1p9>;
+		vdd-l13-l16-l17-supply = <&vreg_bob>;
+
+		vreg_s4a_1p8: smps4 {
+			regulator-name = "vreg_s4a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s5a_1p9: smps5 {
+			regulator-name = "vreg_s5a_1p9";
+			regulator-min-microvolt = <1824000>;
+			regulator-max-microvolt = <2040000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s6a_0p6: smps6 {
+			regulator-name = "vreg_s6a_0p6";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1128000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2a_3p1: ldo2 {
+			regulator-name = "vreg_l2a_3p1";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3a_0p9: ldo3 {
+			regulator-name = "vreg_l3a_0p9";
+			regulator-min-microvolt = <928000>;
+			regulator-max-microvolt = <932000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5a_0p88: ldo5 {
+			regulator-name = "vreg_l5a_0p88";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6a_1p2: ldo6 {
+			regulator-name = "vreg_l6a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9a_1p2: ldo9 {
+			regulator-name = "vreg_l9a_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-name = "vreg_l12a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-name = "vreg_l14a_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l17a_3p0: ldo17 {
+			regulator-name = "vreg_l17a_3p0";
+			regulator-min-microvolt = <2496000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l18a_0p9: ldo18 {
+			regulator-name = "vreg_l18a_0p9";
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <920000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8150l-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-l1-l8-supply = <&vreg_s4a_1p8>;
+		vdd-l2-l3-supply = <&vreg_s8c_1p2>;
+		vdd-l4-l5-l6-supply = <&vreg_bob>;
+		vdd-l7-l11-supply = <&vreg_bob>;
+		vdd-l9-l10-supply = <&vreg_bob>;
+		vdd-bob-supply = <&vph_pwr>;
+
+		vreg_bob: bob {
+			regulator-name = "vreg_bob";
+			regulator-min-microvolt = <3350000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
+
+		vreg_s7c_0p35: smps7 {
+			regulator-name = "vreg_s7c_0p35";
+			regulator-min-microvolt = <348000>;
+			regulator-max-microvolt = <1000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s8c_1p2: smps8 {
+			regulator-name = "vreg_s8c_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1400000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-name = "vreg_l1c_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3c_1p2: ldo3 {
+			regulator-name = "vreg_l3c_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5c_1p8: ldo5 {
+			regulator-name = "vreg_l5c_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6c_2p9: ldo6 {
+			regulator-name = "vreg_l6c_2p9";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7c_2p85: ldo7 {
+			regulator-name = "vreg_l7c_2p85";
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-name = "vreg_l8c_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9c_2p9: ldo9 {
+			regulator-name = "vreg_l9c_2p9";
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-allowed-modes = <RPMH_REGULATOR_MODE_LPM
+						   RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-name = "vreg_l10c_3p3";
+			regulator-min-microvolt = <3296000>;
+			regulator-max-microvolt = <3296000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l11c_3p0: ldo11 {
+			regulator-name = "vreg_l11c_3p0";
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3000000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pm8009-rpmh-regulators";
+		qcom,pmic-id = "f";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vreg_bob>;
+		vdd-l2-supply = <&vreg_s8c_1p2>;
+		vdd-l5-l6-supply = <&vreg_bob>;
+		vdd-l7-supply = <&vreg_s4a_1p8>;
+
+		vreg_s1f_1p2: smps1 {
+			regulator-name = "vreg_s1f_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_s2f_0p5: smps2 {
+			regulator-name = "vreg_s2f_0p5";
+			regulator-min-microvolt = <512000>;
+			regulator-max-microvolt = <1100000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2f_1p3: ldo2 {
+			regulator-name = "vreg_l2f_1p3";
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4f_1p05: ldo4 {
+			regulator-name = "vreg_l4f_1p05";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1050000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5f_2p8: ldo5 {
+			regulator-name = "vreg_l5f_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6f_2p8: ldo6 {
+			regulator-name = "vreg_l6f_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7f_1p8: ldo7 {
+			regulator-name = "vreg_l7f_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&cdsp {
+	status = "okay";
+};
+
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
+&gpi_dma2 {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		memory-region = <&gpu_mem>;
+		firmware-name = "qcom/sm8250/a650_zap.mbn";
+	};
+};
+
+&pm8150_gpios {
+	hot1_key_n: hot1-key-n-state {
+		pins = "gpio1";
+		function = "normal";
+		bias-pull-up;
+		input-enable;
+		power-source = <0>;
+	};
+
+	vol_up_n: vol-up-n-state {
+		pins = "gpio6";
+		function = "normal";
+		bias-pull-up;
+		input-enable;
+		power-source = <0>;
+	};
+};
+
+&pon {
+	mode-bootloader = <0x2>;
+	mode-recovery = <0x1>;
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	status = "okay";
+	linux,code = <KEY_VOLUMEDOWN>;
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
+&qupv3_id_2 {
+	status = "okay";
+};
+
+&uart12 {
+	status = "okay";
+};
+
+&ufs_mem_hc {
+	status = "okay";
+
+	vcc-supply = <&vreg_l17a_3p0>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l6a_1p2>;
+	vccq-max-microamp = <800000>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vccq2-max-microamp = <800000>;
+};
+
+&ufs_mem_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l5a_0p88>;
+	vdda-pll-supply = <&vreg_l9a_1p2>;
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	cd-gpios = <&tlmm 77 GPIO_ACTIVE_LOW>;
+	vmmc-supply = <&vreg_l9c_2p9>;
+	vqmmc-supply = <&vreg_l6c_2p9>;
+	bus-width = <4>;
+	no-sdio;
+	no-mmc;
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "peripheral";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+
+	vdda-pll-supply = <&vreg_l5a_0p88>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l2a_3p1>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l9a_1p2>;
+	vdda-pll-supply = <&vreg_l18a_0p9>;
+};
-- 
2.39.5

