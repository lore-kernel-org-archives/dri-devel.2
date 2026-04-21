Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32A4F8FA71
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 12:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CAA910EC53;
	Tue, 21 Apr 2026 12:57:42 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C446F10EC73
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 12:57:41 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A1F436A896;
 Tue, 21 Apr 2026 12:57:40 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A0A4593AF;
 Tue, 21 Apr 2026 12:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8ISnEER052labwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 21 Apr 2026 12:57:40 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
 jesszhan0024@gmail.com, sean@poorly.run, marijn.suijten@somainline.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/6] drm/msm: fbdev: Inline msm_alloc_stolen_fb()
Date: Tue, 21 Apr 2026 14:51:15 +0200
Message-ID: <20260421125733.209568-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421125733.209568-1-tzimmermann@suse.de>
References: <20260421125733.209568-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A1F436A896
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
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

Inline msm_alloc_stolen_fb() into its only caller. This is necessary
for converting fbdev emulation to use client buffers.

There are some minor changes:

- Handle errors for the non-stolen BO in the respective branch.

- Fill mode_cmd right before using it with msm_framebuffer_init(). Both
will later be replaced with client-buffer interfaces.

- Set the modifier[0] to DRM_FORMAT_MOD_LINEAR. No functional change.

- Integrate the error handling with the existing clean-up.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/msm/msm_drv.h   |  2 --
 drivers/gpu/drm/msm/msm_fb.c    | 46 ---------------------------------
 drivers/gpu/drm/msm/msm_fbdev.c | 44 +++++++++++++++++++++++++------
 3 files changed, 36 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index efc901c9d8c2..b3173fa4d222 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -266,8 +266,6 @@ struct drm_framebuffer *msm_framebuffer_init(struct drm_device *dev,
 struct drm_framebuffer *msm_framebuffer_create(struct drm_device *dev,
 		struct drm_file *file, const struct drm_format_info *info,
 		const struct drm_mode_fb_cmd2 *mode_cmd);
-struct drm_framebuffer * msm_alloc_stolen_fb(struct drm_device *dev,
-		int w, int h, int p, uint32_t format);
 
 #ifdef CONFIG_DRM_MSM_KMS_FBDEV
 int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index d7523a0a866a..dec550e6cf75 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -6,7 +6,6 @@
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_damage_helper.h>
-#include <drm/drm_file.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
@@ -248,48 +247,3 @@ struct drm_framebuffer *msm_framebuffer_create(struct drm_device *dev,
 		drm_gem_object_put(bos[i]);
 	return ERR_PTR(ret);
 }
-
-struct drm_framebuffer *
-msm_alloc_stolen_fb(struct drm_device *dev, int w, int h, int p, uint32_t format)
-{
-	struct drm_mode_fb_cmd2 mode_cmd = {
-		.pixel_format = format,
-		.width = w,
-		.height = h,
-		.pitches = { p },
-	};
-	struct drm_gem_object *bo;
-	struct drm_framebuffer *fb;
-	int size;
-
-	/* allocate backing bo */
-	size = mode_cmd.pitches[0] * mode_cmd.height;
-	DBG("allocating %d bytes for fb %d", size, dev->primary->index);
-	bo = msm_gem_new(dev, size, MSM_BO_SCANOUT | MSM_BO_WC | MSM_BO_STOLEN);
-	if (IS_ERR(bo)) {
-		dev_warn(dev->dev, "could not allocate stolen bo\n");
-		/* try regular bo: */
-		bo = msm_gem_new(dev, size, MSM_BO_SCANOUT | MSM_BO_WC);
-	}
-	if (IS_ERR(bo)) {
-		DRM_DEV_ERROR(dev->dev, "failed to allocate buffer object\n");
-		return ERR_CAST(bo);
-	}
-
-	msm_gem_object_set_name(bo, "stolenfb");
-
-	fb = msm_framebuffer_init(dev,
-				  drm_get_format_info(dev, mode_cmd.pixel_format,
-						      mode_cmd.modifier[0]),
-				  &mode_cmd, &bo);
-	if (IS_ERR(fb)) {
-		DRM_DEV_ERROR(dev->dev, "failed to allocate fb\n");
-		/* note: if fb creation failed, we can't rely on fb destroy
-		 * to unref the bo:
-		 */
-		drm_gem_object_put(bo);
-		return ERR_CAST(fb);
-	}
-
-	return fb;
-}
diff --git a/drivers/gpu/drm/msm/msm_fbdev.c b/drivers/gpu/drm/msm/msm_fbdev.c
index fd19995b12b5..a507f1de0c5d 100644
--- a/drivers/gpu/drm/msm/msm_fbdev.c
+++ b/drivers/gpu/drm/msm/msm_fbdev.c
@@ -9,6 +9,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_file.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_prime.h>
@@ -92,11 +93,13 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	struct drm_device *dev = helper->dev;
 	struct msm_drm_private *priv = dev->dev_private;
 	struct fb_info *fbi = helper->info;
+	struct drm_mode_fb_cmd2 mode_cmd = { };
 	struct drm_framebuffer *fb = NULL;
 	struct drm_gem_object *bo;
 	uint64_t paddr;
 	uint32_t format;
 	int ret, pitch;
+	int size;
 
 	format = drm_mode_legacy_fb_format(sizes->surface_bpp, sizes->surface_depth);
 
@@ -105,16 +108,39 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 			sizes->fb_width, sizes->fb_height);
 
 	pitch = align_pitch(sizes->surface_width, sizes->surface_bpp);
