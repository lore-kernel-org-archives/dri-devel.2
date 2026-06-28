Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99ECBC43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF51510E620;
	Sun, 28 Jun 2026 14:54:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QKytFGvZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FE9010E61E
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:54:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 16E86413DC;
 Sun, 28 Jun 2026 14:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E181F000E9;
 Sun, 28 Jun 2026 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782658483;
 bh=T6RGWBpZ+XHb88E4UWBgvsDwsBAQvIjkvG1wZ1Va4wo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QKytFGvZ27h6sYYBIWcbok3YMk1z2anN1tRRG3wJcaW560auJhMnFek24jqLG0lDH
 qIQD0VoF9B7URG/DTvrpob6U8P7jpcSYUFOt1LG4tIe0LKkj5LiTHR4Mu9+YSvTMLh
 uP0fOf+AipAlNcC52oJ3pY2/U0tZmnf8I6Kb5pHQcuSDUIQvzNHABgdJ+9PY2lUM+W
 KjpQjq4sdLF7GCztbFeoPR5e6a0HEnv0A/pIp89qIp9UiMSG+N/ns1RIKbNi+16L1m
 Y4Gy7P2FBxpuDrz6zQVZS8jht8/IS3Bl8O0vdXBVQPqc+ekguvtVA5Nj066KFo1v4Z
 sMGL4p8Da+17w==
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
Subject: [PATCH v5 07/19] rust: drm: restrict AlwaysRefCounted to Normal GEM
 Object context
Date: Sun, 28 Jun 2026 16:53:27 +0200
Message-ID: <20260628145406.2107056-8-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628145406.2107056-1-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
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

Restrict AlwaysRefCounted for gem::Object and gem::shmem::Object to the
Normal context, since only Normal objects should be independently
reference-counted.

To avoid cascading through IntoGEMObject (which had AlwaysRefCounted as
a supertrait), remove AlwaysRefCounted from IntoGEMObject's supertraits
and instead add it as an explicit bound on lookup_handle(), which is the
only BaseObject method that returns an ARef.

Since Object::new() and shmem::Object::new() return ARef<Self>, move
them to Normal-only impl blocks. Similarly, simplify ObjectConfig and
shmem's parent_resv_obj field to the Normal context.

