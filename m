Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C38606A31B
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QNWZxck8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57BE210E99C;
	Mon, 26 Oct 2026 05:41:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7EE10E988;
 Mon, 26 Oct 2026 05:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993259; x=1824529259;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IX6aGNxhMj5jjUTRoiLfcXFIXczpbyAg2W0KfOHJSKk=;
 b=QNWZxck8bvJ3qmOXk02GVqFspduVIXUZM9kbTGhqLZn9LJv4DHvDq4K+
 nti1mWO+NmiBglB1qRDSw3AhVkDbFTV14i4UVbhNGctXKmO1f3+j52/ct
 KABxSU54DbqwdpSSwO2zDsAoXayKbs1hs9f7PfagUZ8dU4sSY2yWfF1vJ
 +L2cWNRK1wqOgxodQze/u2VFe+PXy27lH+zoHKXgtvCZBe7ZUquZYSf2F
 ls7mlcvpFnJHANsePpjFnaa+ExJt7RM3BXfPbOXmay1k5r1/YAYn023YF
 +TKY8CmG+GN0QdMzxtiGAZo1glfrX6A3NTt7sDHnCc1uyPgmS5snPoQu8 w==;
X-CSE-ConnectionGUID: YfCzsj9RSqyJqnj3DYCtow==
X-CSE-MsgGUID: RCIb+GWATViedckoSRW4aA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550212"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550212"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:59 -0700
X-CSE-ConnectionGUID: zMcfMCDATEmfxYISOQv1yA==
X-CSE-MsgGUID: i+X/7VUiStKF2SsMyGpEwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001984"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:57 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 15/20] drm/i915/alpm: Compute and program switch to active
 latency
Date: Mon, 26 Oct 2026 11:09:26 +0530
Message-ID: <20261026054001.799894-16-animesh.manna@intel.com>
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Program the ALPM switch to active latency into ALPM_CTL2. For UHBR link
rates the latency is derived from the link symbol clock and converted to
scanlines, for non-UHBR rates it is zero.

v2: Use macro instead of magic number wherever possible. [Jouni]
v3:
- Use intel_dp_link_symbol_clock(). [Jouni]
- Fix switch to active time which was 32 times too long as the symbol
  clock already accounts for the 32 bits per symbol. [sashiko]
- Round the switch to active time up to microseconds. [sashiko]
- Check the switch to active latency fits into ALPM_CTL2. [sashiko]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     | 35 +++++++++++++++++--
 .../drm/i915/display/intel_display_types.h    |  1 +
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 831dfa5e677b..4e761022485d 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -250,6 +250,31 @@ static int get_establishment_period(struct intel_dp *intel_dp,
 	return SILENCE_PERIOD_TIME + t1 + tcds;
 }
 
+static int get_switch_to_active(const struct intel_crtc_state *crtc_state)
+{
+	int switch_to_active;
+
+	if (intel_dp_is_uhbr(crtc_state)) {
+		/* link symbol clock (fLink / 32) in kHz */
+		int symbol_clock = intel_dp_link_symbol_clock(crtc_state->port_clock);
+
+		/*
+		 * tSwitch to Active = 32 * (ML_PHY_LOCK Length + 3 + 64) / fLink
+		 *		     = (ML_PHY_LOCK Length + 3 + 64) / symbol clock
+		 *
+		 * The "+ 3" term is the trailing zero padding after the
+		 * POST_LT_SCRAMBLER_RESET, the "+ 64" term represents the MTP
+		 * time slots. The result is rounded up to microseconds.
+		 */
+		switch_to_active = DIV_ROUND_UP((ML_PHY_LOCK_LEN_UHBR + 3 + 64) * 1000,
+						symbol_clock);
+	} else {
+		switch_to_active = 0;
+	}
+
+	return switch_to_active;
+}
+
 /*
  * AUX-Less Wake Time = CEILING( ((PHY P2 to P0) + tLFPS_Period, Max+
  * tSilence, Max+ tPHY Establishment + tCDS) / tline)
@@ -292,7 +317,7 @@ _lnl_compute_aux_less_alpm_params(struct intel_dp *intel_dp,
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 	int aux_less_wake_time, aux_less_wake_lines, silence_period,
-		lfps_half_cycle;
+		lfps_half_cycle, switch_to_active_lines;
 
 	aux_less_wake_time =
 		_lnl_compute_aux_less_wake_time(intel_dp, crtc_state);
@@ -302,10 +327,14 @@ _lnl_compute_aux_less_alpm_params(struct intel_dp *intel_dp,
 
 	lfps_half_cycle = get_lfps_half_cycle_clocks(crtc_state);
 
+	switch_to_active_lines = intel_usecs_to_scanlines(&crtc_state->hw.adjusted_mode,
+							  get_switch_to_active(crtc_state));
+
 	if (aux_less_wake_lines > get_aux_less_wake_lines_max(display) ||
 	    silence_period > PORT_ALPM_CTL_SILENCE_PERIOD_MASK ||
 	    lfps_half_cycle < 1 ||
-	    lfps_half_cycle > PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK + 1)
+	    lfps_half_cycle > PORT_ALPM_LFPS_CTL_LAST_LFPS_HALF_CYCLE_DURATION_MASK + 1 ||
+	    switch_to_active_lines > REG_FIELD_MAX(ALPM_CTL2_SWITCH_TO_ACTIVE_LATENCY_MASK))
 		return false;
 
 	if (display->params.psr_safest_params)
@@ -314,6 +343,7 @@ _lnl_compute_aux_less_alpm_params(struct intel_dp *intel_dp,
 	crtc_state->alpm_state.aux_less_wake_lines = aux_less_wake_lines;
 	crtc_state->alpm_state.silence_period_sym_clocks = silence_period;
 	crtc_state->alpm_state.lfps_half_cycle_num_of_syms = lfps_half_cycle;
+	crtc_state->alpm_state.switch_to_active = switch_to_active_lines;
 
 	return true;
 }
@@ -731,6 +761,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 		lttpr_count = 0;
 
 	alpm_ctl2 = ALPM_CTL2_NUMBER_OF_LTTPR(lttpr_count);
+	alpm_ctl2 |= ALPM_CTL2_SWITCH_TO_ACTIVE_LATENCY(crtc_state->alpm_state.switch_to_active);
 
 	intel_de_write(display, ALPM_CTL2(display, cpu_transcoder), alpm_ctl2);
 	intel_de_write(display, ALPM_CTL(display, cpu_transcoder), alpm_ctl);
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index d0748837ce97..82a63a2e7fa3 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1469,6 +1469,7 @@ struct intel_crtc_state {
 		u8 aux_less_wake_lines;
 		u8 silence_period_sym_clocks;
 		u8 lfps_half_cycle_num_of_syms;
+		int switch_to_active;
 	} alpm_state;
 
 	/* to track changes in plane color blocks */
-- 
2.43.0

