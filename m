Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0391CCA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CA1110E5D3;
	Mon, 12 Oct 2026 04:16:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ED7B10E4C0;
 Mon, 12 Oct 2026 04:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778561; x=1823314561;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QwQyKDdyEwbuO7BH8pDv8mPQ0JaHfjTDkap48ltVi/E=;
 b=XutzbrKiCjUDlayIHtEhyr7/vrKDaY5ANgKheMS36MdAfl+Whr6KmOKW
 +PPB8CnQBGKb1BGWRiZE0+/OGgUiDm+eJVgaHLjpBWrf7oVjnDYE1yazN
 iMHZvCV8ovnKSLqK5QM/R0/PGShJJQX/iyqIzeuNBIG7an12tMKCrtJCE
 n61Z6dX/GYqQ8t8il59gN9P269qVTYV4MTpapLc/2ZvNo/6nBrrlTQS/y
 k/MB6xspWgghASWC1Kk1BxFXf5eAF06ex4YGlt99ACiKM/ELL6B94zB0+
 w7atM4p9ymvhLQmrfvbgi+L6DM94OGKyv1fIre1NY7jAcXBK55RmrE+8j A==;
X-CSE-ConnectionGUID: kG3Hm0XiTDKGhTmzRSIlPA==
X-CSE-MsgGUID: /uu057AGSgKujs9mzdsGhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380947"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380947"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:01 -0700
X-CSE-ConnectionGUID: OUDBACpaSPOumQNncqaRuw==
X-CSE-MsgGUID: yCBz3Wf7QL+dI2urb6YjAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256736"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:00 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 47/56] drm/i915/hdmi: Compute output format for HDMI FRL
 mode
Date: Mon, 12 Oct 2026 09:27:56 +0530
Message-ID: <20261012035806.3361439-48-ankit.k.nautiyal@intel.com>
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

If the source and sink support FRL, then compute output format
that can support HDMI FRL mode. This in turn calculates the FRL
configuration, clocks etc required to support a video mode with
FRL transmission.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 66 +++++++++++++++++------
 1 file changed, 50 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index ce6ad9e28bee..425971d8927a 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2543,10 +2543,11 @@ static int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
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
@@ -2558,7 +2559,7 @@ static int intel_hdmi_compute_formats(struct intel_encoder *encoder,
 		ret = intel_hdmi_compute_output_format(encoder, crtc_state, connector,
 						       respect_downstream_limits,
 						       INTEL_OUTPUT_FORMAT_YCBCR420,
-						       false);
+						       enable_frl);
 
 		if (ret && !respect_downstream_limits) {
 			drm_dbg_kms(display->drm,
@@ -2567,19 +2568,19 @@ static int intel_hdmi_compute_formats(struct intel_encoder *encoder,
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
@@ -2620,6 +2621,26 @@ bool intel_hdmi_compute_has_hdmi_sink(struct intel_encoder *encoder,
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
@@ -2628,6 +2649,9 @@ int intel_hdmi_compute_config(struct intel_encoder *encoder,
 	struct drm_display_mode *adjusted_mode = &pipe_config->hw.adjusted_mode;
 	struct intel_connector *connector = to_intel_connector(conn_state->connector);
 	struct drm_scdc *scdc = &connector->base.display_info.hdmi.scdc;
+	struct intel_hdmi *intel_hdmi = enc_to_intel_hdmi(encoder);
+	bool enable_frl = false;
+	int lane_count = 4;
 	int ret;
 
 	if (adjusted_mode->flags & DRM_MODE_FLAG_DBLSCAN)
@@ -2648,13 +2672,23 @@ int intel_hdmi_compute_config(struct intel_encoder *encoder,
 	if (!intel_link_bw_compute_pipe_bpp(pipe_config))
 		return -EINVAL;
 
-	/*
-	 * Try to respect downstream TMDS clock limits first, if
-	 * that fails assume the user might know something we don't.
-	 */
-	ret = intel_hdmi_compute_formats(encoder, pipe_config, conn_state, true);
-	if (ret)
-		ret = intel_hdmi_compute_formats(encoder, pipe_config, conn_state, false);
+	if (HAS_HDMI_FRL(display) &&
+	    intel_bios_hdmi_max_frl_rate(encoder->devdata) &&
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
@@ -2677,7 +2711,7 @@ int intel_hdmi_compute_config(struct intel_encoder *encoder,
 		adjusted_mode->picture_aspect_ratio =
 			conn_state->picture_aspect_ratio;
 
-	pipe_config->lane_count = 4;
+	pipe_config->lane_count = lane_count;
 
 	if (scdc->scrambling.supported && source_supports_scrambling(encoder) &&
 	    !pipe_config->frl.enable) {
-- 
2.50.1

