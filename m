Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C01C5AC9E
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4969E10F3E0;
	Fri,  7 Aug 2026 04:33:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Q6NzShLU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7579510F3DA;
 Fri,  7 Aug 2026 04:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077179; x=1817613179;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QZx6Ry5B1Wr4AwpNElRuxD4BjCRPNA9s2Tz7jLoIlVY=;
 b=Q6NzShLUv5kCwRvFZBEqiMMEm9aIt5e3hUCEfcknH3K1Xk81iHeOCuHU
 CPDCSlXivCIw4KSs2+pMLneofmyoTMRWOw9e0aJKmwEtlyd8B9bPcTKBr
 4LQVmYc++Qu/I/AXNW9Q4Kf0j4J3SDpN2nbXk7QyWYcj73/jcGG1wb4OC
 8BwIHoyx+T9cMqTV9PcTkf/XbpcPew09XRNWII8js6YikQr+zNSg3y3z+
 AZwjFaZ6HvFADHPH5n47z25ofvey3j1ooXT3ofE+HJsmNp3PkiKuPSONJ
 6zdQ86so+9yVRQjiFaB70uGNW1OmQWc/odKhpQLzg+Z9ElmWCf+JUSIUC Q==;
X-CSE-ConnectionGUID: muTABVdkTrus5m2JOShIcQ==
X-CSE-MsgGUID: QEc03wjaSEq56ovAZuPadQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619377"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619377"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:59 -0700
X-CSE-ConnectionGUID: 9pAfcu5kToKOZqFywE+JqQ==
X-CSE-MsgGUID: qJuvWjXURvSH7GigHBIEGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666544"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:57 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 36/44] drm/i915/hdmi_frl_dfm: Add function to compute FRL DFM
 config
Date: Fri,  7 Aug 2026 09:44:21 +0530
Message-ID: <20260807041430.229038-37-ankit.k.nautiyal@intel.com>
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

Add intel_hdmi_frl_dfm_compute_config() to find the lowest FRL rate
that meets the DFM requirements for a mode, and fill the crtc_state
with the computed DFM parameters and Link M/N.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
---
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.c | 82 +++++++++++++++++++
 .../gpu/drm/i915/display/intel_hdmi_frl_dfm.h |  3 +
 2 files changed, 85 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
index 51a09c05bef3..36ac13b2539b 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 
 #include <drm/drm_connector.h>
+#include <drm/drm_print.h>
 
 #include "intel_de.h"
 #include "intel_display_driver.h"
@@ -744,3 +745,84 @@ void intel_hdmi_frl_dfm_read(struct intel_crtc_state *crtc_state)
 	crtc_state->frl.tb_threshold_min =
 		REG_FIELD_GET(TB_MIN_THESHOLD_MASK, val);
 }
+
+static u32
+get_drm_color_format(enum intel_output_format output_format)
+{
+	switch (output_format) {
+	case INTEL_OUTPUT_FORMAT_RGB:
+		return DRM_OUTPUT_COLOR_FORMAT_RGB444;
+	case INTEL_OUTPUT_FORMAT_YCBCR420:
+		return DRM_OUTPUT_COLOR_FORMAT_YCBCR420;
+	case INTEL_OUTPUT_FORMAT_YCBCR444:
+		return DRM_OUTPUT_COLOR_FORMAT_YCBCR444;
+	default:
+		return DRM_OUTPUT_COLOR_FORMAT_RGB444;
+	}
+}
+
+int intel_hdmi_frl_dfm_compute_config(struct intel_encoder *encoder,
+				      struct intel_crtc_state *crtc_state)
+{
+	static const int rate[] = {9, 18, 24, 32, 40, 48};
+	static const int audio_freq_hz[] = {192000, 176400, 96000, 88200, 48000};
+	struct intel_hdmi_frl_dfm frl_dfm = {0};
+	struct intel_hdmi *intel_hdmi = enc_to_intel_hdmi(encoder);
+	struct intel_display *display = to_intel_display(crtc_state);
+	struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
+	int max_rate = intel_hdmi->max_frl_rate;
+	bool can_support_frl_mode = false;
+	int i, j;
+
+	/* Fill mode related input params */
+	frl_dfm.config.pixel_clock_nominal_khz = adjusted_mode->clock;
+	frl_dfm.config.hactive = adjusted_mode->hdisplay;
+	frl_dfm.config.hblank = adjusted_mode->htotal - adjusted_mode->hdisplay;
+
+	/* Fill color related input params */
+	frl_dfm.config.bpc = crtc_state->pipe_bpp / 3;
+	frl_dfm.config.color_format = get_drm_color_format(crtc_state->output_format);
+
+	/*
+	 * Check if the resolution can be supported in FRL mode.
+	 * We try with the lowest FRL rate first — the minimum rate that
+	 * satisfies DFM requirements — for better SI margin and lower power.
+	 */
+	for (i = 0; i < ARRAY_SIZE(rate); i++) {
+		if (rate[i] > max_rate)
+			continue;
+		/* Fill the bw related input parameters */
+		frl_dfm.config.lanes = rate[i] < 24 ? 3 : 4;
+		frl_dfm.config.bit_rate_kbps = (rate[i] * 1000000) / frl_dfm.config.lanes;
+		for (j = 0; j < ARRAY_SIZE(audio_freq_hz); j++) {
+			frl_dfm.config.audio_hz = audio_freq_hz[j];
+			frl_dfm.config.audio_channels = 8;
+
+			if (intel_hdmi_frl_dfm_nondsc_requirement_met(&frl_dfm)) {
+				can_support_frl_mode = true;
+				break;
+			}
+		}
+
+		if (can_support_frl_mode)
+			break;
+	}
+
+	if (!can_support_frl_mode)
+		return -EINVAL;
+
+	/* Fill crtc_state frl DFM output params */
+	crtc_state->frl.required_lanes = frl_dfm.config.lanes;
+	crtc_state->frl.required_rate = frl_dfm.config.bit_rate_kbps / 1000000;
+	crtc_state->frl.tb_borrowed = frl_dfm.params.tb_borrowed;
+	crtc_state->frl.tb_actual = frl_dfm.params.tb_borrowed / 2;
+	drm_dbg_kms(display->drm, "FRL DFM config: tb_borrowed = %d, tb_actual = %d\n",
+		    crtc_state->frl.tb_borrowed, crtc_state->frl.tb_actual);
+
+	if (frl_dfm.params.tb_borrowed && (frl_dfm.params.tb_borrowed / 2) <= 492)
+		crtc_state->frl.tb_threshold_min = 492 - (frl_dfm.params.tb_borrowed / 2);
+	else
+		crtc_state->frl.tb_threshold_min = 492;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
index 1bfc70067518..eedf43e2836c 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 
 struct intel_crtc_state;
+struct intel_encoder;
 
 /* All the input config needed to compute DFM requirements */
 struct intel_hdmi_frl_dfm_input_config {
@@ -119,5 +120,7 @@ intel_hdmi_frl_dfm_dsc_requirement_met(struct intel_hdmi_frl_dfm *frl_dfm);
 
 void intel_hdmi_frl_dfm_write(const struct intel_crtc_state *crtc_state);
 void intel_hdmi_frl_dfm_read(struct intel_crtc_state *crtc_state);
+int intel_hdmi_frl_dfm_compute_config(struct intel_encoder *encoder,
+				      struct intel_crtc_state *crtc_state);
 
 #endif
-- 
2.50.1

