Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9408DC982C4
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF5010F1E6;
	Tue, 15 Sep 2026 18:39:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Bw3MPaeX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9938710F190;
 Tue, 15 Sep 2026 18:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497581; x=1821033581;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=azxWQPEDGpCklVciJ4xkWYn0hTwY84vSLtt3cxwKx8U=;
 b=Bw3MPaeXLTrzyOdxVdStihUmUUj26yZCFlyvaoY62Yf7V+t9h++0ygFS
 255RO/UKnWfgWfcVbiW5dZXi0I3VnfnyBmS1asnAfp15ouindqAfIbAlr
 7Ze87QXq5850uN5ESYvkwdVmxZN/KDQ7sBZPIbkAjyMKuXWkYN63g8bhV
 INAgdW3ruMO8BFGgi6oWASs8xCodMrJtU4hFaZYa8Ive7XT/LvA2fo+sr
 J81NEw9WoLytIP5gX/WY/PH5hkWng5Ci9PIv7NPLwdTsOeFKpBKDJQI37
 0wtBFLK3eBN791qoeNx5oLGIKjSM+CKMrChb/WD3S+KVChyQcXCZ0vP4v A==;
X-CSE-ConnectionGUID: hweq1cj8RL62nILvubBwcQ==
X-CSE-MsgGUID: YmBx9GP0SN2xugkSwM3BOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380357"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380357"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:41 -0700
X-CSE-ConnectionGUID: F8Il8iKJS/awrouKL7rdpQ==
X-CSE-MsgGUID: +2ri/wmET8CpdUrMKuLVow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148560"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:39 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 15/18] drm/i915/alpm: Introduce has_alpm to decouple from
 pr/psr2/lobf
Date: Tue, 15 Sep 2026 23:34:46 +0530
Message-Id: <20260915180449.277933-16-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20260915180449.277933-1-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

For DP2.1, ALPM (Advanced Link Power Management) is optional: Panel
Replay can be supported without ALPM. Until now ALPM enablement was
derived implicitly from other features - eDP Panel Replay and PSR2
always implied ALPM (intel_psr_needs_alpm()), while LOBF was tracked
separately via has_lobf - so this scattered, feature-coupled logic
cannot express "Panel Replay without ALPM".

Introduce a single crtc_state->has_alpm flag as the source of truth for
whether ALPM is enabled for a pipe configuration, computed during config
validation:

 - Panel Replay: from alpm_config_valid() when ALPM is possible; eDP
   Panel Replay additionally requires has_alpm.
 - PSR2 / Selective Update: from intel_alpm_is_possible().
 - LOBF: from has_lobf.

The Panel Replay path sets has_alpm speculatively, so clear it when
Panel Replay is not the finally selected feature, ensuring a PSR1
fallback never enables ALPM.

Use has_alpm in place of the feature-specific checks in the ALPM
configure, port configure, sink enable and MAC-transmit-LFPS paths, and
key the late wake-line selection off has_alpm / has_panel_replay.

Also rename intel_alpm_is_alpm_aux_less() to intel_alpm_is_aux_less()
and base the aux-less decision on has_panel_replay, keeping the source
programming consistent with the sink's DP_ALPM_MODE_AUX_LESS. The now
unused intel_psr_needs_alpm() is removed.

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     | 25 +++++-----
 drivers/gpu/drm/i915/display/intel_alpm.h     |  4 +-
 drivers/gpu/drm/i915/display/intel_cx0_phy.c  |  6 ++-
 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_lt_phy.c   |  2 +-
 drivers/gpu/drm/i915/display/intel_psr.c      | 48 +++++++++++--------
 drivers/gpu/drm/i915/display/intel_psr.h      |  1 -
 7 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 29a93a252fe9..236341aa3c8d 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -37,11 +37,11 @@ bool intel_alpm_aux_less_wake_supported(struct intel_dp *intel_dp)
 	return intel_dp->alpm_dpcd & DP_ALPM_AUX_LESS_CAP;
 }
 
-bool intel_alpm_is_alpm_aux_less(struct intel_dp *intel_dp,
-				 const struct intel_crtc_state *crtc_state)
+bool intel_alpm_is_aux_less(struct intel_dp *intel_dp,
+			    const struct intel_crtc_state *crtc_state)
 {
-	return intel_psr_needs_alpm_aux_less(intel_dp, crtc_state) ||
-		(crtc_state->has_lobf && intel_alpm_aux_less_wake_supported(intel_dp));
+	return crtc_state->has_panel_replay ||
+	       (crtc_state->has_lobf && intel_alpm_aux_less_wake_supported(intel_dp));
 }
 
 bool intel_alpm_source_supported(struct intel_connector *connector)
@@ -537,6 +537,7 @@ void intel_alpm_lobf_compute_config_late(struct intel_dp *intel_dp,
 
 	crtc_state->has_lobf = (crtc_state->set_context_latency + crtc_state->vrr.guardband) >
 			       (first_sdp_position + waketime_in_lines);
+	crtc_state->has_alpm = crtc_state->has_lobf;
 }
 
 void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
