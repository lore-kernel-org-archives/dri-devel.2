Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BF3CC6B31
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3FAE10F174;
	Thu,  2 Apr 2026 08:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QY8udUac";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD33210F172;
 Thu,  2 Apr 2026 08:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775118021; x=1806654021;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OjVbRtcdiCh8LGNhHiOFh+bWUkwtzu43wKuqsRW9iyo=;
 b=QY8udUacSdQ/Mlq0wWY3JK2XNlRff8kta23DC6VZJw+ne3SR6LJoKGrs
 +Tgd08+Lf6Egy/vq0zWKo3FLriF7x2k4TCaModRq/Bs7YZ/+iYmt+9Q4n
 H8106AuMWndTlyG/5764ch46j/onnIqnGX4afvrhuBsXZsZhqGZyDH5CT
 xt7QLUY7b6EmXQkOVor9DKHbeWRiemkQU7Z6N0fVB6dwf53lPJRoq9mbg
 et5NfLqZxd4MOr7gj0ZruiemOnFdRz6sR2yatQFTGMw2qzc3f2L9D6gbO
 nmjqUnZjB+r63zwG3Gz3sCoUW2aJSip/XHFW0Frgxnc9Bu5N3TGILF4mJ Q==;
X-CSE-ConnectionGUID: 3qCH57GLRxOeKX+MIaem7Q==
X-CSE-MsgGUID: f9A+8qNDT7Octl9kTzGgjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="80060597"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="80060597"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:20:20 -0700
X-CSE-ConnectionGUID: fv8hQuiORiKaS9+8xSYbWQ==
X-CSE-MsgGUID: Ko0WRMhbR0OegLvrOuxULg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="226776310"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:20:19 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 18/23] drm/i915/psr: Program Panel Replay CONFIG3 using AS SDP
 transmission time
Date: Thu,  2 Apr 2026 13:34:18 +0530
Message-ID: <20260402080425.548702-19-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260402080425.548702-1-ankit.k.nautiyal@intel.com>
References: <20260402080425.548702-1-ankit.k.nautiyal@intel.com>
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

Panel Replay requires the AS SDP transmission time to be written into
PANEL_REPLAY_CONFIG3. This field was previously not programmed.

Use the AS SDP transmission-time helper to populate CONFIG3.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 3fe7691c8b77..a9032b7ff814 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -783,6 +783,7 @@ static void _panel_replay_enable_sink(struct intel_dp *intel_dp,
 				      const struct intel_crtc_state *crtc_state)
 {
 	u8 panel_replay_config[2];
+	u8 panel_replay_config_3;
 
 	panel_replay_config[0] = DP_PANEL_REPLAY_ENABLE |
 				 DP_PANEL_REPLAY_VSC_SDP_CRC_EN |
@@ -790,7 +791,6 @@ static void _panel_replay_enable_sink(struct intel_dp *intel_dp,
 				 DP_PANEL_REPLAY_RFB_STORAGE_ERROR_EN |
 				 DP_PANEL_REPLAY_ACTIVE_FRAME_CRC_ERROR_EN;
 	panel_replay_config[1] = DP_PANEL_REPLAY_CRC_VERIFICATION;
-
 	if (crtc_state->has_sel_update)
 		panel_replay_config[0] |= DP_PANEL_REPLAY_SU_ENABLE;
 
@@ -803,6 +803,9 @@ static void _panel_replay_enable_sink(struct intel_dp *intel_dp,
 
 	drm_dp_dpcd_write(&intel_dp->aux, PANEL_REPLAY_CONFIG,
 			  panel_replay_config, sizeof(panel_replay_config));
+
+	panel_replay_config_3 = intel_dp_as_sdp_transmission_time();
+	drm_dp_dpcd_writeb(&intel_dp->aux, PANEL_REPLAY_CONFIG3, panel_replay_config_3);
 }
 
 static void _psr_enable_sink(struct intel_dp *intel_dp,
-- 
2.45.2

