Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7F3FCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD3C10EAB9;
	Tue, 19 May 2026 07:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rs4vg9pW";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11DEA10EA59
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 05:52:02 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-834f1075805so2407186b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779169921; x=1779774721; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uErCr9zi75Tnls+mLi86yEzEO9RwxFHR5lw/x24Nf98=;
 b=Rs4vg9pWKCyITB1qJr9yBgh8E1qVxA/2od/pKrvBuv2t53ftqY0l0dXbYUsfIVGzIx
 53lAi70fE1lfVJ73eWrECBIQZip8xyaEedo/ae/iY/Q08uVFop9LOqYKrcJxQTKJNlSO
 P7jAedMmOQ9EORlxxwDYPf/e1Ge/YIlfDqsGxj3sT2VFApcE/1+TOIxd7Zasu43wxtey
 GE2cd7UylkXpG6Q6d8spCFWEaQ8yjA922W3lXRhykmdzrGYaAiSMbO+tQbmHTTbnK0xz
 IZIvzD1jtPKgR3RBKD9KSevIy838wrkZZk5NrZZuAzVO6U9P2PDGw3pVJT0xDQzrniV/
 kFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779169921; x=1779774721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uErCr9zi75Tnls+mLi86yEzEO9RwxFHR5lw/x24Nf98=;
 b=sMPTXLATU3QmMCTD1PRr/+onO6AbzIwynv+Weu/8/oUE4BSx9gygAh0Sd1Td5MM03b
 SaUHZXbad+oOx/wgJOUOlMDa/prkU0pOoJA9ZfuRi1/Tlbuf9ChKpYtf/e0yc3L4HTxO
 47NsF9z2pI/70NklkNsTFD3HrgGJaHLBj8nvaaLiFul4d/7yZTSd6jAijByOdNEIfA2r
 tKqeF15UQMPxoTh6sR87mshEE5vz7wWoe2FmumWFgzbgW63HEcAIay2vOVClfVIyHSLB
 eQ+g+T7cqGTgwx2yV/rXI35mVniwTKoC6coj2ejs+VqPDVVLZutLTMlCul+TW7GvCRkC
 7/0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+yi3QmJoy3xO4h9wM0/X7wq6EtRFkM2i28Ekdu2Q4T1PYHc14urSXfSJHiBJ67Mhset+fekvIM8M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcTA24QhlSeLWAaYXAprEYmoU6Sxm2x/TfKSx1c4bJPj5euA0k
 tQCY3+HrjHp3OME0Q13Qgzie/X5tjSSDhSkkJAKFJsY3ltxNQzld+8E8
X-Gm-Gg: Acq92OHds6WgDWIyMwGY//iWDoRUozbmNExRYM2w4UttVPz79w42bVcLVNSj7H6Bp64
 iLjJJJTSu/tMtp/N3noLPF6VgnQ+/KZrkinS6XGhnhmK9aOuvv75G54jfsMgPlPIamnQGBb9M7M
 ID7Sx+Fei5SQrb/aHC5lyyiuIlALMEzg6NbqKtlsxzOxWbvh4yDrqXl4k7cmxr2KhpYL1wH9nQG
 2zC5HYCT8bAZjtp+dYGHm82galEXaQ0KkeU903Uy9EWDz/8rveq1n0VJopsxt0VAmBEK9fkCv5V
 b1laCQATI9SUOK2WfpUiQtDDsZygHctE+4PeM2h9wEuXN4T78eVe1bG/inAkrms5dydS4LKuh21
 QJpvF/6jGrxvKkWKkML7+Yp+PPCLAz3PF8zbyxg9AFJH6kXMbFVSPDEjsANX7tr0kj2not3GGAh
 +Negd4AVt40R1d+pp8W9XTSQuknn5ID3MhbrXEgd7jMeIYh48IGhgB4dHIcZWjTFjNRob1NdJWN
 p1q6/eZJ3pK
X-Received: by 2002:a05:6a00:299a:b0:83b:c487:43d2 with SMTP id
 d2e1a72fcca58-83f33df451fmr18417039b3a.36.1779169921605; 
 Mon, 18 May 2026 22:52:01 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f8b9c2ea5sm2641252b3a.13.2026.05.18.22.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 22:52:01 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: display: verisilicon,
 dc: generalize for  single-output variants
