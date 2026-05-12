Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61EBFCD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A3E10EC10;
	Tue, 12 May 2026 19:22:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AHIi4XZO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q52/ivj3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BA4410EC0B
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:22:23 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CIv9uk129123
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:22:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=; b=AHIi4XZOid2bnlQb
 QIHtIk5OsfusjNOScnd7fdBKK8XoScIVE8weXJViPK6qOIkFnMDHkzuSXXl3ya4/
 bpcD4oP4jkNV9ukkZTlqRsMojjMcK1FyOWXrq/O1YQbP3t3mbQ7HF9qYAEw38sTo
 NKvqTZMO6cNaXE/9rcm+9nzEpdMaHDd+VT2BCuPUOMEzlz3enK4tIcEZ2XYxYNf+
 1M/xnjIAeV42EbXcQzJuamxAJeElG+D9nzcgTUv67R3R8lHicTuNTbMhksRX1Y6B
 fvz0WGu3BWiBZ0eu58gVfp2UXR8lStUa34jyR/YzOBDa5Nf4yd8ZXKmsa+Vs6Y78
 lHA9SQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e43tn1py1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:22:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b2e8bba2e6so77064265ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778613742; x=1779218542;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=;
 b=Q52/ivj3z8eUFpb9J3gdaDyn4AdNgsKILyq89KZXg23p4Wl2Z69lOYuEXaRs4vUOZy
 o/WQBY7pw6BGcvuhMeKQg+CrtbsmoTmL/pShDZZ5ly8mfEACIX7dVtCp1KZwZBzsTBuS
 4oFYhN9z7F0bi359NOiY19/eWqA+H4Teb0mjqxWjYmA5u6H14HEvS8L8vKhizD02bAnx
 flLPMrMbYeaSE19xKa5H+OC09q7ofBGrHRxsys7P3MPiWFSbE/xayP8kYO0zYpwgrGl2
 KaJsKr1raeyXQdaTtYJf46khIfPy2NJCdZt4MVahOOgSsM3JnqABl/3v5pHP9RtAZHoL
 kNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778613742; x=1779218542;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=;
 b=bW/hRCaIEzszQrhcvMM4j8+jz8kWioCQDg9LeA2rrOzL3T8imSFEKkpbBHq7cWZmon
 l1+GHysR0k1rsHzG/7PxEPKakDU+5W1dVC4j10WuBQ3VSORAyw0hXcJ9NMn7d3LqHEGM
 FhLPhlR3TkrTjjMuN3bJsnky6Mq9ZPWsGew60bKZGRLCK7SGlnqrAwwtVuuJvLt1M2XB
 MV9HTYsR5Zbtor3hzw3/txSfmXfAU1YzGE7StDGa6fAvApl7SGeu4sOmyidgNwsD82R3
 RPJOrzMkTwlwdtd3TCvWNuJsuUf6gjc9Pi5tcG5LxjOmSoBLn1AaUGSiyzEpE2M7x8j2
 vruQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bMGMEZmJB82SOV2Jsc0wLmieICXpTgfiwEyN+L19bON6W1oQdQh/FuBIaetfXl36veHe6KssMe4U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzznAf5Vq4zQYPsWK9cQ22+uDQTJbDC8xEapk+94+kAOxNfZE9G
 AymGs225rbuoh+Lsvkmyy57FfeM4wOr4HODz00I39Dh79iKQpRRnFK0UDTe69UiDJUjMwACc2Wz
 81MYjK6fX5J4dyEg8nX6IZGdTo7tjuDKdgMShM5hjcTgR7zVUv0d5vqnLgB3vbdKm34KqLFA=
X-Gm-Gg: Acq92OFYWuMuQ1Ebq3OL9sWb29aGlzuxAfvJqsbq1OZmVnFn33RdTL51GBF1h9qWs/w
 ywnQkfzmTe8C0eIwzJAiErZQ2hvEOTiAbJ75SjNo2o/og0bABJ5JtniEAGVXX+c6auFf49vnQ9Q
 KRjzMojGosN7zn4a5WTDMvfpFXVkRcSBfSwZnN2iaPKuoZGOffQJdTerFmPXma+3KJ3L+5PhOp6
 431zT/id55iVtuqbLJt6M/HP9gsK5YizzLgYNFzKvZbyN1CWYqiYh+VplISqf7KBs618RBmnaES
 WqDKD0zrpXmxlEigNEr7P9ndqx0TivzTUMQzcPQH+sJEzgHnFR2kvFmVEGUPqwZvHsXCTo7wUOB
 hBabW/EUyaHAGfrWDMq3+e9f+pSs7iAhwCVBIVP00FrbbZg==
X-Received: by 2002:a17:902:ea8b:b0:2b7:aba0:ac10 with SMTP id
 d9443c01a7336-2bd273a8a92mr2765855ad.11.1778613741946; 
 Tue, 12 May 2026 12:22:21 -0700 (PDT)
X-Received: by 2002:a17:902:ea8b:b0:2b7:aba0:ac10 with SMTP id
 d9443c01a7336-2bd273a8a92mr2765565ad.11.1778613741469; 
 Tue, 12 May 2026 12:22:21 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ead90asm141250585ad.72.2026.05.12.12.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:22:21 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 00:51:21 +0530
Subject: [PATCH v4 4/6] arm64: dts: qcom: glymur: Add GPU smmu node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-glymur-gpu-dt-v4-4-f83832c3bc9a@oss.qualcomm.com>
References: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
In-Reply-To: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
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
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778613699; l=2464;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=qFdQhBrAHggcU0GWES+ohMA4WsH2wnpDPMNFqXrANzE=;
 b=qewqACwvjsAf5rvaenjM+cLqWEE+eh0c4Ai2zQhfpx1rVMx5eMwCU4q16+hHSs93d6WWBiv12
 Z0Idzufub4tCvGngKqrEcib/6jgSNpiH55A8CXbP5MkDaWFgVCZm9hL
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: ZtRtIlANQd1TFxDOIjGSKdsXxnVVph-Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwMCBTYWx0ZWRfX5Iskqtg4scZ2
 4XcOQ5jHhCkppM07vOqn1tC8+dv/BGOY7efvEbKeyh6IDaB5phP5sjALQeUktDwyWFU2K7HO9yU
 ua/swyZju9Te5jXpQ+xnamfORysMzGphv/8Qd6yvs18uoRAypNM/VQtBldeRV876lV1mNPEsLg6
 cd2Lc0KB94G4zVgya59M+PxBPdCGy9ynUgwd4Gmk2hMjtVTi5oYQNDERV2yBtBvYttmLay34cQv
 CS/KhO9Fh1rTQf+Mfj6R5cgpqwYixsIC4hVM/uyTMTJ6gsFlkIVibPa0+9IHMFE+NskUkKGA/Xq
 pkBDyu8vDSCFCzq0Sx6bDn7+PDRad2Fz78XM0WYbor+sScgfj7oRfaqDDdcEVWGFReGL7BPFYhz
 K2g5zAmsWvBiVVc7yZ/DnYRRnlQlaELFKQWALeRz+Gy4iUEcY9iYHQHANi8MC5VuKMnnqTNQLGD
 r2eYQhfCjsKSrNNu0SQ==
X-Proofpoint-GUID: ZtRtIlANQd1TFxDOIjGSKdsXxnVVph-Y
X-Authority-Analysis: v=2.4 cv=Ebn4hvmC c=1 sm=1 tr=0 ts=6a037dee cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120200
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

