Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EECC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B41510F3C6;
	Fri, 28 Aug 2026 14:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IJJm6zRl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jYx4w3B7";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75FD910F3CB
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:42 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDkjun2538511
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q5nvjyWQigaJq/X70FSOqlsHb5yUcVYouF+wJkhwBr8=; b=IJJm6zRlwgC3LIRR
 Qsl+RRGaixMMNMB8vt37n/3o15KRcAgacEop/PAOXaDLSHDWAq4zWiXA6rOHoU1/
 wRY8jyL6tjQ7aUhNwr1u3Z1LD4RehDK4BM7xhyj/8Ux12o2ZJwUyZx6d12qERO4b
 +wXJABugKmTdcE1tTJR9vCETOIFK6B010OhDeFfX0nEDyq9qS4y7/UZoI6RPFHSc
 rhhiwWW2zALuM6gdSG0usU+GOt3KzemyFNigbTM/JIWl+Whakt9AgaYOZjRQXrcu
 8gTxDmHCSLXfwPuTnzClNvxc8P76aHs0qixAr3eSvL8yx47wbeuO/Ii6OmVyZkeZ
 wxBx1w==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mua14w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:41 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97e8be2221eso9528241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787925941; x=1788530741;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q5nvjyWQigaJq/X70FSOqlsHb5yUcVYouF+wJkhwBr8=;
 b=jYx4w3B7R2ERJuaE3L/boNhSfVznxSvauhZVmbu4OWo/7R6O2Y+zBOL0d27oq2aowS
 s5SlcqsCso9gYDMjTzJN8dtho2uLnV1AuKrEA38HoUQKF4BAKQ2s7PAgHqe8C46C2yC1
 N415rHSTPpTqCeeiJ9kiOGL3KNZBDzNg3SVM7W2NsuQM3mQ5gZBUZduUq0u382V3zv8i
 HtXv1Lzjdjk714nHBZH94kkIXFwGNF3L1tci6eorxyi+lOrEnRxixfdmK1aqqj0gYwVc
 lhmDP2mGspvRzFyo7wUN9TLRMGWnvCF+j7bHDtOwAH+ckSzapooqIFMjBZrGgTou/2Tg
 KX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787925941; x=1788530741;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q5nvjyWQigaJq/X70FSOqlsHb5yUcVYouF+wJkhwBr8=;
 b=IY0qYk+OSVgarVdr4+gymIIVKOgxg+AfFO/YUKNxgEiUnXiSNPeuSsAMCsvoyz4PSI
 +gskEAShtWe+rD5LjqbeJzW5ysQDdkELVILf/+RGC5j6jwpmSPivN9q8zJTvYCZewB2l
 RYo94s5CjkpImwbYLB8GrHaOiN2zBiTDxrI05ifXokxXCpeJf23rVTqK0DQwZN8j1Bo2
 VQ7L64R0r0gQGqJ1Oe8yPcZmp2q6WACKwlv99IX64xykCe1bTXX7hCFDKroMZO0SxM6w
 ZzvC6WT1bsDITjBerVEd21Ev+tPT768EpvcqiTtgTsLq4wrIebBNQ+oP3DOEq/qMvje4
 0uEQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0VaTekKkR6HAhVVzafkZnrJrUkSjVR+0DnA+K5P25KNMf4/RqNdKt1FXEOvLuiEtCuHzRRkYtY1c=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lkSM/4NZ9Kr+X+414gT/ED6tFUkaiHwDIkOrTrBUrmd28KVZaL
 ZIQ7iFwBllHiL0zQG7t6Vwvte6ucWepV/iTgQjCkco8H4oFOxjg3xKEQdRx2UuCxp7HwLXW8lJ9
 8lvajGLG/u3JN+UM03nvKK34W0lMMbt40aUjTqOWo+QtsfwQElOClorU0xYozI+lZdxoSE64=
