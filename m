Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6FD606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YbRtxYTP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB244112178;
	Thu, 26 Nov 2026 08:40:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2830A112173;
 Thu, 26 Nov 2026 08:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795682436; x=1827218436;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=8fA/fjF/LeLKmA7P7hGAFYn+bxbWImK14tZyVzDcURA=;
 b=YbRtxYTPC3UcNCpMWwc+QoCiE9DVTOKz2fOPvs8uRu06o6/1wVVsbqq4
 8rOnLvMnT1uaFy+kbHLkzXkguAFH8mwvQD1qSIjWOzL0YbAPIu7J21A4T
 EvRkgnAxag5OY8tNbWWCN2zbMV/kt9qDcs1iBNM1gPudBZJeH6Phrh5vm
 3R7Gfi91S5cyvHxEys2W9QJw06d+HYiV1EzetTsGn0Qp4qZrUuUXOdWun
 JmJNXh4BBFtzsYVXUd4g6g6AevlgK3XNtxVPe4P0iyUTczi+Uy4nUYb76
 MphP+ymeY82MiK8KsysCNI3evyuX1idFyLuO3bE5k3wo7a+3Bk6Me8xKx g==;
X-CSE-ConnectionGUID: V4iP8zX/SkmO+e3m7q7ZeQ==
X-CSE-MsgGUID: elYukOFPTAeTlmjmvZcyfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4488570"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4488570"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 00:40:35 -0800
X-CSE-ConnectionGUID: Y9MCPEygTwu2qzar515evg==
X-CSE-MsgGUID: F0ff9LotS4SzFhCU5G2Jfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12125723"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by orviesa007.jf.intel.com with ESMTP; 26 Nov 2026 00:40:33 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Thu, 26 Nov 2026 14:05:04 +0530
Subject: [PATCH v6 09/13] drm/i915/dp: Select the symbol TG Data M/N
 matching the active PLL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-vlk-64036-dp-symbol-tg-v6-9-835a4f5c0a12@intel.com>
References: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
In-Reply-To: <20261126-vlk-64036-dp-symbol-tg-v6-0-835a4f5c0a12@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 chaitanya.kumar.borah@intel.com, uma.shankar@intel.com, 
 suraj.kandpal@intel.com, Arun R Murthy <arun.r.murthy@intel.com>
X-Mailer: b4 0.15-dev
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Data M/N of the DP symbol based timing generator accounts for the
spread of the PLL, so it must match if the PLL actually used has SSC
enabled. That isn't the case for the TBT PLL, which is used without SSC
when a Type-C port is in the TBT alt mode, and it is known only once the
active PLL is selected, which for a Type-C port happens when enabling it.
With a mismatch the symbol timing generator drifts relative to the pixel
clock.

Add a DPLL manager hook to query if a DPLL state has SSC enabled, and use
it, whenever the active port DPLL is selected, to select the Data M/N
computed for the SSC disabled or enabled case.

Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c       | 16 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.h       |  1 +
 drivers/gpu/drm/i915/display/intel_dpll_mgr.c | 31 +++++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dpll_mgr.h |  2 ++
 4 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 6be2e77c984c1fa13d6896325864f4241c1c1f74..e59737c8e22ed11a6af86ac58eac02f5e11d884f 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3792,6 +3792,22 @@ static void intel_dp_symbol_tg_set_mn(struct intel_dp_symbol_tg *tg, bool ssc_en
 	tg->data_n[1] = mn->data_n[1];
 }
 
+/*
+ * Select the Data M/N matching the SSC state of the active PLL, from the
+ * variants computed by intel_dp_compute_symbol_tg().
+ */
+void intel_dp_symbol_tg_select_mn(struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	struct intel_dp_symbol_tg *tg = &crtc_state->dp_symbol_tg;
+
+	if (!tg->enable)
+		return;
+
+	intel_dp_symbol_tg_set_mn(tg, intel_dpll_hw_state_ssc_enabled(display,
+								      &crtc_state->dpll_hw_state));
+}
+
 /* Compute the DP link layer (LL) symbol based timing generator parameters */
 int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state,
diff --git a/drivers/gpu/drm/i915/display/intel_dp.h b/drivers/gpu/drm/i915/display/intel_dp.h
index 929dd099a44aac40bcfa36dbc2e832023a5751f6..064ea36d100e09cd822e5be558eee7496f17943c 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.h
+++ b/drivers/gpu/drm/i915/display/intel_dp.h
@@ -216,6 +216,7 @@ int intel_dp_dsc_min_src_compressed_bpp(void);
 int intel_dp_compute_min_hblank(struct intel_crtc_state *crtc_state,
 				const struct drm_connector_state *conn_state);
 bool intel_dp_use_symbol_tg(struct intel_display *display, bool is_mst, bool is_uhbr);
