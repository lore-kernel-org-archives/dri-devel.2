Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8041EC88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 882A410E6EB;
	Sat, 12 Sep 2026 10:40:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="FsUfLFae";
	dkim-atps=neutral
Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch
 [185.70.43.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFB7810E6EB
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1789209621; x=1789468821;
 bh=BRr4NJnDDqqOPI6VTa9rc+IWOpgCXIpDSltCC+y1lPQ=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=FsUfLFaeH+thVvcD1J+PfjNmH7APtjlDkXcUNTQK1tx9mnsodEw/47cgngCaqFJYg
 U6JRrb+LxRvxjx2XFMELOj3WS1xqUijxLOlF3APBSR6izH/RfSpCeAEgdt1RbQbS1K
 cJmHsKaXFtdJsCJrE5tEpOgEeuaevE1up6zX2gs3hTjDX9yc33Qn06BV1QMqI4yB5g
 umuP4Z2dYW3s5Uu68dLCkzzyxxpWb4COWvKHN0krFkfvrnE+OliQQ2R9zo3jcRL4k+
 znjEdb+aE4uhj1MfCytweMg+CJ3aF3hac2wcgwdMuZ974v2VJ1XuidCyiIww8s4ULj
 NtJx9xjkfQHsg==
X-Pm-Submission-Id: 4hhnxH2jWgz1DFFV
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v7 3/3] drm/tyr: put iomem behind the hardware gate
Date: Sat, 12 Sep 2026 13:39:56 +0300
Message-ID: <20260912-tyr-reset-impl-v7-3-077ce72084eb@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260912-tyr-reset-impl-v7-0-077ce72084eb@onurozkan.dev>
References: <20260912-tyr-reset-impl-v7-0-077ce72084eb@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Move iomem mapping into HwGate and pass Arc<HwGate> to components that
access hardware. Callers obtain HwAccessGuard before accessing the iomem
so the reset worker waits for ongoing accesses.

Acquire the gate once per address-space operation and pass the guarded
iomem reference to its helpers. This prevents nested gate acquisition
from deadlocking with reset and keeps each operation protected throughout.
Clone the gate Arc before acquiring the guard so mutating helpers can
retain their mutable self receivers.

Suggested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 drivers/gpu/drm/tyr/driver.rs            | 35 ++++++-------
 drivers/gpu/drm/tyr/fw.rs                | 16 +++---
 drivers/gpu/drm/tyr/mmu.rs               |  9 ++--
 drivers/gpu/drm/tyr/mmu/address_space.rs | 90 ++++++++++++++++++--------------
 drivers/gpu/drm/tyr/reset.rs             | 33 +++++-------
 drivers/gpu/drm/tyr/reset/hw_gate.rs     | 44 ++++++++++++----
 6 files changed, 126 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 52b1f16fa405..c326192f8af2 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -76,9 +76,6 @@ pub(crate) struct TyrDrmRegistrationData<'bound> {
     #[pin]
     regulators: Mutex<Regulators>,
 
-    /// GPU MMIO register mapping.
-    pub(crate) iomem: Arc<IoMem<'bound>>,
-
     /// Some information on the GPU.
     ///
     /// This is mainly queried by userspace, i.e.: Mesa.
@@ -117,12 +114,19 @@ fn probe<'bound>(
 
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
-        let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?, GFP_KERNEL)?;
+        let hw = Arc::pin_init(
+            reset::HwGate::new(request.iomap_sized::<SZ_2M>()?),
+            GFP_KERNEL,
+        )?;
 
-        reset::run_reset(pdev.as_ref(), &iomem)?;
+        reset::run_reset(pdev.as_ref(), &hw)?;
 
-        let gpu_info = GpuInfo::new(&iomem);
-        gpu_info.log(pdev.as_ref());
+        let gpu_info = {
+            let hw_guard = hw.access();
+            let gpu_info = GpuInfo::new(hw_guard.iomem());
+            gpu_info.log(pdev.as_ref());
+            gpu_info
+        };
 
         let pa_bits = MMU_FEATURES::from_raw(gpu_info.mmu_features)
             .pa_bits()
@@ -134,24 +138,18 @@ fn probe<'bound>(
 
         let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
 
