Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F407D606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oE1ijCNM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4676510E961;
	Mon, 26 Oct 2026 05:40:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E46C10E961;
 Mon, 26 Oct 2026 05:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993235; x=1824529235;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qAW9w3sJ4usBej4KHTdCjLVV7s1n/eapGvCmlwJieDY=;
 b=oE1ijCNMQ6X5v9Lbotxdeq1uFJ18qNc6afjPsL4168A8/gflZLEFkAJV
 1RBUwW2XeTmUx5sEp1SKihWykFR2SUNpO7itfoFJLwe9OhWXGPfYU4Lbp
 sK4Cm0baAm2f52mo5ihV8BvsHAk9YEnoUvXkQ2oDAbitNZjx8x70PPM78
 flcNYbhuOYT//QeEu3rfNe6j3rDNvBDXfvtUz78zuK29waCxna/dfaZeJ
 hqy4WS3rbFe547br3gTX5cKBsqoAjbeSSYVFaOI3WA4sFjBncfe8ckiGv
 qai7mfieOkJzKNc3ayTvtFMQKZb6OD3wjitGJLXVXUn4AD+FH/qXLlj4u w==;
X-CSE-ConnectionGUID: CEZ4MRpzSvuj7vMIkc14sQ==
X-CSE-MsgGUID: VZSdDtDORZy0RKqT1/GR2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550195"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550195"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:34 -0700
X-CSE-ConnectionGUID: 0VxGRnyVSZKBL6Jv7Mnsdg==
X-CSE-MsgGUID: 4r8ygOngSKC/9BLRIM2Dww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001879"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:32 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 07/20] drm/i915/alpm: Auxless wake time calculation for Xe3p
Date: Mon, 26 Oct 2026 11:09:18 +0530
Message-ID: <20261026054001.799894-8-animesh.manna@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026054001.799894-1-animesh.manna@intel.com>
References: <20261026054001.799894-1-animesh.manna@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
v5:
- Use HAS_LT_PHY() for PHY P2 to P0 latency. [Jouni]
- Use existing intel_dp_link_symbol_size() instead of a duplicate. [Jouni]
- Fix tML_PHY_LOCK comments to use Rate Div. [Jouni]
- Check drm_dp_lttpr_count() return value. [Jouni]
- Keep num_ml_phy_lock and return establishment period directly. [Jouni]

Bspec: 71477
Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 70 +++++++++++++++++++----
 1 file changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index ab6612b4506e..b9e31c29ab96 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -109,22 +109,68 @@ static int get_lfps_half_cycle_clocks(const struct intel_crtc_state *crtc_state)
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
+	return HAS_LT_PHY(display) ? 20 * 1000 : 12 * 1000;
+}
+
+static int get_ml_phy_lock_len(const struct intel_crtc_state *crtc_state)
+{
+	return intel_dp_is_uhbr(crtc_state) ? ML_PHY_LOCK_LEN_UHBR : ML_PHY_LOCK_LEN;
 }
 
-static int get_establishment_period(const struct intel_crtc_state *crtc_state)
+static int get_establishment_period(struct intel_dp *intel_dp,
+				    const struct intel_crtc_state *crtc_state)
 {
+	struct intel_display *display = to_intel_display(intel_dp);
 	int t1 = 50 * 1000;
-	int tps4 = 252;
-	/* port_clock is link rate in 10kbit/s units */
-	int tml_phy_lock = 1000 * 1000 * tps4 / crtc_state->port_clock;
+	/*
+	 * port_clock is link rate in 10kbit/s units, so tML_PHY_LOCK in ns is
+	 * ML_PHY_LOCK Length * Rate Div * 100000 / port_clock
+	 */
+	int tml_phy_lock = get_ml_phy_lock_len(crtc_state) *
+		intel_dp_link_symbol_size(crtc_state->port_clock) * 100000 /
+		crtc_state->port_clock;
+	int lttpr_count = 0;
 	int num_ml_phy_lock, tcds;
 
-	num_ml_phy_lock = 7 + DIV_ROUND_UP(6500, tml_phy_lock) + 1;
+	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP)) {
+		num_ml_phy_lock = 7 + DIV_ROUND_UP(6500, tml_phy_lock) + 1;
+	} else {
+		num_ml_phy_lock = 7;
+
+		lttpr_count = drm_dp_lttpr_count(intel_dp->lttpr_common_caps);
+		if (lttpr_count < 0) {
+			drm_dbg_kms(display->drm,
+				    "Invalid LTTPR count (%pe), assuming no LTTPR\n",
+				    ERR_PTR(lttpr_count));
+			lttpr_count = 0;
+		}
+	}
+
 	tcds = num_ml_phy_lock * tml_phy_lock;
 
+	if (lttpr_count > 0) {
+		/* tlw and tcs values are taken from DP2.1 spec */
+		int tlw = 13000;
+		int tcs = 10000;
+		int tlfps_period = get_lfps_cycle_time(crtc_state);
+		int tdcs = SILENCE_PERIOD_TIME + t1 + tcs +
+			   (lttpr_count - 1) * (tlw + tlfps_period);
+		int tacds = 70000;
+		int tds = 7 * tml_phy_lock;
+
+		/* tdrl is same as tcds */
+		return tlw + tlfps_period + tdcs + tacds +
+		       (lttpr_count - 1) * tds + tcds;
+	}
+
+	/* TODO: Add a check for data realign by DPCD 0x116[3] */
 	return SILENCE_PERIOD_TIME + t1 + tcds;
 }
 
@@ -144,13 +190,15 @@ static int get_establishment_period(const struct intel_crtc_state *crtc_state)
  * adding the "+ 1" term ensures all ML_PHY_LOCK sequences that start
  * within the CDS period complete within the CDS period regardless of
  * entry into the period
- * tML_PHY_LOCK = TPS4 Length * ( 10 / (Link Rate in MHz) )
- * TPS4 Length = 252 Symbols
+ * tML_PHY_LOCK = ML_PHY_LOCK Length * ( Rate Div / (Link Rate in Mbps) )
+ * ML_PHY_LOCK Length = 252 symbols for 8b/10b, 396 super symbols for 128b/132b
+ * Rate Div = 10 for 8b/10b, 32 for 128b/132b
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
@@ -165,7 +213,7 @@ _lnl_compute_aux_less_alpm_params(struct intel_dp *intel_dp,
 		lfps_half_cycle;
 
 	aux_less_wake_time =
-		_lnl_compute_aux_less_wake_time(crtc_state);
+		_lnl_compute_aux_less_wake_time(intel_dp, crtc_state);
 	aux_less_wake_lines = intel_usecs_to_scanlines(&crtc_state->hw.adjusted_mode,
 						       aux_less_wake_time);
 	silence_period = get_silence_period_symbols(crtc_state);
-- 
2.43.0

