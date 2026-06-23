Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF164CDB481
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E2F610ECE2;
	Tue, 23 Jun 2026 22:27:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="l1tG5Ph7";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13C7110E197;
 Tue, 23 Jun 2026 22:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782253659; x=1813789659;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Q7Xj4W/P4LEKPs3wqseTAsQkjJCRgm/z+Jbg3wbVXUk=;
 b=l1tG5Ph7ZIBLwq7L8BCsn0bUvTTXLplqMBZ5JWYi2r6cnEaZxkrVn4zs
 t/0DnCek9HEYAPSDxAvHmRfbT1YniTIM6mRZGpBCEjrlq9xITrkYCjUG4
 0SYVx0kMuW6T/Xnpw5Fbd8LcDTnEBPlOM91agmWv71XR54uUhKc+lzs6f
 meEewWS+TWGj3frX8IwHCCdIlucbbqrJDp0U85gZqRPTh8+uXqGM3Jegf
 XnKmnCZQ4F6vZQM3aWqM4q9fBefx8ttrPDxuYG0zXNjPs6aphbrrDP8Z9
 76qB/xuDfotjMyL7ZzW4j35aTSjzX00gVgC4mY9ZD5cC/GpleMYHa0Rxx w==;
X-CSE-ConnectionGUID: kveynnTpTQSYMmQCZrpzbw==
X-CSE-MsgGUID: TVJYPoslSEGxbr8xXnMr2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83048819"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="83048819"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:38 -0700
X-CSE-ConnectionGUID: 3peGSDhsSVWrJv43AkRP+w==
X-CSE-MsgGUID: QAyQl5osRBuFxSsvH48GNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; d="scan'208";a="273335799"
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 15:27:38 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [RFC PATCH 00/12] drm/ttm,
 drm/xe: Page defragmentation for sub-optimally backed BOs
Date: Tue, 23 Jun 2026 15:27:20 -0700
Message-Id: <20260623222732.360872-1-matthew.brost@intel.com>
X-Mailer: git-send-email 2.34.1
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

This series adds a "page defragmentation" mechanism that lets a driver
re-back a buffer object with higher-order (beneficial-order) pages after
it was initially allocated with a sub-optimal, lower-order set of pages
under memory pressure. Long-lived objects that happened to be allocated
while memory was fragmented otherwise keep their scattered backing
forever, costing TLB efficiency for the lifetime of the object; this
series gives them a chance to be promoted back to the device's
beneficial order once memory is available again.

The TTM core grows the generic plumbing (order-failure tracking, a
defrag move that reallocates a populated BO in place, and a reclaim
backoff knob), and the Xe driver wires up the policy: it tracks the
affected BOs on a per-device list and runs a delayed worker that
periodically tries to defragment them on the GPU.

Overview
========

ttm core
--------
 - Record sub-optimal page-order allocations in ttm_tt. ttm_pool_alloc()
   sets ttm_tt::beneficial_order_failed when it has to fall back below
   the pool's beneficial order, so drivers can tell which BOs are backed
   with scattered pages.
 - Allow backing off reclaim at the beneficial order. A new
   ttm_operation_ctx::beneficial_reclaim_backoff flag makes the pool skip
   direct reclaim/compaction (and the __GFP_RETRY_MAYFAIL promotion) for
   the beneficial order, so a caller that knows beneficial-order
   allocations are currently failing doesn't burn CPU stalling for a
   contiguous page that isn't there.
 - Support defragmentation moves. ttm_operation_ctx::defrag forces a move
   that reallocates a populated BO's backing in place at the beneficial
   order, stashing the old, still-populated tt (bo->defrag_old_tt) and
   handing it to the driver move callback so the contents can be copied
   from the old pages to the new ones. The move is non-destructive: if
   beneficial-order pages can't be obtained the attempt aborts immediately
   and is fully unwound, with the BO restored to its original, still-mapped
   tt and placement.
 - Fault injection for beneficial-order allocation failures. A
   beneficial_order_fault_inject debugfs knob (mirroring
   backup_fault_inject) forces the beneficial-order allocation to fail, so
   the tracking and the driver defrag path can be exercised deterministically
   without driving the system into real fragmentation.

