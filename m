Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5365ACD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 15:38:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB96A10E8D8;
	Mon, 18 May 2026 15:38:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NO3z2qV6";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ADB010E5F5;
 Mon, 18 May 2026 15:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779118692; x=1810654692;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QtQzHczivCw5Lh8GqVNurExxrQyEk0hdEQiAdEQNbA8=;
 b=NO3z2qV6msbuALVaz5lizCXy3WJjKIueejYlNoyRLGgXEzINwNLLHKP9
 is50bLeJMYOWhLBNiBLDzj2sl5hyKA/BCIf+No4sL6L0amz6x+e8FsOSP
 Rf1oRHHdyWa5bDwmXmtTSk5EzMTorGzsKBDLGqj3cRyupppc7dvSsA5E6
 dieuZ5FbhN+PSU2LvKcqRpKaJBi9uisHOTc1aQ8txVWirM9dn1l/riUu8
 FNWQkltXJtTd4vlLPTOvBt9PO5LPKhFfshRXFN1cmOWMdtj1OCQ9xnRgv
 tcBdepLlHFInQV/9twUmz8oz+HBXK9miXB2KyaFpIYqfAv3V+QXFscdFD g==;
X-CSE-ConnectionGUID: 61tAZ5iZS9+/qqxkrN0LTA==
X-CSE-MsgGUID: 3WgviNRIR5Sqg6+lCDmc/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="97544083"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="97544083"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 08:38:11 -0700
X-CSE-ConnectionGUID: uUMDyEjFSKyeJdoc5Dm+gQ==
X-CSE-MsgGUID: i9wragSOSm2biC8yTykX+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; d="scan'208";a="262977548"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.244.57])
 ([10.245.244.57])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 May 2026 08:38:10 -0700
Message-ID: <c4b26104-41c8-4e32-b7a7-aa6b5063985f@intel.com>
Date: Mon, 18 May 2026 16:38:08 +0100
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

Reviewed-by: Matthew Auld <matthew.auld@intel.com>

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

