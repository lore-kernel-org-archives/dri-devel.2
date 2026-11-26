Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23CF606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cMe7vsus
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 080A510E2DF;
	Thu, 26 Nov 2026 08:40:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3974710E27B;
 Thu, 26 Nov 2026 08:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795682415; x=1827218415;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=igJ0BdNFqrWO7Fq7GkWjBMFMFtlncxAZpHdgdg0J7aw=;
 b=cMe7vsusik0cVG9iyAjUQVQ7tqAIGpaPKSk1+DTSLlwI9zBCdaRJbCDY
 7UZsnVTHxcJYXSSmvyvDZbvsjPXQVUmfNuEMRnvh9kJShls1mIaQW9Kig
 rEgK9B1Xo1eSuTvrsXmKuvRXRTqFSHTVvMm3lG1vnqaLO4/v65zxmTwqF
 R+Msph+id7ZAEwQF2V+0zW5FzB+jzWYEo7cincB241yJIHiFan+HJfdj2
 Tb5026zWglCwFIlTDKIiaI2IIDOXz5iruyBIxKNRjJx8kV+hHkA+XiLqD
 Fz/a72MUIeY3t5rhRm01Grgt6CowLVd4DkJ3n7DcF1t9whJE0OyK4t67A Q==;
X-CSE-ConnectionGUID: V1XRYXAJRpeq+Ee3Q3wyTA==
X-CSE-MsgGUID: Riuip6ErSnqdwKJtc81BsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4488505"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4488505"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:40:14 -0800
X-CSE-ConnectionGUID: uCymn9kcQKipx1GVfQ8V3Q==
X-CSE-MsgGUID: 0qkfENF+Q3mh4x2qapY0Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12125650"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 26 Nov 2026 00:40:12 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Thu, 26 Nov 2026 14:04:56 +0530
Subject: [PATCH v6 01/13] drm/i915/dp: Factor out the DSC slice count and
 link bpp lookup
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vlk-64036-dp-symbol-tg-v6-1-835a4f5c0a12@intel.com>
References: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
In-Reply-To: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 chaitanya.kumar.borah@intel.com, uma.shankar@intel.com, 
 suraj.kandpal@intel.com, Arun R Murthy <arun.r.murthy@intel.com>
X-Mailer: b4 0.15-dev
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the DSC slice count and link bpp determination out of
intel_dp_compute_min_hblank() into a helper, so that it can be shared
with the upcoming DP symbol based timing generator computation.
No functional change.

v3: change intel_dp_get_sclice_and_link_bpp -> intel_dp_compute_ (Suraj)

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 51 ++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index bf5e87a72108eaf274f24bc997f2e8e2cc8320a0..db7c8fcc8683aae1a2bc7050ef7c87ed5155c8dc 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3628,6 +3628,35 @@ intel_dp_queue_modeset_retry_for_link(struct intel_atomic_state *state,
 	}
 }
 
+static int intel_dp_compute_dsc_slices_and_link_bpp(const struct intel_crtc_state *crtc_state,
+						    struct intel_connector *connector,
+						    int *dsc_slices, int *link_bpp_x16)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	const struct drm_display_mode *adjusted_mode =
+					&crtc_state->hw.adjusted_mode;
+
+	*dsc_slices = 0;
+
+	if (crtc_state->dsc.compression_enable) {
+		*dsc_slices = intel_dp_dsc_get_slice_count(connector,
+							   adjusted_mode->crtc_clock,
+							   adjusted_mode->crtc_hdisplay,
+							   intel_crtc_num_joined_pipes(crtc_state));
+		if (!*dsc_slices) {
+			drm_dbg(display->drm, "failed to calculate dsc slice count\n");
+			return -EINVAL;
+		}
+
+		*link_bpp_x16 = crtc_state->dsc.compressed_bpp_x16;
+	} else {
+		*link_bpp_x16 = intel_dp_output_format_link_bpp_x16(crtc_state->output_format,
+								    crtc_state->pipe_bpp);
+	}
+
+	return 0;
+}
+
 int intel_dp_compute_min_hblank(struct intel_crtc_state *crtc_state,
 				const struct drm_connector_state *conn_state)
 {
@@ -3642,12 +3671,12 @@ int intel_dp_compute_min_hblank(struct intel_crtc_state *crtc_state,
 	 */
 	int min_sym_cycles = intel_dp_is_uhbr(crtc_state) ? 3 : 5;
 	bool is_mst = intel_crtc_has_type(crtc_state, INTEL_OUTPUT_DP_MST);
-	int num_joined_pipes = intel_crtc_num_joined_pipes(crtc_state);
 	int min_hblank;
 	int max_lane_count = 4;
 	int hactive_sym_cycles, htotal_sym_cycles;
 	int dsc_slices = 0;
 	int link_bpp_x16;
+	int ret;
 
 	if (DISPLAY_VER(display) < 30)
 		return 0;
@@ -3656,22 +3685,10 @@ int intel_dp_compute_min_hblank(struct intel_crtc_state *crtc_state,
 	if (!is_mst && !intel_dp_is_uhbr(crtc_state))
 		return 0;
 
-	if (crtc_state->dsc.compression_enable) {
-		dsc_slices = intel_dp_dsc_get_slice_count(connector,
-							  adjusted_mode->crtc_clock,
-							  adjusted_mode->crtc_hdisplay,
-							  num_joined_pipes);
-		if (!dsc_slices) {
-			drm_dbg(display->drm, "failed to calculate dsc slice count\n");
-			return -EINVAL;
-		}
-	}
-
-	if (crtc_state->dsc.compression_enable)
-		link_bpp_x16 = crtc_state->dsc.compressed_bpp_x16;
-	else
-		link_bpp_x16 = intel_dp_output_format_link_bpp_x16(crtc_state->output_format,
-								   crtc_state->pipe_bpp);
+	ret = intel_dp_compute_dsc_slices_and_link_bpp(crtc_state, connector,
+						       &dsc_slices, &link_bpp_x16);
+	if (ret)
+		return ret;
 
 	/* Calculate min Hblank Link Layer Symbol Cycle Count for 8b/10b MST & 128b/132b */
 	hactive_sym_cycles = drm_dp_link_symbol_cycles(max_lane_count,

-- 
2.25.1

