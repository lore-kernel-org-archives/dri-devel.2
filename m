Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139DA105F79F
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 12:09:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 729A710EBCD;
	Fri, 13 Mar 2026 12:09:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g1PXikGI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qs1A0eAM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8842110EBC9
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:09:01 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62D9BBPa3906354
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=egGAxOwk9R6
 89T+8fcc+V1K/8ByaJLUJQYO2pJTl7JA=; b=g1PXikGIwNSDOwRzXEgH+U/NVha
 E+SkljxZgSVLgNVzJKQtEuYs185gReRp3SAA3llMJF/DW25834+j9u4+efkWMTPv
 q4SARiuZDDKybVERjKCFFRTdcZmztpygU8xlncK1LEzn5CVCMzN72jFgBC19S5M0
 E5bwKj9D8r38Af5+A+bftuipYjtrhybhO8/IVwBzoHV8qtBCJHB7O6SASdkBPv6I
 O3d+sANTzOY7dQAC1CNf/N3qFQYrxo+qsT4q7apnCbRp5FzUZ06gYZwFMJF58FVy
 J5A/nyHDUzo4otgj9bSPwtUEw3iG+LyYGwSbgPMkhNI9Uu2nkvCNYrT+WDw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvfqs8j48-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 12:09:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35a1a764225so1623778a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773403739; x=1774008539;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=egGAxOwk9R689T+8fcc+V1K/8ByaJLUJQYO2pJTl7JA=;
 b=Qs1A0eAM1OY74jVzP212MfFnE+c42x2efKVjUQUtIkh5IOHWud0K2NK6XZBJUOcLcp
 qe2SNH4oRWjL3WqMx1BaHp7whdnIoo6SH49xOjPDhlJpccTOLJEFOjs0zUoednIM96Zc
 tMhnvKgZdn9PNc91gjqlc+5w1ltsUclFRyD2q/b5Nuzx9qvQ/1/ErRGx0livxptmBd/t
 eu7YBA/k7MxWWzblPNYT8mO/BfaxF/Ysh7HMZ/sYjuGIpf3IWsez09Qd13dwQCYILmXK
 0pIEV+ceb1J5pMNLLPwsTlde/QkU+aqV5hFMf9ONufwsYdowIrpK/KjgoW3fy4+t2dvX
 OkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773403739; x=1774008539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=egGAxOwk9R689T+8fcc+V1K/8ByaJLUJQYO2pJTl7JA=;
 b=Kb6o2fmNZqLc4IFZuFxeqm9UXktnWH+5NZahLo9/SJ/ylQ3XMZh9BHVUWektj1ejV2
 v/XY1vmp1+q7jZ6ouG64xbmIAFtN0DyyvZtjsjn+eEkBFl0iD1OoL0S1ZeEZc8R68v5r
 97GtUijN8zCjSxk+ziDIM2fVgAIiTTE1rDHUKfryaA/mAGQmLJtn5zlWAI59gk1En1Xg
 md9gCTHYrdnnYswQvkvDgx7M7FcNfuFzM8SAlkUBDUwzBHx0f7nWOPlT5ejqCHRPVgpR
 +JcB2rIZ6P+IT376hfvwAC+Woe6RxKdlHd4aUUxZHnAajy66FaTGhGnLeJZtFgiVB0Yq
 uQIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEmMdIWiASIg+aAjCu9FI3KduPxu1g9gOGsXt7fmS/V8611AxgAfsI79mHJL7R2xfOVjABETjcu4Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxKnGXZGVRCDyNKep7LNWGJxWX+RuibxRBGZe35+ChY+hCyZiA
 jlsWqMeCM8wPb5vqAYP71tzA5PV4w5NBSosckN6exLtFN1bRshoEuktAjAgGrtdwm8XFA9xgXij
 OOPi29IgGQReSYw/+16sCh5UH4rjSmvO2gtDHIKJSd8dDj0vq3K5uUfFsfMxxtcVPtashfPMU/3
 SQSZw=
