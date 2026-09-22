Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C5A0C98302
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 16:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAE9210E519;
	Tue, 22 Sep 2026 16:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="rwwQ/fHH";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 38E0310E519
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 16:38:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3C351576
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 09:38:04 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 4E9213F632
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790095088; bh=fEo6qnAyn5f+Ayh0CWgFVBjDPIXFFi+YOB8rKVgK/40=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rwwQ/fHHQeY4Jl2Vwf1GFF7QhbpLyZq6GH2Kw0grerpLAJ+35HvEGpJRq35uhJ00h
 dC9o/M2sTIvF0rKQ/UN9xxJYfsFhR5iIBoH5DjzOSvkghw3uUkkPiXuz9T77aITp/d
 2PctKnHsnfMhMKTvDVFpMq7YelxzhjzfpGXYdRJY=
Date: Tue, 22 Sep 2026 17:37:58 +0100
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
Subject: Re: [PATCH 1/4] drm/panthor: Avoid false positives in
 iova_mapped_as_huge_page()
Message-ID: <arKu5lbm-rvyDlNs@e142607>
References: <20260917-panthor-fix-partial-unmap-v1-0-c7008f15fea3@collabora.com>
 <20260917-panthor-fix-partial-unmap-v1-1-c7008f15fea3@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260917-panthor-fix-partial-unmap-v1-1-c7008f15fea3@collabora.com>
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

On Thu, Sep 17, 2026 at 02:33:43PM +0200, Boris Brezillon wrote:
> The check on the folio size is actually moot if the BO offset matching
> the VA we're checking huge-mapping for is not 2M aligned as well.
> This means that we are sometimes returning true when we shouldn't, which
> forces an extra unmap+map to deal with block-mapping splits. It's not
> a functional bug per-se, because the unmap+map sequence will restore
> things in the state we expect them to be, but it's better to properly
> optimize those cases.
> 
> Note that we now align the VA on 2M address below it otherwise we can't
> check the bo_offset alignment (both physical and virtual address need
> to be aligned, in addition to the physically contiguous size being 2M,
> which the folio size check ensures).
> 
> These changes force us to pass the drm_gpuva that's being unmapped
> instead of the new mappings that will be created to cover the left/right
> sections we remap. This changes makes the logic a lot easier to reason
> about, because it doesn't make sense to how things were mapped by
> passing the new mappings that are not yet in place.
> 
> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 9f63a048df61..b0a7033480e6 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2295,15 +2295,29 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
>  }
>  
>  static bool
> -iova_mapped_as_huge_page(struct drm_gpuva_op_map *op, u64 addr)
> +iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
>  {
> -	struct panthor_gem_object *bo = to_panthor_bo(op->gem.obj);
> +	struct panthor_gem_object *bo = to_panthor_bo(mapping->gem.obj);
> +	u64 aligned_va = ALIGN_DOWN(va, SZ_2M);
>  	const struct page *pg;
>  	pgoff_t bo_offset;
>  
> -	bo_offset = addr - op->va.addr + op->gem.offset;
> +	/* If the 2M-aligned VA is outside the mapping being tested, we know
> +	 * it's not a huge map.
> +	 */
> +	if (aligned_va < mapping->va.addr)
> +		return false;
> +
> +	bo_offset = aligned_va - mapping->va.addr + mapping->gem.offset;
>  	pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
>  
> +	/* In case of shmem backing, we know we can only have a huge mapping
> +	 * if the bo_offset is 2M aligned, meaning we can skip the folio size
> +	 * check if it's not the case.
> +	 */
> +	if (!IS_ALIGNED(bo_offset, SZ_2M))
> +		return false;
> +
>  	return folio_size(page_folio(pg)) >= SZ_2M;
>  }
>  
> @@ -2328,7 +2342,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
>  	 */
>  	if (op->prev && aligned_unmap_start < *unmap_start &&
>  	    op->prev->va.addr <= aligned_unmap_start &&
> -	    (is_sparse || iova_mapped_as_huge_page(op->prev, *unmap_start))) {
> +	    (is_sparse || iova_mapped_as_huge_page(op->unmap->va, *unmap_start))) {
>  		*unmap_range += *unmap_start - aligned_unmap_start;
>  		*unmap_start = aligned_unmap_start;
>  	}
> @@ -2338,7 +2352,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
>  	 */
>  	if (op->next && aligned_unmap_end > unmap_end &&
>  	    op->next->va.addr + op->next->va.range >= aligned_unmap_end &&
> -	    (is_sparse || iova_mapped_as_huge_page(op->next, unmap_end - 1))) {
> +	    (is_sparse || iova_mapped_as_huge_page(op->unmap->va, unmap_end - 1))) {
>  		*unmap_range += aligned_unmap_end - unmap_end;
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
