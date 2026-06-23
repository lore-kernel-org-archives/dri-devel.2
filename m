Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A636CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACF4510EAE1;
	Tue, 23 Jun 2026 12:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="WOuerfJQ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FACE10EAE1
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782216587;
 bh=/TZ1zUVv9qX46VAgMsPsPlEdJt9LZFVakRYi1wlWw0M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=WOuerfJQT8r+WBDJTIyz1Ier7k+9Im5Y5fHm51mveX82HSHfb4e0AtWeN7mv4Lnr2
 Uj8BSjU9Q/2cK/t7iY1Rlpa1GO/iyjj1pp6h80lZPYaOEwvVrWzJnC6AbkpEknYXUd
 bNcufi/I2LVfR0dl88U4BaTs953Lz7PRCMhPgLNNVoNTWAzNj5EoIEhBqI95hm5Vq7
 ydOxE82sRCSq4QUuEfYZsiz0YgfjjmOOuj8xIVkQZ0WiBBbrkaMJi6gEooDtIB1i/4
 JU244u8X5ZJT2tVTe5Xt4IiSVhptjboz7OrYbTe1xkr8Pagl7xz8UMk8ybuq3pSA6I
 FErQzi41e2B3g==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 182EE17E062C;
 Tue, 23 Jun 2026 14:09:47 +0200 (CEST)
Date: Tue, 23 Jun 2026 14:09:42 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH] drm/panthor: Fix NPD issue on partial unmap of an
 evicted BO
Message-ID: <20260623140942.5055457c@fedora-2.home>
In-Reply-To: <9f9b372d-b465-4fd4-ab7a-9c399e35b4ed@arm.com>
References: <20260623092413.2710066-1-akash.goel@arm.com>
 <20260623115332.7e89f56b@fedora-2.home>
 <9f9b372d-b465-4fd4-ab7a-9c399e35b4ed@arm.com>
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

On Tue, 23 Jun 2026 12:17:51 +0100
Akash Goel <akash.goel@arm.com> wrote:

> Hi Boris
> 
> On 6/23/26 10:53, Boris Brezillon wrote:
> > On Tue, 23 Jun 2026 10:24:13 +0100
> > Akash Goel <akash.goel@arm.com> wrote:
> >   
> >> This commit fixes the NULL pointer dereference issue that would have
> >> happened on the split of GPU mapping due to partial unmap of an evicted
> >> BO. There is a logic to handle the partial unmap of huge pages when the
> >> GPU mapping is split. That logic was not being completely skipped for
> >> the VMA of an evicted BO and that resulted in a NPD possibility for the
> >> 'bo->backing.pages' pointer, which is set to NULL when pages of a
> >> BO are released on eviction.
> >>  
> 
> >>
> >> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
> >> Signed-off-by: Akash Goel <akash.goel@arm.com>
> >> ---
> >>   drivers/gpu/drm/panthor/panthor_mmu.c | 26 +++++++++++++-------------
> >>   1 file changed, 13 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> >> index 31cc57029c12..285e7b9bc100 100644
> >> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> >> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> >> @@ -2358,20 +2358,20 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
> >>   	 */
> >>   	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
> >>   
> >> -	/*
> >> -	 * ARM IOMMU page table management code disallows partial unmaps of huge pages,
> >> -	 * so when a partial unmap is requested, we must first unmap the entire huge
> >> -	 * page and then remap the difference between the huge page minus the requested
> >> -	 * unmap region. Calculating the right start address and range for the expanded
> >> -	 * unmap operation is the responsibility of the following function.
> >> -	 */
> >> -	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
> >> -
> >> -	/* If the range changed, we might have to lock a wider region to guarantee
> >> -	 * atomicity. panthor_vm_lock_region() bails out early if the new region
> >> -	 * is already part of the locked region, so no need to do this check here.
> >> -	 */
> >>   	if (!unmap_vma->evicted) {
> >> +		/*
> >> +		* ARM IOMMU page table management code disallows partial unmaps of huge pages,
> >> +		* so when a partial unmap is requested, we must first unmap the entire huge
> >> +		* page and then remap the difference between the huge page minus the requested
> >> +		* unmap region. Calculating the right start address and range for the expanded
> >> +		* unmap operation is the responsibility of the following function.
> >> +		*/
> >> +		unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
> >> +
> >> +		/* If the range changed, we might have to lock a wider region to guarantee
> >> +		 * atomicity. panthor_vm_lock_region() bails out early if the new region
> >> +		 * is already part of the locked region, so no need to do this check here.
> >> +		 */
> >>   		panthor_vm_lock_region(vm, unmap_start, unmap_range);
> >>   		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
> >>   	}  
> > 
> > 
> > I think we want something like that instead, so we can keep the
> > 2M alignment for sparse mappings which go recently introduced.
> >   
> 
> Thanks for the suggestion. But sorry I didn't get it.
> 
> I see that the patching of 'op->remap.next->gem.offset' would still be 
> done with my change.
> 
> 	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
> 
> 	if (!unmap_vma->evicted) {
> 		unmap_hugepage_align(&op->remap, &unmap_start,
> 
> IIUC, the 2M alignment is done to avoid a potential partial unmap of 2M 
> page. But if the VMA is in evicted state then already the unmap would 
> have happened for the whole virtual range covered by the VMA.

Nah, you're correct, the patching of the drm_gpuva is independent of the
adjusted unmap range, so we should be good even if we don't adjust this
range for evicted sparse mappings. Sorry for the noise.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