X-Gm-Gg: ATEYQzwgSfdt9mpA1UefIffUDJ5hm6YgV3p/1xpU04yoUl1HsOrk4LW2H9pYtIXhM4l
 OI0cadxIdiDBycIrN2XFHyYXTQzf4+rtuaSrYiIt8ZJTHt5dJfE4bgI49TSZG8nSEBSeR+HI+hh
 wFxO0HNcHoZO+Il5jYvcStJ+E0q1Qe+yDzF3a7zoMj0XcRVz4IXBpJI3MXFjK2lYxtAU7CcAmjH
 POzdGvvecFY6x3fThJLqUEyoDvpyDtEsaglgYgYjF35zKy7wkg7bYp6p3UcgBId8wKPZXLOfOCs
 3iKS6x8UzL6MAcVT/ugQHZO7+qk1FzsOKBsNpwLKz/YT+pANDDJbTKT7DhxaP5HkWovqtUFroKv
 v4GguMyonDS9N9jbAzuc3Q0IjsawBgSRLWV9lfs7lsR6MYHNxHgos29E+/li2WEuiha/alLfmQa
 pnLGMYoEh34FlFlh2kEp1//Fj1JUXod5myTDKG
X-Received: by 2002:a17:90b:2d8a:b0:359:7b9a:2cf1 with SMTP id
 98e67ed59e1d1-35a21e39f16mr2455060a91.4.1773403739269; 
 Fri, 13 Mar 2026 05:08:59 -0700 (PDT)
X-Received: by 2002:a17:90b:2d8a:b0:359:7b9a:2cf1 with SMTP id
 98e67ed59e1d1-35a21e39f16mr2455033a91.4.1773403738674; 
 Fri, 13 Mar 2026 05:08:58 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e18f0asm8421945a91.1.2026.03.13.05.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 05:08:58 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: mathieu.poirier@linaro.org, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
 mani@kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V5 4/5] arm64: dts: qcom: glymur: Add ADSP and CDSP for Glymur
 SoC
Date: Fri, 13 Mar 2026 17:38:13 +0530
Message-Id: <20260313120814.1312410-5-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
References: <20260313120814.1312410-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C8qBiwu_YO84ao4uvYFaIVsrq6jH_22y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA5NiBTYWx0ZWRfX4S4QduYDP4OZ
 7Lq01PeZS0ssstyUxUhSTi5LiJh43tNwYmBCyplQf5/M6u+KDmBxmpVuRfSguCa9FlIVTwfHAUP
 V490FjCpVb20HQ2SA+Sxriyjl/wlZkOQSvDMPbLSnlXYjQ6qeSj5ozS5Oq9Eb33FkfirxwP71Uz
 oYqGX9W83jT6P5agks3QqZq0rTPZ6HNMJ2EF1+x8GwSYtQkqoA1vWGouEAL4g6y4vLsN15stWRY
 WEZKdvAoGuOcnm2ZCj6qPc/AJjyHu6FTWnS/8wQxGEExOOvoQL2FR9LPt8/JgYlPRlHwMdaEOQg
 ZxK3svN5xbrfAy7+GZUMJ3o6bv0/POrm3XoORKgcFfz/BSwtOgkmoBNidDdPclsw0Se4gYF62j8
 J4J1jF4SJcarNWK4vkMXLcvO5XakJJEobJLA8UBR1s7xlFnwkS+t8Fi5SaHg10NjG+Of8SeNQSk
 kKo3Z4A9YPlBqffAXQw==
X-Proofpoint-GUID: C8qBiwu_YO84ao4uvYFaIVsrq6jH_22y
X-Authority-Analysis: v=2.4 cv=GoNPO01C c=1 sm=1 tr=0 ts=69b3fe5c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=9J5YLGu7rYtaBgtqDgwA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130096
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

Add remoteproc PAS loader for ADSP and CDSP with its fastrpc nodes.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 286 +++++++++++++++++++++++++++
 1 file changed, 286 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index e269cec7942c..ed384d5d9d37 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -3346,6 +3346,122 @@ ipcc: mailbox@3e04000 {
 			#mbox-cells = <2>;
 		};
 
