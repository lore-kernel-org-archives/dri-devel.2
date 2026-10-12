Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FAACA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A9610E645;
	Mon, 12 Oct 2026 17:09:28 +0000 (UTC)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C16ED10E65A
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 17:09:22 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cc4b62d118aso1249760a12.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 10:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791824962; x=1792429762; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1xB7LeXBPWjQ/Fkq/Ig7agIfN32e6x+w4jhSajkeZwQ=;
 b=T4ZbBXiB0xjcaQSSJesMFfb86NyjkgLdJkwFfrmYkcmwkgtK0ZLlhIA4OKyn203531
 WFDyLbAzi77xlp5izstoVKwB7Kx3E7Ljpcea2ngoVmmPhFd5IU973+ysrHRhmy8pM0EF
 69r4ByBdePx/jWM8hrc4DqvE3oww5rPNE5vrIAbdmZSVAZj6EgMC0GqGmJ6sVdYk0Aah
 YWdXBWC9NrpXhXChIYKg7r6UELuYw2IA95aHxTOI89KlqNIiPN6gAYnfqzv/kPEPBGuP
 KkLVCw5UhUsGcQVqo1T8jwnF4tluSkAfNbxJqW8aD6xpXtn4CPBKbzRgSZcO+ihOEM91
 OEqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791824962; x=1792429762;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1xB7LeXBPWjQ/Fkq/Ig7agIfN32e6x+w4jhSajkeZwQ=;
 b=sSz4o5HZPvJotUFesEGeVCK+lXNkE0/AZzu0/dUIQCA8BWZPypur3rW+830rYAmnaw
 FZHbJl1xpDXTpDSP/6G/mE+HdvwbktTHlM7sz4A2XsdC4nr+tQwhOP2xeLxj40RWxP7d
 TOqnijFQ55MGIBqm8ReAmpLf0UmLQU9gcrL8G7JHuAhyN3EuUz4u12OYw4Sa4GxDw5og
 zLGnnYnjyQAWGzgGvNsbPJCwpDva1UygtfaNvorNLCRKSps8ZrlEP9s7fBqSSkRLacqg
 g1GMzLARLJw/TWOGC25sGr0AHoCCFjs+B5MwFP9OE6RIZuegjRfl84yOxdcZfkBqn1C6
 urRA==
X-Gm-Message-State: AFq9FYIbTBBBd8J0toqi0S8LKm6/r+qxvARxDurewkPi63yWBBu7QMXw
 93vq3tx9RbiqO/xwh///vNF2Es/RKmqECppz3PS5T/NM8eQdxMPJqQrdYxyQBEXy
X-Gm-Gg: AYBFou1bbB5SqSNgRgFKx0aCO+T8mjO4domWhqKCfHcAJnCbpF151pQqQl1zU+868X9
 zid8WsHiFykXgctua4WrmZxsfwitPyt3/VZsSvB3FTgyXu5e9TirL3vHnyyE1R5gh6GjTdP2i+0
 zwdEaDveOxQq2Jzum5v+6gYlkWgvtMNcFsqEVYjqAm5bhIqONCmhpiSNtzNPCU0tDGOJgh1ZYf+
 tULDFoJiW9Fh7JmE6rL+ydVkZdNLC2hurMzq3fxlusUZkJnQ5Y9GaYPa1E0lqTBPh9llzyf46rI
 ILGWyXMcvCl7ivKc5933o02CPswUcSV6CVsLMU5uf3A4poqUunQnfcA436KlA+G9v9WOIu9BOBX
 xiav0fnd0SlBUHO8gNz4HDhwxYsPE7l3ak0ZcmlgR094TsaU+z2uPh1vkL4l1H3BTWpIIhT+gim
 S14w8Ps0CFRbHzvOKELE3ukDs9USmWKxzADpC5hKh2SnjwekG7nOw1OmOQBqNWlV05H+b1/LHpp
 Fg7JqQQJbUC+F2FEJWekIzli2tpWmE4N4ox9P6Ipt2w2o0uxck=
X-Received: by 2002:a17:90b:4fd0:b0:3a0:9640:8039 with SMTP id
 98e67ed59e1d1-3ab3a778837mr8843817a91.30.1791824962173; 
 Mon, 12 Oct 2026 10:09:22 -0700 (PDT)
Received: from hostname.tail4fb79.ts.net
 ([2401:7400:c804:b668:a144:150d:733a:5ba2])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3ab38ff0d34sm18056092a91.14.2026.10.12.10.09.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:09:21 -0700 (PDT)
From: Ho Jie Feng <hjf3108@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Ho Jie Feng <hjf3108@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/format-helper: Add XRGB8888 to UYVY conversion
Date: Tue, 13 Oct 2026 01:08:56 +0800
Message-ID: <20261012170857.199561-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Add a helper for devices that use packed UYVY but accept XRGB8888
framebuffers.

Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
This is used for a driver, ms912x that I will be submitting. It only
supports uyvy framebuffers.

 drivers/gpu/drm/drm_format_helper.c   | 73 +++++++++++++++++++++++++++
 drivers/gpu/drm/drm_format_internal.h | 21 ++++++++
 include/drm/drm_format_helper.h       |  4 ++
 3 files changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 6cddf05c493bd..606733ca43fb4 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -1379,3 +1379,76 @@ void drm_fb_xrgb8888_to_gray2(struct iosys_map *dst, const unsigned int *dst_pit
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray2);
 
