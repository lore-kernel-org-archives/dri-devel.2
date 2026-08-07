Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BC3C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:31:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34DE210F36A;
	Fri,  7 Aug 2026 04:31:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CHK2RBqn";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF39910F369;
 Fri,  7 Aug 2026 04:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077113; x=1817613113;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hgRM0geeuRzvhJBBaKdilnhVXMeyIcWoi2jCD4J+/+0=;
 b=CHK2RBqnOWJ/4201fEa8mSiRu1AI9WLFCJHKEbrowYrJRw94uV0R7B+G
 DsCjDzxiEgi2Z7dxLpJLKrNVX9Xsb++4y4V0IWxddtPXrOOtwa0RcpOIX
 dJfkgkLCqUW+IxzpWJ9OK7xSjvypRZcPNJqUFNXTUKh140p9DVV7NEkxJ
 cV0cl87D+PDkMMIdN9ZZAGc70VSb655QxQfteDI89wYT8pMYayF9J8SYj
 /fQDNqwo8PvUOXHha3MrJJKg7/lcOIwZDl25W4darqfvXYHjDzlrnwqRW
 +FgSLo8tGcyvZwQolRIcoCLTkh4Sv9sYsFVKCIR+QOi3pl55nOmD8YY8F g==;
X-CSE-ConnectionGUID: G6GFwoIpRRq+BsR9wcd5Wg==
X-CSE-MsgGUID: 0XqPpox+TpeehuBg/W9Www==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619260"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619260"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:53 -0700
X-CSE-ConnectionGUID: wSy2O2ZlQO+rt7mL3nLzhA==
X-CSE-MsgGUID: zrvSig5ISW+xiN/0x3yZmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666118"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:50 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 10/44] drm/i915/ddi: Simplify intel_ddi_enable()
Date: Fri,  7 Aug 2026 09:43:55 +0530
Message-ID: <20260807041430.229038-11-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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

Currently, intel_ddi_enable() has more HDMI- and DP-specific steps
than shared ones. Furthermore, from MTL onwards the sequence of
enabling the Port and TRANS_CONF has also diverged, which is not
currently accounted for.

