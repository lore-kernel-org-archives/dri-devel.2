Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061B0C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 18:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC6C10F1A4;
	Thu,  9 Jul 2026 18:43:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nn93OOl8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bmxGAKe7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA04010E9C7
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 18:43:02 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HXKil2505994
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Jul 2026 18:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=; b=Nn93OOl8OZNvmHgX
 gvJJp5QWD8pxMtDdHmWnsdrAZYMSIBorgL7VdW313o8cyeJEFCUe+Ns5n6Pj2G1Y
 dfOfGefQdFUOLAmNfMULNJ53GMT6g8U6vVNKvnHfl+CC9+0/XY/dCIgLEz2MS0cA
 OR3ZdUxt/zV2qH3Z1FCZtTtq5dlLlWdpFcWNReTWRvGmA73ZeH4LjvjRPD5Xon8G
 vxFnXP6Fn09KMDSrgj60yrNRaPl7kLL+K4VdnTU+hW7LpwfEMqRKj5xnPZ9qC9d5
 jawDxZjcAW6rl7rDnpyK1O3+hsvoslrNdcV+kd/mtbYCgm9gY4oO4oD+iLH6TbPi
 weFEEA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa6p3ucsv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 18:43:02 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-381250979d5so236026a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 11:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783622581; x=1784227381;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=;
 b=bmxGAKe7pUmcPVFWRTMoTZN/vf6V4DtuFbJnK8NtNhsxgJUjupuSfZoa3eGksQVqRb
 YxrWH9H9x0IC/nwyoTDGgT8f0l+zmZf4XTc9p0CzuTbaNw6teO06OoZHVUefRGe2cEeJ
 VOu21kNgy62WanfIYeD6LgwCuOMbBvgZtvABwTjE6oIF0OeUvQq6YCKAxAidPukxoi7p
 Ontd92jmPMu/ZnQIrAyd2Wbnr5ZtN+wkA9VKM6TZneKK/Woh3XuIf2BrINEhWAeCKZdY
 0aO1boKqGsG6nRNnhB+V6eNwwXdLAmRsC/vaXt/2ukNC05QuUJA4OV/MuvJafOG3azL7
 a41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783622581; x=1784227381;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2d5kwEQJ4zj6pWZ0cwELlzSxpmKyMsiG0qTFS7qufTg=;
 b=PgRCqN4GHL9kALxFatvSnPd952napinaAfDePzLBPWu87+7IVotL+UguVXQkEwKr+0
 mMeQsDrUBYMbpEWuI8BrAeQAMi6fDD0emsioyOJvlWxasD+v/y53sxOFRLws2VJshO1Z
 lSwYakaouF8sROWo4piDNjP9u8G+Teut9oNU97ufGID6LAUSdtLHcQaPq3iH9wBLOIaH
 ovoDq051RMbfmJ56Aaw3ox9TZfydyWRsE3Fo+8/MJLcS4ZiG72Lj5GFeYTaYOMmWt03D
 ntu3wEXi6+wjnuc63IGuZ5vOyHEc6rorRdQ8tfhX7y3lcvZfxHDLPvyJMwX8UplvWuMD
 SIAw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLygGY0uJua0leUvcoer4ldR/xAO3B/VoF16seihcYk6BIxvPG+UOnzVrTd/IMxmSEo3lYZjmWROk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzFt57c7k0keuSsDEThCmpcd0W/W7uDPAV9FhfjVvPQF+Y33xAN
 +0hI/HcPdiT+bkb9aeyeeVI9JmQfcUHpXvSDQj6QceVIgHClQ9wd3QJw6fOk5NeUBONzF8ygNmb
 1CN9VZWSG/DGfoeAfHFTENNJmVtjRTTnHCXtgP0qqGbwtE3hWmdfwirvgcRoCenHX4fOED8E=
