Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89EBCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE57910EC77;
	Mon, 12 Oct 2026 04:16:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E5B10EC71;
 Mon, 12 Oct 2026 04:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778581; x=1823314581;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IU/zhr2QsHJtJ5jSJxFiT1t4DfN2GLA5aDFFoQBFNn0=;
 b=PBoD+5oaZrulSeSF+0cFbcjLuih7r3LBo6Mpo20cQiIUAsnkeZbOT2nF
 cnhsotFx3X22e/drgZ+ymosU6DKuaIn1EQQp6/wtfMbXYoUvnX5lfQ41p
 f2NojO01TrAF6uI8xRRfJ7fLo0DmmJMGS1QUy5SBsSPY22+9giUkfXDlw
 WMMaEwrGTyOiO37s41Wdq138pqdbc1SU+8dFiRGsB79+HLPmtcG3SoQCo
 dz11UWKFCTGw7btf0yGhqEIe5rpSqlx9p7nMcobMyboOPUi7oI8P9Dbqs
 kBMe1khjj4WAaL4FryNs9uSuQTcAtvnNvjBYsCm2c4zIMWsRe1GMksd9J w==;
X-CSE-ConnectionGUID: Q0vB/2qUSnWZmaVd1Wu9Mw==
X-CSE-MsgGUID: toT40Mc8Rv2Zcv3og1CJQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="366217"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="366217"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:21 -0700
X-CSE-ConnectionGUID: Rv0suIQcRa61l5Rp+X6GRA==
X-CSE-MsgGUID: M73uFgdTQkKaxynHNVM8UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256837"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:19 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 55/56] drm/i915/hdmi: Iterate through joiner candidates in
 mode_valid path
Date: Mon, 12 Oct 2026 09:28:04 +0530
Message-ID: <20261012035806.3361439-56-ankit.k.nautiyal@intel.com>
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

Modes exceeding a single pipe's dotclock were rejected in mode_valid even
when they could be driven by joining pipes. Iterate the joiner candidates
and allow a mode if it fits with joining, relaxing the dotclock ceiling by
the joined pipe count. Joiner configs needing DSC are pruned for
now, since HDMI DSC comes later.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 51 ++++++++++++++++++-----
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 2ec7d2a5e7d4..2c7c47a3c61d 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2132,20 +2132,55 @@ intel_hdmi_mode_valid_format(struct intel_connector *connector,
 	struct intel_display *display = to_intel_display(connector);
 	struct intel_hdmi *hdmi = intel_attached_hdmi(connector);
 	enum drm_mode_status status;
+	int num_joined_pipes;
 
 	status = intel_hdmi_sink_format_valid(connector, mode,
 					      has_hdmi_sink, sink_format);
 	if (status != MODE_OK)
 		return status;
 
-	status = intel_pfit_mode_valid(display, mode, sink_format, 0);
-	if (status != MODE_OK)
+	status = intel_hdmi_tmds_mode_clock_valid(&connector->base, clock,
+						  has_hdmi_sink, sink_format);
+
+	if (status == MODE_OK)
+		return status;
+
+	/*
+	 * Joiner is supported only with FRL mode.
+	 * If a mode is not supported with TMDS and FRL is not supported,
+	 * prune the mode.
+	 */
+	if (status != MODE_OK && !intel_hdmi_can_support_frl(hdmi))
 		return status;
 
-	status = intel_hdmi_tmds_mode_clock_valid(&connector->base, clock, has_hdmi_sink, sink_format);
+	for_each_joiner_candidate(connector, mode, num_joined_pipes) {
+		if (intel_joiner_needs_dsc(display, num_joined_pipes)) {
+			status = MODE_CLOCK_HIGH;
+			continue;
+		}
+
+		status = intel_pfit_mode_valid(display, mode, sink_format,
+					       num_joined_pipes);
+		if (status != MODE_OK)
+			continue;
+
+		status = intel_mode_valid_max_plane_size(display, mode,
+							 num_joined_pipes);
+		if (status != MODE_OK)
+			continue;
+
+		if (!intel_dp_dotclk_valid(display, clock, mode->htotal, 0,
+					   num_joined_pipes)) {
+			status = MODE_CLOCK_HIGH;
+			continue;
+		}
 
-	if (status != MODE_OK && intel_hdmi_can_support_frl(hdmi))
 		status = intel_hdmi_frl_mode_clock_valid(connector, mode, sink_format);
+		if (status != MODE_OK)
+			continue;
+
+		break;
+	}
 
 	return status;
 }
@@ -2160,7 +2195,6 @@ intel_hdmi_mode_valid(struct drm_connector *_connector,
 	const struct drm_display_info *info = &connector->base.display_info;
 	enum drm_mode_status status;
 	int clock = mode->clock;
-	int max_dotclk = display->cdclk.max_dotclk_freq;
 	bool has_hdmi_sink = intel_has_hdmi_sink(hdmi, connector->base.state);
 
 	status = intel_cpu_transcoder_mode_valid(display, mode);
@@ -2170,9 +2204,6 @@ intel_hdmi_mode_valid(struct drm_connector *_connector,
 	if ((mode->flags & DRM_MODE_FLAG_3D_MASK) == DRM_MODE_FLAG_3D_FRAME_PACKING)
 		clock *= 2;
 
-	if (clock > max_dotclk)
-		return MODE_CLOCK_HIGH;
-
 	if (mode->flags & DRM_MODE_FLAG_DBLCLK) {
 		if (!has_hdmi_sink)
 			return MODE_CLOCK_LOW;
@@ -2197,10 +2228,8 @@ intel_hdmi_mode_valid(struct drm_connector *_connector,
 			status = intel_hdmi_mode_valid_format(connector, mode, clock, has_hdmi_sink,
 							      INTEL_OUTPUT_FORMAT_YCBCR420);
 	}
-	if (status != MODE_OK)
-		return status;
 
-	return intel_mode_valid_max_plane_size(display, mode, 1);
+	return status;
 }
 
 bool intel_hdmi_bpc_possible(const struct intel_crtc_state *crtc_state,
-- 
2.50.1

