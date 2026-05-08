Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A387ECD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 06:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C12310F355;
	Fri,  8 May 2026 06:49:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="DHqil9Hj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZG5PVxkZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DHqil9Hj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZG5PVxkZ";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF5E10F355
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 06:48:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DCF15CEE9;
 Fri,  8 May 2026 06:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778222930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLjTNZgL4gEzhBMwHrATXC3/4dxX5ZU42sUg7OnQ+JM=;
 b=DHqil9HjKooC3Xc7aEY/WltopCHZ95+NeXJYsqPc8WE9Z176z3xHrm0K+UJdZEaO8dnh4w
 gWa485vBgEFfF1CxkV5ehYk9qHKw2saAWz6osDOzeOH9ig0cp+NANGFx8wfwfWRpNhYkNb
 9SfFasM5FGUCPpHiGTATxBcVbqNdV/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778222930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLjTNZgL4gEzhBMwHrATXC3/4dxX5ZU42sUg7OnQ+JM=;
 b=ZG5PVxkZoNdxNhUlsweT6DrqHZBfBu7eH2xM0XCY5yDF+c+9teW6fy2IoqS/uhKbIgMdBt
 EHwEzQy0BxuVkKBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778222930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLjTNZgL4gEzhBMwHrATXC3/4dxX5ZU42sUg7OnQ+JM=;
 b=DHqil9HjKooC3Xc7aEY/WltopCHZ95+NeXJYsqPc8WE9Z176z3xHrm0K+UJdZEaO8dnh4w
 gWa485vBgEFfF1CxkV5ehYk9qHKw2saAWz6osDOzeOH9ig0cp+NANGFx8wfwfWRpNhYkNb
 9SfFasM5FGUCPpHiGTATxBcVbqNdV/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778222930;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zLjTNZgL4gEzhBMwHrATXC3/4dxX5ZU42sUg7OnQ+JM=;
 b=ZG5PVxkZoNdxNhUlsweT6DrqHZBfBu7eH2xM0XCY5yDF+c+9teW6fy2IoqS/uhKbIgMdBt
 EHwEzQy0BxuVkKBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 522CA593A7;
 Fri,  8 May 2026 06:48:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kIKeElKH/Wm1cgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 08 May 2026 06:48:50 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: inki.dae@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com,
 m.szyprowski@samsung.com, wens@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/5] drm/exynos: fbdev: Inline exynos_drm_fbdev_update()
Date: Fri,  8 May 2026 08:46:48 +0200
Message-ID: <20260508064842.22689-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508064842.22689-1-tzimmermann@suse.de>
References: <20260508064842.22689-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_TO(0.00)[samsung.com,kernel.org,gmail.com,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[10]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Inline exynos_drm_fbdev_update() into its only caller. Prepares the
code for using DRM client buffers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 35 ++++++-----------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index d283ded266d5..1c564edd497e 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -54,26 +54,6 @@ static const struct fb_ops exynos_drm_fb_ops = {
 	.fb_destroy	= exynos_drm_fb_destroy,
 };
 
-static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
-				   struct drm_fb_helper_surface_size *sizes,
-				   struct exynos_drm_gem *exynos_gem)
-{
-	struct fb_info *fbi = helper->info;
-	struct drm_framebuffer *fb = helper->fb;
-	unsigned int size = fb->width * fb->height * fb->format->cpp[0];
-
-	fbi->fbops = &exynos_drm_fb_ops;
-
-	drm_fb_helper_fill_info(fbi, helper, sizes);
-
-	fbi->flags |= FBINFO_VIRTFB;
-	fbi->screen_buffer = exynos_gem->kvaddr;
-	fbi->screen_size = size;
-	fbi->fix.smem_len = size;
-
-	return 0;
-}
-
 static const struct drm_fb_helper_funcs exynos_drm_fbdev_helper_funcs = {
 };
 
@@ -82,6 +62,7 @@ int exynos_drm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 {
 	struct exynos_drm_gem *exynos_gem;
 	struct drm_device *dev = helper->dev;
+	struct fb_info *info = helper->info;
 	struct drm_mode_fb_cmd2 mode_cmd = { 0 };
 	unsigned long size;
 	int ret;
@@ -115,15 +96,17 @@ int exynos_drm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	}
 	helper->funcs = &exynos_drm_fbdev_helper_funcs;
 
-	ret = exynos_drm_fbdev_update(helper, sizes, exynos_gem);
-	if (ret < 0)
-		goto err_destroy_framebuffer;
+	info->fbops = &exynos_drm_fb_ops;
+
+	drm_fb_helper_fill_info(info, helper, sizes);
+
+	info->flags |= FBINFO_VIRTFB;
+	info->screen_buffer = exynos_gem->kvaddr;
+	info->screen_size = size;
+	info->fix.smem_len = size;
 
 	return 0;
 
-err_destroy_framebuffer:
-	drm_framebuffer_cleanup(helper->fb);
-	helper->fb = NULL;
 err_destroy_gem:
 	exynos_drm_gem_destroy(exynos_gem);
 	return ret;
-- 
2.54.0

