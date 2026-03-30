Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDEEFF4941
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED38B10E3D7;
	Mon, 30 Mar 2026 04:22:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z95Iy3X/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440EA10E357;
 Mon, 30 Mar 2026 04:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774844549; x=1806380549;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QBKkZwzAy/rUq7kZAG9u16eUb0ILdeXewdnTbcG9GpA=;
 b=Z95Iy3X/dSoeFqyxWcF1mLYE9FNthkGYjAoQs7gcXo7Mxi6SB8uHf1TW
 U8kSAoqYMvyHJ/i05UKt1CeTNyY0RBf0Xdv7rJXfXj3ZK+K+iwNA2skF5
 LCdQswmdeqCVZF6DfJC1y/ETSzU3U5E24IYqvcxjh7i9rq+bPZ7DNOAGz
 ALj0cZDYGyAo89W+HSgs/EC4C9MwXtXySV9iAC4InRhKWecoTRLZnuMVF
 edE5IwmHXX14Y12Tr4jqs/XTnwr5eaAJKVsHRGzM3+llYQRTYo8Ku1AKK
 ql49X9Nt9P0qSjF9GY99tMaNxwwCSZUn1m1LsT2ZUzK48TbjblrGC+JVA A==;
X-CSE-ConnectionGUID: /ok17mYmTduuAHO3n0hDmA==
X-CSE-MsgGUID: P06/VARjS6m9rmdMcPrQAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87218243"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="87218243"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:29 -0700
X-CSE-ConnectionGUID: iq0Y9WB9Te2ei0+EFdWOZQ==
X-CSE-MsgGUID: Z4k6ZuUqQ3uc2WPQpdu+bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="263871264"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:27 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 12/19] drm/i915/dp: Add member to intel_dp to store AS SDP v2
 support
Date: Mon, 30 Mar 2026 09:36:49 +0530
Message-ID: <20260330040656.4116502-13-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
References: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
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

DP v2.1 SCR advertises support for FAVT payload fields parsing in DPCD
0x2214 Bit 2. This indicates the support for Adaptive-Sync SDP version 2
(AS SDP v2), which allows the source to set the version in HB2[4:0] and the
payload length in HB3[5:0] of the AS SDP header.

DP v2.1 SCR also adds a bit for Async Video Timing during Panel Replay, in
Panel Replay Capability DPCD 0x00b1 (Bit 3). When this bit is cleared, the
sink supports asynchronous video timing while in a Panel Replay Active
state. The spec mandates that such sinks shall support AS SDP v2.

Infer AS SDP v2 support from these capabilities and store it in
struct intel_dp for use by subsequent feature enablement changes.

v2:
 - Include parsing ASYNC_VIDEO_TIMING_NOT_SUPPORTED_IN_PR bit to
   determine AS SDP v2 support. (Ville)

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_dp.c       | 37 +++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index e2496db1642a..efc609eef4f5 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -1870,6 +1870,7 @@ struct intel_dp {
 	/* connector directly attached - won't be use for modeset in mst world */
 	struct intel_connector *attached_connector;
 	bool as_sdp_supported;
+	bool as_sdp_v2_supported;
 
 	struct drm_dp_tunnel *tunnel;
 	bool tunnel_suspended:1;
diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index f9bfb07f0205..b2007ffe18bc 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -6301,6 +6301,40 @@ intel_dp_unset_edid(struct intel_dp *intel_dp)
 					       false);
 }
 
+static bool
+intel_dp_sink_supports_as_sdp_v2(struct intel_dp *intel_dp)
+{
+	u8 rx_features;
+	u8 pr_caps;
+
+	/*
+	 * The DP spec does not explicitly provide the AS SDP v2 capability.
+	 * So based on the DP v2.1 SCR, we infer it from the following bits:
+	 *
+	 * DP_AS_SDP_FAVT_PAYLOAD_FIELDS_PARSING_SUPPORTED indicates support for
+	 * FAVT, which is explicitly defined to use AS SDP v2.
+	 *
+	 * DP_ASYNC_VIDEO_TIMING_NOT_SUPPORTED_IN_PR cleared indicates support
+	 * for Async Video timing in PR active and the spec mandates that such
+	 * sinks shall support AS SDP v2.
+	 */
+	if (drm_dp_dpcd_read_byte(&intel_dp->aux,
+				  DP_DPRX_FEATURE_ENUMERATION_LIST_CONT_1,
+				  &rx_features) == 1) {
+		if (rx_features & DP_AS_SDP_FAVT_PAYLOAD_FIELDS_PARSING_SUPPORTED)
+			return true;
+	}
+
+	if (drm_dp_dpcd_read_byte(&intel_dp->aux,
+				  DP_PANEL_REPLAY_CAP_CAPABILITY,
+				  &pr_caps) == 1) {
+		if (!(pr_caps & DP_PANEL_REPLAY_ASYNC_VIDEO_TIMING_NOT_SUPPORTED_IN_PR))
+			return true;
+	}
+
+	return false;
+}
+
 static void
 intel_dp_detect_sdp_caps(struct intel_dp *intel_dp)
 {
@@ -6308,6 +6342,9 @@ intel_dp_detect_sdp_caps(struct intel_dp *intel_dp)
 
 	intel_dp->as_sdp_supported = HAS_AS_SDP(display) &&
 		drm_dp_as_sdp_supported(&intel_dp->aux, intel_dp->dpcd);
+
+	intel_dp->as_sdp_v2_supported = intel_dp->as_sdp_supported &&
+					intel_dp_sink_supports_as_sdp_v2(intel_dp);
 }
 
 static bool intel_dp_needs_dpcd_probe(struct intel_dp *intel_dp, bool force_on_external)
-- 
2.45.2

