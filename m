Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5387FC55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:56:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC04810EBCE;
	Tue,  4 Aug 2026 20:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fbAP03fp";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453FB10E127
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:56:25 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso2140075e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 13:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785876983; x=1786481783; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FsSyzNurkU2AZCAgXzFDhA+4Szt1QyFprpuh+Ygbe6g=;
 b=fbAP03fpaWfei9cw1BiUSynXuz394g7kZkZmO9p3MiEujEGOPWcwWVStA1vsgTiZl4
 OklnEl85KIxjdtt4syZ+dLT49IeI/bDfhbmd3EpKwb/jTdPf15mBPaVpRijLfejNb3c2
 eZMpSuatyHun8RzTwZVkseFfhW7QHoQp4CSezBCRWEq0UoDAty1+h9+epg93b8r1P/eN
 fIfA+XYn+OcEp74LdaF3mOtTeyOrZY/Ph0+YEzBPtpcBlgPduCSs2bZ9wnfa+wcaMfBI
 NwErzGuDd8c05wedhYGorQ/aZ9MadTBUpjp9iabXcIzBVLHY3IILEJAT20fhxvYPIiYI
 PzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785876983; x=1786481783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FsSyzNurkU2AZCAgXzFDhA+4Szt1QyFprpuh+Ygbe6g=;
 b=GqShHoiRV1sLo8OdSfUAHojHFgMkNKZb18HJ+8E+eq4kQfrQlkMCKGOQqaPoUBVCpr
 YU/jt9uEGHjI9kda7fGqI+Xt9KTIgtbGcE+MBjT/6WHZqO5/HcPj/qHyFeCyGyswl5sw
 23BmdbB5DvF73l4DNLYdaJ7vENahkSMcgY75DTNc5fICGCdkb1TIlgdjCYCSL7YLLE5X
 sVSEUkuHLW6w3ucBmpi3rhlzdMYzoAEbVLteMcfeeJ6gU9cBcTcwgck9cBVKQjidJw1Y
 5U1tvj3MyVWxcRqhLKL/kCpkpI1lGHLWKDxbdFMvATS/OA8nc/1ajjRC0ASLqYWJ8BCJ
 /Q4A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZTi/ZPMjSDMKwTPKe62u7J+Z7Gjj8dif5uQx2HVNgPu2Je+nKSDzOnSFGnfUZBLo3axCn7WyN9eo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/jiEtfRbQnf8AEnz+9ICMT3cd6nIk5jpOgzI5NTqy9jQGzBMX
 XqGpMiiEO0IsHWry+0hHwKaaE8XSLqY6jaI3seb63iVtah7YYZtne0p3
X-Gm-Gg: AR+sD11Ui/IX9Vt97B897i08j+1HHwEriT7XdfY/2tLSg9ptlvQJ/7Gqg5BRAc4OeZO
 jaopW0rzNpwyAHMxPDLdbnyCx9mvqZBjXiIz4gQ+QPkWcuiv1/2uc//p32M73bOtHw5Cyz0N6hY
 DPK+eMZwaOQwQYwvtrKHcwAcDPmtH5yT6y4QSpgnjAVTk7pq2VUhiWkW/X20eE/JNVe0ot3nuxq
 fhPjM370V7cKXr3QKUAN4ji+Y35TUsQNgqbdSI8UE1/USsD7EUPu2v/heDzac5AmL+ImOgjgs9f
 LOa+AtSO4504TYWYSEk8YgisW7iGF0PeL/TCtyq6uZ5Wk9zUr4/+Yay9syq/2OfvzSWZxcXZuDt
 7sjMw5z7T/hLZ3K2sPLNpTM2uiAG+Wm6RlMsfbM30Nkm954d0+bx5eydsUXNHsdzvqp2FPDenXK
 gpyJLdYiVxIHV6KfPYH9O5xg+pYVhX7WtK2bPeBtkQVfihQ5MVZ9UKpGFRNEs00sEkSM7zqpdqP
 MeiB+luDK9tozj9ydOMYRxBEw==
X-Received: by 2002:a05:600c:4e94:b0:497:ff73:68d5 with SMTP id
 5b1f17b1804b1-4994e6c5eafmr12299005e9.0.1785876983257; 
 Tue, 04 Aug 2026 13:56:23 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.176.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e4bf820sm12070645e9.0.2026.08.04.13.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 13:56:22 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v2 1/6] dt-bindings: display: add a device tree supplied boot
 logo
Date: Wed,  5 Aug 2026 00:56:12 +0200
Message-Id: <20260804225617.264861-2-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260804225617.264861-1-maximpedraza@gmail.com>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
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
 .../display/linux,boot-logo-clut224.yaml      | 131 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml

diff --git a/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
new file mode 100644
index 000000000..a6a206964
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
@@ -0,0 +1,131 @@
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
+  Embedded systems commonly need a product specific boot logo. Today that
+  means pointing CONFIG_LOGO_LINUX_CLUT224_FILE at a different image, which
+  bakes it into the kernel image: changing the logo means building and
+  deploying a new kernel.
+
+  This node lets the boot logo be described by the device tree instead, so that
+  a single kernel image can serve several products, or several revisions of the
+  same product, that only differ in branding.
+
+  Since a logo is configuration rather than a description of the hardware, the
+  node lives under /chosen, next to the other things firmware hands to the
+  operating system. Open Firmware, which the device tree descends from, carried
+  a boot logo in the same spirit as the oem-logo variable under /options.
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
+# The image either lives in the device tree or in a reserved memory region,
+# never both.
+oneOf:
+  - required:
+      - width
+      - height
+      - clut
+      - data
+  - required:
+      - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    // A 4x2 logo using three colours, centred on the screen.
+    / {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        chosen {
+            logo {
+                compatible = "linux,boot-logo-clut224";
+                width = <4>;
+                height = <2>;
+                clut = /bits/ 8 <0xff 0x00 0x00
+                                 0x00 0xff 0x00
+                                 0x00 0x00 0xff>;
+                data = /bits/ 8 <0x00 0x01 0x01 0x00
+                                 0x02 0x00 0x00 0x02>;
+                logo-centered;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 5114e6db7..8cf5163b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10269,6 +10269,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
+F:	Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
 F:	Documentation/fb/
 F:	drivers/video/
 F:	include/linux/fb.h
-- 
2.39.5

