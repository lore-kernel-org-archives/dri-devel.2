Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63B2FC5AC9F
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B211310F3BE;
	Fri,  7 Aug 2026 04:32:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UKBoMg3g";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E554810F3BB;
 Fri,  7 Aug 2026 04:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077162; x=1817613162;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3QGv1N/SDsb/gINMVO1dvO+3L8S/GMFZKdB184mYUNE=;
 b=UKBoMg3grkCkcBYobSiJKxjOvp9W5n/KGWXWbGDE2zEVg/UDV4QnQvfh
 tEkqka+pNImqYB/QpyX5AVpupfaaIsoYHhW+uVD60AtXLnANjTme4QI7z
 x2h7nnnPOLBGUUiM9cSwy9QL/5OP2DCzlM/O0/Wd00THhpdmZv8UsrlM1
 cXwWA88TLhWbrQ9P/61ZD6uPJTndU69fkg9OmZb9Fu8DXsM44VdD6gSST
 37OThzhRKltQTceafbYmahxydM0kHB42DVmKR/kfdHZW7FdsqnysaiX4z
 pvCyfU6lh0Ev7XPRHw9KMVeBDbjAGlESHoQjBlbvsoXIQM/BoIHg3TLha Q==;
X-CSE-ConnectionGUID: 4fvEus8RSEGCHwP0XYfkzA==
X-CSE-MsgGUID: cr1xdDCRTtOj32kH+vemFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619356"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619356"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:42 -0700
X-CSE-ConnectionGUID: FP55WbCpSzuQKfNSKcHObw==
X-CSE-MsgGUID: hv7lnSgMTMK+bb+bRPVJBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666460"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:39 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 29/44] drm/i915/hdmi: Add FRL port and mode clock valid
Date: Fri,  7 Aug 2026 09:44:14 +0530
Message-ID: <20260807041430.229038-30-ankit.k.nautiyal@intel.com>
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

From: Vandita Kulkarni <vandita.kulkarni@intel.com>

Add the clock valid checks for the HDMI FRL mode of transmission.

Introduce hdmi_port_frl_clock_valid() which validates the FRL link
rate against the maximum FRL rate and the source PHY (c10/c20 or LT),
and a common hdmi_port_clock_valid() wrapper that dispatches to the
TMDS or FRL helper based on frl_mode. Similarly add intel_hdmi_frl_clock()
and a common intel_hdmi_clock() wrapper to compute the required clock
for the selected mode of transmission.

Wire these into intel_hdmi_mode_clock_valid() via the common wrappers.
FRL mode is not enabled yet, so the callers pass frl_mode as false and
the existing TMDS behaviour is unchanged. A subsequent change will
compute frl_mode and enable FRL based validation.

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 100 +++++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_hdmi.h |   4 +-
 2 files changed, 101 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 5a3241c054f7..7170546f4779 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -64,6 +64,7 @@
 #include "intel_hdmi.h"
 #include "intel_link_bw.h"
 #include "intel_lspcon.h"
+#include "intel_lt_phy.h"
 #include "intel_panel.h"
 #include "intel_pfit.h"
 #include "intel_snps_phy.h"
@@ -1921,6 +1922,78 @@ hdmi_port_tmds_clock_valid(struct intel_hdmi *hdmi,
 	return MODE_OK;
 }
 
