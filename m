Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A57606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=d+e6kZMd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5D2A112171;
	Thu, 26 Nov 2026 08:40:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B82D10E329;
 Thu, 26 Nov 2026 08:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795682428; x=1827218428;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=psOGtnya0nJt7NYa4Dqv6bnwwxLNFZ3Na0OgWY/Jc08=;
 b=d+e6kZMdOYuCTRYHv5m9LpVpl60lQhaWWev4Jg11C/Xu/XukUPYAUaDy
 TyUazdY+bMmmNMY4MnLuD7fpLbwBpHV5+pP61kdBe/oWOhZYBHub84xR5
 42vhKaxtGMaqNoe+tWLblRX/1vmAyVhbu8D7w+1qmZw4SXucohdrlLg0N
 JDKwjDLJ5EyoI27A0Hu9Q8WzVAQb+YkjOleo1HLRENbeEkBSeVcOBDl0K
 exE9CvCdKKjndCZRNpadoEOoqSKxJ+cbZQNbwgjybyeJHaKl120Zee4xe
 1yio1BgLgqThrPPeE/mV+W4as0O/aHciZDCCrZjOPVRzrbLy2JfTEXqb6 g==;
X-CSE-ConnectionGUID: Zg+enGHSSpCklqLZoyW+/w==
X-CSE-MsgGUID: xTLsX/aKTRqkcnZ3zjKiSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4488544"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4488544"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:40:28 -0800
X-CSE-ConnectionGUID: wMLSjK+TS2ODx5kwbY9ltw==
X-CSE-MsgGUID: uPAfGqWqQjSUXcJoy3aBlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12125699"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 26 Nov 2026 00:40:25 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Thu, 26 Nov 2026 14:05:01 +0530
Subject: [PATCH v6 06/13] drm/i915/dp: Compute the DP symbol based timing
 generator parameters
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vlk-64036-dp-symbol-tg-v6-6-835a4f5c0a12@intel.com>
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

Xe3p has a DP link layer (LL) symbol based timing generator, which
makes the per-line symbol insertion for 8b/10b MST and 128b/132b
SST/MST compliant with the DP 2.1 hblank symbol cycle count, reducing
the line-to-line hblank jitter that some sinks can't handle.

The Data M/N registers are 128 bits wide, so the Data M/N is computed as
128 bit values, without reducing them apart from the GCDs of the pixel
clock/link rate and of the SSC efficiency, to keep the full precision.

Modes whose LL symbol timings don't fit the hardware are pruned in mode
validation, there is no fallback to the pixel based timing generator. The
Min Hblank mechanism must not be used together with the symbol timing
generator, so compute the timing generator parameters first and skip the
Min Hblank computation when it is used.

v3: Move crtc parameters, checker and dump to new patch (Suraj)
v4: dpcd caps bases ssc capability => intel_panel_use_ssc (Suraj)
    Use gcd() from linux/gcd.h
v5: Replace the MSO/eDP splitter check with a drm_WARN_ON(), MSO is
    only used with 8b/10b SST.
    Use crtc_hdisplay/crtc_htotal to match crtc_clock
    Take the Rx minimum Hblank (DPCD 0221Ah/0221Bh) into account
    Compute the Data M/N for both the SSC disabled and enabled case, as
    the PLL used (TBT PLL: no SSC) is only known later
    Skip computing min_hblank if the symbol TG is used, instead of
    clearing it (Chaitanya)

