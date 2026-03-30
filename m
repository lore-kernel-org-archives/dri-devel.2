Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D03FF493D
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C04610E3D4;
	Mon, 30 Mar 2026 04:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Tj731LQ6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A29E10E362;
 Mon, 30 Mar 2026 04:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774844554; x=1806380554;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VWXHjya03D5lqVnjNy5IbQB9C8P0ZmeGvljB613qqQU=;
 b=Tj731LQ6zZRcEt/rMecfQ61aYnoVm99uhTf7qT2kKh/i4oScICnHQg2o
 l4A0Qv378wPD7oGlX4nZrJyDBciXbGKWAUZtcNf/miHP8m7bt0UtFkMIx
 46FmsavlqTDBU7LjS4cHQb+QERYYO7Pv7MIMs+fjv8QaMpeCNKVgOqdGv
 agXxppRYWfou+HyxMFinp4Hl9uvBrg3YSbf3/wJUlAtWlKzKK7KtK++Bb
 agTaCwD2FhfUEjEjMqmwMWviofecuC0BsNtSmqqfQ69GFEcn+Cv2L3c+U
 f6ijt1y2qGw8pBccsEmXSHlgQh+BJQ/xVd8hptyMmSCBqHXGYn08NJdqa Q==;
X-CSE-ConnectionGUID: CxDp0DxyRT+eXCKOE65hKQ==
X-CSE-MsgGUID: +71BGoJvQ86OhkOjcjOzcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87218245"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="87218245"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:34 -0700
X-CSE-ConnectionGUID: fC8xTZ+VRye79ObWgLiLCg==
X-CSE-MsgGUID: VpgK8UdbTVGrs4+lQgXthA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="263871304"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:32 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 14/19] drm/i915/display: Add helper for AS SDP transmission
 time selection
Date: Mon, 30 Mar 2026 09:36:51 +0530
Message-ID: <20260330040656.4116502-15-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
References: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
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

AS SDP may be transmitted at T1 or T2 depending on Panel Replay and
Adaptive Sync SDP configuration as per DP 2.1. Current we are using
T1 only, but future PR/AS SDP modes/features may require T2 or dynamic
selection.

Introduce a helper to return the appropriate AS SDP transmission time so
that a single value is consistently used for programming PR_ALPM.
For now this returns T1.

v2: Avoid adding new member to crtc_state; use a helper. (Ville)
v3: Clarify why AS SDP transmission time is fixed to T1. (Ville)

Bspec: 68920
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_alpm.c | 20 +++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_dp.c   | 11 +++++++++++
 drivers/gpu/drm/i915/display/intel_dp.h   |  2 ++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/i915/display/intel_alpm.c
index a7350ce8e716..76de24a03f61 100644
--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -11,6 +11,7 @@
 #include "intel_crtc.h"
 #include "intel_de.h"
 #include "intel_display_types.h"
+#include "intel_display_utils.h"
 #include "intel_dp.h"
 #include "intel_dp_aux.h"
 #include "intel_psr.h"
@@ -359,6 +360,23 @@ void intel_alpm_lobf_compute_config(struct intel_dp *intel_dp,
 	crtc_state->has_lobf = true;
 }
 
+static u32 get_pr_alpm_as_sdp_transmission_time(const struct intel_crtc_state *crtc_state)
+{
+	int as_sdp_setup_time = intel_dp_as_sdp_transmission_time();
+
+	switch (as_sdp_setup_time) {
+	case DP_PR_AS_SDP_SETUP_TIME_T1:
+		return PR_ALPM_CTL_ADAPTIVE_SYNC_SDP_POSITION_T1;
+	case DP_PR_AS_SDP_SETUP_TIME_DYNAMIC:
+		return PR_ALPM_CTL_ADAPTIVE_SYNC_SDP_POSITION_T1_OR_T2;
+	case DP_PR_AS_SDP_SETUP_TIME_T2:
+		return PR_ALPM_CTL_ADAPTIVE_SYNC_SDP_POSITION_T2;
+	default:
+		MISSING_CASE(as_sdp_setup_time);
+		return PR_ALPM_CTL_ADAPTIVE_SYNC_SDP_POSITION_T1;
+	}
+}
+
 static void lnl_alpm_configure(struct intel_dp *intel_dp,
 			       const struct intel_crtc_state *crtc_state)
 {
@@ -382,7 +400,7 @@ static void lnl_alpm_configure(struct intel_dp *intel_dp,
 			ALPM_CTL_AUX_LESS_WAKE_TIME(crtc_state->alpm_state.aux_less_wake_lines);
 
 		if (intel_dp->as_sdp_supported) {
-			u32 pr_alpm_ctl = PR_ALPM_CTL_ADAPTIVE_SYNC_SDP_POSITION_T1;
+			u32 pr_alpm_ctl = get_pr_alpm_as_sdp_transmission_time(crtc_state);
 
 			if (crtc_state->link_off_after_as_sdp_when_pr_active)
 				pr_alpm_ctl |= PR_ALPM_CTL_ALLOW_LINK_OFF_BETWEEN_AS_SDP_AND_SU;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index b2007ffe18bc..108e97b26748 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -7465,3 +7465,14 @@ bool intel_dp_joiner_candidate_valid(struct intel_connector *connector,
 
 	return true;
 }
+
+int intel_dp_as_sdp_transmission_time(void)
+{
+	/*
+	 * DP allows AS SDP position to move during PR active in some cases, but
+	 * software-controlled refresh rate changes with DC6v / ALPM require the
+	 * AS SDP to remain at T1. Use T1 unconditionally for now.
+	 */
+
+	return DP_PR_AS_SDP_SETUP_TIME_T1;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index 2849b9ecdc71..2e4609d9d05c 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -238,4 +238,6 @@ bool intel_dp_joiner_candidate_valid(struct intel_connector *connector,
 	for ((__num_joined_pipes) = 1; (__num_joined_pipes) <= (I915_MAX_PIPES); (__num_joined_pipes)++) \
 		for_each_if(intel_dp_joiner_candidate_valid(__connector, (__mode)->hdisplay, __num_joined_pipes))
 
+int intel_dp_as_sdp_transmission_time(void);
+
 #endif /* __INTEL_DP_H__ */
-- 
2.45.2

