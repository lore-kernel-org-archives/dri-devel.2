Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BE0CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 22:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A755610EEDF;
	Wed,  6 May 2026 22:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EH9Ox6+P";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7D3510EEE1
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 22:10:52 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F6B161141;
 Wed,  6 May 2026 22:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8701C2BCB0;
 Wed,  6 May 2026 22:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778105452;
 bh=23fi8AzSa5LgBrTmJFnzH5IJw9u3nJt2QbZBLA69eG4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EH9Ox6+PkcLRQKLNMQVrsAkea9Y5Xz/W4FgqttWlmhedId5n0qJeAjNK1WhjiblE/
 mhpRP3tpyjUgGJVjel6gYKxtdy0I0Xu2qcJYamu7EVTf7uchkr56KLakZGvymiuAun
 koLhE6qGW6rPzg7a736HuiagJelLDwNOmVfUXZpfh9StiIoo6fi+a/4p0zPchjOgfe
 s2/hU6pG6wCBuoEZq69s6y31MxW2K5h8V0dMk3vG3EXSNBoGoRPTXtry0RpjuCT3Ms
 IgRXcVMuFj/RT1s41KUpPpvzILYCktRlWMwwzTbIfsW9bN9I/kPY75SFonvahYEC6i
 KaufuvXNvj/lA==
From: Danilo Krummrich <dakr@kernel.org>
To: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 daniel.almeida@collabora.com, acourbot@nvidia.com, apopple@nvidia.com,
 ecourtney@nvidia.com, deborah.brouwer@collabora.com, lyude@redhat.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Cc: driver-core@lists.linux.dev, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 3/6] rust: drm: Add RegistrationData to drm::Driver
Date: Thu,  7 May 2026 00:06:01 +0200
Message-ID: <20260506221027.858481-4-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506221027.858481-1-dakr@kernel.org>
References: <20260506221027.858481-1-dakr@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add a RegistrationData associated type to drm::Driver. This is a ForLt
type whose lifetime is tied to the parent bus device binding scope.

Registration<T> takes ownership of the data via Pin<KBox<_>>, erasing
the lifetime to 'static for storage. The pointer is written to
drm::Device before drm_dev_register() to ensure it is already in place
when ioctls arrive.

UnbindGuard::registration_data() provides access with the lifetime
shortened from 'static via ForLt::cast_ref. Since Registration::drop()
calls drm_dev_unplug() -- which performs an SRCU barrier waiting for all
drm_dev_enter() critical sections to complete -- the data is guaranteed
to remain valid for the duration of any UnbindGuard.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs |  6 ++-
 drivers/gpu/drm/tyr/driver.rs  |  6 ++-
 rust/kernel/drm/device.rs      | 40 +++++++++++++++
 rust/kernel/drm/driver.rs      | 89 +++++++++++++++++++++++++++-------
 rust/kernel/drm/mod.rs         |  1 +
 5 files changed, 121 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 9d4100f01ea7..54a3391371ba 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -12,7 +12,8 @@
         ioctl, //
     },
     prelude::*,
-    sync::aref::ARef, //
+    sync::aref::ARef,
+    types::ForLt, //
 };
 
 use crate::file::File;
@@ -63,7 +64,7 @@ fn probe(
         let data = try_pin_init!(NovaData { adev: adev.into() });
 
         let drm = drm::UnregisteredDevice::<Self>::new(adev, data)?;
-        let drm = drm::Registration::new_foreign_owned(drm, adev.as_ref(), 0)?;
+        let drm = drm::Registration::new_foreign_owned(drm, adev.as_ref(), (), 0)?;
 
         Ok(Self { drm: drm.into() })
     }
