Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8391D606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KKS1CcKE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC4710E9A6;
	Mon, 26 Oct 2026 05:41:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6336510E99D;
 Mon, 26 Oct 2026 05:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993270; x=1824529270;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KmnboRRKpqTohjr6C5ZU1rpO26zRgn/WpLIZ+2g5NXQ=;
 b=KKS1CcKEPKf6S7VSUQjTiPVZ5Xsvme7Y8Qzccd3KtJH+q/tLhUGjqX/5
 4WqwBJAa0nZRDruX4H/s/r+h+b3xx1V42PKs1BEcHgDHwm8H60lxsiP3k
 fLQe6YesdNjFRAEzTv7pbMlHeEiqtQu0VCM7vbZF+b+AHXHF+eM4EPucX
 J4bQhqxzK+JD4Ca5s/bar5BphIupTOIem8SKvvl6FvpNm0v3dhxeNNdxN
 rJY655yhHc++0JgJZtEdk6WmTfWr5ZBUxE4cnd3Iq4OIH0dBltwjz6VZp
 l8oL1eFE18ixgf24ZHjTd3DrDWeIRJUujURD0PV5dBXhkuebXLpKnTwZB A==;
X-CSE-ConnectionGUID: 8Cbz9050R0ypUmX7EqZYEQ==
X-CSE-MsgGUID: 1BqtgQc3QQSKpMwCMOEz0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550223"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550223"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:41:09 -0700
X-CSE-ConnectionGUID: MPXtpLXkQFu2fOSLyXezpg==
X-CSE-MsgGUID: Dp4Y24u0QTi4boSZ5lOF9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6002045"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:41:07 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 18/20] drm/i915/alpm: Compute ALPM config before PSR config
Date: Mon, 26 Oct 2026 11:09:29 +0530
Message-ID: <20261026054001.799894-19-animesh.manna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026054001.799894-1-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The ALPM params are computed by alpm_config_valid() while computing the
PSR config and again by intel_alpm_lobf_compute_config() for LOBF.

Add intel_alpm_compute_config() which computes the ALPM params once
before the PSR config and records whether AUX wake and AUX-less ALPM
are possible in alpm_state.aux_wake_possible and
alpm_state.aux_less_possible. Do the LOBF compute from there as well.
alpm_config_valid() now uses these flags to choose between PSR, PSR2
and Panel Replay.

No functional change intended.

Suggested-by: Jouni Högander <jouni.hogander@intel.com>
Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     | 33 +++++++++++++++----
 drivers/gpu/drm/i915/display/intel_alpm.h     |  6 +---
 .../drm/i915/display/intel_display_types.h    |  4 +++
 drivers/gpu/drm/i915/display/intel_dp.c       |  2 +-
 drivers/gpu/drm/i915/display/intel_psr.c      |  8 +++--
 5 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 3123296df6b2..65d06e8ebbe0 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -426,8 +426,8 @@ static int io_buffer_wake_time(const struct intel_crtc_state *crtc_state)
 		return skl_io_buffer_wake_time();
 }
 
-bool intel_alpm_compute_params(struct intel_dp *intel_dp,
-			       struct intel_crtc_state *crtc_state)
+static bool intel_alpm_compute_params(struct intel_dp *intel_dp,
+				      struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 	int io_wake_lines, io_wake_time, fast_wake_lines, fast_wake_time;
@@ -549,9 +549,8 @@ void intel_alpm_lobf_compute_config_late(struct intel_dp *intel_dp,
 			       (first_sdp_position + waketime_in_lines);
 }
 
-void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
-				    struct intel_crtc_state *crtc_state,
-				    struct drm_connector_state *conn_state)
+static void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
+					   struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 
@@ -579,10 +578,32 @@ void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
 	      intel_alpm_aux_less_wake_supported(intel_dp)))
 		return;
 
