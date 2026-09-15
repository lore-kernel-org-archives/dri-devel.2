Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B19C982C4
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5E910E829;
	Tue, 15 Sep 2026 18:39:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ktBSNO9A";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1961B10ED09;
 Tue, 15 Sep 2026 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497555; x=1821033555;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IcnTlkuX6LdGgORmEmh2FssmBcvI5p+4ELWbDF36YIs=;
 b=ktBSNO9ATZFHYHMtrU5yFfoafChJWLXKp/nizFdp6yluQkpglLFrN+kl
 kBJ3I5V/t21Cq/O7gr6+tREheLTkBJvWZjX7lzZ5oVIoDCmBzkZFWRBH0
 YeWh79ftmhh8Cw1ghVLFNVI2CwkXz/s/R+V2XRfcutfSb+GGxXTCLSKKN
 VghHu9+F6reo/ZA3EB61B0GcSV/naQHRjfL6hof0GMYr4pa56+0YKC8rB
 MK2HqoYC+fdetIl8dZABRz/krofvdOfLNSMJReZxrobMIOJp+VyWJh/Fj
 tihLj6ImrSkO1ELOkOzz6mrEOn8jZchqmyNv5Fyj5avyiIMaD54vcLMCB w==;
X-CSE-ConnectionGUID: 6QhsArSNQTKkQJfrngBLAg==
X-CSE-MsgGUID: EPKNf4ONTtSqbPXV6d18rA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380286"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380286"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:15 -0700
X-CSE-ConnectionGUID: vt9qRtTET5i890p8GBmdxA==
X-CSE-MsgGUID: L5mcBQKASGSMNNq7UkdnDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148480"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:12 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 06/18] drm/i915/alpm: Auxless wake time calculation for Xe3p
Date: Tue, 15 Sep 2026 23:34:37 +0530
Message-Id: <20260915180449.277933-7-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20260915180449.277933-1-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add support for auxless waketime calculation for DP2.1 ALPM
as dependent parameter got changed.

v1: Initial version.
v2: Use intel_dp_is_uhbr(). [Jani]
v3:
- Separate out switch to active latency calculation.
- Use macro definition for ML_PHY_LOCK length. [Suraj]
v4:
- Fix 32-bit signed integer overflow. [sashiko]
- Fix negative return of drm_dp_lttpr_count(). [sashiko]
- Introduce get_ml_phy_lock_len() and get_dp_link_symbol_size(). [Jouni]
- Align variable naming with bpec formula of establishment_period. [Jouni]

Bspec: 71477
Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 69 +++++++++++++++++++----
 1 file changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index d5823174576a..924fa8dd4638 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -102,21 +102,64 @@ static int get_lfps_half_cycle_clocks(const struct intel_crtc_state *crtc_state)
 		1000 / (2 * LFPS_CYCLE_COUNT);
 }
 
+#define ML_PHY_LOCK_LEN		252
+#define ML_PHY_LOCK_LEN_UHBR	396
+
 static int get_tphy2_p2_to_p0(const struct intel_crtc_state *crtc_state)
 {
-	return 12 * 1000;
+	struct intel_display *display = to_intel_display(crtc_state);
+
+	return DISPLAY_VER(display) >= 35 ? (20 * 1000) : (12 * 1000);
+}
+
+static int get_ml_phy_lock_len(const struct intel_crtc_state *crtc_state)
+{
+	return intel_dp_is_uhbr(crtc_state) ? ML_PHY_LOCK_LEN_UHBR : ML_PHY_LOCK_LEN;
+}
+
+static int get_dp_link_symbol_size(const struct intel_crtc_state *crtc_state)
+{
+	return intel_dp_is_uhbr(crtc_state) ? 32 : 10;
 }
 
