Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B74410FC462
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 23:35:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9365410E6F1;
	Wed,  8 Apr 2026 23:35:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Omlq5ywM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3857410E6F1;
 Wed,  8 Apr 2026 23:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775691323; x=1807227323;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YpKhjeIDRRojp4/+gWwVJdB7lL7GUbyNAx7M7+hH8ok=;
 b=Omlq5ywM0qJ3h3P0Ya6oUn2totG9NqAN2W+DSkqIYA2ECdTyyclhJppH
 pl16iejNr25hrC2r0r/rUOqlMh4tTy1ZDjgPQadhOcn9cWIBnCvJDrhym
 0EE5VCEjHF0byiY2hnPCt77xy6VAFlySMzhi1677tTsFig29xo3ecBp4X
 1dQIlxIW/v1sbjMoVBU5qgREJa9q0OzQiHAEbB8268MhU2PHaOoJOqewg
 4eJJ2TkW5enwpq3ijZZ0ukpmIGPra1mNGScMgSdW3Ve5QXCviQZA4bOwg
 NTC05gFXk9w2XW0GExSlMRPs93R4Nn1YaCE46SW64AvFbY7hKwOb6mCFH g==;
X-CSE-ConnectionGUID: JT3goBsCQsOokYtBZkKGcQ==
X-CSE-MsgGUID: x9Sp+H4JQdKwWyylKERccA==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76705998"
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="76705998"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 16:35:23 -0700
X-CSE-ConnectionGUID: S6Df5EmCRJmzcubc+jucYA==
X-CSE-MsgGUID: uM2d4nagSUWjgxSQ6hk9BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,168,1770624000"; d="scan'208";a="230273131"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.73])
 by fmviesa004-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2026 16:35:20 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Simona Vetter <simona.vetter@ffwll.ch>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@intel.com>,
 =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 3/6] drm/i915/reset: Move pending_fb_pin handling to i915
Date: Thu,  9 Apr 2026 02:34:55 +0300
Message-ID: <20260408233458.22666-4-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260408233458.22666-1-ville.syrjala@linux.intel.com>
References: <20260408233458.22666-1-ville.syrjala@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Only i915 uses the pending_fb_pin counter to potentially whack
the GPU harder if the display gets nuked during a GPU reset.
Move the atomic counter into the i915 specific bits of code, so
that we don't need to worry about on the display side.

For some reason the overlay code kept the pending_fb_pin counter
elevated for longer than just for the pin, but from now on it'll
just cover the actual pinning part.

Cc: Simona Vetter <simona.vetter@ffwll.ch>
Cc: Christian König <christian.koenig@amd.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 .../gpu/drm/i915/display/intel_display_core.h |  1 -
 .../drm/i915/display/intel_display_reset.c    |  9 +--------
 .../drm/i915/display/intel_display_reset.h    |  5 +----
 drivers/gpu/drm/i915/display/intel_overlay.c  | 10 ++--------
 drivers/gpu/drm/i915/gt/intel_reset.c         | 19 ++++++++++---------
 drivers/gpu/drm/i915/i915_dpt.c               |  5 ++---
 drivers/gpu/drm/i915/i915_drv.h               |  2 ++
 drivers/gpu/drm/i915/i915_fb_pin.c            |  9 ++++-----
 drivers/gpu/drm/i915/i915_overlay.c           |  6 ++++++
 9 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_core.h b/drivers/gpu/drm/i915/display/intel_display_core.h
index d708d322aa85..9e77003addd0 100644
--- a/drivers/gpu/drm/i915/display/intel_display_core.h
+++ b/drivers/gpu/drm/i915/display/intel_display_core.h
@@ -561,7 +561,6 @@ struct intel_display {
 		struct drm_atomic_state *modeset_state;
 		struct drm_modeset_acquire_ctx reset_ctx;
 		/* modeset stuck tracking for reset */
-		atomic_t pending_fb_pin;
 		u32 saveDSPARB;
 		u32 saveSWF0[16];
 		u32 saveSWF1[16];
diff --git a/drivers/gpu/drm/i915/display/intel_display_reset.c b/drivers/gpu/drm/i915/display/intel_display_reset.c
index 137a2a33c8b0..ca15dc18ef0f 100644
--- a/drivers/gpu/drm/i915/display/intel_display_reset.c
+++ b/drivers/gpu/drm/i915/display/intel_display_reset.c
@@ -27,19 +27,12 @@ bool intel_display_reset_test(struct intel_display *display)
 		display->params.force_reset_modeset_test;
 }
 
