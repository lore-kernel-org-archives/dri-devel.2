Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BB3C982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 845EC10EF8C;
	Wed, 23 Sep 2026 10:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MYoIN555";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TI9XtLxb";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B9410EFB1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:27 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA2uYI3409808
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rgxQRfbRddwBR9e2WGSz/EjVQdtkUcNgTw11zOQWGkA=; b=MYoIN555LywVykI1
 FNl0777F9gPdr+t5MjoOv+P3K4GzSNanLaTai+dsa4bDVEJQuaKYbyskjSA9W5kG
 p+fk5kLHnQns4yQb0wMMdGMgNzAS1A41Lck2cuoYTCmZz3KsAeEGOkeAjm2Y+nb6
 dgqpyp4+kKtNRQo955lfkejAtEzJMYuO3zzevrlzoo8bMlyPT53dDR+sKddmAlGt
 Tv4QZrI02ziDt37r7DgUgIgYFwZLxrvqiRboqTMipgxAPPp58AnzI1Bgq4oef0Pa
 AEmdMfScgXnfefPhn6wldNgdjh65UyREdIxki67GndE2Vjq+7J43alS0s7Q+cukY
 pnVyiw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux863vtr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:26 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-14318be7d79so813424c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159245; x=1790764045;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rgxQRfbRddwBR9e2WGSz/EjVQdtkUcNgTw11zOQWGkA=;
 b=TI9XtLxbryykVE9akKL67dMP2yo/vNDToWnEwm0dH+ONKtokBl/jeRf78zW5NcvGUt
 0HzeLj0Z6p848zNAmQI8cqMl2YPqnbweyRdAWQ7VMqDaB2REdvDEXz7s2+Agorh0DWwq
 aLz4cfifhcjJMRFZDuzm9l6PEJSZTbQZC8eEPYIE78o6cpVr7lFYyWKQbJY8MG+4n945
 qgdIGA7jI14m02dvk1LaEWORpADHB1KW3NcHlA2vTcxifaGy/ifgxcmbB8PIbKK20MRn
 Oh5BBf9pKiQIkOqFZX4hT89tPfLPcy4uBgTAYuKNDno/05cm1s4Dymvvu0zs/BikehJe
 yOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159245; x=1790764045;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rgxQRfbRddwBR9e2WGSz/EjVQdtkUcNgTw11zOQWGkA=;
 b=OmsMf02gVKbFaZtitFvwb1mXZhOyOFy5jIaG45to8yPJrmWhl9xDH3j6fZT0GQ6v9U
 fWzEqBlNC2j2JCQqc4xphS6wHmoKPikBThZ3klpYO8FfwRcRlkMGmOL5XiO+bqPM28tg
 gqNV5poQICpgMQTARUW4YZLmfN+lP86EhNdB6LpVijQ6rnKYzrRw1HQSlGne+EET2B6q
 pMY8e597G1p7lfrnUpPD+gJYXGmnHrz2/hgUympVrcHhTgizSHSrMZ+aSljuiyDhQYKE
 h1W8zAnk6fJPhF7OSdIALNihPqzjwASx903yFSUwKg/0n33wDQlT1+8/z8oF+ZSoE0jS
 7vPg==
X-Forwarded-Encrypted: i=1;
 AKwUvByXtEPIVfPrAn2bkB0p26xjQXQ4scO32/8Ht//FwUgB0dH9tneOtllCpRCa1rJ2301qGCdRdMRp8iM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lx6iF3i7TPah4/weALfyY6TInzmkC8xzOXaa5MxMqpcgtA/bLd
 CrVzsV2YnGitmZ9H2MjyQiA0hmnh1yh27XjfjROG+Bvst9NWW+B2E+f2GnGRDL6SXLQr/TuTSy8
 hKN8Ncynjw35lkeD9CT+Cut3d6z9ISJhsaSPxErCKGWm+kXhqOtHcs6P6YdJfnIDkWldMsLc=
X-Gm-Gg: AYBFou2sI877AnZFKxG1FQeSTTgzIvK6zcHXQnTDjw1uOmRKe5QoB5lH4LBGS1h2HZx
 9bfWlZy3Pga1Q4v+h1UMMLWSsuoMpKnmxeWkunAygZXoV/TllCBiYHa/n3VepnhNhTxGChcX9iQ
 jWlcBtqZPSryNwkAukYpmiIzNxrkJFVnmWYp7RWLM/JavHd6X+CFrDtdULUgV8MldBOyzoS/qjx
 AcLJa4TDc9aJuidS3s6QF3L6JkA4Dl+t+yMZK0ENzwAGSitvcUS7A/ltdUJzbaEE57t65o2af6r
 Ug2dDjRgeiOr2IzLE+fFlgGTItsZmLVfUd7t1VlAgBQnYHVZnfqKStEqn3knE2I6+QecFQ1KNgL
 p7zXadUxnGiDPPvExlonsXnY=
X-Received: by 2002:a05:701a:ca0e:b0:144:eaa7:2915 with SMTP id
 a92af1059eb24-144f90f8090mr2852422c88.14.1790159245103; 
 Wed, 23 Sep 2026 03:27:25 -0700 (PDT)
X-Received: by 2002:a05:701a:ca0e:b0:144:eaa7:2915 with SMTP id
 a92af1059eb24-144f90f8090mr2852391c88.14.1790159244606; 
 Wed, 23 Sep 2026 03:27:24 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:27:24 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:55:50 +0530
