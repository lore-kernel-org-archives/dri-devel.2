Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD868C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39EB610E255;
	Fri, 10 Jul 2026 21:54:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lT3eDrNB";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FDB610E1BD;
 Fri, 10 Jul 2026 21:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783720488; x=1815256488;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lt/5Vw5Y+JFxkMRCjEo4IxsfaVs/ygYEHnFYVbkVhMQ=;
 b=lT3eDrNB4T9tdPAsmgxf2rDKxFgsiBxswFSLkxETTyYIeM70Y/wnVe35
 okrgwsaQFtiCFSfjq4K6tyrx3DVn5CLe2JPSu+R0xJGwgm9pzBQ/sC1r2
 b5hXK/AJiZ7k1uGWeaktEXAb/TZRtMTCNyzh6hbfT9lMUIWUNPvrxx8hl
 VrqtjUmqauZ6sQE9FQ4eWOA7aO83MLsLiO98qF+cHOC+vZJYSQDzxLDEM
 ohEuw/pw6Wl0XCZmRcQaigMNaH7riJTYD3Y+0iGMrpOLor9pCaYmw5XFl
 yhUVzXcxKIZjrhREYn4QJsEYJyOvnMwBvc2ZaFCJNEu7veikWZZ4hjN2K A==;
X-CSE-ConnectionGUID: LNB3+5OzQ+OLyRVke1AHhg==
X-CSE-MsgGUID: eA8xcnZRTrSY11Pg6fjcPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83543036"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="83543036"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:47 -0700
X-CSE-ConnectionGUID: 0j8fno/OTAWteYmMhgjv1w==
X-CSE-MsgGUID: 9lrKmnc0Saue+ePf9tunoQ==
X-ExtLoop1: 1
Received: from gsse-cloud1.jf.intel.com ([10.54.39.91])
 by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2026 14:54:47 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH v2 00/33] drm/ttm,
 drm/xe: Minimize dma-resv hold times and defragment sub-optimally
 backed BOs
Date: Fri, 10 Jul 2026 14:54:09 -0700
Message-Id: <20260710215442.2444235-1-matthew.brost@intel.com>
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

The overarching goal of this series is to keep user-facing IOCTLs snappy
by holding the BO dma-resv lock for the shortest possible time, and to
push the expensive, best-effort work - page (re)allocation, DMA mapping
and placement fixups - into the background or out of the locked critical
section entirely.

Two related mechanisms fall out of that goal:

 - Out-of-lock backing. Page allocation and DMA mapping are the dominant
   cost of gem_create and of BO moves, and doing them under the dma-resv
   lock serializes otherwise-independent clients. This series preallocates
   the backing pages (and, where applicable, builds the DMA/IOVA mapping)
   outside the lock, then transfers the result into the BO under a brief
   lock hold. The user gets a fast IOCTL return; the heavy lifting happens
   without contending the reservation.

 - Page defragmentation. A BO allocated under memory pressure keeps its
   scattered, sub-optimally-ordered backing for its entire lifetime,
   costing TLB efficiency forever. TTM grows the plumbing to track
   order-failure and to re-back a populated BO in place at the beneficial
   order, and Xe wires up a background delayed worker that promotes such
   BOs on the GPU once memory is available again - again, off the hot
   path and without stalling the submitting thread.

Since v1 [1] the series has grown considerably. The bulk of the new
material is a direct result of profiling: once the defragmenter was in
place, the remaining dma-resv hold times and the per-BO
allocation/mapping costs showed up clearly, which motivated the
out-of-lock preallocation, the IOVA-based mapping path, and the amdgpu
counterpart. Rather than land the defragmenter alone, v2 folds in these
optimizations since they share the same infrastructure and the same
"hold dma-resv briefly, fix up in the background" architecture.

The series is organized in sections rather than described patch by patch:

 - Patches 1-10 (drm/ttm): core TTM preparation - order-failure tracking,
   the defragmentation move, reclaim backoff, and out-of-lock page
   preallocation plumbing.
 - Patches 11-14: other dependent drm/gpusvm and drm/xe patches this
   series builds on (DMA-mapping accounting, per-order DMA stats, async
   L2 flush, and a VM-teardown ordering fix).
 - Patches 15-23 (drm/xe): the page defragmenter itself - BO tracking,
   the on-GPU defrag copy, xe_bo_move() handling, and the background
   worker with its stats and configuration.
 - Patches 24-25 (drm/xe): out-of-lock system BO backing preallocation
   in gem_create, moving page allocation out of the dma-resv lock.
 - Patches 26-32 (drm/xe): IOVA-based DMA mapping optimizations, building
   and finalizing the mapping outside the lock.
 - Patch 33 (drm/amdgpu): the equivalent out-of-lock system BO
   preallocation for amdgpu, exercising the shared TTM plumbing.

Testing
=======

 - 3D benchmarks on Ubuntu and on Android, with memory intentionally
   fragmented by a separate program at launch (plus beneficial-order
   error injection). BOs are initially backed at a sub-optimal order and
   scores start lower; the background defrag worker then promotes the
   backing to the beneficial order and scores climb back in line with the
   unfragmented baseline.
 - IGT:
   https://patchwork.freedesktop.org/patch/739052/?series=170046&rev=2

Matt

[1] https://patchwork.freedesktop.org/series/169053/