Remove the DeviceContext generic from DriverObject::new() and
Driver::Object, since GEM objects can only be constructed in the Normal
context. Simplify DriverAllocImpl accordingly.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs |   2 +-
 drivers/gpu/drm/nova/gem.rs    |  18 ++---
 drivers/gpu/drm/tyr/driver.rs  |   2 +-
 drivers/gpu/drm/tyr/gem.rs     |  11 +--
 rust/kernel/drm/device.rs      |  14 ++--
 rust/kernel/drm/driver.rs      |   2 +-
 rust/kernel/drm/gem/mod.rs     |  97 ++++++++++++-------------
 rust/kernel/drm/gem/shmem.rs   | 129 +++++++++++++++++----------------
 8 files changed, 130 insertions(+), 145 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 8ddb81fd0c87..e3c54303d70e 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -76,7 +76,7 @@ fn probe<'bound>(
 impl drm::Driver for NovaDriver {
     type Data = NovaData;
     type File = File;
-    type Object<Ctx: drm::DeviceContext> = gem::Object<NovaObject, Ctx>;
+    type Object = gem::Object<NovaObject>;
     type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
 
     const INFO: drm::DriverInfo = INFO;
diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
index 9d8ff7de2c0f..2b6fe9dc0bfa 100644
--- a/drivers/gpu/drm/nova/gem.rs
+++ b/drivers/gpu/drm/nova/gem.rs
@@ -2,7 +2,10 @@
 
 use kernel::{
     drm,
-    drm::{gem, gem::BaseObject, DeviceContext},
+    drm::{
+        gem,
+        gem::BaseObject, //
+    },
     page,
     prelude::*,
     sync::aref::ARef,
@@ -21,27 +24,20 @@ impl gem::DriverObject for NovaObject {
     type Driver = NovaDriver;
     type Args = ();
 
-    fn new<Ctx: DeviceContext>(
-        _dev: &NovaDevice<Ctx>,
-        _size: usize,
-        _args: Self::Args,
-    ) -> impl PinInit<Self, Error> {
+    fn new(_dev: &NovaDevice, _size: usize, _args: Self::Args) -> impl PinInit<Self, Error> {
         try_pin_init!(NovaObject {})
     }
 }
 
 impl NovaObject {
     /// Create a new DRM GEM object.
-    pub(crate) fn new<Ctx: DeviceContext>(
-        dev: &NovaDevice<Ctx>,
-        size: usize,
-    ) -> Result<ARef<gem::Object<Self, Ctx>>> {
+    pub(crate) fn new(dev: &NovaDevice, size: usize) -> Result<ARef<gem::Object<Self>>> {
         if size == 0 {
             return Err(EINVAL);
         }
         let aligned_size = page::page_align(size).ok_or(EINVAL)?;
 
-        gem::Object::<Self, Ctx>::new(dev, aligned_size, ())
+        gem::Object::<Self>::new(dev, aligned_size, ())
     }
 
     /// Look up a GEM object handle for a `File` and return an `ObjectRef` for it.
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 180631daff02..7f082de6d6dc 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -182,7 +182,7 @@ fn drop(self: Pin<&mut Self>) {}
 impl drm::Driver for TyrDrmDriver {
     type Data = TyrDrmDeviceData;
     type File = TyrDrmFileData;
-    type Object<R: drm::DeviceContext> = drm::gem::shmem::Object<BoData, R>;
+    type Object = drm::gem::shmem::Object<BoData>;
     type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
 
     const INFO: drm::DriverInfo = INFO;
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index c6d4d6f9bae3..1640a161754b 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -5,10 +5,7 @@
 //! DRM's GEM subsystem with shmem backing.
 
 use kernel::{
-    drm::{
-        gem,
-        DeviceContext, //
-    },
+    drm::gem,
     prelude::*, //
 };
 
@@ -33,11 +30,7 @@ impl gem::DriverObject for BoData {
     type Driver = TyrDrmDriver;
     type Args = BoCreateArgs;
 
-    fn new<Ctx: DeviceContext>(
-        _dev: &TyrDrmDevice<Ctx>,
-        _size: usize,
-        args: BoCreateArgs,
-    ) -> impl PinInit<Self, Error> {
+    fn new(_dev: &TyrDrmDevice, _size: usize, args: BoCreateArgs) -> impl PinInit<Self, Error> {
         try_pin_init!(Self { flags: args.flags })
     }
 }
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 9825d52832af..6f3af46ff647 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -153,13 +153,13 @@ const fn compute_features() -> u32 {
         master_drop: None,
         debugfs_init: None,
 
-        gem_create_object: T::Object::<Normal>::ALLOC_OPS.gem_create_object,
-        prime_handle_to_fd: T::Object::<Normal>::ALLOC_OPS.prime_handle_to_fd,
-        prime_fd_to_handle: T::Object::<Normal>::ALLOC_OPS.prime_fd_to_handle,
-        gem_prime_import: T::Object::<Normal>::ALLOC_OPS.gem_prime_import,
-        gem_prime_import_sg_table: T::Object::<Normal>::ALLOC_OPS.gem_prime_import_sg_table,
-        dumb_create: T::Object::<Normal>::ALLOC_OPS.dumb_create,
-        dumb_map_offset: T::Object::<Normal>::ALLOC_OPS.dumb_map_offset,
+        gem_create_object: T::Object::ALLOC_OPS.gem_create_object,
+        prime_handle_to_fd: T::Object::ALLOC_OPS.prime_handle_to_fd,
+        prime_fd_to_handle: T::Object::ALLOC_OPS.prime_fd_to_handle,
+        gem_prime_import: T::Object::ALLOC_OPS.gem_prime_import,
+        gem_prime_import_sg_table: T::Object::ALLOC_OPS.gem_prime_import_sg_table,
+        dumb_create: T::Object::ALLOC_OPS.dumb_create,
+        dumb_map_offset: T::Object::ALLOC_OPS.dumb_map_offset,
 
         show_fdinfo: None,
         fbdev_probe: None,
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 802e7fc13e30..5152a18a8312 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -111,7 +111,7 @@ pub trait Driver {
     type Data: Sync + Send;
 
     /// The type used to manage memory for this driver.
-    type Object<Ctx: drm::DeviceContext>: AllocImpl;
+    type Object: AllocImpl;
 
     /// The type used to represent a DRM File (client)
     type File: drm::file::DriverFile;
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 1023ddccd785..d56cbe2663e2 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -10,8 +10,7 @@
         self,
         device::{
             DeviceContext,
-            Normal,
-            Registered, //
+            Normal, //
         },
         driver::{
             AllocImpl,
@@ -82,8 +81,7 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
 /// A type alias for retrieving the current [`AllocImpl`] for a given [`DriverObject`].
 ///
 /// [`Driver`]: drm::Driver
-pub type DriverAllocImpl<T, Ctx = Registered> =
-    <<T as DriverObject>::Driver as drm::Driver>::Object<Ctx>;
+pub type DriverAllocImpl<T> = <<T as DriverObject>::Driver as drm::Driver>::Object;
 
 /// GEM object functions, which must be implemented by drivers.
 pub trait DriverObject: Sync + Send + Sized {
@@ -94,8 +92,8 @@ pub trait DriverObject: Sync + Send + Sized {
     type Args;
 
     /// Create a new driver data object for a GEM object of a given size.
-    fn new<Ctx: DeviceContext>(
-        dev: &drm::Device<Self::Driver, Ctx>,
+    fn new(
+        dev: &drm::Device<Self::Driver>,
         size: usize,
         args: Self::Args,
     ) -> impl PinInit<Self, Error>;
@@ -110,7 +108,7 @@ fn close(_obj: &DriverAllocImpl<Self>, _file: &DriverFile<Self>) {}
 }
 
 /// Trait that represents a GEM object subtype
-pub trait IntoGEMObject: Sized + super::private::Sealed + AlwaysRefCounted {
+pub trait IntoGEMObject: Sized + super::private::Sealed {
     /// Returns a reference to the raw `drm_gem_object` structure, which must be valid as long as
     /// this owning object is valid.
     fn as_raw(&self) -> *mut bindings::drm_gem_object;
@@ -184,7 +182,7 @@ fn size(&self) -> usize {
     fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
     where
         Self: AllocImpl<Driver = D>,
-        D: drm::Driver<Object<Normal> = Self, File = F>,
+        D: drm::Driver<Object = Self, File = F>,
         F: drm::file::DriverFile<Driver = D>,
     {
         let mut handle: u32 = 0;
@@ -198,8 +196,8 @@ fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
     /// Looks up an object by its handle for a given `File`.
     fn lookup_handle<D, F>(file: &drm::File<F>, handle: u32) -> Result<ARef<Self>>
     where
-        Self: AllocImpl<Driver = D>,
-        D: drm::Driver<Object<Normal> = Self, File = F>,
+        Self: AllocImpl<Driver = D> + AlwaysRefCounted,
+        D: drm::Driver<Object = Self, File = F>,
         F: drm::file::DriverFile<Driver = D>,
     {
         // SAFETY: The arguments are all valid per the type invariants.
@@ -281,12 +279,43 @@ impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
         rss: None,
     };
 
+    /// Returns the `Device` that owns this GEM object.
+    pub fn dev(&self) -> &drm::Device<T::Driver, Ctx> {
+        // SAFETY:
+        // - `struct drm_gem_object.dev` is initialized and valid for as long as the GEM
+        //   object lives.
+        // - The device we used for creating the gem object is passed as &drm::Device<T::Driver> to
+        //   Object::<T>::new(), so we know that `T::Driver` is the right generic parameter to use
+        //   here.
+        // - Any type invariants of `Ctx` are upheld by using the same `Ctx` for the `Device` we
+        //   return.
+        unsafe { drm::Device::from_raw((*self.as_raw()).dev) }
+    }
+
+    fn as_raw(&self) -> *mut bindings::drm_gem_object {
+        self.obj.get()
+    }
+
+    extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
+        let ptr: *mut Opaque<bindings::drm_gem_object> = obj.cast();
+
+        // SAFETY: All of our objects are of type `Object<T>`.
+        let this = unsafe { crate::container_of!(ptr, Self, obj) };
+
+        // SAFETY: The C code only ever calls this callback with a valid pointer to a `struct
+        // drm_gem_object`.
+        unsafe { bindings::drm_gem_object_release(obj) };
+
+        // SAFETY: All of our objects are allocated via `KBox`, and we're in the
+        // free callback which guarantees this object has zero remaining references,
+        // so we can drop it.
+        let _ = unsafe { KBox::from_raw(this) };
+    }
+}
+
+impl<T: DriverObject> Object<T> {
     /// Create a new GEM object.
-    pub fn new(
-        dev: &drm::Device<T::Driver, Ctx>,
-        size: usize,
-        args: T::Args,
-    ) -> Result<ARef<Self>> {
+    pub fn new(dev: &drm::Device<T::Driver>, size: usize, args: T::Args) -> Result<ARef<Self>> {
         let obj: Pin<KBox<Self>> = KBox::pin_init(
             try_pin_init!(Self {
                 obj: Opaque::new(bindings::drm_gem_object::default()),
@@ -322,46 +351,12 @@ pub fn new(
         // SAFETY: We take over the initial reference count from `drm_gem_object_init()`.
         Ok(unsafe { ARef::from_raw(ptr) })
     }
-
-    /// Returns the `Device` that owns this GEM object.
-    pub fn dev(&self) -> &drm::Device<T::Driver, Ctx> {
-        // SAFETY:
-        // - `struct drm_gem_object.dev` is initialized and valid for as long as the GEM
-        //   object lives.
-        // - The device we used for creating the gem object is passed as &drm::Device<T::Driver> to
-        //   Object::<T>::new(), so we know that `T::Driver` is the right generic parameter to use
-        //   here.
-        // - Any type invariants of `Ctx` are upheld by using the same `Ctx` for the `Device` we
-        //   return.
-        unsafe { drm::Device::from_raw((*self.as_raw()).dev) }
-    }
-
-    fn as_raw(&self) -> *mut bindings::drm_gem_object {
-        self.obj.get()
-    }
-
-    extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
-        let ptr: *mut Opaque<bindings::drm_gem_object> = obj.cast();
-
-        // SAFETY: All of our objects are of type `Object<T>`.
-        let this = unsafe { crate::container_of!(ptr, Self, obj) };
-
-        // SAFETY: The C code only ever calls this callback with a valid pointer to a `struct
-        // drm_gem_object`.
-        unsafe { bindings::drm_gem_object_release(obj) };
-
-        // SAFETY: All of our objects are allocated via `KBox`, and we're in the
-        // free callback which guarantees this object has zero remaining references,
-        // so we can drop it.
-        let _ = unsafe { KBox::from_raw(this) };
-    }
 }
 
 impl_aref_for_gem_obj! {
-    impl<T, C> for Object<T, C>
+    impl<T> for Object<T>
     where
-        T: DriverObject,
-        C: DeviceContext
+        T: DriverObject
 }
 
 impl<T: DriverObject, Ctx: DeviceContext> super::private::Sealed for Object<T, Ctx> {}
diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 5ffa1355ecf2..cf8410e0f228 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -73,17 +73,17 @@
 ///
 /// This is used with [`Object::new()`] to control various properties that can only be set when
 /// initially creating a shmem-backed GEM object.
-pub struct ObjectConfig<'a, T: DriverObject, C: DeviceContext = Normal> {
+pub struct ObjectConfig<'a, T: DriverObject> {
     /// Whether to set the write-combine map flag.
     pub map_wc: bool,
 
     /// Reuse the DMA reservation from another GEM object.
     ///
     /// The newly created [`Object`] will hold an owned refcount to `parent_resv_obj` if specified.
-    pub parent_resv_obj: Option<&'a Object<T, C>>,
+    pub parent_resv_obj: Option<&'a Object<T>>,
 }
 
-impl<'a, T: DriverObject, C: DeviceContext> Default for ObjectConfig<'a, T, C> {
+impl<'a, T: DriverObject> Default for ObjectConfig<'a, T> {
     #[inline(always)]
     fn default() -> Self {
         Self {
@@ -106,7 +106,7 @@ pub struct Object<T: DriverObject, C: DeviceContext = Normal> {
     #[pin]
     obj: Opaque<bindings::drm_gem_shmem_object>,
     /// Parent object that owns this object's DMA reservation object.
-    parent_resv_obj: Option<ARef<Object<T, C>>>,
+    parent_resv_obj: Option<ARef<Object<T>>>,
     /// Devres object for unmapping any SGTable on driver-unbind.
     sgt_res: ManuallyDrop<SetOnce<Devres<SGTableMap<T, C>>>>,
     #[pin]
@@ -118,10 +118,9 @@ pub struct Object<T: DriverObject, C: DeviceContext = Normal> {
 }
 
 super::impl_aref_for_gem_obj! {
-    impl<T, C> for Object<T, C>
+    impl<T> for Object<T>
     where
-        T: DriverObject,
-        C: DeviceContext
+        T: DriverObject
 }
 
 // SAFETY: All GEM objects are thread-safe.
@@ -157,54 +156,6 @@ fn as_raw_shmem(&self) -> *mut bindings::drm_gem_shmem_object {
         self.obj.get()
     }
 
-    /// Create a new shmem-backed DRM object of the given size.
-    ///
-    /// Additional config options can be specified using `config`.
-    pub fn new(
-        dev: &Device<T::Driver, C>,
-        size: usize,
-        config: ObjectConfig<'_, T, C>,
-        args: T::Args,
-    ) -> Result<ARef<Self>> {
-        let new: Pin<KBox<Self>> = KBox::try_pin_init(
-            try_pin_init!(Self {
-                obj <- Opaque::init_zeroed(),
-                parent_resv_obj: config.parent_resv_obj.map(|p| p.into()),
-                sgt_res: ManuallyDrop::new(SetOnce::new()),
-                sgt_lock <- new_mutex!(()),
-                inner <- T::new(dev, size, args),
-                _ctx: PhantomData::<C>,
-            }),
-            GFP_KERNEL,
-        )?;
-
-        // SAFETY: `obj.as_raw()` is guaranteed to be valid by the initialization above.
-        unsafe { (*new.as_raw()).funcs = &Self::VTABLE };
-
-        // SAFETY: The arguments are all valid via the type invariants.
-        to_result(unsafe { bindings::drm_gem_shmem_init(dev.as_raw(), new.as_raw_shmem(), size) })?;
-
-        // SAFETY: We never move out of `self`.
-        let new = KBox::into_raw(unsafe { Pin::into_inner_unchecked(new) });
-
-        // SAFETY: We're taking over the owned refcount from `drm_gem_shmem_init`.
-        let obj = unsafe { ARef::from_raw(NonNull::new_unchecked(new)) };
-
-        // Start filling out values from `config`
-        if let Some(parent_resv) = config.parent_resv_obj {
-            // SAFETY: We have yet to expose the new gem object outside of this function, so it is
-            // safe to modify this field.
-            unsafe { (*obj.obj.get()).base.resv = parent_resv.raw_dma_resv() };
-        }
-
-        // SAFETY: We have yet to expose this object outside of this function, so we're guaranteed
-        // to have exclusive access - thus making this safe to hold a mutable reference to.
-        let shmem = unsafe { &mut *obj.as_raw_shmem() };
-        shmem.set_map_wc(config.map_wc);
-
-        Ok(obj)
-    }
-
     /// Returns the `Device` that owns this GEM object.
     pub fn dev(&self) -> &Device<T::Driver, C> {
         // SAFETY: `dev` will have been initialized in `Self::new()` by `drm_gem_shmem_init()`.
@@ -308,12 +259,6 @@ pub fn vmap<const SIZE: usize>(&self) -> Result<VMapRef<'_, T, C, SIZE>> {
         self.make_vmap()
     }
 
-    /// Creates and returns an owned reference to a virtual kernel memory mapping for this object.
-    #[inline]
-    pub fn owned_vmap<const SIZE: usize>(&self) -> Result<VMapOwned<T, C, SIZE>> {
-        self.make_vmap()
-    }
-
     /// Creates (if necessary) and returns an immutable reference to a scatter-gather table of DMA
     /// pages for this object.
     ///
@@ -355,6 +300,62 @@ pub fn sg_table<'a>(
     }
 }
 
+impl<T: DriverObject> Object<T> {
+    /// Create a new shmem-backed DRM object of the given size.
+    ///
+    /// Additional config options can be specified using `config`.
+    pub fn new(
+        dev: &Device<T::Driver>,
+        size: usize,
+        config: ObjectConfig<'_, T>,
+        args: T::Args,
+    ) -> Result<ARef<Self>> {
+        let new: Pin<KBox<Self>> = KBox::try_pin_init(
+            try_pin_init!(Self {
+                obj <- Opaque::init_zeroed(),
+                parent_resv_obj: config.parent_resv_obj.map(|p| p.into()),
+                sgt_res: ManuallyDrop::new(SetOnce::new()),
+                sgt_lock <- new_mutex!(()),
+                inner <- T::new(dev, size, args),
+                _ctx: PhantomData,
+            }),
+            GFP_KERNEL,
+        )?;
+
+        // SAFETY: `obj.as_raw()` is guaranteed to be valid by the initialization above.
+        unsafe { (*new.as_raw()).funcs = &Self::VTABLE };
+
+        // SAFETY: The arguments are all valid via the type invariants.
+        to_result(unsafe { bindings::drm_gem_shmem_init(dev.as_raw(), new.as_raw_shmem(), size) })?;
+
+        // SAFETY: We never move out of `self`.
+        let new = KBox::into_raw(unsafe { Pin::into_inner_unchecked(new) });
+
+        // SAFETY: We're taking over the owned refcount from `drm_gem_shmem_init`.
+        let obj = unsafe { ARef::from_raw(NonNull::new_unchecked(new)) };
+
+        // Start filling out values from `config`
+        if let Some(parent_resv) = config.parent_resv_obj {
+            // SAFETY: We have yet to expose the new gem object outside of this function, so it is
+            // safe to modify this field.
+            unsafe { (*obj.obj.get()).base.resv = parent_resv.raw_dma_resv() };
+        }
+
+        // SAFETY: We have yet to expose this object outside of this function, so we're guaranteed
+        // to have exclusive access - thus making this safe to hold a mutable reference to.
+        let shmem = unsafe { &mut *obj.as_raw_shmem() };
+        shmem.set_map_wc(config.map_wc);
+
+        Ok(obj)
+    }
+
+    /// Creates and returns an owned reference to a virtual kernel memory mapping for this object.
+    #[inline]
+    pub fn owned_vmap<const SIZE: usize>(&self) -> Result<VMapOwned<T, Normal, SIZE>> {
+        self.make_vmap()
+    }
+}
+
 impl<T: DriverObject, C: DeviceContext> Deref for Object<T, C> {
     type Target = T;
 
@@ -670,8 +671,8 @@ impl gem::DriverObject for KunitObject {
         type Driver = KunitDriver;
         type Args = ();
 
-        fn new<C: DeviceContext>(
-            _dev: &drm::Device<KunitDriver, C>,
+        fn new(
+            _dev: &drm::Device<KunitDriver>,
             _size: usize,
             _args: Self::Args,
         ) -> impl PinInit<Self, Error> {
@@ -683,7 +684,7 @@ fn new<C: DeviceContext>(
     impl drm::Driver for KunitDriver {
         type Data = KunitData;
         type File = KunitFile;
-        type Object<Ctx: DeviceContext> = Object<KunitObject, Ctx>;
+        type Object = Object<KunitObject>;
         type ParentDevice<Ctx: device::DeviceContext> = faux::Device<Ctx>;
 
         const INFO: drm::DriverInfo = INFO;
-- 
2.54.0

