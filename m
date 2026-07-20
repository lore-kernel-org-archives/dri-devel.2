Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A79C44531
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DA0510E669;
	Mon, 20 Jul 2026 05:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ILETFP6r";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11DFF10E66B;
 Mon, 20 Jul 2026 05:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784524546; x=1816060546;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KRq2O1c6HoAIWbt0VR5VLlUonuntkCQCG68L5iGCPuc=;
 b=ILETFP6rh57TDv57QdkqXvrSKjyRMRXqNpxiCFkl01WNWP1R+5nCD8yo
 TnAxNb0r2WA9TvNy/vTb+g43aqWYBpvjl1M6G8/FJFg1OjPr9Xh2GeNFS
 4oCchvTeaHP49lMAcoiyevXZH98B7j9BlLpaGHI36kyc/fS8bzKoBmC3J
 Qb72rN2p4n2JHLKmgxvjc0Ox0whKlNgazi8CenNa8UCI4B/iRn6J6ni1W
 MjiGExMk5qU2N1sF3WPnfAkeI6sk0Wdc/TZZEZTaIDbyVmWA18TB57wAR
 3A3g0OGXLZDZu8L8JrB8Poo8wdtbBoZUZ6SGcXKNP0k3ZIjInFSjAJAyB Q==;
X-CSE-ConnectionGUID: BS1pT97qQVyMtC7WgfFJYA==
X-CSE-MsgGUID: BGYoRaU+RH6Bz+gAZH4JzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85133413"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85133413"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 22:15:45 -0700
X-CSE-ConnectionGUID: MRzz+0wYT3apVNweOvKubQ==
X-CSE-MsgGUID: 6VC9PG33SUme1IsjtEhMmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="257419805"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa007.jf.intel.com with ESMTP; 19 Jul 2026 22:15:45 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v5 07/14] drm/i915/color: Add YCbCr limited-to-full range color
 block support
Date: Mon, 20 Jul 2026 10:21:24 +0530
Message-Id: <20260720045131.971650-8-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
References: <20260720045131.971650-1-chaitanya.kumar.borah@intel.com>
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
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
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
index ba295cbea0f2..b0a2fac24bee 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -685,6 +685,7 @@ struct intel_plane_state {
 		struct drm_property_blob *ctm, *degamma_lut, *gamma_lut, *lut_3d;
 		enum drm_colorop_fixed_matrix_type csc_ff_type; /* For SDR plane */
 		bool csc_ff_enable;
+		bool yuv_range_correction_disable;
 	} hw;
 
 	struct i915_vma *ggtt_vma;
diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index d9908b976ca1..ca8903045195 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -491,6 +491,9 @@ intel_plane_color_copy_uapi_to_hw_state(struct intel_atomic_state *state,
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
index c5e5081e67c2..4d17ea452a25 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -1295,6 +1295,8 @@ static u32 glk_plane_color_ctl_input_csc(const struct intel_plane_state *plane_s
 	} else if (!icl_is_hdr_plane(display, plane->id)) {
 		if (plane_state->hw.csc_ff_enable)
 			ctl |= intel_csc_ff_type_to_csc_mode(plane_state->hw.csc_ff_type);
+		if (plane_state->hw.yuv_range_correction_disable)
+			ctl |= PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
 	}
 
 	return ctl;
-- 
2.25.1

