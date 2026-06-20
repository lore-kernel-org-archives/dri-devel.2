Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3ABCD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 19:13:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5843310E27E;
	Sat, 20 Jun 2026 19:13:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VX8NUKl5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E473110E27E
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 19:13:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 696C4601E1;
 Sat, 20 Jun 2026 19:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF38B1F000E9;
 Sat, 20 Jun 2026 19:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781982782;
 bh=JTxFVtq+h/G2AedWmydlbP3BkW9gHVcpCWMaSdGkHV4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VX8NUKl5wDYreIi5QSoiVyelkOsU6DFDzkKH3k889uFaHGgNzIwe332TW/mdb2344
 LTtILUbXxp10TVhwZnlPrXHj9PCgQm3j9aVmRoMM4luA6h341QE4zKs4z8epwpMSDO
 WHfVxD43D5A22uNRAu7RMZT2dts3QyT+eierqsJ9RDJHvXTt26GHj1dgm6W6Nw6v9C
 zLMAm6jooSjFSkPGwe+eCSdUtdKcVtqWa4EPJM2X5fJNWpsyUT+9DuGp0zoXmvYT3B
 B7m8Hl5WUi5p80awLhernlbxP9WQcytbb+dkpslwC9DZWFD1lnM8Qon2z83FhZRmg9
 ivQjvOC7mNGrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 15/16] rust: drm: Pass registration data to ioctl
 handlers
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260620184924.2247517-16-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-16-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 19:13:01 +0000
Message-Id: <20260620191301.EF38B1F000E9@smtp.kernel.org>
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
- [High] The `declare_drm_ioctls!` macro fails to constrain the `Data` type=
 parameter in `__call_ioctl`, allowing type inference to deduce an arbitrar=
ily large struct size that leads to out-of-bounds memory accesses.
--

commit d383776ed6368e3f51c2779206ce9abab5ecfc2d
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: Pass registration data to ioctl handlers

This commit passes registration data to ioctl handlers via
drm::Device<Registered>::registration_data_with(). It modifies the ioctl
dispatching macro declare_drm_ioctls! and the internal __call_ioctl helper
to thread the registration data through to the ioctl callbacks.

> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index 6cefd26b31f91..75944e72d7af4 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs

[ ... ]

> @@ -202,25 +204,28 @@ macro_rules! declare_drm_ioctls {
>                                      unsafe { &*__ptr },
>                                      unreachable!(),
>                                      unreachable!(),
> +                                    unreachable!(),
>                                  )
>                              };
> =20
>                              let Some(guard) =3D dev.registration_guard()=
 else {
>                                  return $crate::error::code::ENODEV.to_er=
rno();
>                              };
> -                            let __anchor =3D ();
> =20
> -                            // SAFETY:
> -                            // - The ioctl argument has size `_IOC_SIZE(=
cmd)`, which we asserted
> -                            //   above matches the size of this type, an=
d all bit patterns of UAPI
> -                            //   structs must be valid. The argument is =
exclusively owned by this
> -                            //   handler, guaranteed by `drm_ioctl()` to=
 remain valid for the
> -                            //   duration of the call.
> -                            // - `raw_file` is a valid `struct drm_file`=
 pointer provided by the
> -                            //   DRM core.
> -                            match unsafe { $crate::drm::ioctl::internal:=
:__call_ioctl(
> -                                &__anchor, &*guard, raw_data, raw_file, =
$func,
> -                            ) } {
> +                            match guard.registration_data_with(|reg_data=
| {
> +                                // SAFETY:
> +                                // - The ioctl argument has size `_IOC_S=
IZE(cmd)`, which we asserted
> +                                //   above matches the size of this type=
, and all bit patterns of
> +                                //   UAPI structs must be valid. The arg=
ument is exclusively owned
> +                                //   by this handler, guaranteed by `drm=
_ioctl()` to remain valid
> +                                //   for the duration of the call.
> +                                // - `raw_file` is a valid `struct drm_f=
ile` pointer provided by
> +                                //   the DRM core.
> +                                unsafe { $crate::drm::ioctl::internal::_=
_call_ioctl(
> +                                    reg_data, &*guard, raw_data, raw_fil=
e,
> +                                    |dev, data, file| $func(dev, reg_dat=
a, data, file),
> +                                ) }

[Severity: High]
In the declare_drm_ioctls! macro in rust/kernel/drm/ioctl.rs, does this
closure allow type inference to deduce an arbitrarily large struct size that
leads to out-of-bounds memory accesses?

Because Data is not explicitly constrained here, its type is inferred
backward from the user-provided $func. If an ioctl handler is written to
accept a larger mutable reference, it seems Data would be inferred as that
larger type.

The __call_ioctl helper will then cast the raw_data pointer to that larger
type and safely dereference it. Since the DRM core only allocates
_IOC_SIZE(cmd) bytes for the ioctl payload, couldn't this allow Safe Rust to
read and write past the allocated kernel buffer?

Should the closure explicitly annotate the type of data (e.g.,
|dev, data: &mut $crate::uapi::$struct, file|) to prevent type inference
from breaking the size constraint?

> +                            }) {
>                                  Err(e) =3D> e.to_errno(),
>                                  Ok(i) =3D> i.try_into()
>                                              .unwrap_or($crate::error::co=
de::ERANGE.to_errno()),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620184924.2247=
517-1-dakr@kernel.org?part=3D15
