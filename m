Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CE7C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75C1610F3D1;
	Fri, 28 Aug 2026 14:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KG8n+NSb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y6AfVpC7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD54D10F3D1
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:06:02 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDkgcg3790343
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:06:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yBqLcLJpcQf9IwGh9XzxarcrFL0njgSazFzqQcBJXIY=; b=KG8n+NSbm3/ekFTi
 XjDzSOSlIkJrCWMl4mnUnpeFcYwMi9lljyPaxuXBPdfvTGHagV0RJ+DcuIVX0k/7
 EqTykGQaBvFXlz5uTR8Cq7vNrgoulzie1AD66XMgTvs7qesn1fj2FIYya8QOrk4X
 Cl3yJJoRPl+JYHi67Mg24kJCOC2djAZ4JeedpPIdRcv3yZH+tiY6sBCHNSPpRc1t
 ERQGva2lUPer40/Nvn+BXaXRwCGMwaZwufXGUh4bWwLrilGPAdK05V3ogGS40c3h
 6UQi3C9tvuP8IagEKMnm8vaU4JzLVtQLosZOp7lf4T6CplXlX/Z0+2Uh564K5xeC
 FDxVAA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb42p9wgu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:06:02 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52fc16ac179so9089121cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787925961; x=1788530761;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yBqLcLJpcQf9IwGh9XzxarcrFL0njgSazFzqQcBJXIY=;
 b=Y6AfVpC7o7v3pfsVP8rQoxrt8Jih/QEAT5ZVRIm3rhfuYkX2NP/mATxmi0fLAKjqaI
 wkG+iYhItJzXPsDyYF8cJGyi3FpP7S+JU5dkGO1CjLG2ujlbKlLDjEBTUvQWtH5wUhaX
 HStw8+hxV8dxw6gwOR7kv9MQOFOliW73nXlXagJ6itEIpYLvljPuCS9+1Oot02p6uvED
 qbAYUgj/0VTvlMx1h/vVVucHnDJmNqCABnhJBHi0e+9eEYfhFVhnupAjFTDRS3W1CivJ
 TNDhAV1i3DCG9EUIA8fOkAzjMrh/m1ji1SWZdVwXZ+6vLkKN5eVDyoLACKZjQ+42q1Oy
 gFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787925961; x=1788530761;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yBqLcLJpcQf9IwGh9XzxarcrFL0njgSazFzqQcBJXIY=;
 b=nbzoWrdpf0eLnlbXHRA6IeIIeqFG5Fml7+5HNFGbFbc5sj9ua8K4ccu1xlf2eXtmXV
 l365piWZqMtoSR+ozY/LLRv5we+v1WyQP8jPWxT4CUnbII3SxDasKFsua/txp7gXZfzu
 TVD8ccTitZbb56E93Pe7mD/fLvxKnD/MAxTtE/NidxJaM+U6gbVyKs6PkwkvK4G+3yZK
 YbF732z/cgzA/YRULy8hf4WWLxT8Xqd2A7nQvVxe5uw7H1Wy6vkehyADe6CefhB4oVqz
 bWanFG+edweti058PCxn3Do3GjJnJ0icXxigNyXS4gVRTRm9DPOSYZHvXbbfqydLWU5v
 +noQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQLalHvq2KC2N2xun4b6D9Ard3o/f/OnbxN4vBk1Rcwn8NyiFNYdmjKiU6WcYaqVGNZC4v75ttodg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m3QmZ+MrDGuNU4dT62PyhGj6Hlk7evVzJtS8LuXbrSMqzafMac
 BbgFZD9vTGDaGURScXXzA6N0K7kjekEmyuu7FyZYsDz0pcaw/p8kSwTvzVfOAV2fZSrzdNxBLDZ
 gHzsUxMcp79whZid/5+izv4+lDOhofWG8LT0Ffk5aaym9KVMehXNdROn/KnPnoHNbeG9DUgg=
