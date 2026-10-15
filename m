Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0B0CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:39:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C07CA1120C7;
	Thu, 15 Oct 2026 07:39:14 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A467D11210A
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:39:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69F3xJZI1640657
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:39:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZvFYLfipcLVoBfHgUOI0+DbMhkvcbOeJfRf3ILufwjg=; b=Sp0POdzVEsBjoQNP
 8f6jOAJL/WtdgOD3Ckr9jQEbcNWxjippVpuLGkN8GrnmW0PJwbbjz/VO+mGoi95R
 v6KGoF4McmZjUrAlk1TNNW6SJACIJ0lq+ByBLtWcKL6fvNuhovzG6ilp3TyTJi/i
 ex7gjLoxdj0zbJugyXyg/1xaF7bH9/AQc/0hOB0fRhAJXnj/ygyWat19gXAGjavc
 6gKKflzz34Vk35v/CaiMdYARezyuQGggthQG9fupNb+zh/EopaNCuEHGMUoYPTc9
 4vH7DsBWefoKBLkVqxILDrSDCp7t4HzfQ+WltAF0JVH6sOYdTaf4a9bjiy+QSi/P
 /fF6Lg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haqdhgt9p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:39:02 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2e9572e892dso5577415ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 00:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792049942; x=1792654742;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZvFYLfipcLVoBfHgUOI0+DbMhkvcbOeJfRf3ILufwjg=;
 b=PExtjDjn71O9rwx2yGw5rBToelGUIcVK6Bg/kpZmILf30I3FHmUEXTb9bMqsGSqoCi
 1xKiof9baB2jNLIlDopsB7zyd9p7YORvEnzmZUrmSNQ0hc0lNrgNwFL9Fg6UICZlwXR+
 Ty0Ly+fL0nqubXjeKEQ0oZnFbYnRMQlJ5vtMbTGvX4vnvCA1ONMINSbx/vxkzKmpaOAd
 +x6k4rX1Iv8/GspNpowj+upvkUIQp8eob6V8sHFpbGVMJb1M8+uEqG8mRBTQKPCd5Tmi
 9YTgl7irJFPCyzW+7QQR4bEu6Ck4ohRWaDu61GfNzefgm34DSSVlacmLTkymJzsmSfcE
 D2cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792049942; x=1792654742;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZvFYLfipcLVoBfHgUOI0+DbMhkvcbOeJfRf3ILufwjg=;
 b=tcscJgzy8+3yaqllrA5cuyeLOohd0XSQ3FT+yEOI6nnIfdogKsa2Vgw21DNz0aYSiV
 TTrFL1B65tZ1ZOYUfXM4zIiHksum5EIywYPWQL9fhd252w6p9OHi+74QMtzZyWWEuffb
 MT5yJMtzQgRzQW99hWPuWYbgMnseFGWdAK1PpA1xQj9wbSy4T7YqmXcX/s9+ObCRoQc3
 FvYB7igqCP34JCuwnz5cjhJc9ahrcca7qa/FZhmJPecoCUaBMGkg2obFkhYW17/s/vDZ
 MST/9IVJrawYWvjAmZj1KQ54pp6+yJjT+bBS75CAVySUdaz/su35hLmbdsUL29AtmvyX
 7BLw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaikxVcFzwn7LC1zUBbZWB1J4PGDzublJlFvWKpy98RD6BM4+XpNjw7fR9mHjAEGLOxu0PNJwIn6I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJkiZRRral970y7b+iZqdnAP7FQVJGxkP8g8n2c1f6dgUkjHpje
 lTpWorLO7UbbJGBHg2jzzkUwqf3Ww5A8PzllFEXrmDwlJzgDigCYtW66ud+P7yGnQwZdQFQGWwS
 kHCBU4OsJ2l5yVa00SZ8Rr+udU9LF2ffphcnsJqCfbY8PXBskrgMkFl1MR4WmycgvP/1nnCg=
X-Gm-Gg: AYBFou1qvC6yl99l8BU0FNzp5N4PmAOj/zp+oLtDM/UAsH9qn5RcPk++LLVK7frjBWc
 zCXHing4LnLBj465wuojbTd/DSYWYDEMlyYL0R7Qe+NtR+Cb7OkVF00wu7uCcTXzxoQIo9rLgsl
 Xbx5G0jm0oWFVR+7SnPdHxGcQ+2SQUGKB1d3N+VRhwoUtBzIm8IwhftfDb6AmWx7+xTS43Lo4JV
 fqjTb3vUAqPB2EMQCqLovNFB/90CdIpXeJl5aaDB0+3wxH4OVRHAS+Wwo5GKudbeqGkP8C5QAsX
 gWb0nTHNR819jgmsUiJGTCrzdDvQ//Sv2MjEn3oj6eXt7CY/iGSjtr71Gu0D5CnFHlj2wRB1Pzk
 tCmu2+Ht2gwabReZ12En45AoCv8OQxShkHws=
