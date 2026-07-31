Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7FAAC55174
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07B1510E2E3;
	Sat,  1 Aug 2026 07:58:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mrWORtao";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A86FF10F431
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:50:48 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f84023916so1557667f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785534647; x=1786139447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ne8gXxsmxHvirJEKTA6WZrzb+m1RGc3+hgsbJk4xAkg=;
 b=mrWORtaoEvFcEe7t9xTTkqF6WnROUKuVwHIVBWGEyodqARo+wdLvUWPqNp1sj/sB1D
 D/nBRZiW5EZic0dLgY3L4dg6kIMlVpgkt+bHG4pUAroWeFmWCaET3qtTRbqkvRhni4fq
 W4IK581ksm4VfRDTmDIe2+pPu2c4bi+r0cdKPtQ0e6lRhJTcAKStCVgpkocyFFXWfPfd
 Uj7HKi0kOGWm2tFj3XADjonI1H4Ub245Xhnw6S6pBB8bPHB6sLq/cul2I9ZvOpclP3fD
 JNI8FAabGiG0E6SauzkRmsqQUDfKqWsa5f/CsAGs3YjfiYODBm8qe0Sc70Q5cV3n4EAj
 O7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785534647; x=1786139447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ne8gXxsmxHvirJEKTA6WZrzb+m1RGc3+hgsbJk4xAkg=;
 b=UFxYO7/WX8yeLxbtbtKJUPdELyLx/F0IW4nbx1OujATCaEiQOJqLD2KpazadDoZ06y
 bvHOL7bnOa32HIcPhAHC2R/IrsarOK9rbWcMlMvtmCcSeC/2Dc2HekXXWD9DENR17EzD
 p0wbeUXMQ8xi60wLuaNijL6y6UB53afu5EXIhjOcKFe6tIeYo2NX5AVav1nc+tuZ9osb
 ukChbTS0yMdvYcgO8joGXel/u1ixhslt05ih+5s4RRk/kY4yhC4tTdtWJK8aquuugBAR
 l/dHG/JC0zUP8+HVpr2dhuoZb+Cpmt78BUoXzmupTqnG107ZlQkNU7g7We5CobCkqUII
 Vvyg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYNZZQVoaKjVpcQskEh2NdkYCmZpovKKhu2h5qNQ66xkrAWGYukEwM/r0/1ei7B88tjpisjfqF5VA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkRA6EVrELnI9O3aCimlRSXjp9TxcjnA+Wc36Nxr+KnfbgHt3X
 2O50ApW1bB4IdBNQSJu4OkQCAX4fVr52JoNRd8lJpku5gE68fP6/ATmG
X-Gm-Gg: AR+sD10WLf0kXtxCHX6B/6zQcKRasfrs3x26nolb0iGgve3bw70j8ubqsL0ACUp5blK
 TzY4MsOiag1Sy13VOTK2CQted43SgckkYo1165B1WB7qUw9HyShTWauLD21C/mmwiiMS7uGG8SQ
 GCMjD/p0012dJrfwI454tkKq9Zn6mQ5k8v0vf0jwdUcKZGBSgHQ3G6I8xKQ9PsSH8/PZSqEQiLZ
 hzhq7JlmqQVLYKOVbC7z0B0mst4td8oRlKu8tnefTTOd5UN2+zPuJ7rS8TDRIG9JUA49F17Z/wN
 VKVLheqpD9iAravTfKW0trxOnpLFkJjYTZTTVixAoTdUdktDJfzlzAiUL8Q2LgWfPFdttEaD1Be
 ABBYGa2Ba/K9F8/8ZkEcYzqbRmpVVX6ePUOkGElWGXemNoxeafccATSbJtcFPoHm5CwL4o0g9BU
 7jJQMew+Pjc7Is0fkRiJuMBxYFVuQlbemlPFsXjmiSpCv4VpC9xCkwlzlb7etNlr/zbAJydM7GG
 sFjyDO6KJuStF5FAAtQwAQBNg==
X-Received: by 2002:a05:6000:607:b0:475:f0d1:eb63 with SMTP id
 ffacd0b85a97d-47fd7320f88mr2386045f8f.48.1785534646973; 
 Fri, 31 Jul 2026 14:50:46 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.62.64])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2484sm10186342f8f.11.2026.07.31.14.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 14:50:46 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Max Pedraza <maximpedraza@gmail.com>
