Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647BBC43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A8E10EADC;
	Mon,  6 Jul 2026 21:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ceZjQ8eB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="erz3wa1k";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AF9B10E908
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:41:01 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE8vP1654885
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:41:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fkXnf93yLRWoLQTfGMAiyn37G03qiS7uTjdBHZXSW0k=; b=ceZjQ8eBnqJyvJ/n
 yODW0D+GvmdiU6wVotMh8dFHnitj/J9b2rykVHx1hMIlo6l78Eg/RGEZdY/S85ZP
 eQWhwktOgE0fMKVx+pAsrYvcwOjivisetF/2tV3nn349JI3RAyDxYwG1RuZ7LeE/
 /mXXFkWArw7P508NXBDPdpu1CBETqAR3QEgMiihW0ybfhhBFgHRf/3+VZAmIaRT5
 JB0Vs6NYJKkyrZXeowdCoSvha5XAus1xmlH4gXvwGFpXnYFFM50QoU47z1wv200n
 VgygfrEsUrW+4ylZZBvVeUjTHwN/j5L0OtxjPeFoblqOkecHZ6Q59Fa2ECbS+K8b
 3Sj/kg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qpk38e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:41:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc5faecf01so49087915ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783374059; x=1783978859;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fkXnf93yLRWoLQTfGMAiyn37G03qiS7uTjdBHZXSW0k=;
 b=erz3wa1kOJdy7+f3HKXCHh8GmJdcxL6yePBX0ogoFcZYC/VVP/Z81tRTFrc+9Tj9nu
 hnuD01DHLqB8pa/KKhbTBDddqxpiwfy3sbsl5rgUZzTOKBQAh6nKr4ONI9ZepxdelmNb
 Dbviykwi9FM9yv9GX///WjMLcp3LRPpNkl8LVSkC2vXD3RvnrCMZeYiFzkz65PvgCNTU
 fVGwEroHKKWN2yF2D+JjsS8/0eazSof9SLf3WVA5KasLnp1rc1Z8bRTgrlWwuM8ne3cI
 ZTksDZQSZlbogR8Hftfz/Zjxi+/aM1gejnqGaaeMLtq5NePj5U2VwUxcdJ9Caw1TA3XK
 wK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374059; x=1783978859;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fkXnf93yLRWoLQTfGMAiyn37G03qiS7uTjdBHZXSW0k=;
 b=iTVjja3jNvv6vPFPVU0lTtUwSnalDcjnVpdPc3Oytdmzh5S0Nn2yhDD9ilrFfxo/11
 e4ZDAQZ0yse8lID4iSfzZwykDPoZwEyNpNczxD0bN/oEDAJJL9quDgCoVca2dyHIlDz9
 1WUHLVdlDmCI09sQEBrmfx0uUNomp56OBpIPXM2Ng4PNxFY4PqPVsjmvuKGGR8uC1c74
 +WiCgPuO+b2IeHW00kYYBl2ITdeMRY9mTQpnJueiBDjzM968hEtIVIrsppwRTvm4ZahQ
 KpR0Th4Hzw3HXiYbuCz73QgHImWhasfwdnr5pM77YKLN0oI3qVUFXt5e8XzGBFor5Gvz
 EhEA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoVuvLb7pRA3YV7glkmPqxPxlnBxxe80ePWYc3REZ8GZxUq73iwt2lNnLpQWrXLd8U1qAsNlBPvBfY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvQlJHa7y9x6MQVMepRlIBE76ZkVsit5/bHZYD2PNGE5Q6WCKm
 NP5VaM8ykMhqPP0tN0yu8CfNLGsBoU8XGKsHL1Hpx9/SjvlffJFuRz9A/NhNaW2UlX8/WQRrvr2
 Vltg+kmgG+WLELBS0nYMfe5oZmCm2wd0lHG2X8sssH2B1BIaTXCCQKos+y7XDeTlNMHz/rN0=
X-Gm-Gg: AfdE7clE5+C2O7EWjKY1NYtp+RRONYoDY+b4R6hUnDpPzVklEol0nsjA/xmcW/64pbu
 bVprG41wc42xhaRYcwmVkenN2RZHL57bHNHRWel0smXbphnE+2n55pDlZmWWLsK6M+pl+AvJbc+
 ovbMCK6cH+ayvT6NY2Wj1pPb6ru/6xxFxu1zByMJ+R1fHO11mgDOk0+GDiL8o+GFgDPygevye8e
 o0sD30cGMBWw1d3OIa0YtVBYgDKbXpumMIBdc0g2GhebbGKko0qiXHjFHwufgmMxxvEot1/aRRb
 0b40OfTVOtqr0opQu3abo7gu7HOaifn9Kk1T3IqNiLobkb9LlYPhaQKWXGw00g/SBDARJhTcrVu
 m6Ho3+sbEdmaDMk6z6qpHncVVVYELcpbHo9w=
