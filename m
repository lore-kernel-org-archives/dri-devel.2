Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4596CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 08:40:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C4310E0FB;
	Thu, 15 Oct 2026 08:40:03 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A8D1121FD
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:39:45 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F79kfA1684736
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QxCVevdJDei/FrP0xFIQ/25OzUVG+gGQ5ld3vJX0vpw=; b=XeKAWu+8nTF+m3il
 2lHqIQAZSM36hW4nCyCo4ca68w2UCt10w9/1pgcd69mNWCcWvbEnSVB5w+hH5ZYG
 NNuOlT9vLiqflMUcUAha4NSP+RpRiUWEHO0+FyX1b/q4HyL8LPxRVG0PdYSmy2WF
 tA5qroFF5Zzwm1gyTY8jrZ8dD5FoYMHIuLbZfviIxZp+8cDhjcHeFzLggyF6fRr2
 gg2NNzA7H6vuZtIV98u6Ycd+ZdVwRGwBLftk8x8i5KY/ougHd5UmLnn3n4Qgt7kD
 73AruOL75hr20aWjYnSvmXGwAhGRGlE1ikf1ISCYj0z7kD7h6RmhasELwsLNW4Ty
 evAhHg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb03jsd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 08:39:45 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so1018244485a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 01:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792053584; x=1792658384;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QxCVevdJDei/FrP0xFIQ/25OzUVG+gGQ5ld3vJX0vpw=;
 b=BOWyri50TZTvgBQzNUDl/eoz9F+Vc1a49jZreMyY8qs++uvT1joBf0Gqk5xaiMVK9y
 MpXWzWlYeJgpfVKWNYcZPnQRmDwo9cky/d+lCFViypiwKQdZ6smnMBJ7Df6dxONcrFPB
 HIqruP0t9NKGylpFxBIh+WBDjdJ/jD2s+V3QxGa0TcbgNEojQ9y9tieIJNjLOkjklQVx
 GmLT2i8vJxJvFF450b2IG2i2NeyVn2JuEN44f5oJZH3zMYlzbTLr9lYCI9zcJd1Ljdba
 Qexa7WAnXhbzTMh/2eBLkN8arcyWYbE/x3FrH2iWOSiARJ+Qsfun6qnzY6cc53UbQh4H
 2NrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792053584; x=1792658384;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QxCVevdJDei/FrP0xFIQ/25OzUVG+gGQ5ld3vJX0vpw=;
 b=isbEIfYe+5794ZGbdXOyJKXpYgqBiMXKKBqYVgCuIz8Bv6AxtYngKhex1FY5B516MD
 842jsReefYwaJlNUKseITYvOTc6C3AmF5J1Hons+ef4XKBPr8xCem1rN7FzwTQjinA/j
 KrjBX/v7LnWrtOTRGUh9cW+w65Q8mX0B8yD39+R0zyDgXozU72YVXuVYXGY4/KfUKjgz
 9fd8ULZbNiIVW2fin1ISqL/vnApcLQW6oaA8hp/8xVZ+CMlKUrQ7mqWG/zUzEotUDikG
 IhyUeRH7WxQzKoGG5kUmcIbZWpQtTf8gQtOjIRUXzUGYT09gz7o3/gqJva20Fw8AvL40
 mziQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcf517jYYkN6OyUzAMuNpzwLRLZit29NUUlbioO0o7JvkdJrc77MMt4UA+8S8Npf9ei2HcHXwnROM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJnLOxdAAyDefcT1pSnP4PmdpJvKehOtys6RO3FEhg3cxt+/mEQ
 QzkaZct0Bs/Hy+C4eytYARmxR70/g9M7EZY3cJsIZ0GuRGKOWzK1nDP/CUQtFNIwAWDdHOer0ez
 IdfZEtNDZI59O1oHm47YciXZltXaUQqEsuCJlyB6DQEhHXHodbEgR7amtZoaSiMKXlZFugVg=
