Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A976606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 05:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NJm/77QZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED80110E98D;
	Mon, 26 Oct 2026 05:41:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DCB410E98D;
 Mon, 26 Oct 2026 05:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792993256; x=1824529256;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HJVWpU4DDEZzeC9H6zr7zri5JknQl+XVowTOao1L2HA=;
 b=NJm/77QZQZsT4+yf6INbUvj2G1jtS4rb2X3oT7FhYx7xGd1GmDCMcuY0
 hpwfvHMVtNbQYuJ9L5wz2bSLiZityN+98Nkz9sDa+vwmxXstfis55HKWI
 sfuMKVudeftU7wdV0vNyelLsDEUQDns/nPFhakjY2PM6qWsXAAfJNs3T7
 2AGMfWrWYT6HCXlWsYexwarDDMIWIaQR6GlUbvaxebF6BJPQhQYdIGsKM
 9FRHdcFYmFnIAHQ4jf1LYHPFASi6HqDW7Py49B2b7BxAZFJfH/TtQFGSf
 /qChT90A4QI8jaXwof3Rkx2kpUdXdgq3EypXJwQgqe0tLwJI0dOyTuwr/ w==;
X-CSE-ConnectionGUID: Bqnye0JLRQ61TWibRkpoWA==
X-CSE-MsgGUID: MoiojzqSQZ+Gz2tOzvQxlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1550210"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1550210"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Oct 2026 22:40:56 -0700
X-CSE-ConnectionGUID: oGp1CQpYRbiFlWvyrL/lUw==
X-CSE-MsgGUID: L//dSAVsTWKJaOW+lE1HRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="6001973"
Received: from srr4-3-linux-101-amanna.iind.intel.com ([10.190.238.88])
 by fmviesa013.fm.intel.com with ESMTP; 25 Oct 2026 22:40:54 -0700
From: Animesh Manna <animesh.manna@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: jouni.hogander@intel.com, jani.nikula@intel.com, suraj.kandpal@intel.com,
 Animesh Manna <animesh.manna@intel.com>
Subject: [PATCH v7 14/20] drm/i915/alpm: Enable MAC Transmitting LFPS for LT
 PHY
Date: Mon, 26 Oct 2026 11:09:25 +0530
Message-ID: <20261026054001.799894-15-animesh.manna@intel.com>
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

Enable MAC to transmit LFPS via LT PHY during aux-less alpm.

v2:
- Correct commit description. [Suraj]
- Remove loop as no dependency on the transmitter LT_PHY_CMN_CTL0. [Suraj]
v3: Cosmetic changes. [Suraj]
v4:
- Add Bspec reference. [Jouni]
- Rename intel_xe3plpd_mac_transmit_lfps() to
  intel_lt_mac_transmit_lfps(). [Jouni]
- Rename LT_PHY_CMN_LFPS_ENABLE to LT_PHY_CMN_MAC_TRANSMIT_LFPS to
  follow Bspec. [Jouni]

Bspec: 74500
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
index a46ab5d3d70f..6a196df2691e 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -3808,7 +3808,10 @@ static void mtl_ddi_prepare_link_retrain(struct intel_dp *intel_dp,
 	 *     ii. Enable MAC Transmits LFPS in the "PHY Common Control 0" PIPE
 	 *         register
 	 */
-	intel_lnl_mac_transmit_lfps(encoder, crtc_state);
+	if (HAS_LT_PHY(display))
+		intel_lt_mac_transmit_lfps(encoder, crtc_state);
+	else
+		intel_lnl_mac_transmit_lfps(encoder, crtc_state);
 }
 
 static void intel_ddi_prepare_link_retrain(struct intel_dp *intel_dp,
diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.c b/drivers/gpu/drm/i915/display/intel_lt_phy.c
index 86492651b01d..5b26957d7fb9 100644
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
+void intel_lt_mac_transmit_lfps(struct intel_encoder *encoder,
+				const struct intel_crtc_state *crtc_state)
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
+			 LT_PHY_CMN_MAC_TRANSMIT_LFPS,
+			 LT_PHY_CMN_MAC_TRANSMIT_LFPS, MB_WRITE_COMMITTED);
+
+	intel_lt_phy_transaction_end(encoder, wakeref);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy.h b/drivers/gpu/drm/i915/display/intel_lt_phy.h
index 16de39484779..1c3e9e200749 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy.h
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy.h
@@ -49,5 +49,7 @@ void intel_xe3plpd_pll_enable(struct intel_encoder *encoder,
 			      const struct intel_dpll_hw_state *dpll_hw_state);
 void intel_xe3plpd_pll_disable(struct intel_encoder *encoder);
 void intel_lt_phy_verify_plls(struct intel_display *display);
+void intel_lt_mac_transmit_lfps(struct intel_encoder *encoder,
+				const struct intel_crtc_state *crtc_state);
 
 #endif /* __INTEL_LT_PHY_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_lt_phy_regs.h b/drivers/gpu/drm/i915/display/intel_lt_phy_regs.h
index ff6d7829dbb9..a48da8315413 100644
--- a/drivers/gpu/drm/i915/display/intel_lt_phy_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_lt_phy_regs.h
@@ -35,6 +35,9 @@
 #define LT_PHY_TXY_CTL10_MAC(idx)	_MMIO(LT_PHY_TXY_CTL10(idx))
 #define  LT_PHY_TX_LANE_ENABLE		REG_BIT8(0)
 
+#define LT_PHY_CMN_CTL_0		(0x800)
+#define  LT_PHY_CMN_MAC_TRANSMIT_LFPS	REG_BIT8(1)
+
 /* LT Phy Vendor Register */
 #define LT_PHY_VDR_0_CONFIG	0xC02
 #define  LT_PHY_VDR_DP_PLL_ENABLE	REG_BIT(7)
-- 
2.43.0

