Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C08606BA3E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmndbgSM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 601E210F58E;
	Tue, 27 Oct 2026 13:54:32 +0000 (UTC)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032F110F570
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:54:13 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so773709f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793109251; x=1793714051; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=94apHeDFvaEybH6BDSStfeFodhITURdJ4ustmG0CefA=;
 b=BmndbgSMufs6Y5sR2qd+G0ToRkzgiyCiy7xwH9hMGBv7e71F2NNhe3ra/bgnpKihX8
 wsNWNfA6DtxdenuxQYSCYNGUcOQ2ZV0mUV2xSS7spohz6IRBKhbAzPm9LTSKKH2lyz1B
 sWfSpdN5h4gvTzeOinX7a9Tw0v2OZOQu8PxjnKeN9HKUMLvI5dTMoWJGOA7lIUqpP/E4
 YTI3+G0uKg3t2bH5gpC8EqgPaj3vuMxyGT0ynhCqwla3U0DWrnrsuMWUDslJwZaQeM5Q
 Dn03D5LLNY5pNz3zSmikp13sEeXBVKcJA/HePu5BjzrFa9R0CeLCKf3AQDAjZ1gQSg8I
 Yvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109251; x=1793714051;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=94apHeDFvaEybH6BDSStfeFodhITURdJ4ustmG0CefA=;
 b=wutOIhIgkrXyBDwYUN5zpKz8lx/DozAVK58nl5DAqvZRXdGBclK4F/tIKT05hou211
 6f5/rAVbQftZ+Qh70d9RdXPazyM/ZbnmoboSfXBCSAyZU35rHmHCbOi15LFOTguvemDd
 sjSUGioOmsSziNQ4l+bbmYEVNSenm1pieblbH9XgXqRz+cH3tpFu61O5QLpv6sfcu2vR
 3kjy8bdrP4vsUqarxHi/j5bQQV1bkyAp25dxOvs8HPKmRZjYvcya6qlhOGK0MCMzIlIM
 MbetBGZCIAzY49VK9qSyf807DyS/HSwMbu6FGjMQi3mfhqICY1+q0CyqAnb1u6Qyaq4d
 9jjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBztTZYpJQdT3l3vX99zlJPTR1qrYUbB8mbC7mpdDmUcPMORzDa9CZwQRTP5a8LZSDxWgXGV1Sr9Zls=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKdxdB4SGW8svaQR9TTcz7I7/hl7rVReB2oRH7Pp8ti0xC2lsNA
 IygA+mhl+DM24txI6LNNENNWEvdKXFdjOMAMQ8fJlUPInSj2jrGwq0IZ
X-Gm-Gg: AYBFou0djeJwf/ulWvoejpBQyAyfNlgQJM9tO2fwv3bzL2hJkATd/ZLmA5bIY6UQArR
 sv8ll2qagJOkjY38XVljgqst+LdmsfR6vIXwT8X2/kc7/zWOJEsokHoGqbYugs0wezLKqvtRgSk
 5JVqR7ee6olEtOmDM/9Tv31OT8JxYbFzV04ZIhzIPjt2FXlVy1bliQPk1CjQt2F+4kLRN4E0q8Y
 Im1N/j4r445qYy8hgrEbW6XG28O//t7+toDiD7TLuahxgfLy6O2L26rjT/WuBYr92gufx83xfZj
 Xn7Q4ecgvf4AYGXhafqTFnBWyk1Gr9Egk3Ta3Mguv1GBBVMuKE0cR5No9lKY6nOMNgUWftPjqQg
 2BBwqyHZMUjks/scitO0+TSllKy9X2K0wf/by74V+HN/MvshWH0sE1ZjbSltQWS5+IQGb/9IxVp
 av0AKx1zFBk+PxByC/55wChpqfbniDi10unvM4ZFxu7lUC+bnL97U53AP1NcwIEZ2P4sidhsLjw
 Zp9iZwa60yzJuPF/k1jYPepu+3uWs0F2cqou+22oXpxYTs5/rTbp0WYpIHYJYriqPygMH+1/mAa
 WGg+ieEsx+c53nkIg9AkrUP5SB/M
X-Received: by 2002:a5d:5f44:0:b0:48e:55bd:9ce2 with SMTP id
 ffacd0b85a97d-48e55bd9d56mr6249783f8f.20.1793109251114; 
 Tue, 27 Oct 2026 06:54:11 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:54:10 -0700 (PDT)
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
Subject: [PATCH v6 11/15] drm/client: splash: turn the device tree image as it
 asks
