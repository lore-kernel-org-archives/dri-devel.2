Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D03AC5ACAE
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07FF510F3F3;
	Fri,  7 Aug 2026 04:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iidoSf99";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D19A110F3F3;
 Fri,  7 Aug 2026 04:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077197; x=1817613197;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lkDEhWjiHU83WXJNY+zZWAOyk0JQyzG9crHNqTW4m/A=;
 b=iidoSf99PpdnQVkSZodJjFDl7rpYZYUotZmzUwt2vP/YHA2qpHNyyU0+
 F5qoPwTZT+B6WFmT6bM/MmVENtel9U2zWysHTd+d7e3MXdrWnLedHxj0T
 eciyDs6BqbmZxtU6xMtT+HXRWce8ceiTCQbdOQqkieD0AddC9k5BtZSJb
 xzUD20lUYaJnvcLikVk0of/+kRNV2WKZifbA+lWMw7cHYe6oD/q8lBStq
 rKZcpc+9GcxBYzj0E9N3EuUzl0dAMRkAgIsEmAI3ooJd70UTCBPt2aQBT
 7Fzv0rSSq6pgk52LzHB1o0m3z5yMn+R1TwmUZwc+2HEbTURkWFlRhFwyr g==;
X-CSE-ConnectionGUID: wBnGbxvZQ+CiCmCp3PM5pw==
X-CSE-MsgGUID: 5s04q56FQcecMbZqnvcXGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619408"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619408"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:17 -0700
X-CSE-ConnectionGUID: qJXjXG2CQZSdVJSH4ecmPw==
X-CSE-MsgGUID: LLcntWXBS9ma8/uwPOmVSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666614"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:14 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 43/44] drm/i915/hdmi: Compute output format for HDMI FRL mode
Date: Fri,  7 Aug 2026 09:44:28 +0530
Message-ID: <20260807041430.229038-44-ankit.k.nautiyal@intel.com>
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

If the source and sink support FRL, then compute output format
that can support HDMI FRL mode. This in turn calculates the FRL
configuration, clocks etc required to support a video mode with
FRL transmission.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 66 +++++++++++++++++------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 05d3bb40ca30..1773b2096e9f 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2467,10 +2467,11 @@ static int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
 	return intel_hdmi_compute_clock(encoder, crtc_state, respect_downstream_limits, enable_frl);
 }
 
-static int intel_hdmi_compute_formats(struct intel_encoder *encoder,
-				      struct intel_crtc_state *crtc_state,
-				      const struct drm_connector_state *conn_state,
-				      bool respect_downstream_limits)
+static int _intel_hdmi_compute_formats(struct intel_encoder *encoder,
+				       struct intel_crtc_state *crtc_state,
+				       const struct drm_connector_state *conn_state,
+				       bool respect_downstream_limits,
+				       bool enable_frl)
 {
 	struct intel_display *display = to_intel_display(encoder);
 	struct intel_connector *connector = to_intel_connector(conn_state->connector);
@@ -2482,7 +2483,7 @@ static int intel_hdmi_compute_formats(struct intel_encoder *encoder,
 		ret = intel_hdmi_compute_output_format(encoder, crtc_state, connector,
 						       respect_downstream_limits,
 						       INTEL_OUTPUT_FORMAT_YCBCR420,
-						       false);
+						       enable_frl);
 
 		if (ret && !respect_downstream_limits) {
 			drm_dbg_kms(display->drm,
@@ -2491,19 +2492,19 @@ static int intel_hdmi_compute_formats(struct intel_encoder *encoder,
 			ret = intel_hdmi_compute_output_format(encoder, crtc_state, connector,
 							       respect_downstream_limits,
 							       INTEL_OUTPUT_FORMAT_RGB,
-							       false);
+							       enable_frl);
 		}
 	} else {
 		ret = intel_hdmi_compute_output_format(encoder, crtc_state, connector,
 						       respect_downstream_limits,
 						       INTEL_OUTPUT_FORMAT_RGB,
-						       false);
+						       enable_frl);
 
 		if (ret && drm_mode_is_420_also(info, adjusted_mode))
 			ret = intel_hdmi_compute_output_format(encoder, crtc_state, connector,
 							       respect_downstream_limits,
 							       INTEL_OUTPUT_FORMAT_YCBCR420,
-							       false);
+							       enable_frl);
 	}
 
 	return ret;
