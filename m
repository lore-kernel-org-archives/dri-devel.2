Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF9BFF4942
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:22:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9795910E373;
	Mon, 30 Mar 2026 04:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="AsUzKw5t";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AB2010E36A;
 Mon, 30 Mar 2026 04:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774844557; x=1806380557;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QjHn86Y64BLqkfJPuu7ameMNQVs+p9aU1Y/NrJ1NZ54=;
 b=AsUzKw5tbBwLxgOSHkYWIwgx12uhI6W19VuE86NJBnT2GnzbRpMHGc2S
 CZ0117KAtsKCs8LndhIChrjTY6JSQBDct6ENxOcT8HthlAO1O0zThDGYI
 TWnNQK32i8pAB1C/r8DzUGGdc48XjxWYjDA5uNTQYQRouQuQXbWstY6m8
 T/fzWmgta8VFK3gbYZdmBnAiNL2/U76PFVyLBKlTskBODBnz5SrxK1LEW
 RpC33llxC0HIv/Vo7dr7u6D4lpfJrvSRPS15GaNA5OIhVmjdkwiam2pSy
 V5pwE11LRZvnGqSqDSX+OYae7EmDxPED77ERyqRKjtYwgsFdpXKwKehdf A==;
X-CSE-ConnectionGUID: k+BeUXLgRgC7PVHilgk91Q==
X-CSE-MsgGUID: 5t02FWadQlWmenypnCFw3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87218250"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="87218250"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:36 -0700
X-CSE-ConnectionGUID: pmb+XpqHQFSCP4q4hZZqVQ==
X-CSE-MsgGUID: Ke5mkvPVTTuHQnhiYHRbYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="263871358"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:34 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 15/19] drm/i915/psr: Program Panel Replay CONFIG3 using AS SDP
 transmission time
Date: Mon, 30 Mar 2026 09:36:52 +0530
Message-ID: <20260330040656.4116502-16-ankit.k.nautiyal@intel.com>
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

Panel Replay requires the AS SDP transmission time to be written into
PANEL_REPLAY_CONFIG3. This field was previously not programmed.

Use the AS SDP transmission-time helper to populate CONFIG3.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index ca054135ca30..34b0993d9b1d 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -783,7 +783,7 @@ static void _panel_replay_enable_sink(struct intel_dp *intel_dp,
 				      const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
-	u8 panel_replay_config[2];
+	u8 panel_replay_config[3];
 	int ret;
 
 	panel_replay_config[0] = DP_PANEL_REPLAY_ENABLE |
@@ -792,6 +792,7 @@ static void _panel_replay_enable_sink(struct intel_dp *intel_dp,
 				 DP_PANEL_REPLAY_RFB_STORAGE_ERROR_EN |
 				 DP_PANEL_REPLAY_ACTIVE_FRAME_CRC_ERROR_EN;
 	panel_replay_config[1] = DP_PANEL_REPLAY_CRC_VERIFICATION;
+	panel_replay_config[2] = intel_dp_as_sdp_transmission_time();
 
 	if (crtc_state->has_sel_update)
 		panel_replay_config[0] |= DP_PANEL_REPLAY_SU_ENABLE;
-- 
2.45.2

