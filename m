Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99689606A331
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PnJ8YYEY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zzOB4Qta;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=PnJ8YYEY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zzOB4Qta
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 679B510E5E8;
	Fri, 20 Nov 2026 11:52:43 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87865112937
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:52:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 236232257F;
 Fri, 20 Nov 2026 11:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795175548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBhR1XXDmsaBtS9I7K/8WAas372bkG5V3RmqL726cbA=;
 b=PnJ8YYEYhnEr5/cq9NInMtPbGCIL71e2NJhkK7AtyWn9adXyN92nvnyHvOc8KUkM2WgSDP
 41YFdPKewY1PdcNmWAbprrdznmH7aEkTHomwO/2ERFtXkM6ERIvGRbuQPAbH3nMrcTxel2
 o/pU8Vgrz2GBhrlifxmhu+PYrppT3YU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795175548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBhR1XXDmsaBtS9I7K/8WAas372bkG5V3RmqL726cbA=;
 b=zzOB4QtaUaMDoZ7s7dNjDtgKvSqG2ytRlehDkzkGkqU3eUJm7wg/gG8I+YEX9Cf2yhIUyt
 xtOPQxUxDF1zmFBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795175548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBhR1XXDmsaBtS9I7K/8WAas372bkG5V3RmqL726cbA=;
 b=PnJ8YYEYhnEr5/cq9NInMtPbGCIL71e2NJhkK7AtyWn9adXyN92nvnyHvOc8KUkM2WgSDP
 41YFdPKewY1PdcNmWAbprrdznmH7aEkTHomwO/2ERFtXkM6ERIvGRbuQPAbH3nMrcTxel2
 o/pU8Vgrz2GBhrlifxmhu+PYrppT3YU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795175548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rBhR1XXDmsaBtS9I7K/8WAas372bkG5V3RmqL726cbA=;
 b=zzOB4QtaUaMDoZ7s7dNjDtgKvSqG2ytRlehDkzkGkqU3eUJm7wg/gG8I+YEX9Cf2yhIUyt
 xtOPQxUxDF1zmFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE70F134F6;
 Fri, 20 Nov 2026 11:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UE2UA3o0AGsbDAAAD6G6ig:T7
 (envelope-from <tzimmermann@suse.de>); Fri, 20 Nov 2026 11:52:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 6/6] fbcon: Handle characters with no glyph defined in a
 consistent way
Date: Fri, 20 Nov 2026 12:49:59 +0100
Message-ID: <20261120115215.52092-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120115215.52092-1-tzimmermann@suse.de>
References: <20261120115215.52092-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-15.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_TO(0.00)[gmx.de,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -15.80
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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
index c28329466f05..cf3adc46aaa9 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -81,7 +81,6 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				     unsigned char *buf, u8 *dst)
 {
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int charcnt = vc->vc_font.charcount;
 	u32 idx = vc->vc_font.width >> 3;
 	struct fbcon_par *par = info->fbcon_par;
 	u32 s_pitch = font_glyph_pitch(s_width);
@@ -90,9 +89,12 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
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
@@ -105,7 +107,7 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 		else
 			fb_pad_aligned_buffer(dst, d_pitch, src, idx,
 					      image->height);
-
+next_char:
 		dst += s_pitch;
 	}
 
@@ -120,7 +122,6 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 				       unsigned char *buf, u8 *dst)
 {
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	unsigned int charcnt = vc->vc_font.charcount;
 	u32 shift_low = 0, mod = vc->vc_font.width % 8;
 	u32 shift_high = 8;
 	u32 idx = vc->vc_font.width >> 3;
@@ -131,9 +132,12 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
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
@@ -143,6 +147,7 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 		fb_pad_unaligned_buffer(dst, d_pitch, src, idx,
 					image->height, shift_high,
 					shift_low, mod);
+next_char:
 		shift_low += mod;
 		dst += (shift_low >= 8) ? s_pitch : s_pitch - 1;
 		shift_low &= 7;
@@ -291,10 +296,12 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
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

