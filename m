Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28347CD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8984910E5AE;
	Fri,  5 Jun 2026 10:19:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ehgZvF7A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KG9qLj5l";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1EEB10E5B2
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 10:19:25 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6553YUEu2974871
 for <dri-devel@lists.freedesktop.org>; Fri, 5 Jun 2026 10:19:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8mO6WbvT1h9M7fR6svjtgiQ1TZ0TcZuDFdD/Tl0yHwk=; b=ehgZvF7AZ5WrNQrJ
 H0w9egfZbOBcsnIpjqYB187lusX001tRhHyQnVDSyqF2734nd4pISwKOrD+v+NAa
 1sJROJep8REdoAInQbMSUb0rPn9f19P0fG3LkTb+NkzkRWvy3NUwFnWvLIxkzKrz
 wCdX2PGrht6JcPhb4OSeMDNxYQLYAs579V3mgCcLEY6ZGMArBJvQnyWWX9dLWy4q
 J8JGpdLHfWji9n3RxEtdvmAM+K2tu8HXoYHbwVfJgC3ugnOeJgkc6mvUkY+9UrmG
 +AiM7u0q1dlJsGJP1RQG88fNDEAYWcG1dvbsw3Gat65jaLxDQSXj68Opg9b55jQ/
 dqc1Hg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekpnu9fcv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 10:19:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2c0532a6588so17532495ad.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780654764; x=1781259564;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8mO6WbvT1h9M7fR6svjtgiQ1TZ0TcZuDFdD/Tl0yHwk=;
 b=KG9qLj5lCdwKMHMLm/ptgBWqvtInlaJx95GXjsjdTqDX74kdX8p84awAN5Vhpc+2Q1
 3oL2+oVmPo1OIQUfDsNvYBFCtx5jUtvXO5IDDzL10RFSAv26/V7pLJ2BHLXHLafZVzdD
 zx3ELfSIBqBN9P0udgzpTYw4o+4yvBlCz2qwC8mkH6daMqRN1uihzXInHkRTcdkIS6FC
 vA7bSfQweNyucMHs96uEfKaACfD5T7xMPTx11ywaFqYlD74MApjHFb8P2Uq+PUJLZKjT
 ykk+knnhLyhCPooC/NZhyhCax17hhNmerutwwZcqarbeH9OPfotoElP1XBRHO1GvjY9u
 VyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780654764; x=1781259564;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8mO6WbvT1h9M7fR6svjtgiQ1TZ0TcZuDFdD/Tl0yHwk=;
 b=Lydwsxb8u76lxaqBycQQwJHZ0N7AfCi8dBrPFyh3C/jEaMZayqrjr5pSQLYqVun7uU
 fwaYM2ABNxsy5wtXq0cx9j9sIc49sy1/cDSawmdIZ/BnaWEE++0astr4DxvlF7/4KdvB
 ZoBPUHUCrt51DMy49lZPfLSMJ1944GzwgDJaI6EpT7AcdK37ftyyAhM0GYuhzXQjQz5o
 y3amdj6K7LuvqwQqdHZFuYU5I7A+cMcqI/+IrudfWpUCc8N6ZH3I4jmMn7Tl3Q+M9tKZ
 HQk07/tRayHQfxBRKcRAHHPS5Bs77aZ1MNZ9pwfNQXeaXp7ZtMdlIHgoFuouKXR26zJd
 ZmTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4CFp+NsJT73UudwfQKfF1JQsDHs99LKYPROGvTuCpBixbbqn63/OVUVe6MPaAOnOrfOiSW3PFPq8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxs+CmR2AlY3Z5b/AcHyZjx5oZG/OfQDUGsMCYHSRccElMwPPpw
 NSClnjJSRC++7TXLzVqSO0fBjsvDrbATbDBVS+gcP7w8gUm68PNd9ZIc8oDKWUQeaedIiuMe75L
 fjCyI1Ng3DTG8rbNhTgwOMwMVkQ/y6rzkzz8Zbq5liG1pPYp4gb1+FXAft9+84IZThg+r4Y0=
X-Gm-Gg: Acq92OFpDaaoJEKVtMToI9wJF47nYtC1fGTOm2u6SqLObCAUvEGOKujtCz79LQCYwi3
 5kW5E3BsLpltIEidSbB76bE6Gd7VT0+ptkWyMhIiL2LApSxFFl7Nr1s28dQwdcw8Cmh3oaij5lX
 ccGOUkKAPNry09kMfWPWibhtXUyvAVEDEqwYtWXkG/zaG7hNs5dgYr7CpoxyzSOYnwvwV+sKdAi
 Hcojeyg7RNUk78vzpj5PbsXkQ6ba7l9okWp5BOAnuj2z2fY0v+bNDkHkPIqFw+NBOnQEcOtT5+6
 hX8KMXz7Di5LtaRNTn4+d2wkZOJlvUPzR3miL7GF2VhlVzsBY+/kp7FPh2HlQ6RY8jydIakc3Vx
 3oElVspZaRi+hxvcjZQx/mM74AGyGI5qbE8Qbv/QzE55msG+ECXUyPTDzs8M=
