Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2FACA5FDD
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 12:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6CF010E59E;
	Fri,  2 Oct 2026 12:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="NseW1EMD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JpO9Wxwj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pzXMuaTR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tqjRKhgo";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88DC010E59E
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 12:45:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4551B21A34;
 Fri,  2 Oct 2026 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790945106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVl2c+PWSoN1XeajCwbdfkeFecq3QgWVL8Om1itfj5s=;
 b=NseW1EMDesBAJNP/QXJCa1oSCkaeJnPb2Z7YYvcF++sQC1kTT1RGm69HDoQ/1N5xNeGRCX
 0mB3ybvYUe6LgGMJmUWnCW0O6+sjWF7P8+OlCNlxlxkQJT2tRvKdrxYfNdeA2hqxVfrx2s
 lcRsAhyQpFMYRhJUuHpbA63wOWnOyGg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790945106;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVl2c+PWSoN1XeajCwbdfkeFecq3QgWVL8Om1itfj5s=;
 b=JpO9WxwjdWiyN3T3000acMjXnMIXIXoXdv9BMV4sGleTEFywIqnyfjaqdW0I9aEp9XDwJx
 ZwJnl6JGO0N6N7Cg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pzXMuaTR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tqjRKhgo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790945102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVl2c+PWSoN1XeajCwbdfkeFecq3QgWVL8Om1itfj5s=;
 b=pzXMuaTRkNmcnNdTvrBW5w9H0wNV1TP/YvmcU9ruuV/yyLdfjv6v9LxlljK8Xc5cOi0mXy
 p3r+0zcCEO5HreTdfGuVX166yP/lGVA1CqGErfjUhPOO/ywRc3MUXhXMAbwVWTaXCNjuJz
 HziWuxHyfyh6Lyk1ay/ZuBhHOJHeQC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790945102;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FVl2c+PWSoN1XeajCwbdfkeFecq3QgWVL8Om1itfj5s=;
 b=tqjRKhgou9QJN2/rmclW4onem4RylURB+vLD2FZTuiQ0AaRltPWT3as1vq+Pkl5drVii8+
 KOIndC2xn4aS4ZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9439813C93;
 Fri,  2 Oct 2026 12:45:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V/hJI0ynv2rNTwAAD6G6ig:T3
 (envelope-from <tzimmermann@suse.de>); Fri, 02 Oct 2026 12:45:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, decui@microsoft.com, ssengar@linux.microsoft.com,
 andy@kernel.org, gregkh@linuxfoundation.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>
Subject: [PATCH v2 2/7] drm/kms-helper: Remove struct drm_simple_display_pipe
 and helpers
Date: Fri,  2 Oct 2026 14:41:52 +0200
Message-ID: <20261002124456.741011-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124456.741011-1-tzimmermann@suse.de>
References: <20261002124456.741011-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4551B21A34
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,microsoft.com,linux.microsoft.com,linuxfoundation.org];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[15]; ARC_NA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

There are no drivers using struct drm_simple_display_pipe. Remove
the data type and all related helpers.

The idea behind struct drm_simple_display_pipe was to provide an
easier way for writing DRM drivers besides regular atomic helpers.
It turned out to be more complicated. With all drivers being updated
to use atomic helpers, it's time to remove simple-pipe. Also clean
up the related TODO items.

v2:
- fix typo in fbtft TODO (Andy)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 Documentation/gpu/todo.rst              |  17 --
 drivers/gpu/drm/drm_gem_atomic_helper.c |  92 -------
 drivers/gpu/drm/drm_simple_kms_helper.c | 328 ------------------------
 drivers/staging/fbtft/TODO              |   4 +-
 include/drm/drm_gem_atomic_helper.h     |  28 --
 include/drm/drm_simple_kms_helper.h     |  56 +---
 6 files changed, 4 insertions(+), 521 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index a437ae5c71f4..e6d36f8da086 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -29,23 +29,6 @@ refactorings already and are an expert in the specific area
 Subsystem-wide refactorings
 ===========================
 
