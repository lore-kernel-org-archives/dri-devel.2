Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A9AC4450A
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:39:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831D610E789;
	Mon, 13 Jul 2026 05:39:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aBR0AcrE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A45A10E782;
 Mon, 13 Jul 2026 05:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783921168; x=1815457168;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WvpKfp4ySYX7FNei7wVBNUbjSs50pQKxTpm84Ggq1Fw=;
 b=aBR0AcrEZUQBUm24YW0Xc4V4+sdBh8sNvuOMRdkxUlYhkJk0x/ym+WUH
 HRwNckMCU7h4uru6QH7LT/AV90xj5s51Xfi0OhUTczMptc6VVN3Y6Jbor
 gAA7H780WUXi+1uIETmchJeVCPQleKKfJncBOWanOt1VX3mIegA/GzMUc
 ehcf+SBgQ2tjaWtRYvPXT7B8tbtKHBF9Zg0ptbJRPGboBgh6szLoWEoTV
 iDK10QEsLj3SNLQ3CujyQ4UySJAJgsaRy+WLTVzNDgf/QasPfe3UWKuxs
 bdSiDs1TXgqSJWcL6IghVi69l+46H+yINHOoiMlOtV1ySNdF7tH6ckq3i g==;
X-CSE-ConnectionGUID: bdcmp/XAT/y0iweOZG7NHQ==
X-CSE-MsgGUID: q4N5qrDASo2kTEF/PHNHSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95669993"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95669993"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2026 22:39:28 -0700
X-CSE-ConnectionGUID: mv6EkVcuRGKuVV3+BwJzoA==
X-CSE-MsgGUID: UUj79nYvRGq1sVbcJ3nkAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="252066321"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jul 2026 22:39:26 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [CI v4 05/14] drm/i915/display: Track CSC mode in intel plane state
Date: Mon, 13 Jul 2026 10:45:07 +0530
Message-Id: <20260713051516.4087420-6-chaitanya.kumar.borah@intel.com>
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

Add CSC mode to hw plane state to enable programming the fixed-function
CSC block for SDR planes based on the DRM_COLOROP_FIXED_MATRIX state.

Track the bypass state explicitly as a boolean since bypass is managed
separately from the FIXED_MATRIX enum value in the colorop framework.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_types.h |  2 ++
 drivers/gpu/drm/i915/display/intel_plane.c         | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index c048da7d6fea..b3e86a9a5c87 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -683,6 +683,8 @@ struct intel_plane_state {
 		enum drm_color_range color_range;
 		enum drm_scaling_filter scaling_filter;
 		struct drm_property_blob *ctm, *degamma_lut, *gamma_lut, *lut_3d;
+		enum drm_colorop_fixed_matrix_type csc_ff_type; /* For SDR plane */
+		bool csc_ff_enable;
 	} hw;
 
 	struct i915_vma *ggtt_vma;
diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index a440f92ff00c..217c7a84bbfa 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -430,11 +430,19 @@ intel_plane_color_copy_uapi_to_hw_state(struct intel_atomic_state *state,
 	while (iter_colorop) {
 		for_each_new_colorop_in_state(&state->base, colorop, new_colorop_state, i) {
 			if (new_colorop_state->colorop == iter_colorop) {
-				blob = new_colorop_state->bypass ? NULL : new_colorop_state->data;
 				intel_colorop = to_intel_colorop(colorop);
-				changed |= intel_plane_colorop_replace_blob(plane_state,
+				if (intel_colorop->id == INTEL_PLANE_CB_CSC_FF) {
+					plane_state->hw.csc_ff_enable =
+						!new_colorop_state->bypass;
+					plane_state->hw.csc_ff_type =
+						new_colorop_state->fixed_matrix_type;
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
-- 
2.25.1

