Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1C2CD4F26
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 09:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F376C10EA49;
	Tue, 23 Jun 2026 09:53:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Jw7agDlM";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D174A10EA49
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 09:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782208417;
 bh=QYhjy/TQr2lLLYyOrWPIZTBz1YngLir9SZPn7y2QBIw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Jw7agDlMkMKnys3iMCXUPhck+G5JqpC3jnqvIAk7WXsF89vjXcn/3k9Vnt+7YjZ7r
 BegV7CZfUufOGoTDlTC6sI2aaF2RnaZsXMihNztL9ZXRX3Ize4i+nJX0bVEISM4It9
 sjte1iQm68DQkBaB/XZv0JTr903+OqOZp8h5xfAAwxYK6l83QHXNLh1oiFxjPq+XF1
 6UwN3F2xjyxUAFxoghhX2G2F8VbX4tKz5Mazk15tQgLomjQQIJUdLLUwd0so9XhIFH
 zdwh899qhY42PE3fZS6GxdLtZPAHK/NjI/jdJzuMguHT7QoB5+s6paH6hjh0eu5Jzg
 wT1qPvGH9sHpg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EE22317E0853;
 Tue, 23 Jun 2026 11:53:36 +0200 (CEST)
Date: Tue, 23 Jun 2026 11:53:32 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH] drm/panthor: Fix NPD issue on partial unmap of an
 evicted BO
Message-ID: <20260623115332.7e89f56b@fedora-2.home>
In-Reply-To: <20260623092413.2710066-1-akash.goel@arm.com>
References: <20260623092413.2710066-1-akash.goel@arm.com>
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

On Tue, 23 Jun 2026 10:24:13 +0100
Akash Goel <akash.goel@arm.com> wrote:

> This commit fixes the NULL pointer dereference issue that would have
> happened on the split of GPU mapping due to partial unmap of an evicted
> BO. There is a logic to handle the partial unmap of huge pages when the
> GPU mapping is split. That logic was not being completely skipped for
> the VMA of an evicted BO and that resulted in a NPD possibility for the
> 'bo->backing.pages' pointer, which is set to NULL when pages of a
> BO are released on eviction.
> 
> Following dump was seen when a partial unmap was exercised for an
> evicted BO.
> Unable to handle kernel paging request at virtual address 0000000000002000
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=00000008842e8000
> [0000000000002000] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1]  SMP
> <snip>
> pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : iova_mapped_as_huge_page+0x20/0x68 [panthor]
> lr : panthor_gpuva_sm_step_remap+0x39c/0x498 [panthor]
> sp : ffff800086193920
> x29: ffff800086193920 x28: ffff800086193a18 x27: ffff800086193b80
> x26: 0000000000400000 x25: 0000000000810000 x24: 0000000000400000
> x23: ffff000808af1800 x22: 0000000000a00000 x21: ffff800086193a00
> x20: ffff000806fd3f00 x19: 0000000000410000 x18: 00000000ffffffff
> x17: 0000000000000000 x16: 0000000000000000 x15: ffff800083ce2d83
> x14: 0000000000000000 x13: 3120646574636976 x12: 6520303030303138
> x11: 2d30303030313420 x10: ffff8000836e6c80 x9 : ffff80007bfc889c
> x8 : 3fffffffffffefff x7 : ffff8000836e6c80 x6 : 0000000000000000
> x5 : ffff00097ef19088 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000000000010000 x1 : 0000000000000400 x0 : 0000000000000000
> Call trace:
>  iova_mapped_as_huge_page+0x20/0x68 [panthor] (P)
>  op_remap_cb.isra.0+0x70/0xb0
>  __drm_gpuvm_sm_unmap+0xf8/0x1c0
>  drm_gpuvm_sm_unmap+0x40/0x60
>  panthor_vm_exec_op+0xa0/0x168 [panthor]
>  panthor_vm_bind_exec_sync_op+0x8c/0xb8 [panthor]
>  panthor_ioctl_vm_bind+0xbc/0x170 [panthor]
>  drm_ioctl_kernel+0xc0/0x140
>  drm_ioctl+0x20c/0x500
>  __arm64_sys_ioctl+0xb4/0x118
>  invoke_syscall+0x5c/0x120
>  el0_svc_common.constprop.0+0x48/0xf8
>  do_el0_svc+0x28/0x40
>  el0_svc+0x38/0x128
>  el0t_64_sync_handler+0xa0/0xe8
>  el0t_64_sync+0x198/0x1a0
> Code: 8b030021 cb020021 f940b800 d34cfc21 (f8617801)
> ---[ end trace 0000000000000000 ]---
> 
> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
> Signed-off-by: Akash Goel <akash.goel@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 31cc57029c12..285e7b9bc100 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2358,20 +2358,20 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
>  	 */
>  	panthor_fix_sparse_map_offset(op->remap.next, unmap_vma->flags);
>  
> -	/*
> -	 * ARM IOMMU page table management code disallows partial unmaps of huge pages,
> -	 * so when a partial unmap is requested, we must first unmap the entire huge
> -	 * page and then remap the difference between the huge page minus the requested
> -	 * unmap region. Calculating the right start address and range for the expanded
> -	 * unmap operation is the responsibility of the following function.
> -	 */
> -	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
> -
> -	/* If the range changed, we might have to lock a wider region to guarantee
> -	 * atomicity. panthor_vm_lock_region() bails out early if the new region
> -	 * is already part of the locked region, so no need to do this check here.
> -	 */
>  	if (!unmap_vma->evicted) {
> +		/*
> +		* ARM IOMMU page table management code disallows partial unmaps of huge pages,
> +		* so when a partial unmap is requested, we must first unmap the entire huge
> +		* page and then remap the difference between the huge page minus the requested
> +		* unmap region. Calculating the right start address and range for the expanded
> +		* unmap operation is the responsibility of the following function.
> +		*/
> +		unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
> +
> +		/* If the range changed, we might have to lock a wider region to guarantee
> +		 * atomicity. panthor_vm_lock_region() bails out early if the new region
> +		 * is already part of the locked region, so no need to do this check here.
> +		 */
>  		panthor_vm_lock_region(vm, unmap_start, unmap_range);
>  		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
>  	}


I think we want something like that instead, so we can keep the
2M alignment for sparse mappings which go recently introduced.

--->8---
diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 5e735995f80d..28844e1e2f81 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2301,6 +2301,10 @@ iova_mapped_as_huge_page(struct drm_gpuva_op_map *op, u64 addr)
        const struct page *pg;
        pgoff_t bo_offset;
 
+       /* Can happen if the BO is evicted. */
+       if (!bo->backing.pages)
+               return false;
+
        bo_offset = addr - op->va.addr + op->gem.offset;
        pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
 

