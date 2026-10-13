Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 784CECC6B13
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDEEF10F68B;
	Tue, 13 Oct 2026 09:33:21 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D92010F678
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:33:09 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48afe75f055so2512708f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791883988; x=1792488788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J3Mhzxgfk8rELBjNtRbn8fBvJ+iG+2e3C6/7nA4ujsg=;
 b=ezTwFFDEIhvoUkvP9eMXo8WDqI5dNdudh/RJM836Vl2Fteac0d6ydk2C55Zaa/uOMC
 HruIo+ntfTW8CluatX36Oen7FMDI+VF8Tx37XRkX6jvXcWth6Lz/vtERmOQmJ3zemlEE
 lsKXCZdD1/gZxS9yNDvnYErxliPhsssYSm64l89QmX0AlE9gclQSYCWx8R9sfIpkZpUI
 nKW2h40QDoLbbUg6N9+sGRqVdfXfA1ViRT4ObeHZH60IsvPJ6DDnlAz/R/NPqDvfZTjC
 2Pbp5qRwZFJ8bFGExgh01rU5KdjLZU82/FTDEMY3/YhMOV/Fu6NFXcQl2VYhs42snzov
 5L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883988; x=1792488788;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J3Mhzxgfk8rELBjNtRbn8fBvJ+iG+2e3C6/7nA4ujsg=;
 b=eonRUvMxvI4+C4maSFV77cCMD4JYWlMygZ5l6L3l2ttfz2YF4aBnTJgFZv9QzCiWD8
 WyYaen2m+LsUexlYhNkMCE/Hfuw3BtrAPTDrKv4dPEDzab3w68T+UD6qQnxO1ww0lCg2
 UjJo8sWNsi2Ka73ncTJd43VmmKMmqSbblY/iDLTnro2+3JQVuzH6Wytuho8eyoOeSWxx
 sVO6Qkh5qLwMC4J4wMddawRFtvfzz0D3jM35FeW9nYV3LaoIPdVXvvrKHxw65eW2wFiL
 naULuIOtSplivaEzNOFQE26gdhcOuVoVDYHTYF+pzLFMmYXe1GMxceCklOjuwaYGcCKs
 Ig/Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGH4msWx+1j8vjrQiz3V5eBNSGpO76V5pyPhMeQ43AviGtE6wTL5vpH3OkJNNb0u5AyDvQJZqF9OM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJk37sWDvvQIsuw5cZJ6bvfj/aFmgKWN3E+J4kq7/khNI2rCR4H
 7HO8Y71q0dpICM80UW1uLMx7txGZGKAZVVbPoqwHGAjMI+vqo93ih2TL
X-Gm-Gg: AYBFou0k0vLrGKtvowASAtlm2VWrmJiWHQ1xMki7P5OaCQIAZiZM+MB+qeJuHlW9tdT
 sO27Nc4qRzGMH4zkv8q4NT5XwTPrJAY/lUuEYEJRDy1nz0K9xs5EmsHoSsHF8YvBae3YGgb/JDB
 PpwhtGS/YiEDy4nBI9DWaS7l87HXTZ9gsJeFwvdRB0VpO7+VQRHj5vGILKN3x5Y+5QV1PsmgM2u
 M+m83nB6JBU1K4WiOcu0uXbUCjRsGi1MpWWiaig9aVTNdv940UOe0oPNwIflQuMKbXQVhIGyM9x
 /JMSBTgXqMueNjuEx7pgVEoNl14UET9Ihx9QxfJ4YFQL/jljhjgMPL+DeFwGJGin4GDa4ocdcL3
 QUiZSgW2CFDlAq0CuF9PeWVzBSl0PIxTBR+T7lWhaK+Tzmw30an+9VLuOuAZuraIkEiwxGlu3qr
 DvzssR+PG71gv1XL5QLA4oEKW9PNCaSLZBeddBb+RyPWcWsBMTZgD0hIvhU63NXhYuTbM8fUQwy
 FpKU6ShLguQeOnidjRY23Lf
X-Received: by 2002:a05:6000:46c7:b0:48c:6955:a603 with SMTP id
 ffacd0b85a97d-48dbaadd962mr15329987f8f.13.1791883987585; 
 Tue, 13 Oct 2026 02:33:07 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ec6sm3986774f8f.48.2026.10.13.02.33.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:33:06 -0700 (PDT)
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
Subject: [PATCH v5 08/13] drm/client: splash: place the device tree image
 where it asks
Date: Tue, 13 Oct 2026 11:32:38 +0200
Message-Id: <20261013093243.505776-9-maximpedraza@gmail.com>
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

A logo supplied by the device tree describes a particular product, and
where it lands on the panel matters: some panels only show part of the
mode, so the middle of the mode is not the middle of what the user
sees.

Read the optional "logo-position" and "logo-offset" properties of the
node. The position is the top left corner, with -1 on an axis meaning
centre on that axis, and the offset is added afterwards, which is the
only way to say "below the centre" when the device tree does not know
the image size, as with an image in a reserved region.

