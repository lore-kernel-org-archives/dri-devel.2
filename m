Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B035C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32C310E158;
	Sun,  5 Jul 2026 08:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F8GfDW9B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jVszVOE9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC20210E14F
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:01:14 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664KYSmE3977162
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 StFTKdXZGdZFi7CbJzvKqi8zQb82h4UxLwN1tS4qKbU=; b=F8GfDW9B4t3o2Ow7
 mSFrZM8hZj1xH486Ik8lcZU3sm2KfRxIrl+rQEv7RzYxBCgIxJ+n34qiA6D/rQvF
 xzEVZamXH8bwZ/zTSKtDygn++pp4JQy8svP6OwYl41aJ3nIZA7SS4qo9fazTtq2z
 N+wQZyf/FGtAOEDILB9L5Vv0njN3slMLQ19gkGitGsVq5Pb9aRLCA3PbSzxpuT9X
 88rrgTDM28pUD0QkGPwyq/7tS0ZkEuPVDx66hN0rf5QIPGWjUhxRU4PQBgcHlfgd
 YLO+NNb/WDMLXeU/dip7rvBAa5XDpIjaAOKSkMp5+b7esCZuR/VV+7Xm4eNAtbI0
 FpkaZw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3a9wp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:01:14 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so1034797a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783238474; x=1783843274;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=StFTKdXZGdZFi7CbJzvKqi8zQb82h4UxLwN1tS4qKbU=;
 b=jVszVOE9oJ/6p47BP8C+WdIxB4oJxY7dwSOUcEk+7sbWD0rSQA0aq/KNFdtvKKDqck
 SAeGqUSM56G2+xqn00HkQwCmY+1Qxd/1q4RvtD3Mj+IFcBBSdxG9ZN/TeYdBg8Pn+nii
 O9x9uQE280TJSwv2pbeOCEnchtweRVPxfd6ev7QrDdZeVwOOZy+5fny4eLnUQdzfmqYH
 iF2Wmi+Ef5eR1xtBZ9XqBcNpRvExB0sRvnlXIjgoct5UZxmDv23PHz+V+O65r2FVgdpU
 Jl5Dx/gcUOLmI33I5w2yY7VTIj+ZhuCNbm2MaX6SHa/1fwHYQZuDJPfOmMHFtIyVMXLm
 FrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783238474; x=1783843274;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=StFTKdXZGdZFi7CbJzvKqi8zQb82h4UxLwN1tS4qKbU=;
 b=Pj64XLnsmhA/f8clzH83U3cwvXZSCQswMZJF+FropKM1uXUsyiwkBkGQ2uJEz7ZnJc
 3wIW9uWvhGHG2kQPFIKAn3x8rxQBiOMw/5iXGRFHWw8kL7dCEMYLIAkCzUwm6zVpuxaA
 4OQRouMEAnwrgvhaJftpr1IfyOnZOPpMU6m+Mg13kjHLvNh/F9oWj+kYPvYsY2hlf2/j
 iwKq7kabAKcbd+VDtaA69QaC1kAWDwDYjtUK6ffPvCGwlpvzXDLEcVkmYf0FptO43nuT
 wWvfd5hnWbHAd/mQFPL6pbIVGnuuwH06NaxeIoeg+dAY27Pi8lNr5bYU61w9xJPHzP7y
 aT7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqMFQ7dOLNkPg7lvCFVANrM/ycvowslHebR8f5j//cL6kFA6eSgiVAputgcs02VPQEXVylHvwRe4JM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/YIydbYJNSLqyZow9IDCsVWyBTd1cTEOa5VjoUfxks4ii6457
 SDhr3r5tUIxgU60GtTg4UEYCIxLLRnHuyIzXf173mWYWtBQxqhWIdQNBCMhPmX/xQQQhjG/5zWZ
 0JN+8Oy3powzH+GcmtneOB5Bypv4rGXZwgHPjk+IoJHOKOQKP6dMwPLsGqC/A24iXBfbyZsw=
