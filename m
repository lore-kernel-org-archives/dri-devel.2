Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690ADCD5BAC
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 10:12:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0CBC10F536;
	Fri, 22 May 2026 10:12:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BaHp0and";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JxKu1Hq0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3159410F53D
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:12:48 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M68WXj777114
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cokVwtObejHhNsT8CGzVLLo/zm8OUnIjAi9EaYJJAFE=; b=BaHp0and/uMoE7DS
 h5Sz57ZRPv0MyxT1qtrLFJF2OQQtbuHLeiyLzQU3sA8IHq1UVGvc6rXcdreUU+UT
 PAvSZM4zm+jOFT4WRJHe+UP3IjkTMwSfyyLeGvZux4Nn890yHF3zuwfufuOc6CTm
 gzqsZTvd39NxbrZjHvBV0S9XtKJp4x5F7R5aXn8Cv8aaVgUyZQV/SJq2FFkQBjjC
 yOcWhr4IsiXpTLVoSPEchgFBsaXWBQetjs0QQF1p7AI3z3305IY0jkvWjHVtiBpj
 rYL2rmFU7bo4bOrvjA2pb/tX3ysXfjiqjiYlWnW/fkj7hKWIaRADjGG8peid1swE
 dEf4WA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ea94h309r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:12:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-367bb9caa54so6441373a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 03:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779444766; x=1780049566;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cokVwtObejHhNsT8CGzVLLo/zm8OUnIjAi9EaYJJAFE=;
 b=JxKu1Hq07ebcmEvUAj2vw4MXXKb/VTBp+23zL3lcUqmYko66RsOKLF929nwRKFqUxw
 4tbDfEPEnT3445+WXef2MVF7H9RBOvnN14s1VS/IJ3fuSMw4PIwKmbi1OHZSIPinG59+
 ZlEUxeWMrCxqaILfIWt3NVp2KvqifZKIKwm54IeApUr3P/zFTw1++dAkz9O7j+h6aQ6g
 IVRk0epBWf3WWqYbhjTGhXkb8jYnJd11mR19x+NDLRIJ3dW0qn24zgHKRnWGDF8Rv7fq
 EF1Gc5P8jouZuFDfdkWHcpGEhfk3WHtHF5DRP7pCKKtm8KJoYl03x8O3usRjy4wcnj1G
 guwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779444766; x=1780049566;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cokVwtObejHhNsT8CGzVLLo/zm8OUnIjAi9EaYJJAFE=;
 b=mGetVtsN5i9MWgf6sgScVRB7zfXMHlPSQP+Ug3rvROzMrzEU17h2fSTN4F4nxpZcie
 W160Yx6jYNom6dKXBT0nf+orybRmrMI8duDoGjqutqUPpQaxhQAx4cRoQrWVWkZQ1/lI
 3VSYYd+0dct6ck8AydHJZIoKbbOt/mZbjlua8HYXF6xX1cAi49+eR4nbSHy7Ujmcd2sX
 E78QgSyVUSz8WDjQcl2QtiKRuVT7IuJrC0Iucb5av2L6gwEf/c6STU0ygwFKGSS8vOTn
 Km8WwIqP3s+m5biDz7a6+4t9bWZauj1fcFcj3ztwRwku6YUSiblZ13T1BL8tMBKgD/V/
 cxUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CIj4XyEH0RNCC/UAI/nprlPIxUsk7PbgLYUUZf+NkJxTW6dTHdJarMUkuJQwfDir19kRYIsZjDq0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFoGU/Nd8hT18SrmNtBvUDz0kaFCXJ0BETS9z9+qNxJy3pPJW/
 tgf4pBMzpJp+vKFyr3r1xztyV8pt4lqMRVNDHzjA0vgxw08XQTdZBtlQgFnIeJqnvmXfuHD0DLB
 ScaoJNlA3tfqdqbG49eeFMpLASHn2JoN8pzuBHCSJKmgpAQpnXQbkVzcTeyWs9XT4iu+yX5A=
