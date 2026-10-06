Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0791CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 09:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2387910E31B;
	Tue,  6 Oct 2026 09:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="F6mxR1Vi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3549B10E31B;
 Tue,  6 Oct 2026 09:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791280653; x=1822816653;
 h=message-id:date:mime-version:from:subject:to:cc:
 references:in-reply-to:content-transfer-encoding;
 bh=dvcD6Mdza44z18eesP636PVopkd0XIhdZd59/uZOhGc=;
 b=F6mxR1Vi9oZ5yyN0R+8MYQZEBagnJfjjbN7NJ33i+iiKm0iIayoBlCdH
 4pyTKCZE2f43Z397EU36kX5om4lGu0xti7PdDqJUDY/Q62sTxOI7LsTRv
 SAQbomQhVje2ASCcxxTb2X8AId9bis7kpOZiFUj2+scZGbhfDsd55U0kg
 Rc0aKpS893cyJLsTdx015nwKj0GpVJtDBgfGYdTlCqmhxrtUJs+p6nSYH
 syk9GBwCVxIa2t6OjtcBGxi9NzI2dKJg2L9U7XRIyTFeYuFpsJ60mJcMl
 j5QzR8Zu//9ZB9LuKEvcPhXgmAmY256BTRNzPckAbczJrWowbV+qxe9Oi g==;
X-CSE-ConnectionGUID: OTlK4mzsRJqnE6InS6mT1A==
X-CSE-MsgGUID: fNlB5dnQTsW6Ggcl4Raogg==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="15947"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="15947"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:57:29 -0700
X-CSE-ConnectionGUID: WVUKeT+DQvegMMdJ3lLKcA==
X-CSE-MsgGUID: DzbM6jpGSH+j6g70+7WoEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="276615721"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.244.81])
 ([10.245.244.81])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 02:57:22 -0700
Message-ID: <05785392-b9fd-4d3a-82c5-37b4b6cb5f91@intel.com>
Date: Tue, 6 Oct 2026 10:57:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Matthew Auld <matthew.auld@intel.com>
Subject: Re: [PATCH v2] gpu/buddy: add range-restricted contiguous allocation
 fallback
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20260930062117.585089-1-arunpravin.paneerselvam@amd.com>
 <254159a2-66f8-4fce-b185-84e81d126e25@intel.com>
 <b86fd371-289d-479f-bdfe-b2d6136d8d21@amd.com>
Content-Language: en-GB
In-Reply-To: <b86fd371-289d-479f-bdfe-b2d6136d8d21@amd.com>
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

On 05/10/2026 15:14, Arunpravin Paneer Selvam wrote:
> 
> 
> On 10/1/2026 11:58 PM, Matthew Auld wrote:
>> On 30/09/2026 07:21, Arunpravin Paneer Selvam wrote:
>>> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>>
>>> A range + contiguous allocation (e.g. a scanout FB confined to the
>>> CPU-visible VRAM aperture) rounds its size up to a power of two and
>>> requires a naturally aligned free block of that size; on a fragmented
>>> aperture no such aligned block may exist even though enough contiguous
>>> space is free, so the allocation fails with -ENOSPC.
>>>
>>> The non-range contiguous path already recovers from this via
>>> __alloc_contig_try_harder(), which stitches an exact-size span from
>>> smaller adjacent blocks, but that fallback was unreachable once
>>> GPU_BUDDY_RANGE_ALLOCATION was set. Give __alloc_contig_try_harder()
>>> a [range_start, range_end) window and route the range + contiguous
>>> case through it: each candidate placement is confined to the window
>>> and aligned to min_block_size. Non-range callers pass [0, mm->size),
>>> where the guards are no-ops, so the existing behaviour is unchanged.
>>> A KUnit regression test covers the fragmentation pattern.
>>>
>>> Resolves the igt@kms_plane@plane-panning-bottom-right@pipe-a/pipe-b
>>> regression.
>>>
>>> v2:
>>>   - Drop the split-undo patch; the range-bias search always descends to
>>>     an exact-order block or fails the split (already handled), so the
>>>     extra undo was redundant. (Matthew)
>>>   - Verified this fallback alone fixes the kms_plane regression.
>>>
>>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>>> decoupled dirty tracker")
>>
>> Patch looks more like totally new functionally/feature, so the fixes 
>> here is maybe unexpected? Did something in that fixes commit change 
>> something such that the try_harder is now needed, but that needs some 
>> expansion with bias + contig? Do we know exactly what changed here?
> That commit removed __force_merge(), which previously helped recover 
> larger contiguous allocations on demand. As a result, some range- 

