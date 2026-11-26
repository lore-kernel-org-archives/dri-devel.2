Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4797606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TsGq3XP/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D47112186;
	Thu, 26 Nov 2026 08:40:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06096112182;
 Thu, 26 Nov 2026 08:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795682438; x=1827218438;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=A1xsJqgjh0z97TTJZOMWc0IHI6vw8brbvgXW9J/GC10=;
 b=TsGq3XP/idReTXBpSwbyrQoNzEN/SUoYBWKLbW2vTfsL+Fv6HKizTqyr
 9rc8ZZzCbBVLNaZmpxie1B4fEt6Hu+NMmZXkgwQL5xuOvnftx+lE9ts9i
 yJEkZkfTWxr+2Y8e06Tt7z1ZmNknJBFdfHQ7wnkx6Bdx6l4nHNX1OURLo
 LSd3DC/kq0OfxDCGwrb3k0B49Y9dFK6fyhYJ2sg+qax1SCMO7nXxipS6l
 ev9sSCLOEMH3F1WHAGE4kylImANKXHC0y2iC0v+HGWZZLioEik6qLqtsH
 J72fk+cRN67sC44p5SZEvOANaXYzrvxkrOuuSEs6IyvsHcOOPUR5FINuZ w==;
X-CSE-ConnectionGUID: JEFCXlI/QFCpOQPd12vntg==
X-CSE-MsgGUID: C8rYQ+bVRSe/fFuBGl7DKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4488578"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4488578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:40:38 -0800
X-CSE-ConnectionGUID: APeBBJAKR661b6604avLgg==
X-CSE-MsgGUID: wWKLGuUhSum7pxnu/JvUog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12125734"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 26 Nov 2026 00:40:35 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Thu, 26 Nov 2026 14:05:05 +0530
Subject: [PATCH v6 10/13] drm/i915/dp: Prune the modes not fitting the DP
 symbol timing generator
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vlk-64036-dp-symbol-tg-v6-10-835a4f5c0a12@intel.com>
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

The LL symbol timings of a mode have to fit the TRANS_LLSYM_HTOTAL and
TRANS_LLSYM_CHUNK_SIZE registers when the symbol based timing generator
is used. Instead of accepting such modes and silently falling back to the
pixel based timing generator, reject them in the mode validation, the
same as for the transcoder timing limits.

