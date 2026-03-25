Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5270DFEA805
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:54:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A7A10E707;
	Wed, 25 Mar 2026 03:54:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqAXGcxN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cTr5d+x9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1444D10E707
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:54:02 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJDkcA3984472
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=P6zYDve/BYp
 t3VDchEmqfBfV1L4AHwP+iHj3eBf/rX8=; b=VqAXGcxNaMzx0itDBixjO+G/IyW
 aWZX1EWkOfFYWk7Thyh6FTpge6684EmhE/JBX5QTg0uileA6kd5/sKfVRKjQfg3I
 bPOIJiVQPnPgZ9IKrVqMutsi18zBYtzVMl9uhbN9SBDWdJiIu/qWIo33M4X98RaZ
 yTyeQrhsdiQaKpLEA0xwrUi4kxReK55iDlVvNvz7/H3aLbS+SEOnvBbxFfCYHdwa
 9TYlh1bF498YTCxMyjaTx0IMLp5lz1Ie4xaxuUDFPTrf3zFSdaul+ZAyU/VxcnvH
 voemQurH0b+FOwao/S+dIkADLBXRERvWMyAxgiInRUOnUre7g6GcIMS/K/w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3p8344ra-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 03:54:01 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82c613194caso1133012b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 20:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774410840; x=1775015640;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P6zYDve/BYpt3VDchEmqfBfV1L4AHwP+iHj3eBf/rX8=;
 b=cTr5d+x9JXq5DXOAJrg89RxA2Payr9G3Z/yL7GoWYtR/Qid9nfS7s85atT/vAJupkb
 9+PWQtnx24vkETwVT87QhLegrlCKF7LUfHj5+3Ph4nNuu/PdGEjm8a2kXaJNyVSK8pV0
 Y3ddIa4+b42T/Kiv1zDq1tN0bVtA+mfS0h7R4/RyM0T+wtT05/AVoxYoc4VtzNCnkmxM
 JQVvqiq7hO/t6QVUcQpna2xcSBbdEluBeVmV1ERzQVSveGodv0zb+fVwB1mN+7L7w/O4
 ia77B0YyaFbviIvfSslHu8gKQvvLJpIEHVpH75wjLIuZxUhCvH71NrRmckUeQHvx22WS
 OUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774410840; x=1775015640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P6zYDve/BYpt3VDchEmqfBfV1L4AHwP+iHj3eBf/rX8=;
 b=VvTlCMar3HRnfukUSqvqFDFlNO1Fut6aF8ujnTDUxNFGb/M0XYnsOSjcJ+/6a9+u/p
 PiUqUtTc7AsuUa75os/z5td9QsdpjrGARGnopwqerr/lXP1Kk6/5lU161b0LqrJcUymu
 UWCuhKMY0xVBzmcyFJpdlQqscQr59+MvIQOJQ/S6OWh4+SHod26xY1N8p6zo+h/33goz
 0zx8F7WQRs+8ZA9whu4YtkDsK/oeMleldBZoII8RJxYXQGg6EuRo1oVKCI8s0bTJeQHd
 bHJ3GXptWLnMtU0j/ZQFXRlsgVOJkb8jTJh46OOfuELu0E9HDBOjAH/+yNRyzdb7tWJf
 KMuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMUqOTF4/pj3UP2h5Qft6uY1FBRZdcC7gQtoAwQyKlRvzEOgvyQ+kSPJDp1IYUbn0locnisidkUcM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdD3IwomqDxrjtCv9jLoMW50tjVM67cj8k48LNj8efz7Qxl6gc
 ol4KOiJN7ungyBtIgSzrMd3EFG+1XjFb2NxHz5JqnSe+jecmtrZTIMeeMOjhu9IjRZmupvNU+7b
 Wj6q+7Bofr3C4x2Ujj3WoJsCTRiL/JmsrX/VyysXL0C4+P70Xd4UM6/aIKjyv2acbAsLs+CiNry
 4vzIk=
