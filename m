Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7FA1090242
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:01:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9C0310E7A5;
	Thu, 19 Mar 2026 16:01:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="dLvjHU48";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5a9g3IM8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P79EBw1a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lgIyIROX";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05BF910E7D1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:01:23 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B296E4D29B;
 Thu, 19 Mar 2026 16:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WkaG7N4lwBlOriqARQqZZhybHO1wCfrx49olmn0XCYk=;
 b=dLvjHU48n4VBYtkpCmo+5et/BgO5ji5VE4igajcVEfpoo+uB3GVoE9nHM9jFL8vXMcMPPY
 EjIfvzNMLf/1lAEpqkxnrfhUttjzcIhUHDkeuKP3NR5cVoZJTtaajOVxVMy5Zy84RtI5gG
 6dbIyN6lGvghSHXh7QEcIOpe0F5cvYw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WkaG7N4lwBlOriqARQqZZhybHO1wCfrx49olmn0XCYk=;
 b=5a9g3IM8RTZ91K88OIVzGwFcsm2M+THlmrTySpFfA49/8a6TviBqxUvjlFunfjSOpUOCVO
 PrXPeWulUq5gQNDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WkaG7N4lwBlOriqARQqZZhybHO1wCfrx49olmn0XCYk=;
 b=P79EBw1aEPId6jjtzLcFlebxKraw3T2JBfMx0RtioUqUMwXpjLsr/g8zKUMW+yhyXg0zYJ
 ErCi/U6WowfkCw/4DkIk97oHH5xx0GUrhFhjDZGEAGfYnYl98uKpRV4QoiWoQn0jgGnSBh
 c2zmlt7hzDzJI/weIsw+caTV3xekS6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936075;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WkaG7N4lwBlOriqARQqZZhybHO1wCfrx49olmn0XCYk=;
 b=lgIyIROX6/54q3BzBr/PgAow6VLdluoqOyCRqX7lFF6uKIoBPMvAiBGRUwQKEzC2JT4rpl
 mSP1pFNP29/tVRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5EECC4274D;
 Thu, 19 Mar 2026 16:01:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WIO+FcsdvGn0WQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Mar 2026 16:01:15 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 03/16] drm/mipi-dbi: Provide callbacks for atomic interfaces
Date: Thu, 19 Mar 2026 16:59:39 +0100
Message-ID: <20260319160110.109610-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319160110.109610-1-tzimmermann@suse.de>
References: <20260319160110.109610-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[];
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

Refactor the existing simple-display callbacks such that they invoke
helpers compatible with regular atomic modesetting. Allows for adding
mipi-dbi drives that do not require simple-display helpers.

Provide initializer macro for elements of the regular modesetting
pipeline. These will be used by drivers to integrate mipi-dbi helpers.
Also provide initializer macros for the plane formats.

As the new helpers are DRM functions, add the drm_ prefix. Mipi-dbi
interfaces currently lack this.

v3:
- fix uninitialized variable (David)
- document public interfaces (David)
- mention format macros in commit message (David)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: David Lechner <david@lechnology.com>
---
 drivers/gpu/drm/drm_mipi_dbi.c | 203 +++++++++++++++++++++++++--------
 include/drm/drm_mipi_dbi.h     |  86 ++++++++++++++
 2 files changed, 242 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index bc5444ca7ac6..0374fd0c527d 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -14,6 +14,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
+#include <drm/drm_atomic.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_drv.h>
@@ -22,12 +23,9 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem.h>
-#include <drm/drm_gem_atomic_helper.h>
-#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_mipi_dbi.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_print.h>
-#include <drm/drm_probe_helper.h>
 #include <drm/drm_rect.h>
 #include <video/mipi_display.h>
 
@@ -316,6 +314,24 @@ static void mipi_dbi_fb_dirty(struct iosys_map *src, struct drm_framebuffer *fb,
 		drm_err_once(fb->dev, "Failed to update display %d\n", ret);
 }
 
