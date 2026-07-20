Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ADF8C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C346C10E81C;
	Mon, 20 Jul 2026 08:44:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="G1Xs86Tj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C7JrXrmZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A9B410E807
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:44:17 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66K7rcjQ2979823
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 39qqxcbfuYiiqBLw2ZuDhkt8UPE0aaVomriT1BAsCCY=; b=G1Xs86TjnUq/HFcZ
 KyT3NY7vZxg+XCo6IFo5fBJgPIWLEXrcrZNTFBePN16omNIzsL33oIumc07jasPc
 5SsH0yJXxr8WJdeHa2o338BbGiSkFX3lpxfABFPWAmbayUbgH5S69gipIfOpV36t
 tv/rzg73S8HoaVvPb2np7gfwMdsN8qhCKDMYCcVNi7eO7z8o4zxHzfOM5FNcEO0t
 tu+APhRvKJfk1akDL2WFw0Db2P6PKt6iXoCG+rTQ/ypODgzG2s7kg/sAbEFHw1xU
 0GUOXhbjcIzKr8NOO3r+/3O5GUojZHrMgb6JX0F7GnON1vJikEGqs9KCUSBEpOUm
 zd+QZg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg0697-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:44:16 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8efe7db1c42so182690186d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784537056; x=1785141856;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=39qqxcbfuYiiqBLw2ZuDhkt8UPE0aaVomriT1BAsCCY=;
 b=C7JrXrmZU6vtgSrkmkpyJkwG83pYJE9ctDSkytXXZ/1o11gKwRTm/lhJ7lLIVhMlIK
 r+kNigEFT2By2B7CR3R+tGGhqj9My/7FEVV6WNh7Id5X3g5uHalRrxftqJYcvwRR4c05
 oTIzphbDHJ8tioLV/YDpDyEGzAZvf/5EJc8xKFbCT6DAIxLCjY4tqlEn6ibueiw9G8mo
 zC2D4G6oV5PTizC2x1efSHbo1CVtmQoA5VQ1K+DADLAczl0rJON5P/4cGOsZ1ve+o+iP
 MlmMTCuly4GNrrFGudC1O0O7oqP/7gdpEkzX0turWHyWmbknvo9aFnV3EpBieFFHyA5q
 rcsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784537056; x=1785141856;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=39qqxcbfuYiiqBLw2ZuDhkt8UPE0aaVomriT1BAsCCY=;
 b=pduEqC0IWxp+IQFaiyRJiEQ94tBL0t8eBS7aevJ97g9ALI/JK6j5jYb8EFrjyGdRMq
 5lhp3Ir6JTHSJs7MAkMV1KqXyqnYTnUJD/Wkawf1srjukAfnZCmUuvULyOhm9D1KFVL5
 vjtoBF7BxA1mnNT2rncCzhlotcYDjcVHMeY5ynIdzRFXfK4HV4aboSEJuj5NOiXwwGAo
 WfllBNImaVB3R8zBfgj5NqgcX2qYSNRnexiLhJaXDLM2KPnbnDkrGQwC7Stzo1l9gql4
 yUlFwpevBqXndTElcy4YtqQIcNTePkcvR7p7jRFkRfsnsfnXqsKRzMNeNBDxeJ+o+O1D
 dBDg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqmnUUit0Sh3rWh9dqYztwA9OFyuSgOok34bF0QJa/3oWlbjwWTSHWWISDse4lVSEX4tYbp+DUJx0c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwHc7XgkBy5XL6LNnUs8ofZZvRwuDdEU+BTlHNELr01gVWMi+z9
 ldUBWLYqTPC9zMIGLSSttV18FBSew2hKUtQHtcS6boTyZyUjUhkZum1hZANm1b9PZdXEDof9xw3
 KbWGmLh4rz+9jfeAmtok6yS+f2enX/vTtQHgabf+3tk2er0s+3DbjedL7A4UVFi2WVwPWkLQ=
X-Gm-Gg: AfdE7cmR7THa5x/FL76nbDn0CAWAy8pCfV1WtpMPyLZ/ImEGPfNOj8ZvViN3p6esrwI
 OFSFApVDdvDLTGzxFEWqzs1SdXFrs9ZXW5DplQeEwJey9gLlJImrFIXSmBetiSXJBKEQ5/ALGD5
 PDym4mTSL/oClnldvLklGmkT/9kqZ4yahfaYHm2sOxZsos3UGWKNGcWS/3nEXoVFOt+MOH6XBXt
 Tdzi/4GHAqqH09ATifV1bTSVh8ukewUi4oEARrfbE5sCwi40StWgKzJ71+i0fC+nXOQBSnhYmdI
 e0a242tHxOGTmsC6IeBt/Ltio7aivJsQCV8tdKJVMXDz7QkhrpQEnzOJTN8W6HBuvFhTOAtzVbW
 TcqPNy/KXZgilneY/zLIAQoKWmXBNLgVk5olZRz8xz0lGU2bv0TT2KntGOkbo8gU=
X-Received: by 2002:a05:6214:5502:b0:8ee:7c26:8bb8 with SMTP id
 6a1803df08f44-907783184bdmr137248106d6.9.1784537055730; 
 Mon, 20 Jul 2026 01:44:15 -0700 (PDT)