X-Received: by 2002:a17:903:4b46:b0:2c0:c625:400d with SMTP id
 d9443c01a7336-2c1e8979bedmr28483605ad.37.1780654763773; 
 Fri, 05 Jun 2026 03:19:23 -0700 (PDT)
X-Received: by 2002:a17:903:4b46:b0:2c0:c625:400d with SMTP id
 d9443c01a7336-2c1e8979bedmr28483275ad.37.1780654763235; 
 Fri, 05 Jun 2026 03:19:23 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa0236sm89741445ad.33.2026.06.05.03.19.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 03:19:22 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 15:48:51 +0530
Subject: [PATCH v3 1/3] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-shikra-display-v3-1-9846ba5fe635@oss.qualcomm.com>
References: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
In-Reply-To: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780654747; l=4024;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=6h+vF01fqXjL8C+60pXT/uazqotTaaqSviArNOyHNG8=;
 b=TFxRUXxc1AM66zgTu8vryy4ABMH/7M1dXZw8TcuBEziBAE4HeSrNwG9FLnM7EYBN44BuRN6Dy
 aKPmV311+bkDAsH91RkXrlVUjkWwslHad46kxpe84+RjOtbqpfUeZdZ
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: ntTmGADy2NVomxz_bUc1vxuxFKsTiyhl
X-Authority-Analysis: v=2.4 cv=Ksl9H2WN c=1 sm=1 tr=0 ts=6a22a2ac cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=OEkpyX7SRU1z48_sfK4A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5OSBTYWx0ZWRfX19d1U8L2Pny8
 Y6nfme0VqFWyA38FYe2lv62vRNND93RU7M5N65TvCf/1t0a5X8gbyE5o+mCkxjld0eC7CxQ1V7w
 Zhb392RYUejYSOw+WglXmuPGe/d+kbsAfhp8fg+LsyHofbytqPfowpyVm0vlQERADsaA/G5n5ej
 ZurH2tnAfIs+XsiDyd4egIdaoOs88uR7xmuaMjWcO/Ful2WdLQf3ABho8bSWgbMsF43wWbxAJkP
 TxW820eFSdu/DX7WcfCVeGA0f4ZeMdqwHHzXmIHAE4R6BRiRsCyooUWiOOAG1avQFQkdAlpJwJK
 wLNX6cQiuIITRu/5uqWX67+XvMyWEkPSwxWbJ0PnOLpb0cUrFOapXdKGZUKafzqrnInBmaBmegZ
 KZRR8igKCAtYiRGM7eKA/kUzYGNRZvXHvo2xIUDeOEN+5DBQ5S0sAN7vpCyfcVtSzO55GyeWXGq
 pTOWzhLvdUHLei39Z8A==
X-Proofpoint-ORIG-GUID: ntTmGADy2NVomxz_bUc1vxuxFKsTiyhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050099
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

Shikra reuses the same MDSS/DPU 6.5 hardware as QCM2290. Extend
the existing qcm2290 bindings to cover Shikra by adding fallback
compatible chains for MDSS, DPU and DSI controller nodes rather
than introducing a separate binding file.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 .../bindings/display/msm/dsi-controller-main.yaml  |  4 ++++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  7 +++++--
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 22 +++++++++++++++-------
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index dbc0613e427e..ab2cfd6d6e3e 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -57,6 +57,10 @@ properties:
           - const: qcom,eliza-dsi-ctrl
           - const: qcom,sm8750-dsi-ctrl
           - const: qcom,mdss-dsi-ctrl
+      - items:
+          - const: qcom,shikra-dsi-ctrl
+          - const: qcom,qcm2290-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
       - enum:
           - qcom,dsi-ctrl-6g-qcm2290
           - qcom,mdss-dsi-ctrl # This should always come with an SoC-specific compatible
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
index bb09ecd1a5b4..ef21b2c263f2 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/display/msm/qcom,qcm2290-mdss.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Qualcomm QCM220 Display MDSS
+title: Qualcomm QCM2290 and Shikra Display MDSS
 
 maintainers:
   - Loic Poulain <loic.poulain@linaro.org>
@@ -12,13 +12,18 @@ maintainers:
 description:
   Device tree bindings for MSM Mobile Display Subsystem(MDSS) that encapsulates
   sub-blocks like DPU display controller and DSI. Device tree bindings of MDSS
-  are mentioned for QCM2290 target.
+  are mentioned for QCM2290 and Shikra targets. Shikra uses the same MDSS/DPU/DSI
+  hardware as QCM2290 (DPU 6.5) and shares the same register layout.
 
 $ref: /schemas/display/msm/mdss-common.yaml#
 
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
@@ -52,7 +57,11 @@ patternProperties:
 
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
@@ -60,9 +69,8 @@ patternProperties:
 
     properties:
       compatible:
-        items:
-          - const: qcom,qcm2290-dsi-ctrl
-          - const: qcom,mdss-dsi-ctrl
+        contains:
+          const: qcom,qcm2290-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object

-- 
2.34.1