X-Received: by 2002:a17:903:3886:b0:2e8:795d:34f5 with SMTP id
 d9443c01a7336-2e8795d4702mr141414255ad.52.1792049942177; 
 Thu, 15 Oct 2026 00:39:02 -0700 (PDT)
X-Received: by 2002:a17:903:3886:b0:2e8:795d:34f5 with SMTP id
 d9443c01a7336-2e8795d4702mr141413985ad.52.1792049941637; 
 Thu, 15 Oct 2026 00:39:01 -0700 (PDT)
Received: from hu-jshekhar-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e944c23f17sm14014825ad.27.2026.10.15.00.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:39:01 -0700 (PDT)
From: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 13:08:21 +0530
Subject: [PATCH 01/13] dt-bindings: display: msm: Add Qualcomm DCP bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-jshekhar-drm-msm-dcp-v1-v1-1-48aad0fe4f72@oss.qualcomm.com>
References: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
In-Reply-To: <20261015-jshekhar-drm-msm-dcp-v1-v1-0-48aad0fe4f72@oss.qualcomm.com>
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
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792049920; l=10253;
 i=jayant.shekhar@oss.qualcomm.com; s=20260925; h=from:subject:message-id;
 bh=TLBJP8SeoQI3wL4Uv+WS/xB5MwIFcnAFu5CR8nc6eYo=;
 b=eNxcsc69Y8Jo5l1qC3TRVrdnDWJBcU/OMw+5y9ixMTGjI+fxA+/LkdFlDxyedlHibtsx/oh5O
 dhzn4+iWQT8Cp5RfMWhA110+xEzgxMYJ+ZO1Bj9kzTMzhXA5UBDSpMk
X-Developer-Key: i=jayant.shekhar@oss.qualcomm.com; a=ed25519;
 pk=saYTwtCCpug4b0Hz0jHFoATgDtdhFVicwMzDJo2z5ZE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfX0QyYsnr44rlJ
 wkR5hLLPaRW340aorF04AqMs41ibO9GbpshZ2Eokx5cRS3btl9Qqkshehswk62KBe7hOHZEQ3AY
 oRie+HeOmHqjGBVkyDO1jeFCKxuG8l3R6lZ4BlJZDcpFBbeUt25KX95KFGzy6LhuWe15ju4o4Mx
 UprEzjZnh6WsaxEcQ6oEk0q45gZJ9EF4iYkOpSadRJbydO9ATDaCFtjDJghkKiS+SI5DOEpVOJk
 jUFl27BugDqAZ29xj17BpFM0YQWZBjHZAvQCn0N3EX9hIKjA6L55Wkh1XNnI9g5eSC4YVuUfWIN
 9tCGZ0+UTi1Pr48WuN3ztrUIzUChzLWZt+KNRA0SkEojSAmEX0VC1uLNtgh3AVVTGL3YQDobbDP
 XB+Sd/nXGZCpKvQyHLtUe/Kh4OJXkRF7UGi+F8eycqQrdcKAOPVexh7HhmeTpQcWYTypoOuHE2w
 Lotd+Hm89XDEGCJeiEQ==
X-Proofpoint-GUID: BV5jfLxZbXdLXiXxbPT7CB2yOFonkwNX
X-Authority-Analysis: v=2.4 cv=DeeCOftW c=1 sm=1 tr=0 ts=6ad08317 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=Mqdkvc8JU3O6ZvK96OYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAzMCBTYWx0ZWRfXzOlNkzCvah3s
 BAsK/AEyyukpcMGPOajLMkcEbRwUMyrFddnAsdIyFuJAqclMSeJEPVb07RFJLcdtrc/6gqE8i1T
 uvwnLwQnvk5020Oa6Tdt9+CkOYf4msU=
X-Proofpoint-ORIG-GUID: BV5jfLxZbXdLXiXxbPT7CB2yOFonkwNX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150030
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

DCP platforms place the display pipeline under firmware control, so Linux
cannot discover display resources through direct register access. The DRM
driver therefore needs device-tree descriptions of the firmware transport,
display topology, IOMMU contexts, and panel connections.

Add bindings for the Qualcomm DCP VirtIO display function, including the
INTF graph and DSI host outputs. Document the framebuffer IOMMU context,
IPCC power-notify mailbox and interrupts, firmware display topology, and
firmware-visible IOVA window supplied by the parent VirtIO-MMIO transport.

Signed-off-by: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Assisted-by: LLM
---
 .../bindings/display/msm/qcom,dcp-dsi.yaml         |  75 +++++++++++++
 .../bindings/display/msm/qcom,dcp-virtio.yaml      | 113 +++++++++++++++++++
 .../devicetree/bindings/display/msm/qcom,dcp.yaml  | 119 +++++++++++++++++++++
 3 files changed, 307 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
