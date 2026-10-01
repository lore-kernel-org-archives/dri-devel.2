Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976B2CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:59:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F4210F772;
	Thu,  1 Oct 2026 19:59:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T4FcyT2T";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3E010F779
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:59:09 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso53108505e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 12:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790884748; x=1791489548; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4ZJ/XRjiJbnnbNutncIPfctKC3qkIxRHuKxqk+LioEA=;
 b=T4FcyT2TH5fg5D/vRN3GbR/SuX3CP1OFU0zqoN/xJk4V4mXlHKNSNjAn4vXPYBvWwK
 4dvkL6nzdU2WFd7I2do3MbkrtXGAG4uLO/u2AOOPfGvRsi/Mh6I7184fPvhlom8H3yCm
 simwspBkpGWUckhfBOkfu/h0mBvFO/+9MbGzB85waQ5SL101lhp4ayxoBuy2LXkHB11P
 vJWu4U4/b21z2n6npEzgQ9dn9ScanO/DVLEmlrVjWuwhQ3quPUHZ98HaWotPvsmbZPy/
 IZ/2W66tWJWeMV8j+4ZV2IwpIcqpmBaQ4JTYJ50fIb7eaH9xySFKmidmNvAElT4UllkW
 pzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884748; x=1791489548;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4ZJ/XRjiJbnnbNutncIPfctKC3qkIxRHuKxqk+LioEA=;
 b=vL0kKGHnb9WfivKVXtIgAo2GS2kxkxPCYQmP5gqVjGA4y24VcFu/VmlE3zlA1JgCPw
 K6N1/D6SzOc5dWMvRUrRGMXKlHzpHftl/wdA/Ome2MKOoE4S5NFPBfhi9uozG+63NJsj
 5Jw03xegHRkMwMuH+frN8qRy9Ig/gRKaYTTDPNDfBasQON162YtCmQbqgYaQdnmf0e2e
 AZguzv4c5+94I3jcg7QcW/g1eTnNefxFGitIy97MayRYrpEyHZUZwH4YlRgvCk2pcXsd
 TSvqtAvtjUWcfnoWAEQZIq4j6ugU6pmsXgp379s8N01jSo4S4Z3k1ulqewVp0spRj+Bc
 wjHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBznQ2J7EjmygyHPl89XZLkMeoYOWI+wONXywVCcy+gFw6eFlhys4BLPaXQKYJlMjYWNE05RZ3Mzcxw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqhMKrWPLhBDLnRt8Np6NRPwYQgfVXDMzyhixgjXqh7m9kLtdR
 npL1pufj2zeexPur3mmYpz0FgjLfW+/oHodeYK7LXEet1em7l2xZYwXs
X-Gm-Gg: AYBFou0YzcxMhSUl19I1D4xcvxCA4ehTeuTm3fM6TD/RV+GuD3pKKnEm3GrBGurA5N5
 HgNKYpD14UkAffH5FVvknOfHsODVOEuvminAjNM4/Ci9IB5uTTjawai0nL5XnnOdMdwP06WFq2+
 6y8JDOS5vRlnBhCyWG4+E/zuAd0Xre+naOHxoj7mJqV+rXDg3f5ByQG17BhSSlRh7Xn3FaJwm7n
 ynQw8rDmUgXadk15EK0ifYWKoZJR+krJOMZ4hNXGE8GeB+5eIXxpaq9OQfg+ZS9wUHmFScf+SVe
 6JXJriNXlGltOiRlul9g4yG/D8UxwPbeQw+SvNVJ2RTtddlU0cdI1Y6p5rCzK0atQlkwJpReXjq
 CYovLqoJzplzIPx8H9z1Y4NN7BphPv+hUMIX+QXUu2CLc5KAxhBErT27xdfDhCQhE95EvdMM9L8
 w/kZR2+29ndRSHAfdbJHBjXAIcW7M7k1VM/p378OsdTxAzGCIfTfQzrPO0O2p8Mr/U4J7Tj+E8z
 oHfoQSpdFGnzcD2YPGLbRstkg==
