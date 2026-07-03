Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF627C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 20:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0508D10F8FE;
	Fri,  3 Jul 2026 20:35:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kbXCX3Zf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RGa/4LQ4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CD1A10F8FD
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 20:35:55 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663KPa231020375
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 20:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=; b=kbXCX3ZfPE8xGbMt
 vMJtWU22XsCFV4p57+53pKeA3sF8erE5WGjuAIJ4v446eiEkXE9zyhh9NUiRUtAV
 vtfMB12w8Zz7nIM3aJN8gA/DmwzV0BKfCjhOp3EVC4ygnbJAzWsHakrDG4oyQqt+
 nG3cBLf8FbOA6iGXzcsCDQbwZYAI67JatbACMAOe+6vCX0AyEq7EJrxcz3AGLtfo
 qBoQg8XhoCRmU5wJTrTsMd1eqsCOXQpB9KeAyrASJwukltn14xq18TPfZY57Z0Bi
 b7pMwGhGFFb5tNuFjx1PGGYtj9SN/GmngMJfETIFQlcjhqyyIifDM1pqW3uDuvwz
 HJ+mog==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6dkkhd8e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 20:35:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-37fc0aaa94cso1478822a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 13:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783110953; x=1783715753;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=;
 b=RGa/4LQ4vma0aT4rBVrkIRYayrJV+ahAu8R+N/qgE8PsoIWt74qbUlDz5eXXqx7BK7
 wPBnPra1tUHkW//J+sbc2tlMYI0bvJMWlBZEGvx09NppdXmowDv9YNKp9GSGNLIWW3xq
 kUqXSI6jIaFl3pgCMCRMnzgMFp/eUWx4um8IrnMfqXe7at2htxufdo710LHoI04p4tj5
 fCvyRszomgNVdxONvE3J1Tu6U9y6InNYKBgt3K6Jy7HwzMj14vEai/aA/ctcWHZA0McO
 EEwLZRpMIJhnAEdlVlf3vQcy1Q3S5ZP4pq+GIzg447i4uwDeqbBan8PRGc+pYH3EMtCe
 gjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783110953; x=1783715753;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=;
 b=Js59128SWq/kwwMujqhI9m0VCnUSx0yvKM+FxvKlgGvVnnknpeOi1LXLtN+LU+OWYn
 0XGxDharfriwyrduJzr90OnFS6idPyQYedp7m6yXYv0+IztJbHlwYhuvPtm2MLiRUQaf
 uUiNgAmag73HRYbEz5a962x62O5UKCfUr3PAm3aerYeov5Umehh7+T/snPgY/USGT20o
 srcNM3sX2yU5kuMimvcT2cdYXcNh18M0+c/g4zmsJHcQgH6sGX9VvOFeJzdbhz3Ut4pN
 IQ3QvsP3CzZ+pu+R/uaD3/RAMVcypOi7p1QaDaO3ESz4BnNJDDgm8VNu7rSs9GrRdVWk
 S+dg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqY1Ws8hxaMemm/9U53F+SA8/QZ+m9nf3lmHFNkwjAj+18IxhDGj+unp6p7MYxwY7ZOOfYoyicj5eM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyM+0yMGIfFDkVuPXGjcfqSq0nF6+fV37BNfXFZw5tH+e2EUlJe
 u7VMAQCxC3/IAyAPTTsRXAE5zj+9vipQVkjAiGiLianJlbrNiIHgKb71TAqHKRexfrUKodEbJ2Y
 u7okH1EXo6KuItgkpZtAjofZSDBPz7t5aWRScDYqVdJ5Y39wa1vPRH+SIPOPCYYC5zXVL0NI=
