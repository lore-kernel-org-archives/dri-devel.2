Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E15DCA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:16:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 985CA10EC25;
	Mon, 12 Oct 2026 04:16:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF25F10EC7E;
 Mon, 12 Oct 2026 04:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778583; x=1823314583;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WytIWaZAFrKaJis4bJW/SGKHscaE+ZLpRTAtJ1t+q5c=;
 b=EQD9u9GGZJaZvgljXX6fuktoZMu9iHJKx8zyildIoV/ee6i+IqGTFgN8
 AunOREFxkEj/CVB3UCmhG/t86LSF25SNjD3vYDQbmtnk3t0hQhCvhS8lz
 XJ1/cjcBP2eNMTWrFUShFJxi5Oa03u/ycV+Dy0JX50Afc5HmbQ1VVXLRs
 ulLlSKK01Dr9wMpF6DAcR3oygw9XL/ablxirSfG6VlFKD84pctYm5/CQp
 Ihl/JLQ0jbieRFNbkWYkr1kenY3d2666focapMumiRLwO/MTEA4kvxdJk
 rcnL+FHYnIcsLJ5GtE1GaFGlpyM8Kc8rHOq7cobcDmXslbJhfaLreWOm+ w==;
X-CSE-ConnectionGUID: UD0UIt78SCCvJoTioeqAQQ==
X-CSE-MsgGUID: Hs3JHH9KT3WVHuaQAKynIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="366218"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="366218"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:23 -0700
X-CSE-ConnectionGUID: IX/nCvIuR3iGH+HTh3bIdw==
X-CSE-MsgGUID: YebCF+7+SK6qd3F0Fp0uQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256852"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:16:21 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 56/56] drm/i915/hdmi: Allow Pipe joiner for HDMI
Date: Mon, 12 Oct 2026 09:28:05 +0530
Message-ID: <20261012035806.3361439-57-ankit.k.nautiyal@intel.com>
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

Pipe joiner is used only with FRL mode, so allow it only when the platform
and the sink both support FRL.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_hdmi.c   | 8 ++++++++
 drivers/gpu/drm/i915/display/intel_hdmi.h   | 1 +
 drivers/gpu/drm/i915/display/intel_joiner.c | 4 ++++
 3 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 2c7c47a3c61d..2955ab5880fe 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -4378,3 +4378,11 @@ void intel_hdmi_frl_get_config(struct intel_crtc_state *crtc_state)
 
 	intel_hdmi_frl_dfm_read(crtc_state);
 }
+
+bool intel_hdmi_has_joiner(struct intel_hdmi *intel_hdmi)
+{
+	struct intel_display *display = to_intel_display(intel_hdmi);
+	struct intel_encoder *encoder = &hdmi_to_dig_port(intel_hdmi)->base;
+
+	return HAS_HDMI_FRL(display) && intel_bios_hdmi_max_frl_rate(encoder->devdata);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.h b/drivers/gpu/drm/i915/display/intel_hdmi.h
index 71b12f557d75..b0b40e46b568 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.h
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.h
@@ -87,6 +87,7 @@ int intel_hdmi_sink_max_frl_rate(struct drm_connector *connector);
 int intel_hdmi_sink_dsc_max_frl_rate(struct drm_connector *connector);
 void intel_hdmi_frl_cfg_write(const struct intel_crtc_state *crtc_state);
 void intel_hdmi_frl_get_config(struct intel_crtc_state *crtc_state);
+bool intel_hdmi_has_joiner(struct intel_hdmi *intel_hdmi);
 
 /* FRL rate per lane (Gbps) -> PHY PLL table units (10 kbps) */
 #define FRL_GBPS_TO_10KBPS(rate)	((rate) * 100000)
diff --git a/drivers/gpu/drm/i915/display/intel_joiner.c b/drivers/gpu/drm/i915/display/intel_joiner.c
index 9dfe855f5668..9330d53e3cb4 100644
--- a/drivers/gpu/drm/i915/display/intel_joiner.c
+++ b/drivers/gpu/drm/i915/display/intel_joiner.c
@@ -6,6 +6,7 @@
 #include "intel_display_core.h"
 #include "intel_display_types.h"
 #include "intel_dp.h"
+#include "intel_hdmi.h"
 #include "intel_joiner.h"
 
 bool intel_joiner_needs_dsc(struct intel_display *display,
@@ -33,6 +34,9 @@ bool intel_joiner_connector_can_join(struct intel_connector *connector)
 	case DRM_MODE_CONNECTOR_DisplayPort:
 	case DRM_MODE_CONNECTOR_eDP:
 		return intel_dp_has_joiner(intel_attached_dp(connector));
+	case DRM_MODE_CONNECTOR_HDMIA:
+	case DRM_MODE_CONNECTOR_HDMIB:
+		return intel_hdmi_has_joiner(intel_attached_hdmi(connector));
 	default:
 		return false;
 	}
-- 
2.50.1

