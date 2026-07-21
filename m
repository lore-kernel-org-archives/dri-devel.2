Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C8CC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EBDA10E76A;
	Tue, 21 Jul 2026 11:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="croPeb7A";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 027F810E76A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:14:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3356F600AE;
 Tue, 21 Jul 2026 11:14:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB801F000E9;
 Tue, 21 Jul 2026 11:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784632449;
 bh=w2oSk/8ampqUko4t63SgE8cUxbaT9W3gh3wtikyLms4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=croPeb7A6h7r2ypdqB4h9VJE4tTnFR0d8VPkKK/qTna0dComSKfh4tvi1E99mNEMG
 Dwa8/EMZHApgvCWgH7d4OhLhA0kcsq+JIllSBDSng3LF8KcCwNNhR6zmNk4+D95dl2
 1iYZPhialh1GCdBSVAR9IxXt1i/IQmLxBcGRnxNDADSRFqZNVkSyjsgKUV9pSo5XDo
 60N0B9nHpcg18b9zWKgREbqXIfJCaZO62iWo98CODuyU4lyIoolEtXTj8Zx/9ipkir
 PHbUX/m9yNiRbPhOGV86LXUNW2lLRBu5movGfCXiAf/px9PY77K4FTKirIAeIvIT+Z
 CsLAsgxlJt4Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] rust: io: register: allow paths for relative
 register bases
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260721-registers_fix-v1-5-3711b2317e1f@nvidia.com>
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
 <20260721-registers_fix-v1-5-3711b2317e1f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:14:09 +0000
Message-Id: <20260721111409.8EB801F000E9@smtp.kernel.org>
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
- [Low] Deprecated `+` syntax fallback rule for relative register aliases i=
ncorrectly captures the alias offset as a `ty` fragment, causing a macro ex=
pansion error.
- [Low] Mixing the deprecated `+` syntax and the new `:` syntax within the =
same `register! { ... }` block results in a compilation error.
--

--- Patch [5]: [PATCH 5/8] rust: io: register: allow paths for relative reg=
ister bases ---
commit 0d4940e7a464ea733ee8d4db86d88c71b931bf2d
Author: Alexandre Courbot <acourbot@nvidia.com>

rust: io: register: allow paths for relative register bases

This commit introduces Base: Offset and Base: Alias syntax in the register!
macro, parsing them as path fragments rather than ident. It temporarily
retains the deprecated + syntax fallback to allow in-tree users to be
converted incrementally in subsequent patches.

> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -801,6 +801,26 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
>  /// ```
>  #[macro_export]
>  macro_rules! register {
> +    // Deprecated `+` syntax for relative registers and their aliases.
> +    (
> +        $(
> +            $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
> +                $([ $size:expr $(, stride =3D $stride:expr)? ])?
> +                $(@ $($base:ident +)? $offset:literal)?
> +                $(=3D> $alias:ident $(+ $alias_offset:ty)? $([$alias_idx=
:expr])? )?
                                                      ^^^
[Severity: Low]
Does capturing the alias offset as a ty fragment here break the backward
compatibility?

When this is forwarded to the internal rule:

@reg $(#[$attr])* $vis $name ($storage) =3D> $base:path : $alias:path

a parsed ty fragment cannot be matched by a path fragment specifier in the
subsequent macro invocation. This seems to result in a "no rules expected t=
he
token in macro call" compilation error for any code still using the old
syntax.

[ ... ]

>      // Entry point for the macro, allowing multiple registers to be defi=
ned in one call.
>      // It matches all possible register declaration patterns to dispatch=
 them to corresponding
>      // `@reg` rule that defines a single register.
> @@ -808,8 +828,8 @@ macro_rules! register {
>          $(
>              $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
>                  $([ $size:expr $(, stride =3D $stride:expr)? ])?
> -                $(@ $($base:ident +)? $offset:literal)?
> -                $(=3D> $alias:ident $(+ $alias_offset:path)? $([$alias_i=
dx:expr])? )?
> +                $(@ $($base:path :)? $offset:literal)?
> +                $(=3D> $alias:path $(: $alias_offset:path)? $([$alias_id=
x:expr])? )?
>              { $($fields:tt)* }
>          )*
>      ) =3D> {

[Severity: Low]
Will this structure prevent mixing the old and new syntax within the same
register block?

Since both top-level macro arms use $( ... )* to match the entire contents
of the block, a block containing a mix of + and : syntax will fail both
matchers. This might cause compilation errors if users attempt to
incrementally migrate some, but not all, registers within a single
register block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-registers_=
fix-v1-0-3711b2317e1f@nvidia.com?part=3D5
