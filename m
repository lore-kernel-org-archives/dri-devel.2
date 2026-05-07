Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFEFCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 22:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8782B10F2B1;
	Thu,  7 May 2026 22:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="aua+AmYT";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0050A10F2A0
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 22:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778191282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1EZhmpzBVXcmphP1HLxd8IWryTlhPr7BVI8B51IqrY=;
 b=aua+AmYTSy9nfwIH/vzo3mbz5mvJCObT/6uAgVckWr8PnJj8fwhcpKlb8T1+ErpncU/Ji1
 CI9pjmznPnf7y2EoYyw4XLb9SYcHP6GBV5d03S79pNI0nsvwHlQk+t9HfVxQT/97+0iRJY
 t0R+2MBkt7bDIsX0FN8be/yppqW+PWU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-fTZGBgrIMzig8WhYMOy45g-1; Thu,
 07 May 2026 18:01:17 -0400
X-MC-Unique: fTZGBgrIMzig8WhYMOy45g-1
X-Mimecast-MFC-AGG-ID: fTZGBgrIMzig8WhYMOy45g_1778191272
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0FAC4195608E; Thu,  7 May 2026 22:01:12 +0000 (UTC)
Received: from GoldenWind.lan (unknown [10.22.89.165])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5E6F3002D30; Thu,  7 May 2026 22:01:09 +0000 (UTC)
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
Subject: [PATCH v6 1/3] rust/drm: Introduce DeviceContext
Date: Thu,  7 May 2026 17:59:19 -0400
Message-ID: <20260507220044.3204919-2-lyude@redhat.com>
In-Reply-To: <20260507220044.3204919-1-lyude@redhat.com>
References: <20260507220044.3204919-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: h30yRw2RA2WrsLwfcNDW6iOQx_pH7N83UJhjpZJwZeA_1778191272
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

One of the tricky things about DRM bindings in Rust is the fact that
initialization of a DRM device is a multi-step process. It's quite normal
for a device driver to start making use of its DRM device for tasks like
creating GEM objects before userspace registration happens. This is an
issue in rust though, since prior to userspace registration the device is
only partly initialized. This means there's a plethora of DRM device
operations we can't yet expose without opening up the door to UB if the DRM
device in question isn't yet registered.

Additionally, this isn't something we can reliably check at runtime. And
even if we could, performing an operation which requires the device be
registered when the device isn't actually registered is a programmer bug,
meaning there's no real way to gracefully handle such a mistake at runtime.
And even if that wasn't the case, it would be horrendously annoying and
noisy to have to check if a device is registered constantly throughout a
driver.

In order to solve this, we first take inspiration from
`kernel::device::DeviceContext` and introduce `kernel::drm::DeviceContext`.
This provides us with a ZST type that we can generalize over to represent
contexts where a device is known to have been registered with userspace at
some point in time (`Registered`), along with contexts where we can't make
such a guarantee (`Uninit`).

It's important to note we intentionally do not provide a `DeviceContext`
which represents an unregistered device. This is because there's no
reasonable way to guarantee that a device with long-living references to
itself will not be registered eventually with userspace. Instead, we
provide a new-type for this: `UnregisteredDevice` which can
provide a guarantee that the `Device` has never been registered with
userspace. To ensure this, we modify `Registration` so that creating a new
`Registration` requires passing ownership of an `UnregisteredDevice`.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

---
V2:
* Make sure that `UnregisteredDevice` is not thread-safe (since DRM device
  initialization is also not thread-safe)
* Rename from AnyCtx to Uninit, I think this name actually makes a bit more
  sense.
* Change assume_registered() to assume_ctx()
  Since it looks like in some situations, we'll want to update the
  DeviceContext of a object to the latest DeviceContext we know the Device
  to be in.
* Rename Init to Uninit
  When we eventually add KMS support, we're going to have 3 different
  DeviceContexts - Uninit, Init, Registered. Additionally, aside from not
  being registered there are a number of portions of the rest of the Device
  which also aren't usable before at least the Init context - so the naming
  of Uninit makes this a little clearer.
