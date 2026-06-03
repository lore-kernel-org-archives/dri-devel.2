Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF070CD6E60
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 23:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15EC21124AA;
	Wed,  3 Jun 2026 23:29:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="Cn/DteXE";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BE0C1124AA
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 23:29:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780529370; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=klD0oSjMZ7bpaVD9SayonvDK4+LXq0eYJt/157VBA/x6aa1cIbLi3NldDtZF2h36jyfAk3QbsEwKTdDHmPsN4nzCclfzH0vlQp1mAl8Ts0+doZBNUtR0/vyaoLTAubXiYPfDEdoIoRdJ0KwlY0ZY1KMWlcnhTROPWkbNNXmKHtk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780529370;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7hGjdJB21J965Tloxk+FqpvMVaXeHADzpVTvKXzoRaY=; 
 b=G5TnPM0KNe2smnSHnzg21Z5TFMUlTphQz9F39194e7Y98SQ5gnyPtq0wWNyTAigDQEJbFNfAzP3Szl2EsA86IVavvW8+LYClElYUKlrb/msODnZQEV6CcUrPmzwOsDxUoGfMTd3WhcSTlh46yYTbP443p7rHVNOj3P8d7J1sDJ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780529370; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=7hGjdJB21J965Tloxk+FqpvMVaXeHADzpVTvKXzoRaY=;
 b=Cn/DteXEjXsIke2JLqXU34WpEv9JgtOsckSHICikprT7jdBo/5bo36CfDt8ye05N
 UFaWTsNVS++JKA/H6ULOEW3ReLpX4gzYAmi5IdeFBiSX6bOa/4feVhAdyX7xEhir9Dv
 GsGRrDc/gIfjsCNzWE/AdaJ7f1o1jhg3GamGMrqs=
Received: by mx.zohomail.com with SMTPS id 1780529368684554.2263972165351;
 Wed, 3 Jun 2026 16:29:28 -0700 (PDT)
Date: Wed, 3 Jun 2026 16:29:27 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: aliceryhl@google.com, daniel.almeida@collabora.com, acourbot@nvidia.com,
 ecourtney@nvidia.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu,
 boris.brezillon@collabora.com, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/7] rust: drm: Add RegistrationData to drm::Driver
Message-ID: <aiC41_huOYhvacQD@um790>
References: <20260603011711.2077361-1-dakr@kernel.org>
 <20260603011711.2077361-4-dakr@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603011711.2077361-4-dakr@kernel.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Jun 03, 2026 at 03:15:45AM +0200, Danilo Krummrich wrote:
