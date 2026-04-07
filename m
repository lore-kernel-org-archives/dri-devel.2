Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA25EDB7D4
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C8710E384;
	Tue,  7 Apr 2026 09:26:05 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44C0010E383
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:26:03 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2284F5BD7F;
 Tue,  7 Apr 2026 09:26:02 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEBBB4A0B1;
 Tue,  7 Apr 2026 09:26:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OIZHManN1GmDVwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 07 Apr 2026 09:26:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 geert@linux-m68k.org, simona@ffwll.ch, sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 05/10] lib/fonts: Implement glyph rotation
Date: Tue,  7 Apr 2026 11:23:16 +0200
Message-ID: <20260407092555.58816-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407092555.58816-1-tzimmermann@suse.de>
References: <20260407092555.58816-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 2284F5BD7F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
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

Move the glyph rotation helpers from fbcon to the font library. Wrap them
behind clean interfaces. Also clear the output memory to zero. Previously,
the implementation relied on the caller to do that.

Go through the fbcon code and callers of the glyph-rotation helpers. In
addition to the font rotation, there's also the cursor code, which uses
the rotation helpers.

The font-rotation relied on a single memset to zero for the whole font.
This is now multiple memsets on each glyph. This will be sorted out when
the font library also implements font rotation.

Building glyph rotation in the font library still depends on
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y. If we get more users of the code,
we can still add a dedicated Kconfig symbol to the font library.

No changes have been made to the actual implementation of the rotate_*()
and pattern_*() functions. These will be refactored as separate changes.

v2:
- fix typos

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon_ccw.c    |   4 +-
 drivers/video/fbdev/core/fbcon_cw.c     |   4 +-
 drivers/video/fbdev/core/fbcon_rotate.c |  12 +-
 drivers/video/fbdev/core/fbcon_rotate.h |  71 -----------
 include/linux/font.h                    |   8 ++
 lib/fonts/Makefile                      |   1 +
 lib/fonts/font_rotate.c                 | 150 ++++++++++++++++++++++++
 7 files changed, 167 insertions(+), 83 deletions(-)
 create mode 100644 lib/fonts/font_rotate.c

diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 96ef449ee6ac..72453a2aaca8 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <linux/font.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
 #include <asm/types.h>
@@ -344,8 +345,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		size = cur_height * width;
 		while (size--)
 			tmp[i++] = 0xff;
-		memset(mask, 0, w * vc->vc_font.width);
-		rotate_ccw(tmp, mask, vc->vc_font.width, vc->vc_font.height);
+		font_glyph_rotate_270(tmp, vc->vc_font.width, vc->vc_font.height, mask);
 		kfree(tmp);
 	}
 
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index ea712654edae..5690fc1d7854 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <linux/font.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
 #include <asm/types.h>
@@ -327,8 +328,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		size = cur_height * width;
 		while (size--)
 			tmp[i++] = 0xff;
-		memset(mask, 0, w * vc->vc_font.width);
-		rotate_cw(tmp, mask, vc->vc_font.width, vc->vc_font.height);
+		font_glyph_rotate_90(tmp, vc->vc_font.width, vc->vc_font.height, mask);
 		kfree(tmp);
 	}
 
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 18575c5182db..588dc9d6758a 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/fb.h>
+#include <linux/font.h>
 #include <linux/vt_kern.h>
 #include <linux/console.h>
 #include <asm/types.h>
@@ -60,30 +61,25 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	}
 
 	dst = par->fontbuffer;
-	memset(dst, 0, par->fd_size);
 
 	switch (par->rotate) {
 	case FB_ROTATE_UD:
 		for (i = len; i--; ) {
-			rotate_ud(src, dst, vc->vc_font.width,
-				  vc->vc_font.height);
-
+			font_glyph_rotate_180(src, vc->vc_font.width, vc->vc_font.height, dst);
 			src += s_cellsize;
 			dst += d_cellsize;
 		}
 		break;
 	case FB_ROTATE_CW:
 		for (i = len; i--; ) {
-			rotate_cw(src, dst, vc->vc_font.width,
-				  vc->vc_font.height);
+			font_glyph_rotate_90(src, vc->vc_font.width, vc->vc_font.height, dst);
 			src += s_cellsize;
 			dst += d_cellsize;
 		}
 		break;
 	case FB_ROTATE_CCW:
 		for (i = len; i--; ) {
-			rotate_ccw(src, dst, vc->vc_font.width,
-				   vc->vc_font.height);
+			font_glyph_rotate_270(src, vc->vc_font.width, vc->vc_font.height, dst);
 			src += s_cellsize;
 			dst += d_cellsize;
 		}
diff --git a/drivers/video/fbdev/core/fbcon_rotate.h b/drivers/video/fbdev/core/fbcon_rotate.h
index 8cb019e8a9c0..725bcae2df61 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.h
+++ b/drivers/video/fbdev/core/fbcon_rotate.h
@@ -19,77 +19,6 @@
         (fb_scrollmode(s) == SCROLL_REDRAW || fb_scrollmode(s) == SCROLL_MOVE || !(i)->fix.xpanstep) ? \
         (i)->var.xres : (i)->var.xres_virtual; })
 
