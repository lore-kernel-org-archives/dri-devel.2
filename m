Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7EDF36C5C
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:11:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BFE10E564;
	Mon, 20 Apr 2026 12:11:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="qlTqom0T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YHLQKoTY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qlTqom0T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YHLQKoTY";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2760610E564
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:11:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1EA296A8E0;
 Mon, 20 Apr 2026 12:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776687096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OGzj7s/WhrXRB43HZ6ZVzUP3xx+VnUM5Q8QMX4gc5A=;
 b=qlTqom0TU6E8ko6p5mvUBkxnboSKbUclplH44QmPENqLaACU2f1uuSNbeAz5OpYTm7FicX
 xTDzht2Bk7ebVPKHz/cuzXkm2x2UE/eGecgKtMFGVY1pHuZhcLjU/JWRvRsF5GPgLXjZHr
 a2bYvvtf/Xk7ywXUg33pGj2boLUE9Bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776687096;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OGzj7s/WhrXRB43HZ6ZVzUP3xx+VnUM5Q8QMX4gc5A=;
 b=YHLQKoTY0IMQZtZrPlW7Xpi0Yp1KkXqgGf8L7+g891yMM2Sa10mdzCQ8+bEoqhrrZs7URo
 7GXWwpn/YzO9vsAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776687096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OGzj7s/WhrXRB43HZ6ZVzUP3xx+VnUM5Q8QMX4gc5A=;
 b=qlTqom0TU6E8ko6p5mvUBkxnboSKbUclplH44QmPENqLaACU2f1uuSNbeAz5OpYTm7FicX
 xTDzht2Bk7ebVPKHz/cuzXkm2x2UE/eGecgKtMFGVY1pHuZhcLjU/JWRvRsF5GPgLXjZHr
 a2bYvvtf/Xk7ywXUg33pGj2boLUE9Bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776687096;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OGzj7s/WhrXRB43HZ6ZVzUP3xx+VnUM5Q8QMX4gc5A=;
 b=YHLQKoTY0IMQZtZrPlW7Xpi0Yp1KkXqgGf8L7+g891yMM2Sa10mdzCQ8+bEoqhrrZs7URo
 7GXWwpn/YzO9vsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B77F7593B1;
 Mon, 20 Apr 2026 12:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MPlfK/cX5mkGZQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 20 Apr 2026 12:11:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
 kong.kongxinwei@hisilicon.com, sumit.semwal@linaro.org,
 yongqin.liu@linaro.org, jstultz@google.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 4/4] drm/hibmc: Use gem-shmem with shadow-plane helpers for
 memory management
