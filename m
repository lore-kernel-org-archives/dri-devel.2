Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A07C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 05:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28AB510E4CB;
	Tue, 29 Sep 2026 05:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="C4R2pSzM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3EB310E5E4;
 Tue, 29 Sep 2026 05:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790660687; x=1822196687;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=OhQGSDVJEgRNIfOC/AVdpe8b99MkECr+O3vo0rHu8nY=;
 b=C4R2pSzMCuOp4Hk3YkRwSFMzZgnNX26ybHciBhVC5A6kQecm/oUbSSiG
 Oy7sdkyOZsMgciwLTNAd1/Z6p6TcL36ied5nXyylqWYM4mM4K3qpoeGby
 uOwSN5WuGrpNtys7MHMUwT5sJR32oDVcYh78g+WZnyLUfGnH3MhLThvuz
 zVEtM85vZoHeFq8ppJGXBhCA9aTFnfdaCzfeyfg//AAG7sStL32BU9N0e
 43yE8vng2mcCd384PsOwfsbu2FbU8gbxtN/AYy0pfk2Qzl2+FHZNJzJ4R
 xDLyEA6Z/MsTuYst9hrV2kTmSPozVyMNTZ4PyRySQWyfdFzASSIAdOyCl Q==;
X-CSE-ConnectionGUID: jpmoEm2rTxG/FdivBnlKsA==
X-CSE-MsgGUID: 2mWb1Dg3T/6s0MVMQe7KOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90323228"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; d="scan'208";a="90323228"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2026 22:44:46 -0700
X-CSE-ConnectionGUID: b3o1/J0KQF66TedcD+wOzQ==
X-CSE-MsgGUID: jYvclL3jSsKfksbBMzIRwg==
X-ExtLoop1: 1
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by fmviesa003.fm.intel.com with ESMTP; 28 Sep 2026 22:44:46 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Matt Roper <matthew.d.roper@intel.com>,
 Jani Nikula <jani.nikula@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Date: Mon, 28 Sep 2026 22:44:45 -0700
Message-ID: <20260929054444.1933871-2-alan.previn.teres.alexis@intel.com>
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

v5: - Simplify: don't introduce additional redesign and
      use min_t with a backoff to cap wait. (Rodrigo).
v4: - Simplify using poll_timeout_us and poll_timeout_us_atopmic and
      update all callstack to never use a param for atomic (Jani)
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
index 7fa18dfcb5a2..c7c37e59dab0 100644
--- a/drivers/gpu/drm/xe/xe_mmio.c
+++ b/drivers/gpu/drm/xe/xe_mmio.c
@@ -350,10 +350,11 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u
 			wait = ktime_us_delta(end, cur);
 
 		if (atomic)
-			udelay(wait);
+			udelay(min_t(s64, wait, MAX_UDELAY_MS));
 		else
 			usleep_range(wait, wait << 1);
-		wait <<= 1;
+#define __XE_MMIO_WAIT_MAX_BACKOFF_100MS (100 * USEC_PER_MSEC)
+		wait = min_t(s64, wait << 1, __XE_MMIO_WAIT_MAX_BACKOFF_100MS);
 	}
 
 	if (ret != 0) {
-- 
2.43.0

