Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADCEECD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 19:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED9A910E273;
	Sat, 20 Jun 2026 19:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M6QFkvVM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83EC010E273
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 19:02:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62E6643BE2;
 Sat, 20 Jun 2026 19:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 152121F000E9;
 Sat, 20 Jun 2026 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781982149;
 bh=3VTWvsnC6es/KUeZUxhsrIMbtV/RU4RUOjnmV2Fq56I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M6QFkvVMcSzYUP166tZp566iZXLnGhEu6/WYhyPw+gBc6t6/ZaMmvughVvDTjvX6y
 h7HiRlDJTGu3y6xgHeftIW5vePT7e01P8MuHHt1l4kxzYu+68YAnVBXNjOKln7b8hf
 Cqf6eP5D9WxmqNXeL7FRBoI+EV9oesEh4dk0cK9G6/dPGZB7lX5mrfOVIoO96PwJjN
 XrP8T1X+X4OBXtcvotXpIW0+OONf+BlYnSDx8BQ57lK2rxpt4HK9IyLhLicUOYZFrj
 4JI6UED75zEZMsW0/aLEy1F0pFnqVf+iCwm1Yfpwt3WDmDP8V8tUCrQkad1Ig5XY3q
 LXYLJ1bElX4PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/16] rust: drm: add AsRef<ParentDevice<Bound>> for
 Device<Registered>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260620184924.2247517-14-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-14-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 19:02:28 +0000
Message-Id: <20260620190229.152121F000E9@smtp.kernel.org>
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
- [Low] Missing `#[inline]` annotation on the small forwarding function `as=
_ref` in an abstraction crate.
--

commit 61d54b007aa9572681d918fcd5c48802182d8282
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: add AsRef<ParentDevice<Bound>> for Device<Registered>

This commit implements AsRef<T::ParentDevice<Bound>> for Device<T, Register=
ed>.
It provides safe access to the bound parent bus device for registered DRM
devices.

> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 45bacd7b227f0..8f63276c9b62f 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -462,6 +462,19 @@ fn as_ref(&self) -> &T::ParentDevice<device::Normal>=
 {
>      }
>  }
> =20
> +impl<T: drm::Driver> AsRef<T::ParentDevice<device::Bound>> for Device<T,=
 Registered> {
> +    fn as_ref(&self) -> &T::ParentDevice<device::Bound> {

[Severity: Low]
This isn't a bug, but should this small forwarding function in an abstracti=
on
crate have an #[inline] annotation?

The Rust subsystem coding guidelines mention that functions in abstractions
that are small or simply forwarding calls should be annotated with #[inline=
].
Since as_ref() performs purely type-level conversions and pointer coercions,
adding the annotation might help the compiler reliably optimize these across
crate boundaries.

> +        let dev =3D (**self).as_ref().as_ref();
> +
> +        // SAFETY: A `Device<T, Registered>` guarantees that the parent =
device is bound.
> +        let dev =3D unsafe { dev.as_bound() };
> +
> +        // SAFETY: By the type invariant of `Device`, the parent device =
is embedded in
> +        // `T::ParentDevice`.
> +        unsafe { device::AsBusDevice::from_device(dev) }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620184924.2247=
517-1-dakr@kernel.org?part=3D13
