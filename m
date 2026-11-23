Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BBD606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ATE63UMw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xTO4OwGO;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ATE63UMw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=xTO4OwGO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8004810EE24;
	Mon, 23 Nov 2026 14:06:23 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13CB810EE39
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:06:02 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E3D51F818;
 Mon, 23 Nov 2026 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795442760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qda36uCecR5SxbtPUCjOZsnDxatuqBJNG4u6q4VQMl4=;
 b=ATE63UMwXMmPvvdTJNCAyMhBO81oiid4qKFYKG8/j59SC0OSzLuh8wdEPH66bAQMquv46f
 ZAh2CcboMhs7JEyc4lxoMcDVhkTAaiwr4bi5Rto90dDWP6tWuBBpBpMTweFHSzs9zvjOqK
 DeTx2ZvUqFi9kw8yZS5kdMdMy70wRYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795442760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qda36uCecR5SxbtPUCjOZsnDxatuqBJNG4u6q4VQMl4=;
 b=xTO4OwGOVOJkO+QvoSTkK5AxzERyP1NXOtXFgJKLVH0SXhX9Q3Pnp3HeXGGyg7uAaRK0Of
 9QOJuFYiZXJNBiCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795442760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qda36uCecR5SxbtPUCjOZsnDxatuqBJNG4u6q4VQMl4=;
 b=ATE63UMwXMmPvvdTJNCAyMhBO81oiid4qKFYKG8/j59SC0OSzLuh8wdEPH66bAQMquv46f
 ZAh2CcboMhs7JEyc4lxoMcDVhkTAaiwr4bi5Rto90dDWP6tWuBBpBpMTweFHSzs9zvjOqK
 DeTx2ZvUqFi9kw8yZS5kdMdMy70wRYo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795442760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qda36uCecR5SxbtPUCjOZsnDxatuqBJNG4u6q4VQMl4=;
 b=xTO4OwGOVOJkO+QvoSTkK5AxzERyP1NXOtXFgJKLVH0SXhX9Q3Pnp3HeXGGyg7uAaRK0Of
 9QOJuFYiZXJNBiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 45AB81352B;
 Mon, 23 Nov 2026 14:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oQeBOkZIBGvqQwAAD6G6ig:T6
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Nov 2026 14:06:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 5/6] fbcon: Look up glyphs using the font interface
Date: Mon, 23 Nov 2026 15:03:38 +0100
Message-ID: <20261123140554.1129792-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123140554.1129792-1-tzimmermann@suse.de>
References: <20261123140554.1129792-1-tzimmermann@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
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

Replace the open-coded glyph lookup with font_data_glyph_buf() in
implementations of putcs and cursor bitops. As rotated glyphs are
now stored as font_data_t, the regular lookup function for glyphs
works.

Also replace the open-coded size calculations with font-data helpers.

Note that with screen rotation enabled, width and height swap places
for CW and CCW implementations.

