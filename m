Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83843606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=idPG8A59
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC383112196;
	Thu, 26 Nov 2026 08:41:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E4AE112187;
 Thu, 26 Nov 2026 08:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795682452; x=1827218452;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=lIO2nED+OOBjDK6gf1ZzTBVADKPefQjtv7UFQxuPTk8=;
 b=idPG8A59h5859oQh7H+wnCdRlw3Am6Mk/LHz6IfqTpbrDyxYdzVUVAmS
 U7EVCXMK0Ks2F+K04PQZZgiLuTUeKanb7ziqbSHngwQa6ga0nOT10zcIX
 XTNrtPVs1gS3i3400mdHwbOiQBuTqIVTGslLwVV7D+GGp6wmn+nYS2OMt
 SdiSRfxpP02P0aVcGbaXGu7nvxuaHduDmEve0DTxhhbKdZN32xQvll1XV
 FZXV0ZC2QhKNwEjtcHWYor0ywjUDyDhRPJyRRHQ2ZoCN96onAdp9u6N5n
 xXa5pUiOMn8fOvEFM1SP1O1McnOfZcRkInxcvKWEM/Jzv4DFPTxK5DjA+ g==;
X-CSE-ConnectionGUID: lnE2+9f1QiWZjrgG925zoA==
X-CSE-MsgGUID: Vr0HSC6LS5+pNsSRTnu6kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4488597"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4488597"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:40:43 -0800
X-CSE-ConnectionGUID: F9wPCdhmQIuqmc7upn61EQ==
X-CSE-MsgGUID: NSQbg6ZZRw+CsO4mkbeJwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12125751"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 26 Nov 2026 00:40:40 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Thu, 26 Nov 2026 14:05:07 +0530
Subject: [PATCH v6 12/13] drm/i915/dp: Account for the symbol TG in the DP
 BW calculations
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-vlk-64036-dp-symbol-tg-v6-12-835a4f5c0a12@intel.com>
References: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
In-Reply-To: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 chaitanya.kumar.borah@intel.com, uma.shankar@intel.com, 
 suraj.kandpal@intel.com, Arun R Murthy <arun.r.murthy@intel.com>
