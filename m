Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5060A2605
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhIgaoUg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D43E1120CF;
	Wed, 18 Nov 2026 23:38:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC9A1120CD
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:38:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E5E904243A;
 Wed, 18 Nov 2026 23:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BF61F000C4;
 Wed, 18 Nov 2026 23:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795045084;
 bh=ib5I5MU9U2dx9AKOKxzo3p5UBRpPpSLOp77gYWySKQQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FhIgaoUgmfy0i8qseK8P9v0BlAgMeYl3Rn69fhAbxgx/i2w7AR4qkbgUk8w4J8mao
 +ubUrCjpDe/wgC0Qjhwuv3yDDD8g38uC7lGPOejDyJJ1nUsH/zBYs2l9FnNl1ZXK6k
 rTT41oIvW4kAbtNJ2z6oV0JLUljd7/Be02trfyRbU74O6xgo0mKlYS/hBNDKdBrQEP
 s/iz2qz5FzCOx1C0s8W4TgNeIoRSJ4fPN097yqG91vt2RFXdgScE/1xgmmubUmzpMc
 0j3Ac9VlWhu7Ro9KAXeBmIZUa5dv8ZCAIg/rrdzYLYD/QsdGwPkwFEc/+FLGVXawMg
 TjIIQGz+a3omg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, lossin@kernel.org, gary@garyguo.net,
 ojeda@kernel.org, boqun@kernel.org, bjorn3_gh@protonmail.com,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] drm/tyr: use pin-init self-referential support
Date: Thu, 19 Nov 2026 00:37:04 +0100
Message-ID: <20261118233727.3147222-4-dakr@kernel.org>
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

Now that pin-init supports self-referential structs, Arc is no longer
needed just to share resources whose lifetimes are bounded by their
owners.

Use pin-init's self-referential support to share the MMIO mapping, MMU
and firmware VM through borrows instead of Arc, avoiding their separate
allocations and reference counts.

Hide the invariant resource lifetime shared by the VM and its sections
behind an existential lifetime that outlives 'fw, so Firmware only needs
a single lifetime parameter.

Cc: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/tyr/driver.rs            |  38 +++---
 drivers/gpu/drm/tyr/fw.rs                | 152 ++++++++++++-----------
 drivers/gpu/drm/tyr/gem.rs               |  15 +--
 drivers/gpu/drm/tyr/mmu.rs               |  36 +++---
 drivers/gpu/drm/tyr/mmu/address_space.rs |  14 +--
 drivers/gpu/drm/tyr/vm.rs                | 119 +++++++++---------
 6 files changed, 187 insertions(+), 187 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index c2b99d67369f..8deb60f507da 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -29,7 +29,7 @@
     regulator::Regulator,
     sizes::SZ_2M,
     sync::{
-        Arc,
+        aref::ARef,
         Mutex, //
     },
     time, //
@@ -71,7 +71,14 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
     pub(crate) pdev: &'drm platform::Device<Bound>,
 
     /// Firmware sections.
-    pub(crate) fw: Firmware<'drm>,
+    #[pin]
+    #[uses('mmu: invariant)]
+    pub(crate) fw: Firmware<'mmu>,
+
+    /// MMU shared by the firmware and its buffer objects.
+    #[pin]
+    #[uses('iomem: invariant)]
+    mmu: Mmu<'iomem>,
 
     #[pin]
     clks: Mutex<Clocks>,
@@ -80,7 +87,7 @@ pub(crate) struct TyrDrmRegistrationData<'drm> {
     regulators: Mutex<Regulators>,
 
     /// GPU MMIO register mapping.
-    pub(crate) iomem: Arc<IoMem<'drm>>,
+    pub(crate) iomem: IoMem<'drm>,
 
     /// GPU information read from hardware during probe.
     pub(crate) gpu_info: GpuInfo,
@@ -132,7 +139,7 @@ fn probe<'bound>(
 
             let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
 
-            let iomem = Arc::new(request.iomap_sized::<SZ_2M>()?, GFP_KERNEL)?;
+            let iomem = request.iomap_sized::<SZ_2M>()?;
 
             issue_soft_reset(pdev.as_ref(), &iomem)?;
             gpu::l2_power_on(pdev.as_ref(), &iomem)?;
@@ -149,18 +156,7 @@ fn probe<'bound>(
             unsafe { pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_bits)?)? };
 
             let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
