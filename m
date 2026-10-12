Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC2CCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A0A10E4AB;
	Mon, 12 Oct 2026 04:15:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F186310E4A0;
 Mon, 12 Oct 2026 04:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778517; x=1823314517;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0Ypuq7fqdD9DAYBxDEu7c19u0W9y65zyOmL+IDYNbYA=;
 b=bvdEUuGSJpWwIh/VnOQuk5gXjpvJRSXnuAtao8Dl3drwDlK8IiOBwISX
 iCE3XwEYtDJqE4SNzSBAwJLF/EsKBf7MjOw8XfzVYbXFnHun4G9U8FnwR
 zIHJDFWfDcNk3s6obDWiVRIbL8tOeyCMYuRokxKhToJlKr8I0k91oYtnm
 VJ1E4JfYgpY7i92vTq9E2bug01rSyf/GtxlkvQJAK+eKXviT+2LeN6vye
 AMfs6OPkFvuh51k+5OCcuPfJGDn5P5fvGyBZB5edZCGQ/0ljj/o+DyU25
 g8v5/YR5N5C0UbOjv7qKvm1igoY/POgQkDPWCJAGm3LO7uTRXTMYOTfD/ Q==;
X-CSE-ConnectionGUID: g89IiGH0SeKmiUHhGELHsA==
X-CSE-MsgGUID: UsMWwr4fRH+M5yhJ4NKpBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380901"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380901"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:08 -0700
X-CSE-ConnectionGUID: dFf3wQpUSnO6SH0pPorDqw==
X-CSE-MsgGUID: JDJREh/lQvGrsTiLGT4BEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256492"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:07 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 24/56] drm/i915/hdmi: Add provision for FRL mode while
 computing output format
Date: Mon, 12 Oct 2026 09:27:33 +0530
Message-ID: <20261012035806.3361439-25-ankit.k.nautiyal@intel.com>
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

Add a check in compute_config to select FRL mode when TMDS cannot
support the required bandwidth, passing frl_mode flag to the output
format computation.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 34 +++++++++++++++++------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 1aa6f71fbfce..bfec1a808af5 100644
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

