Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAD46C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5974410F395;
	Fri,  7 Aug 2026 04:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="V/cdDn5v";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8663910F38F;
 Fri,  7 Aug 2026 04:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077135; x=1817613135;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KR4BiFuW2PUXLlR83AYvd7tvipUZMtrlnty26f/JSZk=;
 b=V/cdDn5vyL2wSFa2SzSlvJRsA2APWTvdRROwgpGYUyKsB8IB3FB08jUP
 4ylhVqAoMceoNLv3zJSPOthVpXFCefxgmpMrAgZc+RyceoHWg0C3y7O0S
 OddrAI0G/p98jZJqbd0Wk04ndoUFHrqmN+M08tUnGhnJ6PjCfcOK8Jk5B
 MYuJjsI+lHGvbWW8BZaPVHoY7Z0SUJjsdrmJ+0zQWZdMdQI8A3Z8VYNvP
 EwAmkGiDxV24gyw4dJ6zp9nMrI1e+6Pkf/xpJxyUMRoJBlAdwbKexRZ3l
 1vIGLBXWYw/ohfNh96Y+4OIlnd2UbyKRz7b/tZvHAdecxMAa4UuCUO424 A==;
X-CSE-ConnectionGUID: xMSRXbjWTIi9EGpCV0pCNQ==
X-CSE-MsgGUID: NDz7q0C3T6yBWA0o+lk9Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619276"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619276"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:14 -0700
X-CSE-ConnectionGUID: hoCe66hOQd+1r/YN6DECgw==
X-CSE-MsgGUID: xhHbApxKQbyZOvxgIB08WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666201"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:12 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 18/44] drm/i915/hdmi: Drive per-lane TxFFE during FRL link
 training
Date: Fri,  7 Aug 2026 09:44:03 +0530
Message-ID: <20260807041430.229038-19-ankit.k.nautiyal@intel.com>
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

From: Suraj Kandpal <suraj.kandpal@intel.com>

Hook the per-lane TxFFE state added by the previous patch into the
HDMI FRL Link Training Sequence (LTS:3):

 - Advertise FFE_Levels=3 (TxFFE0..TxFFE3) in SCDC 0x31, matching the
   four TxFFE rows present in the PHY HDMI FRL buf-trans table.

 - On LTS:3 entry, after enabling TRANS_HDMI_FRL_ENABLE, call
   encoder->set_signal_levels() so the PHY is programmed to TxFFE0
   on every lane before the sink starts emitting Ln(x)_LTP_req.

 - In intel_hdmi_train_lanes(), handle SCDC_FRL_CHNG_FFE (0xE) by
   incrementing intel_hdmi->frl.ffe_level[lane], capped at
   max_ffe_level. When any lane changed, reprogram the PHY via
   encoder->set_signal_levels() before acknowledging the request.

 - Always clear SCDC FLT_update (0x10 bit 5) after acting on a sink
   request, as required by the HDMI spec.

A forward declaration of clear_scdc_update_flags() is added so it
can be called from intel_hdmi_train_lanes() without reordering the
file.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 39 +++++++++++++++++++----
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index ba1543023373..db585c2af21d 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3573,6 +3573,7 @@ static int clear_scdc_update_flags(struct intel_encoder *encoder, u8 flags)
 
 static bool
 intel_hdmi_frl_prepare_lts2(struct intel_encoder *encoder,
+			    const struct intel_crtc_state *crtc_state,
 			    int frl_rate, int frl_lanes,
 			    int ffe_level)
 {
@@ -3598,7 +3599,12 @@ intel_hdmi_frl_prepare_lts2(struct intel_encoder *encoder,
 	if ((get_frl_update_flags(encoder) & SCDC_FLT_UPDATE))
 		clear_scdc_update_flags(encoder, SCDC_FLT_UPDATE);
 
-	/* #TODO: Source shall program TxFFE = 0 for all active lanes */
+	/*
+	 * Program PHY to TxFFE0 on every lane before the sink
+	 * starts evaluating LTP patterns. ffe_level[] has already been
+	 * cleared by intel_hdmi_reset_frl_config().
+	 */
+	encoder->set_signal_levels(encoder, crtc_state);
 
 	if (drm_scdc_config_frl(adapter, frl_rate, frl_lanes, ffe_level) < 0) {
 		drm_dbg_kms(display->drm,
@@ -3633,9 +3639,11 @@ intel_hdmi_train_lanes(struct intel_encoder *encoder,
 		       int ffe_level)
 {
 	struct intel_display *display = to_intel_display(encoder);
+	struct intel_hdmi *intel_hdmi = enc_to_intel_hdmi(encoder);
 	enum transcoder trans = crtc_state->cpu_transcoder;
 	int num_lanes = crtc_state->frl.required_lanes;
 	enum drm_scdc_frl_ltp ltp[4];
+	bool ffe_changed = false;
 	u32 write_buf = 0;
 	int lane;
 
@@ -3657,13 +3665,29 @@ intel_hdmi_train_lanes(struct intel_encoder *encoder,
 	for (lane = 0; lane < num_lanes; lane++) {
 		if (ltp[lane] >= SCDC_FRL_LTP1 && ltp[lane] <= SCDC_FRL_LTP8)
 			write_buf |= TRANS_HDMI_FRL_LTP(ltp[lane], lane);
-		/* #TODO handle FFE change */
-		else if (ltp[lane] == SCDC_FRL_CHNG_FFE)
-			continue;
+		else if (ltp[lane] == SCDC_FRL_CHNG_FFE) {
+			/*
+			 * During FRL link training: Sink requests Source
+			 * to step TxFFE up by one for this lane. Cap at the
+			 * advertised max FFE level.
+			 */
+			if (intel_hdmi->frl.ffe_level[lane] <
+			    intel_hdmi->frl.max_ffe_level) {
+				intel_hdmi->frl.ffe_level[lane]++;
+				ffe_changed = true;
+			}
+		}
 	}
 
 	intel_de_write(display, TRANS_HDMI_FRL_TRAIN(display, trans), write_buf);
 
+	/*
+	 * Reprogram per-lane PHY TxFFE before clearing FLT_update so the
+	 * sink evaluates the new preset on the next iteration.
+	 */
+	if (ffe_changed)
+		encoder->set_signal_levels(encoder, crtc_state);
+
 	clear_scdc_update_flags(encoder, SCDC_FLT_UPDATE);
 
 	return FRL_TRAIN_CONTINUE;
@@ -3752,9 +3776,9 @@ static int get_next_frl_rate(int curr_rate_gbps)
 	return -EINVAL;
 }
 
-static int get_ffe_level(int rate_gbps)
+static int get_max_ffe_level(int rate_gbps)
 {
-	return 0;
+	return 3;
 }
 
 int intel_hdmi_start_frl(struct intel_encoder *encoder,
@@ -3766,7 +3790,7 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 	struct intel_connector *intel_connector = intel_hdmi->attached_connector;
 	struct drm_connector *connector = &intel_connector->base;
 	int req_rate = crtc_state->frl.required_lanes * crtc_state->frl.required_rate;
-	int ffe_level = get_ffe_level(req_rate);
+	int ffe_level = get_max_ffe_level(req_rate);
 	enum frl_lt_status status;
 	int next_rate = -EINVAL;
 
@@ -3786,6 +3810,7 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 	intel_hdmi->frl.max_ffe_level = ffe_level;
 
 	if (!intel_hdmi_frl_prepare_lts2(encoder,
+					 crtc_state,
 					 crtc_state->frl.required_rate,
 					 crtc_state->frl.required_lanes,
 					 ffe_level))
-- 
2.50.1

