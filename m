Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38EDC2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB43010F3D5;
	Fri,  7 Aug 2026 04:32:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ri2KauGL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DF4010F3CD;
 Fri,  7 Aug 2026 04:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077172; x=1817613172;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=dzm36Mv1E+Ns/kyGhMa+EIXtAHpjcHzqpFOFZUh/83U=;
 b=Ri2KauGLB0DoRP21NkYBkaPRAQkEZoNLv18WbpFW0GOsO2WX1tClxM+p
 x8CteS7IXBPuZwXlzyqC91rIJgKxN7ZUUkX6v9D2n19zPPkBuWfPkZ8Nf
 syhKP/HF7nrQX0QOm/g33idJ+fPOBwe0LuCYgpHxmotQus/OqrheuYq5k
 vuAJd+UAyh+cquy40aMGOLPLI9yGJo7u8saWzNcZ5TmSce+YiHzopusPX
 pnTk9I8uYjozYk4CETTU3N6kQW6q9C7DLrYPqGfdXyKSl2J+y3F7VUwxY
 1UshvQE5lb45aK/sC+EoyQ/52KLlr5TP+ovf6NOCEZ5H7nYkate9Jlw7L A==;
X-CSE-ConnectionGUID: b+AY2TdoTaiuH6bMGXzbUw==
X-CSE-MsgGUID: d6Bo6xbrTUe7KN6k3AVACg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619366"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619366"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:52 -0700
X-CSE-ConnectionGUID: T3AnImneTH+jEOKzhBAzWA==
X-CSE-MsgGUID: 2cXJyrvyTryoO3A+8j9gnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666505"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:49 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 33/44] drm/i915/hdmi_frl_dfm: Add support for DFM calculation
 with DSC
Date: Fri,  7 Aug 2026 09:44:18 +0530
Message-ID: <20260807041430.229038-34-ankit.k.nautiyal@intel.com>
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

Add helper functions for calculating FRL capacity and DFM
requirements with given compressed bpp.

v2: Fix misc issues seen while testing (Mitul)
- Utilization reuirement for DSC should return true

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
---
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.c | 289 ++++++++++++++++++
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.h |   3 +
 2 files changed, 292 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
index 2de9d3dd23ae..56ade6009983 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
@@ -413,3 +413,292 @@ intel_hdmi_frl_dfm_nondsc_requirement_met(struct intel_hdmi_frl_dfm *frl_dfm)
 
 	return false;
 }
