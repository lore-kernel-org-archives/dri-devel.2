Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63473C5AC81
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:33:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A14C10F3DA;
	Fri,  7 Aug 2026 04:33:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fvjUdd8Z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1BB510F3D8;
 Fri,  7 Aug 2026 04:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077177; x=1817613177;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wClLb7aeJ7cMe7+xM+zCMW++a3we6oU56z2k+BB8blI=;
 b=fvjUdd8Za1VW6z+lmz0q828hvwEoDculH9ttTq+9padt3fl67L2dgfNg
 umJRpX2+W2dcMOeJk52gIKuIlpriAT4GBsS6zuSHRl3cJdbTjjhqGGD2T
 7U+yNZFewUuLtKcvdV++offsSOtq9VdE2Jmaa7F5972BlWz1xh5l3O6VC
 cMPx3we9DlIbegE4wJ+p2g+w7N4Dbc3kxS565/tnfl27F1Q7drylXoNOQ
 xk7a8CPAbCU5oxCQ/rLGiGMY9+VD9ZerHSvldLpqsuvEs2OhtISNPdNt+
 x1prQspOBDhEpJ5lXxobcECoFtpR+uESxqpZTjRgPx09B5AJZ24jKFYR/ w==;
X-CSE-ConnectionGUID: 4TrJooCtQPiucE+nPf6/Yg==
X-CSE-MsgGUID: dpRV2L7eQQe5lLwybKFkZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619374"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619374"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:57 -0700
X-CSE-ConnectionGUID: 8ojlL3ZsS2eaJbT1Lr+36A==
X-CSE-MsgGUID: FWnx8UdqSK2ZrjGCM2+dgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666529"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:54 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 35/44] drm/i915/hdmi_frl_dfm: Add helpers to read/write FRL
 DFM registers
Date: Fri,  7 Aug 2026 09:44:20 +0530
Message-ID: <20260807041430.229038-36-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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

Introduce helpers to read/write FRL Data Flow Metering registers.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.c | 42 +++++++++++++++++++
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.h |  5 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
index 56ade6009983..51a09c05bef3 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
@@ -7,7 +7,12 @@
 
 #include <drm/drm_connector.h>
 
+#include "intel_de.h"
+#include "intel_display_driver.h"
+#include "intel_display_regs.h"
+#include "intel_display_types.h"
 #include "intel_hdmi_frl_dfm.h"
+#include "intel_hdmi_frl_dfm_regs.h"
 
 /* DFM constraints and tolerance values */
 #define TB_BORROWED_MAX			400
@@ -702,3 +707,40 @@ bool intel_hdmi_frl_dfm_dsc_requirement_met(struct intel_hdmi_frl_dfm *frl_dfm)
 
 	return true;
 }
+
+void intel_hdmi_frl_dfm_write(const struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	enum transcoder cpu_trans = crtc_state->cpu_transcoder;
+	i915_reg_t reg;
+	u32 val;
+
+	if (!crtc_state->frl.enable)
+		return;
+
+	reg = TRANS_HDMI_FRL_DFMWRCTL(display, cpu_trans);
+	val = TB_ACTUAL_OFFSET(crtc_state->frl.tb_actual);
+	intel_de_rmw(display, reg, TB_ACTUAL_OFFSET_MASK, val);
+
+	reg = TRANS_HDMI_FRL_DFMTHRSH(display, cpu_trans);
+	val = TB_MIN_THESHOLD(crtc_state->frl.tb_threshold_min);
+	intel_de_rmw(display, reg, TB_MIN_THESHOLD_MASK, val);
+}
+
+void intel_hdmi_frl_dfm_read(struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	enum transcoder cpu_trans = crtc_state->cpu_transcoder;
+	u32 val;
+
+	if (!crtc_state->frl.enable)
+		return;
+
+	val = intel_de_read(display, TRANS_HDMI_FRL_DFMWRCTL(display, cpu_trans));
+	crtc_state->frl.tb_actual =
+		REG_FIELD_GET(TB_ACTUAL_OFFSET_MASK, val);
+
+	val = intel_de_read(display, TRANS_HDMI_FRL_DFMTHRSH(display, cpu_trans));
+	crtc_state->frl.tb_threshold_min =
+		REG_FIELD_GET(TB_MIN_THESHOLD_MASK, val);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
index 70a66679bdbc..1bfc70067518 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
@@ -7,6 +7,8 @@
 
 #include <linux/types.h>
 
+struct intel_crtc_state;
+
 /* All the input config needed to compute DFM requirements */
 struct intel_hdmi_frl_dfm_input_config {
 	/*
@@ -115,4 +117,7 @@ bool intel_hdmi_frl_dfm_nondsc_requirement_met(struct intel_hdmi_frl_dfm *frl_df
 bool
 intel_hdmi_frl_dfm_dsc_requirement_met(struct intel_hdmi_frl_dfm *frl_dfm);
 
+void intel_hdmi_frl_dfm_write(const struct intel_crtc_state *crtc_state);
+void intel_hdmi_frl_dfm_read(struct intel_crtc_state *crtc_state);
+
 #endif
-- 
2.50.1

