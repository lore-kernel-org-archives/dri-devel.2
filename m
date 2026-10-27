Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEA3606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a88xAYIs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B8110F584;
	Tue, 27 Oct 2026 13:54:31 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A6110F583
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:54:17 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso2546734f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793109255; x=1793714055; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4ZUO0/RrkqHsNpo8fK7tPpZvASb/BT+Zvsy0BqgEIsw=;
 b=a88xAYIsM0yqAUj0YR7TSN+uzrLctfn6GjXykWCH9/5pmatDLI0xejmtonxEaLpHzL
 hIxXZIkRcXahe2YKp58Cc1Fq15pKpRPVjo8SlByqPkTHMBR4bAT9aKKCMO48bz9EYNwI
 kZH+i+xq5G2ztjJRRjeyhGSLQDm9dl6/wZAR4PActSsuWqG2d0WxKufACn7X4ByQFckq
 +fwqYqyCgBEks77mISsm4IgH0TR03HSNhFbgxPoi/AmV/c1LS3YkMeERoE8WA/L6ir5G
 B24LJm0gVnJY82r4Eke27rqUyGVJkdta2uriCs9nfSiDUSTtkE3W+JF1EJ5qsdkkKnKg
 DuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109255; x=1793714055;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4ZUO0/RrkqHsNpo8fK7tPpZvASb/BT+Zvsy0BqgEIsw=;
 b=PWCBmI/ZCFg3o/gEytBMTfBL+k2pDjAg6Y7E0wIIqMXWgkXPJdWG03l1OBtD6nZcsk
 ds3oo3Wbs7j6QV1vmPXldPXrkvAx2zuR4yqoOxfxVeojM7ZrmtdEapK9jY1fWk7mXw7q
 7yoQlp6VdwSSGK7USvNZUNixFvDgz2LPs9jyyucDdRDEGqorcXrV6vuCrNcCexhqlwjm
 2Blsx+Wo5Mu/4vy89POzDhzMpI3NVMPRkkJHLTDWmxxYh2VfvYftbNMbK537xarX8N96
 JhH8wZjFUCfZKr8OC1qhcS7CWKWTJmJ3aj5gSFbneBCgTr7Nn+/8M3wskUdACvnrhuaA
 cG/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwkGjuVFZHDo2MHtO79XI2Xy3UU2d1SG5+E+kIODDK4PiEf/NP+h3sMhcDjNNae+b4eYGrJ+AZ83C4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIaRP9sk/K3yYGO7wcUYtlCL8sWehF8vOMXUO2RVPbFJdga0+XB
 jMYhEEHsFGh2iKq3wMYodDmONdQKqeAe6nevS2XyIsxQu9++JdyUQY+8
X-Gm-Gg: AYBFou0C5LtgDhYeWyk8Yx36CUpY/naJa2apn2F6hq+w7s64oii6yN1DZ1ftRYEtHmp
 nAnvhnLbz4TjcXx9uwhEuVWwIycbj5e218fboHYv7jZepL8A6G5eiDAbtL8pbtjahtJ2nkuAJAi
 Fz/8+NR4srled4cqyyfRiAF8527Jszn0J/qXRApQJ/D39m8odm3aBMhX0tjk/+xA3PcAXG4leyO
 8pfQNNlEU3T4qY6jg7K3NAve5Xo3YM5fbiNMPw49btfj6f3rp3mK1PB/Np0ZIWAK3LUJIhjEtU5
 y+kqpNs4OR3Oc3Mtjsg2KQtZq8OIuYQRf65Vlra+/N0PMj6WKS8pfAmGdIi+eij48ZoxhdOcLTz
 zEKwhTCIAL7xGF2MCzdX3VC7Ju5Nnlr62ONk9GqEGZ7RURZ+chhvD1pvIl5Xda7QFNzFtyVkqhB
 0SJKcMgn19gk5M//zn46PuSJ5bEkt+gOy5eyJM5ke4JT01bEjYYC42X3qO87FthtPPpbOZoZGd1
 8CO/qGhEi1Q8/Dx9kQHyqKfXGym6Ily8miPVT/ZLzhHCINnQoVb3wzAizwGuuGrCZEhvdXev3Dz
 BFgiLG4=
X-Received: by 2002:a05:6000:41c3:b0:48e:3b48:6f1 with SMTP id
 ffacd0b85a97d-48e3eba6805mr18121353f8f.54.1793109255358; 
 Tue, 27 Oct 2026 06:54:15 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.54.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:54:14 -0700 (PDT)
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
Subject: [PATCH v6 13/15] drm/client: splash: turn the BGRT image on panels
 mounted turned
Date: Tue, 27 Oct 2026 14:53:40 +0100
Message-Id: <20261027135342.2003632-14-maximpedraza@gmail.com>
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
 drivers/gpu/drm/clients/drm_splash.c | 70 +++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index 3f54bec87413..0bf9d969dd8f 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -412,11 +412,6 @@ static bool drm_splash_bgrt_available(struct drm_splash *splash)
 		return false;
 	}
 
-	if (efi_bgrt_status() & ACPI_BGRT_ORIENTATION_OFFSET) {
-		drm_dbg(client->dev, "splash: BGRT rotation bits set, skipping\n");
-		return false;
-	}
-
 	return true;
 }
 
@@ -449,6 +444,26 @@ static int drm_splash_bgrt_load(struct drm_splash *splash, const u8 **data,
 	return 0;
 }
 
+/*
+ * Since ACPI 6.2, bits 1-2 of the BGRT status say that the image is not
+ * pre-rotated for a panel mounted turned, and by how much it has to be
+ * turned to show upright on it: 0, 90, 180 or 270 degrees, which firmware
+ * and userspace (Plymouth) apply counter clockwise, as DRM counts them.
+ */
+static unsigned int drm_splash_bgrt_rotation(void)
+{
+	switch ((efi_bgrt_status() & ACPI_BGRT_ORIENTATION_OFFSET) >> 1) {
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
@@ -724,11 +739,21 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 	}
 
 	if (splash->src == DRM_SPLASH_SRC_BGRT) {
-		x_pad = efi_bgrt_image_offset_x();
-		y_pad = efi_bgrt_image_offset_y();
-
-		if (x_pad > scanout->width - bmp_width ||
-		    y_pad > scanout->height - bmp_height) {
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
+		unsigned int xo = efi_bgrt_image_offset_x();
+		unsigned int yo = efi_bgrt_image_offset_y();
+
+		if (xo > lw || bmp_width > lw - xo ||
+		    yo > lh || bmp_height > lh - yo) {
 			drm_err(client->dev, "splash: BGRT image would overflow\n");
 			return -EINVAL;
 		}
@@ -744,11 +769,30 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 		 * edge of the display, looking quite bad.
 		 */
 
-		if (x_pad != (scanout->width - bmp_width) / 2) {
+		if (xo != (lw - bmp_width) / 2) {
 			drm_err(client->dev, "splash: BGRT sanity check failed\n");
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
@@ -823,8 +867,10 @@ static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
 		return DRM_SPLASH_SRC_DT;
 	}
 
-	if (drm_splash_bgrt_available(splash))
+	if (drm_splash_bgrt_available(splash)) {
+		splash->rotation = drm_splash_bgrt_rotation();
 		return DRM_SPLASH_SRC_BGRT;
+	}
 
 	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP))
 		return DRM_SPLASH_SRC_BMP;
-- 
2.39.5

