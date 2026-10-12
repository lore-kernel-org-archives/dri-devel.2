Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B52C4CA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBD6910E48C;
	Mon, 12 Oct 2026 04:14:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF91410E3ED;
 Mon, 12 Oct 2026 04:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778494; x=1823314494;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=W8BnFl/BGHGjQVX4mykhpRb8AAJnA9v+/d65SUaIBqs=;
 b=NszELoC98VrCCK5BPyzLUxJzt5BNmWoXTeFwCafPnEjZqz9IMg/w7dbB
 kDwW1p4JVzEYLu0GCAovo3k/MevzyKuKQYnPOPQLWT55mYf7KjJ1Elj63
 UGAXryf/Qq8bcQUcaIX7MBVuCjjWWwAQyQmH34a+rY/QHeIqnytfCHqmB
 OgZ7Mtf1LYV494gnfqteMBsKJP8MLliqiLpZAt8hCANd6qhi+YNa8vrxz
 zvKqZ/LNzOWq18utJVChJgHAma4Vn6f0QNCNtxP407t9x0+H6JVOp4RNq
 GreG5GgGG0W9l4PquqkRCSAmqtAi67ye+ENn5nvMpEKVgTq36lD1zeVMD g==;
X-CSE-ConnectionGUID: xxY8+ayaQCObYSm9X+7+/A==
X-CSE-MsgGUID: oLAMTQAYScGWIiFErXdjxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380853"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380853"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:53 -0700
X-CSE-ConnectionGUID: T/E7UPv6SHu7sfofBUqMZw==
X-CSE-MsgGUID: A8vGifiRTJGhAvlzPcfl9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256415"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:52 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 17/56] drm/i915/hdmi: Introduce intel_hdmi_frl_level() for
 per-lane TxFFE
Date: Mon, 12 Oct 2026 09:27:26 +0530
Message-ID: <20261012035806.3361439-18-ankit.k.nautiyal@intel.com>
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

HDMI FRL link training tracks the TxFFE preset per lane: the sink
issues per-lane Ln(x)_LTP_req requests over SCDC and the source owns
an independent TxFFE counter for each lane.

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
that drive ffe_level[] arrive in a follow-up change.

v2: Drop Test TxFFE levels. (Ankit)

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c      | 10 ++++++---
 .../drm/i915/display/intel_display_types.h    |  3 ++-
 drivers/gpu/drm/i915/display/intel_hdmi.c     | 21 +++++++++++++++++--
 drivers/gpu/drm/i915/display/intel_hdmi.h     |  2 ++
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 1e08ffe19447..53e889c0d022 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -1518,11 +1518,15 @@ int intel_ddi_level(struct intel_encoder *encoder,
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
index 019f7b1b7c29..db08eb613d89 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1744,9 +1744,10 @@ struct intel_hdmi {
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
index 11b4554e87bd..0873ecd6ef71 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2554,7 +2554,23 @@ intel_hdmi_reset_frl_config(struct intel_hdmi *intel_hdmi)
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
+ *   0		: No FFE (LTP4 test mode)
+ *   1..3	: TxFFE 1-3 levels
+ */
+int intel_hdmi_frl_level(struct intel_encoder *encoder, int lane)
+{
+	struct intel_hdmi *intel_hdmi = enc_to_intel_hdmi(encoder);
+
+	if (lane < 0 || lane >= ARRAY_SIZE(intel_hdmi->frl.ffe_level))
+		return 1;
+
+	return 1 + intel_hdmi->frl.ffe_level[lane];
 }
 
 static void
@@ -3806,6 +3822,7 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
 	}
 
 	intel_hdmi_reset_frl_config(intel_hdmi);
+	intel_hdmi->frl.max_ffe_level = ffe_level;
 
 	if (!intel_hdmi_frl_prepare_lts2(encoder,
 					 crtc_state->frl.required_rate,
@@ -3819,7 +3836,7 @@ int intel_hdmi_start_frl(struct intel_encoder *encoder,
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

