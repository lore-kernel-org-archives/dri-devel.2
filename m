Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709D2CA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A1D010E957;
	Mon, 12 Oct 2026 04:16:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7A4B10EAC6;
 Mon, 12 Oct 2026 04:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778550; x=1823314550;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Gi1/Kf39ooHGqZM4NV3KIqGLWzJh58XBJUVd+2U7+S4=;
 b=bYUAvYL9CJCww44VuSZBgi2wNXDmkpK2wJpy4Ivhz5Js4v9jsZX515zV
 pmKPsviAvKOVcYINGiPKVqyE5TBH5NUlPTVKv3hOqkHtNFhUXBc7HrLfw
 ppZNmYM9C8Z22GFFzPDzBQm6H0fUNlVaqdjBCBIrPaKKpDdOyVR8ix6Uj
 A4WfuBDIm7XPlVTGMsDn7jfhmeSkjfXpv8NTR3iBLIlkgRqmM+hhp5WUl
 4heGv7/A1U9BcFTOehEZMc+Adldjs8YBbXPklKszCTCddTK5PGD/VsFwI
 ZGnWI5JwGZET9UCPRS6VRDU6XnPUrz5zVzQMe6O9hPNAH002ntuRunIvd g==;
X-CSE-ConnectionGUID: ZgO2fTZUTgySPXcF1FxTEg==
X-CSE-MsgGUID: SMO6zdU9RJOwXuokM+SWpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380940"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380940"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:49 -0700
X-CSE-ConnectionGUID: qfeXwfXgSsqv8OeRYZbQbw==
X-CSE-MsgGUID: D8gFZ0RjQDKkptcbFvRkIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256673"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:48 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 42/56] drm/i915/hdmi: Add read out for FRL state
Date: Mon, 12 Oct 2026 09:27:51 +0530
Message-ID: <20261012035806.3361439-43-ankit.k.nautiyal@intel.com>
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

Read out the FRL configuration and Data Flow Metering registers and
fill the FRL members in crtc_state.

In subsequent changes these are added to the state checker and compared
bwteen two crtc_states in intel_pipe_config_compare().

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c  |  3 ++
 drivers/gpu/drm/i915/display/intel_hdmi.c | 35 +++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_hdmi.h |  1 +
 3 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 22a49eb50b20..f7cbe330e19e 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4302,6 +4302,9 @@ static void intel_ddi_get_config(struct intel_encoder *encoder,
 	intel_dip_sdp_transmission_line_get_config(pipe_config);
 
 	intel_audio_codec_get_config(encoder, pipe_config);
+
+	if (intel_crtc_has_type(pipe_config, INTEL_OUTPUT_HDMI))
+		intel_hdmi_frl_get_config(pipe_config);
 }
 
 void intel_ddi_get_clock(struct intel_encoder *encoder,
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 69612ebe80f0..c5f25d2d6331 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -4160,3 +4160,38 @@ void intel_hdmi_frl_cfg_write(const struct intel_crtc_state *crtc_state)
 
 	intel_de_rmw(display, TRANS_HDMI_FRL_CFG(display, cpu_trans), 0, val);
 }
+
+static void intel_hdmi_frl_cfg_read(struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	enum transcoder cpu_trans = crtc_state->cpu_transcoder;
+	u32 val;
+
+	val = intel_de_read(display, TRANS_HDMI_FRL_CFG(display, cpu_trans));
+
+	if (val & TRANS_HDMI_FRL_ENABLE)
+		crtc_state->frl.enable = true;
+
+	crtc_state->frl.rsrc_sched_en =
+		REG_FIELD_GET(TRANS_HDMI_R_B_SCHED_ENABLE_MASK, val);
+	crtc_state->frl.active_char_buf_threshold =
+		REG_FIELD_GET(TRANS_HDMI_ACTIVE_CHAR_BUF_THRESH_MASK, val);
+}
+
+void intel_hdmi_frl_get_config(struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+
+	if (!HAS_HDMI_FRL(display))
+		return;
+
+	intel_hdmi_frl_cfg_read(crtc_state);
+
+	if (!crtc_state->frl.enable)
+		return;
+
+	crtc_state->frl.required_rate = crtc_state->port_clock / 100000;
+	crtc_state->frl.required_lanes = crtc_state->lane_count;
+
+	intel_hdmi_frl_dfm_read(crtc_state);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index a70b56258cd4..305ee1186d0b 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -84,6 +84,7 @@ void intel_hdmi_poll_for_scrambling_enable(const struct intel_crtc_state *crtc_s
 int intel_hdmi_sink_max_frl_rate(struct drm_connector *connector);
 int intel_hdmi_sink_dsc_max_frl_rate(struct drm_connector *connector);
 void intel_hdmi_frl_cfg_write(const struct intel_crtc_state *crtc_state);
+void intel_hdmi_frl_get_config(struct intel_crtc_state *crtc_state);
 
 /* FRL rate per lane (Gbps) -> PHY PLL table units (10 kbps) */
 #define FRL_GBPS_TO_10KBPS(rate)	((rate) * 100000)
-- 
2.50.1