+void intel_dp_symbol_tg_select_mn(struct intel_crtc_state *crtc_state);
 int intel_dp_compute_symbol_tg(struct intel_dp *intel_dp,
 			       struct intel_crtc_state *crtc_state,
 			       const struct drm_connector_state *conn_state);
diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
index bfd6f0a1972534f05284dbf8d182e396364bcc20..4901f63314a822950e019b8778d0e5ab8b8e401e 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.c
@@ -35,6 +35,7 @@
 #include "intel_display_utils.h"
 #include "intel_dkl_phy.h"
 #include "intel_dkl_phy_regs.h"
+#include "intel_dp.h"
 #include "intel_dpio_phy.h"
 #include "intel_dpll.h"
 #include "intel_dpll_mgr.h"
@@ -120,6 +121,7 @@ struct intel_dpll_mgr {
 			      const struct intel_dpll_hw_state *dpll_hw_state);
 	bool (*compare_hw_state)(const struct intel_dpll_hw_state *a,
 				 const struct intel_dpll_hw_state *b);
+	bool (*is_ssc_enabled)(const struct intel_dpll_hw_state *dpll_hw_state);
 };
 
 static void
@@ -3312,6 +3314,9 @@ void icl_set_active_port_dpll(struct intel_crtc_state *crtc_state,
 
 	crtc_state->intel_dpll = port_dpll->pll;
 	crtc_state->dpll_hw_state = port_dpll->hw_state;
+
+	/* The DP symbol TG Data M/N depends on if the active PLL uses SSC */
+	intel_dp_symbol_tg_select_mn(crtc_state);
 }
 
 static void icl_update_active_dpll(struct intel_atomic_state *state,
@@ -4725,6 +4730,11 @@ static bool xe3plpd_compare_hw_state(const struct intel_dpll_hw_state *_a,
 	return intel_lt_phy_pll_compare_hw_state(a, b);
 }
 
+static bool xe3plpd_is_ssc_enabled(const struct intel_dpll_hw_state *dpll_hw_state)
+{
+	return dpll_hw_state->ltpll.ssc_enabled;
+}
+
 static const struct intel_dpll_mgr xe3plpd_pll_mgr = {
 	.dpll_info = xe3plpd_plls,
 	.compute_dplls = xe3plpd_compute_dplls,
@@ -4734,6 +4744,7 @@ static const struct intel_dpll_mgr xe3plpd_pll_mgr = {
 	.update_ref_clks = icl_update_dpll_ref_clks,
 	.dump_hw_state = xe3plpd_dump_hw_state,
 	.compare_hw_state = xe3plpd_compare_hw_state,
+	.is_ssc_enabled = xe3plpd_is_ssc_enabled,
 };
 
 enum intel_dpll_id dg2_port_to_pll_id(enum port port)
@@ -5106,6 +5117,26 @@ void intel_dpll_release(struct intel_atomic_state *state,
 	dpll_mgr->put_dplls(state, crtc);
 }
 
+/**
+ * intel_dpll_hw_state_ssc_enabled - check if a DPLL state has SSC enabled
+ * @display: intel_display device
+ * @dpll_hw_state: the DPLL state to check
+ *
+ * Returns:
+ * True if the DPLL state is for a DPLL with spread spectrum clocking enabled,
+ * false otherwise, or if this isn't tracked for the platform's DPLLs.
+ */
+bool intel_dpll_hw_state_ssc_enabled(struct intel_display *display,
+				     const struct intel_dpll_hw_state *dpll_hw_state)
+{
+	const struct intel_dpll_mgr *dpll_mgr = display->dpll.mgr;
+
+	if (drm_WARN_ON_ONCE(display->drm, !dpll_mgr || !dpll_mgr->is_ssc_enabled))
+		return false;
+
+	return dpll_mgr->is_ssc_enabled(dpll_hw_state);
+}
+
 /**
  * intel_dpll_update_active - update the active DPLL for a CRTC/encoder
  * @state: atomic state
diff --git a/drivers/gpu/drm/i915/display/intel_dpll_mgr.h b/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
index f4b84733a58c420491e29313cc1265a9ceaea2f8..6a1d7786f07ef41bdd9bd70f554632e6ceafb7ec 100644
--- a/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
+++ b/drivers/gpu/drm/i915/display/intel_dpll_mgr.h
@@ -463,6 +463,8 @@ void intel_dpll_update_ref_clks(struct intel_display *display);
 void intel_dpll_readout_hw_state(struct intel_display *display);
 void intel_dpll_sanitize_state(struct intel_display *display);
 
+bool intel_dpll_hw_state_ssc_enabled(struct intel_display *display,
+				     const struct intel_dpll_hw_state *dpll_hw_state);
 void intel_dpll_dump_hw_state(struct intel_display *display,
 			      struct drm_printer *p,
 			      const struct intel_dpll_hw_state *dpll_hw_state);

-- 
2.25.1

