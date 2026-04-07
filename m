Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC940FEEF29
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 12:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F2BA10E3FF;
	Tue,  7 Apr 2026 12:35:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="YqcAX3i/";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C6810E3FF
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 12:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775565300;
 bh=iodrvQIgdD9Kiayoen0QyBNrwMFuiRXp9NkqjF5NHD8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YqcAX3i/aar9ASfjEfKggiTHzH1RP8Pm1UHMB1qlWSVEWE7pWgPmS608ZS6PlaKcP
 Bet6uRuqrSGTalr8EUQ+txo2bVCbexkLtbcU+bcdliSMwDB44tgAfU5XR+or8dlyX6
 AgLZe8PHpzATdcpAKJ/J3VN4TQhK6TrqquT39lTQNQINjo6GKZ25/6yxeapcizbnNX
 X+RJKh6Noim38gIM2lU+w36+OvYTgH/NAoVpIhKD5q+5uGpzZgW2KXLv71FPrGC2xc
 mxzQz1Qn2/oVb+99zMAjjNOj0mUhaxxTJP4iwio1uyRP0P+k4gZ+M1ZGy4SBL1/fh6
 W0x5NH0noUWbg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CF68917E0FA3;
 Tue,  7 Apr 2026 14:34:59 +0200 (CEST)
Date: Tue, 7 Apr 2026 14:34:55 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v6 3/4] drm/panthor: Support sparse mappings
Message-ID: <20260407143455.5f71f5c7@fedora>
In-Reply-To: <20260403192743.3572062-4-adrian.larumbe@collabora.com>
References: <20260403192743.3572062-1-adrian.larumbe@collabora.com>
 <20260403192743.3572062-4-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Fri,  3 Apr 2026 20:27:28 +0100
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> Allow UM to bind sparsely populated memory regions by cyclically mapping
> virtual ranges over a set of zero-initialised dummy pages. This alternati=
ve
> is preferable to the old method of handling sparseness in the UMD, because
> it relied on the creation of a buffer object to the same end, despite the
> fact Vulkan sparse resources don't need to be backed by a driver BO.
>=20
> Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_mmu.c | 267 +++++++++++++++++++-------
>  include/uapi/drm/panthor_drm.h        |  13 +-
>  2 files changed, 206 insertions(+), 74 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pant=
hor/panthor_mmu.c
> index 10da2f021d9d..e73657aebfb0 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -104,6 +104,11 @@ struct panthor_mmu {
>  		/** @vm.wq: Workqueue used for the VM_BIND queues. */
>  		struct workqueue_struct *wq;
>  	} vm;
> +
> +	struct {
> +		struct page *pages;
> +		struct sg_table *sgt;
> +	} dummy;
>  };
> =20
>  /**
> @@ -1028,6 +1033,34 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 io=
va, int prot,
>  	return 0;
>  }
> =20
> +static int
> +panthor_vm_repeated_map_pages(struct panthor_vm *vm, u64 iova, int prot,
> +			      struct sg_table *sgt, u64 size)

s/panthor_vm_repeated_map_pages/panthor_vm_map_sparse/

and you don't have to pass the sgt (can be retrieved from
vm->ptdev->mmu->dummy.sgt).

> +{
> +	u64 first_iova =3D iova;
> +	u64 first_size =3D size;
> +	int ret;
> +
> +	/* FIXME: we really need to optimize this at the io_pgtable level. */

Maybe turn that into a TODO, since that's not really a bug, and lower
down the "we really need to" into "we should probably".

