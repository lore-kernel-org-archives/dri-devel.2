Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81185606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RLoLN7+C;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iEzMoarS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F1610EF8F;
	Mon, 16 Nov 2026 11:35:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78D4A10EF8F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:35:14 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGBM9N33032706
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0thsqEQypwpZodKDEOlWAqW0XOK2Cxlrn9ugpmJDNRE=; b=RLoLN7+CSSjkTb41
 0nhiV2uP3XWJk/IO8dNGDi4BmyHc8MpMtOMusspKeSY6o6ylIR8aII95t6axLaL6
 MGpnul0nv3A5oSSq77N2aA028kw1BOfW2zyELZrzmnyiU5blXhQJEy+b3Vu6sJEF
 lwR3Wv3mEi/WS56VoacbpqGAymUfTnYM8x5JJS7cRemHFQ8ITBjOTD/fi0gzPz6G
 nT87zg7uDygjiYAU5S8IxD1ZMH0ysTdGWWO132HDRNPjXdLYNK7LEvPF2H0PsxH5
 qMgurVTWIr1s1dLw4Itgrk30aH+dYRPN905dz16uYXogao+28W6qXgokXeO5JZti
 rpP6ug==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyxcf0mtv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:35:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b15e47e57fso2014390a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 03:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794828912; x=1795433712;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0thsqEQypwpZodKDEOlWAqW0XOK2Cxlrn9ugpmJDNRE=;
 b=iEzMoarS3mRBLA26KtCvj+V7R3qIxd7XVBgFRIVfvzdyC7BQp+rK6mMtaf+HO+qKwb
 iagxc8nHMXB+qYSKYns5GfdU40AXH1NWHz88C2FR06s+U26pBwxWX0tEI9Qw393XaZMu
 RJ5Gd5EYMUm3+mGiNbnMMRiIjCNdwINAY4DKpJSbXWfnyE/aGYLClFRcOdBadWav65FL
 +Js8jaG19QeBfeha4fj4R7uSRYdjnGrpWlCh3kQGEZXye9T1J18JPdGyKmXRhewP+mBo
 mN6xOAiJcaxTU6raTPzHCrORT4BO51dSVqxmDzoSjYZB1Gnx95M2B8SNO9rl0ri1rGlc
 BpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794828912; x=1795433712;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0thsqEQypwpZodKDEOlWAqW0XOK2Cxlrn9ugpmJDNRE=;
 b=DVseOqUSjny9mrl08xuHfd5m7YsdEvWMBiQ28u1degFnZX1/6SMMWswBTo0/L80c4m
 BLGJSYWuJxWTaeDivslGtyOUhZ6NxlOmure0lZ8KY/4UpzXAzY4Aoqt9EnFrT3DeVDdJ
 OP3Qs+9P/GGrM7FW9eXGKsc9/WNKVWtFbmOsxRSc5PlksHcrUDNPS2pH0K+28xWuH4Ay
 qDivUIIaLfaDeRIyURPUzYoT76lJblcBnyevQB1M7K1UhsYNCcbBffcbmN1lcQr3nJxZ
 MDTn93g3h8352MsuVMjxCVKPkfhNd5vlhmxHIMiHyQjByTuik4rkdCmzkAqFesfyi0da
 QdWA==
X-Gm-Message-State: APuU4Z+wSH5xM90O125rSkRv171+akotgSAFo1wlcCJyLtutJ8wmeSOi
 k15bcHMIt0BrfvjH4xPmx+I+eR5lqgDLHJsxLdhx12m3AZ/x7gXGXybIPNfjKJepJqCptQ9umIX
 AiKVCmYzmfGWuO/XROlniBf8Gid4/tUI1By/ySXNXR08WbLg4EdK/ygbrEwv2UGnZA6JOt9JQRA
 Knp8k=
X-Gm-Gg: AZFdTZcXyPLljR67+KpVNeFyP0N9zXERu7pW8o0gR3rw8Dg7T6+a/I7/L1KbUVTgPh6
 8YXoaQjgaJ0vqUThUpTaJU0Ix6KNmTR4jQMesmpQ17rCWEsrnUUWiJXbsTZuAsOTI7aju7lMKRk
 5ATI0an0oy6yUDmePfTtJkbn/XCO/opC2IZbyAmHoC0vSalT2s55Xwn/Kb2BGDTwMwT0Ej8+oeV
 ahDPhLImhBfqEwZfU6uquosDSCGNOGwtuKsipqg4KUXzXTinsFNOyoouFxk3HQUXYiKI6SgyRvy
 jvfmSDFAze19O5wrUOxGHeeVa2N4BxacHL23azvnjbrT6n0qS81hv2bph7AClY3CWkXkk2Wm9sS
 o5ps4B1aG5aY4d4+GB1vZGG6F4gcvy2YvpHipmA4wNo9eK73UMPa/MgEDXoQLKJL6LPFTs/uTq9
 Uy
