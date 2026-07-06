Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7534C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:05:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3B710EACD;
	Mon,  6 Jul 2026 21:05:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P9Jj8TM6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dCzUeREC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AD4610EACD
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:05:37 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE79Y1428953
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:05:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=; b=P9Jj8TM6cAcq3H7r
 wjqj6sSGBm4x3syZlkv6YdPpN+WR7zgnw8sn8rttUqC8w+Ux5lTJdlrWiOwLZX60
 soJUYBVsW1d5qsqErak8xliv9nP4I8vAD1rIpJIuNhCyPGc9Brsy8UORhWme5eFt
 cjV2JXrvgTo+VOMZUQkf6VWG0ZWG2W6ZLDWGCx5C8pUYiYY2qsTASxr0pqN53xxh
 EAsijqCklh8y9tobAaph0fesmhXZeKYNeRpUybL8eGSWyxeD9Yl/VTnFccc3ZmvD
 jm3ONgl0G53kRZR9UK5x7XfLhyHivpPsOyBPqM8pmanF7CZFYvyqTpQIVK3jpED7
 wGIoUA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxuhdc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:05:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8894570b58so2431523a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783371936; x=1783976736;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=;
 b=dCzUeRECFaZGoVKoEdnhazUtQl16xZRXvh341qjmtN2iN7tVT/wYv0IL/yzbDsyJZD
 ToXdkhW/UIBG0/d5jCS4TJklhQKlleWB5BkMoWaCNRxdcNxzyMfSq0KTo7NtTXrZ8go/
 pwmdQRYTuxBMigF84UzKFj2oODJx8kVG3LBuF5/s2O6lUwTSKFD6OE4dCw2yjHvw6lVl
 JNAuCXod3qKHTjxHWsUVSjn2f/1fuw85BD+W76Athf0qbm4JB28yqr581CzZH5LQpfqw
 VqLPBUqJ3gGT0M33fUNKzR0LZ45bZX0pHcOCPMc2omlZXcz0OmzJQvVgKApfICBf+J36
 Rwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783371936; x=1783976736;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=;
 b=LXVxUnD7ME9juUr578JjkhnMIiC3nQaFHXxA74skCArZNvfwbIzCDIju8l2h6nB7f7
 lNb/j0sGDBkdje1pEdaE94Oo9t1Goxx9gykRbIVrJGbZidZs56h3hyRmYTAxKTy+EbHK
 KEXAdioQA242x8889lH3rDjhDbqxCq5IJVFo3n8k6cMBWXuFoyEXF4ap9VruyUspjbcr
 G1vFY521GsTWtWYc/w8kUTk6hYBGNbOwd1YFtIVY8QSJ4xOZz0G0fb9S+ZT1AGucMelt
 MS/c5IZFaoi6mvQRl45DiWvh4UwUNB6B+yPTkvZRjuYQgmOsdCipYzI9INtmBVobkOf4
 i1ug==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5Jh833RXOxmSgFobAmdtRgAJGPRUiW4oFOxf4Xm1CbtiCPVu8twXSzgZ1D45EoxOAcfKfSVb9oAQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7ZXsL60k7mfLSuz+B562NmYol91dKmqYXg2pVx5/3yP8MAxyi
 iWX8WY10Xvh5emEKCZ2J4JgPgEAY5taxWPN7tbhp3jtQYDdGd5ElP27XB1Jsju+/MZSYoJcKek1
 vTPwW95C+LaOXAyBpKCA8sZ7Uep8zaoDBDxlTT1oMCqLFTuYR7wEMXrgNJULiQWlq+ka0260=
X-Gm-Gg: AfdE7cmLVJd3N2MXZi7eXuKFO7bniBm2tvn6qFGkRTr0zp7zgbkoxFc0FYAZVKFVGpH
 K3b+i6mZZS2HHssgQeAiX9GrrJEVl3fpIIE2RSdzH6Sy4qEofGyvEVfiL5Nlc0Jwrn2l1KQmic7
 aoWnuQ+fKW6T2hVBxig8qzrcL6mOvbVNokUZp0u7xtXpAYCgNsvOirpIJhh9BALavV0730oNBwq
 SjeHFCcxJYrf9U0bksuYpU31llwK1LgkFwkNKuuhgOwd3D6kSySVJ1Gv0hAUaWiu+Fv6c/WJWpD
 beOmWkg3GNzhjdqnCyOTfFx6d8Z41BVonUjCY65ynchYBB4SDCjZlaF2xL/oOyhR35WwiShbaD8
 fsOWaw2I8xohQcXmMdSPCgq8Rr/eIbFhgqcc=
