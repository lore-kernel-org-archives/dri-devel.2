Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B01EFE51FD
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94D7810F4A9;
	Fri, 24 Apr 2026 10:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="F6r19G00";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 6440810F4A9
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 10:09:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 417441BC0;
 Fri, 24 Apr 2026 03:09:26 -0700 (PDT)
Received: from [10.1.26.15] (e122027.cambridge.arm.com [10.1.26.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8049C3F641;
 Fri, 24 Apr 2026 03:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777025371; bh=N2CAmZ8t8+fMGKaAWWd8No/XpPYJSrYXNu28O4/Bb6A=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=F6r19G008x765L42IrI9v3sLOMzNEA3q2lxXKRXpE/uAbpBYl+mvJs3H+W0hQ+3aL
 3erRzOz4iEDgWKrZmBbDee0xOl3+GxNoDMA+l/uSgsi71bLvN6srcX6fjhyKSRflJe
 7WvS4OSCShUWsBqcG1tEdFnG2Iyji7T9j1v0DwP0=
Message-ID: <f0ec1b96-a6ff-49c6-b57d-740f97ac867f@arm.com>
Date: Fri, 24 Apr 2026 11:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 5/6] drm/panthor: Support sparse mappings
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
 Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
References: <20260422122538.3117380-1-adrian.larumbe@collabora.com>
 <20260422122538.3117380-6-adrian.larumbe@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260422122538.3117380-6-adrian.larumbe@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Adrián,

On 22/04/2026 13:25, Adrián Larumbe wrote:
> Allow UM to bind sparsely populated memory regions by cyclically mapping
> virtual ranges over a kernel-allocated dummy BO. This alternative is
> preferable to the old method of handling sparseness in the UMD, because it
> relied on the creation of a buffer object to the same end, despite the fact
> Vulkan sparse resources don't need to be backed by a driver BO.
> 
> The choice of backing sparsely-bound regions with a Panhtor BO was made so
> as to profit from the existing shrinker reclaim code. That way no special
> treatment must be given to the dummy sparse BOs when reclaiming memory, as
> would be the case if we had chosen a raw kernel page implementation.
> 
> A new dummy BO is allocated per open file context, because even though the
> Vulkan spec mandates that writes into sparsely bound regions must be
> discarded, our implementation is still a workaround over the fact Mali CSF
> GPUs cannot support this behaviour on the hardware level, so writes still
> make it into the backing BO. If we had a global one, then it could be a
> venue for information leaks between file contexts, which should never
> happen in DRM.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Looks good, a few issues below.

I'm worried about remap_evicted_vma() and how that interacts with sparse
mappings. Does that need to be fixed up to handle sparse mappings? Or is
there something to prevent the dummy BO being reclaimed? I might be
missing something here.

> ---
>  drivers/gpu/drm/panthor/panthor_gem.c |  18 +++
>  drivers/gpu/drm/panthor/panthor_gem.h |   2 +
>  drivers/gpu/drm/panthor/panthor_mmu.c | 172 ++++++++++++++++++++++----
>  include/uapi/drm/panthor_drm.h        |  12 ++
>  4 files changed, 183 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
> index 69cef05b6ef7..833153c2b080 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.c
> +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> @@ -1345,6 +1345,24 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
>  	return ERR_PTR(ret);
>  }
>  
> +/**
> + * panthor_dummy_bo_create() - Create a Panthor BO meant to back sparse bindings.
> + * @ptdev: Device.
> + *
> + * Return: A valid pointer in case of success, an ERR_PTR() otherwise.
> + */
> +struct panthor_gem_object *
> +panthor_dummy_bo_create(struct panthor_device *ptdev)
> +{
> +	/* Since even when the DRM device's mount point has enabled THP we have no guarantee
> +	 * that drm_gem_get_pages() will return a single 2MiB PMD, and also we cannot be sure
> +	 * that the 2MiB won't be reclaimed and re-allocated later on as 4KiB chunks, it doesn't
> +	 * make sense to pre-populate this object's page array, nor to fall back on a BO size
> +	 * of 4KiB. Sticking to a dummy object size of 2MiB lets us keep things simple for now.
> +	 */
> +	return panthor_gem_create(&ptdev->base, SZ_2M, DRM_PANTHOR_BO_NO_MMAP, NULL, 0);

So here we're not guaranteeing the dummy BO is a huge page (which is
fine), but...

