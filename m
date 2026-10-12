Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2695BCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:16:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EEE510E802;
	Mon, 12 Oct 2026 11:16:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E88A410E1A0;
 Mon, 12 Oct 2026 11:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791803797; x=1823339797;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=CH24spR2AMdD6HY06GSfxVZKv2G1Us38uv8h96iv9XM=;
 b=PPlHrDJf79DTKtkmbMYO5Mh8i0oARWfTB0aMbF+Zcj7eHGsKf4y4TNdc
 0gUcjX2Vwcfqo3OI0oI2tBrr6kSlXIO0RBQQxPx6FqspKkQ1P2hKxZ8W4
 9iU//Jm7qXu4damFhlA32AqdtSdlzlsTFccAYlsdMdmYllHolwGVyRC+s
 CLkJjMewoZgc5x5oIpog5GZCGlZuUXWTcgKe6kfLVMCl7gEN3ClYWLa7q
 5kpY78IYufCdGewkaR6hsuXdYSNnCuzqQqEAVaDWR9fJKJQp2a1fd9MtT
 N0uMCD8Fm56eE/zJxmQXW/r7j32j1AIiHZMzLRqXoU0WgW9qzWCjVf+I2 g==;
X-CSE-ConnectionGUID: uYMZD2iQRye8GUan1JYgHA==
X-CSE-MsgGUID: afULPW+HRh2FAxc8BH7vdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11932"; a="408254"
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="408254"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 04:16:36 -0700
X-CSE-ConnectionGUID: sJREXrlwRrSvri8PaY3zJA==
X-CSE-MsgGUID: jIozyOnGR1q2EWak0Xpuug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,153,1787036400"; 
   d="scan'208";a="975545"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 04:16:35 -0700
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Subject: [PATCH 0/2] gpu/buddy: Fix quadratic cost of range-biased allocation
Date: Mon, 12 Oct 2026 16:40:45 +0530
Message-ID: <cover.1791802549.git.sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.52.0
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

Range-restricted allocations (GPU_BUDDY_RANGE_ALLOCATION) go through
__alloc_range_bias(), a depth-first walk over the buddy tree that visits
the higher-address child first. It skips blocks that are too small,
outside the range or ALLOCATED, but always descends SPLIT blocks, even
when nothing below them is free. Range allocations are placed top-down,
so they pack below the range end and each new allocation walks over all
blocks already allocated there: O(N) per allocation, O(N^2) in total,
under the driver's allocator lock.

On small-BAR systems only the start of VRAM is CPU accessible through
the PCI BAR. Drivers restrict every CPU-visible allocation to that
window with a range placement (fpfn = 0, lpfn = BAR size). In xe this
covers every pinned and mapped kernel BO (xe_bo_create_pin_map()),
including all page-table BOs, and user BOs created with
DRM_XE_GEM_CREATE_FLAG_NEEDS_VISIBLE_VRAM.

It is worst when VRAM is large but the BAR covers only part of it. On
the affected platform, VRAM is 160 GiB and the BAR is 32 GiB:

xe_pat@pt-caching-random-offsets creates 2 x 16384 4K BOs with
NEEDS_VISIBLE_VRAM and binds each at a random address in a 57-bit VA
space, which needs about three new page tables per bind. That is about
130k 4K range allocations in the visible window. In CI on a debug kernel
the test hit the 180s inactivity timeout inside gpu_buddy_alloc_blocks(),
called from xe_pt_create().

<6> [59.426526] [IGT] xe_pat: executing
<6> [59.436001] [IGT] xe_pat: starting subtest pt-caching-random-offsets
<6> [239.585293] task:xe_pat          state:R  running task     stack:0
pid:3700  tgid:3700  ppid:1957   task_flags:0x400100 flags:0x00000020
<6> [239.585304] Call Trace:
<6> [239.585307]  <TASK>
<6> [239.585309]  ? irqentry_exit+0x2a2/0x8d0
<6> [239.585314]  ? trace_hardirqs_off_finish+0xc7/0xe0
<6> [239.585320]  ? sysvec_apic_timer_interrupt+0x57/0xc0
<6> [239.585326]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
<6> [239.585334]  ? gpu_buddy_alloc_blocks+0x442/0xec0
<6> [239.585341]  ? gpu_buddy_alloc_blocks+0xa37/0xec0
<6> [239.585353]  ? xe_ttm_vram_mgr_new+0x1c7/0x340 [xe]
<6> [239.585506]  ? ttm_resource_alloc+0x50/0xd0 [ttm]
<6> [239.585518]  ? ttm_bo_alloc_at_place+0x84/0x180 [ttm]
<6> [239.585527]  ? ttm_bo_alloc_resource+0x115/0x5e0 [ttm]
<6> [239.585538]  ? ttm_bo_validate+0x94/0x1c0 [ttm]
<6> [239.585546]  ? lock_is_held_type+0xa3/0x130
<6> [239.585552]  ? ttm_bo_init_reserved+0xa5/0x1f0 [ttm]
<6> [239.585560]  ? xe_bo_init_locked+0x20a/0x650 [xe]
<6> [239.585616]  ? __pfx_xe_ttm_bo_destroy+0x10/0x10 [xe]
<6> [239.585672]  ? stack_depot_save_flags+0x28/0x960
<6> [239.585679]  ? __xe_bo_create_locked+0xb1/0xa20 [xe]
<6> [239.585733]  ? _raw_spin_unlock_irqrestore+0x52/0x80
<6> [239.585743]  ? __create_object+0x67/0xe0
<6> [239.585747]  ? trace_hardirqs_on+0x22/0xe0
<6> [239.585753]  ? _raw_spin_unlock_irqrestore+0x52/0x80
<6> [239.585760]  ? xe_bo_create_pin_map_at_aligned+0x51/0x1f0 [xe]
<6> [239.585813]  ? __kmalloc_cache_noprof+0x494/0x670
<6> [239.585819]  ? xe_bo_create_pin_map+0x1f/0x40 [xe]
<6> [239.585870]  ? xe_pt_create+0xb5/0x430 [xe]

Patch 1 tracks, per block, the largest order of any FREE block in its
subtree and lets __alloc_range_bias() skip subtrees that cannot satisfy
the request. Skipped subtrees contain nothing the old walk could split
or return, and the remaining blocks are visited in the same order, so
the selected block and placement are unchanged. The new s8 field uses
existing tail padding.

Patch 2 adds KUnit tests. One fills a range prefix the way small-BAR
drivers do and checks pruning deterministically by hiding a free block
behind an ancestor that reports no free space. The other checks the
metadata of every block after each state change, including coalescing,
rollback of a partial allocation, and trim.

Results
  n_alloc     avg_blocks_visited        avg_allocation_time
              without fix  with fix     without fix  with fix
     4096          4141        46          10.7 us    0.293 us
    65536        127041        48           536 us    0.259 us
   126976        249911        47          1.46 ms    0.283 us

Sanjay Yadav (2):
  gpu/buddy: Prune exhausted subtrees in range-biased allocation
  gpu/tests/buddy: Add range-bias pruning and free-order tracking tests

 drivers/gpu/buddy.c                |  31 +++
 drivers/gpu/tests/gpu_buddy_test.c | 307 +++++++++++++++++++++++++++++
 include/linux/gpu_buddy.h          |   7 +
 3 files changed, 345 insertions(+)

-- 
2.52.0