X-Gm-Gg: AYBFou389Ub8hSmbVgjZHPaca2I/n5fYnClXgtSRmSsRRYjRuNsxJ5sPv1//Zm4ToOf
 ZoKYZUTJI9H9a8WGdhYTZLMCWJLYKWDrExFayRGLyyn1y+0iBMIZ3srZaq08nVFCPmqJChDfrxh
 oNGehy5NrHlWsVFGYmpwaYJgtZpjgbtLOmo+bt1lr2A0zKa78b3KquICbNI0SJmH15bB06JsTQ7
 3ogqs7eI5DDxy8SlpHr/E2U08IvuRNLeFD0mXKr30le9asObRpTGXL3LAIx54NBAm52SSWicrFL
 T49BAiR5W1Jrd7acU83NoO+K4M75HsYMoWzgmHeqcirThV04Wn6Gd1DHkDjUQrm/WOsgOVbKJFK
 aKN7lqSgND/+ybgQnhb18I/f64FF/S9b2FQT98MQCLl6zAl8TZqlUUW0UB3C4aCqg48fqNoRhea
 FWFUNEL0T3FkET
X-Received: by 2002:a05:620a:6489:b0:93e:9171:b82 with SMTP id
 af79cd13be357-93ebd208959mr2802418285a.36.1792053584295; 
 Thu, 15 Oct 2026 01:39:44 -0700 (PDT)
X-Received: by 2002:a05:620a:6489:b0:93e:9171:b82 with SMTP id
 af79cd13be357-93ebd208959mr2802415285a.36.1792053583691; 
 Thu, 15 Oct 2026 01:39:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be33d702a5sm1175500e87.15.2026.10.15.01.39.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 01:39:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:39:12 +0300
Subject: [PATCH v4 5/5] arm64: dts: qcom: sdm845-hdk: add display card overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sdm845-hdk-v4-5-b532b9f4029c@oss.qualcomm.com>
References: <20261015-sdm845-hdk-v4-0-b532b9f4029c@oss.qualcomm.com>
In-Reply-To: <20261015-sdm845-hdk-v4-0-b532b9f4029c@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abel Vesa <abelvesa@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3699;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=lPeEe7tz+0YSnJKsAf50jnjdmdW341RGDSdUQ921plk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0JE/KiJJFSOHp1Qvl9QkM40kcGJVrQLIbF4NZ
 NpZUKyKmE2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatCRPwAKCRCLPIo+Aiko
 1aeICACcdX4Dx/PckMzaaUVlD8PnCWdqIzMq7iBJ53ZUgelXF/Ge4z/kW/N3OXwPXoDu+Pg0dFm
 gxLf6AhnmvNlCVDEcbWTX6nvt9USbz49QMeCkY2viWc9Nd1Kw5RbFayMpXa3+r1clnPnkUxaKWp
 j8WJoK1A4yfaA2t9B+ksT4rUWuRJ0zcfTmr+70NzqOzE0xPLbS/bnXiBHJbiJ3rSKESQzNjj0q2
 AcBRE59F8mPgBHQsUfMQ/tYxg0W0Dqyazn3DALX8lg3VSpHIhVs/3nC0/Mvq7PPLO6f4yBqdleH
 hYyg0Y6bKmo8J4T/qybGtTvMYQKB7lltijs1HK4DnPQ5yEvh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6ad09151 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=FFXsBguXHA8yshPlDHEA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzNCBTYWx0ZWRfX1DPOwXiyCJIH
 yD4WJFlL88fRM2gK4SKjc42+GijpEGTi8UvgzzFAIADzYu7mSiI6Xpk15NGpSKThECrxrT8F0RQ
 PeH63hah7RPXfmwpXYBkgvp9N/G7ypU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzNCBTYWx0ZWRfXx1dhZ7LUNx+O
 LrifGuam7LAk5RcEZasHHhVeS7Ru/6bJNNadVBM3pQGcCS2CWpF8Gw8TUVffjY4yGv2PqSaQ3ZZ
 9ADJGOmpikfeNtOLpt2jxwQFbJQ1YpWkmfsOBbDHdQOZARTslo3e9TijOrigUWMRJkcB+Octfcj
 UGUFhFnFvKqlorFlitsTRKD2GvzxUPGD/7Qb+eTC2D0j7ile/+8yFry/Mei0p6Bf4e4tBYapVaD
 lXB0B1kZPQ4yLYDfOjnBZqsNi1SMeA22xQ3Mhrzk9dt8wTz1kjY0twU1SZ74RMscsuLyOivxkT7
 dKECs/n5oaTpqM6ZXAmk860nvo1T0Qvau4T7eabKu5Hoil+A2rMvWRTtdHgBhmIHd7w9a74qNJj
 CYNCM48e5fD/wYmEqspcsE8MshSr7dz1VV++1KihXssVW7wWfEffopxnqixCczhNKqwtW9ZdV9G
 6an+ULzbEKlXV8IKroA==