X-Received: by 2002:a17:90b:55cf:b0:3a4:9dd7:296f with SMTP id
 98e67ed59e1d1-3b1b0a46728mr8948188a91.40.1794828911911; 
 Mon, 16 Nov 2026 03:35:11 -0800 (PST)
X-Received: by 2002:a17:90b:55cf:b0:3a4:9dd7:296f with SMTP id
 98e67ed59e1d1-3b1b0a46728mr8948162a91.40.1794828911429; 
 Mon, 16 Nov 2026 03:35:11 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d27d26sm21000719a91.13.2026.11.16.03.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:35:11 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:04:07 +0530
Subject: [PATCH v2 4/4] arm64: dts: qcom: glymur-crd: Enable HDMI output
 via PS195
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mahua-hdmi-v2-4-0b5af6bf9e70@oss.qualcomm.com>
References: <20261116-mahua-hdmi-v2-0-0b5af6bf9e70@oss.qualcomm.com>
In-Reply-To: <20261116-mahua-hdmi-v2-0-0b5af6bf9e70@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794828874; l=5443;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=RcljMfYUbyalzdgq7MXeMZXwNq3xR/p30j1AzKNOXPc=;
 b=L4NiMBIz036/oqx54VL20OBls7Kj56F/K1Z1F5PhlaTNkQkWy4HMQKNTwTYE1kjzegmU4/zOG
 jBYPkaL1DKCDcTbHyWxKgUfISrJmFvXyb/WK2/pqW/J6LYT3gQhV0sG
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0NSBTYWx0ZWRfX7LmuNiy1NHQQ
 F3C7KjpZou+jGTLnFwYCVX6mdnsavB9uxRs1BfuhQocFmkNN6EdDWyWpiMQMjeCMgpMjo4HGgER
 ec2hjuvWvXRimaxA45JGqfZicJ87SI/wIyp3FgFYeV1j7O2V/0R/CJEVjm2HtJF0eokSzqDDHct
 qc9YMVxeuliZqOfWyotMmYOJ2nyg+ASr3lWX81EOS0XtW2wWUb+AnjUHaCy6IFpuzfRZVcBISU5
 8fwtQvDqFKL+XN806EqRKWzTj6rusX4Ez6sz403kw6NGOaFNmoB1sfFua+aeG3HQFvGuT0YsG32
 NmhwztT7KRPKeo+l7sh+zseD/8BD9Acmd+FrzE8wkMRBPdAs6GoN9QBa48/E75XeHkl3UK6G3Qd
 W+vYsIfF84+KdNHVhE5q79Fhb2UZQ0mfIubvtx2Z5etY0DVsbzFoTtfMwXZMs4HSvpp1FGrspHi
 oH39tUsGkbrZtQVy3rg==
X-Authority-Analysis: v=2.4 cv=RtZQvymK c=1 sm=1 tr=0 ts=6afaea71 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=4OHBDxuNJHQT2aTpCosA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0NSBTYWx0ZWRfX/ixbia7XC5J1
 vUojdpq8+HTrIjC/8KUxTMSJcoiMWGXSU1xcRdvAwInawi1nNejKbSVRCe7xgrjDzHdITWfb9mU
 usd7Fi/cHcqGBrV6tDukQznK99wGLAU=
X-Proofpoint-ORIG-GUID: httITPUs_M91I_3ZNwxlnRJPeChn02gV
X-Proofpoint-GUID: httITPUs_M91I_3ZNwxlnRJPeChn02gV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160045
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Enable HDMI output on Glymur CoB/SiP, Mahua and Kalambo CRDs through
their shared glymur-crd.dtsi.

Describe the PS195 on i2c13 (qup1_se5, GPIO52=SDA GPIO53=SCL). The
PS195 GPIO11 is pulled high on this board, selecting I2C slave address
0x48. Add the three HDMI power supplies with their regulator-enable
GPIOs and pinctrl states.

