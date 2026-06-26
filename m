Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6FFC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 15:02:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE97A10F614;
	Fri, 26 Jun 2026 15:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AE6Zv4j1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07FB610F614
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 15:02:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E531340617;
 Fri, 26 Jun 2026 15:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B64A1F000E9;
 Fri, 26 Jun 2026 15:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782486157;
 bh=cbr8ye5rw9jmWY8ONcUV1sml5tQtUQEauN1qPctTyJM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AE6Zv4j1EsrP5JCE5pg0SvEpgkRZRaLJeF7fQafHJV+eruiZM8H8V9nCbhkZ33uuQ
 xjEn41WgL9nRJVwsffJr+lofrE9fD09QXJ27X6VAmfjz+I5LwzkYxmXy+tPc4BZc+3
 Lv7LwjwhOZ7/LsrfQjdbgr3S7vvQJ5gEQWcxyEmlPP0tTB7w2fMl8UImdzUnAbWPsQ
 5zcFoFpYVnVzwW4kRX75owWK0ZCMDuyaCRxhStUxwZBBCyT0oxuOu0hysKcxqC078o
 TjX2F3vAa79AS+7F1mXsBGvfZ55jK1Aqxvndk2E92JVphLlDI+BH5rb7bhOBWy8LzW
 SJYHOAhuMVLig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/20] rust: io: generalize `MmioRaw` to pointer to
 arbitrary type
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 ojeda@kernel.org
In-Reply-To: <20260626-io_projection-v5-5-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-5-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:02:36 +0000
Message-Id: <20260626150237.3B64A1F000E9@smtp.kernel.org>
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

New issues:
- [High] `IoMem::ioremap` dynamically rejects valid hardware resources whos=
e size is not a multiple of 4 or whose base address is unaligned.
- [Medium] The infallible 64-bit accessors (`read64`, `write64`, etc.) fail=
 to compile on 64-bit platforms when used with `Mmio` due to a flawed stati=
c alignment assertion.
- [Low] Missing `// INVARIANT:` comment when returning a validated pointer =
establishing the `Region` struct's invariants.

Pre-existing issues:
- [High] The virtual address mapped by `ioremap` is leaked if `MmioRaw::new=
_region` fails.
--

commit 4ac7791c4c497b9e3e333241d199ec287a09b395
Author: Gary Guo <gary@garyguo.net>

rust: io: generalize MmioRaw to pointer to arbitrary type

Conceptually, MmioRaw is just __iomem *, so it should work for any
types. Update the existing use case where it represents a region of
compile-time known minimum size and run-time known actual size to use the
dynamic-sized type Region<SIZE> instead. Rename maxsize method to
reflect that it is the actual size (not a bound) of the region.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 9f060dd291826..12be266d7ed7e 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
[ ... ]
> +impl<const SIZE: usize> MmioRaw<Region<SIZE>> {
> +    /// Create a MmioRaw representing a I/O region with given size.
> +    ///
> +    /// The size is checked against the minimum size specified via const=
 generics.
> +    #[inline]
> +    pub fn new_region(addr: usize, size: usize) -> Result<Self> {
> +        Ok(Self {
> +            ptr: Region::ptr_try_from_raw_parts_mut(core::ptr::without_p=
rovenance_mut(addr), size)?,
> +        })
> +    }
> +}

[Severity: Low]
Is there a missing // INVARIANT: comment when returning a validated pointer
establishing the Region struct's invariants?

The Region type has a documented # Invariants section.
Region::ptr_try_from_raw_parts_mut() validates these invariants and returns
a pointer that establishes them, but seems to lack the mandatory comment
explaining how the checks satisfy the invariants:

rust/kernel/io.rs:Region::ptr_try_from_raw_parts_mut() {
    ...
    Ok(Self::ptr_from_raw_parts_mut(base, size))
    ...
}

[ ... ]
> @@ -193,7 +224,7 @@ pub fn maxsize(&self) -> usize {
>  /// # }
>  /// ```
>  #[repr(transparent)]
> -pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<SIZE>);
> +pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<Region<SIZE>>);

[Severity: Medium]
Can this fail to compile on 64-bit platforms when using infallible 64-bit
accessors like read64() or write64()?

When U is u64 (alignment 8 on 64-bit systems) and the Target is Region<SIZE=
>,
Region specifies #[repr(C, align(4))] which sets MIN_ALIGN to 4.

This causes the assertion strictly bounding the requested type's alignment
to evaluate to false:

rust/kernel/io.rs:io_view_assert() {
    ...
    const_assert!(Alignment::of::<U>().as_usize() <=3D IO::Target::MIN_ALIG=
N.as_usize());
    ...
}

[ ... ]
> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index fc2a3e24f8d5d..9e15bc8fde784 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs
[ ... ]
> @@ -264,8 +264,7 @@ fn ioremap(dev: &'a Device<Bound>, resource: &Resourc=
e) -> Result<Self> {
>              return Err(ENOMEM);
>          }
> =20
> -        let io =3D MmioRaw::new(addr as usize, size)?;
> -
> +        let io =3D MmioRaw::new_region(addr as usize, size)?;

[Severity: High]
Could this unconditionally reject valid hardware resources whose size is not
a multiple of 4 or whose base address is unaligned?

MmioRaw::new_region() calls Region::ptr_try_from_raw_parts_mut() which enfo=
rces
overly restrictive alignment and size checks. Device drivers probing hardwa=
re
with I/O regions like 1-byte RTCs or 2-byte serial ports will fail to load:

rust/kernel/io.rs:Region::ptr_try_from_raw_parts_mut() {
    ...
    if size < SIZE || base.align_offset(4) !=3D 0 || !size.is_multiple_of(4=
) {
        return Err(EINVAL);
    }
    ...
}

[Severity: High]
This isn't a bug introduced by this patch, but does this code leak the virt=
ual
address mapped by bindings::ioremap() if MmioRaw::new_region() fails?

The ? operator here immediately propagates the error. Unlike Bar::new() whi=
ch
explicitly cleans up with bindings::pci_iounmap() on failure, this path fai=
ls
to call bindings::iounmap() before returning.

>          Ok(IoMem { dev, io })
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D5
