Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E956ACD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5032510F9A3;
	Mon,  8 Jun 2026 20:14:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RAFTumQb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 792DB10F9A3
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 20:14:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F155C6001D;
 Mon,  8 Jun 2026 20:14:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7147A1F00893;
 Mon,  8 Jun 2026 20:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780949640;
 bh=8orBKRM4MAXgqBpW0aJAW+AhXYKRSn96Pqp90lBMjPI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RAFTumQbFMg1UbQeAB48dRU2RpivMu+c/ccKi4CkBlFowdeOCya4G5ztdP5l/P4L6
 HBvhv4hZWYm3q6M0zGYu/x+s2J5z706IRvzsviy0sZ7OoOFP5/NDNv71EUdKkkgHYF
 H2srw+tRGvj+nwJxzKhecI38c2wSsf1vJoLOjRjLB3aKESg+MSfD7vTpKrj9bTk+YT
 UA3rIG6SMhJvc77eixUTq+JDchydgPdfpDzO1xgLbGQ7UwVectWselDNBCkBLx2xOr
 nZ/VXxjn9y2bAr1qH16VwgxOtbFfiX0kRetYJ15MqpCaLIITDYVbBxH/gbE98y32im
 /lY4PuGMyI/+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/19] rust: io: add projection macro and methods
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 ojeda@kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260608-io_projection-v3-12-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-12-c5cde13a5ec4@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:13:59 +0000
Message-Id: <20260608201400.7147A1F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unsound `AsBytes` implementation for `Region<SIZE>` leading to und=
efined behavior due to alignment padding.
- [Low] Incorrect use of `#[inline(always)]` on `ProjectHelper` methods, vi=
olating subsystem coding guidelines.
--

commit ab6f2e99706c5568aaec1a417178b7f6d1435b90
Author: Gary Guo <gary@garyguo.net>

rust: io: add projection macro and methods

Add a io_project!() macro allows projection from Io to a subview of it,
using the pointer projection mechanism to perform compile-time checks.
For cases where type-casting is required, the try_cast() function may be
used where the size and alignment checks are performed at runtime.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 9c2ea17ca87b5..173f8c0ba2d6c 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
[ ... ]
> @@ -92,6 +96,11 @@ fn size(p: *const Self) -> usize {
>      }
>  }
> =20
> +// SAFETY: I/O regions can compose of arbitrary bytes.
> +unsafe impl<const SIZE: usize> kernel::transmute::FromBytes for Region<S=
IZE> {}
> +// SAFETY: Values read from I/O are always treated as initialized.
> +unsafe impl<const SIZE: usize> kernel::transmute::AsBytes for Region<SIZ=
E> {}

[Severity: High]
Does this implementation of AsBytes for Region<SIZE> introduce undefined
behavior due to alignment padding?

Region<SIZE> is defined with an alignment constraint and contains an
unsized [u8] field. Because core::mem::size_of_val for dynamically sized
types rounds the size up to a multiple of the alignment, a Region created
with a size that is not a multiple of 8 (on 64-bit systems) will include
trailing padding bytes.

Since AsBytes::as_bytes() relies on size_of_val(self) to slice the memory,
calling it on &Region<SIZE> could produce a &[u8] that extends past the
actual allocated length into out-of-bounds or uninitialized memory.

> +
>  /// Raw representation of an MMIO region.
>  ///
>  /// `MmioRaw<T>` is equivalent to `T __iomem *` in C.
[ ... ]
> @@ -983,3 +1039,78 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {
>  // MMIO regions on 64-bit systems also support 64-bit accesses.
>  #[cfg(CONFIG_64BIT)]
>  impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_rel=
axed);
> +
> +// This helper turns associated functions to methods so it can be invoke=
d in macro.
> +// Used by `io_project!()` only.
> +#[doc(hidden)]
> +#[derive(Clone, Copy)]
> +pub struct ProjectHelper<T>(pub T);
> +
> +impl<'a, T> ProjectHelper<T>
> +where
> +    T: Io<'a, Backend: IoBackend<View<'a, T::Target> =3D T>>,
> +{
> +    // These helper methods must not have symbols present in binary to a=
void confusion.
> +    #[inline(always)]
> +    pub fn as_ptr(self) -> *mut T::Target {

[Severity: Low]
This isn't a bug, but should this use #[inline] instead of #[inline(always)=
]?

According to the rust subsystem guidelines, functions that are small or
forwarding to a binding call in abstractions should be annotated with
#[inline].

The #[inline(always)] annotation should be reserved for functions using
build_assert!() that depend on function parameters.

> +        T::Backend::as_ptr(self.0)
> +    }
> +
> +    /// # Safety
> +    ///
> +    /// Same as `IoBackend::project_view`
> +    #[inline(always)]
> +    pub unsafe fn project_view<U: ?Sized + KnownSize>(

[Severity: Low]
This isn't a bug, but should this use #[inline] instead of #[inline(always)=
]?

According to the rust subsystem guidelines, functions that are small or
forwarding to a binding call in abstractions should be annotated with
#[inline].

The #[inline(always)] annotation should be reserved for functions using
build_assert!() that depend on function parameters.

> +        self,
> +        ptr: *mut U,
> +    ) -> <T::Backend as IoBackend>::View<'a, U> {
> +        // SAFETY: Per safety requirement.
> +        unsafe { T::Backend::project_view::<T::Target, _>(self.0, ptr) }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-io_project=
ion-v3-0-c5cde13a5ec4@garyguo.net?part=3D12