-void intel_display_reset_prepare(struct intel_display *display,
-				 modeset_stuck_fn modeset_stuck, void *context)
+void intel_display_reset_prepare(struct intel_display *display)
 {
 	struct drm_modeset_acquire_ctx *ctx = &display->restore.reset_ctx;
 	struct drm_atomic_state *state;
 	int ret;
 
-	if (atomic_read(&display->restore.pending_fb_pin)) {
-		drm_dbg_kms(display->drm,
-			    "Modeset potentially stuck, unbreaking through wedging\n");
-		modeset_stuck(context);
-	}
-
 	/*
 	 * Need mode_config.mutex so that we don't
 	 * trample ongoing ->detect() and whatnot.
diff --git a/drivers/gpu/drm/i915/display/intel_display_reset.h b/drivers/gpu/drm/i915/display/intel_display_reset.h
index e0f15e757728..a8aa7729d33f 100644
--- a/drivers/gpu/drm/i915/display/intel_display_reset.h
+++ b/drivers/gpu/drm/i915/display/intel_display_reset.h
@@ -10,12 +10,9 @@
 
 struct intel_display;
 
-typedef void modeset_stuck_fn(void *context);
-
 bool intel_display_reset_supported(struct intel_display *display);
 bool intel_display_reset_test(struct intel_display *display);
-void intel_display_reset_prepare(struct intel_display *display,
-				 modeset_stuck_fn modeset_stuck, void *context);
+void intel_display_reset_prepare(struct intel_display *display);
 void intel_display_reset_finish(struct intel_display *display, bool test_only);
 
 #endif /* __INTEL_RESET_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_overlay.c b/drivers/gpu/drm/i915/display/intel_overlay.c
index 12a325ceae6f..a809aa2950ac 100644
--- a/drivers/gpu/drm/i915/display/intel_overlay.c
+++ b/drivers/gpu/drm/i915/display/intel_overlay.c
@@ -481,13 +481,9 @@ static int intel_overlay_do_put_image(struct intel_overlay *overlay,
 	if (ret != 0)
 		return ret;
 
-	atomic_inc(&display->restore.pending_fb_pin);
-
 	vma = intel_parent_overlay_pin_fb(display, obj, &offset);
-	if (IS_ERR(vma)) {
-		ret = PTR_ERR(vma);
-		goto out_pin_section;
-	}
+	if (IS_ERR(vma))
+		return PTR_ERR(vma);
 
 	if (!intel_parent_overlay_is_active(display)) {
 		const struct intel_crtc_state *crtc_state =
@@ -571,8 +567,6 @@ static int intel_overlay_do_put_image(struct intel_overlay *overlay,
 
 out_unpin:
 	intel_parent_overlay_unpin_fb(display, vma);
-out_pin_section:
-	atomic_dec(&display->restore.pending_fb_pin);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/i915/gt/intel_reset.c b/drivers/gpu/drm/i915/gt/intel_reset.c
index ffd11767874f..a1e6aaca8c9b 100644
--- a/drivers/gpu/drm/i915/gt/intel_reset.c
+++ b/drivers/gpu/drm/i915/gt/intel_reset.c
@@ -1398,11 +1398,6 @@ int intel_engine_reset(struct intel_engine_cs *engine, const char *msg)
 	return err;
 }
 
-static void display_reset_modeset_stuck(void *gt)
-{
-	intel_gt_set_wedged(gt);
-}
-
 static void intel_gt_reset_global(struct intel_gt *gt,
 				  u32 engine_mask,
 				  const char *reason)
@@ -1434,10 +1429,16 @@ static void intel_gt_reset_global(struct intel_gt *gt,
 			intel_display_reset_test(display) ||
 			need_display_reset;
 
-		if (reset_display)
-			intel_display_reset_prepare(display,
-						    display_reset_modeset_stuck,
-						    gt);
+		if (reset_display) {
+			if (atomic_read(&i915->pending_fb_pin)) {
+				drm_dbg_kms(&i915->drm,
+					    "Modeset potentially stuck, unbreaking through wedging\n");
+
+				intel_gt_set_wedged(gt);
+			}
+
+			intel_display_reset_prepare(display);
+		}
 
 		intel_gt_reset(gt, engine_mask, reason);
 
diff --git a/drivers/gpu/drm/i915/i915_dpt.c b/drivers/gpu/drm/i915/i915_dpt.c
index 9f47bb563c85..fcd7cced771d 100644
--- a/drivers/gpu/drm/i915/i915_dpt.c
+++ b/drivers/gpu/drm/i915/i915_dpt.c
@@ -129,7 +129,6 @@ static void dpt_cleanup(struct i915_address_space *vm)
 struct i915_vma *i915_dpt_pin_to_ggtt(struct intel_dpt *dpt, unsigned int alignment)
 {
 	struct drm_i915_private *i915 = dpt->vm.i915;
-	struct intel_display *display = i915->display;
 	struct ref_tracker *wakeref;
 	struct i915_vma *vma;
 	void __iomem *iomem;
@@ -141,7 +140,7 @@ struct i915_vma *i915_dpt_pin_to_ggtt(struct intel_dpt *dpt, unsigned int alignm
 		pin_flags |= PIN_MAPPABLE;
 
 	wakeref = intel_runtime_pm_get(&i915->runtime_pm);
-	atomic_inc(&display->restore.pending_fb_pin);
+	atomic_inc(&i915->pending_fb_pin);
 
 	for_i915_gem_ww(&ww, err, true) {
 		err = i915_gem_object_lock(dpt->obj, &ww);
@@ -171,7 +170,7 @@ struct i915_vma *i915_dpt_pin_to_ggtt(struct intel_dpt *dpt, unsigned int alignm
 
 	dpt->obj->mm.dirty = true;
 
-	atomic_dec(&display->restore.pending_fb_pin);
+	atomic_dec(&i915->pending_fb_pin);
 	intel_runtime_pm_put(&i915->runtime_pm, wakeref);
 
 	return err ? ERR_PTR(err) : vma;
diff --git a/drivers/gpu/drm/i915/i915_drv.h b/drivers/gpu/drm/i915/i915_drv.h
index dafee3dcd1c5..844ed79e7211 100644
--- a/drivers/gpu/drm/i915/i915_drv.h
+++ b/drivers/gpu/drm/i915/i915_drv.h
@@ -315,6 +315,8 @@ struct drm_i915_private {
 	/* The TTM device structure. */
 	struct ttm_device bdev;
 
+	atomic_t pending_fb_pin;
+
 	I915_SELFTEST_DECLARE(struct i915_selftest_stash selftest;)
 
 	/*
diff --git a/drivers/gpu/drm/i915/i915_fb_pin.c b/drivers/gpu/drm/i915/i915_fb_pin.c
index 1018f4b7bc2c..a08a8ace681f 100644
--- a/drivers/gpu/drm/i915/i915_fb_pin.c
+++ b/drivers/gpu/drm/i915/i915_fb_pin.c
@@ -29,7 +29,6 @@ intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
 		    unsigned long *out_flags,
 		    struct intel_dpt *dpt)
 {
-	struct intel_display *display = to_intel_display(fb->dev);
 	struct drm_i915_private *i915 = to_i915(fb->dev);
 	struct drm_gem_object *_obj = intel_fb_bo(fb);
 	struct drm_i915_gem_object *obj = to_intel_bo(_obj);
@@ -48,7 +47,7 @@ intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
 	if (WARN_ON(!i915_gem_object_is_framebuffer(obj)))
 		return ERR_PTR(-EINVAL);
 
-	atomic_inc(&display->restore.pending_fb_pin);
+	atomic_inc(&i915->pending_fb_pin);
 
 	for_i915_gem_ww(&ww, ret, true) {
 		ret = i915_gem_object_lock(obj, &ww);
@@ -103,7 +102,7 @@ intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
 
 	i915_vma_get(vma);
 err:
-	atomic_dec(&display->restore.pending_fb_pin);
+	atomic_dec(&i915->pending_fb_pin);
 
 	return vma;
 }
@@ -142,7 +141,7 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 	 */
 	wakeref = intel_runtime_pm_get(&i915->runtime_pm);
 
-	atomic_inc(&display->restore.pending_fb_pin);
+	atomic_inc(&i915->pending_fb_pin);
 
 	/*
 	 * Valleyview is definitely limited to scanning out the first
@@ -218,7 +217,7 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 	if (ret)
 		vma = ERR_PTR(ret);
 
-	atomic_dec(&display->restore.pending_fb_pin);
+	atomic_dec(&i915->pending_fb_pin);
 	intel_runtime_pm_put(&i915->runtime_pm, wakeref);
 	return vma;
 }
diff --git a/drivers/gpu/drm/i915/i915_overlay.c b/drivers/gpu/drm/i915/i915_overlay.c
index 2d7aff51e39b..6de550a17756 100644
--- a/drivers/gpu/drm/i915/i915_overlay.c
+++ b/drivers/gpu/drm/i915/i915_overlay.c
@@ -354,11 +354,14 @@ static struct i915_vma *i915_overlay_pin_fb(struct drm_device *drm,
 					    struct drm_gem_object *obj,
 					    u32 *offset)
 {
+	struct drm_i915_private *i915 = to_i915(drm);
 	struct drm_i915_gem_object *new_bo = to_intel_bo(obj);
 	struct i915_gem_ww_ctx ww;
 	struct i915_vma *vma;
 	int ret;
 
+	atomic_inc(&i915->pending_fb_pin);
+
 	i915_gem_ww_ctx_init(&ww, true);
 retry:
 	ret = i915_gem_object_lock(new_bo, &ww);
@@ -373,6 +376,9 @@ static struct i915_vma *i915_overlay_pin_fb(struct drm_device *drm,
 			goto retry;
 	}
 	i915_gem_ww_ctx_fini(&ww);
+
+	atomic_dec(&i915->pending_fb_pin);
+
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.52.0