+/*
+ * Returns the Fixed rate in 10 Kbps per lane required to support given
+ * pixel rate.
+ * Returns 0 for pixel rate demanding > 12 Gbps
+ */
+static int intel_hdmi_frl_required_bitrate(int pixel_rate_10kbps)
+{
+	/*
+	 * 3 lane configurations:
+	 * 3 Gbps * 3 = 9 Gbps; 6 Gbps * 3 = 18 Gbps.
+	 *
+	 * 4 lane configurations:
+	 * 6 Gbps * 4 = 24 Gbps; 8 Gbps * 4 = 32 Gbp;
+	 * 10 Gbps * 4 = 40 Gbps; 12 Gbps * 4 = 48 Gbps.
+	 */
+	if (pixel_rate_10kbps <= FRL_GBPS_TO_10KBPS(9))
+		return FRL_GBPS_TO_10KBPS(3);
+
+	if (pixel_rate_10kbps > FRL_GBPS_TO_10KBPS(9) &&
+	    pixel_rate_10kbps <= FRL_GBPS_TO_10KBPS(18))
+		return FRL_GBPS_TO_10KBPS(6);
+
+	if (pixel_rate_10kbps > FRL_GBPS_TO_10KBPS(18) &&
+	    pixel_rate_10kbps <= FRL_GBPS_TO_10KBPS(24))
+		return FRL_GBPS_TO_10KBPS(6);
+
+	if (pixel_rate_10kbps > FRL_GBPS_TO_10KBPS(24) &&
+	    pixel_rate_10kbps <= FRL_GBPS_TO_10KBPS(32))
+		return FRL_GBPS_TO_10KBPS(8);
+
+	if (pixel_rate_10kbps > FRL_GBPS_TO_10KBPS(32) &&
+	    pixel_rate_10kbps <= FRL_GBPS_TO_10KBPS(40))
+		return FRL_GBPS_TO_10KBPS(10);
+
+	if (pixel_rate_10kbps > FRL_GBPS_TO_10KBPS(40) &&
+	    pixel_rate_10kbps <= FRL_GBPS_TO_10KBPS(48))
+		return FRL_GBPS_TO_10KBPS(12);
+
+	/*
+	 * pixel rate more than 48 Gbps rate, means more than
+	 * 12 Gbps x 4 lanes. Such a rate not possible with FRL.
+	 */
+	return 0;
+}
+
+static enum drm_mode_status
+hdmi_port_frl_clock_valid(struct intel_hdmi *hdmi, int clock)
+{
+	struct intel_display *display = to_intel_display(hdmi);
+
+	if (DISPLAY_VER(display) >= 35)
+		return intel_lt_phy_hdmi_frl_rate_valid(clock);
+
+	if (DISPLAY_VER(display) >= 14)
+		return intel_cx0_phy_hdmi_frl_rate_valid(hdmi, clock);
+
+	return MODE_OK;
+}
+
+static enum drm_mode_status
+hdmi_port_clock_valid(struct intel_hdmi *hdmi,
+		      int clock, bool respect_downstream_limits,
+		      bool has_hdmi_sink, bool frl_mode)
+{
+	if (frl_mode)
+		return hdmi_port_frl_clock_valid(hdmi, clock);
+
+	return hdmi_port_tmds_clock_valid(hdmi, clock,
+					  respect_downstream_limits,
+					  has_hdmi_sink);
+}
+
 int intel_hdmi_tmds_clock(int clock, int bpc,
 			  enum intel_output_format sink_format)
 {
@@ -1984,6 +2057,29 @@ static bool intel_hdmi_sink_bpc_possible(struct drm_connector *_connector,
 	}
 }
 
+static
+int intel_hdmi_frl_clock(int clock, int bpc, enum intel_output_format sink_format)
+{
+	int pixel_rate_kbps;
+
+	if (sink_format == INTEL_OUTPUT_FORMAT_YCBCR420)
+		clock /= 2;
+
+	pixel_rate_kbps = clock * bpc * 3;
+
+	/* find the closest frl bit rate */
+	return intel_hdmi_frl_required_bitrate(pixel_rate_kbps / 10);
+}
+
+static
+int intel_hdmi_clock(int clock, int bpc, enum intel_output_format sink_format, bool frl_mode)
+{
+	if (frl_mode)
+		return intel_hdmi_frl_clock(clock, bpc, sink_format);
+
+	return intel_hdmi_tmds_clock(clock, bpc, sink_format);
+}
+
 static enum drm_mode_status
 intel_hdmi_mode_clock_valid(struct drm_connector *_connector, int clock,
 			    bool has_hdmi_sink,
@@ -2001,7 +2097,7 @@ intel_hdmi_mode_clock_valid(struct drm_connector *_connector, int clock,
 	 * least one color depth is accepted.
 	 */
 	for (bpc = 12; bpc >= 8; bpc -= 2) {
-		int tmds_clock = intel_hdmi_tmds_clock(clock, bpc, sink_format);
+		int hdmi_clock = intel_hdmi_clock(clock, bpc, sink_format, false);
 
 		if (!intel_hdmi_source_bpc_possible(display, bpc))
 			continue;
@@ -2010,7 +2106,7 @@ intel_hdmi_mode_clock_valid(struct drm_connector *_connector, int clock,
 						  sink_format))
 			continue;
 
-		status = hdmi_port_tmds_clock_valid(hdmi, tmds_clock, true, has_hdmi_sink);
+		status = hdmi_port_clock_valid(hdmi, hdmi_clock, true, has_hdmi_sink, false);
 		if (status == MODE_OK)
 			return MODE_OK;
 	}
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index 5baa38d326e5..0e78e700ebf9 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -80,8 +80,10 @@ void hsw_read_infoframe(struct intel_encoder *encoder,
 			void *frame, ssize_t len);
 void intel_hdmi_poll_for_scrambling_enable(const struct intel_crtc_state *crtc_state,
 					   struct drm_connector *_connector);
-
 int intel_hdmi_sink_max_frl_rate(struct drm_connector *connector);
 int intel_hdmi_sink_dsc_max_frl_rate(struct drm_connector *connector);
 
+/* FRL rate per lane (Gbps) -> PHY PLL table units (10 kbps) */
+#define FRL_GBPS_TO_10KBPS(rate)	((rate) * 100000)
+
 #endif /* __INTEL_HDMI_H__ */
-- 
2.50.1

