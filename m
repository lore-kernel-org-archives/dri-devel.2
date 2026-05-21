Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8870CD4F3D
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 16:18:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11F4910E502;
	Thu, 21 May 2026 16:18:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hSjSb83D";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4798310E4C0;
 Thu, 21 May 2026 16:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779380315; x=1810916315;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=0DhCNQ2SazVfsr/SX8TRWY3jXNCjUdp6CNGTiaiiPIs=;
 b=hSjSb83DJ6jLEcoUqqpRrn+nFgGXf+w9gdWuu28vcjKjQWdRA+AVi7JW
 We7agMcdt4BggH1knAXzgiu0zR8dNvyHFphCDReX6hWtekhitrPld4W47
 bikm/ugACvguz4yiXXgDKlI6sMgguxnKqwMYiiXcB74nVUv+JTYiY44w/
 hvmzrdI8ctG1x5dwddUGAlrfnE81oDtwcYx+6lz5dx7oZ9IMzrji5Pb+L
 4pTbFBMu9UY4bHtIUv/dT8Zi4QX5ziqH2NkEgsAuyyWBafrDxwf8W9koS
 D329gCinFvWa7nP9HAvPzbVA5PsuImpq6HbBwMC9qchI0A6tmXfreeaqL Q==;
X-CSE-ConnectionGUID: 77AWfl57TP2UnoM8+byvlQ==
X-CSE-MsgGUID: E9pblfZvRemEgPPFQk/Tvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="80335704"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="80335704"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 09:18:35 -0700
X-CSE-ConnectionGUID: ffeaSz8EQm2p0U47MmUOFA==
X-CSE-MsgGUID: rSAYMUySTzyghnFM54W0iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; d="scan'208";a="270917954"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO [10.245.244.79])
 ([10.245.244.79])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2026 09:18:34 -0700
Message-ID: <8abba840-14a1-40d1-a3e6-1fd1aff5820c@intel.com>
Date: Thu, 21 May 2026 17:18:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] gpu/buddy: Fix use-after-free in split_block()
 call sites
To: Francois Dugast <francois.dugast@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260518141446.124508-1-francois.dugast@intel.com>
 <20260518141446.124508-2-francois.dugast@intel.com>
 <f4b91f4c-6715-49db-8b8b-15711072dfac@intel.com>
 <ag2T6DbnGQTUPRDn@fdugast-desk>
Content-Language: en-GB
From: Matthew Auld <matthew.auld@intel.com>
In-Reply-To: <ag2T6DbnGQTUPRDn@fdugast-desk>
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

On 20/05/2026 11:58, Francois Dugast wrote:
> On Mon, May 18, 2026 at 04:55:12PM +0100, Matthew Auld wrote:
>> On 18/05/2026 15:14, Francois Dugast wrote:
>>> When split_block() fails it returns before calling mark_split(), leaving
>>> the block in the FREE state and still linked in the rbtree.  The four
>>> err_undo paths then call __gpu_buddy_free() without first removing the
>>> block from the tree, which leads to two distinct bugs:
>>>
>>>    - If the buddy is also free, __gpu_buddy_free() merges the two siblings
>>>      by calling gpu_block_free(mm, block) while block->rb is still linked
>>>      in the tree.  Any subsequent rbtree traversal will follow the now-
>>>      dangling pointer, causing a use-after-free.
>>>
>>>    - In alloc_from_freetree(), where there is no buddy guard,
>>>      __gpu_buddy_free() always reaches mark_free() -> rbtree_insert() with
>>>      block still in the tree, corrupting the rbtree.
>>>
>>> The same pattern is already used correctly in __force_merge(): call
>>> rbtree_remove() to unlink the block before handing it to
>>> __gpu_buddy_free().  Apply the same fix to all four err_undo sites.
>>>
>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>> Signed-off-by: Francois Dugast <francois.dugast@intel.com>
>>> Assisted-by: GitHub Copilot:claude-sonnet-4.6
>>> ---
>>>    drivers/gpu/buddy.c | 16 ++++++++++++----
>>>    1 file changed, 12 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>> index eb1457376307..dac2027bb64a 100644
>>> --- a/drivers/gpu/buddy.c
>>> +++ b/drivers/gpu/buddy.c
>>> @@ -737,8 +737,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>    	buddy = __get_buddy(block);
>>>    	if (buddy &&
>>>    	    (gpu_buddy_block_is_free(block) &&
>>> -	     gpu_buddy_block_is_free(buddy)))
>>> +	     gpu_buddy_block_is_free(buddy))) {
>>> +		rbtree_remove(mm, block);
>>>    		__gpu_buddy_free(mm, block, false);
>>> +	}
>>>    	return ERR_PTR(err);
>>>    }
>>> @@ -847,8 +849,10 @@ alloc_from_freetree(struct gpu_buddy *mm,
>>>    	return block;
>>>    err_undo:
>>> -	if (tmp != order)
>>> +	if (tmp != order) {
>>> +		rbtree_remove(mm, block);
>>
>> Actually, I think this needs the same checking like elsewhere? Say we fail
>> on the first split? Nothing was actually split, right?
> 
> I think this is unnecessary: for block this is tested above with
> BUG_ON(!gpu_buddy_block_is_free(block)). If split_block() fails then it
> happens before mark_split() so block remains free. If buddy is not free
> then the merge loop is skipped in __gpu_buddy_free() but mark_free() is
> called so we do remove + re-insert.
> 
> Also, the checks are added with patch #3 and the introduction of
> __gpu_buddy_undo_splits().

Right, makes sense.

> 
> Francois
> 
>>
>>>    		__gpu_buddy_free(mm, block, false);
>>> +	}
>>>    	return ERR_PTR(err);
>>>    }
>>> @@ -968,8 +972,10 @@ gpu_buddy_offset_aligned_allocation(struct gpu_buddy *mm,
>>>    	buddy = __get_buddy(block);
>>>    	if (buddy &&
>>>    	    (gpu_buddy_block_is_free(block) &&
>>> -	     gpu_buddy_block_is_free(buddy)))
>>> +	     gpu_buddy_block_is_free(buddy))) {
>>> +		rbtree_remove(mm, block);
>>>    		__gpu_buddy_free(mm, block, false);
>>> +	}
>>>    	return ERR_PTR(err);
>>>    }
>>> @@ -1054,8 +1060,10 @@ static int __alloc_range(struct gpu_buddy *mm,
>>>    	buddy = __get_buddy(block);
>>>    	if (buddy &&
>>>    	    (gpu_buddy_block_is_free(block) &&
>>> -	     gpu_buddy_block_is_free(buddy)))
>>> +	     gpu_buddy_block_is_free(buddy))) {
>>> +		rbtree_remove(mm, block);
>>>    		__gpu_buddy_free(mm, block, false);
>>> +	}
>>>    err_free:
>>>    	if (err == -ENOSPC && total_allocated_on_err) {
>>

