Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB924F589A4
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 12:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9D8610F0E2;
	Thu, 23 Apr 2026 12:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="nQiLuYo+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3PETjXBA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nQiLuYo+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3PETjXBA";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 285B810F0EC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 12:36:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E69466A86C;
 Thu, 23 Apr 2026 12:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776947798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PT9SKmo6tzOBvxQzaNezssTsqsXpUBnFbxo81TsVmp0=;
 b=nQiLuYo+rDEU8UCp2yZpRLtS8LDIAj6QtjI1MOeVP4U5h5eJeGoKyycSnhDOmpKMYGsyoL
 svLsCFHQQBcsyiJkiME6SHvCuaBBlWkzzXZXhf4JjffvrBbwuzWjxrxMPbYN/obXScJCRk
 +rfXF3yCFREuOqnQOnZoH0ZbLyXQd20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776947798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PT9SKmo6tzOBvxQzaNezssTsqsXpUBnFbxo81TsVmp0=;
 b=3PETjXBAHi6M5K8SLmb2H4e1tYC3MOEHLUBXUGrtcHpwHE6TZyPnBs+T0LSwO0EINDRsfY
 Sqbfd19VrcJTv8Bw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nQiLuYo+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3PETjXBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776947798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PT9SKmo6tzOBvxQzaNezssTsqsXpUBnFbxo81TsVmp0=;
 b=nQiLuYo+rDEU8UCp2yZpRLtS8LDIAj6QtjI1MOeVP4U5h5eJeGoKyycSnhDOmpKMYGsyoL
 svLsCFHQQBcsyiJkiME6SHvCuaBBlWkzzXZXhf4JjffvrBbwuzWjxrxMPbYN/obXScJCRk
 +rfXF3yCFREuOqnQOnZoH0ZbLyXQd20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776947798;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PT9SKmo6tzOBvxQzaNezssTsqsXpUBnFbxo81TsVmp0=;
 b=3PETjXBAHi6M5K8SLmb2H4e1tYC3MOEHLUBXUGrtcHpwHE6TZyPnBs+T0LSwO0EINDRsfY
 Sqbfd19VrcJTv8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDE7B593B0;
 Thu, 23 Apr 2026 12:36:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KFj4LFYS6mk/cwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 12:36:38 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: linux@armlinux.org.uk,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/3] drm/armada: fbdev: Calculate buffer geometry with format
 helpers
Date: Thu, 23 Apr 2026 14:30:04 +0200
Message-ID: <20260423123635.107126-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423123635.107126-1-tzimmermann@suse.de>
References: <20260423123635.107126-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[armlinux.org.uk,gmail.com,ffwll.ch];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: E69466A86C
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

Replace the geometry and size calculation in armada's fbdev emulation
with DRM format helpers. This consists of a 4CC lookup from the fbdev
parameters, format lookup, pitch calculation and size calculation.

Then allocate the GEM buffer object for the framebuffer memory from
the calculated size. Mmap provides the allocated buffer to user space,
so align the buffer size to PAGE_SIZE.

Slightly rearrange cleaning up the GEM object and rolling back on
errors. This will simplify error handling when the code uses client
buffers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/armada/armada_fbdev.c | 55 ++++++++++++++-------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/armada/armada_fbdev.c b/drivers/gpu/drm/armada/armada_fbdev.c
index 8bbae94804f8..0d112a326255 100644
--- a/drivers/gpu/drm/armada/armada_fbdev.c
+++ b/drivers/gpu/drm/armada/armada_fbdev.c
@@ -45,20 +45,20 @@ int armada_fbdev_driver_fbdev_probe(struct drm_fb_helper *fbh,
 {
 	struct drm_device *dev = fbh->dev;
 	struct fb_info *info = fbh->info;
+	u32 fourcc, pitch;
+	u64 size;
+	const struct drm_format_info *format;
 	struct drm_mode_fb_cmd2 mode;
 	struct armada_framebuffer *dfb;
 	struct armada_gem_object *obj;
-	int size, ret;
+	int ret;
 	void *ptr;
 
-	memset(&mode, 0, sizeof(mode));
-	mode.width = sizes->surface_width;
-	mode.height = sizes->surface_height;
-	mode.pitches[0] = armada_pitch(mode.width, sizes->surface_bpp);
-	mode.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-					sizes->surface_depth);
+	fourcc = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
+	format = drm_get_format_info(dev, fourcc, DRM_FORMAT_MOD_LINEAR);
+	pitch = armada_pitch(sizes->surface_width, drm_format_info_bpp(format, 0));
+	size = ALIGN(pitch * sizes->surface_height, PAGE_SIZE);
 
-	size = mode.pitches[0] * mode.height;
 	obj = armada_gem_alloc_private_object(dev, size);
 	if (!obj) {
 		DRM_ERROR("failed to allocate fb memory\n");
@@ -66,30 +66,26 @@ int armada_fbdev_driver_fbdev_probe(struct drm_fb_helper *fbh,
 	}
 
 	ret = armada_gem_linear_back(dev, obj);
-	if (ret) {
-		drm_gem_object_put(&obj->obj);
-		return ret;
-	}
+	if (ret)
+		goto err_drm_gem_object_put;
 
 	ptr = armada_gem_map_object(dev, obj);
 	if (!ptr) {
-		drm_gem_object_put(&obj->obj);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto err_drm_gem_object_put;
 	}
 
-	dfb = armada_framebuffer_create(dev,
-					drm_get_format_info(dev, mode.pixel_format,
-							    mode.modifier[0]),
-					&mode, obj);
-
-	/*
-	 * A reference is now held by the framebuffer object if
-	 * successful, otherwise this drops the ref for the error path.
-	 */
-	drm_gem_object_put(&obj->obj);
+	memset(&mode, 0, sizeof(mode));
+	mode.width = sizes->surface_width;
+	mode.height = sizes->surface_height;
+	mode.pitches[0] = pitch;
+	mode.pixel_format = fourcc;
 
-	if (IS_ERR(dfb))
-		return PTR_ERR(dfb);
+	dfb = armada_framebuffer_create(dev, format, &mode, obj);
+	if (IS_ERR(dfb)) {
+		ret = PTR_ERR(dfb);
+		goto err_drm_gem_object_put;
+	}
 
 	info->fbops = &armada_fb_ops;
 	info->fix.smem_start = obj->phys_addr;
@@ -105,5 +101,12 @@ int armada_fbdev_driver_fbdev_probe(struct drm_fb_helper *fbh,
 		dfb->fb.width, dfb->fb.height, dfb->fb.format->cpp[0] * 8,
 		(unsigned long long)obj->phys_addr);
 
+	/* The framebuffer still holds a reference on the GEM object. */
+	drm_gem_object_put(&obj->obj);
+
 	return 0;
+
+err_drm_gem_object_put:
+	drm_gem_object_put(&obj->obj);
+	return ret;
 }
-- 
2.53.0

