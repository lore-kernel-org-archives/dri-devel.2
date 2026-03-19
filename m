Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6CE1090247
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B27810E90F;
	Thu, 19 Mar 2026 16:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="LP0JBo4b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DurUNpUX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LP0JBo4b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DurUNpUX";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 998F110E8DB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 16:01:54 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 14E3D5BD8B;
 Thu, 19 Mar 2026 16:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TynI2gXEMx2RShMh3dgkoOaaw/FPUKMVSwXv8ZJf/NE=;
 b=LP0JBo4b0t6zM66cE/1iISmLWnOxlA5oIsHquQDR5ahoItaTHcZYwnj99mIeH3HDeWmPl7
 vrvz8CYP8tJ6gWGxouJbEPtynOs5L1VlTrKrkSNcg3Ig+RzvI2Sjir4zLleTfrZiT14KQU
 p8CPrj5mystWzBeCbmac5stk/h+1s3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TynI2gXEMx2RShMh3dgkoOaaw/FPUKMVSwXv8ZJf/NE=;
 b=DurUNpUXC9++/uBDtE2PLDyC575PujHKFHhJKhf+vunMECAB3Hn8XBro94uqy+T9K83wNz
 w1OknzwL7W8NxIAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1773936082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TynI2gXEMx2RShMh3dgkoOaaw/FPUKMVSwXv8ZJf/NE=;
 b=LP0JBo4b0t6zM66cE/1iISmLWnOxlA5oIsHquQDR5ahoItaTHcZYwnj99mIeH3HDeWmPl7
 vrvz8CYP8tJ6gWGxouJbEPtynOs5L1VlTrKrkSNcg3Ig+RzvI2Sjir4zLleTfrZiT14KQU
 p8CPrj5mystWzBeCbmac5stk/h+1s3o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1773936082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TynI2gXEMx2RShMh3dgkoOaaw/FPUKMVSwXv8ZJf/NE=;
 b=DurUNpUXC9++/uBDtE2PLDyC575PujHKFHhJKhf+vunMECAB3Hn8XBro94uqy+T9K83wNz
 w1OknzwL7W8NxIAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6FA742767;
 Thu, 19 Mar 2026 16:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yPkPM88dvGn0WQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Mar 2026 16:01:19 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: david@lechnology.com, javierm@redhat.com, lanzano.alex@gmail.com,
 kamlesh.gurudasani@gmail.com, architanant5@gmail.com, wens@kernel.org,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, simona@ffwll.ch,
 airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 16/16] drm/simple-kms: Deprecate simple-kms helpers
