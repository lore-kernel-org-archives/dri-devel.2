Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A358C43602
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:15:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C37D110E171;
	Sun,  5 Jul 2026 08:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hw6Uej52";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CdkR+cT9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14CE010E165
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:15:28 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664MRDKq4055733
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IJ8bK+zwxNxvelEPDVocGsp3nSNFU24C3BcvFq2dA/g=; b=Hw6Uej522PtLL0i7
 AAjOq6lllFv7kxd6XU77DgLv0U/97Vkz4XF6yNeEzalbgTu1BPmgeYEeTpi1yloQ
 CBNAj58vinX1TxVcisvmbVu9dccnNB0z5ElUpQXwK+r9XRRv9/2iHoyQKSYEWvXA
 eWCKJGepkjhAIp7/RKAVbKS4IKtYxciDkj5YrtrrU7tMI25IvYfPbFitM/xUYqJV
 bO0NBVcCOpXJZuWXQGIjkSJkpf9jzFqyUQixI6IJsWPWH1+TfjTfmcbD1iHP8KYT
 A5wBo0jYfeU/OfUEGoONWXF1bAq30ioHB+KzlWwHdSr2I7MLQXRkR+4VnUKanfpo
 SCQnCw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txej8be-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:15:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ca5d2474c7so46346135ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783239327; x=1783844127;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IJ8bK+zwxNxvelEPDVocGsp3nSNFU24C3BcvFq2dA/g=;
 b=CdkR+cT9KksBK5qln/xwjfabjHFIeUgWP0w6TXLLqTceEMdsFVUhbVn5hN5T0s+LIB
 E2qLe25tEIF0kqp5TdbL1fk8z3tZj/2winncx+IGlqGUeKp3DZFiC5zbg98XQQQtTcMC
 OmErSSd0HhcGQRP66RZ+6HzKrhRioQ5okF7MFlkJFEBqwIMzFfRjBBOUGPzgjv5PB1m/
 /pRftLrPlWt887Lyv+gvefVjK2YtdS4+Pt5I2iBe7uZmYHn5HdhgSkXwBglYk67+/+Wy
 yOag/RjhwPjX7qfTTYvc7KW9bYPplDnzQCqddb2mYRFYgIIX0cQqyOvCiMIOrZSYdY1s
 nUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783239327; x=1783844127;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IJ8bK+zwxNxvelEPDVocGsp3nSNFU24C3BcvFq2dA/g=;
 b=q/iqjsGu7oMQ83rX/eqXPLjxPPlXXVFebt/1xB7Wg4yxfLbEwSSdsf69l03ZXIXvGj
 otnVvUTRpDLCSxtgIE3OWGqqL7WCP7a8TNJp/8UazoCxg8l9GI0i4flfYT3Vk47nCx6q
 EKibwGBlC4KYquUdWWnz/zcMm2/3s6KT5Db1u8EW9gccwmMW3EUbwQVSSviCjhYaWs8Z
 u50XToQ+lmMc34n4WtloCdBB8yNhT3W/v/oT6gO4Bm4Eg2G+2X6x2ZSsG0N9D0PMpFhT
 MYQ+JCIAnbYEy2xbuiamo0qYfNEffURJhwjSlCvRCbZZFXLiMHW7frxEkBEnukRUHl7S
 vWvg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqiMCAwZzjVoRhSa7wA6e+CuB/lp0VpOIzAC1Nga0FOZLQAoobKPyIUYXa1Ff7UHPr0fI19VwK/5ck=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzCT3Kttwih1kXoorLV5a39ytjLZPN3lCkwla5RZsLa0BsH9kE
 c/CXrs0Q3xfSNIDDPoFYYWQclN5ZFDoQ6wCOAVbypq3JYERGXqxfZPFaBuz6C2Ft8t9qHPklaOm
 pnWH4twVqpioWRIwF5FKhYaapQeW2fvnC6WW//OrvfUtHkp6QGSnqnWbxp9gpsFAZKHo6xus=
