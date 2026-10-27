Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B0B606A320
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JlNGq/+W;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=J9k/lRjW;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=JlNGq/+W;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=J9k/lRjW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A74F10F527;
	Tue, 27 Oct 2026 13:37:10 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C3DE10E435
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:36:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CD82221EF1;
 Tue, 27 Oct 2026 13:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793108213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HoO5jUvremQzsKuy/HaxsY9HIFEdTU36g8DwzY5I3ic=;
 b=JlNGq/+WAIKtJNDeQ7oNq75ujK8VrDrsn2ZBjCYPzFABo1JJaNrKojF7dXLVWAq93bR4we
 FycO3aUakFwK+E3nuPxv3hYWH/iW5gpjOgFGVEe/ZY62PgllxII9zQz2A5uACizQsvPcwz
 /J+kOSc6jjnUCysAi8kKlmoyKaUBwwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793108213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HoO5jUvremQzsKuy/HaxsY9HIFEdTU36g8DwzY5I3ic=;
 b=J9k/lRjWDfcDwiIvYEIapMtFWybTcCqJalYl8HClaDGusgtv/IgHe6Trxc/H97Gy6FQo2o
 K7dJgB9jbg0e0QDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793108213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HoO5jUvremQzsKuy/HaxsY9HIFEdTU36g8DwzY5I3ic=;
 b=JlNGq/+WAIKtJNDeQ7oNq75ujK8VrDrsn2ZBjCYPzFABo1JJaNrKojF7dXLVWAq93bR4we
 FycO3aUakFwK+E3nuPxv3hYWH/iW5gpjOgFGVEe/ZY62PgllxII9zQz2A5uACizQsvPcwz
 /J+kOSc6jjnUCysAi8kKlmoyKaUBwwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793108213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HoO5jUvremQzsKuy/HaxsY9HIFEdTU36g8DwzY5I3ic=;
 b=J9k/lRjWDfcDwiIvYEIapMtFWybTcCqJalYl8HClaDGusgtv/IgHe6Trxc/H97Gy6FQo2o
 K7dJgB9jbg0e0QDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E2C513419;
 Tue, 27 Oct 2026 13:36:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wbs7OfSo4GoWVAAAD6G6ig:T2
 (envelope-from <tzimmermann@suse.de>); Tue, 27 Oct 2026 13:36:53 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/6] fbcon: Use unsigned char for glyph data
Date: Tue, 27 Oct 2026 14:27:16 +0100
Message-ID: <20261027133646.297856-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027133646.297856-1-tzimmermann@suse.de>
References: <20261027133646.297856-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-15.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 REPLY(-4.00)[]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_TO(0.00)[gmx.de,ffwll.ch];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 RCPT_COUNT_FIVE(0.00)[6]; FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -15.80
X-Spam-Level: 
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

Represent glyph data as unsigned char, as done by font_data_t. Convert
all related code. Also declare source buffers with glyph data as const
because internal fonts reside in read-only memory. Avoid writing them.

We still use char for glyph data in struct fb_image. The type is part
of the kernel uAPI and therefore cannot be changed. Fall back to type
casting in this case.

Destination buffers for font drawing are still u8. This is framebuffer
memory provided by graphics hardware.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/bitblit.c   | 25 ++++++++++++++-----------
 drivers/video/fbdev/core/fbcon.h     |  4 ++--
 drivers/video/fbdev/core/fbcon_ccw.c | 22 ++++++++++++----------
 drivers/video/fbdev/core/fbcon_cw.c  | 22 ++++++++++++----------
 drivers/video/fbdev/core/fbcon_ud.c  | 28 +++++++++++++++-------------
 5 files changed, 55 insertions(+), 46 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 4838df192ffe..df3fdaf392a6 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -22,12 +22,13 @@
 /*
  * Accelerated handlers.
  */
