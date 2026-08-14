Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF5DC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D75C10E5B4;
	Fri, 14 Aug 2026 23:10:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f4hytynj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4822E10E5B4
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:10:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2EFD74406C;
 Fri, 14 Aug 2026 23:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4CC1F00A3A;
 Fri, 14 Aug 2026 23:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786749000;
 bh=LaItPQ0o3O7N1/dhhAb06mIPwLY4EhUW6EmJGpPxoGI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f4hytynjujccUOXQEWikO3gIAV4GGTHvmrWLN20+O+lbdbee9IzJWrJS26kfm7bp8
 i1f7qrlXU74MwHqkzGvT+lyVqAnV35eAk+qxvIvIB7zQ8IPeVWVZmTje8rwLLU+0OD
 ObymO299jien3EX+uy+oDoG6hDQFwAUix/Np80yAcNLJpt8XQf3n8BrbxY1rgikx5b
 O5Cv8kUN0JuHDj585QMbztNTAXTTXShFAiBcAW6Iv6hQ1xCD6rDrl9udg88cmKrqOU
 tZfbSr1Lob4x6+bgbsr/4H4pL3w0g0olML7T8aO5vQWMGRecWoPsb9JoDLuT/xXw6K
 ovwUIEUt0A3sA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 work@onurozkan.dev, brauner@kernel.org, lyude@redhat.com, j@jananu.net,
 alvin.sun@linux.dev, deborah.brouwer@collabora.com,
 laura.nao@collabora.com, beata.michalska@arm.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] rust: drm: make Driver::File lifetime-parameterized
Date: Sat, 15 Aug 2026 01:09:04 +0200
Message-ID: <20260814230923.1292966-7-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814230923.1292966-1-dakr@kernel.org>
References: <20260814230923.1292966-1-dakr@kernel.org>
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

Make the DRM file private data lifetime-parameterized, allowing drivers
to borrow from RegistrationData in their per-file data.

Introduce DriverFile<'a> as a lifetime-parameterized trait that receives
both the device and registration data in open(). Parametrize File<D> on
the driver type rather than the file data type, deriving the concrete
file type through ForLt.

Add inner() for covariant file types and inner_with() for invariant ones
to access the driver file data from a File<D> reference.

Ensure file data is always dropped before registration data:

  - In Registration::drop(), iterate the filelist under filelist_mutex
    and drop driver_priv for all open files, then wait for in-flight
    postclose_callback() calls to complete via an open_count / WaitQueue
    pair on drm::Device.

  - In postclose_callback(), skip the drop if driver_priv has already
    been NULLed by the filelist iteration. The NULL write is visible
    through the filelist_mutex acquire/release chain in
    drm_close_helper().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs |   5 +-
 drivers/gpu/drm/nova/file.rs   |  11 ++-
 drivers/gpu/drm/nova/gem.rs    |   8 +-
 drivers/gpu/drm/tyr/driver.rs  |   5 +-
 drivers/gpu/drm/tyr/file.rs    |  11 ++-
 rust/kernel/drm/device.rs      |  35 ++++++--
 rust/kernel/drm/driver.rs      |  69 ++++++++++++++-
 rust/kernel/drm/file.rs        | 150 ++++++++++++++++++++++-----------
 rust/kernel/drm/gem/mod.rs     |  12 ++-
 rust/kernel/drm/gem/shmem.rs   |  12 ++-
 rust/kernel/drm/ioctl.rs       |   2 +-
 11 files changed, 231 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 739690bc2db5..a8f61086773d 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -12,7 +12,8 @@
         ioctl, //
     },
     prelude::*,
-    sync::aref::ARef, //
+    sync::aref::ARef,
+    types::CovariantForLt, //
 };
 
 use crate::file::File;
