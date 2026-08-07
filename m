Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1170C5AC9E
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 04:31:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C5DD10F353;
	Fri,  7 Aug 2026 04:31:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jl+ST/Ok";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFD0510F352;
 Fri,  7 Aug 2026 04:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786077095; x=1817613095;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iB1zeKW7WLZ+81BexQmZi2CxtZtc5aT8IO7XhSFIEPA=;
 b=jl+ST/OkvQ8VgTlJmkwXDJeV6Tjp6UuTGVs7Vx9tZsl2Pegt+wj4rtgV
 ALrw+Q8UVH7DvJ2b3uFCfCuy8HO+/RAcogbNoHeZXlYoLX7nr+uNCT3I5
 yOUZyFmb5BTUdq41b0+5ADeGA10wrJPzwOV6kBD1Ed2rkNdMdj499MlRL
 HlqWLwLnwJ5of6rwCRkCc4xk9ZNteBGxfgFWNtry6+j6zrwHj9WYYedAK
 BRZEYwnn1urnbAqZfuRZPBz8LhuPQOfcmwLQ2Djhdq69bFLGfTR+4l4X8
 yoc+iDlluUbGwb7hPrbCcosIqbooPvhAWikRbmekxFpL7DIZc7LNVUGh1 A==;
X-CSE-ConnectionGUID: pFsvngRXTpWJoe2I+YanYw==
X-CSE-MsgGUID: 7nzMiz+/QLWdr8fJFvk7vw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86619237"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="86619237"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:35 -0700
X-CSE-ConnectionGUID: YWU8oLGVQzS8KKgvkGxwVA==
X-CSE-MsgGUID: QQyiSfMeTnGimM1P9sPtmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; d="scan'208";a="285666054"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 21:31:32 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 uma.shankar@intel.com, ville.syrjala@linux.intel.com,
 suraj.kandpal@intel.com
Subject: [PATCH 03/44] drm/i915/hdmi: Add FRL link rate cap
Date: Fri,  7 Aug 2026 09:43:48 +0530
Message-ID: <20260807041430.229038-4-ankit.k.nautiyal@intel.com>
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
index 76fa6debb852..ba51de6c4e57 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1697,6 +1697,8 @@ struct intel_hdmi {
 		int lanes;
 		int rate_gbps;
 		int ffe_level;
+		int rate_cap;
+		bool reset_rate_cap;
 	} frl;
 };
 
diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/i915/display/intel_hdmi.c
index 65d91fc9f9ce..18d4e79ac54c 100644
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