Date: Thu, 19 Mar 2026 16:59:52 +0100
Message-ID: <20260319160110.109610-17-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319160110.109610-1-tzimmermann@suse.de>
References: <20260319160110.109610-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[lechnology.com,redhat.com,gmail.com,kernel.org,linux.intel.com,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Deprecate simple-encoder and simple-display-pipe helpers in favor of
regular atomic helpers. Remove the related documentation. Add TODO
item for converting the remaining drivers.

These helpers have been deprecated for years and many drivers have
been updated to not use them. Still there are a few left and we
occasionally receive new drivers build upon them. Marking them as
deprecated will hopefully resolve these problems. The TODO items
should be easy enough for getting new voluteers started on DRM driver
development.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: David Lechner <david@lechnology.com>
---
 Documentation/gpu/drm-kms-helpers.rst   |  12 --
 Documentation/gpu/introduction.rst      |   6 -
 Documentation/gpu/todo.rst              |  32 ++++
 drivers/gpu/drm/drm_crtc.c              |   6 +-
 drivers/gpu/drm/drm_gem_atomic_helper.c |  22 ---
 drivers/gpu/drm/drm_modeset_helper.c    |   3 -
 drivers/gpu/drm/drm_simple_kms_helper.c |  83 ---------
 include/drm/drm_simple_kms_helper.h     | 216 +-----------------------
 8 files changed, 39 insertions(+), 341 deletions(-)

diff --git a/Documentation/gpu/drm-kms-helpers.rst b/Documentation/gpu/drm-kms-helpers.rst
index 781129f78b06..b4a9e5ae81f6 100644
--- a/Documentation/gpu/drm-kms-helpers.rst
+++ b/Documentation/gpu/drm-kms-helpers.rst
@@ -104,18 +104,6 @@ VBLANK Helper Reference
 .. kernel-doc:: drivers/gpu/drm/drm_vblank_helper.c
    :export:
 
-Simple KMS Helper Reference
-===========================
-
-.. kernel-doc:: drivers/gpu/drm/drm_simple_kms_helper.c
-   :doc: overview
-
-.. kernel-doc:: include/drm/drm_simple_kms_helper.h
-   :internal:
-
-.. kernel-doc:: drivers/gpu/drm/drm_simple_kms_helper.c
-   :export:
-
 fbdev Helper Functions Reference
 ================================
 
diff --git a/Documentation/gpu/introduction.rst b/Documentation/gpu/introduction.rst
index 3cd0c8860b94..d8f519693fc2 100644
--- a/Documentation/gpu/introduction.rst
+++ b/Documentation/gpu/introduction.rst
@@ -119,12 +119,6 @@ Simple DRM drivers to use as examples
 The DRM subsystem contains a lot of helper functions to ease writing drivers for
 simple graphic devices. For example, the `drivers/gpu/drm/tiny/` directory has a
 set of drivers that are simple enough to be implemented in a single source file.
-
-These drivers make use of the `struct drm_simple_display_pipe_funcs`, that hides
-any complexity of the DRM subsystem and just requires drivers to implement a few
-functions needed to operate the device. This could be used for devices that just
-need a display pipeline with one full-screen scanout buffer feeding one output.
-
 The tiny DRM drivers are good examples to understand how DRM drivers should look
 like. Since are just a few hundreds lines of code, they are quite easy to read.
 
diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 520da44a04a6..bc9f14c8a2ec 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -29,6 +29,38 @@ refactorings already and are an expert in the specific area
 Subsystem-wide refactorings
 ===========================
 
+Open-code drm_simple_encoder_init()
+-----------------------------------
+
+The helper drm_simple_encoder_init() was supposed to simplify encoder
+initialization. Instead it only added an intermediate layer between atomic
+modesetting and the DRM driver.
+
+The task here is to remove drm_simple_encoder_init(). Search for a driver
+that calls drm_simple_encoder_init() and inline the helper. The driver will
+also need its own instance of drm_encoder_funcs.
+
+Contact: Thomas Zimmermann, respective driver maintainer
+
+Level: Easy
+
+Replace struct drm_simple_display_pipe with regular atomic helpers
+------------------------------------------------------------------
+
+The data type struct drm_simple_display_pipe and its helpers were supposed
+to simplify driver development. Instead they only added an intermediate layer
+between atomic modesetting and the DRM driver.
+
+There are still drivers that use drm_simple_display_pipe. The task here is to
+convert them to use regular atomic helpers. Search for a driver that calls
+drm_simple_display_pipe_init() and inline all helpers from drm_simple_kms_helper.c
+into the driver, such that no simple-KMS interfaces are required. Please also
+rename all inlined fucntions according to driver conventions.
+
+Contact: Thomas Zimmermann, respective driver maintainer
+
+Level: Easy
+
 Remove custom dumb_map_offset implementations
 ---------------------------------------------
 
diff --git a/drivers/gpu/drm/drm_crtc.c b/drivers/gpu/drm/drm_crtc.c
index 8d6f721c2c9a..63ead8ba6756 100644
--- a/drivers/gpu/drm/drm_crtc.c
+++ b/drivers/gpu/drm/drm_crtc.c
@@ -340,8 +340,7 @@ static int __drm_crtc_init_with_planes(struct drm_device *dev, struct drm_crtc *
  * Inits a new object created as base part of a driver crtc object. Drivers
  * should use this function instead of drm_crtc_init(), which is only provided
  * for backwards compatibility with drivers which do not yet support universal
- * planes). For really simple hardware which has only 1 plane look at
- * drm_simple_display_pipe_init() instead.
+ * planes).
  * The &drm_crtc_funcs.destroy hook should call drm_crtc_cleanup() and kfree()
  * the crtc structure. The crtc structure should not be allocated with
  * devm_kzalloc().
@@ -424,8 +423,7 @@ static int __drmm_crtc_init_with_planes(struct drm_device *dev,
  * Inits a new object created as base part of a driver crtc object. Drivers
  * should use this function instead of drm_crtc_init(), which is only provided
  * for backwards compatibility with drivers which do not yet support universal
- * planes). For really simple hardware which has only 1 plane look at
- * drm_simple_display_pipe_init() instead.
+ * planes).
  *
  * Cleanup is automatically handled through registering
  * drmm_crtc_cleanup() with drmm_add_action(). The crtc structure should