Date: Tue, 19 May 2026 13:51:06 +0800
Message-ID: <20260519055114.1886525-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519055114.1886525-1-a0987203069@gmail.com>
References: <20260519055114.1886525-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 May 2026 07:13:01 +0000
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

The existing schema assumes a fixed clock/reset topology and dual-output
port structure matching the DC8200 IP block.  This prevents reuse for
single-output variants such as the Verisilicon DCU Lite used in the
Nuvoton MA35D1 SoC.

Rework the schema so that variant-specific constraints are expressed
via allOf/if-then-else:

- The thead,th1520-dc8200 compatible keeps its existing five-clock,
  three-reset, dual-port requirements.

- A standalone verisilicon,dc compatible covers IPs whose identity is
  discovered entirely through hardware registers; these have flexible
  clock and reset counts, a single 'port' property, and no 'ports'
  requirement.

Changes to the base schema:
- Replace the fixed clock/reset items lists with minItems/maxItems
  ranges; variant sub-schemas tighten the constraints via if-then-else.
- Add a 'port' property (graph.yaml single-port alias) alongside the
  existing 'ports', for single-output variants.
- Drop the unconditional 'ports' requirement; each if-branch enforces
  its own port topology.
- Tighten additionalProperties to unevaluatedProperties to allow
  per-variant schemas to add their own constraints cleanly.
- Fix a stray space in the port@0 description.
- Add a DT example for the generic verisilicon,dc compatible
  (Nuvoton MA35D1 DCU Lite).

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../bindings/display/verisilicon,dc.yaml      | 135 ++++++++++++++----
 1 file changed, 108 insertions(+), 27 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
index 9dc35ab973f2..3a814c2e083e 100644
--- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
+++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
@@ -14,10 +14,12 @@ properties:
     pattern: "^display@[0-9a-f]+$"
 
   compatible:
-    items:
-      - enum:
-          - thead,th1520-dc8200
-      - const: verisilicon,dc # DC IPs have discoverable ID/revision registers
+    oneOf:
+      - items:
+          - enum:
+              - thead,th1520-dc8200
+          - const: verisilicon,dc
+      - const: verisilicon,dc  # DC IPs have discoverable ID/revision registers
 
   reg:
     maxItems: 1
@@ -26,32 +28,24 @@ properties:
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
@@ -59,7 +53,7 @@ properties:
     properties:
       port@0:
         $ref: /schemas/graph.yaml#/properties/port
-        description: The first output channel , endpoint 0 should be
+        description: The first output channel, endpoint 0 should be
           used for DPI format output and endpoint 1 should be used
           for DP format output.
 
@@ -75,9 +69,75 @@ required:
   - interrupts
   - clocks
   - clock-names
-  - ports
 
-additionalProperties: false
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: thead,th1520-dc8200
+    then:
+      properties:
+        clocks:
+          items:
+            - description: DC Core clock
+            - description: DMA AXI bus clock
+            - description: Configuration AHB bus clock
+            - description: Pixel clock of output 0
+            - description: Pixel clock of output 1
+
+        clock-names:
+          items:
+            - const: core
+            - const: axi
+            - const: ahb
+            - const: pix0
+            - const: pix1
+
+        resets:
+          items:
+            - description: DC Core reset
+            - description: DMA AXI bus reset
+            - description: Configuration AHB bus reset
+
+        reset-names:
+          items:
+            - const: core
+            - const: axi
+            - const: ahb
+
+      required:
+        - ports
+
+    else:
+      properties:
+        clocks:
+          items:
+            - description: Bus clock that gates register access
+            - description: Pixel clock divider for display timing
+
+        clock-names:
+          items:
+            - const: core
+            - const: pix0
+
+        resets:
+          maxItems: 1
+          description:
+            Reset line for the display controller.
+
+        reset-names:
+          items:
+            - const: core
+
+      required:
+        - port
+
+      not:
+        required:
+          - ports
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -120,3 +180,24 @@ examples:
         };
       };
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
+    #include <dt-bindings/reset/nuvoton,ma35d1-reset.h>
+
+    display@40260000 {
+        compatible = "verisilicon,dc";
+        reg = <0x40260000 0x20000>;
+        interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk DCU_GATE>, <&clk DCUP_DIV>;
+        clock-names = "core", "pix0";
+        resets = <&sys MA35D1_RESET_DISP>;
+        reset-names = "core";
+
+        port {
+            dpi_out: endpoint {
+                remote-endpoint = <&panel_in>;
+            };
+        };
+    };
-- 
2.43.0

