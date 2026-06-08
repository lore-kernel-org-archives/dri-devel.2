Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ECF0CD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:58:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A9710EFC4;
	Mon,  8 Jun 2026 08:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EJe6Ye0x";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E159B10EC3A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 02:32:47 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2bf20f6be6bso28306305ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 19:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780885967; x=1781490767; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mE/QA9NRrIBzmpaNm7qJKCCCXhuuJ1hBihamFPKJO/0=;
 b=EJe6Ye0xUyBdhvbJk832XHIPYtuaucgU3FSZ3xcjgdB0LhkeZ2RJhMLSzMmtczoSqD
 F41pJlKBR1ii4h7ELLxSJaifjU+kx+S3Yp7i+HQuGsRK8xdyMbKGyvfYHMUb09VW9BkW
 p78TiKvRboUUjz496m53XVwpSlxwhsO7xAhld0po8u7QSQWZGuumDbwzN3gdU7blGuxW
 imkZa71JGlBuWti3amE13qcl9Xg2tRy75Nsbc+l0CSAc3ft4aMEBvPHBnrpdMEfR0jPR
 glHY3qP8zBqi1R/XJ9jIQaMxLaNIU37DluIvT3YsoNbXRaLaPneTOTrgvtKFljBhK5wO
 zLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780885967; x=1781490767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mE/QA9NRrIBzmpaNm7qJKCCCXhuuJ1hBihamFPKJO/0=;
 b=hDr1gcROP64UNVTKTqODa8nnYiqpVwYC6mWWuhZdpcNPBwHTh0hjXEkS4xdi2CGBX8
 0cmpPWczhYPBNlWUNMvp7AFuhkMhJ56GZiZk+xYEx70se2RqkKnvF6MausH6NSkUZf76
 wr8vUWSzgDxlLrGxn9kHVI+mxRApKadsTw4TjeokC4ZVUm41W+g4YS6S1rHr2yTWrQ4O
 dKOBUlbXEOZjBWjtwIP+jwK1IhC/YyRFspKlrQezRB3PKwzo/CYtU8Z6B5HZke/qT7EE
 DUCUvDBbkcuoraiLBrj6ZccAqXfNjS8bUs8eWl8oaENmrUau4w990lDBRttIKkO8OaGv
 mZOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+a9KjNMYnhQPBmHdzOMHe48ZDddaFEHstAOCefUhHuUwDeUEY5WZB4VN2vwJkQsIt07I84fORAOCw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEWNNdRiI0B4SfMxRyCHjtuBHN3lSrW7FlsOxMeV4NiNHbLSVy
 zQQFTU7pfYH4Da7OeVNve5PzNc/fX5Wfy6xjvGWqsh2bo+R+oMqVGkk1
X-Gm-Gg: Acq92OG2FhDCIwoJrVp6xBIPhsfV/UoM5rWTbe6JgcaykxS/WNoHWIjt3odQ4eF/ztQ
 oUUeKOcLl1YweF1iE+rEPhhRVyU/FNzFWHexVvbiKjhx0OQvngMtEKrMokpdg7gFV46KtNCATEz
 jkwgmgR3pFJWmeYrCzs9ACicWmb+EkVo2iDj3gAObYfbj3U9UmFgFO6qH64hJq1LHaZa4frcV/z
 cegXBrw5dJZ1TRZZX6jD9thi9oh7i8QPHuTtz5pqLPSVBvgLsWFhsK7md/5ZK39vms+HYCo/FRA
 gn5QfRui+pJ3yJzyX7UTeRV2QfKYV1m+3PxKCIM54BPkjaHtsou+g+fibP9uDpg+FvcZm+w2t8h
 10tl9DjzEx2fRxzNsMxKo1LsYHb5vI+MOCozEpjzyDYr0l+m3YkYBBkROsfBGtCC0SgkJDnlpok
 DMo0rknG7m7s9dxcgluQ0Fb5+HoDejJbVemnzI+wqE7ZugURmSZcmU/nVFfRW97+NWukC7MSsAZ
 psZR4IgFVgqLrbcsyCWRRy4Yat47UQFug==
