Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72A3F589DA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:00:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1766C10F149;
	Thu, 23 Apr 2026 14:00:47 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E61C710F149
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:00:44 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6ADB06A86C;
 Thu, 23 Apr 2026 14:00:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36435593A3;
 Thu, 23 Apr 2026 14:00:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YFcPDAMm6mlCTwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 14:00:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/3] drm/omapdrm: fbdev: Use a DRM client buffer
Date: Thu, 23 Apr 2026 15:58:08 +0200
Message-ID: <20260423140031.126072-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423140031.126072-1-tzimmermann@suse.de>
References: <20260423140031.126072-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 6ADB06A86C
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

Replace the internal DRM framebuffer with a DRM client buffer. The
client buffer allocates the DRM framebuffer on a file and also uses
GEM object handles via the regular ADDFB2 interfaces.

Using client-buffer interfaces unifies framebuffer allocation for
DRM clients in user space and omapdrm's internal fbdev emulation. It
also simplifies the clean-up side of the fbdev emulation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/omapdrm/omap_fbdev.c | 68 ++++++++++++++--------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index f1044d8d1a85..932da9877b98 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -93,8 +93,7 @@ static int omap_fbdev_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 static void omap_fbdev_fb_destroy(struct fb_info *info)
 {
 	struct drm_fb_helper *helper = info->par;
-	struct drm_framebuffer *fb = helper->fb;
-	struct drm_gem_object *bo = drm_gem_fb_get_obj(fb, 0);
+	struct drm_gem_object *bo = drm_gem_fb_get_obj(helper->fb, 0);
 
 	DBG();
 
@@ -102,8 +101,8 @@ static void omap_fbdev_fb_destroy(struct fb_info *info)
 	drm_fb_helper_fini(helper);
 
 	omap_gem_unpin(bo);
-	drm_framebuffer_remove(fb);
 
+	drm_client_buffer_delete(helper->buffer);
 	drm_client_release(&helper->client);
 }
 
@@ -152,18 +151,20 @@ static struct drm_fb_helper *get_fb(struct fb_info *fbi)
 int omap_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 				  struct drm_fb_helper_surface_size *sizes)
 {
-	struct drm_device *dev = helper->dev;
+	struct drm_client_dev *client = &helper->client;
+	struct drm_device *dev = client->dev;
+	struct drm_file *file = client->file;
 	struct omap_drm_private *priv = dev->dev_private;
 	struct omap_fbdev *fbdev = priv->fbdev;
 	struct fb_info *fbi = helper->info;
 	u32 fourcc;
 	u64 pitch, size;
 	const struct drm_format_info *format;
-	struct drm_framebuffer *fb = NULL;
 	union omap_gem_size gsize;
-	struct drm_mode_fb_cmd2 mode_cmd = {0};
 	struct drm_gem_object *bo;
+	struct drm_client_buffer *buffer;
 	dma_addr_t dma_addr;
+	u32 handle;
 	int ret;
 
 	sizes->surface_bpp = 32;
@@ -196,24 +197,18 @@ int omap_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	bo = omap_gem_new(dev, gsize, OMAP_BO_SCANOUT | OMAP_BO_WC);
 	if (!bo) {
 		dev_err(dev->dev, "failed to allocate buffer object\n");
-		ret = -ENOMEM;
-		goto fail;
+		return -ENOMEM;
 	}
 
-	mode_cmd.pixel_format = fourcc;
-	mode_cmd.width = sizes->surface_width;
-	mode_cmd.height = sizes->surface_height;
-	mode_cmd.pitches[0] = pitch;
-
-	fb = omap_framebuffer_init(dev, format,  &mode_cmd, &bo);
-	if (IS_ERR(fb)) {
-		dev_err(dev->dev, "failed to allocate fb\n");
-		/* note: if fb creation failed, we can't rely on fb destroy
-		 * to unref the bo:
-		 */
-		drm_gem_object_put(bo);
-		ret = PTR_ERR(fb);
-		goto fail;
+	ret = drm_gem_handle_create(file, bo, &handle);
+	if (ret)
+		goto err_drm_gem_object_put;
+
+	buffer = drm_client_buffer_create(client, sizes->surface_width, sizes->surface_height,
+					  fourcc, handle, pitch);
+	if (IS_ERR(buffer)) {
+		ret = PTR_ERR(buffer);
+		goto err_drm_gem_handle_delete;
 	}
 
 	/* note: this keeps the bo pinned.. which is perhaps not ideal,
@@ -228,13 +223,14 @@ int omap_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	if (ret) {
 		dev_err(dev->dev, "could not pin framebuffer\n");
 		ret = -ENOMEM;
-		goto fail;
+		goto err_drm_client_buffer_delete;
 	}
 
 	DBG("fbi=%p, dev=%p", fbi, dev);
 
 	helper->funcs = &omap_fbdev_helper_funcs;
-	helper->fb = fb;
+	helper->buffer = buffer;
+	helper->fb = buffer->fb;
 
 	fbi->fbops = &omap_fb_ops;
 
@@ -253,7 +249,7 @@ int omap_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	fbi->fbdefio = &helper->fbdefio;
 	ret = fb_deferred_io_init(fbi);
 	if (ret)
-		goto fail;
+		goto err_omap_gem_unpin;
 
 	/* if we have DMM, then we can use it for scrolling by just
 	 * shuffling pages around in DMM rather than doing sw blit.
@@ -264,19 +260,25 @@ int omap_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 		fbi->fix.ywrapstep = 1;
 	}
 
-
 	DBG("par=%p, %dx%d", fbi->par, fbi->var.xres, fbi->var.yres);
-	DBG("allocated %dx%d fb", fb->width, fb->height);
+	DBG("allocated %dx%d fb", buffer->fb->width, buffer->fb->height);
 
-	return 0;
+	/* The handle is only needed for creating the framebuffer. */
+	drm_gem_handle_delete(file, handle);
 
-fail:
+	/* The framebuffer still holds a reference on the GEM object. */
+	drm_gem_object_put(bo);
 
-	if (ret) {
-		if (fb)
-			drm_framebuffer_remove(fb);
-	}
+	return 0;
 
+err_omap_gem_unpin:
+	omap_gem_unpin(bo);
+err_drm_client_buffer_delete:
+	drm_client_buffer_delete(buffer);
+err_drm_gem_handle_delete:
+	drm_gem_handle_delete(file, handle);
+err_drm_gem_object_put:
+	drm_gem_object_put(bo);
 	return ret;
 }
 
-- 
2.53.0

