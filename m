Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C15F327B5
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3C2A10E172;
	Tue, 21 Apr 2026 07:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="RZUsWEgD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3XopyJxM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RZUsWEgD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3XopyJxM";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADF5E10E823
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 07:37:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 643455BCE1;
 Tue, 21 Apr 2026 07:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776757015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Daf0Jsw+offRMnbEhayvvjA2M01+QV/OTxOZSJbv60s=;
 b=RZUsWEgDmjaraOWNSccQN8EGULGlXV3aLFVCEVUd0l/O8ubP8RJECGDdkkBVMd644vkmM6
 2/MuAQcGuifTcpaBokUILgPNYIXUgYzP5sTbysbLw3arnMXmxKobuWfw0Sl0sIv50H0SpE
 t+oqHhVsnBgulbLdwNSQ0O76nA0u0IE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776757015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Daf0Jsw+offRMnbEhayvvjA2M01+QV/OTxOZSJbv60s=;
 b=3XopyJxMvmr9liFvmbQ4Ja4Fb82ZKw6e2PXSTIqum9iWPcQ/6+XLtUIW57MR8Ap+GNwM/M
 DsoB97TNw9L/TXAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776757015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Daf0Jsw+offRMnbEhayvvjA2M01+QV/OTxOZSJbv60s=;
 b=RZUsWEgDmjaraOWNSccQN8EGULGlXV3aLFVCEVUd0l/O8ubP8RJECGDdkkBVMd644vkmM6
 2/MuAQcGuifTcpaBokUILgPNYIXUgYzP5sTbysbLw3arnMXmxKobuWfw0Sl0sIv50H0SpE
 t+oqHhVsnBgulbLdwNSQ0O76nA0u0IE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776757015;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Daf0Jsw+offRMnbEhayvvjA2M01+QV/OTxOZSJbv60s=;
 b=3XopyJxMvmr9liFvmbQ4Ja4Fb82ZKw6e2PXSTIqum9iWPcQ/6+XLtUIW57MR8Ap+GNwM/M
 DsoB97TNw9L/TXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 221AC593AF;
 Tue, 21 Apr 2026 07:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6KYjBxcp52lgMQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 21 Apr 2026 07:36:55 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: thierry.reding@gmail.com, mperttunen@nvidia.com, airlied@gmail.com,
 simona@ffwll.ch, jonathanh@nvidia.com
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/5] drm/tegra: fbdev: Use a DRM client buffer
Date: Tue, 21 Apr 2026 09:29:08 +0200
Message-ID: <20260421073646.144712-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421073646.144712-1-tzimmermann@suse.de>
References: <20260421073646.144712-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TAGGED_RCPT(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,nvidia.com,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[8]; TO_DN_SOME(0.00)[];
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

Replace the internal DRM framebuffer with a DRM client buffer. The
client buffer allocates the DRM framebuffer on a file and also uses
GEM object handles via the regular ADDFB2 interfaces.

Using client-buffer interfaces unifies framebuffer allocation for
DRM clients in user space and tegra's internal fbdev emulation. It
also simplifies the clean-up side of the fbdev emulation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tegra/fbdev.c | 61 +++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/tegra/fbdev.c b/drivers/gpu/drm/tegra/fbdev.c
index bcf32cfcf818..003e80cf7b9a 100644
--- a/drivers/gpu/drm/tegra/fbdev.c
+++ b/drivers/gpu/drm/tegra/fbdev.c
@@ -40,8 +40,7 @@ static int tegra_fb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 static void tegra_fbdev_fb_destroy(struct fb_info *info)
 {
 	struct drm_fb_helper *helper = info->par;
-	struct drm_framebuffer *fb = helper->fb;
-	struct tegra_bo *bo = tegra_fb_get_plane(fb, 0);
+	struct tegra_bo *bo = tegra_fb_get_plane(helper->fb, 0);
 
 	drm_fb_helper_fini(helper);
 
@@ -50,8 +49,8 @@ static void tegra_fbdev_fb_destroy(struct fb_info *info)
 		vunmap(bo->vaddr);
 		bo->vaddr = NULL;
 	}
-	drm_framebuffer_remove(fb);
 
+	drm_client_buffer_delete(helper->buffer);
 	drm_client_release(&helper->client);
 }
 
