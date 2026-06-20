Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822BECD98FA
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 00:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC9F810E154;
	Sat, 20 Jun 2026 00:59:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EiorQNAq";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F1210E153
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 00:59:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DFA86442A4;
 Sat, 20 Jun 2026 00:59:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8AA91F000E9;
 Sat, 20 Jun 2026 00:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781917185;
 bh=+1s6PThYlLAPctMKtY0HENdy48lIUKzYJ3WkwVZMSlw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=EiorQNAqqnvKjL5Dt7fWRlwFNAsZftCc0Ekkwhp1QzOBHjvlTlneb4wvbZZoNEh6M
 jhDHPAZaMauVeIjXIKBpBDADeM2RSTndREEQMe4iOG0V/Ay7ailuN1qYTU0zspKjhJ
 hCdv4PzCXvlJyiIIJkMAqRegoTP6+5cJS04I0QymVliNUHteE0R3jiTd1EgXYZJcbI
 JfDhwNc6+fhuU0YNiMQG6/0UcPDaUEAc5ysWx00qaE1HDHXM67buG/sfHkLma9h/UV
 pfvSJeiZzTUTDpJQOF+61NTipfX0gkESqQT6OTW+9JZ+ZClrEZlSVrCcpzz/tzK7yj
 chBJlIVbrtTpg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 acourbot@nvidia.com, ecourtney@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 deborah.brouwer@collabora.com, boris.brezillon@collabora.com,
 lyude@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v3 10/13] rust: drm: Add RegistrationData to drm::Driver
Date: Sat, 20 Jun 2026 02:51:22 +0200
Message-ID: <20260620005431.1562115-11-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620005431.1562115-1-dakr@kernel.org>
References: <20260620005431.1562115-1-dakr@kernel.org>
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
Registration<'a, T> takes ownership of the data via Pin<KBox<_>>,
storing it with its real lifetime. The pointer is written to drm::Device
before drm_dev_register() to ensure it is already in place when ioctls
arrive.

Device<T, Registered>::registration_data_with() provides access with the
lifetime shortened from 'static via a pointer cast. Since
Registration::drop() calls drm_dev_unplug(), which performs an SRCU
barrier waiting for all drm_dev_enter() critical sections to complete,
the data is guaranteed to remain valid for the duration of any
RegistrationGuard.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs |  20 ++++--
 drivers/gpu/drm/tyr/driver.rs  |  18 +++--
 rust/kernel/drm/device.rs      |  49 ++++++++++++++
 rust/kernel/drm/driver.rs      | 116 ++++++++++++++++++++++-----------
 4 files changed, 153 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index e3c54303d70e..131212df94d3 100644
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
@@ -20,9 +21,10 @@
 
 pub(crate) struct NovaDriver;
 
-pub(crate) struct Nova {
+pub(crate) struct Nova<'bound> {
     #[expect(unused)]
     drm: ARef<drm::Device<NovaDriver>>,
+    _reg: drm::Registration<'bound, NovaDriver>,
 }
 
 /// Convienence type alias for the DRM device type for this driver
@@ -56,7 +58,7 @@ pub(crate) struct NovaData {
 
 impl auxiliary::Driver for NovaDriver {
     type IdInfo = ();
-    type Data<'bound> = Nova;
+    type Data<'bound> = Nova<'bound>;
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
     fn probe<'bound>(
@@ -66,15 +68,21 @@ fn probe<'bound>(
         let data = try_pin_init!(NovaData { adev: adev.into() });
 
         let drm = drm::UnregisteredDevice::<Self>::new(adev, data)?;
-        let drm = drm::Registration::new_foreign_owned(drm, adev.as_ref(), 0)?;
-
-        Ok(Nova { drm: drm.into() })
+        // SAFETY: `reg` is stored in `Nova` and dropped when the driver is unbound; it is
+        // never forgotten.
+        let reg = unsafe { drm::Registration::new(adev.as_ref(), drm, (), 0)? };
+
+        Ok(Nova {
+            drm: reg.device().into(),
+            _reg: reg,
+        })
     }
 }
 
 #[vtable]
 impl drm::Driver for NovaDriver {
     type Data = NovaData;
+    type RegistrationData = ForLt!(());
     type File = File;
     type Object = gem::Object<NovaObject>;
     type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 7f082de6d6dc..e017448aabab 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -31,7 +31,8 @@
         aref::ARef,
         Mutex, //
     },
