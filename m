Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA339CA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC13E10E458;
	Mon, 12 Oct 2026 04:14:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7517B10E44B;
 Mon, 12 Oct 2026 04:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778479; x=1823314479;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CBpsoDa0flqWzeTpHiOAaeU7bUlpTrhMY6x1K5uN7wU=;
 b=mX7MOPzfrs9aVzk25d+nDK57j+MKdve4V3ffVE/AS1b1bJoelZX0KZo7
 /YZa7UkcClH1ZULVdjdWHYeL7uI/07x82rUjizbJZTExqijylShBvN9FL
 5MVepSbN1u9rxnMejJnuCQz0076e76DjxLiiXUp2jUCJ+w30NaUJu6oHJ
 BAC6VinoOtSPOJZRG0jvE1PKFuuGHIIoavn1Yv0HRpvYBMOTlyHsG3k5l
 0KtolxFbgMOUClQThSScTJsIfinikUro5V1JJIC+//LS0Vo35Khlr3o87
 +KkJMVq/pcS7L2sDJyt9FW3gyuewqrVBRj+O+q/b6AcFr1FQZoBJDSI5G A==;
X-CSE-ConnectionGUID: uLNsZV/9QUWPePL62IRM/Q==
X-CSE-MsgGUID: EkHLroIWQIq6C1qwnHxUUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380841"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380841"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:39 -0700
X-CSE-ConnectionGUID: 2u54ildhSh2PEgDsSaNGPQ==
X-CSE-MsgGUID: hEvL3Z4kSVWuvQXE1C1wmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256376"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:38 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 11/56] drm/i915/ddi: Factor out common transcoder/vblank
 enable sequence
Date: Mon, 12 Oct 2026 09:27:20 +0530
Message-ID: <20261012035806.3361439-12-ankit.k.nautiyal@intel.com>
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
index c4ca98510747..a5a5a4f37262 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3391,6 +3391,25 @@ static void trans_port_sync_stop_link_train(struct intel_atomic_state *state,
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
@@ -3399,7 +3418,6 @@ static void intel_ddi_enable_dp(struct intel_atomic_state *state,
 	struct intel_display *display = to_intel_display(encoder);
 	struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
-	struct intel_crtc *pipe_crtc;
 	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
 	enum port port = encoder->port;
 
@@ -3429,16 +3447,7 @@ static void intel_ddi_enable_dp(struct intel_atomic_state *state,
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
@@ -3481,7 +3490,6 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 	struct intel_display *display = to_intel_display(encoder);
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
 	struct drm_connector *connector = conn_state->connector;
-	struct intel_crtc *pipe_crtc;
 	enum port port = encoder->port;
 	u32 buf_ctl = 0;
 
@@ -3489,16 +3497,7 @@ static void intel_ddi_enable_hdmi(struct intel_atomic_state *state,
 
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