+
+/* Get required no. of tribytes (estimate1) during HCBlank */
+static u32
+get_frl_hcblank_tb_est1_target(u32 hcactive_target_tb,
+			       u32 hactive, u32 hblank)
+{
+	return DIV_ROUND_UP(hcactive_target_tb * hblank, hactive);
+}
+
+/* Get required no. of tribytes during HCBlank */
+static u32
+get_frl_hcblank_tb_target(u32 hcactive_target_tb, u32 hactive,
+			  u32 hblank, u32 hcblank_audio_min,
+			  u32 cfrl_available)
+{
+	u32 hcblank_target_tb1 = get_frl_hcblank_tb_est1_target(hcactive_target_tb,
+									 hactive, hblank);
+	u32 hcblank_target_tb2 = max(hcblank_target_tb1, hcblank_audio_min);
+
+	return 4 * (min(hcblank_target_tb2,
+			(2 * cfrl_available - 3 * hcactive_target_tb) / 2) / 4);
+}
+
+static u32
+get_dsc_tribyte_time(u32 num_tribyte,
+		     u32 tribyte_rate_k)
+{
+	u32 tribyte_time, time_multiplier;
+
+	/*
+	 * tribyte_rate_k is the num of kilo tribytes in 1 sec, on an average.
+	 *
+	 * time taken for:
+	 * (tribyte_rate_k * 1000) tribytes -> 1 sec
+	 * (tribyte_rate_k * 1000) tribytes -> 10^9 nsec
+	 * 1000 tribytes                    -> (10^9 / tribyte_rate_k) nsec
+	 * 1 tribyte                        -> 10^9 / tribyte_rate_k * 1000)
+	 * 1 tribyte                        -> 10^6 / tribyte_rate_k
+	 * tribyte_time			    -> num_tribyte * 10 ^ 6 / (tribyte_rate_k)
+	 *
+	 * So, avg time for tribyte_time in nsec =
+	 *				num_tribyte * 10 ^ 6 / (tribyte_rate_k)
+	 */
+	time_multiplier = DIV_ROUND_UP(FRL_TIMING_NS_MULTIPLIER, 1000);
+	tribyte_time = num_tribyte * time_multiplier;
+
+	return DIV_ROUND_UP(tribyte_time, tribyte_rate_k);
+}
+
+/* Get time to send all tribytes in hcactive region in nsec*/
+static u32
+get_dsc_tactive_target_ns(u32 frl_lanes, u32 hcactive_target_tb,
+			  u32 ftb_avg_k, u32 min_frl_char_rate_k,
+			  u32 overhead_max)
+{
+	u32 avg_tribyte_time_ns, tribyte_time_ns;
+	u32 num_chars_hcactive;
+	u32 frl_char_rate_k;
+
+	/* Avg time to transmit all active region tribytes */
+	avg_tribyte_time_ns = get_dsc_tribyte_time(hcactive_target_tb, ftb_avg_k);
+
+	/*
+	 * 2 bytes in active region = 1 FRL characters
+	 * 1 Tribyte in active region = 3/2 FRL characters
+	 */
+	num_chars_hcactive = DIV_ROUND_UP(hcactive_target_tb * 3, 2);
+
+	/*
+	 * FRL rate = lanes * frl character rate
+	 * But actual bandwidth wil be less, due to FRL limitations so account
+	 * for the overhead involved.
+	 * FRL rate with overhead = FRL rate * (100 - overhead %) / 100
+	 */
+	frl_char_rate_k = frl_lanes * min_frl_char_rate_k;
+	frl_char_rate_k = DIV_ROUND_UP(frl_char_rate_k * (EFFICIENCY_MULTIPLIER - overhead_max),
+				       EFFICIENCY_MULTIPLIER);
+
+	/* Time to transmit all characters with FRL limitations */
+	tribyte_time_ns	= get_dsc_tribyte_time(num_chars_hcactive, frl_char_rate_k);
+	return max(avg_tribyte_time_ns, tribyte_time_ns);
+}
+
+/* Get TBdelta : borrowing in tribytes relative to avg tribyte rate */
+static u32
+get_dsc_tri_bytes_delta(u32 tactive_target_ns, u32 tblank_target_ns,
+			u32 tactive_ref_ns, u32 tblank_ref_ns,
+			u32 hcactive_target_tb, u32 ftb_avg_k,
+			u32 hactive, u32 hblank,
+			u32 line_time_ns)
+{
+	u32 tb_delta_limit;
+	u32 hcblank_target_tb1 = get_frl_hcblank_tb_est1_target(hcactive_target_tb,
+								    hactive, hblank);
+	u32 tribytes = (hcactive_target_tb + hcblank_target_tb1);
+	u32 tactive_avg_ns;
+
+	if (tblank_ref_ns < tblank_target_ns) {
+		tactive_avg_ns = mult_frac(FRL_TIMING_NS_MULTIPLIER,
+					   hcactive_target_tb, ftb_avg_k * 1000);
+		tb_delta_limit = DIV_ROUND_UP((tactive_ref_ns - tactive_avg_ns) * tribytes,
+					      line_time_ns);
+	} else {
+		u32 t_delta_ns;
+
+		if (tactive_target_ns > tactive_ref_ns)
+			t_delta_ns = tactive_target_ns - tactive_ref_ns;
+		else
+			t_delta_ns = tactive_ref_ns - tactive_target_ns;
+		tb_delta_limit = (t_delta_ns * tribytes) / line_time_ns;
+	}
+
+	return tb_delta_limit;
+}
+
+static u32
+get_dsc_tri_bytes_borrowed(u32 ftb_avg_k,
+			   u32 tactive_target_ns,
+			   u32 hcactive_target)
+{
+	u32 hactive, tb_borrowed;
+
+	hactive = DIV_ROUND_UP(tactive_target_ns * DIV_ROUND_UP(ftb_avg_k, 1000), 1000);
+	tb_borrowed = hactive - hcactive_target;
+
+	return tb_borrowed;
+}
+
+/* Compute hcactive and hcblank tribytes for given dsc bpp setting */
+static void
+compute_dsc_tribytes(struct intel_hdmi_frl_dfm *frl_dfm)
+{
+	u32 hcactive_target_tb;
+	u32 hcblank_target_tb;
+	u32 cfrl_available;
+	u32 num_slices;
+	u32 bytes_target;
+
+	/* Assert for slice width ?*/
+	if (!frl_dfm->config.slice_width)
+		return;
+
+	num_slices = DIV_ROUND_UP(frl_dfm->config.hactive, frl_dfm->config.slice_width);
+
+	/* Get required no. of tribytes during HCActive */
+	bytes_target = num_slices *
+		       DIV_ROUND_UP(frl_dfm->config.target_bpp_16 * frl_dfm->config.slice_width,
+				    8 * BPP_MULTIPLIER);
+
+	hcactive_target_tb = DIV_ROUND_UP(bytes_target, 3);
+
+	/* Get FRL Available characters */
+	cfrl_available = ((EFFICIENCY_MULTIPLIER - frl_dfm->params.overhead_max) *
+			  frl_dfm->params.cfrl_line) / EFFICIENCY_MULTIPLIER;
+
+	hcblank_target_tb =
+		get_frl_hcblank_tb_target(hcactive_target_tb,
+					  frl_dfm->config.hactive,
+					  frl_dfm->config.hblank,
+					  frl_dfm->params.hblank_audio_min,
+					  cfrl_available);
+
+	frl_dfm->params.hcactive_target = hcactive_target_tb;
+	frl_dfm->params.hcblank_target = hcblank_target_tb;
+}
+
+/* Check if audio supported with given dsc bpp and frl bandwidth */
+static bool
+audio_supported_with_dsc(struct intel_hdmi_frl_dfm *frl_dfm)
+{
+	return frl_dfm->params.hcblank_target > frl_dfm->params.hblank_audio_min;
+}
+
+/* Is DFM timing requirement is met with DSC */
+static
+bool timing_req_met_with_dsc(struct intel_hdmi_frl_dfm *frl_dfm)
+{
+	u32 ftb_avg_k;
+	u32 tactive_ref_ns, tblank_ref_ns, tactive_target_ns, tblank_target_ns;
+	u32 tb_borrowed, tb_delta, tb_worst;
+
+	/* Get the avg no of tribytes sent per sec (Kbps) */
+	ftb_avg_k = (frl_dfm->params.hcactive_target + frl_dfm->params.hcblank_target) *
+		    DIV_ROUND_UP(frl_dfm->params.pixel_clock_max_khz,
+				 frl_dfm->config.hactive + frl_dfm->config.hblank);
+
+	/* Time to send Active tribytes in nanoseconds */
+	tactive_ref_ns = DIV_ROUND_UP(frl_dfm->params.line_time_ns * frl_dfm->config.hactive,
+				      frl_dfm->config.hactive + frl_dfm->config.hblank);
+
+	/* Time to send Blanking tribytes in nanoseconds */
+	tblank_ref_ns = DIV_ROUND_UP(frl_dfm->params.line_time_ns * frl_dfm->config.hblank,
+				     frl_dfm->config.hactive + frl_dfm->config.hblank);
+
+	tactive_target_ns = get_dsc_tactive_target_ns(frl_dfm->config.lanes,
+						      frl_dfm->params.hcactive_target,
+						      ftb_avg_k,
+						      frl_dfm->params.char_rate_min_kbps,
+						      frl_dfm->params.overhead_max);
+
+	tblank_target_ns = frl_dfm->params.line_time_ns - tactive_target_ns;
+
+	/* Get no. of tri bytes borrowed with DSC enabled */
+	tb_borrowed = get_dsc_tri_bytes_borrowed(ftb_avg_k,
+						 tactive_target_ns,
+						 frl_dfm->params.hcactive_target);
+
+	tb_delta = get_dsc_tri_bytes_delta(tactive_target_ns,
+					   tblank_target_ns,
+					   tactive_ref_ns,
+					   tblank_ref_ns,
+					   frl_dfm->params.hcactive_target,
+					   ftb_avg_k,
+					   frl_dfm->config.hactive,
+					   frl_dfm->config.hblank,
+					   frl_dfm->params.line_time_ns);
+
+	tb_worst = max(tb_borrowed, tb_delta);
+	if (tb_worst > TB_BORROWED_MAX)
+		return false;
+
+	frl_dfm->params.ftb_avg_k = ftb_avg_k;
+	frl_dfm->params.tb_borrowed = tb_borrowed;
+
+	return true;
+}
+
+/* Check Utilization constraint with DSC */
+static bool
+utilization_constraints_met_with_dsc(struct intel_hdmi_frl_dfm *frl_dfm)
+{
+	u32 hcactive_target_tb = frl_dfm->params.hcactive_target;
+	u32 hcblank_target_tb = frl_dfm->params.hcblank_target;
+	u32 frl_char_per_line = frl_dfm->params.cfrl_line;
+	u32 overhead_max = frl_dfm->params.overhead_max;
+	u32 utilization_with_overhead;
+	u32 actual_frl_char_payload;
+	u32 utilization;
+
+	/*
+	 * Note:
+	 * 1 FRL characters per 2 bytes in active period
+	 * 1 FRL char per byte in Blanking period
+	 */
+	actual_frl_char_payload = DIV_ROUND_UP(3 * hcactive_target_tb, 2) +
+				  hcblank_target_tb;
+
+	utilization = (actual_frl_char_payload * EFFICIENCY_MULTIPLIER) /
+		      frl_char_per_line;
+
+	/*
+	 * Utilization with overhead = utlization% +overhead %
+	 * should be less than 100%
+	 */
+	utilization_with_overhead = utilization + overhead_max;
+	if (utilization_with_overhead  > EFFICIENCY_MULTIPLIER)
+		return false;
+
+	return true;
+}
+
+/*
+ * intel_hdmi_frl_dfm_dsc_requirement_met : Check if FRL DFM requirements are met with
+ * the given bpp.
+ * @frl_dfm: dfm structure
+ *
+ * Returns true if the frl dfm requirements are met, else returns false.
+ */
+bool intel_hdmi_frl_dfm_dsc_requirement_met(struct intel_hdmi_frl_dfm *frl_dfm)
+{
+	if (!frl_dfm->config.slice_width || !frl_dfm->config.target_bpp_16)
+		return false;
+
+	compute_max_frl_link_overhead(frl_dfm);
+	compute_link_characteristics(frl_dfm);
+	compute_audio_hblank_min(frl_dfm);
+	compute_dsc_tribytes(frl_dfm);
+
+	if (!audio_supported_with_dsc(frl_dfm))
+		return false;
+
+	if (!timing_req_met_with_dsc(frl_dfm))
+		return false;
+
+	if (!utilization_constraints_met_with_dsc(frl_dfm))
+		return false;
+
+	return true;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
index 83d5b0d6370b..70a66679bdbc 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
@@ -112,4 +112,7 @@ struct intel_hdmi_frl_dfm {
 
 bool intel_hdmi_frl_dfm_nondsc_requirement_met(struct intel_hdmi_frl_dfm *frl_dfm);
 
+bool
+intel_hdmi_frl_dfm_dsc_requirement_met(struct intel_hdmi_frl_dfm *frl_dfm);
+
 #endif
-- 
2.50.1

