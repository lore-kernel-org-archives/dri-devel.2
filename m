Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE111CD98FB
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67B2310EF31;
	Wed, 17 Jun 2026 09:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NyjgnWWl";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7F0B10EF26;
 Wed, 17 Jun 2026 09:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781688771; x=1813224771;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NrW09K1yfF8m1TyNkiXpZTExLYl2n21zQ9xeIi7EmdY=;
 b=NyjgnWWlZpxlZiRb1vZXnhnpEpqAm6ncNxi8xRaNWBVamdI2Od9oBh20
 iTSyrOtPCcPOxNkq+bZSx2ZHHvFPM1KDDCnDyl+6kshXv2ds2ApSTPmFk
 dVYCOVjLlCFislfmmWTiX+xVxEodvD/v2pvd0nMAjNH+3mCBnVurRHOjw
 qhEdyOb96fr6SIgTDdCIbXcRSEHhUxfB6sBTwKeD5mY2cFogxusvZ/8n3
 /DHjNKqJ1qlXF8/fIxr+dlz9FPO3yd9yfSqnKCSvPqy+3km9934EwRGmS
 YdncCFi/959p5YlT4NiONWNlONgAgPPv4VI/pa51gL88WtyEGBFrw/6g4 w==;
X-CSE-ConnectionGUID: +xtXmJutTZeZfFt6fBEWtQ==
X-CSE-MsgGUID: ya3+YR86Q2Oxb7vQjbcdkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="81605280"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="81605280"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 02:32:50 -0700
X-CSE-ConnectionGUID: ieJdgsWmQGSjYWSgz3hQUw==
X-CSE-MsgGUID: r761FaDWQ/Wn9aa9+8cVYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="245114448"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 17 Jun 2026 02:32:49 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: [v3 07/14] drm/i915/color: Add YCbCr limited-to-full range color
 block support
Date: Wed, 17 Jun 2026 14:38:12 +0530
Message-Id: <20260617090819.1735153-8-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260617090819.1735153-1-chaitanya.kumar.borah@intel.com>
References: <20260617090819.1735153-1-chaitanya.kumar.borah@intel.com>
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

Add support for color block which performs YCbCr limited-to-full
range expansion in the plane color pipeline. The color block is
represented using DRM_COLOROP_FIXED_MATRIX colorop.

v2:
- s/yuv_range_correct/yuv_range_correction_disable/ to mirror
  HW register bit naming
- Fix inverted bypass logic: assign bypass state directly since
  bypass=true means HW range correction should be disabled

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color_pipeline.c | 6 ++++++
 drivers/gpu/drm/i915/display/intel_display_limits.h | 1 +
 drivers/gpu/drm/i915/display/intel_display_types.h  | 1 +
 drivers/gpu/drm/i915/display/intel_plane.c          | 3 +++
 drivers/gpu/drm/i915/display/skl_universal_plane.c  | 2 ++
 5 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index 2ef42a133a98..7d25f4fbfa9b 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -108,6 +108,12 @@ struct intel_colorop *intel_color_pipeline_plane_add_colorop(struct drm_plane *p
 							  intel_plane_supported_csc_ff,
 							  DRM_COLOROP_FLAG_ALLOW_BYPASS);
 		break;
+	case INTEL_PLANE_CB_YUV_RANGE_CORRECT:
+		ret = drm_plane_colorop_fixed_matrix_init(dev, &colorop->base, plane,
+							  &intel_colorop_funcs,
+							  BIT(DRM_COLOROP_FM_YCBCR_LIMITED_FULL),
+							  DRM_COLOROP_FLAG_ALLOW_BYPASS);
+		break;
 	default:
 		drm_err(plane->dev, "Invalid colorop id [%d]", id);
 		ret = -EINVAL;
diff --git a/drivers/gpu/drm/i915/display/intel_display_limits.h b/drivers/gpu/drm/i915/display/intel_display_limits.h
index 7ba7360c574e..9493d333a242 100644
--- a/drivers/gpu/drm/i915/display/intel_display_limits.h
+++ b/drivers/gpu/drm/i915/display/intel_display_limits.h
@@ -172,6 +172,7 @@ enum intel_color_block {
 	INTEL_PLANE_CB_CSC_FF,
 	INTEL_PLANE_CB_POST_CSC_LUT,
 	INTEL_PLANE_CB_3DLUT,
+	INTEL_PLANE_CB_YUV_RANGE_CORRECT,
 
 	INTEL_CB_MAX
 };
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 1b5a3c84a7f3..bc85d3c88706 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -683,6 +683,7 @@ struct intel_plane_state {
 		struct drm_property_blob *ctm, *degamma_lut, *gamma_lut, *lut_3d;
 		enum drm_colorop_fixed_matrix_type csc_ff_type; /* For SDR plane */
 		bool csc_ff_enable;
+		bool yuv_range_correction_disable;
 	} hw;
 
 	struct i915_vma *ggtt_vma;
diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index 78ee3c357d8a..e2b496bd6266 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -436,6 +436,9 @@ intel_plane_color_copy_uapi_to_hw_state(struct intel_atomic_state *state,
 						!new_colorop_state->bypass;
 					plane_state->hw.csc_ff_type =
 						new_colorop_state->fixed_matrix_type;
+				} else if (intel_colorop->id == INTEL_PLANE_CB_YUV_RANGE_CORRECT) {
+					plane_state->hw.yuv_range_correction_disable =
+						new_colorop_state->bypass;
 				} else {
 					blob = new_colorop_state->bypass ?
 						NULL : new_colorop_state->data;
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 0e951b36ccca..9f4bc5a61ffb 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -1296,6 +1296,8 @@ static u32 glk_plane_color_ctl_input_csc(const struct intel_plane_state *plane_s
 	} else if (!icl_is_hdr_plane(display, plane->id)) {
 		if (plane_state->hw.csc_ff_enable)
 			ctl |= intel_csc_ff_type_to_csc_mode(plane_state->hw.csc_ff_type);
+		if (plane_state->hw.yuv_range_correction_disable)
+			ctl |= PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
 	}
 
 	return ctl;
-- 
2.25.1