@@ -719,7 +720,7 @@ void intel_alpm_pr_as_sdp_update(const struct intel_crtc_state *crtc_state)
 		intel_dp = enc_to_intel_dp(encoder);
 
 		if (!intel_dp->as_sdp_supported ||
-		    !intel_alpm_is_alpm_aux_less(intel_dp, crtc_state))
+		    !intel_alpm_is_aux_less(intel_dp, crtc_state))
 			continue;
 
 		mutex_lock(&intel_dp->alpm.lock);
@@ -735,8 +736,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
 	u32 alpm_ctl, alpm_ctl2, lttpr_count;
 
-	if (DISPLAY_VER(display) < 20 || (!intel_psr_needs_alpm(intel_dp, crtc_state) &&
-					  !crtc_state->has_lobf))
+	if (DISPLAY_VER(display) < 20 || !crtc_state->has_alpm)
 		return;
 
 	mutex_lock(&intel_dp->alpm.lock);
@@ -744,7 +744,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 	 * Panel Replay on eDP is always using ALPM aux less. I.e. no need to
 	 * check panel support at this point.
 	 */
-	if (intel_alpm_is_alpm_aux_less(intel_dp, crtc_state)) {
+	if (intel_alpm_is_aux_less(intel_dp, crtc_state)) {
 		alpm_ctl = ALPM_CTL_ALPM_ENABLE |
 			ALPM_CTL_ALPM_AUX_LESS_ENABLE |
 			ALPM_CTL_AUX_LESS_SLEEP_HOLD_TIME_50_SYMBOLS;
@@ -792,10 +792,10 @@ void intel_alpm_port_configure(struct intel_dp *intel_dp,
 	enum port port = dp_to_dig_port(intel_dp)->base.port;
 	u32 alpm_ctl_val = 0, lfps_ctl_val = 0;
 
-	if (DISPLAY_VER(display) < 20)
+	if (DISPLAY_VER(display) < 20 || !crtc_state->has_alpm)
 		return;
 
-	if (intel_alpm_is_alpm_aux_less(intel_dp, crtc_state)) {
+	if (intel_alpm_is_aux_less(intel_dp, crtc_state)) {
 		int lfps_cycle = get_lfps_cycle_count(crtc_state);
 		u32 lfps_cycle_val;
 
@@ -854,13 +854,12 @@ void intel_alpm_enable_sink(struct intel_dp *intel_dp,
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
 
 	drm_dp_dpcd_writeb(&intel_dp->aux, DP_RECEIVER_ALPM_CONFIG, val);
diff --git a/drivers/gpu/drm/i915/display/intel_alpm.h b/drivers/gpu/drm/i915/display/intel_alpm.h
index ea90eba76ca7..5d404e7b07de 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.h
+++ b/drivers/gpu/drm/i915/display/intel_alpm.h
@@ -35,8 +35,8 @@ void intel_alpm_lobf_enable(const struct intel_crtc_state *new_crtc_state);
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
diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index dbebd7210848..26a5d40289ac 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -3449,8 +3449,10 @@ void intel_lnl_mac_transmit_lfps(struct intel_encoder *encoder,
 	int i;
 	u8 owned_lane_mask;
 
-	if (DISPLAY_VER(display) < 20 ||
-	    !intel_alpm_is_alpm_aux_less(enc_to_intel_dp(encoder), crtc_state))
+	if (DISPLAY_VER(display) < 20 || !crtc_state->has_alpm)
+		return;
+
+	if (!intel_alpm_is_aux_less(enc_to_intel_dp(encoder), crtc_state))
 		return;
 
 	owned_lane_mask = intel_cx0_get_owned_lane_mask(encoder);
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index a5f18ac8a7d0..e2cc73c98479 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1448,6 +1448,7 @@ struct intel_crtc_state {
 		u8 silence_period_sym_clocks;
 		u8 lfps_half_cycle_num_of_syms;
 	} alpm_state;
+	bool has_alpm;
 
 	/* to track changes in plane color blocks */
 	bool plane_color_changed;
diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/drm/i915/display/intel_lt_phy.c
index 4fe010df20be..8ebbdc3c0184 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
@@ -2371,7 +2371,7 @@ void intel_xe3plpd_mac_transmit_lfps(struct intel_encoder *encoder,
 	struct ref_tracker *wakeref;
 	u8 owned_lane_mask;
 
-	if (!intel_alpm_is_alpm_aux_less(intel_dp, crtc_state))
+	if (!crtc_state->has_alpm || !intel_alpm_is_aux_less(intel_dp, crtc_state))
 		return;
 
 	wakeref = intel_lt_phy_transaction_begin(encoder);
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 872e253db178..1f14dbe57512 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1648,6 +1648,8 @@ static bool intel_sel_update_config_valid(struct intel_crtc_state *crtc_state,
 	crtc_state->enable_psr2_su_region_et = psr2_su_region_et_valid(connector,
 								       crtc_state->has_panel_replay);
 
+	crtc_state->has_alpm = intel_alpm_is_possible(intel_dp);
+
 	return true;
 
 unsupported:
@@ -1735,11 +1737,17 @@ static bool _panel_replay_compute_config(struct intel_crtc_state *crtc_state,
 	crtc_state->link_off_after_as_sdp_when_pr_active = compute_link_off_after_as_sdp_when_pr_active(connector);
 	crtc_state->disable_as_sdp_when_pr_active = compute_disable_as_sdp_when_pr_active(connector);
 
+	if (intel_alpm_is_possible(intel_dp))
+		crtc_state->has_alpm = alpm_config_valid(intel_dp, crtc_state, true, true, false);
+
 	if (!intel_dp_is_edp(intel_dp))
 		return true;
 
 	/* Remaining checks are for eDP only */
 
+	if (!crtc_state->has_alpm)
+		return false;
+
 	if (to_intel_crtc(crtc_state->uapi.crtc)->pipe != PIPE_A &&
 	    to_intel_crtc(crtc_state->uapi.crtc)->pipe != PIPE_B)
 		return false;
@@ -1762,9 +1770,6 @@ static bool _panel_replay_compute_config(struct intel_crtc_state *crtc_state,
 		return false;
 	}
 
-	if (!alpm_config_valid(intel_dp, crtc_state, true, true, false))
-		return false;
-
 	return true;
 }
 
@@ -1888,6 +1893,15 @@ void intel_psr_compute_config(struct intel_dp *intel_dp,
 	crtc_state->panel_replay_dsc_support = connector->dp.panel_replay_caps.dsc_support;
 	crtc_state->has_panel_replay = _panel_replay_compute_config(crtc_state, conn_state);
 
+	/*
+	 * has_alpm may have been set speculatively while evaluating Panel
+	 * Replay. It is only valid if Panel Replay was actually selected;
+	 * otherwise the finally chosen feature (PSR2/SU or LOBF) decides it and
+	 * a PSR1 fallback must not enable ALPM.
+	 */
+	if (!crtc_state->has_panel_replay)
+		crtc_state->has_alpm = false;
+
 	crtc_state->has_psr = crtc_state->has_panel_replay ? true :
 		_psr_compute_config(intel_dp, crtc_state, conn_state);
 
@@ -4555,16 +4569,6 @@ void intel_psr_connector_debugfs_add(struct intel_connector *connector)
 				    connector, &i915_psr_status_fops);
 }
 
-bool intel_psr_needs_alpm(struct intel_dp *intel_dp, const struct intel_crtc_state *crtc_state)
-{
-	/*
-	 * eDP Panel Replay uses always ALPM
-	 * PSR2 uses ALPM but PSR1 doesn't
-	 */
-	return intel_dp_is_edp(intel_dp) && (crtc_state->has_sel_update ||
-					     crtc_state->has_panel_replay);
-}
-
 bool intel_psr_needs_alpm_aux_less(struct intel_dp *intel_dp,
 				   const struct intel_crtc_state *crtc_state)
 {
@@ -4578,15 +4582,17 @@ void intel_psr_compute_config_late(struct intel_dp *intel_dp,
 	int vblank = intel_crtc_vblank_length(crtc_state);
 	int wake_lines;
 
-	if (intel_psr_needs_alpm_aux_less(intel_dp, crtc_state))
-		wake_lines = crtc_state->alpm_state.aux_less_wake_lines;
-	else if (intel_psr_needs_alpm(intel_dp, crtc_state))
-		wake_lines = DISPLAY_VER(display) < 20 ?
-			     psr2_block_count_lines(crtc_state->alpm_state.io_wake_lines,
-						    crtc_state->alpm_state.fast_wake_lines) :
-			     crtc_state->alpm_state.io_wake_lines;
-	else
+	if (crtc_state->has_alpm) {
+		if (crtc_state->has_panel_replay)
+			wake_lines = crtc_state->alpm_state.aux_less_wake_lines;
+		else
+			wake_lines = DISPLAY_VER(display) < 20 ?
+				     psr2_block_count_lines(crtc_state->alpm_state.io_wake_lines,
+							    crtc_state->alpm_state.fast_wake_lines) :
+				     crtc_state->alpm_state.io_wake_lines;
+	} else {
 		wake_lines = 0;
+	}
 
 	/*
 	 * Disable the PSR features if wake lines exceed the available vblank.
diff --git a/drivers/gpu/drm/i915/display/intel_psr.h b/drivers/gpu/drm/i915/display/intel_psr.h
index d545fdaa0de7..4905ba4da4b8 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.h
+++ b/drivers/gpu/drm/i915/display/intel_psr.h
@@ -79,7 +79,6 @@ void intel_psr_trigger_frame_change_event(struct intel_dsb *dsb,
 int intel_psr_min_set_context_latency(const struct intel_crtc_state *crtc_state);
 void intel_psr_connector_debugfs_add(struct intel_connector *connector);
 void intel_psr_debugfs_register(struct intel_display *display);
-bool intel_psr_needs_alpm(struct intel_dp *intel_dp, const struct intel_crtc_state *crtc_state);
 bool intel_psr_needs_alpm_aux_less(struct intel_dp *intel_dp,
 				   const struct intel_crtc_state *crtc_state);
 void intel_psr_compute_config_late(struct intel_dp *intel_dp,
-- 
2.29.0