Date: Mon, 20 Apr 2026 14:10:00 +0200
Message-ID: <20260420121130.200133-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420121130.200133-1-tzimmermann@suse.de>
References: <20260420121130.200133-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[12]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[linaro.org,hisilicon.com,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
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

Replace the gem-vram memory manager with gem-shmem. Makes the driver more
robust and enables dma-buf sharing with other hardware.

Gem-vram was created from various drivers that used TTM for their memory
management. All these drivers have meanwhile been converted to gem-shmem.
Using gem-vram is deprecated because it has several problems.

* TTM requires significant overcommitment of video memory for reliable
page flips. There needs to be 3 times the size of the largest possible
framebuffer available or page flips can fail. This leaves the display
dark without further warning. Hibmc hardware with 32 MiB and a maximum
framebuffer size of 1920x2000 is at the limit.

* No dma-buf sharing without GTT support. Neither gem-vram nor hibmc
hardware support a GTT address space. This is required to share buffers
with other devices via dma-buf interfaces.

* TTM requires hardware-accelerated rendering into video memory for
optimal results. As hibmc hardware cannot do this, hibmc renders in
system memory and copies the result to video memory. This can be more
effectively implemented with gem-shmem and DRM's shadow-plane helpers.

Converting hibmc to gem-shmem and shadow-plane helpers.

* Replace gem-vram entry points in struct drm_driver with gem-shmem
equivalents. This makes the driver allocate struct drm_gem_shmem_object
for its buffers.

* Use DRM_GEM_SHADOW_*_PLANE for its plane funcs and plane-helper
funcs. The shadow-plane helpers map a plane's gem buffer objects into
kernel address space during a page flip, so that atomic_update can
copy them to video memory.

* Handle framebuffer damage in hibmc_plane_atomic_update(). This updates
video memory from the plane's framebuffer. It automatically synchronizes
shared buffers with other devices. Create the framebuffer with
drm_gem_fb_create_with_dirty() to trigger the update on each page flip.

* Initialize the plane with drm_plane_enable_fb_damage_clips() to limit
the damage updates to the framebuffer areas that changed. We don't want
to do a full-buffer memcpy if only a small area has changed.

* Test display modes against the available video memory in
hibmc_mode_config_mode_valid(). We only want to announce display modes
that fit into display memory.

* Map the display memory itself into kernel address space.

* Do not set drm_mode_config.prefer_shadow. This would advise user space
to install a shadow buffer. But with gem-shmem, the gem buffer object
already acts as a shadow buffer for video memory.

We use these patterns in many other drivers with similar limitation as
hibmc and its hardware. With these changes in place, hibmc is more robust
and better integrated into the overall DRM framework.

v2:
- do not select TTM symbols

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c        | 17 ++++-
 drivers/gpu/drm/hisilicon/hibmc/Kconfig       |  4 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 42 ++++++++-----
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 62 ++++++++++++++-----
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  5 ++
 include/drm/drm_gem_shmem_helper.h            |  5 ++
 6 files changed, 101 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 545933c7f712..c651245f8e91 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -453,7 +453,21 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 }
 EXPORT_SYMBOL_GPL(drm_gem_shmem_vunmap_locked);
 
-static int
+/**
+ * drm_gem_shmem_create_with_handle - Allocate an object with the given size and
+ *	returns a GEM handle
+ * @file_priv: DRM file structure to create the dumb buffer for
+ * @dev: DRM device
+ * @size: Size of the object to allocate
+ * @handle: Returns the GEM handle on success
+ *
+ * Allocates an shmem GEM buffer using drm_gem_shmem_create() and returns
+ * a GEM handle to it.
+ *
+ * Returns:
+ * Zero on success, or an error code otherwise.
+ */
+int
 drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
 				 struct drm_device *dev, size_t size,
 				 uint32_t *handle)
@@ -475,6 +489,7 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(drm_gem_shmem_create_with_handle);
 
 /* Update madvise status, returns true if not purged, else
  * false or -errno.
diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
index d1f3f5793f34..adf4516bf8f6 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
+++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
@@ -5,10 +5,8 @@ config DRM_HISI_HIBMC
 	select DRM_CLIENT_SELECTION
 	select DRM_DISPLAY_HELPER
 	select DRM_DISPLAY_DP_HELPER
+	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
-	select DRM_VRAM_HELPER
-	select DRM_TTM
-	select DRM_TTM_HELPER
 	select I2C
 	select I2C_ALGOBIT
 	help
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 20ab933b0f12..fd3f05ba62df 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -15,8 +15,10 @@
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_damage_helper.h>
 #include <drm/drm_fourcc.h>
-#include <drm/drm_gem_vram_helper.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_vblank.h>
 
 #include "hibmc_drm_drv.h"
@@ -83,28 +85,41 @@ static int hibmc_plane_atomic_check(struct drm_plane *plane,
 static void hibmc_plane_atomic_update(struct drm_plane *plane,
 				      struct drm_atomic_state *state)
 {
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(plane->dev);
 	struct drm_plane_state *new_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(new_state);
 	struct drm_framebuffer *fb = new_state->fb;
+	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state, plane);
+	u32 gpu_addr = 0;
 	u32 reg;
-	s64 gpu_addr = 0;
 	u32 line_l;
-	struct hibmc_drm_private *priv = to_hibmc_drm_private(plane->dev);
-	struct drm_gem_vram_object *gbo;
 
-	if (!new_state->fb)
+	if (!fb)
 		return;
 
-	gbo = drm_gem_vram_of_gem(new_state->fb->obj[0]);
+	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE) == 0) {
+		struct drm_rect damage;
+		struct drm_atomic_helper_damage_iter iter;
+
+		drm_atomic_helper_damage_iter_init(&iter, old_state, new_state);
+		drm_atomic_for_each_plane_damage(&iter, &damage) {
+			struct iosys_map dst[DRM_FORMAT_MAX_PLANES] = {
+				IOSYS_MAP_INIT_VADDR_IOMEM(priv->vram + gpu_addr),
+			};
 
-	gpu_addr = drm_gem_vram_offset(gbo);
-	if (WARN_ON_ONCE(gpu_addr < 0))
-		return; /* Bug: we didn't pin the BO to VRAM in prepare_fb. */
+			iosys_map_incr(&dst[0],
+				       drm_fb_clip_offset(fb->pitches[0], fb->format, &damage));
+			drm_fb_memcpy(dst, fb->pitches, shadow_plane_state->data, fb, &damage);
+		}
+
+		drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
+	}
 
 	writel(gpu_addr, priv->mmio + HIBMC_CRT_FB_ADDRESS);
 
 	reg = drm_format_info_min_pitch(fb->format, 0, fb->width);
 
