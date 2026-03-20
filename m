Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57631098792
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A15A10EADB;
	Fri, 20 Mar 2026 14:42:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IIy5ITEu";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F5CB10EAD9
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 14:41:55 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso16723215e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774017714; x=1774622514; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q3uDCj5ujrrN7s5sHc5emouOCi1WukCaxLeNogjD46M=;
 b=IIy5ITEuG7pkidyTLU8Ns1EjU3dJyymFA41BTPOduwxrTLOF/5Q3Ae3bIbfj02wgdj
 66uTI0CR30iJ6vBgxHFe1+tmlQC1dGBwhmOWDsRu+DT59f7RkTFOUyH369q37O8PMfRO
 XcryI7btaIcnkJKvH4gIuj7YzIArQEQet/xUBdNQa8bKmPOMqRTRuRKyeX0mwrP3mJYR
 GyZNeBBeNlOzIQosetKQ/tSb8xhplnsOYCKaDzQDw6ds22NmlGYVcqhGb7wBhrc9Gl5o
 vVRZKECjtGe9daqOhoIKoU4nCqvD1EPHRxHRAqQ+wAVZbZ9ynF/RUkeEPw/L+Yet5trS
 znow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774017714; x=1774622514;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q3uDCj5ujrrN7s5sHc5emouOCi1WukCaxLeNogjD46M=;
 b=sOpvzmda2gWFTeZG0JBagG6RLqc9N8LHjdRqQgCLg081ks3W4LGCq8cL8MANZRyhqq
 DZ/P6qnBJTGnsli6MF5xAnlwquasIaKd+hiusFvpUd0FiHDp6dTUUhcOONOnKomUJz9n
 +py6b5Xva2ao0jk/uDJLxBAfJ/2doQGDZZLifu2//JIi7k2faniQaLsiucytJVVSlBrh
 qsUd5tYh/j9WLZ/LJpGqbkvA3O8LSNZiOfIVl4Edh7TZpFN6yt+ZqN2M8N+NlWPgDtJ3
 Z3WQYbETpNr8FJCWBKa1bYuYlJbDxdstGeZyXxxQMfqoLZD+mOqEMUys1CgD1XwMQTRS
 hZqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIfyY+v0r9yE2ghw0TBCG87k/dLPeWW0yj98DTsUXdg0RoIWX/KMlu/09FJl6uDZtoVx+tjpZpuo0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKyOUp2pKSmJmYUgoKbKaly9jyBMLogjHCLrZNCSLqKBJH+Lfz
 oWZnO5pAEdzbTygQDsnnoUN0/Be3Pmrc5igrZT9AD0iUYVWoNFj4OOA4
X-Gm-Gg: ATEYQzwBIyBP5BdVIu9NV2+Yc6tI+UsNMzZee9FTjJti3Lyz16eIICqx6UZKB6fTrK0
 hs8u2auC1T335YiiHAYUIZTKOZE/D82MGJlKFDCM3LJYf1w1GCQwVIaaxB/VebjF4wklvnlCsNs
 ICHSoUnC2Lp/UK4NsZpqngSH2FBgZGfpzCYXF06PzzJ56ZgEy48Kt85aIW6KwLSn8WWmuZyA4FA
 Coe6OtWlz9eJug7qLHptucmMRSG2w9AmTfqrZmoOekOo4vxJ3mEqaQhAUO7kSxSSJ0h7/xcCNCn
 NVnl4LDEDdSWcpWoBvRP4Pr86O9z8bw/V5uLpwQ8aqo86Bei6JYVUAuG4MXOzEot8Fx0yJGT8A7
 LOLS6tkBBAb2nSXI/H+wJwEAFYEfWGHkeAqBaerpjmhX5RG66RF0IAjNbCSv+YZin3kJHYxnhhE
 +tJZBO7nk/K6PuIJaDSaq7FZ5t2UiKASi0sAD3c04GpNWgQLkSV9G5Oabqjj2Hj8w=
