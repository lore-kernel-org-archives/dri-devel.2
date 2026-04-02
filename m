Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DCFCC6B2D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 08:20:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F1210F164;
	Thu,  2 Apr 2026 08:20:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Y8aHsh/y";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E2E10F164;
 Thu,  2 Apr 2026 08:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775118013; x=1806654013;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Ifhg3xHydad4/3T6gb/AJ5yNqZfo5mDiy6XNjvpTMWw=;
 b=Y8aHsh/y8CcKWqsqUT/mrecmWPC8TKZhpWlVmKkkMTsMpLSrpE5qwKFt
 UGKEemml8tbpC3lxEsmHEMOd7Op0QnMCsHUQ7v9YbA2Sj8bMAkD660tWJ
 r+ZoH3QFi9h/necMbKTpAFd7du1nxfwYKaOVNKgRpjT0RmUu9baEi5C3h
 FayP/byfKaOYCtyXXiZGbIror1j1kov6wBaNgyxy8CzjYKQ7dLJ2cWLFH
 V+B8EFxu3EjGZAuZ4A2hlHXHpgJRl0jBI/uMr2GNzsY9suHth/Ph0yWZK
 5KZq4NZJJHxIfmX6uz75V1I2zrsT88RMGMRvZGPL9PuQ8+qbawNOoICXX A==;
X-CSE-ConnectionGUID: pqsSjgMNTUOlneArZZtpcQ==
X-CSE-MsgGUID: WLk0qOUfQXShCT3Ezz1fkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="80060554"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="80060554"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:20:13 -0700
X-CSE-ConnectionGUID: RYCGoKywTriqSWtPmrZkuw==
X-CSE-MsgGUID: k8CqaIsPSzGPEUX1eXEWLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="226776251"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 01:20:11 -0700
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com, jouni.hogander@intel.com,
 animesh.manna@intel.com, Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: [PATCH 15/23] drm/i915/dp: Allow AS SDP only if v2 is supported
Date: Thu,  2 Apr 2026 13:34:15 +0530
Message-ID: <20260402080425.548702-16-ankit.k.nautiyal@intel.com>
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

We do not support AS SDP version 1, so allow AS SDP only if AS SDP v2 is
supported.

Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 9fd768447f28..e97233805348 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -3127,7 +3127,7 @@ static void intel_dp_compute_vsc_colorimetry(const struct intel_crtc_state *crtc
 static bool intel_dp_needs_as_sdp(struct intel_dp *intel_dp,
 				  struct intel_crtc_state *crtc_state)
 {
-	if (!intel_dp->as_sdp_supported)
+	if (!intel_dp->as_sdp_v2_supported)
 		return false;
 
 	/*
-- 
2.45.2

