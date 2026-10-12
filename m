Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8138BCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F45010E491;
	Mon, 12 Oct 2026 04:15:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15AAD10E470;
 Mon, 12 Oct 2026 04:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778496; x=1823314496;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2mHlTE2++HouifNNk6V0uuZQQLmaUHNMe5Yt5xdNePw=;
 b=NO2/k2uhV3Uua4CufSba2bxvvnb29IwdY7/4QYXlMudGbSAWekmRIM1G
 GI4M+HSK0aYtHV4DsVFUIldALicADlZ6FBjz/F6PhZP1JilY87rXvwhBs
 WMgYhSXqfxX+EIEKFrFosGRWha0Jnx6l7R3+/W3gPfyz8QXrpNN10cyek
 ll5mY9KHky8D1KYQwJVAMy8EXFDDmY3/fFacFx8mVLzhKh/xZyXxELMJZ
 VvThpEpeijwPs9uwc0c3+ug3dlnCoWI4VKsKtDvI0y649N9ubQFhLiLr3
 plNq8T+nHFVIY4dxRRH7ZvEQecAZewFgdMCftE3N75ATz1foDmfeYsQcZ Q==;
X-CSE-ConnectionGUID: NRjmUwIMRiy6P4BLEB3+sg==
X-CSE-MsgGUID: CRKt2F17QuSCjp0uB5Vucg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380854"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380854"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:55 -0700
X-CSE-ConnectionGUID: x8VtUQ11ReyXE8Tpl71etw==
X-CSE-MsgGUID: ZSxhYiu0SieU+y2uP73OOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256422"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:54 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 18/56] drm/i915/hdmi: Drive per-lane TxFFE during FRL link
 training
Date: Mon, 12 Oct 2026 09:27:27 +0530
Message-ID: <20261012035806.3361439-19-ankit.k.nautiyal@intel.com>
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
 drivers/gpu/drm/i915/display/intel_hdmi.c | 27 +++++++++++++++--------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 0873ecd6ef71..1aa6f71fbfce 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3581,6 +3581,7 @@ static int clear_scdc_update_flags(struct intel_encoder *encoder, u8 flags)
 
 static bool
 intel_hdmi_frl_prepare_lts2(struct intel_encoder *encoder,
+			    const struct intel_crtc_state *crtc_state,
 			    int frl_rate, int frl_lanes,
 			    int ffe_level)
 {
@@ -3619,7 +3620,8 @@ intel_hdmi_frl_prepare_lts2(struct intel_encoder *encoder,
 	if (ret & SCDC_FLT_UPDATE)
 		clear_scdc_update_flags(encoder, SCDC_FLT_UPDATE);
 
-	/* #TODO: Source shall program TxFFE = 0 for all active lanes */
+	/* ffe_level[] was cleared by intel_hdmi_reset_frl_config(). */
+	encoder->set_signal_levels(encoder, crtc_state);
 
 	if (drm_scdc_config_frl(adapter, frl_rate, frl_lanes, ffe_level) < 0) {
 		drm_dbg_kms(display->drm,
@@ -3654,9 +3656,11 @@ intel_hdmi_train_lanes(struct intel_encoder *encoder,
 		       int ffe_level)
 {
 	struct intel_display *display = to_intel_display(encoder);
+	struct intel_hdmi *intel_hdmi = enc_to_intel_hdmi(encoder);
 	enum transcoder trans = crtc_state->cpu_transcoder;
 	int num_lanes = crtc_state->frl.required_lanes;
 	enum drm_scdc_frl_ltp ltp[4];
+	bool ffe_changed = false;
 	u32 write_buf = 0;
 	int update_flags;
 	int lane;
@@ -3684,16 +3688,20 @@ intel_hdmi_train_lanes(struct intel_encoder *encoder,
 		if (ltp[lane] == SCDC_FRL_LTP3)
 			continue;
 
-		if (ltp[lane] >= SCDC_FRL_LTP1 && ltp[lane] <= SCDC_FRL_LTP8)
+		if (ltp[lane] >= SCDC_FRL_LTP1 && ltp[lane] <= SCDC_FRL_LTP8) {
 			write_buf |= TRANS_HDMI_FRL_LTP(ltp[lane], lane);
-
-		/* #TODO handle FFE change */
-		else if (ltp[lane] == SCDC_FRL_CHNG_FFE)
-			continue;
+		} else if (ltp[lane] == SCDC_FRL_CHNG_FFE &&
+			   intel_hdmi->frl.ffe_level[lane] < intel_hdmi->frl.max_ffe_level) {
+			intel_hdmi->frl.ffe_level[lane]++;
+			ffe_changed = true;
+		}
 	}
 
 	intel_de_write(display, TRANS_HDMI_FRL_TRAIN(display, trans), write_buf);
 
+	if (ffe_changed)
+		encoder->set_signal_levels(encoder, crtc_state);
+
 	clear_scdc_update_flags(encoder, SCDC_FLT_UPDATE);
 
 	return FRL_TRAIN_CONTINUE;
@@ -3791,9 +3799,9 @@ static int get_next_frl_rate(int curr_rate_gbps)
 	return -EINVAL;
 }
 
-static int get_ffe_level(int rate_gbps)
+static int get_max_ffe_level(int rate_gbps)
 {
-	return 0;
+	return 3;
 }
 
 int intel_hdmi_start_frl(struct intel_encoder *encoder,
@@ -3805,7 +3813,7 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 	struct intel_connector *intel_connector = intel_hdmi->attached_connector;
 	struct drm_connector *connector = &intel_connector->base;
 	int req_rate = crtc_state->frl.required_lanes * crtc_state->frl.required_rate;
-	int ffe_level = get_ffe_level(req_rate);
+	int ffe_level = get_max_ffe_level(req_rate);
 	enum frl_lt_status status;
 	int next_rate = -EINVAL;
 
@@ -3825,6 +3833,7 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 	intel_hdmi->frl.max_ffe_level = ffe_level;
 
 	if (!intel_hdmi_frl_prepare_lts2(encoder,
+					 crtc_state,
 					 crtc_state->frl.required_rate,
 					 crtc_state->frl.required_lanes,
 					 ffe_level))
-- 
2.50.1

