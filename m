Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAACCC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFE8F10FE7E;
	Wed, 14 Oct 2026 16:20:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9344810FE8D
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:20:19 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb0vF905402
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YvA5VN9F1N6zF9xJ2DQD0VDFC0d4+++etjYaQC8uc3Y=; b=LoJ0DLHx+hzj50SW
 Mz+/y+fdRXGzkQVhoaK1cTkTFZR3onkq6dlJbo8VSkdfi1YMC/XFTW16aq7BnyCc
 S6mlzMXTKwf0vDlN14S5C2OllMLnValya98x4hg1WoIiViQiHGEA4u5ecRFpO/4y
 cj2yjNXsPItG/Z4EM97wJX5rkc0rJXRGO75dhPQ6/c+VudXaxtrrWk++GaSkj9xw
 DHvF04ABxhZ0sA5njSLGldxdQl32G11mc3fRXG3BGDge5XeHMhekvvhho3z+HDxf
 pwbA591ik/XpDkgRBlgrCUjfHyjVEJhw2cvfqVABQ4uZrdbHYL2gKH7kykGpEVVu
 jFxECQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p2h28-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:20:18 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-939c30aa9a0so64414685a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 09:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791994818; x=1792599618;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YvA5VN9F1N6zF9xJ2DQD0VDFC0d4+++etjYaQC8uc3Y=;
 b=a7dCXkqhVC2B/Gn8kGDSxYOspeF1UFApYiaFo13S+atTFYDrUjMGa9RWtGEsgKDkR2
 Ah303ZkYLfGBYBZEoxC+shUhy560k2VZ2fq401WmMiUAhGbW6FQ/zXiXFZElRgMgoy0I
 jq+MwdfnBWVz2L/8oGdAHnYxOwlWayPJBAl02VOEW7JEST0uO4WvgSpXIKanaSjs29Ct
 eCM9ss6IW0SCiEoeq7V661styDQz2w3ZvHN9iOOVd9Mg4gWJuANlamcYI4zZ49uaCtwR
 VD52F4d/K8XmY140ZKnnAUU8qjzQRCwdm+sCw0evRRdbp3PAGN6HjftS0plxaAd7wWLo
 0MVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994818; x=1792599618;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YvA5VN9F1N6zF9xJ2DQD0VDFC0d4+++etjYaQC8uc3Y=;
 b=H+7Q/nOifnCh+tw/tTG9EL6lLjGOsEz6ORlQhtVDvNUcboxfmmhETXYx9fgpp8fSoO
 eh2FIK0CEr+Zx9GLvllSpaA/aHjmK/Ez+YEpS9HbLsuiDz24Zx3klgpN2LJv6J+dE2OY
 WotLNx5wSjBHtm5VyTO7ECFF8cDu5+gHvNSn7/7ZnpcO+0F3YUv/2ejGZRhiTzLfNg3R
 u8Tnt5lWWGrMHp/fOK/K1bookzps2i5hfDfR0tMAvmSET4SshfcmXwWkF1BMP9hM3fqC
 6Ql4Y7CvK0sbkCQgLJ/KiXdmdDavGQe89Cy04Y4Fy7jSAe5H//6q+c0pnztHjxJ2MnqO
 3VKw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzOWOiax74lWkUHnvPKX1J4FI0noWxe8wYbWp+RPlGH2aLHi94Nqjm+RjNGwHuBGHRqXeeN6/apic=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLL3MiGvZ1qWBx73b8ij7P2l+IHQh+X51gEj7lT6gfmc28/6c/e
 5NHwfyEOeS+x1Ntlm0asKuARwv07x55golwN2hoz2wwYXpcsL0mAj89F+CzmmzONU+4n9m39BMI
 wRmZj/zLkCsqu2JdrTIl/6TLTt0tMjpOWuksZ8qHMS5gJkJTq2uWJSVFzNvcLgSCtz27XYV0=
X-Gm-Gg: AYBFou0kDsml+FTHhXbEeKYASG0mKbZ/TNLYjoPtQxQiXjFliuC85r83IzimqPWHmFc
 dsiutwrhy3AUPddlrT3VmHEdSOxo8ENyG9MoKcJOeuDx6xK6wUj3EosDTQ/BgdtR6ETZv8yMu7X
 za1cjiAlZluoAffV1u6nEcRUUZdjb4Mc3sP8UfnLukr64ltL94zBWFqUvILBpWDI6wX5FO3ptgN
 3ThMfGaODFbw9tJKpr27lWobZCQoFShuSMa/k7SuvtJQZeEW5imI3DO7T89ZugmcDnQ+sF2BMmP
 vEbclUivoqeg4aWqBAjyjcawHvYXmEXime0aBPMyAvswk+iO9wV3K40Zs6LEvGdp7SjbwYfnrXt
 jzmXPCMdbPC9nnz1fCGVbQ3D/7JXhAY+0yPAzAOmP0zh98xdT+wbGFqYKCaZjo1QGgwDFXi4M0F
 XiXyESjLyfKlbq
