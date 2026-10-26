Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4455606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GNCFG8As
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A53E810E9A5;
	Mon, 26 Oct 2026 05:41:22 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD69810E985;
 Mon, 26 Oct 2026 05:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993273; x=1824529273;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EnlGgs5KEPpujwgWLLwH8IJiVDcL8pebn+Nr3HyZayU=;
 b=GNCFG8As7tc9WI9ly4U+NKNbBHeQ4Y5i5X2Hl1P9GF1nhd/+5Dy88iWz
 Oq0f05ZmEX4/A/B2Ti0f9Q0+V+NLZsMT2WNJk0lANIUM1QebA+92n4BQ2
 Lf2GAJzVEvrTwUaSfoNUPjVvndJpp5ZJIiyreCJCQv9VLQVVzfeVkkrqb
 JGyjqTOSgXROMOFYhvb9WSx1bSSgpWQkgl1i7VUgi14tgzlrkDEMgK/nR
 lQ9eTX+dYd9K3KgqdPJlXXOuk8YrbhTBsbP2xY0ESo3vUTF4pl94klpFv
 tUhgjKZlvEmkVLRuW5v5XtVdeY7GjeL7xbLPDazUlHtlwN/QwothOknc4 g==;
X-CSE-ConnectionGUID: iU0Wmi86TVOH97q56y54OQ==
X-CSE-MsgGUID: U0jsm33sQ1qlyg98xPEyzg==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550226"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550226"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:41:13 -0700
X-CSE-ConnectionGUID: 1B5t/Q4mQqOkOW5Ia7PBHQ==
X-CSE-MsgGUID: zKonzSPkSJO0u+mZKP+sxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6002056"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:41:11 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 19/20] drm/i915/alpm: Introduce has_alpm to decouple from
 pr/psr2/lobf
Date: Mon, 26 Oct 2026 11:09:30 +0530
Message-ID: <20261026054001.799894-20-animesh.manna@intel.com>
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

For DP2.1, ALPM (Advanced Link Power Management) is optional: Panel
Replay can be supported without ALPM. Until now ALPM enablement was
derived implicitly from other features - eDP Panel Replay and PSR2
always implied ALPM (intel_psr_needs_alpm()), while LOBF was tracked
separately via has_lobf - so this scattered, feature-coupled logic
cannot express "Panel Replay without ALPM".

Introduce a single crtc_state->has_alpm flag as the source of truth for
whether ALPM is enabled. It is set in one place, in the new
intel_alpm_compute_config_late(), once the final PSR, Panel Replay and
LOBF state is known:

 - eDP Panel Replay and PSR2 always use ALPM.
 - DP Panel Replay uses ALPM only if AUX-less ALPM is possible and its
   wake time fits, otherwise Panel Replay is used without ALPM.
 - Otherwise ALPM follows LOBF.

intel_alpm_compute_config_late() also does the late LOBF checks that
intel_alpm_lobf_compute_config_late() did before.

Use has_alpm in the ALPM configure and sink enable paths, and require
it in intel_alpm_is_aux_less() (renamed from
intel_alpm_is_alpm_aux_less()) so that AUX-less ALPM programming,
including the AS SDP part of PR_ALPM_CTL and the MAC transmit LFPS, is
skipped when ALPM is not used. Require the ALPM DPCD caps for AUX-less
ALPM on eDP as well.

v2:
- Set has_alpm in one place in intel_alpm_compute_config_late(). [Jouni]
- Don't let selective update overwrite has_alpm. [sashiko]
- Don't leave has_alpm set when PSR features are dropped late. [sashiko]
- Keep clearing the port ALPM registers when ALPM is not used. [sashiko]
- Require has_alpm for AUX-less ALPM programming. [sashiko]
- Keep ALPM enabled for PSR2 regardless of the ALPM DPCD caps.

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     | 55 +++++++++++++------
 drivers/gpu/drm/i915/display/intel_alpm.h     |  8 +--
 drivers/gpu/drm/i915/display/intel_cx0_phy.c  |  2 +-
 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c       |  2 +-
 drivers/gpu/drm/i915/display/intel_lt_phy.c   |  2 +-
 drivers/gpu/drm/i915/display/intel_psr.c      | 11 +++-
 drivers/gpu/drm/i915/display/intel_psr.h      |  3 +-
 8 files changed, 57 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 65d06e8ebbe0..47263af0970c 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -37,11 +37,12 @@ bool intel_alpm_aux_less_wake_supported(struct intel_dp *intel_dp)
 	return intel_dp->alpm_dpcd & DP_ALPM_AUX_LESS_CAP;
 }
 
