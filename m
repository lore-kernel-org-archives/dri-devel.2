Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5739C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACDBF10E77E;
	Mon, 13 Jul 2026 05:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YimOLJjg";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F6CB10E786;
 Mon, 13 Jul 2026 05:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783921170; x=1815457170;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8vt7YNfY9Dtu9pLtqF0G4IszoexVBjT9F+gJ0ZIGZk8=;
 b=YimOLJjgQg+SNjC2ZmkVi4O3bpFILdEOlEkWPZsQpDa88x0XyeI04sSt
 PvwAoktZWF/tIuIMabcn9JNdgdTKeq12KN1g/800g5IQ4tOk11RKiFrLR
 exRBiI5wvaVyBKSieeW99IaBNJku3GsCOPAVxmYu+NvZTQpdewxor+2Bc
 1DVrRRDrAgy8wztnaJUT2YMsh7fOL5rg2/rBZbmbHJyrhg/Lq2yOEztWI
 a5hN5aYAB7IvxLiChdb4dRavIcjZp5qmjqD5qRCZFP3GVFuk0KeiypANN
 3YD0ycAYqWczVTxlRYXLWF3nNnj5IaN34u8GS9Tf0V1dwtI7mp+eFTA/C g==;
X-CSE-ConnectionGUID: W9caovaQTvao7zpmAXhNPw==
X-CSE-MsgGUID: Ny92OcAzQzC04GdE1T18eA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95669994"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95669994"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2026 22:39:30 -0700
X-CSE-ConnectionGUID: OFGJx70GSrecIhMWemx48Q==
X-CSE-MsgGUID: Y7/RWIJHQKuilcll2ayBNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="252066325"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jul 2026 22:39:28 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [CI v4 06/14] drm/i915/display: Program input CSC on SDR planes
Date: Mon, 13 Jul 2026 10:45:08 +0530
Message-Id: <20260713051516.4087420-7-chaitanya.kumar.borah@intel.com>
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

When a color pipeline is active, program the SDR plane fixed-function
CSC. Keep the legacy color_encoding/color_range properties mutually
exclusive with color pipeline uapi.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 .../drm/i915/display/skl_universal_plane.c    | 64 ++++++++++++++-----
 1 file changed, 47 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index da2df5be9848..0e951b36ccca 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -1240,33 +1240,63 @@ static u32 glk_plane_color_ctl_crtc(const struct intel_crtc_state *crtc_state)
 	return plane_color_ctl;
 }
 
+static u32 intel_csc_ff_type_to_csc_mode(enum drm_colorop_fixed_matrix_type csc_ff_type)
+{
+	u32 csc_mode;
+
+	switch (csc_ff_type) {
+	case DRM_COLOROP_FM_YCBCR601_FULL_RGB:
+		csc_mode = PLANE_COLOR_CSC_MODE_YUV601_TO_RGB601;
+		break;
+	case DRM_COLOROP_FM_YCBCR709_FULL_RGB:
+		csc_mode = PLANE_COLOR_CSC_MODE_YUV709_TO_RGB709;
+		break;
+	case DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB:
+		csc_mode = PLANE_COLOR_CSC_MODE_YUV2020_TO_RGB2020;
+		break;
+	case DRM_COLOROP_FM_RGB709_RGB2020:
+		csc_mode = PLANE_COLOR_CSC_MODE_RGB709_TO_RGB2020;
+		break;
+	default:
+		csc_mode = PLANE_COLOR_CSC_MODE_BYPASS;
+	}
+	return csc_mode;
+}
+
 static u32 glk_plane_color_ctl_input_csc(const struct intel_plane_state *plane_state)
 {
 	struct intel_display *display = to_intel_display(plane_state);
 	const struct drm_framebuffer *fb = plane_state->hw.fb;
 	struct intel_plane *plane = to_intel_plane(plane_state->uapi.plane);
+	bool color_pipeline = plane_state->uapi.state &&
+		plane_state->uapi.state->plane_color_pipeline;
 	u32 ctl = 0;
 
-	if (!fb->format->is_yuv)
-		return 0;
+	if (!color_pipeline) {
+		if (!fb->format->is_yuv)
+			return 0;
 
-	if (!icl_is_hdr_plane(display, plane->id)) {
-		switch (plane_state->hw.color_encoding) {
-		case DRM_COLOR_YCBCR_BT709:
-			ctl |= PLANE_COLOR_CSC_MODE_YUV709_TO_RGB709;
-			break;
-		case DRM_COLOR_YCBCR_BT2020:
-			ctl |= PLANE_COLOR_CSC_MODE_YUV2020_TO_RGB2020;
-			break;
-		default:
-			ctl |= PLANE_COLOR_CSC_MODE_YUV601_TO_RGB601;
+		if (!icl_is_hdr_plane(display, plane->id)) {
+			switch (plane_state->hw.color_encoding) {
+			case DRM_COLOR_YCBCR_BT709:
+				ctl |= PLANE_COLOR_CSC_MODE_YUV709_TO_RGB709;
+				break;
+			case DRM_COLOR_YCBCR_BT2020:
+				ctl |= PLANE_COLOR_CSC_MODE_YUV2020_TO_RGB2020;
+				break;
+			default:
+				ctl |= PLANE_COLOR_CSC_MODE_YUV601_TO_RGB601;
+			}
+		} else {
+			ctl |= PLANE_COLOR_INPUT_CSC_ENABLE;
 		}
-	} else {
-		ctl |= PLANE_COLOR_INPUT_CSC_ENABLE;
-	}
 
-	if (plane_state->hw.color_range == DRM_COLOR_YCBCR_FULL_RANGE)
-		ctl |= PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
+		if (plane_state->hw.color_range == DRM_COLOR_YCBCR_FULL_RANGE)
+			ctl |= PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
+	} else if (!icl_is_hdr_plane(display, plane->id)) {
+		if (plane_state->hw.csc_ff_enable)
+			ctl |= intel_csc_ff_type_to_csc_mode(plane_state->hw.csc_ff_type);
+	}
 
 	return ctl;
 }
-- 
2.25.1

