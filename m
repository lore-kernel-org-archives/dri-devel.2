Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A49F609778C
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Yamglwxg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BE5810EEBE;
	Mon, 19 Oct 2026 15:48:46 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E3710EEBE
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 15:48:39 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3ab98332238so1839161a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792424919; x=1793029719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D8+K0yhFOMML8+Q3O7sLPxhD4rnWfCrAJQplUYe0Ock=;
 b=YamglwxgAdBZRbGYe9V+UCVkngQkt+hfP9IVYwUbiwTY34nihfzEN1q5G6ZpZ6fpMW
 shejkVsCYnSFXEm19C+rB6IjdqFL0ajnPFtklmObhWDOtYib3Y5ao/ybhMJ5eEDjcibd
 NheL5ERMCE+etU4vuLp0DhoIAEBTVtvCC5rpLix9En/j6hJkiBsNe91Dwqz+rpp1c8nc
 LVeaYwMRSFAEG5iOQ4Ht/u5QG01Uv82sZF5eoz04jz2YOGjnXCTB3Y1BGmME/YrK1QW5
 ad374gI5ANwYijrpn+amSQHFyiCo0UafuQX/yFRhWdHjp3o5Awg8Grg6DuqOVRz4pQdJ
 73LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792424919; x=1793029719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D8+K0yhFOMML8+Q3O7sLPxhD4rnWfCrAJQplUYe0Ock=;
 b=njjN8lOPqjDeAC5Y3KTGZR+fgdMBYU6Q4XK3I+cqEbKgtjc2tSdCi5MWuQDXvVqSgE
 MN3Wye9EksMhd0A7q4t0ROX90mRR8UUEG15wweTt8pR/iUYC0fCnCqnWrbUB9vQ09CRg
 61Ijmeh5iaiJW5IzniyKrQ2uLQDmgNq9ercdzENa5fKOxuIdOlyP83kSVSkZyP8EHWzf
 JBjUWdzwLeoObbpnKBKseZtL1stjn5RoDR5ErvMtkIHWQ/pjitINR+JDG4tXB0An+vTw
 utzbTYeB1UMNvH7rdvcrKyJniRNmp55x2idgslbgtdG8CzBuUfny9K8oMiPgJxFgRrQA
 44mQ==
X-Gm-Message-State: AFq9FYIbV/3rxDUxnpMxTYeMNDDPa5op6PMakeJL84z0HdBynFcu5JEE
 n52MokEaa9vyTkjz5HcbD6XaX4AW5SyDvtzllJ+OsNosyZ+78BBvCNO+858CMztB
X-Gm-Gg: AYBFou2/FLc10vfBAUPPNqRsW48YYsTEu+4DteDtYHu5iFUXNm0dmyZ/F0l7q5Qmp2a
 vyGnGQBUOR8FnpKAM03RIpjESiNuUCSZgEhNIP1TDfxESSJrl9LbeDBNm1mLNKiYl4CcclOhYjF
 vXE4iC/RHs/cugHUEcCcrQahZHEPaPDwLVEWBphAwtmce7qoXpzgSa09gFrLKbtgSZWb65kCUx+
 2N0Sr9pwr48C0V64PG2wBAa1N0mbE85BctBOHim3zex+Zjbb3i7v7BlmYY8hGwnt78Qz9wL4GO5
 +hi7A7Y5sLzfUKlyR3AKhsd+uMgVLqjVOCSSS33UJ9RFyhjeZ+PqaZrS6rIZ7wndnVPkcfJ6XbC
 vejEdK38rQE0luco1DN68QJ8fMZ7mVGLzKGn65v+jt4TckAQldKWDSNiCeF24cfZ+YuUODH64YC
 XK2EXggy4TkDv3Yc+r6cR3TcUFqwQGaG9zOdibUnAa85fCWRwfRq5Sol3HjQ+PFuRnkf3q11/vd
 QWEQQEIh0XQXpBN7t6RcwGqNZPI0IBHVUJWNXltb3NgpgT5IA==