X-Mailer: b4 0.15-dev
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With the symbol based timing generator the stream is padded per line with
the LL symbol cycle granularity, which the pixel based timing generator
based BW model doesn't account for. As the link config, the TU and the PBN
are sized from that model, nothing guaranteed that the Data M/N of the
symbol based timing generator fits the reserved TUs/slots.

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c        | 197 +++++++++++++++----------
 drivers/gpu/drm/i915/display/intel_dp.h        |  25 ++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c    | 116 +++++++++++----
 drivers/gpu/drm/i915/display/intel_dp_tunnel.c |   4 +-
 4 files changed, 226 insertions(+), 116 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 82966028b2a2867889169ca372d8d36b576d9119..217b5d1e082f2bb9ee15773e382c528700671584 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1469,9 +1469,11 @@ intel_dp_mode_valid_format(struct intel_connector *connector,
 
 	link_bpp_x16 = intel_dp_mode_min_link_bpp_x16(connector, mode,
 						      output_format);
-	mode_rate = intel_dp_link_required(max_link_clock, max_lanes,
-					   target_clock, mode->hdisplay,
-					   link_bpp_x16, 0);
+	mode_rate = intel_dp_stream_link_required(intel_dp, false,
+						  max_link_clock, max_lanes,
+						  target_clock, mode->hdisplay,
+						  mode->htotal, 0, output_format,
+						  link_bpp_x16, 0);
 
 	/*
 	 * We cannot determine the required pipe‑join count before knowing whether
@@ -1517,9 +1519,10 @@ intel_dp_mode_valid_format(struct intel_connector *connector,
 				if (!drm_dp_is_uhbr_rate(max_link_clock))
 					bw_overhead_flags |= DRM_DP_BW_OVERHEAD_FEC;
 
-				dsc = intel_dp_mode_valid_with_dsc(connector,
+				dsc = intel_dp_mode_valid_with_dsc(connector, false,
 								   max_link_clock, max_lanes,
 								   target_clock, mode->hdisplay,
+								   mode->htotal,
 								   num_joined_pipes,
 								   output_format, pipe_bpp,
 								   bw_overhead_flags);
@@ -1531,7 +1534,7 @@ intel_dp_mode_valid_format(struct intel_connector *connector,
 			continue;
 		}
 
-		if (mode_rate > max_rate && !dsc) {
+		if ((mode_rate < 0 || mode_rate > max_rate) && !dsc) {
 			status = MODE_CLOCK_HIGH;
 			continue;
 		}
@@ -1540,14 +1543,6 @@ intel_dp_mode_valid_format(struct intel_connector *connector,
 		if (status != MODE_OK)
 			continue;
 
-		if (!intel_dp_mode_valid_symbol_tg(connector, intel_dp, false, mode,
-						   max_link_clock, output_format,
-						   mode_rate <= max_rate,
-						   dsc ? dsc_slice_count : 0)) {
-			status = MODE_H_ILLEGAL;
-			continue;
-		}
-
 		if (!dsc)
 			dsc_slice_count = 0;
 
@@ -1871,16 +1866,20 @@ intel_dp_compute_link_config_wide(struct intel_dp *intel_dp,
 					&pipe_config->hw.adjusted_mode;
 			int mode_rate;
 
-			mode_rate = intel_dp_link_required(link_config.rate,
-							   link_config.lane_count,
-							   clock, adjusted_mode->hdisplay,
-							   link_bpp_x16, 0);
+			mode_rate = intel_dp_stream_link_required(intel_dp, false,
+								  link_config.rate,
+								  link_config.lane_count,
+								  clock,
+								  adjusted_mode->hdisplay,
+								  adjusted_mode->htotal, 0,
+								  pipe_config->output_format,
+								  link_bpp_x16, 0);
 
 			link_avail = intel_dp_max_link_data_rate(intel_dp,
 								 link_config.rate,
 								 link_config.lane_count);
 
-			if (mode_rate <= link_avail) {
+			if (mode_rate >= 0 && mode_rate <= link_avail) {
 				pipe_config->lane_count = link_config.lane_count;
 				pipe_config->pipe_bpp = bpp;
 				pipe_config->port_clock = link_config.rate;
@@ -2067,21 +2066,26 @@ static bool intel_dp_dsc_supports_format(const struct intel_connector *connector
 	return drm_dp_dsc_sink_supports_format(connector->dp.dsc_dpcd, sink_dsc_format);
 }
 
-static bool is_bw_sufficient_for_dsc_config(struct intel_dp *intel_dp,
+static bool is_bw_sufficient_for_dsc_config(struct intel_dp *intel_dp, bool is_mst,
 					    int link_clock, int lane_count,
 					    int mode_clock, int mode_hdisplay,
-					    int dsc_slice_count, int link_bpp_x16,
+					    int mode_htotal, int dsc_slice_count,
+					    enum intel_output_format output_format,
+					    int link_bpp_x16,
 					    unsigned long bw_overhead_flags)
 {
 	int available_bw;
 	int required_bw;
 
 	available_bw = intel_dp_max_link_data_rate(intel_dp, link_clock, lane_count);
-	required_bw = intel_dp_link_required(link_clock, lane_count,
-					     mode_clock, mode_hdisplay,
-					     link_bpp_x16, bw_overhead_flags);
+	required_bw = intel_dp_stream_link_required(intel_dp, is_mst,
+						    link_clock, lane_count,
+						    mode_clock, mode_hdisplay,
+						    mode_htotal, dsc_slice_count,
+						    output_format, link_bpp_x16,
+						    bw_overhead_flags);
 
-	return available_bw >= required_bw;
+	return required_bw >= 0 && available_bw >= required_bw;
 }
 
 static int dsc_compute_link_config(struct intel_dp *intel_dp,
@@ -2129,12 +2133,14 @@ static int dsc_compute_link_config(struct intel_dp *intel_dp,
 			int line_slice_count =
 				intel_dsc_line_slice_count(&pipe_config->dsc.slice_config);
 
-			if (!is_bw_sufficient_for_dsc_config(intel_dp,
+			if (!is_bw_sufficient_for_dsc_config(intel_dp, false,
 							     link_config.rate,
 							     link_config.lane_count,
 							     adjusted_mode->crtc_clock,
 							     adjusted_mode->hdisplay,
+							     adjusted_mode->htotal,
 							     line_slice_count,
+							     pipe_config->output_format,
 							     dsc_bpp_x16,
 							     bw_overhead_flags))
 				continue;
@@ -2658,14 +2664,15 @@ static int compute_max_compressed_bpp_x16(struct intel_connector *connector,
 	return max_link_bpp_x16;
 }
 
-bool intel_dp_mode_valid_with_dsc(struct intel_connector *connector,
+bool intel_dp_mode_valid_with_dsc(struct intel_connector *connector, bool is_mst,
 				  int link_clock, int lane_count,
-				  int mode_clock, int mode_hdisplay,
+				  int mode_clock, int mode_hdisplay, int mode_htotal,
 				  int num_joined_pipes,
 				  enum intel_output_format output_format,
 				  int pipe_bpp, unsigned long bw_overhead_flags)
 {
-	struct intel_dp *intel_dp = intel_attached_dp(connector);
+	struct intel_dp *intel_dp = is_mst ? connector->mst.dp :
+					     intel_attached_dp(connector);
 	int min_bpp_x16 = intel_dp_compute_min_compressed_bpp_x16(connector,
 								  output_format);
 	int max_bpp_x16 = compute_max_compressed_bpp_x16(connector,
@@ -2684,10 +2691,11 @@ bool intel_dp_mode_valid_with_dsc(struct intel_connector *connector,
 	if (dsc_slice_count == 0)
 		return false;
 
-	return is_bw_sufficient_for_dsc_config(intel_dp,
+	return is_bw_sufficient_for_dsc_config(intel_dp, is_mst,
 					       link_clock, lane_count,
 					       mode_clock, mode_hdisplay,
-					       dsc_slice_count, min_bpp_x16,
+					       mode_htotal, dsc_slice_count,
+					       output_format, min_bpp_x16,
 					       bw_overhead_flags);
 }
 
@@ -2975,13 +2983,30 @@ intel_dp_compute_config_limits(struct intel_dp *intel_dp,
 						       limits);
 }
 
-int intel_dp_config_required_rate(const struct intel_crtc_state *crtc_state)
+int intel_dp_config_required_rate(struct intel_dp *intel_dp,
+				  const struct intel_crtc_state *crtc_state)
 {
 	const struct drm_display_mode *adjusted_mode =
 		&crtc_state->hw.adjusted_mode;
 	int link_bpp_x16 = crtc_state->dsc.compression_enable ?
 		crtc_state->dsc.compressed_bpp_x16 :
 		fxp_q4_from_int(crtc_state->pipe_bpp);
+	int dsc_slice_count = crtc_state->dsc.compression_enable ?
+		intel_dsc_line_slice_count(&crtc_state->dsc.slice_config) : 0;
+	bool is_mst = intel_crtc_has_type(crtc_state, INTEL_OUTPUT_DP_MST);
+	int required_rate;
+
+	required_rate = intel_dp_stream_link_required(intel_dp, is_mst,
+						      crtc_state->port_clock,
+						      crtc_state->lane_count,
+						      adjusted_mode->crtc_clock,
+						      adjusted_mode->hdisplay,
+						      adjusted_mode->htotal,
+						      dsc_slice_count,
+						      crtc_state->output_format,
+						      link_bpp_x16, 0);
+	if (required_rate >= 0)
+		return required_rate;
 
 	return intel_dp_link_required(crtc_state->port_clock, crtc_state->lane_count,
 				      adjusted_mode->crtc_clock, adjusted_mode->hdisplay,
@@ -3092,7 +3117,7 @@ intel_dp_compute_link_for_joined_pipes(struct intel_encoder *encoder,
 		    pipe_config->pipe_bpp,
 		    FXP_Q4_ARGS(pipe_config->dsc.compressed_bpp_x16),
 		    str_yes_no(intel_dp_in_hdr_mode(conn_state)),
-		    intel_dp_config_required_rate(pipe_config),
+		    intel_dp_config_required_rate(intel_dp, pipe_config),
 		    intel_dp_max_link_data_rate(intel_dp,
 						pipe_config->port_clock,
 						pipe_config->lane_count));
@@ -3833,23 +3858,73 @@ static bool intel_dp_symbol_tg_cycles_in_range(const struct intel_dp_symbol_tg_c
 }
 
 /*
- * Check if the LL symbol timings of a mode fit the symbol based timing
- * generator registers, for the given link rate and link bpp. The lower the
- * bpp, the fewer cycles, so this can be called with the minimum bpp to prune
- * the modes which can't be supported with any bpp.
+ * Get the bpp and the BW overhead to use for the BW calculations of a stream
+ * using the symbol based timing generator. The symbol based timing generator
+ * pads the stream per line with the LL symbol cycle (4 symbols) granularity,
+ * which is accounted for by the effective bpp (EFF_PIX_BPP_LL_SYM), so only the
+ * SSC and FEC margin applies on top of it.
+ *
+ * Returns -EINVAL if the stream's LL symbol timings don't fit the symbol based
+ * timing generator.
  */
-static bool intel_dp_symbol_tg_mode_valid(struct intel_dp *intel_dp,
-					  const struct drm_display_mode *mode,
-					  int link_rate, int link_bpp_x16, int dsc_slices,
-					  enum intel_output_format output_format)
+int intel_dp_symbol_tg_bw_params(struct intel_dp *intel_dp,
+				 int hdisplay, int htotal,
+				 int link_bpp_x16, int dsc_slice_count,
+				 enum intel_output_format output_format,
+				 bool is_uhbr, unsigned long bw_overhead_flags,
+				 int *bw_bpp_x16, int *bw_overhead)
 {
 	struct intel_dp_symbol_tg_cycles cycles;
+	int symbol_size = is_uhbr ? 32 : 8;
+
+	intel_dp_symbol_tg_calc_cycles(intel_dp, hdisplay, htotal, link_bpp_x16,
+				       dsc_slice_count, output_format, is_uhbr,
+				       &cycles);
 
-	intel_dp_symbol_tg_calc_cycles(intel_dp, mode->hdisplay, mode->htotal,
-				       link_bpp_x16, dsc_slices, output_format,
-				       drm_dp_is_uhbr_rate(link_rate), &cycles);
+	if (!intel_dp_symbol_tg_cycles_in_range(&cycles))
+		return -EINVAL;
+
+	if (is_uhbr)
+		bw_overhead_flags |= DRM_DP_BW_OVERHEAD_UHBR;
+
+	/* EFF_PIX_BPP_LL_SYM = EFF_HTOTAL_LL_SYM_CYC_CNT * SYMBOL_SIZE * 4 / Htotal */
+	*bw_bpp_x16 = DIV_ROUND_UP((cycles.hactive + cycles.hblank) *
+				   LL_SYMBOLS_PER_CYCLE * symbol_size * 16, htotal);
+	*bw_overhead = max(drm_dp_bw_margin_overhead(bw_overhead_flags),
+			   intel_dp_bw_fec_overhead(bw_overhead_flags & DRM_DP_BW_OVERHEAD_FEC));
+
+	return 0;
+}
+
+/*
+ * The required data bandwidth of a stream, taking into account the symbol
+ * based timing generator, if that is used. Returns -EINVAL if the stream
+ * doesn't fit the symbol based timing generator.
+ */
+int intel_dp_stream_link_required(struct intel_dp *intel_dp, bool is_mst,
+				  int link_clock, int lane_count,
+				  int mode_clock, int mode_hdisplay, int mode_htotal,
+				  int dsc_slice_count,
+				  enum intel_output_format output_format,
+				  int link_bpp_x16, unsigned long bw_overhead_flags)
+{
+	struct intel_display *display = to_intel_display(intel_dp);
+	bool is_uhbr = drm_dp_is_uhbr_rate(link_clock);
+	int bw_bpp_x16, bw_overhead, ret;
+
+	if (!intel_dp_use_symbol_tg(display, is_mst, is_uhbr))
+		return intel_dp_link_required(link_clock, lane_count,
+					      mode_clock, mode_hdisplay,
+					      link_bpp_x16, bw_overhead_flags);
+
+	ret = intel_dp_symbol_tg_bw_params(intel_dp, mode_hdisplay, mode_htotal,
+					   link_bpp_x16, dsc_slice_count,
+					   output_format, is_uhbr, bw_overhead_flags,
+					   &bw_bpp_x16, &bw_overhead);
+	if (ret)
+		return ret;
 
-	return intel_dp_symbol_tg_cycles_in_range(&cycles);
+	return intel_dp_effective_data_rate(mode_clock, bw_bpp_x16, bw_overhead);
 }
 
 /* 64 x 64 -> 128 bit multiplication, result as {lo, hi} */
@@ -3898,40 +3973,6 @@ void intel_dp_symbol_tg_select_mn(struct intel_crtc_state *crtc_state)
 								      &crtc_state->dpll_hw_state));
 }
 