Factor out the LL symbol cycle count computation, to be used both by the
mode validation and by the computation of the timing generator
parameters. The mode validation uses the minimum link bpp, as a mode not
fitting with that doesn't fit with any other bpp either.

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c     | 173 +++++++++++++++++++++-------
 drivers/gpu/drm/i915/display/intel_dp.h     |   7 ++
 drivers/gpu/drm/i915/display/intel_dp_mst.c |   8 ++
 3 files changed, 149 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index e59737c8e22ed11a6af86ac58eac02f5e11d884f..82966028b2a2867889169ca372d8d36b576d9119 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -1540,6 +1540,14 @@ intel_dp_mode_valid_format(struct intel_connector *connector,
 		if (status != MODE_OK)
 			continue;
 
+		if (!intel_dp_mode_valid_symbol_tg(connector, intel_dp, false, mode,
+						   max_link_clock, output_format,
+						   mode_rate <= max_rate,
+						   dsc ? dsc_slice_count : 0)) {
+			status = MODE_H_ILLEGAL;
+			continue;
+		}
+
 		if (!dsc)
 			dsc_slice_count = 0;
 
@@ -3762,6 +3770,88 @@ int intel_dp_compute_min_hblank(struct intel_crtc_state *crtc_state,
 /* Number of symbols the transcoder link layer processes in a symbol cycle */
 #define LL_SYMBOLS_PER_CYCLE	4
 
+struct intel_dp_symbol_tg_cycles {
+	int hactive;
+	int hblank;
+	int chunk;
+};
+
+/* dsc_slices is 0 for an uncompressed stream */
+static void intel_dp_symbol_tg_calc_cycles(struct intel_dp *intel_dp,
+					   int hdisplay, int htotal,
+					   int link_bpp_x16, int dsc_slices,
+					   enum intel_output_format output_format,
+					   bool is_uhbr,
+					   struct intel_dp_symbol_tg_cycles *cycles)
+{
+	int symbol_size = is_uhbr ? 32 : 8;
+	u8 rx_min_hblank;
+	int hblank_pixels;
+
+	cycles->chunk = 0;
+
+	if (dsc_slices) {
+		int slice_width = DIV_ROUND_UP(hdisplay, dsc_slices);
+		int chunk_bytes = DIV_ROUND_UP(slice_width * link_bpp_x16, 16 * 8);
+
+		cycles->chunk = DIV_ROUND_UP(chunk_bytes * 8,
+					     LL_SYMBOLS_PER_CYCLE * symbol_size);
+		cycles->hactive = dsc_slices * (cycles->chunk + 1);
+	} else {
+		int hact_width = hdisplay;
+		int pix_bpp_x16 = link_bpp_x16;
+
+		/* YUV 4:2:0 without DSC: half the Hactive at twice the bpp */
+		if (output_format == INTEL_OUTPUT_FORMAT_YCBCR420) {
+			hact_width /= 2;
+			pix_bpp_x16 *= 2;
+		}
+
+		cycles->hactive = DIV_ROUND_UP(DIV_ROUND_UP(hact_width, LL_SYMBOLS_PER_CYCLE) *
+					       pix_bpp_x16, 16 * symbol_size);
+	}
+
+	hblank_pixels = htotal - hdisplay;
+	cycles->hblank = DIV_ROUND_UP(DIV_ROUND_UP(hblank_pixels, LL_SYMBOLS_PER_CYCLE) *
+				      link_bpp_x16, 16 * symbol_size);
+
+	/* DP 2.1: the minimum Hblank is 5 LL symbol cycles for 8b/10b, 3 for 128b/132b */
+	cycles->hblank = max(cycles->hblank, is_uhbr ? 3 : 5);
+
+	/* The Rx minimum Hblank, if the sink enumerates it */
+	rx_min_hblank = intel_dp->rx_min_hblank[is_uhbr];
+	if (rx_min_hblank & DP_RX_MIN_HBLANK_ENABLE)
+		cycles->hblank = max(cycles->hblank,
+				     (rx_min_hblank & DP_RX_MIN_HBLANK_MASK) +
+				     (is_uhbr ? 3 : 5));
+}
+
+static bool intel_dp_symbol_tg_cycles_in_range(const struct intel_dp_symbol_tg_cycles *cycles)
+{
+	return cycles->hactive + cycles->hblank <= TRANS_LLSYM_HTOTAL_MASK + 1 &&
+		cycles->chunk <= TRANS_LLSYM_CHUNK_SIZE_MASK;
+}
+
+/*
+ * Check if the LL symbol timings of a mode fit the symbol based timing
+ * generator registers, for the given link rate and link bpp. The lower the
+ * bpp, the fewer cycles, so this can be called with the minimum bpp to prune
+ * the modes which can't be supported with any bpp.
+ */
+static bool intel_dp_symbol_tg_mode_valid(struct intel_dp *intel_dp,
+					  const struct drm_display_mode *mode,
+					  int link_rate, int link_bpp_x16, int dsc_slices,
+					  enum intel_output_format output_format)
+{
+	struct intel_dp_symbol_tg_cycles cycles;
+
+	intel_dp_symbol_tg_calc_cycles(intel_dp, mode->hdisplay, mode->htotal,
+				       link_bpp_x16, dsc_slices, output_format,
+				       drm_dp_is_uhbr_rate(link_rate), &cycles);
+
+	return intel_dp_symbol_tg_cycles_in_range(&cycles);
+}
+
 /* 64 x 64 -> 128 bit multiplication, result as {lo, hi} */
 static void intel_dp_mul_u64_u64(u64 a, u64 b, u64 res[2])
 {
@@ -3808,6 +3898,40 @@ void intel_dp_symbol_tg_select_mn(struct intel_crtc_state *crtc_state)
 								      &crtc_state->dpll_hw_state));
 }
 
