Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270A4FF8864
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 22:13:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85FB710E97F;
	Mon, 27 Apr 2026 22:13:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aFiYEfVB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6ABD10E97F
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 22:13:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A9AB60128;
 Mon, 27 Apr 2026 22:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410D6C2BCB6;
 Mon, 27 Apr 2026 22:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777328029;
 bh=LqoJmyLMcfvlHKDJq6T+tkDE6stHA+a+dnj6GefZ9os=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aFiYEfVByRv2PjDa9rjYPjgR9q/fQlaBcDWAP+n9ARzSi35I3fnQBQL4jXkKGDFqb
 Z+VfYo+FSkRbNwQd6HzuNL2R+VKCaOPP2Vt7a5oRB1f1lN8QHUS7mkwa2kqHPVBPHD
 l03xRWXLrvCwYveEXJEMCVnnLbogwLsr1wkfNlkwlAmoq9F+HdY8YjBxU3qt84QonQ
 vdiQnv2fsuVsGsUCmq1lVdBEMwCQFAmiGn60q3rtrxY6WPr2VXXMG+6L4Xh1xwYO4V
 WJEmvDbKfwovia/wetB+zMtncjlIo7goJfWZX5JKqF73OCnqP5s8BCruWMyK6RvsV7
 duihnqd6v+KKw==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 16/24] rust: usb: make Driver trait lifetime-parameterized
Date: Tue, 28 Apr 2026 00:11:14 +0200
Message-ID: <20260427221155.2144848-17-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427221155.2144848-1-dakr@kernel.org>
References: <20260427221155.2144848-1-dakr@kernel.org>
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

Make usb::Driver take a lifetime parameter 'a that ties device resources
to the binding scope.

Internally, Adapter<T: Driver> becomes Adapter<F: ForLt> with a bound
for<'a> F::Of<'a>: Driver<'a>; module_usb_driver! wraps the driver type
in ForLt!() so drivers don't have to.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/usb.rs              | 84 ++++++++++++++++++++-------------
 samples/rust/rust_driver_usb.rs | 14 +++---
 2 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 442e456fd2d3..f519444cf8d0 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -35,22 +35,34 @@
 };
 
 /// An adapter for the registration of USB drivers.
-pub struct Adapter<T: Driver>(T);
+///
+/// `F` is a [`ForLt`](trait@ForLt) type that maps lifetimes to the driver's device
+/// private data type, i.e. `F::Of<'a>` is the driver struct parameterized by `'a`. The macro
+/// `module_usb_driver!` generates this automatically via `ForLt!()`.
+pub struct Adapter<F>(PhantomData<F>);
 
 // SAFETY:
 // - `bindings::usb_driver` is a C type declared as `repr(C)`.
-// - `T` is the type of the driver's device private data.
+// - `F::Of<'static>` is the stored type of the driver's device private data.
 // - `struct usb_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<F> driver::DriverLayout for Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'a> F::Of<'a>: Driver<'a>,
