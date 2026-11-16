Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88BD606A323
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 23:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a88mP5LD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1410110E34B;
	Sun, 15 Nov 2026 23:22:32 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F25310E078
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 23:22:10 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so3652955e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 15:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794784929; x=1795389729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cn5rUH/LqEYR2KCJXDoJWBOdHFISKEsWG/FrBt6pVFs=;
 b=a88mP5LDIAzPAIrubaI2YwMs5wo2e/PDbIWRUzbzPfpnM3VqFrYMfpqgA1eTuktk17
 9FqgW7BzpSIHc0VJarYzngmHOcqrO3Lveig6fwdhN55QkeSHsyPdQ8eQjgJg6pep9JSP
 6Rp+DHmOrJbnCU/xpQSVI1XNyGZNdzeuvGWRVzeQ5G/qVhOtu9o596ILrghOSkeScm59
 +rncxjTGFx1shQIpXZ85mePNIAN8M4nf7RFapSDs90Rt8Z8O7B9pCxdfsQw6esxec3mf
 jKbxnp5opbe+TnxeGKTKez02oQigXXVUoiA66RCpU0J6OR4lF98cX2BISw6joTFGNmfo
 LMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794784929; x=1795389729;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cn5rUH/LqEYR2KCJXDoJWBOdHFISKEsWG/FrBt6pVFs=;
 b=ZCRzGWWF4ZtdyRmQDQw4g4RCXvNvsbLhQPDPeygIcQCg/qXom7w8IFbgKae8ZETlbp
 Vhw7fJtw3Q39OMFEts75Ks+8zAE6/HzK/VJSvPnat0qCMsn57EzLVbag/XaYTvtdOq+Y
 P+cNdZc0g/8+qqDGk58BAg2Q59Uxni0lICbNQgXRMUVzShxZINd05hYLW4ODJrpAX0WW
 1NXJOHbZnMpBzS1cLehaV2gRfAPlkh/UJfm227uDZfcpUt9xOA0Fm4kLBl05bVA7xhcj
 prIWxqY6+a7NM0ta7qtsrUupDTpUNRw8fu7DkYMzg/XXQuIh/2ajHL/m1MZqvQGOgPtQ
 eiOw==
X-Forwarded-Encrypted: i=1;
 AL+hErFzGQl0OG5JwXusiYPv7/0rDMA44kbXmMLfUDjxGNokBxPoWV2AI9n+FzMQZK4zSzz5cVOkbXwjBMg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/k4Y71xQAqcQzGFNN7L4BP9dKtQwgJ/rp9MIiZdY+GwPJ68v9X
 P+9YfRhg4KFjkZq7g8MOOd3oqoPC7FMIwR+AosICqtTy2zTy/5FcJo8g
X-Gm-Gg: AYBFou0jsKkWKn8aEDQxLzgo240acfqy8p/cLiLjhBniSuKqT3RtAPBPBEByBErIdRO
 VJl8IQ1ruIJ0L+6tMB2qqwDcsqYPy3B7FWvW7UQpItKxQ2w/OuUP7TeC5jQegbi64Jj6FmOEMHy
 1hvK0oqvXvtPlPtPMRZdr1wrkZcWIYTCpxWW48tOmCG+ZU9vdH6lmOVNKMeqRBlaYKLfm8L4oDW
 yHCGSBjvw7vibCs+CcquhMwQlA7JzrIgEFfuwTozvH9FwdTgiuq2ED3mvgz7aIq8WDsm926Y+Jo
 niU6aH0ZSsLsdm9290bQjvJUMOKwoHfWhJ6lQo7WoDfAndHXONe+0pf8+lvQz8hkk9H+uLRzFfC
 odqsDd4mZWCgp7p48L29v6N21v6AkWXmUTj6z1KErl/fQJUa5gl3KGN+PW/bKI3PWb0UPX552P8
 AEbJ2p23cyyP4IlNfPSV1stjHJOqzlawSQVD4O4sdLK2/8+M0NHdScgUwYJhM7Mmf+mNS410BtK
 vMqaPmfhku+RxOB4Rpvipyy0TdJkchUhRhBjFj36cDyHFFwbPZO1GwFnj6sgjZ8jYAy8ZmW+WDt
 4cPUdi9cgboMoW3YoKV7X17CxwpaO+K+SeT7s3FFfcp6hi8fYnB07eY=
X-Received: by 2002:a05:600c:4e88:b0:4bb:6f41:399f with SMTP id
 5b1f17b1804b1-4bb6f413a83mr46879065e9.24.1794784928688; 
 Sun, 15 Nov 2026 15:22:08 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571f976esm127920955e9.3.2026.11.15.15.22.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 15:22:08 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/6] fbdev: efifb: move the BMP headers to <video/bmp.h>
Date: Mon, 16 Nov 2026 01:21:53 +0100
Message-Id: <20261116002156.1027726-4-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116002156.1027726-1-maximpedraza@gmail.com>
References: <20261116002156.1027726-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The DRM splash client parses the same BMP headers as efifb. Rather than
keep a second copy of the structures, move them to include/video/bmp.h
with the magic number.

BMP is little endian whatever the CPU, so the header gives the fields
as __le16 and __le32, and efifb now reads them with
get_unaligned_le16() and get_unaligned_le32(). Width and height are
read signed, as the format has them. No change on the little endian
systems EFI runs on.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/video/fbdev/efifb.c | 49 ++++++++++++++-----------------------
 include/video/bmp.h         | 40 ++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 31 deletions(-)
 create mode 100644 include/video/bmp.h

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 3411be06d3e6..fd348a72f780 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -16,32 +16,13 @@
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/sysfb.h>
+#include <linux/unaligned.h>
+#include <video/bmp.h>
 #include <video/vga.h>
 #include <asm/efi.h>
 #include <drm/drm_connector.h>  /* For DRM_MODE_PANEL_ORIENTATION_* */
 #include <drm/drm_panel_quirks.h> /* For drm_get_panel_orientation_quirk */
 
