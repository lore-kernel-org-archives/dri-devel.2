Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A35C43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 14:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B5A510F63E;
	Fri, 26 Jun 2026 14:55:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NZ7vckfk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A50B10F63E
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 14:55:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3F7D242ABF;
 Fri, 26 Jun 2026 14:55:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE361F000E9;
 Fri, 26 Jun 2026 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782485748;
 bh=mqisg6aM5jOlYzz0CH4s5SiQiKRPVh/LuJv/aKxmeb4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NZ7vckfkBe5lw+TBV7j7EuZf4A7UpH+/fMjvBC1S9rbmj1LoLALV9JFf3JSVGAbf5
 HUeeMdXZ8uN86zGdSibvThI/DS6tpCQOj8NUgT3Sa7TU0q0Tdf5UqnX9CrsUNLNYeG
 PpfB42INEk3S0GY/WZWtyxl1KSWoEKZ8YPoI2jltlukCCBhJSw+Ta5c2KwFL+vUpjs
 wcmIcnwmmipiLihXsC019TK7KIoaA83VBpxs1ZtuHGUaBtwNcheEhcoV8pOAiAw14s
 jhoAqfKgksdYV8QIBDHh9kPq2ZAqKqFaVpmfBOfUle8wck6Z8BVwfGsQYVErxMV3CS
 P/cA3QkCfGmaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/20] rust: io: use view types instead of addresses
 for `Io`
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260626-io_projection-v5-9-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-9-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 14:55:47 +0000
Message-Id: <20260626145547.BBE361F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The abstraction methods `io_read` and `io_write` for `ConfigSpaceBa=
ckend` are missing the `#[inline]` annotation.
--

commit 4b02e1c6f87f5cb689ea18ffd09a2fb450c97ee7
Author: Gary Guo <gary@garyguo.net>
Subject: rust: io: use view types instead of addresses for Io

This commit introduces a new IoBackend trait to avoid monomorphization
duplication and defines operations on it using view types instead of
addresses. IoCapable implementations are moved to backends, and io_read
and io_write are made safe by relying on view invariants.

> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 89f4bb483a7f6..e67c1e3694fb8 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs

[ ... ]

> @@ -112,25 +138,24 @@ unsafe fn io_write(self, value: $ty, address: usize=
) {
>  /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_f=
n` and `$write_fn`.
>  macro_rules! impl_config_space_io_capable {
>      ($ty:ty, $read_fn:ident, $write_fn:ident) =3D> {
> -        impl<'a, T: ?Sized> IoCapable<$ty> for ConfigSpace<'a, T> {
> -            unsafe fn io_read(self, address: usize) -> $ty {
> +        impl IoCapable<$ty> for ConfigSpaceBackend {
> +            fn io_read(view: ConfigSpace<'_, $ty>) -> $ty {

[Severity: Low]
this isn't a bug, but should this small forwarding function be annotated
with #[inline]? The Rust subsystem guidelines state that functions in
abstractions that are small or forwarding to a binding call should be
annotated with #[inline].

> +                // CAST: The offset is cast to `i32` because the C funct=
ions expect a 32-bit
> +                // signed offset parameter. PCI configuration space size=
 is at most 4096 bytes,
> +                // so the value always fits within `i32` without truncat=
ion or sign change.
> +                let addr =3D view.ptr.addr() as i32;
> +
>                  let mut val: $ty =3D 0;
> =20
>                  // Return value from C function is ignored in infallible=
 accessors.
> -                let _ret =3D
> -                    // SAFETY: By the type invariant `self.pdev` is a va=
lid address.
> -                    // CAST: The offset is cast to `i32` because the C f=
unctions expect a 32-bit
> -                    // signed offset parameter. PCI configuration space =
size is at most 4096 bytes,
> -                    // so the value always fits within `i32` without tru=
ncation or sign change.
> -                    unsafe { bindings::$read_fn(self.pdev.as_raw(), addr=
ess as i32, &mut val) };
> -
> +                // SAFETY: By the type invariant `pdev` is a valid addre=
ss.
> +                let _ =3D unsafe { bindings::$read_fn(view.pdev.as_raw()=
, addr, &mut val) };
>                  val
>              }
> =20
> -            unsafe fn io_write(self, value: $ty, address: usize) {
> +            fn io_write(view: ConfigSpace<'_, $ty>, value: $ty) {

[Severity: Low]
this isn't a bug, but should this function also have the #[inline] annotati=
on?

> +                // CAST: The offset is cast to `i32` because the C funct=
ions expect a 32-bit
> +                // signed offset parameter. PCI configuration space size=
 is at most 4096 bytes,
> +                // so the value always fits within `i32` without truncat=
ion or sign change.
> +                let addr =3D view.ptr.addr() as i32;
> +
>                  // Return value from C function is ignored in infallible=
 accessors.
> -                let _ret =3D
> -                    // SAFETY: By the type invariant `self.pdev` is a va=
lid address.
> -                    // CAST: The offset is cast to `i32` because the C f=
unctions expect a 32-bit
> -                    // signed offset parameter. PCI configuration space =
size is at most 4096 bytes,
> -                    // so the value always fits within `i32` without tru=
ncation or sign change.
> -                    unsafe { bindings::$write_fn(self.pdev.as_raw(), add=
ress as i32, value) };
> +                // SAFETY: By the type invariant `pdev` is a valid addre=
ss.
> +                let _ =3D unsafe { bindings::$write_fn(view.pdev.as_raw(=
), addr, value) };
>              }
>          }
>      };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D9