-/*
- * Check if the LL symbol timings of a mode can be supported by the symbol
- * based timing generator, if that is used for the given link, either with an
- * uncompressed stream (if @uncompressed_ok) or with DSC (if @dsc_slice_count
- * is not 0), at the minimum link bpp.
- */
-bool intel_dp_mode_valid_symbol_tg(struct intel_connector *connector,
-				   struct intel_dp *intel_dp, bool is_mst,
-				   const struct drm_display_mode *mode,
-				   int link_rate,
-				   enum intel_output_format output_format,
-				   bool uncompressed_ok, int dsc_slice_count)
-{
-	struct intel_display *display = to_intel_display(connector);
-	int min_bpp_x16, min_compressed_bpp_x16;
-
-	if (!intel_dp_use_symbol_tg(display, is_mst, drm_dp_is_uhbr_rate(link_rate)))
-		return true;
-
-	min_bpp_x16 = intel_dp_mode_min_link_bpp_x16(connector, mode, output_format);
-	if (uncompressed_ok &&
-	    intel_dp_symbol_tg_mode_valid(intel_dp, mode, link_rate,
-					  min_bpp_x16, 0, output_format))
-		return true;
-
-	min_compressed_bpp_x16 = intel_dp_compute_min_compressed_bpp_x16(connector,
-									 output_format);
-
-	return dsc_slice_count &&
-		intel_dp_symbol_tg_mode_valid(intel_dp, mode, link_rate,
-					      min_compressed_bpp_x16,
-					      dsc_slice_count, output_format);
-}
-
 /* Compute the DP link layer (LL) symbol based timing generator parameters */
 int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index db65912047332bd788adc0fdd9401e06cf5acfa8..538c57fb5cd60fe9d863570ab2e38cb4954cbfec 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -107,7 +107,8 @@ void intel_dp_mst_suspend(struct intel_display *display);
 void intel_dp_mst_resume(struct intel_display *display);
 int intel_dp_rate_limit_len(const int *rates, int len, int max_rate);
 int intel_dp_max_source_lane_count(struct intel_digital_port *dig_port);
