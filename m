Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8451EF99362
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E91E410F02B;
	Thu, 23 Apr 2026 09:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="YVs9h22i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ssp+BQUg";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YVs9h22i";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ssp+BQUg";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D31310F02B
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 09:45:08 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FD136A84E;
 Thu, 23 Apr 2026 09:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776937500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYJuol+7YU/+PHceO+yqgAfvdOLjBZXkYkfGRMV3HPo=;
 b=YVs9h22iqqvN6J+XreSDzaVLqfsIRnE+otwdujtxBcKNyxI9vnqX5p/jjSiV9IMWNcVdlG
 18i6IPI5RUPItdEGnUvpQ3vWj5d1rCd/oqluNdrKJHaGiRLyNwT80f68l+P8GlEb1nSPk9
 MoaChKeh7Qwh16fn9ErR3eX0KJX8VZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776937500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYJuol+7YU/+PHceO+yqgAfvdOLjBZXkYkfGRMV3HPo=;
 b=Ssp+BQUg18k0vg/Ojx6U6uaNnOU8KaZYfQ5SiUcSFca/zScnJEHAZofssAeTAuVYKRow80
 gKEeNz2jGhMRbGCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776937500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYJuol+7YU/+PHceO+yqgAfvdOLjBZXkYkfGRMV3HPo=;
 b=YVs9h22iqqvN6J+XreSDzaVLqfsIRnE+otwdujtxBcKNyxI9vnqX5p/jjSiV9IMWNcVdlG
 18i6IPI5RUPItdEGnUvpQ3vWj5d1rCd/oqluNdrKJHaGiRLyNwT80f68l+P8GlEb1nSPk9
 MoaChKeh7Qwh16fn9ErR3eX0KJX8VZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776937500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jYJuol+7YU/+PHceO+yqgAfvdOLjBZXkYkfGRMV3HPo=;
 b=Ssp+BQUg18k0vg/Ojx6U6uaNnOU8KaZYfQ5SiUcSFca/zScnJEHAZofssAeTAuVYKRow80
 gKEeNz2jGhMRbGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24602593A3;
 Thu, 23 Apr 2026 09:45:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2KiuBxzq6Wk+QwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 09:45:00 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: inki.dae@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org
Cc: linux-samsung-soc@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5/5] drm/exynos: Make exynos_drm_framebuffer_init() an
 internal interface
Date: Thu, 23 Apr 2026 11:37:50 +0200
Message-ID: <20260423094452.32665-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423094452.32665-1-tzimmermann@suse.de>
References: <20260423094452.32665-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[samsung.com,gmail.com,ffwll.ch,lists.freedesktop.org];
 RCPT_COUNT_SEVEN(0.00)[8];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

The only caller of exynos_drm_framebuffer_init() is the helper
exynos_user_fb_create() from the same source file. Declare the
former as static.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/exynos/exynos_drm_fb.c | 2 +-
 drivers/gpu/drm/exynos/exynos_drm_fb.h | 7 -------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.c b/drivers/gpu/drm/exynos/exynos_drm_fb.c
index ab0e0c74ec47..66dec2b7a5de 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.c
@@ -55,7 +55,7 @@ static const struct drm_framebuffer_funcs exynos_drm_fb_funcs = {
 	.create_handle	= drm_gem_fb_create_handle,
 };
 
-struct drm_framebuffer *
+static struct drm_framebuffer *
 exynos_drm_framebuffer_init(struct drm_device *dev,
 			    const struct drm_format_info *info,
 			    const struct drm_mode_fb_cmd2 *mode_cmd,
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fb.h b/drivers/gpu/drm/exynos/exynos_drm_fb.h
index fdc6cb40cc9c..aeb6f29eb167 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fb.h
+++ b/drivers/gpu/drm/exynos/exynos_drm_fb.h
@@ -12,13 +12,6 @@
 
 #include "exynos_drm_gem.h"
 
-struct drm_framebuffer *
-exynos_drm_framebuffer_init(struct drm_device *dev,
-			    const struct drm_format_info *info,
-			    const struct drm_mode_fb_cmd2 *mode_cmd,
-			    struct exynos_drm_gem **exynos_gem,
-			    int count);
-
 dma_addr_t exynos_drm_fb_dma_addr(struct drm_framebuffer *fb, int index);
 
 void exynos_drm_mode_config_init(struct drm_device *dev);
-- 
2.53.0

