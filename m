Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109A9606BA3E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lb2jMBer
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BAB310F58B;
	Tue, 27 Oct 2026 13:54:32 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4C310F572
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:54:21 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so20576525e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793109259; x=1793714059; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kjJRYbm0P/rhDwIhbhLgzvyBgDKoIc1GRXvwAOHpom0=;
 b=Lb2jMBercuuVcpoVCvnehpItB3ZfvdCBKIpDJg1SlGLWYGBsHf43Dy8JtCTeVWAUib
 uzbhlGrn9InB2iHFcOIYpwaJecXR/w3IGUzkmTu0OQx/ghrBWJgfhCbJ95+cs6SwAQOt
 xUOHkDdtxv3ZlpVDgVpdL5OXqi4m3xsvc7InrN9Q9W83JihpI7D6T0dym8MErVe8ET0U
 udxR/uzPwNki4g7HWP8AtaC+iX+Fk+RcspAzsM3l+H8vji2Ut1TwpxS+lmMMBhqEDeOb
 tXsMDz8rHkldCe244TFh/bI2so8PpSxaLzl0yDKHebnTQW2kxSkfBf65cpPVKjvWzL5k
 UGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109260; x=1793714060;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kjJRYbm0P/rhDwIhbhLgzvyBgDKoIc1GRXvwAOHpom0=;
 b=uRp68qU5qONf6jvcG+k9gaVbTVk33HiH//c/syc8u+bNYVbnoiApkfF75vPGahnPq9
 p91iw72JOlZjU8ZYoWYywFtTDZlLpK4jUv/+VzrbMHkLJsE4z2wPibfiVX3aF0DyT1NY
 Uc8D/A04UtMrkqJeMXLA3+WhtED9Wek8gNVf8SqvjcVMtdvThvhBb5nc4ZbeF1BsdPDf
 yqv0Bp8zlhHGhzhQRyIm7w+sek3uBHVlR4e+W7Nr9VgXULoIY1nnleW9rXGVlR7+MzvG
 Wd4vjST0xnT9BvVBNsR3RYvg8rafDOkvyYhVN3Ohx7GQHJ+lfL+J7xgghvlJUNynavH7
 hz8w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzX6vupVVgvaYGK13MQouSKVxjGZ16wCTaZVdFOUbkV5tEWgqFSfKgJPICIHrgWv75ka5k4Q7Vvorw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLugbgi7IEzFLYi5Yo+ne4/TzJzbiGYdxqMgIGRWMBva9sycYxl
 Dup1Og6sUgodc4YonCJCPkby6hV0pNvJ5dO2aBD4FDmOGUN7MIWsXODR
X-Gm-Gg: AYBFou35+VQbujsgxfhDoiKKvZWovpKrno5hq1e8F2tcD8zNPQyfPMiUJ89pvRvXYBg
 RSXYeK7yjSuEEtTVwcL22t/ft02h5NOSJREo2AwChUJegyyPph9e0b8DfQVFt6CpvtJ0y1h+K+V
 mfN2/b/OBWsP3cbNnNCx62Cf+FUlQlO2Mxi/VUeZb7qBEZ1IXHmxVW1nbpvqspwj725s0NU+XFC
 Ybvi7SCuBYihpt4e03iK202qwl/i9BXwYL3thQcax0O/xPinVms9bwPNZe76y82ap+AJjgGorqW
 myUY9v0P3ksG6vfp1DNslcUY/H6PibI3koNqhzJM9AvN7BmZBEr4UATQFAU++DooQJtb4//EjRK
 4wLYW8mFAUiRqYwXrzd1fNwMp31xEHgEXJRF71ueRwyFybOYS+hztrHH7uOUIW1FAyoRvI3Q9pu
 fRq2yrMMQGIvne6z43E19dOZImYMZrcLgF5prDXa6mLkiZHDVPyLUxImr0IDEzr3HWdVq3H3rs+
 ky4d9J6KLqloLqML+YqFVDa4S1n127BASo1azArb+7apZlNx6nMhFXzCO0PlF/p0NHB6s51Gg5A
 Q+7OHwk=
X-Received: by 2002:a05:600c:620f:b0:4a1:9078:911 with SMTP id
 5b1f17b1804b1-4a35acc731dmr180025295e9.31.1793109259383; 
 Tue, 27 Oct 2026 06:54:19 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:54:19 -0700 (PDT)
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
Subject: [PATCH v6 15/15] drm/client: splash: document the image sources
Date: Tue, 27 Oct 2026 14:53:42 +0100
Message-Id: <20261027135342.2003632-16-maximpedraza@gmail.com>
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