X-Proofpoint-ORIG-GUID: WJyxrOjcu5UD4IUiPOKOrL_FEfKQRNC6
X-Proofpoint-GUID: WJyxrOjcu5UD4IUiPOKOrL_FEfKQRNC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150034
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

The SDM845 HDK can be fitted with the same display card as the SM8150
HDK, carrying a Truly NT36850 WQHD dual-DSI panel. Here it is powered
by the PMI8998 LAB/IBB and WLED, and it is mutually exclusive with the
on-board LT9611 HDMI bridge.

The configuration follows the vendor kernel, with the bias rails at the
5.5 V default of the LCD mode.

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/Makefile                  |   4 +
 .../boot/dts/qcom/sdm845-hdk-display-card.dtso     | 109 +++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 5be99934cf9f..85d06a950b4a 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -356,6 +356,10 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-db845c-navigation-mezzanine.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-google-crosshatch.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-google-blueline.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-hdk.dtb
+
+sdm845-hdk-display-card-dtbs	:= sdm845-hdk.dtb sdm845-hdk-display-card.dtbo
+
+dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-hdk-display-card.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyln.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-lg-judyp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
diff --git a/arch/arm64/boot/dts/qcom/sdm845-hdk-display-card.dtso b/arch/arm64/boot/dts/qcom/sdm845-hdk-display-card.dtso
new file mode 100644
index 000000000000..1022ab096170
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm845-hdk-display-card.dtso
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+/*
+ * Display Card kit overlay.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+/dts-v1/;
+/plugin/;
+
+/* Disable HDMI bridge related nodes (mutually exclusive with the display card) */
+&lt9611_codec {
+	status = "disabled";
+};
+
+&ibb {
+	regulator-min-microvolt = <5500000>;
+	regulator-max-microvolt = <5500000>;
+};
+
+&lab {
+	regulator-min-microvolt = <5500000>;
+	regulator-max-microvolt = <5500000>;
+};
+
+&mdss_dsi0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	panel@0 {
+		compatible = "truly,wqhd60-nt36850";
+		reg = <0>;
+
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+		vddio-supply = <&vreg_l14a_1p8>;
+		avdd-supply = <&lab>;
+		avee-supply = <&ibb>;
+
+		backlight = <&pmi8998_wled>;
+
+		pinctrl-0 = <&disp0_reset_n_active>, <&mdp_vsync>;
+		pinctrl-1 = <&disp0_reset_n_suspend>, <&mdp_vsync>;
+		pinctrl-names = "default", "sleep";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				panel0_in: endpoint {
+					remote-endpoint = <&mdss_dsi0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				panel1_in: endpoint {
+					remote-endpoint = <&mdss_dsi1_out>;
+				};
+			};
+		};
+	};
+};
+
+&mdss_dsi0_out {
+	remote-endpoint = <&panel0_in>;
+};
+
+&mdss_dsi1_out {
+	remote-endpoint = <&panel1_in>;
+};
+
+&pmi8998_wled {
+	qcom,num-strings = <2>;
+	qcom,external-pfet;
+
+	status = "okay";
+};
+
+&tlmm {
+	disp0_reset_n_active: disp0-reset-n-active-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	disp0_reset_n_suspend: disp0-reset-n-suspend-state {
+		pins = "gpio6";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdp_vsync: mdp-vsync-state {
+		pins = "gpio10";
+		function = "mdp_vsync";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+};

-- 
2.47.3

