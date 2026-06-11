Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ABF9CD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 17:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC1110E824;
	Thu, 11 Jun 2026 17:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gzZKqE4h";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0375E10E824
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 17:07:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C751542A46;
 Thu, 11 Jun 2026 17:07:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB6E1F00893;
 Thu, 11 Jun 2026 17:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781197655;
 bh=fPpgR8Ii7Gq2wI/gsjk8ANn98sO4emon9U/HRJLVH9U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gzZKqE4hrOtoet+QGAnaY1umahBYvX4AIKt983gXlqGrQ2cDLacjmrAghIhhTadJY
 XQIze29JIx7M3ir72u6RiPas3LPr6YZNn27dYHwUxhW8ovpgxeqc4B+rrVtygg2aE8
 XhO62/bJzdD9R7dzMVQ5Fh3IfgS/TCPv0HxOWRNI6SYyKi7JTc3Aj77MHlY+Esy057
 vCUyYXPPijdGfMKuLZAoC5JVqcWdxmSAiRP2BXSKmfpdqgg6JKMCZg5Cs4mHF5kPu4
 jhKidNxaGmkY7Kg6aiENI7s/Py23xTgyWSzItduekhthGRps7CtrWZZcgrTqPQlD/x
 USKsgFpG28ljg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/20] rust: io: implement `Io` on reference types
 instead
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org,
 linux-pci@vger.kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260611-io_projection-v4-4-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-4-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 17:07:30 +0000
Message-Id: <20260611170731.1BB6E1F00893@smtp.kernel.org>
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

New issues:
- [Low] Missing lifetime specifiers in trait implementations for reference =
types.

Pre-existing issues:
- [High] The safe trait `Io` provides safe methods that perform unchecked `=
unsafe` operations relying on safe, overridable methods, violating Rust's s=
oundness guarantees.
--

commit d5084ac7c26ce79e46d5cb18b40703205bee53dd
Author: Gary Guo <gary@garyguo.net>

rust: io: implement Io on reference types instead

Currently, Io is implemented on owned I/O objects (e.g. Bar). This is
going to change with I/O projections, as then Io need to work both for
owned objects and views of them. Views are themselves reference-like
(however they obviously cannot be references, because they belong to a
different address space).

To faciliate the change, change Io to be implemented on reference types
for the owned I/O objects, and make methods take self instead of &self.
When I/O views are implemented, we can then naturally implement Io for
these objects.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 38281636b4da3..3b478dcf10f95 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
[ ... ]
> @@ -338,7 +338,7 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
> =20
>      /// Fallible 8-bit read with runtime bounds check.
>      #[inline(always)]
> -    fn try_read8(&self, offset: usize) -> Result<u8>
> +    fn try_read8(self, offset: usize) -> Result<u8>

[Severity: High]
This is a pre-existing issue, but does the Io trait need to be marked as
unsafe?

The safe trait Io provides safe methods like try_read8() which contain an
unsafe block calling self.io_read(). The safety of this block assumes
that self.io_addr() always returns a valid memory address.

However, since Io is a safe trait, any safe Rust code can implement it
and arbitrarily override methods like io_addr(), addr(), or maxsize()
to return invalid addresses. If this occurs, calling the safe try_read8()
function will result in undefined behavior.

Should Io or IoCapable be an unsafe trait so that the implementor is
held formally responsible for upholding the invariants required by the
unsafe blocks in the default methods?

[ ... ]
> @@ -800,13 +800,13 @@ fn update<T, L, F>(&self, location: L, f: F)
>  macro_rules! impl_mmio_io_capable {
>      ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:id=
ent) =3D> {
>          $(#[$attr])*
> -        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
> -            unsafe fn io_read(&self, address: usize) -> $ty {
> +        impl<const SIZE: usize> IoCapable<$ty> for &$mmio<SIZE> {

[Severity: Low]
Does this implementation cause a compile error due to a missing lifetime
specifier?

Implementing a trait for a reference type requires an explicit lifetime
parameter for that reference. Should this be updated to include the
lifetime? For example:

impl<'a, const SIZE: usize> IoCapable<$ty> for &'a $mmio<SIZE>?

[ ... ]
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index b4996aa059d81..505305cd9b86c 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -79,8 +79,8 @@ pub struct ConfigSpace<'a, S: ?Sized + ConfigSpaceKind =
=3D Extended> {
>  /// Implements [`IoCapable`] on [`ConfigSpace`] for `$ty` using `$read_f=
n` and `$write_fn`.
>  macro_rules! impl_config_space_io_capable {
>      ($ty:ty, $read_fn:ident, $write_fn:ident) =3D> {
> -        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for ConfigS=
pace<'a, S> {
> -            unsafe fn io_read(&self, address: usize) -> $ty {
> +        impl<'a, S: ?Sized + ConfigSpaceKind> IoCapable<$ty> for &Config=
Space<'a, S> {

[Severity: Low]
Similar to the regression in io.rs, is an outer lifetime specifier required
for this reference type to compile?

For example:

impl<'a, 'b, S: ?Sized + ConfigSpaceKind> IoCapable<$ty>
    for &'b ConfigSpace<'a, S>?

[ ... ]
> @@ -112,18 +112,18 @@ unsafe fn io_write(&self, value: $ty, address: usiz=
e) {
>  impl_config_space_io_capable!(u16, pci_read_config_word, pci_write_confi=
g_word);
>  impl_config_space_io_capable!(u32, pci_read_config_dword, pci_write_conf=
ig_dword);
> =20
> -impl<'a, S: ?Sized + ConfigSpaceKind> Io for ConfigSpace<'a, S> {
> +impl<'a, S: ?Sized + ConfigSpaceKind> Io for &ConfigSpace<'a, S> {

[Severity: Low]
As with the previous implementation, does this also need an outer lifetime
specifier for the reference itself?

>      type Target =3D S;
> =20
>      /// Returns the base address of the I/O region. It is always 0 for c=
onfiguration space.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D4
