Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D65FF4940
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 04:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09EA410E3C6;
	Mon, 30 Mar 2026 04:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dpgzyD9q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F3FD10E396;
 Mon, 30 Mar 2026 04:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774844562; x=1806380562;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4CD9i6YeT0ZBhzcjJPqMMksDKExj6ijxfokVvkqd1Ag=;
 b=dpgzyD9qWEWOTjNvyrCUFWowiLaAMWuGc+qrJ3aPunnirqBPCmnVGPuu
 gfE/Z/C81r2oP7vLFwLM+hCdQcC1yCdvAtQwmaInGU/x2HuuTzaOvMf3i
 gBG89Wyneeq2rGzaJXYyn14sAYqMMHspWh5aKe9XXNEfUc8rwbqe17qpf
 uYw+wTKwTbTaPQtIqqy8sO3ACGM78+L0w/KdvfasTs1R1dM3Tq6jqc5fH
 Ybdam1evE/4CQtVSm0FZR8uW7lpjsYHxBz9qq4d9tHs1YZdhBEvJIV3DR
 Z8QFs7fNxTFCaaL8GI+SUy6+H20wAzO3RHd/fHfRkA1NLl8WAcl5mVYL1 A==;
X-CSE-ConnectionGUID: 9xz2ajOASE2Dc+KrEPbZQA==
X-CSE-MsgGUID: kIGPmNWCTEKcg7RXsmqVgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="87218256"
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="87218256"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:42 -0700
X-CSE-ConnectionGUID: 1RS6lDvSQjm4XwPnjShZsw==
X-CSE-MsgGUID: k5PUmcC4RyupDciRhKxKZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,149,1770624000"; d="scan'208";a="263871383"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2026 21:22:39 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 17/19] drm/i915/dp: Program AS SDP DB[1:0] for PR with Link off
Date: Mon, 30 Mar 2026 09:36:54 +0530
Message-ID: <20260330040656.4116502-18-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
References: <20260330040656.4116502-1-ankit.k.nautiyal@intel.com>
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
index 108e97b26748..343bb2a86675 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3161,9 +3161,10 @@ static void intel_dp_compute_as_sdp(struct intel_dp *intel_dp,
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

