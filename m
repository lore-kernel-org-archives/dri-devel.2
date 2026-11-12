Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66569606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VF63g/4e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955B81122ED;
	Thu, 12 Nov 2026 23:28:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3831C10EBC9
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:28:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 553BF624AB;
 Thu, 12 Nov 2026 23:28:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0ED81F000C7;
 Thu, 12 Nov 2026 23:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794526126;
 bh=ZAMK+7jiJkzCsCGZhhkbbdgevys+lauzLtPj/YcPTBQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VF63g/4e4CK2f3A9B2cvKXpyWKFb13+xEBPTko9pDnQ/5v75keeMrWXowEWbzxt4a
 /eBcUQAZme3yl0+D6J26UnnjleXDlyOYKpNpDZStwFPk3joaHIPLoT2PU2k6AaazLk
 gIB6qSwo+iwKTXjTZNAVWMH1AkY8lYa3SJAfqU8vDq4tCq2EMnsgCEabDYfn6wTGcL
 xHcgBYFH5jquPoveuQrsjA1zsSqovKm/8ManzGRUiomx03Jsg4bWxE7svXcYqfTYQj
 cdk4yjXJWA7Jt+NCIkdIn9L7s+0rgALVf7CvF1ocA371KYLd7t67OsUD8IHHG/byo4
 7CRtvssCvqXxw==
Message-ID: <sashiko-outbox-211952@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 07/13] drm/powervr_sgx: Add GEM objects, VMs and
 dma-buf sharing
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-7-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-7-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:28:45 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [High] drm/powervr_sgx: unreaped objects across restarts in
  pvrsgx_kobj_reap()
- [High] drm/powervr_sgx: refcount cycle in pvrsgx_kobj_create() and
  pvrsgx_vm_create()
- [High] drm/powervr_sgx: unbounded row loop in range_flush() via
  cache_range_check()
- [High] drm/powervr_sgx: stranded pvrsgx_vm_free items on
  sdev->inval_waits leak drm_device
- [High] drm/powervr_sgx: race between pvrsgx_vm_lookup() and VM context
  teardown
- [Medium] drm/powervr_sgx: imported BOs rejected in
  pvrsgx_ioctl_get_bo_mmap_offset()
- [Medium] drm/powervr_sgx: missing cache flush and GFP flags in
  pvrsgx_ioctl_create_bo()
- [Medium] drm/powervr_sgx: unconditional EDMPROTECT on KDATA in
  krange() faults SGX530
- [Low] drm/powervr_sgx: stale sync_ops comment above
  pvrsgx_ioctl_vm_bind()
--

commit 296c713c959dc9c9e5a4a2d89cd48e4f92b9f9e5
Author: Joseph Telaak <joseph@telaak.dev>

drm/powervr_sgx: Add GEM objects, VMs and dma-buf sharing

This commit adds GEM shmem buffer objects, drm_gpuvm-based VM context and
VM_BIND management, kernel-owned GPU objects with deferred reaping, and
dma-buf export and import support for PowerVR SGX GPUs.

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_gem.c b/drivers/gpu/drm/p=
owervr_sgx/pvrsgx_gem.c
> new file mode 100644
> index 0000000000000..b22b819b01fd8
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_gem.c
> @@ -0,0 +1,120 @@

[ ... ]

> +/* Every CPU mapping, the dma-buf's included, needs ALLOW_CPU_ACCESS. */
> +static int pvrsgx_gem_mmap(struct drm_gem_object *obj, struct vm_area_st=
ruct *vma)
> +{
> +	if (!drm_gem_is_imported(obj) &&
> +	    !(to_pvrsgx_bo(obj)->flags & DRM_POWERVR_SGX_BO_ALLOW_CPU_ACCESS))
> +		return -EINVAL;
> +	return drm_gem_shmem_object_mmap(obj, vma);
> +}

[ ... ]