v3:
- upcast vc_font.data to font_data_t for glyph lookup

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/bitblit.c   | 24 +++++++++++++++---------
 drivers/video/fbdev/core/fbcon_ccw.c | 14 ++++++++------
 drivers/video/fbdev/core/fbcon_cw.c  | 14 ++++++++------
 drivers/video/fbdev/core/fbcon_ud.c  | 23 ++++++++++++++---------
 4 files changed, 45 insertions(+), 30 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 1cbfbe50bebf..d8330caec5d2 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -76,13 +76,15 @@ static void bit_clear(struct vc_data *vc, struct fb_info *info, int sy,
 
 static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				     const u16 *s, u32 attr, u32 cnt,
-				     u32 d_pitch, u32 s_pitch, u32 cellsize,
+				     u32 d_pitch, u32 s_width, u32 s_vpitch,
 				     struct fb_image *image,
 				     unsigned char *buf, u8 *dst)
 {
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int charcnt = vc->vc_font.charcount;
 	u32 idx = vc->vc_font.width >> 3;
+	font_data_t *fd = (font_data_t *)vc->vc_font.data; /* upcast to font_data_t */
+	u32 s_pitch = font_glyph_pitch(s_width);
 	const unsigned char *src;
 
 	while (cnt--) {
@@ -90,7 +92,7 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 
 		if (ch >= charcnt)
 			ch = 0;
-		src = vc->vc_font.data + (unsigned int)ch * cellsize;
+		src = font_data_glyph_buf(fd, s_width, s_vpitch, ch);
 
 		if (attr) {
 			update_attr(buf, src, attr, vc);
@@ -113,7 +115,7 @@ static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 static inline void bit_putcs_unaligned(struct vc_data *vc,
 				       struct fb_info *info, const u16 *s,
 				       u32 attr, u32 cnt, u32 d_pitch,
-				       u32 s_pitch, u32 cellsize,
+				       u32 s_width, u32 s_vpitch,
 				       struct fb_image *image,
 				       unsigned char *buf, u8 *dst)
 {
@@ -122,6 +124,8 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 	u32 shift_low = 0, mod = vc->vc_font.width % 8;
 	u32 shift_high = 8;
 	u32 idx = vc->vc_font.width >> 3;
+	font_data_t *fd = (font_data_t *)vc->vc_font.data; /* upcast to font_data_t */
+	u32 s_pitch = font_glyph_pitch(s_width);
 	const unsigned char *src;
 
 	while (cnt--) {
@@ -129,7 +133,7 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 
 		if (ch >= charcnt)
 			ch = 0;
-		src = vc->vc_font.data + (unsigned int)ch * cellsize;
+		src = font_data_glyph_buf(fd, s_width, s_vpitch, ch);
 
 		if (attr) {
 			update_attr(buf, src, attr, vc);
@@ -156,8 +160,9 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 	struct fbcon_par *par = info->fbcon_par;
 	struct fb_image image;
 	u32 vyres = GETVYRES(par->p, info);
-	u32 width = DIV_ROUND_UP(vc->vc_font.width, 8);
-	u32 cellsize = width * vc->vc_font.height;
+	u32 width = vc->vc_font.width;
+	u32 vpitch = vc->vc_font.height;
+	u32 cellsize = font_glyph_size(width, vpitch);
 	u32 maxcnt = info->pixmap.size/cellsize;
 	u32 scan_align = info->pixmap.scan_align - 1;
 	u32 buf_align = info->pixmap.buf_align - 1;
@@ -212,10 +217,10 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 
 		if (!mod)
 			bit_putcs_aligned(vc, info, s, attribute, cnt, pitch,
-					  width, cellsize, &image, buf, dst);
+					  width, vpitch, &image, buf, dst);
 		else
 			bit_putcs_unaligned(vc, info, s, attribute, cnt,
-					    pitch, width, cellsize, &image,
+					    pitch, width, vpitch, &image,
 					    buf, dst);
 
 		image.dx += cnt * vc->vc_font.width;
@@ -271,6 +276,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	int width = vc->vc_font.width;
 	int vpitch = vc->vc_font.height;
 	int cellsize = font_glyph_size(width, vpitch);
+	font_data_t *fd = (font_data_t *)vc->vc_font.data; /* upcast to font_data_t */
 	int c;
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
@@ -289,7 +295,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	/* Clamp to font size, same as bit_putcs_aligned() */
 	if (c >= vc->vc_font.charcount)
 		c = 0;
-	src = vc->vc_font.data + (c * cellsize);
+	src = font_data_glyph_buf(fd, width, vpitch, c);
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 589291caed32..9da6c0e41e7a 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -97,7 +97,7 @@ static void ccw_clear(struct vc_data *vc, struct fb_info *info, int sy,
 
 static inline void ccw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				    const u16 *s, u32 attr, u32 cnt,
-				    u32 d_pitch, u32 s_pitch, u32 cellsize,
+				    u32 d_pitch, u32 s_width, u32 s_vpitch,
 				    struct fb_image *image,
 				    unsigned char *buf, u8 *dst)
 {
@@ -107,7 +107,8 @@ static inline void ccw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 	const unsigned char *src;
 
 	while (cnt--) {
-		src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
+		src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch,
+					  scr_readw(s--) & charmask);
 
 		if (attr) {
 			ccw_update_attr(buf, src, attr, vc);
@@ -133,8 +134,9 @@ static void ccw_putcs(struct vc_data *vc, struct fb_info *info,
 {
 	struct fb_image image;
 	struct fbcon_par *par = info->fbcon_par;
-	u32 width = font_glyph_pitch(vc->vc_font.height);
-	u32 cellsize = width * vc->vc_font.width;
+	u32 width = vc->vc_font.height;
+	u32 vpitch = vc->vc_font.width;
+	u32 cellsize = font_glyph_size(width, vpitch);
 	u32 maxcnt = info->pixmap.size/cellsize;
 	u32 scan_align = info->pixmap.scan_align - 1;
 	u32 buf_align = info->pixmap.buf_align - 1;
@@ -176,7 +178,7 @@ static void ccw_putcs(struct vc_data *vc, struct fb_info *info,
 		dst = fb_get_buffer_offset(info, &info->pixmap, size);
 		image.data = dst;
 		ccw_putcs_aligned(vc, info, s, attribute, cnt, pitch,
-				 width, cellsize, &image, buf, dst);
+				 width, vpitch, &image, buf, dst);
 		image.dy += image.height;
 		count -= cnt;
 		s -= cnt;
@@ -243,7 +245,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = par->rotated.buf + ((c & charmask) * cellsize);
+	src = font_data_glyph_buf(par->rotated.buf, width, vpitch, c & charmask);
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 87e9dd666953..354f40f77bb4 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -82,7 +82,7 @@ static void cw_clear(struct vc_data *vc, struct fb_info *info, int sy,
 
 static inline void cw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				    const u16 *s, u32 attr, u32 cnt,
-				    u32 d_pitch, u32 s_pitch, u32 cellsize,
+				    u32 d_pitch, u32 s_width, u32 s_vpitch,
 				    struct fb_image *image,
 				    unsigned char *buf, u8 *dst)
 {
@@ -92,7 +92,8 @@ static inline void cw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 	const unsigned char *src;
 
 	while (cnt--) {
-		src = par->rotated.buf + (scr_readw(s++) & charmask) * cellsize;
+		src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch,
+					  scr_readw(s++) & charmask);
 
 		if (attr) {
 			cw_update_attr(buf, src, attr, vc);
@@ -118,8 +119,9 @@ static void cw_putcs(struct vc_data *vc, struct fb_info *info,
 {
 	struct fb_image image;
 	struct fbcon_par *par = info->fbcon_par;
-	u32 width = font_glyph_pitch(vc->vc_font.height);
-	u32 cellsize = width * vc->vc_font.width;
+	u32 width = vc->vc_font.height;
+	u32 vpitch = vc->vc_font.width;
+	u32 cellsize = font_glyph_size(width, vpitch);
 	u32 maxcnt = info->pixmap.size/cellsize;
 	u32 scan_align = info->pixmap.scan_align - 1;
 	u32 buf_align = info->pixmap.buf_align - 1;
@@ -159,7 +161,7 @@ static void cw_putcs(struct vc_data *vc, struct fb_info *info,
 		dst = fb_get_buffer_offset(info, &info->pixmap, size);
 		image.data = dst;
 		cw_putcs_aligned(vc, info, s, attribute, cnt, pitch,
-				 width, cellsize, &image, buf, dst);
+				 width, vpitch, &image, buf, dst);
 		image.dy += image.height;
 		count -= cnt;
 		s += cnt;
@@ -226,7 +228,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = par->rotated.buf + ((c & charmask) * (cellsize));
+	src = font_data_glyph_buf(par->rotated.buf, width, vpitch, c & charmask);
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index a610af1023de..01f45eaa2013 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -83,17 +83,19 @@ static void ud_clear(struct vc_data *vc, struct fb_info *info, int sy,
 
 static inline void ud_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				    const u16 *s, u32 attr, u32 cnt,
-				    u32 d_pitch, u32 s_pitch, u32 cellsize,
+				    u32 d_pitch, u32 s_width, u32 s_vpitch,
 				    struct fb_image *image,
 				    unsigned char *buf, u8 *dst)
 {
 	struct fbcon_par *par = info->fbcon_par;
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	u32 idx = vc->vc_font.width >> 3;
+	u32 s_pitch = font_glyph_pitch(s_width);
 	const unsigned char *src;
 
 	while (cnt--) {
-		src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
+		src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch,
+					  scr_readw(s--) & charmask);
 
 		if (attr) {
 			ud_update_attr(buf, src, attr, vc);
@@ -116,7 +118,7 @@ static inline void ud_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 static inline void ud_putcs_unaligned(struct vc_data *vc,
 				      struct fb_info *info, const u16 *s,
 				      u32 attr, u32 cnt, u32 d_pitch,
-				      u32 s_pitch, u32 cellsize,
+				      u32 s_width, u32 s_vpitch,
 				      struct fb_image *image,
 				      unsigned char *buf, u8 *dst)
 {
@@ -125,10 +127,12 @@ static inline void ud_putcs_unaligned(struct vc_data *vc,
 	u32 shift_low = 0, mod = vc->vc_font.width % 8;
 	u32 shift_high = 8;
 	u32 idx = vc->vc_font.width >> 3;
+	u32 s_pitch = font_glyph_pitch(s_width);
 	const unsigned char *src;
 
 	while (cnt--) {
-		src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
+		src = font_data_glyph_buf(par->rotated.buf, s_width, s_vpitch,
+					  scr_readw(s--) & charmask);
 
 		if (attr) {
 			ud_update_attr(buf, src, attr, vc);
@@ -154,8 +158,9 @@ static void ud_putcs(struct vc_data *vc, struct fb_info *info,
 {
 	struct fb_image image;
 	struct fbcon_par *par = info->fbcon_par;
-	u32 width = font_glyph_pitch(vc->vc_font.width);
-	u32 cellsize = width * vc->vc_font.height;
+	u32 width = vc->vc_font.width;
+	u32 vpitch = vc->vc_font.height;
+	u32 cellsize = font_glyph_size(width, vpitch);
 	u32 maxcnt = info->pixmap.size/cellsize;
 	u32 scan_align = info->pixmap.scan_align - 1;
 	u32 buf_align = info->pixmap.buf_align - 1;
@@ -200,10 +205,10 @@ static void ud_putcs(struct vc_data *vc, struct fb_info *info,
 
 		if (!mod)
 			ud_putcs_aligned(vc, info, s, attribute, cnt, pitch,
-					 width, cellsize, &image, buf, dst);
+					 width, vpitch, &image, buf, dst);
 		else
 			ud_putcs_unaligned(vc, info, s, attribute, cnt, pitch,
-					   width, cellsize, &image,
+					   width, vpitch, &image,
 					   buf, dst);
 
 		image.dx += image.width;
@@ -273,7 +278,7 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = par->rotated.buf + ((c & charmask) * cellsize);
+	src = font_data_glyph_buf(par->rotated.buf, width, vpitch, c & charmask);
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
-- 
2.56.1

