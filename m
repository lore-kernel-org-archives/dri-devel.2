Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4B4C43458
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3F3510E61A;
	Sun, 28 Jun 2026 14:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T5Awz6sZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB33510E61A
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:54:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C320B43ADF;
 Sun, 28 Jun 2026 14:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57AC1F00A3A;
 Sun, 28 Jun 2026 14:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782658465;
 bh=SCbMZuGgOBfjbMGFeTZTjFc0XokSoalUCmtTidvSvFY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=T5Awz6sZWmxAhsaRZ6foBOuiIAEChkIYx+w/+NOM8FW3pmxhhbIKglG2LchgLWk7H
 zsMHoxzBofngmcxELZEK8OddkQgqzKM2gIWm/8BEFi21aMMhJucPxoO7WoE3t6pJFR
 SmQSGh4xKrWqz16pHkZmP64L0rq2FthM2uvDl14z6qqgf0zIG0T/IU0my37oqpFJ04
 xOiGFFq4E2D0hjAOj+SexhM9UTeQFKK9E/hsUj71DzgMHHJ7+/Y4sLXrI5RBFPg8iX
 9LUMKgD934btnb/vaQ374RrTw6dokM+/ZtJkjc384TH8Zvy7xMgpS2LKyAME3HYhjy
 t0NZWUi00HzfA==
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
Subject: [PATCH v5 03/19] rust: faux: add Device type with AsBusDevice support
Date: Sun, 28 Jun 2026 16:53:23 +0200
Message-ID: <20260628145406.2107056-4-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628145406.2107056-1-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
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

Add a faux::Device type that wraps struct faux_device and implements
AsBusDevice, enabling faux devices to be used as parent devices for
subsystems that require a bus device, such as DRM.

