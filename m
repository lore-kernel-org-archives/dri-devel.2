Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0649ACD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:58:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6659610E8EB;
	Mon, 18 May 2026 15:58:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UWaLcniO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2B510E8EB;
 Mon, 18 May 2026 15:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779119890; x=1810655890;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Tgf/ATTtiWXRL+hNl7LjoiT5hgyoYKhkTvfeGulCYCM=;
 b=UWaLcniO2TLeADgLw5wF29uGLDeNQXCajrbzldFd8zPpnNeQegpzm/k7
 XDwUP/69VjidjLVRwORL1i6nBnb80yVaovRTo1ULcMsYeq525TMhgcxDU
 ap0+t1XmG2BYOz36DzWxwD+TMhXUhylZ95mvVlJXFE69VgkfDtvMuO6KF
 3A2/9MP6Z+l1JyNgAyUFaQsN8vbmSyNPm8NaebjUH8MvoDcVJDXkccHY6
 e+ufZ6y4RTKSbgbeonHX4X0S7pN2uE83qR0caMw9FqMEBVMyzwH9d+8CG
 saxRrUbG3Dt7qWq6uamMo0xsPfs5M56ESfchYqC5hEae8o4Rzp71+N9a0 Q==;
X-CSE-ConnectionGUID: nz9fuldtQoO3zLNeEMSyEQ==
X-CSE-MsgGUID: GcxGA9aRTeKf0LdWpiQ/sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="97546215"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="97546215"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 08:58:09 -0700
X-CSE-ConnectionGUID: EA4oxBCJSyuWbu+tQI/hXg==
X-CSE-MsgGUID: Dm9j6miQSHy75ythNMfluQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="262981743"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.57])
 ([10.245.244.57])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 08:58:08 -0700
Message-ID: <6e126bb7-4bfb-46e4-9f3d-b900145f1ac5@intel.com>
Date: Mon, 18 May 2026 16:58:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] gpu/buddy: Track per-order free blocks with a
 scoreboard
To: Francois Dugast <francois.dugast@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
References: <20260518141446.124508-1-francois.dugast@intel.com>
 <20260518141446.124508-5-francois.dugast@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260518141446.124508-5-francois.dugast@intel.com>
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
> Reporting per-order free block counts in drm_buddy_print() currently
> requires walking all rbtrees, which is O(n) over the total number of
> free blocks and holds the allocator lock for the duration. This becomes
> expensive on large VRAM heaps with many small free fragments.
> 
> Maintain a free_scoreboard[] array indexed by order instead, so that
> the count for any order is always available in O(1). The scoreboard is
> kept accurate by hooking into the four places where a block's free state
> changes: mark_free(), mark_allocated(), mark_split(), and the sites in
> __gpu_buddy_free(), __force_merge(), and the four err_undo paths that
> call rbtree_remove() directly on free blocks without going through
> mark_*().
> 
> The print functions are simplified as a result: the rbtree traversal
> is replaced by a direct array lookup.
> 
> v3: Update after introducing __gpu_buddy_undo_splits() helper
> 
> v2: Update after fix for use-after-free in split_block() call sites
> 
> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> Assisted-by: GitHub Copilot:claude-sonnet-4.6

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

