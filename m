Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DF4CCF2DB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:18:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320B810E91B;
	Mon, 19 Oct 2026 09:18:44 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B90CB10E90A
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:18:27 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8Ow1a3256648
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 myWgXXG8iF+vXRiE8O56/LC4PaTh8cFxHTKQwgY5Elg=; b=J1F8rkLT9jxWdE/1
 J4n6ITLaKA2X20EWCQU35EltVB4BDfssQkPuXts/r2ZfsjeLyL9AE3d/ZxZvGyJx
 +fEH7TySoQdstnsj9Mke27sdcWcfDxyxARA8W/+A14SBzQFMtPcQeDm7FHB/+h5I
 eSXJ9GizIQo6qudsfOf2yRI+MesXAvFEtQ9W3i3MxuNxTpkhjfRW1E36Y2Rb64FQ
 396q+F0yY7vbbLra05IO3kBUnwEwPg5+4UCw18CeEVVHHwiSsayLDqnKKtHFQI5k
 2ShQSYSn0UA8ZuUOYr3p4bzoJkrXmTgACDWSwN1UPHhXMfSz2duXhfEUTKZR6+ig
 W4bBow==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f8bbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:18:27 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91b92acedd9so70339276d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792401506; x=1793006306;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=myWgXXG8iF+vXRiE8O56/LC4PaTh8cFxHTKQwgY5Elg=;
 b=h6e64daVHe9sQOW8zm1mabdMjkFp+NWqrHU3wve32WW0Hw5PtGW3LTYmZHT086MWxy
 6PMCguqYENvcVYfnKND/Zuz7yb75DkMW5HsJ2KNManiMk3IIUo4uMyVxXY8F/XVmQoOu
 zNKH5My0X67OcBdRGt+izNpY3V5GjFktu+9yFHVsGSGxZ/YjiTBHHS/pzyQAgX83xJ28
 6lpYpwerjrtAWnSgVc3que33oc9se/Wy8xme7Jqy85WbyDGtGgl2u2gnfKyucTRhjfV7
 8ZlpbapqQFgyDd9mOl8AEVCasa8P1VryS2dWIzdhdGeRLnM7NnGI+q0P7VvqWBYAC7Rh
 Hs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401506; x=1793006306;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=myWgXXG8iF+vXRiE8O56/LC4PaTh8cFxHTKQwgY5Elg=;
 b=rNV/hQwYVSrv/Za/5hmiM6GRC/YIDnDycT2DwzWW58jB3V6gIuvdjowFZdCSrD6xIz
 VbPZEhvKEh7UXe1THTrDnjeuqzHPVeR2I86KAEmwTWt6cNF3KX3ESIOVUqeGRRNJBrTF
 JcP1B/yPx/Ao57xj3H0Ui1DcrK4GTKAEIC/djWS8S0pBI6J/DwTy4R/nlzIXFHMqKxXd
 +hwMHCUXRy3YkfGVf9Qi0vC0lfNwTYmhG8nqIAOW3cZ3Y6EcLwUTSmshLUFpVJmmK23J
 mI0iJCp3hdOBs8DyhemzqhUs0BYfn+p+9sxh514O7EBphcTB3iLnhL6tMbIfDbDRACEF
 YTqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByJq0dn2vqzVhJhzwgFYGlXCxjna32Kq+MGRaDe+K8f+XebaZ6TIyCUQC7DL/tSHQe60jeYqPjaqFw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIZOMuIE9LAX9L9hrEhpIIlhgYtkKhPspyvnoMkQX2w+/Kp9tuM
 QDVqrFewRVg+MiGBdbUgIR56hQehdX9RQVEzB+IqGWDqkgoXnowJmAVB2JQmP/oTnkqpwVmNvnJ
 rMarm97jMiIVrmO55RWkwigqekGopDP9qQa+kvqdI//DJ4uqgITsKbgL2s9xX8+4qF/BLuAI=
X-Gm-Gg: AYBFou2AeoQL6CmIu2vJ995Ig5Lem2rO0SZbMt9y+F0sBibyvmNbjOR8ydn/PXIAQdD
 wCUUSgLzGq8LhJYofdxj3I/4Me9OIzax6JBtTMYeka/1vlXdDSgpo7JdTsYifeFAjusaQ1L6HCa
 iLmJdEfy0M2EB+abAsYd3y8/3kjWbHzYv5byAAXkEPz/U//Dtkc4CDBdxH/Oaqsf+r1cIwEUV/j
 53LIY18Jp1N1hrsggT00qtNmWAc88aK6U1JtVt2coYT2LtTns/oPNOPxvLGq8xUCnek1GMqFrNb
 /jc/wW0kDrjmF3kpL9aXjUE1lnOG/chMav+8bBYtS61/AVvbIqCs+hJ8YanFMiBHGshv3Hu3Cib
 cg3kPCj5UV/qNNtDGGxpk6q7vOx9iDe+vHHGrwgP4byLXg+l03wl4VGf00Y2Ru/3RZ7GaDkfd+M
 vjor/SCPTtkRVs
