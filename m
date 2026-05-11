Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9180CD4842
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 11:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3495810E6B9;
	Mon, 11 May 2026 11:55:50 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C3610E6BF
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 11:55:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB14C75A92;
 Mon, 11 May 2026 11:55:43 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68010593A3;
 Mon, 11 May 2026 11:55:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MH4qGL/DAWoERgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 11 May 2026 11:55:43 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: inki.dae@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com,
 m.szyprowski@samsung.com, wens@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 2/5] drm/exynos: fbdev: Inline exynos_drm_fbdev_update()
Date: Mon, 11 May 2026 13:54:32 +0200
Message-ID: <20260511115538.57884-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511115538.57884-1-tzimmermann@suse.de>
References: <20260511115538.57884-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: AB14C75A92
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

