Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CB8C54F54
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:40:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86BE510E9CC;
	Tue, 28 Jul 2026 18:40:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="abk7Qms9";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1182C10E9BC
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785263980; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jW1gsJnTT3rzFEHBF0sv5sk3z7Q4zqtCALvzv2JOgdb2fkKNHoBeaUbzcGRzwc7a6hO4HTbx/lsAwllP1c7JRhu+A/YlbneB65F2T5nl/42etzFSu0w+RsBDNZHupPRVjE1KearuB3F4hvjMevxk+cwC4lSkk6Dbhz3+rpa5vcs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785263980;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KZqnTX8OJYp6hqEzGylnlZsaRSrdWMSJfFgGXN97Nn4=; 
 b=A37FFFxg8AfV0LjcJuUMnK6vCg+DhtF7WP3+OZ3R5kSS8U2mLCHrnh8iIMsC+iFH9wVvA6PmbDozykok4fMab4S1JCFTluDqaoA92FkQ/DKX2ccDofxfCrXXk2D1Hk8cCCllQA+wM12zVM0eNCeAzPYtaWOiCeHxYcLH/BOjzpU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785263980; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=KZqnTX8OJYp6hqEzGylnlZsaRSrdWMSJfFgGXN97Nn4=;
 b=abk7Qms9cScqQ2QRFdYdWJvc8ci/dXXWTKwNzbFNYc5XR6+QyC7oJQz7zlAuCXuY
 cgpY1XP6zrQarIuXWVVc8rd2SL5oa7E7lV9C4Z5Y5qhbzpL/B+GTWZsTBZCI0aQaDWJ
 4ZOd/higTIZ27FxqRIRN8JCqJa3HNqrHTYETjaWw=
Received: by mx.zohomail.com with SMTPS id 1785263978292649.4934477571643;
 Tue, 28 Jul 2026 11:39:38 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 28 Jul 2026 11:39:29 -0700
Subject: [PATCH v10 7/7] drm/tyr: add Microcontroller Unit (MCU) booting
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-fw-boot-b4-v10-7-9187aefa3f2f@collabora.com>
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
In-Reply-To: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, laura.nao@collabora.com, 
 samitolvanen@google.com, lyude@redhat.com, beata.michalska@arm.com, 
 boris.brezillon@collabora.com, steven.price@arm.com, alvin.sun@linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=14498;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=6VlLRxsilTY4GlazTuiAKyRJUA9EMstCcSbGp/KR2ds=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkZ3xNyQuZMDHly/tRrvXpVOYvZYU/PByz4xWLzXDXWy
 6etpaWpo5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgImsvMbI8O2g0YH+7UZS53V3
 vQqdFPPSyvzpJsYf9u9vXp4faVPjFMXI0Oe6V7Su5vTb/N9OS3duXrTTTYtp/sr81JwU9QOtNsm
 T+AA=
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
 drivers/gpu/drm/tyr/driver.rs |  23 ++-
 drivers/gpu/drm/tyr/fw.rs     | 321 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs    |   3 -
 drivers/gpu/drm/tyr/tyr.rs    |   1 +
 drivers/gpu/drm/tyr/vm.rs     |   1 -
 6 files changed, 341 insertions(+), 9 deletions(-)

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
index f487b3996293..d78ad9d292ff 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -37,6 +37,7 @@
 
 use crate::{
     file::TyrDrmFileData,
+    fw::Firmware,
     gem::Bo,
     gpu,
     gpu::GpuInfo,
@@ -67,6 +68,9 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
     /// Parent platform device.
     pub(crate) pdev: &'drm platform::Device<Bound>,
 
+    /// Firmware sections.
+    pub(crate) fw: Firmware<'drm>,
+
     #[pin]
     clks: Mutex<Clocks>,
 
@@ -144,10 +148,21 @@ fn probe<'bound>(
 
         let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
 
-        let _mmu = Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &gpu_info)?;
+        let mmu = Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &gpu_info)?;
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
 
