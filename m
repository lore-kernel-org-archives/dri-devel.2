Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4911F34C5E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45BC910E4AC;
	Mon, 13 Apr 2026 14:53:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="URdC085V";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 0BFD110E4AC
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:53:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DDAEF2E99
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:53:18 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 52E4A3F641
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1776092004; bh=U/o56xLAUs5BK0XAFsMnzu3D154pEgSCh5Zp1ZH9ynQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=URdC085VChbDdPuF55wLFtIYqdzrPdCHfuE1EndWOkekdeUxViW2zRhVoKOb3mMjW
 WN5JOlybrhz6iU5Av2O7tnbi7ObSeowTbTcuh7Mco1BmjcRoIu0FImExJxdRHe9REd
 aUNSK7Mr7RQRRejNt0tTUuwOtrc8/rW6dBg+px/4=
Date: Mon, 13 Apr 2026 15:53:20 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Akash Goel <akash.goel@arm.com>
Cc: boris.brezillon@collabora.com, steven.price@arm.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch, nd@arm.com
Subject: Re: [PATCH v2] drm/panthor: Avoid potential UAF due to memory reclaim
Message-ID: <ad0DYEdw60jv9KXk@e142607>
References: <20260413080253.1288157-1-akash.goel@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260413080253.1288157-1-akash.goel@arm.com>
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

On Mon, Apr 13, 2026 at 09:02:53AM +0100, Akash Goel wrote:
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

I seem to have some email delivery delays, I've seen v2 after I've replied to v1:

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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
> -- 
> 2.25.1
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