+		remoteproc_adsp: remoteproc@6800000 {
+			compatible = "qcom,glymur-adsp-pas", "qcom,sm8550-adsp-pas";
+			reg = <0x0 0x06800000 0x0 0x10000>;
+
+			iommus = <&apps_smmu 0x1000 0x0>;
+
+			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
+			power-domain-names = "lcx",
+					     "lmx";
+
+			memory-region = <&adspslpi_mem>, <&q6_adsp_dtb_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			remoteproc_adsp_glink: glink-edge {
+				interrupts-extended = <&ipcc IPCC_MPROC_LPASS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+
+				mboxes = <&ipcc IPCC_MPROC_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				qcom,remote-pid = <2>;
+
+				label = "lpass";
+
+				fastrpc {
+					compatible = "qcom,glymur-fastrpc", "qcom,kaanapali-fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "adsp";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+
+						iommus = <&apps_smmu 0x1003 0x80>,
+							 <&apps_smmu 0x1063 0x20>;
+						dma-coherent;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+
+						iommus = <&apps_smmu 0x1004 0x80>,
+							 <&apps_smmu 0x1064 0x20>;
+						dma-coherent;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+
+						iommus = <&apps_smmu 0x1005 0x80>,
+							 <&apps_smmu 0x1065 0x20>;
+						dma-coherent;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+
+						iommus = <&apps_smmu 0x1006 0x80>,
+							 <&apps_smmu 0x1066 0x20>;
+						dma-coherent;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+
+						iommus = <&apps_smmu 0x1007 0x40>,
+							 <&apps_smmu 0x1067 0x0>,
+							 <&apps_smmu 0x1087 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@8 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <8>;
+
+						iommus = <&apps_smmu 0x1008 0x80>,
+							 <&apps_smmu 0x1068 0x20>;
+						dma-coherent;
+					};
+				};
+			};
+		};
+
 		lpass_lpiaon_noc: interconnect@7400000 {
 			compatible = "qcom,glymur-lpass-lpiaon-noc";
 			reg = <0x0 0x07400000 0x0 0x19080>;
@@ -4692,6 +4808,176 @@ nsp_noc: interconnect@320c0000 {
 			#interconnect-cells = <2>;
 		};
 
+		remoteproc_cdsp: remoteproc@32300000 {
+			compatible = "qcom,glymur-cdsp-pas", "qcom,sm8550-cdsp-pas";
+			reg = <0x0 0x32300000 0x0 0x10000>;
+
+			iommus = <&apps_smmu 0x2400 0x400>;
+
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_NSP>;
+			power-domain-names = "cx",
+					     "mxc",
+					     "nsp";
+
+			memory-region = <&cdsp_mem>, <&q6_cdsp_dtb_mem>;
+			qcom,qmp = <&aoss_qmp>;
+			qcom,smem-states = <&smp2p_cdsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_MPROC_CDSP
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_MPROC_CDSP
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+				qcom,remote-pid = <5>;
+				label = "cdsp";
+
+				fastrpc {
+					compatible = "qcom,glymur-fastrpc", "qcom,kaanapali-fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "cdsp";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+
+						iommus = <&apps_smmu 0x2401 0x440>,
+							 <&apps_smmu 0x1961 0x0>,
+							 <&apps_smmu 0x19c1 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+
+						iommus = <&apps_smmu 0x2402 0x440>,
+							 <&apps_smmu 0x1962 0x0>,
+							 <&apps_smmu 0x19c2 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+
+						iommus = <&apps_smmu 0x2403 0x440>,
+							 <&apps_smmu 0x1963 0x0>,
+							 <&apps_smmu 0x19c3 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+
+						iommus = <&apps_smmu 0x2404 0x440>,
+							 <&apps_smmu 0x1964 0x0>,
+							 <&apps_smmu 0x19c4 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+
+						iommus = <&apps_smmu 0x2405 0x440>,
+							 <&apps_smmu 0x1965 0x0>,
+							 <&apps_smmu 0x19c5 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+
+						iommus = <&apps_smmu 0x2406 0x440>,
+							 <&apps_smmu 0x1966 0x0>,
+							 <&apps_smmu 0x19c6 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+
+						iommus = <&apps_smmu 0x2407 0x440>,
+							 <&apps_smmu 0x1967 0x0>,
+							 <&apps_smmu 0x19c7 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@8 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <8>;
+
+						iommus = <&apps_smmu 0x2408 0x440>,
+							 <&apps_smmu 0x1968 0x0>,
+							 <&apps_smmu 0x19c8 0x0>;
+						dma-coherent;
+					};
+
+					/* note: compute-cb@9 is secure */
+
+					compute-cb@10 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <10>;
+
+						iommus = <&apps_smmu 0x240c 0x440>,
+							 <&apps_smmu 0x196c 0x0>,
+							 <&apps_smmu 0x19cc 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@11 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <11>;
+
+						iommus = <&apps_smmu 0x240d 0x440>,
+							 <&apps_smmu 0x196d 0x0>,
+							 <&apps_smmu 0x19cd 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@12 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <12>;
+
+						iommus = <&apps_smmu 0x240e 0x440>,
+							 <&apps_smmu 0x196e 0x0>,
+							 <&apps_smmu 0x19ce 0x0>;
+						dma-coherent;
+					};
+				};
+			};
+		};
+
 		imem: sram@81e08000 {
 			compatible = "mmio-sram";
 			reg = <0x0 0x81e08600 0x0 0x300>;
-- 
2.34.1

