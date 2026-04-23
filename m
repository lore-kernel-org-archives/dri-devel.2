Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D147F589AE
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:36:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF6DA10F0EC;
	Thu, 23 Apr 2026 12:36:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ur+H0yCB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="43ttbHHU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AFanu26g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Cpg1LZcc";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16BF10F0F2
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:36:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 214236A86D;
 Thu, 23 Apr 2026 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776947800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9hUNBkptdS0e54SrwNjOb2PaaVB1CMo9J5gcuo6cu4=;
 b=ur+H0yCBmHCmvvFJTDRk5l/Jh0hZ77TlnuGR0buY4U2un0YdMyV3wMmv5zYbGf7AqvTKJx
 f7ny2vSBu6uh4nR6OFv9zcxP1KT3UPDOU/Ho8GSb7y3NX3D5JeeBKhiLuXRT3+K8XI68iB
 uDIIVNDzCUPfOPn0Gr/tC2vdaH1X9sM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776947800;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9hUNBkptdS0e54SrwNjOb2PaaVB1CMo9J5gcuo6cu4=;
 b=43ttbHHUPbwXntpzxD5CuNwnj4dHWseVjg2/29h532ZQCpFIhCYYB3PZYjwKf5E29PVFCj
 rO7jQM+xuCtMKhDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776947799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9hUNBkptdS0e54SrwNjOb2PaaVB1CMo9J5gcuo6cu4=;
 b=AFanu26g2Lfuvm2XtUkU54GO0yXWISRxA0DOjyfKyDahVHMPj1b1YJQEOBsYLd94DUJgLQ
 zH4qkSPepL325uWEAhqE/NACVOKH5CCkwfPlyJdID3hxuQl+lj/h8Z7+QLyJMQvDS0Z+4D
 ejGJISQYCd8XTXRywVIeFZJqlpMAd4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776947799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9hUNBkptdS0e54SrwNjOb2PaaVB1CMo9J5gcuo6cu4=;
 b=Cpg1LZccfrtoc4+rj07lrjH9gqGCEesHndjLTgazfUvcYUBvgHC20s5zfbxurQTSoAH9VG
 9QlJvokJoB5iraCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDBD1593A3;
 Thu, 23 Apr 2026 12:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UH/ZOFYS6mk/cwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 12:36:38 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: linux@armlinux.org.uk,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/3] drm/armada: fbdev: Use a DRM client buffer
Date: Thu, 23 Apr 2026 14:30:05 +0200
Message-ID: <20260423123635.107126-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423123635.107126-1-tzimmermann@suse.de>
References: <20260423123635.107126-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com,ffwll.ch];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
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
index 0d112a326255..bf1f87583586 100644
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
 
@@ -75,37 +76,43 @@ int armada_fbdev_driver_fbdev_probe(struct drm_fb_helper *fbh,
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
2.53.0

