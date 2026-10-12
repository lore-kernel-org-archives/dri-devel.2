Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD28CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:33:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A13310E5D8;
	Mon, 12 Oct 2026 13:33:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F88E10E5D8
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:07 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC0WGb1236888
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AsIDIIxYIR8hxItM65IQFe6k6IyKy2g83EPXzed51Nk=; b=i8d4fHJCUCRRjhFU
 udMdqK7QX6MnG7IxB3TBSkBsvj7P+n1v0JW+chGt76MtXT8WxZJ7mh/8gA5DbX3e
 Rl/og+aqhNgZ6FRnu71+LmuY6jiIJslpw5JvwjUwrt7zf2UC1rwhNuhuBuubivHZ
 xRKimY5M6q6XMOtgZlfo0gCsVP4E/dd/rGjgANqnoSaTQcJYJEf0KF1qY2mEbOZe
 HszRZYU6qLmstTIuVUEo+dx4D2kRDiCR/dOBd+/hpPWCVVaGtY4aLv+Y0ydhIH0k
 Op9SJpNZwEmweliUaUzKzzCn4+KSLUHHds+0jdTy45FKnNDbdzrv1FkXFL92vL6Z
 bjnqDQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j6dk6aa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 13:33:06 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-147be78cd56so8141381c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791811985; x=1792416785;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AsIDIIxYIR8hxItM65IQFe6k6IyKy2g83EPXzed51Nk=;
 b=Zed32lZu7mMjHaIigNByV83LDKbNr8AD+x0dS2SHKWfM2ffRZ20lhLtOI2GxHkJgSl
 fmgUy3yteQ8sbQYVV3O9a/oCXW8Ez8mwlfFZ+rka5SYbiz2NROT5HVKRWLs/Cf2VM3VM
 SFlM5URBzgHm7ytFNYVVDpS6ePMVLyKJPiP0pJKQxUDBzgOGxwU1aHaD2XqTRYWVp/LX
 GL9+D1q16vLJymkEQOdD0M2CbTKpG7qtFXfTjn7f6LTiEK9Hlukw80/IN3fDbUgCLcQe
 D8t5fUlszbeQAk8YKiahAOg7jAXuj02pMo+Ob7sNsX9B6Iacc6gddjlyKeEESBUyWYS2
 zGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791811985; x=1792416785;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AsIDIIxYIR8hxItM65IQFe6k6IyKy2g83EPXzed51Nk=;
 b=BjSmOIh/NhX7yglPPIuYIyD2Bm6g6xcVRXA386xsrNgwMFmyZ25wt8ErnElitN2Zx5
 mfYATLefDgLJPiaE5UFztxStWbGDHtDATBjvdY7rnJ5vtingmRtrXxxV9sqNCQkLy5Lf
 39TJ49ltkbfcA9/vsc6PH2Qwo8Ng6ogutWOyzwQzK6l/eO1QLmdSWNnofMGnEN1v+kkY
 lCqjL67zsVfgNNB4Cuzor5WyU/ej4Ds35Xiffd4VP/Xm/N+xRAMIRAZQftj6SRnmi/BR
 tH/hkHcXj187+ENhWrlzJX5QUjl6o7y8pXUN4CEJzVdxallH/FsY9w24NVl1r2jVx/JN
 AKLA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0WLE7cd06NnzVffnH0/TuGs2nUOf12ZHC9gl0OQy6caiw9G11PfPyr7QQBoM3nrN0laaywwxTTqI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLjI6aETKz+wS/CcbWsaRPR65BNZjJIHWe621ObunRm3+F70u8X
 SSm2UhiYljYiWRCA33nUgxd4E5PlAMIzjy0owz2CbHoSw5jGzvs4JwYDrhbXNLPZFOEtJ1dHqjg
 r7SiWrsTXHS13dhLYfv/tR0kMI5VIaRzNtcGOY5fsVbmekXfVCwFKZ0KjQTKN2Z7XltKhYDA=
