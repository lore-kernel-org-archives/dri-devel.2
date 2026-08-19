Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25C5C5DF8B
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3834610ECFC;
	Wed, 19 Aug 2026 10:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mBX2NcrZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4D610E54E;
 Wed, 19 Aug 2026 10:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787137052; x=1818673052;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=sP01/4b7FuKKARMPlkNw6ESfAzF7voEyqpTp2DPD5Rg=;
 b=mBX2NcrZLwy37Cw4IAngQJwy0W6o/OlSFAkUU+6dAG37km0EofQaFZq4
 7VwPR1Ylh4IIRqA2EvPJepFwCfZvVO2rBqwwgS8nMlXUqpK1fv/6P/DSM
 TvSXTySMYInmAUlyCGWS6BbHKVX63WgzpLKnorH2UF8K4iF5M1FwWwyX7
 df4ffcq/tZ8XaHRQnQz99Vd/oHYbzd3JqxHNqs693V9zCoFOIZnG58G5j
 HLMo+014AI0052KELf7xAw2YKrv/xU9O+0rKqF71E4oTMf3nxNXoRxpVK
 7GDaOtPgRvDllBoTsZBtccwocX4mRvu08uYlhyMiK+K/hP93NnQTw0mSv w==;
X-CSE-ConnectionGUID: kJm/5G+FTuOf8QjpeuoYsw==
X-CSE-MsgGUID: hRGsjC2yQiWFZoz2Q2yrUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87566245"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="87566245"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 03:57:32 -0700
X-CSE-ConnectionGUID: I1w3rCl1QLCPkHiHK3b8qw==
X-CSE-MsgGUID: fkGxM+IYT5OVICvZaLKCiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; d="scan'208";a="265058901"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.245.244.176])
 ([10.245.244.176])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Aug 2026 03:57:30 -0700