> Add a RegistrationData associated type to drm::Driver. This is a ForLt
> type whose lifetime is tied to the parent bus device binding scope.
> 
> Registration<'a, T> takes ownership of the data via Pin<KBox<_>>,
> storing it with its real lifetime. The pointer is written to drm::Device
> before drm_dev_register() to ensure it is already in place when ioctls
> arrive.
> 
> UnbindGuard::registration_data_with() provides access with the lifetime
> shortened from 'static via ForLt::cast_ref_unchecked. Since
> Registration::drop() calls drm_dev_unplug(), which performs an SRCU
> barrier waiting for all drm_dev_enter() critical sections to complete,
> the data is guaranteed to remain valid for the duration of any
> UnbindGuard.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/drm/nova/driver.rs |  16 +++--
>  drivers/gpu/drm/tyr/driver.rs  |  16 +++--
>  rust/kernel/drm/device.rs      |  49 +++++++++++++
>  rust/kernel/drm/driver.rs      | 123 ++++++++++++++++++++++++---------
>  rust/kernel/drm/mod.rs         |   1 +
>  5 files changed, 162 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
> index c5b0313006bd..4267e6e6dbb4 100644
> --- a/drivers/gpu/drm/nova/driver.rs
> +++ b/drivers/gpu/drm/nova/driver.rs
> @@ -12,7 +12,8 @@
>          ioctl, //
>      },
>      prelude::*,
> -    sync::aref::ARef, //
> +    sync::aref::ARef,
> +    types::ForLt, //
>  };
>  
>  use crate::file::File;
> @@ -20,9 +21,10 @@
>  
>  pub(crate) struct NovaDriver;
>  
> -pub(crate) struct Nova {
> +pub(crate) struct Nova<'bound> {
>      #[expect(unused)]
>      drm: ARef<drm::Device<NovaDriver>>,
> +    _reg: drm::Registration<'bound, NovaDriver>,
>  }
>  
>  /// Convienence type alias for the DRM device type for this driver
> @@ -56,7 +58,7 @@ pub(crate) struct NovaData {
>  
>  impl auxiliary::Driver for NovaDriver {
>      type IdInfo = ();
> -    type Data<'bound> = Nova;
> +    type Data<'bound> = Nova<'bound>;
>      const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
>  
>      fn probe<'bound>(
> @@ -66,15 +68,19 @@ fn probe<'bound>(
>          let data = try_pin_init!(NovaData { adev: adev.into() });
>  
>          let drm = drm::UnregisteredDevice::<Self>::new(adev, data)?;
> -        let drm = drm::Registration::new_foreign_owned(drm, adev.as_ref(), 0)?;
> +        let reg = drm::Registration::new(adev.as_ref(), drm, (), 0)?;
>  
> -        Ok(Nova { drm: drm.into() })
> +        Ok(Nova {
> +            drm: reg.device().into(),
> +            _reg: reg,
> +        })
>      }
>  }
>  
>  #[vtable]
>  impl drm::Driver for NovaDriver {
>      type Data = NovaData;
> +    type RegistrationData = ForLt!(());
>      type File = File;
>      type Object<Ctx: drm::DeviceContext> = gem::Object<NovaObject, Ctx>;
>      type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
> diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> index 338c25ccc151..819f64a7573d 100644
> --- a/drivers/gpu/drm/tyr/driver.rs
> +++ b/drivers/gpu/drm/tyr/driver.rs
> @@ -31,7 +31,8 @@
>          aref::ARef,
>          Mutex, //
>      },
> -    time, //
> +    time,
> +    types::ForLt, //
>  };
>  
>  use crate::{
> @@ -52,8 +53,9 @@
>  pub(crate) struct TyrPlatformDriver;
>  
>  #[pin_data(PinnedDrop)]
> -pub(crate) struct TyrPlatformDriverData {
> +pub(crate) struct TyrPlatformDriverData<'bound> {
>      _device: ARef<TyrDrmDevice>,
> +    _reg: drm::Registration<'bound, TyrDrmDriver>,
>  }
>  
>  #[pin_data]
> @@ -98,7 +100,7 @@ fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
>  
>  impl platform::Driver for TyrPlatformDriver {
>      type IdInfo = ();
> -    type Data<'bound> = TyrPlatformDriverData;
> +    type Data<'bound> = TyrPlatformDriverData<'bound>;
>      const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
>  
>      fn probe<'bound>(
> @@ -150,10 +152,11 @@ fn probe<'bound>(
>          });
>  
>          let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
> -        let tdev = drm::driver::Registration::new_foreign_owned(tdev, pdev.as_ref(), 0)?;
> +        let reg = drm::Registration::new(pdev.as_ref(), tdev, (), 0)?;

Hi Danilo, could we use separate data arguments in UnregisteredDevice
vs in the Registration? Basically we want to use the UnregisteredDevice
to initialize and boot the firmware which we then store as registration
data.

Could you have a look at this patch, it applies on top of this series:
https://lore.kernel.org/rust-for-linux/20260603-use_tyr_reg_data-v1-1-97f64e951cf6@collabora.com/

Deborah

