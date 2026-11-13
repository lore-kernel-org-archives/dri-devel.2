Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FB60A3813
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 08:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DyEdU7f7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SiaPXUOn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E0C10E776;
	Fri, 13 Nov 2026 08:29:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 859EB10FFF8
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:12 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AD57Ek63616117
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gdIKtbmtt6X34cnhTlk+wlpmiV3qhuoe2c6i221ujkM=; b=DyEdU7f7GlyDYh+a
 O8BQtxysEHUEcsn2AqqSQ/xcpB93svGlwd62z8i4FLWJBIR5oyKOz0TCrtbbSkZk
 +nMtFrdTsE7t8cwCHuWOTe0b+R866kT6i0sHGXqEhjCHOhxJEtQqMOF7wH6slbGh
 Mo5g8XitnqdN15BugPpkkfYUFVyYnvtX6zp/185UIjeSvSfFvhbDjhm9WXnL/UAm
 fMYbF03B5wN8c2iZnFzBfSgyMqKkkQ1sO4Q3PA74Yw4iHJRdtL2Uxjege1mlvMho
 W2IB+nScQIgWCYsHKXadHiVcCdMfZUm6eIngWEkwA7l/nKa77w/ZnJ9IBQC9dV8S
 WenGWA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwh0ajvx7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:29:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-533928ef33aso7616461cf.1
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 00:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794558551; x=1795163351;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gdIKtbmtt6X34cnhTlk+wlpmiV3qhuoe2c6i221ujkM=;
 b=SiaPXUOnN7V8RYbgPs+fcDgbqkoxt6J3q+IJSBKZkAnSIh+aC0DPfMERF7gvgff4y4
 IL4K6piOW6TgPpqPp5dJ0RSQTFMhF6yeZheH7zV5K7Fwv6SCq0gk7UPW2dtfK4ZD2X6I
 1BZVLpBjeRUFo8aMIbX5OtJgGDgZUYxVYGNcQ+axhwNWGtRUbCAdE6iCxLuKFiraNZw+
 F699OwKbbv298JRnc2sTCd6L9pXvaYmVMkQN1v1oNTkQ/DtfF12RpjS4YRhreBLPeiHC
 NgY8jtBW+rmIkoY2rr0xmmCJUYu1BoM9HFCekO+ZKNZkRdskYh+mfF5Wu8DEtzsitg/y
 qZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794558551; x=1795163351;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gdIKtbmtt6X34cnhTlk+wlpmiV3qhuoe2c6i221ujkM=;
 b=aYYOADRH9VD/RqyyBPv8cxtS0n9cLQ3MkklY/cR5eXsJA5PqzB5ODnD+O3T41oWqcj
 qCBqyEsxuZzJDmhlnkpUkmTTw8UQ5tzG/y3X0A6fLGK22qF8Lm8sDbuuL3g2HQzuKgoo
 UnjEmK3yhNiIl8ChZvMDnOFWX1TR1TuyiBeCn8HFgj2o9bYQ+ZuCNnXb4FkZ96Kpu8h3
 5axz2uBcBwsqPfLKQ/noBVjo6QrurMZW64ijLSmNTcr+10L77HSeAQtGIQlo9K3YelH9
 NEemf1uFp1mMpaqiaSGWE3iYBltpyQSrldz8XEhiR7hVLD9DJxqHGZfXzrny/nQy4MNN
 Ddfg==
X-Forwarded-Encrypted: i=1;
 AL+hErG3ZM7ds0ki+FoyY0G/smzMnna625PUvMkrrVKa31ThjkrkNqTYG5tFWD5O5QeKClJhH00BT+eqmJQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/iF2jiq1IUDUDTDqVBJRtmAjFlxQ0Wxo4UqiacSTDeS8THgck4
 MZVheJzuqT7OqdLmRSnpJ1ZgZNYFclTMx9cSIxgi0kDM5UxsH4BnDM+YDteSbKVZPq4shRmR5In
 1yhkabcOzW7gT3TocdWrCwvUfhS3fZBn/0KUa16CRu2eoYC+WU+GpMUgHiF6V/Qz9xpTPOLA=
