Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185F2CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 21:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796F910EEC4;
	Wed,  6 May 2026 21:52:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vo1IzwE5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6841210EEC4
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 21:52:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D10AD6013B;
 Wed,  6 May 2026 21:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48158C2BCC4;
 Wed,  6 May 2026 21:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778104362;
 bh=MLfMM778T9pvISlajrqiOEZI+9A8Be7jGUlckLgNLCI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Vo1IzwE5/2GxiHxXpRlyCshyU6iNZnsYPIJM+gjuJ3uViELs5QB0bQcjIfaHX2eXz
 MWO6wowOyfU9nyHXw3XLeM3NODttIhANCADb7nD+29NZpeyIT0IPKhID6ip0zI87CE
 his2UON8NDTeyrU2MPOTMDKtTnlA+80MN9zgFkYS/j3Wm+j6bRNUvDmpCU6plV74hy
 GQpjVwi6m2pIr5KTtiVrBZ2aoKQMxd7jbEHsb229AfP56LJmA+V31Z5jfTzneDBo4b
 wKC48Iq3v7gghLFiapaZSRke/pU3yW8WiHrEMDOas62+aXeXyao5XwZJhqzBn+uf5w
 Y+FwafEMtfOhQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 12/25] rust: auxiliary: make Driver trait
 lifetime-parameterized
Date: Wed,  6 May 2026 23:50:48 +0200
Message-ID: <20260506215113.851360-13-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506215113.851360-1-dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
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

Make auxiliary::Driver take a lifetime parameter 'bound that ties device
resources to the binding scope.

