Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 036EFFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FFB10E960;
	Tue,  5 May 2026 07:12:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; secure) header.d=panix.com header.i=@panix.com header.b="olpCBwjT";
	dkim-atps=neutral
Received: from mailbackend.panix.com (mailbackend.panix.com [166.84.1.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DE710E21A;
 Fri,  1 May 2026 22:57:22 +0000 (UTC)
Received: from [10.50.4.26] (45-31-46-51.lightspeed.sndgca.sbcglobal.net
 [45.31.46.51])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4g6mdY0ZkBz4Vxx;
 Fri,  1 May 2026 18:57:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1777676241; bh=tbNoSz+TYk+wwrYQ8y6aYsYId0XhheqQ8jh56VRMikM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=olpCBwjTQ96jAtct84MqIaGKdURZ8J0X9P9hC6Z6qaMHCqPLZnqpBtYvguHjgbuKg
 tljhfzDb2vw9YpMxkmPDnddTKI7d4/oiM+c36imsEsvGmF9KNKfiOTJacSgxhyVbXr
 kw5DUP0LQS+YlglefWCscxnZbHET5BH1mznOJ3l4=
Message-ID: <cc2ef040-23c2-4dab-a57f-e2df374deef9@panix.com>
Date: Fri, 1 May 2026 15:57:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm: Fix GPU MM stats during pool shrinking
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui
 <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 David Airlie <airlied@gmail.com>
References: <20260501223003.2648450-1-matthew.brost@intel.com>
Content-Language: en-US
From: Kenneth Crudup <kenny@panix.com>
In-Reply-To: <20260501223003.2648450-1-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 05 May 2026 07:12:26 +0000
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


On 5/1/26 15:30, Matthew Brost wrote:

> TTM pool shrinking frees pages by calling __free_pages() directly,
> which bypasses updates to NR_GPU_ACTIVE and leaves GPU MM accounting
> out of sync.
> 
> Introduce a helper, __free_pages_gpu_account(), and use it for all page
> frees in ttm_pool.c so GPU MM statistics are updated consistently.
> 
> Reported-by: Kenneth Crudup <kenny@panix.com>
> Fixes: ae80122f3896 ("drm/ttm: use gpu mm stats to track gpu memory allocations. (v4)")
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: David Airlie <airlied@gmail.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>   drivers/gpu/drm/ttm/ttm_pool.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)

Tested-By: Kenneth R. Crudup <kenny@panix.com>

> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 26a3689e5fd9..95bbd9328072 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -206,6 +206,14 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>   	return NULL;
>   }
>   
> +static void __free_pages_gpu_account(struct page *p, unsigned int order,
> +				     bool reclaim)
> +{
> +	mod_lruvec_page_state(p, reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTIVE,
> +			      -(1 << order));
> +	__free_pages(p, order);
> +}
> +
>   /* Reset the caching and pages of size 1 << order */
>   static void ttm_pool_free_page(struct ttm_pool *pool, enum ttm_caching caching,
>   			       unsigned int order, struct page *p, bool reclaim)
> @@ -223,9 +231,7 @@ static void ttm_pool_free_page(struct ttm_pool *pool, enum ttm_caching caching,
>   #endif
>   
>   	if (!pool || !ttm_pool_uses_dma_alloc(pool)) {
> -		mod_lruvec_page_state(p, reclaim ? NR_GPU_RECLAIM : NR_GPU_ACTIVE,
> -				      -(1 << order));
> -		__free_pages(p, order);
> +		__free_pages_gpu_account(p, order, reclaim);
>   		return;
>   	}
>   
> @@ -606,7 +612,7 @@ static int ttm_pool_restore_commit(struct ttm_pool_tt_restore *restore,
>   			 */
>   			ttm_pool_split_for_swap(restore->pool, p);
>   			copy_highpage(restore->alloced_page + i, p);
> -			__free_pages(p, 0);
> +			__free_pages_gpu_account(p, 0, false);
>   		}
>   
>   		restore->restored_pages++;
> @@ -1068,7 +1074,7 @@ long ttm_pool_backup(struct ttm_pool *pool, struct ttm_tt *tt,
>   			if (flags->purge) {
>   				shrunken += num_pages;
>   				page->private = 0;
> -				__free_pages(page, order);
> +				__free_pages_gpu_account(page, order, false);
>   				memset(tt->pages + i, 0,
>   				       num_pages * sizeof(*tt->pages));
>   			}

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange 
County CA

