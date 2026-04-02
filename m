Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E948CC6B2D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79EC810F15D;
	Thu,  2 Apr 2026 08:20:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nmlhlTzA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED93210F15A;
 Thu,  2 Apr 2026 08:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775118009; x=1806654009;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HKtKuWIigzDJGhI91ZWHWWLsAEGrgc/zwxolVt4R/eA=;
 b=nmlhlTzAk6GzScDqKSEdAmD29CY/y5rDXlxPe1lGnG7EKj5QhWalKnBJ
 MmWgRLwZYVOKS6zi594DqKPE86vJ6BqKN/juX9kLfRmLieyhECnUxfWWa
 aM5w35o59EojUZg50cqtyLWEMcx7cDDOTtvq5wwkUCmMJm8jevZqtao1B
 QPHUulimbZL1vcJxXs2fRX8QQl8GB0xBkhYBgpO/x/0ynHe8+P2nq5EWu
 mV263M6BwYkb+7P/tc3vylKI4BgnEVscyJ8lDxTwbWAZ6mjTaWfOdT243
 9csvh5AJ8Pw2dm7u3X5tQVSyVkDmoOEe4e03rYhDKlHP+xKQCW+Sg6OHZ g==;
X-CSE-ConnectionGUID: 5UWWo8ynRly1fIFkNzZTzg==
X-CSE-MsgGUID: KqCrKyECQaKusOh1AeOUhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="80060526"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="80060526"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:20:08 -0700
X-CSE-ConnectionGUID: pTQwuPzjSGKwCmOu+N2nQg==
X-CSE-MsgGUID: MtTe54WBTI+x03NAFa/MSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="226776217"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:20:06 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 13/23] drm/i915/psr: Add helper to get Async Video timing
 support in PR active
Date: Thu,  2 Apr 2026 13:34:13 +0530
Message-ID: <20260402080425.548702-14-ankit.k.nautiyal@intel.com>
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

Introduce a helper to check if Panel Replay has Async Video Timing support
during PR Active state.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 8 ++++++++
 drivers/gpu/drm/i915/display/intel_psr.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 2f1b48cd8efd..782e839b7396 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -4623,3 +4623,11 @@ bool intel_psr_use_trans_push(const struct intel_crtc_state *crtc_state)
 
 	return HAS_PSR_TRANS_PUSH_FRAME_CHANGE(display) && crtc_state->has_psr;
 }
+
+bool intel_psr_pr_async_video_timing_supported(struct intel_dp *intel_dp)
+{
+	struct intel_connector *connector = intel_dp->attached_connector;
+
+	return !(connector->dp.panel_replay_caps.dpcd[INTEL_PR_DPCD_INDEX(DP_PANEL_REPLAY_CAP_CAPABILITY)] &
+		 DP_PANEL_REPLAY_ASYNC_VIDEO_TIMING_NOT_SUPPORTED_IN_PR);
+}
diff --git a/drivers/gpu/drm/i915/display/intel_psr.h b/drivers/gpu/drm/i915/display/intel_psr.h
index 394b641840b3..29723e63888f 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.h
+++ b/drivers/gpu/drm/i915/display/intel_psr.h
@@ -86,5 +86,6 @@ void intel_psr_compute_config_late(struct intel_dp *intel_dp,
 				   struct intel_crtc_state *crtc_state);
 int intel_psr_min_guardband(struct intel_crtc_state *crtc_state);
 bool intel_psr_use_trans_push(const struct intel_crtc_state *crtc_state);
+bool intel_psr_pr_async_video_timing_supported(struct intel_dp *intel_dp);
 
 #endif /* __INTEL_PSR_H__ */
-- 
2.45.2

