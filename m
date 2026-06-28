Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4D3C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 15:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA52210E633;
	Sun, 28 Jun 2026 15:06:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V+40IqCo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFE7C10E633
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:05:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 635B56001D;
 Sun, 28 Jun 2026 15:05:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE42E1F000E9;
 Sun, 28 Jun 2026 15:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782659159;
 bh=xjnrmfjkUez73BWeJY8QWCuxAzi5YIAt05GmjH0SprA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V+40IqCo3L+rwxUjl7iOnQCt4js3j9qb1Dvg4Ukp+Zq76JR2kPlpivBTZRkA2lAeA
 nZeUKIj/GjQl/XvRgsDMJC3fEcq4R/RNSiRKApQma/XsVOJ0QJi+H02sXrrYzWx13Q
 aVBRLYjvqYvgP/Gep4gLWTE2+tNOPJ0oW2AGIA8BY+1QGFVmxCtRJ8c/8wGK3aftW8
 o+0tDUI4Ahj4PdCGOPaNaQUZBoOlIx8e/EklO2Q+KRJvO9oPvU69KqvV1h5PFDP7Vc
 Mrf8o5F/wBesKvHfQiFO/Dv9Dxe3F4aHX2qeKsABqr9tGu0TFm1yQHn7G2EWgtlee7
 wTlu5qNCGLR0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/19] rust: drm: pin ioctl Device reference to
 Normal context
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260628145406.2107056-11-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-11-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 28 Jun 2026 15:05:58 +0000
Message-Id: <20260628150558.CE42E1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Potential unaligned reference creation from `raw_data` when pointi=
ng to `stack_kdata`.
--

commit 8f60afaa1c169bb0b033e33cedd40ffff2147401
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: pin ioctl Device reference to Normal context

Explicitly annotate the Device reference produced by from_raw() in the ioctl
dispatch macro as Device<_, Normal>. This prevents the context from being
inferred from the handler's first parameter type, ensuring a handler cannot
obtain a Registered reference without runtime proof.

> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index ccf4150d83b69..6f5a9877bdae0 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs
> @@ -134,7 +134,8 @@ macro_rules! declare_drm_ioctls {
>                              // FIXME: Currently there is nothing enforci=
ng that the types of the
>                              // dev/file match the current driver these i=
octls are being declared
>                              // for, and it's not clear how to enforce th=
is within the type system.
> -                            let dev =3D $crate::drm::device::Device::fro=
m_raw(raw_dev);
> +                            let dev: &$crate::drm::device::Device<_, $cr=
ate::drm::Normal> =3D
> +                                $crate::drm::device::Device::from_raw(ra=
w_dev);
> =20
>                              // Enforce that the handler accepts higher-r=
anked
>                              // lifetimes, preventing it from requiring '=
static
[ ... ]
>                              // The `ioctl` argument is exclusively owned=
 by the handler
>                              // and guaranteed by the C implementation (`=
drm_ioctl()`) to remain
>                              // valid for the entire lifetime of the refe=
rence taken here.
>                              // There is no concurrent access or aliasing=
; no other references
>                              // to this object exist during this call.
>                              let data =3D unsafe { &mut *(raw_data.cast::=
<$crate::uapi::$struct>()) };

[Severity: High]
This isn't a bug introduced by this patch, but does this create an unaligned
reference?

The C function drm_ioctl() allocates char stack_kdata[128]; on the stack for
ioctl payloads <=3D 128 bytes, which only guarantees 1-byte alignment.

When declare_drm_ioctls!() receives this pointer as raw_data and
unconditionally casts it to create a mutable reference:

    let data =3D unsafe { &mut *(raw_data.cast::<$crate::uapi::$struct>()) =
};

it violates Rust's strict alignment rules for references.

Creating a reference to under-aligned memory is immediate undefined behavior
in Rust, regardless of whether the target architecture supports unaligned
accesses.

Because this path is reachable by any unprivileged userspace program calling
DRM ioctls, could this lead to a denial of service if LLVM emits instructio=
ns
that trap (such as vectorized operations)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260628145406.2107=
056-1-dakr@kernel.org?part=3D10
