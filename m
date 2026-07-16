Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AC7C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:30:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D377E10E3A2;
	Thu, 16 Jul 2026 15:30:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EGBTPv7N";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7B7F10E3A6
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:30:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5903560A6E;
 Thu, 16 Jul 2026 15:30:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC3B1F000E9;
 Thu, 16 Jul 2026 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784215805;
 bh=3BGn5puD2EBaMaIf/11InBqC7iJBnOjjLNUdkyXw58Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EGBTPv7Nyj0afMbPmfFNoDJCyWvebybMPZmQuUa0VwIhj/Sn/dJBEQBSJFds2IlOM
 ShygCPaxSdFw/etLPazoy3IZ5l96kaQW3fJFLd5Dg8eR53/oL9eHKj/QtEVkoDBs0o
 tY2AUMqC+0RhtMxBY+fO9rWDHUmXdgKcClcxHK30a0QbKyZwvZn64obFApPk/wle1b
 K7EmxZv9UtDHUs+SPKcRyVN29Cam2F3dal56Wk9yaHkOiYm0YAzhcO7OSXSuJiKBrI
 cQDJyE8YR7LpCfRuuxZfsNIfrPdNzmCppgsPxO4ySSvvGKs8mWk5XcjJPdIw+kUqEe
 kk2faIsvQK3qw==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 04/11] KVM: guest_memfd: Introduce guest memory ops
 and route native gmem through them
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: kvm@vger.kernel.org, media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <1256966e1b1b112ad92bf1b248c439ac23d61535.1784194290.git.dwmw@amazon.co.uk>
References: <f09647f427565c1789a6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk>
 <1256966e1b1b112ad92bf1b248c439ac23d61535.1784194290.git.dwmw@amazon.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:30:04 +0000
Message-Id: <20260716153004.CBC3B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Dropped page reference in `kvm_gmem_populate_one` causes a TOC=
TOU Use-After-Free on physical pages.
- [High] Use-After-Free (UAF) in `kvm_gmem_unbind` due to lockless derefere=
nce of unrefcounted `slot->gmem.file`.
- [High] Missing module reference count in `kvm_gmem_ops` allows foreign ba=
ckend unload, causing kernel panic.
- [High] `kvm_gmem_bind` API contract fails to initialize `slot->gmem.file`=
, breaking KVM core state tracking.
--

--- Patch [4]: [RFC PATCH 04/11] KVM: guest_memfd: Introduce guest memory o=
ps and route native gmem through them ---
commit 4ae3212093e20a291a948708162e27b1bb7009da
Author: David Woodhouse <dwmw@amazon.co.uk>

KVM: guest_memfd: Introduce guest memory ops and route native gmem through =
them

This commit introduces a kvm_gmem_ops vtable to allow other subsystems to
supply guest memory backing. It routes the built-in guest_memfd operations
through this vtable and refactors the generic bind, unbind, and populate
flows.

> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index ab8cfaec82d31..b33d2f4750426 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
[ ... ]
> @@ -621,6 +621,88 @@ static inline bool kvm_slot_has_gmem(const struct kv=
m_memory_slot *slot)
>  	return slot && (slot->flags & KVM_MEM_GUEST_MEMFD);
>  }
> =20
> +#ifdef CONFIG_KVM_GUEST_MEMFD
> +/*
> + * struct kvm_gmem_ops - vtable a guest_memfd backing implementation exp=
oses.
> + *
> + * Every file that can back KVM guest memory -- KVM's own guest_memfd (s=
ee
> + * kvm_gmem_create()) and any other subsystem opting in -- is created wi=
th
> + * the shared kvm_gmem_fops (see is_kvm_gmem_file()).  file->private_dat=
a on
> + * such a file points at a struct kvm_gmem_backing whose ->ops field is =
the
> + * per-instance vtable below.  KVM never looks any further; the rest of =
the
> + * per-file state (allocator, refcount, private xarray, ...) is up to the
> + * implementation and is reached via container_of() from the backing.
> + *
> + * The memory-side callbacks (bind, unbind, get_pfn, populate, invalidat=
e)
> + * are the reason the interface exists.  The file-level callbacks (relea=
se,
> + * mmap, fallocate, ...) are dispatched by kvm_gmem_fops so that every
> + * implementation gets a private hook -- see the dispatchers in
> + * virt/kvm/guest_memfd.c.
> + *
> + * get_pfn() contract:
> + *  - *pfn is the host PFN backing @gfn.  It need not have a struct page.
> + *  - *max_order is the largest order KVM may use to map starting at @gf=
n.
> + *    The implementation MUST clamp it to the physical contiguity and the
> + *    HPA/GPA alignment of the backing, so KVM never builds a huge SPTE =
that
> + *    spans discontiguous physical memory.
> + *  - If *page is non-NULL on return the caller owns that page reference=
 and
> + *    is responsible for put_page() after use.  If *page is left NULL th=
e PFN
> + *    is treated as non-refcounted, and its lifetime is owned by the
> + *    implementation across bind()/unbind().
> + *
> + * Memory intended to back guest RAM MUST be reported as E820_TYPE_RAM b=
y the
> + * host so KVM maps it write-back (and applies the memory-encryption bit=
 on
> + * encrypted hosts) rather than treating it as MMIO.
> + */
> +struct kvm_gmem_ops {
> +	/* Memory operations. */

[Severity: High]
Is there a missing module reference count in struct kvm_gmem_ops?=20

The operations table lacks an owner field (like struct module *owner) to pin
the backend module.

Since the shared kvm_gmem_fops routes file operations to a foreign backend's
vtable, could a user open the guest_memfd, unload the backend module, and
then close the file? The release dispatcher would then call into the unload=
ed
module's release hook, potentially causing a kernel panic.

> +	int (*bind)(struct file *file, struct kvm *kvm,
> +		    struct kvm_memory_slot *slot, loff_t offset);
[ ... ]
> diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
> index db57c5766ab60..2b277468a12f0 100644
> --- a/virt/kvm/guest_memfd.c
> +++ b/virt/kvm/guest_memfd.c
[ ... ]
> @@ -692,15 +782,51 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memor=
y_slot *slot,
[ ... ]
> +int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
> +		  unsigned int fd, uoff_t offset)
> +{
> +	const struct kvm_gmem_ops *ops;
> +	struct file *file;
> +	int r;
> +
> +	BUILD_BUG_ON(sizeof(gpa_t) !=3D sizeof(offset));
> +	BUILD_BUG_ON(sizeof(gfn_t) !=3D sizeof(slot->gmem.pgoff));
> +
> +	file =3D fget(fd);
> +	if (!file)
> +		return -EBADF;
> +
> +	ops =3D kvm_gmem_get_ops(file);
> +	if (!ops || !ops->bind || !ops->get_pfn) {
> +		r =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (!PAGE_ALIGNED(offset)) {
> +		r =3D -EINVAL;
> +		goto out;
> +	}
> =20
>  	/*
> -	 * Drop the reference to the file, even on success.  The file pins KVM,
> -	 * not the other way 'round.  Active bindings are invalidated if the
> -	 * file is closed before memslots are destroyed.
> +	 * On success .bind() associates the fd with @kvm and (if the
> +	 * implementation needs it) records the reference that makes the fd
> +	 * pin the VM.  A .bind() that returns success is trusted to have
> +	 * done so; there is no separate ownership check here.
> +	 */
> +	r =3D ops->bind(file, kvm, slot, offset);
> +out:
> +	/*
> +	 * Drop the reference to the file even on success.  The file pins
> +	 * KVM, not the other way 'round: it is the implementation's job to
> +	 * invalidate its bindings if the fd is closed before the memslots
> +	 * are destroyed.
>  	 */
> -	r =3D 0;
> -err:
>  	fput(file);
>  	return r;
>  }

[Severity: High]
Does this function miss initializing slot->gmem.file on a successful bind?

KVM core code relies heavily on slot->gmem.file being populated to later ca=
ll
unbind. If a foreign backend succeeds in ops->bind but doesn't intentionally
mutate KVM's internal slot->gmem.file state, KVM might never call unbind
when the memslot is subsequently freed.

Could this leak backend resources or leave dangling memslot pointers in the
backend?

> @@ -741,15 +861,41 @@ void kvm_gmem_unbind(struct kvm_memory_slot *slot)
[ ... ]
> +void kvm_gmem_unbind(struct kvm *kvm, struct kvm_memory_slot *slot)
> +{
> +	const struct kvm_gmem_ops *ops;
> +	struct file *file;
> +
> +	/*
> +	 * Nothing to do if the underlying file was _already_ closed, as
> +	 * kvm_gmem_release() invalidates and nullifies all bindings.
> +	 */
> +	file =3D READ_ONCE(slot->gmem.file);
> +	if (!file)
> +		return;
> +
> +	ops =3D kvm_gmem_get_ops(file);

[Severity: High]
Is it safe to dereference the file locklessly here?

The generic code previously used get_file_active() to safely obtain a
reference. Because kvm_gmem_bind() intentionally drops its reference to the
file on success (via fput(file)), userspace can close the guest_memfd
concurrently while the memslot is being destroyed.

Could this result in a use-after-free when kvm_gmem_get_ops() attempts to
dereference the unrefcounted file pointer?

> +	if (ops && ops->unbind)
> +		ops->unbind(file, kvm, slot);
[ ... ]
> @@ -860,11 +1020,50 @@ static long __kvm_gmem_populate(struct kvm *kvm, s=
truct kvm_memory_slot *slot,
>  	return ret;
>  }
> =20
> +static int kvm_gmem_populate_one(const struct kvm_gmem_ops *ops,
> +				      struct file *file, struct kvm *kvm,
> +				      struct kvm_memory_slot *slot, gfn_t gfn,
> +				      struct page *src_page,
> +				      kvm_gmem_populate_cb post_populate,
> +				      void *opaque)
> +{
> +	kvm_pfn_t pfn;
> +	int ret;
> +
> +	/*
> +	 * Resolve the PFN via the ops.  A populate() op may also copy
> +	 * @src_page into the backing before the arch post_populate() step
> +	 * (e.g. SNP LAUNCH_UPDATE); otherwise fall back to get_pfn().
> +	 */
> +	if (ops->populate)
> +		ret =3D ops->populate(file, kvm, slot, gfn, &pfn,
> +				    src_page, 0);
> +	else {
> +		struct page *ignored_page =3D NULL;
> +
> +		ret =3D ops->get_pfn(file, kvm, slot, gfn, &pfn,
> +				   &ignored_page, NULL);
> +		/*
> +		 * Populate does not consume a refcount on the destination page.
> +		 * If get_pfn() handed a refcount back through @page, drop it.
> +		 * Implementations whose PFNs aren't refcounted per-call leave
> +		 * @page NULL and this is a no-op.
> +		 */
> +		if (!ret && ignored_page)
> +			put_page(ignored_page);
> +	}
> +	if (ret)
> +		return ret;
> +
> +	return post_populate(kvm, gfn, pfn, src_page, opaque);
> +}

[Severity: Critical]
Does dropping the page reference before calling post_populate() introduce a
time-of-check to time-of-use race?

If the backend provides a physical page via get_pfn() and we drop the pin
with put_page(ignored_page) early, the page could be concurrently freed and
reallocated to another process.

Could this cause the hardware post_populate callback (such as SNP RMPUPDATE)
to operate on a physical page that now belongs to an innocent host process,
corrupting host memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/f09647f427565c1789a=
6979470045aab78661563.1784194290.git.dwmw@amazon.co.uk?part=3D4
