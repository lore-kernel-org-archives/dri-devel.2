Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFEEC5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:06:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F8F10E44D;
	Tue, 18 Aug 2026 08:06:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rGiBNu4I";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 586CD10E1BE
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:06:47 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so569306066b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787040406; x=1787645206; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ky5AAenkhb8FlnMl43V7nWMO27MSh6zMgGttM+QAy0=;
 b=rGiBNu4Il3fQhnMC9xX8EyhXKJX3g+SLxa2NCeNpZ5SbQ9H+VsMG3ycn7+zvOlVX8L
 p3uT3CX+iQymJ9sjLy2afa1bJMzmjd5ZSyZcqK23AMTXiwNugN2DgoHq/3g4QJ1yiuHt
 auQRwg8XGck0VINEqPRGvKyTcttOHojYzILh0K+DTuPZpedKa/uK4Ci6qCWxmzwppJxc
 PqOPfuepNmPbO/rS5MDSb8A8D/tkXjf7uT/v3xz8Pj4hioq+ydr0qyzSEGCnG5lZgmPN
 5AoSxFH+hOrmMqfPiJSDsuK4hnuy/423UPqVTEF1tsLqagU7m9g+p/yAS3+Gb/DbyXfw
 ATgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787040406; x=1787645206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9ky5AAenkhb8FlnMl43V7nWMO27MSh6zMgGttM+QAy0=;
 b=AxwiowW5v+BxflCnTEk+g9UdVPDUAb2IvNqrrd0vQhf6keqQv+VRuQW8K9dWd5qeQa
 zCFxxBCZlD7WqOXCoKlW9vjqKudVn/PFEryXyhsm7/I1DJbTn7XilarSuGpdaNv5N5Sp
 uTU1CUicDyozf/qCMaoPDtMahC73GqA08CkSdU2+R0vN2K36x36W3HYCuU8LsbNZSbUT
 8n3eWtoF8IwxqrTWzfWlmhe5ILkRBHmtfBedFMC9aFGp2dWe3j4CsgnGaQ1Yd+ln6yiN
 mKTmjbnNXxeN92+i61jlXxNQFbKXcNOdJdL0/+pO9kkOwPe6hLLh4I5oiC/Tmiwc/kMt
 lHQw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKMWo/iOIDZETIUGea9vuU2IW/YzKvGTVCFBQ7jbaZEYbl4wk4Rlk24ToFX+j4zo/kDzbpNAeCZg0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz5OMycsvsv5gLG+JJqEMHAs0EFfFszAzkS/3rYqJsBssbLmCiS
 4KQULJrP6Dq3zt+Puy4H13vuc5DG5CZqZihXkS+FJc0WAOP3ONmIW6y4
X-Gm-Gg: AR+sD11XULDuofExPx5vr5h4XucWJYurvPtzJ/ckIc+k4VgWH0NVHM33rqC41wHBaLj
 737dT/rQCCo1olheYjSZKy9cdqUI+Ke/EOiHq8+jVXhRRjYcEBwMwSAF4Zw7CYab2dTWUPvJX+R
 /WZ9UyLwocTihryQdpTSce8nNxa86/cnimPAv4ULHY0suR1ZwhLuXI+UUjDNFfMMse019ljhzSa
 v9+DWcpGDH5BaTv3ObSyc030QUaTmlNfoZcsuRwViEzoUTGOAbIcWEEKlWE5sYae4iMgv0X13Oq
 hMCHGoLcEmgjqmbdIzryhUos2hbJTYcc2G82UOovU0EmCn1XbvIG67jBmJAqk6JNcNDRjULVugh
 V0kTLBFpGqog/m8auohZ0F3HDN0F81+f4/hXyCCoX65jZITIyzJ0xV4o1H22+lA8e5tNRgCGcLO
 knEVSE+f84TUzKildboLO8TLRFYPuVv8XiS1pGa6rWfDUo3VXoMpskmouojIj1hvm4qjFlRf9gR
 Upk
X-Received: by 2002:a17:906:a8c:b0:c20:31d1:a899 with SMTP id
 a640c23a62f3a-c2188470ce8mr280058166b.4.1787040405261; 
 Tue, 18 Aug 2026 01:06:45 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b2e9sm10367223f8f.9.2026.08.18.01.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:06:44 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v4 2/6] drm/ssd130x: Change SSD133X color format to RGB565
 from RGB332
