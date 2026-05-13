Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA87DCD37AC
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B4810EFC7;
	Wed, 13 May 2026 17:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p6QXzazJ";
	dkim-atps=neutral
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07F7C10EFC7
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:24:57 +0000 (UTC)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-8b5cda2dab9so65551506d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778693097; x=1779297897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHO4x4lOdCDMJON6jMB2kxg3vzW5UNVYFHF/b3xHCUg=;
 b=p6QXzazJqD4wuLMR6PhfGF4vGMs7eRSE5JJ8bbd277e9WU9w9Z7lBXToHZbyz2CsVL
 D/Acn8b5vLxc8tczClGOB0LgGdV2ItE09R8IdCIa69j4iZHoMcdn9UjaY9E3PNySEiFz
 pOV4aPVC1k73Gk1/BxWplrX+H6Fe4A8ioo8Vpfw2d0juxNQXcB5O1zYm7jVh7MTMUW1Y
 nMVHBmN3bIXMfzm2Y1qZfe4ebWIX6/JdEwYzUlyB7/f1M0kHTT0C0Izm86cocJIgcW0m
 TMZMlSx/ZqdR7VueLKYX9+L8OcCPOC1qaNKIKCr7bKAomECLh2Tv0bYMd8/b6lowHtxo
 EL6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778693097; x=1779297897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AHO4x4lOdCDMJON6jMB2kxg3vzW5UNVYFHF/b3xHCUg=;
 b=ijW1bVhwKUpUB3tvmoARKE7MIeEmJdfnb/eL2F0RlfNnxppS9wUBbzjT6erOBUkzD9
 UW4Y6KzcXYJsytQIFdxnnRUavUm7nnmocgrUmvi2BiaMsRZJ6OfgkijzMaUaBxPD0bR7
 pEUs0To5e7CxuvqbkiDe/3uJReG6g8gy9f0LwRy87HUKzixhKpu6LFqDa1viQuJPNkU/
 EjOTzkyZmtf/WrLN+vyw79WqThu4ISfLAQMrPVpxvd6mpgnhNBPySzPsMH3Dk8z09yXr
 1O5Qzr2GCUGYQdTl5sBWKXLACxcNB2FCovWilSdwnnQlqJZ56UJFdRBar4N7maSvMvGd
 t7hg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GaJOBO3Zvd6zHPeWBsSfwNPmTnQMJCPTD0C+9RBQPUS8WChUZ5e/jO1StoXr22IoxA3fMd/rzBDI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhbP0+sy5BxW9m9OrYhExCGPEltzPYyU8EABOVhGSyku8sbap/
 lT5e1Oqas4CXUrwJIgNltuaeamDgMmZkdx/aBovWCdPlqBRfoiTHpV8n
X-Gm-Gg: Acq92OExEcqubCrnGG4S4Fm9vR7HXPKdjtZF478xxQBK/10+o1LDxVcWbRkgdiCp4Xc
 qysSmMCn/gwowIux9et7ONrO/TJPGOZLEYVQUTNrBg53nyr08pTgcbFeLceQMDLM/cemTiSfl2Y
 donh/0hgzpyVImDSrTt5ve9f4pU9S5WFjJ7inczozVSR3O2PCthuwTqEw8IIxemU+Sjxaau2R97
 U0JXDGg09Bg6Yip0d2EUt5tsCEKrvjOxbJJoPoZWmYBX2XzRnKZxL2pQ2F3bCnyc9MmS/v6PGMR
 8gH9zA7xW9AMVcLg45uS3xpla3Ip7gHOiLpy0Ld4qHR3C4k0RiMqJEo00fWI00VcRbiCJVSklXX
 smc+e+fp8AF1cXSEjoUVg68Vmj+NYJ0V0FKI5s79nu2L/07UgcOFQadTH0VXBxOpKK31BkdgPAv
 5Tcp5g7YFL5V9hWrGkFBPGc2EOvA==
