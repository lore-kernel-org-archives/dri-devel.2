Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 072DBCD4F3C
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 16:08:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 575D410EDD3;
	Tue, 19 May 2026 16:08:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YJKfjuki";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB37610EDC8
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 16:08:46 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so2376928f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779206925; x=1779811725; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOkRbl/Z3KIo8IHWL0YYZ2T30bRveRdlbF9KAPZu9kI=;
 b=YJKfjukiQGIQBY6WItOr6MtekYAmXanWyeFvyzNRr9hAZMU5kI42f/So26oQZ28HAI
 9GXkRkV6elV9u62zT+XtXIa/KfCOuRqC3EmJO6k+cGvPV+1K7FmKmY2DnRDMG020afC6
 akl+6QllbaU0xIrDbO0tNJow6npGijqslBfw8PXFnnTZbb85peRVR4/6+FwleTirYcsG
 3tEYZxd++wg5ihadkNDZag0I8NatdGvp2mHxnfpLMB0S+JzhRBSh6/9gU5UWDP8W2WTS
 xjgjUc5017sSL0wCuqImKZ3rC0EdFyT9Ye2CHGRRhjNqnn++wzCucUXVSVPC3r2vetoT
 2aaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779206925; x=1779811725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UOkRbl/Z3KIo8IHWL0YYZ2T30bRveRdlbF9KAPZu9kI=;
 b=dv7ANIP8vD5v2gI0XXGM1sM8VG5n2XNEcRSHjWJh4s7vtAIMNMkk+tcB2SQpWmZXbc
 tbJRzkDAQH82rd30k57X1ri1wdqWwhL0YmBZdays65YR3n410H+Vjj13xH3ewIYRBT7V
 4xYzXDgILPUpS1qkQBbDppa1KAuW0YUooIAybnpfrB+3sKltBuC3NjHmUG/tN8uC91+c
 XCzCvk8q4gLUBa1NibuhwH0tSlRRbwBUy8m7e75rP8rhHogMAGpzhCoALvrYha+bEhKd
 EagllP1uHWsGOSWEVYCgvdmKx3Wt1d9xnDr68UZ09CLP9Pn7X6e0sN07J1DWR//JQgLd
 YJUA==
X-Gm-Message-State: AOJu0Yz4TMtIhNAtR7uyljVxoknMpvyHp0xlZRrUyIRelqo+65Kn+p1l
 0aCSnd4cKK4zXrYZD0y+SnxUnf6Z7QuxcSqg9BXOsteHXjmfNfZcxgFz
X-Gm-Gg: Acq92OHedI0+8FfFsNDVHI5tpY7Z177v2sfUC2Xq3vFZx6M2pS79kdYPEuDsbIQwxyu
 eQm+uM9HX6t751HdfxXtWWIBGwuFjsGWGAlvFQCQGJBUyHZLgneue0T5SSH7Kd6guWOuT0y7aCc
 AITJfy8Q8OkMsk+fTZZhyaJzbFtcJfRbjJxm8LvbUn9bUUWSrAA6xCF1bgNHa3IYAfEtZJb0Dyh
 H1Mn55Ta7MhBRN6CGqvtkN3AadJ7A93HQhHlyEAY6FfLd3UGLP4rKMCLeFTTk6bbar+/3/q818e
 FI5XlK40cckWoNuA99bdDd1v8FsyvPwXPDdpWldEZohm2xJHVSmQKjcT4kr1s4NTK+DxLN4nZ9n
 Vzpkj6PfmrVrHldt+k38AVlW5OSSMc4Ea9YjevBJ11Mj9wy3lOr6a2s37G2vba2RYA1YZWbQghJ
 L9FHLaeGEIXJLjxxHPUQj++a/RLAsQU8bqhGhj1V/q9hT7wYvOC+6YiOnVOcgB2lNVGQ+K8sZdi
 KLp6TKZaBAmrEbieS4BUTfLOz3JMZwooySz/g==
X-Received: by 2002:a05:600c:34cd:b0:488:936a:6220 with SMTP id
 5b1f17b1804b1-48fe61f2c03mr344635125e9.21.1779206925142; 
 Tue, 19 May 2026 09:08:45 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:3f5e:825d:a98f:fd29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5ab527asm372645305e9.11.2026.05.19.09.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:08:44 -0700 (PDT)
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
Subject: [PATCH v4 2/5] dt-bindings: display: renesas,
 rzg2l-du: Add RZ/T2H and RZ/N2H support
Date: Tue, 19 May 2026 17:08:22 +0100
Message-ID: <20260519160825.4082566-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519160825.4082566-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260519160825.4082566-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v3->v4:
- Added RB tag from Rob.

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