new file mode 100644
index 000000000000..f7178c66c09e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-dsi.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,dcp-dsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm DCP DSI host
+
+maintainers:
+  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
+
+description: |
+  A MIPI DSI host exposed by the Qualcomm DCP VirtIO device (see
+  qcom,dcp.yaml). DCP is a firmware protocol shared across multiple
+  Qualcomm SoCs, not specific to any one of them; Hawi is its first
+  platform. The DSI host and its connection to a panel are described
+  using the standard DSI controller and OF graph properties.
+
+allOf:
+  - $ref: /schemas/display/dsi-controller.yaml#
+
+properties:
+  reg:
+    maxItems: 1
+    description: Index of this DSI host among its siblings.
+
+  status: true
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: |
+      port@0: Input from the DCP virtio device's DPU INTF output port.
+      port@1: Output to the attached panel.
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+required:
+  - reg
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    dcp-subsystem {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dsi@0 {
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    dcp_dsi0_in: endpoint {
+                        remote-endpoint = <&dcp_intf1_out>;
+                    };
+                };
+
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
new file mode 100644
index 000000000000..018694310dfb
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp-virtio.yaml
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,dcp-virtio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm DCP VirtIO host
+
+maintainers:
+  - Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
+
+description: |
+  Qualcomm's DCP VirtIO host provides the generic VirtIO-MMIO transport and
+  the host-side IPCC channel used to wake the DCP firmware.
+
+properties:
+  compatible:
+    contains:
+      const: qcom,dcp-virtio
+
+  reg:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+  iommu-ranges:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  interrupts-extended:
+    minItems: 2
+
+  interrupt-names:
+    items:
+      - const: virtio
+      - const: dcp_power_notify_irq
+
+  dma-coherent: true
+
+  mboxes:
+    maxItems: 1
+
+  mbox-names:
+    const: dcp-power-tx
+
+  dcp-subsystem:
+    $ref: qcom,dcp.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts-extended
+  - interrupt-names
+  - iommus
+  - dcp-subsystem
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+
+    virtio@9be8000 {
+        compatible = "qcom,dcp-virtio", "virtio,mmio";
+        reg = <0x09be8000 0x1000>;
+        interrupts-extended = <&intc GIC_ESPI 956 IRQ_TYPE_LEVEL_HIGH>,
+                              <&ipcc 13 5 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "virtio", "dcp_power_notify_irq";
+        iommus = <&apps_smmu 0x15a3 0x0>;
+        iommu-ranges = <0x0 0x84000000 0x0 0x04000000>;
+        dma-coherent;
+        mboxes = <&ipcc 13 5>;
+        mbox-names = "dcp-power-tx";
+
+        dcp-subsystem {
+            compatible = "virtio,device34";
+            iommus = <&apps_smmu 0x400 0x2>;
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@1 {
+                    reg = <1>;
+                    dcp_intf1_out: endpoint {
+                        remote-endpoint = <&dcp_dsi0_in>;
+                    };
+                };
+            };
+
+            dsi@0 {
+                reg = <0>;
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+                        dcp_dsi0_in: endpoint {
+                            remote-endpoint = <&dcp_intf1_out>;
+                        };
+                    };
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml b/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml
new file mode 100644
index 000000000000..0ca00a567e9e
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,dcp.yaml
@@ -0,0 +1,119 @@
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
+  INTF outputs and DSI hosts. Firmware capabilities and internal resources,
+  including pipes, mixers, CRTCs, and clocks, are discovered at runtime.
+
+  The compatible string "virtio,device34" encodes device ID 52 (0x34). It is
+  a provisional local ID pending registration of the DCP HFI VirtIO device.
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
+      iommus property on the parent virtio,mmio node.
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
+      DPU INTF output ports. Port number matches INTF index:
+        port@0: INTF0 (no bridge in this series)
+        port@1: INTF1 -> DSI0
+        port@2: INTF2 -> DSI1
+        port@3: INTF3 (no bridge in this series)
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+      port@2:
+        $ref: /schemas/graph.yaml#/properties/port
+      port@3:
+        $ref: /schemas/graph.yaml#/properties/port
+
+patternProperties:
+  "^dsi@[0-9]+$":
+    $ref: qcom,dcp-dsi.yaml#
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
+    dcp-subsystem {
+        compatible = "virtio,device34";
+
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
+                    remote-endpoint = <&dcp_dsi0_in>;
+                };
+            };
+        };
+
+        dsi@0 {
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    dcp_dsi0_in: endpoint {
+                        remote-endpoint = <&dcp_intf1_out>;
+                    };
+                };
+
+            };
+        };
+    };

-- 
2.43.0

