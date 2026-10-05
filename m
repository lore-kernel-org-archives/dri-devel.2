Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA39CA5FF0
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 11:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD5F10E264;
	Mon,  5 Oct 2026 11:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="lNZ6aA3S";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AD9E10E264
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 11:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791201203;
 bh=1cvRFs3e3GOgEv20ZHhlqN3hVJ2EwB0TmbkyrTnmpbY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lNZ6aA3SkHmVAFvrtWo7caeNZEV9FCAt43KunoyBwuP7UPLdDLDQFrLumCxxG5kgv
 GW5QLGgL8AnNEv6MPWcYaOkcWmmYAAvUja9oip5jELj5Kvj1pG1cY9kxqvUlRnEHmL
 6CU6+mLl3c/Z3qyp/wH8q6V2WttayIRfCRgUD8dWp4vaEokGHtMh3i4Tw6y99qN8Aa
 NEUsJ9hEhNeXcOF1x0PjSeJ/Mg0N8JRtyM6tZphJMynOKxOI1zWJKf8XWSXYyQRIVZ
 qoNbF9ojBADZ8bTgLZXzv2hVwBT7h0v6UBpfbv9b8PFIDAy9KiIAAo6verCGED/+Qe
 VhnJjgZg5FyhQ==
Received: from fedora-61.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3761E17E006F;
 Mon, 05 Oct 2026 13:53:23 +0200 (CEST)
Date: Mon, 5 Oct 2026 13:53:12 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>, =?UTF-8?B?QWRyacOhbg==?= Larumbe
 <adrian.larumbe@collabora.com>, Akash Goel <akash.goel@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] drm/panthor: Actually check huge-page mapping on
 sparse regions
Message-ID: <20261005135312.43d132cf@fedora-61.home>
In-Reply-To: <678b9346-a53d-49bd-9c90-fa63e6c81169@arm.com>
References: <20260924-panthor-fix-partial-unmap-v2-0-59a68a1f9e14@collabora.com>
 <20260924-panthor-fix-partial-unmap-v2-4-59a68a1f9e14@collabora.com>
 <678b9346-a53d-49bd-9c90-fa63e6c81169@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Mon, 5 Oct 2026 12:03:26 +0100
Steven Price <steven.price@arm.com> wrote:

> On 24/09/2026 12:04, Boris Brezillon wrote:
> > With the recent changes to iova_mapped_as_huge_page(), the check for
> > huge-page mapping of sparse BOs is actually simple:
> > 
> > - for a sparse mapping, we know the BO offset any VA in this regions is
> >   va & (SZ_2M - 1)
> > - the VA we're searching the BO offset for is the 2M-aligned
> >   aligned_va value
> > 
> > This guarantees that the BO offset to check is always zero in that case.
> > 
> > This is simple enough to let the code check if page 0 is a huge page
> > and save the unmap+map dance when the dummy BO is not backed by a
> > a huge page. So let's do that and kill the comment that says it's too
> > complicated.
> > 
> > Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> > Reviewed-by: Akash Goel <akash.goel@arm.com>
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>  
> 
> In itself I can't see anything wrong with this change, so:
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> However...
> 
> > ---
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> > index d2897099763e..01564d250adf 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -2337,18 +2337,18 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
> >  
> >  		return false;
> >  	} else {
> > -		const struct page *pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
> >  		struct panthor_vma *vma = container_of(mapping, struct panthor_vma, base);
> >  		bool is_sparse = vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
> > +		const struct page *pg;
> >  
> > -		/* If the unmapped VMA stands for a sparse mapping, always
> > -		 * assume the backing storage is a THP, since the overhead of
> > -		 * unmapping 2MiB worth of 4KiB pages and remapping some of
> > -		 * them is offset by the logic of working out whether it's
> > -		 * the opposite case right below.
> > +		/* BO offset on a sparse mapping is chosen so that 2M-aligned
> > +		 * VAs point to the start of the BO. Since aligned_va (the
> > +		 * address we check huge-page against) is 2M-aligned, the BO
> > +		 * offset is guaranteed to be zero.
> > +		 * Check panthor_fix_sparse_map_offset() for more details.
> >  		 */
> >  		if (is_sparse)
> > -			return true;
> > +			bo_offset = 0;
> >  
> >  		/* In case of shmem backing, we know we can only have a huge
> >  		 * mapping if the bo_offset is 2M aligned, meaning we can skip
> > @@ -2357,6 +2357,7 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
> >  		if (!IS_ALIGNED(bo_offset, SZ_2M))
> >  			return false;
> >  
> > +		pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
> >  		return folio_size(page_folio(pg)) >= SZ_2M;  
> 
> ... this seems like it could be problematic. On the mapping side we use
> the scatter list to decide whether the region is huge page mapped or
> not. The scatter list code can merge segments that are contiguous (see
> pages_are_mergeable()), so if we have a region which has small folios we
> fail this check even though the pages might have been mapped as huge pages.
> 
> This is a problem on the non-sparse path as well (hence not really
> related to this patch). I'm not really sure how to test this though - I
> may well have overlooked something here.

So, this is based on the assumption that shmem backing is allocated
with the buddy allocator, and because of how this allocator splits
bigger order blocks to service smaller allocations, it's my
understanding that two consecutive folios of the same size/order can't
be physically contiguous.
