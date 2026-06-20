Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67295CD98FA
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 00:59:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C1110E14C;
	Sat, 20 Jun 2026 00:59:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ePK7IbV0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2095A10E14C
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 00:59:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8920C601E3;
 Sat, 20 Jun 2026 00:59:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364871F00A3D;
 Sat, 20 Jun 2026 00:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781917163;
 bh=GX4iUgICOl9WSpPYr949LtTq59N3lfYURqZfRtVaF84=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ePK7IbV0IfOtQQM1rgASdrTR9AYpcxMa1WN7DurIt1bO7+AedNC1MlAkhsDwCKLNq
 T5abrxpV/DogDwarlsmJWV1pzuu8FqgEX1dC/RANwTDZayH3S0zHNI6KNbCISqayCt
 JyNm1odfOaA5qplYov/wI6uSK5LAuXpfZX/MWochPDFO9i1axIOqRrXRx7su5eIenj
 1lkPyu+n1ZnxCRFw2OALKCbR+SF1h7mgx5bjdSKAZAnRv+st8NiTX8XJogSFBo1WH2
 xigf9rMED+AQNfXFCv4CGHiXI7/SgSbNA2c0WQsYaxIECoveRuB86t4ybxRIQQUptT
 qKlPiJayRTw5w==
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
Subject: [PATCH v3 05/13] rust: drm: restrict AlwaysRefCounted to Normal GEM
 Object context
Date: Sat, 20 Jun 2026 02:51:17 +0200
Message-ID: <20260620005431.1562115-6-dakr@kernel.org>
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

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs |  2 +-
 drivers/gpu/drm/nova/gem.rs    | 18 +++----
 drivers/gpu/drm/tyr/driver.rs  |  2 +-
 drivers/gpu/drm/tyr/gem.rs     | 11 +---
 rust/kernel/drm/device.rs      | 14 ++---
 rust/kernel/drm/driver.rs      |  2 +-
 rust/kernel/drm/gem/mod.rs     | 97 ++++++++++++++++------------------
 rust/kernel/drm/gem/shmem.rs   | 75 +++++++++++++-------------
 8 files changed, 103 insertions(+), 118 deletions(-)

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
index f47a90cdb95b..146e8cfc2cdf 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -43,14 +43,14 @@
 /// This is used with [`Object::new()`] to control various properties that can only be set when
 /// initially creating a shmem-backed GEM object.
 #[derive(Default)]
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
 
 /// A shmem-backed GEM object.
@@ -66,17 +66,16 @@ pub struct Object<T: DriverObject, C: DeviceContext = Normal> {
     #[pin]
     obj: Opaque<bindings::drm_gem_shmem_object>,
     /// Parent object that owns this object's DMA reservation object.
-    parent_resv_obj: Option<ARef<Object<T, C>>>,
+    parent_resv_obj: Option<ARef<Object<T>>>,
     #[pin]
     inner: T,
     _ctx: PhantomData<C>,
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
@@ -112,13 +111,43 @@ fn as_raw_shmem(&self) -> *mut bindings::drm_gem_shmem_object {
         self.obj.get()
     }
 
+    /// Returns the `Device` that owns this GEM object.
+    pub fn dev(&self) -> &Device<T::Driver, C> {
+        // SAFETY: `dev` will have been initialized in `Self::new()` by `drm_gem_shmem_init()`.
+        unsafe { Device::from_raw((*self.as_raw()).dev) }
+    }
+
+    extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
+        // SAFETY:
+        // - DRM always passes a valid gem object here
+        // - We used drm_gem_shmem_create() in our create_gem_object callback, so we know that
+        //   `obj` is contained within a drm_gem_shmem_object
+        let this = unsafe { container_of!(obj, bindings::drm_gem_shmem_object, base) };
+
+        // SAFETY:
+        // - We're in free_callback - so this function is safe to call.
+        // - We won't be using the gem resources on `this` after this call.
+        unsafe { bindings::drm_gem_shmem_release(this) };
+
+        // SAFETY:
+        // - We verified above that `obj` is valid, which makes `this` valid
+        // - This function is set in AllocOps, so we know that `this` is contained within a
+        //   `Object<T, C>`
+        let this = unsafe { container_of!(Opaque::cast_from(this), Self, obj) }.cast_mut();
+
+        // SAFETY: We're recovering the Kbox<> we created in gem_create_object()
+        let _ = unsafe { KBox::from_raw(this) };
+    }
+}
+
+impl<T: DriverObject> Object<T> {
     /// Create a new shmem-backed DRM object of the given size.
     ///
     /// Additional config options can be specified using `config`.
     pub fn new(
-        dev: &Device<T::Driver, C>,
+        dev: &Device<T::Driver>,
         size: usize,
-        config: ObjectConfig<'_, T, C>,
+        config: ObjectConfig<'_, T>,
         args: T::Args,
     ) -> Result<ARef<Self>> {
         let new: Pin<KBox<Self>> = KBox::try_pin_init(
@@ -126,7 +155,7 @@ pub fn new(
                 obj <- Opaque::init_zeroed(),
                 parent_resv_obj: config.parent_resv_obj.map(|p| p.into()),
                 inner <- T::new(dev, size, args),
-                _ctx: PhantomData::<C>,
+                _ctx: PhantomData,
             }),
             GFP_KERNEL,
         )?;
@@ -157,34 +186,6 @@ pub fn new(
 
         Ok(obj)
     }
-
-    /// Returns the `Device` that owns this GEM object.
-    pub fn dev(&self) -> &Device<T::Driver, C> {
-        // SAFETY: `dev` will have been initialized in `Self::new()` by `drm_gem_shmem_init()`.
-        unsafe { Device::from_raw((*self.as_raw()).dev) }
-    }
-
-    extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
-        // SAFETY:
-        // - DRM always passes a valid gem object here
-        // - We used drm_gem_shmem_create() in our create_gem_object callback, so we know that
-        //   `obj` is contained within a drm_gem_shmem_object
-        let this = unsafe { container_of!(obj, bindings::drm_gem_shmem_object, base) };
-
-        // SAFETY:
-        // - We're in free_callback - so this function is safe to call.
-        // - We won't be using the gem resources on `this` after this call.
-        unsafe { bindings::drm_gem_shmem_release(this) };
-
-        // SAFETY:
-        // - We verified above that `obj` is valid, which makes `this` valid
-        // - This function is set in AllocOps, so we know that `this` is contained within a
-        //   `Object<T, C>`
-        let this = unsafe { container_of!(Opaque::cast_from(this), Self, obj) }.cast_mut();
-
-        // SAFETY: We're recovering the Kbox<> we created in gem_create_object()
-        let _ = unsafe { KBox::from_raw(this) };
-    }
 }
 
 impl<T: DriverObject, C: DeviceContext> Deref for Object<T, C> {
-- 
2.54.0

