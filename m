Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24888606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=J9TIRVZC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CZSLtGq+;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=J9TIRVZC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CZSLtGq+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8832D1125A8;
	Thu, 26 Nov 2026 16:32:13 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370DD10E9EA
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:31:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DD1F61FE22;
 Thu, 26 Nov 2026 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795710713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HsdTNBGwPWRG7oE9R6XYhea8asSSVSJstKN967n780Q=;
 b=J9TIRVZCZR5lODJa2yEBPyGXupUb8DvrJQE9NvBYh/UHYZ0rXeQ/suaPqUEOZ9gyjE4963
 DFHrVs3lnOCZ5ZDEnu4GtRG+kubpXCV1eLEW6gkxYOBnGMwG5hQs4sa1GOaOYYRvAAQtF8
 U0U5NSYxU7z/ob2QuU8VOXfQZbM97co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795710713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HsdTNBGwPWRG7oE9R6XYhea8asSSVSJstKN967n780Q=;
 b=CZSLtGq+Jo/e3EPN3CwTnV/IAhyyWf1KlBVh2ZIHY6BxR6dneRyXvu3Vu/l/XnbJIZddEa
 f3zwq9riGGrI8fDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795710713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HsdTNBGwPWRG7oE9R6XYhea8asSSVSJstKN967n780Q=;
 b=J9TIRVZCZR5lODJa2yEBPyGXupUb8DvrJQE9NvBYh/UHYZ0rXeQ/suaPqUEOZ9gyjE4963
 DFHrVs3lnOCZ5ZDEnu4GtRG+kubpXCV1eLEW6gkxYOBnGMwG5hQs4sa1GOaOYYRvAAQtF8
 U0U5NSYxU7z/ob2QuU8VOXfQZbM97co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795710713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HsdTNBGwPWRG7oE9R6XYhea8asSSVSJstKN967n780Q=;
 b=CZSLtGq+Jo/e3EPN3CwTnV/IAhyyWf1KlBVh2ZIHY6BxR6dneRyXvu3Vu/l/XnbJIZddEa
 f3zwq9riGGrI8fDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DC9C134CA;
 Thu, 26 Nov 2026 16:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vrCcCfleCGvnJgAAD6G6ig:T2
 (envelope-from <tzimmermann@suse.de>); Thu, 26 Nov 2026 16:31:53 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/2] fbcon: Don't change shared blitting state for hidden
 consoles
Date: Thu, 26 Nov 2026 17:23:10 +0100
Message-ID: <20261126163150.91355-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126163150.91355-1-tzimmermann@suse.de>
References: <20261126163150.91355-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[gmx.de,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -11.80
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

All consoles on a framebuffer share par->rotate and par->bitops.
fbcon_init() calls set_blitting_type() for each new console, which
resets both to the new console's rotation. If the visible console is
rotated, it then keeps its rotated rows and columns but draws with
unrotated bitops. The next cursor update or scroll writes beyond the
framebuffer and oopses, e.g. at shutdown when plymouthd opens a new
VT:

  BUG: unable to handle page fault for address: ffffd2ce80bd5000
  RIP: 0010:sys_imageblit+0x707/0x7e0
   soft_cursor+0x1a4/0x250
   bit_cursor+0x3ab/0x550
   hide_cursor+0x27/0xb0

Only call set_blitting_type() from fbcon_init() for the visible console
or when the fbcon state was just created. Compute a new console's rows
and columns from its own rotation instead of par->rotate, so that it
doesn't inherit the visible console's geometry.

Tested on QEMU with console 0 rotated by 90 degrees. Other rotations
and rotate_all are untested.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.c | 38 +++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index d7890e119dc7..7e39c40abe88 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -197,15 +197,20 @@ static void fbcon_set_all_vcs(struct fb_info *info);
 static struct device *fbcon_device;
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+/* Returns the rotation that a console uses when it is displayed. */
+static int fbcon_display_rotation(const struct fb_info *info, const struct fbcon_display *p)
+{
+	if (!(info->flags & FBINFO_MISC_TILEBLITTING) && p->con_rotate < 4)
+		return p->con_rotate;
+
+	return FB_ROTATE_UR;
+}
+
 static inline void fbcon_set_rotation(struct fb_info *info)
 {
 	struct fbcon_par *par = info->fbcon_par;
 
-	if (!(info->flags & FBINFO_MISC_TILEBLITTING) &&
-	    par->p->con_rotate < 4)
-		par->rotate = par->p->con_rotate;
-	else
-		par->rotate = 0;
+	par->rotate = fbcon_display_rotation(info, par->p);
 }
 
 static void fbcon_rotate(struct fb_info *info, u32 rotate)
@@ -253,6 +258,11 @@ static void fbcon_rotate_all(struct fb_info *info, u32 rotate)
 	fbcon_set_all_vcs(info);
 }
 #else
+static int fbcon_display_rotation(const struct fb_info *info, const struct fbcon_display *p)
+{
+	return FB_ROTATE_UR;
+}
+
 static inline void fbcon_set_rotation(struct fb_info *info)
 {
 	struct fbcon_par *par = info->fbcon_par;
@@ -1105,6 +1115,8 @@ static void fbcon_init(struct vc_data *vc, bool init)
 	struct vc_data *svc = *default_mode;
 	struct fbcon_display *t, *p = &fb_display[vc->vc_num];
 	int logo = 1, new_rows, new_cols, rows, cols;
+	bool new_par = false;
+	int rotate;
 	int ret;
 
 	if (WARN_ON(info_idx == -1))
@@ -1125,9 +1137,11 @@ static void fbcon_init(struct vc_data *vc, bool init)
 	if (var_to_display(p, &info->var, info))
 		return;
 
-	if (!info->fbcon_par)
+	if (!info->fbcon_par) {
 		if (con2fb_acquire_newinfo(vc, info, vc->vc_num))
 			return;
+		new_par = true;
+	}
 
 	/* If we are not the first console on this
 	   fb, copy the font from that console */
@@ -1185,12 +1199,15 @@ static void fbcon_init(struct vc_data *vc, bool init)
 	if (p->con_rotate == -1)
 		p->con_rotate = FB_ROTATE_UR;
 
-	set_blitting_type(vc, info);
+	if (new_par || con_is_visible(vc))
+		set_blitting_type(vc, info);
 
 	cols = vc->vc_cols;
 	rows = vc->vc_rows;
-	new_cols = FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
-	new_rows = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
+	/* Use the console's own rotation; par->rotate belongs to the visible one. */
+	rotate = fbcon_display_rotation(info, p);
+	new_cols = FBCON_SWAP(rotate, info->var.xres, info->var.yres);
+	new_rows = FBCON_SWAP(rotate, info->var.yres, info->var.xres);
 	new_cols /= vc->vc_font.width;
 	new_rows /= vc->vc_font.height;
 
@@ -1238,7 +1255,8 @@ static void fbcon_init(struct vc_data *vc, bool init)
 	if (logo)
 		fbcon_prepare_logo(vc, info, cols, rows, new_cols, new_rows);
 
-	if (par->bitops->rotate_font && par->bitops->rotate_font(info, vc)) {
+	if ((new_par || con_is_visible(vc)) &&
+	    par->bitops->rotate_font && par->bitops->rotate_font(info, vc)) {
 		par->rotate = FB_ROTATE_UR;
 		set_blitting_type(vc, info);
 	}
-- 
2.56.1