> +int pvrsgx_ioctl_create_bo(struct drm_device *drm, void *data, struct dr=
m_file *file)
> +{
> +	struct drm_powervr_sgx_ioctl_create_bo_args *args =3D data;
> +	struct drm_gem_shmem_object *shmem;
> +	int err;
> +
> +	if (args->_padding_c || (args->flags & ~PVRSGX_BO_FLAGS_MASK) ||
> +	    !args->size || !PAGE_ALIGNED(args->size) || args->size > PVRSGX_BO_=
MAX_SIZE)
> +		return -EINVAL;
> +	if ((args->flags & DRM_POWERVR_SGX_BO_CODE) &&
> +	    (args->flags & DRM_POWERVR_SGX_BO_ALLOW_CPU_ACCESS))
> +		return -EINVAL;
> +
> +	shmem =3D drm_gem_shmem_create(drm, args->size);
> +	if (IS_ERR(shmem))
> +		return PTR_ERR(shmem);
> +	to_pvrsgx_bo(&shmem->base)->flags =3D args->flags;
> +	/* Pages the GPU can address. */
> +	mapping_set_gfp_mask(shmem->base.filp->f_mapping,
> +			     (GFP_HIGHUSER & ~__GFP_HIGHMEM) | __GFP_DMA32);

[Severity: Medium]
On ARM, can dirty cache lines from shmem page zeroing overwrite data written
to a BO before its first VM_BIND?

When shmem allocates backing pages, the kernel zeroes them through the
cacheable linear mapping, leaving dirty zero cache lines in the CPU data
cache.  Unlike x86, drm_gem_shmem_get_pages_locked() does not call
set_pages_array_wc() on ARM, so writing to a BO via mmap() or UPLOAD_CODE
before VM_BIND writes through a write-combined mapping to DRAM while those
dirty zero lines remain cached.  When bind_op_check() later calls
drm_gem_shmem_get_pages_sgt() -> dma_map_sgtable(), those dirty zero lines
are flushed to DRAM over the earlier writes.

Also, mapping_set_gfp_mask() replaces the mask set by __drm_gem_shmem_init()
and drops __GFP_RETRY_MAYFAIL | __GFP_NOWARN, so large DMA32 BO allocations
up to PVRSGX_BO_MAX_SIZE (1 GiB) can trigger page allocation failure warnin=
gs
in dmesg under memory pressure.

> +
> +	err =3D drm_gem_handle_create(file, &shmem->base, &args->handle);
> +	drm_gem_object_put(&shmem->base);
> +	return err;
> +}
> +
> +int pvrsgx_ioctl_get_bo_mmap_offset(struct drm_device *drm, void *data, =
struct drm_file *file)
> +{
> +	struct drm_powervr_sgx_ioctl_get_bo_mmap_offset_args *args =3D data;
> +	struct drm_gem_object *obj;
> +	int err;
> +
> +	if (args->_padding_4)
> +		return -EINVAL;
> +
> +	obj =3D drm_gem_object_lookup(file, args->handle);
> +	if (!obj)
> +		return -ENOENT;
> +	if (!(to_pvrsgx_bo(obj)->flags & DRM_POWERVR_SGX_BO_ALLOW_CPU_ACCESS)) {
> +		err =3D -EINVAL;
> +		goto out;
> +	}

[Severity: Medium]
Does pvrsgx_ioctl_get_bo_mmap_offset() reject every PRIME-imported dma-buf
with -EINVAL?

Imported objects are created via pvrsgx_prime_import_sg_table() with
bo->flags =3D=3D 0.  pvrsgx_gem_mmap() checks !drm_gem_is_imported(obj) bef=
ore
requiring DRM_POWERVR_SGX_BO_ALLOW_CPU_ACCESS, but
pvrsgx_ioctl_get_bo_mmap_offset() does not, so userspace can never obtain t=
he
mmap offset to reach pvrsgx_gem_mmap() on an imported BO.

[ ... ]

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_kobj.c b/drivers/gpu/drm/=
powervr_sgx/pvrsgx_kobj.c
> new file mode 100644
> index 0000000000000..8b21315e9a135
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_kobj.c
> @@ -0,0 +1,285 @@

[ ... ]

> +/* Each range in the core's layout (pvrsgx_core.c). */
> +static struct krange krange(const struct pvrsgx_device *sdev, enum pvrsg=
x_krange r)
> +{
> +	const struct pvrsgx_heap_layout *h =3D pvrsgx_heaps(sdev);
> +
> +	switch (r) {
> +	case PVRSGX_KRANGE_KDATA:	/* past the firmware's own arenas (pvrsgx_fw.=
c) */
> +		return (struct krange){ h->kernel_data.base + 0x10000, h->kernel_data.=
end,
> +					SGX_MMU_PTE_CACHECONSISTENT | SGX_MMU_PTE_EDMPROTECT };

[Severity: Medium]
Should PVRSGX_KRANGE_KDATA omit SGX_MMU_PTE_EDMPROTECT when
sdev->family->data_no_edmprotect is set, the way fw_arenas() does in
pvrsgx_fw.c?

On SGX530 (data_no_edmprotect =3D true), microkernel stores to pages mapped
with SGX_MMU_PTE_EDMPROTECT trigger BIF page faults, so microkernel writes =
to
context CCB control words, RT dataset status words, and render details in
PVRSGX_KRANGE_KDATA will fault and reset the GPU.

[ ... ]

> +	if (per_vm) {
> +		o->vm =3D pvrsgx_vm_get(vm);
> +	} else if (vm) {
> +		err =3D pvrsgx_mmu_map_pages(vm->mmu, o->node.start, o->km.pages, o->k=
m.npages, 0);
> +		if (err)
> +			goto err_kmem;
> +		o->vm =3D pvrsgx_vm_get(vm);
> +	}

[Severity: High]
Does holding o->vm on graveyard objects create a reference cycle with
sdev->base that prevents pvrsgx_device_release() and pvrsgx_kobj_fini() from
ever running?

In pvrsgx_vm_create(), drm_gpuvm_init() takes a drm_dev_get(&sdev->base)
reference that is only dropped in vm_release() -> drm_gpuvm_put().  Each
VM-associated pvrsgx_kobj holds pvrsgx_vm_get(vm) until kobj_free(), while
pvrsgx_kobj_fini() is only called from the drmm callback
pvrsgx_device_release() when sdev->base.ref reaches 0.  If any VM-associated
kobj is sitting in sdev->graveyard or sdev->kobj_unmapped when the device is
unplugged (or is released when a DRM fd closes after unplug), o->vm keeps
vm->ref > 0, which keeps sdev->base.ref > 0 so pvrsgx_device_release() never
runs to reap the graveyard.

[ ... ]

> +void pvrsgx_kobj_reap(struct pvrsgx_device *sdev, u64 renders_done)
> +{
> +	struct pvrsgx_kobj *o, *tmp;
> +	bool all =3D renders_done =3D=3D U64_MAX;
> +	u32 restarts =3D READ_ONCE(sdev->restarts);
> +	u64 seq =3D 0, consumed;
> +	LIST_HEAD(dead);
> +
> +	mutex_lock(&sdev->kobj_lock);
> +	list_for_each_entry_safe(o, tmp, &sdev->graveyard, grave) {\n> +		/* A =
restart forgets everything the old run pointed at. */
> +		if (all || o->grave_restarts !=3D restarts ||
> +		    (o->grave_seq < renders_done && !o->until_restart))
> +			list_move_tail(&o->grave, &dead);
> +	}
> +	mutex_unlock(&sdev->kobj_lock);
> +
> +	if (!list_empty(&dead)) {
> +		list_for_each_entry(o, &dead, grave)
> +			kobj_unmap(o);
> +		/* The next command carries the invalidate. */
> +		mutex_lock(&sdev->ccb_lock);
> +		sdev->fw.cache_control |=3D PVRSGX_CC_INVAL_BIF_PT | PVRSGX_CC_INVAL_B=
IF_PD;
> +		seq =3D sdev->ccb_issued + 1;
> +		mutex_unlock(&sdev->ccb_lock);
> +	}
> +
> +	mutex_lock(&sdev->kobj_lock);
> +	list_for_each_entry(o, &dead, grave)
> +		o->flush_seq =3D seq;
> +	list_splice_tail_init(&dead, &sdev->kobj_unmapped);
> +	/*
> +	 * After a restart the ring starts over empty, so everything sent befor=
e it
> +	 * counts as consumed: the GPU was reset, and the first command after t=
he
> +	 * microkernel's start carries an invalidate of its own.
> +	 */
> +	consumed =3D all ? U64_MAX : pvrsgx_ccb_consumed(sdev);
> +	list_for_each_entry_safe(o, tmp, &sdev->kobj_unmapped, grave) {
> +		if (o->flush_seq <=3D consumed)
> +			list_move_tail(&o->grave, &dead);
> +	}

[Severity: High]
Does assigning o->flush_seq =3D sdev->ccb_issued + 1 leave objects reaped
across a microkernel restart stranded in sdev->kobj_unmapped?

When pvrsgx_fw_start() restarts the microkernel, it resets the CCB ring
offsets to 0 without advancing sdev->ccb_issued and queues sdev->reap_work.
pvrsgx_kobj_reap() moves graveyard objects with o->grave_restarts !=3D rest=
arts
(including until_restart parameter buffer descriptors) to dead, sets
o->flush_seq =3D sdev->ccb_issued + 1, and compares it against
pvrsgx_ccb_consumed(sdev), which returns sdev->ccb_issued.  Because
o->flush_seq > consumed, neither those objects nor any objects already in
sdev->kobj_unmapped waiting for sdev->ccb_issued + 1 before the reset are
freed until another CCB command is issued and reaped.

Also, unlike pvrsgx_ccb_inval_reap(), consumed does not check
READ_ONCE(sdev->lost), so objects in sdev->kobj_unmapped remain unfreed when
the device is marked lost.

[ ... ]

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_prime.c b/drivers/gpu/drm=
/powervr_sgx/pvrsgx_prime.c
> new file mode 100644
> index 0000000000000..e6aca114515dd
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_prime.c
> @@ -0,0 +1,203 @@

[ ... ]

> +/* A range's flags, and its rows inside an object of obj_size bytes. */
> +static int cache_range_check(const struct drm_powervr_sgx_cache_range *r=
, u64 obj_size)
> +{
> +	u32 rows =3D max(r->rows, 1u);
> +	u64 span, end;
> +
> +	if (!r->flags || (r->flags & ~CACHE_RANGE_FLAGS) || !r->size)
> +		return -EINVAL;
> +	if (rows > 1 && r->stride < r->size)
> +		return -EINVAL;
> +	if (check_mul_overflow((u64)(rows - 1), (u64)r->stride, &span) ||
> +	    check_add_overflow(span, r->size, &span) ||
> +	    check_add_overflow(r->offset, span, &end) || end > obj_size)
> +		return -EINVAL;
> +	return 0;
> +}

[ ... ]

> +static u64 range_flush(const struct pvrsgx_cache_range *r)
> +{
> +	const struct iosys_map *map =3D &to_pvrsgx_bo(r->obj)->import_map;
> +
> +	/* I/O memory isn't cached. */
> +	if (!r->import || map->is_iomem)
> +		return 0;
> +	if (r->rows =3D=3D 1 || r->stride =3D=3D r->size) {
> +		drm_clflush_virt_range(map->vaddr + r->offset, r->size * r->rows);
> +	} else {
> +		for (u32 y =3D 0; y < r->rows; y++)
> +			drm_clflush_virt_range(map->vaddr + r->offset + (u64)y * r->stride,
> +					       r->size);
> +	}
> +	return r->size * r->rows;
> +}

[Severity: High]
Can a user submit cache ranges with a tiny size and stride (such as size =
=3D 1,
stride =3D 2, and rows =3D obj_size / 2) to stall the CPU in range_flush()?

On a 1 GiB imported dma-buf, cache_range_check() allows up to 2^29 rows per
range across 64 ranges.  Because r->stride !=3D r->size, range_flush() calls
drm_clflush_virt_range() in a tight non-preemptible loop hundreds of millio=
ns
of times=E2=80=94each issuing two full memory barriers and two clflushopt
instructions=E2=80=94both in pvrsgx_run_job() and inside the fence-signalin=
g section
in pvrsgx_job_process_done().

[ ... ]

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_vm.c b/drivers/gpu/drm/po=
wervr_sgx/pvrsgx_vm.c
> new file mode 100644
> index 0000000000000..b12d390622cfc
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_vm.c
> @@ -0,0 +1,799 @@

[ ... ]

> +static void vm_free_work(struct work_struct *work)
> +{
> +	struct pvrsgx_vm_free *f =3D container_of(work, struct pvrsgx_vm_free, =
work);
> +	struct pvrsgx_device *sdev =3D to_pvrsgx_device(f->drm);
> +
> +	f->inval.done =3D vm_free_done;
> +	if (f->teardown) {
> +		mutex_lock(&f->vm->lock);
> +		vm_unmap_all(f->vm, &f->vas);
> +		mutex_unlock(&f->vm->lock);
> +	}
> +	/*
> +	 * The BIF caches walks only of a directory a job ran on, and a restart=
 or
> +	 * power-off drops them: then there is nothing to wait for.
> +	 */
> +	if (!READ_ONCE(sdev->powered) ||
> +	    READ_ONCE(f->vm->ran_gen) !=3D READ_ONCE(sdev->fw_gen) + 1) {
> +		vm_free_done(&f->inval);
> +		return;
> +	}
> +	pvrsgx_ccb_after_invalidate(sdev, &f->inval, PVRSGX_CC_INVAL_BIF_PT |
> +				    PVRSGX_CC_INVAL_BIF_PD | PVRSGX_CC_INVAL_DATA);
> +}

[Severity: High]
Can f->inval be queued onto sdev->inval_waits and never reaped across power=
-off
or unplug, leaking f->drm and deadlocking drmm teardown?

CPU0 (vm_free_work)               CPU1 (unplug or CCB completion)
vm_free_work()
  READ_ONCE(sdev->powered) =3D=3D true
  pvrsgx_ccb_after_invalidate()
    mutex_lock(&sdev->ccb_lock)
    w->seq =3D sdev->ccb_issued + 1
    mutex_unlock(&sdev->ccb_lock)
                                  pvrsgx_job_unplug()
                                    sdev->lost =3D true
                                    pvrsgx_fw_stop()
                                    pvrsgx_ccb_inval_reap(sdev, true)
    spin_lock_irqsave(&sdev->inval_lock)
    list_add_tail(&w->node, &sdev->inval_waits)  <-- never reaped

In pvrsgx_ccb.c, pvrsgx_ccb_after_invalidate() drops sdev->ccb_lock before
taking sdev->inval_lock, and checks sdev->powered / sdev->lost without
holding sdev->inval_lock:

drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.c:pvrsgx_ccb_after_invalidate() {
	if (READ_ONCE(sdev->lost)) {
		w->done(w);
		return;
	}
	mutex_lock(&sdev->ccb_lock);
	sdev->fw.cache_control |=3D cache_control;
	w->seq =3D sdev->ccb_issued + 1;
	mutex_unlock(&sdev->ccb_lock);
	spin_lock_irqsave(&sdev->inval_lock, flags);
	list_add_tail(&w->node, &sdev->inval_waits);
	spin_unlock_irqrestore(&sdev->inval_lock, flags);
	pvrsgx_ccb_inval_reap(sdev, false);
}

If pvrsgx_job_unplug() (or another CPU completing command w->seq) runs
pvrsgx_ccb_inval_reap() in that window, w->node is queued after the reap has
already finished.  Likewise, if vm_free_work() queues f->inval while the GPU
is idle before runtime suspend, pvrsgx_fw_stop() powers off the GPU without
calling pvrsgx_ccb_inval_reap().  Because vm_free_after_jobs() holds
drm_dev_get(f->drm) until vm_free_done(), a stranded entry on
sdev->inval_waits prevents sdev->base.ref from reaching 0, so the drmm
callback pvrsgx_device_release() never runs.

[ ... ]

> +void pvrsgx_vm_user_get(struct pvrsgx_vm *vm)
> +{
> +	atomic_inc(&vm->users);
> +}

[ ... ]

> +struct pvrsgx_vm *pvrsgx_vm_lookup(struct pvrsgx_file *sfile, u32 handle)
> +{
> +	struct pvrsgx_vm *vm;
> +
> +	xa_lock(&sfile->vms);
> +	vm =3D xa_load(&sfile->vms, handle);
> +	if (vm)
> +		pvrsgx_vm_get(vm);
> +	xa_unlock(&sfile->vms);
> +	return vm;
> +}

[Severity: High]
Can pvrsgx_ioctl_destroy_vm_context() race with a concurrent
pvrsgx_vm_lookup() user to map objects into an already torn-down VM or
resurrect vm->users from 0?

CPU0                              CPU1
pvrsgx_ioctl_vm_bind()
  vm =3D pvrsgx_vm_lookup()
                                  pvrsgx_ioctl_destroy_vm_context()
                                    xa_erase(&sfile->vms, handle)
                                    pvrsgx_vm_user_put(vm)
                                      atomic_dec_and_test(&vm->users)
                                      vm_free_work()
                                        vm_unmap_all(vm, ...)
  mutex_lock(&vm->lock)
  bind_apply(vm, ...)             <-- maps BOs into torn-down VM

pvrsgx_vm_lookup() only increments vm->ref under xa_lock(&sfile->vms),
without checking or incrementing vm->users, and pvrsgx_ioctl_vm_bind() never
checks whether vm->users has already dropped to 0 after acquiring vm->lock.
New mappings added after vm_unmap_all() stay pinned until vm_release() (and=
 if
a context creation path calls pvrsgx_vm_user_get() after lookup, atomic_inc=
()
resurrects vm->users from 0 to 1 and triggers a second teardown when that
context is destroyed).

[ ... ]

> +/* Wait, interruptibly, for every wait op; find every signal op's syncob=
j. */
> +int pvrsgx_ioctl_vm_bind(struct drm_device *drm, void *data, struct drm_=
file *file)
> +{
> +	struct drm_powervr_sgx_ioctl_vm_bind_args *args =3D data;
> +	struct pvrsgx_vm_free *f =3D NULL;
> +	struct bind_op *ops =3D NULL;
> +	struct drm_powervr_sgx_vm_bind_op *in;
> +	struct pvrsgx_vm *vm;
> +	struct drm_exec exec;
> +	u32 n =3D args->ops.count;
> +	int err;
> +
> +	/* A synchronous bind takes no fences (drm-vm-bind-async.rst). */
> +	if (args->flags !=3D DRM_POWERVR_SGX_VM_BIND_FLAG_SYNC || !n || args->s=
ync_ops.count)
> +		return -EINVAL;

[Severity: Low]
This isn't a bug, but the comment above pvrsgx_ioctl_vm_bind() describes
waiting on and signaling sync_ops, whereas pvrsgx_ioctl_vm_bind() only
supports synchronous binds and rejects non-zero args->sync_ops.count.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D7