-int intel_dp_config_required_rate(const struct intel_crtc_state *crtc_state);
+int intel_dp_config_required_rate(struct intel_dp *intel_dp,
+				  const struct intel_crtc_state *crtc_state);
 int intel_dp_rate_select(struct intel_dp *intel_dp, int rate);
 int intel_dp_rate_index(const int *rates, int len, int rate);
 void intel_dp_update_sink_caps(struct intel_dp *intel_dp);
@@ -149,9 +150,9 @@ int intel_dp_compute_min_compressed_bpp_x16(struct intel_connector *connector,
 bool intel_dp_get_connector_max_link_config(struct intel_connector *connector,
 					    const struct link_config_limits *limits,
 					    struct intel_dp_link_config *max_link_config);
-bool intel_dp_mode_valid_with_dsc(struct intel_connector *connector,
+bool intel_dp_mode_valid_with_dsc(struct intel_connector *connector, bool is_mst,
 				  int link_clock, int lane_count,
-				  int mode_clock, int mode_hdisplay,
+				  int mode_clock, int mode_hdisplay, int mode_htotal,
 				  int num_joined_pipes,
 				  enum intel_output_format output_format,
 				  int pipe_bpp, unsigned long bw_overhead_flags);
@@ -217,12 +218,18 @@ int intel_dp_dsc_min_src_compressed_bpp(void);
 int intel_dp_compute_min_hblank(struct intel_crtc_state *crtc_state,
 				const struct drm_connector_state *conn_state);
 bool intel_dp_use_symbol_tg(struct intel_display *display, bool is_mst, bool is_uhbr);
-bool intel_dp_mode_valid_symbol_tg(struct intel_connector *connector,
-				   struct intel_dp *intel_dp, bool is_mst,
-				   const struct drm_display_mode *mode,
-				   int link_rate,
-				   enum intel_output_format output_format,
-				   bool uncompressed_ok, int dsc_slice_count);
+int intel_dp_symbol_tg_bw_params(struct intel_dp *intel_dp,
+				 int hdisplay, int htotal,
+				 int link_bpp_x16, int dsc_slice_count,
+				 enum intel_output_format output_format,
+				 bool is_uhbr, unsigned long bw_overhead_flags,
+				 int *bw_bpp_x16, int *bw_overhead);
+int intel_dp_stream_link_required(struct intel_dp *intel_dp, bool is_mst,
+				  int link_clock, int lane_count,
+				  int mode_clock, int mode_hdisplay, int mode_htotal,
+				  int dsc_slice_count,
+				  enum intel_output_format output_format,
+				  int link_bpp_x16, unsigned long bw_overhead_flags);
 void intel_dp_symbol_tg_select_mn(struct intel_crtc_state *crtc_state);
 int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index ed615ee2f51ec08bb8d7f2e729f95edcf83de5b1..858f2c28e2703865ab6bc6887f6da5eca7f58524 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -176,22 +176,61 @@ static int intel_dp_mst_max_dpt_bpp(const struct intel_crtc_state *crtc_state,
 			 mul_u32_u32(adjusted_mode->crtc_clock, 1030000));
 }
 
-static int intel_dp_mst_bw_overhead(const struct intel_crtc_state *crtc_state,
-				    bool ssc, int dsc_slice_count, int bpp_x16)
+static unsigned long intel_dp_mst_bw_overhead_flags(const struct intel_crtc_state *crtc_state,
+						    bool ssc)
 {
-	const struct drm_display_mode *adjusted_mode =
-		&crtc_state->hw.adjusted_mode;
 	unsigned long flags = DRM_DP_BW_OVERHEAD_MST;
 
 	flags |= ssc ? DRM_DP_BW_OVERHEAD_SSC_REF_CLK : 0;
 	flags |= crtc_state->fec_enable ? DRM_DP_BW_OVERHEAD_FEC : 0;
 
+	return flags;
+}
+
+static int intel_dp_mst_bw_overhead(const struct intel_crtc_state *crtc_state,
+				    bool ssc, int dsc_slice_count, int bpp_x16)
+{
+	const struct drm_display_mode *adjusted_mode =
+		&crtc_state->hw.adjusted_mode;
+
 	return intel_dp_link_bw_overhead(crtc_state->port_clock,
 					 crtc_state->lane_count,
 					 adjusted_mode->hdisplay,
 					 dsc_slice_count,
 					 bpp_x16,
-					 flags);
+					 intel_dp_mst_bw_overhead_flags(crtc_state, ssc));
+}
+
+/*
+ * Get the bpp and the BW overhead to use for the BW calculations of a stream,
+ * accounting for the symbol based timing generator, if that is used. Returns
+ * -EINVAL if the stream doesn't fit the symbol based timing generator.
+ */
+static int intel_dp_mst_bw_params(struct intel_dp *intel_dp,
+				  const struct intel_crtc_state *crtc_state,
+				  bool ssc, int dsc_slice_count, int link_bpp_x16,
+				  int *bw_bpp_x16, int *bw_overhead)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	const struct drm_display_mode *adjusted_mode =
+		&crtc_state->hw.adjusted_mode;
+	bool is_mst = intel_crtc_has_type(crtc_state, INTEL_OUTPUT_DP_MST);
+
+	if (intel_dp_use_symbol_tg(display, is_mst, intel_dp_is_uhbr(crtc_state)))
+		return intel_dp_symbol_tg_bw_params(intel_dp,
+						    adjusted_mode->crtc_hdisplay,
+						    adjusted_mode->crtc_htotal,
+						    link_bpp_x16, dsc_slice_count,
+						    crtc_state->output_format,
+						    intel_dp_is_uhbr(crtc_state),
+						    intel_dp_mst_bw_overhead_flags(crtc_state, ssc),
+						    bw_bpp_x16, bw_overhead);
+
+	*bw_bpp_x16 = link_bpp_x16;
+	*bw_overhead = intel_dp_mst_bw_overhead(crtc_state, ssc, dsc_slice_count,
+						link_bpp_x16);
+
+	return 0;
 }
 
 static void intel_dp_mst_compute_m_n(const struct intel_crtc_state *crtc_state,
@@ -324,8 +363,9 @@ int intel_dp_mtp_tu_compute_config(struct intel_dp *intel_dp,
 	drm_WARN_ON(display->drm, min_bpp_x16 % bpp_step_x16 || max_bpp_x16 % bpp_step_x16);
 
 	for (bpp_x16 = max_bpp_x16; bpp_x16 >= min_bpp_x16; bpp_x16 -= bpp_step_x16) {
-		int local_bw_overhead;
+		int local_bw_overhead, local_bw_bpp_x16;
 		int link_bpp_x16;
+		int ret;
 
 		drm_dbg_kms(display->drm, "Trying bpp " FXP_Q4_FMT "\n", FXP_Q4_ARGS(bpp_x16));
 
@@ -339,21 +379,36 @@ int intel_dp_mtp_tu_compute_config(struct intel_dp *intel_dp,
 			intel_dp_output_format_link_bpp_x16(crtc_state->output_format,
 							    fxp_q4_to_int(bpp_x16));
 
-		local_bw_overhead = intel_dp_mst_bw_overhead(crtc_state,
-							     false, dsc_slice_count, link_bpp_x16);
+		/*
+		 * With the symbol based timing generator the BW is calculated
+		 * from the effective bpp of the LL symbol timings, and the
+		 * candidate is rejected if these don't fit the timing generator.
+		 */
+		ret = intel_dp_mst_bw_params(intel_dp, crtc_state, false,
+					     dsc_slice_count, link_bpp_x16,
+					     &local_bw_bpp_x16, &local_bw_overhead);
+		if (ret) {
+			drm_dbg_kms(display->drm,
+				    "LL symbol timings don't fit with bpp " FXP_Q4_FMT "\n",
+				    FXP_Q4_ARGS(bpp_x16));
+			continue;
+		}
 
 		intel_dp_mst_compute_m_n(crtc_state,
 					 local_bw_overhead,
-					 link_bpp_x16,
+					 local_bw_bpp_x16,
 					 &crtc_state->dp_m_n);
 
 		if (is_mst) {
-			int remote_bw_overhead;
+			int remote_bw_overhead, remote_bw_bpp_x16;
 			int remote_tu;
 			fixed20_12 pbn;
 
-			remote_bw_overhead = intel_dp_mst_bw_overhead(crtc_state,
-								      true, dsc_slice_count, link_bpp_x16);
+			ret = intel_dp_mst_bw_params(intel_dp, crtc_state, true,
+						     dsc_slice_count, link_bpp_x16,
+						     &remote_bw_bpp_x16, &remote_bw_overhead);
+			if (drm_WARN_ON(display->drm, ret))
+				continue;
 
 			/*
 			 * The TU size programmed to the HW determines which slots in
@@ -370,7 +425,7 @@ int intel_dp_mtp_tu_compute_config(struct intel_dp *intel_dp,
 			 * enable SSC on the corresponding link.
 			 */
 			pbn.full = dfixed_const(intel_dp_mst_calc_pbn(adjusted_mode->crtc_clock,
-								      link_bpp_x16,
+								      remote_bw_bpp_x16,
 								      remote_bw_overhead));
 			remote_tu = DIV_ROUND_UP(pbn.full, mst_state->pbn_div.full);
 
@@ -1522,6 +1577,7 @@ mst_connector_mode_valid_ctx(struct drm_connector *_connector,
 	struct drm_dp_mst_topology_mgr *mgr = &intel_dp->mst.mgr;
 	struct drm_dp_mst_port *port = connector->mst.port;
 	int max_rate, mode_rate, max_lanes, max_link_clock;
+	int est_slice_count = 0;
 	unsigned long bw_overhead_flags =
 		DRM_DP_BW_OVERHEAD_MST | DRM_DP_BW_OVERHEAD_SSC_REF_CLK;
 	int min_link_bpp_x16 = fxp_q4_from_int(18);
@@ -1564,10 +1620,23 @@ mst_connector_mode_valid_ctx(struct drm_connector *_connector,
 
 	max_rate = intel_dp_max_link_data_rate(intel_dp,
 					       max_link_clock, max_lanes);
-	mode_rate = intel_dp_link_required(max_link_clock, max_lanes,
-					   mode->clock, mode->hdisplay,
-					   min_link_bpp_x16,
-					   bw_overhead_flags);
+	/*
+	 * The compressed stream's slice count depends on the joiner candidate,
+	 * use the one for a single pipe as an estimate in the compressed case.
+	 */
+	if (supports_dsc && connector->mst.port->passthrough_aux)
+		est_slice_count = intel_dp_dsc_get_slice_count(connector,
+							       mode->clock,
+							       mode->hdisplay, 1);
+
+	mode_rate = intel_dp_stream_link_required(intel_dp, true,
+						  max_link_clock, max_lanes,
+						  mode->clock, mode->hdisplay,
+						  mode->htotal,
+						  est_slice_count,
+						  INTEL_OUTPUT_FORMAT_RGB,
+						  min_link_bpp_x16,
+						  bw_overhead_flags);
 
 	/* The symbol based timing generator has no Link M/N ratio limit */
 	if (!intel_dp_use_symbol_tg(display, true, drm_dp_is_uhbr_rate(max_link_clock)) &&
@@ -1599,7 +1668,7 @@ mst_connector_mode_valid_ctx(struct drm_connector *_connector,
 	if (ret)
 		return ret;
 
-	if (mode_rate > max_rate ||
+	if (mode_rate < 0 || mode_rate > max_rate ||
 	    drm_dp_calc_pbn_mode(mode->clock, min_link_bpp_x16) > port->full_pbn) {
 		*status = MODE_CLOCK_HIGH;
 		return 0;
@@ -1624,9 +1693,10 @@ mst_connector_mode_valid_ctx(struct drm_connector *_connector,
 			if (!drm_dp_is_uhbr_rate(max_link_clock))
 				bw_overhead_flags |= DRM_DP_BW_OVERHEAD_FEC;
 
-			dsc = intel_dp_mode_valid_with_dsc(connector,
+			dsc = intel_dp_mode_valid_with_dsc(connector, true,
 							   max_link_clock, max_lanes,
 							   target_clock, mode->hdisplay,
+							   mode->htotal,
 							   num_joined_pipes,
 							   INTEL_OUTPUT_FORMAT_RGB, pipe_bpp,
 							   bw_overhead_flags);
@@ -1647,14 +1717,6 @@ mst_connector_mode_valid_ctx(struct drm_connector *_connector,
 		if (*status != MODE_OK)
 			continue;
 
-		if (!intel_dp_mode_valid_symbol_tg(connector, intel_dp, true, mode,
-						   max_link_clock, INTEL_OUTPUT_FORMAT_RGB,
-						   mode_rate <= max_rate,
-						   dsc ? dsc_slice_count : 0)) {
-			*status = MODE_H_ILLEGAL;
-			continue;
-		}
-
 		if (!dsc)
 			dsc_slice_count = 0;
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp_tunnel.c b/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
index 2199396345646a0c2cd7c8ec7ed07a38688ec94e..399e40c2da7f04d30962f1626e55c5f709a5306d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_tunnel.c
@@ -153,7 +153,7 @@ static int allocate_initial_tunnel_bw_for_pipes(struct intel_dp *intel_dp, u8 pi
 	for_each_intel_crtc_in_pipe_mask(display, crtc, pipe_mask) {
 		const struct intel_crtc_state *crtc_state =
 			to_intel_crtc_state(crtc->base.state);
-		int stream_bw = intel_dp_config_required_rate(crtc_state);
+		int stream_bw = intel_dp_config_required_rate(intel_dp, crtc_state);
 
 		tunnel_bw += stream_bw;
 
@@ -648,7 +648,7 @@ int intel_dp_tunnel_atomic_compute_stream_bw(struct intel_atomic_state *state,
 	struct intel_display *display = to_intel_display(state);
 	struct intel_encoder *encoder = &dp_to_dig_port(intel_dp)->base;
 	struct intel_crtc *crtc = to_intel_crtc(crtc_state->uapi.crtc);
-	int required_rate = intel_dp_config_required_rate(crtc_state);
+	int required_rate = intel_dp_config_required_rate(intel_dp, crtc_state);
 	int ret;
 
 	if (!intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))

-- 
2.25.1

