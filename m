Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD13CA5FBB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E0F10F1EE;
	Wed, 30 Sep 2026 07:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iNOGK5/R";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3959A10F1E1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:06:02 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ff9642c57so7535825e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790751960; x=1791356760; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c/1eVBfEidkNMnK70z191xNT/a5PNdQYyZi8hBu3u0k=;
 b=iNOGK5/RMIw3/owfmTv0pYneEKGTPYnNNF0eoiHg1Q/ji6FqkrEYHIxcBWO9zenV3b
 ShbIDP48RyzR6QwmKpxhEbk2y/hhPmZZdpgWUN2xw08/R5sz/T4c17p2vORG3iON3SRK
 jyU84tqbaCIjazq72aZjfqP7xnpHJXJLHnX+H7EWpoU1+ChbZvfVTQeWS6ffiUQ8rKtm
 SlAQGMgdkBmtpqkGeKeZ1tyWtIMkwbxLQAfsunK7OuFL/2A0Nu6679Am1YkZGQIkR3TL
 hjHFh4vKwDEAVuiKsRoUmcPPU3LGVRIZf++BIOc0U9EdAP7bNMJ+tG5s1xjqUK05VyK7
 RQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751960; x=1791356760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c/1eVBfEidkNMnK70z191xNT/a5PNdQYyZi8hBu3u0k=;
 b=0XspdXLtZKRwxFhC+AfsXgqccRBvxgnXMxeQZCQ05ICC2+MhleTER+H4jDvSH6jPP6
 nBRI9dsV4rVMUcOsfXvzg9+h6s0v7hgGDCD/bPrA7RgaDv9aP04YnqBjaehcIhTYbBwm
 FeEmWSg3jqFXAmyBEqx2IMLK0W0Y3X76EbPO6ba9ZM/TDxu1ZBbbD8pWdhvOPkj3U3qS
 CyqIWRjNt/rr2s31vgBIq+UAzOoYaLZzvW8XzFiqcmU9ZCbcFl0SADweYM5K8SJziVLj
 sNVJfJt15Sm0bzSQh+A1f/raBbxe/PDLr22h18jD707f2uE3OOZ6Jph2rjpQuMg90bJC
 2Y7A==
X-Gm-Message-State: AFuF++k+iMPVmxUEwghg0WYMUnL2joSVWwii8oNmngdGA00yy/bgwjIX
 QTBXShUQ+raDqDJmLhoIyaFcHdrR+Sy8Pry7uyCc77ZCfDhdjN9QkoYz
X-Gm-Gg: AYBFou0sBsJ8c1U/BKE0Kbfpb+nRWQ+uMvvhrjiE30g773wCMT/S0ksyJo5NKP7YLRu
 ukr3ccNjO4dOtBd4OoumN1PIWCpQwgXvaVI2ln46WdvsJZxSrXxTHSnHxdFE/Z+Xv9PhqGyNCcL
 e1dwnK4oXOXY6PxoNoHgabeTehg3xx7ro9yJMbldKp00d3qgNjj94wXwgHHAKsYXMukOA1d41du
 K+BbR1dUsRar8c/5BMpJzIOp5iPXOVU06/YlxPBtoxDzgfQ42Dfz2QaRm/LI+lTomPkgzyD/eyt
 6OzLP4jkscZOKfazXIfhsgmEiOo1vQudBrNtWHm18c5rL4nwV01vVaejBaGhCug7b7lx6kMa18I
 mvULeX5l2t7T+UTyzBgJaeXVmuH6OlL4PqFjnXd2zKa/KQqyiJtWFlGfEdfz/cUZUHO6hxmxj1N
 mgFo73tvxT6cEDWPvseM5axlUpEpHyG1U3cZUO/Xk7eDIRdsuYBZpp/Ohmvq918o0tsB79YoUXW
 jWV5G2Cs9+FGrmO1Pf0OIoggUYuDQ==
