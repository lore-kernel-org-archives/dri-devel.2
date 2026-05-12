Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71B8CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2591710E2B8;
	Tue, 12 May 2026 19:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bZf97tOG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b3h+nug/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F302E10E2B8
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:22:14 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CIs12a1058398
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 18vX5BO6Ky0YjuphCfCL/g3VnD5eR3Y2KIwiC9kySjg=; b=bZf97tOGRyEE0oAa
 X1dFXhFPupPx5Xm+inIKhxZ2AiqxWkHeS3+pjkttLQS15PaqkD5NmqcV2K2tR07N
 4xCiGKoA6xW1w86ZsMG525PPYHIItjicOThVekEdKdqPy0zEaiQ3S89smuSr1uOG
 rNVXKZ7ZK++HTwhp12GsF0/9i9LJNI6eJ2rxCzr9JXo8WnsWOqfufrLFkdnmq0Gb
 jngW+Mz2QY5+/MQ5PVFfiqcHcUx53CiEUMIGX1GJ0kgnwvyoiV0QN1UNGClXk4tu
 l1PU8Qv3drmHmnwdRAPW5j4OpkAa0qbhMiXtbPmEsYngFrAGULKrdZ/C1XhQvifd
 /HTjCA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e49vx830n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:22:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2babc42244aso111455115ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778613733; x=1779218533;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=18vX5BO6Ky0YjuphCfCL/g3VnD5eR3Y2KIwiC9kySjg=;
 b=b3h+nug/J0c7YBYIOZIcCA1c8XKybN+VXHqZ/JD8arnBPXKGhzldljK1zLUePt3req
 vTdEBJ+0gLOpLpfKfFU7n+1QU8Sdr5xfG4Vf6dvcGbCNZghiZ6KXSLPiPqkmIfijE70r
 70kClO+0dmvdBhLubFs0x2zafy8ouiBmprN/kdwMSrfWbuyJJhEhJyypq9oPvqI/Z4t2
 FWUnJpN90Z2vuCog/amtmUjLM4zNE6HmcY9nrOXMoVWmMhYUcdA6V2cyGhYAQ1oc5ltI
 ZZHr5eMQ0Dz8FSUYulICOSriIKaEJNRpfO+iN8HBbNmoU4p7cFoh0IMtZSb2sbIS9Dqs
 39/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778613733; x=1779218533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=18vX5BO6Ky0YjuphCfCL/g3VnD5eR3Y2KIwiC9kySjg=;
 b=CuEOfjQBi3ZF84EXQUcYvpP12dTckOStm2o4jiS6oGSi6WU6d5ZONTKxmXCgtvpzaw
 eHytSBw++1uRacou8Mq3vzQ0wCAMDyyjPuQBz2kBR3uydVVGdr2rJJGr0dkj1Hh99C/2
 rKUQmuMPBA+oaRXKla1wrrhiIfsqRwn8tdz/byvK+X2mJVrZKcqA9dsxWGiRFCfhf90P
 42c9g33CUiATZouTzNUFnIufQ/HmchvN6Kzas0f2e41h58nOhq0eiCucDSxKSakyrXNW
 5/gfuu7Irym+FXeYqKcV1mFksaHwHpIh9BXhY1BsyqdFL5hCAvgGK2mgLXaIJfOSC3ji
 6dUA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/o4dkIOsHoBd+AnYRsxWC0LAStZAd32csUADIZOOVHYNevxyzdlGrg+MPgxUBfavRyDeQBmX8nWyk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaSe6o6uY1PJLjvjwJxJVbXYHxFuQT0LMm9hQANc0GfjCmJhCR
 WJn1FIoGBYFaDtWgef2g/g2cXIrei1j39WGmv43gzcxU3J0hwR4qS435jFw2Hw3Hna0gMWmkN2B
 u55VDDvDZWR6AvPtkSvLVf6yPfyjbElubn0z+8EEjQAHjAtTSU83vREBZp7PCTUZbn4JbaAc=
