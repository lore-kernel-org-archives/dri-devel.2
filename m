Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3C9C88E6A
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B26B210EC24;
	Mon, 14 Sep 2026 09:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IlBAjoH5";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA4E10EC03
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:00:24 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c3ea1f6so702209f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789376423; x=1789981223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VT13ksi3OXIOndUOzudMSplx3NO7d38IamwYpMwrKgo=;
 b=IlBAjoH5EErMbYRMd/a4UX+4BSPUnFzbgbOxl/dL7Ev/lbpeUajCDwYi7pmL9bkRQ6
 CIQ7l7KHxEmGVovsjxFMlDs4B+5QIO/glEowXwkU/Z6V3ZdgvClrX9jk87YbJPwaJ2WA
 rAm9+2zBSU6QHFz+FxGf5n1uELKYhqPZnXnK0KFeF/adUX+ziDsiQnI31AkbsJn5DVqm
 QsYdotWIc8hQF8FhUKdL+lPX3lp+2P8jvE1+uo1doNFVQp6kcLp9k2Bps37vdkbzU9jw
 PqCgNnBwMPKA2sh/YgokRLqXXqrYiWWwe6bgfWWtuMThWZK8rTdmcT/O13Vh3PCeUOo2
 s5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789376423; x=1789981223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VT13ksi3OXIOndUOzudMSplx3NO7d38IamwYpMwrKgo=;
 b=DOKRM2/QeHSU3OY6GaOxyr9WJ18M1TnnZ7vD/mZEKPHjdHj+g5oc9zk9B1wvW/RMqF
 1tKM8ZIKLP1UI/hxPCMNsUZf+rVzsqfLEUTAcsdj0yTqt+3sWi8F7tJjAPBKycN5XqF1
 uAWcP2RlXnJtcrB5XtyuwC7ImMcpJ+3H7k6U74JHPswa6dShtuJNG6SC/mQg3IxehMdW
 MgDrtgyR7gXGL78u+wv/+NtxVc/fg62RAY/f4RUxIhzrbR98yfyJH188qzdT5lSpfpyY
 9RKu972b4uSuBp0E7ljvkiXpBTyL3tAZO9Bksnh9J909LW24yK7SDwHdnvj+19pvK45E
 JuYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzsUf+d5SytQpXagBLzqZdGQO3WfhDZwh2FdcmDExOdcsexPmt32/57ZrVsapN94wc/xLuVDYancog=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mX7zLBV6SJAGwroyZDoN9zXoMOAJ8nOjM5O1z3BINSDH+nNbaR
 6ISis6p7KHvYnWvpHsnNkyN6vD44XOwF8iE52QywIic/kpKpU8TPpn/Y
X-Gm-Gg: AYBFou1zM+wd0OP7Km/NX/64JecP7QgF3dMM3LY5tFB3kW28KiZyL4NMKkn0lXcxsix
 4oD//kzT0dsHtz0k6HRMnblBvDm5ecek2nIVX5ltJGo5oMebg4xmXK0/pjiVfsNfQSFnuvDsQ4z
 G+wKMIThl0mxQ9RWFqosJaCkVTS/pjJ1ALKEc8i2yey49F6fJulyvxg544X6TX4e+owOePxtv6M
 YSJQnNpFO4MdOM1g7catD7XRuu22HkJZNBm06csbW0F4fRsCYKko4+0l35lhFD7m/6CCFpmBjmc
 09kRFSyrLub5Vp5Fsl3EtbK8yQmA6tR2McTPQFwGk5Way4u1aB0EHS752kyZlqs/Uwvc2q6coNf
 PsLWPvGLHU5kj24ABNnEmXCIUOIa1TRNXSxMxsZlOj4ghvqD9V4S556aJj7Ejet/kVhOqWxwFB9
 qdsLK+4eSWEroI+ozeGyRPzAACXZ4vmkDmsUGEh198WMxxGZEnm56lN+h9XlRMOFDg9NDkGs0yb
 Ezgt3rjAMHV
X-Received: by 2002:a5d:5f8e:0:b0:485:8a46:b3ce with SMTP id
 ffacd0b85a97d-48702b8316dmr1416118f8f.54.1789376420461; 
 Mon, 14 Sep 2026 02:00:20 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm25245851f8f.9.2026.09.14.02.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:00:20 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amit.barzilai22@gmail.com
Subject: [PATCH v6 2/6] drm/ssd130x: Change SSD133X color format to RGB565
 from RGB332
Date: Mon, 14 Sep 2026 11:59:27 +0300
Message-ID: <20260914085931.66857-3-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914085931.66857-1-amit.barzilai22@gmail.com>
References: <20260914085931.66857-1-amit.barzilai22@gmail.com>
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

Assisted-by: LLM
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/gpu/drm/solomon/ssd130x.c | 48 ++++++++++++++++++++-----------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index feec4933e3e6..cbf77a74c4fa 100644
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

