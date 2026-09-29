Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB4EC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC2210EF9F;
	Tue, 29 Sep 2026 16:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lsnlwDYw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2B9A10EF93;
 Tue, 29 Sep 2026 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790698288; x=1822234288;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=E+qpu/3mUBlG0VofrRB0IGKZDYXBfkPeh5dpHLP/Uu0=;
 b=lsnlwDYwlgwpaqC4HjkjpILg9wl7ISdkTMc1WqiHoF2uFtSupjgI63t6
 IK6k61oFmrFP/Q5NTRcrxQI8FuHBw69vOlQNqdb6yA08J87e8zvP0Yc2m
 tpw12Y1/BSSZTryHnN3QyRHWqVTC/bOUdBcK488fNdgRSUoQo28ztXbXb
 cnnHq5TmsZIpd/TRDdzsGRQxFeMQ/7soa2Qwl5AylgSBiMXSXVL0XaV56
 SdnP7zpISvu+fC04GZv+GVEy2TbjzNs3HiWwARCpr0VuoT+rv5okt7FJi
 WIX9Y+1xNSVe45J+jbFVLbthxO8wO1ov6Z64VqtS12ta0cR2crux2fYIs w==;
X-CSE-ConnectionGUID: PC9zRsLDQuaBAF0UU9lTsA==
X-CSE-MsgGUID: qjv+o7SrQkuMRlqAubi6GA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90475041"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90475041"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 09:11:28 -0700
X-CSE-ConnectionGUID: 87TQea9fSbqyyL5SvLAIzA==
X-CSE-MsgGUID: G3aMZv0fTgiWTKp+9vtCmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="274021994"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by fmviesa006.fm.intel.com with ESMTP; 29 Sep 2026 09:11:27 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Matt Roper <matthew.d.roper@intel.com>,
 Jani Nikula <jani.nikula@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Date: Tue, 29 Sep 2026 08:25:04 -0700
Message-ID: <20260929161125.1973918-2-alan.previn.teres.alexis@intel.com>
X-Mailer: git-send-email 2.43.0
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

Check for overflow in udelay/usleep_range use in __xe_mmio_wait32
and pick the correct helper according to the wait time and atomic.
Implement a similar helper to replace DIV_ROUND_UP for 32-bit CPUs.
Avoid growing delays becoming intollerably large by capping the
in-loop wait time.

v6: - Fix commit message to remove items dropped in v5. Fix the
      use of MAX_UDELAY_MS for microsecond unit. (Shasiko review).
v5: - Simplify: don't introduce additional redesign and
      use min_t with a backoff to cap wait. (Rodrigo).
v4: - Simplify using poll_timeout_us and poll_timeout_us_atomic and
      update all callers to never use a param for atomic (Jani)
v3: - Use div64_s64 kernel API for 32-bit vs 64-bit division.
v2: - Fixed checkpatch failure.
    - Added helper for 64-bit DIV_ROUND_UP on 32-bit CPU (Shasiko
      review). Fixed bug max range in usleep_range(Shasiko review)

Fixes: 5c09bd6ccd41 ("drm/xe/mmio: Move xe_mmio_wait32() to xe_mmio.c")
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
Assisted-by: Github-Copilot:Claude-Sonnet-5-0
---
 drivers/gpu/drm/xe/xe_mmio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
index 7fa18dfcb5a2..5a03698729ce 100644
--- a/drivers/gpu/drm/xe/xe_mmio.c
+++ b/drivers/gpu/drm/xe/xe_mmio.c
@@ -350,10 +350,11 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u
 			wait = ktime_us_delta(end, cur);
 
 		if (atomic)
-			udelay(wait);
+			udelay(min_t(s64, wait, (MAX_UDELAY_MS * 1000)));
 		else
 			usleep_range(wait, wait << 1);
-		wait <<= 1;
+#define __XE_MMIO_WAIT_MAX_BACKOFF_100MS (100 * USEC_PER_MSEC)
+		wait = min_t(s64, wait << 1, __XE_MMIO_WAIT_MAX_BACKOFF_100MS);
 	}
 
 	if (ret != 0) {
-- 
2.43.0

