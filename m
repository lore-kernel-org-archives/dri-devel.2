Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8782606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57F8010F4FD;
	Tue, 27 Oct 2026 13:37:01 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8963810F4A4
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:36:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4663521F2D;
 Tue, 27 Oct 2026 13:36:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEAB213419;
 Tue, 27 Oct 2026 13:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wbs7OfSo4GoWVAAAD6G6ig:T4
 (envelope-from <tzimmermann@suse.de>); Tue, 27 Oct 2026 13:36:53 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/6] lib/fonts, fbcon: Use font_data_t for rotated fonts
Date: Tue, 27 Oct 2026 14:27:18 +0100
Message-ID: <20261027133646.297856-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027133646.297856-1-tzimmermann@suse.de>
References: <20261027133646.297856-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: 4663521F2D
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Return rotated font data as font_data_t instead of unsigned char*.
Release the data with font_data_put() in fbcon.

It is still possible to use preallocated font buffers for the rotated
font data. The font data tracks the buffer size and reference count to
do so; font_data_rotate() invokes __font_data_alloc() to allocate a
new font-data buffer is necessary.

Returning rotated font data as font_data_t further allows for using
regular font-data helpers on it. Fbcon now manages buffer life time
with the font data's reference counting. Removes the plain kfree().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.c        |  3 ++-
 drivers/video/fbdev/core/fbcon.h        |  3 +--
 drivers/video/fbdev/core/fbcon_rotate.c | 19 ++++++++-------
 include/linux/font.h                    |  5 ++--
 lib/fonts/font_rotate.c                 | 32 ++++++++++---------------
 5 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index d97d94bb8e99..9a88a47fc84c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -770,7 +770,8 @@ static void fbcon_release(struct fb_info *info)
 		kfree(par->cursor_data);
 		kfree(par->cursor_src);
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-		kfree(par->rotated.buf);
+		if (par->rotated.buf)
+			font_data_put(par->rotated.buf);
 #endif
 		kfree(info->fbcon_par);
 		info->fbcon_par = NULL;
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index ab78dad15925..8b662226004c 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -90,8 +90,7 @@ struct fbcon_par {
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
 	struct {
 		font_data_t *fontdata;  /* source font */
-		unsigned char *buf;     /* rotated glyphs */
-		size_t bufsize;
+		font_data_t *buf;       /* rotated font */
 		int buf_rotate;         /* rotation of buf */
 	} rotated;
 #endif
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 6cdbc96eeca6..b7c48e7c4a6e 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -18,7 +18,7 @@
 int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 {
 	struct fbcon_par *par = info->fbcon_par;
-	unsigned char *buf;
+	font_data_t *buf;
 	int ret;
 
 	if (par->p->fontdata == par->rotated.fontdata && par->rotate == par->rotated.buf_rotate)
@@ -32,21 +32,22 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 
 	buf = font_data_rotate(par->rotated.fontdata, vc->vc_font.width,
 			       vc->vc_font.height, vc->vc_font.charcount,
-			       par->rotated.buf_rotate, par->rotated.buf,
-			       &par->rotated.bufsize);
+			       par->rotated.buf_rotate, par->rotated.buf);
 	if (IS_ERR(buf)) {
 		ret = PTR_ERR(buf);
-		goto err_kfree;
+		goto err_font_data_put;
 	}
 
+	if (par->rotated.buf)
+		font_data_put(par->rotated.buf);
 	par->rotated.buf = buf;
 
 	return 0;
 
-err_kfree:
-	kfree(par->rotated.buf);
-	par->rotated.buf = NULL; /* clear here to avoid output */
-	par->rotated.bufsize = 0;
-
+err_font_data_put:
+	if (par->rotated.buf) {
+		font_data_put(par->rotated.buf);
+		par->rotated.buf = NULL; /* clear here to avoid output */
+	}
 	return ret;
 }
