Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE11AC44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:53:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 455F010E314;
	Thu, 16 Jul 2026 15:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LDNDcSQi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F7E10E273
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:53:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14E9860A5E;
 Thu, 16 Jul 2026 15:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E181F000E9;
 Thu, 16 Jul 2026 15:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784217200;
 bh=9WgkAxwNMU8rugLYbDSOqjiOXrMgfqnUsL5JLYyzc/o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LDNDcSQiiCaHADvJ2X1JL/JSANAOIguOzy1fYt4w0GWWq+StNtY9uOFbBr8CBHZX0
 qzUnUNxd+EZBO/8rSCR7u3kkT9w1Ni1BTYWn8hgffzRjQnv8dxCuexjOdoEyPEaViK
 Blz1u431NK8Qi4utnD8staqBQ9XobGAzRHiDUrPNlqIrGnEW5c6wJEqzGmaGTLXJUF
 OQ4Ezx28275ktHnxeG6JLvEY+3tfTxLmMWoO6PryhRjvjusfRgFqSMKeM1mS7d/e6r
 laUZDbjdYIGTrBAqp3CGoeH8hpmXwG9pkkXy3rfyTyrw7FXs6dPdsiuUnLZjM+xjUj
 uTpPrxqRhvqlw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/11] samples/kvm: Add guest_memfd backing sample
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <cfc7765953bddff7bb6d4206f5cfa6df9c8705ef.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
 <cfc7765953bddff7bb6d4206f5cfa6df9c8705ef.1784194290.git.dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:53:20 +0000
Message-Id: <20260716155320.86E181F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 14 potential issue=
(s) to consider:
- [Critical] Missing file type validation for `setup.kvm_fd` allows arbitra=
ry kernel memory corruption.
- [Critical] `gmem_release()` frees memory while it is still mapped into th=
e guest, causing host physical memory corruption.
- [High] Unprotected access to `info->kvm` leads to Use-After-Free and data=
 races.
- [High] Non-atomic bitmap operations in `GMEM_PROVIDER_SET_PRESENT` corrup=
t memory revocation state.
- [High] `gmem_bind` tracks only a single memslot binding, preventing memor=
y revocation for previously bound slots.
- [High] Integer underflow in revocation range causes out-of-bounds KVM inv=
alidation.
- [High] `gmem_max_order()` ignores the absent bitmap, allowing KVM to inst=
all hugepage mappings over revoked pages.
- [High] `gmem_mmap()` does not check `info->mmap_capable`, allowing host a=
ccess to hardware-encrypted VM memory.
- [High] `gmem_unbind()` fails to call `psmash()`, leaving 2M pages permane=
ntly stuck in the private state on SEV-SNP.
- [High] The `psmash` operation is completely skipped in `gmem_bind` if the=
 starting physical address is not 2M aligned.
- [High] The provider does not pin its module, allowing it to be unloaded w=
hile guest_memfd instances remain active.
- [High] Integer truncation in `bitmap_zalloc()` leads to an unprivileged k=
ernel heap buffer overflow.
- [Medium] Leaked provider file reference in `gmem_provider_get_dmabuf` err=
or path.
- [Medium] DMAbuf exporter leaks its initial kref and fails to wait for map=
pings to be torn down.
--

--- Patch [8]: [RFC PATCH 08/11] samples/kvm: Add guest_memfd backing sampl=
e ---
commit 7bfeb9f519ccce1291a261c36607819a68c027ce
Author: David Woodhouse <dwmw@amazon.co.uk>
Subject: samples/kvm: Add guest_memfd backing sample

This commit adds a sample guest_memfd provider module for KVM. It
demonstrates page-less backing from a fixed physical range or a
CMA-allocated contiguous region. It also includes page revocation
via a bitmap and a dma-buf exporter.

