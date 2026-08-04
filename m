Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F11C55838
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:55:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C010D10EA3A;
	Tue,  4 Aug 2026 12:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eaxxN1qb";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48C9E10EA32;
 Tue,  4 Aug 2026 12:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785848107; x=1817384107;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H6d09+bbha//LaW5Dy4HwvORJ/QVEzUagd/sdgTSCu8=;
 b=eaxxN1qbh0apGcpEI7xoRDS5Vph3g+BPM8GIVH+rtkS3NTgZm+eq8lnT
 H4Kmb5GMrT8A7ZQxLTnYMvtalqcTt0GB1xdK9OPJzDD6LtAnFmfVNhRir
 jeC6nN+svl+3fvbmmhKUkLDdVZnVyfNlTWY56buZViHskQ8UAL+mHJszV
 4OcF8vScDf88yjd5fJTwcyK0IfTyQggoKhBAY1uRTt32noWcZqwF45b3v
 ofysaXME1Q7CgZypDva6g2oQTl6ewRRUq6SIndsF8T/obfTM/NxDAzu8G
 nzNNq23lJSOOtR4jNb6cJrA8FQVaU2aYmn0F4DmI/Jq5Hw6o6aTwoH+2x A==;
X-CSE-ConnectionGUID: iKC4PvkSTOe3mbDU6Md52g==
X-CSE-MsgGUID: W7O3g75lSzGxjbig3LH10g==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90073214"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="90073214"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 05:55:07 -0700
X-CSE-ConnectionGUID: iQBC+RKNQ52UGzejzGh44A==
X-CSE-MsgGUID: a3YkyPGbSF26yB6i68vQ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="262108321"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa009.jf.intel.com with ESMTP; 04 Aug 2026 05:55:04 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v6 3/9] drm/i915/display: extract glk_plane_color_ctl_input_csc
 helper
Date: Tue,  4 Aug 2026 18:01:01 +0530
Message-ID: <20260804123107.2256124-4-chaitanya.kumar.borah@intel.com>
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

Extract the input CSC and YUV range correction logic from
glk_plane_color_ctl() into a dedicated glk_plane_color_ctl_input_csc()
helper. No functional change.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 .../drm/i915/display/skl_universal_plane.c    | 32 +++++++++++--------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 07a683293352..0234492425d5 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -1240,37 +1240,43 @@ static u32 glk_plane_color_ctl_crtc(const struct intel_crtc_state *crtc_state)
 	return plane_color_ctl;
 }
 
-static u32 glk_plane_color_ctl(const struct intel_plane_state *plane_state)
+static u32 glk_plane_color_ctl_input_csc(const struct intel_plane_state *plane_state)
 {
 	struct intel_display *display = to_intel_display(plane_state);
 	const struct drm_framebuffer *fb = plane_state->hw.fb;
 	struct intel_plane *plane = to_intel_plane(plane_state->uapi.plane);
-	u32 plane_color_ctl = 0;
-
-	plane_color_ctl |= PLANE_COLOR_PLANE_GAMMA_DISABLE;
-	plane_color_ctl |= glk_plane_color_ctl_alpha(plane_state);
+	u32 ctl = 0;
 
 	if (fb->format->is_yuv && !icl_is_hdr_plane(display, plane->id)) {
 		switch (plane_state->hw.color_encoding) {
 		case DRM_COLOR_YCBCR_BT709:
-			plane_color_ctl |= PLANE_COLOR_CSC_MODE_YUV709_TO_RGB709;
+			ctl |= PLANE_COLOR_CSC_MODE_YUV709_TO_RGB709;
 			break;
 		case DRM_COLOR_YCBCR_BT2020:
-			plane_color_ctl |=
-				PLANE_COLOR_CSC_MODE_YUV2020_TO_RGB2020;
+			ctl |= PLANE_COLOR_CSC_MODE_YUV2020_TO_RGB2020;
 			break;
 		default:
-			plane_color_ctl |=
-				PLANE_COLOR_CSC_MODE_YUV601_TO_RGB601;
+			ctl |= PLANE_COLOR_CSC_MODE_YUV601_TO_RGB601;
 		}
 		if (plane_state->hw.color_range == DRM_COLOR_YCBCR_FULL_RANGE)
-			plane_color_ctl |= PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
+			ctl |= PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
 	} else if (fb->format->is_yuv) {
-		plane_color_ctl |= PLANE_COLOR_INPUT_CSC_ENABLE;
+		ctl |= PLANE_COLOR_INPUT_CSC_ENABLE;
 		if (plane_state->hw.color_range == DRM_COLOR_YCBCR_FULL_RANGE)
-			plane_color_ctl |= PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
+			ctl |= PLANE_COLOR_YUV_RANGE_CORRECTION_DISABLE;
 	}
 
+	return ctl;
+}
+
+static u32 glk_plane_color_ctl(const struct intel_plane_state *plane_state)
+{
+	u32 plane_color_ctl = 0;
+
+	plane_color_ctl |= PLANE_COLOR_PLANE_GAMMA_DISABLE;
+	plane_color_ctl |= glk_plane_color_ctl_alpha(plane_state);
+	plane_color_ctl |= glk_plane_color_ctl_input_csc(plane_state);
+
 	if (plane_state->force_black)
 		plane_color_ctl |= PLANE_COLOR_PLANE_CSC_ENABLE;
 
-- 
2.50.1

