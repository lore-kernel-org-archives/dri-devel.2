Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5D6C44529
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 05:15:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E791810E67D;
	Mon, 20 Jul 2026 05:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TYcArVJT";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24D7010E658;
 Mon, 20 Jul 2026 05:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784524551; x=1816060551;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8v1AQ6RMT3arnr8+DdPXZNB8uzBonTYlva092aZp1p8=;
 b=TYcArVJTeG8ch/5lybvaamc10pT7k7/wJOBpWZ3nxgW5ntHEWReVauaV
 Y/iKj+g9ULjf6cF9xUyFnLyudrht1aoqS0Uxx1aArn/H0RxuWTjkpNq7I
 LQSySUdUN9C/AUFkGOXEjrqH9LH9AoV9xGVfMdjgDZU/8kUcDzv52qlWa
 sCmwTECnZSO6Mc6zawT2rws6Snxg21d0dF3UvgHWOvaF+qV11ZbZDT8+t
 CUL5UhhVUZzZw+eQuPMclql3UTUitPrgWtneC74eNv6GKBHtAeO7Xwa5t
 8qZt8sGQM3BvWHTkfjoGPQMgv3fKNYTCyR8B1dtwOfPIWXR7DiJz+7tCz g==;
X-CSE-ConnectionGUID: YBwLYAEoQjuAaMiOZZ4aag==
X-CSE-MsgGUID: SQKZdSONS3SpZ4yNL2lW3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11851"; a="85133416"
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="85133416"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jul 2026 22:15:51 -0700
X-CSE-ConnectionGUID: I8cIl4O+RQqo/m+DvCeUXQ==
X-CSE-MsgGUID: kKIamaY2QoaFmByUI6jWjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,174,1779174000"; d="scan'208";a="257419819"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by orviesa007.jf.intel.com with ESMTP; 19 Jul 2026 22:15:50 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Pranay Samala <pranay.samala@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [v5 10/14] drm/i915/color: Extract HDR pre-CSC LUT programming to
 helper function
Date: Mon, 20 Jul 2026 10:21:27 +0530
Message-Id: <20260720045131.971650-11-chaitanya.kumar.borah@intel.com>
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

From: Pranay Samala <pranay.samala@intel.com>

As we prepare to add support for LUT programming in SDR planes,
refactor HDR plane pre-CSC LUT programming to a helper.

Signed-off-by: Pranay Samala <pranay.samala@intel.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color.c | 30 ++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 87ced9f6ff40..2a32ab62721c 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -3959,20 +3959,15 @@ xelpd_load_plane_csc_matrix(struct intel_dsb *dsb,
 }
 
 static void
-xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
-				const struct intel_plane_state *plane_state)
+xelpd_load_hdr_pre_csc_lut(struct intel_display *display,
+			   struct intel_dsb *dsb,
+			   enum pipe pipe,
+			   enum plane_id plane,
+			   const struct drm_color_lut32 *pre_csc_lut)
 {
-	struct intel_display *display = to_intel_display(plane_state);
-	const struct drm_plane_state *state = &plane_state->uapi;
-	enum pipe pipe = to_intel_plane(state->plane)->pipe;
-	enum plane_id plane = to_intel_plane(state->plane)->id;
-	const struct drm_color_lut32 *pre_csc_lut = plane_state->hw.degamma_lut->data;
 	int i, lut_size = 128;
 	u32 lut_val;
 
-	if (!icl_is_hdr_plane(display, plane))
-		return;
-
 	intel_de_write_dsb(display, dsb,
 			   PLANE_PRE_CSC_GAMC_INDEX_ENH(pipe, plane, 0),
 			   PLANE_PAL_PREC_AUTO_INCREMENT);
@@ -3997,6 +3992,21 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 	intel_de_write_dsb(display, dsb, PLANE_PRE_CSC_GAMC_INDEX_ENH(pipe, plane, 0), 0);
 }
 
+static void
+xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
+				const struct intel_plane_state *plane_state)
+{
+	struct intel_display *display = to_intel_display(plane_state);
+	const struct drm_plane_state *state = &plane_state->uapi;
+	enum pipe pipe = to_intel_plane(state->plane)->pipe;
+	enum plane_id plane = to_intel_plane(state->plane)->id;
+	const struct drm_color_lut32 *pre_csc_lut = plane_state->hw.degamma_lut ?
+			plane_state->hw.degamma_lut->data : NULL;
+
+	if (icl_is_hdr_plane(display, plane))
+		xelpd_load_hdr_pre_csc_lut(display, dsb, pipe, plane, pre_csc_lut);
+}
+
 static void
 xelpd_program_plane_post_csc_lut(struct intel_dsb *dsb,
 				 const struct intel_plane_state *plane_state)
-- 
2.25.1

