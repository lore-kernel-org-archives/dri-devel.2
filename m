Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBD0C44525
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:15:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CCD910E656;
	Mon, 20 Jul 2026 05:15:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="X3nUJAWS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53B710E655;
 Mon, 20 Jul 2026 05:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784524544; x=1816060544;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SVUAg9QzMnk2kUfAZbW0gupa2qIgQHEDNMoEM6M4pC4=;
 b=X3nUJAWSkwEjuDu9HB3aPQTYYiOQVUYhSrCJ+LPKlhw1yTpEDhrgsLTH
 iubUTFENaCSpyCmE8t/mIMO14K48bzUrtp7HDXs4L4ax9qhL8g8s7t5KY
 yhsHsCJsHZgxrBYqDYK6NOpdxYlQU6M0Y3JEukHdbdCt16jiJ7Ma++MGf
 jI4/ecWHQNLYgO9R8Q+y3J/D8xjN5BKD/nwUtCAr2Hb28REztm6kpJHZ5
 qQrBV19Y8ElNu/8kan1EMyjNfEaGLczoBEC7tRpKE2wnIm9qlqs9Ct4Y7
 SgPFnA5ALWbIEs/le/zz5H8ief0bpbTkrDtPACa36WomUnNmWTOMgDqBW w==;
X-CSE-ConnectionGUID: vuWzxINnRsWsZAqIMAACWA==
X-CSE-MsgGUID: KqB2UFqlQ5qNxSJfwXDqeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85133411"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85133411"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 22:15:44 -0700
X-CSE-ConnectionGUID: 6r25WAqwSt+LfHIQMtc/wg==
X-CSE-MsgGUID: H+O84DAWT720N0wwwEBFmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="257419797"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa007.jf.intel.com with ESMTP; 19 Jul 2026 22:15:43 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v5 06/14] drm/i915/display: Program input CSC on SDR planes
Date: Mon, 20 Jul 2026 10:21:23 +0530
Message-Id: <20260720045131.971650-7-chaitanya.kumar.borah@intel.com>
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

When a color pipeline is active, program the SDR plane fixed-function
CSC. Keep the legacy color_encoding/color_range properties mutually
exclusive with color pipeline uapi.

v2:
- Do not skip programming legacy property if color pipeline is not set.
  Support for YUV buffers in color pipeline uAPI is a work in progress.
  Therefore, color-pipeline-aware userspace might still use the legacy
  COLOR_RANGE and COLOR_ENCODING property while keeping the color
  pipeline to Bypass. Therefore, skip programming based on legacy
  properties only when a color pipeline is set.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com> #v1
---
 .../drm/i915/display/skl_universal_plane.c    | 63 ++++++++++++++-----
 1 file changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index e09743179c0c..c5e5081e67c2 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -1240,33 +1240,62 @@ static u32 glk_plane_color_ctl_crtc(const struct intel_crtc_state *crtc_state)
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
+	bool color_pipeline = !!plane_state->uapi.color_pipeline;
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