>  
>          let driver = TyrPlatformDriverData {
> -            _device: tdev.into(),
> +            _device: reg.device().into(),
> +            _reg: reg,
>          };
>  
>          // We need this to be dev_info!() because dev_dbg!() does not work at
> @@ -164,7 +167,7 @@ fn probe<'bound>(
>  }
>  
>  #[pinned_drop]
> -impl PinnedDrop for TyrPlatformDriverData {
> +impl PinnedDrop for TyrPlatformDriverData<'_> {
>      fn drop(self: Pin<&mut Self>) {}
>  }
>  
> @@ -181,6 +184,7 @@ fn drop(self: Pin<&mut Self>) {}
>  #[vtable]
>  impl drm::Driver for TyrDrmDriver {
>      type Data = TyrDrmDeviceData;
> +    type RegistrationData = ForLt!(());
>      type File = TyrDrmFileData;
>      type Object<R: drm::DeviceContext> = drm::gem::shmem::Object<BoData, R>;
>      type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index 828618ae19af..9e5e069b5135 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -23,6 +23,7 @@
>          AlwaysRefCounted, //
>      },
>      types::{
> +        ForLt,
>          NotThreadSafe,
>          Opaque, //
>      },
> @@ -35,6 +36,7 @@
>  };
>  use core::{
>      alloc::Layout,
> +    cell::UnsafeCell,
>      marker::PhantomData,
>      mem,
>      ops::Deref,
> @@ -259,6 +261,9 @@ pub fn new(
>          // SAFETY: `drm_dev` is still private to this function.
>          unsafe { (*drm_dev).driver = const { &Self::VTABLE } };
>  
> +        // SAFETY: `raw_drm` is valid; no concurrent access before registration.
> +        unsafe { (*raw_drm.as_ptr()).registration_data = UnsafeCell::new(NonNull::dangling()) };
> +
>          // SAFETY: The reference count is one, and now we take ownership of that reference as a
>          // `drm::Device`.
>          // INVARIANT: We just created the device above, but have yet to call `drm_dev_register`.
> @@ -290,6 +295,7 @@ pub fn new(
>  pub struct Device<T: drm::Driver, C: DeviceContext = Registered> {
>      dev: Opaque<bindings::drm_device>,
>      data: T::Data,
> +    pub(super) registration_data: UnsafeCell<NonNull<<T::RegistrationData as ForLt>::Of<'static>>>,
>      _ctx: PhantomData<C>,
>  }
>  
> @@ -298,6 +304,27 @@ pub(crate) fn as_raw(&self) -> *mut bindings::drm_device {
>          self.dev.get()
>      }
>  
> +    /// Returns a reference to the registration data with lifetime shortened from `'static`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that:
> +    ///
> +    /// - The parent bus device is bound (e.g. by holding an active `drm_dev_enter()` critical
> +    ///   section via [`UnbindGuard`]).
> +    /// - The returned reference is not exposed to code that can choose a concrete lifetime for
> +    ///   it, as that would be unsound for types that are invariant over their lifetime parameter
> +    ///   (e.g. it must be passed through an HRTB-bounded closure).
> +    unsafe fn registration_data_unchecked(&self) -> &<T::RegistrationData as ForLt>::Of<'_> {
> +        // SAFETY: Caller guarantees the parent bus device is bound, hence
> +        // the pointer is valid.
> +        let static_ref = unsafe { (*self.registration_data.get()).as_ref() };
> +
> +        // SAFETY: Caller guarantees the reference is only used behind an HRTB, making the
> +        // round-trip from `'static` sound regardless of variance.
> +        unsafe { T::RegistrationData::cast_ref_unchecked(static_ref) }
> +    }
> +
>      /// # Safety
>      ///
>      /// `ptr` must be a valid pointer to a `struct device` embedded in `Self`.
> @@ -412,6 +439,28 @@ pub struct UnbindGuard<'a, T: drm::Driver> {
>      idx: i32,
>  }
>  
> +impl<T: drm::Driver> UnbindGuard<'_, T> {
> +    /// Access the parent device and registration data through a closure, with both lifetimes
> +    /// tied to the closure scope.
> +    ///
> +    /// The data is owned by [`Registration`](drm::Registration) and is guaranteed to remain valid
> +    /// for the duration of this guard, since [`Registration`](drm::Registration)'s `drop` calls
> +    /// `drm_dev_unplug()` which waits for all `drm_dev_enter()` critical sections to complete.
> +    pub fn registration_data_with<R, F>(&self, f: F) -> R
> +    where
> +        F: for<'a> FnOnce(
> +            &'a T::ParentDevice<device::Bound>,
> +            &'a <T::RegistrationData as ForLt>::Of<'a>,
> +        ) -> R,
> +    {
> +        // SAFETY: We hold an active `drm_dev_enter()` critical section, so the parent bus
> +        // device is guaranteed to be bound. The closure's HRTB `for<'a>` prevents the caller
> +        // from smuggling in references with a concrete short lifetime, satisfying the lifetime
> +        // requirement of `registration_data_unchecked`.
> +        f(&**self, unsafe { self.dev.registration_data_unchecked() })
> +    }
> +}
> +
>  impl<T: drm::Driver> Deref for UnbindGuard<'_, T> {
>      type Target = T::ParentDevice<device::Bound>;
>  
> diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
> index f68a17d8939d..6aa1cb99cc7f 100644
> --- a/rust/kernel/drm/driver.rs
> +++ b/rust/kernel/drm/driver.rs
> @@ -7,11 +7,11 @@
>  use crate::{
>      bindings,
>      device,
> -    devres,
>      drm,
>      error::to_result,
>      prelude::*,
> -    sync::aref::ARef, //
> +    sync::aref::ARef,
> +    types::ForLt, //
>  };
>  use core::{
>      mem,
> @@ -110,6 +110,16 @@ pub trait Driver {
>      /// Context data associated with the DRM driver
>      type Data: Sync + Send;
>  
> +    /// Data owned by the [`Registration`] and accessible through [`drm::device::UnbindGuard`].
> +    ///
> +    /// This is a [`ForLt`](trait@ForLt) type whose lifetime is tied to the parent bus
> +    /// device binding scope.
> +    /// The data is only accessible while the parent bus device is bound (i.e. within a
> +    /// `drm_dev_enter/exit` critical section), and references handed out by
> +    /// [`UnbindGuard::registration_data_with()`](drm::device::UnbindGuard::registration_data_with)
> +    /// ties the lifetime to the closure scope.
> +    type RegistrationData: ForLt;
> +
>      /// The type used to manage memory for this driver.
>      type Object<Ctx: drm::DeviceContext>: AllocImpl;
>  
> @@ -139,12 +149,57 @@ pub trait Driver {
>  /// The registration type of a `drm::Device`.
>  ///
>  /// Once the `Registration` structure is dropped, the device is unregistered.
> -pub struct Registration<T: Driver>(ARef<drm::Device<T>>);
> +pub struct Registration<'a, T: Driver> {
> +    drm: ARef<drm::Device<T>>,
> +    _reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'a>>>,
> +}
> +
> +impl<'a, T: Driver> Registration<'a, T>
> +where
> +    for<'b> <T::RegistrationData as ForLt>::Of<'b>: Send,
> +{
> +    /// Register a new [`UnregisteredDevice`](drm::UnregisteredDevice) with userspace.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must not `mem::forget()` the returned [`Registration`] or otherwise prevent its
> +    /// [`Drop`] implementation from running, since the registration data may contain borrowed
> +    /// references that become invalid after `'a` ends.
> +    ///
> +    /// If the registration data is `'static`, use the safe [`Registration::new()`] instead.
> +    pub unsafe fn new_with_lt<E>(
> +        dev: &'a device::Device<device::Bound>,
> +        drm: drm::UnregisteredDevice<T>,
> +        reg_data: impl PinInit<<T::RegistrationData as ForLt>::Of<'a>, E>,
> +        flags: usize,
> +    ) -> Result<Self>
> +    where
> +        Error: From<E>,
> +    {
> +        if drm.as_ref().as_raw() != dev.as_raw() {
> +            return Err(EINVAL);
> +        }
>  
> -impl<T: Driver> Registration<T> {
> -    fn new(drm: drm::UnregisteredDevice<T>, flags: usize) -> Result<Self> {
> -        // SAFETY: `drm.as_raw()` is valid by the invariants of `drm::Device`.
> -        to_result(unsafe { bindings::drm_dev_register(drm.as_raw(), flags) })?;
> +        let reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'a>>> =
> +            KBox::pin_init(reg_data, GFP_KERNEL)?;
> +
> +        // Store the registration data pointer in the device before registration, so that it is
> +        // visible once ioctls can be called.
> +        //
> +        // SAFETY: Lifetimes do not affect layout, so the pointer cast is sound.
> +        let ptr: NonNull<<T::RegistrationData as ForLt>::Of<'static>> =
> +            unsafe { mem::transmute(NonNull::from(Pin::get_ref(reg_data.as_ref()))) };
> +
> +        // SAFETY: No concurrent access; the device is not yet registered.
> +        unsafe { *drm.registration_data.get() = ptr };
> +
> +        // SAFETY: `drm` is a valid, initialized but not yet registered DRM device.
> +        let ret = unsafe { bindings::drm_dev_register(drm.as_raw(), flags) };
> +        if let Err(e) = to_result(ret) {
> +            // SAFETY: No concurrent access; registration failed.
> +            unsafe { *drm.registration_data.get() = NonNull::dangling() };
> +            return Err(e);
> +        }
>  
>          // SAFETY: We just called `drm_dev_register` above
>          let new = NonNull::from(unsafe { drm.assume_ctx() });
> @@ -156,48 +211,49 @@ fn new(drm: drm::UnregisteredDevice<T>, flags: usize) -> Result<Self> {
>          // one reference to the device - which we take ownership over here.
>          let new = unsafe { ARef::from_raw(new) };
>  
> -        Ok(Self(new))
> +        Ok(Self {
> +            drm: new,
> +            _reg_data: reg_data,
> +        })
>      }
>  
> -    /// Registers a new [`UnregisteredDevice`](drm::UnregisteredDevice) with userspace.
> -    ///
> -    /// Ownership of the [`Registration`] object is passed to [`devres::register`].
> -    pub fn new_foreign_owned<'a>(
> -        drm: drm::UnregisteredDevice<T>,
> +    /// Safe variant of [`Registration::new_with_lt()`] for registration data that does not contain
> +    /// borrowed references.
> +    pub fn new<E>(
>          dev: &'a device::Device<device::Bound>,
> +        drm: drm::UnregisteredDevice<T>,
> +        reg_data: impl PinInit<<T::RegistrationData as ForLt>::Of<'a>, E>,
>          flags: usize,
> -    ) -> Result<&'a drm::Device<T>>
> +    ) -> Result<Self>
>      where
> -        T: 'static,
> +        <T::RegistrationData as ForLt>::Of<'a>: 'static,
> +        Error: From<E>,
>      {
> -        if drm.as_ref().as_raw() != dev.as_raw() {
> -            return Err(EINVAL);
> -        }
> -
> -        let reg = Registration::<T>::new(drm, flags)?;
> -        let drm = NonNull::from(reg.device());
> -
> -        devres::register(dev, reg, GFP_KERNEL)?;
> -
> -        // SAFETY: Since `reg` was passed to devres::register(), the device now owns the lifetime
> -        // of the DRM registration - ensuring that this references lives for at least as long as 'a.
> -        Ok(unsafe { drm.as_ref() })
> +        // SAFETY: `Of<'a>: 'static` guarantees the data contains no borrowed references,
> +        // so forgetting the `Registration` cannot cause use-after-free.
> +        unsafe { Self::new_with_lt(dev, drm, reg_data, flags) }
>      }
>  
>      /// Returns a reference to the `Device` instance for this registration.
>      pub fn device(&self) -> &drm::Device<T> {
> -        &self.0
> +        &self.drm
>      }
>  }
>  
>  // SAFETY: `Registration` doesn't offer any methods or access to fields when shared between
>  // threads, hence it's safe to share it.
> -unsafe impl<T: Driver> Sync for Registration<T> {}
> +unsafe impl<T: Driver> Sync for Registration<'_, T> where
> +    for<'a> <T::RegistrationData as ForLt>::Of<'a>: Send
> +{
> +}
>  
>  // SAFETY: Registration with and unregistration from the DRM subsystem can happen from any thread.
> -unsafe impl<T: Driver> Send for Registration<T> {}
> +unsafe impl<T: Driver> Send for Registration<'_, T> where
> +    for<'a> <T::RegistrationData as ForLt>::Of<'a>: Send
> +{
> +}
>  
> -impl<T: Driver> Drop for Registration<T> {
> +impl<T: Driver> Drop for Registration<'_, T> {
>      fn drop(&mut self) {
>          // Use `drm_dev_unplug` rather than `drm_dev_unregister` to ensure that existing
>          // `drm_dev_enter()` critical sections complete before unregistration proceeds. This
> @@ -207,6 +263,9 @@ fn drop(&mut self) {
>          //
>          // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The existence of this
>          // `Registration` also guarantees that this `drm::Device` is actually registered.
> -        unsafe { bindings::drm_dev_unplug(self.0.as_raw()) };
> +        unsafe { bindings::drm_dev_unplug(self.drm.as_raw()) };
> +        // After drm_dev_unplug(), the SRCU barrier guarantees that all UnbindGuard critical
> +        // sections have completed, so no one holds a reference to reg_data anymore.
> +        // reg_data is dropped here automatically.
>      }
>  }
> diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
> index a66e7166f66b..59870bb09de2 100644
> --- a/rust/kernel/drm/mod.rs
> +++ b/rust/kernel/drm/mod.rs
> @@ -12,6 +12,7 @@
>  pub use self::device::Device;
>  pub use self::device::DeviceContext;
>  pub use self::device::Registered;
> +pub use self::device::UnbindGuard;
>  pub use self::device::Uninit;
>  pub use self::device::UnregisteredDevice;
>  pub use self::driver::Driver;
> -- 
> 2.54.0
> 