> +}
> +
>  static bool can_swap(void)
>  {
>  	return get_nr_swap_pages() > 0;
> diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
> index ae0491d0b121..8639c2fa08e6 100644
> --- a/drivers/gpu/drm/panthor/panthor_gem.h
> +++ b/drivers/gpu/drm/panthor/panthor_gem.h
> @@ -315,6 +315,8 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
>  
>  void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo);
>  
> +struct panthor_gem_object *panthor_dummy_bo_create(struct panthor_device *ptdev);
> +
>  #ifdef CONFIG_DEBUG_FS
>  void panthor_gem_debugfs_init(struct drm_minor *minor);
>  #endif
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 54f7f7a8d44f..7b91836e608d 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -112,6 +112,17 @@ struct panthor_mmu {
>  struct panthor_vm_pool {
>  	/** @xa: Array used for VM handle tracking. */
>  	struct xarray xa;
> +
> +	/**
> +	 * @dummy: Dummy object used for sparse mappings
> +	 *
> +	 * Sparse bindings map virtual address ranges onto a dummy
> +	 * BO in a modulo fashion. Even though sparse writes are meant
> +	 * to be discarded and reads undefined, writes are still reflected
> +	 * in the dummy buffer. That means we must keep a dummy object per
> +	 * file context, to avoid data leaks between them.
> +	 */
> +	struct panthor_gem_object *dummy;
>  };
>  
>  /**
> @@ -391,6 +402,16 @@ struct panthor_vm {
>  		 */
>  		struct list_head lru_node;
>  	} reclaim;
> +
> +	/**
> +	 * @dummy: Dummy object used for sparse mappings.
> +	 *
> +	 * VM's must keep a reference to the file context-wide dummy BO because
> +	 * they can outlive the file context, which includes the VM pool holding
> +	 * the original dummy BO reference.
> +	 *
> +	 */
> +	struct panthor_gem_object *dummy;
>  };
>  
>  /**
> @@ -1020,6 +1041,45 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 iova, int prot,
>  	return 0;
>  }
>  
> +static int
> +panthor_vm_map_sparse(struct panthor_vm *vm, u64 iova, int prot,
> +		      struct sg_table *sgt, u64 size)
> +{
> +	u64 start_iova = iova;
> +	int ret;
> +
> +	if (iova & (SZ_2M - 1)) {
> +		u64 unaligned_size = min(ALIGN(iova, SZ_2M) - iova, size);
> +
> +		ret = panthor_vm_map_pages(vm, iova, prot, sgt,
> +					   0, unaligned_size);
> +		if (ret)
> +			return ret;
> +
> +		size -= unaligned_size;
> +		iova += unaligned_size;
> +	}
> +
> +	/* TODO: we should probably optimize this at the io_pgtable level. */
> +	while (size > 0) {
> +		u64 next_size = min(size, sg_dma_len(sgt->sgl));

Here we're only using the first entry of the scatter list. So I think in
the fragmented case we don't end up using the full 2MB.

> +
> +		ret = panthor_vm_map_pages(vm, iova, prot,
> +					   sgt, 0, next_size);
> +		if (ret)
> +			goto err_unmap;
> +
> +		size -= next_size;
> +		iova += next_size;
> +	}
> +
> +	return 0;
> +
> +err_unmap:
> +	panthor_vm_unmap_pages(vm, start_iova, iova - start_iova);
> +	return ret;
> +}
> +
>  static int flags_to_prot(u32 flags)
>  {
>  	int prot = 0;
> @@ -1262,6 +1322,7 @@ static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
>  	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
>  	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
>  	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED | \
> +	 DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE | \
>  	 DRM_PANTHOR_VM_BIND_OP_TYPE_MASK)
>  
>  static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
> @@ -1269,6 +1330,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  					 struct panthor_gem_object *bo,
>  					 const struct drm_panthor_vm_bind_op *op)
>  {
> +	bool is_sparse = op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
>  	struct drm_gpuvm_bo *preallocated_vm_bo;
>  	struct sg_table *sgt = NULL;
>  	int ret;
> @@ -1280,8 +1342,21 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
>  	    (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) != DRM_PANTHOR_VM_BIND_OP_TYPE_MAP)
>  		return -EINVAL;
>  
> -	/* Make sure the VA and size are in-bounds. */
> -	if (op->size > bo->base.size || op->bo_offset > bo->base.size - op->size)
> +	/* uAPI mandates sparsely bound regions must not be executable. */
> +	if (is_sparse && !(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC))
> +		return -EINVAL;
> +
> +	/* For non-sparse, make sure the VA and size are in-bounds.
> +	 * For sparse, this is not applicable, because the dummy BO is
> +	 * repeatedly mapped over a potentially wider VA range.
> +	 */
> +	if (!is_sparse && (op->size > bo->base.size || op->bo_offset > bo->base.size - op->size))
> +		return -EINVAL;
> +
> +	/* For sparse, we don't expect any user BO, the BO we get passed
> +	 * is the dummy BO attached to the VM pool.
> +	 */
> +	if (is_sparse && (op->bo_handle || op->bo_offset))
>  		return -EINVAL;
>  
>  	/* If the BO has an exclusive VM attached, it can't be mapped to other VMs. */
> @@ -1543,6 +1618,9 @@ int panthor_vm_pool_create_vm(struct panthor_device *ptdev,
>  		return ret;
>  	}
>  
> +	drm_gem_object_get(&pool->dummy->base);
> +	vm->dummy = pool->dummy;
> +
>  	args->user_va_range = kernel_va_start;
>  	return id;
>  }
> @@ -1634,6 +1712,7 @@ void panthor_vm_pool_destroy(struct panthor_file *pfile)
>  	xa_for_each(&pfile->vms->xa, i, vm)
>  		panthor_vm_destroy(vm);
>  
> +	drm_gem_object_put(&pfile->vms->dummy->base);
>  	xa_destroy(&pfile->vms->xa);
>  	kfree(pfile->vms);
>  }
> @@ -1651,6 +1730,11 @@ int panthor_vm_pool_create(struct panthor_file *pfile)
[missing context]
	pfile->vms = kzalloc_obj(*pfile->vms);
	if (!pfile->vms)
