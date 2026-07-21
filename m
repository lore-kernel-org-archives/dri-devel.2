Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B84C44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:41:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C20010E321;
	Tue, 21 Jul 2026 11:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C5SPsU82";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E92D10E321
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:41:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DC888600BB;
 Tue, 21 Jul 2026 11:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17941F000E9;
 Tue, 21 Jul 2026 11:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784634060;
 bh=NNAgLrpDH0/UU8+wsDoeYGyVlYL+qTZEqWUnwFngF7g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=C5SPsU827OX56Uob8a1dbCTau1rZm+xkDVVotHIC8QglLYa8KbJ40Af2X1/OOqsW+
 iktk0gDgP1uEHj1IH3Aa1aymUNd8PjAEpYGvzJu50t51UIvYQWcP6ln0XInb3HmMZM
 zYqokC665UofDct7MiPNsXZUlf2mZm12hTeqou+Y8bXkNAjAym2v29+1PcG0+msuYy
 kvbYwaxOeuMYjD4oIvl+bZ8S9SrkyXuWFp0WylM/BismZPxK1hpp31o7RxDWOhBlUb
 whLXyhrO3ccA3GPf4r+jlgUvMz4GoLd2Y/xGh3i14cZbr9Uo9KrcRtH8Hb2FMhQ+PI
 mGljbueDijoZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] rust: io: register: use new relative base syntax in
 doc and examples
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org,
 ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260721-registers_fix-v1-6-3711b2317e1f@nvidia.com>
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
 <20260721-registers_fix-v1-6-3711b2317e1f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 11:40:59 +0000
Message-Id: <20260721114059.F17941F000E9@smtp.kernel.org>
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
- [Medium] The `register!` macro fails to compile when using the deprecated=
 `+` syntax for relative register aliases.
--

--- Patch [6]: [PATCH 6/8] rust: io: register: use new relative base syntax=
 in doc and examples ---
commit ad4a7f900a81289c91c14aec0581812ddbb526e4
Author: Alexandre Courbot <acourbot@nvidia.com>

rust: io: register: use new relative base syntax in doc and examples

This commit (along with earlier patches in the series) converts the
documentation and examples to use the new Base: syntax to specify
relative registers bases. It also updates the macro's internal rules
to support this new syntax while keeping temporary support for the
old syntax.

> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index 80e638a892d74..eeb7f859f8b9d 100644
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
> +            { $($fields:tt)* }
> +        )*
> +    ) =3D> {
> +        $(
> +        $crate::register!(
> +            @reg $(#[$attr])* $vis $name ($storage) $([$size $(, stride =
=3D $stride)?])?
> +                $(@ $($base :)? $offset)?
> +                $(=3D> $alias $(: $alias_offset)? $([$alias_idx])? )?
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Could this cause a regression where the macro fails to compile when using t=
he
deprecated + syntax for relative register aliases?

In the deprecated branch above, $alias_offset is matched as a :ty fragment.
It is then forwarded here to an internal @reg rule:

[ ... ]

>      // Creates an alias register of relative offset register `alias` wit=
h its own fields.
>      (
> -        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) =3D> $=
base:ident + $alias:ident
> +        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) =3D> $=
base:path : $alias:path
>              { $($fields:tt)* }
>      ) =3D> {

However, this internal @reg rule expects a :path fragment. Rust macros do
not allow an abstract syntax tree node parsed as a ty fragment to match a
path specifier, which will result in a "no rules expected the token"
compilation error.

Since it was intended that the old form continues to be accepted temporaril=
y,
continuous integration might miss this conditional compilation error if no
dependent driver using the old syntax is built in standard configs. Could
$alias_offset be matched as a :path or :ident instead of :ty in the
deprecated branch to avoid this?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-registers_=
fix-v1-0-3711b2317e1f@nvidia.com?part=3D6
