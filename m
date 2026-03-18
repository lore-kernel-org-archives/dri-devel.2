Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B471A1077614
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:50:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0496710E7AE;
	Wed, 18 Mar 2026 19:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lDJnF0VI";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D8E10E3AE
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:05:25 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48535a0ef86so91915e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773849924; x=1774454724; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q3uDCj5ujrrN7s5sHc5emouOCi1WukCaxLeNogjD46M=;
 b=lDJnF0VId1XKqwTinZTKFokB54IR1nKNhmIt+PJ3qc6OmkttgBpU8TcfHvrzP9tu4O
 7nNO9kCDuei0Prnl5aOTFHtPwJ3xl9aHQeZY73QhmrAUATSsGJ91LXwSs8RXRs+9OA2X
 QDlFK4kWB8Ur6srhZ0htDH7ZDYpt87pGfWtA5J/CfVhbGaki9bHsNyNNAJCCcNgpZBAk
 Q09Qi6RmIwYIA4chJWrriQU5B60r/5uQGgydtdQTlybKwNg9M+ZCXUOBJvQPny0UbbDN
 Ho9TICm0UwXgdRLhJaTkVQJTLicWp1L0VH+PZQdDxF7dJfhmZf4ltFueXEiqC2fi3wgj
 hvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773849924; x=1774454724;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q3uDCj5ujrrN7s5sHc5emouOCi1WukCaxLeNogjD46M=;
 b=GoTtFRMSVGV3+9FEq8Jbmqnt3KQsBlQ8UnzQpkZRhR8EP3wMzSPqs5E7WTdrEoPm+z
 9jeacNu+uKDHGqOTywiH7aNOqwQ01kp/OVd4EIo5JR8iVXMT1UyJq1oBFZbv46WHe75w
 9ih4NdHN8Jo7mg3rxQfuK270jjSMEbCQlZ54aE2vaoSu6q9r2MQT/OUnCojFUvXOQF3M
 rq8WGCfj1OSsRDZ1E6/l0u4uzyEoBnvZe3E/jpul/Lo6xQLORdZoi2+lI+EaJIWcvCAf
 NNqHmE99ic1X+F86tV0krYd4kkoy+7KGwV5AFU+5YbvA9Dhde3+vFAcDkK8mlSErWcyT
 MW0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+rlgU1EX5GjJ48WZ9eGgB0jWYdJu0oDsA3qzaEY5FsH/+i7V8Ogae+cj2q1YA9CSQYO5kViDBJnQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5EG6mjROVEsmOZIzU1W8VOmCkB64M/sVnXNE3xWEHD3hGyPen
 f5efXoafQSnzMDVdHa38oGXfSk11wrbkud/bxpLRhfVzlLZpDH3dx+4p
X-Gm-Gg: ATEYQzxABTtND4YlcNm4iLWgAVFhb3pG+vGQFY456N2zoEwxqCyt5rUJaqp9ADq6VPQ
 uj80BF8sjW3HP9WZ26PNAZ0vgLqkbJs4xPibdPOJKgS9bGFAH6fcAmVYnakYABM2zaxu8JHUsYR
 7LUyHuxR/LPlZDbGBycQn6c+zCenZFJ2xHtw5sjxkQafj4W4h48Zd3zPBZRUUUaOtozQ8kVrkDb
 rmBHOIdnVz99ALaKXrFP+tbkbjqNIc6WcUZDkNm5RhQQ0blA80ADuz3yWRG5T32yBwn93Bs8pCE
 LNoVVnukefnaIA3Px2zFVXdNwZ//QHJJqAnALhusxRu9+ctuID/sRWnHsjYSau4AtO3iyUtUk9e
 Aw/8xojAzUH9FuwL5e1dFyeW+Jn2kgddlAW8vtLc9qEqR0wDXSlVCaoYciIEMSlq82Htgfa9KhV
 VxbbBbbGM6C8Oi4W0JZD7TWKP5XDAD29xRr7H0PnGUz5miwQjPZgVHD619iClhK++GdjGRNg3+f
 Q==
X-Received: by 2002:a05:600c:810c:b0:477:b642:9dc1 with SMTP id
 5b1f17b1804b1-486f4475342mr67413535e9.20.1773849924043; 
 Wed, 18 Mar 2026 09:05:24 -0700 (PDT)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il.
 [89.139.129.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8baec5csm2282225e9.15.2026.03.18.09.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:05:23 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Date: Wed, 18 Mar 2026 18:04:50 +0200
Subject: [PATCH v6 3/3] arm64: dts: qcom: sm6125-xiaomi-laurel-sprout:
 Enable MDSS and add panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260318-panel-patches-v6-3-7a30c2f85e0b@gmail.com>
References: <20260318-panel-patches-v6-0-7a30c2f85e0b@gmail.com>
In-Reply-To: <20260318-panel-patches-v6-0-7a30c2f85e0b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773849909; l=3473;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=z5cWtDke+sL8Ldiyo6ylOZz0UVt/fRNgwxPdkXOleNc=;
 b=dYQiTGxFTslamVdeBsQYeDoKHLqMu4p1xhRxqwj/4rfnJtAiX0OJRX0t79Hb2PUQL4cU79ekl
 By44Ksiem0VCJoK3zRu+xTLhwe5Xhvq/eaGTH66U0I7qcn5SE05I/Cz
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Mailman-Approved-At: Wed, 18 Mar 2026 19:50:21 +0000
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

