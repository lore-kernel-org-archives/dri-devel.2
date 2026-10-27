Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5533606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k2DCtkhK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07D7010F586;
	Tue, 27 Oct 2026 13:54:32 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E869D10F57C
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:54:10 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so2496355f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793109249; x=1793714049; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fU1UKpzBNuXU6ySePDsKYMB2Kq9NDiCM/53N3kd7ajQ=;
 b=k2DCtkhK5RTcJXGMQWeIhUHGw1P2RjhPNK7wnJFilINeilSV4w98lurR8PEFxp5P/q
 S1ruKhZlggjiPSXdNiZRMYb7Ql89BcgACo0PxIF0D6VZKTIzrkLoijCcquW7lzIX+NgM
 92HX9vEUK7KCV9HC0jBtEt9SzwEcLnx0VxedyLWDhRZqCbEENp1kFsgzL8gzLkfUBdQF
 khNCCOYBpo/MJRyLBe9Dr3UxwSarMTwJHBb3JYGZw4rsNdAUssJ9ZQCmGUTBttdshRdJ
 NIRLYxm1wuMWaBDgLRIYOrpyTvmnxz2GqWZWE5CbsmTXfSnRx2Lzh+BeN/3pnF8W7/gX
 iRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109249; x=1793714049;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fU1UKpzBNuXU6ySePDsKYMB2Kq9NDiCM/53N3kd7ajQ=;
 b=o1xHMeozHAcK8hV9/SnRM32qXNuAF8fxS5bANcE++DGYnsFbUlNUffvTJ8inFnMacH
 GYIQwdxdoyEzcW8P3zqztiy8cVU+ouiDLjWJl0RnYEOwIqh9hgtDyh9OCo84Vb6XgXA0
 WFQ3GLNa80k6rgqaaHbb9Xqm/zgoBWN0P+IDbg53Z19ekkOZ3VnA4lcSO1zYWFzAi9pm
 FXVRvBcXxr8eFxy46CgXs9usnWgZjykn7E1wx21/knyc73OFFhbsTKv401mXauAtkaJl
 +xD1htZizBncUTebMNqVIAkRaENw2XuRLBnjAlPkq34n5Z4ftet+CldHezOYa9DaC3jT
 R0Ww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsBmEuuFpBkQypr2ZmI1knzW7ZvsZY95oRyAbPA48B8dFcLyd5yuiG/s5z8numygi4Kl1gvu+nMnQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKfR4hYzSvIRNDj0kzH2+xrvcvVXTt97p4DgSZ2rra+vziQHNuc
 x8ZgHqNCjn2sg7/LR9NcX+azMIXV+/xjJ5VoSCcGZk8WqGUtZsMK011B
X-Gm-Gg: AYBFou0ooZdD7/Khce0lk4kO1PyVgBXbH7qYyExM3RkGO8rwOnSY4rMKxjkdlMKvu7f
 yCkQh4nAsNDtAIVy9Mri3pl90R5tTHa1fuPeXTLw3No/ZXpgs8mb0CA//mrkYStX36haQ6ya3Tb
 QqMzHvSzhwIaff2sRHhMlyLCf8WAHcwlciCVULjXKCREdp/p7YF0vv8x0w3T29jNqoh3oXlKflq
 5o9bRm1aFuVZTlFQxzPcTlAk7jgyM9cY4+J7eV+BXTW3143wvpKQwurN07yQiHm99AmUz483aoY
 Z0X8djb1rxOIjuALyVry/Ra58QhbwpgtlkWwDAEEre9iVRbSJjTU0ObCSyWKF7JL1mR7F1jOK21
 V8+xcmbT64sy910vTyxSCVZEbBKFy2wXC4ZcP0sj9c2VnRdO8uMB0+lU59mlmxiHhLyyCzbnwQR
 3IjPiafs0ZwoI45wSgioMN9t/bxE1Nb+tzdKPDWkO8M1KiokmnN7b0O76fLd8W7Mw0tGN0IUuIe
 XexEqMYJKzKUirJXnAjOjXJj102h4RvmddYzS0+M6YHJYNyMNJ2Wz2AFDtjCVSKcvmHDaiMrrTE
 8lbDQPs=
X-Received: by 2002:adf:e186:0:b0:48d:eec5:d243 with SMTP id
 ffacd0b85a97d-48e3eb8b71emr19191940f8f.9.1793109249072; 
 Tue, 27 Oct 2026 06:54:09 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.54.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:54:08 -0700 (PDT)
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
Subject: [PATCH v6 10/15] drm/client: splash: place the device tree image
 where it asks
