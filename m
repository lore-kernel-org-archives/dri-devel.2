Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A0310F284C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B50410EF17;
	Fri, 27 Mar 2026 16:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="qzaWaLb7";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B9D10EF11
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:12:36 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-660a58841d4so2889479a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1774627955; x=1775232755; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Dq7FZmaEKFcQHlwC/6geG17+uu+aaA5ZxCfFTQLxT+c=;
 b=qzaWaLb7bUlge7ANJs5jWFt9FuF10NF3ooFxc/pPrJsgXz2pwx+uhklEtFIfm+w6K1
 Y28pzI6Zf4jAU+F5T+h4FAdPYHp55hmLTwOLrbdMAXtOuJ31acFS29UPZLTFJm4wC7mp
 P37sB3qyPgHt7HNYX7O6czCzXD7ulA7hP/M2s2g8ugh0PEmGmtkaqTZtHRuYXAG/icBU
 YQkv0UR51r9tt1ob90GS5lu06cvdjrp/X1maKChQaI1uA6jZiLt/X5lIuVWLyt6v6i/C
 RvbLgb5o/MoU51dsgTyA6tv1GR2kyMK92U2yYa+tYzZuB199Qguc+MWaF3tKmoRICoEu
 I67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627955; x=1775232755;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Dq7FZmaEKFcQHlwC/6geG17+uu+aaA5ZxCfFTQLxT+c=;
 b=d/x6kEPe5iBYUB4Z8yk1WY73CJfA3mD6eTAEqQ/EJ3z3GLF1pRR0xPt/U7bHm08Pci
 NWw6NfnKpChh2u7iUsxSyMfkmItzMpjuUje/yufbDmfJl0xDRFiDpeLS8RmHx/CUDxCf
 QQLIHLH9iHtl2Xi02N6qj7nQQddjsbSyyyb0qyS3Dijff4H2gzy2+1bXzKGEBpJev/9X
 ARFQrHOTiNKuuwjhZofzsZNrDWfnlb3rwwiz4627qj903MKgwr8e9ncXd/LVn21mvMpc
 fXryomzwlVzO7KDBTh5ZXQ8SsCK7r7XXeH3aEf3gylK8VKIGTc/E33Pr7/dr7xGLWjXZ
 XywA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnUQXDCf16JBcCFAr/El7x/Z+C8rdgMQAm0+lzR2KXPpWa+agY8Hmcc8llLSUjNetmO+V12ZkDj14=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxa2OzykTsnBMA0ZnzlEK+BJnI8FzHj7EFtNdVd4dnDu6vnfvlB
 8c29krbpgy3su14omb4gdqrilyrdUGVzGHUNcXyLtiEaFJdQdlCBg7j3AbsjHR06IfQ=
X-Gm-Gg: ATEYQzxD+NUO6nOfXWiYT9GGJR50yDsMwA9/6xAsQL/EqbCIr/YW88QZhFLD+GE/Kfm
 e0qiK1X1ay2jKuUe1ZM4c8eitgR5k7HOCXavZIqykEo6rp5CeBPYENZdazKc8/ARQ18fFQcj6IN
 PfS8bW56DiZKEcOQLc0zDU6mPTCcrHkkMHYfzMrYUeRzsXL286UJJXwCwD2vbfIlakl4Cd0qrmI
 +BK6zUP+y7WNGxBb/mwF5TAllqQX7T+2vaoXttz7hFuFkj5Y07qJhu8wEAYawnMYpfZ62qVQIBB
 NqIs6VsBr7kn0EZTkFATV5FxV2TLEkpMfEeGc23pLOFhbWX1t4DUoONIrBZ+T9uMQpqlkb7a9/s
 3y77O8uxBLT+ULOMqrGIF8PzXC2j2Fpbqvaw8WJ4e4tURF8CbSXuvYzjRejLti2oUAXg21fciws
 woe9vq33ZrWRoHgf/+QQ3SrCzEzEJBhsHC45I2loohKQ/CD5bqNJV4FSN2rHq7QZnpSG417nJ1o
 btW+g==
X-Received: by 2002:a17:907:94c2:b0:b97:bc6b:7f21 with SMTP id
 a640c23a62f3a-b9b4fa1aee7mr205959666b.0.1774627955130; 
 Fri, 27 Mar 2026 09:12:35 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b20265cc0sm273518366b.15.2026.03.27.09.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:12:34 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 27 Mar 2026 17:12:23 +0100
Subject: [PATCH v2 4/9] dt-bindings: display: msm: document the Milos
 Mobile Display Subsystem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-milos-mdss-v2-4-bc586683f5ca@fairphone.com>
References: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
In-Reply-To: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Marek <jonathan@marek.ca>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774627949; l=9238;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=KtUn5G2UTlEzF/yc8/MAeH8lYJexJkFm284OdZOtjsA=;
 b=XRBDJr+T4inivP4pCestBgyjauRIBd5h9gxsYU7Sc+onWf6YvnD0LQUjqAApSV7jl/whtAR4E
 eTvFPG0+Te6Co++eRkdMlIQz0g81A6TkBr87kCD7dNRLZzUBawgg1LF
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Document the Mobile Display Subsystem (MDSS) on the Milos SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/display/msm/qcom,milos-mdss.yaml      | 283 +++++++++++++++++++++
 1 file changed, 283 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.yaml