+/**
+ * drm_mipi_dbi_crtc_helper_mode_valid - MIPI DBI mode-valid helper
+ * @crtc: The CRTC
+ * @mode: The mode to test
+ *
+ * This function validates a given display mode against the MIPI DBI's hardware
+ * display. Drivers can use this as their struct &drm_crtc_helper_funcs.mode_valid
+ * callback.
+ */
+enum drm_mode_status drm_mipi_dbi_crtc_helper_mode_valid(struct drm_crtc *crtc,
+							 const struct drm_display_mode *mode)
+{
+	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(crtc->dev);
+
+	return drm_crtc_helper_mode_valid_fixed(crtc, mode, &dbidev->mode);
+}
+EXPORT_SYMBOL(drm_mipi_dbi_crtc_helper_mode_valid);
+
 /**
  * mipi_dbi_pipe_mode_valid - MIPI DBI mode-valid helper
  * @pipe: Simple display pipe
@@ -328,43 +344,87 @@ static void mipi_dbi_fb_dirty(struct iosys_map *src, struct drm_framebuffer *fb,
 enum drm_mode_status mipi_dbi_pipe_mode_valid(struct drm_simple_display_pipe *pipe,
 					      const struct drm_display_mode *mode)
 {
-	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(pipe->crtc.dev);
-
-	return drm_crtc_helper_mode_valid_fixed(&pipe->crtc, mode, &dbidev->mode);
+	return drm_mipi_dbi_crtc_helper_mode_valid(&pipe->crtc, mode);
 }
 EXPORT_SYMBOL(mipi_dbi_pipe_mode_valid);
 
 /**
- * mipi_dbi_pipe_update - Display pipe update helper
- * @pipe: Simple display pipe
- * @old_state: Old plane state
+ * drm_mipi_dbi_plane_helper_atomic_check - MIPI DBI plane check helper
+ * @plane: Plane to check
+ * @state: Atomic state
+ *
+ * This function performs the default checks on the primary plane
+ * of a MIPI DBI device. Drivers can use this as their
+ * struct &drm_crtc_helper_funcs.atomic_check callback.
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise.
+ */
+int drm_mipi_dbi_plane_helper_atomic_check(struct drm_plane *plane,
+					   struct drm_atomic_state *state)
+{
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc_state *new_crtc_state = NULL;
+	int ret;
+
+	if (new_plane_state->crtc)
+		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_plane_state->crtc);
+
+	ret = drm_atomic_helper_check_plane_state(new_plane_state, new_crtc_state,
+						  DRM_PLANE_NO_SCALING,
+						  DRM_PLANE_NO_SCALING,
+						  false, false);
+	if (ret)
+		return ret;
+	else if (!new_plane_state->visible)
+		return 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_mipi_dbi_plane_helper_atomic_check);
+
+/**
+ * drm_mipi_dbi_plane_helper_atomic_update - Display update helper
+ * @plane: Plane
+ * @state: Atomic state
  *
  * This function handles framebuffer flushing and vblank events. Drivers can use
- * this as their &drm_simple_display_pipe_funcs->update callback.
+ * this as their struct &drm_plane_helper_funcs.atomic_update callback.
  */
-void mipi_dbi_pipe_update(struct drm_simple_display_pipe *pipe,
-			  struct drm_plane_state *old_state)
+void drm_mipi_dbi_plane_helper_atomic_update(struct drm_plane *plane,
+					     struct drm_atomic_state *state)
 {
-	struct drm_plane_state *state = pipe->plane.state;
-	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
-	struct drm_framebuffer *fb = state->fb;
+	struct drm_plane_state *plane_state = plane->state;
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
+	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
 	struct drm_rect rect;
 	int idx;
 
-	if (!pipe->crtc.state->active)
+	if (!fb)
 		return;
 
-	if (WARN_ON(!fb))
-		return;
-
-	if (!drm_dev_enter(fb->dev, &idx))
-		return;
-
-	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
-		mipi_dbi_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
-				  &shadow_plane_state->fmtcnv_state);
+	if (drm_dev_enter(plane->dev, &idx)) {
+		if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect))
+			mipi_dbi_fb_dirty(&shadow_plane_state->data[0], fb, &rect,
+					  &shadow_plane_state->fmtcnv_state);
+		drm_dev_exit(idx);
+	}
+}
+EXPORT_SYMBOL(drm_mipi_dbi_plane_helper_atomic_update);
 
