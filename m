Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BC1CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C18CE10E3EC;
	Wed, 24 Jun 2026 15:24:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="pcY02sgs";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 684DA10E3EC
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 15:24:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F6572308;
 Wed, 24 Jun 2026 08:24:29 -0700 (PDT)
Received: from [10.57.80.146] (unknown [10.57.80.146])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FD553F905;
 Wed, 24 Jun 2026 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1782314673; bh=Kr9PxiimzdmHXkWFbWuhQ+JTnwkSqSuKMW5J54+nEj4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pcY02sgs2Mm8G1UR/XClsb+9aGhcIOsptWBNUzuoktUP4vob0POJPHA0MOUHxy7Tt
 tl58jqRi7/rBph+w+2vMiukmRLsg3CiVLhXMEU2RjfO/Bj8qZKMhg7nGJJGqgyr6ZB
 w7nunyjCZgtHnhcZxCCvY/dJbuSGIaQ8TXEdXg/s=
Message-ID: <6ba21577-9963-4fe6-a945-8566239cb491@arm.com>
Date: Wed, 24 Jun 2026 16:24:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Fix NPD issue on partial unmap of an
 evicted BO
To: Akash Goel <akash.goel@arm.com>, boris.brezillon@collabora.com,
 liviu.dudau@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
References: <20260623130119.2737003-1-akash.goel@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260623130119.2737003-1-akash.goel@arm.com>
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

On 23/06/2026 14:01, Akash Goel wrote:
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
> v2: Fix indentation
> 
> Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
> Signed-off-by: Akash Goel <akash.goel@arm.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 31cc57029c12..7c99cd422add 100644
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
> +		 * ARM IOMMU page table management code disallows partial unmaps of huge pages,
> +		 * so when a partial unmap is requested, we must first unmap the entire huge
> +		 * page and then remap the difference between the huge page minus the requested
> +		 * unmap region. Calculating the right start address and range for the expanded
> +		 * unmap operation is the responsibility of the following function.
> +		 */
> +		unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
> +
> +		/* If the range changed, we might have to lock a wider region to guarantee
> +		 * atomicity. panthor_vm_lock_region() bails out early if the new region
> +		 * is already part of the locked region, so no need to do this check here.
> +		 */
>  		panthor_vm_lock_region(vm, unmap_start, unmap_range);
>  		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
>  	}