@@ -72,6 +73,7 @@ fn probe(
 #[vtable]
 impl drm::Driver for NovaDriver {
     type Data = NovaData;
+    type RegistrationData = ForLt!(());
     type File = File;
     type Object<Ctx: drm::DeviceContext> = gem::Object<NovaObject, Ctx>;
     type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 747745d23f31..7ac3707823b6 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -25,7 +25,8 @@
         aref::ARef,
         Mutex, //
     },
-    time, //
+    time,
+    types::ForLt, //
 };
 
 use crate::{
@@ -133,7 +134,7 @@ fn probe(
         });
 
         let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
-        let tdev = drm::driver::Registration::new_foreign_owned(tdev, pdev.as_ref(), 0)?;
+        let tdev = drm::driver::Registration::new_foreign_owned(tdev, pdev.as_ref(), (), 0)?;
 
         let driver = TyrPlatformDriverData {
             _device: tdev.into(),
@@ -175,6 +176,7 @@ fn drop(self: Pin<&mut Self>) {
 #[vtable]
 impl drm::Driver for TyrDrmDriver {
     type Data = TyrDrmDeviceData;
+    type RegistrationData = ForLt!(());
     type File = TyrDrmFileData;
     type Object<R: drm::DeviceContext> = drm::gem::Object<TyrObject, R>;
     type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index bb685165032d..11edbe6f9f42 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -23,6 +23,7 @@
         AlwaysRefCounted, //
     },
     types::{
+        ForLt,
         NotThreadSafe,
         Opaque, //
     },
@@ -35,6 +36,7 @@
 };
 use core::{
     alloc::Layout,
+    cell::UnsafeCell,
     marker::PhantomData,
     mem,
     ops::Deref,
@@ -239,6 +241,9 @@ pub fn new(
             unsafe { bindings::drm_dev_put(drm_dev) };
         })?;
 
+        // SAFETY: `raw_drm` is valid; no concurrent access before registration.
+        unsafe { (*raw_drm.as_ptr()).registration_data = UnsafeCell::new(NonNull::dangling()) };
+
         // SAFETY: The reference count is one, and now we take ownership of that reference as a
         // `drm::Device`.
         // INVARIANT: We just created the device above, but have yet to call `drm_dev_register`.
@@ -270,6 +275,7 @@ pub fn new(
 pub struct Device<T: drm::Driver, C: DeviceContext = Registered> {
     dev: Opaque<bindings::drm_device>,
     data: T::Data,
+    pub(super) registration_data: UnsafeCell<NonNull<<T::RegistrationData as ForLt>::Of<'static>>>,
     _ctx: PhantomData<C>,
 }
 
@@ -278,6 +284,23 @@ pub(crate) fn as_raw(&self) -> *mut bindings::drm_device {
         self.dev.get()
     }
 
+    /// Returns a reference to the registration data with lifetime shortened
+    /// from `'static`.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure the parent bus device is bound. This is
+    /// typically guaranteed by holding an active `drm_dev_enter()` critical
+    /// section (e.g. via [`UnbindGuard`]).
+    #[doc(hidden)]
+    pub unsafe fn raw_registration_data(&self) -> &<T::RegistrationData as ForLt>::Of<'_> {
+        // SAFETY: Caller guarantees the parent bus device is bound, hence
+        // the pointer is valid.
+        let static_ref = unsafe { (*self.registration_data.get()).as_ref() };
+
+        T::RegistrationData::cast_ref(static_ref)
+    }
+
     /// # Safety
     ///
     /// `ptr` must be a valid pointer to a `struct device` embedded in `Self`.
@@ -391,6 +414,23 @@ pub struct UnbindGuard<'a, T: drm::Driver> {
     idx: i32,
 }
 
