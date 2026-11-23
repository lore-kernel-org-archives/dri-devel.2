Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E78606A334
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1F8710EE35;
	Mon, 23 Nov 2026 14:06:01 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDECB10EE28
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:06:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A423B1F822;
 Mon, 23 Nov 2026 14:05:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C0E513532;
 Mon, 23 Nov 2026 14:05:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oQeBOkZIBGvqQwAAD6G6ig:T2
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Nov 2026 14:05:59 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 1/6] fbcon: Use unsigned char for glyph data
Date: Mon, 23 Nov 2026 15:03:34 +0100
Message-ID: <20261123140554.1129792-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123140554.1129792-1-tzimmermann@suse.de>
References: <20261123140554.1129792-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: A423B1F822
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
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
index 590d12bbf30d..5cdd70f32c28 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -23,12 +23,13 @@
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
@@ -76,12 +77,13 @@ static void bit_clear(struct vc_data *vc, struct fb_info *info, int sy,
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
@@ -112,15 +114,15 @@ static inline void bit_putcs_unaligned(struct vc_data *vc,
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
@@ -161,7 +163,8 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 	u32 buf_align = info->pixmap.buf_align - 1;
 	u32 mod = vc->vc_font.width % 8, cnt, pitch, size;
 	u32 attribute = get_attribute(info, scr_readw(s));
-	u8 *dst, *buf = NULL;
+	unsigned char *buf = NULL;
+	u8 *dst;
 
 	image.fg_color = fg;
 	image.bg_color = bg;
@@ -269,7 +272,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1;
-	const u8 *src;
+	const unsigned char *src;
 
 	cursor.set = 0;
 
@@ -287,12 +290,12 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 
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
index d93a89877d04..289a3d18f917 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -75,7 +75,7 @@ struct fbcon_bitops {
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
 struct fbcon_rotated {
 	font_data_t *fontdata;       /* source font */
-	u8 *buf;                     /* rotated glyphs */
+	unsigned char *buf;          /* rotated glyphs */
 	size_t bufsize;
 	int buf_rotate;              /* rotation of buf */
 	unsigned int buf_width;      /* geometry of source font */
@@ -98,7 +98,7 @@ struct fbcon_par {
 	int    graphics;
 	bool   initialized;
 	int    rotate;
-	char  *cursor_data;
+	unsigned char *cursor_data;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
 	struct fbcon_rotated rotated;
 #endif
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
2.56.1

