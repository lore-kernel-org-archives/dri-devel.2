Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529E4CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F49C10F77C;
	Thu,  1 Oct 2026 19:59:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CvliMGEV";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BE9B10F77C
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:59:13 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-4a00713639cso38273155e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 12:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790884752; x=1791489552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XVc+fU/zcPUru0u/1bv2Cu0U8wgH+3PGO04gz/Rcw/g=;
 b=CvliMGEVOKYtXITaIp7ZjzigwYxy00UqTqrTZcSQpre7GNznUvxBHnCGOLEXulyyo8
 UojI9VJy+JAMwcyvj1W/7SUn+AONiA5t/ykqaYkjoo9i7gC58Y1uOs/uG25YbqVKT32G
 1OPkTQOB3KwQK3FQA8mcc1LR6ooqkEigdX8dOFAptWXhSDmJRhxGZEPcEwgpIVsu48zc
 DtxPWKLBYpYPzRqvRw7VaRmSeVYJA4+cBsYv00Clcf7MltEC9SeBJGQzLvtnbQvt0F5V
 qR0M9deamQKiGImMKkVjx5AtRCGqvDq1LHKEMVVecy475oBLkOhwFLg+yanmX4LwXryi
 pzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884752; x=1791489552;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XVc+fU/zcPUru0u/1bv2Cu0U8wgH+3PGO04gz/Rcw/g=;
 b=yFBPdNwYHMwbRkdCbaq4lei1goLKted/ZXIfRAZ38A57rqcOgapy7Z78nFGoYS6EpP
 WVcERs1DU2h83NsMfUQc3MnYhX8jz8swh3W54IfJOCUWWgt840r5FzFhHamU99+euN/L
 gAez4ZCYXl6FaRNV5DOYiVc0fWEKeJV7XX8FXvL2wJjp8Ytm2m/F9yUu4ymtgVO8mkOv
 0ZMWILo18Ss537n8fuMDTgeM3hp7rKEwDTWnqOhQvQn3JGWOORBied7jJ/ph6bDWyEid
 UgIuq7Vm1vISMoHHkqecSIFOX+v7gTXH8XGh6fQxVztpJaDNQNzkSulwpgtxi5lbTHSK
 zXZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1/Aq5d9FvHb4o/2g8mBTpIrfSWdwstoQlQN+Qs0VMH6QCoVuPNBTeweDrZ4mm+puhPvg26eLeWCU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mt1Cefpfr8Zs12/03ipIQM10gdOIbMM3oI7qBVbWt5Kw/0h+t8
 sD+LwkQAWMD05y5c2fJarII4jGRjspRaor+GpuvCjOH2vX9g/fG23shU
X-Gm-Gg: AYBFou2Q3lrAO3tcNXaXRl3+xmQgWiEU2+JX3DIujIGGN6sZi/Kl62HzB5QkC5f/ZMK
 YbhWisE10m0T5JEzYbWzd6oqXWiYvHesaFQC9QMl7v5LZ+P7jjHs5sV26yKPhmXsuPvt1cL9+ND
 KAlJvO+zXP7KXJNoQYZpAwEDlPYAQz86k9e5fcLbnwpdunmkd/82pfYITK4rHUgNQErxS+506m4
 Q2ed/Bj4Ep7QUbTmYYn1xYGP/M8lHFEGT/ADjuHtTshZLDk9XWZoqmY3zgh3ffduNkwCcuRbKLQ
 ADkVhdb8ozEfWqzjEBDTBlXhGseG5+Q3KFkioU1tPjyaMYWwPh1qxAanqywkkos5FMDLZnF/XxT
 S5LsTGLO4G0/4On9jwcthCpa3anqiUAAKGJaUkwoNIsVC8HkbiPIq8Z9HREq1JRAR56rUDmFYWa
 uTfsFTLUHCD+he6l7XV4Z9vGCxjSToj1lMOBg3GwlVRw0sfbBfbqedGZmilnQkepKIgYUn2jlRm
 WS3Rifvgp+F41M+IlKDW+wB5lZt6cHwyVDS
X-Received: by 2002:a05:600c:3b01:b0:49f:ce72:e930 with SMTP id
 5b1f17b1804b1-4a02758eed8mr12271135e9.34.1790884751563; 
 Thu, 01 Oct 2026 12:59:11 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0276f92d9sm15031045e9.4.2026.10.01.12.59.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:59:11 -0700 (PDT)
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
Subject: [PATCH RFC v4 11/13] drm/client: splash: turn the BGRT image on
 panels mounted turned
Date: Thu,  1 Oct 2026 21:58:45 +0200
Message-Id: <20261001195847.141192-12-maximpedraza@gmail.com>
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

Since ACPI 6.2, bits 1-2 of the BGRT status tell that the firmware
image is not pre-rotated and how far it has to be turned to show
upright on a panel mounted turned. The client skipped such images
altogether, so tablets and 2-in-1s with a portrait panel got no splash.

Turn the image as the bits say. The values count 90 degree steps
counter clockwise, as Plymouth, the main user of the BGRT, applies
them, and as DRM_MODE_ROTATE_* count, which is what they become.

