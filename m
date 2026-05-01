Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAC8CD3423
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 17:11:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFA6410E53E;
	Fri,  1 May 2026 17:11:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DsAT2e0a";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WVGVyhwF";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A48110E555
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 17:11:10 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641GLkFd498167
 for <dri-devel@lists.freedesktop.org>; Fri, 1 May 2026 17:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qvactydo9LBndlL4M8ALZ02yKT1EFcq++vAUvHqcA6M=; b=DsAT2e0aWUQX4dql
 3CLFX31JDIo9f38d3NbN8QtRZOyr00CBqT232plbrBEKkRaABib/K/mVuK2cfUIj
 uTqAVv0PmjiMhoeUh2MCnrS2mpzE/PgTDtKEWc9cpsBGlb80G3YLkK+GjkO2U0gp
 wWLaivnH3d3+G/P7cO67JCBhWQo4lWRSSy90iMJfrvubdxZodX8gzPIUj+PBV1aB
 rLzfXiJIcIh4YN/hdDbdmYkY3YvMTDQYIvuxk1IMYEX6Ygnys92zj6YCSkvsI7NZ
 AK0jqPt2LvlJkdl7pAZJobW8Zds3WzbYbe9LoCERfyitkMxGycoL2bZawccQTfIu
 Lg4wrw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvchkbcpd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 17:11:09 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c797e31a9b7so2568658a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777655468; x=1778260268;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qvactydo9LBndlL4M8ALZ02yKT1EFcq++vAUvHqcA6M=;
 b=WVGVyhwFS41aF/OjUl6aZ0YbR0oRdlJBP/k53P+mD9Xy0FuW+zr6M+gDXrSK7SUhHs
 buikOckc1mbs9UuhX0fOrVDaTBt9gldsWhqnb+1t3sqzwIRhIrJnkS07iHDxWw54X+hH
 aD3FeBNMqWLmZuTZXD8IrUc06wdaAMwWTwTXBb5LVqnAO55WeeGFZ1qkZWclBIktWiH7
 53FLq27AaQwmZhijmEsUFx1MRSuSZ40KYpARSKlarRtsASHof96bODeDFvEVpdrF0PTb
 40/XfjUK0omKoWArArmhaMCYoXbuOBVKchfHEqbW/L0UvIRegmoWgUYuSNSWAXwQ8T5A
 8KUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777655468; x=1778260268;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qvactydo9LBndlL4M8ALZ02yKT1EFcq++vAUvHqcA6M=;
 b=l1G4/lO6ZMxnCZlU0M6d8ZwwsTRKGRdtQsJjgK+UfD6Gh5f2oFhvNeihWiPIsjPoFZ
 JBTD6Eb/Mx304xyP0NDUiN3qTzG4HFBlwM9a0jcHhMIHucw0ROTAst/W3JWUZy9d3WYn
 80xfwciOyDa69SmeBjCpl7cMrSfLXGuX90taMYHIyEXcU5M5tsmEiMAIz9gfJX07gdPH
 CZMnr54QZWM8r7oXUElmKvEyFKamo4VNK428tbZLf2ePOK1+KYXelLsDfotQoELeAYcq
 jJJbe3gCZJcKTjO9lBzODpVbD0iabJGLHVaz6L79+X/ByBnwdA7FQ26zjSwRr/OcbvcA
 oPiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+x4vAQCef8esx8itnusbKiv9/o11bSCoTefaXYnnR4T+d5zVG+kwar4Lx2kx+RRWUXiOd7AfYoZ5o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTHM6z5LYm/LfM6ebVK1kASILwETCEeMejcw1Q1y8AVC+iWft/
 3FE+ogfzsk+jXqvHaEaFaMf92y1kiOEykKDRv1xdM9LkZ6O8YF7dM7QSIJr9IDdYtpYTR+PsGpn
 quAy1DT5uvLLH+Z5VOHXkAB0GbtmgXe0Mm5GBzhH0qosN8gxrnFWgEUPuIIrBh7vQAr8j4xg=
