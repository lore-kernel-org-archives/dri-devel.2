Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDC7606A33A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jI0TxUOT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 194D610E297;
	Tue, 17 Nov 2026 15:03:05 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E518410E0F9;
 Tue, 17 Nov 2026 15:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794927779; x=1826463779;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=+J6AwQl1G0XFy3ZeXCW20mtiW0I+Uvvod3rmP12KMZw=;
 b=jI0TxUOTfgMtqYkTHrCZkcdkbJ8ewlmgXLut657HbVJxloKEEuuwfbys
 7wiQFfwQNwxG/u77jhsPHbipz81hx0SVdBqtK7eUP+S7t6iBNd2ktSgYg
 cEMN5ru4gz2FXDndktEF5TU3zvv1oWIs/pb3ZegwoHKhPIL/zemfsXHQK
 rhK5yRX5iz4xY0qyJEFhNKOeSaDbJviiisTWiNzMNPXNiS07ldzkQcM/B
 67wtleNUAsOhqoVaPlchV568aH7B2Ks+0zXjeHr1jHfQsiIPIp/zA4AfS
 1NVe6ZXBfUVsoOrp42p90vjz4bUDMoKW2RYNiye19CQqA89hjSwQJTnyy A==;
X-CSE-ConnectionGUID: kcocZ4h+TvCZKVhFgRZJaw==
X-CSE-MsgGUID: Ws9kJNbvSd6UNBtQTpN6/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3593412"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3593412"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 07:02:59 -0800
X-CSE-ConnectionGUID: fvwQIlTsSqyeiaig7/TVaA==
X-CSE-MsgGUID: QWRhJusLRLWn860MQZK4EQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9859846"
Received: from yadavs-z690i-a-ultra-plus.iind.intel.com ([10.190.216.90])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 07:02:57 -0800
From: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Subject: [PATCH v5 0/1] gpu/buddy: Fix quadratic cost of range-biased
 allocation
Date: Tue, 17 Nov 2026 20:24:36 +0530
Message-ID: <20261117145435.1629839-3-sanjay.kumar.yadav@intel.com>
X-Mailer: git-send-email 2.52.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Range-restricted allocations (GPU_BUDDY_RANGE_ALLOCATION) go through
__alloc_range_bias(), a depth-first walk over the buddy tree that visits
the higher-address child first. It skips blocks that are too small,
outside the range or ALLOCATED, but always descends SPLIT blocks, even
when nothing below them is free. Range allocations are placed top-down,
so they pack below the range end and each new allocation walks over all
blocks already allocated there: O(N) per allocation, O(N^2) in total,
under the driver's allocator lock.

This is a property of the range-biased allocation algorithm rather than
of any particular memory configuration. Any driver that repeatedly
restricts placement to a window can encounter this behavior once enough
small allocations accumulate in that window.

One configuration where the problem becomes particularly visible is a
small-BAR system. Drivers restrict every CPU-visible allocation to that
window with a range placement (fpfn = 0, lpfn = BAR size).

xe_pat@pt-caching-random-offsets does about 130k 4K range allocations
and hit the CI 180s inactivity timeout on a debug kernel inside
gpu_buddy_alloc_blocks(). With the full VRAM visible the same test does
not use the range path.

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

The patch tracks, per block, the largest order of any FREE block in its
subtree and lets __alloc_range_bias() skip subtrees that cannot satisfy
the request. Skipped subtrees contain nothing the old walk could split
or return, and the remaining blocks are visited in the same order, so
the selected block and placement are unchanged. The new s8 field uses
existing tail padding.

Results
  n_alloc     avg_blocks_visited        avg_allocation_time
              without fix  with fix     without fix  with fix
     4096          4141        46          10.7 us    0.293 us
    65536        127041        48           536 us    0.259 us
   126976        249911        47          1.46 ms    0.283 us

v2:
- Reword cover letter and commit message to describe this as a general
  fix for the algorithmic cost of range-biased allocation rather than a
  small-BAR specific issue (Matt A)
- No code changes

v3: (Sashiko)
- Use div_u64() in the KUnit test to fix the 32-bit build

v4: (Matt A)
- Drop the KUnit tests

Sanjay Yadav (1):
  gpu/buddy: Prune exhausted subtrees in range-biased allocation

 drivers/gpu/buddy.c       | 56 +++++++++++++++++++++++++++------------
 include/linux/gpu_buddy.h |  7 +++++
 2 files changed, 46 insertions(+), 17 deletions(-)

-- 
2.52.0

