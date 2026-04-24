Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ABAFF885A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A7A10F707;
	Fri, 24 Apr 2026 23:40:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="O3ZRbk/v";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9956710F6FD
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777073973; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lX6mgycwtadmZmf4aM5E3+srCH6govgn2n3b2ARS50Dmmc8QikJszQ5erwr3WC6223F9PkGee5seaQTLjtmMVwb9e0ztdqt0UTfDI2lPosXy4HfNb2SK7JrpaK32jIgQugZIAqwjmUcCpeRdtQ2p+HB9w3Kiyvw396lQkGYU6PY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777073973;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=0htmUZ7cd0cYpXNM04syGCkizAjtah7yfT8aRdJ9awE=; 
 b=fuM9hsE5IGOg/j6WXiXQZRorh7W26X1PcHid8l2154wyo//cN9mi0TeMmbb/vmqSPR+gW4k6M0KCmaNbNQR7fYZLM23OeZONIvd8l16WbqPqo+/lz7wuOwgGT2cJG0H+KActSrlceANCpEHaobbAToIu9j0HGrfqCFCBEt8dwno=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777073973; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=0htmUZ7cd0cYpXNM04syGCkizAjtah7yfT8aRdJ9awE=;
 b=O3ZRbk/v9pBI3aWcwKqXCF8KkXuNOjBiV6PW8InjKS7YzOBuSUgerWCCa3jWgYSd
 WJmg4wbD6prA6oY+4k8DILLSUahWqRlDRyakCs6o4A4MIr0gE58VjakfYxCylymVOxH
 6HVyu0U8feUQENfrb6v0kXVoYC2vJu/aE4fYlfWg=
Received: by mx.zohomail.com with SMTPS id 1777073971418822.0534965186632;
 Fri, 24 Apr 2026 16:39:31 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 24 Apr 2026 16:39:07 -0700
Subject: [PATCH v4 13/20] drm/tyr: add firmware loading and MCU boot
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-b4-fw-boot-v4-v4-13-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
In-Reply-To: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13544;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=c4q67V7m5J8MVZYjpWxFtUzFl3nup07SAjdC7IcRBEc=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJmv/yukVVhM+SuetpK36WSUfOw+Pjuf32ImOyomFlhm5
 T5XXLK9o5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgIlcC2f4p/DBkrM/Xv54hNWX
 rN43zyOcjWP2X2GVmK90k8fpXKTUckaGNdaR81umV3ist93zg8tY9XJs5KNzJ/+yhd0XvR2TUSX
 ICQA=
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

Add firmware loading and management for the Mali CSF GPU. This introduces
the fw module that loads the Mali GPU firmware binary, parses it into
sections, and maps those sections into the MCU VM at the required
virtual addresses.

On probe, the firmware is loaded, its sections are mapped and populated,
the MCU VM is activated, and the MCU is booted.

Co-developed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/Kconfig   |   1 +
 drivers/gpu/drm/tyr/driver.rs |  16 ++-
 drivers/gpu/drm/tyr/fw.rs     | 272 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs    |   3 -
 drivers/gpu/drm/tyr/mmu.rs    |   1 -
 drivers/gpu/drm/tyr/slot.rs   |   1 -
 drivers/gpu/drm/tyr/tyr.rs    |   1 +
 drivers/gpu/drm/tyr/vm.rs     |   1 -
 8 files changed, 289 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tyr/Kconfig b/drivers/gpu/drm/tyr/Kconfig
index 443ce988b570..729643f4db49 100644
--- a/drivers/gpu/drm/tyr/Kconfig
+++ b/drivers/gpu/drm/tyr/Kconfig
@@ -18,6 +18,7 @@ config DRM_TYR
 	select DRM_TYR_STATIC_DEPS
 	select IOMMU_IO_PGTABLE_LPAE
 	select RUST_DRM_GEM_SHMEM_HELPER
