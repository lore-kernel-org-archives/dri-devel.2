Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F46CD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 14:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC12910FFAB;
	Fri, 29 May 2026 14:08:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="fV2jXCxN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4oJVQEjm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fV2jXCxN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4oJVQEjm";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCDF10FFA6
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:08:14 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B41166AE32;
 Fri, 29 May 2026 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780063684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7r2nHkgW6iQqRWvcbWJRBuD+nIdEQeUrSi3LmbcMaO0=;
 b=fV2jXCxNOv1anc5R6STlJt/kHosZ6HC1OSUlOWSxkvwT9fdvAnwHUOJb3+pR/Fqw3C8Dd2
 3TBTI77ng9Zoc1QtVtBnhJJcFH9z5zmjLIs7/a3J27CW27aRzIulk94a/DKwZnM3xQRkEc
 r6dGiY4sCTq1z8rCxI/fiSw1wHU2P7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780063684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7r2nHkgW6iQqRWvcbWJRBuD+nIdEQeUrSi3LmbcMaO0=;
 b=4oJVQEjmKEbfZbtxw1OmBrS+T11tXmVtH72T1n6oejsDUZdVIV37M2RGmPCgYieKaMCOaK
 dVixgXqbEhVzLxCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fV2jXCxN;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4oJVQEjm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780063684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7r2nHkgW6iQqRWvcbWJRBuD+nIdEQeUrSi3LmbcMaO0=;
 b=fV2jXCxNOv1anc5R6STlJt/kHosZ6HC1OSUlOWSxkvwT9fdvAnwHUOJb3+pR/Fqw3C8Dd2
 3TBTI77ng9Zoc1QtVtBnhJJcFH9z5zmjLIs7/a3J27CW27aRzIulk94a/DKwZnM3xQRkEc
 r6dGiY4sCTq1z8rCxI/fiSw1wHU2P7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780063684;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7r2nHkgW6iQqRWvcbWJRBuD+nIdEQeUrSi3LmbcMaO0=;
 b=4oJVQEjmKEbfZbtxw1OmBrS+T11tXmVtH72T1n6oejsDUZdVIV37M2RGmPCgYieKaMCOaK
 dVixgXqbEhVzLxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72C72779A8;
 Fri, 29 May 2026 14:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AMVSGsSdGWoybAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 29 May 2026 14:08:04 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, javierm@redhat.com, deller@gmx.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/4] drm/panic: Look up glyph shape with font helper
Date: Fri, 29 May 2026 16:01:25 +0200
Message-ID: <20260529140759.529929-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529140759.529929-1-tzimmermann@suse.de>
References: <20260529140759.529929-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B41166AE32
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
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
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
 drivers/gpu/drm/drm_panic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index d6d3b8d85dea..e576c4791861 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -443,9 +443,11 @@ static void draw_txt_rectangle(struct drm_scanout_buffer *sb,
 			rec.x1 += (drm_rect_width(clip) - (line_len * font->width)) / 2;
 
 		for (j = 0; j < line_len; j++) {
-			src = drm_draw_get_char_bitmap(font, msg[i].txt[j], font_pitch);
+			src = font_data_glyph_buf(font->data, font->width, font->height,
+						  (unsigned char)msg[i].txt[j]);
 			rec.x2 = rec.x1 + font->width;
-			drm_panic_blit(sb, &rec, src, font_pitch, 1, color);
+			if (src)
+				drm_panic_blit(sb, &rec, src, font_pitch, 1, color);
 			rec.x1 += font->width;
 		}
 	}
-- 
2.54.0

