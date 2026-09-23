Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFBAC98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B3210F180;
	Wed, 23 Sep 2026 20:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MBS0/YeO";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E69B710F173
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:10:56 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so7408955e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790194255; x=1790799055; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z5ud7C6Q7hzdhSrMZ0UnmI/lSmzd22+sOaMu+2pIMXc=;
 b=MBS0/YeOzaE9H2Agz30f2L8b9FVmwoSlX7el0RmuxhudOUfJnNVedwrz4Ej6Byyd5s
 7pE927gZF6kiIFTPH4F7uV5YGn0OX7RYFFnE++rnEIoq1r29Q3uSG0164e15xW7CIqoo
 M3gcMmCEDF98GD1zOivrldOHTF0lBszj/ahdbgc65ty1YQpLEK+oVthcZruEldtJQDdD
 QjjtcRgwwSPGONZR2NUSTi1nXOIMEZgu3IagacfET4VYRMoyu8sKP+G0FoFVQT6qKhHj
 pLKnv1J642PR4Sf6/+CvccLRyTlt7oWFyAu+969/EZBDc3R30YWkoBIx5giPDFOYNUVi
 Jkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194255; x=1790799055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z5ud7C6Q7hzdhSrMZ0UnmI/lSmzd22+sOaMu+2pIMXc=;
 b=CN1cMwaRtYGAt8tdZlx1j7b35/nvqPLNv6+XOvXhsZV1jdj5jn7uTqD8VVMXtWD++w
 oKq+7zLh8F4iENYjQ4nL8doR6DUsPdc1TTbu/TAX97PtiiAq1jbRCoiwtR1TTjf9qSS0
 mkKcaAi/ENAsZyvWJIY7grQMFGoMa4C83N822HpJ2gIi8lFS4amKhdRMOTVCQib702JP
 KHj8//KDOhEKvceJQirdUE3hHs/uw/TdcHBeC5QMGqGpH05ZdrrkOQ/7GlQt8p43QEXD
 onQiXp8VWUvSs5+aQej0HUswArYD6Z3AsG8xd2N+RwYYy9XD3E/EZMMTEDL3GuTXdDAQ
 mBZA==
X-Forwarded-Encrypted: i=1;
 AKwUvByQRXSU8rrGUeYwQNvEtpLPqBywz2YOllZ9CfLRRWXGEe3l4vQgbW/r2Gu4pJ55id80HxILUmaqKvY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mwxl9YspWR/qI0HTzrX5MOyIemmNJyY6GoXpPsXI+q4mfHeEjm
 qEdUF8JfDLiIg6VoYY3yZUYMVZQvmgGqnGCYmfbwI0MIw9a153gXzKke
X-Gm-Gg: AYBFou0RQ/Ekupl9m8ohl3ZttRYKA3qQQkhDZw57N5fETvK+lq23kDyLwJN/OvVsnEW
 arWya3EUQHcLbRY2bEUvGXxcgMMEe9L26nxDO320YDq9x0P6+vJdOtH4jRwrkN5DMW1MFrOvhuH
 8rW4hNb+bqR1XhTpBFvMtIpv0CggcGbTFjkg8jX32+akDfnX6R9rNImv7Q7E1erL/eEmGump6M/
 Vb0dCfYJVre2jar2VQfFZZpAUtaPF5SZSCcLcVtwm/sLRmDCaQwfm05LUsZnDC6S/GsYOe3Ssw+
 u8tmyT4iNAKjGPY7x1mHJvbXxdsFOZT1RblBAhP1eU30ex5+3Z5/rXIc4rOE0iw4EY5nJlINgXo
 pWZkupdxUY+KkMKRULUC/72feeqQOZK8uxZZTqE+fPZ63lnK3lpW5YFEkYpfMmeDcUzPD+2ybRU
 oj9B8WAhAjOkjGIRou53Y5QfdLEwAC1c9HCFr7Dp7NRNgxqh9puEMLH8enUqH4ojhWbUy1O5G+U
 diRd3MUeLOvAlWXHDCnfLiy
X-Received: by 2002:a05:600c:4fc7:b0:49e:799e:c1c3 with SMTP id
 5b1f17b1804b1-49fe66f1444mr4525325e9.17.1790194255204; 
 Wed, 23 Sep 2026 13:10:55 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4c8dsm13559295e9.3.2026.09.23.13.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:10:54 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v3 2/7] dt-bindings: display: add a device tree supplied boot
 logo
