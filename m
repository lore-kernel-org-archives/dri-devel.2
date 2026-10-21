Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45E606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fq6kfxwp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C3DF10E266;
	Wed, 21 Oct 2026 08:44:54 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBAF510E266
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1792572286;
 bh=fYxOwjQv5dtVvmyu01w7Ou5Z1hdzbvQOEdZ2sXgi+ow=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=fq6kfxwpSaRJzytwbRPqgmuwsvKUt+bY0HHHBNExk9ZeouSbQKwnR4aPKeUrcPlOG
 LtZ+SSNIqWcUFmox8STCbLPsFtiCXGnIkZ3nnqZwrcMthD+bXfGMc0egZC2qw1HumE
 AiTDZHDnTRXL60KUAx2jOKyVVGmELc1bDWqUt417lnb3zMbhVUj8Qy9wt6fC2TgRP+
 AtNaEyj1xBR48APlaIS8PPZV4Yu4KJY7jfcz0IltT1jFgfAIsU4jDjFKsCuXqLI7oA
 25pSDapnkofhvxzOei2MGQgpRZf0jeqSseAI9bPZsHLiXPwNaqk1Lmj8UwGzsivG8L
 OznEEa+XP1dug==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id F262217E0411;
 Wed, 21 Oct 2026 10:44:45 +0200 (CEST)
Date: Wed, 21 Oct 2026 10:44:37 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Ketil Johnsen <ketil.johnsen@arm.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/12] drm/panthor: Create kernel BO from existing GEM
Message-ID: <20261021104437.31382be7@fedora-21.home>
In-Reply-To: <20261012125940.3291951-10-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
 <20261012125940.3291951-10-ketil.johnsen@arm.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 12 Oct 2026 14:59:37 +0200
Ketil Johnsen <ketil.johnsen@arm.com> wrote:

> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Refactors/splits existing panthor_kernel_bo_create().
> Adds panthor_kernel_bo_create_from_gem() so we can create kernel BOs
> from imported protected memory in future change.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Co-developed-by: Ketil Johnsen <ketil.johnsen@arm.com>
> Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
> 
> ---
> 
> v4:
> - First version of this change as a separate commit
> ---
>  drivers/gpu/drm/panthor/panthor_gem.c | 94 ++++++++++++++++++---------
>  drivers/gpu/drm/panthor/panthor_gem.h |  7 ++
>  2 files changed, 71 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index 2e39a32fcd673..f1939b4aafed1 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -1033,7 +1033,6 @@ panthor_gem_create(struct drm_device *dev, size_t size, uint32_t flags,
>  		bo->base.resv = bo->exclusive_vm_root_gem->resv;
>  	}
>  
> -	panthor_gem_debugfs_add_usage_flags(bo, usage_flags);
>  	panthor_gem_debugfs_bo_add(bo);
>  	return bo;
>  
> @@ -1260,7 +1259,9 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
>  	panthor_kernel_bo_vunmap(bo);
>  
>  	drm_WARN_ON(bo->obj->dev,
> -		    to_panthor_bo(bo->obj)->exclusive_vm_root_gem != panthor_vm_root_gem(vm));
> +		    to_panthor_bo(bo->obj)->exclusive_vm_root_gem &&
> +			    (to_panthor_bo(bo->obj)->exclusive_vm_root_gem !=
> +			     panthor_vm_root_gem(vm)));

Let's create local vars so this can all fit on a single line.

