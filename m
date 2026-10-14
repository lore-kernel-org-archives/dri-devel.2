Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06555CC6B2D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 23:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4979E10EB64;
	Wed, 14 Oct 2026 23:52:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F65310EB64
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:51:49 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EMHQl34167548
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QxCVevdJDei/FrP0xFIQ/25OzUVG+gGQ5ld3vJX0vpw=; b=VVk4BuCejeZRxfi3
 L7UdC9/bYbvFBOEvby33Mrkj9T4l5jJkoIj1MN/a3zUOEM4aCvcruLMudsQEIFe8
 ocEzDAvdwvLdGMus/OX4/INKgDD2TrB4PhfouFH+6Z6WDcmdSsgTjI2iiT/joWeh
 3eAMUod8OGFPtzl+w7qOncje3rDylv68ILEmkNf9iOdrX33ffYtTF9lL9zrRjkWA
 TZaN4R6k29zetT/hIi2FkoyDifn24CIIjtN2BPxUrsW2fNBmDxzeKYMd6kucdMx9
 o7EZWISEm5yNXVD6aeVP6n7po6YOUhQu4bCUcvjTACb34q4HyCQEAIGN7u8WzTKG
 IgMksg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hac231u6c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 23:51:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e46c120dfso128337985a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792021908; x=1792626708;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QxCVevdJDei/FrP0xFIQ/25OzUVG+gGQ5ld3vJX0vpw=;
 b=VNpcVQGYnMZNTfiKL+/yXX75CZWHcCajtUM0lNA8NqEqSw39pYyFmckb36XgV4PU9w
 b0itMS9gYCfJVH/mwniIac6wpuuqrlQ41gcSeMSvisOEclnrfKDGqQS7CCOEfYZdi9bC
 +wlz4Ajy+hdXH6MvUQmao4RQX/UPf0N9l76doW2WlEeGsV3I7p4Xip1J6Y/QMoilik8H
 aVEJllgvuTeDPdQCl0a4Yj3f2TScvE8YIZKADE5zxiuLB41epW4Wxnix1mn+5VDbp3NX
 NLmWQEfkGW7eJtnHYndNlXsSkCkSV0SAA/FvntU49B1Wg+4zJRrR/zXLIZZ8IrM4fsv6
 z4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792021908; x=1792626708;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QxCVevdJDei/FrP0xFIQ/25OzUVG+gGQ5ld3vJX0vpw=;
 b=FDZRhMKxvbqkLeDhC90aDmwy5Ksh92wsVPAPpG5Lvq49Z6zJb1fdXm0uwKHrIvsa/Y
 IBC7Z85oBGdqTjUej0AvJnFQuuTyteICDUx8RB4BlGBNW5IxtV63qn4unffN43RE8Rjb
 vZjaGk54fHqiFC/JQllCVE0uSYukAFPBdXCGo8kfIsKEWSKrdESObf13kbQDx/kHDeJ1
 xhKIq5/YI25C3BHT0n0YuRNtODlwjvQPOM858dFH0ec7voxdB4hGjZon4T0d3/ltJ2K5
 YHej+7sbgxsNRtxXgIkp/GXe5UzO55m01UnENO/ZlRlT2lNId06+3MonjujG6SPRVA6Q
 HJgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwk8mTrbg690iivI+tMpMpuM08S0vnfMYTohZ4wXQFD+y/wkBc1cdbzh36Xv0V8HnEeoo55NX3ZJ30=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKCWIdSX7JXtzDL2qx118HqykUSlDLTfIVgnBYVw/1WXUdatF8j
 e+IDuLDat1dAe6o0iXnPoYByKo0lhqR7APo1gjXQRbXW+zHHe24qSVLsB8AlJwip5Omv9zg5nNQ
 sBDBNzn5Btfpj68eMoA59k4sUkkDkgZ85ui/cxO8QsDWkSU4RHs00UKpreRMR7c+jHKcPDYT4A1
 RN+Qk=
X-Gm-Gg: AYBFou1i71rLFL3sYG9fmv8fQReywCKehI3sHf3tuVBbYynQ6mKIhG4aMn40W69313n
 IhZciCIfkQ6DRlls4grK6nYwlLFC2g46f9bDW4KeRXAzkzDKMT9Mc/cKAwvs96drbsR8VFNCcTL
 IymDJMegpytHO9WMPgAoaUwFZQ/8PU9XvPQTFxcwtAfndx8ddjkOBzEc2ieN4SqGsDzWcs1mPwq
 +yygyund5inoL61wbQwsmWlpZt7Cx6Wq3Ol7EovHS9F9fsLhp5RH2e+FLicY+cdL6bOl1t136HM
 DWMjIF2iv/z4q3hix+Olpf2X3J4u/XILIISl59Y6wXj5QZBk9oHD5UxQFzZ3wSF7xpb6F/UgdVa
 H9FSLRHrN5UWCHLPUVBqNd+mHrHXLIdmN63xgwb+nZueUM+3EOSk/u462zMt5OFKkQTPTqVF7XR
 /MwF5ECm0WwjlF
