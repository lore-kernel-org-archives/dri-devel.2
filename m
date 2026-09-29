Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF36CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:51:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED4510EDEF;
	Tue, 29 Sep 2026 09:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Z3BLJSDD";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ED8D10EDE8;
 Tue, 29 Sep 2026 09:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790675464; x=1822211464;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=5IMzqzg26e1ZOe5msduUKZOodQmOMG4X1RMTOWhDaqs=;
 b=Z3BLJSDDXe1NPE/XWi+DGK/wtoMlLL09bGjwb8+GZna+M5FokzkaXwN7
 TKYxBI4ckAxnZDGrLPZrID53KJK10cQT8AXr33+V5q0eHLCi3niqKryZu
 dqcfTqV4s3RW+c0oNxLjlaEosXMgPeocX/ATQ8M9PYecuLATlCov3MoDH
 uer43WLfv1XXbpB53+oA/oUH5Hc1e08iyA5WhouquN6g1ZOGTllGnQ7ig
 2Vgu4X+twNUBCgCjM2r+4f8PoIKe6IM/n+eoWkD7mEPUXm+TtfwJI3xai
 gc+vc/RyME6WHTLprvlETNz9uK9VaZ/dBVDsk1zkKAosD1tHmoY0k40zc Q==;
X-CSE-ConnectionGUID: LhtZTUVJR8mOLXwJIu7kqg==
X-CSE-MsgGUID: V1FE0yn9Tw+5cEKuUE8Znw==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="100720951"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="100720951"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 02:51:04 -0700
X-CSE-ConnectionGUID: SbTQ6ONTRamNR6hrvV/fiA==
X-CSE-MsgGUID: MvMNXFwcQBmEfevu2ItB2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="274856017"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.8])
 ([10.245.245.8])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 02:51:02 -0700
Message-ID: <74e8255e-acde-4270-a0c4-10e14e3d7ba4@intel.com>
Date: Tue, 29 Sep 2026 10:50:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] gpu/buddy: fix missing split-undo on
 allocation-search exhaustion
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20260928175128.257266-1-arunpravin.paneerselvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260928175128.257266-1-arunpravin.paneerselvam@amd.com>
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

On 28/09/2026 18:51, Arunpravin Paneer Selvam wrote:
> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> 
> __alloc_range_bias() and __alloc_range() only undid splits made during
> their search when split_block() itself failed. Their DFS-exhaustion
> failure paths (-ENOSPC, when no suitable block is found) skipped the
> undo, leaving the buddy tree needlessly fragmented over repeated
> failed allocation attempts.
> 
> Fix by recording every successful split_block() call in a list and
> unconditionally undoing those splits on every failure exit, via a
> new single-level gpu_buddy_merge_one_level() helper (the original
> __gpu_buddy_undo_splits() cascaded merges upward, which is unsafe
> when called per split-list entry).

At least for __alloc_range(), I thought if we do a split it should be 
always guaranteed that some eventual side (left or right at some depth) 
will be marked as allocated, unless the split itself fails, in which 
case you might need the special undo path.  So I don't think you can 
ever have two free buddies on the -ENOSPC path, in which case you don't 
need any "undo splits", you can just trigger the normal 
gpu_buddy_free_list_internal() path, which is what the code currently 
does? What am I missing?

