Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7356606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XH+9MFDz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E04F1112013;
	Thu, 29 Oct 2026 08:04:47 +0000 (UTC)
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFA1810E6B9
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 17:46:34 +0000 (UTC)
Received: by mail-dy2-f9.google.com with SMTP id
 5a478bee46e88-35fad13ca97so234869eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793209594; x=1793814394; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J5kskPYEzVbZTmug890A+LF3utkapqU/C4c+xhUhSgg=;
 b=XH+9MFDzAukNUzFdK9YnAdEuy4Sy+OSUu7ieahfCX/FE80gri70GA2ZEmXuur9OfW8
 i6YMWtsn8QvLYIzCua0c75Oq23yuEVQryqx59icBz3q4oSWMsovXXZVj08+DPKjTpgf/
 inq/mIX/uiNdtD9+NGVRm8hs72cPZL7+40a6T9WrsM0Vj8BEmjIl8w311e8nba0nfRei
 Z1TZK+GCPiJPrBaF0dNOQRiDkBqbzJ6q4aDyhAJjwMuCXyQgR3D1omNsrtH1nDwlVh7x
 ztNjqH1okrwA8NFep8DZy1W2lk9x9k40cHICiLr/yymqEVOzBIbJzTQjPFkuRsXSg0gc
 Zb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793209594; x=1793814394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J5kskPYEzVbZTmug890A+LF3utkapqU/C4c+xhUhSgg=;
 b=Ll61TgdC80vdHSGXxqImZ4udC7feix1cQU9vw2wMExIXFapdTJ1eHaDsKM5bP9lrC/
 hcA6vpI2SX10oQWgBztpfNNlNvnqYEmleuWCcU0H/MLZPOKgNyV/mAzJOohYB8Qln2fM
 Ek80qESMVtleRjmcSG3SAM1pk7EGq1FtHp4OG9BZeD5zj6ThLxmAH0VdqjYU6JWV6Gti
 J1ZJk7DyuKsT89aRAZ+mk5YXmrTYWPl9pnk8E+n8PmePcXtymbZ9o7g34gmPgxgViwGK
 pZIHEtw26OuokwreVFiCU8urvvbGYGSCTIjY3i/XQu5fp3Z5D0zWX60PWLA2YgL+EJ8S
 3Dlw==
X-Gm-Message-State: AFq9FYKpfSKrC13NXggV4EeoRBRCTPCR5q7ZVDUAkml6eMo8YSrerL77
 JTTdLBijf/v6iLdyq8ewMczPIR0+KUUFOrrfeDlw+yZWsze4qt7ZmSjS2/1Dh2oWSrojOw==
X-Gm-Gg: AYBFou25mjL/KTsMVMK/gVRKXU/A9g7uAfFKAzD5WF6xnDEdjPq+a725uWLJSQg278Z
 E4pk8Xrd/NFqnJfc5sxZIpbwk2JoPtgJmU1mzFoQwG34KZVpHUyFv9Nycqt3oD9lava8PgHv13f
 N7y2KLEVMUS9wpocah90fJ1AjiQyawQdbvqKeMwVco6f+gpafPGr44nSjRgG6X2cd/Kh4ZQsGCa
 gELgj84icqol2Gny1WKaauZ+D5vZL7lNXkhNaDFZ+JbxnMRWnao2od2fLpLWBrFvKf9ByUAw6yx
 dJwI96UPrLaY0DfC+T7hfPSqKGO7l6UhBxdc+1EPeRZz3NUEMbpEXdqsxbIqeRY61nvKGOD7bkI
 U+4fMwPMFkVLTUaSqTOIdy+rOtaLw1UTyJOmJ+uodzS1P2E3Y18nZtGsU+jvqFUAbqiQ1+gu2zs
 Wd5UE90AbtNEzCigG45X8rIPFl0Z9rtcmu3IUcDNFUWAZzVB5aNcp+kO/x1GWjalOBROqlUhKuK
 CKwgCLN+QoFhTOET4myJY6teqzGuqgOz5MyAvFahvD1M+Kum29T8TlZnWmaRp1PoHO6O1eDvmMg
 DDJvy5b7RLvFIOWIaJwk8dJldQ++IuiPppKYp4TqCp3O1Dp/g57rsRykO5+iP349TNcCDxh/M33
 2M4AQ0qT5I4KwzQ==
X-Received: by 2002:a05:693c:41c8:20b0:351:5cb5:53f7 with SMTP id
 5a478bee46e88-36a2027e717mr4970207eec.3.1793209593900; 
 Wed, 28 Oct 2026 10:46:33 -0700 (PDT)
Received: from toolbx (2607-8700-5500-3d9a-0000-0000-0000-0003.16clouds.com.
 [2607:8700:5500:3d9a::3]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a237be80csm17883633eec.2.2026.10.28.10.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:46:33 -0700 (PDT)
From: ZiAo Wang <ziaowang2007@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, linux-kernel@vger.kernel.org,
 Ho Jie Feng <hjf3108@gmail.com>, ZiAo Wang <ziaowang2007@gmail.com>
Subject: [PATCH v2 1/2] drm/format-helper: Add XRGB8888 to UYVY conversion
Date: Thu, 29 Oct 2026 01:44:24 +0800
Message-ID: <20261028174425.21704-2-ziaowang2007@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028174425.21704-1-ziaowang2007@gmail.com>
References: <20261028174425.21704-1-ziaowang2007@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ho Jie Feng <hjf3108@gmail.com>

Add a helper for devices that use packed UYVY but accept XRGB8888
framebuffers.

Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
Signed-off-by: ZiAo Wang <ziaowang2007@gmail.com>
---
 drivers/gpu/drm/drm_format_helper.c   | 73 +++++++++++++++++++++++++++
 drivers/gpu/drm/drm_format_internal.h | 21 ++++++++
 include/drm/drm_format_helper.h       |  4 ++
 3 files changed, 98 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 6cddf05c49..606733ca43 100644
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
index ce29dd05bc..7a4cfb0d18 100644
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
index 2b5c1aef80..e50f96e074 100644
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
2.56.0