> ---
>   drivers/gpu/buddy.c         | 36 +++++++++++++++++++++---------------
>   drivers/gpu/drm/drm_buddy.c | 16 ++--------------
>   include/linux/gpu_buddy.h   |  7 +++++++
>   3 files changed, 30 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 8654604b87a4..de18b63fef0a 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -193,6 +193,8 @@ static void mark_allocated(struct gpu_buddy *mm,
>   	block->header &= ~GPU_BUDDY_HEADER_STATE;
>   	block->header |= GPU_BUDDY_ALLOCATED;
>   
> +	mm->free_scoreboard[gpu_buddy_block_order(block)]--;
> +
>   	rbtree_remove(mm, block);
>   }
>   
> @@ -204,6 +206,8 @@ static void mark_free(struct gpu_buddy *mm,
>   	block->header &= ~GPU_BUDDY_HEADER_STATE;
>   	block->header |= GPU_BUDDY_FREE;
>   
> +	mm->free_scoreboard[gpu_buddy_block_order(block)]++;
> +
>   	tree = get_block_tree(block);
>   	rbtree_insert(mm, block, tree);
>   }
> @@ -214,6 +218,8 @@ static void mark_split(struct gpu_buddy *mm,
>   	block->header &= ~GPU_BUDDY_HEADER_STATE;
>   	block->header |= GPU_BUDDY_SPLIT;
>   
> +	mm->free_scoreboard[gpu_buddy_block_order(block)]--;
> +
>   	rbtree_remove(mm, block);
>   }
>   
> @@ -271,6 +277,7 @@ static unsigned int __gpu_buddy_free(struct gpu_buddy *mm,
>   		}
>   
>   		rbtree_remove(mm, buddy);
> +		mm->free_scoreboard[gpu_buddy_block_order(buddy)]--;
>   		if (force_merge && gpu_buddy_block_is_clear(buddy))
>   			mm->clear_avail -= gpu_buddy_block_size(mm, buddy);
>   
> @@ -335,6 +342,7 @@ static int __force_merge(struct gpu_buddy *mm,
>   					iter = rb_prev(iter);
>   
>   				rbtree_remove(mm, block);
> +				mm->free_scoreboard[gpu_buddy_block_order(block)]--;
>   				if (gpu_buddy_block_is_clear(block))
>   					mm->clear_avail -= gpu_buddy_block_size(mm, block);
>   
> @@ -384,11 +392,17 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>   
>   	BUG_ON(mm->max_order > GPU_BUDDY_MAX_ORDER);
>   
> +	mm->free_scoreboard = kcalloc(mm->max_order + 1,
> +				      sizeof(*mm->free_scoreboard),
> +				      GFP_KERNEL);
> +	if (!mm->free_scoreboard)
> +		return -ENOMEM;
> +
>   	mm->free_trees = kmalloc_array(GPU_BUDDY_MAX_FREE_TREES,
>   				       sizeof(*mm->free_trees),
>   				       GFP_KERNEL);
>   	if (!mm->free_trees)
> -		return -ENOMEM;
> +		goto out_free_scoreboard;
>   
>   	for_each_free_tree(i) {
>   		mm->free_trees[i] = kmalloc_array(mm->max_order + 1,
> @@ -450,6 +464,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>   	while (i--)
>   		kfree(mm->free_trees[i]);
>   	kfree(mm->free_trees);
> +out_free_scoreboard:
> +	kfree(mm->free_scoreboard);
>   	return -ENOMEM;
>   }
>   EXPORT_SYMBOL(gpu_buddy_init);
> @@ -488,6 +504,7 @@ void gpu_buddy_fini(struct gpu_buddy *mm)
>   		kfree(mm->free_trees[i]);
>   	kfree(mm->free_trees);
>   	kfree(mm->roots);
> +	kfree(mm->free_scoreboard);
>   }
>   EXPORT_SYMBOL(gpu_buddy_fini);
>   
> @@ -659,6 +676,7 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
>   	    (gpu_buddy_block_is_free(block) &&
>   	     gpu_buddy_block_is_free(buddy))) {
>   		rbtree_remove(mm, block);
> +		mm->free_scoreboard[gpu_buddy_block_order(block)]--;
>   		__gpu_buddy_free(mm, block, false);
>   	}
>   }
> @@ -1487,21 +1505,9 @@ void gpu_buddy_print(struct gpu_buddy *mm)
>   		mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
>   
>   	for (order = mm->max_order; order >= 0; order--) {
> -		struct gpu_buddy_block *block, *tmp;
> -		struct rb_root *root;
> -		u64 count = 0, free;
> -		unsigned int tree;
> -
> -		for_each_free_tree(tree) {
> -			root = &mm->free_trees[tree][order];
> -
> -			rbtree_postorder_for_each_entry_safe(block, tmp, root, rb) {
> -				BUG_ON(!gpu_buddy_block_is_free(block));
> -				count++;
> -			}
> -		}
> +		u64 count = mm->free_scoreboard[order];
> +		u64 free = count * (mm->chunk_size << order);
>   
> -		free = count * (mm->chunk_size << order);
>   		if (free < SZ_1M)
>   			pr_info("order-%2d free: %8llu KiB, blocks: %llu\n",
>   				order, free >> 10, count);
> diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
> index faa025498de4..eef995e08a37 100644
> --- a/drivers/gpu/drm/drm_buddy.c
> +++ b/drivers/gpu/drm/drm_buddy.c
> @@ -47,23 +47,11 @@ void drm_buddy_print(struct gpu_buddy *mm, struct drm_printer *p)
>   		   mm->chunk_size >> 10, mm->size >> 20, mm->avail >> 20, mm->clear_avail >> 20);
>   
>   	for (order = mm->max_order; order >= 0; order--) {
> -		struct gpu_buddy_block *block, *tmp;
> -		struct rb_root *root;
> -		u64 count = 0, free;
> -		unsigned int tree;
> -
> -		for_each_free_tree(tree) {
> -			root = &mm->free_trees[tree][order];
> -
> -			rbtree_postorder_for_each_entry_safe(block, tmp, root, rb) {
> -				BUG_ON(!gpu_buddy_block_is_free(block));
> -				count++;
> -			}
> -		}
> +		u64 count = mm->free_scoreboard[order];
> +		u64 free = count * (mm->chunk_size << order);
>   
>   		drm_printf(p, "order-%2d ", order);
>   
> -		free = count * (mm->chunk_size << order);
>   		if (free < SZ_1M)
>   			drm_printf(p, "free: %8llu KiB", free >> 10);
>   		else
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index 71941a039648..a28f7d7637ca 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -173,6 +173,13 @@ struct gpu_buddy {
>   	 * that fits in the remaining space.
>   	 */
>   	struct gpu_buddy_block **roots;
> +	/*
> +	 * Per-order free block scoreboard: free_scoreboard[order] holds the
> +	 * number of blocks of that order currently in the free state.
> +	 * Incremented in mark_free(), decremented wherever rbtree_remove() is
> +	 * called on a free block.
> +	 */
> +	u64 *free_scoreboard;
>   /* public: */
>   	unsigned int n_roots;
>   	unsigned int max_order;

