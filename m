Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CC5C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACE7810ED4C;
	Fri, 14 Aug 2026 23:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NP58/Zma";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E933A10ED4C
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:23:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5F64060008;
 Fri, 14 Aug 2026 23:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E9A1F000E9;
 Fri, 14 Aug 2026 23:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786749823;
 bh=hEZBbAw5FsK9X0nXHPRK7WpuPegRddDhOSOZ9UR/O08=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NP58/ZmahAssxW2xWKk3M0V48+ahaMRMpwPOF2XApYen/70tFs81vzWrrjIIz9fqk
 c+gL7pJLxf/I3VPdugqoXN4wFlN+EwMY/foe+eBDrmm8VMZ+UACxgt73ElT84M1H82
 UgLbsV0GwIZ20g1t+9ObZxoReUKPLM4ghp4lJI24T9GxyXhiYVELazSVmt+959yejk
 yh5cdFdNoFoHqye9fS1ZJ//r/B32u4SMPNnp/HWsJWRk15C10X0BE3uZCRZcbXrJGz
 0XLGuNRVWjTzbooa4BUkS7Hmy3aI6h9aD/Z1CVxGcL1XACAQZpVXA01dWFy2/fyWD/
 CBu64XV80fLog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] rust: drm: make Driver::File lifetime-parameterized
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260814230923.1292966-7-dakr@kernel.org>
References: <20260814230923.1292966-1-dakr@kernel.org>
 <20260814230923.1292966-7-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 23:23:42 +0000
Message-Id: <20260814232342.C6E9A1F000E9@smtp.kernel.org>
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
- [High] Lock inversion in Registration::drop() when freeing file data unde=
r filelist_mutex
- [Low] Missing #[inline] annotations on small abstraction functions
--

--- Patch [6]: [PATCH 6/7] rust: drm: make Driver::File lifetime-parameteri=
zed ---
commit f0644f05187ec5973de59ac9760eaeeee5140b6a
Author: Danilo Krummrich <dakr@kernel.org>

rust: drm: make Driver::File lifetime-parameterized

Make the DRM file private data lifetime-parameterized, allowing drivers
to borrow from RegistrationData in their per-file data.

> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
[ ... ]
> @@ -221,6 +237,51 @@ fn drop(&mut self) {
>          unsafe { bindings::drm_dev_unplug(self.drm.as_raw()) };
>          // After drm_dev_unplug(), the SRCU barrier guarantees that all =
RegistrationGuard critical
>          // sections have completed, so no one holds a reference to reg_d=
ata anymore.
> -        // reg_data is dropped here automatically.
> +
> +        // Drop all remaining file private data before dropping registra=
tion data. This guarantees
> +        // that file data (which may borrow from RegistrationData) is al=
ways dropped first.
> +        let raw =3D self.drm.as_raw();
> +
> +        // SAFETY: `filelist_mutex` is initialized by `drm_dev_init()` a=
nd remains valid for
> +        // the lifetime of the `struct drm_device`.
> +        let filelist_mutex =3D unsafe { Mutex::from_raw(&raw mut (*raw).=
filelist_mutex) };
> +        {
> +            let _guard =3D filelist_mutex.lock();
> +
> +            // SAFETY: `filelist` is a valid, initialized sentinel `list=
_head`; the mutex
> +            // guard prevents concurrent modification.
> +            let filelist =3D unsafe {
> +                clist_create!(
> +                    &raw mut (*raw).filelist,
> +                    drm::File<T>,
> +                    bindings::drm_file,
> +                    lhead
> +                )
> +            };
> +
> +            for file in filelist.iter() {
> +                // SAFETY: `file` is a valid `drm_file` on this device's=
 filelist.
> +                let priv_ptr =3D unsafe { (*file.as_raw()).driver_priv };
> +
> +                // SAFETY: Setting `driver_priv` to NULL is visible to `=
postclose_callback()`
> +                // through the `filelist_mutex` acquire/release chain in=
 `drm_close_helper()`.
> +                unsafe { (*file.as_raw()).driver_priv =3D core::ptr::nul=
l_mut() };
> +
> +                // SAFETY: `driver_priv` was created by `open_callback()=
` via `KBox::into_raw` and
> +                // has not yet been freed (the file is still in the list=
, so `postclose_callback()`
> +                // has not run).
> +                drop(unsafe { KBox::from_raw(priv_ptr.cast::<<T::File as=
 ForLt>::Of<'static>>()) });

[Severity: High]
Does dropping the file data while holding `filelist_mutex` introduce a lock
inversion risk?

If the driver's File Drop implementation acquires a driver-specific lock, t=
his
creates a `filelist_mutex` -> driver lock dependency.

Since VFS operations routinely take driver locks before the DRM core takes
`filelist_mutex` (e.g., in `drm_file_free`), this could violate core kernel
locking rules and cause an AB-BA deadlock on device unplug.

> +
> +                self.drm.open_count.fetch_sub(1, Release);
> +            }
> +        }
> +
> +        // Wait for in-flight `postclose_callback()` calls to complete. =
After `drm_dev_unplug()`, no
> +        // new opens can succeed, so `open_count` is monotonically decre=
asing.
> +        self.drm
> +            .open_count_wq
> +            .wait_event(|| self.drm.open_count.load(Acquire) =3D=3D 0);
> +
> +        // `_reg_data` is dropped here automatically, after all file dat=
a has been dropped.
>      }
>  }
> diff --git a/rust/kernel/drm/file.rs b/rust/kernel/drm/file.rs
> --- a/rust/kernel/drm/file.rs
> +++ b/rust/kernel/drm/file.rs
[ ... ]
> @@ -45,59 +62,94 @@ pub(super) fn as_raw(&self) -> *mut bindings::drm_fil=
e {
>          self.0.get()
>      }
> =20
> -    fn driver_priv(&self) -> *mut T {
> -        // SAFETY: By the type invariants of `Self`, `self.as_raw()` is =
always valid.
> -        unsafe { (*self.as_raw()).driver_priv }.cast()
> +    /// Return a pinned reference to the driver file data.
> +    ///
> +    /// Only available when `D::File` implements [`trait@CovariantForLt`=
]. For invariant types, use
> +    /// [`inner_with()`](Self::inner_with).
> +    pub fn inner(&self) -> Pin<&<D::File as ForLt>::Of<'_>>
> +    where
> +        D::File: CovariantForLt,

[Severity: Low]
This isn't a bug, but shouldn't this small accessor abstraction function be
annotated with #[inline]?

> +    {
> +        // SAFETY: `driver_priv` was initialized by `open_callback()`. `=
CovariantForLt` guarantees
> +        // the lifetime shortening from `'static` to `'_` is sound.
> +        unsafe { Pin::new_unchecked(&*(*self.as_raw()).driver_priv.cast_=
const().cast()) }
>      }
> =20
> -    /// Return a pinned reference to the driver file structure.
> -    pub fn inner(&self) -> Pin<&T> {
> -        // SAFETY: By the type invariant the pointer `self.as_raw()` poi=
nts to a valid and opened
> -        // `struct drm_file`, hence `driver_priv` has been properly init=
ialized by `open_callback`.
> -        unsafe { Pin::new_unchecked(&*(self.driver_priv())) }
> +    /// Access the driver file data through a closure.
> +    ///
> +    /// This works for all file data types, including invariant ones. Fo=
r covariant types,
> +    /// [`inner()`](Self::inner) provides direct access without a closur=
e.
> +    pub fn inner_with<R, F>(&self, f: F) -> R
> +    where
> +        F: for<'a> FnOnce(Pin<&'a <D::File as ForLt>::Of<'a>>) -> R,

[Severity: Low]
This isn't a bug, but shouldn't this abstraction function also be annotated
with #[inline]?

> +    {
> +        // SAFETY: `driver_priv` was initialized by `open_callback()`. T=
he HRTB `for<'a>` prevents
> +        // the caller from choosing a concrete lifetime, making the life=
time shortening sound
> +        // regardless of variance.
> +        f(unsafe { Pin::new_unchecked(&*(*self.as_raw()).driver_priv.cas=
t_const().cast()) })
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814230923.1292=
966-1-dakr@kernel.org?part=3D6
