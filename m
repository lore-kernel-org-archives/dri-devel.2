Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F341C54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 10:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D916510EE94;
	Thu, 30 Jul 2026 10:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="RyAIqM+S";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id CBC7C10EE94
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 10:47:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C64F1688
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:47:43 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 10F5B3F86F
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 03:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1785408467; bh=unSsqLjMlbRj1rOildUEgSOScIlD71euFOCQoiPmzqA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RyAIqM+SfrvuQMy/k7nbz5Q+wWWuIgrNQZ9+Nnaf3lQwAdNmUuEuHyNOAzrIvBaqM
 F77xfIMdgHTJWipsZgNM1furDg1C9pDENzeSwkfso1vUQ2cR3ucRqN3mWwS2f3c2E7
 4Vm8nn1F8GtPS30JxUH/9Xvfj0XrOFUb3RJDhQyw=
Date: Thu, 30 Jul 2026 11:47:34 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] drm/panthor: Explicit expansion of locked VM region
Message-ID: <amsrxqUXNYhFDPz-@e142607>
References: <20260712135439.1546950-1-ketil.johnsen@arm.com>
 <20260712135439.1546950-4-ketil.johnsen@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260712135439.1546950-4-ketil.johnsen@arm.com>
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

On Sun, Jul 12, 2026 at 03:54:35PM +0200, Ketil Johnsen wrote:
> Currently the panthor_vm_lock_region() function will implicitly expand
> an already locked VM region. This can be problematic because the caller
> do not reliably know if it needs to call panthor_vm_unlock_region()
> or not.
> 
> Worth noting, there is currently no known issues with this as the code
> is written today.
> 
> This change introduces panthor_vm_expand_region() which will only work
> if there is already a locked VM region. This again means that the
> original lock and unlock functions can work as a pair. This pairing is
> needed for subsequent protected memory changes.
> 
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 87 +++++++++++++++++++--------
>  1 file changed, 62 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 1f6b9242279c2..b82b01013611c 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -1774,20 +1774,49 @@ static const char *access_type_name(struct panthor_device *ptdev,
>  	}
>  }
>  
> +static int panthor_vm_apply_as_lock(struct panthor_vm *vm, u64 region)
> +{
> +	struct panthor_device *ptdev = vm->ptdev;
> +
> +	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
> +
> +	gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id), region);
> +	return as_send_cmd_and_wait(ptdev, vm->as.id, AS_COMMAND_LOCK);
> +}
> +
>  static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
>  {
>  	struct panthor_device *ptdev = vm->ptdev;
>  	int ret = 0;
>  
> -	/* sm_step_remap() can call panthor_vm_lock_region() to account for
> -	 * the wider unmap needed when doing a partial huge page unamp. We
> -	 * need to ignore the lock if it's already part of the locked region.
> -	 */
> -	if (start >= vm->locked_region.start &&
> -	    start + size <= vm->locked_region.start + vm->locked_region.size)
> -		return 0;
> +	if (drm_WARN_ON(&ptdev->base, vm->locked_region.size))
> +		return -EINVAL;
> +
> +	mutex_lock(&ptdev->mmu->as.slots_lock);
> +	if (vm->as.id >= 0 && size) {
> +		u64 region = pack_region_range(ptdev, &start, &size);
> +
> +		ret = panthor_vm_apply_as_lock(vm, region);
> +	}
>  
> -	/* sm_step_remap() may need a locked region that isn't a strict superset
> +	if (!ret) {
> +		vm->locked_region.start = start;
> +		vm->locked_region.size = size;
> +	}
> +	mutex_unlock(&ptdev->mmu->as.slots_lock);
> +
> +	return ret;
> +}
> +
> +static int panthor_vm_expand_locked_region(struct panthor_vm *vm,
> +					   u64 start, u64 size)
> +{
> +	struct panthor_device *ptdev = vm->ptdev;
> +	u64 end;
> +	int ret = 0;
> +
> +	/* This function is here to handle the following case:
> +	 * sm_step_remap() may need a locked region that isn't a strict superset
>  	 * of the original one because of having to extend unmap boundaries beyond
>  	 * it to deal with partial unmaps of transparent huge pages. What we want
>  	 * in those cases is to lock the union of both regions. The new region must
> @@ -1795,25 +1824,30 @@ static int panthor_vm_lock_region(struct panthor_vm *vm, u64 start, u64 size)
>  	 * boundaries in a remap operation can only shift up or down respectively,
>  	 * but never otherwise.
>  	 */
> -	if (vm->locked_region.size) {
> -		u64 end = max(vm->locked_region.start + vm->locked_region.size,
> -			      start + size);
>  
> -		drm_WARN_ON_ONCE(&vm->ptdev->base, (start + size <= vm->locked_region.start) ||
> -				 (start >= vm->locked_region.start + vm->locked_region.size));
> +	/* This function can only expand an already locked region */
> +	if (drm_WARN_ON(&ptdev->base, !vm->locked_region.size))
> +		return -EINVAL;
> +
> +	/* Early out if requested range is already locked */
> +	if (start >= vm->locked_region.start &&
> +	    start + size <= vm->locked_region.start + vm->locked_region.size)
> +		return 0;
>  
> -		start = min(start, vm->locked_region.start);
> -		size = end - start;
> -	}
> +	end = max(vm->locked_region.start + vm->locked_region.size,
> +		  start + size);
> +
> +	drm_WARN_ON_ONCE(&ptdev->base, (start + size <= vm->locked_region.start) ||
> +			 (start >= vm->locked_region.start + vm->locked_region.size));
> +
> +	start = min(start, vm->locked_region.start);
> +	size = end - start;
>  
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	if (vm->as.id >= 0 && size) {
> -		/* Lock the region that needs to be updated */
> -		gpu_write64(ptdev->mmu->iomem, AS_LOCKADDR(vm->as.id),
> -			    pack_region_range(ptdev, &start, &size));
> +		u64 region = pack_region_range(ptdev, &start, &size);
>  
> -		/* If the lock succeeded, update the locked_region info. */
> -		ret = as_send_cmd_and_wait(ptdev, vm->as.id, AS_COMMAND_LOCK);
> +		ret = panthor_vm_apply_as_lock(vm, region);
>  	}
>  
>  	if (!ret) {
> @@ -2367,11 +2401,14 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
>  		 */
>  		unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
>  
> -		/* If the range changed, we might have to lock a wider region to guarantee
> -		 * atomicity. panthor_vm_lock_region() bails out early if the new region
> -		 * is already part of the locked region, so no need to do this check here.
> +		/* If the range changed, we might have to lock a wider region to
> +		 * guarantee atomicity.
>  		 */
> -		panthor_vm_lock_region(vm, unmap_start, unmap_range);
> +		ret = panthor_vm_expand_locked_region(vm, unmap_start,
> +						      unmap_range);
> +		if (ret)
> +			return ret;
> +
>  		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
>  	}
>  
> -- 
> 2.43.0
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
