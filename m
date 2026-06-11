Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51B2CD8CB9
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 174B110ED13;
	Thu, 11 Jun 2026 07:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="mH5sNyQ4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Xlhs5xxM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vBl5LtVI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w74nClr2";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24F5910ED13
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:21:38 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA3CF6AF17;
 Thu, 11 Jun 2026 07:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781162488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Brvw1XtbD1aevs6+0l4JjUdt4q9AmVarY+QBzKU91BE=;
 b=mH5sNyQ4qduSyCsCP4++ugFmD+BTc3d7BXrHDMoFAHsIz0S8avcuWdUroIRJxtaM2AYMKt
 mlvxeVVTyRkFeTPvMarXz68SlN7V5hdlbgJgFzHuf9Gi7qGDQO1lAEZjXVsOp/vK4Kl7bB
 w1J8GY+5LlN0j4Wzj06PR1TIkpga4mA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781162488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Brvw1XtbD1aevs6+0l4JjUdt4q9AmVarY+QBzKU91BE=;
 b=Xlhs5xxMmJdleojlSG19QlEo8BzBfUm3Gb6L/etjcr/x5241NQXlIhWRUEYkUCIVexzvyH
 ZD2EOr+dLpV3qmDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781162487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Brvw1XtbD1aevs6+0l4JjUdt4q9AmVarY+QBzKU91BE=;
 b=vBl5LtVIvIhsN9fuokV1yS/mec/XYGdeBlklriE806AAIZ+d7SMNRlkKP+uNV/BDhU07Ek
 eIKZ2JuE8y8WvXi0EDvoA/QJN7ocHkXvC4yoszAOvbeVps09S+6qf9Er9C4jGCDwdnozQ3
 mLj71xonKhdrL2KJjaU2QRD7mg6tEmw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781162487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Brvw1XtbD1aevs6+0l4JjUdt4q9AmVarY+QBzKU91BE=;
 b=w74nClr2gIcxUS/f3CPKRzTg+nMAD/sVMQ1P+UcOgVCPoNgkKcwOdDEvvzDU4bwd1pugLU
 SzEVYFPL6hYq2qBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0B3B779A7;
 Thu, 11 Jun 2026 07:21:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6EK1KfdhKmqKKAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 11 Jun 2026 07:21:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: linux@armlinux.org.uk, airlied@gmail.com, simona@ffwll.ch,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/3] drm/armada: fbdev: Use a DRM client buffer
Date: Thu, 11 Jun 2026 09:20:12 +0200
Message-ID: <20260611072121.71492-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611072121.71492-1-tzimmermann@suse.de>
References: <20260611072121.71492-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com,ffwll.ch,kernel.org,linux.intel.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCVD_TLS_ALL(0.00)[];
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
DRM clients in user space and armada's internal fbdev emulation. It
also simplifies the clean-up side of the fbdev emulation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/armada/armada_fbdev.c | 41 ++++++++++++++++-----------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index f95658091acf..46b2eb84b65f 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -26,8 +26,7 @@ static void armada_fbdev_fb_destroy(struct fb_info *info)
 
 	drm_fb_helper_fini(fbh);
 
-	fbh->fb->funcs->destroy(fbh->fb);
-
+	drm_client_buffer_delete(fbh->buffer);
 	drm_client_release(&fbh->client);
 }
 
@@ -43,14 +42,16 @@ static const struct drm_fb_helper_funcs armada_fbdev_helper_funcs;
 int armada_fbdev_driver_fbdev_probe(struct drm_fb_helper *fbh,
 				    struct drm_fb_helper_surface_size *sizes)
 {
-	struct drm_device *dev = fbh->dev;
+	struct drm_client_dev *client = &fbh->client;
+	struct drm_device *dev = client->dev;
+	struct drm_file *file = client->file;
 	struct fb_info *info = fbh->info;
 	u32 fourcc, pitch;
 	u64 size;
 	const struct drm_format_info *format;
-	struct drm_mode_fb_cmd2 mode;
-	struct armada_framebuffer *dfb;
 	struct armada_gem_object *obj;
+	struct drm_client_buffer *buffer;
+	u32 handle;
 	int ret;
 	void *ptr;
 
@@ -85,37 +86,43 @@ int armada_fbdev_driver_fbdev_probe(struct drm_fb_helper *fbh,
 		goto err_drm_gem_object_put;
 	}
 
-	memset(&mode, 0, sizeof(mode));
-	mode.width = sizes->surface_width;
-	mode.height = sizes->surface_height;
-	mode.pitches[0] = pitch;
-	mode.pixel_format = fourcc;
-
-	dfb = armada_framebuffer_create(dev, format, &mode, obj);
-	if (IS_ERR(dfb)) {
-		ret = PTR_ERR(dfb);
+	ret = drm_gem_handle_create(file, &obj->obj, &handle);
+	if (ret)
 		goto err_drm_gem_object_put;
+
+	buffer = drm_client_buffer_create(client, sizes->surface_width, sizes->surface_height,
+					  fourcc, handle, pitch);
+	if (IS_ERR(buffer)) {
+		ret = PTR_ERR(buffer);
+		goto err_drm_gem_handle_delete;
 	}
 
+	fbh->funcs = &armada_fbdev_helper_funcs;
+	fbh->buffer = buffer;
+	fbh->fb = buffer->fb;
+
 	info->fbops = &armada_fb_ops;
 	info->fix.smem_start = obj->phys_addr;
 	info->fix.smem_len = obj->obj.size;
 	info->screen_size = obj->obj.size;
 	info->screen_base = ptr;
-	fbh->funcs = &armada_fbdev_helper_funcs;
-	fbh->fb = &dfb->fb;
 
 	drm_fb_helper_fill_info(info, fbh, sizes);
 
 	DRM_DEBUG_KMS("allocated %dx%d %dbpp fb: 0x%08llx\n",
-		dfb->fb.width, dfb->fb.height, dfb->fb.format->cpp[0] * 8,
+		buffer->fb->width, buffer->fb->height, buffer->fb->format->cpp[0] * 8,
 		(unsigned long long)obj->phys_addr);
 
+	/* The handle is only needed for creating the framebuffer. */
+	drm_gem_handle_delete(file, handle);
+
 	/* The framebuffer still holds a reference on the GEM object. */
 	drm_gem_object_put(&obj->obj);
 
 	return 0;
 
+err_drm_gem_handle_delete:
+	drm_gem_handle_delete(file, handle);
 err_drm_gem_object_put:
 	drm_gem_object_put(&obj->obj);
 	return ret;
-- 
2.54.0

