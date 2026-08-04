Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1590C55ABF
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 12:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC49A10EA43;
	Tue,  4 Aug 2026 12:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="er1wmmZM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6853410EA44;
 Tue,  4 Aug 2026 12:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785848114; x=1817384114;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g9coBMH/txDMEwqBelPlzvFBXtkx76A4L7OwTR6Nanc=;
 b=er1wmmZMkTyLwevO6X9LD5rjgw6k86vxb8tWknYngh+ohRwhVKCi0cGl
 FKPjAUM5q3LgXHbXRe54Kw+jaaArm04fvijJHWlz5tT9YhXeZgDCcZhNJ
 qe5oblGqBiVmekmeU8QiALa0jjkxf9WvN1M5SlGJ3xb+RzbyC09NQio+h
 RsK8JGaUzV3OdFUONUic25gxOvdrbIRbwA97jyWj/fEfi76hCjFN1An4g
 J3Q5Szf/YuLN0Ojfot5EEfot6OUG4GPI0Tqioz8AIyX5ciu529ejFvart
 /4J4Cb9XEKmt6dotKNj2dZAP/rB0iQl16TL5+/Gy33AGyDQ8pT+jpM8t/ Q==;
X-CSE-ConnectionGUID: gtZhIIOGTzKmS5HoSpv+TA==
X-CSE-MsgGUID: bGzeE2T/Qeu7vN+LqdOBAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="90073237"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="90073237"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2026 05:55:14 -0700
X-CSE-ConnectionGUID: sB/tCIX/RneeuWl/i2Nnfg==
X-CSE-MsgGUID: +pGQafdLS3aAMosG5eKMUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; d="scan'208";a="262108405"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa009.jf.intel.com with ESMTP; 04 Aug 2026 05:55:11 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Pranay Samala <pranay.samala@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v6 7/9] drm/i915/color: Extract HDR post-CSC LUT programming to
 helper function
Date: Tue,  4 Aug 2026 18:01:05 +0530
Message-ID: <20260804123107.2256124-8-chaitanya.kumar.borah@intel.com>
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

From: Pranay Samala <pranay.samala@intel.com>

Move HDR plane post-CSC LUT programming to improve code organization.

While at it, remove the segment 0 index register writes as it is not
currently programmed.

Signed-off-by: Pranay Samala <pranay.samala@intel.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 35 ++++++++++++----------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 87ced9f6ff40..36c8688ed28e 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -3998,25 +3998,17 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 }
 
 static void
-xelpd_program_plane_post_csc_lut(struct intel_dsb *dsb,
-				 const struct intel_plane_state *plane_state)
+xelpd_load_hdr_post_csc_lut(struct intel_display *display,
+			    struct intel_dsb *dsb,
+			    enum pipe pipe,
+			    enum plane_id plane,
+			    const struct drm_color_lut32 *post_csc_lut)
 {
-	struct intel_display *display = to_intel_display(plane_state);
-	const struct drm_plane_state *state = &plane_state->uapi;
-	enum pipe pipe = to_intel_plane(state->plane)->pipe;
-	enum plane_id plane = to_intel_plane(state->plane)->id;
-	const struct drm_color_lut32 *post_csc_lut = plane_state->hw.gamma_lut->data;
 	int i, lut_size = 32;
 	u32 lut_val;
 
-	if (!icl_is_hdr_plane(display, plane))
-		return;
-
 	intel_de_write_dsb(display, dsb, PLANE_POST_CSC_GAMC_INDEX_ENH(pipe, plane, 0),
 			   PLANE_PAL_PREC_AUTO_INCREMENT);
-	/* TODO: Add macro */
-	intel_de_write_dsb(display, dsb, PLANE_POST_CSC_GAMC_SEG0_INDEX_ENH(pipe, plane, 0),
-			   PLANE_PAL_PREC_AUTO_INCREMENT);
 
 	for (i = 0; i < lut_size + 3; i++) {
 		if (post_csc_lut) {
@@ -4036,8 +4028,21 @@ xelpd_program_plane_post_csc_lut(struct intel_dsb *dsb,
 	}
 
 	intel_de_write_dsb(display, dsb, PLANE_POST_CSC_GAMC_INDEX_ENH(pipe, plane, 0), 0);
-	intel_de_write_dsb(display, dsb,
-			   PLANE_POST_CSC_GAMC_SEG0_INDEX_ENH(pipe, plane, 0), 0);
+}
+
+static void
+xelpd_program_plane_post_csc_lut(struct intel_dsb *dsb,
+				 const struct intel_plane_state *plane_state)
+{
+	struct intel_display *display = to_intel_display(plane_state);
+	const struct drm_plane_state *state = &plane_state->uapi;
+	enum pipe pipe = to_intel_plane(state->plane)->pipe;
+	enum plane_id plane = to_intel_plane(state->plane)->id;
+	const struct drm_color_lut32 *post_csc_lut = plane_state->hw.gamma_lut ?
+		plane_state->hw.gamma_lut->data : NULL;
+
+	if (icl_is_hdr_plane(display, plane))
+		xelpd_load_hdr_post_csc_lut(display, dsb, pipe, plane, post_csc_lut);
 }
 
 static void
-- 
2.50.1

