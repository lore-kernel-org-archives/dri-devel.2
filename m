Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A1A606AA2B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:54:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE3310F57E;
	Tue, 27 Oct 2026 13:54:11 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 036F310F567
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:54:04 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so2552368f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793109242; x=1793714042; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CNwiH8WXKlzRpf9XA93ERiKn3IeKgsDSdg+szp0134I=;
 b=UBiHiLigdinZLHKqhZf5bgZmDDTRvVJPZzFH388maiCpKTuqlztCN5yXysKNv1Jskx
 DBDwwBfS5EcOp77+sP+5S4z1SMqJhVSw1gQbciVFlUpG5h+cHc2gObUfWG/U0ElnW5UK
 unOYwbNn90ag8pGKDQCV/P0nPzSSg6UdWra6A/XJACkpZ2+F6zu3mIwlNUpmv+OgOEds
 OXix6fMOwz8Lhs3vXhkwsKOUgQ48lByMHQNRLJqmWjHqZKcCpqjpNaImTNI43fKzMFHd
 Y4KQavSnuJQEozG3Ndv0BmKIzL6V2ntMPG3aOZ06x4pB8CnjyzDtFQOIJM9wTv3LVZGH
 1cnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109242; x=1793714042;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CNwiH8WXKlzRpf9XA93ERiKn3IeKgsDSdg+szp0134I=;
 b=iaY7n2Kw+/o0L5AFN9sVnAguYIa2ayxb7FQzcQBCssBsgy5WB+zG/YasRti6jqMNm8
 oMiWH8BY1YL3dghw7l+o2rIazflEbn/uq8bJFXQGzu2JXYMKMk/P06NnxETooLfjWDzE
 Djo5nL901AW6LHSsrnUixiUae/VNb+oEdWvTIgdYtB4PGEe0MbYVsOMz7zNayR2iT8HL
 ysgvvNPVvwx0/tGYBMlZWrpu5TAmuUN78QevpZsBWsw0D59AUBsAIxREe1AyKVWObE2X
 SxIE5MpepbtrNfiNqlonlZg0HV1LXOnxVtqLkwQcjkkD6TkLqZ0tpQu2xAn4gWz1l2Xz
 zn3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeRZsfK+AoGbwWdQtL7+0HJyS5s+1rJeIfJGBUyiUGRqKONchre/ymlhIDICEfEsiphO/Vo055MQM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJZ3qiKrFlvJzMjNsy7vr7KluE+0WJWFXjmPVtLYOHF/7rxsYo6
 sOGapLOC2x40dBXKgjGurgpHm5CoJVAVtbz8EKHPRM7+8JH9eCy8PZ2f
X-Gm-Gg: AYBFou0Q6MrNRgFHLYOnYHm9fNdh8JgLk4eXpS7ZabCvv9tnywMjs8erBtMpPAui2L7
 G6+EpGpUERVgv0GkGlCE8HSueTZ9xxSJ6gYXynin+yBWUNgOU7bOdUbvmDKH+SHaW6UnIOMKp+v
 gPfhDV70LvyslhKf/KtAc8Qsy/vL1MX0vOaQ2aJU8fQoIC8WOf6pkYP7eqp95ca6/GqXpXazTvb
 k85XdDGMJz6TnbPZE0mu4nrzY8JKHwTnhZwXV/sAHu+wOs0ZCMybl42TnkhI+bHFW8PkYBNU0H4
 GYI7hC5WcwE4g/N+/Hzk51rH7Mqt86XUcothLLnRmf/OweBaDj5G59o7w+UHQoLVTmHQq098Elr
 avvFPqyCUmKIgEdW56HXtnfgH7VU1/wEmjrCfxQDfLNt79mTIfavR7bZAJeW6yVr0fMFOlHdaJq
 J5PMGZUl+qs0I6A9afdTMRKQxb825EyU0JX7yK992QvvJufPoOxi7G+yq+pA+NI8skYbMc87xUr
 eDpcH1b0tHWlp8N+SwP3Xt5n/OhLB7WSfX9/tcbq57AfaBYtn4aFoCDOZV6l2nuBUXntzh7vubp
 YeXx4RA=
