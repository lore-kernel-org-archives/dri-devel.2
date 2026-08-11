Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5744C5CFF1
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 17:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF28910ED14;
	Tue, 11 Aug 2026 17:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="D/DPUs7d";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB88F10ED11;
 Tue, 11 Aug 2026 17:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:From:Reply-To; bh=XVMBGqTk/9YJw70TQfyjjGjaNAXjD6CUcjV68YGm7aU=; b=
 D/DPUs7d+fAm367bgQOdXllDr1/9bIa80CTpXzTabuH5m8Em1O1WJwMMVHF9tjTuLn5Uqx9bXPDql
 3V71IqefIAqxqYCvc/xXXO6OSI0HRtg5hlqmp1xJyVLV34gTQe3c3lCPXnLCHNeatNqAtupXWENur
 1762VtZDA/7/l/FdGo4C4j2IdjYw9ghAiqhshBdUpm2aMmLgh8Hn6oZWNUzKQ78yvSQGSEOhA7pKb
 WHmJ75v8gk1kGaXEGyLbU1qo3qZumvnG5sSJhUr5N3vbtwpzSBbzM22P4BnGjvJmLSu287jNF/FFl
 6MIB2OEGkTd2i06mfeYgoRKbDIl3qI/qgQ==;
Received: from 154.red-79-147-121.dynamicip.rima-tde.net ([79.147.121.154]
 helo=killbill.Home) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wtpzj-00HH9d-W0; Tue, 11 Aug 2026 19:10:32 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, alex.hung@amd.com,
 aurabindo.pillai@amd.com, christian.koenig@amd.com, contact@emersion.fr,
 daniels@collabora.com, harry.wentland@amd.com, louis.chauvet@bootlin.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, mwen@igalia.com,
 sebastian.wick@redhat.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v4 10/11] drm/amd/display: allow individual colorop changes
Date: Tue, 11 Aug 2026 18:45:59 +0200
Message-ID: <20260811171011.184964-11-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811171011.184964-1-mwen@igalia.com>
References: <20260811171011.184964-1-mwen@igalia.com>
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

Every AMD colorop helper requires new colorop state to update a single
active colorop, i.e. if the userspace modifies a single property of a
colorop, but doesn't resubmit the whole color pipeline, the driver
silently falls back to the legacy color path, instead of just restore
colorop settings from committed state. Change all colorop helpers to get
the committed state if there's no new state for a given colorop. It
keeps walking in the active color pipeline and update a color block if
the related colorop changed.

Fixes: 9ba25915efba ("drm/amd/display: Add support for sRGB EOTF in DEGAM block")
Acked-by: Harry Wentland <harry.wentland@amd.com> #v3
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 183 +++++++-----------
 1 file changed, 66 insertions(+), 117 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index c528daefac5e..f6a2af5d2e96 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1550,24 +1550,13 @@ __set_dm_plane_colorop_degamma(struct drm_plane_state *plane_state,
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
@@ -1577,43 +1566,37 @@ __set_dm_plane_colorop_3x4_matrix(struct drm_plane_state *plane_state,
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
+	if (colorop_state->colorop->type != DRM_COLOROP_CTM_3X4)
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
@@ -1624,29 +1607,23 @@ __set_dm_plane_colorop_multiplier(struct drm_plane_state *plane_state,
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
+	if (colorop_state->colorop->type != DRM_COLOROP_MULTIPLIER)
+		return -EINVAL;
+
+	if (colorop_state->bypass) {
+		dc_plane_state->hdr_mult = dc_fixpt_one;
+	} else {
+		drm_dbg(dev, "Multiplier colorop with ID: %d\n", colorop->base.id);
+		dc_plane_state->hdr_mult = amdgpu_dm_fixpt_from_s3132(colorop_state->multiplier);
 	}
 
 	return 0;
@@ -1657,8 +1634,6 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 			      struct dc_plane_state *dc_plane_state,
 			      struct drm_colorop *colorop)
 {
-	struct drm_colorop *old_colorop;
-	struct drm_colorop_state *new_colorop_state;
 	struct drm_colorop_state *tf_state = NULL, *lut_state = NULL;
 	struct drm_atomic_commit *state = plane_state->state;
 	struct drm_colorop *lut_colorop;
@@ -1667,38 +1642,29 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
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
+	tf_state = drm_atomic_get_new_colorop_state(state, colorop);
+	if (!tf_state)
+		tf_state = colorop->state;
 
 	/* 1D LUT - SHAPER LUT: find state */
-	lut_colorop = old_colorop->next;
+	lut_colorop = colorop->next;
 	if (!lut_colorop) {
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
@@ -1708,7 +1674,7 @@ __set_dm_plane_colorop_shaper(struct drm_plane_state *plane_state,
 		dc_plane_state->cm.flags.bits.shaper_enable = 1;
 	}
 
-	if (lut_state && !lut_state->bypass) {
+	if (!lut_state->bypass) {
 		drm_dbg(dev, "Shaper LUT colorop with ID: %d\n", lut_colorop->base.id);
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf;
@@ -1765,8 +1731,7 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
 			     struct dc_plane_state *dc_plane_state,
 			     struct drm_colorop *colorop)
 {
-	struct drm_colorop *old_colorop;
-	struct drm_colorop_state *colorop_state = NULL, *new_colorop_state;
+	struct drm_colorop_state *colorop_state;
 	struct dc_transfer_func *tf = &dc_plane_state->cm.shaper_func;
 	struct drm_atomic_commit *state = plane_state->state;
 	const struct amdgpu_device *adev = drm_to_adev(colorop->dev);
@@ -1774,19 +1739,14 @@ __set_dm_plane_colorop_3dlut(struct drm_plane_state *plane_state,
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
+	if (!colorop_state->bypass && colorop->type == DRM_COLOROP_3D_LUT) {
 		if (!has_3dlut) {
 			drm_dbg(dev, "3D LUT is not supported by hardware\n");
 			return -EINVAL;
@@ -1825,8 +1785,6 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 			     struct dc_plane_state *dc_plane_state,
 			     struct drm_colorop *colorop)
 {
-	struct drm_colorop *old_colorop;
-	struct drm_colorop_state *new_colorop_state;
 	struct drm_colorop_state *tf_state = NULL, *lut_state = NULL;
 	struct drm_atomic_commit *state = plane_state->state;
 	struct drm_colorop *lut_colorop;
@@ -1835,38 +1793,29 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
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
+	tf_state = drm_atomic_get_new_colorop_state(state, colorop);
+	if (!tf_state)
+		tf_state = colorop->state;
 
 	/* 1D LUT - BLND LUT: find state */
-	lut_colorop = old_colorop->next;
+	lut_colorop = colorop->next;
 	if (!lut_colorop) {
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
@@ -1876,7 +1825,7 @@ __set_dm_plane_colorop_blend(struct drm_plane_state *plane_state,
 		dc_plane_state->cm.flags.bits.blend_enable = 1;
 	}
 
-	if (lut_state && !lut_state->bypass) {
+	if (!lut_state->bypass) {
 		drm_dbg(dev, "Blend LUT colorop with ID: %d\n", lut_colorop->base.id);
 		tf->type = TF_TYPE_DISTRIBUTED_POINTS;
 		tf->tf = default_tf;
-- 
2.53.0