X-Received: by 2002:a17:902:f607:b0:2c9:e835:ac67 with SMTP id
 d9443c01a7336-2ccbeb1e2e5mr25480765ad.19.1783374059376; 
 Mon, 06 Jul 2026 14:40:59 -0700 (PDT)
X-Received: by 2002:a17:902:f607:b0:2c9:e835:ac67 with SMTP id
 d9443c01a7336-2ccbeb1e2e5mr25480395ad.19.1783374058879; 
 Mon, 06 Jul 2026 14:40:58 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:40:58 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 03:10:20 +0530
Subject: [PATCH v3 2/7] arm64: dts: qcom: kaanapali: add the GPU SMMU node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-kaana-gpu-dt-v3-2-8dac9a60dd5c@oss.qualcomm.com>
References: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
In-Reply-To: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Qingqing Zhou <quic_qqzhou@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=2533;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=qEe8ApyufGdls1/59eRBgE6mt3fqa4nJlBW/WwvTUag=;
 b=LMc5mk+WE5iV1TaH/olVocdEf9bvwVBig/I7ERonQcpX3Z63ura+W+n63vue4peLfqeMvQt0W
 tZxG2RqFMvbDzM/WCwXmBJBo2DW8B0e75hW8EtxLW8A48IujYbwUZN4
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4c20ec cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: tHBSUBHBBDU1fT-L5nIR25gIRziuUBlQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX2SaslGsiVZnX
 oty5amiZTL/8JEq4CLgrAgAZ8sp38XRaKuSv2PxmKZgV4M5yPeDYbfFWxEpc9MmYRJ+/cMcr3HZ
 GExk75lSgkOAxxHH2gb5E8HpI4A2LQI4JuiV6RLG4e7khrJ7LWsIr4IYnptcxTlHxI3/ue/yMLf
 8VdrlX4G/ysw+qEmCJDxKgcfIZRj+1E1SBELdM7y7Zl/QnUQ33cDUQYlCgMumC0NMA9k7Elur1o
 ktzQuJXpXPEROIuBu+0xrokPETK7L12HXQzF1b3oNIWO7NdyaonI2AAuOpXMYdHR7ZRQwYbx2wM
 5OnhMOY2Kw5SqpzmB5L8MtJKqcAFXSD0yhA66To7DxloFfB5kcaxEJT2/JQqCgWFGwn5qRvqIpo
 u+QkvwG6QFPeN+IQ85sLhlU8tay3J57aZhBTUkzBPqnAhfeekkGPoG06i4n/Q8er2k6yIGC4mGZ
 M3Yiz1BHjlCKUubTomg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfX5umLt9fADMbw
 1IMvcYOn2M5RwS8hdMFXBWcmxPei75rNenpCE+vFxfvMV92Ru4bnOLo724Sd5WFjJtNo4m7Vq87
 W/0wK07gFMU5JZDZWvVFEpzyC7ktaJY=
X-Proofpoint-GUID: tHBSUBHBBDU1fT-L5nIR25gIRziuUBlQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060218
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

From: Qingqing Zhou <quic_qqzhou@quicinc.com>

Add the Adreno GPU SMMU node for kaanapali platform.

Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 7aa9653bd456..a41962366941 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -2601,6 +2601,46 @@ gpucc: clock-controller@3d90000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,kaanapali-smmu-500",
+				     "qcom,adreno-smmu",
+				     "qcom,smmu-500",
+				     "arm,mmu-500";
+			reg = <0x0 0x03da0000 0x0 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 660 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 662 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 667 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 670 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 700 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gpucc GPU_CC_GPU_SMMU_VOTE_CLK>;
+			clock-names = "hlos";
+			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+			dma-coherent;
+		};
+
 		remoteproc_adsp: remoteproc@6800000 {
 			compatible = "qcom,kaanapali-adsp-pas", "qcom,sm8550-adsp-pas";
 			reg = <0x0 0x06800000 0x0 0x10000>;

-- 
2.54.0

