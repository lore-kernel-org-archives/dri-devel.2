Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EEBCD98C7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C7610E56E;
	Tue,  9 Jun 2026 17:20:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NzhIgnmj";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA75010E56E
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7hKD688BR4DRBO7R1bLR1TicQyQ74tXehnXvakTOCLk=; b=NzhIgnmj83+ayycuJvv73rSSVN
 XaA+D+CTDpyfNCvc3hLVy0toPpJAAMeaqdXDbfLsypUoArUW/zW5rYoThKw1uhdUaOUS5Tns4eadN
 3wSqkY8PcTEdoSCpvDkBv80nw78ZauLsNP8UyYTVlhJFFImcogcw0Eeu0XBlntBBO4VU2khA89DnY
 HLNagRhVu8F+KPqa/QPDKnLK534t+4XQVQNgogoC3JbzKQEoqcYZr5KyGZgYqSt3nVehUcq/jWr72
 WxeIvEptLXhyxJdJ49jjHMw6/ByDesF8FjS61XHmfWiRfwQpd0BbpZUY1c/hCMwVYCI/tYSPCklzB
 kcYkTAFQ==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wX087-00F5FG-HF; Tue, 09 Jun 2026 19:20:48 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Subject: [RFC PATCH 7/8] drm/colorop: Convert pipline 'next' pointer to a list
Date: Tue,  9 Jun 2026 10:19:40 -0700
Message-ID: <20260609171941.169104-8-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609171941.169104-1-John.Harrison@Igalia.com>
References: <20260609171941.169104-1-John.Harrison@Igalia.com>
MIME-Version: 1.0
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

The colorop pipeline system was using explicit next pointers and open
coded lists rather than the official kernel list helpers. Fix that.

The result is a little odd. There is no pipeline object as such -
pipelines are just a sequence of colorop objects and defined by
whatever arbitrary colorop object happens to be first in the sequence.
Therefore, there is no clear place to put the list head object. It
has to go inside the first colorop in the pipe. Which means there is a
list head inside *every* colorop object, regardless of whether it is the
head of a pipeline or not. Most of them are just empty lists.

Signed-off-by: John Harrison <John.Harrison@Igalia.com>
Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 60 ++++++++++---------
 drivers/gpu/drm/drm_atomic.c                  | 15 ++++-
 drivers/gpu/drm/drm_colorop.c                 | 16 +++--
 drivers/gpu/drm/i915/display/intel_plane.c    | 14 +++--
 drivers/gpu/drm/vkms/vkms_composer.c          |  9 +--
 include/drm/drm_colorop.h                     | 18 +++++-
 6 files changed, 79 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 86086d10c543..e6de93f25362 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1629,21 +1629,21 @@ __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
 static int
 __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 			      struct dc_plane_state *dc_plane_state,