X-Gm-Gg: AR+sD11gEJUcOjyp64sBRdnnwNiXiDsWrlLU3xhC9139UQsrFXtWnvcH7aLkoWpV4jN
 eLp14oJ/VngVfDclXu8ol7MCu72q6TrsDkeCJtY8lUs6f5leXEN4a48jGaqimIETHh7LBQhN7XH
 DglQjciugK4rpLLwbXT/SyEzPDnBZGFFR3jRI/5kCw7xlgqDbuHP1GEWPdWOHHUEVNZzDwsnTfq
 e1xiVUEzPO7yrfDsQHOjBt1dJ1x9pT3/OCuLOWAOgQzEmFh/LphoIx643akk4/9Z/GovekXlm6l
 43GxqjVO8Jcj4o/Hyl7FPPT7O0bQio5p4x7FJSEV7PtUsDvcWMRksQ/1v2vFMfGmk4P1+umGUBu
 lAr2EraMrwegVKKyP03X1mng=
X-Received: by 2002:a05:622a:93:b0:52e:125b:9444 with SMTP id
 d75a77b69052e-52fa1d2d479mr171378551cf.17.1787925961222; 
 Fri, 28 Aug 2026 07:06:01 -0700 (PDT)
X-Received: by 2002:a05:622a:93:b0:52e:125b:9444 with SMTP id
 d75a77b69052e-52fa1d2d479mr171377151cf.17.1787925960540; 
 Fri, 28 Aug 2026 07:06:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm3908633f8f.20.2026.08.28.07.05.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:05:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:05:10 +0200
Subject: [PATCH RFC/DO NOT MERGE 12/12] arm64: dts: qcom: eliza-evk: Add
 native HDMI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-drm-msm-hdmi-eliza-v1-12-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 linux-phy@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3179;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=u1bSkl1k9t9/uMluWadh6rXCGD8ZdDQlv9GwIeJhvIs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkZWiqk9i/2WoIbJ17LnGMdKK+fQvUgAh6sj06
 ktkn1cAIaSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapGVogAKCRDBN2bmhouD
 12rLD/9OWEuFU/08pzSSIz37CyxP2BNBpkm6TcXV3cyOKweH89yiNHt116VRkSOjcw7v6UYh9ge
 cIPuWlOkOey4qczsNFyZW96/Q3hmWjYG52AW79+69OjEazJ3KQXtBNBtaUxquA82mw5LZGyQZB0
 JDbVhW+qarI504Ybb1+kk/ufWZzN893ewD8PxoGemngHPkAMjhydTGm/GNnODoWjZGIs3WqhM+W
 U2o6NgIbPMw6kA0eRQ3/Mb/XQCcCUlnf9nSefmCke2zFMg0UThx8vUG7t9zoWQOBVGSKnl3pS6G
 SFSZzA9bEk1iZtugWsZusVkFuanC7YhEYVaY8kCWBEiZtqekfqeIFiZs10dlcZUPuJOqP+ERJWc
 QheXQpG56d6fIQ6LaYUppo/CcQlNf4L61F7dOIdC6ZylIyPvEImq/lk0bhJujYonMoaLcxWfzNU
 ZA8Yje2oSnGX7CdedakIVS85i1CgqGggN7MpT6Eg/W0FY7vee3RtasdYwRhhTEVNlIpftZL6x80
 TovlB4MP7qb4+Eba8s5YD7gVF9KzuQRUCJjxLlgrzCzvraDnolpGoU5NzsXq51TRve80I/RksMz
 BvqG2ORce0tgbblhAsvS1yTYIcu9JnNiVdMjuwlcSYbVFGbTLeG70Kvt0rpzneMYErx+PnntueH
 BfCH6tgo8jqWA3w==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-ORIG-GUID: PJDoVuKpuQ9LvbwkAbutMaTsCxmoey0e