Xe driver
---------
 - Track BOs backed at a sub-optimal page order. ttm_bo_type_device BOs
   resident in XE_PL_TT with beneficial_order_failed set are kept on a
   per-device list (with an atomic count); membership is updated from the
   move path and the BO is dropped when pinned.
 - Back off beneficial-order reclaim under defrag pressure. When enough
   BOs are already pending defrag, set beneficial_reclaim_backoff so new
   allocations fall back quickly instead of stalling.
 - Add xe_migrate_copy_defrag() for on-GPU defrag copies. Relocates a BO's
   contents from the old pages to the freshly reallocated ones entirely on
   the GPU, in up to two passes: a verbatim data copy with the compression
   PAT cleared, then (for compressed BOs) an indirect -> indirect CCS aux
   copy with the compression PAT set. The two passes are required because
   the data copy and the indirect CCS access need opposite compression PAT
   settings on the same page mapping.
 - Handle defrag moves in xe_bo_move(). Detects bo->defrag_old_tt, runs the
   GPU copy from the stashed old tt's sg table, and pipelines the teardown
   via ttm_bo_move_accel_cleanup() so the old backing is unpopulated/freed
   only once the copy fence signals. The defrag move is fully pipelined with
   fences: rather than stalling, it inserts the copy into the GPU execution
   pipeline and lets the BO's normal fence dependencies order it against
   concurrent work.
 - Add a page defragmentation worker. A delayed worker walks the per-device
   list and attempts a defrag move on each BO. It is kicked when the list
   first becomes non-empty, caps the BOs processed per run
   (XE_BO_DEFRAG_NUM_BO_LIMIT_PER_WORK) to avoid starving active work,
   backs off exponentially on failure
   (XE_BO_DEFRAG_INTERVAL_MS .. XE_BO_DEFRAG_INTERVAL_MAX_MS), and stops
   once the list drains.
 - Observability and configuration: defrag GT stats, a DRM_XE_DEBUG_DEFRAG
   Kconfig option for debug logging, and Kconfig.profile options to tune the
   defrag thresholds/intervals.

Notes
=====
 - This series initially targets system/GTT backing (XE_PL_TT) only. The
   TTM defrag plumbing is placement-agnostic, so VRAM-backed BOs could be
   defragmented too with future driver-side work (a VRAM beneficial-order
   notion and the corresponding migrate paths).
 - Testing: memory was intentionally fragmented by a separate program at
   the moment a 3D benchmark launches, combined with the beneficial-order
   error injection. The benchmark's BOs are initially backed at a
   sub-optimal order and FPS starts lower; shortly after, the defrag worker
   kicks in and iteratively migrates the backing to the beneficial order,
   and FPS climbs to its peak.
 - The on-GPU two-pass copy, in particular the indirect -> indirect CCS aux
   copy across two distinct page sets, still wants wider hardware validation.
 - The TTM defrag move and the Xe policy are deliberately split so the core
   plumbing can be reviewed independently of the driver's heuristics.
 - The series without a version of [1] will not break the shrinker feedback
   loop in Xe

[1] https://patchwork.freedesktop.org/series/168651/

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
Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Matthew Brost (12):
  drm/ttm/pool: Allow backing off reclaim at the beneficial order
  drm/ttm: Record sub-optimal page order allocations in ttm_tt
  drm/ttm: Support defragmentation moves
  drm/ttm: Add fault injection for beneficial-order allocation failures
  drm/xe: Track BOs backed at a sub-optimal page order
  drm/xe: Back off beneficial-order reclaim under defrag pressure
  drm/xe: Add xe_migrate_copy_defrag() for on-GPU defrag copies
  drm/xe: Handle defrag moves in xe_bo_move()
  drm/xe: Add a page defragmentation worker
  drm/xe: Add defrag GT stats
  drm/xe: Add DRM_XE_DEBUG_DEFRAG Kconfig option for debugging memory
    fragmentation
  drm/xe: Add Kconfig.profile options for BO defrag configuration

 drivers/gpu/drm/ttm/ttm_bo.c           |  83 +++++-
 drivers/gpu/drm/ttm/ttm_bo_util.c      |  16 +-
 drivers/gpu/drm/ttm/ttm_pool.c         |  49 +++-
 drivers/gpu/drm/ttm/ttm_tt.c           |   1 +
 drivers/gpu/drm/xe/Kconfig.debug       |  13 +
 drivers/gpu/drm/xe/Kconfig.profile     |  35 +++
 drivers/gpu/drm/xe/xe_bo.c             | 352 ++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_bo.h             |   2 +
 drivers/gpu/drm/xe/xe_bo_types.h       |   6 +
 drivers/gpu/drm/xe/xe_device.c         |   2 +
 drivers/gpu/drm/xe/xe_device_types.h   |  30 +++
 drivers/gpu/drm/xe/xe_gt_stats.c       |   3 +
 drivers/gpu/drm/xe/xe_gt_stats_types.h |  10 +
 drivers/gpu/drm/xe/xe_migrate.c        | 135 ++++++++--
 drivers/gpu/drm/xe/xe_migrate.h        |   8 +
 include/drm/ttm/ttm_bo.h               |  23 ++
 include/drm/ttm/ttm_tt.h               |   8 +
 17 files changed, 740 insertions(+), 36 deletions(-)

-- 
2.34.1

