Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07361F589DB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 14:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65C4810F166;
	Thu, 23 Apr 2026 14:00:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="WMxFJG3D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bmmkAC6s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WMxFJG3D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bmmkAC6s";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C3BA10F149
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 14:00:40 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 304C96A85A;
 Thu, 23 Apr 2026 14:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776952835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8dVaETatJVLArWMUP7auTbML4SVMi1JDtfiBL8z6YQ=;
 b=WMxFJG3DEXhrjf4+GH0lSVM114ioOFEusU1DDYN/yeOcWEs9MQYWIh4b9q2Xx4OvchQtwW
 nHdUycXOgGF/lMDnSSYf++iuXjbzArttlJ96JYsknT0FokNWYyACl3uGxdIvvE/FIOVf3a
 Z33gcZ8AGzgezJkYB9bMc+9YYM2kUDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776952835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8dVaETatJVLArWMUP7auTbML4SVMi1JDtfiBL8z6YQ=;
 b=bmmkAC6sdyGO3EH7S0a6jGC1mKXGvWbV5ir8e2xvPTAjNBX5eMX3tXiD3kgwm+5Ugs2WHi
 vznFkO2tykT5dSBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776952835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8dVaETatJVLArWMUP7auTbML4SVMi1JDtfiBL8z6YQ=;
 b=WMxFJG3DEXhrjf4+GH0lSVM114ioOFEusU1DDYN/yeOcWEs9MQYWIh4b9q2Xx4OvchQtwW
 nHdUycXOgGF/lMDnSSYf++iuXjbzArttlJ96JYsknT0FokNWYyACl3uGxdIvvE/FIOVf3a
 Z33gcZ8AGzgezJkYB9bMc+9YYM2kUDM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776952835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/8dVaETatJVLArWMUP7auTbML4SVMi1JDtfiBL8z6YQ=;
 b=bmmkAC6sdyGO3EH7S0a6jGC1mKXGvWbV5ir8e2xvPTAjNBX5eMX3tXiD3kgwm+5Ugs2WHi
 vznFkO2tykT5dSBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1452593B0;
 Thu, 23 Apr 2026 14:00:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oLaXOQIm6mlCTwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 14:00:34 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: tomi.valkeinen@ideasonboard.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/3] drm/omapdrm: fbdev: Calculate buffer geometry with format
 helpers
Date: Thu, 23 Apr 2026 15:58:07 +0200
Message-ID: <20260423140031.126072-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423140031.126072-1-tzimmermann@suse.de>
References: <20260423140031.126072-1-tzimmermann@suse.de>
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
 FREEMAIL_TO(0.00)[ideasonboard.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[7]; TO_DN_SOME(0.00)[];
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

Replace the geometry and size calculation in omapdrm's fbdev emulation
with DRM format helpers. This consists of a 4CC lookup from the fbdev
parameters, format lookup, pitch calculation and size calculation.

Then allocate the GEM buffer object for the framebuffer memory from
the calculated size. Mmap provides the allocated buffer to user space,
so align the buffer size to PAGE_SIZE.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/omapdrm/omap_fbdev.c | 42 ++++++++++++++++------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
index ca3fb186bf19..f1044d8d1a85 100644
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/fb.h>
+#include <linux/overflow.h>
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_drv.h>
@@ -155,6 +156,9 @@ int omap_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	struct omap_drm_private *priv = dev->dev_private;
 	struct omap_fbdev *fbdev = priv->fbdev;
 	struct fb_info *fbi = helper->info;
+	u32 fourcc;
+	u64 pitch, size;
+	const struct drm_format_info *format;
 	struct drm_framebuffer *fb = NULL;
 	union omap_gem_size gsize;
 	struct drm_mode_fb_cmd2 mode_cmd = {0};
@@ -169,24 +173,24 @@ int omap_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 			sizes->surface_height, sizes->surface_bpp,
 			sizes->fb_width, sizes->fb_height);
 
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-			sizes->surface_depth);
-
-	mode_cmd.width = sizes->surface_width;
-	mode_cmd.height = sizes->surface_height;
-
-	mode_cmd.pitches[0] =
-			DIV_ROUND_UP(mode_cmd.width * sizes->surface_bpp, 8);
-
 	fbdev->ywrap_enabled = priv->has_dmm && ywrap_enabled;
-	if (fbdev->ywrap_enabled) {
-		/* need to align pitch to page size if using DMM scrolling */
-		mode_cmd.pitches[0] = PAGE_ALIGN(mode_cmd.pitches[0]);
-	}
+
+	fourcc = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
+	format = drm_get_format_info(dev, fourcc, DRM_FORMAT_MOD_LINEAR);
+	if (!format)
+		return -EINVAL;
+	pitch = drm_format_info_min_pitch(format, 0, sizes->surface_width);
+	if (!pitch)
+		return -EINVAL;
+	if (fbdev->ywrap_enabled)
+		pitch = PAGE_ALIGN(pitch); /* required if using DMM scrolling */
+	if (check_mul_overflow(pitch, sizes->surface_height, &size))
+		return -EINVAL;
+	size = PAGE_ALIGN(size);
 
 	/* allocate backing bo */
 	gsize = (union omap_gem_size){
-		.bytes = PAGE_ALIGN(mode_cmd.pitches[0] * mode_cmd.height),
+		.bytes = size,
 	};
 	DBG("allocating %d bytes for fb %d", gsize.bytes, dev->primary->index);
 	bo = omap_gem_new(dev, gsize, OMAP_BO_SCANOUT | OMAP_BO_WC);
@@ -196,10 +200,12 @@ int omap_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 		goto fail;
 	}
 
-	fb = omap_framebuffer_init(dev,
-				   drm_get_format_info(dev, mode_cmd.pixel_format,
-						       mode_cmd.modifier[0]),
-				   &mode_cmd, &bo);
+	mode_cmd.pixel_format = fourcc;
+	mode_cmd.width = sizes->surface_width;
+	mode_cmd.height = sizes->surface_height;
+	mode_cmd.pitches[0] = pitch;
+
+	fb = omap_framebuffer_init(dev, format,  &mode_cmd, &bo);
 	if (IS_ERR(fb)) {
 		dev_err(dev->dev, "failed to allocate fb\n");
 		/* note: if fb creation failed, we can't rely on fb destroy
-- 
2.53.0

