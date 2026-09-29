Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D482CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A6FA10E6E1;
	Tue, 29 Sep 2026 11:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FgFdOrHS";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73AFA10E6CD;
 Tue, 29 Sep 2026 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790682332; x=1822218332;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ve3q4OgY29qfgLVAAMpW86ylCqcJ65a++paFdqRS8Lw=;
 b=FgFdOrHSD+A8fDp1cU04KWVtTZOFC+0rxo1fbenrw60BhXGAOoMt5TFl
 8GKf2pQHun60R4XMg2+lok6URPeFwk0ovRCFQqW+scYooYOeCOSnGCX3k
 F3jxeTJ6updxaxnWKRSFUJ4BwUFP2VQUF1CEqEASTJuo5Yong2yg6IHJb
 xawc5TKSSRBHXXblChQo+BOo4VEuYSyze7yuqZ/3am+J/x+PRGZ4G61eb
 NfJEYKdcy3+dy1ILfVQ55thsBoch3S05F1I+niVz+Gw3xJh84lYZFcUOS
 NUgYdAhtEFi3G1lq6OfQm7Gf0q6eIeLakSyY57CRaeuQ2mbo2p8EA+vD8 w==;
X-CSE-ConnectionGUID: rGVMDkbzT22rfYvrNDXinA==
X-CSE-MsgGUID: fXq8xDqARXu6dQScPnYUyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91496695"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="91496695"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 04:45:32 -0700
X-CSE-ConnectionGUID: OZjUVBngTH6OyCeUoVFniQ==
X-CSE-MsgGUID: IZ5+FHG2RlOElOuIZLfQmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="279175485"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.245.8])
 ([10.245.245.8])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 04:45:30 -0700
Message-ID: <978a409e-4ac9-407b-8c57-557965b30469@intel.com>
Date: Tue, 29 Sep 2026 12:45:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] gpu/buddy: fix missing split-undo on
 allocation-search exhaustion
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com, alexander.deucher@amd.com,
 Anand.Raghavendra@amd.com
References: <20260929105407.484707-1-arunpravin.paneerselvam@amd.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260929105407.484707-1-arunpravin.paneerselvam@amd.com>
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

On 29/09/2026 11:54, Arunpravin Paneer Selvam wrote:
> From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> 
> __alloc_range_bias() only undid splits made during its search when
> split_block() itself failed. Its DFS-exhaustion failure path (-ENOSPC,
> when no suitable block is found) skipped the undo, leaving the buddy
> tree needlessly fragmented over repeated failed allocation attempts.
> 
> Fix by recording every successful split_block() call in a list and
> unconditionally undoing those splits on every failure exit, via a
> new single-level gpu_buddy_merge_one_level() helper (the original
> __gpu_buddy_undo_splits() cascaded merges upward, which is unsafe
> when called per split-list entry).
> 
> Resolves the igt@kms_plane@plane-panning-bottom-right@pipe-a/pipe-b
> regression.
> 
> v2:
>   - Drop the undo from __alloc_range(): it allocates every block it walks,
>     so freeing that list on failure already merges the splits. (Matthew)
> 
> Fixes: 1ad5e807f716 ("gpu/buddy: replace dual-tree/force_merge with decoupled dirty tracker")
> Assisted-by: Claude:claude-opus-4-8
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Christian König <christian.koenig@amd.com>
> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
> ---
>   drivers/gpu/buddy.c | 54 +++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 2f2aaadafe35..e5c9e21cd077 100644
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

Looking at this now, I also don't see any issue here? If we got here:

1. block_order >= order.
2. adjust_end/start is aligned to order and fits within block.

Given that there must be something in here that will eventually hit 
block_order == order, given some number of splits, so either split fails 
or we must hit the 'return block'?


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
> 
> base-commit: 90780f2c3d30187116128f71bcf92c8ab63400e7

