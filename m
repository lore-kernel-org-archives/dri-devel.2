Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AB8FD5F9B
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 08:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E4EE10E5DA;
	Wed,  8 Apr 2026 08:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EY5Een04";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4778110E5E9;
 Wed,  8 Apr 2026 08:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775638716; x=1807174716;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e9qryOqyco3aQVFBquI3K3Sc9jZVNHQkKlRymJqYvTg=;
 b=EY5Een04B/q3Tg4mFvWwDzTxLp4mbwOXfWGZZwemGRg747f7OzFWqy59
 bhd9Uyu0lxMTlkq7jLum6vMCMdfuXMkqBNSzLFAvxmvymR2pn8z7ikd42
 Vb5nHwgEA16XX6UAY19vOnoKKOqUnPYvXixcQOcW5wMJRh9Mv2g8/On/m
 vd7qgkywF0I67COL26PBMdF6aKGWgJIrskr9D06mUVju4jyfwSR8QWfjR
 jB+wnCu/gSonOJGiAGOhTsx22G6F7Cu0pRK47AF07Wbz7FwU+VFjNccRM
 KCXC82sJkSclNt0H8TVnVWhVXYiCGzpyIZAm6yYaeel91cD7yvlH6kshM g==;
X-CSE-ConnectionGUID: wd3ZUftgSneosxtv1T7mtg==
X-CSE-MsgGUID: 1L3VOoEmTCCwVW6Jc5fwfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11752"; a="76516725"
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="76516725"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:58:36 -0700
X-CSE-ConnectionGUID: zyLwuTeBSKO9HRHuPcYvrw==
X-CSE-MsgGUID: mY9ymXDjQyiN4hW25x6MEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,167,1770624000"; d="scan'208";a="227572651"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 01:58:34 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 23/26] drm/i915/dp: Program AS SDP DB[1:0] for PR with Link off
Date: Wed,  8 Apr 2026 14:12:35 +0530
Message-ID: <20260408084239.1295325-24-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
References: <20260408084239.1295325-1-ankit.k.nautiyal@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

For Panel Replay with AUX-less ALPM (link-off PR), the source must send
Adaptive-Sync SDP v2. Program DB[1:0] per DP spec v2.1:
- VRR AVT: 00b (variable VTotal)
- VRR FAVT: 10b/11b (TRR not reached/reached)
- Fixed timing with PR link-off (VRR off): 01b (AS disabled; VTotal fixed)

Also, drop the redundant target_rr assignment.

v2: Fix the else case. (Ville)

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 1e56de9c3ce3..754aa3f6427e 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3166,9 +3166,10 @@ static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
 		as_sdp->mode = DP_AS_SDP_FAVT_TRR_REACHED;
 		as_sdp->target_rr = drm_mode_vrefresh(adjusted_mode);
 		as_sdp->target_rr_divider = true;
-	} else {
+	} else if (crtc_state->vrr.enable) {
 		as_sdp->mode = DP_AS_SDP_AVT_DYNAMIC_VTOTAL;
-		as_sdp->target_rr = 0;
+	} else {
+		as_sdp->mode = DP_AS_SDP_AVT_FIXED_VTOTAL;
 	}
 }
 
-- 
2.45.2