X-Gm-Gg: Acq92OE2WVT8HSrAOP4WU9sSIYfhqX6I9jXtJvjdlb84F8wt7D1fPy4sV+LhAGffltn
 /VcXnDgWCY/W7+Jh5sNxyhyrRH6Jo+xw9scpySEQG45XXyWWwjJ2v3pcla0zZt3SrAVmenpp1VI
 VVhGrlyVI8XwW3RySXK18XrAMAwMX/veKX1zjnkUSb0TsC66rfR5eq5a7CclfeU2dmhadCbzhr2
 MFshvL7CvsocevYRCbG+1dzzE26klP1W0xJwUbRMjpeTX+GxXJ5aQV5xmnlk9bf3HIX9YBHTTl7
 ScgdiwU90HM8M/ZnjiI9i9f4BQSfnOC0sGVANqpr+xBXxdIJ5EbYiRXo+q05o+HfYKOXG0fEI7D
 FDFB4yKHigCoUf70+S7wY0dYTJUqq/gJpgQnZEVYlS2R7hQ==
X-Received: by 2002:a17:90b:23c5:b0:36a:7c8f:13c4 with SMTP id
 98e67ed59e1d1-36a7c8f15c0mr757077a91.20.1779444766095; 
 Fri, 22 May 2026 03:12:46 -0700 (PDT)
X-Received: by 2002:a17:90b:23c5:b0:36a:7c8f:13c4 with SMTP id
 98e67ed59e1d1-36a7c8f15c0mr757065a91.20.1779444765611; 
 Fri, 22 May 2026 03:12:45 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85202b4442sm1143498a12.12.2026.05.22.03.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 03:12:45 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 22 May 2026 15:41:58 +0530
Subject: [PATCH v5 2/5] dt-bindings: display/msm: gpu: Document Adreno X2-185
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-glymur-gpu-dt-v5-2-562c406b210c@oss.qualcomm.com>
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
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779444741; l=1562;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=VXyPjRyCvwokK/qdzZThuxToG/yvYiuIOD5L6w36bck=;
 b=hHmHtgDv/8JAzGDQHpoxO18rVqZunMZq4oxl0d3cCR+bDPnORL1fE/cpw/Xw180Vyv/75m9Dn
 jdLWruQY/RFAIr2sYPUchNZDz0KAyA6VsVna6zODm5Hqhh57SNm7AZb
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: GqfjUtKUQftsVN51JbtKqyPpzrJAhkBf
X-Authority-Analysis: v=2.4 cv=QblWeMbv c=1 sm=1 tr=0 ts=6a102c1f cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=aapufVXKjK5bSyzaIfAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: GqfjUtKUQftsVN51JbtKqyPpzrJAhkBf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDEwMSBTYWx0ZWRfX9tbwC3fo0t7A
 vNktIC4Yg17WHDW28ldJN6mHY1/nS7MXvC0vVq6OQLUw/1RFRlMji9BViDVnaD21x4loiRjhuQ2
 Ab52vd8j7Yw9+wBnqiNb+bxtQlLtvNYswBjGlVJHiG2yVA8UW4dT10hz8ljmAMrMdm6dRNA3RpU
 D23bOSTJrqssvHlUs2EZQ9j7EAxEcd+CeORkzo93RzULUGHvQSa+gq4M7W+dNB/A4x5cdiPjhpz
 393nW+I3+n5FzEVYw488gxkvBMH60Xzd2tCLiCE9adixH11dqkP/L/+eQvfWCSLyYvMNKfnb4eo
 qPzXGH0DWrR0NB6ew70QbqxD7K/0ePrXstLIT2F0YlnqsGr9cHzTODd2FahFSLVNw7AxVEEE/Wp
 REE2ITNhTbV73BWgtJHBZ1mPINW0CK8rneAd797PQJW1vWntTaKARKiENohC/hapTa6BElKxxpK
 yV2ha2/uuFbKcjPCdew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220101
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

Adreno X2-185 GPU found in Glymur chipsets belongs to the A8x family.
It features a new slice architecture with 4 slices, significantly higher
bandwidth throughput compared to mobile counterparts, raytracing support,
and the highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among
other improvements. Update the dt bindings documentation to describe this
GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 04b2328903ca..77caacd0fb3f 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -411,6 +411,21 @@ allOf:
         - clocks
         - clock-names
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-44070001
+    then:
+      properties:
+        reg:
+          minItems: 2
+          maxItems: 2
+
+        reg-names:
+          minItems: 2
+          maxItems: 2
+
   - if:
       properties:
         compatible:
@@ -434,6 +449,7 @@ allOf:
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
+              - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node
       properties:

-- 
2.51.0

