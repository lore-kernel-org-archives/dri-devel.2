Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975C8CA9EDA
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548F410E706;
	Mon, 12 Oct 2026 04:15:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8605110E614;
 Mon, 12 Oct 2026 04:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778539; x=1823314539;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=XUTmqPsrhn9JIMp0rd8Lv5aqOuZqskjDoSmda0UXwV8=;
 b=Axtc0hroTF3H+mN7XrX075FiFVlpIh67m2WpA71n3osQX9OmPQlbXu5B
 THpjKelkTa2btuGG3vuwe+JHqoZ63MU++BjSvqKOjA5rVoI/yzJi/aQQ7
 1irYCKlpZHEqJkDD8r3SkA5w4ENlPuSBAFPXq3XIFDanGczAIZd2Ox0M/
 H+DEmOO+l7z3wtmZB0RjRXeOU/osh74XVE8/oSgaXmEdCVu/XeB/QkfBT
 Z1tKbPLdqVii4V2Wxp0DjLWPoUIfRzkAMuhR44iYWxw+aIgwT+U7o+9DG
 p5Hx0rWY+inyfUlVkCv05zM9BptGUxS4LMENpkFAlb8O0zuG7R6hcTvyK Q==;
X-CSE-ConnectionGUID: MLLDg7qJTwKT4t8n4J7Fnw==
X-CSE-MsgGUID: l0yJDGqRSeyC1YdJdkyF0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380928"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380928"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:38 -0700
X-CSE-ConnectionGUID: 6cSSb+F2TCmO0/Z69c/JXw==
X-CSE-MsgGUID: HUgOK2izQoWgq/Pms44bCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256609"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:37 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 37/56] drm/i915/hdmi: Add FRL port clock valid
Date: Mon, 12 Oct 2026 09:27:46 +0530
Message-ID: <20261012035806.3361439-38-ankit.k.nautiyal@intel.com>
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

From: Vandita Kulkarni <vandita.kulkarni@intel.com>

Introduce hdmi_port_frl_clock_valid() which validates the FRL link
rate against the maximum FRL rate and the source PHY (c10/c20 or LT).

Call this from the FRL mode_valid path.

Since PHY PLL table units are in 10 kbps, add a macro to convert FRL
rate per lane in Gbps to 10 kbps.

Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 20 +++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_hdmi.h |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index b82c636b46f9..8e742165a50a 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -65,6 +65,7 @@
 #include "intel_hdmi_frl_dfm.h"
 #include "intel_link_bw.h"
 #include "intel_lspcon.h"
+#include "intel_lt_phy.h"
 #include "intel_panel.h"
 #include "intel_pfit.h"
 #include "intel_snps_phy.h"
@@ -1922,6 +1923,20 @@ hdmi_port_tmds_clock_valid(struct intel_hdmi *hdmi,
 	return MODE_OK;
 }
 
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
+	return MODE_CLOCK_RANGE;
+}
+
 int intel_hdmi_tmds_clock(int clock, int bpc,
 			  enum intel_output_format sink_format)
 {
@@ -2046,6 +2061,7 @@ intel_hdmi_frl_mode_clock_valid(struct intel_connector *connector,
 	struct intel_hdmi_frl_dfm frl_dfm = {};
 	int max_rate = hdmi->max_frl_rate;
 	int lanes = max_rate < 24 ? 3 : 4;
+	int port_clock;
 
 	frl_dfm.config.pixel_clock_nominal_khz = mode->clock;
 	frl_dfm.config.hactive = mode->hdisplay;
@@ -2064,7 +2080,9 @@ intel_hdmi_frl_mode_clock_valid(struct intel_connector *connector,
 	if (!intel_hdmi_frl_dfm_nondsc_requirement_met(&frl_dfm))
 		return MODE_CLOCK_HIGH;
 
-	return MODE_OK;
+	port_clock = FRL_GBPS_TO_10KBPS(max_rate / lanes);
+
+	return hdmi_port_frl_clock_valid(hdmi, port_clock);
 }
 
 static enum drm_mode_status
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index 6e0b5fb1930a..a70b56258cd4 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -85,4 +85,7 @@ int intel_hdmi_sink_max_frl_rate(struct drm_connector *connector);
 int intel_hdmi_sink_dsc_max_frl_rate(struct drm_connector *connector);
 void intel_hdmi_frl_cfg_write(const struct intel_crtc_state *crtc_state);
 
+/* FRL rate per lane (Gbps) -> PHY PLL table units (10 kbps) */
+#define FRL_GBPS_TO_10KBPS(rate)	((rate) * 100000)
+
 #endif /* __INTEL_HDMI_H__ */
-- 
2.50.1