+{
     type DriverType = bindings::usb_driver;
-    type DriverData = ForLt!(T);
+    type DriverData = F;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
 // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
 // a preceding call to `register` has been successful.
-unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+unsafe impl<F> driver::RegistrationOps for Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'a> F::Of<'a>: Driver<'a>,
+{
     unsafe fn register(
         udrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -61,7 +73,7 @@ unsafe fn register(
             (*udrv.get()).name = name.as_char_ptr();
             (*udrv.get()).probe = Some(Self::probe_callback);
             (*udrv.get()).disconnect = Some(Self::disconnect_callback);
-            (*udrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*udrv.get()).id_table = <F::Of<'static> as Driver<'static>>::ID_TABLE.as_ptr();
         }
 
         // SAFETY: `udrv` is guaranteed to be a valid `DriverType`.
@@ -76,7 +88,11 @@ unsafe fn unregister(udrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<F> Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'a> F::Of<'a>: Driver<'a>,
+{
     extern "C" fn probe_callback(
         intf: *mut bindings::usb_interface,
         id: *const bindings::usb_device_id,
@@ -87,16 +103,16 @@ extern "C" fn probe_callback(
         // INVARIANT: `intf` is valid for the duration of `probe_callback()`.
         let intf = unsafe { &*intf.cast::<Interface<device::CoreInternal>>() };
 
-        from_result(|| {
-            // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct usb_device_id` and
-            // does not add additional invariants, so it's safe to transmute.
-            let id = unsafe { &*id.cast::<DeviceId>() };
+        // SAFETY: `DeviceId` is a `#[repr(transparent)]` wrapper of `struct usb_device_id` and
+        // does not add additional invariants, so it's safe to transmute.
+        let id = unsafe { &*id.cast::<DeviceId>() };
 
-            let info = T::ID_TABLE.info(id.index());
-            let data = T::probe(intf, id, info);
+        from_result(|| {
+            let info = <F::Of<'_> as Driver<'_>>::ID_TABLE.info(id.index());
+            let data = <F::Of<'_> as Driver<'_>>::probe(intf, id, info);
 
             let dev: &device::Device<device::CoreInternal> = intf.as_ref();
-            dev.set_drvdata::<ForLt!(T)>(data)?;
+            dev.set_drvdata::<F>(data)?;
             Ok(0)
         })
     }
@@ -111,11 +127,10 @@ extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
         let dev: &device::Device<device::CoreInternal> = intf.as_ref();
 
         // SAFETY: `disconnect_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { dev.drvdata_borrow::<ForLt!(T)>() };
+        // `probe_callback`, hence it's guaranteed that drvdata has been set.
+        let data = unsafe { dev.drvdata_borrow::<F>() };
 
-        T::disconnect(intf, data);
+        <F::Of<'_> as Driver<'_>>::disconnect(intf, data);
     }
 }
 
@@ -281,29 +296,29 @@ macro_rules! usb_device_table {
 /// kernel::usb_device_table!(
 ///     USB_TABLE,
 ///     MODULE_USB_TABLE,
-///     <MyDriver as usb::Driver>::IdInfo,
+///     <MyDriver as usb::Driver<'_>>::IdInfo,
 ///     [
 ///         (usb::DeviceId::from_id(0x1234, 0x5678), ()),
 ///         (usb::DeviceId::from_id(0xabcd, 0xef01), ()),
 ///     ]
 /// );
 ///
-/// impl usb::Driver for MyDriver {
+/// impl<'a> usb::Driver<'a> for MyDriver {
 ///     type IdInfo = ();
 ///     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 ///
 ///     fn probe(
-///         _interface: &usb::Interface<Core>,
-///         _id: &usb::DeviceId,
-///         _info: &Self::IdInfo,
-///     ) -> impl PinInit<Self, Error> {
+///         _interface: &'a usb::Interface<Core>,
+///         _id: &'a usb::DeviceId,
+///         _info: &'a Self::IdInfo,
+///     ) -> impl PinInit<Self, Error> + 'a {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn disconnect(_interface: &usb::Interface<Core>, _data: Pin<&Self>) {}
+///     fn disconnect(_interface: &'a usb::Interface<Core>, _data: Pin<&'a Self>) {}
 /// }
 ///```
-pub trait Driver {
+pub trait Driver<'a> {
     /// The type holding information about each one of the device ids supported by the driver.
     type IdInfo: 'static;
 
@@ -315,15 +330,15 @@ pub trait Driver {
     /// Called when a new USB interface is bound to this driver.
     /// Implementers should attempt to initialize the interface here.
     fn probe(
-        interface: &Interface<device::Core>,
-        id: &DeviceId,
-        id_info: &Self::IdInfo,
-    ) -> impl PinInit<Self, Error>;
+        interface: &'a Interface<device::Core>,
+        id: &'a DeviceId,
+        id_info: &'a Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'a;
 
     /// USB driver disconnect.
     ///
     /// Called when the USB interface is about to be unbound from this driver.
-    fn disconnect(interface: &Interface<device::Core>, data: Pin<&Self>);
+    fn disconnect(interface: &'a Interface<device::Core>, data: Pin<&'a Self>);
 }
 
 /// A USB interface.
@@ -486,7 +501,10 @@ unsafe impl Sync for Device<device::Bound> {}
 /// ```
 #[macro_export]
 macro_rules! module_usb_driver {
-    ($($f:tt)*) => {
-        $crate::module_driver!(<T>, $crate::usb::Adapter<T>, { $($f)* });
+    (type: $type:ty, $($rest:tt)*) => {
+        $crate::module_driver!(<T>, $crate::usb::Adapter<T>, {
+            type: $crate::types::ForLt!($type),
+            $($rest)*
+        });
     }
 }
diff --git a/samples/rust/rust_driver_usb.rs b/samples/rust/rust_driver_usb.rs
index ab72e99e1274..6f3e5db9f35d 100644
--- a/samples/rust/rust_driver_usb.rs
+++ b/samples/rust/rust_driver_usb.rs
@@ -20,26 +20,26 @@ struct SampleDriver {
 kernel::usb_device_table!(
     USB_TABLE,
     MODULE_USB_TABLE,
-    <SampleDriver as usb::Driver>::IdInfo,
+    <SampleDriver as usb::Driver<'_>>::IdInfo,
     [(usb::DeviceId::from_id(0x1234, 0x5678), ()),]
 );
 
-impl usb::Driver for SampleDriver {
+impl<'a> usb::Driver<'a> for SampleDriver {
     type IdInfo = ();
     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 
     fn probe(
-        intf: &usb::Interface<Core>,
-        _id: &usb::DeviceId,
-        _info: &Self::IdInfo,
-    ) -> impl PinInit<Self, Error> {
+        intf: &'a usb::Interface<Core>,
+        _id: &'a usb::DeviceId,
+        _info: &'a Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'a {
         let dev: &device::Device<Core> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample probed\n");
 
         Ok(Self { _intf: intf.into() })
     }
 
-    fn disconnect(intf: &usb::Interface<Core>, _data: Pin<&Self>) {
+    fn disconnect(intf: &'a usb::Interface<Core>, _data: Pin<&'a Self>) {
         let dev: &device::Device<Core> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample disconnected\n");
     }
-- 
2.54.0