-        let mmu = Mmu::new(iomem.as_arc_borrow(), &gpu_info)?;
+        let mmu = Mmu::new(hw.clone(), &gpu_info)?;
 
-        let firmware = Firmware::new(
-            pdev,
-            iomem.clone(),
-            &unreg_dev,
-            mmu.as_arc_borrow(),
-            &gpu_info,
-        )?;
+        let firmware = Firmware::new(pdev, hw.clone(), &unreg_dev, mmu.as_arc_borrow(), &gpu_info)?;
 
         firmware.boot()?;
         firmware.enable_global_interface(&gpu_info, &core_clk)?;
 
         let reg_data = try_pin_init!(TyrDrmRegistrationData {
                 pdev,
-                // SAFETY: `Registration` is stored in the platform driver data and
-                // not leaked, so `ResetHandle` is dropped before borrowed data expires.
-                reset <- unsafe { reset::ResetHandle::new(pdev, iomem.as_arc_borrow())? },
+                // SAFETY: `ResetHandle` is stored in registration data created with `new_with_lt`
+                // and is dropped before the borrowed device and MMIO references expire.
+                reset <- unsafe { reset::ResetHandle::new(pdev, hw.clone())? },
                 fw: firmware,
                 clks <- new_mutex!(Clocks {
                     core: core_clk,
@@ -162,7 +160,6 @@ fn probe<'bound>(
                     _mali: mali_regulator,
                     _sram: sram_regulator,
                 }),
-                iomem,
                 gpu_info,
         });
 
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 651bbe77f10b..e1522ab14e8d 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -41,7 +41,6 @@
 
 use crate::{
     driver::{
-        IoMem,
         TyrDrmDevice, //
     },
     fw::{
@@ -65,6 +64,7 @@
         MCU_CONTROL,
         MCU_STATUS, //
     },
+    reset::HwGate,
     vm::Vm, //
 };
 
@@ -148,8 +148,8 @@ pub(crate) struct Firmware<'bound> {
     /// Platform device reference (needed to access the MCU JOB_IRQ registers).
     _pdev: ARef<platform::Device>,
 
-    /// Iomem need to access registers.
-    iomem: Arc<IoMem<'bound>>,
+    /// Shared gate that coordinates hardware access with GPU reset.
+    hw: Arc<HwGate<'bound>>,
 
     /// MCU VM.
     vm: Arc<Vm<'bound>>,