-Replace struct drm_simple_display_pipe with regular atomic helpers
-------------------------------------------------------------------
-
-The data type struct drm_simple_display_pipe and its helpers were supposed
-to simplify driver development. Instead they only added an intermediate layer
-between atomic modesetting and the DRM driver.
-
-There are still drivers that use drm_simple_display_pipe. The task here is to
-convert them to use regular atomic helpers. Search for a driver that calls
-drm_simple_display_pipe_init() and inline all helpers from drm_simple_kms_helper.c
-into the driver, such that no simple-KMS interfaces are required. Please also
-rename all inlined functions according to driver conventions.
-
-Contact: Thomas Zimmermann, respective driver maintainer
-
-Level: Easy
-
 Remove custom dumb_map_offset implementations
 ---------------------------------------------
 
diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index dd9efa7e3216..c952cfed84c1 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -10,7 +10,6 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "drm_internal.h"
 
@@ -367,94 +366,3 @@ void drm_gem_end_shadow_fb_access(struct drm_plane *plane, struct drm_plane_stat
 	drm_gem_fb_vunmap(fb, shadow_plane_state->map);
 }
 EXPORT_SYMBOL(drm_gem_end_shadow_fb_access);
-
-/**
- * drm_gem_simple_kms_begin_shadow_fb_access - prepares shadow framebuffers for CPU access
- * @pipe: the simple display pipe
- * @plane_state: the plane state of type struct drm_shadow_plane_state
- *
- * This function implements struct drm_simple_display_funcs.begin_fb_access.
- *
- * See drm_gem_begin_shadow_fb_access() for details and
- * drm_gem_simple_kms_cleanup_shadow_fb() for cleanup.
- *
- * Returns:
- * 0 on success, or a negative errno code otherwise.
- */
-int drm_gem_simple_kms_begin_shadow_fb_access(struct drm_simple_display_pipe *pipe,
-					      struct drm_plane_state *plane_state)
-{
-	return drm_gem_begin_shadow_fb_access(&pipe->plane, plane_state);
-}
-EXPORT_SYMBOL(drm_gem_simple_kms_begin_shadow_fb_access);
-
-/**
- * drm_gem_simple_kms_end_shadow_fb_access - releases shadow framebuffers from CPU access
- * @pipe: the simple display pipe
- * @plane_state: the plane state of type struct drm_shadow_plane_state
- *
- * This function implements struct drm_simple_display_funcs.end_fb_access.
- * It undoes all effects of drm_gem_simple_kms_begin_shadow_fb_access() in
- * reverse order.
- *
- * See drm_gem_simple_kms_begin_shadow_fb_access().
- */
-void drm_gem_simple_kms_end_shadow_fb_access(struct drm_simple_display_pipe *pipe,
-					     struct drm_plane_state *plane_state)
-{
-	drm_gem_end_shadow_fb_access(&pipe->plane, plane_state);
-}
-EXPORT_SYMBOL(drm_gem_simple_kms_end_shadow_fb_access);
-
-/**
- * drm_gem_simple_kms_create_shadow_plane_state - creates shadow-buffered plane state
- * @pipe: the simple display pipe
- *
- * This function implements struct drm_simple_display_pipe_funcs.create_plane_state
- * for shadow-buffered planes.
- *
- * Returns:
- * A pointer to a new plane state on success, or an ERR_PTR()-encoded
- * error code otherwise.
- */
-struct drm_plane_state *
-drm_gem_simple_kms_create_shadow_plane_state(struct drm_simple_display_pipe *pipe)
-{
-	return drm_gem_create_shadow_plane_state(&pipe->plane);
-}
-EXPORT_SYMBOL(drm_gem_simple_kms_create_shadow_plane_state);
-
-/**
- * drm_gem_simple_kms_duplicate_shadow_plane_state - duplicates shadow-buffered plane state
- * @pipe: the simple display pipe
- *
- * This function implements struct drm_simple_display_funcs.duplicate_plane_state
- * for shadow-buffered planes. It does not duplicate existing mappings of the shadow
- * buffers. Mappings are maintained during the atomic commit by the plane's prepare_fb
- * and cleanup_fb helpers.
- *
- * Returns:
- * A pointer to a new plane state on success, or NULL otherwise.
- */
-struct drm_plane_state *
-drm_gem_simple_kms_duplicate_shadow_plane_state(struct drm_simple_display_pipe *pipe)
-{
-	return drm_gem_duplicate_shadow_plane_state(&pipe->plane);
-}
-EXPORT_SYMBOL(drm_gem_simple_kms_duplicate_shadow_plane_state);
-
-/**
- * drm_gem_simple_kms_destroy_shadow_plane_state - resets shadow-buffered plane state
- * @pipe: the simple display pipe
- * @plane_state: the plane state of type struct drm_shadow_plane_state
- *
- * This function implements struct drm_simple_display_funcs.destroy_plane_state
- * for shadow-buffered planes. It expects that mappings of shadow buffers
- * have been released already.
- */
-void drm_gem_simple_kms_destroy_shadow_plane_state(struct drm_simple_display_pipe *pipe,
-						   struct drm_plane_state *plane_state)
-{
-	drm_gem_destroy_shadow_plane_state(&pipe->plane, plane_state);
-}
-EXPORT_SYMBOL(drm_gem_simple_kms_destroy_shadow_plane_state);
diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 5e324c77ad27..1d048282ed50 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -16,10 +16,6 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 
-static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup = {
-	.destroy = drm_encoder_cleanup,
-};
-
 void *__drmm_simple_encoder_alloc(struct drm_device *dev, size_t size,
 				  size_t offset, int encoder_type)
 {
@@ -28,329 +24,5 @@ void *__drmm_simple_encoder_alloc(struct drm_device *dev, size_t size,
 }
 EXPORT_SYMBOL(__drmm_simple_encoder_alloc);
 
-static enum drm_mode_status
-drm_simple_kms_crtc_mode_valid(struct drm_crtc *crtc,
-			       const struct drm_display_mode *mode)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
-	if (!pipe->funcs || !pipe->funcs->mode_valid)
-		/* Anything goes */
-		return MODE_OK;
-
-	return pipe->funcs->mode_valid(pipe, mode);
-}
-
-static int drm_simple_kms_crtc_check(struct drm_crtc *crtc,
-				     struct drm_atomic_commit *state)
-{
-	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
-	int ret;
-
-	if (!crtc_state->enable)
-		goto out;
-
-	ret = drm_atomic_helper_check_crtc_primary_plane(crtc_state);
-	if (ret)
-		return ret;
-
-out:
-	return drm_atomic_add_affected_planes(state, crtc);
-}
-
-static void drm_simple_kms_crtc_enable(struct drm_crtc *crtc,
-				       struct drm_atomic_commit *state)
-{
-	struct drm_plane *plane;
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
-	if (!pipe->funcs || !pipe->funcs->enable)
-		return;
-
-	plane = &pipe->plane;
-	pipe->funcs->enable(pipe, crtc->state, plane->state);
-}
-
-static void drm_simple_kms_crtc_disable(struct drm_crtc *crtc,
-					struct drm_atomic_commit *state)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
-	if (!pipe->funcs || !pipe->funcs->disable)
-		return;
-
-	pipe->funcs->disable(pipe);
-}
-
-static const struct drm_crtc_helper_funcs drm_simple_kms_crtc_helper_funcs = {
-	.mode_valid = drm_simple_kms_crtc_mode_valid,
-	.atomic_check = drm_simple_kms_crtc_check,
-	.atomic_enable = drm_simple_kms_crtc_enable,
-	.atomic_disable = drm_simple_kms_crtc_disable,
-};
-
-static struct drm_crtc_state *drm_simple_kms_crtc_duplicate_state(struct drm_crtc *crtc)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
-	if (!pipe->funcs || !pipe->funcs->duplicate_crtc_state)
-		return drm_atomic_helper_crtc_duplicate_state(crtc);
-
-	return pipe->funcs->duplicate_crtc_state(pipe);
-}
-
-static void drm_simple_kms_crtc_destroy_state(struct drm_crtc *crtc, struct drm_crtc_state *state)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
-	if (!pipe->funcs || !pipe->funcs->destroy_crtc_state)
-		drm_atomic_helper_crtc_destroy_state(crtc, state);
-	else
-		pipe->funcs->destroy_crtc_state(pipe, state);
-}
-
-static int drm_simple_kms_crtc_enable_vblank(struct drm_crtc *crtc)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
-	if (!pipe->funcs || !pipe->funcs->enable_vblank)
-		return 0;
-
-	return pipe->funcs->enable_vblank(pipe);
-}
-
-static void drm_simple_kms_crtc_disable_vblank(struct drm_crtc *crtc)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(crtc, struct drm_simple_display_pipe, crtc);
-	if (!pipe->funcs || !pipe->funcs->disable_vblank)
-		return;
-
-	pipe->funcs->disable_vblank(pipe);
-}
-
-static const struct drm_crtc_funcs drm_simple_kms_crtc_funcs = {
-	.atomic_create_state = drm_atomic_helper_crtc_create_state,
-	.destroy = drm_crtc_cleanup,
-	.set_config = drm_atomic_helper_set_config,
-	.page_flip = drm_atomic_helper_page_flip,
-	.atomic_duplicate_state = drm_simple_kms_crtc_duplicate_state,
-	.atomic_destroy_state = drm_simple_kms_crtc_destroy_state,
-	.enable_vblank = drm_simple_kms_crtc_enable_vblank,
-	.disable_vblank = drm_simple_kms_crtc_disable_vblank,
-};
-
-static int drm_simple_kms_plane_atomic_check(struct drm_plane *plane,
-					struct drm_atomic_commit *state)
-{
-	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state,
-									     plane);
-	struct drm_simple_display_pipe *pipe;
-	struct drm_crtc_state *crtc_state;
-	int ret;
-
-	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
-	crtc_state = drm_atomic_get_new_crtc_state(state,
-						   &pipe->crtc);
-
-	ret = drm_atomic_helper_check_plane_state(plane_state, crtc_state,
-						  DRM_PLANE_NO_SCALING,
-						  DRM_PLANE_NO_SCALING,
-						  false, false);
-	if (ret)
-		return ret;
-
-	if (!plane_state->visible)
-		return 0;
-
-	if (!pipe->funcs || !pipe->funcs->check)
-		return 0;
-
-	return pipe->funcs->check(pipe, plane_state, crtc_state);
-}
-
-static void drm_simple_kms_plane_atomic_update(struct drm_plane *plane,
-					struct drm_atomic_commit *state)
-{
-	struct drm_plane_state *old_pstate = drm_atomic_get_old_plane_state(state,
-									    plane);
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
-	if (!pipe->funcs || !pipe->funcs->update)
-		return;
-
-	pipe->funcs->update(pipe, old_pstate);
-}
-
-static int drm_simple_kms_plane_prepare_fb(struct drm_plane *plane,
-					   struct drm_plane_state *state)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
-	if (!pipe->funcs || !pipe->funcs->prepare_fb) {
-		if (WARN_ON_ONCE(!drm_core_check_feature(plane->dev, DRIVER_GEM)))
-			return 0;
-
-		WARN_ON_ONCE(pipe->funcs && pipe->funcs->cleanup_fb);
-
-		return drm_gem_plane_helper_prepare_fb(plane, state);
-	}
-
-	return pipe->funcs->prepare_fb(pipe, state);
-}
-
-static void drm_simple_kms_plane_cleanup_fb(struct drm_plane *plane,
-					    struct drm_plane_state *state)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
-	if (!pipe->funcs || !pipe->funcs->cleanup_fb)
-		return;
-
-	pipe->funcs->cleanup_fb(pipe, state);
-}
-
-static int drm_simple_kms_plane_begin_fb_access(struct drm_plane *plane,
-						struct drm_plane_state *new_plane_state)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
-	if (!pipe->funcs || !pipe->funcs->begin_fb_access)
-		return 0;
-
-	return pipe->funcs->begin_fb_access(pipe, new_plane_state);
-}
-
-static void drm_simple_kms_plane_end_fb_access(struct drm_plane *plane,
-					       struct drm_plane_state *new_plane_state)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
-	if (!pipe->funcs || !pipe->funcs->end_fb_access)
-		return;
-
-	pipe->funcs->end_fb_access(pipe, new_plane_state);
-}
-
-static bool drm_simple_kms_format_mod_supported(struct drm_plane *plane,
-						uint32_t format,
-						uint64_t modifier)
-{
-	return modifier == DRM_FORMAT_MOD_LINEAR;
-}
-
-static const struct drm_plane_helper_funcs drm_simple_kms_plane_helper_funcs = {
-	.prepare_fb = drm_simple_kms_plane_prepare_fb,
-	.cleanup_fb = drm_simple_kms_plane_cleanup_fb,
-	.begin_fb_access = drm_simple_kms_plane_begin_fb_access,
-	.end_fb_access = drm_simple_kms_plane_end_fb_access,
-	.atomic_check = drm_simple_kms_plane_atomic_check,
-	.atomic_update = drm_simple_kms_plane_atomic_update,
-};
-
-static struct drm_plane_state *
-drm_simple_kms_plane_create_state(struct drm_plane *plane)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
-	if (!pipe->funcs || !pipe->funcs->create_plane_state)
-		return drm_atomic_helper_plane_create_state(plane);
-
-	return pipe->funcs->create_plane_state(pipe);
-}
-
-static struct drm_plane_state *drm_simple_kms_plane_duplicate_state(struct drm_plane *plane)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
-	if (!pipe->funcs || !pipe->funcs->duplicate_plane_state)
-		return drm_atomic_helper_plane_duplicate_state(plane);
-
-	return pipe->funcs->duplicate_plane_state(pipe);
-}
-
-static void drm_simple_kms_plane_destroy_state(struct drm_plane *plane,
-					       struct drm_plane_state *state)
-{
-	struct drm_simple_display_pipe *pipe;
-
-	pipe = container_of(plane, struct drm_simple_display_pipe, plane);
-	if (!pipe->funcs || !pipe->funcs->destroy_plane_state)
-		drm_atomic_helper_plane_destroy_state(plane, state);
-	else
-		pipe->funcs->destroy_plane_state(pipe, state);
-}
-
-static const struct drm_plane_funcs drm_simple_kms_plane_funcs = {
-	.update_plane		= drm_atomic_helper_update_plane,
-	.disable_plane		= drm_atomic_helper_disable_plane,
-	.destroy		= drm_plane_cleanup,
-	.atomic_create_state	= drm_simple_kms_plane_create_state,
-	.atomic_duplicate_state	= drm_simple_kms_plane_duplicate_state,
-	.atomic_destroy_state	= drm_simple_kms_plane_destroy_state,
-	.format_mod_supported   = drm_simple_kms_format_mod_supported,
-};
-
-int drm_simple_display_pipe_attach_bridge(struct drm_simple_display_pipe *pipe,
-					  struct drm_bridge *bridge)
-{
-	return drm_bridge_attach(&pipe->encoder, bridge, NULL, 0);
-}
-EXPORT_SYMBOL(drm_simple_display_pipe_attach_bridge);
-
-int drm_simple_display_pipe_init(struct drm_device *dev,
-			struct drm_simple_display_pipe *pipe,
-			const struct drm_simple_display_pipe_funcs *funcs,
-			const uint32_t *formats, unsigned int format_count,
-			const uint64_t *format_modifiers,
-			struct drm_connector *connector)
-{
-	struct drm_encoder *encoder = &pipe->encoder;
-	struct drm_plane *plane = &pipe->plane;
-	struct drm_crtc *crtc = &pipe->crtc;
-	int ret;
-
-	pipe->connector = connector;
-	pipe->funcs = funcs;
-
-	drm_plane_helper_add(plane, &drm_simple_kms_plane_helper_funcs);
-	ret = drm_universal_plane_init(dev, plane, 0,
-				       &drm_simple_kms_plane_funcs,
-				       formats, format_count,
-				       format_modifiers,
-				       DRM_PLANE_TYPE_PRIMARY, NULL);
-	if (ret)
-		return ret;
-
-	drm_crtc_helper_add(crtc, &drm_simple_kms_crtc_helper_funcs);
-	ret = drm_crtc_init_with_planes(dev, crtc, plane, NULL,
-					&drm_simple_kms_crtc_funcs, NULL);
-	if (ret)
-		return ret;
-
-	encoder->possible_crtcs = drm_crtc_mask(crtc);
-	ret = drm_encoder_init(dev, encoder, &drm_simple_encoder_funcs_cleanup,
-			       DRM_MODE_ENCODER_NONE, NULL);
-	if (ret || !connector)
-		return ret;
-
-	return drm_connector_attach_encoder(connector, encoder);
-}
-EXPORT_SYMBOL(drm_simple_display_pipe_init);
-
 MODULE_DESCRIPTION("Helpers for drivers for simple display hardware");
 MODULE_LICENSE("GPL");