The offsets need more care. For such an image the firmware gives them
on the upright screen, while the client draws into the buffer as it is
scanned out, which on a panel mounted turned is the upright screen
turned the other way. Check them and apply the efifb sanity check in
the upright frame, then move the image's rectangle into the buffer's
frame. An image without the bits is drawn at its offsets as before:
the buffer is the frame the firmware drew it in, so a pre-rotated image
needs none of the guessing userspace has to do for it.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/drm_splash.c | 77 ++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index 30ba6573424e..34f3c3910be1 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -388,14 +388,14 @@ static bool drm_splash_bgrt_available(struct drm_splash *splash)
 		return false;
 	}
 
-	if (bgrt_tab.status & ACPI_BGRT_ORIENTATION_OFFSET) {
-		drm_info(client->dev, "splash: BGRT rotation bits set, skipping");
-		return false;
-	}
-
 	return true;
 }
 
+static inline u8 drm_splash_bgrt_get_status(void)
+{
+	return bgrt_tab.status;
+}
+
 static inline unsigned int drm_splash_bgrt_get_xoffset(void)
 {
 	return bgrt_tab.image_offset_x;
@@ -445,6 +445,11 @@ static inline unsigned int drm_splash_bgrt_get_yoffset(void)
 	return 0;
 }
 
+static inline u8 drm_splash_bgrt_get_status(void)
+{
+	return 0;
+}
+
 static inline int drm_splash_bgrt_load(struct drm_splash *splash,
 				       const u8 **data, size_t *size)
 {
@@ -452,6 +457,26 @@ static inline int drm_splash_bgrt_load(struct drm_splash *splash,
 }
 #endif // CONFIG_DRM_CLIENT_SPLASH_SRC_BGRT
 
+/*
+ * Since ACPI 6.2, bits 1-2 of the BGRT status say that the image is not
+ * pre-rotated for a panel mounted turned, and by how much it has to be
+ * turned to show upright on it: 0, 90, 180 or 270 degrees, which firmware
+ * and userspace (Plymouth) apply counter clockwise, as DRM counts them.
+ */
+static unsigned int drm_splash_bgrt_rotation(void)
+{
+	switch ((drm_splash_bgrt_get_status() & ACPI_BGRT_ORIENTATION_OFFSET) >> 1) {
+	case 1:
+		return DRM_MODE_ROTATE_90;
+	case 2:
+		return DRM_MODE_ROTATE_180;
+	case 3:
+		return DRM_MODE_ROTATE_270;
+	default:
+		return DRM_MODE_ROTATE_0;
+	}
+}
+
 static u32 drm_splash_find_usable_format(struct drm_plane *plane,
 					 u32 preferred_format)
 {
@@ -709,11 +734,21 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 	}
 
 	if (splash->src == DRM_SPLASH_SRC_BGRT) {
-		x_pad = drm_splash_bgrt_get_xoffset();
-		y_pad = drm_splash_bgrt_get_yoffset();
-
-		if ((x_pad + bmp_width) > scanout->width ||
-		    (y_pad + bmp_height) > scanout->height) {
+		/*
+		 * The BGRT offsets place the upright image on the upright
+		 * screen, which for a panel mounted turned is not the frame
+		 * the buffer is scanned out in. Work in that frame, then move
+		 * the image's rectangle into the buffer's.
+		 */
+		bool quarter = splash->rotation &
+			       (DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270);
+		unsigned int lw = quarter ? scanout->height : scanout->width;
+		unsigned int lh = quarter ? scanout->width : scanout->height;
+		unsigned int xo = drm_splash_bgrt_get_xoffset();
+		unsigned int yo = drm_splash_bgrt_get_yoffset();
+
+		if (xo > lw || bmp_width > lw - xo ||
+		    yo > lh || bmp_height > lh - yo) {
 			drm_err(client->dev, "splash: BGRT image would overflow");
 			return -EINVAL;
 		}
@@ -730,11 +765,30 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 		 * the display looking quite bad.
 		 */
 
-		if (x_pad != (scanout->width - bmp_width) / 2) {
+		if (xo != (lw - bmp_width) / 2) {
 			drm_err(client->dev, "splash: BGRT sanity check failed");
 			return -EINVAL;
 		}
 #endif
+
+		switch (splash->rotation) {
+		case DRM_MODE_ROTATE_90:
+			x_pad = yo;
+			y_pad = lw - xo - bmp_width;
+			break;
+		case DRM_MODE_ROTATE_180:
+			x_pad = lw - xo - bmp_width;
+			y_pad = lh - yo - bmp_height;
+			break;
+		case DRM_MODE_ROTATE_270:
+			x_pad = lh - yo - bmp_height;
+			y_pad = xo;
+			break;
+		default:
+			x_pad = xo;
+			y_pad = yo;
+			break;
+		}
 	} else {
 		x_pad = drm_splash_place_axis(splash->pos_x, splash->off_x,
 					      scanout->width, img_w);
@@ -818,6 +872,7 @@ static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
 	/* The BGRT carries no colour: firmware splashes sit on black */
 	if (drm_splash_bgrt_available(splash)) {
 		splash->bg_color = CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR;
+		splash->rotation = drm_splash_bgrt_rotation();
 		return DRM_SPLASH_SRC_BGRT;
 	}
 
-- 
2.39.5