Bspec: 68922
Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_types.h |   2 +
 drivers/gpu/drm/i915/display/intel_dp.c            | 226 +++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.h            |   3 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |   5 +
 4 files changed, 236 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index ee4152afb86dbe1ad041d4d99c058bdb97932350..62143b9f87ff5fca2c69173354b83e93589cff9a 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1889,6 +1889,8 @@ struct intel_dp {
 	u8 lttpr_common_caps[DP_LTTPR_COMMON_CAP_SIZE];
 	u8 lttpr_phy_caps[DP_MAX_LTTPR_COUNT][DP_LTTPR_PHY_CAP_SIZE];
 	u8 pcon_dsc_dpcd[DP_PCON_DSC_ENCODER_CAP_SIZE];
+	/* Rx minimum Hblank, DP_RX_MIN_HBLANK_{8B10B,128B132B} */
+	u8 rx_min_hblank[2];
 	/* source rates */
 	int num_source_rates;
 	const int *source_rates;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index db7c8fcc8683aae1a2bc7050ef7c87ed5155c8dc..196388800326803fd5b8544af498b0546a1661db 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -26,6 +26,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/gcd.h>
 #include <linux/i2c.h>
 #include <linux/iopoll.h>
 #include <linux/log2.h>
@@ -1269,6 +1270,16 @@ bool intel_dp_has_dsc(const struct intel_connector *connector)
 	return true;
 }
 