The overview only said that the client draws a colour or an image. By
now the image can come from three places in a set order, and be placed
and turned. Write it down: the sources and their order, the image
format, placement and rotation, and the background.

Also note that the splash rules out fbdev emulation on the same device,
and that a bootloader that loads no image into a reserved region has to
disable or remove the node, since the region can keep the previous
image across a reset and even a short power cycle.

Pull the overview into Documentation/gpu/drm-client.rst, which covers
the in-kernel clients, so that it is published.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 Documentation/gpu/drm-client.rst     |  6 +++
 drivers/gpu/drm/clients/drm_splash.c | 61 +++++++++++++++++++++++++++-
 2 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-client.rst b/Documentation/gpu/drm-client.rst
index cbcfe30de777..a58d6440d9f2 100644
--- a/Documentation/gpu/drm-client.rst
+++ b/Documentation/gpu/drm-client.rst
@@ -16,3 +16,9 @@ Kernel clients
 
 .. kernel-doc:: drivers/gpu/drm/drm_client_event.c
    :export:
+
+Splash client
+=============
+
+.. kernel-doc:: drivers/gpu/drm/clients/drm_splash.c
+   :doc: overview
diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index d3ed53cde0f5..0fc72a3fe989 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -40,7 +40,66 @@
  * DOC: overview
  *
  * This is a simple graphic bootsplash, able to display either a plain color or
- * a static image.
+ * a static image. It draws once the display driver has registered, and again
+ * on every hotplug, on the outputs there are then, until userspace takes the
+ * display over; when userspace lets it go, the splash is shown again.
+ *
+ * It is selected with ``drm_client_lib.active=splash`` or
+ * CONFIG_DRM_CLIENT_DEFAULT_SPLASH. A device has a single in-kernel client, so
+ * with the splash there is no fbdev emulation: no ``/dev/fb0`` and no
+ * framebuffer console.
+ *
+ * Image sources
+ * -------------
+ *
+ * The image is a BMP with a BITMAPINFOHEADER, or its V4 or V5 extension,
+ * 24 bits per pixel and no compression. It comes from the first of these that
+ * is present, each built in with its CONFIG_DRM_CLIENT_SPLASH_SRC_* option; if
+ * that one then fails to load, only the background is drawn:
+ *
+ * 1. a node compatible with "boot-logo" under ``/chosen`` in the device tree,
+ *    carrying the BMP itself or pointing at a reserved memory region the
+ *    bootloader loaded it into, if that region can be mapped (see
+ *    Documentation/devicetree/bindings/display/boot-logo.yaml);
+ * 2. the EFI BGRT, the image the firmware showed;
+ * 3. the BMP named by CONFIG_DRM_CLIENT_SPLASH_BMP_NAME, ``drm_splash.bmp`` by
+ *    default, loaded as firmware, for instance built into the kernel with
+ *    CONFIG_EXTRA_FIRMWARE.
+ *
+ * With none of them, only the background is drawn.
+ *
+ * A reserved memory region keeps its contents across a reset, and may even
+ * across a short power cycle, and the kernel cannot tell a stale image from a
+ * fresh one: a bootloader that loads no image there disables the node, or
+ * removes it.
+ *
+ * Placement
+ * ---------
+ *
+ * Everything is given as the screen is seen: once turned as its connector
+ * needs, for a panel mounted turned (the panel's orientation) or as asked
+ * with video=...,rotate=. The plane turns it in hardware when it can, and the
+ * splash turns its buffer in software otherwise, as fbdev does with the
+ * console. A panel mounted turned is described on the panel, not here.
+ *
+ * The image is placed at a position in pixels, where -1 centres it on that
+ * axis, and an offset is added afterwards; the result is clamped so that the
+ * whole image stays on screen. A rotation of 90, 180 or 270 degrees counter
+ * clockwise turns the image and not the screen: position and offset stay in
+ * the same pixels, and a quarter turn only swaps how much room the image
+ * takes up.
+ *
+ * A device tree image is placed and turned as its node says, and any other
+ * image is centred and upright. A BGRT image is the exception to the above: it
+ * is drawn at the table offsets on the screen the firmware drew it on,
+ * unturned but for the table's orientation bits.
+ *
+ * Background
+ * ----------
+ *
+ * The rest of the screen is filled with the node's "background-color" for a
+ * device tree image, and with CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR
+ * otherwise.
  */
 
 /*
-- 
2.39.5

