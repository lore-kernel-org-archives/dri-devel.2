Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62809C5CFC1
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 10:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B9C910E1B1;
	Sat, 15 Aug 2026 10:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="eOcXBfXD";
	dkim-atps=neutral
Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch
 [185.70.43.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769C910E1B1
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 10:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1786789532; x=1787048732;
 bh=RZdeoJJVRJ4nWalD/8I8LSa342o9Wo31uEBZe+oaUDg=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=eOcXBfXDyDbxom85zs5xd0XIcRnkN2WIcY9aqK9Xf6IhUBgaBQmRlvXSmVi1zLKyv
 QZ0M7Y0naQ/kQEa/JB467YdHQkZxl3A/x0vtsm5S/QJBOB428iWNboDGPGESZIwiXZ
 NymUFcCyqokOH9+nxUTkqeLbPTPJ3/WEGilaIW8dRf6KhwzNory6d1KtgUQ1IgEMGb
 yGAvtHXg47ln5tKKte3/OTn8+2Kawh9HolNvzSye9N4AMjN5oXLZ+31SMgBIISTPaN
 y9gg0c8c7+u8S8lhnYeYZSwc/7UtxpShsneGMzSu/MYFDKtg6Hs7kaYmBQB6HcpDMv
 sn1CVFKPj3alg==
X-Pm-Submission-Id: 4hMZx60kqkz2SchQ
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v4 4/4] drm/tyr: put iomem behind the hardware gate
Date: Sat, 15 Aug 2026 13:24:00 +0300
Message-ID: <20260815-tyr-reset-impl-v4-4-578df9a5e576@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260815-tyr-reset-impl-v4-0-578df9a5e576@onurozkan.dev>
References: <20260815-tyr-reset-impl-v4-0-578df9a5e576@onurozkan.dev>
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

Suggested-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 drivers/gpu/drm/tyr/driver.rs            | 26 +++++++----------
 drivers/gpu/drm/tyr/fw.rs                | 16 ++++++-----
 drivers/gpu/drm/tyr/mmu.rs               |  9 ++----
 drivers/gpu/drm/tyr/mmu/address_space.rs | 49 ++++++++++++++++----------------
 drivers/gpu/drm/tyr/reset.rs             | 34 +++++++++-------------
 drivers/gpu/drm/tyr/reset/hw_gate.rs     | 40 ++++++++++++++++++++------
 6 files changed, 90 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index bd613ab7e05c..936624340edd 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -75,9 +75,6 @@ pub(crate) struct TyrDrmRegistrationData<'bound> {
     #[pin]
     regulators: Mutex<Regulators>,
 
-    /// GPU MMIO register mapping.
-    pub(crate) iomem: Arc<IoMem<'bound>>,
-
     /// Some information on the GPU.
     ///
     /// This is mainly queried by userspace, i.e.: Mesa.
@@ -116,11 +113,15 @@ fn probe<'bound>(
 
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
-        let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?, GFP_KERNEL)?;
+        let hw = Arc::pin_init(
+            reset::HwGate::new(request.iomap_sized::<SZ_2M>()?),
+            GFP_KERNEL,
+        )?;
 
-        reset::run_reset(pdev.as_ref(), &iomem)?;
+        reset::run_reset(pdev.as_ref(), &hw)?;
 
-        let gpu_info = GpuInfo::new(&iomem);
+        let hw_guard = hw.access();
+        let gpu_info = GpuInfo::new(hw_guard.iomem());
         gpu_info.log(pdev.as_ref());
 
         let pa_bits = MMU_FEATURES::from_raw(gpu_info.mmu_features)
@@ -135,17 +136,11 @@ fn probe<'bound>(
 
         // SAFETY: `ResetHandle` is stored in registration data created with `new_with_lt`
         // and is dropped before the borrowed device and MMIO references expire.
