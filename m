Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B47F606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oL2HLxjN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662DB1120D0;
	Wed, 18 Nov 2026 23:38:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAA4A1120CD
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:37:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 985B6431E0;
 Wed, 18 Nov 2026 23:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2DF61F000C4;
 Wed, 18 Nov 2026 23:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795045076;
 bh=+LKHbm/MJJ4OH4+MNuXcJRoFW26TR+G93lGGnClo71g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=oL2HLxjNtmbhGxaNfxqhuyyNUBnyo3hp7vo/6XpmRT/gGgGMbT8QHawB+J6/KOM2W
 g5yZn6M8FgU8cYEUXyNlNXmls5aYiAmZX7fZUMJaORuvTy5eaXfBmmfiAYhUv5CjAR
 BhoFqlicXzrOQgZPJf4Ulbcz6YrxFs+i2APgSeOrmYKdDiWR8ggAN71xg58M51hd/g
 Tu46LvzF7EZvJeRebBJa5NFOJeANoZ86tmt7pSSx3Q/6nlTTp/o0fUG6ltMBLH8mp3
 in4yLZkpQq2Hj3l/7w/GHsQdU9xywrJ36d27Taw2lbyw8o1qack48O+vMYQQEpW9Il
 ZWffGabUBSKgg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net,
 ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/tyr: name resource lifetimes after their types
Date: Thu, 19 Nov 2026 00:37:02 +0100
Message-ID: <20261118233727.3147222-2-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118233727.3147222-1-dakr@kernel.org>
References: <20261118233727.3147222-1-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The firmware, buffer, VM and MMU types use 'drm for their resource
lifetimes, even though each parameter is local to its type.

Rename these parameters to reflect the respective type's scope in
preparation for converting the resource ownership to self-referential
pin-init.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/tyr/fw.rs                | 26 +++++++--------
 drivers/gpu/drm/tyr/gem.rs               |  8 ++---
 drivers/gpu/drm/tyr/mmu.rs               | 24 +++++++-------
 drivers/gpu/drm/tyr/mmu/address_space.rs | 30 ++++++++---------
 drivers/gpu/drm/tyr/vm.rs                | 42 ++++++++++++------------
 5 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index aea151ff1f93..16c6aca3d3f1 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -131,7 +131,7 @@ fn try_from_fw(value: u32) -> Result<Self> {
 }
 
 /// A parsed section of the firmware binary.
-struct Section<'drm> {
+struct Section<'sec> {
     // Raw firmware section data for reset purposes
     #[expect(dead_code)]
     data: KVec<u8>,
@@ -139,23 +139,23 @@ struct Section<'drm> {
     // Keep the BO backing this firmware section so that both the
     // GPU mapping and CPU mapping remain valid until the Section is dropped.
     #[expect(dead_code)]
-    mem: gem::KernelBo<'drm>,
+    mem: gem::KernelBo<'sec>,
 }
 
 /// Loaded firmware with sections mapped into MCU VM.
-pub(crate) struct Firmware<'drm> {
+pub(crate) struct Firmware<'fw> {
     /// Iomem need to access registers.
-    iomem: Arc<IoMem<'drm>>,
+    iomem: Arc<IoMem<'fw>>,
 
     /// MCU VM.
-    vm: Arc<Vm<'drm>>,
+    vm: Arc<Vm<'fw>>,
 
     /// List of firmware sections.
     #[expect(dead_code)]
-    sections: KVec<Section<'drm>>,
+    sections: KVec<Section<'fw>>,
 }
 