Internally, Adapter<T: Driver> becomes Adapter<F: ForLt> with a bound
for<'bound> F::Of<'bound>: Driver<'bound>; module_auxiliary_driver!
wraps the driver type in ForLt!() so drivers don't have to.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs        |  9 ++--
 rust/kernel/auxiliary.rs              | 60 ++++++++++++++++++---------
 samples/rust/rust_driver_auxiliary.rs | 12 ++++--
 3 files changed, 55 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index b1af0a099551..8e28ccad0575 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -42,18 +42,21 @@ pub(crate) struct NovaData {
 kernel::auxiliary_device_table!(
     AUX_TABLE,
     MODULE_AUX_TABLE,
-    <NovaDriver as auxiliary::Driver>::IdInfo,
+    <NovaDriver as auxiliary::Driver<'_>>::IdInfo,
     [(
         auxiliary::DeviceId::new(NOVA_CORE_MODULE_NAME, AUXILIARY_NAME),
         ()
     )]
 );
 
-impl auxiliary::Driver for NovaDriver {
+impl<'bound> auxiliary::Driver<'bound> for NovaDriver {
     type IdInfo = ();
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
-    fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        adev: &'bound auxiliary::Device<Core>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let data = try_pin_init!(NovaData { adev: adev.into() });
 
         let drm = drm::Device::<Self>::new(adev.as_ref(), data)?;
diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index e193ba5b7167..d2785a841380 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -38,22 +38,35 @@
 };
 
 /// An adapter for the registration of auxiliary drivers.
-pub struct Adapter<T: Driver>(T);
+///
+/// `F` is a [`ForLt`](trait@ForLt) type that maps lifetimes to the driver's device
+/// private data type, i.e. `F::Of<'bound>` is the driver struct
+/// parameterized by `'bound`. The macro `module_auxiliary_driver!`
+/// generates this automatically via `ForLt!()`.
+pub struct Adapter<F>(PhantomData<F>);
 
 // SAFETY:
 // - `bindings::auxiliary_driver` is a C type declared as `repr(C)`.
-// - `T` is the type of the driver's device private data.
+// - `F::Of<'static>` is the stored type of the driver's device private data.
 // - `struct auxiliary_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<F> driver::DriverLayout for Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'bound> F::Of<'bound>: Driver<'bound>,
+{
     type DriverType = bindings::auxiliary_driver;
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
+    for<'bound> F::Of<'bound>: Driver<'bound>,
+{
     unsafe fn register(
         adrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -64,7 +77,7 @@ unsafe fn register(
             (*adrv.get()).name = name.as_char_ptr();
             (*adrv.get()).probe = Some(Self::probe_callback);
             (*adrv.get()).remove = Some(Self::remove_callback);
-            (*adrv.get()).id_table = T::ID_TABLE.as_ptr();
+            (*adrv.get()).id_table = <F::Of<'static> as Driver<'static>>::ID_TABLE.as_ptr();
         }
 
         // SAFETY: `adrv` is guaranteed to be a valid `DriverType`.
@@ -79,7 +92,11 @@ unsafe fn unregister(adrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<F> Adapter<F>
+where
+    F: ForLt + 'static,
+    for<'bound> F::Of<'bound>: Driver<'bound>,
+{
     extern "C" fn probe_callback(
         adev: *mut bindings::auxiliary_device,
         id: *const bindings::auxiliary_device_id,
@@ -93,12 +110,12 @@ extern "C" fn probe_callback(
         // SAFETY: `DeviceId` is a `#[repr(transparent)`] wrapper of `struct auxiliary_device_id`
         // and does not add additional invariants, so it's safe to transmute.
         let id = unsafe { &*id.cast::<DeviceId>() };
-        let info = T::ID_TABLE.info(id.index());
 
         from_result(|| {
-            let data = T::probe(adev, info);
+            let info = <F::Of<'_> as Driver<'_>>::ID_TABLE.info(id.index());
+            let data = <F::Of<'_> as Driver<'_>>::probe(adev, info);
 
-            adev.as_ref().set_drvdata::<ForLt!(T)>(data)?;
+            adev.as_ref().set_drvdata::<F>(data)?;
             Ok(0)
         })
     }
@@ -111,19 +128,21 @@ extern "C" fn remove_callback(adev: *mut bindings::auxiliary_device) {
         let adev = unsafe { &*adev.cast::<Device<device::CoreInternal>>() };
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
-        // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T>>`.
-        let data = unsafe { adev.as_ref().drvdata_borrow::<ForLt!(T)>() };
+        // `probe_callback`, hence it's guaranteed that drvdata has been set.
+        let data = unsafe { adev.as_ref().drvdata_borrow::<F>() };
 
-        T::unbind(adev, data);
+        <F::Of<'_> as Driver<'_>>::unbind(adev, data);
     }
 }
 
 /// Declares a kernel module that exposes a single auxiliary driver.
 #[macro_export]
 macro_rules! module_auxiliary_driver {
-    ($($f:tt)*) => {
-        $crate::module_driver!(<T>, $crate::auxiliary::Adapter<T>, { $($f)* });
+    (type: $type:ty, $($rest:tt)*) => {
+        $crate::module_driver!(<T>, $crate::auxiliary::Adapter<T>, {
+            type: $crate::types::ForLt!($type),
+            $($rest)*
+        });
     };
 }
 
@@ -195,7 +214,7 @@ macro_rules! auxiliary_device_table {
 /// The auxiliary driver trait.
 ///
 /// Drivers must implement this trait in order to get an auxiliary driver registered.
-pub trait Driver {
+pub trait Driver<'bound>: Send {
     /// The type holding information about each device id supported by the driver.
     ///
     /// TODO: Use associated_type_defaults once stabilized:
@@ -209,7 +228,10 @@ pub trait Driver {
     /// Auxiliary driver probe.
     ///
     /// Called when an auxiliary device is matches a corresponding driver.
-    fn probe(dev: &Device<device::Core>, id_info: &Self::IdInfo) -> impl PinInit<Self, Error>;
+    fn probe(
+        dev: &'bound Device<device::Core>,
+        id_info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound;
 
     /// Auxiliary driver unbind.
     ///
@@ -221,7 +243,7 @@ pub trait Driver {
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Self::drop`.
-    fn unbind(dev: &Device<device::Core>, this: Pin<&Self>) {
+    fn unbind(dev: &'bound Device<device::Core>, this: Pin<&'bound Self>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index a1b42d30580e..6baeb1dde5da 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -26,16 +26,19 @@
 kernel::auxiliary_device_table!(
     AUX_TABLE,
     MODULE_AUX_TABLE,
-    <AuxiliaryDriver as auxiliary::Driver>::IdInfo,
+    <AuxiliaryDriver as auxiliary::Driver<'_>>::IdInfo,
     [(auxiliary::DeviceId::new(MODULE_NAME, AUXILIARY_NAME), ())]
 );
 
-impl auxiliary::Driver for AuxiliaryDriver {
+impl<'bound> auxiliary::Driver<'bound> for AuxiliaryDriver {
     type IdInfo = ();
 
     const ID_TABLE: auxiliary::IdTable<Self::IdInfo> = &AUX_TABLE;
 
-    fn probe(adev: &auxiliary::Device<Core>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe(
+        adev: &'bound auxiliary::Device<Core>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         dev_info!(
             adev,
             "Probing auxiliary driver for auxiliary device with id={}\n",
@@ -123,7 +126,8 @@ struct SampleModule {
     #[allow(clippy::type_complexity)]
     _pci_driver: driver::Registration<pci::Adapter<ForLt!(ParentDriver)>>,
     #[pin]
-    _aux_driver: driver::Registration<auxiliary::Adapter<AuxiliaryDriver>>,
+    #[allow(clippy::type_complexity)]
+    _aux_driver: driver::Registration<auxiliary::Adapter<ForLt!(AuxiliaryDriver)>>,
 }
 
 impl InPlaceModule for SampleModule {
-- 
2.54.0