-	drm_dev_exit(idx);
+/**
+ * mipi_dbi_pipe_update - Display pipe update helper
+ * @pipe: Simple display pipe
+ * @old_state: Old plane state
+ *
+ * This function handles framebuffer flushing and vblank events. Drivers can use
+ * this as their &drm_simple_display_pipe_funcs->update callback.
+ */
+void mipi_dbi_pipe_update(struct drm_simple_display_pipe *pipe,
+			  struct drm_plane_state *old_state)
+{
+	return drm_mipi_dbi_plane_helper_atomic_update(&pipe->plane, old_state->state);
 }
 EXPORT_SYMBOL(mipi_dbi_pipe_update);
 
@@ -394,18 +454,48 @@ static void mipi_dbi_blank(struct mipi_dbi_dev *dbidev)
 }
 
 /**
- * mipi_dbi_pipe_disable - MIPI DBI pipe disable helper
- * @pipe: Display pipe
+ * drm_mipi_dbi_crtc_helper_atomic_check - MIPI DBI CRTC check helper
+ * @crtc: CRTC to check
+ * @state: Atomic state
+ *
+ * This function performs the default checks on the CRTC of a MIPI DBI
+ * device and ensures that the primary plane as been set up correctly.
+ * Drivers can use this as their struct &drm_crtc_helper_funcs.atomic_check
+ * callback.
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise.
+ */
+int drm_mipi_dbi_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
+{
+	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+	int ret;
+
+	if (!crtc_state->enable)
+		goto out;
+
+	ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
+	if (ret)
+		return ret;
+
+out:
+	return drm_atomic_add_affected_planes(state, crtc);
+}
+EXPORT_SYMBOL(drm_mipi_dbi_crtc_helper_atomic_check);
+
+/**
+ * drm_mipi_dbi_crtc_helper_atomic_disable - MIPI DBI CRTC disable helper
+ * @crtc: CRTC to disable
+ * @state: Atomic state
  *
  * This function disables backlight if present, if not the display memory is
  * blanked. The regulator is disabled if in use. Drivers can use this as their
- * &drm_simple_display_pipe_funcs->disable callback.
+ * struct &drm_crtc_helper_funcs.atomic_disable callback.
  */
-void mipi_dbi_pipe_disable(struct drm_simple_display_pipe *pipe)
+void drm_mipi_dbi_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					     struct drm_atomic_state *state)
 {
-	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(pipe->crtc.dev);
-
-	DRM_DEBUG_KMS("\n");
+	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(crtc->dev);
 
 	if (dbidev->backlight)
 		backlight_disable(dbidev->backlight);
@@ -417,6 +507,20 @@ void mipi_dbi_pipe_disable(struct drm_simple_display_pipe *pipe)
 	if (dbidev->io_regulator)
 		regulator_disable(dbidev->io_regulator);
 }