-impl<'drm> Drop for Firmware<'drm> {
+impl<'fw> Drop for Firmware<'fw> {
     fn drop(&mut self) {
         // Stop the MCU before releasing its firmware mappings and memory.
         let _ = self.stop();
@@ -165,8 +165,8 @@ fn drop(&mut self) {
     }
 }
 
-impl<'drm> Firmware<'drm> {
-    fn init_section_mem(dev: &Device, mem: &mut KernelBo<'drm>, data: &KVec<u8>) -> Result {
+impl<'fw> Firmware<'fw> {
+    fn init_section_mem(dev: &Device, mem: &mut KernelBo<'fw>, data: &KVec<u8>) -> Result {
         if data.is_empty() {
             return Ok(());
         }
@@ -213,12 +213,12 @@ fn load(
 
     /// Load firmware and map sections into MCU VM.
     pub(crate) fn new(
-        dev: &'drm Device<Bound>,
-        iomem: Arc<IoMem<'drm>>,
+        dev: &'fw Device<Bound>,
+        iomem: Arc<IoMem<'fw>>,
         ddev: &TyrDrmDevice,
-        mmu: ArcBorrow<'_, Mmu<'drm>>,
+        mmu: ArcBorrow<'_, Mmu<'fw>>,
         gpu_info: &GpuInfo,
-    ) -> Result<Firmware<'drm>> {
+    ) -> Result<Firmware<'fw>> {
         let vm = Vm::new(dev, ddev, mmu, gpu_info)?;
         vm.activate()?;
 
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 3bf3787f5c3f..0439bf96467f 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -82,16 +82,16 @@ pub(crate) enum KernelBoVaAlloc {
 /// a GEM object with automatic GPU virtual address (VA) space mapping and cleanup.
 ///
 /// When dropped, the buffer is automatically unmapped from the GPU VA space.
-pub(crate) struct KernelBo<'drm> {
+pub(crate) struct KernelBo<'bo> {
     /// The underlying GEM buffer object.
     bo: ARef<Bo>,
     /// The GPU VM this buffer is mapped into.
-    vm: Arc<Vm<'drm>>,
+    vm: Arc<Vm<'bo>>,
     /// The GPU VA range occupied by this buffer.
     va_range: Range<u64>,
 }
 
-impl<'drm> KernelBo<'drm> {
+impl<'bo> KernelBo<'bo> {
     /// Creates a new kernel-owned buffer object and maps it into GPU VA space.
     ///
     /// This function allocates a new shmem-backed GEM object and immediately maps
@@ -99,7 +99,7 @@ impl<'drm> KernelBo<'drm> {
     /// cleaned up when the [`KernelBo`] is dropped.
     pub(crate) fn new(
         ddev: &TyrDrmDevice,
-        vm: Arc<Vm<'drm>>,
+        vm: Arc<Vm<'bo>>,
         size: u64,
         va_alloc: KernelBoVaAlloc,
         flags: VmMapFlags,
diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
index 5e88c9e6a4cd..b64c5bba0e8f 100644
--- a/drivers/gpu/drm/tyr/mmu.rs
+++ b/drivers/gpu/drm/tyr/mmu.rs
@@ -43,23 +43,23 @@
 
 pub(crate) mod address_space;
 
-pub(crate) type AsSlotManager<'drm> = SlotManager<AddressSpaceManager<'drm>, MAX_AS>;
+pub(crate) type AsSlotManager<'as_mgr> = SlotManager<AddressSpaceManager<'as_mgr>, MAX_AS>;
 
 /// Locked wrapper for carrying out virtual memory (VM) operations on the MMU.
 #[pin_data]
-pub(crate) struct Mmu<'drm> {
+pub(crate) struct Mmu<'mmu> {
     /// Slot Manager instance used to allocate hardware slots and write to MMU registers.
     #[pin]
-    pub(crate) as_manager: Mutex<AsSlotManager<'drm>>,
+    pub(crate) as_manager: Mutex<AsSlotManager<'mmu>>,
 }
 
-impl<'drm> Mmu<'drm> {
+impl<'mmu> Mmu<'mmu> {
     /// Create an MMU component for this device.
     pub(crate) fn new(
-        dev: &'drm Device<Bound>,
-        iomem: ArcBorrow<'_, IoMem<'drm>>,
+        dev: &'mmu Device<Bound>,
+        iomem: ArcBorrow<'_, IoMem<'mmu>>,
         gpu_info: &GpuInfo,
-    ) -> Result<Arc<Mmu<'drm>>> {
+    ) -> Result<Arc<Mmu<'mmu>>> {
         let present = AS_PRESENT::from_raw(gpu_info.as_present).present().get();
         let slot_count = present.count_ones().try_into()?;
 
@@ -81,17 +81,17 @@ pub(crate) fn new(
 
     /// Assign a VM to an AS slot, provide a translation table,
     /// and update the MMU to make the VM resident.
-    pub(crate) fn activate_vm(&self, vm_as_data: ArcBorrow<'_, VmAsData<'drm>>) -> Result {
+    pub(crate) fn activate_vm(&self, vm_as_data: ArcBorrow<'_, VmAsData<'mmu>>) -> Result {
         self.as_manager.lock().activate_vm(vm_as_data)
     }
 
     /// Evict a VM from its AS slot and flush the MMU.
-    pub(crate) fn deactivate_vm(&self, vm_as_data: &VmAsData<'drm>) -> Result {
+    pub(crate) fn deactivate_vm(&self, vm_as_data: &VmAsData<'mmu>) -> Result {
         self.as_manager.lock().deactivate_vm(vm_as_data)
     }
 
     /// Flush MMU translation caches after a VM update.
-    pub(crate) fn flush_vm(&self, vm_as_data: &VmAsData<'drm>) -> Result {
+    pub(crate) fn flush_vm(&self, vm_as_data: &VmAsData<'mmu>) -> Result {
         self.as_manager.lock().flush_vm(vm_as_data)
     }
 
@@ -103,7 +103,7 @@ pub(crate) fn flush_vm(&self, vm_as_data: &VmAsData<'drm>) -> Result {
     /// If the VM is not resident, this is a NOP.
     pub(crate) fn start_vm_update(
         &self,
-        vm_as_data: &VmAsData<'drm>,
+        vm_as_data: &VmAsData<'mmu>,
         region: &Range<u64>,
     ) -> Result {
         self.as_manager.lock().start_vm_update(vm_as_data, region)
@@ -114,7 +114,7 @@ pub(crate) fn start_vm_update(
     /// If the VM is resident, this will let GPU accesses on the updated
     /// range go through, in case any of them were blocked.
     /// If the VM is not resident, this is a NOP.
-    pub(crate) fn end_vm_update(&self, vm_as_data: &VmAsData<'drm>) -> Result {
+    pub(crate) fn end_vm_update(&self, vm_as_data: &VmAsData<'mmu>) -> Result {
         self.as_manager.lock().end_vm_update(vm_as_data)
     }
 }
diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index 76e3d2df6afd..4cb582f98852 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -147,27 +147,27 @@ fn as_config(&self) -> Result<AddressSpaceConfig> {
 
 /// Coordinates all hardware-level address space operations through MMIO register
 /// operations including enabling, disabling, flushing, and updating address spaces.
-pub(crate) struct AddressSpaceManager<'drm> {
+pub(crate) struct AddressSpaceManager<'as_mgr> {
     /// Parent device used for logging.
-    dev: &'drm Device<Bound>,
+    dev: &'as_mgr Device<Bound>,
 
     /// Memory-mapped I/O region for GPU register access.
-    iomem: Arc<IoMem<'drm>>,
+    iomem: Arc<IoMem<'as_mgr>>,
 
     /// Bitmask of present address space slots from GPU_AS_PRESENT register.
     as_present: u32,
 }
 
-impl<'drm> AddressSpaceManager<'drm> {
+impl<'as_mgr> AddressSpaceManager<'as_mgr> {
     /// Creates a new address space manager.
     ///
     /// Initializes the manager with references to the platform device and
     /// I/O memory region, along with the bitmask of available AS slots.
     pub(super) fn new(
-        dev: &'drm Device<Bound>,
-        iomem: Arc<IoMem<'drm>>,
+        dev: &'as_mgr Device<Bound>,
+        iomem: Arc<IoMem<'as_mgr>>,
         as_present: u32,
-    ) -> Result<AddressSpaceManager<'drm>> {
+    ) -> Result<AddressSpaceManager<'as_mgr>> {
         if as_present.trailing_ones() != as_present.count_ones() {
             dev_err!(
                 dev,
@@ -436,9 +436,9 @@ fn as_flush(&mut self, as_nr: usize) -> Result {
     }
 }
 
-impl<'drm> SlotOperations<MAX_AS> for AddressSpaceManager<'drm> {
+impl<'as_mgr> SlotOperations<MAX_AS> for AddressSpaceManager<'as_mgr> {
     /// VM address space data associated with a hardware slot.
-    type SlotData = Arc<VmAsData<'drm>>;
+    type SlotData = Arc<VmAsData<'as_mgr>>;
 
     fn seat(slot_data: &Self::SlotData) -> &LockedSeat<Self, MAX_AS> {
         &slot_data.as_seat
@@ -458,11 +458,11 @@ fn evict(&mut self, slot_idx: usize, _slot_data: &Self::SlotData) -> Result {
     }
 }
 
-impl<'drm> AsSlotManager<'drm> {
+impl<'as_mgr> AsSlotManager<'as_mgr> {
     /// Locks a region for translation table updates if the VM has an active slot.
     pub(super) fn start_vm_update(
         &mut self,
-        vm_as_data: &VmAsData<'drm>,
+        vm_as_data: &VmAsData<'as_mgr>,
         region: &Range<u64>,
     ) -> Result {
         let seat = vm_as_data.as_seat.access(self);
@@ -476,7 +476,7 @@ pub(super) fn start_vm_update(
     }
 
     /// Completes translation table updates and unlocks the region.
-    pub(super) fn end_vm_update(&mut self, vm_as_data: &VmAsData<'drm>) -> Result {
+    pub(super) fn end_vm_update(&mut self, vm_as_data: &VmAsData<'as_mgr>) -> Result {
         let seat = vm_as_data.as_seat.access(self);
         match seat.slot() {
             Some(slot) => {
@@ -488,7 +488,7 @@ pub(super) fn end_vm_update(&mut self, vm_as_data: &VmAsData<'drm>) -> Result {
     }
 
     /// Flushes the translation table cache if the VM has an active slot.
-    pub(super) fn flush_vm(&mut self, vm_as_data: &VmAsData<'drm>) -> Result {
+    pub(super) fn flush_vm(&mut self, vm_as_data: &VmAsData<'as_mgr>) -> Result {
         let seat = vm_as_data.as_seat.access(self);
         match seat.slot() {
             Some(slot) => {
@@ -500,12 +500,12 @@ pub(super) fn flush_vm(&mut self, vm_as_data: &VmAsData<'drm>) -> Result {
     }
 
     /// Activates a VM by assigning it to a hardware slot.
-    pub(super) fn activate_vm(&mut self, vm_as_data: ArcBorrow<'_, VmAsData<'drm>>) -> Result {
+    pub(super) fn activate_vm(&mut self, vm_as_data: ArcBorrow<'_, VmAsData<'as_mgr>>) -> Result {
         self.activate(vm_as_data.into())
     }
 
     /// Deactivates a VM by evicting it from its hardware slot.
-    pub(super) fn deactivate_vm(&mut self, vm_as_data: &VmAsData<'drm>) -> Result {
+    pub(super) fn deactivate_vm(&mut self, vm_as_data: &VmAsData<'as_mgr>) -> Result {
         self.evict(&vm_as_data.as_seat)
     }
 }
diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 1dd11b2b1253..2557d6517ca3 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -316,34 +316,34 @@ pub(crate) struct GpuVmData<'drm> {
 ///
 /// Each VM can be mapped into a hardware address space slot.
 #[pin_data]
-pub(crate) struct Vm<'drm> {
+pub(crate) struct Vm<'vm> {
     /// Data referenced by an AS when the VM is active
-    as_data: Arc<VmAsData<'drm>>,
+    as_data: Arc<VmAsData<'vm>>,
     /// MMU manager.
-    mmu: Arc<Mmu<'drm>>,
+    mmu: Arc<Mmu<'vm>>,
     /// Parent device used for DMA mapping and page-table operations.
-    dev: &'drm Device<Bound>,
+    dev: &'vm Device<Bound>,
     /// DRM GPUVM core for managing virtual address space.
     #[pin]
-    gpuvm_unique: Mutex<UniqueRefGpuVm<GpuVmData<'drm>>>,
+    gpuvm_unique: Mutex<UniqueRefGpuVm<GpuVmData<'vm>>>,
     /// Non-core part of the GPUVM. Can be used for stuff that doesn't modify the
     /// internal mapping tree, like GpuVm::obtain()
-    gpuvm: ARef<GpuVm<GpuVmData<'drm>>>,
+    gpuvm: ARef<GpuVm<GpuVmData<'vm>>>,
     /// VA range for this VM.
     va_range: Range<u64>,
 }
 
-impl<'drm> Vm<'drm> {
+impl<'vm> Vm<'vm> {
     /// Creates a new GPU virtual address space.
     ///
     /// The VM is initialized with a page table configured according to the GPU's
     /// address translation capabilities and registered with the GPUVM framework.
     pub(crate) fn new(
-        dev: &'drm Device<Bound>,
+        dev: &'vm Device<Bound>,
         ddev: &TyrDrmDevice,
-        mmu: ArcBorrow<'_, Mmu<'drm>>,
+        mmu: ArcBorrow<'_, Mmu<'vm>>,
         gpu_info: &GpuInfo,
-    ) -> Result<Arc<Vm<'drm>>> {
+    ) -> Result<Arc<Vm<'vm>>> {
         let mmu_features = MMU_FEATURES::from_raw(gpu_info.mmu_features);
         let va_bits = mmu_features.va_bits().get();
         let pa_bits = mmu_features.pa_bits().get();
@@ -362,7 +362,7 @@ pub(crate) fn new(
             &*dummy_obj,
             range.clone(),
             reserve_range,
-            GpuVmData::<'drm> {
+            GpuVmData::<'vm> {
                 _phantom: PhantomData::<&()>,
             },
         )
@@ -389,7 +389,7 @@ pub(crate) fn new(
     }
 
     /// Returns the parent device used by this VM for DMA mapping and page-table operations.
-    pub(crate) fn dev(&self) -> &'drm Device<Bound> {
+    pub(crate) fn dev(&self) -> &'vm Device<Bound> {
         self.dev
     }
 
@@ -426,9 +426,9 @@ pub(crate) fn kill(&self) {
     /// GPUVM framework and the hardware page table.
     fn exec_op<'a>(
         &self,
-        gpuvm_unique: &mut UniqueRefGpuVm<GpuVmData<'drm>>,
-        req: VmOpRequest<'drm>,
-        resources: &'a mut VmOpResources<'drm>,
+        gpuvm_unique: &mut UniqueRefGpuVm<GpuVmData<'vm>>,
+        req: VmOpRequest<'vm>,
+        resources: &'a mut VmOpResources<'vm>,
     ) -> Result {
         let pt = &self.as_data.page_table;
 
@@ -524,9 +524,9 @@ pub(crate) fn map_bo_range(
         };
         let mut resources = VmOpResources {
             preallocated_gpuvas: [
-                Some(GpuVaAlloc::<GpuVmData<'drm>>::new(GFP_KERNEL)?),
-                Some(GpuVaAlloc::<GpuVmData<'drm>>::new(GFP_KERNEL)?),
-                Some(GpuVaAlloc::<GpuVmData<'drm>>::new(GFP_KERNEL)?),
+                Some(GpuVaAlloc::<GpuVmData<'vm>>::new(GFP_KERNEL)?),
+                Some(GpuVaAlloc::<GpuVmData<'vm>>::new(GFP_KERNEL)?),
+                Some(GpuVaAlloc::<GpuVmData<'vm>>::new(GFP_KERNEL)?),
             ],
         };
         let result = {
@@ -577,9 +577,9 @@ pub(crate) fn unmap_range(&self, va: u64, size: u64) -> Result {
                 [None, None, None]
             } else {
                 [
-                    Some(GpuVaAlloc::<GpuVmData<'drm>>::new(GFP_KERNEL)?),
-                    Some(GpuVaAlloc::<GpuVmData<'drm>>::new(GFP_KERNEL)?),
-                    Some(GpuVaAlloc::<GpuVmData<'drm>>::new(GFP_KERNEL)?),
+                    Some(GpuVaAlloc::<GpuVmData<'vm>>::new(GFP_KERNEL)?),
+                    Some(GpuVaAlloc::<GpuVmData<'vm>>::new(GFP_KERNEL)?),
+                    Some(GpuVaAlloc::<GpuVmData<'vm>>::new(GFP_KERNEL)?),
                 ]
             },
         };
-- 
2.56.1

