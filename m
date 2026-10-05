Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BC2CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2117A10EDD3;
	Mon,  5 Oct 2026 15:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="U0B9UnoE";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E0D9110EDD2
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 15:31:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08B0D152B;
 Mon,  5 Oct 2026 08:31:11 -0700 (PDT)
Received: from [10.57.78.53] (unknown [10.57.78.53])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C5C03F66F;
 Mon,  5 Oct 2026 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791214274; bh=1KxWukN91rQATxKeKW/KQzlxtbJENoTAECtlYaMOGgQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=U0B9UnoENLn+hROcRubshH9HnOleoucY2g+JOxuIsfh4QHQERB8rxdfFQWAgH6DJ5
 JhSG7Sr0nv1LKrI0ChCVnC2YhCT2vg6cmmmIpIHX+8jWfp3l52wawSw0dIx6Gp8KNS
 NRXRSyR3pZ3HmJUd8mCNGmHmfQz1hSEHMRNf/pdk=
Message-ID: <5b0254d0-1be2-4dad-b6ce-368d341dd319@arm.com>
Date: Mon, 5 Oct 2026 16:31:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] drm/panthor: Actually check huge-page mapping on
 sparse regions
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Akash Goel <akash.goel@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260924-panthor-fix-partial-unmap-v2-0-59a68a1f9e14@collabora.com>
 <20260924-panthor-fix-partial-unmap-v2-4-59a68a1f9e14@collabora.com>
 <678b9346-a53d-49bd-9c90-fa63e6c81169@arm.com>
 <20261005135312.43d132cf@fedora-61.home>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261005135312.43d132cf@fedora-61.home>
Content-Type: text/plain; charset=UTF-8
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

On 05/10/2026 12:53, Boris Brezillon wrote:
> On Mon, 5 Oct 2026 12:03:26 +0100
> Steven Price <steven.price@arm.com> wrote:
> 
>> On 24/09/2026 12:04, Boris Brezillon wrote:
>>> With the recent changes to iova_mapped_as_huge_page(), the check for
>>> huge-page mapping of sparse BOs is actually simple:
>>>
>>> - for a sparse mapping, we know the BO offset any VA in this regions is
>>>   va & (SZ_2M - 1)
>>> - the VA we're searching the BO offset for is the 2M-aligned
>>>   aligned_va value
>>>
>>> This guarantees that the BO offset to check is always zero in that case.
>>>
>>> This is simple enough to let the code check if page 0 is a huge page
>>> and save the unmap+map dance when the dummy BO is not backed by a
>>> a huge page. So let's do that and kill the comment that says it's too
>>> complicated.
>>>
>>> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
>>> Reviewed-by: Akash Goel <akash.goel@arm.com>
>>> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>  
>>
>> In itself I can't see anything wrong with this change, so:
>>
>> Reviewed-by: Steven Price <steven.price@arm.com>
>>
>> However...
>>
>>> ---
>>>  drivers/gpu/drm/panthor/panthor_mmu.c | 15 ++++++++-------
>>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
>>> index d2897099763e..01564d250adf 100644
>>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
>>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
>>> @@ -2337,18 +2337,18 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
>>>  
>>>  		return false;
>>>  	} else {
>>> -		const struct page *pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
>>>  		struct panthor_vma *vma = container_of(mapping, struct panthor_vma, base);
>>>  		bool is_sparse = vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
>>> +		const struct page *pg;
>>>  
>>> -		/* If the unmapped VMA stands for a sparse mapping, always
>>> -		 * assume the backing storage is a THP, since the overhead of
>>> -		 * unmapping 2MiB worth of 4KiB pages and remapping some of
>>> -		 * them is offset by the logic of working out whether it's
>>> -		 * the opposite case right below.
>>> +		/* BO offset on a sparse mapping is chosen so that 2M-aligned
>>> +		 * VAs point to the start of the BO. Since aligned_va (the
>>> +		 * address we check huge-page against) is 2M-aligned, the BO
>>> +		 * offset is guaranteed to be zero.
>>> +		 * Check panthor_fix_sparse_map_offset() for more details.
>>>  		 */
>>>  		if (is_sparse)
>>> -			return true;
>>> +			bo_offset = 0;
>>>  
>>>  		/* In case of shmem backing, we know we can only have a huge
>>>  		 * mapping if the bo_offset is 2M aligned, meaning we can skip
>>> @@ -2357,6 +2357,7 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
>>>  		if (!IS_ALIGNED(bo_offset, SZ_2M))
>>>  			return false;
>>>  
>>> +		pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
>>>  		return folio_size(page_folio(pg)) >= SZ_2M;  
>>
>> ... this seems like it could be problematic. On the mapping side we use
>> the scatter list to decide whether the region is huge page mapped or
>> not. The scatter list code can merge segments that are contiguous (see
>> pages_are_mergeable()), so if we have a region which has small folios we
>> fail this check even though the pages might have been mapped as huge pages.
>>
>> This is a problem on the non-sparse path as well (hence not really
>> related to this patch). I'm not really sure how to test this though - I
>> may well have overlooked something here.
> 
> So, this is based on the assumption that shmem backing is allocated
> with the buddy allocator, and because of how this allocator splits
> bigger order blocks to service smaller allocations, it's my
> understanding that two consecutive folios of the same size/order can't
> be physically contiguous.

Yes, you'd expect the buddy allocator to combine the folios back into a
larger one if they were contiguous. I guess we should be safe, at least
for now. I still feel it's unnecessarily fragile and complex trying to
work out whether we've mapped as a huge page or not. But I don't
actually have a better solution at the moment, and this series is at
least improving things. I'll put it on my todo list to look at later.

Thanks,
Steve

