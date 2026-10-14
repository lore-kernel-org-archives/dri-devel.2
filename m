Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14183CC6B1A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 04:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68EE010FAC1;
	Wed, 14 Oct 2026 04:39:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA3E10FA9F
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:38:39 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69E2MXru3000893
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rSR5yGjst7ree4hGlYQQdXPDFqVHpG+6xoKd0iwANhM=; b=Qzi73vjR5NnEQ8FR
 YZlPtRUAKLOYVmFPCL4xGGdNqmNhKBSLwHz43gf6UEW3lGLPn2nZyWAOCLbL2t8/
 Q2LJJ137RyhB+wP3Gb4ftemTlE5FtwP5vuy2qnUBuxHUuM4j50/jfjHvY6EjSU5A
 IQktWRcUppALZCkni3rliAHt4jBFS7uExGpwj9FOkuuQ9rvvPhyn0CmmIknwmHKL
 QL3jTvmXDydFnDym+CA7ZAx2udOdR7BGfbWUT5werMnBDsRp7WUA1+lXVPKtlR/E
 UiHm50ZE5B0ctJ2HfsYkgLEZDafN3A7R5tcUW4Bcl+Z8QuvVHZ/KPfe+L0nfQYvS
 m//mVw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbet6es-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:38:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5352436cd78so37034391cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 21:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791952718; x=1792557518;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rSR5yGjst7ree4hGlYQQdXPDFqVHpG+6xoKd0iwANhM=;
 b=hVjBdeXHV260cJRI0saXdiisJSuhUecIPH83nkF39tfopFwKU1u4vMS8TbewMJRbQG
 AxIpQTkQkXJYCoY29qcsHNp5bBhy7mvKFm8P4BMEg7yM/fgsA/kaAhXqNE6SgaKwP1xI
 zif1RhKhSRFgdcJuC9X98wVW5jtHajU+PF32NzBu7P4gcWJBMbNF12d6PlPQP+OEA76y
 vziN5CLHaA4kFuwPzWTxWA3XpOi7MyFESJqObM4Mq5xgak48jtqk2xhaydS4ILcZpzaM
 kJtKdlAB/NsnSw/WZalUCUoPuKkHHSUSaMgRrcDHSl8RrhHZW99MKpN6VHaUCSOGFs92
 dKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791952718; x=1792557518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rSR5yGjst7ree4hGlYQQdXPDFqVHpG+6xoKd0iwANhM=;
 b=ipuixkgRZzAvQj4PcWBSOKl8AayuhBFSM91CFMMZ2OAxMYfji57Hjp7mJnrFEQlyqv
 +BV6hmQcJ6ayEitM8LvjclM14ayfUBPqUb3Y9wFn48H/BEQqgj5xHXJSxdGvlyxsvo/C
 8Z3BTko763rfLHvddBz7aBB9dyZ8m+p/Hm50lI4uP6hMPtkfElUXJEpmJAadRA4mp0eG
 z5I5f21bY8OnaUvkQq/8nN/FZcIov0jB0doU1slpiOKpfKcE0zynWUhbyee9lXjX1tAb
 X0fRTGCM1HCGsVFc8aC/MXKkY2B4jJNbl10qNtQ3fZUphLdghVpg9oUNmwpxiZ7dWtd9
 BEEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOf90FtXnuXhW48c18li0gAgWJC0RXzveg/zNz3LPlSaURaAHBdSG7CDa2tT4jlE31Ihx7yTQIqgo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKm0L5g48zqTm5P1BMOwyGiZyvR3T7IALt5w57TW8E7YIZPE0f3
 G+qL+Vlp96YRlfsF9ZX1sCChQExbcm7zUwEsCNzFAtH0Gls+6bPcXykl4Etw8XITriBK0SVoGFe
 CBEpousYeU44xIhYWhwSUmcEW8vpgW/NYBsmkXUAlkeLiPCFP5GWyAlaxynHydUIXseCg464=
X-Gm-Gg: AYBFou1CwOsC2twS72iNjaHqkla9BKYU1/c5e2mXdJ2F8+sRgTwoS4f675AvXOI4NDM
 OHX9AvwuHgMeAptwkQY0ew2WqWszaFQsLnxVSuDU0LVrPqcsHmdtWfaswm8wGAGGSyA8QXesTfz
 dDKhluglxarS4SyF8ZnzV8xn8STnRUJpJSpfro24lItMjSCHDE2go53bhrz4hxrDMp5hXHGh9Hh
 YWVDSqEkaAuMGTIS0UbY5rzC7vck7OlJH2nXwgnXU69ltC6G8SvjW9Q4SIqksI9lLqTuZTvxI1n
 eamg5B90xJBelFCZCejabqMV0C7XLuPWccNr0c3JjVRDx23tFpSDLWWiXbWwD1mCpgMF5HFdf/3
 QqrucSnQWzKcgYUITkfvR2jvDE4Eu9U4eOV9Igvl88/so4xnhrRjs8UIvLuQPUQ==
X-Received: by 2002:a05:622a:e0c8:20b0:535:a5fa:ee0d with SMTP id
 d75a77b69052e-535a5faf24bmr157459071cf.77.1791952717555; 
 Tue, 13 Oct 2026 21:38:37 -0700 (PDT)