Move the encoder-specific steps into their respective helpers and
simplify intel_ddi_enable(), which now simply dispatches to
intel_ddi_enable_{hdmi,dp}() and calls intel_hdcp_enable() at the
end.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 102 +++++++++++++----------
 1 file changed, 56 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 48411a4d30c3..4f089df82ec8 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3376,8 +3376,47 @@ static void intel_ddi_enable_dp(struct intel_atomic_state *state,
 	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
+	struct intel_crtc *pipe_crtc;
+	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
 	enum port port = encoder->port;
 
+	/* 128b/132b SST */
+	if (intel_dp_is_uhbr(crtc_state)) {
+		const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
+		u64 crtc_clock_hz = KHz(adjusted_mode->crtc_clock);
+
+		intel_de_write(display, TRANS_DP2_VFREQHIGH(cpu_transcoder),
+			       TRANS_DP2_VFREQ_PIXEL_CLOCK(crtc_clock_hz >> 24));
+		intel_de_write(display, TRANS_DP2_VFREQLOW(cpu_transcoder),
+			       TRANS_DP2_VFREQ_PIXEL_CLOCK(crtc_clock_hz & 0xffffff));
+	}
+
+	intel_ddi_enable_transcoder_func(encoder, crtc_state);
+
+	intel_vrr_transcoder_enable(crtc_state);
+
+	/* 128b/132b SST */
+	if (intel_dp_is_uhbr(crtc_state)) {
+		intel_ddi_clear_act_sent(encoder, crtc_state);
+
+		intel_de_rmw(display, TRANS_DDI_FUNC_CTL(display, cpu_transcoder), 0,
+			     TRANS_DDI_DP_VC_PAYLOAD_ALLOC);
+
+		intel_ddi_wait_for_act_sent(encoder, crtc_state);
+		drm_dp_dpcd_poll_act_handled(&intel_dp->aux, 0);
+	}
+
+	intel_enable_transcoder(crtc_state);
+
+	intel_ddi_wait_for_fec_status(encoder, crtc_state, true);
+
+	for_each_pipe_crtc_modeset_enable(display, pipe_crtc, crtc_state) {
+		const struct intel_crtc_state *pipe_crtc_state =
+			intel_atomic_get_new_crtc_state(state, pipe_crtc);
+
+		intel_crtc_vblank_on(pipe_crtc_state);
+	}
+
 	if (port == PORT_A && DISPLAY_VER(display) < 9)
 		intel_dp_stop_link_train(intel_dp, crtc_state);
 
@@ -3419,9 +3458,25 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 	struct intel_display *display = to_intel_display(encoder);
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
 	struct drm_connector *connector = conn_state->connector;
+	struct intel_crtc *pipe_crtc;
 	enum port port = encoder->port;
 	u32 buf_ctl = 0;
 
+	intel_ddi_enable_transcoder_func(encoder, crtc_state);
+
+	intel_vrr_transcoder_enable(crtc_state);
+
+	intel_enable_transcoder(crtc_state);
+
+	intel_ddi_wait_for_fec_status(encoder, crtc_state, true);
+
+	for_each_pipe_crtc_modeset_enable(display, pipe_crtc, crtc_state) {
+		const struct intel_crtc_state *pipe_crtc_state =
+			intel_atomic_get_new_crtc_state(state, pipe_crtc);
+
+		intel_crtc_vblank_on(pipe_crtc_state);
+	}
+
 	if (!intel_hdmi_handle_sink_scrambling(encoder, connector,
 					       crtc_state->hdmi_high_tmds_clock_ratio,
 					       crtc_state->hdmi_scrambling))
@@ -3531,57 +3586,12 @@ static void intel_ddi_enable(struct intel_atomic_state *state,
 			     const struct intel_crtc_state *crtc_state,
 			     const struct drm_connector_state *conn_state)
 {
-	struct intel_display *display = to_intel_display(encoder);
-	struct intel_crtc *pipe_crtc;
-	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
-	bool is_hdmi = intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI);
-
-	/* 128b/132b SST */
-	if (!is_hdmi && intel_dp_is_uhbr(crtc_state)) {
-		const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
-		u64 crtc_clock_hz = KHz(adjusted_mode->crtc_clock);
-
-		intel_de_write(display, TRANS_DP2_VFREQHIGH(cpu_transcoder),
-			       TRANS_DP2_VFREQ_PIXEL_CLOCK(crtc_clock_hz >> 24));
-		intel_de_write(display, TRANS_DP2_VFREQLOW(cpu_transcoder),
-			       TRANS_DP2_VFREQ_PIXEL_CLOCK(crtc_clock_hz & 0xffffff));
-	}
-
-	intel_ddi_enable_transcoder_func(encoder, crtc_state);
-
-	intel_vrr_transcoder_enable(crtc_state);
-
-	/* 128b/132b SST */
-	if (!is_hdmi && intel_dp_is_uhbr(crtc_state)) {
-		struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
-
-		intel_ddi_clear_act_sent(encoder, crtc_state);
-
-		intel_de_rmw(display, TRANS_DDI_FUNC_CTL(display, cpu_transcoder), 0,
-			     TRANS_DDI_DP_VC_PAYLOAD_ALLOC);
-
-		intel_ddi_wait_for_act_sent(encoder, crtc_state);
-		drm_dp_dpcd_poll_act_handled(&intel_dp->aux, 0);
-	}
-
-	intel_enable_transcoder(crtc_state);
-
-	intel_ddi_wait_for_fec_status(encoder, crtc_state, true);
-
-	for_each_pipe_crtc_modeset_enable(display, pipe_crtc, crtc_state) {
-		const struct intel_crtc_state *pipe_crtc_state =
-			intel_atomic_get_new_crtc_state(state, pipe_crtc);
-
-		intel_crtc_vblank_on(pipe_crtc_state);
-	}
-
-	if (is_hdmi)
+	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI))
 		intel_ddi_enable_hdmi(state, encoder, crtc_state, conn_state);
 	else
 		intel_ddi_enable_dp(state, encoder, crtc_state, conn_state);
 
 	intel_hdcp_enable(state, encoder, crtc_state, conn_state);
-
 }
 
 static void intel_ddi_disable_dp(struct intel_atomic_state *state,
-- 
2.50.1

