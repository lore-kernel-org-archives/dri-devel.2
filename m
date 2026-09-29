Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21649CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C96410EEDF;
	Tue, 29 Sep 2026 14:11:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IqJtHcd5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44B0F10EEDF
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 14:11:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC1A160008;
 Tue, 29 Sep 2026 14:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1452F1F000FF;
 Tue, 29 Sep 2026 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790691060;
 bh=zO5ATSdbrwWLO7zn8nPlig/4WRhXbINcs4D1AuxUzxg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IqJtHcd573cG3ji+R5C1P7AlGrnTzfluZsD1FPi/0B4zY4w5uWBrTIe4C9afUDEBw
 IStDhwIs6oWOtkgQDggSrMkC9DQF834AdX9GgbAC46KnCBslxWzeBYj1Ybpp1idlnu
 Dyc6ZRHnTfQ3bUCYmBz7naZBMOyjgsEMdEgUfTBAF4LAT4xuW+oOzrathkp1AHwKom
 ha0TRI9yebvSTJSrRiIca3Ku8b/pKE0Owb1Mbde9e2SncCQkNRwGEfY+VvOtCe1+Jz
 RAaGe3ew0P0WnC9MeP4OuSMtIFJtK1SdcxugOfukgp3sNFReozK96BtgvirCnqQLcc
 CmhsmdI0z7mKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/10] rust: macros: add derive macro for `Into`
To: "Kaiqi Guo" <chaoji_xinren@163.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>, gary@garyguo.net, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260929135855.36775-2-chaoji_xinren@163.com>
References: <20260929135855.36775-1-chaoji_xinren@163.com>
 <20260929135855.36775-2-chaoji_xinren@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 14:10:59 +0000
Message-Id: <20260929141100.1452F1F000FF@smtp.kernel.org>
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
- [Low] rust: macros: Into derive fails on repr with nested arguments
- [Low] rust: macros: Bounded validation incorrectly accepts bool
--

commit f3bc2f572cd1e2c7a2b7b3fee89fc39e25420448
Author: Jesung Yang <y.j3ms.n@gmail.com>

rust: macros: add derive macro for Into

This commit introduces a procedural macro Into to automatically derive the =
Into
trait for unit-only enums. It generates From implementations based on the i=
nto
or repr attributes, supporting primitive types and the Bounded type. It also
generates compile-time assertions to ensure variant discriminants fit within
the destination type.

Link: https://lore.kernel.org/rust-for-linux/20250624132337.2242-1-dakr@ker=
nel.org/ [1]

> diff --git a/rust/macros/convert.rs b/rust/macros/convert.rs
> new file mode 100644
> index 0000000000000..6702c2e48c1fe
> --- /dev/null
> +++ b/rust/macros/convert.rs
> @@ -0,0 +1,527 @@
[ ... ]
> +fn parse_attrs(
> +    target: DeriveTarget,
> +    attrs: &[Attribute],
> +) -> syn::Result<(Vec<Type>, bool, Option<Ident>)> {
> +    let helper =3D target.get_helper_name();
> +
> +    let mut is_repr_c =3D false;
> +    let mut repr_ty =3D None;
> +    let mut helper_tys =3D Vec::new();
> +    for attr in attrs {
> +        if attr.path().is_ident("repr") {
> +            attr.parse_nested_meta(|meta| {
> +                let ident =3D meta.path.get_ident();
> +                if let Some(i) =3D ident {
> +                    if is_valid_primitive(i) {
> +                        repr_ty =3D ident.cloned();
> +                    } else if i =3D=3D "C" {
> +                        is_repr_c =3D true;
> +                    }
> +                }
> +                // Delegate `repr` attribute validation to rustc.
> +                Ok(())

[Severity: Low]
Does this closure returning Ok(()) without consuming the inner tokens cause
parsing to fail?=20

For example, if a developer applies #[derive(Into)] to an enum with a
#[repr(align(4))] attribute, the inner token 4 is not consumed. Will this
cause the syn crate to return a parsing error and break the build?

> +            })?;
> +        } else if attr.path().is_ident(helper) {
> +            let args =3D attr.parse_args_with(Punctuated::<Type, Token![=
,]>::parse_terminated)?;
> +            helper_tys.extend(args);
> +        }
> +    }
> +
> +    Ok((helper_tys, is_repr_c, repr_ty))
> +}
[ ... ]
> +fn validate_bounded(path_segment: &PathSegment) -> syn::Result<ValidTy> {
> +    let PathSegment { ident, arguments } =3D path_segment;
> +    return match arguments {
> +        PathArguments::AngleBracketed(inner) if ident =3D=3D Bounded::NA=
ME =3D> {
> +            let AngleBracketedGenericArguments {
> +                colon2_token, args, ..
> +            } =3D inner;
[ ... ]
> +            let Some(base_ty_ident) =3D base_ty_lowered.path.get_ident()=
 else {
> +                return Err(make_base_ty_err(base_ty));
> +            };
> +
> +            if !is_valid_primitive(base_ty_ident) {

[Severity: Low]
Does this validation step incorrectly accept bool as a base type for Bounde=
d?

Because is_valid_primitive() returns true for bool, specifying
Bounded<bool, 1> passes this check.=20

Later in the code, emit_min() attempts to emit MIN and BITS properties:

rust/macros/convert.rs:emit_min() {
    ...
    ::quote::quote! { #base_ty::MIN >> (#base_ty::BITS - #bits) }
    ...
}

Since bool::MIN and bool::BITS do not exist, will this generate invalid code
that causes the build to fail?

> +                return Err(make_base_ty_err(base_ty));
> +            }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929135855.3677=
5-1-chaoji_xinren@163.com?part=3D1
