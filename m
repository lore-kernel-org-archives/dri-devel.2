Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA603FF8867
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:10:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B57010E0AA;
	Mon, 27 Apr 2026 22:10:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y6qGnLzY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCD310E0AA
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 22:10:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 865F560121;
 Mon, 27 Apr 2026 22:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A6EC2BCB5;
 Mon, 27 Apr 2026 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777327814;
 bh=zI+mMBdbuau50/8YDiI0VaEPwOU1Qoarl3j0X+HD4BQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y6qGnLzY3KZ7BzhazKAY+kJQ5PPKyrFVb0oAotjtfC6498nkJyOZaAzbdEZ5DpNA1
 Efy8fIllZGqNmhqJSVUEFOMWk0lOfxeEV8AK0JfD3gu6juFt/v/Jm03fPNo3AZ31HD
 oIR6CLAipt7nh4zEQZx+y4x4Sn9YuCBRp5ubCPzh8wzU2MWCF+SVuom1gqmemfbOYD
 r+lK5T37TWu8JY7+vTKU7Mehw9HyMR+hJGqj/R5eZ6D3HvYeTpi2oAAOLacJUrnEAl
 6YlMA5/pZd3hfYc/ETeDrGpS7fNaYZBFQ1zVUYsTYMRVW6GQQwwQUVFyyEfrTKZ9od
 ClwhKcx033PSw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 1/2] rust: auxiliary: add registration data to auxiliary
 devices
Date: Tue, 28 Apr 2026 00:09:40 +0200
Message-ID: <20260427221002.2143861-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427221002.2143861-1-dakr@kernel.org>
References: <20260427221002.2143861-1-dakr@kernel.org>
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

Add a registration_data pointer to struct auxiliary_device, allowing the
registering (parent) driver to attach private data to the device at
registration time and retrieve it later when called back by the
auxiliary (child) driver.

By tying the data to the device's registration, Rust drivers can bind
the lifetime of device resources to it, since the auxiliary bus
guarantees that the parent driver remains bound while the auxiliary
device is bound.

On the Rust side, Registration<T> takes ownership of the data via
ForeignOwnable. A TypeId is stored alongside the data for runtime type
checking, making Device::registration_data<T>() a safe method.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs       |  10 +-
 include/linux/auxiliary_bus.h         |   4 +
 rust/kernel/auxiliary.rs              | 208 ++++++++++++++++++--------
 samples/rust/rust_driver_auxiliary.rs |  40 +++--
 4 files changed, 180 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 84b0e1703150..8fe484d357f6 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -32,8 +32,7 @@
 pub(crate) struct NovaCore {
     #[pin]
     pub(crate) gpu: Gpu,
-    #[pin]
-    _reg: Devres<auxiliary::Registration>,
+    _reg: Devres<auxiliary::Registration<()>>,
 }
 
 const BAR0_SIZE: usize = SZ_16M;
@@ -96,14 +95,15 @@ fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, E
 
             Ok(try_pin_init!(Self {
                 gpu <- Gpu::new(pdev, bar.clone(), bar.access(pdev.as_ref())?),
-                _reg <- auxiliary::Registration::new(
+                _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
                     c"nova-drm",
                     // TODO[XARR]: Use XArray or perhaps IDA for proper ID allocation/recycling. For
                     // now, use a simple atomic counter that never recycles IDs.
                     AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
-                    crate::MODULE_NAME
-                ),
+                    crate::MODULE_NAME,
+                    (),
+                )?,
             }))
         })
     }
diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index bc09b55e3682..4e1ad8ccbcdd 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -62,6 +62,9 @@
  * @sysfs.irqs: irqs xarray contains irq indices which are used by the device,
  * @sysfs.lock: Synchronize irq sysfs creation,
  * @sysfs.irq_dir_exists: whether "irqs" directory exists,
+ * @registration_data_rust: private data owned by the registering (parent)
+ *                          driver; valid for as long as the device is
+ *                          registered with the driver core,
  *
  * An auxiliary_device represents a part of its parent device's functionality.
  * It is given a name that, combined with the registering drivers
@@ -148,6 +151,7 @@ struct auxiliary_device {
 		struct mutex lock; /* Synchronize irq sysfs creation */
 		bool irq_dir_exists;
 	} sysfs;
