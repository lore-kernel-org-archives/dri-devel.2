Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767EFFD5F6A
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A153110E5D9;
	Wed,  8 Apr 2026 08:58:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ASl8RemU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183C110E5D5;
 Wed,  8 Apr 2026 08:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775638706; x=1807174706;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=05dUB7gXgSJ/SF8PIoOheO5beqWi3UJbrpF4pHh+O3M=;
 b=ASl8RemUtoBDfRTbB013A8G7SzAaH+QCKffzMfeurd2b+1nPTQEcBSLx
 4Df5do1ENmU5A7fiA18eRyKWAmesKiYaLGWSOTKbqSdKRg8V8wxseXSB1
 D799HJ7SO9zDd7TO9Qf+XAKHeokTD/aByiSGqXzUQ5Z/KHBD2cUVUJZ//
 ziAix2bm8XpGimQOGttyKD3GMnsrWuwXrhWxctt98cnTeL6Af6GLXWenM
 yU5NYOWfSbvbfJGiDqxJ4t+H1C3jdSKfeLuybHPs1UkSoi9Taq09iUjni
 li8hPGLjtB6MPGwbxINgJG5mU29t3/GI9jPRwuZmfVXQiQu0VExRFXxDR w==;
X-CSE-ConnectionGUID: X9TKk7vnS1KYkCxUgAH4hw==
X-CSE-MsgGUID: EtDz6olJRIixr6agBJoRJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76516688"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76516688"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:58:26 -0700
X-CSE-ConnectionGUID: /v1X32LoSG+LE3vCHfGtrA==
X-CSE-MsgGUID: O48Na5qORreKiLZN7Oa7Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="227572618"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:58:24 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 19/26] drm/i915/psr: Write the PR config DPCDs in burst mode
Date: Wed,  8 Apr 2026 14:12:31 +0530
Message-ID: <20260408084239.1295325-20-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
References: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
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

Replace the consecutive single-byte writes to PANEL_REPLAY_CONFIG and
CONFIG2 with one drm_dp_dpcd_write() burst starting at PANEL_REPLAY_CONFIG,
reducing AUX transactions.

v2: Drop extra conditions, and optimize variables. (Ville)
v3: Drop the error check after write. (Ville)

Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 26 ++++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 257bfaed2e10..e011c15ef7d8 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -783,27 +783,27 @@ static bool psr2_su_region_et_valid(struct intel_connector *connector, bool pane
 static void _panel_replay_enable_sink(struct intel_dp *intel_dp,
 				      const struct intel_crtc_state *crtc_state)
 {
-	u8 val = DP_PANEL_REPLAY_ENABLE |
-		DP_PANEL_REPLAY_VSC_SDP_CRC_EN |
-		DP_PANEL_REPLAY_UNRECOVERABLE_ERROR_EN |
-		DP_PANEL_REPLAY_RFB_STORAGE_ERROR_EN |
-		DP_PANEL_REPLAY_ACTIVE_FRAME_CRC_ERROR_EN;
-	u8 panel_replay_config2 = DP_PANEL_REPLAY_CRC_VERIFICATION;
+	u8 panel_replay_config[2];
+
+	panel_replay_config[0] = DP_PANEL_REPLAY_ENABLE |
+				 DP_PANEL_REPLAY_VSC_SDP_CRC_EN |
+				 DP_PANEL_REPLAY_UNRECOVERABLE_ERROR_EN |
+				 DP_PANEL_REPLAY_RFB_STORAGE_ERROR_EN |
+				 DP_PANEL_REPLAY_ACTIVE_FRAME_CRC_ERROR_EN;
+	panel_replay_config[1] = DP_PANEL_REPLAY_CRC_VERIFICATION;
 
 	if (crtc_state->has_sel_update)
-		val |= DP_PANEL_REPLAY_SU_ENABLE;
+		panel_replay_config[0] |= DP_PANEL_REPLAY_SU_ENABLE;
 
 	if (crtc_state->enable_psr2_su_region_et)
-		val |= DP_PANEL_REPLAY_ENABLE_SU_REGION_ET;
+		panel_replay_config[0] |= DP_PANEL_REPLAY_ENABLE_SU_REGION_ET;
 
 	if (crtc_state->req_psr2_sdp_prior_scanline)
-		panel_replay_config2 |=
+		panel_replay_config[1] |=
 			DP_PANEL_REPLAY_SU_REGION_SCANLINE_CAPTURE;
 
-	drm_dp_dpcd_writeb(&intel_dp->aux, PANEL_REPLAY_CONFIG, val);
-
-	drm_dp_dpcd_writeb(&intel_dp->aux, PANEL_REPLAY_CONFIG2,
-			   panel_replay_config2);
+	drm_dp_dpcd_write(&intel_dp->aux, PANEL_REPLAY_CONFIG,
+			  panel_replay_config, sizeof(panel_replay_config));
 }
 
 static void _psr_enable_sink(struct intel_dp *intel_dp,
-- 
2.45.2

