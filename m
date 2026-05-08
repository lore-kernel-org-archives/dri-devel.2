Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3AC8CD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8E110F449;
	Fri,  8 May 2026 11:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PGpaOXaV";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D09110E2FD
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:17:51 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-44dd5cb0f81so1914265f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 04:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778239070; x=1778843870; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=umnPqhqqv013uzG5MHEH2JE+ZpMvEjDm4eYLN1odRbQ=;
 b=PGpaOXaVmRsxGAKwziO050lMppSZ6MqHWbBo+kSj/jErGnm+tvIsSuM4WlHvNZts8t
 N4MM0J3cL/Pqyisjg0qhWiSaCkZRhzNrjyBm0/0beThI2l6I0XgHaLxamXCjrz3VRbro
 2tbih+WfQ5WfuWGKz27gq7yGMN7jXDdMKRLc1AW/IuH5FaGLF0w3kF7dbDBRKY7qUYnL
 ZBNI9ICW1BpwCggy4E+GEXclGlOFXl9DMspAs6FxnZQgEdwJhk9u1r9NteUNgEF16ZvO
 3HUgRbeTssaIChussSBs8z797F5TgT69sJ0tuKzUdIrq6wF9oG7hgwC9lDOhZdi8UL+U
 fu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778239070; x=1778843870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=umnPqhqqv013uzG5MHEH2JE+ZpMvEjDm4eYLN1odRbQ=;
 b=AhGnRd0E+S77tGVmByvsmwoEVJwVy+Ic+oU3EtN9t0yMDb1rTc/ds+hirdfVLo9p1B
 TxH5Dk1BkB0Z3vUj8WHYmrjrTS323qjpBaDl2EMpg0+ElN1Lbc5baLSAzCNGq1FK+PHF
 EqKJz625Wm4/ueTukQRYh3zoksuzZx2OQndql08CcsPDlQURSkKLWgi32OCM5nHbEjqX
 qpvRiuzOnsRwDOl5f/3fx+hSzQF+Mz9K41V1uHq7vrp2JPcJn9msgheGlRQV8+sGUsay
 MjtqSdG2UlmfHxZ5CrVx5Usy7Li8Brx3sxZPDS3hE+ixZbUCatTxH2euSA+HYtBjWkYf
 7mDA==
X-Gm-Message-State: AOJu0YyVjs0Hwluw2MQA76wZwdGeiMeHKO9+YBma15cDIqgKk0INL3zF
 HQKk+4Zvu1YZ1fuBvptjAhXSh41YZ+hbXt0lpfXx7K30ViUithEYxKWq
X-Gm-Gg: Acq92OEeZa7JD67atQCLuxhyT0p/WTObBmX/H9EU4TUoPVouGGd318aOX3P0ApoKyax
 TNsrmF5ytIDkLxKuvbBoD8r0HyfdhrdzjljLLGGTv2t3yiwFbwfmGQrh9Y2arCPfaxZQnGf2FLT
 pEoVmWd7nlj9Ft04q5+zwON7kuyyqp4lghNktFUhl4Uo2t73zh4LUZCm+YYd45dE9MpDBpxyjA8
 WohgH2FzdU5lLx2f5L0FD/ESFao/4vxgTPEybrZwpaP676E0XnLA41+uSIo8dezhm87DOmYRW9z
 coMHM1ywKOFwh+vhd2cOZBzhZKBhkPSD9j4hEn8XKb5zXK4UMNITsG+YSvYTEVaN6eae9MP9Bad
 6m2p/jYigUdXpJeu42LxpQ1AHk7gvu5swKIxuYXZHWo/nRS4BBHCCr8tGuqsXfA1etPWOWywIUr
 XTCfk/xjgyZD9k9tnUBT9spuU/kiNhm2ULS3sVG4rVixPCKyl2HYeYyOvxYkd4+UiwfaYZb8i+B
 OQitETUcdzksMZrOKssdNc1gYu/c0b/i8a1gQQOjfmopxvA
X-Received: by 2002:a05:6000:20c6:b0:449:8650:954d with SMTP id
 ffacd0b85a97d-452e84663e6mr7389736f8f.12.1778239069759; 
 Fri, 08 May 2026 04:17:49 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:74ae:919a:e57c:bd9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454916df968sm3535563f8f.25.2026.05.08.04.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 04:17:49 -0700 (PDT)
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
Subject: [PATCH v2 1/4] dt-bindings: display: renesas,
 rzg2l-du: Add RZ/T2H and RZ/N2H support
Date: Fri,  8 May 2026 12:17:41 +0100
Message-ID: <20260508111744.771659-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508111744.771659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260508111744.771659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
index 2cc66dcef870..18776ac9e7c7 100644
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
@@ -137,6 +142,17 @@ allOf:
 
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