+	void *registration_data_rust;
 };
 
 /**
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 93c0db1f6655..467befea8e44 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -19,12 +19,17 @@
         to_result, //
     },
     prelude::*,
-    types::Opaque,
+    types::{
+        ForeignOwnable,
+        Opaque, //
+    },
     ThisModule, //
 };
 use core::{
+    any::TypeId,
     marker::PhantomData,
     mem::offset_of,
+    pin::Pin,
     ptr::{
         addr_of_mut,
         NonNull, //
@@ -257,6 +262,40 @@ pub fn parent(&self) -> &device::Device<device::Bound> {
         // SAFETY: A bound auxiliary device always has a bound parent device.
         unsafe { parent.as_bound() }
     }
+
+    /// Returns a pinned reference to the registration data set by the registering (parent) driver.
+    ///
+    /// Returns [`EINVAL`] if `T` does not match the type used by the parent driver when calling
+    /// [`Registration::new()`].
+    ///
+    /// Returns [`ENOENT`] if no registration data has been set, e.g. when the device was
+    /// registered by a C driver.
+    pub fn registration_data<T: 'static>(&self) -> Result<Pin<&T>> {
+        // SAFETY: By the type invariant, `self.as_raw()` is a valid `struct auxiliary_device`.
+        let ptr = unsafe { (*self.as_raw()).registration_data_rust };
+        if ptr.is_null() {
+            dev_warn!(
+                self.as_ref(),
+                "No registration data set; parent is not a Rust driver.\n"
+            );
+            return Err(ENOENT);
+        }
+
+        // SAFETY: `ptr` is non-null and was set via `into_foreign()` in `Registration::new()`;
+        // `RegistrationData` is `#[repr(C)]` with `type_id` at offset 0, so reading a `TypeId`
+        // at the start of the allocation is valid regardless of `T`.
+        let type_id = unsafe { ptr.cast::<TypeId>().read() };
+        if type_id != TypeId::of::<T>() {
+            return Err(EINVAL);
+        }
+
+        // SAFETY: The `TypeId` check above confirms that the stored type is `T`; `ptr` remains
+        // valid until `Registration::drop()` calls `from_foreign()`.
+        let wrapper = unsafe { Pin::<KBox<RegistrationData<T>>>::borrow(ptr) };
+
+        // SAFETY: `data` is a structurally pinned field of `RegistrationData`.
+        Ok(unsafe { wrapper.map_unchecked(|w| &w.data) })
+    }
 }
 
 impl Device {
@@ -326,87 +365,132 @@ unsafe impl Send for Device {}
 // (i.e. `Device<Normal>) are thread safe.
 unsafe impl Sync for Device {}
 
+/// Wrapper that stores a [`TypeId`] alongside the registration data for runtime type checking.
+#[repr(C)]
+#[pin_data]
+struct RegistrationData<T> {
+    type_id: TypeId,
+    #[pin]
+    data: T,
+}
+
 /// The registration of an auxiliary device.
 ///
 /// This type represents the registration of a [`struct auxiliary_device`]. When its parent device
 /// is unbound, the corresponding auxiliary device will be unregistered from the system.
 ///
+/// The type parameter `T` is the type of the registration data owned by the registering (parent)
+/// driver. It can be accessed by the auxiliary driver through
+/// [`Device::registration_data()`].
+///
 /// # Invariants
 ///
-/// `self.0` always holds a valid pointer to an initialized and registered
-/// [`struct auxiliary_device`].
-pub struct Registration(NonNull<bindings::auxiliary_device>);
-
-impl Registration {
-    /// Create and register a new auxiliary device.
-    pub fn new<'a>(
-        parent: &'a device::Device<device::Bound>,
-        name: &'a CStr,
+/// `self.adev` always holds a valid pointer to an initialized and registered
+/// [`struct auxiliary_device`], and `registration_data` points to a valid
+/// `Pin<KBox<RegistrationData<T>>>`.
+pub struct Registration<T: 'static> {
+    adev: NonNull<bindings::auxiliary_device>,
+    _data: PhantomData<T>,
+}
+
+impl<T: Send + 'static> Registration<T> {
+    /// Create and register a new auxiliary device with the given registration data.
+    ///
+    /// The `data` is owned by the registration and can be accessed through the auxiliary device
+    /// via [`Device::registration_data()`].
+    pub fn new<E>(
+        parent: &device::Device<device::Bound>,
+        name: &CStr,
         id: u32,
-        modname: &'a CStr,
-    ) -> impl PinInit<Devres<Self>, Error> + 'a {
-        pin_init::pin_init_scope(move || {
-            let boxed = KBox::new(Opaque::<bindings::auxiliary_device>::zeroed(), GFP_KERNEL)?;
-            let adev = boxed.get();
-
-            // SAFETY: It's safe to set the fields of `struct auxiliary_device` on initialization.
-            unsafe {
-                (*adev).dev.parent = parent.as_raw();
-                (*adev).dev.release = Some(Device::release);
-                (*adev).name = name.as_char_ptr();
-                (*adev).id = id;
-            }
-
-            // SAFETY: `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`,
-            // which has not been initialized yet.
-            unsafe { bindings::auxiliary_device_init(adev) };
-
-            // Now that `adev` is initialized, leak the `Box`; the corresponding memory will be
-            // freed by `Device::release` when the last reference to the `struct auxiliary_device`
-            // is dropped.
-            let _ = KBox::into_raw(boxed);
-
-            // SAFETY:
-            // - `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`, which
-            //   has been initialized,
-            // - `modname.as_char_ptr()` is a NULL terminated string.
-            let ret = unsafe { bindings::__auxiliary_device_add(adev, modname.as_char_ptr()) };
-            if ret != 0 {
-                // SAFETY: `adev` is guaranteed to be a valid pointer to a
-                // `struct auxiliary_device`, which has been initialized.
-                unsafe { bindings::auxiliary_device_uninit(adev) };
-
-                return Err(Error::from_errno(ret));
-            }
-
-            // INVARIANT: The device will remain registered until `auxiliary_device_delete()` is
-            // called, which happens in `Self::drop()`.
-            Ok(Devres::new(
-                parent,
-                // SAFETY: `adev` is guaranteed to be non-null, since the `KBox` was allocated
-                // successfully.
-                Self(unsafe { NonNull::new_unchecked(adev) }),
-            ))
-        })
+        modname: &CStr,
+        data: impl PinInit<T, E>,
+    ) -> Result<Devres<Self>>
+    where
+        Error: From<E>,
+    {
+        let data = KBox::pin_init::<Error>(
+            try_pin_init!(RegistrationData {
+                type_id: TypeId::of::<T>(),
+                data <- data,
+            }),
+            GFP_KERNEL,
+        )?;
+
+        let boxed = KBox::new(Opaque::<bindings::auxiliary_device>::zeroed(), GFP_KERNEL)?;
+        let adev = boxed.get();
+
+        // SAFETY: It's safe to set the fields of `struct auxiliary_device` on initialization.
+        unsafe {
+            (*adev).dev.parent = parent.as_raw();
+            (*adev).dev.release = Some(Device::release);
+            (*adev).name = name.as_char_ptr();
+            (*adev).id = id;
+            (*adev).registration_data_rust = data.into_foreign();
+        }
+
+        // SAFETY: `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`,
+        // which has not been initialized yet.
+        unsafe { bindings::auxiliary_device_init(adev) };
+
+        // Now that `adev` is initialized, leak the `Box`; the corresponding memory will be
+        // freed by `Device::release` when the last reference to the `struct auxiliary_device`
+        // is dropped.
+        let _ = KBox::into_raw(boxed);
+
+        // SAFETY:
+        // - `adev` is guaranteed to be a valid pointer to a `struct auxiliary_device`, which
+        //   has been initialized,
+        // - `modname.as_char_ptr()` is a NULL terminated string.
+        let ret = unsafe { bindings::__auxiliary_device_add(adev, modname.as_char_ptr()) };
+        if ret != 0 {
+            // SAFETY: `registration_data` was set above via `into_foreign()`.
+            let _ = unsafe {
+                Pin::<KBox<RegistrationData<T>>>::from_foreign((*adev).registration_data_rust)
+            };
+
+            // SAFETY: `adev` is guaranteed to be a valid pointer to a
+            // `struct auxiliary_device`, which has been initialized.
+            unsafe { bindings::auxiliary_device_uninit(adev) };
+
+            return Err(Error::from_errno(ret));
+        }
+
+        // INVARIANT: The device will remain registered until `auxiliary_device_delete()` is
+        // called, which happens in `Self::drop()`.
+        let reg = Self {
+            // SAFETY: `adev` is guaranteed to be non-null, since the `KBox` was allocated
+            // successfully.
+            adev: unsafe { NonNull::new_unchecked(adev) },
+            _data: PhantomData,
+        };
+
+        Devres::new::<core::convert::Infallible>(parent, reg)
     }
 }
 
-impl Drop for Registration {
+impl<T: 'static> Drop for Registration<T> {
     fn drop(&mut self) {
-        // SAFETY: By the type invariant of `Self`, `self.0.as_ptr()` is a valid registered
+        // SAFETY: By the type invariant of `Self`, `self.adev.as_ptr()` is a valid registered
         // `struct auxiliary_device`.
-        unsafe { bindings::auxiliary_device_delete(self.0.as_ptr()) };
+        unsafe { bindings::auxiliary_device_delete(self.adev.as_ptr()) };
+
+        // SAFETY: `registration_data` was set in `new()` via `into_foreign()`.
+        drop(unsafe {
+            Pin::<KBox<RegistrationData<T>>>::from_foreign(
+                (*self.adev.as_ptr()).registration_data_rust,
+            )
+        });
 
         // This drops the reference we acquired through `auxiliary_device_init()`.
         //
-        // SAFETY: By the type invariant of `Self`, `self.0.as_ptr()` is a valid registered
+        // SAFETY: By the type invariant of `Self`, `self.adev.as_ptr()` is a valid registered
         // `struct auxiliary_device`.
-        unsafe { bindings::auxiliary_device_uninit(self.0.as_ptr()) };
+        unsafe { bindings::auxiliary_device_uninit(self.adev.as_ptr()) };
     }
 }
 
 // SAFETY: A `Registration` of a `struct auxiliary_device` can be released from any thread.
-unsafe impl Send for Registration {}
+unsafe impl<T: Send> Send for Registration<T> {}
 
 // SAFETY: `Registration` does not expose any methods or fields that need synchronization.
-unsafe impl Sync for Registration {}
+unsafe impl<T: Send> Sync for Registration<T> {}
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index 5c5a5105a3ff..319ef734c02b 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -17,8 +17,6 @@
     InPlaceModule, //
 };
 
-use core::any::TypeId;
-
 const MODULE_NAME: &CStr = <LocalModule as kernel::ModuleMetadata>::NAME;
 const AUXILIARY_NAME: &CStr = c"auxiliary";
 
@@ -49,13 +47,13 @@ fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<S
     }
 }
 
-#[pin_data]
+struct Data {
+    index: u32,
+}
+
 struct ParentDriver {
-    private: TypeId,
-    #[pin]
-    _reg0: Devres<auxiliary::Registration>,
-    #[pin]
-    _reg1: Devres<auxiliary::Registration>,
+    _reg0: Devres<auxiliary::Registration<Data>>,
+    _reg1: Devres<auxiliary::Registration<Data>>,
 }
 
 kernel::pci_device_table!(
@@ -71,10 +69,21 @@ impl pci::Driver for ParentDriver {
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe(pdev: &pci::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
-        try_pin_init!(Self {
-            private: TypeId::of::<Self>(),
-            _reg0 <- auxiliary::Registration::new(pdev.as_ref(), AUXILIARY_NAME, 0, MODULE_NAME),
-            _reg1 <- auxiliary::Registration::new(pdev.as_ref(), AUXILIARY_NAME, 1, MODULE_NAME),
+        Ok(Self {
+            _reg0: auxiliary::Registration::new(
+                pdev.as_ref(),
+                AUXILIARY_NAME,
+                0,
+                MODULE_NAME,
+                Data { index: 0 },
+            )?,
+            _reg1: auxiliary::Registration::new(
+                pdev.as_ref(),
+                AUXILIARY_NAME,
+                1,
+                MODULE_NAME,
+                Data { index: 1 },
+            )?,
         })
     }
 }
@@ -83,7 +92,8 @@ impl ParentDriver {
     fn connect(adev: &auxiliary::Device<Bound>) -> Result {
         let dev = adev.parent();
         let pdev: &pci::Device<Bound> = dev.try_into()?;
-        let drvdata = dev.drvdata::<Self>()?;
+
+        let data = adev.registration_data::<Data>()?;
 
         dev_info!(
             dev,
@@ -95,8 +105,8 @@ fn connect(adev: &auxiliary::Device<Bound>) -> Result {
 
         dev_info!(
             dev,
-            "We have access to the private data of {:?}.\n",
-            drvdata.private
+            "Connected to auxiliary device with index {}.\n",
+            data.index
         );
 
         Ok(())
-- 
2.54.0

