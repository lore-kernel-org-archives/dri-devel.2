Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6618DC56201
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:55:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B351D10EA2F;
	Tue,  4 Aug 2026 12:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E9iQ9UdA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69FDF10EA2A;
 Tue,  4 Aug 2026 12:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785848105; x=1817384105;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1erQ+272RDlFJZ0P27k879xu4qc6rFVSKNOT/hgMjos=;
 b=E9iQ9UdANzc6DvCPRHWaxXliGnWBDxLc0ym3y59xuivhZqKDhVI6tLsq
 +AmcJFdt96yHQVnsXyPlAzI2ZS85or0hHb5851fm+chLd10DBYqwMdFaE
 cdYTJiV6DVHQ36dktBx5H+k0+Hr9Bo8zVzDH1vI6EtM+qcJPqduJaLUAU
 UjdPSGg/gkaP4K1/4TRNkMvKA7Lan/NwV+aUh/yyXHG8NG7dEPj0A9P95
 lPi/lxn4KUbl/CmgLhAyJIuFIcvH0OLWzM67xx7vT9kJRYjuHM5Gaqx57
 F/t/BuyBzuDKM3R8C09Xx0pentroZuDTlibKCMWoOmAoxWPKJu+qgO5iw w==;
X-CSE-ConnectionGUID: 2brEEwgdRSCEgyGIwpDLAg==
X-CSE-MsgGUID: ohTAz6K9S5KS01kRF6uv+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90073200"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="90073200"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 05:55:05 -0700
X-CSE-ConnectionGUID: jbiXXUEbRuinRaD/vG4SUw==
X-CSE-MsgGUID: vWLKgJFQSIO1PCiQ/0VkyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="262108292"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa009.jf.intel.com with ESMTP; 04 Aug 2026 05:55:02 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v6 2/9] drm/i915/color: Add CSC on SDR plane color pipeline
Date: Tue,  4 Aug 2026 18:01:00 +0530
Message-ID: <20260804123107.2256124-3-chaitanya.kumar.borah@intel.com>
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

Add the fixed-function CSC block to color pipeline in SDR planes
as a DRM_COLOROP_FIXED_MATRIX colorop.

v2:
- s/DRM_COLOROP_FM_YCBCR2020_FULL_RGB_NC/
	DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB
- Inline icl_is_hdr_plane() instead of storing in local variable

v3:
- In preparation of a simple pipeline
	[YUV Full/Limited -> RGB]
  Make the Fixed Matrix ColorOp support Limited Range enums
  (DRM_COLOROP_FM_YCBCRXXX_LIMITED_RGB) too.
- Therefore s/sdr_plane_pipeline/sdr_plane_yuv_pipeline

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com> #v2
---
 .../drm/i915/display/intel_color_pipeline.c   | 23 ++++++++++++++++++-
 .../drm/i915/display/intel_display_limits.h   |  1 +
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color_pipeline.c b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
index 6cf8080ee800..efd4375c4331 100644
--- a/drivers/gpu/drm/i915/display/intel_color_pipeline.c
+++ b/drivers/gpu/drm/i915/display/intel_color_pipeline.c
@@ -43,6 +43,18 @@ static const enum intel_color_block hdr_plane_pipeline[] = {
 	INTEL_PLANE_CB_POST_CSC_LUT,
 };
 
+static const enum intel_color_block sdr_plane_yuv_pipeline[] = {
+	INTEL_PLANE_CB_CSC_FF,
+};
+
+static const u64 intel_plane_supported_csc_ff =
+		BIT(DRM_COLOROP_FM_YCBCR601_FULL_RGB) |
+		BIT(DRM_COLOROP_FM_YCBCR601_LIMITED_RGB) |
+		BIT(DRM_COLOROP_FM_YCBCR709_FULL_RGB) |
+		BIT(DRM_COLOROP_FM_YCBCR709_LIMITED_RGB) |
+		BIT(DRM_COLOROP_FM_YCBCR2020_NC_FULL_RGB) |
+		BIT(DRM_COLOROP_FM_YCBCR2020_NC_LIMITED_RGB);
+
 static bool plane_has_3dlut(struct intel_display *display, enum pipe pipe,
 			    struct drm_plane *plane)
 {
@@ -92,6 +104,12 @@ struct intel_colorop *intel_color_pipeline_plane_add_colorop(struct drm_plane *p
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
@@ -126,9 +144,12 @@ int _intel_color_pipeline_plane_init(struct drm_plane *plane, struct drm_prop_en
 	if (plane_has_3dlut(display, pipe, plane)) {
 		pipeline = xe3plpd_primary_plane_pipeline;
 		pipeline_len = ARRAY_SIZE(xe3plpd_primary_plane_pipeline);
-	} else {
+	} else if (icl_is_hdr_plane(display, to_intel_plane(plane)->id)) {
 		pipeline = hdr_plane_pipeline;
 		pipeline_len = ARRAY_SIZE(hdr_plane_pipeline);
+	} else {
+		pipeline = sdr_plane_yuv_pipeline;
+		pipeline_len = ARRAY_SIZE(sdr_plane_yuv_pipeline);
 	}
 
 	for (i = 0; i < pipeline_len; i++) {
diff --git a/drivers/gpu/drm/i915/display/intel_display_limits.h b/drivers/gpu/drm/i915/display/intel_display_limits.h
index ea89473c177f..7ba7360c574e 100644
--- a/drivers/gpu/drm/i915/display/intel_display_limits.h
+++ b/drivers/gpu/drm/i915/display/intel_display_limits.h
@@ -169,6 +169,7 @@ enum aux_ch {
 enum intel_color_block {
 	INTEL_PLANE_CB_PRE_CSC_LUT,
 	INTEL_PLANE_CB_CSC,
+	INTEL_PLANE_CB_CSC_FF,
 	INTEL_PLANE_CB_POST_CSC_LUT,
 	INTEL_PLANE_CB_3DLUT,
 
-- 
2.50.1

