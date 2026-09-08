Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E797C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 20:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 378BB10ED6C;
	Tue,  8 Sep 2026 20:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FXMNhAB9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCEB10ED66;
 Tue,  8 Sep 2026 20:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788899605; x=1820435605;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=C1VAkch/ILViMxSV5rGwKQDYeRoN5gaegzdh+U0+5Zo=;
 b=FXMNhAB9rSUMJWR3Bt0qd51jO/+1dhFZA3dFkiKDAKeZbVVaoQKhGK/+
 usCrT6GGsJ4x7uERkzzoqKNulpIwiLzjQhRNS8p6kVtxKJeCz1fa2F5Y9
 htclWMyFqQbKeOra1+jNqoV+Yee6x7azRURHcKS0zO/bkrzBYBS1An/Zl
 Blv29VE14rqx1IgyFQrdaThdbgWjb3bVe/RJZjUFQB3sc+0exbgJ6BVZu
 YzY7VdUp8jwSJ3+NWT5911ti4Z9hkv1OKxH6UGrbcXnNOIxNb6qVph4g4
 IVfISLVgypjpx5Yum6+jZHYEL6T2rYwavOp6gxWIs/CRB627Y6gBLsAq2 g==;
X-CSE-ConnectionGUID: 6tJAu4PiSjyw2SkD4kABOg==
X-CSE-MsgGUID: VBzsuCvKQxqA34BJvhBrpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="99977239"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="99977239"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 13:33:25 -0700
X-CSE-ConnectionGUID: Rd3P/sm4QDOvhfi1/K43Cg==
X-CSE-MsgGUID: UIh+/PFvTQqerynD0VaRsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="274647463"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by orviesa003.jf.intel.com with ESMTP; 08 Sep 2026 13:33:25 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Matt Roper <matthew.d.roper@intel.com>
Subject: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Date: Tue,  8 Sep 2026 13:33:23 -0700
Message-ID: <20260908203323.397466-2-alan.previn.teres.alexis@intel.com>
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

v3: - Use div64_s64 kernel API for 32-bit vs 64-bit division.
v2: - Fixed checkpatch failure.
    - Added helper for 64-bit DIV_ROUND_UP on 32-bit CPU (Shasiko
      review). Fixed bug max range in usleep_range(Shasiko review)

Fixes: 5c09bd6ccd41 ("drm/xe/mmio: Move xe_mmio_wait32() to xe_mmio.c")
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
Assisted-by: Github-Copilot:Claude-Sonnet-5-0
---
 drivers/gpu/drm/xe/xe_mmio.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
index 7fa18dfcb5a2..507095f33cec 100644
--- a/drivers/gpu/drm/xe/xe_mmio.c
+++ b/drivers/gpu/drm/xe/xe_mmio.c
@@ -7,6 +7,7 @@
 
 #include <linux/delay.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/pci.h>
 
@@ -349,11 +350,23 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u
 		if (ktime_after(ktime_add_us(cur, wait), end))
 			wait = ktime_us_delta(end, cur);
 
-		if (atomic)
-			udelay(wait);
-		else
-			usleep_range(wait, wait << 1);
-		wait <<= 1;
+#define __XE_MMIO_WAIT_MAX_INLOOP_100MS (100 * USEC_PER_MSEC)
+		if (atomic) {
+			if (wait <= MAX_UDELAY_MS * USEC_PER_MSEC)
+				udelay(wait);
+			else
+				mdelay(div64_s64(wait, USEC_PER_MSEC));
+		} else {
+			usleep_range(wait, wait + (wait >> 2)); /* range till wait + 25% */
+		}
+		/*
+		 * As we keep doubling the wait time for every check that fails, cap the
+		 * in-loop delay-or-sleep to less than 2x 100 milliseconds to prevent from
+		 * expanding 'wait' into exponentially longer wait times per loop that
+		 * end up delaying the next completion check way later than tolerable.
+		 */
+		wait = wait < __XE_MMIO_WAIT_MAX_INLOOP_100MS >> 1 ?
+		       wait << 1 : __XE_MMIO_WAIT_MAX_INLOOP_100MS;
 	}
 
 	if (ret != 0) {
-- 
2.43.0

