Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0787FCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2209610E45D;
	Mon, 12 Oct 2026 04:14:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F1410E443;
 Mon, 12 Oct 2026 04:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778477; x=1823314477;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=on7lXy+1Wk4EjEDRKDNtoKmI64AJqAvq/RzzsZQgsoI=;
 b=mIVsPNsByAFoKgyvBz+VdZK0aB0AyBLSg+cyhzLKhDNeFHG5ZK7qx/od
 OWNbvyg9YBJET3KlQKVaL2bWi8W26y/FzwYs+yy2lnj1UIfyutcLxQcpT
 wVEjzed1D2fn3TN4Qz2zgGVjbvojK5R4iSwVMZ1bROb5VWnYeNMW5AM0S
 Wv5JNnu/3BdcdKZfJNdivlxhaL50/ZYGYBdu/3XWZPGmdpiAcUZZ4nHpQ
 x9/w4MHTmrOwr8lcrXla1u0NB5+9R4bOcLbQTeot9xnf0bjJM/26L/E22
 q465qn1l38c0H/l0vECDjMvz3kbI5fZsJd208LJhP0QGRfnARE9msQVTD A==;
X-CSE-ConnectionGUID: NLqlqpNoQrKg63VzFuLiIA==
X-CSE-MsgGUID: OiUFY9sORJifjApGQesKGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380839"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380839"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:37 -0700
X-CSE-ConnectionGUID: 6ncEp7YCTr+YrCeT/Ow2Sw==
X-CSE-MsgGUID: AWsksfLwSC+0vIs4DNKNwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256370"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:36 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 10/56] drm/i915/ddi: Simplify intel_ddi_enable()
Date: Mon, 12 Oct 2026 09:27:19 +0530
Message-ID: <20261012035806.3361439-11-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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
index 576e66774678..c4ca98510747 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3399,8 +3399,47 @@ static void intel_ddi_enable_dp(struct intel_atomic_state *state,
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
 
@@ -3442,9 +3481,25 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
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
@@ -3554,57 +3609,12 @@ static void intel_ddi_enable(struct intel_atomic_state *state,
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

