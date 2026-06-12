Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1E3CD98CE
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 20:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AED9610E0D5;
	Fri, 12 Jun 2026 20:28:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e6J5DesM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C100C10E0D5
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 20:28:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 699B243465;
 Fri, 12 Jun 2026 20:28:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2577C1F000E9;
 Fri, 12 Jun 2026 20:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781296121;
 bh=BgZW0bYsX10TGa7+gt81cJ8W6oXBT2P5ugT83+Pc7vU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e6J5DesM4S0r4+jGiRwAcQikRqvP6Mzhk+yGei3EUyMMliNK4EBUIIUY/0pZFAV/F
 f4gI4dNmEHjiNC698+y52E95joUCrSyBxKsvA37WyBibDrQWEZ8K0hmfG36XlYLXvo
 ehfruDcuMUxvPsbFe9wzFBwmo7CzFyiwAlnfldMPp6U0t1jsu35rzFU1wEsbD4k2gv
 rVj//pq2/qXIjUqsae+94Z29BWM1LtKGlTiZWwzQv2aQXli4DfQFL5xonkI7fUyrPl
 YH7bs9IsCbK/fC1KZO9+VBcYTkzjIKphwZZrVWRKjNoPXD9eIhh8C8/kUOlCnCeSEz
 +zBkN5M70dMBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 4/4] rust: drm: gem: Introduce
 shmem::Object::sg_table()
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260612194436.585385-5-lyude@redhat.com>
References: <20260612194436.585385-5-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 20:28:40 +0000
Message-Id: <20260612202841.2577C1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] `SGTableMap::drop()` unconditionally calls `__drm_gem_shmem_free_s=
gt_locked()`, which improperly frees the `sg_table` of imported DMA-BUF obj=
ects using `kfree()` instead of returning it to the exporter.
- [High] `Object::sg_table()` does not pin the GEM object, allowing the shr=
inker to purge it and free the scatter-gather table while Rust still holds =
references to it.
- [High] Concurrent execution of device unbind and GEM object free causes a=
 Use-After-Free of the GEM object inside `SGTableMap::drop`.
--

commit 91daf37fb73a3ed3254590bfb60a617c06f3950d
Author: Lyude Paul <lyude@redhat.com>
Subject: rust: drm: gem: Introduce shmem::Object::sg_table()

This commit introduces a devres-managed SGTable mapping for GEM shmem
objects in Rust, ensuring mappings are released on driver unbind.

> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs

[ ... ]

> @@ -183,18 +207,26 @@ extern "C" fn free_callback(obj: *mut bindings::drm=
_gem_object) {
>          // - We verified above that `obj` is valid, which makes `this` v=
alid
>          // - This function is set in AllocOps, so we know that `this` is=
 contained within a
>          //   `Object<T, C>`
> -        let this =3D unsafe { container_of!(Opaque::cast_from(this), Sel=
f, obj) }.cast_mut();
> +        let this =3D unsafe { container_of!(Opaque::cast_from(base), Sel=
f, obj) }.cast_mut();
> +
> +        // We need to drop `sgt_res` first, since doing so requires that=
 the GEM object is still
> +        // alive.
> +        // SAFETY:
> +        // - We verified above that `this` is valid.
> +        // - We are in free_callback, guaranteeing we have exclusive acc=
ess to `this` and that
> +        //   `sgt_res` will not be used after dropping it here.
> +        unsafe { ManuallyDrop::drop(&mut (*this).sgt_res) };
> +
>          // SAFETY:
>          // - We're in free_callback - so this function is safe to call.
>          // - We won't be using the gem resources on `this` after this ca=
ll.
> -        unsafe { bindings::drm_gem_shmem_release(this) };
> +        unsafe { bindings::drm_gem_shmem_release(base) };

[Severity: High]
Can this sequence cause a use-after-free if device unbind runs
concurrently with the last reference drop?

If the device unbind thread changes the Devres state to revoked and waits
in rcu::synchronize_rcu(), and free_callback() runs concurrently:

free_callback()
    ManuallyDrop::drop(&mut (*this).sgt_res)

Because the state is already revoked, will Devres::drop() return immediately
without waiting for the unbind thread? free_callback() would then proceed
to call drm_gem_shmem_release() and free the GEM object memory.

When the unbind thread finishes synchronize_rcu(), it will call
SGTableMap::drop() which dereferences the now-freed GEM object:

SGTableMap::drop()
    let obj =3D unsafe { self.obj.as_ref() };

[ ... ]

> +impl<T: DriverObject, C: DeviceContext> Drop for SGTableMap<T, C> {
> +    fn drop(&mut self) {
> +        // SAFETY: `obj` is always valid via our type invariants
> +        let obj =3D unsafe { self.obj.as_ref() };
> +        let _lock =3D DmaResvGuard::new(obj);
> +
> +        // SAFETY: We acquired the lock needed for calling this function=
 above
> +        unsafe { bindings::__drm_gem_shmem_free_sgt_locked(obj.as_raw_sh=
mem()) };

[Severity: High]
Does this unconditionally free the scatter-gather table, even for imported
DMA-BUF objects?

The Rust GEM shmem abstraction supports imported DMA-BUF objects. For these
objects, the scatter-gather table is allocated and mapped by the exporter.

Calling __drm_gem_shmem_free_sgt_locked() here will unmap and call kfree()
on a pointer not allocated by this driver. Could this corrupt the exporter's
heap?

> +    }
> +}

[ ... ]

> +impl<T: DriverObject, C: DeviceContext> SGTableMap<T, C> {
> +    fn new(obj: &Object<T, C>) -> impl Init<Self, Error> {
> +        // INVARIANT:
> +        // - We call drm_gem_shmem_get_pages_sgt below and check whether=
 or not it succeeds,
> +        //   fulfilling the invariant of SGTableMap that the object's `s=
gt` field is initialized.
> +        // SAFETY:
> +        // - `obj` is fully initialized, making this function safe to ca=
ll.
> +        from_err_ptr(unsafe { bindings::drm_gem_shmem_get_pages_sgt(obj.=
as_raw_shmem()) })?;

[Severity: High]
Is the GEM object properly pinned here?

The documentation for Object::sg_table() states "This will pin the object
in memory." However, drm_gem_shmem_get_pages_sgt() increments
pages_use_count but does not increment pages_pin_count.

If the user marks the object with MADV_DONTNEED, could the shrinker purge
the object, freeing the scatter-gather table while Rust still hands out
references to it? This might also lead to a NULL pointer dereference later
in SGTableMap::drop() when it passes the freed table to
__drm_gem_shmem_free_sgt_locked().

> +
> +        Ok(Self { obj: obj.into() })
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612194436.5853=
85-1-lyude@redhat.com?part=3D4
