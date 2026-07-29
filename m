Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1115C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63AE710EC17;
	Wed, 29 Jul 2026 12:56:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VS/0w9mR";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD9C10EBF8
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:55:35 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so6337755e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785329734; x=1785934534; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3c69RKvA+f6vz1rynv3Xy+wD041KoVVbloyxYN/KJv0=;
 b=VS/0w9mRSNEccZjFZXUHqCBYxfbBpwbp0n8nLbaZ4DNQ+zJwHqQewRB26kzCuP3xeb
 n0Vp6L0ZpCAp0MSNRdT/9gf9A+J0Qwc01zYK45kL62DiFhAECjb1VPd9EtoPyXotUhK8
 Ed9KEg9lqvuF+aKjr5fNk2avJFuYBv/LQjOAPsVbPp13ahs+59PWB1b+kXtNxuWlqd13
 xyuNQSofI989CVaR6xTNZNMSCaFmyFmPXPx+n/F/5fjKC7auqAFxYw80wjOOfEpT9sk6
 ONcvaHcpu2wZeeglUsFZoTnImf9O60cJ29R3Z2KjPSiOe8CCuasqJuyjsIBEOTH4Rt6o
 be0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785329734; x=1785934534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3c69RKvA+f6vz1rynv3Xy+wD041KoVVbloyxYN/KJv0=;
 b=gA4bRpeMSWpyOkuUYHg8NQjL4BXtujEP4iZPwtsJc6FrFObLRFwUpUS2YzRlcPNVux
 DxZFyPQWLUQo3Iuv0SpmdqPMSM3TVLqNq6Lk5HChoL2BGHBZW7ihNeNvqLoM+m+DAFfq
 JBdHFYOVdjh/hMlnM6YIWATfzNE41DBIlgZoWUFKlkZwWPdHVW2KnZKJwqMkfPyrlKXQ
 0sIiAhUtqQYhgB/Nr/hEJYng4dmwMwwwnEaEwH1fUsQxMgJNrj9C0pL4Zbw3Yq8Bdesi
 +ngYL9FDFivPyrP1VxfzL4u7+i/Oj6LW0pydkySei3qiQ30QmHkEJxHvYqIp6kz9J//4
 WMJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBjwCgBtO+g/vdBXSHDG8z6jH4+vtz/Glo3YlkiyWZX1lhbv43d/RskG2muJU5XDpXwu82AMZ1nZA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8JwQomieMDDt19yHH3BnOTpl2IRCZ0cjkzDuBf2lW2ziHLJ5M
 SdKkmZvgxXlAQ+L3hdesOWNNbhAihyVyU8DGOmk8qthVUNVuKTA3ndir
X-Gm-Gg: AR+sD13PbVdaE67OIictxTg7l9fso+JTWlvcpNc7wToW8nOHvNLhUcDYOgRoFMiIQEZ
 9hQzRGHtZFC/0cyEdjODNwH9S1XF7e2CUBU1fDOPiAIB1bMgL4EzIND+6q4ukfbWXqlZIMRhahn
 aoH3F9PJZ+Wm2GWRwiMkRlmT9iOQg/jqRrqS4Pjfc/+H7BFe7cxH+9TTGerop11jyX4PF/h9Vga
 UIn/NJyYTEpqPq9OWjto+nIKg0Gm2iTRJC75ynvHKWUHehhoPQjhwlV6UaVrYdMRCS6JvtdkFyS
 bmaUdJCV5fyRVUmpjVD5+xljfgg2odsWjGavPd7+pmVv61e3uR7rgoSIw1a2ytA9Oc4hpdsNKD4
 70gXHb9K5sKgBuD7ivEN0kyoPgoOVR0AwjmdhUp5cm70cUee2wckGaZKcjyXe7zM6LF5wRntjaZ
 1Oq1g3DF2u7MNVWIcZJkqyj4eYQlwmE7J7EmJxi+4EsBFAaLN+0PiRsx0T55L1GJS+caO5AU+WA
 S5vNP6vroWKwmQskP3EMi/w
X-Received: by 2002:a05:600c:1384:b0:496:c441:1354 with SMTP id
 5b1f17b1804b1-496c65744f0mr79543445e9.29.1785329734116; 
 Wed, 29 Jul 2026 05:55:34 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:10b8:4461:ee04:15e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189e5sm9264645f8f.27.2026.07.29.05.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:55:33 -0700 (PDT)
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
Subject: [PATCH v2 07/16] dt-bindings: display: renesas,
 rzg2l-du: Document RZ/G3L SoC
Date: Wed, 29 Jul 2026 13:54:59 +0100
Message-ID: <20260729125516.230757-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
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
v1->v2:
 * Restored ports.
 * Replaced endpoint with port in ports node.
---
 .../bindings/display/renesas,rzg2l-du.yaml    | 26 ++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml b/Documentation/devicetree/bindings/display/renesas,rzg2l-du.yaml
index 7c84a9ecc7a7..5c9b15a09dee 100644
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
 
@@ -108,6 +109,7 @@ allOf:
             port@0:
               description: DPI
             port@1: false
+            port@2: false
 
           required:
             - port@0
@@ -124,10 +126,31 @@ allOf:
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
+        ports:
+          properties:
+            port@0:
+              description: DSI
+            port@1:
+              description: DPI
+            port@2:
+              description: LVDS
+
+          required:
+            - port@0
+            - port@1
+            - port@2
   - if:
       properties:
         compatible:
@@ -140,6 +163,7 @@ allOf:
             port@0:
               description: DSI
             port@1: false
+            port@2: false
 
           required:
             - port@0
-- 
2.43.0

