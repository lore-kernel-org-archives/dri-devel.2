Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85205CA9ED9
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEE6710E32D;
	Mon, 12 Oct 2026 04:14:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75B0A10E32D;
 Mon, 12 Oct 2026 04:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778459; x=1823314459;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8niptzHTjhJDKB8AkTHTPlpKLVY4Fz+4YWxeOgNqT1c=;
 b=JZiFdhT37vmaucNeVBuxMmvbMjkEN+Zdi+bVLRcj1K9+p7F5zeKQK3Pt
 pXd7C4JV/0COzvP6v3xhvQukloEpHegA+AXaeawE/YaOWUY3gMA+QRdro
 /5YrdQpdKUEZS+RrJPzbad+87xQwumal9NSNzlTduhx1/Z+ymAm1bnDVV
 K+4neGZxGHQaVG/U0oC3aQN/+pS8OKIzD4JTVfsEIjQoBPZLcZEXZVIeu
 mwhfjwmeorTHTRAODZoGO8eb2C2aR/jdj5G3n8dfUrs+Lyo1SXLJ//Q14
 kVMiygpyWv49GfbYLHDhLehvn7bGsSZLoM5vxhIZGXDLDOpyxRwm1kz2a w==;
X-CSE-ConnectionGUID: heb8aLtbRtmWbZ9ZMnL99g==
X-CSE-MsgGUID: AYTf0dN4QGeRQ8dT3bT6kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380808"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380808"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:19 -0700
X-CSE-ConnectionGUID: i3R+9wTrQbqIHDkj6MKctg==
X-CSE-MsgGUID: awTHxqSFSpiKZeRiYr/eGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256319"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:17 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 02/56] drm/i915/hdmi: Add new data members for FRL
 configuration
Date: Mon, 12 Oct 2026 09:27:11 +0530
Message-ID: <20261012035806.3361439-3-ankit.k.nautiyal@intel.com>
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

HDMI supports higher resolutions using Fixed Rate Link.
Source needs to do FRL link training on the 4 lanes before video
stream transmission.

Add the members to crtc_state and intel_hdmi for identifying the FRL
supporting HDMI sink and to maintain the FRL training information after
successful training.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../drm/i915/display/intel_display_types.h    |  9 +++++
 drivers/gpu/drm/i915/display/intel_hdmi.c     | 36 +++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 79f30660c2b6..89333c9ddcc8 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1709,8 +1709,17 @@ struct intel_hdmi {
 		enum drm_dp_dual_mode_type type;
 		int max_tmds_clock;
 	} dp_dual_mode;
+	bool has_sink_hdmi_21;
+	int max_frl_rate;
+	int max_dsc_frl_rate;
 	struct intel_connector *attached_connector;
 	struct cec_notifier *cec_notifier;
+	struct {
+		bool trained;
+		int lanes;
+		int rate_gbps;
+		int ffe_level;
+	} frl;
 };
 
 struct intel_dp_mst_encoder;
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index b6fa1a1558b8..69534eea78a1 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2485,6 +2485,8 @@ intel_hdmi_unset_edid(struct drm_connector *_connector)
 	struct intel_connector *connector = to_intel_connector(_connector);
 	struct intel_hdmi *intel_hdmi = intel_attached_hdmi(connector);
 
+	intel_hdmi->has_sink_hdmi_21 = false;
+
 	intel_hdmi->dp_dual_mode.type = DRM_DP_DUAL_MODE_NONE;
 	intel_hdmi->dp_dual_mode.max_tmds_clock = 0;
 
@@ -2545,6 +2547,38 @@ intel_hdmi_dp_dual_mode_detect(struct drm_connector *_connector)
 	}
 }
 
+static void
+intel_hdmi_reset_frl_config(struct intel_hdmi *intel_hdmi)
+{
+	intel_hdmi->frl.trained = false;
+	intel_hdmi->frl.lanes = 0;
+	intel_hdmi->frl.rate_gbps = 0;
+	intel_hdmi->frl.ffe_level = 0;
+}
+
+static void
+intel_hdmi_init_frl_config(struct intel_connector *connector)
+{
+	struct intel_hdmi *intel_hdmi = intel_attached_hdmi(connector);
+	struct intel_encoder *encoder = &hdmi_to_dig_port(intel_hdmi)->base;
+	int max_src_frl_rate =
+		DIV_ROUND_UP(intel_bios_hdmi_max_frl_rate(encoder->devdata), 1000000) * 4;
+	int max_sink_dsc_frl_rate =
+		intel_hdmi_sink_dsc_max_frl_rate(&connector->base);
+	int max_sink_frl_rate =
+		intel_hdmi_sink_max_frl_rate(&connector->base);
+
+	intel_hdmi->has_sink_hdmi_21 = max_sink_frl_rate > 0;
+
+	intel_hdmi->max_frl_rate = min(max_sink_frl_rate,
+				       max_src_frl_rate);
+
+	intel_hdmi->max_dsc_frl_rate = min(max_sink_dsc_frl_rate,
+					   max_src_frl_rate);
+
+	intel_hdmi_reset_frl_config(intel_hdmi);
+}
+
 static bool
 intel_hdmi_set_edid(struct drm_connector *_connector)
 {
@@ -2576,6 +2610,8 @@ intel_hdmi_set_edid(struct drm_connector *_connector)
 	if (drm_edid_is_digital(drm_edid)) {
 		intel_hdmi_dp_dual_mode_detect(&connector->base);
 
+		intel_hdmi_init_frl_config(connector);
+
 		connected = true;
 	}
 
-- 
2.50.1

