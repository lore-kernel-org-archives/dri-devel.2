Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFB5C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9283F10EFB2;
	Wed, 23 Sep 2026 10:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Trx4Xl6U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LJ3+iB0m";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B679E10EFB2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:34 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA2s3w2951639
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1NuOH1NXcB2AiI/hLtOWQM1XgjcXBrhm8FLEPIqXD8M=; b=Trx4Xl6UZKDhwbvB
 eChrg8GkrK1mFLFBmIrEvDMVX0t8RTkR21kvIGY8qvKVyur/LyYRza4GDeDo2rvb
 KRVf4mb7VSOkjrdSOZVcjb7jpUztFUTGNn6Me+1/JYoKR7LbWvDOtdrvFGTRycsF
 eoZS4vzTGk7nAx6OgeEbho/96E44Uuk+Yh/X6rm5tpMajQtGh9XVqyL1zEp7Olr/
 BiU+ttXtpvcnSJO5KLXYmIWHpwDC3aZtr/mRZq7SN97/Nn2EIfDvuIs6hbx28oZY
 XT8bF3H5wRFYhwraK7Qh6enTlhhC/5dR3hQV1yV1NoEksWGRt6HhiLnzpcGP4Aor
 06ChCg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gv32qtbnx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so1310346eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159253; x=1790764053;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1NuOH1NXcB2AiI/hLtOWQM1XgjcXBrhm8FLEPIqXD8M=;
 b=LJ3+iB0mME1B4kXtliskq1T2BQnfxkHxaTgDqPqkLo/wUCDS1e0VUv/NkY8Wxw0Cam
 WkM8/36o/rEYsi8v7F48CgmTurC1t3RzbFjAxdVWmm+LBjHOoNMz499QAN0C4US0O3gT
 eLrOngoLj+5dO18yUuXiP1LOUNwiLn14OAnOYfyOQipnAf0L6Z/0eDFupF165XLVCCkN
 pY0GD0+yqjH9xCoI81lYHFY1w+jK421H3w0HELMAGeOyrM8LYiT3SWQMZ7Fuu7GVag5+
 JpHNkvgBZlRshcOIBc93/EOYCT1gHdT4DAO1ghux49FYQkAX7+jR7pdy82vM9TD3HmA9
 p+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159253; x=1790764053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1NuOH1NXcB2AiI/hLtOWQM1XgjcXBrhm8FLEPIqXD8M=;
 b=wjysf9PJ9z2YQfkjKZ6ir2x/FpdQOVADR+2eSf56OT7qQyuGxT+xzY+Hl8P+dArx4p
 t0Q6WDyd0W2plJR+fHAyA0pwWZ0nUBwl9DF6xiAONXCkyIp+g29JWuDwWHV/mmUtdvg/
 ZImqVH/M4uTTmURsfZm6DdGFixueo8IxITxNjHvAtNca77/5c70W2E478gBPJkjEok4F
 KTJlWruKJX4vFUB9vaLy9VKNvFlLWLJY3Lx8x22kXsCf08RGjDJyBdlmTz+AUGroyDQz
 k6QhUxHKEaIaRBf3KeFKd9oSKcKfsVUVfHTckI7EgHsvZteTO0/Ow3euVJnQfAFjOhoI
 Kziw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+TSS7EcYHHm38MYa3itvO1kW7vy278+f/ljzhD1E1QtGogzTnHkh11wYA+EOl0kT34GKHdEYvQf8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQmeN4bDJP5XDyFPmAroC3DZgZp+xnjtMuxHVNlspSbWOq6kjU
 S8pjQ7727Vqlw87ezyye3oYPmtEwoKYNKiWFJqzpLELQcqeMqWRpm4RkGZAt6VeumpaIxAUYma3
 n1KhJPttZ6YqvhisFagmhJdtvg2qdQd2ElnVLQ47oWx8kACDNmYRXv1GyhWY7LNYGP/xkx4I=
X-Gm-Gg: AYBFou3+3f+jaxogGDG2o+sIlu/ZKgOcT9lxOgJWan1Hk6IC5xE05Oh9lxZ6VqU4oJS
 QA74Rsj96vxjO1mP+/wQ6ltQ8q5eI2KPJkNtwMb2rN4AM73K5KMLKmhq75Z3JYivc0k5QYzb9Bn
 6a4RQaNOOlc2gJDlxeEpbbj/7Yw4wxpXiN5RkkI8/WEMEqwUMx4bE77judWNHoG1h5ZwgOzO9o9
 BIBnIa4mweVIO9ZiMOfQlPzWk93Jt1XPsg4GaWDfgjADxDypoxKXHUWOOHSHjwyaitdxvutx9xt
 PDHA8E3hjf1z9gCh3zQrfSxD4MTYL7oThyd9fnk7vjsHfrlNxPhIH4PfloycfNq4fwkfPjmYIhe
 LXN+o6TjejWjUME3C2Wew4M4=
X-Received: by 2002:a05:701b:4187:10b0:144:ff51:2d5f with SMTP id
 a92af1059eb24-144ff512f97mr576952c88.33.1790159252660; 
 Wed, 23 Sep 2026 03:27:32 -0700 (PDT)
X-Received: by 2002:a05:701b:4187:10b0:144:ff51:2d5f with SMTP id
 a92af1059eb24-144ff512f97mr576909c88.33.1790159252108; 
 Wed, 23 Sep 2026 03:27:32 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:27:31 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:55:51 +0530
