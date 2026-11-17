Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255B3606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hPqAKj7x
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E07A10F5A3;
	Tue, 17 Nov 2026 09:57:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C125410F5B5;
 Tue, 17 Nov 2026 09:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794909445; x=1826445445;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=IA+mq3swVuvqjyGrM2KTcGrCIB0NuVm1ncsOeLYeuew=;
 b=hPqAKj7x29BHY5TCZMv260/wEINPjkku5QupkoN4zJccb6cSoIpcTD2T
 OQiKK21I1FbcVflr6z+DUWKyQYZLLSDooyqcj6iyDOzccQob7YVr391Tz
 fSi76nK1UyF3tBLJBYSvZKX0wUi3CltT5cBhMQqx9jT5gG/8ZlUl5P3uh
 Jsh2mTSGZmGzXPo1giBDZP2aZDt1URFNbj7sfReBGUviKS4yKHnkDmpla
 J/DieZFAcxmcyDGObr9+u2saqhsVvvA24vll3iiyoqD7uVbsphz+vuGTo
 Texqq6thu5/oTIb/FyoOYTZASXLBSlonl6dgO6BAsRK6rGPZHH5IgPvqp Q==;
X-CSE-ConnectionGUID: UmJwxlW1T+ue3xtri977qA==
X-CSE-MsgGUID: TjDvOaztRjyWtv2v5+aJAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3565219"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3565219"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 01:57:21 -0800
X-CSE-ConnectionGUID: giGsdx1FREChK0DgG+jZDg==
X-CSE-MsgGUID: l3hqllxbQYWi/0p4b1lDUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; d="scan'208";a="10116467"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO [10.245.244.57])
 ([10.245.244.57])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 01:57:18 -0800
Message-ID: <8b622510-5dff-4adc-abe9-db7b782692e2@intel.com>
Date: Tue, 17 Nov 2026 09:57:15 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] gpu/buddy: Prune exhausted subtrees in
 range-biased allocation
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>,
 dri-devel@lists.freedesktop.org, William Palacek <William.Palacek@amd.com>
Cc: intel-xe@lists.freedesktop.org, Joel Fernandes <joelagnelf@nvidia.com>
References: <20261102051633.2035348-3-sanjay.kumar.yadav@intel.com>
 <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
 <b07e279a-67f2-4d38-ba24-9ff2ca9a90fb@amd.com>
 <91f03c24-2bee-4872-bf09-ca54f81ccf50@intel.com>
 <3d156a96-ca2d-479b-b6af-d31b862b9467@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <3d156a96-ca2d-479b-b6af-d31b862b9467@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/2026 04:57, Arunpravin Paneer Selvam wrote:
