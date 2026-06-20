Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F126ACD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 01:13:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD5E510E15B;
	Sat, 20 Jun 2026 01:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EDTmJp69";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A8D10E15B
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 01:13:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5FEC600AE;
 Sat, 20 Jun 2026 01:13:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B801F000E9;
 Sat, 20 Jun 2026 01:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781917980;
 bh=SzS1khSL12rcuYySZDONR8LwYTIaah9wxy+VFfjgaLM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EDTmJp69L44A67UMjm7Ri6UVEqY51RyaxPMvCM1WC1xn5Skk4osCCo3FB2IvZFzX4
 TwbwgPePuYwOeBAv3LSeztuXpo0nPLvBP1GGFp2Bc260AxRgGeVmAHPIekUHFQ6xDc
 W30oEZwXg8chf4NWgIsedkOnlMJ+/bfFtqqdBGOy4m6ruT+kqAzvwNGAmr2CpTkwCy
 csXc995hLuuLfSs3/6FESfCzK4S78DntpFnGFkfDX1EAAPOTARyts7VjiD+c9MwcqX
 petVH8L5HanRqV6WBD+MItxIoCrVzGSyZZh+mv4MojVxt/X25z55GWlQvrDQHq3fba
 BJmI4SgIYMNHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/13] rust: drm: Add RegistrationGuard for
 drm_dev_enter/exit critical sections
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org,
 "Alexandre Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260620005431.1562115-10-dakr@kernel.org>
References: <20260620005431.1562115-1-dakr@kernel.org>
 <20260620005431.1562115-10-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 01:12:59 +0000
Message-Id: <20260620011259.F0B801F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Device::registration_guard() grants a `Registered` context to unre=
gistered devices, allowing access to unbound hardware.
- [High] RegistrationGuard is implicitly `Send`, causing lockdep splats if =
dropped on a different thread.
- [Medium] Safe Rust can cause an SRCU deadlock by dropping `Registration` =
while holding `RegistrationGuard`.
--

commit 3b6c73976ebe0a7066664f9ddc910e85fe1582da
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: Add RegistrationGuard for drm_dev_enter/exit critical sections

This patch adds RegistrationGuard, a guard object representing a=20
drm_dev_enter/exit SRCU critical section. It also changes=20
Registration::drop to use drm_dev_unplug() instead of=20
drm_dev_unregister() to provide the SRCU barrier required for safety.

> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 885077e270ebc..bc8cfd753596e 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs

[ ... ]

