Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E499CCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2701F10ED0A;
	Wed, 13 May 2026 07:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OCzL/z1p";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2FC10E0F6
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:51:54 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-8353ca0f1f1so1958086b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 00:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778485914; x=1779090714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fz3/iPbkPkVJpg+21eyeyZQXc8fO7eG+LOXjZ7wm054=;
 b=OCzL/z1pQ9mIjQmwrb9faHfZxSF2/bEqhdMjHM6Rhmygbxi/zQfetQowoUuxScsMXq
 kKN3bgc+4JG9R8ne0Fa9UXczRq332rP8Sy/XFJqbU8aXlesPsAS8wZ3FScQa4Yb+GPep
 NTm1ERo5IlU4qrqFrWy0nxaxQu9wuSx0nWhs+l1pvzlHLnt/I8bVi2B60lDMAyPvYdyP
 FtNG/6TSyXENJJdn8EbUiymzj+wHfaOwExOvDk9qpS8I0R8PT4fBx75YOK/tmFodNtss
 fqDdmlDt59VIONBz1jxhgGkRKYuK+t/5Zr7f3nhld5MHyhoJrVSG4YK/UjBLyqg6Ryvc
 EMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778485914; x=1779090714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fz3/iPbkPkVJpg+21eyeyZQXc8fO7eG+LOXjZ7wm054=;
 b=B3mf78+T8RcgrHTGaFVlUlmObVECvoWt8iwJDvLy4bqlLXC5yvXNAx7JhEAUfX9uLq
 46r/8fnCZ3cLHBH55PqzqVPbxAsXwFpttZ6TUi2JGd461rQ6AK2riu5alPZ8Gapn9J9F
 6hGSmBCQEA+TE0ZV+QUPH2AfpaFY3Sb4lWhHntMuOVzv/CENGql5JT6igXo9mNE9iqwP
 yIM2gRSNIvUdQ9Xd4qBfwc9Mv44zEwNIAyrxDYrb979XqQbU1PP6Elw4jqStzxvCrs8N
 6YyydcA+958cwiINs7kilfAK9JKKHvUmfjsER02JfZ7RDkWnCQ4IyrXafQsXnPfovAoR
 kP0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iQYBnhmaoJxtv45kAZ2hg6X2rT1IiJSbrgCwK3yUkSPADihvCpjazns9KzM8IM1jOGAOO8QqrjlA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx40d+iRvweXiChk1vrmEoBBfsEykGy0Gsb9oU85IMj5GzQHrpe
 2/f8uCuT88anM9pn1MzjNJ+PEI2yo+Mu9a5aTRKPe6QsUk5ERenyZY7l
X-Gm-Gg: Acq92OGQ+JE219FH4MK7Wv2wSOZm7UVwqwxXwzm+GJVr7twjRHBVBVMOAbHSRPqOrqr
 16mUpar2JENlOSgnkGYYNcIrubSx1Qek/svQBuQfWDcHCVUmuOKhWXdNtzUlnfRp1JBBQUEAXHi
 vtk2ZMDH2/c2GYrdsstfiA0Vi9rAXNNoM7CcJKBlVdd1e5fhVADY4nEk4pxC9u7fBEtIvzkG7nF
 uOiBgy6TRmkBS70aZoWumOAiVmyIrB+QG7afefq1JmK4l/8qrP/On3msVVFBOD7QtQKFw1/+XhG
 0f9qp+Wogks8TvIjkm27SAP4YVpem2xvRE61RFyCz5W9apahibsS1yvLNvve/gc5HIueLxb4dzY
 reLOeZnTPDDfWayrZFsVDIGKIdmgDaTMwWCo9EYvziH6j6W9v40gtmQruFinym8cqutu6K1cXo2
 XI2K4a67q6oL+f/J+42cEjiWMcjGZkSkHso5tU68tvxLxpps8gbZLQW87XyWt4FKbbNtATLByCS
 LCbtiuofOxv
X-Received: by 2002:a05:6a00:2304:b0:837:8a0c:8f70 with SMTP id
 d2e1a72fcca58-83bb8691c49mr14478252b3a.28.1778485913610; 
 Mon, 11 May 2026 00:51:53 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965d36a12sm17694642b3a.27.2026.05.11.00.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 00:51:53 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH 1/2] dt-bindings: display: verisilicon,
 dc: generalize for DCUltra Lite variant
Date: Mon, 11 May 2026 15:51:41 +0800
Message-ID: <20260511075142.54752-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511075142.54752-1-a0987203069@gmail.com>
References: <20260511075142.54752-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

Extend the verisilicon,dc base schema to accommodate the Nuvoton MA35D1
DCUltra Lite (a previous generation of the DC8000 series) which has a
different clock topology, no reset control, and a single output.

- Replace the fixed clock/reset item lists with minItems/maxItems ranges
  so sub-schemas can enforce variant-specific constraints
- Add a 'port' property (single-port alias) alongside the existing 'ports'
  for single-output variants
- Remove the mandatory 'ports' requirement from the base schema; sub-schemas
  shall enforce their own port topology
- Add a 'select' stanza so the validator matches any node whose compatible
  contains a known Verisilicon DC string, including SoC-specific glue
- Relax additionalProperties to allow unevaluatedProperties enforcement in
  sub-schemas
- Fix a minor whitespace issue in the port@0 description

Add nuvoton,ma35d1-dcu.yaml as a sub-schema for the Nuvoton MA35D1 DCUltra
Lite display controller:

