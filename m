Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FAFACA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 045F110E4A1;
	Mon, 12 Oct 2026 04:16:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D086210E960;
 Mon, 12 Oct 2026 04:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778564; x=1823314564;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9eWEKUkjU64MvxFOcbx7+5GhX9gr1LDBcd+41y1bDe4=;
 b=U2zBOI4BbzF43mI4SrjxwBkzagmNMUzP7FUgsnXXoZkArEA59r4WBW9I
 Tw9WGepnCH1rOqw5/loqxyztwWvi6vLkvYsKZ8bSsMd9pRxb1DF3zGMb8
 89LEQhFq6/hgq1qDx4GpDXsRfpFrNPDGcja3YLI71K2KZqHWpIreOdv2F
 puzY2hYKEvYxIm328TJmTI+TnQt0ro0vJvVlLkrStrJI5aMsExp0ykAaq
 KSlHAi+8VG1sKfpTob9XllzpOWdwnHe+PZiTfDYyZwdkpVA5S8Hqpoe+k
 MrF3dcxBO9VnZ3EQLfr3dPzvTfo+OPx9EGsABi4Azu6iBEjfc4F1UkFw/ Q==;
X-CSE-ConnectionGUID: 3pb7+NuNTmqBnJ50dEUF5w==
X-CSE-MsgGUID: q0vEPeUCS6O3v+DL1kFFPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380949"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380949"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:03 -0700
X-CSE-ConnectionGUID: MRtJAmGUQvezXgHD5kKBgg==
X-CSE-MsgGUID: R03zGUutSECSR0Qynvu3Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256750"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:02 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 48/56] drm/i915/hdmi: Add a helper to check non DSC audio
 support for HDMI FRL
Date: Mon, 12 Oct 2026 09:27:57 +0530
Message-ID: <20261012035806.3361439-49-ankit.k.nautiyal@intel.com>
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

For HDMI TMDS we need to check if the Hblank tribytes are sufficient for
HDMI audio packets tribytes for a given audio configuration.

For FRL we need to check the above and also that the whole line meets
the line budget for a given FRL rate.

Add a helper to check whether a given audio configuration (L-PCM sample
rate + channel count) fits the committed non DSC FRL video config, using
the FRL DFM.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 22 ++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_hdmi.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 425971d8927a..c57d99195ed0 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2341,6 +2341,28 @@ compute_frl_mn(struct intel_crtc_state *crtc_state, u32 ftb_avg_k)
 	crtc_state->frl.div18 = DIV_ROUND_UP_ULL(div_18_clk, 1000);
 }
 
+bool intel_hdmi_frl_audio_rate_supported(const struct intel_crtc_state *crtc_state,
+					 int audio_rate, int channels)
+{
+	const struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
+	struct intel_hdmi_frl_dfm frl_dfm = {};
+
+	frl_dfm.config.pixel_clock_nominal_khz = adjusted_mode->clock;
+	frl_dfm.config.hactive = adjusted_mode->hdisplay;
+	frl_dfm.config.hblank = adjusted_mode->htotal - adjusted_mode->hdisplay;
+	frl_dfm.config.bpc = crtc_state->pipe_bpp / 3;
+	frl_dfm.config.color_format = get_drm_color_format(crtc_state->output_format);
+
+	frl_dfm.config.lanes = crtc_state->frl.required_lanes;
+	frl_dfm.config.bit_rate_kbps = crtc_state->frl.required_rate * 1000000;
+
+	/* Audio config under test */
+	frl_dfm.config.audio_hz = audio_rate;
+	frl_dfm.config.audio_channels = channels;
+
+	return intel_hdmi_frl_dfm_nondsc_requirement_met(&frl_dfm);
+}
+
 static int
 intel_hdmi_compute_frl_config(struct intel_encoder *encoder,
 			      struct intel_crtc_state *crtc_state)
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index 305ee1186d0b..71b12f557d75 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -63,6 +63,8 @@ int intel_hdmi_dsc_get_num_slices(const struct drm_display_mode *mode,
 				  int hdmi_max_slices, int hdmi_throughput);
 int intel_hdmi_dsc_get_slice_height(int vactive);
 bool intel_hdmi_is_frl(u32 clock);
+bool intel_hdmi_frl_audio_rate_supported(const struct intel_crtc_state *crtc_state,
+					 int audio_rate, int channels);
 void intel_hdmi_prepare_for_frl_mode(const struct intel_crtc_state *crtc_state);
 int intel_hdmi_start_frl(struct intel_encoder *encoder,
 			 const struct intel_crtc_state *crtc_state);
-- 
2.50.1