> @@ -323,6 +321,62 @@ pub(crate) unsafe fn assume_ctx<NewCtx: DeviceContex=
t>(&self) -> &Device<T, NewC
>      }
>  }
> =20
> +impl<T: drm::Driver> Device<T> {
> +    /// Guard against the parent bus device being unbound.
> +    ///
> +    /// Returns a [`RegistrationGuard`] if the device has not been unplu=
gged, [`None`] otherwise.
> +    ///
> +    /// While [`RegistrationGuard`] is held the parent device is guarant=
eed to be bound.
> +    #[must_use]
> +    pub fn registration_guard(&self) -> Option<RegistrationGuard<'_, T>>=
 {
> +        let mut idx: i32 =3D 0;
> +        // SAFETY: `self.as_raw()` is a valid pointer to a `struct drm_d=
evice`.
> +        if unsafe { bindings::drm_dev_enter(self.as_raw(), &mut idx) } {

[Severity: High]
Does this logic correctly prove the device is registered?

Because dev->unplugged defaults to false upon allocation, drm_dev_enter()
will return true for an UnregisteredDevice that has not yet called
drm_dev_register().=20

If device probe fails, the kernel unwinds devres-managed resources but never
creates a Registration or calls drm_dev_unplug(). If an ARef<Device> is
kept alive by a background thread, registration_guard() will still succeed
and return a RegistrationGuard.

This guard dereferences to Device<T, Registered>, which falsely exposes the
parent bus device as bound. Could this lead to a Use-After-Free or invalid
memory access if the parent device's devres-managed hardware resources are
accessed after probe failure?=20

Should the guard explicitly verify the registration state (e.g.,
dev->registered) after acquiring the SRCU lock?

> +            Some(RegistrationGuard { dev: self, idx })
> +        } else {
> +            None
> +        }
> +    }
> +}
> +
> +/// A guard proving the DRM device is registered and the parent bus devi=
ce is bound.
> +///
> +/// The guard dereferences to [`Device<T, Registered>`], providing acces=
s to the DRM device with
> +/// the guarantee that the parent bus device is bound for the entire dur=
ation of the critical
> +/// section.
> +///
> +/// Internally this is backed by a `drm_dev_enter()` / `drm_dev_exit()` =
SRCU critical section.
> +///
> +/// # Invariants
> +///
> +/// - `idx` is the SRCU read lock index returned by a successful `drm_de=
v_enter()` call.
> +/// - The parent bus device of `dev` is bound for the lifetime of this g=
uard.
> +#[must_use]
> +pub struct RegistrationGuard<'a, T: drm::Driver> {
> +    dev: &'a Device<T>,
> +    idx: i32,
> +}

[Severity: High]
Is it intentional that RegistrationGuard is implicitly Send?

Because its inner fields are Send, this allows safe Rust to acquire the
guard on one thread and drop it on another.

While SRCU technically allows cross-thread unlocks, the kernel's lockdep
implementation tracks SRCU read locks per-task. If a guard is dropped on a
different thread, will lockdep emit a bad unlock balance detected splat?

Should RegistrationGuard be explicitly marked !Send (e.g., by adding a
PhantomData<*mut ()> field)?

> +
> +impl<T: drm::Driver> Deref for RegistrationGuard<'_, T> {
> +    type Target =3D Device<T, Registered>;
> +
> +    #[inline]
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: A successful `drm_dev_enter()` guarantees that the de=
vice is registered and
> +        // the parent bus device is bound.
> +        unsafe { self.dev.assume_ctx() }

[Severity: High]
Does a successful drm_dev_enter() alone guarantee the Registered state?

As mentioned above, if drm_dev_enter() succeeds on an UnregisteredDevice
after probe failure, this unsafe block will grant the Registered state
incorrectly.

> +    }
> +}

[ ... ]

> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index 9ba7dc3a7a97a..ceb2829985c78 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs

[ ... ]

> @@ -199,8 +199,14 @@ unsafe impl<T: Driver> Send for Registration<T> {}
> =20
>  impl<T: Driver> Drop for Registration<T> {
>      fn drop(&mut self) {
> +        // Use `drm_dev_unplug` rather than `drm_dev_unregister` to ensu=
re that existing
> +        // `drm_dev_enter()` critical sections complete before unregistr=
ation proceeds. This
> +        // is required for the safety of `RegistrationGuard`, which reli=
es on the SRCU barrier in
> +        // `drm_dev_unplug()` to guarantee that the parent device is sti=
ll bound within the
> +        // critical section.
> +        //
>          // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The =
existence of this
> -        // `Registration` also guarantees the this `drm::Device` is actu=
ally registered.
> -        unsafe { bindings::drm_dev_unregister(self.0.as_raw()) };
> +        // `Registration` also guarantees that this `drm::Device` is act=
ually registered.
> +        unsafe { bindings::drm_dev_unplug(self.0.as_raw()) };

[Severity: Medium]
Can dropping Registration while holding RegistrationGuard on the same
thread cause an SRCU deadlock?

drm_dev_unplug() synchronously waits for all SRCU readers by calling
synchronize_srcu(&drm_unplug_srcu). Since safe Rust can acquire an
independent reference to the device, obtain a RegistrationGuard (which
holds the SRCU read lock), and then drop Registration on the same thread,
synchronize_srcu() could be called from within its own read-side critical
section.

Would this deadlock the thread and trigger an SRCU lockdep warning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620005431.1562=
115-1-dakr@kernel.org?part=3D9