> 
> 
> On 11/15/2026 9:23 PM, Yadav, Sanjay Kumar wrote:
>>
>> On 09-11-2026 12:10, Arunpravin Paneer Selvam wrote:
>>> Hi Sanjay,
>>>
>>> On 11/2/2026 10:46 AM, Sanjay Yadav wrote:
>>>> __alloc_range_bias() walks the buddy tree depth-first, higher address
>>>> first, and descends every SPLIT block even when nothing below it is
>>>> free. Range allocations are placed top-down, so they pack below the
>>>> range end and each new one walks every block already allocated there:
>>>> O(N) per allocation and O(N^2) for N allocations, under the allocator
>>>> lock.
>>>>
>>>> Track in each block the largest order of any FREE block in its subtree
>>>> (GPU_BUDDY_NO_FREE_ORDER if none), update it when a block is allocated
>>>> or freed, and skip subtrees that cannot satisfy the requested order.
>>>> Splitting needs no update of its own, as both children are marked free
>>>> right after and that propagates the new value up.
>>>> gpu_buddy_block_trim() detaches the block before freeing it, so updates
>>>> stop there while re-allocating inside it; recompute from the parent
>>>> once it is reattached.
>>>>
>>>> Skipped subtrees contain no FREE block of the requested order or
>>>> larger, so the old walk could neither split nor return anything there.
>>>> The remaining blocks are visited in the same order, so the selected
>>>> block and placement are unchanged.
>>> I am not receiving some of the emails you are. sending me. I think 
>>> there may be an issue with my mailbox, so I need to check that on my 
>>> side.
>>> William has also been working on improving the range-allocation 
>>> performance in drm_buddy. His patch is here:
>>>
>>> https://patchwork.freedesktop.org/patch/763478/
>>>
>>> Since both patches are trying to improve the same range-allocation 
>>> path, I would like to converge on a single upstream approach rather 
>>> than carry separate optimizations.
>>> I have put together a version based on William’s offset-sorted free- 
>>> tree approach, extending the search to be class-aware:
>>>
>>> https://gitlab.freedesktop.org/arunpravin24/drm-buddy-range-wip/-/ 
>>> commit/72414977d38f4bcf7a364c64f24aa7f25cf699d9
>>>
>>> With this approach, we can remove the buddy-tree DFS walk entirely. 
>>> Cleared blocks are located using the existing subtree_block_state 
>>> augmentation, and top-down placement comes directly from the offset- 
>>> sorted free trees, reducing the lookup to an O(log n) free-tree 
>>> search followed by a small bounded scan.
>>>
>>> @Sanjay, could you take a look at the version above? I think it would 
>>> be better to follow this approach upstream and create a patch with 
>>> the test cases around it.
>> I tested your WIP on our side (applied on current drm-tip, on top of
>> the merged two-pass guard).
>>
>> BMG, CPU-visible BAR resized to 4GB, xe_pat@pt-caching-random-offsets:
>>
>>   drm-tip                 ~48-51s
>>   drm-tip + my v4         ~0.7s
>>   drm-tip + your WIP      ~0.75s
>>  (drm-tip, full BAR       ~0.7s, range path not used)
>> So your version fixes the xe small-BAR case as well as v4 and looks 
>> good to me.
>> v4(already R-b/T-b by Joel) could go in first as the small fix and your
>> series replace the walk on top. Whichever you and Matt prefer.
> Okay, please confirm with Matthew. If this is the final version, I will 
> merge it upstream.

Yeah, ack from my side.