X-Received: by 2002:a05:600c:46d4:b0:49f:e772:6ddf with SMTP id
 5b1f17b1804b1-4a0276c01e6mr12542815e9.32.1790884747870; 
 Thu, 01 Oct 2026 12:59:07 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0276f92d9sm15031045e9.4.2026.10.01.12.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:59:07 -0700 (PDT)
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
Subject: [PATCH RFC v4 09/13] drm/client: splash: turn the device tree image
 as it asks
Date: Thu,  1 Oct 2026 21:58:43 +0200
Message-Id: <20261001195847.141192-10-maximpedraza@gmail.com>
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

The same board is often fitted with the same panel mounted in more than
one orientation. Let the device tree node ask for the image to be turned,
with a "rotation" property counting degrees counter clockwise, as panels
already do and as DRM_MODE_ROTATE_* count, which is what it is kept as.

The rotation turns the image and not the screen: "logo-position" and
"logo-offset" stay in screen pixels, and a quarter turn only swaps how
much room the image takes up. Placing it in a frame that turned with it
would make the same pair of coordinates mean different places on the
same panel, decided by a property that describes the image.

The three blitters, one per destination pixel size, become one that
reads the source pixel through the rotation and writes it according to
the pixel size. Each source pixel is read as three bytes rather than as
an unaligned u32: a BMP row is only padded as a whole, so with 3 * width
already a multiple of four the last pixel of the image was read one byte
past its end. An upright image going to an RGB888 buffer is still copied
a row at a time.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/drm_splash.c | 206 ++++++++++++++-------------
 1 file changed, 110 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index 349f68d392e5..924bc0032d1d 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -25,6 +25,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_mode.h>
 #include <drm/drm_plane.h>
 #include <drm/drm_print.h>
 
