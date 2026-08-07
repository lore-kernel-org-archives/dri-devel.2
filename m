Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D080C5AC9F
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D629610F3CF;
	Fri,  7 Aug 2026 04:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="D4E8W7Zh";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B7B010F3CF;
 Fri,  7 Aug 2026 04:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077174; x=1817613174;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=gn8yuCCVT8L+aqyvW7e0HgyiMAegHfB5ya3ip9SMQ64=;
 b=D4E8W7Zh7KIhVfVni5vyjg6/VTFhbsh5CAZftsSvb60Y5vclZIreV4v3
 EJ1cnzljPToivPlg2UMc5nIrujEPqZNjmOQWP/fhFdWpisPPFBSEzpPeL
 R9wzmo1RqFoInLhiNvnW6jQuoiSenNQcw5EBWhVuCk0/zyUrHLZ+1a7wi
 WqA4bCvO0yXMxWEep0/ZX5To9CZpwwzMYumcRjGUG9vtMWSl+DFZcniwc
 tc9rmGemIv3o+uPbqz5AR4GRdU+X4N17fJIjqKT9iyFLAeM2VQ6ya90MO
 gcNnoyAhvBsAea9KwSXA9/eHwJ0N6mkwIx0mIiVOqKMxo7IDU1N+bLlBm g==;
X-CSE-ConnectionGUID: U9oXlK6sQO6CQaLbBCGlfA==
X-CSE-MsgGUID: XxNKPHzOQBqHU73M5F6yBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619368"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619368"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:54 -0700
X-CSE-ConnectionGUID: a2dBuIwRQWG+k/+aqdcYrg==
X-CSE-MsgGUID: 8IIE/HvgTwq7P2KbZlTuhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666519"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:52 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 34/44] drm/i915/hdmi: Add helper to write FRL CFG register
Date: Fri,  7 Aug 2026 09:44:19 +0530
Message-ID: <20260807041430.229038-35-ankit.k.nautiyal@intel.com>
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

Introduce helpers to write FRL CFG refister bits.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 16 ++++++++++++++++
 drivers/gpu/drm/i915/display/intel_hdmi.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 7170546f4779..4d547c27914c 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3992,3 +3992,19 @@ void intel_hdmi_disable_frl(struct intel_encoder *encoder,
 
 	intel_hdmi_reset_frl_config(intel_hdmi);
 }
+
+void intel_hdmi_frl_cfg_write(const struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(crtc_state);
+	enum transcoder cpu_trans = crtc_state->cpu_transcoder;
+	u32 val;
+
+	if (!crtc_state->frl.enable)
+		return;
+
+	val = TRANS_HDMI_R_B_SCHED_ENABLE(crtc_state->frl.rsrc_sched_en);
+	val |= TRANS_HDMI_ACTIVE_CHAR_BUF_THRESH(crtc_state->frl.active_char_buf_threshold);
+	val |= TRANS_HDMI_MIN_BLANK_CHAR(TRANS_HDMI_MIN_BLANK_CHAR_VAL);
+
+	intel_de_rmw(display, TRANS_HDMI_FRL_CFG(display, cpu_trans), 0, val);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index 0e78e700ebf9..41d0a850ec76 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -82,6 +82,7 @@ void intel_hdmi_poll_for_scrambling_enable(const struct intel_crtc_state *crtc_s
 					   struct drm_connector *_connector);
 int intel_hdmi_sink_max_frl_rate(struct drm_connector *connector);
 int intel_hdmi_sink_dsc_max_frl_rate(struct drm_connector *connector);
+void intel_hdmi_frl_cfg_write(const struct intel_crtc_state *crtc_state);
 
 /* FRL rate per lane (Gbps) -> PHY PLL table units (10 kbps) */
 #define FRL_GBPS_TO_10KBPS(rate)	((rate) * 100000)
-- 
2.50.1

