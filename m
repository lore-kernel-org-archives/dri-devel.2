Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD413E63FFB
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 21:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F70910E0BC;
	Sat,  4 Apr 2026 21:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lp4PGznD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNNvWHaw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B86B910E0A0
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 21:03:59 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6340gkc91344729
 for <dri-devel@lists.freedesktop.org>; Sat, 4 Apr 2026 21:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nmtZth3SXSD5zX4iUT5/KNuaDt5932j/HMFP1H0CNWc=; b=Lp4PGznDUzIZPYY6
 AfQDGUfXyOPolYYKX82N4dZAsg5spNO5JBxQr38jyHNLkH3SU3Z7f9aWgWsjlvcx
 2mNsKQfNRKNICxDXQn8uUs9RJcIRWFUcqCCM3DNTsVKoAe+s0vN4nhWFa9twFk7C
 PLmFU29Hsocr67Ex9f16e/7V2SqOn9FH+IJnNCY7QR3NQ3lhLxWIxzAgqyyjphXP
 mVRqF1bPylGfgD4J0vYA9KxouT0xDqaOX1ZZNF+oslxwehl9xpBwp9Br6fiSkBt5
 LD9n9RJ1MmYpslLlH457B7QYB7oWfWbBinO4q/w+UA9P75CM+EpOYJtb8E/bMoAt
 vMijkA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4darbfhqgs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 21:03:59 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35d9010602bso2798373a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Apr 2026 14:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775336638; x=1775941438;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nmtZth3SXSD5zX4iUT5/KNuaDt5932j/HMFP1H0CNWc=;
 b=WNNvWHawULQrOHh2rJYQlcSXYjytiCrznRdxROUSqY4xZtAK+caxRBJdRx0rhg5UfV
 N4hIjlTyqa6X1EjN0Pkg6nSp9uCtyqteZYPIkbyFMjhmKv6se+vM7vJmLAr7ZC9PFk/1
 k6xM2tj8GUr0aJqyO2CFNgt9be7rBVcEUqBD4qJayg7LKF4852TxERlDMLICkatXv3KE
 ZG2mG5cGSIDp/KHxIs0FHGtoQGhsYdWZZaWRi7izrwTa0VsWMhPresF1zICRxDYvktK9
 pMM/OxBT7FQLV3AOj5DHu+ucb3tT9t/2r5vEpF61j2cnaV5H2Z0ZEswSdCXzqFCn2o4V
 VWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775336638; x=1775941438;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nmtZth3SXSD5zX4iUT5/KNuaDt5932j/HMFP1H0CNWc=;
 b=WLrLA+V7BrglPG5K3w1EgdpoyLT8KjMLb6ruKbhadzb/H3JxxOrX4pDPxbI1Liavdg
 8ZBbQZLeLp4Z/42Y9H+E+IjKqSzhMWEsOCF4O26sXRV+TYb0M7Qwridw541piWYM7++n
 TdkZbXu4oz0LoxeNEL2szf868i2G5lfIRmX9QRxKubU51Ic4Rm1RCw2wlmF/paQDc5vk
 g6MViyT6ppWEyN+KLF71wxt3UVomTUDtvQtUFPM/g+IC2XmP2HwsaHpqNACeqHt4GH82
 Sdoas/Wz3NUqHBaGCs8+0AmH1w2fTeXU1gm6viqbiEejMNdRR3UoHYKHue6m/3sCS92W
 iyJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTao8JpsL0BASi+K+ytZUScHMYo7UTuBbufTyDaXECse+rhIg/VNtMzbg/ONUNy5KYqdbOrCMf+Ss=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcA8aaxB8bRK2Sk1Y4GGjTmkFCwcQhGP0g6gs14Tn+BaQFR7cv
 lFwfEPjeqjEFTPoRPvwcjHJ4kib6kTu/PcVbJqbIOMOy7Lrlim5Q1++AFl84EjrjwD05+Zd2p8r
 2GkrR8ovfQ2EZRBNrAyE3LMFnpU478PL23vQOFcVFmTXfMDHFpF5zvS3JOcyA+QBt30ppcjc=