-static void update_attr(u8 *dst, const u8 *src, int attribute, struct vc_data *vc)
+static void update_attr(unsigned char *dst, const unsigned char *src, int attribute,
+			struct vc_data *vc)
 {
 	int i, offset = (vc->vc_font.height < 10) ? 1 : 2;
 	int width = DIV_ROUND_UP(vc->vc_font.width, 8);
 	unsigned int cellsize = vc->vc_font.height * width;
-	u8 c;
+	unsigned char c;
 
 	offset = cellsize - (offset * width);
 	for (i = 0; i < cellsize; i++) {
@@ -75,12 +76,13 @@ static void bit_clear(struct vc_data *vc, struct fb_info *info, int sy,
 static inline void bit_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				     const u16 *s, u32 attr, u32 cnt,
 				     u32 d_pitch, u32 s_pitch, u32 cellsize,
-				     struct fb_image *image, u8 *buf, u8 *dst)
+				     struct fb_image *image,
+				     unsigned char *buf, u8 *dst)
 {
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int charcnt = vc->vc_font.charcount;
 	u32 idx = vc->vc_font.width >> 3;
-	const u8 *src;
+	const unsigned char *src;
 
 	while (cnt--) {
 		u16 ch = scr_readw(s++) & charmask;
@@ -111,15 +113,15 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
 				       struct fb_info *info, const u16 *s,
 				       u32 attr, u32 cnt, u32 d_pitch,
 				       u32 s_pitch, u32 cellsize,
-				       struct fb_image *image, u8 *buf,
-				       u8 *dst)
+				       struct fb_image *image,
+				       unsigned char *buf, u8 *dst)
 {
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	unsigned int charcnt = vc->vc_font.charcount;
 	u32 shift_low = 0, mod = vc->vc_font.width % 8;
 	u32 shift_high = 8;
 	u32 idx = vc->vc_font.width >> 3;
-	const u8 *src;
+	const unsigned char *src;
 
 	while (cnt--) {
 		u16 ch = scr_readw(s++) & charmask;
@@ -158,7 +160,8 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 	u32 buf_align = info->pixmap.buf_align - 1;
 	u32 mod = vc->vc_font.width % 8, cnt, pitch, size;
 	u32 attribute = get_attribute(info, scr_readw(s));
-	u8 *dst, *buf = NULL;
+	unsigned char *buf = NULL;
+	u8 *dst;
 
 	image.fg_color = fg;
 	image.bg_color = bg;
@@ -249,7 +252,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1;
-	const u8 *src;
+	const unsigned char *src;
 
 	cursor.set = 0;
 
@@ -267,12 +270,12 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
-		par->cursor_state.image.data = src;
+		par->cursor_state.image.data = (const char *)src;
 		cursor.set |= FB_CUR_SETIMAGE;
 	}
 
 	if (attribute) {
-		u8 *dst;
+		unsigned char *dst;
 
 		dst = kmalloc_array(w, vc->vc_font.height, GFP_ATOMIC);
 		if (!dst)
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 054cf66b15fa..ab78dad15925 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -86,11 +86,11 @@ struct fbcon_par {
 	int    graphics;
 	bool   initialized;
 	int    rotate;
-	char  *cursor_data;
+	unsigned char *cursor_data;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
 	struct {
 		font_data_t *fontdata;  /* source font */
-		u8 *buf;                /* rotated glyphs */
+		unsigned char *buf;     /* rotated glyphs */
 		size_t bufsize;
 		int buf_rotate;         /* rotation of buf */
 	} rotated;
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index 9a9839631cc5..de4a58d3385e 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -23,13 +23,13 @@
  * Rotation 270 degrees
  */
 
-static void ccw_update_attr(u8 *dst, u8 *src, int attribute,
-				  struct vc_data *vc)
+static void ccw_update_attr(unsigned char *dst, const unsigned char *src, int attribute,
+			    struct vc_data *vc)
 {
 	int i, j, offset = (vc->vc_font.height < 10) ? 1 : 2;
 	int width = font_glyph_pitch(vc->vc_font.height);
 	int mod = vc->vc_font.height % 8;
-	u8 c, msk = ~(0xff << offset), msk1 = 0;
+	unsigned char c, msk = ~(0xff << offset), msk1 = 0;
 
 	if (mod)
 		msk <<= (8 - mod);
@@ -98,12 +98,13 @@ static void ccw_clear(struct vc_data *vc, struct fb_info *info, int sy,
 static inline void ccw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				    const u16 *s, u32 attr, u32 cnt,
 				    u32 d_pitch, u32 s_pitch, u32 cellsize,
-				    struct fb_image *image, u8 *buf, u8 *dst)
+				    struct fb_image *image,
+				    unsigned char *buf, u8 *dst)
 {
 	struct fbcon_par *par = info->fbcon_par;
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	u32 idx = font_glyph_pitch(vc->vc_font.height);
-	u8 *src;
+	const unsigned char *src;
 
 	while (cnt--) {
 		src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
@@ -139,8 +140,9 @@ static void ccw_putcs(struct vc_data *vc, struct fb_info *info,
 	u32 buf_align = info->pixmap.buf_align - 1;
 	u32 cnt, pitch, size;
 	u32 attribute = get_attribute(info, scr_readw(s));
-	u8 *dst, *buf = NULL;
+	unsigned char *buf = NULL;
 	u32 vyres = GETVYRES(par->p, info);
+	u8 *dst;
 
 	if (!par->rotated.buf)
 		return;
@@ -229,7 +231,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1, dx, dy;
-	char *src;
+	const unsigned char *src;
 	u32 vyres = GETVYRES(par->p, info);
 
 	if (!par->rotated.buf)
@@ -241,14 +243,14 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	attribute = get_attribute(info, c);
 	src = par->rotated.buf + ((c & charmask) * (w * vc->vc_font.width));
 
-	if (par->cursor_state.image.data != src ||
+	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
-		par->cursor_state.image.data = src;
+		par->cursor_state.image.data = (const char *)src;
 		cursor.set |= FB_CUR_SETIMAGE;
 	}
 
 	if (attribute) {
-		u8 *dst;
+		unsigned char *dst;
 
 		dst = kmalloc_array(w, vc->vc_font.width, GFP_ATOMIC);
 		if (!dst)
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 4cb20337cf79..4e82199082f1 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -23,12 +23,12 @@
  * Rotation 90 degrees
  */
 
-static void cw_update_attr(u8 *dst, u8 *src, int attribute,
-				  struct vc_data *vc)
+static void cw_update_attr(unsigned char *dst, const unsigned char *src, int attribute,
+			   struct vc_data *vc)
 {
 	int i, j, offset = (vc->vc_font.height < 10) ? 1 : 2;
 	int width = font_glyph_pitch(vc->vc_font.height);
-	u8 c, msk = ~(0xff >> offset);
+	unsigned char c, msk = ~(0xff >> offset);
 
 	for (i = 0; i < vc->vc_font.width; i++) {
 		for (j = 0; j < width; j++) {
@@ -83,12 +83,13 @@ static void cw_clear(struct vc_data *vc, struct fb_info *info, int sy,
 static inline void cw_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				    const u16 *s, u32 attr, u32 cnt,
 				    u32 d_pitch, u32 s_pitch, u32 cellsize,
-				    struct fb_image *image, u8 *buf, u8 *dst)
+				    struct fb_image *image,
+				    unsigned char *buf, u8 *dst)
 {
 	struct fbcon_par *par = info->fbcon_par;
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	u32 idx = font_glyph_pitch(vc->vc_font.height);
-	u8 *src;
+	const unsigned char *src;
 
 	while (cnt--) {
 		src = par->rotated.buf + (scr_readw(s++) & charmask) * cellsize;
@@ -124,8 +125,9 @@ static void cw_putcs(struct vc_data *vc, struct fb_info *info,
 	u32 buf_align = info->pixmap.buf_align - 1;
 	u32 cnt, pitch, size;
 	u32 attribute = get_attribute(info, scr_readw(s));
-	u8 *dst, *buf = NULL;
+	unsigned char *buf = NULL;
 	u32 vxres = GETVXRES(par->p, info);
+	u8 *dst;
 
 	if (!par->rotated.buf)
 		return;
@@ -212,7 +214,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1, dx, dy;
-	char *src;
+	const unsigned char *src;
 	u32 vxres = GETVXRES(par->p, info);
 
 	if (!par->rotated.buf)
@@ -224,14 +226,14 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	attribute = get_attribute(info, c);
 	src = par->rotated.buf + ((c & charmask) * (w * vc->vc_font.width));
 
-	if (par->cursor_state.image.data != src ||
+	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
-		par->cursor_state.image.data = src;
+		par->cursor_state.image.data = (const char *)src;
 		cursor.set |= FB_CUR_SETIMAGE;
 	}
 
 	if (attribute) {
-		u8 *dst;
+		unsigned char *dst;
 
 		dst = kmalloc_array(w, vc->vc_font.width, GFP_ATOMIC);
 		if (!dst)
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index ac22b9846b79..dc48e19513a1 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -22,13 +22,13 @@
  * Rotation 180 degrees
  */
 
-static void ud_update_attr(u8 *dst, u8 *src, int attribute,
-				  struct vc_data *vc)
+static void ud_update_attr(unsigned char *dst, const unsigned char *src, int attribute,
+			   struct vc_data *vc)
 {
 	int i, offset = (vc->vc_font.height < 10) ? 1 : 2;
 	int width = font_glyph_pitch(vc->vc_font.width);
 	unsigned int cellsize = vc->vc_font.height * width;
-	u8 c;
+	unsigned char c;
 
 	offset = offset * width;
 
@@ -84,12 +84,13 @@ static void ud_clear(struct vc_data *vc, struct fb_info *info, int sy,
 static inline void ud_putcs_aligned(struct vc_data *vc, struct fb_info *info,
 				    const u16 *s, u32 attr, u32 cnt,
 				    u32 d_pitch, u32 s_pitch, u32 cellsize,
-				    struct fb_image *image, u8 *buf, u8 *dst)
+				    struct fb_image *image,
+				    unsigned char *buf, u8 *dst)
 {
 	struct fbcon_par *par = info->fbcon_par;
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	u32 idx = vc->vc_font.width >> 3;
-	u8 *src;
+	const unsigned char *src;
 
 	while (cnt--) {
 		src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
@@ -116,15 +117,15 @@ static inline void ud_putcs_unaligned(struct vc_data *vc,
 				      struct fb_info *info, const u16 *s,
 				      u32 attr, u32 cnt, u32 d_pitch,
 				      u32 s_pitch, u32 cellsize,
-				      struct fb_image *image, u8 *buf,
-				      u8 *dst)
+				      struct fb_image *image,
+				      unsigned char *buf, u8 *dst)
 {
 	struct fbcon_par *par = info->fbcon_par;
 	u16 charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
 	u32 shift_low = 0, mod = vc->vc_font.width % 8;
 	u32 shift_high = 8;
 	u32 idx = vc->vc_font.width >> 3;
-	u8 *src;
+	const unsigned char *src;
 
 	while (cnt--) {
 		src = par->rotated.buf + (scr_readw(s--) & charmask) * cellsize;
@@ -160,9 +161,10 @@ static void ud_putcs(struct vc_data *vc, struct fb_info *info,
 	u32 buf_align = info->pixmap.buf_align - 1;
 	u32 mod = vc->vc_font.width % 8, cnt, pitch, size;
 	u32 attribute = get_attribute(info, scr_readw(s));
-	u8 *dst, *buf = NULL;
+	unsigned char *buf = NULL;
 	u32 vyres = GETVYRES(par->p, info);
 	u32 vxres = GETVXRES(par->p, info);
+	u8 *dst;
 
 	if (!par->rotated.buf)
 		return;
@@ -258,7 +260,7 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1, dx, dy;
-	char *src;
+	const unsigned char *src;
 	u32 vyres = GETVYRES(par->p, info);
 	u32 vxres = GETVXRES(par->p, info);
 
@@ -271,14 +273,14 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	attribute = get_attribute(info, c);
 	src = par->rotated.buf + ((c & charmask) * (w * vc->vc_font.height));
 
-	if (par->cursor_state.image.data != src ||
+	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
-		par->cursor_state.image.data = src;
+		par->cursor_state.image.data = (const char *)src;
 		cursor.set |= FB_CUR_SETIMAGE;
 	}
 
 	if (attribute) {
-		u8 *dst;
+		unsigned char *dst;
 
 		dst = kmalloc_array(w, vc->vc_font.height, GFP_ATOMIC);
 		if (!dst)
-- 
2.56.0