+impl<T: drm::Driver> UnbindGuard<'_, T> {
+    /// Returns a reference to the registration data with its lifetime shortened from `'static`
+    /// to the guard's borrow lifetime.
+    ///
+    /// The data is owned by [`Registration`](drm::driver::Registration) and is guaranteed to
+    /// remain valid for the duration of this guard, since
+    /// [`Registration`](drm::driver::Registration)'s `drop` calls
+    /// `drm_dev_unplug()` which waits for all `drm_dev_enter()` critical sections to complete.
+    pub fn registration_data(&self) -> &<T::RegistrationData as ForLt>::Of<'_> {
+        // SAFETY: The pointer was set in `Registration::new()` before `drm_dev_register()`, and
+        // is only invalidated after `drm_dev_unplug()` in `Registration::drop()`. Since we hold
+        // an active `drm_dev_enter()` critical section, the SRCU barrier in `drm_dev_unplug()`
+        // guarantees the pointer is still valid.
+        unsafe { self.dev.raw_registration_data() }
+    }
+}
+
 impl<T: drm::Driver> Deref for UnbindGuard<'_, T> {
     type Target = T::ParentDevice<device::Bound>;
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 751a68bb27e1..3a49ef324ada 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -11,7 +11,8 @@
     drm,
     error::to_result,
     prelude::*,