X-Received: by 2002:a05:6214:508e:b0:89c:5a3f:15a4 with SMTP id
 6a1803df08f44-8c8fdff1f09mr6218176d6.24.1778693096835; 
 Wed, 13 May 2026 10:24:56 -0700 (PDT)
Received: from localhost ([142.181.178.53]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c908d1d2cfsm1501436d6.15.2026.05.13.10.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:24:56 -0700 (PDT)
From: Richard Acayan <mailingradian@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 dri-devel@lists.freedesktop.org, Yifei Zhan <yifei@zhan.science>,
 Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v4 1/2] arm64: dts: qcom: sdm670-google: add common device
 tree include
Date: Wed, 13 May 2026 13:25:48 -0400
Message-ID: <20260513172549.1345-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513172549.1345-1-mailingradian@gmail.com>
References: <20260513172549.1345-1-mailingradian@gmail.com>
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

The Pixel 3a XL can be supported by reusing most of the device tree from
the Pixel 3a. Move the common elements to a common device tree include
like with other devices.

Since the original devicetree should only specify non-XL properties, it
needs to be completely rewritten. Also change the SPDX license
identifier from GPL-2.0 (which was deprecated as it can be
misinterpreted as GPLv2 or later) into GPL-2.0-only.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Assisted-by: "Claude Code Review Bot":claude-opus-4-6
---
 ...le-sargo.dts => sdm670-google-common.dtsi} |  22 +-
 .../boot/dts/qcom/sdm670-google-sargo.dts     | 714 +-----------------
 2 files changed, 20 insertions(+), 716 deletions(-)
 copy arch/arm64/boot/dts/qcom/{sdm670-google-sargo.dts => sdm670-google-common.dtsi} (97%)

diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts b/arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi
similarity index 97%
copy from arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
copy to arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi
index eba2f3792dd0..0f57b915186b 100644
--- a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
+++ b/arch/arm64/boot/dts/qcom/sdm670-google-common.dtsi
@@ -6,8 +6,6 @@
  * Copyright (c) 2022, Richard Acayan. All rights reserved.
  */
 