X-Gm-Gg: AfdE7cl4DDAeB3yomHUXm/bF+lMc44FXecjg9yVzeB2PaDlsbC+wPXt/MWWvcthfM5D
 HRRA2MIOZltODMvxBchytglMAKwhJIElmMIgCkVRqSorN6gJq9H9Ml6ck30c9JsEqolQY1axI33
 4uSkDtSbfEaj7tAtMPLAt6u9SfpDS738ipJJO2AxT3uMuIWz2+kL2iqymov+q/d5tYq7zCJwSHR
 QdI9BuPIL414ukpzYxkEeqnm5BrTDZPpL0YvSO3H1+QvOyDr44nhm5RCzfhdlCcHMo/zSlC6IEP
 GANwTDcS2i6aNzllmBMdG5DXYhSNi4HISRcbcktJPW9IdPN6a4P86VN0bvuonf8e+Jm1PWg4I0z
 R7TUHIR9Jwx0c4OtismWUI77WPHIm1zpM5l8=
X-Received: by 2002:a17:90b:4b06:b0:368:ed26:15b2 with SMTP id
 98e67ed59e1d1-382807af3c4mr6120302a91.8.1783238473289; 
 Sun, 05 Jul 2026 01:01:13 -0700 (PDT)
X-Received: by 2002:a17:90b:4b06:b0:368:ed26:15b2 with SMTP id
 98e67ed59e1d1-382807af3c4mr6120271a91.8.1783238472790; 
 Sun, 05 Jul 2026 01:01:12 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.01.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:01:12 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:07 +0530
Subject: [PATCH v2 3/8] arm64: dts: qcom: kaanapali: add the GPU SMMU node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-kaana-gpu-dt-v2-3-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
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
 Qingqing Zhou <quic_qqzhou@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=2414;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2J3wxVNsY4ppAiRVvLGUwPpm/Kmj8pqOhBbdF4kY2vw=;
 b=k578A5/54ikUDp8kLnqQMv2fOTlVQ7Xm5nrGCJ4mzGkT7xA6MAy/zLB9vcpg4v5kTvgvtBoGk
 96g1g8ZDfYUBT5FeUIfmS4ddkZABbHayBtPZcgQ7p3K7fwb6+/tGgcM
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfXzXwCUpfOzwYv
 4UGwWyTP49PMDHUtwVB7+JDZKCMAfO5K9wRDWcTUxuVSKawi3gp29xSYJdcvY35pCN1jxTAn00w
 opMP7EHegzZWspMeo7bws4XT5ocwOUA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfXwcOsHFNiZWEw
 IldL39CmjmscxK3tWhYprUDb5s7+6aPUsnb2vv3yquDJDxvobNTmh+lW3oSODpioNq5mEDu/V31
 5xJsXouEUNaRi5yDGzFehzwoIOrzJ9yhlhbDdAuVNltB8KMI0OcLVpsKWWuvef8AmKYugJqEIQf
 hff7nPf5ll2YrgKBn9z5KJO0h7mNSA/3q9ZA6MBm1JPxIIHy9A7CVqD+oVLKE2M1r6mdp4lvFF2
 mCzMzsxhy82zXXtA854RZxdJHkzsHwE3TiRqqWlsruQiHHWgBMmMeg0Q5twoDAwWoyBGz2FN06l
 FK0C6huyeHPixpN+tzySt4Eyi55eiwn8Cf6RcAtxBciV8x5x8m/fAwihVZ95DUq0FHnjvJ42bYk
 ikyOX1JHQK7ftYVa2/CzjNA66QYk+BSEYxAiryK3ickHjEbCaSA5ixTjSgHWEjTZUIXYm5yhiXs
 IUjNqWoIUT15w8xBbuA==
X-Proofpoint-GUID: IbYH8WjO060XY9uvOfGwLMp170aSO7-I
X-Proofpoint-ORIG-GUID: IbYH8WjO060XY9uvOfGwLMp170aSO7-I
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4a0f4a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050081
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
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index 7aa9653bd456..19eceecc2a19 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -2601,6 +2601,49 @@ gpucc: clock-controller@3d90000 {
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
+			dma-coherent;
+
+			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+
+			clocks = <&gpucc GPU_CC_GPU_SMMU_VOTE_CLK>;
+			clock-names = "hlos";
+
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
+		};
+
 		remoteproc_adsp: remoteproc@6800000 {
 			compatible = "qcom,kaanapali-adsp-pas", "qcom,sm8550-adsp-pas";
 			reg = <0x0 0x06800000 0x0 0x10000>;

-- 
2.54.0

