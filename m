Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F28F531D9
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:32:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AD7910E54A;
	Mon, 13 Apr 2026 22:32:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="IvPxR754";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39B2B10E54A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 22:32:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776119523; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mFw/ilW2zCsXYeivP3LhG5gOVLeveWaA1JaMMD4gTbVV0n0i0LHW193ezMgGXxf9HngJblvDqpAQQAqHze7jayXyNEjrheun5mLduu5/supeIgg5Svrnz+z5LKhCvJ/22hu+3Q9FQmonN23NpBrP96fn18ICIPDzlpy2AQm++fA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776119523;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=C/m0ypL/3oAer/xlqaqK+nR119FCTivyqk+k/gXCT5o=; 
 b=RXFOtwcWDC8cAId/EPXS/k0vf+T/vt2h8xaIc8n2IU2pgFqVLNWKPTTf4DiFnPPIMIppIl+n66qoFiG3LTgpIPrNyS7aVBpMmos2F6T+6E9MrbPzjNfK6BCdxSm5ZqY26mr5raBwRspPoKFV0rnQKomipAs2MIYvulAHAORhXwk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776119523; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=C/m0ypL/3oAer/xlqaqK+nR119FCTivyqk+k/gXCT5o=;
 b=IvPxR754lxhmau8ObA7NEEF56bJbHqbsFLLRIxBIJviBO/mgMV0CsuC3TTM38Nfh
 zzUBxMdfWqu8p+dqbcGigt4WvTkwL3g4Rzvq9B4QTU8xl+Nu0sUc+aIB+8YlDJAlDJl
 5u88zLyHldnfrc0sSGDQTHQqx/MQ4LsRAeRStx3U=
Received: by mx.zohomail.com with SMTPS id 1776119522369451.23767583430583;
 Mon, 13 Apr 2026 15:32:02 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Mon, 13 Apr 2026 15:31:44 -0700
Subject: [PATCH v3 09/13] drm/tyr: add MMU module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260413-b4-fw-boot-v3-v3-9-b422f3c03885@collabora.com>
References: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
In-Reply-To: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=34311;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=Y2oeP8IZFKghbe3KLU5OHdSNN4VeTVKubV5WJG6b5LE=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl3865ubD6dlfDE8p3Ij0mufb95fkppNtmoN2toMrY+j
 In7uOxuRykLgxgXg6yYIstZe6Me8ar3Rrrz/zfDzGFlAhnCwMUpABN5cprhn5qFW11bw36Fowkf
 ZiX+PvhDfUresq3zXx5T45f9dvulTirDP0MWl3JZx5y0Jjk+Kavd0x1UeaQV023O/p2+mkl0Uaw
 REwA=
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

From: Boris Brezillon <boris.brezillon@collabora.com>

Add a Memory Management Unit (MMU) driver for Tyr. The MMU wraps a
SlotManager for allocating hardware address space slots. The underlying
AddressSpaceManager performs MMU operations including enabling/disabling
address spaces, flushing page tables, and locking regions for page table
updates.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs            |   3 +
 drivers/gpu/drm/tyr/mmu.rs               | 128 +++++++
 drivers/gpu/drm/tyr/mmu/address_space.rs | 571 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/regs.rs              | 110 ++++++
 drivers/gpu/drm/tyr/tyr.rs               |   1 +
 5 files changed, 813 insertions(+)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 1f09f59e271a..495021a8657d 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -45,6 +45,7 @@
     gem::BoData,
     gpu,
     gpu::GpuInfo,
+    mmu::Mmu,
     regs::gpu_control::*, //
 };
 