-        let reset = unsafe { reset::ResetHandle::new(pdev, iomem.as_arc_borrow())? };
+        let reset = unsafe { reset::ResetHandle::new(pdev, hw.clone())? };
 
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
@@ -163,7 +158,6 @@ fn probe<'bound>(
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
index d5274220eb3c..7ce2902e6300 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -42,7 +42,6 @@
 };
 
 use crate::{
-    driver::IoMem,
     mmu::{
         AsSlotManager,
         Mmu, //
@@ -52,6 +51,7 @@
         mmu_control::mmu_as_control::*,
         MAX_AS, //
     },
+    reset::HwGate,
     slot::{
         Seat,
         SlotOperations, //
@@ -201,8 +201,8 @@ fn as_config(&self) -> Result<AddressSpaceConfig> {
 ///
 /// [`SlotOperations`]: crate::slot::SlotOperations
 pub(crate) struct AddressSpaceManager<'bound> {
-    /// Memory-mapped I/O region for GPU register access.
-    iomem: Arc<IoMem<'bound>>,
+    /// Shared gate that coordinates hardware access with GPU reset.
+    hw: Arc<HwGate<'bound>>,
 
     /// Bitmask of available address space slots from GPU_AS_PRESENT register.
     as_present: u32,
@@ -229,16 +229,13 @@ fn evict(&mut self, slot_idx: usize, _slot_data: &Self::SlotData) -> Result {
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
@@ -269,7 +266,8 @@ fn validate_as_slot(&self, as_nr: usize) -> Result {
     ///
     /// Returns an error if polling times out after 10ms or if register access fails.
     fn as_wait_ready(&self, as_nr: usize) -> Result {
-        let io = &*self.iomem;
+        let hw_guard = self.hw.access();
+        let io = hw_guard.iomem();
         let op = || {
             let status_reg = STATUS::try_at(as_nr).ok_or(EINVAL)?;
             Ok(io.read(status_reg))
@@ -283,9 +281,10 @@ fn as_wait_ready(&self, as_nr: usize) -> Result {
     /// Sends a command to an AS slot.
     ///
     /// Returns an error if waiting for ready times out or if register write fails.
-    fn as_send_cmd(&mut self, as_nr: usize, cmd: MmuCommand) -> Result {
+    fn as_send_cmd(&self, as_nr: usize, cmd: MmuCommand) -> Result {
         self.as_wait_ready(as_nr)?;
-        let io = &*self.iomem;
+        let hw_guard = self.hw.access();
+        let io = hw_guard.iomem();
         let command_reg = COMMAND::try_at(as_nr).ok_or(EINVAL)?;
         io.write(command_reg, COMMAND::zeroed().with_command(cmd));
         Ok(())
@@ -294,7 +293,7 @@ fn as_send_cmd(&mut self, as_nr: usize, cmd: MmuCommand) -> Result {
     /// Sends a command to an AS slot and waits for completion.
     ///
     /// Returns an error if sending the command fails or if waiting for completion times out.
-    fn as_send_cmd_and_wait(&mut self, as_nr: usize, cmd: MmuCommand) -> Result {
+    fn as_send_cmd_and_wait(&self, as_nr: usize, cmd: MmuCommand) -> Result {
         self.as_send_cmd(as_nr, cmd)?;
         self.as_wait_ready(as_nr)?;
         Ok(())
@@ -303,10 +302,10 @@ fn as_send_cmd_and_wait(&mut self, as_nr: usize, cmd: MmuCommand) -> Result {
     /// Enables an AS slot with the provided configuration.
     ///
     /// Returns an error if the slot is invalid or if register writes/commands fail.
-    fn as_enable(&mut self, as_nr: usize, as_config: &AddressSpaceConfig) -> Result {
+    fn as_enable(&self, as_nr: usize, as_config: &AddressSpaceConfig) -> Result {
         self.validate_as_slot(as_nr)?;
-
-        let io = &*self.iomem;
+        let hw_guard = self.hw.access();
+        let io = hw_guard.iomem();
 
         let transtab = as_config.transtab;
         io.write(
@@ -346,14 +345,14 @@ fn as_enable(&mut self, as_nr: usize, as_config: &AddressSpaceConfig) -> Result
     /// Disables an AS slot and clears its configuration.
     ///
     /// Returns an error if the slot is invalid or if register writes/commands fail.
-    fn as_disable(&mut self, as_nr: usize) -> Result {
+    fn as_disable(&self, as_nr: usize) -> Result {
         self.validate_as_slot(as_nr)?;
+        let hw_guard = self.hw.access();
+        let io = hw_guard.iomem();
 
         // Flush AS before disabling
         self.as_send_cmd_and_wait(as_nr, MmuCommand::FlushMem)?;
 
-        let io = &*self.iomem;
-
         io.write(
             TRANSTAB_LO::try_at(as_nr).ok_or(EINVAL)?,
             TRANSTAB_LO::from_raw(0),
@@ -397,8 +396,10 @@ fn as_disable(&mut self, as_nr: usize) -> Result {
     /// power-of-two region aligned to its size.
     ///
     /// Returns an error if the slot is invalid or if register writes/commands fail.
-    fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> Result {
+    fn as_start_update(&self, as_nr: usize, region: &Range<u64>) -> Result {
         self.validate_as_slot(as_nr)?;
+        let hw_guard = self.hw.access();
+        let io = hw_guard.iomem();
 
         // The lock operates on full 64-byte cache lines of translation table entries.
         // Since each translation table entry (TTE) is 8 bytes, a cache line has 8 TTEs.
@@ -436,8 +437,6 @@ fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> Result {
         // because log2(32 KiB) = 15.
         let lockaddr_size = lock_region_log2 - 1;
 
-        let io = &*self.iomem;
-
         let lockaddr_val = LOCKADDR::zeroed()
             .try_with_size(lockaddr_size)?
             .try_with_base(lockaddr_base)?
@@ -458,7 +457,7 @@ fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> Result {
     /// Completes an atomic translation table update.
     ///
     /// Returns an error if the slot is invalid or if the flush command fails.
-    fn as_end_update(&mut self, as_nr: usize) -> Result {
+    fn as_end_update(&self, as_nr: usize) -> Result {
         self.validate_as_slot(as_nr)?;
         self.as_send_cmd_and_wait(as_nr, MmuCommand::FlushPt)?;
         Ok(())
@@ -467,7 +466,7 @@ fn as_end_update(&mut self, as_nr: usize) -> Result {
     /// Flushes the translation table cache for an AS slot.
     ///
     /// Returns an error if the slot is invalid or if the flush command fails.
-    fn as_flush(&mut self, as_nr: usize) -> Result {
+    fn as_flush(&self, as_nr: usize) -> Result {
         self.validate_as_slot(as_nr)?;
         self.as_send_cmd(as_nr, MmuCommand::FlushPt)
     }
diff --git a/drivers/gpu/drm/tyr/reset.rs b/drivers/gpu/drm/tyr/reset.rs
index a0eabf8ac6d0..69c1ea3d6abc 100644
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
@@ -83,13 +82,10 @@ unsafe impl AtomicType for ResetState {
 struct Controller<'bound> {
     /// Parent platform device.
     pdev: &'bound platform::Device<Bound>,
-    /// Mapped register space needed for reset operations.
-    iomem: Arc<IoMem<'bound>>,
     /// State shared by reset schedulers and the worker.
     state: Atomic<ResetState>,
-    /// Drains reset-sensitive hardware accesses before a reset.
-    #[pin]
-    hw: HwGate,
+    /// Shared gate that coordinates hardware access with GPU reset.
+    hw: Arc<HwGate<'bound>>,
     /// Work item backing async reset processing.
     #[pin]
     work: Work<Controller<'bound>>,
@@ -109,16 +105,12 @@ fn run(this: Arc<Self>) {
 
 impl<'bound> Controller<'bound> {
     /// Creates an [`Arc<Controller>`] ready for use.
-    fn new(
-        pdev: &'bound platform::Device<Bound>,
-        iomem: ArcBorrow<'_, IoMem<'bound>>,
-    ) -> Result<Arc<Self>> {
+    fn new(pdev: &'bound platform::Device<Bound>, hw: Arc<HwGate<'bound>>) -> Result<Arc<Self>> {
         Arc::pin_init(
             try_pin_init!(Self {
                 pdev,
-                iomem: iomem.into(),
                 state: Atomic::new(ResetState::Idle),
-                hw <- HwGate::new(),
+                hw,
                 work <- kernel::new_work!("tyr::reset"),
             }),
             GFP_KERNEL,
@@ -148,10 +140,7 @@ fn reset_work(self: &Arc<Self>) {
 
         dev_info!(self.pdev, "Starting GPU reset.\n");
 
-        // Wait for current hardware accesses to finish before resetting.
-        let reset_guard = self.hw.close();
-        let reset_result = run_reset(self.pdev.as_ref(), &self.iomem);
-        drop(reset_guard);
+        let reset_result = run_reset(self.pdev.as_ref(), &self.hw);
 
         if let Err(e) = reset_result {
             dev_err!(self.pdev, "GPU reset failed: {:?}\n", e);
@@ -185,10 +174,10 @@ impl<'bound> ResetHandle<'bound> {
     /// running [`Drop`], since it owns work that may borrow from `'bound`.
     pub(crate) unsafe fn new(
         pdev: &'bound platform::Device<Bound>,
-        iomem: ArcBorrow<'_, IoMem<'bound>>,
+        hw: Arc<HwGate<'bound>>,
     ) -> Result<Self> {
         Ok(Self {
-            controller: Controller::new(pdev, iomem)?,
+            controller: Controller::new(pdev, hw)?,
             // SAFETY: The caller guarantees the handle is dropped.
             wq: unsafe { ScopedQueue::new(c"tyr-reset-wq")? },
         })
@@ -253,7 +242,10 @@ fn issue_soft_reset<'bound>(dev: &'bound Device<Bound>, io: &IoMem<'bound>) -> R
 ///   - Trigger a GPU soft reset.
 ///   - Wait for the reset-complete IRQ status.
 ///   - Power L2 back on.
-pub(super) fn run_reset<'bound>(dev: &'bound Device<Bound>, iomem: &IoMem<'bound>) -> Result {
+pub(super) fn run_reset<'bound>(dev: &'bound Device<Bound>, hw: &HwGate<'bound>) -> Result {
+    let hw_guard = hw.close();
+    let iomem = hw_guard.iomem();
+
     issue_soft_reset(dev, iomem)?;
     gpu::l2_power_on(dev, iomem)?;
     Ok(())
diff --git a/drivers/gpu/drm/tyr/reset/hw_gate.rs b/drivers/gpu/drm/tyr/reset/hw_gate.rs
index 54754f9fc05f..e761a0b03661 100644
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
+pub(crate) struct HwGate<'bound> {
+    /// GPU MMIO register mapping.
+    iomem: IoMem<'bound>,
     /// Admits readers and is held exclusively while the reset worker owns the
     /// hardware.
     #[pin]
@@ -30,30 +34,33 @@ pub(super) struct HwGate {
     srcu: Srcu,
 }
 
-impl HwGate {
+impl<'bound> HwGate<'bound> {
     /// Creates an open hardware-access gate.
-    pub(super) fn new() -> impl PinInit<Self, Error> {
+    pub(crate) fn new(iomem: IoMem<'bound>) -> impl PinInit<Self, Error> {
         try_pin_init!(Self {
+            iomem,
             gate_lock <- new_mutex!(()),
             srcu <- kernel::new_srcu!(),
         })
     }
 
     /// Enters a reset-sensitive hardware-access section.
-    #[expect(dead_code)]
-    fn access(&self) -> HwAccessGuard<'_> {
+    pub(crate) fn access(&self) -> HwAccessGuard<'_, 'bound> {
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
+    pub(super) fn close(&self) -> HwClosedGuard<'_, 'bound> {
         let gate_lock = self.gate_lock.lock();
 
         // Holding `gate_lock` prevents new readers from entering SRCU. Readers
@@ -61,6 +68,7 @@ pub(super) fn close(&self) -> HwClosedGuard<'_> {
         self.srcu.synchronize();
 
         HwClosedGuard {
+            gate: self,
             _gate_lock: gate_lock,
         }
     }
@@ -68,13 +76,27 @@ pub(super) fn close(&self) -> HwClosedGuard<'_> {
 
 /// Shared hardware access that blocks reset until dropped.
 #[must_use = "the gate is released when the guard is dropped"]
-struct HwAccessGuard<'a> {
+pub(crate) struct HwAccessGuard<'a, 'bound> {
+    gate: &'a HwGate<'bound>,
     _srcu: srcu::Guard<'a>,
 }
 
+impl<'a, 'bound> HwAccessGuard<'a, 'bound> {
+    pub(crate) fn iomem(&self) -> &IoMem<'bound> {
+        &self.gate.iomem
+    }
+}
+
 /// Exclusive hardware access for the reset worker that blocks new hardware
 /// accesses until dropped.
 #[must_use = "the gate stays closed until the guard is dropped"]
-pub(super) struct HwClosedGuard<'a> {
+pub(super) struct HwClosedGuard<'a, 'bound> {
+    gate: &'a HwGate<'bound>,
     _gate_lock: MutexGuard<'a, ()>,
 }
+
+impl<'a, 'bound> HwClosedGuard<'a, 'bound> {
+    pub(super) fn iomem(&self) -> &IoMem<'bound> {
+        &self.gate.iomem
+    }
+}

-- 
2.51.2
