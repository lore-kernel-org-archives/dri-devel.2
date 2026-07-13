Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06073C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C99DA10E79E;
	Mon, 13 Jul 2026 05:39:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Wr3bgEv3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8E710E79B;
 Mon, 13 Jul 2026 05:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783921181; x=1815457181;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/dAESFrwjEKPO14HzlzprjYKV21e6xapVow6W+1J/8E=;
 b=Wr3bgEv3eM2gK+HlruzKg6NyAJedJ+mgjNpihvqkZa2eiSRioLq0sLNm
 emOkh/11sKoP0OQgq+cF19zDEFuSIpJLRjoEHJvlrfBNYNTUpzeLOxuLv
 5WpSXkEWXrxqTHEiiJYf1pjXT9x9iiuOGNIiuKnl04JG15b6BoADQRi1M
 nnBrzliXy7uGDnauJ6yXqMjr61iAO4vIWzSuagotIltQiGrLS2YHxZlXu
 86gqFXFSge5OzRMtFl3HS+IVvpzCHKnTI2Fcm9OGhfKefpizaBgcPWiC5
 tkqClV2p+O+/gdRcrRUql6xL3473a814HYLE/IqdeJNoJ05tSCX13fx4+ w==;
X-CSE-ConnectionGUID: eejHRHttTeWU4U+IEFCjMg==
X-CSE-MsgGUID: PRAxveCJTY+QP1NTSVcY2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95670005"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95670005"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2026 22:39:41 -0700
X-CSE-ConnectionGUID: GM43FfxhRP+T55dczJYhbQ==
X-CSE-MsgGUID: 1CeoVOP4TsKuuwWaHpqZXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="252066352"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
 by fmviesa007.fm.intel.com with ESMTP; 12 Jul 2026 22:39:39 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Pranay Samala <pranay.samala@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>
Subject: [CI v4 12/14] drm/i915/color: Extract HDR post-CSC LUT programming to
 helper function
Date: Mon, 13 Jul 2026 10:45:14 +0530
Message-Id: <20260713051516.4087420-13-chaitanya.kumar.borah@intel.com>
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
index abf3b3a2e177..360046979556 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -4050,25 +4050,17 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
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
@@ -4088,8 +4080,21 @@ xelpd_program_plane_post_csc_lut(struct intel_dsb *dsb,
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
2.25.1

