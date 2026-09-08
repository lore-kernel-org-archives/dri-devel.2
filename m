Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FA9C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D0B210EF35;
	Wed,  9 Sep 2026 06:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BimnQo1L";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20FB910EAE6
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:28:52 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-39266382df6so3441308a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788859732; x=1789464532; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8EcwJ6FJdDLZqAgx4ZJcfrdseGR1/I5SVESCmgXprts=;
 b=BimnQo1LTYWMmMPbCquepm7I8BJ+PyUAag/jQJDX6OJkf4thpwLEMpI3FqplLCBqAa
 Uv2IGcnOSrVnYQuw1qleneyrRPBoRY+cRPzSVVv57YpwSILBsaqPvhvuwcRT9C7EbGdb
 5JW0dVhZnoob85gQXuvYZWsWsbzhQ19Jt05F71r6oU+YdhiZ/lhe5i0oF/N085EV2Ktu
 x0PMoqcYMBRWIFt7GhNNMcdRv7/lepjc3Unhqwgz9XLcFwDlKey6ktIS0Y9vcqpdE7Og
 MSTlY9vvZFCbxmDhegpIj3PTq6BE+vaGoGI4Lk+38gGb+vTyobU9z8iJ5NZmiRgwJ7V+
 SJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788859732; x=1789464532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8EcwJ6FJdDLZqAgx4ZJcfrdseGR1/I5SVESCmgXprts=;
 b=M1Tq+0BcD6rGT10rzGsPId0bESpUXPYl/2fwLAwqmaytneQRmI2QnJvabhbhPm+Bsd
 edvHkI48as7US14Bd2kNG/Ebpcjl0F7Fj2of5q1vn7KJtPpP9i/iipEMOzMLrILSBUI+
 BzKQ8xeRFgAGnUzBEnwWyc+fY/33FGTSSlrsB0H1i4cme0T4HwGYXtY4iH9wHlaEBhhJ
 ohnMSOajemos0aJMdUHV8nEAzkA5UePOx5bMPjgd0KE9RisRQkaRsB5skl2GuJsbF0kX
 T+2gH0JqhOd01p9pz7VekD3vCU4ul5xl47Su6JmE8dI7hCU4sb13v48sjfCpPf5jinQf
 qfTA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxS5ZeI5lWpTvhYujZ6xrQleqOzUnUaodaGfOFdew6CkexFRNFWKkQALwuz7eG4iul0WPLfFOeWUv0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nd2IubAhw2X37bCQcjsDKjOOnKGlc0vVzSCxHm6eT4DkU6nAKz
 A8SqCgZDgWPmO0WFR5RmD9hqfcX4wVIgkxxA4/MQKE1zhJL1doMFHADR
X-Gm-Gg: AYBFou19EVYQMKIy9s+TSWf57/WmT248T/ZTfNGiuWkgXcw73/Q1pFBg88omNFDop+0
 CDV1SJRHLU9CjPJlmxeV8n3MvukXPGA+1z6OC/BqFFlXpIx5Nbtz819F75ocvdybxcHSydZnwmp
 4YdoA4gEb2HiDn7ZpnS4mm/JNE+yrRmRVYp4/5w478ZNrzblBHxpZyC3UtGLtNV7UDeaAMLITCF
 nMFZyYcFWqdaCIrlH42ehM58O0HoFVM90R/m1xDkiMFTSVpJO+FzFAh8UNUlJ8hMKeLLOKdnWdx
 L9F5Jclor+WQXiek7e6IG/B832GWv6UBzBUVb1/ol+D/JcQ5hNFtuvWdwLKUMQIpbGBgGHjK0TF
 lslz4YQjar6GVBfZ50xveOMsaMK46JNeF/M5KbUNBrGWyQZYTAKn97l9ucG/PaSFdDZ45u7mGRw
 k3hNSdwQ4gaei4P2NscYWEZWPnzD8wZ5POY0iO+BJ3qr2g4OOZ7j1KywV23lUcYQpzSN6w4rCfR
 RY4Ewgdr1Lt2FXvA39smXXgmIBML8AgTICbOKWx57M1K4SAJ8NS
X-Received: by 2002:a17:90b:2808:b0:398:b46d:48c0 with SMTP id
 98e67ed59e1d1-39b262aaeb7mr44896355a91.18.1788859731444; 
 Tue, 08 Sep 2026 02:28:51 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c39227sm32109846a91.9.2026.09.08.02.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:28:51 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v6 1/6] dt-bindings: display: verisilicon,
 dc: add support for nuvoton, ma35d1-dcu
Date: Tue,  8 Sep 2026 17:28:35 +0800
Message-ID: <20260908092840.225220-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908092840.225220-1-a0987203069@gmail.com>
References: <20260908092840.225220-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

Add the Nuvoton MA35D1 DCUltraLite (nuvoton,ma35d1-dcu) to the binding.
The DCUltraLite uses only four clocks (core, axi, ahb, pix0) and one
reset (core), with a single output port.

The MA35D1 clock controller gates the core, AXI and AHB clocks with a
single bit, but each remains a distinct clock line feeding the IP with
its own rate constraints, so all four must still be listed individually
in the devicetree; core, axi and ahb happen to share the same clock
phandle.

Move the clocks/clock-names minItems to 4 and resets/reset-names
minItems to 1 at the top level, since that is the lowest count any
supported variant needs.  Add an allOf/if block that tightens the
constraint back up to the fixed 5-clock/3-reset topology required by
the existing thead,th1520-dc8200 compatible, and another one that caps
the new nuvoton,ma35d1-dcu compatible at the 4-clock/1-reset count it
actually wires up.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../bindings/display/verisilicon,dc.yaml      | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
index 919a900122012..773966677d0f4 100644
--- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
+++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - thead,th1520-dc8200
+          - nuvoton,ma35d1-dcu
       - const: verisilicon,dc # DC IPs have discoverable ID/revision registers
 
   reg:
@@ -26,6 +27,7 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 4
     items:
       - description: DC Core clock
       - description: DMA AXI bus clock
@@ -34,6 +36,7 @@ properties:
       - description: Pixel clock of output 1
 
   clock-names:
+    minItems: 4
     items:
       - const: core
       - const: axi
@@ -42,12 +45,14 @@ properties:
       - const: pix1
 
   resets:
+    minItems: 1
     items:
       - description: DC Core reset
       - description: DMA AXI bus reset
       - description: Configuration AHB bus reset
 
   reset-names:
+    minItems: 1
     items:
       - const: core
       - const: axi
@@ -79,6 +84,45 @@ required:
   - reset-names
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
+
+        clock-names:
+          minItems: 5
+
+        resets:
+          minItems: 3
+
+        reset-names:
+          minItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nuvoton,ma35d1-dcu
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+
+        clock-names:
+          maxItems: 4
+
+        resets:
+          maxItems: 1
+
+        reset-names:
+          maxItems: 1
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

