Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E42C88E45
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7368010EB31;
	Fri, 11 Sep 2026 15:37:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KYTnV2H/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kHkbLvH2";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1398910EB31
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:33 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEmAsd1090942
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 F0/+fVvhOXF30n3qDQqRZypRi/vvshor5bgJQEsTRIo=; b=KYTnV2H/WDw8kR6X
 0fCxw0dQ0glmb3+7ZZhP4iUYGI91IcuQ7lG7wzU2pVoDrWky/SrPjfsID8E2Njay
 EZIBRzGq8FB89e1jEVhB48fhf5WPIDWh02WCzFg/8nL+GJXSyOwRuxTbk2jaQ9q1
 8VwiKKpCGAPzgv/CJjfW4gZl0dldAjfRxMMW3d+GZPgQE+T9AKNJ+cOhlgHE8dmt
 DjJU78e4Ph4AcmtprVeZo4ebIIybMealRF2wB4WWdGCTCHTRdF/6R4rQCk3d/ZK8
 3SDO6AFceYSywWSzRaiQR2LTgIb03drBLgxO8QJCo8JU1XNLqsqBHKpjftAnuR88
 quKSDQ==
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd3ajut-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:32 +0000 (GMT)
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-4519ef1babeso787849fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141052; x=1789745852;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F0/+fVvhOXF30n3qDQqRZypRi/vvshor5bgJQEsTRIo=;
 b=kHkbLvH2QAPvFE8ShUPInD1uvTDQ3b5p0PquaifoHfMhtP6VTOapI/cNVnTRR5PCiS
 2OLuKoN6/CVG1/7tQLUrotKspEv3Qey1cCW6ykbd0UAdhKu2r4FJqibJKYoKsOIzSeXe
 Ev97dii4FReGNQ4isISoNOadU/9oA7s6qNG8YmSb1a5Z3+CpTRoMvj6ri2D6b9Taly7t
 v2t7mJgVUIaGXuT/9BFGofFmSlL2amMq+JuMdWnYdpsAGNLz398j5/1iITaR7KhQrYzi
 RDEFMOw5yZFsyO0WGn4SYy495C4njYTtuB6NjxyBBNDEoW8DRb+emmuvzJW8Tev41/M5
 Lovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141052; x=1789745852;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F0/+fVvhOXF30n3qDQqRZypRi/vvshor5bgJQEsTRIo=;
 b=oe5MJU+BL2l7Ne8nlGjPZQ97jFDsxeoUyDr0CG6FSrwwfKralFyk9PzGr0xJ4tvtwO
 Fv9eB9ByepKNFgQMt1QZmcUyAKhE30L30FTiTOp3BCobY6cEgcsnMPKRPENFu34T4Q8c
 ZIqpAxpJgZ6c9UX/30n+rxT5Dd53XZdWOPT/mqkspUBQlX5pW2XzsnaO//zBsh/PpZDm
 lgJGpcM72GvQWTTJb2SPWrTkCwnEHazD972IS7ahoylqwBAgLbCWD6nsAFTou2X1iKwG
 uxMX3zynXbqOQrgGxL9ml33VDFaqGYnNKLtOGG2QCHXPQqtnGX96wymRB9L3FT21YtgW
 z+wA==
X-Forwarded-Encrypted: i=1;
 AKwUvByJ11Pln2ay188PLLH+V3AjvJWSmzREC1eE1b/WIYgsnRc2aorpW1tQSmpf6d3R0iaKDjfpSbuiyko=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mYLkaz336dUwvyCaklUGez6oLwIxOSLWaOIBjKmug9J7pn9/wQ
 PSNYmGvQ3ITamsGjEM1yFKGADjvZh+qy3sAIcqd/iAGnCy+TF6r4lGLnOfwL17GWWsKhwIo5jqx
 z5c6Wlmi4WfuZdXcZN4FSSw/IZ3o9SEeZODYQ+qtKTHh4NgMeB7lqsfrj7f461exOO3F9SWY=
X-Gm-Gg: AYBFou0Rd8C+8JlAa5XnhveRXQZ22gB6WoqLyvpoE+GKbJKF6INHxNpwOaxAnNj0WyJ
 4B3ecvmKH6nkitg6VqiajVYS4vSJprGXWtJu5unWrib3b534zX05a2OoFMEUmVAkhyJb9ZuKwD7
 tDqVLh5NjhGuGaVaarLD2YzxXFR/kQJ0XEKpz9nHrFKxzcYcX8RYUIRooHTyIUsBZPmzmVNmyEv
 H9XlFouq5ohJ9xWEYBLzEpDSqKpLWq+/stK68WJuoTYnp7zRjvE0WQtJAPmkJkv/odJ01LjWaOI
 XtIzRGXVNlOeWfYYaxKmo8f2nlQ1p66fiWlWTkkghfYsxU7y6UrdgnOt9Th6juabKdDn5dA6mFA
 g34sNYLnE8+LmEcgBHi9N5ERwzLk=