-bool intel_alpm_is_alpm_aux_less(struct intel_dp *intel_dp,
-				 const struct intel_crtc_state *crtc_state)
+bool intel_alpm_is_aux_less(struct intel_dp *intel_dp,
+			    const struct intel_crtc_state *crtc_state)
 {
-	return intel_psr_needs_alpm_aux_less(intel_dp, crtc_state) ||
-		(crtc_state->has_lobf && intel_alpm_aux_less_wake_supported(intel_dp));
+	return crtc_state->has_alpm &&
+	       (crtc_state->has_panel_replay ||
+		(crtc_state->has_lobf && intel_alpm_aux_less_wake_supported(intel_dp)));
 }
 
 static bool intel_alpm_source_supported(struct intel_dp *intel_dp)
@@ -509,8 +510,8 @@ static bool intel_alpm_lobf_is_window1_sufficient(struct intel_crtc_state *crtc_
 	return window1 > crtc_state->alpm_state.check_entry_lines;
 }
 
-void intel_alpm_lobf_compute_config_late(struct intel_dp *intel_dp,
-					 struct intel_crtc_state *crtc_state)
+static void intel_alpm_lobf_compute_config_late(struct intel_dp *intel_dp,
+						struct intel_crtc_state *crtc_state)
 {
 	struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
 	int waketime_in_lines, first_sdp_position;
@@ -598,14 +599,34 @@ void intel_alpm_compute_config(struct intel_dp *intel_dp,
 
 	crtc_state->alpm_state.aux_wake_possible = true;
 	crtc_state->alpm_state.aux_less_possible =
-		DISPLAY_VER(display) >= 20 &&
-		(intel_dp_is_edp(intel_dp) ||
-		 (intel_alpm_is_possible(intel_dp, crtc_state) &&
-		  intel_alpm_aux_less_wake_supported(intel_dp)));
+		DISPLAY_VER(display) >= 20 && intel_alpm_is_possible(intel_dp, crtc_state) &&
+		(intel_dp_is_edp(intel_dp) || intel_alpm_aux_less_wake_supported(intel_dp));
 
 	intel_alpm_lobf_compute_config(intel_dp, crtc_state);
 }
 
+/*
+ * Decide whether ALPM is enabled once PSR, Panel Replay and LOBF have been
+ * finalized. eDP Panel Replay and PSR2 always use ALPM, for DP Panel Replay
+ * ALPM is optional and used only if the AUX-less wake time fits.
+ */
+void intel_alpm_compute_config_late(struct intel_dp *intel_dp,
+				    struct intel_crtc_state *crtc_state)
+{
+	int aux_less_wake_lines = crtc_state->alpm_state.aux_less_wake_lines;
+
+	intel_alpm_lobf_compute_config_late(intel_dp, crtc_state);
+
+	if (crtc_state->has_psr && crtc_state->has_panel_replay)
+		crtc_state->has_alpm = intel_dp_is_edp(intel_dp) ||
+			(crtc_state->alpm_state.aux_less_possible &&
+			 intel_psr_wake_lines_fit_into_vblank(crtc_state, aux_less_wake_lines));
+	else if (crtc_state->has_psr && crtc_state->has_sel_update)
+		crtc_state->has_alpm = intel_dp_is_edp(intel_dp);
+	else
+		crtc_state->has_alpm = crtc_state->has_lobf;
+}
+
 static u32 get_pr_alpm_as_sdp_transmission_time(const struct intel_crtc_state *crtc_state)
 {
 	u8 as_sdp_setup_time = intel_dp_as_sdp_transmission_time();
@@ -750,7 +771,7 @@ void intel_alpm_pr_as_sdp_update(const struct intel_crtc_state *crtc_state)
 		intel_dp = enc_to_intel_dp(encoder);
 
 		if (!intel_dp->as_sdp_supported ||
-		    !intel_alpm_is_alpm_aux_less(intel_dp, crtc_state))
+		    !intel_alpm_is_aux_less(intel_dp, crtc_state))
 			continue;
 
 		mutex_lock(&intel_dp->alpm.lock);
@@ -767,8 +788,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 	u32 alpm_ctl, alpm_ctl2;
 	int lttpr_count;
 
-	if (DISPLAY_VER(display) < 20 || (!intel_psr_needs_alpm(intel_dp, crtc_state) &&
-					  !crtc_state->has_lobf))
+	if (DISPLAY_VER(display) < 20 || !crtc_state->has_alpm)
 		return;
 
 	mutex_lock(&intel_dp->alpm.lock);
@@ -776,7 +796,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 	 * Panel Replay on eDP is always using ALPM aux less. I.e. no need to
 	 * check panel support at this point.
 	 */
-	if (intel_alpm_is_alpm_aux_less(intel_dp, crtc_state)) {
+	if (intel_alpm_is_aux_less(intel_dp, crtc_state)) {
 		int wake_lines = crtc_state->alpm_state.aux_less_wake_lines;
 
 		alpm_ctl = ALPM_CTL_ALPM_ENABLE |
@@ -832,7 +852,7 @@ void intel_alpm_port_configure(struct intel_dp *intel_dp,
 	if (DISPLAY_VER(display) < 20)
 		return;
 
-	if (intel_alpm_is_alpm_aux_less(intel_dp, crtc_state)) {
+	if (intel_alpm_is_aux_less(intel_dp, crtc_state)) {
 		int lfps_cycle = get_lfps_cycle_count(crtc_state);
 		u32 lfps_cycle_val;
 
@@ -888,13 +908,12 @@ void intel_alpm_enable_sink(struct intel_dp *intel_dp,
 {
 	u8 val;
 
-	if (!intel_psr_needs_alpm(intel_dp, crtc_state) && !crtc_state->has_lobf)
+	if (!crtc_state->has_alpm)
 		return;
 
 	val = DP_ALPM_ENABLE | DP_ALPM_LOCK_ERROR_IRQ_HPD_ENABLE;
 
-	if (crtc_state->has_panel_replay || (crtc_state->has_lobf &&
-					     intel_alpm_aux_less_wake_supported(intel_dp)))
+	if (intel_alpm_is_aux_less(intel_dp, crtc_state))
 		val |= DP_ALPM_MODE_AUX_LESS;
 
 	drm_dp_dpcd_write_byte(&intel_dp->aux, DP_RECEIVER_ALPM_CONFIG, val);
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/i915/display/intel_alpm.h
index be9b4d761c13..a35a98a55a8d 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.h
+++ b/drivers/gpu/drm/i915/display/intel_alpm.h
@@ -31,14 +31,14 @@ void intel_alpm_lobf_enable(const struct intel_crtc_state *new_crtc_state);
 void intel_alpm_lobf_debugfs_add(struct intel_connector *connector);
 bool intel_alpm_aux_wake_supported(struct intel_dp *intel_dp);
 bool intel_alpm_aux_less_wake_supported(struct intel_dp *intel_dp);
-bool intel_alpm_is_alpm_aux_less(struct intel_dp *intel_dp,
-				 const struct intel_crtc_state *crtc_state);
+bool intel_alpm_is_aux_less(struct intel_dp *intel_dp,
+			    const struct intel_crtc_state *crtc_state);
 bool intel_alpm_pr_as_sdp_skip_frames_enabled(struct intel_dp *intel_dp,
 					      const struct intel_crtc_state *crtc_state);
 void intel_alpm_pr_as_sdp_update(const struct intel_crtc_state *crtc_state);
 void intel_alpm_disable(struct intel_dp *intel_dp);
 bool intel_alpm_get_error(struct intel_dp *intel_dp);
-void intel_alpm_lobf_compute_config_late(struct intel_dp *intel_dp,
-					 struct intel_crtc_state *crtc_state);
+void intel_alpm_compute_config_late(struct intel_dp *intel_dp,
+				    struct intel_crtc_state *crtc_state);
 int intel_alpm_lobf_min_guardband(struct intel_crtc_state *crtc_state);
 #endif
diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index 814615fe9951..453526c4b3a9 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -3453,7 +3453,7 @@ void intel_lnl_mac_transmit_lfps(struct intel_encoder *encoder,
 	u8 owned_lane_mask;
 
 	if (DISPLAY_VER(display) < 20 ||
-	    !intel_alpm_is_alpm_aux_less(enc_to_intel_dp(encoder), crtc_state))
+	    !intel_alpm_is_aux_less(enc_to_intel_dp(encoder), crtc_state))
 		return;
 
 	owned_lane_mask = intel_cx0_get_owned_lane_mask(encoder);
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index ce7dc3375f2e..73d82df2ff92 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1475,6 +1475,7 @@ struct intel_crtc_state {
 		bool aux_wake_possible;
 		bool aux_less_possible;
 	} alpm_state;
+	bool has_alpm;
 
 	/* to track changes in plane color blocks */
 	bool plane_color_changed;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 7827de39e826..43b17d2ed93f 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -7594,7 +7594,7 @@ int intel_dp_compute_config_late(struct intel_encoder *encoder,
 	if (ret)
 		return ret;
 
-	intel_alpm_lobf_compute_config_late(intel_dp, crtc_state);
+	intel_alpm_compute_config_late(intel_dp, crtc_state);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/drm/i915/display/intel_lt_phy.c
index 5b26957d7fb9..74ef0d29756c 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
@@ -2371,7 +2371,7 @@ void intel_lt_mac_transmit_lfps(struct intel_encoder *encoder,
 	struct ref_tracker *wakeref;
 	u8 owned_lane_mask;
 
-	if (!intel_alpm_is_alpm_aux_less(intel_dp, crtc_state))
+	if (!intel_alpm_is_aux_less(intel_dp, crtc_state))
 		return;
 
 	wakeref = intel_lt_phy_transaction_begin(encoder);
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index c00ec3f64202..4c429a14b50e 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1426,6 +1426,14 @@ static bool _wake_lines_fit_into_vblank(const struct intel_crtc_state *crtc_stat
 	return true;
 }
 
+bool intel_psr_wake_lines_fit_into_vblank(const struct intel_crtc_state *crtc_state,
+					  int wake_lines)
+{
+	return _wake_lines_fit_into_vblank(crtc_state,
+					   intel_crtc_vblank_length(crtc_state),
+					   wake_lines);
+}
+
 static bool wake_lines_fit_into_vblank(struct intel_dp *intel_dp,
 				       const struct intel_crtc_state *crtc_state,
 				       bool aux_less,
@@ -4547,7 +4555,8 @@ void intel_psr_connector_debugfs_add(struct intel_connector *connector)
 				    connector, &i915_psr_status_fops);
 }
 
-bool intel_psr_needs_alpm(struct intel_dp *intel_dp, const struct intel_crtc_state *crtc_state)
+static bool intel_psr_needs_alpm(struct intel_dp *intel_dp,
+				 const struct intel_crtc_state *crtc_state)
 {
 	/*
 	 * eDP Panel Replay uses always ALPM
diff --git a/drivers/gpu/drm/i915/display/intel_psr.h b/drivers/gpu/drm/i915/display/intel_psr.h
index d545fdaa0de7..2557776a402b 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.h
+++ b/drivers/gpu/drm/i915/display/intel_psr.h
@@ -79,9 +79,10 @@ void intel_psr_trigger_frame_change_event(struct intel_dsb *dsb,
 int intel_psr_min_set_context_latency(const struct intel_crtc_state *crtc_state);
 void intel_psr_connector_debugfs_add(struct intel_connector *connector);
 void intel_psr_debugfs_register(struct intel_display *display);
-bool intel_psr_needs_alpm(struct intel_dp *intel_dp, const struct intel_crtc_state *crtc_state);
 bool intel_psr_needs_alpm_aux_less(struct intel_dp *intel_dp,
 				   const struct intel_crtc_state *crtc_state);
+bool intel_psr_wake_lines_fit_into_vblank(const struct intel_crtc_state *crtc_state,
+					  int wake_lines);
 void intel_psr_compute_config_late(struct intel_dp *intel_dp,
 				   struct intel_crtc_state *crtc_state);
 int intel_psr_min_guardband(struct intel_crtc_state *crtc_state);
-- 
2.43.0