new file mode 100644
index 000000000000..0fb66b4b2742
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,milos-mdss.yaml
@@ -0,0 +1,283 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,milos-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Milos Display MDSS
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description:
+  Milos MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
+  DPU display controller, DSI and DP interfaces etc.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,milos-mdss
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
+        const: qcom,milos-dpu
+
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,milos-dp
+
+  "^dsi@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        items:
+          - const: qcom,milos-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+    properties:
+      compatible:
+        const: qcom,milos-dsi-phy-4nm
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+    #include <dt-bindings/interconnect/qcom,milos-rpmh.h>
+
+    display-subsystem@ae00000 {
+        compatible = "qcom,milos-mdss";
+        reg = <0x0ae00000 0x1000>;
+        reg-names = "mdss";
+
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH 0>;
+
+        clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                 <&gcc GCC_DISP_HF_AXI_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+
+        resets = <&dispcc DISP_CC_MDSS_CORE_BCR>;
+
+        interconnects = <&mmss_noc MASTER_MDP QCOM_ICC_TAG_ALWAYS
+                         &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+                        <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+                         &cnoc_main SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+        interconnect-names = "mdp0-mem",
+                             "cpu-cfg";
+
+        power-domains = <&dispcc DISP_CC_MDSS_CORE_GDSC>;
+
+        iommus = <&apps_smmu 0x1c00 0x2>;
+
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges;
+
+        display-controller@ae01000 {
+            compatible = "qcom,milos-dpu";
+            reg = <0x0ae01000 0x8f000>,
+                  <0x0aeb0000 0x3000>;
+            reg-names = "mdp",
+                        "vbif";
+
+            interrupts-extended = <&mdss 0>;
+
+            clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+                     <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                     <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+                     <&dispcc DISP_CC_MDSS_MDP_CLK>,
+                     <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+            clock-names = "nrt_bus",
+                          "iface",
+                          "lut",
+                          "core",
+                          "vsync";
+
+            assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+            assigned-clock-rates = <19200000>;
+
+            operating-points-v2 = <&mdp_opp_table>;
+
+            power-domains = <&rpmhpd RPMHPD_CX>;
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
+            };
+
+            mdp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-200000000 {
+                    opp-hz = /bits/ 64 <200000000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
+                };
+
+                opp-342000000 {
+                    opp-hz = /bits/ 64 <342000000>;
+                    required-opps = <&rpmhpd_opp_svs>;
+                };
+
+                opp-402000000 {
+                    opp-hz = /bits/ 64 <402000000>;
+                    required-opps = <&rpmhpd_opp_svs_l1>;
+                };
+
+                opp-535000000 {
+                    opp-hz = /bits/ 64 <535000000>;
+                    required-opps = <&rpmhpd_opp_nom>;
+                };
+
+                opp-600000000 {
+                    opp-hz = /bits/ 64 <600000000>;
+                    required-opps = <&rpmhpd_opp_nom_l1>;
+                };
+
+                opp-630000000 {
+                    opp-hz = /bits/ 64 <630000000>;
+                    required-opps = <&rpmhpd_opp_turbo>;
+                };
+            };
+        };
+
+        dsi@ae94000 {
+            compatible = "qcom,milos-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+            reg = <0x0ae94000 0x1000>;
+            reg-names = "dsi_ctrl";
+
+            interrupts-extended = <&mdss 4>;
+
+            clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
+                     <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
+                     <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
+                     <&dispcc DISP_CC_MDSS_ESC0_CLK>,
+                     <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                     <&gcc GCC_DISP_HF_AXI_CLK>;
+            clock-names = "byte",
+                          "byte_intf",
+                          "pixel",
+                          "core",
+                          "iface",
+                          "bus";
+
+            assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
+                              <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
+            assigned-clock-parents = <&mdss_dsi0_phy DSI_BYTE_PLL_CLK>,
+                                     <&mdss_dsi0_phy DSI_PIXEL_PLL_CLK>;
+
+            operating-points-v2 = <&mdss_dsi_opp_table>;
+
+            power-domains = <&rpmhpd RPMHPD_CX>;
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
+                    };
+                };
+            };
+
+            mdss_dsi_opp_table: opp-table {
+                compatible = "operating-points-v2";
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
+            compatible = "qcom,milos-dsi-phy-4nm";
+            reg = <0x0ae95000 0x200>,
+                  <0x0ae95200 0x300>,
+                  <0x0ae95500 0x400>;
+            reg-names = "dsi_phy",
+                        "dsi_phy_lane",
+                        "dsi_pll";
+
+            clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                     <&rpmhcc RPMH_CXO_CLK>;
+            clock-names = "iface",
+                          "ref";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+        };
+    };
+...

-- 
2.53.0

