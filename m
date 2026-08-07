Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED44AC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0B7310F385;
	Fri,  7 Aug 2026 04:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="c9kB4l80";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50D710F374;
 Fri,  7 Aug 2026 04:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077125; x=1817613125;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9oe1YILI6lT3N821gSlhl0H+uXnlsgZjCiWJ3o3+DlI=;
 b=c9kB4l80gq3mnKbim4et920abCl0ScHYNWvurOMGItATRXZwnFawQQ5x
 uqy159PFpd7WA0z5cBy86kwjUnkLvdqIMpdfgkOeZl8J2X2IADN/jd5TM
 +UHWiYgQEUkjDqVVztMMhg9kLZnl1VMzPGqHY1DFB8Teu30a73SIgz+FI
 TdNJ8YMJzD8NIp8OOn0kRlsGQYhAR1+gJC9ssST7i3Uq38FXlG6lEWu1Y
 uTCXkzHkvK6qbbXvEOfWGBBiB6NRepjBngBV0if4K8040EIU0nSyuhaMN
 MHfM5jW4RLCxPicVSnSPhb12ZCmY2kaZIqQOANGOpTwzLKylUJCJM7TNw A==;
X-CSE-ConnectionGUID: WLF588jbQOudCLrccCz3bg==
X-CSE-MsgGUID: eLTJx/s4SECrD42xW2Cf8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619269"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619269"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:04 -0700
X-CSE-ConnectionGUID: Zg+3239eQx6XIBouqlqHhg==
X-CSE-MsgGUID: IG9ibK/vRoq6Hjhdu9S5+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666160"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:00 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 14/44] drm/i915/hdmi: Add functions for FRL training state
 machine
Date: Fri,  7 Aug 2026 09:43:59 +0530
Message-ID: <20260807041430.229038-15-ankit.k.nautiyal@intel.com>
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

Add the FRL link training state machine and the helpers to drive it
with an HDMI FRL sink over SCDC: prepare for LTS:2, train the lanes in
LTS:3, complete training in LTS:P and fall back to legacy TMDS in LTS:L.

intel_hdmi_start_frl() drives these states for the requested rate and
lanes.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 258 ++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_hdmi.h |   2 +
 2 files changed, 260 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 96542869740e..ff200d662a3f 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3523,3 +3523,261 @@ void intel_hdmi_prepare_for_frl_mode(const struct intel_crtc_state *crtc_state)
 
 	intel_de_write(display, TRANS_HDMI_FRL_TRAIN(display, trans), write_buf);
 }
