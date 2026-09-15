Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78574C982C1
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6A0610F05B;
	Tue, 15 Sep 2026 18:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QSuPLoIm";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A92210F05B;
 Tue, 15 Sep 2026 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789497575; x=1821033575;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GxqdL1/nkQzjGi8Fv/tSVjwpsyCrlxrkfJ29Lcsu/lE=;
 b=QSuPLoImZ/6bPUP7AL/+gLRQvLPPl2siKhNBWC5PLekPnFLw8V8QcuxH
 QLZxviuvgEZEsR3Kpv7ZrUrWO5tJJDB1sSbCxtesOJchwUZegW6OhzFZ2
 J8Ovc7Tlp4gobj6qYBALWoxMksFkhOOUZzSbEg3i/bnkGXGREoif6hsXy
 drzBr7luVA4g7gpvLI6XKmA9p7RbOXlGvU58ArxRqT+us/j+PVpH6V9EJ
 RUlq74dMit270bXNKD/lzm5U/B8YrsgOwu+lCY5K2LWiZ5muC62X500ou
 jav96QbvpAPbnyT8Ci+oaKO3XV383WMyZ7OPqtktuUn/m/LuATOkKkuzj Q==;
X-CSE-ConnectionGUID: j9PQrZ3bRjeuRn4VUk1/rw==
X-CSE-MsgGUID: 07j2z1BoRU2+yw09OYr7gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="92380332"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="92380332"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2026 11:39:35 -0700
X-CSE-ConnectionGUID: EOb5AnK1Qdew1WGXx8VfaQ==
X-CSE-MsgGUID: +rXTY6xdThqYMdnp08WrTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="298148542"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa001.fm.intel.com with ESMTP; 15 Sep 2026 11:39:33 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v6 13/18] drm/i915/alpm: Enable MAC Transmitting LFPS for LT
 PHY
Date: Tue, 15 Sep 2026 23:34:44 +0530
Message-Id: <20260915180449.277933-14-animesh.manna@intel.com>
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

Enable MAC to transmit LFPS via LT PHY during aux-less alpm.

v2:
- Correct commit description. [Suraj]
- Remove loop as no dependency on the transmitter LT_PHY_CMN_CTL0. [Suraj]
v3: Cosmetic changes. [Suraj]

Cc: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c      |  5 +++-
 drivers/gpu/drm/i915/display/intel_lt_phy.c   | 27 +++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_lt_phy.h   |  2 ++
 .../gpu/drm/i915/display/intel_lt_phy_regs.h  |  3 +++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 9b3b526e5e55..5244218132aa 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3796,7 +3796,10 @@ static void mtl_ddi_prepare_link_retrain(struct intel_dp *intel_dp,
 	 *     ii. Enable MAC Transmits LFPS in the "PHY Common Control 0" PIPE
 	 *         register
 	 */
-	intel_lnl_mac_transmit_lfps(encoder, crtc_state);
+	if (HAS_LT_PHY(display))
+		intel_xe3plpd_mac_transmit_lfps(encoder, crtc_state);
+	else
+		intel_lnl_mac_transmit_lfps(encoder, crtc_state);
 }
 
 static void intel_ddi_prepare_link_retrain(struct intel_dp *intel_dp,
diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/drm/i915/display/intel_lt_phy.c
index 86492651b01d..4fe010df20be 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.c
@@ -5,6 +5,7 @@
 
 #include <drm/drm_print.h>
 
+#include "intel_alpm.h"
 #include "intel_cx0_phy.h"
 #include "intel_cx0_phy_regs.h"
 #include "intel_ddi.h"
@@ -2357,3 +2358,29 @@ void intel_lt_phy_verify_plls(struct intel_display *display)
 	intel_lt_phy_pll_verify_tables(display, xe3plpd_lt_edp_tables);
 	intel_lt_phy_pll_verify_tables(display, xe3plpd_lt_hdmi_tables);
 }
+
+/*
+ * According to HAS we need to enable MAC Transmitting LFPS in the "PHY Common
+ * Control 0" PIPE register in case of AUX Less ALPM is going to be used. This
+ * function is doing that and is called by link retrain sequence.
+ */
+void intel_xe3plpd_mac_transmit_lfps(struct intel_encoder *encoder,
+				     const struct intel_crtc_state *crtc_state)
+{
+	struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
+	struct ref_tracker *wakeref;
+	u8 owned_lane_mask;
+
+	if (!intel_alpm_is_alpm_aux_less(intel_dp, crtc_state))
+		return;
+
+	wakeref = intel_lt_phy_transaction_begin(encoder);
+
+	owned_lane_mask = intel_lt_phy_get_owned_lane_mask(encoder);
+
+	intel_lt_phy_rmw(encoder, owned_lane_mask, LT_PHY_CMN_CTL_0,
+			 LT_PHY_CMN_LFPS_ENABLE,
+			 LT_PHY_CMN_LFPS_ENABLE, MB_WRITE_COMMITTED);
+
+	intel_lt_phy_transaction_end(encoder, wakeref);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.h b/drivers/gpu/drm/i915/display/intel_lt_phy.h
index 16de39484779..c76c97b90946 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.h
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.h
@@ -49,5 +49,7 @@ void intel_xe3plpd_pll_enable(struct intel_encoder *encoder,
 			      const struct intel_dpll_hw_state *dpll_hw_state);
 void intel_xe3plpd_pll_disable(struct intel_encoder *encoder);
 void intel_lt_phy_verify_plls(struct intel_display *display);
+void intel_xe3plpd_mac_transmit_lfps(struct intel_encoder *encoder,
+				     const struct intel_crtc_state *crtc_state);
 
 #endif /* __INTEL_LT_PHY_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy_regs.h b/drivers/gpu/drm/i915/display/intel_lt_phy_regs.h
index ff6d7829dbb9..b64ff57e0c09 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy_regs.h
@@ -35,6 +35,9 @@
 #define LT_PHY_TXY_CTL10_MAC(idx)	_MMIO(LT_PHY_TXY_CTL10(idx))
 #define  LT_PHY_TX_LANE_ENABLE		REG_BIT8(0)
 
+#define LT_PHY_CMN_CTL_0		(0x800)
+#define  LT_PHY_CMN_LFPS_ENABLE		REG_BIT8(1)
+
 /* LT Phy Vendor Register */
 #define LT_PHY_VDR_0_CONFIG	0xC02
 #define  LT_PHY_VDR_DP_PLL_ENABLE	REG_BIT(7)
-- 
2.29.0

