Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF67606A321
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=TUTlgG/6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AE4C10FDC4;
	Wed, 11 Nov 2026 16:09:16 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8696010FDC2;
 Wed, 11 Nov 2026 16:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=S6FVGPb1ZvpOph0pJYvEx0mS+mnul1pNHVlTgogu8qQ=;
 t=1794413349; x=2109773349; b=TUTlgG/6LrNdJisRLg6NGGpFCBTqr9IlLwzpdaQKR7lphnN
 BmwQ8trVpyW7BFNyZ7x88rDGeuyBlBMwc8vERO6Jdcot0oL0TWuw6DChG6pSYOKzTBqbPNeah0VV9
 a8Pnij2JcTGlhqeREh5c/x+fsR064+43Xp/zmVZp8kyV9zBB4/ks0SEuf9jXUzEQVK3vqRY//cf6a
 54yk3X7vgPqfnYa4RWj9R/x6s3IRKG1H0ShypsNWAAHBE/4Aby5j7OBpvyUEitnpZMUZiX1E+A+cu
 Ys1rdFiFy7pB+jgisMJfwzpCVqMqgja5It7NB5Xb7DvLxsF5KuQ7kdUuQQTiR5zg==;
Received: from 193.red-79-147-123.dynamicip.rima-tde.net ([79.147.123.193]
 helo=killbill) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1xRAsN-008u8Y-KC; Wed, 11 Nov 2026 17:08:43 +0100
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, christian.koenig@amd.com, contact@emersion.fr,
 daniels@collabora.com, harry.wentland@amd.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mwen@igalia.com,
 sebastian.wick@redhat.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@gmail.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, louis.chauvet@bootlin.com,
 John Harrison <John.Harrison@igalia.com>