> +	while (size > 0) {
> +		u64 next_size =3D min(size, sgt->sgl->length);
> +
> +		ret =3D panthor_vm_map_pages(vm, iova, prot,
> +					   sgt, 0, next_size);
> +		if (ret)
> +			goto err_unmap;
> +
> +		size -=3D next_size;
> +		iova +=3D next_size;
> +	}
> +
> +	return 0;
> +
> +err_unmap:
> +	panthor_vm_unmap_pages(vm, first_iova, first_size - size);
> +	return ret;
> +}
> +
>  static int flags_to_prot(u32 flags)
>  {
>  	int prot =3D 0;
> @@ -1270,6 +1303,7 @@ static int panthor_vm_op_ctx_prealloc_pts(struct pa=
nthor_vm_op_ctx *op_ctx)
>  	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
>  	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
>  	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED | \
> +	 DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE | \
>  	 DRM_PANTHOR_VM_BIND_OP_TYPE_MASK)
> =20
>  static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ct=
x,
> @@ -1277,74 +1311,87 @@ static int panthor_vm_prepare_map_op_ctx(struct p=
anthor_vm_op_ctx *op_ctx,
>  					 struct panthor_gem_object *bo,
>  					 const struct drm_panthor_vm_bind_op *op)
>  {
> +	bool is_sparse =3D op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
>  	struct drm_gpuvm_bo *preallocated_vm_bo;
>  	struct sg_table *sgt =3D NULL;
>  	int ret;
> =20
> -	if (!bo)
> -		return -EINVAL;
> -
>  	if ((op->flags & ~PANTHOR_VM_BIND_OP_MAP_FLAGS) ||
>  	    (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) !=3D DRM_PANTHOR_VM_=
BIND_OP_TYPE_MAP)
>  		return -EINVAL;
> =20
> -	/* Make sure the VA and size are in-bounds. */
> -	if (op->size > bo->base.size || op->bo_offset > bo->base.size - op->siz=
e)
> -		return -EINVAL;
> +	if (!is_sparse) {
> +		/* Make sure the VA and size are in-bounds. */
> +		if (!bo || op->size > bo->base.size ||
> +		    op->bo_offset > bo->base.size - op->size)
> +			return -EINVAL;
> +	} else {
> +		if (bo || op->bo_handle || op->bo_offset)

The bo !=3D NULL check seems redundant: if bo_handle is zero, the BO will
always be NULL. nit: I'd probably also probably combine the else+if
into an else-if:

	} else if (op->bo_handle || op->bo_offset) {

		return -EINVAL;

> +			return -EINVAL;
> +	}


> =20
>  	/* If the BO has an exclusive VM attached, it can't be mapped to other =
VMs. */
> -	if (bo->exclusive_vm_root_gem &&
> +	if (!is_sparse && bo->exclusive_vm_root_gem &&

Let's go for bo !=3D NULL checks instead:

	if (bo && bo->exclusive_vm_root_gem !=3D panthor_vm_root_gem(vm))


>  	    bo->exclusive_vm_root_gem !=3D panthor_vm_root_gem(vm))
>  		return -EINVAL;
> =20
> -	panthor_vm_init_op_ctx(op_ctx, op->size, op->va, op->flags);
> +	panthor_vm_init_op_ctx(op_ctx, op->size, op->va, op->flags
> +			       | ((is_sparse) ? DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC : 0));
> =20
>  	ret =3D panthor_vm_op_ctx_prealloc_vmas(op_ctx);
>  	if (ret)
>  		goto err_cleanup;
> =20
> -	/* Pre-reserve the BO pages, so the map operation doesn't have to
> -	 * allocate.
> -	 */
> -	ret =3D panthor_gem_pin(bo);
> -	if (ret)
> -		goto err_cleanup;
> +	if (!is_sparse) {

Same here, I'd go for

	if (bo) {

> +		/* Pre-reserve the BO pages, so the map operation doesn't have to
> +		 * allocate.
> +		 */
> +		ret =3D panthor_gem_pin(bo);
> +		if (ret)
> +			goto err_cleanup;
> =20
> -	drm_gem_object_get(&bo->base);
> -	op_ctx->map.bo =3D bo;
> +		drm_gem_object_get(&bo->base);
> +		op_ctx->map.bo =3D bo;
> =20
> -	sgt =3D panthor_gem_get_dev_sgt(bo);
> -	if (IS_ERR(sgt)) {
> -		ret =3D PTR_ERR(sgt);
> -		goto err_cleanup;
> -	}
> +		sgt =3D panthor_gem_get_dev_sgt(bo);
> +		if (IS_ERR(sgt)) {
> +			ret =3D PTR_ERR(sgt);
> +			goto err_cleanup;
> +		}
> +		op_ctx->map.sgt =3D sgt;
> =20
> -	preallocated_vm_bo =3D drm_gpuvm_bo_create(&vm->base, &bo->base);
> -	if (!preallocated_vm_bo) {
> -		ret =3D -ENOMEM;
> -		goto err_cleanup;
> -	}
> +		preallocated_vm_bo =3D drm_gpuvm_bo_create(&vm->base, &bo->base);
> +		if (!preallocated_vm_bo) {
> +			ret =3D -ENOMEM;
> +			goto err_cleanup;
> +		}
> =20
> -	op_ctx->map.vm_bo =3D drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
> -	op_ctx->map.bo_offset =3D op->bo_offset;
> +		op_ctx->map.vm_bo =3D
> +			drm_gpuvm_bo_obtain_prealloc(preallocated_vm_bo);
> +		op_ctx->map.bo_offset =3D op->bo_offset;
> +	}  else {
> +		op_ctx->map.sgt =3D vm->ptdev->mmu->dummy.sgt;

I don't think we need to initialize the sgt field in that case, the
dummy page sgt can be retrieved from the vm in panthor_vm_map_sparse().

> +	}
> =20
>  	ret =3D panthor_vm_op_ctx_prealloc_pts(op_ctx);
>  	if (ret)
>  		goto err_cleanup;
> =20
> -	/* Insert BO into the extobj list last, when we know nothing can fail. =
*/
> -	if (bo->base.resv !=3D panthor_vm_resv(vm)) {
> -		dma_resv_lock(panthor_vm_resv(vm), NULL);
> -		drm_gpuvm_bo_extobj_add(op_ctx->map.vm_bo);
> -		dma_resv_unlock(panthor_vm_resv(vm));
> -	}
> +	if (!is_sparse) {
> +		/* Insert BO into the extobj list last, when we know nothing can fail.=
 */
> +		if (bo->base.resv !=3D panthor_vm_resv(vm)) {

	if (bo && bo->base.resv !=3D panthor_vm_resv(vm)) {

> +			dma_resv_lock(panthor_vm_resv(vm), NULL);
> +			drm_gpuvm_bo_extobj_add(op_ctx->map.vm_bo);
> +			dma_resv_unlock(panthor_vm_resv(vm));
> +		}
> =20
> -	/* And finally update the BO state. */
> -	dma_resv_lock(bo->base.resv, NULL);
> -	mutex_lock(&bo->base.gpuva.lock);
> -	panthor_gem_update_reclaim_state_locked(bo, NULL);
> -	mutex_unlock(&bo->base.gpuva.lock);
> -	dma_resv_unlock(bo->base.resv);
> +		/* And finally update the BO state. */
> +		dma_resv_lock(bo->base.resv, NULL);
> +		mutex_lock(&bo->base.gpuva.lock);
> +		panthor_gem_update_reclaim_state_locked(bo, NULL);
> +		mutex_unlock(&bo->base.gpuva.lock);
> +		dma_resv_unlock(bo->base.resv);
> +	}
> =20
>  	return 0;
> =20
> @@ -2148,13 +2195,43 @@ static void panthor_vma_init(struct panthor_vma *=
vma, u32 flags)
>  #define PANTHOR_VM_MAP_FLAGS \
>  	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
>  	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
> -	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED)
> +	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED | \
> +	 DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
> +
> +static int
> +panthor_vm_map(struct panthor_vm *vm, bool sparse, struct sg_table *sgt,
> +	       u64 addr, u64 offset, u64 size, int prot)
> +{
> +	int ret;
> +
> +	if (!size)
> +		return 0;
> +
> +	if (!sparse)
> +		return panthor_vm_map_pages(vm, addr, prot, sgt, offset, size);
> +
> +	drm_WARN_ON(&vm->ptdev->base, sgt->sgl->length !=3D SZ_2M);
> +
> +	if (addr & (SZ_2M - 1)) {
> +		u64 unaligned_size =3D min(ALIGN(addr, SZ_2M) - addr, size);
> +
> +		ret =3D panthor_vm_map_pages(vm, addr, prot, sgt,
> +					   0, unaligned_size);
> +		if (ret)
> +			return ret;
> +
> +		size -=3D unaligned_size;
> +	}
> +
> +	return panthor_vm_repeated_map_pages(vm, addr, prot, sgt, size);
> +}

How about:

static int
panthor_vm_exec_map_op(struct panthor_vm *vm,
		       const struct panthor_vm_op_ctx *op_ctx,
		       const struct drm_gpuva_op_map *op)
{
	bool is_sparse =3D op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;

	if (!op->va.range)
		return 0;

	if (op_ctx->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE) {
		// Do the manual 2M alignment in panthor_vm_map_sparse()
		return panthor_vm_map_sparse(vm, op->va.addr,
					     flags_to_prot(op_ctx->flags),
					     op->va.range);
	}

	return panthor_vm_map_pages(vm, op->va.addr,
				    flags_to_prot(op_ctx->flags),
				    op_ctx->map.sgt,
				    op->map.gem.offset, op->va.range);
}

> =20
>  static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *priv)
>  {
>  	struct panthor_vm *vm =3D priv;
>  	struct panthor_vm_op_ctx *op_ctx =3D vm->op_ctx;
>  	struct panthor_vma *vma =3D panthor_vm_op_ctx_get_vma(op_ctx);
> +	bool is_sparse =3D op_ctx->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
>  	int ret;
> =20
>  	if (!vma)
> @@ -2162,19 +2239,20 @@ static int panthor_gpuva_sm_step_map(struct drm_g=
puva_op *op, void *priv)
> =20
>  	panthor_vma_init(vma, op_ctx->flags & PANTHOR_VM_MAP_FLAGS);
> =20
> -	ret =3D panthor_vm_map_pages(vm, op->map.va.addr, flags_to_prot(vma->fl=
ags),
> -				   op_ctx->map.bo->dmap.sgt, op->map.gem.offset,
> -				   op->map.va.range);
> +	ret =3D panthor_vm_map(vm, is_sparse, op_ctx->map.sgt, op->map.va.addr,
> +			     op->map.gem.offset, op->map.va.range, flags_to_prot(vma->flags));
>  	if (ret) {
>  		panthor_vm_op_ctx_return_vma(op_ctx, vma);
>  		return ret;
>  	}
> =20
>  	drm_gpuva_map(&vm->base, &vma->base, &op->map);
> -	panthor_vma_link(vm, vma, op_ctx->map.vm_bo);
> =20
> -	drm_gpuvm_bo_put_deferred(op_ctx->map.vm_bo);
> -	op_ctx->map.vm_bo =3D NULL;
> +	if (!is_sparse) {

	if (op_ctx->map.vm_bo) {

> +		panthor_vma_link(vm, vma, op_ctx->map.vm_bo);
> +		drm_gpuvm_bo_put_deferred(op_ctx->map.vm_bo);
> +		op_ctx->map.vm_bo =3D NULL;
> +	}
> =20
>  	return 0;
>  }
> @@ -2194,7 +2272,7 @@ iova_mapped_as_huge_page(struct drm_gpuva_op_map *o=
p, u64 addr)
> =20
>  static void
>  unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
> -		     u64 *unmap_start, u64 *unmap_range)
> +		     u64 *unmap_start, u64 *unmap_range, bool sparse)

You can probably get the unmap_vma out of the remap op, and extract the
is_sparse info from there. If we decide to keep it as an extra
argument, I would call it 'unmapped_vma_is_sparse'.

>  {
>  	u64 aligned_unmap_start, aligned_unmap_end, unmap_end;
> =20
> @@ -2207,7 +2285,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_rema=
p *op,
>  	 */
>  	if (op->prev && aligned_unmap_start < *unmap_start &&
>  	    op->prev->va.addr <=3D aligned_unmap_start &&
> -	    iova_mapped_as_huge_page(op->prev, *unmap_start)) {
> +	    (sparse || iova_mapped_as_huge_page(op->prev, *unmap_start))) {
>  		*unmap_range +=3D *unmap_start - aligned_unmap_start;
>  		*unmap_start =3D aligned_unmap_start;
>  	}
> @@ -2217,7 +2295,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_rema=
p *op,
>  	 */
>  	if (op->next && aligned_unmap_end > unmap_end &&
>  	    op->next->va.addr + op->next->va.range >=3D aligned_unmap_end &&
> -	    iova_mapped_as_huge_page(op->next, unmap_end - 1)) {
> +	    (sparse || iova_mapped_as_huge_page(op->next, *unmap_start))) {
>  		*unmap_range +=3D aligned_unmap_end - unmap_end;
>  	}
>  }
> @@ -2229,6 +2307,8 @@ static int panthor_gpuva_sm_step_remap(struct drm_g=
puva_op *op,
>  	struct panthor_vm *vm =3D priv;
>  	struct panthor_vm_op_ctx *op_ctx =3D vm->op_ctx;
>  	struct panthor_vma *prev_vma =3D NULL, *next_vma =3D NULL;
> +	struct sg_table *sgt =3D vm->ptdev->mmu->dummy.sgt;
> +	bool is_sparse =3D unmap_vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
>  	u64 unmap_start, unmap_range;
>  	int ret;
> =20
> @@ -2241,7 +2321,7 @@ static int panthor_gpuva_sm_step_remap(struct drm_g=
puva_op *op,
>  	 * unmap region. Calculating the right start address and range for the =
expanded
>  	 * unmap operation is the responsibility of the following function.
>  	 */
> -	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range);
> +	unmap_hugepage_align(&op->remap, &unmap_start, &unmap_range, is_sparse);
> =20
>  	/* If the range changed, we might have to lock a wider region to guaran=
tee
>  	 * atomicity. panthor_vm_lock_region() bails out early if the new region
> @@ -2253,14 +2333,15 @@ static int panthor_gpuva_sm_step_remap(struct drm=
_gpuva_op *op,
>  	}
> =20
>  	if (op->remap.prev) {
> -		struct panthor_gem_object *bo =3D to_panthor_bo(op->remap.prev->gem.ob=
j);
>  		u64 offset =3D op->remap.prev->gem.offset + unmap_start - op->remap.pr=
ev->va.addr;
>  		u64 size =3D op->remap.prev->va.addr + op->remap.prev->va.range - unma=
p_start;
> =20
> +		if (!is_sparse)

		if (op->remap.prev->gem.obj)

> +			sgt =3D to_panthor_bo(op->remap.prev->gem.obj)->dmap.sgt;
> +
>  		if (!unmap_vma->evicted) {
> -			ret =3D panthor_vm_map_pages(vm, unmap_start,
> -						   flags_to_prot(unmap_vma->flags),
> -						   bo->dmap.sgt, offset, size);
> +			ret =3D panthor_vm_map(vm, is_sparse, sgt, unmap_start, offset,
> +					     size, flags_to_prot(unmap_vma->flags));
>  			if (ret)
>  				return ret;
>  		}
> @@ -2271,14 +2352,16 @@ static int panthor_gpuva_sm_step_remap(struct drm=
_gpuva_op *op,
>  	}
> =20
>  	if (op->remap.next) {
> -		struct panthor_gem_object *bo =3D to_panthor_bo(op->remap.next->gem.ob=
j);
>  		u64 addr =3D op->remap.next->va.addr;
>  		u64 size =3D unmap_start + unmap_range - op->remap.next->va.addr;
> =20
> +		if (!is_sparse)

		if (op->remap.next->gem.obj)

> +			sgt =3D to_panthor_bo(op->remap.next->gem.obj)->dmap.sgt;
> +
>  		if (!unmap_vma->evicted) {
> -			ret =3D panthor_vm_map_pages(vm, addr, flags_to_prot(unmap_vma->flags=
),
> -						   bo->dmap.sgt, op->remap.next->gem.offset,
> -						   size);
> +			ret =3D panthor_vm_map(vm, is_sparse, sgt, addr,
> +					     op->remap.next->gem.offset, size,
> +					     flags_to_prot(unmap_vma->flags));
>  			if (ret)
>  				return ret;
>  		}
> @@ -2292,20 +2375,22 @@ static int panthor_gpuva_sm_step_remap(struct drm=
_gpuva_op *op,
>  			next_vma ? &next_vma->base : NULL,
>  			&op->remap);
> =20
> -	if (prev_vma) {
> -		/* panthor_vma_link() transfers the vm_bo ownership to
> -		 * the VMA object. Since the vm_bo we're passing is still
> -		 * owned by the old mapping which will be released when this
> -		 * mapping is destroyed, we need to grab a ref here.
> -		 */
> -		panthor_vma_link(vm, prev_vma, op->remap.unmap->va->vm_bo);
> -	}
> +	if (!is_sparse) {

	if (op->remap.unmap->va->vm_bo) {

> +		if (prev_vma) {
> +			/* panthor_vma_link() transfers the vm_bo ownership to
> +			 * the VMA object. Since the vm_bo we're passing is still
> +			 * owned by the old mapping which will be released when this
> +			 * mapping is destroyed, we need to grab a ref here.
> +			 */
> +			panthor_vma_link(vm, prev_vma, op->remap.unmap->va->vm_bo);
> +		}
> +
> +		if (next_vma)
> +			panthor_vma_link(vm, next_vma, op->remap.unmap->va->vm_bo);
> =20
> -	if (next_vma) {
> -		panthor_vma_link(vm, next_vma, op->remap.unmap->va->vm_bo);
> +		panthor_vma_unlink(unmap_vma);
>  	}
> =20
> -	panthor_vma_unlink(unmap_vma);
>  	return 0;
>  }
> =20
> @@ -2579,11 +2664,9 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct p=
anthor_vm_op_ctx *op,
> =20
>  	switch (op_type) {
>  	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP: {
> -		const struct drm_gpuvm_map_req map_req =3D {
> +		struct drm_gpuvm_map_req map_req =3D {
>  			.map.va.addr =3D op->va.addr,
>  			.map.va.range =3D op->va.range,
> -			.map.gem.obj =3D op->map.vm_bo->obj,
> -			.map.gem.offset =3D op->map.bo_offset,
>  		};
> =20
>  		if (vm->unusable) {
> @@ -2591,6 +2674,11 @@ panthor_vm_exec_op(struct panthor_vm *vm, struct p=
anthor_vm_op_ctx *op,
>  			break;
>  		}
> =20
> +		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {
> +			map_req.map.gem.obj =3D op->map.vm_bo->obj;
> +			map_req.map.gem.offset =3D op->map.bo_offset;
> +		}
> +
>  		ret =3D drm_gpuvm_sm_map(&vm->base, vm, &map_req);
>  		break;
>  	}
> @@ -3041,6 +3129,9 @@ int panthor_vm_map_bo_range(struct panthor_vm *vm, =
struct panthor_gem_object *bo
>  	struct panthor_vm_op_ctx op_ctx;
>  	int ret;
> =20
> +	if (drm_WARN_ON(&vm->ptdev->base, flags & DRM_PANTHOR_VM_BIND_OP_MAP_SP=
ARSE))
> +		return -EINVAL;
> +
>  	op =3D (struct drm_panthor_vm_bind_op){
>  		.bo_offset =3D offset,
>  		.size =3D size,
> @@ -3204,6 +3295,10 @@ void panthor_mmu_unplug(struct panthor_device *ptd=
ev)
>  		}
>  	}
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
> +
> +	sg_free_table(ptdev->mmu->dummy.sgt);
> +	kfree(ptdev->mmu->dummy.sgt);
> +	__free_pages(ptdev->mmu->dummy.pages, get_order(SZ_2M));

We can probably replace this by drmm_actions so the dummy pages and
sgt gets automatically freed when the DRM device vanishes and you don't
have to duplicate the logic in the unplug and panthor_mmu_init error
path.

>  }
> =20
>  static void panthor_mmu_release_wq(struct drm_device *ddev, void *res)
> @@ -3269,7 +3364,33 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  		ptdev->gpu_info.mmu_features |=3D BITS_PER_LONG;
>  	}
> =20
> +	mmu->dummy.pages =3D alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(SZ_=
2M));
> +	if (!mmu->dummy.pages)
> +		return -ENOMEM;

We should probably allocate this page on-demand, so that systems that
never use sparse bindings don't pay the 2M cost. Also, we might want a
fallback to use 4k pages in case the 2M page allocation fails.

> +
> +	mmu->dummy.sgt =3D kzalloc_obj(*mmu->dummy.sgt);
> +	if (!mmu->dummy.sgt) {
> +		ret =3D -ENOMEM;
> +		goto mmu_init_free_pages;
> +	}
> +
> +	ret =3D sg_alloc_table(mmu->dummy.sgt, 1, GFP_KERNEL);
> +	if (ret) {
> +		ret =3D -ENOMEM;
> +		goto mmu_init_free_sgtable;
> +	}
> +
> +	sg_set_page(mmu->dummy.sgt->sgl, mmu->dummy.pages, SZ_2M, 0);
> +	sg_dma_address(mmu->dummy.sgt->sgl) =3D page_to_phys(mmu->dummy.pages);
> +	sg_dma_len(mmu->dummy.sgt->sgl) =3D SZ_2M;

Let's use drm_prime_pages_to_sg() instead of open-coding it:

	mmu->dummy.sgt =3D drm_prime_pages_to_sg(&ptdev->base,
					       &mmu->dummy.pages, 1);
	if (IS_ERR(mmu->dummy.sgt))
		...


> +
>  	return drmm_add_action_or_reset(&ptdev->base, panthor_mmu_release_wq, m=
mu->vm.wq);
> +
> +mmu_init_free_sgtable:
> +	kfree(mmu->dummy.sgt);
> +mmu_init_free_pages:
> +	__free_pages(mmu->dummy.pages, get_order(SZ_2M));
> +	return ret;
>  }
> =20
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/include/uapi/drm/panthor_drm.h b/include/uapi/drm/panthor_dr=
m.h
> index dc2704fc2829..9e7197845ea4 100644
> --- a/include/uapi/drm/panthor_drm.h
> +++ b/include/uapi/drm/panthor_drm.h
> @@ -614,6 +614,18 @@ enum drm_panthor_vm_bind_op_flags {
>  	 */
>  	DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED =3D 1 << 2,
> =20
> +	/**
> +	 * @DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE: Repeat a BO range
> +	 *
> +	 * Only valid with DRM_PANTHOR_VM_BIND_OP_TYPE_MAP.
> +	 *
> +	 * When this flag is set, the whole vm_bind range is mapped over a dummy
> +	 * object in a cyclic fashion, and all GPU reads from the addresses in =
the
> +	 * range return 0.

Nope, reads return undefined values and writes hit the dummy page (hence
the undefined value on reads). This makes me realize we probably don't
want to make the dummy page global (shared across processes), because
that's a potential source of data leak.

>	This flag being set means drm_panthor_vm_bind_op:offset
> +	 * and drm_panthor_vm_bind_op::handle must both be set to 0.
> +	 */
> +	DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE =3D 1 << 3,
> +
>  	/**
>  	 * @DRM_PANTHOR_VM_BIND_OP_TYPE_MASK: Mask used to determine the type o=
f operation.
>  	 */
> @@ -677,7 +689,6 @@ struct drm_panthor_vm_bind_op {
>  	 * This array shall not be empty for sync-only operations.
>  	 */
>  	struct drm_panthor_obj_array syncs;
> -

Looks like an unrelated change that should be in its own commit.

>  };
> =20
>  /**

