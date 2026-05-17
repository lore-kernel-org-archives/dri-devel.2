Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE09DCD4F3C
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 00:03:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14DAB10E58C;
	Sun, 17 May 2026 00:03:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XtGwfL8D";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F239F10E658
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 00:03:33 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 75803600BB;
 Sun, 17 May 2026 00:03:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B2EC19425;
 Sun, 17 May 2026 00:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778976213;
 bh=HnenYj+M4p4qXsQQTJ2FKMdGG+njf7P3a3XdXnokphw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XtGwfL8D4rLCRYovUzuxP1x5uDxfvnkOdhYR83Blktzf7gNSbzR5kg/9hD7Hoj4UK
 +YAxxW9ObPLquzvwzVo4eIVd0DcZg8wthiFopQE7VyUQDH1eGxftDrNKeGELyGRB4Z
 yB8mlahjHtAXeMEWPWyTjHZ23oUpmDuosyqplPYNygw0xqc+cBALz4hs+90LrNopgC
 14F8OEyWvw9AyxGDCuWR3nqk2SJudogUKDQ211Jmmc8MV9n5l4tok3Xivp5bTlVQK7
 yZzr+/CsbwJOV458v6qTggUZRg7a18vbv3utHHOgOT4eN4KgkF4RRiFv74m0TjRD8T
 ZNBXGTtB7H6VQ==
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
Subject: [PATCH v3 13/27] rust: usb: make Driver trait lifetime-parameterized
Date: Sun, 17 May 2026 02:01:01 +0200
Message-ID: <20260517000149.3226762-14-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517000149.3226762-1-dakr@kernel.org>
References: <20260517000149.3226762-1-dakr@kernel.org>
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

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/usb.rs              | 39 +++++++++++++++++++--------------
 samples/rust/rust_driver_usb.rs | 14 ++++++------
 2 files changed, 30 insertions(+), 23 deletions(-)

diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 995221d327b8..ec67e4d2416f 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -41,7 +41,7 @@
 // - `DEVICE_DRIVER_OFFSET` is the correct byte offset to the embedded `struct device_driver`.
 unsafe impl<T: Driver> driver::DriverLayout for Adapter<T> {
     type DriverType = bindings::usb_driver;
-    type DriverData<'bound> = T::Data;
+    type DriverData<'bound> = T::Data<'bound>;
     const DEVICE_DRIVER_OFFSET: usize = core::mem::offset_of!(Self::DriverType, driver);
 }
 
@@ -110,7 +110,7 @@ extern "C" fn disconnect_callback(intf: *mut bindings::usb_interface) {
         // SAFETY: `disconnect_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `Device::set_drvdata()` has been called
         // and stored a `Pin<KBox<T::Data>>`.
-        let data = unsafe { dev.drvdata_borrow::<T::Data>() };
+        let data = unsafe { dev.drvdata_borrow::<T::Data<'_>>() };
 
         T::disconnect(intf, data);
     }
@@ -287,18 +287,22 @@ macro_rules! usb_device_table {
 ///
 /// impl usb::Driver for MyDriver {
 ///     type IdInfo = ();
-///     type Data = Self;
+///     type Data<'bound> = Self;
 ///     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 ///
-///     fn probe(
-///         _interface: &usb::Interface<Core>,
-///         _id: &usb::DeviceId,
-///         _info: &Self::IdInfo,
-///     ) -> impl PinInit<Self::Data, Error> {
+///     fn probe<'bound>(
+///         _interface: &'bound usb::Interface<Core>,
+///         _id: &'bound usb::DeviceId,
+///         _info: &'bound Self::IdInfo,
+///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
 ///         Err(ENODEV)
 ///     }
 ///
-///     fn disconnect(_interface: &usb::Interface<Core>, _data: Pin<&Self::Data>) {}
+///     fn disconnect<'bound>(
+///         _interface: &'bound usb::Interface<Core>,
+///         _data: Pin<&'bound Self::Data<'bound>>,
+///     ) {
+///     }
 /// }
 ///```
 pub trait Driver {
@@ -306,7 +310,7 @@ pub trait Driver {
     type IdInfo: 'static;
 
     /// The type of the driver's bus device private data.
-    type Data;
+    type Data<'bound>: 'bound;
 
     /// The table of device ids supported by the driver.
     const ID_TABLE: IdTable<Self::IdInfo>;
@@ -315,16 +319,19 @@ pub trait Driver {
     ///
     /// Called when a new USB interface is bound to this driver.
     /// Implementers should attempt to initialize the interface here.
-    fn probe(
-        interface: &Interface<device::Core>,
-        id: &DeviceId,
-        id_info: &Self::IdInfo,
-    ) -> impl PinInit<Self::Data, Error>;
+    fn probe<'bound>(
+        interface: &'bound Interface<device::Core>,
+        id: &'bound DeviceId,
+        id_info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;
 
     /// USB driver disconnect.
     ///
     /// Called when the USB interface is about to be unbound from this driver.
-    fn disconnect(interface: &Interface<device::Core>, data: Pin<&Self::Data>);
+    fn disconnect<'bound>(
+        interface: &'bound Interface<device::Core>,
+        data: Pin<&'bound Self::Data<'bound>>,
+    );
 }
 
 /// A USB interface.
diff --git a/samples/rust/rust_driver_usb.rs b/samples/rust/rust_driver_usb.rs
index 5942e4b01fd8..4403bd758db9 100644
--- a/samples/rust/rust_driver_usb.rs
+++ b/samples/rust/rust_driver_usb.rs
@@ -26,21 +26,21 @@ struct SampleDriver {
 
 impl usb::Driver for SampleDriver {
     type IdInfo = ();
-    type Data = Self;
+    type Data<'bound> = Self;
     const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
 
-    fn probe(
-        intf: &usb::Interface<Core>,
-        _id: &usb::DeviceId,
-        _info: &Self::IdInfo,
-    ) -> impl PinInit<Self, Error> {
+    fn probe<'bound>(
+        intf: &'bound usb::Interface<Core>,
+        _id: &'bound usb::DeviceId,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
         let dev: &device::Device<Core> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample probed\n");
 
         Ok(Self { _intf: intf.into() })
     }
 
-    fn disconnect(intf: &usb::Interface<Core>, _data: Pin<&Self>) {
+    fn disconnect<'bound>(intf: &'bound usb::Interface<Core>, _data: Pin<&'bound Self>) {
         let dev: &device::Device<Core> = intf.as_ref();
         dev_info!(dev, "Rust USB driver sample disconnected\n");
     }
-- 
2.54.0

