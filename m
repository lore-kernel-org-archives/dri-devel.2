Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BDAC61DE1
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 19:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547CD10E223;
	Sun, 30 Aug 2026 19:39:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KF1xxxU6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D0D10E223
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 19:39:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 695F040186;
 Sun, 30 Aug 2026 19:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAAA1F000E9;
 Sun, 30 Aug 2026 19:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788118767;
 bh=B/J0dQVm1CYnTLlC/ZEqOzh+mwu9l206IVsM49M3P2U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KF1xxxU6l3EomNY1i4++AYhgmq+yuKR77NzQnnk++gdYYwf73WlXzyQTb1nT2ktsZ
 hODopOp97M0zYwGMcptuPpPED6arsOvJOr0lGl2LVcOXjXaICMZqJJsd6aSKEQ/P57
 w5mmNqaURoPghiGSgz6WScPKoOMno3gY9/At3QBswgeHtOx/pJ7KMj77pl/gyTGTZ1
 Et1crG8PTd67O2fH44fpRKmQxekq3/L3JE5FiSj5v2lTqLW8DpFnHzXaXqFkkYd97L
 QuUvgY0KXT1XPaHG+1jRz3FUtnNpmvJ3VWBsJ70QOYZKtXza/MeXrktxtdT2ceTu2D
 ue8ZYlenPsAYQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 tamird@kernel.org, work@onurozkan.dev, mmaurer@google.com
Cc: driver-core@lists.linux.dev, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 4/4] rust: dma: tie Coherent and CoherentBox to the device's
 bound lifetime
Date: Sun, 30 Aug 2026 21:37:16 +0200
Message-ID: <20260830193824.471089-5-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830193824.471089-1-dakr@kernel.org>
References: <20260830193824.471089-1-dakr@kernel.org>
MIME-Version: 1.0
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

Add a lifetime parameter to Coherent and CoherentBox that ties the DMA
allocation to the device's bound scope, ensuring it is freed before the
device is unbound.

DMA allocations carry device resources (e.g. IOMMU mappings) that must
not outlive the device's bound lifetime. Without a lifetime parameter,
there was no compile-time enforcement that a Coherent or CoherentBox is
dropped before the device is unbound.