Connect the four-lane DP2 path through the USB2 QMP combo PHY to the
PS195 DisplayPort input, and wire the PS195 HDMI output to the HDMI
connector. Add the GPIO126 HPD pinctrl state to glymur.dtsi.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur-crd.dtsi | 147 +++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/glymur.dtsi     |   6 ++
 2 files changed, 153 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
index 2ec62423ad79..d875ed69460e 100644
--- a/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur-crd.dtsi
@@ -63,6 +63,17 @@ switch-lid {
 		};
 	};
 
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_con: endpoint {
+				remote-endpoint = <&hdmi_bridge_out>;
+			};
+		};
+	};
+
 	pmic-glink {
 		compatible = "qcom,glymur-pmic-glink",
 			     "qcom,pmic-glink";
@@ -142,6 +153,53 @@ vreg_edp_3p3: regulator-edp-3p3 {
 		regulator-boot-on;
 	};
 
+	vreg_hdmi_0p95: regulator-hdmi-0p95 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_HDMI_0P95";
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <950000>;
+
+		gpio = <&tlmm 55 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <1000>;
+
+		pinctrl-0 = <&hdmi_0p95_reg_en>;
+		pinctrl-names = "default";
+	};
+
+	vreg_hdmi_1p2: regulator-hdmi-1p2 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_HDMI_1P2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+
+		vin-supply = <&vreg_l18b0>;
+
+		gpio = <&tlmm 54 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <2000>;
+
+		pinctrl-0 = <&hdmi_1p2_reg_en>;
+		pinctrl-names = "default";
+	};
+
+	vreg_hdmi_3p3: regulator-hdmi-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_HDMI_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 170 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		startup-delay-us = <2000>;
+
+		pinctrl-0 = <&hdmi_3p3_reg_en>;
+		pinctrl-names = "default";
+	};
+
 	vreg_misc_3p3: regulator-misc-3p3 {
 		compatible = "regulator-fixed";
 
@@ -519,6 +577,40 @@ touchscreen@38 {
 	};
 };
 
+&i2c13 {
+	status = "okay";
+
+	hdmi-bridge@48 {
+		compatible = "parade,ps195";
+		reg = <0x48>;
+
+		vdd09-supply = <&vreg_hdmi_0p95>;
+		vdd12-supply = <&vreg_hdmi_1p2>;
+		vdd33-supply = <&vreg_hdmi_3p3>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				hdmi_bridge_in: endpoint {
+					remote-endpoint = <&usb_2_qmpphy_out_dp>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				hdmi_bridge_out: endpoint {
+					remote-endpoint = <&hdmi_con>;
+				};
+			};
+		};
+	};
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
@@ -545,6 +637,17 @@ &mdss_dp1_out {
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
+&mdss_dp2 {
+	pinctrl-0 = <&usb2_dp_hot_plug_detect>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mdss_dp2_out {
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+};
+
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
@@ -826,6 +929,27 @@ ec_int_n_default: ec-int-n-state {
 		bias-disable;
 	};
 
+	hdmi_0p95_reg_en: hdmi-0p95-reg-en-state {
+		pins = "gpio55";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	hdmi_1p2_reg_en: hdmi-1p2-reg-en-state {
+		pins = "gpio54";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	hdmi_3p3_reg_en: hdmi-3p3-reg-en-state {
+		pins = "gpio170";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	kybd_default: kybd-default-state {
 		pins = "gpio67";
 		function = "gpio";
@@ -1035,6 +1159,29 @@ &usb_1_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in1>;
 };
 
+&usb_2_qmpphy {
+	/delete-property/ mode-switch;
+	/delete-property/ orientation-switch;
+
+	status = "okay";
+
+	ports {
+		port@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			/delete-node/ endpoint;
+
+			usb_2_qmpphy_out_dp: endpoint@0 {
+				reg = <0>;
+
+				data-lanes = <3 2 1 0>;
+				remote-endpoint = <&hdmi_bridge_in>;
+			};
+		};
+	};
+};
+
 &usb_hs {
 	dr_mode = "host";
 
diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index 65a398c0a992..2d3f8fe2cf5d 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -6793,6 +6793,12 @@ data-pins {
 					bias-pull-up;
 				};
 			};
+
+			usb2_dp_hot_plug_detect: usb2-dp-hot-plug-detect-state {
+				pins = "gpio126";
+				function = "usb2_dp";
+				bias-disable;
+			};
 		};
 
 		ctcu@10001000 {

-- 
2.34.1

