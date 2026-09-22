Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0777AC98307
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:43:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4425010EDAE;
	Tue, 22 Sep 2026 16:43:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="FopzZ7Lp";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id A26F310EDAE
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 16:43:36 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20CD91576
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 09:43:32 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 6F6363F632
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790095415; bh=oZodBLOvhWZnhGBhFyedqhlpKfrMwQq9wmTh3Vz6cE4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FopzZ7Lp8FS5RDQvroi86CgHxxf7SdP1rGZkHd5shtkfRoWmLs5l5uTLERmqB8vrL
 igWV3pc2rkk+PXmpbMkREKC+Iw4kh9w9arnOOAX1SuWr+RG+y71QWEykZFrGdOq3MF
 Q13BV8t9Mepy/RsZf7XGSbCKlYxz7QyDzTNIhtuY=
Date: Tue, 22 Sep 2026 17:43:16 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>,
 Akash Goel <akash.goel@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] drm/panthor: Actually check huge-page mapping on
 sparse regions
Message-ID: <arKwJOFgHRk6mgjt@e142607>
References: <20260917-panthor-fix-partial-unmap-v1-0-c7008f15fea3@collabora.com>
 <20260917-panthor-fix-partial-unmap-v1-4-c7008f15fea3@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917-panthor-fix-partial-unmap-v1-4-c7008f15fea3@collabora.com>
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

On Thu, Sep 17, 2026 at 02:33:46PM +0200, Boris Brezillon wrote:
> With the recent changes to iova_mapped_as_huge_page(), the check for
> huge-page mapping of sparse BOs is actually simple:
> 
> - for a sparse mapping, we know the BO offset any VA in this regions is
>   va & (SZ_2M - 1)
> - the VA we're searching the BO offset for is the 2M-aligned
>   aligned_va value
> 
> This guarantees that the BO offset to check is always zero in that case.
> 
> This is simple enough to let the code check if page 0 is a huge page
> and save the unmap+map dance when the dummy BO is not backed by a
> a huge page. So let's do that and kill the comment that says it's too
> complicated.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index d2897099763e..01564d250adf 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2337,18 +2337,18 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
>  
>  		return false;
>  	} else {
> -		const struct page *pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
>  		struct panthor_vma *vma = container_of(mapping, struct panthor_vma, base);
>  		bool is_sparse = vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
> +		const struct page *pg;
>  
> -		/* If the unmapped VMA stands for a sparse mapping, always
> -		 * assume the backing storage is a THP, since the overhead of
> -		 * unmapping 2MiB worth of 4KiB pages and remapping some of
> -		 * them is offset by the logic of working out whether it's
> -		 * the opposite case right below.
> +		/* BO offset on a sparse mapping is chosen so that 2M-aligned
> +		 * VAs point to the start of the BO. Since aligned_va (the
> +		 * address we check huge-page against) is 2M-aligned, the BO
> +		 * offset is guaranteed to be zero.
> +		 * Check panthor_fix_sparse_map_offset() for more details.
>  		 */
>  		if (is_sparse)
> -			return true;
> +			bo_offset = 0;
>  
>  		/* In case of shmem backing, we know we can only have a huge
>  		 * mapping if the bo_offset is 2M aligned, meaning we can skip
> @@ -2357,6 +2357,7 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
>  		if (!IS_ALIGNED(bo_offset, SZ_2M))
>  			return false;
>  
> +		pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
>  		return folio_size(page_folio(pg)) >= SZ_2M;
>  	}
>  }
> 
> -- 
> 2.55.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