X-Received: by 2002:a05:600c:45c4:b0:4a0:25c:8ad2 with SMTP id
 5b1f17b1804b1-4a01b1aedd0mr5255825e9.9.1790751960356; 
 Wed, 30 Sep 2026 00:06:00 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f5bcdsm1145150f8f.27.2026.09.30.00.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:05:59 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 3/6] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Date: Wed, 30 Sep 2026 10:05:32 +0300
Message-ID: <20260930070535.47130-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930070535.47130-1-clamor95@gmail.com>
References: <20260930070535.47130-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Document 8-bit CPU parallel MIPI DBI Type B interface provided by
Tegra20/30 SoCs display controller.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++++++++++++++
 1 file changed, 138 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8bit-cpu.yaml

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8bit-cpu.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8bit-cpu.yaml
new file mode 100644
index 0000000000000..f0dab608b2936
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8bit-cpu.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-8bit-cpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvidia Tegra DC based MIPI DBI Type B bridge
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description: The display controller in Tegra20/30 SoCs features an
+  8-bit SPI interface that closely resembles the MIPI DBI Type B
+  protocol and is referred to as '8-bit CPU'. Each display controller
+  provides two such interfaces, which can be used to send MIPI DCS
+  commands to initialize and control the panel while image data is
+  transmitted via 16/18/24-line RGB.
+
+properties:
+  compatible:
+    const: nvidia,tegra-8bit-cpu
+
+  dc-gpios:
+    description: Data/command selection pin.
+    maxItems: 1
+
+  rw-gpios:
+    description: Read/write pin.
+    maxItems: 1
+
+  cs-gpios:
+    description: Chip select pin.
+    maxItems: 1
+
+  data-gpios:
+    description: Specifies a set of 8 gpio pins used to transfer data.
+    minItems: 8
+    maxItems: 8
+
+  nvidia,init-sequence:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: Device specific set of values used in DC DISP_SPI_INIT_SEQ
+      registers.
+    minItems: 4
+    maxItems: 4
+
+  panel:
+    type: object
+    description: Node of supported panel driven by the bridge.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: Video port for RGB input.
+
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+            properties:
+              bus-width:
+                enum: [ 16, 18, 24 ]
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for DBI output (panel or connector).
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dbi-bridge {
+        compatible = "nvidia,tegra-8bit-cpu";
+
+        dc-gpios = <&gpio 110 GPIO_ACTIVE_HIGH>;
+        rw-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+        cs-gpios = <&gpio 108 GPIO_ACTIVE_HIGH>;
+
+        data-gpios = <&gpio 32 GPIO_ACTIVE_HIGH>, <&gpio 33 GPIO_ACTIVE_HIGH>,
+                     <&gpio 34 GPIO_ACTIVE_HIGH>, <&gpio 35 GPIO_ACTIVE_HIGH>,
+                     <&gpio 36 GPIO_ACTIVE_HIGH>, <&gpio 37 GPIO_ACTIVE_HIGH>,
+                     <&gpio 38 GPIO_ACTIVE_HIGH>, <&gpio 39 GPIO_ACTIVE_HIGH>;
+
+        nvidia,init-sequence = <0x0000002c 0x0 0x0 0x00005000>;
+
+        panel {
+            compatible = "hit,tx10d07vm0baa";
+
+            reset-gpios = <&gpio 175 GPIO_ACTIVE_LOW>;
+
+            avci-supply = <&vcc_2v8_lcd>;
+            iovcc-supply = <&iovcc_1v8_lcd>;
+
+            backlight = <&backlight>;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&bridge_output>;
+                };
+            };
+        };
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                bridge_input: endpoint {
+                    remote-endpoint = <&dpi_output>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+
+                bridge_output: endpoint {
+                    remote-endpoint = <&panel_input>;
+                };
+            };
+        };
+    };
-- 
2.53.0