> diff --git a/samples/kvm/gmem_provider.c b/samples/kvm/gmem_provider.c
> new file mode 100644
> index 0000000000000..e30580fecd166
> --- /dev/null
> +++ b/samples/kvm/gmem_provider.c
> @@ -0,0 +1,651 @@
[ ... ]
> +static int gmem_max_order(struct gmem_info *info, gfn_t gfn, unsigned lo=
ng index)
> +{
> +	unsigned long pfn =3D info->base_pfn + index;
> +	unsigned long remaining =3D info->npages - index;
> +	unsigned int pud_order =3D PUD_SHIFT - PAGE_SHIFT;
> +	unsigned int pmd_order =3D PMD_SHIFT - PAGE_SHIFT;
> +
> +	if (IS_ALIGNED(pfn, 1UL << pud_order) &&
> +	    IS_ALIGNED(gfn, 1UL << pud_order) &&
> +	    remaining >=3D (1UL << pud_order))
> +		return pud_order;

[Severity: High]
Does gmem_max_order() account for pages marked absent?

When KVM queries the maximum mapping order for a present faulting page,
gmem_max_order() checks alignment and remaining length, but does not check
if any of the subsequent pages within the hugepage range are marked absent
in info->absent.

If a subset of pages in a 2M or 1G range is revoked but the faulting page
is present, could KVM install a hugepage mapping that grants the guest
unauthorized access to the revoked pages within that block?

[ ... ]
> +static int gmem_bind(struct file *file, struct kvm *kvm,
> +		     struct kvm_memory_slot *slot, loff_t offset)
> +{
[ ... ]
> +	/* Record the binding so the revoke ioctl can translate offset -> gfn. =
*/
> +	info->base_gfn =3D slot->base_gfn;
> +	info->pgoff =3D start;

[Severity: High]
Does gmem_bind() only track a single memslot binding?

KVM allows a single provider fd to back multiple memslots. However,
gmem_bind() overwrites info->base_gfn and info->pgoff with the new
slot's coordinates.

During GMEM_PROVIDER_SET_PRESENT, KVM is only asked to invalidate the singl=
e,
most recently bound GFN range. Older slots would be ignored and their guest
NPT/EPT mappings never zapped. Can this result in a complete bypass of the
page revocation mechanism for previously bound slots?

> +
> +#if IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)
> +	/*
> +	 * Reset the RMP for the range to 4K shared so a (new) SEV-SNP VM can
> +	 * transition it to private and re-encrypt it.  PSMASH any 2M entries
> +	 * first.  Harmless on non-SNP hosts, where these return -ENODEV.
> +	 */
> +	{
> +		unsigned long i;
> +
> +		for (i =3D 0; i < slot->npages; i +=3D PTRS_PER_PMD) {
> +			unsigned long pfn =3D info->base_pfn + start + i;
> +
> +			if (IS_ALIGNED(pfn, PTRS_PER_PMD))
> +				psmash(pfn);
> +		}

[Severity: High]
Will the psmash() operation be skipped if the start address is unaligned?

The loop advances i by PTRS_PER_PMD (which is 512) and checks if the combin=
ed
pfn is perfectly aligned to a 2M boundary.

If info->base_pfn + start is not 2M-aligned to begin with, adding 512
guarantees that every subsequent PFN checked will also be unaligned.
psmash() would never be called for any 2M boundaries inside the range.
Could this cause subsequent rmp_make_shared() calls to fail?

> +		for (i =3D 0; i < slot->npages; i++) {
> +			unsigned long pfn =3D info->base_pfn + start + i;
> +			int ret =3D rmp_make_shared(pfn, PG_LEVEL_4K);
> +
> +			if (ret && ret !=3D -ENODEV)
> +				pr_info_once("gmem_provider: rmp_make_shared(0x%lx) =3D %d\n",
> +					     pfn, ret);
> +		}
> +	}
> +#endif
> +
> +	/* Claim (or, on re-bind, transfer) VM ownership; pins the VM. */
> +	if (info->kvm !=3D kvm) {
> +		kvm_get_kvm(kvm);
> +		if (info->kvm)
> +			kvm_put_kvm(info->kvm);
> +		info->kvm =3D kvm;
> +	}

[Severity: High]
Does this code handle concurrent bindings safely?

In gmem_bind(), info->kvm is read and modified without any locking. If a
single provider file is concurrently bound to multiple VMs (or the same VM
multiple times), multiple threads could race, reading the same old info->kvm
pointer and both calling kvm_put_kvm().

This could lead to a double-put and Use-After-Free of the KVM instances.
Additionally, gmem_fd_ioctl() accesses info->kvm without locks while it
might be concurrently updated or freed. Could we add synchronization to
protect info->kvm?

[ ... ]
> +static void gmem_unbind(struct file *file, struct kvm *kvm,
> +			struct kvm_memory_slot *slot)
> +{
> +#if IS_ENABLED(CONFIG_AMD_MEM_ENCRYPT)
> +	struct gmem_info *info =3D to_gmem_info(file);
> +	unsigned long start =3D slot->gmem.pgoff;
> +	unsigned long i;
> +
> +	for (i =3D 0; i < slot->npages; i++) {
> +		unsigned long pfn =3D info->base_pfn + start + i;
> +
> +		rmp_make_shared(pfn, PG_LEVEL_4K);
> +	}
> +#endif
> +}

[Severity: High]
Is a call to psmash() required before rmp_make_shared() here?

On SEV-SNP hosts, converting a 2M private page back to the shared state
using rmp_make_shared() with PG_LEVEL_4K fails unless the 2M RMP entry is
first shattered using psmash().

gmem_unbind() omits the psmash() step and ignores the return value of
rmp_make_shared(). This could leave 2M pages permanently marked as private.
When these CMA pages are freed and reused by the host allocator, wouldn't
accessing them crash the host?

[ ... ]
> +static void gmem_release(struct file *file)
> +{
> +	struct gmem_info *info =3D to_gmem_info(file);
> +
> +	if (info->kvm)
> +		kvm_put_kvm(info->kvm);
> +	if (info->cma_pages)
> +		free_contig_range(info->base_pfn, info->npages);
> +	bitmap_free(info->absent);
> +	kfree(info);
> +}

[Severity: Critical]
Does gmem_release() free memory while it is still mapped into the guest?

When the provider fd is closed, gmem_release() frees info->cma_pages and
the info struct. However, it does not appear to zap the guest's NPT/EPT
page tables or clear the KVM slot tracking pointer.

This leaves the guest with full read/write access to the freed CMA pages
after they have been reallocated to other kernel subsystems. When KVM later
destroys the memslot, it could also dereference the dangling slot->gmem.file
pointer. Should the mappings be explicitly torn down before freeing?

[ ... ]
> +static int gmem_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct gmem_info *info =3D to_gmem_info(file);
> +	unsigned long npages =3D vma_pages(vma);
> +
> +	if (vma->vm_pgoff + npages > info->npages)
> +		return -EINVAL;
> +
> +	/* Page-less backing: map raw PFNs, not folios. */
> +	vm_flags_set(vma, VM_PFNMAP | VM_IO | VM_DONTEXPAND | VM_DONTDUMP);
> +	return remap_pfn_range(vma, vma->vm_start, info->base_pfn + vma->vm_pgo=
ff,
> +			       npages << PAGE_SHIFT, vma->vm_page_prot);
> +}

[Severity: High]
Should gmem_mmap() validate the mmap_capable policy?

gmem_bind() refuses to bind to encrypted VMs if info->mmap_capable is set,
in order to protect the host. However, gmem_mmap() maps the memory to
userspace without verifying info->mmap_capable.

Userspace could clear GMEM_PROVIDER_FLAG_MMAP_CAPABLE during setup,
successfully bind to a SEV-SNP/TDX VM, and then call mmap() on the fd
anyway. Could this allow host access to hardware-encrypted memory and
cause a machine check exception or RMP violation?

[ ... ]
> +/* Called with info->dmabufs_lock held on the revoke path. */
> +static void gmem_dma_buf_revoke_all(struct gmem_info *info)
> +{
> +	struct gmem_dmabuf *priv;
> +
> +	list_for_each_entry(priv, &info->dmabufs, list) {
> +		dma_resv_lock(priv->dmabuf->resv, NULL);
> +		if (!priv->revoked) {
> +			priv->revoked =3D true;
> +			dma_buf_invalidate_mappings(priv->dmabuf);
> +		}
> +		dma_resv_unlock(priv->dmabuf->resv);
> +	}
> +}

[Severity: Medium]
Should the revocation wait for the completion of mapping teardowns?

In gmem_dma_buf_revoke_all(), dma_buf_invalidate_mappings() is called, but
it doesn't wait on priv->comp. This leaves the completion machinery unused
and leaks the kref initialized in gmem_provider_get_dmabuf().

Should we properly wait for the mappings to be torn down and drop the
reference?

[ ... ]
> +static int gmem_provider_get_dmabuf(struct file *file)
> +{
> +	struct gmem_info *info =3D to_gmem_info(file);
> +	DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
> +	struct gmem_dmabuf *priv;
> +	int fd;
> +
> +	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->info =3D info;
> +	priv->provider_file =3D get_file(file);
> +	priv->phys.paddr =3D (u64)info->base_pfn << PAGE_SHIFT;
> +	priv->phys.len =3D (u64)info->npages << PAGE_SHIFT;
> +	kref_init(&priv->kref);
> +	init_completion(&priv->comp);
> +	INIT_LIST_HEAD(&priv->list);
> +
> +	exp_info.ops =3D &gmem_dma_buf_ops;
> +	exp_info.size =3D priv->phys.len;
> +	exp_info.flags =3D O_RDWR;
> +	exp_info.priv =3D priv;
> +
> +	priv->dmabuf =3D dma_buf_export(&exp_info);
> +	if (IS_ERR(priv->dmabuf)) {
> +		fd =3D PTR_ERR(priv->dmabuf);
> +		kfree(priv);
> +		return fd;
> +	}

[Severity: Medium]
Will this error path leak the provider file reference?

Earlier in gmem_provider_get_dmabuf(), get_file(file) is called to increment
the reference count. If dma_buf_export() fails, the function frees priv and
returns an error, but it doesn't appear to call fput(priv->provider_file).

Could userspace trigger this intentionally (e.g., by hitting file descriptor
limits) to permanently leak the file and its associated CMA memory?

[ ... ]
> +static long gmem_fd_ioctl(struct file *file, unsigned int cmd, unsigned =
long arg)
> +{
> +	struct gmem_info *info =3D to_gmem_info(file);
> +	struct gmem_provider_present p;
> +	unsigned long start_index, end_index;
[ ... ]
> +	if (p.present) {
> +		/* Restore: next guest fault calls get_pfn() and re-maps. */
> +		bitmap_clear(info->absent, start_index, end_index - start_index);
> +	} else {
> +		/* Revoke: mark absent, then zap the guest NPT/EPT for the range. */
> +		bitmap_set(info->absent, start_index, end_index - start_index);

[Severity: High]
Are these bitmap operations safe against concurrent updates?

In gmem_fd_ioctl(), GMEM_PROVIDER_SET_PRESENT uses bitmap_set() and
bitmap_clear() without synchronization. These functions perform non-atomic
read-modify-write operations on the underlying unsigned long elements.

If userspace concurrently revokes or restores different page ranges that fa=
ll
within the same bitmap word, won't the updates race and clobber each other,
potentially allowing the guest unauthorized access?

> +		if (info->kvm)
> +			kvm_gmem_invalidate_range(info->kvm,
> +				info->base_gfn + start_index - info->pgoff,
> +				info->base_gfn + end_index - info->pgoff);

[Severity: High]
Can this arithmetic underflow if start_index < info->pgoff?

If userspace specifies a revocation range that starts before the offset whe=
re
the slot was bound (start_index < info->pgoff), the subtraction here will
underflow to a massive unsigned value.

kvm_gmem_invalidate_range() would then use this bogus GFN range, fail to
find the correct slot, and skip the invalidation entirely, leaving revoked
pages mapped in the guest. Should we bounds-check start_index against
info->pgoff?

[ ... ]
> +static long gmem_ctl_ioctl(struct file *file, unsigned int cmd, unsigned=
 long arg)
> +{
> +	struct gmem_provider_setup setup;
> +	struct gmem_info *info;
> +	struct file *kvm_file;
> +	struct page *pages =3D NULL;
> +	struct kvm *kvm;
> +	unsigned long npages;
> +	int fd, ret;
> +
> +	if (cmd !=3D GMEM_PROVIDER_SETUP)
> +		return -ENOTTY;
> +
> +	if (copy_from_user(&setup, (void __user *)arg, sizeof(setup)))
> +		return -EFAULT;
> +	if (setup.flags & ~GMEM_PROVIDER_FLAG_MMAP_CAPABLE)
> +		return -EINVAL;
> +
> +	kvm_file =3D fget(setup.kvm_fd);
> +	if (!kvm_file)
> +		return -EBADF;
> +	kvm =3D kvm_file->private_data;

[Severity: Critical]
Is it possible for userspace to provide a file descriptor that is not a KVM
VM file?

Looking at gmem_ctl_ioctl(), the code calls fget() on setup.kvm_fd and blin=
dly
dereferences kvm_file->private_data. If an unprivileged user passes an
arbitrary file descriptor (like an eventfd or socket), this would cast
its private_data to a struct kvm *.

This could lead to arbitrary kernel memory corruption when kvm_get_kvm()
subsequently performs an atomic increment at the offset of users_count on
that arbitrary data structure. Should we verify the file's operations
(e.g., checking kvm_file->f_op) before casting?

[ ... ]
> +	info->absent =3D bitmap_zalloc(info->npages, GFP_KERNEL);

[Severity: High]
Can info->npages be truncated during bitmap allocation?

info->npages is a 64-bit unsigned long. If the module is loaded with a large
external addr=3D/len=3D range (e.g., 16TB), info->npages exceeds 32 bits.
bitmap_zalloc() takes an unsigned int for nbits, which would silently
truncate this value, allocating a smaller bitmap.

An unprivileged user could then call GMEM_PROVIDER_SET_PRESENT with a large
offset that passes the 64-bit bounds check, causing bitmap_set() to write
far beyond the truncated allocation. Does this allow a kernel heap buffer
overflow?

[ ... ]
> +	fd =3D anon_inode_getfd("[gmem-provider]", &kvm_gmem_fops,
> +			      &info->backing, O_RDWR | O_CLOEXEC);

[Severity: High]
Is the provider module pinned when the file descriptor is created?

anon_inode_getfd() creates the fd using &kvm_gmem_fops, which belongs to
the KVM module. The provider module does not take a reference to itself.

If userspace closes the control fd (/dev/gmem_provider) but keeps the
provider fd open, could the gmem_provider module be unloaded via rmmod?
Subsequent VM page faults or ioctls would then call into the unloaded
module's gmem_ops, potentially causing a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f09647f427565c1789a=
6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk?part=3D8
