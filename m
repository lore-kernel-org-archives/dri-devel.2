Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B3A606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bYupLdqQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cslAJ9O1;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=bYupLdqQ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cslAJ9O1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5774410F75C;
	Tue, 17 Nov 2026 14:08:41 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D15510F70F;
 Tue, 17 Nov 2026 14:08:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9E2EE22316;
 Tue, 17 Nov 2026 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794924476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=COMkQmnQCehio7DOnM2qqCXfVoxaXXN4MjJ+qTdy8no=;
 b=bYupLdqQOaOabS6vjaldVAdSdE5cjn2ZLW1Hz97V0iptIRczlFeS/bGMYWJcYZqMnaMI3z
 Hn9ElrRebsDHOVveize2ZqzRnlFdQguVPbxizg7YOPacoIonX63a9mO7Vbyf8ry57sUsGp
 47bBQT7EhCVp9avCGkRWmvETRAH2+kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794924476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=COMkQmnQCehio7DOnM2qqCXfVoxaXXN4MjJ+qTdy8no=;
 b=cslAJ9O1Z98CHoMuLoLhXaExyHelsINbs3DGLPwRYQgF5DlxY23hyo2CvIVC+Hn8k+TxXq
 T9UqUlbCc/yTgiBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bYupLdqQ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cslAJ9O1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794924476; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=COMkQmnQCehio7DOnM2qqCXfVoxaXXN4MjJ+qTdy8no=;
 b=bYupLdqQOaOabS6vjaldVAdSdE5cjn2ZLW1Hz97V0iptIRczlFeS/bGMYWJcYZqMnaMI3z
 Hn9ElrRebsDHOVveize2ZqzRnlFdQguVPbxizg7YOPacoIonX63a9mO7Vbyf8ry57sUsGp
 47bBQT7EhCVp9avCGkRWmvETRAH2+kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794924476;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=COMkQmnQCehio7DOnM2qqCXfVoxaXXN4MjJ+qTdy8no=;
 b=cslAJ9O1Z98CHoMuLoLhXaExyHelsINbs3DGLPwRYQgF5DlxY23hyo2CvIVC+Hn8k+TxXq
 T9UqUlbCc/yTgiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39F7613507;
 Tue, 17 Nov 2026 14:07:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lIVaDrtf/GpTJgAAD6G6ig:T3
 (envelope-from <tzimmermann@suse.de>); Tue, 17 Nov 2026 14:07:56 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 2/2] drm: Remove drm_crtc_init()
Date: Tue, 17 Nov 2026 15:04:30 +0100
Message-ID: <20261117140750.541769-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261117140750.541769-1-tzimmermann@suse.de>
References: <20261117140750.541769-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9E2EE22316
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
 RCPT_COUNT_SEVEN(0.00)[10];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -12.01
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There are no remaining users of drm_crtc_init(), so remove the helper
and the internal data structures for the primary plane that the helper
creates.

v3:
- keep plane->format_default for now
- remove obsolete include statements

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_crtc.c           | 19 +++----
 drivers/gpu/drm/drm_modeset_helper.c | 76 ----------------------------
 include/drm/drm_modeset_helper.h     |  3 --
 3 files changed, 7 insertions(+), 91 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 5295ec122e0d..614876415479 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -334,10 +334,7 @@ static int __drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *
  * @funcs: callbacks for the new CRTC
  * @name: printf style format string for the CRTC name, or NULL for default name
  *
- * Inits a new object created as base part of a driver crtc object. Drivers
- * should use this function instead of drm_crtc_init(), which is only provided
- * for backwards compatibility with drivers which do not yet support universal
- * planes).
+ * Inits a new object created as base part of a driver crtc object.
  * The &drm_crtc_funcs.destroy hook should call drm_crtc_cleanup() and kfree()
  * the crtc structure. The crtc structure should not be allocated with
  * devm_kzalloc().
@@ -417,10 +414,7 @@ static int __drmm_crtc_init_with_planes(struct drm_device *dev,
  * @funcs: callbacks for the new CRTC
  * @name: printf style format string for the CRTC name, or NULL for default name
  *
- * Inits a new object created as base part of a driver crtc object. Drivers
- * should use this function instead of drm_crtc_init(), which is only provided
- * for backwards compatibility with drivers which do not yet support universal
- * planes).
+ * Inits a new object created as base part of a driver crtc object.
  *
  * Cleanup is automatically handled through registering
  * drmm_crtc_cleanup() with drmm_add_action(). The crtc structure should