* s/DeviceContext/DeviceContext/
  For consistency with the rest of the kernel
* Drop as_ref::<Device<T, Uninit>>() for now since I don't actually think
  we need this quite yet
V3:
* Get rid of drm_dev_ctx!, as we don't actually need to implement Send or
  Sync ourselves
* Remove mention of C function in drm::device::Registration rustdoc
* Add more documentation to the DeviceContext trait, go into detail about
  the various setup phases and such.
* Add missing period to comment in `UnregisteredDevice::new()`.
V4:
* Address some comments from Danilo I missed last round:
  * Remove leftover rebase detritus from new_foreign_owned()
    (the seemingly useless cast)
  * Remove no-op mention in Registered device context
V5:
* Fix incorrect size on Kmalloc (Deborah)
V6:
* Rebase

 drivers/gpu/drm/nova/driver.rs |   8 +-
 drivers/gpu/drm/tyr/driver.rs  |  10 +-
 rust/kernel/drm/device.rs      | 222 +++++++++++++++++++++++++--------
 rust/kernel/drm/driver.rs      |  35 ++++--
 rust/kernel/drm/mod.rs         |   4 +
 5 files changed, 214 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index b1af0a099551d..99d6841b69cbc 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -21,7 +21,7 @@ pub(crate) struct NovaDriver {
 }
 
 /// Convienence type alias for the DRM device type for this driver
-pub(crate) type NovaDevice = drm::Device<NovaDriver>;
+pub(crate) type NovaDevice<Ctx = drm::Registered> = drm::Device<NovaDriver, Ctx>;
 
 #[pin_data]
 pub(crate) struct NovaData {
@@ -56,10 +56,10 @@ impl auxiliary::Driver for NovaDriver {
     fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
         let data = try_pin_init!(NovaData { adev: adev.into() });
 
-        let drm = drm::Device::<Self>::new(adev.as_ref(), data)?;
-        drm::Registration::new_foreign_owned(&drm, adev.as_ref(), 0)?;
+        let drm = drm::UnregisteredDevice::<Self>::new(adev.as_ref(), data)?;
+        let drm = drm::Registration::new_foreign_owned(drm, adev.as_ref(), 0)?;
 
-        Ok(Self { drm })
+        Ok(Self { drm: drm.into() })
     }
 }
 
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index e20a5978eed6d..4f96c8f761895 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -49,7 +49,7 @@
 pub(crate) struct TyrDrmDriver;
 
 /// Convenience type alias for the DRM device type for this driver.
-pub(crate) type TyrDrmDevice = drm::Device<TyrDrmDriver>;
+pub(crate) type TyrDrmDevice<Ctx = drm::Registered> = drm::Device<TyrDrmDriver, Ctx>;
 
 #[pin_data(PinnedDrop)]
 pub(crate) struct TyrPlatformDriverData {
@@ -152,10 +152,12 @@ fn probe(
                 gpu_info,
         });
 
-        let ddev: ARef<TyrDrmDevice> = drm::Device::new(pdev.as_ref(), data)?;
-        drm::driver::Registration::new_foreign_owned(&ddev, pdev.as_ref(), 0)?;
+        let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev.as_ref(), data)?;
+        let tdev = drm::driver::Registration::new_foreign_owned(tdev, pdev.as_ref(), 0)?;
 
-        let driver = TyrPlatformDriverData { _device: ddev };
+        let driver = TyrPlatformDriverData {
+            _device: tdev.into(),
+        };
 
         // We need this to be dev_info!() because dev_dbg!() does not work at
         // all in Rust for now, and we need to see whether probe succeeded.
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index adbafe8db54d1..27a52a270be66 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -6,10 +6,12 @@
 
 use crate::{
     alloc::allocator::Kmalloc,
-    bindings, device,
+    bindings,
+    device,
     drm::{
         self,
-        driver::AllocImpl, //
+        driver::AllocImpl,
+        private::Sealed, //
     },
     error::from_err_ptr,
     prelude::*,
@@ -17,16 +19,20 @@
         ARef,
         AlwaysRefCounted, //
     },