+	select RUST_FW_LOADER_ABSTRACTIONS
 	depends on IOMMU_SUPPORT
 	default n
 	help
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 495021a8657d..246bc3cb8580 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -42,6 +42,7 @@
 
 use crate::{
     file::TyrDrmFileData,
+    fw::Firmware,
     gem::BoData,
     gpu,
     gpu::GpuInfo,
@@ -63,6 +64,8 @@
 pub(crate) struct TyrDrmDeviceData {
     pub(crate) pdev: ARef<platform::Device>,
 
+    pub(crate) fw: Arc<Firmware>,
+
     #[pin]
     clks: Mutex<Clocks>,
 
@@ -154,10 +157,21 @@ fn probe(
         let uninit_ddev = UnregisteredDevice::<TyrDrmDriver>::new(pdev.as_ref())?;
         let platform: ARef<platform::Device> = pdev.into();
 
-        let _mmu = Mmu::new(pdev, iomem.as_arc_borrow(), &gpu_info)?;
+        let mmu = Mmu::new(pdev, iomem.as_arc_borrow(), &gpu_info)?;
+
+        let firmware = Firmware::new(
+            pdev,
+            iomem.clone(),
+            &uninit_ddev,
+            mmu.as_arc_borrow(),
+            &gpu_info,
+        )?;
+
+        firmware.boot()?;
 
         let data = try_pin_init!(TyrDrmDeviceData {
                 pdev: platform.clone(),
+                fw: firmware,
                 clks <- new_mutex!(Clocks {
                     core: core_clk,
                     stacks: stacks_clk,
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
new file mode 100644
index 000000000000..cb2546350f0a
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -0,0 +1,272 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Firmware loading and management for Mali CSF GPU.
+//!
+//! This module handles loading the Mali GPU firmware binary, parsing it into sections,
+//! and mapping those sections into the MCU's virtual address space. Each firmware section
+//! has specific properties (read/write/execute permissions, cache modes) and must be loaded
+//! at specific virtual addresses expected by the MCU.
+//!
+//! See [`Firmware`] for the main firmware management interface and [`Section`] for
+//! individual firmware sections.
+//!
+//! [`Firmware`]: crate::fw::Firmware
+//! [`Section`]: crate::fw::Section
+
+use kernel::{
+    bits::genmask_u32,
+    devres::Devres,
+    drm::{
+        gem::BaseObject,
+        Uninit, //
+    },
+    impl_flags,
+    io::{
+        poll,
+        Io, //
+    },
+    platform,
+    prelude::*,
+    str::CString,
+    sync::{
+        Arc,
+        ArcBorrow, //
+    },
+    time,
+    types::ARef, //
+};
+
+use crate::{
+    driver::{
+        IoMem,
+        TyrDrmDevice, //
+    },
+    fw::parser::{
+        FwParser,
+        ParsedSection, //
+    },
+    gem,
+    gem::{
+        KernelBo,
+        KernelBoVaAlloc, //
+    },
+    gpu::GpuInfo,
+    mmu::Mmu,
+    regs::gpu_control::{
+        McuControlMode,
+        McuStatus,
+        GPU_ID,
+        MCU_CONTROL,
+        MCU_STATUS, //
+    },
+    vm::Vm, //
+};
+
+mod parser;
+
+impl_flags!(
+    #[derive(Debug, Clone, Default, Copy, PartialEq, Eq)]
+    pub(super) struct SectionFlags(u32);
+
+    #[derive(Debug, Clone, Copy, PartialEq, Eq)]
+    pub(super) enum SectionFlag {
+        Read = 1 << 0,
+        Write = 1 << 1,
+        Exec = 1 << 2,
+        CacheModeNone = 0 << 3,
+        CacheModeCached = 1 << 3,
+        CacheModeUncachedCoherent = 2 << 3,
+        CacheModeCachedCoherent = 3 << 3,
+        Prot = 1 << 5,
+        Shared = 1 << 30,
+        Zero = 1 << 31,
+    }
+);
+
+pub(super) const CACHE_MODE_MASK: SectionFlags = SectionFlags(genmask_u32(3..=4));
+
+pub(super) const CSF_MCU_SHARED_REGION_START: u32 = 0x04000000;
+
+impl SectionFlags {
+    fn cache_mode(&self) -> SectionFlags {
+        *self & CACHE_MODE_MASK
+    }
+}
+
+impl TryFrom<u32> for SectionFlags {
+    type Error = Error;
+
+    fn try_from(value: u32) -> Result<Self, Self::Error> {
+        let valid_flags = SectionFlags::from(SectionFlag::Read)
+            | SectionFlags::from(SectionFlag::Write)
+            | SectionFlags::from(SectionFlag::Exec)
+            | CACHE_MODE_MASK
+            | SectionFlags::from(SectionFlag::Prot)
+            | SectionFlags::from(SectionFlag::Shared)
+            | SectionFlags::from(SectionFlag::Zero);
+
+        if value & valid_flags.0 != value {
+            Err(EINVAL)
+        } else {
+            Ok(Self(value))
+        }
+    }
+}
+
+/// A parsed section of the firmware binary.
+struct Section {
+    // Raw firmware section data for reset purposes
+    #[expect(dead_code)]
+    data: KVec<u8>,
+
+    // Keep the BO backing this firmware section so that both the
+    // GPU mapping and CPU mapping remain valid until the Section is dropped.
+    #[expect(dead_code)]
+    mem: gem::KernelBo,
+}
+
+/// Loaded firmware with sections mapped into MCU VM.
+pub(crate) struct Firmware {
+    /// Platform device reference (needed to access the MCU JOB_IRQ registers).
+    pdev: ARef<platform::Device>,
+
+    /// Iomem need to access registers.
+    iomem: Arc<Devres<IoMem>>,
+
+    /// MCU VM.
+    vm: Arc<Vm>,
+
+    /// List of firmware sections.
+    #[expect(dead_code)]
+    sections: KVec<Section>,
+}
+
+impl Drop for Firmware {
+    fn drop(&mut self) {
+        // AS slots retain a VM ref, we need to kill the circular ref manually.
+        self.vm.kill();
+    }
+}
+
+impl Firmware {
+    fn init_section_mem(mem: &mut KernelBo, data: &KVec<u8>) -> Result {
+        if data.is_empty() {
+            return Ok(());
+        }
+
+        let vmap = mem.bo.vmap::<0>()?;
+        let size = mem.bo.size();
+
+        if data.len() > size {
+            pr_err!("fw section {} bigger than BO {}\n", data.len(), size);
+            return Err(EINVAL);
+        }
+
+        for (i, &byte) in data.iter().enumerate() {
+            vmap.try_write8(byte, i)?;
+        }
+
+        Ok(())
+    }
+
+    fn request(
+        ddev: &TyrDrmDevice<Uninit>,
+        gpu_info: &GpuInfo,
+    ) -> Result<kernel::firmware::Firmware> {
+        let gpu_id = GPU_ID::from_raw(gpu_info.gpu_id);
+
+        let path = CString::try_from_fmt(fmt!(
+            "arm/mali/arch{}.{}/mali_csffw.bin",
+            gpu_id.arch_major().get(),
+            gpu_id.arch_minor().get()
+        ))?;
+
+        kernel::firmware::Firmware::request(&path, ddev.as_ref())
+    }
+
+    fn load(
+        ddev: &TyrDrmDevice<Uninit>,
+        gpu_info: &GpuInfo,
+    ) -> Result<(kernel::firmware::Firmware, KVec<ParsedSection>)> {
+        let fw = Self::request(ddev, gpu_info)?;
+        let mut parser = FwParser::new(fw.data());
+
+        let parsed_sections = parser.parse()?;
+
+        Ok((fw, parsed_sections))
+    }
+
+    /// Load firmware and map sections into MCU VM.
+    pub(crate) fn new(
+        pdev: &platform::Device,
+        iomem: Arc<Devres<IoMem>>,
+        ddev: &TyrDrmDevice<Uninit>,
+        mmu: ArcBorrow<'_, Mmu>,
+        gpu_info: &GpuInfo,
+    ) -> Result<Arc<Firmware>> {
+        let vm = Vm::new(pdev, ddev, mmu, gpu_info)?;
+
+        let (fw, parsed_sections) = Self::load(ddev, gpu_info)?;
+
+        vm.activate()?;
+
+        let mut sections = KVec::new();
+        for parsed in parsed_sections {
+            let size = (parsed.va.end - parsed.va.start) as usize;
+            let va = u64::from(parsed.va.start);
+
+            let mut mem = KernelBo::new(
+                ddev,
+                vm.as_arc_borrow(),
+                size.try_into().unwrap(),
+                KernelBoVaAlloc::Explicit(va),
+                parsed.vm_map_flags,
+            )?;
+
+            let section_start = parsed.data_range.start as usize;
+            let section_end = parsed.data_range.end as usize;
+            let mut data = KVec::new();
+
+            // Ensure that the firmware slice is not out of bounds.
+            let fw_data = fw.data();
+            let bytes = fw_data.get(section_start..section_end).ok_or(EINVAL)?;
+            data.extend_from_slice(bytes, GFP_KERNEL)?;
+
+            Self::init_section_mem(&mut mem, &data)?;
+
+            sections.push(Section { data, mem }, GFP_KERNEL)?;
+        }
+
+        let firmware = Arc::new(
+            Firmware {
+                pdev: pdev.into(),
+                iomem,
+                vm,
+                sections,
+            },
+            GFP_KERNEL,
+        )?;
+
+        Ok(firmware)
+    }
+
+    pub(crate) fn boot(&self) -> Result {
+        // SAFETY: Boot is currently only called in the probe path, so we're sure we have a bound
+        // device.
+        let dev = unsafe { self.pdev.as_ref().as_bound() };
+        let io = (self.iomem).access(dev)?;
+        io.write_reg(MCU_CONTROL::zeroed().with_req(McuControlMode::Auto));
+
+        if let Err(e) = poll::read_poll_timeout(
+            || Ok(io.read(MCU_STATUS)),
+            |status| status.value() == McuStatus::Enabled,
+            time::Delta::from_millis(1),
+            time::Delta::from_millis(100),
+        ) {
+            let status = io.read(MCU_STATUS);
+            pr_err!("MCU failed to boot, status: {:?}", status.value());
+            return Err(e);
+        }
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index d032a8ae543f..4ec373e0bcfa 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -94,7 +94,6 @@ pub(crate) fn new_dummy_object<Ctx: DeviceContext>(ddev: &TyrDrmDevice<Ctx>) ->
 /// a [`KernelBo`]. An automatic VA allocation strategy will be added in the future.
 pub(crate) enum KernelBoVaAlloc {
     /// Explicit VA address specified by the caller.
-    #[expect(dead_code)]
     Explicit(u64),
 }
 
@@ -107,7 +106,6 @@ pub(crate) enum KernelBoVaAlloc {
 /// When dropped, the buffer is automatically unmapped from the GPU VA space.
 pub(crate) struct KernelBo {
     /// The underlying GEM buffer object.
-    #[expect(dead_code)]
     pub(crate) bo: ARef<Bo>,
     /// The GPU VM this buffer is mapped into.
     vm: Arc<Vm>,
@@ -121,7 +119,6 @@ impl KernelBo {
     /// This function allocates a new shmem-backed GEM object and immediately maps
     /// it into the specified GPU virtual memory space. The mapping is automatically
     /// cleaned up when the [`KernelBo`] is dropped.
-    #[expect(dead_code)]
     pub(crate) fn new<Ctx: DeviceContext>(
         ddev: &TyrDrmDevice<Ctx>,
         vm: ArcBorrow<'_, Vm>,
diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
index 09df98ffc9e3..935e2102ab30 100644
--- a/drivers/gpu/drm/tyr/mmu.rs
+++ b/drivers/gpu/drm/tyr/mmu.rs
@@ -12,7 +12,6 @@
 //!
 //! [`AddressSpaceManager`]: address_space::AddressSpaceManager
 //! [`SlotManager`]: crate::slot::SlotManager
-#![allow(dead_code)]
 
 use core::ops::Range;
 
diff --git a/drivers/gpu/drm/tyr/slot.rs b/drivers/gpu/drm/tyr/slot.rs
index debba75f6204..53abb9eeb970 100644
--- a/drivers/gpu/drm/tyr/slot.rs
+++ b/drivers/gpu/drm/tyr/slot.rs
@@ -20,7 +20,6 @@
 //!
 //! [SlotOperations]: crate::slot::SlotOperations
 //! [SlotManager]: crate::slot::SlotManager
-#![allow(dead_code)]
 
 use core::{
     mem::take,
diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
index b3244670dd79..18b0668bb217 100644
--- a/drivers/gpu/drm/tyr/tyr.rs
+++ b/drivers/gpu/drm/tyr/tyr.rs
@@ -9,6 +9,7 @@
 
 mod driver;
 mod file;
+mod fw;
 mod gem;
 mod gpu;
 mod mmu;
diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index c19300d76194..1ef7e40ccdb5 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -6,7 +6,6 @@
 //! the illusion of owning the entire virtual address (VA) range, similar to CPU virtual memory.
 //! Each virtual memory (VM) area is backed by ARM64 LPAE Stage 1 page tables and can be
 //! mapped into hardware address space (AS) slots for GPU execution.
-#![allow(dead_code)]
 
 use core::ops::Range;
 

-- 
2.53.0

