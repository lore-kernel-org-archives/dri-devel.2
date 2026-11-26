Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66173606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BCqu1GYw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NDvAEhfN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C403210F635;
	Thu, 26 Nov 2026 06:29:47 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D456410F61E
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:29:36 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ36Lc61812795
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Y78skdnXDcn/YdXAR0v/cW0FycySwQB/bgImMnR6+To=; b=BCqu1GYwyhMRar90
 F3tVAfRuWe9jmCt7/sQOhllTwblDM5If+TL5KTf3iXNiK7hU/MVyu7VbSjcPHMwL
 cPi0ftAJDIAChGgzV0OXc4+WbMRed9k/hsCfQo3lLZ1uVl6Wmkq5FYQM5hMD4xR2
 /xsoRCDVMkvV/u1sj23elw3ZkA2kT0lieoXFrV7+fP3JCwvWi5EgiUPcSLsfrAcH
 tYW+aiM5m5dvcsSDwO6cEs1Tf+xgdAlYp6xPUxu8//ydVS+FXmIwy5Mg9gIpZCX6
 BdhiriceQrr7W1gtAIzbmOmUz1/UewB1Q1yGA8mQcRMYMl2YBKTSjlIs9TC+vePL
 aE35Yg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ak00wsc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:29:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2f04e19d945so50254945ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795674574; x=1796279374;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y78skdnXDcn/YdXAR0v/cW0FycySwQB/bgImMnR6+To=;
 b=NDvAEhfNeMnbreGXbRKrmG1gUSUW+2fPTomannszWH+IsUEsMvVKNjyMKSMN6Wj8Lc
 rfifZfYqsaK9fhnnoez4vP3pOtvIaSda61fZg6xbFLRKG/akjzCk2cUf7umTrDEvzl3c
 lXZAWni3qLsWJf4vZTWaaUltVSkg8JaPgTn+DQP8dxJiv++R4trPyb4i1ZnhI+4bxl2v
 C/rayxDQhdRit0CHJc/3+qccsBJg0TL3l4a01e6Y8eiBiZH4oGNrHFfquzfkWjYwVECW
 RJY7o0jNWQQ5LpJvmGttoJFmXeu+bmHQglflgNH4kX7ydfcCDR4tD9DeAsqIselw86dE
 tn7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795674574; x=1796279374;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y78skdnXDcn/YdXAR0v/cW0FycySwQB/bgImMnR6+To=;
 b=vesEZS5Amvs34S1jfxQICURZCZ6zBEhVdUIr7F52MS7jqeQJizOQi+D8ctg0qc/5zb
 X4k8PWOlkne6B71OwqFbTXFTT7BOHDEgIudKMuE2PVq34wnJ2GIybmh7eTL8gi2wla3v
 HVkxlL3WQoqbkM2DXm2r75ybKxYOWvhmKUau4EMBdowrmUcf7spsHfdexWz79XrCy0hC
 AUMN4wNdGQ9TtjEKChVvdp6OrA2vN4bER09KncG0LlHeEEJsXEDB/+6fZvt0uRZ+jlws
 43m6iRgtD0Oioy75DHBvAeo2KfAsKFIl0j/PRndDkowEZIZBi1g6nzLFFqvvkoxQBLGV
 Qo/A==
X-Forwarded-Encrypted: i=1;
 AL+hErE/LVi9JYtzqSqyX45Wey7bRjW0xQeLb3aYJlhf7e2KE+6M57SvMfoRGCgOr8g+dD1CYbsYAVVzn08=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/8Uwv015KpM2LyqrDj+Nqi7xlIYVVQXwGVbml1t87f2Z+bw7bx
 3zPGo34CZnmzR5cWE3/vDc+hjIplWBL3MxNubXPvXv+pOOkvIlJbdfUsUUTHpHp68++pi53LV4W
 UeOYkrtphSD3YagL4KMKHrekuk3/RKmzkDeeTx2lmB4odpfEUfdZunF7DhdUm7+GUONqJMNY=
