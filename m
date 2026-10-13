Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5166ACC6B08
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8BA610F673;
	Tue, 13 Oct 2026 09:33:17 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C85310F673
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:33:04 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so1853676f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791883983; x=1792488783; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SnEkf+SshAJve0553z+hLZ8mY5sSHw5Ad0IiJvmX3q0=;
 b=eg9kVZswpF03ZeY6maItPSmXlh0YLTwKUyiEbq6R1JAxiyoRtVrO+dNo+caJTzIfaU
 vS64AdnjKCf+6krokLrMPrtEuOIHjEKIlGXdq5TJSSKVKg7d6JLbbdsBxe4870PoP16b
 Aw1Sa6EArrrtnWZhg2hDYtIKMkBCOGMqnAXShcLrfS03YOu1R57aX3LJ+EsZziwnTI06
 3eV1W24jOZSocrAK4V5rDFinna8xitBklZXSEszvNjj/tpMkwXNw6hidwJjqFUsVZxwZ
 h2hfYs4zOlwQha9iA2LN+L3kQBwUl4Vl+47u0nSTNezpTFQe1GQXhnOKrUoxLS/mpG/i
 EIjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883983; x=1792488783;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SnEkf+SshAJve0553z+hLZ8mY5sSHw5Ad0IiJvmX3q0=;
 b=Pa6B/VFz2u049ii8C8S4eB5TMoeoo8q5U3e0+ubbV3LEuzMCNDNDijYAZ3pnWlwEII
 /D2p2raouNwwfHxQuCtdeHYu7fpNFrWbOUJpZ5XRxZqqbKmG/6TSCXYrEZfC76w4Y3+X
 FxRz4rnWafU1RxSOMFCyQ3HB0vvseNTku9Bn7D1B98n3I8XGGWVB+GBdbSa2SmpEHRHK
 7WzdR4HUw6qCWyzkR6iSshBiQwTKYhtL7xt0u91lsxUgeaXkUwnQlVSrU27dhteS7uKf
 CD0h5div9a0xNw0Lo8LLjTqjH5oK1wclRttlg4dX3E3Y/rIjOKt7A+AzM5j7jMTpawJN
 bCUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIxQoHT8dy9sfN5+8MYG4HSms9KL1GHwaeVDEdEEqC5eq2zGQ9tMkl9P+njdibdCV/RuSFqtBBg5U=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJjKM3MB2T16AJn7yE6c0NxWDFi/YdIc8NXBJuzzAFA2EecyxBs
 7D3/H97Z3wh8Atg4LoDS1/Gyi3HI+6MVeOgWXhrgIw23SurB7H0CjqWF
X-Gm-Gg: AYBFou1hcbWcc58Jj/63fs4hLjddcHSoMiR22bN+jkVBbCSrXA+3k7j98LnqlfabiFu
 oOUZKAwUbrfgQQD0ki2qaydknBmrO0fribXMMWWEsuqPE93L0h2JaJiKaYJFjcPtW3YqRcmfe4m
 73gSrSAGBkzbte6JHPP2gQ3n6daoOIIc+eQ9JYcxbbf5wi19y61FclEZmFqOYKhx/n98RRYLh+X
 klFSnyA/X6sA44wrpUQ8Gr9n1+Fz7h7KCChWpE/H23yXLnocL7dzIvJVJ/Fw2gtntA3XATzW3kj
 Q6LyKCxEu5q/Q++Wwh1kRxHlQR5oNGrTWfTjhyYY4cr8kX89ZteMpQAizadF3qVVkLMqQZ/EQCB
 n3p9PE9rR+n1FaCArMExE6l0B/MiieP7tXJBm8EipOgi0StdODa9JdrmpqKChqESfNKwGrVIqHf
 IkD9xKIG6sQS4bHOisXMWN/ToaQjqMJkCqlWM0jraGIHP18DxNbUNBGzu2slxH1NzUvUgKyRIo8
 XLqsoE6AL5q/2AbQaYPMFWd
X-Received: by 2002:a5d:5f84:0:b0:48b:86:5563 with SMTP id
 ffacd0b85a97d-48dbaae6f0bmr22382083f8f.27.1791883982560; 
 Tue, 13 Oct 2026 02:33:02 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ec6sm3986774f8f.48.2026.10.13.02.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:33:02 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 06/13] dt-bindings: display: add a boot logo node under
 /chosen
Date: Tue, 13 Oct 2026 11:32:36 +0200
Message-Id: <20261013093243.505776-7-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261013093243.505776-1-maximpedraza@gmail.com>
References: <20261013093243.505776-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Products built on the same board often differ only in branding. On UEFI
systems the firmware hands the operating system its boot logo through
the ACPI BGRT; a device tree system has no such table, so today the logo
is built into the kernel, and each product needs its own kernel image.
With U-Boot's Falcon mode the device tree is the only thing that reaches
the kernel, so it is also the only place the logo can come from.

Add a "boot-logo" node under /chosen. The node lives there because a
logo is configuration handed over by firmware rather than a description
of the hardware, as simple-framebuffer nodes already are.

The image is a BMP with 24 bits per pixel and no compression, the
format of the BGRT image, so that one file serves the firmware splash,
a BMP loaded as firmware and this node alike. It is carried either in
an "image" property, which dtc fills in from the file with /incbin/, or
in a reserved memory region the bootloader loaded it into, named by
"memory-region". Exactly one of the two must be present.

