Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4B3CDB471
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:25:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8020410E75C;
	Mon, 22 Jun 2026 15:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mKl7TYdt";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB1310E759
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 15:25:24 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4924f8db066so9494685e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782141923; x=1782746723; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O+FbGuHfeWoNi/lXKYN24egtcTrn6rTefu8w9kcMeGk=;
 b=mKl7TYdtNT0Z+/twIkQIfKvIB6WOngvZdL2SzbXK7+ah9tZli7xnzYVE1FG5UdacvV
 kYHwcEryX+hhZQAhxzIGQsisrHEILmRuMiGabtwjVX5eJJwimXdYv8VVPmxYnAmo0B87
 8/pf524ZOA+IT8CUDVt+zJCkkOPe1HWuUSgzxZ/p5UAbuGsBgR4GdXD+jjL8XdvKmUjD
 3fshNJJmANBEWzespqsuT+hnuKB9ek+yODPZVKHxx1hfJbyNtV1U0IdAXNIujUbqER8a
 8j7xxQbjgP3iwDkAo8Hmsft26ZvccaqyHhD7g+Ju6BLztKbZA8bDmsk/Rd01ecZmkeVi
 745g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782141923; x=1782746723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O+FbGuHfeWoNi/lXKYN24egtcTrn6rTefu8w9kcMeGk=;
 b=Rb8936y+Bf7MHDSl16rjyfA+DJH1WyB6tHYKomx8gA4xg0hTG69UyAp8AffqftntxN
 0k6oQMImH39t+qlkza6Edx5mHktJbqm0Du4P+vf5FcU6+W/6aqitV+xM/nKhaQomOLqe
 f0Kc2kI1Bjz9sKaZ2y++Phuo1aJs5bUobJB5K6znlpJJj3xS1TqqlfKR4sZ54cd1e/dz
 vilr4tqWH1of0CMJui5AqUUf4mRcgPsr2fUMr+buBf6niv4dHwkWD/afk1fPqSiMkOif
 MUUlHYPZmkyu7bNeovIK+FUJxehF+TMmNe1WNBW9d45jhSp07tMHLcVbMUWDjREQEHfN
 0PNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7jen8+EMhXP+AU44vW9pgXG8pl2aUb4eszYf3YYAbnF4Dqq0s2ZHlcUJQ70031f+FxHeZ4M2hSUs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJ9GGWMtavJKUI+AJlftrHdcZCj3QoRrrHbwg+t96pmiv5paUB
 4dRdjO5C41+8YodeBLUWP9zFOKdAOpcw1dUq7GRd3r6BjwZok6uWxYKX
X-Gm-Gg: AfdE7cnq+G/lDw7bQv9Iy5TvfP6D4i4B1mOqAazFPVT3elnq2HGS1Wn06zdV1zVuQ3g
 17I9qSyVcL8TMZ2yDA2SOfj3s1MKq8s06foj/kuQRx2m97NcJhLXKWHS0MsYdAITB7KWbPG6Hz8
 nCPknflh7ba0Z59hKTr8rmfwsH3IpdaKZ+U4JuAE9eMaZFDdba+i8i2ybWVpmyJL5Z80iYp922x
 npfcqQG5R9n0irpXljT1jD/vhU7yGoulT2/jsYYmuUjZnKMC1jp236zIZQFBVxI7CqEFAobn+en
 RbTiZ0pB+4I6THMzBFa6pstajsJyD7KnInasoMNHrYLvgtGDt1R+KRkc4Qqm3SqSh8CxYRGZ+58
 eq4d6NXKga8Oqn+/24NZGe8emgB7BdhcCMdta5r40VLU80s4DIoIg2QyKnHMpUH3jZ0fJ6aCMMC
 DsSc8+c8YEE9KUNlqqBrHph8p2INBe4H2QPS8MfQ==
