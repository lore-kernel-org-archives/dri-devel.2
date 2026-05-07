Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC5FCD3439
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F388110F10A;
	Thu,  7 May 2026 13:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="c+WbO38f";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1A6C610F116
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:19:09 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EDC51688;
 Thu,  7 May 2026 06:19:03 -0700 (PDT)
Received: from [10.57.67.110] (unknown [10.57.67.110])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 417483F763;
 Thu,  7 May 2026 06:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778159948; bh=yXfCBFCPgjOdOHb+BXpPtV18+dE1tw2IPBvEyejnGQ8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=c+WbO38fpAK05jEpTLtFj9smv59nLRjtMjNRcVMBvyloemq6GwEzBhTeDMcS5JRnz
 1qquED8BFq//9bSqSSWM6A3j/+v1n701n5LlvRFxfk2qeuX6wPxudG+02ZkjpOUTeT
 MA12aXU+nJq+H7WSP3yBSeZEHAvPKzdJV/6wFTMg=
Message-ID: <96bb98c0-33ff-46b6-99fc-f325582c5a94@arm.com>
Date: Thu, 7 May 2026 14:19:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/panthor: Avoid potential UAF due to memory reclaim
To: Akash Goel <akash.goel@arm.com>, boris.brezillon@collabora.com,
 liviu.dudau@arm.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
References: <20260413080253.1288157-1-akash.goel@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260413080253.1288157-1-akash.goel@arm.com>
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

On 13/04/2026 09:02, Akash Goel wrote:
> Recent changes to add shrinker support introduced a use after free
> vulnerability.
> When a BO is evicted from the shrinker callback, all its CPU and GPU
> mappings are invalidated. It can happen that another GPU mapping is
> created for the BO after the eviction. Because of the new GPU mapping,
> BO will be added back to one of the reclaim list but the state of
> corresponding vm_bo will not be changed.
> If vm_bo remains in evicted state and shrinker callback is invoked
> again then the new GPU mapping won't be invalidated. As a result the
> backing pages, which were acquired on the creation of new GPU mapping,
> can get reclaimed and reused whilst they are still mapped to the GPU.
> 
> To prevent the use after free possibility, this commit removes the
> evicted check for vm_bo so that all GPU mappings are checked for
> invalidation.
> 
> v2:
>  - Update comment and add a newline in
>    panthor_vm_evict_bo_mappings_locked().
> 
> Fixes: fb42964e2a76 ("drm/panthor: Add a GEM shrinker")
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Akash Goel <akash.goel@arm.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Applied to drm-misc-next

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index fa8b31df85c9..592a6829bee6 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2350,14 +2350,20 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo)
>  		struct panthor_vm *vm = container_of(vm_bo->vm, struct panthor_vm, base);
>  		struct drm_gpuva *va;
>  
> -		/* Skip already evicted GPU mappings. */
> -		if (vm_bo->evicted)
> -			continue;
> -
>  		if (!mutex_trylock(&vm->op_lock))
>  			return -EDEADLK;
>  
> -		drm_gpuvm_bo_evict(vm_bo, true);
> +		/* It can be that the vm_bo was already evicted but a new
> +		 * mapping pointing to this BO got created in the meantime,
> +		 * thus turning the vm_bo in partially evicted state. In that case
> +		 * we don't call drm_gpuvm_bo_evict() again because this would
> +		 * mess up with the internal gpuvm lists, but we do walk the
> +		 * VAs on this vm_bo to make sure the non-evicted ones are
> +		 * torn down.
> +		 */
> +		if (!vm_bo->evicted)
> +			drm_gpuvm_bo_evict(vm_bo, true);
> +
>  		drm_gpuvm_bo_for_each_va(va, vm_bo) {
>  			struct panthor_vma *vma = container_of(va, struct panthor_vma, base);
>  

