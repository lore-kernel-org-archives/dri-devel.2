Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BB1CD4F21
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:22:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88A5010EC0E;
	Tue, 12 May 2026 19:22:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mJakw1D6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="axk9kgO+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1576E10EC0B
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:22:07 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CDgXWW680346
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6K3yheIQTvNblsixGApswikdFYlZRnnf5XfM5ye4b6k=; b=mJakw1D6cVqieOmn
 f10Zv4ujgl/+bv8kijme+B507ip9cG5AQPru7SOfLm5m1mCzkjPRn/Zb9GskcdXW
 H/xmhPBw1TJ/925r2vDYSj1si4leuJm5zSAElbXAnBqsSxK/lCLpzlWIyQfkmRjl
 3v+XgfDYF3m4SFkTQLbDdEHavpFc415EpCk3IRfpaCVaUR+U7Ottq2v90qtT5h+E
 5K7farLe5Z0XEh4OAo3EXQbhg/rxjWXqBCU0RyMtYyTaSbyV/26JxALHR6mjkpEd
 mBn2v/G/JRgRU2pitgagSaMIn7wg6cBw4o+m5Du9/q71FgTOwJpplMzqCLWIV//H
 ZVakRw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e45avhd2x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:22:06 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2bd1dbcccf6so9002805ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778613725; x=1779218525;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6K3yheIQTvNblsixGApswikdFYlZRnnf5XfM5ye4b6k=;
 b=axk9kgO+sJ0rA3mvJXa2LIuadW195YPm9bTFI88yOgqHhjWYVo3bbCihGLs1ZM6Je2
 Ll+HY8mVvYN6Ejvfy9UGWRBCLrAQDpILVBIN5dfjIIgDQZloeh0f2QJeDQSow/aOQTbb
 beRm9Ai3FcG/JoHoFsENxLON3iggHj3KiSyXkoPJwKp30RW0GXT/SrGX9iE4a3ARD9jm
 FWfPIlTxbe6uCLdP2IlUahcZ2UqpYsTIZSl5wpXSCdCMzH/1qLaAExfl/Io+Bg7pAlGH
 J0z3xyQ+3sg8j3jbphB5sz08BpSpEYMFjr/2Dyp33pOiz/V1rbatDtzXNA4HbxtJhRSM
 5DLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778613725; x=1779218525;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6K3yheIQTvNblsixGApswikdFYlZRnnf5XfM5ye4b6k=;
 b=HsftvpO224bM/cy0fUsZ3rJ2xyaJKR5PbZ/o8Uj4UdT5Vm+62PRAbEY9DtHvDJtqKw
 7VAIESh6rmTlB5Q9WODBZj1enhK3p1axRy+4VvnRz70GhbVCbNUpvX3buhkqQMGs3kui
 r/3Msv2i+8AeG3nrIo9cLKcAgv83bBeBwOsJR0SvGeDrveqv7nTFR4UAtBGlcnzZRnxO
 mRlI/rJ2EDQsvvB1XEthwmm0ML4gEndA6yinoCgkeVg+Z4PseNhwXALxeVKt60FwNHpi
 9xGIuVUrR8wcFCHd5FB58pznJ6INbSc/sjlv5Hq7yhLxPpUuQYjQ+RHV8qXExu58tUtX
 dV8g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9adzummdN9+4/62klvvg1wiyQxUvZ3A3sggognuhJmARzF9OZFgb/I2Y5Fpi5dW36NgyxdMsZ5J0M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypetFaYC+q1YUIi8TggJVNRFjumt4IqdxxQ/bIRAUKzljB0sHD
 WWgH5hhm6xyWjnE+AACtRNWcgyBEwQWrEXR6SKE9zDNdxgWN2gJPNh3s/Vzwnu5WBDq5R1lQQly
 nqFTN8ThNVepCpDOQP/VdBGKERV/sKPidl4Wqaa5GmuGmMakClCpKHVrzvsRsGr1Ro1ZHyLA=