X-Received: by 2002:a05:6214:5502:b0:8ee:7c26:8bb8 with SMTP id
 6a1803df08f44-907783184bdmr137247906d6.9.1784537055337; 
 Mon, 20 Jul 2026 01:44:15 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9077871f650sm87061716d6.45.2026.07.20.01.44.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 01:44:14 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:43:53 +0800
Subject: [PATCH 1/3] dt-bindings: display: msm: Allow two MDSS power
 domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-msm_gdsc2-v1-1-4687866d6cb0@oss.qualcomm.com>
References: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
In-Reply-To: <20260720-msm_gdsc2-v1-0-4687866d6cb0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784537040; l=3201;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=/6L2ekPpAxec/7uyCjbq9UCoVdswxCOmDhBbBr2sCa8=;
 b=KY5Qshg6p+4uwwzypEcbJv1/JWBhvrQpn04OPdUBO5ESYEw8Zf/tkYyK8jZI9/2454dUilHaz
 khtp7I3splQAcXdU7lFyliJc/KznWeZhOgii0k3H0vNP/kgfgt/0nn9
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfX6iT0JgBG5ElB
 w28hIRgRjKRHQd+D9nerpD+IdnnaTuwsQQnvuoDbGS02D6WSYWiexBwysDktGzWnORFgt4s5if/
 +dsOmu8zX38tp3lGdbMhTiVYEbDPGh0=
X-Proofpoint-GUID: pdZKPV-_BOfQjaUFz9FMYjhJcO6K_4CZ
X-Proofpoint-ORIG-GUID: pdZKPV-_BOfQjaUFz9FMYjhJcO6K_4CZ
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5ddfe0 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=0Rkz6-gpJEd4cPyUuX0A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5NiBTYWx0ZWRfXx4Im0wQ6Aob9
 qjBhO4kc5WX72TJzp+sz6C5O+1wGVZkAxtsqkILkqPfT9KTWgSTU4bpQxfYXF22TxicQhE9tn+O
 k5TSo33b/4njVgHv/vVMOqyb1yHyX/e4aJMKoTrdPT8/J5HCT5tYjM1QPxAyjP2B6C/nhAAb0IR
 rv7E+OoAOdwoM738aXwWicRLDE2MG+r+XyuME6rkGlJU8igt41ExkIn6hPgnrKIgjvnp+9RVsWd
 5LMurop30Fmxic1Z0Iqg/u8UpHnGcIEpt9IppkYsGDvjzqKoi8skGt9Z8SKkKW/qDsk6EaLa5ts
 9xqbyFGOn3hMMi13qIb3RceHUtsjWFE8HrqUL+rXvjEYjV2MTE4kuUpQg3UTfSL06f5wWkeDUy9
 4l8eFcLDXyOMlmwc0jfsSYqK6De/WE9TFB1jEaJQiVHIMcBkKNCMkjfFfA3nmEUrJZnqsJ1ttYo
 lYGjrDFXZFilJC8NaLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200096
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

Kaanapali (SM8750) and Glymur use two display power domains.
CORE_GDSC powers the main display hardware while INT2_GDSC
powers a subset of SSPP blocks.

Allow the MDSS bindings to describe both power domains and
their corresponding power-domain-names values.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/mdss-common.yaml        |  3 ++-
 .../devicetree/bindings/display/msm/qcom,glymur-mdss.yaml   | 13 ++++++++++++-
 .../bindings/display/msm/qcom,kaanapali-mdss.yaml           | 13 ++++++++++++-
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
index c6305a6e0334..c0b650ffd9ef 100644
--- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
+++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
@@ -31,7 +31,8 @@ properties:
     const: mdss
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 2
 
   clocks:
     minItems: 2
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml
index 64dde43373ac..685bedb26a12 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,glymur-mdss.yaml
@@ -38,6 +38,16 @@ properties:
       - const: mdp0-mem
       - const: cpu-cfg
 
+  power-domains:
+    items:
+      - description: MDSS core GDSC power domain
+      - description: MDSS INT2 GDSC power domain
+
+  power-domain-names:
+    items:
+      - const: core
+      - const: int2
+
 patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
@@ -95,7 +105,8 @@ examples:
 
             resets = <&disp_cc_mdss_core_bcr>;
 
-            power-domains = <&mdss_gdsc>;
+            power-domains = <&mdss_gdsc>, <&mdss_int2_gdsc>;
+            power-domain-names = "core", "int2";
 
             iommus = <&apps_smmu 0x1c00 0x2>;
 
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
index 9f935defd6b1..088010f464c3 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,kaanapali-mdss.yaml
@@ -40,6 +40,16 @@ properties:
       - const: mdp0-mem
       - const: cpu-cfg
 
+  power-domains:
+    items:
+      - description: MDSS core GDSC power domain
+      - description: MDSS INT2 GDSC power domain
+
+  power-domain-names:
+    items:
+      - const: core
+      - const: int2
+
 patternProperties:
   "^display-controller@[0-9a-f]+$":
     type: object
@@ -89,7 +99,8 @@ examples:
                  <&disp_cc_mdss_ahb_swi_clk>;
         resets = <&disp_cc_mdss_core_bcr>;
 
-        power-domains = <&mdss_gdsc>;
+        power-domains = <&mdss_gdsc>, <&mdss_int2_gdsc>;
+        power-domain-names = "core", "int2";
 
         iommus = <&apps_smmu 0x800 0x2>;
 

-- 
2.43.0