"logo-position" takes -1 on an axis to mean centre on that axis, which
is the only way to say it when the device tree does not know the image
size, and "logo-offset" is added afterwards. "rotation" counts degrees
counter clockwise, as for panels, and turns the image rather than the
screen, so position and offset stay in screen pixels. The optional
"background-color" goes with the image, since a logo designed for one
background looks wrong on another.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 .../bindings/display/boot-logo.yaml           | 151 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 152 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/boot-logo.yaml

diff --git a/Documentation/devicetree/bindings/display/boot-logo.yaml b/Documentation/devicetree/bindings/display/boot-logo.yaml
new file mode 100644
index 000000000000..bf4121f24f1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/boot-logo.yaml
@@ -0,0 +1,151 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/boot-logo.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Boot logo supplied by the device tree
+
+maintainers:
+  - Francesco Valla <francesco@valla.it>
+  - Màxim Pedraza Padilla <maximpedraza@gmail.com>
+
+description: |
+  An image for the operating system to show on the display while it boots,
+  handed over by the firmware together with where and how to show it.
+
+  Products built on the same board often differ only in branding. Carrying
+  the logo in the device tree lets a single kernel image serve all of them,
+  each booting with its own device tree, and it works where the device tree
+  is the only thing that reaches the kernel, as with U-Boot's Falcon mode.
+  It plays the part the ACPI BGRT plays on UEFI systems.
+
+  Since a logo is configuration rather than a description of the hardware,
+  the node lives under /chosen, next to the other things firmware hands to
+  the operating system.
+
+  The image is a BMP file with a 40 byte BITMAPINFOHEADER, 24 bits per pixel
+  and no compression, the format of the BGRT image. It is carried either in
+  the node itself or in a reserved memory region the bootloader loaded it
+  into, never both.
+
+properties:
+  $nodename:
+    const: logo
+
+  compatible:
+    const: boot-logo
+
+  image:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description:
+      The BMP file itself, byte for byte, which dtc can fill in from the file
+      with /incbin/. The device tree stays in memory for as long as the
+      system runs, so this is meant for small images; larger ones belong in
+      a reserved memory region.
+
+  memory-region:
+    maxItems: 1
+    description: |
+      Reserved memory region the bootloader loaded the BMP file into, starting
+      at the beginning of the region. The BMP header says how much of the
+      region is image.
+
+      This keeps the image out of the device tree, so that it can be changed
+      without rebuilding the device tree, for instance by loading it from a
+      partition of its own that userspace can update.
+
+      Memory keeps its contents across a reset, and may even across a short
+      power cycle, and the operating system cannot tell a stale image from a
+      fresh one. A bootloader that loads no image into the region therefore
+      disables the node (status = "disabled") or removes it.
+
+  logo-position:
+    $ref: /schemas/types.yaml#/definitions/int32-array
+    description:
+      X and Y coordinates, in screen pixels, of the top left corner of the
+      image once it has been rotated. A value of -1 on an axis centres the
+      image on that axis instead, which is the only way to say it when the
+      device tree does not know the image size, as with a memory region.
+      Defaults to centring on both axes.
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
+      X and Y displacement, in screen pixels, applied after the image has been
+      placed. Mostly useful together with a centred axis, to land the image
+      somewhere other than the middle of a panel whose visible area is not
+      the middle of the mode.
+    items:
+      - description: X displacement
+        minimum: -65535
+        maximum: 65535
+      - description: Y displacement
+        minimum: -65535
+        maximum: 65535
+
+  rotation:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Rotation applied to the image before it is shown, in degrees counter
+      clockwise, as for the rotation property of panels. It turns the image
+      and not the screen, so a quarter turn swaps how much room the image
+      takes up, but logo-position and logo-offset stay in screen pixels
+      either way.
+    enum: [0, 90, 180, 270]
+    default: 0
+
+  background-color:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Colour of the rest of the screen, as 0xRRGGBB. When absent, the
+      operating system uses its own default.
+    maximum: 0xffffff
+
+required:
+  - compatible
+
+# The image lives either in the node or in a reserved memory region,
+# never both and never neither.
+oneOf:
+  - required:
+      - image
+  - required:
+      - memory-region
+
+additionalProperties: false
+
+examples:
+  - |
+    // A 2x1 image, red and blue, centred and 120 pixels below the middle
+    / {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        chosen {
+            logo {
+                compatible = "boot-logo";
+                /* Normally: image = /incbin/("logo.bmp"); */
+                image = /bits/ 8 <0x42 0x4d 0x3e 0x00 0x00 0x00 0x00 0x00
+                                  0x00 0x00 0x36 0x00 0x00 0x00 0x28 0x00
+                                  0x00 0x00 0x02 0x00 0x00 0x00 0x01 0x00
+                                  0x00 0x00 0x01 0x00 0x18 0x00 0x00 0x00
+                                  0x00 0x00 0x08 0x00 0x00 0x00 0x13 0x0b
+                                  0x00 0x00 0x13 0x0b 0x00 0x00 0x00 0x00
+                                  0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
+                                  0xff 0xff 0x00 0x00 0x00 0x00>;
+                logo-position = <(-1) (-1)>;
+                logo-offset = <0 120>;
+                background-color = <0x1e1e28>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 321ecb9f5b5b..0d1decaedde0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9174,6 +9174,7 @@ M:	Màxim Pedraza Padilla <maximpedraza@gmail.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/boot-logo.yaml
 F:	drivers/gpu/drm/clients/drm_splash.c
 
 DRM TTM SUBSYSTEM
-- 
2.39.5