+
+static bool is_flt_ready(struct intel_encoder *encoder)
+{
+	struct intel_display *display = to_intel_display(encoder);
+	struct i2c_adapter *adapter =
+		intel_gmbus_get_adapter(display, intel_hdmi_ddc_pin(encoder));
+
+	return drm_scdc_read_status_flags(adapter) & SCDC_FLT_READY;
+}
+
+static u8 get_frl_update_flags(struct intel_encoder *encoder)
+{
+	struct intel_display *display = to_intel_display(encoder);
+	struct i2c_adapter *adapter =
+		intel_gmbus_get_adapter(display, intel_hdmi_ddc_pin(encoder));
+
+	return drm_scdc_read_update_flags(adapter);
+}
+
+static int clear_scdc_update_flags(struct intel_encoder *encoder, u8 flags)
+{
+	struct intel_display *display = to_intel_display(encoder);
+	struct i2c_adapter *adapter =
+		intel_gmbus_get_adapter(display, intel_hdmi_ddc_pin(encoder));
+
+	return drm_scdc_clear_update_flags(adapter, flags);
+}
+
+static bool
+intel_hdmi_frl_prepare_lts2(struct intel_encoder *encoder,
+			    int frl_rate, int frl_lanes,
+			    int ffe_level)
+{
+#define TIMEOUT_FLT_READY_MS 250
+	struct intel_display *display = to_intel_display(encoder);
+	struct i2c_adapter *adapter =
+		intel_gmbus_get_adapter(display, intel_hdmi_ddc_pin(encoder));
+	bool flt_ready = false;
+
+	if (!frl_rate || !frl_lanes)
+		return false;
+
+	if (read_poll_timeout(is_flt_ready, flt_ready,
+			      flt_ready, 1000,
+			      TIMEOUT_FLT_READY_MS * USEC_PER_MSEC,
+			      false, encoder)) {
+		drm_dbg_kms(display->drm,
+			    "HDMI sink not ready for FRL in %d\n",
+			    TIMEOUT_FLT_READY_MS);
+		return false;
+	}
+
+	if ((get_frl_update_flags(encoder) & SCDC_FLT_UPDATE))
+		clear_scdc_update_flags(encoder, SCDC_FLT_UPDATE);
+
+	/* #TODO: Source shall program TxFFE = 0 for all active lanes */
+
+	if (drm_scdc_config_frl(adapter, frl_rate, frl_lanes, ffe_level) < 0) {
+		drm_dbg_kms(display->drm,
+			    "Failed to write SCDC config regs for FRL\n");
+		return false;
+	}
+
+	return flt_ready;
+}
+
+enum frl_lt_status {
+	FRL_TRAINING_PASSED,
+	FRL_CHANGE_RATE,
+	FRL_TRAIN_CONTINUE,
+	FRL_TRAIN_RETRAIN,
+	FRL_TRAIN_STOP,
+};
+
+static int get_link_training_patterns(struct intel_encoder *encoder,
+				      enum drm_scdc_frl_ltp ltp[4])
+{
+	struct intel_display *display = to_intel_display(encoder);
+	struct i2c_adapter *adapter =
+		intel_gmbus_get_adapter(display, intel_hdmi_ddc_pin(encoder));
+
+	return drm_scdc_get_ltp(adapter, ltp);
+}
+
+static enum frl_lt_status
+intel_hdmi_train_lanes(struct intel_encoder *encoder,
+		       const struct intel_crtc_state *crtc_state,
+		       int ffe_level)
+{
+	struct intel_display *display = to_intel_display(encoder);
+	enum transcoder trans = crtc_state->cpu_transcoder;
+	int num_lanes = crtc_state->frl.required_lanes;
+	enum drm_scdc_frl_ltp ltp[4];
+	u32 write_buf = 0;
+	int lane;
+
+	if (!(get_frl_update_flags(encoder) & SCDC_FLT_UPDATE))
+		return FRL_TRAIN_CONTINUE;
+
+	if (get_link_training_patterns(encoder, ltp) < 0)
+		return FRL_TRAIN_STOP;
+
+	if (ltp[0] == ltp[1] && ltp[1] == ltp[2]) {
+		if (num_lanes == 3 || (num_lanes == 4 && ltp[2] == ltp[3])) {
+			if (ltp[0] == SCDC_FRL_NO_LTP)
+				return FRL_TRAINING_PASSED;
+			if (ltp[0] == SCDC_FRL_CHNG_RATE)
+				return FRL_CHANGE_RATE;
+		}
+	}
+
+	for (lane = 0; lane < num_lanes; lane++) {
+		if (ltp[lane] >= SCDC_FRL_LTP1 && ltp[lane] <= SCDC_FRL_LTP8)
+			write_buf |= TRANS_HDMI_FRL_LTP(ltp[lane], lane);
+		/* #TODO handle FFE change */
+		else if (ltp[lane] == SCDC_FRL_CHNG_FFE)
+			continue;
+	}
+
+	intel_de_write(display, TRANS_HDMI_FRL_TRAIN(display, trans), write_buf);
+
+	clear_scdc_update_flags(encoder, SCDC_FLT_UPDATE);
+
+	return FRL_TRAIN_CONTINUE;
+}
+
+static enum frl_lt_status
+frl_train_complete_ltsp(struct intel_encoder *encoder,
+			const struct intel_crtc_state *crtc_state)
+{
+#define FLT_UPDATE_TIMEOUT_MS 200
+	struct intel_display *display = to_intel_display(encoder);
+	enum transcoder trans = crtc_state->cpu_transcoder;
+	u8 update_flags = 0, clear_flags = 0;
+	u32 buf;
+
+	buf = intel_de_read(display, TRANS_HDMI_FRL_CFG(display, trans));
+	intel_de_write(display, TRANS_HDMI_FRL_CFG(display, trans),
+		       buf | TRANS_HDMI_FRL_TRAINING_COMPLETE);
+
+	if (clear_scdc_update_flags(encoder, SCDC_FLT_UPDATE) < 0)
+		return FRL_TRAIN_STOP;
+
+	if (!read_poll_timeout(get_frl_update_flags, update_flags,
+			       update_flags & (SCDC_FRL_START | SCDC_FLT_UPDATE),
+			       1000, FLT_UPDATE_TIMEOUT_MS * USEC_PER_MSEC,
+			       false, encoder)) {
+		if (update_flags & SCDC_FLT_UPDATE)
+			clear_flags |= SCDC_FLT_UPDATE;
+		if (update_flags & SCDC_FRL_START) {
+			clear_flags |= SCDC_FRL_START;
+			clear_scdc_update_flags(encoder, clear_flags);
+			return FRL_TRAINING_PASSED;
+		}
+		drm_dbg_kms(display->drm,
+			    "FRL update received for retraining the lanes\n");
+		clear_scdc_update_flags(encoder, clear_flags);
+		return FRL_TRAIN_RETRAIN;
+	}
+
+	drm_err(display->drm, "FRL TRAINING: FRL update timedout\n");
+	return FRL_TRAIN_STOP;
+}
+
+static enum frl_lt_status
+intel_hdmi_frl_train_lts3(struct intel_encoder *encoder,
+			  const struct intel_crtc_state *crtc_state,
+			  int ffe_level)
+{
+#define FLT_TIMEOUT_MS 200
+	struct intel_display *display = to_intel_display(encoder);
+	enum frl_lt_status status;
+	enum transcoder trans = crtc_state->cpu_transcoder;
+	u32 buf;
+
+	buf = intel_de_read(display, TRANS_HDMI_FRL_CFG(display, trans));
+	intel_de_write(display, TRANS_HDMI_FRL_CFG(display, trans),
+		       buf | TRANS_HDMI_FRL_ENABLE);
+
+#define done (status != FRL_TRAIN_CONTINUE)
+	status = FRL_TRAIN_CONTINUE;
+	read_poll_timeout(intel_hdmi_train_lanes, status,
+			  done,
+			  1000, FLT_TIMEOUT_MS * USEC_PER_MSEC,
+			  false, encoder, crtc_state, ffe_level);
+
+	if (status == FRL_TRAIN_CONTINUE) {
+		drm_err(display->drm, "FRL TRAINING: FLT TIMEDOUT\n");
+		return FRL_TRAIN_STOP;
+	}
+
+	if (status != FRL_TRAINING_PASSED)
+		return status;
+
+	return frl_train_complete_ltsp(encoder, crtc_state);
+}
+
+static int get_ffe_level(int rate_gbps)
+{
+	return 0;
+}
+
+int intel_hdmi_start_frl(struct intel_encoder *encoder,
+			 const struct intel_crtc_state *crtc_state)
+{
+	struct intel_display *display = to_intel_display(encoder);
+	struct intel_digital_port *dig_port = enc_to_dig_port(encoder);
+	struct intel_hdmi *intel_hdmi = &dig_port->hdmi;
+	struct intel_connector *intel_connector = intel_hdmi->attached_connector;
+	struct drm_connector *connector = &intel_connector->base;
+	int req_rate = crtc_state->frl.required_lanes * crtc_state->frl.required_rate;
+	int ffe_level = get_ffe_level(req_rate);
+	enum frl_lt_status status;
+
+	if (!crtc_state->frl.enable)
+		return 0;
+
+	if (intel_hdmi->frl.trained &&
+	    intel_hdmi->frl.rate_gbps >= req_rate) {
+		drm_dbg_kms(display->drm,
+			    "[CONNECTOR:%d:%s] FRL Already trained with rate=%d\n",
+			    connector->base.id, connector->name,
+			    intel_hdmi->frl.rate_gbps);
+		return 0;
+	}
+
+	intel_hdmi_reset_frl_config(intel_hdmi);
+
+	if (!intel_hdmi_frl_prepare_lts2(encoder,
+					 crtc_state->frl.required_rate,
+					 crtc_state->frl.required_lanes,
+					 ffe_level))
+		status = FRL_TRAIN_STOP;
+	else
+		status = intel_hdmi_frl_train_lts3(encoder, crtc_state, ffe_level);
+
+	switch (status) {
+	case FRL_TRAINING_PASSED:
+		intel_hdmi->frl.trained = true;
+		intel_hdmi->frl.rate_gbps = req_rate;
+		intel_hdmi->frl.ffe_level = ffe_level;
+		drm_dbg_kms(display->drm,
+			    "[CONNECTOR:%d:%s] FRL Training Passed with rate=%d\n",
+			    connector->base.id, connector->name,
+			    intel_hdmi->frl.rate_gbps);
+		return 0;
+	default:
+		break;
+	}
+
+	if (crtc_state->frl.enable && !intel_hdmi->frl.trained)
+		drm_err(display->drm,
+			"[CONNECTOR:%d:%s] FRL Training Failed with rate=%d\n",
+			connector->base.id, connector->name,
+			req_rate);
+
+	return -EINVAL;
+}
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index 6283305b5274..1724e6075a9b 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -64,6 +64,8 @@ int intel_hdmi_dsc_get_num_slices(const struct drm_display_mode *mode,
 int intel_hdmi_dsc_get_slice_height(int vactive);
 bool intel_hdmi_is_frl(u32 clock);
 void intel_hdmi_prepare_for_frl_mode(const struct intel_crtc_state *crtc_state);
+int intel_hdmi_start_frl(struct intel_encoder *encoder,
+			 const struct intel_crtc_state *crtc_state);
 void hsw_write_infoframe(struct intel_encoder *encoder,
 			 const struct intel_crtc_state *crtc_state,
 			 unsigned int type,
-- 
2.50.1