X-Gm-Gg: AYBFou2bAZ4ZlFM8tX175CCMSTbv4lovufDju5zZM+D/3vJQ5I0bybV91uxTMt3hjEs
 etPsLwNVHRUXh1Czo7bBJQCXJM6kZDoxbvJTQfRwcAxIc2ESN/mne3LT03E/An69DjViJykn20e
 gGG6j2Rh8SZ9SGABzfE9uIwTSYR6vCUwrTt5n2UKoIkyqjysov+EtXsl4mgPv5MNI1UkST9Pdid
 qPau41bgOlvwe95ruDzx36KT3gUrYyJ2jeqk3FarTPEkAopQaVy+COasVa3RCroyciEBhg90lmp
 QypW0updpJhIEcvNPT2osR0PF/PrCAVATXM4mck7q5k6mWrOiOicqxYiLwVGrQJpE+hGPRy/fS4
 43EQwHtbTK4UzffGEgxEirt5VLog=
X-Received: by 2002:a05:7022:3a86:b0:163:8b44:902c with SMTP id
 a92af1059eb24-16a6250bc98mr13246692c88.17.1791811984853; 
 Mon, 12 Oct 2026 06:33:04 -0700 (PDT)
X-Received: by 2002:a05:7022:3a86:b0:163:8b44:902c with SMTP id
 a92af1059eb24-16a6250bc98mr13246633c88.17.1791811983942; 
 Mon, 12 Oct 2026 06:33:03 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm44740397eec.9.2026.10.12.06.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 06:33:03 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 19:02:13 +0530
Subject: [PATCH v2 03/13] dt-bindings: display/msm: Document Nord MDSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-nord-drv-dt-v2-3-a2ab9af954d2@oss.qualcomm.com>
References: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
In-Reply-To: <20261012-nord-drv-dt-v2-0-a2ab9af954d2@oss.qualcomm.com>
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
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791811948; l=14471;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=PIhvMharehcV8F2KI7CYEOsm1wLJbNBmm8ONnPnEAf4=;
 b=pDbDXOChbVAY54mKsTwyNDKjKrSkbZnG1MU8iMabzXOJGiXRM8w1xxlQZClElSEX4871K/lTy
 eAE+OmFJ6WuD0r7HtIir+xizX9jXGUI45oGlTOYK5FpQpEcFAmpDzI8
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfXyG0YnvKmSxGQ
 vYJJ1qcZGxIDlw3s4DCzuP7W9Pb8bfhIuqHEcBdO0yVxZRPSnFGOgkuJ50JbWb5AyBmVQANSCHU
 AnJ4ZT8IUVG4Q7VXzzNEeYUQMkHQoeGwgd3PaA3kb284QKydRVQZ8ANnb/kHKTshC+xVchoRynx
 ga11UJEXGNUGBk1437na3+ppnZCUj1rUmXyuvNaZGGmPKpYNRnm4JCQdXWSUXgm4ACut5wr5iB9
 2lktETfE3Wq1kyzFy/ncNMPGtHrAEftNu8YjYDnV6SNStgVahMoqXkWsgJ2HvGThQUGMeGkie5X
 0bkxTqgNLMNbkGqGdSUg1NotB40epxcpvt5hDOxdCq1qwDv3AATddYFPXT3L3IVHrGH569Cq9il
 e/p3NsW1D8QLwKWzvKfCOEoBhdeN1TlqfWhwNteBU0EHS+IUJUL26v2RldjHPnws7hS8N1KedIN
 XATlpsRActwbrHE1mJg==
X-Authority-Analysis: v=2.4 cv=aK5lOr9m c=1 sm=1 tr=0 ts=6acce192 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=7d_QaK0HgB4quCyenD8A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: 4b9T_1pVrCVbrruCKHekNuWT6FN7MXco
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MyBTYWx0ZWRfX6h1GLcXaMWnI
 hJsY2MPfOSgedZcSav5KchrG2KZMmOc0KiWASBi5J4j89ovFUJ9QtSsfs5R9nE/SRQJxiX8m5GW
 o6Nd3wkKDznehXFgMWVjjuSKtTZFl6w=
