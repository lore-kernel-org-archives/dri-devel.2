Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CD2C5ACA8
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F4710F3B1;
	Fri,  7 Aug 2026 04:32:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Dmd817Ba";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7811C10F3A9;
 Fri,  7 Aug 2026 04:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077149; x=1817613149;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mnv2X0Z226wsh1Q+PB+awGBWv2vIXHYJ0U6TIQF49YE=;
 b=Dmd817Ba15kxpRSeDyDO8oO3jMUbaE3hcroaOyCMDFHjH4MSI1jU4JPS
 DSQCVF7TWu+MzrpZyKcWrXZJ1qKpniQX+U7XKeQaVFgXKiHBrJjaJuo1s
 e3Nf/FlmINSlkMn3UqMlp6oG6ruYcC1k4eaFLhWsK7wAcWqLVoyNyZX9h
 eSCnHH5YCTeMKk71d4oIamA7f12QVOcpS0RjuY0Qo86IszOfnBOEMW9kz
 3cxT5qz/l29MqMtmYt9hQ+d1WPm2Bmo4TfX8DsE/huoSgHSz5BjOK0DGX
 PjXffiR1V4pgduNXCLgK8MX28EvIbxCvI4GadCm5JW2N897EheOm9yNwJ Q==;
X-CSE-ConnectionGUID: +5GLGfdGR22MYR/VxqFUDA==
X-CSE-MsgGUID: eKJ2GUa+Rwyj3/QReXZX9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619346"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619346"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:29 -0700
X-CSE-ConnectionGUID: 3YVvlj8DQ7K0KXBTkTOjQw==
X-CSE-MsgGUID: Q3yApr0hT4SWQ/2fRDSPrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666368"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:27 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 24/44] drm/i915/hdmi: Add provision for FRL mode while
 computing output format
Date: Fri,  7 Aug 2026 09:44:09 +0530
Message-ID: <20260807041430.229038-25-ankit.k.nautiyal@intel.com>
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

Add a check in compute_config to select FRL mode when TMDS cannot
support the required bandwidth, passing frl_mode flag to the output
format computation.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 34 +++++++++++++++++------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index db585c2af21d..8f0ee9282b61 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2195,9 +2195,9 @@ static int intel_hdmi_compute_bpc(struct intel_encoder *encoder,
 	return -EINVAL;
 }
 
-static int intel_hdmi_compute_clock(struct intel_encoder *encoder,
-				    struct intel_crtc_state *crtc_state,
-				    bool respect_downstream_limits)
+static int intel_hdmi_compute_tmds_clock(struct intel_encoder *encoder,
+					 struct intel_crtc_state *crtc_state,
+					 bool respect_downstream_limits)
 {
 	struct intel_display *display = to_intel_display(encoder);
 	const struct drm_display_mode *adjusted_mode =
@@ -2229,6 +2229,17 @@ static int intel_hdmi_compute_clock(struct intel_encoder *encoder,
 	return 0;
 }
 
+static int intel_hdmi_compute_clock(struct intel_encoder *encoder,
+				    struct intel_crtc_state *crtc_state,
+				    bool respect_downstream_limits,
+				    bool enable_frl)
+{
+	if (enable_frl)
+		return -EINVAL;
+
+	return intel_hdmi_compute_tmds_clock(encoder, crtc_state, respect_downstream_limits);
+}
+
 bool intel_hdmi_limited_color_range(const struct intel_crtc_state *crtc_state,
 				    const struct drm_connector_state *conn_state)
 {
@@ -2284,7 +2295,8 @@ static int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
 					    struct intel_crtc_state *crtc_state,
 					    struct intel_connector *connector,
 					    bool respect_downstream_limits,
-					    enum intel_output_format sink_format)
+					    enum intel_output_format sink_format,
+					    bool enable_frl)
 {
 	const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
 
@@ -2295,7 +2307,7 @@ static int intel_hdmi_compute_output_format(struct intel_encoder *encoder,
 	crtc_state->sink_format = sink_format;
 	crtc_state->output_format = intel_hdmi_output_format(crtc_state);
 
-	return intel_hdmi_compute_clock(encoder, crtc_state, respect_downstream_limits);
+	return intel_hdmi_compute_clock(encoder, crtc_state, respect_downstream_limits, enable_frl);
 }
 
 static int intel_hdmi_compute_formats(struct intel_encoder *encoder,
@@ -2312,7 +2324,8 @@ static int intel_hdmi_compute_formats(struct intel_encoder *encoder,
 	if (drm_mode_is_420_only(info, adjusted_mode)) {
 		ret = intel_hdmi_compute_output_format(encoder, crtc_state, connector,
 						       respect_downstream_limits,
-						       INTEL_OUTPUT_FORMAT_YCBCR420);
+						       INTEL_OUTPUT_FORMAT_YCBCR420,
+						       false);
 
 		if (ret && !respect_downstream_limits) {
 			drm_dbg_kms(display->drm,
@@ -2320,17 +2333,20 @@ static int intel_hdmi_compute_formats(struct intel_encoder *encoder,
 
 			ret = intel_hdmi_compute_output_format(encoder, crtc_state, connector,
 							       respect_downstream_limits,
-							       INTEL_OUTPUT_FORMAT_RGB);
+							       INTEL_OUTPUT_FORMAT_RGB,
+							       false);
 		}
 	} else {
 		ret = intel_hdmi_compute_output_format(encoder, crtc_state, connector,
 						       respect_downstream_limits,
-						       INTEL_OUTPUT_FORMAT_RGB);
+						       INTEL_OUTPUT_FORMAT_RGB,
+						       false);
 
 		if (ret && drm_mode_is_420_also(info, adjusted_mode))
 			ret = intel_hdmi_compute_output_format(encoder, crtc_state, connector,
 							       respect_downstream_limits,
-							       INTEL_OUTPUT_FORMAT_YCBCR420);
+							       INTEL_OUTPUT_FORMAT_YCBCR420,
+							       false);
 	}
 
 	return ret;
-- 
2.50.1