Date: Tue, 27 Oct 2026 14:53:38 +0100
Message-Id: <20261027135342.2003632-12-maximpedraza@gmail.com>
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Let the device tree node ask for the image to be turned, for a logo
drawn in one orientation and meant to be seen in another, with a
"rotation" property counting degrees counter clockwise, as panels
already do and as DRM_MODE_ROTATE_* count, which is what it is kept as.
It describes the image only: a panel mounted turned is described on the
panel, and a later patch in this series makes the splash follow it.

The rotation turns the image and not the screen: "logo-position" and
"logo-offset" stay in screen pixels, and a quarter turn only swaps how
much room the image takes up. Placing it in a frame that turned with it
would make the same pair of coordinates mean different places on the
same panel, decided by a property that describes the image.

The turn happens in the first of the two drawing steps, which reads
the BMP into an XRGB8888 buffer: it walks the source through the
rotation, so the buffer holds the image as it is to be seen. The second
step, into the framebuffer's format, does not change.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/drm_splash.c | 109 +++++++++++++++++++++++----
 1 file changed, 93 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index 81070547390f..a50036155763 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -28,6 +28,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_mode.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 
@@ -114,6 +115,8 @@ struct drm_splash {
 	 */
 	s32 pos_x, pos_y;
 	s32 off_x, off_y;
+	/* One of DRM_MODE_ROTATE_*: turns the image, not the screen */
+	unsigned int rotation;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -273,10 +276,34 @@ static void drm_splash_dt_pair(struct drm_splash *splash,
 static void drm_splash_dt_placement(struct drm_splash *splash,
 				    struct device_node *np)
 {
+	u32 val;
+
 	drm_splash_dt_pair(splash, np, "logo-position", -1, 65535,
 			   &splash->pos_x, &splash->pos_y);
 	drm_splash_dt_pair(splash, np, "logo-offset", -65535, 65535,
 			   &splash->off_x, &splash->off_y);
+
+	/* Degrees counter clockwise, as for panels, and as DRM counts them */
+	if (!of_property_read_u32(np, "rotation", &val)) {
+		switch (val) {
+		case 0:
+			splash->rotation = DRM_MODE_ROTATE_0;
+			break;
+		case 90:
+			splash->rotation = DRM_MODE_ROTATE_90;
+			break;
+		case 180:
+			splash->rotation = DRM_MODE_ROTATE_180;
+			break;
+		case 270:
+			splash->rotation = DRM_MODE_ROTATE_270;
+			break;
+		default:
+			drm_warn(splash->client.dev,
+				 "splash: %pOF: unsupported rotation %u\n",
+				 np, val);
+		}
+	}
 }
 
 /*
@@ -494,19 +521,59 @@ static unsigned int drm_splash_place_axis(s32 pos, s32 off, unsigned int span,
 	return clamp_t(s64, coord + off, 0, last);
 }
 
-/* The rows of a 24 bpp BMP, bottom up or top down, upright in XRGB8888 */
-static void drm_splash_bmp_decode(u32 *dst, const u8 *src, unsigned int spitch,
+/*
+ * The pixels of a 24 bpp BMP, whose rows go bottom up or top down, into
+ * XRGB8888, turned by @rotation, one of DRM_MODE_ROTATE_*, which count
+ * counter clockwise. A quarter turn swaps width and height in @dst.
+ *
+ * Each source pixel is three bytes read on their own, since a BMP row is
+ * only padded to four bytes as a whole and the image need not be aligned.
+ */
+static void drm_splash_bmp_decode(u32 *dst, const u8 *sbuf8, unsigned int spitch,
 				  unsigned int width, unsigned int height,
-				  bool invert_y)
+				  bool invert_y, unsigned int rotation)
 {
+	bool quarter = rotation & (DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270);
+	unsigned int dw = quarter ? height : width;
+	unsigned int dh = quarter ? width : height;
+	/* A positive BMP height stores the rows bottom up */
+	ptrdiff_t down = invert_y ? -(ptrdiff_t)spitch : spitch;
+	const u8 *first = sbuf8 + (invert_y ? (height - 1) * spitch : 0);
+	const u8 *last = first + (height - 1) * down;
+	ptrdiff_t step_x, step_y;
+	const u8 *src, *p;
 	unsigned int x, y;
 
-	for (y = 0; y < height; y++) {
-		const u8 *p = src + (invert_y ? height - 1 - y : y) * spitch;
+	/*
+	 * Where the source pixel for the top left of the turned image is, and
+	 * how far one step right and one step down in it move in the source
+	 */
+	switch (rotation) {
+	case DRM_MODE_ROTATE_90:
+		src = first + 3 * (width - 1);
+		step_x = down;
+		step_y = -3;
+		break;
+	case DRM_MODE_ROTATE_180:
+		src = last + 3 * (width - 1);
+		step_x = -3;
+		step_y = -down;
+		break;
+	case DRM_MODE_ROTATE_270:
+		src = last;
+		step_x = -down;
+		step_y = 3;
+		break;
+	default:
+		src = first;
+		step_x = 3;
+		step_y = down;
+		break;
+	}
 
-		for (x = 0; x < width; x++, p += 3)
+	for (y = 0; y < dh; y++, src += step_y)
+		for (x = 0, p = src; x < dw; x++, p += step_x)
 			*dst++ = get_unaligned_le24(p);
-	}
 }
 
 /* An XRGB8888 image into a buffer of another format, at x0, y0 */
@@ -564,7 +631,7 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 	bool bmp_invert_y;
 	u32 bitmap_offset;
 	size_t row_len, pixels_len, end;
-	unsigned int x_pad, y_pad;
+	unsigned int x_pad, y_pad, img_w, img_h;
 	const u8 *image_data;
 	struct iosys_map map;
 	struct drm_rect r;
@@ -629,7 +696,16 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 	}
 	bmp_pitch = row_len & ~(size_t)3;
 
-	if (bmp_width > scanout->width || bmp_height > scanout->height) {
+	/* The room the image takes up on screen, once turned */
+	if (splash->rotation & (DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270)) {
+		img_w = bmp_height;
+		img_h = bmp_width;
+	} else {
+		img_w = bmp_width;
+		img_h = bmp_height;
+	}
+
+	if (img_w > scanout->width || img_h > scanout->height) {
 		drm_err(client->dev, "splash: BMP image is too big for the screen\n");
 		return -EINVAL;
 	}
@@ -662,19 +738,19 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 #endif
 	} else {
 		x_pad = drm_splash_place_axis(splash->pos_x, splash->off_x,
-					      scanout->width, bmp_width);
+					      scanout->width, img_w);
 		y_pad = drm_splash_place_axis(splash->pos_y, splash->off_y,
-					      scanout->height, bmp_height);
+					      scanout->height, img_h);
 	}
 
 	image_data = data + bitmap_offset;
 