-    sync::aref::ARef, //
+    sync::aref::ARef,
+    types::ForLt, //
 };
 use core::{
     mem,
@@ -108,6 +109,16 @@ pub trait Driver {
     /// Context data associated with the DRM driver
     type Data: Sync + Send;
 
+    /// Data owned by the [`Registration`] and accessible through [`drm::device::UnbindGuard`].
+    ///
+    /// This is a [`ForLt`](trait@ForLt) type whose lifetime is tied to the parent bus
+    /// device binding scope.
+    /// The data is only accessible while the parent bus device is bound (i.e. within a
+    /// `drm_dev_enter/exit` critical section), and references handed out by
+    /// [`UnbindGuard::registration_data()`](drm::device::UnbindGuard::registration_data) have
+    /// their lifetime shortened accordingly via [`ForLt::cast_ref`].
+    type RegistrationData: ForLt;
+
     /// The type used to manage memory for this driver.
     type Object<Ctx: drm::DeviceContext>: AllocImpl;
 
@@ -127,12 +138,44 @@ pub trait Driver {
 /// The registration type of a `drm::Device`.
 ///
 /// Once the `Registration` structure is dropped, the device is unregistered.
-pub struct Registration<T: Driver>(ARef<drm::Device<T>>);
+pub struct Registration<T: Driver> {
+    drm: ARef<drm::Device<T>>,
+    #[allow(dead_code)]
+    reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'static>>>,
+}
 
-impl<T: Driver> Registration<T> {
-    fn new(drm: drm::UnregisteredDevice<T>, flags: usize) -> Result<Self> {
-        // SAFETY: `drm.as_raw()` is valid by the invariants of `drm::Device`.
-        to_result(unsafe { bindings::drm_dev_register(drm.as_raw(), flags) })?;
+impl<T: Driver> Registration<T>
+where
+    for<'a> <T::RegistrationData as ForLt>::Of<'a>: Send,
+{
+    fn new<'bound, E>(
+        drm: drm::UnregisteredDevice<T>,
+        reg_data: impl PinInit<<T::RegistrationData as ForLt>::Of<'bound>, E>,
+        flags: usize,
+    ) -> Result<Self>
+    where
+        Error: From<E>,
+    {
+        let reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'bound>>> =
+            KBox::pin_init(reg_data, GFP_KERNEL)?;
+
+        // SAFETY: `ForLt` guarantees covariance; lifetimes do not affect layout.
+        let reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'static>>> =
+            unsafe { mem::transmute(reg_data) };
+
+        // Store the registration data pointer in the device before registration, so that it is
+        // visible once ioctls can be called.
+        //
+        // SAFETY: No concurrent access; the device is not yet registered.
+        unsafe { *drm.registration_data.get() = NonNull::from(Pin::get_ref(reg_data.as_ref())) }
+
+        // SAFETY: `drm` is a valid, initialized but not yet registered DRM device.
+        let ret = unsafe { bindings::drm_dev_register(drm.as_raw(), flags) };
+        if let Err(e) = to_result(ret) {
+            // SAFETY: No concurrent access; registration failed.
+            unsafe { *drm.registration_data.get() = NonNull::dangling() };
+            return Err(e);
+        }
 
         // SAFETY: We just called `drm_dev_register` above
         let new = NonNull::from(unsafe { drm.assume_ctx() });
@@ -144,46 +187,55 @@ fn new(drm: drm::UnregisteredDevice<T>, flags: usize) -> Result<Self> {
         // one reference to the device - which we take ownership over here.
         let new = unsafe { ARef::from_raw(new) };
 
-        Ok(Self(new))
+        Ok(Self { drm: new, reg_data })
     }
 
     /// Registers a new [`UnregisteredDevice`](drm::UnregisteredDevice) with userspace.
     ///
     /// Ownership of the [`Registration`] object is passed to [`devres::register`].
-    pub fn new_foreign_owned<'a>(
+    pub fn new_foreign_owned<'bound, E>(
         drm: drm::UnregisteredDevice<T>,
-        dev: &'a device::Device<device::Bound>,
+        dev: &'bound device::Device<device::Bound>,
+        reg_data: impl PinInit<<T::RegistrationData as ForLt>::Of<'bound>, E>,
         flags: usize,
-    ) -> Result<&'a drm::Device<T>>
+    ) -> Result<&'bound drm::Device<T>>
     where
         T: 'static,
+        Error: From<E>,
     {
         if drm.as_ref().as_raw() != dev.as_raw() {
             return Err(EINVAL);
         }
 
-        let reg = Registration::<T>::new(drm, flags)?;
+        let reg = Registration::<T>::new(drm, reg_data, flags)?;
         let drm = NonNull::from(reg.device());
 
-        devres::register(dev, reg, GFP_KERNEL)?;
+        devres::register::<_, core::convert::Infallible>(dev, reg, GFP_KERNEL)?;
 
         // SAFETY: Since `reg` was passed to devres::register(), the device now owns the lifetime
-        // of the DRM registration - ensuring that this references lives for at least as long as 'a.
+        // of the DRM registration - ensuring that this reference lives for
+        // at least as long as 'bound.
         Ok(unsafe { drm.as_ref() })
     }
 
     /// Returns a reference to the `Device` instance for this registration.
     pub fn device(&self) -> &drm::Device<T> {
-        &self.0
+        &self.drm
     }
 }
 
 // SAFETY: `Registration` doesn't offer any methods or access to fields when shared between
 // threads, hence it's safe to share it.
-unsafe impl<T: Driver> Sync for Registration<T> {}
+unsafe impl<T: Driver> Sync for Registration<T> where
+    for<'a> <T::RegistrationData as ForLt>::Of<'a>: Send
+{
+}
 
 // SAFETY: Registration with and unregistration from the DRM subsystem can happen from any thread.
-unsafe impl<T: Driver> Send for Registration<T> {}
+unsafe impl<T: Driver> Send for Registration<T> where
+    for<'a> <T::RegistrationData as ForLt>::Of<'a>: Send
+{
+}
 
 impl<T: Driver> Drop for Registration<T> {
     fn drop(&mut self) {
@@ -195,6 +247,9 @@ fn drop(&mut self) {
         //
         // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The existence of this
         // `Registration` also guarantees that this `drm::Device` is actually registered.
-        unsafe { bindings::drm_dev_unplug(self.0.as_raw()) };
+        unsafe { bindings::drm_dev_unplug(self.drm.as_raw()) };
+        // After drm_dev_unplug(), the SRCU barrier guarantees that all UnbindGuard critical
+        // sections have completed, so no one holds a reference to reg_data anymore.
+        // reg_data is dropped here automatically.
     }
 }
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index 64a43cb0fe57..6c0ba9c82b92 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -11,6 +11,7 @@
 pub use self::device::Device;
 pub use self::device::DeviceContext;
 pub use self::device::Registered;
+pub use self::device::UnbindGuard;
 pub use self::device::Uninit;
 pub use self::device::UnregisteredDevice;
 pub use self::driver::Driver;
-- 
2.54.0