X-Gm-Gg: AR+sD12QJU8jybxr6PN5bxAExK+9jHQpoV26sVVSlDWL2XilKxz5haS/Tt2M4UPbmmq
 Wtq3lMQ0n18kQZGuqey6pVp1xn/dGeN272idabzBA7Po46FZAN/HQ7A70GPO04F/SRzG3aXn2Dj
 VED73lLCYQ4b7qqcXG34/iJ5mPuxNx53gaWWi7m762YV5cmZmktjCR+em6rwukTt3VIRFPMQ4B+
 NKLYbNoLc7kMrKLrM6yWV6wBDbzMHdY4XFiwQ3iIB91r6LATk2B/3egthFwDvh8DMWhHyJUSety
 D7gR7S0A2uHevpzNiB6Z7HmCECeKXa4tgIDsSuG6md7GA00aeiNWTl0XY8a19QrcXLOsovMO09c
 j5TaBAiFmt724e4a+p6syq4U=
X-Received: by 2002:a05:6102:f9b:b0:778:9e3c:5760 with SMTP id
 ada2fe7eead31-7859946b444mr2147821137.11.1787925940862; 
 Fri, 28 Aug 2026 07:05:40 -0700 (PDT)
X-Received: by 2002:a05:6102:f9b:b0:778:9e3c:5760 with SMTP id
 ada2fe7eead31-7859946b444mr2147768137.11.1787925940211; 
 Fri, 28 Aug 2026 07:05:40 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm3908633f8f.20.2026.08.28.07.05.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:05:39 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:05:03 +0200
Subject: [PATCH RFC/DO NOT MERGE 05/12] dt-bindings: display/msm: hdmi: Add
 Eliza HDMI TX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-drm-msm-hdmi-eliza-v1-5-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 linux-phy@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7950;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=caxf4nP0LYhd5tTHzg34r3IHakvLdeyikIWGEpS/fMo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkZWcR5kCraTeaFlb37qcnOqd4rhI8I3jzoXSI
 zJeI7SgTV6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapGVnAAKCRDBN2bmhouD
 193pD/9Pw8KOp7bE0U7nphpfhHH+pJ5kmrc9xszbAWpknu41CZuqBNzvnIVmI/87O3l04yu+XM/
 nIZXHGSfzXXT3/VCAi/PMq707DZjAL/y39fRt2+ctP614cFbko3erU81p7ojZkGqEcZY6eH8puL
 yIwxHDEmOcdiJR103GYYowj+hBdedNMvx196rHVh9QJ1AMwIOk8llTZVKg4L0VFnBqDUJnutK9S
 Xgy0PldBUDOFC5SdLr6jv5R2vh8zYVbdL+VTvTGcKSKVetvgkW/K0Y25ThXx70xBMpik+W9Udsv
 EubDNTKHwL2qFLFo+Q6L2BwQskm089cA7Q0zTMdJDbZWsa2Yu1LJsbgEPAiOb+f3CMrkiljvidx
 JHfqVQtcfw9wSnxz7v/y5v/l0f67OIvX5a69xWT2Yjafyvjlf4f6FSgfuSxdqEuPmtyMWv9JKC1
 Zu/DbOZAA5Hcecqitowd1arraQY9pdxP0JY95lc9/05K9sqKXvII2XL06xIZ2dJYR3lGAsOltXt
 fDWwLDAgzHskVUCiU4G6IxqCmLSP4qSsg/dgfeOtvBBmR+k7WbFj2+iOoosSwNm9xJEb/u7H+w9
 liGE2Wfk14hL1+/7opR6DhrAsyFy6xiPYGoRh+aEKoFkcTiw7uTLasmvPbgHgjJv6JsXITndgjd
 8AB8HTHR70KHKaQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=6a9195b5 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=U2XnKTW_qBCVAJQLEIUA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: 8MiPD9urQOPwOTUbVfpIYDrPGQ8LeJMJ
