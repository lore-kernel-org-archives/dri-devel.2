Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA78CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 14:08:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70F1D10FFA6;
	Fri, 29 May 2026 14:08:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="cz/ILdQ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g+3mLFG1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cz/ILdQ0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g+3mLFG1";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB88410FFA6
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:08:09 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6ABA36AD77;
 Fri, 29 May 2026 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780063684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XqeIkKhg3iLXG98oLAZmvKZstFgR2UqUAG/0vaT0+Ak=;
 b=cz/ILdQ0U8xlwX9GYdI9opakwbCAo2cfDPEli1rStTM3O06mbRyyamTj+vvmDKlyP69cfz
 X0zbn5Gbb52pVq2AW9uW0gpMXpxkMO2yn7OcrZkjAIcRbjxHglrJNWk8zKVNr1JcwoA5lB
 Z8vwF7zQJ3DP+/0Yusyz8CxasovRGCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780063684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XqeIkKhg3iLXG98oLAZmvKZstFgR2UqUAG/0vaT0+Ak=;
 b=g+3mLFG1LOmQGpIVsoG4+QKma0zB6tDnyos+2VMQ4Gm1pVIWywqxMzZzXpko2d40oubdOQ
 L8S3ro6APRsEGoDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="cz/ILdQ0";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=g+3mLFG1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780063684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XqeIkKhg3iLXG98oLAZmvKZstFgR2UqUAG/0vaT0+Ak=;
 b=cz/ILdQ0U8xlwX9GYdI9opakwbCAo2cfDPEli1rStTM3O06mbRyyamTj+vvmDKlyP69cfz
 X0zbn5Gbb52pVq2AW9uW0gpMXpxkMO2yn7OcrZkjAIcRbjxHglrJNWk8zKVNr1JcwoA5lB
 Z8vwF7zQJ3DP+/0Yusyz8CxasovRGCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780063684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XqeIkKhg3iLXG98oLAZmvKZstFgR2UqUAG/0vaT0+Ak=;
 b=g+3mLFG1LOmQGpIVsoG4+QKma0zB6tDnyos+2VMQ4Gm1pVIWywqxMzZzXpko2d40oubdOQ
 L8S3ro6APRsEGoDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26D8B779A7;
 Fri, 29 May 2026 14:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cMYbCMSdGWoybAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 29 May 2026 14:08:04 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, javierm@redhat.com, deller@gmx.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/4] drm/client: log: Look up glyph shape with font helper
Date: Fri, 29 May 2026 16:01:24 +0200
Message-ID: <20260529140759.529929-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529140759.529929-1-tzimmermann@suse.de>
References: <20260529140759.529929-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6ABA36AD77
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,gmx.de,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,suse.de:mid];
 RCPT_COUNT_SEVEN(0.00)[10];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Look up glyph shapes with font_data_glyph_buf(). Handle non-existing
glyphs gracefully. Enable extended ASCII by casting to unsigned char.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/clients/drm_log.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
index 8d21b785bead..e3e02c84a4cf 100644
--- a/drivers/gpu/drm/clients/drm_log.c
+++ b/drivers/gpu/drm/clients/drm_log.c
@@ -122,10 +122,12 @@ static void drm_log_draw_line(struct drm_log_scanout *scanout, const char *s,
 	iosys_map_incr(&map, r.y1 * fb->pitches[0]);
 	for (i = 0; i < len && i < scanout->columns; i++) {
 		u32 color = (i < prefix_len) ? scanout->prefix_color : scanout->front_color;
-		src = drm_draw_get_char_bitmap(font, s[i], font_pitch);
-		drm_log_blit(&map, fb->pitches[0], src, font_pitch,
-			     scanout->scaled_font_h, scanout->scaled_font_w,
-			     px_width, color);
+		src = font_data_glyph_buf(font->data, font->width, font->height,
+					  (unsigned char)s[i]);
+		if (src)
+			drm_log_blit(&map, fb->pitches[0], src, font_pitch,
+				     scanout->scaled_font_h, scanout->scaled_font_w,
+				     px_width, color);
 		iosys_map_incr(&map, scanout->scaled_font_w * px_width);
 	}
 
-- 
2.54.0

