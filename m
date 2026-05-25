Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9954CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 20:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 437FC10E3CE;
	Mon, 25 May 2026 20:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FQgWIuLc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1674B10E3CE
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 20:29:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 80DB260008;
 Mon, 25 May 2026 20:29:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8861E1F00A3A;
 Mon, 25 May 2026 20:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779740992;
 bh=lvGrU2igniPCHmh11/tYEXfXrdYrMryxZKMyGL+/290=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FQgWIuLcqzfeCCHmIIWiu4svdtEx6DRpx8wc/PAzclgcYHSPoA3CW1KcEfwiUS8qF
 MFDlh+iDHbL0We6CJvw7I2uJiJkyNDsV1ZozSSVDWTv5kjY3TOYCXC6I9b4aH2XB10
 2ha24xUL8YEMoj0wF0KmZD85J02SB3MfHRvS0n8qAiNRdTV100GFngVjL5gPQ6T33S
 UIplVxrFk8EciZVch2zFuv1Ftr5thahR5ijddUNZBXF9pK+jmAtG8Okw3D2/NS7tUS
 W51+b155b8K3MV6yVqxdNOB8xOXVEcBmO4RRghzqq8bGtR85e0/VF+fBa3SUmjvvH3
 hGZeB39papaKA==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com,
 pcolberg@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v5 03/24] rust: driver: move 'static bounds to constructor
Date: Mon, 25 May 2026 22:20:50 +0200
Message-ID: <20260525202921.124698-4-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
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

From: Gary Guo <gary@garyguo.net>

With the ForeignOwnable lifetime change, the 'static bound is no longer
necessary on the drvdata methods or bus adapter impls. Move it to the
Registration constructor instead.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
Co-developed-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/auxiliary.rs | 6 +++---
 rust/kernel/device.rs    | 8 ++++----
 rust/kernel/driver.rs    | 7 +++++--
 rust/kernel/i2c.rs       | 8 ++++----
 rust/kernel/pci.rs       | 6 +++---
 rust/kernel/platform.rs  | 8 ++++----
 rust/kernel/usb.rs       | 6 +++---
 7 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 19aec94aa95b..35b44d194f67 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -44,7 +44,7 @@
 // - `T` is the type of the driver's device private data.
 // - `struct auxiliary_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::auxiliary_driver;
     type DriverData = T;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
@@ -52,7 +52,7 @@ unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
 
 // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
 // a preceding call to `register` has been successful.
-unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
     unsafe fn register(
         adrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -78,7 +78,7 @@ unsafe fn unregister(adrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<T: Driver> Adapter<T> {
     extern "C" fn probe_callback(
         adev: *mut bindings::auxiliary_device,
         id: *const bindings::auxiliary_device_id,
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index fd50399aadea..5df8fa108a52 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -203,7 +203,7 @@ pub unsafe fn as_bound(&self) -> &Device<Bound> {
 
 impl Device<CoreInternal> {
     /// Store a pointer to the bound driver's private data.
-    pub fn set_drvdata<T: 'static>(&self, data: impl PinInit<T, Error>) -> Result {
+    pub fn set_drvdata<T>(&self, data: impl PinInit<T, Error>) -> Result {
         let data = KBox::pin_init(data, GFP_KERNEL)?;
 
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
@@ -218,7 +218,7 @@ pub fn set_drvdata<T: 'static>(&self, data: impl PinInit<T, Error>) -> Result {
     ///
     /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
     ///   [`Device::set_drvdata`].
-    pub(crate) unsafe fn drvdata_obtain<T: 'static>(&self) -> Option<Pin<KBox<T>>> {
+    pub(crate) unsafe fn drvdata_obtain<T>(&self) -> Option<Pin<KBox<T>>> {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
         let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
 
@@ -244,7 +244,7 @@ pub(crate) unsafe fn drvdata_obtain<T: 'static>(&self) -> Option<Pin<KBox<T>>> {
     ///   device is fully unbound.
     /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
     ///   [`Device::set_drvdata`].
-    pub unsafe fn drvdata_borrow<T: 'static>(&self) -> Pin<&T> {
+    pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
         // SAFETY: `drvdata_unchecked()` has the exact same safety requirements as the ones
         // required by this method.
         unsafe { self.drvdata_unchecked() }
@@ -260,7 +260,7 @@ impl Device<Bound> {
     ///   the device is fully unbound.
     /// - The type `T` must match the type of the `ForeignOwnable` previously stored by
     ///   [`Device::set_drvdata`].
-    unsafe fn drvdata_unchecked<T: 'static>(&self) -> Pin<&T> {
+    unsafe fn drvdata_unchecked<T>(&self) -> Pin<&T> {
         // SAFETY: By the type invariants, `self.as_raw()` is a valid pointer to a `struct device`.
         let ptr = unsafe { bindings::dev_get_drvdata(self.as_raw()) };
 
diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 36de8098754d..c8406dc4da60 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -181,7 +181,7 @@ unsafe impl<T: RegistrationOps> Sync for Registration<T> {}
 // any thread, so `Registration` is `Send`.
 unsafe impl<T: RegistrationOps> Send for Registration<T> {}
 
-impl<T: RegistrationOps + 'static> Registration<T> {
+impl<T: RegistrationOps> Registration<T> {
     extern "C" fn post_unbind_callback(dev: *mut bindings::device) {
         // SAFETY: The driver core only ever calls the post unbind callback with a valid pointer to
         // a `struct device`.
@@ -215,7 +215,10 @@ fn callbacks_attach(drv: &Opaque<T::DriverType>) {
     }
 
     /// Creates a new instance of the registration object.
-    pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error> {
+    pub fn new(name: &'static CStr, module: &'static ThisModule) -> impl PinInit<Self, Error>
+    where
+        T: 'static,
+    {
         try_pin_init!(Self {
             reg <- Opaque::try_ffi_init(|ptr: *mut T::DriverType| {
                 // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 7b908f0c5a58..4ccee4ba4f23 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -96,7 +96,7 @@ macro_rules! i2c_device_table {
 // - `T` is the type of the driver's device private data.
 // - `struct i2c_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::i2c_driver;
     type DriverData = T;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
@@ -104,7 +104,7 @@ unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
 
 // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
 // a preceding call to `register` has been successful.
-unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
     unsafe fn register(
         idrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -151,7 +151,7 @@ unsafe fn unregister(idrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<T: Driver> Adapter<T> {
     extern "C" fn probe_callback(idev: *mut bindings::i2c_client) -> kernel::ffi::c_int {
         // SAFETY: The I2C bus only ever calls the probe callback with a valid pointer to a
         // `struct i2c_client`.
@@ -222,7 +222,7 @@ fn i2c_id_info(dev: &I2cClient) -> Option<&'static <Self as driver::Adapter>::Id
     }
 }
 
-impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
+impl<T: Driver> driver::Adapter for Adapter<T> {
     type IdInfo = T::IdInfo;
 
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index af74ddff6114..17a33819dc0a 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -62,7 +62,7 @@
 // - `T` is the type of the driver's device private data.
 // - `struct pci_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::pci_driver;
     type DriverData = T;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
@@ -70,7 +70,7 @@ unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
 
 // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
 // a preceding call to `register` has been successful.
-unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
     unsafe fn register(
         pdrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -96,7 +96,7 @@ unsafe fn unregister(pdrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<T: Driver> Adapter<T> {
     extern "C" fn probe_callback(
         pdev: *mut bindings::pci_dev,
         id: *const bindings::pci_device_id,
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 8917d4ee499f..c7a3dcdde3b1 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -48,7 +48,7 @@
 // - `T` is the type of the driver's device private data.
 // - `struct platform_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::platform_driver;
     type DriverData = T;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
@@ -56,7 +56,7 @@ unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
 
 // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
 // a preceding call to `register` has been successful.
-unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
     unsafe fn register(
         pdrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -91,7 +91,7 @@ unsafe fn unregister(pdrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<T: Driver> Adapter<T> {
     extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ffi::c_int {
         // SAFETY: The platform bus only ever calls the probe callback with a valid pointer to a
         // `struct platform_device`.
@@ -124,7 +124,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
     }
 }
 
-impl<T: Driver + 'static> driver::Adapter for Adapter<T> {
+impl<T: Driver> driver::Adapter for Adapter<T> {
     type IdInfo = T::IdInfo;
 
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 9c17a672cd27..3f62da585281 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -39,7 +39,7 @@
 // - `T` is the type of the driver's device private data.
 // - `struct usb_driver` embeds a `struct device_driver`.
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
-unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
+unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::usb_driver;
     type DriverData = T;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
@@ -47,7 +47,7 @@ unsafe impl<T: Driver + 'static> driver::DriverLayout for Adapter<T> {
 
 // SAFETY: A call to `unregister` for a given instance of `DriverType` is guaranteed to be valid if
 // a preceding call to `register` has been successful.
-unsafe impl<T: Driver + 'static> driver::RegistrationOps for Adapter<T> {
+unsafe impl<T: Driver> driver::RegistrationOps for Adapter<T> {
     unsafe fn register(
         udrv: &Opaque<Self::DriverType>,
         name: &'static CStr,
@@ -73,7 +73,7 @@ unsafe fn unregister(udrv: &Opaque<Self::DriverType>) {
     }
 }
 
-impl<T: Driver + 'static> Adapter<T> {
+impl<T: Driver> Adapter<T> {
     extern "C" fn probe_callback(
         intf: *mut bindings::usb_interface,
         id: *const bindings::usb_device_id,
-- 
2.54.0