-			      struct drm_colorop *colorop)
+			      struct drm_colorop *pipeline)
 {
-	struct drm_colorop *old_colorop;
+	struct drm_colorop *old_colorop, *colorop;
 	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
 	struct drm_atomic_commit *state = plane_state->state;
 	enum dc_transfer_func_predefined default_tf = TRANSFER_FUNCTION_LINEAR;
 	struct dc_transfer_func *tf = &dc_plane_state->in_shaper_func;
 	const struct drm_color_lut32 *shaper_lut;
-	struct drm_device *dev = colorop->dev;
+	struct drm_device *dev = pipeline->dev;
 	bool enabled = false;
 	u32 shaper_size;
 	int i = 0, ret = 0;
 
 	/* 1D Curve - SHAPER TF */
-	old_colorop = colorop;
+	old_colorop = pipeline;
 	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
 		if (new_colorop_state->colorop == old_colorop &&
 		    (BIT(new_colorop_state->curve_1d_type) & amdgpu_dm_supported_shaper_tfs)) {
@@ -1664,11 +1664,11 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 	}
 
 	/* 1D LUT - SHAPER LUT */
-	colorop = old_colorop->next;
-	if (!colorop) {
+	if (list_is_last(&old_colorop->pipeline_list, &pipeline->pipeline_head)) {
 		drm_dbg(dev, "no Shaper LUT colorop found\n");
 		return -EINVAL;
 	}
+	colorop = list_next_entry(old_colorop, pipeline_list);
 
 	old_colorop = colorop;
 	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
@@ -1793,20 +1793,20 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
 static int
 __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 			     struct dc_plane_state *dc_plane_state,
-			     struct drm_colorop *colorop)
+			     struct drm_colorop *pipeline)
 {
-	struct drm_colorop *old_colorop;
+	struct drm_colorop *old_colorop, *colorop;
 	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
 	struct drm_atomic_commit *state = plane_state->state;
 	enum dc_transfer_func_predefined default_tf = TRANSFER_FUNCTION_LINEAR;
 	struct dc_transfer_func *tf = &dc_plane_state->blend_tf;
 	const struct drm_color_lut32 *blend_lut = NULL;
-	struct drm_device *dev = colorop->dev;
+	struct drm_device *dev = pipeline->dev;
 	uint32_t blend_size = 0;
 	int i = 0;
 
 	/* 1D Curve - BLND TF */
-	old_colorop = colorop;
+	old_colorop = pipeline;
 	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
 		if (new_colorop_state->colorop == old_colorop &&
 		    (BIT(new_colorop_state->curve_1d_type) & amdgpu_dm_supported_blnd_tfs)) {
@@ -1825,11 +1825,11 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 	}
 
 	/* 1D Curve - BLND LUT */
-	colorop = old_colorop->next;
-	if (!colorop) {
+	if (list_is_last(&old_colorop->pipeline_list, &pipeline->pipeline_head)) {
 		drm_dbg(dev, "no Blend LUT colorop found\n");
 		return -EINVAL;
 	}
+	colorop = list_next_entry(old_colorop, pipeline_list);
 
 	old_colorop = colorop;
 	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
@@ -1911,14 +1911,15 @@ static int
 amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
 				       struct dc_plane_state *dc_plane_state)
 {
-	struct drm_colorop *colorop = plane_state->color_pipeline;
+	struct drm_colorop *pipeline = plane_state->color_pipeline;
+	struct drm_colorop *colorop = pipeline;
 	struct drm_device *dev = plane_state->plane->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	bool has_3dlut = adev->dm.dc->caps.color.dpp.hw_3d_lut || adev->dm.dc->caps.color.mpc.preblend;
 	int ret;
 
 	/* 1D Curve - DEGAM TF */
-	if (!colorop)
+	if (!pipeline)
 		return -EINVAL;
 
 	ret = __set_dm_plane_colorop_degamma(plane_state, dc_plane_state, colorop);
@@ -1926,71 +1927,74 @@ amdgpu_dm_plane_set_colorop_properties(struct drm_plane_state *plane_state,
 		return ret;
 
 	/* Multiplier */
-	colorop = colorop->next;
-	if (!colorop) {
+	if (list_is_last(&colorop->pipeline_list, &pipeline->pipeline_head)) {
 		drm_dbg(dev, "no multiplier colorop found\n");
 		return -EINVAL;
 	}
 
+	colorop = list_next_entry(colorop, pipeline_list);
 	ret = __set_dm_plane_colorop_multiplier(plane_state, dc_plane_state, colorop);
 	if (ret)
 		return ret;
 
 	/* 3x4 matrix */
-	colorop = colorop->next;
-	if (!colorop) {
+	if (list_is_last(&colorop->pipeline_list, &pipeline->pipeline_head)) {
 		drm_dbg(dev, "no 3x4 matrix colorop found\n");
 		return -EINVAL;
 	}
 
+	colorop = list_next_entry(colorop, pipeline_list);
 	ret = __set_dm_plane_colorop_3x4_matrix(plane_state, dc_plane_state, colorop);
 	if (ret)
 		return ret;
 
 	if (has_3dlut) {
 		/* 1D Curve & LUT - SHAPER TF & LUT */
-		colorop = colorop->next;
-		if (!colorop) {
+		if (list_is_last(&colorop->pipeline_list, &pipeline->pipeline_head)) {
 			drm_dbg(dev, "no Shaper TF colorop found\n");
 			return -EINVAL;
 		}
 
+		colorop = list_next_entry(colorop, pipeline_list);
 		ret = __set_dm_plane_colorop_shaper(plane_state, dc_plane_state, colorop);
 		if (ret)
 			return ret;
 
 		/* Shaper LUT colorop is already handled, just skip here */
-		colorop = colorop->next;
-		if (!colorop)
+		if (list_is_last(&colorop->pipeline_list, &pipeline->pipeline_head)) {
+			drm_dbg(dev, "no Shaper LUT colorop found\n");
 			return -EINVAL;
+		}
+		colorop = list_next_entry(colorop, pipeline_list);
 
 		/* 3D LUT */
-		colorop = colorop->next;
-		if (!colorop) {
+		if (list_is_last(&colorop->pipeline_list, &pipeline->pipeline_head)) {
 			drm_dbg(dev, "no 3D LUT colorop found\n");
 			return -EINVAL;
 		}
 
+		colorop = list_next_entry(colorop, pipeline_list);
 		ret = __set_dm_plane_colorop_3dlut(plane_state, dc_plane_state, colorop);
 		if (ret)
 			return ret;
 	}
 
 	/* 1D Curve & LUT - BLND TF & LUT */
-	colorop = colorop->next;
-	if (!colorop) {
+	if (list_is_last(&colorop->pipeline_list, &pipeline->pipeline_head)) {
 		drm_dbg(dev, "no Blend TF colorop found\n");
 		return -EINVAL;
 	}
 
+	colorop = list_next_entry(colorop, pipeline_list);
 	ret = __set_dm_plane_colorop_blend(plane_state, dc_plane_state, colorop);
 	if (ret)
 		return ret;
 
 	/* BLND LUT colorop is already handled, just skip here */
-	colorop = colorop->next;
-	if (!colorop)
+	if (list_is_last(&colorop->pipeline_list, &pipeline->pipeline_head)) {
+		drm_dbg(dev, "no Blend LUT colorop found\n");
 		return -EINVAL;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
index 3af1b9cc9a06..e2a75b70604d 100644
--- a/drivers/gpu/drm/drm_atomic.c
+++ b/drivers/gpu/drm/drm_atomic.c
@@ -893,10 +893,14 @@ static int drm_atomic_plane_check(const struct drm_plane_state *old_plane_state,
 }
 
 static void drm_atomic_colorop_print_state(struct drm_printer *p,
+					   struct drm_colorop **pipeline,
 					   const struct drm_colorop_state *state)
 {
 	struct drm_colorop *colorop = state->colorop;
 
+	if (!*pipeline)
+		*pipeline = colorop;
+
 	drm_printf(p, "colorop[%u]:\n", colorop->base.id);
 	drm_printf_indent(p, 1, "type=%s\n", drm_get_colorop_type_name(colorop->type));
 	if (colorop->bypass_property)
@@ -929,7 +933,12 @@ static void drm_atomic_colorop_print_state(struct drm_printer *p,
 		break;
 	}
 
-	drm_printf_indent(p, 1, "next=%d\n", colorop->next ? colorop->next->base.id : 0);
+	if (list_is_last(&colorop->pipeline_list, &(*pipeline)->pipeline_head)) {
+		*pipeline = NULL;
+		return;
+	}
+
+	drm_printf_indent(p, 1, "next=%d\n", list_next_entry(colorop, pipeline_list)->base.id);
 }
 
 static void drm_atomic_plane_print_state(struct drm_printer *p,
@@ -2125,7 +2134,7 @@ static void __drm_state_dump(struct drm_device *dev, struct drm_printer *p,
 			     bool take_locks)
 {
 	struct drm_mode_config *config = &dev->mode_config;
-	struct drm_colorop *colorop;
+	struct drm_colorop *colorop, *colorop_pipeline = NULL;
 	struct drm_plane *plane;
 	struct drm_crtc *crtc;
 	struct drm_connector *connector;
@@ -2138,7 +2147,7 @@ static void __drm_state_dump(struct drm_device *dev, struct drm_printer *p,
 	list_for_each_entry(colorop, &config->colorop_list, head) {
 		if (take_locks)
 			drm_modeset_lock(&colorop->plane->mutex, NULL);
-		drm_atomic_colorop_print_state(p, colorop->state);
+		drm_atomic_colorop_print_state(p, &colorop_pipeline, colorop->state);
 		if (take_locks)
 			drm_modeset_unlock(&colorop->plane->mutex);
 	}
diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
index 5a6d05557bc4..5b4e71e90623 100644
--- a/drivers/gpu/drm/drm_colorop.c
+++ b/drivers/gpu/drm/drm_colorop.c
@@ -109,7 +109,8 @@ static int drm_plane_colorop_init(struct drm_device *dev, struct drm_colorop *co
 	colorop->dev = dev;
 	colorop->type = type;
 	colorop->plane = plane;
-	colorop->next = NULL;
+	INIT_LIST_HEAD(&colorop->pipeline_list);
+	INIT_LIST_HEAD(&colorop->pipeline_head);
 	colorop->funcs = funcs;
 
 	list_add_tail(&colorop->head, &config->colorop_list);
@@ -651,16 +652,13 @@ const char *drm_get_colorop_lut3d_interpolation_name(enum drm_colorop_lut3d_inte
  */
 void drm_colorop_add_to_pipeline(struct drm_colorop *pipeline, struct drm_colorop *colorop)
 {
-	struct drm_colorop *last = pipeline;
+	struct drm_colorop *last;
 
-	/* Head entry does not need processing */
-	if (colorop == pipeline)
-		return;
+	last = list_last_entry_or_null(&pipeline->pipeline_head, struct drm_colorop, pipeline_list);
 
-	while (last->next)
-		last = last->next;
+	if (last)
+		drm_object_property_set_value(&last->base, last->next_property, colorop->base.id);
 
-	drm_object_property_set_value(&last->base, last->next_property, colorop->base.id);
-	last->next = colorop;
+	list_add_tail(&colorop->pipeline_list, &pipeline->pipeline_head);
 }
 EXPORT_SYMBOL(drm_colorop_add_to_pipeline);
diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index 3eaf82477f49..877c20ed62bd 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -413,21 +413,23 @@ intel_plane_color_copy_uapi_to_hw_state(struct intel_atomic_state *state,
 					const struct intel_plane_state *from_plane_state,
 					struct intel_crtc *crtc)
 {
-	struct drm_colorop *iter_colorop, *colorop;
+	struct drm_colorop *iter_colorop, *colorop, *pipeline;
 	struct drm_colorop_state *new_colorop_state;
 	struct intel_colorop *intel_colorop;
 	struct drm_property_blob *blob;
-	struct intel_crtc_state *new_crtc_state = state ?
-		intel_atomic_get_new_crtc_state(state, crtc) : NULL;
+	struct intel_crtc_state *new_crtc_state;
 	bool changed = false;
 	int i = 0;
 
 	if (!state)
 		return;
 
-	iter_colorop = from_plane_state->uapi.color_pipeline;
+	pipeline = from_plane_state->uapi.color_pipeline;
+	if (!pipeline)
+		return;
 
-	while (iter_colorop) {
+	WARN_ON(!list_is_first(&pipeline->pipeline_list, &pipeline->pipeline_head));
+	list_for_each_entry(iter_colorop, &pipeline->pipeline_head, pipeline_list) {
 		for_each_new_colorop_in_state(&state->base, colorop, new_colorop_state, i) {
 			if (new_colorop_state->colorop == iter_colorop) {
 				blob = new_colorop_state->bypass ? NULL : new_colorop_state->data;
@@ -437,9 +439,9 @@ intel_plane_color_copy_uapi_to_hw_state(struct intel_atomic_state *state,
 									    blob);
 			}
 		}
-		iter_colorop = iter_colorop->next;
 	}
 
+	new_crtc_state = intel_atomic_get_new_crtc_state(state, crtc);
 	if (new_crtc_state && changed)
 		new_crtc_state->plane_color_changed = true;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 83d217085ad0..fc20b788738a 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -194,9 +194,12 @@ static void pre_blend_color_transform(const struct vkms_plane_state *plane_state
 				      struct line_buffer *output_buffer)
 {
 	struct pixel_argb_s32 pixel;
+	struct drm_colorop *pipeline = plane_state->base.base.color_pipeline;
+
+	WARN_ON(!list_is_first(&pipeline->pipeline_list, &pipeline->pipeline_head));
 
 	for (size_t x = 0; x < output_buffer->n_pixels; x++) {
-		struct drm_colorop *colorop = plane_state->base.base.color_pipeline;
+		struct drm_colorop *colorop;
 
 		/*
 		 * Some operations, such as applying a BT709 encoding matrix,
@@ -213,7 +216,7 @@ static void pre_blend_color_transform(const struct vkms_plane_state *plane_state
 		pixel.g = output_buffer->pixels[x].g;
 		pixel.b = output_buffer->pixels[x].b;
 
-		while (colorop) {
+		list_for_each_entry(colorop, &pipeline->pipeline_head, pipeline_list) {
 			struct drm_colorop_state *colorop_state;
 
 			colorop_state = colorop->state;
@@ -223,8 +226,6 @@ static void pre_blend_color_transform(const struct vkms_plane_state *plane_state
 
 			if (!colorop_state->bypass)
 				apply_colorop(&pixel, colorop);
-
-			colorop = colorop->next;
 		}
 
 		/* clamp values */
diff --git a/include/drm/drm_colorop.h b/include/drm/drm_colorop.h
index 6888d27e5592..f500a6077e60 100644
--- a/include/drm/drm_colorop.h
+++ b/include/drm/drm_colorop.h
@@ -271,12 +271,24 @@ struct drm_colorop {
 	enum drm_colorop_type type;
 
 	/**
-	 * @next:
+	 * @pipeline_head:
 	 *
 	 * Read-only
-	 * Pointer to next drm_colorop in pipeline
+	 * List head for the pipeline. Only valid if this drm_colorop object is the
+	 * head of a pipeline. Will be an empty list for all other drm_colorop objects.
+	 * Invariant once the pipeline has been constructed. So does not need locking.
 	 */
-	struct drm_colorop *next;
+	struct list_head pipeline_head;
+
+	/**
+	 * @pipeline_list:
+	 *
+	 * Read-only
+	 * List entry within the @pipeline_head list of the pipeline that this colorop
+	 * is part of. Invariant once the pipeline has been constructed. So does not
+	 * need locking.
+	 */
+	struct list_head pipeline_list;
 
 	/**
 	 * @type_property:
-- 
2.43.0