+/*
+ * The symbol based timing generator is to be used for 8b/10b MST and 128b/132b
+ * SST/MST, but only once all the pieces needed for that are in place, which is
+ * done by a later patch.
+ */
+static bool intel_dp_use_symbol_tg(struct intel_display *display, bool is_mst, bool is_uhbr)
+{
+	return false;
+}
+
 static int
 intel_dp_get_max_m_n_ratio(struct intel_display *display)
 {
@@ -3681,6 +3692,10 @@ int intel_dp_compute_min_hblank(struct intel_crtc_state *crtc_state,
 	if (DISPLAY_VER(display) < 30)
 		return 0;
 
+	/* The Min Hblank mechanism must not be used with the symbol based timing generator */
+	if (crtc_state->dp_symbol_tg.enable)
+		return 0;
+
 	/* MIN_HBLANK should be set only for 8b/10b MST or for 128b/132b SST/MST */
 	if (!is_mst && !intel_dp_is_uhbr(crtc_state))
 		return 0;
@@ -3734,6 +3749,197 @@ int intel_dp_compute_min_hblank(struct intel_crtc_state *crtc_state,
 	return 0;
 }
 
+/* Number of symbols the transcoder link layer processes in a symbol cycle */
+#define LL_SYMBOLS_PER_CYCLE	4
+
+/* 64 x 64 -> 128 bit multiplication, result as {lo, hi} */
+static void intel_dp_mul_u64_u64(u64 a, u64 b, u64 res[2])
+{
+	res[0] = a * b;
+	res[1] = mul_u64_u64_shr(a, b, 64);
+}
+
+/* Compare two {lo, hi} 128 bit values */
+static int intel_dp_cmp_u128(const u64 a[2], const u64 b[2])
+{
+	if (a[1] != b[1])
+		return a[1] > b[1] ? 1 : -1;
+
+	if (a[0] != b[0])
+		return a[0] > b[0] ? 1 : -1;
+
+	return 0;
+}
+
+/* Set the active Data M/N from the SSC disabled (0) / enabled (1) variant */
+static void intel_dp_symbol_tg_set_mn(struct intel_dp_symbol_tg *tg, bool ssc_enabled)
+{
+	const struct intel_dp_symbol_tg_mn *mn = &tg->mn[ssc_enabled];
+
+	tg->data_m[0] = mn->data_m[0];
+	tg->data_m[1] = mn->data_m[1];
+	tg->data_n[0] = mn->data_n[0];
+	tg->data_n[1] = mn->data_n[1];
+}
+
+/* Compute the DP link layer (LL) symbol based timing generator parameters */
+int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
+			       struct intel_crtc_state *crtc_state,
+			       const struct drm_connector_state *conn_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	const struct drm_display_mode *adjusted_mode =
+					&crtc_state->hw.adjusted_mode;
+	struct intel_connector *connector = to_intel_connector(conn_state->connector);
+	struct intel_dp_symbol_tg *tg = &crtc_state->dp_symbol_tg;
+	bool is_uhbr = intel_dp_is_uhbr(crtc_state);
+	int symbol_size = is_uhbr ? 32 : 8;
+	int hactive_cycles, hblank_cycles, chunk_cycles = 0;
+	int hblank_pixels;
+	u8 rx_min_hblank;
+	int dsc_slices, link_bpp_x16;
+	u32 ch_num, ch_den, ssc_num, ssc_den, spread_x1000, link_rate_mbps;
+	u32 rate_gcd, ssc_gcd;
+	u64 data_m[2][2], data_n[2][2];
+	bool ssc_allowed;
+	int ssc, ret;
+
+	memset(tg, 0, sizeof(*tg));
+
+	/* The symbol based timing generator is used for 8b/10b MST and 128b/132b SST/MST */
+	if (!intel_dp_use_symbol_tg(display,
+				    intel_crtc_has_type(crtc_state, INTEL_OUTPUT_DP_MST),
+				    is_uhbr))
+		return 0;
+
+	/* MSO is only used with 8b/10b SST, where the symbol TG isn't used */
+	if (drm_WARN_ON(display->drm, crtc_state->splitter.enable))
+		return 0;
+
+	ret = intel_dp_compute_dsc_slices_and_link_bpp(crtc_state, connector,
+						       &dsc_slices, &link_bpp_x16);
+	if (ret)
+		return ret;
+
+	if (crtc_state->dsc.compression_enable) {
+		int slice_width = DIV_ROUND_UP(adjusted_mode->crtc_hdisplay, dsc_slices);
+		int chunk_bytes = DIV_ROUND_UP(slice_width * link_bpp_x16, 16 * 8);
+
+		chunk_cycles = DIV_ROUND_UP(chunk_bytes * 8,
+					    LL_SYMBOLS_PER_CYCLE * symbol_size);
+		hactive_cycles = dsc_slices * (chunk_cycles + 1);
+	} else {
+		int hact_width = adjusted_mode->crtc_hdisplay;
+		int pix_bpp_x16 = link_bpp_x16;
+
+		/* YUV 4:2:0 without DSC: half the Hactive at twice the bpp */
+		if (crtc_state->output_format == INTEL_OUTPUT_FORMAT_YCBCR420) {
+			hact_width /= 2;
+			pix_bpp_x16 *= 2;
+		}
+
+		hactive_cycles = DIV_ROUND_UP(DIV_ROUND_UP(hact_width, LL_SYMBOLS_PER_CYCLE) *
+					      pix_bpp_x16, 16 * symbol_size);
+	}
+
+	hblank_pixels = adjusted_mode->crtc_htotal - adjusted_mode->crtc_hdisplay;
+	hblank_cycles = DIV_ROUND_UP(DIV_ROUND_UP(hblank_pixels, LL_SYMBOLS_PER_CYCLE) *
+				     link_bpp_x16, 16 * symbol_size);
+
+	/* DP 2.1: the minimum Hblank is 5 LL symbol cycles for 8b/10b, 3 for 128b/132b */
+	hblank_cycles = max(hblank_cycles, is_uhbr ? 3 : 5);
+
+	/* The Rx minimum Hblank, if the sink enumerates it */
+	rx_min_hblank = intel_dp->rx_min_hblank[is_uhbr];
+	if (rx_min_hblank & DP_RX_MIN_HBLANK_ENABLE)
+		hblank_cycles = max(hblank_cycles,
+				    (rx_min_hblank & DP_RX_MIN_HBLANK_MASK) +
+				    (is_uhbr ? 3 : 5));
+
+	if (hactive_cycles + hblank_cycles > TRANS_LLSYM_HTOTAL_MASK + 1 ||
+	    chunk_cycles > TRANS_LLSYM_CHUNK_SIZE_MASK) {
+		drm_dbg_kms(display->drm,
+			    "LL symbol timings out of range (hactive %d, hblank %d, chunk %d), using pixel TG\n",
+			    hactive_cycles, hblank_cycles, chunk_cycles);
+		return 0;
+	}
+
+	if (is_uhbr) {
+		ch_num = 1568768;
+		ch_den = 1622115;
+	} else if (crtc_state->fec_enable) {
+		ch_num = 51200;
+		ch_den = 65537;
+	} else {
+		ch_num = 8;
+		ch_den = 10;
+	}
+
+	/*
+	 * spread_x1000 is the spread in % multiplied by 1000, so 500 means 0.5%.
+	 * ssc_den * spread_x1000 / (200 * 1000) is ssc_den * (Spread_Amount / 200).
+	 *
+	 * With 0.5% spread: 100000 * 500 / 200000 = 250, so ssc_num = 99750.
+	 * The efficiency is 99750 / 100000 = 0.9975, which equals 1 - 0.5 / 200.
+	 * With no SSC the spread is 0, so ssc_num = ssc_den and the efficiency
+	 * is 1.
+	 *
+	 * SSC is used only if both the panel/VBT policy and the sink allow it,
+	 * same as for the PHY PLL programming. The PLL that will be used, and
+	 * with that if SSC is enabled, is only known when the PLLs are computed,
+	 * and for Type-C ports at the time of enabling the port, as the TBT PLL
+	 * is used without SSC. So compute the Data M/N for both the SSC enabled
+	 * and the SSC disabled case, intel_dp_symbol_tg_select_mn() selects the
+	 * one matching the PLL.
+	 */
+	ssc_den = 100000;
+	ssc_allowed = intel_panel_use_ssc(display) &&
+		      intel_dp->dpcd[DP_MAX_DOWNSPREAD] & DP_MAX_DOWNSPREAD_0_5;
+
+	/* The link rate in Mbps, port_clock is in 10 kbps units */
+	link_rate_mbps = crtc_state->port_clock / 100;
+
+	rate_gcd = gcd(adjusted_mode->crtc_clock, link_rate_mbps);
+
+	for (ssc = 0; ssc < 2; ssc++) {
+		spread_x1000 = ssc && ssc_allowed ? 500 : 0;
+		ssc_num = ssc_den - DIV_ROUND_CLOSEST(ssc_den * spread_x1000, 200 * 1000);
+		ssc_gcd = gcd(ssc_num, ssc_den);
+
+		intel_dp_mul_u64_u64((u64)(adjusted_mode->crtc_clock / rate_gcd) *
+				     LL_SYMBOLS_PER_CYCLE * symbol_size * ch_den,
+				     (u64)(hactive_cycles + hblank_cycles) * (ssc_den / ssc_gcd),
+				     data_m[ssc]);
+		intel_dp_mul_u64_u64((u64)(link_rate_mbps / rate_gcd) * crtc_state->lane_count *
+				     adjusted_mode->crtc_htotal * 1000,
+				     (u64)ch_num * (ssc_num / ssc_gcd),
+				     data_n[ssc]);
+
+		if (intel_dp_cmp_u128(data_m[ssc], data_n[ssc]) > 0) {
+			drm_dbg_kms(display->drm,
+				    "LL symbol data M/N ratio exceeds 1.0 (SSC %s), using pixel TG\n",
+				    str_enabled_disabled(ssc));
+			return 0;
+		}
+	}
+
+	tg->enable = true;
+	tg->hactive = hactive_cycles;
+	tg->htotal = hactive_cycles + hblank_cycles;
+	tg->chunk_size = chunk_cycles;
+	for (ssc = 0; ssc < 2; ssc++) {
+		tg->mn[ssc].data_m[0] = data_m[ssc][0];
+		tg->mn[ssc].data_m[1] = data_m[ssc][1];
+		tg->mn[ssc].data_n[0] = data_n[ssc][0];
+		tg->mn[ssc].data_n[1] = data_n[ssc][1];
+	}
+
+	/* The PLL is not known yet, select the same as without the PLL awareness */
+	intel_dp_symbol_tg_set_mn(tg, ssc_allowed);
+
+	return 0;
+}
+
 int
 intel_dp_compute_config(struct intel_atomic_state *state,
 			struct intel_encoder *encoder,
@@ -3830,6 +4036,10 @@ intel_dp_compute_config(struct intel_atomic_state *state,
 		intel_dp_check_m_n_ratio(pipe_config, &pipe_config->dp_m_n);
 	}
 
+	ret = intel_dp_compute_symbol_tg(intel_dp, pipe_config, conn_state);
+	if (ret)
+		return ret;
+
 	ret = intel_dp_compute_min_hblank(pipe_config, conn_state);
 	if (ret)
 		return ret;
@@ -4676,6 +4886,18 @@ static u8 intel_dp_read_dprx_feature_enum(struct intel_dp *intel_dp)
 	return dprx;
 }
 
+static void intel_dp_read_rx_min_hblank(struct intel_dp *intel_dp)
+{
+	/* 8b/10b, 128b/132b */
+	intel_dp->rx_min_hblank[0] = 0;
+	intel_dp->rx_min_hblank[1] = 0;
+
+	drm_dp_dpcd_read_byte(&intel_dp->aux, DP_RX_MIN_HBLANK_8B10B,
+			      &intel_dp->rx_min_hblank[0]);
+	drm_dp_dpcd_read_byte(&intel_dp->aux, DP_RX_MIN_HBLANK_128B132B,
+			      &intel_dp->rx_min_hblank[1]);
+}
+
 static bool intel_dp_get_colorimetry_status(u8 dprx)
 {
 	return dprx & DP_VSC_SDP_EXT_FOR_COLORIMETRY_SUPPORTED;
@@ -5049,6 +5271,8 @@ intel_edp_init_dpcd(struct intel_dp *intel_dp, struct intel_connector *connector
 	intel_dp->sst_split_sdp_support =
 		intel_dp_get_sst_split_sdp_status(dprx);
 
+	intel_dp_read_rx_min_hblank(intel_dp);
+
 	/*
 	 * Read the eDP display control registers.
 	 *
@@ -5153,6 +5377,8 @@ intel_dp_get_dpcd(struct intel_dp *intel_dp)
 		intel_dp->sst_split_sdp_support =
 			intel_dp_get_sst_split_sdp_status(dprx);
 
+		intel_dp_read_rx_min_hblank(intel_dp);
+
 		intel_dp_update_sink_caps(intel_dp);
 	}
 
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index 1f4a3aff9abebdb2bf8cd17a77231e5af66f47ac..352c656299e3b2d81e0612a71da6247d02b5aa17 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -215,6 +215,9 @@ int intel_dp_dsc_min_src_input_bpc(void);
 int intel_dp_dsc_min_src_compressed_bpp(void);
 int intel_dp_compute_min_hblank(struct intel_crtc_state *crtc_state,
 				const struct drm_connector_state *conn_state);
+int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
+			       struct intel_crtc_state *crtc_state,
+			       const struct drm_connector_state *conn_state);
 
 int intel_dp_dsc_bpp_step_x16(const struct intel_connector *connector);
 void intel_dp_dpcd_set_probe(struct intel_dp *intel_dp, bool force_on_external);
diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/drm/i915/display/intel_dp_mst.c
index 1e6190689e6b2616ed850d61c5bfbf60a62c5422..e8864477ee1fa3ad8313b90dc0f03332a2f77c2d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c
@@ -728,6 +728,11 @@ static int mst_stream_compute_link_for_joined_pipes(struct intel_encoder *encode
 			return -EINVAL;
 	}
 
+	ret = intel_dp_compute_symbol_tg(connector->mst.dp,
+					 pipe_config, conn_state);
+	if (ret)
+		return ret;
+
 	ret = intel_dp_compute_min_hblank(pipe_config, conn_state);
 	if (ret)
 		return ret;

-- 
2.25.1