Message-ID: <90e47436-3fe9-473c-8350-31ab5c1800d0@intel.com>
Date: Wed, 19 Aug 2026 11:57:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 1/2] gpu/buddy: replace dual-tree/force_merge with
 decoupled dirty tracker
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260819104242.10703-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260819104242.10703-1-Arunpravin.PaneerSelvam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 19/08/2026 11:42, Arunpravin Paneer Selvam wrote:
> The current buddy allocator maintains separate clear_tree[] and
> dirty_tree[] rbtrees per order, preventing coalescing between cleared
> and dirty buddies. Under mixed workloads, this creates a merge barrier:
> adjacent buddies frequently end up split across trees, forcing reliance
> on __force_merge() during allocation.
> 
> __force_merge() performs an O(N x max_order) scan under the VRAM manager
> lock, leading to allocation stalls and failures for large contiguous
> requests even when sufficient total free memory is available.
> 
> Solution
> 
> Replace the dual-tree design with:
> - A single free_tree[order] rbtree for dirty and mixed free blocks
>    (fully cleared free blocks float outside this tree)
> - A lightweight out-of-band dirty tracker (gpu_dirty_tracker)
> 
> Fully cleared free blocks are tracked outside the buddy trees using an
> augmented interval rbtree, enabling O(log E) lookup of the largest
> cleared extents.
> 
> Buddy coalescing is now unconditional in __gpu_buddy_free(), regardless
> of clear/dirty state. This removes the merge barrier and eliminates the
> need for __force_merge().
> 
> Benefits
> 
> - Correct high-order allocations after mixed clear/dirty workloads
> - Elimination of O(N x max_order) merge cost from the allocation path
> - O(log E) cleared-extent lookup replacing O(N) scans
> - Predictable allocation latency under fragmentation
> - Reduced complexity with a single tree per order
> 
> Test:
> dEQP-VK.memory.allocation.basic.size_8KiB.reverse.count_4000
> 
> Below data is from /sys/kernel/debug/dri/1/amdgpu_vram_mm:
> 
> Base (dual-tree), before VKCTS test:
>    order- 6 free:   6 MiB,  blocks: 26
>    order- 5 free:   1 MiB,  blocks: 15
>    order- 4 free: 960 KiB,  blocks: 15
>    order- 3 free:   5 MiB,  blocks: 171
>    order- 2 free:   2 MiB,  blocks: 176
>    order- 1 free:   1 MiB,  blocks: 165
>    order- 0 free:  16 KiB,  blocks: 4
> 
> Base (dual-tree), after VKCTS test:
>    order- 6 free: 768 KiB,  blocks: 3
>    order- 5 free: 499 MiB,  blocks: 3999
>    order- 4 free: 250 MiB,  blocks: 4001
>    order- 3 free: 129 MiB,  blocks: 4157
>    order- 2 free:  65 MiB,  blocks: 4161
>    order- 1 free:  63 MiB,  blocks: 8138
>    order- 0 free:  20 KiB,  blocks: 5
> 
> Dirty tracker, before VKCTS test:
>    order- 6 free:   4 MiB,  blocks: 19
>    order- 5 free:   2 MiB,  blocks: 18
>    order- 4 free: 704 KiB,  blocks: 11
>    order- 3 free:   5 MiB,  blocks: 168
>    order- 2 free:   2 MiB,  blocks: 174
>    order- 1 free:   1 MiB,  blocks: 167
>    order- 0 free:  32 KiB,  blocks: 8
> 
> Dirty tracker, after VKCTS test:
>    order- 6 free:   4 MiB,  blocks: 19
>    order- 5 free:   2 MiB,  blocks: 18
>    order- 4 free: 704 KiB,  blocks: 11
>    order- 3 free:   5 MiB,  blocks: 168
>    order- 2 free:   2 MiB,  blocks: 174
>    order- 1 free:   1 MiB,  blocks: 167
>    order- 0 free:  28 KiB,  blocks: 7
> 
> v2:
>   - Code-style cleanup and minor refactoring
>   - Renamed locals for clarity
> 
> v3:
>   - Keep cleared blocks inside free_tree[] instead of floating them.
>   - Add subtree_has_dirty rbtree augment for O(log N) dirty-first walk.
> 
> v4:
>   - Fixed checkpatch warnings.
>   - Optimized gpu_buddy_reset_clear() to a single post-order walk that
>     flips block headers and recomputes the rbtree augment in one pass.
>   - Propagate subtree_max_size top-down in insert_extent() so ancestors
>     are not left with stale values on no-rotation inserts. (sashiko)
>   - Drop the whole extent in gpu_dirty_tracker_mark_dirty() when the
>     inside-split allocation fails, avoiding a stale clear claim. (sashiko)
>   - Make gpu_dirty_tracker_find() alignment-aware and fall back to the
>     dirty tree on steered failure to avoid spurious -ENOSPC. (sashiko)
> 
> v5:
>   - Track dirty extents instead of cleared ones: steer dirty allocs onto
>     tracked dirty windows and pick clear allocs via a free-tree augment,
>     avoiding clear-memory wastage by keeping cleared free blocks untouched
>     during dirty allocation.
> 
> v6:
>   - Make __alloc_range_bias() return the highest/right-most address by
>     default, establishing top-down as the intended placement for
>     range-biased allocations.
>   - Honour GPU_BUDDY_CLEAR_ALLOCATION in __alloc_range_bias() by steering
>     the descent towards clear subtrees for non-top-down clear
>     requests. (sashiko)
>   - Skip dirty-tracker steering for offset-aligned requests so they keep
>     their min_block_size alignment. (sashiko)
>   - sashiko reported that the __GFP_NOFAIL dirty-extent allocations on
>     the free path could deadlock during memory reclaim, since that is a
>     GFP_KERNEL allocation on the free path; move to a per-tracker
>     mempool so extent nodes are guaranteed without __GFP_NOFAIL.
>     (sashiko)
>   - Derive each free block's clear/dirty class from the blocks already
>     in hand on split, free, alloc, trim and init instead of querying the
>     dirty tracker, removing the tracker lookups from the hot paths.
> 
> v7:
>   - Preserve mixed-block clear state in __gpu_buddy_free() when a mixed
>     split child is re-merged after an undone split. (sashiko)
>   - Prefer a fully-clear block over a mixed one of the same order via a
>     single ordered clear-state max augment on free_tree[].
> 
> v8:
>   - Coalesce contiguous dirty blocks in __gpu_buddy_free_list() into one
>     dirty extent update instead of one mark_dirty() per block. (Matthew)
> 
> v9:
>   - Reset has_clear on allocation so a mixed block taken whole and later
>     freed fully dirty is not re-tracked as mixed. (sashiko)
> 
> v10:
>   - Use a plain slab allocation for dirty extents; skip and log once on
>     failure. (Matthew)
>   - Assert a non-zero size in the dirty-tracker range helpers. (Matthew)
>   - Drop the cached clear_avail member; derive it on demand. (Matthew)
>   - Collapse the two dirty branches of gpu_buddy_reset_clear(). (Matthew)
>   - Move the gpu_block_state enum above the gpu_buddy_block kernel-doc
>     so the doc directly precedes its struct. (Matthew)
>   - Mark the gpu_dirty_tracker struct private. (Matthew)
>   - Preserve a block's clear state on non-clear allocation instead of
>     force-dirtying it. (Matthew)
>   - Drop the redundant header clear in gpu_buddy_block_trim(). (Matthew)
> 
> Assisted-by: Claude:claude-opus-4-8
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> ---

<snip>

>   
> +/**
> + * gpu_buddy_clear_avail - free space that is clear (zeroed), in bytes
> + * @mm: gpu buddy allocator
> + *
> + * A subset of @mm->avail. Derived on demand as @mm->avail minus the bytes
> + * the dirty tracker records as dirty, so it is always consistent with the
> + * tracker without a cached field to keep in sync. Zero for a fresh pool,
> + * which is fully dirty.
> + */
> +static inline u64 gpu_buddy_clear_avail(const struct gpu_buddy *mm)
> +{

gpu_buddy_driver_lock_held(mm);

Just to make it clear that avail & total_dirty need to be in-sync to 
always get something sane here?

Can be tweaked when merging.

> +	return mm->avail - mm->dirty.total_dirty;
> +}
> +
>   #ifdef CONFIG_LOCKDEP
>   /**
>    * gpu_buddy_driver_set_lock() - Set the lock protecting accesses to GPU BUDDY
> 
> base-commit: 063019ac51afffda4ab3d658701b086caa0c8e9e

