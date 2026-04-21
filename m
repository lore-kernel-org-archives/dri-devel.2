Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F449F8FA72
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 12:57:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9688210EC9D;
	Tue, 21 Apr 2026 12:57:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="O9RWdFUj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iTDmtsJS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O9RWdFUj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iTDmtsJS";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3E810EC88
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 12:57:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C99C96A8F0;
 Tue, 21 Apr 2026 12:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776776261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZt0ydHttYtd0M1sWWj1Zg9jRiEQBNIJ16JlYRlATYM=;
 b=O9RWdFUjG7yZlEVJrWc+2Zz4OBJC+str5VWuHWw01HXyVxyvVgJHWs8hdx1vEGYwg5+EA+
 vAP3jPA7loggWw78qdTsfkR9JA1Mto6a7xOJft2CfKOiSuXhnXc04HQOTKiZ1RSMw9rAGB
 vdAb/6dDhB00/NN3I8qt+CwWubbUEx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776776261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZt0ydHttYtd0M1sWWj1Zg9jRiEQBNIJ16JlYRlATYM=;
 b=iTDmtsJSMWL5iu6bHri1vhqrCUAbgMpcmUjLk/IJoqD4DfryPbutpIeewj5n6vUYBKLSC/
 AX6sBUxJ2RQ0jHBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776776261; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZt0ydHttYtd0M1sWWj1Zg9jRiEQBNIJ16JlYRlATYM=;
 b=O9RWdFUjG7yZlEVJrWc+2Zz4OBJC+str5VWuHWw01HXyVxyvVgJHWs8hdx1vEGYwg5+EA+
 vAP3jPA7loggWw78qdTsfkR9JA1Mto6a7xOJft2CfKOiSuXhnXc04HQOTKiZ1RSMw9rAGB
 vdAb/6dDhB00/NN3I8qt+CwWubbUEx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776776261;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZt0ydHttYtd0M1sWWj1Zg9jRiEQBNIJ16JlYRlATYM=;
 b=iTDmtsJSMWL5iu6bHri1vhqrCUAbgMpcmUjLk/IJoqD4DfryPbutpIeewj5n6vUYBKLSC/
 AX6sBUxJ2RQ0jHBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73187593AF;
 Tue, 21 Apr 2026 12:57:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GC6pGkV052labwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 21 Apr 2026 12:57:41 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5/6] drm/msm: fbdev: Use a DRM client buffer
Date: Tue, 21 Apr 2026 14:51:18 +0200
Message-ID: <20260421125733.209568-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421125733.209568-1-tzimmermann@suse.de>
References: <20260421125733.209568-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,linux.dev,gmail.com,poorly.run,somainline.org,ffwll.ch];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
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
DRM clients in user space and msm's internal fbdev emulation. It
also simplifies the clean-up side of the fbdev emulation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/msm/msm_fbdev.c | 55 +++++++++++++++++++--------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index 5532c5779f17..f14db46aa51e 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -41,17 +41,15 @@ static int msm_fbdev_mmap(struct fb_info *info, struct vm_area_struct *vma)
 static void msm_fbdev_fb_destroy(struct fb_info *info)
 {
 	struct drm_fb_helper *helper = (struct drm_fb_helper *)info->par;
-	struct drm_framebuffer *fb = helper->fb;
-	struct drm_gem_object *bo = msm_framebuffer_bo(fb, 0);
+	struct drm_gem_object *bo = msm_framebuffer_bo(helper->fb, 0);
 
 	DBG();
 
 	drm_fb_helper_fini(helper);
 
-	/* this will free the backing object */
 	msm_gem_put_vaddr(bo);
-	drm_framebuffer_remove(fb);
 
+	drm_client_buffer_delete(helper->buffer);
 	drm_client_release(&helper->client);
 }
 
