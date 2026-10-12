Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0716FCA9EDD
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA8E510E770;
	Mon, 12 Oct 2026 04:15:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A04810E6B5;
 Mon, 12 Oct 2026 04:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778540; x=1823314540;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Lm8OL7AmJT89Qq9PNAvVTRb4WM+/jpzwRS6khu+l2JA=;
 b=GVLhglt5eqjB3bdZFtpi4vfH7l9SUhjhzMbKsqj/X/IP6rPRhzwHM0QK
 AlaJ/xn3YG3PEdw1GM+PreMFsGsQxCOqISI1CDknyAXL8xYJ6g+trIHJK
 OMFHxe59i+/X2W+dtkpx5ft+auznUkFGvpWruWOHy+vqGtxnVFe66XEum
 DPpKwE2tmA8vPfok9Hk1iVAGC41FzQLfmXg0Kv5Lsnst6KzOqaFlRpfWh
 p8sp4wU94FH2lVavU2eG3rZo5T5b1yAwCDRk+iLiYNVoh7fBzcpsk1dUx
 dLggWyx+QD2TCGJq29d+nZ/tFuF1euQXWXWsu15PJI0NYTiAIqWlO6U4Q w==;
X-CSE-ConnectionGUID: /m7iYEvFTa2677ng/0syyQ==
X-CSE-MsgGUID: 8qz3PVwMSvOUVZvwJdv1Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380926"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380926"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:36 -0700
X-CSE-ConnectionGUID: SyNHCNK1TxqHwMYnpTqxrA==
X-CSE-MsgGUID: /ZmCkKWHQKyQbuINBeDezQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256597"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:34 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 36/56] drm/i915/hdmi: Validate FRL modes in mode_valid
 using the FRL DFM
Date: Mon, 12 Oct 2026 09:27:45 +0530
Message-ID: <20261012035806.3361439-37-ankit.k.nautiyal@intel.com>
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

Modes above the TMDS limits can still be driven over FRL. When the
TMDS check fails, fall back to an FRL check that runs the non-DSC FRL DFM
at the best case (min bpc, max FRL rate, min audio) to confirm the mode
fits.

The fallback is gated on intel_hdmi_can_support_frl(), added here as a
placeholder returning false, so the FRL path stays inactive until FRL
support is completed in a later change.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 61 ++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 67228b538e81..b82c636b46f9 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -62,6 +62,7 @@
 #include "intel_hdcp_regs.h"
 #include "intel_hdcp_shim.h"
 #include "intel_hdmi.h"
+#include "intel_hdmi_frl_dfm.h"
 #include "intel_link_bw.h"
 #include "intel_lspcon.h"
 #include "intel_panel.h"
@@ -2021,6 +2022,51 @@ intel_hdmi_tmds_mode_clock_valid(struct drm_connector *_connector, int clock,
 	return status;
 }
 
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
+static enum drm_mode_status
+intel_hdmi_frl_mode_clock_valid(struct intel_connector *connector,
+				const struct drm_display_mode *mode,
+				enum intel_output_format output_format)
+{
+	struct intel_hdmi *hdmi = intel_attached_hdmi(connector);
+	struct intel_hdmi_frl_dfm frl_dfm = {};
+	int max_rate = hdmi->max_frl_rate;
+	int lanes = max_rate < 24 ? 3 : 4;
+
+	frl_dfm.config.pixel_clock_nominal_khz = mode->clock;
+	frl_dfm.config.hactive = mode->hdisplay;
+	frl_dfm.config.hblank = mode->htotal - mode->hdisplay;
+
+	/* Use min bpc to check if mode can be supported */
+	frl_dfm.config.bpc = 8;
+	frl_dfm.config.color_format = get_drm_color_format(output_format);
+	frl_dfm.config.lanes = lanes;
+	frl_dfm.config.bit_rate_kbps = (max_rate * 1000000) / lanes;
+
+	/* min audio */
+	frl_dfm.config.audio_channels = 2;
+	frl_dfm.config.audio_hz = 48000;
+
+	if (!intel_hdmi_frl_dfm_nondsc_requirement_met(&frl_dfm))
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
 static enum drm_mode_status
 intel_hdmi_sink_format_valid(struct intel_connector *connector,
 			     const struct drm_display_mode *mode,
@@ -2045,6 +2091,13 @@ intel_hdmi_sink_format_valid(struct intel_connector *connector,
 	}
 }
 
+static bool
+intel_hdmi_can_support_frl(struct intel_hdmi *intel_hdmi)
+{
+	/* TODO check for FRL support */
+	return false;
+}
+
 static enum drm_mode_status
 intel_hdmi_mode_valid_format(struct intel_connector *connector,
 			     const struct drm_display_mode *mode,
@@ -2052,6 +2105,7 @@ intel_hdmi_mode_valid_format(struct intel_connector *connector,
 			     enum intel_output_format sink_format)
 {
 	struct intel_display *display = to_intel_display(connector);
+	struct intel_hdmi *hdmi = intel_attached_hdmi(connector);
 	enum drm_mode_status status;
 
 	status = intel_hdmi_sink_format_valid(connector, mode,
@@ -2063,7 +2117,12 @@ intel_hdmi_mode_valid_format(struct intel_connector *connector,
 	if (status != MODE_OK)
 		return status;
 
-	return intel_hdmi_tmds_mode_clock_valid(&connector->base, clock, has_hdmi_sink, sink_format);
+	status = intel_hdmi_tmds_mode_clock_valid(&connector->base, clock, has_hdmi_sink, sink_format);
+
+	if (status != MODE_OK && intel_hdmi_can_support_frl(hdmi))
+		status = intel_hdmi_frl_mode_clock_valid(connector, mode, sink_format);
+
+	return status;
 }
 
 static enum drm_mode_status
-- 
2.50.1

