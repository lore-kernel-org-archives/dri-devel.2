Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2ABDCD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 20:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F4010E8DA;
	Mon, 11 May 2026 20:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XySf+3Ya";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cm6aO5Bb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C0CF10E8C7
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:53 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6X7Y2186527
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=; b=XySf+3YahjCKLFxr
 WxPovLbCYzHHPuQBdLh9CQ8iJQhnWZQz1dnFRiR8orkodnsqszosr5ls9dgIQHUU
 tQ8bQZYNjRDcEzLcdnd8O/54hgLinoDBLeAHIm4i3nWYX2Dhoy7llRQQ1M2DjYOk
 XLqoIs9muLeyHNfm8x0+do7m2W8COnRKgVRlRQwjJrUNSSdkO+ZMPpM6Bm+U5aLv
 sJtoCLD2RFRMrGbnoGoL/DB4rHG2HfOM0lL3vxx+Yct+eOcCUnE3/JMQ5AGNlgCl
 v/vg/CISUQbkA6w+VWaqNkWartdTbqroMaGXbbFotZzq0WJ4PwweAi6znyKx7kh0
 HzWf+w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv0r05m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 20:07:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-367cb6de61aso4904870a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778530072; x=1779134872;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=;
 b=cm6aO5BbhZtKmebrQLbTKiiHMLCCdq7SumUeWGq0dkNqnYnuCFSRc31280UOszor8Y
 a2DCgIMzxFCQ2mD9tfZZSEvAbdjtmW0tEVGjtziPuteeRStAeRvI3U8ouCwOGsKWZrL0
 m2c54iQamTETNUOyv0PLH3QG+0AXQGFM7H2EyP3Bi1u/UGzj6u4M61dSf+WVI4zD1yJh
 4ph7XpD9q5uzTl5W17VHKPWbx7NE/q5Cb8qAxVhCue0/bL1hX8lga2N/SYZ7Aa04JVQ0
 XoSt7L+vKcXo5synpqsDRTjua/mCyYybYAA+mgAOJzJmp1bKQ0IzF1CRwBQkt6FUBOXl
 H29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778530072; x=1779134872;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=;
 b=rT8zRv2wvYec7Gch6wyf4w/vTYmhven0lJbiu1tYfXh/98D6UDycl77NTLsvHx2CGZ
 K6N/r4Com2zhVbXGLMfZb4v+hSVWBqnMnha4DMsAsXaW7vKJiVXBRAbTn6YbEQ9JCVpP
 1gF3PIws8gPeK4bCq8H/0kf/svQdjN7T/Z5feesd+W+PbnebwKTWMSjfFNlEdIRgIiFc
 qaKeidVEUlaYJwK8ks8MUQqde1PUwh9RbLhu5Neat+7O9PIVOjBm4a4ZBk7pE1U+BRxK
 oo6v+uDzFtJ1g4L6I+dQriC9l57mlaxr+oX5MfGR8ciKwyXn1dOsmtJNPXt1A5MFmRhB
 q6YA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/QM7F73TJQatyU8S8hMbCGbDMBpy5X957FBblOU99JuceeR0FAywy+jz3gb44QiAcEYhCKvg5JRAI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyn39H6JPqb94TmqLUoDOrgkXAXgzlhrIF7r1jvnPwtBJiZRKYX
 z+NsboVGT9jbYJGi6Cv7VUyE3ILSUIUW69WyIk7Ftldz0UT4fxm9UuqIL9z7Xxv/L32EW87AEf/
 69iv1GW4YEoHqXgmzN6s982G6ET4GYFToXK1twhCN0B1ZNsHXLPPbR9mjPpEyaUDHkCNnj+4=