X-Received: by 2002:a05:600c:5285:b0:492:463c:48b7 with SMTP id
 5b1f17b1804b1-492463c5257mr193028095e9.22.1782141922516; 
 Mon, 22 Jun 2026 08:25:22 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492492338dasm217883655e9.1.2026.06.22.08.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:25:22 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 gregkh@linuxfoundation.org, deller@gmx.de
Cc: azuddinadam@gmail.com, chintanlike@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v2 2/4] drm/ssd130x: Add RGB565 support to SSD133X family
Date: Mon, 22 Jun 2026 18:25:04 +0300
Message-ID: <20260622152506.78627-3-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622152506.78627-1-amit.barzilai22@gmail.com>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
MIME-Version: 1.0
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

SSD133X screens were getting 8bpp (RGB332) instead of the 16bpp
(RGB565) that they support. This change adds a boolean to the
deviceinfo struct selecting whether the variant is driven at
DRM_FORMAT_RGB565.

Changed SSD133X to now utilize 65k color (RGB565).

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 55 +++++++++++++++++++++++++------
 drivers/gpu/drm/solomon/ssd130x.h |  7 ++++
 2 files changed, 52 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 04da4f2f7d08..2b0a8218f529 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -140,6 +140,12 @@
 #define SSD133X_SET_PRECHARGE_VOLTAGE		0xbb
 #define SSD133X_SET_VCOMH_VOLTAGE		0xbe
 