-
-static inline int pattern_test_bit(u32 x, u32 y, u32 pitch, const char *pat)
-{
-	u32 tmp = (y * pitch) + x, index = tmp / 8,  bit = tmp % 8;
-
-	pat +=index;
-	return (*pat) & (0x80 >> bit);
-}
-
-static inline void pattern_set_bit(u32 x, u32 y, u32 pitch, char *pat)
-{
-	u32 tmp = (y * pitch) + x, index = tmp / 8, bit = tmp % 8;
-
-	pat += index;
-
-	(*pat) |= 0x80 >> bit;
-}
-
-static inline void rotate_ud(const char *in, char *out, u32 width, u32 height)
-{
-	int i, j;
-	int shift = (8 - (width % 8)) & 7;
-
-	width = (width + 7) & ~7;
-
-	for (i = 0; i < height; i++) {
-		for (j = 0; j < width - shift; j++) {
-			if (pattern_test_bit(j, i, width, in))
-				pattern_set_bit(width - (1 + j + shift),
-						height - (1 + i),
-						width, out);
-		}
-
-	}
-}
-
-static inline void rotate_cw(const char *in, char *out, u32 width, u32 height)
-{
-	int i, j, h = height, w = width;
-	int shift = (8 - (height % 8)) & 7;
-
-	width = (width + 7) & ~7;
-	height = (height + 7) & ~7;
-
-	for (i = 0; i < h; i++) {
-		for (j = 0; j < w; j++) {
-			if (pattern_test_bit(j, i, width, in))
-				pattern_set_bit(height - 1 - i - shift, j,
-						height, out);
-
-		}
-	}
-}
-
-static inline void rotate_ccw(const char *in, char *out, u32 width, u32 height)
-{
-	int i, j, h = height, w = width;
-	int shift = (8 - (width % 8)) & 7;
-
-	width = (width + 7) & ~7;
-	height = (height + 7) & ~7;
-
-	for (i = 0; i < h; i++) {
-		for (j = 0; j < w; j++) {
-			if (pattern_test_bit(j, i, width, in))
-				pattern_set_bit(i, width - 1 - j - shift,
-						height, out);
-		}
-	}
-}
-
 int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc);
 
 #if defined(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION)
diff --git a/include/linux/font.h b/include/linux/font.h
index 3bd49d914b22..0a240dd70422 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -104,6 +104,14 @@ unsigned int font_data_size(font_data_t *fd);
 bool font_data_is_equal(font_data_t *lhs, font_data_t *rhs);
 int font_data_export(font_data_t *fd, struct console_font *font, unsigned int vpitch);
 
+/* font_rotate.c */
+void font_glyph_rotate_90(const unsigned char *glyph, unsigned int width, unsigned int height,
+			  unsigned char *out);
+void font_glyph_rotate_180(const unsigned char *glyph, unsigned int width, unsigned int height,
+			   unsigned char *out);
+void font_glyph_rotate_270(const unsigned char *glyph, unsigned int width, unsigned int height,
+			   unsigned char *out);
+
 /*
  * Font description
  */
diff --git a/lib/fonts/Makefile b/lib/fonts/Makefile
index b176af53d53e..7202a70a56ef 100644
--- a/lib/fonts/Makefile
+++ b/lib/fonts/Makefile
@@ -2,6 +2,7 @@
 # Font handling
 
 font-y := fonts.o
+font-$(CONFIG_FRAMEBUFFER_CONSOLE_ROTATION) += font_rotate.o
 
 # Built-in fonts; sorted by Family-Size in ascending order
 font-$(CONFIG_FONT_6x8)       += font_6x8.o
