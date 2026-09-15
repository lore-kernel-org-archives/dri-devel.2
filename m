Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD606C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E801410E4BD;
	Tue, 15 Sep 2026 18:39:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RXYORnmi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D07E10E2E4;
 Tue, 15 Sep 2026 18:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497587; x=1821033587;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yxDGv9UssrhhQsP5orvR9BxaKRenrluDiFK9X7LJDxw=;
 b=RXYORnmiP2dUb95JO3B0UdkPmVQucHvZQvIP2H5gKeKWLUcJCgnf518U
 vQiS9/Vt6ZhGQjylhPkw/QcH4jqa9/ykDK4xYLsUdjl1azrECj/+kVhBI
 O18T6zGoHmyXLuQlDRyEt7iSOtZCzgDsoy7+dkrmm80NiRUP0kWuajcis
 Yqz7tJhx6u6ESpmdw8DxoeIDxGl95bJBk/BE8duYZo577G1qirlS1x5s0
 ThfMk+U+wiWyZL6rjsKshj85G/sZls66BQ7kuXdBTQwHvVNw5Uz9YwJLT
 qmTxOM8qXpon8EbfjmOG5YRSYfa4Nho0E3FD+fInagVut3W6JHnyajCdY w==;
X-CSE-ConnectionGUID: QVWBSlJDSSeui07EInVwuA==
X-CSE-MsgGUID: BrIaqxDlQPO+wZITXnfwwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380367"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380367"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:47 -0700
X-CSE-ConnectionGUID: xxUgUmYNThKbrdY2wG/qZg==
X-CSE-MsgGUID: 45e+CqmrQE+x0xYZ+2nAMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148574"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:42 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 16/18] drm/i915/alpm: Compute and program switch to active
 latency
Date: Tue, 15 Sep 2026 23:34:47 +0530
Message-Id: <20260915180449.277933-17-animesh.manna@intel.com>
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

Program the ALPM switch to active latency into ALPM_CTL2. For UHBR link
rates the latency is derived from the link symbol clock and converted to
scanlines, for non-UHBR rates it is zero.

v2: Use macro instead of magic number wherever possible. [Jouni]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     | 29 ++++++++++++++++++-
 .../drm/i915/display/intel_display_types.h    |  1 +
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 236341aa3c8d..84777c8d31bb 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -301,6 +301,31 @@ static int get_establishment_period(struct intel_dp *intel_dp,
 	return establishment_period;
 }
 
+static int get_switch_to_active(const struct intel_crtc_state *crtc_state)
+{
+	int port_clock = crtc_state->port_clock;
+	int switch_to_active;
+
+	if (intel_dp_is_uhbr(crtc_state)) {
+		/* symbol_clock (fLink) in MHz */
+		int symbol_clock = port_clock / intel_dp_link_symbol_size(port_clock) / 100;
+
+		/*
+		 * tSwitch to Active = 32 * (ML_PHY_LOCK Length + 3 + 64) / fLink
+		 *
+		 * The "+ 3" term is the trailing zero padding after the
+		 * POST_LT_SCRAMBLER_RESET, the "+ 64" term represents the MTP
+		 * time slots. The result is in microseconds.
+		 */
+		switch_to_active = get_dp_link_symbol_size(crtc_state) *
+				   (ML_PHY_LOCK_LEN_UHBR + 3 + 64) / symbol_clock;
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
@@ -360,7 +385,8 @@ _lnl_compute_aux_less_alpm_params(struct intel_dp *intel_dp,
 	crtc_state->alpm_state.aux_less_wake_lines = aux_less_wake_lines;
 	crtc_state->alpm_state.silence_period_sym_clocks = silence_period;
 	crtc_state->alpm_state.lfps_half_cycle_num_of_syms = lfps_half_cycle;
-
+	crtc_state->alpm_state.switch_to_active = intel_usecs_to_scanlines(&crtc_state->hw.adjusted_mode,
+									   get_switch_to_active(crtc_state));
 	return true;
 }
 
@@ -772,6 +798,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 	lttpr_count = drm_dp_lttpr_count(intel_dp->lttpr_common_caps);
 
 	alpm_ctl2 = ALPM_CTL2_NUMBER_OF_LTTPR(lttpr_count);
+	alpm_ctl2 |= ALPM_CTL2_SWITCH_TO_ACTIVE_LATENCY(crtc_state->alpm_state.switch_to_active);
 
 	intel_de_write(display, ALPM_CTL2(display, cpu_transcoder), alpm_ctl2);
 	intel_de_write(display, ALPM_CTL(display, cpu_transcoder), alpm_ctl);
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index e2cc73c98479..6387258cd633 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1447,6 +1447,7 @@ struct intel_crtc_state {
 		u8 aux_less_wake_lines;
 		u8 silence_period_sym_clocks;
 		u8 lfps_half_cycle_num_of_syms;
+		int switch_to_active;
 	} alpm_state;
 	bool has_alpm;
 
-- 
2.29.0