X-Proofpoint-ORIG-GUID: 4b9T_1pVrCVbrruCKHekNuWT6FN7MXco
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120053
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

Nord has a new MDSS 12.1 revision with DPU 1499A and two independent,
DP-only display interface controllers (no DSI), which no existing
schema describes. Add a dedicated qcom,nord-mdss binding to document.

Assisted-by: LLM
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 .../bindings/display/msm/qcom,nord-mdss.yaml       | 396 +++++++++++++++++++++
 1 file changed, 396 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
new file mode 100644
index 000000000000..abd80dae4e7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,nord-mdss.yaml
@@ -0,0 +1,396 @@
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
+    #include <dt-bindings/clock/qcom,nord-dispcc.h>
+    #include <dt-bindings/clock/qcom,nord-nwgcc.h>
+    #include <dt-bindings/clock/qcom,nord-tcsrcc.h>
+    #include <dt-bindings/interconnect/qcom,icc.h>
+    #include <dt-bindings/interconnect/qcom,nord-rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom,rpmhpd.h>
+
+    display-subsystem@ae00000 {
+        compatible = "qcom,nord-mdss";
+        reg = <0x0ae00000 0x1000>;
+        reg-names = "mdss";
+
+        power-domains = <&dispcc0 MDSS_DISP_CC_MDSS_CORE_GDSC>;
+        clocks = <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
+                 <&nwgcc NW_GCC_DISP_0_HF_AXI_CLK>,
+                 <&dispcc0 MDSS_DISP_CC_MDSS_MDP_CLK>;
+        clock-names = "iface", "bus", "core";
+        resets = <&dispcc0 MDSS_DISP_CC_MDSS_CORE_BCR>;
+
+        interconnects = <&mmss_noc MASTER_MDP0 QCOM_ICC_TAG_ALWAYS
+                         &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+                        <&hscnoc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+                         &config_noc SLAVE_DISPLAY_CFG QCOM_ICC_TAG_ACTIVE_ONLY>;
+        interconnect-names = "mdp0-mem", "cpu-cfg";
+
+        interrupts = <GIC_SPI 930 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        iommus = <&apps_smmu_1 0x3e0 0x2>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        display-controller@ae01000 {
+            compatible = "qcom,nord-dpu";
+            reg = <0x0ae01000 0x8f000>,
+                  <0x0aeb0000 0x3000>;
+            reg-names = "mdp", "vbif";
+
+            clocks = <&nwgcc NW_GCC_DISP_0_HF_AXI_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_MDP_LUT_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_MDP_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
+            clock-names = "nrt_bus", "iface", "lut", "core", "vsync";
+
+            assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_VSYNC_CLK>;
+            assigned-clock-rates = <19200000>;
+
+            operating-points-v2 = <&mdp_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    dpu_intf0_out: endpoint {
+                        remote-endpoint = <&mdss_dp0_in>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    dpu_intf4_out: endpoint {
+                        remote-endpoint = <&mdss_dp1_in>;
+                    };
+                };
+            };
+
+            mdp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-300000000 {
+                    opp-hz = /bits/ 64 <300000000>;
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
+                opp-650000000 {
+                    opp-hz = /bits/ 64 <650000000>;
+                    required-opps = <&rpmhpd_opp_turbo>;
+                };
+
+                opp-710000000 {
+                    opp-hz = /bits/ 64 <710000000>;
+                    required-opps = <&rpmhpd_opp_turbo_l1>;
+                };
+            };
+        };
+
+        displayport-controller@af54000 {
+            compatible = "qcom,nord-dp";
+
+            reg = <0xaf54000 0x200>,
+                  <0xaf54200 0x200>,
+                  <0xaf55000 0xc00>,
+                  <0xaf56000 0x400>,
+                  <0xaf57000 0x400>,
+                  <0xaf58000 0x400>,
+                  <0xaf59000 0x400>,
+                  <0xaf5a000 0x600>,
+                  <0xaf5b000 0x600>;
+
+            clocks = <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_INTF_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL1_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL2_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL3_CLK>;
+            clock-names = "core_iface", "core_aux",
+                          "ctrl_link", "ctrl_link_iface",
+                          "stream_pixel", "stream_1_pixel",
+                          "stream_2_pixel", "stream_3_pixel";
+
+            assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_LINK_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL2_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_PIXEL3_CLK_SRC>;
+            assigned-clock-parents = <&dp0_phy 0>,
+                                     <&dp0_phy 1>,
+                                     <&dp0_phy 1>,
+                                     <&dp0_phy 1>,
+                                     <&dp0_phy 1>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <12>;
+
+            phys = <&dp0_phy>;
+            phy-names = "dp";
+
+            operating-points-v2 = <&dp_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            #sound-dai-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    mdss_dp0_in: endpoint {
+                        remote-endpoint = <&dpu_intf0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    mdss_dp0_out: endpoint { };
+                };
+            };
+
+            dp_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-162000000 {
+                    opp-hz = /bits/ 64 <162000000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
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
+        };
+
+        displayport-controller@af5c000 {
+            compatible = "qcom,nord-dp";
+
+            reg = <0xaf5c000 0x200>,
+                  <0xaf5c200 0x200>,
+                  <0xaf5d000 0xc00>,
+                  <0xaf5e000 0x400>,
+                  <0xaf5f000 0x400>,
+                  <0xaf60000 0x400>,
+                  <0xaf61000 0x400>,
+                  <0xaf62000 0x600>,
+                  <0xaf63000 0x600>;
+
+            clocks = <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_AUX_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_LINK_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_LINK_INTF_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL0_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL1_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL2_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL3_CLK>;
+            clock-names = "core_iface", "core_aux",
+                          "ctrl_link", "ctrl_link_iface",
+                          "stream_pixel", "stream_1_pixel",
+                          "stream_2_pixel", "stream_3_pixel";
+
+            assigned-clocks = <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_LINK_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC>,
+                              <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC>;
+            assigned-clock-parents = <&dp1_phy 0>,
+                                     <&dp1_phy 1>,
+                                     <&dp1_phy 1>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <13>;
+
+            phys = <&dp1_phy>;
+            phy-names = "dp";
+
+            operating-points-v2 = <&dp1_opp_table>;
+            power-domains = <&rpmhpd RPMHPD_MMCX>;
+
+            #sound-dai-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    mdss_dp1_in: endpoint {
+                        remote-endpoint = <&dpu_intf4_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    mdss_dp1_out: endpoint { };
+                };
+            };
+
+            dp1_opp_table: opp-table {
+                compatible = "operating-points-v2";
+
+                opp-162000000 {
+                    opp-hz = /bits/ 64 <162000000>;
+                    required-opps = <&rpmhpd_opp_low_svs>;
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
+        };
+
+        dp0_phy: phy@fc3a00 {
+            compatible = "qcom,nord-dp-phy";
+
+            reg = <0xfc3a00 0x1d0>,
+                  <0xfc3200 0x128>,
+                  <0xfc3600 0x128>,
+                  <0xfc3000 0x200>;
+
+            clocks = <&dispcc0 MDSS_DISP_CC_MDSS_DPTX0_AUX_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
+                     <&tcsrcc TCSR_DP_TX_0_CLKREF_EN>;
+            clock-names = "aux", "cfg_ahb", "ref";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            power-domains = <&rpmhpd RPMHPD_MX>;
+        };
+
+        dp1_phy: phy@fc6a00 {
+            compatible = "qcom,nord-dp-phy";
+
+            reg = <0xfc6a00 0x200>,
+                  <0xfc6200 0xd0>,
+                  <0xfc6600 0xd0>,
+                  <0xfc6000 0x1c8>;
+
+            clocks = <&dispcc0 MDSS_DISP_CC_MDSS_DPTX1_AUX_CLK>,
+                     <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
+                     <&tcsrcc TCSR_DP_TX_1_CLKREF_EN>;
+            clock-names = "aux", "cfg_ahb", "ref";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            power-domains = <&rpmhpd RPMHPD_MX>;
+        };
+    };

-- 
2.34.1

