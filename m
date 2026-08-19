Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B8BC5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:56:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ACAC10E129;
	Wed, 19 Aug 2026 11:56:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jZGfP4LO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3584B10E129;
 Wed, 19 Aug 2026 11:56:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C479D43BED;
 Wed, 19 Aug 2026 11:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10D861F00A3A;
 Wed, 19 Aug 2026 11:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787140576;
 bh=Y9TFlC97/fU5+jsWSUYX/0b4tnqB948mdcrxZc+Z0N8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jZGfP4LOjEgn/xAy8xqqbTtHf3OvevkPjSPvRwpOxQL4yNlXiX16JziQPRZ3ri78N
 z8QmSHVTA9+sbqPnawJSgwo3wFIK9EWukI5LzffyKU+ctA/C5y5CPxKZqFd0sTyRnA
 P1nQbILmsQWdudMyVt6o5CSH/TuXu0EKZIe8/j/oZe7Vk3CWBpFwksddF2BmqK7Cdi
 04fR/A5yGkXuM7bn5n+/a8JRu7v5ZJlyZ10Wry3pT+0iBLK2eyK3B8mrDi7tmpWR+b
 Gtmm3F/PuLqHRFVwo8sjeV5sLmDTdhGcYNJv6pu9bwpW6fSZV/GWbyFd50uzC4npnK
 8HkeVNs3QDLUA==
Date: Wed, 19 Aug 2026 13:56:13 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>, 
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 =?utf-8?Q?Micha=C5=82?= Grzelak <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v5 1/6] drm/i915/gem: Count mapped pages in a folio
Message-ID: <aoWMcLMNCl0cjcLx@zenone.zhora.eu>
References: <20260817095648.2438192-1-krzysztof.karas@intel.com>
 <20260817095648.2438192-2-krzysztof.karas@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817095648.2438192-2-krzysztof.karas@intel.com>
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

Hi Krzysztof,

your patch looks good, but it needs to be polished a bit.

...

> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> index 06543ae60706..f338dc39fad1 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
> @@ -68,10 +68,13 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>  			 unsigned int max_segment)
>  {
>  	unsigned int page_count; /* restricted by sg_alloc_table */
> -	unsigned long i;
> +	unsigned long next_pfn = 0; /* suppress gcc warning */
> +	unsigned long folio_start = 0;
> +	unsigned long folio_end = 0;

Can these go inside the for loop? Keep variables in the innermost
section needed.


Besides

> +	struct folio *folio = NULL;
>  	struct scatterlist *sg;
> -	unsigned long next_pfn = 0;	/* suppress gcc warning */
>  	gfp_t noreclaim;
> +	unsigned long i;

Please, don't reorder variables in this patch, it's out of the
scope.

>  	int ret;
>  
>  	if (overflows_type(size / PAGE_SIZE, page_count))
> @@ -85,6 +88,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>  	if (size > resource_size(&mr->region))
>  		return -ENOMEM;
>  
> +	if (max_segment < PAGE_SIZE)
> +		return -EINVAL;
> +

the max_segment validation is out of the scope.

>  	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
>  		return -ENOMEM;
>  
> @@ -101,7 +107,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>  	sg = st->sgl;
>  	st->nents = 0;
>  	for (i = 0; i < page_count; i++) {
> -		struct folio *folio;

Why are you moving this out of the for loop?

> +		unsigned long folio_page_index = 0;

This initialization is not necessary.

>  		unsigned long nr_pages;
>  		const unsigned int shrink[] = {
>  			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,

...

> +				}
> +			} while (1);
> +
> +			folio_start = folio_pgoff(folio);
> +			folio_end = folio_start + folio_nr_pages(folio) - 1;
> +		}
> +
> +		folio_page_index = i - folio_start;
> +		if (WARN_ON_ONCE(folio_page_index >= folio_nr_pages(folio))) {
> +			ret = -EINVAL;
> +			folio_put(folio);

I think shmem_sg_free_table() drops the folio reference already,
right?

> +			goto err_sg;
> +		}

Is this WARN_ON_ONCE() check really necessary?

>  
>  		nr_pages = min_array(((unsigned long[]) {
> -					folio_nr_pages(folio),
> +					folio_nr_pages(folio) - folio_page_index,
>  					page_count - i,
>  					max_segment / PAGE_SIZE,
>  				      }), 3);

...

> @@ -186,6 +216,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
>  	i915_sg_trim(st);
>  
>  	return 0;
> +

Drop this change

What I want from this patch is a minimal change, without any
churn not belonging to the sole scope of the patch.

Thanks, Krzysztof,
Andi

>  err_sg:
>  	sg_mark_end(sg);
>  	if (sg != st->sgl) {
> -- 
> 2.34.1
> 
