Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A445CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 17:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B5110E560;
	Fri,  1 May 2026 17:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a8NI18EE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PCxJiYp6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E07010E557
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 17:11:17 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641GLTGa3938660
 for <dri-devel@lists.freedesktop.org>; Fri, 1 May 2026 17:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2zubOAZ/8a7yYkuEZ+V2cJH7d90bVGw6nym4GQ0WP6c=; b=a8NI18EEpnJ894ee
 shfHP/ToapzWfmjrVI5QEfPZ1EqgBDx1bszRS6Q14I5r1UIVslVm2U+yfFCUQ9C2
 mMFJ5a+2cvb/9P9GNsXgD7zAEfqPCYwEQf21TRQOcbutXYgp/CEZt1aF3gA1gE/P
 W1yLTEhoQRk7FcZrkSTzl7fKudiHuWoz9Ylw1qnkJ19tFVhlzAVJ4V60Upc+qJJT
 5D6fJjeM+zFj2cysc1Hq1/twbCIeLftKnf17hzTwGQa6Iwc4Ubo8VOvKP2OkKzwz
 ztY4jGIndfl5zKXuf7Kw2A85AvfZBhcVP2wNg0q6mdK/0M1PPMUyQ4LJ/Po93ia4
 ifaXUw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvtrn13a3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 17:11:16 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82fa6c3a77cso1548322b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777655475; x=1778260275;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2zubOAZ/8a7yYkuEZ+V2cJH7d90bVGw6nym4GQ0WP6c=;
 b=PCxJiYp6dF0LziMszc6ogirK12Rb10F5M/Rb0qwYebX+Fc04CaCV7xjM7VSpTHO6Nj
 wxGwSX3xSFst9R9/Fd893wLduWuWA6QH2ooqTz42sYHYSmP7EJ6KovT3ycFucoSZ7RBK
 /1ZzmQ9EvpHsF2QmzePHOqbNksxtTsX206ViUayU70sE6wnvTZxie1bfVYQUQb0kUX/N
 UJW2m3e46xkaxBhvnaT95cpd6swnHIDaK59N8mGKpn0oVdKxGmpvN43xDrgvm/J8Lxpq
 A51HLk3q6HTID8Ei5IzEQfYnjgVkMvSPDgjoKv/GdmdqU2vi6TbBaScgiy1OxYtXef85
 UoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777655475; x=1778260275;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2zubOAZ/8a7yYkuEZ+V2cJH7d90bVGw6nym4GQ0WP6c=;
 b=DrR+bXE7zHaCMrCpbzVe1ts/azBOiodFHfKSft2AXdn3SB9RwFulABAzkZJGUHVWIN
 vdP48fPTztV2foDeSMhFSGPlGmFJ5tMogvh3JBa0ziX1ubQsMkFPVhJNFIaNzdff3JHN
 R4VI7nnqpzGhwVsg52HiOeWIl4hA02IQaxu3my7fLfYLZRZXOxPJ8Kp3s3cI4c+sAvg+
 8NyzcMmUU58QlMAv2G5d0jCVuwev/mWjpJR1x5BfYUYkdw0i9zpzWmqkIfdwQRHdvkpC
 nhU3z5aB1qS7y6TtiIhqhhE+gHkaXJB623BmiUe4hFe6MUebB5BrrHFcvDV+mCJnQYSM
 XZow==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Okl46dDeVHfWI5DE2ZIBkYuxOjyUHgPpQPo/xBfVYP2Y3n1J/Yh0jgO4roU1ZvDzz67Kgw9Iavug=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZR89VsCoztBd6zW8ig50KBDp9JNVv6RSEOUNFmjOD7ybLgonQ
 NwINSytxq5SDCreqJW57QJXHIxiF/nxG2jW0ETiyyc7wZMzJ9Lcd4SNGKciJspxL5bP8JDPxRnS
 y3EhjYH4S4lY2JVv4e+ZFkmV4YSHK1qp85fDsh3SnQnahIK4JUQXNjJvUCC4z/6IIW6G34sY=
