Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56474606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dvbdw5uu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40C6211203C;
	Thu, 29 Oct 2026 07:58:58 +0000 (UTC)
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEC610FC9F
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 13:26:11 +0000 (UTC)
Received: by mail-dy2-f9.google.com with SMTP id
 5a478bee46e88-34cbc588a31so523755eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 06:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793193971; x=1793798771; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J5kskPYEzVbZTmug890A+LF3utkapqU/C4c+xhUhSgg=;
 b=Dvbdw5uuyi0KrxYkyFgCtAbb32Bz8lecsy/o/xpTvpEYAbpAlRLyeCY8Lwanzn6L/d
 v+6z0vnlctxIVi8vy1Ai50aZt+NbgES1yh2L8taDVnVtmgm2ACLHe9Exz4y8qcx2zQQU
 LGkpoZMO0fdP3JIA051+sxa4c6sAd9kYKyPU0vfXRdZVHNxZUtM5Ge0ST8FQ64WLGdxA
 dqwMccmI4VcbUuVqOFxzjYfm1tBjbziKaVzoLRa7Z38SSadgX+hPPw8DQcSEIEX8IxgE
 W/gkj0zXTWEiMJyt9+3aDBMvC6e0UaRhk8pzZTfRHy7N981TSge0hRGrQLHakC8+T4Mg
 avfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793193971; x=1793798771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J5kskPYEzVbZTmug890A+LF3utkapqU/C4c+xhUhSgg=;
 b=gkxvWAXtxFCSchC9EjrIxMaztvOtM/BDuEz2X7gq92+1v7ij/Bod+dgFHNqffIZ7Yo
 j/KAApsNt6k22mQxaKf7rA4fx8L0yX7utZQvYECovmBXodsU+MISAdl6L11ntKxbQr8o
 MhqGS/pIoI9yrt0FQaJjaV/0D/TvHOz4BymThC2pYvWnAN/410mU0htS1c2IIQvXpyfI
 d4Ol25yqOflzHLaiiYoRX0l+IhjfbAPFOaf5qHLEvKgpC7lwAj+K2wIcCzazhBtPCijL
 y38FeP3dJA76K5dC3M2HJHtbpqEXkY6lVurah8ppk2wMdjuyes0bE6ehqmjKN0ath7a3
 FUxw==
X-Gm-Message-State: AFq9FYLUCPwWU6TrRxIm5Qj5bitzMhiW4ULHmslZj4/PITmaqm9V5BJi
 MmAJupeSfiYUjH4r5QdVR2ir5XyvllIY4LyvN5ydTzsyGC5DQPS9XF08NYUVZUIqNS3Y5Q==
X-Gm-Gg: AYBFou0lv86DDNzJHRtxpOxnrgdbbfQdng4e6Q7uvcbY26ILn1bP+nDpyg0SESLl8ek
 ZowE8Y0XO38w2vEv/f6z5XT8Y/96XZ5uKulS9FyeWuOFVNIQGRIOW+QkhWZk1k6T3dBZzTBPCon
 hRolTfEM+uXcc4EwhnDzHwMnZEBTokDJW7H9NZy4KjrPlOPy07271/hZYz909w/l8enHtxwuxD1
 tQXFJGTh2X2aNeX3Mdt0oxXZHQLAtsrQVx1Be8D1fVmgZaQztmyexZ8o9r7G/fUMSDEi8Hnk0B6
 JRqrOSuQDrR+JK2iKFSxrBZkxPJOTAaUP+skGetQyjGzdHG9FFxLSpBI/OwP0vNWQ1rnUpcRU8v
 FmTn4TonY9v+8y7btWj2TstS+evnzjUi6TCLcL+gRsYqga5W3yQP6QVsvZz6rF+HKIEQX+witcY
 rpO8yrVyAdutVOHM0MoH2Oktw8RwQcQZZmad3cxbb1HmknqmATAKofZOEkrSnIVQucwKrgJPC11
 JM7xVNr7Vu4TAsEpkSdns0eh6+nCvKHA0r5ZvQ/byVcUH3AGgAOsgbPJcK4ss1bW3Bt89n7h3vE
 TW3zcZjGEmp1hhmEVjszOq6eIne1KgTsDK3/4noktF4G1cMjLvdxxvc=
X-Received: by 2002:a05:7022:e883:b0:1a7:2ce7:ad10 with SMTP id
 a92af1059eb24-1a72ce7aeefmr2980468c88.44.1793193970280; 
 Wed, 28 Oct 2026 06:26:10 -0700 (PDT)
Received: from toolbx (2607-8700-5500-3d9a-0000-0000-0000-0003.16clouds.com.
 [2607:8700:5500:3d9a::3]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75c814aa1sm10708639c88.7.2026.10.28.06.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 06:26:10 -0700 (PDT)
From: ZiAo Wang <ziaowang2007@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, jikos@kernel.org, bentiss@kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ho Jie Feng <hjf3108@gmail.com>, ZiAo Wang <ziaowang2007@gmail.com>
Subject: [PATCH 1/3] drm/format-helper: Add XRGB8888 to UYVY conversion
Date: Wed, 28 Oct 2026 21:25:34 +0800
Message-ID: <20261028132536.375927-2-ziaowang2007@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028132536.375927-1-ziaowang2007@gmail.com>
References: <20261028132536.375927-1-ziaowang2007@gmail.com>
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

