Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A747CD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 18:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6752210E26D;
	Sat, 20 Jun 2026 18:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kbnLV5gs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E8A10E26D
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 18:58:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 64B4C40142;
 Sat, 20 Jun 2026 18:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232BD1F000E9;
 Sat, 20 Jun 2026 18:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781981909;
 bh=kPY0Q+fmhGIrLblF5cph1AmyZ2wxA2QwT5fOZgKddMU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kbnLV5gsUTIOpZ+Lb9SYKOR/1eyn2uWZknNbB6LMEDZ5Rt9d+TWMvw6TSJbTepQwI
 JOFxHtNPNPV/UDN7RQ8conuwA13Olgi7tmRW2VNBMle7VlBjvZ6ij8jsIOFYwaJCW8
 5MvSj+OsOQXX4devjY6B66csqFCia+cFWz8x8XQxkLiJv+jVuY+CGNS7k1GYkZ7RzY
 sUvFDynuwumT4NrnrwNj7zfRLhAwQcWGEmXMv/1JOIP9B1cDDGvvVvcoX6jlaRNdMY
 Ujw79Dow+ZwBfg8VLr277m8VETz1D0T6zHd8de3Z0K4VfSTRuU1f+jnNKRMd7PhgBN
 QcICg9XD51rfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/16] rust: drm: Wrap ioctl dispatch in
 RegistrationGuard
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260620184924.2247517-12-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-12-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 18:58:28 +0000
Message-Id: <20260620185829.232BD1F000E9@smtp.kernel.org>
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
- [Critical] The `declare_drm_ioctls!` macro fails to constrain the ioctl h=
andler's data argument type to the declared UAPI `$struct`, which allows ha=
ndlers to silently accept larger types and causes out-of-bounds memory acce=
sses.
--

commit aaaa8c4ed4a35894ea9d49cf012ca359ca7c8ab5
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: Wrap ioctl dispatch in RegistrationGuard

This patch ensures that ioctl handlers receive a reference to a registered
device, proving at the type level that the device has not been unplugged.
It achieves this by calling `registration_guard()` on the device and using a
dead-code closure as a type-inference anchor to resolve the driver type
parameter.

> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index 70cf1aa4d788f..6cefd26b31f91 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs

[ ... ]

> @@ -164,11 +176,38 @@ macro_rules! declare_drm_ioctls {

[ ... ]

> +                            // Type-inference anchor: the closure is nev=
er called but ties `dev`'s
> +                            // type to `$func`'s first parameter, which =
the compiler cannot infer
> +                            // through method resolution and associated-=
type projections alone.
> +                            #[allow(unreachable_code)]
> +                            let _ =3D || {
> +                                $func(
> +                                    // SAFETY: This closure is never exe=
cuted; the dereference
> +                                    // exists purely to unify the type p=
arameter with `$func`.
> +                                    // The pointer is valid regardless.
> +                                    unsafe { &*__ptr },
> +                                    unreachable!(),
> +                                    unreachable!(),

[Severity: Critical]
Does using unreachable!() here drop the type constraint on the UAPI struct?

Because unreachable!() coerces to any type, it appears this closure fails to
anchor the data argument to the expected UAPI struct.

This allows the compiler to infer the data type entirely from the user-prov=
ided
handler signature without enforcing that it matches the declared UAPI struc=
t.

> +                                )
> +                            };
> +
> +                            let Some(guard) =3D dev.registration_guard()=
 else {
> +                                return $crate::error::code::ENODEV.to_er=
rno();
> +                            };
>                              let __anchor =3D ();
> =20
>                              // SAFETY:
> @@ -180,7 +219,7 @@ macro_rules! declare_drm_ioctls {
>                              // - `raw_file` is a valid `struct drm_file`=
 pointer provided by the
>                              //   DRM core.
>                              match unsafe { $crate::drm::ioctl::internal:=
:__call_ioctl(
> -                                &__anchor, dev, raw_data, raw_file, $fun=
c,
> +                                &__anchor, &*guard, raw_data, raw_file, =
$func,

[Severity: Critical]
If the handler author accidentally specifies a larger type for the data
argument, could this lead to out-of-bounds memory access?

Since __call_ioctl() infers its generic data type directly from the $func
signature, it will cast the raw_data pointer to that inferred type.=20

The DRM core allocates the raw_data buffer exactly based on the expected UA=
PI
struct size. If the handler silently accepts a larger struct type, casting =
and
dereferencing it in __call_ioctl() would cause out-of-bounds memory accesse=
s.

>                              ) } {
>                                  Err(e) =3D> e.to_errno(),
>                                  Ok(i) =3D> i.try_into()

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620184924.2247=
517-1-dakr@kernel.org?part=3D11
