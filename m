Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDAB6CD4F49
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0268710E8FB;
	Mon, 18 May 2026 15:55:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nvC2pr/f";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9191710E1CD;
 Mon, 18 May 2026 15:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779119717; x=1810655717;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=7zrfzZVmWcOeIHBmw69bZZJ8FB5u0s89gu//WG51oX4=;
 b=nvC2pr/fS7K466SIsdb39FguYvwayMZWuF+O0W9OLc5Z5RJzXEk+Rp6J
 dGODbEGA0kXZEC8RaGVENCn9Q3wbtcOPE5RizevoJyi+2yKJnGrNttZhY
 VWhyLTNcPfnlHbHcedWgTLQvVNvTCiXusuXv6v3lpH6pS1hUaL94+ssw7
 60QBSz4XMyjsFzA2f81/aLyG9jOaK0GUvWJa8AnKhMa8sggs+Il79myKE
 XlPFg/HYXS/hjlmGtmUF/1WiNU7Y/SNZ0z15quLpQzK5jvVsDT7D3VVo2
 BeHyaBEyjTwBEUSVKxWJJvN0ZwwfkOWj8z5XKeMWbGhqAMvNIfo20UXZb g==;
X-CSE-ConnectionGUID: eEpB4n0/RRCV4Tvgw9ffEQ==
X-CSE-MsgGUID: MYmr4YcOSZmq+KMg+FxLSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="91081627"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="91081627"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 08:55:16 -0700
X-CSE-ConnectionGUID: /13KnxRAT1u02JPIUWsJbw==
X-CSE-MsgGUID: CCmaU3diS6y22OtO+ifqAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="238617883"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.57])
 ([10.245.244.57])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 08:55:15 -0700
Message-ID: <f4b91f4c-6715-49db-8b8b-15711072dfac@intel.com>
Date: Mon, 18 May 2026 16:55:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] gpu/buddy: Fix use-after-free in split_block()
 call sites
To: Francois Dugast <francois.dugast@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Sashiko <sashiko-bot@kernel.org>
References: <20260518141446.124508-1-francois.dugast@intel.com>
 <20260518141446.124508-2-francois.dugast@intel.com>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <20260518141446.124508-2-francois.dugast@intel.com>
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
> When split_block() fails it returns before calling mark_split(), leaving
> the block in the FREE state and still linked in the rbtree.  The four
> err_undo paths then call __gpu_buddy_free() without first removing the
> block from the tree, which leads to two distinct bugs:
> 
>   - If the buddy is also free, __gpu_buddy_free() merges the two siblings
>     by calling gpu_block_free(mm, block) while block->rb is still linked
>     in the tree.  Any subsequent rbtree traversal will follow the now-
>     dangling pointer, causing a use-after-free.
> 
>   - In alloc_from_freetree(), where there is no buddy guard,
>     __gpu_buddy_free() always reaches mark_free() -> rbtree_insert() with
>     block still in the tree, corrupting the rbtree.
> 
> The same pattern is already used correctly in __force_merge(): call
> rbtree_remove() to unlink the block before handing it to
> __gpu_buddy_free().  Apply the same fix to all four err_undo sites.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> ---
>   drivers/gpu/buddy.c | 16 ++++++++++++----
>   1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index eb1457376307..dac2027bb64a 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -737,8 +737,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   	buddy = __get_buddy(block);
>   	if (buddy &&
>   	    (gpu_buddy_block_is_free(block) &&
> -	     gpu_buddy_block_is_free(buddy)))
> +	     gpu_buddy_block_is_free(buddy))) {
> +		rbtree_remove(mm, block);
>   		__gpu_buddy_free(mm, block, false);
> +	}
>   	return ERR_PTR(err);
>   }
>   
> @@ -847,8 +849,10 @@ alloc_from_freetree(struct gpu_buddy *mm,
>   	return block;
>   
>   err_undo:
> -	if (tmp != order)
> +	if (tmp != order) {
> +		rbtree_remove(mm, block);

Actually, I think this needs the same checking like elsewhere? Say we 
fail on the first split? Nothing was actually split, right?

>   		__gpu_buddy_free(mm, block, false);
> +	}
>   	return ERR_PTR(err);
>   }
>   
> @@ -968,8 +972,10 @@ gpu_buddy_offset_aligned_allocation(struct gpu_buddy *mm,
>   	buddy = __get_buddy(block);
>   	if (buddy &&
>   	    (gpu_buddy_block_is_free(block) &&
> -	     gpu_buddy_block_is_free(buddy)))
> +	     gpu_buddy_block_is_free(buddy))) {
> +		rbtree_remove(mm, block);
>   		__gpu_buddy_free(mm, block, false);
> +	}
>   	return ERR_PTR(err);
>   }
>   
> @@ -1054,8 +1060,10 @@ static int __alloc_range(struct gpu_buddy *mm,
>   	buddy = __get_buddy(block);
>   	if (buddy &&
>   	    (gpu_buddy_block_is_free(block) &&
> -	     gpu_buddy_block_is_free(buddy)))
> +	     gpu_buddy_block_is_free(buddy))) {
> +		rbtree_remove(mm, block);
>   		__gpu_buddy_free(mm, block, false);
> +	}
>   
>   err_free:
>   	if (err == -ENOSPC && total_allocated_on_err) {

