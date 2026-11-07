Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9496606A32E
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVIAImaN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24D1610E520;
	Sat,  7 Nov 2026 02:21:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1D5D10E520
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 02:20:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A813341913;
 Sat,  7 Nov 2026 02:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980DE1F0089F;
 Sat,  7 Nov 2026 02:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794018056;
 bh=QPFnrihV2CbIAo3HEHNKdZY98nlrOB91ZpEHEOiNnlU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jVIAImaNBek3MiT23Ah+hsqu1i2UvixhIvhN8ewwqaBj4gSNzyuqzwHBQVJF3A26v
 CHnd4dQDnJeIXxmkLi+6TYv5AQjytxkIa4R/Ry9Q1XqHczPuaNx4UgNbtOaSoTWpAN
 Pn8K8zhc98fUbOtZ75/Qb6HaiM0Hlyi3rWGq2VhcCBcVrC88YM86zwr4CAMR6NqqQH
 uZKYMwqfvwzIMK8N21a/dwJBvh86dcqORhsXt7Urq+e+e9tKyQZXsVFZURUbgHWRzt
 YpME241c0uAXl45H3UHPpjWkSpKCQVQpDNZrWDf2lmxZJbUsuwMTpAFk19X3zRl7Mq
 lDjnttt0KzXVA==
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
Subject: [PATCH v2 7/7] rust: drm: make Driver::File lifetime-parameterized
Date: Sat,  7 Nov 2026 03:03:25 +0100
Message-ID: <20261107021427.2105374-8-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107021427.2105374-1-dakr@kernel.org>
References: <20261107021427.2105374-1-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make the DRM file private data lifetime-parameterized, allowing drivers
to borrow from RegistrationData in their per-file data.

Introduce DriverFile<'a> as a lifetime-parameterized trait that receives
both the device and registration data in open(). Parametrize File<D> on
the driver type rather than the file data type, deriving the concrete
file type through Driver::File<'a>.

Add inner_with() to access the driver file data from a File<D> reference.

