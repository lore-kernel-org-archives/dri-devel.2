Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B565DF9B5F5
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 09:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F157110E295;
	Wed, 22 Apr 2026 09:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LLQZJ+1k";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F7E710E295
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 09:18:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F2306011F;
 Wed, 22 Apr 2026 09:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7191C19425;
 Wed, 22 Apr 2026 09:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776849528;
 bh=K8pcoY2WgjFw92Yz0dOk8n5L/ZPIsmzw+Zb1EkmEH/o=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=LLQZJ+1kSY/o60d6TTX7DKYBkuuD8VNc4XiuneZZhwI/K3F3/KYPHPlKbb/7y41F0
 gW1geJvdRNu0QQF2ij+TdA1Ko6jujZCK/cQOjIaqyw1+Do9f0iniyArT4lNax/LEZV
 hM6b/dNMUWVUMQmA71kXlXPG59YnQYZW9oqBVyfSD41/HPP2mLSWqE4thBh30kYWAe
 ++lrrvZfP3q9VR1MrQ0mrIYbQIm5mwvKy5DbT3+ooWNPnWVuklVR8qXC5xAHiG3bju
 uV+jNi6tXJJiBLTXufIj9S5p9mECdkVaQQ3Uo/5V7pf2LGjpD8hv6xWI7SxI3bKhVG
 N/ctHrkaSbPjA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Jiri Pirko <jiri@resnulli.us>
Cc: dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux.dev, linux-media@vger.kernel.org,
 sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
 Brian.Starkey@arm.com, jstultz@google.com, tjmercier@google.com,
 christian.koenig@amd.com, m.szyprowski@samsung.com,
 robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev,
 ptesarik@suse.com, catalin.marinas@arm.com,
 suzuki.poulose@arm.com, steven.price@arm.com,
 thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
In-Reply-To: <20260421121004.GA3611611@ziepe.ca>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us> <yq5atst6ywbl.fsf@kernel.org>
 <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
 <20260421121004.GA3611611@ziepe.ca>
Date: Wed, 22 Apr 2026 14:48:37 +0530
Message-ID: <yq5aik9jcpzm.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Jason Gunthorpe <jgg@ziepe.ca> writes:

> On Tue, Apr 21, 2026 at 01:53:31PM +0200, Jiri Pirko wrote:
>> >> You reach there when is_swiotlb_force_bounce(dev) is true and
>> >> DMA_ATTR_CC_SHARED is set. What am I missing?
>> >>
>> >
>> >So a swiotlb_force_bounce will not use swiotlb bouncing if
>> >DMA_ATTR_CC_SHARED is set ? 
>> 
>> Correct. Bouncing does not make sense in this case, as shared memory is
>> already being mapped.
>
> It is a little bit mangled, there are many reasons force_swiotlb can
> be set, but we loose them as it flows through - swiotlb_init()
> just has a simple SWIOTLB_FORCE
>
> Ideally DMA_ATTR_CC_SHARED would skip swiotlb only if it is being
> selected for CC reasons. For instance if you have the swiotlb force
> command line parameter I would still expect it bounce shared memory.
>
> Arguably I think this arch flow is misdesigned, the
> is_swiotlb_force_bounce() should not be used for CC. dma_capable() is
> the correct API to check if the device can DMA to the presented
> address, and it will trigger swiotlb_map() just the same without
> creating this gap.
>
> Jason

Something like this?

static inline dma_addr_t dma_direct_map_phys(struct device *dev,
		phys_addr_t phys, size_t size, enum dma_data_direction dir,
		unsigned long attrs, bool flush)
{
	dma_addr_t dma_addr;

	if (is_swiotlb_force_bounce(dev)) {
		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
			return DMA_MAPPING_ERROR;

		return swiotlb_map(dev, phys, size, dir, attrs);
	}

	if (attrs & DMA_ATTR_MMIO) {
		dma_addr = phys;
		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
			goto err_overflow;
		goto dma_mapped;
	} else if (attrs & DMA_ATTR_CC_SHARED) {
		dma_addr = phys_to_dma_unencrypted(dev, phys);
	} else {
		dma_addr = phys_to_dma_encrypted(dev, phys);
	}

	if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
	    dma_kmalloc_needs_bounce(dev, size, dir)) {
		if (is_swiotlb_active(dev) &&
		    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
			return swiotlb_map(dev, phys, size, dir, attrs);
		goto err_overflow;
	}

dma_mapped:
	if (!dev_is_dma_coherent(dev) &&
	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
		arch_sync_dma_for_device(phys, size, dir);
		if (flush)
			arch_sync_dma_flush();
	}
	return dma_addr;

and dma_capable() now does
static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size,
		bool is_ram, unsigned long attrs)
{
....

	/*
	 * if phys addr attribute is encrypted but the
	 * device is forcing an encrypted dma addr
	 */
	if (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev))
		return false;
...

}


-aneesh
