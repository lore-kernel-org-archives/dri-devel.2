Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F07D58B18
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 11:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E193D10E1F4;
	Sun, 15 Mar 2026 11:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LM71GZVU";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCB0410E18E
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 21:46:35 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-439d8dc4ae4so3425052f8f.2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 14:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773524794; x=1774129594; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dsoJTFfN3Lcp672vnl+BCSyX/e4yOnsEQpHNAiLSlIQ=;
 b=LM71GZVUpHF3EYlYjarrUPvRgQc0sVqee0QQAERPBfmO1tiMitlXuXJvw0WMfoZ0z/
 +TBJ357YD5JDUVV5IlFzBZ1vz9TsMnvTE9607REwF0TeGz4316HTEnP5ogBxUzGfR9zK
 q1/EnT0dqu3Q9Yg8n25a7slLhH36WRYOnRM4YFYLplrgPHVAyVGQF/5B6pzzRJdp4Jsc
 yBxrHveLlC0GKotCPHuCg8fe8/QAo4i2l0FKcAqsrUTco7VYQVCJ5o90XMMce6eTDOBd
 GMO4SOKokOS18aQzUfQ32kxWHx0c1qwydAFlSfsgY2KEBxT7h2YNair2upunH/cu3DRJ
 j3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773524794; x=1774129594;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dsoJTFfN3Lcp672vnl+BCSyX/e4yOnsEQpHNAiLSlIQ=;
 b=E7szytMg3wnE/GVlT+L7N2rSO/Mi3C6+ZDhKrxdslv7Y9SRytXkXtvw44FlH8c90WT
 zSWoBPRxOHziAMWI1IfFzNj8Oxo6l6HIAvS5YtDLgHaWNs6oJMo7b24KfZSF6ZJWsqBj
 N0RQmAdvdi6LNtOmXOhX4iHfx7QDi36hePSfu6PWLAst46tSywuQjKHzVDkuyLYOYGss
 z95BU7asfkKJ7WIhHDreKaiL1j9B0b6naw5slxbPdsOY2+BxWBZMJreXkIDRC0cvLGuq
 tA+ESVTTILcFxsLwZ3+YeA55jEpu1rwJzN9jT9NiYTnAi1vLZiC7iXaMOxWG0DXeA1R8
 4H4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSOdGiVuCqAVzCryv3bsXCFeD5VBzqQKs6qGAwQqf2JsNSesAQ93BIsuHmIr8QEWmWXVWJfrgiC7g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyBf2Df36aPsoHMDQ59FbRTfcxDoZidT/Kxil4bMlzXS6DdZ7Ut
 vvjGGN0TeXUteHlNg87E3djz9WJKyiXd3BhDe3uzVlgPYVYvpz4zojkr
X-Gm-Gg: ATEYQzzv1zA79LLrcZcItORZC00LrhdaorBR3BKPfWZ3evnC49wllIwh/5W36d/SAI9
 8C90+6SLPmp6mTFUHdvex0r8Bco/+DRRflxfZHM4M898tjoZTZSHiJCXKlH9xyovIbFysnbvwe4
 +rHrmbSc3AhT/ZgX1hkCwR6KAIisOnxAlAmhXC4haDyNf/A/LmWUtp4MYVX1oHQzFTFbeYFYWGT
 oD2nGzZXiUpFm87IrsVQj+UEc1C7z2ZXz+WeBAby+zatw8FpU1UhhBbd3blMiCyBCaHAP4qlelV
 P2Gp6ZbjGio64iYGcJrK7u8GTFFBHkE2w9G1FgqfRbtCoYY9jqy2xmw4N18O8u5L8HwdARdiEDI
 gt0W7i2ZaAdYI8kRyr/oK77H6EdQ32hHhnBy5ucnrdKQWYC+IRh9Z3iu8GqMdPxuUN9Oodyj9aR
 pAxa2O6GHGT0So9AtU2DFF3O6z2d/fUyZo3fjYYIVfJk/Blu5kUxvgSfv1UgdFdTN70GXEqcyYZ
 Q==
X-Received: by 2002:a5d:5f53:0:b0:439:bd26:3c63 with SMTP id
 ffacd0b85a97d-43a04db4bf4mr13896214f8f.28.1773524794034; 
 Sat, 14 Mar 2026 14:46:34 -0700 (PDT)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il.
 [89.139.129.65]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19aec5sm28756221f8f.4.2026.03.14.14.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2026 14:46:33 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Date: Sat, 14 Mar 2026 23:46:23 +0200
Subject: [PATCH v4 3/3] arm64: dts: qcom: sm6125-xiaomi-laurel-sprout:
 Enable MDSS and add panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260314-panel-patches-v4-3-1ecbb2c0c3c8@gmail.com>
References: <20260314-panel-patches-v4-0-1ecbb2c0c3c8@gmail.com>
In-Reply-To: <20260314-panel-patches-v4-0-1ecbb2c0c3c8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773524784; l=3473;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=MowvpUKBHWcPnQE4YIK2nePYkcrVYnXiFtHKOMsDddI=;
 b=fjAjMIu63T3J89KrTMFMgceNzP8z3eiyQ/RYVuk1rw4Xso+FdysYzfH7tFEqPaGpEPjECwufA
 ZyYAKfsa9lhDS0lbq+DfbA14HoN7LNx4Kv9qt9tfs+0v9ATS6TkkIjO
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Mailman-Approved-At: Sun, 15 Mar 2026 11:20:58 +0000
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

Enable the MDSS nodes and add supplies and bindings for the Samsung S6E8FCO
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
index 994fb0412fcbdf5466f87a325c48b697a37b514b..9b046d21da1dc54bd851a94d0e209bf1763e865a 100644
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
+		compatible = "samsung,s6e8fco-m1906f9";
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