diff --git a/drivers/gpu/drm/drm_gem_atomic_helper.c b/drivers/gpu/drm/drm_gem_atomic_helper.c
index 421c460ac972..abef865c5f2c 100644
--- a/drivers/gpu/drm/drm_gem_atomic_helper.c
+++ b/drivers/gpu/drm/drm_gem_atomic_helper.c
@@ -87,28 +87,6 @@
  * A mapping address for each of the framebuffer's buffer object is stored in
  * struct &drm_shadow_plane_state.map. The mappings are valid while the state
  * is being used.
- *
- * Drivers that use struct drm_simple_display_pipe can use
- * %DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS to initialize the rsp
- * callbacks. Access to shadow-buffer mappings is similar to regular
- * atomic_update.
- *
- * .. code-block:: c
- *
- *	struct drm_simple_display_pipe_funcs driver_pipe_funcs = {
- *		...,
- *		DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
- *	};
- *
- *	void driver_pipe_enable(struct drm_simple_display_pipe *pipe,
- *				struct drm_crtc_state *crtc_state,
- *				struct drm_plane_state *plane_state)
- *	{
- *		struct drm_shadow_plane_state *shadow_plane_state =
- *			to_drm_shadow_plane_state(plane_state);
- *
- *		// access shadow buffer via shadow_plane_state->map
- *	}
  */
 
 /*
diff --git a/drivers/gpu/drm/drm_modeset_helper.c b/drivers/gpu/drm/drm_modeset_helper.c
index a57f6a10ada4..d7721df744e7 100644
--- a/drivers/gpu/drm/drm_modeset_helper.c
+++ b/drivers/gpu/drm/drm_modeset_helper.c
@@ -135,9 +135,6 @@ static const struct drm_plane_funcs primary_plane_funcs = {
  *
  * This is purely a backwards compatibility helper for old drivers. Drivers
  * should instead implement their own primary plane. Atomic drivers must do so.
- * Drivers with the above hardware restriction can look into using &struct
- * drm_simple_display_pipe, which encapsulates the above limitations into a nice
- * interface.
  *
  * Returns:
  * Zero on success, error code on failure.
diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index fcbcaaa36b5f..4d91513a1e34 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -16,55 +16,10 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
 
-/**
- * DOC: overview
- *
- * This helper library provides helpers for drivers for simple display
- * hardware.
- *
- * drm_simple_display_pipe_init() initializes a simple display pipeline
- * which has only one full-screen scanout buffer feeding one output. The
- * pipeline is represented by &struct drm_simple_display_pipe and binds
- * together &drm_plane, &drm_crtc and &drm_encoder structures into one fixed
- * entity. Some flexibility for code reuse is provided through a separately
- * allocated &drm_connector object and supporting optional &drm_bridge
- * encoder drivers.
- *
- * Many drivers require only a very simple encoder that fulfills the minimum
- * requirements of the display pipeline and does not add additional
- * functionality. The function drm_simple_encoder_init() provides an
- * implementation of such an encoder.
- */
-
 static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup = {
 	.destroy = drm_encoder_cleanup,
 };
 
-/**
- * drm_simple_encoder_init - Initialize a preallocated encoder with
- *                           basic functionality.
- * @dev: drm device
- * @encoder: the encoder to initialize
- * @encoder_type: user visible type of the encoder
- *
- * Initialises a preallocated encoder that has no further functionality.
- * Settings for possible CRTC and clones are left to their initial values.
- * The encoder will be cleaned up automatically as part of the mode-setting
- * cleanup.
- *
- * The caller of drm_simple_encoder_init() is responsible for freeing
- * the encoder's memory after the encoder has been cleaned up. At the
- * moment this only works reliably if the encoder data structure is
- * stored in the device structure. Free the encoder's memory as part of
- * the device release function.
- *
- * Note: consider using drmm_simple_encoder_alloc() instead of
- * drm_simple_encoder_init() to let the DRM managed resource infrastructure
- * take care of cleanup and deallocation.
- *
- * Returns:
- * Zero on success, error code on failure.
- */
 int drm_simple_encoder_init(struct drm_device *dev,
 			    struct drm_encoder *encoder,
 			    int encoder_type)