Subject: [PATCH 11/15] dt-bindings: display/msm: Document A845 GPU and GMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-gpu-v1-11-0c3c79a1a470@oss.qualcomm.com>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=4840;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=Di/O0uiu9sPfgbWZQ+DWpyFRPmaRlm3RFUo2LVR7Grs=;
 b=oSIRTIhIZTWgDC4dXD32uIpXePSFy6yeSCHpm1fL/BJX72Hrv/9/RdQGTvztY59Hyg5ntcCm4
 jHdUKpXw1dgALp5yZOyf/ttjpjDm4SFkpgAu8+0TssXWGH1uhbPRZd8
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=SJnXx+vH c=1 sm=1 tr=0 ts=6ab3a995 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=0V7fMRHxbeNora9F6bUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: TCqJAuA02e843HEnTCRIVt_ekOm-OyId
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfXyCztP6PKvH4v
 UV0u6EDbT18kEZESp2usX/zTMaXi/5II5Ma7We18de42XqVWP292DKo1RWL7jBiR3eqCR2u5oos
 grcvsfwuBLWMLJwp44/tW6h7rm6QR/I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX7j2/6Pu8Zq75
 uZWTtJtHtnF+GIRdQqtlVZ8VFySMPjA0mxHs5uxLLzTB+cJDzi3wurJepN5PCv2TXSzAVM+HkVc
 fVU0I3TLQlQ5+pT8C/jLhR9L/A1ry0Pk1IYz6KMfCeA0rdVZOwCuj3rALBumr1ocPCbWdcdtZnD
 8ZcvA15vg/eNR24Zt5wtfPMPmD3ogJos8j2OdrIlw5Ui3xRu9d2XIoybGJqkNY/oKwOa7xf0yOt
 QABaZEZLGJjyafP+OrN6UjfGYtf0ADtb7x7XvML6nxFb4qtCOBjsuIjg6DW82LV214/M4Vlmtzg
 IKjP/4X77QPqktwpe3eiaczUxSQ1Ogg4QO5zHQ/XcU1mn9IjHvxlMbIe5BDIjmLASFZRoh/zZp+
 w7SF6sVaoD4mnWUg5VwA/PPKuUeWEyrc21GNtOSTW1Pu4AqNnxJOVvUrpKylwDSH2B4ZITSCfe4
 ZiiXAjY/3PTLa90XftA==
X-Proofpoint-ORIG-GUID: TCqJAuA02e843HEnTCRIVt_ekOm-OyId
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230041
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

From: Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>

Adreno 845 GPU is present in the Maili SoC which is very similar to the
A850 GPU, except the MALU block. It has different set of power
configurations and the GMU clock list. Document this GPU and its GMU.

Signed-off-by: Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 54 ++++++++++++++--------
 .../devicetree/bindings/display/msm/gpu.yaml       |  2 +
 2 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 875fd1242528..be4feb87f274 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -367,7 +367,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,adreno-gmu-850.1
+            const: qcom,adreno-gmu-845.0
     then:
       properties:
         reg:
@@ -380,7 +380,7 @@ allOf:
           items:
             - description: GMU clock
             - description: GPU CX clock
-            - description: GPU MEMNOC clock
+            - description: GPU SMMU Vote clock
             - description: GPU AHB clock
             - description: GPU MXG AHB clock
             - description: GMU HUB clock
@@ -388,7 +388,7 @@ allOf:
           items:
             - const: gmu
             - const: cxo
-            - const: memnoc
+            - const: smmu_vote
             - const: ahb
             - const: mxg_ahb
             - const: hub
@@ -407,7 +407,7 @@ allOf:
       properties:
         compatible:
           contains:
-            const: qcom,adreno-gmu-x285.1
+            const: qcom,adreno-gmu-850.1
     then:
       properties:
         reg:
@@ -418,42 +418,60 @@ allOf:
             - const: gmu
         clocks:
           items:
-            - description: GPU AHB clock
             - description: GMU clock
             - description: GPU CX clock
             - description: GPU MEMNOC clock
+            - description: GPU AHB clock
+            - description: GPU MXG AHB clock
             - description: GMU HUB clock
-            - description: GMU RSCC HUB clock
         clock-names:
           items:
-            - const: ahb
             - const: gmu
             - const: cxo
             - const: memnoc
+            - const: ahb
+            - const: mxg_ahb
             - const: hub
-            - const: rscc
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: GX power domain
+            - description: GMU MX power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: gx
+            - const: gmu_mx
 
   - if:
       properties:
         compatible:
           contains:
-            const: qcom,adreno-gmu-wrapper
+            const: qcom,adreno-gmu-x285.1
     then:
       properties:
         reg:
           items:
-            - description: GMU wrapper register space
+            - description: Core GMU registers
         reg-names:
           items:
             - const: gmu
-    else:
-      required:
-        - clocks
-        - clock-names
-        - interrupts
-        - interrupt-names
-        - iommus
-        - operating-points-v2
+        clocks:
+          items:
+            - description: GPU AHB clock
+            - description: GMU clock
+            - description: GPU CX clock
+            - description: GPU MEMNOC clock
+            - description: GMU HUB clock
+            - description: GMU RSCC HUB clock
+        clock-names:
+          items:
+            - const: ahb
+            - const: gmu
+            - const: cxo
+            - const: memnoc
+            - const: hub
+            - const: rscc
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index 3438eebf2fa4..a11a4dba838d 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -415,6 +415,7 @@ allOf:
             enum:
               - qcom,adreno-44010000
               - qcom,adreno-44050a01
+              - qcom,adreno-44041400
               - qcom,adreno-44051401
               - qcom,adreno-44070001
     then:
@@ -453,6 +454,7 @@ allOf:
               - qcom,adreno-43051401
               - qcom,adreno-44010000
               - qcom,adreno-44050a01
+              - qcom,adreno-44041400
               - qcom,adreno-44051401
               - qcom,adreno-44070001
 

-- 
2.55.0

