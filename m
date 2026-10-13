Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FBDFCC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:07:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0DE510E0E2;
	Tue, 13 Oct 2026 15:07:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D0D910E0E0;
 Tue, 13 Oct 2026 15:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791904015; x=1823440015;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=/os/0OBmuHhN6vE59+UC0SPms0S9/erqW6koDWRjc6w=;
 b=H0XaHOW2f1dm5AQGpzNEXSzsmhUkP6i6E+YRG00tjM4KOfvqb6MmJ01U
 Ic0qD8OZuBMeAAWo4QbeIaVKXRFB0mU9qjd0G+zo4PqfwZyDZiA17rYob
 WKAFG2GmXJy70nbNRyHu0w7Ahtw+KyBp8ZRQf/3h/uw3ArixvrLV4J5c8
 PcDON3jTzTxDIr/lJmZMtRBg9tEkuHVvySm/8MLrTViBBo1Q3ThEq8sRj
 rIgK0bIy5lAiETcRH/165ZcNGv0KicwKR4wUmRdGOVfTlg9JyYYF3KeLc
 bWLpTWLDFLebsAp4Furw+bXZgEzSas57InxFDC4cUSz9PKVdDw65vdRGf g==;
X-CSE-ConnectionGUID: QhaZXfePTX21mavHlqirwg==
X-CSE-MsgGUID: W2cbebP5TZ23HpBAw8Q6ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="517054"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="517054"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 08:06:54 -0700
X-CSE-ConnectionGUID: zHruqfdYTJOCMJshHNjjjw==
X-CSE-MsgGUID: dv6J0yrjRhS0gAUHICq6wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1245491"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.245.122])
 ([10.245.245.122])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 08:06:52 -0700
Message-ID: <343cf7b2-6241-4e3c-8b37-2f0ea75c6723@intel.com>
Date: Tue, 13 Oct 2026 16:06:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] gpu/buddy: restore two-pass clear/dirty guard for
 range-biased allocation
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20261009100546.1103622-1-arunpravin.paneerselvam@amd.com>
 <3e16b7d9-b1d6-4d6c-8f58-f6716fff71a6@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <3e16b7d9-b1d6-4d6c-8f58-f6716fff71a6@amd.com>
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

Hey,

Yes, going to go through it now. Did you already look over the Sashiko 
reports:
https://sashiko.dev/#/patchset/20261009100546.1103622-1-arunpravin.paneerselvam%40amd.com

Are they all false positive? I wanted to hold off reviewing if you were 
going to re-spin.

Also, on the "bugs" tab in Sashiko there was one open buddy issue, which 
I sent a fix for:
https://lore.kernel.org/intel-xe/20261006110706.1636971-2-matthew.auld@intel.com/

Please take a look at that.

