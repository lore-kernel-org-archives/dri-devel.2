Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81F9C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11A4810E688;
	Sat,  4 Jul 2026 09:34:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kfzzLkvV";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BD4210E066
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 09:34:41 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so11496505e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783157680; x=1783762480; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q9vf76BqIuQO+oLK9NNkHBXuVK+BkmRkVD8Sg2pJCJU=;
 b=kfzzLkvV1XZWQAycHBbttREqHcReDPulCH9NOUGvZwOgTSWASU+s2IyYh1QeYFrytZ
 G4iOpkATlE5aI5BuBwclmZrg6JMG/0EJW5DUB/B4vAtWp4k8o8SWFXKUnNtzrYUZETgq
 sYe7bCN3+oox9VY4Awzd00cc8QcYcK7iqFmQ1BV/nPQlI3k23FbM+NB1nt8u4aMcsbzs
 J2bM38iHbYVJcjm/tyQACUO8IP0NIBnm07Gr5LMP5r3lt734I07Nw9UW68Ueio4IZW2p
 C4xxp5Q4AxWQ8VIVovQ2+/6g3q25wrCeFdnJoOj6MulJllZRcoV2zDHUYayslCV6ksax
 sIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783157680; x=1783762480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=q9vf76BqIuQO+oLK9NNkHBXuVK+BkmRkVD8Sg2pJCJU=;
 b=tSLBaO5vh9D4uJuaOmHA+FKCXf5//dy0aGVs1WgYoRkYSnNI8mt+pVQMWCOVBOFdaz
 hM17Fwkd78HQ0mW97cl2yW5jlISOaK0mcETh/KBWCjHVbRJAtUQ4+GbkRXMzfuHD0R9F
 sNFNUKQ8PR8Fene/ukFTbDb7i5s7ZjwPZxXAn/4WmhDUePDOTwmzlbAjvJy68g+Umbz6
 qANBbwKbB6NRn5PmhaiEZyLPtZXqMxNmCExyF/RoHydNA/JA90W4UQ11usKq4nHYFrMQ
 iMsdPg5Yp2nLNozlxkmzDpjISAyBej8aDU8eGmSRfmdROoQLTfPgGI+16gSgwpfnJ+DB
 xNQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Y19SvGhM7IH4zM1XT329YbIT1lFrAJc70NnWxtwccv6Zgt/qut4h69LqIQ5wRNmrg6YHMslPhvng=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBSkJpk58YM4wgXM1Snycrz0hnPy53VkcfxSk7MtOEIFXjHrZ2
 8p69y9zH/SDgvAgOGFEb5E1sZwvaitV6dVr2hwM5qLszaw4omPsJ4Bzy
X-Gm-Gg: AfdE7cl3ZO1RVcksFm/+FBhzjOMkrfxAYi1Yg+wGaiIXceFKmvEFKEl12yJWfIKh2Au
 tBsqSEqtq9Id/GZp6kL0vXalKfsCt1HxurzFUaazF3S23dfo4xpGl+o1SXmNemsWuU3Bgg+UOuV
 AWZiaug2Pte7nTMYTgBjN21Swj1De3705ew2sgUIHstO5CJ/WbJPffaVusITePvtw/lBwH+4aGV
 Aj5iK9XUwIWvi/OYkoZm4WCnxbIjuZSpLbn2EXpk9JOG74QV/LfILdxJ0PWZ1tbNjkYLNoEfGeL
 6esUtaiq9b2ZCsOlNZRAhjVVflu/jfdLswtw8kwXhjBfHe3mF6Lem3XemhmF4tGbikEgos4Do6c
 sT5POxS0kC4nd/29a8tvf5sgrV1YuOXpWV4o2pIM9O0Hii5j0DYc/t4KtcgAPnIdL+uEADiN8vv
 9Iv9lekINfYbvBpCid/Ji/
X-Received: by 2002:a05:600c:3515:b0:493:c42e:5be0 with SMTP id
 5b1f17b1804b1-493d11894f7mr32349275e9.0.1783157679621; 
 Sat, 04 Jul 2026 02:34:39 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8c5b:5b11:f6a5:9bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce040b4sm153180235e9.10.2026.07.04.02.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 02:34:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 07/16] dt-bindings: display: renesas,
 rzg2l-du: Document RZ/G3L SoC
Date: Sat,  4 Jul 2026 10:34:17 +0100
Message-ID: <20260704093433.273672-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
References: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

The DU block on the RZ/G3L SoC is identical to the one found on the RZ/G2L
SoC. However, it supports the DSI, DPI, and LVDS interfaces, while the
RZ/G2L supports only the DSI and DPI interfaces.

Due to this difference, a SoC-specific compatible string,
'renesas,r9a08g046-du', is added for the RZ/G3L SoC.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/display/renesas,rzg2l-du.yaml    | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 7c84a9ecc7a7..65368649fe77 100644
--- a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
+++ b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
@@ -20,6 +20,7 @@ properties:
       - enum:
           - renesas,r9a07g043u-du # RZ/G2UL
           - renesas,r9a07g044-du # RZ/G2{L,LC}
+          - renesas,r9a08g046-du # RZ/G3L
           - renesas,r9a09g057-du # RZ/V2H(P)
           - renesas,r9a09g077-du # RZ/T2H
       - items:
@@ -65,7 +66,7 @@ properties:
       model-dependent. Each port shall have a single endpoint.
 
     patternProperties:
-      "^port@[0-1]$":
+      "^port@[0-2]$":
         $ref: /schemas/graph.yaml#/properties/port
         unevaluatedProperties: false
 
@@ -88,7 +89,6 @@ required:
   - clocks
   - clock-names
   - power-domains
-  - ports
   - renesas,vsps
 
 additionalProperties: false
@@ -108,6 +108,7 @@ allOf:
             port@0:
               description: DPI
             port@1: false
+            port@2: false
 
           required:
             - port@0
@@ -124,10 +125,31 @@ allOf:
               description: DSI
             port@1:
               description: DPI
+            port@2: false
 
           required:
             - port@0
             - port@1
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a08g046-du
+    then:
+      properties:
+        port:
+          properties:
+            endpoint@0:
+              description: DSI
+            endpoint@1:
+              description: DPI
+            endpoint@2:
+              description: LVDS
+
+          required:
+            - port@0
+            - port@1
+            - port@2
   - if:
       properties:
         compatible:
@@ -140,6 +162,7 @@ allOf:
             port@0:
               description: DSI
             port@1: false
+            port@2: false
 
           required:
             - port@0
-- 
2.43.0

