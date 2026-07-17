Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE0EC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:42:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC8210E507;
	Fri, 17 Jul 2026 20:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GD3fzSng";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d617Zv+e";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9CEC10F5D8
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:44 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtU5Q2887012
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IJ8bK+zwxNxvelEPDVocGsp3nSNFU24C3BcvFq2dA/g=; b=GD3fzSng4mzaN34w
 lyG3oR0LBYUx3m+Qt/0ZhEE4VliGMDFm6RGxkvWJGSIITjX0E0PIklvvwsPM6VH2
 kazsXfSDaTgjfy0QA0mp+cdKHIegZGn+dKWdOUtkksdJ6EESL7y1JO6MHn7zmnL7
 sn7zeT/ui3A60R2MOqcqLdahw0HdPzn5/q3ZGdaiUVQw0QxcaELNswEc1Keb8wWh
 PYvfue02YKfPd2zbto0SUbUBpe4RJRJGlWFhIHMatbYBdq1KMPdYE8RAqCeYtx9o
 J+kjitAFjiqDO1dexz7SHzgKYcnvP1DPAHd643M5Grm+4UrXs1o7CSOceq9ex3ha
 U5RzAg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfjma5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:43 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccafc5e82cso63773495ad.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784320962; x=1784925762;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IJ8bK+zwxNxvelEPDVocGsp3nSNFU24C3BcvFq2dA/g=;
 b=d617Zv+e0WiVbFJVz+C01Yho7sl+z97dLY0Ey2KjUfRByW7gugoLqnMdTCEZSVOxQl
 V0oASYUN65+Ny1ICt1McFBVImHktW4cMFvCMlTdUSjTymHg8MxuXUpHwX5sE8lKW6zO1
 Os2ejSqyJxophQHoOd625CHuwcF3YVzvSq2tkLXS+aXTW2BoPCPF+5zZIyXTulUcZg+2
 DtNolAobyoixF35naAMoaIB7BXfZgClvb34ZamGWmmVxsYstUCA4aWPiXTGGoIoNryOK
 5YBdtdC5Zop63VtBXJbCtnJTEepGM82hms6yWwaEKd92XjzkgLq/E7IrCxaECY5o5yll
 vIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784320962; x=1784925762;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IJ8bK+zwxNxvelEPDVocGsp3nSNFU24C3BcvFq2dA/g=;
 b=EK7CNHM85+9s3SHCcwHTIlXAcpxZy6VxDX12L97tedMWGRXh1a2GNAnySuU7qIq+5w
 hw10VK32EevSd7luWo6moosyu1zIYP0wzMEmHFCJQAQJyPfa5yMt+6V/CQuobdAZHe+0
 CSkJP6Z2qFONw2ExuIYVpUFgnploBo68fU7IWVdtRPk/WU9sB3fFBjPBJ/5XbIjkj5GS
 hR3aXUOmK5v7mKtfbxOdJgvLXGnTOcxt47TRXuaCvRZu6qQFIIeIVPOetzURGaV+cvt8
 dqCNQ6AHZjiGNKfsHTMDnTrdjez4rns1gU+mVz0+C5TAl+tNaVmQzJe3TbaRh2Icg5oG
 flbA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrRkU9jNuB/BFBBzQlVovNY4PJIz3M6EFTSCp9ZF0rBzgjVMD+I0DDNaOa04W9CWxURlVJeK6c/oNs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBvZZ6i6R3YEqecfT+0QRIzl5UPMlTogdyny/hRZd6qXTlyMWS
 TVrqza4QGWta0ga4ufS8doISm3IsWtTabrKU3R0T4JQjRCrz2Pcxb5dUUz3O3GWj9pR+x7aMd8H
 R7FZGzwovp/KMIgIaIDEriSw7c4PzdFQuUvX3VijUyFlQBsJNCwzacLZsMs1j30+DJRvy8IQ=
X-Gm-Gg: AfdE7clzidmmb+q2W70A+9ERGRM4oB00ris+EoPGyIwzLJZMdx23LV6Zk2ek+XM7Nrc
 nOAm8pzM4+nKPLdpHz6fYncSF4f81zp8cgBH8LYbwKWabOSK+/AsguNUZPPKWXWPTnqKNLNPDai
 MXdCUf8AXlWaVavwOBkPfH4QwIbz2c/EumRwN2S5qlgBId2PHHYCpJPAXznQdU6OSijiyak3U8x
 kDYZVktlLV7fLwAxRwHSV2GddKOUrTnGAs3WdQXiXfwzJatORECIFoOwJ5v8syM8acQ+U3ZEWA0
 lU5ABOGaxC2SYb3oamtYG7N7iQRC8LwCqXW9dWRdcZhcY8y4hIuUbz7bj9b3zASTuc7KsdNyJLh
 8tZT0fVuaa9aOxNx4Dc171h91
X-Received: by 2002:a17:90a:d44e:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-38e4b3d0fdamr4149506a91.1.1784320962252; 
 Fri, 17 Jul 2026 13:42:42 -0700 (PDT)
X-Received: by 2002:a17:90a:d44e:b0:38d:ddc2:7ccb with SMTP id
 98e67ed59e1d1-38e4b3d0fdamr4149477a91.1.1784320961810; 
 Fri, 17 Jul 2026 13:42:41 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:42:41 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:31 +0530
Subject: [PATCH v2 6/9] arm64: dts: qcom: eliza: Add GPU SMMU node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-6-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=2286;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=q+INaEIUNj0EXeDmcw5Jx9wg9/Og5BIcLTww5DoAVnA=;
 b=Xr36ABXncw9ToqIETUKiq9f7DTuutD8YoPX7Fr09ffFks3kKWGRv7D5+Z2AlU0qI/PcuMN7JI
 vyF+B9p/KGSBhQbdfWh2JQz3GCVlOhZthUh2mx0IpSvMqUeKCWSYaS+
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfX4SpV5dnyq0Il
 0dMjCt9oO+47s4i8Y8xe+sfrSehVnt29TqsgkxYD94SQ8H8VgONfuZkhy3sIlkuL5Q14L7gpl/x
 3hKz/R4e7+l786hLAU3D/wzpFJ6wI4tbRAtk208LpvhXeBZ0m5enZ2bLwj0rtxieiOamknnr9vu
 JCsvROYbu/leOPSh9DBUxkIbJHm+Es+rdbT86y8hn10jqbUolbV7AHfNddaDmZYZULIfgL51uZQ
 x7RxzMMhvLF31VoRWNu9S3BbFFjKlfN2b6IQBUFV1dI0LEpyi7keLRmdH31jRGWbqxbTsZw6P/o
 Or/pvkds2avM7wEHrQ7gtTIhvS4FglftMlDbkRw6ErjMVBLBPDdfOnkf20IvaHMDM3PspHHZult
 4L5BXwxgsYNSr+7w4zfhGgPUeJPFyHoDbLMdwVgiR4vs7LUDA/XnVH8Jdbb9Dwib0+ppqdn/eQz
 G4/46TccQ447NM3SZUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfX3W9kuOLF1ueB
 VCgqLWb0Rx2A9qjXJ3gKhPkVWhCNKgvsTpn2rnVWGq7VqziCxgJKtllZ42jnTyS7kmciaLdvZJm
 AXeuwC77GioCmC2sDmk4tboRMtuEM+U=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5a93c3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=IlPRAfYEAefbqxDJwzkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: Bf7uR04XRzRXk6_RJE7GAvmYSioB732c
X-Proofpoint-ORIG-GUID: Bf7uR04XRzRXk6_RJE7GAvmYSioB732c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170213
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

