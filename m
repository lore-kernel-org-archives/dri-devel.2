Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E1A2D39406
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67DC510F081;
	Thu,  2 Apr 2026 09:50:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=quicinc.com header.i=@quicinc.com header.b="FfWf84ZJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7665B10E409;
 Thu,  2 Apr 2026 09:50:28 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6327HGXH3044207; Thu, 2 Apr 2026 09:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=j/xYMmjVgEX
 gdxV48wdb3wGntOFFuiUnKCT2/b5NadA=; b=FfWf84ZJUaRx87TkgVJsW5G/YLD
 N0QdrBImTt05FEXTE6o9VASqAD4exqXh1uM+MNfZnxWDGmXrrjr1SYfP+gjQ7vRE
 hOpacvDZ9wCY8XxXaUpVcr1xF6Bwm0EX2WADCwQWJC+28k1rLUWLRd2SpwmJ3E5s
 3S2tpbO3ZXJCDesH0qx1JNeLCFb//7Ing19X5pxKPERDzlwDI6UWzF7wt1FdMnwP
 KvWodcIj1tOILslAaCZak5nVka1Styxb9o4U5HrjwWmmfzGe5HNG+dxDw4K00z/1
 sr40ytrniBQ9Q9wCcpioFRYew3fwlNbpANCWoKwCIp/kPbPMozN3uytqXvQ==
Received: from apblrppmta02.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9483v8fn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 09:50:19 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
 by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6329oGU9004382; 
 Thu, 2 Apr 2026 09:50:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4d6qk2m86k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 09:50:16 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com
 [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6329oGHC004362;
 Thu, 2 Apr 2026 09:50:16 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mkuntuma-hyd.qualcomm.com
 [10.213.97.145])
 by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6329oGYd004354
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Apr 2026 09:50:16 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4582077)
 id B402F5ED; Thu,  2 Apr 2026 15:20:15 +0530 (+0530)
From: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
To: dmitry.baryshkov@oss.qualcomm.com, marijn.suijten@somainline.org,
 swboyd@chromium.org, mripard@kernel.org, abel.vesa@linaro.org,
 andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, robin.clark@oss.qualcomm.com,
 jessica.zhang@oss.qualcomm.com, abhinav.kumar@linux.dev,
 sean@poorly.run, airlied@gmail.com, simona@ffwll.ch,
 alex.vinarskis@gmail.com
Cc: Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 quic_rajeevny@quicinc.com, quic_vproddut@quicinc.com,
 quic_riteshk@quicinc.com,
 Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
Subject: [PATCH v5 3/3] arm64: dts: qcom: lemans-evk-ifp-mezzanine: Enable
 mdss1 display Port
Date: Thu,  2 Apr 2026 15:20:03 +0530
Message-Id: <20260402095003.3758176-4-quic_mkuntuma@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402095003.3758176-1-quic_mkuntuma@quicinc.com>
References: <20260402095003.3758176-1-quic_mkuntuma@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=RYydyltv c=1 sm=1 tr=0 ts=69ce3bdc cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=0voD-ITsHmux3e9IgYMA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA4OCBTYWx0ZWRfX1hsR09aS5PFY
 h6bJ7zyEy1VJKQ4pHwNZhEM512SKuAZ1zILLsdKWeZKUZmUph3Kd9yCAecJQs6Sd8sEb4vLD9iA
 emJcDbPIFavK8/4WVR7cEGmzmwkNIRNcctw7QtXA6CVK7aoLxtAng4JAvW7RVTK6C5mi1GJN1BR
 ON/ZJVIr650BiXvSiaJWASSKjMyuyVwCJXIEuRX2n+BmzJQ2XpnKQCOZ1LDqbe6cr711fVntmnI
 T6RuJYU2z3iRaWDAioFNyfOe1s/TpszvKuCxcIRz3MD7bR6VF+vhghlcBPl23kKqoML967eOJDk
 j/7XPjphj9XGDKFeFwatt0s31Zq7mleDIR7vn5eCpbeT/lb21kp+vNLykmL5b57FJcqbT6zqY8Q
 sKWy6jQC9+49Dzt3RmXHD8ZvFShEzpWIpKdJT9hhlpIZC4E8J+odVv+JG5CWrIHBQ/3wCvXl2ID
 18zku2RR+9hgR30EuDA==
X-Proofpoint-ORIG-GUID: f6XuQancGbzBxrIPkTdPrUqEW_W-HNuu
X-Proofpoint-GUID: f6XuQancGbzBxrIPkTdPrUqEW_W-HNuu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020088
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

From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>

Enable DP controllers, DPTX0 and DPTX1 alongside
their corresponding PHYs of mdss1 which corresponds to eDP2
and eDP3.

Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Signed-off-by: Mani Chandana Ballary Kuntumalla <quic_mkuntuma@quicinc.com>
---
 .../dts/qcom/lemans-evk-ifp-mezzanine.dtso    | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk-ifp-mezzanine.dtso b/arch/arm64/boot/dts/qcom/lemans-evk-ifp-mezzanine.dtso
index 268fc6b05d4b..44bd9b1a1765 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk-ifp-mezzanine.dtso
+++ b/arch/arm64/boot/dts/qcom/lemans-evk-ifp-mezzanine.dtso
@@ -11,6 +11,30 @@
 &{/} {
 	model = "Qualcomm Technologies, Inc. Lemans-evk IFP Mezzanine";
 
+	dp2-connector {
+		compatible = "dp-connector";
+		label = "eDP2";
+		type = "full-size";
+
+		port {
+			dp2_connector_in: endpoint {
+				remote-endpoint = <&mdss1_dp0_out>;
+			};
+		};
+	};
+
+	dp3-connector {
+		compatible = "dp-connector";
+		label = "eDP3";
+		type = "full-size";
+
+		port {
+			dp3_connector_in: endpoint {
+				remote-endpoint = <&mdss1_dp1_out>;
+			};
+		};
+	};
+
 	vreg_0p9: regulator-0v9 {
 		compatible = "regulator-fixed";
 		regulator-name = "VREG_0P9";
@@ -141,6 +165,44 @@ mac_addr1: mac-addr@0 {
 	};
 };
 
+&mdss1 {
+	status = "okay";
+};
+
+&mdss1_dp0 {
+	pinctrl-0 = <&dp2_hot_plug_det>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mdss1_dp1 {
+	pinctrl-0 = <&dp3_hot_plug_det>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&mdss1_dp0_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+	remote-endpoint = <&dp2_connector_in>;
+};
+
+&mdss1_dp1_out {
+	data-lanes = <0 1 2 3>;
+	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+	remote-endpoint = <&dp3_connector_in>;
+};
+
+&mdss1_dp0_phy {
+	status = "okay";
+};
+
+&mdss1_dp1_phy {
+	status = "okay";
+};
+
 &pcie0 {
 	iommu-map = <0x0 &pcie_smmu 0x0 0x1>,
 		    <0x100 &pcie_smmu 0x1 0x1>,
@@ -235,6 +297,18 @@ &serdes1 {
 };
 
 &tlmm {
+	dp2_hot_plug_det: dp2-hot-plug-det-state {
+		pins = "gpio104";
+		function = "edp2_hot";
+		bias-disable;
+	};
+
+	dp3_hot_plug_det: dp3-hot-plug-det-state {
+		pins = "gpio103";
+		function = "edp3_hot";
+		bias-disable;
+	};
+
 	ethernet1_default: ethernet1-default-state {
 		ethernet1-mdc-pins {
 			pins = "gpio20";
-- 
2.34.1

