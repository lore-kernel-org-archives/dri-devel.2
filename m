Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EC4606A33E
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.a=rsa-sha256 header.s=protonmail2 header.b=hyCcl6Dc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF86B1125C3;
	Fri, 13 Nov 2026 14:33:55 +0000 (UTC)
Received: from mail-106113.protonmail.ch (mail-106113.protonmail.ch
 [79.135.106.113])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 312AF1125C3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 14:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail2; t=1794580424; x=1794839624;
 bh=3oUZ1JHjNyLtoGlDZ8Mo9dnLlowDVdJ5Yz0xC5xOzXU=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=hyCcl6DcUCc0bVJus+MU0NBx0ms0+5fRRc1870zikBNWhbMVs/yk7n01v4GsK7mz9
 TEM4TeixTDPTKC1a+OTF7Rhv4eS8v1nbDv4j2ur0HyFzVUGHCtUbjRFJR8gScyue5T
 c6Mc+ImSjqrfjoSHjLb2VIBE8blrNIBxAtmPK0xATS3DLMrBH/qFd3BL6raaX6q/Xn
 CCPEqJjGkU4cawluPqDTw5NNoR/GykSE+hxPe+8HZ/NtB+pVIX1aJZ/BKNcNv5SMbp
 Us3WxrG3L7NmwJPO96zsIqYtzJP97FAtAYPTepE2QG+Qk5sk+LAZnhG/awj08g/JRk
 3FhzkRo+1y3NQ==
X-Pm-Submission-Id: 4jR09w5rZDz1DDrH
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, work@onurozkan.dev,
 boris.brezillon@collabora.com
Subject: [PATCH v8 3/3] drm/tyr: put iomem behind the hardware gate
Date: Fri, 13 Nov 2026 17:32:28 +0300
Message-ID: <20261113-tyr-reset-impl-v8-3-2ee298ac9808@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
References: <20261113-tyr-reset-impl-v8-0-2ee298ac9808@onurozkan.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move iomem mapping into HwGate and pass Arc<HwGate> to components that
access hardware. Callers obtain HwAccessGuard before accessing the iomem
so the reset worker waits for ongoing accesses.

Acquire the gate once per address-space operation and pass the guarded
iomem reference to its helpers. This prevents nested gate acquisition
from deadlocking with reset and keeps each operation protected throughout.
Clone the gate Arc before acquiring the guard so mutating helpers can
retain their mutable self receivers.

Suggested-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 drivers/gpu/drm/tyr/driver.rs            | 27 ++++++----
 drivers/gpu/drm/tyr/fw.rs                | 16 +++---
 drivers/gpu/drm/tyr/mmu.rs               |  6 +--
 drivers/gpu/drm/tyr/mmu/address_space.rs | 87 ++++++++++++++++++--------------
 drivers/gpu/drm/tyr/reset.rs             | 33 +++++-------
 drivers/gpu/drm/tyr/reset/hw_gate.rs     | 44 ++++++++++++----
 6 files changed, 126 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 863c8008a132..ab4f5ff95f1f 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -79,9 +79,6 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
     #[pin]
     regulators: Mutex<Regulators>,
 
-    /// GPU MMIO register mapping.
-    pub(crate) iomem: Arc<IoMem<'drm>>,
-
     /// GPU information read from hardware during probe.
     pub(crate) gpu_info: GpuInfo,
 }
@@ -118,12 +115,21 @@ fn probe<'bound>(
 
             let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
-            let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?, GFP_KERNEL)?;
+            // TODO: Consider embedding HwGate in platform data and using self referential
+            // pin-init instead of Arc.
+            let hw = Arc::pin_init(
+                reset::HwGate::new(request.iomap_sized::<SZ_2M>()?),
+                GFP_KERNEL,
+            )?;
 
-            reset::run_reset(pdev.as_ref(), &iomem)?;
+            reset::run_reset(pdev.as_ref(), &hw)?;
 
