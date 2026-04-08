Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1E5FD5F7C
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 05:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6EB010E521;
	Wed,  8 Apr 2026 05:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XNGWlBOS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B63D910E522;
 Wed,  8 Apr 2026 05:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775626809; x=1807162809;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7zyI/zxHl7KLHvHzarmSt9YO53PSu3UIxFgvGevE+e4=;
 b=XNGWlBOSZrQ+WWmbPLusNazSqBnBllU2C+htIdGjPrCwvbRkDZJc2AvI
 KfVCqk05UHSECCBk/v+xpqzT6fXcuBlr87FpD+hquAVD9vbnI2k7L8fm0
 XWvpiAOL6ncQoR/wBv9t3IuVoOWm7DLZYZq2nPzyoUImn04VehEieQ3MD
 wdPjsygVqYq74kPyxoRjeSfR99oGkefWvvYBX0ZWNgoQJVw67OslFbb8d
 FD3bGiXCClgi3Cw2ivnXyiU+li4E/HBrG4YQF9XtbcorBVGrGb8DqVlfB
 apHgb9/nyg4Ii3XgVpfiGeHY2PAyKnDOP6I5JB2JREYdNpsD0/+BDbLV/ A==;
X-CSE-ConnectionGUID: YJzKg5SGTPKcwmsv9yF51A==
X-CSE-MsgGUID: HgSjlpZ9QlqXFK0SJYGW0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="80194861"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="80194861"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2026 22:40:09 -0700
X-CSE-ConnectionGUID: CqMM970ERZOmmRRLZvByuA==
X-CSE-MsgGUID: eqQ0GgPgSAuwee4Km6THuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="251517984"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa002.fm.intel.com with ESMTP; 07 Apr 2026 22:40:04 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
Cc: harry.wentland@amd.com, louis.chauvet@bootlin.com, mwen@igalia.com,
 contact@emersion.fr, alex.hung@amd.com, daniels@collabora.com,
 uma.shankar@intel.com, maarten.lankhorst@intel.com,
 pekka.paalanen@collabora.com, pranay.samala@intel.com,
 swati2.sharma@intel.com, chaitanya.kumar.borah@intel.com
Subject: [PATCH v2 02/13] drm/i915/color: Add CSC on SDR plane color pipeline
Date: Wed,  8 Apr 2026 10:45:03 +0530
Message-Id: <20260408051514.608781-3-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260408051514.608781-1-chaitanya.kumar.borah@intel.com>
References: <20260408051514.608781-1-chaitanya.kumar.borah@intel.com>
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

Add the fixed-function CSC block to color pipeline in SDR planes
as a DRM_COLOROP_FIXED_MATRIX colorop.

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 .../drm/i915/display/intel_color_pipeline.c   | 22 ++++++++++++++++++-
 .../drm/i915/display/intel_display_limits.h   |  1 +
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index 6cf8080ee800..49c621d1bf22 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -43,6 +43,16 @@ static const enum intel_color_block hdr_plane_pipeline[] = {
 	INTEL_PLANE_CB_POST_CSC_LUT,
 };
 
+static const enum intel_color_block sdr_plane_pipeline[] = {
+	INTEL_PLANE_CB_CSC_FF,
+};
+
+static const u64 intel_plane_supported_csc_ff =
+		BIT(DRM_COLOROP_FM_YCBCR601_FULL_RGB) |
+		BIT(DRM_COLOROP_FM_YCBCR709_FULL_RGB) |
+		BIT(DRM_COLOROP_FM_YCBCR2020_FULL_RGB_NC) |
+		BIT(DRM_COLOROP_FM_RGB709_RGB2020);
+
 static bool plane_has_3dlut(struct intel_display *display, enum pipe pipe,
 			    struct drm_plane *plane)
 {
@@ -92,6 +102,12 @@ struct intel_colorop *intel_color_pipeline_plane_add_colorop(struct drm_plane *p
 							  DRM_COLOROP_LUT1D_INTERPOLATION_LINEAR,
 							  DRM_COLOROP_FLAG_ALLOW_BYPASS);
 		break;
+	case INTEL_PLANE_CB_CSC_FF:
+		ret = drm_plane_colorop_fixed_matrix_init(dev, &colorop->base, plane,
+							  &intel_colorop_funcs,
+							  intel_plane_supported_csc_ff,
+							  DRM_COLOROP_FLAG_ALLOW_BYPASS);
+		break;
 	default:
 		drm_err(plane->dev, "Invalid colorop id [%d]", id);
 		ret = -EINVAL;
@@ -122,13 +138,17 @@ int _intel_color_pipeline_plane_init(struct drm_plane *plane, struct drm_prop_en
 	int pipeline_len;
 	int ret = 0;
 	int i;
+	bool is_hdr = icl_is_hdr_plane(display, to_intel_plane(plane)->id);
 
 	if (plane_has_3dlut(display, pipe, plane)) {
 		pipeline = xe3plpd_primary_plane_pipeline;
 		pipeline_len = ARRAY_SIZE(xe3plpd_primary_plane_pipeline);
-	} else {
+	} else if (is_hdr) {
 		pipeline = hdr_plane_pipeline;
 		pipeline_len = ARRAY_SIZE(hdr_plane_pipeline);
+	} else {
+		pipeline = sdr_plane_pipeline;
+		pipeline_len = ARRAY_SIZE(sdr_plane_pipeline);
 	}
 
 	for (i = 0; i < pipeline_len; i++) {
diff --git a/drivers/gpu/drm/i915/display/intel_display_limits.h b/drivers/gpu/drm/i915/display/intel_display_limits.h
index 453f7b720815..f4aad54472ce 100644
--- a/drivers/gpu/drm/i915/display/intel_display_limits.h
+++ b/drivers/gpu/drm/i915/display/intel_display_limits.h
@@ -167,6 +167,7 @@ enum aux_ch {
 enum intel_color_block {
 	INTEL_PLANE_CB_PRE_CSC_LUT,
 	INTEL_PLANE_CB_CSC,
+	INTEL_PLANE_CB_CSC_FF,
 	INTEL_PLANE_CB_POST_CSC_LUT,
 	INTEL_PLANE_CB_3DLUT,
 
-- 
2.25.1