X-Gm-Gg: Acq92OHE7bo0viORPCwO48niuw/jTINuMdJ2m6IsmiHYUc3ibC57TQi9sgFJxnKqo7l
 rsDS6vvSTlnceKouKyUHEFGQULiK/m3bde2rxM403pCMtJh1zytXdDsFxUaNCexz1PHWSo0hAlb
 CYRXn3PdQtzSu4FFpu3smQP+bt6Kkrk6D79ROH6QVaAlouFjlUY+IrnCi2ahGZw3XW+EuzPsz4m
 FWB2mKg2UNJUoUuUyp4dEBOSx38HpfD0pBDYl+VFVstzI4wKvJmLDvlc6DpITh4Wej8lyLZFfrf
 flzUTZ/ZqpSJ0d1PLrCT0bqfYdLFEFZlJOWUVoLar+UDd1NZy0V0Kl96NSVwk1g722inBLlVwcy
 EIcZFfmdK+1LwEHy1VKvJ+y74sJDukWOGzHWj75fKovU7hQ==
X-Received: by 2002:a17:902:70c8:b0:2ba:df8c:11d3 with SMTP id
 d9443c01a7336-2bd275d00a3mr2773185ad.32.1778613725153; 
 Tue, 12 May 2026 12:22:05 -0700 (PDT)
X-Received: by 2002:a17:902:70c8:b0:2ba:df8c:11d3 with SMTP id
 d9443c01a7336-2bd275d00a3mr2772965ad.32.1778613724679; 
 Tue, 12 May 2026 12:22:04 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ead90asm141250585ad.72.2026.05.12.12.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:22:04 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 13 May 2026 00:51:19 +0530
Subject: [PATCH v4 2/6] dt-bindings: display/msm: gpu: Document Adreno X2-185
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-glymur-gpu-dt-v4-2-f83832c3bc9a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778613699; l=1607;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Mpr6Q33aJKvJH4hPu7N8/Msc5ivh6tKB28dTURNeqko=;
 b=Gx9R8cnM6dmWa7xP8HG35i9llcmnCvT54E/MmvyhWf9dgg+yrc2NmmfCLxs6WzuV6JSZJdKkD
 rwYBNyfDpaABoe22B55Lf5pwSwQzUZVwZXKhfFNU6SBGUwmDH0uqd6A
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: UKl3pfSB6_2J4T_aydg3aEg6LKNlHIou
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwMCBTYWx0ZWRfX3/1rDmE5SGSC
 z0qQX5Zt54h5jBU+WucAxvhtkp+jESr5UYM3GhTu16DPjnbPrWfT6oSGKTbvEEfWzRAT9Ypb4F8
 cGcNfeP4zLn09jMyNStaNFRzxIpSy7Ay0LtaZlkqhFfoFveOFLAO4gMd/FfEP3swQk+FyUugxT9
 ru75c2zMZyJRF9A/7mxsOLn4FbLihEQ3su6Sjr4uRcoFan0fDqlnFreCGMzsPX7OTiCEXoA6+EK
 HfOW8TBKbI8Ai9UNW9QRI+st2akOORV8X+t2MbirWn43rW6kz+VkURwgLJzGfp3J/FUtAhQUvZT
 s7Xq2Dw/brDCo0Cc/jkHkE4Jc0w+uxlR+ieXGwBqyshIKLmEbhlcrhobxH+323W2IpcAz/XGcf3
 Gx9a3njp49zTvV9sEg1sktQK2fEIbk7uo40ueNLBVsI7YGQ0h0wUHSeYuw7A7YCcwZE5KipGfPN
 H7JfTY+oQLQJDZF4UBg==
X-Authority-Analysis: v=2.4 cv=bOwm5v+Z c=1 sm=1 tr=0 ts=6a037dde cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=aapufVXKjK5bSyzaIfAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: UKl3pfSB6_2J4T_aydg3aEg6LKNlHIou
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
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

Adreno X2-185 GPU found in Glymur chipsets belongs to the A8x family.
It features a new slice architecture with 4 slices, significantly higher
bandwidth throughput compared to mobile counterparts, raytracing support,
and the highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among
other improvements. Update the dt bindings documentation to describe this
GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/gpu.yaml | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 04b2328903ca..e67cd708dda2 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -411,6 +411,22 @@ allOf:
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
+          items:
+            - const: kgsl_3d0_reg_memory
+            - const: cx_mem
+
   - if:
       properties:
         compatible:
@@ -434,6 +450,7 @@ allOf:
               - qcom,adreno-43050a01
               - qcom,adreno-43050c01
               - qcom,adreno-43051401
+              - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node
       properties:

-- 
2.51.0