Date: Tue, 18 Aug 2026 11:06:22 +0300
Message-ID: <20260818080626.30430-3-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818080626.30430-1-amit.barzilai22@gmail.com>
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
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

SSD133X screens were driven at 8bpp RGB332 despite supporting 16bpp RGB565.
Switch the SSD133X data path to RGB565.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 45 +++++++++++++++++++------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 0b0fc6fe3df2..1110aa63d066 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -146,6 +146,11 @@
 #define SSD133X_DEFAULT_CONTRAST_B		0x50
 #define SSD133X_DEFAULT_CONTRAST_C		0x7d
 
+/* ssd133x remap byte (data of SSD13XX_SET_SEG_REMAP) */
+#define SSD133X_SET_REMAP_COM_SPLIT		BIT(5)
+#define SSD133X_SET_REMAP_COLOR_DEPTH_MASK	GENMASK(7, 6)
+#define SSD133X_COLOR_DEPTH_65K			0x1
+
 #define MAX_CONTRAST 255
 
 const struct ssd130x_deviceinfo ssd130x_variants[] = {
@@ -618,17 +623,17 @@ static int ssd133x_set_contrast(struct ssd130x_device *ssd130x, u32 brightness)
 static int ssd133x_init(struct ssd130x_device *ssd130x)
 {
 	int ret;
+	/*
+	 * Horizontal address increment, normal SA,SB,SC (e.g. RGB) sub-pixel
+	 * order, COM split odd even and 65k (RGB565) color depth.
+	 */
+	u8 remap = SSD133X_SET_REMAP_COM_SPLIT |
+		   FIELD_PREP(SSD133X_SET_REMAP_COLOR_DEPTH_MASK, SSD133X_COLOR_DEPTH_65K);
 	const u8 cmds[] = {
 		2, SSD133X_SET_MASTER_CURRENT, 0x06,
 		3, SSD133X_SET_COL_RANGE, 0x00, ssd130x->width - 1,
 		3, SSD133X_SET_ROW_RANGE, 0x00, ssd130x->height - 1,
-		/*
-		 * Horizontal Address Increment
-		 * Normal order SA,SB,SC (e.g. RGB)
-		 * COM Split Odd Even
-		 * 256 color format
-		 */
-		2, SSD13XX_SET_SEG_REMAP, 0x20,
+		2, SSD13XX_SET_SEG_REMAP, remap,
 		2, SSD133X_SET_DISPLAY_START, 0x00,
 		2, SSD133X_SET_DISPLAY_OFFSET, 0x00,
 		1, SSD133X_SET_DISPLAY_NORMAL,
@@ -829,14 +834,20 @@ static int ssd133x_update_rect(struct ssd130x_device *ssd130x,
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
-	 * sub-pixels for color A, B and C. These have 3 bit, 3 bit and
-	 * 2 bits respectively.
+	 * sub-pixels for color A, B and C. These have 3, 3 and 2 bits
+	 * respectively.
+	 *
+	 * When using the 65k color depth format, each pixel contains 3
+	 * sub-pixels for color A, B and C. These have 5, 6 and 5 bits
+	 * respectively.
 	 */
 
 	/* Set column start and end */
@@ -909,7 +920,7 @@ static void ssd132x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 
 static void ssd133x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 {
-	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
+	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB565);
 	unsigned int pitch;
 
 	if (!fi)
@@ -978,7 +989,7 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
 				struct drm_format_conv_state *fmtcnv_state)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
-	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
+	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB565);
 	unsigned int dst_pitch;
 	struct iosys_map dst;
 
@@ -988,7 +999,7 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
 	dst_pitch = drm_format_info_min_pitch(fi, 0, drm_rect_width(rect));
 
 	iosys_map_set_vaddr(&dst, data_array);
-	drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
+	drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
 
 	ssd133x_update_rect(ssd130x, rect, data_array, dst_pitch);
 
@@ -1446,7 +1457,7 @@ static int ssd133x_crtc_atomic_check(struct drm_crtc *crtc,
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	struct ssd130x_crtc_state *ssd130x_state = to_ssd130x_crtc_state(crtc_state);
-	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
+	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB565);
 	unsigned int pitch;
 	int ret;
 
-- 
2.55.0

