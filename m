Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E020CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78C4A11237C;
	Wed,  3 Jun 2026 14:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MpJfbVvM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N+JPV9m2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776B611248B
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 14:59:49 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653DC3sN1957518
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 14:59:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FCvEktdSiv4A6mtT0YE77fV8FNu/cYvcs0DIGD1tKXo=; b=MpJfbVvM755po/He
 XTPfzryXQ/64qNgjYaLJh72VMguEPzoGAErIPRLRKcpzjRywcQXw/8RNcL3rD/jc
 vNGtu7kok8OpwFvnqX/kJOUyRQNWQnrTjP54ejaTJ8IPtZD2tMZJgVlNkTmcf8mB
 WWZWU0WvHj4SnloocUhlLjwEbas13xbjvGi0TzsE48O+GwMzhdNTgwZaRSeEPlOQ
 ShgH6NFjD7xaTGoz83jwWxdZM13Wo88ObLFGEmbqB6scRCcwhyBH+AR+a38QJvC3
 1oTYWPA8RTBWpIfAqteBT60TWBeFvA20Q+S2oJw47qqY1PQx2W5gHUoLM3Vx7Ia1
 jF/yQQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejfqc1ugn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 14:59:48 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8423f544944so2723067b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 07:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780498787; x=1781103587;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FCvEktdSiv4A6mtT0YE77fV8FNu/cYvcs0DIGD1tKXo=;
 b=N+JPV9m2eCrfYTReNSJ1+ekqgXXnW26KQo3oH6kKsiQIETEWGW//SA7ODd3TvHWr4u
 iUlebHRIxS/RQbiN9URS9UHGjx2gQ/sZjNzkgFylpqrh2BUcmrrd2hdGQRg+/PbpMN6I
 vsc2c02U3DeDKa1z3JDC+uImiUrtPr+TVTqZITMdj26ImbpJwWK4w82ZtRi8zrkLXLfM
 5YHFEisHqYgnmlZCUE902gEQclBW8L8n8i/Y2yT27cUT2YaVitqULPwF1GQkldRnvVE0
 SRzMo3jRNOD5y4XPzvhKn7uNQJn9skKH2rIEyMvGkfj+8PPmYP52p7HL512RGYd3AUG9
 Mh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780498787; x=1781103587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FCvEktdSiv4A6mtT0YE77fV8FNu/cYvcs0DIGD1tKXo=;
 b=bOfz/Ayo/5yL2OZo0IW7kfNhvnEl2Loa29gp37ucNqDwO9QZhhtFypAyR0A73pXM/W
 edMvlmnIHSsI0Wc8Qche/GHEJW3B1T5xzqE6ZzqKMhl5UIXoU6lK2skoYGWTO4gubeeD
 f4HHuixTQV9ud2yogTVVd/ZfOpYS6prip9SU8eb1583ObWJaUxR16Q24ISLISe71kix0
 8BKzq+wk8FwLNSMVm60bSJFjSiZtlZNpjw2O628Bh0Pl0LdSb0Xkx2c6lESuyRGgPnJN
 MBS0WIv4zb/JIZzcmh35vZkx9hr5VvnzqQppbyJRJRtxjh8zan29nbUoHCYHE6L0B05S
 APCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VC8kYnr7tzx2bjHlFA2Pds/SnPNIvAogMsSUQVvvB1cc00ao8uTupiYJR2X/o7pAjsMXr0YNu5ck=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXJLyMSh0O3I8pSqzON9ENdJaWz5DRabbShe/fU4ciANCyzavD
 gyI8FJemuBBbrko2nyFTkHVNSelCxYvyi5r4BGQvTp4nsba+j0Zf2tE4u55JYRhk+O8Y1RLmlC1
 BO41AIhBOFcsqGSui+y2aFjS4ZLDTdoPNbg5jNjzfd2Lvj4mhrDDiDMAV6h9OQK1WoZOaLDk=
X-Gm-Gg: Acq92OFzSDyxSnXoGAlmzTJi7gH4tStalX75q9KLTyzEGBfkZaV707igNi8ZNwvhFtt
 q2oKrtWynhZBmmyvvVH4ACLukfPBknmnYiqECHsCQye5goKm3rnykDY9MLKs99wV8i6Rqn4qxQi
 4QQukItxRp4fOANAwkxKDDj8+Foy1rBYSAo2bB/bJMSQrkgiRIwB+7z0K7swGMxYJCR+DIpz9lG
 OcPyHQbRTtG2LpxuOK9E5yQeVUOTN2kMhDSu9eAfWb4Lc1uy7dSERYFqZLHjSFkhmCXgdMRm0Xc
 li7/rZ3Y9SCfUEhUXvk1VJcWLjet1DCY3JCB2c0MjPAobXeeNJ0yZwnYhHKRRig/lwR/zlHbp/C
 qMwfHHATz/t/Rmh3U6rQtXEXu4iR8irmsVpubUJ3j3gJxlK0emit+j7+Feoc=