-struct bmp_file_header {
-	u16 id;
-	u32 file_size;
-	u32 reserved;
-	u32 bitmap_offset;
-} __packed;
-
-struct bmp_dib_header {
-	u32 dib_header_size;
-	s32 width;
-	s32 height;
-	u16 planes;
-	u16 bpp;
-	u32 compression;
-	u32 bitmap_size;
-	u32 horz_resolution;
-	u32 vert_resolution;
-	u32 colors_used;
-	u32 colors_important;
-} __packed;
-
 static bool use_bgrt = true;
 static bool request_mem_succeeded = false;
 static u64 mem_flags = EFI_MEMORY_WC | EFI_MEMORY_UC;
@@ -145,9 +126,10 @@ static bool efifb_bgrt_sanity_check(const struct screen_info *si, u32 bmp_width)
 
 static void efifb_show_boot_graphics(struct fb_info *info, const struct screen_info *si)
 {
-	u32 bmp_width, bmp_height, bmp_pitch, dst_x, y, src_y;
+	u32 bmp_width, bmp_height, bmp_pitch, bitmap_offset, dst_x, y, src_y;
 	struct bmp_file_header *file_header;
 	struct bmp_dib_header *dib_header;
+	s32 width, height;
 	void *bgrt_image = NULL;
 	u8 *dst = info->screen_base;
 
@@ -186,20 +168,25 @@ static void efifb_show_boot_graphics(struct fb_info *info, const struct screen_i
 		goto error;
 
 	file_header = bgrt_image;
-	if (file_header->id != 0x4d42 || file_header->reserved != 0)
+	if (get_unaligned_le16(&file_header->id) != BMP_FILE_MAGIC_ID ||
+	    get_unaligned_le32(&file_header->reserved) != 0)
 		goto error;
+	bitmap_offset = get_unaligned_le32(&file_header->bitmap_offset);
 
 	dib_header = bgrt_image + sizeof(*file_header);
-	if (dib_header->dib_header_size != 40 || dib_header->width < 0 ||
-	    dib_header->planes != 1 || dib_header->bpp != 24 ||
-	    dib_header->compression != 0)
+	width = get_unaligned_le32(&dib_header->width);
+	height = get_unaligned_le32(&dib_header->height);
+	if (get_unaligned_le32(&dib_header->dib_header_size) != 40 ||
+	    width < 0 || get_unaligned_le16(&dib_header->planes) != 1 ||
+	    get_unaligned_le16(&dib_header->bpp) != 24 ||
+	    get_unaligned_le32(&dib_header->compression) != 0)
 		goto error;
 
-	bmp_width = dib_header->width;
-	bmp_height = abs(dib_header->height);
+	bmp_width = width;
+	bmp_height = abs(height);
 	bmp_pitch = round_up(3 * bmp_width, 4);
 
-	if ((file_header->bitmap_offset + bmp_pitch * bmp_height) >
+	if ((bitmap_offset + bmp_pitch * bmp_height) >
 				bgrt_image_size)
 		goto error;
 
@@ -222,12 +209,12 @@ static void efifb_show_boot_graphics(struct fb_info *info, const struct screen_i
 
 		src_y = y - bgrt_tab.image_offset_y;
 		/* Positive header height means upside down row order */
-		if (dib_header->height > 0)
+		if (height > 0)
 			src_y = (bmp_height - 1) - src_y;
 
 		memset(dst, 0, bgrt_tab.image_offset_x * 4);
 		dst_x = bgrt_tab.image_offset_x;
-		efifb_copy_bmp(bgrt_image + file_header->bitmap_offset +
+		efifb_copy_bmp(bgrt_image + bitmap_offset +
 					    src_y * bmp_pitch,
 			       (u32 *)dst + dst_x, bmp_width, si);
 		dst_x += bmp_width;
diff --git a/include/video/bmp.h b/include/video/bmp.h
new file mode 100644
index 000000000000..8e97ded98dfb
--- /dev/null
+++ b/include/video/bmp.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _VIDEO_BMP_H
+#define _VIDEO_BMP_H
+
+#include <linux/types.h>
+
+/* "BM", the first two bytes of a BMP file */
+#define BMP_FILE_MAGIC_ID 0x4d42
+
+/*
+ * The headers at the start of a BMP file. Every field is little endian,
+ * whatever the CPU, and the headers need not be aligned in memory: read them
+ * with get_unaligned_le16() and get_unaligned_le32().
+ */
+struct bmp_file_header {
+	__le16 id;
+	__le32 file_size;
+	__le32 reserved;
+	__le32 bitmap_offset;
+} __packed;
+
+/*
+ * BITMAPINFOHEADER. Width and height are signed: a negative width is
+ * invalid, and a negative height means the rows go top to bottom.
+ */
+struct bmp_dib_header {
+	__le32 dib_header_size;
+	__le32 width;
+	__le32 height;
+	__le16 planes;
+	__le16 bpp;
+	__le32 compression;
+	__le32 bitmap_size;
+	__le32 horz_resolution;
+	__le32 vert_resolution;
+	__le32 colors_used;
+	__le32 colors_important;
+} __packed;
+
+#endif /* _VIDEO_BMP_H */
-- 
2.39.5