X-Received: by 2002:a05:6000:29d5:b0:48e:3d35:a18a with SMTP id
 ffacd0b85a97d-48e3eb98289mr9620502f8f.49.1793109242138; 
 Tue, 27 Oct 2026 06:54:02 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:54:01 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/15] dt-bindings: display: add a boot logo node under
 /chosen
Date: Tue, 27 Oct 2026 14:53:34 +0100
Message-Id: <20261027135342.2003632-8-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261027135342.2003632-1-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Products built on the same board often differ only in branding. On UEFI
systems the firmware hands the operating system its boot logo through
the ACPI BGRT; a device tree system has no such table, so today the logo
is built into the kernel, and each product needs its own kernel image.
With U-Boot's Falcon mode the device tree is the only thing that reaches
the kernel, so it is also the only place the logo can come from.

Add a "logo" node, compatible "boot-logo", under /chosen. It lives
there because a logo is configuration handed over by firmware rather
than a description of the hardware, as simple-framebuffer nodes already
are.

The image is a BMP with 24 bits per pixel and no compression, the
format of the BGRT image, so that one file serves the firmware splash,
a BMP loaded as firmware and this node alike. It is carried either in
a "logo-image" property, which dtc fills in from the file with /incbin/,
or in a reserved memory region the bootloader loaded it into, named by
"memory-region". Exactly one of the two must be present.

"logo-position" takes -1 on an axis to mean centre on that axis, which
is the only way to say it when the device tree does not know the image
size, and "logo-offset" is added afterwards. "rotation" is the one of
panel-common.yaml, degrees counter clockwise, but turns the image rather
than the screen, so position and offset stay in screen pixels. The
optional "background-color" goes with the image, since a logo designed
for one background looks wrong on another.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 .../bindings/display/boot-logo.yaml           | 156 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 157 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/boot-logo.yaml

diff --git a/Documentation/devicetree/bindings/display/boot-logo.yaml b/Documentation/devicetree/bindings/display/boot-logo.yaml
new file mode 100644
index 000000000000..9cd4b2565112
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/boot-logo.yaml
@@ -0,0 +1,156 @@
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
+allOf:
+  - $ref: panel/panel-common.yaml#
+
+properties:
+  $nodename:
+    const: logo
+
+  compatible:
+    const: boot-logo
+
+  logo-image:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description:
+      The BMP file itself, byte for byte, which dtc can fill in from the file
+      with /incbin/. The device tree stays in memory for as long as the
+      system runs, and some architectures limit its size (arm64 to 2 MB), so
+      this is meant for small images; at three bytes per pixel, larger ones
+      belong in a reserved memory region.
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
+    default: [-1, -1]
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
+      the middle of the mode. Defaults to no displacement.
+    default: [0, 0]
+    items:
+      - description: X displacement
+        minimum: -65535
+        maximum: 65535
+      - description: Y displacement
+        minimum: -65535
+        maximum: 65535
+
+  rotation:
+    description:
+      Rotation applied to the image as the screen is seen, in degrees counter
+      clockwise, as for the rotation property of panels. It turns the image
+      and not the screen; a panel mounted turned is described by its own
+      rotation property, which is made up for first, so this means the same
+      whichever way the panel is mounted. A quarter turn swaps how much room
+      the image takes up, but logo-position and logo-offset stay in pixels of
+      the screen as seen either way. Defaults to 0.
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
+      - logo-image
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
+                /* Normally: logo-image = /incbin/("logo.bmp"); */
+                logo-image = /bits/ 8 <0x42 0x4d 0x3e 0x00 0x00 0x00 0x00 0x00
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

