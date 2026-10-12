Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC356CA9EDD
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F91210E530;
	Mon, 12 Oct 2026 04:15:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B332B10E4F4;
 Mon, 12 Oct 2026 04:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778528; x=1823314528;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=m8HYOz/DEkRkq3gcvWRxfRrHndSBhepMLl+2d2ewQWw=;
 b=MzbWownap/8Ek2gJr+c1hiD+u7gqRSB5WUGFOEDSGZYrY+27gRW+jUy7
 fygdeEmP+Nfi5JVEsC5Fp0k8inOjwvRZZwFuFVl8Z3rdEN832JOzRhC3I
 97Rl7HiP7+p0Q0OH0zCvLQCuspi5p8fD1MQA7H6FvXM/0KBp79CYBkaXm
 Y4L+jR5EEu6a4K8glFL7dSapxGfdSUMrThGOywbUHE+y1R65LW87Xr6DQ
 gqko2vOcxEqyxTuYACX0SkJ5owDzJNHyha3aKolQ9oG63ChgRx0xz5xeg
 +3ty+5k8GL/UYJMoFR8LkWcjKpOdpVGUo01c1i1QkoI7xdiPFE7/xPl72 g==;
X-CSE-ConnectionGUID: WTaDj6ISTbChEgVOBMJJVg==
X-CSE-MsgGUID: jfMozLfkR623koznsIDkyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380916"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380916"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:24 -0700
X-CSE-ConnectionGUID: FGjfjDwOQmehlyh6hQonRw==
X-CSE-MsgGUID: v88u6951RXmNwSaCsWN8Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256565"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:15:23 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 31/56] drm/i915/hdmi: Add helper to write FRL CFG register
Date: Mon, 12 Oct 2026 09:27:40 +0530
Message-ID: <20261012035806.3361439-32-ankit.k.nautiyal@intel.com>
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

Introduce helpers to write FRL CFG refister bits.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c | 16 ++++++++++++++++
 drivers/gpu/drm/i915/display/intel_hdmi.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index bfec1a808af5..db996b696847 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -3919,3 +3919,19 @@ void intel_hdmi_disable_frl(struct intel_encoder *encoder,
 
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
index 5baa38d326e5..6e0b5fb1930a 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -83,5 +83,6 @@ void intel_hdmi_poll_for_scrambling_enable(const struct intel_crtc_state *crtc_s
 
 int intel_hdmi_sink_max_frl_rate(struct drm_connector *connector);
 int intel_hdmi_sink_dsc_max_frl_rate(struct drm_connector *connector);
+void intel_hdmi_frl_cfg_write(const struct intel_crtc_state *crtc_state);
 
 #endif /* __INTEL_HDMI_H__ */
-- 
2.50.1

