Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD43C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 21:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26DB910F717;
	Thu,  9 Jul 2026 21:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="jdjOPCE9";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74F8410F717
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 21:37:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783633022; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=WzI7T91FaT+UzlRFwfB9SrLX9fkJatvaTJFucrEEjlhKn0m4oSRoEgsKxU16WSNIK8LAZGhJLCZg2A0wdwmRbSPaMKglBf8/24EbgOLJ5OI2NVhCgUxBHvput2LBKcq3AC5TABL7HAk0XgYiwX23+HMWK2sw5J+DNUr/BoKAEps=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783633022;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YyzHCJDcTFAcn3xwRPMPR7TZeYOMB53lwdlLSEE0YqE=; 
 b=HAoGnOd4GtTBSTbRj0wuKVrFBkSnFTK9xI1m6RaOnq5pB7TDYfurP2Uu0LBpMOyBRAzF5azZR+SVCHtoR6C+xmCQfa47UWrN5ExWEWrbYAQ8o1+Fp50MYWZUdLdTjGtfryWiyq4oWNIx5NF9tSwZlehG4wevqjDgAkf5SleI9Ck=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783633022; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=YyzHCJDcTFAcn3xwRPMPR7TZeYOMB53lwdlLSEE0YqE=;
 b=jdjOPCE9ZGspDmIoG8pkcHZZWCgPlr7I9Ca0t7Ee2b0RhCSadVeoJPYimBh/cs1I
 rnt3qtrkIRGuA0zCXkmQkn4ax2R0xVPWaOET8EBj3cGCEDhq58sQk1lbO2ziAJOvIOa
 iNJyCbrD6nDs8NjfocBpcE1YziPl7HeD5tKQz3V4=
Received: by mx.zohomail.com with SMTPS id 1783633020102274.5745984966967;
 Thu, 9 Jul 2026 14:37:00 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Thu, 09 Jul 2026 14:36:47 -0700
Subject: [PATCH v6 7/7] drm/tyr: add Microcontroller Unit (MCU) booting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-fw-boot-b4-v6-7-ca391e1a4108@collabora.com>
References: <20260709-fw-boot-b4-v6-0-ca391e1a4108@collabora.com>
In-Reply-To: <20260709-fw-boot-b4-v6-0-ca391e1a4108@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 boris.brezillon@collabora.com, samitolvanen@google.com, acourbot@nvidia.com, 
 alvin.sun@linux.dev, laura.nao@collabora.com, work@onurozkan.dev, 
 beata.michalska@arm.com, steven.price@arm.com, lyude@redhat.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13706;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=7iTOgphSoklmzfu5DFXT5pB0Q4BsI2FrrIrkk57YEWk=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkBIiXejzOKpooG8M8RCNxc8p1RoNlv0zEn6VfLLshm7
 VVav9+no5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgIns/87wz7jn9Z7wGfmHg8xn
 1vDl6G74XXCy1O1+8Da1e3MvN890O8Pw3/HX3eWv/W6nrw/lnJPnLprkeTa2+luKE3Niz7mgZ2e
 ieQE=
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

Add a firmware module to load, parse, and map the MCU firmware sections
into shared GEM memory at the required virtual addresses accessible by the
GPU.

Create a firmware instance during probe and store it inside the
TyrDrmRegistrationData to keep it alive after probe. Use the firmware
instance to boot the MCU.

Remove the dead-code annotations from the MMU, VM, slot manager, and
kernel BO code now that these paths are used by the firmware module.

Update Kconfig to add the RUST_FW_LOADER_ABSTRACTIONS dependency
required by this module.

Co-developed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/Kconfig   |   1 +
 drivers/gpu/drm/tyr/driver.rs |  17 ++-
 drivers/gpu/drm/tyr/fw.rs     | 263 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs    |   3 -
 drivers/gpu/drm/tyr/mmu.rs    |   1 -
 drivers/gpu/drm/tyr/slot.rs   |   1 -
 drivers/gpu/drm/tyr/tyr.rs    |   1 +
 drivers/gpu/drm/tyr/vm.rs     |   1 -
 8 files changed, 281 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tyr/Kconfig b/drivers/gpu/drm/tyr/Kconfig