X-Received: by 2002:a05:6870:a0b5:b0:475:e0a7:9f34 with SMTP id
 586e51a60fabf-47de9967df3mr3841121fac.34.1789141051518; 
 Fri, 11 Sep 2026 08:37:31 -0700 (PDT)
X-Received: by 2002:a05:6870:a0b5:b0:475:e0a7:9f34 with SMTP id
 586e51a60fabf-47de9967df3mr3841081fac.34.1789141051072; 
 Fri, 11 Sep 2026 08:37:31 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.37.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:37:29 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:34 +0530
Subject: [PATCH 03/17] dt-bindings: display/msm: Document Nord MDSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-3-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
In-Reply-To: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=3375;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=v6qbb59cSCOFYZp+/jT5/t4KEEFywV4AJkLRBZh12sg=;
 b=VthrLSgYFzt0GpHboC0CLVbmH++is8PI/ePpXkxK0R4IJmY1Nk3ZPzxHZowpzVvWqG0/fFN9B
 AtF5j8uVhD5BJvc8A5vnxBD/fKNGfqlsvf7DTpwIBlhQnVqil92MGQb
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Authority-Analysis: v=2.4 cv=Bv8IUoX5 c=1 sm=1 tr=0 ts=6aa4203c cx=c_pps
 a=zPxD6eHSjdtQ/OcAcrOFGw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=DZBPq5aedYDaYU3_3SAA:9 a=QEXdDO2ut3YA:10
 a=y8BKWJGFn5sdPF1Y92-H:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: RHGtzq3gLjN9L2C6LVIHCs_HRnNG87zT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX3K+q0mmPavrd
 ZBWJHQ0NxK5W3rGGiDRj8Lk6ojawGpfCcoq9bOHLVXycZ4LWnfxzw2yl9VBNZaXq68Xqg70aHX6
 oz9FNdTkIElYOMM7h5B9BURdux5vfrg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX9OH3nt7JEU5y
 xl0yPRn0VBpzdfd2bPdNI79DMm3olDMRJIcTbyBkCyBxPlekPqCupwLKFTKgSXb5HtZC8zZj7cS
 4zmNOVvt2zyPA18ea18y2CmiaDZ0Tcn8gg+AQCTY5y/7Y6n5FhaoZeKC70AzrkFqGO65YRjFmSi
 iY4aJqDaR+v3gEq/CKm12TAmLJwxL6xNgGKSoK8BGzpD8Zo94jZDwAi78Nf51bKX3tqM2J5mgvq
 O3qqfDzO9t/FuzH4FIlWrfaN2mbZhg3NW/Ab8IBebEmR5oSHTTaiOkc/UGoUw9vYQ4SV7BshYHf
 7Al80ie8yOGv1rLRINo3xgf/T8mAnqB4kRp465vncxeF3vponGW8d2/z68LK+Hcq0R2V+GMefKw
 qK+o32/29XveC6jgSpUqvzEV7AFcb89MzIyBiMHUCdjb26GUS5iBvQtNKBRwxxUNJMjngAN6ppe
 nWa1figJubKD0MIXDAg==
X-Proofpoint-ORIG-GUID: RHGtzq3gLjN9L2C6LVIHCs_HRnNG87zT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1011 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110218
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

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Add the binding for the display subsystem (MDSS) found on the Qualcomm
Nord SoC. Nord is MDSS 12.1, DP-only (no DSI), with two independent DP
controllers.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 .../bindings/display/msm/qcom,nord-mdss.yaml       | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
new file mode 100644
index 000000000000..0b0cacdca9db
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,nord-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Nord display subsystem (MDSS)
+
+maintainers:
+  - Mahadevan P <mahadevan.p@oss.qualcomm.com>
+
+description:
+  Nord display subsystem consists of MDSS (display controller), DPU 1499A
+  (display processing unit), and display interface controllers (DP only, no DSI).
+  This is MDSS 12.1, DP-only, with 2 independent DP controllers.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,nord-mdss
+
+  clocks:
+    items:
+      - description: Display AHB
+      - description: Display hf AXI
+      - description: Display core
+
+  clock-names:
+    items:
+      - const: iface
+      - const: bus
+      - const: core
+
+  iommus:
+    maxItems: 1
+
+  interconnects:
+    items:
+      - description: Interconnect path from mdp0 port to the data bus
+      - description: Interconnect path from CPU to the reg bus
+
+  interconnect-names:
+    items:
+      - const: mdp0-mem
+      - const: cpu-cfg
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,nord-dpu
+
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,nord-dp
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,nord-dp-phy
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,dispcc-nord.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    display-subsystem@ae00000 {
+        compatible = "qcom,nord-mdss";
+        reg = <0x0ae00000 0x1000>;
+        reg-names = "mdss";
+        power-domains = <&dispcc_gdsc>;
+        clocks = <&dispcc DISPCC_MDSS_AHB_CLK>,
+                 <&gcc GCC_DISP_HF_AXI_CLK>,
+                 <&dispcc DISPCC_MDSS_MDP_CLK>;
+        clock-names = "iface", "bus", "core";
+        resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+        iommus = <&apps_smmu 0x800 0x420>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+    };

-- 
2.34.1

