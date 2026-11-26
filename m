Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8BD606A330
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NJuAlJ0J;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=saPQeAIZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NJuAlJ0J;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=saPQeAIZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951ED1125C5;
	Thu, 26 Nov 2026 16:32:20 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78818112595
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:31:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 240CE21F9B;
 Thu, 26 Nov 2026 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795710714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOJ/fNe9TGkQu8O/yDVaqAATqQ7AjargAEnACec+OTE=;
 b=NJuAlJ0J2BD6NIVyduIGZVnFuFkKC2SDznar8bKGnUOusKpAWIF3PLc+xZwv2Q9BHgXU3M
 tqf6GBPXWz97VE59Q2XfkVNDJUe7Uyo5EVorDQ1ZbcSeZY3fUyr16LU8Xf5QG4JHPxL2J3
 4U3YeftEHBirpwViPbT824vBpMbMlN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795710714;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOJ/fNe9TGkQu8O/yDVaqAATqQ7AjargAEnACec+OTE=;
 b=saPQeAIZg9P2W/QLc21Eo4ld1FqiKoKs4LydEn2zqBoxjZTO2KF4+T6dD2gfbirwiMR/os
 gBkQEgxsPznpFxBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795710714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOJ/fNe9TGkQu8O/yDVaqAATqQ7AjargAEnACec+OTE=;
 b=NJuAlJ0J2BD6NIVyduIGZVnFuFkKC2SDznar8bKGnUOusKpAWIF3PLc+xZwv2Q9BHgXU3M
 tqf6GBPXWz97VE59Q2XfkVNDJUe7Uyo5EVorDQ1ZbcSeZY3fUyr16LU8Xf5QG4JHPxL2J3
 4U3YeftEHBirpwViPbT824vBpMbMlN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795710714;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOJ/fNe9TGkQu8O/yDVaqAATqQ7AjargAEnACec+OTE=;
 b=saPQeAIZg9P2W/QLc21Eo4ld1FqiKoKs4LydEn2zqBoxjZTO2KF4+T6dD2gfbirwiMR/os
 gBkQEgxsPznpFxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4883134E8;
 Thu, 26 Nov 2026 16:31:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vrCcCfleCGvnJgAAD6G6ig:T3
 (envelope-from <tzimmermann@suse.de>); Thu, 26 Nov 2026 16:31:53 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/2] fbcon: Provide a single implementation of
 fbcon_set_rotation()
Date: Thu, 26 Nov 2026 17:23:11 +0100
Message-ID: <20261126163150.91355-3-tzimmermann@suse.de>
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

Merge both implmentations of fbcon_set_rotation() into one. In the
case of CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=n, fbcon_display_rotation()
returns FB_ROTATE_UR. So the new code is equivalent to the existing
code.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbcon.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 7e39c40abe88..08712611e333 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -206,13 +206,6 @@ static int fbcon_display_rotation(const struct fb_info *info, const struct fbcon
 	return FB_ROTATE_UR;
 }
 
-static inline void fbcon_set_rotation(struct fb_info *info)
-{
-	struct fbcon_par *par = info->fbcon_par;
-
-	par->rotate = fbcon_display_rotation(info, par->p);
-}
-
 static void fbcon_rotate(struct fb_info *info, u32 rotate)
 {
 	struct fbcon_par *par = info->fbcon_par;
@@ -263,13 +256,6 @@ static int fbcon_display_rotation(const struct fb_info *info, const struct fbcon
 	return FB_ROTATE_UR;
 }
 
-static inline void fbcon_set_rotation(struct fb_info *info)
-{
-	struct fbcon_par *par = info->fbcon_par;
-
-	par->rotate = FB_ROTATE_UR;
-}
-
 static void fbcon_rotate(struct fb_info *info, u32 rotate)
 {
 	return;
@@ -281,6 +267,13 @@ static void fbcon_rotate_all(struct fb_info *info, u32 rotate)
 }
 #endif /* CONFIG_FRAMEBUFFER_CONSOLE_ROTATION */
 
+static void fbcon_set_rotation(struct fb_info *info)
+{
+	struct fbcon_par *par = info->fbcon_par;
+
+	par->rotate = fbcon_display_rotation(info, par->p);
+}
+
 static void fbcon_set_bitops(struct fbcon_par *par)
 {
 	switch (par->rotate) {
-- 
2.56.1