Date: Wed, 23 Sep 2026 22:10:30 +0200
Message-Id: <20260923201035.51007-3-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260923201035.51007-1-maximpedraza@gmail.com>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
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

Embedded products frequently need a product specific boot logo. Today that
means pointing CONFIG_LOGO_LINUX_CLUT224_FILE at a different image, which
bakes it into the kernel image: a change of branding, or a second product
sharing the same board support package, requires a separate kernel build,
and requalifying that kernel for what is a cosmetic change.

Add a binding for a "boot-logo-clut224" node, which carries the logo
in the same paletted format the built-in CLUT224 logos already use, plus a
few optional properties describing where on the screen it is drawn.

The node lives under /chosen because a logo is configuration handed over by
firmware rather than a description of the hardware. Open Firmware, which
the device tree descends from, carried a boot logo in the same spirit as
the oem-logo variable under /options, and simple-framebuffer nodes live
under /chosen today for the same reason.

The palette size is derived from the length of the "clut" property rather
than spelled out separately, and "data" holds plain palette indices; the
32 entry offset the frame buffer layer reserves for the console is an
implementation detail and is applied by the kernel, not by the binding.

"logo-position" takes -1 on an axis to mean centre on that axis rather than
carrying a separate boolean for it. A boolean can only centre both axes or
neither, and next to explicit coordinates it would have to override them
silently when a device tree gave both.

A rotation turns the logo, not the screen. "logo-position" and
"logo-offset" are screen pixels whatever "logo-rotation" says, and a
quarter turn only changes how much room the logo takes up. Placing the
logo in a frame that turns with it would make the same pair of
coordinates mean different places on the same panel, decided by a
property that is meant to describe the image.

Every coordinate is bounded. The kernel clamps them anyway, since it cannot
trust a device tree, but a value that cannot possibly be meant is worth
catching in dtbs_check rather than on the panel.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 .../bindings/display/boot-logo-clut224.yaml   | 135 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 136 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/boot-logo-clut224.yaml

diff --git a/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml b/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
new file mode 100644
index 0000000000..9dc3471763
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/boot-logo-clut224.yaml#
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
+  $nodename:
+    const: logo
+
+  compatible:
+    const: boot-logo-clut224
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
+    $ref: /schemas/types.yaml#/definitions/int32-array
+    description:
+      X and Y coordinates, in pixels, of the top left corner of the logo.
+      A value of -1 on an axis centres the logo on that axis instead.
+      Defaults to the top left corner of the screen.
+    items:
+      - description: X coordinate, or -1 to centre horizontally
+        minimum: -1
+        maximum: 65535
+      - description: Y coordinate, or -1 to centre vertically
+        minimum: -1
+        maximum: 65535
+
+  logo-offset:
+    $ref: /schemas/types.yaml#/definitions/int32-array
+    description:
+      X and Y displacement, in screen pixels, applied after the logo has been
+      placed.
+      Mostly useful together with a centred axis, to land the logo somewhere
+      other than the middle of a panel whose usable area is not its centre.
+    items:
+      - description: X displacement
+        minimum: -65535
+        maximum: 65535
+      - description: Y displacement
+        minimum: -65535
+        maximum: 65535
+
+  logo-rotation:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Rotation applied to the logo before it is drawn. It turns the logo and
+      not the screen, so a quarter turn swaps how much room the logo takes
+      up, but logo-position and logo-offset stay in screen pixels either
+      way.
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
+    // A 4x2 logo using three colours, centred on both axes.
+    / {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        chosen {
+            logo {
+                compatible = "boot-logo-clut224";
+                width = <4>;
+                height = <2>;
+                clut = /bits/ 8 <0xff 0x00 0x00
+                                 0x00 0xff 0x00
+                                 0x00 0x00 0xff>;
+                data = /bits/ 8 <0x00 0x01 0x01 0x00
+                                 0x02 0x00 0x00 0x02>;
+                logo-position = <(-1) (-1)>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index c241444789..804a48e9bc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10339,6 +10339,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 Q:	http://patchwork.kernel.org/project/linux-fbdev/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git
+F:	Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
 F:	Documentation/fb/
 F:	drivers/video/
 F:	include/linux/fb.h
-- 
2.39.5