> 
> Resolves the igt@kms_plane@plane-panning-bottom-right@pipe-a/pipe-b
> regression.
> 
> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
> Assisted-by: Claude:claude-opus-4-8
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/buddy.c | 64 ++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 58 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 2f2aaadafe35..b741160d3d16 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -1240,6 +1240,52 @@ static void __gpu_buddy_undo_splits(struct gpu_buddy *mm,
>   	}
>   }
>   
> +static void gpu_buddy_merge_one_level(struct gpu_buddy *mm,
> +				      struct gpu_buddy_block *block)
> +{
> +	struct gpu_buddy_block *buddy = __get_buddy(block);
> +	struct gpu_buddy_block *parent = block->parent;
> +	enum gpu_block_state block_state;
> +
> +	if (!buddy || !gpu_buddy_block_is_free(block) ||
> +	    !gpu_buddy_block_is_free(buddy))
> +		return;
> +
> +	block_state = gpu_block_cached_state(block);
> +	if (gpu_block_cached_state(buddy) != block_state)
> +		block_state = GPU_BLOCK_MIXED;
> +
> +	rbtree_remove(mm, block);
> +	rbtree_remove(mm, buddy);
> +	mm->free_scoreboard[gpu_buddy_block_order(block)] -= 2;
> +
> +	gpu_block_free(mm, block);
> +	gpu_block_free(mm, buddy);
> +
> +	__mark_free(mm, parent, block_state);
> +}
> +
> +static void gpu_buddy_undo_splits(struct gpu_buddy *mm,
> +				  struct gpu_buddy_block *block,
> +				  struct list_head *splits)
> +{
> +	if (block)
> +		gpu_buddy_merge_one_level(mm, block);
> +
> +	while (!list_empty(splits)) {
> +		struct gpu_buddy_block *parent =
> +			list_first_entry(splits, struct gpu_buddy_block,
> +					 tmp_link);
> +
> +		list_del(&parent->tmp_link);
> +
> +		if (!gpu_buddy_block_is_split(parent))
> +			continue;
> +
> +		gpu_buddy_merge_one_level(mm, parent->left);
> +	}
> +}
> +
>   static struct gpu_buddy_block *
>   __alloc_range_bias(struct gpu_buddy *mm,
>   		   u64 start, u64 end,
> @@ -1249,6 +1295,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   	u64 req_size = mm->chunk_size << order;
>   	struct gpu_buddy_block *block;
>   	LIST_HEAD(dfs);
> +	LIST_HEAD(splits);
>   	int err;
>   	int i;
>   
> @@ -1313,6 +1360,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   			err = split_block(mm, block);
>   			if (unlikely(err))
>   				goto err_undo;
> +
> +			list_add(&block->tmp_link, &splits);
>   		}
>   
>   		/*
> @@ -1349,7 +1398,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   		}
>   	} while (1);
>   
> -	return ERR_PTR(-ENOSPC);
> +	err = -ENOSPC;
>   
>   err_undo:
>   	/*
> @@ -1357,7 +1406,8 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   	 * bigger is better, so make sure we merge everything back before we
>   	 * free the allocated blocks.
>   	 */
> -	__gpu_buddy_undo_splits(mm, block);
> +	gpu_buddy_undo_splits(mm, block, &splits);
> +
>   	return ERR_PTR(err);
>   }
>   
> @@ -1580,6 +1630,7 @@ static int __alloc_range(struct gpu_buddy *mm,
>   	struct gpu_buddy_block *block;
>   	u64 total_allocated = 0;
>   	LIST_HEAD(allocated);
> +	LIST_HEAD(splits);
>   	u64 end;
>   	int err;
>   
> @@ -1605,7 +1656,7 @@ static int __alloc_range(struct gpu_buddy *mm,
>   
>   		if (gpu_buddy_block_is_allocated(block)) {
>   			err = -ENOSPC;
> -			goto err_free;
> +			goto err_undo;
>   		}
>   
>   		if (contains(start, end, block_start, block_end)) {
> @@ -1634,6 +1685,8 @@ static int __alloc_range(struct gpu_buddy *mm,
>   			err = split_block(mm, block);
>   			if (unlikely(err))
>   				goto err_undo;
> +
> +			list_add(&block->tmp_link, &splits);
>   		}
>   
>   		list_add(&block->right->tmp_link, dfs);
> @@ -1642,7 +1695,7 @@ static int __alloc_range(struct gpu_buddy *mm,
>   
>   	if (total_allocated < size) {
>   		err = -ENOSPC;
> -		goto err_free;
> +		goto err_undo;
>   	}
>   
>   	list_splice_tail(&allocated, blocks);
> @@ -1655,9 +1708,8 @@ static int __alloc_range(struct gpu_buddy *mm,
>   	 * bigger is better, so make sure we merge everything back before we
>   	 * free the allocated blocks.
>   	 */
> -	__gpu_buddy_undo_splits(mm, block);
> +	gpu_buddy_undo_splits(mm, block, &splits);
>   
> -err_free:
>   	if (err == -ENOSPC && total_allocated_on_err) {
>   		list_splice_tail(&allocated, blocks);
>   		*total_allocated_on_err = total_allocated;
> 
> base-commit: 90780f2c3d30187116128f71bcf92c8ab63400e7

