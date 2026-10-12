Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB2ECA9EDC
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE15210E6D3;
	Mon, 12 Oct 2026 04:15:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D7E910E530;
 Mon, 12 Oct 2026 04:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778530; x=1823314530;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=An5gNUgrXKBsNnlDU2Nch5VmZeNprvuI8kaRKQZ04F4=;
 b=mmf3C5OA3nlkJTDi9zsMWqou4lEy93diKXluz9uFBdmzAeCc0Jd0ovMq
 oIi/TlEdxTHT2Mk2w+cteUa2BSOBZIvc/fHuAybU5olX9Ja7H2yTg/5zH
 ovFSA1MuKXloMj0cGng3iN2UEJluYywL+GtVs87sPo8JLspQ7VS+yKHj4
 wq/fppR9AzsfnaLBvYZS3UUChE0OTuyotl+5pv3baEx9kbqdyBEKYarIK
 KUwXk0v/7eiNMjqSGmK4yvM9yPrQoOjWzRfDry9zsxVyQQBKjFrpLwOV8
 rvcG/EDA/efZNmd2Isv0SjZCRwuFG7NAi1texr6BNnQywKq8YYskUEAgQ w==;
X-CSE-ConnectionGUID: 3MQtfzX+TJaqZ3fRnObDfw==
X-CSE-MsgGUID: I7sjYxeJSaWg7f0IlDysEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380918"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380918"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:27 -0700
X-CSE-ConnectionGUID: B95xl+jXQtWNkzcDwxo4KA==
X-CSE-MsgGUID: L+m0krgSRFiF+pVCJOfkfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256569"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:25 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 32/56] drm/i915/hdmi_frl_dfm: Add helpers to read/write FRL
 DFM registers
Date: Mon, 12 Oct 2026 09:27:41 +0530
Message-ID: <20261012035806.3361439-33-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
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
index fe1df69a1096..8062baed63db 100644
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
@@ -719,3 +724,40 @@ bool intel_hdmi_frl_dfm_dsc_requirement_met(struct intel_hdmi_frl_dfm *frl_dfm)
 
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

