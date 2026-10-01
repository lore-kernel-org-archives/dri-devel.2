Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 341D9CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8612210F781;
	Thu,  1 Oct 2026 19:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k/vsXwe7";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D21D310F77D
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:59:16 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ccf3ca626so43130325e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 12:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790884755; x=1791489555; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6RrSkqTXqNdvcO9If5wraMvoT6iTfXjvMrsjx83kGx8=;
 b=k/vsXwe70pKOAR9F/SHmftgyITJZROrgIBAMT7YiKajNDIT+tszp+NtFmW0SI0yHB0
 72Doe4nIEHEbTqjbOipIEdziSN/O0dKsw9E+I+zOX3eXC4KfNrORAOHqNP4LgPnch42m
 h4B1auoB4DxOyA3VnL9+ACD0sJlnh3YycubXpHVRYag/h8oJ2TTueVPdy7FHBL4yfDuH
 /tjwcv2K9bXsa4PCNt+PyyyuJHiVCNR0DFQfWo005qarVvfzY/l+grjkze7HNxC84Xeh
 Jh4icZdyghIRFG0Xi5cqbBoHnwPGcPxyn60f44czjaJ9BL/hxl1wIm2NqZNw0O2E36xQ
 K0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884755; x=1791489555;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6RrSkqTXqNdvcO9If5wraMvoT6iTfXjvMrsjx83kGx8=;
 b=1fXBvakxTl2ZT1h8eCwlGJZj/iM7TxCxjWwQxdZoRByZZYXpiQATg6A7DHQ/psYCZX
 TcclpkJC+5FKAo3MUoJfndrmfZFRIDuW9j8Mktcqw6uBySyskz2qXvbWKlvzH6pZO6mT
 lAqykH/nMPtrGpRoC01+kxv4Yy+GWiPcjhK9SlWAKe4Jhbj/txDsyWl9QQH5IsoQ81/m
 AGWCxZaRH+MW5uORbwwul27gR13dvK6/LJW4tDHGipYkP1k3iCOE44XCvmFEP5Lm7Hsj
 TuljMqQTLMjQbjXhWQ9wI3bVtrn5Ab+jsj5rmamSdwKpkgGBFii16fqSxJUxvtGS56KI
 Z+ZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwiWBqfzruiCN0T+amDiM5etEDB6RLlVzQEihshpCKcPRBjrCv3Nc7KT5eGHnxsALhqQj0I5QqdIcI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lHU752mISQjWcNzZUIr3x/VVBz8EL0j9LLCkgd3lVLNxLbJTPD
 xBJ3YZsmv+rhj/Vvcwm1wuUGL4ZhAyWUyOF+0MhrJ98gLez3WkMZ5N+a
X-Gm-Gg: AYBFou3Ew823HM+8juohmUFwFhWCb1omWTTqxbdNOSNf39SgkdcTUa6mr60yLfxsZqu
 5keFu51D7Zeyb36jEGvPDVoxv+0P+9t/aPhxVT2DGoIuidvyn7icGhsqRrhGMM3S3NMzP8en26T
 0nS+poEoLHLRUoEZx4CXHWewgujU2ANZJkymnzy63fokUKxd7Y3kjAe67khEj0RMseSDmyokiOi
 vVDugSmepCZpN3tbmpspcQhsiHcyVtHi+99iZ3O+UzsPYeff/t7PzLmWkuI/4XqrsFSNVuSXttC
 5sBCacHXwON+D+w1/wSGrPBqo83Z0nPw9Msog3hwmmFtc6llVNQFb6qUT0ClZjdydmzdGCq7VYn
 lDIvBHcrzQlNufLJ7ws/ROGZPVCS35OKpkp9MJSn0GCTcco76eREqcxi7GYUug+GgZ+GkEBNsHT
 ysCDDzU97TPdiwN0cR2o8mKAoVu0+/fXpxTxIB6bVGqfuGs5MHHyDGzHwOG4Aq2ifHKdibC/pRm
 M8ESmG01IkDHY9wMh8uhB7/kA==
X-Received: by 2002:a05:600c:6d1:b0:4a0:1d3d:502d with SMTP id
 5b1f17b1804b1-4a02755f856mr8018525e9.10.1790884755180; 
 Thu, 01 Oct 2026 12:59:15 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0276f92d9sm15031045e9.4.2026.10.01.12.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:59:14 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC v4 13/13] drm/client: splash: document the image sources
 and parameters
Date: Thu,  1 Oct 2026 21:58:47 +0200
Message-Id: <20261001195847.141192-14-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261001195847.141192-1-maximpedraza@gmail.com>
References: <20261001195847.141192-1-maximpedraza@gmail.com>
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