-	line_l = new_state->fb->pitches[0];
+	line_l = fb->pitches[0];
 	writel(HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_WIDTH, reg) |
 	       HIBMC_FIELD(HIBMC_CRT_FB_WIDTH_OFFS, line_l),
 	       priv->mmio + HIBMC_CRT_FB_WIDTH);
@@ -132,13 +147,11 @@ static const struct drm_plane_funcs hibmc_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
 	.destroy = drm_plane_cleanup,
-	.reset = drm_atomic_helper_plane_reset,
-	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
 };
 
 static const struct drm_plane_helper_funcs hibmc_plane_helper_funcs = {
-	DRM_GEM_VRAM_PLANE_HELPER_FUNCS,
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS,
 	.atomic_check = hibmc_plane_atomic_check,
 	.atomic_update = hibmc_plane_atomic_update,
 };
@@ -505,6 +518,7 @@ int hibmc_de_init(struct hibmc_drm_private *priv)
 	}
 
 	drm_plane_helper_add(plane, &hibmc_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(plane);
 
 	ret = drm_crtc_init_with_planes(dev, crtc, plane,
 					NULL, &hibmc_crtc_funcs, NULL);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 289304500ab0..a0ecf82b576f 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -18,9 +18,10 @@
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
-#include <drm/drm_fbdev_ttm.h>
+#include <drm/drm_dumb_buffers.h>
+#include <drm/drm_fbdev_shmem.h>
 #include <drm/drm_gem_framebuffer_helper.h>
-#include <drm/drm_gem_vram_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_module.h>
 #include <drm/drm_vblank.h>
@@ -70,7 +71,13 @@ static irqreturn_t hibmc_dp_interrupt(int irq, void *arg)
 static int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
 			     struct drm_mode_create_dumb *args)
 {
-	return drm_gem_vram_fill_create_dumb(file, dev, 0, 128, args);
+	int ret;
+
+	ret = drm_mode_size_dumb(dev, args, SZ_128, 0);
+	if (ret)
+		return ret;
+
+	return drm_gem_shmem_create_with_handle(file, dev, args->size, &args->handle);
 }
 
 static const struct drm_driver hibmc_driver = {
@@ -80,10 +87,9 @@ static const struct drm_driver hibmc_driver = {
 	.desc			= "hibmc drm driver",
 	.major			= 1,
 	.minor			= 0,
-	.debugfs_init		= drm_vram_mm_debugfs_init,
-	.dumb_create            = hibmc_dumb_create,
-	.dumb_map_offset        = drm_gem_ttm_dumb_map_offset,
-	DRM_FBDEV_TTM_DRIVER_OPS,
+	.gem_prime_import	= drm_gem_shmem_prime_import_no_map,
+	.dumb_create		= hibmc_dumb_create,
+	DRM_FBDEV_SHMEM_DRIVER_OPS,
 };
 
 static int __maybe_unused hibmc_pm_suspend(struct device *dev)
@@ -105,11 +111,32 @@ static const struct dev_pm_ops hibmc_pm_ops = {
 				hibmc_pm_resume)
 };
 