X-Gm-Gg: ATEYQzwSfZlxOm7Ppk/Hwr9s7aIJqXxCRDQu0Z/dLgL0q86D5OagfJIdh8W2FoNueph
 SVZ1U+jAjc8INvURt5fRZkcJDsBEXL4NAw4XmpdXDUYujPXUW05T9U0FMxaqpGgIoUs9+0WD5yv
 3fLWYiCTSei8b446qipoVJAn34Rj/euCElTqjU4cwRNzemT5MyeUBwkxxg703vPPvPLL495dTHD
 sbD2Dk/OmR0eGs17smspFNSOphWQNbyRVvRoHzkerP8vVie93KOB/Ae6Fou0KutNrmpUCCAoYsY
 E0VBgkcJVAXTWMSU9NJALg4Fs+Z+Nev2GkHlV0TJ718kmwX5osP9eKCAsy1PqELuLaU14n623Fw
 NheFhJeoNMofetbIKIHDFQECvWACz517ZMDmw+CkrW5m5tIQMq8f16sOWawD0R5ZEUq2I1wHXeg
 jOcqsrkgP12vNz12cVMH+tU4SMKWnhsYH1tdoj
X-Received: by 2002:a05:6a00:1da2:b0:82a:fc5:fb81 with SMTP id
 d2e1a72fcca58-82c6de7391dmr1624234b3a.5.1774410840241; 
 Tue, 24 Mar 2026 20:54:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:1da2:b0:82a:fc5:fb81 with SMTP id
 d2e1a72fcca58-82c6de7391dmr1624221b3a.5.1774410839694; 
 Tue, 24 Mar 2026 20:53:59 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0410870csm14220689b3a.52.2026.03.24.20.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 20:53:59 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: robh@kernel.org, srini@kernel.org, amahesh@qti.qualcomm.com,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH V6 2/5] arm64: dts: qcom: glymur: Add ADSP and CDSP for Glymur
 SoC
Date: Wed, 25 Mar 2026 09:23:35 +0530
Message-Id: <20260325035338.1393287-3-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
References: <20260325035338.1393287-1-sibi.sankar@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAyMyBTYWx0ZWRfX9/rOGbAtzXyi
 siLzkdhOOCHQFIR3VzR3ZiG+swlUUA0rfpzQDomHlrN2JacZ0m4BrvNhRtP/rPJnef+UNdLjHsY
 frVKt1l6ujBPI3I/8PohqL6YaztImCUjDE64RbiIzZFbZYOiW0iGr5ovLjnJ58UBQnScQrE35zs
 G0sBMfjVwFczZ323nb7V96ssB2UIWdJn8PJAMd2tjr7Srzze1Nq8l/GiwxE0jl/F2sfhQQolrgS
 fPLryOam0/L6JdnLjOZpfgzsHf1tsYMm9wdY2K8ke+JrtFCQ4fyIS6Cihi95hk/mvxc3lwQtcDp
 YwndXzsAlBv/lmRqJOHdSIWtPUj90Gahoo4LpjNS3zgqt+tM23HqxmZDwd8LjhH7m3LYW9Ddg01
 qLdS5npwcgAlotXlOY+e8kHKrTaNCCxHO8ExC1nwcVhr+RgfXCuQoZvC0RyR8yQrhfFHEKisVwa
 v6BACctnD+dY7lMI33g==
X-Proofpoint-ORIG-GUID: IWLlTgvzryB516HpfCa6C-dr3k8mvZAE
X-Authority-Analysis: v=2.4 cv=F6hat6hN c=1 sm=1 tr=0 ts=69c35c59 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=NZoh-cpM5xcobfd524sA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: IWLlTgvzryB516HpfCa6C-dr3k8mvZAE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250023
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
index 2c9d10f2e987..e571710de40e 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -3705,6 +3705,122 @@ ipcc: mailbox@3e04000 {
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
@@ -5910,6 +6026,176 @@ nsp_noc: interconnect@320c0000 {
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

