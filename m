Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3DCCA5FDD
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 18:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9A9310E3EF;
	Thu,  1 Oct 2026 18:29:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mpm+Q5yW";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79A5A10E2B5;
 Thu,  1 Oct 2026 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790879342; x=1822415342;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=E81U4XJM9pN1WjMWQPIEK/Y9pJ5Co2fGYxI2NjKfu2k=;
 b=mpm+Q5yW1BiqAiAtC1w/AJYSYdFkkzymgMMTa0PBSwuPojmYTwhBN1Hy
 4RpQOPYhHipygXbbcEE4MPgCw/K6+lYj0TqtaR7ZeNIVRH8guaV0t8t9A
 Ja1+P7adYwibKHpS7WZV4PFDEKb1zliwCtLEvhpnoVu1q/otNHw1kf93j
 XpluppOqGG/pa7SIChrs4wOx1s8WOiJYHiAmI+ZJKvWH6GMsZalFO6VlW
 7xwdu5NgNM0PZgv0M7eaJ8F9e1s3OG48lax5p9xGJMCgkeYoAFeU8HbDK
 sJHoOLDdf7dgDNeMd2oLtYajrMyAvSw1ZVS/bSH5R71ffKUeGvxT2CSAz Q==;
X-CSE-ConnectionGUID: 3wXSaCaSTf+f2FhlMRwhTQ==
X-CSE-MsgGUID: JfHq+e6yTra34X0026OAxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91509358"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="91509358"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 11:29:01 -0700
X-CSE-ConnectionGUID: SGsb97rOTWmaMxFRkaxAyA==
X-CSE-MsgGUID: Ud98J+BNQOuAO9PDSEAlxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="275593666"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO [10.245.244.54])
 ([10.245.244.54])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 11:28:59 -0700
Message-ID: <254159a2-66f8-4fce-b185-84e81d126e25@intel.com>
Date: Thu, 1 Oct 2026 19:28:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] gpu/buddy: add range-restricted contiguous allocation
 fallback
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20260930062117.585089-1-arunpravin.paneerselvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260930062117.585089-1-arunpravin.paneerselvam@amd.com>
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

On 30/09/2026 07:21, Arunpravin Paneer Selvam wrote:
> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> 
> A range + contiguous allocation (e.g. a scanout FB confined to the
> CPU-visible VRAM aperture) rounds its size up to a power of two and
> requires a naturally aligned free block of that size; on a fragmented
> aperture no such aligned block may exist even though enough contiguous
> space is free, so the allocation fails with -ENOSPC.
> 
> The non-range contiguous path already recovers from this via
> __alloc_contig_try_harder(), which stitches an exact-size span from
> smaller adjacent blocks, but that fallback was unreachable once
> GPU_BUDDY_RANGE_ALLOCATION was set. Give __alloc_contig_try_harder()
> a [range_start, range_end) window and route the range + contiguous
> case through it: each candidate placement is confined to the window
> and aligned to min_block_size. Non-range callers pass [0, mm->size),
> where the guards are no-ops, so the existing behaviour is unchanged.
> A KUnit regression test covers the fragmentation pattern.
> 
> Resolves the igt@kms_plane@plane-panning-bottom-right@pipe-a/pipe-b
> regression.
> 
> v2:
>   - Drop the split-undo patch; the range-bias search always descends to
>     an exact-order block or fails the split (already handled), so the
>     extra undo was redundant. (Matthew)
>   - Verified this fallback alone fixes the kms_plane regression.
> 
> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")

Patch looks more like totally new functionally/feature, so the fixes 
here is maybe unexpected? Did something in that fixes commit change 
something such that the try_harder is now needed, but that needs some 
expansion with bias + contig? Do we know exactly what changed here?

> Assisted-by: Claude:claude-opus-4-8

Assisted-by: LLM

> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/buddy.c                | 88 ++++++++++++++++--------------
>   drivers/gpu/tests/gpu_buddy_test.c | 83 ++++++++++++++++++++++++++--
>   2 files changed, 126 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 2f2aaadafe35..5265e1f6a318 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1685,26 +1685,14 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
>   			     blocks, total_allocated_on_err);
>   }
>   
> -static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
> -					u64 unaligned_offset,
> -					u64 size,
> -					u64 min_block_size,
> -					unsigned long flags,
> -					struct list_head *blocks)
> -{
> -	u64 aligned_offset = round_down(unaligned_offset, min_block_size);
> -
> -	return __gpu_buddy_alloc_range(mm, aligned_offset, size, flags,
> -				       NULL, blocks);
> -}
> -
>   static int __alloc_contig_try_harder(struct gpu_buddy *mm,
> +				     u64 range_start, u64 range_end,
>   				     u64 size,
>   				     u64 min_block_size,
>   				     unsigned long flags,
>   				     struct list_head *blocks)
>   {
> -	u64 rhs_offset, lhs_offset, filled;
> +	u64 rhs_offset, lhs_offset, filled, aligned;
>   	struct gpu_buddy_block *block;
>   	struct rb_root *root;
>   	struct rb_node *iter;
> @@ -1734,20 +1722,24 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>   					       flags, &filled, blocks);
>   		if (err && err != -ENOSPC)
>   			return err;
> -		if (!err && IS_ALIGNED(rhs_offset, min_block_size))
> +		if (!err && IS_ALIGNED(rhs_offset, min_block_size) &&
> +		    rhs_offset >= range_start && rhs_offset + size <= range_end)
>   			return 0;
>   		if (!err) {
>   			/* Allocate the unaligned RHS offset using round_down */
>   			gpu_buddy_free_list_internal(mm, blocks);
> -			err = __alloc_contig_aligned_retry(mm, rhs_offset,
> -							   size,
> -							   min_block_size,
> -							   flags, blocks);
> -			if (!err)
> -				return 0;
> -			if (err != -ENOSPC) {
> -				gpu_buddy_free_list_internal(mm, blocks);
> -				return err;
> +
> +			aligned = round_down(rhs_offset, min_block_size);
> +			if (aligned >= range_start &&
> +			    aligned + size <= range_end) {
> +				err = __gpu_buddy_alloc_range(mm, aligned, size,
> +							      flags, NULL, blocks);

Did you consider doing a bias-range for [start, end] using 
min_block_size and using what it returns as the starting point, 
extending left/right? If that fails advance start and try again? Maybe 
what you have here is much better for the case you have in mind?

> +				if (!err)
> +					return 0;
> +				if (err != -ENOSPC) {
> +					gpu_buddy_free_list_internal(mm, blocks);
> +					return err;
> +				}
>   			}
>   			goto next;
>   		}
> @@ -1759,15 +1751,17 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
>   
>   		/* Allocate the unaligned LHS offset using round_down */
>   		gpu_buddy_free_list_internal(mm, blocks);
> -		err = __alloc_contig_aligned_retry(mm, lhs_offset,
> -						   size,
> -						   min_block_size,
> -						   flags, blocks);
> -		if (!err)
> -			return 0;
> -		if (err != -ENOSPC) {
> -			gpu_buddy_free_list_internal(mm, blocks);
> -			return err;
> +
> +		aligned = round_down(lhs_offset, min_block_size);
> +		if (aligned >= range_start && aligned + size <= range_end) {
> +			err = __gpu_buddy_alloc_range(mm, aligned, size,
> +						      flags, NULL, blocks);
> +			if (!err)
> +				return 0;
> +			if (err != -ENOSPC) {
> +				gpu_buddy_free_list_internal(mm, blocks);
> +				return err;
> +			}
>   		}
>   next:
>   		gpu_buddy_free_list_internal(mm, blocks);
> @@ -2021,11 +2015,18 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>   	min_order = ilog2(min_block_size) - ilog2(mm->chunk_size);
>   
>   	if (order > mm->max_order || size > mm->size) {
> -		if ((flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) &&
> -		    !(flags & GPU_BUDDY_RANGE_ALLOCATION))
> -			return __alloc_contig_try_harder(mm, original_size,
> +		if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
> +			u64 range_start, range_end;
> +
> +			range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? start : 0;
> +			range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? end : mm->size;
> +
> +			return __alloc_contig_try_harder(mm, range_start,
> +							 range_end,
> +							 original_size,
>   							 original_min_size,
>   							 flags, blocks);
> +		}
>   
>   		return -EINVAL;
>   	}
> @@ -2058,9 +2059,14 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>   			 * Try contiguous block allocation through
>   			 * try harder method.
>   			 */
> -			if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION &&
> -			    !(flags & GPU_BUDDY_RANGE_ALLOCATION)) {
> -				err = __alloc_contig_try_harder(mm,
> +			if (flags & GPU_BUDDY_CONTIGUOUS_ALLOCATION) {
> +				u64 range_start, range_end;
> +
> +				range_start = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? start : 0;
> +				range_end = (flags & GPU_BUDDY_RANGE_ALLOCATION) ? end : mm->size;
> +
> +				err = __alloc_contig_try_harder(mm, range_start,
> +								range_end,
>   								original_size,
>   								original_min_size,
>   								flags,
> @@ -2068,9 +2074,9 @@ int gpu_buddy_alloc_blocks(struct gpu_buddy *mm,
>   				if (!err)
>   					return 0;
>   				if (err != -ENOSPC)
> -					return err;
> -				goto err_free;
> +					goto err_free;
>   			}
> +
>   			err = -ENOSPC;
>   			goto err_free;
>   		} while (1);
> diff --git a/drivers/gpu/tests/gpu_buddy_test.c b/drivers/gpu/tests/gpu_buddy_test.c
> index b75d32ca6ca0..2c445870b808 100644
> --- a/drivers/gpu/tests/gpu_buddy_test.c
> +++ b/drivers/gpu/tests/gpu_buddy_test.c
> @@ -1251,6 +1251,77 @@ static void gpu_test_buddy_alloc_contiguous(struct kunit *test)
>   	gpu_buddy_fini(&mm);
>   }
>   
> +static void gpu_test_buddy_alloc_range_contiguous(struct kunit *test)
> +{
> +	const unsigned long ps = SZ_4K, mm_size = 16 * ps;
> +	const unsigned long range_end = 8 * ps;
> +	struct gpu_buddy_block *block, *prev;
> +	LIST_HEAD(allocated);
> +	struct gpu_buddy mm;
> +	LIST_HEAD(pin_lo);
> +	LIST_HEAD(pin_hi);
> +	u64 total;
> +
> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, ps),
> +			       "buddy_init failed\n");
> +
> +	/*
> +	 * Idea is to confine the test to the sub-range [0, 32K), which a 12K
> +	 * contiguous request (rounded up to 16K) splits into two naturally
> +	 * aligned 16K slots: [0, 16K) and [16K, 32K). We pin the first 4K page
> +	 * of each slot ([0, 4K) and [16K, 20K)) so that neither aligned slot
> +	 * can satisfy the rounded-up 16K allocation, yet the freed remainder
> +	 * still leaves a contiguous 12K hole at offset 4K, which is page-aligned
> +	 * but not 16K-aligned. A 12K contiguous+range allocation must therefore
> +	 * fall back to stitching that span instead of returning -ENOSPC.
> +	 */
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 0, ps, ps, ps,
> +						      &pin_lo, 0),
> +			       "failed to pin low page\n");
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 4 * ps, 5 * ps, ps,
> +						      ps, &pin_hi, 0),
> +			       "failed to pin high page\n");
> +
> +	/* No aligned 16K block is free; the range-aware fallback must stitch
> +	 * the unaligned [ps, 4*ps) hole instead of returning -ENOSPC.
> +	 */
> +	KUNIT_ASSERT_FALSE_MSG(test,
> +			       gpu_buddy_alloc_blocks(&mm, 0, range_end, 3 * ps,
> +						      ps, &allocated,
> +						      GPU_BUDDY_CONTIGUOUS_ALLOCATION |
> +						      GPU_BUDDY_RANGE_ALLOCATION),
> +			       "range-restricted contiguous alloc failed\n");
> +
> +	/* The result must be exactly 3*ps, contiguous, and inside the range. */
> +	total = 0;
> +	prev = NULL;
> +	list_for_each_entry(block, &allocated, link) {
> +		u64 offset = gpu_buddy_block_offset(block);
> +		u64 bsize = gpu_buddy_block_size(&mm, block);
> +
> +		KUNIT_EXPECT_TRUE_MSG(test, offset + bsize <= range_end,
> +				      "block [%llx, %llx) outside range\n",
> +				      offset, offset + bsize);
> +		if (prev)
> +			KUNIT_EXPECT_EQ_MSG(test,
> +					    gpu_buddy_block_offset(prev) +
> +					    gpu_buddy_block_size(&mm, prev),
> +					    offset,
> +					    "block at %llx not contiguous\n",
> +					    offset);
> +		prev = block;
> +		total += bsize;
> +	}
> +	KUNIT_EXPECT_EQ(test, total, 3 * ps);
> +
> +	gpu_buddy_free_list(&mm, &allocated, 0);
> +	gpu_buddy_free_list(&mm, &pin_lo, 0);
> +	gpu_buddy_free_list(&mm, &pin_hi, 0);
> +	gpu_buddy_fini(&mm);
> +}
> +
>   static void gpu_test_buddy_alloc_pathological(struct kunit *test)
>   {
>   	u64 mm_size, size, start = 0;
> @@ -1534,10 +1605,13 @@ static void gpu_test_buddy_alloc_exceeds_max_order(struct kunit *test)
>   				     GPU_BUDDY_RANGE_ALLOCATION);
>   	KUNIT_EXPECT_EQ(test, err, -EINVAL);
>   
> -	/* CONTIGUOUS + RANGE should return -EINVAL (no try_harder for RANGE) */
> -	err = gpu_buddy_alloc_blocks(&mm, 0, mm_size, size, SZ_4K, &blocks,
> -				     GPU_BUDDY_CONTIGUOUS_ALLOCATION | GPU_BUDDY_RANGE_ALLOCATION);
> -	KUNIT_EXPECT_EQ(test, err, -EINVAL);
> +	/* CONTIGUOUS + RANGE should succeed via the range-aware try_harder */
> +	KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_alloc_blocks(&mm, 0, mm_size, size,
> +							    SZ_4K, &blocks,
> +							    GPU_BUDDY_CONTIGUOUS_ALLOCATION |
> +							    GPU_BUDDY_RANGE_ALLOCATION),
> +			       "range contiguous alloc hit an error size=%llu\n", size);
> +	gpu_buddy_free_list(&mm, &blocks, 0);
>   
>   	gpu_buddy_fini(&mm);
>   }
> @@ -1603,6 +1677,7 @@ static struct kunit_case gpu_buddy_tests[] = {
>   	KUNIT_CASE(gpu_test_buddy_alloc_pessimistic),
>   	KUNIT_CASE(gpu_test_buddy_alloc_pathological),
>   	KUNIT_CASE(gpu_test_buddy_alloc_contiguous),
> +	KUNIT_CASE(gpu_test_buddy_alloc_range_contiguous),
>   	KUNIT_CASE(gpu_test_buddy_alloc_clear),
>   	KUNIT_CASE(gpu_test_buddy_alloc_range),
>   	KUNIT_CASE(gpu_test_buddy_alloc_range_bias),
> 
> base-commit: 744f262401cc2e1f3827496c72a47e072d31a852

