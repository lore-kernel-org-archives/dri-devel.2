Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BC7606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Dgh3f2S6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85C0D10F4C3;
	Tue, 20 Oct 2026 10:39:24 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74FB510EBB9;
 Tue, 20 Oct 2026 10:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792492759; x=1824028759;
 h=message-id:date:mime-version:subject:from:to:references:
 in-reply-to:content-transfer-encoding;
 bh=d+irqP4gRAlW4o26RaUF8mqP4MaaD0lWMX36dRHY7NU=;
 b=Dgh3f2S6KCNHtPARuDSb91O9dUWTwwFj7B3fPaUV52KSD/sv+8cMlVl6
 TapCdfxpRH5UBjYWkjGxRQBoaYAa+2zVyvBEOZsOC8MiYlUtUeiBsb3g3
 N7seCUcxVIzZcXizULwt8eih8yst4mVuN6JIz6idoiMUHHfcBOwOoKhVB
 XD5EhW1HLtlXwdhkI4hHANDaTEEEUl/GSX7Vs5zW+kZuUvll+QSiNWrjq
 G+Cmp8pF4+majQUYD16Jzv0PvYXCloD19BCWMZdlrlBT1GB3f2UxL4hKg
 yJoFCSCxaMLRIDckphhZz+DuDn8ellI567jFTacClk9Bo2/W1mNhqjowY Q==;
X-CSE-ConnectionGUID: SWmniO1/S66AMRlXRnB2xg==
X-CSE-MsgGUID: 9UrbAdGAS6KrE8OjwUodXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1202685"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1202685"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 03:39:18 -0700
X-CSE-ConnectionGUID: +pG71t18T5qs0/96Ed3XVw==
X-CSE-MsgGUID: Y/hTnJt5Th2JgJV52I4P/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2673831"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO [10.245.244.166])
 ([10.245.244.166])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 03:39:17 -0700
Message-ID: <a9c59d5c-9fb1-4207-a05b-3f5d52a3239e@intel.com>
Date: Tue, 20 Oct 2026 11:39:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
From: Matthew Auld <matthew.auld@intel.com>
To: sashiko-reviews@lists.linux.dev,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
References: <20261020055537.1640552-1-arunpravin.paneerselvam@amd.com>
 <sashiko-outbox-178464@kernel.org>
 <30e81db2-a56a-464b-93ea-c74aa161fdde@intel.com>