+/*
+ * Check if the LL symbol timings of a mode can be supported by the symbol
+ * based timing generator, if that is used for the given link, either with an
+ * uncompressed stream (if @uncompressed_ok) or with DSC (if @dsc_slice_count
+ * is not 0), at the minimum link bpp.
+ */
+bool intel_dp_mode_valid_symbol_tg(struct intel_connector *connector,
+				   struct intel_dp *intel_dp, bool is_mst,
+				   const struct drm_display_mode *mode,
+				   int link_rate,
+				   enum intel_output_format output_format,
+				   bool uncompressed_ok, int dsc_slice_count)
+{
+	struct intel_display *display = to_intel_display(connector);
+	int min_bpp_x16, min_compressed_bpp_x16;
+
+	if (!intel_dp_use_symbol_tg(display, is_mst, drm_dp_is_uhbr_rate(link_rate)))
+		return true;
+
+	min_bpp_x16 = intel_dp_mode_min_link_bpp_x16(connector, mode, output_format);
+	if (uncompressed_ok &&
+	    intel_dp_symbol_tg_mode_valid(intel_dp, mode, link_rate,
+					  min_bpp_x16, 0, output_format))
+		return true;
+
+	min_compressed_bpp_x16 = intel_dp_compute_min_compressed_bpp_x16(connector,
+									 output_format);
+
+	return dsc_slice_count &&
+		intel_dp_symbol_tg_mode_valid(intel_dp, mode, link_rate,
+					      min_compressed_bpp_x16,
+					      dsc_slice_count, output_format);
+}
+
 /* Compute the DP link layer (LL) symbol based timing generator parameters */
 int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state,
@@ -3820,9 +3944,8 @@ int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 	struct intel_dp_symbol_tg *tg = &crtc_state->dp_symbol_tg;
 	bool is_uhbr = intel_dp_is_uhbr(crtc_state);
 	int symbol_size = is_uhbr ? 32 : 8;
-	int hactive_cycles, hblank_cycles, chunk_cycles = 0;
-	int hblank_pixels;
-	u8 rx_min_hblank;
+	struct intel_dp_symbol_tg_cycles cycles;
+	int hactive_cycles, hblank_cycles, chunk_cycles;
 	int dsc_slices, link_bpp_x16;
 	u32 ch_num, ch_den, ssc_num, ssc_den, spread_x1000, link_rate_mbps;
 	u32 rate_gcd, ssc_gcd;
@@ -3847,43 +3970,15 @@ int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 	if (ret)
 		return ret;
 