+	crtc_state->has_lobf = true;
+}
+
+/*
+ * Compute the ALPM params and whether AUX wake / AUX-less ALPM is possible for
+ * the mode and the sink. PSR and Panel Replay use these to choose the feature.
+ */
+void intel_alpm_compute_config(struct intel_dp *intel_dp,
+			       struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+
+	if (!intel_dp_is_edp(intel_dp) && !intel_alpm_is_possible(intel_dp, crtc_state))
+		return;
+
 	if (!intel_alpm_compute_params(intel_dp, crtc_state))
 		return;
 
-	crtc_state->has_lobf = true;
+	crtc_state->alpm_state.aux_wake_possible = true;
+	crtc_state->alpm_state.aux_less_possible =
+		DISPLAY_VER(display) >= 20 &&
+		(intel_dp_is_edp(intel_dp) ||
+		 (intel_alpm_is_possible(intel_dp, crtc_state) &&
+		  intel_alpm_aux_less_wake_supported(intel_dp)));
+
+	intel_alpm_lobf_compute_config(intel_dp, crtc_state);
 }
 
 static u32 get_pr_alpm_as_sdp_transmission_time(const struct intel_crtc_state *crtc_state)
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/i915/display/intel_alpm.h
index 24c319bc5eff..be9b4d761c13 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.h
+++ b/drivers/gpu/drm/i915/display/intel_alpm.h
@@ -10,7 +10,6 @@
 
 struct intel_dp;
 struct intel_crtc_state;
-struct drm_connector_state;
 struct intel_connector;
 struct intel_atomic_state;
 struct intel_crtc;
@@ -19,11 +18,8 @@ int intel_alpm_init_dpcd(struct intel_dp *intel_dp);
 void intel_alpm_init(struct intel_dp *intel_dp);
 bool intel_alpm_is_possible(struct intel_dp *intel_dp,
 			    const struct intel_crtc_state *crtc_state);
-bool intel_alpm_compute_params(struct intel_dp *intel_dp,
+void intel_alpm_compute_config(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state);
-void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
-				    struct intel_crtc_state *crtc_state,
-				    struct drm_connector_state *conn_state);
 void intel_alpm_configure(struct intel_dp *intel_dp,
 			  const struct intel_crtc_state *crtc_state);
 void intel_alpm_enable_sink(struct intel_dp *intel_dp,
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 82a63a2e7fa3..ce7dc3375f2e 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1470,6 +1470,10 @@ struct intel_crtc_state {
 		u8 silence_period_sym_clocks;
 		u8 lfps_half_cycle_num_of_syms;
 		int switch_to_active;
+
+		/* ALPM params are valid for the mode and the sink */
+		bool aux_wake_possible;
+		bool aux_less_possible;
 	} alpm_state;
 
 	/* to track changes in plane color blocks */
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index c543fe551eb8..7827de39e826 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3822,9 +3822,9 @@ intel_dp_compute_config(struct intel_atomic_state *state,
 		pipe_config->dp_m_n.data_m *= pipe_config->splitter.link_count;
 
 	intel_vrr_compute_config(pipe_config, conn_state);
+	intel_alpm_compute_config(intel_dp, pipe_config);
 	intel_psr_compute_config(intel_dp, pipe_config, conn_state);
 	intel_dp_compute_as_sdp(intel_dp, pipe_config);
-	intel_alpm_lobf_compute_config(intel_dp, pipe_config, conn_state);
 	intel_dp_drrs_compute_config(connector, pipe_config, link_bpp_x16);
 	intel_dp_compute_vsc_sdp(intel_dp, pipe_config, conn_state);
 	intel_dp_compute_hdr_metadata_infoframe_sdp(intel_dp, pipe_config, conn_state);
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 4ae47d33096a..c00ec3f64202 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1462,16 +1462,18 @@ static bool wake_lines_fit_into_vblank(struct intel_dp *intel_dp,
 }
 
 static bool alpm_config_valid(struct intel_dp *intel_dp,
-			      struct intel_crtc_state *crtc_state,
+			      const struct intel_crtc_state *crtc_state,
 			      bool aux_less,
 			      bool needs_panel_replay,
 			      bool needs_sel_update)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
+	bool alpm_possible = aux_less ? crtc_state->alpm_state.aux_less_possible :
+					crtc_state->alpm_state.aux_wake_possible;
 
-	if (!intel_alpm_compute_params(intel_dp, crtc_state)) {
+	if (!alpm_possible) {
 		drm_dbg_kms(display->drm,
-			    "PSR2/Panel Replay  not enabled, Unable to use long enough wake times\n");
+			    "PSR2/Panel Replay not enabled, ALPM not possible\n");
 		return false;
 	}
 
-- 
2.43.0