-        let reg_data = try_pin_init!(TyrDrmRegistrationData {
+        let reg_data = pin_init!(TyrDrmRegistrationData {
                 pdev,
+                fw: firmware,
                 clks <- new_mutex!(Clocks {
                     core: core_clk,
                     stacks: stacks_clk,
@@ -167,9 +182,7 @@ fn probe<'bound>(
 
         let driver = TyrPlatformDriverData { _reg: reg };
 
-        // We need this to be dev_info!() because dev_dbg!() does not work at
-        // all in Rust for now, and we need to see whether probe succeeded.
-        dev_info!(pdev, "Tyr initialized correctly.\n");
+        dev_dbg!(pdev, "Tyr initialized correctly.");
         Ok(driver)
     }
 }
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
new file mode 100644
index 000000000000..47d25c901bd0
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -0,0 +1,321 @@
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
+    device::{
+        Bound,
+        Device, //
+    },
+    drm::{
+        gem::BaseObject, //
+    },
+    io::{
+        poll,
+        Io, //
+    },
+    num::Bounded,
+    prelude::*,
+    register,
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
+        job_control::{
+            JOB_IRQ_CLEAR,
+            JOB_IRQ_RAWSTAT, //
+        }, //
+    },
+    vm::Vm, //
+};
+
+mod parser;
+
+pub(super) const CSF_MCU_SHARED_REGION_START: u32 = 0x04000000;
+
+#[derive(Copy, Clone, Debug, PartialEq, Eq)]
+#[repr(u8)]
+pub(super) enum CacheMode {
+    None = 0,
+    Cached = 1,
+    UncachedCoherent = 2,
+    CachedCoherent = 3,
+}
+
+impl From<Bounded<u32, 2>> for CacheMode {
+    fn from(value: Bounded<u32, 2>) -> Self {
+        match value.get() {
+            0 => Self::None,
+            1 => Self::Cached,
+            2 => Self::UncachedCoherent,
+            3 => Self::CachedCoherent,
+            _ => unreachable!(),
+        }
+    }
+}
+
+impl From<CacheMode> for Bounded<u32, 2> {
+    fn from(value: CacheMode) -> Self {
+        Bounded::try_new(value as u32).unwrap()
+    }
+}
+
+register! {
+     #[allow(non_upper_case_globals)]
+    pub(super) SectionFlags(u32) @ 0x0 {
+        0:0 read => bool;
+        1:1 write => bool;
+        2:2 exec => bool;
+        4:3 cache_mode => CacheMode;
+        5:5 prot => bool;
+        30:30 shared => bool;
+        31:31 zero => bool;
+    }
+}
+
+impl SectionFlags {
+    const VALID_MASK: u32 = Self::READ_MASK
+        | Self::WRITE_MASK
+        | Self::EXEC_MASK
+        | Self::CACHE_MODE_MASK
+        | Self::PROT_MASK
+        | Self::SHARED_MASK
+        | Self::ZERO_MASK;
+
+    fn try_from_fw(value: u32) -> Result<Self> {
+        if value & !Self::VALID_MASK != 0 {
+            Err(EINVAL)
+        } else {
+            Ok(Self::from_raw(value))
+        }
+    }
+}
+
+/// A parsed section of the firmware binary.
+struct Section<'drm> {
+    // Raw firmware section data for reset purposes
+    #[expect(dead_code)]
+    data: KVec<u8>,
+
+    // Keep the BO backing this firmware section so that both the
+    // GPU mapping and CPU mapping remain valid until the Section is dropped.
+    #[expect(dead_code)]
+    mem: gem::KernelBo<'drm>,
+}
+
+/// Loaded firmware with sections mapped into MCU VM.
+pub(crate) struct Firmware<'drm> {
+    /// Iomem need to access registers.
+    iomem: Arc<IoMem<'drm>>,
+
+    /// MCU VM.
+    vm: Arc<Vm<'drm>>,
+
+    /// List of firmware sections.
+    #[expect(dead_code)]
+    sections: KVec<Section<'drm>>,
+}
+
+impl<'drm> Drop for Firmware<'drm> {
+    fn drop(&mut self) {
+        // Stop the MCU before releasing its firmware mappings and memory.
+        let _ = self.stop();
+
+        // AS slots retain a VM ref, we need to kill the circular ref manually.
+        self.vm.kill();
+    }
+}
+
+impl<'drm> Firmware<'drm> {
+    fn init_section_mem(dev: &Device, mem: &mut KernelBo<'drm>, data: &KVec<u8>) -> Result {
+        if data.is_empty() {
+            return Ok(());
+        }
+
+        let vmap = mem.bo().vmap::<0>()?;
+        let size = mem.bo().size();
+
+        if data.len() > size {
+            dev_err!(dev, "fw section {} bigger than BO {}", data.len(), size);
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
+        dev: &Device,
+        ddev: &TyrDrmDevice,
+        gpu_info: &GpuInfo,
+    ) -> Result<(kernel::firmware::Firmware, KVec<ParsedSection>)> {
+        let fw = Self::request(ddev, gpu_info)?;
+        let mut parser = FwParser::new(dev, fw.data());
+
+        let parsed_sections = parser.parse()?;
+
+        Ok((fw, parsed_sections))
+    }
+
+    /// Load firmware and map sections into MCU VM.
+    pub(crate) fn new(
+        dev: &'drm Device<Bound>,
+        iomem: Arc<IoMem<'drm>>,
+        ddev: &TyrDrmDevice,
+        mmu: ArcBorrow<'_, Mmu<'drm>>,
+        gpu_info: &GpuInfo,
+    ) -> Result<Firmware<'drm>> {
+        let vm = Vm::new(dev, ddev, mmu, gpu_info)?;
+        vm.activate()?;
+
+        let result = (|| {
+            let (fw, parsed_sections) = Self::load(dev, ddev, gpu_info)?;
+            let mut sections = KVec::new();
+            for parsed in parsed_sections {
+                let size = u64::from(parsed.va.end.checked_sub(parsed.va.start).ok_or(EINVAL)?);
+
+                let va = u64::from(parsed.va.start);
+
+                let mut mem = KernelBo::new(
+                    ddev,
+                    vm.clone(),
+                    size,
+                    KernelBoVaAlloc::Explicit(va),
+                    parsed.vm_map_flags,
+                )?;
+
+                let section_start = parsed.data_range.start as usize;
+                let section_end = parsed.data_range.end as usize;
+                let mut data = KVec::new();
+
+                // Ensure that the firmware slice is not out of bounds.
+                let fw_data = fw.data();
+                let bytes = fw_data.get(section_start..section_end).ok_or(EINVAL)?;
+                data.extend_from_slice(bytes, GFP_KERNEL)?;
+
+                Self::init_section_mem(dev, &mut mem, &data)?;
+
+                sections.push(Section { data, mem }, GFP_KERNEL)?;
+            }
+
+            Ok(Firmware {
+                iomem,
+                vm: vm.clone(),
+                sections,
+            })
+        })();
+
+        if result.is_err() {
+            vm.kill();
+        }
+
+        result
+    }
+
+    pub(crate) fn boot(&self) -> Result {
+        let io = &self.iomem;
+
+        // Discard any stale global interrupt.
+        io.write_reg(JOB_IRQ_CLEAR::zeroed().with_glb(true));
+
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
+            dev_err!(
+                self.vm.dev(),
+                "MCU failed to boot, status: {:?}",
+                status.value()
+            );
+            return Err(e);
+        }
+
+        io.write_reg(JOB_IRQ_CLEAR::zeroed().with_glb(true));
+
+        Ok(())
+    }
+
+    fn stop(&self) -> Result {
+        let io = &self.iomem;
+        io.write_reg(MCU_CONTROL::zeroed().with_req(McuControlMode::Disable));
+
+        if let Err(e) = poll::read_poll_timeout(
+            || Ok(io.read(MCU_STATUS)),
+            |status| status.value() == McuStatus::Disabled,
+            time::Delta::from_micros(10),
+            time::Delta::from_millis(100),
+        ) {
+            let status = io.read(MCU_STATUS);
+            dev_err!(
+                self.vm.dev(),
+                "MCU failed to stop, status: {:?}",
+                status.value()
+            );
+            return Err(e);
+        }
+
+        Ok(())
+    }
+}
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 69e1c75e59a5..3bf3787f5c3f 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -72,7 +72,6 @@ pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice) -> Result<ARef<Bo>> {
 /// An automatic VA allocation strategy will be added in the future.
 pub(crate) enum KernelBoVaAlloc {
     /// Explicit VA address specified by the caller.
-    #[expect(dead_code)]
     Explicit(u64),
 }
 
@@ -98,7 +97,6 @@ impl<'drm> KernelBo<'drm> {
     /// This function allocates a new shmem-backed GEM object and immediately maps
     /// it into the specified GPU virtual memory space. The mapping is automatically
     /// cleaned up when the [`KernelBo`] is dropped.
-    #[expect(dead_code)]
     pub(crate) fn new(
         ddev: &TyrDrmDevice,
         vm: Arc<Vm<'drm>>,
@@ -135,7 +133,6 @@ pub(crate) fn new(
         })
     }
 
-    #[expect(dead_code)]
     pub(crate) fn bo(&self) -> &Bo {
         &self.bo
     }
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
index 53a17dd8d949..74c3d6c8efc4 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -6,7 +6,6 @@
 //! the illusion of owning the entire virtual address (VA) range, similar to CPU virtual memory.
 //! Each virtual memory (VM) area is backed by ARM64 LPAE Stage 1 page tables and can be
 //! mapped into hardware address space (AS) slots for GPU execution.
-#![expect(dead_code)]
 
 use core::marker::PhantomData;
 use core::ops::Range;

-- 
2.55.0

