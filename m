Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE250C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB1210F15D;
	Fri, 14 Aug 2026 23:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RWNjXBqn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B05A10F4BC
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:21:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EC7A600E2;
 Fri, 14 Aug 2026 23:21:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AA71F000E9;
 Fri, 14 Aug 2026 23:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786749666;
 bh=40Qtsk/EfvbsvzSzPzG46nxlKdPTaSSnygGR4nbw3qk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RWNjXBqnqmHMW69HEO7G2Cqa/JSOC44t5kbYn8QFIrbzaoArw1CrlFv7ePtfKhNSW
 sTH103PD8XnBDIAdsNrh+2pTh61eTuUNiDKWL89TtgUnibJp1GyxAJQCw0OUBLyhv5
 ZMpBvDHiAnO3xRIwjb1iIYRpMTEnogO0hE/GKzMbNo9YSrp5Q57vOV/98M2hlzBKnk
 iwCwIdzhC/MEQw58rD+5rEwbJgvnjeZ+Gn/oV7IBonuY1O5AyLVcOGaQwa1XyKc8rb
 RUF2yvFrfrKhGx/B8wyPF+aQxTEDt+4IEQIJEh3bRFUHkmHxFz+Xlz7uspRHoOA5Xt
 95GEQ9YWs0EDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] rust: drm: gem: gate open/close callbacks with
 RegistrationGuard
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260814230923.1292966-3-dakr@kernel.org>
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-3-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:21:05 +0000
Message-Id: <20260814232106.01AA71F000E9@smtp.kernel.org>
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
- [High] Bypassing `T::close` when the DRM device is unregistered leaks dri=
ver-specific resources and software state allocated in `T::open`.
- [High] Wrapping the entire `open` and `close` callbacks in `RegistrationG=
uard` introduces a severe AB-BA deadlock hazard with the device unplug path.
--

--- Patch [2]: [PATCH 2/7] rust: drm: gem: gate open/close callbacks with R=
egistrationGuard ---
commit 56b4431da0d3b7c0798814690d882352e01b7d71
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: gem: gate open/close callbacks with RegistrationGuard
   =20
Wrap the GEM object open and close callbacks with a RegistrationGuard
(drm_dev_enter / drm_dev_exit) to ensure the driver callbacks only run
while the parent bus device is bound.

If the device has been unbound, open returns -ENODEV and close silently
returns. This prevents driver code from accessing device resources after
unbind and is a prerequisite for making drm::Driver::File
lifetime-parameterized.

> diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
> index 80d8f524f9d57..560403ca8e38f 100644
> --- a/rust/kernel/drm/gem/mod.rs
> +++ b/rust/kernel/drm/gem/mod.rs
> @@ -128,6 +128,14 @@ extern "C" fn open_callback<T: DriverObject>(
>      raw_obj: *mut bindings::drm_gem_object,
>      raw_file: *mut bindings::drm_file,
>  ) -> core::ffi::c_int {
> +    // SAFETY: `raw_obj` is a valid pointer to a `struct drm_gem_object`=
 with a valid `dev`.
> +    let dev: &drm::Device<T::Driver, drm::Userspace> =3D
> +        unsafe { drm::Device::from_raw((*raw_obj).dev) };
> +
> +    let Some(_guard) =3D dev.registration_guard() else {

[Severity: High]
Could this cause an AB-BA deadlock with the device unplug path?

If an unbind thread acquires a driver-specific lock and then calls
drm_dev_unplug(), it will block in synchronize_srcu(&drm_unplug_srcu)
waiting for SRCU read sections to finish.

Concurrently, if a userspace thread opens a GEM handle, this
registration_guard() call takes the drm_unplug_srcu read lock.

When the callback proceeds to call T::open(), the driver might try to
acquire the same driver-specific lock held by the unbind thread, deadlocking
the system.

> +        return ENODEV.to_errno();
> +    };
> +
>      // SAFETY: `open_callback` is only ever called with a valid pointer =
to a `struct drm_file`.
>      let file =3D unsafe { DriverFile::<T>::from_raw(raw_file) };

[ ... ]

> @@ -148,6 +156,14 @@ extern "C" fn close_callback<T: DriverObject>(
>      raw_obj: *mut bindings::drm_gem_object,
>      raw_file: *mut bindings::drm_file,
>  ) {
> +    // SAFETY: `raw_obj` is a valid pointer to a `struct drm_gem_object`=
 with a valid `dev`.
> +    let dev: &drm::Device<T::Driver, drm::Userspace> =3D
> +        unsafe { drm::Device::from_raw((*raw_obj).dev) };
> +
> +    let Some(_guard) =3D dev.registration_guard() else {
> +        return;

[Severity: High]
Is it safe to return early here without calling T::close()?

If a GEM object is created while the device is bound, and the device is then
hot-unplugged, the guard check will fail.

Returning early skips the software cleanup in T::close(), which could
permanently leak driver-specific memory and state (like tracking lists or I=
DR
entries) allocated during T::open().

> +    };
> +
>      // SAFETY: `open_callback` is only ever called with a valid pointer =
to a `struct drm_file`.
>      let file =3D unsafe { DriverFile::<T>::from_raw(raw_file) };
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814230923.1292=
966-1-dakr@kernel.org?part=3D2
