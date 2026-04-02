Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D5ACC6B31
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2423710F189;
	Thu,  2 Apr 2026 08:20:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ORd2X0Nv";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01AD310F189;
 Thu,  2 Apr 2026 08:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775118033; x=1806654033;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YyoM7UiIAbBQvw8fURYZdwaN+yZ0PStx3VjqoG5Tmbw=;
 b=ORd2X0Nvjql6FjCg+/wvFvCo2MsMIVYKlHNoE32B2WtaA9QgjF2XnZI1
 eHmhwdrIssQxL5TT9o1fv8PVaogzS/r9q+LCcBmYmy2FhTnO1gr1zykzZ
 x+K1MyYchzM9FcdxAsp6CpptT3ct5JH4hBVyVOZEK2WW4Zk3t1SEgtZ9t
 76F/czEQ9aIVq169iAALvde1NQMfz/VDfPWlIgCl3civosOUvityAFDpV
 RKP1g0ijqC5VzXngtannoTx7F+Jw1jgCt3UlmooFTqpjsBB1hW1HZiOAU
 K+L7tFzELs8oxHBmTUzSJAsWkoDgsy0N1F4PMO04xARttWB3wyu9wKEs/ Q==;
X-CSE-ConnectionGUID: ZjFSJW7lQ3K9kD5I2cTqOw==
X-CSE-MsgGUID: pAXa9LevSL+QDN/FGls7bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="80060631"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="80060631"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:20:33 -0700
X-CSE-ConnectionGUID: 5p1VlnIMT0azOc0n6zv7lw==
X-CSE-MsgGUID: q6G9NOQ2QX67nPgN/6pelg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="226776384"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:20:31 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 23/23] drm/i915/dp: Always enable AS SDP if supported by
 source + sink
Date: Thu,  2 Apr 2026 13:34:23 +0530
Message-ID: <20260402080425.548702-24-ankit.k.nautiyal@intel.com>
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

Currently AS SDP is only configured when VRR is enabled. However, other
use cases like CMRR, Panel Replay, etc. also send information to the sink
via AS SDPs.

With optimized guardband, we also need to account for wakeup time and other
relevant details that depend on the AS SDP position whenever AS SDP is
enabled. If a feature enabling AS SDP gets turned on later (after modeset),
the guardband might not be sufficient and may need to increase, triggering
a full modeset.

To avoid this, always send AS SDP whenever:
 - the source and sink both support it, AND,
 - there is a possibility to use it for VRR and Panel Replay for
   synchronization.

v2: Check if AS SDP can be used for synchronization for VRR or PR. (Ville)

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index f5d96074c48e..5fc545d95cae 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3136,7 +3136,11 @@ static bool intel_dp_needs_as_sdp(struct intel_dp *intel_dp,
 	if (drm_dp_is_branch(intel_dp->dpcd))
 		return false;
 
-	return crtc_state->vrr.enable;
+	if (intel_alpm_is_alpm_aux_less(intel_dp, crtc_state) &&
+	    !intel_psr_pr_async_video_timing_supported(intel_dp))
+		return true;
+
+	return intel_vrr_possible(crtc_state);
 }
 
 static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
-- 
2.45.2

