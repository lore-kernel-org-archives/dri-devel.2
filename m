Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA55C5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 11:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05C6510E4E3;
	Sun, 23 Aug 2026 11:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qDd5Y4Yn";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81B410E4E3
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 11:20:33 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-69f7fa1c548so4789481a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 04:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787484032; x=1788088832; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O2nHmLuWlmB9nT6PWD8W1i/ls2Umb2NuoFiA04KEePk=;
 b=qDd5Y4Yn/mmuJVYJ0Vk947huo3aHVXSlajd1tm0HvhxUkXwWEPQbJk5LX7Qd4BQiqp
 ssI0K3N0v4HAGau/87VRzAiNLlHBwmJCtRuWrd7SeE/qc88oXeCu6XbjcDkQ6QmEBPBZ
 N8965WuLwvX7vE6PEOX6538lubavpXOOlZqQEz4xYd4HhphofIPMoqrvOQYe5ODe+tBb
 jB/HfLUhZ+eBgcrgjGX3T/LM6m03shmvT1WmcSX3DQbHUMERqdwFznKWokNZuBuIiN5N
 wjxqShER1T1PsNzMRx/+hXeQMrshQQhA/Y8jF0xPD5O6fAwvrbise5MuIN/kY0ImgSBo
 /fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787484032; x=1788088832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=O2nHmLuWlmB9nT6PWD8W1i/ls2Umb2NuoFiA04KEePk=;
 b=fHAX1xk0o1wE8EPt6Wl3r6+Mc6y5RY9glT3eqAWot+GQEH1JfOThXOSjmXcSJoP6as
 Q0PUWh9iZHs0qf9IgfAG3D7CDqmoweEwdQgKXniyVW+IOrjYvMk44AsA3vbmjslhh+r6
 C+MsqFXP59XiNx88K5oeJ/yxN8bet6DqPicxYuNV4W8bSq5N54Xz1RqwnVfvCqeoYoA/
 tX4r8ijDHAFSR8VwXNHAUMl1CI0lymtKWgE9eyIpMtXp3aOxsW2mMeOiXj+4ptrlpQiy
 zfmDoq73E7KcdOKRM8hwKCSuu/DfakaRWcKWl9r6pfR49Lt0TmEghXdb1cpdXwqirxBZ
 JDUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFUEJQbz2q+WmvXYv6M2kU9fazA8/3N2oTh0Z+i37HHSJfiEt02Wxom0tLNDtqBSectgDT9eET0qg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kjQqmbJ3kz2dIfQpJeS+LuxIOy/uGHxBZofXJUmfsmLxxmGkLZ
 JXL5MLPjU8PZUIalhBLxweoSUCdYxQYyUMSXGtztreZOeslqr2TTNGPc
X-Gm-Gg: AR+sD10ywjJcR7DjsLeQ4ZYetlONPf3jz0WuPws8YqvzqJQzRmKKfjgq4DmrTfDxura
 qMTwhMOAWopaKKAk9ZfumlP3N3/snRgWI2DvwFtN5v195CdIqGb2nxYcOdj1Wg0/i5pSojnxFp5
 5jH2zIgjCCjdn5ujQZ8i0VARUHxI1NA5H+XNGxfuvzp08NuSvkkNCrNuo8O9Miw1IERLwuydoKT
 1QR4JMc8VCfMifsz8YkSUCsMtY5gV0ibKGXWWG6z5tP4pkXYwzYJ6tD4FBcR8LII5jZtpdgvDCv
 o6RDVtn4+w2uXf90vTy6Ir3L6yzcIiCD62ignCc+0G5eTMb7nPzrz8In17ty3XLctTzNVa/NpzL
 1AS7Q7X9qJ1h01N5qGjHKkDME/oLZvrSNcNOWMaZOvf5wi4RozMotaAM7GvTKo0uMaaWeBvRFFr
 QNxAE/fynr0i6sli1DJ2YBwTNDKZJm/wbf8bVdYkBPLPhepNjnMUUpSPOqI1R01o8pbA==
X-Received: by 2002:a17:907:9495:b0:c21:49df:1650 with SMTP id
 a640c23a62f3a-c2491c9bae2mr962084666b.8.1787484032115; 
 Sun, 23 Aug 2026 04:20:32 -0700 (PDT)
Received: from thinker ([2a13:54c2:f000:e268:6d0c:d746:2b12:231f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm707233866b.38.2026.08.23.04.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 04:20:31 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v5 2/6] drm/ssd130x: Change SSD133X color format to RGB565
 from RGB332
Date: Sun, 23 Aug 2026 14:19:55 +0300
Message-ID: <20260823111959.17029-3-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823111959.17029-1-amit.barzilai22@gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
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
 drivers/gpu/drm/solomon/ssd130x.c | 48 ++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 0b0fc6fe3df2..8cf1e9c84a81 100644
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
+	const u8 remap = SSD133X_SET_REMAP_COM_SPLIT |
+			 FIELD_PREP(SSD133X_SET_REMAP_COLOR_DEPTH_MASK, SSD133X_COLOR_DEPTH_65K);
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
@@ -909,9 +920,10 @@ static void ssd132x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 
 static void ssd133x_clear_screen(struct ssd130x_device *ssd130x, u8 *data_array)
 {
-	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
+	const struct drm_format_info *fi;
 	unsigned int pitch;
 
+	fi = drm_format_info(DRM_FORMAT_RGB565);
 	if (!fi)
 		return;
 
@@ -978,17 +990,18 @@ static int ssd133x_fb_blit_rect(struct drm_framebuffer *fb,
 				struct drm_format_conv_state *fmtcnv_state)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
-	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
+	const struct drm_format_info *fi;
 	unsigned int dst_pitch;
 	struct iosys_map dst;
 
+	fi = drm_format_info(DRM_FORMAT_RGB565);
 	if (!fi)
 		return -EINVAL;
 
 	dst_pitch = drm_format_info_min_pitch(fi, 0, drm_rect_width(rect));
 
 	iosys_map_set_vaddr(&dst, data_array);
-	drm_fb_xrgb8888_to_rgb332(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
+	drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
 
 	ssd133x_update_rect(ssd130x, rect, data_array, dst_pitch);
 
@@ -1446,10 +1459,11 @@ static int ssd133x_crtc_atomic_check(struct drm_crtc *crtc,
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(drm);
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 	struct ssd130x_crtc_state *ssd130x_state = to_ssd130x_crtc_state(crtc_state);
-	const struct drm_format_info *fi = drm_format_info(DRM_FORMAT_RGB332);
+	const struct drm_format_info *fi;
 	unsigned int pitch;
 	int ret;
 
+	fi = drm_format_info(DRM_FORMAT_RGB565);
 	if (!fi)
 		return -EINVAL;
 
-- 
2.55.0