X-Received: by 2002:a17:90a:2d0:b0:3ad:43c1:7d41 with SMTP id
 98e67ed59e1d1-3ad43c17f6cmr1295554a91.33.1792424918943; 
 Mon, 19 Oct 2026 08:48:38 -0700 (PDT)
Received: from hostname.tail4fb79.ts.net
 ([2401:7400:c804:b668:a144:150d:733a:5ba2])
 by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-3ad5cc13658sm63271a91.4.2026.10.19.08.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 08:48:38 -0700 (PDT)
From: Ho Jie Feng <hjf3108@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Ho Jie Feng <hjf3108@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] drm/format-helper: Add XRGB8888 to UYVY conversion
Date: Mon, 19 Oct 2026 23:48:05 +0800
Message-ID: <20261019154820.68659-2-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019154820.68659-1-hjf3108@gmail.com>
References: <20261019154820.68659-1-hjf3108@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a helper for devices that use packed UYVY but accept XRGB8888
framebuffers.

Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 drivers/gpu/drm/drm_format_helper.c   | 52 +++++++++++++++++++++++++++
 drivers/gpu/drm/drm_format_internal.h | 19 ++++++++++
 include/drm/drm_format_helper.h       |  4 +++
 3 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 6cddf05c493bd..3cdfb4c68bfbf 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/iosys-map.h>
+#include <linux/math.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -1379,3 +1380,54 @@ void drm_fb_xrgb8888_to_gray2(struct iosys_map *dst, const unsigned int *dst_pit
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray2);
 
+static void drm_fb_xrgb8888_to_uyvy_line(void *dbuf, const void *sbuf, unsigned int pixels)
+{
+	__le32 *dbuf32 = dbuf;
+	const __le32 *sbuf32 = sbuf;
+	const __le32 *send32 = sbuf32 + round_down(pixels, 2);
+
+	while (sbuf32 < send32) {
+		u32 pix1 = le32_to_cpup(sbuf32);
+		u32 pix2 = le32_to_cpup(sbuf32 + 1);
+		u32 val32 = drm_pixel_xrgb8888_to_uyvy_bt601(pix1, pix2);
+
+		*dbuf32++ = cpu_to_le32(val32);
+		sbuf32 += 2;
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
index ce29dd05bcc55..41875656e59e4 100644
--- a/drivers/gpu/drm/drm_format_internal.h
+++ b/drivers/gpu/drm/drm_format_internal.h
@@ -159,6 +159,25 @@ static inline u32 drm_pixel_xrgb8888_to_abgr2101010(u32 pix)
 	       drm_pixel_xrgb8888_to_xbgr2101010(pix);
 }
 
+static inline u32 drm_pixel_xrgb8888_to_uyvy_bt601(u32 pix1, u32 pix2)
+{
+	u32 r1 = (pix1 & 0x00ff0000) >> 16;
+	u32 g1 = (pix1 & 0x0000ff00) >> 8;
+	u32 b1 =  pix1 & 0x000000ff;
+	u32 r2 = (pix2 & 0x00ff0000) >> 16;
+	u32 g2 = (pix2 & 0x0000ff00) >> 8;
+	u32 b2 =  pix2 & 0x000000ff;
+	u32 r = r1 + r2;
+	u32 g = g1 + g2;
+	u32 b = b1 + b2;
+	u32 y1 = ((16U << 16) + 16829 * r1 + 33039 * g1 + 6416 * b1 + 32768) >> 16;
+	u32 y2 = ((16U << 16) + 16829 * r2 + 33039 * g2 + 6416 * b2 + 32768) >> 16;
+	u32 u = ((128U << 17) - 9714 * r - 19071 * g + 28784 * b + 65536) >> 17;
+	u32 v = ((128U << 17) + 28784 * r - 24103 * g - 4681 * b + 65536) >> 17;
+
+	return u | (y1 << 8) | (v << 16) | (y2 << 24);
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

