Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAEC606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IM5aE/PY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0j9sS75Y;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IM5aE/PY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=0j9sS75Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E240510EE52;
	Mon, 23 Nov 2026 14:06:12 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABDCC10EE2E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:06:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 54A2A220B1;
 Mon, 23 Nov 2026 14:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795442760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96eYVx1R1idjewa0QOQy/qzWTBFar/8EbpF5K9szVXM=;
 b=IM5aE/PY5H/3t1FS6WFcDTSHGoBWS87DOa938lKDdhosbOkGAhCqpRzwWUStPe8zWuzJon
 9Q4FzAgZfJRbFeAnN223FDhA2YwJar78RY2POxyZa0ZSEZi6wrZWJ3n+/zqeHWS13UGQ3N
 IEt+Z1yhQbtQ9qlZyHM3Y2JQsuCF1XQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795442760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96eYVx1R1idjewa0QOQy/qzWTBFar/8EbpF5K9szVXM=;
 b=0j9sS75Y7B6cbwOHesBbbh1kc7F8hfUHAaDXyI/Font+I9VMpcOmwzur9mMmRMg+aewb2X
 3wo/nhDVSIUsGJCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795442760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96eYVx1R1idjewa0QOQy/qzWTBFar/8EbpF5K9szVXM=;
 b=IM5aE/PY5H/3t1FS6WFcDTSHGoBWS87DOa938lKDdhosbOkGAhCqpRzwWUStPe8zWuzJon
 9Q4FzAgZfJRbFeAnN223FDhA2YwJar78RY2POxyZa0ZSEZi6wrZWJ3n+/zqeHWS13UGQ3N
 IEt+Z1yhQbtQ9qlZyHM3Y2JQsuCF1XQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795442760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96eYVx1R1idjewa0QOQy/qzWTBFar/8EbpF5K9szVXM=;
 b=0j9sS75Y7B6cbwOHesBbbh1kc7F8hfUHAaDXyI/Font+I9VMpcOmwzur9mMmRMg+aewb2X
 3wo/nhDVSIUsGJCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D98013532;
 Mon, 23 Nov 2026 14:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oQeBOkZIBGvqQwAAD6G6ig:T5
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Nov 2026 14:06:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 4/6] fbcon: Refactor size calculation for cursor buffers
Date: Mon, 23 Nov 2026 15:03:37 +0100
Message-ID: <20261123140554.1129792-5-tzimmermann@suse.de>
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
2.56.1