@@ -221,7 +221,7 @@ fn load(
     /// Load firmware and map sections into MCU VM.
     pub(crate) fn new(
         pdev: &'bound platform::Device<Bound>,
-        iomem: Arc<IoMem<'bound>>,
+        hw: Arc<HwGate<'bound>>,
         ddev: &TyrDrmDevice<Uninit>,
         mmu: ArcBorrow<'_, Mmu<'bound>>,
         gpu_info: &GpuInfo,
@@ -262,7 +262,7 @@ pub(crate) fn new(
         let firmware = Arc::pin_init(
             try_pin_init!(Firmware {
                 _pdev: pdev.into(),
-                iomem,
+                hw,
                 vm,
                 sections,
                 global_iface <- new_mutex!(GlobalInterface::new()?),
@@ -288,7 +288,8 @@ pub(crate) fn shared_section<'a>(&'a self) -> Result<&'a Section<'bound>> {
     }
 
     pub(crate) fn boot(&self) -> Result {
-        let io = &self.iomem;
+        let hw_guard = self.hw.access();
+        let io = hw_guard.iomem();
         io.write_reg(MCU_CONTROL::zeroed().with_req(McuControlMode::Auto));
 
         if let Err(e) = poll::read_poll_timeout(
@@ -307,8 +308,9 @@ pub(crate) fn boot(&self) -> Result {
     /// Enable the global interface.
     pub(crate) fn enable_global_interface(&self, gpu_info: &GpuInfo, core_clk: &Clk) -> Result {
         let shared_section = self.shared_section()?;
+        let hw_guard = self.hw.access();
         self.global_iface
             .lock()
-            .enable(&self.iomem, shared_section, gpu_info, core_clk)
+            .enable(hw_guard.iomem(), shared_section, gpu_info, core_clk)
     }
 }
diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
index cb5908c80e3d..8df6d2ef3c74 100644
--- a/drivers/gpu/drm/tyr/mmu.rs
+++ b/drivers/gpu/drm/tyr/mmu.rs
@@ -26,7 +26,6 @@
 };
 
 use crate::{
-    driver::IoMem,
     gpu::GpuInfo,
     mmu::address_space::{
         AddressSpaceManager,
@@ -36,6 +35,7 @@
         gpu_control::AS_PRESENT,
         MAX_AS, //
     },
+    reset::HwGate,
     slot::SlotManager, //
 };
 
@@ -67,14 +67,11 @@ pub(crate) struct Mmu<'bound> {
 
 impl<'bound> Mmu<'bound> {
     /// Create an MMU component for this device.
-    pub(crate) fn new(
-        iomem: ArcBorrow<'_, IoMem<'bound>>,
-        gpu_info: &GpuInfo,
-    ) -> Result<Arc<Mmu<'bound>>> {
+    pub(crate) fn new(hw: Arc<HwGate<'bound>>, gpu_info: &GpuInfo) -> Result<Arc<Mmu<'bound>>> {
         let present = AS_PRESENT::from_raw(gpu_info.as_present).present().get();
         let slot_count = present.count_ones().try_into()?;
 
-        let as_manager = AddressSpaceManager::new(iomem, present)?;
+        let as_manager = AddressSpaceManager::new(hw, present)?;
         let mmu_init = try_pin_init!(Self{
             as_manager <- new_mutex!(SlotManager::new(as_manager, slot_count)?),
         });
diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index d5274220eb3c..4e6832fc1d6f 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -52,6 +52,7 @@
         mmu_control::mmu_as_control::*,
         MAX_AS, //
     },
+    reset::HwGate,
     slot::{
         Seat,
         SlotOperations, //
@@ -199,10 +200,14 @@ fn as_config(&self) -> Result<AddressSpaceConfig> {
 /// disabling, flushing, and updating address spaces. Implements [`SlotOperations`]
 /// to integrate with the generic slot management system.
 ///
+/// Each hardware operation acquires the hardware-access gate once and passes the
+/// guarded MMIO reference to its helpers. Helpers must not re-enter the gate while
+/// an operation holds an SRCU read-side guard.
+///
 /// [`SlotOperations`]: crate::slot::SlotOperations
 pub(crate) struct AddressSpaceManager<'bound> {
-    /// Memory-mapped I/O region for GPU register access.
-    iomem: Arc<IoMem<'bound>>,
+    /// Shared gate that coordinates hardware access with GPU reset.
+    hw: Arc<HwGate<'bound>>,
 
     /// Bitmask of available address space slots from GPU_AS_PRESENT register.
     as_present: u32,
@@ -215,13 +220,18 @@ impl<'bound> SlotOperations for AddressSpaceManager<'bound> {
     /// Activates an address space in a hardware slot.
     fn activate(&mut self, slot_idx: usize, slot_data: &Self::SlotData) -> Result {
         let as_config = slot_data.as_config()?;
-        self.as_enable(slot_idx, &as_config)
+        let hw = self.hw.clone();
+        let hw_guard = hw.access();
+        self.as_enable(hw_guard.iomem(), slot_idx, &as_config)
     }
 
     /// Evicts an address space from a hardware slot.
     fn evict(&mut self, slot_idx: usize, _slot_data: &Self::SlotData) -> Result {
-        self.as_flush(slot_idx)?;
-        self.as_disable(slot_idx)?;
+        let hw = self.hw.clone();
+        let hw_guard = hw.access();
+        let io = hw_guard.iomem();
+        self.as_flush(io, slot_idx)?;
+        self.as_disable(io, slot_idx)?;
         Ok(())
     }
 }
@@ -229,16 +239,13 @@ fn evict(&mut self, slot_idx: usize, _slot_data: &Self::SlotData) -> Result {
 impl<'bound> AddressSpaceManager<'bound> {
     /// Creates a new address space manager.
     ///
-    /// Initializes the manager with references to the platform device and
-    /// I/O memory region, along with the bitmask of available AS slots.
+    /// Initializes the manager with the hardware-access gate and the bitmask
+    /// of available AS slots.
     pub(super) fn new(
-        iomem: ArcBorrow<'_, IoMem<'bound>>,
+        hw: Arc<HwGate<'bound>>,
         as_present: u32,
     ) -> Result<AddressSpaceManager<'bound>> {
-        Ok(Self {
-            iomem: iomem.into(),
-            as_present,
-        })
+        Ok(Self { hw, as_present })
     }
 
     /// Validates that an AS slot number is within range and present in hardware.
@@ -268,8 +275,7 @@ fn validate_as_slot(&self, as_nr: usize) -> Result {
     /// Waits for an AS slot to become ready (not active).
     ///
     /// Returns an error if polling times out after 10ms or if register access fails.
-    fn as_wait_ready(&self, as_nr: usize) -> Result {
-        let io = &*self.iomem;
+    fn as_wait_ready(&self, io: &IoMem<'_>, as_nr: usize) -> Result {
         let op = || {
             let status_reg = STATUS::try_at(as_nr).ok_or(EINVAL)?;
             Ok(io.read(status_reg))
@@ -283,9 +289,8 @@ fn as_wait_ready(&self, as_nr: usize) -> Result {
     /// Sends a command to an AS slot.
     ///
     /// Returns an error if waiting for ready times out or if register write fails.
-    fn as_send_cmd(&mut self, as_nr: usize, cmd: MmuCommand) -> Result {
-        self.as_wait_ready(as_nr)?;
-        let io = &*self.iomem;
+    fn as_send_cmd(&mut self, io: &IoMem<'_>, as_nr: usize, cmd: MmuCommand) -> Result {
+        self.as_wait_ready(io, as_nr)?;
         let command_reg = COMMAND::try_at(as_nr).ok_or(EINVAL)?;
         io.write(command_reg, COMMAND::zeroed().with_command(cmd));
         Ok(())
@@ -294,20 +299,23 @@ fn as_send_cmd(&mut self, as_nr: usize, cmd: MmuCommand) -> Result {
     /// Sends a command to an AS slot and waits for completion.
     ///
     /// Returns an error if sending the command fails or if waiting for completion times out.
-    fn as_send_cmd_and_wait(&mut self, as_nr: usize, cmd: MmuCommand) -> Result {
-        self.as_send_cmd(as_nr, cmd)?;
-        self.as_wait_ready(as_nr)?;
+    fn as_send_cmd_and_wait(&mut self, io: &IoMem<'_>, as_nr: usize, cmd: MmuCommand) -> Result {
+        self.as_send_cmd(io, as_nr, cmd)?;
+        self.as_wait_ready(io, as_nr)?;
         Ok(())
     }
 
     /// Enables an AS slot with the provided configuration.
     ///
     /// Returns an error if the slot is invalid or if register writes/commands fail.
-    fn as_enable(&mut self, as_nr: usize, as_config: &AddressSpaceConfig) -> Result {
+    fn as_enable(
+        &mut self,
+        io: &IoMem<'_>,
+        as_nr: usize,
+        as_config: &AddressSpaceConfig,
+    ) -> Result {
         self.validate_as_slot(as_nr)?;
 
-        let io = &*self.iomem;
-
         let transtab = as_config.transtab;
         io.write(
             TRANSTAB_LO::try_at(as_nr).ok_or(EINVAL)?,
@@ -338,7 +346,7 @@ fn as_enable(&mut self, as_nr: usize, as_config: &AddressSpaceConfig) -> Result
             MEMATTR_HI::from_raw((memattr >> 32) as u32),
         );
 
-        self.as_send_cmd_and_wait(as_nr, MmuCommand::Update)?;
+        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::Update)?;
 
         Ok(())
     }
@@ -346,13 +354,11 @@ fn as_enable(&mut self, as_nr: usize, as_config: &AddressSpaceConfig) -> Result
     /// Disables an AS slot and clears its configuration.
     ///
     /// Returns an error if the slot is invalid or if register writes/commands fail.
-    fn as_disable(&mut self, as_nr: usize) -> Result {
+    fn as_disable(&mut self, io: &IoMem<'_>, as_nr: usize) -> Result {
         self.validate_as_slot(as_nr)?;
 
         // Flush AS before disabling
-        self.as_send_cmd_and_wait(as_nr, MmuCommand::FlushMem)?;
-
-        let io = &*self.iomem;
+        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::FlushMem)?;
 
         io.write(
             TRANSTAB_LO::try_at(as_nr).ok_or(EINVAL)?,
@@ -385,7 +391,7 @@ fn as_disable(&mut self, as_nr: usize) -> Result {
             TRANSCFG_HI::from_raw((transcfg >> 32) as u32),
         );
 
-        self.as_send_cmd_and_wait(as_nr, MmuCommand::Update)?;
+        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::Update)?;
 
         Ok(())
     }
@@ -397,7 +403,7 @@ fn as_disable(&mut self, as_nr: usize) -> Result {
     /// power-of-two region aligned to its size.
     ///
     /// Returns an error if the slot is invalid or if register writes/commands fail.
-    fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> Result {
+    fn as_start_update(&mut self, io: &IoMem<'_>, as_nr: usize, region: &Range<u64>) -> Result {
         self.validate_as_slot(as_nr)?;
 
         // The lock operates on full 64-byte cache lines of translation table entries.
@@ -436,8 +442,6 @@ fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> Result {
         // because log2(32 KiB) = 15.
         let lockaddr_size = lock_region_log2 - 1;
 
-        let io = &*self.iomem;
-
         let lockaddr_val = LOCKADDR::zeroed()
             .try_with_size(lockaddr_size)?
             .try_with_base(lockaddr_base)?
@@ -452,24 +456,24 @@ fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> Result {
             LOCKADDR_HI::from_raw((lockaddr_val >> 32) as u32),
         );
 
-        self.as_send_cmd(as_nr, MmuCommand::Lock)
+        self.as_send_cmd(io, as_nr, MmuCommand::Lock)
     }
 
     /// Completes an atomic translation table update.
     ///
     /// Returns an error if the slot is invalid or if the flush command fails.
-    fn as_end_update(&mut self, as_nr: usize) -> Result {
+    fn as_end_update(&mut self, io: &IoMem<'_>, as_nr: usize) -> Result {
         self.validate_as_slot(as_nr)?;
-        self.as_send_cmd_and_wait(as_nr, MmuCommand::FlushPt)?;
+        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::FlushPt)?;
         Ok(())
     }
 
     /// Flushes the translation table cache for an AS slot.
     ///
     /// Returns an error if the slot is invalid or if the flush command fails.
-    fn as_flush(&mut self, as_nr: usize) -> Result {
+    fn as_flush(&mut self, io: &IoMem<'_>, as_nr: usize) -> Result {
         self.validate_as_slot(as_nr)?;
-        self.as_send_cmd(as_nr, MmuCommand::FlushPt)
+        self.as_send_cmd(io, as_nr, MmuCommand::FlushPt)
     }
 }
 
@@ -486,7 +490,9 @@ pub(super) fn start_vm_update(&mut self, vm: &VmAsData<'bound>, region: &Range<u
         match seat.slot() {
             Some(slot) => {
                 let as_nr = slot as usize;
-                self.as_start_update(as_nr, region)
+                let hw = self.hw.clone();
+                let hw_guard = hw.access();
+                self.as_start_update(hw_guard.iomem(), as_nr, region)
             }
             _ => Ok(()),
         }
@@ -504,7 +510,9 @@ pub(super) fn end_vm_update(&mut self, vm: &VmAsData<'bound>) -> Result {
         match seat.slot() {
             Some(slot) => {
                 let as_nr = slot as usize;
-                self.as_end_update(as_nr)
+                let hw = self.hw.clone();
+                let hw_guard = hw.access();
+                self.as_end_update(hw_guard.iomem(), as_nr)
             }
             _ => Ok(()),
         }
@@ -521,7 +529,9 @@ pub(super) fn flush_vm(&mut self, vm: &VmAsData<'bound>) -> Result {
         match seat.slot() {
             Some(slot) => {
                 let as_nr = slot as usize;
-                self.as_flush(as_nr)
+                let hw = self.hw.clone();
+                let hw_guard = hw.access();
+                self.as_flush(hw_guard.iomem(), as_nr)
             }
             _ => Ok(()),
         }
diff --git a/drivers/gpu/drm/tyr/reset.rs b/drivers/gpu/drm/tyr/reset.rs
index a41158c7ea21..1abcd25877d3 100644
--- a/drivers/gpu/drm/tyr/reset.rs
+++ b/drivers/gpu/drm/tyr/reset.rs
@@ -21,7 +21,7 @@
 
 mod hw_gate;
 
-use hw_gate::HwGate;
+pub(crate) use hw_gate::HwGate;
 
 use kernel::{
     device::{
@@ -41,8 +41,7 @@
             Full,
             Release, //
         },
-        Arc,
-        ArcBorrow, //
+        Arc, //
     },
     time,
     workqueue::{
@@ -84,13 +83,10 @@ unsafe impl AtomicType for ResetState {
 struct Controller<'ctrl> {
     /// Parent platform device.
     pdev: &'ctrl platform::Device<Bound>,
-    /// Mapped register space needed for reset operations.
-    iomem: Arc<IoMem<'ctrl>>,
     /// State shared by reset schedulers and the worker.
     state: Atomic<ResetState>,
-    /// Drains reset-sensitive hardware accesses before a reset.
-    #[pin]
-    hw: HwGate,
+    /// Shared gate that coordinates hardware access with GPU reset.
+    hw: Arc<HwGate<'ctrl>>,
 }
 
 impl<'ctrl> ScopedWorkItem for Controller<'ctrl> {
@@ -103,13 +99,12 @@ impl<'ctrl> Controller<'ctrl> {
     /// Creates a reset controller.
     fn new(
         pdev: &'ctrl platform::Device<Bound>,
-        iomem: Arc<IoMem<'ctrl>>,
+        hw: Arc<HwGate<'ctrl>>,
     ) -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
             pdev,
-            iomem,
             state: Atomic::new(ResetState::Idle),
-            hw <- HwGate::new(),
+            hw,
         })
     }
 
@@ -136,10 +131,7 @@ fn reset_work(&self) {
 
         dev_dbg!(self.pdev, "Starting GPU reset.\n");
 
-        // Wait for current hardware accesses to finish before resetting.
-        let reset_guard = self.hw.close();
-        let reset_result = run_reset(self.pdev.as_ref(), &self.iomem);
-        drop(reset_guard);
+        let reset_result = run_reset(self.pdev.as_ref(), &self.hw);
 
         if let Err(e) = reset_result {
             dev_err!(self.pdev, "GPU reset failed: {:?}\n", e);
@@ -175,12 +167,10 @@ impl<'reset> ResetHandle<'reset> {
     /// running [`Drop`], since it owns work that may borrow from `'reset`.
     pub(crate) unsafe fn new(
         pdev: &'reset platform::Device<Bound>,
-        iomem: ArcBorrow<'_, IoMem<'reset>>,
+        hw: Arc<HwGate<'reset>>,
     ) -> Result<impl PinInit<Self, Error>> {
-        let iomem = iomem.into();
-
         Ok(try_pin_init!(Self {
-            controller <- kernel::new_scoped_work!("tyr::reset", Controller::new(pdev, iomem)),
+            controller <- kernel::new_scoped_work!("tyr::reset", Controller::new(pdev, hw)),
             // SAFETY: The caller guarantees the handle is dropped.
             wq: unsafe { ScopedQueue::new(c"tyr-reset-wq")? },
         }))
@@ -242,7 +232,10 @@ fn issue_soft_reset(dev: &Device<Bound>, io: &IoMem<'_>) -> Result {
 ///   - Trigger a GPU soft reset.
 ///   - Wait for the reset-complete IRQ status.
 ///   - Power L2 back on.
-pub(super) fn run_reset(dev: &Device<Bound>, iomem: &IoMem<'_>) -> Result {
+pub(super) fn run_reset(dev: &Device<Bound>, hw: &HwGate<'_>) -> Result {
+    let hw_guard = hw.close();
+    let iomem = hw_guard.iomem();
+
     issue_soft_reset(dev, iomem)?;
     gpu::l2_power_on(dev, iomem)?;
     Ok(())
diff --git a/drivers/gpu/drm/tyr/reset/hw_gate.rs b/drivers/gpu/drm/tyr/reset/hw_gate.rs
index 54754f9fc05f..201f8c953078 100644
--- a/drivers/gpu/drm/tyr/reset/hw_gate.rs
+++ b/drivers/gpu/drm/tyr/reset/hw_gate.rs
@@ -18,9 +18,13 @@
     },
 };
 
+use crate::driver::IoMem;
+
 /// Synchronizes GPU hardware access with reset.
 #[pin_data]
-pub(super) struct HwGate {
+pub(crate) struct HwGate<'hw> {
+    /// GPU MMIO register mapping.
+    iomem: IoMem<'hw>,
     /// Admits readers and is held exclusively while the reset worker owns the
     /// hardware.
     #[pin]
@@ -30,30 +34,37 @@ pub(super) struct HwGate {
     srcu: Srcu,
 }
 
-impl HwGate {
+impl<'hw> HwGate<'hw> {
     /// Creates an open hardware-access gate.
-    pub(super) fn new() -> impl PinInit<Self, Error> {
+    pub(crate) fn new(iomem: IoMem<'hw>) -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
+            iomem,
             gate_lock <- new_mutex!(()),
             srcu <- kernel::new_srcu!(),
         })
     }
 
     /// Enters a reset-sensitive hardware-access section.
-    #[expect(dead_code)]
-    fn access(&self) -> HwAccessGuard<'_> {
+    ///
+    /// This gate is not reentrant. Acquire it once for the whole hardware operation
+    /// and pass the guard's MMIO reference to helpers. Re-entering while holding a
+    /// guard can deadlock with a reset holding `gate_lock` while draining readers.
+    pub(crate) fn access(&self) -> HwAccessGuard<'_, 'hw> {
         let gate_lock = self.gate_lock.lock();
         let srcu = self.srcu.read_lock();
         drop(gate_lock);
 
-        HwAccessGuard { _srcu: srcu }
+        HwAccessGuard {
+            gate: self,
+            _srcu: srcu,
+        }
     }
 
     /// Stops new readers and drains admitted readers for the reset worker.
     ///
     /// Callers must serialize write-side access. The reset controller's state
     /// machine provides that serialization.
-    pub(super) fn close(&self) -> HwClosedGuard<'_> {
+    pub(super) fn close(&self) -> HwClosedGuard<'_, 'hw> {
         let gate_lock = self.gate_lock.lock();
 
         // Holding `gate_lock` prevents new readers from entering SRCU. Readers
@@ -61,6 +72,7 @@ pub(super) fn close(&self) -> HwClosedGuard<'_> {
         self.srcu.synchronize();
 
         HwClosedGuard {
+            gate: self,
             _gate_lock: gate_lock,
         }
     }
@@ -68,13 +80,27 @@ pub(super) fn close(&self) -> HwClosedGuard<'_> {
 
 /// Shared hardware access that blocks reset until dropped.
 #[must_use = "the gate is released when the guard is dropped"]
-struct HwAccessGuard<'a> {
+pub(crate) struct HwAccessGuard<'a, 'hw> {
+    gate: &'a HwGate<'hw>,
     _srcu: srcu::Guard<'a>,
 }
 
+impl<'a, 'hw> HwAccessGuard<'a, 'hw> {
+    pub(crate) fn iomem(&self) -> &IoMem<'hw> {
+        &self.gate.iomem
+    }
+}
+
 /// Exclusive hardware access for the reset worker that blocks new hardware
 /// accesses until dropped.
 #[must_use = "the gate stays closed until the guard is dropped"]
-pub(super) struct HwClosedGuard<'a> {
+pub(super) struct HwClosedGuard<'a, 'hw> {
+    gate: &'a HwGate<'hw>,
     _gate_lock: MutexGuard<'a, ()>,
 }
+
+impl<'a, 'hw> HwClosedGuard<'a, 'hw> {
+    pub(super) fn iomem(&self) -> &IoMem<'hw> {
+        &self.gate.iomem
+    }
+}

-- 
2.54.0
