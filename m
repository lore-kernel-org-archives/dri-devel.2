Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E22C982D2
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1813C10F211;
	Fri, 18 Sep 2026 07:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lC8Aa3uF";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C2A410F147
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:01:38 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccb652d7so259847a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789700498; x=1790305298; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zNwi0hswB7nBQJuSOnrDkFTvC7EtUxGnPwE8AGU2RxA=;
 b=lC8Aa3uFBqsmARUiEkhU/7QRypYv51FYSj+OFGwqgj+Q6edNDFL/i9ybng9IVbMYuw
 Ip42MpU44ngMcwElj8MQo2jDKJXSuolcc4DDRum133sdotSUIwwg3cZzj6DqIl8GqwK4
 4150im2LzTLBMCxmH8506h7N/4wJavUey7C//Y7NTY6UiBqOpXZX7zSirBCJxQmwbmL2
 KUNLh5AOGC9MIBOvno38XZoi6EkuKJV5wgXZIKlRdin20wn6qa1fuRad9TPIgEjpui/8
 gY/+sZB+8QT3fd8UtvzhH5tg92ziq1QMNaoErgQyinyMMLTeMlIrn9wWZKiL45bfQRZv
 mQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789700498; x=1790305298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zNwi0hswB7nBQJuSOnrDkFTvC7EtUxGnPwE8AGU2RxA=;
 b=TpjtKKBLhl+vNx/JEUhDE7PFM1lLIOqUnfEQZqfgQMTBneuK/W93Nc1aFkxEc9fUOj
 BLA8nfvmohg/BoSRP5W7c0AN4l7+whfOQh0OY3Z/+fqTguneKNsfD2glOWJNCwc1pmdB
 b7KnT1Fpa1vqQDYbS7LsKRvxdXxjj6SG0SermSLBiqHBmNekaZhL1oXp+gCWK2cg8GfY
 XZQ+EL3o6ejHYScRm1b6l7CANAeu60cf9vzoHNKQreHB5q2rCZXHx0ScszuRiiC76w+7
 RrNccPbN8lVX776VZ/p667v8aUaqJ7+OhVW3C3zVB7vuF+To6t3qzH0HY88WR4IOcobA
 JKJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzUUrWtxdyIyrf3D6rXszg62yWSTxM6mPw528VTLvslskvEOnk1yoFBwcNG0YxO+fXmYBvggs5HkxY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mGkVphSE1+TWLzMBdJ4/KC0N9rJ+OKWtDKOTun3oiDvO69PgHG
 VxQVEpGoMtXf01+k2CJCFdyowWl9LWwlK/5Z/xM+d9n3+YjgdwDd8OHD
X-Gm-Gg: AYBFou2G9ZiKommlQAikjwrMhcxAmg5S0J8YE9K4Tri5XWM241o79fTZG+Wz+th6E93
 VACgCJuDqNCLxKYteBGECHUEi/5x+KZ18TCZ/Y0c3CKFezbjblJysBC9AJLEOXSjIMbcuV7SmhZ
 FcamZP489/j3UqOhZ5DFD8iQrLCkFZxTbjkd8to+HD0XmTvf7kjF5xiWzcjcMI21ujaYnpyRVdx
 jihxrZBRRMbfmKEsiGMtRaF+B2tK0LRGOsazemTOo/0Eu+8sUL33SrkayMHP/YMAgIPXLOiSVVA
 m0EKai5PZ24WwmOcs7XsrgRplDsHzINpl7ubJOGoX65QCncfx5FJpKF9VByTvS+SbgxaAvZFLXU
 ZwMVPlle1IuLg0GTdHcGvDmHg88MyXaHlNfuL0nK14ops42F45JISRz7OS+/egbVMulfnSsAI8r
 DcrUWOyaYimvZmBNGM8MjRu3+SRy9It39uLE+6mby2iJTmjRLT79JmDrtvyl73DQoRLjHKcZO/e
 jdDDVeApxd9HaaE0qJ/Zu0MgMOmey2eRmQBaEvYs6h3qRvsZdUzj6ZMPJ+keA4=
X-Received: by 2002:a17:90a:38c4:b0:39e:5c75:acbb with SMTP id
 98e67ed59e1d1-39e5c75c196mr202652a91.11.1789700497914; 
 Thu, 17 Sep 2026 20:01:37 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e362e9402sm7969141a91.15.2026.09.17.20.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:01:37 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/7] dt-bindings: display: verisilicon,
 dc: add support for nuvoton, ma35d1-dcu
Date: Fri, 18 Sep 2026 11:01:19 +0800
Message-ID: <20260918030125.315978-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918030125.315978-1-a0987203069@gmail.com>
References: <20260918030125.315978-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:09:59 +0000
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

Restrict the same nuvoton,ma35d1-dcu if block to a single port@0,
since the DCUltraLite only has one output port.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/display/verisilicon,dc.yaml      | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
index 919a900122012..e1e6a3a953646 100644
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
@@ -79,6 +84,52 @@ required:
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
+        ports:
+          properties:
+            port@1: false
+
+          required:
+            - port@0
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