-            let gpu_info = GpuInfo::new(&iomem);
-            gpu_info.log(pdev.as_ref());
+            let gpu_info = {
+                let hw_guard = hw.access();
+                let gpu_info = GpuInfo::new(hw_guard.iomem());
+                gpu_info.log(pdev.as_ref());
+                gpu_info
+            };
 
             let pa_bits = MMU_FEATURES::from_raw(gpu_info.mmu_features)
                 .pa_bits()
@@ -135,11 +141,11 @@ fn probe<'bound>(
 
             let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
 
-            let mmu = Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &gpu_info)?;
+            let mmu = Mmu::new(pdev.as_ref(), hw.clone(), &gpu_info)?;
 
             let firmware = Firmware::new(
                 pdev.as_ref(),
-                iomem.clone(),
+                hw.clone(),
                 &unreg_dev,
                 mmu.as_arc_borrow(),
                 &gpu_info,
@@ -157,7 +163,7 @@ fn probe<'bound>(
                         pdev,
                         // SAFETY: The registration is owned by platform driver data,
                         // so reset work is drained before borrowed data expires.
-                        reset <- reset::ResetHandle::new(pdev, iomem.as_arc_borrow())?,
+                        reset <- reset::ResetHandle::new(pdev, hw.clone())?,
                         fw: firmware,
                         clks <- new_mutex!(Clocks {
                             core: core_clk,
@@ -168,7 +174,6 @@ fn probe<'bound>(
                             _mali: mali_regulator,
                             _sram: sram_regulator,
                         }),
-                        iomem,
                         gpu_info,
                     }),
                 )},
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index aea151ff1f93..f2e0404addf2 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -38,7 +38,6 @@
 
 use crate::{
     driver::{
-        IoMem,
         TyrDrmDevice, //
     },
     fw::parser::{
@@ -66,6 +65,7 @@
             JOB_IRQ_RAWSTAT, //
         }, //
     },
+    reset::HwGate,
     vm::Vm, //
 };
 
@@ -144,8 +144,8 @@ struct Section<'drm> {
 
 /// Loaded firmware with sections mapped into MCU VM.
 pub(crate) struct Firmware<'drm> {
-    /// Iomem need to access registers.
-    iomem: Arc<IoMem<'drm>>,
+    /// Shared gate that coordinates hardware access with GPU reset.
+    hw: Arc<HwGate<'drm>>,
 
     /// MCU VM.
     vm: Arc<Vm<'drm>>,
