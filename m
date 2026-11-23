Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC11606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matt3o12.de header.i=@matt3o12.de header.a=rsa-sha256 header.s=securedbylima-20230709 header.b=VJqOYnOH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D258410F1DD;
	Mon, 23 Nov 2026 20:40:09 +0000 (UTC)
Received: from mx1.mail-out.lima-city.de (mx1.mail-out.lima-city.de
 [91.216.248.203])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEE1F10F1DD
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 20:39:54 +0000 (UTC)
From: Matteo Kloiber <kernel@matt3o12.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matt3o12.de;
 s=securedbylima-20230709; t=1795466393;
 bh=XFtFx6yuzOdS0rMQwsslfA8mrrvFL4PucwDMubk+Yko=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VJqOYnOHrWcHeBN9Rrn4KjECwiU2xfj18wBk/E589L09beI+u2sIanA1vfZ0QaAnT
 cy64XlWyfBt765cSWeT55zn2gSMELQjLXRVfXVCPoC26EgJptHFzjSastBaUJcdClr
 7SxrgUAPmXQJ0RllFCRPvxYdfpnhQSKGBqxCbgoIsZXw82pM7LkG8SLYvL+hFFc09/
 aDhGgaSoxPHEp4xbBB5e71bhp3u+4tHqclMYaYcm3fhmfgyb/KPKL8Ju0CgtorGm8w
 TL/T66UeD02JBMTKMW0RDTk6xm4H1jldNseDA0SiptPOlvttlLhMejJnmmyJwajGCV
 pq6vgBVGNwDBw==
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Matteo Kloiber <kernel@matt3o12.de>
Subject: [RFC PATCH 3/3] rust: dma: require device configuration before DMA
Date: Mon, 23 Nov 2026 21:39:26 +0100
Message-ID: <20261123203926.1787169-4-kernel@matt3o12.de>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20261123203926.1787169-1-kernel@matt3o12.de>
References: <20261123203926.1787169-1-kernel@matt3o12.de>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rust drivers can allocate or map DMA memory without first setting the
DMA parameters. A missing setter leaves the existing value in use,
which is the bus default or whatever a previously bound driver left
behind. This happened with Nova's maximum segment size, fixed in
commit 6bd5eaeb9827 ("gpu: nova-core: declare unlimited DMA max
segment size").

Add a DMA Setup token to the PCI and platform InitTokens passed to
probe. Drivers can read device registers before they configure DMA.
Drivers that do not use DMA can discard the token.

Add Params for the streaming mask, coherent mask and maximum segment
size. Some(value) sets a parameter; None keeps its current value. Do not
implement Default, so drivers must specify every field, including new
fields.

Setup::configure consumes the token and returns a copyable Handle on
success. Require this handle for DMA allocations, scatterlist mappings
and IOMMU page tables. The handle prevents use of these APIs before
configuration and does not permit later changes to DMA parameters.
Document the same requirement for DRM callbacks that use the C DMA APIs.

Remove the dma::Device trait and its setters, and update drivers and
samples. Keep Nova's unlimited segment size and the DMA sample's 64 KiB
limit. Leave Tyr's existing segment size unchanged pending a hardware
limit review.

Link: https://lore.kernel.org/DLHH0K25NLX5.616R4D860TXU@nvidia.com
Link: https://lore.kernel.org/DLR1JCUWS824.35QJU45D2W9ZE@nvidia.com
Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Matteo Kloiber <kernel@matt3o12.de>
---
 drivers/gpu/drm/tyr/driver.rs                 |  19 +-
 drivers/gpu/drm/tyr/fw.rs                     |  11 +-
 drivers/gpu/drm/tyr/mmu/address_space.rs      |   7 +-
 drivers/gpu/drm/tyr/vm.rs                     |  28 +-
 drivers/gpu/nova-core/driver.rs               |   5 +-
 drivers/gpu/nova-core/falcon.rs               |  13 +-
 drivers/gpu/nova-core/fb.rs                   |  11 +-
 .../nova-core/firmware/fwsec/bootloader.rs    |  13 +-
 drivers/gpu/nova-core/firmware/gsp.rs         |  18 +-
 drivers/gpu/nova-core/firmware/gsp_fmc.rs     |  10 +-
 drivers/gpu/nova-core/firmware/radix3.rs      |  17 +-
 drivers/gpu/nova-core/firmware/riscv.rs       |  11 +-
 drivers/gpu/nova-core/fsp.rs                  |  20 +-
 drivers/gpu/nova-core/gpu.rs                  |  40 +--
 drivers/gpu/nova-core/gsp.rs                  |  19 +-
 drivers/gpu/nova-core/gsp/boot.rs             |   2 +-
 drivers/gpu/nova-core/gsp/cmdq.rs             |  14 +-
 drivers/gpu/nova-core/gsp/hal/gh100.rs        |   9 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs        |  24 +-
 drivers/gpu/nova-core/gsp/logbuffer.rs        |  23 +-
 rust/helpers/dma.c                            |   6 -
 rust/kernel/dma.rs                            | 264 +++++++++---------
 rust/kernel/drm/driver.rs                     |   4 +
 rust/kernel/drm/gem/shmem.rs                  |  23 +-
 rust/kernel/iommu/pgtable.rs                  |  24 +-
 rust/kernel/pci.rs                            |  14 +-
 rust/kernel/platform.rs                       |  14 +-
 rust/kernel/scatterlist.rs                    |  20 +-
 samples/rust/rust_dma.rs                      |  19 +-
 29 files changed, 387 insertions(+), 315 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 7650ade4ad72..9b9c7bd0fc6a 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -12,7 +12,7 @@
         DeviceContext, //
     },
     dma::{
-        Device as DmaDevice,
+        self,
         DmaMask, //
     },
     drm,
