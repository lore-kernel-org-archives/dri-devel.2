Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CEA606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 05:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=J39I/obA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1E310FC7E;
	Fri, 20 Nov 2026 05:12:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B569310F116;
 Fri, 20 Nov 2026 05:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795151508; x=1826687508;
 h=from:date:subject:mime-version:content-transfer-encoding:
 message-id:references:in-reply-to:to:cc;
 bh=8fA/fjF/LeLKmA7P7hGAFYn+bxbWImK14tZyVzDcURA=;
 b=J39I/obA8SlIjwD+cJqME3+Y5y6cd/UwKka2909I8VjUXN8MIJ90CA+L
 vlTIlV79SCeIeJ6JI5OhO6b19LtUOU+y5QLVTcZgd5/v7rhQfWcymVGqm
 tO2VwES2G57bAvjwH5x6zs4PTPL6p0MhnCNUCNfcZhqpcn/5JNGrHbUBP
 V04uISlclvnjatx59ReP0iJcLHpktRMH7EOORzxn4YzFALj4U5xilUTVm
 mZKXWl7NI0p0Kzierzd77eNut2V4rP1u9Ch+4Gv4Kzte56Et6ReZ4croa
 3ftKEeYG39FlguSKiJ+YmVxXwioU84kECuWiz9FCeNWabimTFQ00Nxtxk Q==;
X-CSE-ConnectionGUID: xNB/2Ea8SCG/M7BMVW1fCA==
X-CSE-MsgGUID: sMVMNJb2TD636R0Y3IfIpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3907461"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="3907461"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 21:11:47 -0800
X-CSE-ConnectionGUID: 3VvKj1OLQayhAo1tM7XegQ==
X-CSE-MsgGUID: LPSfaLvtSpC9gyWto5XG3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10607242"
Received: from srr4-3-linux-106-armuthy.iind.intel.com ([10.190.238.56])
 by fmviesa004.fm.intel.com with ESMTP; 19 Nov 2026 21:11:44 -0800
From: Arun R Murthy <arun.r.murthy@intel.com>
Date: Fri, 20 Nov 2026 10:36:08 +0530
Subject: [PATCH v5 09/13] drm/i915/dp: Select the symbol TG Data M/N
 matching the active PLL
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-vlk-64036-dp-symbol-tg-v5-9-bf8f78b32709@intel.com>
References: <20261120-vlk-64036-dp-symbol-tg-v5-0-bf8f78b32709@intel.com>
In-Reply-To: <20261120-vlk-64036-dp-symbol-tg-v5-0-bf8f78b32709@intel.com>
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