-    time, //
+    time,
+    types::ForLt, //
 };
 
 use crate::{
@@ -52,8 +53,9 @@
 pub(crate) struct TyrPlatformDriver;
 
 #[pin_data(PinnedDrop)]
-pub(crate) struct TyrPlatformDriverData {
+pub(crate) struct TyrPlatformDriverData<'bound> {
     _device: ARef<TyrDrmDevice>,
+    _reg: drm::Registration<'bound, TyrDrmDriver>,
 }
 
 #[pin_data]
@@ -98,7 +100,7 @@ fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
 
 impl platform::Driver for TyrPlatformDriver {
     type IdInfo = ();
-    type Data<'bound> = TyrPlatformDriverData;
+    type Data<'bound> = TyrPlatformDriverData<'bound>;
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
     fn probe<'bound>(
@@ -150,10 +152,13 @@ fn probe<'bound>(
         });
 
         let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
-        let tdev = drm::driver::Registration::new_foreign_owned(tdev, pdev.as_ref(), 0)?;
+        // SAFETY: `reg` is stored in `TyrPlatformDriverData` and dropped when the driver is
+        // unbound; it is never forgotten.
+        let reg = unsafe { drm::Registration::new(pdev.as_ref(), tdev, (), 0)? };
 
         let driver = TyrPlatformDriverData {
-            _device: tdev.into(),
+            _device: reg.device().into(),
+            _reg: reg,
         };
 
         // We need this to be dev_info!() because dev_dbg!() does not work at
@@ -164,7 +169,7 @@ fn probe<'bound>(
 }
 
 #[pinned_drop]
-impl PinnedDrop for TyrPlatformDriverData {
+impl PinnedDrop for TyrPlatformDriverData<'_> {
     fn drop(self: Pin<&mut Self>) {}
 }
 
@@ -181,6 +186,7 @@ fn drop(self: Pin<&mut Self>) {}
 #[vtable]
 impl drm::Driver for TyrDrmDriver {
     type Data = TyrDrmDeviceData;
+    type RegistrationData = ForLt!(());
     type File = TyrDrmFileData;
     type Object = drm::gem::shmem::Object<BoData>;
     type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index bc8cfd753596..0a2ee308b1b2 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -20,6 +20,7 @@
         AlwaysRefCounted, //
     },
     types::{
+        ForLt,
         NotThreadSafe,
         Opaque, //
     },