+static enum drm_mode_status hibmc_mode_config_mode_valid(struct drm_device *dev,
+							 const struct drm_display_mode *mode)
+{
+	const struct drm_format_info *info =
+		drm_get_format_info(dev, DRM_FORMAT_XRGB8888, DRM_FORMAT_MOD_LINEAR);
+	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
+	unsigned long max_fb_size = priv->vram_size;
+	u64 pitch;
+
+	if (drm_WARN_ON_ONCE(dev, !info))
+		return MODE_ERROR; /* driver bug */
+
+	pitch = drm_format_info_min_pitch(info, 0, mode->hdisplay);
+	if (!pitch)
+		return MODE_BAD_WIDTH;
+	else if (pitch > max_fb_size / mode->vdisplay)
+		return MODE_MEM;
+
+	return MODE_OK;
+}
+
 static const struct drm_mode_config_funcs hibmc_mode_funcs = {
-	.mode_valid = drm_vram_helper_mode_valid,
+	.mode_valid = hibmc_mode_config_mode_valid,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
-	.fb_create = drm_gem_fb_create,
+	.fb_create = drm_gem_fb_create_with_dirty,
 };
 
 static int hibmc_kms_init(struct hibmc_drm_private *priv)
@@ -129,7 +156,6 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
 	dev->mode_config.max_height = 1200;
 
 	dev->mode_config.preferred_depth = 24;
-	dev->mode_config.prefer_shadow = 1;
 
 	dev->mode_config.funcs = (void *)&hibmc_mode_funcs;
 
@@ -323,18 +349,22 @@ static int hibmc_load(struct drm_device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
+	resource_size_t vram_base, vram_size;
 	int ret;
 
 	ret = hibmc_hw_init(priv);
 	if (ret)
 		return ret;
 
-	ret = drmm_vram_helper_init(dev, pci_resource_start(pdev, 0),
-				    pci_resource_len(pdev, 0));
-	if (ret) {
-		drm_err(dev, "Error initializing VRAM MM; %d\n", ret);
-		return ret;
-	}
+	vram_base = pci_resource_start(pdev, 0);
+	vram_size = pci_resource_len(pdev, 0);
+
+	priv->vram = devm_ioremap_wc(dev->dev, vram_base, vram_size);
+	if (!priv->vram)
+		return -ENOMEM;
+
+	priv->vram_base = vram_base;
+	priv->vram_size = vram_size;
 
 	ret = hibmc_kms_init(priv);
 	if (ret)
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index ca8502e2760c..4e212af6143d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -37,6 +37,11 @@ struct hibmc_drm_private {
 	/* hw */
 	void __iomem   *mmio;
 
+	/* vram */
+	void __iomem *vram;
+	resource_size_t	vram_base;
+	resource_size_t	vram_size;
+
 	/* drm */
 	struct drm_device dev;
 	struct drm_plane primary_plane;
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 5ccdae21b94a..8167a1d6f997 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -141,6 +141,11 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_shmem_object *shmem)
 void drm_gem_shmem_print_info(const struct drm_gem_shmem_object *shmem,
 			      struct drm_printer *p, unsigned int indent);
 
+int
+drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
+				 struct drm_device *dev, size_t size,
+				 uint32_t *handle);
+
 extern const struct vm_operations_struct drm_gem_shmem_vm_ops;
 
 /*
-- 
2.53.0