Content-Language: en-GB
In-Reply-To: <30e81db2-a56a-464b-93ea-c74aa161fdde@intel.com>
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/2026 10:52, Matthew Auld wrote:
> On 20/10/2026 09:00, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential 
>> issue(s) to consider:
>> - [High] gpu/buddy: block_incompatible() mishandles split and mixed 
>> blocks in __alloc_range_bias()
>> -- 
>>
>> commit 6dff7f0e6dce9c68ecb98f2d911199843d2b4401
>> Author: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>
>> gpu/buddy: restore two-pass clear/dirty guard for range-biased allocation
>>
>> This commit introduces a two-pass search in 
>> __gpu_buddy_alloc_range_bias()
>> using block_incompatible() in the strict pass to prevent range-restricted
>> allocations from splitting opposite-class (clear vs. dirty) blocks unless
>> no matching blocks exist in the range.
>>
>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>> index 503f7d5934e4b..91935c71c5255 100644
>>> --- a/drivers/gpu/buddy.c
>>> +++ b/drivers/gpu/buddy.c
>>> @@ -1240,11 +1240,19 @@ static void __gpu_buddy_undo_splits(struct 
>>> gpu_buddy *mm,
>>>       }
>>>   }
>>> +static bool block_incompatible(struct gpu_buddy_block *block, 
>>> unsigned int flags)
>>> +{
>>> +    bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
>>> +
>>> +    return needs_clear != gpu_buddy_block_is_clear(block);
>>> +}
>>> +
>>>   static struct gpu_buddy_block *
>>>   __alloc_range_bias(struct gpu_buddy *mm,
>>>              u64 start, u64 end,
>>>              unsigned int order,
>>> -           unsigned long flags)
>>> +           unsigned long flags,
>>> +           bool fallback)
>>>   {
>>
>> [ ... ]
>>
>>> @@ -1298,6 +1304,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>                   continue;
>>>           }
>>> +        if (!fallback && block_incompatible(block, flags))
>>> +            continue;
>>> +
>>>           if (contains(start, end, block_start, block_end) &&
>>>               order == gpu_buddy_block_order(block)) {
>>>               /*
>>> @@ -1315,38 +1324,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>                   goto err_undo;
>>>           }
>>> -        /*
>>> -         * Top-down is a strict address-placement policy, so when it is
>>> -         * requested we ignore clear steering and simply descend the
>>> -         * right (higher-address) child first. Only a non-top-down 
>>> clear
>>> -         * request biases the descent towards clear/has_clear subtrees.
>>> -         */
>>> -        if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
>>> -            !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
>>> -            struct gpu_buddy_block *prefer;
>>> -
>>> -            if (gpu_buddy_block_is_clear(block->right))
>>> -                prefer = block->right;
>>> -            else if (gpu_buddy_block_is_clear(block->left))
>>> -                prefer = block->left;
>>> -            else if (block->right->has_clear)
>>> -                prefer = block->right;
>>> -            else if (block->left->has_clear)
>>> -                prefer = block->left;
>>> -            else
>>> -                prefer = block->right;
>>> -
>>> -            if (prefer == block->right) {
>>> -                list_add(&block->left->tmp_link, &dfs);
>>> -                list_add(&block->right->tmp_link, &dfs);
>>> -            } else {
>>> -                list_add(&block->right->tmp_link, &dfs);
>>> -                list_add(&block->left->tmp_link, &dfs);
>>> -            }
>>> -        } else {
>>> -            list_add(&block->left->tmp_link, &dfs);
>>> -            list_add(&block->right->tmp_link, &dfs);
>>> -        }
>>> +        list_add(&block->left->tmp_link, &dfs);
>>> +        list_add(&block->right->tmp_link, &dfs);
>>>       } while (1);
>>
>> [Severity: High]
>> Does calling block_incompatible() on every visited node in
>> __alloc_range_bias() before checking whether the block is split or mixed
>> mishandle internal GPU_BUDDY_SPLIT nodes and coalesced GPU_BLOCK_MIXED 
>> free
>> blocks?
>>
>> First, when mark_split() transitions a block to GPU_BUDDY_SPLIT, it 
>> leaves
>> the previous GPU_BUDDY_HEADER_CLEAR bit intact on the internal node:
>>
>> drivers/gpu/buddy.c:mark_split() {
>>     block->header &= ~GPU_BUDDY_HEADER_STATE;
>>     block->header |= GPU_BUDDY_SPLIT;
>>     ...
>> }
>>
>> Because gpu_buddy_init() initializes roots as dirty, any root or ancestor
>> split while dirty keeps gpu_buddy_block_is_clear(block) == false while 
>> any
>> descendant remains allocated. Conversely, a clear block that is split and
>> later has a descendant freed as dirty keeps 
>> gpu_buddy_block_is_clear(block)
>> == true on the split ancestor.
>>
>> When __gpu_buddy_alloc_range_bias() runs the first pass (fallback = 
>> false),
>> __alloc_range_bias() evaluates block_incompatible(block, flags) on those
>> GPU_BUDDY_SPLIT ancestors and skips the entire subtree without descending
>> into its children. If no other root satisfies the request, the first pass
>> returns -ENOSPC and __gpu_buddy_alloc_range_bias() falls back to the 
>> second
>> pass (fallback = true), where block_incompatible() is disabled and the
>> clear/has_clear child-ordering preference has been removed, causing the
>> search to split the highest-address extent regardless of class.
>>
>> Second, __gpu_buddy_free() coalesces adjacent clear and dirty free 
>> buddies
>> into a single GPU_BUDDY_FREE block with state GPU_BLOCK_MIXED, which has
>> gpu_buddy_block_is_clear(block) == false and block->has_clear == true:
>>
>> 1. For clear range allocations (flags & GPU_BUDDY_CLEAR_ALLOCATION), 
>> Pass 1
>>     sees gpu_buddy_block_is_clear(block) == false on a GPU_BLOCK_MIXED 
>> block
>>     and skips it via block_incompatible() without splitting it to 
>> reach the
>>     clear sub-blocks inside. Pass 2 then splits the mixed block 
>> without clear
>>     child-steering and unconditionally visits block->right first, 
>> returning a
>>     dirty block whenever the clear half is in block->left.
>>
>> 2. For dirty range allocations (!(flags & GPU_BUDDY_CLEAR_ALLOCATION)),
>>     block_incompatible() returns false on a higher-order GPU_BLOCK_MIXED
>>     block because gpu_buddy_block_is_clear(block) is false. Pass 1 
>> then calls
>>     split_block(mm, block), which reclassifies block->left and block- 
>> >right
>>     via mark_free(). If the child overlapping [start, end) is clear 
>> while the
>>     dirty child lies outside [start, end), Pass 1 rejects the clear 
>> child via
>>     block_incompatible() and skips the other child without calling
>>     __gpu_buddy_undo_splits().
>>
>> Wouldn't leaving that split GPU_BLOCK_MIXED block unmerged keep both
>> children in GPU_BUDDY_FREE state, preventing ancestor coalescing on 
>> teardown
>> and triggering gpu_buddy_assert(gpu_buddy_block_is_free(mm->roots[i])) 
>> while
>> leaking the split child gpu_buddy_block structures in gpu_buddy_fini()?
> 
> Analysis looks correct to me. We assume if you get as far as doing an 
> actual split, then that must mean there is something in there which is 
> compatible, either you find it with some number of splits or one of the 
> split calls hits an error, which takes care to undo the splits. But now 
> with that compat check, this breaks, since we don't know ahead of time 
> if it will find something which is also compat. Arun, thoughts?

Maybe something like: 
https://gitlab.freedesktop.org/mwa/kernel/-/commit/c611df39a268843021546f86754e20f07c7bdc87

So inject the parent node into the dfs for each split, and since we 
visit everything or find a suitable node, it should undo the splits as 
we go, I think.

> 
>>
>> [ ... ]
>>
> 