+static void drm_fb_xrgb8888_to_uyvy_line(void *dbuf, const void *sbuf, unsigned int width)
+{
+	u8 *transfer_buffer = dbuf;
+	const __le32 *temp_buffer = sbuf;
+	unsigned int i, dst_offset = 0;
+	unsigned int pixel1, pixel2;
+	unsigned int r1, g1, b1, r2, g2, b2;
+	unsigned int r, g, b;
+	unsigned int v, y1, u, y2;
+
+	for (i = 0; i < width; i += 2) {
+		pixel1 = le32_to_cpup(&temp_buffer[i]);
+		pixel2 = le32_to_cpup(&temp_buffer[i + 1]);
+
+		r1 = (pixel1 & 0x00ff0000) >> 16;
+		g1 = (pixel1 & 0x0000ff00) >> 8;
+		b1 =  pixel1 & 0x000000ff;
+		r2 = (pixel2 & 0x00ff0000) >> 16;
+		g2 = (pixel2 & 0x0000ff00) >> 8;
+		b2 =  pixel2 & 0x000000ff;
+
+		y1 = drm_pixel_rgb_to_y_bt601(r1, g1, b1);
+		y2 = drm_pixel_rgb_to_y_bt601(r2, g2, b2);
+
+		r = r1 + r2;
+		g = g1 + g2;
+		b = b1 + b2;
+
+		v = drm_pixel_rgb2_to_v_bt601(r, g, b);
+		u = drm_pixel_rgb2_to_u_bt601(r, g, b);
+
+		transfer_buffer[dst_offset++] = u;
+		transfer_buffer[dst_offset++] = y1;
+		transfer_buffer[dst_offset++] = v;
+		transfer_buffer[dst_offset++] = y2;
+	}
+}
+
+/**
+ * drm_fb_xrgb8888_to_uyvy - Convert XRGB8888 to UYVY clip buffer
+ * @dst: Array of UYVY destination buffers
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @src: Array of XRGB8888 source buffers
+ * @fb: DRM framebuffer
+ * @clip: Clip rectangle area to copy; x1 and x2 must be even
+ * @state: Transform and conversion state
+ *
+ * This function copies parts of a framebuffer to display memory and converts the
+ * color format during the process. The parameters @dst, @dst_pitch and @src refer
+ * to arrays. Each array must have at least as many entries as there are planes in
+ * @fb's format. Each entry stores the value for the format's respective color plane
+ * at the same index.
+ *
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
+ *
+ * Drivers can use this function for UYVY devices that don't support XRGB8888
+ * natively. ITU BT.601 is being used for the RGB -> YUV conversion.
+ */
+void drm_fb_xrgb8888_to_uyvy(struct iosys_map *dst, const unsigned int *dst_pitch,
+			     const struct iosys_map *src, const struct drm_framebuffer *fb,
+			     const struct drm_rect *clip, struct drm_format_conv_state *state)
+{
+	static const u8 dst_pixsize[DRM_FORMAT_MAX_PLANES] = {
+		2,
+	};
+
+	drm_fb_xfrm(dst, dst_pitch, dst_pixsize, src, fb, clip, false, state,
+		    drm_fb_xrgb8888_to_uyvy_line);
+}
+EXPORT_SYMBOL(drm_fb_xrgb8888_to_uyvy);
+
diff --git a/drivers/gpu/drm/drm_format_internal.h b/drivers/gpu/drm/drm_format_internal.h
index ce29dd05bcc55..7a4cfb0d188cb 100644
--- a/drivers/gpu/drm/drm_format_internal.h
+++ b/drivers/gpu/drm/drm_format_internal.h
@@ -159,6 +159,27 @@ static inline u32 drm_pixel_xrgb8888_to_abgr2101010(u32 pix)
 	       drm_pixel_xrgb8888_to_xbgr2101010(pix);
 }
 
+static inline u32 drm_pixel_rgb_to_y_bt601(u32 r, u32 g, u32 b)
+{
+	const u32 luma = (16U << 16) + 16829 * r + 33039 * g + 6416 * b + 32768;
+
+	return luma >> 16;
+}
+
+static inline u32 drm_pixel_rgb2_to_u_bt601(u32 r2, u32 g2, u32 b2)
+{
+	const u32 u = (128U << 17) - 9714 * r2 - 19071 * g2 + 28784 * b2 + 65536;
+
+	return u >> 17;
+}
+
+static inline u32 drm_pixel_rgb2_to_v_bt601(u32 r2, u32 g2, u32 b2)
+{
+	const u32 v = (128U << 17) + 28784 * r2 - 24103 * g2 - 4681 * b2 + 65536;
+
+	return v >> 17;
+}
+
 /*
  * Conversion from ARGB8888
  */
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 2b5c1aef80b0e..e50f96e07484c 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -136,4 +136,8 @@ void drm_fb_xrgb8888_to_gray2(struct iosys_map *dst, const unsigned int *dst_pit
 			      const struct iosys_map *src, const struct drm_framebuffer *fb,
 			      const struct drm_rect *clip, struct drm_format_conv_state *state);
 
+void drm_fb_xrgb8888_to_uyvy(struct iosys_map *dst, const unsigned int *dst_pitch,
+			     const struct iosys_map *src, const struct drm_framebuffer *fb,
+			     const struct drm_rect *clip, struct drm_format_conv_state *state);
+
 #endif /* __LINUX_DRM_FORMAT_HELPER_H */
-- 
2.55.0

