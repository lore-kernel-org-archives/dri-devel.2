Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D222CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B6B51127D7;
	Thu,  4 Jun 2026 12:31:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YihOSW7t";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j6hyPYPn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC48A1127DF
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:31:22 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654AaCq51993965
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 12:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /L5+wnjbDEv3102VhOKhi89mJmJQbEkYJLYSrku4XFo=; b=YihOSW7t5IckLsz6
 zvkpUu3rt5sYbJ+OAx08vyi29N4mOGsSsCaUC0oIAWOJ0E7Amiwn3MgInauKAkfV
 aGgwCTcmYg1FtV0KASu3vAkq4U6tjg1P+Hpoc3E4maSnqEi1uq0QXTTdvQK0TidU
 IllBHxoGjYOVzVaFObSY2hyiBVCa/uG7nj5fbw3dVkSFq3lr2H9wvRnoIS3yN/6u
 k4ni+Dn85uMDjrFS7F6hl4R6jhQPJ41ax6g4+ZbHfZLyDTFq011Fr0K3JJ/x77SL
 LvU1jW55gygrd2QSZwXipPYKOYqgP/skwrWZa8uYlBrA4x73iP/dxudnyJXdLQq/
 m0vd5g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs8pumwg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 12:31:21 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8426ed9f24dso947530b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 05:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780576281; x=1781181081;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/L5+wnjbDEv3102VhOKhi89mJmJQbEkYJLYSrku4XFo=;
 b=j6hyPYPndEQAp7MvQknCAAYpvzlJhBWCeQk29fwXIcHUWFNQ4qQyEw14Aypwqqj8VS
 PrDqYimGSmHxDzUxCFhzvVSlVamYpfLZQzXDsruz5tVQZQyGQimaBsnEttiglSjzbM7e
 y5JfH6FLTnLHUG3I9IOKHs+xoJk1vw76G9uogCqiRZ5OeTWIL4gUNvy/s/DS+yjPZLG6
 w2MpxBsFiwhz6XjAMot8dTJHRxaDSwGozICmK55A12Pn/h6T5EE0J5MwptoO733X51FA
 gfG1FrIueyAZKSzRORzb1/R1idWbVem6rKYTnU/yA8hz8FZEKYk5XEGXNvKil/Bzwj5k
 siEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780576281; x=1781181081;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/L5+wnjbDEv3102VhOKhi89mJmJQbEkYJLYSrku4XFo=;
 b=DPeZk9Ff+qSeWu9lBluNfo99f0xf2rCgr7gstsRvOFVoPzUOc4Lb4g+IIIy4anymvG
 W7Kf8G+o247pnFBWsV4+CNlIK1A/3yFeG4LZXV2sHExXQilPvg5oOIPmVe/ABc5UbZvo
 wVR0xWSPVabVw1y/dfzWQt/bmkMt2bkGgP4l/17dDbtvv3fwuJt6Lz/TLrGCFV+iYKKY
 B6geU6PfRebqJd0tWntqTm8RicY7dY/y3w27bRimAvlMFs0oTtpLA+dvItcWUWCA0Vx+
 KYUmaryQPqDkyEvjPzxBrDzhbatLAyrz/IzY7XPbextlbxD1XhkM0ZQ7O16SC+ffRdwe
 +ZuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9328DUuvrIunwYcBQZGpRxgTacvBUe86szUFtKAMdVGXk76nAlMcKMk6VlQijjowSNwwFgs27s9HI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4Gh7ReJMEzvHgZsFJVA1MTo6ZPvxH+rUxqAEma6KVoTY+oYAX
 9lmXNMJMsBTIQKm7YJOSJhPQDKX1jd7Rt3g9CB9Bm/dpI531cTU0TZoY3ZXG+FFZNRbRxc0Thz0
 tGE4IHqhkSRhqdadyuwQm7Hsy3P/hz/bzkx7P84fZSW9/ZqleHrOFqTGIJ/Gfxbkpe9OdRVQ=
X-Gm-Gg: Acq92OEHUlScC/vhlYZwP6lUgpF7H/QbGe1kJgnSKVV5QUhVg5+Vpc3O6hmQ2drXnN4
 47Q3rrE+vw98bTI5sHy/5KBApFNVlALokYqIMsvNIlgJl+BPF3dg2/DYX9JBSmZ/yzYlsO+rxPv
 BEUzIXToLn1LF/nkU7G+jlBkYO/LzCjQRYwzEcQko4BM4nMoS02iPJIt62RjoHbOqSkxwolaZYX
 HjNSpzm4tDp6HqBQp2Oz/C6T1hPE8moMrGUy5R7y02vxtQucSrmFiji9eiiZ7kqesutO72Z8tcu
 d0ICqmUbs3BJT71CkuWMQEUQ0rxglqyilMTye7GVZ9a+cxRcnbvPctN1qHSNnYEVCtiTWbx9CnW
 kA+hNSSKHcFh+choLvmKs0D2Xe+71+8sT+ZDMnVCB79ojknIzrfUpqFNTNpk=
X-Received: by 2002:a05:6a00:1905:b0:837:f111:b70 with SMTP id
 d2e1a72fcca58-8429b57a3b6mr2822613b3a.4.1780576280751; 
 Thu, 04 Jun 2026 05:31:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:1905:b0:837:f111:b70 with SMTP id
 d2e1a72fcca58-8429b57a3b6mr2822556b3a.4.1780576280004; 
 Thu, 04 Jun 2026 05:31:20 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428325d9a3sm6015917b3a.34.2026.06.04.05.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 05:31:19 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Thu, 04 Jun 2026 18:00:47 +0530