X-Received: by 2002:a05:620a:40c4:b0:93f:102:566 with SMTP id
 af79cd13be357-93f01020639mr843409085a.67.1792021907912; 
 Wed, 14 Oct 2026 16:51:47 -0700 (PDT)
X-Received: by 2002:a05:620a:40c4:b0:93f:102:566 with SMTP id
 af79cd13be357-93f01020639mr843406985a.67.1792021907422; 
 Wed, 14 Oct 2026 16:51:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3aafded5414sm2285281fa.16.2026.10.14.16.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 16:51:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 02:51:17 +0300
Subject: [PATCH v3 5/5] arm64: dts: qcom: sdm845-hdk: add display card overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-sdm845-hdk-v3-5-1c179cd0d16f@oss.qualcomm.com>
References: <20261015-sdm845-hdk-v3-0-1c179cd0d16f@oss.qualcomm.com>
In-Reply-To: <20261015-sdm845-hdk-v3-0-1c179cd0d16f@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq0BV69yRKo5WsJL9NkfShKlw5sif2TqVTVzVqc
 XiBc9GHkYiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatAVegAKCRCLPIo+Aiko
 1UjbB/9QEPTx8aoKoMW/XSK+7/UUz+WLcxglA+qvd5MRi7AaKIiOanodABwZSFMbkV6j2Zrya/+
 GFw6bIpeoxu6PcMC8whrOpraTiS3oqf86jx69Y1pcbrwWe9HCuExHu2JYjlFlEqKuLvvgP9n8TN
 6DvCLhvBuiBeaIFXT5fDnQXhtTc7AQA1jKpgQTYyGWvfmQjFIcQy3PvneItIsfxNLMlmbWqloLS
 rE2Pv09nhLqHi6qBtgIbZ2UduicoOrYaPw6yIkaklowXxemc4M3SHe2CQs6c6agKZ3L+Vv9vZWU
 YdrJaPNVK+7AoOJe8QZN5ASbkjZ4xZPHIEdATKuTQfHp8vHK
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=PYJqFShd c=1 sm=1 tr=0 ts=6ad01595 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=FFXsBguXHA8yshPlDHEA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA5NSBTYWx0ZWRfX4PM2buhoep9Y
 +EF21vM1x4rfgjqrV8VaMviBlfsU78YvnCOTPk0pmjeB7lnc08nPYZ+RxPdsVmK9OmtSuKOrugL
 q9tIEGyN7QwXjopnd5/P2e5c04cdsrg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA5NSBTYWx0ZWRfX23NwDeRNT29Q
 8WJb3DUHBm9UXVwcMwIiTn/4q8HDCecB8RLqeDvyMzUfXMNbMvmNol8xgDg68U5WGjCeuL/VQb/
 b8ayIv9+9OsuzvlflCrOh+/Y9ie/nB1aNxdcC+/WyieST/tVT1Lqt3SNACmhRJRxNRL+kVXV/G/
 1Z+GOtNMVrD9x5Q51MtJjukIjZYwuGE7PQhklydsgXzht+OzVp4+SsgiUpI39vE4ZrjF7L2UXFx
 /mGzfYThWT+Ir+eKZtXbgtBBUT+MXZ8kg2ipwRBK6hXFKUu2gF/IEH6bU+RBZ5nxdDjqZBxJN6J
 3sn+Ci4/tx4r+Sui9M9ZIZyzaiIgfgIbWgVVPHINEpk8rMXll0XI+/LRQcbnD4i7G7kob4xURQE
 ErMuIxM4OfUv20yqVTtYk8Q8fFcZobIN6jAZEIlOGE+btrom/M7zICf014zQgHqWLk+IjZB20vw
 QVy1nvjXcnLDZQ+aVFg==
X-Proofpoint-GUID: zKyhnvo3UFcgWszDgBZKJby_eNV6ahKI
X-Proofpoint-ORIG-GUID: zKyhnvo3UFcgWszDgBZKJby_eNV6ahKI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140095
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

