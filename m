Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2558C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72E5510F3EA;
	Fri,  7 Aug 2026 04:33:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FEvXEJk6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6478210F3EA;
 Fri,  7 Aug 2026 04:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077189; x=1817613189;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ju+7p7XKNByosmUCgjLZS2zBlc/LKItxqNN1eplmTzE=;
 b=FEvXEJk6dFbE8Si+JFgEdwZVKZNDK+tkyv1rM+OrKRAjMuZXqwnY3OF8
 ljR3dLBxiHYZuLdr/b4RgonGE25FvEMG90+3boRQcVHVB56N23Oq+ofVo
 uuHNCJdwrIoY6xdS1BSJm1S1jRUV1Lzjg2V9XdtHsZfPhfqlM318BJ6M2
 2cTw28dmsAFYcDTvtAYJlKDVb/qcrQYqE/jYXKBi+UIFjdI0LPfklez4X
 X0LfNc4/zGal2QzsG2fgjalzZpWlraMT5/nEv6hgLq+wreAYWhA6mfQ0m
 ogp+479EfAetNej7v8JFUUIVB5sCH79KKxgMYQEIqfXp3oi6KCsSdGm8Z A==;
X-CSE-ConnectionGUID: xi/qBnEnTb2TticigkJkFw==
X-CSE-MsgGUID: Y6R5OMt7Qey+KHj3teip4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619392"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619392"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:09 -0700
X-CSE-ConnectionGUID: tg6MCi29RwGhaE2ZrKZlSA==
X-CSE-MsgGUID: 17lFVdZRSdqL4o68EQJl+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666587"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:33:06 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 40/44] drm/i915/hdmi: Add read out for FRL state
Date: Fri,  7 Aug 2026 09:44:25 +0530
Message-ID: <20260807041430.229038-41-ankit.k.nautiyal@intel.com>
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
index 6ee2c3119c9b..fc465683782a 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4281,6 +4281,9 @@ static void intel_ddi_get_config(struct intel_encoder *encoder,
 	intel_read_dp_sdp(encoder, pipe_config, DP_SDP_ADAPTIVE_SYNC);
 
 	intel_audio_codec_get_config(encoder, pipe_config);
+
+	if (intel_crtc_has_type(pipe_config, INTEL_OUTPUT_HDMI))
+		intel_hdmi_frl_get_config(pipe_config);
 }
 
 void intel_ddi_get_clock(struct intel_encoder *encoder,
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index e30adda6dac2..05d3bb40ca30 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -4099,3 +4099,38 @@ void intel_hdmi_frl_cfg_write(const struct intel_crtc_state *crtc_state)
 
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
index 41d0a850ec76..cf5ccd308ce6 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -83,6 +83,7 @@ void intel_hdmi_poll_for_scrambling_enable(const struct intel_crtc_state *crtc_s
 int intel_hdmi_sink_max_frl_rate(struct drm_connector *connector);
 int intel_hdmi_sink_dsc_max_frl_rate(struct drm_connector *connector);
 void intel_hdmi_frl_cfg_write(const struct intel_crtc_state *crtc_state);
+void intel_hdmi_frl_get_config(struct intel_crtc_state *crtc_state);
 
 /* FRL rate per lane (Gbps) -> PHY PLL table units (10 kbps) */
 #define FRL_GBPS_TO_10KBPS(rate)	((rate) * 100000)
-- 
2.50.1