On 13/10/2026 15:31, Arunpravin Paneer Selvam wrote:
> Hi Matthew,
> Could you please review the v4.
> 
> Thanks,
> Arun.
> 
> On 10/9/2026 3:35 PM, Arunpravin Paneer Selvam wrote:
>> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>>
>> Range-restricted allocations (the visible-VRAM aperture) skip
>> dirty_steer_window() and reach __alloc_range_bias() with no clear/dirty
>> eligibility guard, so a dirty allocation freely splits clear extents (and
>> vice versa), interleaving the two classes until no large same-class run
>> survives and a 4K scanout pin fails with -ENOSPC. Use a two-pass range
>> search instead: block_incompatible() rejects opposite-class blocks in the
>> strict pass and relaxes only when the strict pass returns -ENOSPC, so a
>> request still succeeds when only opposite-class space remains. A KUnit
>> regression test covers the interleaving pattern and fails without the
>> guard.
>>
>> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with 
>> decoupled dirty tracker")
>> Assisted-by: LLM
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
>> ---
>>   drivers/gpu/buddy.c                | 71 ++++++++++++++----------------
>>   drivers/gpu/tests/gpu_buddy_test.c | 65 +++++++++++++++++++++++++++
>>   2 files changed, 99 insertions(+), 37 deletions(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index 2f2aaadafe35..6566bad4fef1 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -1240,11 +1240,19 @@ static void __gpu_buddy_undo_splits(struct 
>> gpu_buddy *mm,
>>       }
>>   }
>> +static bool block_incompatible(struct gpu_buddy_block *block, 
>> unsigned int flags)
>> +{
>> +    bool needs_clear = flags & GPU_BUDDY_CLEAR_ALLOCATION;
>> +
>> +    return needs_clear != gpu_buddy_block_is_clear(block);
>> +}
>> +
>>   static struct gpu_buddy_block *
>>   __alloc_range_bias(struct gpu_buddy *mm,
>>              u64 start, u64 end,
>>              unsigned int order,
>> -           unsigned long flags)
>> +           unsigned long flags,
>> +           bool fallback)
>>   {
>>       u64 req_size = mm->chunk_size << order;
>>       struct gpu_buddy_block *block;
>> @@ -1258,9 +1266,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>        * This range-constrained search hands back the highest/right-most
>>        * address that satisfies the request: the roots are seeded 
>> high-to-low
>>        * and the right (higher-address) child is descended first, making
>> -     * top-down the default placement here. A non-top-down clear 
>> request is
>> -     * the only exception, where the descent is biased towards clear or
>> -     * clear-containing subtrees to satisfy the clear preference.
>> +     * top-down the default placement here.
>>        */
>>       for (i = mm->n_roots - 1; i >= 0; --i)
>>           list_add_tail(&mm->roots[i]->tmp_link, &dfs);
>> @@ -1298,6 +1304,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>                   continue;
>>           }
>> +        if (!fallback && block_incompatible(block, flags))
>> +            continue;
>> +
>>           if (contains(start, end, block_start, block_end) &&
>>               order == gpu_buddy_block_order(block)) {
>>               /*
>> @@ -1315,38 +1324,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>                   goto err_undo;
>>           }
>> -        /*
>> -         * Top-down is a strict address-placement policy, so when it is
>> -         * requested we ignore clear steering and simply descend the
>> -         * right (higher-address) child first. Only a non-top-down clear
>> -         * request biases the descent towards clear/has_clear subtrees.
>> -         */
>> -        if ((flags & GPU_BUDDY_CLEAR_ALLOCATION) &&
>> -            !(flags & GPU_BUDDY_TOPDOWN_ALLOCATION)) {
>> -            struct gpu_buddy_block *prefer;
>> -
>> -            if (gpu_buddy_block_is_clear(block->right))
>> -                prefer = block->right;
>> -            else if (gpu_buddy_block_is_clear(block->left))
>> -                prefer = block->left;
>> -            else if (block->right->has_clear)
>> -                prefer = block->right;
>> -            else if (block->left->has_clear)
>> -                prefer = block->left;
>> -            else
>> -                prefer = block->right;
>> -
>> -            if (prefer == block->right) {
>> -                list_add(&block->left->tmp_link, &dfs);
>> -                list_add(&block->right->tmp_link, &dfs);
>> -            } else {
>> -                list_add(&block->right->tmp_link, &dfs);
>> -                list_add(&block->left->tmp_link, &dfs);
>> -            }
>> -        } else {
>> -            list_add(&block->left->tmp_link, &dfs);
>> -            list_add(&block->right->tmp_link, &dfs);
>> -        }
>> +        list_add(&block->left->tmp_link, &dfs);
>> +        list_add(&block->right->tmp_link, &dfs);
>>       } while (1);
>>       return ERR_PTR(-ENOSPC);
>> @@ -1361,6 +1340,24 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>       return ERR_PTR(err);
>>   }
>> +static struct gpu_buddy_block *
>> +__gpu_buddy_alloc_range_bias(struct gpu_buddy *mm,
>> +                 u64 start, u64 end,
>> +                 unsigned int order,
>> +                 unsigned long flags)
>> +{
>> +    struct gpu_buddy_block *block;
>> +    bool fallback = false;
>> +
>> +    block = __alloc_range_bias(mm, start, end, order,
>> +                   flags, fallback);
>> +    if (IS_ERR(block))
>> +        return __alloc_range_bias(mm, start, end, order,
>> +                      flags, !fallback);
>> +
>> +    return block;
>> +}
>> +
>>   /* Return the highest-address free block of at least @order. */
>>   static struct gpu_buddy_block *
>>   get_maxblock(struct gpu_buddy *mm,
>> @@ -1924,7 +1921,7 @@ __gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>>       if (flags & GPU_BUDDY_RANGE_ALLOCATION) {
>>           /* Allocate traversing within the range */
>> -        block = __alloc_range_bias(mm, start, end, order, flags);
>> +        block = __gpu_buddy_alloc_range_bias(mm, start, end, order, 
>> flags);
>>           if (!IS_ERR(block) || !steered)
>>               return block;
>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/ 
>> gpu_buddy_test.c
>> index b75d32ca6ca0..3eaa261571bf 100644
>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>> @@ -1597,6 +1597,70 @@ static int gpu_buddy_suite_init(struct 
>> kunit_suite *suite)
>>       return 0;
>>   }
>> +static void gpu_test_buddy_alloc_range_clear_guard(struct kunit *test)
>> +{
>> +    const unsigned long chunk = SZ_1M, mm_size = SZ_4M;
>> +    struct gpu_buddy_block *block;
>> +    LIST_HEAD(high_clear_a);
>> +    LIST_HEAD(high_clear_b);
>> +    LIST_HEAD(low_dirty);
>> +    struct gpu_buddy mm;
>> +    LIST_HEAD(barrier);
>> +    LIST_HEAD(result);
>> +
>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
>> +                   "buddy_init failed\n");
>> +
>> +    /*
>> +     * Lay out a 4 MiB aperture as three regions:
>> +     *
>> +     *   [0,  1M)   dirty free
>> +     *   [1M, 2M)   allocated  (barrier, keeps the two halves un- 
>> mergeable)
>> +     *   [2M, 4M)   clear free (one naturally aligned 2 MiB extent)
>> +     *
>> +     * A dirty (non-clear) range allocation must take the low dirty 
>> block
>> +     * and leave the large clear extent intact. Without the guard the
>> +     * top-down search cuts the higher clear extent instead and 
>> returns a
>> +     * clear block -- the interleaving that fragments the aperture and
>> +     * ultimately fails a large same-class scanout allocation.
>> +     */
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 0, chunk, chunk, chunk,
>> +                              &low_dirty, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "alloc [0, 1M) failed\n");
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, chunk, 2 * chunk, 
>> chunk, chunk,
>> +                              &barrier, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "alloc [1M, 2M) failed\n");
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 2 * chunk, 3 * chunk, 
>> chunk, chunk,
>> +                              &high_clear_a, 
>> GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "alloc [2M, 3M) failed\n");
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 3 * chunk, 4 * chunk, 
>> chunk, chunk,
>> +                              &high_clear_b, 
>> GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "alloc [3M, 4M) failed\n");
>> +
>> +    /* [2M, 4M) coalesces into one aligned clear extent; [0, 1M) 
>> stays dirty. */
>> +    gpu_buddy_free_list(&mm, &low_dirty, 0);
>> +    gpu_buddy_free_list(&mm, &high_clear_a, GPU_BUDDY_CLEARED);
>> +    gpu_buddy_free_list(&mm, &high_clear_b, GPU_BUDDY_CLEARED);
>> +
>> +    KUNIT_ASSERT_FALSE_MSG(test,
>> +                   gpu_buddy_alloc_blocks(&mm, 0, mm_size, chunk, chunk,
>> +                              &result, GPU_BUDDY_RANGE_ALLOCATION),
>> +                   "dirty range alloc failed\n");
>> +
>> +    block = list_first_entry(&result, struct gpu_buddy_block, link);
>> +    KUNIT_EXPECT_FALSE_MSG(test, gpu_buddy_block_is_clear(block),
>> +                   "dirty range alloc cut the clear extent 
>> (offset=%llx)\n",
>> +                   gpu_buddy_block_offset(block));
>> +
>> +    gpu_buddy_free_list(&mm, &result, 0);
>> +    gpu_buddy_free_list(&mm, &barrier, 0);
>> +    gpu_buddy_fini(&mm);
>> +}
>> +
>>   static struct kunit_case gpu_buddy_tests[] = {
>>       KUNIT_CASE(gpu_test_buddy_alloc_limit),
>>       KUNIT_CASE(gpu_test_buddy_alloc_optimistic),
>> @@ -1606,6 +1670,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>>       KUNIT_CASE(gpu_test_buddy_alloc_clear),
>>       KUNIT_CASE(gpu_test_buddy_alloc_range),
>>       KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
>> +    KUNIT_CASE(gpu_test_buddy_alloc_range_clear_guard),
>>       KUNIT_CASE_SLOW(gpu_test_buddy_fragmentation_performance),
>>       KUNIT_CASE_SLOW(gpu_test_buddy_dirty_tracker_performance),
>>       KUNIT_CASE(gpu_test_buddy_alloc_exceeds_max_order),
>>
>> base-commit: f146c6086b792cb2c6b3ce5106f0cce62e408df8
> 