-	fb = msm_alloc_stolen_fb(dev, sizes->surface_width,
-			sizes->surface_height, pitch, format);
 
+	/* allocate backing bo */
+	size = pitch * sizes->surface_height;
+	DBG("allocating %d bytes for fb %d", size, dev->primary->index);
+	bo = msm_gem_new(dev, size, MSM_BO_SCANOUT | MSM_BO_WC | MSM_BO_STOLEN);
+	if (IS_ERR(bo)) {
+		dev_warn(dev->dev, "could not allocate stolen bo\n");
+		/* try regular bo: */
+		bo = msm_gem_new(dev, size, MSM_BO_SCANOUT | MSM_BO_WC);
+		if (IS_ERR(bo)) {
+			DRM_DEV_ERROR(dev->dev, "failed to allocate buffer object\n");
+			return PTR_ERR(bo);
+		}
+	}
+
+	msm_gem_object_set_name(bo, "stolenfb");
+
+	mode_cmd.pixel_format = format;
+	mode_cmd.width = sizes->surface_width;
+	mode_cmd.height = sizes->surface_height;
+	mode_cmd.pitches[0] = pitch;
+	mode_cmd.modifier[0] = DRM_FORMAT_MOD_LINEAR;
+
+	fb = msm_framebuffer_init(dev,
+				  drm_get_format_info(dev, mode_cmd.pixel_format,
+						      mode_cmd.modifier[0]),
+				  &mode_cmd, &bo);
 	if (IS_ERR(fb)) {
 		DRM_DEV_ERROR(dev->dev, "failed to allocate fb\n");
-		return PTR_ERR(fb);
+		ret = PTR_ERR(fb);
+		goto err_drm_gem_object_put;
 	}
 
-	bo = msm_framebuffer_bo(fb, 0);
-
 	/*
 	 * NOTE: if we can be guaranteed to be able to map buffer
 	 * in panic (ie. lock-safe, etc) we could avoid pinning the
@@ -123,7 +149,7 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	ret = msm_gem_get_and_pin_iova(bo, priv->kms->vm, &paddr);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "failed to get buffer obj iova: %d\n", ret);
-		goto fail;
+		goto err_drm_framebuffer_remove;
 	}
 
 	DBG("fbi=%p, dev=%p", fbi, dev);
@@ -138,7 +164,7 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	fbi->screen_buffer = msm_gem_get_vaddr(bo);
 	if (IS_ERR(fbi->screen_buffer)) {
 		ret = PTR_ERR(fbi->screen_buffer);
-		goto fail;
+		goto err_drm_framebuffer_remove;
 	}
 	fbi->screen_size = bo->size;
 	fbi->fix.smem_start = paddr;
@@ -149,7 +175,9 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 
 	return 0;
 
-fail:
+err_drm_framebuffer_remove:
 	drm_framebuffer_remove(fb);
+err_drm_gem_object_put:
+	drm_gem_object_put(bo);
 	return ret;
 }
-- 
2.53.0

