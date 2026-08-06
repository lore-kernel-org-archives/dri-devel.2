Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87032C5AC80
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 16:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4DCF10E351;
	Thu,  6 Aug 2026 16:45:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="OpRiGbVi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDE9310E339;
 Thu,  6 Aug 2026 16:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786034753; x=1817570753;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ejsE3VlpkC3lckrN2lcA+kcDvZd2cqeo/lYYqoRWyu8=;
 b=OpRiGbViEUGRD6GSDbb0Tx7Ti8Sgiin21aWj5pe8vpaii2NOSDs4IcPg
 RCJpSfSNdvOJdEzEb6ErUfS6RP+TsP+/VFQ//8g00zsCn8tRnD/DGD73e
 9z1X9K0Jj3FjatT116CeXxRHk/TsMigsJelNV8Qs5HrbU43lqIZYBKx1Y
 m2dAVtdru4pLfSk2EAuAvqFdMUVI+B8h6/S8kY0lKLt1PpDLPUXxnPQ4+
 bjiAd8d2a1dx074tZT9vLrm2T3kEVm2lcjv3aZ2f9czkFnO0v9afHXIIO
 wz7iSTRc9pD/5SaWCoVbBBXC7aZ21giDiS08/gSKST6tTI23yLmN7XYqQ A==;
X-CSE-ConnectionGUID: 4g3XSIXNRO+Avu4HJl2mKA==
X-CSE-MsgGUID: WM8SV5voQ7a4MmcLqbWQ2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86712315"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="86712315"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 09:45:52 -0700
X-CSE-ConnectionGUID: KpjMF5ZQR2qJsDTvdng6NA==
X-CSE-MsgGUID: WYhB8H7KQBayau/ijWisBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="285524503"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO [10.245.245.11])
 ([10.245.245.11])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 09:45:50 -0700
Message-ID: <7d2e8cbf-ff8e-491c-8a59-d05025df8565@intel.com>
Date: Thu, 6 Aug 2026 17:45:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] gpu/buddy: replace dual-tree/force_merge with
 decoupled dirty tracker
To: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260731070741.2654251-1-Arunpravin.PaneerSelvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260731070741.2654251-1-Arunpravin.PaneerSelvam@amd.com>
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

On 31/07/2026 08:07, Arunpravin Paneer Selvam wrote:
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
> Assisted-by: Claude:claude-opus-4-8
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

<snip>

>   
> @@ -620,13 +1100,18 @@ EXPORT_SYMBOL(gpu_buddy_reset_clear);
>   void gpu_buddy_free_block(struct gpu_buddy *mm,
>   			  struct gpu_buddy_block *block)
>   {
> +	u64 size = gpu_buddy_block_size(mm, block);
> +	u64 offset = gpu_buddy_block_offset(block);
> +
>   	gpu_buddy_driver_lock_held(mm);
>   	BUG_ON(!gpu_buddy_block_is_allocated(block));
> -	mm->avail += gpu_buddy_block_size(mm, block);
> -	if (gpu_buddy_block_is_clear(block))
> -		mm->clear_avail += gpu_buddy_block_size(mm, block);
>   
> -	__gpu_buddy_free(mm, block, false);
> +	mm->avail += size;
> +	if (!gpu_buddy_block_is_clear(block))
> +		gpu_dirty_tracker_mark_dirty(&mm->dirty, offset, size);
> +
> +	gpu_buddy_sync_clear_avail(mm);
> +	__gpu_buddy_free(mm, block);
>   }
>   EXPORT_SYMBOL(gpu_buddy_free_block);
>   
> @@ -641,9 +1126,9 @@ static void __gpu_buddy_free_list(struct gpu_buddy *mm,
>   
>   	list_for_each_entry_safe(block, on, objects, link) {
>   		if (mark_clear)
> -			mark_cleared(block);
> +			block->header |= GPU_BUDDY_HEADER_CLEAR;
>   		else if (mark_dirty)
> -			clear_reset(block);
> +			block->header &= ~GPU_BUDDY_HEADER_CLEAR;
>   		gpu_buddy_free_block(mm, block);

Just a thought, not a blocker or anything. It looks possible that as you 
loop through the blocks here you could easily extend the extent range if 
you keep finding something contig to the current extent, and then turn 
that into fewer mark_dirty() calls. If you ever encounter something 
non-contig you call mark_dirty() with whatever extent range you have 
now, and then start again. Obvious case is if you had a contig 
allocation which is more than one block, which could be turned into one 
mark_dirty().