> 
> Regards,
> Arun.
>>>
>>> @William, could you also take a look at the version above? Hopefully 
>>> we can follow the same approach when porting this optimization to the 
>>> older dual-free-tree branch
>>> used by the ROCm versions you are targeting.
>>>
>>> Thanks,
>>>  Arun
>>>>
>>>> v4: (Matt A)
>>>> - Drop the update in mark_split(), the children being marked free
>>>>    updates the parent
>>>> - Detach the block before __mark_free() in gpu_buddy_block_trim(), so
>>>>    only the final update from the parent propagates up
>>>> - Drop the order, is_allocated() and is_free() checks in
>>>>    __alloc_range_bias() that the pruning check now covers
>>>>
>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>>>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>>>> Assisted-by: LLM
>>>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>>>> ---
>>>>   drivers/gpu/buddy.c       | 56 ++++++++++++++++++++++++++ 
>>>> +------------
>>>>   include/linux/gpu_buddy.h |  7 +++++
>>>>   2 files changed, 46 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>>> index 28cff97d57dc..93f70c98b235 100644
>>>> --- a/drivers/gpu/buddy.c
>>>> +++ b/drivers/gpu/buddy.c
>>>> @@ -602,6 +602,7 @@ static struct gpu_buddy_block 
>>>> *gpu_block_alloc(struct gpu_buddy *mm,
>>>>       block->header = offset;
>>>>       block->header |= order;
>>>>       block->parent = parent;
>>>> +    block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>>>>         RB_CLEAR_NODE(&block->rb);
>>>>   @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
>>>>       RB_CLEAR_NODE(&block->rb);
>>>>   }
>>>>   +static void update_subtree_max_free_order(struct gpu_buddy_block 
>>>> *block)
>>>> +{
>>>> +    while (block) {
>>>> +        s8 max_free;
>>>> +
>>>> +        if (gpu_buddy_block_is_free(block))
>>>> +            max_free = gpu_buddy_block_order(block);
>>>> +        else if (gpu_buddy_block_is_split(block))
>>>> +            max_free = max(block->left->subtree_max_free_order,
>>>> + block->right->subtree_max_free_order);
>>>> +        else
>>>> +            max_free = GPU_BUDDY_NO_FREE_ORDER;
>>>> +
>>>> +        if (block->subtree_max_free_order == max_free)
>>>> +            break;
>>>> +
>>>> +        block->subtree_max_free_order = max_free;
>>>> +        block = block->parent;
>>>> +    }
>>>> +}
>>>> +
>>>>   static void mark_allocated(struct gpu_buddy *mm,
>>>>                  struct gpu_buddy_block *block)
>>>>   {
>>>> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>>>>       mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>>>>         rbtree_remove(mm, block);
>>>> +    update_subtree_max_free_order(block);
>>>>   }
>>>>     static void __mark_free(struct gpu_buddy *mm,
>>>> @@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
>>>>       mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>>>>         rbtree_insert(mm, block);
>>>> +    update_subtree_max_free_order(block);
>>>>   }
>>>>     static void mark_free(struct gpu_buddy *mm,
>>>> @@ -869,6 +893,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>>>> size, u64 chunk_size)
>>>>         size = round_down(size, chunk_size);
>>>>   +    BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
>>>> +
>>>>       mm->size = size;
>>>>       mm->avail = size;
>>>>       mm->chunk_size = chunk_size;
>>>> @@ -1277,7 +1303,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>             list_del(&block->tmp_link);
>>>>   -        if (gpu_buddy_block_order(block) < order)
>>>> +        if (block->subtree_max_free_order < (int)order)
>>>>               continue;
>>>>             block_start = gpu_buddy_block_offset(block);
>>>> @@ -1286,9 +1312,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>           if (!overlaps(start, end, block_start, block_end))
>>>>               continue;
>>>>   -        if (gpu_buddy_block_is_allocated(block))
>>>> -            continue;
>>>> -
>>>>           if (block_start < start || block_end > end) {
>>>>               u64 adjusted_start = max(block_start, start);
>>>>               u64 adjusted_end = min(block_end, end);
>>>> @@ -1298,16 +1321,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>                   continue;
>>>>           }
>>>>   +        /* Not pruned at @order, so this block itself is FREE */
>>>>           if (contains(start, end, block_start, block_end) &&
>>>> -            order == gpu_buddy_block_order(block)) {
>>>> -            /*
>>>> -             * Find the free block within the range.
>>>> -             */
>>>> -            if (gpu_buddy_block_is_free(block))
>>>> -                return block;
>>>> -
>>>> -            continue;
>>>> -        }
>>>> +            order == gpu_buddy_block_order(block))
>>>> +            return block;
>>>>             if (!gpu_buddy_block_is_split(block)) {
>>>>               err = split_block(mm, block);
>>>> @@ -1856,13 +1873,17 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>>>                            gpu_buddy_block_offset(block),
>>>>                            gpu_buddy_block_size(mm, block));
>>>>   -    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>>>> GPU_BLOCK_DIRTY);
>>>> -    mm->avail += gpu_buddy_block_size(mm, block);
>>>> -
>>>> -    /* Prevent recursively freeing this node */
>>>> +    /*
>>>> +     * Detach the block to prevent recursively freeing this node, 
>>>> and to
>>>> +     * keep free-order updates from propagating above it until the 
>>>> trim
>>>> +     * is done.
>>>> +     */
>>>>       parent = block->parent;
>>>>       block->parent = NULL;
>>>>   +    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>>>> GPU_BLOCK_DIRTY);
>>>> +    mm->avail += gpu_buddy_block_size(mm, block);
>>>> +
>>>>       list_add(&block->tmp_link, &dfs);
>>>>       err =  __alloc_range(mm, &dfs, new_start, new_size,
>>>>                    was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
>>>> @@ -1881,6 +1902,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>>>       }
>>>>         block->parent = parent;
>>>> +    update_subtree_max_free_order(parent);
>>>>       return err;
>>>>   }
>>>>   EXPORT_SYMBOL(gpu_buddy_block_trim);
>>>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>>>> index ddc4eca84175..8037f5a0feb1 100644
>>>> --- a/include/linux/gpu_buddy.h
>>>> +++ b/include/linux/gpu_buddy.h
>>>> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>>>>       unsigned int subtree_max_alignment;
>>>>       struct list_head tmp_link;
>>>>       bool has_clear;
>>>> +    /*
>>>> +     * Largest order of any FREE block in this block's buddy 
>>>> subtree, or
>>>> +     * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
>>>> +     */
>>>> +    s8 subtree_max_free_order;
>>>>   };
>>>>   +#define GPU_BUDDY_NO_FREE_ORDER (-1)
>>>> +
>>>>   /* Order-zero must be at least SZ_4K */
>>>>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>>>
> 