X-Received: by 2002:a05:620a:4714:b0:939:ff11:5328 with SMTP id
 af79cd13be357-93ebd211034mr2620943285a.24.1791994817466; 
 Wed, 14 Oct 2026 09:20:17 -0700 (PDT)
X-Received: by 2002:a05:620a:4714:b0:939:ff11:5328 with SMTP id
 af79cd13be357-93ebd211034mr2620936885a.24.1791994816864; 
 Wed, 14 Oct 2026 09:20:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5be33d7d0f6sm740187e87.38.2026.10.14.09.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:19:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 19:19:20 +0300
Subject: [PATCH v2 5/5] arm64: dts: qcom: sdm845-hdk: add display card overlay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-sdm845-hdk-v2-5-6d0b4b42f267@oss.qualcomm.com>
References: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
In-Reply-To: <20261014-sdm845-hdk-v2-0-6d0b4b42f267@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3759;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=fiG9JOwZ9RgoyoDyD6yndaiq97l2KW6CcMhSb/W8evw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqz6uIKiPcnuT84rLen1AukFunySURVM0g03Lh1
 21lVTg/aQ+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCas+riAAKCRCLPIo+Aiko
 1XhoB/9pOmvOIaU1s0UmuN4LFEoRFcc6VK4R6vVfvDVOnjFiZkVFdV+RE8eVTfFJT1Ah996kYXj
 ckn1icJBgL1uw5U4+95RDZu8T/ukocAdgHJbUST8ZI5wfcdu3h/TGmEeRLPNvgBUq4a3yJp2mdH
 AL/21pc4fJCMNq7IcSmrdZ9GNrkB6w60UAERE5BDY+/aEQDPhBmISsoA2czMwcyVCAoDBAQws8E
 NL4oWqdPfwMHTdIxCT2wOR4RAkgBUIZHZsaGbj2MffARKX0Vy1KL8HUmmikZypFZzl+86OQ0DuM
 1j/hGjWGE0xvnPnfCu2iPizghyiKHhlOo9cSS4kXet714zeA
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2NSBTYWx0ZWRfX9PUublY1EF08
 NiSdxpw8aVAABRyg+sZVZwZg3+U7LrDL9FUQuVSPBtLaTZhus5xAIvtUvq7FCv9GckJ565v8zeg
 ZCzclEiaMRYK7W2Aw+G/btTkdc0zo/c=
X-Proofpoint-ORIG-GUID: JrjZg1x8VScxft-pSY6iITju-oGPoES5
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acfabc2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=FFXsBguXHA8yshPlDHEA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2NSBTYWx0ZWRfX0s6n/lze7v5b
 5lugiRWC4a52T5q5OYVW9Wh8WnbD2uJUadU+Plb8AJn3Fkh6VvLbCjZm1yf2XqpvrcThjDphDyJ
 7EPKPP0AFQv6Qd3phlhFuNdffLKeSsxtfe+o21CbwNA0KiqQCV8G0WxLCdnnXwJiDoumXcvkB+7
 U3Ckfn//tZ2oOIJuLDEz1PQYjGU/b5mVqawaoIWgHBE5YgjqnM3rClNDZst5wbJDMLduNhDtO4l
 xWKWlQQs0pb1+OrZX3VpR+Asfmy3BMgYyQYFDernv/zTrWdnmXQkQC0sFJ+WU1OcJ9cuwc3DWC0
 qvUvaCDcjPfv4PGxrrND06FC/88ukYnxRgGH0Vt9batplXrMWnnmwNots8u9oHIhzGpF+2xcRk0
 ePIKFzTA4lk74BNZ+wXyC4l85Fkf9M3J0hts6jnQSrziLH6b6+KXdI3unY3sfNtuVrcSgOoRR4J
 6YrjdTb85gRmxHRsj6w==
X-Proofpoint-GUID: JrjZg1x8VScxft-pSY6iITju-oGPoES5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140065
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
5.5 V default of the LCD mode and the mode select line driven low for
the dual port mode.

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

