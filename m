Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F18CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 14:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B084810EAD5;
	Tue, 12 May 2026 14:41:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kEPOsJz3";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 715E710EAD5
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:41:42 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so3575756f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 07:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778596901; x=1779201701; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/kJIKcZqxJ8G0thiFyFX6xJiY+UhKIMT0pGQl1UUr4=;
 b=kEPOsJz3GQoX6Nv7TiqFzR3XnyUrSn6Oc/NOBkJdzkrBnWhVGtcNfg/tzBNeHH/tEW
 wzvgbTS3InlsFa7KH5SzzMIEiuJOfymmd1akOG6BGwaxGsR1Ioqy55+QOsqmJew4/F70
 4b3OshGen+LMhgmDhIbCAKTXpC10Y+R1BMwsmSxBy1gZUM1JrWRevBsrp6HGksvmqft2
 zReQwrJG7XhvgXaif5xcx2DUUox5Ys/9KkqJD7Sb+cuPnckCONuRVFEFs8kqDKW2RZVI
 jgzPJ81Jn6uSfVhNgHAfzHhjB5/5HiP2SG3Z5V0zUcnBRGfJ3ZBhfjpxD/W0OQMnykrX
 xLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778596901; x=1779201701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q/kJIKcZqxJ8G0thiFyFX6xJiY+UhKIMT0pGQl1UUr4=;
 b=ExisfPwTKUcFhZsoLqnnyNesY5tl5P6MpamaIUtt/Z4SmzAhAAZzE5iDM1al7fiBPC
 CKPPdYnt43rngSc7kze9s1U4jmVTMx8Ml0LuurM8v0IEfy7NeVZiFUvTomlBWUvNT0p+
 MEx9T6ixkdZdqrDFV8SfnRAOp0NKOl27Er9wedFfrK9FrJyHVmeBRlsQ5SUnDFcKFuKr
 JKnQRSAFAZwJlAog8SzgR5Nr61qa70+dD4t7H7WhqzeDI48F1mcxc/IMWaTVL747wPBP
 U8gAcdhBi1qtgDV0iR6F0JW7PNlm8uUGrWvjkuODr9b8ltxT6SV6banXCYjD+Ru3YZHA
 0ebA==
X-Gm-Message-State: AOJu0Yxnqxzcu1U9nYc6SibRhnvVLER92Nn+v8yCBoZSYOk98VhTd46C
 nxRvPkBTSeL4F3Kaae5MMu1gOpmlqapuTngZUkiLPOAi+nSQtHv90JsU
X-Gm-Gg: Acq92OGOYIJFLAeqkbdvQt+wrn8s1OvtqcPrbvlfBBp6uVDZBqtKJ59e2dBAhEX1zwL
 WvjdHwBfeCsXXq3gKe8fx7OQ03pCcT6f2qrsIGhtVWlpy4GQlFF1wTANk6WicmMUF5FeksU9imC
 hCTEpyy1kU9HksH0mMa55R6LRnOwnl2xZW2riUlW0K2vl7D44UIBBSEE6TL5USq94uUkDkOc+el
 J4ic/A2teOy1OfOrfv2zSWqtLMPhOB02Wv4AGMMa8LuUajybocSNfpuQlN/3UI6RGu8tKmR9Fm0
 RBZzthl+8/5GV9TclTBgV9RqxvKtAex9nEA3JLnWfhVLhcd1fYWxeBJHUnV8PbGOEqloWvgmFV1
 /Vx7uKKMEeRZqnK23SMy+kKBkJwX1B2asD9vh2iQP4dNXYHx8cQOuxLiKXT19sfOFMJ/SM8PFzA
 Rq8AgCoBZHCad0ccNUNWuCpuMdIrMW5GaDgqx0kpo8+fEsJ7zc5rZ10Bst+lrDBlCelkwM5AKmj
 81E+LXHqUttSO89aF7Z2eUcT5zEhlSgtKU=
X-Received: by 2002:a05:6000:420c:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-454637c817fmr27827468f8f.38.1778596900791; 
 Tue, 12 May 2026 07:41:40 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:77f5:545a:798:321])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491cab9c2sm34978713f8f.31.2026.05.12.07.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:41:40 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 2/5] dt-bindings: display: renesas,
 rzg2l-du: Add RZ/T2H and RZ/N2H support
Date: Tue, 12 May 2026 15:41:01 +0100
Message-ID: <20260512144104.761531-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
supports the DPI interface, but includes SoC-specific register differences
and has no reset control. Add a dedicated compatible string to represent
this variant and update the allOf constraints accordingly.

As the DU implementation on RZ/N2H matches RZ/T2H, describe it using an
RZ/N2H specific compatible string with the RZ/T2H compatible as fallback.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2->v3:
- No change

v1->v2:
- Dropped the "port" property in favor of "ports" with a single port@0
  child, to align with the existing RZ/G2L bindings and simplify the
  device tree structure.
- Updated the commit message to reflect the change from "port" to "ports".
- Dropped RB tag from Rob due to above changes.
---
 .../bindings/display/renesas,rzg2l-du.yaml    | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 5add3b832eab..7c84a9ecc7a7 100644
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
@@ -83,7 +87,6 @@ required:
   - interrupts
   - clocks
   - clock-names
-  - resets
   - power-domains
   - ports
   - renesas,vsps
@@ -95,7 +98,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: renesas,r9a07g043u-du
+            enum:
+              - renesas,r9a07g043u-du
+              - renesas,r9a09g077-du
     then:
       properties:
         ports:
@@ -138,6 +143,17 @@ allOf:
 
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
+    else:
+      required:
+        - resets
 
 examples:
   # RZ/G2L DU
-- 
2.54.0