-static int get_establishment_period(const struct intel_crtc_state *crtc_state)
+static int get_establishment_period(struct intel_dp *intel_dp,
+				    const struct intel_crtc_state *crtc_state)
 {
 	int t1 = 50 * 1000;
-	int tps4 = 252;
-	/* port_clock is link rate in 10kbit/s units */
-	int tml_phy_lock = 1000 * 1000 * tps4 / crtc_state->port_clock;
+	int tps4 = get_ml_phy_lock_len(crtc_state) * get_dp_link_symbol_size(crtc_state);
+	/*
+	 * port_clock is link rate in 10kbit/s units, so multiplying by
+	 * (1000 * 1000)/10 = 100000
+	 */
+	int tml_phy_lock = 100000 * tps4 / crtc_state->port_clock;
+	int lttpr_count = 0;
 	int tcds, establishment_period;
 
-	tcds = (7 + DIV_ROUND_UP(6500, tml_phy_lock) + 1) * tml_phy_lock;
-	establishment_period = (SILENCE_PERIOD_TIME + t1 + tcds);
+	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP)) {
+		tcds = (7 + DIV_ROUND_UP(6500, tml_phy_lock) + 1) * tml_phy_lock;
+	} else {
+		tcds = 7 * tml_phy_lock;
+		lttpr_count = drm_dp_lttpr_count(intel_dp->lttpr_common_caps);
+	}
+
+	if (lttpr_count > 0) {
+		/* tlw and tcs values are taken from DP2.1 spec */
+		int tlw = 13000;
+		int tcs = 10000;
+		int tlfps_period = get_lfps_cycle_time(crtc_state);
+		int tdcs = (SILENCE_PERIOD_TIME + t1 + tcs +
+			    (lttpr_count - 1) * (tlw + tlfps_period));
+		int tacds = 70000;
+		int tds = 7 * tml_phy_lock;
+
+		/* tdrl is same as tcds*/
+		establishment_period = tlw + tlfps_period + tdcs + tacds +
+				       (lttpr_count - 1) * tds + tcds;
+	} else {
+		/* TODO: Add a check for data realign by DPCD 0x116[3] */
+
+		establishment_period = (SILENCE_PERIOD_TIME + t1 + tcds);
+	}
 
 	return establishment_period;
 }
@@ -138,12 +181,16 @@ static int get_establishment_period(const struct intel_crtc_state *crtc_state)
  * within the CDS period complete within the CDS period regardless of
  * entry into the period
  * tML_PHY_LOCK = TPS4 Length * ( 10 / (Link Rate in MHz) )
- * TPS4 Length = 252 Symbols
+ * ML_PHY_LOCK Length (8b/10b): 252
+ * ML_PHY_LOCK Length (128b/132b): 396
+ * TPS4 Length = ML_PHY_LOCK * Rate Div
+ * Rate Div = 32 for 128b/132b and 10 for 8b/10b.
  */
-static int _lnl_compute_aux_less_wake_time(const struct intel_crtc_state *crtc_state)
+static int _lnl_compute_aux_less_wake_time(struct intel_dp *intel_dp,
+					   const struct intel_crtc_state *crtc_state)
 {
 	int tphy2_p2_to_p0 = get_tphy2_p2_to_p0(crtc_state);
-	int establishment_period = get_establishment_period(crtc_state);
+	int establishment_period = get_establishment_period(intel_dp, crtc_state);
 
 	return DIV_ROUND_UP(tphy2_p2_to_p0 + get_lfps_cycle_time(crtc_state) +
 			    establishment_period, 1000);
@@ -158,7 +205,7 @@ _lnl_compute_aux_less_alpm_params(struct intel_dp *intel_dp,
 		lfps_half_cycle;
 
 	aux_less_wake_time =
-		_lnl_compute_aux_less_wake_time(crtc_state);
+		_lnl_compute_aux_less_wake_time(intel_dp, crtc_state);
 	aux_less_wake_lines = intel_usecs_to_scanlines(&crtc_state->hw.adjusted_mode,
 						       aux_less_wake_time);
 	silence_period = get_silence_period_symbols(crtc_state);
-- 
2.29.0

