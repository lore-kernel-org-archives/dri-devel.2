Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A3BCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 715EC10E81F;
	Mon, 12 Oct 2026 04:15:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0014610E96E;
 Mon, 12 Oct 2026 04:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778543; x=1823314543;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rgVM8+L9hJd8uHCiUfsd8tJ1s6bM7lgacSUbNICUeJM=;
 b=FzrL0dddmbvpdYfTvr0M9qsQslvUts0jTYSsimdP08qvIXBOHWafPLJM
 QINf37xJSp6ss66G1x1RrVnvLqUBIlIzVlffw/W6YINLemspLRbdYY3Xh
 bu2qwdMtdrLb/huMXI5S8jjYa8U/sBzWLJPAnVVgJjUPuRklI/wIZJYTU
 uCMPiAsjED2/pLJmfwnQ5fMr8dZsj1HgSWtceK9ejW8wn4QvUCdMN+E0i
 3evawauC7P4PRgSJgwLZYLsxXhCWJVgF3D9TvoWPQnI4/cGwTtMHem4Os
 6cBsE9fQdYtdImu7ApVX3Qlpb3mL3ExbCDvhlTbZg2LC9GsiyhUN1qCIe Q==;
X-CSE-ConnectionGUID: oVzt3YLxQA6v0i/rZu9Zyw==
X-CSE-MsgGUID: PzH9D6isRG6cZKb5Jw5cIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380932"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380932"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:40 -0700
X-CSE-ConnectionGUID: PyaRmXcKRsqqORxPrqTpLQ==
X-CSE-MsgGUID: UH2MTS/oS0iaMkp9mmu5fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256621"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:39 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 38/56] drm/i915/hdmi: Add FRL clock computation based on DFM
Date: Mon, 12 Oct 2026 09:27:47 +0530
Message-ID: <20261012035806.3361439-39-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Compute the FRL port clock for a mode using the DFM helper.
Starting with the lowest FRL rate that meets the DFM requirements, check
if the mode can be supported with FRL and derive the port clock from the
selected FRL rate and lane count.

Use the min audio requirement (L-PCM 2ch/48KHz) to make sure FRL rate
chosen can support baseline audio. The pruning of un-supported audio is
handled as a separate change.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Signed-off-by: Vandita Kulkarni <vandita.kulkarni@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 118 +++++++++++++++++++++-
 1 file changed, 117 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 8e742165a50a..0391597c9847 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2306,13 +2306,129 @@ static int intel_hdmi_compute_tmds_clock(struct intel_encoder *encoder,
 	return 0;
 }
 
