Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EAACD98D6
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:58:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD91F10E24E;
	Mon, 15 Jun 2026 07:58:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="igJdhbJW";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 014D410E1FB
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:50:14 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-137d464c47eso2221404c88.1
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 23:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781506214; x=1782111014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lenEIxoLi6+YCq/tfMwIzvmfL+sfiBY8pQSkNEn0Xhs=;
 b=igJdhbJWA/dRvHnzOnQQRO589mnZpH+FW2Plb72eRxW5+puz9NOIxZk/90e/+T+FjZ
 J3tY9d5SvuUVdQnq13Fa0vZ16ZSbC+BnajSWi+RE6uHrj/6hxmkoVXwC+USuQzbLH4eF
 RqA/3gwq0NuqcS6pf+QQtnFYoSr60cIjTkpeaZ1SskRolzeCkW5iL56dDIH0UeKUvl1a
 lyef5P0368e0oig4YKtS1oTTwQx1tafJvpeabc6bJ/QyPVR3WgMXos+XNuQG7P56lwmV
 uCsBJCl6jV4xanfXyncDZod5VBU82im5CbVQXcQnHIhM7BRIAP3MrVxq0SG9kt1V0Ke7
 65Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506214; x=1782111014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lenEIxoLi6+YCq/tfMwIzvmfL+sfiBY8pQSkNEn0Xhs=;
 b=HC76O2PHNr0mV9e/Yz0wJIjG1h5ZfjjxpGw7nwxZJojoytN4zyzF1tYSJCBsZGelz5
 T/H9M4H7/6bD3omcz8akDuAQJxZVb+PwDblKqEn4g+KXqn7n8fkOE8bOySjJCCmKzk0W
 SnJvdIUOHzkPFH6PM0ljB5Po+WBb24fkiOBLwnomNwXnTJVqnxHyAne83mlQMwjZsWu3
 qqnneyjC7PppOufhBgNnTXF/XEn7wYaMgyFaERP/0lueZh5JcYdSSrv3MmEx9j4bt2Gk
 469hExif5hVIwtoKL0bf1fNuXR0WiefN/AdC/uswQWWtlJL8iekX05K9xPq8LP0GQHQY
 X0jw==
X-Forwarded-Encrypted: i=1;
 AFNElJ92SmBxF4Iyop1YCv+Q73hDHmLyZlMOwyRNkPAHACaPKnDPz707Mk6ADw6y9jH3h+DvIpZjz87ESMU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhLA/ZtTcCcW+vbUfHYpwrV2FW9p8jDvA2cY/iMjBm/79BY89r
 e3FcuLFNE3yBIRRQHxxL1tU/Fz9meWFhhXxEvQh6lfYTtU/mkEXphTBu
X-Gm-Gg: Acq92OFsV/j3rn9AFO/y4mDV2SJ94fHa6e932kWVh48p8paBfRZlkkdGQZ1sangCtKq
 +cmaGaeO2x6dlTPyYn7cJtd+eV3JN0t7SxGwo/XFm7dV9L5rQOHTHc0dyPl0s09yrs9qwx/xb30
 Q/8CanfEE8ULKTChTVZ/wgVzOimYMvypHuuMpgKkiy0vLBHanZX1Yj3ybIOHVcqCMJnFVyHCR5u
 9KlWUBdDk7PhNSC+JdiYPTcy2Fslelm1blPmqaqZ/B3J5CTSgdAtCIsP3/Sv+EnUE/sfT4sa6E1
 2PrHJPwIh6uMaWFLeQPMKsU9bZojK8lneSRuh5iznKcrUQB+yofcGLjH6CSO681nnY79CTRxkqH
 1jVrEFkOWyy/rlDOh3oF+3K4O3AtxBroWzjTs+EvQB/LK1RGHi+NaorwswZsck79PHWqQsNqZHk
 EglIlQWEIiYsLKufOov2KTpyzxWUHAk4sXUGMebc0P8G7/ImquCMZohpyEych3858h6Snz+4QbI
 cNYAskWJTiA
X-Received: by 2002:a05:7300:6da4:b0:2d9:db50:c6ce with SMTP id
 5a478bee46e88-30820c0a172mr6428010eec.3.1781506214227; 
 Sun, 14 Jun 2026 23:50:14 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb9a2e7sm13516812eec.30.2026.06.14.23.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 23:50:13 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v4 1/6] dt-bindings: display: verisilicon,
 dc: generalize for single-output variants
Date: Mon, 15 Jun 2026 14:49:58 +0800
Message-ID: <20260615065003.76661-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615065003.76661-1-a0987203069@gmail.com>
References: <20260615065003.76661-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Jun 2026 07:58:00 +0000
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
- Move clock and reset items descriptions into the per-variant allOf/if
  blocks; keep only minItems/maxItems at the top level so the base schema
  accepts all variants.
- Restore full items lists for clock-names and reset-names at the top
  level with minItems so the names are validated against the descriptions.
- Keep ports in the global required list and keep additionalProperties: false.
- Add an allOf/if block for thead,th1520-dc8200: five-clock (core, axi,
  ahb, pix0, pix1), three-reset (core, axi, ahb), required resets.
- Add an allOf/if block for nuvoton,ma35d1-dcu: two-clock (core, pix0),
  one-reset (core), required resets.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../bindings/display/verisilicon,dc.yaml      | 80 +++++++++++++++++--
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
index 9dc35ab973f2..0c41286b8223 100644
--- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
+++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - thead,th1520-dc8200
+          - nuvoton,ma35d1-dcu
       - const: verisilicon,dc # DC IPs have discoverable ID/revision registers
 
   reg:
@@ -26,14 +27,12 @@ properties:
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
+    minItems: 2
+    maxItems: 5
     items:
       - const: core
       - const: axi
@@ -42,12 +41,16 @@ properties:
       - const: pix1
 
   resets:
+    minItems: 1
+    maxItems: 3
     items:
       - description: DC Core reset
       - description: DMA AXI bus reset
       - description: Configuration AHB bus reset
 
   reset-names:
+    minItems: 1
+    maxItems: 3
     items:
       - const: core
       - const: axi
@@ -59,7 +62,7 @@ properties:
     properties:
       port@0:
         $ref: /schemas/graph.yaml#/properties/port
-        description: The first output channel , endpoint 0 should be
+        description: The first output channel, endpoint 0 should be
           used for DPI format output and endpoint 1 should be used
           for DP format output.
 
@@ -77,6 +80,69 @@ required:
   - clock-names
   - ports
 
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
+          items:
+            - description: DC Core clock
+            - description: DMA AXI bus clock
+            - description: Configuration AHB bus clock
+            - description: Pixel clock of output 0
+            - description: Pixel clock of output 1
+
+        clock-names:
+          minItems: 5
+          maxItems: 5
+
+        resets:
+          minItems: 3
+          maxItems: 3
+
+        reset-names:
+          minItems: 3
+          maxItems: 3
+
+      required:
+        - resets
+        - reset-names
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
+          items:
+            - description: DC Core clock
+            - description: Pixel clock of output 0
+
+        clock-names:
+          minItems: 2
+          maxItems: 2
+
+        resets:
+          minItems: 1
+          maxItems: 1
+
+        reset-names:
+          maxItems: 1
+
+      required:
+        - resets
+        - reset-names
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

