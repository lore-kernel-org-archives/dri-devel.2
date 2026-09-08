Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F99C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DABC310E4CE;
	Tue,  8 Sep 2026 18:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="LasUKB3z";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67A7010E173;
 Tue,  8 Sep 2026 18:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788893773; x=1820429773;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=iogi/bWLrt9Uh1fWOBtCKZOPqVFdvKbfsf/y2qql35s=;
 b=LasUKB3zp5TgZpGyxUwFXmuOWdEsLPxA/HIfwcBHStwsSMVRZ9iuRlCl
 JfyWZMctoOSw/w+KZe+WzBUDl4FBAPKrd07BvuFOz0eYJ4os8EfraJPnf
 ucIPA9fC3I7GLr2jHe4Uf0CXFGG9/75TsqEGEuGNaM4pJzXvFQtb7ysaj
 PYGeJt8P9+AIkPh82hUa8w3QufkIVjmf2KE7WLpYjxgPVr6Nr81pHwwjM
 ybBYMvuaViy03dsIBEbsTJ9UnkIdGN1BAey+DD3llD90Ca2ykZRlgB4QQ
 wDy9mwk5vBnlpxBXzycP35HUUQPMTDUPL0Wx/PQ0yBbrz2XO751ba8Fb6 g==;
X-CSE-ConnectionGUID: vAt7InmxQkKU7BYQd6KjzQ==
X-CSE-MsgGUID: AWi25JFMSHqEwMh7ARKx7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="93003899"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="93003899"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 11:56:12 -0700
X-CSE-ConnectionGUID: xG8i8XFWSle4EPNXaN7U7Q==
X-CSE-MsgGUID: EuGQkW2XTACb1uHJ6gRoAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; d="scan'208";a="271589438"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by orviesa009.jf.intel.com with ESMTP; 08 Sep 2026 11:56:12 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Matt Roper <matthew.d.roper@intel.com>
Subject: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Date: Tue,  8 Sep 2026 11:56:08 -0700
Message-ID: <20260908185609.359565-2-alan.previn.teres.alexis@intel.com>
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

v2: - Fixed checkpatch failure.
    - Added helper for 64-bit DIV_ROUND_UP on 32-bit CPU (Shasiko
      review). Fixed bug max range in usleep_range(Shasiko review)

Fixes: 5c09bd6ccd41 ("drm/xe/mmio: Move xe_mmio_wait32() to xe_mmio.c")
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
Assisted-by: Github-Copilot:Claude-Sonnet-5-0
---
 drivers/gpu/drm/xe/xe_mmio.c | 50 ++++++++++++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
index 7fa18dfcb5a2..1ae382f009de 100644
--- a/drivers/gpu/drm/xe/xe_mmio.c
+++ b/drivers/gpu/drm/xe/xe_mmio.c
@@ -7,6 +7,8 @@
 
 #include <linux/delay.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/math.h>
+#include <linux/math64.h>
 #include <linux/minmax.h>
 #include <linux/pci.h>
 
@@ -320,6 +322,30 @@ u64 xe_mmio_read64_2x32(struct xe_mmio *mmio, struct xe_reg reg)
 	return (u64)udw << 32 | ldw;
 }
 
+/**
+ * __div_round_up64() - alternative to DIV_ROUND_UP for use by __xe_mmio_wait32
+ * @dividend: 64 bit positive number to divide
+ * @divisor: 64 bit positive divisor
+ *
+ * DIV_ROUND_UP() relies on plain '/' and '%' operators, which for 64-bit
+ * operands on a 32-bit CPU get turned into calls to libgcc's __divdi3()/
+ * __moddi3(), routines the kernel does not link against. Provide a
+ * do_div()-based equivalent that works for signed 64-bit inputs on any
+ * architecture.
+ *
+ * Returns: rounded up division result
+ */
+static inline s64 __div_round_up64(s64 dividend, s64 divisor)
+{
+	u64 abs_dividend = abs(dividend);
+	u64 abs_divisor = abs(divisor);
+	u64 result = abs_dividend + abs_divisor - 1;
+
+	do_div(result, abs_divisor);
+	/* dont check for negative values as local caller only uses positive numbers */
+	return (s64)result;
+}
+
 static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val,
 			    u32 timeout_us, u32 *out_val, bool atomic, bool expect_match)
 {
@@ -349,11 +375,25 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u
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
+			else if (BITS_PER_LONG == 32)
+				mdelay(DIV_ROUND_UP(wait, USEC_PER_MSEC));
+			else
+				mdelay(__div_round_up64(wait, USEC_PER_MSEC));
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

