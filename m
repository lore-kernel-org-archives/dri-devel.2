Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5093FCD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 20:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AAA10F99A;
	Mon,  8 Jun 2026 20:09:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SxlTOf2U";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF3610F992
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 20:09:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 60D6E434C6;
 Mon,  8 Jun 2026 20:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0393A1F00898;
 Mon,  8 Jun 2026 20:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780949384;
 bh=B2zm4p05VMMW/N8ec1jbpv/zD3S9tUl1Fx5w+6hjul0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SxlTOf2U0lm+SYj93zDyeOZxsYsrjv9IaQrKAHWDnoW9+Mj3n+jF4Es2rHj58LTgl
 lybKWEb+4vgxdZ8AN80S3WTDfOIMavte7nUZDFtTDBi9htCGvASMYpl8WiexYoQJk4
 ZH4MG3yN5i+tlqnmQKW15A8pOf8hsW0isnMe/j00dqkiUKweyFrmBJrZyQC4sqJifH
 ivC0Xqn997++A3YcyR/a7ST3vhnRUBYS5OrJwEqZyy7qx1BFATlW3X0c+bvubQNcfT
 p3WWM0ssN5SbfUuMdmz0dJSmUNTWk/DPCxb4LjdmOeL5ycgPoFhEAHFrLiEa8gUQY3
 dkX/zfOpP/NxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/19] rust: io: add I/O backend for system memory
 with volatile access
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260608-io_projection-v3-13-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-13-c5cde13a5ec4@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:09:43 +0000
Message-Id: <20260608200944.0393A1F00898@smtp.kernel.org>
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
- [High] Missing explicit `Send` and `Sync` trait implementations for `SysM=
em`.
- [High] `RelaxedMmio` lacks `Send` and `Sync` trait implementations.
- [Low] Missing `#[inline]` annotations on small forwarding functions `io_r=
ead` and `io_write` in `SysMemBackend`.
--

commit d4531b875e419c5220ee6e82d5fc9e251929f095
Author: Laura Nao <laura.nao@collabora.com>
Subject: rust: io: add I/O backend for system memory with volatile access

This commit adds a SysMem structure and backend for kernel virtual address
ranges. It implements the IoCapable trait for primitive types, utilizing
volatile accesses to provide safe access to shared memory. This provides an
alternative to Coherent memory when another layer handles device mapping.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 173f8c0ba2d6c..580ca88c46ccc 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -1040,6 +1040,120 @@ pub fn relaxed(self) -> RelaxedMmio<'a, T> {

[Severity: High]
Does RelaxedMmio lack explicit Send and Sync trait implementations?

Similar to SysMem introduced below, RelaxedMmio was refactored earlier in
this patch series to contain a *mut T inside its ptr field:

rust/kernel/io.rs:
pub struct RelaxedMmio<'a, T: ?Sized> {
    ptr: *mut T,
    phantom: PhantomData<&'a ()>,
}

While Mmio explicitly implements Send and Sync, RelaxedMmio does not.
Because of this, it is now implicitly !Send and !Sync. This seems to be a
regression introduced by this series, as the prior version of RelaxedMmio
implicitly derived Send/Sync from a usize address representation.

Without these traits, RelaxedMmio cannot be shared between threads, stored
in a Mutex, or passed across thread boundaries. Could this limit its usabil=
ity
in device drivers?

>  #[cfg(CONFIG_64BIT)]
>  impl_mmio_io_capable!(RelaxedMmioBackend, u64, readq_relaxed, writeq_rel=
axed);

[ ... ]

> +macro_rules! impl_sysmem_io_capable {
> +    ($ty:ty) =3D> {
> +        impl IoCapable<$ty> for SysMemBackend {
> +            fn io_read(view: SysMem<'_, $ty>) -> $ty {

[Severity: Low]
Does this small forwarding function need an #[inline] annotation?

According to the Rust Subsystem guidelines for abstractions, functions that=
 are
small or just forward to an underlying call should be annotated with #[inli=
ne].
Since io_read is extremely short and directly wraps read_volatile, does it
require the attribute to prevent suboptimal code generation?

> +                // SAFETY:
> +                // - Per type invariant, `ptr` is valid and aligned.
> +                // - Using read_volatile() here so that race with hardwa=
re is well-defined.
> +                // - Using read_volatile() here is not sound if it races=
 with other CPU per Rust
> +                //   rules, but this is allowed per LKMM.
> +                // - The macro is only used on primitives so all bit pat=
terns are valid.
> +                unsafe { view.ptr.read_volatile() }
> +            }
> +
> +            fn io_write(view: SysMem<'_, $ty>, value: $ty) {

[Severity: Low]
Should this small forwarding function also have an #[inline] annotation?

Like io_read above, this directly wraps write_volatile and appears to fall
under the guidelines requiring #[inline] for small forwarding functions.

> +                // SAFETY:
> +                // - Per type invariant, `ptr` is valid and aligned.
> +                // - Using write_volatile() here so that race with hardw=
are is well-defined.
> +                // - Using write_volatile() here is not sound if it race=
s with other CPU per Rust
> +                //   rules, but this is allowed per LKMM.
> +                unsafe { view.ptr.write_volatile(value) }
> +            }
> +        }
> +    };
> +}

[ ... ]

> +/// System memory region.
> +///
> +/// Provides `Io` trait implementation for kernel virtual address ranges,
> +/// using volatile read/write to safely access shared memory that may be
> +/// concurrently accessed by external hardware.
> +///
> +/// # Invariants
> +///
> +/// `self.ptr.addr() .. self.ptr.addr() + KnownSize::size(self.ptr)` is =
valid and aligned kernel
> +/// accessible memory region for the lifetime `'a`.
> +pub struct SysMem<'a, T: ?Sized> {
> +    ptr: *mut T,
> +    phantom: PhantomData<&'a ()>,
> +}

[Severity: High]
Does SysMem need explicit Send and Sync implementations?

Because SysMem holds a *mut T internal pointer, it is implicitly !Send
and !Sync.

Since it represents an I/O mapping which can be safely shared across threads
(provided T: Sync) and volatile accesses handle hardware races according to
the LKMM, missing these implementations prevents SysMem from being passed
across thread boundaries or embedded into device state structures managed by
Arc or Mutex.

Will this severely restrict its usability in multi-threaded environments,
such as typical device drivers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-io_project=
ion-v3-0-c5cde13a5ec4@garyguo.net?part=3D13