Subject: [PATCH 10/15] dt-bindings: display/msm: Document A850 GPU and GMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-gpu-v1-10-0c3c79a1a470@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=3397;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2l0HOP6mPSZOtBbSF3ksRuZxG+DphYWlDRxyeluAzLM=;
 b=SFUs5FDbVaozEtr1Ys5yrhoHlAOgul38VUPaf7kTbcdYxKZKqgEpUm43xftFNbo3KxM7TiZvu
 YuOUkWDXIeqAke2d3hs3JVntTErY0j0vyVb516CqT+pexr5DlK8C6e4
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: qjJZnMAJHikbsPnvcnGPWgN-OGaer-sd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX1y5FhkG2KXIG
 5I7aCP1ODhmCWb1UM/0Z8YN/46cNCggdT0Iz0/W9jNmcxWY5t3O5YwYSJPmRkgmgwXFgRSYebA6
 RISsa60oqW7AJIWCQToDbs9xix8hKWQ=
X-Proofpoint-ORIG-GUID: qjJZnMAJHikbsPnvcnGPWgN-OGaer-sd
X-Authority-Analysis: v=2.4 cv=eIOGH3p1 c=1 sm=1 tr=0 ts=6ab3a98e cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=vA3qWFdfvwbCGvS2NoYA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX+aHUbon9nUL7
 VDZkLWIy+SdK4KvRyMzQjWyybfAyqJTvDfvqKLR+XfduO2dq5pCVJz1vx0Wcv16A9r6k5vFTlPa
 W5EuNjmCC2emIg/SrpsKKlnyqPPlN0+12ElE+R15dXMdWpWDRPYTNBDFe5BnbOJiv9TDc0a48Fk
 mkdFWRCGoAp2FU/Eg9DEEit0Ly+xsvCalquHA0bf2K9qq+EiG0S9T4LKyJQjAu3umi+zIeHc7pZ
 fbSp06A/VeJxBmMaUw72aMnr8jD9UDUUgLvlKr+vyAUym6cRddOkAo+Jf3jb3tyrX1BlWJSP97W
 orWsfB5rYkrN/3NYC/kg1Od7UgtzqRzoqXrqp1Ovk4H8+q4D7MqXtw9ZFawqpYL6J3xTsQHUeOF
 OzROFenPfv06rEQsqGW+vdKgkO5f5rJQm33jOtAGgaEJhggwn4RRAVDnrbeK/Qas7PH84rrgaQO
 eVB67u22lvmFQq/7e3w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
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

Adreno A850 GPU found in Hawi SoC belongs to the A8x family and is
the successor to A840. Like A840, its clocks are described in the GMU
node and it has the following power related updates:
  1. GMU is now powered via a dedicated GDSC connected to MxG rail
  2. An additional power rail called Bx

Describe this GPU/GMU along with the new compatible strings.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/gmu.yaml       | 44 ++++++++++++++++++++++
 .../devicetree/bindings/display/msm/gpu.yaml       |  2 +
 2 files changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/gmu.yaml b/Documentation/devicetree/bindings/display/msm/gmu.yaml
index 9e459f12ce3f..875fd1242528 100644
--- a/Documentation/devicetree/bindings/display/msm/gmu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gmu.yaml
@@ -55,14 +55,18 @@ properties:
       - const: gmu
 
   power-domains:
+    minItems: 2
     items:
       - description: CX power domain
       - description: GX power domain
+      - description: GMU MX power domain
 
   power-domain-names:
+    minItems: 2
     items:
       - const: cx
       - const: gx
+      - const: gmu_mx
 
   iommus:
     maxItems: 1
@@ -359,6 +363,46 @@ allOf:
             - const: memnoc
             - const: hub
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,adreno-gmu-850.1
+    then:
+      properties:
+        reg:
+          items:
+            - description: Core GMU registers
+        reg-names:
+          items:
+            - const: gmu
+        clocks:
+          items:
+            - description: GMU clock
+            - description: GPU CX clock
+            - description: GPU MEMNOC clock
+            - description: GPU AHB clock
+            - description: GPU MXG AHB clock
+            - description: GMU HUB clock
+        clock-names:
+          items:
+            - const: gmu
+            - const: cxo
+            - const: memnoc
+            - const: ahb
+            - const: mxg_ahb
+            - const: hub
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
+
   - if:
       properties:
         compatible:
diff --git a/Documentation/devicetree/bindings/display/msm/gpu.yaml b/Documentation/devicetree/bindings/display/msm/gpu.yaml
index e5efe2d35ddc..3438eebf2fa4 100644
--- a/Documentation/devicetree/bindings/display/msm/gpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/gpu.yaml
@@ -415,6 +415,7 @@ allOf:
             enum:
               - qcom,adreno-44010000
               - qcom,adreno-44050a01
+              - qcom,adreno-44051401
               - qcom,adreno-44070001
     then:
       properties:
@@ -452,6 +453,7 @@ allOf:
               - qcom,adreno-43051401
               - qcom,adreno-44010000
               - qcom,adreno-44050a01
+              - qcom,adreno-44051401
               - qcom,adreno-44070001
 
     then: # Starting with A6xx, the clocks are usually defined in the GMU node

-- 
2.55.0

