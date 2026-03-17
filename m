Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F56FCD0DA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75BF510E74C;
	Wed, 18 Mar 2026 08:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xqxcf5fn";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E789C10E415
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 18:50:47 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48628ce9ab5so14437435e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 11:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773773446; x=1774378246; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q3uDCj5ujrrN7s5sHc5emouOCi1WukCaxLeNogjD46M=;
 b=Xqxcf5fnJ4M3csG9DYhFGo0enjPcJmv4miFzkBgkrUo07jN2vtTXX4VgmrCeCSbGLZ
 PaIv/+kxmHZiS+Lw+jWCVle1FrrvkuyTetLwlJUO0n/xQ8G/iigp4s5odjnwhCKOwLqR
 Wji3IkJERJv7TCawBD8oUo7gadiRVw52ohOh1SOsTrAvVbKLLqhfRb8JHY3dkToowA7X
 DliXB+N/dGqyiXz11Xa8EZD6qWm3GJ6wal9fhZVJv0P8iMCdR4Ww3FNxP8NBHtNL0ADo
 WTS5AT0LHnf8O/xy7MMPOFAT6GIc86fRaXwzT5wIML0veLuEk+WlZALejoZHvtWYXlMv
 ocfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773773446; x=1774378246;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q3uDCj5ujrrN7s5sHc5emouOCi1WukCaxLeNogjD46M=;
 b=PBX7ASryUD3ocU6zoyaYdBrp78bGf0nZD/+JQY5AqtzudlzGL2Iw+JZrt8Eaob7F0H
 Sy6cZQZoT1tPXUesqWs2L0qKInZHwCr+BwuD+C7+M5QnPgnsShQxyuN2SHXA/GAdLpBP
 XSPsrd7igmvsasDTHfUw5Ku/iGfVjXBTDPIchpJgR+PUHu2EG6EPo1x8YuDXeHLg3xQT
 gEYGB28l13m3AxpkfuqeODmgVjlX9YpiO1FMQZ1tOb0qYyfIl8NQLtokBeNyAPvrvC7R
 ikotDV4ayIrhzmJL183dvSQZeOvE1UMre6SPew0E417C3jWN3UQo8cUEYjRf60y1fZ4P
 d6bA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPil6wnVbxNSfaEkODlKAeauPEQNYBz0DjYppb3GQR+iZnM5mMaOQcS5tTljIAw+XtNF8AyuC5clw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJX1IrDS83Om2+c/XsyHaE4l936YWtM2mpkvkRxGHbM5TbaKdz
 ZKMn0sX39+5eO58/cRd7EXbNe/9OfLk5qxiCeGenzQdR/1RMRaNP0v6h
X-Gm-Gg: ATEYQzxXeWYIr5Xv7dFXZFKhtXOScrRnVrrOKLMJfLEhfH0bpJeQeqzF2xdXnVjZyrl
 WbLBZTMP8MtqSqCOtW7lFaYRPh0n76HQj/tfqA8WhwDmFFnsXFTK4RqC43awb864tM6EdZRFbdj
 UED5atsGjCpCT/pDk+F/yPs2eTIKI4d0+LCgjV+hHB4qzehuljEnVDPzvxLgzIrBUvUXd7yGaZB
 Vjtfd6n5NRtAQEFrDynx/pZTbYuRTksvPgJbaaWpz49OZtpRWAfiErDhNne6cSoGnkEz04gkKo7
 VqLdH5dYNvpmE6hBNeb00hQCya5OHcRNVKVoa3GYfhSMVDix1+NSPM5m/rxBbyUpyh+R60F7HoM
 bbAo49rdLjCTTDSsF8GKvQcJX2yG6lxoZNfd4WQbz1olUHjUzN08pQxK+TKZYLUTtcDeYMYhr+i
 Hz7xeMYVmBSSI/DRwGckHOU37ETFpByko2otIq2Bjn8TJ1Vvs+OAXIsQyo4d2g1mk4AAZx7Stg1
 Q==
X-Received: by 2002:a05:600c:3551:b0:485:3c14:885b with SMTP id
 5b1f17b1804b1-486f4476e2cmr10827785e9.28.1773773446274; 
 Tue, 17 Mar 2026 11:50:46 -0700 (PDT)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il.
 [89.139.129.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea8fb0dsm152863595e9.3.2026.03.17.11.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 11:50:45 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Date: Tue, 17 Mar 2026 20:50:31 +0200
Subject: [PATCH v5 3/3] arm64: dts: qcom: sm6125-xiaomi-laurel-sprout:
 Enable MDSS and add panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-panel-patches-v5-3-ef99f7b280da@gmail.com>
References: <20260317-panel-patches-v5-0-ef99f7b280da@gmail.com>
In-Reply-To: <20260317-panel-patches-v5-0-ef99f7b280da@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773773435; l=3473;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=z5cWtDke+sL8Ldiyo6ylOZz0UVt/fRNgwxPdkXOleNc=;
 b=is/9H1uiIy/C4DtVU6X+cCIT0JuOVFC6SfqAqDeqZyS6xlZdifsCtoPxuuLOc27OyWE30vvIS
 dtEqLToBftAD/piEFdAnoqT7oYt8CS32zIzvUNdbL/gdzlShOh64Zrr
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