@@ -2544,6 +2545,26 @@ bool intel_hdmi_compute_has_hdmi_sink(struct intel_encoder *encoder,
 		!intel_hdmi_is_cloned(crtc_state);
 }
 
+static int intel_hdmi_compute_formats(struct intel_encoder *encoder,
+				      struct intel_crtc_state *crtc_state,
+				      const struct drm_connector_state *conn_state,
+				      bool enable_frl)
+{
+	int ret;
+
+	/*
+	 * Try to respect downstream TMDS clock limits first, if
+	 * that fails assume the user might know something we don't.
+	 */
+	ret = _intel_hdmi_compute_formats(encoder, crtc_state,
+					  conn_state, true, enable_frl);
+	if (ret)
+		ret = _intel_hdmi_compute_formats(encoder, crtc_state,
+						  conn_state, false, enable_frl);
+
+	return ret;
+}
+
 int intel_hdmi_compute_config(struct intel_encoder *encoder,
 			      struct intel_crtc_state *pipe_config,
 			      struct drm_connector_state *conn_state)
@@ -2552,6 +2573,9 @@ int intel_hdmi_compute_config(struct intel_encoder *encoder,
 	struct drm_display_mode *adjusted_mode = &pipe_config->hw.adjusted_mode;
 	struct intel_connector *connector = to_intel_connector(conn_state->connector);
 	struct drm_scdc *scdc = &connector->base.display_info.hdmi.scdc;
+	struct intel_hdmi *intel_hdmi = enc_to_intel_hdmi(encoder);
+	bool enable_frl = false;
+	int lane_count = 4;
 	int ret;
 
 	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
@@ -2576,13 +2600,23 @@ int intel_hdmi_compute_config(struct intel_encoder *encoder,
 		intel_hdmi_has_audio(encoder, pipe_config, conn_state) &&
 		intel_audio_compute_config(encoder, pipe_config, conn_state);
 
-	/*
-	 * Try to respect downstream TMDS clock limits first, if
-	 * that fails assume the user might know something we don't.
-	 */
-	ret = intel_hdmi_compute_formats(encoder, pipe_config, conn_state, true);
-	if (ret)
-		ret = intel_hdmi_compute_formats(encoder, pipe_config, conn_state, false);
+	if (HAS_HDMI_FRL(display) &&
+	    intel_bios_hdmi_max_frl_rate(encoder) &&
+	    intel_hdmi->has_sink_hdmi_21)
+		enable_frl = true;
+
+	ret = intel_hdmi_compute_formats(encoder, pipe_config, conn_state, false);
+
+	if (ret && enable_frl) {
+		ret = intel_hdmi_compute_formats(encoder, pipe_config, conn_state, true);
+		drm_dbg_kms(display->drm,
+			    "Enabling FRL mode with lanes = %d rate = %d\n",
+			    pipe_config->frl.required_lanes,
+			    pipe_config->frl.required_rate);
+		pipe_config->frl.enable = true;
+		lane_count = pipe_config->frl.required_lanes;
+	}
+
 	if (ret) {
 		drm_dbg_kms(display->drm,
 			    "unsupported HDMI clock (%d kHz), rejecting mode\n",
@@ -2601,7 +2635,7 @@ int intel_hdmi_compute_config(struct intel_encoder *encoder,
 		adjusted_mode->picture_aspect_ratio =
 			conn_state->picture_aspect_ratio;
 
-	pipe_config->lane_count = 4;
+	pipe_config->lane_count = lane_count;
 
 	if (scdc->scrambling.supported && source_supports_scrambling(encoder) &&
 	    !pipe_config->frl.enable) {
-- 
2.50.1

