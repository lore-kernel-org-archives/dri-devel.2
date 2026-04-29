Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCC8FF887E
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 17:00:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0BEC10F0F2;
	Wed, 29 Apr 2026 17:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UCyfqMo1";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FF210F0F3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 17:00:22 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-483487335c2so127093305e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777482021; x=1778086821; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ikSPOGR4XXwx0JwMlnraIx1B5HOIyelZFy6MXUSY+IY=;
 b=UCyfqMo1shjEJIKjH5TL4BMVjRyKigr3wLp1Q99ImORe4qSI459wKCgHm+0FO/5Wy/
 WYFzNbWvW+9krEND7ZHDFbQZsov8QRN8mgGYtzjYLbkZ7Q13Zq1LaLvYfxq2Z8KttSJz
 i2fX07ycihVjY9WN85CQFEwqTK7BeCGPjlnsrJdQVLNMQk9VDwLVTD+17l7LSzgBhXcI
 K7+AmKOSx4DtyJlpiN9lA5eL27uaxlZlV1AYxnuo2hqUXFdNGrJB417si7NG99apViuq
 Kvk5NVt7L/O6d3IwF2vGNidXAg5r5GT+sq2Y9pb2YFzU7NoyUV0Blae0+/i5XbzsZkAs
 KgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777482021; x=1778086821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ikSPOGR4XXwx0JwMlnraIx1B5HOIyelZFy6MXUSY+IY=;
 b=Kb9fEvvJFBdXksBKFOqX+GWs/hDwabxXpWIuML91We73TDwJX5cC2xfDUFqKHE8sJi
 Q8L76MS9aqiDGUh4eYGp2Jfj8ThNHNmnAErOXh9VgOQzdHmfvkPSFPeqh5cOgN3Jc0nO
 GFrStFF6xPfyYmayEcim+r+oZMVVJLWzHU2Y2DNikKCtIvkov0jQVFgrnAr9mDDD5kxA
 YCxaEOTT9GaoZe4uBsQjf5OeTX1UKaKF8W8JvQuXaUmL0VTfNeR63OhxaxsgMbdgYphh
 Z1M7cp+pQ2yUulzyL5HxLxxv5+W7hVUhgxSsctg9TkkQMZCpFwVO/GmEkTgpnspHZeEI
 elbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ94TNcP3M6ZjvOHpHSQ0LbXM1KR4PQjkphbOksc8bsu0Rc1trJ/jlDeLjrv7Iyf29MmpFS3nhVrlyU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzm38vNXrA8E5uHGK+UfAAnFHmswkiLdUCTEbVtxBTko1mhTFO3
 gUckpimgt8S/PR3vTtPeEeQKHkQs1eCsZZ0PPeA0DmNZ1CtoNlPvlEjT
X-Gm-Gg: AeBDietEMlgcC72Re15LrM2T7qqtIgMU8TKhwsXi7XoP+7b+0YDRE3qMh/cQ7VcvKNI
 KgLP4mfY3xKmRUDtMbaP9D1rgbkWfh2IqUSdlfvmVSFI4cJWzlxxZoqks/pDO8EQeNz+18rMN6J
 Y1Gh4ScT27hV8rVBeKpsYXO2XaURXoSE4muuRpVER1sYLOzaAff7jtM3RsEHFEoEn0jSf6LHaSm
 3CsMFrWxk0DVj356vEuqmuWj0MyAOwMA/Gpu2h10oE38rYlESwqLogc6shi61zKdLeUY214ydPU
 H5qhtmVjCg+HdvzOL/exfmJNDUpMPnDVLVNYIQAuUlks1DKanS3MnJhBKZEdHSY70grBpouMNfa
 Zz6m9d8//K8yLLg+v7Ai4WLAoT+Ab7sE0amhuzr+ttLPjzt+dg3x+94iIm0goP6suHcxkw1uNAA
 mq9Ir1hKoxa+ljuQcGp0GF5DG1XS9baJSKYlKqMkoJzKNMamgFDcFjI9w2MvkZYeCwHbVmBcWpA
 lbPI2pGVvk42OReFRfevs32oirS1Ys2SCS0wLxIdZsKdcrk
X-Received: by 2002:a05:600c:3b0f:b0:48a:52ce:a4b1 with SMTP id
 5b1f17b1804b1-48a77b177aamr133031915e9.15.1777482020092; 
 Wed, 29 Apr 2026 10:00:20 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:212b:3a69:4f2c:3897])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c856dsm4809755e9.6.2026.04.29.10.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 10:00:19 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/4] dt-bindings: display: renesas,
 rzg2l-du: Add RZ/T2H and RZ/N2H support
Date: Wed, 29 Apr 2026 18:00:09 +0100
Message-ID: <20260429170012.366537-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260429170012.366537-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document the Display Unit (DU) support for the RZ/T2H and RZ/N2H SoCs.

The DU block on RZ/T2H is functionally equivalent to the RZ/G2UL DU and
supports the DPI interface, but includes SoC-specific register differences.
Add a dedicated compatible string to represent this variant.

As the DU implementation on RZ/N2H matches RZ/T2H, describe it using an
RZ/N2H specific compatible string with the RZ/T2H compatible as fallback.

Unlike other DU variants which use a multi-port model, the RZ/T2H and
RZ/N2H DU has a single output and is modelled using a single port node
with one endpoint. Add a port property to support this and update the
allOf constraints accordingly.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/display/renesas,rzg2l-du.yaml    | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 2cc66dcef870..45678d536a75 100644
--- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
@@ -21,6 +21,7 @@ properties:
           - renesas,r9a07g043u-du # RZ/G2UL
           - renesas,r9a07g044-du # RZ/G2{L,LC}
           - renesas,r9a09g057-du # RZ/V2H(P)
+          - renesas,r9a09g077-du # RZ/T2H
       - items:
           - enum:
               - renesas,r9a07g054-du    # RZ/V2L
@@ -28,6 +29,9 @@ properties:
       - items:
           - const: renesas,r9a09g056-du # RZ/V2N
           - const: renesas,r9a09g057-du # RZ/V2H(P) fallback
+      - items:
+          - const: renesas,r9a09g087-du # RZ/N2H
+          - const: renesas,r9a09g077-du # RZ/T2H fallback
 
   reg:
     maxItems: 1
@@ -53,6 +57,10 @@ properties:
   power-domains:
     maxItems: 1
 
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: Single output port for single-output DU variants.
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
     description: |
@@ -83,9 +91,7 @@ required:
   - interrupts
   - clocks
   - clock-names
-  - resets
   - power-domains
-  - ports
   - renesas,vsps
 
 additionalProperties: false
@@ -137,6 +143,20 @@ allOf:
 
           required:
             - port@0
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-du
+    then:
+      properties:
+        resets: false
+      required:
+        - port
+    else:
+      required:
+        - resets
+        - ports
 
 examples:
   # RZ/G2L DU
-- 
2.54.0