-	/* First the image upright in XRGB8888, then into the buffer's format */
+	/* First the image turned in XRGB8888, then into the buffer's format */
 	img = kvmalloc_array(bmp_width, bmp_height * sizeof(*img), GFP_KERNEL);
 	if (!img)
 		return -ENOMEM;
 	drm_splash_bmp_decode(img, image_data, bmp_pitch, bmp_width, bmp_height,
-			      bmp_invert_y);
+			      bmp_invert_y, splash->rotation);
 
 	ret = drm_client_buffer_vmap_local(buffer, &map);
 	if (ret) {
@@ -683,9 +759,9 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 		return ret;
 	}
 
-	r = DRM_RECT_INIT(x_pad, y_pad, bmp_width, bmp_height);
+	r = DRM_RECT_INIT(x_pad, y_pad, img_w, img_h);
 	drm_splash_blit(&map, fb->pitches[0], fb->format, x_pad, y_pad, img,
-			bmp_width, bmp_height);
+			img_w, img_h);
 
 	kvfree(img);
 	drm_client_buffer_vunmap_local(buffer);
@@ -1184,9 +1260,10 @@ void drm_splash_register(struct drm_device *dev,
 	mutex_init(&splash->lock);
 	init_completion(&splash->fw_done);
 
-	/* Centred unless the image source asks otherwise */
+	/* Centred and upright unless the image source asks otherwise */
 	splash->pos_x = -1;
 	splash->pos_y = -1;
+	splash->rotation = DRM_MODE_ROTATE_0;
 
 	if (format && format->num_planes == 1) {
 		splash->preferred_format = format->format;
-- 
2.39.5

