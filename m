Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C3606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:52:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D5B112982;
	Fri, 20 Nov 2026 11:52:31 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01436112937
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:52:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3E5D22579;
 Fri, 20 Nov 2026 11:52:27 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C27C134F6;
 Fri, 20 Nov 2026 11:52:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UE2UA3o0AGsbDAAAD6G6ig:T5
 (envelope-from <tzimmermann@suse.de>); Fri, 20 Nov 2026 11:52:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 4/6] fbcon: Refactor size calculation for cursor buffers
Date: Fri, 20 Nov 2026 12:49:57 +0100
Message-ID: <20261120115215.52092-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120115215.52092-1-tzimmermann@suse.de>
References: <20261120115215.52092-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: A3E5D22579
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

Replace open-coded size calculation for cursor glyph buffers with
font helpers. Use it for glyph lookup and buffer allocation.

Treat glyph width as bits per scanline instead of bytes. This is
consistent with font helpers.

Note that with screen rotation enabled, width and height swap places
for CW and CCW implementations.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/bitblit.c   |  9 ++++++---
 drivers/video/fbdev/core/fbcon_ccw.c | 10 ++++++----
 drivers/video/fbdev/core/fbcon_cw.c  | 10 ++++++----
 drivers/video/fbdev/core/fbcon_ud.c  | 10 ++++++----
 4 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 5cdd70f32c28..1cbfbe50bebf 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -268,7 +268,10 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	struct fb_cursor cursor;
 	struct fbcon_par *par = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	int w = DIV_ROUND_UP(vc->vc_font.width, 8), c;
+	int width = vc->vc_font.width;
+	int vpitch = vc->vc_font.height;
+	int cellsize = font_glyph_size(width, vpitch);
+	int c;
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
 	int err = 1;
@@ -286,7 +289,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	/* Clamp to font size, same as bit_putcs_aligned() */
 	if (c >= vc->vc_font.charcount)
 		c = 0;
-	src = vc->vc_font.data + (c * (w * vc->vc_font.height));
+	src = vc->vc_font.data + (c * cellsize);
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
@@ -297,7 +300,7 @@ static void bit_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	if (attribute) {
 		unsigned char *dst;
 
-		dst = kmalloc_array(w, vc->vc_font.height, GFP_ATOMIC);
+		dst = kmalloc(cellsize, GFP_ATOMIC);
 		if (!dst)
 			return;
 		kfree(par->cursor_data);
diff --git a/drivers/video/fbdev/core/fbcon_ccw.c b/drivers/video/fbdev/core/fbcon_ccw.c
index de4a58d3385e..589291caed32 100644
--- a/drivers/video/fbdev/core/fbcon_ccw.c
+++ b/drivers/video/fbdev/core/fbcon_ccw.c
@@ -226,7 +226,9 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	struct fb_cursor cursor;
 	struct fbcon_par *par = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	int w = font_glyph_pitch(vc->vc_font.height);
+	int width = vc->vc_font.height;
+	int vpitch = vc->vc_font.width;
+	int cellsize = font_glyph_size(width, vpitch);
 	int c;
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
@@ -241,7 +243,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = par->rotated.buf + ((c & charmask) * (w * vc->vc_font.width));
+	src = par->rotated.buf + ((c & charmask) * cellsize);
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
@@ -252,7 +254,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	if (attribute) {
 		unsigned char *dst;
 
-		dst = kmalloc_array(w, vc->vc_font.width, GFP_ATOMIC);
+		dst = kmalloc(cellsize, GFP_ATOMIC);
 		if (!dst)
 			return;
 		kfree(par->cursor_data);
@@ -304,7 +306,7 @@ static void ccw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		if (!tmp)
 			return;
 
-		mask = kmalloc_array(vc->vc_font.width, w, GFP_ATOMIC);
+		mask = kmalloc(cellsize, GFP_ATOMIC);
 		if (!mask) {
 			kfree(tmp);
 			return;
diff --git a/drivers/video/fbdev/core/fbcon_cw.c b/drivers/video/fbdev/core/fbcon_cw.c
index 4e82199082f1..87e9dd666953 100644
--- a/drivers/video/fbdev/core/fbcon_cw.c
+++ b/drivers/video/fbdev/core/fbcon_cw.c
@@ -209,7 +209,9 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	struct fb_cursor cursor;
 	struct fbcon_par *par = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	int w = font_glyph_pitch(vc->vc_font.height);
+	int width = vc->vc_font.height;
+	int vpitch = vc->vc_font.width;
+	int cellsize = font_glyph_size(width, vpitch);
 	int c;
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
@@ -224,7 +226,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = par->rotated.buf + ((c & charmask) * (w * vc->vc_font.width));
+	src = par->rotated.buf + ((c & charmask) * (cellsize));
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
@@ -235,7 +237,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	if (attribute) {
 		unsigned char *dst;
 
-		dst = kmalloc_array(w, vc->vc_font.width, GFP_ATOMIC);
+		dst = kmalloc(cellsize, GFP_ATOMIC);
 		if (!dst)
 			return;
 		kfree(par->cursor_data);
@@ -287,7 +289,7 @@ static void cw_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		if (!tmp)
 			return;
 
-		mask = kmalloc_array(vc->vc_font.width, w, GFP_ATOMIC);
+		mask = kmalloc(cellsize, GFP_ATOMIC);
 		if (!mask) {
 			kfree(tmp);
 			return;
diff --git a/drivers/video/fbdev/core/fbcon_ud.c b/drivers/video/fbdev/core/fbcon_ud.c
index dc48e19513a1..a610af1023de 100644
--- a/drivers/video/fbdev/core/fbcon_ud.c
+++ b/drivers/video/fbdev/core/fbcon_ud.c
@@ -255,7 +255,9 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	struct fb_cursor cursor;
 	struct fbcon_par *par = info->fbcon_par;
 	unsigned short charmask = vc->vc_hi_font_mask ? 0x1ff : 0xff;
-	int w = font_glyph_pitch(vc->vc_font.width);
+	int width = vc->vc_font.width;
+	int vpitch = vc->vc_font.height;
+	int cellsize = font_glyph_size(width, vpitch);
 	int c;
 	int y = real_y(par->p, vc->state.y);
 	int attribute, use_sw = vc->vc_cursor_type & CUR_SW;
@@ -271,7 +273,7 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 
  	c = scr_readw((u16 *) vc->vc_pos);
 	attribute = get_attribute(info, c);
-	src = par->rotated.buf + ((c & charmask) * (w * vc->vc_font.height));
+	src = par->rotated.buf + ((c & charmask) * cellsize);
 
 	if (par->cursor_state.image.data != (const char *)src ||
 	    par->cursor_reset) {
@@ -282,7 +284,7 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 	if (attribute) {
 		unsigned char *dst;
 
-		dst = kmalloc_array(w, vc->vc_font.height, GFP_ATOMIC);
+		dst = kmalloc(cellsize, GFP_ATOMIC);
 		if (!dst)
 			return;
 		kfree(par->cursor_data);
@@ -334,7 +336,7 @@ static void ud_cursor(struct vc_data *vc, struct fb_info *info, bool enable,
 		if (!tmp)
 			return;
 
-		mask = kmalloc_array(vc->vc_font.height, w, GFP_ATOMIC);
+		mask = kmalloc(cellsize, GFP_ATOMIC);
 		if (!mask) {
 			kfree(tmp);
 			return;
-- 
2.56.0