X-Received: by 2002:a05:6a20:6a07:b0:3bf:9e25:1a13 with SMTP id
 adf61e73a8af0-3c08ed5762amr2779194637.15.1783371936172; 
 Mon, 06 Jul 2026 14:05:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a07:b0:3bf:9e25:1a13 with SMTP id
 adf61e73a8af0-3c08ed5762amr2779159637.15.1783371935725; 
 Mon, 06 Jul 2026 14:05:35 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm305031c88.15.2026.07.06.14.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:05:35 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 07 Jul 2026 02:34:36 +0530
Subject: [PATCH v5 4/7] arm64: dts: qcom: shikra: Add Adreno SMMU node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-shikra-gpu-v5-4-d2f373912d3f@oss.qualcomm.com>
References: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
In-Reply-To: <20260707-shikra-gpu-v5-0-d2f373912d3f@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783371890; l=1898;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=EYNcq3OFs2Ql/wREKtEM5ji0GMxwTnKnJ9RpGAjMe6E=;
 b=DsMZ8weeC1FJ28PI4GwkWbJKDNIUqDgYuPQPbdoJatJcqoYjN0mvkvVRCXgkFLpEvRW9GGIIr
 imbpv+kai9SDEKXMg7NTAHIPZgWtHd9Y91kx+N0s6PgP2ncPgsQzm6p
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: A-DmfKsS-v9jB5OVBLYTAHRjEGG7cJzM
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4c18a0 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=zTWU315qYGxAnKAOPQ0A:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX+YhkTbKDiJfM
 0kcGPCaTuvdCZotum4hTBMCdZB1CErrHgP1clGkqfvnQ3nuqlVrjS/0l+L3W3YrnetOZ+nVbt53
 C0QusxBe+uBR6wPeRDQpB1HBtpJwEec=
X-Proofpoint-GUID: A-DmfKsS-v9jB5OVBLYTAHRjEGG7cJzM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxMyBTYWx0ZWRfX1VIl/orwvmq+
 kzKTPWJz2Kqg3v7+DVNXfaB+M/HxrIkm794I15fm+SXBHzI2GKAiIkbMslY4AAfs+Iz2RhL2wGb
 4Jfco3I90SqtPuRzuNUFcfl3rS6t5BQmbrw5k06T5/lhZJCfwxj1Wz+XZYIsi2ojDPgQdFsuVm7
 sLGSWCD3FbwSOG+c7mSfOyEHSycvU5c6Dcbqfv3+dSrdAe4/AVcA+9+HZVivqv+PEUigDao9Z3H
 VdQxtdCETjurvH8kUBKAAYutH6ttqNC6XHwxhR5sOpbPxVtxoPSDVArADeiGgJq7OZje1s25Xo/
 RQBw5qGF9sFmP/6luKxr7wsRHckifzwV5waqLq3BYTdhquFejnpIdxQukea29fgtOdhuH4ewzQl
 PnC8ChwTHiW1GXxxnk1bCjCGgFXajdWR29HLKm/yVWXVOC9ZvIxU2iAOD7b7UIvTu4OTxlbqeK+
 OWzcz20BRoEUKqMIJqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060213
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

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add the Adreno GPU IOMMU (adreno_smmu) node for the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index be443b362576..bb11e832d9a6 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2005,6 +2005,35 @@ gpucc: clock-controller@5990000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@59a0000 {
+			compatible = "qcom,shikra-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x059a0000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>;
+			clock-names = "hlos",
+				      "bus",
+				      "iface",
+				      "ahb";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+		};
+
 		dispcc: clock-controller@5f00000 {
 			compatible = "qcom,shikra-dispcc", "qcom,qcm2290-dispcc";
 			reg = <0x0 0x05f00000 0x0 0x20000>;

-- 
2.54.0

