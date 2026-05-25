Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FC9CD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 20:31:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D53B10E3FD;
	Mon, 25 May 2026 20:31:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RgzFvYdH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D626610E3FD
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 20:31:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BC4CE434EF;
 Mon, 25 May 2026 20:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE501F00A3A;
 Mon, 25 May 2026 20:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779741085;
 bh=z11UvhgWKKI+6/EKxkmzn/nsBmglIioHgcmgo3Ma1ao=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RgzFvYdHim5i70pkW58BdnAg7eHxoPEq5f3D+giQr18kn6I23lyT6ZwTuL5+CpRzU
 I2zTTrGxspIqDOjSK4K+RiEaW2Sk9W10Pekqol5UtikwbHelFc2CFSvILbaFtu+k/W
 avV5JASb6F7JLAGxtW5LpXCjUCWbwtPhq/7L6mNdOAliQZlJdH7rsL2XYx9pdtIBqI
 qanJPfl1Yn+JPxVoqwvt1I5IttuwaSV+KV5eBlOftCmix0dxK+b2Lx50TeFxQEk3rS
 LcPCsbQObOax6sc0EpPnPRwRqq2iBsQlOuS5Z9stTcj4iLLf0iNlCzxOCWIhJf8/Gq
 AaZDcjAnuoGww==
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
Subject: [PATCH v5 16/24] rust: i2c: make Driver trait lifetime-parameterized
Date: Mon, 25 May 2026 22:21:03 +0200
Message-ID: <20260525202921.124698-17-dakr@kernel.org>
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

Add a 'bound lifetime to the associated Data, changing type Data to type
Data<'bound>.

This allows the driver's bus device private data to capture the device /
driver bound lifetime; device resources can be stored directly by
reference rather than requiring Devres.

The probe() and unbind() callbacks thus gain a 'bound lifetime parameter
on the methods themselves; avoiding a global lifetime on the trait impl.

Existing drivers set type Data<'bound> = Self, preserving the current
behavior.

Acked-by: Igor Korotin <igor.korotin@linux.dev>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/i2c.rs              | 39 ++++++++++++++++++---------------
 samples/rust/rust_driver_i2c.rs | 14 ++++++------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 50feade0fb58..6094d32652e3 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -98,7 +98,7 @@ macro_rules! i2c_device_table {
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::i2c_driver;
-    type DriverData<'bound> = T::Data;
+    type DriverData<'bound> = T::Data<'bound>;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -176,8 +176,8 @@ extern "C" fn remove_callback(idev: *mut bindings::i2c_client) {
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `I2cClient::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T::Data>>`.
-        let data = unsafe { idev.as_ref().drvdata_borrow::<T::Data>() };
+        // and stored a `Pin<KBox<T::Data<'_>>>`.
+        let data = unsafe { idev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::unbind(idev, data);
     }
@@ -188,8 +188,8 @@ extern "C" fn shutdown_callback(idev: *mut bindings::i2c_client) {
 
         // SAFETY: `shutdown_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
-        // and stored a `Pin<KBox<T::Data>>`.
-        let data = unsafe { idev.as_ref().drvdata_borrow::<T::Data>() };
+        // and stored a `Pin<KBox<T::Data<'_>>>`.
+        let data = unsafe { idev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::shutdown(idev, data);
     }
@@ -294,19 +294,22 @@ macro_rules! module_i2c_driver {
 ///
 /// impl i2c::Driver for MyDriver {
 ///     type IdInfo = ();
-///     type Data = Self;
+///     type Data<'bound> = Self;
 ///     const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
 ///     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 ///     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
 ///
-///     fn probe(
-///         _idev: &i2c::I2cClient<Core<'_>>,
-///         _id_info: Option<&Self::IdInfo>,
-///     ) -> impl PinInit<Self::Data, Error> {
+///     fn probe<'bound>(
+///         _idev: &'bound i2c::I2cClient<Core<'_>>,
+///         _id_info: Option<&'bound Self::IdInfo>,
+///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn shutdown(_idev: &i2c::I2cClient<Core<'_>>, this: Pin<&Self::Data>) {
+///     fn shutdown<'bound>(
+///         _idev: &'bound i2c::I2cClient<Core<'_>>,
+///         this: Pin<&Self::Data<'bound>>,
+///     ) {
 ///     }
 /// }
 ///```
@@ -320,7 +323,7 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data: Send;
+    type Data<'bound>: Send + 'bound;
 
     /// The table of device ids supported by the driver.
     const I2C_ID_TABLE: Option<IdTable<Self::IdInfo>> = None;
@@ -335,10 +338,10 @@ pub trait Driver {
     ///
     /// Called when a new i2c client is added or discovered.
     /// Implementers should attempt to initialize the client here.
-    fn probe(
-        dev: &I2cClient<device::Core<'_>>,
-        id_info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self::Data, Error>;
+    fn probe<'bound>(
+        dev: &'bound I2cClient<device::Core<'_>>,
+        id_info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// I2C driver shutdown.
     ///
@@ -351,7 +354,7 @@ fn probe(
     /// This callback is distinct from final resource cleanup, as the driver instance remains valid
     /// after it returns. Any deallocation or teardown of driver-owned resources should instead be
     /// handled in `Drop`.
-    fn shutdown(dev: &I2cClient<device::Core<'_>>, this: Pin<&Self::Data>) {
+    fn shutdown<'bound>(dev: &'bound I2cClient<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
 
@@ -365,7 +368,7 @@ fn shutdown(dev: &I2cClient<device::Core<'_>>, this: Pin<&Self::Data>) {
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &I2cClient<device::Core<'_>>, this: Pin<&Self::Data>) {
+    fn unbind<'bound>(dev: &'bound I2cClient<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_driver_i2c.rs b/samples/rust/rust_driver_i2c.rs
index 171550ea0b6f..ead8263a7d48 100644
--- a/samples/rust/rust_driver_i2c.rs
+++ b/samples/rust/rust_driver_i2c.rs
@@ -35,16 +35,16 @@
 
 impl i2c::Driver for SampleDriver {
     type IdInfo = u32;
-    type Data = Self;
+    type Data<'bound> = Self;
 
     const ACPI_ID_TABLE: Option<acpi::IdTable<Self::IdInfo>> = Some(&ACPI_TABLE);
     const I2C_ID_TABLE: Option<i2c::IdTable<Self::IdInfo>> = Some(&I2C_TABLE);
     const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
 
-    fn probe(
-        idev: &i2c::I2cClient<Core<'_>>,
-        info: Option<&Self::IdInfo>,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        idev: &'bound i2c::I2cClient<Core<'_>>,
+        info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let dev = idev.as_ref();
 
         dev_info!(dev, "Probe Rust I2C driver sample.\n");
@@ -56,11 +56,11 @@ fn probe(
         Ok(Self)
     }
 
-    fn shutdown(idev: &i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
+    fn shutdown<'bound>(idev: &'bound i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
         dev_info!(idev.as_ref(), "Shutdown Rust I2C driver sample.\n");
     }
 
-    fn unbind(idev: &i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
+    fn unbind<'bound>(idev: &'bound i2c::I2cClient<Core<'_>>, _this: Pin<&Self>) {
         dev_info!(idev.as_ref(), "Unbind Rust I2C driver sample.\n");
     }
 }
-- 
2.54.0

