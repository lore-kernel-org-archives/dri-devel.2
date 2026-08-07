Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D86C2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEFD210F350;
	Fri,  7 Aug 2026 04:31:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="E7QEJrxs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2834C10F349;
 Fri,  7 Aug 2026 04:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077092; x=1817613092;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VyL5SRfscyvQK6Oe9/rhtwTlSz5NQxJTIXROjeSb/wE=;
 b=E7QEJrxsX4tV2g+Vfofk9+VhyBlg1klxilvzdIY7hg2LsIOS4fZsKYff
 H7i63Cfx8RsjzJjzpRZXhoX3STdk8DR7EagDeGOy0L7eRlmAEu7pumxx7
 qNQ9LTZL/V7NxdFUQcz/iMg63bCNi5HnVFgwcc97N807DLN0CAc9MwBxi
 MH4XVSE3C+xO8eIz9CUIObebxCsrbamp9thUzUCYEpM2jkXk7v0YyYDL6
 XY8ixeYw4O4iBHqqY8g3Kk4u3dN0vjg+cu/USrewH1xJxxZStadvCIfBH
 gj4g/Uwx9wOitVMRxLDjPz2J8MZWlnDyqNj2v+jo69XO9q9L7NDD+T+pI g==;
X-CSE-ConnectionGUID: qO5LqCoYQD+KDO+YWcDueQ==
X-CSE-MsgGUID: 5PDRdq0+T+O2kk+yALRNUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619235"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619235"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:32 -0700
X-CSE-ConnectionGUID: Ggk2TfxAR9WwCWsDKjJeRA==
X-CSE-MsgGUID: 0DzjlOxVSkS2f5zCFx28Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666040"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:29 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 02/44] drm/i915/hdmi: Add new data members for FRL
 configuration
Date: Fri,  7 Aug 2026 09:43:47 +0530
Message-ID: <20260807041430.229038-3-ankit.k.nautiyal@intel.com>
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
index 20a07ea06b5e..76fa6debb852 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1687,8 +1687,17 @@ struct intel_hdmi {
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
index 9b637e38a1a5..65d91fc9f9ce 100644
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
+		DIV_ROUND_UP(intel_bios_hdmi_max_frl_rate(encoder), 1000000) * 4;
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

