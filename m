Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255D1CD6E4A
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 14:08:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A62210FFA7;
	Fri, 29 May 2026 14:08:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="WPzuU6eP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JiUvHdSS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WPzuU6eP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JiUvHdSS";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E3010FFA7
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 14:08:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A9B96AD67;
 Fri, 29 May 2026 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780063685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9T/r1s9M1Nvvp1Aw0+maCxF6qx7FwMjqBiQF2aoe2w=;
 b=WPzuU6ePMEKS7IJYTXGaLBL/tntqLWgPjptefT5YSIW6xgLmaqZDyRL5kedf4LJjizlbVv
 QrAQcuosbFVKPj5QAINkAST/4cWrfmh+gVZSvDpdfvW9e1HUfBWb7KrxjGQV/zNtuQO1QQ
 AX2S0kJvu1jnXbYsyr4X86JtL0/mndY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780063685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9T/r1s9M1Nvvp1Aw0+maCxF6qx7FwMjqBiQF2aoe2w=;
 b=JiUvHdSSm+YZFGOjt+XX8JqrcJXeDZyzxrbCxTkcThFutda9r51K6oNOM5v8zr02Ox/kDk
 EaJao1Dt/z/QeeBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780063685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9T/r1s9M1Nvvp1Aw0+maCxF6qx7FwMjqBiQF2aoe2w=;
 b=WPzuU6ePMEKS7IJYTXGaLBL/tntqLWgPjptefT5YSIW6xgLmaqZDyRL5kedf4LJjizlbVv
 QrAQcuosbFVKPj5QAINkAST/4cWrfmh+gVZSvDpdfvW9e1HUfBWb7KrxjGQV/zNtuQO1QQ
 AX2S0kJvu1jnXbYsyr4X86JtL0/mndY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780063685;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9T/r1s9M1Nvvp1Aw0+maCxF6qx7FwMjqBiQF2aoe2w=;
 b=JiUvHdSSm+YZFGOjt+XX8JqrcJXeDZyzxrbCxTkcThFutda9r51K6oNOM5v8zr02Ox/kDk
 EaJao1Dt/z/QeeBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB6E6779A7;
 Fri, 29 May 2026 14:08:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kIGULMSdGWoybAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 29 May 2026 14:08:04 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, javierm@redhat.com, deller@gmx.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/4] drm/draw: Remove unused helper drm_draw_get_char_bitmap()
Date: Fri, 29 May 2026 16:01:26 +0200
Message-ID: <20260529140759.529929-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529140759.529929-1-tzimmermann@suse.de>
References: <20260529140759.529929-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.974];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[redhat.com,gmx.de,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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

Glyph-shape lookup has been integrated into the font-data interface
and all callers have been updated. Remove the old helper.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_draw_internal.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_draw_internal.h b/drivers/gpu/drm/drm_draw_internal.h
index 261967145635..44ddcee4744c 100644
--- a/drivers/gpu/drm/drm_draw_internal.h
+++ b/drivers/gpu/drm/drm_draw_internal.h
@@ -7,7 +7,6 @@
 #ifndef __DRM_DRAW_INTERNAL_H__
 #define __DRM_DRAW_INTERNAL_H__
 
-#include <linux/font.h>
 #include <linux/types.h>
 
 struct iosys_map;
@@ -18,12 +17,6 @@ static inline bool drm_draw_is_pixel_fg(const u8 *sbuf8, unsigned int spitch, in
 	return (sbuf8[(y * spitch) + x / 8] & (0x80 >> (x % 8))) != 0;
 }
 
-static inline const u8 *drm_draw_get_char_bitmap(const struct font_desc *font,
-						 char c, size_t font_pitch)
-{
-	return font->data + (c * font->height) * font_pitch;
-}
-
 bool drm_draw_can_convert_from_xrgb8888(u32 format);
 
 u32 drm_draw_color_from_xrgb8888(u32 color, u32 format);
-- 
2.54.0

