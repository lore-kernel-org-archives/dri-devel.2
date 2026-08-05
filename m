Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F26C55ABA
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FDB810EF55;
	Wed,  5 Aug 2026 16:50:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PC0KKQUv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1216E10EF53
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 16:50:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 76E7E60A5A;
 Wed,  5 Aug 2026 16:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7161F000E9;
 Wed,  5 Aug 2026 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785948644;
 bh=P2L6oRPUJO/v08DM1Y+l9EsgkljWMl9aO19tJttgYC0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PC0KKQUv+HPlTrpkmBkx+Mf0isYy4kSpmhXtCBsfJvFSj/uhV3Qepzhq+kyzbqjOv
 4pqO2S0+s0JNNdNxpvaGnEj3ybG5TaHlQGvTvx6V2X5JRRvvcvN3oyRxPD+gSqFmmA
 J4jY664TyK2mZAqTpcNwEdHKxr899rWWqiEq5EplMuEUzYNxPHPPVdwoSsszY19QX7
 Eu4BIft28yNxfLpgDhLkiWQQfovaLTHgjuDLkm0AosdlboW2PHqFbUHdT0Zmy7310R
 43MR4N2BE4Z7ul0wYsqpoRFuF8EPKBe6eGHFHjTmRjIoGz5QBMwPZRfvyakCcLOlT1
 JQ0THy8c1ncDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/16] rust: io: register: support fixed offset
 register without bitfield
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org,
 ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260805-typed_register-v2-11-c3ca142220a0@garyguo.net>
References: <20260805-typed_register-v2-0-c3ca142220a0@garyguo.net>
 <20260805-typed_register-v2-11-c3ca142220a0@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:50:42 +0000
Message-Id: <20260805165043.0F7161F000E9@smtp.kernel.org>
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
- [Low] The `register!` macro documentation provides an example defining a =
FIFO register (`TX_FIFO`) with a `u32` type. This violates the subsystem gu=
idelines which mandate that FIFOs must use stream accessors (no byteswappin=
g). Using a `u32` register type implies standard register access (e.g., `wr=
itel`), which will byteswap on big-endian architectures and corrupt stream =
data. Additionally, the macro's syntax rule `$ty: ident $(:: $path_frag:ide=
nt)*` restricts the type to paths, preventing developers from directly spec=
ifying a byte array (e.g., `[u8; 4]`) as the type to properly model a bytes=
wap-free stream.
--

--- Patch [11]: [PATCH v2 11/16] rust: io: register: support fixed offset r=
egister without bitfield ---
commit a13a899311e93c249f5925eff4ce304f82a4cb69
Author: Gary Guo <gary@garyguo.net>

rust: io: register: support fixed offset register without bitfield

Add a rule to allow creating `IoLoc` in `regiser!()` using an existing type
and not create a bitfield. Add an example to demonstrate this for FIFO
registers.

> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index dc800fc711722..49a61da106c7d 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs

[ ... ]

> @@ -499,6 +516,19 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
>  /// In this example, `SCRATCH_BOOT_STATUS` uses the same I/O address as =
`SCRATCH`, while providing
>  /// its own `completed` field.
>  ///
> +/// If you do not wish to have a bitfield defined, you can also create a=
 register using an existing
> +/// type.
> +///
> +/// ```no_run
> +/// # use kernel::io::*;
> +/// register! {
> +///     base: Region<0x1000>;
> +///
> +///     /// TX FIFO register.
> +///     pub TX_FIFO: u32 @ 0x00001000;

[Severity: Low]
Does this example promote an anti-pattern for FIFO access?

Using u32 for a FIFO implies standard register I/O accessors (like writel or
readl), which will perform byte-swapping on big-endian architectures.
According to the I/O accessor subsystem guidelines, FIFOs should use stream
accessors without byteswapping to prevent data corruption.

Would it be better to avoid using a FIFO as the example here, or use a type
that enforces stream semantics?

> +/// }
> +/// ```
> +///
>  /// ## Relative registers

[ ... ]

> @@ -826,6 +856,23 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
>  macro_rules! register {
>      (base: $reg_base:ty;) =3D> {};
> =20
> +    // Creates a register at a fixed offset of the MMIO space with provi=
ded type.
> +    (
> +        base: $reg_base:ty;
> +        // `$ty` cannot be `:ty` due to follow-set restrictions.
> +        $(#[$attr:meta])* $vis:vis $name:ident: $ty: ident $(:: $path_fr=
ag:ident)*

[Severity: Low]
Does this macro rule prevent developers from specifying inline byte arrays
(like [u8; 4]) as the register type?

Since the type matcher is restricted to identifiers and paths, it seems
developers wouldn't be able to directly define a byte array to properly mod=
el
a byteswap-free stream without defining a separate type alias first.

Could this be adjusted to support array syntax, or is the limitation strict
enough to require type aliases for stream buffers?

> +            $(@ $offset:literal)?
> +            $(=3D> $alias:path $([$alias_idx:expr])? )?;
> +        $($rest:tt)*
> +    ) =3D> {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805-typed_regi=
ster-v2-0-c3ca142220a0@garyguo.net?part=3D11