@@ -119,9 +119,10 @@ impl platform::Driver for TyrPlatformDriver {
 
     fn probe<'bound>(
         pdev: &'bound platform::Device<Core<'_>>,
-        _tokens: platform::InitTokens<'bound>,
+        tokens: platform::InitTokens<'bound>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        let platform::InitTokens { dma: setup, .. } = tokens;
         pin_init::pin_init_scope(move || {
             let core_clk = Clk::get(pdev.as_ref(), Some(c"core"))?;
             let stacks_clk = OptionalClk::get(pdev.as_ref(), Some(c"stacks"))?;
@@ -147,17 +148,21 @@ fn probe<'bound>(
             let pa_bits = MMU_FEATURES::from_raw(gpu_info.mmu_features)
                 .pa_bits()
                 .get();
-            // SAFETY: No concurrent DMA allocations or mappings can be made because
-            // the device is still being probed and therefore isn't being used by
-            // other threads of execution.
-            unsafe { pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_bits)?)? };
+            let mask = DmaMask::try_new(pa_bits)?;
+            let dma = setup.configure(dma::Params {
+                streaming_mask: Some(mask),
+                coherent_mask: Some(mask),
+                // TODO: Panthor calls `dma_set_max_seg_size(dev, UINT_MAX)`; Tyr probably wants
+                // `Some(NonZeroU32::MAX)` here as well.
+                max_seg_size: None,
+            })?;
 
             let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev)?;
 
             let mmu = Mmu::new(pdev.as_ref(), iomem.as_arc_borrow(), &gpu_info)?;
 
             let firmware = Firmware::new(
-                pdev.as_ref(),
+                dma,
                 iomem.clone(),
                 &unreg_dev,
                 mmu.as_arc_borrow(),
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index aea151ff1f93..b4e9de26ead5 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -15,10 +15,8 @@
 
 use kernel::{
     bitfield,
-    device::{
-        Bound,
-        Device, //
-    },
+    device::Device,
+    dma,
     drm::{
         gem::BaseObject, //
     },
@@ -213,13 +211,14 @@ fn load(
 
     /// Load firmware and map sections into MCU VM.
     pub(crate) fn new(
-        dev: &'drm Device<Bound>,
+        dma: dma::Handle<'drm>,
         iomem: Arc<IoMem<'drm>>,
         ddev: &TyrDrmDevice,
         mmu: ArcBorrow<'_, Mmu<'drm>>,
         gpu_info: &GpuInfo,
     ) -> Result<Firmware<'drm>> {
-        let vm = Vm::new(dev, ddev, mmu, gpu_info)?;
+        let dev = dma.device();
+        let vm = Vm::new(dma, ddev, mmu, gpu_info)?;
         vm.activate()?;
 
         let result = (|| {
diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index 76e3d2df6afd..ed131b8a6b57 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -12,7 +12,8 @@
     device::{
         Bound,
         Device, //
-    }, //
+    },
+    dma,
     error::Result,
     io::{
         poll,
@@ -89,7 +90,7 @@ impl<'drm> VmAsData<'drm> {
     /// Creates VM address space data by initializing all of its fields.
     pub(crate) fn new<'a>(
         mmu: &'a Mmu<'drm>,
-        dev: &'drm Device<Bound>,
+        dma: dma::Handle<'drm>,
         va_bits: u32,
         pa_bits: u32,
     ) -> impl pin_init::PinInit<VmAsData<'drm>, Error> + 'a {
@@ -101,7 +102,7 @@ pub(crate) fn new<'a>(
             coherent_walk: false,
         };
 
-        let page_table_init = IoPageTable::new(dev, pt_config);
+        let page_table_init = IoPageTable::new(dma, pt_config);
 
         try_pin_init!(Self {
             as_seat: LockedBy::new(&mmu.as_manager, Seat::NoSeat),
diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 1dd11b2b1253..d3614ca602cc 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -15,6 +15,7 @@
         Bound,
         Device, //
     },
+    dma,
     drm::{
         gem::BaseObject,
         gpuvm::{
@@ -219,8 +220,10 @@ enum PtOpType {
 /// Memory Management Unit (MMU) state is properly managed and Translation
 /// Lookaside Buffer (TLB) entries are flushed.
 pub(crate) struct PtUpdateContext<'ctx, 'drm> {
-    /// Device used for DMA-mapping GEM shmem SG tables.
+    /// Device used for log messages.
     dev: &'ctx Device<Bound>,
+    /// DMA handle used to map GEM shmem SG tables.
+    dma: dma::Handle<'ctx>,
 
     /// Page table.
     pt: &'ctx IoPageTable<'drm, ARM64LPAES1>,
@@ -248,7 +251,7 @@ impl<'ctx, 'drm> PtUpdateContext<'ctx, 'drm> {
     /// The context will automatically flush the TLB and
     /// complete the update when dropped.
     fn new(
-        dev: &'ctx Device<Bound>,
+        dma: dma::Handle<'ctx>,
         pt: &'ctx IoPageTable<'drm, ARM64LPAES1>,
         mmu: &'ctx Mmu<'drm>,
         as_data: &'ctx VmAsData<'drm>,
@@ -259,7 +262,8 @@ fn new(
         mmu.start_vm_update(as_data, &region)?;
 
         Ok(Self {
-            dev,
+            dev: dma.device(),
+            dma,
             pt,
             mmu,
             as_data,
@@ -321,8 +325,10 @@ pub(crate) struct Vm<'drm> {
     as_data: Arc<VmAsData<'drm>>,
     /// MMU manager.
     mmu: Arc<Mmu<'drm>>,
-    /// Parent device used for DMA mapping and page-table operations.
+    /// Parent device.
     dev: &'drm Device<Bound>,
+    /// DMA handle used for mappings and page-table operations.
+    dma: dma::Handle<'drm>,
     /// DRM GPUVM core for managing virtual address space.
     #[pin]
     gpuvm_unique: Mutex<UniqueRefGpuVm<GpuVmData<'drm>>>,
@@ -339,11 +345,12 @@ impl<'drm> Vm<'drm> {
     /// The VM is initialized with a page table configured according to the GPU's
     /// address translation capabilities and registered with the GPUVM framework.
     pub(crate) fn new(
-        dev: &'drm Device<Bound>,
+        dma: dma::Handle<'drm>,
         ddev: &TyrDrmDevice,
         mmu: ArcBorrow<'_, Mmu<'drm>>,
         gpu_info: &GpuInfo,
     ) -> Result<Arc<Vm<'drm>>> {
+        let dev = dma.device();
         let mmu_features = MMU_FEATURES::from_raw(gpu_info.mmu_features);
         let va_bits = mmu_features.va_bits().get();
         let pa_bits = mmu_features.pa_bits().get();
@@ -371,12 +378,13 @@ pub(crate) fn new(
         })?;
         let gpuvm = ARef::from(&*gpuvm_unique);
 
-        let as_data = Arc::pin_init(VmAsData::new(&mmu, dev, va_bits, pa_bits), GFP_KERNEL)?;
+        let as_data = Arc::pin_init(VmAsData::new(&mmu, dma, va_bits, pa_bits), GFP_KERNEL)?;
 
         let vm = Arc::pin_init(
             pin_init!(Self{
                 as_data,
                 dev,
+                dma,
                 mmu: mmu.into(),
                 gpuvm,
                 gpuvm_unique <- new_mutex!(gpuvm_unique),
@@ -388,7 +396,7 @@ pub(crate) fn new(
         Ok(vm)
     }
 
-    /// Returns the parent device used by this VM for DMA mapping and page-table operations.
+    /// Returns the parent device.
     pub(crate) fn dev(&self) -> &'drm Device<Bound> {
         self.dev
     }
@@ -435,7 +443,7 @@ fn exec_op<'a>(
         match req.op_type {
             VmOpType::Map(args) => {
                 let mut pt_upd = PtUpdateContext::new(
-                    self.dev,
+                    self.dma,
                     pt,
                     &self.mmu,
                     &self.as_data,
@@ -457,7 +465,7 @@ fn exec_op<'a>(
             }
             VmOpType::Unmap => {
                 let mut pt_upd = PtUpdateContext::new(
-                    self.dev,
+                    self.dma,
                     pt,
                     &self.mmu,
                     &self.as_data,
@@ -630,7 +638,7 @@ fn sm_step_map<'op>(
             return Err(EINVAL);
         }
 
-        let sgt = op.obj().sg_table(context.dev).inspect_err(|e| {
+        let sgt = op.obj().sg_table(context.dma).inspect_err(|e| {
             dev_err!(context.dev, "Failed to get sg_table: {:?}", e);
         })?;
         let prot = match &context.op_type {
diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index e42987e35846..cdf0d703538b 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -100,9 +100,10 @@ impl pci::Driver for NovaCoreDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
-        _tokens: pci::InitTokens<'bound>,
+        tokens: pci::InitTokens<'bound>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        let pci::InitTokens { dma, .. } = tokens;
         dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
         try_pin_init!(NovaCore {
@@ -132,7 +133,7 @@ fn probe<'bound>(
                 crate::irq::doorbell_test::run_selftest(pdev, bar, spec.chipset)?;
             },
 
-            gpu <- Gpu::new(pdev, bar, bar1).pin_chain(|_gpu| {
+            gpu <- Gpu::new(pdev, dma, bar, bar1).pin_chain(|_gpu| {
                 #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
                 _gpu.run_selftests(pdev);
                 Ok(())
diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index fb4f1cad867e..a3a6f853b7e4 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -7,6 +7,7 @@
 use kernel::{
     device,
     dma::{
+        self,
         Coherent,
         CoherentBox,
         DmaAddress, //
@@ -374,6 +375,7 @@ pub(crate) trait FalconFirmware {
 pub(crate) struct Falcon<'a, E: FalconEngine> {
     hal: KBox<dyn FalconHal<E>>,
     dev: &'a device::Device<device::Bound>,
+    dma: dma::Handle<'a>,
     bar: Bar0<'a>,
     // TODO: make private
     pub(crate) pfalcon: Mmio<'a, PFalconRegisters>,
@@ -382,14 +384,11 @@ pub(crate) struct Falcon<'a, E: FalconEngine> {
 
 impl<'a, E: FalconEngine + 'static> Falcon<'a, E> {
     /// Create a new falcon instance.
-    pub(crate) fn new(
-        dev: &'a device::Device<device::Bound>,
-        chipset: Chipset,
-        bar: Bar0<'a>,
-    ) -> Result<Self> {
+    pub(crate) fn new(dma: dma::Handle<'a>, chipset: Chipset, bar: Bar0<'a>) -> Result<Self> {
         Ok(Self {
             hal: hal::falcon_hal(chipset)?,
-            dev,
+            dev: dma.device(),
+            dma,
             bar,
             pfalcon: E::pfalcon(bar),
             pfalcon2: E::pfalcon2(bar),
@@ -651,7 +650,7 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(&self, fw: &F) ->
             // DMA copies are done in chunks of `MEM_BLOCK_ALIGNMENT`, so pad the length
             // accordingly and fill with `0`.
             let mut dma_obj = CoherentBox::zeroed_slice(
-                self.dev,
+                self.dma,
                 fw_slice.len().next_multiple_of(MEM_BLOCK_ALIGNMENT),
                 GFP_KERNEL,
             )?;
diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 5ceb7760c78e..164e14a8b6fc 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -7,7 +7,10 @@
 
 use kernel::{
     device,
-    dma::CoherentHandle,
+    dma::{
+        self,
+        CoherentHandle, //
+    },
     fmt,
     io::Io,
     prelude::*,
@@ -55,17 +58,17 @@ pub(crate) struct SysmemFlush<'sys> {
 impl<'sys> SysmemFlush<'sys> {
     /// Allocate a memory page and register it as the sysmem flush page.
     pub(crate) fn register(
-        dev: &'sys device::Device<device::Bound>,
+        dma: dma::Handle<'sys>,
         bar: Bar0<'sys>,
         chipset: Chipset,
     ) -> Result<Self> {
-        let page = CoherentHandle::alloc(dev, kernel::page::PAGE_SIZE, GFP_KERNEL)?;
+        let page = CoherentHandle::alloc(dma, kernel::page::PAGE_SIZE, GFP_KERNEL)?;
 
         hal::fb_hal(chipset).write_sysmem_flush_page(bar, page.dma_address())?;
 
         Ok(Self {
             chipset,
-            device: dev,
+            device: dma.device(),
             bar,
             page,
         })
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index 461e5e6f7899..d504c33d789f 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -11,7 +11,10 @@
         self,
         Device, //
     },
-    dma::Coherent,
+    dma::{
+        self,
+        Coherent, //
+    },
     prelude::*, //
 };
 
@@ -45,14 +48,14 @@ pub(crate) struct FwsecFirmwareWithBl<'a> {
 }
 
 impl<'a> FwsecFirmwareWithBl<'a> {
-    /// Loads the bootloader firmware for `dev` and `chipset`, and wrap `firmware` so it can be
+    /// Loads the bootloader firmware for the device and `chipset`, and wrap `firmware` so it can be
     /// loaded using it.
     pub(crate) fn new(
         firmware: FwsecFirmware,
-        dev: &'a Device<device::Bound>,
+        dma: dma::Handle<'a>,
         chipset: Chipset,
     ) -> Result<Self> {
-        let bootloader = GenericBootloader::new(dev, chipset)?;
+        let bootloader = GenericBootloader::new(dma.device(), chipset)?;
 
         // `BootloaderDmemDescV2` expects the source to be a mirror image of the destination and
         // uses the same offset parameter for both.
@@ -77,7 +80,7 @@ pub(crate) fn new(
 
             (
                 align_padding,
-                Coherent::from_slice(dev, firmware_obj.as_slice(), GFP_KERNEL)?,
+                Coherent::from_slice(dma, firmware_obj.as_slice(), GFP_KERNEL)?,
             )
         };
 
diff --git a/drivers/gpu/nova-core/firmware/gsp.rs b/drivers/gpu/nova-core/firmware/gsp.rs
index 341a8b19aa38..aafa6c583421 100644
--- a/drivers/gpu/nova-core/firmware/gsp.rs
+++ b/drivers/gpu/nova-core/firmware/gsp.rs
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 
 use kernel::{
-    device,
     dma::{
+        self,
         Coherent,
         DmaAddress, //
     },
@@ -37,12 +37,10 @@ pub(crate) struct GspFirmware<'a> {
 }
 
 impl<'a> GspFirmware<'a> {
-    /// Loads the GSP firmware binaries, map them into `dev`'s address-space, and creates the page
-    /// tables expected by the GSP bootloader to load it.
-    pub(crate) fn new(
-        dev: &'a device::Device<device::Bound>,
-        chipset: Chipset,
-    ) -> impl PinInit<Self, Error> + 'a {
+    /// Loads the GSP firmware binaries, maps them into the device's address space, and creates
+    /// the page tables expected by the GSP bootloader to load it.
+    pub(crate) fn new(dma: dma::Handle<'a>, chipset: Chipset) -> impl PinInit<Self, Error> + 'a {
+        let dev = dma.device();
         pin_init::pin_init_scope(move || {
             let firmware = request_tlv(dev, chipset, "gsp")?;
             let tlv = Tlv::new(firmware.data())?;
@@ -56,15 +54,15 @@ pub(crate) fn new(
             let filename = CString::try_from_fmt(fmt!("nvidia/{chip_name}/gsp/{file}"))?;
             firmware::request_into_buf(&filename, dev, fw_vvec.as_mut_slice())?;
 
-            let signatures = Coherent::from_slice(dev, tlv.get_bytes(b"SIGN")?, GFP_KERNEL)?;
+            let signatures = Coherent::from_slice(dma, tlv.get_bytes(b"SIGN")?, GFP_KERNEL)?;
 
             Ok(try_pin_init!(Self {
-                radix3 <- Radix3::new(dev, fw_vvec),
+                radix3 <- Radix3::new(dma, fw_vvec),
                 signatures,
                 bootloader: {
                     let bl = request_tlv(dev, chipset, "gsp_bootloader")?;
 
-                    RiscvFirmware::new(dev, &bl)?
+                    RiscvFirmware::new(dma, &bl)?
                 },
             }))
         })
diff --git a/drivers/gpu/nova-core/firmware/gsp_fmc.rs b/drivers/gpu/nova-core/firmware/gsp_fmc.rs
index 94fcc86c7dff..6c52eb2dbed9 100644
--- a/drivers/gpu/nova-core/firmware/gsp_fmc.rs
+++ b/drivers/gpu/nova-core/firmware/gsp_fmc.rs
@@ -6,7 +6,10 @@
 
 use kernel::{
     device,
-    dma::Coherent,
+    dma::{
+        self,
+        Coherent, //
+    },
     prelude::*, //
 };
 
@@ -48,7 +51,8 @@ pub(crate) struct GspFmcFirmware<'a> {
 }
 
 impl<'a> GspFmcFirmware<'a> {
-    pub(crate) fn new(dev: &'a device::Device<device::Bound>, chipset: Chipset) -> Result<Self> {
+    pub(crate) fn new(dma: dma::Handle<'a>, chipset: Chipset) -> Result<Self> {
+        let dev = dma.device();
         let fw = request_tlv(dev, chipset, "fmc")?;
         let tlv = Tlv::new(fw.data())?;
         dev_dbg!(
@@ -58,7 +62,7 @@ pub(crate) fn new(dev: &'a device::Device<device::Bound>, chipset: Chipset) -> R
         );
 
         let fmc_image_data = tlv.get_bytes(b"BLOB")?;
-        let fmc_image = Coherent::from_slice(dev, fmc_image_data, GFP_KERNEL)?;
+        let fmc_image = Coherent::from_slice(dma, fmc_image_data, GFP_KERNEL)?;
 
         Ok(Self {
             fmc_image,
diff --git a/drivers/gpu/nova-core/firmware/radix3.rs b/drivers/gpu/nova-core/firmware/radix3.rs
index 94235bd1209d..1dfe6b96ab45 100644
--- a/drivers/gpu/nova-core/firmware/radix3.rs
+++ b/drivers/gpu/nova-core/firmware/radix3.rs
@@ -12,8 +12,8 @@
 //! ```
 
 use kernel::{
-    device,
     dma::{
+        self,
         Coherent,
         CoherentBox,
         DataDirection,
@@ -50,23 +50,20 @@ pub(crate) struct Radix3<'a> {
 }
 
 impl<'a> Radix3<'a> {
-    /// Builds a radix3 page table over `data`, mapped for `dev` to read. May sleep.
-    pub(crate) fn new(
-        dev: &'a device::Device<device::Bound>,
-        data: VVec<u8>,
-    ) -> impl PinInit<Self, Error> + 'a {
+    /// Builds a radix3 page table over `data`, mapped for the device to read. May sleep.
+    pub(crate) fn new(dma: dma::Handle<'a>, data: VVec<u8>) -> impl PinInit<Self, Error> + 'a {
         let size = data.len();
 
         pin_init::pin_init_scope(move || {
             Ok(try_pin_init!(Self {
-                data <- SGTable::new(dev, data, DataDirection::ToDevice, GFP_KERNEL),
+                data <- SGTable::new(dma, data, DataDirection::ToDevice, GFP_KERNEL),
                 level2 <- {
                     build_lvl(&data)
-                        .map(|l2| SGTable::new(dev, l2, DataDirection::ToDevice, GFP_KERNEL))?
+                        .map(|l2| SGTable::new(dma, l2, DataDirection::ToDevice, GFP_KERNEL))?
                 },
                 level1 <- {
                     build_lvl(&level2)
-                        .map(|l1| SGTable::new(dev, l1, DataDirection::ToDevice, GFP_KERNEL))?
+                        .map(|l1| SGTable::new(dma, l1, DataDirection::ToDevice, GFP_KERNEL))?
                 },
                 level0: {
                     // Allocate the level 0 page table as a device-visible DMA object, and map the
@@ -79,7 +76,7 @@ pub(crate) fn new(
                     // Create level 0 page table data and fill its first entry with the level 1
                     // table.
                     let mut level0 = CoherentBox::<'_, [u64]>::zeroed_slice(
-                        dev,
+                        dma,
                         GSP_PAGE_SIZE / size_of::<u64>(),
                         GFP_KERNEL
                     )?;
diff --git a/drivers/gpu/nova-core/firmware/riscv.rs b/drivers/gpu/nova-core/firmware/riscv.rs
index f05cfb1c65da..f78af9bba740 100644
--- a/drivers/gpu/nova-core/firmware/riscv.rs
+++ b/drivers/gpu/nova-core/firmware/riscv.rs
@@ -4,8 +4,10 @@
 //! dedicated header.
 
 use kernel::{
-    device,
-    dma::Coherent,
+    dma::{
+        self,
+        Coherent, //
+    },
     firmware::Firmware,
     prelude::*, //
 };
@@ -28,7 +30,8 @@ pub(crate) struct RiscvFirmware<'a> {
 
 impl<'a> RiscvFirmware<'a> {
     /// Parses the RISC-V firmware image contained in `fw`.
-    pub(crate) fn new(dev: &'a device::Device<device::Bound>, fw: &Firmware) -> Result<Self> {
+    pub(crate) fn new(dma: dma::Handle<'a>, fw: &Firmware) -> Result<Self> {
+        let dev = dma.device();
         let tlv = Tlv::new(fw.data())?;
         dev_dbg!(
             dev,
@@ -41,7 +44,7 @@ pub(crate) fn new(dev: &'a device::Device<device::Bound>, fw: &Firmware) -> Resu
         let manifest_offset = tlv.get_u32(b"MFOF")?;
         let app_version = tlv.get_u32(b"APPV")?;
 
-        let ucode = Coherent::from_slice(dev, tlv.get_bytes(b"BLOB")?, GFP_KERNEL)?;
+        let ucode = Coherent::from_slice(dma, tlv.get_bytes(b"BLOB")?, GFP_KERNEL)?;
 
         Ok(Self {
             ucode,
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index ea08cd58346f..9675d3941ed5 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -12,7 +12,10 @@
 
 use kernel::{
     device,
-    dma::Coherent,
+    dma::{
+        self,
+        Coherent, //
+    },
     io::poll::read_poll_timeout,
     num::TryIntoBounded,
     prelude::*,
@@ -359,7 +362,7 @@ impl<'a> FmcBootArgs<'a> {
     /// Builds FMC boot arguments, allocating the DMA-coherent boot parameter
     /// structure that FSP will read.
     pub(crate) fn new(
-        dev: &'a device::Device<device::Bound>,
+        dma: dma::Handle<'a>,
         chipset: Chipset,
         wpr_meta: Coherent<'a, GspFwWprMeta>,
         libos: &'a Coherent<'a, [LibosMemoryRegionInitArgument]>,
@@ -369,7 +372,7 @@ pub(crate) fn new(
 
         Ok(Self {
             chipset,
-            fmc_boot_params: Coherent::init(dev, GFP_KERNEL, init)?,
+            fmc_boot_params: Coherent::init(dma, GFP_KERNEL, init)?,
             resume,
             _wpr_meta: wpr_meta,
             _libos: libos,
@@ -401,13 +404,13 @@ impl<'a> Fsp<'a> {
     ///
     /// If `chipset` doesn't support FSP, `Ok(None)` is returned.
     pub(crate) fn try_new(
-        dev: &'a device::Device<device::Bound>,
+        dma: dma::Handle<'a>,
         bar: Bar0<'a>,
         chipset: Chipset,
     ) -> Result<Option<Self>> {
         match hal::fsp_hal(chipset) {
             None => Ok(None),
-            Some(hal) => Self::wait_secure_boot(dev, bar, chipset, hal).map(Option::Some),
+            Some(hal) => Self::wait_secure_boot(dma, bar, chipset, hal).map(Option::Some),
         }
     }
 
@@ -417,7 +420,7 @@ pub(crate) fn try_new(
     /// elapses. Returning an [`Fsp`] only on success guarantees, at the API level, that the
     /// interface is not used before secure boot has completed.
     fn wait_secure_boot(
-        dev: &'a device::Device<device::Bound>,
+        dma: dma::Handle<'a>,
         bar: Bar0<'a>,
         chipset: Chipset,
         hal: &'static dyn hal::FspHal,
@@ -425,8 +428,9 @@ fn wait_secure_boot(
         /// FSP secure boot completion timeout in milliseconds.
         const FSP_SECURE_BOOT_TIMEOUT_MS: i64 = 5000;
 
-        let falcon = Falcon::<FspEngine>::new(dev, chipset, bar)?;
-        let fmc_fw = GspFmcFirmware::new(dev, chipset)?;
+        let dev = dma.device();
+        let falcon = Falcon::<FspEngine>::new(dma, chipset, bar)?;
+        let fmc_fw = GspFmcFirmware::new(dma, chipset)?;
 
         read_poll_timeout(
             || Ok(hal.fsp_boot_status(bar)),
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 993f1512c391..47ec4fa1400e 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -1,10 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use core::ops::Range;
+use core::{
+    num::NonZeroU32,
+    ops::Range, //
+};
 
 use kernel::{
     device,
-    dma::Device,
+    dma,
     fmt,
     gpu::buddy::GpuBuddyParams,
     io::Io,
@@ -322,6 +325,8 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 struct GspResources<'gpu> {
     /// Device owning the GPU.
     device: &'gpu pci::Device<device::Bound>,
+    /// DMA handle used for the GPU's allocations.
+    dma_handle: dma::Handle<'gpu>,
     /// Details about the chipset.
     spec: Spec,
     /// MMIO mapping of PCI BAR 0.
@@ -434,6 +439,7 @@ fn drop(self: Pin<&mut Self>) {
             .unload(
                 GspBootContext {
                     pdev: device,
+                    dma: *this.dma_handle,
                     bar,
                     chipset: this.spec.chipset,
                     gsp_falcon: &*this.gsp_falcon,
@@ -450,6 +456,7 @@ fn drop(self: Pin<&mut Self>) {
 impl<'gpu> Gpu<'gpu> {
     pub(crate) fn new<'a>(
         pdev: &'gpu pci::Device<device::Core<'a>>,
+        setup: dma::Setup<'gpu>,
         bar: Bar0<'gpu>,
         bar1: Bar1<'gpu>,
     ) -> impl PinInit<Self, Error> + use<'gpu, 'a> {
@@ -460,16 +467,13 @@ pub(crate) fn new<'a>(
                 dev_info!(dev, "NVIDIA ({})\n", spec);
             })?;
             let dma_mask = hal::gpu_hal(spec.chipset).dma_mask();
-            // SAFETY: `Gpu` owns all DMA allocations for this device, and we are
-            // still constructing it, so no concurrent DMA allocations can exist.
-            unsafe { pdev.dma_set_mask_and_coherent(dma_mask)? };
-
-            // Nova walks SG segments to build page tables, so their length is
-            // irrelevant to the device.
-            //
-            // SAFETY: `Gpu` owns all DMA allocations for this device, and we are
-            // still constructing it, so no concurrent DMA allocations can exist.
-            unsafe { pdev.dma_set_max_seg_size(u32::MAX) };
+            let dma = setup.configure(dma::Params {
+                streaming_mask: Some(dma_mask),
+                coherent_mask: Some(dma_mask),
+                // Nova walks SG segments to build page tables, so their length is
+                // irrelevant to the device.
+                max_seg_size: Some(NonZeroU32::MAX),
+            })?;
 
             Ok(try_pin_init!(Self {
                 spec,
@@ -483,32 +487,34 @@ pub(crate) fn new<'a>(
                 },
 
                 // Initialize this early because `gsp_resources` depends on it.
-                sysmem_flush: SysmemFlush::register(dev, bar, spec.chipset)?,
+                sysmem_flush: SysmemFlush::register(dma, bar, spec.chipset)?,
 
                 gsp_resources <- try_pin_init!(GspResources {
                     device: pdev,
+                    dma_handle: dma,
 
                     spec: *spec,
 
                     bar,
 
-                    gsp_falcon: Falcon::new(dev, spec.chipset, bar)?,
+                    gsp_falcon: Falcon::new(dma, spec.chipset, bar)?,
 
-                    sec2_falcon: Falcon::new(dev, spec.chipset, bar)?,
+                    sec2_falcon: Falcon::new(dma, spec.chipset, bar)?,
 
-                    fsp: Fsp::try_new(dev, bar, spec.chipset)?,
+                    fsp: Fsp::try_new(dma, bar, spec.chipset)?,
 
                     timer: Timer::setup(dev, bar, spec.chipset, fsp.as_ref())?,
 
                     vgpu: VgpuManager::new(pdev, spec.chipset, fsp.as_mut()),
 
-                    gsp <- Gsp::new(pdev, bar),
+                    gsp <- Gsp::new(dma, bar),
 
                     // This member must be initialized last, so the `UnloadBundle` can never be
                     // dropped from outside of the constructed `GspResources`, ensuring that the
                     // unload sequence is properly run in case of failure.
                     unload_bundle: gsp.boot(GspBootContext {
                         pdev,
+                        dma,
                         bar,
                         chipset: spec.chipset,
                         gsp_falcon,
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 2f1cdf8b7bec..e218a1628646 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -7,6 +7,7 @@
     debugfs,
     device,
     dma::{
+        self,
         Coherent,
         CoherentBox,
         CoherentView,
@@ -64,6 +65,7 @@
 /// - `'ctx` is a shorter lifetime during which this context borrows those subdevices.
 pub(crate) struct GspBootContext<'ctx, 'gpu> {
     pub(crate) pdev: &'gpu pci::Device<device::Bound>,
+    pub(crate) dma: dma::Handle<'gpu>,
     pub(crate) bar: Bar0<'gpu>,
     pub(crate) chipset: Chipset,
     pub(crate) gsp_falcon: &'ctx Falcon<'gpu, GspFalcon>,
@@ -114,25 +116,20 @@ pub(crate) struct Gsp<'gsp> {
 }
 
 impl<'gsp> Gsp<'gsp> {
-    // Creates an in-place initializer for a `Gsp` manager for `pdev`.
-    pub(crate) fn new(
-        pdev: &'gsp pci::Device<device::Bound>,
-        bar: Bar0<'gsp>,
-    ) -> impl PinInit<Self, Error> + 'gsp {
+    // Creates an in-place initializer for a `Gsp` manager for the device.
+    pub(crate) fn new(dma: dma::Handle<'gsp>, bar: Bar0<'gsp>) -> impl PinInit<Self, Error> + 'gsp {
         pin_init::pin_init_scope(move || {
-            let dev = pdev.as_ref();
-
-            let log_buffers = LogBuffers::new(dev)?;
+            let log_buffers = LogBuffers::new(dma)?;
 
             // Initialise the logging structures. The OpenRM equivalents are in:
             // _kgspInitLibosLoggingStructures (allocates memory for buffers)
             // kgspSetupLibosInitArgs_IMPL (creates pLibosInitArgs[] array)
             Ok(try_pin_init!(Self {
-                cmdq <- Cmdq::new(dev, bar),
-                rmargs: Coherent::init(dev, GFP_KERNEL, GspArgumentsPadded::new(&cmdq))?,
+                cmdq <- Cmdq::new(dma, bar),
+                rmargs: Coherent::init(dma, GFP_KERNEL, GspArgumentsPadded::new(&cmdq))?,
                 libos: {
                     let mut libos = CoherentBox::zeroed_slice(
-                        dev,
+                        dma,
                         GSP_PAGE_SIZE / size_of::<LibosMemoryRegionInitArgument>(),
                         GFP_KERNEL,
                     )?;
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 9d5da5b165ac..fc24a779305f 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -39,7 +39,7 @@ pub(crate) fn boot(
         let dev = pdev.as_ref();
         let hal = super::hal::gsp_hal(chipset);
 
-        let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset), GFP_KERNEL)?;
+        let gsp_fw = KBox::pin_init(GspFirmware::new(ctx.dma, chipset), GFP_KERNEL)?;
 
         self.cmdq
             .send_rpc_command_no_wait(commands::rpc::SetSystemInfo::new(
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index e2b9a5383a66..e442d956ce19 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -12,6 +12,7 @@
 use kernel::{
     device,
     dma::{
+        self,
         Coherent,
         CoherentBox,
         DmaAddress, //
@@ -174,12 +175,12 @@ struct DmaGspMem<'a> {
 }
 
 impl<'a> DmaGspMem<'a> {
-    /// Allocate a new instance and map it for `dev`.
-    fn new(dev: &'a device::Device<device::Bound>, bar: Bar0<'a>) -> Result<Self> {
+    /// Allocate a new instance and map it for the device.
+    fn new(dma: dma::Handle<'a>, bar: Bar0<'a>) -> Result<Self> {
         const MSGQ_SIZE: u32 = cv!(size_of::<Msgq>());
         const RX_HDR_OFF: u32 = cv!(mem::offset_of!(Msgq, rx));
 
-        let mut gsp_mem = CoherentBox::<'_, GspMem>::zeroed(dev, GFP_KERNEL)?;
+        let mut gsp_mem = CoherentBox::<'_, GspMem>::zeroed(dma, GFP_KERNEL)?;
         gsp_mem.cpuq.tx = MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES);
         gsp_mem.cpuq.rx = MsgqRxHeader::new();
 
@@ -489,13 +490,14 @@ impl<'cmdq> Cmdq<'cmdq> {
     /// Default timeout for receiving a message from the GSP.
     pub(super) const RECEIVE_TIMEOUT: Delta = Delta::from_secs(5);
 
-    /// Creates a new command queue for `dev`.
+    /// Creates a new command queue for the device.
     pub(crate) fn new(
-        dev: &'cmdq device::Device<device::Bound>,
+        dma: dma::Handle<'cmdq>,
         bar: Bar0<'cmdq>,
     ) -> impl PinInit<Self, Error> + 'cmdq {
         pin_init_scope(move || {
-            let gsp_mem = DmaGspMem::new(dev, bar)?;
+            let dev = dma.device();
+            let gsp_mem = DmaGspMem::new(dma, bar)?;
 
             Ok(try_pin_init!(Self {
                 dma_addr: gsp_mem.mem.dma_address(),
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index 91201b51030e..aad4a6b222aa 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -154,9 +154,12 @@ fn boot<'gpu>(
         let fb_sizes = FbSizes::new(chipset, ctx.bar, ctx.vgpu.state())?;
         dev_dbg!(dev, "{:#x?}\n", fb_sizes);
 
-        let wpr_meta =
-            Coherent::init(dev, GFP_KERNEL, GspFwWprMeta::from_sizes(gsp_fw, &fb_sizes))?;
-        let args = FmcBootArgs::new(dev, chipset, wpr_meta, &gsp.libos, false)?;
+        let wpr_meta = Coherent::init(
+            ctx.dma,
+            GFP_KERNEL,
+            GspFwWprMeta::from_sizes(gsp_fw, &fb_sizes),
+        )?;
+        let args = FmcBootArgs::new(ctx.dma, chipset, wpr_meta, &gsp.libos, false)?;
 
         let unload_bundle = crate::gsp::UnloadBundle(
             KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle + 'gpu>
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index e90db1a23032..48f6a3dffa29 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -5,7 +5,10 @@
 
 use kernel::{
     device,
-    dma::Coherent,
+    dma::{
+        self,
+        Coherent, //
+    },
     io::Io,
     types::ScopeGuard, //
 };
@@ -136,13 +139,15 @@ impl Tu102 {
     /// created the WPR2 region.
     fn run_fwsec_frts(
         &self,
-        dev: &device::Device<device::Bound>,
+        dma: dma::Handle<'_>,
         chipset: Chipset,
         falcon: &Falcon<'_, GspEngine>,
         bar: Bar0<'_>,
         bios: &Vbios,
         fb_ranges: &FbRanges,
     ) -> Result {
+        let dev = dma.device();
+
         // Check that the WPR2 region does not already exist - if it does, we cannot run
         // FWSEC-FRTS until the GPU is reset.
         if wpr2_range(bar).is_some() {
@@ -165,7 +170,7 @@ fn run_fwsec_frts(
         )?;
 
         if self.needs_fwsec_bootloader {
-            let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dev, chipset)?;
+            let fwsec_frts_bl = FwsecFirmwareWithBl::new(fwsec_frts, dma, chipset)?;
             // Load and run the bootloader, which will load FWSEC-FRTS and run it.
             fwsec_frts_bl.run(dev, falcon)?;
         } else {
@@ -214,16 +219,18 @@ fn run_fwsec_frts(
     /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
     fn build_unload_bundle<'gpu>(
         &self,
-        dev: &'gpu device::Device<device::Bound>,
+        dma: dma::Handle<'gpu>,
         chipset: Chipset,
         bios: &Vbios,
         gsp_falcon: &Falcon<'_, GspEngine>,
         sec2_falcon: &Falcon<'_, Sec2>,
     ) -> Result<crate::gsp::UnloadBundle<'gpu>> {
+        let dev = dma.device();
+
         // Load the FWSEC SB firmware, as well as its bootloader if required.
         let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bios, FwsecCommand::Sb)?;
         let fwsec_sb = if self.needs_fwsec_bootloader {
-            FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?)
+            FwsecUnloadFirmware::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dma, chipset)?)
         } else {
             FwsecUnloadFirmware::WithoutBl(fwsec_sb)
         };
@@ -252,6 +259,7 @@ fn boot<'gpu>(
         ctx: &mut GspBootContext<'_, 'gpu>,
         gsp_fw: &GspFirmware<'gpu>,
     ) -> Result<Option<crate::gsp::UnloadBundle<'gpu>>> {
+        let dma = ctx.dma;
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
@@ -264,7 +272,7 @@ fn boot<'gpu>(
         // Declared before the unload guard so that if Booter fails while running, SEC2 is reset
         // by the guard before this allocation is freed.
         let wpr_meta = Coherent::init(
-            dev,
+            dma,
             GFP_KERNEL,
             GspFwWprMeta::from_ranges(gsp_fw, &fb_ranges),
         )?;
@@ -276,7 +284,7 @@ fn boot<'gpu>(
         // If the unload bundle creation fails, the GPU will need to be reset before the driver can
         // be probed again.
         let unload_bundle = self
-            .build_unload_bundle(dev, chipset, &bios, gsp_falcon, sec2_falcon)
+            .build_unload_bundle(dma, chipset, &bios, gsp_falcon, sec2_falcon)
             .inspect_err(|e| dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n", e))
             .ok();
 
@@ -289,7 +297,7 @@ fn boot<'gpu>(
 
         // FWSEC-FRTS is not executed on chips where the FRTS region size is 0 (e.g. GA100).
         if !fb_ranges.frts.is_empty() {
-            self.run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, &fb_ranges)?;
+            self.run_fwsec_frts(dma, chipset, gsp_falcon, bar, &bios, &fb_ranges)?;
         }
 
         gsp_falcon.reset()?;
diff --git a/drivers/gpu/nova-core/gsp/logbuffer.rs b/drivers/gpu/nova-core/gsp/logbuffer.rs
index 5455d990ffb4..2b3494470a83 100644
--- a/drivers/gpu/nova-core/gsp/logbuffer.rs
+++ b/drivers/gpu/nova-core/gsp/logbuffer.rs
@@ -5,7 +5,10 @@
 use kernel::{
     debugfs,
     device,
-    dma::Coherent,
+    dma::{
+        self,
+        Coherent, //
+    },
     io::{
         io_project,
         Io, //
@@ -47,9 +50,9 @@
 pub(super) struct LogBuffer<'a>(pub(super) Coherent<'a, [u8; LOG_BUFFER_SIZE]>);
 
 impl<'a> LogBuffer<'a> {
-    /// Creates a new `LogBuffer` mapped on `dev`.
-    fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
-        let obj = Self(Coherent::zeroed(dev, GFP_KERNEL)?);
+    /// Creates a new `LogBuffer` mapped on the device.
+    fn new(dma: dma::Handle<'a>) -> Result<Self> {
+        let obj = Self(Coherent::zeroed(dma, GFP_KERNEL)?);
 
         let start_addr = obj.0.dma_address();
 
@@ -98,13 +101,13 @@ pub(super) struct LogBuffers<'a> {
 }
 
 impl<'a> LogBuffers<'a> {
-    /// Allocates the log buffers of `dev`.
-    pub(super) fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
+    /// Allocates the log buffers of the device.
+    pub(super) fn new(dma: dma::Handle<'a>) -> Result<Self> {
         Ok(Self {
-            dev,
-            loginit: LogBuffer::new(dev)?,
-            logintr: LogBuffer::new(dev)?,
-            logrm: LogBuffer::new(dev)?,
+            dev: dma.device(),
+            loginit: LogBuffer::new(dma)?,
+            logintr: LogBuffer::new(dma)?,
+            logrm: LogBuffer::new(dma)?,
         })
     }
 
diff --git a/rust/helpers/dma.c b/rust/helpers/dma.c
index ff8f24dae9df..443360237606 100644
--- a/rust/helpers/dma.c
+++ b/rust/helpers/dma.c
@@ -17,12 +17,6 @@ __rust_helper void rust_helper_dma_free_attrs(struct device *dev, size_t size,
 	dma_free_attrs(dev, size, cpu_addr, dma_handle, attrs);
 }
 
-__rust_helper int rust_helper_dma_set_mask_and_coherent(struct device *dev,
-							u64 mask)
-{
-	return dma_set_mask_and_coherent(dev, mask);
-}
-
 __rust_helper int rust_helper_dma_set_mask(struct device *dev, u64 mask)
 {
 	return dma_set_mask(dev, mask);
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 580e1c3427bc..03f48bd1f940 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -9,8 +9,7 @@
     debugfs,
     device::{
         self,
-        Bound,
-        Core, //
+        Bound, //
     },
     error::to_result,
     fs::file,
@@ -31,6 +30,7 @@
     uaccess::UserSliceWriter, //
 };
 use core::{
+    num::NonZeroU32,
     ops::{
         Deref,
         DerefMut, //
@@ -48,83 +48,124 @@
 /// Note that this may be `u64` even on 32-bit architectures.
 pub type DmaAddress = bindings::dma_addr_t;
 
-/// Trait to be implemented by DMA capable bus devices.
+/// DMA parameters passed to [`Setup::configure`].
 ///
-/// The [`dma::Device`](Device) trait should be implemented by bus specific device representations,
-/// where the underlying bus is DMA capable, such as:
-#[cfg_attr(CONFIG_PCI, doc = "* [`pci::Device`](kernel::pci::Device)")]
-/// * [`platform::Device`](::kernel::platform::Device)
-pub trait Device<'a>: AsRef<device::Device<Core<'a>>> {
-    /// Set up the device's DMA streaming addressing capabilities.
+/// `Some(value)` sets a parameter and `None` keeps its current value. The current value is whatever
+/// the bus set up or a previously bound driver left behind, so it is not necessarily the bus
+/// default. There is intentionally no `Default` implementation, so drivers have to decide on every
+/// parameter, including ones added later.
+///
+/// # Examples
+///
+/// ```
+/// # use core::num::NonZeroU32;
+/// use kernel::dma::{self, Coherent, DmaMask};
+///
+/// # fn test(setup: dma::Setup<'_>) -> Result {
+/// let dma = setup.configure(dma::Params {
+///     streaming_mask: Some(DmaMask::new::<64>()),
+///     coherent_mask: Some(DmaMask::new::<64>()),
+///     max_seg_size: Some(NonZeroU32::MAX),
+/// })?;
+///
+/// let _buf = Coherent::<u64>::zeroed(dma, GFP_KERNEL)?;
+/// # Ok::<(), Error>(()) }
+/// ```
+pub struct Params {
+    /// Address mask for streaming DMA mappings.
+    pub streaming_mask: Option<DmaMask>,
+    /// Address mask for coherent DMA allocations.
+    pub coherent_mask: Option<DmaMask>,
+    /// Maximum length in bytes of a DMA segment supported by the device.
     ///
-    /// This method is usually called once from `probe()` as soon as the device capabilities are
-    /// known.
+    /// Use `Some(NonZeroU32::MAX)` if the device has no segment size limit.
+    pub max_seg_size: Option<NonZeroU32>,
+}
+
+/// Token for configuring a device's DMA parameters.
+///
+/// The bus passes it to the driver's `probe()` callback. The driver can access the device, e.g. to
+/// read its capabilities, before calling [`Setup::configure`], which consumes the token. Drivers
+/// that don't use DMA can drop it.
+///
+/// # Invariants
+///
+/// - The bus has initialized the device's DMA parameters.
+/// - There is only one `Setup` per driver binding, and no [`Handle`] has been created for it yet.
+/// - No DMA allocation or mapping for this device can run concurrently with
+///   [`Setup::configure`], and nothing else changes the DMA parameters while the device is bound.
+pub struct Setup<'bound> {
+    dev: &'bound device::Device<Bound>,
+}
+
+impl<'bound> Setup<'bound> {
+    /// Creates the setup token passed to a driver's probe callback.
     ///
     /// # Safety
     ///
-    /// This method must not be called concurrently with any DMA allocation or mapping primitives,
-    /// such as [`Coherent::zeroed`].
-    unsafe fn dma_set_mask(&self, mask: DmaMask) -> Result {
-        // SAFETY:
-        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
-        // - The safety requirement of this function guarantees that there are no concurrent calls
-        //   to DMA allocation and mapping primitives using this mask.
-        to_result(unsafe { bindings::dma_set_mask(self.as_ref().as_raw(), mask.value()) })
+    /// The caller must ensure the invariants of [`Self`], including uniqueness of the token.
+    pub(crate) unsafe fn new(dev: &'bound device::Device<Bound>) -> Self {
+        Self { dev }
     }
 
-    /// Set up the device's DMA coherent addressing capabilities.
-    ///
-    /// This method is usually called once from `probe()` as soon as the device capabilities are
-    /// known.
-    ///
-    /// # Safety
+    /// Applies `params` and returns a [`Handle`] for DMA allocations and mappings.
     ///
-    /// This method must not be called concurrently with any DMA allocation or mapping primitives,
-    /// such as [`Coherent::zeroed`].
-    unsafe fn dma_set_coherent_mask(&self, mask: DmaMask) -> Result {
-        // SAFETY:
-        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
-        // - The safety requirement of this function guarantees that there are no concurrent calls
-        //   to DMA allocation and mapping primitives using this mask.
-        to_result(unsafe { bindings::dma_set_coherent_mask(self.as_ref().as_raw(), mask.value()) })
+    /// If a setter fails, its error is returned and parameters applied before it are not restored.
+    pub fn configure(self, params: Params) -> Result<Handle<'bound>> {
+        let dev = self.dev.as_raw();
+
+        if let Some(mask) = params.streaming_mask {
+            // SAFETY: `dev` is valid. The `Setup` invariants exclude concurrent DMA operations
+            // and other parameter setters, and consuming the token prevents reconfiguration.
+            to_result(unsafe { bindings::dma_set_mask(dev, mask.value()) })?;
+        }
+        if let Some(mask) = params.coherent_mask {
+            // SAFETY: `dev` is valid. The `Setup` invariants exclude concurrent DMA operations
+            // and other parameter setters, and consuming the token prevents reconfiguration.
+            to_result(unsafe { bindings::dma_set_coherent_mask(dev, mask.value()) })?;
+        }
+        if let Some(size) = params.max_seg_size {
+            // SAFETY: `dev` is valid and its DMA parameters are initialized. The `Setup`
+            // invariants exclude concurrent DMA operations and other parameter setters,
+            // and consuming the token prevents reconfiguration.
+            unsafe { bindings::dma_set_max_seg_size(dev, size.get()) };
+        }
+
+        // INVARIANT: All requested setters succeeded. The `Setup` invariants prevent further
+        // changes while the device is bound to the driver.
+        Ok(Handle { dev: self.dev })
+    }
+}
+
+/// Handle for DMA allocations and mappings on a configured device.
+///
+/// Returned by [`Setup::configure`]. It can be copied freely, but cannot change the DMA parameters.
+///
+/// # Invariants
+///
+/// The requested DMA parameters have been applied and do not change during `'bound`.
+#[derive(Clone, Copy)]
+pub struct Handle<'bound> {
+    dev: &'bound device::Device<Bound>,
+}
+
+impl<'bound> Handle<'bound> {
+    /// Returns the device associated with this DMA handle.
+    pub fn device(self) -> &'bound device::Device<Bound> {
+        self.dev
     }
 
-    /// Set up the device's DMA addressing capabilities.
-    ///
-    /// This is a combination of [`Device::dma_set_mask`] and [`Device::dma_set_coherent_mask`].
-    ///
-    /// This method is usually called once from `probe()` as soon as the device capabilities are
-    /// known.
-    ///
-    /// # Safety
-    ///
-    /// This method must not be called concurrently with any DMA allocation or mapping primitives,
-    /// such as [`Coherent::zeroed`].
-    unsafe fn dma_set_mask_and_coherent(&self, mask: DmaMask) -> Result {
-        // SAFETY:
-        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
-        // - The safety requirement of this function guarantees that there are no concurrent calls
-        //   to DMA allocation and mapping primitives using this mask.
-        to_result(unsafe {
-            bindings::dma_set_mask_and_coherent(self.as_ref().as_raw(), mask.value())
-        })
+    pub(crate) fn as_raw(self) -> *mut bindings::device {
+        self.dev.as_raw()
     }
 
-    /// Set the maximum size of a single DMA segment the device may request.
+    /// Creates a handle for `dev` without calling [`Setup::configure`].
     ///
-    /// This method is usually called once from `probe()` as soon as the device capabilities are
-    /// known.
-    ///
-    /// # Safety
-    ///
-    /// This method must not be called concurrently with any DMA allocation or mapping primitives,
-    /// such as [`Coherent::zeroed`].
-    unsafe fn dma_set_max_seg_size(&self, size: u32) {
-        // SAFETY:
-        // - By the type invariant of `device::Device`, `self.as_ref().as_raw()` is valid.
-        // - The safety requirement of this function guarantees that there are no concurrent calls
-        //   to DMA allocation and mapping primitives using this parameter.
-        unsafe { bindings::dma_set_max_seg_size(self.as_ref().as_raw(), size) }
+    /// For tests only.
+    #[cfg(CONFIG_KUNIT = "y")]
+    #[allow(dead_code)] // Only used by tests of other, optional abstractions.
+    pub(crate) fn new_for_test(dev: &'bound device::Device<Bound>) -> Self {
+        Self { dev }
     }
 }
 
@@ -217,10 +258,9 @@ pub const fn value(&self) -> u64 {
 /// # Examples
 ///
 /// ```
-/// # use kernel::device::{Bound, Device};
 /// use kernel::dma::{attrs::*, Coherent};
 ///
-/// # fn test(dev: &Device<Bound>) -> Result {
+/// # fn test(dev: kernel::dma::Handle<'_>) -> Result {
 /// let attribs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_WARN;
 /// let c: Coherent<'_, [u64]> =
 ///     Coherent::zeroed_slice_with_attrs(dev, 4, GFP_KERNEL, attribs)?;
@@ -380,16 +420,12 @@ fn from(direction: DataDirection) -> Self {
 /// `CoherentBox<T>`:
 ///
 /// ```
-/// # use kernel::device::{
-/// #     Bound,
-/// #     Device,
-/// # };
 /// use kernel::dma::{attrs::*,
 ///     Coherent,
 ///     CoherentBox,
 /// };
 ///
-/// # fn test(dev: &Device<Bound>) -> Result {
+/// # fn test(dev: kernel::dma::Handle<'_>) -> Result {
 /// let mut dmem: CoherentBox<'_, u64> = CoherentBox::zeroed(dev, GFP_KERNEL)?;
 /// *dmem = 42;
 /// let dmem: Coherent<'_, u64> = dmem.into();
@@ -400,16 +436,12 @@ fn from(direction: DataDirection) -> Self {
 ///
 ///
 /// ```
-/// # use kernel::device::{
-/// #     Bound,
-/// #     Device,
-/// # };
 /// use kernel::dma::{attrs::*,
 ///     Coherent,
 ///     CoherentBox,
 /// };
 ///
-/// # fn test(dev: &Device<Bound>) -> Result {
+/// # fn test(dev: kernel::dma::Handle<'_>) -> Result {
 /// let mut dmem: CoherentBox<'_, [u64]> = CoherentBox::zeroed_slice(dev, 4, GFP_KERNEL)?;
 /// dmem.fill(42);
 /// let dmem: Coherent<'_, [u64]> = dmem.into();
@@ -421,7 +453,7 @@ impl<'a, T: AsBytes + FromBytes> CoherentBox<'a, [T]> {
     /// [`CoherentBox`] variant of [`Coherent::zeroed_slice_with_attrs`].
     #[inline]
     pub fn zeroed_slice_with_attrs(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -432,7 +464,7 @@ pub fn zeroed_slice_with_attrs(
     /// Same as [CoherentBox::zeroed_slice_with_attrs], but with `dma::Attrs(0)`.
     #[inline]
     pub fn zeroed_slice(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
     ) -> Result<Self> {
@@ -472,13 +504,12 @@ pub fn init_at<E>(&mut self, i: usize, init: impl Init<T, E>) -> Result
     /// ```
     /// use core::ops::Deref;
     ///
-    /// # use kernel::device::{Bound, Device};
     /// use kernel::dma::{
     ///     attrs::*,
     ///     CoherentBox
     /// };
     ///
-    /// # fn test(dev: &Device<Bound>) -> Result {
+    /// # fn test(dev: kernel::dma::Handle<'_>) -> Result {
     /// let data = [0u8, 1u8, 2u8, 3u8];
     /// let c: CoherentBox<'_, [u8]> =
     ///     CoherentBox::from_slice_with_attrs(dev, &data, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
@@ -487,7 +518,7 @@ pub fn init_at<E>(&mut self, i: usize, init: impl Init<T, E>) -> Result
     /// # Ok::<(), Error>(()) }
     /// ```
     pub fn from_slice_with_attrs(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         data: &[T],
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -511,11 +542,7 @@ pub fn from_slice_with_attrs(
     /// Performs the same functionality as [`CoherentBox::from_slice_with_attrs`], except the
     /// `dma_attrs` is 0 by default.
     #[inline]
-    pub fn from_slice(
-        dev: &'a device::Device<Bound>,
-        data: &[T],
-        gfp_flags: kernel::alloc::Flags,
-    ) -> Result<Self>
+    pub fn from_slice(dev: Handle<'a>, data: &[T], gfp_flags: kernel::alloc::Flags) -> Result<Self>
     where
         T: Copy,
     {
@@ -527,7 +554,7 @@ impl<'a, T: AsBytes + FromBytes> CoherentBox<'a, T> {
     /// Same as [`CoherentBox::zeroed_slice_with_attrs`], but for a single element.
     #[inline]
     pub fn zeroed_with_attrs(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
     ) -> Result<Self> {
@@ -536,7 +563,7 @@ pub fn zeroed_with_attrs(
 
     /// Same as [`CoherentBox::zeroed_slice`], but for a single element.
     #[inline]
-    pub fn zeroed(dev: &'a device::Device<Bound>, gfp_flags: kernel::alloc::Flags) -> Result<Self> {
+    pub fn zeroed(dev: Handle<'a>, gfp_flags: kernel::alloc::Flags) -> Result<Self> {
         Self::zeroed_with_attrs(dev, gfp_flags, Attrs(0))
     }
 }
@@ -595,7 +622,7 @@ fn from(value: CoherentBox<'a, T>) -> Self {
 // constructors `unsafe` to prevent this is considered too restrictive for the common case; this
 // soundness hole is accepted for now.
 pub struct Coherent<'a, T: KnownSize + ?Sized> {
-    dev: &'a device::Device<Bound>,
+    dev: Handle<'a>,
     dma_addr: DmaAddress,
     cpu_addr: NonNull<T>,
     dma_attrs: Attrs,
@@ -660,7 +687,7 @@ pub unsafe fn as_mut(&self) -> &mut T {
 impl<'a, T: AsBytes + FromBytes> Coherent<'a, T> {
     /// Allocates a region of `T` of coherent memory.
     fn alloc_with_attrs(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
     ) -> Result<Self> {
@@ -672,7 +699,7 @@ fn alloc_with_attrs(
         }
 
         let mut dma_addr = 0;
-        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
+        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `device::Device`.
         let addr = unsafe {
             bindings::dma_alloc_attrs(
                 dev.as_raw(),
@@ -686,7 +713,7 @@ fn alloc_with_attrs(
         // INVARIANT:
         // - We just successfully allocated a coherent region which is adequately sized for `T`,
         //   hence the cpu address is valid.
-        // - `dev` is a valid reference to a bound device that outlives this allocation.
+        // - `dev` is a configured DMA handle for a device that outlives this allocation.
         Ok(Self {
             dev,
             dma_addr,
@@ -700,23 +727,19 @@ fn alloc_with_attrs(
     /// # Examples
     ///
     /// ```
-    /// # use kernel::device::{
-    /// #     Bound,
-    /// #     Device,
-    /// # };
     /// use kernel::dma::{
     ///     attrs::*,
     ///     Coherent,
     /// };
     ///
-    /// # fn test(dev: &Device<Bound>) -> Result {
+    /// # fn test(dev: kernel::dma::Handle<'_>) -> Result {
     /// let c: Coherent<'_, [u64; 4]> =
     ///     Coherent::zeroed_with_attrs(dev, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
     /// # Ok::<(), Error>(()) }
     /// ```
     #[inline]
     pub fn zeroed_with_attrs(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
     ) -> Result<Self> {
@@ -726,14 +749,14 @@ pub fn zeroed_with_attrs(
     /// Performs the same functionality as [`Coherent::zeroed_with_attrs`], except the
     /// `dma_attrs` is 0 by default.
     #[inline]
-    pub fn zeroed(dev: &'a device::Device<Bound>, gfp_flags: kernel::alloc::Flags) -> Result<Self> {
+    pub fn zeroed(dev: Handle<'a>, gfp_flags: kernel::alloc::Flags) -> Result<Self> {
         Self::zeroed_with_attrs(dev, gfp_flags, Attrs(0))
     }
 
     /// Same as [`Coherent::zeroed_with_attrs`], but instead of a zero-initialization the memory is
     /// initialized with `init`.
     pub fn init_with_attrs<E>(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
         init: impl Init<T, E>,
@@ -758,7 +781,7 @@ pub fn init_with_attrs<E>(
     /// with `init`.
     #[inline]
     pub fn init<E>(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         gfp_flags: kernel::alloc::Flags,
         init: impl Init<T, E>,
     ) -> Result<Self>
@@ -770,7 +793,7 @@ pub fn init<E>(
 
     /// Allocates a region of `[T; len]` of coherent memory.
     fn alloc_slice_with_attrs(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         len: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -789,7 +812,7 @@ fn alloc_slice_with_attrs(
 
         let size = core::mem::size_of::<T>().checked_mul(len).ok_or(ENOMEM)?;
         let mut dma_addr = 0;
-        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
+        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `device::Device`.
         let addr = unsafe {
             bindings::dma_alloc_attrs(
                 dev.as_raw(),
@@ -803,7 +826,7 @@ fn alloc_slice_with_attrs(
         // INVARIANT:
         // - We just successfully allocated a coherent region which is adequately sized for
         //   `[T; len]`, hence the cpu address is valid.
-        // - `dev` is a valid reference to a bound device that outlives this allocation.
+        // - `dev` is a configured DMA handle for a device that outlives this allocation.
         Ok(Coherent {
             dev,
             dma_addr,
@@ -820,23 +843,19 @@ fn alloc_slice_with_attrs(
     /// # Examples
     ///
     /// ```
-    /// # use kernel::device::{
-    /// #     Bound,
-    /// #     Device,
-    /// # };
     /// use kernel::dma::{
     ///     attrs::*,
     ///     Coherent,
     /// };
     ///
-    /// # fn test(dev: &Device<Bound>) -> Result {
+    /// # fn test(dev: kernel::dma::Handle<'_>) -> Result {
     /// let c: Coherent<'_, [u64]> =
     ///     Coherent::zeroed_slice_with_attrs(dev, 4, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
     /// # Ok::<(), Error>(()) }
     /// ```
     #[inline]
     pub fn zeroed_slice_with_attrs(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         len: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -848,7 +867,7 @@ pub fn zeroed_slice_with_attrs(
     /// `dma_attrs` is 0 by default.
     #[inline]
     pub fn zeroed_slice(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         len: usize,
         gfp_flags: kernel::alloc::Flags,
     ) -> Result<Coherent<'a, [T]>> {
@@ -861,13 +880,12 @@ pub fn zeroed_slice(
     /// # Examples
     ///
     /// ```
-    /// # use kernel::device::{Bound, Device};
     /// use kernel::dma::{
     ///     attrs::*,
     ///     Coherent
     /// };
     ///
-    /// # fn test(dev: &Device<Bound>) -> Result {
+    /// # fn test(dev: kernel::dma::Handle<'_>) -> Result {
     /// let data = [0u8, 1u8, 2u8, 3u8];
     /// // `c` has the same content as `data`.
     /// let c: Coherent<'_, [u8]> =
@@ -877,7 +895,7 @@ pub fn zeroed_slice(
     /// ```
     #[inline]
     pub fn from_slice_with_attrs(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         data: &[T],
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -892,7 +910,7 @@ pub fn from_slice_with_attrs(
     /// `dma_attrs` is 0 by default.
     #[inline]
     pub fn from_slice(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         data: &[T],
         gfp_flags: kernel::alloc::Flags,
     ) -> Result<Coherent<'a, [T]>>
@@ -991,7 +1009,7 @@ fn write_to_slice(
 /// - `dma_attrs` contains the attributes used for the allocation, always including
 ///   `DMA_ATTR_NO_KERNEL_MAPPING`.
 pub struct CoherentHandle<'a> {
-    dev: &'a device::Device<Bound>,
+    dev: Handle<'a>,
     dma_addr: DmaAddress,
     cpu_handle: NonNull<c_void>,
     size: usize,
@@ -1006,7 +1024,7 @@ impl<'a> CoherentHandle<'a> {
     ///
     /// Returns `EINVAL` if `size` is zero, `ENOMEM` if the allocation fails.
     pub fn alloc_with_attrs(
-        dev: &'a device::Device<Bound>,
+        dev: Handle<'a>,
         size: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -1032,7 +1050,7 @@ pub fn alloc_with_attrs(
 
         // INVARIANT: `cpu_handle` is the opaque handle from a successful `dma_alloc_attrs` call
         // with `DMA_ATTR_NO_KERNEL_MAPPING`, `dma_addr` is the corresponding DMA address,
-        // and `dev` is a valid reference to a bound device that outlives this allocation.
+        // and `dev` is a configured DMA handle for a device that outlives this allocation.
         Ok(Self {
             dev,
             dma_addr,
@@ -1044,11 +1062,7 @@ pub fn alloc_with_attrs(
 
     /// Allocates `size` bytes of coherent DMA memory without creating a kernel virtual mapping.
     #[inline]
-    pub fn alloc(
-        dev: &'a device::Device<Bound>,
-        size: usize,
-        gfp_flags: kernel::alloc::Flags,
-    ) -> Result<Self> {
+    pub fn alloc(dev: Handle<'a>, size: usize, gfp_flags: kernel::alloc::Flags) -> Result<Self> {
         Self::alloc_with_attrs(dev, size, gfp_flags, Attrs(0))
     }
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 3e16a67801a0..af9d7ee376dd 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -175,6 +175,10 @@ pub struct Registration<'a, T: Driver> {
 impl<'a, T: Driver> Registration<'a, T> {
     /// Register a new [`UnregisteredDevice`](drm::UnregisteredDevice) with userspace.
     ///
+    /// If the driver's C callbacks allocate or map DMA memory, DMA must be configured for the
+    /// device before calling this, and its DMA parameters must not change while those callbacks
+    /// can run.
+    ///
     /// # Safety
     ///
     /// The caller must not `mem::forget()` the returned [`Registration`] or otherwise prevent its
diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 386b8894fe2e..f33aff1e0c95 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -11,11 +11,8 @@
 
 use crate::{
     container_of,
-    device::{
-        self,
-        Bound, //
-    },
     devres::*,
+    dma,
     drm::{
         driver,
         gem,
@@ -255,13 +252,10 @@ pub fn vmap<const SIZE: usize>(&self) -> Result<VMapRef<'_, T, SIZE>> {
     /// Creates (if necessary) and returns an immutable reference to a scatter-gather table of DMA
     /// pages for this object.
     ///
-    /// This will pin the object in memory. It is expected that `dev` should be a pointer to the
-    /// same [`device::Device`] which `self` belongs to, otherwise this function will return
-    /// `Err(EINVAL)`.
-    pub fn sg_table<'a>(
-        &'a self,
-        dev: &'a device::Device<Bound>,
-    ) -> Result<&'a scatterlist::SGTable> {
+    /// This pins the object in memory. The DMA handle must belong to this object's parent
+    /// device, otherwise this function returns `Err(EINVAL)`.
+    pub fn sg_table<'a>(&'a self, dma: dma::Handle<'a>) -> Result<&'a scatterlist::SGTable> {
+        let dev = dma.device();
         let parent = self.dev().as_ref();
         if dev.as_raw() != parent.as_ref().as_raw() {
             return Err(EINVAL);
@@ -578,6 +572,7 @@ unsafe impl<T: DriverObject> Sync for SGTableMap<T> {}
 mod tests {
     use super::*;
     use crate::{
+        device,
         drm::{
             self,
             UnregisteredDevice, //
@@ -704,14 +699,14 @@ fn vmap_io() -> Result {
     fn fail_sg_table_on_wrong_dev() -> Result {
         let (_dev, drm) = create_drm_dev()?;
         let reg = faux::Registration::new(c"EvilKunit", None)?;
-        let wrong_dev = reg.as_ref();
+        let wrong_dma = dma::Handle::new_for_test(reg.as_ref().as_ref());
 
         let obj = Object::<KunitObject>::new(&drm, PAGE_SIZE, ObjectConfig::default(), ())?;
 
-        assert_eq!(obj.sg_table(wrong_dev.as_ref()).err().unwrap(), EINVAL);
+        assert_eq!(obj.sg_table(wrong_dma).err().unwrap(), EINVAL);
 
         // If sgt_res was not initialized mistakenly with the wrong device, this should still fail.
-        assert_eq!(obj.sg_table(wrong_dev.as_ref()).err().unwrap(), EINVAL);
+        assert_eq!(obj.sg_table(wrong_dma).err().unwrap(), EINVAL);
 
         // TODO: Someday, we should test that creating an sg_table here still succeeds.
 
diff --git a/rust/kernel/iommu/pgtable.rs b/rust/kernel/iommu/pgtable.rs
index 5f9b42ca92c2..78acef800011 100644
--- a/rust/kernel/iommu/pgtable.rs
+++ b/rust/kernel/iommu/pgtable.rs
@@ -12,10 +12,7 @@
 use crate::{
     alloc,
     bindings,
-    device::{
-        Bound,
-        Device, //
-    },
+    dma,
     error::to_result,
     io::PhysAddr,
     prelude::*, //
@@ -57,10 +54,11 @@ pub struct Config {
 ///
 /// # Invariants
 ///
-/// The pointer references a valid io page table.
+/// The pointer references a valid io page table whose device's DMA parameters have been
+/// configured and remain unchanged for the lifetime of the page table.
 pub struct IoPageTable<'a, F: IoPageTableFmt> {
     ptr: NonNull<bindings::io_pgtable_ops>,
-    _dev: PhantomData<&'a Device<Bound>>,
+    _dma: PhantomData<dma::Handle<'a>>,
     _marker: PhantomData<F>,
 }
 
@@ -77,8 +75,10 @@ pub trait IoPageTableFmt: 'static {
 
 impl<'a, F: IoPageTableFmt> IoPageTable<'a, F> {
     /// Create a new `IoPageTable`.
+    ///
+    /// Requires a configured DMA handle because non-coherent page tables may use DMA mappings.
     #[inline]
-    pub fn new(dev: &'a Device<Bound>, config: Config) -> Result<IoPageTable<'a, F>> {
+    pub fn new(dma: dma::Handle<'a>, config: Config) -> Result<IoPageTable<'a, F>> {
         let mut raw_cfg = bindings::io_pgtable_cfg {
             quirks: config.quirks,
             pgsize_bitmap: config.pgsize_bitmap,
@@ -86,7 +86,7 @@ pub fn new(dev: &'a Device<Bound>, config: Config) -> Result<IoPageTable<'a, F>>
             oas: config.oas,
             coherent_walk: config.coherent_walk,
             tlb: &raw const NOOP_FLUSH_OPS,
-            iommu_dev: dev.as_raw(),
+            iommu_dev: dma.as_raw(),
             ..Zeroable::zeroed()
         };
 
@@ -94,15 +94,17 @@ pub fn new(dev: &'a Device<Bound>, config: Config) -> Result<IoPageTable<'a, F>>
         // * The raw_cfg pointer is valid for the duration of this call.
         // * The provided `FLUSH_OPS` contains valid function pointers that accept a null pointer
         //   as cookie.
-        // * The caller ensures that the io pgtable does not outlive the device.
+        // * The DMA handle ensures that the device is configured and remains bound for `'a`.
+        //   The returned page table cannot outlive this lifetime.
         let ops = unsafe {
             bindings::alloc_io_pgtable_ops(F::FORMAT, &mut raw_cfg, core::ptr::null_mut())
         };
 
-        // INVARIANT: We successfully created a valid page table.
+        // INVARIANT: We successfully created a valid page table. The DMA handle guarantees
+        // that its device's parameters are configured and remain unchanged for `'a`.
         Ok(IoPageTable {
             ptr: NonNull::new(ops).ok_or(ENOMEM)?,
-            _dev: PhantomData,
+            _dma: PhantomData,
             _marker: PhantomData,
         })
     }
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index fdb2934eda0d..0e50eff34f35 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -12,6 +12,7 @@
         RawDeviceId,
         RawDeviceIdIndex, //
     },
+    dma,
     driver,
     error::{
         from_result,
@@ -128,7 +129,11 @@ extern "C" fn probe_callback(
         let info = unsafe { id.info_unchecked_opt::<T::IdInfo>() };
 
         from_result(|| {
-            let data = T::probe(pdev, InitTokens { _p: PhantomData }, info);
+            // SAFETY: The bus initializes DMA parameters before probing. This is the only
+            // setup token issued for this binding, and the driver cannot use the Rust DMA
+            // allocation or mapping APIs until it consumes the token to configure DMA.
+            let dma = unsafe { dma::Setup::new(pdev.as_ref()) };
+            let data = T::probe(pdev, InitTokens { dma }, info);
 
             pdev.as_ref().set_drvdata(data)?;
             Ok(0)
@@ -264,7 +269,8 @@ macro_rules! pci_device_table {
 /// Initialization tokens passed to a PCI driver's [`Driver::probe`] callback.
 #[non_exhaustive]
 pub struct InitTokens<'bound> {
-    _p: PhantomData<&'bound ()>,
+    /// Token for configuring DMA, see [`dma::Setup`].
+    pub dma: dma::Setup<'bound>,
 }
 
 /// The PCI driver trait.
@@ -322,6 +328,8 @@ pub trait Driver {
     ///
     /// Called when a new pci device is added or discovered. Implementers should
     /// attempt to initialize the device here.
+    ///
+    /// Drivers that use DMA must configure it through `tokens.dma` first.
     fn probe<'bound>(
         dev: &'bound Device<device::Core<'_>>,
         tokens: InitTokens<'bound>,
@@ -515,8 +523,6 @@ unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx>
 kernel::impl_device_context_deref!(unsafe { Device });
 kernel::impl_device_context_into_aref!(Device);
 
-impl<'a> crate::dma::Device<'a> for Device<device::Core<'a>> {}
-
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     #[inline]
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index a7b33e229a30..d22c291739ee 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -12,6 +12,7 @@
         self,
         Bound, //
     },
+    dma,
     driver,
     error::{
         from_result,
@@ -104,7 +105,11 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
         let info = unsafe { <Self as driver::Adapter>::id_info(pdev.as_ref()) };
 
         from_result(|| {
-            let data = T::probe(pdev, InitTokens { _p: PhantomData }, info);
+            // SAFETY: The bus initializes DMA parameters before probing. This is the only
+            // setup token issued for this binding, and the driver cannot use the Rust DMA
+            // allocation or mapping APIs until it consumes the token to configure DMA.
+            let dma = unsafe { dma::Setup::new(pdev.as_ref()) };
+            let data = T::probe(pdev, InitTokens { dma }, info);
 
             pdev.as_ref().set_drvdata(data)?;
             Ok(0)
@@ -162,7 +167,8 @@ macro_rules! module_platform_driver {
 /// Initialization tokens passed to a platform driver's [`Driver::probe`] callback.
 #[non_exhaustive]
 pub struct InitTokens<'bound> {
-    _p: PhantomData<&'bound ()>,
+    /// Token for configuring DMA, see [`dma::Setup`].
+    pub dma: dma::Setup<'bound>,
 }
 
 /// The platform driver trait.
@@ -234,6 +240,8 @@ pub trait Driver {
     ///
     /// Called when a new platform device is added or discovered.
     /// Implementers should attempt to initialize the device here.
+    ///
+    /// Drivers that use DMA must configure it through `tokens.dma` first.
     fn probe<'bound>(
         dev: &'bound Device<device::Core<'_>>,
         tokens: InitTokens<'bound>,
@@ -539,8 +547,6 @@ pub fn optional_irq_by_name(&self, name: &CStr) -> Result<IrqRequest<'_>> {
 kernel::impl_device_context_deref!(unsafe { Device });
 kernel::impl_device_context_into_aref!(Device);
 
-impl<'a> crate::dma::Device<'a> for Device<device::Core<'a>> {}
-
 // SAFETY: Instances of `Device` are always reference-counted.
 unsafe impl crate::sync::aref::AlwaysRefCounted for Device {
     fn inc_ref(&self) {
diff --git a/rust/kernel/scatterlist.rs b/rust/kernel/scatterlist.rs
index 3a5250f85000..bd54a2e04cb9 100644
--- a/rust/kernel/scatterlist.rs
+++ b/rust/kernel/scatterlist.rs
@@ -333,12 +333,13 @@ impl<P> Owned<P>
 where
     for<'a> P: page::AsPageIter<Iter<'a> = VmallocPageIter<'a>> + 'static,
 {
-    fn new(
-        dev: &Device<Bound>,
+    fn new<'a>(
+        dma: dma::Handle<'a>,
         mut pages: P,
         dir: dma::DataDirection,
         flags: alloc::Flags,
-    ) -> Result<impl PinInit<Self, Error> + '_> {
+    ) -> Result<impl PinInit<Self, Error> + 'a> {
+        let dev = dma.device();
         let page_iter = pages.page_iter();
         let size = page_iter.size();
 
@@ -406,7 +407,7 @@ impl<P> SGTable<Owned<P>>
     ///
     /// # Parameters
     ///
-    /// * `dev`: The [`Device`] that will be performing the DMA.
+    /// * `dma`: A handle for the device whose DMA parameters have been configured.
     /// * `pages`: The entity providing the backing pages. It must implement [`page::AsPageIter`].
     ///   The ownership of this entity is moved into the new [`SGTable<Owned>`].
     /// * `dir`: The [`dma::DataDirection`] of the DMA transfer.
@@ -416,13 +417,12 @@ impl<P> SGTable<Owned<P>>
     ///
     /// ```
     /// use kernel::{
-    ///     device::{Bound, Device},
     ///     dma, page,
     ///     prelude::*,
     ///     scatterlist::{SGTable, Owned},
     /// };
     ///
-    /// fn test(dev: &Device<Bound>) -> Result {
+    /// fn test(dev: dma::Handle<'_>) -> Result {
     ///     let size = 4 * page::PAGE_SIZE;
     ///     let pages = VVec::<u8>::with_capacity(size, GFP_KERNEL)?;
     ///
@@ -436,14 +436,14 @@ impl<P> SGTable<Owned<P>>
     ///     Ok(())
     /// }
     /// ```
-    pub fn new(
-        dev: &Device<Bound>,
+    pub fn new<'a>(
+        dma: dma::Handle<'a>,
         pages: P,
         dir: dma::DataDirection,
         flags: alloc::Flags,
-    ) -> impl PinInit<Self, Error> + '_ {
+    ) -> impl PinInit<Self, Error> + 'a {
         try_pin_init!(Self {
-            inner <- Owned::new(dev, pages, dir, flags)?
+            inner <- Owned::new(dma, pages, dir, flags)?
         })
     }
 }
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 25ce01f2d224..9d93524204b2 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -4,15 +4,17 @@
 //!
 //! To make this driver probe, QEMU must be run with `-device pci-testdev`.
 
+use core::num::NonZeroU32;
+
 use kernel::{
     device::{
         Bound,
         Core, //
     },
     dma::{
+        self,
         Coherent,
         DataDirection,
-        Device,
         DmaMask, //
     },
     io::{
@@ -27,6 +29,7 @@
         Owned,
         SGTable, //
     }, //
+    sizes::SizeConstants,
 };
 
 struct DmaSampleDriver;
@@ -76,19 +79,23 @@ impl pci::Driver for DmaSampleDriver {
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
-        _tokens: pci::InitTokens<'bound>,
+        tokens: pci::InitTokens<'bound>,
         _info: Option<&'bound Self::IdInfo>,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
+        let pci::InitTokens { dma: setup, .. } = tokens;
         pin_init::pin_init_scope(move || {
             dev_info!(pdev, "Probe DMA test driver.\n");
 
             let mask = DmaMask::new::<64>();
 
-            // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
-            unsafe { pdev.dma_set_mask_and_coherent(mask)? };
+            let dma = setup.configure(dma::Params {
+                streaming_mask: Some(mask),
+                coherent_mask: Some(mask),
+                max_seg_size: Some(const { NonZeroU32::new(u32::SZ_64K).unwrap() }),
+            })?;
 
             let ca: Coherent<'_, [MyStruct]> =
-                Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
+                Coherent::zeroed_slice(dma, TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
                 io_project!(ca, [panic: i]).copy_write(MyStruct::new(value.0, value.1));
@@ -97,7 +104,7 @@ fn probe<'bound>(
             let size = 4 * page::PAGE_SIZE;
             let pages = VVec::with_capacity(size, GFP_KERNEL)?;
 
-            let sgt = SGTable::new(pdev.as_ref(), pages, DataDirection::ToDevice, GFP_KERNEL);
+            let sgt = SGTable::new(dma, pages, DataDirection::ToDevice, GFP_KERNEL);
 
             Ok(try_pin_init!(Self::Data {
                 pdev,
-- 
2.51.2