@@ -75,7 +76,7 @@ fn probe<'bound>(
 impl drm::Driver for NovaDriver {
     type Data = ();
     type RegistrationData<'a> = ();
-    type File = File;
+    type File = CovariantForLt!(File);
     type Object = gem::Object<NovaObject>;
     type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
 
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 298c02bacb4b..1f94201af92b 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -3,7 +3,6 @@
 use crate::driver::{NovaDevice, NovaDriver};
 use crate::gem::NovaObject;
 use kernel::{
-    alloc::flags::*,
     auxiliary,
     device::Bound,
     drm::{
@@ -18,10 +17,10 @@
 
 pub(crate) struct File;
 
-impl drm::file::DriverFile for File {
+impl drm::file::DriverFile<'_> for File {
     type Driver = NovaDriver;
 
-    fn open(_dev: &NovaDevice) -> Result<Pin<KBox<Self>>> {
+    fn open(_device: &NovaDevice<Registered>, _reg_data: &()) -> Result<Pin<KBox<Self>>> {
         Ok(KBox::new(Self, GFP_KERNEL)?.into())
     }
 }
@@ -32,7 +31,7 @@ pub(crate) fn get_param(
         dev: &NovaDevice<Registered>,
         _reg_data: &(),
         getparam: &mut uapi::drm_nova_getparam,
-        _file: &drm::File<File>,
+        _file: &drm::File<NovaDriver>,
     ) -> Result<u32> {
         let adev: &auxiliary::Device<Bound> = dev.as_ref();
         let pdev: &pci::Device<Bound> = adev.parent().try_into()?;
@@ -52,7 +51,7 @@ pub(crate) fn gem_create(
         dev: &NovaDevice<Registered>,
         _reg_data: &(),
         req: &mut uapi::drm_nova_gem_create,
-        file: &drm::File<File>,
+        file: &drm::File<NovaDriver>,
     ) -> Result<u32> {
         let obj = NovaObject::new(dev, req.size.try_into()?)?;
 
@@ -66,7 +65,7 @@ pub(crate) fn gem_info(
         _dev: &NovaDevice<Registered>,
         _reg_data: &(),
         req: &mut uapi::drm_nova_gem_info,
-        file: &drm::File<File>,
+        file: &drm::File<NovaDriver>,
     ) -> Result<u32> {
         let bo = NovaObject::lookup_handle(file, req.handle)?;
 
diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
index 2b6fe9dc0bfa..2a21ff8ba579 100644
--- a/drivers/gpu/drm/nova/gem.rs
+++ b/drivers/gpu/drm/nova/gem.rs
@@ -11,9 +11,9 @@
     sync::aref::ARef,
 };
 
-use crate::{
-    driver::{NovaDevice, NovaDriver},
-    file::File,
+use crate::driver::{
+    NovaDevice,
+    NovaDriver, //
 };
 
 /// GEM Object inner driver data
@@ -43,7 +43,7 @@ pub(crate) fn new(dev: &NovaDevice, size: usize) -> Result<ARef<gem::Object<Self
     /// Look up a GEM object handle for a `File` and return an `ObjectRef` for it.
     #[inline]
     pub(crate) fn lookup_handle(
-        file: &drm::File<File>,
+        file: &drm::File<NovaDriver>,
         handle: u32,
     ) -> Result<ARef<gem::Object<Self>>> {
         gem::Object::lookup_handle(file, handle)
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index d78ad9d292ff..94bc85635725 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -32,7 +32,8 @@
         Arc,
         Mutex, //
     },
-    time, //
+    time,
+    types::CovariantForLt, //
 };
 
 use crate::{
@@ -206,7 +207,7 @@ fn drop(self: Pin<&mut Self>) {}
 impl drm::Driver for TyrDrmDriver {
     type Data = ();
     type RegistrationData<'drm> = TyrDrmRegistrationData<'drm>;
-    type File = TyrDrmFileData;
+    type File = CovariantForLt!(TyrDrmFileData);
     type Object = Bo;
     type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
 
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 9f60a90d4948..0e0878090de6 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -19,13 +19,16 @@
 #[pin_data]
 pub(crate) struct TyrDrmFileData {}
 
-/// Convenience type alias for our DRM `File` type
-pub(crate) type TyrDrmFile = drm::file::File<TyrDrmFileData>;
+/// Convenience type alias for our DRM `File` type.
+pub(crate) type TyrDrmFile = drm::file::File<TyrDrmDriver>;
 
-impl drm::file::DriverFile for TyrDrmFileData {
+impl drm::file::DriverFile<'_> for TyrDrmFileData {
     type Driver = TyrDrmDriver;
 
-    fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
+    fn open(
+        _device: &TyrDrmDevice<Registered>,
+        _reg_data: &TyrDrmRegistrationData<'_>,
+    ) -> Result<Pin<KBox<Self>>> {
         KBox::try_pin_init(try_pin_init!(Self {}), GFP_KERNEL)
     }
 }
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 09903ed783e1..29512d0e2ddb 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -15,11 +15,16 @@
     },
     error::from_err_ptr,
     prelude::*,
-    sync::aref::{
-        ARef,
-        AlwaysRefCounted, //
+    sync::{
+        aref::{
+            ARef,
+            AlwaysRefCounted, //
+        },
+        atomic::Atomic,
+        WaitQueue,
     },
     types::{
+        ForLt,
         NotThreadSafe,
         Opaque, //
     },
@@ -190,7 +195,10 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<T: drm::Driver> UnregisteredDevice<T> {
+impl<T: drm::Driver> UnregisteredDevice<T>
+where
+    for<'a> <T::File as ForLt>::Of<'a>: drm::file::DriverFile<'a, Driver = T>,
+{
     const fn compute_features() -> u32 {
         let mut features = drm::driver::FEAT_GEM;
 
@@ -203,8 +211,8 @@ const fn compute_features() -> u32 {
 
     const VTABLE: bindings::drm_driver = drm_legacy_fields! {
         load: None,
-        open: Some(drm::File::<T::File>::open_callback),
-        postclose: Some(drm::File::<T::File>::postclose_callback),
+        open: Some(drm::File::<T>::open_callback),
+        postclose: Some(drm::File::<T>::postclose_callback),
         unload: None,
         release: Some(Device::<T>::release),
         master_set: None,
@@ -333,6 +341,19 @@ pub fn new(
         // SAFETY: `raw_drm` is valid; no concurrent access before registration.
         unsafe { (*raw_drm.as_ptr()).registration_data = UnsafeCell::new(NonNull::dangling()) };
 
+        // SAFETY: `raw_drm` is valid; no concurrent access before registration.
+        unsafe { (*raw_drm.as_ptr()).open_count = Atomic::new(0) };
+
+        // SAFETY:
+        // - `raw_drm` is valid; no concurrent access before registration.
+        // - The field is pinned because the Device is pinned (refcounted, allocated by
+        //   `__drm_dev_alloc()`, never moved).
+        // - The init is infallible.
+        let Ok(()) = unsafe {
+            crate::new_waitqueue!("drm_open_count")
+                .__pinned_init(&raw mut (*raw_drm.as_ptr()).open_count_wq)
+        };
+
         // SAFETY: The reference count is one, and now we take ownership of that reference as a
         // `drm::Device`.
         // INVARIANT: We just created the device above, but have yet to call `drm_dev_register`.
@@ -357,6 +378,8 @@ pub struct Device<T: drm::Driver, C: DeviceContext = Normal> {
     dev: Opaque<bindings::drm_device>,
     data: T::Data,
     pub(super) registration_data: UnsafeCell<NonNull<T::RegistrationData<'static>>>,
+    pub(super) open_count: Atomic<i32>,
+    pub(super) open_count_wq: WaitQueue,
     _ctx: PhantomData<C>,
 }
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 74f6ed690d8b..2aa534149d78 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -9,8 +9,17 @@
     device,
     drm,
     error::to_result,
+    interop::list::clist_create,
     prelude::*,
-    sync::aref::ARef, //
+    sync::{
+        aref::ARef,
+        atomic::{
+            Acquire,
+            Release, //
+        },
+        Mutex, //
+    },
+    types::ForLt, //
 };
 use core::ptr::NonNull;
 
@@ -117,8 +126,15 @@ pub trait Driver {
     /// The type used to manage memory for this driver.
     type Object: AllocImpl;
 
-    /// The type used to represent a DRM File (client)
-    type File: drm::file::DriverFile;
+    /// The type used to represent a DRM File (client).
+    ///
+    /// File data may borrow from [`RegistrationData`](Driver::RegistrationData). File data is
+    /// guaranteed to be dropped before registration data, either when the file is closed or
+    /// when the device is unregistered, whichever comes first.
+    ///
+    /// Drivers set this to `CovariantForLt!(MyFileData)` (or `ForLt!` for invariant types)
+    /// and implement [`DriverFile`](drm::file::DriverFile) for their file data type.
+    type File: ForLt + 'static;
 
     /// The bus device type of the parent device that the DRM device is associated with.
     type ParentDevice<Ctx: device::DeviceContext>: device::AsBusDevice<Ctx>;
@@ -221,6 +237,51 @@ fn drop(&mut self) {
         unsafe { bindings::drm_dev_unplug(self.drm.as_raw()) };
         // After drm_dev_unplug(), the SRCU barrier guarantees that all RegistrationGuard critical
         // sections have completed, so no one holds a reference to reg_data anymore.
-        // reg_data is dropped here automatically.
+
+        // Drop all remaining file private data before dropping registration data. This guarantees
+        // that file data (which may borrow from RegistrationData) is always dropped first.
+        let raw = self.drm.as_raw();
+
+        // SAFETY: `filelist_mutex` is initialized by `drm_dev_init()` and remains valid for
+        // the lifetime of the `struct drm_device`.
+        let filelist_mutex = unsafe { Mutex::from_raw(&raw mut (*raw).filelist_mutex) };
+        {
+            let _guard = filelist_mutex.lock();
+
+            // SAFETY: `filelist` is a valid, initialized sentinel `list_head`; the mutex
+            // guard prevents concurrent modification.
+            let filelist = unsafe {
+                clist_create!(
+                    &raw mut (*raw).filelist,
+                    drm::File<T>,
+                    bindings::drm_file,
+                    lhead
+                )
+            };
+
+            for file in filelist.iter() {
+                // SAFETY: `file` is a valid `drm_file` on this device's filelist.
+                let priv_ptr = unsafe { (*file.as_raw()).driver_priv };
+
+                // SAFETY: Setting `driver_priv` to NULL is visible to `postclose_callback()`
+                // through the `filelist_mutex` acquire/release chain in `drm_close_helper()`.
+                unsafe { (*file.as_raw()).driver_priv = core::ptr::null_mut() };
+
+                // SAFETY: `driver_priv` was created by `open_callback()` via `KBox::into_raw` and
+                // has not yet been freed (the file is still in the list, so `postclose_callback()`
+                // has not run).
+                drop(unsafe { KBox::from_raw(priv_ptr.cast::<<T::File as ForLt>::Of<'static>>()) });
+
+                self.drm.open_count.fetch_sub(1, Release);
+            }
+        }
+
+        // Wait for in-flight `postclose_callback()` calls to complete. After `drm_dev_unplug()`, no
+        // new opens can succeed, so `open_count` is monotonically decreasing.
+        self.drm
+            .open_count_wq
+            .wait_event(|| self.drm.open_count.load(Acquire) == 0);
+
+        // `_reg_data` is dropped here automatically, after all file data has been dropped.
     }
 }
diff --git a/rust/kernel/drm/file.rs b/rust/kernel/drm/file.rs
index 10160601ce5a..6491ec5707a0 100644
--- a/rust/kernel/drm/file.rs
+++ b/rust/kernel/drm/file.rs
@@ -8,17 +8,34 @@
     bindings,
     drm,
     prelude::*,
-    types::Opaque, //
+    sync::atomic::{
+        Relaxed,
+        Release, //
+    },
+    types::{
+        CovariantForLt,
+        ForLt,
+        Opaque, //
+    }, //
 };
 use core::marker::PhantomData;
 
 /// Trait that must be implemented by DRM drivers to represent a DRM File (a client instance).
-pub trait DriverFile {
+///
+/// The lifetime `'a` allows the file data to borrow from
+/// [`RegistrationData`](drm::Driver::RegistrationData).
+pub trait DriverFile<'a>: Sized {
     /// The parent `Driver` implementation for this `DriverFile`.
     type Driver: drm::Driver;
 
-    /// Open a new file (called when a client opens the DRM device).
-    fn open(device: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>>;
+    /// Open a new DRM file, creating the per-file driver data.
+    ///
+    /// Called when a client opens the DRM device. The returned file data may borrow from
+    /// `reg_data` with lifetime `'a`.
+    fn open(
+        device: &drm::Device<Self::Driver, drm::Registered>,
+        reg_data: &'a <Self::Driver as drm::Driver>::RegistrationData<'a>,
+    ) -> Result<Pin<KBox<Self>>>;
 }
 
 /// An open DRM File.
@@ -27,17 +44,17 @@ pub trait DriverFile {
 ///
 /// `self.0` is a valid instance of a `struct drm_file`.
 #[repr(transparent)]
-pub struct File<T: DriverFile>(Opaque<bindings::drm_file>, PhantomData<T>);
+pub struct File<D: drm::Driver>(Opaque<bindings::drm_file>, PhantomData<D>);
 
-impl<T: DriverFile> File<T> {
+impl<D: drm::Driver> File<D> {
     #[doc(hidden)]
     /// Not intended to be called externally, except via declare_drm_ioctls!()
     ///
     /// # Safety
     ///
-    /// `raw_file` must be a valid pointer to an open `struct drm_file`, opened through `T::open`.
-    pub unsafe fn from_raw<'a>(ptr: *mut bindings::drm_file) -> &'a File<T> {
-        // SAFETY: `raw_file` is valid by the safety requirements of this function.
+    /// `ptr` must be a valid pointer to an open `struct drm_file`.
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::drm_file) -> &'a File<D> {
+        // SAFETY: `ptr` is valid by the safety requirements of this function.
         unsafe { &*ptr.cast() }
     }
 
@@ -45,59 +62,94 @@ pub(super) fn as_raw(&self) -> *mut bindings::drm_file {
         self.0.get()
     }
 
-    fn driver_priv(&self) -> *mut T {
-        // SAFETY: By the type invariants of `Self`, `self.as_raw()` is always valid.
-        unsafe { (*self.as_raw()).driver_priv }.cast()
+    /// Return a pinned reference to the driver file data.
+    ///
+    /// Only available when `D::File` implements [`trait@CovariantForLt`]. For invariant types, use
+    /// [`inner_with()`](Self::inner_with).
+    pub fn inner(&self) -> Pin<&<D::File as ForLt>::Of<'_>>
+    where
+        D::File: CovariantForLt,
+    {
+        // SAFETY: `driver_priv` was initialized by `open_callback()`. `CovariantForLt` guarantees
+        // the lifetime shortening from `'static` to `'_` is sound.
+        unsafe { Pin::new_unchecked(&*(*self.as_raw()).driver_priv.cast_const().cast()) }
     }
 
-    /// Return a pinned reference to the driver file structure.
-    pub fn inner(&self) -> Pin<&T> {
-        // SAFETY: By the type invariant the pointer `self.as_raw()` points to a valid and opened
-        // `struct drm_file`, hence `driver_priv` has been properly initialized by `open_callback`.
-        unsafe { Pin::new_unchecked(&*(self.driver_priv())) }
+    /// Access the driver file data through a closure.
+    ///
+    /// This works for all file data types, including invariant ones. For covariant types,
+    /// [`inner()`](Self::inner) provides direct access without a closure.
+    pub fn inner_with<R, F>(&self, f: F) -> R
+    where
+        F: for<'a> FnOnce(Pin<&'a <D::File as ForLt>::Of<'a>>) -> R,
+    {
+        // SAFETY: `driver_priv` was initialized by `open_callback()`. The HRTB `for<'a>` prevents
+        // the caller from choosing a concrete lifetime, making the lifetime shortening sound
+        // regardless of variance.
+        f(unsafe { Pin::new_unchecked(&*(*self.as_raw()).driver_priv.cast_const().cast()) })
     }
 
     /// The open callback of a `struct drm_file`.
+    ///
+    /// Called from `drm_open()`, which is itself called from `fops_open()`. The latter holds a
+    /// `RegistrationGuard`, so the device is guaranteed to be registered for the duration of this
+    /// callback.
     pub(crate) extern "C" fn open_callback(
         raw_dev: *mut bindings::drm_device,
         raw_file: *mut bindings::drm_file,
-    ) -> core::ffi::c_int {
-        // SAFETY: A callback from `struct drm_driver::open` guarantees that
-        // - `raw_dev` is valid pointer to a `struct drm_device`,
-        // - the corresponding `struct drm_device` has been registered.
-        let drm = unsafe { drm::Device::from_raw(raw_dev) };
-
-        // SAFETY: `raw_file` is a valid pointer to a `struct drm_file`.
-        let file = unsafe { File::<T>::from_raw(raw_file) };
-
-        let inner = match T::open(drm) {
-            Err(e) => {
-                return e.to_errno();
-            }
-            Ok(i) => i,
-        };
-
-        // SAFETY: This pointer is treated as pinned, and the Drop guarantee is upheld in
-        // `postclose_callback()`.
-        let driver_priv = KBox::into_raw(unsafe { Pin::into_inner_unchecked(inner) });
-
-        // SAFETY: By the type invariants of `Self`, `self.as_raw()` is always valid.
-        unsafe { (*file.as_raw()).driver_priv = driver_priv.cast() };
-
-        0
+    ) -> core::ffi::c_int
+    where
+        for<'a> <D::File as ForLt>::Of<'a>: DriverFile<'a, Driver = D>,
+    {
+        // SAFETY: The DRM core guarantees that `raw_dev` is valid. `fops_open()` holds a
+        // `RegistrationGuard`, so the device is registered and the `Registered` context holds.
+        let dev: &drm::device::Device<D, drm::Registered> =
+            unsafe { drm::device::Device::from_raw(raw_dev) };
+
+        dev.registration_data_with(|reg_data| {
+            let inner = match <<D::File as ForLt>::Of<'_> as DriverFile<'_>>::open(dev, reg_data) {
+                Err(e) => return e.to_errno(),
+                Ok(i) => i,
+            };
+
+            // SAFETY: This pointer is treated as pinned, and the Drop guarantee is upheld in
+            // `postclose_callback()` or the filelist iteration in `Registration::drop()`.
+            let driver_priv = KBox::into_raw(unsafe { Pin::into_inner_unchecked(inner) });
+
+            dev.open_count.fetch_add(1, Relaxed);
+
+            // SAFETY: `raw_file` is a valid pointer to a `struct drm_file`.
+            unsafe { (*raw_file).driver_priv = driver_priv.cast() };
+
+            0
+        })
     }
 
     /// The postclose callback of a `struct drm_file`.
     pub(crate) extern "C" fn postclose_callback(
-        _raw_dev: *mut bindings::drm_device,
+        raw_dev: *mut bindings::drm_device,
         raw_file: *mut bindings::drm_file,
-    ) {
-        // SAFETY: This reference won't escape this function
-        let file = unsafe { File::<T>::from_raw(raw_file) };
-
-        // SAFETY: `file.driver_priv` has been created in `open_callback` through `KBox::into_raw`.
-        let _ = unsafe { KBox::from_raw(file.driver_priv()) };
+    ) where
+        for<'a> <D::File as ForLt>::Of<'a>: DriverFile<'a, Driver = D>,
+    {
+        // SAFETY: `raw_file` is a valid pointer to a `struct drm_file`.
+        let driver_priv = unsafe { (*raw_file).driver_priv };
+
+        if driver_priv.is_null() {
+            return;
+        }
+
+        // SAFETY: `driver_priv` was created in `open_callback()` through `KBox::into_raw` and has
+        // not been dropped yet (the NULL check above guards against double-free from the filelist
+        // iteration in `Registration::drop()`).
+        let _ = unsafe { KBox::from_raw(driver_priv.cast::<<D::File as ForLt>::Of<'static>>()) };
+
+        // SAFETY: `raw_dev` is valid for the lifetime of the `struct drm_file`.
+        let dev: &drm::device::Device<D> = unsafe { drm::device::Device::from_raw(raw_dev) };
+        if dev.open_count.fetch_sub(1, Release) == 1 {
+            dev.open_count_wq.wake_up();
+        }
     }
 }
 
-impl<T: DriverFile> super::private::Sealed for File<T> {}
+impl<D: drm::Driver> super::private::Sealed for File<D> {}
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index ee048febfbdc..1aa18f0b172c 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -76,7 +76,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
 ///
 /// [`Driver`]: drm::Driver
 /// [`DriverFile`]: drm::file::DriverFile
-pub type DriverFile<T> = drm::File<<<T as DriverObject>::Driver as drm::Driver>::File>;
+pub type DriverFile<T> = drm::File<<T as DriverObject>::Driver>;
 
 /// A type alias for retrieving the current [`AllocImpl`] for a given [`DriverObject`].
 ///
@@ -196,11 +196,10 @@ fn size(&self) -> usize {
 
     /// Creates a new handle for the object associated with a given `File`
     /// (or returns an existing one).
-    fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
+    fn create_handle<D>(&self, file: &drm::File<D>) -> Result<u32>
     where
         Self: AllocImpl<Driver = D>,
-        D: drm::Driver<Object = Self, File = F>,
-        F: drm::file::DriverFile<Driver = D>,
+        D: drm::Driver<Object = Self>,
     {
         let mut handle: u32 = 0;
         // SAFETY: The arguments are all valid per the type invariants.
@@ -211,11 +210,10 @@ fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
     }
 
     /// Looks up an object by its handle for a given `File`.
-    fn lookup_handle<D, F>(file: &drm::File<F>, handle: u32) -> Result<ARef<Self>>
+    fn lookup_handle<D>(file: &drm::File<D>, handle: u32) -> Result<ARef<Self>>
     where
         Self: AllocImpl<Driver = D> + AlwaysRefCounted,
-        D: drm::Driver<Object = Self, File = F>,
-        F: drm::file::DriverFile<Driver = D>,
+        D: drm::Driver<Object = Self>,
     {
         // SAFETY: The arguments are all valid per the type invariants.
         let ptr = unsafe { bindings::drm_gem_object_lookup(file.as_raw().cast(), handle) };
diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index a687d46d170d..793b4883de3a 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -584,7 +584,8 @@ mod tests {
         },
         faux,
         io::Io,
-        page::PAGE_SIZE, //
+        page::PAGE_SIZE,
+        types::CovariantForLt, //
     };
 
     // The bare minimum needed to create a fake drm driver for kunit
@@ -604,10 +605,13 @@ struct KunitObject {}
         desc: c"Kunit",
     };
 
-    impl drm::file::DriverFile for KunitFile {
+    impl drm::file::DriverFile<'_> for KunitFile {
         type Driver = KunitDriver;
 
-        fn open(_dev: &drm::Device<KunitDriver>) -> Result<Pin<KBox<Self>>> {
+        fn open(
+            _device: &drm::Device<KunitDriver, drm::Registered>,
+            _reg_data: &(),
+        ) -> Result<Pin<KBox<Self>>> {
             Ok(KBox::new(Self, GFP_KERNEL)?.into())
         }
     }
@@ -629,7 +633,7 @@ fn new(
     impl drm::Driver for KunitDriver {
         type Data = KunitData;
         type RegistrationData<'a> = ();
-        type File = KunitFile;
+        type File = CovariantForLt!(KunitFile);
         type Object = Object<KunitObject>;
         type ParentDevice<Ctx: device::DeviceContext> = faux::Device<Ctx>;
 
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 9934b23c36eb..8ac7fb1d4ec2 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -97,7 +97,7 @@ pub const fn __dev_ctx_cast<T: crate::drm::Driver>(
 /// fn foo(device: &kernel::drm::Device<Self, kernel::drm::Registered>,
 ///        reg_data: &Self::RegistrationData<'_>,
 ///        data: &mut uapi::argument_type,
-///        file: &kernel::drm::File<Self::File>,
+///        file: &kernel::drm::File<Self>,
 /// ) -> Result<u32>
 /// ```
 /// where `Self` is the drm::drv::Driver implementation these ioctls are being declared within.
-- 
2.55.0