X-Proofpoint-GUID: 8MiPD9urQOPwOTUbVfpIYDrPGQ8LeJMJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX/zvo5a1N3D9f
 BIyNK7uyDBJhL3zyst96C8+nW5n0bqFj717XwNxQWGTWzjHwlnjsJdJCE9+hPSMWadO6aqwijJI
 5WJGTMAZrz9WAHRr6focbr2E5BIiNWA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX+cHAa0RCKs3y
 NsQOmWZQshSeThPIN9ECPtCrhL8tsuDZBJYGcUPk9HIj2ayiF0bUHyk5lPXYQFnProz6oWJcj62
 MFMlR/9/+k3lkSwtsioc+lJ4f8J9KUz7+gtHWqQrnGCVUoTeq2NgCB+dGn9l3jmGnu34Tn/Fqi2
 H4C4w5hoVWSBYuXgaaJ80MuuT/g8mBODy2qK3G8d0yy7+0x8S1ejjRwXro3+3U35aCMkw9m4jGE
 MH5plojHLyOVdDLVYYOalWDcZcVA4iKX+TmhjulVAGzE3n9DqJSSGGyck/6UcMmYjjt1WCT5FOQ
 Oml/VicHEqbRwoMSacicel9TeGPxUyOeRozO3Zv9jeDOD8HquDXl7IIc+YFlcjyaSi1U669wY3E
 0UlMf5VEQENfLGRQ9CSmpdvALI4k3lgVl0X7gfurwrSRaPxvTh9AlvcPnxzAaZ8S3exXfaGGSyv
 fZtAE7qeJsYPjUWuH9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280122
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

Qualcomm Eliza SoC comes with HDMI IP block, built on top of one
previously present in MSM8998.  There are just a few differences in
hardware, mostly about handling clock reparenting, but more notable the
old binding looked incomplete, thus devices could not be considered
compatible.  The QFPROM MMIO space is not really part of HDMI, thus do
not include it in the new device support.

Document also VDD IO supply, which is providing power to external 5V
elements, like HPD pull ups.  This is not a suuply for internal HDMI
elements, thus it is valid for older variants as well.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/hdmi.yaml      | 67 ++++++++++++++-
 .../bindings/display/msm/qcom,eliza-mdss.yaml      | 96 +++++++++++++++++++++-
 2 files changed, 158 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/hdmi.yaml b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
index 02d27ccad024..6adaa095b747 100644
--- a/Documentation/devicetree/bindings/display/msm/hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/msm/hdmi.yaml
@@ -20,6 +20,7 @@ properties:
       - qcom,hdmi-tx-8994
       - qcom,hdmi-tx-8996
       - qcom,hdmi-tx-8998
+      - qcom,eliza-hdmi-tx
 
   clocks:
     minItems: 1
@@ -35,10 +36,7 @@ properties:
 
   reg-names:
     minItems: 1
-    items:
-      - const: core_physical
-      - const: qfprom_physical
-      - const: hdcp_physical
+    maxItems: 3
 
   interrupts:
     maxItems: 1
@@ -62,10 +60,21 @@ properties:
   core-vcc-supply:
     description: phandle to VCC supply regulator
 
+  vddio-supply:
+    description: IO (e.g. HPD) supply
+
   hpd-gpios:
     maxItems: 1
     description: hpd pin
 
+  operating-points-v2: true
+
+  opp-table:
+    type: object
+
+  power-domains:
+    maxItems: 1
+
   '#sound-dai-cells':
     const: 1
 
@@ -113,6 +122,12 @@ allOf:
             - const: core
             - const: master_iface
             - const: slave_iface
+        reg-names:
+          minItems: 1
+          items:
+            - const: core_physical
+            - const: qfprom_physical
+            - const: hdcp_physical
         core-vcc-supply: false
 
   - if:
@@ -136,6 +151,12 @@ allOf:
             - const: core
             - const: alt_iface
             - const: extp
+        reg-names:
+          minItems: 1
+          items:
+            - const: core_physical
+            - const: qfprom_physical
+            - const: hdcp_physical
         hdmi-mux-supply: false
 
   - if:
@@ -159,6 +180,44 @@ allOf:
             - const: bus
             - const: mnoc
             - const: iface_mmss