@@ -370,20 +325,6 @@ static const struct drm_plane_funcs drm_simple_kms_plane_funcs = {
 	.format_mod_supported   = drm_simple_kms_format_mod_supported,
 };
 
-/**
- * drm_simple_display_pipe_attach_bridge - Attach a bridge to the display pipe
- * @pipe: simple display pipe object
- * @bridge: bridge to attach
- *
- * Makes it possible to still use the drm_simple_display_pipe helpers when
- * a DRM bridge has to be used.
- *
- * Note that you probably want to initialize the pipe by passing a NULL
- * connector to drm_simple_display_pipe_init().
- *
- * Returns:
- * Zero on success, negative error code on failure.
- */
 int drm_simple_display_pipe_attach_bridge(struct drm_simple_display_pipe *pipe,
 					  struct drm_bridge *bridge)
 {
@@ -391,30 +332,6 @@ int drm_simple_display_pipe_attach_bridge(struct drm_simple_display_pipe *pipe,
 }
 EXPORT_SYMBOL(drm_simple_display_pipe_attach_bridge);
 
-/**
- * drm_simple_display_pipe_init - Initialize a simple display pipeline
- * @dev: DRM device
- * @pipe: simple display pipe object to initialize
- * @funcs: callbacks for the display pipe (optional)
- * @formats: array of supported formats (DRM_FORMAT\_\*)
- * @format_count: number of elements in @formats
- * @format_modifiers: array of formats modifiers
- * @connector: connector to attach and register (optional)
- *
- * Sets up a display pipeline which consist of a really simple
- * plane-crtc-encoder pipe.
- *
- * If a connector is supplied, the pipe will be coupled with the provided
- * connector. You may supply a NULL connector when using drm bridges, that
- * handle connectors themselves (see drm_simple_display_pipe_attach_bridge()).
- *
- * Teardown of a simple display pipe is all handled automatically by the drm
- * core through calling drm_mode_config_cleanup(). Drivers afterwards need to
- * release the memory for the structure themselves.
- *
- * Returns:
- * Zero on success, negative error code on failure.
- */
 int drm_simple_display_pipe_init(struct drm_device *dev,
 			struct drm_simple_display_pipe *pipe,
 			const struct drm_simple_display_pipe_funcs *funcs,
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index b2486d073763..cb672ce0e856 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -3,6 +3,11 @@
  * Copyright (C) 2016 Noralf Trønnes
  */
 
+/*
+ * Simple KMS helpers are deprected in favor of regular atomic helpers. Do not
+ * use the min new code.
+ */
+
 #ifndef __LINUX_DRM_SIMPLE_KMS_HELPER_H
 #define __LINUX_DRM_SIMPLE_KMS_HELPER_H
 
@@ -12,233 +17,38 @@
 
 struct drm_simple_display_pipe;
 
-/**
- * struct drm_simple_display_pipe_funcs - helper operations for a simple
- *                                        display pipeline
- */
 struct drm_simple_display_pipe_funcs {
-	/**
-	 * @mode_valid:
-	 *
-	 * This callback is used to check if a specific mode is valid in the
-	 * crtc used in this simple display pipe. This should be implemented
-	 * if the display pipe has some sort of restriction in the modes
-	 * it can display. For example, a given display pipe may be responsible
-	 * to set a clock value. If the clock can not produce all the values
-	 * for the available modes then this callback can be used to restrict
-	 * the number of modes to only the ones that can be displayed. Another
-	 * reason can be bandwidth mitigation: the memory port on the display
-	 * controller can have bandwidth limitations not allowing pixel data
-	 * to be fetched at any rate.
-	 *
-	 * This hook is used by the probe helpers to filter the mode list in
-	 * drm_helper_probe_single_connector_modes(), and it is used by the
-	 * atomic helpers to validate modes supplied by userspace in
-	 * drm_atomic_helper_check_modeset().
-	 *
-	 * This function is optional.
-	 *
-	 * NOTE:
-	 *
-	 * Since this function is both called from the check phase of an atomic
-	 * commit, and the mode validation in the probe paths it is not allowed
-	 * to look at anything else but the passed-in mode, and validate it
-	 * against configuration-invariant hardware constraints.
-	 *
-	 * RETURNS:
-	 *
-	 * drm_mode_status Enum
-	 */
 	enum drm_mode_status (*mode_valid)(struct drm_simple_display_pipe *pipe,
 					   const struct drm_display_mode *mode);
-
-	/**
-	 * @enable:
-	 *
-	 * This function should be used to enable the pipeline.
-	 * It is called when the underlying crtc is enabled.
-	 * This hook is optional.
-	 */
 	void (*enable)(struct drm_simple_display_pipe *pipe,
 		       struct drm_crtc_state *crtc_state,
 		       struct drm_plane_state *plane_state);
-	/**
-	 * @disable:
-	 *
-	 * This function should be used to disable the pipeline.
-	 * It is called when the underlying crtc is disabled.
-	 * This hook is optional.
-	 */
 	void (*disable)(struct drm_simple_display_pipe *pipe);
-
-	/**
-	 * @check:
-	 *
-	 * This function is called in the check phase of an atomic update,
-	 * specifically when the underlying plane is checked.
-	 * The simple display pipeline helpers already check that the plane is
-	 * not scaled, fills the entire visible area and is always enabled
-	 * when the crtc is also enabled.
-	 * This hook is optional.
-	 *
-	 * RETURNS:
-	 *
-	 * 0 on success, -EINVAL if the state or the transition can't be
-	 * supported, -ENOMEM on memory allocation failure and -EDEADLK if an
-	 * attempt to obtain another state object ran into a &drm_modeset_lock
-	 * deadlock.
-	 */
 	int (*check)(struct drm_simple_display_pipe *pipe,
 		     struct drm_plane_state *plane_state,
 		     struct drm_crtc_state *crtc_state);
-	/**
-	 * @update:
-	 *
-	 * This function is called when the underlying plane state is updated.
-	 * This hook is optional.
-	 *
-	 * This is the function drivers should submit the
-	 * &drm_pending_vblank_event from. Using either
-	 * drm_crtc_arm_vblank_event(), when the driver supports vblank
-	 * interrupt handling, or drm_crtc_send_vblank_event() for more
-	 * complex case. In case the hardware lacks vblank support entirely,
-	 * drivers can set &struct drm_crtc_state.no_vblank in
-	 * &struct drm_simple_display_pipe_funcs.check and let DRM's
-	 * atomic helper fake a vblank event.
-	 */
 	void (*update)(struct drm_simple_display_pipe *pipe,
 		       struct drm_plane_state *old_plane_state);
-
-	/**
-	 * @prepare_fb:
-	 *
-	 * Optional, called by &drm_plane_helper_funcs.prepare_fb.  Please read
-	 * the documentation for the &drm_plane_helper_funcs.prepare_fb hook for
-	 * more details.
-	 *
-	 * For GEM drivers who neither have a @prepare_fb nor @cleanup_fb hook
-	 * set, drm_gem_plane_helper_prepare_fb() is called automatically
-	 * to implement this. Other drivers which need additional plane
-	 * processing can call drm_gem_plane_helper_prepare_fb() from
-	 * their @prepare_fb hook.
-	 */
 	int (*prepare_fb)(struct drm_simple_display_pipe *pipe,
 			  struct drm_plane_state *plane_state);
-
-	/**
-	 * @cleanup_fb:
-	 *
-	 * Optional, called by &drm_plane_helper_funcs.cleanup_fb.  Please read
-	 * the documentation for the &drm_plane_helper_funcs.cleanup_fb hook for
-	 * more details.
-	 */
 	void (*cleanup_fb)(struct drm_simple_display_pipe *pipe,
 			   struct drm_plane_state *plane_state);
-
-	/**
-	 * @begin_fb_access:
-	 *
-	 * Optional, called by &drm_plane_helper_funcs.begin_fb_access. Please read
-	 * the documentation for the &drm_plane_helper_funcs.begin_fb_access hook for
-	 * more details.
-	 */
 	int (*begin_fb_access)(struct drm_simple_display_pipe *pipe,
 			       struct drm_plane_state *new_plane_state);
-
-	/**
-	 * @end_fb_access:
-	 *
-	 * Optional, called by &drm_plane_helper_funcs.end_fb_access. Please read
-	 * the documentation for the &drm_plane_helper_funcs.end_fb_access hook for
-	 * more details.
-	 */
 	void (*end_fb_access)(struct drm_simple_display_pipe *pipe,
 			      struct drm_plane_state *plane_state);
-
-	/**
-	 * @enable_vblank:
-	 *
-	 * Optional, called by &drm_crtc_funcs.enable_vblank. Please read
-	 * the documentation for the &drm_crtc_funcs.enable_vblank hook for
-	 * more details.
-	 */
 	int (*enable_vblank)(struct drm_simple_display_pipe *pipe);
-
-	/**
-	 * @disable_vblank:
-	 *
-	 * Optional, called by &drm_crtc_funcs.disable_vblank. Please read
-	 * the documentation for the &drm_crtc_funcs.disable_vblank hook for
-	 * more details.
-	 */
 	void (*disable_vblank)(struct drm_simple_display_pipe *pipe);
-
-	/**
-	 * @reset_crtc:
-	 *
-	 * Optional, called by &drm_crtc_funcs.reset. Please read the
-	 * documentation for the &drm_crtc_funcs.reset hook for more details.
-	 */
 	void (*reset_crtc)(struct drm_simple_display_pipe *pipe);
-
-	/**
-	 * @duplicate_crtc_state:
-	 *
-	 * Optional, called by &drm_crtc_funcs.atomic_duplicate_state. Please
-	 * read the documentation for the &drm_crtc_funcs.atomic_duplicate_state
-	 * hook for more details.
-	 */
 	struct drm_crtc_state * (*duplicate_crtc_state)(struct drm_simple_display_pipe *pipe);
-
-	/**
-	 * @destroy_crtc_state:
-	 *
-	 * Optional, called by &drm_crtc_funcs.atomic_destroy_state. Please
-	 * read the documentation for the &drm_crtc_funcs.atomic_destroy_state
-	 * hook for more details.
-	 */
 	void (*destroy_crtc_state)(struct drm_simple_display_pipe *pipe,
 				   struct drm_crtc_state *crtc_state);
-
-	/**
-	 * @reset_plane:
-	 *
-	 * Optional, called by &drm_plane_funcs.reset. Please read the
-	 * documentation for the &drm_plane_funcs.reset hook for more details.
-	 */
 	void (*reset_plane)(struct drm_simple_display_pipe *pipe);
-
-	/**
-	 * @duplicate_plane_state:
-	 *
-	 * Optional, called by &drm_plane_funcs.atomic_duplicate_state.  Please
-	 * read the documentation for the &drm_plane_funcs.atomic_duplicate_state
-	 * hook for more details.
-	 */
 	struct drm_plane_state * (*duplicate_plane_state)(struct drm_simple_display_pipe *pipe);
-
-	/**
-	 * @destroy_plane_state:
-	 *
-	 * Optional, called by &drm_plane_funcs.atomic_destroy_state.  Please
-	 * read the documentation for the &drm_plane_funcs.atomic_destroy_state
-	 * hook for more details.
-	 */
 	void (*destroy_plane_state)(struct drm_simple_display_pipe *pipe,
 				    struct drm_plane_state *plane_state);
 };
 
-/**
- * struct drm_simple_display_pipe - simple display pipeline
- * @crtc: CRTC control structure
- * @plane: Plane control structure
- * @encoder: Encoder control structure
- * @connector: Connector control structure
- * @funcs: Pipeline control functions (optional)
- *
- * Simple display pipeline with plane, crtc and encoder collapsed into one
- * entity. It should be initialized by calling drm_simple_display_pipe_init().
- */
 struct drm_simple_display_pipe {
 	struct drm_crtc crtc;
 	struct drm_plane plane;
@@ -265,22 +75,6 @@ int drm_simple_encoder_init(struct drm_device *dev,
 void *__drmm_simple_encoder_alloc(struct drm_device *dev, size_t size,
 				  size_t offset, int encoder_type);
 
-/**
- * drmm_simple_encoder_alloc - Allocate and initialize an encoder with basic
- *                             functionality.
- * @dev: drm device
- * @type: the type of the struct which contains struct &drm_encoder
- * @member: the name of the &drm_encoder within @type.
- * @encoder_type: user visible type of the encoder
- *
- * Allocates and initializes an encoder that has no further functionality.
- * Settings for possible CRTC and clones are left to their initial values.
- * Cleanup is automatically handled through registering drm_encoder_cleanup()
- * with drmm_add_action().
- *
- * Returns:
- * Pointer to new encoder, or ERR_PTR on failure.
- */
 #define drmm_simple_encoder_alloc(dev, type, member, encoder_type) \
 	((type *)__drmm_simple_encoder_alloc(dev, sizeof(type), \
 					     offsetof(type, member), \
-- 
2.53.0