X-Gm-Gg: AfdE7cmyepe0vhYfEZ5XMDcqnO4sxBjPU/qhBSzvtGvfTbMyVWls9WYkyE0kuCUAwC8
 PoKSqBtdIRj01pNlkqwokqzQf1qgqJ37XxCo5U6MX1C9qlZ/XT004EW/1gmvk5O1RPQkfTysxKp
 fyQfzSX9/kztgl18EvsfJfJG+mf4kZriGXPH3eWUDx+skl6iX0iyBO+JmH8yVsT4OuOobYWiI0p
 vdI+d1KJ5LWlLkWerR6kFzDjEbkmhJ+nMCy0kxNFm4nFkSBmGTLRKibJgNzcs7LVHTMN6GUK3D3
 jU5rqEfUmZhZzoMn90GCpreHoXtWLYWoeN/+JRu+9lbEahKI46F/PD2ApTd7kz/aGRyLMAZHGoM
 wNxJ9qFIYe2EAcS5Xfk5vQHNZquBgDeWZF+Y=
X-Received: by 2002:a17:90b:51:b0:37e:2053:348f with SMTP id
 98e67ed59e1d1-3829f7e86c6mr859262a91.25.1783110953173; 
 Fri, 03 Jul 2026 13:35:53 -0700 (PDT)
X-Received: by 2002:a17:90b:51:b0:37e:2053:348f with SMTP id
 98e67ed59e1d1-3829f7e86c6mr859230a91.25.1783110952611; 
 Fri, 03 Jul 2026 13:35:52 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0b7b9a8asm24815567eec.2.2026.07.03.13.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 13:35:52 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 04 Jul 2026 02:04:30 +0530
Subject: [PATCH v4 4/9] arm64: dts: qcom: shikra: Add Adreno SMMU node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-shikra-gpu-v4-4-90cf1a52e539@oss.qualcomm.com>
References: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
In-Reply-To: <20260704-shikra-gpu-v4-0-90cf1a52e539@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783110907; l=1898;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=EYNcq3OFs2Ql/wREKtEM5ji0GMxwTnKnJ9RpGAjMe6E=;
 b=VV53sBo/O5fZ+NGsyhq4LtyFTf/b+WQ8uGjvE91A7dZXdXWNqRQAjopFaqZ2FFIMEKi2ZmO1b
 iWCZ4r056a9Aa6iGB0aED9govTFpDOH8j0BvDycAX5GdmmELVWBCWVb
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX3kFo3zebnNjg
 7L2Ewn/DqGBpk6NOJtpAKpAtI/ys82k5YCKYhyfiYIy0iI74HO7DAiXmYKarZH97Po7uQAh9kSe
 JcW+t/esj5HfpLfwuF9VT/9gA/hBvDPcjzVo9slAGCa3aZUrTM9fH7CzBn+xMbIR0lT1p8biw9m
 bC9N+LXJURDD3XajEJFTITcPWypwRltKTHk6DPYebPgnpAD2Nj9yYEDQjOeYvRXXUQCVqU/f2l2
 lMF7KYnR5mGfhBvYPXmnzp8PRIyvP3P/k6m9S6gC6xpubrTEGkawck9LOEuYWPXkav5d1Bkv/UR
 1rKn6a8RgzpN3oRQuo391R6hEjhHIUiTJ0Ku/unI47ZrEZRuRn0d1deG8Bc71xOor7p2RKuRTky
 dTTqXRQ1GUzPzVe8R3XhpUSpEW4TM0geY7gpszRVCRjDsZb/EmRyCDqQiTvQyrJx2J/6YoeYURN
 B0cSC/4uVwsxG1rw0VA==
X-Authority-Analysis: v=2.4 cv=LeUMLDfi c=1 sm=1 tr=0 ts=6a481d2a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=zTWU315qYGxAnKAOPQ0A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: VqXpy1cR-d4AaTM7K9GFdDsEW-R6NyQp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDIwOCBTYWx0ZWRfX+wthK3baaH4f
 t+pHz8YatEu1Z62vypZ6Y8ee4H3yzLiYV4KLCBiVqi0qLxOjNvrA0uXTJGs/Uth6f9OaR/XVcBH
 GjaQqzzsiRXHrJKdE6MVLKmt8El9UfU=
X-Proofpoint-GUID: VqXpy1cR-d4AaTM7K9GFdDsEW-R6NyQp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_04,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030208
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