Ensure file data is always dropped before registration data:

  - In Registration::drop(), detach driver_priv for all open files under
    filelist_mutex, then drop the detached data after releasing the mutex
    and wait for file-data destruction in concurrent postclose_callback()
    calls via an open_count / WaitQueue pair on drm::Device.

  - In postclose_callback(), skip the drop if driver_priv has already
    been NULLed by the filelist iteration. The NULL write is visible
    through the filelist_mutex acquire/release chain in
    drm_close_helper().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs |   2 +-
 drivers/gpu/drm/nova/file.rs   |  13 ++-
 drivers/gpu/drm/nova/gem.rs    |   8 +-
 drivers/gpu/drm/tyr/driver.rs  |   2 +-
 drivers/gpu/drm/tyr/file.rs    |  11 +-
 rust/kernel/drm/device.rs      |  36 +++++--
 rust/kernel/drm/driver.rs      | 113 +++++++++++++++++++--
 rust/kernel/drm/file.rs        | 180 ++++++++++++++++++++++++---------
 rust/kernel/drm/gem/mod.rs     |  44 ++++++--
 rust/kernel/drm/gem/shmem.rs   |   9 +-
 rust/kernel/drm/ioctl.rs       |   6 +-
 11 files changed, 330 insertions(+), 94 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 44a52e60b3c7..f2d40e6fab21 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -90,7 +90,7 @@ fn probe<'bound>(
 impl drm::Driver for NovaDriver {
     type Data = ();
     type RegistrationData<'a> = DrmRegData<'a>;
-    type File = File;
+    type File<'a> = File;
     type Object = gem::Object<NovaObject>;
     type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
 
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 13642f83289d..8b800f821e2c 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -99,10 +99,13 @@ fn write_info<T: AsBytes>(info: &mut uapi::drm_nova_info, value: T) -> Result {
     Ok(())
 }
 
-impl drm::file::DriverFile for File {
+impl drm::file::DriverFile<'_> for File {
     type Driver = NovaDriver;
 
-    fn open(_dev: &NovaDevice) -> impl PinInit<Self, Error> {
+    fn open(
+        _device: &NovaDevice<Registered>,
+        _reg_data: &DrmRegData<'_>,
+    ) -> impl PinInit<Self, Error> {
         Ok(Self)
     }
 }
@@ -113,7 +116,7 @@ pub(crate) fn gem_create(
         dev: &NovaDevice<Registered>,
         _reg_data: &DrmRegData<'_>,
         req: &mut uapi::drm_nova_gem_create,
-        file: &drm::File<File>,
+        file: &drm::File<NovaDriver>,
     ) -> Result<u32> {
         let obj = NovaObject::new(dev, req.size.try_into()?)?;
 
@@ -127,7 +130,7 @@ pub(crate) fn gem_info(
         _dev: &NovaDevice<Registered>,
         _reg_data: &DrmRegData<'_>,
         req: &mut uapi::drm_nova_gem_info,
-        file: &drm::File<File>,
+        file: &drm::File<NovaDriver>,
     ) -> Result<u32> {
         let bo = NovaObject::lookup_handle(file, req.handle)?;
 
@@ -141,7 +144,7 @@ pub(crate) fn info(
         _dev: &NovaDevice<Registered>,
         reg_data: &DrmRegData<'_>,
         info: &mut uapi::drm_nova_info,
-        _file: &drm::File<File>,
+        _file: &drm::File<NovaDriver>,
     ) -> Result<u32> {
         match info.id {
             uapi::DRM_NOVA_INFO_GPU => write_info(info, GpuInfo::new(reg_data)?)?,
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
index c2b99d67369f..46caf7b336d9 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -209,7 +209,7 @@ fn drop(self: Pin<&mut Self>) {}
 impl drm::Driver for TyrDrmDriver {
     type Data = ();
     type RegistrationData<'drm> = TyrDrmRegistrationData<'drm>;
-    type File = TyrDrmFileData;
+    type File<'a> = TyrDrmFileData;
     type Object = Bo;
     type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
 
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 6850708cfcdd..933a365cb016 100644
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
 
-    fn open(_dev: &drm::Device<Self::Driver>) -> impl PinInit<Self, Error> {
+    fn open(
+        _device: &TyrDrmDevice<Registered>,
+        _reg_data: &TyrDrmRegistrationData<'_>,
+    ) -> impl PinInit<Self, Error> {
         Ok(Self {})
     }
 }
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index b8444499b39c..bd66e55b6e17 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -15,9 +15,13 @@
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
         NotThreadSafe,
@@ -190,7 +194,10 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<T: drm::Driver> UnregisteredDevice<T> {
+impl<T: drm::Driver> UnregisteredDevice<T>
+where
+    for<'a> T::File<'a>: drm::file::DriverFile<'a, Driver = T>,
+{
     const fn compute_features() -> u32 {
         let mut features = drm::driver::FEAT_GEM;
 
@@ -203,8 +210,8 @@ const fn compute_features() -> u32 {
 
     const VTABLE: bindings::drm_driver = drm_legacy_fields! {
         load: None,
-        open: Some(drm::File::<T::File>::open_callback),
-        postclose: Some(drm::File::<T::File>::postclose_callback),
+        open: Some(drm::File::<T>::open_callback),
+        postclose: Some(drm::File::<T>::postclose_callback),
         unload: None,
         release: Some(Device::<T>::release),
         master_set: None,
@@ -333,6 +340,21 @@ pub fn new(
         // SAFETY: `raw_drm` is valid; no concurrent access before registration.
         unsafe { (*raw_drm.as_ptr()).registration_data = UnsafeCell::new(NonNull::dangling()) };
 
+        // SAFETY: `raw_drm` is valid; no concurrent access before registration.
+        unsafe { (*raw_drm.as_ptr()).open_count = Atomic::new(0) };
+
+        // SAFETY:
+        // - `raw_drm` is valid and `open_count_wq` is uninitialized; no concurrent access
+        //   before registration.
+        // - The field is pinned because the Device is pinned (refcounted, allocated by
+        //   `__drm_dev_alloc()`, never moved).
+        unsafe {
+            pin_init::raw_init(
+                &raw mut (*raw_drm.as_ptr()).open_count_wq,
+                crate::new_waitqueue!("drm_open_count"),
+            )
+        };
+
         // SAFETY: The reference count is one, and now we take ownership of that reference as a
         // `drm::Device`.
         // INVARIANT: We just created the device above, but have yet to call `drm_dev_register`.
@@ -357,6 +379,8 @@ pub struct Device<T: drm::Driver, C: DeviceContext = Normal> {
     dev: Opaque<bindings::drm_device>,
     data: T::Data,
     pub(super) registration_data: UnsafeCell<NonNull<T::RegistrationData<'static>>>,
+    pub(super) open_count: Atomic<i32>,
+    pub(super) open_count_wq: WaitQueue,
     _ctx: PhantomData<C>,
 }
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index f6db91e81e79..92055c4f9e00 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -7,10 +7,22 @@
 use crate::{
     bindings,
     device,
-    drm,
+    drm::{
+        self,
+        file::FileData, //
+    },
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
+    types::Opaque, //
 };
 use core::{
     marker::PhantomPinned,
@@ -120,8 +132,14 @@ pub trait Driver {
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
+    /// Drivers implement [`DriverFile`](drm::file::DriverFile) for their file data type.
+    type File<'a>: 'a;
 
     /// The bus device type of the parent device that the DRM device is associated with.
     type ParentDevice<Ctx: device::DeviceContext>: device::AsBusDevice<Ctx>;
@@ -197,6 +215,13 @@ pub unsafe fn new<E>(
                 // SAFETY: `drm` is a valid, initialized but not yet registered DRM device.
                 let ret = unsafe { bindings::drm_dev_register(drm.as_raw(), 0) };
                 to_result(ret).inspect_err(|_| {
+                    // SAFETY:
+                    // - Failed registration unplugs the device and drains registration guards.
+                    // - `data` remains initialized until this closure returns.
+                    // - Failed initialization does not run `Registration::drop()`, so this is
+                    //   the only file-data cleanup for this device.
+                    unsafe { Self::drop_file_data(drm) };
+
                     // SAFETY: `drm_dev_register()` synchronizes SRCU on failure, so no
                     // concurrent access to `registration_data` is possible at this point.
                     unsafe { *drm.registration_data.get() = NonNull::dangling() };
@@ -209,6 +234,75 @@ pub unsafe fn new<E>(
     pub fn device(&self) -> &drm::Device<T> {
         &self.drm
     }
+
+    /// Detaches and drops file data, then waits for concurrent postclose destruction.
+    ///
+    /// # Safety
+    ///
+    /// - `drm` must be unplugged with all `RegistrationGuard` sections drained.
+    /// - Its registration data must remain alive until this function returns.
+    /// - This must be the only call for this device.
+    unsafe fn drop_file_data(drm: &drm::Device<T>) {
+        let raw = drm.as_raw();
+        let mut files = None;
+
+        // SAFETY: `filelist_mutex` is initialized by `drm_dev_init()` and remains valid for
+        // the lifetime of the `struct drm_device`.
+        let filelist_mutex = unsafe { Mutex::from_raw(&raw mut (*raw).filelist_mutex) };
+        {
+            let _guard = filelist_mutex.lock();
+
+            // SAFETY:
+            // - `filelist` is initialized and protected by the held mutex.
+            // - Its entries are `drm_file`s linked through `lhead`; `Opaque` has the same layout.
+            let filelist = unsafe {
+                clist_create!(
+                    &raw mut (*raw).filelist,
+                    Opaque<bindings::drm_file>,
+                    bindings::drm_file,
+                    lhead
+                )
+            };
+
+            // Detach the allocations so `postclose()` sees NULL and leaves their destruction to us.
+            // After `postclose()` returns, the DRM core can free the C file, so the detached list
+            // must not depend on it. All `RegistrationGuard` sections have already been drained.
+            for file in filelist.iter() {
+                // SAFETY: `file` is a valid `drm_file` on this device's filelist.
+                let priv_ptr = unsafe { (*file.get()).driver_priv };
+
+                // SAFETY: Setting `driver_priv` to NULL is visible to `postclose_callback()`
+                // through the `filelist_mutex` acquire/release chain in `drm_close_helper()`.
+                unsafe { (*file.get()).driver_priv = core::ptr::null_mut() };
+
+                // SAFETY:
+                // - `priv_ptr` comes from `KBox::into_raw()` in `open_callback()`.
+                // - The file is still in the list, so `postclose_callback()` has not run. Clearing
+                //   `driver_priv` transfers ownership here and makes a later postclose skip it.
+                // - Only the owning pointer is moved; the pinned allocation is dropped in place.
+                let mut data = unsafe {
+                    Pin::new_unchecked(KBox::from_raw(
+                        priv_ptr.cast::<FileData<T::File<'static>>>(),
+                    ))
+                };
+                *data.as_mut().project().next = files.take();
+                files = Some(data);
+            }
+        }
+
+        // Run driver destructors without `filelist_mutex`. Take each link before dropping its
+        // allocation to avoid recursively dropping the entire chain.
+        while let Some(mut data) = files {
+            files = data.as_mut().project().next.take();
+            drop(data);
+            drm.open_count.fetch_sub(1, Release);
+        }
+
+        // Wait for file-data destruction in concurrent `postclose_callback()` calls. No new opens
+        // can succeed after unplug, so `open_count` is monotonically decreasing.
+        drm.open_count_wq
+            .wait_event(|| drm.open_count.load(Acquire) == 0);
+    }
 }
 
 // SAFETY: `Registration` doesn't offer any methods or access to fields when shared between
@@ -230,8 +324,13 @@ fn drop(self: Pin<&mut Self>) {
         // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The existence of this
         // `Registration` also guarantees that this `drm::Device` is actually registered.
         unsafe { bindings::drm_dev_unplug(self.drm.as_raw()) };
-        // After drm_dev_unplug(), the SRCU barrier guarantees that all RegistrationGuard critical
-        // sections have completed, so no one holds a reference to reg_data anymore.
-        // reg_data is dropped here automatically.
+
+        // SAFETY:
+        // - `drm_dev_unplug()` has unplugged the device and drained registration guards.
+        // - Registration data remains alive until this destructor returns.
+        // - Registration succeeded, so this destructor performs the only file-data cleanup.
+        unsafe { Self::drop_file_data(&self.drm) };
+
+        // Registration data is dropped here automatically, after all file data has been dropped.
     }
 }
diff --git a/rust/kernel/drm/file.rs b/rust/kernel/drm/file.rs
index bd5e4ca2977f..2dd0e61718fb 100644
--- a/rust/kernel/drm/file.rs
+++ b/rust/kernel/drm/file.rs
@@ -8,36 +8,66 @@
     bindings,
     drm,
     prelude::*,
+    sync::atomic::{
+        Relaxed,
+        Release, //
+    },
     types::Opaque, //
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
-    fn open(device: &drm::Device<Self::Driver>) -> impl PinInit<Self, Error>;
+    /// Open a new DRM file, creating the per-file driver data.
+    ///
+    /// Called when a client opens the DRM device. The returned initializer may borrow from
+    /// `reg_data` with lifetime `'a`.
+    fn open(
+        device: &drm::Device<Self::Driver, drm::Registered>,
+        reg_data: &'a <Self::Driver as drm::Driver>::RegistrationData<'a>,
+    ) -> impl PinInit<Self, Error>;
+}
+
+/// File-private allocation, with a link for dropping detached data outside `filelist_mutex`.
+#[pin_data]
+pub(super) struct FileData<T> {
+    /// Pinned per-file driver data, which may borrow from registration data.
+    #[pin]
+    data: T,
+    /// Next detached allocation to drop during registration teardown; otherwise `None`.
+    pub(super) next: Option<Pin<KBox<Self>>>,
 }
 
 /// An open DRM File.
 ///
 /// # Invariants
 ///
-/// `self.0` is a valid instance of a `struct drm_file`.
+/// - `self.0` is a valid instance of a `struct drm_file` opened on a device of driver `D`.
+/// - A [`drm::RegistrationGuard`] for that device is held for the duration of any `&File<D>`
+///   reference.
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
+    /// - `ptr` must point to an open `struct drm_file` on a device of driver `D` and remain valid
+    ///   for `'a`.
+    /// - A [`drm::RegistrationGuard`] for that device must be held for all of `'a`.
+    #[inline]
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::drm_file) -> &'a File<D> {
+        // SAFETY:
+        // - The caller guarantees that `ptr` is valid for `'a`.
+        // - The caller guarantees that the type invariants hold.
         unsafe { &*ptr.cast() }
     }
 
@@ -45,60 +75,110 @@ pub(super) fn as_raw(&self) -> *mut bindings::drm_file {
         self.0.get()
     }
 
-    fn driver_priv(&self) -> *mut T {
-        // SAFETY: By the type invariants of `Self`, `self.as_raw()` is always valid.
-        unsafe { (*self.as_raw()).driver_priv }.cast()
+    /// Returns the registered DRM device this file was opened on.
+    #[inline]
+    pub fn device(&self) -> &drm::Device<D, drm::Registered> {
+        // SAFETY:
+        // - The open file keeps its minor and device alive.
+        // - By the type invariants, the device uses driver `D`.
+        // - The type invariants require a `RegistrationGuard` for the device throughout this
+        //   borrow, satisfying the `Registered` context.
+        unsafe { drm::Device::from_raw((*(*self.as_raw()).minor).dev) }
     }
 
-    /// Return a pinned reference to the driver file structure.
-    pub fn inner(&self) -> Pin<&T> {
-        // SAFETY: By the type invariant the pointer `self.as_raw()` points to a valid and opened
-        // `struct drm_file`, hence `driver_priv` has been properly initialized by `open_callback`.
-        unsafe { Pin::new_unchecked(&*(self.driver_priv())) }
+    /// Access the driver file data through a closure.
+    ///
+    /// The closure receives a pinned reference to the file data.
+    ///
+    /// The outer reference carries the `&self` lifetime while the inner type carries the HRTB
+    /// lifetime `'a`, implying `'a` outlives `&self`. This allows the closure to coerce covariant
+    /// sub-fields (e.g. `&'a T` to the caller's lifetime) and return them directly in `R`.
+    #[inline]
+    pub fn inner_with<'this, R, F>(&'this self, f: F) -> R
+    where
+        F: for<'a> FnOnce(Pin<&'this D::File<'a>>) -> R,
+    {
+        // SAFETY: By the type invariants, `self.as_raw()` points to a valid `drm_file`.
+        let ptr: *const FileData<_> = unsafe { (*self.as_raw()).driver_priv.cast_const().cast() };
+
+        // SAFETY:
+        // - The type invariants keep this file's pinned `FileData` allocation valid for `'this`.
+        // - The `data` field is structurally pinned.
+        // - The HRTB `for<'a>` prevents the caller from choosing a concrete lifetime, so shortening
+        //   is sound regardless of variance.
+        let data: Pin<&'this D::File<'this>> = unsafe { Pin::new_unchecked(&(*ptr).data) };
+        f(data)
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
-        let init = T::open(drm);
-        let inner = match KBox::try_pin_init(init, GFP_KERNEL) {
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
+        for<'a> D::File<'a>: DriverFile<'a, Driver = D>,
+    {
+        // SAFETY:
+        // - The DRM core guarantees that `raw_dev` is valid.
+        // - `fops_open()` holds a `RegistrationGuard`, satisfying the `Registered` context.
+        let dev: &drm::device::Device<D, drm::Registered> =
+            unsafe { drm::device::Device::from_raw(raw_dev) };
+
+        dev.registration_data_with(|reg_data| {
+            let init = try_pin_init!(FileData {
+                next: None,
+                data <- <D::File<'_> as DriverFile<'_>>::open(dev, reg_data),
+            });
+            let inner = match KBox::try_pin_init(init, GFP_KERNEL) {
+                Err(e) => return e.to_errno(),
+                Ok(i) => i,
+            };
+
+            // SAFETY: The allocation stays pinned until `postclose_callback()` or
+            // `Registration::drop_file_data()` drops it in place.
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
+        for<'a> D::File<'a>: DriverFile<'a, Driver = D>,
+    {
+        // SAFETY: `raw_file` is a valid pointer to a `struct drm_file`.
+        let driver_priv = unsafe { (*raw_file).driver_priv };
+
+        if driver_priv.is_null() {
+            return;
+        }
+
+        // SAFETY:
+        // - `driver_priv` comes from `KBox::into_raw()` in `open_callback()`.
+        // - The file is not on the filelist, and the NULL check rules out ownership having been
+        //   transferred to `Registration::drop_file_data()`.
+        // - The pinned data is dropped in place while registration data is still alive, since
+        //   registration cleanup waits for `open_count` to reach zero.
+        drop(unsafe { KBox::from_raw(driver_priv.cast::<FileData<D::File<'static>>>()) });
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
index 260f36817f96..123a3896f2a5 100644
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
@@ -136,7 +136,9 @@ extern "C" fn open_callback<T: DriverObject>(
         return ENODEV.to_errno();
     };
 
-    // SAFETY: `open_callback` is only ever called with a valid pointer to a `struct drm_file`.
+    // SAFETY:
+    // - Handle creation ensures the valid file belongs to the object's device (`T::Driver`).
+    // - `_guard` is held for the entire use of the file reference.
     let file = unsafe { DriverFile::<T>::from_raw(raw_file) };
 
     // SAFETY:
@@ -164,7 +166,9 @@ extern "C" fn close_callback<T: DriverObject>(
         return;
     };
 
-    // SAFETY: `open_callback` is only ever called with a valid pointer to a `struct drm_file`.
+    // SAFETY:
+    // - Handle creation ensures the valid file belongs to the object's device (`T::Driver`).
+    // - `_guard` is held for the entire use of the file reference.
     let file = unsafe { DriverFile::<T>::from_raw(raw_file) };
 
     // SAFETY: `close_callback` is specified in the AllocOps structure for `Object<T>`, ensuring
@@ -188,6 +192,18 @@ unsafe fn from_raw<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self {
 
 /// Base operations shared by all GEM object classes
 pub trait BaseObject: IntoGEMObject {
+    /// Returns the DRM device that owns this GEM object.
+    #[inline]
+    fn device(&self) -> &drm::Device<Self::Driver>
+    where
+        Self: AllocImpl,
+    {
+        // SAFETY:
+        // - `self.as_raw()` points to a valid GEM object whose device is valid for this borrow.
+        // - The sealed `AllocImpl` implementations identify the device's driver as `Self::Driver`.
+        unsafe { drm::Device::from_raw((*self.as_raw()).dev) }
+    }
+
     /// Returns the size of the object in bytes.
     fn size(&self) -> usize {
         // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a valid `struct drm_gem_object`.
@@ -196,26 +212,32 @@ fn size(&self) -> usize {
 
     /// Creates a new handle for the object associated with a given `File`
     /// (or returns an existing one).
-    fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
+    ///
+    /// Returns [`EINVAL`] if the object and file belong to different DRM devices.
+    fn create_handle<D>(&self, file: &drm::File<D>) -> Result<u32>
     where
         Self: AllocImpl<Driver = D>,
-        D: drm::Driver<Object = Self, File = F>,
-        F: drm::file::DriverFile<Driver = D>,
+        D: drm::Driver<Object = Self>,
     {
+        if self.device().as_raw() != file.device().as_raw() {
+            return Err(EINVAL);
+        }
+
         let mut handle: u32 = 0;
-        // SAFETY: The arguments are all valid per the type invariants.
+        // SAFETY:
+        // - The pointers are valid per the type invariants.
+        // - The object and file belong to the same DRM device.
         to_result(unsafe {
-            bindings::drm_gem_handle_create(file.as_raw().cast(), self.as_raw(), &mut handle)
+            bindings::drm_gem_handle_create(file.as_raw(), self.as_raw(), &mut handle)
         })?;
         Ok(handle)
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
index 1a4f81e3b5b5..1558b6079edf 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -601,10 +601,13 @@ struct KunitObject {}
         desc: c"Kunit",
     };
 
-    impl drm::file::DriverFile for KunitFile {
+    impl drm::file::DriverFile<'_> for KunitFile {
         type Driver = KunitDriver;
 
-        fn open(_dev: &drm::Device<KunitDriver>) -> impl PinInit<Self, Error> {
+        fn open(
+            _device: &drm::Device<KunitDriver, drm::Registered>,
+            _reg_data: &(),
+        ) -> impl PinInit<Self, Error> {
             Ok(Self)
         }
     }
@@ -626,7 +629,7 @@ fn new(
     impl drm::Driver for KunitDriver {
         type Data = KunitData;
         type RegistrationData<'a> = ();
-        type File = KunitFile;
+        type File<'a> = KunitFile;
         type Object = Object<KunitObject>;
         type ParentDevice<Ctx: device::DeviceContext> = faux::Device<Ctx>;
 
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 9934b23c36eb..65c326348c64 100644
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
@@ -192,7 +192,9 @@ macro_rules! declare_drm_ioctls {
                             // There is no concurrent access or aliasing; no other references
                             // to this object exist during this call.
                             let data = unsafe { &mut *(raw_data.cast::<$crate::uapi::$struct>()) };
-                            // SAFETY: This is just the DRM file structure
+                            // SAFETY:
+                            // - The DRM core provides a valid file for this device.
+                            // - `guard` is held for the entire use of the file reference.
                             let file = unsafe { $crate::drm::File::from_raw(raw_file) };
 
                             match guard.registration_data_with(|reg_data| {
-- 
2.56.0