X-Gm-Gg: AfdE7cmfA1RjVUk0iF5q551vETzpd/tlWmzaK7BPZJonsOuf++J0l2XfrqFhd7CwSsX
 V5jBjZpy7J5yCWsjpfGiJy+ptlrnhdJH3dYuD6JT5FoOxNk+BHWiMxyVcOz8Iqyau4nHMOszVcM
 /d2toyLulpFkKgXYD3DcNS/wzwE9i92/TIA2+bDQUbqGaPsdSL+/2mb8p1tRQtxqV3N0YXl8YW3
 noclwOPl7GXA51wFSvPwS2fe884GbOcKYcD1Kj+p6eYQ0q46LjOt4cKUND5LWsq2xRi2MeiR8u3
 iH8vV0J2Ajr/XhLLxfzNbDZ9p85fTkQbHgDS3AKTrk149o0AwbUGtbytaArGWzLQzfMAxobmhvg
 rJPb+jQbQzUvnAEHnIvB/9hlpXKM/ipSlDI4=
X-Received: by 2002:a17:90b:3b8d:b0:37f:eeeb:646b with SMTP id
 98e67ed59e1d1-3893f97ccf5mr7914182a91.3.1783622581509; 
 Thu, 09 Jul 2026 11:43:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3b8d:b0:37f:eeeb:646b with SMTP id
 98e67ed59e1d1-3893f97ccf5mr7914153a91.3.1783622580962; 
 Thu, 09 Jul 2026 11:43:00 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56848sm34205652eec.16.2026.07.09.11.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 11:43:00 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 00:12:03 +0530
Subject: [PATCH v6 4/7] arm64: dts: qcom: shikra: Add Adreno SMMU node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-shikra-gpu-v6-4-b388ec5dce77@oss.qualcomm.com>
References: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
In-Reply-To: <20260710-shikra-gpu-v6-0-b388ec5dce77@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783622535; l=1898;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=EYNcq3OFs2Ql/wREKtEM5ji0GMxwTnKnJ9RpGAjMe6E=;
 b=2hVttTTQRx5zMnrLWm1rAziEUo0KqAbW50W+2RE7kkRSP52+sN8ta7ltAR+qhxhPFdVtIsNQT
 21HAwNZOnqjA1MKkTJmHPKDYJ149gLd1W3/OoOL0yOSPJS/9mcqOXYo
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: zJ82E96zG-quKDf4Jugiiew1JELO_tdL
X-Proofpoint-GUID: zJ82E96zG-quKDf4Jugiiew1JELO_tdL
X-Authority-Analysis: v=2.4 cv=TPh1jVla c=1 sm=1 tr=0 ts=6a4febb6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=zTWU315qYGxAnKAOPQ0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfX6JIbVw9Xrn0D
 Gc+vOykdtQ5jxevS8mZXtwvHly3cTDhhAcMLRBU9HPnThMNP4nSaSDHxoqDLEm9lbLHWdiHOgxT
 /CzDgaUsv+AVFKCX1/Dljcu2C+b8oCc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4NSBTYWx0ZWRfXztVcyzJb1hsd
 qZ4CfaCdR8Aurh7TFuJYhmt4nAOgWk94ejNUZGS0NlqgsMNL9rqPmJJcmc85WnDUryI4HAvmwQ0
 skeJaH5YG3JffDAynScEj/1v3HMJJo2UE5yOjR1hUCjZAlJNzT5fMuFsv/WBiWk18AnSvFOYdl8
 b9EcocnzgPZNC2qqMdd000+F0m2xKmeVUT+8aQKu6czvaKrWoAb5NcdDPy4z252fa4e2evU5MKF
 Ipr9A6tvpPBWPLtULd4x8uZoQdcKCj0+VPUuL+0+yEio8IlJrDxULzm+w1rZp72jsQDAfH7Ktam
 QjVlzMaKVOvRN4ymHdsr0TplBsrsrHTEBW6jdU4RyrTY6wdbDgc0GgYwjuuUXi9EEkabA7vkNaV
 vRyVDT7lvuFGWFBHZoR4h7yRuFU8/XPjWUwr8j4TpmsNVHUVYYq4L5yO46Fv3v9MndxZ+WfD+bo
 oG0GieTYuJhc+/PBmwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090185
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