+EXPORT_SYMBOL(drm_mipi_dbi_crtc_helper_atomic_disable);
+
+/**
+ * mipi_dbi_pipe_disable - MIPI DBI pipe disable helper
+ * @pipe: Display pipe
+ *
+ * This function disables backlight if present, if not the display memory is
+ * blanked. The regulator is disabled if in use. Drivers can use this as their
+ * &drm_simple_display_pipe_funcs->disable callback.
+ */
+void mipi_dbi_pipe_disable(struct drm_simple_display_pipe *pipe)
+{
+	drm_mipi_dbi_crtc_helper_atomic_disable(&pipe->crtc, pipe->crtc.state->state);
+}
 EXPORT_SYMBOL(mipi_dbi_pipe_disable);
 
 /**
@@ -503,23 +607,32 @@ void mipi_dbi_pipe_destroy_plane_state(struct drm_simple_display_pipe *pipe,
 }
 EXPORT_SYMBOL(mipi_dbi_pipe_destroy_plane_state);
 
-static int mipi_dbi_connector_get_modes(struct drm_connector *connector)
+/**
+ * drm_mipi_dbi_connector_helper_get_modes - Duplicates the MIPI DBI mode for the connector
+ * @connector: The connector
+ *
+ * Sets the connecto rmodes from the MIPI DBI mode. Drivers can use this as their
+ * &drm_connector_helper_funcs->get_mods callback. See drm_gem_destroy_shadow_plane_state()
+ * for additional details.
+ *
+ * Returns:
+ * The number of created modes.
+ */
+int drm_mipi_dbi_connector_helper_get_modes(struct drm_connector *connector)
 {
 	struct mipi_dbi_dev *dbidev = drm_to_mipi_dbi_dev(connector->dev);
 
 	return drm_connector_helper_get_modes_fixed(connector, &dbidev->mode);
 }
+EXPORT_SYMBOL(drm_mipi_dbi_connector_helper_get_modes);
 
 static const struct drm_connector_helper_funcs mipi_dbi_connector_hfuncs = {
-	.get_modes = mipi_dbi_connector_get_modes,
+	DRM_MIPI_DBI_CONNECTOR_HELPER_FUNCS,
 };
 
 static const struct drm_connector_funcs mipi_dbi_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