Both come straight from the device tree, so the sum is done in 64 bits
and clamped, and a silly pair of values lands the image against an
edge rather than off the screen: the blitters do not clip. Every other
source keeps being centred, except the BGRT, which keeps its own
offsets.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/drm_splash.c | 73 ++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index 50842922a7f8..8561d00a5b96 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -122,6 +122,14 @@ struct drm_splash {
 	void *map_data;
 
 	enum drm_splash_source src;
+
+	/*
+	 * Where the image goes, in screen pixels: a coordinate of -1 centres
+	 * it on that axis, and the offset is added afterwards. Only the device
+	 * tree asks for anything but the centre.
+	 */
+	s32 pos_x, pos_y;
+	s32 off_x, off_y;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -260,13 +268,21 @@ static struct device_node *drm_splash_dt_node(struct drm_splash *splash)
 	return NULL;
 }
 
-static bool drm_splash_dt_available(struct drm_splash *splash)
+/* The optional placement properties of the node, read once */
+static void drm_splash_dt_placement(struct drm_splash *splash,
+				    struct device_node *np)
 {
-	struct device_node *np = drm_splash_dt_node(splash);
+	u32 val[2];
 
-	of_node_put(np);
+	if (!of_property_read_u32_array(np, "logo-position", val, 2)) {
+		splash->pos_x = (s32)val[0];
+		splash->pos_y = (s32)val[1];
+	}
 
-	return np;
+	if (!of_property_read_u32_array(np, "logo-offset", val, 2)) {
+		splash->off_x = (s32)val[0];
+		splash->off_y = (s32)val[1];
+	}
 }
 
 static int drm_splash_dt_load(struct drm_splash *splash, const u8 **data,
@@ -319,9 +335,14 @@ static int drm_splash_dt_load(struct drm_splash *splash, const u8 **data,
 	return ret;
 }
 #else
-static bool drm_splash_dt_available(struct drm_splash *splash)
+static struct device_node *drm_splash_dt_node(struct drm_splash *splash)
+{
+	return NULL;
+}
+
+static void drm_splash_dt_placement(struct drm_splash *splash,
+				    struct device_node *np)
 {
-	return false;
 }
 
 static int drm_splash_dt_load(struct drm_splash *splash,
@@ -438,6 +459,26 @@ static int drm_splash_fill_solid_color(struct drm_client_buffer *buffer,
 }
 
 #if IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_BMP_SUPPORT)
+/*
+ * Place the image along one axis of the screen. @pos is the coordinate asked
+ * for, or -1 to centre on that axis, and @off is added afterwards. Both may
+ * come from the device tree, so the sum is done wide enough not to wrap, and
+ * the result keeps the whole image on the screen: the blitters do not clip.
+ */
+static unsigned int drm_splash_place_axis(s32 pos, s32 off, unsigned int span,
+					  unsigned int size)
+{
+	s64 last = (s64)span - size;
+	s64 coord;
+
+	if (last <= 0)
+		return 0;
+
+	coord = pos == -1 ? last / 2 : pos;
+
+	return clamp_t(s64, coord + off, 0, last);
+}
+
 static void drm_splash_blit_pix16(struct iosys_map *map, unsigned int dpitch,
 				  unsigned int x_pad, unsigned int y_pad,
 				  const u8 *sbuf8, unsigned int spitch,
@@ -636,9 +677,10 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 		}
 #endif
 	} else {
-		/* Center X and Y */
-		x_pad = (scanout->width - bmp_width) / 2;
-		y_pad = (scanout->height - bmp_height) / 2;
+		x_pad = drm_splash_place_axis(splash->pos_x, splash->off_x,
+					      scanout->width, bmp_width);
+		y_pad = drm_splash_place_axis(splash->pos_y, splash->off_y,
+					      scanout->height, bmp_height);
 	}
 
 	image_data = data + bitmap_offset;
@@ -721,8 +763,15 @@ static int drm_splash_image_load(struct drm_splash *splash, const u8 **img_data,
  */
 static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
 {
-	if (drm_splash_dt_available(splash))
+	struct device_node *np;
+
+	np = drm_splash_dt_node(splash);
+	if (np) {
+		drm_splash_dt_placement(splash, np);
+		of_node_put(np);
 		return DRM_SPLASH_SRC_DT;
+	}
+
 	if (drm_splash_bgrt_available(splash))
 		return DRM_SPLASH_SRC_BGRT;
 	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP))
@@ -1144,6 +1193,10 @@ void drm_splash_register(struct drm_device *dev,
 	spin_lock_init(&splash->fw_lock);
 	init_completion(&splash->fw_done);
 
+	/* Centred unless the image source asks otherwise */
+	splash->pos_x = -1;
+	splash->pos_y = -1;
+
 	if (format && format->num_planes == 1)
 		splash->preferred_format = format->format;
 	else
-- 
2.39.5

