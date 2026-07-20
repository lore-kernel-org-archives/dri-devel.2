Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18410C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:15:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0257510E66A;
	Mon, 20 Jul 2026 05:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JKtHiJkR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 757B510E655;
 Mon, 20 Jul 2026 05:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784524544; x=1816060544;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=racVhI/5VPXfKnH9LiuFtXNJ5RaJAzmFp+eeGNCMTkY=;
 b=JKtHiJkR1ra4rrnZJNCiw/M1F45SplzY/EqojckGkHhjde5Rv6KRBeeZ
 5cURJbP21UxEhloOUgdE6bXtPL13gRUWxhW2gCr8v0736kQ8opfhZ5eVj
 kVf8kWIG6Pa7TtnavlXgrSeb3eMNZ5kQvsV3Zhuj5hZH9XKIXmtegwKyK
 d00a1QnXOE+JZe77PYoviv3Vfa/PVG1mpR9X6Qj8GXdVvbvxdYJFTzy+x
 QdbbxlyUJGZ8dPThfsfxw92W1PJCCpEOqNvM1PMwkEqirBKKRFrAWkB6q
 nnik8d2Fa8U0WcpyK6MX8bbkyPyZ+LH+Pv06cAYlp+OUQTpRA/iemLx8Q Q==;
X-CSE-ConnectionGUID: c43PbLRVQOyH1CIcm81TVg==
X-CSE-MsgGUID: VKbbyMnISxigtvN30aroyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85133409"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85133409"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 22:15:42 -0700
X-CSE-ConnectionGUID: I6mtTN0DR66rQJLtIBjuWw==
X-CSE-MsgGUID: yYidtzC7QtW6oOWee20iMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="257419792"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa007.jf.intel.com with ESMTP; 19 Jul 2026 22:15:41 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v5 05/14] drm/i915/display: Track CSC mode in intel plane state
Date: Mon, 20 Jul 2026 10:21:22 +0530
Message-Id: <20260720045131.971650-6-chaitanya.kumar.borah@intel.com>
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
index 17336ad6d5e9..ba295cbea0f2 100644
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
index d0f99a87c42e..d9908b976ca1 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -485,11 +485,19 @@ intel_plane_color_copy_uapi_to_hw_state(struct intel_atomic_state *state,
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

