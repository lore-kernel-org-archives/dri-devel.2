Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232F460A6F74
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=K5CsclHg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81B4710F579;
	Tue, 27 Oct 2026 13:54:09 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF51910F572
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:53:54 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so2217047f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793109233; x=1793714033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HFwDNLv3n+wl+JreLzg2KvEaj4Ho3mAm9pShsdfkSdI=;
 b=K5CsclHgL2g+YUut6xwxAQ9vMv1nGf8UhH1utKX6FwbtfwnF4Tp47JD8aygJjQGTd4
 fV9+wa9qIpwk11v5Ye5jXmOxFUywzwHNEppmpGq2WoFyV9drse0fq+VuqjVUuuUP/nR1
 BkG3/FUwcB8d9iLFBbe1v0nUnnCib1HmEHuoF3HfqLR3yVgIw2BRy1MmxhVlE20kZIvP
 1cQFZR243Iw13Z3CvdRdwFwpQ9LcKFty5h+WAgUJpHkFlbxN4AMp1/AaYK90hI6Hp0eX
 nUNAMeJM/uAAa61nzVAkSWiIMZcb6GlBNjHKZAHZGVMRzaWxBEncpy5Q8ID6J+BdDoLW
 +FrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109233; x=1793714033;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HFwDNLv3n+wl+JreLzg2KvEaj4Ho3mAm9pShsdfkSdI=;
 b=AIkRn/RITXTvel9/ojv2iPW1YPW5zrV6r0Yc8RAwp71Dw8HVMv6Sblh6BofUeDqmY/
 uv1ofgZ7AytUcTaQNtVN82Ur+xM7T3BTtPtHghY2P0l7E9n6MVpAYzWgjyukX2R1Li91
 HjzrIXYlZF3V30WByOsXc5QHRJC9vttPZeDbL5bkbWIQr7Z5xM/Bw/w5i6W/f9W/zKEE
 +f5uPVsujLBy54iJEx6kseMgvjK3G5QH53aUIyEiOyyLcEdQ7bv5CmtE7Vn9NTPfgmHl
 c3TnOxYkP1A88s8tO2Wh2caHTBbWzylOT6yxqz8eC6cBrAg5Pm34+CzeoFpN/soFPr4i
 UbEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByUSVj6u2xKvlxi9WzM8lD917NVIdJU5st7rbdScHfUgIoniATmvxpmWAcdX4m2Luh7A/pG6z4CAD8=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI8NoP1Wkw0+PlXW3hbpgB0oP9TrFUmR8awoB4pY1UMYMCRzXWz
 TioS0W/2ZAVwMomb2pr6Jn+VjDlGznoEthRLjKzIA/eOv/n4/vinccnS
X-Gm-Gg: AYBFou3RnPB2XQU0iegZdqIciu8lmbnKP9ojzgXDiH/Fk7B2nAOj8D/zohjW7dpE68P
 6HUtRDJcyR2/S5xvx5/tEVn38e59GwDv1HudyTNz/GA2tvtRAKt2yLqUkAL+S51MEQWINIOUFx6
 X8JnJgfH3nXjmAtyPOKOGYYDURH3Q7tEQOdYZlSGn1vijn+zXOEPH0PCtD4ytFT14b1moPL3cxm
 U9x7HmCFx6tmHCnN0H8J5JC/g/jqcyHgY8eAjXtZXNt4DAU+bZEUA5tx63sBRLInxPwE6pSW7s/
 7NNo8U3lfkWy2ChAS3TQ8PI++ofQfkem1ftb9NEQ5aCi1DeoBicbKSoFcUxVLkezFJiWy6ythgw
 cZDMM0UDgbvsw0fiKk/fe4XlrqBVaEp7i2Bw4QZPFjJ0mtF2A9QZyf4ixGKcmI21RhGe7oSmer7
 ectuDGU40NwmDld0/KY7ROOV0U0+VJDD7Rz4ZuWfRZR//eNNcZCqpMyYWhKEIXcCYBSFHi2/WrJ
 fQ/E+QU6yrJO1UydAPQXoydXjTpCfNJxadN3xqCikhcrUgXc67KWyqTdIX3krdxODwkw4DJQD/3
 izcDJQw=
X-Received: by 2002:a5d:6f08:0:b0:48d:f034:7fcd with SMTP id
 ffacd0b85a97d-48e3eba1207mr20313170f8f.51.1793109232976; 
 Tue, 27 Oct 2026 06:53:52 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.53.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:53:51 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
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
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/15] fbdev: efifb: move the BMP headers to <video/bmp.h>
Date: Tue, 27 Oct 2026 14:53:30 +0100
Message-Id: <20261027135342.2003632-4-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261027135342.2003632-1-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
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
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---

Notes:
    TODO for the efifb maintainers, not changed here so that this patch
    only moves the headers: the bound check
    
    	if ((bitmap_offset + bmp_pitch * bmp_height) > bgrt_image_size)
    
    is done in u32 and can wrap with a crafted BGRT image, for instance
    with a bitmap_offset close to 4 GiB, and so can round_up(3 * bmp_width,
    4) and the product with a huge width; image_offset_x + bmp_width against
    lfb_width is a u32 sum too. efifb_copy_bmp() would then read outside the
    mapped image. The DRM splash client checks the same headers with
    check_add_overflow() and check_mul_overflow(). I can send a separate fix
    if wanted.

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
index 000000000000..8aa249f2302f
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
+ * BITMAPINFOHEADER. Width and height are signed: a negative width means
+ * nothing, and a negative height that the rows go top to bottom.
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

