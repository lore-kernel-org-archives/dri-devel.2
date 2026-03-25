Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C928106B50B
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:17:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F2810E8B9;
	Wed, 25 Mar 2026 12:17:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WL52UEZW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GfYahdTr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF3F10E8AE
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:13 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62PBG2fQ3090924
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DvYYLWhWfjzIYUd3a5Nk0Q+Nm2WxSO1rmYo5uvWd9qA=; b=WL52UEZW4vcAiX+8
 Ggyf4Civ6+Bs8sWN0o8cLrl+9RCi+24uMydaz9RwFtoojBOrYYV676cOnOYYV3Zn
 q+oK4zyed2uEaOECGYiDzQ7pmzYRgntsngBepk2K1mI/EhbQz8I6vyn7X4u2dgTU
 asCbt86wRJjkm/5iorNlVMHvJ5Q8M0sEWaD0vO4V3iuejRboGv7X0xDMAM9VzGYO
 m4aTdIQW/blZBK8DbMSksz8DXn3VEY7YH7Rctgrj9mG0wMoHZYheoSP7U2WrNNZo
 FeqJaOjsV9DaywDf9KhWf4bzSPvyestGnilPVuJiIbYFUGyoBWZehRLVs7u5dELy
 4HWCwQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dmprfk9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 12:17:12 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b3544bc7bso24386121cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 05:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774441032; x=1775045832;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DvYYLWhWfjzIYUd3a5Nk0Q+Nm2WxSO1rmYo5uvWd9qA=;
 b=GfYahdTr0JZWwugqctb5UhouA5RNHRR+9j31EdSj6iBwOUGv98Aw9GZm3MiI7dztfT
 qeNjXcizLtkDa5SKftVeFjjiSXp+Z12T0JynJfPYhPZ2ymptI3LAyXWLLVB4KZD1jKrp
 X7DJNWM8t6bOe/mYAXjcm0KSvudNFtJm+LmxUYiSTQ7u0YTwJ8uKqxh3Xh2gWy74IIJL
 r9i4R7srFyT/sEc9w1P9ZqX1fHzjPG9uelFxGuKeVGJ+9P7jOOd6+S8MndeDD3ltR8HM
 NgO4DiAa04kcqU1bM1qvFDha67RD8sbQn2ltLswbOxbP/X9n3haNPHT4xtqo/n1aRXpU
 ngFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774441032; x=1775045832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DvYYLWhWfjzIYUd3a5Nk0Q+Nm2WxSO1rmYo5uvWd9qA=;
 b=ryTzP7DkMb/7nPPSU/7mc/bOVw3ftzaCeCEgf1MPIFqfCz/f8SN9TN7fht1y12Z+Oq
 oEXSgnREydu4ZwjjoPvryWKc1ZONEMJObRkdwLGd74f8UM2Xal4MxrfYkRry2Dva3C8V
 tjM5kQ/QlChErzQIDPTlYbVRId/ejAu/1SKk3qFU5wLJ6MN2P4sULRp8rPd9Yv5COQ0r
 G9X0ttSkfQnkQnnlvktBG8UqcthZ9ctcQRw9zJ77VmhZxXYvKLX28raVAclO3GtUK/Hj
 QI6ff1ZJ2XOHPLPO/zcDsfG3R/+FIXGklXfG9ympt7cI8vOKmihT0ClYZs0SaAZDv4o+
 QjZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAhgYp5cPUcnUgS2rl6Ekb58PwtyVKM3153n6RwNpJqSSj4oXiuc6L14/vpRL+msiK4iUHm5EvLZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZM2nbanwg4TRGpEv4MeWURVyflZ7MxKutIfGS66ELRvFDrDOg
 Aymgayi2IGx8JSD9E6ljayUtD/Ki1o/P+LJV77/Tww2sCRWCQ0o1ygARhtAICuCBH2MaMjwN0mJ
 u6TtAqT3LrfWUNTJ8rfwz3sUb6zvDrV8t+6OSQ9zmRL4USmNnlimW7hWr4O9wriZI7dfXPQM=