-
-            let mmu = Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &gpu_info)?;
-
-            let firmware = Firmware::new(
-                pdev.as_ref(),
-                iomem.clone(),
-                &unreg_dev,
-                mmu.as_arc_borrow(),
-                &gpu_info,
-            )?;
-
-            firmware.boot()?;
+            let ddev = ARef::from(&*unreg_dev);
 
             Ok(try_pin_init!(TyrPlatformDriverData {
                 // SAFETY: `_reg` is stored in `TyrPlatformDriverData` and dropped when the
@@ -168,9 +164,13 @@ fn probe<'bound>(
                 _reg <- unsafe { drm::Registration::new(
                     pdev.as_ref(),
                     unreg_dev,
-                    pin_init!(TyrDrmRegistrationData {
+                    try_pin_init!(TyrDrmRegistrationData {
+                        iomem,
+                        gpu_info,
+                        mmu <- Mmu::new(pdev.as_ref(), iomem, gpu_info),
+                        fw <- Firmware::new(pdev.as_ref(), iomem, &ddev, mmu.get_ref(), gpu_info),
+                        _: { fw.boot()?; },
                         pdev,
-                        fw: firmware,
                         clks <- new_mutex!(Clocks {
                             core: core_clk,
                             stacks: stacks_clk,
@@ -180,8 +180,6 @@ fn probe<'bound>(
                             _mali: mali_regulator,
                             _sram: sram_regulator,
                         }),
-                        iomem,
-                        gpu_info,
                     }),
                 )},
                 _: { dev_dbg!(pdev, "Tyr initialized correctly.") },
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 16c6aca3d3f1..bd377875778b 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -29,10 +29,6 @@
     num::Bounded,
     prelude::*,
     str::CString,
-    sync::{
-        Arc,
-        ArcBorrow, //
-    },
     time, //
 };
 
@@ -131,7 +127,7 @@ fn try_from_fw(value: u32) -> Result<Self> {
 }
 
 /// A parsed section of the firmware binary.
-struct Section<'sec> {
+struct Section<'sec, 'res> {
     // Raw firmware section data for reset purposes
     #[expect(dead_code)]
     data: KVec<u8>,
@@ -139,34 +135,41 @@ struct Section<'sec> {
     // Keep the BO backing this firmware section so that both the
     // GPU mapping and CPU mapping remain valid until the Section is dropped.
     #[expect(dead_code)]
-    mem: gem::KernelBo<'sec>,
+    mem: gem::KernelBo<'sec, 'res>,
 }
 
 /// Loaded firmware with sections mapped into MCU VM.
-pub(crate) struct Firmware<'fw> {
+#[pin_data(PinnedDrop)]
+pub(crate) struct Firmware<'fw>
+where
+    exists<'res>: 'fw,
+{
     /// Iomem need to access registers.
-    iomem: Arc<IoMem<'fw>>,
-
-    /// MCU VM.
-    vm: Arc<Vm<'fw>>,
+    iomem: &'fw IoMem<'fw>,
 
     /// List of firmware sections.
-    #[expect(dead_code)]
-    sections: KVec<Section<'fw>>,
+    #[uses('res: invariant)]
+    sections: KVec<Section<'vm, 'res>>,
+
+    /// MCU VM.
+    #[pin]
+    #[uses('res: invariant)]
+    vm: Vm<'fw, 'res>,
 }
 
-impl<'fw> Drop for Firmware<'fw> {
-    fn drop(&mut self) {
+#[pinned_drop]
+impl PinnedDrop for Firmware<'_> {
+    fn drop(self: Pin<&mut Self>) {
         // Stop the MCU before releasing its firmware mappings and memory.
         let _ = self.stop();
 
         // AS slots retain a VM ref, we need to kill the circular ref manually.
-        self.vm.kill();
+        self.with_vm(|vm| vm.kill());
     }
 }
 
 impl<'fw> Firmware<'fw> {
-    fn init_section_mem(dev: &Device, mem: &mut KernelBo<'fw>, data: &KVec<u8>) -> Result {
+    fn init_section_mem(dev: &Device, mem: &mut KernelBo<'_, '_>, data: &KVec<u8>) -> Result {
         if data.is_empty() {
             return Ok(());
         }
@@ -212,62 +215,65 @@ fn load(
     }
 
     /// Load firmware and map sections into MCU VM.
-    pub(crate) fn new(
-        dev: &'fw Device<Bound>,
-        iomem: Arc<IoMem<'fw>>,
-        ddev: &TyrDrmDevice,
-        mmu: ArcBorrow<'_, Mmu<'fw>>,
-        gpu_info: &GpuInfo,
-    ) -> Result<Firmware<'fw>> {
-        let vm = Vm::new(dev, ddev, mmu, gpu_info)?;
-        vm.activate()?;
-
-        let result = (|| {
-            let (fw, parsed_sections) = Self::load(dev, ddev, gpu_info)?;
-            let mut sections = KVec::new();
-            for parsed in parsed_sections {
-                let size = u64::from(parsed.va.end.checked_sub(parsed.va.start).ok_or(EINVAL)?);
-
-                let va = u64::from(parsed.va.start);
-
-                let mut mem = KernelBo::new(
-                    ddev,
-                    vm.clone(),
-                    size,
-                    KernelBoVaAlloc::Explicit(va),
-                    parsed.vm_map_flags,
-                )?;
-
-                let section_start = parsed.data_range.start as usize;
-                let section_end = parsed.data_range.end as usize;
-                let mut data = KVec::new();
-
-                // Ensure that the firmware slice is not out of bounds.
-                let fw_data = fw.data();
-                let bytes = fw_data.get(section_start..section_end).ok_or(EINVAL)?;
-                data.extend_from_slice(bytes, GFP_KERNEL)?;
-
-                Self::init_section_mem(dev, &mut mem, &data)?;
-
-                sections.push(Section { data, mem }, GFP_KERNEL)?;
-            }
-
-            Ok(Firmware {
-                iomem,
-                vm: vm.clone(),
-                sections,
-            })
-        })();
-
-        if result.is_err() {
-            vm.kill();
-        }
-
-        result
+    pub(crate) fn new<'a, 'res>(
+        dev: &'res Device<Bound>,
+        iomem: &'fw IoMem<'fw>,
+        ddev: &'a TyrDrmDevice,
+        mmu: &'fw Mmu<'res>,
+        gpu_info: &'a GpuInfo,
+    ) -> impl PinInit<Self, Error> + use<'a, 'fw, 'res> {
+        try_pin_init!(Self {
+            iomem,
+            vm <- Vm::new(dev, ddev, mmu, gpu_info),
+            sections: {
+                let vm = vm.get_ref();
+                vm.activate()?;
+
+                let result: Result<_> = (|| {
+                    let (fw, parsed_sections) = Self::load(dev, ddev, gpu_info)?;
+                    let mut sections = KVec::new();
+                    for parsed in parsed_sections {
+                        let size =
+                            u64::from(parsed.va.end.checked_sub(parsed.va.start).ok_or(EINVAL)?);
+
+                        let va = u64::from(parsed.va.start);
+
+                        let mut mem = KernelBo::new(
+                            ddev,
+                            vm,
+                            size,
+                            KernelBoVaAlloc::Explicit(va),
+                            parsed.vm_map_flags,
+                        )?;
+
+                        let section_start = parsed.data_range.start as usize;
+                        let section_end = parsed.data_range.end as usize;
+                        let mut data = KVec::new();
+
+                        // Ensure that the firmware slice is not out of bounds.
+                        let fw_data = fw.data();
+                        let bytes = fw_data.get(section_start..section_end).ok_or(EINVAL)?;
+                        data.extend_from_slice(bytes, GFP_KERNEL)?;
+
+                        Self::init_section_mem(dev, &mut mem, &data)?;
+
+                        sections.push(Section { data, mem }, GFP_KERNEL)?;
+                    }
+
+                    Ok(sections)
+                })();
+
+                if result.is_err() {
+                    vm.kill();
+                }
+
+                result?
+            },
+        })
     }
 
     pub(crate) fn boot(&self) -> Result {
-        let io = &self.iomem;
+        let io = self.iomem;
 
         // Discard any stale global interrupt.
         io.write_reg(JOB_IRQ_CLEAR::zeroed().with_glb(true));
@@ -284,7 +290,7 @@ pub(crate) fn boot(&self) -> Result {
         ) {
             let status = io.read(MCU_STATUS);
             dev_err!(
-                self.vm.dev(),
+                self.with_vm(|vm| vm.dev()),
                 "MCU failed to boot, status: {:?}",
                 status.value()
             );
@@ -297,7 +303,7 @@ pub(crate) fn boot(&self) -> Result {
     }
 
     fn stop(&self) -> Result {
-        let io = &self.iomem;
+        let io = self.iomem;
         io.write_reg(MCU_CONTROL::zeroed().with_req(McuControlMode::Disable));
 
         if let Err(e) = poll::read_poll_timeout(
@@ -308,7 +314,7 @@ fn stop(&self) -> Result {
         ) {
             let status = io.read(MCU_STATUS);
             dev_err!(
-                self.vm.dev(),
+                self.with_vm(|vm| vm.dev()),
                 "MCU failed to stop, status: {:?}",
                 status.value()
             );
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 0439bf96467f..05965a9135b7 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -12,10 +12,7 @@
         shmem, //
     },
     prelude::*,
-    sync::{
-        aref::ARef,
-        Arc, //
-    }, //
+    sync::aref::ARef, //
 };
 
 use crate::{
@@ -82,16 +79,16 @@ pub(crate) enum KernelBoVaAlloc {
 /// a GEM object with automatic GPU virtual address (VA) space mapping and cleanup.
 ///
 /// When dropped, the buffer is automatically unmapped from the GPU VA space.
-pub(crate) struct KernelBo<'bo> {
+pub(crate) struct KernelBo<'bo, 'res> {
     /// The underlying GEM buffer object.
     bo: ARef<Bo>,
     /// The GPU VM this buffer is mapped into.
-    vm: Arc<Vm<'bo>>,
+    vm: &'bo Vm<'bo, 'res>,
     /// The GPU VA range occupied by this buffer.
     va_range: Range<u64>,
 }
 
-impl<'bo> KernelBo<'bo> {
+impl<'bo, 'res> KernelBo<'bo, 'res> {
     /// Creates a new kernel-owned buffer object and maps it into GPU VA space.
     ///
     /// This function allocates a new shmem-backed GEM object and immediately maps
@@ -99,7 +96,7 @@ impl<'bo> KernelBo<'bo> {
     /// cleaned up when the [`KernelBo`] is dropped.
     pub(crate) fn new(
         ddev: &TyrDrmDevice,
-        vm: Arc<Vm<'bo>>,
+        vm: &'bo Vm<'bo, 'res>,
         size: u64,
         va_alloc: KernelBoVaAlloc,
         flags: VmMapFlags,
@@ -138,7 +135,7 @@ pub(crate) fn bo(&self) -> &Bo {
     }
 }
 
-impl Drop for KernelBo<'_> {
+impl Drop for KernelBo<'_, '_> {
     fn drop(&mut self) {
         let va = self.va_range.start;
         let size = self.va_range.end - self.va_range.start;
diff --git a/drivers/gpu/drm/tyr/mmu.rs b/drivers/gpu/drm/tyr/mmu.rs
index b64c5bba0e8f..70662c953d7e 100644
--- a/drivers/gpu/drm/tyr/mmu.rs
+++ b/drivers/gpu/drm/tyr/mmu.rs
@@ -21,7 +21,6 @@
     new_mutex,
     prelude::*,
     sync::{
-        Arc,
         ArcBorrow,
         Mutex, //
     }, //
@@ -57,26 +56,27 @@ impl<'mmu> Mmu<'mmu> {
     /// Create an MMU component for this device.
     pub(crate) fn new(
         dev: &'mmu Device<Bound>,
-        iomem: ArcBorrow<'_, IoMem<'mmu>>,
+        iomem: &'mmu IoMem<'mmu>,
         gpu_info: &GpuInfo,
-    ) -> Result<Arc<Mmu<'mmu>>> {
+    ) -> impl PinInit<Self, Error> + 'mmu {
         let present = AS_PRESENT::from_raw(gpu_info.as_present).present().get();
-        let slot_count = present.count_ones().try_into()?;
+        try_pin_init!(Self {
+            as_manager <- {
+                let slot_count = present.count_ones().try_into()?;
 
-        let address_space_manager = AddressSpaceManager::new(dev, iomem.into(), present)?;
-        let as_slot_manager =
-            SlotManager::new(address_space_manager, slot_count).inspect_err(|e| {
-                dev_err!(
-                    dev,
-                    "Failed to initialize MMU slot manager with {} slots: {:?}",
-                    slot_count,
-                    e
-                );
-            })?;
-        let mmu_init = try_pin_init!(Self{
-            as_manager <- new_mutex!(as_slot_manager),
-        });
-        Arc::pin_init(mmu_init, GFP_KERNEL)
+                let address_space_manager = AddressSpaceManager::new(dev, iomem, present)?;
+                let as_slot_manager =
+                    SlotManager::new(address_space_manager, slot_count).inspect_err(|e| {
+                        dev_err!(
+                            dev,
+                            "Failed to initialize MMU slot manager with {} slots: {:?}",
+                            slot_count,
+                            e
+                        );
+                    })?;
+                new_mutex!(as_slot_manager)
+            },
+        })
     }
 
     /// Assign a VM to an AS slot, provide a translation table,
diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index 4cb582f98852..0330cf514269 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -152,7 +152,7 @@ pub(crate) struct AddressSpaceManager<'as_mgr> {
     dev: &'as_mgr Device<Bound>,
 
     /// Memory-mapped I/O region for GPU register access.
-    iomem: Arc<IoMem<'as_mgr>>,
+    iomem: &'as_mgr IoMem<'as_mgr>,
 
     /// Bitmask of present address space slots from GPU_AS_PRESENT register.
     as_present: u32,
@@ -165,7 +165,7 @@ impl<'as_mgr> AddressSpaceManager<'as_mgr> {
     /// I/O memory region, along with the bitmask of available AS slots.
     pub(super) fn new(
         dev: &'as_mgr Device<Bound>,
-        iomem: Arc<IoMem<'as_mgr>>,
+        iomem: &'as_mgr IoMem<'as_mgr>,
         as_present: u32,
     ) -> Result<AddressSpaceManager<'as_mgr>> {
         if as_present.trailing_ones() != as_present.count_ones() {
@@ -216,7 +216,7 @@ fn validate_as_slot(&self, as_nr: usize) -> Result {
     ///
     /// Returns an error if polling times out after 10ms or if register access fails.
     fn as_wait_ready(&self, as_nr: usize) -> Result {
-        let io = &*self.iomem;
+        let io = self.iomem;
         let op = || {
             let status_reg = STATUS::try_at(as_nr).ok_or(EINVAL)?;
             Ok(io.read(status_reg))
@@ -232,7 +232,7 @@ fn as_wait_ready(&self, as_nr: usize) -> Result {
     /// Returns an error if waiting for ready times out or if register write fails.
     fn as_send_cmd(&mut self, as_nr: usize, cmd: MmuCommand) -> Result {
         self.as_wait_ready(as_nr)?;
-        let io = &*self.iomem;
+        let io = self.iomem;
         let command_reg = COMMAND::try_at(as_nr).ok_or(EINVAL)?;
         io.write(command_reg, COMMAND::zeroed().with_command(cmd));
         Ok(())
@@ -253,7 +253,7 @@ fn as_send_cmd_and_wait(&mut self, as_nr: usize, cmd: MmuCommand) -> Result {
     fn as_enable(&mut self, as_nr: usize, as_config: &AddressSpaceConfig) -> Result {
         self.validate_as_slot(as_nr)?;
 
-        let io = &*self.iomem;
+        let io = self.iomem;
 
         let transtab = as_config.transtab;
         io.write(
@@ -299,7 +299,7 @@ fn as_disable(&mut self, as_nr: usize) -> Result {
         // Flush AS before disabling
         self.as_send_cmd_and_wait(as_nr, MmuCommand::FlushMem)?;
 
-        let io = &*self.iomem;
+        let io = self.iomem;
 
         io.write(
             TRANSTAB_LO::try_at(as_nr).ok_or(EINVAL)?,
@@ -394,7 +394,7 @@ fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> Result {
         // because log2(32 KiB) = 15.
         let lockaddr_size = lock_region_log2 - 1;
 
-        let io = &*self.iomem;
+        let io = self.iomem;
 
         // The LOCKADDR base field stores address bits 63:12, so remove the low 12 bits
         // before passing this value to the register macro helper.
diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 2557d6517ca3..4f3dbeec37a2 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -50,7 +50,6 @@
     sync::{
         aref::ARef,
         Arc,
-        ArcBorrow,
         Mutex, //
     },
     uapi, //
@@ -316,80 +315,80 @@ pub(crate) struct GpuVmData<'drm> {
 ///
 /// Each VM can be mapped into a hardware address space slot.
 #[pin_data]
-pub(crate) struct Vm<'vm> {
+pub(crate) struct Vm<'vm, 'res> {
     /// Data referenced by an AS when the VM is active
-    as_data: Arc<VmAsData<'vm>>,
+    as_data: Arc<VmAsData<'res>>,
     /// MMU manager.
-    mmu: Arc<Mmu<'vm>>,
+    mmu: &'vm Mmu<'res>,
     /// Parent device used for DMA mapping and page-table operations.
-    dev: &'vm Device<Bound>,
+    dev: &'res Device<Bound>,
     /// DRM GPUVM core for managing virtual address space.
     #[pin]
-    gpuvm_unique: Mutex<UniqueRefGpuVm<GpuVmData<'vm>>>,
+    gpuvm_unique: Mutex<UniqueRefGpuVm<GpuVmData<'res>>>,
     /// Non-core part of the GPUVM. Can be used for stuff that doesn't modify the
     /// internal mapping tree, like GpuVm::obtain()
-    gpuvm: ARef<GpuVm<GpuVmData<'vm>>>,
+    gpuvm: ARef<GpuVm<GpuVmData<'res>>>,
     /// VA range for this VM.
     va_range: Range<u64>,
 }
 
-impl<'vm> Vm<'vm> {
+impl<'vm, 'res> Vm<'vm, 'res> {
     /// Creates a new GPU virtual address space.
     ///
     /// The VM is initialized with a page table configured according to the GPU's
     /// address translation capabilities and registered with the GPUVM framework.
-    pub(crate) fn new(
-        dev: &'vm Device<Bound>,
-        ddev: &TyrDrmDevice,
-        mmu: ArcBorrow<'_, Mmu<'vm>>,
-        gpu_info: &GpuInfo,
-    ) -> Result<Arc<Vm<'vm>>> {
-        let mmu_features = MMU_FEATURES::from_raw(gpu_info.mmu_features);
-        let va_bits = mmu_features.va_bits().get();
-        let pa_bits = mmu_features.pa_bits().get();
-
-        let range = 0..(1u64 << va_bits);
-        let reserve_range = 0..0u64;
-
-        // dummy_obj is used to initialize the GPUVM tree.
-        let dummy_obj = gem::new_dummy_object(ddev).inspect_err(|e| {
-            dev_err!(dev, "Failed to create dummy GEM object: {:?}", e);
-        })?;
+    pub(crate) fn new<'a>(
+        dev: &'res Device<Bound>,
+        ddev: &'a TyrDrmDevice,
+        mmu: &'vm Mmu<'res>,
+        gpu_info: &'a GpuInfo,
+    ) -> impl PinInit<Self, Error> + 'a
+    where
+        'vm: 'a,
+    {
+        pin_init::pin_init_scope(move || {
+            let mmu_features = MMU_FEATURES::from_raw(gpu_info.mmu_features);
+            let va_bits = mmu_features.va_bits().get();
+            let pa_bits = mmu_features.pa_bits().get();
+
+            let range = 0..(1u64 << va_bits);
+            let reserve_range = 0..0u64;
+
+            // dummy_obj is used to initialize the GPUVM tree.
+            let dummy_obj = gem::new_dummy_object(ddev).inspect_err(|e| {
+                dev_err!(dev, "Failed to create dummy GEM object: {:?}", e);
+            })?;
 
-        let gpuvm_unique = GpuVm::new::<Error, _>(
-            c"Tyr::GpuVm",
-            ddev,
-            &*dummy_obj,
-            range.clone(),
-            reserve_range,
-            GpuVmData::<'vm> {
-                _phantom: PhantomData::<&()>,
-            },
-        )
-        .inspect_err(|e| {
-            dev_err!(dev, "Failed to create GpuVm: {:?}", e);
-        })?;
-        let gpuvm = ARef::from(&*gpuvm_unique);
+            let gpuvm_unique = GpuVm::new::<Error, _>(
+                c"Tyr::GpuVm",
+                ddev,
+                &*dummy_obj,
+                range.clone(),
+                reserve_range,
+                GpuVmData::<'res> {
+                    _phantom: PhantomData::<&()>,
+                },
+            )
+            .inspect_err(|e| {
+                dev_err!(dev, "Failed to create GpuVm: {:?}", e);
+            })?;
+            let gpuvm = ARef::from(&*gpuvm_unique);
 
-        let as_data = Arc::pin_init(VmAsData::new(&mmu, dev, va_bits, pa_bits), GFP_KERNEL)?;
+            let as_data = Arc::pin_init(VmAsData::new(mmu, dev, va_bits, pa_bits), GFP_KERNEL)?;
 
-        let vm = Arc::pin_init(
-            pin_init!(Self{
+            Ok(try_pin_init!(Self {
                 as_data,
                 dev,
-                mmu: mmu.into(),
+                mmu,
                 gpuvm,
                 gpuvm_unique <- new_mutex!(gpuvm_unique),
                 va_range: range,
-            }),
-            GFP_KERNEL,
-        )?;
-
-        Ok(vm)
+            }))
+        })
     }
 
     /// Returns the parent device used by this VM for DMA mapping and page-table operations.
-    pub(crate) fn dev(&self) -> &'vm Device<Bound> {
+    pub(crate) fn dev(&self) -> &'res Device<Bound> {
         self.dev
     }
 
@@ -426,9 +425,9 @@ pub(crate) fn kill(&self) {
     /// GPUVM framework and the hardware page table.
     fn exec_op<'a>(
         &self,
-        gpuvm_unique: &mut UniqueRefGpuVm<GpuVmData<'vm>>,
-        req: VmOpRequest<'vm>,
-        resources: &'a mut VmOpResources<'vm>,
+        gpuvm_unique: &mut UniqueRefGpuVm<GpuVmData<'res>>,
+        req: VmOpRequest<'res>,
+        resources: &'a mut VmOpResources<'res>,
     ) -> Result {
         let pt = &self.as_data.page_table;
 
@@ -437,7 +436,7 @@ fn exec_op<'a>(
                 let mut pt_upd = PtUpdateContext::new(
                     self.dev,
                     pt,
-                    &self.mmu,
+                    self.mmu,
                     &self.as_data,
                     req.region,
                     PtOpType::Map(PtMapArgs {
@@ -459,7 +458,7 @@ fn exec_op<'a>(
                 let mut pt_upd = PtUpdateContext::new(
                     self.dev,
                     pt,
-                    &self.mmu,
+                    self.mmu,
                     &self.as_data,
                     req.region,
                     PtOpType::Unmap,
@@ -524,9 +523,9 @@ pub(crate) fn map_bo_range(
         };
         let mut resources = VmOpResources {
             preallocated_gpuvas: [
-                Some(GpuVaAlloc::<GpuVmData<'vm>>::new(GFP_KERNEL)?),
-                Some(GpuVaAlloc::<GpuVmData<'vm>>::new(GFP_KERNEL)?),
-                Some(GpuVaAlloc::<GpuVmData<'vm>>::new(GFP_KERNEL)?),
+                Some(GpuVaAlloc::<GpuVmData<'res>>::new(GFP_KERNEL)?),
+                Some(GpuVaAlloc::<GpuVmData<'res>>::new(GFP_KERNEL)?),
+                Some(GpuVaAlloc::<GpuVmData<'res>>::new(GFP_KERNEL)?),
             ],
         };
         let result = {
@@ -577,9 +576,9 @@ pub(crate) fn unmap_range(&self, va: u64, size: u64) -> Result {
                 [None, None, None]
             } else {
                 [
-                    Some(GpuVaAlloc::<GpuVmData<'vm>>::new(GFP_KERNEL)?),
-                    Some(GpuVaAlloc::<GpuVmData<'vm>>::new(GFP_KERNEL)?),
-                    Some(GpuVaAlloc::<GpuVmData<'vm>>::new(GFP_KERNEL)?),
+                    Some(GpuVaAlloc::<GpuVmData<'res>>::new(GFP_KERNEL)?),
+                    Some(GpuVaAlloc::<GpuVmData<'res>>::new(GFP_KERNEL)?),
+                    Some(GpuVaAlloc::<GpuVmData<'res>>::new(GFP_KERNEL)?),
                 ]
             },
         };
-- 
2.56.1