@@ -214,7 +214,7 @@ fn load(
     /// Load firmware and map sections into MCU VM.
     pub(crate) fn new(
         dev: &'drm Device<Bound>,
-        iomem: Arc<IoMem<'drm>>,
+        hw: Arc<HwGate<'drm>>,
         ddev: &TyrDrmDevice,
         mmu: ArcBorrow<'_, Mmu<'drm>>,
         gpu_info: &GpuInfo,
@@ -253,7 +253,7 @@ pub(crate) fn new(
             }
 
             Ok(Firmware {
-                iomem,
+                hw,
                 vm: vm.clone(),
                 sections,
             })
@@ -267,7 +267,8 @@ pub(crate) fn new(
     }
 
     pub(crate) fn boot(&self) -> Result {
-        let io = &self.iomem;
+        let hw_guard = self.hw.access();
+        let io = hw_guard.iomem();
 
         // Discard any stale global interrupt.
         io.write_reg(JOB_IRQ_CLEAR::zeroed().with_glb(true));
@@ -297,7 +298,8 @@ pub(crate) fn boot(&self) -> Result {
     }
 
     fn stop(&self) -> Result {
-        let io = &self.iomem;
+        let hw_guard = self.hw.access();
+        let io = hw_guard.iomem();
         io.write_reg(MCU_CONTROL::zeroed().with_req(McuControlMode::Disable));
 
         if let Err(e) = poll::read_poll_timeout(
diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
index 5e88c9e6a4cd..adac036744a3 100644
--- a/drivers/gpu/drm/tyr/mmu.rs
+++ b/drivers/gpu/drm/tyr/mmu.rs
@@ -28,7 +28,6 @@
 };
 
 use crate::{
-    driver::IoMem,
     gpu::GpuInfo,
     mmu::address_space::{
         AddressSpaceManager,
@@ -38,6 +37,7 @@
         gpu_control::AS_PRESENT,
         MAX_AS, //
     },
+    reset::HwGate,
     slot::SlotManager, //
 };
 
@@ -57,13 +57,13 @@ impl<'drm> Mmu<'drm> {
     /// Create an MMU component for this device.
     pub(crate) fn new(
         dev: &'drm Device<Bound>,
-        iomem: ArcBorrow<'_, IoMem<'drm>>,
+        hw: Arc<HwGate<'drm>>,
         gpu_info: &GpuInfo,
     ) -> Result<Arc<Mmu<'drm>>> {
         let present = AS_PRESENT::from_raw(gpu_info.as_present).present().get();
         let slot_count = present.count_ones().try_into()?;
 
-        let address_space_manager = AddressSpaceManager::new(dev, iomem.into(), present)?;
+        let address_space_manager = AddressSpaceManager::new(dev, hw, present)?;
         let as_slot_manager =
             SlotManager::new(address_space_manager, slot_count).inspect_err(|e| {
                 dev_err!(
diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index 76e3d2df6afd..34f5481a6957 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -49,6 +49,7 @@
         mmu_control::mmu_as_control::*,
         MAX_AS, //
     },
+    reset::HwGate,
     slot::{
         LockedSeat,
         Seat,
@@ -147,12 +148,16 @@ fn as_config(&self) -> Result<AddressSpaceConfig> {
 
 /// Coordinates all hardware-level address space operations through MMIO register
 /// operations including enabling, disabling, flushing, and updating address spaces.
+///
+/// Each hardware operation acquires the hardware-access gate once and passes the
+/// guarded MMIO reference to its helpers. Helpers must not re-enter the gate while
+/// an operation holds an SRCU read-side guard.
 pub(crate) struct AddressSpaceManager<'drm> {
     /// Parent device used for logging.
     dev: &'drm Device<Bound>,
 
-    /// Memory-mapped I/O region for GPU register access.
-    iomem: Arc<IoMem<'drm>>,
+    /// Shared gate that coordinates hardware access with GPU reset.
+    hw: Arc<HwGate<'drm>>,
 
     /// Bitmask of present address space slots from GPU_AS_PRESENT register.
     as_present: u32,
@@ -161,11 +166,11 @@ pub(crate) struct AddressSpaceManager<'drm> {
 impl<'drm> AddressSpaceManager<'drm> {
     /// Creates a new address space manager.
     ///
-    /// Initializes the manager with references to the platform device and
-    /// I/O memory region, along with the bitmask of available AS slots.
+    /// Initializes the manager with the device, hardware-access gate and bitmask
+    /// of available AS slots.
     pub(super) fn new(
         dev: &'drm Device<Bound>,
-        iomem: Arc<IoMem<'drm>>,
+        hw: Arc<HwGate<'drm>>,
         as_present: u32,
     ) -> Result<AddressSpaceManager<'drm>> {
         if as_present.trailing_ones() != as_present.count_ones() {
@@ -178,7 +183,7 @@ pub(super) fn new(
         }
         Ok(Self {
             dev,
-            iomem,
+            hw,
             as_present,
         })
     }
@@ -215,8 +220,7 @@ fn validate_as_slot(&self, as_nr: usize) -> Result {
     /// Waits for an AS slot to become ready (not active).
     ///
     /// Returns an error if polling times out after 10ms or if register access fails.
-    fn as_wait_ready(&self, as_nr: usize) -> Result {
-        let io = &*self.iomem;
+    fn as_wait_ready(&self, io: &IoMem<'_>, as_nr: usize) -> Result {
         let op = || {
             let status_reg = STATUS::try_at(as_nr).ok_or(EINVAL)?;
             Ok(io.read(status_reg))
@@ -230,9 +234,8 @@ fn as_wait_ready(&self, as_nr: usize) -> Result {
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
@@ -241,20 +244,23 @@ fn as_send_cmd(&mut self, as_nr: usize, cmd: MmuCommand) -> Result {
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
@@ -285,7 +291,7 @@ fn as_enable(&mut self, as_nr: usize, as_config: &AddressSpaceConfig) -> Result
             MEMATTR_HI::from_raw((memattr >> 32) as u32),
         );
 
-        self.as_send_cmd_and_wait(as_nr, MmuCommand::Update)?;
+        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::Update)?;
 
         Ok(())
     }
@@ -293,13 +299,11 @@ fn as_enable(&mut self, as_nr: usize, as_config: &AddressSpaceConfig) -> Result
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
@@ -332,7 +336,7 @@ fn as_disable(&mut self, as_nr: usize) -> Result {
             TRANSCFG_HI::from_raw((transcfg >> 32) as u32),
         );
 
-        self.as_send_cmd_and_wait(as_nr, MmuCommand::Update)?;
+        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::Update)?;
 
         Ok(())
     }
@@ -344,7 +348,7 @@ fn as_disable(&mut self, as_nr: usize) -> Result {
     /// power-of-two region aligned to its size.
     ///
     /// Returns an error if the slot is invalid or if register writes/commands fail.
-    fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> Result {
+    fn as_start_update(&mut self, io: &IoMem<'_>, as_nr: usize, region: &Range<u64>) -> Result {
         self.validate_as_slot(as_nr)?;
 
         // Avoid both an empty range and an inverted range.
@@ -394,8 +398,6 @@ fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> Result {
         // because log2(32 KiB) = 15.
         let lockaddr_size = lock_region_log2 - 1;
 
-        let io = &*self.iomem;
-
         // The LOCKADDR base field stores address bits 63:12, so remove the low 12 bits
         // before passing this value to the register macro helper.
         // These bits are guaranteed to be zero anyway because of the minimum
@@ -415,24 +417,24 @@ fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> Result {
             LOCKADDR_HI::from_raw((lockaddr_val >> 32) as u32),
         );
 
-        self.as_send_cmd_and_wait(as_nr, MmuCommand::Lock)
+        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::Lock)
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
-        self.as_send_cmd_and_wait(as_nr, MmuCommand::FlushPt)
+        self.as_send_cmd_and_wait(io, as_nr, MmuCommand::FlushPt)
     }
 }
 
@@ -447,13 +449,18 @@ fn seat(slot_data: &Self::SlotData) -> &LockedSeat<Self, MAX_AS> {
     /// Activates a VM in a hardware slot.
     fn activate(&mut self, slot_idx: usize, slot_data: &Self::SlotData) -> Result {
         let as_config = slot_data.as_config()?;
-        self.as_enable(slot_idx, &as_config)
+        let hw = self.hw.clone();
+        let hw_guard = hw.access();
+        self.as_enable(hw_guard.iomem(), slot_idx, &as_config)
     }
 
     /// Evicts a VM from a hardware slot.
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
@@ -469,7 +476,9 @@ pub(super) fn start_vm_update(
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
@@ -481,7 +490,9 @@ pub(super) fn end_vm_update(&mut self, vm_as_data: &VmAsData<'drm>) -> Result {
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
@@ -493,7 +504,9 @@ pub(super) fn flush_vm(&mut self, vm_as_data: &VmAsData<'drm>) -> Result {
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
index 640371b3104d..8504d6135398 100644
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
@@ -175,14 +167,12 @@ impl<'reset> ResetHandle<'reset> {
     /// running [`Drop`], since it owns work that may borrow from `'reset`.
     pub(crate) unsafe fn new(
         pdev: &'reset platform::Device<Bound>,
-        iomem: ArcBorrow<'_, IoMem<'reset>>,
+        hw: Arc<HwGate<'reset>>,
     ) -> Result<impl PinInit<Self, Error>> {
-        let iomem = iomem.into();
-
         Ok(try_pin_init!(Self {
             // SAFETY: The caller guarantees the handle is dropped.
             controller <- unsafe {
-                kernel::new_scoped_work!("tyr::reset", Controller::new(pdev, iomem))
+                kernel::new_scoped_work!("tyr::reset", Controller::new(pdev, hw))
             },
             wq: Queue::new_ordered().build(c"tyr-reset-wq")?,
         }))
@@ -244,7 +234,10 @@ fn issue_soft_reset(dev: &Device<Bound>, io: &IoMem<'_>) -> Result {
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
2.51.2