The Nuvoton MA35D1 integrates the Verisilicon DCUltra Lite display
controller. It is a single-output display controller with a 32-bit
RGB (DPI) interface. Unlike the DC8000, it does not have discoverable
chip identity registers, does not support the CONFIG_EX commit path,
and uses dedicated IRQ status/enable registers at offsets 0x147C/0x1480.
The clock topology uses two clocks (bus gate and pixel divider) and
does not require explicit reset control from the driver.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../bindings/display/nuvoton,ma35d1-dcu.yaml  | 94 +++++++++++++++++++
 .../bindings/display/verisilicon,dc.yaml      | 64 +++++++------
 2 files changed, 131 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/nuvoton,ma35d1-dcu.yaml

diff --git a/Documentation/devicetree/bindings/display/nuvoton,ma35d1-dcu.yaml b/Documentation/devicetree/bindings/display/nuvoton,ma35d1-dcu.yaml
new file mode 100644
index 000000000000..9279004ae27c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/nuvoton,ma35d1-dcu.yaml
@@ -0,0 +1,94 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/nuvoton,ma35d1-dcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuvoton MA35D1 DCUltra Lite display controller
+
+maintainers:
+  - Joey Lu <yclu4@nuvoton.com>
+
+description:
+  The Nuvoton MA35D1 integrates the Verisilicon DCUltra Lite display
+  controller. It is a single-output display controller with a 32-bit
+  RGB (DPI) interface.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - nuvoton,ma35d1-dcu
+  required:
+    - compatible
+
+allOf:
+  - $ref: http://devicetree.org/schemas/display/verisilicon,dc.yaml#
+
+properties:
+  compatible:
+    const: nuvoton,ma35d1-dcu
+
+  reg:
+    maxItems: 1
+    description:
+      Register range of the DCUltra Lite controller. The address space
+      is 0x2000 bytes.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Bus clock that gates register access (DCU_GATE)
+      - description: Pixel clock divider for display timing (DCUP_DIV)
+
+  clock-names:
+    items:
+      - const: core
+      - const: pix0
+
+  resets:
+    maxItems: 1
+    description:
+      Optional reset for the display controller. The driver does not
+      assert or deassert this reset; it may be used by firmware or
+      boot loaders to bring the hardware to a clean state.
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      Output port to the downstream display device (e.g. RGB panel).
+      The DCUltra Lite supports a single parallel RGB output.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+
+    display@40260000 {
+        compatible = "nuvoton,ma35d1-dcu";
+        reg = <0x40260000 0x2000>;
+        interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk DCU_GATE>, <&clk DCUP_DIV>;
+        clock-names = "core", "pix0";
+        resets = <&sys MA35D1_RESET_DISP>;
+
+        port {
+            dpi_out: endpoint {
+                remote-endpoint = <&panel_in>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
index 9dc35ab973f2..00884529f8c1 100644
--- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
+++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
@@ -9,15 +9,34 @@ title: Verisilicon DC-series display controllers
 maintainers:
   - Icenowy Zheng <uwu@icenowy.me>
 
+description:
+  Verisilicon DC-series display controllers.
+
+# Select any node whose compatible contains one of the known Verisilicon DC
+# or DC-derived compatible strings, including SoC-specific glue variants.
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - verisilicon,dc
+          - thead,th1520-dc8200
+          - nuvoton,ma35d1-dcu
+  required:
+    - compatible
+
 properties:
   $nodename:
     pattern: "^display@[0-9a-f]+$"
 
   compatible:
-    items:
-      - enum:
-          - thead,th1520-dc8200
-      - const: verisilicon,dc # DC IPs have discoverable ID/revision registers
+    # Enumerated in full so the schema validator can verify any compatible
+    # string against this list, including those from child schemas.
+    contains:
+      enum:
+        - verisilicon,dc
+        - thead,th1520-dc8200
+        - nuvoton,ma35d1-dcu
 
   reg:
     maxItems: 1
@@ -26,32 +45,24 @@ properties:
     maxItems: 1
 
   clocks:
-    items:
-      - description: DC Core clock
-      - description: DMA AXI bus clock
-      - description: Configuration AHB bus clock
-      - description: Pixel clock of output 0
-      - description: Pixel clock of output 1
+    minItems: 2
+    maxItems: 5
 
   clock-names:
-    items:
-      - const: core
-      - const: axi
-      - const: ahb
-      - const: pix0
-      - const: pix1
+    minItems: 2
+    maxItems: 5
 
   resets:
-    items:
-      - description: DC Core reset
-      - description: DMA AXI bus reset
-      - description: Configuration AHB bus reset
+    minItems: 1
+    maxItems: 3
 
   reset-names:
-    items:
-      - const: core
-      - const: axi
-      - const: ahb
+    minItems: 1
+    maxItems: 3
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: Single video output port for single-output variants.
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
@@ -59,7 +70,7 @@ properties:
     properties:
       port@0:
         $ref: /schemas/graph.yaml#/properties/port
-        description: The first output channel , endpoint 0 should be
+        description: The first output channel, endpoint 0 should be
           used for DPI format output and endpoint 1 should be used
           for DP format output.
 
@@ -75,9 +86,8 @@ required:
   - interrupts
   - clocks
   - clock-names
-  - ports
 
-additionalProperties: false
+additionalProperties: true
 
 examples:
   - |
-- 
2.43.0

