Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B1CC2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:33:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 531BD10F3DD;
	Fri,  7 Aug 2026 04:33:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="P0UB7BE1";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E88A910F3DD;
 Fri,  7 Aug 2026 04:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077182; x=1817613182;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+hHjzXQoH6YIGVY1Q+tHqFo1krOpaE1FUfYRaFGgPO4=;
 b=P0UB7BE1nUu7dEv7L1DkaOdtS5KQWkA/Igoi5eJ38PwEQTh6KPxdTGYC
 EUnwATkTyUryUc8eLxqPItUcVP3YCWMk3OZoJA7aPT4+2g65KZvXD4E22
 gDbMxn1m+LghATMc6CCNYAYXBVYld2zbc6vZzKTBPNMYaAK2Bz6r/HNOo
 DJFQGzW39E1uNUuMNlpDSc8zIVqLhDCLN9h5srx2J1pZJNoWfrnBmmlQl
 anW7F5WlntwBmRucs6CXhyP+keAUtj50AZW2UHY+W221FyWR4JQ4/096i
 NJ6qqM3KSt9n2oyJ64pbdUGkPp7xmztF2gUNXdZ6Ph4Du+4oyXRgB17m9 A==;
X-CSE-ConnectionGUID: BkvNDrUkQXWdhlbF/b8pig==
X-CSE-MsgGUID: SVESKf26Tp+PZwyIxpDMlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619381"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619381"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:02 -0700
X-CSE-ConnectionGUID: nih2HRvhSmyqCUeuAsdqhw==
X-CSE-MsgGUID: xXH+lbqqTUCC6PjdnvedOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666554"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:59 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 37/44] drm/i915/hdmi: Add FRL clock computation based on DFM
Date: Fri,  7 Aug 2026 09:44:22 +0530
Message-ID: <20260807041430.229038-38-ankit.k.nautiyal@intel.com>
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

Compute the FRL port clock for a mode using the DFM helper.
Starting with the lowest FRL rate that meets the DFM requirements, check
if the mode can be supported with FRL and derive the port clock from the
selected FRL rate and lane count.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 61 ++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 4d547c27914c..0977c7011dd3 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -62,6 +62,7 @@
 #include "intel_hdcp_regs.h"
 #include "intel_hdcp_shim.h"
 #include "intel_hdmi.h"
+#include "intel_hdmi_frl_dfm.h"
 #include "intel_link_bw.h"
 #include "intel_lspcon.h"
 #include "intel_lt_phy.h"
@@ -2325,13 +2326,71 @@ static int intel_hdmi_compute_tmds_clock(struct intel_encoder *encoder,
 	return 0;
 }
 
+static int
+intel_hdmi_compute_frl_config(struct intel_encoder *encoder,
+			      struct intel_crtc_state *crtc_state)
+{
+	int ret;
+
+	ret = intel_hdmi_frl_dfm_compute_config(encoder, crtc_state);
+	if (ret) {
+		memset(&crtc_state->frl, 0, sizeof(crtc_state->frl));
+		return ret;
+	}
+
+	/*
+	 * TODO
+	 * 1. Calculate condition for Reseource based scheduling enable.
+	 * Disabling resource based scheduling for now.
+	 * 2. Active Character buffer threshold depends on cd clock bw.
+	 * Setting default value of 0.
+	 */
+	crtc_state->frl.rsrc_sched_en = false;
+	crtc_state->frl.active_char_buf_threshold = 0;
+
+	return 0;
+}
+
+static int
+intel_hdmi_compute_frl_clock(struct intel_encoder *encoder,
+			     struct intel_crtc_state *crtc_state)
+{
+	struct intel_hdmi *hdmi = enc_to_intel_hdmi(encoder);
+	int max_bpc = max(crtc_state->pipe_bpp / 3, 8);
+	int port_clock;
+	int bpc;
+
+	for (bpc = max_bpc; bpc >= 8; bpc -= 2) {
+		int ret;
+
+		if (!hdmi_bpc_possible(crtc_state, bpc))
+			continue;
+
+		crtc_state->pipe_bpp = bpc * 3;
+
+		ret = intel_hdmi_compute_frl_config(encoder, crtc_state);
+		if (ret)
+			continue;
+
+		/* Port clock for FRL rates is bitrate in 10Kbps */
+		port_clock = FRL_GBPS_TO_10KBPS(crtc_state->frl.required_rate);
+
+		if (hdmi_port_frl_clock_valid(hdmi, port_clock) == MODE_OK) {
+			crtc_state->port_clock = port_clock;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int intel_hdmi_compute_clock(struct intel_encoder *encoder,
 				    struct intel_crtc_state *crtc_state,
 				    bool respect_downstream_limits,
 				    bool enable_frl)
 {
 	if (enable_frl)
-		return -EINVAL;
+		return intel_hdmi_compute_frl_clock(encoder, crtc_state);
 
 	return intel_hdmi_compute_tmds_clock(encoder, crtc_state, respect_downstream_limits);
 }
-- 
2.50.1

