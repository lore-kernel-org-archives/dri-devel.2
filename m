Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1841ACD37AA
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 22:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DD4510F297;
	Thu,  7 May 2026 22:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fhoLEicR";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EA1810F2A7
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 22:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778191283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnPQLVQuDWoemQfMgfHmwxba2NCe19UHVOC9hBnD750=;
 b=fhoLEicR6hSsmv112nnTfWZC6XUKZloZIoxBErMmdn63ng+dS7VeoLWCB7HCXwZW6gSEAA
 6Mq23k1MP2clKngkKMHSWq4cBbWUOjbo2WIrSaBj9XGFns6EjYuBKLsOU3oAy9c1gOObmD
 tIsu3kuiT7ARmBB148V6nbUTyUgkaS8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-218-pi9JpxQmNKi-_jq2r3zi4g-1; Thu,
 07 May 2026 18:01:19 -0400
X-MC-Unique: pi9JpxQmNKi-_jq2r3zi4g-1
X-Mimecast-MFC-AGG-ID: pi9JpxQmNKi-_jq2r3zi4g_1778191277
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35D611956094; Thu,  7 May 2026 22:01:17 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.165])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 112D83002D2F; Thu,  7 May 2026 22:01:14 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Cc: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Alice Ryhl" <aliceryhl@google.com>,
 Nova-gpu@lists.linux.dev, "Shankari Anand" <shankari.ak0208@gmail.com>,
 "David Airlie" <airlied@gmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>,
 "Asahi Lina" <lina+kernel@asahilina.net>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Lyude Paul" <lyude@redhat.com>
Subject: [PATCH v6 3/3] rust/drm/gem: Use DeviceContext with GEM objects
Date: Thu,  7 May 2026 17:59:21 -0400
Message-ID: <20260507220044.3204919-4-lyude@redhat.com>
In-Reply-To: <20260507220044.3204919-1-lyude@redhat.com>
References: <20260507220044.3204919-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: sLhIEp7ymRl0lnD1fVOftNu8cm76N652ACU96ahdmKw_1778191277
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Now that we have the ability to represent the context in which a DRM device
is in at compile-time, we can start carrying around this context with GEM
object types in order to allow a driver to safely create GEM objects before
a DRM device has registered with userspace.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

---
V4:
* Add a comment to explain the Uninit DeviceContext usage in the GEM object
  vtable (tl;dr: the DeviceContext is meaningless here)
