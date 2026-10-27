Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5DD606A32D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0578710F540;
	Tue, 27 Oct 2026 13:37:24 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B5A10F4A4
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:36:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E6FB721F2F;
 Tue, 27 Oct 2026 13:36:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B6E81342D;
 Tue, 27 Oct 2026 13:36:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wbs7OfSo4GoWVAAAD6G6ig:T7
 (envelope-from <tzimmermann@suse.de>); Tue, 27 Oct 2026 13:36:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6/6] fbcon: Handle characters with no glyph defined in a
 consistent way
Date: Tue, 27 Oct 2026 14:27:21 +0100
Message-ID: <20261027133646.297856-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027133646.297856-1-tzimmermann@suse.de>
References: <20261027133646.297856-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: E6FB721F2F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
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

Check the result of font_data_glyph_buf() for NULL when drawing the
screen. Fall back to a default value of '\0' for undefined glpyhs. Skip
the character if no fallback exists.

Error checking for fonts has been inconsistent or absent from fbcon.
Most of the drawing code relies on earlier validation in the font-import
code. Some code implements the glyph test by itself. At least all of
fbcon should be consistent in how it handles undefined glyphs.

Calls to font_data_glyph_buf() returning NULL for undefined glyphs make
it easy to handle this special case consistently across fbcon.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/bitblit.c   | 27 +++++++++++++++++----------
 drivers/video/fbdev/core/fbcon_ccw.c | 12 +++++++++++-
 drivers/video/fbdev/core/fbcon_cw.c  | 13 +++++++++++--
 drivers/video/fbdev/core/fbcon_ud.c  | 18 +++++++++++++++++-
 4 files changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index b1c90bc29648..e108cd50cb1d 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -80,7 +80,6 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				     unsigned char *buf, u8 *dst)
 {
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int charcnt = vc->vc_font.charcount;
 	u32 idx = vc->vc_font.width >> 3;
 	struct fbcon_par *par = info->fbcon_par;
 	u32 s_pitch = font_glyph_pitch(s_width);
@@ -89,9 +88,12 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 	while (cnt--) {
 		u16 ch = scr_readw(s++) & charmask;
 
-		if (ch >= charcnt)
-			ch = 0;
 		src = font_data_glyph_buf(par->p->fontdata, s_width, s_vpitch, ch);
+		if (!src) {
+			src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch, '\0');
+			if (!src)
+				goto next_char;
+		}
 
 		if (attr) {
 			update_attr(buf, src, attr, vc);
@@ -104,7 +106,7 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 		else
 			fb_pad_aligned_buffer(dst, d_pitch, src, idx,
 					      image->height);
-
+next_char:
 		dst += s_pitch;
 	}
 
@@ -119,7 +121,6 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 				       unsigned char *buf, u8 *dst)
 {
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int charcnt = vc->vc_font.charcount;
 	u32 shift_low = 0, mod = vc->vc_font.width % 8;
 	u32 shift_high = 8;
 	u32 idx = vc->vc_font.width >> 3;
@@ -130,9 +131,12 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 	while (cnt--) {
 		u16 ch = scr_readw(s++) & charmask;
 
-		if (ch >= charcnt)
-			ch = 0;
 		src = font_data_glyph_buf(par->p->fontdata, s_width, s_vpitch, ch);
+		if (!src) {
+			src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch, '\0');
+			if (!src)
+				goto next_char;
+		}
 
 		if (attr) {
 			update_attr(buf, src, attr, vc);
@@ -142,6 +146,7 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 		fb_pad_unaligned_buffer(dst, d_pitch, src, idx,
 					image->height, shift_high,
 					shift_low, mod);
+next_char:
 		shift_low += mod;
 		dst += (shift_low >= 8) ? s_pitch : s_pitch - 1;
 		shift_low &= 7;
@@ -271,10 +276,12 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	attribute = get_attribute(info, c);
 	c &= charmask;
 
-	/* Clamp to font size, same as bit_putcs_aligned() */
-	if (c >= vc->vc_font.charcount)
-		c = 0;
 	src = font_data_glyph_buf(par->p->fontdata, width, vpitch, c);
+	if (!src) {
+		src = font_data_glyph_buf(par->p->fontdata, width, vpitch, '\0');
+		if (!src)
+			return;
+	}
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 9da6c0e41e7a..cbaa75fc1cc1 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -109,6 +109,11 @@ static inline void ccw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 	while (cnt--) {
 		src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch,
 					  scr_readw(s--) & charmask);
+		if (!src) {
+			src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch, '\0');
+			if (!src)
+				goto next_char;
+		}
 
 		if (attr) {
 			ccw_update_attr(buf, src, attr, vc);
@@ -121,7 +126,7 @@ static inline void ccw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 		else
 			fb_pad_aligned_buffer(dst, d_pitch, src, idx,
 					      vc->vc_font.width);
-
+next_char:
 		dst += d_pitch * vc->vc_font.width;
 	}
 
@@ -246,6 +251,11 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
 	src = font_data_glyph_buf(par->rotated.buf, width, vpitch, c & charmask);
+	if (!src) {
+		src = font_data_glyph_buf(par->rotated.buf, width, vpitch, c & charmask);
+		if (!src)
+			return;
+	}
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 354f40f77bb4..7606ad38c269 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -94,7 +94,11 @@ static inline void cw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 	while (cnt--) {
 		src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch,
 					  scr_readw(s++) & charmask);
-
+		if (!src) {
+			src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch, '\0');
+			if (!src)
+				goto next_char;
+		}
 		if (attr) {
 			cw_update_attr(buf, src, attr, vc);
 			src = buf;
@@ -106,7 +110,7 @@ static inline void cw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 		else
 			fb_pad_aligned_buffer(dst, d_pitch, src, idx,
 					      vc->vc_font.width);
-
+next_char:
 		dst += d_pitch * vc->vc_font.width;
 	}
 
