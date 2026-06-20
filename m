Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2399DCD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 19:06:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F3D410E1BD;
	Sat, 20 Jun 2026 19:06:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OLJEefu7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6AD510E1BD
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 19:06:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8667F43D47;
 Sat, 20 Jun 2026 19:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9F61F000E9;
 Sat, 20 Jun 2026 19:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781982408;
 bh=jH6sdNQijcjzWP6Bcezp8Tcw9cLph6Uxl4jHPcj0+QA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OLJEefu7q0rHGu/N9KIGOgwgeNrj3fpGpN+yqewVNYx0CvtODiAeHuZua8KqI3cIy
 ZXRorFP4bqPaFuJRHN+BiOAMrNW3yzERRE0+n54icUqmc7A0wX4lK+W8JEfb6C1ONq
 i9kJfEc4OtMgJhc2CdQ5emcv5UI1CYNnstpvI1Sgxmrjvr/Wxb+zq75wOwjI0VWu4o
 umpOrL8xFiGLY7m93/spgBJEZcbt0/cydlHWFgaSqZwdYO4rImTliTkBopgD2N4nGW
 Xq/23erzi3GeNYj1ODWawj/SQnP0SqVmH4E+/WrU/VU5fNzBXcFMp44ttd7/sSvyLv
 qEE/ckiM9u0aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/16] rust: drm: Add RegistrationData to drm::Driver
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260620184924.2247517-15-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-15-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 19:06:47 +0000
Message-Id: <20260620190648.2E9F61F000E9@smtp.kernel.org>
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
- [Critical] Unsound lifetime shortening of `RegistrationData` allows safe =
code to trigger a use-after-free.
- [High] Data race and use-after-free on `RegistrationData` when `drm_dev_r=
egister()` fails.
--

commit 4c4fafa27855b4e677d80a9c3bf6cb9acd303180
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: Add RegistrationData to drm::Driver

This patch introduces a RegistrationData associated type for drm::Driver
whose lifetime is tied to the parent bus device. It manages the registration
scope and provides safe access to this data within a RegistrationGuard.

> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 8f63276c9b62f..fc79f90a197d9 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs

[ ... ]

> +    #[inline]
> +    unsafe fn registration_data_unchecked(&self) -> &<T::RegistrationDat=
a as ForLt>::Of<'_> {
> +        // SAFETY:
> +        // - Caller guarantees the parent bus device is bound, hence the=
 pointer is valid.
> +        // - The pointer cast from `Of<'static>` to `Of<'_>` is layout-c=
ompatible since lifetimes
> +        //   are erased at runtime.
> +        // - Caller guarantees the reference is only used behind an HRTB=
, making the lifetime
> +        //   shortening sound regardless of variance.
> +        unsafe { (*self.registration_data.get()).cast::<_>().as_ref() }
> +    }

[ ... ]

> +    pub fn registration_data_with<R, F>(&self, f: F) -> R
> +    where
> +        F: for<'a> FnOnce(&'a <T::RegistrationData as ForLt>::Of<'a>) ->=
 R,
> +    {
> +        // SAFETY: `Registered` guarantees the device is registered and =
the parent bus device is
> +        // bound. The closure's HRTB `for<'a>` prevents the caller from =
smuggling in references
> +        // with a concrete short lifetime, satisfying the lifetime requi=
rement of
> +        // `registration_data_unchecked`.
> +        f(unsafe { self.registration_data_unchecked() })
> +    }

[Severity: Critical]
Does this lifetime shortening cast violate soundness if the Of<'a> type is
invariant (e.g., Cell<&'a u32> or Mutex<Option<&'a u32>>)?

Even with the HRTB bound in registration_data_with(), safe driver code could
do something like device.registration_data_with(|data| data.set(&local_var))
where local_var outlives the closure but not the device's 'bound lifetime.
Because the lifetime of the invariant container was shortened to the closur=
e's
scope, the compiler will accept this and allow writing a short-lived refere=
nce
into it.

When the function returns and local_var is dropped, the physical
RegistrationData container living in the device will hold a dangling pointe=
r,
leading to a use-after-free when the data is accessed again.

> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index ceb2829985c78..e42b48e5cad28 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs

[ ... ]

> +        // SAFETY: `drm` is a valid, initialized but not yet registered =
DRM device.
> +        let ret =3D unsafe { bindings::drm_dev_register(drm.as_raw(), fl=
ags) };
> +        if let Err(e) =3D to_result(ret) {
> +            // SAFETY: No concurrent access; registration failed.
> +            unsafe { *drm.registration_data.get() =3D NonNull::dangling(=
) };
> +            return Err(e);
> +        }

[Severity: High]
Can this error path trigger a use-after-free if drm_dev_register() fails
partway through its initialization?

During drm_dev_register(), minor nodes (such as the render node) are
registered sequentially via drm_minor_register(). As soon as a minor node is
registered, userspace can open it and begin executing ioctls. These concurr=
ent
ioctls will successfully enter the RegistrationGuard critical section since
dev->unplugged is false.

If drm_dev_register() subsequently fails on the primary node, it returns an
error without calling drm_dev_unplug() (which would otherwise perform an SR=
CU
barrier to wait for existing readers). Returning Err(e) here causes the
RegistrationData to be dropped and freed, while a concurrent ioctl still
inside its drm_dev_enter() critical section could access this freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620184924.2247=
517-1-dakr@kernel.org?part=3D14