X-Gm-Gg: AfdE7cnIXiiWBjGwN138w8mseTU5e9uneor4XsipNlWNxtZTF93M1HPX//gvqdPTS5M
 Cv0YJheX7TvmTOwkd3lZvb+Df1fPRGT0mghkeHYr+nSv68T3rszh5R2qZaBCRgeiEfst9KXK/5U
 pF/QYqgDvuGWv73EQDixGpj7iCx4psA4VppE5WZcUiuRb7wfo+PLIPzIbt0ZWi3BuARHg34hB7P
 eoGn9rKS0Vjmo9rZw4UJTsapuA7mc0TAsZalEw+e7tnXIXEmBXi05BAR5CMF7MLv1yn3/EWS8X9
 eR31L7qWGkTYBLBwg6iqljkd/L1key9VaY1bJgQb1FPZdCR8iBAyFNt+mMSOD8lOy3UK9rIgdv7
 E62rfBgoRuyplFKiUwkl5+cs/qOaV+sy2jQA=
X-Received: by 2002:a17:903:22ce:b0:2ba:924b:3948 with SMTP id
 d9443c01a7336-2cbb750dfeemr62830255ad.15.1783239326733; 
 Sun, 05 Jul 2026 01:15:26 -0700 (PDT)
X-Received: by 2002:a17:903:22ce:b0:2ba:924b:3948 with SMTP id
 d9443c01a7336-2cbb750dfeemr62829785ad.15.1783239326208; 
 Sun, 05 Jul 2026 01:15:26 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.15.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:15:25 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:21 +0530
Subject: [PATCH 6/8] arm64: dts: qcom: eliza: Add GPU SMMU node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-6-c9f1354dbd29@oss.qualcomm.com>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=2286;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=q+INaEIUNj0EXeDmcw5Jx9wg9/Og5BIcLTww5DoAVnA=;
 b=MohOZP5BSd7gGPu51pY6rKeL5RRxBoIVIbOgZlIdE/wHpMOl/l34w/UKkxBV+hgg0MnC/fet9
 g1adGQtY8KCBh/oGiWWKyTQqqhJ1+0LNhTQDsT9Ph0U7ePkTzbEp3qg
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MyBTYWx0ZWRfX/731bGKEXr+A
 kN3hUkm+hu264TdMvAx3NUDqjeUjBapEqhvgMmrNFsNbLYI/HY2v2Dobsdd21PNQx6SqNTW0krY
 7rjh71TFrS1JQ+7o69bcZ+bIIwlHEnc=
X-Proofpoint-GUID: 5PcrXltXySq0fs03hxV9fdtVrtXURb7P
X-Proofpoint-ORIG-GUID: 5PcrXltXySq0fs03hxV9fdtVrtXURb7P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MyBTYWx0ZWRfXyK26EE0R56nH
 xBr/8EDg08lWL/Twc9eEgVrX0rDN0P2+i4LyEHwFSwfedB0ZC+eVFjM+xH7jP569OIYIQVmtBre
 4ZMBuv+8IPPw7gK5CquS/QHA6Qlb7OszJ66RM3O79EW9vTjSLGPCS5E8G+zBmhDJavcPD8GvVdv
 BUd4QsUcIZH6rHNZsoifO++Go8XMaO7AjvUEJ0nTsvWFsQ9T93h1Cc63E70P8DSle0oNFAIlkWa
 HXuOqWyKeSIFRXfm4Kq1ex9JEmnlYrP4P0bTKPHYqTV+cSZYBJUVj71lbwrLASA8kgrUlGJ3IYa
 2kFj+f//54pXOPc3reNzzxSdetaqzaxzmyDTOhTW+rCu41oi9Bc8TW4qcI9ZBIVSLDzFARYYNrP
 Yir6+zxf+ajQD1SYjRCkbK6/qsDpSIDFvx19x3RlDJ2yFcH4jl26LcgCWHd2yTb3mR65m936QE/
 EkA3EWSJ5jEF5v1XJNg==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4a129f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=IlPRAfYEAefbqxDJwzkA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050083
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

From: Abel Vesa <abel.vesa@oss.qualcomm.com>

Add the nodes to describe the GPU SMMU.

Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza.dtsi | 38 +++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
index c5635f22e2a7..e5b8377e6c3a 100644
--- a/arch/arm64/boot/dts/qcom/eliza.dtsi
+++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
@@ -2674,6 +2674,44 @@ mdss_dp0_out: endpoint {
 			};
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,eliza-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x03da0000 0x0 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			interrupts = <GIC_SPI 673 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 677 IRQ_TYPE_LEVEL_HIGH>,
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
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 659 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 661 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 664 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 668 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 699 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>;
+			clock-names = "hlos";
+			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+			dma-coherent;
+		};
+
 		gpucc: clock-controller@3d90000 {
 			compatible = "qcom,eliza-gpucc";
 			reg = <0x0 0x03d90000 0x0 0xa000>;

-- 
2.54.0