X-Gm-Gg: AeBDieuLkz2tY9cXgnwO7506RQ3bRhwGpAS6YzvO48aXcYFbqn6ENed1zHVCwtEuJ5t
 o1/xtk23XXs9VoYbsaQSDCGY9NdV7PYnxO0I5JlMPQS5uGmxIK0DhU6IH/2XcttVyb0BNe7A05f
 JhP132ScQvh+mPyDy4eAn2QigC6Gfl3rRSoPiyaiRHT2QwKnSfyttD6kZmWTlIRGH0xH/zum7FX
 6keBL1PE7dLU0BY6tXYIjVv0//IeYAjs/VY+s7o6PGFDOvLDJLbMJLLme1ycmLDeCyEJWGITJaS
 67QTWtPgRTBJSHSvlcW6VVKEou47h9SSG1ogAjlEo8PIZJYzOwiggy0G8ZW+BwZXA4nbbNlaLQd
 3KLPhARruJGXe/cToMTiyBWawufxk19QegRfPY73CxvD5I5SmDM25sKHP
X-Received: by 2002:a05:6a00:a10:b0:82c:247b:ffdc with SMTP id
 d2e1a72fcca58-8352d1fa3f0mr86202b3a.29.1777655468145; 
 Fri, 01 May 2026 10:11:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:a10:b0:82c:247b:ffdc with SMTP id
 d2e1a72fcca58-8352d1fa3f0mr86172b3a.29.1777655467620; 
 Fri, 01 May 2026 10:11:07 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8351587db67sm3099323b3a.13.2026.05.01.10.11.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 10:11:07 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 01 May 2026 22:40:38 +0530
Subject: [PATCH v2 2/4] dt-bindings: arm-smmu: Update the description for
 Glymur GPU SMMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-glymur-gpu-dt-v2-2-2f128b5596bb@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777655447; l=1314;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=AJlLPOqIput4lZvz7Qw7pxDO1mYbGZ42K21QV1AC8DA=;
 b=RQBbUHg7ynwcZIYGXJfF5UjeI27Y9iCGT60Yo3GTy0d0b8UlsVvDPNbblzrR8sySspG5ewvHE
 /W0QN6tlcmmBOI/mEoHoI7ooCg9EDOnjjkJ7y3pda4rg/Tt+k1Tgn5e
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE2OSBTYWx0ZWRfXyrT9ft/ZDEK0
 uMN3lo9AK8uKrk7Spt+uPZjH3xNM4VpogNk+LFqUoPfQZTVrFM5D9j+rnKSao61W8B+WQdqNtUH
 r+byARq6ajJtOVTyr22LfePC7TQkfkT5JQ1Y71CBcjKNt5oaOja/SwSDaMLij0/Mma0zN7fSI8k
 C48Sc6tCavDi0b0VdIbp6ST5I6MOtI4xhwX+QyyPrXFaM1SBklIal8wFQeX78HxSJZ0X3r5tgr/
 48Iz4c9llfg/X5gXErj2BokMO3jGmyqJs+rf89E6vcCl00v62eiW125dRxXF6cV9XT00Nb3G5rD
 EbmJ6i7HOVHxpkT8kuMkDOwvOtnAJxsSz7nN7ge/E9ice1MxpgiUJXGB3qJs3tI0visn2MNNDBz
 woXF4Yk62tx6wQKSp/joDLB+KXfifL5ySe+zAB9Fqa+4Zq2Sww7ZUyzrH7jjrAnrQw8UN7BLf3Z
 b4Gdj+uCHVmHawFRiJw==
X-Authority-Analysis: v=2.4 cv=Zdkt8MVA c=1 sm=1 tr=0 ts=69f4dead cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=BshQC2s5e-qBobt13pcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: epYDIeJbPS5ws8zTtrKSAO162Of2r-Bh
X-Proofpoint-GUID: epYDIeJbPS5ws8zTtrKSAO162Of2r-Bh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0
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

Add the interconnects property to the common SMMU properties and extend
the sm8750 clock description section to also cover Glymur since it uses
the same single "hlos" vote clock.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 06fb5c8e7547cb7a92823adc2772b94f747376a6..df67ab2aa715f81f5a10678b936558827c105bd9 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -243,6 +243,9 @@ properties:
     minItems: 1
     maxItems: 3
 
+  interconnects:
+    maxItems: 1
+
   nvidia,memory-controller:
     description: |
       A phandle to the memory controller on NVIDIA Tegra186 and later SoCs.
@@ -566,7 +569,9 @@ allOf:
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