diff --git a/lib/fonts/font_rotate.c b/lib/fonts/font_rotate.c
new file mode 100644
index 000000000000..d107a8d0a2b0
--- /dev/null
+++ b/lib/fonts/font_rotate.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Font rotation
+ *
+ *    Copyright (C) 2005 Antonino Daplas <adaplas @pol.net>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive for
+ * more details.
+ */
+
+#include <linux/export.h>
+#include <linux/math.h>
+#include <linux/string.h>
+
+#include "font.h"
+
+static inline int pattern_test_bit(u32 x, u32 y, u32 pitch, const char *pat)
+{
+	u32 tmp = (y * pitch) + x, index = tmp / 8,  bit = tmp % 8;
+
+	pat += index;
+	return (*pat) & (0x80 >> bit);
+}
+
+static inline void pattern_set_bit(u32 x, u32 y, u32 pitch, char *pat)
+{
+	u32 tmp = (y * pitch) + x, index = tmp / 8, bit = tmp % 8;
+
+	pat += index;
+
+	(*pat) |= 0x80 >> bit;
+}
+
+static inline void rotate_cw(const char *in, char *out, u32 width, u32 height)
+{
+	int i, j, h = height, w = width;
+	int shift = (8 - (height % 8)) & 7;
+
+	width = (width + 7) & ~7;
+	height = (height + 7) & ~7;
+
+	for (i = 0; i < h; i++) {
+		for (j = 0; j < w; j++) {
+			if (pattern_test_bit(j, i, width, in))
+				pattern_set_bit(height - 1 - i - shift, j,
+						height, out);
+		}
+	}
+}
+
+/**
+ * font_glyph_rotate_90 - Rotate a glyph pattern by 90° in clockwise direction
+ * @glyph: The glyph to rotate
+ * @width: The glyph width in bits per scanline
+ * @height: The number of scanlines in the glyph
+ * @out: The rotated glyph bitmap
+ *
+ * The parameters @width and @height refer to the input glyph given in @glyph.
+ * The caller has to provide the output buffer @out of sufficient size to hold
+ * the rotated glyph. Rotating by 90° flips the width and height for the output
+ * glyph. Depending on the glyph pitch, the size of the output glyph can be
+ * different than the size of the input. Callers have to take this into account
+ * when allocating the output memory.
+ */
+void font_glyph_rotate_90(const unsigned char *glyph, unsigned int width, unsigned int height,
+			  unsigned char *out)
+{
+	memset(out, 0, font_glyph_size(height, width)); /* flip width/height */
+
+	rotate_cw(glyph, out, width, height);
+}
+EXPORT_SYMBOL_GPL(font_glyph_rotate_90);
+
+static inline void rotate_ud(const char *in, char *out, u32 width, u32 height)
+{
+	int i, j;
+	int shift = (8 - (width % 8)) & 7;
+
+	width = (width + 7) & ~7;
+
+	for (i = 0; i < height; i++) {
+		for (j = 0; j < width - shift; j++) {
+			if (pattern_test_bit(j, i, width, in))
+				pattern_set_bit(width - (1 + j + shift),
+						height - (1 + i),
+						width, out);
+		}
+	}
+}
+
+/**
+ * font_glyph_rotate_180 - Rotate a glyph pattern by 180°
+ * @glyph: The glyph to rotate
+ * @width: The glyph width in bits per scanline
+ * @height: The number of scanlines in the glyph
+ * @out: The rotated glyph bitmap
+ *
+ * The parameters @width and @height refer to the input glyph given in @glyph.
+ * The caller has to provide the output buffer @out of sufficient size to hold
+ * the rotated glyph.
+ */
+void font_glyph_rotate_180(const unsigned char *glyph, unsigned int width, unsigned int height,
+			   unsigned char *out)
+{
+	memset(out, 0, font_glyph_size(width, height));
+
+	rotate_ud(glyph, out, width, height);
+}
+EXPORT_SYMBOL_GPL(font_glyph_rotate_180);
+
+static inline void rotate_ccw(const char *in, char *out, u32 width, u32 height)
+{
+	int i, j, h = height, w = width;
+	int shift = (8 - (width % 8)) & 7;
+
+	width = (width + 7) & ~7;
+	height = (height + 7) & ~7;
+
+	for (i = 0; i < h; i++) {
+		for (j = 0; j < w; j++) {
+			if (pattern_test_bit(j, i, width, in))
+				pattern_set_bit(i, width - 1 - j - shift,
+						height, out);
+		}
+	}
+}
+
+/**
+ * font_glyph_rotate_270 - Rotate a glyph pattern by 270° in clockwise direction
+ * @glyph: The glyph to rotate
+ * @width: The glyph width in bits per scanline
+ * @height: The number of scanlines in the glyph
+ * @out: The rotated glyph bitmap
+ *
+ * The parameters @width and @height refer to the input glyph given in @glyph.
+ * The caller has to provide the output buffer @out of sufficient size to hold
+ * the rotated glyph. Rotating by 270° flips the width and height for the output
+ * glyph. Depending on the glyph pitch, the size of the output glyph can be
+ * different than the size of the input. Callers have to take this into account
+ * when allocating the output memory.
+ */
+void font_glyph_rotate_270(const unsigned char *glyph, unsigned int width, unsigned int height,
+			   unsigned char *out)
+{
+	memset(out, 0, font_glyph_size(height, width)); /* flip width/height */
+
+	rotate_ccw(glyph, out, width, height);
+}
+EXPORT_SYMBOL_GPL(font_glyph_rotate_270);
-- 
2.53.0