@@ -806,10 +800,11 @@ int drm_mode_setcrtc(struct drm_device *dev, void *data,
 
 		/*
 		 * Check whether the primary plane supports the fb pixel format.
-		 * Drivers not implementing the universal planes API use a
-		 * default formats list provided by the DRM core which doesn't
-		 * match real hardware capabilities. Skip the check in that
-		 * case.
+		 *
+		 * TODO:  Radeon does not implementing the universal planes API but
+		 *        uses a default formats list provided by the DRM core that
+		 *        doesn't match real hardware capabilities. Skip the check
+		 *        for now until radeon has been updated.
 		 */
 		if (!plane->format_default) {
 			if (!drm_plane_has_format(plane, fb->format->format, fb->modifier)) {
diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index cca623eb23e5..6ec23f8e0905 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -27,8 +27,6 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_modeset_helper.h>
-#include <drm/drm_panic_helper.h>
-#include <drm/drm_plane_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -101,80 +99,6 @@ void drm_helper_mode_fill_fb_struct(struct drm_device *dev,
 }
 EXPORT_SYMBOL(drm_helper_mode_fill_fb_struct);
 
-/*
- * This is the minimal list of formats that seem to be safe for modeset use
- * with all current DRM drivers.  Most hardware can actually support more
- * formats than this and drivers may specify a more accurate list when
- * creating the primary plane.
- */
-static const uint32_t safe_modeset_formats[] = {
-	DRM_FORMAT_XRGB8888,
-	DRM_FORMAT_ARGB8888,
-};
-
-static const struct drm_plane_funcs primary_plane_funcs = {
-	DRM_PLANE_NON_ATOMIC_FUNCS,
-	DRM_PANIC_PLANE_FUNCS,
-};
-
-/**
- * drm_crtc_init - Legacy CRTC initialization function
- * @dev: DRM device
- * @crtc: CRTC object to init
- * @funcs: callbacks for the new CRTC
- *
- * Initialize a CRTC object with a default helper-provided primary plane and no
- * cursor plane.
- *
- * Note that we make some assumptions about hardware limitations that may not be
- * true for all hardware:
- *
- * 1. Primary plane cannot be repositioned.
- * 2. Primary plane cannot be scaled.
- * 3. Primary plane must cover the entire CRTC.
- * 4. Subpixel positioning is not supported.
- * 5. The primary plane must always be on if the CRTC is enabled.
- *
- * This is purely a backwards compatibility helper for old drivers. Drivers
- * should instead implement their own primary plane. Atomic drivers must do so.
- *
- * Returns:
- * Zero on success, error code on failure.
- */
-int drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
-		  const struct drm_crtc_funcs *funcs)
-{
-	struct drm_plane *primary;
-	int ret;
-
-	/* possible_crtc's will be filled in later by crtc_init */
-	primary = __drm_universal_plane_alloc(dev, sizeof(*primary), 0, 0,
-					      &primary_plane_funcs,
-					      safe_modeset_formats,
-					      ARRAY_SIZE(safe_modeset_formats),
-					      NULL, DRM_PLANE_TYPE_PRIMARY, NULL);
-	if (IS_ERR(primary))
-		return PTR_ERR(primary);
-
-	/*
-	 * Remove the format_default field from drm_plane when dropping
-	 * this helper.
-	 */
-	primary->format_default = true;
-
-	ret = drm_crtc_init_with_planes(dev, crtc, primary, NULL, funcs, NULL);
-	if (ret)
-		goto err_drm_plane_cleanup;
-
-	return 0;
-
-err_drm_plane_cleanup:
-	drm_plane_cleanup(primary);
-	kfree(primary);
-	return ret;
-}
-EXPORT_SYMBOL(drm_crtc_init);
-
 /**
  * drm_mode_config_helper_suspend - Modeset suspend helper
  * @dev: DRM device
diff --git a/include/drm/drm_modeset_helper.h b/include/drm/drm_modeset_helper.h
index 7e3d4c5a7f66..6b9421aee536 100644
--- a/include/drm/drm_modeset_helper.h
+++ b/include/drm/drm_modeset_helper.h
@@ -37,9 +37,6 @@ void drm_helper_mode_fill_fb_struct(struct drm_device *dev,
 				    const struct drm_format_info *info,
 				    const struct drm_mode_fb_cmd2 *mode_cmd);
 
-int drm_crtc_init(struct drm_device *dev, struct drm_crtc *crtc,
-		  const struct drm_crtc_funcs *funcs);
-
 int drm_mode_config_helper_suspend(struct drm_device *dev);
 int drm_mode_config_helper_resume(struct drm_device *dev);
 
-- 
2.56.0

