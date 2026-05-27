Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AA7CD5BDE
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 08:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF2AB10E18B;
	Wed, 27 May 2026 08:51:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A4bj/hmQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C9CB10E18B;
 Wed, 27 May 2026 08:51:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C15BC4396D;
 Wed, 27 May 2026 08:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AD71F00A3D;
 Wed, 27 May 2026 08:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779871908;
 bh=cw6Hq3fwY9dORsY8hW5a014rXACoZ3Q9ELeTsBjnSJM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=A4bj/hmQa3H0KsSybQA679jZY8C2M2EBxCmGFd4kLjKqsNk3QWKHZjyPK5mXRkcfX
 VpWCAte43G/7b72JGRYwED2VJuyypr5CTDlz+B/TBjr+N205H33pNj87fbEH7GjTMD
 f4IzoJPCYeB66bnO4D2+DjO3keQikG9pILexzAijVpqCIMzJOir5m7RmSLWK4oBGUx
 HpxXjQHd9D1kqOUe/dWA+5FlGHtZur/fBmi1sPvyfdRgQVFYYfU4QdQGQhpaG5w5EU
 Y1D1Hds9rZPfYSD7ptH/l2KRCdPsgF384y4fFB2IicC6PJSaekfzn3Pg06DbJM/mVv
 ywTh7ch9dWuXw==
Message-ID: <e4dcfbc8-2666-452c-90b2-25c4b2c50c9f@kernel.org>
Date: Wed, 27 May 2026 10:51:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/slab: improve kmem_cache_alloc_bulk
To: Christoph Hellwig <hch@lst.de>, Vlastimil Babka <vbabka@kernel.org>,
 Harry Yoo <harry@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, io-uring@vger.kernel.org,
 kasan-dev@googlegroups.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Matt Fleming <mfleming@cloudflare.com>,
 kernel-team <kernel-team@cloudflare.com>
References: <20260527070239.2252948-1-hch@lst.de>
 <20260527070239.2252948-2-hch@lst.de>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260527070239.2252948-2-hch@lst.de>
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



On 27/05/2026 09.02, Christoph Hellwig wrote:
> The kmem_cache_alloc_bulk return value is weird.  It returns the number
> of allocated objects, but that must always be 0 or the requested number
> based on the implementations and the handling in the callers, but that
> assumption is not actually documented anywhere, which confuses automated
> review tools.
> 

I remember, this API behavior was requested by AKPM when I developed
kmem_cache_alloc_bulk.  I trusted AKPM's decision, but I cannot explain
why this choice was made.

I kept the netdev code usage below. The current napi_skb_cache_get_bulk
have a retry logic that assumes that a partial bulk number can be
returned (which it cannot as Hellwig explains).  Cc Alex/Olek please
review the changes below as you added this retry logic.


> Fix this by returning a bool if the allocation succeeded and adding a
> kerneldoc comment explaining the API.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/gpu/drm/msm/msm_iommu.c       |  6 +--
>   drivers/gpu/drm/panthor/panthor_mmu.c | 12 +++---
>   include/linux/slab.h                  |  6 ++-
>   io_uring/io_uring.c                   | 23 +++++------
>   lib/test_meminit.c                    | 19 +++++----
>   mm/kasan/kasan_test_c.c               |  5 +--
>   mm/kfence/kfence_test.c               |  9 +++--
>   mm/slub.c                             | 58 +++++++++++++++------------
>   net/bpf/test_run.c                    |  7 ++--
>   net/core/skbuff.c                     | 24 ++++++-----
>   tools/include/linux/slab.h            |  2 +-
>   tools/testing/shared/linux.c          | 19 ++++-----
>   12 files changed, 93 insertions(+), 97 deletions(-)
> 

[...]

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 44ac121cfccb..73045b688385 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -288,11 +288,11 @@ static inline struct sk_buff *napi_skb_cache_get(bool alloc)
>   
>   	local_lock_nested_bh(&napi_alloc_cache.bh_lock);
>   	if (unlikely(!nc->skb_count)) {
> -		if (alloc)
> -			nc->skb_count = kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
> -						GFP_ATOMIC | __GFP_NOWARN,
> -						NAPI_SKB_CACHE_BULK,
> -						nc->skb_cache);
> +		if (alloc && kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
> +						   GFP_ATOMIC | __GFP_NOWARN,
> +						   NAPI_SKB_CACHE_BULK,
> +						   nc->skb_cache))
> +			nc->skb_count = NAPI_SKB_CACHE_BULK;
>   		if (unlikely(!nc->skb_count)) {
>   			local_unlock_nested_bh(&napi_alloc_cache.bh_lock);
>   			return NULL;
> @@ -353,16 +353,18 @@ u32 napi_skb_cache_get_bulk(void **skbs, u32 n)
>   
>   	/* No enough cached skbs. Try refilling the cache first */
>   	bulk = min(NAPI_SKB_CACHE_SIZE - nc->skb_count, NAPI_SKB_CACHE_BULK);
> -	nc->skb_count += kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
> -					       GFP_ATOMIC | __GFP_NOWARN, bulk,
> -					       &nc->skb_cache[nc->skb_count]);
> +	if (kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
> +				  GFP_ATOMIC | __GFP_NOWARN, bulk,
> +				  &nc->skb_cache[nc->skb_count]))
> +		nc->skb_count += bulk;
>   	if (likely(nc->skb_count >= n))
>   		goto get;
>   
>   	/* Still not enough. Bulk-allocate the missing part directly, zeroed */
> -	n -= kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
> -				   GFP_ATOMIC | __GFP_ZERO | __GFP_NOWARN,
> -				   n - nc->skb_count, &skbs[nc->skb_count]);
> +	if (kmem_cache_alloc_bulk(net_hotdata.skbuff_cache,
> +				  GFP_ATOMIC | __GFP_ZERO | __GFP_NOWARN,
> +				  n - nc->skb_count, &skbs[nc->skb_count]))
> +		n = nc->skb_count;
>   	if (likely(nc->skb_count >= n))
>   		goto get;
>   