Date: Tue, 27 Oct 2026 14:53:37 +0100
Message-Id: <20261027135342.2003632-11-maximpedraza@gmail.com>
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

A logo supplied by the device tree describes a particular product, and
where it lands on the panel matters: some panels only show part of the
mode, so the middle of the mode is not the middle of what the user
sees.

Read the optional "logo-position" and "logo-offset" properties of the
node. The position is the top left corner, with -1 on an axis meaning
centre on that axis, and the offset is added afterwards, which is the
only way to say "below the centre" when the device tree does not know
the image size, as with an image in a reserved region.

Both come straight from the device tree. A property that is not two
cells, or that is out of the binding's range, is reported and keeps its
default;
otherwise the sum is done in 64 bits and clamped, and a silly pair of
values lands the image against an edge rather than off the screen: the
blitters do not clip. Every other source keeps being centred, except
the BGRT, which keeps its own offsets.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/drm_splash.c | 82 ++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index 618c060f33d5..81070547390f 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -106,6 +106,14 @@ struct drm_splash {
 	size_t dt_len;
 
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
@@ -238,6 +246,39 @@ static struct device_node *drm_splash_dt_node(struct drm_splash *splash)
 	return NULL;
 }
 
+/* An X and Y pair; anything but two cells from @min to @max is reported */
+static void drm_splash_dt_pair(struct drm_splash *splash,
+			       struct device_node *np, const char *name,
+			       s32 min, s32 max, s32 *x, s32 *y)
+{
+	u32 val[2];
+
+	if (!of_property_present(np, name))
+		return;
+
+	if (of_property_count_u32_elems(np, name) != 2 ||
+	    of_property_read_u32_array(np, name, val, 2) ||
+	    (s32)val[0] < min || (s32)val[0] > max ||
+	    (s32)val[1] < min || (s32)val[1] > max) {
+		drm_warn(splash->client.dev, "splash: %pOF: invalid %s\n",
+			 np, name);
+		return;
+	}
+
+	*x = val[0];
+	*y = val[1];
+}
+
+/* The optional placement properties of the node, read once */
+static void drm_splash_dt_placement(struct drm_splash *splash,
+				    struct device_node *np)
+{
+	drm_splash_dt_pair(splash, np, "logo-position", -1, 65535,
+			   &splash->pos_x, &splash->pos_y);
+	drm_splash_dt_pair(splash, np, "logo-offset", -65535, 65535,
+			   &splash->off_x, &splash->off_y);
+}
+
 /*
  * Find the image when the source is picked, and keep it for the outputs
  * plugged in later. A node whose image cannot be had leaves the other
@@ -307,6 +348,11 @@ static bool drm_splash_dt_open(struct drm_splash *splash)
 	return false;
 }
 
+static void drm_splash_dt_placement(struct drm_splash *splash,
+				    struct device_node *np)
+{
+}
+
 static int drm_splash_dt_load(struct drm_splash *splash,
 			      const u8 **data, size_t *size)
 {
@@ -428,6 +474,26 @@ static int drm_splash_fill_solid_color(struct drm_client_buffer *buffer,
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
 /* The rows of a 24 bpp BMP, bottom up or top down, upright in XRGB8888 */
 static void drm_splash_bmp_decode(u32 *dst, const u8 *src, unsigned int spitch,
 				  unsigned int width, unsigned int height,
@@ -595,9 +661,10 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
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
@@ -659,8 +726,11 @@ static int drm_splash_image_load(struct drm_splash *splash, const u8 **img_data,
  */
 static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
 {
-	if (drm_splash_dt_open(splash))
+	if (drm_splash_dt_open(splash)) {
+		drm_splash_dt_placement(splash, splash->dt_np);
 		return DRM_SPLASH_SRC_DT;
+	}
+
 	if (drm_splash_bgrt_available(splash))
 		return DRM_SPLASH_SRC_BGRT;
 	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP))
@@ -1114,6 +1184,10 @@ void drm_splash_register(struct drm_device *dev,
 	mutex_init(&splash->lock);
 	init_completion(&splash->fw_done);
 
+	/* Centred unless the image source asks otherwise */
+	splash->pos_x = -1;
+	splash->pos_y = -1;
+
 	if (format && format->num_planes == 1) {
 		splash->preferred_format = format->format;
 	} else {
-- 
2.39.5