-	.fill_modes = drm_helper_probe_single_connector_modes,
+	DRM_MIPI_DBI_CONNECTOR_FUNCS,
 	.destroy = drm_connector_cleanup,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
 static int mipi_dbi_rotate_mode(struct drm_display_mode *mode,
@@ -540,18 +653,15 @@ static int mipi_dbi_rotate_mode(struct drm_display_mode *mode,
 }
 
 static const struct drm_mode_config_helper_funcs mipi_dbi_mode_config_helper_funcs = {
-	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm,
+	DRM_MIPI_DBI_MODE_CONFIG_HELPER_FUNCS,
 };
 
 static const struct drm_mode_config_funcs mipi_dbi_mode_config_funcs = {
-	.fb_create = drm_gem_fb_create_with_dirty,
-	.atomic_check = drm_atomic_helper_check,
-	.atomic_commit = drm_atomic_helper_commit,
+	DRM_MIPI_DBI_MODE_CONFIG_FUNCS,
 };
 
 static const uint32_t mipi_dbi_formats[] = {
-	DRM_FORMAT_RGB565,
-	DRM_FORMAT_XRGB8888,
+	DRM_MIPI_DBI_PLANE_FORMATS,
 };
 
 /**
@@ -637,8 +747,7 @@ int mipi_dbi_dev_init_with_formats(struct mipi_dbi_dev *dbidev,
 				   unsigned int rotation, size_t tx_buf_size)
 {
 	static const uint64_t modifiers[] = {
-		DRM_FORMAT_MOD_LINEAR,
-		DRM_FORMAT_MOD_INVALID
+		DRM_MIPI_DBI_PLANE_FORMAT_MODIFIERS,
 	};
 	struct drm_device *drm = &dbidev->drm;
 	int ret;
diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index 9c0e015dd929..ae92a5e8d13b 100644
--- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -9,7 +9,12 @@
 #define __LINUX_MIPI_DBI_H
 
 #include <linux/mutex.h>
+
+#include <drm/drm_atomic_state_helper.h>
 #include <drm/drm_device.h>
+#include <drm/drm_gem_atomic_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 
 struct drm_format_conv_state;
@@ -230,6 +235,87 @@ int mipi_dbi_buf_copy(void *dst, struct iosys_map *src, struct drm_framebuffer *
 	ret; \
 })
 
+/*
+ * Plane
+ */
+
+#define DRM_MIPI_DBI_PLANE_FORMATS \
+	DRM_FORMAT_RGB565, \
+	DRM_FORMAT_XRGB8888
+
+#define DRM_MIPI_DBI_PLANE_FORMAT_MODIFIERS \
+	DRM_FORMAT_MOD_LINEAR, \
+	DRM_FORMAT_MOD_INVALID
+
+#define DRM_MIPI_DBI_PLANE_FUNCS \
+	DRM_GEM_SHADOW_PLANE_FUNCS, \
+	.update_plane = drm_atomic_helper_update_plane, \
+	.disable_plane = drm_atomic_helper_disable_plane
+
+int drm_mipi_dbi_plane_helper_atomic_check(struct drm_plane *plane,
+					   struct drm_atomic_state *state);
+void drm_mipi_dbi_plane_helper_atomic_update(struct drm_plane *plane,
+					     struct drm_atomic_state *state);
+
+#define DRM_MIPI_DBI_PLANE_HELPER_FUNCS \
+	DRM_GEM_SHADOW_PLANE_HELPER_FUNCS, \
+	.atomic_check = drm_mipi_dbi_plane_helper_atomic_check, \
+	.atomic_update = drm_mipi_dbi_plane_helper_atomic_update
+
+/*
+ * CRTC
+ */
+
+#define DRM_MIPI_DBI_CRTC_FUNCS \
+	.reset = drm_atomic_helper_crtc_reset, \
+	.set_config = drm_atomic_helper_set_config, \
+	.page_flip = drm_atomic_helper_page_flip, \
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state, \
+	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state
+
+enum drm_mode_status drm_mipi_dbi_crtc_helper_mode_valid(struct drm_crtc *crtc,
+							 const struct drm_display_mode *mode);
+int drm_mipi_dbi_crtc_helper_atomic_check(struct drm_crtc *crtc,
+					  struct drm_atomic_state *state);
+void drm_mipi_dbi_crtc_helper_atomic_disable(struct drm_crtc *crtc,
+					     struct drm_atomic_state *state);
+
+#define DRM_MIPI_DBI_CRTC_HELPER_FUNCS \
+	.mode_valid = drm_mipi_dbi_crtc_helper_mode_valid, \
+	.atomic_check = drm_mipi_dbi_crtc_helper_atomic_check, \
+	.atomic_disable = drm_mipi_dbi_crtc_helper_atomic_disable
+
+/*
+ * Connector
+ */
+
+#define DRM_MIPI_DBI_CONNECTOR_FUNCS \
+	.reset = drm_atomic_helper_connector_reset, \
+	.fill_modes = drm_helper_probe_single_connector_modes, \
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state, \
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state
+
+int drm_mipi_dbi_connector_helper_get_modes(struct drm_connector *connector);
+
+#define DRM_MIPI_DBI_CONNECTOR_HELPER_FUNCS \
+	.get_modes = drm_mipi_dbi_connector_helper_get_modes
+
+/*
+ * Mode config
+ */
+
+#define DRM_MIPI_DBI_MODE_CONFIG_FUNCS \
+	.fb_create = drm_gem_fb_create_with_dirty, \
+	.atomic_check = drm_atomic_helper_check, \
+	.atomic_commit = drm_atomic_helper_commit
+
+#define DRM_MIPI_DBI_MODE_CONFIG_HELPER_FUNCS \
+	.atomic_commit_tail = drm_atomic_helper_commit_tail_rpm
+
+/*
+ * Debug FS
+ */
+
 #ifdef CONFIG_DEBUG_FS
 void mipi_dbi_debugfs_init(struct drm_minor *minor);
 #else
-- 
2.53.0