@@ -32,6 +33,7 @@
 };
 use core::{
     alloc::Layout,
+    cell::UnsafeCell,
     marker::PhantomData,
     mem,
     ops::Deref,
@@ -230,6 +232,9 @@ pub fn new(
         // SAFETY: `drm_dev` is still private to this function.
         unsafe { (*drm_dev).driver = const { &Self::VTABLE } };
 
+        // SAFETY: `raw_drm` is valid; no concurrent access before registration.
+        unsafe { (*raw_drm.as_ptr()).registration_data = UnsafeCell::new(NonNull::dangling()) };
+
         // SAFETY: The reference count is one, and now we take ownership of that reference as a
         // `drm::Device`.
         // INVARIANT: We just created the device above, but have yet to call `drm_dev_register`.
@@ -253,6 +258,7 @@ pub fn new(
 pub struct Device<T: drm::Driver, C: DeviceContext = Normal> {
     dev: Opaque<bindings::drm_device>,
     data: T::Data,
+    pub(super) registration_data: UnsafeCell<NonNull<<T::RegistrationData as ForLt>::Of<'static>>>,
     _ctx: PhantomData<C>,
 }
 
@@ -261,6 +267,28 @@ pub(crate) fn as_raw(&self) -> *mut bindings::drm_device {
         self.dev.get()
     }
 
+    /// Returns a reference to the registration data with lifetime shortened from `'static`.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that:
+    ///
+    /// - The parent bus device is bound (e.g. by holding an active `drm_dev_enter()` critical
+    ///   section via [`RegistrationGuard`]).
+    /// - The returned reference is not exposed to code that can choose a concrete lifetime for
+    ///   it, as that would be unsound for types that are invariant over their lifetime parameter
+    ///   (e.g. it must be passed through an HRTB-bounded closure).
+    #[inline]
+    unsafe fn registration_data_unchecked(&self) -> &<T::RegistrationData as ForLt>::Of<'_> {
+        // SAFETY:
+        // - Caller guarantees the parent bus device is bound, hence the pointer is valid.
+        // - The pointer cast from `Of<'static>` to `Of<'_>` is layout-compatible since lifetimes
+        //   are erased at runtime.
+        // - Caller guarantees the reference is only used behind an HRTB, making the lifetime
+        //   shortening sound regardless of variance.
+        unsafe { (*self.registration_data.get()).cast::<_>().as_ref() }
+    }
+
     /// # Safety
     ///
     /// `ptr` must be a valid pointer to a `struct device` embedded in `Self`.
@@ -357,6 +385,27 @@ pub struct RegistrationGuard<'a, T: drm::Driver> {
     idx: i32,
 }
 
+impl<T: drm::Driver> Device<T, Registered> {
+    /// Access the registration data through a closure, with the lifetime tied to the closure
+    /// scope.
+    ///
+    /// The data is owned by [`Registration`](drm::Registration) and is guaranteed to remain valid
+    /// as long as the device is registered, since [`Registration`](drm::Registration)'s `drop`
+    /// calls `drm_dev_unplug()` which waits for all `drm_dev_enter()` critical sections to
+    /// complete.
+    #[inline]
+    pub fn registration_data_with<R, F>(&self, f: F) -> R
+    where
+        F: for<'a> FnOnce(&'a <T::RegistrationData as ForLt>::Of<'a>) -> R,
+    {
+        // SAFETY: `Registered` guarantees the device is registered and the parent bus device is
+        // bound. The closure's HRTB `for<'a>` prevents the caller from smuggling in references
+        // with a concrete short lifetime, satisfying the lifetime requirement of
+        // `registration_data_unchecked`.
+        f(unsafe { self.registration_data_unchecked() })
+    }
+}
+
 impl<T: drm::Driver> Deref for RegistrationGuard<'_, T> {
     type Target = Device<T, Registered>;
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index ceb2829985c7..987d116e3501 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -7,11 +7,11 @@
 use crate::{
     bindings,
     device,
-    devres,
     drm,
     error::to_result,
     prelude::*,
-    sync::aref::ARef, //
+    sync::aref::ARef,
+    types::ForLt, //
 };
 use core::{
     mem,
@@ -110,6 +110,16 @@ pub trait Driver {
     /// Context data associated with the DRM driver
     type Data: Sync + Send;
 
+    /// Data owned by the [`Registration`] and accessible within a
+    /// [`RegistrationGuard`](drm::RegistrationGuard) critical section via
+    /// [`Device::registration_data_with()`](drm::Device::registration_data_with).
+    ///
+    /// This is a [`ForLt`](trait@ForLt) type whose lifetime is tied to the parent bus
+    /// device binding scope. References handed out by
+    /// [`Device::registration_data_with()`](drm::Device::registration_data_with) are tied to
+    /// the closure scope.
+    type RegistrationData: ForLt;
+
     /// The type used to manage memory for this driver.
     type Object: AllocImpl;
 
@@ -139,65 +149,92 @@ pub trait Driver {
 /// The registration type of a `drm::Device`.
 ///
 /// Once the `Registration` structure is dropped, the device is unregistered.
-pub struct Registration<T: Driver>(ARef<drm::Device<T>>);
-
-impl<T: Driver> Registration<T> {
-    fn new(drm: drm::UnregisteredDevice<T>, flags: usize) -> Result<Self> {
-        // SAFETY: `drm.as_raw()` is valid by the invariants of `drm::Device`.
-        to_result(unsafe { bindings::drm_dev_register(drm.as_raw(), flags) })?;
-
-        // SAFETY: We just called `drm_dev_register` above
-        let new = NonNull::from(unsafe { drm.assume_ctx() });
-
-        // Leak the ARef from UnregisteredDevice in preparation for transferring its ownership.
-        mem::forget(drm);
-
-        // SAFETY: `drm`'s `Drop` constructor was never called, ensuring that there remains at least
-        // one reference to the device - which we take ownership over here.
-        let new = unsafe { ARef::from_raw(new) };
-
-        Ok(Self(new))
-    }
+pub struct Registration<'a, T: Driver> {
+    drm: ARef<drm::Device<T>>,
+    _reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'a>>>,
+}
 
-    /// Registers a new [`UnregisteredDevice`](drm::UnregisteredDevice) with userspace.
+impl<'a, T: Driver> Registration<'a, T>
+where
+    for<'b> <T::RegistrationData as ForLt>::Of<'b>: Send,
+{
+    /// Register a new [`UnregisteredDevice`](drm::UnregisteredDevice) with userspace.
     ///
-    /// Ownership of the [`Registration`] object is passed to [`devres::register`].
-    pub fn new_foreign_owned<'a>(
-        drm: drm::UnregisteredDevice<T>,
+    /// # Safety
+    ///
+    /// The caller must not `mem::forget()` the returned [`Registration`] or otherwise prevent its
+    /// [`Drop`] implementation from running, since the registration data may contain borrowed
+    /// references that become invalid after `'a` ends.
+    pub unsafe fn new<E>(
         dev: &'a device::Device<device::Bound>,
+        drm: drm::UnregisteredDevice<T>,
+        reg_data: impl PinInit<<T::RegistrationData as ForLt>::Of<'a>, E>,
         flags: usize,
-    ) -> Result<&'a drm::Device<T>>
+    ) -> Result<Self>
     where
-        T: 'static,
+        Error: From<E>,
     {
         if drm.as_ref().as_ref().as_raw() != dev.as_raw() {
             return Err(EINVAL);
         }
 
-        let reg = Registration::<T>::new(drm, flags)?;
-        let drm = NonNull::from(reg.device());
+        let reg_data: Pin<KBox<<T::RegistrationData as ForLt>::Of<'a>>> =
+            KBox::pin_init(reg_data, GFP_KERNEL)?;
+
+        // Store the registration data pointer in the device before registration, so that it is
+        // visible once ioctls can be called.
+        //
+        // SAFETY: Lifetimes do not affect layout, so the pointer cast is sound.
+        let ptr: NonNull<<T::RegistrationData as ForLt>::Of<'static>> =
+            unsafe { mem::transmute(NonNull::from(Pin::get_ref(reg_data.as_ref()))) };
+
+        // SAFETY: No concurrent access; the device is not yet registered.
+        unsafe { *drm.registration_data.get() = ptr };
+
+        // SAFETY: `drm` is a valid, initialized but not yet registered DRM device.
+        let ret = unsafe { bindings::drm_dev_register(drm.as_raw(), flags) };
+        if let Err(e) = to_result(ret) {
+            // SAFETY: No concurrent access; registration failed.
+            unsafe { *drm.registration_data.get() = NonNull::dangling() };
+            return Err(e);
+        }
+
+        // SAFETY: We just called `drm_dev_register` above
+        let new = NonNull::from(unsafe { drm.assume_ctx() });
+
+        // Leak the ARef from UnregisteredDevice in preparation for transferring its ownership.
+        mem::forget(drm);
 
-        devres::register(dev, reg, GFP_KERNEL)?;
+        // SAFETY: `drm`'s `Drop` constructor was never called, ensuring that there remains at least
+        // one reference to the device - which we take ownership over here.
+        let new = unsafe { ARef::from_raw(new) };
 
-        // SAFETY: Since `reg` was passed to devres::register(), the device now owns the lifetime
-        // of the DRM registration - ensuring that this references lives for at least as long as 'a.
-        Ok(unsafe { drm.as_ref() })
+        Ok(Self {
+            drm: new,
+            _reg_data: reg_data,
+        })
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
+unsafe impl<T: Driver> Sync for Registration<'_, T> where
+    for<'a> <T::RegistrationData as ForLt>::Of<'a>: Send
+{
+}
 
 // SAFETY: Registration with and unregistration from the DRM subsystem can happen from any thread.
-unsafe impl<T: Driver> Send for Registration<T> {}
+unsafe impl<T: Driver> Send for Registration<'_, T> where
+    for<'a> <T::RegistrationData as ForLt>::Of<'a>: Send
+{
+}
 
-impl<T: Driver> Drop for Registration<T> {
+impl<T: Driver> Drop for Registration<'_, T> {
     fn drop(&mut self) {
         // Use `drm_dev_unplug` rather than `drm_dev_unregister` to ensure that existing
         // `drm_dev_enter()` critical sections complete before unregistration proceeds. This
@@ -207,6 +244,9 @@ fn drop(&mut self) {
         //
         // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The existence of this
         // `Registration` also guarantees that this `drm::Device` is actually registered.
-        unsafe { bindings::drm_dev_unplug(self.0.as_raw()) };
+        unsafe { bindings::drm_dev_unplug(self.drm.as_raw()) };
+        // After drm_dev_unplug(), the SRCU barrier guarantees that all RegistrationGuard critical
+        // sections have completed, so no one holds a reference to reg_data anymore.
+        // reg_data is dropped here automatically.
     }
 }
-- 
2.54.0