@@ -90,15 +88,16 @@ static const struct drm_fb_helper_funcs msm_fbdev_helper_funcs = {
 int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 				 struct drm_fb_helper_surface_size *sizes)
 {
-	struct drm_device *dev = helper->dev;
+	struct drm_client_dev *client = &helper->client;
+	struct drm_device *dev = client->dev;
+	struct drm_file *file = client->file;
 	struct msm_drm_private *priv = dev->dev_private;
 	struct fb_info *fbi = helper->info;
-	struct drm_mode_fb_cmd2 mode_cmd = { };
-	struct drm_framebuffer *fb = NULL;
 	const struct drm_format_info *format;
-	u32 fourcc, pitch;
+	u32 fourcc, pitch, handle;
 	u64 size;
 	struct drm_gem_object *bo;
+	struct drm_client_buffer *buffer;
 	uint64_t paddr;
 	int ret;
 
@@ -127,16 +126,15 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 
 	msm_gem_object_set_name(bo, "stolenfb");
 
-	mode_cmd.pixel_format = fourcc;
-	mode_cmd.width = sizes->surface_width;
-	mode_cmd.height = sizes->surface_height;
-	mode_cmd.pitches[0] = pitch;
-
-	fb = msm_framebuffer_init(dev, format, &mode_cmd, &bo);
-	if (IS_ERR(fb)) {
-		drm_err(dev, "failed to allocate fb\n");
-		ret = PTR_ERR(fb);
+	ret = drm_gem_handle_create(file, bo, &handle);
+	if (ret)
 		goto err_drm_gem_object_put;
+
+	buffer = drm_client_buffer_create(client, sizes->surface_width, sizes->surface_height,
+					  fourcc, handle, pitch);
+	if (IS_ERR(buffer)) {
+		ret = PTR_ERR(buffer);
+		goto err_drm_gem_handle_delete;
 	}
 
 	/*
@@ -147,13 +145,14 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	ret = msm_gem_get_and_pin_iova(bo, priv->kms->vm, &paddr);
 	if (ret) {
 		drm_err(dev, "failed to get buffer obj iova: %d\n", ret);
-		goto err_drm_framebuffer_remove;
+		goto err_drm_client_buffer_delete;
 	}
 
 	DBG("fbi=%p, dev=%p", fbi, dev);
 
 	helper->funcs = &msm_fbdev_helper_funcs;
-	helper->fb = fb;
+	helper->buffer = buffer;
+	helper->fb = buffer->fb;
 
 	fbi->fbops = &msm_fb_ops;
 
@@ -162,19 +161,29 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	fbi->screen_buffer = msm_gem_get_vaddr(bo);
 	if (IS_ERR(fbi->screen_buffer)) {
 		ret = PTR_ERR(fbi->screen_buffer);
-		goto err_drm_framebuffer_remove;
+		goto err_msm_gem_put_vaddr;
 	}
 	fbi->screen_size = bo->size;
 	fbi->fix.smem_start = paddr;
 	fbi->fix.smem_len = bo->size;
 
 	DBG("par=%p, %dx%d", fbi->par, fbi->var.xres, fbi->var.yres);
-	DBG("allocated %dx%d fb", fb->width, fb->height);
+	DBG("allocated %dx%d fb", buffer->fb->width, buffer->fb->height);
+
+	/* The handle is only needed for creating the framebuffer. */
+	drm_gem_handle_delete(file, handle);
+
+	/* The framebuffer still holds a reference on the GEM object. */
+	drm_gem_object_put(bo);
 
 	return 0;
 
-err_drm_framebuffer_remove:
-	drm_framebuffer_remove(fb);
+err_msm_gem_put_vaddr:
+	msm_gem_put_vaddr(bo);
+err_drm_client_buffer_delete:
+	drm_client_buffer_delete(buffer);
+err_drm_gem_handle_delete:
+	drm_gem_handle_delete(file, handle);
 err_drm_gem_object_put:
 	drm_gem_object_put(bo);
 	return ret;
-- 
2.53.0

