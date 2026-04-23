Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301D8F99344
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378B910F024;
	Thu, 23 Apr 2026 09:45:06 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F17C410F00F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 09:45:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D11315BCF9;
 Thu, 23 Apr 2026 09:44:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90C52593B0;
 Thu, 23 Apr 2026 09:44:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wPvqIRvq6Wk+QwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 09:44:59 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: inki.dae@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org
Cc: linux-samsung-soc@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/5] drm/exynos: fbdev: Calculate buffer geometry with format
 helpers
Date: Thu, 23 Apr 2026 11:37:48 +0200
Message-ID: <20260423094452.32665-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423094452.32665-1-tzimmermann@suse.de>
References: <20260423094452.32665-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: D11315BCF9
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Replace the geometry and size calculation in exynos' fbdev emulation
with DRM format helpers. This consists of a 4CC lookup from the fbdev
parameters, format lookup, pitch calculation and size calculation.

Then allocate the GEM buffer object for the framebuffer memory from
the calculated size. Mmap provides the allocated buffer to user space,
so align the buffer size to PAGE_SIZE.

Initialize the fields screen_size and fix.smem_len in struct fb_info
from the size of the allocated buffer object. This is the real size
and can differ from the requested size.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 35 ++++++++++++-----------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 1c564edd497e..9225cf1a83c8 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -60,11 +60,14 @@ static const struct drm_fb_helper_funcs exynos_drm_fbdev_helper_funcs = {
 int exynos_drm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 					struct drm_fb_helper_surface_size *sizes)
 {
-	struct exynos_drm_gem *exynos_gem;
 	struct drm_device *dev = helper->dev;
 	struct fb_info *info = helper->info;
+	u32 fourcc, pitch;
+	u64 size;
+	const struct drm_format_info *format;
+	struct exynos_drm_gem *exynos_gem;
+	struct drm_gem_object *obj;
 	struct drm_mode_fb_cmd2 mode_cmd = { 0 };
-	unsigned long size;
 	int ret;
 
 	DRM_DEV_DEBUG_KMS(dev->dev,
@@ -72,23 +75,23 @@ int exynos_drm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 			  sizes->surface_width, sizes->surface_height,
 			  sizes->surface_bpp);
 
-	mode_cmd.width = sizes->surface_width;
-	mode_cmd.height = sizes->surface_height;
-	mode_cmd.pitches[0] = sizes->surface_width * (sizes->surface_bpp >> 3);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-							  sizes->surface_depth);
-
-	size = mode_cmd.pitches[0] * mode_cmd.height;
+	fourcc = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
+	format = drm_get_format_info(dev, fourcc, DRM_FORMAT_MOD_LINEAR);
+	pitch = drm_format_info_min_pitch(format, 0, sizes->surface_width);
+	size = ALIGN(pitch * sizes->surface_height, PAGE_SIZE);
 
 	exynos_gem = exynos_drm_gem_create(dev, EXYNOS_BO_WC, size, true);
 	if (IS_ERR(exynos_gem))
 		return PTR_ERR(exynos_gem);
+	obj = &exynos_gem->base;
+
+	mode_cmd.width = sizes->surface_width;
+	mode_cmd.height = sizes->surface_height;
+	mode_cmd.pixel_format = fourcc;
+	mode_cmd.pitches[0] = pitch;
+	mode_cmd.modifier[0] = DRM_FORMAT_MOD_LINEAR;
 
-	helper->fb =
-		exynos_drm_framebuffer_init(dev,
-					    drm_get_format_info(dev, mode_cmd.pixel_format,
-								mode_cmd.modifier[0]),
-					    &mode_cmd, &exynos_gem, 1);
+	helper->fb = exynos_drm_framebuffer_init(dev, format, &mode_cmd, &exynos_gem, 1);
 	if (IS_ERR(helper->fb)) {
 		DRM_DEV_ERROR(dev->dev, "failed to create drm framebuffer.\n");
 		ret = PTR_ERR(helper->fb);
@@ -102,8 +105,8 @@ int exynos_drm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 
 	info->flags |= FBINFO_VIRTFB;
 	info->screen_buffer = exynos_gem->kvaddr;
-	info->screen_size = size;
-	info->fix.smem_len = size;
+	info->screen_size = obj->size;
+	info->fix.smem_len = obj->size;
 
 	return 0;
 
-- 
2.53.0

