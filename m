Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E5BCD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 15:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0157F10E2D8;
	Thu, 21 May 2026 15:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bEhNVt1G";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1105D10E2D8
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 15:35:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BBA8601F3;
 Thu, 21 May 2026 15:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBDC1F00A3B;
 Thu, 21 May 2026 15:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779377751;
 bh=5PUD/3vmVzMg81CR18Fk250apIi9RXyWW+eG5eaM6s8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=bEhNVt1GsNTReAabbrbOrGd7094+P/Sa5116B7JLNnREdhOzMGX2Gz8rO+jhs2hjr
 zSsrlqBKOoM5flIzMvqZnYd7J9cRg2EDO74CdatpbE2YJ1B0uNV1ztRl6S0G+N0vsU
 yB1er4WO6TtsqsXhRMk1/TlGmKa+L1/FsD2GOdqw+oQm9GLeFT3Bj3KKSnDOBHF4B/
 U+yyOFENz4I54n62JgPRSNPUjWlQ+ltOi5Wo2jvwQbED3vUWkLuR6lXfvEDJvLC4tN
 p2nKWsvyoT705a20eObfWQInTblFf6CCtvyGPA+dGyxm9WCeiQxTawQdn76dB9GHg8
 A/2+Gwm/0LbAQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, sumit.semwal@linaro.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
 jstultz@google.com, tjmercier@google.com,
 christian.koenig@amd.com, m.szyprowski@samsung.com,
 robin.murphy@arm.com, leon@kernel.org, sean.anderson@linux.dev,
 ptesarik@suse.com, catalin.marinas@arm.com,
 suzuki.poulose@arm.com, steven.price@arm.com,
 thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev
Subject: Re: [PATCH v5 1/2] dma-mapping: introduce DMA_ATTR_CC_SHARED for
 shared memory
In-Reply-To: <20260426130531.GF804026@ziepe.ca>
References: <20260325192352.437608-1-jiri@resnulli.us>
 <20260325192352.437608-2-jiri@resnulli.us> <yq5atst6ywbl.fsf@kernel.org>
 <4qdizkkoeke3cvkcf35upa7p7ick6s654eqlrizmi7ozkw5eze@tnpk2e34xgwl>
 <yq5awly0d504.fsf@kernel.org>
 <tteiecxfqy4k24wnzvp6ocxnuopyhmqtne2xwh5htwldlbzjnp@o6cbzdlurxld>
 <20260421121004.GA3611611@ziepe.ca> <yq5aik9jcpzm.fsf@kernel.org>
 <20260424225514.GE804026@ziepe.ca> <20260426130531.GF804026@ziepe.ca>
Date: Thu, 21 May 2026 21:05:39 +0530
Message-ID: <yq5azf1s6aic.fsf@kernel.org>
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

>> > static inline dma_addr_t dma_direct_map_phys(struct device *dev,
>> > 		phys_addr_t phys, size_t size, enum dma_data_direction dir,
>> > 		unsigned long attrs, bool flush)
>> > {
>> > 	dma_addr_t dma_addr;
>> > 
>> > 	if (is_swiotlb_force_bounce(dev)) {
>> > 		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
>> > 			return DMA_MAPPING_ERROR;
>> > 
>> > 		return swiotlb_map(dev, phys, size, dir, attrs);
>> > 	}
>> > 
>> > 	if (attrs & DMA_ATTR_MMIO) {
>> > 		dma_addr = phys;
>> > 		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
>> > 			goto err_overflow;
>> > 		goto dma_mapped;
>> 
>> I suspect P2P is probably broken on CC because this doesn't make
>> sense..
>
> Actually, I suppose it is fully broken because it will jump to swiotlb
> and then should fail.
>
>> This should flow into the
>> phys_to_dma_unencrypted/phys_to_dma_encrypted block as well AFAICT, it
>> shouldn't just assign phys. Assigning phys to dma on a CC system is
>> always wrong, right?
>> 
>> It is is more like
>> 
>>         /* To be updated, callers should specify MMIO | CC_SHARED instead of
>> 	   * implying it. */
>>         if (attrs & DMA_ATTR_MMIO)
>> 	   attrs |= DMA_ATTR_CC_SHARED;
>
> So no need for this if, we can go directly to marking the MMIO callers
> with DMA_ATTR_CC_SHARED once this is fixed for mmio:
>
>>         if (attrs & DMA_ATTR_CC_SHARED) {
>>  		dma_addr = phys_to_dma_unencrypted(dev, phys);
>>  	} else {
>>  		dma_addr = phys_to_dma_encrypted(dev, phys);
>>  	}
>
> Jasn

I am wondering whether this is better

static inline dma_addr_t dma_direct_map_phys(struct device *dev,
		phys_addr_t phys, size_t size, enum dma_data_direction dir,
		unsigned long attrs, bool flush)
{
	dma_addr_t dma_addr;

	/*
	 * For a device requiring unencrypted DMA, MMIO memory is treated
	 * as shared.
	 */
	if (force_dma_unencrypted(dev) && (attrs & DMA_ATTR_MMIO))
		attrs |= DMA_ATTR_CC_SHARED;

.....

	if (attrs & DMA_ATTR_CC_SHARED)
		dma_addr = phys_to_dma_unencrypted(dev, phys);
	else
		dma_addr = phys_to_dma_encrypted(dev, phys);

	if (attrs & DMA_ATTR_MMIO) {
		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
			goto err_overflow;
		goto dma_mapped;
	}


....
-aneesh
