Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C766CA9EDA
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A3F810EC5A;
	Mon, 12 Oct 2026 04:15:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2762A10EA46;
 Mon, 12 Oct 2026 04:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778548; x=1823314548;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6zPROt+Dg8nP/iKqHkjXEz14P3pEMUR1xgESl0e4YiM=;
 b=Na7pmMvMJSB2efqUJyHkEh+N04PKWsTIRFRwGfssdS4hPd3Q7yVJZj6l
 KlVNO6/tkjJYwjBiBW6imI2E5OxPOGEXQ/NkaTtyRM9dikcMNp+Lm4DTh
 xXMGdwg7APXyGs6qzHYxw6K5skHORG45uYzIOs1P1G35DlO5y7QcDUTFs
 uocz3YdSnM4sfTjqzlorlTLMussZUYC3liC8Xs3oLxkUorwb1+KpINQ38
 fsLiF3jGpBlC7At+e7VdZPfxT8D5HK4U5FJShVXmYl4zibHEDxHUl8/Tq
 KyXKGysUHYaSkbLjVp4p0tTWVTZEXu/trjrDGYZ3biJxfUXNizfRuMwpZ w==;
X-CSE-ConnectionGUID: wkPbr/mgRw2cOT8Z6lutVA==
X-CSE-MsgGUID: QJf1CtrXSS6XOi50K7ld2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380939"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380939"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:47 -0700
X-CSE-ConnectionGUID: hyriq3YATZ2payqDBYRq4A==
X-CSE-MsgGUID: 6iG/IQJDQYWJer2axIZlYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256664"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:46 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 41/56] drm/i915/ltphy: Fix HDMI FRL per-lane TX mapping
Date: Mon, 12 Oct 2026 09:27:50 +0530
Message-ID: <20261012035806.3361439-42-ankit.k.nautiyal@intel.com>
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

intel_lt_phy_set_signal_levels() currently maps DDI lane N to PHY lane
N / 2, TX N % 2, which matches the DisplayPort lane mapping. HDMI FRL
uses a different mapping because the LT PHY swaps main links 0 and 2 to
support DP++, with the swap applied before port reversal.

The resulting HDMI lane-to-transmitter mapping is:

  HDMI lane    Normal         Reversed
  ---------    ------------   ------------
  0            LN1_TX1        LN0_TX2
  1            LN0_TX2        LN1_TX1
  2            LN0_TX1        LN1_TX2
  3            LN1_TX2        LN0_TX1   (x4 only)

Using the DP mapping for HDMI FRL causes per-lane FFE settings to be
programmed on the wrong transmitter. For example, an FFE request for
lane 0 is applied to lane 2 and vice versa.

Fix this by using an HDMI FRL-specific lookup table indexed by lane
reversal state and HDMI lane number. Retain the existing mapping for
DisplayPort and HDMI TMDS, where lane-specific signal levels are not
required.

The TX enable masks in intel_lt_phy_enable_disable_tx() already match
the Bspec-defined HDMI FRL mapping and require no changes.

Bspec: 74701
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_lt_phy.c | 33 +++++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/drm/i915/display/intel_lt_phy.c
index ba03e5f1bb87..6d6ff9fbcce8 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
@@ -2419,6 +2419,24 @@ void intel_lt_phy_set_signal_levels(struct intel_encoder *encoder,
 	struct ref_tracker *wakeref;
 	int n_entries, ln;
 	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
+	/*
+	 * HDMI 2.1 FRL distributes the DDI lanes across the PHY transmitters in
+	 * a fixed, non-identity order unlike DP which uses
+	 * lane = ln / 2, tx = ln % 2. tx selects LT_PHY_TXY_*(tx)
+	 * within the message-bus lane. Indexed [lane_reversal][ddi_lane]; the
+	 * x3 case uses the first three entries of each row.
+	 */
+	static const struct {
+		u8 lane_mask;
+		u8 tx;
+	} frl_lane_map[2][4] = {
+		/* not reversed: LN1_TX1, LN0_TX2, LN0_TX1, LN1_TX2 */
+		{ { INTEL_LT_PHY_LANE1, 0 }, { INTEL_LT_PHY_LANE0, 1 },
+		  { INTEL_LT_PHY_LANE0, 0 }, { INTEL_LT_PHY_LANE1, 1 } },
+		/* reversed:     LN0_TX2, LN1_TX1, LN1_TX2, LN0_TX1 */
+		{ { INTEL_LT_PHY_LANE0, 1 }, { INTEL_LT_PHY_LANE1, 0 },
+		  { INTEL_LT_PHY_LANE1, 1 }, { INTEL_LT_PHY_LANE0, 0 } },
+	};
 
 	if (intel_tc_port_in_tbt_alt_mode(dig_port))
 		return;
@@ -2435,9 +2453,18 @@ void intel_lt_phy_set_signal_levels(struct intel_encoder *encoder,
 
 	for (ln = 0; ln < crtc_state->lane_count; ln++) {
 		int level = intel_ddi_level(encoder, crtc_state, ln);
-		int lane = ln / 2;
-		int tx = ln % 2;
-		u8 lane_mask = lane == 0 ? INTEL_LT_PHY_LANE0 : INTEL_LT_PHY_LANE1;
+		u8 lane_mask;
+		int tx;
+
+		if (crtc_state->frl.enable) {
+			lane_mask = frl_lane_map[dig_port->lane_reversal][ln].lane_mask;
+			tx = frl_lane_map[dig_port->lane_reversal][ln].tx;
+		} else {
+			lane_mask = (ln / 2) == 0 ? INTEL_LT_PHY_LANE0 :
+						    INTEL_LT_PHY_LANE1;
+			tx = ln % 2;
+		}
+
 
 		if (!(lane_mask & owned_lane_mask))
 			continue;
-- 
2.50.1

