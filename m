Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDCFECD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 01:16:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F411E10E166;
	Sat, 20 Jun 2026 01:16:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mxqQK+R6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B76E10E166
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 01:16:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 78444600AE;
 Sat, 20 Jun 2026 01:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05AC1F000E9;
 Sat, 20 Jun 2026 01:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781918164;
 bh=lTi6F/1vQsu3va1NpnyKF6kWfzZaaF5+nYtrRNYmNkI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mxqQK+R6APTTx1HihuBUre97VQAycTbhGiri22K/Ki9LmQE26duel8vlNGgCgn6KV
 mDkkpyhiuUMMLhgD99xuNGFb2d1fc3zD7ybzbujCe5DaWMWdKSOLBjnRMmKg65suYh
 6kT8rAdH7ZJxFnMcDridslBBM0Rsa1453zFoWmsaYKt3yayoSq0OO1n07GbnyUvBRA
 4m7wXf/4I8uDL/un7CLXJuHehTfk2RhoaAqIqboy1Dgp6eZ1U4kTVZBdv2z5fmL0mX
 ANBN2qs5fa7HT5zuNKSH2PQ+2XdJ8jehv/ncY5FQZb0oF1qTFd0EnQCSrwi7y65DQO
 KiWg4nX0Ykn6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/13] rust: drm: Pass registration data to ioctl
 handlers
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260620005431.1562115-13-dakr@kernel.org>
References: <20260620005431.1562115-1-dakr@kernel.org>
 <20260620005431.1562115-13-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 01:16:03 +0000
Message-Id: <20260620011603.F05AC1F000E9@smtp.kernel.org>
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
- [High] Missing `Sync` bound on `RegistrationData` allows data races via c=
oncurrent ioctl calls.
- [High] Unconstrained type inference in `declare_drm_ioctls!` bypasses typ=
e invariants, causing Undefined Behavior.
--

commit 4f19dadb5da1b4410f3118837853bdb09c3f4718
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: Pass registration data to ioctl handlers

Pass registration data to ioctl handlers via
drm::Device<Registered>::registration_data_with().

[ ... ]
> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index c6a03be018e6d..ecc1a0383635c 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs
[ ... ]
> @@ -143,9 +144,16 @@ macro_rules! declare_drm_ioctls {
>                              // type to `$func`'s first parameter, which =
the compiler cannot infer
>                              // through method resolution and associated-=
type projections alone.
>                              #[allow(unreachable_code)]
> -                            let _ =3D || $func(dev, unreachable!(), unre=
achable!());
> +                            let _ =3D || {
> +                                $func(
> +                                    dev,
> +                                    unreachable!(),
> +                                    unreachable!(),
> +                                    unreachable!(),
> +                                )
> +                            };

[Severity: High]
Does this type inference bypass the safety invariants of Device::from_raw()?

Because dev is passed directly to the user-provided $func in this dummy=20
closure, the compiler infers the DeviceContext of dev from the handler's=20
signature. If an ioctl handler expects &Device<T, Registered>, the compiler=
=20
resolves dev to be a Registered device.

This means the preceding call to Device::from_raw(raw_dev) instantiates a=20
Registered device reference before registration_guard() establishes the=20
drm_dev_enter SRCU critical section. This bypasses the safety contract whic=
h=20
requires the parent bus device to be bound.

Would it be safer to explicitly constrain dev to Device<_, Normal>, and=20
pass &*guard instead of dev to the dummy closure?

> =20
> -                            let Some(_guard) =3D dev.registration_guard(=
) else {
> +                            let Some(guard) =3D dev.registration_guard()=
 else {
>                                  return $crate::error::code::ENODEV.to_er=
rno();
>                              };
[ ... ]
> @@ -160,7 +168,9 @@ macro_rules! declare_drm_ioctls {
>                              // SAFETY: This is just the DRM file structu=
re
>                              let file =3D unsafe { $crate::drm::File::fro=
m_raw(raw_file) };
> =20
> -                            match $func(dev, data, file) {
> +                            match guard.registration_data_with(|reg_data=
| {
> +                                $func(&*guard, reg_data, data, file)
> +                            }) {

[Severity: High]
Can this allow data races if the RegistrationData type is not Sync?

Looking at the Driver trait definition in rust/kernel/drm/driver.rs:

trait Driver {
    type RegistrationData: ForLt;
    ...
}

RegistrationData is defined without a Sync bound. However, Device<T, C>=20
is unconditionally Sync, meaning any thread can access its shared methods=20
concurrently.=20

Since multiple userspace threads can invoke DRM ioctls concurrently, multip=
le=20
threads can call registration_data_with() at the same time to obtain shared=
=20
references to the same data. If a driver uses a non-Sync type for=20
RegistrationData (such as Cell<T>), could this lead to concurrent mutation=
=20
and undefined behavior?

>                                  Err(e) =3D> e.to_errno(),
>                                  Ok(i) =3D> i.try_into()
>                                              .unwrap_or($crate::error::co=
de::ERANGE.to_errno()),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620005431.1562=
115-1-dakr@kernel.org?part=3D12