X-Gm-Gg: AZFdTZcGaIKhjD3s6nXi1UA9oBhBTQ9SuwTZjhdTEUDZ/RdKG49WnESp7pg6qhgzJYq
 vS6GOx55qIMLiWSAGz/EnV1YeilB2GBJOIgQA1Pyp8rZGmuNv3Ulqp51QYLMqjjxZw6LrtxUZ6O
 Bi8motDFLDC69Rzpz+rIzljGOoRckahouem7TvdTlSF+ftB1gRG+u38mrNJpjYireJC9wjt/fSi
 WLuKHSlKENecfyWqbHZawS3oOB9/I2pB20ng6R3/BEwidN2KcZsyZu654Z3LPsVQJf6wMXoQn6p
 D7cGtp1M/wTLTvu8FxW29YBcHyPdEQi5x9vI7tVEifvX/u0GKE2ikeHK7Bq2GVv5S74vWyi5zMl
 3y6/eOj+Ris2t6LKkEoT8O7z4dNG0agPRPc9Jfk4JQ3X1Naq1X0ZwzS14AyfJMFgnTPi2jMHoQC
 dXkJE99X+i
X-Received: by 2002:a17:902:d4c7:b0:2f0:4f8a:c166 with SMTP id
 d9443c01a7336-2f04f8ac351mr173957555ad.56.1795674574420; 
 Wed, 25 Nov 2026 22:29:34 -0800 (PST)
X-Received: by 2002:a17:902:d4c7:b0:2f0:4f8a:c166 with SMTP id
 d9443c01a7336-2f04f8ac351mr173957405ad.56.1795674573906; 
 Wed, 25 Nov 2026 22:29:33 -0800 (PST)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2f03f147a9esm97159715ad.72.2026.11.25.22.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 22:29:33 -0800 (PST)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 11:59:09 +0530
Subject: [PATCH v3 01/21] dt-bindings: display: msm: Add Qualcomm DCP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-jshekhar-v3-dcp-v3-1-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Flemin Jose <flemin.jose@oss.qualcomm.com>,
 Mahadevan P <mahap@oss.qualcomm.com>
Cc: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795674555; l=5709;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=U6TxkZ8CuOVRovKLZXYMgwd7nNnUigtqivShqty42v8=;
 b=KuI+bWQmRi9fvCvyVl7QjCUcVdHutgwKIzjrubWNefS9OEYZxBFON3Km5R3thcyiMHA7PXxmT
 WKjkb3y6K+KBYV4YX/BDa3TZ9zBK3HKNHPikgH3FKzcrN91K6c3qPeh
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6b07d1cf cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=odQccb9QLjelfSTPidkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: OpkaEfs4JJzhrBq0U0JoycJmGNy6EAVT
X-Proofpoint-GUID: OpkaEfs4JJzhrBq0U0JoycJmGNy6EAVT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX2mLsglA/LbW/
 9fcsqSL9L+mKlrdVm0oDqXiLgi+UCRldL1gMXkGpIVXH4gKCSgrdf5B827cMiDeu5RN1Dok8l7o
 hWPYr9N2/B1GZgTQ0O3/EgvSwQ6+5+DrJs8FuxS4MxYis5uZM8hmZTKp6ULdABab4c3LxbP5jKI
 V0rOzDNaTQsXta0tnjBgFdi08WXin2qzIH4jUyp9eQnBZkfw6/NdKCIFZ6NVC6If2Ky1Mx0aW1t
 UzVWwgyNyHbVUSS6cy3EuKJMtNh3XxCwb+hWYP5OXym/SSuezoYntzq3cIW6QZiu5MATge3oSFP
 sCCRWN54rnkNafEsS+4Ll9SgUdCaMXhO9QdEFgqZ9bDoTHeQoMw4Fd5mr/gl7Qo6F3euc68Q7vG
 N7FSIJo3W5vgfw2oqtfRwsOEjKFEHH5u7efCnngpzuxVym6GKqfMLbgdzuUVwDt78vJyyZvBGaV
 RuukvoBUxQ/8oEpuatg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyNCBTYWx0ZWRfX2rueJgFNk4gk
 t4j/CMKkrtp64ce28wEJ6svhos2a7+e7tt8555cr2Cdi126dFe9HF3/m6IGwidj/PQkTkSsp9X6
 2zyFBA0R+nUNYgp1CLFF3BGfleV3b/E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_01,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260024
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

