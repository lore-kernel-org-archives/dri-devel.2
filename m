Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC55C44518
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 02:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D93D210F973;
	Sat, 11 Jul 2026 02:56:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="TES0ASNc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C34E110E6F0;
 Sat, 11 Jul 2026 02:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783738592; x=1815274592;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MkDmOHMdUUIRDIcGOStHc6YdQK1SAZZSc3FC6q53LOQ=;
 b=TES0ASNcsQgtGdxMP91PpmAWVi76SGjGtZTxUnZhCZ4lM7W9PyAm6jSY
 T2KQtg7wZUpARQlIDAX3a7VPCKvEWdJhadKKWUIdrhMauzumjq8FuBtec
 vNQhJdUThPgoiwWjlp9hUpxcwbjxVktipAcia9MV1iN5m7S4M1pua1A6f
 0v7sDncQDk4pVZh2oQjpretUzJtxAua1iJdy9xAfafPrSYvS+BSdhfgHN
 YdoZx95i4xI/gTKJXzbv/0aeveI0HJJZ7O+ju5OSxSIReYtohcQ7V7Scy
 5ccvQZF1TvUd78fbIFhSYqn2te7kO/en7iro+CWZUWbHt2y8zrZU4RKfQ g==;
X-CSE-ConnectionGUID: p84HTHJ5S1eo4vz1CF+AAQ==
X-CSE-MsgGUID: v35L8VRqSNO237/utOoqKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="101986331"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="101986331"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:32 -0700
X-CSE-ConnectionGUID: DjfB2bHCRsuh5KDlYFMYOg==
X-CSE-MsgGUID: 6iAXW7+RTR2nAszUf8yzMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="256987772"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 19:56:31 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v3 23/33] drm/xe: Defrag using out-of-lock page preallocation
Date: Fri, 10 Jul 2026 19:56:09 -0700
Message-Id: <20260711025619.2540575-24-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260711025619.2540575-1-matthew.brost@intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
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

Convert xe_bo_defrag_one() to a three-phase scheme that moves the
expensive beneficial-order allocations out of the BO dma-resv lock:

 1. Under the lock, re-check eligibility, capture the tt cpu-caching and
    read the exact sub-optimal page count (ttm_tt_suboptimal_pages()),
    bounded by the run budget.
 2. Drop the lock and preallocate that many beneficial-order chunks via
    ttm_pool_prealloc_fill(); reclaim/compaction stalls and the cpu
    cache mode change both happen here, outside the lock.
 3. Re-take the lock, re-check, and validate consuming the prealloc bag.
    Any shortfall harvests the old backing instead of reclaiming, so the
    move never stalls under the lock; the BO re-queues for a later pass.

With both allocation and caching hoisted out, the BO-lock held time
drops to copy-bound (median ~0.27ms, p95 ~2ms); the remaining tail is
lock-wait behind active rendering, as intended.

Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Huang Rui <ray.huang@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

---

v3:
 - Use DIV_ROUND_UP_ULL() for the 64-bit preallocation chunk count
   (Sashiko)
---
 drivers/gpu/drm/xe/xe_bo.c | 46 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 0bdd1c920404..8b89d34f37d4 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -1258,16 +1258,56 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
 		.defrag_bytes_remaining = budget,
 	};
 	struct ttm_buffer_object *ttm_bo = &bo->ttm;
+	struct ttm_pool *pool = &ttm_bo->bdev->pool;
+	struct ttm_pool_prealloc pp = {};
 	struct ttm_placement placement;
 	struct ttm_place place;
+	enum ttm_caching tt_caching;
+	unsigned int order, want = 0;
 	int ret = 0;
 
 	*consumed = 0;
 	*needs_more = false;
 
+	/*
+	 * Phase 1: under the BO lock, re-check eligibility and estimate how
+	 * many beneficial-order chunks the move will (re)allocate, bounded by
+	 * the run's byte budget. Then drop the lock so the high-order, possibly
+	 * reclaim/compaction stalling allocations happen unlocked.
+	 */
+	xe_bo_lock(bo, false);
+	if (!xe_bo_needs_defrag(bo)) {
+		xe_bo_defrag_remove(bo);
+		xe_bo_unlock(bo);
+		goto out;
+	}
+	tt_caching = bo->ttm.ttm->caching;
+	order = ttm_pool_prealloc_order(pool);
+	if (order && ttm_bo->ttm) {
+		u32 suboptimal = ttm_tt_suboptimal_pages(ttm_bo->ttm);
+		u64 cap = min_t(u64, budget, xe_bo_size(bo)) >> PAGE_SHIFT;
+
+		/* Prealloc only the beneficial-order chunks the move replaces. */
+		want = DIV_ROUND_UP_ULL(min_t(u64, suboptimal, cap), 1UL << order);
+	}
+	xe_bo_unlock(bo);
+
+	/* Phase 2: preallocate outside the lock; */
+	if (want) {
+		ret = ttm_pool_prealloc_fill(pool, tt_caching, &pp, want);
+		if (ret || !pp.count) {
+			ret = ret ?: -ENOMEM;
+			xe_gt_stats_incr(xe_root_mmio_gt(xe),
+					 XE_GT_STATS_ID_DEFRAG_FAILED_COUNT, 1);
+			goto out_err;
+		}
+	}
+
+	/*
+	 * Phase 3: re-take the lock, re-check, and validate using the prealloc.
+	 */
 	xe_bo_lock(bo, false);
 
-	/* Re-check eligibility under the BO lock. */
 	if (!xe_bo_needs_defrag(bo)) {
 		xe_bo_defrag_remove(bo);
 		goto unlock;
@@ -1277,6 +1317,7 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
 	place.flags |= TTM_PL_FLAG_TEMPORARY;
 	placement.num_placement = 1;
 	placement.placement = &place;
+	ctx.prealloc = &pp;
 
 	/*
 	 * On success the move reallocates the backing at beneficial order and
@@ -1321,6 +1362,9 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
 
 unlock:
 	xe_bo_unlock(bo);
+out_err:
+	ttm_pool_prealloc_fini(pool, &pp);
+out:
 	return ret;
 }
 
-- 
2.34.1