X-Received: by 2002:a05:622a:e0c8:20b0:535:a5fa:ee0d with SMTP id
 d75a77b69052e-535a5faf24bmr157458781cf.77.1791952716986; 
 Tue, 13 Oct 2026 21:38:36 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5359b755c35sm116809651cf.15.2026.10.13.21.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 21:38:36 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 12:38:16 +0800
Subject: [PATCH v3 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-msm_gdsc2-v3-1-f1ed69014416@oss.qualcomm.com>
References: <20261014-msm_gdsc2-v3-0-f1ed69014416@oss.qualcomm.com>
In-Reply-To: <20261014-msm_gdsc2-v3-0-f1ed69014416@oss.qualcomm.com>
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
 Abel Vesa <abelvesa@kernel.org>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791952700; l=3637;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=X4t5+8WXSWcDrlOMviadtgvxoJejJH86561bik9TCh4=;
 b=49ZhH3GuWNSITYuhFpsrQO0sphIX9MFQeSGVqv9dWe3wjkgysi/1pwye4t4VUQrYX+P+AfuH5
 mFd/C5RgUbRDD2A4a52jIorXTz6fmjCB2Hp7FlyHpyAomW+eTKXG/U4
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: gVobL42qZo8k1b5B6nlzlRJFWFr9uDJT
X-Proofpoint-GUID: gVobL42qZo8k1b5B6nlzlRJFWFr9uDJT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxOCBTYWx0ZWRfXy++8jsFuq2fY
 FzRPJayJqBx8eUxeN3ndMMYKM+9IYipESy0UKRptBYdtJ0y4ShcnigWuR0zad8K/6pW/9eVHboY
 /Zf0tpba2CB+4CwYVWQUh280O2eDBNq72Is5eKjWaUloigiMfMaMUgZcd2aYm+QFESsGs0gdmsL
 O2HAlSgG7RTMq8lkw+YnFKBJ8MTdxIwpxqDHXiCL3tArPirXIp1BBtXKHXF+aLoC7FCzv9sHEXS
 G7Y1bTbyLig6eUEiTUh3RBn2zg6nJUmBZbYG1RTCDGpoe4gGLg444o2R+tbBLOmhtjwktrKuJwU
 W+8kd/ILyLEdJWMkAdIV46cKeGvDWYyYNXJVr0wyuqK5lMvBWpTt6s5zOGGJmQnb/QU5FQYT8m3
 4dvf24GW8pNz83RN/BILpUB69dJJ49i1O7iqXAPCI16MYEXtJ8Si3TJaPXhpvCmEJIRWhsBl0yc
 ll2cR5pfHKjUxDJXYSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxOCBTYWx0ZWRfX3AAlfHIC4LF7
 rZUFPcRDQH3eEon8Pd2AylJDOqk5+GMpUmM1IJbuNYV04Etogolm9Bxg8Ejya6dk04tYp1QcaA/
 dy//Yw0oqDnc86vFzRWst+SIE2wF4S4=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6acf074e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=vb5kALK8DBTIocmybfAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140018
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

Kaanapali (SM8850) has two display GDSCs. CORE_GDSC supplies shared
MDSS hardware and most of the DPU, while INT2 GDSC supplies the
VIG2/VIG3/DMA5 source pipes. Without INT2 GDSC, these source pipes
remain inaccessible.

Describe CORE and INT2 as power domains of the DPU device, matching
the hardware partitioning. INT2 only supplies DPU-local source pipes,
while CORE also remains attached to the parent MDSS device because it
supplies shared MDSS hardware. DPU performance-state votes on CORE are
propagated through the genpd hierarchy to its parent MMCX domain.

Restrict the two-domain schema to the Kaanapali DPU compatible, so other
platforms sharing qcom,sm8650-dpu.yaml retain the existing single
power-domain constraint.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/dpu-common.yaml | 19 +++++++++++++++++--
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml   |  4 +++-
 .../bindings/display/msm/qcom,sm8650-dpu.yaml       | 21 +++++++++++++++++++++
 3 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
index 3f953aa5e694..19b791a857b5 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
@@ -25,8 +25,7 @@ properties:
   interrupts:
     maxItems: 1
 
-  power-domains:
-    maxItems: 1
+  power-domains: true
 
   operating-points-v2: true
   opp-table:
@@ -53,4 +52,20 @@ required:
   - operating-points-v2
   - ports
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,kaanapali-dpu
+    then:
+      properties:
+        power-domains:
+          minItems: 2
+          maxItems: 2
+    else:
+      properties:
+        power-domains:
+          maxItems: 1
+
 additionalProperties: true
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
index 9f935defd6b1..6d6391970d6b 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
@@ -125,7 +125,9 @@ examples:
 
             operating-points-v2 = <&mdp_opp_table>;
 
-            power-domains = <&rpmhpd RPMHPD_MMCX>;
+            power-domains = <&mdss_gdsc>,
+                            <&mdss_int2_gdsc>;
+            power-domain-names = "core", "int2";
 
             ports {
                 #address-cells = <1>;
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index aa0cf0ec5b93..512143402083 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -61,6 +61,27 @@ required:
   - clocks
   - clock-names
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,kaanapali-dpu
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CORE GDSC power domain
+            - description: INT2 GDSC power domain
+
+        power-domain-names:
+          items:
+            - const: core
+            - const: int2
+
+      required:
+        - power-domain-names
+
 unevaluatedProperties: false
 
 examples:

-- 
2.43.0