V5:
* Improve invariant comment above drm_gem_object_init()
V6:
* Rebase

 drivers/gpu/drm/nova/driver.rs |  2 +-
 drivers/gpu/drm/nova/gem.rs    | 15 +++++---
 drivers/gpu/drm/tyr/driver.rs  |  2 +-
 drivers/gpu/drm/tyr/gem.rs     | 11 ++++--
 rust/kernel/drm/device.rs      | 18 ++++++----
 rust/kernel/drm/driver.rs      |  2 +-
 rust/kernel/drm/gem/mod.rs     | 65 +++++++++++++++++++++++-----------
 rust/kernel/drm/gem/shmem.rs   | 57 +++++++++++++++++------------
 8 files changed, 113 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 99d6841b69cbc..3e0647dcfe981 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -67,7 +67,7 @@ fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<S
 impl drm::Driver for NovaDriver {
     type Data = NovaData;
     type File = File;
-    type Object = gem::Object<NovaObject>;
+    type Object<Ctx: drm::DeviceContext> = gem::Object<NovaObject, Ctx>;
 
     const INFO: drm::DriverInfo = INFO;
 
diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
index e073e174e2578..9d8ff7de2c0f7 100644
--- a/drivers/gpu/drm/nova/gem.rs
+++ b/drivers/gpu/drm/nova/gem.rs
@@ -2,7 +2,7 @@
 
 use kernel::{
     drm,
-    drm::{gem, gem::BaseObject},
+    drm::{gem, gem::BaseObject, DeviceContext},
     page,
     prelude::*,
     sync::aref::ARef,
@@ -21,20 +21,27 @@ impl gem::DriverObject for NovaObject {
     type Driver = NovaDriver;
     type Args = ();
 
-    fn new(_dev: &NovaDevice, _size: usize, _args: Self::Args) -> impl PinInit<Self, Error> {
+    fn new<Ctx: DeviceContext>(
+        _dev: &NovaDevice<Ctx>,
+        _size: usize,
+        _args: Self::Args,
+    ) -> impl PinInit<Self, Error> {
         try_pin_init!(NovaObject {})
     }
 }
 
 impl NovaObject {
     /// Create a new DRM GEM object.
-    pub(crate) fn new(dev: &NovaDevice, size: usize) -> Result<ARef<gem::Object<Self>>> {
+    pub(crate) fn new<Ctx: DeviceContext>(
+        dev: &NovaDevice<Ctx>,
+        size: usize,
+    ) -> Result<ARef<gem::Object<Self, Ctx>>> {
         if size == 0 {
             return Err(EINVAL);
         }
         let aligned_size = page::page_align(size).ok_or(EINVAL)?;
 
-        gem::Object::new(dev, aligned_size, ())
+        gem::Object::<Self, Ctx>::new(dev, aligned_size, ())
     }
 
     /// Look up a GEM object handle for a `File` and return an `ObjectRef` for it.
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 4f96c8f761895..756a93210fc95 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -185,7 +185,7 @@ fn drop(self: Pin<&mut Self>) {}
 impl drm::Driver for TyrDrmDriver {
     type Data = TyrDrmDeviceData;
     type File = TyrDrmFileData;
-    type Object = drm::gem::shmem::Object<BoData>;
+    type Object<R: drm::DeviceContext> = drm::gem::shmem::Object<BoData, R>;
 
     const INFO: drm::DriverInfo = INFO;
 
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 1640a161754b2..c6d4d6f9bae39 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -5,7 +5,10 @@
 //! DRM's GEM subsystem with shmem backing.
 
 use kernel::{
-    drm::gem,
+    drm::{
+        gem,
+        DeviceContext, //
+    },
     prelude::*, //
 };
 
@@ -30,7 +33,11 @@ impl gem::DriverObject for BoData {
     type Driver = TyrDrmDriver;
     type Args = BoCreateArgs;
 
-    fn new(_dev: &TyrDrmDevice, _size: usize, args: BoCreateArgs) -> impl PinInit<Self, Error> {
+    fn new<Ctx: DeviceContext>(
+        _dev: &TyrDrmDevice<Ctx>,
+        _size: usize,
+        args: BoCreateArgs,
+    ) -> impl PinInit<Self, Error> {
         try_pin_init!(Self { flags: args.flags })
     }
 }
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 27a52a270be66..e0864ed843075 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -167,13 +167,17 @@ impl<T: drm::Driver> UnregisteredDevice<T> {
         master_set: None,
         master_drop: None,
         debugfs_init: None,
-        gem_create_object: T::Object::ALLOC_OPS.gem_create_object,
-        prime_handle_to_fd: T::Object::ALLOC_OPS.prime_handle_to_fd,
-        prime_fd_to_handle: T::Object::ALLOC_OPS.prime_fd_to_handle,
-        gem_prime_import: T::Object::ALLOC_OPS.gem_prime_import,
-        gem_prime_import_sg_table: T::Object::ALLOC_OPS.gem_prime_import_sg_table,
-        dumb_create: T::Object::ALLOC_OPS.dumb_create,
-        dumb_map_offset: T::Object::ALLOC_OPS.dumb_map_offset,
+
+        // Ignore the Uninit DeviceContext below. It is only provided because it is required by the
+        // compiler, and it is not actually used by these functions.
+        gem_create_object: T::Object::<Uninit>::ALLOC_OPS.gem_create_object,
+        prime_handle_to_fd: T::Object::<Uninit>::ALLOC_OPS.prime_handle_to_fd,
+        prime_fd_to_handle: T::Object::<Uninit>::ALLOC_OPS.prime_fd_to_handle,
+        gem_prime_import: T::Object::<Uninit>::ALLOC_OPS.gem_prime_import,
+        gem_prime_import_sg_table: T::Object::<Uninit>::ALLOC_OPS.gem_prime_import_sg_table,
+        dumb_create: T::Object::<Uninit>::ALLOC_OPS.dumb_create,
+        dumb_map_offset: T::Object::<Uninit>::ALLOC_OPS.dumb_map_offset,
+
         show_fdinfo: None,
         fbdev_probe: None,
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 55b01ee088548..294e17af86a32 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -109,7 +109,7 @@ pub trait Driver {
     type Data: Sync + Send;
 
     /// The type used to manage memory for this driver.
-    type Object: AllocImpl;
+    type Object<Ctx: drm::DeviceContext>: AllocImpl;
 
     /// The type used to represent a DRM File (client)
     type File: drm::file::DriverFile;
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index 568b5c08019e7..d91e01e897c4d 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -8,6 +8,10 @@
     bindings,
     drm::{
         self,
+        device::{
+            DeviceContext,
+            Registered, //
+        },
         driver::{
             AllocImpl,
             AllocOps, //
@@ -22,6 +26,7 @@
     types::Opaque,
 };
 use core::{
+    marker::PhantomData,
     ops::Deref,
     ptr::NonNull, //
 };
@@ -76,7 +81,8 @@ unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
 /// A type alias for retrieving the current [`AllocImpl`] for a given [`DriverObject`].
 ///
 /// [`Driver`]: drm::Driver
-pub type DriverAllocImpl<T> = <<T as DriverObject>::Driver as drm::Driver>::Object;
+pub type DriverAllocImpl<T, Ctx = Registered> =
+    <<T as DriverObject>::Driver as drm::Driver>::Object<Ctx>;
 
 /// GEM object functions, which must be implemented by drivers.
 pub trait DriverObject: Sync + Send + Sized {
@@ -87,8 +93,8 @@ pub trait DriverObject: Sync + Send + Sized {
     type Args;
 
     /// Create a new driver data object for a GEM object of a given size.
-    fn new(
-        dev: &drm::Device<Self::Driver>,
+    fn new<Ctx: DeviceContext>(
+        dev: &drm::Device<Self::Driver, Ctx>,
         size: usize,
         args: Self::Args,
     ) -> impl PinInit<Self, Error>;
@@ -125,9 +131,12 @@ extern "C" fn open_callback<T: DriverObject>(
     // SAFETY: `open_callback` is only ever called with a valid pointer to a `struct drm_file`.
     let file = unsafe { DriverFile::<T>::from_raw(raw_file) };
 
-    // SAFETY: `open_callback` is specified in the AllocOps structure for `DriverObject<T>`,
-    // ensuring that `raw_obj` is contained within a `DriverObject<T>`
-    let obj = unsafe { <<T::Driver as drm::Driver>::Object as IntoGEMObject>::from_raw(raw_obj) };
+    // SAFETY:
+    // * `open_callback` is specified in the AllocOps structure for `DriverObject`, ensuring that
+    //   `raw_obj` is contained within a `DriverAllocImpl<T>`
+    // * It is only possible for `open_callback` to be called after device registration, ensuring
+    //   that the object's device is in the `Registered` state.
+    let obj: &DriverAllocImpl<T> = unsafe { IntoGEMObject::from_raw(raw_obj) };
 
     match T::open(obj, file) {
         Err(e) => e.to_errno(),
@@ -144,12 +153,12 @@ extern "C" fn close_callback<T: DriverObject>(
 
     // SAFETY: `close_callback` is specified in the AllocOps structure for `Object<T>`, ensuring
     // that `raw_obj` is indeed contained within a `Object<T>`.
-    let obj = unsafe { <<T::Driver as drm::Driver>::Object as IntoGEMObject>::from_raw(raw_obj) };
+    let obj: &DriverAllocImpl<T> = unsafe { IntoGEMObject::from_raw(raw_obj) };
 
     T::close(obj, file);
 }
 
-impl<T: DriverObject> IntoGEMObject for Object<T> {
+impl<T: DriverObject, Ctx: DeviceContext> IntoGEMObject for Object<T, Ctx> {
     fn as_raw(&self) -> *mut bindings::drm_gem_object {
         self.obj.get()
     }
@@ -157,7 +166,7 @@ fn as_raw(&self) -> *mut bindings::drm_gem_object {
     unsafe fn from_raw<'a>(self_ptr: *mut bindings::drm_gem_object) -> &'a Self {
         // SAFETY: `obj` is guaranteed to be in an `Object<T>` via the safety contract of this
         // function
-        unsafe { &*crate::container_of!(Opaque::cast_from(self_ptr), Object<T>, obj) }
+        unsafe { &*crate::container_of!(Opaque::cast_from(self_ptr), Object<T, Ctx>, obj) }
     }
 }
 
@@ -174,7 +183,7 @@ fn size(&self) -> usize {
     fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
     where
         Self: AllocImpl<Driver = D>,
-        D: drm::Driver<Object = Self, File = F>,
+        D: drm::Driver<Object<Registered> = Self, File = F>,
         F: drm::file::DriverFile<Driver = D>,
     {
         let mut handle: u32 = 0;
@@ -189,7 +198,7 @@ fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
     fn lookup_handle<D, F>(file: &drm::File<F>, handle: u32) -> Result<ARef<Self>>
     where
         Self: AllocImpl<Driver = D>,
-        D: drm::Driver<Object = Self, File = F>,
+        D: drm::Driver<Object<Registered> = Self, File = F>,
         F: drm::file::DriverFile<Driver = D>,
     {
         // SAFETY: The arguments are all valid per the type invariants.
@@ -241,16 +250,18 @@ impl<T: IntoGEMObject> BaseObjectPrivate for T {}
 ///
 /// # Invariants
 ///
-/// - `self.obj` is a valid instance of a `struct drm_gem_object`.
+/// * `self.obj` is a valid instance of a `struct drm_gem_object`.
+/// * Any type invariants of `Ctx` apply to the parent DRM device for this GEM object.
 #[repr(C)]
 #[pin_data]
-pub struct Object<T: DriverObject + Send + Sync> {
+pub struct Object<T: DriverObject + Send + Sync, Ctx: DeviceContext = Registered> {
     obj: Opaque<bindings::drm_gem_object>,
     #[pin]
     data: T,
+    _ctx: PhantomData<Ctx>,
 }
 
-impl<T: DriverObject> Object<T> {
+impl<T: DriverObject, Ctx: DeviceContext> Object<T, Ctx> {
     const OBJECT_FUNCS: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
         free: Some(Self::free_callback),
         open: Some(open_callback::<T>),
@@ -270,11 +281,16 @@ impl<T: DriverObject> Object<T> {
     };
 
     /// Create a new GEM object.
-    pub fn new(dev: &drm::Device<T::Driver>, size: usize, args: T::Args) -> Result<ARef<Self>> {
+    pub fn new(
+        dev: &drm::Device<T::Driver, Ctx>,
+        size: usize,
+        args: T::Args,
+    ) -> Result<ARef<Self>> {
         let obj: Pin<KBox<Self>> = KBox::pin_init(
             try_pin_init!(Self {
                 obj: Opaque::new(bindings::drm_gem_object::default()),
                 data <- T::new(dev, size, args),
+                _ctx: PhantomData,
             }),
             GFP_KERNEL,
         )?;
@@ -283,6 +299,8 @@ pub fn new(dev: &drm::Device<T::Driver>, size: usize, args: T::Args) -> Result<A
         unsafe { (*obj.as_raw()).funcs = &Self::OBJECT_FUNCS };
 
         // SAFETY: The arguments are all valid per the type invariants.
+        // INVARIANT: `dev` and the GEM object are in the same state at the moment, and upgrading
+        // the typestate in `dev` will not carry over to the GEM object.
         to_result(unsafe { bindings::drm_gem_object_init(dev.as_raw(), obj.obj.get(), size) })?;
 
         // SAFETY: We will never move out of `Self` as `ARef<Self>` is always treated as pinned.
@@ -296,13 +314,15 @@ pub fn new(dev: &drm::Device<T::Driver>, size: usize, args: T::Args) -> Result<A
     }
 
     /// Returns the `Device` that owns this GEM object.
-    pub fn dev(&self) -> &drm::Device<T::Driver> {
+    pub fn dev(&self) -> &drm::Device<T::Driver, Ctx> {
         // SAFETY:
         // - `struct drm_gem_object.dev` is initialized and valid for as long as the GEM
         //   object lives.
         // - The device we used for creating the gem object is passed as &drm::Device<T::Driver> to
         //   Object::<T>::new(), so we know that `T::Driver` is the right generic parameter to use
         //   here.
+        // - Any type invariants of `Ctx` are upheld by using the same `Ctx` for the `Device` we
+        //   return.
         unsafe { drm::Device::from_raw((*self.as_raw()).dev) }
     }
 
@@ -327,11 +347,16 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
     }
 }
 
-impl_aref_for_gem_obj!(impl<T> for Object<T> where T: DriverObject);
+impl_aref_for_gem_obj! {
+    impl<T, C> for Object<T, C>
+    where
+        T: DriverObject,
+        C: DeviceContext
+}
 
-impl<T: DriverObject> super::private::Sealed for Object<T> {}
+impl<T: DriverObject, Ctx: DeviceContext> super::private::Sealed for Object<T, Ctx> {}
 
-impl<T: DriverObject> Deref for Object<T> {
+impl<T: DriverObject, Ctx: DeviceContext> Deref for Object<T, Ctx> {
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
@@ -339,7 +364,7 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<T: DriverObject> AllocImpl for Object<T> {
+impl<T: DriverObject, Ctx: DeviceContext> AllocImpl for Object<T, Ctx> {
     type Driver = T::Driver;
 
     const ALLOC_OPS: AllocOps = AllocOps {
diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index e1b648920d2f6..e6ba17459fb73 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -15,7 +15,9 @@
         device,
         driver,
         gem,
-        private::Sealed, //
+        private::Sealed,
+        DeviceContext,
+        Registered, //
     },
     error::to_result,
     prelude::*,
@@ -23,11 +25,12 @@
     types::Opaque, //
 };
 use core::{
+    marker::PhantomData,
     ops::{
         Deref,
         DerefMut, //
     },
-    ptr::NonNull,
+    ptr::NonNull, //
 };
 use gem::{
     BaseObjectPrivate,
@@ -40,42 +43,49 @@
 /// This is used with [`Object::new()`] to control various properties that can only be set when
 /// initially creating a shmem-backed GEM object.
 #[derive(Default)]
-pub struct ObjectConfig<'a, T: DriverObject> {
+pub struct ObjectConfig<'a, T: DriverObject, C: DeviceContext = Registered> {
     /// Whether to set the write-combine map flag.
     pub map_wc: bool,
 
     /// Reuse the DMA reservation from another GEM object.
     ///
     /// The newly created [`Object`] will hold an owned refcount to `parent_resv_obj` if specified.
-    pub parent_resv_obj: Option<&'a Object<T>>,
+    pub parent_resv_obj: Option<&'a Object<T, C>>,
 }
 
 /// A shmem-backed GEM object.
 ///
 /// # Invariants
 ///
-/// `obj` contains a valid initialized `struct drm_gem_shmem_object` for the lifetime of this
-/// object.
+/// - `obj` contains a valid initialized `struct drm_gem_shmem_object` for the lifetime of this
+///   object.
+/// - Any type invariants of `C` apply to the parent DRM device for this GEM object.
 #[repr(C)]
 #[pin_data]
-pub struct Object<T: DriverObject> {
+pub struct Object<T: DriverObject, C: DeviceContext = Registered> {
     #[pin]
     obj: Opaque<bindings::drm_gem_shmem_object>,
     /// Parent object that owns this object's DMA reservation object.
-    parent_resv_obj: Option<ARef<Object<T>>>,
+    parent_resv_obj: Option<ARef<Object<T, C>>>,
     #[pin]
     inner: T,
+    _ctx: PhantomData<C>,
 }
 
-super::impl_aref_for_gem_obj!(impl<T> for Object<T> where T: DriverObject);
+super::impl_aref_for_gem_obj! {
+    impl<T, C> for Object<T, C>
+    where
+        T: DriverObject,
+        C: DeviceContext
+}
 
 // SAFETY: All GEM objects are thread-safe.
-unsafe impl<T: DriverObject> Send for Object<T> {}
+unsafe impl<T: DriverObject, C: DeviceContext> Send for Object<T, C> {}
 
 // SAFETY: All GEM objects are thread-safe.
-unsafe impl<T: DriverObject> Sync for Object<T> {}
+unsafe impl<T: DriverObject, C: DeviceContext> Sync for Object<T, C> {}
 
-impl<T: DriverObject> Object<T> {
+impl<T: DriverObject, C: DeviceContext> Object<T, C> {
     /// `drm_gem_object_funcs` vtable suitable for GEM shmem objects.
     const VTABLE: bindings::drm_gem_object_funcs = bindings::drm_gem_object_funcs {
         free: Some(Self::free_callback),
@@ -106,9 +116,9 @@ fn as_raw_shmem(&self) -> *mut bindings::drm_gem_shmem_object {
     ///
     /// Additional config options can be specified using `config`.
     pub fn new(
-        dev: &device::Device<T::Driver>,
+        dev: &device::Device<T::Driver, C>,
         size: usize,
-        config: ObjectConfig<'_, T>,
+        config: ObjectConfig<'_, T, C>,
         args: T::Args,
     ) -> Result<ARef<Self>> {
         let new: Pin<KBox<Self>> = KBox::try_pin_init(
@@ -116,6 +126,7 @@ pub fn new(
                 obj <- Opaque::init_zeroed(),
                 parent_resv_obj: config.parent_resv_obj.map(|p| p.into()),
                 inner <- T::new(dev, size, args),
+                _ctx: PhantomData::<C>,
             }),
             GFP_KERNEL,
         )?;
@@ -148,7 +159,7 @@ pub fn new(
     }
 
     /// Returns the `Device` that owns this GEM object.
-    pub fn dev(&self) -> &device::Device<T::Driver> {
+    pub fn dev(&self) -> &device::Device<T::Driver, C> {
         // SAFETY: `dev` will have been initialized in `Self::new()` by `drm_gem_shmem_init()`.
         unsafe { device::Device::from_raw((*self.as_raw()).dev) }
     }
@@ -168,7 +179,7 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
         // SAFETY:
         // - We verified above that `obj` is valid, which makes `this` valid
         // - This function is set in AllocOps, so we know that `this` is contained within a
-        //   `Object<T>`
+        //   `Object<T, C>`
         let this = unsafe { container_of!(Opaque::cast_from(this), Self, obj) }.cast_mut();
 
         // SAFETY: We're recovering the Kbox<> we created in gem_create_object()
@@ -176,7 +187,7 @@ extern "C" fn free_callback(obj: *mut bindings::drm_gem_object) {
     }
 }
 
-impl<T: DriverObject> Deref for Object<T> {
+impl<T: DriverObject, C: DeviceContext> Deref for Object<T, C> {
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
@@ -184,15 +195,15 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<T: DriverObject> DerefMut for Object<T> {
+impl<T: DriverObject, C: DeviceContext> DerefMut for Object<T, C> {
     fn deref_mut(&mut self) -> &mut Self::Target {
         &mut self.inner
     }
 }
 
-impl<T: DriverObject> Sealed for Object<T> {}
+impl<T: DriverObject, C: DeviceContext> Sealed for Object<T, C> {}
 
-impl<T: DriverObject> gem::IntoGEMObject for Object<T> {
+impl<T: DriverObject, C: DeviceContext> gem::IntoGEMObject for Object<T, C> {
     fn as_raw(&self) -> *mut bindings::drm_gem_object {
         // SAFETY:
         // - Our immutable reference is proof that this is safe to dereference.
@@ -200,18 +211,18 @@ fn as_raw(&self) -> *mut bindings::drm_gem_object {
         unsafe { &raw mut (*self.obj.get()).base }
     }
 
-    unsafe fn from_raw<'a>(obj: *mut bindings::drm_gem_object) -> &'a Object<T> {
+    unsafe fn from_raw<'a>(obj: *mut bindings::drm_gem_object) -> &'a Self {
         // SAFETY: The safety contract of from_gem_obj() guarantees that `obj` is contained within
         // `Self`
         unsafe {
             let obj = Opaque::cast_from(container_of!(obj, bindings::drm_gem_shmem_object, base));
 
-            &*container_of!(obj, Object<T>, obj)
+            &*container_of!(obj, Self, obj)
         }
     }
 }
 
-impl<T: DriverObject> driver::AllocImpl for Object<T> {
+impl<T: DriverObject, C: DeviceContext> driver::AllocImpl for Object<T, C> {
     type Driver = T::Driver;
 
     const ALLOC_OPS: driver::AllocOps = driver::AllocOps {
-- 
2.54.0