X-Gm-Gg: AYBFou15v+uiYYQPuXchTT9rB8jzX+mncDxgTFyuDwxauzcRSxfcohv1BJmxnsVGdrr
 K1rzUiY2cXwz429oY9f9N04aAZ6dv670jOPztjhAJfTVgTy0MI+rDbCj53LIN0h9/3O4zahK+p2
 ZAY7Rl1g6GLfspFysXavjFmO06aRBptWqoBaK9UDWPHGNjcS2N3H9Jb6d++LfY+p/uUr8wEFg4s
 mlLx12NboGOOM8bpfTXSA37x+Ha134pZQbo/Lq1pY9gQ715JHp7kP6/tIjLik5Rwy0KVcxfA7L+
 eqQgIQmFbMwurIut35VW0KrhW8F4DvCGd9zNfEQHcOLnEK8ZpfqshGbBIwZdky3EnwT/40usERo
 ryFnkRzYVuYho2ckWkw3bz/M0TJlxvonaLYgedkogqwc8jasstL5CmVSrgRl0ZJdsL9lmk2VlVi
 qq61OhfRDn8zi4sVAD1G78O777DkxqNqkiAlTQ
X-Received: by 2002:ac8:5dcb:0:b0:535:b506:11e8 with SMTP id
 d75a77b69052e-55ac1331525mr31454401cf.0.1794558550524; 
 Fri, 13 Nov 2026 00:29:10 -0800 (PST)
X-Received: by 2002:ac8:5dcb:0:b0:535:b506:11e8 with SMTP id
 d75a77b69052e-55ac1331525mr31454101cf.0.1794558550017; 
 Fri, 13 Nov 2026 00:29:10 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55ad1b13917sm13524491cf.29.2026.11.13.00.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 00:29:09 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 16:28:51 +0800
Subject: [PATCH v6 1/3] dt-bindings: display: msm: Add INT2 GDSC to
 Kaanapali DPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-msm_gdsc2-v6-1-17adbce47220@oss.qualcomm.com>
References: <20261113-msm_gdsc2-v6-0-17adbce47220@oss.qualcomm.com>
In-Reply-To: <20261113-msm_gdsc2-v6-0-17adbce47220@oss.qualcomm.com>
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
 Konrad Dybcio <konradybcio@kernel.org>,
 Del Regno <angelogioacchino.delregno@somainline.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Danila Tikhonov <danila@mainlining.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794558532; l=9575;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=cyZkjCOBijSm7S/CvS/j8M3k40zS+ATYoCyKx4MzWdU=;
 b=jZE/XfoPpWsMgCJBUkQ+f0VREypGPXnvj4gU/SkNdUdDjefLxOw4uKGttbH5hqZKFBohRXRg/
 MLMqxt8Y19+ABQahskwTozUpXBmhOjfSbmpfwSsUnFwGXiWJq0wjltE
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzMyBTYWx0ZWRfX4X1NhuXXXPGy
 uVINQHdmSUBqwMNaWvDfFmLz4czIEwnrJyBS4bSNVgcum/ENJtZ688jFweQOAmO9+jgVTfVR9Vm
 /UPNPOVHf0RLZcVEgm8yhMiwg53I8K8=
X-Proofpoint-GUID: ndlgrVG7uwUS6WNnv1Q2mpGqMFpqec8W
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6af6ca57 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Ghaf3IcVr8FXk-v7bh4A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzMyBTYWx0ZWRfX2R4A/8uYcdGJ
 US9t2DuPszc9JzB6aHMWau4qFJZ5xeJ2/xHAlJlzonVt0Xp7im8hnk1hpdOe79oH1skKOGg+4SX
 P4joKlcKSGODf/1UxrSYzpC2n1fN3BS4LBba0cVO179Tdm6SlB7yjJjO8bz0pqTFx33h27WozTf
 JwMvi1S0bO0LRboW9r6aMPsnyZyEaBn0Pm/1tJmlI1GlmSSbc0rl8YyTGlgBPYFL9d4SaQ/DOe+
 xCPUQkAYXNkVZ0oepfuqPK/DDghaaL/jtdzhBpGs0eF+tdBY9rLapYzfClrgJQTgSGpj6DsZU8s
 kOn8PX0TWo7Z/wJk0zgP+hkZ3M5i5ibsN/93bmHbiR0FYQze8AAcr1aKRH2y9+LCYsnd9d7Zqv4
 NdZluoca4ebtO/jwsIafeyE6Kc2kx+LFoqxkPU/jQ+bcVQweOMcmzN0jz/tUrbLVL0c1mo6ZuUt
 DshZNq6GJVgfj5Iuzzw==