X-Gm-Gg: ATEYQzyLzTXAq8z/cr4z431YdaEIDMsQ1l1I6v7wB55j44PLIA9Z2ofYw12x/9Tgn3/
 MVPRu70ij8NBCj6Pi8tNgitSPQuuHiBl/672vFHay3d42S2DkIO8uFe9AkOOJQrsrVSObEKKOlT
 Q5Zq9Wu5+v7mSxGwoD5ifwND9ExWXEfbyP1a7tYJxaMQx5JSafLARWmjZdPAt4uPj6EoLSAILnq
 L1TMZFL/OHF15qneGa1tzFksmbUxgEi/L5PnlRts1hao+Z0qy12zgZbjIH4ldA4s7+x5SgtOe5f
 Ss6h+FcEUOFJExSJNL8nKoTjU9xqp6Sa5rXV1TpYDWM1LPGGHZrDqfPauhaHYT/dC3jSFYc4DrN
 MFcprwweVuzk8tVkU9IwBELmj2tpF4nOKKI37OiQfaCQt
X-Received: by 2002:ac8:6906:0:b0:509:882:9e7a with SMTP id
 d75a77b69052e-50b80f2ba1fmr44136001cf.70.1774441031342; 
 Wed, 25 Mar 2026 05:17:11 -0700 (PDT)
X-Received: by 2002:ac8:6906:0:b0:509:882:9e7a with SMTP id
 d75a77b69052e-50b80f2ba1fmr44134931cf.70.1774441030584; 
 Wed, 25 Mar 2026 05:17:10 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b8a106339sm6480356f8f.36.2026.03.25.05.17.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 05:17:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Wed, 25 Mar 2026 13:16:46 +0100
Subject: [PATCH v3 5/8] dt-bindings: display/msm: qcom,eliza-mdss: Add
 Eliza SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-drm-display-eliza-v3-5-dc2b2f0c74a2@oss.qualcomm.com>
References: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
In-Reply-To: <20260325-drm-display-eliza-v3-0-dc2b2f0c74a2@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Jonathan Marek <jonathan@marek.ca>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16867;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=EwI/Ilroe2dcZtsTMAQYHEJswLAcBpbqNllMx+9MzZM=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGnD0jOhxtybdiczdXXma1ol1bajlNlEaUIFckM2SCxnT5OWZ
 okCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJpw9IzAAoJEME3ZuaGi4PXsiQP/jqW
 8iwDR+sklJqiSLHRZ+OZit+PWLoWB2r0iqJUX8l78rVlkmKypcKNofL9tjt2j2HfaQO7su/kKyn
 YhxyKcXlrU/o+KeqfoFA7wzLCODrAU8CWIStjt3cqKX/MY7TxijEP/r7Tqv6iY7ysXcJlLOq6uH
 AdSUyfuQihEwLtQ0hYWHOD/8b1T0p6tpLSa8wSgH6VZRJdGiTrcWchX0oHtvQTH3+llX4DT6q2w
 //oXL/XVDPbDqL48qzP+W9+gHMZda1Agt8scvJ2PV7k95zlChyQWpv9oQvN6YwFPSgX/aV92PXo
 doOgm4gH3N2Y6d5rOlxVV3b8kN3J4Y5xxuO9do1PKgulqD0aLJqfrDAzxPLMx1+geQf6zeDdp+V
 QOHWXypb2qt7SaGNIDPlHizW/jWMrDgrl/AZ0aqEwG/b9Z1ISIglwzfd8hC9dmsVg/ff7//lmhN
 wkTpnECKGtBmrCj+rbtX94UU2cIVIsWHJx7igr9Iq8mnvphDR/dVwttGwiyyM0MsNVjTJmJBDHA
 b+n8l6laygsupPZyg9vySXd5cuRwexWu6IV2CPIJ1dDel2hTMBSLIEGC81/t5OOhz7rCWsSECNf
 cjGoi2r1I91n6sVie5vJ/WVBNwzESFh+goRN+d5/WERF11SyUeeTB41NYy1hcG85Y2HErZbbGjm
 AHp2y
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA4NyBTYWx0ZWRfX//C5n1fdLfxw
 EbABcz9oXttlXh221FGjUK1mTK4l8BocVRFS/14RKqNKlVlqe9kUOPBCDHKGd7xMNbx7+ul+VqE
 akNjzipKCQOi76eXzJ1yoH5HgE4aP27noh4AGorn8aQLRLZLQBFFCj3wT8643aHXB7qGPMLQ753
 vZFyQHq6l33diFlYtnjjM/wyGjX8OmTGxftfIH/KfEcRjg3b0bKqS1L7xMTOa2Kvh7urnZQbmei
 9fn5dTzsJl2+y3zgrSAd5Qtevx5GNcW70hEEOV5p5L6Q1EmSHFWfsCXf6mxSpAC89AhdRtv7Hnd
 FxnBuwQU1Lrb+3NA+dg8pbaNCWpF/lNSOGU5a4+/fJR7CXMyzU/9BDRfJ6dLKjsL3gWXA7obFp8
 HIrrNBuq++0CtciW12DJ8OJPJ1hRsIGj3+8pWg3iuSF7vgx4R7ysIJAfakk2SZm/CBZ2uBFTjc3
 2cE371NA1P499z4VdDQ==