Subject: [RFC PATCH 1/6] dt-bindings: display: add a device tree supplied boot
 logo
Date: Fri, 31 Jul 2026 23:50:38 +0200
Message-Id: <20260731215043.30392-2-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260731215043.30392-1-maximpedraza@gmail.com>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
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

Embedded products frequently need a product specific boot logo. Today the
only way to get one is to replace one of the logo_*_clut224.ppm files in
the kernel source tree, which bakes the image into the kernel image: a
change of branding, or a second product sharing the same board support,
requires a separate kernel build.

Add a binding for a "linux,boot-logo-clut224" node, which carries the logo
in the same paletted format the built-in CLUT224 logos already use, plus a
few optional properties describing where on the screen it is drawn.

The palette size is derived from the length of the "clut" property rather
than spelled out separately, and "data" holds plain palette indices; the
32 entry offset the frame buffer layer reserves for the console is an
implementation detail and is applied by the kernel, not by the binding.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 .../display/linux,boot-logo-clut224.yaml      | 108 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml

diff --git a/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
new file mode 100644
index 000000000..10845378d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/linux,boot-logo-clut224.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Boot logo supplied by the device tree
+
+maintainers:
+  - Max Pedraza <maximpedraza@gmail.com>
+
+description: |
+  Embedded systems commonly need a product specific boot logo. Today the only
+  way to get one is to replace one of the logo_*_clut224.ppm files in the
+  kernel source tree, which means the image is baked into the kernel image and
+  a new kernel has to be built and deployed to change it.
+
+  This node lets the boot logo be described by the device tree instead, so that
+  a single kernel image can serve several products, or several revisions of the
+  same product, that only differ in branding.
+
+  The image is stored in the same paletted format the in-kernel CLUT224 logos
+  use: a palette of at most 224 RGB entries plus one palette index per pixel.
+
+properties:
+  compatible:
+    const: linux,boot-logo-clut224
+
+  width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Logo width in pixels.
+    minimum: 1
+    maximum: 65535
+
+  height:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Logo height in pixels.
+    minimum: 1
+    maximum: 65535
+
+  clut:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description:
+      Colour lookup table, as consecutive red, green and blue bytes per entry.
+      The number of entries is derived from the property length and must not
+      exceed 224.
+    minItems: 3
+    maxItems: 672
+
+  data:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description:
+      One byte per pixel, left to right and top to bottom, each byte being an
+      index into the colour lookup table. The property length must be equal to
+      width multiplied by height.
+
+  logo-position:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      X and Y coordinates, in pixels, of the top left corner of the logo.
+      Defaults to the top left corner of the screen.
+    items:
+      - description: X coordinate
+      - description: Y coordinate
+
+  logo-offset:
+    $ref: /schemas/types.yaml#/definitions/int32-array
+    description:
+      X and Y displacement, in pixels, applied after the logo has been placed.
+      Mostly useful together with logo-centered.
+    items:
+      - description: X displacement
+      - description: Y displacement
+
+  logo-centered:
+    type: boolean
+    description:
+      Centre the logo on the screen, overriding logo-position.
+
+  logo-rotation:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Rotation applied to the logo before it is drawn.
+    enum: [none, cw, ccw, ud]
+    default: none
+
+required:
+  - compatible
+  - width
+  - height
+  - clut
+  - data
+
+additionalProperties: false
+
+examples:
+  - |
+    // A 4x2 logo using three colours, centred on the screen.
+    logo {
+        compatible = "linux,boot-logo-clut224";
+        width = <4>;
+        height = <2>;
+        clut = /bits/ 8 <0xff 0x00 0x00
+                         0x00 0xff 0x00
+                         0x00 0x00 0xff>;
+        data = /bits/ 8 <0x00 0x01 0x01 0x00
+                         0x02 0x00 0x00 0x02>;
+        logo-centered;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index e08767323..3f0ede165 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9951,6 +9951,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
+F:	Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
 F:	Documentation/fb/
 F:	drivers/video/
 F:	include/linux/fb.h
-- 
2.39.5

