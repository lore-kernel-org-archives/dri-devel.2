Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5902610854DC
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 09:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EDE610E783;
	Wed, 18 Mar 2026 09:26:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="de4Qmu9c";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63B5710E783;
 Wed, 18 Mar 2026 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773826012; x=1805362012;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eYHQSwgTJFYHl10cdIWjxKtheDXSwV4VIZeq9P9XvJg=;
 b=de4Qmu9cQanzd0iACIxMcjYh9AgsD3gjAK0Dfw1/ONC0b3GlsEeuGNbI
 qcMnbNqsRD/KfzIwGohYmsL9CzvnvVeRRX7jAVSO1de5TBX3g4CZMNGsJ
 9lXvWRtonUgl1sHc+eG8T99m/m/Le1wreYtT5kyRoJGrkT56UjuaGcQvE
 dRgGhHgPPWNo67q9BVDkkVhlj+TXFr6x6C5/Zedwucf4bF9n59lciDMO8
 9wa2kZeQjLxpKcmQcUQDAJQLhD1W8kKSKRosJuq4v4NtzAQMQ/gE/Ad96
 KwH6DvSnUC6cEOzRM410raY/iEdMcZ4Na0JpR3r/L/HIRE/uIrmMvNnKP w==;
X-CSE-ConnectionGUID: CwOTRU3LTuqelWWZv/w+Ow==
X-CSE-MsgGUID: cdn/7aUvRBeLLZ4i0QgfMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="85953873"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; d="scan'208";a="85953873"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2026 02:26:52 -0700
X-CSE-ConnectionGUID: DeMixuhaQRy71hK3xzLF5A==
X-CSE-MsgGUID: A4vGYPj2TX2HXwrGGMx6YQ==
X-ExtLoop1: 1
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.223.74.76])
 by fmviesa003.fm.intel.com with ESMTP; 18 Mar 2026 02:26:49 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, imre.deak@intel.com, jani.nikula@intel.com,
 arun.r.murthy@intel.com, Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v8 3/3] drm/i915/display: Panel Replay BW optimization for
 DP2.0 tunneling
Date: Wed, 18 Mar 2026 14:26:42 +0530
Message-Id: <20260318085642.3621166-4-animesh.manna@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20260318085642.3621166-1-animesh.manna@intel.com>
References: <20260318085642.3621166-1-animesh.manna@intel.com>
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

Unused bandwidth can be used by external display agents for Panel Replay
enabled DP panel during idleness with link on. Enable source to replace
dummy data from the display with data from another agent by programming
TRANS_DP2_CTL [Panel Replay Tunneling Enable].

v2:
- Enable pr bw optimization along with panel replay enable. [Jani]

v3:
- Write TRANS_DP2_CTL once for both bw optimization and panel replay
enable. [Jani]

v4:
- Read DPCD once in init() and store in panel_replay_caps. [Jouni]

v5:
- Avoid reading DPCD for edp. [Jouni]
- Use drm_dp_dpcd_read_byte() and some cosmetic changes. [Jani]

v6:
- Extend the corresponding interface defined in drm_dp_tunnel.c
to query the Panel Replay optimization capability. [Imre]

Bspec: 68920
Reviewed-by: Arun R Murthy <arun.r.murthy@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 .../gpu/drm/i915/display/intel_display_regs.h |  1 +
 drivers/gpu/drm/i915/display/intel_psr.c      | 19 +++++++++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_regs.h b/drivers/gpu/drm/i915/display/intel_display_regs.h
index 4746e9ebd920..dada8dc27ea4 100644
--- a/drivers/gpu/drm/i915/display/intel_display_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_display_regs.h
@@ -2263,6 +2263,7 @@
 #define TRANS_DP2_CTL(trans)			_MMIO_TRANS(trans, _TRANS_DP2_CTL_A, _TRANS_DP2_CTL_B)
 #define  TRANS_DP2_128B132B_CHANNEL_CODING	REG_BIT(31)
 #define  TRANS_DP2_PANEL_REPLAY_ENABLE		REG_BIT(30)
+#define  TRANS_DP2_PR_TUNNELING_ENABLE		REG_BIT(26)
 #define  TRANS_DP2_DEBUG_ENABLE			REG_BIT(23)
 
 #define _TRANS_DP2_VFREQHIGH_A			0x600a4
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index c13116e6f17f..7e891a80786e 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -44,6 +44,7 @@
 #include "intel_dmc.h"
 #include "intel_dp.h"
 #include "intel_dp_aux.h"
+#include "intel_dp_tunnel.h"
 #include "intel_dsb.h"
 #include "intel_frontbuffer.h"
 #include "intel_hdmi.h"
@@ -1023,11 +1024,23 @@ static u8 frames_before_su_entry(struct intel_dp *intel_dp)
 	return frames_before_su_entry;
 }
 
+static bool intel_psr_allow_pr_bw_optimization(struct intel_dp *intel_dp)
+{
+	if (!intel_dp_tunnel_bw_alloc_is_enabled(intel_dp))
+		return false;
+
+	if (!intel_dp_tunnel_pr_optimization_supported(intel_dp))
+		return false;
+
+	return true;
+}
+
 static void dg2_activate_panel_replay(struct intel_dp *intel_dp)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 	struct intel_psr *psr = &intel_dp->psr;
 	enum transcoder cpu_transcoder = intel_dp->psr.transcoder;
+	u32 dp2_ctl_val = TRANS_DP2_PANEL_REPLAY_ENABLE;
 
 	if (intel_dp_is_edp(intel_dp) && psr->sel_update_enabled) {
 		u32 val = psr->su_region_et_enabled ?
@@ -1040,12 +1053,14 @@ static void dg2_activate_panel_replay(struct intel_dp *intel_dp)
 			       val);
 	}
 
+	if (!intel_dp_is_edp(intel_dp) && intel_psr_allow_pr_bw_optimization(intel_dp))
+		dp2_ctl_val |= TRANS_DP2_PR_TUNNELING_ENABLE;
+
 	intel_de_rmw(display,
 		     PSR2_MAN_TRK_CTL(display, intel_dp->psr.transcoder),
 		     0, ADLP_PSR2_MAN_TRK_CTL_SF_CONTINUOS_FULL_FRAME);
 
-	intel_de_rmw(display, TRANS_DP2_CTL(intel_dp->psr.transcoder), 0,
-		     TRANS_DP2_PANEL_REPLAY_ENABLE);
+	intel_de_rmw(display, TRANS_DP2_CTL(intel_dp->psr.transcoder), 0, dp2_ctl_val);
 }
 
 static void hsw_activate_psr2(struct intel_dp *intel_dp)
-- 
2.29.0