@@ -153,6 +154,8 @@ fn probe(
         let uninit_ddev = UnregisteredDevice::<TyrDrmDriver>::new(pdev.as_ref())?;
         let platform: ARef<platform::Device> = pdev.into();
 
+        let _mmu = Mmu::new(pdev, iomem.as_arc_borrow(), &gpu_info)?;
+
         let data = try_pin_init!(TyrDrmDeviceData {
                 pdev: platform.clone(),
                 clks <- new_mutex!(Clocks {
diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
new file mode 100644
index 000000000000..09df98ffc9e3
--- /dev/null
+++ b/drivers/gpu/drm/tyr/mmu.rs
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Memory Management Unit (MMU) driver for the Tyr GPU.
+//!
+//! This module manages GPU address spaces and virtual memory (VM) operations through
+//! hardware MMU slots. It provides functionality for flushing page tables and
+//! managing VM updates for active address spaces.
+//!
+//! The MMU coordinates with the [`AddressSpaceManager`] to handle hardware
+//! address space allocation and page table operations, using [`SlotManager`]
+//! to track which address spaces are currently active in hardware slots.
+//!
+//! [`AddressSpaceManager`]: address_space::AddressSpaceManager
+//! [`SlotManager`]: crate::slot::SlotManager
+#![allow(dead_code)]
+
+use core::ops::Range;
+
+use kernel::{
+    devres::Devres,
+    new_mutex,
+    platform,
+    prelude::*,
+    sync::{
+        Arc,
+        ArcBorrow,
+        Mutex, //
+    }, //
+};
+
+use crate::{
+    driver::IoMem,
+    gpu::GpuInfo,
+    mmu::address_space::{
+        AddressSpaceManager,
+        VmAsData, //
+    },
+    regs::{
+        gpu_control::AS_PRESENT,
+        MAX_AS, //
+    },
+    slot::SlotManager, //
+};
+
+pub(crate) mod address_space;
+
+pub(crate) type AsSlotManager = SlotManager<AddressSpaceManager, MAX_AS>;
+
+/// MMU component of the GPU.
+///
+/// This is used to bind VM objects to an AS (Address Space) slot
+/// and make the VM active on the GPU.
+///
+/// All operations acquire an internal lock, allowing concurrent access from multiple
+/// threads. Methods may block if another thread holds the lock.
+#[pin_data]
+pub(crate) struct Mmu {
+    /// Manages the allocation of hardware MMU slots to GPU address spaces.
+    ///
+    /// Tracks which address spaces are currently active in hardware slots and
+    /// coordinates address space operations like flushing and VM updates.
+    ///
+    /// This mutex also protects individual [`Seat`]s that are wrapped with
+    /// `LockedBy<Seat, SlotManager<...>>` to share the same lock protection.
+    ///
+    /// [`Seat`]: crate::slot::Seat
+    #[pin]
+    pub(crate) as_manager: Mutex<AsSlotManager>,
+}
+
+impl Mmu {
+    /// Create an MMU component for this device.
+    pub(crate) fn new(
+        pdev: &platform::Device,
+        iomem: ArcBorrow<'_, Devres<IoMem>>,
+        gpu_info: &GpuInfo,
+    ) -> Result<Arc<Mmu>> {
+        let present = AS_PRESENT::from_raw(gpu_info.as_present).present().get();
+        let slot_count = present.count_ones().try_into()?;
+
+        let as_manager = AddressSpaceManager::new(pdev, iomem, present)?;
+        let mmu_init = try_pin_init!(Self{
+            as_manager <- new_mutex!(SlotManager::new(as_manager, slot_count)?),
+        });
+        Arc::pin_init(mmu_init, GFP_KERNEL)
+    }
+
+    /// Make a VM active.
+    ///
+    /// This implies assigning the VM to an AS slot through the slot manager.
+    pub(crate) fn activate_vm(&self, vm: ArcBorrow<'_, VmAsData>) -> Result {
+        self.as_manager.lock().activate_vm(vm)
+    }
+
+    /// Make the VM inactive.
+    ///
+    /// Evicts the VM from its AS slot through the slot manager.
+    pub(crate) fn deactivate_vm(&self, vm: &VmAsData) -> Result {
+        self.as_manager.lock().deactivate_vm(vm)
+    }
+
+    /// Flush caches after a VM update.
+    ///
+    /// If the VM is no longer resident, this is a NOP, otherwise, the
+    /// AS manager will flush the GPU and MMU Translation Lookaside Buffer (TLB) caches.
+    pub(crate) fn flush_vm(&self, vm: &VmAsData) -> Result {
+        self.as_manager.lock().flush_vm(vm)
+    }
+
+    /// Flags the start of a VM update.
+    ///
+    /// If the VM is resident, any GPU access on the memory range being
+    /// updated will be blocked until `Mmu::end_vm_update()` is called.
+    /// This guarantees the atomicity of a VM update.
+    /// If the VM is not resident, this is a NOP.
+    pub(crate) fn start_vm_update(&self, vm: &VmAsData, region: &Range<u64>) -> Result {
+        self.as_manager.lock().start_vm_update(vm, region)
+    }
+
+    /// Flags the end of a VM update.
+    ///
+    /// If the VM is resident, this will let GPU accesses on the updated
+    /// range go through, in case any of them were blocked.
+    /// If the VM is not resident, this is a NOP.
+    pub(crate) fn end_vm_update(&self, vm: &VmAsData) -> Result {
+        self.as_manager.lock().end_vm_update(vm)
+    }
+}
diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
new file mode 100644
index 000000000000..cc2841bab21c
--- /dev/null
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -0,0 +1,571 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! GPU address space management and hardware operations.
+//!
+//! This module manages GPU hardware address spaces (AS), including configuration,
+//! command submission, and page table update regions. It handles the hardware
+//! interaction for MMU operations through MMIO register access.
+//!
+//! The [`AddressSpaceManager`] implements [`SlotOperations`] to integrate with
+//! the slot management system, enabling and configuring address spaces in the
+//! hardware slots as needed.
+//!
+//! [`SlotOperations`]: crate::slot::SlotOperations
+
+use core::ops::Range;
+
+use kernel::{
+    device::{
+        Bound,
+        Device, //
+    },
+    devres::Devres,
+    error::Result,
+    io::{
+        poll,
+        register::Array,
+        Io, //
+    },
+    iommu::pgtable::{
+        Config,
+        IoPageTable,
+        ARM64LPAES1, //
+    },
+    platform,
+    prelude::*,
+    sizes::{
+        SZ_2M,
+        SZ_4K, //
+    },
+    sync::{
+        aref::ARef,
+        Arc,
+        ArcBorrow,
+        LockedBy, //
+    },
+    time::Delta, //
+};
+
+use crate::{
+    driver::IoMem,
+    mmu::{
+        AsSlotManager,
+        Mmu, //
+    },
+    regs::{
+        mmu_control::mmu_as_control,
+        mmu_control::mmu_as_control::*,
+        MAX_AS, //
+    },
+    slot::{
+        Seat,
+        SlotOperations, //
+    }, //
+};
+
+/// Hardware address space configuration registers.
+///
+/// Contains register values for configuring a GPU MMU address space.
+#[derive(Clone, Copy)]
+struct AddressSpaceConfig {
+    /// Translation configuration.
+    ///
+    /// Controls address translation mode, address range restrictions, translation table
+    /// walk attributes, and access permission settings for this address space.
+    transcfg: u64,
+
+    /// Translation table base address.
+    ///
+    /// The address of the top level of a translation table structure.
+    transtab: u64,
+
+    /// Memory attributes.
+    ///
+    /// Defines memory attribute indirection entries that control cacheability
+    /// and other memory access properties for the address space.
+    memattr: u64,
+}
+
+/// Virtual memory (VM) address space data for GPU MMU operations.
+///
+/// Contains all resources and information needed by the [`AddressSpaceManager`]
+/// to activate a VM in a hardware address space slot.
+///
+/// On activation, we will pass an [`Arc`]<[`VmAsData`]> that will be stored in
+/// the slot to make sure the page table and the underlying resources
+/// (pages) used by the AS slot won't go away while the MMU points to
+/// those.
+///
+/// The `as_seat` field uses [`LockedBy`] to ensure safe concurrent access to
+/// the slot assignment state, protected by the [`AsSlotManager`] lock.
+#[pin_data]
+pub(crate) struct VmAsData {
+    /// Tracks this VM's binding to a hardware address space slot.
+    as_seat: LockedBy<Seat, AsSlotManager>,
+
+    /// Virtual address bits for this address space.
+    va_bits: u8,
+
+    /// Page table.
+    ///
+    /// Managed by devres to ensure proper cleanup. The page table maps
+    /// GPU virtual addresses to physical addresses for this VM.
+    #[pin]
+    pub(crate) page_table: Devres<IoPageTable<ARM64LPAES1>>,
+}
+
+impl VmAsData {
+    /// Creates a new VM address space data structure.
+    ///
+    /// Initializes the page table for the address space.
+    pub(crate) fn new<'a>(
+        mmu: &'a Mmu,
+        pdev: &'a platform::Device,
+        va_bits: u32,
+        pa_bits: u32,
+    ) -> impl pin_init::PinInit<VmAsData, Error> + 'a {
+        // SAFETY: pdev is a bound device.
+        let dev = unsafe { pdev.as_ref().as_bound() };
+
+        let pt_config = Config {
+            quirks: 0,
+            pgsize_bitmap: SZ_4K | SZ_2M,
+            ias: va_bits,
+            oas: pa_bits,
+            coherent_walk: false,
+        };
+
+        let page_table_init = IoPageTable::new(dev, pt_config);
+
+        try_pin_init!(Self {
+            as_seat: LockedBy::new(&mmu.as_manager, Seat::NoSeat),
+            va_bits: va_bits as u8,
+            page_table <- page_table_init,
+        }? Error)
+    }
+
+    /// Computes the hardware configuration for this address space.
+    ///
+    /// The caller must ensure that the address space is evicted and cleaned up
+    /// before the `VmAsData` is dropped.
+    fn as_config(&self, dev: &Device<Bound>) -> Result<AddressSpaceConfig> {
+        let pt = self.page_table.access(dev)?;
+
+        // The hardware computes the valid input address range as:
+        //   INA_BITS_VALID = min(HW_INA_BITS, 55 - INA_BITS)
+        // To configure our desired va_bits, we solve for INA_BITS:
+        //   INA_BITS = 55 - va_bits
+        // This assumes HW_INA_BITS (hardware capability) >= va_bits.
+        let ina_bits_field_value = 55 - self.va_bits;
+        let ina_bits = match ina_bits_field_value {
+            7 => mmu_as_control::InaBits::Bits48,
+            8 => mmu_as_control::InaBits::Bits47,
+            9 => mmu_as_control::InaBits::Bits46,
+            10 => mmu_as_control::InaBits::Bits45,
+            11 => mmu_as_control::InaBits::Bits44,
+            12 => mmu_as_control::InaBits::Bits43,
+            13 => mmu_as_control::InaBits::Bits42,
+            14 => mmu_as_control::InaBits::Bits41,
+            15 => mmu_as_control::InaBits::Bits40,
+            16 => mmu_as_control::InaBits::Bits39,
+            17 => mmu_as_control::InaBits::Bits38,
+            18 => mmu_as_control::InaBits::Bits37,
+            19 => mmu_as_control::InaBits::Bits36,
+            20 => mmu_as_control::InaBits::Bits35,
+            21 => mmu_as_control::InaBits::Bits34,
+            22 => mmu_as_control::InaBits::Bits33,
+            23 => mmu_as_control::InaBits::Bits32,
+            24 => mmu_as_control::InaBits::Bits31,
+            25 => mmu_as_control::InaBits::Bits30,
+            26 => mmu_as_control::InaBits::Bits29,
+            27 => mmu_as_control::InaBits::Bits28,
+            28 => mmu_as_control::InaBits::Bits27,
+            29 => mmu_as_control::InaBits::Bits26,
+            30 => mmu_as_control::InaBits::Bits25,
+            _ => return Err(EINVAL),
+        };
+
+        let transcfg = mmu_as_control::TRANSCFG::zeroed()
+            .with_ptw_memattr(mmu_as_control::PtwMemattr::WriteBack)
+            .with_r_allocate(true)
+            .with_mode(mmu_as_control::AddressSpaceMode::Aarch64_4K)
+            .with_ina_bits(ina_bits)
+            .into_raw();
+
+        Ok(AddressSpaceConfig {
+            transcfg,
+            // SAFETY: Caller ensures proper cleanup.
+            transtab: unsafe { pt.ttbr() },
+            memattr: MEMATTR::from_mair(pt.mair()).into_raw(),
+        })
+    }
+}
+
+/// Manages GPU hardware address spaces via MMIO register operations.
+///
+/// Coordinates all hardware-level address space operations including enabling,
+/// disabling, flushing, and updating address spaces. Implements [`SlotOperations`]
+/// to integrate with the generic slot management system.
+///
+/// [`SlotOperations`]: crate::slot::SlotOperations
+pub(crate) struct AddressSpaceManager {
+    /// Platform device reference for DMA and device operations.
+    pdev: ARef<platform::Device>,
+
+    /// Memory-mapped I/O region for GPU register access.
+    iomem: Arc<Devres<IoMem>>,
+
+    /// Bitmask of available address space slots from GPU_AS_PRESENT register.
+    as_present: u32,
+}
+
+impl SlotOperations for AddressSpaceManager {
+    /// VM address space data stored in each hardware slot.
+    type SlotData = Arc<VmAsData>;
+
+    /// Activates an address space in a hardware slot.
+    fn activate(&mut self, slot_idx: usize, slot_data: &Self::SlotData) -> Result {
+        let as_config = slot_data.as_config(self.dev())?;
+        self.as_enable(slot_idx, &as_config)
+    }
+
+    /// Evicts an address space from a hardware slot.
+    fn evict(&mut self, slot_idx: usize, _slot_data: &Self::SlotData) -> Result {
+        if self.iomem.try_access().is_some() {
+            self.as_flush(slot_idx)?;
+            self.as_disable(slot_idx)?;
+        }
+        Ok(())
+    }
+}
+
+impl AddressSpaceManager {
+    /// Creates a new address space manager.
+    ///
+    /// Initializes the manager with references to the platform device and
+    /// I/O memory region, along with the bitmask of available AS slots.
+    pub(super) fn new(
+        pdev: &platform::Device,
+        iomem: ArcBorrow<'_, Devres<IoMem>>,
+        as_present: u32,
+    ) -> Result<AddressSpaceManager> {
+        Ok(Self {
+            pdev: pdev.into(),
+            iomem: iomem.into(),
+            as_present,
+        })
+    }
+
+    /// Returns a reference to the bound device.
+    fn dev(&self) -> &Device<Bound> {
+        // SAFETY: pdev is a bound device.
+        unsafe { self.pdev.as_ref().as_bound() }
+    }
+
+    /// Validates that an AS slot number is within range and present in hardware.
+    ///
+    /// Checks that the slot index is less than [`MAX_AS`] and that
+    /// the corresponding bit is set in the `as_present` mask read from the GPU.
+    ///
+    /// Returns [`EINVAL`] if the slot is out of range or not present in hardware.
+    fn validate_as_slot(&self, as_nr: usize) -> Result {
+        if as_nr >= MAX_AS {
+            pr_err!("AS slot {} out of valid range (max {})\n", as_nr, MAX_AS);
+            return Err(EINVAL);
+        }
+
+        if (self.as_present & (1 << as_nr)) == 0 {
+            pr_err!(
+                "AS slot {} not present in hardware (AS_PRESENT={:#x})\n",
+                as_nr,
+                self.as_present
+            );
+            return Err(EINVAL);
+        }
+
+        Ok(())
+    }
+
+    /// Waits for an AS slot to become ready (not active).
+    ///
+    /// Returns an error if polling times out after 10ms or if register access fails.
+    fn as_wait_ready(&self, as_nr: usize) -> Result {
+        let dev = self.dev();
+        let io = self.iomem.access(dev)?;
+        let op = || {
+            let status_reg = STATUS::try_at(as_nr).ok_or(EINVAL)?;
+            Ok(io.read(status_reg))
+        };
+        let cond = |status: &STATUS| -> bool { !status.active_ext() };
+        poll::read_poll_timeout(op, cond, Delta::from_millis(0), Delta::from_millis(10))?;
+
+        Ok(())
+    }
+
+    /// Sends a command to an AS slot.
+    ///
+    /// Returns an error if waiting for ready times out or if register write fails.
+    fn as_send_cmd(&mut self, as_nr: usize, cmd: MmuCommand) -> Result {
+        self.as_wait_ready(as_nr)?;
+        let dev = self.dev();
+        let io = self.iomem.access(dev)?;
+        let command_reg = COMMAND::try_at(as_nr).ok_or(EINVAL)?;
+        io.write(command_reg, COMMAND::zeroed().with_command(cmd));
+        Ok(())
+    }
+
+    /// Sends a command to an AS slot and waits for completion.
+    ///
+    /// Returns an error if sending the command fails or if waiting for completion times out.
+    fn as_send_cmd_and_wait(&mut self, as_nr: usize, cmd: MmuCommand) -> Result {
+        self.as_send_cmd(as_nr, cmd)?;
+        self.as_wait_ready(as_nr)?;
+        Ok(())
+    }
+
+    /// Enables an AS slot with the provided configuration.
+    ///
+    /// Returns an error if the slot is invalid or if register writes/commands fail.
+    fn as_enable(&mut self, as_nr: usize, as_config: &AddressSpaceConfig) -> Result {
+        self.validate_as_slot(as_nr)?;
+
+        let dev = self.dev();
+        let io = self.iomem.access(dev)?;
+
+        let transtab = as_config.transtab;
+        io.write(
+            TRANSTAB_LO::try_at(as_nr).ok_or(EINVAL)?,
+            TRANSTAB_LO::from_raw(transtab as u32),
+        );
+        io.write(
+            TRANSTAB_HI::try_at(as_nr).ok_or(EINVAL)?,
+            TRANSTAB_HI::from_raw((transtab >> 32) as u32),
+        );
+
+        let transcfg = as_config.transcfg;
+        io.write(
+            TRANSCFG_LO::try_at(as_nr).ok_or(EINVAL)?,
+            TRANSCFG_LO::from_raw(transcfg as u32),
+        );
+        io.write(
+            TRANSCFG_HI::try_at(as_nr).ok_or(EINVAL)?,
+            TRANSCFG_HI::from_raw((transcfg >> 32) as u32),
+        );
+
+        let memattr = as_config.memattr;
+        io.write(
+            MEMATTR_LO::try_at(as_nr).ok_or(EINVAL)?,
+            MEMATTR_LO::from_raw(memattr as u32),
+        );
+        io.write(
+            MEMATTR_HI::try_at(as_nr).ok_or(EINVAL)?,
+            MEMATTR_HI::from_raw((memattr >> 32) as u32),
+        );
+
+        self.as_send_cmd_and_wait(as_nr, MmuCommand::Update)?;
+
+        Ok(())
+    }
+
+    /// Disables an AS slot and clears its configuration.
+    ///
+    /// Returns an error if the slot is invalid or if register writes/commands fail.
+    fn as_disable(&mut self, as_nr: usize) -> Result {
+        self.validate_as_slot(as_nr)?;
+
+        // Flush AS before disabling
+        self.as_send_cmd_and_wait(as_nr, MmuCommand::FlushMem)?;
+
+        let dev = self.dev();
+        let io = self.iomem.access(dev)?;
+
+        io.write(
+            TRANSTAB_LO::try_at(as_nr).ok_or(EINVAL)?,
+            TRANSTAB_LO::from_raw(0),
+        );
+        io.write(
+            TRANSTAB_HI::try_at(as_nr).ok_or(EINVAL)?,
+            TRANSTAB_HI::from_raw(0),
+        );
+
+        io.write(
+            MEMATTR_LO::try_at(as_nr).ok_or(EINVAL)?,
+            MEMATTR_LO::from_raw(0),
+        );
+        io.write(
+            MEMATTR_HI::try_at(as_nr).ok_or(EINVAL)?,
+            MEMATTR_HI::from_raw(0),
+        );
+
+        let transcfg = TRANSCFG::zeroed()
+            .with_mode(AddressSpaceMode::Unmapped)
+            .into_raw();
+
+        io.write(
+            TRANSCFG_LO::try_at(as_nr).ok_or(EINVAL)?,
+            TRANSCFG_LO::from_raw(transcfg as u32),
+        );
+        io.write(
+            TRANSCFG_HI::try_at(as_nr).ok_or(EINVAL)?,
+            TRANSCFG_HI::from_raw((transcfg >> 32) as u32),
+        );
+
+        self.as_send_cmd_and_wait(as_nr, MmuCommand::Update)?;
+
+        Ok(())
+    }
+
+    /// Locks a region of the translation tables for an atomic update.
+    ///
+    /// Programs the MMU LOCKADDR register for the given address space and issues
+    /// the lock command. The hardware rounds the requested range up to a
+    /// power-of-two region aligned to its size.
+    ///
+    /// Returns an error if the slot is invalid or if register writes/commands fail.
+    fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> Result {
+        self.validate_as_slot(as_nr)?;
+
+        // The lock operates on full 64-byte cache lines of translation table entries.
+        // Since each translation table entry (TTE) is 8 bytes, a cache line has 8 TTEs.
+        // Since each TTE maps one page, the minimum locked region size will be 8 pages.
+        //
+        // With 4KiB pages (Aarch64_4K mode), the minimum locked region is 32KiB.
+        let lock_region_min_size: u64 = 32 * 1024;
+
+        // Count the number of trailing zero bits (zeros at the right/least-significant
+        // end of the binary representation). For a power-of-two value, this equals the
+        // base-2 exponent (e.g., 32 KiB = 2^15 → 15).
+        let lock_region_min_size_log2 = lock_region_min_size.trailing_zeros() as u8;
+
+        // XOR the first and last addresses to identify which bits differ between them.
+        // The highest set bit in the result determines the exponent of the smallest
+        // power-of-two region that can contain both addresses.
+        //
+        // Example:
+        //   addr_xor = 0x1000 ^ 0x2FFF = 0x3FFF
+        //   highest set bit in 0x3FFF is bit 13
+        //   minimum region size = 2^(13 + 1) = 16 KiB
+        let addr_xor = region.start ^ (region.end - 1);
+        let region_size_log2 = 64 - addr_xor.leading_zeros() as u8;
+
+        let lock_region_log2 = core::cmp::max(region_size_log2, lock_region_min_size_log2);
+
+        // Align the LOCKADDR base address down to the lock region size (1 << lock_region_log2).
+        //
+        // The MMU ignores the low lock_region_log2 bits of LOCKADDR base, so ensure
+        // they are cleared in software to avoid ambiguity.
+        let lockaddr_base = region.start & !((1u64 << lock_region_log2) - 1);
+
+        // The LOCKADDR size field encodes the lock region size as log2(size) - 1,
+        // per the hardware definition. For example, a 32 KiB region is encoded as 14
+        // because log2(32 KiB) = 15.
+        let lockaddr_size = lock_region_log2 - 1;
+
+        let dev = self.dev();
+        let io = self.iomem.access(dev)?;
+
+        let lockaddr_val = LOCKADDR::zeroed()
+            .try_with_size(lockaddr_size)?
+            .try_with_base(lockaddr_base)?
+            .into_raw();
+
+        io.write(
+            LOCKADDR_LO::try_at(as_nr).ok_or(EINVAL)?,
+            LOCKADDR_LO::from_raw(lockaddr_val as u32),
+        );
+        io.write(
+            LOCKADDR_HI::try_at(as_nr).ok_or(EINVAL)?,
+            LOCKADDR_HI::from_raw((lockaddr_val >> 32) as u32),
+        );
+
+        self.as_send_cmd(as_nr, MmuCommand::Lock)
+    }
+
+    /// Completes an atomic translation table update.
+    ///
+    /// Returns an error if the slot is invalid or if the flush command fails.
+    fn as_end_update(&mut self, as_nr: usize) -> Result {
+        self.validate_as_slot(as_nr)?;
+        self.as_send_cmd_and_wait(as_nr, MmuCommand::FlushPt)?;
+        Ok(())
+    }
+
+    /// Flushes the translation table cache for an AS slot.
+    ///
+    /// Returns an error if the slot is invalid or if the flush command fails.
+    fn as_flush(&mut self, as_nr: usize) -> Result {
+        self.validate_as_slot(as_nr)?;
+        self.as_send_cmd(as_nr, MmuCommand::FlushPt)
+    }
+}
+
+impl AsSlotManager {
+    /// Locks a region for translation table updates if the VM has an active slot.
+    ///
+    /// If the VM is currently assigned to a hardware slot, locks the specified
+    /// memory region to make translation table updates atomic. GPU accesses to the
+    /// region will be blocked until [`end_vm_update`] is called.
+    ///
+    /// If the VM is not resident in a hardware slot, this is a no-op.
+    pub(super) fn start_vm_update(&mut self, vm: &VmAsData, region: &Range<u64>) -> Result {
+        let seat = vm.as_seat.access(self);
+        match seat.slot() {
+            Some(slot) => {
+                let as_nr = slot as usize;
+                self.as_start_update(as_nr, region)
+            }
+            _ => Ok(()),
+        }
+    }
+
+    /// Completes translation table updates and unlocks the region.
+    ///
+    /// If the VM is currently assigned to a hardware slot, flushes the translation
+    /// table cache and unlocks the region that was locked by [`start_vm_update`],
+    /// allowing GPU accesses to proceed with the updated translation tables.
+    ///
+    /// If the VM is not resident in a hardware slot, this is a no-op.
+    pub(super) fn end_vm_update(&mut self, vm: &VmAsData) -> Result {
+        let seat = vm.as_seat.access(self);
+        match seat.slot() {
+            Some(slot) => {
+                let as_nr = slot as usize;
+                self.as_end_update(as_nr)
+            }
+            _ => Ok(()),
+        }
+    }
+
+    /// Flushes translation table cache if the VM has an active slot.
+    ///
+    /// If the VM is currently assigned to a hardware slot, invalidates cached
+    /// translation table entries to ensure subsequent GPU accesses use updated translations.
+    ///
+    /// If the VM is not resident in a hardware slot, this is a no-op.
+    pub(super) fn flush_vm(&mut self, vm: &VmAsData) -> Result {
+        let seat = vm.as_seat.access(self);
+        match seat.slot() {
+            Some(slot) => {
+                let as_nr = slot as usize;
+                self.as_flush(as_nr)
+            }
+            _ => Ok(()),
+        }
+    }
+
+    /// Activates a VM by assigning it to a hardware slot.
+    ///
+    /// Allocates a hardware address space slot for the VM and configures
+    /// it with the VM's translation table and memory attributes.
+    pub(super) fn activate_vm(&mut self, vm: ArcBorrow<'_, VmAsData>) -> Result {
+        self.activate(&vm.as_seat, vm.into())
+    }
+
+    /// Deactivates a VM by evicting it from its hardware slot.
+    ///
+    /// Flushes any pending operations and clears the hardware slot's
+    /// configuration, freeing the slot for use by other VMs.
+    pub(super) fn deactivate_vm(&mut self, vm: &VmAsData) -> Result {
+        self.evict(&vm.as_seat)
+    }
+}
diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
index 9963294b8625..dafca19e3532 100644
--- a/drivers/gpu/drm/tyr/regs.rs
+++ b/drivers/gpu/drm/tyr/regs.rs
@@ -45,6 +45,8 @@ pub(crate) fn read_u64_no_tearing(lo_read: impl Fn() -> u32, hi_read: impl Fn()
     }
 }
 
+pub(crate) use mmu_control::mmu_as_control::MAX_AS;
+
 /// These registers correspond to the GPU_CONTROL register page.
 /// They are involved in GPU configuration and control.
 pub(crate) mod gpu_control {
@@ -974,6 +976,8 @@ pub(crate) mod mmu_as_control {
             register, //
         };
 
+        use pin_init::Zeroable;
+
         /// Maximum number of hardware address space slots.
         /// The actual number of slots available is usually lower.
         pub(crate) const MAX_AS: usize = 16;
@@ -1167,7 +1171,113 @@ fn from(val: MMU_MEMATTR_STAGE1) -> Self {
             pub(crate) MEMATTR_HI(u32)[MAX_AS, stride = STRIDE] @ 0x240c {
                 31:0 value;
             }
+        }
+
+        impl MEMATTR {
+            /// ARM MAIR Write-Allocate bit (bit 0 of inner/outer cache policy nibble).
+            ///
+            /// In the ARM Architecture Reference Manual, the MAIR encoding for Normal memory
+            /// uses the format `0bxxRW` where:
+            /// - `W` (bit 0) = Write-Allocate policy
+            /// - `R` (bit 1) = Read-Allocate policy
+            ///   For example, `0b1111` = Write-Back with both Read and Write allocation.
+            const ARM_MAIR_WRITE_ALLOCATE: u8 = 0x1;
+            /// ARM MAIR Read-Allocate bit (bit 1 of inner/outer cache policy nibble).
+            const ARM_MAIR_READ_ALLOCATE: u8 = 0x2;
+            /// ARM MAIR Write-back bit (bit 2 of inner/outer cache policy nibble).
+            const ARM_MAIR_WRITE_BACK: u8 = 0x4;
+            /// Mask for the inner cache policy nibble in MAIR attribute bytes.
+            const ARM_MAIR_INNER_MASK: u8 = 0x0f;
+
+            fn encode_attribute(
+                alloc_w: bool,
+                alloc_r: bool,
+                alloc_sel: AllocPolicySelect,
+                coherency: Coherency,
+                memory_type: MemoryType,
+            ) -> MMU_MEMATTR_STAGE1 {
+                MMU_MEMATTR_STAGE1::zeroed()
+                    .with_alloc_w(alloc_w)
+                    .with_alloc_r(alloc_r)
+                    .with_alloc_sel(alloc_sel)
+                    .with_coherency(coherency)
+                    .with_memory_type(memory_type)
+            }
+
+            fn with_encoded_attribute(self, index: usize, attr: MMU_MEMATTR_STAGE1) -> Self {
+                debug_assert!(index < 8);
+
+                let shift = index * 8;
+                let mask = !(0xffu64 << shift);
+                let raw = (self.into_raw() & mask) | ((u64::from(attr.into_raw())) << shift);
+
+                Self::from_raw(raw)
+            }
+
+            /// Check if a MAIR attribute byte represents device memory.
+            ///
+            /// Device memory (memory-mapped I/O, registers) cannot be cached and must
+            /// be mapped as GPU `NonCacheable`.
+            fn is_device_memory(mair_attr: u8) -> bool {
+                // In AArch64 MAIR, device memory has bits [1:0] of outer nibble = 0.
+                let outer = mair_attr >> 4;
+                (outer & 0x3) == 0
+            }
 
+            /// Check if normal memory is fully write-back cacheable.
+            ///
+            /// ARM MAIR has two cache policy levels (outer [7:4] and inner [3:0]).
+            /// For memory to be truly write-back, BOTH levels must have the write-back bit set.
+            /// If only one level is write-back, treat it as non-cacheable for GPU purposes.
+            fn is_writeback_cacheable(mair_attr: u8) -> bool {
+                let outer = mair_attr >> 4;
+                let inner = mair_attr & Self::ARM_MAIR_INNER_MASK;
+
+                (outer & Self::ARM_MAIR_WRITE_BACK) != 0 && (inner & Self::ARM_MAIR_WRITE_BACK) != 0
+            }
+
+            // TODO: Add a `coherent` parameter like panthor's mair_to_memattr().
+            // For now, assume a non-coherent system and always encode write-back
+            // memory with MidgardInnerDomain coherency.
+            fn attribute_from_mair(mair_attr: u8) -> MMU_MEMATTR_STAGE1 {
+                // Device memory or non-writeback normal memory
+                if Self::is_device_memory(mair_attr) || !Self::is_writeback_cacheable(mair_attr) {
+                    return Self::encode_attribute(
+                        false,
+                        false,
+                        AllocPolicySelect::Alloc,
+                        Coherency::MidgardInnerDomain,
+                        MemoryType::NonCacheable,
+                    );
+                }
+
+                // Write-back cacheable normal memory
+                let inner: u8 = mair_attr & Self::ARM_MAIR_INNER_MASK;
+                Self::encode_attribute(
+                    (inner & Self::ARM_MAIR_WRITE_ALLOCATE) != 0,
+                    (inner & Self::ARM_MAIR_READ_ALLOCATE) != 0,
+                    AllocPolicySelect::Alloc,
+                    Coherency::MidgardInnerDomain,
+                    MemoryType::WriteBack,
+                )
+            }
+
+            /// Convert an AArch64 MAIR value into the GPU MEMATTR register encoding.
+            ///
+            /// MAIR bytes map to GPU attributes as follows:
+            /// - device/write-through/non-cacheable → GPU `NonCacheable`
+            /// - write-back → GPU `WriteBack` (preserving inner allocation hints)
+            pub(crate) fn from_mair(mair: u64) -> Self {
+                mair.to_le_bytes()
+                    .into_iter()
+                    .enumerate()
+                    .fold(Self::zeroed(), |acc, (i, attr)| {
+                        acc.with_encoded_attribute(i, Self::attribute_from_mair(attr))
+                    })
+            }
+        }
+
+        register! {
             /// Lock region address for each address space.
             pub(crate) LOCKADDR(u64)[MAX_AS, stride = STRIDE] @ 0x2410 {
                 /// Lock region size.
diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
index 20b38120e20e..9f9f31ea02e3 100644
--- a/drivers/gpu/drm/tyr/tyr.rs
+++ b/drivers/gpu/drm/tyr/tyr.rs
@@ -11,6 +11,7 @@
 mod file;
 mod gem;
 mod gpu;
+mod mmu;
 mod regs;
 mod slot;
 

-- 
2.53.0