X-Gm-Gg: AeBDiesOuTq4TNUCzzEDdPy4a619ZwO1bNXPscFM6NrEl8E6m0BDv48+D8YAIlYOagt
 /eJVMjY1APxOOQxeC6F5zwVQFg4xW8CDsinRP+VIYy6m+Q5A6epcq54kJ44LEf0tHCIZjL9b0f8
 lTf11Btyqc708V1/CK3mPPSMzeTBBv9Hk5fRlR9J3A6WQFJvdZny/gP9msaXasylGOP/BkqsW+s
 mgNlc79uIQ9jUXH/HRyKi9js3he9NZ4+biu+tgTSgg+K+8mgXloh67cduyEZjYPIrKGMpjieZO7
 CjcLzEb0dMfcT31HBvRUlTj5IG+z37oJ/3oMqe4vFHe4LSkwRBjc220atEbu6oA6tK4YSuLKBXa
 d3b/d4eXqAZuENMz9MSBcQR9U17Dn+rqLA9zPa47PEr1QPOB26DThtnUS
X-Received: by 2002:a05:6a00:ab89:b0:82c:9cd2:fee5 with SMTP id
 d2e1a72fcca58-8352d02559amr100711b3a.7.1777655475258; 
 Fri, 01 May 2026 10:11:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:ab89:b0:82c:9cd2:fee5 with SMTP id
 d2e1a72fcca58-8352d02559amr100674b3a.7.1777655474748; 
 Fri, 01 May 2026 10:11:14 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8351587db67sm3099323b3a.13.2026.05.01.10.11.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 10:11:14 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 01 May 2026 22:40:39 +0530
Subject: [PATCH v2 3/4] arm64: dts: qcom: glymur: Add GPU smmu node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-glymur-gpu-dt-v2-3-2f128b5596bb@oss.qualcomm.com>
References: <20260501-glymur-gpu-dt-v2-0-2f128b5596bb@oss.qualcomm.com>
In-Reply-To: <20260501-glymur-gpu-dt-v2-0-2f128b5596bb@oss.qualcomm.com>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777655447; l=2636;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=QkffR+QOr2z/kbtj5GbV5Aa+e4MwVgVJAmCOoCw+1uU=;
 b=0ae7cQ5RUVZpl8ozfmKx1kS9wwVDMWR3kxd5O+U/8V2HPOd8vSqHCtFqv6UYcFaWA+7lc4Zw0
 jUpmOWwcfLJCFm5ZE+zJeIndSp652eK4q5Qqcno/JxAHbp/E71ncT5A
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: lsB88YUopMopuWdI0vMXMlasTQT18Jw1
X-Proofpoint-GUID: lsB88YUopMopuWdI0vMXMlasTQT18Jw1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE2OSBTYWx0ZWRfX43uzTIV/3b5R
 6HDaUD6dG4/gcE5+OR2kVkxC6KilKvP0uYzAM2ozP9kwqlNnQjqZe6PIAazh37ZLJgcOuCdYIcQ
 mrPIC+d3jr5Hfn5w/k6VLOG4WdhMyc3frHMq29nTqCqwM29CTFsD8x4/ocxENiO12locGlTa0Q7
 inUjU2kyNvVlo887CqaT7lN5LaEAKzW9fikGm2mQQU69DbOD127PKPkTEKO0lcix7KTqlPLfs0p
 7IuImJ1ze0pEyljiQhFAKJlUJP/6Z1lYJyjA1Nu2Lum2YDhAsQsH6oJdcFuqNToY4AkZ7d1fKgi
 EBT9XIL2ej50iCo7MzSFa5de//VpAj8VdSUD+8RL+migBa3P/3YzhRBeaxTQ1W8sOvQTjF0RRli
 VEy/jbJ6kKjZRvA4pjIsPicIpR4AnjA7X85lc30QJ491J04nvYjUS5tn2lVML937uw+aKprQRdx
 /3zZpG6l3p6bYsJ6yDA==
X-Authority-Analysis: v=2.4 cv=KrZ9H2WN c=1 sm=1 tr=0 ts=69f4deb4 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010169
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
 arch/arm64/boot/dts/qcom/glymur.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/glymur.dtsi b/arch/arm64/boot/dts/qcom/glymur.dtsi
index ed9aac42fcbf3684773ae449ecbea4ca679691a5..93afc81698cb64232ac6b61754fc6f4c923e30c8 100644
--- a/arch/arm64/boot/dts/qcom/glymur.dtsi
+++ b/arch/arm64/boot/dts/qcom/glymur.dtsi
@@ -3729,6 +3729,46 @@ gpucc: clock-controller@3d90000 {
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

