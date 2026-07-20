Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3DEC44529
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E368610E660;
	Mon, 20 Jul 2026 05:15:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="l+/CyhMo";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D60B10E667;
 Mon, 20 Jul 2026 05:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784524544; x=1816060544;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hXn9sO0CHEVW7IwzG4pfuTSibwzv/oHKAiytKYO1s+s=;
 b=l+/CyhMotYxAlhtvGMAB+3l2sKH+FbE8hlIjx5uD1QnRT5rwoMx6vtGP
 tdsTRYH0NrKWfI/70f1bkX4swQTGukoS2Z+IAQWZvbVPW1f9fGGifZxmh
 s+cqLCCaW9a3ZP4ROXvg44eeC7LXwmEOtocpk/qvH1iB5j9ymrl/+zzh7
 4VsgEeovs3sjoVEQqIUtBM5lefndI0xkkgAWj7e4TPVX0VJCruBfL2N0v
 B2nFATpH77xKO2Ma9eeRPl1Yg9tP5ATgCrmlyoTlqe05hO6VuqezuePbi
 N5YvpLbgt9r/ieE+zOWzjW1Y8/eiolekQwCcss7qVuiftUqYeclCPGEQj Q==;
X-CSE-ConnectionGUID: 8BCzxP25RX6L4XBpTi7hpQ==
X-CSE-MsgGUID: oiElKgFeRV2GFxc2zlMv6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85133405"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85133405"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 22:15:39 -0700
X-CSE-ConnectionGUID: 6XfmF7IRSU6Qcnox1mvDLA==
X-CSE-MsgGUID: f1BOzauxRBqdWaSYgCiDjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="257419781"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa007.jf.intel.com with ESMTP; 19 Jul 2026 22:15:38 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v5 03/14] drm/i915/display: extract glk_plane_color_ctl_input_csc
 helper
Date: Mon, 20 Jul 2026 10:21:20 +0530
Message-Id: <20260720045131.971650-4-chaitanya.kumar.borah@intel.com>
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

Extract the input CSC and YUV range correction logic from
glk_plane_color_ctl() into a dedicated glk_plane_color_ctl_input_csc()
helper. No functional change.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 .../drm/i915/display/skl_universal_plane.c    | 32 +++++++++++--------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index b246fc48558b..f831c1958ff4 100644
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
2.25.1