X-Gm-Gg: Acq92OEdkdVsINHNTwkZ3ezeYo/UMGp5JtS6/2x6dsZfKUPvNwSw2GuCISpoplWyhu5
 mP6epPxvh1oB5WtFg1PgPFBRROt8Dbi9gFDkBnmeOLCE/Coj5ETTsJHGvSQijX9L0CZk+qYm3AB
 LpHdAMfywgDqGsafVgS7roKNrAUhK2pkS74DHq5Yhj4RrcLPOy/TQiyjwGslh99JM0Pu99Y1+nR
 rb2lPpVD4ljkUD4yZZSQU43IjbL7kCNS7/sGhTfiMMonqdZLiwSOVrr51806fA28iaC/5K8gbb4
 6+APgYK5yP9brAsohQ4B4QagYju86+BbiDAAuKfx1jvaP/BuIVn0Y/RZITzXT9hUR5DGt15t7WB
 hEbqpar5zhKN3Lp1kotANrCYXPfhwoGYGGnEtMtrW1EwkmA==
X-Received: by 2002:a17:90b:1c8b:b0:35b:e4f8:7b2b with SMTP id
 98e67ed59e1d1-365abe8a3d0mr28761692a91.18.1778530072184; 
 Mon, 11 May 2026 13:07:52 -0700 (PDT)
X-Received: by 2002:a17:90b:1c8b:b0:35b:e4f8:7b2b with SMTP id
 98e67ed59e1d1-365abe8a3d0mr28761651a91.18.1778530071731; 
 Mon, 11 May 2026 13:07:51 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-368b01ef884sm64911a91.5.2026.05.11.13.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 13:07:51 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 01:37:02 +0530
Subject: [PATCH v3 4/5] arm64: dts: qcom: glymur: Add GPU smmu node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-glymur-gpu-dt-v3-4-84232dc21c03@oss.qualcomm.com>
References: <20260512-glymur-gpu-dt-v3-0-84232dc21c03@oss.qualcomm.com>
In-Reply-To: <20260512-glymur-gpu-dt-v3-0-84232dc21c03@oss.qualcomm.com>
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
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778530037; l=2464;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=qFdQhBrAHggcU0GWES+ohMA4WsH2wnpDPMNFqXrANzE=;
 b=guWcqvEXlOg18VWFlVGJK7GD0f3EEXvKBY0xuASDpGlUq1jirx5N9pH6IzljMaz1oh09424gp
 wFYY9XKopBUDi3NSX19zaHjYT9i7Lty+lq7HdZ6NbMQyV6T95NzCHaK
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIxMyBTYWx0ZWRfX8yGTXmRkRniv
 wgS+8I3v2DbPGX02IH2ebGwFKZeavPLFYUqly97lGcR+TUCqI0HLUNZaEeofaWkNbMck2z94HPE
 raj0VpLhVels2EAr1BR0h+JGEH20IpL80zXp92rkT7A1e/gIlYT3A3YYg7PiOcK80Dkru2opNiz
 6ebLzsUdvq3CndqGUoyHFbul+/y1pcp7kESRcbVi0aCpJNSNEpNVC1AAxSYiC+KduuZRjiAPx+M
 Hk4XFI2i58ooBIB/gUWhvxmOg8WG00dDnJJlCUaE/MfIKThGRpeuo9is8750b/6O1R42JBveiAO
 xuTRquL8g+pvCWyrvv2EnkXJvk6OojsAAAigG+qHtLh9Ge57MTREboUGka2W2bYBm8/OQ0fP8Ac
 fhf7kOgc2GSKMsN5Q88rJ5qPqat2OTFPGqAmS8vqEjoCR23OldSzqqU29iNFG0GThWmgPmadLbu
 hWDmBh+Dpf9EukAZmUQ==
X-Authority-Analysis: v=2.4 cv=bpB8wkai c=1 sm=1 tr=0 ts=6a023718 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: jYe1TZSaa7alX5PqJ31gitdZh0XfNmd5
X-Proofpoint-ORIG-GUID: jYe1TZSaa7alX5PqJ31gitdZh0XfNmd5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110213
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

From: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>

Add the nodes to describe the GPU SMMU node.

Signed-off-by: Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/glymur.dtsi | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index ed9aac42fcbf..5e76a0d53f01 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -3729,6 +3729,44 @@ gpucc: clock-controller@3d90000 {
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
+			dma-coherent;
+		};
+
 		ipcc: mailbox@3e04000 {
 			compatible = "qcom,glymur-ipcc", "qcom,ipcc";
 			reg = <0x0 0x03e04000 0x0 0x1000>;

-- 
2.51.0

