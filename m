Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4692CCD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 18:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A193110E271;
	Sat, 20 Jun 2026 18:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oES8DkYH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2346810E270
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 18:59:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F17C942AEE;
 Sat, 20 Jun 2026 18:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4EA1F000E9;
 Sat, 20 Jun 2026 18:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781981985;
 bh=OzFC1dOKiO+czBRFhVGFyLfrcehWJ7DXtK3IViJF3G4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oES8DkYHc4VPM4bnY87NOR4W+JdqqBt7P9H6CqaIjnhyJBQG0320SepkutbjVCXel
 Yuc8Hv613KtsI4xqGt5a0+wIVRiwaYrkfKGAqC7RhOWVo+2pZgzRXwm7e/lQ2fryG4
 sRlT88fsU8SrPqUyInMsCyQfvZJJHz2S4548GUSVsg9kg6/q62rAm0tuFuF/hJw3QO
 SqqDQXxsmmB3vDKrTfco3V16KA6Yox/9AxIiIKJoBRwJBbpCtd1p8g4klDpld7hICg
 nzPp90ax2VijQZxy2GsrwNJ1a5ECHHjuSCJI+J5tjn6/O5THPfqebvw7m5pxgMsMbK
 30LXCAIfZDHxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/16] rust: drm: pin ioctl Device reference to
 Normal context
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260620184924.2247517-9-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-9-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 18:59:45 +0000
Message-Id: <20260620185945.AF4EA1F000E9@smtp.kernel.org>
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
- [High] Out-of-Bounds Memory Access via Type Inference in `declare_drm_ioc=
tls!`
- [High] Type Confusion via Unconstrained Device and File Generic Parameters
--

commit 0938877e05968d385af3ba72b727ba8164977c11
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: pin ioctl Device reference to Normal context
   =20
Explicitly annotate the Device reference produced by from_raw() in the
ioctl dispatch macro as Device<_, Normal>. Without this annotation, the
context is inferred from the handler's first parameter type, which would
allow a handler declaring &Device<T, Registered> to obtain a Registered
reference without runtime proof via RegistrationGuard.

> diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
> index 023e6da5c1e4b..70cf1aa4d788f 100644
> --- a/rust/kernel/drm/ioctl.rs
> +++ b/rust/kernel/drm/ioctl.rs
> @@ -167,7 +167,8 @@ macro_rules! declare_drm_ioctls {
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

[Severity: High]
This isn't a bug introduced by this patch, but looking at the FIXME comment
and the use of the generic wildcard for the driver type in
Device<_, Normal>, could this lead to type confusion?

If a developer provides a handler expecting a Device for DriverB but
registers it in DriverA's ioctl array, it seems Device::from_raw() will cast
the C pointers for DriverA into references for DriverB. Any subsequent acce=
ss
to the device or file private data would then cause memory corruption.

Also, for the File type:

rust/kernel/drm/ioctl.rs:internal::__call_ioctl() {
    ...
    let file =3D unsafe { super::super::File::<F>::from_raw(raw_file) };
    ...
}

Is there a way to enforce that the Device and File generic parameters of the
user-provided ioctl handler match the actual driver registering the ioctls?

>                              let __anchor =3D ();
> =20
>                              // SAFETY:

[Severity: High]
This is a pre-existing issue, but does declare_drm_ioctls! constrain the
inferred Data type for the ioctl payload?

Looking at __call_ioctl(), the Data generic type is inferred from the second
parameter of the user-provided handler:

rust/kernel/drm/ioctl.rs:internal::__call_ioctl() {
    ...
    let data =3D unsafe { &mut *(raw_data.cast::<Data>()) };
    ...
}

If a handler expects a mutable reference to a data type larger than the
declared struct (for example, a very large array), __call_ioctl() casts
raw_data to that larger type. Since the DRM core allocates exactly
_IOC_SIZE(cmd) bytes based on the macro's struct, could this result in an
out-of-bounds heap read/write?

Could the type-inference anchor be updated to explicitly constrain the data
parameter, perhaps using let mut data: $crate::uapi::$struct =3D unreachabl=
e!();
instead of unreachable!()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620184924.2247=
517-1-dakr@kernel.org?part=3D8
