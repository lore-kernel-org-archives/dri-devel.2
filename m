Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA1D109024A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9F9210E8F9;
	Thu, 19 Mar 2026 16:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="uEJ2x2n5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dHtmyJ5/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uEJ2x2n5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dHtmyJ5/";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A54F10E8F9
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:01:44 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 162EC4D302;
 Thu, 19 Mar 2026 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtFuh3/ljJJr1gbNx08Aa05be3K17xyLRh1hQ7TQ/30=;
 b=uEJ2x2n52IbPWf2KvKoEMeUYMc7dv7jQfm0hnFsu5PCb2V5LklBWm+xq9+mZg689AHTlhO
 7fQrZewGLiMB8cnYTKEEQaZI7GpuyzKWZKsvUKptkr4qS2yTuTxrDMjSI4cqrhOBAVtAdn
 nXvD1O8USGAxFF+FMMLjBsoG5muii7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtFuh3/ljJJr1gbNx08Aa05be3K17xyLRh1hQ7TQ/30=;
 b=dHtmyJ5/Euj+dZjWfKXJ6Je9Ac/R8oV5+vZmxxzglgt5RRAI0Gizv//eZ7jOLslrrUNle5
 3pFcQEcgRmrdWQBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtFuh3/ljJJr1gbNx08Aa05be3K17xyLRh1hQ7TQ/30=;
 b=uEJ2x2n52IbPWf2KvKoEMeUYMc7dv7jQfm0hnFsu5PCb2V5LklBWm+xq9+mZg689AHTlhO
 7fQrZewGLiMB8cnYTKEEQaZI7GpuyzKWZKsvUKptkr4qS2yTuTxrDMjSI4cqrhOBAVtAdn
 nXvD1O8USGAxFF+FMMLjBsoG5muii7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EtFuh3/ljJJr1gbNx08Aa05be3K17xyLRh1hQ7TQ/30=;
 b=dHtmyJ5/Euj+dZjWfKXJ6Je9Ac/R8oV5+vZmxxzglgt5RRAI0Gizv//eZ7jOLslrrUNle5
 3pFcQEcgRmrdWQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8502142766;
 Thu, 19 Mar 2026 16:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +BhDH88dvGn0WQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Mar 2026 16:01:19 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 15/16] drm/mipi-dbi: Remove simple-display helpers from
 mipi-dbi
Date: Thu, 19 Mar 2026 16:59:51 +0100
Message-ID: <20260319160110.109610-16-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319160110.109610-1-tzimmermann@suse.de>
References: <20260319160110.109610-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
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

With the conversion to regular atomic helpers, mipi-dbi's support
for simple-display helpers is unused. Removed it.

v2:
- remove unused connector from struct mipi_dbi_dev

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 247 ---------------------------------
 include/drm/drm_mipi_dbi.h     |  54 -------
 2 files changed, 301 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index 0374fd0c527d..9ab6113d74a2 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -15,7 +15,6 @@
 #include <linux/spi/spi.h>
 
 #include <drm/drm_atomic.h>
-#include <drm/drm_connector.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
@@ -332,22 +331,6 @@ enum drm_mode_status drm_mipi_dbi_crtc_helper_mode_valid(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_mipi_dbi_crtc_helper_mode_valid);
 