@@ -70,15 +69,18 @@ static const struct drm_fb_helper_funcs tegra_fbdev_helper_funcs = {
 int tegra_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 				   struct drm_fb_helper_surface_size *sizes)
 {
-	struct tegra_drm *tegra = helper->dev->dev_private;
-	struct drm_device *drm = helper->dev;
-	struct drm_mode_fb_cmd2 cmd = { 0 };
+	struct drm_client_dev *client = &helper->client;
+	struct drm_device *drm = client->dev;
+	struct drm_file *file = client->file;
+	struct tegra_drm *tegra = drm->dev_private;
 	struct fb_info *info = helper->info;
 	u32 fourcc, pitch;
 	u64 size;
 	const struct drm_format_info *format;
-	struct drm_framebuffer *fb;
 	struct tegra_bo *bo;
+	struct drm_gem_object *gem;
+	u32 handle;
+	struct drm_client_buffer *buffer;
 	int err;
 
 	fourcc = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
@@ -90,23 +92,22 @@ int tegra_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	bo = tegra_bo_create(drm, size, 0);
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
+	gem = &bo->gem;
 
-	cmd.pixel_format = fourcc;
-	cmd.width = sizes->surface_width;
-	cmd.height = sizes->surface_height;
-	cmd.pitches[0] = pitch;
-
-	fb = tegra_fb_alloc(drm, format, &cmd, &bo, 1);
-	if (IS_ERR(fb)) {
-		err = PTR_ERR(fb);
-		dev_err(drm->dev, "failed to allocate DRM framebuffer: %d\n",
-			err);
-		drm_gem_object_put(&bo->gem);
-		return PTR_ERR(fb);
+	err = drm_gem_handle_create(file, gem, &handle);
+	if (err)
+		goto err_drm_gem_object_put;
+
+	buffer = drm_client_buffer_create(client, sizes->surface_width, sizes->surface_height,
+					  fourcc, handle, pitch);
+	if (IS_ERR(buffer)) {
+		err = PTR_ERR(buffer);
+		goto err_drm_gem_handle_delete;
 	}
 
 	helper->funcs = &tegra_fbdev_helper_funcs;
-	helper->fb = fb;
+	helper->buffer = buffer;
+	helper->fb = buffer->fb;
 
 	info->fbops = &tegra_fb_ops;
 
@@ -118,19 +119,29 @@ int tegra_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 		if (!bo->vaddr) {
 			dev_err(drm->dev, "failed to vmap() framebuffer\n");
 			err = -ENOMEM;
-			goto destroy;
+			goto err_drm_client_buffer_delete;
 		}
 	}
 
 	info->flags |= FBINFO_VIRTFB;
 	info->screen_buffer = bo->vaddr;
-	info->screen_size = bo->gem.size;
+	info->screen_size = gem->size;
 	info->fix.smem_start = (unsigned long)(bo->iova);
-	info->fix.smem_len = bo->gem.size;
+	info->fix.smem_len = gem->size;
+
+	/* The handle is only needed for creating the framebuffer. */
+	drm_gem_handle_delete(file, handle);
+
+	/* The framebuffer still holds a reference on the GEM object. */
+	drm_gem_object_put(gem);
 
 	return 0;
 
-destroy:
-	drm_framebuffer_remove(fb);
+err_drm_client_buffer_delete:
+	drm_client_buffer_delete(buffer);
+err_drm_gem_handle_delete:
+	drm_gem_handle_delete(file, handle);
+err_drm_gem_object_put:
+	drm_gem_object_put(gem);
 	return err;
 }
-- 
2.53.0

