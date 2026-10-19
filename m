Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3CCDCCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1893C10E936;
	Mon, 19 Oct 2026 09:57:44 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2274810E93E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:57:32 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so1286851f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792403850; x=1793008650; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pBTLKDknRyoiYDKLKvNdQPQPMYptAQUNMVhu1Fol0ak=;
 b=A8hwkT5L0kuJKDTCZY1u+7Zw+6FAqvO1s8OsENI5KsiixVjV3sMUSfWu5F/h31ocdU
 kyKfGU0vQQIDErGPgPnHf/mNDz/VUDoSBJfbfz7HD4HkjNNlnOvhb8K0Wz6dYgAhzrJq
 oOA74h7BpbiArkGlMeknpw6Vuyfbpob/g6xG8D+L2DoWtdIkjpdhaDpq+QVZarKK7GQ8
 DNNXEbmPxbFeGzy3RoXLhDGDgngWa3+pCnl0DApgPmfbGimwFlsnUoqUjhNTAnu4JWH6
 UAFWGNb24Xzfimc1szm+3oIgDC8ItfPeDPyDS5Kc4GlHoArC8to0CRLv2uPKvPqojVLu
 BEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403850; x=1793008650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pBTLKDknRyoiYDKLKvNdQPQPMYptAQUNMVhu1Fol0ak=;
 b=1amJaSwoTIJaCrFYm030rj18EvJF8iV2dUr87dwfw5RIJbVZl43YCsts89Ipq7yzue
 a/jrZ2XAlB+WZuZ8PCOmyA1aXUU2UT44pGox7IAvEvxIy4Zb8/IR2/gOZ/37vSNQJatk
 8Ef/P50gHYHVLIKpHsdf9cPPbKR7zqwoXjIhBFOXY+w02JV5AeddUPciRXCceQA0RYag
 ileCDfymFoFZ48juGIhFFg8s2qJNnyNprgd/wuqkoXQR0QtEpLmC+CdJ5vql51Fal5b5
 ZiK4b5qaddxfZjCOKm2DbmpBN0t5vqk4R9WTYG1qE+bY8bvzmUiiyG6s9wUDb1bOPanJ
 UYQQ==
X-Gm-Message-State: AFq9FYLv9hPC98ArZVNlvJ/VlWwTf8/JfcTAUGzuxtGluKDxWDLJOXno
 DaUQ+GZGkQtjNfkfK5BCpAMSY5i+2OlLYybx7Z9A31dDlVXODOOG1jvL
X-Gm-Gg: AYBFou1V7U3sNRrYw1HsaVJ+btVenqK93aNSYhk5r6r1hbBXniXum9yJWDc4+pUtfXe
 u8I2pCLToT1dKCeW7uUe9j+EQOs4mdauFZCOWcaHAJuhprNnLS3AMTQDxW1ai9HU2SbaagSDuj2
 ydjNdMbkAADGCoXUKJJHmuTNx97MFbjIRAmkwzTnP+Vo1e8LCNI3rExTUgVj5djsUK7YPWrcN+C
 +S0OTTGZ3OGk44cZbc+PEv237/g4A/lG0cyGSoK+Axh15/9Knv/dNGkGhUtE9GYJJ1skJgBUHDD
 g54+WSWSwVJ7WWt+p9TA6nJFqyu9WMB/AIr5sWKf1/dh/dkl9j1vqn1y9O5ipBAr3rsh5f4EX/m
 /Q+513d2k0GpvukYgp2ap1MvWqs2ZW9CqcnmaT+yIujWm7Bh6gwKu8wNmVWwwnFo/fo4XFPWHEy
 cm0ArMkG6PYX5rhPknnoLK1lOs/V3QdJJezoDPGKeCQAjsAghOWhn9DRqRyYq05i3bqXUfE/7sB
 9hkrFJiVdOKf/T46GY=
X-Received: by 2002:a05:6000:468d:b0:48e:eb:56c5 with SMTP id
 ffacd0b85a97d-48e07bab949mr9616378f8f.8.1792403850324; 
 Mon, 19 Oct 2026 02:57:30 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd500e75sm21740089f8f.42.2026.10.19.02.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:57:28 -0700 (PDT)
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
Subject: [PATCH v3 3/7] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Date: Mon, 19 Oct 2026 12:57:01 +0300
Message-ID: <20261019095705.91062-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019095705.91062-1-clamor95@gmail.com>
References: <20261019095705.91062-1-clamor95@gmail.com>
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
 .../display/tegra/nvidia,tegra-dbi.yaml       | 138 ++++++++++++++++++
 .../display/tegra/nvidia,tegra20-dc.yaml      |  15 ++
 2 files changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.yaml

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.yaml
new file mode 100644
index 0000000000000..ada7b35778933
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.yaml
@@ -0,0 +1,138 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-dbi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvidia Tegra DC based MIPI DBI Type B interface
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
+    description:
+      Device specific set of values used in DC DISP_SPI_INIT_SEQ registers.
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
+  - dc-gpios
+  - rw-gpios
+  - cs-gpios
+  - data-gpios
+  - panel
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dbi {
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
+                    bus-width = <24>;
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
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
index 69be95afd5627..a2b7279a17930 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
@@ -76,6 +76,9 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: A list of phandles of outputs that this display controller can drive.
 
+  dbi:
+    $ref: /schemas/display/tegra/nvidia,tegra-dbi.yaml#
+
   rgb:
     type: object
 
@@ -155,6 +158,18 @@ allOf:
             - const: wind
             - const: wint
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra114-dc
+              - nvidia,tegra124-dc
+              - nvidia,tegra210-dc
+    then:
+      properties:
+        dbi: false
+
 additionalProperties: false
 
 required:
-- 
2.53.0

