Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9D2CC6B10
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4D4610F68A;
	Tue, 13 Oct 2026 09:33:21 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4B8110F678
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:33:15 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48b02b1b4cfso3036820f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791883994; x=1792488794; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BdKVfmAGa7RaZVKgQWROr2rYza34vttyTey4iUR61tg=;
 b=gNS4M+kxqLg32arzfQufJ4hgAwRhDldut+e66JjPZN3OluNFtnf7yQ5s8POgjOZcJQ
 Zi6nJnmG0Eag5oTodwAdpjGmYbhJg4YQmZhsqLkZMQUss7A8auCSixVr25X3/Nxa9UHi
 We/NoOopP+r/kO58xHE67A3uVmVKw1PCQsjg6C9VNNUNgpHj7me70mwsFANvBMx6PRYs
 wMNfr5E02guQZezraGgLveCkKr6GOlHqH1J0i9fxdCN98Ff5N8loVlRQ83Yt1hCNDwz2
 3io+deYOs/STP2xNjst1CUXGnMI0N2OP9XFBEc3GiZQ9Wi6bSd0NtZ9OOX49jHkD271b
 k7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883994; x=1792488794;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BdKVfmAGa7RaZVKgQWROr2rYza34vttyTey4iUR61tg=;
 b=R4tdnVHPVY3Xh/iH2mfc1rDwu8JNrOG/4SdHOmb5iVkXLJcICA2XRMJLEBqpdqySmZ
 Y1H1D1U0JTrUoI3UjCm6aSTn5qi6pCg2LEmHyv+BlJC/r2yzjYPK0D5LpNfBfUnaBdUt
 QJIbPNyNqpUa2SoAFnZtoDHjdEBCSNAve7J1jWiyCYKPluWnpZ3I1GiD6e4DjS8T4y4j
 f5s9xjinmSFDORbWp4BKtDmJgGP7bxYdiO4G0/iO4OEjx7WhdY2Waa811yUNcv+nk8Bm
 /RyfbHr+CWGDO62nBqq0ve/G+sbcHP0LXicGKGmsVWyxIKVbsInpB0Mh3WEFKwdqv8OZ
 oOFg==
X-Forwarded-Encrypted: i=1;
 AKwUvBx75cQo48Pf2QWJZnLi/7yzYd6lMTB2Em+Cs6ArDPLPIPhgrc9JHIK9hPSYDGS1wcgeJQWjBuxntSA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIm2CIDvakzZ/BBvt25cU4rKJ1+57ahBHj9cjm5ATj4/igzLTtU
 /RTln5OKuXf2fs4XovACoAE4g2rsgTc4zR6Ki55pvbUFbRcz9s/O1FuX
X-Gm-Gg: AYBFou1TMh4q6zNaQimQvrsL7i3XbozK9p0okophnF4qnclH068ke+c+a7eIJZAyCvT
 LE2gNLAhmeLALjpgOHFQdL8ANq2SSzUAupnct/MtzV/1VlUQ8bbZjJz8ig+ASB2xJWuHiA79wWw
 ZwQ2+ajQ00ZN6ezDImL5WnaP0kudZQPx6wd6CkIom4wgx5gG3AN7aAZ8FL23bQvrxw5l7xivNDL
 RhNzZjSHxlO+xo178xt8lKFhwm5ezscHdBNcqtZiUkyomKTYid0l8wTwM2b1efrhzTkf8KhMHrd
 5gbN3Ylzk9sfr/BBgG7VnR33ylovFeD2aK4yKCCLpLRuuduMYE8wa4f9Fljd1FHA+ExhX0j3Y9Y
 eH0Ti0Zeb8upAFijwRkDgoK71s7SbatKWsRkIwZhk9EozHRz8SjrRuKW2XWX3p/gja/7DEfm72j
 06yTkXAzq9NFUV0oqRd4PgIo3zC7Y4QSdn61UXGigjgeSbS3H4BW1zE8qf0q29BByifD/8E8XUC
 L6V0IrvBqFPGzvN6Zj0Vjus
X-Received: by 2002:a05:600d:864c:10b0:4a1:8bff:9284 with SMTP id
 5b1f17b1804b1-4a18dcd532cmr183789385e9.15.1791883994018; 
 Tue, 13 Oct 2026 02:33:14 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ec6sm3986774f8f.48.2026.10.13.02.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:33:13 -0700 (PDT)
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
Subject: [PATCH v5 11/13] drm/client: splash: turn the BGRT image on panels
 mounted turned
Date: Tue, 13 Oct 2026 11:32:41 +0200
Message-Id: <20261013093243.505776-12-maximpedraza@gmail.com>
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
 drivers/gpu/drm/clients/drm_splash.c | 67 +++++++++++++++++++++++-----
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index 463aff27c747..4c30de7c5c16 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -398,11 +398,6 @@ static bool drm_splash_bgrt_available(struct drm_splash *splash)
 		return false;
 	}
 
-	if (efi_bgrt_status() & ACPI_BGRT_ORIENTATION_OFFSET) {
-		drm_info(client->dev, "splash: BGRT rotation bits set, skipping");
-		return false;
-	}
-
 	return true;
 }
 
@@ -431,6 +426,26 @@ static int drm_splash_bgrt_load(struct drm_splash *splash, const u8 **data,
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
@@ -688,11 +703,21 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 	}
 
 	if (splash->src == DRM_SPLASH_SRC_BGRT) {
-		x_pad = efi_bgrt_image_offset_x();
-		y_pad = efi_bgrt_image_offset_y();
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
+		unsigned int xo = efi_bgrt_image_offset_x();
+		unsigned int yo = efi_bgrt_image_offset_y();
+
+		if (xo > lw || bmp_width > lw - xo ||
+		    yo > lh || bmp_height > lh - yo) {
 			drm_err(client->dev, "splash: BGRT image would overflow");
 			return -EINVAL;
 		}
@@ -709,11 +734,30 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
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
@@ -797,6 +841,7 @@ static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
 	/* The BGRT carries no colour: firmware splashes sit on black */
 	if (drm_splash_bgrt_available(splash)) {
 		splash->bg_color = CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR;
+		splash->rotation = drm_splash_bgrt_rotation();
 		return DRM_SPLASH_SRC_BGRT;
 	}
 
-- 
2.39.5

