Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1031CD6E60
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26F6F10F3AE;
	Tue,  2 Jun 2026 17:04:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Teeq5xrp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B377B10F3D4
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 17:04:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7BC55442DB;
 Tue,  2 Jun 2026 17:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE361F00893;
 Tue,  2 Jun 2026 17:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780419880;
 bh=EzspvoAQSSDCqxg+UyL/aDpReFYUPBMdP1aaWFMsVUQ=;
 h=From:To:Cc:Subject:Date;
 b=Teeq5xrpvQgiBSbrqv1oIkUQSZTCUtlhLCarH4f34KVE8nIgqc21aRsiDU65wy3m1
 hVOc7i8u+GneV4e/Uwu2l5CiyG5e1CqV2qTkWTCnsQItVxgeYVFq07BhIaHij6miLs
 JA8IDM22/gu9ZRlwzNWIV73hqDEwVj3c1VsDxTA+yPQNiaekJuRgxcRJjPE6LlF1Eo
 p89lVC8WzZEnJ3tYejCu/vvCxnPun+04YqJp9L2qbNgFSHivp1y/jfeiOr2T8HLVDE
 zcMH3dsRzt3BraDGt8NSsLVtyAHEoL5bDRO33KX4+6fqBvnIJQHwz+JJCMtdPNf31Q
 ah82tW7N5/E4A==
From: Gary Guo <gary@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: nova-core: move lifetime to `Bar0`
Date: Tue,  2 Jun 2026 18:04:07 +0100
Message-ID: <20260602170416.2268531-1-gary@kernel.org>
X-Mailer: git-send-email 2.54.0
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

From: Gary Guo <gary@garyguo.net>

Currently Nova code uses `&'a Bar0` a lot. This is `&'a Mmio`, where `Mmio`
represents an owned MMIO region; this type only exists as a target for
`Deref` so `Bar` and `IoMem` can share code and should be avoided to be
named directly. The upcoming I/O projection series would make `Io` trait
much simpler to implement, and thuis the owned MMIO type would be removed
in favour of direct `Io` implementation on `Bar` and `IoMem`.

Add lifetime parameter to `Bar0<'a>` and change it to be alias of `&'a
pci::Bar<'a, ..>`. This also prepares Nova core so that when I/O projection
series land, this could be changed to using a MMIO view type directly which
avoids double indirection.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/driver.rs               |  2 +-
 drivers/gpu/nova-core/falcon.rs               | 44 +++++++++++--------
 drivers/gpu/nova-core/falcon/gsp.rs           |  4 +-
 drivers/gpu/nova-core/falcon/hal.rs           | 12 ++---
 drivers/gpu/nova-core/falcon/hal/ga102.rs     | 18 ++++----
 drivers/gpu/nova-core/falcon/hal/tu102.rs     | 12 ++---
 drivers/gpu/nova-core/fb.rs                   |  6 +--
 drivers/gpu/nova-core/fb/hal.rs               |  8 ++--
 drivers/gpu/nova-core/fb/hal/ga100.rs         | 14 +++---
 drivers/gpu/nova-core/fb/hal/ga102.rs         | 10 ++---
 drivers/gpu/nova-core/fb/hal/gb100.rs         | 12 ++---
 drivers/gpu/nova-core/fb/hal/gb202.rs         | 12 ++---
 drivers/gpu/nova-core/fb/hal/gh100.rs         |  8 ++--
 drivers/gpu/nova-core/fb/hal/tu102.rs         | 16 +++----
 drivers/gpu/nova-core/firmware/booter.rs      |  4 +-
 drivers/gpu/nova-core/firmware/fwsec.rs       |  4 +-
 .../nova-core/firmware/fwsec/bootloader.rs    |  2 +-
 drivers/gpu/nova-core/fsp.rs                  |  2 +-
 drivers/gpu/nova-core/fsp/hal.rs              |  2 +-
 drivers/gpu/nova-core/fsp/hal/gb202.rs        |  2 +-
 drivers/gpu/nova-core/fsp/hal/gh100.rs        |  2 +-
 drivers/gpu/nova-core/gpu.rs                  |  9 ++--
 drivers/gpu/nova-core/gpu/hal.rs              |  2 +-
 drivers/gpu/nova-core/gpu/hal/gh100.rs        |  2 +-
 drivers/gpu/nova-core/gpu/hal/tu102.rs        |  2 +-
 drivers/gpu/nova-core/gsp/boot.rs             | 10 ++---
 drivers/gpu/nova-core/gsp/cmdq.rs             | 10 ++---
 drivers/gpu/nova-core/gsp/hal.rs              |  6 +--
 drivers/gpu/nova-core/gsp/hal/gh100.rs        |  2 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs        | 14 +++---
 drivers/gpu/nova-core/gsp/sequencer.rs        |  4 +-
 drivers/gpu/nova-core/regs.rs                 |  2 +-
 drivers/gpu/nova-core/vbios.rs                |  8 ++--
 33 files changed, 137 insertions(+), 130 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index ade73da68be5..5738d4ac521b 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -36,7 +36,7 @@ pub(crate) struct NovaCore<'bound> {
 
 const BAR0_SIZE: usize = SZ_16M;
 
