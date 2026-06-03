Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC57ECD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 23:19:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD0C11249F;
	Wed,  3 Jun 2026 23:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="F0bhzAhZ";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC19411249F
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 23:19:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780528760; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=J4kGOTEDDnPsHyM7Kh9Tm14KVYGI4yohOBInH9u83JBtTj5IUxGC/UWNcqU22uYHt4vt5tNsFn+dnurd818pJcUDzVRB7rVtQSdXlef4cGk5AIjQltQCannc5Azh9aBSR0h0yv/UG+N95j/F2wETNqAAZ/3kdz4aOjudSKboVEc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780528760;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=B48BPaNiNgsQNhS0VcH5Lp6S14iMdPnq6gxBl8tiFJw=; 
 b=arYXrMYDWkMlmb3Fw13kEsEBHZS5fSMMg00EJj6VxYlifBb04mbkmWZKHKcdB5Z+qs0v/nhq68aoY0qlP0dYnJgx2gMJ2LmWCOaN0/uipFY7f7/dawrWWUbqLIN1FWeNHFMpV8qYPyWhTyyP1KsvBTz6+xXVgaQfGNYZVh0nGWw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780528760; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=B48BPaNiNgsQNhS0VcH5Lp6S14iMdPnq6gxBl8tiFJw=;
 b=F0bhzAhZRE9RHvPkwWGnSkte+mIBaOgnF4H0aFGO4CEvdv6JtU75SF4pqR8zYXWL
 gpJ/RcCt9j8L9wN1BSTgus+aplMH8Nr/8zRdUdubVaBI4EYVYQxZE49k0P2WsBGMxI4
 CFV7BrRmjXG747H8tbKii4PuVOVR7wWGcryEvEnw=
Received: by mx.zohomail.com with SMTPS id 1780528758938572.0046341443704;
 Wed, 3 Jun 2026 16:19:18 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Wed, 03 Jun 2026 16:19:13 -0700
Subject: [PATCH] drm/tyr: move probe resources into registration data
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-use_tyr_reg_data-v1-1-97f64e951cf6@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBNsBIOuEiGWk82mYqwopLsnL
 d/i/wyJhClBV2UQujjxthY0dQXT4tdIikMxoEarrTbqTOSOR5xQdMEfXhlsUZO1I4YAJduFZr7
 /ZT+87wfN5Mv0YgAAAA==
X-Change-ID: 20260603-use_tyr_reg_data-32720e66b2dd
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, laura.nao@collabora.com, 
 boris.brezillon@collabora.com, samitolvanen@google.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10951;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=JRW3yM5b0Bc8CZNn9QITbrbszOsJjFMCOjZ1OyrLTEo=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkK28puHj4bf/XmX5crbbNfzW4+0mYu7OPnYT3fetFab
 S7JhpuaHaUsDGJcDLJiiixn7Y16xKveG+nO/98MM4eVCWQIAxenAEykJYLhf71okfWh6PK3nWqZ
 Z5grVwh8KmE7+P8Wk8/TuxoTZrW5ODD805lcM8XrX/ucp0lHdx7WLn7/956pxpwH+gJiqy3Y274
 eZQMA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

Introduce TyrDrmRegistrationData to hold resources that need to stay alive
while the DRM device is registered. This moves the parent platform device,
clocks, regulators, MMIO mapping, firmware state, and GPU info into data
owned by the DRM registration.

The registration data is tied to the platform device binding lifetime, so
use Registration::new_with_lt() and store the returned Registration in
the platform driver data.

Add initial firmware and MMU stubs so the registration data can own the
probe-time resources that firmware loading and GPU VM setup will need.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
This patch applies on top of the drm lifetime series [1] and the
full branch [2]

[1] https://lore.kernel.org/rust-for-linux/20260603011711.2077361-1-dakr@kernel.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=drm-lifetime
---
 drivers/gpu/drm/tyr/driver.rs | 51 +++++++++++++++++++++++++++-----
 drivers/gpu/drm/tyr/file.rs   | 11 +++----
 drivers/gpu/drm/tyr/fw.rs     | 69 +++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/mmu.rs    | 43 +++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs    |  2 ++
 5 files changed, 164 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 819f64a7573d..acf5080a5467 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -29,6 +29,7 @@
     sizes::SZ_2M,
     sync::{
         aref::ARef,
+        Arc,
         Mutex, //
     },
     time,
@@ -37,9 +38,11 @@
 
 use crate::{
     file::TyrDrmFileData,
+    fw::Firmware,
     gem::BoData,
     gpu,
     gpu::GpuInfo,
+    mmu::Mmu,
     regs::gpu_control::*, //
 };
 
@@ -49,7 +52,6 @@
 
 /// Convenience type alias for the DRM device type for this driver.
 pub(crate) type TyrDrmDevice<Ctx = drm::Registered> = drm::Device<TyrDrmDriver, Ctx>;