X-Proofpoint-ORIG-GUID: ndlgrVG7uwUS6WNnv1Q2mpGqMFpqec8W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_02,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130033
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Kaanapali (SM8850) has two display GDSCs. CORE_GDSC supplies shared
MDSS hardware and most of the DPU, while INT2 GDSC supplies the
VIG2/VIG3/DMA5 source pipes. Without INT2 GDSC, these source pipes
remain inaccessible.

Describe CORE and INT2 as power domains of the DPU device, matching
the hardware partitioning. INT2 only supplies DPU-local source pipes,
while CORE also remains attached to the parent MDSS device because it
supplies shared MDSS hardware. DPU performance-state votes on CORE are
propagated through the genpd hierarchy to its parent MMCX domain.

Keep the widest valid constraints in dpu-common.yaml, including the
power-domain-names definition, and narrow them in the platform-specific
bindings. Require two domains and their names for Kaanapali, while
retaining the existing single-domain constraint for all other DPU
platforms.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../bindings/display/msm/dpu-common.yaml           |  9 ++++++++-
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml  |  4 +++-
 .../bindings/display/msm/qcom,msm8998-dpu.yaml     |  3 +++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  3 +++
 .../bindings/display/msm/qcom,sc7180-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sc7280-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sc8180x-dpu.yaml     |  3 +++
 .../bindings/display/msm/qcom,sdm845-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sm6115-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sm6150-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sm7150-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sm8150-dpu.yaml      |  3 +++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      | 23 ++++++++++++++++++++++
 13 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
index 3f953aa5e6949..d2a2ffa043ed8 100644
--- a/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dpu-common.yaml
@@ -26,7 +26,14 @@ properties:
     maxItems: 1
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
+
+  power-domain-names:
+    minItems: 1
+    items:
+      - const: core
+      - const: int2
 
   operating-points-v2: true
   opp-table:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
index 9f935defd6b12..6d6391970d6b6 100644
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
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
index d5a64c8a921f1..bded43a34b87d 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,msm8998-dpu.yaml
@@ -15,6 +15,9 @@ properties:
   compatible:
     const: qcom,msm8998-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
index 034d3df8d2470..6c1476a0faaf5 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml
@@ -19,6 +19,9 @@ properties:
           - const: qcom,shikra-dpu
           - const: qcom,qcm2290-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
index 8137618237ce7..3fa0f02f44892 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
@@ -19,6 +19,9 @@ properties:
       - qcom,sm6350-dpu
       - qcom,sm6375-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
index df9ec15ad6c3c..7703d9b017cfc 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-dpu.yaml
@@ -24,6 +24,9 @@ properties:
       - qcom,sm8450-dpu
       - qcom,sm8550-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
index a411126708b80..8e10f9e0d1769 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc8180x-dpu.yaml
@@ -15,6 +15,9 @@ properties:
   compatible:
     const: qcom,sc8180x-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
index dc11fd421a27f..9dafe1d827e13 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-dpu.yaml
@@ -17,6 +17,9 @@ properties:
       - qcom,sdm670-dpu
       - qcom,sdm845-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
index 510eb6c193649..173c2f034241c 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6115-dpu.yaml
@@ -15,6 +15,9 @@ properties:
   compatible:
     const: qcom,sm6115-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: MDP register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
index 8cbf99f9fcba5..b8344ff8895ac 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6150-dpu.yaml
@@ -16,6 +16,9 @@ properties:
   compatible:
     const: qcom,sm6150-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
index c79b2d4428003..8e50942f3e1f2 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
@@ -15,6 +15,9 @@ properties:
   compatible:
     const: qcom,sm7150-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
index a88d22f30a602..b407bc3994620 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8150-dpu.yaml
@@ -17,6 +17,9 @@ properties:
       - qcom,sm8150-dpu
       - qcom,sm8250-dpu
 
+  power-domains:
+    maxItems: 1
+
   reg:
     items:
       - description: Address offset and size for mdp register set
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index aa0cf0ec5b93f..fc19bedfbc0af 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -61,6 +61,29 @@ required:
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
+          minItems: 2
+
+        power-domain-names:
+          minItems: 2
+
+      required:
+        - power-domain-names
+    else:
+      properties:
+        power-domains:
+          maxItems: 1
+
+        power-domain-names: false
+
 unevaluatedProperties: false
 
 examples:

-- 
2.43.0