-	if (crtc_state->dsc.compression_enable) {
-		int slice_width = DIV_ROUND_UP(adjusted_mode->crtc_hdisplay, dsc_slices);
-		int chunk_bytes = DIV_ROUND_UP(slice_width * link_bpp_x16, 16 * 8);
-
-		chunk_cycles = DIV_ROUND_UP(chunk_bytes * 8,
-					    LL_SYMBOLS_PER_CYCLE * symbol_size);
-		hactive_cycles = dsc_slices * (chunk_cycles + 1);
-	} else {
-		int hact_width = adjusted_mode->crtc_hdisplay;
-		int pix_bpp_x16 = link_bpp_x16;
-
-		/* YUV 4:2:0 without DSC: half the Hactive at twice the bpp */
-		if (crtc_state->output_format == INTEL_OUTPUT_FORMAT_YCBCR420) {
-			hact_width /= 2;
-			pix_bpp_x16 *= 2;
-		}
-
-		hactive_cycles = DIV_ROUND_UP(DIV_ROUND_UP(hact_width, LL_SYMBOLS_PER_CYCLE) *
-					      pix_bpp_x16, 16 * symbol_size);
-	}
-
-	hblank_pixels = adjusted_mode->crtc_htotal - adjusted_mode->crtc_hdisplay;
-	hblank_cycles = DIV_ROUND_UP(DIV_ROUND_UP(hblank_pixels, LL_SYMBOLS_PER_CYCLE) *
-				     link_bpp_x16, 16 * symbol_size);
-
-	/* DP 2.1: the minimum Hblank is 5 LL symbol cycles for 8b/10b, 3 for 128b/132b */
-	hblank_cycles = max(hblank_cycles, is_uhbr ? 3 : 5);
-
-	/* The Rx minimum Hblank, if the sink enumerates it */
-	rx_min_hblank = intel_dp->rx_min_hblank[is_uhbr];
-	if (rx_min_hblank & DP_RX_MIN_HBLANK_ENABLE)
-		hblank_cycles = max(hblank_cycles,
-				    (rx_min_hblank & DP_RX_MIN_HBLANK_MASK) +
-				    (is_uhbr ? 3 : 5));
+	intel_dp_symbol_tg_calc_cycles(intel_dp, adjusted_mode->crtc_hdisplay,
+				       adjusted_mode->crtc_htotal, link_bpp_x16,
+				       dsc_slices, crtc_state->output_format,
+				       is_uhbr, &cycles);
+	hactive_cycles = cycles.hactive;
+	hblank_cycles = cycles.hblank;
+	chunk_cycles = cycles.chunk;
 
-	if (hactive_cycles + hblank_cycles > TRANS_LLSYM_HTOTAL_MASK + 1 ||
-	    chunk_cycles > TRANS_LLSYM_CHUNK_SIZE_MASK) {
+	if (!intel_dp_symbol_tg_cycles_in_range(&cycles)) {
 		drm_dbg_kms(display->drm,
 			    "LL symbol timings out of range (hactive %d, hblank %d, chunk %d), using pixel TG\n",
 			    hactive_cycles, hblank_cycles, chunk_cycles);
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index 064ea36d100e09cd822e5be558eee7496f17943c..db65912047332bd788adc0fdd9401e06cf5acfa8 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -16,6 +16,7 @@ enum port;
 struct drm_connector_state;
 struct drm_dp_desc;
 struct drm_dp_vsc_sdp;
+struct drm_display_mode;
 struct drm_encoder;
 struct drm_modeset_acquire_ctx;
 struct intel_atomic_state;
@@ -216,6 +217,12 @@ int intel_dp_dsc_min_src_compressed_bpp(void);
 int intel_dp_compute_min_hblank(struct intel_crtc_state *crtc_state,
 				const struct drm_connector_state *conn_state);
 bool intel_dp_use_symbol_tg(struct intel_display *display, bool is_mst, bool is_uhbr);
+bool intel_dp_mode_valid_symbol_tg(struct intel_connector *connector,
+				   struct intel_dp *intel_dp, bool is_mst,
+				   const struct drm_display_mode *mode,
+				   int link_rate,
+				   enum intel_output_format output_format,
+				   bool uncompressed_ok, int dsc_slice_count);
 void intel_dp_symbol_tg_select_mn(struct intel_crtc_state *crtc_state);
 int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 58ca5312c195e2428b0356da090d540bfb8012ce..ed615ee2f51ec08bb8d7f2e729f95edcf83de5b1 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -1647,6 +1647,14 @@ mst_connector_mode_valid_ctx(struct drm_connector *_connector,
 		if (*status != MODE_OK)
 			continue;
 
+		if (!intel_dp_mode_valid_symbol_tg(connector, intel_dp, true, mode,
+						   max_link_clock, INTEL_OUTPUT_FORMAT_RGB,
+						   mode_rate <= max_rate,
+						   dsc ? dsc_slice_count : 0)) {
+			*status = MODE_H_ILLEGAL;
+			continue;
+		}
+
 		if (!dsc)
 			dsc_slice_count = 0;
 

-- 
2.25.1

