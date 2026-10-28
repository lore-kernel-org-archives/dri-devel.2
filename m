Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21407606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FN3wXovS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A84610E711;
	Wed, 28 Oct 2026 23:03:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C9810E2F8;
 Wed, 28 Oct 2026 23:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793228577; x=1824764577;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=70+5liHePgcQKfx9vh3AKdUbRkrtVZQYaXIigCKndHc=;
 b=FN3wXovSDCMAAFiRP+++PC5hUFhgOMZjfnfr3ZnljFpVmGKQ769O26ua
 H6CJhHA9OmTgDiKuBwTT43C9Q1JLd6SO3IEwPzwO2nAXCf5AovfJvRWm5
 +Ih3oryYa7SzUL8K8jbzNYQSY+jABYQ4Etkzcqg/hOa4SiMsbMBSMSVZz
 vCoiUOcH/A6UowC2dYXgM0lLCzexvUxXsJNLft+ynSlET5rXV22vn0EFw
 7hPJzhRtSrqXnR0DsTjZDrPAToR35deJRC37inEmVJiUDFevatSxyMG1i
 hfPNs1VMZ+okRfHl6AVJB7ggvtu8PzQIG+I0JQy2z9I8NtHqZWFW5JZHo A==;
X-CSE-ConnectionGUID: 0YJrPMa4Qq+JKntRSr88vw==
X-CSE-MsgGUID: W9Z2jrRLQKqwUz/BG54U7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1840893"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1840893"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Oct 2026 16:02:55 -0700
X-CSE-ConnectionGUID: 6IjsOVvnQo+bJq51SP1GmQ==
X-CSE-MsgGUID: yOoBrMvpQdyH+5cl8R0JTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5054985"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by orviesa006.jf.intel.com with ESMTP; 28 Oct 2026 16:02:55 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Matt Roper <matthew.d.roper@intel.com>,
 Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 1/1] drm/xe/mmio: Update xe_mmio_wait to use kernel polling
 helpers
Date: Wed, 28 Oct 2026 16:02:54 -0700
Message-ID: <20261028230254.496501-2-alan.previn.teres.alexis@intel.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Refactor the current implementation os __xe_mmio_wait32 to use
kernel poll_timeout_* helpers that scale across architecture
and max timeouts while maintaining the exponential backoff looping
to ensure no difference in latency experiened by callers.

Assisted-by: LLM
Suggested-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
---
 drivers/gpu/drm/xe/xe_mmio.c | 64 +++++++++++++-----------------------
 1 file changed, 23 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
index 2674146ced76..e48b1c94a82b 100644
--- a/drivers/gpu/drm/xe/xe_mmio.c
+++ b/drivers/gpu/drm/xe/xe_mmio.c
@@ -5,8 +5,8 @@
 
 #include "xe_mmio.h"
 
-#include <linux/delay.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/iopoll.h>
 #include <linux/minmax.h>
 #include <linux/pci.h>
 
@@ -324,53 +324,35 @@ u64 xe_mmio_read64_2x32(struct xe_mmio *mmio, struct xe_reg reg)
 	return (u64)udw << 32 | ldw;
 }
 
-#define __XE_MMIO_WAIT_MAX_BACKOFF_100MS (100 * USEC_PER_MSEC)
+#define XE_MMIO_WAIT_MIN_US		10
+#define XE_MMIO_WAIT_MAX_DELAY_US	(MAX_UDELAY_MS * 1000)
+#define XE_MMIO_WAIT_MAX_SLEEP_US	(100 * 1000)
+
 static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val,
 			    u32 timeout_us, u32 *out_val, bool atomic, bool expect_match)
 {
-	ktime_t cur = ktime_get_raw();
-	const ktime_t end = ktime_add_us(cur, timeout_us);
-	int ret = -ETIMEDOUT;
-	s64 wait = 10;
+	u32 max_us = atomic ? XE_MMIO_WAIT_MAX_DELAY_US : XE_MMIO_WAIT_MAX_SLEEP_US;
+	/* a zero timeout means "never time out" to the iopoll helpers */
+	u32 left_us = timeout_us ?: 1;
+	u32 wait_us = XE_MMIO_WAIT_MIN_US;
+	u32 step_us;
 	u32 read;
-	bool check;
-
-	for (;;) {
-		read = xe_mmio_read32(mmio, reg);
-
-		check = (read & mask) == val;
-		if (!expect_match)
-			check = !check;
-
-		if (check) {
-			ret = 0;
-			break;
-		}
-
-		cur = ktime_get_raw();
-		if (!ktime_before(cur, end))
-			break;
-
-		if (ktime_after(ktime_add_us(cur, wait), end))
-			wait = ktime_us_delta(end, cur);
+	int ret;
 
+	/* exponential backoff: each step polls at, and lasts for, twice the previous interval */
+	do {
+		step_us = min(wait_us, left_us);
 		if (atomic)
-			udelay(min_t(s64, wait, (MAX_UDELAY_MS * 1000)));
+			ret = poll_timeout_us_atomic(read = xe_mmio_read32(mmio, reg),
+						     ((read & mask) == val) == expect_match,
+						     step_us, step_us, false);
 		else
-			usleep_range(wait, wait << 1);
-		wait = min_t(s64, wait << 1, __XE_MMIO_WAIT_MAX_BACKOFF_100MS);
-	}
-
-	if (ret != 0) {
-		read = xe_mmio_read32(mmio, reg);
-
-		check = (read & mask) == val;
-		if (!expect_match)
-			check = !check;
-
-		if (check)
-			ret = 0;
-	}
+			ret = poll_timeout_us(read = xe_mmio_read32(mmio, reg),
+					      ((read & mask) == val) == expect_match,
+					      step_us, step_us, false);
+		left_us -= step_us;
+		wait_us = min(wait_us << 1, max_us);
+	} while (ret && left_us);
 
 	if (out_val)
 		*out_val = read;

base-commit: 81fce6ce260af07e3f7a1211b6fe813941cbd17b
-- 
2.43.0