X-Received: by 2002:a05:620a:230e:10b0:93f:2ae1:ea06 with SMTP id
 af79cd13be357-93f2ae1f225mr732440585a.44.1792401505994; 
 Mon, 19 Oct 2026 02:18:25 -0700 (PDT)
X-Received: by 2002:a05:620a:230e:10b0:93f:2ae1:ea06 with SMTP id
 af79cd13be357-93f2ae1f225mr732438985a.44.1792401505515; 
 Mon, 19 Oct 2026 02:18:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ab2e4e05c2sm15893441fa.25.2026.10.19.02.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:18:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:18:07 +0300
Subject: [PATCH v5 5/5] arm64: dts: qcom: sdm845-hdk: add display card overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-sdm845-hdk-v5-5-4aa7e22cd0ed@oss.qualcomm.com>
References: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
In-Reply-To: <20261019-sdm845-hdk-v5-0-4aa7e22cd0ed@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3676;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Gk4MYI6gZD64lB8jqs+VeFEB9RTHDV7aov9asAEAoqo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1eBR1tmWG6zeCOvuonHAaCMIEV+WWzn8XNCgn
 J3Xj+NiVOCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatXgUQAKCRCLPIo+Aiko
 1RwKB/4rsmEwIX1nmfiibiHGtpcsn/dIQigZZreg6kpuVuey2k6J9pekhos1EGi5T1cgdwQzpOG
 bM9QpvZLUAbpYqrktU71RTHjeE3zTo4Y5HQgr0MXZifrxrImmsSqISxSTmtv3BvGDRwWX+Arbml
 UA73hnRMUhag9G47RygcTMZkcbntOT5ubGrQPqiPvcnzlfTxOuEye8H4ZbHf0ZvMQysHarUTTsm
 Q+BngOQ/U3dvLFK+qdO5Xnew3QK7A/MXxhaemB7p0Zhbgo95mcpHROUNIpJ0juVJdBfSp6p4ps6
 zvZA8gewXZfJM2i0oC0kQayPPifZJa64x4UuqU/t87n6r9f4
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: QW8kYCvocVeGVee9dGpeQQoyRrZma-65
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfX+ezB5LxubA0x
 Q+Hxx9t7M23AMJ3z8B6O4MEqKJJUgCH2WJjGI+oxHVKYYm2KyX0040LhAfUnF72GMOHBvsE9w+X
 AYKvt5TnbDJY1LLh6wfaNWrosfkVgQTUfqoOdZGldBn++8bcY4MVrDsUR0yW7D9um+zWnjEJJRh
 OPpwg8lDsT6U6I5v/zeSfIcrb6B24SaLl6xD+Qei2dkqA2cvlu7/vJ1nIaS8m6ADrFlyAWr6PDp
 HrC6UWYfso8GHH+BNlR/a7Hg6rxzFDO7nRJ14qffKOd2EG4rdPMgHClssVJ1Wzot8hd5PUAnJpx
 d/l2Y4+HfgaEEas+CWMjCkQMsNFkouI1e7LNrP5+aXYzHLs7vsdGYZo4dJ3OmtnSysUqDt7vFFr
 ERv2MQOFussZpM8dNQE6wp2vF4sB26qJkl/TpiWgA3PaIC1xEP3h6eVTXR+Fd4E5t+nwI4AlocV
 ZkqnfodyzM8faU7zAfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAzNiBTYWx0ZWRfX/3iB4JJluwDd
 e3e+l2b5x45VLjRwpgpdM42osrLxalO5vJf3+TycxNaHGVDI+7ZNUmIZd8DBcYL4jGOQLDwfemx
 B/tup1Yk7xgfX8jKFQHB1BkI1jimYC4=
X-Proofpoint-GUID: QW8kYCvocVeGVee9dGpeQQoyRrZma-65
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad5e063 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=YEx-fy-UkOsNpVOY4JwA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190036
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

The SDM845 HDK can be fitted with the display card, carrying a Truly
NT36850 WQHD dual-DSI panel. Here it is powered by the PMI8998 LAB/IBB
and WLED, and it is mutually exclusive with the on-board LT9611 HDMI
bridge.

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

