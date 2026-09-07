Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD6AC79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 23:55:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6260F10E531;
	Mon,  7 Sep 2026 23:55:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GpnA0YbO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8061A10E07E;
 Mon,  7 Sep 2026 23:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788825329; x=1820361329;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=IXxN/Q2r+lids8V4kL1tlzzu7NcTV+57RaGth+rzIIc=;
 b=GpnA0YbO7BLrNITPCHZbyWWtOmuQWvCI/05z2wERB2jXqPeEcefqPlmp
 WY1Kv3TGa5obxb8ileUnAWAMuJg/qVcVpyfriI2y9z4Fo1qsjGsfrSPow
 VfnN0C+TbS1v+/ycWP1YVaSQqcIjCTqo7i8klRuFjHuFDSRero9WmN5OG
 mZd3VVdtK/C03PTcLt4zjqmdiZEmCV9YpodQur1EB1j0DIuhalE4q9lRn
 nhrBMMWwl+9ZgUPXDkM5IBa53DKMDfkwgZVLKr8EsUKQsqt86+lcC5skv
 ERHHiactWrYEerWJFRFG9AaHpFRoILXB/90QDLfFFBv5aY9IuKmg3dGk5 w==;
X-CSE-ConnectionGUID: D0ad9sa/TfWneiYaSSpMCQ==
X-CSE-MsgGUID: 1YPZdr69Ql6LEKKuGPC7mQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100380283"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="100380283"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 16:55:28 -0700
X-CSE-ConnectionGUID: y7hjhfq4SYGC+STNCRugEA==
X-CSE-MsgGUID: i/ndgK/vReeAUxruZ0qKcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="272765419"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by fmviesa004.fm.intel.com with ESMTP; 07 Sep 2026 16:55:27 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Matt Roper <matthew.d.roper@intel.com>
Subject: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Date: Mon,  7 Sep 2026 16:55:23 -0700
Message-ID: <20260907235524.7807-2-alan.previn.teres.alexis@intel.com>
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
and pick the correct helper accordingly. Fix sign-overflow and avoid
growing delays becoming intollerably large by capping the in-loop
wait time. Simplify sleep_min assignment by removing redundant cast.

Fixes: 5c09bd6ccd41 ("drm/xe/mmio: Move xe_mmio_wait32() to xe_mmio.c")
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
Assisted-by: Github-Copilot:Claude-Sonnet-4-6
---
 drivers/gpu/drm/xe/xe_mmio.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
index 7fa18dfcb5a2..cf2e05aaa4b2 100644
--- a/drivers/gpu/drm/xe/xe_mmio.c
+++ b/drivers/gpu/drm/xe/xe_mmio.c
@@ -349,11 +349,23 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u
 		if (ktime_after(ktime_add_us(cur, wait), end))
 			wait = ktime_us_delta(end, cur);
 
-		if (atomic)
-			udelay(wait);
-		else
-			usleep_range(wait, wait << 1);
-		wait <<= 1;
+#define __XE_MMIO_WAIT_MAX_INLOOP_TIME (100 * USEC_PER_MSEC)
+		if (atomic) {
+			if (wait <= MAX_UDELAY_MS * USEC_PER_MSEC)
+				udelay(wait);
+			else
+				mdelay(DIV_ROUND_UP(wait, USEC_PER_MSEC));
+		} else {
+			usleep_range(wait, __XE_MMIO_WAIT_MAX_INLOOP_TIME);
+		}
+		/*
+		 * As we keep doubling the wait time for every check that fails, cap the
+		 * in-loop delay-or-sleep to less than 2x 100 miliseconds to prevent from
+		 * expanding 'wait' into exponentially longer wait times per loop that
+		 * end up delaying the next completion check way later than tolerable.
+		 */
+		wait = wait < __XE_MMIO_WAIT_MAX_INLOOP_TIME >> 1 ?
+		       wait << 1 : __XE_MMIO_WAIT_MAX_INLOOP_TIME;
 	}
 
 	if (ret != 0) {

base-commit: 71bc3b7cc55631a9b3807da98e2b2880838b9623
-- 
2.43.0