Propagate the new lifetime parameter through all users.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/falcon.rs               |   2 +-
 drivers/gpu/nova-core/fb.rs                   |   2 +-
 drivers/gpu/nova-core/firmware/booter.rs      |   2 +-
 drivers/gpu/nova-core/firmware/fsp.rs         |   8 +-
 .../nova-core/firmware/fwsec/bootloader.rs    |  12 +-
 drivers/gpu/nova-core/firmware/gsp.rs         |  14 +-
 drivers/gpu/nova-core/firmware/riscv.rs       |   8 +-
 drivers/gpu/nova-core/fsp.rs                  |  20 +--
 drivers/gpu/nova-core/gpu.rs                  |   4 +-
 drivers/gpu/nova-core/gsp.rs                  |  30 ++---
 drivers/gpu/nova-core/gsp/boot.rs             |  10 +-
 drivers/gpu/nova-core/gsp/cmdq.rs             |  35 +++--
 drivers/gpu/nova-core/gsp/commands.rs         |   2 +-
 drivers/gpu/nova-core/gsp/fw.rs               |  12 +-
 drivers/gpu/nova-core/gsp/hal.rs              |  14 +-
 drivers/gpu/nova-core/gsp/hal/gh100.rs        |  16 +--
 drivers/gpu/nova-core/gsp/hal/tu102.rs        |  34 ++---
 drivers/gpu/nova-core/gsp/sequencer.rs        |   6 +-
 rust/kernel/dma.rs                            | 121 +++++++++---------
 rust/kernel/uaccess.rs                        |   4 +-
 samples/rust/rust_dma.rs                      |   4 +-
 21 files changed, 176 insertions(+), 184 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 65cb12d26e2b..15eba039cb69 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -506,7 +506,7 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
     /// `sec` is set if the loaded firmware is expected to run in secure mode.
     fn dma_wr(
         &self,
-        dma_obj: &Coherent<[u8]>,
+        dma_obj: &Coherent<'_, [u8]>,
         target_mem: FalconMem,
         load_offsets: FalconDmaLoadTarget,
     ) -> Result {
diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 9ef232a73dee..b3a6ab8b57a6 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -177,7 +177,7 @@ impl FbRanges {
     pub(crate) fn new(
         chipset: Chipset,
         bar: Bar0<'_>,
-        gsp_fw: &GspFirmware,
+        gsp_fw: &GspFirmware<'_>,
         vgpu_state: VgpuState,
     ) -> Result<Self> {
         let hal = hal::fb_hal(chipset);
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index dc071edba331..aa4458bb3312 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -186,7 +186,7 @@ pub(crate) fn run<T>(
         &self,
         dev: &device::Device<device::Bound>,
         sec2_falcon: &Falcon<'_, Sec2>,
-        wpr_meta: &Coherent<T>,
+        wpr_meta: &Coherent<'_, T>,
     ) -> Result {
         sec2_falcon.reset()?;
         sec2_falcon.load(self)?;
diff --git a/drivers/gpu/nova-core/firmware/fsp.rs b/drivers/gpu/nova-core/firmware/fsp.rs
index 5462e318410a..d47b1d2a1030 100644
--- a/drivers/gpu/nova-core/firmware/fsp.rs
+++ b/drivers/gpu/nova-core/firmware/fsp.rs
@@ -39,15 +39,15 @@ pub(crate) struct FmcSignatures {
     pub(crate) signature: [u8; FSP_SIG_SIZE],
 }
 
-pub(crate) struct FspFirmware {
+pub(crate) struct FspFirmware<'a> {
     /// FMC firmware image data
-    pub(crate) fmc_image: Coherent<[u8]>,
+    pub(crate) fmc_image: Coherent<'a, [u8]>,
     /// FMC firmware signatures.
     pub(crate) fmc_sigs: KBox<FmcSignatures>,
 }
 
-impl FspFirmware {
-    pub(crate) fn new(dev: &device::Device<device::Bound>, chipset: Chipset) -> Result<Self> {
+impl<'a> FspFirmware<'a> {
+    pub(crate) fn new(dev: &'a device::Device<device::Bound>, chipset: Chipset) -> Result<Self> {
         let fw = request_tlv(dev, chipset, "fmc")?;
         let tlv = Tlv::new(fw.data())?;
         dev_dbg!(dev, "loaded fsp firmware v{}\n", tlv.get_string(b"VERS")?);
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index ec4d92317a93..06a7936a8c5e 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -98,9 +98,9 @@ unsafe impl AsBytes for BootloaderDmemDescV2 {}
 
 /// Wrapper for [`FwsecFirmware`] that includes the bootloader performing the actual load
 /// operation.
-pub(crate) struct FwsecFirmwareWithBl {
+pub(crate) struct FwsecFirmwareWithBl<'a> {
     /// DMA object the bootloader will copy the firmware from.
-    _firmware_dma: Coherent<[u8]>,
+    _firmware_dma: Coherent<'a, [u8]>,
     /// Code of the bootloader to be loaded into non-secure IMEM.
     ucode: KVec<u8>,
     /// Descriptor to be loaded into DMEM for the bootloader to read.
@@ -113,12 +113,12 @@ pub(crate) struct FwsecFirmwareWithBl {
     start_tag: u16,
 }
 
-impl FwsecFirmwareWithBl {
+impl<'a> FwsecFirmwareWithBl<'a> {
     /// Loads the bootloader firmware for `dev` and `chipset`, and wrap `firmware` so it can be
     /// loaded using it.
     pub(crate) fn new(
         firmware: FwsecFirmware,
-        dev: &Device<device::Bound>,
+        dev: &'a Device<device::Bound>,
         chipset: Chipset,
     ) -> Result<Self> {
         let fw = request_tlv(dev, chipset, "gen_bootloader")?;
@@ -272,7 +272,7 @@ pub(crate) fn run(
     }
 }
 
-impl FalconFirmware for FwsecFirmwareWithBl {
+impl FalconFirmware for FwsecFirmwareWithBl<'_> {
     type Target = Gsp;
 
     fn brom_params(&self) -> FalconBromParams {
@@ -286,7 +286,7 @@ fn boot_addr(&self) -> u32 {
     }
 }
 
-impl FalconPioLoadable for FwsecFirmwareWithBl {
+impl FalconPioLoadable for FwsecFirmwareWithBl<'_> {
     fn imem_sec_load_params(&self) -> Option<FalconPioImemLoadTarget<'_>> {
         None
     }
diff --git a/drivers/gpu/nova-core/firmware/gsp.rs b/drivers/gpu/nova-core/firmware/gsp.rs
index e8f9491e84cc..22d1f9329c9f 100644
--- a/drivers/gpu/nova-core/firmware/gsp.rs
+++ b/drivers/gpu/nova-core/firmware/gsp.rs
@@ -44,7 +44,7 @@
 /// Each page is 4KB, each entry is 8 bytes (64-bit DMA address).
 /// Also known as "Radix3" firmware.
 #[pin_data]
-pub(crate) struct GspFirmware {
+pub(crate) struct GspFirmware<'a> {
     /// The GSP firmware inside a [`VVec`], device-mapped via a SG table.
     #[pin]
     fw: SGTable<Owned<VVec<u8>>>,
@@ -55,19 +55,19 @@ pub(crate) struct GspFirmware {
     #[pin]
     level1: SGTable<Owned<VVec<u8>>>,
     /// Level 0 page table (single 4KB page) with one entry: DMA address of first level 1 page.
-    level0: Coherent<[u64]>,
+    level0: Coherent<'a, [u64]>,
     /// Size in bytes of the firmware contained in [`Self::fw`].
     pub(crate) size: usize,
     /// Device-mapped GSP signatures matching the GPU's [`Chipset`].
-    pub(crate) signatures: Coherent<[u8]>,
+    pub(crate) signatures: Coherent<'a, [u8]>,
     /// GSP bootloader, verifies the GSP firmware before loading and running it.
-    pub(crate) bootloader: RiscvFirmware,
+    pub(crate) bootloader: RiscvFirmware<'a>,
 }
 
-impl GspFirmware {
+impl<'a> GspFirmware<'a> {
     /// Loads the GSP firmware binaries, map them into `dev`'s address-space, and creates the page
     /// tables expected by the GSP bootloader to load it.
-    pub(crate) fn new<'a>(
+    pub(crate) fn new(
         dev: &'a device::Device<device::Bound>,
         chipset: Chipset,
     ) -> impl PinInit<Self, Error> + 'a {
@@ -120,7 +120,7 @@ pub(crate) fn new<'a>(
 
                     // Create level 0 page table data and fill its first entry with the level 1
                     // table.
-                    let mut level0 = CoherentBox::<[u64]>::zeroed_slice(
+                    let mut level0 = CoherentBox::<'_, [u64]>::zeroed_slice(
                         dev,
                         GSP_PAGE_SIZE / size_of::<u64>(),
                         GFP_KERNEL
diff --git a/drivers/gpu/nova-core/firmware/riscv.rs b/drivers/gpu/nova-core/firmware/riscv.rs
index 1403f05a7305..f05cfb1c65da 100644
--- a/drivers/gpu/nova-core/firmware/riscv.rs
+++ b/drivers/gpu/nova-core/firmware/riscv.rs
@@ -13,7 +13,7 @@
 use crate::firmware::tlv::Tlv;
 
 /// A parsed firmware for a RISC-V core, ready to be loaded and run.
-pub(crate) struct RiscvFirmware {
+pub(crate) struct RiscvFirmware<'a> {
     /// Offset at which the code starts in the firmware image.
     pub(crate) code_offset: u32,
     /// Offset at which the data starts in the firmware image.
@@ -23,12 +23,12 @@ pub(crate) struct RiscvFirmware {
     /// Application version.
     pub(crate) app_version: u32,
     /// Device-mapped firmware image.
-    pub(crate) ucode: Coherent<[u8]>,
+    pub(crate) ucode: Coherent<'a, [u8]>,
 }
 
-impl RiscvFirmware {
+impl<'a> RiscvFirmware<'a> {
     /// Parses the RISC-V firmware image contained in `fw`.
-    pub(crate) fn new(dev: &device::Device<device::Bound>, fw: &Firmware) -> Result<Self> {
+    pub(crate) fn new(dev: &'a device::Device<device::Bound>, fw: &Firmware) -> Result<Self> {
         let tlv = Tlv::new(fw.data())?;
         dev_dbg!(
             dev,
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index ab685fb4168f..961e96fe9484 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -267,7 +267,7 @@ fn frts_vidmem_offset(hal: &dyn hal::FspHal, fb_info: &FbSizes) -> Result<u64> {
     /// Returns an in-place initializer for [`FspCotMessage`].
     fn new<'a>(
         fb_info: &FbSizes,
-        fsp_fw: &'a FspFirmware,
+        fsp_fw: &'a FspFirmware<'_>,
         args: &'a FmcBootArgs<'_>,
     ) -> Result<impl Init<Self> + 'a> {
         let hal = hal::fsp_hal(args.chipset).ok_or(ENOTSUPP)?;
@@ -345,28 +345,28 @@ impl MessageToFsp for FspPrcMessage {
 /// Bundled arguments for FMC boot via FSP Chain of Trust.
 pub(crate) struct FmcBootArgs<'a> {
     chipset: Chipset,
-    fmc_boot_params: Coherent<GspFmcBootParams>,
+    fmc_boot_params: Coherent<'a, GspFmcBootParams>,
     resume: bool,
     // Additional dependencies required to be kept alive for FMC boot.
-    _wpr_meta: Coherent<GspFwWprMeta>,
-    _libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
+    _wpr_meta: Coherent<'a, GspFwWprMeta>,
+    _libos: &'a Coherent<'a, [LibosMemoryRegionInitArgument]>,
 }
 
 impl<'a> FmcBootArgs<'a> {
     /// Builds FMC boot arguments, allocating the DMA-coherent boot parameter
     /// structure that FSP will read.
     pub(crate) fn new(
-        dev: &device::Device<device::Bound>,
+        dev: &'a device::Device<device::Bound>,
         chipset: Chipset,
-        wpr_meta: Coherent<GspFwWprMeta>,
-        libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
+        wpr_meta: Coherent<'a, GspFwWprMeta>,
+        libos: &'a Coherent<'a, [LibosMemoryRegionInitArgument]>,
         resume: bool,
     ) -> Result<Self> {
         let init = GspFmcBootParams::new(wpr_meta.dma_address(), libos.dma_address());
 
         Ok(Self {
             chipset,
-            fmc_boot_params: Coherent::<GspFmcBootParams>::init(dev, GFP_KERNEL, init)?,
+            fmc_boot_params: Coherent::init(dev, GFP_KERNEL, init)?,
             resume,
             _wpr_meta: wpr_meta,
             _libos: libos,
@@ -374,7 +374,7 @@ pub(crate) fn new(
     }
 
     /// Returns the FMC boot parameters allocation.
-    pub(crate) fn boot_params(&self) -> &Coherent<GspFmcBootParams> {
+    pub(crate) fn boot_params(&self) -> &Coherent<'_, GspFmcBootParams> {
         &self.fmc_boot_params
     }
 }
@@ -386,7 +386,7 @@ pub(crate) fn boot_params(&self) -> &Coherent<GspFmcBootParams> {
 /// Chain of Trust boot.
 pub(crate) struct Fsp<'a> {
     falcon: Falcon<'a, FspEngine>,
-    fsp_fw: FspFirmware,
+    fsp_fw: FspFirmware<'a>,
 }
 
 impl<'a> Fsp<'a> {
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index fd1414004dd0..6de75d16488d 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -272,9 +272,9 @@ struct GspResources<'gpu> {
     vgpu: VgpuManager,
     /// GSP runtime data.
     #[pin]
-    gsp: Gsp,
+    gsp: Gsp<'gpu>,
     /// GSP unload firmware bundle, if any.
-    unload_bundle: Option<gsp::UnloadBundle>,
+    unload_bundle: Option<gsp::UnloadBundle<'gpu>>,
 }
 
 /// Structure holding the resources required to operate the GPU.
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 13f361406a6c..25ea43f1cbe9 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -115,11 +115,11 @@ fn init(view: CoherentView<'_, Self>, start: DmaAddress) -> Result<()> {
 /// then pp points to index into the buffer where the next logging entry will
 /// be written. Therefore, the logging data is valid if:
 ///   1 <= pp < sizeof(buffer)/sizeof(u64)
-struct LogBuffer(Coherent<[u8; LOG_BUFFER_SIZE]>);
+struct LogBuffer<'a>(Coherent<'a, [u8; LOG_BUFFER_SIZE]>);
 
-impl LogBuffer {
+impl<'a> LogBuffer<'a> {
     /// Creates a new `LogBuffer` mapped on `dev`.
-    fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
+    fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
         let obj = Self(Coherent::zeroed(dev, GFP_KERNEL)?);
 
         let start_addr = obj.0.dma_address();
@@ -135,33 +135,33 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
     }
 }
 
-struct LogBuffers {
+struct LogBuffers<'a> {
     /// Init log buffer.
-    loginit: LogBuffer,
+    loginit: LogBuffer<'a>,
     /// Interrupts log buffer.
-    logintr: LogBuffer,
+    logintr: LogBuffer<'a>,
     /// RM log buffer.
-    logrm: LogBuffer,
+    logrm: LogBuffer<'a>,
 }
 
 /// GSP runtime data.
 #[pin_data]
-pub(crate) struct Gsp {
+pub(crate) struct Gsp<'gsp> {
     /// Libos arguments.
-    pub(crate) libos: Coherent<[LibosMemoryRegionInitArgument]>,
+    pub(crate) libos: Coherent<'gsp, [LibosMemoryRegionInitArgument]>,
     /// Log buffers, optionally exposed via debugfs.
     #[pin]
-    logs: debugfs::Scope<LogBuffers>,
+    logs: debugfs::Scope<LogBuffers<'gsp>>,
     /// Command queue.
     #[pin]
-    pub(crate) cmdq: Cmdq,
+    pub(crate) cmdq: Cmdq<'gsp>,
     /// RM arguments.
-    rmargs: Coherent<GspArgumentsPadded>,
+    rmargs: Coherent<'gsp, GspArgumentsPadded>,
 }
 
-impl Gsp {
+impl<'gsp> Gsp<'gsp> {
     // Creates an in-place initializer for a `Gsp` manager for `pdev`.
-    pub(crate) fn new(pdev: &pci::Device<device::Bound>) -> impl PinInit<Self, Error> + '_ {
+    pub(crate) fn new(pdev: &'gsp pci::Device<device::Bound>) -> impl PinInit<Self, Error> + 'gsp {
         pin_init::pin_init_scope(move || {
             let dev = pdev.as_ref();
 
@@ -223,4 +223,4 @@ pub(crate) fn get_static_info(&self, bar: Bar0<'_>) -> Result<commands::GetGspSt
 }
 
 /// Opaque bundle required to unload the GSP. Created by [`Gsp::boot`], consumed by [`Gsp::unload`].
-pub(crate) struct UnloadBundle(KBox<dyn hal::UnloadBundle>);
+pub(crate) struct UnloadBundle<'a>(KBox<dyn hal::UnloadBundle + 'a>);
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index e03700ee7bea..e32c9e1f33ab 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -22,7 +22,7 @@
     },
 };
 
-impl super::Gsp {
+impl<'gsp> super::Gsp<'gsp> {
     /// Attempt to boot the GSP.
     ///
     /// This is a GPU-dependent and complex procedure that involves loading firmware files from
@@ -33,8 +33,8 @@ impl super::Gsp {
     /// [`Self::unload`]) returned.
     pub(crate) fn boot(
         self: Pin<&mut Self>,
-        mut ctx: super::GspBootContext<'_, '_>,
-    ) -> Result<Option<super::UnloadBundle>> {
+        mut ctx: super::GspBootContext<'_, 'gsp>,
+    ) -> Result<Option<super::UnloadBundle<'gsp>>> {
         let pdev = ctx.pdev;
         let bar = ctx.bar;
         let chipset = ctx.chipset;
@@ -88,7 +88,7 @@ pub(crate) fn boot(
 
     /// Shut down the GSP and wait until it is offline.
     fn shutdown_gsp(
-        cmdq: &Cmdq,
+        cmdq: &Cmdq<'_>,
         bar: Bar0<'_>,
         gsp_falcon: &Falcon<'_, Gsp>,
         mode: commands::PowerStateLevel,
@@ -113,7 +113,7 @@ fn shutdown_gsp(
     pub(crate) fn unload(
         &self,
         mut ctx: super::GspBootContext<'_, '_>,
-        unload_bundle: Option<super::UnloadBundle>,
+        unload_bundle: Option<super::UnloadBundle<'_>>,
     ) -> Result {
         let dev = ctx.dev();
 
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 6da728201281..fe087ce315b0 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -25,10 +25,7 @@
     new_mutex,
     prelude::*,
     ptr,
-    sync::{
-        aref::ARef,
-        Mutex, //
-    },
+    sync::Mutex,
     time::Delta,
     transmute::{
         AsBytes,
@@ -230,19 +227,19 @@ unsafe impl FromBytes for GspMem {}
 ///   pointer and the GSP read pointer. This region is returned by [`Self::driver_write_area`].
 /// * The driver owns (i.e. can read from) the part of the GSP message queue between the CPU read
 ///   pointer and the GSP write pointer. This region is returned by [`Self::driver_read_area`].
-struct DmaGspMem(Coherent<GspMem>);
+struct DmaGspMem<'a>(Coherent<'a, GspMem>);
 
-impl DmaGspMem {
+impl<'a> DmaGspMem<'a> {
     /// Allocate a new instance and map it for `dev`.
-    fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
+    fn new(dev: &'a device::Device<device::Bound>) -> Result<Self> {
         const MSGQ_SIZE: u32 = num::usize_into_u32::<{ size_of::<Msgq>() }>();
         const RX_HDR_OFF: u32 = num::usize_into_u32::<{ mem::offset_of!(Msgq, rx) }>();
 
-        let mut gsp_mem = CoherentBox::<GspMem>::zeroed(dev, GFP_KERNEL)?;
+        let mut gsp_mem = CoherentBox::<'_, GspMem>::zeroed(dev, GFP_KERNEL)?;
         gsp_mem.cpuq.tx = MsgqTxHeader::new(MSGQ_SIZE, RX_HDR_OFF, MSGQ_NUM_PAGES);
         gsp_mem.cpuq.rx = MsgqRxHeader::new();
 
-        let gsp_mem: Coherent<_> = gsp_mem.into();
+        let gsp_mem: Coherent<'_, _> = gsp_mem.into();
         PteArray::init(io_project!(gsp_mem, .ptes), gsp_mem.dma_address())?;
 
         Ok(Self(gsp_mem))
@@ -483,15 +480,15 @@ struct GspMessage<'a> {
 /// Provides the ability to send commands and receive messages from the GSP using a shared memory
 /// area.
 #[pin_data]
-pub(crate) struct Cmdq {
+pub(crate) struct Cmdq<'cmdq> {
     /// Inner mutex-protected state.
     #[pin]
-    inner: Mutex<CmdqInner>,
+    inner: Mutex<CmdqInner<'cmdq>>,
     /// DMA address of the command queue's shared memory region.
     pub(super) dma_addr: DmaAddress,
 }
 
-impl Cmdq {
+impl<'cmdq> Cmdq<'cmdq> {
     /// Offset of the data after the PTEs.
     const POST_PTE_OFFSET: usize = core::mem::offset_of!(GspMem, cpuq);
 
@@ -512,14 +509,16 @@ impl Cmdq {
     pub(super) const RECEIVE_TIMEOUT: Delta = Delta::from_secs(5);
 
     /// Creates a new command queue for `dev`.
-    pub(crate) fn new(dev: &device::Device<device::Bound>) -> impl PinInit<Self, Error> + '_ {
+    pub(crate) fn new(
+        dev: &'cmdq device::Device<device::Bound>,
+    ) -> impl PinInit<Self, Error> + 'cmdq {
         pin_init_scope(move || {
             let gsp_mem = DmaGspMem::new(dev)?;
 
             Ok(try_pin_init!(Self {
                 dma_addr: gsp_mem.0.dma_address(),
                 inner <- new_mutex!(CmdqInner {
-                    dev: dev.into(),
+                    dev,
                     gsp_mem,
                     seq: 0,
                 }),
@@ -610,16 +609,16 @@ pub(crate) fn receive_msg<M: MessageFromGsp>(&self, timeout: Delta) -> Result<M>
 }
 
 /// Inner mutex protected state of [`Cmdq`].
-struct CmdqInner {
+struct CmdqInner<'a> {
     /// Device this command queue belongs to.
-    dev: ARef<device::Device>,
+    dev: &'a device::Device,
     /// Current command sequence number.
     seq: u32,
     /// Memory area shared with the GSP for communicating commands and messages.
-    gsp_mem: DmaGspMem,
+    gsp_mem: DmaGspMem<'a>,
 }
 
-impl CmdqInner {
+impl CmdqInner<'_> {
     /// Timeout for waiting for space on the command queue.
     const ALLOCATE_TIMEOUT: Delta = Delta::from_secs(1);
 
diff --git a/drivers/gpu/nova-core/gsp/commands.rs b/drivers/gpu/nova-core/gsp/commands.rs
index ffc25fd8c47b..69d7d41c1791 100644
--- a/drivers/gpu/nova-core/gsp/commands.rs
+++ b/drivers/gpu/nova-core/gsp/commands.rs
@@ -187,7 +187,7 @@ fn read(
 }
 
 /// Waits for GSP initialization to complete.
-pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq) -> Result {
+pub(crate) fn wait_gsp_init_done(cmdq: &Cmdq<'_>) -> Result {
     loop {
         match cmdq.receive_msg::<GspInitDone>(Cmdq::RECEIVE_TIMEOUT) {
             Ok(_) => break Ok(()),
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 05f54fee6186..8778c4bf79c0 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -179,7 +179,7 @@ impl GspFwWprMeta {
     /// Returns an initializer for a `GspFwWprMeta` suitable for booting `gsp_firmware` using the
     /// framebuffer ranges `ranges`.
     pub(crate) fn from_ranges<'a>(
-        gsp_firmware: &'a GspFirmware,
+        gsp_firmware: &'a GspFirmware<'_>,
         ranges: &'a FbRanges,
     ) -> impl Init<Self> + 'a {
         let init_inner = init!(bindings::GspFwWprMeta {
@@ -231,7 +231,7 @@ pub(crate) fn from_ranges<'a>(
     ///
     /// The region offsets are left at zero: the ACR ucode computes them when it sets up WPR2.
     pub(crate) fn from_sizes<'a>(
-        gsp_firmware: &'a GspFirmware,
+        gsp_firmware: &'a GspFirmware<'_>,
         sizes: &'a FbSizes,
     ) -> impl Init<Self> + 'a {
         /// VGA workspace size to reserve at the end of the framebuffer, in bytes.
@@ -665,7 +665,7 @@ unsafe impl FromBytes for LibosMemoryRegionInitArgument {}
 impl LibosMemoryRegionInitArgument {
     pub(crate) fn new<'a, A: AsBytes + FromBytes + KnownSize + ?Sized>(
         name: &'static str,
-        obj: &'a Coherent<A>,
+        obj: &'a Coherent<'_, A>,
     ) -> impl Init<Self> + 'a {
         /// Generates the `ID8` identifier required for some GSP objects.
         fn id8(name: &str) -> u64 {
@@ -897,7 +897,7 @@ pub(crate) struct GspArgumentsCached {
 
 impl GspArgumentsCached {
     /// Creates the arguments for starting the GSP up using `cmdq` as its command queue.
-    pub(crate) fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
+    pub(crate) fn new<'a, 'b>(cmdq: &'a Cmdq<'b>) -> impl Init<Self> + use<'a, 'b> {
         let init_inner = init!(bindings::GSP_ARGUMENTS_CACHED {
             messageQueueInitArguments <- MessageQueueInitArguments::new(cmdq),
             bDmemStack: 1,
@@ -924,7 +924,7 @@ pub(crate) struct GspArgumentsPadded {
 }
 
 impl GspArgumentsPadded {
-    pub(crate) fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
+    pub(crate) fn new<'a, 'b>(cmdq: &'a Cmdq<'b>) -> impl Init<Self> + use<'a, 'b> {
         init!(GspArgumentsPadded {
             inner <- GspArgumentsCached::new(cmdq),
             ..Zeroable::init_zeroed()
@@ -944,7 +944,7 @@ unsafe impl FromBytes for GspArgumentsPadded {}
 
 impl MessageQueueInitArguments {
     /// Creates a new init arguments structure for `cmdq`.
-    fn new(cmdq: &Cmdq) -> impl Init<Self> + '_ {
+    fn new<'a, 'b>(cmdq: &'a Cmdq<'b>) -> impl Init<Self> + use<'a, 'b> {
         init!(MessageQueueInitArguments {
             sharedMemPhysAddr: cmdq.dma_addr,
             pageTableEntryCount: num::usize_into_u32::<{ Cmdq::NUM_PTES }>(),
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 5850fa0fe0e9..d8329f6fcc65 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -35,12 +35,12 @@ pub(super) trait GspHal: Send {
     ///
     /// Upon success, returns the [`crate::gsp::UnloadBundle`] to use with [`Gsp::unload`], if one
     /// could be created.
-    fn boot(
+    fn boot<'gpu>(
         &self,
-        gsp: &Gsp,
-        ctx: &mut GspBootContext<'_, '_>,
-        gsp_fw: &GspFirmware,
-    ) -> Result<Option<crate::gsp::UnloadBundle>>;
+        gsp: &Gsp<'gpu>,
+        ctx: &mut GspBootContext<'_, 'gpu>,
+        gsp_fw: &GspFirmware<'gpu>,
+    ) -> Result<Option<super::UnloadBundle<'gpu>>>;
 
     /// Performs HAL-specific post-GSP boot tasks.
     ///
@@ -48,9 +48,9 @@ fn boot(
     /// after the initialization commands have been pushed onto its queue.
     fn post_boot(
         &self,
-        _gsp: &Gsp,
+        _gsp: &Gsp<'_>,
         _ctx: &mut GspBootContext<'_, '_>,
-        _gsp_fw: &GspFirmware,
+        _gsp_fw: &GspFirmware<'_>,
     ) -> Result {
         Ok(())
     }
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index e283429a95dd..91201b51030e 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -58,7 +58,7 @@ fn combined_addr(&self) -> u64 {
     fn lockdown_released_or_error(
         &self,
         gsp_falcon: &Falcon<'_, GspEngine>,
-        fmc_boot_params: &Coherent<GspFmcBootParams>,
+        fmc_boot_params: &Coherent<'_, GspFmcBootParams>,
     ) -> bool {
         // GSP-FMC normally clears the boot parameters address from the mailboxes early during
         // boot. If the address is still there, keep polling rather than treating it as an error.
@@ -75,7 +75,7 @@ fn lockdown_released_or_error(
 fn wait_for_gsp_lockdown_release(
     dev: &device::Device<device::Bound>,
     gsp_falcon: &Falcon<'_, GspEngine>,
-    fmc_boot_params: &Coherent<GspFmcBootParams>,
+    fmc_boot_params: &Coherent<'_, GspFmcBootParams>,
 ) -> Result {
     dev_dbg!(dev, "Waiting for GSP lockdown release\n");
 
@@ -141,12 +141,12 @@ impl GspHal for Gh100 {
     ///
     /// This path uses FSP to establish a chain of trust and boot GSP-FMC. FSP handles
     /// the GSP boot internally - no manual GSP reset/boot is needed.
-    fn boot(
+    fn boot<'gpu>(
         &self,
-        gsp: &Gsp,
-        ctx: &mut GspBootContext<'_, '_>,
-        gsp_fw: &GspFirmware,
-    ) -> Result<Option<crate::gsp::UnloadBundle>> {
+        gsp: &Gsp<'gpu>,
+        ctx: &mut GspBootContext<'_, 'gpu>,
+        gsp_fw: &GspFirmware<'gpu>,
+    ) -> Result<Option<crate::gsp::UnloadBundle<'gpu>>> {
         let dev = ctx.dev();
         let chipset = ctx.chipset;
         let gsp_falcon = ctx.gsp_falcon;
@@ -159,7 +159,7 @@ fn boot(
         let args = FmcBootArgs::new(dev, chipset, wpr_meta, &gsp.libos, false)?;
 
         let unload_bundle = crate::gsp::UnloadBundle(
-            KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle>
+            KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBundle + 'gpu>
         );
 
         // Wait for the GSP RISC-V core to halt in case of error. We create this guard after `args`
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index a5c0ca355493..f315013cff86 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -52,12 +52,12 @@
 //
 // Since there are two variants of the prepared firmware (with and without a bootloader), this type
 // abstracts the difference.
-enum FwsecUnloadFirmware {
+enum FwsecUnloadFirmware<'a> {
     WithoutBl(FwsecFirmware),
-    WithBl(FwsecFirmwareWithBl),
+    WithBl(FwsecFirmwareWithBl<'a>),
 }
 
-impl FwsecUnloadFirmware {
+impl FwsecUnloadFirmware<'_> {
     /// Runs the FWSEC SB firmware.
     fn run(
         &self,
@@ -74,12 +74,12 @@ fn run(
 
 // Contains the firmware required to fully reset GSP on chipsets where the GSP is started using
 // FWSEC/Booter.
-struct Sec2UnloadBundle {
-    fwsec_sb: FwsecUnloadFirmware,
+struct Sec2UnloadBundle<'a> {
+    fwsec_sb: FwsecUnloadFirmware<'a>,
     booter_unloader: BooterFirmware,
 }
 
-impl UnloadBundle for Sec2UnloadBundle {
+impl UnloadBundle for Sec2UnloadBundle<'_> {
     fn run(&self, ctx: &mut GspBootContext<'_, '_>) -> Result {
         let dev = ctx.dev();
         let bar = ctx.bar;
@@ -213,14 +213,14 @@ fn run_fwsec_frts(
     }
 
     /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
-    fn build_unload_bundle(
+    fn build_unload_bundle<'gpu>(
         &self,
-        dev: &device::Device<device::Bound>,
+        dev: &'gpu device::Device<device::Bound>,
         chipset: Chipset,
         bios: &Vbios,
         gsp_falcon: &Falcon<'_, GspEngine>,
         sec2_falcon: &Falcon<'_, Sec2>,
-    ) -> Result<crate::gsp::UnloadBundle> {
+    ) -> Result<crate::gsp::UnloadBundle<'gpu>> {
         // Load the FWSEC SB firmware, as well as its bootloader if required.
         let fwsec_sb = FwsecFirmware::new(dev, gsp_falcon, bios, FwsecCommand::Sb)?;
         let fwsec_sb = if self.needs_fwsec_bootloader {
@@ -241,18 +241,18 @@ fn build_unload_bundle(
             },
             GFP_KERNEL,
         )
-        .map(|b| crate::gsp::UnloadBundle(b))
+        .map(|b| crate::gsp::UnloadBundle(b as KBox<dyn UnloadBundle + 'gpu>))
         .map_err(Into::into)
     }
 }
 
 impl GspHal for Tu102 {
-    fn boot(
+    fn boot<'gpu>(
         &self,
-        gsp: &Gsp,
-        ctx: &mut GspBootContext<'_, '_>,
-        gsp_fw: &GspFirmware,
-    ) -> Result<Option<crate::gsp::UnloadBundle>> {
+        gsp: &Gsp<'gpu>,
+        ctx: &mut GspBootContext<'_, 'gpu>,
+        gsp_fw: &GspFirmware<'gpu>,
+    ) -> Result<Option<crate::gsp::UnloadBundle<'gpu>>> {
         let dev = ctx.dev();
         let bar = ctx.bar;
         let chipset = ctx.chipset;
@@ -317,9 +317,9 @@ fn boot(
 
     fn post_boot(
         &self,
-        gsp: &Gsp,
+        gsp: &Gsp<'_>,
         ctx: &mut GspBootContext<'_, '_>,
-        gsp_fw: &GspFirmware,
+        gsp_fw: &GspFirmware<'_>,
     ) -> Result {
         GspSequencer::run(&gsp.cmdq, ctx, &gsp.libos, gsp_fw.bootloader.app_version)?;
 
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index bcad1421953a..dae34c11eb05 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -138,7 +138,7 @@ pub(crate) struct GspSequencer<'a> {
     /// GSP falcon for core operations.
     gsp_falcon: &'a Falcon<'a, Gsp>,
     /// LibOS memory region init arguments.
-    libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
+    libos: &'a Coherent<'a, [LibosMemoryRegionInitArgument]>,
     /// Bootloader application version.
     bootloader_app_version: u32,
     /// Device for logging.
@@ -338,9 +338,9 @@ fn next(&mut self) -> Option<Self::Item> {
 
 impl<'a> GspSequencer<'a> {
     pub(crate) fn run(
-        cmdq: &Cmdq,
+        cmdq: &Cmdq<'_>,
         ctx: &'a GspBootContext<'_, '_>,
-        libos: &'a Coherent<[LibosMemoryRegionInitArgument]>,
+        libos: &'a Coherent<'a, [LibosMemoryRegionInitArgument]>,
         bootloader_app_version: u32,
     ) -> Result {
         let seq_info = loop {
diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
index 79f453e9ec0b..4ce914b7d1da 100644
--- a/rust/kernel/dma.rs
+++ b/rust/kernel/dma.rs
@@ -24,7 +24,6 @@
     },
     prelude::*,
     ptr::KnownSize,
-    sync::aref::ARef,
     transmute::{
         AsBytes,
         FromBytes, //
@@ -223,7 +222,7 @@ pub const fn value(&self) -> u64 {
 ///
 /// # fn test(dev: &Device<Bound>) -> Result {
 /// let attribs = DMA_ATTR_FORCE_CONTIGUOUS | DMA_ATTR_NO_WARN;
-/// let c: Coherent<[u64]> =
+/// let c: Coherent<'_, [u64]> =
 ///     Coherent::zeroed_slice_with_attrs(dev, 4, GFP_KERNEL, attribs)?;
 /// # Ok::<(), Error>(()) }
 /// ```
@@ -390,9 +389,9 @@ fn from(direction: DataDirection) -> Self {
 /// };
 ///
 /// # fn test(dev: &Device<Bound>) -> Result {
-/// let mut dmem: CoherentBox<u64> = CoherentBox::zeroed(dev, GFP_KERNEL)?;
+/// let mut dmem: CoherentBox<'_, u64> = CoherentBox::zeroed(dev, GFP_KERNEL)?;
 /// *dmem = 42;
-/// let dmem: Coherent<u64> = dmem.into();
+/// let dmem: Coherent<'_, u64> = dmem.into();
 /// # Ok::<(), Error>(()) }
 /// ```
 ///
@@ -410,18 +409,18 @@ fn from(direction: DataDirection) -> Self {
 /// };
 ///
 /// # fn test(dev: &Device<Bound>) -> Result {
-/// let mut dmem: CoherentBox<[u64]> = CoherentBox::zeroed_slice(dev, 4, GFP_KERNEL)?;
+/// let mut dmem: CoherentBox<'_, [u64]> = CoherentBox::zeroed_slice(dev, 4, GFP_KERNEL)?;
 /// dmem.fill(42);
-/// let dmem: Coherent<[u64]> = dmem.into();
+/// let dmem: Coherent<'_, [u64]> = dmem.into();
 /// # Ok::<(), Error>(()) }
 /// ```
-pub struct CoherentBox<T: KnownSize + ?Sized>(Coherent<T>);
+pub struct CoherentBox<'a, T: KnownSize + ?Sized>(Coherent<'a, T>);
 
-impl<T: AsBytes + FromBytes> CoherentBox<[T]> {
+impl<'a, T: AsBytes + FromBytes> CoherentBox<'a, [T]> {
     /// [`CoherentBox`] variant of [`Coherent::zeroed_slice_with_attrs`].
     #[inline]
     pub fn zeroed_slice_with_attrs(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -432,7 +431,7 @@ pub fn zeroed_slice_with_attrs(
     /// Same as [CoherentBox::zeroed_slice_with_attrs], but with `dma::Attrs(0)`.
     #[inline]
     pub fn zeroed_slice(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         count: usize,
         gfp_flags: kernel::alloc::Flags,
     ) -> Result<Self> {
@@ -480,14 +479,14 @@ pub fn init_at<E>(&mut self, i: usize, init: impl Init<T, E>) -> Result
     ///
     /// # fn test(dev: &Device<Bound>) -> Result {
     /// let data = [0u8, 1u8, 2u8, 3u8];
-    /// let c: CoherentBox<[u8]> =
+    /// let c: CoherentBox<'_, [u8]> =
     ///     CoherentBox::from_slice_with_attrs(dev, &data, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
     ///
     /// assert_eq!(c.deref(), &data);
     /// # Ok::<(), Error>(()) }
     /// ```
     pub fn from_slice_with_attrs(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         data: &[T],
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
@@ -512,7 +511,7 @@ pub fn from_slice_with_attrs(
     /// `dma_attrs` is 0 by default.
     #[inline]
     pub fn from_slice(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         data: &[T],
         gfp_flags: kernel::alloc::Flags,
     ) -> Result<Self>
@@ -523,11 +522,11 @@ pub fn from_slice(
     }
 }
 
-impl<T: AsBytes + FromBytes> CoherentBox<T> {
+impl<'a, T: AsBytes + FromBytes> CoherentBox<'a, T> {
     /// Same as [`CoherentBox::zeroed_slice_with_attrs`], but for a single element.
     #[inline]
     pub fn zeroed_with_attrs(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
     ) -> Result<Self> {
@@ -536,12 +535,12 @@ pub fn zeroed_with_attrs(
 
     /// Same as [`CoherentBox::zeroed_slice`], but for a single element.
     #[inline]
-    pub fn zeroed(dev: &device::Device<Bound>, gfp_flags: kernel::alloc::Flags) -> Result<Self> {
+    pub fn zeroed(dev: &'a device::Device<Bound>, gfp_flags: kernel::alloc::Flags) -> Result<Self> {
         Self::zeroed_with_attrs(dev, gfp_flags, Attrs(0))
     }
 }
 
-impl<T: KnownSize + ?Sized> Deref for CoherentBox<T> {
+impl<T: KnownSize + ?Sized> Deref for CoherentBox<'_, T> {
     type Target = T;
 
     #[inline]
@@ -554,7 +553,7 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<T: AsBytes + FromBytes + KnownSize + ?Sized> DerefMut for CoherentBox<T> {
+impl<T: AsBytes + FromBytes + KnownSize + ?Sized> DerefMut for CoherentBox<'_, T> {
     #[inline]
     fn deref_mut(&mut self) -> &mut Self::Target {
         // SAFETY:
@@ -565,9 +564,9 @@ fn deref_mut(&mut self) -> &mut Self::Target {
     }
 }
 
-impl<T: AsBytes + FromBytes + KnownSize + ?Sized> From<CoherentBox<T>> for Coherent<T> {
+impl<'a, T: AsBytes + FromBytes + KnownSize + ?Sized> From<CoherentBox<'a, T>> for Coherent<'a, T> {
     #[inline]
-    fn from(value: CoherentBox<T>) -> Self {
+    fn from(value: CoherentBox<'a, T>) -> Self {
         value.0
     }
 }
@@ -588,26 +587,20 @@ fn from(value: CoherentBox<T>) -> Self {
 ///   to an allocated region of coherent memory and `dma_addr` is the DMA address base of the
 ///   region.
 /// - The size in bytes of the allocation is equal to size information via pointer.
-// TODO
 //
-// DMA allocations potentially carry device resources (e.g.IOMMU mappings), hence for soundness
-// reasons DMA allocation would need to be embedded in a `Devres` container, in order to ensure
-// that device resources can never survive device unbind.
-//
-// However, it is neither desirable nor necessary to protect the allocated memory of the DMA
-// allocation from surviving device unbind; it would require RCU read side critical sections to
-// access the memory, which may require subsequent unnecessary copies.
-//
-// Hence, find a way to revoke the device resources of a `Coherent`, but not the
-// entire `Coherent` including the allocated memory itself.
-pub struct Coherent<T: KnownSize + ?Sized> {
-    dev: ARef<device::Device>,
+// The lifetime parameter ties DMA allocations to the device's bound scope, ensuring they are freed
+// before the device is unbound under normal circumstances. However, if a `Coherent` is leaked (e.g.
+// via `mem::forget`), device resources such as IOMMU mappings will not be released.  Making all
+// constructors `unsafe` to prevent this is considered too restrictive for the common case; this
+// soundness hole is accepted for now.
+pub struct Coherent<'a, T: KnownSize + ?Sized> {
+    dev: &'a device::Device<Bound>,
     dma_addr: DmaAddress,
     cpu_addr: NonNull<T>,
     dma_attrs: Attrs,
 }
 
-impl<T: KnownSize + ?Sized> Coherent<T> {
+impl<T: KnownSize + ?Sized> Coherent<'_, T> {
     /// Returns the size in bytes of this allocation.
     #[inline]
     pub fn size(&self) -> usize {
@@ -663,10 +656,10 @@ pub unsafe fn as_mut(&self) -> &mut T {
     }
 }
 
-impl<T: AsBytes + FromBytes> Coherent<T> {
+impl<'a, T: AsBytes + FromBytes> Coherent<'a, T> {
     /// Allocates a region of `T` of coherent memory.
     fn alloc_with_attrs(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
     ) -> Result<Self> {
@@ -692,9 +685,9 @@ fn alloc_with_attrs(
         // INVARIANT:
         // - We just successfully allocated a coherent region which is adequately sized for `T`,
         //   hence the cpu address is valid.
-        // - We also hold a refcounted reference to the device.
+        // - `dev` is a valid reference to a bound device that outlives this allocation.
         Ok(Self {
-            dev: dev.into(),
+            dev,
             dma_addr,
             cpu_addr,
             dma_attrs,
@@ -716,13 +709,13 @@ fn alloc_with_attrs(
     /// };
     ///
     /// # fn test(dev: &Device<Bound>) -> Result {
-    /// let c: Coherent<[u64; 4]> =
+    /// let c: Coherent<'_, [u64; 4]> =
     ///     Coherent::zeroed_with_attrs(dev, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
     /// # Ok::<(), Error>(()) }
     /// ```
     #[inline]
     pub fn zeroed_with_attrs(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
     ) -> Result<Self> {
@@ -732,14 +725,14 @@ pub fn zeroed_with_attrs(
     /// Performs the same functionality as [`Coherent::zeroed_with_attrs`], except the
     /// `dma_attrs` is 0 by default.
     #[inline]
-    pub fn zeroed(dev: &device::Device<Bound>, gfp_flags: kernel::alloc::Flags) -> Result<Self> {
+    pub fn zeroed(dev: &'a device::Device<Bound>, gfp_flags: kernel::alloc::Flags) -> Result<Self> {
         Self::zeroed_with_attrs(dev, gfp_flags, Attrs(0))
     }
 
     /// Same as [`Coherent::zeroed_with_attrs`], but instead of a zero-initialization the memory is
     /// initialized with `init`.
     pub fn init_with_attrs<E>(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
         init: impl Init<T, E>,
@@ -764,7 +757,7 @@ pub fn init_with_attrs<E>(
     /// with `init`.
     #[inline]
     pub fn init<E>(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         gfp_flags: kernel::alloc::Flags,
         init: impl Init<T, E>,
     ) -> Result<Self>
@@ -776,11 +769,11 @@ pub fn init<E>(
 
     /// Allocates a region of `[T; len]` of coherent memory.
     fn alloc_slice_with_attrs(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         len: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
-    ) -> Result<Coherent<[T]>> {
+    ) -> Result<Coherent<'a, [T]>> {
         const {
             assert!(
                 core::mem::size_of::<T>() > 0,
@@ -809,9 +802,9 @@ fn alloc_slice_with_attrs(
         // INVARIANT:
         // - We just successfully allocated a coherent region which is adequately sized for
         //   `[T; len]`, hence the cpu address is valid.
-        // - We also hold a refcounted reference to the device.
+        // - `dev` is a valid reference to a bound device that outlives this allocation.
         Ok(Coherent {
-            dev: dev.into(),
+            dev,
             dma_addr,
             cpu_addr,
             dma_attrs,
@@ -836,17 +829,17 @@ fn alloc_slice_with_attrs(
     /// };
     ///
     /// # fn test(dev: &Device<Bound>) -> Result {
-    /// let c: Coherent<[u64]> =
+    /// let c: Coherent<'_, [u64]> =
     ///     Coherent::zeroed_slice_with_attrs(dev, 4, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
     /// # Ok::<(), Error>(()) }
     /// ```
     #[inline]
     pub fn zeroed_slice_with_attrs(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         len: usize,
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
-    ) -> Result<Coherent<[T]>> {
+    ) -> Result<Coherent<'a, [T]>> {
         Coherent::alloc_slice_with_attrs(dev, len, gfp_flags | __GFP_ZERO, dma_attrs)
     }
 
@@ -854,10 +847,10 @@ pub fn zeroed_slice_with_attrs(
     /// `dma_attrs` is 0 by default.
     #[inline]
     pub fn zeroed_slice(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         len: usize,
         gfp_flags: kernel::alloc::Flags,
-    ) -> Result<Coherent<[T]>> {
+    ) -> Result<Coherent<'a, [T]>> {
         Self::zeroed_slice_with_attrs(dev, len, gfp_flags, Attrs(0))
     }
 
@@ -876,18 +869,18 @@ pub fn zeroed_slice(
     /// # fn test(dev: &Device<Bound>) -> Result {
     /// let data = [0u8, 1u8, 2u8, 3u8];
     /// // `c` has the same content as `data`.
-    /// let c: Coherent<[u8]> =
+    /// let c: Coherent<'_, [u8]> =
     ///     Coherent::from_slice_with_attrs(dev, &data, GFP_KERNEL, DMA_ATTR_NO_WARN)?;
     ///
     /// # Ok::<(), Error>(()) }
     /// ```
     #[inline]
     pub fn from_slice_with_attrs(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         data: &[T],
         gfp_flags: kernel::alloc::Flags,
         dma_attrs: Attrs,
-    ) -> Result<Coherent<[T]>>
+    ) -> Result<Coherent<'a, [T]>>
     where
         T: Copy,
     {
@@ -898,10 +891,10 @@ pub fn from_slice_with_attrs(
     /// `dma_attrs` is 0 by default.
     #[inline]
     pub fn from_slice(
-        dev: &device::Device<Bound>,
+        dev: &'a device::Device<Bound>,
         data: &[T],
         gfp_flags: kernel::alloc::Flags,
-    ) -> Result<Coherent<[T]>>
+    ) -> Result<Coherent<'a, [T]>>
     where
         T: Copy,
     {
@@ -909,7 +902,7 @@ pub fn from_slice(
     }
 }
 
-impl<T> Coherent<[T]> {
+impl<T> Coherent<'_, [T]> {
     /// Returns the number of elements `T` in this allocation.
     ///
     /// Note that this is not the size of the allocation in bytes, which is provided by
@@ -922,10 +915,10 @@ pub fn len(&self) -> usize {
 }
 
 /// Note that the device configured to do DMA must be halted before this object is dropped.
-impl<T: KnownSize + ?Sized> Drop for Coherent<T> {
+impl<T: KnownSize + ?Sized> Drop for Coherent<'_, T> {
     fn drop(&mut self) {
         let size = T::size(self.cpu_addr.as_ptr());
-        // SAFETY: Device pointer is guaranteed as valid by the type invariant on `Device`.
+        // SAFETY: Device pointer is guaranteed as valid by the lifetime of this `Coherent`.
         // The cpu address, and the dma address are valid due to the type invariants on
         // `Coherent`.
         unsafe {
@@ -942,15 +935,15 @@ fn drop(&mut self) {
 
 // SAFETY: It is safe to send a `Coherent` to another thread if `T`
 // can be sent to another thread.
-unsafe impl<T: KnownSize + Send + ?Sized> Send for Coherent<T> {}
+unsafe impl<T: KnownSize + Send + ?Sized> Send for Coherent<'_, T> {}
 
 // SAFETY: Sharing `&Coherent` across threads is safe if `T` is `Sync`, because all
 // methods that access the buffer contents (`field_read`, `field_write`, `as_slice`,
 // `as_slice_mut`) are `unsafe`, and callers are responsible for ensuring no data races occur.
 // The safe methods only return metadata or raw pointers whose use requires `unsafe`.
-unsafe impl<T: KnownSize + ?Sized + AsBytes + FromBytes + Sync> Sync for Coherent<T> {}
+unsafe impl<T: KnownSize + ?Sized + AsBytes + FromBytes + Sync> Sync for Coherent<'_, T> {}
 
-impl<T: KnownSize + AsBytes + ?Sized> debugfs::BinaryWriter for Coherent<T> {
+impl<T: KnownSize + AsBytes + ?Sized> debugfs::BinaryWriter for Coherent<'_, T> {
     fn write_to_slice(
         &self,
         writer: &mut UserSliceWriter,
@@ -1236,7 +1229,7 @@ fn as_view(self) -> CoherentView<'a, Self::Target> {
     }
 }
 
-impl<'a, T: ?Sized + KnownSize> IoBase<'a> for &'a Coherent<T> {
+impl<'a, T: ?Sized + KnownSize> IoBase<'a> for &'a Coherent<'_, T> {
     type Backend = CoherentIoBackend;
     type Target = T;
 
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 5f6c4d7a1a51..f09078228c53 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -520,14 +520,14 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
     ///
     /// fn copy_dma_to_user(
     ///     mut writer: UserSliceWriter,
-    ///     alloc: &Coherent<[u8]>,
+    ///     alloc: &Coherent<'_, [u8]>,
     /// ) -> Result {
     ///     writer.write_dma(alloc, 0, 256)
     /// }
     /// ```
     pub fn write_dma<T: KnownSize + AsBytes + ?Sized>(
         &mut self,
-        alloc: &Coherent<T>,
+        alloc: &Coherent<'_, T>,
         offset: usize,
         count: usize,
     ) -> Result {
diff --git a/samples/rust/rust_dma.rs b/samples/rust/rust_dma.rs
index 0fac9d4ae566..ffb693544673 100644
--- a/samples/rust/rust_dma.rs
+++ b/samples/rust/rust_dma.rs
@@ -34,7 +34,7 @@
 #[pin_data(PinnedDrop)]
 struct DmaSampleData<'bound> {
     pdev: &'bound pci::Device<Bound>,
-    ca: Coherent<[MyStruct]>,
+    ca: Coherent<'bound, [MyStruct]>,
     #[pin]
     sgt: SGTable<Owned<VVec<u8>>>,
 }
@@ -86,7 +86,7 @@ fn probe<'bound>(
             // SAFETY: There are no concurrent calls to DMA allocation and mapping primitives.
             unsafe { pdev.dma_set_mask_and_coherent(mask)? };
 
-            let ca: Coherent<[MyStruct]> =
+            let ca: Coherent<'_, [MyStruct]> =
                 Coherent::zeroed_slice(pdev.as_ref(), TEST_VALUES.len(), GFP_KERNEL)?;
 
             for (i, value) in TEST_VALUES.into_iter().enumerate() {
-- 
2.55.0

