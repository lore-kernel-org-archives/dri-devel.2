Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7ECAC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:31:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 365E910F36B;
	Fri,  7 Aug 2026 04:31:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fsZuvt4j";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA4E10F337;
 Fri,  7 Aug 2026 04:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077115; x=1817613115;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=39dGzbcNVftQcZJMBKlCdfdcD1reWXRgienyQte1i7U=;
 b=fsZuvt4jFahNx4vFcwQBCRVI3AC9h0E4tdAkqoDMMT/MO4OMnrqJyT5M
 8l++h28qGxgdrtJQDpmto9ukThegeaqe6aIctIB/w3LMLK09QJAxagr7P
 hwo4lf4Bqfvmth6GvwsxS05o/1LVU4BZVLZPkfvb2wO4s/HXxsg9QD7zE
 DqLTpYcscpPo4o1FDejctT7A2X/EOhZLbRCf96JjtZHMYdivNSuN+NUrx
 M3GMvP+2sTpiE4CNJmTQr69b0BKViE+aBPGFPJPQjtvGdBpEKp273QmAw
 fhzQqIPHEpci+bQ35Fi+YLmmeJoPvele28xoL0UbwpMONtgwSvbz3syuW g==;
X-CSE-ConnectionGUID: gZlcxsJ3R7KyyrtzLxQ0wg==
X-CSE-MsgGUID: TnHoyFPnSjyZUl2xgwHUTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619262"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619262"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:55 -0700
X-CSE-ConnectionGUID: Siebf+PoRxiY4srGzJf+qg==
X-CSE-MsgGUID: Ma26yrZtR9m0sihf5A0CvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666124"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:52 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 11/44] drm/i915/ddi: Factor out common transcoder/vblank
 enable sequence
Date: Fri,  7 Aug 2026 09:43:56 +0530
Message-ID: <20260807041430.229038-12-ankit.k.nautiyal@intel.com>
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

intel_ddi_enable_dp() and intel_ddi_enable_hdmi() both contain an
identical sequence to enable the transcoder, wait for FEC status,
and turn on vblank for each pipe. Move this into a new helper,
intel_ddi_enable_transcoder_and_vblank(), to avoid the duplication.

No functional change.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 43 ++++++++++++------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 4f089df82ec8..5be4a7f00313 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3368,6 +3368,25 @@ static void trans_port_sync_stop_link_train(struct intel_atomic_state *state,
 				 crtc_state);
 }
 
+static void intel_ddi_enable_transcoder_and_vblank(struct intel_atomic_state *state,
+						   struct intel_encoder *encoder,
+						   const struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(encoder);
+	struct intel_crtc *pipe_crtc;
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
+}
+
 static void intel_ddi_enable_dp(struct intel_atomic_state *state,
 				struct intel_encoder *encoder,
 				const struct intel_crtc_state *crtc_state,
@@ -3376,7 +3395,6 @@ static void intel_ddi_enable_dp(struct intel_atomic_state *state,
 	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
-	struct intel_crtc *pipe_crtc;
 	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
 	enum port port = encoder->port;
 
@@ -3406,16 +3424,7 @@ static void intel_ddi_enable_dp(struct intel_atomic_state *state,
 		drm_dp_dpcd_poll_act_handled(&intel_dp->aux, 0);
 	}
 
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
+	intel_ddi_enable_transcoder_and_vblank(state, encoder, crtc_state);
 
 	if (port == PORT_A && DISPLAY_VER(display) < 9)
 		intel_dp_stop_link_train(intel_dp, crtc_state);
@@ -3458,7 +3467,6 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 	struct intel_display *display = to_intel_display(encoder);
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
 	struct drm_connector *connector = conn_state->connector;
-	struct intel_crtc *pipe_crtc;
 	enum port port = encoder->port;
 	u32 buf_ctl = 0;
 
@@ -3466,16 +3474,7 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 
 	intel_vrr_transcoder_enable(crtc_state);
 
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
+	intel_ddi_enable_transcoder_and_vblank(state, encoder, crtc_state);
 
 	if (!intel_hdmi_handle_sink_scrambling(encoder, connector,
 					       crtc_state->hdmi_high_tmds_clock_ratio,
-- 
2.50.1

