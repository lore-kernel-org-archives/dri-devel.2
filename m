Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC9FCD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 16:02:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55F5889838;
	Mon, 18 May 2026 16:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aY8wyLYU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BCF489838;
 Mon, 18 May 2026 16:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779120155; x=1810656155;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6cPDmcGk+1pt3EXewfHdBeIlTjwB+R4e+VMTw6N8b2Q=;
 b=aY8wyLYUDDBJodsr2Jplbwc0kKrCQRgDSFHctPr32mNEk13awy00M+PK
 uhC75kNY/8CYgM5oxIE2MSy4njYo8tT2e6HEgXo8GYFRxoL0MgLaRdFAy
 CPN35QBChr3iC64+uqKBY7ajPCHq9QGWQ7MT12//aSR5BgJgCubUiU0oC
 37UC4eDIc9ZzA9t/sZCELTsCHG1ikDaOZ4vawPZipygt8AhbjPiYZCDko
 4+aO44JBMXWX4Y51z2q4n6b2Htu3qvqDcXJfE9IzXv2r+Lpoc5Zs7uRHG
 uRUBrQAc+V0oR3qJI2He40gEo6eKBaZoW7fFpc+6nw24V1njjup3VHedF w==;
X-CSE-ConnectionGUID: jIS3DTstRIeWq466yMd0mw==
X-CSE-MsgGUID: qiioOc7IQJikYZx2fia0ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="91368921"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="91368921"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 09:02:35 -0700
X-CSE-ConnectionGUID: cFIhrLI3RIOjmqlMsb2swg==
X-CSE-MsgGUID: +rsurwKaSLGgRMw5t9owGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="235215638"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.57])
 ([10.245.244.57])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 09:02:34 -0700
Message-ID: <ddfb5ef7-e01a-4a9d-aa16-bcd475338135@intel.com>
Date: Mon, 18 May 2026 17:02:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] gpu/buddy: Track per-order used blocks with a
 scoreboard
To: Francois Dugast <francois.dugast@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260518141446.124508-1-francois.dugast@intel.com>
 <20260518141446.124508-6-francois.dugast@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260518141446.124508-6-francois.dugast@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 18/05/2026 15:14, Francois Dugast wrote:
> Extend the scoreboard approach from the previous commit to used blocks,
> so drm_buddy_print() can report per-order allocation pressure in O(1).
> 
> Unlike free blocks, an allocated block can leave the allocated state
> through mark_free() (normal free and gpu_buddy_block_trim()) or be
> consumed directly by gpu_block_free() during coalescing. Both sites are
> guarded by gpu_buddy_block_is_allocated() and paired with the increment
> in mark_allocated().
> 
> v2:
> - Update after fix for use-after-free in split_block() call sites
> - Change goto label to out_free_used_scoreboard for clarity
> - Make drm_buddy_print() and gpu_buddy_print() symmetric for used and
>    free
> 
> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> Assisted-by: GitHub Copilot:claude-sonnet-4.6