-/**
- * mipi_dbi_pipe_mode_valid - MIPI DBI mode-valid helper
- * @pipe: Simple display pipe
- * @mode: The mode to test
- *
- * This function validates a given display mode against the MIPI DBI's hardware
- * display. Drivers can use this as their &drm_simple_display_pipe_funcs->mode_valid
- * callback.
- */
-enum drm_mode_status mipi_dbi_pipe_mode_valid(struct drm_simple_display_pipe *pipe,
-					      const struct drm_display_mode *mode)
-{
-	return drm_mipi_dbi_crtc_helper_mode_valid(&pipe->crtc, mode);
-}
-EXPORT_SYMBOL(mipi_dbi_pipe_mode_valid);
-
 /**
  * drm_mipi_dbi_plane_helper_atomic_check - MIPI DBI plane check helper
  * @plane: Plane to check
@@ -413,21 +396,6 @@ void drm_mipi_dbi_plane_helper_atomic_update(struct drm_plane *plane,
 }
 EXPORT_SYMBOL(drm_mipi_dbi_plane_helper_atomic_update);
 
-/**
- * mipi_dbi_pipe_update - Display pipe update helper
- * @pipe: Simple display pipe
- * @old_state: Old plane state
- *
- * This function handles framebuffer flushing and vblank events. Drivers can use
- * this as their &drm_simple_display_pipe_funcs->update callback.
- */
-void mipi_dbi_pipe_update(struct drm_simple_display_pipe *pipe,
-			  struct drm_plane_state *old_state)
-{
-	return drm_mipi_dbi_plane_helper_atomic_update(&pipe->plane, old_state->state);
-}
-EXPORT_SYMBOL(mipi_dbi_pipe_update);
-
 static void mipi_dbi_blank(struct mipi_dbi_dev *dbidev)
 {
 	struct drm_device *drm = &dbidev->drm;
@@ -509,104 +477,6 @@ void drm_mipi_dbi_crtc_helper_atomic_disable(struct drm_crtc *crtc,
 }
 EXPORT_SYMBOL(drm_mipi_dbi_crtc_helper_atomic_disable);
 
-/**
- * mipi_dbi_pipe_disable - MIPI DBI pipe disable helper
- * @pipe: Display pipe
- *
- * This function disables backlight if present, if not the display memory is
- * blanked. The regulator is disabled if in use. Drivers can use this as their
- * &drm_simple_display_pipe_funcs->disable callback.
- */
-void mipi_dbi_pipe_disable(struct drm_simple_display_pipe *pipe)
-{
-	drm_mipi_dbi_crtc_helper_atomic_disable(&pipe->crtc, pipe->crtc.state->state);
-}
-EXPORT_SYMBOL(mipi_dbi_pipe_disable);
-
-/**
- * mipi_dbi_pipe_begin_fb_access - MIPI DBI pipe begin-access helper
- * @pipe: Display pipe
- * @plane_state: Plane state
- *
- * This function implements struct &drm_simple_display_funcs.begin_fb_access.
- *
- * See drm_gem_begin_shadow_fb_access() for details and mipi_dbi_pipe_cleanup_fb()
- * for cleanup.
- *
- * Returns:
- * 0 on success, or a negative errno code otherwise.
- */
-int mipi_dbi_pipe_begin_fb_access(struct drm_simple_display_pipe *pipe,
-				  struct drm_plane_state *plane_state)
-{
-	return drm_gem_begin_shadow_fb_access(&pipe->plane, plane_state);
-}
-EXPORT_SYMBOL(mipi_dbi_pipe_begin_fb_access);
-
-/**
- * mipi_dbi_pipe_end_fb_access - MIPI DBI pipe end-access helper
- * @pipe: Display pipe
- * @plane_state: Plane state
- *
- * This function implements struct &drm_simple_display_funcs.end_fb_access.
- *
- * See mipi_dbi_pipe_begin_fb_access().
- */
-void mipi_dbi_pipe_end_fb_access(struct drm_simple_display_pipe *pipe,
-				 struct drm_plane_state *plane_state)
-{
-	drm_gem_end_shadow_fb_access(&pipe->plane, plane_state);
-}
-EXPORT_SYMBOL(mipi_dbi_pipe_end_fb_access);
-
-/**
- * mipi_dbi_pipe_reset_plane - MIPI DBI plane-reset helper
- * @pipe: Display pipe
- *
- * This function implements struct &drm_simple_display_funcs.reset_plane
- * for MIPI DBI planes.
- */
-void mipi_dbi_pipe_reset_plane(struct drm_simple_display_pipe *pipe)
-{
-	drm_gem_reset_shadow_plane(&pipe->plane);
-}
-EXPORT_SYMBOL(mipi_dbi_pipe_reset_plane);
-
-/**
- * mipi_dbi_pipe_duplicate_plane_state - duplicates MIPI DBI plane state
- * @pipe: Display pipe
- *
- * This function implements struct &drm_simple_display_funcs.duplicate_plane_state
- * for MIPI DBI planes.
- *
- * See drm_gem_duplicate_shadow_plane_state() for additional details.
- *
- * Returns:
- * A pointer to a new plane state on success, or NULL otherwise.
- */
-struct drm_plane_state *mipi_dbi_pipe_duplicate_plane_state(struct drm_simple_display_pipe *pipe)
-{
-	return drm_gem_duplicate_shadow_plane_state(&pipe->plane);
-}
-EXPORT_SYMBOL(mipi_dbi_pipe_duplicate_plane_state);
-
-/**
- * mipi_dbi_pipe_destroy_plane_state - cleans up MIPI DBI plane state
- * @pipe: Display pipe
- * @plane_state: Plane state
- *
- * This function implements struct drm_simple_display_funcs.destroy_plane_state
- * for MIPI DBI planes.
- *
- * See drm_gem_destroy_shadow_plane_state() for additional details.
- */
-void mipi_dbi_pipe_destroy_plane_state(struct drm_simple_display_pipe *pipe,
-				       struct drm_plane_state *plane_state)
-{
-	drm_gem_destroy_shadow_plane_state(&pipe->plane, plane_state);
-}
-EXPORT_SYMBOL(mipi_dbi_pipe_destroy_plane_state);
-
 /**
  * drm_mipi_dbi_connector_helper_get_modes - Duplicates the MIPI DBI mode for the connector
  * @connector: The connector
@@ -626,15 +496,6 @@ int drm_mipi_dbi_connector_helper_get_modes(struct drm_connector *connector)
 }
 EXPORT_SYMBOL(drm_mipi_dbi_connector_helper_get_modes);
 
-static const struct drm_connector_helper_funcs mipi_dbi_connector_hfuncs = {
-	DRM_MIPI_DBI_CONNECTOR_HELPER_FUNCS,
-};
-
-static const struct drm_connector_funcs mipi_dbi_connector_funcs = {
-	DRM_MIPI_DBI_CONNECTOR_FUNCS,
-	.destroy = drm_connector_cleanup,
-};
-
 static int mipi_dbi_rotate_mode(struct drm_display_mode *mode,
 				unsigned int rotation)
 {
@@ -652,18 +513,6 @@ static int mipi_dbi_rotate_mode(struct drm_display_mode *mode,
 	}
 }
 
-static const struct drm_mode_config_helper_funcs mipi_dbi_mode_config_helper_funcs = {
-	DRM_MIPI_DBI_MODE_CONFIG_HELPER_FUNCS,
-};
-
-static const struct drm_mode_config_funcs mipi_dbi_mode_config_funcs = {
-	DRM_MIPI_DBI_MODE_CONFIG_FUNCS,
-};
-
-static const uint32_t mipi_dbi_formats[] = {
-	DRM_MIPI_DBI_PLANE_FORMATS,
-};
-
 /**
  * drm_mipi_dbi_dev_init - MIPI DBI device initialization
  * @dbidev: MIPI DBI device structure to initialize
@@ -717,102 +566,6 @@ int drm_mipi_dbi_dev_init(struct mipi_dbi_dev *dbidev, const struct drm_display_
 }
 EXPORT_SYMBOL(drm_mipi_dbi_dev_init);
 
-/**
- * mipi_dbi_dev_init_with_formats - MIPI DBI device initialization with custom formats
- * @dbidev: MIPI DBI device structure to initialize
- * @funcs: Display pipe functions
- * @formats: Array of supported formats (DRM_FORMAT\_\*).
- * @format_count: Number of elements in @formats
- * @mode: Display mode
- * @rotation: Initial rotation in degrees Counter Clock Wise
- * @tx_buf_size: Allocate a transmit buffer of this size.
- *
- * This function sets up a &drm_simple_display_pipe with a &drm_connector that
- * has one fixed &drm_display_mode which is rotated according to @rotation.
- * This mode is used to set the mode config min/max width/height properties.
- *
- * Use mipi_dbi_dev_init() if you want native RGB565 and emulated XRGB8888 format.
- *
- * Note:
- * Some of the helper functions expects RGB565 to be the default format and the
- * transmit buffer sized to fit that.
- *
- * Returns:
- * Zero on success, negative error code on failure.
- */
-int mipi_dbi_dev_init_with_formats(struct mipi_dbi_dev *dbidev,
-				   const struct drm_simple_display_pipe_funcs *funcs,
-				   const uint32_t *formats, unsigned int format_count,
-				   const struct drm_display_mode *mode,
-				   unsigned int rotation, size_t tx_buf_size)
-{
-	static const uint64_t modifiers[] = {
-		DRM_MIPI_DBI_PLANE_FORMAT_MODIFIERS,
-	};
-	struct drm_device *drm = &dbidev->drm;
-	int ret;
-
-	ret = drm_mipi_dbi_dev_init(dbidev, mode, formats[0], rotation, tx_buf_size);
-	if (ret)
-		return ret;
-
-	ret = drmm_mode_config_init(drm);
-	if (ret)
-		return ret;
-
-	drm_connector_helper_add(&dbidev->connector, &mipi_dbi_connector_hfuncs);
-	ret = drm_connector_init(drm, &dbidev->connector, &mipi_dbi_connector_funcs,
-				 DRM_MODE_CONNECTOR_SPI);
-	if (ret)
-		return ret;
-
-	ret = drm_simple_display_pipe_init(drm, &dbidev->pipe, funcs, formats, format_count,
-					   modifiers, &dbidev->connector);
-	if (ret)
-		return ret;
-
-	drm_plane_enable_fb_damage_clips(&dbidev->pipe.plane);
-
-	drm->mode_config.funcs = &mipi_dbi_mode_config_funcs;
-	drm->mode_config.min_width = dbidev->mode.hdisplay;
-	drm->mode_config.max_width = dbidev->mode.hdisplay;
-	drm->mode_config.min_height = dbidev->mode.vdisplay;
-	drm->mode_config.max_height = dbidev->mode.vdisplay;
-	drm->mode_config.helper_private = &mipi_dbi_mode_config_helper_funcs;
-
-	return 0;
-}
-EXPORT_SYMBOL(mipi_dbi_dev_init_with_formats);
-
-/**
- * mipi_dbi_dev_init - MIPI DBI device initialization
- * @dbidev: MIPI DBI device structure to initialize
- * @funcs: Display pipe functions
- * @mode: Display mode
- * @rotation: Initial rotation in degrees Counter Clock Wise
- *
- * This function sets up a &drm_simple_display_pipe with a &drm_connector that
- * has one fixed &drm_display_mode which is rotated according to @rotation.
- * This mode is used to set the mode config min/max width/height properties.
- * Additionally &mipi_dbi.tx_buf is allocated.
- *
- * Supported formats: Native RGB565 and emulated XRGB8888.
- *
- * Returns:
- * Zero on success, negative error code on failure.
- */
-int mipi_dbi_dev_init(struct mipi_dbi_dev *dbidev,
-		      const struct drm_simple_display_pipe_funcs *funcs,
-		      const struct drm_display_mode *mode, unsigned int rotation)
-{
-	dbidev->drm.mode_config.preferred_depth = 16;
-
-	return mipi_dbi_dev_init_with_formats(dbidev, funcs, mipi_dbi_formats,
-					      ARRAY_SIZE(mipi_dbi_formats), mode,
-					      rotation, 0);
-}
-EXPORT_SYMBOL(mipi_dbi_dev_init);
-
 /**
  * mipi_dbi_hw_reset - Hardware reset of controller
  * @dbi: MIPI DBI structure
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index ae92a5e8d13b..07374eb5d88e 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -15,7 +15,6 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 struct drm_format_conv_state;
 struct drm_rect;
@@ -91,16 +90,6 @@ struct mipi_dbi_dev {
 	 */
 	struct drm_device drm;
 
-	/**
-	 * @pipe: Display pipe structure
-	 */
-	struct drm_simple_display_pipe pipe;
-
-	/**
-	 * @connector: Connector
-	 */
-	struct drm_connector connector;
-
 	/**
 	 * @mode: Fixed display mode
 	 */
@@ -173,28 +162,6 @@ int mipi_dbi_spi_init(struct spi_device *spi, struct mipi_dbi *dbi,
 int drm_mipi_dbi_dev_init(struct mipi_dbi_dev *dbidev, const struct drm_display_mode *mode,
 			  u32 format, unsigned int rotation, size_t tx_buf_size);
 
-int mipi_dbi_dev_init_with_formats(struct mipi_dbi_dev *dbidev,
-				   const struct drm_simple_display_pipe_funcs *funcs,
-				   const uint32_t *formats, unsigned int format_count,
-				   const struct drm_display_mode *mode,
-				   unsigned int rotation, size_t tx_buf_size);
-int mipi_dbi_dev_init(struct mipi_dbi_dev *dbidev,
-		      const struct drm_simple_display_pipe_funcs *funcs,
-		      const struct drm_display_mode *mode, unsigned int rotation);
-enum drm_mode_status mipi_dbi_pipe_mode_valid(struct drm_simple_display_pipe *pipe,
-					      const struct drm_display_mode *mode);
-void mipi_dbi_pipe_update(struct drm_simple_display_pipe *pipe,
-			  struct drm_plane_state *old_state);
-void mipi_dbi_pipe_disable(struct drm_simple_display_pipe *pipe);
-int mipi_dbi_pipe_begin_fb_access(struct drm_simple_display_pipe *pipe,
-				  struct drm_plane_state *plane_state);
-void mipi_dbi_pipe_end_fb_access(struct drm_simple_display_pipe *pipe,
-				 struct drm_plane_state *plane_state);
-void mipi_dbi_pipe_reset_plane(struct drm_simple_display_pipe *pipe);
-struct drm_plane_state *mipi_dbi_pipe_duplicate_plane_state(struct drm_simple_display_pipe *pipe);
-void mipi_dbi_pipe_destroy_plane_state(struct drm_simple_display_pipe *pipe,
-				       struct drm_plane_state *plane_state);
-
 void mipi_dbi_hw_reset(struct mipi_dbi *dbi);
 bool mipi_dbi_display_is_on(struct mipi_dbi *dbi);
 int mipi_dbi_poweron_reset(struct mipi_dbi_dev *dbidev);
@@ -322,25 +289,4 @@ void mipi_dbi_debugfs_init(struct drm_minor *minor);
 static inline void mipi_dbi_debugfs_init(struct drm_minor *minor) {}
 #endif
 
-/**
- * DRM_MIPI_DBI_SIMPLE_DISPLAY_PIPE_FUNCS - Initializes struct drm_simple_display_pipe_funcs
- *                                          for MIPI-DBI devices
- * @enable_: Enable-callback implementation
- *
- * This macro initializes struct drm_simple_display_pipe_funcs with default
- * values for MIPI-DBI-based devices. The only callback that depends on the
- * hardware is @enable, for which the driver has to provide an implementation.
- * MIPI-based drivers are encouraged to use this macro for initialization.
- */
-#define DRM_MIPI_DBI_SIMPLE_DISPLAY_PIPE_FUNCS(enable_) \
-	.mode_valid = mipi_dbi_pipe_mode_valid, \
-	.enable = (enable_), \
-	.disable = mipi_dbi_pipe_disable, \
-	.update = mipi_dbi_pipe_update, \
-	.begin_fb_access = mipi_dbi_pipe_begin_fb_access, \
-	.end_fb_access = mipi_dbi_pipe_end_fb_access, \
-	.reset_plane = mipi_dbi_pipe_reset_plane, \
-	.duplicate_plane_state = mipi_dbi_pipe_duplicate_plane_state, \
-	.destroy_plane_state = mipi_dbi_pipe_destroy_plane_state
-
 #endif /* __LINUX_MIPI_DBI_H */
-- 
2.53.0