-/dts-v1/;
-
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/leds/common.h>
@@ -28,9 +26,6 @@
 /delete-node/ &gpu_mem;
 
 / {
-	model = "Google Pixel 3a";
-	compatible = "google,sargo", "qcom,sdm670";
-
 	aliases { };
 
 	battery: battery {
@@ -38,7 +33,6 @@ battery: battery {
 
 		voltage-min-design-microvolt = <3312000>;
 		voltage-max-design-microvolt = <4400000>;
-		charge-full-design-microamp-hours = <3000000>;
 	};
 
 	chosen {
@@ -48,11 +42,11 @@ chosen {
 		#size-cells = <2>;
 		ranges;
 
-		framebuffer@9c000000 {
+		framebuffer: framebuffer@9c000000 {
 			compatible = "simple-framebuffer";
-			reg = <0 0x9c000000 0 (1080 * 2220 * 4)>;
+			memory-region = <&fb_mem>;
 			width = <1080>;
-			height = <2220>;
+			/* height is in specific device trees */
 			stride = <(1080 * 4)>;
 			format = "a8r8g8b8";
 		};
@@ -121,7 +115,7 @@ gpu_mem: gpu@97a15000 {
 			no-map;
 		};
 
-		framebuffer-region@9c000000 {
+		fb_mem: framebuffer-region@9c000000 {
 			reg = <0 0x9c000000 0 0x2400000>;
 			no-map;
 		};
@@ -521,10 +515,8 @@ rmi4-f01@1 {
 			syna,nosleep-mode = <1>;
 		};
 
-		rmi4-f12@12 {
+		rmi4_f12: rmi4-f12@12 {
 			reg = <0x12>;
-			touchscreen-x-mm = <62>;
-			touchscreen-y-mm = <127>;
 			syna,sensor-type = <1>;
 		};
 	};
@@ -538,8 +530,8 @@ &mdss_dsi0 {
 	vdda-supply = <&vreg_l1a_1p225>;
 	status = "okay";
 
-	panel@0 {
-		compatible = "samsung,s6e3fa7-ams559nk06";
+	panel: panel@0 {
+		/* compatible is provided in specific device trees */
 		reg = <0>;
 
 		reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
index eba2f3792dd0..c67a0396436b 100644
--- a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
+++ b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
@@ -1,720 +1,32 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-only
 /*
- * Device tree for Google Pixel 3a, adapted from google-blueline device tree,
- * xiaomi-lavender device tree, and oneplus-common device tree.
+ * Device tree for Google Pixel 3a (non-XL).
  *
- * Copyright (c) 2022, Richard Acayan. All rights reserved.
+ * Copyright (c) Richard Acayan. All rights reserved.
  */
 
 /dts-v1/;
 
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
-#include <dt-bindings/power/qcom-rpmpd.h>
-#include "sdm670.dtsi"
-#include "pm660.dtsi"
-#include "pm660l.dtsi"
-
-/delete-node/ &mpss_region;
-/delete-node/ &venus_mem;
-/delete-node/ &wlan_msa_mem;
-/delete-node/ &cdsp_mem;
-/delete-node/ &mba_region;
-/delete-node/ &adsp_mem;
-/delete-node/ &ipa_fw_mem;
-/delete-node/ &ipa_gsi_mem;
-/delete-node/ &gpu_mem;
+#include "sdm670-google-common.dtsi"
 
 / {
 	model = "Google Pixel 3a";
 	compatible = "google,sargo", "qcom,sdm670";
-
-	aliases { };
-
-	battery: battery {
-		compatible = "simple-battery";
-
-		voltage-min-design-microvolt = <3312000>;
-		voltage-max-design-microvolt = <4400000>;
-		charge-full-design-microamp-hours = <3000000>;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-
-		#address-cells = <2>;
-		#size-cells = <2>;
-		ranges;
-
-		framebuffer@9c000000 {
-			compatible = "simple-framebuffer";
-			reg = <0 0x9c000000 0 (1080 * 2220 * 4)>;
-			width = <1080>;
-			height = <2220>;
-			stride = <(1080 * 4)>;
-			format = "a8r8g8b8";
-		};
-	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		autorepeat;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&vol_up_pin>;
-
-		key-vol-up {
-			label = "Volume Up";
-			linux,code = <KEY_VOLUMEUP>;
-			gpios = <&pm660l_gpios 7 GPIO_ACTIVE_LOW>;
-		};
-	};
-
-	reserved-memory {
-		#address-cells = <2>;
-		#size-cells = <2>;
-
-		mpss_region: mpss@8b000000 {
-			reg = <0 0x8b000000 0 0x9800000>;
-			no-map;
-		};
-
-		venus_mem: venus@94800000 {
-			reg = <0 0x94800000 0 0x500000>;
-			no-map;
-		};
-
-		wlan_msa_mem: wlan-msa@94d00000 {
-			reg = <0 0x94d00000 0 0x100000>;
-			no-map;
-		};
-
-		cdsp_mem: cdsp@94e00000 {
-			reg = <0 0x94e00000 0 0x800000>;
-			no-map;
-		};
-
-		mba_region: mba@95600000 {
-			reg = <0 0x95600000 0 0x200000>;
-			no-map;
-		};
-
-		adsp_mem: adsp@95800000 {
-			reg = <0 0x95800000 0 0x2200000>;
-			no-map;
-		};
-
-		ipa_fw_mem: ipa-fw@97a00000 {
-			reg = <0 0x97a00000 0 0x10000>;
-			no-map;
-		};
-
-		ipa_gsi_mem: ipa-gsi@97a10000 {
-			reg = <0 0x97a10000 0 0x5000>;
-			no-map;
-		};
-
-		gpu_mem: gpu@97a15000 {
-			reg = <0 0x97a15000 0 0x2000>;
-			no-map;
-		};
-
-		framebuffer-region@9c000000 {
-			reg = <0 0x9c000000 0 0x2400000>;
-			no-map;
-		};
-
-		/* Also includes ramoops regions */
-		debug_info_mem: debug-info@a1800000 {
-			reg = <0 0xa1800000 0 0x411000>;
-			no-map;
-		};
-	};
-
-	/*
-	 * The touchscreen regulator seems to be controlled somehow by a gpio.
-	 * Model it as a fixed regulator and keep it on. Without schematics we
-	 * don't know how this is actually wired up...
-	 */
-	ts_1p8_supply: ts-1p8-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "ts_1p8_supply";
-
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-
-		gpio = <&pm660_gpios 12 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-	};
-
-	vph_pwr: vph-pwr-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vph_pwr";
-		regulator-min-microvolt = <3312000>;
-		regulator-max-microvolt = <3312000>;
-
-		regulator-always-on;
-		regulator-boot-on;
-	};
-
-	/*
-	 * Supply map from xiaomi-lavender specifies this as the supply for
-	 * ldob1, ldob9, ldob10, ldoa2, and ldoa3, while downstream specifies
-	 * this as a power domain. Set this as a fixed regulator with the same
-	 * voltage as lavender until display is needed to avoid unneccessarily
-	 * using a deprecated binding (regulator-fixed-domain).
-	 */
-	vreg_s2b_1p05: vreg-s2b-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "vreg_s2b";
-		regulator-min-microvolt = <1050000>;
-		regulator-max-microvolt = <1050000>;
-	};
-
-	cam_front_ldo: cam-front-ldo-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "cam_front_ldo";
-		regulator-min-microvolt = <1352000>;
-		regulator-max-microvolt = <1352000>;
-		regulator-enable-ramp-delay = <135>;
-
-		gpios = <&pm660l_gpios 4 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-
-		pinctrl-0 = <&cam_front_ldo_pin>;
-		pinctrl-names = "default";
-	};
-
-	cam_vio_ldo: cam-vio-ldo-regulator {
-		compatible = "regulator-fixed";
-		regulator-name = "cam_vio_ldo";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-		regulator-enable-ramp-delay = <233>;
-
-		gpios = <&pm660_gpios 13 GPIO_ACTIVE_HIGH>;
-		enable-active-high;
-
-		pinctrl-0 = <&cam_vio_pin>;
-		pinctrl-names = "default";
-	};
-};
-
-&apps_rsc {
-	regulators-0 {
-		compatible = "qcom,pm660-rpmh-regulators";
-		qcom,pmic-id = "a";
-
-		vdd-s1-supply = <&vph_pwr>;
-		vdd-s2-supply = <&vph_pwr>;
-		vdd-s3-supply = <&vph_pwr>;
-		vdd-s4-supply = <&vph_pwr>;
-		vdd-s5-supply = <&vph_pwr>;
-		vdd-s6-supply = <&vph_pwr>;
-
-		vdd-l1-l6-l7-supply = <&vreg_s6a_0p87>;
-		vdd-l2-l3-supply = <&vreg_s2b_1p05>;
-		vdd-l5-supply = <&vreg_s2b_1p05>;
-		vdd-l8-l9-l10-l11-l12-l13-l14-supply = <&vreg_s4a_2p04>;
-		vdd-l15-l16-l17-l18-l19-supply = <&vreg_bob>;
-
-		/*
-		 * S1A (FTAPC0), S2A (FTAPC1), S3A (HFAPC1) are managed
-		 * by the Core Power Reduction hardened (CPRh) and the
-		 * Operating State Manager (OSM) HW automatically.
-		 */
-
-		vreg_s4a_2p04: smps4 {
-			regulator-min-microvolt = <1808000>;
-			regulator-max-microvolt = <2040000>;
-			regulator-enable-ramp-delay = <200>;
-		};
-
-		vreg_s6a_0p87: smps6 {
-			regulator-min-microvolt = <1224000>;
-			regulator-max-microvolt = <1352000>;
-			regulator-enable-ramp-delay = <150>;
-		};
-
-		/* LDOs */
-		vreg_l1a_1p225: ldo1 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1250000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l2a_1p0: ldo2 {
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1000000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l3a_1p0: ldo3 {
-			regulator-min-microvolt = <1000000>;
-			regulator-max-microvolt = <1000000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l5a_0p848: ldo5 {
-			regulator-min-microvolt = <800000>;
-			regulator-max-microvolt = <800000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l6a_1p3: ldo6 {
-			regulator-min-microvolt = <1248000>;
-			regulator-max-microvolt = <1304000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l7a_1p2: ldo7 {
-			regulator-min-microvolt = <1200000>;
-			regulator-max-microvolt = <1200000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l8a_1p8: ldo8 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-enable-ramp-delay = <250>;
-			regulator-always-on;
-		};
-
-		vreg_l9a_1p8: ldo9 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l10a_1p8: ldo10 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l11a_1p8: ldo11 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l12a_1p8: ldo12 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l13a_1p8: ldo13 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l14a_1p8: ldo14 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <1800000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l15a_1p8: ldo15 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2950000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l16a_2p7: ldo16 {
-			regulator-min-microvolt = <2696000>;
-			regulator-max-microvolt = <2696000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l17a_1p8: ldo17 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2950000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l19a_3p3: ldo19 {
-			regulator-min-microvolt = <3000000>;
-			regulator-max-microvolt = <3312000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-	};
-
-	regulators-1 {
-		compatible = "qcom,pm660l-rpmh-regulators";
-		qcom,pmic-id = "b";
-
-		vdd-s1-supply = <&vph_pwr>;
-		vdd-s2-supply = <&vph_pwr>;
-		vdd-s3-s4-supply = <&vph_pwr>;
-		vdd-s5-supply = <&vph_pwr>;
-
-		vdd-l1-l9-l10-supply = <&vreg_s2b_1p05>;
-		vdd-l2-supply = <&vreg_bob>;
-		vdd-l3-l5-l7-l8-supply = <&vreg_bob>;
-		vdd-l4-l6-supply = <&vreg_bob>;
-		vdd-bob-supply = <&vph_pwr>;
-
-		/* LDOs */
-		vreg_l1b_0p925: ldo1 {
-			regulator-min-microvolt = <880000>;
-			regulator-max-microvolt = <900000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l2b_2p95: ldo2 {
-			regulator-min-microvolt = <1800000>;
-			regulator-max-microvolt = <2960000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l3b_3p0: ldo3 {
-			regulator-min-microvolt = <2850000>;
-			regulator-max-microvolt = <3008000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l4b_2p95: ldo4 {
-			regulator-min-microvolt = <2960000>;
-			regulator-max-microvolt = <2960000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l5b_2p95: ldo5 {
-			regulator-min-microvolt = <2960000>;
-			regulator-max-microvolt = <2960000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l6b_3p3: ldo6 {
-			regulator-min-microvolt = <3008000>;
-			regulator-max-microvolt = <3300000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l7b_3p125: ldo7 {
-			regulator-min-microvolt = <3088000>;
-			regulator-max-microvolt = <3100000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		vreg_l8b_3p3: ldo8 {
-			regulator-min-microvolt = <3300000>;
-			regulator-max-microvolt = <3312000>;
-			regulator-enable-ramp-delay = <250>;
-		};
-
-		/*
-		 * Downstream specifies a fixed voltage of 3.312 V, but the
-		 * PMIC4 BOB ranges don't support that. Widen the range a
-		 * little to avoid adding a new BOB regulator type.
-		 */
-		vreg_bob: bob {
-			regulator-min-microvolt = <3296000>;
-			regulator-max-microvolt = <3328000>;
-			regulator-enable-ramp-delay = <500>;
-		};
-	};
-};
-
-&camss {
-	vdda-phy-supply = <&vreg_l1a_1p225>;
-	vdda-pll-supply = <&vreg_s6a_0p87>;
-
-	status = "okay";
-};
-
-&camss_port1 {
-	camss_endpoint1: endpoint {
-		data-lanes = <0 1 2 3>;
-		remote-endpoint = <&cam_front_endpoint>;
-	};
 };
 
-&cci {
-	pinctrl-0 = <&cci1_default>;
-	pinctrl-1 = <&cci1_sleep>;
-	pinctrl-names = "default", "sleep";
-
-	status = "okay";
-};
-
-&cci_i2c1 {
-	camera@1a {
-		compatible = "sony,imx355";
-		reg = <0x1a>;
-
-		clocks = <&camcc CAM_CC_MCLK2_CLK>;
-
-		/*
-		 * The sensor can accept a 24 MHz clock, but 19.2 MHz has
-		 * better driver compatibility.
-		 */
-		assigned-clocks = <&camcc CAM_CC_MCLK2_CLK>;
-		assigned-clock-rates = <19200000>;
-
-		reset-gpios = <&tlmm 9 GPIO_ACTIVE_LOW>;
-
-		avdd-supply = <&cam_front_ldo>;
-		dvdd-supply = <&cam_front_ldo>;
-		dovdd-supply = <&cam_vio_ldo>;
-
-		pinctrl-0 = <&cam_mclk2_default>;
-		pinctrl-names = "default";
-
-		rotation = <270>;
-		orientation = <0>;
-
-		port {
-			cam_front_endpoint: endpoint {
-				data-lanes = <1 2 3 4>;
-				link-frequencies = /bits/ 64 <360000000>;
-				remote-endpoint = <&camss_endpoint1>;
-			};
-		};
-	};
-};
-
-&gcc {
-	protected-clocks = <GCC_QSPI_CORE_CLK>,
-			   <GCC_QSPI_CORE_CLK_SRC>,
-			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>;
-};
-
-&gpi_dma1 {
-	status = "okay";
-};
-
-&gpu {
-	status = "okay";
-};
-
-&gpu_zap_shader {
-	firmware-name = "qcom/sdm670/sargo/a615_zap.mbn";
-};
-
-&i2c9 {
-	clock-frequency = <100000>;
-	status = "okay";
-
-	synaptics-rmi4-i2c@20 {
-		compatible = "syna,rmi4-i2c";
-		reg = <0x20>;
-		interrupts-extended = <&tlmm 125 IRQ_TYPE_EDGE_FALLING>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&touchscreen_default>;
-
-		vio-supply = <&ts_1p8_supply>;
-
-		syna,reset-delay-ms = <200>;
-		syna,startup-delay-ms = <200>;
-
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		rmi4-f01@1 {
-			reg = <0x01>;
-			syna,nosleep-mode = <1>;
-		};
-
-		rmi4-f12@12 {
-			reg = <0x12>;
-			touchscreen-x-mm = <62>;
-			touchscreen-y-mm = <127>;
-			syna,sensor-type = <1>;
-		};
-	};
-};
-
-&mdss {
-	status = "okay";
-};
-
-&mdss_dsi0 {
-	vdda-supply = <&vreg_l1a_1p225>;
-	status = "okay";
-
-	panel@0 {
-		compatible = "samsung,s6e3fa7-ams559nk06";
-		reg = <0>;
-
-		reset-gpios = <&tlmm 75 GPIO_ACTIVE_LOW>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&panel_default>;
-
-		power-supply = <&vreg_l6b_3p3>;
-
-		port {
-			panel_in: endpoint {
-				remote-endpoint = <&mdss_dsi0_out>;
-			};
-		};
-	};
-};
-
-&mdss_dsi0_out {
-	remote-endpoint = <&panel_in>;
-	data-lanes = <0 1 2 3>;
+&battery {
+	charge-full-design-microamp-hours = <3000000>;
 };
 
-&mdss_dsi0_phy {
-	vdds-supply = <&vreg_l1b_0p925>;
-	status = "okay";
+&framebuffer {
+	height = <2220>;
 };
 
-&mdss_mdp {
-	status = "okay";
+&panel {
+	compatible = "samsung,s6e3fa7-ams559nk06";
 };
 
-&pm660_charger {
-	monitored-battery = <&battery>;
-	status = "okay";
-};
-
-&pm660_gpios {
-	cam_vio_pin: cam-vio-state {
-		pins = "gpio13";
-		function = "normal";
-		power-source = <0>;
-	};
-};
-
-&pm660_rradc {
-	status = "okay";
-};
-
-&pm660l_flash {
-	status = "okay";
-
-	led-0 {
-		function = LED_FUNCTION_FLASH;
-		color = <LED_COLOR_ID_WHITE>;
-		led-sources = <1>, <2>;
-		led-max-microamp = <500000>;
-		flash-max-microamp = <1500000>;
-		flash-max-timeout-us = <1280000>;
-	};
-};
-
-&pm660l_gpios {
-	cam_front_ldo_pin: cam-front-state {
-		pins = "gpio4";
-		function = "normal";
-		power-source = <0>;
-	};
-
-	vol_up_pin: vol-up-state {
-		pins = "gpio7";
-		function = "normal";
-		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
-		input-enable;
-		bias-pull-up;
-	};
-};
-
-&pon_pwrkey {
-	status = "okay";
-};
-
-&pon_resin {
-	linux,code = <KEY_VOLUMEDOWN>;
-	status = "okay";
-};
-
-&qupv3_id_1 {
-	status = "okay";
-};
-
-&sdhc_1 {
-	supports-cqe;
-	mmc-hs200-1_8v;
-	mmc-hs400-1_8v;
-	mmc-ddr-1_8v;
-
-	qcom,ddr-config = <0xc3040873>;
-
-	vmmc-supply = <&vreg_l4b_2p95>;
-	vqmmc-supply = <&vreg_l8a_1p8>;
-
-	status = "okay";
-};
-
-&tlmm {
-	gpio-reserved-ranges = <0 4>, <81 4>;
-
-	panel_default: panel-default-state {
-		te-pins {
-			pins = "gpio10";
-			function = "mdp_vsync";
-			drive-strength = <2>;
-			bias-pull-down;
-		};
-
-		reset-pins {
-			pins = "gpio75";
-			function = "gpio";
-			drive-strength = <8>;
-			bias-disable;
-		};
-
-		mode-pins {
-			pins = "gpio76";
-			function = "gpio";
-			drive-strength = <8>;
-			bias-disable;
-		};
-	};
-
-	touchscreen_default: ts-default-state {
-		ts-reset-pins {
-			pins = "gpio99";
-			function = "gpio";
-			drive-strength = <2>;
-			bias-pull-up;
-			output-high;
-		};
-
-		ts-irq-pins {
-			pins = "gpio125";
-			function = "gpio";
-			drive-strength = <2>;
-			bias-disable;
-		};
-
-		ts-switch-pins {
-			pins = "gpio135";
-			function = "gpio";
-			drive-strength = <2>;
-			bias-disable;
-			output-low;
-		};
-	};
-};
-
-&usb_1_hsphy {
-	vdd-supply = <&vreg_l1b_0p925>;
-	vdda-pll-supply = <&vreg_l10a_1p8>;
-	vdda-phy-dpdm-supply = <&vreg_l7b_3p125>;
-
-	status = "okay";
-};
-
-&usb_1 {
-	qcom,select-utmi-as-pipe-clk;
-	status = "okay";
-};
-
-&usb_1_dwc3 {
-	/* Only peripheral works for now */
-	dr_mode = "peripheral";
-
-	/* Do not assume that sdm670.dtsi will never support USB 3.0 */
-	phys = <&usb_1_hsphy>;
-	phy-names = "usb2-phy";
-	maximum-speed = "high-speed";
+&rmi4_f12 {
+	touchscreen-x-mm = <62>;
+	touchscreen-y-mm = <127>;
 };
-- 
2.54.0

