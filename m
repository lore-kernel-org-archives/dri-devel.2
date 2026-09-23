Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C20B8C9830C
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7E110E0E0;
	Wed, 23 Sep 2026 13:49:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="mQ/W8ZyC";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 56E7010E0E0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:49:13 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F5BE1516;
 Wed, 23 Sep 2026 06:49:09 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 115DE3F86F;
 Wed, 23 Sep 2026 06:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790171352; bh=XZjpz87fWuq0xeTRn18TokdKjnI48O4gDE75aIXRo/8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mQ/W8ZyCxdppzKi6TjFPjx+SnN6nJs1Q0ck64jZseOqja959/n3ZX/3vuBXryqiVy
 OL6BsCU2pOXRu8nZ7Rw2k3kSXnD9/Eum+CdiLMgaM+zfOhJSn9F4DHjrcdbTXpAfoQ
 tqz7RvO89PTGnZD7MrNYoOLeOeYFrJCzF3uTP37o=
Date: Wed, 23 Sep 2026 14:49:07 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 christian.koenig@amd.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v7 06/13] dma-contiguous: Accept an explicit minimum
 alignment
Message-ID: <arPY05E2xYflek07@arm.com>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-7-aneesh.kumar@kernel.org>
 <arOrgRfi1k12clT7@arm.com> <yq5a33v02nmn.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a33v02nmn.fsf@kernel.org>
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

On Wed, Sep 23, 2026 at 05:19:52PM +0530, Aneesh Kumar K.V wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Mon, Sep 21, 2026 at 08:18:40PM +0530, Aneesh Kumar K.V (Arm) wrote:
> >> @@ -125,7 +126,8 @@ static inline int dma_contiguous_reserve_area(phys_addr_t size,
> >>  	return -ENOSYS;
> >>  }
> >>  static inline struct page *dma_alloc_from_contiguous(struct device *dev,
> >> -		size_t count, unsigned int order, bool no_warn)
> >> +		size_t count, unsigned int order, unsigned int required_order,
> >> +		bool no_warn)
> >>  {
> >>  	return NULL;
> >>  }
> >> @@ -136,7 +138,7 @@ static inline bool dma_release_from_contiguous(struct device *dev,
> >>  }
> >>  /* Use fallback alloc() and free() when CONFIG_DMA_CMA=n */
> >>  static inline struct page *dma_alloc_contiguous(struct device *dev, size_t size,
> >> -		gfp_t gfp)
> >> +		gfp_t gfp, unsigned int align_order)
> >
> > Can we not just bake the alignment further down in these functions
> > rather than getting the callers to pass the {required,align}_order?
> >
> 
> But, we need this to be conditional on CoCo shared allocations. We could
> derive that from attrs and pass attrs instead of align_order, i.e.
> something like:
> 
> 
>  struct page *dma_alloc_from_contiguous(struct device *dev, size_t count,
> -		unsigned int align, unsigned int required_align, bool no_warn)
> +		unsigned int align, unsigned long attrs, bool no_warn)
>  {
> -	if (required_align > CONFIG_CMA_ALIGNMENT)
> +	if (!dma_contiguous_resolve_alignment(attrs, &align))
>  		return NULL;
> -	align = min(max(align, required_align), CONFIG_CMA_ALIGNMENT);
>  
>  	return cma_alloc(dev_get_cma_area(dev), count, align, no_warn);
>  }
> 
> 
> with
> 
> +static bool dma_contiguous_resolve_alignment(unsigned long attrs,
> +					     unsigned int *align)
> +{
> +	unsigned int required_align = 0;
> +
> +	if (attrs & __DMA_ATTR_ALLOC_CC_SHARED)
> +		required_align = get_order(cc_shared_granule_size());
> +	if (required_align > CONFIG_CMA_ALIGNMENT)
> +		return false;
> +
> +	*align = min(max(*align, required_align), CONFIG_CMA_ALIGNMENT);
> +	return true;
> +}

Yes, I think this would work.

-- 
Catalin
