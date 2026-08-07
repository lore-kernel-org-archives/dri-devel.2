Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D900BC5AC81
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB3B610F38C;
	Fri,  7 Aug 2026 04:32:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="bxYor9cB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CA1010F38D;
 Fri,  7 Aug 2026 04:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077132; x=1817613132;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YWC7emFCzDjzfQp5RcPepwt0pFOV9+dFBOugUb3e0nw=;
 b=bxYor9cBupYjwRi/x+oC4DX/eXhU5xKu8MrrgBMZmQmLG01povJIr/Hb
 2aQka8fMBnP2mtSGi9GTxytMdNBcctcuMzoWOZd50YLyoMvZdXtJ92Lho
 73G4hYstYKAIoc/qFDlz+BAdcaokm8I8qfQ6Ro4dfwWy4ejvHBmtDL4Nr
 QRTKLOAHPtB+KJRKxP86z8UYRTWsFEF05vpVyv0W+kKbWl+10lzLkw5c2
 XTQENE+wAcsmNkOCmcAZ2nDb9heI8GWcb1oDUOAYm2fTV3uABTMKozDcG
 YhYA7qraItEdzeRf7K3h/ycCDAx5/ZX/OsEw6R+8MP+eh6FG8y7c1f7mg w==;
X-CSE-ConnectionGUID: F0EluGUeTFKJRDAclfl3UA==
X-CSE-MsgGUID: p5H+eW4EQiaN3WNmjdGisg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619274"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619274"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:12 -0700
X-CSE-ConnectionGUID: yqXF2lYYRum+XZBjM1g4tg==
X-CSE-MsgGUID: PlZiQUTHSvGV0HiDmqCU0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666194"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:32:09 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 17/44] drm/i915/hdmi: Introduce intel_hdmi_frl_level() for
 per-lane TxFFE
Date: Fri,  7 Aug 2026 09:44:02 +0530
Message-ID: <20260807041430.229038-18-ankit.k.nautiyal@intel.com>
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

HDMI FRL link training tracks the TxFFE preset per lane: the sink
issues per-lane Ln(x)_LTP_req requests over SCDC and the source owns
an independent TxFFE counter for each lane.
The PHY HDMI FRL buf-trans table is laid out so that index 1 + 3*N
selects the normal-operation row for TxFFE level N.

Convert struct intel_hdmi.frl from a single link-wide ffe_level into
a per-lane ffe_level[4] array plus a max_ffe_level cap, and expose
intel_hdmi_frl_level(encoder, lane) which returns the buf-trans index
that the PHY set_signal_levels() callback should program for that
lane.

Wire it into intel_ddi_level(): on FRL the per-lane index is used,
TMDS keeps the existing intel_ddi_hdmi_level() VBT/default path.

No functional change yet: ffe_level[] is always zero, so
intel_hdmi_frl_level() returns the TxFFE0 row (index 1) on every
lane, matching pre-existing behaviour. The training-side updates
that drive ffe_level[] arrive in a follow-up patch.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c      | 10 +++++---
 .../drm/i915/display/intel_display_types.h    |  3 ++-
 drivers/gpu/drm/i915/display/intel_hdmi.c     | 25 +++++++++++++++++--
 drivers/gpu/drm/i915/display/intel_hdmi.h     |  2 ++
 4 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index d6e7e7863d36..d1a60cdf55fa 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -1517,11 +1517,15 @@ int intel_ddi_level(struct intel_encoder *encoder,
 	if (drm_WARN_ON_ONCE(display->drm, !trans))
 		return 0;
 
-	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI))
-		level = intel_ddi_hdmi_level(encoder, trans);
-	else
+	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_HDMI)) {
+		if (intel_hdmi_is_frl(crtc_state->port_clock))
+			level = intel_hdmi_frl_level(encoder, lane);
+		else
+			level = intel_ddi_hdmi_level(encoder, trans);
+	} else {
 		level = intel_ddi_dp_level(enc_to_intel_dp(encoder), crtc_state,
 					   lane);
+	}
 
 	if (drm_WARN_ON_ONCE(display->drm, level >= n_entries))
 		level = n_entries - 1;
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 00775ad9019c..942dbad802a6 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1722,9 +1722,10 @@ struct intel_hdmi {
 		bool trained;
 		int lanes;
 		int rate_gbps;
-		int ffe_level;
 		int rate_cap;
 		bool reset_rate_cap;
+		u8 max_ffe_level;
+		u8 ffe_level[4];
 	} frl;
 };
 
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 2b0cdb0719e2..ba1543023373 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2554,7 +2554,27 @@ intel_hdmi_reset_frl_config(struct intel_hdmi *intel_hdmi)
 	intel_hdmi->frl.trained = false;
 	intel_hdmi->frl.lanes = 0;
 	intel_hdmi->frl.rate_gbps = 0;
-	intel_hdmi->frl.ffe_level = 0;
+	intel_hdmi->frl.max_ffe_level = 0;
+	memset(intel_hdmi->frl.ffe_level, 0, sizeof(intel_hdmi->frl.ffe_level));
+}
+
+/*
+ * HDMI FRL training level is encoded as follows:
+ *   i 0      : No FFE (LTP4 test mode)
+ *   i 1+3*N  : TxFFE N normal operation (N = 0..3)
+ *   i 1+3*N+1: TxFFE N de-emphasis only (LTP4 test mode)
+ *   i 1+3*N+2: TxFFE N pre-shoot only  (LTP4 test mode)
+ *
+ * Normal operation returns 1 + 3 * ffe_level[lane].
+ */
+int intel_hdmi_frl_level(struct intel_encoder *encoder, int lane)
+{
+	struct intel_hdmi *intel_hdmi = enc_to_intel_hdmi(encoder);
+
+	if (lane < 0 || lane >= ARRAY_SIZE(intel_hdmi->frl.ffe_level))
+		return 1;
+
+	return 1 + 3 * intel_hdmi->frl.ffe_level[lane];
 }
 
 static void
@@ -3763,6 +3783,7 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 	}
 
 	intel_hdmi_reset_frl_config(intel_hdmi);
+	intel_hdmi->frl.max_ffe_level = ffe_level;
 
 	if (!intel_hdmi_frl_prepare_lts2(encoder,
 					 crtc_state->frl.required_rate,
@@ -3776,7 +3797,7 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 	case FRL_TRAINING_PASSED:
 		intel_hdmi->frl.trained = true;
 		intel_hdmi->frl.rate_gbps = req_rate;
-		intel_hdmi->frl.ffe_level = ffe_level;
+		intel_hdmi->frl.max_ffe_level = ffe_level;
 		drm_dbg_kms(display->drm,
 			    "[CONNECTOR:%d:%s] FRL Training Passed with rate=%d\n",
 			    connector->base.id, connector->name,
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index 59a561ad28e0..5baa38d326e5 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -68,6 +68,8 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 			 const struct intel_crtc_state *crtc_state);
 void intel_hdmi_disable_frl(struct intel_encoder *encoder,
 			    const struct intel_crtc_state *crtc_state);
+void intel_hdmi_prepare_for_frl_mode(const struct intel_crtc_state *crtc_state);
+int intel_hdmi_frl_level(struct intel_encoder *encoder, int lane);
 void hsw_write_infoframe(struct intel_encoder *encoder,
 			 const struct intel_crtc_state *crtc_state,
 			 unsigned int type,
-- 
2.50.1

