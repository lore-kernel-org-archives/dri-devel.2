Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280C0CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8460311A29A;
	Thu,  4 Jun 2026 19:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ah7oufMl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EEAF11A298
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 19:41:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DFA36001A;
 Thu,  4 Jun 2026 19:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155B11F00893;
 Thu,  4 Jun 2026 19:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780602083;
 bh=ShuVlLWC5FgBtDaDVnuK31drZ5jQl97zhyIfpyaIgJ4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ah7oufMlAxcMhs/B68reBXMm0ou7AOmSOo3Q6clR34dNTXfdFsuN9xUEKa8axgXli
 XAqKcU1PKU3ggJG+QOdFVwC3Z7S+g4F4UHRwIFS8ZAkPqDvN2FfBnKyd66cUmgfZrw
 /6PNMWPH1YJlwGBnasYvrDkHx5txsNbtwLDcaXblEUieBi2E67cNZp2MgrZH69Ipe3
 ZIvmlXF3uadTSQbfXNbFnD2WY6ExhUkAYLS8yQdjLPldOnVLepZv6lBgaCVliwNeaF
 IqTMazO/XUtJdJEqFc9k4RLEKNt6w0xrij0dK+bpm6XO980qwHGLVH/CJ210A51N+v
 MfZ7ks0Mlb0VQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 2/4] rust: drm: gem: shmem: Add vmap functions
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 ojeda@kernel.org
In-Reply-To: <20260604192740.659240-3-lyude@redhat.com>
References: <20260604192740.659240-3-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 19:41:22 +0000
Message-Id: <20260604194123.155B11F00893@smtp.kernel.org>
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
- [High] The `IoCapable` implementation for `VMap` uses non-volatile `ptr::=
read` and `ptr::write`, allowing the compiler to optimize away or reorder m=
emory accesses to shared device memory.
- [Medium] `VMap` and `VMapOwned` are implicitly `!Send` and `!Sync` due to=
 the `*mut c_void` field, artificially restricting the mapping to the threa=
d that created it.
- [Low] Missing `// INVARIANT:` comment explaining `VMap` memory validity a=
t its construction site, violating subsystem guidelines.
--

commit b418d73acbe560c4eda85331900333d19c6ae108
Author: Lyude Paul <lyude@redhat.com>

rust: drm: gem: shmem: Add vmap functions

One of the more obvious use cases for gem shmem objects is the ability to
create mappings into their contents. So, let's hook this up in our rust
bindings.

> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index 4cf038f7afb71..a20b0c0dac6bd 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs

[ ... ]

> @@ -188,6 +196,80 @@ extern "C" fn free_callback(obj: *mut bindings::drm_=
gem_object) {
>          // SAFETY: We're recovering the Kbox<> we created in gem_create_=
object()
>          let _ =3D unsafe { KBox::from_raw(this) };
>      }
> +
> +    /// Attempt to create a vmap from the gem object, and confirm the si=
ze of said vmap.
> +    fn make_vmap<'a, R, const SIZE: usize>(&'a self) -> Result<VMap<T, R=
, C, SIZE>>
> +    where
> +        R: Deref<Target =3D Self> + From<&'a Self>,
> +    {

[ ... ]

> +        // XXX: We don't currently support iomem allocations
> +        if map.is_iomem {
> +            // SAFETY:
> +            // - The vmap operation above succeeded, guaranteeing that `=
map` points to a valid
> +            //   memory mapping.
> +            // - We checked that this is an iomem allocation, making it =
safe to read vaddr_iomem
> +            unsafe { self.raw_vunmap(map) };
> +
> +            Err(ENOTSUPP)
> +        } else {
> +            Ok(VMap {
> +                // SAFETY: We checked that this is not an iomem allocati=
on, making it safe to read
> +                // vaddr
> +                addr: unsafe { map.__bindgen_anon_1.vaddr },
> +                owner: self.into(),
> +            })

[Severity: Low]
This isn't a bug, but there's a missing invariant comment here.

The Rust subsystem guidelines mention that when a struct with an
# Invariants documentation section is constructed, the code should have an
// INVARIANT: comment explaining why the invariants are satisfied.

Would it make sense to add a comment here explaining why the memory remains
valid until dropped?

> +        }
> +    }

[ ... ]

> @@ -264,3 +345,232 @@ fn drop(&mut self) {
>          unsafe { bindings::dma_resv_unlock(self.0.raw_dma_resv()) };
>      }
>  }
> +
> +macro_rules! impl_vmap_io_capable {
> +    ($impl:ident, $ty:ty) =3D> {
> +        impl<D, R, C, const SIZE: usize> IoCapable<$ty> for $impl<D, R, =
C, SIZE>
> +        where
> +            D: DriverObject,
> +            C: DeviceContext,
> +            R: Deref<Target =3D Object<D, C>>,
> +        {
> +            #[inline(always)]
> +            unsafe fn io_read(&self, address: usize) -> $ty {
> +                let ptr =3D address as *mut $ty;
> +
> +                // SAFETY: The safety contract of `io_read` guarantees t=
hat address is a valid
> +                // address within the bounds of `Self` of at least the s=
ize of $ty, and is properly
> +                // aligned.
> +                unsafe { ptr::read(ptr) }
> +            }

[Severity: High]
Can this allow the compiler to improperly optimize these memory accesses?

Since VMap represents GEM shmem objects mapped into the kernel virtual
address space, this memory might be concurrently accessed by hardware or
userspace.

Using standard non-volatile ptr::read and ptr::write allows the compiler
to cache values in registers, coalesce writes, or elide them entirely. The C
equivalent (iosys_map_rd and iosys_map_wr) uses READ_ONCE() and
WRITE_ONCE() for this reason.

Should this use ptr::read_volatile() to safely access the shared memory?

> +
> +            #[inline(always)]
> +            unsafe fn io_write(&self, value: $ty, address: usize) {
> +                let ptr =3D address as *mut $ty;
> +
> +                // SAFETY: The safety contract of `io_write` guarantees =
that address is a valid
> +                // address within the bounds of `Self` of at least the s=
ize of $ty, and is properly
> +                // aligned.
> +                unsafe { ptr::write(ptr, value) }
> +            }

[Severity: High]
Similar to the io_read() implementation above, does this write need to use
ptr::write_volatile() to prevent the compiler from caching or coalescing
these shared memory writes?

> +        }
> +    };
> +}
> +
> +/// A reference to a virtual mapping for an shmem-based GEM object in ke=
rnel address space.
> +///
> +/// # Invariants
> +///
> +/// - The size of `owner` is >=3D SIZE.
> +/// - The memory pointed to by addr remains valid at least until this ob=
ject is dropped.
> +pub struct VMap<D, R, C =3D Registered, const SIZE: usize =3D 0>
> +where
> +    D: DriverObject,
> +    C: DeviceContext,
> +    R: Deref<Target =3D Object<D, C>>,
> +{
> +    addr: *mut c_void,
> +    owner: R,
> +}

[Severity: Medium]
Does this unintentionally restrict the mapping to the thread that created i=
t?

Because VMap stores its mapping address as a raw pointer
addr: *mut c_void, it implicitly lacks the Send and Sync traits in Rust.
This means VMap and VMapOwned cannot be safely transferred or shared
across concurrency boundaries.

Since the kernel's virtual mapping should be globally valid as long as the
underlying owner object provides safe concurrent access, should explicit
unsafe impl Send and unsafe impl Sync be provided for this struct?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604192740.6592=
40-1-lyude@redhat.com?part=3D2
