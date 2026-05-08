Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E37CD37A7
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 14:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C9210F4E1;
	Fri,  8 May 2026 14:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RzOc/Z9V";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9331210F4E1;
 Fri,  8 May 2026 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778249588; x=1809785588;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SshePRMj+u4JSmcX/YmvIJCJ9oDV6a3JF98FOph8D7s=;
 b=RzOc/Z9VpJKvx7TpvDcJUDyy9YwO85jzE2ha96IXq9I4jAvlT6gy4uFt
 nbNmDiNR9W1LqWx8fMk4pNgN1b5GRDyf5OK3DfSc8UrsZleFEcRZdz3di
 ZSrbmyXIm6vyMPgkOQ+KT42l76TpCI+gk4d8xi8/5Zlp2w+rQQ2vsWMRp
 4N2waetvRJwp9qTDNAfiqs/mpmtHmgD5RvtrEMatBxoozKbe6DoeYTYLN
 XY5jMxZ/vuEc7n8d7NCalhWNKJSps64vKnZ5onJgloYYp5E3iaLV1YJfu
 w3AVKL1HW+Owa3Pv0xjN/DX9rt7+e7EzK5BVFKOfU6yrKXAdTcyeC1Nlk A==;
X-CSE-ConnectionGUID: /3PuJh/qQcyz+kePx9T/wQ==
X-CSE-MsgGUID: Lzs95d24QaOZRCNQz6m1hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11780"; a="82838838"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="82838838"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 07:13:08 -0700
X-CSE-ConnectionGUID: PR4+6gT3QhKLmNsCJzkAYg==
X-CSE-MsgGUID: KnAZZFdUT46MxA/4HjDQvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; d="scan'208";a="241773500"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO [10.245.244.63])
 ([10.245.244.63])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2026 07:13:07 -0700
Message-ID: <fe332774-5678-4b9e-8453-49355de1f773@intel.com>
Date: Fri, 8 May 2026 15:13:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] gpu/buddy: Track per-order used blocks with a
 scoreboard
To: Francois Dugast <francois.dugast@intel.com>,
 dri-devel@lists.freedesktop.org,
 "Paneer Selvam, Arunpravin" <Arunpravin.PaneerSelvam@amd.com>
Cc: intel-xe@lists.freedesktop.org
References: <20260504135343.1797869-1-francois.dugast@intel.com>
 <20260504135343.1797869-3-francois.dugast@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260504135343.1797869-3-francois.dugast@intel.com>
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

On 04/05/2026 14:52, Francois Dugast wrote:
> Extend the scoreboard approach from the previous commit to used blocks,
> so drm_buddy_print() can report per-order allocation pressure in O(1).
> 
> Unlike free blocks, an allocated block can leave the allocated state
> through mark_free() (normal free and gpu_buddy_block_trim()) or be
> consumed directly by gpu_block_free() during coalescing. Both sites are
> guarded by gpu_buddy_block_is_allocated() and paired with the increment
> in mark_allocated().
> 
> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> Assisted-by: GitHub Copilot:claude-sonnet-4.6

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

Note that Sashiko found an existing issue here: 
https://sashiko.dev/#/patchset/20260504135343.1797869-1-francois.dugast%40intel.com

I guess would be good to fix that first, in this series?

> ---
>   drivers/gpu/buddy.c         | 29 +++++++++++++++++++++++------
>   drivers/gpu/drm/drm_buddy.c |  8 +++++---
>   include/linux/gpu_buddy.h   |  8 ++++++++
>   3 files changed, 36 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index d831165e87ea..ebef03613b3f 100644
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
> @@ -398,6 +405,12 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
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
> @@ -462,6 +475,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>   		kfree(mm->free_trees[i]);
>   	kfree(mm->free_trees);
>   out_free_scoreboard:
> +	kfree(mm->used_scoreboard);
> +out_free_free_scoreboard:
>   	kfree(mm->free_scoreboard);
>   	return -ENOMEM;
>   }
> @@ -502,6 +517,7 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
>   	kfree(mm->free_trees);
>   	kfree(mm->roots);
>   	kfree(mm->free_scoreboard);
> +	kfree(mm->used_scoreboard);
>   }
>   EXPORT_SYMBOL(gpu_buddy_fini);
>   
> @@ -1496,15 +1512,16 @@ void gpu_buddy_print(struct gpu_buddy *mm)
>   		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
>   
>   	for (order = mm->max_order; order >= 0; order--) {
> -		u64 count = mm->free_scoreboard[order];
> -		u64 free = count * (mm->chunk_size << order);
> +		u64 free_count = mm->free_scoreboard[order];
> +		u64 used_count = mm->used_scoreboard[order];
> +		u64 free = free_count * (mm->chunk_size << order);
>   
>   		if (free < SZ_1M)
> -			pr_info("order-%2d free: %8llu KiB, blocks: %llu\n",
> -				order, free >> 10, count);
> +			pr_info("order-%2d free: %8llu KiB, free_blocks: %llu, used_blocks: %llu\n",
> +				order, free >> 10, free_count, used_count);
>   		else
> -			pr_info("order-%2d free: %8llu MiB, blocks: %llu\n",
> -				order, free >> 20, count);
> +			pr_info("order-%2d free: %8llu MiB, free_blocks: %llu, used_blocks: %llu\n",
> +				order, free >> 20, free_count, used_count);
>   	}
>   }
>   EXPORT_SYMBOL(gpu_buddy_print);
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index 7839b54d3da7..3a1cb06923c6 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -46,8 +46,9 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
>   		   mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
>   
>   	for (order = mm->max_order; order >= 0; order--) {
> -		u64 count = mm->free_scoreboard[order];
> -		u64 free = count * (mm->chunk_size << order);
> +		u64 free_count = mm->free_scoreboard[order];
> +		u64 used_count = mm->used_scoreboard[order];
> +		u64 free = free_count * (mm->chunk_size << order);
>   
>   		drm_printf(p, "order-%2d ", order);
>   
> @@ -56,7 +57,8 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
>   		else
>   			drm_printf(p, "free: %8llu MiB", free >> 20);
>   
> -		drm_printf(p, ", blocks: %llu\n", count);
> +		drm_printf(p, ", free_blocks: %llu, used_blocks: %llu\n",
> +			   free_count, used_count);
>   	}
>   }
>   EXPORT_SYMBOL(drm_buddy_print);
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index 250841ca4bcf..b1cad7833dc1 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -179,6 +179,14 @@ struct gpu_buddy {
>   	 * mark_split() when a block leaves the free state.
>   	 */
>   	u64 *free_scoreboard;
> +	/*
> +	 * Per-order used block scoreboard: used_scoreboard[order] holds the
> +	 * number of blocks of that order currently in the allocated state.
> +	 * Incremented in mark_allocated(), decremented in
> +	 * gpu_buddy_free_block() which is the sole entry point for freeing
> +	 * allocated blocks.
> +	 */
> +	u64 *used_scoreboard;
>   /* public: */
>   	unsigned int n_roots;
>   	unsigned int max_order;