Cc: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>
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



Matthew Brost (31):
  drm/ttm/pool: Allow backing off reclaim at the beneficial order
  drm/ttm/pool: Add ttm_pool_page_order_nodma() helper
  drm/ttm: Record sub-optimal page order allocations in ttm_tt
  drm/ttm: Introduce ttm_pool_alloc_iter for __ttm_pool_alloc()
  drm/ttm: Support defragmentation moves
  drm/ttm: Add fault injection for beneficial-order allocation failures
  drm/ttm: Harvest beneficial-order pages on defragmentation moves
  drm/ttm: Bound page (re)allocation per defragmentation move
  drm/ttm: Preallocate beneficial-order defrag pages outside the lock
  drm/ttm: Add full out-of-lock preallocation for ttm_pool_alloc()
  drm/xe: Flush L2 asynchronously in xe_bo_trigger_rebind()
  drm/xe: Destroy page tables after unlinking all VMAs on VM close
  drm/xe: Track BOs backed at a sub-optimal page order
  drm/xe: Back off beneficial-order reclaim under defrag pressure
  drm/xe: Add xe_migrate_copy_defrag() for on-GPU defrag copies
  drm/xe: Handle defrag moves in xe_bo_move()
  drm/xe: Skip self-copies for borrowed pages on defrag moves
  drm/xe: Add a page defragmentation worker
  drm/xe: Add defrag GT stats
  drm/xe: Add Kconfig.profile options for BO defrag configuration
  drm/xe: Defrag using out-of-lock page preallocation
  drm/xe: Add defrag profiling tracepoints
  drm/xe: Preallocate system BO backing outside the dma-resv lock
  drm/xe: Add tracepoint for xe_gem_create_ioctl
  drm/xe: Add IOVA-based xe_res_cursor variant
  drm/xe: Use IOVA-based DMA mapping for eligible tt BOs
  drm/xe: Add per-device dependency scheduler for IOVA defrag finalize
  drm/xe: Add packed copy-step IOVA mapping for defrag
  drm/xe: Blit src-natural to dst-packed for defrag-IOVA copies
  drm/xe: Finalize defrag-IOVA moves with post-copy job
  drm/amdgpu: Preallocate system BO pages outside the reservation lock

Thomas Hellström (2):
  drm/gpusvm: Add a DMA-mapping accounting callback
  drm/xe: Add debugfs stats for DMA-mapped pages per order

 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |    4 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |    2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |   45 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h       |    5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |    4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |   39 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |    3 +
 drivers/gpu/drm/drm_gpusvm.c                  |   17 +-
 drivers/gpu/drm/ttm/ttm_bo.c                  |  101 +-
 drivers/gpu/drm/ttm/ttm_bo_util.c             |   21 +-
 drivers/gpu/drm/ttm/ttm_pool.c                |  931 +++++++++-
 drivers/gpu/drm/ttm/ttm_tt.c                  |   67 +
 drivers/gpu/drm/xe/Kconfig.profile            |   40 +
 drivers/gpu/drm/xe/tests/xe_bo.c              |    8 +-
 drivers/gpu/drm/xe/tests/xe_dma_buf.c         |    2 +-
 drivers/gpu/drm/xe/tests/xe_migrate.c         |   12 +-
 drivers/gpu/drm/xe/xe_bo.c                    | 1632 ++++++++++++++++-
 drivers/gpu/drm/xe/xe_bo.h                    |   15 +-
 drivers/gpu/drm/xe/xe_bo_types.h              |    6 +
 drivers/gpu/drm/xe/xe_debugfs.c               |   26 +
 drivers/gpu/drm/xe/xe_device.c                |   35 +
 drivers/gpu/drm/xe/xe_device_types.h          |   57 +
 drivers/gpu/drm/xe/xe_dma_buf.c               |    2 +-
 drivers/gpu/drm/xe/xe_ggtt.c                  |    2 +-
 drivers/gpu/drm/xe/xe_gt_stats.c              |    5 +
 drivers/gpu/drm/xe/xe_gt_stats_types.h        |   17 +
 drivers/gpu/drm/xe/xe_migrate.c               |  531 +++++-
 drivers/gpu/drm/xe/xe_migrate.h               |   17 +
 drivers/gpu/drm/xe/xe_pt.c                    |    2 +-
 drivers/gpu/drm/xe/xe_res_cursor.h            |   56 +-
 drivers/gpu/drm/xe/xe_svm.c                   |   36 +-
 drivers/gpu/drm/xe/xe_svm.h                   |    3 +-
 drivers/gpu/drm/xe/xe_trace_bo.h              |   90 +
 drivers/gpu/drm/xe/xe_userptr.c               |   55 +
 drivers/gpu/drm/xe/xe_userptr.h               |    1 +
 drivers/gpu/drm/xe/xe_vm.c                    |  149 +-
 drivers/gpu/drm/xe/xe_vm.h                    |    5 +
 include/drm/drm_gpusvm.h                      |   19 +
 include/drm/ttm/ttm_bo.h                      |   64 +
 include/drm/ttm/ttm_pool.h                    |   46 +
 include/drm/ttm/ttm_tt.h                      |   43 +-
 42 files changed, 4029 insertions(+), 189 deletions(-)

-- 
2.34.1