+/* ssd133x remap byte (data of SSD13XX_SET_SEG_REMAP) */
+#define SSD133X_SET_REMAP_COM_SPLIT		BIT(5)
+#define SSD133X_SET_REMAP_COLOR_DEPTH_MASK	GENMASK(7, 6)
+#define SSD133X_COLOR_DEPTH_256			0x0
+#define SSD133X_COLOR_DEPTH_65K			0x1
+
 #define MAX_CONTRAST 255
 
 const struct ssd130x_deviceinfo ssd130x_variants[] = {
@@ -206,6 +212,7 @@ const struct ssd130x_deviceinfo ssd130x_variants[] = {
 	[SSD1331_ID] = {
 		.default_width = 96,
 		.default_height = 64,
+		.format_rgb565 = 1,
 		.family_id = SSD133X_FAMILY,
 	}
 };
@@ -584,6 +591,10 @@ static int ssd132x_init(struct ssd130x_device *ssd130x)
 
 static int ssd133x_init(struct ssd130x_device *ssd130x)
 {
+	u8 remap = SSD133X_SET_REMAP_COM_SPLIT |
+		   FIELD_PREP(SSD133X_SET_REMAP_COLOR_DEPTH_MASK,
+			      ssd130x->device_info->format_rgb565 ?
+			      SSD133X_COLOR_DEPTH_65K : SSD133X_COLOR_DEPTH_256);
 	const u8 cmds[] = {
 		2, SSD133X_CONTRAST_A, 0x91,
 		2, SSD133X_CONTRAST_B, 0x50,
@@ -595,9 +606,9 @@ static int ssd133x_init(struct ssd130x_device *ssd130x)
 		 * Horizontal Address Increment
 		 * Normal order SA,SB,SC (e.g. RGB)
 		 * COM Split Odd Even
-		 * 256 color format
+		 * 256 or 65k color format, depending on the variant
 		 */
-		2, SSD13XX_SET_SEG_REMAP, 0x20,
+		2, SSD13XX_SET_SEG_REMAP, remap,
 		2, SSD133X_SET_DISPLAY_START, 0x00,
 		2, SSD133X_SET_DISPLAY_OFFSET, 0x00,
 		1, SSD133X_SET_DISPLAY_NORMAL,
@@ -794,14 +805,20 @@ static int ssd133x_update_rect(struct ssd130x_device *ssd130x,
 	 * COM0 to COM[N - 1] are the rows and SEG0 to SEG[M - 1] are
 	 * the columns.
 	 *
-	 * Each Segment has a 8-bit pixel and each Common output has a
-	 * row of pixels. When using the (default) horizontal address
-	 * increment mode, each byte of data sent to the controller has
-	 * a Segment (e.g: SEG0).
+	 * Each Segment holds one pixel and each Common output has a row
+	 * of pixels. A pixel is 8 bits (one byte) in the 256 color
+	 * (RGB332) format or 16 bits (two bytes) in the 65k color
+	 * (RGB565) format. When using the (default) horizontal address
+	 * increment mode, the pixel data is sent Segment by Segment
+	 * (e.g: SEG0 first).
 	 *
 	 * When using the 256 color depth format, each pixel contains 3
 	 * sub-pixels for color A, B and C. These have 3 bit, 3 bit and
 	 * 2 bits respectively.
+	 *
+	 * When using the 65k color depth format, each pixel contains 3
+	 * sub-pixels for color A, B and C. These have 5 bit, 6 bit and
+	 * 5 bits respectively.
 	 */
 
 	/* Set column start and end */
@@ -872,9 +889,24 @@ static void ssd132x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 	ssd130x_write_data(ssd130x, data_array, columns * height);
 }
 
+/*
+ * The SSD133X family can drive the panel in either RGB332 (1 byte per pixel)
+ * or RGB565 (2 bytes per pixel). The format is a per-variant policy choice
+ * selected through ssd130x_deviceinfo::format_rgb565, not a capability probe.
+ * Centralize the choice here so that the buffer sizing (allocation, clear and
+ * blit pitch) can never disagree.
+ */
+static const struct drm_format_info *ssd133x_format_info(struct ssd130x_device *ssd130x)
+{
+	if (ssd130x->device_info->format_rgb565)
+		return drm_format_info(DRM_FORMAT_RGB565);
+
+	return drm_format_info(DRM_FORMAT_RGB332);
+}
+
 static void ssd133x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 {
-	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
+	const struct drm_format_info *fi = ssd133x_format_info(ssd130x);
 	unsigned int pitch;
 
 	if (!fi)
@@ -945,7 +977,7 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
 				struct drm_format_conv_state *fmtcnv_state)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
-	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
+	const struct drm_format_info *fi = ssd133x_format_info(ssd130x);
 	unsigned int dst_pitch;
 	struct iosys_map dst;
 	int ret = 0;
@@ -956,7 +988,10 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
 	dst_pitch = drm_format_info_min_pitch(fi, 0, drm_rect_width(rect));
 
 	iosys_map_set_vaddr(&dst, data_array);
-	drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
+	if (ssd130x->device_info->format_rgb565)
+		drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
+	else
+		drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
 
 	ssd133x_update_rect(ssd130x, rect, data_array, dst_pitch);
 
@@ -1414,7 +1449,7 @@ static int ssd133x_crtc_atomic_check(struct drm_crtc *crtc,
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	struct ssd130x_crtc_state *ssd130x_state = to_ssd130x_crtc_state(crtc_state);
-	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
+	const struct drm_format_info *fi = ssd133x_format_info(ssd130x);
 	unsigned int pitch;
 	int ret;
 
diff --git a/drivers/gpu/drm/solomon/ssd130x.h b/drivers/gpu/drm/solomon/ssd130x.h
index a4554018bb2a..b0b487c06e04 100644
--- a/drivers/gpu/drm/solomon/ssd130x.h
+++ b/drivers/gpu/drm/solomon/ssd130x.h
@@ -54,6 +54,13 @@ struct ssd130x_deviceinfo {
 	bool need_pwm;
 	bool need_chargepump;
 	bool page_mode_only;
+	/*
+	 * Per-variant output format selector for the SSD133X data path. The
+	 * hardware can drive the panel in RGB332 (1 byte/pixel) or RGB565
+	 * (2 bytes/pixel); this is a policy choice per variant, not a
+	 * capability probe. When set, the variant is driven at RGB565.
+	 */
+	bool format_rgb565;
 
 	enum ssd130x_family_ids family_id;
 };
-- 
2.54.0