X-Received: by 2002:a17:902:ced1:b0:2c0:fa4e:91f6 with SMTP id
 d9443c01a7336-2c1e7d41eabmr144113125ad.13.1780885967308; 
 Sun, 07 Jun 2026 19:32:47 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c245dd3b5dsm38143485ad.81.2026.06.07.19.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 19:32:46 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v3 1/5] dt-bindings: display: verisilicon,
 dc: generalize for single-output variants
Date: Mon,  8 Jun 2026 10:32:33 +0800
Message-ID: <20260608023237.305036-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608023237.305036-1-a0987203069@gmail.com>
References: <20260608023237.305036-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Jun 2026 08:58:33 +0000
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

The existing schema hard-codes the five-clock/three-reset/dual-port
topology of the DC8200 IP block, preventing reuse for single-output
variants such as the Verisilicon DCUltraLite used in the Nuvoton MA35D1
SoC.

Rework the schema so that variant-specific constraints are expressed via
allOf/if blocks:

- Add nuvoton,ma35d1-dcu to the SoC-specific compatible enum.  The
  generic verisilicon,dc fallback remains the driver-binding string.
- Relax the top-level clocks/resets definitions to minItems ranges so
  the base schema accepts both variants.
- Keep ports in the global required list and keep additionalProperties
  tightened to unevaluatedProperties.
- Add an allOf/if block for thead,th1520-dc8200: five-clock (core, axi,
  ahb, pix0, pix1), three-reset (core, axi, ahb).
- Add an allOf/if block for nuvoton,ma35d1-dcu: two-clock (core, pix0),
  one-reset (core).
- Fix a stray space in the port@0 description.
- Add a DT example for the Nuvoton MA35D1 DCU Lite using ports/port@0.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../bindings/display/verisilicon,dc.yaml      | 103 +++++++++++++++---
 1 file changed, 90 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
index 9dc35ab973f2..db0260d874c5 100644
--- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
+++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
@@ -17,7 +17,8 @@ properties:
     items:
       - enum:
           - thead,th1520-dc8200
-      - const: verisilicon,dc # DC IPs have discoverable ID/revision registers
+          - nuvoton,ma35d1-dcu
+      - const: verisilicon,dc  # DC IPs have discoverable ID/revision registers
 
   reg:
     maxItems: 1
@@ -26,6 +27,7 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 2
     items:
       - description: DC Core clock
       - description: DMA AXI bus clock
@@ -34,24 +36,19 @@ properties:
       - description: Pixel clock of output 1
 
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
+    minItems: 1
     items:
       - description: DC Core reset
       - description: DMA AXI bus reset
       - description: Configuration AHB bus reset
 
   reset-names:
-    items:
-      - const: core
-      - const: axi
-      - const: ahb
+    minItems: 1
+    maxItems: 3
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
@@ -59,7 +56,7 @@ properties:
     properties:
       port@0:
         $ref: /schemas/graph.yaml#/properties/port
-        description: The first output channel , endpoint 0 should be
+        description: The first output channel, endpoint 0 should be
           used for DPI format output and endpoint 1 should be used
           for DP format output.
 
@@ -77,7 +74,60 @@ required:
   - clock-names
   - ports
 
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
+          minItems: 5
+          maxItems: 5
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
+          minItems: 3
+          maxItems: 3
+
+        reset-names:
+          items:
+            - const: core
+            - const: axi
+            - const: ahb
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nuvoton,ma35d1-dcu
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+
+        clock-names:
+          items:
+            - const: core
+            - const: pix0
+
+        resets:
+          maxItems: 1
+
+        reset-names:
+          items:
+            - const: core
+
+unevaluatedProperties: false
 
 examples:
   - |
@@ -120,3 +170,30 @@ examples:
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
+        compatible = "nuvoton,ma35d1-dcu", "verisilicon,dc";
+        reg = <0x40260000 0x20000>;
+        interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk DCU_GATE>, <&clk DCUP_DIV>;
+        clock-names = "core", "pix0";
+        resets = <&sys MA35D1_RESET_DISP>;
+        reset-names = "core";
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                dpi_out: endpoint {
+                    remote-endpoint = <&panel_in>;
+                };
+            };
+        };
+    };
-- 
2.43.0

