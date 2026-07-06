Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F84C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F7B10E99A;
	Mon,  6 Jul 2026 13:08:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="M4rTjdB2";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id CE2B710E9A0;
 Mon,  6 Jul 2026 13:08:20 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F82628C7;
 Mon,  6 Jul 2026 06:08:16 -0700 (PDT)
Received: from [10.57.82.104] (unknown [10.57.82.104])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E88F43F7B4;
 Mon,  6 Jul 2026 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1783343300; bh=0aA4qLPP4be61ChbVSTr6j8z/Dm/HGd90mPQPS4LDmU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=M4rTjdB20bQ2CIIm6sF9czHLIiKzlI2RImQaKwc20odxzVCQybIaWr3rwfjrKShR5
 KD1O5KVG+VNwczLFB/cfjDMk335CqXNUd1rKGJjEVFahgMi5MA35fcXRGjNdG6lza+
 SNjeWVEgCVnwJxppYQ/IW6dg3IkcQENcwHFbtb7Q=
Message-ID: <a381d265-e7a4-4fe7-9421-3553706d41c1@arm.com>
Date: Mon, 6 Jul 2026 14:08:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drivers/iommu: Catch scatterlist length overflows
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Krzysztof Karas <krzysztof.karas@intel.com>,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Andi Shyti <andi.shyti@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, =?UTF-8?Q?Micha=C5=82_Grzelak?=
 <michal.grzelak@intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>,
 Krzysztof Niemiec <krzysztof.niemiec@intel.com>
References: <20260701104437.236979-1-krzysztof.karas@intel.com>
 <20260701104437.236979-4-krzysztof.karas@intel.com>
 <20260703162236.GX7525@ziepe.ca>
 <90558ba3-44e6-4d5e-9c72-ed8817d372be@arm.com>
 <20260703203502.GC1978949@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260703203502.GC1978949@ziepe.ca>
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

On 2026-07-03 9:35 pm, Jason Gunthorpe wrote:
> On Fri, Jul 03, 2026 at 07:58:32PM +0100, Robin Murphy wrote:
>> On 03/07/2026 5:22 pm, Jason Gunthorpe wrote:
>>> On Wed, Jul 01, 2026 at 10:44:37AM +0000, Krzysztof Karas wrote:
>>>> It is possible, when a very large mapping uses a single
>>>> scatterlist, that padding overflows scatterlist's length field.
>>>> This results in:
>>>>    1) silently wrapping the value
>>>>    2) smaller than desired mappings produced by iommu_map_sg
>>>>    3) leaving mapped bytes in memory (no iommu_unmap)
>>>>
>>>> Address this issue by adding overflow detection for previous
>>>> scatterlist length field.
>>>
>>> Urk, this is unfortunate, it means we cannot map certain kinds of
>>> scatterlists? Meaning there is a condition that makes a scatterlist
>>> ill formed?
>>>
>>> This seems like something that needs to be more clearly documented and
>>> we need to ensure at least the common scatterlist builders don't hit
>>> it..
>>
>> Well, it's taken 10 years to be caught by a test which seemingly expects the
>> mapping of a single absurdly giant scatterlist to fail anyway,
> 
> If your server has 0.5TB of ram a 4G IO isn't actually that large.
> Randomly getting a few contiguous 1G hugetlbfs pages is not even that
> unlikely. Something like FSDAX has a very high chance of getting high
> contiguity pages in files.

Sure, but how many servers had 0.5TB of RAM in 2015? And how many of 
those were running the arm64 DMA mapping code? As I said, both this 
merging logic and the iommu_map_sg() interface itself were essentially 
written to support media buffers on Android phones which didn't even 
have 4GB of RAM in total. Yes, things have moved on by now, but 
correspondingly it has also been decided that the ~30-year-old 
scatterlist design also doesn't scale to modern use-cases anyway, and is 
being replaced, so limitations of a "legacy" API that don't have any 
meaningful impact to its existing users are hardly something to panic 
about. If DRM does want to be able to *reliably* map massive amounts of 
RAM then it can adopt the new IOMMU API, for this and all the other 
reasons that that new API was promised to be "better".

> So I wouldn't be quite so dismissive that this is not something a real
> user can hit.

I'm not being dismissive - clearly it can be hit. My point is that 
anyone who *does* hit it can only expect it to fail (as indeed this 
particular IGT test seems to), because it has never worked. You cannot 
encode a 4GB scatterlist segment, because it overflows UINT_MAX. And if 
you did try to bodge it and pass a UINT_MAX length segment to 
iommu_map_sg() then that will also fail because it's not aligned to an 
IOMMU page size. It's purely the matter of *how* exactly it fails which 
could do with fixing.

>> here, but I suspect this is likely just regular iova_granule rounding
>> overflowing when the segment boundary is the maximum 4GB, since the largest
>> representable segment length is 4GB - 1.
> 
> It looks like the iommu_dma_map_sg() algorithm only works reliably if
> the scatterlist entry size is less than UINT_MAX/2, otherwise it can
> risk overflowing when it pads.

AFAICS, the overflow can only happen with a 4GB boundary mask, and for 
two conditions:

- rounding up the current segment, when s->length + s->offset > 4GB - 
iova_granule (but still <= 4GB otherwise it's bogus anyway)
- padding the previous segment in the case where the current segment 
would otherwise cross the next boundary, when prev->offset = 0 and 
prev->length + s->length >= 4GB

So yes, limiting any individual segment to <=2GB would end up avoiding 
both those conditions, but it would also impact plenty of cases that 
*do* currently work fine, e.g. 1GB+3GB+3GB. The limitation is really 
that you can't have two consecutive segments where the first starts 
exactly on a 4GB boundary and the sum of both their sizes >=4GB.

> API wise I expect any arbitary input to sg_alloc_table_from_pages() to
> result in a scatterlist that iommu_dma_map_sg() will map. This
> patch highlights there are cornere cases where that isn't true, it
> should be fixed..

Technically sg_alloc_table_from_pages() carries no such assumption, only 
sg_alloc_table_from_pages_segment() (or __sg_alloc_table_from_pages()) 
with the correct dma_seg_boundary value for the given device. But even 
then in the worst case, they should still end up splitting segments at 
4GB-PAGE_SIZE due to the fundamental int limitation, and so only be at 
risk of putting two such segments back-to-back.

> I agree we shouldn't overcomplicate iommu_dma_map_sg(), so the
> simplest fix is to introduce a SG_MAX_LENGTH set to UINT_MAX/2,
> justified by the logic in iommu_dma_map_sg(). Fixup the core sg_alloc
> code to respect that. WARN_ON in iommu_dma_map_sg() if a malformed
> scatterlist entry is presented. Add a WARN_ON under DMA debugging
> kconfig as well for the physical path.

Again, it's not "malformed", it's just an edge case of certain 
otherwise-valid scatterlist layouts that are not supported in this one 
DMA API implementation. Nothing in the DMA API ever guarantees that any 
particular mapping must succeed. Furthermore I don't see that anyone's 
asking for this to actually be supported, just to fail cleanly and 
correctly without inadvertently corrupting state.

Thanks,
Robin.