Could potentially also assert that used_scoreboard is empty at fini(), 
as a quick sanity check that nothing got leaked/missed with the 
accounting. Would also then be checked across the selftests.

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/buddy.c         | 39 +++++++++++++++++++++++++++----------
>   drivers/gpu/drm/drm_buddy.c | 18 +++++++++++------
>   include/linux/gpu_buddy.h   |  8 ++++++++
>   3 files changed, 49 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index de18b63fef0a..f81d0d8fde15 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -194,6 +194,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>   	block->header |= GPU_BUDDY_ALLOCATED;
>   
>   	mm->free_scoreboard[gpu_buddy_block_order(block)]--;
> +	mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>   
>   	rbtree_remove(mm, block);
>   }
> @@ -203,6 +204,9 @@ static void mark_free(struct gpu_buddy *mm,
>   {
>   	enum gpu_buddy_free_tree tree;
>   
> +	if (gpu_buddy_block_is_allocated(block))
> +		mm->used_scoreboard[gpu_buddy_block_order(block)]--;
> +
>   	block->header &= ~GPU_BUDDY_HEADER_STATE;
>   	block->header |= GPU_BUDDY_FREE;
>   
> @@ -281,6 +285,9 @@ static unsigned int __gpu_buddy_free(struct gpu_buddy *mm,
>   		if (force_merge && gpu_buddy_block_is_clear(buddy))
>   			mm->clear_avail -= gpu_buddy_block_size(mm, buddy);
>   
> +		if (gpu_buddy_block_is_allocated(block))
> +			mm->used_scoreboard[gpu_buddy_block_order(block)]--;
> +
>   		gpu_block_free(mm, block);
>   		gpu_block_free(mm, buddy);
>   
> @@ -398,11 +405,17 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>   	if (!mm->free_scoreboard)
>   		return -ENOMEM;
>   
> +	mm->used_scoreboard = kcalloc(mm->max_order + 1,
> +				      sizeof(*mm->used_scoreboard),
> +				      GFP_KERNEL);
> +	if (!mm->used_scoreboard)
> +		goto out_free_free_scoreboard;
> +
>   	mm->free_trees = kmalloc_array(GPU_BUDDY_MAX_FREE_TREES,
>   				       sizeof(*mm->free_trees),
>   				       GFP_KERNEL);
>   	if (!mm->free_trees)
> -		goto out_free_scoreboard;
> +		goto out_free_used_scoreboard;
>   
>   	for_each_free_tree(i) {
>   		mm->free_trees[i] = kmalloc_array(mm->max_order + 1,
> @@ -464,7 +477,9 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>   	while (i--)
>   		kfree(mm->free_trees[i]);
>   	kfree(mm->free_trees);
> -out_free_scoreboard:
> +out_free_used_scoreboard:
> +	kfree(mm->used_scoreboard);
> +out_free_free_scoreboard:
>   	kfree(mm->free_scoreboard);
>   	return -ENOMEM;
>   }
> @@ -505,6 +520,7 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
>   	kfree(mm->free_trees);
>   	kfree(mm->roots);
>   	kfree(mm->free_scoreboard);
> +	kfree(mm->used_scoreboard);
>   }
>   EXPORT_SYMBOL(gpu_buddy_fini);
>   
> @@ -1505,15 +1521,18 @@ void gpu_buddy_print(struct gpu_buddy *mm)
>   		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
>   
>   	for (order = mm->max_order; order >= 0; order--) {
> -		u64 count = mm->free_scoreboard[order];
> -		u64 free = count * (mm->chunk_size << order);
> -
> -		if (free < SZ_1M)
> -			pr_info("order-%2d free: %8llu KiB, blocks: %llu\n",
> -				order, free >> 10, count);
> +		u64 free_count = mm->free_scoreboard[order];
> +		u64 used_count = mm->used_scoreboard[order];
> +		u64 block_size = mm->chunk_size << order;
> +		u64 free = free_count * block_size;
> +		u64 used = used_count * block_size;
> +
> +		if (block_size < SZ_1M)
> +			pr_info("order-%2d free: %8llu KiB, used: %8llu KiB, free_blocks: %llu, used_blocks: %llu\n",
> +				order, free >> 10, used >> 10, free_count, used_count);
>   		else
> -			pr_info("order-%2d free: %8llu MiB, blocks: %llu\n",
> -				order, free >> 20, count);
> +			pr_info("order-%2d free: %8llu MiB, used: %8llu MiB, free_blocks: %llu, used_blocks: %llu\n",
> +				order, free >> 20, used >> 20, free_count, used_count);
>   	}
>   }
>   EXPORT_SYMBOL(gpu_buddy_print);
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index eef995e08a37..1536e59c6fe7 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -47,17 +47,23 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
>   		   mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
>   
>   	for (order = mm->max_order; order >= 0; order--) {
> -		u64 count = mm->free_scoreboard[order];
> -		u64 free = count * (mm->chunk_size << order);
> +		u64 free_count = mm->free_scoreboard[order];
> +		u64 used_count = mm->used_scoreboard[order];
> +		u64 block_size = mm->chunk_size << order;
> +		u64 free = free_count * block_size;
> +		u64 used = used_count * block_size;
>   
>   		drm_printf(p, "order-%2d ", order);
>   
> -		if (free < SZ_1M)
> -			drm_printf(p, "free: %8llu KiB", free >> 10);
> +		if (block_size < SZ_1M)
> +			drm_printf(p, "free: %8llu KiB, used: %8llu KiB",
> +				   free >> 10, used >> 10);
>   		else
> -			drm_printf(p, "free: %8llu MiB", free >> 20);
> +			drm_printf(p, "free: %8llu MiB, used: %8llu MiB",
> +				   free >> 20, used >> 20);
>   
> -		drm_printf(p, ", blocks: %llu\n", count);
> +		drm_printf(p, ", free_blocks: %llu, used_blocks: %llu\n",
> +			   free_count, used_count);
>   	}
>   }
>   EXPORT_SYMBOL(drm_buddy_print);
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index a28f7d7637ca..e037714563d8 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -180,6 +180,14 @@ struct gpu_buddy {
>   	 * called on a free block.
>   	 */
>   	u64 *free_scoreboard;
> +	/*
> +	 * Per-order used block scoreboard: used_scoreboard[order] holds the
> +	 * number of blocks of that order currently in the allocated state.
> +	 * Incremented in mark_allocated(), decremented in mark_free() (guarded
> +	 * by gpu_buddy_block_is_allocated()) and in __gpu_buddy_free() when an
> +	 * allocated block is consumed directly during buddy coalescing.
> +	 */
> +	u64 *used_scoreboard;
>   /* public: */
>   	unsigned int n_roots;
>   	unsigned int max_order;