X-Authority-Analysis: v=2.4 cv=ToDWQjXh c=1 sm=1 tr=0 ts=6a9195ca cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=O_mqdUvEFfx1mi-XM6MA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: PJDoVuKpuQ9LvbwkAbutMaTsCxmoey0e
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfXxTUIFgCyZOdT
 ps1lDySfELQXYVkg+via7n/boyIecow4Yi7beoC4ZDOkHpZVq28kJ98NL8hYASP+bc1xzyfH1mW
 h7r2rTGta/ujI4K1nLW5XEpVAsdZTWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX4+4Wj1EvgIHI
 RW8f1PfnyDYSJfuP25YEQeOogO2q0WsvPvKsbBqjInqSEGH1LYWU4P7R/Sn2hwEFnchuo8g/CCw
 NBj1b4/I0hikdjdrFr4S0H9Ibf5Dld0RJOLdn1dpYRP5Jz1tIGHZzhrUr2ICH/+R8Thv8fdF7Rw
 e/IGJpnshKuq4HMJ/fXvF1LMi8n3hoVC/HmBTaiDXW5npwjkJ9vz8826szv2QZ46nrbBHVub5E+
 lAQLDHyfM5L3nePH+NSv8OZ8Q8ZM2hl2ui3QpLuxaKkvIQOS+7t1wy/81srV7qtMdqyw/0Coq+a
 5ygVSjKZTzgYb5TuSc1bwzr0iG1vWmm5Lsc5HMZQ+HgKunwnm7axnhtGYnpPnpVSzGJ5akcrsVh
 MSraOkS4fM8wZ1M+hefe1zQkQDhFXuMJSuVZDqeimvCiLe1xbhHzw0oi4yGYI1ANYxJIq1wL8Eu
 zy6llpvPBoPFuj2iRnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280122
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

Eliza EVK comes with two HDMI outputs: native eARC and via Lontium
DSI2HDMI converter.  Add the first one, with the 5V power supply.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 103 ++++++++++++++++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
index 2fc945658300..533d52ecaacb 100644
--- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
@@ -12,6 +12,29 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	hdmi_5p0_reg: regulator-hdmi-5v0 {
+		compatible = "regulator-fixed";
+		regulator-name = "hdmi_5p0";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&tlmm 184 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		pinctrl-0 = <&hdmi_5p0_state>;
+		pinctrl-names = "default";
+	};
+
+	hdmi-0-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_0_connector_in: endpoint {
+				remote-endpoint = <&mdss_hdmi_out>;
+			};
+		};
+	};
+
 	pmic-glink {
 		compatible = "qcom,eliza-pmic-glink",
 			     "qcom,sm8550-pmic-glink",
@@ -51,6 +74,34 @@ pmic_glink_ss_in: endpoint {
 	};
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_hdmi {
+	pinctrl-0 = <&hdmi_ddc_default>,
+		    <&hdmi_cec_active>,
+		    <&hdmi_hpd_active>;
+	pinctrl-1 = <&hdmi_ddc_default>,
+		    <&hdmi_cec_sleep>,
+		    <&hdmi_hpd_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	core-vcc-supply = <&vreg_l2b>;
+	core-vdda-supply = <&vreg_l4b>;
+	vddio-supply = <&hdmi_5p0_reg>;
+
+	status = "okay";
+};
+
+&mdss_hdmi_out {
+	remote-endpoint = <&hdmi_0_connector_in>;
+};
+
+&mdss_hdmi_phy {
+	status = "okay";
+};
+
 &pm7550ba_eusb2_repeater {
 	vdd18-supply = <&vreg_l7b>;
 	vdd3-supply = <&vreg_l17b>;
@@ -70,11 +121,63 @@ &sdhc_2 {
 };
 
 &tlmm {
+	hdmi_ddc_default: hdmi-ddc-state {
+		hdmi-ddc-scl-pins {
+			pins = "gpio6";
+			function = "hdmi_ddc_scl";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		hdmi-ddc-sda-pins {
+			pins = "gpio7";
+			function = "hdmi_ddc_sda";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	hdmi_cec_active: hdmi-cec-active-state {
+		pins = "gpio46";
+		function = "hdmi_tx_cec";
+		drive-strength = <16>;
+		bias-pull-up;
+	};
+
+	hdmi_cec_sleep: hdmi-cec-sleep-state {
+		pins = "gpio46";
+		function = "hdmi_tx_cec";
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+
+	hdmi_hpd_active: hdmi-hpd-active-state {
+		pins = "gpio47";
+		function = "hdmi_hot_plug";
+		drive-strength = <16>;
+		bias-pull-down;
+	};
+
+	hdmi_hpd_sleep: hdmi-hpd-sleep-state {
+		pins = "gpio47";
+		function = "hdmi_hot_plug";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
 	sd_cd: sd-cd-state {
 		pins = "gpio58";
 		function = "gpio";
 		bias-pull-up;
 	};
+
+	hdmi_5p0_state: hdmi-5p0-state {
+		pins = "gpio184";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+		output-low;
+	};
 };
 
 &uart13 {

-- 
2.53.0

