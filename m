Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3E5606D81A
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TgH3XdiI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC71710FCA3;
	Wed,  4 Nov 2026 15:19:01 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B65DA10FCA3
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 15:18:54 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8a594d313a3so546577b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 07:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793805534; x=1794410334; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Oa7wmpPw7j3ZiDjIECjj/f+/lMAKhUceS0WKlo1NXtc=;
 b=TgH3XdiIUhTtCIR6ZDM581CBTlJ+RlPGuOw4BT45TE50gmLnX61/ke09iNqw8dXg1Q
 N1i4TxYrLcTX9JW8KJInz/4B13Ye0ReybkLRK2ibzUg9zqx0M57/29DCB6r94b3FmGWv
 vKCJiDtNs6UQWrsyXegIdbyxr0uX2fQcvjmngzLXySVfSEvfMv6LwYjyIaPHktloPhIl
 5uHxiBLbfzjb7+qrxqprpHUUC/Mtwr/7kctL8n/OAmn7/6hlW3xWBaWViUa1RQuPdQ2Z
 u2L3ucqWUruvMabc2Q6itxcZdLujpDslTCj2Qzw/Lvf3/Ul2NbmIoFmXly1C85yQjltO
 MzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793805534; x=1794410334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Oa7wmpPw7j3ZiDjIECjj/f+/lMAKhUceS0WKlo1NXtc=;
 b=GRbkl33S/O5TJsMC2uDqHMBDeWiHlTFY/gAltrudTr+zrJXxNWjOoKnLUVQ84auVlL
 dJfVs2V+GwesZLYNUsdp2YhhW1lCMD3zAPVW6wIJdxqUf2ZI7ikBiKJuVt+3zyPGUNAg
 KkAVE1D0Vq5f+GNp9pcH9thHsuuPxA36tnIcB85MGyW0RWyjt+Onwz7Ko7oPzt7kvdrZ
 CgyS0MlEt/VWDo8powh2lneWfgEmR9uUMHoFpMtcSKu63xvGqO7ARNTHH3K/jIuyInwE
 NFWg8PMH5t6Y7NH5hOvhzcMpz14CWgtI18Ea6dTC4NfairbLTV2zMAPK7Pqv/rDloptp
 iFng==
X-Gm-Message-State: APuU4Z8pTFJHPE29G/lzAxF/jxRGOUW4SrGM0gF7zIZbhyLlgm7Y9QRt
 EUorle5KVMIJzGznAuXB/m4oVHva7gXmZAgnvvpn8J2se5Gt8wemomnvHkFuzV6U
X-Gm-Gg: AYBFou0m2H/Vb6AVNkgtNWeVT8OT9WHV8O2gjlWJuVEL+fBZq3P5ibG9c4h27SG1WXS
 fEIcoGvAV8NZsDIMBu5P4PQ/8lMtAbs/llpCVCTmY4pFVS92m4D1Kqappg5Khn14FNP6WvNYhkU
 LII3kh20FjiO2AnPDA0ocW7+ewze5vSdR9QY7VX9ozuzPD0BgfFnwOTcz6y7x4JbmCM97cp8rV8
 S+8tu4x7IZjUdEHRIUtL22EoLbqJ/hxI+BJIJjGLh61veA9M7QVztg3PkRIvcaouJX+GzBWlML+
 4Qpp2N3XB5Uk+8vOQ1kGU0ds3qCPx7Q6YRq74D4wU5YyVUBnTFJ5YsFWmgenlrqJRmOZT0UNRQH
 Vg+TFOEt4CmKveqA8iYIXf6H49/MO1kUqHukzK+uaE65sLiOEEArT8pmXBZs0LrVgsR3dDrCs2F
 4qukazYvsPa9JY600jtTmzLmF2Lmln4X9KnknBgCQIr4qZ2nA6M9kDj/KjmPBNH+dFslvD/TyOJ
 in1vExu2Sb+oWyuSYyInILU7gH3bUPxPVpPkC0d0IcYYRwE642gyGvwBUvKeH+VbAUexUiqg0WQ
 AI9g4icBKDhZYPCYerAlgefvr5+1TGUfe2BZquBPtJny8XsmFQpdlC6J5QY3y04ShUPs092twED
 qlwNj
X-Received: by 2002:a05:6a00:6c9d:b0:89f:ed19:f093 with SMTP id
 d2e1a72fcca58-8a9beb684f0mr13888333b3a.34.1793805533961; 
 Wed, 04 Nov 2026 07:18:53 -0800 (PST)
Received: from hostname.tail4fb79.ts.net
 ([2401:7400:c804:b668:65cc:625f:9c43:1e88])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-8b097fdf9bdsm1110555b3a.7.2026.11.04.07.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:18:53 -0800 (PST)
From: Ho Jie Feng <hjf3108@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Ho Jie Feng <hjf3108@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] drm/format-helper: Add XRGB8888 to UYVY conversion
Date: Wed,  4 Nov 2026 23:16:47 +0800
Message-ID: <20261104151652.59135-2-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104151652.59135-1-hjf3108@gmail.com>
References: <20261104151652.59135-1-hjf3108@gmail.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a helper for devices that use packed UYVY but accept XRGB8888
framebuffers.

Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 drivers/gpu/drm/drm_format_helper.c   | 50 +++++++++++++++++++++++++++
 drivers/gpu/drm/drm_format_internal.h | 19 ++++++++++
 include/drm/drm_format_helper.h       |  4 +++
 3 files changed, 73 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 6cddf05c4..7e5cbb605 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -1379,3 +1379,53 @@ void drm_fb_xrgb8888_to_gray2(struct iosys_map *dst, const unsigned int *dst_pit
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray2);
 
+static void drm_fb_xrgb8888_to_uyvy_line(void *dbuf, const void *sbuf, unsigned int pixels)
+{
+	__le32 *dbuf32 = dbuf;
+	const __le32 *sbuf32 = sbuf;
+	const __le32 *send32 = sbuf32 + pixels;
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
diff --git a/drivers/gpu/drm/drm_format_internal.h b/drivers/gpu/drm/drm_format_internal.h
index ce29dd05b..41875656e 100644
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
index 2b5c1aef8..e50f96e07 100644
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