diff --git a/drivers/staging/fbtft/TODO b/drivers/staging/fbtft/TODO
index e72a08bf221c..2222998fd3ef 100644
--- a/drivers/staging/fbtft/TODO
+++ b/drivers/staging/fbtft/TODO
@@ -1,3 +1,3 @@
-* convert all these over to drm_simple_display_pipe and submit for inclusion
-  into the DRM subsystem under drivers/gpu/drm - fbdev doesn't take any new
+* convert all drivers over to DRM and submit them for inclusion into
+  the DRM subsystem under drivers/gpu/drm - fbdev doesn't take new
   drivers anymore.
diff --git a/include/drm/drm_gem_atomic_helper.h b/include/drm/drm_gem_atomic_helper.h
index d41877f77b77..f605a8a7b017 100644
--- a/include/drm/drm_gem_atomic_helper.h
+++ b/include/drm/drm_gem_atomic_helper.h
@@ -9,8 +9,6 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_plane.h>
 
-struct drm_simple_display_pipe;
-
 /*
  * Plane Helpers
  */
@@ -126,30 +124,4 @@ void drm_gem_end_shadow_fb_access(struct drm_plane *plane, struct drm_plane_stat
 	.begin_fb_access = drm_gem_begin_shadow_fb_access, \
 	.end_fb_access = drm_gem_end_shadow_fb_access
 
-int drm_gem_simple_kms_begin_shadow_fb_access(struct drm_simple_display_pipe *pipe,
-					      struct drm_plane_state *plane_state);
-void drm_gem_simple_kms_end_shadow_fb_access(struct drm_simple_display_pipe *pipe,
-					     struct drm_plane_state *plane_state);
-struct drm_plane_state *
-drm_gem_simple_kms_create_shadow_plane_state(struct drm_simple_display_pipe *pipe);
-struct drm_plane_state *
-drm_gem_simple_kms_duplicate_shadow_plane_state(struct drm_simple_display_pipe *pipe);
-void drm_gem_simple_kms_destroy_shadow_plane_state(struct drm_simple_display_pipe *pipe,
-						   struct drm_plane_state *plane_state);
-
-/**
- * DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS -
- *	Initializes struct drm_simple_display_pipe_funcs for shadow-buffered planes
- *
- * Drivers may use GEM BOs as shadow buffers over the framebuffer memory. This
- * macro initializes struct drm_simple_display_pipe_funcs to use the rsp helper
- * functions.
- */
-#define DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS \
-	.begin_fb_access = drm_gem_simple_kms_begin_shadow_fb_access, \
-	.end_fb_access = drm_gem_simple_kms_end_shadow_fb_access, \
-	.create_plane_state = drm_gem_simple_kms_create_shadow_plane_state, \
-	.duplicate_plane_state = drm_gem_simple_kms_duplicate_shadow_plane_state, \
-	.destroy_plane_state = drm_gem_simple_kms_destroy_shadow_plane_state
-
 #endif /* __DRM_GEM_ATOMIC_HELPER_H__ */
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index 2b31c25c57a9..beb5c8a19bb7 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -11,61 +11,9 @@
 #ifndef __LINUX_DRM_SIMPLE_KMS_HELPER_H
 #define __LINUX_DRM_SIMPLE_KMS_HELPER_H
 
-#include <drm/drm_crtc.h>
-#include <drm/drm_encoder.h>
-#include <drm/drm_plane.h>
+#include <linux/types.h>
 
-struct drm_simple_display_pipe;
-
-struct drm_simple_display_pipe_funcs {
-	enum drm_mode_status (*mode_valid)(struct drm_simple_display_pipe *pipe,
-					   const struct drm_display_mode *mode);
-	void (*enable)(struct drm_simple_display_pipe *pipe,
-		       struct drm_crtc_state *crtc_state,
-		       struct drm_plane_state *plane_state);
-	void (*disable)(struct drm_simple_display_pipe *pipe);
-	int (*check)(struct drm_simple_display_pipe *pipe,
-		     struct drm_plane_state *plane_state,
-		     struct drm_crtc_state *crtc_state);
-	void (*update)(struct drm_simple_display_pipe *pipe,
-		       struct drm_plane_state *old_plane_state);
-	int (*prepare_fb)(struct drm_simple_display_pipe *pipe,
-			  struct drm_plane_state *plane_state);
-	void (*cleanup_fb)(struct drm_simple_display_pipe *pipe,
-			   struct drm_plane_state *plane_state);
-	int (*begin_fb_access)(struct drm_simple_display_pipe *pipe,
-			       struct drm_plane_state *new_plane_state);
-	void (*end_fb_access)(struct drm_simple_display_pipe *pipe,
-			      struct drm_plane_state *plane_state);
-	int (*enable_vblank)(struct drm_simple_display_pipe *pipe);
-	void (*disable_vblank)(struct drm_simple_display_pipe *pipe);
-	struct drm_crtc_state * (*duplicate_crtc_state)(struct drm_simple_display_pipe *pipe);
-	void (*destroy_crtc_state)(struct drm_simple_display_pipe *pipe,
-				   struct drm_crtc_state *crtc_state);
-	struct drm_plane_state * (*create_plane_state)(struct drm_simple_display_pipe *pipe);
-	struct drm_plane_state * (*duplicate_plane_state)(struct drm_simple_display_pipe *pipe);
-	void (*destroy_plane_state)(struct drm_simple_display_pipe *pipe,
-				    struct drm_plane_state *plane_state);
-};
-
-struct drm_simple_display_pipe {
-	struct drm_crtc crtc;
-	struct drm_plane plane;
-	struct drm_encoder encoder;
-	struct drm_connector *connector;
-
-	const struct drm_simple_display_pipe_funcs *funcs;
-};
-
-int drm_simple_display_pipe_attach_bridge(struct drm_simple_display_pipe *pipe,
-					  struct drm_bridge *bridge);
-
-int drm_simple_display_pipe_init(struct drm_device *dev,
-			struct drm_simple_display_pipe *pipe,
-			const struct drm_simple_display_pipe_funcs *funcs,
-			const uint32_t *formats, unsigned int format_count,
-			const uint64_t *format_modifiers,
-			struct drm_connector *connector);
+struct drm_device;
 
 void *__drmm_simple_encoder_alloc(struct drm_device *dev, size_t size,
 				  size_t offset, int encoder_type);
-- 
2.55.0