__force_merge() got nuked, but IIRC I think that was essentially because 
we now "force merge" on free, so shouldn't we get the ~same result? Or 
is the fact that we force_merge() on every free giving a different 
layout of pages, and with some very some specific allocation pattern 
that difference subtly results in -ENOSPC, somehow?

> restricted contiguous allocation requests
> that used to succeed now fail with -ENOSPC (the kms_plane regression). 
> This patch restores that capability through the try_harder() stitching 
> logic, so the Fixes: tag reflects a
> regression introduced by that commit rather than new functionality.
>>
>>> Assisted-by: Claude:claude-opus-4-8
>>
>> Assisted-by: LLM
>>
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Signed-off-by: Arunpravin Paneer Selvam 
>>> <Arunpravin.PaneerSelvam@amd.com>
>>> ---
>>>   drivers/gpu/buddy.c                | 88 ++++++++++++++++--------------
>>>   drivers/gpu/tests/gpu_buddy_test.c | 83 ++++++++++++++++++++++++++--
>>>   2 files changed, 126 insertions(+), 45 deletions(-)
>>>
>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>> index 2f2aaadafe35..5265e1f6a318 100644
>>> --- a/drivers/gpu/buddy.c
>>> +++ b/drivers/gpu/buddy.c
>>> @@ -1685,26 +1685,14 @@ static int __gpu_buddy_alloc_range(struct 
>>> gpu_buddy *mm,
>>>                    blocks, total_allocated_on_err);
>>>   }
>>>   -static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
>>> -                    u64 unaligned_offset,
>>> -                    u64 size,
>>> -                    u64 min_block_size,
>>> -                    unsigned long flags,
>>> -                    struct list_head *blocks)
>>> -{
>>> -    u64 aligned_offset = round_down(unaligned_offset, min_block_size);
>>> -
>>> -    return __gpu_buddy_alloc_range(mm, aligned_offset, size, flags,
>>> -                       NULL, blocks);
>>> -}
>>> -
>>>   static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>>> +                     u64 range_start, u64 range_end,
>>>                        u64 size,
>>>                        u64 min_block_size,
>>>                        unsigned long flags,
>>>                        struct list_head *blocks)
>>>   {
>>> -    u64 rhs_offset, lhs_offset, filled;
>>> +    u64 rhs_offset, lhs_offset, filled, aligned;
>>>       struct gpu_buddy_block *block;
>>>       struct rb_root *root;
>>>       struct rb_node *iter;
>>> @@ -1734,20 +1722,24 @@ static int __alloc_contig_try_harder(struct 
>>> gpu_buddy *mm,
>>>                              flags, &filled, blocks);
>>>           if (err && err != -ENOSPC)
>>>               return err;
>>> -        if (!err && IS_ALIGNED(rhs_offset, min_block_size))
>>> +        if (!err && IS_ALIGNED(rhs_offset, min_block_size) &&
>>> +            rhs_offset >= range_start && rhs_offset + size <= 
>>> range_end)
>>>               return 0;
>>>           if (!err) {
>>>               /* Allocate the unaligned RHS offset using round_down */
>>>               gpu_buddy_free_list_internal(mm, blocks);
>>> -            err = __alloc_contig_aligned_retry(mm, rhs_offset,
>>> -                               size,
>>> -                               min_block_size,
>>> -                               flags, blocks);
>>> -            if (!err)
>>> -                return 0;
>>> -            if (err != -ENOSPC) {
>>> -                gpu_buddy_free_list_internal(mm, blocks);
>>> -                return err;
>>> +
>>> +            aligned = round_down(rhs_offset, min_block_size);
>>> +            if (aligned >= range_start &&
>>> +                aligned + size <= range_end) {
>>> +                err = __gpu_buddy_alloc_range(mm, aligned, size,
>>> +                                  flags, NULL, blocks);
>>
>> Did you consider doing a bias-range for [start, end] using 
>> min_block_size and using what it returns as the starting point, 
>> extending left/right? If that fails advance start and try again? Maybe 
>> what you have here is much better for the case you have in mind?
> I took a closer look at the alloc_range_bias approach. My understanding 
> is that this would repeatedly bias within [start, end], use the returned 
> min_block_size block as a starting point, and then extend left/right to 
> build the requested run.
> While that should work, every failed attempt may require splitting 
> higher-order blocks to obtain a min_block_size block, followed by a 
> free/merge back when the extension fails.
> The free-tree descent evaluates the available starting points through a 
> tree walk without any splitting or allocation just for enumeration, so I 
> kept that approach.
> Please let me know if there is a case where alloc_range_bias would 
> provide an advantage over the free-tree descent.
> 
> While evaluating it, I found two issues in the current try_harder() 
> implementation:
> 
> 1. It only searches free_tree[size_order]. This is insufficient when 
> min_block_size < size. For example, for a 128 KiB allocation (order-5) 
> with min_block_size = 4 KiB, free_tree[5] may be empty
> while two adjacent order-4 (64 KiB) blocks covering [64 KiB, 128 KiB] 
> and [128 KiB, 192 KiB] are free. These blocks still form a valid 
> order-5-sized contiguous run, but they can never appear in
> free_tree[5] because they are not mergeable buddies. As a result, a 
> search that only considers free_tree[5] will never find this placement. 
> v3 addresses this by walking the free tree from the
> requested size order down to min_order, while reusing the existing 
> extend/stitch logic and min_block_size alignment checks unchanged.
> 
> 2. The search is not restricted to the requested range. v3 confines the 
> walk to [range_start, range_end], skipping candidates at or above 
> range_end and stopping once the walk falls below range_start.
> This ensures that range-constrained allocations only consider free 
> blocks within the requested window and avoids performing allocation/free 
> attempts on blocks outside the specified range.
> For non-range callers, the effective window remains [0, mm->size], so 
> the behavior is unchanged.
> 
> Regards,
> Arun.
>>
>>> +                if (!err)
>>> +                    return 0;
>>> +                if (err != -ENOSPC) {
>>> +                    gpu_buddy_free_list_internal(mm, blocks);
>>> +                    return err;
>>> +                }
>>>               }
>>>               goto next;
>>>           }
>>> @@ -1759,15 +1751,17 @@ static int __alloc_contig_try_harder(struct 
>>> gpu_buddy *mm,
>>>             /* Allocate the unaligned LHS offset using round_down */
>>>           gpu_buddy_free_list_internal(mm, blocks);
>>> -        err = __alloc_contig_aligned_retry(mm, lhs_offset,
>>> -                           size,
>>> -                           min_block_size,
>>> -                           flags, blocks);
>>> -        if (!err)
>>> -            return 0;
>>> -        if (err != -ENOSPC) {
>>> -            gpu_buddy_free_list_internal(mm, blocks);
>>> -            return err;
>>> +
>>> +        aligned = round_down(lhs_offset, min_block_size);
>>> +        if (aligned >= range_start && aligned + size <= range_end) {
>>> +            err = __gpu_buddy_alloc_range(mm, aligned, size,
>>> +                              flags, NULL, blocks);
>>> +            if (!err)
>>> +                return 0;
>>> +            if (err != -ENOSPC) {
>>> +                gpu_buddy_free_list_internal(mm, blocks);
>>> +                return err;
>>> +            }
>>>           }
>>>   next:
>>>           gpu_buddy_free_list_internal(mm, blocks);
>>> @@ -2021,11 +2015,18 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>>       min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
>>>         if (order > mm->max_order || size > mm->size) {
>>> -        if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
>>> -            !(flags & GPU_BUDDY_RANGE_ALLOCATION))
>>> -            return __alloc_contig_try_harder(mm, original_size,
>>> +        if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
>>> +            u64 range_start, range_end;
>>> +
>>> +            range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? 
>>> start : 0;
>>> +            range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? end : 
>>> mm->size;
>>> +
>>> +            return __alloc_contig_try_harder(mm, range_start,
>>> +                             range_end,
>>> +                             original_size,
>>>                                original_min_size,
>>>                                flags, blocks);
>>> +        }
>>>             return -EINVAL;
>>>       }
>>> @@ -2058,9 +2059,14 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>>                * Try contiguous block allocation through
>>>                * try harder method.
>>>                */
>>> -            if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION &&
>>> -                !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
>>> -                err = __alloc_contig_try_harder(mm,
>>> +            if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
>>> +                u64 range_start, range_end;
>>> +
>>> +                range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? 
>>> start : 0;
>>> +                range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? 
>>> end : mm->size;
>>> +
>>> +                err = __alloc_contig_try_harder(mm, range_start,
>>> +                                range_end,
>>>                                   original_size,
>>>                                   original_min_size,
>>>                                   flags,
>>> @@ -2068,9 +2074,9 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>>                   if (!err)
>>>                       return 0;
>>>                   if (err != -ENOSPC)
>>> -                    return err;
>>> -                goto err_free;
>>> +                    goto err_free;
>>>               }
>>> +
>>>               err = -ENOSPC;
>>>               goto err_free;
>>>           } while (1);
>>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/ 
>>> gpu_buddy_test.c
>>> index b75d32ca6ca0..2c445870b808 100644
>>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>>> @@ -1251,6 +1251,77 @@ static void 
>>> gpu_test_buddy_alloc_contiguous(struct kunit *test)
>>>       gpu_buddy_fini(&mm);
>>>   }
>>>   +static void gpu_test_buddy_alloc_range_contiguous(struct kunit *test)
>>> +{
>>> +    const unsigned long ps = SZ_4K, mm_size = 16 * ps;
>>> +    const unsigned long range_end = 8 * ps;
>>> +    struct gpu_buddy_block *block, *prev;
>>> +    LIST_HEAD(allocated);
>>> +    struct gpu_buddy mm;
>>> +    LIST_HEAD(pin_lo);
>>> +    LIST_HEAD(pin_hi);
>>> +    u64 total;
>>> +
>>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, ps),
>>> +                   "buddy_init failed\n");
>>> +
>>> +    /*
>>> +     * Idea is to confine the test to the sub-range [0, 32K), which 
>>> a 12K
>>> +     * contiguous request (rounded up to 16K) splits into two naturally
>>> +     * aligned 16K slots: [0, 16K) and [16K, 32K). We pin the first 
>>> 4K page
>>> +     * of each slot ([0, 4K) and [16K, 20K)) so that neither aligned 
>>> slot
>>> +     * can satisfy the rounded-up 16K allocation, yet the freed 
>>> remainder
>>> +     * still leaves a contiguous 12K hole at offset 4K, which is 
>>> page-aligned
>>> +     * but not 16K-aligned. A 12K contiguous+range allocation must 
>>> therefore
>>> +     * fall back to stitching that span instead of returning -ENOSPC.
>>> +     */
>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>> +                   gpu_buddy_alloc_blocks(&mm, 0, ps, ps, ps,
>>> +                              &pin_lo, 0),
>>> +                   "failed to pin low page\n");
>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>> +                   gpu_buddy_alloc_blocks(&mm, 4 * ps, 5 * ps, ps,
>>> +                              ps, &pin_hi, 0),
>>> +                   "failed to pin high page\n");
>>> +
>>> +    /* No aligned 16K block is free; the range-aware fallback must 
>>> stitch
>>> +     * the unaligned [ps, 4*ps) hole instead of returning -ENOSPC.
>>> +     */
>>> +    KUNIT_ASSERT_FALSE_MSG(test,
>>> +                   gpu_buddy_alloc_blocks(&mm, 0, range_end, 3 * ps,
>>> +                              ps, &allocated,
>>> +                              GPU_BUDDY_CONTIGUOUS_ALLOCATION |
>>> +                              GPU_BUDDY_RANGE_ALLOCATION),
>>> +                   "range-restricted contiguous alloc failed\n");
>>> +
>>> +    /* The result must be exactly 3*ps, contiguous, and inside the 
>>> range. */
>>> +    total = 0;
>>> +    prev = NULL;
>>> +    list_for_each_entry(block, &allocated, link) {
>>> +        u64 offset = gpu_buddy_block_offset(block);
>>> +        u64 bsize = gpu_buddy_block_size(&mm, block);
>>> +
>>> +        KUNIT_EXPECT_TRUE_MSG(test, offset + bsize <= range_end,
>>> +                      "block [%llx, %llx) outside range\n",
>>> +                      offset, offset + bsize);
>>> +        if (prev)
>>> +            KUNIT_EXPECT_EQ_MSG(test,
>>> +                        gpu_buddy_block_offset(prev) +
>>> +                        gpu_buddy_block_size(&mm, prev),
>>> +                        offset,
>>> +                        "block at %llx not contiguous\n",
>>> +                        offset);
>>> +        prev = block;
>>> +        total += bsize;
>>> +    }
>>> +    KUNIT_EXPECT_EQ(test, total, 3 * ps);
>>> +
>>> +    gpu_buddy_free_list(&mm, &allocated, 0);
>>> +    gpu_buddy_free_list(&mm, &pin_lo, 0);
>>> +    gpu_buddy_free_list(&mm, &pin_hi, 0);
>>> +    gpu_buddy_fini(&mm);
>>> +}
>>> +
>>>   static void gpu_test_buddy_alloc_pathological(struct kunit *test)
>>>   {
>>>       u64 mm_size, size, start = 0;
>>> @@ -1534,10 +1605,13 @@ static void 
>>> gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
>>>                        GPU_BUDDY_RANGE_ALLOCATION);
>>>       KUNIT_EXPECT_EQ(test, err, -EINVAL);
>>>   -    /* CONTIGUOUS + RANGE should return -EINVAL (no try_harder for 
>>> RANGE) */
>>> -    err = gpu_buddy_alloc_blocks(&mm, 0, mm_size, size, SZ_4K, &blocks,
>>> -                     GPU_BUDDY_CONTIGUOUS_ALLOCATION | 
>>> GPU_BUDDY_RANGE_ALLOCATION);
>>> -    KUNIT_EXPECT_EQ(test, err, -EINVAL);
>>> +    /* CONTIGUOUS + RANGE should succeed via the range-aware 
>>> try_harder */
>>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, 
>>> mm_size, size,
>>> +                                SZ_4K, &blocks,
>>> +                                GPU_BUDDY_CONTIGUOUS_ALLOCATION |
>>> +                                GPU_BUDDY_RANGE_ALLOCATION),
>>> +                   "range contiguous alloc hit an error 
>>> size=%llu\n", size);
>>> +    gpu_buddy_free_list(&mm, &blocks, 0);
>>>         gpu_buddy_fini(&mm);
>>>   }
>>> @@ -1603,6 +1677,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>>>       KUNIT_CASE(gpu_test_buddy_alloc_pessimistic),
>>>       KUNIT_CASE(gpu_test_buddy_alloc_pathological),
>>>       KUNIT_CASE(gpu_test_buddy_alloc_contiguous),
>>> +    KUNIT_CASE(gpu_test_buddy_alloc_range_contiguous),
>>>       KUNIT_CASE(gpu_test_buddy_alloc_clear),
>>>       KUNIT_CASE(gpu_test_buddy_alloc_range),
>>>       KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
>>>
>>> base-commit: 744f262401cc2e1f3827496c72a47e072d31a852
>>
> 