X-Received: by 2002:a05:6a00:181b:b0:82f:4cc9:1854 with SMTP id
 d2e1a72fcca58-84284f4eb8amr3945728b3a.49.1780498787380; 
 Wed, 03 Jun 2026 07:59:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:181b:b0:82f:4cc9:1854 with SMTP id
 d2e1a72fcca58-84284f4eb8amr3945675b3a.49.1780498786882; 
 Wed, 03 Jun 2026 07:59:46 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282882170sm3747409b3a.30.2026.06.03.07.59.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 07:59:46 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 20:29:26 +0530
Subject: [PATCH 1/5] dt-bindings: display: msm: qcm2290: Add Shikra MDSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-shikra-display-v1-1-aeac1b94faa7@oss.qualcomm.com>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
In-Reply-To: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780498770; l=4175;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=MlVeOjyzwpym+szw56TwOtGwaPWWiF2YunpAZEWQfDo=;
 b=oxLSInKe2xaUTLeI9g3Z5OUf7JJRMtiRqN/OpXficZ7vBb/NRa3zVy3B7/ShmW5dyy21yM4/H
 tkNVDWGHZMUBTCpEPMfU6fGIUthwjbz1/Zk+f3hiIxAYjthF9wOuCYJ
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: r8C7QH2iqChQ7DQik18O7ZRzgl2Ldwn4
X-Proofpoint-ORIG-GUID: r8C7QH2iqChQ7DQik18O7ZRzgl2Ldwn4
X-Authority-Analysis: v=2.4 cv=e602j6p/ c=1 sm=1 tr=0 ts=6a204164 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=_tpsKkHDXNPZovU35XoA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0NCBTYWx0ZWRfX9QQQvQMxrH91
 zcRKCk58dUxq7ptYEKzfjzUe43tMY3+RB1ecgx+yTDB2kNTw+9grWEFoNsOp7zPYgr5YJSrI+TK
 MG8my08TFHlIa7kOi95oC8qvuv2ABomNZ5hnzSzU+1dcs4mPuyIUOALcIxdffdzidlcR/UFVT+5
 G2/si6HFScGGGp3oxzZDEyH1X8Br5VKWJFRr/rOeY+zKCJnow0++mefgymnkwAdxKFrNv78WbWQ
 +jqTwrN9vzbIa66UG1hOsFf7Dm7wsYov+kUMxmJjnTnKjyhKEyeCbhUDFbvRSt0NML3H9KUc/2r
 ymHFIOeNnBD7swfRQ2lFT2bMZtLeuJXF3ieZljX4fOwQWLrMpQu2FHvOCMYtzXwn3MB0c1WRlZQ
 DCTc9evuDy3nJU9Sp782wLpZfJ6jWQ2L3VkRduN1Z7PCYDouVHHSO+A9Mn0VeuDxKBxsuBSFbFC
 RnUOKkawEZP8Cgtq4og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030144
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
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  4 ++-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 34 +++++++++++++++++-----
 3 files changed, 31 insertions(+), 8 deletions(-)

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
index be6cd8adb3b6..cc1f227ade2d 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
@@ -13,7 +13,9 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    const: qcom,qcm2290-dpu
+    enum:
+      - qcom,qcm2290-dpu
+      - qcom,shikra-dpu
 
   reg:
     items:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
index bb09ecd1a5b4..d2609c24e305 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml
@@ -4,21 +4,35 @@
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
+          - qcom,shikra-mdss
+  required:
+    - compatible
+
 properties:
   compatible:
-    const: qcom,qcm2290-mdss
+    enum:
+      - qcom,qcm2290-mdss
+      - qcom,shikra-mdss
 
   clocks:
     items:
@@ -52,7 +66,9 @@ patternProperties:
 
     properties:
       compatible:
-        const: qcom,qcm2290-dpu
+        enum:
+          - qcom,qcm2290-dpu
+          - qcom,shikra-dpu
 
   "^dsi@[0-9a-f]+$":
     type: object
@@ -60,9 +76,13 @@ patternProperties:
 
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
+              - const: qcom,mdss-dsi-ctrl
 
   "^phy@[0-9a-f]+$":
     type: object

-- 
2.34.1