-    types::Opaque,
+    types::{
+        NotThreadSafe,
+        Opaque, //
+    },
     workqueue::{
         HasDelayedWork,
         HasWork,
         Work,
         WorkItem, //
-    },
+    }, //
 };
 use core::{
     alloc::Layout,
+    marker::PhantomData,
     mem,
     ops::Deref,
     ptr::{
@@ -66,26 +72,98 @@ macro_rules! drm_legacy_fields {
     }
 }
 
-/// A typed DRM device with a specific `drm::Driver` implementation.
+/// A trait implemented by all possible contexts a [`Device`] can be used in.
+///
+/// Setting up a new [`Device`] is a multi-stage process. Each step of the process that a user
+/// interacts with in Rust has a respective [`DeviceContext`] typestate. For example,
+/// `Device<T, Registered>` would be a [`Device`] that reached the [`Registered`] [`DeviceContext`].
+///
+/// Each stage of this process is described below:
+///
+/// ```text
+///        1                     2                         3
+/// +--------------+   +------------------+   +-----------------------+
+/// |Device created| → |Device initialized| → |Registered w/ userspace|
+/// +--------------+   +------------------+   +-----------------------+
+///    (Uninit)                                      (Registered)
+/// ```
+///
+/// 1. The [`Device`] is in the [`Uninit`] context and is not guaranteed to be initialized or
+///    registered with userspace. Only a limited subset of DRM core functionality is available.
+/// 2. The [`Device`] is guaranteed to be fully initialized, but is not guaranteed to be registered
+///    with userspace. All DRM core functionality which doesn't interact with userspace is
+///    available. We currently don't have a context for representing this.
+/// 3. The [`Device`] is guaranteed to be fully initialized, and is guaranteed to have been
+///    registered with userspace at some point - thus putting it in the [`Registered`] context.
 ///
-/// The device is always reference-counted.
+/// An important caveat of [`DeviceContext`] which must be kept in mind: when used as a typestate
+/// for a reference type, it can only guarantee that a [`Device`] reached a particular stage in the
+/// initialization process _at the time the reference was taken_. No guarantee is made in regards to
+/// what stage of the process the [`Device`] is currently in. This means for instance that a
+/// `&Device<T, Uninit>` may actually be registered with userspace, it just wasn't known to be
+/// registered at the time the reference was taken.
+pub trait DeviceContext: Sealed + Send + Sync {}
+
+/// The [`DeviceContext`] of a [`Device`] that was registered with userspace at some point.
+///
+/// This represents a [`Device`] which is guaranteed to have been registered with userspace at
+/// some point in time. Such a DRM device is guaranteed to have been fully-initialized.
+///
+/// Note: A device in this context is not guaranteed to remain registered with userspace for its
+/// entire lifetime, as this is impossible to guarantee at compile-time.
 ///
 /// # Invariants
 ///
-/// `self.dev` is a valid instance of a `struct device`.
-#[repr(C)]
-pub struct Device<T: drm::Driver> {
-    dev: Opaque<bindings::drm_device>,
-    data: T::Data,
+/// A [`Device`] in this [`DeviceContext`] is guaranteed to have been registered with userspace
+/// at some point in time.
+pub struct Registered;
+
+impl Sealed for Registered {}
+impl DeviceContext for Registered {}
+
+/// The [`DeviceContext`] of a [`Device`] that may be unregistered and partly uninitialized.
+///
+/// A [`Device`] in this context is only guaranteed to be partly initialized, and may or may not
+/// be registered with userspace. Thus operations which depend on the [`Device`] being fully
+/// initialized, or which depend on the [`Device`] being registered with userspace are not
+/// available through this [`DeviceContext`].
+///
+/// A [`Device`] in this context can be used to create a
+/// [`Registration`](drm::driver::Registration).
+pub struct Uninit;
+
+impl Sealed for Uninit {}
+impl DeviceContext for Uninit {}
+
+/// A [`Device`] which is known at compile-time to be unregistered with userspace.
+///
+/// This type allows performing operations which are only safe to do before userspace registration,
+/// and can be used to create a [`Registration`](drm::driver::Registration) once the driver is ready
+/// to register the device with userspace.
+///
+/// Since DRM device initialization must be single-threaded, this object is not thread-safe.
+///
+/// # Invariants
+///
+/// The device in `self.0` is guaranteed to be a newly created [`Device`] that has not yet been
+/// registered with userspace until this type is dropped.
+pub struct UnregisteredDevice<T: drm::Driver>(ARef<Device<T, Uninit>>, NotThreadSafe);
+
+impl<T: drm::Driver> Deref for UnregisteredDevice<T> {
+    type Target = Device<T, Uninit>;
+
+    fn deref(&self) -> &Self::Target {
+        &self.0
+    }
 }
 
-impl<T: drm::Driver> Device<T> {
+impl<T: drm::Driver> UnregisteredDevice<T> {
     const VTABLE: bindings::drm_driver = drm_legacy_fields! {
         load: None,
         open: Some(drm::File::<T::File>::open_callback),
         postclose: Some(drm::File::<T::File>::postclose_callback),
         unload: None,
-        release: Some(Self::release),
+        release: Some(Device::<T>::release),
         master_set: None,
         master_drop: None,
         debugfs_init: None,
@@ -113,21 +191,23 @@ impl<T: drm::Driver> Device<T> {
 
     const GEM_FOPS: bindings::file_operations = drm::gem::create_fops();
 
-    /// Create a new `drm::Device` for a `drm::Driver`.
-    pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<ARef<Self>> {
+    /// Create a new `UnregisteredDevice` for a `drm::Driver`.
+    ///
+    /// This can be used to create a [`Registration`](kernel::drm::Registration).
+    pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<Self> {
         // `__drm_dev_alloc` uses `kmalloc()` to allocate memory, hence ensure a `kmalloc()`
         // compatible `Layout`.
-        let layout = Kmalloc::aligned_layout(Layout::new::<Self>());
+        let layout = Kmalloc::aligned_layout(Layout::new::<Device<T, Uninit>>());
 
         // SAFETY:
         // - `VTABLE`, as a `const` is pinned to the read-only section of the compilation,
         // - `dev` is valid by its type invarants,
-        let raw_drm: *mut Self = unsafe {
+        let raw_drm: *mut Device<T, Uninit> = unsafe {
             bindings::__drm_dev_alloc(
                 dev.as_raw(),
                 &Self::VTABLE,
                 layout.size(),
-                mem::offset_of!(Self, dev),
+                mem::offset_of!(Device<T, Uninit>, dev),
             )
         }
         .cast();
@@ -142,7 +222,7 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<A
         unsafe { data.__pinned_init(raw_data) }.inspect_err(|_| {
             // SAFETY: `raw_drm` is a valid pointer to `Self`, given that `__drm_dev_alloc` was
             // successful.
-            let drm_dev = unsafe { Self::into_drm_device(raw_drm) };
+            let drm_dev = unsafe { Device::into_drm_device(raw_drm) };
 
             // SAFETY: `__drm_dev_alloc()` was successful, hence `drm_dev` must be valid and the
             // refcount must be non-zero.
@@ -151,9 +231,39 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<A
 
         // SAFETY: The reference count is one, and now we take ownership of that reference as a
         // `drm::Device`.
-        Ok(unsafe { ARef::from_raw(raw_drm) })
+        // INVARIANT: We just created the device above, but have yet to call `drm_dev_register`.
+        // `Self` cannot be copied or sent to another thread - ensuring that `drm_dev_register`
+        // won't be called during its lifetime and that the device is unregistered.
+        Ok(Self(unsafe { ARef::from_raw(raw_drm) }, NotThreadSafe))
     }
+}
+
+/// A typed DRM device with a specific [`drm::Driver`] implementation and [`DeviceContext`].
+///
+/// Since DRM devices can be used before being fully initialized and registered with userspace, `C`
+/// represents the furthest [`DeviceContext`] we can guarantee that this [`Device`] has reached.
+///
+/// Keep in mind: this means that an unregistered device can still have the registration state
+/// [`Registered`] as long as it was registered with userspace once in the past, and that the
+/// behavior of such a device is still well-defined. Additionally, a device with the registration
+/// state [`Uninit`] simply does not have a guaranteed registration state at compile time, and could
+/// be either registered or unregistered. Since there is no way to guarantee a long-lived reference
+/// to an unregistered device would remain unregistered, we do not provide a [`DeviceContext`] for
+/// this.
+///
+/// # Invariants
+///
+/// * `self.dev` is a valid instance of a `struct device`.
+/// * The data layout of `Self` remains the same across all implementations of `C`.
+/// * Any invariants for `C` also apply.
+#[repr(C)]
+pub struct Device<T: drm::Driver, C: DeviceContext = Registered> {
+    dev: Opaque<bindings::drm_device>,
+    data: T::Data,
+    _ctx: PhantomData<C>,
+}
 
+impl<T: drm::Driver, C: DeviceContext> Device<T, C> {
     pub(crate) fn as_raw(&self) -> *mut bindings::drm_device {
         self.dev.get()
     }
@@ -179,13 +289,13 @@ unsafe fn into_drm_device(ptr: NonNull<Self>) -> *mut bindings::drm_device {
     ///
     /// # Safety
     ///
-    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count,
-    /// i.e. it must be ensured that the reference count of the C `struct drm_device` `ptr` points
-    /// to can't drop to zero, for the duration of this function call and the entire duration when
-    /// the returned reference exists.
-    ///
-    /// Additionally, callers must ensure that the `struct device`, `ptr` is pointing to, is
-    /// embedded in `Self`.
+    /// * Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count,
+    ///   i.e. it must be ensured that the reference count of the C `struct drm_device` `ptr` points
+    ///   to can't drop to zero, for the duration of this function call and the entire duration when
+    ///   the returned reference exists.
+    /// * Additionally, callers must ensure that the `struct device`, `ptr` is pointing to, is
+    ///   embedded in `Self`.
+    /// * Callers promise that any type invariants of `C` will be upheld.
     #[doc(hidden)]
     pub unsafe fn from_raw<'a>(ptr: *const bindings::drm_device) -> &'a Self {
         // SAFETY: By the safety requirements of this function `ptr` is a valid pointer to a
@@ -205,9 +315,20 @@ extern "C" fn release(ptr: *mut bindings::drm_device) {
         // - `this` is valid for dropping.
         unsafe { core::ptr::drop_in_place(this) };
     }
+
+    /// Change the [`DeviceContext`] for a [`Device`].
+    ///
+    /// # Safety
+    ///
+    /// The caller promises that `self` fulfills all of the guarantees provided by the given
+    /// [`DeviceContext`].
+    pub(crate) unsafe fn assume_ctx<NewCtx: DeviceContext>(&self) -> &Device<T, NewCtx> {
+        // SAFETY: The data layout is identical via our type invariants.
+        unsafe { mem::transmute(self) }
+    }
 }
 
-impl<T: drm::Driver> Deref for Device<T> {
+impl<T: drm::Driver, C: DeviceContext> Deref for Device<T, C> {
     type Target = T::Data;
 
     fn deref(&self) -> &Self::Target {
@@ -217,7 +338,7 @@ fn deref(&self) -> &Self::Target {
 
 // SAFETY: DRM device objects are always reference counted and the get/put functions
 // satisfy the requirements.
-unsafe impl<T: drm::Driver> AlwaysRefCounted for Device<T> {
+unsafe impl<T: drm::Driver, C: DeviceContext> AlwaysRefCounted for Device<T, C> {
     fn inc_ref(&self) {
         // SAFETY: The existence of a shared reference guarantees that the refcount is non-zero.
         unsafe { bindings::drm_dev_get(self.as_raw()) };
@@ -232,7 +353,7 @@ unsafe fn dec_ref(obj: NonNull<Self>) {
     }
 }
 
-impl<T: drm::Driver> AsRef<device::Device> for Device<T> {
+impl<T: drm::Driver, C: DeviceContext> AsRef<device::Device> for Device<T, C> {
     fn as_ref(&self) -> &device::Device {
         // SAFETY: `bindings::drm_device::dev` is valid as long as the DRM device itself is valid,
         // which is guaranteed by the type invariant.
@@ -241,21 +362,22 @@ fn as_ref(&self) -> &device::Device {
 }
 
 // SAFETY: A `drm::Device` can be released from any thread.
-unsafe impl<T: drm::Driver> Send for Device<T> {}
+unsafe impl<T: drm::Driver, C: DeviceContext> Send for Device<T, C> {}
 
 // SAFETY: A `drm::Device` can be shared among threads because all immutable methods are protected
 // by the synchronization in `struct drm_device`.
-unsafe impl<T: drm::Driver> Sync for Device<T> {}
+unsafe impl<T: drm::Driver, C: DeviceContext> Sync for Device<T, C> {}
 
-impl<T, const ID: u64> WorkItem<ID> for Device<T>
+impl<T, C, const ID: u64> WorkItem<ID> for Device<T, C>
 where
     T: drm::Driver,
-    T::Data: WorkItem<ID, Pointer = ARef<Device<T>>>,
-    T::Data: HasWork<Device<T>, ID>,
+    T::Data: WorkItem<ID, Pointer = ARef<Self>>,
+    T::Data: HasWork<Self, ID>,
+    C: DeviceContext,
 {
-    type Pointer = ARef<Device<T>>;
+    type Pointer = ARef<Self>;
 
-    fn run(ptr: ARef<Device<T>>) {
+    fn run(ptr: ARef<Self>) {
         T::Data::run(ptr);
     }
 }
@@ -267,40 +389,42 @@ fn run(ptr: ARef<Device<T>>) {
 // stored inline in `drm::Device`, so the `container_of` call is valid.
 //
 // - The two methods are true inverses of each other: given `ptr: *mut
-// Device<T>`, `raw_get_work` will return a `*mut Work<Device<T>, ID>` through
-// `T::Data::raw_get_work` and given a `ptr: *mut Work<Device<T>, ID>`,
-// `work_container_of` will return a `*mut Device<T>` through `container_of`.
-unsafe impl<T, const ID: u64> HasWork<Device<T>, ID> for Device<T>
+// Device<T, C>`, `raw_get_work` will return a `*mut Work<Device<T, C>, ID>` through
+// `T::Data::raw_get_work` and given a `ptr: *mut Work<Device<T, C>, ID>`,
+// `work_container_of` will return a `*mut Device<T, C>` through `container_of`.
+unsafe impl<T, C, const ID: u64> HasWork<Self, ID> for Device<T, C>
 where
     T: drm::Driver,
-    T::Data: HasWork<Device<T>, ID>,
+    T::Data: HasWork<Self, ID>,
+    C: DeviceContext,
 {
-    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<Device<T>, ID> {
-        // SAFETY: The caller promises that `ptr` points to a valid `Device<T>`.
+    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<Self, ID> {
+        // SAFETY: The caller promises that `ptr` points to a valid `Device<T, C>`.
         let data_ptr = unsafe { &raw mut (*ptr).data };
 
         // SAFETY: `data_ptr` is a valid pointer to `T::Data`.
         unsafe { T::Data::raw_get_work(data_ptr) }
     }
 
-    unsafe fn work_container_of(ptr: *mut Work<Device<T>, ID>) -> *mut Self {
+    unsafe fn work_container_of(ptr: *mut Work<Self, ID>) -> *mut Self {
         // SAFETY: The caller promises that `ptr` points at a `Work` field in
         // `T::Data`.
         let data_ptr = unsafe { T::Data::work_container_of(ptr) };
 
-        // SAFETY: `T::Data` is stored as the `data` field in `Device<T>`.
+        // SAFETY: `T::Data` is stored as the `data` field in `Device<T, C>`.
         unsafe { crate::container_of!(data_ptr, Self, data) }
     }
 }
 
 // SAFETY: Our `HasWork<T, ID>` implementation returns a `work_struct` that is
 // stored in the `work` field of a `delayed_work` with the same access rules as
-// the `work_struct` owing to the bound on `T::Data: HasDelayedWork<Device<T>,
+// the `work_struct` owing to the bound on `T::Data: HasDelayedWork<Device<T, C>,
 // ID>`, which requires that `T::Data::raw_get_work` return a `work_struct` that
 // is inside a `delayed_work`.
-unsafe impl<T, const ID: u64> HasDelayedWork<Device<T>, ID> for Device<T>
+unsafe impl<T, C, const ID: u64> HasDelayedWork<Self, ID> for Device<T, C>
 where
     T: drm::Driver,
-    T::Data: HasDelayedWork<Device<T>, ID>,
+    T::Data: HasDelayedWork<Self, ID>,
+    C: DeviceContext,
 {
 }
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 5233bdebc9fcd..55b01ee088548 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -13,6 +13,10 @@
     prelude::*,
     sync::aref::ARef, //
 };
+use core::{
+    mem,
+    ptr::NonNull, //
+};
 
 /// Driver use the GEM memory manager. This should be set for all modern drivers.
 pub(crate) const FEAT_GEM: u32 = bindings::drm_driver_feature_DRIVER_GEM;
@@ -123,21 +127,31 @@ pub trait Driver {
 pub struct Registration<T: Driver>(ARef<drm::Device<T>>);
 
 impl<T: Driver> Registration<T> {
-    fn new(drm: &drm::Device<T>, flags: usize) -> Result<Self> {
+    fn new(drm: drm::UnregisteredDevice<T>, flags: usize) -> Result<Self> {
         // SAFETY: `drm.as_raw()` is valid by the invariants of `drm::Device`.
         to_result(unsafe { bindings::drm_dev_register(drm.as_raw(), flags) })?;
 
-        Ok(Self(drm.into()))
+        // SAFETY: We just called `drm_dev_register` above
+        let new = NonNull::from(unsafe { drm.assume_ctx() });
+
+        // Leak the ARef from UnregisteredDevice in preparation for transferring its ownership.
+        mem::forget(drm);
+
+        // SAFETY: `drm`'s `Drop` constructor was never called, ensuring that there remains at least
+        // one reference to the device - which we take ownership over here.
+        let new = unsafe { ARef::from_raw(new) };
+
+        Ok(Self(new))
     }
 
-    /// Registers a new [`Device`](drm::Device) with userspace.
+    /// Registers a new [`UnregisteredDevice`](drm::UnregisteredDevice) with userspace.
     ///
     /// Ownership of the [`Registration`] object is passed to [`devres::register`].
-    pub fn new_foreign_owned(
-        drm: &drm::Device<T>,
-        dev: &device::Device<device::Bound>,
+    pub fn new_foreign_owned<'a>(
+        drm: drm::UnregisteredDevice<T>,
+        dev: &'a device::Device<device::Bound>,
         flags: usize,
-    ) -> Result
+    ) -> Result<&'a drm::Device<T>>
     where
         T: 'static,
     {
@@ -146,8 +160,13 @@ pub fn new_foreign_owned(
         }
 
         let reg = Registration::<T>::new(drm, flags)?;
+        let drm = NonNull::from(reg.device());
+
+        devres::register(dev, reg, GFP_KERNEL)?;
 
-        devres::register(dev, reg, GFP_KERNEL)
+        // SAFETY: Since `reg` was passed to devres::register(), the device now owns the lifetime
+        // of the DRM registration - ensuring that this references lives for at least as long as 'a.
+        Ok(unsafe { drm.as_ref() })
     }
 
     /// Returns a reference to the `Device` instance for this registration.
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index a4b6c54301985..a66e7166f66b5 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -10,6 +10,10 @@
 pub mod ioctl;
 
 pub use self::device::Device;
+pub use self::device::DeviceContext;
+pub use self::device::Registered;
+pub use self::device::Uninit;
+pub use self::device::UnregisteredDevice;
 pub use self::driver::Driver;
 pub use self::driver::DriverInfo;
 pub use self::driver::Registration;
-- 
2.54.0

