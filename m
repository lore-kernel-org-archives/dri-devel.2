Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3DCF53D85
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:26:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA2910E2B8;
	Mon, 16 Mar 2026 18:26:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 52DF210E3C8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 18:26:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E67C339;
 Mon, 16 Mar 2026 11:25:56 -0700 (PDT)
Received: from [10.57.61.116] (unknown [10.57.61.116])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 262AB3F778;
 Mon, 16 Mar 2026 11:25:58 -0700 (PDT)
Message-ID: <15fcfa5e-c4b9-4b56-8f84-20dd5f66d643@arm.com>
Date: Mon, 16 Mar 2026 18:25:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dma-mapping: introduce DMA_ATTR_CC_DECRYPTED for
 pre-decrypted memory
To: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org
Cc: sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
 Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
 christian.koenig@amd.com, m.szyprowski@samsung.com, jgg@ziepe.ca,
 leon@kernel.org, sean.anderson@linux.dev, ptesarik@suse.com,
 catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev
References: <20260316125857.617836-1-jiri@resnulli.us>
 <20260316125857.617836-2-jiri@resnulli.us>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260316125857.617836-2-jiri@resnulli.us>
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

On 2026-03-16 12:58 pm, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Current CC designs don't place a vIOMMU in front of untrusted devices.
> Instead, the DMA API forces all untrusted device DMA through swiotlb
> bounce buffers (is_swiotlb_force_bounce()) which copies data into
> decrypted memory on behalf of the device.
> 
> When a caller has already arranged for the memory to be decrypted
> via set_memory_decrypted(), the DMA API needs to know so it can map
> directly using the unencrypted physical address rather than bounce
> buffering. Following the pattern of DMA_ATTR_MMIO, add
> DMA_ATTR_CC_DECRYPTED for this purpose. Like the MMIO case, only the
> caller knows what kind of memory it has and must inform the DMA API
> for it to work correctly.

Echoing Jason's point, if the intent of this is to indicate shared 
memory, please call it DMA_ATTR_CC_SHARED. Yes, some of the existing 
APIs are badly named because they conflated intent with implementation 
details; that is no reason to keep wilfully making the same mistake.

At least with Arm CCA, the architecture enforces *confidentiality* 
pretty much orthogonally to encryption - if your threat model excludes 
physical attacks against DRAM, you can still have Realms isolated from 
each other (and of course other execution states) without even 
implementing the memory encryption feature; conversely if you do have 
it, then even all the shared/host memory may still be physically 
encrypted, it just has its own context (key) distinct from the Realm 
ones. Similarly, while it's not a "true" CoCo environment, pKVM has a 
similar notion of shared vs. private which can benefit from 
piggy-backing off much of the CoCo infrastructure in places like the DMA 
layer, but has nothing whatsoever to do with actual encryption.

Furthermore, "shared" is just shorter and more readable, even before I 
invoke the previous discussion of why it should be "unencrypted" rather 
than "decrypted" anyway ;)

> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v3->v4:
> - added some sanity checks to dma_map_phys and dma_unmap_phys
> - enhanced documentation of DMA_ATTR_CC_DECRYPTED attr
> v1->v2:
> - rebased on top of recent dma-mapping-fixes
> ---
>   include/linux/dma-mapping.h | 10 ++++++++++
>   include/trace/events/dma.h  |  3 ++-
>   kernel/dma/direct.h         | 14 +++++++++++---
>   kernel/dma/mapping.c        | 13 +++++++++++--
>   4 files changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 29973baa0581..476964d2b22f 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -85,6 +85,16 @@
>    * a cacheline must have this attribute for this to be considered safe.
>    */
>   #define DMA_ATTR_CPU_CACHE_CLEAN	(1UL << 11)
> +/*
> + * DMA_ATTR_CC_DECRYPTED: Indicates the DMA mapping is decrypted (shared) for
> + * confidential computing guests. For normal system memory the caller must have
> + * called set_memory_decrypted(), and pgprot_decrypted must be used when
> + * creating CPU PTEs for the mapping. The same decrypted semantic may be passed
> + * to the vIOMMU when it sets up the IOPTE. For MMIO use together with

That being "the vIOMMU" that you said doesn't exist, and which is 
explicitly not supported?...

> + * DMA_ATTR_MMIO to indicate decrypted MMIO. Unless DMA_ATTR_MMIO is provided
> + * a struct page is required.
> + */
> +#define DMA_ATTR_CC_DECRYPTED	(1UL << 12)
>   
>   /*
>    * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
> diff --git a/include/trace/events/dma.h b/include/trace/events/dma.h
> index 33e99e792f1a..b8082d5177c4 100644
> --- a/include/trace/events/dma.h
> +++ b/include/trace/events/dma.h
> @@ -32,7 +32,8 @@ TRACE_DEFINE_ENUM(DMA_NONE);
>   		{ DMA_ATTR_ALLOC_SINGLE_PAGES, "ALLOC_SINGLE_PAGES" }, \
>   		{ DMA_ATTR_NO_WARN, "NO_WARN" }, \
>   		{ DMA_ATTR_PRIVILEGED, "PRIVILEGED" }, \
> -		{ DMA_ATTR_MMIO, "MMIO" })
> +		{ DMA_ATTR_MMIO, "MMIO" }, \
> +		{ DMA_ATTR_CC_DECRYPTED, "CC_DECRYPTED" })
>   
>   DECLARE_EVENT_CLASS(dma_map,
>   	TP_PROTO(struct device *dev, phys_addr_t phys_addr, dma_addr_t dma_addr,
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index e89f175e9c2d..c047a9d0fda3 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -84,16 +84,24 @@ static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>   	dma_addr_t dma_addr;
>   
>   	if (is_swiotlb_force_bounce(dev)) {
> -		if (attrs & DMA_ATTR_MMIO)
> -			return DMA_MAPPING_ERROR;
> +		if (!(attrs & DMA_ATTR_CC_DECRYPTED)) {
> +			if (attrs & DMA_ATTR_MMIO)
> +				return DMA_MAPPING_ERROR;
>   
> -		return swiotlb_map(dev, phys, size, dir, attrs);
> +			return swiotlb_map(dev, phys, size, dir, attrs);
> +		}
> +	} else if (attrs & DMA_ATTR_CC_DECRYPTED) {
> +		return DMA_MAPPING_ERROR;
>   	}
>   
>   	if (attrs & DMA_ATTR_MMIO) {
>   		dma_addr = phys;
>   		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
>   			goto err_overflow;
> +	} else if (attrs & DMA_ATTR_CC_DECRYPTED) {
> +		dma_addr = phys_to_dma_unencrypted(dev, phys);
> +		if (unlikely(!dma_capable(dev, dma_addr, size, false)))
> +			goto err_overflow;
>   	} else {
>   		dma_addr = phys_to_dma(dev, phys);
>   		if (unlikely(!dma_capable(dev, dma_addr, size, true)) ||
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 3928a509c44c..abb0c88b188b 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -157,6 +157,7 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   	bool is_mmio = attrs & DMA_ATTR_MMIO;
> +	bool is_cc_decrypted = attrs & DMA_ATTR_CC_DECRYPTED;
>   	dma_addr_t addr = DMA_MAPPING_ERROR;
>   
>   	BUG_ON(!valid_dma_direction(dir));
> @@ -165,8 +166,11 @@ dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>   		return DMA_MAPPING_ERROR;
>   
>   	if (dma_map_direct(dev, ops) ||
> -	    (!is_mmio && arch_dma_map_phys_direct(dev, phys + size)))
> +	    (!is_mmio && !is_cc_decrypted &&
> +	     arch_dma_map_phys_direct(dev, phys + size)))
>   		addr = dma_direct_map_phys(dev, phys, size, dir, attrs);
> +	else if (is_cc_decrypted)
> +		return DMA_MAPPING_ERROR;
>   	else if (use_dma_iommu(dev))

...although, why *shouldn't* this be allowed with a vIOMMU? (Especially 
given that a vIOMMU for untrusted devices can be emulated by the host 
VMM without the CoCo hypervisor having to care at all - again, at least 
on Arm and other architectures where IOMMUs are regular driver model 
devices)

>   		addr = iommu_dma_map_phys(dev, phys, size, dir, attrs);
>   	else if (ops->map_phys)

Or indeed any other non-direct ops? Obviously all the legacy 
architectures like Alpha are never going to see this or care, but I 
could imagine Xen and possibly PowerPC might.

Thanks,
Robin.

> @@ -203,11 +207,16 @@ void dma_unmap_phys(struct device *dev, dma_addr_t addr, size_t size,
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   	bool is_mmio = attrs & DMA_ATTR_MMIO;
> +	bool is_cc_decrypted = attrs & DMA_ATTR_CC_DECRYPTED;
>   
>   	BUG_ON(!valid_dma_direction(dir));
> +
>   	if (dma_map_direct(dev, ops) ||
> -	    (!is_mmio && arch_dma_unmap_phys_direct(dev, addr + size)))
> +	    (!is_mmio && !is_cc_decrypted &&
> +	     arch_dma_unmap_phys_direct(dev, addr + size)))
>   		dma_direct_unmap_phys(dev, addr, size, dir, attrs);
> +	else if (is_cc_decrypted)
> +		return;
>   	else if (use_dma_iommu(dev))
>   		iommu_dma_unmap_phys(dev, addr, size, dir, attrs);
>   	else if (ops->unmap_phys)