[/missing_context]
>  		return -ENOMEM;
>  
>  	xa_init_flags(&pfile->vms->xa, XA_FLAGS_ALLOC1);
> +
> +	pfile->vms->dummy = panthor_dummy_bo_create(pfile->ptdev);
> +	if (IS_ERR(pfile->vms->dummy))
> +		return PTR_ERR(pfile->vms->dummy);

Here pfile->vms is not cleaned up.

> +
>  	return 0;
>  }
>  
> @@ -1968,6 +2052,9 @@ static void panthor_vm_free(struct drm_gpuvm *gpuvm)
>  
>  	free_io_pgtable_ops(vm->pgtbl_ops);
>  
> +	if (vm->dummy)
> +		drm_gem_object_put(&vm->dummy->base);
> +
>  	drm_mm_takedown(&vm->mm);
>  	kfree(vm);
>  }
> @@ -2127,7 +2214,23 @@ static void panthor_vma_init(struct panthor_vma *vma, u32 flags)
>  #define PANTHOR_VM_MAP_FLAGS \
>  	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
>  	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
> -	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED)
> +	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED | \
> +	 DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
> +
> +static int
> +panthor_vm_exec_map_op(struct panthor_vm *vm, u32 flags,
> +		       const struct drm_gpuva_op_map *op)
> +{
> +	struct panthor_gem_object *bo = to_panthor_bo(op->gem.obj);
> +	int prot = flags_to_prot(flags);
> +
> +	if (flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
> +		return panthor_vm_map_sparse(vm, op->va.addr, prot,
> +					     bo->dmap.sgt, op->va.range);
> +
> +	return panthor_vm_map_pages(vm, op->va.addr, prot, bo->dmap.sgt,
> +				    op->gem.offset, op->va.range);
> +}
>  
>  static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
>  {
> @@ -2141,9 +2244,7 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
>  
>  	panthor_vma_init(vma, op_ctx->flags & PANTHOR_VM_MAP_FLAGS);
>  
> -	ret = panthor_vm_map_pages(vm, op->map.va.addr, flags_to_prot(vma->flags),
> -				   op_ctx->map.bo->dmap.sgt, op->map.gem.offset,
> -				   op->map.va.range);
> +	ret = panthor_vm_exec_map_op(vm, vma->flags, &op->map);
>  	if (ret) {
>  		panthor_vm_op_ctx_return_vma(op_ctx, vma);
>  		return ret;
> @@ -2159,13 +2260,16 @@ static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
>  }
>  
>  static bool
> -iova_mapped_as_huge_page(struct drm_gpuva_op_map *op, u64 addr)
> +iova_mapped_as_huge_page(struct drm_gpuva_op_map *op, u64 addr, bool is_sparse)
>  {
>  	struct panthor_gem_object *bo = to_panthor_bo(op->gem.obj);
>  	const struct page *pg;
>  	pgoff_t bo_offset;
>  
> -	bo_offset = addr - op->va.addr + op->gem.offset;
> +	/* Per-VM Dummy BO in sparse mappings is always 2MiB, so checking the
> +	 * size of the very first page is enough.
> +	 */
> +	bo_offset = !is_sparse ? addr - op->va.addr + op->gem.offset : 0;
>  	pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
>  
>  	return folio_size(page_folio(pg)) >= SZ_2M;
> @@ -2175,6 +2279,8 @@ static void
>  unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
>  		     u64 *unmap_start, u64 *unmap_range)
>  {
> +	struct panthor_vma *unmap_vma = container_of(op->unmap->va, struct panthor_vma, base);
> +	bool is_sparse = unmap_vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
>  	u64 aligned_unmap_start, aligned_unmap_end, unmap_end;
>  
>  	unmap_end = *unmap_start + *unmap_range;
> @@ -2186,7 +2292,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
>  	 */
>  	if (op->prev && aligned_unmap_start < *unmap_start &&
>  	    op->prev->va.addr <= aligned_unmap_start &&
> -	    iova_mapped_as_huge_page(op->prev, *unmap_start)) {
> +	    (iova_mapped_as_huge_page(op->prev, *unmap_start, is_sparse))) {
>  		*unmap_range += *unmap_start - aligned_unmap_start;
>  		*unmap_start = aligned_unmap_start;
>  	}
> @@ -2196,7 +2302,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
>  	 */
>  	if (op->next && aligned_unmap_end > unmap_end &&
>  	    op->next->va.addr + op->next->va.range >= aligned_unmap_end &&
> -	    iova_mapped_as_huge_page(op->next, unmap_end - 1)) {
> +	    (iova_mapped_as_huge_page(op->next, *unmap_start, is_sparse))) {
                                                ^^^^^^^^^^^^
Shouldn't that still be (unmap_end - 1)?

Thanks,
Steve

>  		*unmap_range += aligned_unmap_end - unmap_end;
>  	}
>  }
> @@ -2231,15 +2337,27 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
>  		panthor_vm_unmap_pages(vm, unmap_start, unmap_range);
>  	}
>  
> +	/* In the following two branches, neither remap::unmap::offset nor remap::unmap::keep
> +	 * can be trusted to contain legitimate values in the case of sparse mappings, because
> +	 * the drm_gpuvm core calculates them on the assumption that a VM_BIND operation's
> +	 * range is always less than the target BO. That doesn't hold in the case of sparse
> +	 * bindings, but we don't care to adjust the BO offset of new VA's spawned by a remap
> +	 * operation because we ignore them altogether when sparse-mapping pages on a HW level
> +	 * just further below. If we ever wanted to make use of remap::unmap::keep, then this
> +	 * logic would have to be reworked.
> +	 */
>  	if (op->remap.prev) {
> -		struct panthor_gem_object *bo = to_panthor_bo(op->remap.prev->gem.obj);
>  		u64 offset = op->remap.prev->gem.offset + unmap_start - op->remap.prev->va.addr;
>  		u64 size = op->remap.prev->va.addr + op->remap.prev->va.range - unmap_start;
> +		const struct drm_gpuva_op_map map_op = {
> +			.va.addr = unmap_start,
> +			.va.range = size,
> +			.gem.obj = op->remap.prev->gem.obj,
> +			.gem.offset = offset,
> +		};
>  
> -		if (!unmap_vma->evicted) {
> -			ret = panthor_vm_map_pages(vm, unmap_start,
> -						   flags_to_prot(unmap_vma->flags),
> -						   bo->dmap.sgt, offset, size);
> +		if (!unmap_vma->evicted && size > 0) {
> +			ret = panthor_vm_exec_map_op(vm, unmap_vma->flags, &map_op);
>  			if (ret)
>  				return ret;
>  		}
> @@ -2250,14 +2368,17 @@ static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,
>  	}
>  
>  	if (op->remap.next) {
> -		struct panthor_gem_object *bo = to_panthor_bo(op->remap.next->gem.obj);
>  		u64 addr = op->remap.next->va.addr;
>  		u64 size = unmap_start + unmap_range - op->remap.next->va.addr;
> +		const struct drm_gpuva_op_map map_op = {
> +			.va.addr = addr,
> +			.va.range = size,
> +			.gem.obj = op->remap.next->gem.obj,
> +			.gem.offset = op->remap.next->gem.offset,
> +		};
>  
> -		if (!unmap_vma->evicted) {
> -			ret = panthor_vm_map_pages(vm, addr, flags_to_prot(unmap_vma->flags),
> -						   bo->dmap.sgt, op->remap.next->gem.offset,
> -						   size);
> +		if (!unmap_vma->evicted && size > 0) {
> +			ret = panthor_vm_exec_map_op(vm, unmap_vma->flags, &map_op);
>  			if (ret)
>  				return ret;
>  		}
> @@ -2817,7 +2938,13 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
>  
>  	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
> -		gem = drm_gem_object_lookup(file, op->bo_handle);
> +		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {
> +			gem = drm_gem_object_lookup(file, op->bo_handle);
> +		} else {
> +			gem = &vm->dummy->base;
> +			drm_gem_object_get(&vm->dummy->base);
> +		}
> +
>  		ret = panthor_vm_prepare_map_op_ctx(op_ctx, vm,
>  						    gem ? to_panthor_bo(gem) : NULL,
>  						    op);
> @@ -3025,6 +3152,9 @@ int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_object *bo
>  	struct panthor_vm_op_ctx op_ctx;
>  	int ret;
>  
> +	if (drm_WARN_ON(&vm->ptdev->base, flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE))
> +		return -EINVAL;
> +
>  	ret = panthor_vm_prepare_map_op_ctx(&op_ctx, vm, bo, &op);
>  	if (ret)
>  		return ret;
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_drm.h
> index 42c901ebdb7a..1490a2223766 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -614,6 +614,18 @@ enum drm_panthor_vm_bind_op_flags {
>  	 */
>  	DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED = 1 << 2,
>  
> +	/**
> +	 * @DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE: Sparsely map a virtual memory range
> +	 *
> +	 * Only valid with DRM_PANTHOR_VM_BIND_OP_TYPE_MAP.
> +	 *
> +	 * When this flag is set, the whole vm_bind range is mapped over a dummy object in a cyclic
> +	 * fashion, and all GPU reads from addresses in the range return undefined values. This flag
> +	 * being set means drm_panthor_vm_bind_op:offset and drm_panthor_vm_bind_op::handle must
> +	 * both be set to 0. DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC must also be set.
> +	 */
> +	DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE = 1 << 3,
> +
>  	/**
>  	 * @DRM_PANTHOR_VM_BIND_OP_TYPE_MASK: Mask used to determine the type of operation.
>  	 */

