Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBA1FF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:57:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 741D810F2DA;
	Thu, 30 Apr 2026 09:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="GXF2QJXt";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5FCB10F2DA
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777543053;
 bh=EqostS1TuX39neZTb8ma99XfpqP8c9WzR/lTLDW4rFo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=GXF2QJXtEjMv9e8Jklg27IFvpiOSSTQyr0/pD8WHcPBcYTs2XtVG6/iITM3dKJ89L
 EeaDDWjwCkNA77zfx+zQmAFTX6ygVT34zWwkuRIOnCZeRTCWizh5XiSfzstqpQnW+4
 9P1gCx9I+tLdAwWWxQdpuUzhgrVwuTcWQlJ834EFt6Q7vBEUmoWFywrdachmGFRZrc
 gGgoyJV0QYda6RYo0gRWeoKWe4e6LVzqo3NcQ4RZkg80vhh+8j30mt9Vc5nV4K0yw9
 1q/sibxGVR1Lj6AIwBGHm6oNoe8b3YpFhX+iIs7UEM5hTo+B5g44hn9/elyxpU7/Aj
 Msrdu269WicAw==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DCA8417E0EBB;
 Thu, 30 Apr 2026 11:57:32 +0200 (CEST)
Date: Thu, 30 Apr 2026 11:57:27 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Steven
 Price <steven.price@arm.com>, kernel@collabora.com, Liviu Dudau
 <liviu.dudau@arm.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v10 5/6] drm/panthor: Support sparse mappings
Message-ID: <20260430115727.054d06c6@fedora>
In-Reply-To: <20260430095734.28bc98cf@fedora>
References: <20260429183253.66422-1-adrian.larumbe@collabora.com>
 <20260429183253.66422-6-adrian.larumbe@collabora.com>
 <20260430095734.28bc98cf@fedora>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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

On Thu, 30 Apr 2026 09:57:34 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Wed, 29 Apr 2026 19:32:17 +0100
> Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:
>=20
> > Allow UM to bind sparsely populated memory regions by cyclically mapping
> > virtual ranges over a kernel-allocated dummy BO. This alternative is
> > preferable to the old method of handling sparseness in the UMD, because=
 it
> > relied on the creation of a buffer object to the same end, despite the =
fact
> > Vulkan sparse resources don't need to be backed by a driver BO.
> >=20
> > The choice of backing sparsely-bound regions with a Panhtor BO was made=
 so
> > as to profit from the existing shrinker reclaim code. That way no speci=
al
> > treatment must be given to the dummy sparse BOs when reclaiming memory,=
 as
