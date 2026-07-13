Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B355C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:39:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB5A10E78E;
	Mon, 13 Jul 2026 05:39:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TsJ4YQuq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DB8E10E556;
 Mon, 13 Jul 2026 05:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783921172; x=1815457172;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pg1EKOvkqyiBzK3aw1PYuKh6r1DP++9g4QNBBVivgPs=;
 b=TsJ4YQuqStAcIE3mKqfPuaBFnrdX+L4+iYEZUmCD4P2CZPkBPorHq4yJ
 DQy4msJ6L9RAai9eT+sJrl/HJPMf790BPpm7unDaBvXIesmEXpBho+w9J
 j3O9reMjFbKUZN4lyFn7VExuoN96DCGO95PG66g2NnLS84Ube9scIVcH6
 IBkVBhPgBOctX/+XOSfBuj3I5oZNAPaEX03t4Za3ARqFa+fbWeFGGCzX9
 iaAmN9elWDBojOAnDEZi7vbcMmqxypFQAI7FSQigOORr8007gbJdMhyBo
 Wo5xewn+zUhBgzJiV4g4toI4sRqpbpq/W3QW2XnUUN8RbFPMXqeAigEEe Q==;
X-CSE-ConnectionGUID: 28bzSklvTlSk0ZJt15qHjw==
X-CSE-MsgGUID: XRxK/VpAT72zRmMbuCti9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95669995"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95669995"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2026 22:39:32 -0700
X-CSE-ConnectionGUID: U6e97zJSQS2F4NlQ6TyheQ==
X-CSE-MsgGUID: Px8PiZM5TliRkEJvl2MhSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="252066329"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jul 2026 22:39:30 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [CI v4 07/14] drm/i915/color: Add YCbCr limited-to-full range color
 block support
Date: Mon, 13 Jul 2026 10:45:09 +0530
Message-Id: <20260713051516.4087420-8-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
References: <20260713051516.4087420-1-chaitanya.kumar.borah@intel.com>
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
index b3e86a9a5c87..1c95271742eb 100644
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
index 217c7a84bbfa..54fb014f9087 100644
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