-pub(crate) type Bar0 = kernel::io::Mmio<BAR0_SIZE>;
+pub(crate) type Bar0<'a> = &'a pci::Bar<'a, BAR0_SIZE>;
 
 kernel::pci_device_table!(
     PCI_TABLE,
diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon.rs
index 053ce5bea6cd..94c7696a6493 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -373,7 +373,7 @@ pub(crate) fn new(dev: &device::Device, chipset: Chipset) -> Result<Self> {
     }
 
     /// Resets DMA-related registers.
-    pub(crate) fn dma_reset(&self, bar: &Bar0) {
+    pub(crate) fn dma_reset(&self, bar: Bar0<'_>) {
         bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
             v.with_allow_phys_no_ctx(true)
         });
@@ -385,7 +385,7 @@ pub(crate) fn dma_reset(&self, bar: &Bar0) {
     }
 
     /// Reset the controller, select the falcon core, and wait for memory scrubbing to complete.
-    pub(crate) fn reset(&self, bar: &Bar0) -> Result {
+    pub(crate) fn reset(&self, bar: Bar0<'_>) -> Result {
         self.hal.reset_eng(bar)?;
         self.hal.select_core(self, bar)?;
         self.hal.reset_wait_mem_scrubbing(bar)?;
@@ -404,7 +404,11 @@ pub(crate) fn reset(&self, bar: &Bar0) -> Result {
     /// Write a slice to Falcon IMEM memory using programmed I/O (PIO).
     ///
     /// Returns `EINVAL` if `img.len()` is not a multiple of 4.
-    fn pio_wr_imem_slice(&self, bar: &Bar0, load_offsets: FalconPioImemLoadTarget<'_>) -> Result {
+    fn pio_wr_imem_slice(
+        &self,
+        bar: Bar0<'_>,
+        load_offsets: FalconPioImemLoadTarget<'_>,
+    ) -> Result {
         // Rejecting misaligned images here allows us to avoid checking
         // inside the loops.
         if load_offsets.data.len() % 4 != 0 {
@@ -441,7 +445,11 @@ fn pio_wr_imem_slice(&self, bar: &Bar0, load_offsets: FalconPioImemLoadTarget<'_
     /// Write a slice to Falcon DMEM memory using programmed I/O (PIO).
     ///
     /// Returns `EINVAL` if `img.len()` is not a multiple of 4.
-    fn pio_wr_dmem_slice(&self, bar: &Bar0, load_offsets: FalconPioDmemLoadTarget<'_>) -> Result {
+    fn pio_wr_dmem_slice(
+        &self,
+        bar: Bar0<'_>,
+        load_offsets: FalconPioDmemLoadTarget<'_>,
+    ) -> Result {
         // Rejecting misaligned images here allows us to avoid checking
         // inside the loops.
         if load_offsets.data.len() % 4 != 0 {
@@ -469,7 +477,7 @@ fn pio_wr_dmem_slice(&self, bar: &Bar0, load_offsets: FalconPioDmemLoadTarget<'_
     /// Perform a PIO copy into `IMEM` and `DMEM` of `fw`, and prepare the falcon to run it.
     pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
         &self,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         fw: &F,
     ) -> Result {
         bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
@@ -505,7 +513,7 @@ pub(crate) fn pio_load<F: FalconFirmware<Target = E> + FalconPioLoadable>(
     /// `sec` is set if the loaded firmware is expected to run in secure mode.
     fn dma_wr(
         &self,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         dma_obj: &Coherent<[u8]>,
         target_mem: FalconMem,
         load_offsets: FalconDmaLoadTarget,
@@ -612,7 +620,7 @@ fn dma_wr(
     fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
         &self,
         dev: &Device<device::Bound>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         fw: &F,
     ) -> Result {
         // DMA object with firmware content as the source of the DMA engine.
@@ -660,7 +668,7 @@ fn dma_load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
     }
 
     /// Wait until the falcon CPU is halted.
-    pub(crate) fn wait_till_halted(&self, bar: &Bar0) -> Result<()> {
+    pub(crate) fn wait_till_halted(&self, bar: Bar0<'_>) -> Result<()> {
         // TIMEOUT: arbitrarily large value, firmwares should complete in less than 2 seconds.
         read_poll_timeout(
             || Ok(bar.read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())),
@@ -673,7 +681,7 @@ pub(crate) fn wait_till_halted(&self, bar: &Bar0) -> Result<()> {
     }
 
     /// Start the falcon CPU.
-    pub(crate) fn start(&self, bar: &Bar0) -> Result<()> {
+    pub(crate) fn start(&self, bar: Bar0<'_>) -> Result<()> {
         match bar
             .read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())
             .alias_en()
@@ -692,7 +700,7 @@ pub(crate) fn start(&self, bar: &Bar0) -> Result<()> {
     }
 
     /// Writes values to the mailbox registers if provided.
-    pub(crate) fn write_mailboxes(&self, bar: &Bar0, mbox0: Option<u32>, mbox1: Option<u32>) {
+    pub(crate) fn write_mailboxes(&self, bar: Bar0<'_>, mbox0: Option<u32>, mbox1: Option<u32>) {
         if let Some(mbox0) = mbox0 {
             bar.write(
                 WithBase::of::<E>(),
@@ -709,19 +717,19 @@ pub(crate) fn write_mailboxes(&self, bar: &Bar0, mbox0: Option<u32>, mbox1: Opti
     }
 
     /// Reads the value from `mbox0` register.
-    pub(crate) fn read_mailbox0(&self, bar: &Bar0) -> u32 {
+    pub(crate) fn read_mailbox0(&self, bar: Bar0<'_>) -> u32 {
         bar.read(regs::NV_PFALCON_FALCON_MAILBOX0::of::<E>())
             .value()
     }
 
     /// Reads the value from `mbox1` register.
-    pub(crate) fn read_mailbox1(&self, bar: &Bar0) -> u32 {
+    pub(crate) fn read_mailbox1(&self, bar: Bar0<'_>) -> u32 {
         bar.read(regs::NV_PFALCON_FALCON_MAILBOX1::of::<E>())
             .value()
     }
 
     /// Reads values from both mailbox registers.
-    pub(crate) fn read_mailboxes(&self, bar: &Bar0) -> (u32, u32) {
+    pub(crate) fn read_mailboxes(&self, bar: Bar0<'_>) -> (u32, u32) {
         let mbox0 = self.read_mailbox0(bar);
         let mbox1 = self.read_mailbox1(bar);
 
@@ -737,7 +745,7 @@ pub(crate) fn read_mailboxes(&self, bar: &Bar0) -> (u32, u32) {
     /// the `MBOX0` and `MBOX1` registers.
     pub(crate) fn boot(
         &self,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         mbox0: Option<u32>,
         mbox1: Option<u32>,
     ) -> Result<(u32, u32)> {
@@ -751,7 +759,7 @@ pub(crate) fn boot(
     /// falcon instance. `engine_id_mask` and `ucode_id` are obtained from the firmware header.
     pub(crate) fn signature_reg_fuse_version(
         &self,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         engine_id_mask: u16,
         ucode_id: u8,
     ) -> Result<u32> {
@@ -762,7 +770,7 @@ pub(crate) fn signature_reg_fuse_version(
     /// Check if the RISC-V core is active.
     ///
     /// Returns `true` if the RISC-V core is active, `false` otherwise.
-    pub(crate) fn is_riscv_active(&self, bar: &Bar0) -> bool {
+    pub(crate) fn is_riscv_active(&self, bar: Bar0<'_>) -> bool {
         self.hal.is_riscv_active(bar)
     }
 
@@ -771,7 +779,7 @@ pub(crate) fn is_riscv_active(&self, bar: &Bar0) -> bool {
     pub(crate) fn load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
         &self,
         dev: &Device<device::Bound>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         fw: &F,
     ) -> Result {
         match self.hal.load_method() {
@@ -781,7 +789,7 @@ pub(crate) fn load<F: FalconFirmware<Target = E> + FalconDmaLoadable>(
     }
 
     /// Write the application version to the OS register.
-    pub(crate) fn write_os_version(&self, bar: &Bar0, app_version: u32) {
+    pub(crate) fn write_os_version(&self, bar: Bar0<'_>, app_version: u32) {
         bar.write(
             WithBase::of::<E>(),
             regs::NV_PFALCON_FALCON_OS::zeroed().with_value(app_version),
diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/falcon/gsp.rs
index df6d5a382c7a..9dab7833d67f 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -40,7 +40,7 @@ impl FalconEngine for Gsp {}
 impl Falcon<Gsp> {
     /// Clears the SWGEN0 bit in the Falcon's IRQ status clear register to
     /// allow GSP to signal CPU for processing new messages in message queue.
-    pub(crate) fn clear_swgen0_intr(&self, bar: &Bar0) {
+    pub(crate) fn clear_swgen0_intr(&self, bar: Bar0<'_>) {
         bar.write(
             WithBase::of::<Gsp>(),
             regs::NV_PFALCON_FALCON_IRQSCLR::zeroed().with_swgen0(true),
@@ -48,7 +48,7 @@ pub(crate) fn clear_swgen0_intr(&self, bar: &Bar0) {
     }
 
     /// Checks if GSP reload/resume has completed during the boot process.
-    pub(crate) fn check_reload_completed(&self, bar: &Bar0, timeout: Delta) -> Result<bool> {
+    pub(crate) fn check_reload_completed(&self, bar: Bar0<'_>, timeout: Delta) -> Result<bool> {
         read_poll_timeout(
             || Ok(bar.read(regs::NV_PGC6_BSI_SECURE_SCRATCH_14)),
             |val| val.boot_stage_3_handoff(),
diff --git a/drivers/gpu/nova-core/falcon/hal.rs b/drivers/gpu/nova-core/falcon/hal.rs
index a524c8096b67..89b56823906b 100644
--- a/drivers/gpu/nova-core/falcon/hal.rs
+++ b/drivers/gpu/nova-core/falcon/hal.rs
@@ -34,7 +34,7 @@ pub(crate) enum LoadMethod {
 /// registers.
 pub(crate) trait FalconHal<E: FalconEngine>: Send + Sync {
     /// Activates the Falcon core if the engine is a risvc/falcon dual engine.
-    fn select_core(&self, _falcon: &Falcon<E>, _bar: &Bar0) -> Result {
+    fn select_core(&self, _falcon: &Falcon<E>, _bar: Bar0<'_>) -> Result {
         Ok(())
     }
 
@@ -43,23 +43,23 @@ fn select_core(&self, _falcon: &Falcon<E>, _bar: &Bar0) -> Result {
     fn signature_reg_fuse_version(
         &self,
         falcon: &Falcon<E>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         engine_id_mask: u16,
         ucode_id: u8,
     ) -> Result<u32>;
 
     /// Program the boot ROM registers prior to starting a secure firmware.
-    fn program_brom(&self, falcon: &Falcon<E>, bar: &Bar0, params: &FalconBromParams);
+    fn program_brom(&self, falcon: &Falcon<E>, bar: Bar0<'_>, params: &FalconBromParams);
 
     /// Check if the RISC-V core is active.
     /// Returns `true` if the RISC-V core is active, `false` otherwise.
-    fn is_riscv_active(&self, bar: &Bar0) -> bool;
+    fn is_riscv_active(&self, bar: Bar0<'_>) -> bool;
 
     /// Wait for memory scrubbing to complete.
-    fn reset_wait_mem_scrubbing(&self, bar: &Bar0) -> Result;
+    fn reset_wait_mem_scrubbing(&self, bar: Bar0<'_>) -> Result;
 
     /// Reset the falcon engine.
-    fn reset_eng(&self, bar: &Bar0) -> Result;
+    fn reset_eng(&self, bar: Bar0<'_>) -> Result;
 
     /// Returns the method used to load data into the falcon's memory.
     ///
diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-core/falcon/hal/ga102.rs
index 3df1ffa159b8..cf6ce47e6b25 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -31,7 +31,7 @@
 
 use super::FalconHal;
 
-fn select_core_ga102<E: FalconEngine>(bar: &Bar0) -> Result {
+fn select_core_ga102<E: FalconEngine>(bar: Bar0<'_>) -> Result {
     let bcr_ctrl = bar.read(regs::NV_PRISCV_RISCV_BCR_CTRL::of::<E>());
     if bcr_ctrl.core_select() != PeregrineCoreSelect::Falcon {
         bar.write(
@@ -53,7 +53,7 @@ fn select_core_ga102<E: FalconEngine>(bar: &Bar0) -> Result {
 
 fn signature_reg_fuse_version_ga102(
     dev: &device::Device,
-    bar: &Bar0,
+    bar: Bar0<'_>,
     engine_id_mask: u16,
     ucode_id: u8,
 ) -> Result<u32> {
@@ -86,7 +86,7 @@ fn signature_reg_fuse_version_ga102(
     Ok(u16::BITS - reg_fuse_version.leading_zeros())
 }
 
-fn program_brom_ga102<E: FalconEngine>(bar: &Bar0, params: &FalconBromParams) {
+fn program_brom_ga102<E: FalconEngine>(bar: Bar0<'_>, params: &FalconBromParams) {
     bar.write(
         WithBase::of::<E>().at(0),
         regs::NV_PFALCON2_FALCON_BROM_PARAADDR::zeroed().with_value(params.pkc_data_offset),
@@ -115,30 +115,30 @@ pub(super) fn new() -> Self {
 }
 
 impl<E: FalconEngine> FalconHal<E> for Ga102<E> {
-    fn select_core(&self, _falcon: &Falcon<E>, bar: &Bar0) -> Result {
+    fn select_core(&self, _falcon: &Falcon<E>, bar: Bar0<'_>) -> Result {
         select_core_ga102::<E>(bar)
     }
 
     fn signature_reg_fuse_version(
         &self,
         falcon: &Falcon<E>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         engine_id_mask: u16,
         ucode_id: u8,
     ) -> Result<u32> {
         signature_reg_fuse_version_ga102(&falcon.dev, bar, engine_id_mask, ucode_id)
     }
 
-    fn program_brom(&self, _falcon: &Falcon<E>, bar: &Bar0, params: &FalconBromParams) {
+    fn program_brom(&self, _falcon: &Falcon<E>, bar: Bar0<'_>, params: &FalconBromParams) {
         program_brom_ga102::<E>(bar, params);
     }
 
-    fn is_riscv_active(&self, bar: &Bar0) -> bool {
+    fn is_riscv_active(&self, bar: Bar0<'_>) -> bool {
         bar.read(regs::NV_PRISCV_RISCV_CPUCTL::of::<E>())
             .active_stat()
     }
 
-    fn reset_wait_mem_scrubbing(&self, bar: &Bar0) -> Result {
+    fn reset_wait_mem_scrubbing(&self, bar: Bar0<'_>) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 20ms.
         read_poll_timeout(
             || Ok(bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>())),
@@ -149,7 +149,7 @@ fn reset_wait_mem_scrubbing(&self, bar: &Bar0) -> Result {
         .map(|_| ())
     }
 
-    fn reset_eng(&self, bar: &Bar0) -> Result {
+    fn reset_eng(&self, bar: Bar0<'_>) -> Result {
         let _ = bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<E>());
 
         // According to OpenRM's `kflcnPreResetWait_GA102` documentation, HW sometimes does not set
diff --git a/drivers/gpu/nova-core/falcon/hal/tu102.rs b/drivers/gpu/nova-core/falcon/hal/tu102.rs
index d8f5d271811b..3aaee3869312 100644
--- a/drivers/gpu/nova-core/falcon/hal/tu102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/tu102.rs
@@ -34,28 +34,28 @@ pub(super) fn new() -> Self {
 }
 
 impl<E: FalconEngine> FalconHal<E> for Tu102<E> {
-    fn select_core(&self, _falcon: &Falcon<E>, _bar: &Bar0) -> Result {
+    fn select_core(&self, _falcon: &Falcon<E>, _bar: Bar0<'_>) -> Result {
         Ok(())
     }
 
     fn signature_reg_fuse_version(
         &self,
         _falcon: &Falcon<E>,
-        _bar: &Bar0,
+        _bar: Bar0<'_>,
         _engine_id_mask: u16,
         _ucode_id: u8,
     ) -> Result<u32> {
         Ok(0)
     }
 
-    fn program_brom(&self, _falcon: &Falcon<E>, _bar: &Bar0, _params: &FalconBromParams) {}
+    fn program_brom(&self, _falcon: &Falcon<E>, _bar: Bar0<'_>, _params: &FalconBromParams) {}
 
-    fn is_riscv_active(&self, bar: &Bar0) -> bool {
+    fn is_riscv_active(&self, bar: Bar0<'_>) -> bool {
         bar.read(regs::NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS::of::<E>())
             .active_stat()
     }
 
-    fn reset_wait_mem_scrubbing(&self, bar: &Bar0) -> Result {
+    fn reset_wait_mem_scrubbing(&self, bar: Bar0<'_>) -> Result {
         // TIMEOUT: memory scrubbing should complete in less than 10ms.
         read_poll_timeout(
             || Ok(bar.read(regs::NV_PFALCON_FALCON_DMACTL::of::<E>())),
@@ -66,7 +66,7 @@ fn reset_wait_mem_scrubbing(&self, bar: &Bar0) -> Result {
         .map(|_| ())
     }
 
-    fn reset_eng(&self, bar: &Bar0) -> Result {
+    fn reset_eng(&self, bar: Bar0<'_>) -> Result {
         regs::NV_PFALCON_FALCON_ENGINE::reset_engine::<E>(bar);
         self.reset_wait_mem_scrubbing(bar)?;
 
diff --git a/drivers/gpu/nova-core/fb.rs b/drivers/gpu/nova-core/fb.rs
index 0aaee718c2c3..725e428154cf 100644
--- a/drivers/gpu/nova-core/fb.rs
+++ b/drivers/gpu/nova-core/fb.rs
@@ -46,7 +46,7 @@ pub(crate) struct SysmemFlush<'sys> {
     /// Chipset we are operating on.
     chipset: Chipset,
     device: &'sys device::Device,
-    bar: &'sys Bar0,
+    bar: Bar0<'sys>,
     /// Keep the page alive as long as we need it.
     page: CoherentHandle,
 }
@@ -55,7 +55,7 @@ impl<'sys> SysmemFlush<'sys> {
     /// Allocate a memory page and register it as the sysmem flush page.
     pub(crate) fn register(
         dev: &'sys device::Device<device::Bound>,
-        bar: &'sys Bar0,
+        bar: Bar0<'sys>,
         chipset: Chipset,
     ) -> Result<Self> {
         let page = CoherentHandle::alloc(dev, kernel::page::PAGE_SIZE, GFP_KERNEL)?;
@@ -171,7 +171,7 @@ pub(crate) struct FbLayout {
 
 impl FbLayout {
     /// Computes the FB layout for `chipset` required to run the `gsp_fw` GSP firmware.
-    pub(crate) fn new(chipset: Chipset, bar: &Bar0, gsp_fw: &GspFirmware) -> Result<Self> {
+    pub(crate) fn new(chipset: Chipset, bar: Bar0<'_>, gsp_fw: &GspFirmware) -> Result<Self> {
         let hal = hal::fb_hal(chipset);
 
         let fb = {
diff --git a/drivers/gpu/nova-core/fb/hal.rs b/drivers/gpu/nova-core/fb/hal.rs
index be9e75f990f0..714f0b51cd8f 100644
--- a/drivers/gpu/nova-core/fb/hal.rs
+++ b/drivers/gpu/nova-core/fb/hal.rs
@@ -20,18 +20,18 @@
 
 pub(crate) trait FbHal {
     /// Returns the address of the currently-registered sysmem flush page.
-    fn read_sysmem_flush_page(&self, bar: &Bar0) -> u64;
+    fn read_sysmem_flush_page(&self, bar: Bar0<'_>) -> u64;
 
     /// Register `addr` as the address of the sysmem flush page.
     ///
     /// This might fail if the address is too large for the receiving register.
-    fn write_sysmem_flush_page(&self, bar: &Bar0, addr: u64) -> Result;
+    fn write_sysmem_flush_page(&self, bar: Bar0<'_>, addr: u64) -> Result;
 
     /// Returns `true` is display is supported.
-    fn supports_display(&self, bar: &Bar0) -> bool;
+    fn supports_display(&self, bar: Bar0<'_>) -> bool;
 
     /// Returns the VRAM size, in bytes.
-    fn vidmem_size(&self, bar: &Bar0) -> u64;
+    fn vidmem_size(&self, bar: Bar0<'_>) -> u64;
 
     /// Returns the amount of VRAM to reserve for the PMU.
     fn pmu_reserved_size(&self) -> u32;
diff --git a/drivers/gpu/nova-core/fb/hal/ga100.rs b/drivers/gpu/nova-core/fb/hal/ga100.rs
index af95f1bdd273..3cc1caf361c7 100644
--- a/drivers/gpu/nova-core/fb/hal/ga100.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga100.rs
@@ -17,13 +17,13 @@
 
 struct Ga100;
 
-pub(super) fn read_sysmem_flush_page_ga100(bar: &Bar0) -> u64 {
+pub(super) fn read_sysmem_flush_page_ga100(bar: Bar0<'_>) -> u64 {
     u64::from(bar.read(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
         | u64::from(bar.read(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI).adr_63_40())
             << FLUSH_SYSMEM_ADDR_SHIFT_HI
 }
 
-pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0, addr: u64) {
+pub(super) fn write_sysmem_flush_page_ga100(bar: Bar0<'_>, addr: u64) {
     bar.write_reg(
         regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR_HI::zeroed().with_adr_63_40(
             Bounded::<u64, _>::from(addr)
@@ -40,7 +40,7 @@ pub(super) fn write_sysmem_flush_page_ga100(bar: &Bar0, addr: u64) {
     );
 }
 
-pub(super) fn display_enabled_ga100(bar: &Bar0) -> bool {
+pub(super) fn display_enabled_ga100(bar: Bar0<'_>) -> bool {
     !bar.read(regs::ga100::NV_FUSE_STATUS_OPT_DISPLAY)
         .display_disabled()
 }
@@ -50,21 +50,21 @@ pub(super) fn display_enabled_ga100(bar: &Bar0) -> bool {
 const FLUSH_SYSMEM_ADDR_SHIFT_HI: u32 = 40;
 
 impl FbHal for Ga100 {
-    fn read_sysmem_flush_page(&self, bar: &Bar0) -> u64 {
+    fn read_sysmem_flush_page(&self, bar: Bar0<'_>) -> u64 {
         read_sysmem_flush_page_ga100(bar)
     }
 
-    fn write_sysmem_flush_page(&self, bar: &Bar0, addr: u64) -> Result {
+    fn write_sysmem_flush_page(&self, bar: Bar0<'_>, addr: u64) -> Result {
         write_sysmem_flush_page_ga100(bar, addr);
 
         Ok(())
     }
 
-    fn supports_display(&self, bar: &Bar0) -> bool {
+    fn supports_display(&self, bar: Bar0<'_>) -> bool {
         display_enabled_ga100(bar)
     }
 
-    fn vidmem_size(&self, bar: &Bar0) -> u64 {
+    fn vidmem_size(&self, bar: Bar0<'_>) -> u64 {
         super::tu102::vidmem_size_gp102(bar)
     }
 
diff --git a/drivers/gpu/nova-core/fb/hal/ga102.rs b/drivers/gpu/nova-core/fb/hal/ga102.rs
index e06dbb08349e..44a2cf8a00f1 100644
--- a/drivers/gpu/nova-core/fb/hal/ga102.rs
+++ b/drivers/gpu/nova-core/fb/hal/ga102.rs
@@ -12,28 +12,28 @@
     regs, //
 };
 
-pub(super) fn vidmem_size_ga102(bar: &Bar0) -> u64 {
+pub(super) fn vidmem_size_ga102(bar: Bar0<'_>) -> u64 {
     bar.read(regs::NV_USABLE_FB_SIZE_IN_MB).usable_fb_size()
 }
 
 struct Ga102;
 
 impl FbHal for Ga102 {
-    fn read_sysmem_flush_page(&self, bar: &Bar0) -> u64 {
+    fn read_sysmem_flush_page(&self, bar: Bar0<'_>) -> u64 {
         super::ga100::read_sysmem_flush_page_ga100(bar)
     }
 
-    fn write_sysmem_flush_page(&self, bar: &Bar0, addr: u64) -> Result {
+    fn write_sysmem_flush_page(&self, bar: Bar0<'_>, addr: u64) -> Result {
         super::ga100::write_sysmem_flush_page_ga100(bar, addr);
 
         Ok(())
     }
 
-    fn supports_display(&self, bar: &Bar0) -> bool {
+    fn supports_display(&self, bar: Bar0<'_>) -> bool {
         super::ga100::display_enabled_ga100(bar)
     }
 
-    fn vidmem_size(&self, bar: &Bar0) -> u64 {
+    fn vidmem_size(&self, bar: Bar0<'_>) -> u64 {
         vidmem_size_ga102(bar)
     }
 
diff --git a/drivers/gpu/nova-core/fb/hal/gb100.rs b/drivers/gpu/nova-core/fb/hal/gb100.rs
index ecea4ff446ff..6e0eba101ca1 100644
--- a/drivers/gpu/nova-core/fb/hal/gb100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb100.rs
@@ -33,7 +33,7 @@ impl RegisterBase<regs::Hshub0Base> for Gb100 {
     const BASE: usize = 0x0087_0000;
 }
 
-fn read_sysmem_flush_page_gb100(bar: &Bar0) -> u64 {
+fn read_sysmem_flush_page_gb100(bar: Bar0<'_>) -> u64 {
     let lo = u64::from(
         bar.read(regs::NV_PFB_HSHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::of::<Gb100>())
             .adr(),
@@ -50,7 +50,7 @@ fn read_sysmem_flush_page_gb100(bar: &Bar0) -> u64 {
 ///
 /// Both the primary and EG (egress) register pairs must be programmed to the same address,
 /// as required by hardware.
-fn write_sysmem_flush_page_gb100(bar: &Bar0, addr: Bounded<u64, 52>) {
+fn write_sysmem_flush_page_gb100(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
     // CAST: lower 32 bits. Hardware ignores bits 7:0.
     let addr_lo = *addr as u32;
     let addr_hi = addr.shr::<32, 20>().cast::<u32>();
@@ -84,11 +84,11 @@ pub(super) const fn pmu_reserved_size_gb100() -> u32 {
 }
 
 impl FbHal for Gb100 {
-    fn read_sysmem_flush_page(&self, bar: &Bar0) -> u64 {
+    fn read_sysmem_flush_page(&self, bar: Bar0<'_>) -> u64 {
         read_sysmem_flush_page_gb100(bar)
     }
 
-    fn write_sysmem_flush_page(&self, bar: &Bar0, addr: u64) -> Result {
+    fn write_sysmem_flush_page(&self, bar: Bar0<'_>, addr: u64) -> Result {
         let addr = Bounded::<u64, 52>::try_new(addr).ok_or(EINVAL)?;
 
         write_sysmem_flush_page_gb100(bar, addr);
@@ -96,11 +96,11 @@ fn write_sysmem_flush_page(&self, bar: &Bar0, addr: u64) -> Result {
         Ok(())
     }
 
-    fn supports_display(&self, bar: &Bar0) -> bool {
+    fn supports_display(&self, bar: Bar0<'_>) -> bool {
         super::ga100::display_enabled_ga100(bar)
     }
 
-    fn vidmem_size(&self, bar: &Bar0) -> u64 {
+    fn vidmem_size(&self, bar: Bar0<'_>) -> u64 {
         super::ga102::vidmem_size_ga102(bar)
     }
 
diff --git a/drivers/gpu/nova-core/fb/hal/gb202.rs b/drivers/gpu/nova-core/fb/hal/gb202.rs
index fa5c3f7f2b2e..038d1278c634 100644
--- a/drivers/gpu/nova-core/fb/hal/gb202.rs
+++ b/drivers/gpu/nova-core/fb/hal/gb202.rs
@@ -28,7 +28,7 @@ impl RegisterBase<regs::Fbhub0Base> for Gb202 {
     const BASE: usize = 0x008a_0000;
 }
 
-fn read_sysmem_flush_page_gb202(bar: &Bar0) -> u64 {
+fn read_sysmem_flush_page_gb202(bar: Bar0<'_>) -> u64 {
     let lo = u64::from(
         bar.read(regs::NV_PFB_FBHUB_PCIE_FLUSH_SYSMEM_ADDR_LO::of::<Gb202>())
             .adr(),
@@ -42,7 +42,7 @@ fn read_sysmem_flush_page_gb202(bar: &Bar0) -> u64 {
 }
 
 /// Write the sysmem flush page address through the GB20x FBHUB0 registers.
-fn write_sysmem_flush_page_gb202(bar: &Bar0, addr: Bounded<u64, 52>) {
+fn write_sysmem_flush_page_gb202(bar: Bar0<'_>, addr: Bounded<u64, 52>) {
     // Write HI first. The hardware will trigger the flush on the LO write.
     bar.write(
         regs::NV_PFB_FBHUB_PCIE_FLUSH_SYSMEM_ADDR_HI::of::<Gb202>(),
@@ -57,11 +57,11 @@ fn write_sysmem_flush_page_gb202(bar: &Bar0, addr: Bounded<u64, 52>) {
 }
 
 impl FbHal for Gb202 {
-    fn read_sysmem_flush_page(&self, bar: &Bar0) -> u64 {
+    fn read_sysmem_flush_page(&self, bar: Bar0<'_>) -> u64 {
         read_sysmem_flush_page_gb202(bar)
     }
 
-    fn write_sysmem_flush_page(&self, bar: &Bar0, addr: u64) -> Result {
+    fn write_sysmem_flush_page(&self, bar: Bar0<'_>, addr: u64) -> Result {
         let addr = Bounded::<u64, 52>::try_new(addr).ok_or(EINVAL)?;
 
         write_sysmem_flush_page_gb202(bar, addr);
@@ -69,11 +69,11 @@ fn write_sysmem_flush_page(&self, bar: &Bar0, addr: u64) -> Result {
         Ok(())
     }
 
-    fn supports_display(&self, bar: &Bar0) -> bool {
+    fn supports_display(&self, bar: Bar0<'_>) -> bool {
         super::ga100::display_enabled_ga100(bar)
     }
 
-    fn vidmem_size(&self, bar: &Bar0) -> u64 {
+    fn vidmem_size(&self, bar: Bar0<'_>) -> u64 {
         super::ga102::vidmem_size_ga102(bar)
     }
 
diff --git a/drivers/gpu/nova-core/fb/hal/gh100.rs b/drivers/gpu/nova-core/fb/hal/gh100.rs
index 8f79c72b1823..5450c7254dad 100644
--- a/drivers/gpu/nova-core/fb/hal/gh100.rs
+++ b/drivers/gpu/nova-core/fb/hal/gh100.rs
@@ -14,21 +14,21 @@
 struct Gh100;
 
 impl FbHal for Gh100 {
-    fn read_sysmem_flush_page(&self, bar: &Bar0) -> u64 {
+    fn read_sysmem_flush_page(&self, bar: Bar0<'_>) -> u64 {
         super::ga100::read_sysmem_flush_page_ga100(bar)
     }
 
-    fn write_sysmem_flush_page(&self, bar: &Bar0, addr: u64) -> Result {
+    fn write_sysmem_flush_page(&self, bar: Bar0<'_>, addr: u64) -> Result {
         super::ga100::write_sysmem_flush_page_ga100(bar, addr);
 
         Ok(())
     }
 
-    fn supports_display(&self, bar: &Bar0) -> bool {
+    fn supports_display(&self, bar: Bar0<'_>) -> bool {
         super::ga100::display_enabled_ga100(bar)
     }
 
-    fn vidmem_size(&self, bar: &Bar0) -> u64 {
+    fn vidmem_size(&self, bar: Bar0<'_>) -> u64 {
         super::ga102::vidmem_size_ga102(bar)
     }
 
diff --git a/drivers/gpu/nova-core/fb/hal/tu102.rs b/drivers/gpu/nova-core/fb/hal/tu102.rs
index 62d9357987f7..f629e8e9d5d5 100644
--- a/drivers/gpu/nova-core/fb/hal/tu102.rs
+++ b/drivers/gpu/nova-core/fb/hal/tu102.rs
@@ -17,11 +17,11 @@
 /// to be used by HALs.
 pub(super) const FLUSH_SYSMEM_ADDR_SHIFT: u32 = 8;
 
-pub(super) fn read_sysmem_flush_page_gm107(bar: &Bar0) -> u64 {
+pub(super) fn read_sysmem_flush_page_gm107(bar: Bar0<'_>) -> u64 {
     u64::from(bar.read(regs::NV_PFB_NISO_FLUSH_SYSMEM_ADDR).adr_39_08()) << FLUSH_SYSMEM_ADDR_SHIFT
 }
 
-pub(super) fn write_sysmem_flush_page_gm107(bar: &Bar0, addr: u64) -> Result {
+pub(super) fn write_sysmem_flush_page_gm107(bar: Bar0<'_>, addr: u64) -> Result {
     // Check that the address doesn't overflow the receiving 32-bit register.
     u32::try_from(addr >> FLUSH_SYSMEM_ADDR_SHIFT)
         .map_err(|_| EINVAL)
@@ -30,12 +30,12 @@ pub(super) fn write_sysmem_flush_page_gm107(bar: &Bar0, addr: u64) -> Result {
         })
 }
 
-pub(super) fn display_enabled_gm107(bar: &Bar0) -> bool {
+pub(super) fn display_enabled_gm107(bar: Bar0<'_>) -> bool {
     !bar.read(regs::gm107::NV_FUSE_STATUS_OPT_DISPLAY)
         .display_disabled()
 }
 
-pub(super) fn vidmem_size_gp102(bar: &Bar0) -> u64 {
+pub(super) fn vidmem_size_gp102(bar: Bar0<'_>) -> u64 {
     bar.read(regs::NV_PFB_PRI_MMU_LOCAL_MEMORY_RANGE)
         .usable_fb_size()
 }
@@ -55,19 +55,19 @@ pub(super) const fn frts_size_tu102() -> u64 {
 struct Tu102;
 
 impl FbHal for Tu102 {
-    fn read_sysmem_flush_page(&self, bar: &Bar0) -> u64 {
+    fn read_sysmem_flush_page(&self, bar: Bar0<'_>) -> u64 {
         read_sysmem_flush_page_gm107(bar)
     }
 
-    fn write_sysmem_flush_page(&self, bar: &Bar0, addr: u64) -> Result {
+    fn write_sysmem_flush_page(&self, bar: Bar0<'_>, addr: u64) -> Result {
         write_sysmem_flush_page_gm107(bar, addr)
     }
 
-    fn supports_display(&self, bar: &Bar0) -> bool {
+    fn supports_display(&self, bar: Bar0<'_>) -> bool {
         display_enabled_gm107(bar)
     }
 
-    fn vidmem_size(&self, bar: &Bar0) -> u64 {
+    fn vidmem_size(&self, bar: Bar0<'_>) -> u64 {
         vidmem_size_gp102(bar)
     }
 
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index c5e17605e1a3..d9313ac361af 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -294,7 +294,7 @@ pub(crate) fn new(
         chipset: Chipset,
         ver: &str,
         falcon: &Falcon<<Self as FalconFirmware>::Target>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
     ) -> Result<Self> {
         let fw_name = match kind {
             BooterKind::Loader => "booter_load",
@@ -405,7 +405,7 @@ pub(crate) fn new(
     pub(crate) fn run<T>(
         &self,
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         sec2_falcon: &Falcon<Sec2>,
         wpr_meta: &Coherent<T>,
     ) -> Result {
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 4108f28cd338..199ae2adb664 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -321,7 +321,7 @@ impl FwsecFirmware {
     pub(crate) fn new(
         dev: &Device<device::Bound>,
         falcon: &Falcon<Gsp>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         bios: &Vbios,
         cmd: FwsecCommand,
     ) -> Result<Self> {
@@ -394,7 +394,7 @@ pub(crate) fn run(
         &self,
         dev: &Device<device::Bound>,
         falcon: &Falcon<Gsp>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
     ) -> Result<()> {
         // Reset falcon, load the firmware, and run it.
         falcon
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index bcb713a868e2..039920dc340b 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -280,7 +280,7 @@ pub(crate) fn run(
         &self,
         dev: &Device<device::Bound>,
         falcon: &Falcon<Gsp>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
     ) -> Result<()> {
         // Reset falcon, load the firmware, and run it.
         falcon
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 908dc112aa6f..711665d4256b 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -47,7 +47,7 @@ impl Fsp {
     /// interface is not used before secure boot has completed.
     pub(crate) fn wait_secure_boot(
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         chipset: Chipset,
         fsp_fw: FspFirmware,
     ) -> Result<Fsp> {
diff --git a/drivers/gpu/nova-core/fsp/hal.rs b/drivers/gpu/nova-core/fsp/hal.rs
index fc5ebb749c59..ec29f49ad605 100644
--- a/drivers/gpu/nova-core/fsp/hal.rs
+++ b/drivers/gpu/nova-core/fsp/hal.rs
@@ -14,7 +14,7 @@
 
 pub(super) trait FspHal {
     /// Returns the secure boot status from the architecture-specific `NV_THERM_I2CS_SCRATCH` register.
-    fn fsp_boot_status(&self, bar: &Bar0) -> u32;
+    fn fsp_boot_status(&self, bar: Bar0<'_>) -> u32;
 }
 
 /// Returns the FSP HAL, or `None` if the architecture doesn't support FSP.
diff --git a/drivers/gpu/nova-core/fsp/hal/gb202.rs b/drivers/gpu/nova-core/fsp/hal/gb202.rs
index 2f08b6c9f308..cf433ff4397b 100644
--- a/drivers/gpu/nova-core/fsp/hal/gb202.rs
+++ b/drivers/gpu/nova-core/fsp/hal/gb202.rs
@@ -12,7 +12,7 @@
 struct Gb202;
 
 impl FspHal for Gb202 {
-    fn fsp_boot_status(&self, bar: &Bar0) -> u32 {
+    fn fsp_boot_status(&self, bar: Bar0<'_>) -> u32 {
         bar.read(regs::gb202::NV_THERM_I2CS_SCRATCH_FSP_BOOT_COMPLETE)
             .fsp_boot_complete()
             .into()
diff --git a/drivers/gpu/nova-core/fsp/hal/gh100.rs b/drivers/gpu/nova-core/fsp/hal/gh100.rs
index 290fb55a81da..13338492bab2 100644
--- a/drivers/gpu/nova-core/fsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/fsp/hal/gh100.rs
@@ -12,7 +12,7 @@
 struct Gh100;
 
 impl FspHal for Gh100 {
-    fn fsp_boot_status(&self, bar: &Bar0) -> u32 {
+    fn fsp_boot_status(&self, bar: Bar0<'_>) -> u32 {
         bar.read(regs::gh100::NV_THERM_I2CS_SCRATCH_FSP_BOOT_COMPLETE)
             .fsp_boot_complete()
             .into()
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index b7341bde04be..b3c91731db45 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -208,7 +208,7 @@ pub(crate) struct Spec {
 }
 
 impl Spec {
-    fn new(dev: &device::Device, bar: &Bar0) -> Result<Spec> {
+    fn new(dev: &device::Device, bar: Bar0<'_>) -> Result<Spec> {
         // Some brief notes about boot0 and boot42, in chronological order:
         //
         // NV04 through NV50:
@@ -269,7 +269,7 @@ pub(crate) struct Gpu<'gpu> {
     device: &'gpu device::Device<device::Bound>,
     spec: Spec,
     /// MMIO mapping of PCI BAR 0.
-    bar: &'gpu Bar0,
+    bar: Bar0<'gpu>,
     /// System memory page required for flushing all pending GPU-side memory writes done through
     /// PCIE into system memory, via sysmembar (A GPU-initiated HW memory-barrier operation).
     sysmem_flush: SysmemFlush<'gpu>,
@@ -287,7 +287,7 @@ pub(crate) struct Gpu<'gpu> {
 impl<'gpu> Gpu<'gpu> {
     pub(crate) fn new(
         pdev: &'gpu pci::Device<device::Core<'_>>,
-        bar: &'gpu Bar0,
+        bar: Bar0<'gpu>,
     ) -> impl PinInit<Self, Error> + 'gpu {
         try_pin_init!(Self {
             device: pdev.as_ref(),
@@ -308,8 +308,6 @@ pub(crate) fn new(
                     .inspect_err(|_| dev_err!(pdev, "GFW boot did not complete\n"))?;
             },
 
-            bar,
-
             sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec.chipset)?,
 
             gsp_falcon: Falcon::new(
@@ -326,6 +324,7 @@ pub(crate) fn new(
             // outside of the constructed `Gpu`, ensuring that the unload sequence is properly run
             // in case of failure.
             unload_bundle: gsp.boot(pdev, bar, spec.chipset, gsp_falcon, sec2_falcon)?,
+            bar,
         })
     }
 }
diff --git a/drivers/gpu/nova-core/gpu/hal.rs b/drivers/gpu/nova-core/gpu/hal.rs
index cd833bd49b9b..3f25882d0e56 100644
--- a/drivers/gpu/nova-core/gpu/hal.rs
+++ b/drivers/gpu/nova-core/gpu/hal.rs
@@ -20,7 +20,7 @@
 
 pub(crate) trait GpuHal {
     /// Waits for GFW_BOOT completion if required by this hardware family.
-    fn wait_gfw_boot_completion(&self, bar: &Bar0) -> Result;
+    fn wait_gfw_boot_completion(&self, bar: Bar0<'_>) -> Result;
 
     /// Returns the DMA mask for the current architecture.
     fn dma_mask(&self) -> DmaMask;
diff --git a/drivers/gpu/nova-core/gpu/hal/gh100.rs b/drivers/gpu/nova-core/gpu/hal/gh100.rs
index 17778a618900..e3f8ba0fab33 100644
--- a/drivers/gpu/nova-core/gpu/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gpu/hal/gh100.rs
@@ -14,7 +14,7 @@
 struct Gh100;
 
 impl GpuHal for Gh100 {
-    fn wait_gfw_boot_completion(&self, _bar: &Bar0) -> Result {
+    fn wait_gfw_boot_completion(&self, _bar: Bar0<'_>) -> Result {
         Ok(())
     }
 
diff --git a/drivers/gpu/nova-core/gpu/hal/tu102.rs b/drivers/gpu/nova-core/gpu/hal/tu102.rs
index 125478bfe07a..b0732e53edea 100644
--- a/drivers/gpu/nova-core/gpu/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gpu/hal/tu102.rs
@@ -55,7 +55,7 @@ impl GpuHal for Tu102 {
     /// This function waits for a signal indicating that core initialization is complete. Before
     /// this signal is received, little can be done with the GPU. This signal is set by the FWSEC
     /// running on the GSP in Heavy-secured mode.
-    fn wait_gfw_boot_completion(&self, bar: &Bar0) -> Result {
+    fn wait_gfw_boot_completion(&self, bar: Bar0<'_>) -> Result {
         // Before accessing the completion status in `NV_PGC6_AON_SECURE_SCRATCH_GROUP_05`, we must
         // first check `NV_PGC6_AON_SECURE_SCRATCH_GROUP_05_PRIV_LEVEL_MASK`. This is because
         // `NV_PGC6_AON_SECURE_SCRATCH_GROUP_05` becomes accessible only after the secure firmware
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 8c316fa2e585..8afb62d689cb 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -38,7 +38,7 @@
 pub(super) struct BootUnloadArgs<'a> {
     gsp: &'a super::Gsp,
     dev: &'a device::Device<device::Bound>,
-    bar: &'a Bar0,
+    bar: Bar0<'a>,
     gsp_falcon: &'a Falcon<Gsp>,
     sec2_falcon: &'a Falcon<Sec2>,
     unload_bundle: Option<super::UnloadBundle>,
@@ -57,7 +57,7 @@ impl<'a> BootUnloadGuard<'a> {
     pub(super) fn new(
         gsp: &'a super::Gsp,
         dev: &'a device::Device<device::Bound>,
-        bar: &'a Bar0,
+        bar: Bar0<'a>,
         gsp_falcon: &'a Falcon<Gsp>,
         sec2_falcon: &'a Falcon<Sec2>,
         unload_bundle: Option<super::UnloadBundle>,
@@ -104,7 +104,7 @@ impl super::Gsp {
     pub(crate) fn boot(
         self: Pin<&mut Self>,
         pdev: &pci::Device<device::Bound>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         chipset: Chipset,
         gsp_falcon: &Falcon<Gsp>,
         sec2_falcon: &Falcon<Sec2>,
@@ -166,7 +166,7 @@ pub(crate) fn boot(
     /// Shut down the GSP and wait until it is offline.
     fn shutdown_gsp(
         cmdq: &Cmdq,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         gsp_falcon: &Falcon<Gsp>,
         mode: commands::PowerStateLevel,
     ) -> Result {
@@ -190,7 +190,7 @@ fn shutdown_gsp(
     pub(crate) fn unload(
         &self,
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         gsp_falcon: &Falcon<Gsp>,
         sec2_falcon: &Falcon<Sec2>,
         unload_bundle: Option<super::UnloadBundle>,
diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 275da9b1ee0e..0bc5a95a9cd7 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -532,7 +532,7 @@ fn calculate_checksum<T: Iterator<Item = u8>>(it: T) -> u32 {
     }
 
     /// Notifies the GSP that we have updated the command queue pointers.
-    fn notify_gsp(bar: &Bar0) {
+    fn notify_gsp(bar: Bar0<'_>) {
         bar.write_reg(regs::NV_PGSP_QUEUE_HEAD::zeroed().with_address(0u32));
     }
 
@@ -552,7 +552,7 @@ fn notify_gsp(bar: &Bar0) {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command and reply initializers are propagated as-is.
-    pub(crate) fn send_command<M>(&self, bar: &Bar0, command: M) -> Result<M::Reply>
+    pub(crate) fn send_command<M>(&self, bar: Bar0<'_>, command: M) -> Result<M::Reply>
     where
         M: CommandToGsp,
         M::Reply: MessageFromGsp,
@@ -580,7 +580,7 @@ pub(crate) fn send_command<M>(&self, bar: &Bar0, command: M) -> Result<M::Reply>
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    pub(crate) fn send_command_no_wait<M>(&self, bar: &Bar0, command: M) -> Result
+    pub(crate) fn send_command_no_wait<M>(&self, bar: Bar0<'_>, command: M) -> Result
     where
         M: CommandToGsp<Reply = NoReply>,
         Error: From<M::InitError>,
@@ -624,7 +624,7 @@ impl CmdqInner {
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    fn send_single_command<M>(&mut self, bar: &Bar0, command: M) -> Result
+    fn send_single_command<M>(&mut self, bar: Bar0<'_>, command: M) -> Result
     where
         M: CommandToGsp,
         // This allows all error types, including `Infallible`, to be used for `M::InitError`.
@@ -694,7 +694,7 @@ fn send_single_command<M>(&mut self, bar: &Bar0, command: M) -> Result
     ///   written to by its [`CommandToGsp::init_variable_payload`] method.
     ///
     /// Error codes returned by the command initializers are propagated as-is.
-    fn send_command<M>(&mut self, bar: &Bar0, command: M) -> Result
+    fn send_command<M>(&mut self, bar: Bar0<'_>, command: M) -> Result
     where
         M: CommandToGsp,
         Error: From<M::InitError>,
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/hal.rs
index 88fc3e791114..04f004856c60 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -41,7 +41,7 @@ pub(super) trait UnloadBundle: Send {
     fn run(
         &self,
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         gsp_falcon: &Falcon<GspEngine>,
         sec2_falcon: &Falcon<Sec2>,
     ) -> Result;
@@ -58,7 +58,7 @@ fn boot<'a>(
         &self,
         gsp: &'a Gsp,
         dev: &'a device::Device<device::Bound>,
-        bar: &'a Bar0,
+        bar: Bar0<'a>,
         chipset: Chipset,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
@@ -74,7 +74,7 @@ fn post_boot(
         &self,
         _gsp: &Gsp,
         _dev: &device::Device<device::Bound>,
-        _bar: &Bar0,
+        _bar: Bar0<'_>,
         _gsp_fw: &GspFirmware,
         _gsp_falcon: &Falcon<GspEngine>,
         _sec2_falcon: &Falcon<Sec2>,
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core/gsp/hal/gh100.rs
index b25970dd4561..caf5365573f3 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -41,7 +41,7 @@ fn boot<'a>(
         &self,
         _gsp: &'a Gsp,
         dev: &'a device::Device<device::Bound>,
-        bar: &'a Bar0,
+        bar: Bar0<'a>,
         chipset: Chipset,
         _fb_layout: &FbLayout,
         _wpr_meta: &Coherent<GspFwWprMeta>,
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core/gsp/hal/tu102.rs
index a033bc892066..2f6301af7113 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -61,7 +61,7 @@ impl FwsecUnloadFirmware {
     /// Loads the FWSEC SB firmware, as well as its bootloader if `chipset` requires it.
     fn new(
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         chipset: Chipset,
         bios: &Vbios,
         gsp_falcon: &Falcon<GspEngine>,
@@ -79,7 +79,7 @@ fn new(
     fn run(
         &self,
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         gsp_falcon: &Falcon<GspEngine>,
     ) -> Result {
         match self {
@@ -100,7 +100,7 @@ impl Sec2UnloadBundle {
     /// Load and prepare the resources required to properly reset the GSP after it has been stopped.
     fn build(
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         chipset: Chipset,
         bios: &Vbios,
         gsp_falcon: &Falcon<GspEngine>,
@@ -129,7 +129,7 @@ impl UnloadBundle for Sec2UnloadBundle {
     fn run(
         &self,
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         gsp_falcon: &Falcon<GspEngine>,
         sec2_falcon: &Falcon<Sec2>,
     ) -> Result {
@@ -172,7 +172,7 @@ fn run_fwsec_frts(
     dev: &device::Device<device::Bound>,
     chipset: Chipset,
     falcon: &Falcon<GspEngine>,
-    bar: &Bar0,
+    bar: Bar0<'_>,
     bios: &Vbios,
     fb_layout: &FbLayout,
 ) -> Result {
@@ -259,7 +259,7 @@ fn boot<'a>(
         &self,
         gsp: &'a Gsp,
         dev: &'a device::Device<device::Bound>,
-        bar: &'a Bar0,
+        bar: Bar0<'a>,
         chipset: Chipset,
         fb_layout: &FbLayout,
         wpr_meta: &Coherent<GspFwWprMeta>,
@@ -325,7 +325,7 @@ fn post_boot(
         &self,
         gsp: &Gsp,
         dev: &device::Device<device::Bound>,
-        bar: &Bar0,
+        bar: Bar0<'_>,
         gsp_fw: &GspFirmware,
         gsp_falcon: &Falcon<GspEngine>,
         sec2_falcon: &Falcon<Sec2>,
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core/gsp/sequencer.rs
index b3015483ed17..e0850d21adca 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -131,7 +131,7 @@ pub(crate) struct GspSequencer<'a> {
     /// Sequencer information with command data.
     seq_info: GspSequence,
     /// `Bar0` for register access.
-    bar: &'a Bar0,
+    bar: Bar0<'a>,
     /// SEC2 falcon for core operations.
     sec2_falcon: &'a Falcon<Sec2>,
     /// GSP falcon for core operations.
@@ -351,7 +351,7 @@ pub(crate) struct GspSequencerParams<'a> {
     /// Device for logging.
     pub(crate) dev: &'a device::Device,
     /// BAR0 for register access.
-    pub(crate) bar: &'a Bar0,
+    pub(crate) bar: Bar0<'a>,
 }
 
 impl<'a> GspSequencer<'a> {
diff --git a/drivers/gpu/nova-core/regs.rs b/drivers/gpu/nova-core/regs.rs
index 2cb1f02f35a4..5cab4ca67f3c 100644
--- a/drivers/gpu/nova-core/regs.rs
+++ b/drivers/gpu/nova-core/regs.rs
@@ -498,7 +498,7 @@ pub(crate) fn with_falcon_mem(self, mem: FalconMem) -> Self {
 
 impl NV_PFALCON_FALCON_ENGINE {
     /// Resets the falcon
-    pub(crate) fn reset_engine<E: FalconEngine>(bar: &Bar0) {
+    pub(crate) fn reset_engine<E: FalconEngine>(bar: Bar0<'_>) {
         bar.update(Self::of::<E>(), |r| r.with_reset(true));
 
         // TIMEOUT: falcon engine should not take more than 10us to reset.
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c0bc1008ed75..fd168c5da78c 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -58,7 +58,7 @@ fn try_from(code: u8) -> Result<Self> {
 /// Vbios Reader for constructing the VBIOS data.
 struct VbiosIterator<'a> {
     dev: &'a device::Device,
-    bar0: &'a Bar0,
+    bar0: Bar0<'a>,
     /// VBIOS data vector: As BIOS images are scanned, they are added to this vector for reference
     /// or copying into other data structures. It is the entire scanned contents of the VBIOS which
     /// progressively extends. It is used so that we do not re-read any contents that are already
@@ -90,7 +90,7 @@ impl<'a> VbiosIterator<'a> {
     /// so that PROM reads transparently skip the header. On GA100, for some reason, the IFR offset
     /// is not applied to PROM reads. Therefore, the search for the PCI expansion must skip the IFR
     /// header, if found.
-    fn rom_offset(dev: &device::Device, bar0: &Bar0) -> Result<usize> {
+    fn rom_offset(dev: &device::Device, bar0: Bar0<'_>) -> Result<usize> {
         // IFR Header in VBIOS.
         register! {
             NV_PBUS_IFR_FMT_FIXED0(u32) @ 0x300000 {
@@ -158,7 +158,7 @@ fn rom_offset(dev: &device::Device, bar0: &Bar0) -> Result<usize> {
         }
     }
 
-    fn new(dev: &'a device::Device, bar0: &'a Bar0) -> Result<Self> {
+    fn new(dev: &'a device::Device, bar0: Bar0<'a>) -> Result<Self> {
         Ok(Self {
             dev,
             bar0,
@@ -297,7 +297,7 @@ impl Vbios {
     /// Probe for VBIOS extraction.
     ///
     /// Once the VBIOS object is built, `bar0` is not read for [`Vbios`] purposes anymore.
-    pub(crate) fn new(dev: &device::Device, bar0: &Bar0) -> Result<Vbios> {
+    pub(crate) fn new(dev: &device::Device, bar0: Bar0<'_>) -> Result<Vbios> {
         // Images to extract from iteration
         let mut pci_at_image: Option<PciAtBiosImage> = None;
         let mut fwsec_section: Option<KVVec<u8>> = None;

base-commit: 4d789488d3bec3e2c6b7f282e29cfb1bec6b2c25
-- 
2.54.0

