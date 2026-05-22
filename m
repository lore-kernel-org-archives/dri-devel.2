Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7902CD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:12:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 234FA10F538;
	Fri, 22 May 2026 10:12:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SZMJ1SOi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H5LGciBk";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12BC10F538
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:12:55 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M8oXUa3532131
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=; b=SZMJ1SOidQow36VO
 OmfNAX/lI/DPOfz4E1kbWdZb+QV76/Qqi9IBNmAhbtB7Hk7BRGIN+kyAeN9T0sec
 Qft7KZdza78Kf+glrSj0oRC9UOCWmhIujnxfnimp550FN4Rj+iOSKFZGNRkpw54L
 Xu8A+eACHkIogqYmc9aeJ2nF/Qtlochx8Dcn/KL935vFcx1VJCdaiu6IJJKpD7vY
 FJDPItryyTHcNER2akP46kPAkRgOfWZPnWslxEQBwQAJBxJkuYnSJWUfpcawHvR1
 v/ZiWePBSyL9JvR8OYXUStgoZPJPW/Tca/RKDGv4EuMuXDJHKYohFwkwUNoqsoAw
 PzEcPQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea39gvjks-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:12:55 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c70f19f0f37so3819736a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 03:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779444775; x=1780049575;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=;
 b=H5LGciBkAnvjBM1ruwhEdzHqCj/1RxLDj893L64G+4Npi3TBDT6raTBtAMsJn3Zh7a
 a3RPJIDsLobhcnwVmerOO8M2cMZ7KqsagorEZ64TWkYLKE+z0t+lT/rwQqJXDSEclp50
 7/IvfEHqHIOeM0XTSIPdu8/vpQpUPI2bh5nFLNFCj+GS54s11v/zZd2JEgHZdpQrjJ6D
 nc+RJerxMliqbcpYGn/HobQypur1R9ZwoaNwyfO4lYFTTFsgoecq+TkeFlTzaMHzMhcp
 UwnuvKKEP20uU1hthSZ7vtcgx5XQKH+EdvfZfjEJEqWdhTMr1xOnw71frJ5lMhCbwGyR
 w3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779444775; x=1780049575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rSS+0xZwfP4yWE0NsCbw6sj47xOcxhNMbb0P26lUdAA=;
 b=qZvAvT8vmCOp/83V+aYgXKtOxNo8tMDxc8c9o4KA4qvKt9G6NM9ilKV6WLrpLfKO0h
 VN16OuMsiQlDfajV0z4QykVDlELm7MNPFCVTOcs3CnSrdqZJSwVvZfKmuOpELNa1mmvy
 h8i3LgoPwEF0LoCHKTETwMlKb1SVnl36bXT2PggGjeKCos+UmieKFn/+yZwRqH/43CHL
 r2id0leCZqxMSgHl5OY+2nvbtaSYkHiNesKg6pQctrqHK69OVQNcgqLe/NM37xt+mTzz
 M4o9gcVcqvWsR6XZQHS2CCberQfUooTzci4/BkntB62Np6Ja66eqmQe//4nyu2EuuOp7
 tjew==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KPKeNee5aHv9NKTp+4q4l9l0sDyd5RZs9ZCtj6l2SGgDxxdhMa9IIBXAQYDhMS+03cx6xtCfuKvs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaA8KUlMNVVTYtoDgdyxizmlanWoWqcbSb0HWC8r6nDRXscbmF
 59s2LiEQspvM4cm3N7aYk/sUkAaQh8W3EZv/nBGrfbHNMDiKMkE7YbaOGSK1u12z3iE3ookP4+f
 zgmqAMy1tzj2UxxqyQPXWEEkNSDhc+gWsCgs2ZPAJn/NHk+KdS+gYxf2Z+NzXRrc35k5YAiM=
X-Gm-Gg: Acq92OHxxwKC6siYb6SVtAQNZNFY0cOmBgrK5MpSED9tO/x72qTTRhpsiQAZ1HpzTRY
 yXD63MMQPS/tyq5I2tk+C+1ZF+hlNLdUajqlXBni0waY3h/I0SKylqYJOA9A3YA7V9ojBLJbgDZ
 9+XzTjOTMvyCWUM2zddCka6cNuqYMbUMZm6h3BwmyxmWP/oqBslhyco1YD0bomUOUkIKxfKqnbF
 XkAatHm9M0xoQnztfkrXLZZcczad7Vu8UjeA22r6gkAzE7tgXwfyB6vSRjZ5WneSSjOIwMSGts/
 jlsBiGezybof7f14PghL+144Is+JMAKN59Bf2BhoPNEiNC34MSE4J1XY8m6slRsFNKAUrPE4W+l
 eItmjHvjdEhwwMJymKsOMfmb7c60+sbpJC3NWS0RlA56viQ==
X-Received: by 2002:a05:6a20:7283:b0:3a2:f05a:795e with SMTP id
 adf61e73a8af0-3b307bc9d78mr6490724637.3.1779444774627; 
 Fri, 22 May 2026 03:12:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:7283:b0:3a2:f05a:795e with SMTP id
 adf61e73a8af0-3b307bc9d78mr6490689637.3.1779444774118; 
 Fri, 22 May 2026 03:12:54 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85202b4442sm1143498a12.12.2026.05.22.03.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 03:12:53 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:41:59 +0530
Subject: [PATCH v5 3/5] arm64: dts: qcom: glymur: Add GPU smmu node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-glymur-gpu-dt-v5-3-562c406b210c@oss.qualcomm.com>
References: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
In-Reply-To: <20260522-glymur-gpu-dt-v5-0-562c406b210c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444741; l=2464;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=qFdQhBrAHggcU0GWES+ohMA4WsH2wnpDPMNFqXrANzE=;
 b=yNzqUhOCMXQvxrRtd7kxvs7YMFtzu8GiAVVxvYNsil7K96Pk0pY01/RxIvWewjoljNJUYvNeS
 3lRjHziweCfBb69K8ZhCLsCORtTB/RODIjYmlA7lEj942QbUt4Oh06+
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=Yr8/gYYX c=1 sm=1 tr=0 ts=6a102c27 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: xHs2A0z7692yJwLTpTvkAa_LWNFhknBp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMSBTYWx0ZWRfX23cLGNAIbh+q
 IgE1Xu3ZjJogILy+iRQpC6CwWkPnJdDUvXhBacDKnrbwV/EzRPcYTYpY9XnJrDL0pFiAnpxee7/
 drLSLbd/nlYW/OnPkSdoxiKpIYzEsiyO3k2Q2x5oEBGHuyGmvtuckZwDZ9T5rbaYQtVdpyDiuL+
 7KgIPx3ebLkv2kqFAsME9+xE8JywFzljFU9IvxHEg3mLa2Oq9m4Yvs1RVGN9lcpilS6KjY+Od1k
 2PWd/p6XsBokm3Xz0HNjo/aAXyZndCDSnxKsAV5wNjXwGI59Zx4kTHXGv12eSa24CZSeB3Ag2tX
 F3mNBkUCsNw9VQSTss7ktYreUaoeA2rYoYTgUpB9XqoqXrxebJ23FYBzKhenrvL8MtW3wlg1T1a
 76LoVFnTvK8jWxuuJsTrcZzEbt0tRcn4sA/SMYBmKniWBo0rpJ2o4LU2hG+Wh0vxUuJwasekePp
 7VbR/uuvCWUMAkDOuHg==
X-Proofpoint-GUID: xHs2A0z7692yJwLTpTvkAa_LWNFhknBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220101
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