@@ -128,6 +129,8 @@ struct drm_splash {
 	 */
 	s32 pos_x, pos_y;
 	s32 off_x, off_y;
+	/* One of DRM_MODE_ROTATE_*: turns the image, not the screen */
+	unsigned int rotation;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -275,6 +278,28 @@ static void drm_splash_dt_placement(struct drm_splash *splash,
 		splash->off_x = (s32)val[0];
 		splash->off_y = (s32)val[1];
 	}
+
+	/* Degrees counter clockwise, as for panels, and as DRM counts them */
+	if (!of_property_read_u32(np, "rotation", &val[0])) {
+		switch (val[0]) {
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
+				 "splash: %pOF: unsupported rotation %u",
+				 np, val[0]);
+		}
+	}
 }
 
 static int drm_splash_dt_load(struct drm_splash *splash, const u8 **data,
@@ -500,73 +525,68 @@ static unsigned int drm_splash_place_axis(s32 pos, s32 off, unsigned int span,
 	return clamp_t(s64, coord + off, 0, last);
 }
 
-static void drm_splash_blit_pix16(struct iosys_map *map, unsigned int dpitch,
-				  unsigned int x_pad, unsigned int y_pad,
-				  const u8 *sbuf8, unsigned int spitch,
-				  unsigned int width, unsigned int height,
-				  bool invert_y, u32 format)
-{
-	unsigned int x, y, src_offset, dst_offset;
-	u32 scolor, dcolor, wr_off;
-
-	for (y = 0; y < height; y++) {
-		src_offset = (invert_y ? (height - y - 1) : y) * spitch;
-		dst_offset = (y_pad + y) * dpitch;
-
-		for (x = 0; x < width; x++) {
-			scolor = *(const u32 *)(&sbuf8[src_offset + 3 * x]);
-			dcolor = drm_draw_color_from_xrgb8888(scolor, format);
-			wr_off = dst_offset + (x_pad + x) * sizeof(u16);
-
-			iosys_map_wr(map, wr_off, u16, dcolor);
-		}
-	}
-}
-
-static void drm_splash_blit_pix24(struct iosys_map *map, unsigned int dpitch,
-				  unsigned int x_pad, unsigned int y_pad,
-				  const u8 *sbuf8, unsigned int spitch,
-				  unsigned int width, unsigned int height,
-				  bool invert_y, u32 format)
-{
-	unsigned int x, y, src_offset, dst_offset;
-	u32 scolor, dcolor, wr_off;
-
-	for (y = 0; y < height; y++) {
-		src_offset = (invert_y ? (height - y - 1) : y) * spitch;
-		dst_offset = (y_pad + y) * dpitch;
-
-		for (x = 0; x < width; x++) {
-			scolor = *(const u32 *)(&sbuf8[src_offset + 3 * x]);
-			dcolor = drm_draw_color_from_xrgb8888(scolor, format);
-			wr_off = dst_offset + (x_pad + x) * 3;
-
-			iosys_map_wr(map, wr_off, u8, (dcolor & 0x000000FF) >> 0);
-			iosys_map_wr(map, wr_off + 1, u8, (dcolor & 0x0000FF00) >> 8);
-			iosys_map_wr(map, wr_off + 2, u8, (dcolor & 0x00FF0000) >> 16);
-		}
-	}
-}
-
-static void drm_splash_blit_pix32(struct iosys_map *map, unsigned int dpitch,
-				  unsigned int x_pad, unsigned int y_pad,
-				  const u8 *sbuf8, unsigned int spitch,
-				  unsigned int width, unsigned int height,
-				  bool invert_y, u32 format)
+/*
+ * Copy the BMP pixels into the buffer, converted to its format and turned by
+ * @rotation, one of DRM_MODE_ROTATE_*, which count counter clockwise. The
+ * rotation turns the image, not the screen: a quarter turn swaps how much
+ * room the image takes up, and @x_pad and @y_pad place that room on screen.
+ *
+ * Each source pixel is three bytes read on their own, since a BMP row is
+ * only padded to four bytes as a whole and the image need not be aligned.
+ */
+static void drm_splash_blit(struct iosys_map *map, unsigned int dpitch,
+			    u32 format, unsigned int cpp,
+			    unsigned int x_pad, unsigned int y_pad,
+			    const u8 *sbuf8, unsigned int spitch,
+			    unsigned int width, unsigned int height,
+			    bool invert_y, unsigned int rotation)
 {
-	unsigned int x, y, src_offset, dst_offset;
-	u32 scolor, dcolor, wr_off;
-
-	for (y = 0; y < height; y++) {
-		src_offset = (invert_y ? (height - y - 1) : y) * spitch;
-		dst_offset = (y_pad + y) * dpitch;
+	bool quarter = rotation & (DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_270);
+	unsigned int dw = quarter ? height : width;
+	unsigned int dh = quarter ? width : height;
+	unsigned int x, y, sx, sy, row, off;
+	u32 scolor, dcolor;
+
+	for (y = 0; y < dh; y++) {
+		for (x = 0; x < dw; x++) {
+			switch (rotation) {
+			case DRM_MODE_ROTATE_90:
+				sx = width - 1 - y;
+				sy = x;
+				break;
+			case DRM_MODE_ROTATE_180:
+				sx = width - 1 - x;
+				sy = height - 1 - y;
+				break;
+			case DRM_MODE_ROTATE_270:
+				sx = y;
+				sy = height - 1 - x;
+				break;
+			default:
+				sx = x;
+				sy = y;
+				break;
+			}
 
-		for (x = 0; x < width; x++) {
-			scolor = *(const u32 *)(&sbuf8[src_offset + 3 * x]);
+			/* A positive BMP height stores the rows bottom up */
+			row = invert_y ? height - 1 - sy : sy;
+			scolor = get_unaligned_le24(&sbuf8[row * spitch + 3 * sx]);
 			dcolor = drm_draw_color_from_xrgb8888(scolor, format);
-			wr_off = dst_offset + (x_pad + x) * sizeof(u32);
+			off = (y_pad + y) * dpitch + (x_pad + x) * cpp;
 
-			iosys_map_wr(map, wr_off, u32, dcolor);
+			switch (cpp) {
+			case 2:
+				iosys_map_wr(map, off, u16, dcolor);
+				break;
+			case 3:
+				iosys_map_wr(map, off, u8, dcolor & 0xff);
+				iosys_map_wr(map, off + 1, u8, (dcolor >> 8) & 0xff);
+				iosys_map_wr(map, off + 2, u8, (dcolor >> 16) & 0xff);
+				break;
+			case 4:
+				iosys_map_wr(map, off, u32, dcolor);
+				break;
+			}
 		}
 	}
 }
@@ -605,7 +625,7 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 	bool bmp_invert_y;
 	u32 bitmap_offset;
 	size_t row_len, pixels_len, end;
-	unsigned int x_pad, y_pad;
+	unsigned int x_pad, y_pad, img_w, img_h;
 	const u8 *image_data;
 	struct iosys_map map;
 	struct drm_rect r;
@@ -665,7 +685,16 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
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
 		drm_err(client->dev, "splash: BMP image is too big for the screen");
 		return -EINVAL;
 	}
@@ -699,9 +728,9 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
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
@@ -712,40 +741,24 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 		return ret;
 	}
 
-	r = DRM_RECT_INIT(x_pad, y_pad, bmp_width, bmp_height);
+	r = DRM_RECT_INIT(x_pad, y_pad, img_w, img_h);
 
-	/* In case the target format is RGB888, source data can be copied to
-	 * the video buffer line by line, avoiding some overhead.
+	/*
+	 * An unturned image going to an RGB888 buffer has the same byte order
+	 * as the BMP, so it is copied a row at a time.
 	 */
-	if (scanout->format == DRM_FORMAT_RGB888) {
+	if (scanout->format == DRM_FORMAT_RGB888 &&
+	    splash->rotation == DRM_MODE_ROTATE_0) {
 		drm_splash_blit_rgb888(&map, fb->pitches[0], x_pad, y_pad,
 				       image_data, bmp_pitch, bmp_width,
 				       bmp_height, bmp_invert_y);
+	} else if (px_width >= 2 && px_width <= 4) {
+		drm_splash_blit(&map, fb->pitches[0], scanout->format, px_width,
+				x_pad, y_pad, image_data, bmp_pitch, bmp_width,
+				bmp_height, bmp_invert_y, splash->rotation);
 	} else {
-		switch (px_width) {
-		case 2:
-			drm_splash_blit_pix16(&map, fb->pitches[0], x_pad,
-					      y_pad, image_data, bmp_pitch,
-					      bmp_width, bmp_height,
-					      bmp_invert_y, scanout->format);
-			break;
-		case 3:
-			drm_splash_blit_pix24(&map, fb->pitches[0], x_pad,
-					      y_pad, image_data, bmp_pitch,
-					      bmp_width, bmp_height,
-					      bmp_invert_y, scanout->format);
-			break;
-		case 4:
-			drm_splash_blit_pix32(&map, fb->pitches[0], x_pad,
-					      y_pad, image_data, bmp_pitch,
-					      bmp_width, bmp_height,
-					      bmp_invert_y, scanout->format);
-			break;
-		default:
-			drm_warn_once(client->dev,
-				      "splash: can't blit with pixel width %d",
-				      px_width);
-		}
+		drm_warn_once(client->dev, "splash: can't blit with pixel width %d",
+			      px_width);
 	}
 
 	drm_client_buffer_vunmap_local(buffer);
@@ -1190,9 +1203,10 @@ void drm_splash_register(struct drm_device *dev,
 	spin_lock_init(&splash->fw_lock);
 	init_completion(&splash->fw_done);
 
-	/* Centred unless the image source asks otherwise */
+	/* Centred and upright unless the image source asks otherwise */
 	splash->pos_x = -1;
 	splash->pos_y = -1;
+	splash->rotation = DRM_MODE_ROTATE_0;
 
 	if (format && format->num_planes == 1)
 		splash->preferred_format = format->format;
-- 
2.39.5