Add a binding for the Qualcomm DCP VirtIO display function.
Document the framebuffer IOMMU context, DCP INTF output graph, DSI host
indices, and connections to the external display chain. Firmware-owned
display resources and internal paths are discovered at runtime.

Assisted-by: LLM
Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 159 +++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml
new file mode 100644
index 000000000000..ff7dc4e5c5ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml
@@ -0,0 +1,159 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,dcp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Co-Processor (DCP)
+
+maintainers:
+  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
+
+description: |
+  The Display Co-Processor (DCP) is a firmware-owned display subsystem.
+  Linux communicates with DCP over HFI through VirtIO and does not access
+  display hardware registers directly.
+
+  This node describes the externally connected display graph between DCP
+  INTF outputs and attached DSI panels. It is assigned to the VirtIO device
+  by the Qualcomm transport driver and is not independently enumerated.
+  Firmware capabilities and internal resources, including pipes, mixers,
+  CRTCs, and clocks, are discovered at runtime.
+
+allOf:
+  - $ref: /schemas/virtio/virtio-device.yaml#
+
+properties:
+  compatible:
+    const: virtio,device34
+
+  iommus:
+    maxItems: 1
+    description:
+      SMMU context used by DCP firmware to access GEM framebuffers. This
+      is separate from the HFI transport context specified by the
+      iommus property on the parent DCP transport node.
+      The child context is used for framebuffer DMA performed by DCP
+      firmware, while the parent context is used for VirtIO transport and HFI
+      queue buffers. These contexts represent distinct firmware-visible DMA
+      address spaces and must not be used interchangeably.
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: |
+      DPU INTF output-only ports. The port number matches the firmware INTF
+      index. The corresponding interface@N child has a reg value matching
+      the port number; its protocol-specific child describes the display
+      interface. The graph endpoint itself connects directly to the attached
+      panel. Each INTF index is represented by one interface node, avoiding
+      duplicate reg values when different interface protocols are used.
+      Unused INTF ports are omitted.
+    unevaluatedProperties: false
+    patternProperties:
+      "^port@[0-9a-f]+$":
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+            required:
+              - remote-endpoint
+
+patternProperties:
+  "^interface@[0-9a-f]+$":
+    type: object
+    properties:
+      "#address-cells":
+        const: 1
+      "#size-cells":
+        const: 0
+      reg:
+        maxItems: 1
+        description: DCP INTF index matching the output port.
+    patternProperties:
+      "^dsi@[0-9a-f]+$":
+        type: object
+        allOf:
+          - $ref: /schemas/display/dsi-controller.yaml#
+        properties:
+          reg:
+            maxItems: 1
+            description: DSI host index.
+        required:
+          - reg
+          - "#address-cells"
+          - "#size-cells"
+        unevaluatedProperties: false
+    required:
+      - reg
+      - "#address-cells"
+      - "#size-cells"
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - iommus
+  - "#address-cells"
+  - "#size-cells"
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    display-subsystem {
+        compatible = "virtio,device34";
+        iommus = <&apps_smmu 0x400 0x2>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@1 {
+                reg = <1>;
+                dcp_intf1_out: endpoint {
+                    remote-endpoint = <&panel_dcp_in>;
+                };
+            };
+        };
+
+        interface@1 {
+            reg = <1>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            dsi@0 {
+                reg = <0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                panel@0 {
+                    compatible = "novatek,nt37801";
+                    reg = <0>;
+
+                    vddio-supply = <&vreg_l12b_1p8>;
+                    vci-supply = <&vreg_l13b_3p0>;
+                    vdd-supply = <&display_panel_vdd>;
+                    reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
+
+                    port {
+                        panel_dcp_in: endpoint {
+                            remote-endpoint = <&dcp_intf1_out>;
+                        };
+                    };
+                };
+            };
+        };
+    };

-- 
2.43.0

