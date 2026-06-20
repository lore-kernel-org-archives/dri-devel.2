Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CE0CD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 01:13:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68D2010E163;
	Sat, 20 Jun 2026 01:13:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jxiemph5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E56010E163
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 01:13:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 206ED600AE;
 Sat, 20 Jun 2026 01:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47D01F000E9;
 Sat, 20 Jun 2026 01:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781918026;
 bh=iBYKqtngL0J2FnoCz7ktMOvmdc6QThzvcATbikw1z98=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jxiemph5zLJc/4KEqnYisJwgMI48EMXryDaulEFmJuZjNyt6TWUupacgicpCLBCbi
 HEDNGL5sQH4CJHkYxlDE6XsDhUweC+RhAGuy1DqNpnzzPJc1FoZa+3McPie21WIzA6
 yt5mEMSyzFX+NYaG5VM25K0ogFDjBOqmMkce/TqzSbznDNfpAWgwGfoLAYfSWaV2P4
 iowSe6phJkuaH0nxbXYAnIt+lUipLat2rYVlc7eX8NROZ4sf0KInGTkx7xEaF34KUQ
 cWk2zbjSaVSoYQiAqt4lfsEc1PxHjz8crP2RdW/hawhGK6gJgLjdojWoB4V3H6VBDK
 qFB32zD1Z9bBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 11/13] rust: drm: Wrap ioctl dispatch in
 RegistrationGuard
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260620005431.1562115-12-dakr@kernel.org>
References: <20260620005431.1562115-1-dakr@kernel.org>
 <20260620005431.1562115-12-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 01:13:46 +0000
Message-Id: <20260620011346.A47D01F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Type inference hole in declare_drm_ioctls! allows safe handlers to=
 trigger UB by inferring a Registered context before registration is verifi=
ed.
- [High] Unbounded lifetimes for `data` and `file` in declare_drm_ioctls! a=
llow safe ioctl handlers to stash references, causing use-after-free.
--

commit 28720068d91e18a10855651aab56d3a9e81f5d62
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: Wrap ioctl dispatch in RegistrationGuard

This commit wraps every ioctl handler inside a drm_dev_enter/exit critical
section using RegistrationGuard. It returns ENODEV if the device is unplugg=
ed
and anchors the driver type with a never-called closure to assist compiler
type inference.

> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index cf328101dde4e..c6a03be018e6d 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs
[ ... ]
> @@ -135,6 +138,16 @@ macro_rules! declare_drm_ioctls {
>                              // dev/file match the current driver these i=
octls are being declared
>                              // for, and it's not clear how to enforce th=
is within the type system.
>                              let dev =3D $crate::drm::device::Device::fro=
m_raw(raw_dev);
> +
> +                            // Type-inference anchor: the closure is nev=
er called but ties `dev`'s
> +                            // type to `$func`'s first parameter, which =
the compiler cannot infer
> +                            // through method resolution and associated-=
type projections alone.
> +                            #[allow(unreachable_code)]
> +                            let _ =3D || $func(dev, unreachable!(), unre=
achable!());
> +
> +                            let Some(_guard) =3D dev.registration_guard(=
) else {
> +                                return $crate::error::code::ENODEV.to_er=
rno();
> +                            };

[Severity: High]
This is a pre-existing issue, but does this type inference anchor create a
scenario where safe driver code can trigger undefined behavior?=20

If a driver author writes a safe ioctl handler that expects a registered
context, such as &Device<T, Registered>, the type-inference anchor will tie
the type of dev to that first parameter. This causes Device::from_raw() to =
be
evaluated with C =3D Registered.

Since Device::from_raw() is called before dev.registration_guard() can
verify the device is actually bound, doesn't this create a Registered
reference for an unplugged device? Would this violate the type invariant
and safety contract of from_raw() before the guard is even checked?

[Severity: High]
This is also a pre-existing issue, but are the lifetimes of the data and fi=
le
arguments passed to the user's $func properly constrained?

While the guard bounds the lifetime of the device access, the data and file
parameters instantiated from raw pointers later in this macro don't appear =
to
have explicit lifetime bounds. If $func demands a 'static lifetime for these
arguments, will the compiler incorrectly infer them as 'static?

If so, could a safe ioctl handler stash these references in a global variab=
le
or async context, causing a use-after-free once the ioctl callback returns =
and
the C API invalidates the pointers?

>                              // SAFETY: The ioctl argument has size `_IOC=
_SIZE(cmd)`, which we
>                              // asserted above matches the size of this t=
ype, and all bit patterns of
>                              // UAPI structs must be valid.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620005431.1562=
115-1-dakr@kernel.org?part=3D11
