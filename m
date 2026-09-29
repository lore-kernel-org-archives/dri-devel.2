Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D9ECA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC8AA10F074;
	Tue, 29 Sep 2026 19:20:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="R6MHUhiA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3B8510F072;
 Tue, 29 Sep 2026 19:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790709639; x=1822245639;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wRF+ItvSNwe2eymSjckpCfFm5v0VPerNdcMQ97uGTFU=;
 b=R6MHUhiAe05cdaQ6Zr9LOY8g5sv8iiC5zSZ70gT5Tw0+tYNLtfK+1/K1
 DuXQ2hXs3XrVTRcVqFPMeW9xn4JV/OdXWAURKAXK6/R/aovJ3hB1BuRai
 inFw57Mo6w5mckMXNQxi5WXsMV9ewg+tU7C2+tX+yH3KIl3uXg/QdTAol
 diQgQdOhgINfFMXPgw4DndqJX+3dFM8zi9Kq3AiUJK2lwabWESG75tfzJ
 MKObLCzg+fKLsRoGvsWm6CnKKNM6Kn3uyn4X5t2Z8CEHpfx0BNHjLNFxz
 VJ+hGQgDKM7SuYKScJkyumEZpoT+tnADTCRJZNHdVI/Xj8qQ3nus0f0yk g==;
X-CSE-ConnectionGUID: 0zijrlPMRdiqUCHMJ7Lstw==
X-CSE-MsgGUID: Be2/ijTUTNmxH2nXRuuWyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90205431"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90205431"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 12:20:39 -0700
X-CSE-ConnectionGUID: KjeUUSKLSp6Dw5Gxbu/XPA==
X-CSE-MsgGUID: L08ocxQyQqCNMpfjMtbHHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="280214982"
Received: from aalteres-desk1.fm.intel.com ([10.121.64.173])
 by fmviesa004.fm.intel.com with ESMTP; 29 Sep 2026 12:20:38 -0700
From: Alan Previn <alan.previn.teres.alexis@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Alan Previn <alan.previn.teres.alexis@intel.com>,
 dri-devel@lists.freedesktop.org, Matt Roper <matthew.d.roper@intel.com>,
 Jani Nikula <jani.nikula@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Date: Tue, 29 Sep 2026 12:20:37 -0700
Message-ID: <20260929192037.2233429-2-alan.previn.teres.alexis@intel.com>
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

Check for overflow in udelay use in __xe_mmio_wait32 and
avoid growing delays becoming intollerably large by capping the
in-loop wait time.

v7: - Change assisted-by to "LLM" (Rodrigo).
    - Move the max-wait macro to outside the function (Rodrigo).
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
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Assisted-by: LLM
---
 drivers/gpu/drm/xe/xe_mmio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
index 7fa18dfcb5a2..455a07d79cd9 100644
--- a/drivers/gpu/drm/xe/xe_mmio.c
+++ b/drivers/gpu/drm/xe/xe_mmio.c
@@ -320,6 +320,7 @@ u64 xe_mmio_read64_2x32(struct xe_mmio *mmio, struct xe_reg reg)
 	return (u64)udw << 32 | ldw;
 }
 
+#define __XE_MMIO_WAIT_MAX_BACKOFF_100MS (100 * USEC_PER_MSEC)
 static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val,
 			    u32 timeout_us, u32 *out_val, bool atomic, bool expect_match)
 {
@@ -350,10 +351,10 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u
 			wait = ktime_us_delta(end, cur);
 
 		if (atomic)
-			udelay(wait);
+			udelay(min_t(s64, wait, (MAX_UDELAY_MS * 1000)));
 		else
 			usleep_range(wait, wait << 1);
-		wait <<= 1;
+		wait = min_t(s64, wait << 1, __XE_MMIO_WAIT_MAX_BACKOFF_100MS);
 	}
 
 	if (ret != 0) {
-- 
2.43.0