Update Registration to return &faux::Device<Bound> via AsRef.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/gem/shmem.rs     | 11 +++--
 rust/kernel/faux.rs              | 69 +++++++++++++++++++++++++++-----
 samples/rust/rust_driver_faux.rs |  3 +-
 3 files changed, 68 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 3ee19ef6264e..52de59b14dad 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -692,10 +692,12 @@ impl drm::Driver for KunitDriver {
     fn create_drm_dev() -> Result<(faux::Registration, UnregisteredDevice<KunitDriver>)> {
         // Create a faux DRM device so we can test gem object creation.
         let data = try_pin_init!(KunitData {});
-        let dev = faux::Registration::new(c"Kunit", None)?;
-        let drm = UnregisteredDevice::new(dev.as_ref(), data)?;
+        let reg = faux::Registration::new(c"Kunit", None)?;
+        let fdev = reg.as_ref();
+        let dev = fdev.as_ref();
+        let drm = UnregisteredDevice::new(dev, data)?;
 
-        Ok((dev, drm))
+        Ok((reg, drm))
     }
 
     #[test]
@@ -755,7 +757,8 @@ fn vmap_io() -> Result {
     #[test]
     fn fail_sg_table_on_wrong_dev() -> Result {
         let (_dev, drm) = create_drm_dev()?;
-        let wrong_dev = faux::Registration::new(c"EvilKunit", None)?;
+        let reg = faux::Registration::new(c"EvilKunit", None)?;
+        let wrong_dev = reg.as_ref();
 
         let obj = Object::<KunitObject, _>::new(&drm, PAGE_SIZE, ObjectConfig::default(), ())?;
 
diff --git a/rust/kernel/faux.rs b/rust/kernel/faux.rs
index 36c92ae2943c..cd0724af446b 100644
--- a/rust/kernel/faux.rs
+++ b/rust/kernel/faux.rs
@@ -9,15 +9,63 @@
 use crate::{
     bindings,
     device,
-    prelude::*, //
+    prelude::*,
+    types::Opaque, //
 };
-use core::ptr::{
-    addr_of_mut,
-    null,
-    null_mut,
-    NonNull, //
+use core::{
+    marker::PhantomData,
+    ptr::{
+        null,
+        null_mut,
+        NonNull, //
+    },
 };
 
+/// A faux device.
+///
+/// A faux device is a virtual device backed by the faux bus, primarily used for scenarios where a
+/// real hardware device is not available or for testing.
+///
+/// # Invariants
+///
+/// The underlying `struct faux_device` is valid and the embedded `struct device` is initialized.
+#[repr(transparent)]
+pub struct Device<Ctx: device::DeviceContext = device::Normal>(
+    Opaque<bindings::faux_device>,
+    PhantomData<Ctx>,
+);
+
+impl<Ctx: device::DeviceContext> Device<Ctx> {
+    #[inline]
+    fn as_raw(&self) -> *mut bindings::faux_device {
+        self.0.get()
+    }
+
+    /// # Safety
+    ///
+    /// `ptr` must be a valid pointer to a `struct faux_device`.
+    #[inline]
+    unsafe fn from_raw<'a>(ptr: *mut bindings::faux_device) -> &'a Self {
+        // SAFETY: `Device` is a transparent wrapper of `Opaque<bindings::faux_device>`.
+        unsafe { &*ptr.cast() }
+    }
+}
+
+impl<Ctx: device::DeviceContext> AsRef<device::Device<Ctx>> for Device<Ctx> {
+    #[inline]
+    fn as_ref(&self) -> &device::Device<Ctx> {
+        // SAFETY: By the type invariant of `Self`, `self.as_raw()` is a pointer to a valid
+        // `struct faux_device`. `dev` points to a valid `struct device`.
+        unsafe { device::Device::from_raw(&raw mut (*self.as_raw()).dev) }
+    }
+}
+
+// SAFETY: `faux::Device` is a transparent wrapper of `struct faux_device`.
+// The offset is guaranteed to point to a valid device field inside `faux::Device`.
+unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx> {
+    const OFFSET: usize = core::mem::offset_of!(bindings::faux_device, dev);
+}
+
 /// The registration of a faux device.
 ///
 /// This type represents the registration of a [`struct faux_device`]. When an instance of this type
@@ -60,10 +108,11 @@ fn as_raw(&self) -> *mut bindings::faux_device {
     }
 }
 
-impl AsRef<device::Device<device::Bound>> for Registration {
-    fn as_ref(&self) -> &device::Device<device::Bound> {
+impl AsRef<Device<device::Bound>> for Registration {
+    #[inline]
+    fn as_ref(&self) -> &Device<device::Bound> {
         // SAFETY:
-        // - The underlying `device` in `faux_device` is guaranteed by the C API to be a valid
+        // - The underlying `struct faux_device` is guaranteed by the C API to be a valid
         //   initialized `device`.
         // - `faux_match()` always returns 1, and probe runs synchronously
         //   (PROBE_FORCE_SYNCHRONOUS).
@@ -71,7 +120,7 @@ fn as_ref(&self) -> &device::Device<device::Bound> {
         //   sysfs.
         // - `mem::forget(Registration)` is not a problem; if the `Registration` is leaked, the faux
         //   device stays bound forever.
-        unsafe { device::Device::from_raw(addr_of_mut!((*self.as_raw()).dev)) }
+        unsafe { Device::from_raw(self.as_raw()) }
     }
 }
 
diff --git a/samples/rust/rust_driver_faux.rs b/samples/rust/rust_driver_faux.rs
index 99876c8e3743..27b6d3e2bb44 100644
--- a/samples/rust/rust_driver_faux.rs
+++ b/samples/rust/rust_driver_faux.rs
@@ -25,8 +25,9 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Initialising Rust Faux Device Sample\n");
 
         let reg = faux::Registration::new(c"rust-faux-sample-device", None)?;
+        let fdev = reg.as_ref();
 
-        dev_info!(reg, "Hello from faux device!\n");
+        dev_info!(fdev, "Hello from faux device!\n");
 
         Ok(Self { _reg: reg })
     }
-- 
2.54.0

