Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C414EBFD10
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D500E10E33D;
	Mon, 13 Apr 2026 07:39:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GJYpuG2i";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0C810E33D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1776065965;
 bh=Ak2vttfopiW4HLlXSkXWW+Fy2hjAYzBa+PmGbOXuke8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GJYpuG2iTs3kMWgbWHeH9EF0TWoota4hi4H2ppybW8oObsNjfzlQEC+Rg6Ho2EQb4
 e+WSFcN+MBVsl7m6nm7WdveRG5Ju6VTovP8tdFwTvuxi6I0ua3s0f/FCcrKJJv7tva
 Mhhv0QVrzAC5bVxDE1q3PRvwJJ28XyTi15gtenHC7dcBgHHI1oNeDZoxlMk0rr/HS2
 L6G3UPIFM6fLq00KCsWhmu/LqaTalMnyBu+lvATU/u6p/o3uDK6b2YcY6NUCXrZWX4
 72PLGf3y7tkqOsAne2ein6xrIDhRpjIkD/ER/LDpA88fqtVKDCVwdmZml7926RvU7B
 AeoFuejl8dYCg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1A89F17E0610;
 Mon, 13 Apr 2026 09:39:25 +0200 (CEST)
Date: Mon, 13 Apr 2026 09:39:19 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Akash Goel <akash.goel@arm.com>
Cc: liviu.dudau@arm.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH] drm/panthor: Avoid potential UAF due to memory reclaim
Message-ID: <20260413093753.4e67fb6e@fedora>
In-Reply-To: <20260410195050.687201-1-akash.goel@arm.com>
References: <20260410195050.687201-1-akash.goel@arm.com>
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

On Fri, 10 Apr 2026 20:50:50 +0100
Akash Goel <akash.goel@arm.com> wrote:

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
> Fixes: fb42964e2a76 ("drm/panthor: Add a GEM shrinker")
> Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Akash Goel <akash.goel@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

A couple nits below.


> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index fa8b31df85c9..8d0dfa93c45c 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -2350,14 +2350,19 @@ int panthor_vm_evict_bo_mappings_locked(struct panthor_gem_object *bo)
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
> +		/* It can be that the vm_bo was already evicted, but a new

							evicted but a ...

> +		 * mapping pointing to this BO got created in the meantime,
> +		 * turning the vm_bo in partially evicted state. In that case

		   thus turning the vm_bo in a partially evicted state.

> +		 * we don't call drm_gpuvm_bo_evict() again because this would
> +		 * mess up with the internal gpuvm lists, but we do walk the
> +		 * VAs on this vm_bo to make sure the non-evicted ones are
> +		 * torn down.
> +		 */
> +		if (!vm_bo->evicted)
> +			drm_gpuvm_bo_evict(vm_bo, true);

Can we add a blank line here?

>  		drm_gpuvm_bo_for_each_va(va, vm_bo) {
>  			struct panthor_vma *vma = container_of(va, struct panthor_vma, base);
>  