>  	panthor_vm_unmap_range(vm, bo->va_node.start, bo->va_node.size);
>  	panthor_vm_free_va(vm, &bo->va_node);
>  	if (vm == panthor_fw_vm(ptdev))
> @@ -1271,46 +1272,33 @@ void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo)
>  }
>  
>  /**
> - * panthor_kernel_bo_create() - Create and map a GEM object to a VM
> + * panthor_kernel_bo_create_from_gem() - Create kernel BO from existing GEM object
>   * @ptdev: Device.
>   * @vm: VM to map the GEM to.
> - * @size: Size of the buffer object.
> - * @bo_flags: Combination of drm_panthor_bo_flags flags.
> + * @bo: BO to use for our kernel BO.
>   * @vm_map_flags: Combination of drm_panthor_vm_bind_op_flags (only those
>   * that are related to map operations).
>   * @gpu_va: GPU address assigned when mapping to the VM.
>   * If gpu_va == PANTHOR_VM_KERNEL_AUTO_VA, the virtual address will be
>   * automatically allocated.
> - * @name: Descriptive label of the BO's contents
> + * @vm_map_size: Size of the BO to map to the VM.
>   *
>   * Return: A valid pointer in case of success, an ERR_PTR() otherwise.
>   */
>  struct panthor_kernel_bo *
> -panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
> -			 size_t size, u32 bo_flags, u32 vm_map_flags,
> -			 u64 gpu_va, const char *name)
> +panthor_kernel_bo_create_from_gem(struct panthor_device *ptdev,
> +				  struct panthor_vm *vm,
> +				  struct panthor_gem_object *bo,
> +				  u32 vm_map_flags, u64 gpu_va, u32 vm_map_size)
>  {
>  	struct panthor_kernel_bo *kbo;
> -	struct panthor_gem_object *bo;
> -	u32 debug_flags = PANTHOR_DEBUGFS_GEM_USAGE_FLAG_KERNEL;
>  	int ret;
>  
> -	if (drm_WARN_ON(&ptdev->base, !vm))
> -		return ERR_PTR(-EINVAL);
> -
>  	kbo = kzalloc_obj(*kbo);
>  	if (!kbo)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (vm == panthor_fw_vm(ptdev))
> -		debug_flags |= PANTHOR_DEBUGFS_GEM_USAGE_FLAG_FW_MAPPED;
> -
> -	bo = panthor_gem_create(&ptdev->base, size, bo_flags, vm, debug_flags);
> -	if (IS_ERR(bo)) {
> -		ret = PTR_ERR(bo);
> -		goto err_free_kbo;
> -	}
> -
> +	drm_gem_object_get(&bo->base);
>  	kbo->obj = &bo->base;
>  
>  	if (vm == panthor_fw_vm(ptdev)) {
> @@ -1319,24 +1307,27 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
>  			goto err_put_obj;
>  	}
>  
> -	panthor_gem_kernel_bo_set_label(kbo, name);
> -
>  	/* The system and GPU MMU page size might differ, which becomes a
>  	 * problem for FW sections that need to be mapped at explicit address
>  	 * since our PAGE_SIZE alignment might cover a VA range that's
>  	 * expected to be used for another section.
>  	 * Make sure we never map more than we need.
>  	 */
> -	size = ALIGN(size, panthor_vm_page_size(vm));
> -	ret = panthor_vm_alloc_va(vm, gpu_va, size, &kbo->va_node);
> +	vm_map_size = ALIGN(vm_map_size, panthor_vm_page_size(vm));
> +	ret = panthor_vm_alloc_va(vm, gpu_va, vm_map_size, &kbo->va_node);
>  	if (ret)
>  		goto err_unpin;
>  
> -	ret = panthor_vm_map_bo_range(vm, bo, 0, size, kbo->va_node.start, vm_map_flags);
> +	ret = panthor_vm_map_bo_range(vm, bo, 0, vm_map_size,
> +				      kbo->va_node.start, vm_map_flags);
>  	if (ret)
>  		goto err_free_va;
>  
>  	kbo->vm = panthor_vm_get(vm);
> +	if (vm == panthor_fw_vm(ptdev))
> +		panthor_gem_debugfs_add_usage_flags(
> +			bo, PANTHOR_DEBUGFS_GEM_USAGE_FLAG_FW_MAPPED);


	if (vm == panthor_fw_vm(ptdev)) {
		panthor_gem_debugfs_add_usage_flags(bo,
						    PANTHOR_DEBUGFS_GEM_USAGE_FLAG_FW_MAPPED);
	}

> +
>  	return kbo;
>  
>  err_free_va:
> @@ -1348,12 +1339,55 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
>  
>  err_put_obj:
>  	drm_gem_object_put(&bo->base);
> -
> -err_free_kbo:
>  	kfree(kbo);
>  	return ERR_PTR(ret);
>  }
>  
> +/**
> + * panthor_kernel_bo_create() - Create and map a GEM object to a VM
> + * @ptdev: Device.
> + * @vm: VM to map the GEM to.
> + * @size: Size of the buffer object.
> + * @bo_flags: Combination of drm_panthor_bo_flags flags.
> + * @vm_map_flags: Combination of drm_panthor_vm_bind_op_flags (only those
> + * that are related to map operations).
> + * @gpu_va: GPU address assigned when mapping to the VM.
> + * If gpu_va == PANTHOR_VM_KERNEL_AUTO_VA, the virtual address will be
> + * automatically allocated.
> + * @name: Descriptive label of the BO's contents
> + *
> + * Return: A valid pointer in case of success, an ERR_PTR() otherwise.
> + */
> +struct panthor_kernel_bo *
> +panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
> +			 size_t size, u32 bo_flags, u32 vm_map_flags,
> +			 u64 gpu_va, const char *name)
> +{
> +	struct panthor_kernel_bo *kbo;
> +	struct panthor_gem_object *bo;
> +
> +	if (drm_WARN_ON(&ptdev->base, !vm))
> +		return ERR_PTR(-EINVAL);
> +
> +	bo = panthor_gem_create(&ptdev->base, size, bo_flags, vm, 0);
> +	if (IS_ERR(bo))
> +		return ERR_CAST(bo);
> +
> +	kbo = panthor_kernel_bo_create_from_gem(ptdev, vm, bo, vm_map_flags,
> +						gpu_va, size);
> +	if (!IS_ERR(kbo)) {
> +		panthor_gem_debugfs_add_usage_flags(
> +			bo, PANTHOR_DEBUGFS_GEM_USAGE_FLAG_KERNEL);

		panthor_gem_debugfs_add_usage_flags(bo,
						    PANTHOR_DEBUGFS_GEM_USAGE_FLAG_KERNEL);

> +		panthor_gem_kernel_bo_set_label(kbo, name);
> +	}
> +
> +	/* panthor_kernel_bo_create_from_gem() acquires a GEM ref if the import
> +	 * succeeds, so we can release it unconditionally here.
> +	 */
> +	drm_gem_object_put(&bo->base);
> +	return kbo;
> +}
> +
>  /**
>   * panthor_dummy_bo_create() - Create a Panthor BO meant to back sparse bindings.
>   * @ptdev: Device.
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
> index 4da3f59693ce4..03dd3927b5d16 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.h
> +++ b/drivers/gpu/drm/panthor/panthor_gem.h
> @@ -318,6 +318,13 @@ panthor_kernel_bo_vunmap(struct panthor_kernel_bo *bo)
>  	}
>  }
>  
> +struct panthor_kernel_bo *
> +panthor_kernel_bo_create_from_gem(struct panthor_device *ptdev,
> +				  struct panthor_vm *vm,
> +				  struct panthor_gem_object *bo,
> +				  u32 vm_map_flags, u64 gpu_va,
> +				  u32 vm_map_size);
> +
>  struct panthor_kernel_bo *
>  panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
>  			 size_t size, u32 bo_flags, u32 vm_map_flags,

