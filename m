Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E33CD98FF
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 09:33:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AAE210EF2E;
	Wed, 17 Jun 2026 09:32:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NvKA5V+K";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1F0210E9A6;
 Wed, 17 Jun 2026 09:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781688767; x=1813224767;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BlWDtHQvas24HpNVDKqQtIMekhhZM4SV70A4n6q/q58=;
 b=NvKA5V+KHdiSzhp6rbGsUhUvKbJKXjtzYJwa6ZGSoM65vEtCFbEg0sRI
 CREcYrIOVwaW4kY3i+1zLtMHxhSjEvRBbCy4/EallmkqDglNZbpY+rUdO
 jU8KO1Smya87/rk6nhinfxptBkeHWRIKUEL49cpugBMs/9iGTTSg9MfVf
 DD2j1X/MUy0P74/Ramn/6zBvTcuB6AM8PVuhl1YY93UnFurSB6y/A1k21
 xck4a/t99ltR1eiXVX36sPt0amfDYqLQ8YOArtIoOpyj/Hfo5SxIk+sha
 EZp3hSMIvkIJEVnNbY0ZtW/fJLB5Iwn4Cyzb3tqHSnZQ7YynsM7Ec6Dgc w==;
X-CSE-ConnectionGUID: FMnlfwLkSSWn4oeRBsazTw==
X-CSE-MsgGUID: P54sVd0yTWqMNsdhJBIvgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="81605270"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="81605270"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2026 02:32:46 -0700
X-CSE-ConnectionGUID: yqyhRx0MTbe3Z1ZO9fzbhg==
X-CSE-MsgGUID: rPn76RPXTMqDfxftNhjOVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; d="scan'208";a="245114436"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 17 Jun 2026 02:32:45 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Subject: [v3 05/14] drm/i915/display: Track CSC mode in intel plane state
Date: Wed, 17 Jun 2026 14:38:10 +0530
Message-Id: <20260617090819.1735153-6-chaitanya.kumar.borah@intel.com>
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

Add CSC mode to hw plane state to enable programming the fixed-function
CSC block for SDR planes based on the DRM_COLOROP_FIXED_MATRIX state.

Track the bypass state explicitly as a boolean since bypass is managed
separately from the FIXED_MATRIX enum value in the colorop framework.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_types.h |  2 ++
 drivers/gpu/drm/i915/display/intel_plane.c         | 12 ++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 6cd102a3b610..1b5a3c84a7f3 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -681,6 +681,8 @@ struct intel_plane_state {
 		enum drm_color_range color_range;
 		enum drm_scaling_filter scaling_filter;
 		struct drm_property_blob *ctm, *degamma_lut, *gamma_lut, *lut_3d;
+		enum drm_colorop_fixed_matrix_type csc_ff_type; /* For SDR plane */
+		bool csc_ff_enable;
 	} hw;
 
 	struct i915_vma *ggtt_vma;
diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index 3eaf82477f49..78ee3c357d8a 100644
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

