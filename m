Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF846CDB46F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:55:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A05410EABC;
	Tue, 23 Jun 2026 12:55:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="EAp9u9xN";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D72910EABC
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782219355;
 bh=9EoUhOdA7j+seAfhvUlRUZqmYTKDM+5A8VpX20MrCZw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EAp9u9xNWNUYg2L/9Y27jQ9W3T+1nlcti638qJVYABOZGtB6Bjt/CIa6qlGeIW7oL
 NZ09HvdWw8AzPBCu3/YoHKFXzUyJyKCUMGbUkVs0IBO/L8DmJhwxf8IDUN28dEZslS
 XNW8sw2b4MoNzDRghuuQA1ytSk3EfxlQp/jraO891WXvmOP736XlXx9K+ojCepBo3e
 lh4W0fsYvOK5we9prjcyw9l+G3sDkudLlWUa1f9DHZpMlRYR/rJ8xsNZyBqynRqfl4
 K6ydaKyKpR0i0MONiM/Xic787rbZnupr/n03bjRjBTnmPML83IwZ8jHwe8ywr6s7IU
 GMqZh9JR04zOg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 58A7F17E091C;
 Tue, 23 Jun 2026 14:55:55 +0200 (CEST)
Date: Tue, 23 Jun 2026 14:55:50 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>, =?UTF-8?B?QWRyacOhbg==?= Larumbe
 <adrian.larumbe@collabora.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH] drm/panthor: Fix NPD issue on partial unmap of an
 evicted BO
Message-ID: <20260623145550.71485c03@fedora-2.home>
In-Reply-To: <b85679e3-5ca2-4d36-8675-2b968d97cb5b@arm.com>
References: <20260623092413.2710066-1-akash.goel@arm.com>
 <20260623115332.7e89f56b@fedora-2.home>
 <9f9b372d-b465-4fd4-ab7a-9c399e35b4ed@arm.com>
 <20260623140942.5055457c@fedora-2.home>
 <b85679e3-5ca2-4d36-8675-2b968d97cb5b@arm.com>
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

+Adrian

On Tue, 23 Jun 2026 13:41:12 +0100
Akash Goel <akash.goel@arm.com> wrote:

> On 6/23/26 13:09, Boris Brezillon wrote:
> > On Tue, 23 Jun 2026 12:17:51 +0100
> > Akash Goel <akash.goel@arm.com> wrote:
> >   
> >> Hi Boris
> >>
> >> On 6/23/26 10:53, Boris Brezillon wrote:  
> >>> On Tue, 23 Jun 2026 10:24:13 +0100
> >>> Akash Goel <akash.goel@arm.com> wrote:
> >>>      
> >>>> This commit fixes the NULL pointer dereference issue that would have
> >>>> happened on the split of GPU mapping due to partial unmap of an evicted
> >>>> BO. There is a logic to handle the partial unmap of huge pages when the
> >>>> GPU mapping is split. That logic was not being completely skipped for
> >>>> the VMA of an evicted BO and that resulted in a NPD possibility for the
> >>>> 'bo->backing.pages' pointer, which is set to NULL when pages of a
> >>>> BO are released on eviction.
> >>>>     
> >>  
> >>>>
> >>>> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
> >>>> Signed-off-by: Akash Goel <akash.goel@arm.com>
> >>>> ---
> >>>>    drivers/gpu/drm/panthor/panthor_mmu.c | 26 +++++++++++++-------------
> >>>>    1 file changed, 13 insertions(+), 13 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> >>>> index 31cc57029c12..285e7b9bc100 100644
> >>>> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> >>>> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> >>>> @@ -2358,20 +2358,20 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
> >>>>    	 */
> >>>>    	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
> >>>>    
> >>>> -	/*
> >>>> -	 * ARM IOMMU page table management code disallows partial unmaps of huge pages,
> >>>> -	 * so when a partial unmap is requested, we must first unmap the entire huge
> >>>> -	 * page and then remap the difference between the huge page minus the requested
> >>>> -	 * unmap region. Calculating the right start address and range for the expanded
> >>>> -	 * unmap operation is the responsibility of the following function.
> >>>> -	 */
> >>>> -	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
> >>>> -
> >>>> -	/* If the range changed, we might have to lock a wider region to guarantee
> >>>> -	 * atomicity. panthor_vm_lock_region() bails out early if the new region
> >>>> -	 * is already part of the locked region, so no need to do this check here.
> >>>> -	 */
> >>>>    	if (!unmap_vma->evicted) {
> >>>> +		/*
> >>>> +		* ARM IOMMU page table management code disallows partial unmaps of huge pages,
> >>>> +		* so when a partial unmap is requested, we must first unmap the entire huge
> >>>> +		* page and then remap the difference between the huge page minus the requested
> >>>> +		* unmap region. Calculating the right start address and range for the expanded
> >>>> +		* unmap operation is the responsibility of the following function.
> >>>> +		*/
> >>>> +		unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
> >>>> +
> >>>> +		/* If the range changed, we might have to lock a wider region to guarantee
> >>>> +		 * atomicity. panthor_vm_lock_region() bails out early if the new region
> >>>> +		 * is already part of the locked region, so no need to do this check here.
> >>>> +		 */
> >>>>    		panthor_vm_lock_region(vm, unmap_start, unmap_range);
> >>>>    		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
> >>>>    	}  
> >>>
> >>>
> >>> I think we want something like that instead, so we can keep the
> >>> 2M alignment for sparse mappings which go recently introduced.
> >>>      
> >>
> >> Thanks for the suggestion. But sorry I didn't get it.
> >>
> >> I see that the patching of 'op->remap.next->gem.offset' would still be
> >> done with my change.
> >>
> >> 	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
> >>
> >> 	if (!unmap_vma->evicted) {
> >> 		unmap_hugepage_align(&op->remap, &unmap_start,
> >>
> >> IIUC, the 2M alignment is done to avoid a potential partial unmap of 2M
> >> page. But if the VMA is in evicted state then already the unmap would
> >> have happened for the whole virtual range covered by the VMA.  
> > 
> > Nah, you're correct, the patching of the drm_gpuva is independent of the
> > adjusted unmap range, so we should be good even if we don't adjust this
> > range for evicted sparse mappings. Sorry for the noise.
> >   
> 
> No worries. Thanks for confirming.
> 
> Since I had a closer look at the code, sorry I have another doubt.
> 
> Do we really need the call to 'panthor_fix_sparse_map_offset()' in the 
> following code block ?. The 'op->remap.next->gem.offset' would already 
> have been patched before.

That's probably not needed, indeed. Adrian to confirm.

> 
> 
> 	if (op->remap.next) {
> 		u64 addr = op->remap.next->va.addr;
> 		u64 size = unmap_start + unmap_range - op->remap.next->va.addr;
> 
> 		if (!unmap_vma->evicted && size > 0) {
> 			struct drm_gpuva_op_map map_op = {
> 				.va.addr = addr,
> 				.va.range = size,
> 				.gem.obj = op->remap.next->gem.obj,
> 				.gem.offset = op->remap.next->gem.offset,
> 			};
> 			panthor_fix_sparse_map_offset(&map_op, unmap_vma->flags);
> 
> 			ret = panthor_vm_exec_map_op(vm, unmap_vma->flags, &map_op);
> 
> 
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>  
> 
> Sorry I realized that indentation needs to be fixed in my patch.
> 
> Will send a v2 and ad your r-b tag.

Sounds good.

Thanks,

Boris