Subject: [PATCH v5 13/15] drm/amd/display: allow individual colorop changes
Date: Wed, 11 Nov 2026 17:05:26 +0100
Message-ID: <20261111160814.21326-14-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111160814.21326-1-mwen@igalia.com>
References: <20261111160814.21326-1-mwen@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If userspace modifies a single property of a colorop but doesn't
resubmit the entire color pipeline, the other colorops will not be
present in the commit; consequently, on plane recreation, the system
would silently fall back to the legacy color path instead of maintaining
the previously applied settings. Commit 20331505df9c ("drm/amd/display:
pull colorops into state when recreating a plane") addresses this issue
by ensuring that all colorops associated with a plane are included in
the commit whenever that plane is recreated, because at this point, only
new colorop states were taken into account in an atomic commit.

Use the committed state of a colorop within the active color pipeline
when the commit doesn't introduce a new state for it. A colorop that is
not included in the commit remains unchanged; therefore, its committed
state is also its new state. Consequently, remove the call to
drm_atomic_add_affected_colorops() from dm_update_plane_state(), since a
duplicated colorop state would just contain those same,
already-committed values. Also fix AMD KUnit color test accordingly.

Fixes: 9ba25915efba ("drm/amd/display: Add support for sRGB EOTF in DEGAM block")
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  13 --
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 213 +++++++-----------
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |  15 +-
 3 files changed, 92 insertions(+), 149 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0ea45ab12119..4d6a965d2b6b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6048,19 +6048,6 @@ dm_update_plane_state(struct dc *dc,
 		if (ret)
 			goto out;
 
-		/*
-		 * Recreating the plane re-derives its DC color pipeline from the
-		 * colorop states in this commit. Pull the plane's colorops in so
-		 * the derivation sees the current pipeline; otherwise every stage
-		 * silently defaults to bypass (dropping YUV->RGB, shaper, 3D LUT
-		 * and regamma) when userspace didn't touch color in this commit.
-		 */
-		if (new_plane_state->color_pipeline) {
-			ret = drm_atomic_add_affected_colorops(state, plane);
-			if (ret)
-				goto out;
-		}
-
 		WARN_ON(dm_new_plane_state->dc_state);
 
 		dc_new_plane_state = dc_create_plane_state(dc);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index f53228072fc8..7332c8874397 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1592,21 +1592,14 @@ __set_dm_plane_colorop_fixed_matrix(struct drm_plane_state *plane_state,
 				    struct dc_plane_state *dc_plane_state,
 				    struct drm_colorop *colorop)
 {
-	struct drm_colorop *old_colorop;
-	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
+	struct drm_colorop_state *colorop_state = NULL;
 	struct drm_atomic_commit *state = plane_state->state;
-	int i = 0;
-
-	old_colorop = colorop;
-
-	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-		if (new_colorop_state->colorop == old_colorop) {
-			colorop_state = new_colorop_state;
-			break;
-		}
-	}
 
+	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
 	if (!colorop_state)
+		colorop_state = colorop->state;
+
+	if (colorop->type != DRM_COLOROP_FIXED_MATRIX)
 		return -EINVAL;
 
 	if (colorop_state->bypass) {
@@ -1647,24 +1640,13 @@ __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
 			       struct dc_plane_state *dc_plane_state,
 			       struct drm_colorop *colorop)
 {
-	struct drm_colorop *old_colorop;
-	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
+	struct drm_colorop_state *colorop_state;
 	struct drm_atomic_commit *state = plane_state->state;
-	int i = 0;
-
-	old_colorop = colorop;
 
 	/* 1st op: 1d curve - degamma */
-	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-		if (new_colorop_state->colorop == old_colorop &&
-		    (BIT(new_colorop_state->curve_1d_type) & amdgpu_dm_supported_degam_tfs)) {
-			colorop_state = new_colorop_state;
-			break;
-		}
-	}
-
+	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
 	if (!colorop_state)
-		return -EINVAL;
+		colorop_state = colorop->state;
 
 	return __set_colorop_in_tf_1d_curve(dc_plane_state, colorop_state);
 }
@@ -1675,43 +1657,37 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
 				  struct dc_plane_state *dc_plane_state,
 				  struct drm_colorop *colorop)
 {
-	struct drm_colorop *old_colorop;
-	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
+	struct drm_colorop_state *colorop_state;
 	struct drm_atomic_commit *state = plane_state->state;
 	const struct drm_device *dev = colorop->dev;
 	const struct drm_property_blob *blob;
 	struct drm_color_ctm_3x4 *ctm = NULL;
-	int i = 0;
 
 	/* 3x4 matrix */
-	old_colorop = colorop;
-	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-		if (new_colorop_state->colorop == old_colorop &&
-		    new_colorop_state->colorop->type == DRM_COLOROP_CTM_3X4) {
-			colorop_state = new_colorop_state;
-			break;
-		}
+	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+	if (!colorop_state)
+		colorop_state = colorop->state;
+
+	if (colorop->type != DRM_COLOROP_CTM_3X4)
+		return -EINVAL;
+
+	if (colorop_state->bypass) {
+		dc_plane_state->gamut_remap_matrix.enable_remap = false;
+		dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
+		return 0;
 	}
 
-	if (colorop_state && colorop->type == DRM_COLOROP_CTM_3X4) {
-		if (colorop_state->bypass) {
-			dc_plane_state->gamut_remap_matrix.enable_remap = false;
-			dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
-			return 0;
-		}
-
-		drm_dbg(dev, "3x4 matrix colorop with ID: %d\n", colorop->base.id);
-		blob = colorop_state->data;
-		if (blob->length == sizeof(struct drm_color_ctm_3x4)) {
-			ctm = (struct drm_color_ctm_3x4 *) blob->data;
-			__drm_ctm_3x4_to_dc_matrix(ctm, dc_plane_state->gamut_remap_matrix.matrix);
-			dc_plane_state->gamut_remap_matrix.enable_remap = true;
-			dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
-		} else {
-			drm_warn(dev, "blob->length (%zu) isn't equal to drm_color_ctm_3x4 (%zu)\n",
-				 blob->length, sizeof(struct drm_color_ctm_3x4));
-			return -EINVAL;
-		}
+	drm_dbg(dev, "3x4 matrix colorop with ID: %d\n", colorop->base.id);
+	blob = colorop_state->data;
+	if (blob->length == sizeof(struct drm_color_ctm_3x4)) {
+		ctm = (struct drm_color_ctm_3x4 *) blob->data;
+		__drm_ctm_3x4_to_dc_matrix(ctm, dc_plane_state->gamut_remap_matrix.matrix);
+		dc_plane_state->gamut_remap_matrix.enable_remap = true;
+		dc_plane_state->input_csc_color_matrix.enable_adjustment = false;
+	} else {
+		drm_warn(dev, "blob->length (%zu) isn't equal to drm_color_ctm_3x4 (%zu)\n",
+			 blob->length, sizeof(struct drm_color_ctm_3x4));
+		return -EINVAL;
 	}
 
 	return 0;
@@ -1723,29 +1699,23 @@ __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
 				  struct dc_plane_state *dc_plane_state,
 				  struct drm_colorop *colorop)
 {
-	struct drm_colorop *old_colorop;
-	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
+	struct drm_colorop_state *colorop_state;
 	struct drm_atomic_commit *state = plane_state->state;
 	const struct drm_device *dev = colorop->dev;
-	int i = 0;
 
 	/* Multiplier */
-	old_colorop = colorop;
-	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-		if (new_colorop_state->colorop == old_colorop &&
-		    new_colorop_state->colorop->type == DRM_COLOROP_MULTIPLIER) {
-			colorop_state = new_colorop_state;
-			break;
-		}
-	}
+	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+	if (!colorop_state)
+		colorop_state = colorop->state;
 
-	if (colorop_state && colorop->type == DRM_COLOROP_MULTIPLIER) {
-		if (colorop_state->bypass) {
-			dc_plane_state->hdr_mult = dc_fixpt_one;
-		} else {
-			drm_dbg(dev, "Multiplier colorop with ID: %d\n", colorop->base.id);
-			dc_plane_state->hdr_mult = amdgpu_dm_fixpt_from_s3132(colorop_state->multiplier);
-		}
+	if (colorop->type != DRM_COLOROP_MULTIPLIER)
+		return -EINVAL;
+
+	if (colorop_state->bypass) {
+		dc_plane_state->hdr_mult = dc_fixpt_one;
+	} else {
+		drm_dbg(dev, "Multiplier colorop with ID: %d\n", colorop->base.id);
+		dc_plane_state->hdr_mult = amdgpu_dm_fixpt_from_s3132(colorop_state->multiplier);
 	}
 
 	return 0;
@@ -1757,8 +1727,6 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 			      struct dc_plane_state *dc_plane_state,
 			      struct drm_colorop *colorop)
 {
-	struct drm_colorop *old_colorop;
-	struct drm_colorop_state *new_colorop_state;
 	struct drm_colorop_state *tf_state = NULL, *lut_state = NULL;
 	struct drm_atomic_commit *state = plane_state->state;
 	struct drm_colorop *lut_colorop;
@@ -1767,38 +1735,32 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 	const struct drm_color_lut32 *shaper_lut;
 	struct drm_device *dev = colorop->dev;
 	u32 shaper_size;
-	int i = 0, ret = 0;
+	int ret = 0;
 
 	tf->type = TF_TYPE_BYPASS;
 	dc_plane_state->cm.flags.bits.shaper_enable = 0;
 
 	/* 1D Curve - SHAPER TF: find state */
-	old_colorop = colorop;
-	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-		if (new_colorop_state->colorop == old_colorop &&
-		    (BIT(new_colorop_state->curve_1d_type) & amdgpu_dm_supported_shaper_tfs)) {
-			tf_state = new_colorop_state;
-			break;
-		}
-	}
+	if (colorop->type != DRM_COLOROP_1D_CURVE)
+		return -EINVAL;
+
+	tf_state = drm_atomic_get_new_colorop_state(state, colorop);
+	if (!tf_state)
+		tf_state = colorop->state;
 
 	/* 1D LUT - SHAPER LUT: find state */
-	lut_colorop = old_colorop->next;
-	if (!lut_colorop) {
+	lut_colorop = colorop->next;
+	if (!lut_colorop || lut_colorop->type != DRM_COLOROP_1D_LUT) {
 		drm_dbg(dev, "no Shaper LUT colorop found\n");
 		return -EINVAL;
 	}
 
-	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-		if (new_colorop_state->colorop == lut_colorop &&
-		    new_colorop_state->colorop->type == DRM_COLOROP_1D_LUT) {
-			lut_state = new_colorop_state;
-			break;
-		}
-	}
+	lut_state = drm_atomic_get_new_colorop_state(state, lut_colorop);
+	if (!lut_state)
+		lut_state = lut_colorop->state;
 
-	if (tf_state && !tf_state->bypass) {
-		drm_dbg(dev, "Shaper TF colorop with ID: %d\n", old_colorop->base.id);
+	if (!tf_state->bypass) {
+		drm_dbg(dev, "Shaper TF colorop with ID: %d\n", colorop->base.id);
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(tf_state->curve_1d_type);
 		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
@@ -1808,7 +1770,7 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 		dc_plane_state->cm.flags.bits.shaper_enable = 1;
 	}
 
-	if (lut_state && !lut_state->bypass) {
+	if (!lut_state->bypass) {
 		drm_dbg(dev, "Shaper LUT colorop with ID: %d\n", lut_colorop->base.id);
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf;
@@ -1865,8 +1827,7 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
 			     struct dc_plane_state *dc_plane_state,
 			     struct drm_colorop *colorop)
 {
-	struct drm_colorop *old_colorop;
-	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
+	struct drm_colorop_state *colorop_state;
 	struct dc_transfer_func *tf = &dc_plane_state->cm.shaper_func;
 	struct drm_atomic_commit *state = plane_state->state;
 	const struct amdgpu_device *adev = drm_to_adev(colorop->dev);
@@ -1874,19 +1835,17 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
 	const struct drm_device *dev = colorop->dev;
 	const struct drm_color_lut32 *lut3d;
 	uint32_t lut3d_size;
-	int i = 0, ret = 0;
+	int ret = 0;
 
 	/* 3D LUT */
-	old_colorop = colorop;
-	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-		if (new_colorop_state->colorop == old_colorop &&
-		    new_colorop_state->colorop->type == DRM_COLOROP_3D_LUT) {
-			colorop_state = new_colorop_state;
-			break;
-		}
-	}
+	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
+	if (!colorop_state)
+		colorop_state = colorop->state;
 
-	if (colorop_state && !colorop_state->bypass && colorop->type == DRM_COLOROP_3D_LUT) {
+	if (colorop->type != DRM_COLOROP_3D_LUT)
+		return -EINVAL;
+
+	if (!colorop_state->bypass) {
 		if (!has_3dlut) {
 			drm_dbg(dev, "3D LUT is not supported by hardware\n");
 			return -EINVAL;
@@ -1926,8 +1885,6 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 			     struct dc_plane_state *dc_plane_state,
 			     struct drm_colorop *colorop)
 {
-	struct drm_colorop *old_colorop;
-	struct drm_colorop_state *new_colorop_state;
 	struct drm_colorop_state *tf_state = NULL, *lut_state = NULL;
 	struct drm_atomic_commit *state = plane_state->state;
 	struct drm_colorop *lut_colorop;
@@ -1936,38 +1893,32 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 	const struct drm_color_lut32 *blend_lut = NULL;
 	struct drm_device *dev = colorop->dev;
 	uint32_t blend_size = 0;
-	int i = 0, ret;
+	int ret;
 
 	tf->type = TF_TYPE_BYPASS;
 	dc_plane_state->cm.flags.bits.blend_enable = 0;
 
 	/* 1D Curve - BLND TF: find state */
-	old_colorop = colorop;
-	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-		if (new_colorop_state->colorop == old_colorop &&
-		    (BIT(new_colorop_state->curve_1d_type) & amdgpu_dm_supported_blnd_tfs)) {
-			tf_state = new_colorop_state;
-			break;
-		}
-	}
+	if (colorop->type != DRM_COLOROP_1D_CURVE)
+		return -EINVAL;
+
+	tf_state = drm_atomic_get_new_colorop_state(state, colorop);
+	if (!tf_state)
+		tf_state = colorop->state;
 
 	/* 1D LUT - BLND LUT: find state */
-	lut_colorop = old_colorop->next;
-	if (!lut_colorop) {
+	lut_colorop = colorop->next;
+	if (!lut_colorop || lut_colorop->type != DRM_COLOROP_1D_LUT) {
 		drm_dbg(dev, "no Blend LUT colorop found\n");
 		return -EINVAL;
 	}
 
-	for_each_new_colorop_in_state(state, colorop, new_colorop_state, i) {
-		if (new_colorop_state->colorop == lut_colorop &&
-		    new_colorop_state->colorop->type == DRM_COLOROP_1D_LUT) {
-			lut_state = new_colorop_state;
-			break;
-		}
-	}
+	lut_state = drm_atomic_get_new_colorop_state(state, lut_colorop);
+	if (!lut_state)
+		lut_state = lut_colorop->state;
 
-	if (tf_state && !tf_state->bypass) {
-		drm_dbg(dev, "Blend TF colorop with ID: %d\n", old_colorop->base.id);
+	if (!tf_state->bypass) {
+		drm_dbg(dev, "Blend TF colorop with ID: %d\n", colorop->base.id);
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf = amdgpu_colorop_tf_to_dc_tf(tf_state->curve_1d_type);
 		tf->sdr_ref_white_level = SDR_WHITE_LEVEL_INIT_VALUE;
@@ -1977,7 +1928,7 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 		dc_plane_state->cm.flags.bits.blend_enable = 1;
 	}
 
-	if (lut_state && !lut_state->bypass) {
+	if (!lut_state->bypass) {
 		drm_dbg(dev, "Blend LUT colorop with ID: %d\n", lut_colorop->base.id);
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
index d2ae35bf550f..8e00da61a04b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_color_test.c
@@ -1847,8 +1847,9 @@ struct dm_test_colorop_fixture {
  * @test: KUnit test context
  * @type: colorop type to assign
  *
- * Fabricates a minimal drm_atomic_commit with one colorop slot so that
- * for_each_new_colorop_in_state() finds exactly the colorop under test.
+ * Fabricates a minimal drm_atomic_commit with the colorop in the only colorop
+ * slot (index 0), so that drm_atomic_get_new_colorop_state() returns its new
+ * state.
  *
  * Returns: a populated fixture (by value).
  */
@@ -1865,6 +1866,7 @@ dm_test_colorop_setup(struct kunit *test, enum drm_colorop_type type)
 	f.colorop = kunit_kzalloc(test, sizeof(*f.colorop), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, f.colorop);
 	f.colorop->dev = &f.adev->ddev;
+	f.colorop->index = 0;
 	f.colorop->type = type;
 
 	f.colorop_state = kunit_kzalloc(test, sizeof(*f.colorop_state), GFP_KERNEL);
@@ -1911,8 +1913,10 @@ static void dm_test_colorop_multiplier_applied(struct kunit *test)
 }
 
 /**
- * dm_test_colorop_multiplier_no_match - Non-multiplier colorop leaves hdr_mult untouched
+ * dm_test_colorop_multiplier_no_match - Non-multiplier colorop: return -EINVAL.
  * @test: KUnit test context
+ *
+ * left hdr_mult untouched
  */
 static void dm_test_colorop_multiplier_no_match(struct kunit *test)
 {
@@ -1923,7 +1927,7 @@ static void dm_test_colorop_multiplier_no_match(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test,
 			__set_dm_plane_colorop_multiplier(f.plane_state, f.dc_plane_state, f.colorop),
-			0);
+			-EINVAL);
 	KUNIT_EXPECT_EQ(test, f.dc_plane_state->hdr_mult.value, 0LL);
 }
 
@@ -2414,7 +2418,7 @@ static void dm_test_update_plane_color_mgmt_plane_ctm(struct kunit *test)
  * dm_test_colorop_pipeline_add - append one colorop to a fabricated pipeline
  * @test: KUnit test context
  * @f: color update fixture that owns the atomic state
- * @index: colorop array index to populate
+ * @index: colorop array index to populate, also used as the colorop index
  * @type: colorop type
  * @curve_1d_type: 1D curve type for DRM_COLOROP_1D_CURVE states
  * @bypass: bypass flag for the new colorop state
@@ -2434,6 +2438,7 @@ dm_test_colorop_pipeline_add(struct kunit *test,
 	colorop = kunit_kzalloc(test, sizeof(*colorop), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, colorop);
 	colorop->dev = &f->adev->ddev;
+	colorop->index = index;
 	colorop->type = type;
 	colorop->size = MAX_COLOR_LUT_ENTRIES;
 
-- 
2.53.0

