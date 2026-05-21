Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E04CD5BAB
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 23:40:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1617D10F45C;
	Thu, 21 May 2026 23:40:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JZnGZFzV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE77E10F45C
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 23:40:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52D9C601D9;
 Thu, 21 May 2026 23:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EC11F00A3D;
 Thu, 21 May 2026 23:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779406835;
 bh=NnGjcL7KCY7DeRdXWPfnt63zevGpvRoRbOoOP1ZRnLg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JZnGZFzVjcVBf9TSnNANcehypJGLZGBPSOKZCChqBWXe0xI6j2iMBRWja7mm9cRIZ
 VL33JrehzPK+KXunaZXoq8aDGRF9Sr/oSeYy/nycEHB9Thec5PWodH5GP/8HZevUNs
 LgaRXDR4znVRnX9dP6hZduxBZMAq+oFVn8zQdFnD3elCkswwQphmmGy7bNDX/qBhXO
 YawScoJvpEydH/x2/uF1zEX0fr4Ke5FFVWhRL6kwsXYFJOUmxcTTcYhgojlBsQTGYx
 0hn/AS9OiQ0S/ozmDFbNsw1mvW1fkuL5do8vKVfiBslWKo2PWa5UCI/GGhMMTsJb9J
 Nu6SZ5X4l+hWw==
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
Subject: [PATCH v4 11/27] rust: pci: make Driver trait lifetime-parameterized
Date: Fri, 22 May 2026 01:34:37 +0200
Message-ID: <20260521233501.1191842-12-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260521233501.1191842-1-dakr@kernel.org>
References: <20260521233501.1191842-1-dakr@kernel.org>
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

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs       |  9 ++++++---
 rust/kernel/pci.rs                    | 26 +++++++++++++-------------
 samples/rust/rust_dma.rs              |  7 +++++--
 samples/rust/rust_driver_auxiliary.rs |  7 +++++--
 samples/rust/rust_driver_pci.rs       |  7 +++++--
 5 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 13c5ff15e87f..6ad1a856694c 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -74,10 +74,13 @@ pub(crate) struct NovaCore {
 
 impl pci::Driver for NovaCore {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core<'_>>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
@@ -109,7 +112,7 @@ fn probe(pdev: &pci::Device<Core<'_>>, _info: &Self::IdInfo) -> impl PinInit<Sel
         })
     }
 
-    fn unbind(pdev: &pci::Device<Core<'_>>, this: Pin<&Self>) {
+    fn unbind<'bound>(pdev: &'bound pci::Device<Core<'_>>, this: Pin<&Self>) {
         this.gpu.unbind(pdev.as_ref());
     }
 }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 314ad9fefdb0..a462f4e8f5f3 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -64,7 +64,7 @@
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::pci_driver;
-    type DriverData<'bound> = T::Data;
+    type DriverData<'bound> = T::Data<'bound>;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -130,7 +130,7 @@ extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T::Data>>`.
-        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data>() };
+        let data = unsafe { pdev.as_ref().drvdata_borrow::<T::Data<'_>>() };
 
         T::unbind(pdev, data);
     }
@@ -279,13 +279,13 @@ macro_rules! pci_device_table {
 ///
 /// impl pci::Driver for MyDriver {
 ///     type IdInfo = ();
-///     type Data = Self;
+///     type Data<'bound> = Self;
 ///     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 ///
-///     fn probe(
-///         _pdev: &pci::Device<Core<'_>>,
-///         _id_info: &Self::IdInfo,
-///     ) -> impl PinInit<Self, Error> {
+///     fn probe<'bound>(
+///         _pdev: &'bound pci::Device<Core<'_>>,
+///         _id_info: &'bound Self::IdInfo,
+///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 /// }
@@ -302,7 +302,7 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data: Send;
+    type Data<'bound>: Send + 'bound;
 
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
@@ -311,10 +311,10 @@ pub trait Driver {
     ///
     /// Called when a new pci device is added or discovered. Implementers should
     /// attempt to initialize the device here.
-    fn probe(
-        dev: &Device<device::Core<'_>>,
-        id_info: &Self::IdInfo,
-    ) -> impl PinInit<Self::Data, Error>;
+    fn probe<'bound>(
+        dev: &'bound Device<device::Core<'_>>,
+        id_info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// PCI driver unbind.
     ///
@@ -326,7 +326,7 @@ fn probe(
     /// operations to gracefully tear down the device.
     ///
     /// Otherwise, release operations for driver resources should be performed in `Drop`.
-    fn unbind(dev: &Device<device::Core<'_>>, this: Pin<&Self::Data>) {
+    fn unbind<'bound>(dev: &'bound Device<device::Core<'_>>, this: Pin<&Self::Data<'bound>>) {
         let _ = (dev, this);
     }
 }
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 9a243e7c7298..c4d2d36602af 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -58,10 +58,13 @@ unsafe impl kernel::transmute::FromBytes for MyStruct {}
 
 impl pci::Driver for DmaSampleDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core<'_>>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_info!(pdev, "Probe DMA test driver.\n");
 
diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_driver_auxiliary.rs
index f0d419823f9a..0e979f45cd68 100644
--- a/samples/rust/rust_driver_auxiliary.rs
+++ b/samples/rust/rust_driver_auxiliary.rs
@@ -69,11 +69,14 @@ struct ParentDriver {
 
 impl pci::Driver for ParentDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core<'_>>, _info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         Ok(Self {
             _reg0: auxiliary::Registration::new(
                 pdev.as_ref(),
diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index 3106f766fd93..6791d98e1c79 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -140,11 +140,14 @@ fn config_space(pdev: &pci::Device<Bound>) {
 
 impl pci::Driver for SampleDriver {
     type IdInfo = TestIndex;
-    type Data = Self;
+    type Data<'bound> = Self;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
-    fn probe(pdev: &pci::Device<Core<'_>>, info: &Self::IdInfo) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        pdev: &'bound pci::Device<Core<'_>>,
+        info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             let vendor = pdev.vendor_id();
             dev_dbg!(
-- 
2.54.0