+static int
+intel_hdmi_compute_frl_config(struct intel_encoder *encoder,
+			      struct intel_crtc_state *crtc_state)
+{
+	static const int rate[] = {9, 18, 24, 32, 40, 48};
+	struct intel_hdmi_frl_dfm frl_dfm = {0};
+	struct intel_hdmi *intel_hdmi = enc_to_intel_hdmi(encoder);
+	struct intel_display *display = to_intel_display(crtc_state);
+	struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
+	int max_rate = intel_hdmi->max_frl_rate;
+	bool can_support_frl_mode = false;
+	int i;
+
+	/* Fill mode related input params */
+	frl_dfm.config.pixel_clock_nominal_khz = adjusted_mode->clock;
+	frl_dfm.config.hactive = adjusted_mode->hdisplay;
+	frl_dfm.config.hblank = adjusted_mode->htotal - adjusted_mode->hdisplay;
+
+	/* Fill color related input params */
+	frl_dfm.config.bpc = crtc_state->pipe_bpp / 3;
+	frl_dfm.config.color_format = get_drm_color_format(crtc_state->output_format);
+
+	/*
+	 * Using fixed 2ch / 48 kHz baseline makes the chosen rate carry video + basic
+	 * stereo (L-PCM), so the guaranteed floor is never pruned.
+	 * Since overhead is only a few packets/line, it almost never bumps the FRL rate,
+	 * but it avoids the situation where a rate is chosen with no room for audio gap.
+	 *
+	 * Everything above the baseline is decided by pruning the ELD at the committed
+	 * rate.
+	 */
+	frl_dfm.config.audio_hz = 48000;
+	frl_dfm.config.audio_channels = 2;
+
+	/*
+	 * Check if the resolution can be supported in FRL mode.
+	 * We try with the lowest FRL rate first — the minimum rate that
+	 * satisfies DFM requirements — for better SI margin and lower power.
+	 */
+	for (i = 0; i < ARRAY_SIZE(rate); i++) {
+		if (rate[i] > max_rate)
+			continue;
+		/* Fill the bw related input parameters */
+		frl_dfm.config.lanes = rate[i] < 24 ? 3 : 4;
+		frl_dfm.config.bit_rate_kbps = (rate[i] * 1000000) / frl_dfm.config.lanes;
+
+		if (intel_hdmi_frl_dfm_nondsc_requirement_met(&frl_dfm)) {
+			can_support_frl_mode = true;
+			break;
+		}
+	}
+
+	if (!can_support_frl_mode) {
+		memset(&crtc_state->frl, 0, sizeof(crtc_state->frl));
+		return -EINVAL;
+	}
+
+	/* Fill crtc_state frl DFM output params */
+	crtc_state->frl.required_lanes = frl_dfm.config.lanes;
+	crtc_state->frl.required_rate = frl_dfm.config.bit_rate_kbps / 1000000;
+	crtc_state->frl.tb_borrowed = frl_dfm.params.tb_borrowed;
+	crtc_state->frl.tb_actual = frl_dfm.params.tb_borrowed / 2;
+	drm_dbg_kms(display->drm, "FRL DFM config: tb_borrowed = %d, tb_actual = %d\n",
+		    crtc_state->frl.tb_borrowed, crtc_state->frl.tb_actual);
+
+	if (frl_dfm.params.tb_borrowed && (frl_dfm.params.tb_borrowed / 2) <= 492)
+		crtc_state->frl.tb_threshold_min = 492 - (frl_dfm.params.tb_borrowed / 2);
+	else
+		crtc_state->frl.tb_threshold_min = 492;
+
+	/*
+	 * TODO
+	 * 1. Calculate condition for Reseource based scheduling enable.
+	 * Disabling resource based scheduling for now.
+	 * 2. Active Character buffer threshold depends on cd clock bw.
+	 * Setting default value of 0.
+	 */
+	crtc_state->frl.rsrc_sched_en = false;
+	crtc_state->frl.active_char_buf_threshold = 0;
+
+	return 0;
+}
+
+static int
+intel_hdmi_compute_frl_clock(struct intel_encoder *encoder,
+			     struct intel_crtc_state *crtc_state)
+{
+	struct intel_hdmi *hdmi = enc_to_intel_hdmi(encoder);
+	int max_bpc = max(crtc_state->pipe_bpp / 3, 8);
+	int port_clock;
+	int bpc;
+
+	for (bpc = max_bpc; bpc >= 8; bpc -= 2) {
+		int ret;
+
+		if (!hdmi_bpc_possible(crtc_state, bpc))
+			continue;
+
+		crtc_state->pipe_bpp = bpc * 3;
+
+		ret = intel_hdmi_compute_frl_config(encoder, crtc_state);
+		if (ret)
+			continue;
+
+		/* Port clock for FRL rates is bitrate in 10Kbps */
+		port_clock = FRL_GBPS_TO_10KBPS(crtc_state->frl.required_rate);
+
+		if (hdmi_port_frl_clock_valid(hdmi, port_clock) == MODE_OK) {
+			crtc_state->port_clock = port_clock;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int intel_hdmi_compute_clock(struct intel_encoder *encoder,
 				    struct intel_crtc_state *crtc_state,
 				    bool respect_downstream_limits,
 				    bool enable_frl)
 {
 	if (enable_frl)
-		return -EINVAL;
+		return intel_hdmi_compute_frl_clock(encoder, crtc_state);
 
 	return intel_hdmi_compute_tmds_clock(encoder, crtc_state, respect_downstream_limits);
 }
-- 
2.50.1