-
 pub(crate) struct TyrPlatformDriver;
 
 #[pin_data(PinnedDrop)]
@@ -59,21 +61,36 @@ pub(crate) struct TyrPlatformDriverData<'bound> {
 }
 
 #[pin_data]
-pub(crate) struct TyrDrmDeviceData {
+pub(crate) struct TyrDrmDeviceData;
+
+/// Resources kept alive by the DRM registration.
+#[pin_data]
+pub(crate) struct TyrDrmRegistrationData<'bound> {
+    /// Parent platform device.
     pub(crate) pdev: ARef<platform::Device>,
 
+    /// Firmware sections.
+    pub(crate) fw: Arc<Firmware<'bound>>,
+
     #[pin]
     clks: Mutex<Clocks>,
 
     #[pin]
     regulators: Mutex<Regulators>,
 
+    /// GPU MMIO register mapping.
+    pub(crate) iomem: Arc<IoMem<'bound>>,
+
     /// Some information on the GPU.
     ///
     /// This is mainly queried by userspace, i.e.: Mesa.
     pub(crate) gpu_info: GpuInfo,
 }
 
+impl ForLt for TyrDrmRegistrationData<'static> {
+    type Of<'bound> = TyrDrmRegistrationData<'bound>;
+}
+
 fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
     iomem.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
 
@@ -119,7 +136,7 @@ fn probe<'bound>(
         let sram_regulator = Regulator::<regulator::Enabled>::get(pdev.as_ref(), c"sram")?;
 
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
-        let iomem = request.iomap_sized::<SZ_2M>()?;
+        let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?, GFP_KERNEL)?;
 
         issue_soft_reset(pdev.as_ref(), &iomem)?;
         gpu::l2_power_on(pdev.as_ref(), &iomem)?;
@@ -137,8 +154,23 @@ fn probe<'bound>(
 
         let platform: ARef<platform::Device> = pdev.into();
 