+        reg-names:
+          minItems: 1
+          items:
+            - const: core_physical
+            - const: qfprom_physical
+            - const: hdcp_physical
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcom,eliza-hdmi-tx
+    then:
+      properties:
+        clocks:
+          minItems: 6
+          maxItems: 6
+        clock-names:
+          items:
+            - const: iface
+            - const: core
+            - const: extp
+            - const: phy_iface
+            - const: pll
+            - const: pixel_src
+        reg:
+          minItems: 2
+          maxItems: 2
+        reg-names:
+          items:
+            - const: core_physical
+            - const: hdcp_physical
+        hdmi-mux-supply: false
+
+      required:
+        - core-vcc-supply
+        - core-vdda-supply
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml
index bd4ba91a171f..6f50f7106c8f 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml
@@ -63,13 +63,22 @@ patternProperties:
         contains:
           const: qcom,eliza-dsi-ctrl
 
+  "^hdmi@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,eliza-hdmi-tx
+
   "^phy@[0-9a-f]+$":
     type: object
     additionalProperties: true
     properties:
       compatible:
         contains:
-          const: qcom,eliza-dsi-phy-4nm
+          enum:
+            - qcom,eliza-dsi-phy-4nm
+            - qcom,eliza-hdmi-phy
 
 required:
   - compatible
@@ -79,6 +88,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/clock/qcom,dsi-phy-28nm.h>
+    #include <dt-bindings/clock/qcom,eliza-tcsr.h>
     #include <dt-bindings/clock/qcom,rpmh.h>
     #include <dt-bindings/interconnect/qcom,icc.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -405,6 +415,90 @@ examples:
             vdds-supply = <&vreg_l2b>;
         };
 
+        hdmi@aea0000 {
+            compatible = "qcom,eliza-hdmi-tx";
+            reg = <0x0aea0000 0x1000>,
+                  <0x0aee0000 0x1000>;
+            reg-names = "core_physical",
+                        "hdcp_physical";
+
+            interrupts-extended = <&mdss 8>;
+
+            clocks = <&disp_cc_mdss_hdmi_ahbm_clk>,
+                     <&disp_cc_mdss_hdmi_app_clk>,
+                     <&disp_cc_mdss_hdmi_pclk_clk>,
+                     <&disp_cc_mdss_hdmi_intf_clk>,
+                     <&mdss_hdmi_phy>,
+                     <&disp_cc_mdss_hdmi_pclk_clk_src>;
+            clock-names = "iface",
+                          "core",
+                          "extp",
+                          "phy_iface",
+                          "pll",
+                          "pixel_src";
+
+            operating-points-v2 = <&mdss_hdmi_opp_table>;
+
+            phys = <&mdss_hdmi_phy>;
+            power-domains = <&rpmhpd RPMHPD_CX>;
+            #sound-dai-cells = <1>;
+
+            core-vcc-supply = <&vreg_l2b>;
+            core-vdda-supply = <&vreg_l4b>;
+            vddio-supply = <&hdmi_5p0_reg>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    mdss_hdmi_in: endpoint {
+                        remote-endpoint = <&dpu_intf4_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    mdss_hdmi_out: endpoint {
+                        remote-endpoint = <&hdmi_0_connector_in>;
+                    };
+                };
+            };
+
+            mdss_hdmi_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-150000000 {
+                    opp-hz = /bits/ 64 <150000000>;
+                    required-opps = <&rpmhpd_opp_low_svs_d1>;
+                };
+
+                opp-300000000 {
+                    opp-hz = /bits/ 64 <300000000>;
+                    required-opps = <&rpmhpd_opp_svs>;
+                };
+            };
+        };
+
+        mdss_hdmi_phy: phy@aea1000 {
+            compatible = "qcom,eliza-hdmi-phy";
+            reg = <0x0aea1000 0x1000>;
+
+            clocks = <&disp_cc_mdss_ahb_clk>,
+                     <&tcsr TCSR_HDMI_CLKREF_EN>,
+                     <&bi_tcxo_div2>;
+            clock-names = "iface",
+                          "ref",
+                          "xo";
+
+            #clock-cells = <0>;
+            #phy-cells = <0>;
+            power-domains = <&rpmhpd RPMHPD_CX>;
+        };
+
         displayport-controller@af54000 {
             compatible = "qcom,eliza-dp", "qcom,sm8650-dp";
             reg = <0x0af54000 0x200>,

-- 
2.53.0