X-Gm-Gg: AeBDies22x0Nya/08T06SFxCkWolDzieeXp/qIGOEtVXTsD5TwkRH0etPYK+gSd2quX
 +4guvTJUJ4hEJiTDB9LE9BSB4O+Dt7iCELnCajun7yzPlm99E6VXyXeQS1KGhANCTjVnUtK7gPT
 vbgV4xVYH3kOUCcBFlu1osKYjQ/ckC+azxkVl0vDxPcEKOJAH0fU//hMVcbE0rbqc9zgWMSDZfA
 PgjxQp0kxrROAXPe4iddYZZj7CKivPBUeaUUqc7AQZkfxY43a9DyI4WCWiaYUD6IyzpPcjI1weG
 U31vQbUpLAyMqTUj9h73ByFQ+pmrlPjz61//89GN2PXaoJW+EPVkMZGJhfIei8LK7zt1L0z5APE
 xmGVRzk3wSYdDpkUbmzuHWpqNWtKiVurJnH/epteGTRRPpA==
X-Received: by 2002:a17:90b:2ccc:b0:35d:a0b7:9608 with SMTP id
 98e67ed59e1d1-35de67dc7d4mr6566658a91.7.1775336638394; 
 Sat, 04 Apr 2026 14:03:58 -0700 (PDT)
X-Received: by 2002:a17:90b:2ccc:b0:35d:a0b7:9608 with SMTP id
 98e67ed59e1d1-35de67dc7d4mr6566629a91.7.1775336637929; 
 Sat, 04 Apr 2026 14:03:57 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35de677e2dbsm2675545a91.4.2026.04.04.14.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 14:03:57 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Apr 2026 02:33:15 +0530
Subject: [PATCH RFC 2/4] arm64: dts: qcom: glymur: Add GPU smmu node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-glymur-gpu-dt-v1-2-2135eb11c562@oss.qualcomm.com>
References: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
In-Reply-To: <20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775336618; l=2452;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=JT5lwnVUisFrhJnFAuWZExNJ4rN4NkpGTeCu4OU5CF0=;
 b=EntZR4nO3H9acZ51Ka46YVBtGA2N7T569x46whj309a/ZNx2ueznbQ04jh9qhZhj54yrQNRUf
 /OsMJuZfi8ZCV5umqob40FeXJ73JFVkSN6c2VyNmHZfAPHfRkzu8dQH
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA0MDIwMCBTYWx0ZWRfXz0hPfg4EuYhR
 p6zdDRLnrG9hLh0LU9X36fzYAkFT581omsWo+A+EeAPsGPgYi6yrbfktOSQTdEXEJncIO+q1y+q
 EgxT+MuHDhejamOBrorkj3awTNBghrtyJ69UP98IsGQ4AsUEFpwx5m682k80KKm4ypD58s/HJkY
 zwbkejHB7BNaAjywt0WMQjDsnrDCinpXVAjyIx1R29HhOf+VMbupL5uV/hBuben+RT+YaJFRix8
 rp4Hv81Y41rGHyvPtto5cS5SwcUF6ac6iO4L9ofSbQVvSSz3iM3aB491om8gS5Z92TSRJKF2zHb
 DR9t2jtwp5H+mCnWyEoZgpw6ocJT1nnLXpPp5QU5ctYKucBJQtUFQnCqgvNTkv6B/S3tjT1s6vT
 6ru/qT6R8OAQCUSjQMbPlVDFUDn7jMgSqG76Jo/lTXLFi/tajQz26AtDeUTRVg03ZsjAYvejcvy
 4xui9u3kX5tP5OfluDA==
X-Proofpoint-ORIG-GUID: NOBUkPs-drUws3lmZRecF5gPZ7JdKawc
X-Proofpoint-GUID: NOBUkPs-drUws3lmZRecF5gPZ7JdKawc
X-Authority-Analysis: v=2.4 cv=I6Zohdgg c=1 sm=1 tr=0 ts=69d17cbf cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-04_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604040200
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

From: Rajendra Nayak <quic_rjendra@quicinc.com>

Add the nodes to describe the GPU SMMU node.

Signed-off-by: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index e65e40857b3e..a3fe2b12aee0 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -3724,6 +3724,46 @@ gpucc: clock-controller@3d90000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,glymur-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
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
+			interconnects = <&hsc_noc MASTER_GPU_TCU QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+			dma-coherent;
+		};
+
 		ipcc: mailbox@3e04000 {
 			compatible = "qcom,glymur-ipcc", "qcom,ipcc";
 			reg = <0x0 0x03e04000 0x0 0x1000>;

-- 
2.51.0

