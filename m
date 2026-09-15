Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A43C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66CD810EF70;
	Tue, 15 Sep 2026 18:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ioLgQZio";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9703F10EE58;
 Tue, 15 Sep 2026 18:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497566; x=1821033566;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1V4wxwpRXDjKanfN7R/II44SQXTaeWmIy8v2ucs10f8=;
 b=ioLgQZiocnkgerQsyCWPwHl2M59KoFcKSPy/kWf0jrmXS0vZnxQcAzmH
 JCzyxCR+AUt+lgrV/v+wINfWdfLQeLTXxZcYeaEKiM7FGmeWGRy91E4je
 GkqvLCJ/SZdrMcOuXVjBnqajmIF/30IHX4V20aL5XhNoh5X5VuO8BjGl5
 vR5ys2Qwmf6P9XjQZAjX3KcZIjMwXhzzLN/CvMJsa9FQRja46shFSZYsp
 3GOSzIo+qnefILehkDhr8ya8fl5jGLrqb2wm8rmhRucys35cq+BOA4j2O
 V7tqg2fJCQmfO8UYZ/Uklgc30zmRSBNJyIz/biXaNok/5pGEoqzihIm7W Q==;
X-CSE-ConnectionGUID: qMxfASpcQiaufvJHKcCpKw==
X-CSE-MsgGUID: 6OHnRcoWTEuKRkFFPiKmpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380305"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380305"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:26 -0700
X-CSE-ConnectionGUID: 7BDgh6oDQ82LYuLg+mZvMg==
X-CSE-MsgGUID: dsX5RymeTTOtC62KcofbHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148506"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:24 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 10/18] drm/i915/alpm: Modify LFPS cycle count for DP ALPM
Date: Tue, 15 Sep 2026 23:34:41 +0530
Message-Id: <20260915180449.277933-11-animesh.manna@intel.com>
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

For DP minimum LFPS count is set to minimum 16.

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index 14ecb27095b2..22ed341763fa 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -24,7 +24,8 @@
 				(SILENCE_PERIOD_MAX_TIME -	\
 				 SILENCE_PERIOD_MIN_TIME) / 2)
 
-#define LFPS_CYCLE_COUNT 10
+#define LFPS_CYCLE_COUNT	10
+#define LFPS_CYCLE_COUNT_DP	16
 
 bool intel_alpm_aux_wake_supported(struct intel_dp *intel_dp)
 {
@@ -121,10 +122,19 @@ static int get_lfps_cycle_time(const struct intel_crtc_state *crtc_state)
 	return tlfps_cycle_min +  (tlfps_cycle_max - tlfps_cycle_min) / 2;
 }
 
+static int get_lfps_cycle_count(const struct intel_crtc_state *crtc_state)
+{
+	/* External DP uses a minimum of 16 LFPS cycles. */
+	if (!intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP))
+		return LFPS_CYCLE_COUNT_DP;
+
+	return LFPS_CYCLE_COUNT;
+}
+
 static int get_lfps_half_cycle_clocks(const struct intel_crtc_state *crtc_state)
 {
 	return get_lfps_cycle_time(crtc_state) * crtc_state->port_clock / 1000 /
-		1000 / (2 * LFPS_CYCLE_COUNT);
+		1000 / (2 * get_lfps_cycle_count(crtc_state));
 }
 
 #define ML_PHY_LOCK_LEN		252
@@ -779,7 +789,7 @@ void intel_alpm_port_configure(struct intel_dp *intel_dp,
 			PORT_ALPM_CTL_MAX_PHY_SWING_HOLD(0) |
 			PORT_ALPM_CTL_SILENCE_PERIOD(
 				crtc_state->alpm_state.silence_period_sym_clocks);
-		lfps_ctl_val = PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(LFPS_CYCLE_COUNT) |
+		lfps_ctl_val = PORT_ALPM_LFPS_CTL_LFPS_CYCLE_COUNT(get_lfps_cycle_count(crtc_state)) |
 			PORT_ALPM_LFPS_CTL_LFPS_HALF_CYCLE_DURATION(
 				crtc_state->alpm_state.lfps_half_cycle_num_of_syms) |
 			PORT_ALPM_LFPS_CTL_FIRST_LFPS_HALF_CYCLE_DURATION(
-- 
2.29.0