diff --git a/include/linux/font.h b/include/linux/font.h
index be1a26ff8ae9..2d7e2ca3db0f 100644
--- a/include/linux/font.h
+++ b/include/linux/font.h
@@ -120,9 +120,8 @@ void font_glyph_rotate_180(const unsigned char *glyph, unsigned int width, unsig
 			   unsigned char *out);
 void font_glyph_rotate_270(const unsigned char *glyph, unsigned int width, unsigned int height,
 			   unsigned char *out);
-unsigned char *font_data_rotate(font_data_t *fd, unsigned int width, unsigned int height,
-				unsigned int charcount, unsigned int steps,
-				unsigned char *buf, size_t *bufsize);
+font_data_t *font_data_rotate(font_data_t *fd, unsigned int width, unsigned int height,
+			      unsigned int charcount, unsigned int steps, font_data_t *buf);
 
 /*
  * Font description
diff --git a/lib/fonts/font_rotate.c b/lib/fonts/font_rotate.c
index 275406008823..ea54bd618ffb 100644
--- a/lib/fonts/font_rotate.c
+++ b/lib/fonts/font_rotate.c
@@ -181,8 +181,7 @@ EXPORT_SYMBOL_GPL(font_glyph_rotate_270);
  * @height: The number of scanlines in the glyph
  * @charcount: The number of glyphs in the font
  * @steps: Number of rotation steps of 90°
- * @buf: Preallocated output buffer; can be NULL
- * @bufsize: The size of @buf in bytes; can be NULL
+ * @buf: Preallocated font data; can be NULL
  *
  * The parameters @width and @height refer to the visible number of pixels
  * and scanlines in a single glyph. The number of glyphs is given in @charcount.
@@ -194,16 +193,14 @@ EXPORT_SYMBOL_GPL(font_glyph_rotate_270);
  * as returned by font_data_buf(). Callers are responsible to free the returned
  * buffer with kfree(). Font rotation typically happens when displays get
  * re-oriented. To avoid unnecessary re-allocation of the memory buffer, the
- * caller can pass in an earlier result buffer in @buf for reuse. The old and
- * new buffer sizes are given and retrieved by the caller in @bufsize. The
- * allocation semantics are compatible with krealloc().
+ * caller can pass in an earlier result in @buf for reuse. The returned font
+ * data should be released with font_data_put().
  *
  * Returns:
- * A buffer with rotated glyphs on success, or an error pointer otherwise
+ * Font data with rotated glyphs on success, or an error pointer otherwise
  */
-unsigned char *font_data_rotate(font_data_t *fd, unsigned int width, unsigned int height,
-				unsigned int charcount, unsigned int steps,
-				unsigned char *buf, size_t *bufsize)
+font_data_t *font_data_rotate(font_data_t *fd, unsigned int width, unsigned int height,
+			      unsigned int charcount, unsigned int steps, font_data_t *buf)
 {
 	const unsigned char *src = font_data_buf(fd);
 	unsigned int s_cellsize = font_glyph_size(width, height);
@@ -227,19 +224,16 @@ unsigned char *font_data_rotate(font_data_t *fd, unsigned int width, unsigned in
 	if (check_mul_overflow(charcount, d_cellsize, &size))
 		return ERR_PTR(-EINVAL);
 
-	if (!buf || !bufsize || size > *bufsize) {
-		dst = kmalloc_array(charcount, d_cellsize, GFP_KERNEL);
-		if (!dst)
-			return ERR_PTR(-ENOMEM);
-
-		kfree(buf);
-		buf = dst;
-		if (bufsize)
-			*bufsize = size;
+	if (!buf || size > font_data_size(buf)) {
+		buf = __font_data_alloc(size, GFP_KERNEL);
+		if (IS_ERR(buf))
+			return buf;
 	} else {
-		dst = buf;
+		font_data_get(buf);
 	}
 
+	dst = __font_data_wrbuf(buf);
+
 	switch (steps) {
 	case 0:
 		memcpy(dst, src, size);
-- 
2.56.0