X-Proofpoint-GUID: GhAYMoGukougnGMrp9zKr_zWADknlxAm
X-Proofpoint-ORIG-GUID: GhAYMoGukougnGMrp9zKr_zWADknlxAm
X-Authority-Analysis: v=2.4 cv=O7w0fR9W c=1 sm=1 tr=0 ts=69c3d248 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=wHLdSD0nsKlegPJtv6gA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250087
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

Add MDSS/MDP display subsystem for Qualcomm Eliza SoC, being overall a
minor revision change against SM8750, but coming with few different
components, like different DSI PHY, missing DP1 and added HDMI.

The binding does not include HDMI description yet.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Fix build by decoupling from headers.
---
 .../bindings/display/msm/qcom,eliza-mdss.yaml      | 494 +++++++++++++++++++++
 1 file changed, 494 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml
new file mode 100644
index 000000000000..47938d13d1ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,eliza-mdss.yaml
@@ -0,0 +1,494 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,eliza-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Eliza SoC Display MDSS
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description:
+  Eliza SoC Mobile Display Subsystem (MDSS) encapsulates sub-blocks like DPU
+  display controller, DSI and DP interfaces etc.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,eliza-mdss
+
+  clocks:
+    items:
+      - description: Display AHB
+      - description: Display hf AXI
+      - description: Display core
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
+        contains:
+          const: qcom,eliza-dpu
+
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        contains:
+          const: qcom,eliza-dp
+
+  "^dsi@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        contains:
+          const: qcom,eliza-dsi-ctrl
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        contains:
+          const: qcom,eliza-dsi-phy-4nm
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,dsi-phy-28nm.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy-qcom-qmp.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    display-subsystem@ae00000 {
+        compatible = "qcom,eliza-mdss";
+        reg = <0x0ae00000 0x1000>;
+        reg-names = "mdss";
+        ranges;
+
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+
+        clocks = <&disp_cc_mdss_ahb_clk>,
+                 <&gcc_disp_hf_axi_clk>,
+                 <&disp_cc_mdss_mdp_clk>;
+
+        resets = <&disp_cc_mdss_core_bcr>;
+
+        interconnects = <&mmss_noc_master_mdp QCOM_ICC_TAG_ALWAYS
+                         &mc_virt_slave_ebi1 QCOM_ICC_TAG_ALWAYS>,
+                        <&gem_noc_master_appss_proc QCOM_ICC_TAG_ACTIVE_ONLY
+                         &config_noc_slave_display_cfg QCOM_ICC_TAG_ACTIVE_ONLY>;
+        interconnect-names = "mdp0-mem",
+                             "cpu-cfg";
+
+        power-domains = <&mdss_gdsc>;
+
+        iommus = <&apps_smmu 0x800 0x2>;
+
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        mdss_mdp: display-controller@ae01000 {
+            compatible = "qcom,eliza-dpu";
+            reg = <0x0ae01000 0x93000>,
+                  <0x0aeb0000 0x2008>;
+            reg-names = "mdp",
+                        "vbif";
+
+            interrupts-extended = <&mdss 0>;
+
+            clocks = <&gcc_disp_hf_axi_clk>,
+                     <&disp_cc_mdss_ahb_clk>,
+                     <&disp_cc_mdss_mdp_lut_clk>,
+                     <&disp_cc_mdss_mdp_clk>,
+                     <&disp_cc_mdss_vsync_clk>;
+            clock-names = "nrt_bus",
+                          "iface",
+                          "lut",
+                          "core",
+                          "vsync";
+
+            assigned-clocks = <&disp_cc_mdss_vsync_clk>;
+            assigned-clock-rates = <19200000>;
+
+            operating-points-v2 = <&mdp_opp_table>;
+
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    dpu_intf1_out: endpoint {
+                        remote-endpoint = <&mdss_dsi0_in>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    dpu_intf2_out: endpoint {
+                        remote-endpoint = <&mdss_dsi1_in>;
+                    };
+                };
+
+                port@2 {
+                    reg = <2>;
+
+                    dpu_intf0_out: endpoint {
+                        remote-endpoint = <&mdss_dp0_in>;
+                    };
+                };
+            };
+
+            mdp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-150000000 {
+                    opp-hz = /bits/ 64 <150000000>;
+                    required-opps = <&rpmhpd_opp_low_svs_d1>;
+                };
+
+                opp-207000000 {
+                    opp-hz = /bits/ 64 <207000000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
+                };
+
+                opp-342000000 {
+                    opp-hz = /bits/ 64 <342000000>;
+                    required-opps = <&rpmhpd_opp_svs>;
+                };
+
+                opp-417000000 {
+                    opp-hz = /bits/ 64 <417000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+
+                opp-532000000 {
+                    opp-hz = /bits/ 64 <532000000>;
+                    required-opps = <&rpmhpd_opp_nom>;
+                };
+
+                opp-600000000 {
+                    opp-hz = /bits/ 64 <600000000>;
+                    required-opps = <&rpmhpd_opp_nom_l1>;
+                };
+
+                opp-660000000 {
+                    opp-hz = /bits/ 64 <660000000>;
+                    required-opps = <&rpmhpd_opp_turbo>;
+                };
+            };
+        };
+
+        dsi@ae94000 {
+            compatible = "qcom,eliza-dsi-ctrl", "qcom,sm8750-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+            reg = <0x0ae94000 0x400>;
+            reg-names = "dsi_ctrl";
+
+            interrupts-extended = <&mdss 4>;
+
+            clocks = <&disp_cc_mdss_byte0_clk>,
+                     <&disp_cc_mdss_byte0_intf_clk>,
+                     <&disp_cc_mdss_pclk0_clk>,
+                     <&disp_cc_mdss_esc0_clk>,
+                     <&disp_cc_mdss_ahb_clk>,
+                     <&gcc_disp_hf_axi_clk>,
+                     <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>,
+                     <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
+                     <&disp_cc_esync0_clk>,
+                     <&disp_cc_osc_clk>,
+                     <&disp_cc_mdss_byte0_clk_src>,
+                     <&disp_cc_mdss_pclk0_clk_src>;
+            clock-names = "byte",
+                          "byte_intf",
+                          "pixel",
+                          "core",
+                          "iface",
+                          "bus",
+                          "dsi_pll_pixel",
+                          "dsi_pll_byte",
+                          "esync",
+                          "osc",
+                          "byte_src",
+                          "pixel_src";
+
+            operating-points-v2 = <&mdss_dsi_opp_table>;
+
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            phys = <&mdss_dsi0_phy>;
+            phy-names = "dsi";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    mdss_dsi0_in: endpoint {
+                        remote-endpoint = <&dpu_intf1_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    mdss_dsi0_out: endpoint {
+                        remote-endpoint = <&panel0_in>;
+                        data-lanes = <0 1 2 3>;
+                    };
+                };
+            };
+
+            mdss_dsi_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-140630000 {
+                    opp-hz = /bits/ 64 <140630000>;
+                    required-opps = <&rpmhpd_opp_low_svs_d1>;
+                };
+
+                opp-187500000 {
+                    opp-hz = /bits/ 64 <187500000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
+                };
+
+                opp-300000000 {
+                    opp-hz = /bits/ 64 <300000000>;
+                    required-opps = <&rpmhpd_opp_svs>;
+                };
+
+                opp-358000000 {
+                    opp-hz = /bits/ 64 <358000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+            };
+        };
+
+        mdss_dsi0_phy: phy@ae95000 {
+            compatible = "qcom,eliza-dsi-phy-4nm", "qcom,sm8650-dsi-phy-4nm";
+            reg = <0x0ae95000 0x200>,
+                  <0x0ae95200 0x280>,
+                  <0x0ae95500 0x400>;
+            reg-names = "dsi_phy",
+                        "dsi_phy_lane",
+                        "dsi_pll";
+
+            clocks = <&disp_cc_mdss_ahb_clk>,
+                     <&bi_tcxo_div2>;
+            clock-names = "iface",
+                          "ref";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            vdds-supply = <&vreg_l2b>;
+        };
+
+        dsi@ae96000 {
+            compatible = "qcom,eliza-dsi-ctrl", "qcom,sm8750-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+            reg = <0x0ae96000 0x400>;
+            reg-names = "dsi_ctrl";
+
+            interrupts-extended = <&mdss 5>;
+
+            clocks = <&disp_cc_mdss_byte1_clk>,
+                     <&disp_cc_mdss_byte1_intf_clk>,
+                     <&disp_cc_mdss_pclk1_clk>,
+                     <&disp_cc_mdss_esc1_clk>,
+                     <&disp_cc_mdss_ahb_clk>,
+                     <&gcc_disp_hf_axi_clk>,
+                     <&mdss_dsi1_phy DSI_PIXEL_PLL_CLK>,
+                     <&mdss_dsi1_phy DSI_BYTE_PLL_CLK>,
+                     <&disp_cc_esync1_clk>,
+                     <&disp_cc_osc_clk>,
+                     <&disp_cc_mdss_byte1_clk_src>,
+                     <&disp_cc_mdss_pclk1_clk_src>;
+            clock-names = "byte",
+                          "byte_intf",
+                          "pixel",
+                          "core",
+                          "iface",
+                          "bus",
+                          "dsi_pll_pixel",
+                          "dsi_pll_byte",
+                          "esync",
+                          "osc",
+                          "byte_src",
+                          "pixel_src";
+
+            operating-points-v2 = <&mdss_dsi_opp_table>;
+
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            phys = <&mdss_dsi1_phy>;
+            phy-names = "dsi";
+
+            vdda-supply = <&vreg_l4b>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    mdss_dsi1_in: endpoint {
+                        remote-endpoint = <&dpu_intf2_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    mdss_dsi1_out: endpoint {
+                        remote-endpoint = <&panel1_in>;
+                        data-lanes = <0 1 2 3>;
+                    };
+                };
+            };
+        };
+
+        mdss_dsi1_phy: phy@ae97000 {
+            compatible = "qcom,eliza-dsi-phy-4nm", "qcom,sm8650-dsi-phy-4nm";
+            reg = <0x0ae97000 0x200>,
+                  <0x0ae97200 0x280>,
+                  <0x0ae97500 0x400>;
+            reg-names = "dsi_phy",
+                        "dsi_phy_lane",
+                        "dsi_pll";
+
+            clocks = <&disp_cc_mdss_ahb_clk>,
+                     <&rpmhcc RPMH_CXO_CLK>;
+            clock-names = "iface",
+                          "ref";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            vdds-supply = <&vreg_l2b>;
+        };
+
+        displayport-controller@af54000 {
+            compatible = "qcom,eliza-dp", "qcom,sm8650-dp";
+            reg = <0xaf54000 0x104>,
+                  <0xaf54200 0xc0>,
+                  <0xaf55000 0x770>,
+                  <0xaf56000 0x9c>,
+                  <0xaf57000 0x9c>;
+
+            interrupts-extended = <&mdss 12>;
+
+            clocks = <&disp_cc_mdss_ahb_clk>,
+                     <&disp_cc_mdss_dptx0_aux_clk>,
+                     <&disp_cc_mdss_dptx0_link_clk>,
+                     <&disp_cc_mdss_dptx0_link_intf_clk>,
+                     <&disp_cc_mdss_dptx0_pixel0_clk>,
+                     <&disp_cc_mdss_dptx0_pixel1_clk>;
+            clock-names = "core_iface",
+                          "core_aux",
+                          "ctrl_link",
+                          "ctrl_link_iface",
+                          "stream_pixel",
+                          "stream_1_pixel";
+
+            assigned-clocks = <&disp_cc_mdss_dptx0_link_clk_src>,
+                              <&disp_cc_mdss_dptx0_pixel0_clk_src>,
+                              <&disp_cc_mdss_dptx0_pixel1_clk_src>;
+            assigned-clock-parents = <&usb_dp_qmpphy QMP_USB43DP_DP_LINK_CLK>,
+                                     <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>,
+                                     <&usb_dp_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
+
+            operating-points-v2 = <&dp_opp_table>;
+
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
+            phy-names = "dp";
+
+            #sound-dai-cells = <0>;
+
+            dp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-192000000 {
+                    opp-hz = /bits/ 64 <192000000>;
+                    required-opps = <&rpmhpd_opp_low_svs_d1>;
+                };
+
+                opp-270000000 {
+                    opp-hz = /bits/ 64 <270000000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
+                };
+
+                opp-540000000 {
+                    opp-hz = /bits/ 64 <540000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+
+                opp-810000000 {
+                    opp-hz = /bits/ 64 <810000000>;
+                    required-opps = <&rpmhpd_opp_nom>;
+                };
+            };
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    mdss_dp0_in: endpoint {
+                        remote-endpoint = <&dpu_intf0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    mdss_dp0_out: endpoint {
+                        data-lanes = <0 1 2 3>;
+                        remote-endpoint = <&usb_dp_qmpphy_dp_in>;
+                        link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.51.0