@@ -229,6 +233,11 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
 	src = font_data_glyph_buf(par->rotated.buf, width, vpitch, c & charmask);
+	if (!src) {
+		src = font_data_glyph_buf(par->rotated.buf, width, vpitch, '\0');
+		if (!src)
+			return;
+	}
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index 01f45eaa2013..bdba3a959d1e 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -96,6 +96,11 @@ static inline void ud_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 	while (cnt--) {
 		src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch,
 					  scr_readw(s--) & charmask);
+		if (!src) {
+			src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch, '\0');
+			if (!src)
+				goto next_char;
+		}
 
 		if (attr) {
 			ud_update_attr(buf, src, attr, vc);
@@ -108,7 +113,7 @@ static inline void ud_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 		else
 			fb_pad_aligned_buffer(dst, d_pitch, src, idx,
 					      image->height);
-
+next_char:
 		dst += s_pitch;
 	}
 
@@ -133,6 +138,11 @@ static inline void ud_putcs_unaligned(struct vc_data *vc,
 	while (cnt--) {
 		src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch,
 					  scr_readw(s--) & charmask);
+		if (!src) {
+			src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch, '\0');
+			if (!src)
+				goto next_char;
+		}
 
 		if (attr) {
 			ud_update_attr(buf, src, attr, vc);
@@ -142,6 +152,7 @@ static inline void ud_putcs_unaligned(struct vc_data *vc,
 		fb_pad_unaligned_buffer(dst, d_pitch, src, idx,
 					image->height, shift_high,
 					shift_low, mod);
+next_char:
 		shift_low += mod;
 		dst += (shift_low >= 8) ? s_pitch : s_pitch - 1;
 		shift_low &= 7;
@@ -279,6 +290,11 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
 	src = font_data_glyph_buf(par->rotated.buf, width, vpitch, c & charmask);
+	if (!src) {
+		src = font_data_glyph_buf(par->rotated.buf, width, vpitch, '\0');
+		if (!src)
+			return;
+	}
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
-- 
2.56.0