> > would be the case if we had chosen a raw kernel page implementation.
> >=20
> > A new dummy BO is allocated per open file context, because even though =
the
> > Vulkan spec mandates that writes into sparsely bound regions must be
> > discarded, our implementation is still a workaround over the fact Mali =
CSF
> > GPUs cannot support this behaviour on the hardware level, so writes sti=
ll
> > make it into the backing BO. If we had a global one, then it could be a
> > venue for information leaks between file contexts, which should never
> > happen in DRM.
> >=20
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
> > ---
> >  drivers/gpu/drm/panthor/panthor_gem.c |  18 +++
> >  drivers/gpu/drm/panthor/panthor_gem.h |   2 +
> >  drivers/gpu/drm/panthor/panthor_mmu.c | 159 ++++++++++++++++++++++----
> >  include/uapi/drm/panthor_drm.h        |  12 ++
> >  4 files changed, 170 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/pa=
nthor/panthor_gem.c
> > index 13295d7a593d..c798ac2963e1 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gem.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gem.c
> > @@ -1345,6 +1345,24 @@ panthor_kernel_bo_create(struct panthor_device *=
ptdev, struct panthor_vm *vm,
> >  	return ERR_PTR(ret);
> >  }
> > =20
> > +/**
> > + * panthor_dummy_bo_create() - Create a Panthor BO meant to back spars=
e bindings.
> > + * @ptdev: Device.
> > + *
> > + * Return: A valid pointer in case of success, an ERR_PTR() otherwise.
> > + */
> > +struct panthor_gem_object *
> > +panthor_dummy_bo_create(struct panthor_device *ptdev)
> > +{
> > +	/* Since even when the DRM device's mount point has enabled THP we ha=
ve no guarantee
> > +	 * that drm_gem_get_pages() will return a single 2MiB PMD, and also w=
e cannot be sure
> > +	 * that the 2MiB won't be reclaimed and re-allocated later on as 4KiB=
 chunks, it doesn't
> > +	 * make sense to pre-populate this object's page array, nor to fall b=
ack on a BO size
> > +	 * of 4KiB. Sticking to a dummy object size of 2MiB lets us keep thin=
gs simple for now.
> > +	 */
> > +	return panthor_gem_create(&ptdev->base, SZ_2M, DRM_PANTHOR_BO_NO_MMAP=
, NULL, 0);
> > +}
> > +
> >  static bool can_swap(void)
> >  {
> >  	return get_nr_swap_pages() > 0;
> > diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/pa=
nthor/panthor_gem.h
> > index ae0491d0b121..8639c2fa08e6 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gem.h
> > +++ b/drivers/gpu/drm/panthor/panthor_gem.h
> > @@ -315,6 +315,8 @@ panthor_kernel_bo_create(struct panthor_device *ptd=
ev, struct panthor_vm *vm,
> > =20
> >  void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo);
> > =20
> > +struct panthor_gem_object *panthor_dummy_bo_create(struct panthor_devi=
ce *ptdev);
> > +
> >  #ifdef CONFIG_DEBUG_FS
> >  void panthor_gem_debugfs_init(struct drm_minor *minor);
> >  #endif
> > diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pa=
nthor/panthor_mmu.c
> > index f54a60cd0ec4..9257afd6adc9 100644
> > --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> > @@ -112,6 +112,17 @@ struct panthor_mmu {
> >  struct panthor_vm_pool {
> >  	/** @xa: Array used for VM handle tracking. */
> >  	struct xarray xa;
> > +
> > +	/**
> > +	 * @dummy: Dummy object used for sparse mappings
> > +	 *
> > +	 * Sparse bindings map virtual address ranges onto a dummy
> > +	 * BO in a modulo fashion. Even though sparse writes are meant
> > +	 * to be discarded and reads undefined, writes are still reflected
> > +	 * in the dummy buffer. That means we must keep a dummy object per
> > +	 * file context, to avoid data leaks between them.
> > +	 */
> > +	struct panthor_gem_object *dummy;
> >  };
> > =20
> >  /**
> > @@ -391,6 +402,16 @@ struct panthor_vm {
> >  		 */
> >  		struct list_head lru_node;
> >  	} reclaim;
> > +
> > +	/**
> > +	 * @dummy: Dummy object used for sparse mappings.
> > +	 *
> > +	 * VM's must keep a reference to the file context-wide dummy BO becau=
se
> > +	 * they can outlive the file context, which includes the VM pool hold=
ing
> > +	 * the original dummy BO reference.
> > +	 * =20
>=20
> nit: Drop the extra blank line.
>=20
> > +	 */
> > +	struct panthor_gem_object *dummy;
> >  };
> > =20
> >  /**
> > @@ -1020,6 +1041,30 @@ panthor_vm_map_pages(struct panthor_vm *vm, u64 =
iova, int prot,
> >  	return 0;
> >  }
> > =20
> > +static int
> > +panthor_vm_map_sparse(struct panthor_vm *vm, u64 iova, int prot,
> > +		      struct sg_table *sgt, u64 size)
> > +{
> > +	u64 mapped =3D 0;
> > +	int ret;
> > +
> > +	while (mapped < size) {
> > +		u64 addr =3D iova + mapped;
> > +		u32 chunk_size =3D min(size - mapped, SZ_2M - (addr & (SZ_2M - 1)));
> > +
> > +		ret =3D panthor_vm_map_pages(vm, addr, prot,
> > +					   sgt, 0, chunk_size);
> > +		if (ret) {
> > +			panthor_vm_unmap_pages(vm, iova, mapped);
> > +			return ret;
> > +		}
> > +
> > +		mapped +=3D chunk_size;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int flags_to_prot(u32 flags)
> >  {
> >  	int prot =3D 0;
> > @@ -1262,6 +1307,7 @@ static int panthor_vm_op_ctx_prealloc_pts(struct =
panthor_vm_op_ctx *op_ctx)
> >  	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
> >  	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
> >  	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED | \
> > +	 DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE | \
> >  	 DRM_PANTHOR_VM_BIND_OP_TYPE_MASK)
> > =20
> >  static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_=
ctx,
> > @@ -1269,6 +1315,7 @@ static int panthor_vm_prepare_map_op_ctx(struct p=
anthor_vm_op_ctx *op_ctx,
> >  					 struct panthor_gem_object *bo,
> >  					 const struct drm_panthor_vm_bind_op *op)
> >  {
> > +	bool is_sparse =3D op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
> >  	struct drm_gpuvm_bo *preallocated_vm_bo;
> >  	struct sg_table *sgt =3D NULL;
> >  	int ret;
> > @@ -1280,8 +1327,21 @@ static int panthor_vm_prepare_map_op_ctx(struct =
panthor_vm_op_ctx *op_ctx,
> >  	    (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) !=3D DRM_PANTHOR_V=
M_BIND_OP_TYPE_MAP)
> >  		return -EINVAL;
> > =20
> > -	/* Make sure the VA and size are in-bounds. */
> > -	if (op->size > bo->base.size || op->bo_offset > bo->base.size - op->s=
ize)
> > +	/* uAPI mandates sparsely bound regions must not be executable. */
> > +	if (is_sparse && !(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC))
> > +		return -EINVAL;
> > +
> > +	/* For non-sparse, make sure the VA and size are in-bounds.
> > +	 * For sparse, this is not applicable, because the dummy BO is
> > +	 * repeatedly mapped over a potentially wider VA range.
> > +	 */
> > +	if (!is_sparse && (op->size > bo->base.size || op->bo_offset > bo->ba=
se.size - op->size))
> > +		return -EINVAL;
> > +
> > +	/* For sparse, we don't expect any user BO, the BO we get passed
> > +	 * is the dummy BO attached to the VM pool.
> > +	 */
> > +	if (is_sparse && (op->bo_handle || op->bo_offset))
> >  		return -EINVAL;
> > =20
> >  	/* If the BO has an exclusive VM attached, it can't be mapped to othe=
r VMs. */
> > @@ -1543,6 +1603,9 @@ int panthor_vm_pool_create_vm(struct panthor_devi=
ce *ptdev,
> >  		return ret;
> >  	}
> > =20
> > +	drm_gem_object_get(&pool->dummy->base);
> > +	vm->dummy =3D pool->dummy;
> > +
> >  	args->user_va_range =3D kernel_va_start;
> >  	return id;
> >  }
> > @@ -1634,6 +1697,7 @@ void panthor_vm_pool_destroy(struct panthor_file =
*pfile)
> >  	xa_for_each(&pfile->vms->xa, i, vm)
> >  		panthor_vm_destroy(vm);
> > =20
> > +	drm_gem_object_put(&pfile->vms->dummy->base);
> >  	xa_destroy(&pfile->vms->xa);
> >  	kfree(pfile->vms);
> >  }
> > @@ -1651,6 +1715,13 @@ int panthor_vm_pool_create(struct panthor_file *=
pfile)
> >  		return -ENOMEM;
> > =20
> >  	xa_init_flags(&pfile->vms->xa, XA_FLAGS_ALLOC1);
> > +
> > +	pfile->vms->dummy =3D panthor_dummy_bo_create(pfile->ptdev);
> > +	if (IS_ERR(pfile->vms->dummy)) {
> > +		kfree(pfile->vms);
> > +		return PTR_ERR(pfile->vms->dummy);
> > +	}
> > +
> >  	return 0;
> >  }
> > =20
> > @@ -1987,6 +2058,9 @@ static void panthor_vm_free(struct drm_gpuvm *gpu=
vm)
> > =20
> >  	free_io_pgtable_ops(vm->pgtbl_ops);
> > =20
> > +	if (vm->dummy)
> > +		drm_gem_object_put(&vm->dummy->base);
> > +
> >  	drm_mm_takedown(&vm->mm);
> >  	kfree(vm);
> >  }
> > @@ -2146,7 +2220,23 @@ static void panthor_vma_init(struct panthor_vma =
*vma, u32 flags)
> >  #define PANTHOR_VM_MAP_FLAGS \
> >  	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
> >  	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
> > -	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED)
> > +	 DRM_PANTHOR_VM_BIND_OP_MAP_UNCACHED | \
> > +	 DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
> > +
> > +static int
> > +panthor_vm_exec_map_op(struct panthor_vm *vm, u32 flags,
> > +		       const struct drm_gpuva_op_map *op)
> > +{
> > +	struct panthor_gem_object *bo =3D to_panthor_bo(op->gem.obj);
> > +	int prot =3D flags_to_prot(flags);
> > +
> > +	if (flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)
> > +		return panthor_vm_map_sparse(vm, op->va.addr, prot,
> > +					     bo->dmap.sgt, op->va.range);
> > +
> > +	return panthor_vm_map_pages(vm, op->va.addr, prot, bo->dmap.sgt,
> > +				    op->gem.offset, op->va.range);
> > +}
> > =20
> >  static int panthor_gpuva_sm_step_map(struct drm_gpuva_op *op, void *pr=
iv)
> >  {
> > @@ -2160,9 +2250,7 @@ static int panthor_gpuva_sm_step_map(struct drm_g=
puva_op *op, void *priv)
> > =20
> >  	panthor_vma_init(vma, op_ctx->flags & PANTHOR_VM_MAP_FLAGS);
> > =20
> > -	ret =3D panthor_vm_map_pages(vm, op->map.va.addr, flags_to_prot(vma->=
flags),
> > -				   op_ctx->map.bo->dmap.sgt, op->map.gem.offset,
> > -				   op->map.va.range);
> > +	ret =3D panthor_vm_exec_map_op(vm, vma->flags, &op->map);
> >  	if (ret) {
> >  		panthor_vm_op_ctx_return_vma(op_ctx, vma);
> >  		return ret;
> > @@ -2178,13 +2266,16 @@ static int panthor_gpuva_sm_step_map(struct drm=
_gpuva_op *op, void *priv)
> >  }
> > =20
> >  static bool
> > -iova_mapped_as_huge_page(struct drm_gpuva_op_map *op, u64 addr)
> > +iova_mapped_as_huge_page(struct drm_gpuva_op_map *op, u64 addr, bool i=
s_sparse)
> >  {
> >  	struct panthor_gem_object *bo =3D to_panthor_bo(op->gem.obj);
> >  	const struct page *pg;
> >  	pgoff_t bo_offset;
> > =20
> > -	bo_offset =3D addr - op->va.addr + op->gem.offset;
> > +	/* Per-VM Dummy BO in sparse mappings is always 2MiB, so checking the
> > +	 * size of the very first page is enough.
> > +	 */
> > +	bo_offset =3D !is_sparse ? addr - op->va.addr + op->gem.offset : 0;
> >  	pg =3D bo->backing.pages[bo_offset >> PAGE_SHIFT];
> > =20
> >  	return folio_size(page_folio(pg)) >=3D SZ_2M;
> > @@ -2194,6 +2285,8 @@ static void
> >  unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
> >  		     u64 *unmap_start, u64 *unmap_range)
> >  {
> > +	struct panthor_vma *unmap_vma =3D container_of(op->unmap->va, struct =
panthor_vma, base);
> > +	bool is_sparse =3D unmap_vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPAR=
SE;
> >  	u64 aligned_unmap_start, aligned_unmap_end, unmap_end;
> > =20
> >  	unmap_end =3D *unmap_start + *unmap_range;
> > @@ -2205,7 +2298,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_re=
map *op,
> >  	 */
> >  	if (op->prev && aligned_unmap_start < *unmap_start &&
> >  	    op->prev->va.addr <=3D aligned_unmap_start &&
> > -	    iova_mapped_as_huge_page(op->prev, *unmap_start)) {
> > +	    (iova_mapped_as_huge_page(op->prev, *unmap_start, is_sparse))) { =
=20
>=20
> Actually, I think this could be:
> 	   =20
> 	    (is_sparse || iova_mapped_as_huge_page(op->prev, *unmap_start)) {
>=20
> such that we always end up with sparse mappings starting at offset=3D0 on
> the dummy GEM, even if those mappings are not 2M aligned (see below for
> more reasons to keep this thing accurate).
>=20
> >  		*unmap_range +=3D *unmap_start - aligned_unmap_start;
> >  		*unmap_start =3D aligned_unmap_start;
> >  	}
> > @@ -2215,7 +2308,7 @@ unmap_hugepage_align(const struct drm_gpuva_op_re=
map *op,
> >  	 */
> >  	if (op->next && aligned_unmap_end > unmap_end &&
> >  	    op->next->va.addr + op->next->va.range >=3D aligned_unmap_end &&
> > -	    iova_mapped_as_huge_page(op->next, unmap_end - 1)) {
> > +	    iova_mapped_as_huge_page(op->next, unmap_end - 1, is_sparse)) {
> >  		*unmap_range +=3D aligned_unmap_end - unmap_end;
> >  	}

If we want all sparse mappings to start at offset 0, we'll also need
something like:

	if (op->next && aligned_unmap_end > unmap_end) {
		/* If this is a sparse mapping, we always unmap everything
		 * up to the next 2M boundary, just so we have the guarantee
		 * the new unaligned mapping starts at offset=3D0 of the dummy
		 * GEM.
		 */
		if (is_sparse) {
			u64 new_unmap_end =3D min(op->next->va.addr + op->next->va.range,
						aligned_unmap_end);

			*unmap_range +=3D new_unmap_end - unmap_end;
		} else if (op->next->va.addr + op->next->va.range >=3D aligned_unmap_end =
&&
			   iova_mapped_as_huge_page(op->next, unmap_end - 1)) {
			*unmap_range +=3D aligned_unmap_end - unmap_end;
		}=09
	}

But it looks like we're accumulating special cases for SPARSE,
so I'm wondering if we're not better off setting
drm_gpuva::gem.offset to iova & (SZ_2M - 1) at this point,
and adding all these GEM offset adjustment machinery behind
some helpers that would check the VM_BIND_MAP flags.

> >  }


