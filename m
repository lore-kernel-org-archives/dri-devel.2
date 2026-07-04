Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE577C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 08:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A24E10E046;
	Sat,  4 Jul 2026 08:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="USD5mT3T";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D6F810E046
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 08:09:49 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so10991365e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 01:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783152587; x=1783757387; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5sRdDxXdJoIR7rHcHYJyjPRi8VcEI0CsKE31MI1Zm8w=;
 b=USD5mT3TzpPlqQEYeM7Lr5wua14AsMyIRPFbabmwy4byaJ6Fn6UHOGU/ck6glRt9CA
 CuqKXbXhpJGWz4ymHkhm9BxNlSG+DYfLjvreOkwVr06Y9fgwlIrjlMacxiUokcRutrCc
 HCqraPNmaFhOuDF7VKL+J/+QAUIA0YGDyW+o0ogE2MggO6QzjT/ZiK9iyBN4r/zLwL+N
 FB4QVawx3gIl5r9dMbMLt+ze0Hf+gb7COXi4t7KM7veJNMlVPjaBcgvUHaVN3HjjedHn
 L+OEs09A2oD2WtjfZwJSa+IEycJKIaHi2Fxb7QhgMVLEX5kUZ2zYpMbDfbKe3yK84vUv
 w77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783152587; x=1783757387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5sRdDxXdJoIR7rHcHYJyjPRi8VcEI0CsKE31MI1Zm8w=;
 b=soK51IbkAFse9I9t2m2SopDWVPbpA9PrMSZrrxc6PAgOexNU8Dv+rYnfsUwfFjNP8K
 bAxXTSvdaXnbOaeqwLu0w6S1l0wij/itCOsqJCL9xgTjFgd3fcxOVSFfP9K4g0Fi5Zyi
 7EjohBDzr0BCYxUADf5TYyeY/P0h74wxcjShyUosSAFUkPLgpJLWeOQA93q6/Y/fyEst
 KGiJQtx9d6l8TWatLJ0d53WZWIlG+svEkKCaK40NkKVqCwmFQn41eyjkmkTKC2vCeiWA
 K8QoiDwDBsBzploTOiMKFfWdpQT3uaq0ZGCJKKsqdRiMd2WUGASjfhDZi3nQVwuiIQlg
 oI3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wwseCWh6BwroFc/X2hrN0ydWueSHTKjJbAuD7FKgavVKcu5pYA9QYPRQXr87WI6OY4jYRG1l1/BU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjvcsRxbicxPzSBMy9MB3GmWZR8nC7oesi1Ij8TAIoGx0b2Jm1
 qLKm+eV668QEhIXfRFYwYYrEekxSEvKlBbB/2O3AibXjiUxMLFey8aGd
X-Gm-Gg: AfdE7cn9LaeTyoSx0Lw9lWZbbYeAwL/qT5x+2+8TBAV2LSopOuPTuI4it9SxzBV3w1l
 KGtWfI4rGR/qypr8G6Inx5K4Q3gJ+HZGbnh0D0RDHX6fmKpkXxD/TMYI45pLFcfadw7gW8Ely+o
 7QdiC78IFdZjOz7lYhd3UMvevjFjC6qtpDtPdvkBz11dh0gOhayiFR7uec8WwjWsuc5oYT+dCgl
 /y2xLWIff0SP5nZ8qtFUW0H2gIT3D20RWGZh1oLMZupUa0P816cE14UbW9mZxN9uWc7IB8DJqZn
 V+K42ObSu4SvfJCUHAOokLFzmxsA99WVwaexP7qxZ8ChjO9gjdRfGvR8IFS51cr2dv7SgjZDxE/
 um0pHqouadJECG4foVgsQ4D8Nq40d+6egqSgAm/bIQ22ou0VGYH/E5kSIId/VuLXRFteLVAlP5Y
 LaN78XdWo6XF57JwTeNuSRFvAdpYQ=
X-Received: by 2002:a05:600c:811a:b0:493:bc92:ba9a with SMTP id
 5b1f17b1804b1-493d11d7e5bmr23547495e9.13.1783152587230; 
 Sat, 04 Jul 2026 01:09:47 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm6143055f8f.26.2026.07.04.01.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 01:09:46 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v3 2/3] drm/ssd130x: Change SSD133X color format to RGB565
 from RGB332
Date: Sat,  4 Jul 2026 11:09:24 +0300
Message-ID: <20260704080925.75113-3-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704080925.75113-1-amit.barzilai22@gmail.com>
References: <20260704080925.75113-1-amit.barzilai22@gmail.com>
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
---
 drivers/gpu/drm/solomon/ssd130x.c | 45 +++++++++++++++++++------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 04da4f2f7d08..3f09977d227b 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -140,6 +140,11 @@
 #define SSD133X_SET_PRECHARGE_VOLTAGE		0xbb
 #define SSD133X_SET_VCOMH_VOLTAGE		0xbe
 
+/* ssd133x remap byte (data of SSD13XX_SET_SEG_REMAP) */
+#define SSD133X_SET_REMAP_COM_SPLIT		BIT(5)
+#define SSD133X_SET_REMAP_COLOR_DEPTH_MASK	GENMASK(7, 6)
+#define SSD133X_COLOR_DEPTH_65K			0x1
+
 #define MAX_CONTRAST 255
 
 const struct ssd130x_deviceinfo ssd130x_variants[] = {
@@ -584,6 +589,12 @@ static int ssd132x_init(struct ssd130x_device *ssd130x)
 
 static int ssd133x_init(struct ssd130x_device *ssd130x)
 {
+	/*
+	 * Horizontal address increment, normal SA,SB,SC (e.g. RGB) sub-pixel
+	 * order, COM split odd even and 65k (RGB565) color depth.
+	 */
+	u8 remap = SSD133X_SET_REMAP_COM_SPLIT |
+		   FIELD_PREP(SSD133X_SET_REMAP_COLOR_DEPTH_MASK, SSD133X_COLOR_DEPTH_65K);
 	const u8 cmds[] = {
 		2, SSD133X_CONTRAST_A, 0x91,
 		2, SSD133X_CONTRAST_B, 0x50,
@@ -591,13 +602,7 @@ static int ssd133x_init(struct ssd130x_device *ssd130x)
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
@@ -794,14 +799,20 @@ static int ssd133x_update_rect(struct ssd130x_device *ssd130x,
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
@@ -874,7 +885,7 @@ static void ssd132x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 
 static void ssd133x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 {
-	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
+	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB565);
 	unsigned int pitch;
 
 	if (!fi)
@@ -945,7 +956,7 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
 				struct drm_format_conv_state *fmtcnv_state)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
-	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
+	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB565);
 	unsigned int dst_pitch;
 	struct iosys_map dst;
 	int ret = 0;
@@ -956,7 +967,7 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
 	dst_pitch = drm_format_info_min_pitch(fi, 0, drm_rect_width(rect));
 
 	iosys_map_set_vaddr(&dst, data_array);
-	drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
+	drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
 
 	ssd133x_update_rect(ssd130x, rect, data_array, dst_pitch);
 
@@ -1414,7 +1425,7 @@ static int ssd133x_crtc_atomic_check(struct drm_crtc *crtc,
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	struct ssd130x_crtc_state *ssd130x_state = to_ssd130x_crtc_state(crtc_state);
-	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
+	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB565);
 	unsigned int pitch;
 	int ret;
 
-- 
2.54.0