X-Received: by 2002:a05:600c:4e8e:b0:485:3c8f:e4c5 with SMTP id
 5b1f17b1804b1-486fee049fdmr47723445e9.17.1774017713941; 
 Fri, 20 Mar 2026 07:41:53 -0700 (PDT)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il.
 [89.139.129.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b1fe65sm130648835e9.5.2026.03.20.07.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 07:41:53 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Date: Fri, 20 Mar 2026 16:41:40 +0200
Subject: [PATCH v7 3/3] arm64: dts: qcom: sm6125-xiaomi-laurel-sprout:
 Enable MDSS and add panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260320-panel-patches-v7-3-3eaefc4b3878@gmail.com>
References: <20260320-panel-patches-v7-0-3eaefc4b3878@gmail.com>
In-Reply-To: <20260320-panel-patches-v7-0-3eaefc4b3878@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Kamil_Go=C5=82da?= <kamil.golda@protonmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Yedaya Katsman <yedaya.ka@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774017703; l=3473;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=z5cWtDke+sL8Ldiyo6ylOZz0UVt/fRNgwxPdkXOleNc=;
 b=WHY8+9XaoSxSSE2KQ2TOtpn78+34uCdIC1zeND3T4ovWS7EtUwqQymYR6bvjCFI+7j0eI9ZtF
 q5GKppG0j2nAzqcPps59vM1DfETVxG+iVYZ/oK+XO4vs6YBnjp05RIn
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
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

Enable the MDSS nodes and add supplies and bindings for the Samsung S6E8FC0
DSI controller for the M1906F9 panel.

The ldo and iovcc gpio pins boot up with a current of 16 mA, but they work
fine with 2mA, so I used that.

mdss_dsi0_phy is powered by VDD_MX, see power-domains in sm6125.dtsi

Co-developed-by: Kamil Gołda <kamil.golda@protonmail.com>
Signed-off-by: Kamil Gołda <kamil.golda@protonmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 .../boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts  | 94 ++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
index 994fb0412fcbdf5466f87a325c48b697a37b514b..6eb46967712554929ab68af6f3218396b7f0118e 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -82,6 +82,33 @@ key-volume-up {
 		};
 	};
 
+	panel_vdd_1p8: regulator-panel-vdd {
+		compatible = "regulator-fixed";
+		regulator-name = "panel_vdd_1p8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+		vin-supply = <&vreg_l9a>;
+
+		enable-active-high;
+		gpio = <&tlmm 26 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&panel_vdd_1p8_en>;
+		pinctrl-names = "default";
+	};
+
+	panel_vci_3p0: regulator-panel-vci {
+		compatible = "regulator-fixed";
+		regulator-name = "panel_vci_3p0";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-boot-on;
+
+		enable-active-high;
+		gpio = <&tlmm 124 GPIO_ACTIVE_HIGH>;
+		pinctrl-0 = <&panel_vci_3p0_en>;
+		pinctrl-names = "default";
+	};
+
 	thermal-zones {
 		rf-pa0-thermal {
 			thermal-sensors = <&pm6125_adc_tm 0>;
@@ -128,6 +155,45 @@ &hsusb_phy1 {
 	status = "okay";
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_dsi0 {
+	vdda-supply = <&vreg_l18a>;
+	status = "okay";
+
+	panel@0 {
+		compatible = "samsung,s6e8fc0-m1906f9";
+		reg = <0>;
+
+		reset-gpios = <&tlmm 90 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&mdss_default>;
+		pinctrl-1 = <&mdss_sleep>;
+		pinctrl-names = "default", "sleep";
+
+		vdd-supply = <&panel_vdd_1p8>;
+		vci-supply = <&panel_vci_3p0>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&mdss_dsi0_out>;
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	data-lanes = <0 1 2 3>;
+	remote-endpoint = <&panel_in>;
+};
+
+
+&mdss_dsi0_phy {
+	status = "okay";
+};
+
 &pm6125_adc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&camera_flash_therm &emmc_ufs_therm>;
@@ -387,6 +453,34 @@ &sdhc_2 {
 
 &tlmm {
 	gpio-reserved-ranges = <22 2>, <28 6>;
+
+	panel_vdd_1p8_en: panel-vdd-default-state {
+		pins = "gpio26";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	mdss_default: mdss-default-state {
+		pins = "gpio90";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	mdss_sleep: mdss-sleep-state {
+		pins = "gpio90";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	panel_vci_3p0_en: panel-vci-default-state {
+		pins = "gpio124";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
 };
 
 &ufs_mem_hc {

-- 
2.53.0