X-Gm-Gg: Acq92OHxWVJbArWjj7oet3jnVqIGFGcha4Cw+6ox6stKOGFFqxoakyr0m4L3asMTzmX
 pB8b8AoCVFCDFvPW3IVQMIa6/OnzJG+JGZeVYm0w0KwQL08Rpd8JdKNdC3HhHiwXla2Z5t3g/5Z
 8odQB+jkQiyMiA5D46CsjFtqRkmgTwXtOPS/jhOabGUZXHeyCViooHJ/5oPD3MPqKIliuqDy/wr
 xzBrCyjAUe442KmEpV/SxtObghN/Q5RgQVFaTtzC+jR3fAotcvephEv1g5X2INWwxQexLWxVfzV
 L4HsGBZ86YbJd8D5CV20IMVHnIgIEbtyhS52zn5c05Sgy46z0WeCKO1LyBqTDYK32om/zCl2eD1
 UvDY590bDa7djN6W+5k3O5ketu25+VN9hs8L8aZ2FvK7NBw==
X-Received: by 2002:a17:903:8c6:b0:2bd:907:2cf0 with SMTP id
 d9443c01a7336-2bd276f20f8mr3596465ad.32.1778613733144; 
 Tue, 12 May 2026 12:22:13 -0700 (PDT)
X-Received: by 2002:a17:903:8c6:b0:2bd:907:2cf0 with SMTP id
 d9443c01a7336-2bd276f20f8mr3596105ad.32.1778613732663; 
 Tue, 12 May 2026 12:22:12 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ead90asm141250585ad.72.2026.05.12.12.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:22:12 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 00:51:20 +0530
Subject: [PATCH v4 3/6] dt-bindings: arm-smmu: Update the description for
 Glymur GPU SMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-glymur-gpu-dt-v4-3-f83832c3bc9a@oss.qualcomm.com>
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
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778613699; l=1014;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=+Y9gYZSkWF93iB7//ohDWKNnMjwm/WhLykXaB9JYn4Q=;
 b=sJd52zbNvhJgb1ND3wewPjtymBQO1zHcJeff4xbFhYmqzmdH1ZAPEn/CEg3GbkRyuYyQW/n63
 GG493bLcmq7BWjLKyNq7Z7xbAwWo7HUq3kgm0UbPs89yZspZIMONxfz
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: KBPExxXiEJMblrMHFwsj96Cdr4T9sfIQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwMCBTYWx0ZWRfX24I1E49GwBUF
 +bJbXiexsj8+oWeO+An534Agrdq3PgwkgfplVpO74lxZxHzinuhxVFtocP2bxbz/R6h/OK9VLgH
 DiiiKduJpPMy9T37ZL7fTkwKFgE/UKKLSXvR0osfisxSDmXLc9+d3NIe/ucYMkJC8QVUJ85mOH8
 r0kCpBo4Wp1RAGCjNliTII/3UclwXnwG+a2o2nXrAVwN9gUevdC/amcIJ7L7FfW141+Wj7BlX4j
 4SJJLzt5rK/vXFuQsi5Tb1a6FYssDojJANzY7R2cnhV2nfg0PftYWzu6rTfX9eH9TMUSDCCyFfp
 jiWuZRC6MnQsYEMXV7mb+1bu3kqDJSLMZxTv2O4DAmyaopWNq+fjtCP0nMZVyT++TaanMX13bes
 XrMYU4CzCtAVorcIY2K+nHobPLppB/C3xr3u0b6hCawT4Vaxel6uS3q5CA7Q4QCga2I6sHN6zU5
 k3FkRM5OVkZd6+/nGyg==
X-Proofpoint-GUID: KBPExxXiEJMblrMHFwsj96Cdr4T9sfIQ
X-Authority-Analysis: v=2.4 cv=A8Fc+aWG c=1 sm=1 tr=0 ts=6a037de6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=RQVZ3Ks9ONUmwc3llXAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
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

Add the interconnects property to the common SMMU properties and extend
the sm8750 clock description section to also cover Glymur since it uses
the same single "hlos" vote clock.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547..b811ece722c9 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -566,7 +566,9 @@ allOf:
       properties:
         compatible:
           items:
-            - const: qcom,sm8750-smmu-500
+            - enum:
+                - qcom,glymur-smmu-500
+                - qcom,sm8750-smmu-500
             - const: qcom,adreno-smmu
             - const: qcom,smmu-500
             - const: arm,mmu-500

-- 
2.51.0

