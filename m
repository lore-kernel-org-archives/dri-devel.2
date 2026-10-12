Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F28CA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E5A10EC7D;
	Mon, 12 Oct 2026 04:16:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D5710EC77;
 Mon, 12 Oct 2026 04:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778579; x=1823314579;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1WMapmPSLCqd9Uo+/6yARNgIaPeRv1srjYB6lyGYB4Q=;
 b=bb/GqqYq1n8aR+vTjEcNIqte8gd5pJ138758TCDoINlTJT9kZXFtrOyK
 yHfKL8NAnWemtmAc7zTatf2UFO2t8dfrzwUtWScg9PyhpezIVk+tqpJ88
 axNjAosg2w6Gra8wWt38VDHe1X6uCoZANqoiOPLrafUiuqqhQv++eCB+N
 w8xFxkCT1SbmpxVgcHGO6n+1DTfhFDCo3yWsffi6so74NNNU9Xq6QZKD9
 A2Hl/T/0VZnTDXtIWLhw0b+2sZ/Ldk3GP7LgUadLM6otZJuop7y1Rh+tq
 ExGfw+LLf0Ofe1aWfUI7ezwB6aNF3sZfnwYwJxYctUQ2kHphT3K284obw A==;
X-CSE-ConnectionGUID: UhzaMq97TWuKd6xC1O5t2g==
X-CSE-MsgGUID: F+HcHHZAQ8KnwNoP5wSzNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="366216"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="366216"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:18 -0700
X-CSE-ConnectionGUID: FnvRNHwmT3eTxXOSz28fPA==
X-CSE-MsgGUID: QJiLSdBQSwWU+leuqAWi6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256823"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:16 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 54/56] drm/i915/hdmi: Iterate through joiner candidates in
 compute_config path
Date: Mon, 12 Oct 2026 09:28:03 +0530
Message-ID: <20261012035806.3361439-55-ankit.k.nautiyal@intel.com>
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

A mode that exceeds a single pipe's max dotclock can still be driven by
splitting it across joined pipes. Iterate over the joiner candidates in the
HDMI compute_config path, and pick the first pipe count
that can carry the mode, setting crtc_state->joiner_pipes accordingly.

Allowing these joiner-capable modes in the mode_valid path is handled in
a subsequent change.

Some joiner configurations need DSC to work. Since HDMI DSC will be enabled
in subsequent changes, such configurations are skipped for now.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 67 +++++++++++++++++++++--
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index e3dbd71a3652..2ec7d2a5e7d4 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -64,6 +64,7 @@
 #include "intel_hdcp_shim.h"
 #include "intel_hdmi.h"
 #include "intel_hdmi_frl_dfm.h"
+#include "intel_joiner.h"
 #include "intel_link_bw.h"
 #include "intel_lspcon.h"
 #include "intel_lt_phy.h"
@@ -2453,8 +2454,8 @@ intel_hdmi_compute_frl_config(struct intel_encoder *encoder,
 }
 
 static int
-intel_hdmi_compute_frl_clock(struct intel_encoder *encoder,
-			     struct intel_crtc_state *crtc_state)
+_intel_hdmi_compute_frl_clock(struct intel_encoder *encoder,
+			      struct intel_crtc_state *crtc_state)
 {
 	struct intel_hdmi *hdmi = enc_to_intel_hdmi(encoder);
 	int max_bpc = max(crtc_state->pipe_bpp / 3, 8);
@@ -2485,13 +2486,70 @@ intel_hdmi_compute_frl_clock(struct intel_encoder *encoder,
 	return -EINVAL;
 }
 
+static int
+intel_hdmi_compute_clock_for_joined_pipes(struct intel_encoder *encoder,
+					  struct intel_crtc_state *crtc_state,
+					  struct intel_connector *connector)
+{
+	struct intel_display *display = to_intel_display(encoder);
+	int num_joined_pipes = intel_crtc_num_joined_pipes(crtc_state);
+	const struct drm_display_mode *adjusted_mode =
+		&crtc_state->hw.adjusted_mode;
+	int ret;
+
+	if (intel_joiner_needs_dsc(display, num_joined_pipes))
+		return -EINVAL;
+
+	ret = _intel_hdmi_compute_frl_clock(encoder, crtc_state);
+	if (ret || !intel_dp_dotclk_valid(display,
+					  adjusted_mode->crtc_clock,
+					  adjusted_mode->crtc_htotal,
+					  0,
+					  num_joined_pipes))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int
+intel_hdmi_compute_frl_clock(struct intel_encoder *encoder,
+			     struct intel_crtc_state *crtc_state,
+			     struct intel_connector *connector)
+{
+	struct intel_display *display = to_intel_display(encoder);
+	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
+	const struct drm_display_mode *adjusted_mode =
+		&crtc_state->hw.adjusted_mode;
+	int num_joined_pipes;
+	int ret = -EINVAL;
+
+	for_each_joiner_candidate(connector, adjusted_mode, num_joined_pipes) {
+		if (!(intel_joiner_valid_primary_pipe_mask(display, num_joined_pipes) & BIT(crtc->pipe)))
+			continue;
+
+		if (num_joined_pipes > 1)
+			crtc_state->joiner_pipes = GENMASK(crtc->pipe + num_joined_pipes - 1,
+							   crtc->pipe);
+		ret = intel_hdmi_compute_clock_for_joined_pipes(encoder, crtc_state, connector);
+
+		if (ret == 0)
+			break;
+	}
+
+	if (ret < 0)
+		crtc_state->joiner_pipes = 0;
+
+	return ret;
+}
+
 static int intel_hdmi_compute_clock(struct intel_encoder *encoder,
 				    struct intel_crtc_state *crtc_state,
+				    struct intel_connector *connector,
 				    bool respect_downstream_limits,
 				    bool enable_frl)
 {
 	if (enable_frl)
-		return intel_hdmi_compute_frl_clock(encoder, crtc_state);
+		return intel_hdmi_compute_frl_clock(encoder, crtc_state, connector);
 
 	return intel_hdmi_compute_tmds_clock(encoder, crtc_state, respect_downstream_limits);
 }
@@ -2563,7 +2621,8 @@ static int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
 	crtc_state->sink_format = sink_format;
 	crtc_state->output_format = intel_hdmi_output_format(crtc_state);
 
-	return intel_hdmi_compute_clock(encoder, crtc_state, respect_downstream_limits, enable_frl);
+	return intel_hdmi_compute_clock(encoder, crtc_state, connector,
+					respect_downstream_limits, enable_frl);
 }
 
 static int _intel_hdmi_compute_formats(struct intel_encoder *encoder,
-- 
2.50.1

