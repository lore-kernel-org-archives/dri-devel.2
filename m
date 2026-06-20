Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18733CD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 01:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57EEB10E142;
	Sat, 20 Jun 2026 01:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fyFIUzK5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A097510E142
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 01:10:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 534E74196E;
 Sat, 20 Jun 2026 01:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043AC1F000E9;
 Sat, 20 Jun 2026 01:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781917848;
 bh=3hQPJxyIzOBRroyu5VCHSV7y+KLwgIxa771Vt79Ox64=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fyFIUzK5YzgPjJDjfDWh6wmhTFO8KV25c0V91IHTcIxrSaSnYnKMCgJR/bIOIIVhe
 Jg7CfAFiYSi96jM9oKjNk8Te96suUJ7h7evwx0ciehnvV9Bnm+WU10O8r5dUIGqTF+
 dAZkJbSW1NLbr9Ydp3vbHOh8yXbA8cRc+L5xh5BjLXJbufZMZgpGwTYF1Dj8geV/qc
 Y/RYoAW6zfkt7S76ZPjqhk+PxTApKnCM4vnMGec0PouDSAPk8m8TaSxwwgJHKmSjlr
 OP+I8rmkPO7dfLffmLrZR/O7psXeW/UqGGsprJe7rcv+M3s0MkdfN6nFLvqLo/BSah
 wKiqD9fTg9H8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/13] rust: drm: Add RegistrationData to drm::Driver
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260620005431.1562115-11-dakr@kernel.org>
References: <20260620005431.1562115-1-dakr@kernel.org>
 <20260620005431.1562115-11-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 01:10:47 +0000
Message-Id: <20260620011048.043AC1F000E9@smtp.kernel.org>
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
- [High] Missing `Sync` and `Send` bounds on `RegistrationData` allows safe=
 code to introduce data races when concurrently accessed via `Device` or `R=
egistration`.
- [High] `registration_guard()` can be called on an `UnregisteredDevice`, a=
llowing access to an uninitialized (dangling) `registration_data` pointer.
--

commit 44df82d554a5a6b1d866d87bea0b20d5dd954c66
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: Add RegistrationData to drm::Driver

This commit adds a RegistrationData associated type to drm::Driver. It is
tied to the parent bus device binding scope and stored in drm::Device before
registration. Access is provided via Device::registration_data_with().

> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index bc8cfd753596e..0a2ee308b1b2a 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs

[ ... ]

> @@ -230,6 +232,9 @@ pub fn new(
>          // SAFETY: `drm_dev` is still private to this function.
>          unsafe { (*drm_dev).driver =3D const { &Self::VTABLE } };
> =20
> +        // SAFETY: `raw_drm` is valid; no concurrent access before regis=
tration.
> +        unsafe { (*raw_drm.as_ptr()).registration_data =3D UnsafeCell::n=
ew(NonNull::dangling()) };

[Severity: High]
Could a caller safely dereference this dangling pointer by calling
registration_guard() before the device is actually registered?

Since UnregisteredDevice dereferences to Device, a caller can invoke
registration_guard() before registration. The C function drm_dev_enter()
only checks if the device is unplugged, not if it has been registered, so it
will return true and grant a RegistrationGuard prematurely.

If safe code then calls registration_data_with() on that guard, it seems it
would result in a dangling pointer dereference here:

    unsafe { (*self.registration_data.get()).cast::<_>().as_ref() }

> +
>          // SAFETY: The reference count is one, and now we take ownership=
 of that reference as a
>          // `drm::Device`.
>          // INVARIANT: We just created the device above, but have yet to =
call `drm_dev_register`.

[ ... ]

> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index ceb2829985c78..987d116e3501e 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs

[ ... ]

> @@ -110,6 +110,16 @@ pub trait Driver {
>      /// Context data associated with the DRM driver
>      type Data: Sync + Send;
> =20
> +    /// Data owned by the [`Registration`] and accessible within a
> +    /// [`RegistrationGuard`](drm::RegistrationGuard) critical section v=
ia
> +    /// [`Device::registration_data_with()`](drm::Device::registration_d=
ata_with).
> +    ///
> +    /// This is a [`ForLt`](trait@ForLt) type whose lifetime is tied to =
the parent bus
> +    /// device binding scope. References handed out by
> +    /// [`Device::registration_data_with()`](drm::Device::registration_d=
ata_with) are tied to
> +    /// the closure scope.
> +    type RegistrationData: ForLt;

[Severity: High]
Does this type definition need Sync and Send bounds to prevent data races?

Since drm::Device unconditionally implements Sync, references to the
device can be shared across multiple threads. The new registration_data_wit=
h()
method allows these threads to concurrently obtain shared references to
RegistrationData.

If a driver author provides a type that is not thread-safe (such as Cell)
for RegistrationData in safe Rust, multiple threads could concurrently acce=
ss
and mutate the inner data, potentially leading to data races.

> +
>      /// The type used to manage memory for this driver.
>      type Object: AllocImpl;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620005431.1562=
115-1-dakr@kernel.org?part=3D10
