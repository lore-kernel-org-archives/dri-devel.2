Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264DCC5AC9E
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:33:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 717E510F3ED;
	Fri,  7 Aug 2026 04:33:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="eZzDm+ma";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E434110F3E8;
 Fri,  7 Aug 2026 04:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077192; x=1817613192;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=A30f9iDH1wdqWEbYSl0FG/B2faP8bTdLmLolgf2moy0=;
 b=eZzDm+ma/e3B8O+no34JXbjlV7tyUQOErsNlQBxVL2I5SJwkqASEbt/K
 i5tVw5CtFnO89f23WtGjd3KO/ETF5fFXF0BOuDGr7/0SKyvwZ35dd7U+v
 Qtf1Oe6nXnm2GfUp8i7S4RatotjXV2+GppUXGFVPVw6A6B9HHlbx0rA6s
 V2zq2fKvalCuv3kqrvDH8Bw3Q4Ttq7WN+uEZOa5tNPX+dt1SfaCoXzF6k
 ywuVvNgdpaz3O5VceGncZGydbDAcejGx6vxk8naOZnys3YheUv3tRHuML
 7reU4U9gO5nzE0CfC+HhX/C2IYgBmMBXejobzlggJ2k/ibQP3u3PV1h9q w==;
X-CSE-ConnectionGUID: L57el/ooSRalQKwloRjP2A==
X-CSE-MsgGUID: OntvsqgBQqyiwaYjfVvjqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619394"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619394"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:12 -0700
X-CSE-ConnectionGUID: j+1T6EvUTtGRsxpmCaLl8Q==
X-CSE-MsgGUID: e7KLzbIaQ8CyoEZmIUOFeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666596"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:09 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 41/44] drm/i915/hdmi_frl_dfm: Handle FRL Link M/N
Date: Fri,  7 Aug 2026 09:44:26 +0530
Message-ID: <20260807041430.229038-42-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
References: <20260807041430.229038-1-ankit.k.nautiyal@intel.com>
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

From: Vandita Kulkarni <vandita.kulkarni@intel.com>

For HDMI FRL, the transcoder Link M/N carries the ratio of the average
tribyte rate (ftb_avg) to the FRL div18 clock.

Compute link_m/link_n from ftb_avg and the required FRL rate, reduced
by their gcd. As PIPE_LINK_M1/N1 are 24-bit wide, scale both down
preserving the ratio until they fit.

Program the Link M/N after FRL link training and along with the DFM
registers, just before enabling the transcoder.

Read it back in the FRL readout for the state checker.

Bspec: 68848
Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.c | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
index 36ac13b2539b..58fc55cb09e3 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
@@ -3,6 +3,7 @@
  * Copyright © 2022 Intel Corp
  */
 
+#include <linux/gcd.h>
 #include <linux/kernel.h>
 
 #include <drm/drm_connector.h>
@@ -709,6 +710,28 @@ bool intel_hdmi_frl_dfm_dsc_requirement_met(struct intel_hdmi_frl_dfm *frl_dfm)
 	return true;
 }
 
+static void frl_set_m_n(const struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
+
+	intel_de_write(display, PIPE_LINK_M1(display, cpu_transcoder),
+		       crtc_state->frl.link_m);
+	intel_de_write(display, PIPE_LINK_N1(display, cpu_transcoder),
+		       crtc_state->frl.link_n);
+}
+
+static void frl_get_m_n(struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	enum transcoder cpu_transcoder = crtc_state->cpu_transcoder;
+
+	crtc_state->frl.link_m = intel_de_read(display, PIPE_LINK_M1(display, cpu_transcoder)) &
+				 DATA_LINK_M_N_MASK;
+	crtc_state->frl.link_n = intel_de_read(display, PIPE_LINK_N1(display, cpu_transcoder)) &
+				 DATA_LINK_M_N_MASK;
+}
+
 void intel_hdmi_frl_dfm_write(const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(crtc_state);
@@ -719,6 +742,8 @@ void intel_hdmi_frl_dfm_write(const struct intel_crtc_state *crtc_state)
 	if (!crtc_state->frl.enable)
 		return;
 
+	frl_set_m_n(crtc_state);
+
 	reg = TRANS_HDMI_FRL_DFMWRCTL(display, cpu_trans);
 	val = TB_ACTUAL_OFFSET(crtc_state->frl.tb_actual);
 	intel_de_rmw(display, reg, TB_ACTUAL_OFFSET_MASK, val);
@@ -737,6 +762,8 @@ void intel_hdmi_frl_dfm_read(struct intel_crtc_state *crtc_state)
 	if (!crtc_state->frl.enable)
 		return;
 
+	frl_get_m_n(crtc_state);
+
 	val = intel_de_read(display, TRANS_HDMI_FRL_DFMWRCTL(display, cpu_trans));
 	crtc_state->frl.tb_actual =
 		REG_FIELD_GET(TB_ACTUAL_OFFSET_MASK, val);
@@ -761,6 +788,38 @@ get_drm_color_format(enum intel_output_format output_format)
 	}
 }
 
+static void
+compute_frl_mn(struct intel_crtc_state *crtc_state, u32 ftb_avg_k)
+{
+	u64 ftb_avg, div_18_clk, gcd_val;
+	u32 link_m, link_n;
+
+	ftb_avg = ftb_avg_k * 1000;
+	div_18_clk = mult_frac(1000000000, crtc_state->frl.required_rate, 18);
+	gcd_val = gcd(ftb_avg, div_18_clk);
+
+	link_m = DIV_ROUND_UP_ULL(ftb_avg, gcd_val);
+	link_n = DIV_ROUND_UP_ULL(div_18_clk, gcd_val);
+
+	/*
+	 * PIPE_LINK_M1/N1 are 24-bit (DATA_LINK_M_N_MASK). Scale both
+	 * down preserving the ratio until they fit the register width.
+	 *
+	 * #TODO check if intel_reduce_m_n_ratio() can be exported.
+	 */
+	while (link_m > DATA_LINK_M_N_MASK ||
+	       link_n > DATA_LINK_M_N_MASK) {
+		link_m >>= 1;
+		link_n >>= 1;
+	}
+
+	crtc_state->frl.link_m = link_m;
+	crtc_state->frl.link_n = link_n;
+
+	/* Frl div 18 stored in Khz */
+	crtc_state->frl.div18 = DIV_ROUND_UP_ULL(div_18_clk, 1000);
+}
+
 int intel_hdmi_frl_dfm_compute_config(struct intel_encoder *encoder,
 				      struct intel_crtc_state *crtc_state)
 {
@@ -824,5 +883,10 @@ int intel_hdmi_frl_dfm_compute_config(struct intel_encoder *encoder,
 	else
 		crtc_state->frl.tb_threshold_min = 492;
 
+	compute_frl_mn(crtc_state, frl_dfm.params.ftb_avg_k);
+	drm_dbg_kms(display->drm, "FRL Clock: link_m = %dHz, link_n = %dHz, div18 = %dKHz\n",
+		    crtc_state->frl.link_m, crtc_state->frl.link_n,
+		    crtc_state->frl.div18);
+
 	return 0;
 }
-- 
2.50.1

