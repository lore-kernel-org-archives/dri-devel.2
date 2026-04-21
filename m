Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFBBF327B7
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D14310E821;
	Tue, 21 Apr 2026 07:36:59 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C3F310E820
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 07:36:56 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B2BF5BCC2;
 Tue, 21 Apr 2026 07:36:55 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE6AA593AF;
 Tue, 21 Apr 2026 07:36:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CIwMLRYp52lgMQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 21 Apr 2026 07:36:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: thierry.reding@gmail.com, mperttunen@nvidia.com, airlied@gmail.com,
 simona@ffwll.ch, jonathanh@nvidia.com
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/5] drm/tegra: fbdev: Calculate buffer geometry with format
 helpers
Date: Tue, 21 Apr 2026 09:29:07 +0200
Message-ID: <20260421073646.144712-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421073646.144712-1-tzimmermann@suse.de>
References: <20260421073646.144712-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 1B2BF5BCC2
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
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

Replace the geometry and size calculation in tegra's fbdev emulation
with DRM format helpers. This consists of a 4CC lookup from the fbdev
parameters, format lookup, pitch calculation and size calculation.
Then allocate the GEM buffer object for the framebuffer memory from
the calculated size.

Set up mode_cmd with the calculated values just before allocating the
framebuffer. This code will later be replaced with a DRM client buffer.

Set framebuffer size fields in struct fb_info from the size stored in
the GEM buffer object instead of what has been requested. The requested
size is an estimate, while the buffer size is the exact value rounded
to the correct alignment.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tegra/fbdev.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/tegra/fbdev.c b/drivers/gpu/drm/tegra/fbdev.c
index 793849199783..bcf32cfcf818 100644
--- a/drivers/gpu/drm/tegra/fbdev.c
+++ b/drivers/gpu/drm/tegra/fbdev.c
@@ -74,31 +74,29 @@ int tegra_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	struct drm_device *drm = helper->dev;
 	struct drm_mode_fb_cmd2 cmd = { 0 };
 	struct fb_info *info = helper->info;
-	unsigned int bytes_per_pixel;
+	u32 fourcc, pitch;
+	u64 size;
+	const struct drm_format_info *format;
 	struct drm_framebuffer *fb;
 	struct tegra_bo *bo;
-	size_t size;
 	int err;
 
-	bytes_per_pixel = DIV_ROUND_UP(sizes->surface_bpp, 8);
-
-	cmd.width = sizes->surface_width;
-	cmd.height = sizes->surface_height;
-	cmd.pitches[0] = round_up(sizes->surface_width * bytes_per_pixel,
-				  tegra->pitch_align);
-
-	cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-						     sizes->surface_depth);
-
-	size = cmd.pitches[0] * cmd.height;
+	fourcc = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
+	format = drm_get_format_info(drm, fourcc, DRM_FORMAT_MOD_LINEAR);
+	pitch = round_up(drm_format_info_min_pitch(format, 0, sizes->surface_width),
+			 tegra->pitch_align);
+	size = ALIGN(pitch * sizes->surface_height, PAGE_SIZE);
 
 	bo = tegra_bo_create(drm, size, 0);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
-	fb = tegra_fb_alloc(drm,
-			    drm_get_format_info(drm, cmd.pixel_format, cmd.modifier[0]),
-			    &cmd, &bo, 1);
+	cmd.pixel_format = fourcc;
+	cmd.width = sizes->surface_width;
+	cmd.height = sizes->surface_height;
+	cmd.pitches[0] = pitch;
+
+	fb = tegra_fb_alloc(drm, format, &cmd, &bo, 1);
 	if (IS_ERR(fb)) {
 		err = PTR_ERR(fb);
 		dev_err(drm->dev, "failed to allocate DRM framebuffer: %d\n",
@@ -126,9 +124,9 @@ int tegra_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 
 	info->flags |= FBINFO_VIRTFB;
 	info->screen_buffer = bo->vaddr;
-	info->screen_size = size;
+	info->screen_size = bo->gem.size;
 	info->fix.smem_start = (unsigned long)(bo->iova);
-	info->fix.smem_len = size;
+	info->fix.smem_len = bo->gem.size;
 
 	return 0;
 
-- 
2.53.0