index 79ea4bb214de..8f13e49f11f9 100644
--- a/drivers/gpu/drm/tyr/Kconfig
+++ b/drivers/gpu/drm/tyr/Kconfig
@@ -13,6 +13,7 @@ config DRM_TYR
 	select IOMMU_IO_PGTABLE_LPAE
 	select RUST_DRM_GEM_SHMEM_HELPER
 	select RUST_DRM_GPUVM
+	select RUST_FW_LOADER_ABSTRACTIONS
 	help
 	  Rust DRM driver for ARM Mali CSF-based GPUs.
 
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 9195c8be5203..46ba91af9aca 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -37,6 +37,7 @@
 
 use crate::{
     file::TyrDrmFileData,
+    fw::Firmware,
     gem::Bo,
     gpu,
     gpu::GpuInfo,
@@ -67,6 +68,9 @@ pub(crate) struct TyrDrmRegistrationData<'bound> {
     /// Parent platform device.
     pub(crate) pdev: &'bound platform::Device<Bound>,
 
+    /// Firmware sections.
+    pub(crate) fw: Firmware<'bound>,
+
     #[pin]
     clks: Mutex<Clocks>,
 
@@ -144,10 +148,21 @@ fn probe<'bound>(
 
         let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
 
-        let _mmu = Mmu::new(iomem.as_arc_borrow(), &gpu_info)?;
+        let mmu = Mmu::new(iomem.as_arc_borrow(), &gpu_info)?;
+
+        let firmware = Firmware::new(
+            pdev.as_ref(),
+            iomem.clone(),
+            &unreg_dev,
+            mmu.as_arc_borrow(),
+            &gpu_info,
+        )?;
+
+        firmware.boot()?;
 
         let reg_data = try_pin_init!(TyrDrmRegistrationData {
                 pdev,
+                fw: firmware,
                 clks <- new_mutex!(Clocks {
                     core: core_clk,
                     stacks: stacks_clk,
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
new file mode 100644
index 000000000000..554808a792aa
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -0,0 +1,263 @@
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
+    device::{
+        Bound,
+        Device, //
+    },
+    drm::{
+        gem::BaseObject, //
+    },
+    impl_flags,
+    io::{
+        poll,
+        Io, //
+    },
+    prelude::*,
+    str::CString,
+    sync::{
+        Arc,
+        ArcBorrow, //
+    },
+    time, //
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
+
+    mmu::Mmu,
+    regs::{
+        gpu_control::{
+            McuControlMode,
+            McuStatus,
+            GPU_ID,
+            MCU_CONTROL,
+            MCU_STATUS, //
+        }, //
+        job_control::JOB_IRQ_RAWSTAT, //
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
+struct Section<'bound> {
+    // Raw firmware section data for reset purposes
+    #[expect(dead_code)]
+    data: KVec<u8>,
+
+    // Keep the BO backing this firmware section so that both the
+    // GPU mapping and CPU mapping remain valid until the Section is dropped.
+    #[expect(dead_code)]
+    mem: gem::KernelBo<'bound>,
+}
+
+/// Loaded firmware with sections mapped into MCU VM.
+pub(crate) struct Firmware<'bound> {
+    /// Iomem need to access registers.
+    iomem: Arc<IoMem<'bound>>,
+
+    /// MCU VM.
+    vm: Arc<Vm<'bound>>,
+
+    /// List of firmware sections.
+    #[expect(dead_code)]
+    sections: KVec<Section<'bound>>,
+}
+
+impl<'bound> Drop for Firmware<'bound> {
+    fn drop(&mut self) {
+        // AS slots retain a VM ref, we need to kill the circular ref manually.
+        self.vm.kill();
+    }
+}
+
+impl<'bound> Firmware<'bound> {
+    fn init_section_mem(mem: &mut KernelBo<'bound>, data: &KVec<u8>) -> Result {
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
+    fn request(ddev: &TyrDrmDevice, gpu_info: &GpuInfo) -> Result<kernel::firmware::Firmware> {
+        let gpu_id = GPU_ID::from_raw(gpu_info.gpu_id);
+
+        let path = CString::try_from_fmt(fmt!(
+            "arm/mali/arch{}.{}/mali_csffw.bin",
+            gpu_id.arch_major().get(),
+            gpu_id.arch_minor().get()
+        ))?;
+
+        kernel::firmware::Firmware::request(&path, ddev.as_ref().as_ref())
+    }
+
+    fn load(
+        ddev: &TyrDrmDevice,
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
+        dev: &'bound Device<Bound>,
+        iomem: Arc<IoMem<'bound>>,
+        ddev: &TyrDrmDevice,
+        mmu: ArcBorrow<'_, Mmu<'bound>>,
+        gpu_info: &GpuInfo,
+    ) -> Result<Firmware<'bound>> {
+        let vm = Vm::new(dev, ddev, mmu, gpu_info)?;
+        vm.activate()?;
+
+        let (fw, parsed_sections) = Self::load(ddev, gpu_info)?;
+        let mut sections = KVec::new();
+        for parsed in parsed_sections {
+            let size = (parsed.va.end - parsed.va.start) as usize;
+            let va = u64::from(parsed.va.start);
+
+            let mut mem = KernelBo::new(
+                ddev,
+                vm.clone(),
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
+        let firmware = Firmware {
+            iomem,
+            vm,
+            sections,
+        };
+
+        Ok(firmware)
+    }
+
+    pub(crate) fn boot(&self) -> Result {
+        let io = &self.iomem;
+        io.write_reg(MCU_CONTROL::zeroed().with_req(McuControlMode::Auto));
+
+        if let Err(e) = poll::read_poll_timeout(
+            || Ok((io.read(MCU_STATUS), io.read(JOB_IRQ_RAWSTAT))),
+            |(mcu_status, irq_rawstat)| {
+                mcu_status.value() == McuStatus::Enabled && irq_rawstat.glb()
+            },
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
index 47a05a33388e..e9bf35682a47 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -72,7 +72,6 @@ pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) -> Result<ARef<Bo>> {
 /// An automatic VA allocation strategy will be added in the future.
 pub(crate) enum KernelBoVaAlloc {
     /// Explicit VA address specified by the caller.
-    #[expect(dead_code)]
     Explicit(u64),
 }
 
@@ -85,7 +84,6 @@ pub(crate) enum KernelBoVaAlloc {
 /// When dropped, the buffer is automatically unmapped from the GPU VA space.
 pub(crate) struct KernelBo<'bound> {
     /// The underlying GEM buffer object.
-    #[expect(dead_code)]
     pub(crate) bo: ARef<Bo>,
     /// The GPU VM this buffer is mapped into.
     vm: Arc<Vm<'bound>>,
@@ -99,7 +97,6 @@ impl<'bound> KernelBo<'bound> {
     /// This function allocates a new shmem-backed GEM object and immediately maps
     /// it into the specified GPU virtual memory space. The mapping is automatically
     /// cleaned up when the [`KernelBo`] is dropped.
-    #[expect(dead_code)]
     pub(crate) fn new(
         ddev: &TyrDrmDevice,
         vm: Arc<Vm<'bound>>,
diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
index c0341557d730..0ed20e03569c 100644
--- a/drivers/gpu/drm/tyr/mmu.rs
+++ b/drivers/gpu/drm/tyr/mmu.rs
@@ -10,7 +10,6 @@
 //! The [`SlotManager`] manages the assignment of virtual address spaces to hardware address-space
 //! (AS) slots. MMU commands such as updates and flushes are carried out by the
 //! [`AddressSpaceManager`] which actually writes to the MMU registers.
-#![allow(dead_code)]
 
 use core::ops::Range;
 
diff --git a/drivers/gpu/drm/tyr/slot.rs b/drivers/gpu/drm/tyr/slot.rs
index 3f58b23238ef..bc70ea49f9f5 100644
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
index 92f6885cdaae..e7ec450bdc9c 100644
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
index 57929c2d3e94..54dfd5bbeab4 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -6,7 +6,6 @@
 //! the illusion of owning the entire virtual address (VA) range, similar to CPU virtual memory.
 //! Each virtual memory (VM) area is backed by ARM64 LPAE Stage 1 page tables and can be
 //! mapped into hardware address space (AS) slots for GPU execution.
-#![allow(dead_code)]
 
 use core::marker::PhantomData;
 use core::ops::Range;

-- 
2.54.0

