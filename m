Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F862C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 930FC10EDF9;
	Wed, 19 Aug 2026 11:22:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P4C/ukN9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09DA510EDF1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:22:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F44360A58;
 Wed, 19 Aug 2026 11:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3E61F000E9;
 Wed, 19 Aug 2026 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787138528;
 bh=TSZn0TMr7fPwFI63AtGNFD9e0bs+tf6VivR4ONyYvOk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P4C/ukN9XNOzkArXUGgULVUG77/H6jblvkzv/Us71AhUgVCrSC0Be4B8RUfJ+Mu1a
 oSMhkebQ9yINtnj2cl5yDynD40od5haZfjUuSRVs/z+5FM9S9w4cW6P4RQIryKM3TT
 XtqNZgAXyuRuBwwFoVo1HPwwPmsVPqp6YF6MJJhaFlEL7cReJZTOBEWrkTgabeoOrf
 G0zFTDwgqlhWd6wr1W6nBXZ983CJadMMo4YP7uS0ek5jmIgtVxcJpclCW8dhtqtdu5
 ZliJZkz+gWprL9o14ZFOn696HqLOH8JHx99l8kRAat1CjPJkJmJOONTsiXr8+/UXOO
 HvEQpEg+LFcvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/16] rust: io: register: allow explicit base type
 specification
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20260819-typed_register-v3-6-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-6-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:22:07 +0000
Message-Id: <20260819112207.CB3E61F000E9@smtp.kernel.org>
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
- [Medium] The `register!` macro's parsing logic for the optional `base:` p=
arameter creates an ambiguity that breaks parsing if the first register is =
named `base`.
- [Medium] Discarding the `base` parameter in the macro output causes `unus=
ed_import` warnings in updated doc tests, breaking `make rusttest`.
--

--- Patch [6]: [PATCH v3 06/16] rust: io: register: allow explicit base typ=
e specification ---
commit 35780b69bb052cc1fae4709e732645521408cd48
Author: Gary Guo <gary@garyguo.net>

rust: io: register: allow explicit base type specification

This commit modifies the register! macro to accept an optional base
parameter to specify the base type it will be operating on. Currently,
the parameter is parsed but ignored in the generated code until all
users are converted.

> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index 45d2e73a92e7e..49a5fe069e47f 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -13,9 +13,14 @@
>  //! # Simple example
>  //!
>  //! ```no_run
> -//! use kernel::io::register;
> +//! use kernel::io::{
> +//!     register,
> +//!     Region,
> +//! };
>  //!
>  //! register! {
> +//!     base: Region<0x1000>;
> +//!

[Severity: Medium]
Will this result in an unused import warning that breaks make rusttest?

Since the base parameter is parsed but entirely discarded from the emitted
token stream, rustc will never see Region being used. The kernel compiles d=
oc
tests with -Dwarnings enabled, so this unused import could cause the doc
tests to fail.

[ ... ]

> diff --git a/rust/macros/io/register.rs b/rust/macros/io/register.rs
> index 8af12caa964b8..2fb48e1be82d6 100644
> --- a/rust/macros/io/register.rs
> +++ b/rust/macros/io/register.rs

[ ... ]

> @@ -139,16 +140,26 @@ fn parse(input: syn::parse::ParseStream<'_>) -> Res=
ult<Self> {
>  }
> =20
>  pub(crate) struct RegDef {
> +    base: Option<Type>,
>      regs: Vec<Reg>,
>  }
> =20
>  impl Parse for RegDef {
>      fn parse(input: syn::parse::ParseStream<'_>) -> Result<Self> {
> +        let base =3D if input.peek(kw::base) {
> +            let _: kw::base =3D input.parse()?;
> +            let _: Token![:] =3D input.parse()?;

[Severity: Medium]
Does this parsing logic break if a user names their first register base?

By only using input.peek(kw::base), the macro eagerly matches any identifier
named base at the start of the block. If a user defines a register like
base(u32) @ 0x100 (without a visibility modifier), it seems the macro will
consume base, expect a colon, and then fail with a syntax error when it
encounters the parenthesis.

Would checking for the trailing colon using input.peek2(Token![:]) prevent
this ambiguity?

> +            let base =3D input.parse()?;
> +            let _: Token![;] =3D input.parse()?;
> +            Some(base)
> +        } else {
> +            None
> +        };
>          let mut regs =3D Vec::new();
>          while !input.is_empty() {
>              regs.push(input.parse()?);
>          }
> -        Ok(RegDef { regs })
> +        Ok(RegDef { base, regs })
>      }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D6