Subject: [PATCH v2 1/3] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-shikra-display-v2-1-b3c1b2b67edc@oss.qualcomm.com>
References: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
In-Reply-To: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780576263; l=4493;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=WfANBIIgBzTwwuDDl6Kdw8lUaZONgWxsNNvWrRs4B1s=;
 b=MtMgBdqvWqWsrLdHxWNc0SaL5+U3fBPtkq6vzeFtJypgM4h4oQWOWMW8CatTFoOwuUB00ACxI
 /jqGFI74wkKASThmqiqyz0GObhh0XKnl0wAX2LWewF69aq3oi58Z7bG
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-ORIG-GUID: OrVlknvJSppos_3pxXUjKYshXPC79Ah1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyMSBTYWx0ZWRfXyZwlWvGX40au
 NpARUAONPkBetxbdWunwYvTjqkiht7S+/HHnDIqDWZ7BZclDZjyAd+u8D/WsI+vqR43JK0x2wFH
 Uree9xihWxtB9/3zWHhI+BZHhhT3IcjsMAM4mgN1vPXziE+rcCJofmxY7FUpPZh5MzCgWGdftNW
 snRNVJarrftNIixLG449vIDqvv51tgJK0W2k87FSJgs7VbvQEjv+v4SumaM6FpPXdfN+rP870wo
 bX39dZ30JV8BYimJPy8HgPyXe8fJewILD1w3h25MzOIIcV9bQtOLl2qMMYCSs+R2nQdrjrnNDfe
 jwTE/BOjbm6QZkerXh8tT+iqxqOuJn1DqPMOhZufAszyCDY5FageP+egVQHpsH9ILQ0L23RjLsv
 7OJcURYsVsHD0Jp6ZIrprNQTn5QBXLNEdmLnchxnyt0k8DKj+Hn0CCTeWvZeJOQdxldCC7EWat3
 yyTOs/c3E4TcDjR7H9w==
X-Authority-Analysis: v=2.4 cv=E779Y6dl c=1 sm=1 tr=0 ts=6a217019 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=_tpsKkHDXNPZovU35XoA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: OrVlknvJSppos_3pxXUjKYshXPC79Ah1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040121
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

Shikra SoC uses the same MDSS/DPU/DSI hardware as QCM2290 (DPU 6.5),
sharing the same register layout, DSI controller and 14nm DSI PHY.
Add qcom,shikra-mdss to the qcm2290-mdss binding compatible enum
rather than introducing a separate binding file.

Register qcom,shikra-dsi-ctrl in dsi-controller-main.yaml alongside
qcom,qcm2290-dsi-ctrl, and update the qcm2290-mdss patternProperties
to accept both SoC-specific DPU and DSI controller compatibles.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 .../bindings/display/msm/dsi-controller-main.yaml  |  1 +
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  7 ++--
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 38 ++++++++++++++++++----
 3 files changed, 37 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index dbc0613e427e..a2f3e91104af 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -33,6 +33,7 @@ properties:
               - qcom,sdm660-dsi-ctrl
               - qcom,sdm670-dsi-ctrl
               - qcom,sdm845-dsi-ctrl
+              - qcom,shikra-dsi-ctrl
               - qcom,sm6115-dsi-ctrl
               - qcom,sm6125-dsi-ctrl
               - qcom,sm6150-dsi-ctrl
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
index be6cd8adb3b6..e166a73651df 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
@@ -13,8 +13,11 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    const: qcom,qcm2290-dpu
-
+    oneOf:
+      - const: qcom,qcm2290-dpu
+      - items:
+          - const: qcom,shikra-dpu
+          - const: qcom,qcm2290-dpu
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index bb09ecd1a5b4..7184b09a8774 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -4,21 +4,36 @@
 $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm QCM220 Display MDSS
+title: Qualcomm QCM2290 and Shikra Display MDSS
 
 maintainers:
   - Loic Poulain <loic.poulain@linaro.org>
+  - Nabige Aala <nabige.aala@oss.qualcomm.com>
 
 description:
   Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
   sub-blocks like DPU display controller and DSI. Device tree bindings of MDSS
-  are mentioned for QCM2290 target.
+  are mentioned for QCM2290 and Shikra targets. Shikra uses the same MDSS/DPU/DSI
+  hardware as QCM2290 (DPU 6.5) and shares the same register layout.
 
 $ref: /schemas/display/msm/mdss-common.yaml#
 
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - qcom,qcm2290-mdss
+  required:
+    - compatible
+
 properties:
   compatible:
-    const: qcom,qcm2290-mdss
+    oneOf:
+      - const: qcom,qcm2290-mdss
+      - items:
+          - const: qcom,shikra-mdss
+          - const: qcom,qcm2290-mdss
 
   clocks:
     items:
@@ -52,7 +67,11 @@ patternProperties:
 
     properties:
       compatible:
-        const: qcom,qcm2290-dpu
+        oneOf:
+          - const: qcom,qcm2290-dpu
+          - items:
+              - const: qcom,shikra-dpu
+              - const: qcom,qcm2290-dpu
 
   "^dsi@[0-9a-f]+$":
     type: object
@@ -60,9 +79,14 @@ patternProperties:
 
     properties:
       compatible:
-        items:
-          - const: qcom,qcm2290-dsi-ctrl
-          - const: qcom,mdss-dsi-ctrl
+        oneOf:
+          - items:
+              - const: qcom,qcm2290-dsi-ctrl
+              - const: qcom,mdss-dsi-ctrl
+          - items:
+              - const: qcom,shikra-dsi-ctrl
+              - const: qcom,qcm2290-dsi-ctrl
+              - const: qcom,mdss-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object

-- 
2.34.1