-        let data = try_pin_init!(TyrDrmDeviceData {
+        let dev_data = try_pin_init!(TyrDrmDeviceData {});
+
+        let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, dev_data)?;
+
+        let mmu = Mmu::new(iomem.as_arc_borrow(), &gpu_info)?;
+
+        let firmware = Firmware::new(
+            pdev,
+            iomem.clone(),
+            &unreg_dev,
+            mmu.as_arc_borrow(),
+            &gpu_info,
+        )?;
+
+        let reg_data = try_pin_init!(TyrDrmRegistrationData {
                 pdev: platform.clone(),
+                fw: firmware,
                 clks <- new_mutex!(Clocks {
                     core: core_clk,
                     stacks: stacks_clk,
@@ -148,11 +180,16 @@ fn probe<'bound>(
                     _mali: mali_regulator,
                     _sram: sram_regulator,
                 }),
+                iomem,
                 gpu_info,
         });
 
-        let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
-        let reg = drm::Registration::new(pdev.as_ref(), tdev, (), 0)?;
+        // SAFETY: `reg` is stored in the platform driver data and is not leaked or
+        // forgotten, so it is dropped before the `'bound` registration data can become
+        // invalid.
+        let reg = unsafe {
+            drm::driver::Registration::new_with_lt(pdev.as_ref(), unreg_dev, reg_data, 0)?
+        };
 
         let driver = TyrPlatformDriverData {
             _device: reg.device().into(),
@@ -184,7 +221,7 @@ fn drop(self: Pin<&mut Self>) {}
 #[vtable]
 impl drm::Driver for TyrDrmDriver {
     type Data = TyrDrmDeviceData;
-    type RegistrationData = ForLt!(());
+    type RegistrationData = TyrDrmRegistrationData<'static>;
     type File = TyrDrmFileData;
     type Object<R: drm::DeviceContext> = drm::gem::shmem::Object<BoData, R>;
     type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 9f53da7633ab..9baec67febc9 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -11,7 +11,8 @@
 
 use crate::driver::{
     TyrDrmDevice,
-    TyrDrmDriver, //
+    TyrDrmDriver,
+    TyrDrmRegistrationData, //
 };
 
 #[pin_data]
@@ -30,16 +31,16 @@ fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
 
 impl TyrDrmFileData {
     pub(crate) fn dev_query(
-        ddev: &TyrDrmDevice,
+        _ddev: &TyrDrmDevice,
         _pdev: &platform::Device<device::Bound>,
-        _reg_data: &(),
+        reg_data: &TyrDrmRegistrationData<'_>,
         devquery: &mut uapi::drm_panthor_dev_query,
         _file: &TyrDrmFile,
     ) -> Result<u32> {
         if devquery.pointer == 0 {
             match devquery.type_ {
                 uapi::drm_panthor_dev_query_type_DRM_PANTHOR_DEV_QUERY_GPU_INFO => {
-                    devquery.size = core::mem::size_of_val(&ddev.gpu_info) as u32;
+                    devquery.size = core::mem::size_of_val(&reg_data.gpu_info) as u32;
                     Ok(0)
                 }
                 _ => Err(EINVAL),
@@ -53,7 +54,7 @@ pub(crate) fn dev_query(
                     )
                     .writer();
 
-                    writer.write(&ddev.gpu_info)?;
+                    writer.write(&reg_data.gpu_info)?;
 
                     Ok(0)
                 }
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
new file mode 100644
index 000000000000..4872e1a07c05
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Firmware loading and management for Mali CSF GPUs.
+//!
+//! This is currently only a lifetime/resource stub. The actual firmware parser,
+//! section loading, MCU VM mapping, and boot sequence will be added later.
+#![allow(dead_code)]
+
+use kernel::{
+    device::Bound,
+    drm::Uninit,
+    platform,
+    prelude::*,
+    sync::{
+        aref::ARef,
+        Arc,
+        ArcBorrow, //
+    }, //
+};
+
+use crate::{
+    driver::{
+        IoMem,
+        TyrDrmDevice, //
+    },
+    gpu::GpuInfo,
+    mmu::Mmu, //
+};
+
+/// Firmware state for a bound Tyr device.
+///
+/// For now this only keeps the device resources alive. Later this will own the
+/// loaded firmware sections, MCU VM mappings, and boot state.
+pub(crate) struct Firmware<'bound> {
+    /// Parent platform device.
+    _pdev: ARef<platform::Device>,
+
+    /// MMIO mapping used for firmware/MCU register access.
+    _iomem: Arc<IoMem<'bound>>,
+}
+
+impl<'bound> Firmware<'bound> {
+    /// Create firmware state for this device.
+    ///
+    /// This stub only records the resources that future firmware loading code
+    /// will need.
+    pub(crate) fn new(
+        pdev: &'bound platform::Device<Bound>,
+        iomem: Arc<IoMem<'bound>>,
+        _ddev: &TyrDrmDevice<Uninit>,
+        _mmu: ArcBorrow<'_, Mmu<'bound>>,
+        _gpu_info: &GpuInfo,
+    ) -> Result<Arc<Firmware<'bound>>> {
+        Ok(Arc::new(
+            Self {
+                _pdev: pdev.into(),
+                _iomem: iomem,
+            },
+            GFP_KERNEL,
+        )?)
+    }
+
+    /// Boot the firmware.
+    ///
+    /// This is a placeholder until the MCU boot sequence is implemented.
+    pub(crate) fn boot(&self) -> Result {
+        todo!()
+    }
+}
diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
new file mode 100644
index 000000000000..7cbfbe39a290
--- /dev/null
+++ b/drivers/gpu/drm/tyr/mmu.rs
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Memory Management Unit (MMU) driver for the Tyr GPU.
+//!
+//! This is currently only a lifetime/resource stub.
+//! The actual MMU initialization, page table management, and GPU VM mapping will be added later.
+
+use core::marker::PhantomData;
+
+use kernel::{
+    prelude::*,
+    sync::{
+        Arc, //
+        ArcBorrow,
+    },
+};
+
+use crate::{
+    driver::IoMem,
+    gpu::GpuInfo,
+    regs::gpu_control::AS_PRESENT, //
+};
+
+pub(super) struct Mmu<'bound> {
+    _bound: PhantomData<&'bound ()>,
+}
+
+impl<'bound> Mmu<'bound> {
+    pub(super) fn new(
+        _iomem: ArcBorrow<'_, IoMem<'bound>>,
+        gpu_info: &GpuInfo,
+    ) -> Result<Arc<Mmu<'bound>>> {
+        let present = AS_PRESENT::from_raw(gpu_info.as_present).present().get();
+        let slot_count: usize = present.count_ones().try_into()?;
+        pr_info!("MMU: {} address space slots present", slot_count);
+        Ok(Arc::new(
+            Mmu {
+                _bound: PhantomData,
+            },
+            GFP_KERNEL,
+        )?)
+    }
+}
diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
index 95cda7b0962f..d4c2a474b712 100644
--- a/drivers/gpu/drm/tyr/tyr.rs
+++ b/drivers/gpu/drm/tyr/tyr.rs
@@ -9,8 +9,10 @@
 
 mod driver;
 mod file;
+mod fw;
 mod gem;
 mod gpu;
+mod mmu;
 mod regs;
 
 kernel::module_platform_driver! {

---
base-commit: 0fb675787f89bb4a9c820fc8e9ad5ab13ea3adb7
change-id: 20260603-use_tyr_reg_data-32720e66b2dd

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

