Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311E1CA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E34510E411;
	Mon, 12 Oct 2026 04:14:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CEB810E3D0;
 Mon, 12 Oct 2026 04:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791778461; x=1823314461;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xXejOTAOJ2QIBZlJE0IS0iX2lz5c+vj7kREzp9nv6go=;
 b=ivmxcouGFT+3tNYNIuxh7ODTd/r/K2aMWBpvg6blnsBtnuf1ppDERcuU
 yXYKbi1CAm1U9zjWkMbCVJrPXGQm8TwzWZsCQKlUnlpb1DfagAVlmHA2H
 c9e0V3yywiYKdrBRd9Vnp5zHIoXRT45Wd7tWbOgzG7NS1cc7L5hzDA5+U
 dKygEK0uiTS2szboLrUOtY8ZSz5QYicn3su8MyMj6Rlpxp6nPj/aVrFQf
 UybA9vpPqEn3fGqLd4OQhDQoKVnXVWKu3mKrm8Heg94q+Cu6k5IrjwHtQ
 oyB0N6s/KSIRB/Gyo3BV6x7+FIeyS29IsHMGmzvZc5DZXJnS8nktTa9eb Q==;
X-CSE-ConnectionGUID: vye+U3U9QiG2I2tuFmFmvw==
X-CSE-MsgGUID: f9OrYKLISQSyHZ7v+gkPjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="380814"
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="380814"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:21 -0700
X-CSE-ConnectionGUID: o9Jkfhf0TCWmdPCHiPSGiw==
X-CSE-MsgGUID: EUkU97jnRGCQzqOMkKeMAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,152,1787036400"; 
   d="scan'208";a="1256326"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Oct 2026 21:14:20 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH v2 03/56] drm/i915/hdmi: Add FRL link rate cap
Date: Mon, 12 Oct 2026 09:27:12 +0530
Message-ID: <20261012035806.3361439-4-ankit.k.nautiyal@intel.com>
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

Add a member rate_cap to store the highest FRL rate the link is believed
to sustain. This is initially set based on the source and sink FRL
capabilities, and updated only when the capabilities change. To achieve
this, the reset is gated by a reset_rate_cap flag, so that rate_cap is
left as is on a plain re-probe.

Also reset the rate cap when the status changes to disconnected, so that
a re-plug of the same sink starts again from the full capability.

Later during a Link training failure at a specific rate, rate_cap can be
lowered, and since it is retained across a re-probe, the next training
attempt will honor the reduced cap. No user for now, this will be used
in the later changes.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../drm/i915/display/intel_display_types.h    |  2 ++
 drivers/gpu/drm/i915/display/intel_hdmi.c     | 33 ++++++++++++++++---
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 89333c9ddcc8..8a2128473f4f 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1719,6 +1719,8 @@ struct intel_hdmi {
 		int lanes;
 		int rate_gbps;
 		int ffe_level;
+		int rate_cap;
+		bool reset_rate_cap;
 	} frl;
 };
 
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 69534eea78a1..5c57f81d971b 100644
--- a/drivers/gpu/drm/i915/display/intel_hdmi.c
+++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
@@ -2567,14 +2567,30 @@ intel_hdmi_init_frl_config(struct intel_connector *connector)
 		intel_hdmi_sink_dsc_max_frl_rate(&connector->base);
 	int max_sink_frl_rate =
 		intel_hdmi_sink_max_frl_rate(&connector->base);
+	int max_frl_rate, max_dsc_frl_rate;
 
 	intel_hdmi->has_sink_hdmi_21 = max_sink_frl_rate > 0;
 
-	intel_hdmi->max_frl_rate = min(max_sink_frl_rate,
-				       max_src_frl_rate);
+	max_frl_rate = min(max_sink_frl_rate, max_src_frl_rate);
 
-	intel_hdmi->max_dsc_frl_rate = min(max_sink_dsc_frl_rate,
-					   max_src_frl_rate);
+	max_dsc_frl_rate = min(max_sink_dsc_frl_rate,
+			       max_src_frl_rate);
+	/*
+	 * Set the FRL rate cap on connect / capability change only.
+	 * Leaving it untouched on a plain re-probe lets a future
+	 * training-driven reduction persist across the retry.
+	 */
+	if (max_frl_rate != intel_hdmi->max_frl_rate ||
+	    max_dsc_frl_rate != intel_hdmi->max_dsc_frl_rate)
+		intel_hdmi->frl.reset_rate_cap = true;
+
+	intel_hdmi->max_frl_rate = max_frl_rate;
+	intel_hdmi->max_dsc_frl_rate = max_dsc_frl_rate;
+
+	if (intel_hdmi->frl.reset_rate_cap) {
+		intel_hdmi->frl.rate_cap = max(max_frl_rate, max_dsc_frl_rate);
+		intel_hdmi->frl.reset_rate_cap = false;
+	}
 
 	intel_hdmi_reset_frl_config(intel_hdmi);
 }
@@ -2656,9 +2672,16 @@ intel_hdmi_detect(struct drm_connector *_connector, bool force)
 out:
 	intel_display_power_put(display, POWER_DOMAIN_GMBUS, wakeref);
 
-	if (status != connector_status_connected)
+	if (status != connector_status_connected) {
 		cec_notifier_phys_addr_invalidate(intel_hdmi->cec_notifier);
 
+		/*
+		 * Reset the rate cap so that the next connect re-initializes
+		 * frl.rate_cap to the capability ceiling.
+		 */
+		intel_hdmi->frl.reset_rate_cap = true;
+	}
+
 	return status;
 }
 
-- 
2.50.1