The overview only said that the client draws a colour or an image. By
now the image can come from four places in a set order, be placed and
turned, and every part of that can be overridden from the command line,
each parameter for its own part only. Write it down: the sources and
their order, the image format, placement and rotation, the background,
every parameter with its format, and what a parameter given alone
keeps from the image source.

Also note that the splash rules out fbdev emulation on the same device,
and that a bootloader that loads no image into a reserved region has to
clear it, since the region can keep the previous image across a reset
and even a short power cycle.

Pull the overview into Documentation/gpu/drm-client.rst, which covers
the in-kernel clients, so that it is published.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 Documentation/gpu/drm-client.rst     |  6 +++
 drivers/gpu/drm/clients/drm_splash.c | 78 +++++++++++++++++++++++++++-
 2 files changed, 83 insertions(+), 1 deletion(-)

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
index 8d056edfee56..85083337870c 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -37,7 +37,83 @@
  * DOC: overview
  *
  * This is a simple graphic bootsplash, able to display either a plain color or
- * a static image.
+ * a static image. It draws once the display driver has registered, and stays
+ * until userspace takes the display over.
+ *
+ * It is selected with ``drm_client_lib.active=splash`` or
+ * CONFIG_DRM_CLIENT_DEFAULT_SPLASH. A device has a single in-kernel client, so
+ * with the splash there is no fbdev emulation: no ``/dev/fb0`` and no
+ * framebuffer console.
+ *
+ * Image sources
+ * -------------
+ *
+ * The image is a BMP with a 40 byte BITMAPINFOHEADER, 24 bits per pixel and no
+ * compression. It comes from the first of these that provides one:
+ *
+ * 1. a BMP loaded as firmware and named on the command line with
+ *    ``drm_client_lib.splash_bmp=``; ``splash_bmp=none`` asks for no image at
+ *    all, and a named file that is missing gives no image rather than falling
+ *    back to the sources below;
+ * 2. a "boot-logo" node under ``/chosen`` in the device tree, carrying the BMP
+ *    itself or pointing at a reserved memory region the bootloader loaded it
+ *    into (see Documentation/devicetree/bindings/display/boot-logo.yaml);
+ * 3. the EFI BGRT, the image the firmware showed;
+ * 4. ``drm_splash.bmp`` loaded as firmware, for instance built into the kernel
+ *    with CONFIG_EXTRA_FIRMWARE.
+ *
+ * With none of them, only the background is drawn.
+ *
+ * A reserved memory region keeps its contents across a reset, and may even
+ * across a short power cycle, so a bootloader that loads no image there has
+ * to clear it: the kernel cannot tell a stale image from a fresh one.
+ *
+ * Placement
+ * ---------
+ *
+ * The image is placed at a position in screen pixels, where -1 centres it on
+ * that axis, and an offset is added afterwards; the result is clamped so that
+ * the whole image stays on screen. A rotation of 90, 180 or 270 degrees
+ * counter clockwise turns the image and not the screen: position and offset
+ * stay in screen pixels, and a quarter turn only swaps how much room the image
+ * takes up.
+ *
+ * A device tree image is placed and turned as its node says. A BGRT image is
+ * placed at the table offsets and turned as its orientation bits say, the
+ * offsets then being given on the upright screen. Any other image is centred
+ * and upright.
+ *
+ * Background
+ * ----------
+ *
+ * The rest of the screen is filled with the node's "background-color" for a
+ * device tree image, and with CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR
+ * otherwise.
+ *
+ * Command line
+ * ------------
+ *
+ * What the command line gives wins over every source, each parameter only for
+ * what it says, and only when it is given:
+ *
+ * ``drm_client_lib.splash_bmp=NAME``
+ *   BMP to load as firmware, or ``none`` for no image.
+ * ``drm_client_lib.splash_color=0xRRGGBB``
+ *   background color, whatever the image.
+ * ``drm_client_lib.splash_pos=X,Y``
+ *   position; ``-1,-1`` centres, ``-1,183`` centres horizontally only.
+ * ``drm_client_lib.splash_offset=DX,DY``
+ *   offset added to the position, for instance ``0,80``.
+ * ``drm_client_lib.splash_rotation=DEGREES``
+ *   0, 90, 180 or 270, counter clockwise.
+ *
+ * Positions take both values, or are ignored with a warning. Since each
+ * parameter only replaces its own part, the rest keeps coming from the image
+ * source: ``splash_offset=`` alone moves the image from where the source puts
+ * it, centred for a BMP loaded as firmware, and ``splash_pos=`` alone keeps a
+ * device tree node's "logo-offset". Give both to place the image exactly. A
+ * BGRT image placed from the command line is placed in screen pixels like any
+ * other: the table offsets are then not used.
  */
 
 /*
-- 
2.39.5

