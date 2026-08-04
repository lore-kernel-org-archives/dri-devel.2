Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE89C561F8
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FDB10EA3E;
	Tue,  4 Aug 2026 12:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iP9hHZ8s";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB5010EA31;
 Tue,  4 Aug 2026 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785848110; x=1817384110;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cxhYIgbe/Zo1o2/UlUPEviiI5b1pXuttVWALx6dnMRQ=;
 b=iP9hHZ8sdMcKKPM/6/Z7u8G3otR1LiDAIIyL8qCNGnpGxzGe7GOAgfsO
 OgZAlZgKZmzdOgxuSqe5GrCaPMy9qJ4xtwrHAHp5DQyGUIt3pFtMZMRdj
 GOSJV3HmHydxQZKk+o5koyWJcYU1n8WlBu/jFOB+3mD23SsV47Jo1vbo5
 7vqoOiHDJCHV+vTS7SsUFt13CwzsYAwrFnisW0Qnocs462Kn7EBtTV6bh
 lSth+omxRbRgCPifkXfr5gxQwR+LHuRoWe4GBlKFIHcTN5LYuovrGmwfU
 UpBmbW3OOppCEhdG+HTBpOl0TX/O/gEmv1VtZEomhgPJx8VtT8qC+haTs g==;
X-CSE-ConnectionGUID: zvqZmgSMTayqNSGds+rD0A==
X-CSE-MsgGUID: qOv/VUDRTTCFw6lemV40yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90073224"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="90073224"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 05:55:10 -0700
X-CSE-ConnectionGUID: 0BzjcJHDRHWdcireZyV2SQ==
X-CSE-MsgGUID: KZo/107uRzGwZVhDuSYPzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="262108360"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa009.jf.intel.com with ESMTP; 04 Aug 2026 05:55:08 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: [v6 5/9] drm/i915/display: Program CSC on SDR planes based on Fixed
 Matrix Colorop
Date: Tue,  4 Aug 2026 18:01:03 +0530
Message-ID: <20260804123107.2256124-6-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
References: <20260804123107.2256124-1-chaitanya.kumar.borah@intel.com>
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

When a color pipeline is active, program the SDR plane fixed-function
CSC based on the Fixed Matrix Colorop's state. Re-use the existing plane
state variables for color_range and color_encoding. Track the bypass state
explicitly as a boolean since bypass is managed separately from the
FIXED_MATRIX enum value in the colorop framework. Keep the programming
based on color_encoding/color_range legacy properties intact.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_plane.c    | 53 ++++++++++++++++++-
 .../drm/i915/display/skl_universal_plane.c    |  4 +-
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 20a07ea06b5e..beb0169cabef 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -683,6 +683,7 @@ struct intel_plane_state {
 		enum drm_color_range color_range;
 		enum drm_scaling_filter scaling_filter;
 		struct drm_property_blob *ctm, *degamma_lut, *gamma_lut, *lut_3d;
+		bool csc_ff_enable;
 	} hw;
 
 	struct i915_vma *ggtt_vma;
diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index d0f99a87c42e..25ca049009ef 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -462,6 +462,42 @@ intel_plane_colorop_replace_blob(struct intel_plane_state *plane_state,
 	return false;
 }
 
+static u32
+fixedmatrix_colorop_to_encoding(enum drm_colorop_fixed_matrix_type fm_type)
+{
+	switch (fm_type) {
+	case DRM_COLOROP_FM_YCBCR709_FULL_RGB:
+	case DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
+		return DRM_COLOR_YCBCR_BT709;
+
+	case DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
+	case DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
+		return DRM_COLOR_YCBCR_BT2020;
+
+	case DRM_COLOROP_FM_YCBCR601_FULL_RGB:
+	case DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
+	default:
+		return DRM_COLOR_YCBCR_BT601;
+	}
+}
+
+static u32
+fixedmatrix_colorop_to_range(enum drm_colorop_fixed_matrix_type fm_type)
+{
+	switch (fm_type) {
+	case DRM_COLOROP_FM_YCBCR601_FULL_RGB:
+	case DRM_COLOROP_FM_YCBCR709_FULL_RGB:
+	case DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
+		return DRM_COLOR_YCBCR_FULL_RANGE;
+
+	case DRM_COLOROP_FM_YCBCR601_LIMITED_RGB:
+	case DRM_COLOROP_FM_YCBCR709_LIMITED_RGB:
+	case DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB:
+	default:
+		return DRM_COLOR_YCBCR_LIMITED_RANGE;
+	}
+}
+
 static void
 intel_plane_color_copy_uapi_to_hw_state(struct intel_atomic_state *state,
 					struct intel_plane_state *plane_state,
@@ -474,6 +510,7 @@ intel_plane_color_copy_uapi_to_hw_state(struct intel_atomic_state *state,
 	struct drm_property_blob *blob;
 	struct intel_crtc_state *new_crtc_state = state ?
 		intel_atomic_get_new_crtc_state(state, crtc) : NULL;
+	enum drm_colorop_fixed_matrix_type fm_type;
 	bool changed = false;
 	int i = 0;
 
@@ -485,11 +522,23 @@ intel_plane_color_copy_uapi_to_hw_state(struct intel_atomic_state *state,
 	while (iter_colorop) {
 		for_each_new_colorop_in_state(&state->base, colorop, new_colorop_state, i) {
 			if (new_colorop_state->colorop == iter_colorop) {
-				blob = new_colorop_state->bypass ? NULL : new_colorop_state->data;
 				intel_colorop = to_intel_colorop(colorop);
-				changed |= intel_plane_colorop_replace_blob(plane_state,
+				if (intel_colorop->id == INTEL_PLANE_CB_CSC_FF) {
+					fm_type = new_colorop_state->fixed_matrix_type;
+
+					plane_state->hw.csc_ff_enable =
+						!new_colorop_state->bypass;
+					plane_state->hw.color_encoding =
+						fixedmatrix_colorop_to_encoding(fm_type);
+					plane_state->hw.color_range =
+						fixedmatrix_colorop_to_range(fm_type);
+				} else {
+					blob = new_colorop_state->bypass ?
+						NULL : new_colorop_state->data;
+					changed |= intel_plane_colorop_replace_blob(plane_state,
 									    intel_colorop,
 									    blob);
+				}
 			}
 		}
 		iter_colorop = iter_colorop->next;
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 73be4c6ff1d3..222c3b6bbe46 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -1245,9 +1245,11 @@ static u32 glk_plane_color_ctl_input_csc(const struct intel_plane_state *plane_s
 	struct intel_display *display = to_intel_display(plane_state);
 	const struct drm_framebuffer *fb = plane_state->hw.fb;
 	struct intel_plane *plane = to_intel_plane(plane_state->uapi.plane);
+	bool color_pipeline = !!plane_state->uapi.color_pipeline;
+	bool needs_csc = color_pipeline ? plane_state->hw.csc_ff_enable : fb->format->is_yuv;
 	u32 ctl = 0;
 
-	if (!fb->format->is_yuv)
+	if (!needs_csc)
 		return 0;
 
 	if (!icl_is_hdr_plane(display, plane->id)) {
-- 
2.50.1

