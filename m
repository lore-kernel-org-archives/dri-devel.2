Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A290DC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB52110EEE4;
	Tue, 29 Sep 2026 14:10:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rk6gavTU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C39CD10EEDF
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:10:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C09CE601DB;
 Tue, 29 Sep 2026 14:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1351F000FF;
 Tue, 29 Sep 2026 14:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790691019;
 bh=FpvXuDHY7RopLAjx9MyyVi6KBf0g+96vMx1ZcrPiQzg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Rk6gavTUE8So5DbcNyHa/vzWjgkYQFmcn9fz0mp8QbtNpBUB6sLs/6XwsDLaRJw5J
 wmxNpbunP/8O+lmzIpI6p8KmfA8muKdvvHZMvM3FDPKh21gxJNklhW3uqhgEtpMDAB
 ZJlwO57GyqeioE9+HtN/FDDxU8ns7uCDueqfxrsShxQtjwjaRnM/OuKcEt2aq95SLT
 w7mFcc24xKpc+cFOwITzK4iqLaAy+BDZajmmIIDwpdeGCfJjPpstoybfPZhE+m2Iu3
 Fvq+V6A/XV1BdUChGF6zzF1L8dY5WRwPvCOaQ00+yMYfZvbQMj9E9/T+Jwgorng5PF
 wNGIM//FjpPcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/10] rust: macros: add derive macro for `TryFrom`
To: "Kaiqi Guo" <chaoji_xinren@163.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, gary@garyguo.net,
 dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org
In-Reply-To: <20260929135855.36775-3-chaoji_xinren@163.com>
References: <20260929135855.36775-1-chaoji_xinren@163.com>
 <20260929135855.36775-3-chaoji_xinren@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 14:10:18 +0000
Message-Id: <20260929141019.1F1351F000FF@smtp.kernel.org>
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
- [Low] rust: macros: unused_comparisons warning on 128-bit boundary checks
- [Low] rust: macros: dead_code and unused_variables on empty enums
--

commit 2f4a5e53f9efd805dce115afdbd130dde8b72a62
Author: Jesung Yang <y.j3ms.n@gmail.com>

rust: macros: add derive macro for `TryFrom`

Introduce a procedural macro TryFrom to automatically implement the TryFrom
trait for unit-only enums, reducing boilerplate when interpreting numeric
values as enum variants.

> diff --git a/rust/macros/convert.rs b/rust/macros/convert.rs
> index 6702c2e48c1fe..c64e35447859c 100644
> --- a/rust/macros/convert.rs
> +++ b/rust/macros/convert.rs

[ ... ]

> @@ -245,6 +253,56 @@ fn from(#param: #enum_ident) -> #input_ty {
>          }
>      }
> =20
> +    fn impl_try_from(
> +        enum_ident: &Ident,
> +        variants: &[Ident],
> +        repr_ty: &syn::Path,
> +        input_ty: &ValidTy,
> +    ) -> TokenStream {
> +        let param =3D Ident::new("value", Span::call_site());

[Severity: Low]
Does this trigger an unused_variables warning if the user derives TryFrom o=
n a
variant-less (empty) enum?

The generated try_from function never uses the value parameter in that case,
which could result in a build failure under CONFIG_WERROR.

> +
> +        let overflow_assertion =3D emit_overflow_assert(enum_ident, vari=
ants, repr_ty, input_ty);

[Severity: Low]
Can this generated overflow assertion cause a dead_code warning for empty e=
nums?

When an enum is empty, no variant assertions are generated to invoke the
internal fits() helper function, leaving it unused.

Also, when deriving TryFrom for a 128-bit target type, does the generated
fits() function trigger the unused_comparisons lint?

For example, the bounds checks in emit_overflow_assert() generate compariso=
ns
like this:

    (d as ::core::primitive::u128) <=3D (dst_max as ::core::primitive::u128)

If dst_max is the maximum possible value for a u128, the comparison is
trivially true and triggers the unused_comparisons lint. This can cause bui=
ld
failures under CONFIG_WERROR.

Would it make sense to apply #[allow(unused_comparisons)] to the entire fit=
s()
function scope rather than just the signedness boolean variables?

> +        let emit_cast =3D |variant| {
> +            let qualified_variant =3D ::quote::quote! { #enum_ident::#va=
riant };
> +            match input_ty {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929135855.3677=
5-1-chaoji_xinren@163.com?part=3D2
