Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0993AC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55D8510EFF0;
	Tue, 15 Sep 2026 18:39:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="K+OdeYbt";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 928A110EFF0;
 Tue, 15 Sep 2026 18:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497572; x=1821033572;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=T6rwmScuc6SdeHfCnB55NXjNoXiaGYyhX7tnEWngezQ=;
 b=K+OdeYbt9tUPW1TZk5Rqfp8cN7JxWqYhy8OxtO+1n6HsIgNx+xT5fppb
 isUXeADfIQu410jEFfLz9Rj90ll4FuD785UCVJv1tUtNO+5fyf+QjU0hj
 H2EucV1QtayG28hBUQFtYYrzHzEvlRXG4Pt9M6M14YBeoZqAyQ7qrP8+P
 9S43fI6W5yz+7UqZzIl3Ot3Qi4/KeiAG1YEiHXT3I0U+uO70pjdogIkRR
 tDRFxtoF/3J9VuruZGygq5NOFBzoA7xhOXtzE3AjSWZkpYe6Ggn2SZ8v0
 Vv46DR9J0KRnXTZ25hF6CXIdFoyEzie7dmzXJBwGGMv5Y68zm0CyHKJcD Q==;
X-CSE-ConnectionGUID: c1ihIM6LSiGKNXvN4G3QvA==
X-CSE-MsgGUID: A2tQkTQqRkW2yKPG3eRw3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380321"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380321"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:32 -0700
X-CSE-ConnectionGUID: GeHO+EucRyyE57F7gheFaw==
X-CSE-MsgGUID: 4qFgsppMTES9qf+3CSnEyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148523"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:30 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 12/18] drm/i915/alpm: Program LTTPR count for DP 2.1 ALPM
Date: Tue, 15 Sep 2026 23:34:43 +0530
Message-Id: <20260915180449.277933-13-animesh.manna@intel.com>
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

Issue a AUX write transaction to DPCD DP_TOTAL_LTTPR_CNT (0xf000a)
with total number of LTTPR before link training.

v2: Cosmetic changes. [Suraj]
v3:
- Use same encoding format for lttpr_count. [Jouni]
- Avoid reading alpm_ctl2 register. [Jouni]

Cc: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c     |  7 ++++++-
 .../drm/i915/display/intel_dp_link_training.c | 21 +++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index da653a407e97..06c1a59aa2c5 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -726,7 +726,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
-	u32 alpm_ctl;
+	u32 alpm_ctl, alpm_ctl2, lttpr_count;
 
 	if (DISPLAY_VER(display) < 20 || (!intel_psr_needs_alpm(intel_dp, crtc_state) &&
 					  !crtc_state->has_lobf))
@@ -762,6 +762,11 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 
 	alpm_ctl |= ALPM_CTL_ALPM_ENTRY_CHECK(crtc_state->alpm_state.check_entry_lines);
 
+	lttpr_count = drm_dp_lttpr_count(intel_dp->lttpr_common_caps);
+
+	alpm_ctl2 = ALPM_CTL2_NUMBER_OF_LTTPR(lttpr_count);
+
+	intel_de_write(display, ALPM_CTL2(display, cpu_transcoder), alpm_ctl2);
 	intel_de_write(display, ALPM_CTL(display, cpu_transcoder), alpm_ctl);
 	mutex_unlock(&intel_dp->alpm.lock);
 }
diff --git a/drivers/gpu/drm/i915/display/intel_dp_link_training.c b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
index cb92cff90614..37c8306a1fa0 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_link_training.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_link_training.c
@@ -2265,6 +2265,25 @@ intel_dp_128b132b_link_train(struct intel_dp *intel_dp,
 	return passed;
 }
 
+static void intel_dp_update_lttpr_count(struct intel_dp *intel_dp,
+					int lttpr_count)
+{
+	u8 val;
+
+	/*
+	 * Program only for DP2.1 and return if LTTPR revison is less than 0x20
+	 * where 0:3 represents minor rev and 4:7 represent major rev
+	 */
+	if (!intel_dp_is_edp(intel_dp) ||
+	    lttpr_count < 0 ||
+	    intel_dp->lttpr_common_caps[0] <= 0x20)
+		return;
+
+	val = intel_dp->lttpr_common_caps[DP_PHY_REPEATER_CNT -
+					  DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV];
+	drm_dp_dpcd_writeb(&intel_dp->aux, DP_TOTAL_LTTPR_CNT, val);
+}
+
 /**
  * intel_dp_start_link_train - start link training
  * @state: Atomic state
@@ -2304,6 +2323,8 @@ void intel_dp_start_link_train(struct intel_atomic_state *state,
 
 	intel_dp_prepare_link_train(intel_dp, crtc_state);
 
+	intel_dp_update_lttpr_count(intel_dp, lttpr_count);
+
 	if (intel_dp_is_uhbr(crtc_state))
 		passed = intel_dp_128b132b_link_train(intel_dp, crtc_state, lttpr_count);
 	else
-- 
2.29.0

