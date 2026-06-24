Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120F5CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8262110F149;
	Thu, 25 Jun 2026 07:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=proton.me header.i=@proton.me header.b="l/gTiDOO";
	dkim-atps=neutral
X-Greylist: delayed 622 seconds by postgrey-1.36 at gabe;
 Wed, 24 Jun 2026 15:59:41 UTC
Received: from mail-244104.protonmail.ch (mail-244104.protonmail.ch
 [109.224.244.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2122610E0AD
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 15:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
 s=protonmail; t=1782316317; x=1782575517;
 bh=hxRw5ipziotItQ2/roHsYyI6m5cg12RlqqHRE5WMBX0=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=l/gTiDOOyDr8P8EWp1ioM5/1gT4qYasDuOGu0XTKi1Ecu5Pj52Mx3LaRTK7AHBloN
 Ulu959JqwAWQmFnKbS9NFO1NptDdRkcewoCfSgcCi1+lDaM1CYJo5WpDa0jFW8wUss
 BDBnRVDAeDPTVn1XBb6na9mlQpQ7OIrMJ+83qkgZlmEDOHy/qC7A4kiBdFGcHAk/hp
 dkzs+4mmQDLyLDgzqRPrsp6Sq5+pAKcBq/x3UxH5sjNXBeWIY/jON3HCBD4JQOMdlm
 GYO/0ct7x4gQaApRRxJ/FgMx33dzKDO0GoRCMZGvmkC6HZdyuCcLNzFxt12XrQ+glw
 2Qqh4BHeAnsng==
Date: Wed, 24 Jun 2026 15:51:49 +0000
To: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
From: Tim Kovalenko <tim.kovalenko@proton.me>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 Tim Kovalenko <tim.kovalenko@proton.me>
Subject: [PATCH] gpu: nova-core: falcon: store bar and dev in falcon
Message-ID: <20260624-drm-bar-refactor-v1-1-7062899163c5@proton.me>
Feedback-ID: 96458489:user:proton
X-Pm-Message-ID: 769483a5ed6cf2cfb81a332d85cb2c46ca513187
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 25 Jun 2026 07:03:17 +0000
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

Store the bound device and `BAR0` mapping in `Falcon` instead of passing
them through every `Falcon` operation. This simplifies the `Falcon` API and
removes repeated `dev`/`bar` plumbing from reset, load, boot, mailbox, DMA,
and GSP/FSP-specific Falcon helpers.

Add a named helper for configuring Falcon FBIF transaction slots for
physical coherent system memory, avoiding direct `BAR0` access from the
FWSEC bootloader path without exposing BAR0 publicly.

Future work / questions:

    - Focused only on the Falcon for this patch - more to follow.

    - Not sure about the FalconHal and if I should modify the Trait
        - Could be part of the next patch
        - But it could definitively be simplified

    - Also, how far should the refactor go and to what extend add new
      methods to avoid passing `bar` or `dev` but also not exposing them as
      pub. For `dev`, there's a lot of `dev_err` usage that requires us to
      pass it as a param.
        - I've created the `set_fbif_transcfg_phys_sysmem` method to
          address such issue and remove some code duplication but that
          method could be made a bit more generic.

    - Also, is there a reason why we are not passing the `GspBootContext`
      when we need stuff like `bar`, `dev` and both falcons?

Reported-by: Alexandre Courbot <acourbot@nvidia.com>
Closes: https://rust-for-linux.zulipchat.com/#narrow/channel/509436-Nova/to=
pic/Storing.20driver-bound.20references.20into.20sub-devices/near/599137882
Signed-off-by: Tim Kovalenko <tim.kovalenko@proton.me>
---
 drivers/gpu/nova-core/falcon.rs                    | 206 ++++++++++-------=
----
 drivers/gpu/nova-core/falcon/fsp.rs                |  44 +++--
 drivers/gpu/nova-core/falcon/gsp.rs                |  21 ++-
 drivers/gpu/nova-core/falcon/hal.rs                |   6 +-
 drivers/gpu/nova-core/falcon/hal/ga102.rs          |   8 +-
 drivers/gpu/nova-core/falcon/hal/tu102.rs          |   6 +-
 drivers/gpu/nova-core/firmware/booter.rs           |  25 +--
 drivers/gpu/nova-core/firmware/fwsec.rs            |  19 +-
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |  33 +---
 drivers/gpu/nova-core/fsp.rs                       |  23 ++-
 drivers/gpu/nova-core/gpu.rs                       |   9 +-
 drivers/gpu/nova-core/gsp.rs                       |   4 +-
 drivers/gpu/nova-core/gsp/boot.rs                  |  22 +--
 drivers/gpu/nova-core/gsp/hal.rs                   |   4 +-
 drivers/gpu/nova-core/gsp/hal/gh100.rs             |  32 ++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs             |  75 ++++----
 drivers/gpu/nova-core/gsp/sequencer.rs             |  31 ++--
 17 files changed, 253 insertions(+), 315 deletions(-)

diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falcon=
.rs
index 94c7696a6493..ca12cc11a370 100644
--- a/drivers/gpu/nova-core/falcon.rs
+++ b/drivers/gpu/nova-core/falcon.rs
@@ -5,10 +5,7 @@
 use hal::FalconHal;
=20
 use kernel::{
-    device::{
-        self,
-        Device, //
-    },
+    device,
     dma::{
         Coherent,
         CoherentBox,
@@ -24,7 +21,6 @@
         Io,
     },
     prelude::*,
-    sync::aref::ARef,
     time::Delta,
 };
=20
@@ -358,41 +354,47 @@ pub(crate) trait FalconFirmware {
 }
=20
 /// Contains the base parameters common to all Falcon instances.
-pub(crate) struct Falcon<E: FalconEngine> {
+pub(crate) struct Falcon<'a, E: FalconEngine> {
     hal: KBox<dyn FalconHal<E>>,
-    dev: ARef<device::Device>,
+    dev: &'a device::Device<device::Bound>,
+    bar: Bar0<'a>,
 }
=20
-impl<E: FalconEngine + 'static> Falcon<E> {
+impl<'a, E: FalconEngine + 'static> Falcon<'a, E> {
     /// Create a new falcon instance.
-    pub(crate) fn new(dev: &device::Device, chipset: Chipset) -> Result<Se=
lf> {
+    pub(crate) fn new(
+        dev: &'a device::Device<device::Bound>,
+        chipset: Chipset,
+        bar: Bar0<'a>,
+    ) -> Result<Self> {
         Ok(Self {
             hal: hal::falcon_hal(chipset)?,
-            dev: dev.into(),
+            dev,
+            bar,
         })
     }
=20
     /// Resets DMA-related registers.
-    pub(crate) fn dma_reset(&self, bar: Bar0<'_>) {
-        bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
+    pub(crate) fn dma_reset(&self) {
+        self.bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
             v.with_allow_phys_no_ctx(true)
         });
=20
-        bar.write(
+        self.bar.write(
             WithBase::of::<E>(),
             regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
         );
     }
=20
     /// Reset the controller, select the falcon core, and wait for memory =
scrubbing to complete.
-    pub(crate) fn reset(&self, bar: Bar0<'_>) -> Result {
-        self.hal.reset_eng(bar)?;
-        self.hal.select_core(self, bar)?;
-        self.hal.reset_wait_mem_scrubbing(bar)?;
+    pub(crate) fn reset(&self) -> Result {
+        self.hal.reset_eng(self.bar)?;
+        self.hal.select_core(self, self.bar)?;
+        self.hal.reset_wait_mem_scrubbing(self.bar)?;
=20
-        bar.write(
+        self.bar.write(
             WithBase::of::<E>(),
-            regs::NV_PFALCON_FALCON_RM::from(bar.read(regs::NV_PMC_BOOT_0)=
.into_raw()),
+            regs::NV_PFALCON_FALCON_RM::from(self.bar.read(regs::NV_PMC_BO=
OT_0).into_raw()),
         );
=20
         Ok(())
@@ -404,18 +406,14 @@ pub(crate) fn reset(&self, bar: Bar0<'_>) -> Result {
     /// Write a slice to Falcon IMEM memory using programmed I/O (PIO).
     ///
     /// Returns `EINVAL` if `img.len()` is not a multiple of 4.
-    fn pio_wr_imem_slice(
-        &self,
-        bar: Bar0<'_>,
-        load_offsets: FalconPioImemLoadTarget<'_>,
-    ) -> Result {
+    fn pio_wr_imem_slice(&self, load_offsets: FalconPioImemLoadTarget<'_>)=
 -> Result {
         // Rejecting misaligned images here allows us to avoid checking
         // inside the loops.
         if load_offsets.data.len() % 4 !=3D 0 {
             return Err(EINVAL);
         }
=20
-        bar.write(
+        self.bar.write(
             WithBase::of::<E>().at(Self::PIO_PORT),
             regs::NV_PFALCON_FALCON_IMEMC::zeroed()
                 .with_secure(load_offsets.secure)
@@ -426,13 +424,13 @@ fn pio_wr_imem_slice(
         for (n, block) in load_offsets.data.chunks(MEM_BLOCK_ALIGNMENT).en=
umerate() {
             let n =3D u16::try_from(n)?;
             let tag: u16 =3D load_offsets.start_tag.checked_add(n).ok_or(E=
RANGE)?;
-            bar.write(
+            self.bar.write(
                 WithBase::of::<E>().at(Self::PIO_PORT),
                 regs::NV_PFALCON_FALCON_IMEMT::zeroed().with_tag(tag),
             );
             for word in block.chunks_exact(4) {
                 let w =3D [word[0], word[1], word[2], word[3]];
-                bar.write(
+                self.bar.write(
                     WithBase::of::<E>().at(Self::PIO_PORT),
                     regs::NV_PFALCON_FALCON_IMEMD::zeroed().with_data(u32:=
:from_le_bytes(w)),
                 );
@@ -445,18 +443,14 @@ fn pio_wr_imem_slice(
     /// Write a slice to Falcon DMEM memory using programmed I/O (PIO).
     ///
     /// Returns `EINVAL` if `img.len()` is not a multiple of 4.
-    fn pio_wr_dmem_slice(
-        &self,
-        bar: Bar0<'_>,
-        load_offsets: FalconPioDmemLoadTarget<'_>,
-    ) -> Result {
+    fn pio_wr_dmem_slice(&self, load_offsets: FalconPioDmemLoadTarget<'_>)=
 -> Result {
         // Rejecting misaligned images here allows us to avoid checking
         // inside the loops.
         if load_offsets.data.len() % 4 !=3D 0 {
             return Err(EINVAL);
         }
=20
-        bar.write(
+        self.bar.write(
             WithBase::of::<E>().at(Self::PIO_PORT),
             regs::NV_PFALCON_FALCON_DMEMC::zeroed()
                 .with_aincw(true)
@@ -465,7 +459,7 @@ fn pio_wr_dmem_slice(
=20
         for word in load_offsets.data.chunks_exact(4) {
             let w =3D [word[0], word[1], word[2], word[3]];
-            bar.write(
+            self.bar.write(
                 WithBase::of::<E>().at(Self::PIO_PORT),
                 regs::NV_PFALCON_FALCON_DMEMD::zeroed().with_data(u32::fro=
m_le_bytes(w)),
             );
@@ -477,29 +471,28 @@ fn pio_wr_dmem_slice(
     /// Perform a PIO copy into `IMEM` and `DMEM` of `fw`, and prepare the=
 falcon to run it.
     pub(crate) fn pio_load<F: FalconFirmware<Target =3D E> + FalconPioLoad=
able>(
         &self,
-        bar: Bar0<'_>,
         fw: &F,
     ) -> Result {
-        bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
+        self.bar.update(regs::NV_PFALCON_FBIF_CTL::of::<E>(), |v| {
             v.with_allow_phys_no_ctx(true)
         });
=20
-        bar.write(
+        self.bar.write(
             WithBase::of::<E>(),
             regs::NV_PFALCON_FALCON_DMACTL::zeroed(),
         );
=20
         if let Some(imem_ns) =3D fw.imem_ns_load_params() {
-            self.pio_wr_imem_slice(bar, imem_ns)?;
+            self.pio_wr_imem_slice(imem_ns)?;
         }
         if let Some(imem_sec) =3D fw.imem_sec_load_params() {
-            self.pio_wr_imem_slice(bar, imem_sec)?;
+            self.pio_wr_imem_slice(imem_sec)?;
         }
-        self.pio_wr_dmem_slice(bar, fw.dmem_load_params())?;
+        self.pio_wr_dmem_slice(fw.dmem_load_params())?;
=20
-        self.hal.program_brom(self, bar, &fw.brom_params());
+        self.hal.program_brom(self, self.bar, &fw.brom_params());
=20
-        bar.write(
+        self.bar.write(
             WithBase::of::<E>(),
             regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_a=
ddr()),
         );
@@ -513,7 +506,6 @@ pub(crate) fn pio_load<F: FalconFirmware<Target =3D E> =
+ FalconPioLoadable>(
     /// `sec` is set if the loaded firmware is expected to run in secure m=
ode.
     fn dma_wr(
         &self,
-        bar: Bar0<'_>,
         dma_obj: &Coherent<[u8]>,
         target_mem: FalconMem,
         load_offsets: FalconDmaLoadTarget,
@@ -571,7 +563,7 @@ fn dma_wr(
=20
         // Set up the base source DMA address.
=20
-        bar.write(
+        self.bar.write(
             WithBase::of::<E>(),
             regs::NV_PFALCON_FALCON_DMATRFBASE::zeroed().with_base(
                 // CAST: `as u32` is used on purpose since we do want to s=
trip the upper bits,
@@ -579,7 +571,7 @@ fn dma_wr(
                 (dma_start >> 8) as u32,
             ),
         );
-        bar.write(
+        self.bar.write(
             WithBase::of::<E>(),
             regs::NV_PFALCON_FALCON_DMATRFBASE1::zeroed().try_with_base(dm=
a_start >> 40)?,
         );
@@ -590,23 +582,23 @@ fn dma_wr(
=20
         for pos in (0..num_transfers).map(|i| i * DMA_LEN) {
             // Perform a transfer of size `DMA_LEN`.
-            bar.write(
+            self.bar.write(
                 WithBase::of::<E>(),
                 regs::NV_PFALCON_FALCON_DMATRFMOFFS::zeroed()
                     .try_with_offs(load_offsets.dst_start + pos)?,
             );
-            bar.write(
+            self.bar.write(
                 WithBase::of::<E>(),
                 regs::NV_PFALCON_FALCON_DMATRFFBOFFS::zeroed().with_offs(s=
rc_start + pos),
             );
=20
-            bar.write(WithBase::of::<E>(), cmd);
+            self.bar.write(WithBase::of::<E>(), cmd);
=20
             // Wait for the transfer to complete.
             // TIMEOUT: arbitrarily large value, no DMA transfer to the fa=
lcon's small memories
             // should ever take that long.
             read_poll_timeout(
-                || Ok(bar.read(regs::NV_PFALCON_FALCON_DMATRFCMD::of::<E>(=
))),
+                || Ok(self.bar.read(regs::NV_PFALCON_FALCON_DMATRFCMD::of:=
:<E>())),
                 |r| r.idle(),
                 Delta::ZERO,
                 Delta::from_secs(2),
@@ -617,12 +609,7 @@ fn dma_wr(
     }
=20
     /// Perform a DMA load into `IMEM` and `DMEM` of `fw`, and prepare the=
 falcon to run it.
-    fn dma_load<F: FalconFirmware<Target =3D E> + FalconDmaLoadable>(
-        &self,
-        dev: &Device<device::Bound>,
-        bar: Bar0<'_>,
-        fw: &F,
-    ) -> Result {
+    fn dma_load<F: FalconFirmware<Target =3D E> + FalconDmaLoadable>(&self=
, fw: &F) -> Result {
         // DMA object with firmware content as the source of the DMA engin=
e.
         let dma_obj =3D {
             let fw_slice =3D fw.as_slice();
@@ -630,7 +617,7 @@ fn dma_load<F: FalconFirmware<Target =3D E> + FalconDma=
Loadable>(
             // DMA copies are done in chunks of `MEM_BLOCK_ALIGNMENT`, so =
pad the length
             // accordingly and fill with `0`.
             let mut dma_obj =3D CoherentBox::zeroed_slice(
-                dev,
+                self.dev,
                 fw_slice.len().next_multiple_of(MEM_BLOCK_ALIGNMENT),
                 GFP_KERNEL,
             )?;
@@ -642,24 +629,16 @@ fn dma_load<F: FalconFirmware<Target =3D E> + FalconD=
maLoadable>(
             dma_obj.into()
         };
=20
-        self.dma_reset(bar);
-        bar.update(regs::NV_PFALCON_FBIF_TRANSCFG::of::<E>().at(0), |v| {
-            v.with_target(FalconFbifTarget::CoherentSysmem)
-                .with_mem_type(FalconFbifMemType::Physical)
-        });
+        self.dma_reset();
+        self.set_fbif_transcfg_phys_sysmem(0)?;
=20
-        self.dma_wr(
-            bar,
-            &dma_obj,
-            FalconMem::ImemSecure,
-            fw.imem_sec_load_params(),
-        )?;
-        self.dma_wr(bar, &dma_obj, FalconMem::Dmem, fw.dmem_load_params())=
?;
+        self.dma_wr(&dma_obj, FalconMem::ImemSecure, fw.imem_sec_load_para=
ms())?;
+        self.dma_wr(&dma_obj, FalconMem::Dmem, fw.dmem_load_params())?;
=20
-        self.hal.program_brom(self, bar, &fw.brom_params());
+        self.hal.program_brom(self, self.bar, &fw.brom_params());
=20
         // Set `BootVec` to start of non-secure code.
-        bar.write(
+        self.bar.write(
             WithBase::of::<E>(),
             regs::NV_PFALCON_FALCON_BOOTVEC::zeroed().with_value(fw.boot_a=
ddr()),
         );
@@ -667,11 +646,26 @@ fn dma_load<F: FalconFirmware<Target =3D E> + FalconD=
maLoadable>(
         Ok(())
     }
=20
+    /// Configure a Falcon FBIF transaction slot to access physical cohere=
nt system memory.
+    pub(crate) fn set_fbif_transcfg_phys_sysmem(&self, dmaidx: u32) -> Res=
ult {
+        self.bar.update(
+            regs::NV_PFALCON_FBIF_TRANSCFG::of::<E>()
+                .try_at(usize::from_safe_cast(dmaidx))
+                .ok_or(EINVAL)?,
+            |v| {
+                v.with_target(FalconFbifTarget::CoherentSysmem)
+                    .with_mem_type(FalconFbifMemType::Physical)
+            },
+        );
+
+        Ok(())
+    }
+
     /// Wait until the falcon CPU is halted.
-    pub(crate) fn wait_till_halted(&self, bar: Bar0<'_>) -> Result<()> {
+    pub(crate) fn wait_till_halted(&self) -> Result<()> {
         // TIMEOUT: arbitrarily large value, firmwares should complete in =
less than 2 seconds.
         read_poll_timeout(
-            || Ok(bar.read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())),
+            || Ok(self.bar.read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())=
),
             |r| r.halted(),
             Delta::ZERO,
             Delta::from_secs(2),
@@ -681,16 +675,17 @@ pub(crate) fn wait_till_halted(&self, bar: Bar0<'_>) =
-> Result<()> {
     }
=20
     /// Start the falcon CPU.
-    pub(crate) fn start(&self, bar: Bar0<'_>) -> Result<()> {
-        match bar
+    pub(crate) fn start(&self) -> Result<()> {
+        match self
+            .bar
             .read(regs::NV_PFALCON_FALCON_CPUCTL::of::<E>())
             .alias_en()
         {
-            true =3D> bar.write(
+            true =3D> self.bar.write(
                 WithBase::of::<E>(),
                 regs::NV_PFALCON_FALCON_CPUCTL_ALIAS::zeroed().with_startc=
pu(true),
             ),
-            false =3D> bar.write(
+            false =3D> self.bar.write(
                 WithBase::of::<E>(),
                 regs::NV_PFALCON_FALCON_CPUCTL::zeroed().with_startcpu(tru=
e),
             ),
@@ -700,16 +695,16 @@ pub(crate) fn start(&self, bar: Bar0<'_>) -> Result<(=
)> {
     }
=20
     /// Writes values to the mailbox registers if provided.
-    pub(crate) fn write_mailboxes(&self, bar: Bar0<'_>, mbox0: Option<u32>=
, mbox1: Option<u32>) {
+    pub(crate) fn write_mailboxes(&self, mbox0: Option<u32>, mbox1: Option=
<u32>) {
         if let Some(mbox0) =3D mbox0 {
-            bar.write(
+            self.bar.write(
                 WithBase::of::<E>(),
                 regs::NV_PFALCON_FALCON_MAILBOX0::zeroed().with_value(mbox=
0),
             );
         }
=20
         if let Some(mbox1) =3D mbox1 {
-            bar.write(
+            self.bar.write(
                 WithBase::of::<E>(),
                 regs::NV_PFALCON_FALCON_MAILBOX1::zeroed().with_value(mbox=
1),
             );
@@ -717,21 +712,23 @@ pub(crate) fn write_mailboxes(&self, bar: Bar0<'_>, m=
box0: Option<u32>, mbox1: O
     }
=20
     /// Reads the value from `mbox0` register.
-    pub(crate) fn read_mailbox0(&self, bar: Bar0<'_>) -> u32 {
-        bar.read(regs::NV_PFALCON_FALCON_MAILBOX0::of::<E>())
+    pub(crate) fn read_mailbox0(&self) -> u32 {
+        self.bar
+            .read(regs::NV_PFALCON_FALCON_MAILBOX0::of::<E>())
             .value()
     }
=20
     /// Reads the value from `mbox1` register.
-    pub(crate) fn read_mailbox1(&self, bar: Bar0<'_>) -> u32 {
-        bar.read(regs::NV_PFALCON_FALCON_MAILBOX1::of::<E>())
+    pub(crate) fn read_mailbox1(&self) -> u32 {
+        self.bar
+            .read(regs::NV_PFALCON_FALCON_MAILBOX1::of::<E>())
             .value()
     }
=20
     /// Reads values from both mailbox registers.
-    pub(crate) fn read_mailboxes(&self, bar: Bar0<'_>) -> (u32, u32) {
-        let mbox0 =3D self.read_mailbox0(bar);
-        let mbox1 =3D self.read_mailbox1(bar);
+    pub(crate) fn read_mailboxes(&self) -> (u32, u32) {
+        let mbox0 =3D self.read_mailbox0();
+        let mbox1 =3D self.read_mailbox1();
=20
         (mbox0, mbox1)
     }
@@ -743,54 +740,43 @@ pub(crate) fn read_mailboxes(&self, bar: Bar0<'_>) ->=
 (u32, u32) {
     ///
     /// Wait up to two seconds for the firmware to complete, and return it=
s exit status read from
     /// the `MBOX0` and `MBOX1` registers.
-    pub(crate) fn boot(
-        &self,
-        bar: Bar0<'_>,
-        mbox0: Option<u32>,
-        mbox1: Option<u32>,
-    ) -> Result<(u32, u32)> {
-        self.write_mailboxes(bar, mbox0, mbox1);
-        self.start(bar)?;
-        self.wait_till_halted(bar)?;
-        Ok(self.read_mailboxes(bar))
+    pub(crate) fn boot(&self, mbox0: Option<u32>, mbox1: Option<u32>) -> R=
esult<(u32, u32)> {
+        self.write_mailboxes(mbox0, mbox1);
+        self.start()?;
+        self.wait_till_halted()?;
+        Ok(self.read_mailboxes())
     }
=20
     /// Returns the fused version of the signature to use in order to run =
a HS firmware on this
     /// falcon instance. `engine_id_mask` and `ucode_id` are obtained from=
 the firmware header.
     pub(crate) fn signature_reg_fuse_version(
         &self,
-        bar: Bar0<'_>,
         engine_id_mask: u16,
         ucode_id: u8,
     ) -> Result<u32> {
         self.hal
-            .signature_reg_fuse_version(self, bar, engine_id_mask, ucode_i=
d)
+            .signature_reg_fuse_version(self, self.bar, engine_id_mask, uc=
ode_id)
     }
=20
     /// Check if the RISC-V core is active.
     ///
     /// Returns `true` if the RISC-V core is active, `false` otherwise.
-    pub(crate) fn is_riscv_active(&self, bar: Bar0<'_>) -> bool {
-        self.hal.is_riscv_active(bar)
+    pub(crate) fn is_riscv_active(&self) -> bool {
+        self.hal.is_riscv_active(self.bar)
     }
=20
     /// Load a firmware image into Falcon memory, using the preferred meth=
od for the current
     /// chipset.
-    pub(crate) fn load<F: FalconFirmware<Target =3D E> + FalconDmaLoadable=
>(
-        &self,
-        dev: &Device<device::Bound>,
-        bar: Bar0<'_>,
-        fw: &F,
-    ) -> Result {
+    pub(crate) fn load<F: FalconFirmware<Target =3D E> + FalconDmaLoadable=
>(&self, fw: &F) -> Result {
         match self.hal.load_method() {
-            LoadMethod::Dma =3D> self.dma_load(dev, bar, fw),
-            LoadMethod::Pio =3D> self.pio_load(bar, &fw.try_as_pio_loadabl=
e()?),
+            LoadMethod::Dma =3D> self.dma_load(fw),
+            LoadMethod::Pio =3D> self.pio_load(&fw.try_as_pio_loadable()?)=
,
         }
     }
=20
     /// Write the application version to the OS register.
-    pub(crate) fn write_os_version(&self, bar: Bar0<'_>, app_version: u32)=
 {
-        bar.write(
+    pub(crate) fn write_os_version(&self, app_version: u32) {
+        self.bar.write(
             WithBase::of::<E>(),
             regs::NV_PFALCON_FALCON_OS::zeroed().with_value(app_version),
         );
diff --git a/drivers/gpu/nova-core/falcon/fsp.rs b/drivers/gpu/nova-core/fa=
lcon/fsp.rs
index 52cdb84ef0e8..53b1079843ae 100644
--- a/drivers/gpu/nova-core/falcon/fsp.rs
+++ b/drivers/gpu/nova-core/falcon/fsp.rs
@@ -21,7 +21,6 @@
 };
=20
 use crate::{
-    driver::Bar0,
     falcon::{
         Falcon,
         FalconEngine,
@@ -48,18 +47,18 @@ impl RegisterBase<PFalcon2Base> for Fsp {
=20
 impl FalconEngine for Fsp {}
=20
-impl Falcon<Fsp> {
+impl<'a> Falcon<'a, Fsp> {
     /// Writes `data` to FSP external memory at offset `0`.
     ///
     /// `data` is interpreted as little-endian 32-bit words. Returns `EINV=
AL`
     /// if the `data` length is not 4-byte aligned.
-    fn write_emem(&mut self, bar: Bar0<'_>, data: &[u8]) -> Result {
+    fn write_emem(&mut self, data: &[u8]) -> Result {
         if data.len() % 4 !=3D 0 {
             return Err(EINVAL);
         }
=20
         // Begin a write burst at offset `0`, auto-incrementing on each wr=
ite.
-        bar.write(
+        self.bar.write(
             WithBase::of::<Fsp>(),
             regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincw(true),
         );
@@ -68,7 +67,7 @@ fn write_emem(&mut self, bar: Bar0<'_>, data: &[u8]) -> R=
esult {
             let value =3D u32::from_le_bytes([chunk[0], chunk[1], chunk[2]=
, chunk[3]]);
=20
             // Write the next 32-bit `value`; hardware advances the offset=
.
-            bar.write(
+            self.bar.write(
                 WithBase::of::<Fsp>(),
                 regs::NV_PFALCON_FALCON_EMEMD::zeroed().with_data(value),
             );
@@ -81,20 +80,23 @@ fn write_emem(&mut self, bar: Bar0<'_>, data: &[u8]) ->=
 Result {
     ///
     /// `data` is stored as little-endian 32-bit words. Returns `EINVAL` i=
f
     /// the `data` length is not 4-byte aligned.
-    fn read_emem(&mut self, bar: Bar0<'_>, data: &mut [u8]) -> Result {
+    fn read_emem(&mut self, data: &mut [u8]) -> Result {
         if data.len() % 4 !=3D 0 {
             return Err(EINVAL);
         }
=20
         // Begin a read burst at offset `0`, auto-incrementing on each rea=
d.
-        bar.write(
+        self.bar.write(
             WithBase::of::<Fsp>(),
             regs::NV_PFALCON_FALCON_EMEMC::zeroed().with_aincr(true),
         );
=20
         for chunk in data.chunks_exact_mut(4) {
             // Read the next 32-bit word; hardware advances the offset.
-            let value =3D bar.read(regs::NV_PFALCON_FALCON_EMEMD::of::<Fsp=
>()).data();
+            let value =3D self
+                .bar
+                .read(regs::NV_PFALCON_FALCON_EMEMD::of::<Fsp>())
+                .data();
             chunk.copy_from_slice(&value.to_le_bytes());
         }
=20
@@ -107,9 +109,9 @@ fn read_emem(&mut self, bar: Bar0<'_>, data: &mut [u8])=
 -> Result {
     ///
     /// The FSP message queue is not circular. Pointers are reset to 0 aft=
er each
     /// message exchange, so `tail >=3D head` is always true when data is =
present.
-    fn poll_msgq(&self, bar: Bar0<'_>) -> u32 {
-        let head =3D bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).val();
-        let tail =3D bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).val();
+    fn poll_msgq(&self) -> u32 {
+        let head =3D self.bar.read(regs::NV_PFSP_MSGQ_HEAD::at(0)).val();
+        let tail =3D self.bar.read(regs::NV_PFSP_MSGQ_TAIL::at(0)).val();
=20
         if head =3D=3D tail {
             return 0;
@@ -122,20 +124,20 @@ fn poll_msgq(&self, bar: Bar0<'_>) -> u32 {
     /// Writes `packet` to FSP EMEM and updates the queue pointers to noti=
fy FSP.
     ///
     /// Returns `EINVAL` if `packet` is empty or its length is not 4-byte =
aligned.
-    pub(crate) fn send_msg(&mut self, bar: Bar0<'_>, packet: &[u8]) -> Res=
ult {
+    pub(crate) fn send_msg(&mut self, packet: &[u8]) -> Result {
         if packet.is_empty() {
             return Err(EINVAL);
         }
=20
-        self.write_emem(bar, packet)?;
+        self.write_emem(packet)?;
=20
         // Update queue pointers. TAIL points at the last DWORD written.
         let tail_offset =3D u32::try_from(packet.len() - 4).map_err(|_| EI=
NVAL)?;
-        bar.write(
+        self.bar.write(
             Array::at(0),
             regs::NV_PFSP_QUEUE_TAIL::zeroed().with_address(tail_offset),
         );
-        bar.write(
+        self.bar.write(
             Array::at(0),
             regs::NV_PFSP_QUEUE_HEAD::zeroed().with_address(0),
         );
@@ -148,9 +150,9 @@ pub(crate) fn send_msg(&mut self, bar: Bar0<'_>, packet=
: &[u8]) -> Result {
     ///
     /// Returns `ETIMEDOUT` if no message was available until timeout, or =
a regular error code if a
     /// memory allocation error occurred.
-    pub(crate) fn recv_msg(&mut self, bar: Bar0<'_>) -> Result<KVec<u8>> {
+    pub(crate) fn recv_msg(&mut self) -> Result<KVec<u8>> {
         let msg_size =3D read_poll_timeout(
-            || Ok(self.poll_msgq(bar)),
+            || Ok(self.poll_msgq()),
             |&size| size > 0,
             Delta::from_millis(10),
             Delta::from_millis(FSP_MSG_TIMEOUT_MS),
@@ -160,11 +162,13 @@ pub(crate) fn recv_msg(&mut self, bar: Bar0<'_>) -> R=
esult<KVec<u8>> {
         let mut buffer =3D KVec::<u8>::new();
         buffer.resize(msg_size, 0, GFP_KERNEL)?;
=20
-        self.read_emem(bar, &mut buffer)?;
+        self.read_emem(&mut buffer)?;
=20
         // Reset message queue pointers after reading.
-        bar.write(Array::at(0), regs::NV_PFSP_MSGQ_TAIL::zeroed().with_val=
(0));
-        bar.write(Array::at(0), regs::NV_PFSP_MSGQ_HEAD::zeroed().with_val=
(0));
+        self.bar
+            .write(Array::at(0), regs::NV_PFSP_MSGQ_TAIL::zeroed().with_va=
l(0));
+        self.bar
+            .write(Array::at(0), regs::NV_PFSP_MSGQ_HEAD::zeroed().with_va=
l(0));
=20
         Ok(buffer)
     }
diff --git a/drivers/gpu/nova-core/falcon/gsp.rs b/drivers/gpu/nova-core/fa=
lcon/gsp.rs
index f788b87bd951..ae32f401aeb0 100644
--- a/drivers/gpu/nova-core/falcon/gsp.rs
+++ b/drivers/gpu/nova-core/falcon/gsp.rs
@@ -14,7 +14,6 @@
 };
=20
 use crate::{
-    driver::Bar0,
     falcon::{
         Falcon,
         FalconEngine,
@@ -37,20 +36,20 @@ impl RegisterBase<PFalcon2Base> for Gsp {
=20
 impl FalconEngine for Gsp {}
=20
-impl Falcon<Gsp> {
+impl<'a> Falcon<'a, Gsp> {
     /// Clears the SWGEN0 bit in the Falcon's IRQ status clear register to
     /// allow GSP to signal CPU for processing new messages in message que=
ue.
-    pub(crate) fn clear_swgen0_intr(&self, bar: Bar0<'_>) {
-        bar.write(
+    pub(crate) fn clear_swgen0_intr(&self) {
+        self.bar.write(
             WithBase::of::<Gsp>(),
             regs::NV_PFALCON_FALCON_IRQSCLR::zeroed().with_swgen0(true),
         );
     }
=20
     /// Checks if GSP reload/resume has completed during the boot process.
-    pub(crate) fn check_reload_completed(&self, bar: Bar0<'_>, timeout: De=
lta) -> Result<bool> {
+    pub(crate) fn check_reload_completed(&self, timeout: Delta) -> Result<=
bool> {
         read_poll_timeout(
-            || Ok(bar.read(regs::NV_PGC6_BSI_SECURE_SCRATCH_14)),
+            || Ok(self.bar.read(regs::NV_PGC6_BSI_SECURE_SCRATCH_14)),
             |val| val.boot_stage_3_handoff(),
             Delta::ZERO,
             timeout,
@@ -59,19 +58,21 @@ pub(crate) fn check_reload_completed(&self, bar: Bar0<'=
_>, timeout: Delta) -> Re
     }
=20
     /// Returns whether the RISC-V branch privilege lockdown bit is set.
-    pub(crate) fn riscv_branch_privilege_lockdown(&self, bar: Bar0<'_>) ->=
 bool {
-        bar.read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
+    pub(crate) fn riscv_branch_privilege_lockdown(&self) -> bool {
+        self.bar
+            .read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
             .riscv_br_priv_lockdown()
     }
=20
     /// Returns whether GSP registers can be read by the CPU.
-    pub(crate) fn priv_target_mask_released(&self, bar: Bar0<'_>) -> bool =
{
+    pub(crate) fn priv_target_mask_released(&self) -> bool {
         /// Pattern returned by GSP register reads while the PRIV target m=
ask still blocks CPU
         /// access. The low byte varies; the upper 24 bits are fixed.
         const LOCKED_PATTERN: u32 =3D 0xbadf_4100;
         const LOCKED_MASK: u32 =3D 0xffff_ff00;
=20
-        let hwcfg2 =3D bar
+        let hwcfg2 =3D self
+            .bar
             .read(regs::NV_PFALCON_FALCON_HWCFG2::of::<Gsp>())
             .into_raw();
=20
diff --git a/drivers/gpu/nova-core/falcon/hal.rs b/drivers/gpu/nova-core/fa=
lcon/hal.rs
index 89b56823906b..0cb665162c90 100644
--- a/drivers/gpu/nova-core/falcon/hal.rs
+++ b/drivers/gpu/nova-core/falcon/hal.rs
@@ -34,7 +34,7 @@ pub(crate) enum LoadMethod {
 /// registers.
 pub(crate) trait FalconHal<E: FalconEngine>: Send + Sync {
     /// Activates the Falcon core if the engine is a risvc/falcon dual eng=
ine.
-    fn select_core(&self, _falcon: &Falcon<E>, _bar: Bar0<'_>) -> Result {
+    fn select_core(&self, _falcon: &Falcon<'_, E>, _bar: Bar0<'_>) -> Resu=
lt {
         Ok(())
     }
=20
@@ -42,14 +42,14 @@ fn select_core(&self, _falcon: &Falcon<E>, _bar: Bar0<'=
_>) -> Result {
     /// falcon instance. `engine_id_mask` and `ucode_id` are obtained from=
 the firmware header.
     fn signature_reg_fuse_version(
         &self,
-        falcon: &Falcon<E>,
+        falcon: &Falcon<'_, E>,
         bar: Bar0<'_>,
         engine_id_mask: u16,
         ucode_id: u8,
     ) -> Result<u32>;
=20
     /// Program the boot ROM registers prior to starting a secure firmware=
.
-    fn program_brom(&self, falcon: &Falcon<E>, bar: Bar0<'_>, params: &Fal=
conBromParams);
+    fn program_brom(&self, falcon: &Falcon<'_, E>, bar: Bar0<'_>, params: =
&FalconBromParams);
=20
     /// Check if the RISC-V core is active.
     /// Returns `true` if the RISC-V core is active, `false` otherwise.
diff --git a/drivers/gpu/nova-core/falcon/hal/ga102.rs b/drivers/gpu/nova-c=
ore/falcon/hal/ga102.rs
index cf6ce47e6b25..e45adb0312c0 100644
--- a/drivers/gpu/nova-core/falcon/hal/ga102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/ga102.rs
@@ -115,21 +115,21 @@ pub(super) fn new() -> Self {
 }
=20
 impl<E: FalconEngine> FalconHal<E> for Ga102<E> {
-    fn select_core(&self, _falcon: &Falcon<E>, bar: Bar0<'_>) -> Result {
+    fn select_core(&self, _falcon: &Falcon<'_, E>, bar: Bar0<'_>) -> Resul=
t {
         select_core_ga102::<E>(bar)
     }
=20
     fn signature_reg_fuse_version(
         &self,
-        falcon: &Falcon<E>,
+        falcon: &Falcon<'_, E>,
         bar: Bar0<'_>,
         engine_id_mask: u16,
         ucode_id: u8,
     ) -> Result<u32> {
-        signature_reg_fuse_version_ga102(&falcon.dev, bar, engine_id_mask,=
 ucode_id)
+        signature_reg_fuse_version_ga102(falcon.dev, bar, engine_id_mask, =
ucode_id)
     }
=20
-    fn program_brom(&self, _falcon: &Falcon<E>, bar: Bar0<'_>, params: &Fa=
lconBromParams) {
+    fn program_brom(&self, _falcon: &Falcon<'_, E>, bar: Bar0<'_>, params:=
 &FalconBromParams) {
         program_brom_ga102::<E>(bar, params);
     }
=20
diff --git a/drivers/gpu/nova-core/falcon/hal/tu102.rs b/drivers/gpu/nova-c=
ore/falcon/hal/tu102.rs
index 3aaee3869312..de48ded45bbe 100644
--- a/drivers/gpu/nova-core/falcon/hal/tu102.rs
+++ b/drivers/gpu/nova-core/falcon/hal/tu102.rs
@@ -34,13 +34,13 @@ pub(super) fn new() -> Self {
 }
=20
 impl<E: FalconEngine> FalconHal<E> for Tu102<E> {
-    fn select_core(&self, _falcon: &Falcon<E>, _bar: Bar0<'_>) -> Result {
+    fn select_core(&self, _falcon: &Falcon<'_, E>, _bar: Bar0<'_>) -> Resu=
lt {
         Ok(())
     }
=20
     fn signature_reg_fuse_version(
         &self,
-        _falcon: &Falcon<E>,
+        _falcon: &Falcon<'_, E>,
         _bar: Bar0<'_>,
         _engine_id_mask: u16,
         _ucode_id: u8,
@@ -48,7 +48,7 @@ fn signature_reg_fuse_version(
         Ok(0)
     }
=20
-    fn program_brom(&self, _falcon: &Falcon<E>, _bar: Bar0<'_>, _params: &=
FalconBromParams) {}
+    fn program_brom(&self, _falcon: &Falcon<'_, E>, _bar: Bar0<'_>, _param=
s: &FalconBromParams) {}
=20
     fn is_riscv_active(&self, bar: Bar0<'_>) -> bool {
         bar.read(regs::NV_PRISCV_RISCV_CORE_SWITCH_RISCV_STATUS::of::<E>()=
)
diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-co=
re/firmware/booter.rs
index d9313ac361af..acb7f4d8a532 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -15,7 +15,6 @@
 };
=20
 use crate::{
-    driver::Bar0,
     falcon::{
         sec2::Sec2,
         Falcon,
@@ -293,8 +292,7 @@ pub(crate) fn new(
         kind: BooterKind,
         chipset: Chipset,
         ver: &str,
-        falcon: &Falcon<<Self as FalconFirmware>::Target>,
-        bar: Bar0<'_>,
+        falcon: &Falcon<'_, <Self as FalconFirmware>::Target>,
     ) -> Result<Self> {
         let fw_name =3D match kind {
             BooterKind::Loader =3D> "booter_load",
@@ -339,11 +337,8 @@ pub(crate) fn new(
             } else {
                 // Obtain the version from the fuse register, and extract =
the corresponding
                 // signature.
-                let reg_fuse_version =3D falcon.signature_reg_fuse_version=
(
-                    bar,
-                    brom_params.engine_id_mask,
-                    brom_params.ucode_id,
-                )?;
+                let reg_fuse_version =3D falcon
+                    .signature_reg_fuse_version(brom_params.engine_id_mask=
, brom_params.ucode_id)?;
=20
                 // `0` means the last signature should be used.
                 const FUSE_VERSION_USE_LAST_SIG: u32 =3D 0;
@@ -405,18 +400,14 @@ pub(crate) fn new(
     pub(crate) fn run<T>(
         &self,
         dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        sec2_falcon: &Falcon<Sec2>,
+        sec2_falcon: &Falcon<'_, Sec2>,
         wpr_meta: &Coherent<T>,
     ) -> Result {
-        sec2_falcon.reset(bar)?;
-        sec2_falcon.load(dev, bar, self)?;
+        sec2_falcon.reset()?;
+        sec2_falcon.load(self)?;
         let wpr_handle =3D wpr_meta.dma_handle();
-        let (mbox0, mbox1) =3D sec2_falcon.boot(
-            bar,
-            Some(wpr_handle as u32),
-            Some((wpr_handle >> 32) as u32),
-        )?;
+        let (mbox0, mbox1) =3D
+            sec2_falcon.boot(Some(wpr_handle as u32), Some((wpr_handle >> =
32) as u32))?;
         dev_dbg!(dev, "SEC2 MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
=20
         if mbox0 !=3D 0 {
diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-cor=
e/firmware/fwsec.rs
index 199ae2adb664..95e0dd77746b 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -27,7 +27,6 @@
 };
=20
 use crate::{
-    driver::Bar0,
     falcon::{
         gsp::Gsp,
         Falcon,
@@ -320,8 +319,7 @@ impl FwsecFirmware {
     /// command.
     pub(crate) fn new(
         dev: &Device<device::Bound>,
-        falcon: &Falcon<Gsp>,
-        bar: Bar0<'_>,
+        falcon: &Falcon<'_, Gsp>,
         bios: &Vbios,
         cmd: FwsecCommand,
     ) -> Result<Self> {
@@ -337,7 +335,7 @@ pub(crate) fn new(
                 .ok_or(EINVAL)?;
             let desc_sig_versions =3D u32::from(desc.signature_versions())=
;
             let reg_fuse_version =3D
-                falcon.signature_reg_fuse_version(bar, desc.engine_id_mask=
(), desc.ucode_id())?;
+                falcon.signature_reg_fuse_version(desc.engine_id_mask(), d=
esc.ucode_id())?;
             dev_dbg!(
                 dev,
                 "desc_sig_versions: {:#x}, reg_fuse_version: {}\n",
@@ -390,21 +388,16 @@ pub(crate) fn new(
     /// This must only be called on chipsets that do not need the FWSEC bo=
otloader (i.e., where
     /// [`Chipset::needs_fwsec_bootloader()`](crate::gpu::Chipset::needs_f=
wsec_bootloader) returns
     /// `false`). On chipsets that do, use [`bootloader::FwsecFirmwareWith=
Bl`] instead.
-    pub(crate) fn run(
-        &self,
-        dev: &Device<device::Bound>,
-        falcon: &Falcon<Gsp>,
-        bar: Bar0<'_>,
-    ) -> Result<()> {
+    pub(crate) fn run(&self, dev: &Device<device::Bound>, falcon: &Falcon<=
'_, Gsp>) -> Result<()> {
         // Reset falcon, load the firmware, and run it.
         falcon
-            .reset(bar)
+            .reset()
             .inspect_err(|e| dev_err!(dev, "Failed to reset GSP falcon: {:=
?}\n", e))?;
         falcon
-            .load(dev, bar, self)
+            .load(self)
             .inspect_err(|e| dev_err!(dev, "Failed to load FWSEC firmware:=
 {:?}\n", e))?;
         let (mbox0, _) =3D falcon
-            .boot(bar, Some(0), None)
+            .boot(Some(0), None)
             .inspect_err(|e| dev_err!(dev, "Failed to boot FWSEC firmware:=
 {:?}\n", e))?;
         if mbox0 !=3D 0 {
             dev_err!(dev, "FWSEC firmware returned error {}\n", mbox0);
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/g=
pu/nova-core/firmware/fwsec/bootloader.rs
index ac1558a83b83..71f5a70a1114 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -12,10 +12,6 @@
         Device, //
     },
     dma::Coherent,
-    io::{
-        register::WithBase, //
-        Io,
-    },
     prelude::*,
     ptr::{
         Alignable,
@@ -29,15 +25,12 @@
 };
=20
 use crate::{
-    driver::Bar0,
     falcon::{
         self,
         gsp::Gsp,
         Falcon,
         FalconBromParams,
         FalconDmaLoadable,
-        FalconFbifMemType,
-        FalconFbifTarget,
         FalconFirmware,
         FalconPioDmemLoadTarget,
         FalconPioImemLoadTarget,
@@ -50,8 +43,7 @@
         FIRMWARE_VERSION, //
     },
     gpu::Chipset,
-    num::FromSafeCast,
-    regs,
+    num::FromSafeCast, //
 };
=20
 /// Descriptor used by RM to figure out the requirements of the boot loade=
r.
@@ -275,33 +267,20 @@ pub(crate) fn new(
     ///
     /// The bootloader will load the FWSEC firmware and then execute it. T=
his function returns
     /// after FWSEC has reached completion.
-    pub(crate) fn run(
-        &self,
-        dev: &Device<device::Bound>,
-        falcon: &Falcon<Gsp>,
-        bar: Bar0<'_>,
-    ) -> Result<()> {
+    pub(crate) fn run(&self, dev: &Device<device::Bound>, falcon: &Falcon<=
'_, Gsp>) -> Result<()> {
         // Reset falcon, load the firmware, and run it.
         falcon
-            .reset(bar)
+            .reset()
             .inspect_err(|e| dev_err!(dev, "Failed to reset GSP falcon: {:=
?}\n", e))?;
         falcon
-            .pio_load(bar, self)
+            .pio_load(self)
             .inspect_err(|e| dev_err!(dev, "Failed to load FWSEC firmware:=
 {:?}\n", e))?;
=20
         // Configure DMA index for the bootloader to fetch the FWSEC firmw=
are from system memory.
-        bar.update(
-            regs::NV_PFALCON_FBIF_TRANSCFG::of::<Gsp>()
-                .try_at(usize::from_safe_cast(self.dmem_desc.ctx_dma))
-                .ok_or(EINVAL)?,
-            |v| {
-                v.with_target(FalconFbifTarget::CoherentSysmem)
-                    .with_mem_type(FalconFbifMemType::Physical)
-            },
-        );
+        falcon.set_fbif_transcfg_phys_sysmem(self.dmem_desc.ctx_dma)?;
=20
         let (mbox0, _) =3D falcon
-            .boot(bar, Some(0), None)
+            .boot(Some(0), None)
             .inspect_err(|e| dev_err!(dev, "Failed to boot FWSEC firmware:=
 {:?}\n", e))?;
         if mbox0 !=3D 0 {
             dev_err!(dev, "FWSEC firmware returned error {}\n", mbox0);
diff --git a/drivers/gpu/nova-core/fsp.rs b/drivers/gpu/nova-core/fsp.rs
index 4b97d1fb505e..574e1627e63c 100644
--- a/drivers/gpu/nova-core/fsp.rs
+++ b/drivers/gpu/nova-core/fsp.rs
@@ -224,27 +224,27 @@ pub(crate) fn boot_params_dma_handle(&self) -> u64 {
 /// An `Fsp` is produced by [`Fsp::wait_secure_boot`], which only returns =
once FSP secure boot
 /// has completed. It owns the FSP falcon and the FMC firmware, which are =
used for the subsequent
 /// Chain of Trust boot.
-pub(crate) struct Fsp {
-    falcon: Falcon<FspEngine>,
+pub(crate) struct Fsp<'a> {
+    falcon: Falcon<'a, FspEngine>,
     fsp_fw: FspFirmware,
 }
=20
-impl Fsp {
+impl<'a> Fsp<'a> {
     /// Waits for FSP secure boot completion, then returns the [`Fsp`] int=
erface.
     ///
     /// Polls the thermal scratch register until FSP signals boot completi=
on or the timeout
     /// elapses. Returning an [`Fsp`] only on success guarantees, at the A=
PI level, that the
     /// interface is not used before secure boot has completed.
     pub(crate) fn wait_secure_boot(
-        dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
+        dev: &'a device::Device<device::Bound>,
+        bar: Bar0<'a>,
         chipset: Chipset,
-    ) -> Result<Fsp> {
+    ) -> Result<Fsp<'a>> {
         /// FSP secure boot completion timeout in milliseconds.
         const FSP_SECURE_BOOT_TIMEOUT_MS: i64 =3D 5000;
=20
         let hal =3D hal::fsp_hal(chipset).ok_or(ENOTSUPP)?;
-        let falcon =3D Falcon::<FspEngine>::new(dev, chipset)?;
+        let falcon =3D Falcon::<FspEngine>::new(dev, chipset, bar)?;
         let fsp_fw =3D FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?;
=20
         read_poll_timeout(
@@ -262,13 +262,13 @@ pub(crate) fn wait_secure_boot(
=20
     /// Sends a message to FSP and waits for the response.
     /// Returns the full response buffer on success.
-    fn send_sync_fsp<M>(&mut self, dev: &device::Device, bar: Bar0<'_>, ms=
g: &M) -> Result<KVec<u8>>
+    fn send_sync_fsp<M>(&mut self, dev: &device::Device, msg: &M) -> Resul=
t<KVec<u8>>
     where
         M: MessageToFsp,
     {
-        self.falcon.send_msg(bar, msg.as_bytes())?;
+        self.falcon.send_msg(msg.as_bytes())?;
=20
-        let response_buf =3D self.falcon.recv_msg(bar).inspect_err(|e| {
+        let response_buf =3D self.falcon.recv_msg().inspect_err(|e| {
             dev_err!(dev, "FSP response error: {:?}\n", e);
         })?;
=20
@@ -330,7 +330,6 @@ fn send_sync_fsp<M>(&mut self, dev: &device::Device, ba=
r: Bar0<'_>, msg: &M) ->
     pub(crate) fn boot_fmc(
         &mut self,
         dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
         fb_layout: &FbLayout,
         args: &FmcBootArgs,
     ) -> Result {
@@ -341,7 +340,7 @@ pub(crate) fn boot_fmc(
             GFP_KERNEL,
         )?;
=20
-        let _response_buf =3D self.send_sync_fsp(dev, bar, &*msg)?;
+        let _response_buf =3D self.send_sync_fsp(dev, &*msg)?;
=20
         dev_dbg!(dev, "FSP Chain of Trust completed successfully\n");
         Ok(())
diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
index 4d76be429e75..43c3f4f8df71 100644
--- a/drivers/gpu/nova-core/gpu.rs
+++ b/drivers/gpu/nova-core/gpu.rs
@@ -273,9 +273,9 @@ struct GspResources<'gpu> {
     /// MMIO mapping of PCI BAR 0.
     bar: Bar0<'gpu>,
     /// GSP falcon instance, used for GSP boot up and cleanup.
-    gsp_falcon: Falcon<GspFalcon>,
+    gsp_falcon: Falcon<'gpu, GspFalcon>,
     /// SEC2 falcon instance, used for GSP boot up and cleanup.
-    sec2_falcon: Falcon<Sec2Falcon>,
+    sec2_falcon: Falcon<'gpu, Sec2Falcon>,
     /// GSP runtime data.
     #[pin]
     gsp: Gsp,
@@ -351,10 +351,11 @@ pub(crate) fn new(
                 gsp_falcon: Falcon::new(
                     pdev.as_ref(),
                     spec.chipset,
+                    bar
                 )
-                .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
+                .inspect(|falcon| falcon.clear_swgen0_intr())?,
=20
-                sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset)?,
+                sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset, bar)=
?,
=20
                 gsp <- Gsp::new(pdev),
=20
diff --git a/drivers/gpu/nova-core/gsp.rs b/drivers/gpu/nova-core/gsp.rs
index 73e93403601c..b4ac4156056e 100644
--- a/drivers/gpu/nova-core/gsp.rs
+++ b/drivers/gpu/nova-core/gsp.rs
@@ -57,8 +57,8 @@ pub(crate) struct GspBootContext<'a> {
     pub(crate) pdev: &'a pci::Device<device::Bound>,
     pub(crate) bar: Bar0<'a>,
     pub(crate) chipset: Chipset,
-    pub(crate) gsp_falcon: &'a Falcon<GspFalcon>,
-    pub(crate) sec2_falcon: &'a Falcon<Sec2Falcon>,
+    pub(crate) gsp_falcon: &'a Falcon<'a, GspFalcon>,
+    pub(crate) sec2_falcon: &'a Falcon<'a, Sec2Falcon>,
 }
=20
 impl<'a> GspBootContext<'a> {
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/=
boot.rs
index bb2000b7a78b..ab0491b57944 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -37,8 +37,8 @@ pub(super) struct BootUnloadArgs<'a> {
     gsp: &'a super::Gsp,
     dev: &'a device::Device<device::Bound>,
     bar: Bar0<'a>,
-    gsp_falcon: &'a Falcon<Gsp>,
-    sec2_falcon: &'a Falcon<Sec2>,
+    gsp_falcon: &'a Falcon<'a, Gsp>,
+    sec2_falcon: &'a Falcon<'a, Sec2>,
     unload_bundle: Option<super::UnloadBundle>,
 }
=20
@@ -56,8 +56,8 @@ pub(super) fn new(
         gsp: &'a super::Gsp,
         dev: &'a device::Device<device::Bound>,
         bar: Bar0<'a>,
-        gsp_falcon: &'a Falcon<Gsp>,
-        sec2_falcon: &'a Falcon<Sec2>,
+        gsp_falcon: &'a Falcon<'a, Gsp>,
+        sec2_falcon: &'a Falcon<'a, Sec2>,
         unload_bundle: Option<super::UnloadBundle>,
     ) -> Self {
         Self {
@@ -120,17 +120,17 @@ pub(crate) fn boot(
         // Perform the chipset-specific boot sequence, and retrieve the un=
load bundle.
         let unload_guard =3D hal.boot(&self, &ctx, &fb_layout, &wpr_meta)?=
;
=20
-        gsp_falcon.write_os_version(bar, gsp_fw.bootloader.app_version);
+        gsp_falcon.write_os_version(gsp_fw.bootloader.app_version);
=20
         // Poll for RISC-V to become active before continuing.
         read_poll_timeout(
-            || Ok(gsp_falcon.is_riscv_active(bar)),
+            || Ok(gsp_falcon.is_riscv_active()),
             |val: &bool| *val,
             Delta::from_millis(10),
             Delta::from_secs(5),
         )?;
=20
-        dev_dbg!(pdev, "RISC-V active? {}\n", gsp_falcon.is_riscv_active(b=
ar),);
+        dev_dbg!(pdev, "RISC-V active? {}\n", gsp_falcon.is_riscv_active()=
,);
=20
         self.cmdq
             .send_command_no_wait(bar, commands::SetSystemInfo::new(pdev, =
chipset))?;
@@ -149,7 +149,7 @@ pub(crate) fn boot(
     fn shutdown_gsp(
         cmdq: &Cmdq,
         bar: Bar0<'_>,
-        gsp_falcon: &Falcon<Gsp>,
+        gsp_falcon: &Falcon<'_, Gsp>,
         mode: commands::PowerStateLevel,
     ) -> Result {
         // Command to shut the GSP down.
@@ -158,7 +158,7 @@ fn shutdown_gsp(
         // Wait until GSP signals it is suspended.
         const LIBOS_INTERRUPT_PROCESSOR_SUSPENDED: u32 =3D bits::bit_u32(3=
1);
         read_poll_timeout(
-            || Ok(gsp_falcon.read_mailbox0(bar)),
+            || Ok(gsp_falcon.read_mailbox0()),
             |&mb0| mb0 & LIBOS_INTERRUPT_PROCESSOR_SUSPENDED !=3D 0,
             Delta::from_millis(10),
             Delta::from_secs(5),
@@ -173,8 +173,8 @@ pub(crate) fn unload(
         &self,
         dev: &device::Device<device::Bound>,
         bar: Bar0<'_>,
-        gsp_falcon: &Falcon<Gsp>,
-        sec2_falcon: &Falcon<Sec2>,
+        gsp_falcon: &Falcon<'_, Gsp>,
+        sec2_falcon: &Falcon<'_, Sec2>,
         unload_bundle: Option<super::UnloadBundle>,
     ) -> Result {
         // Shut down the GSP. Keep going even in case of error.
diff --git a/drivers/gpu/nova-core/gsp/hal.rs b/drivers/gpu/nova-core/gsp/h=
al.rs
index 51a277fe97bb..d3e47ef206de 100644
--- a/drivers/gpu/nova-core/gsp/hal.rs
+++ b/drivers/gpu/nova-core/gsp/hal.rs
@@ -42,8 +42,8 @@ fn run(
         &self,
         dev: &device::Device<device::Bound>,
         bar: Bar0<'_>,
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
+        gsp_falcon: &Falcon<'_, GspEngine>,
+        sec2_falcon: &Falcon<'_, Sec2>,
     ) -> Result;
 }
=20
diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-core=
/gsp/hal/gh100.rs
index 2187e11168b2..1d06405a32f6 100644
--- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
+++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
@@ -42,10 +42,10 @@ struct GspMbox {
=20
 impl GspMbox {
     /// Reads both mailboxes from the GSP falcon.
-    fn read(gsp_falcon: &Falcon<GspEngine>, bar: Bar0<'_>) -> Self {
+    fn read(gsp_falcon: &Falcon<'_, GspEngine>) -> Self {
         Self {
-            mbox0: gsp_falcon.read_mailbox0(bar),
-            mbox1: gsp_falcon.read_mailbox1(bar),
+            mbox0: gsp_falcon.read_mailbox0(),
+            mbox1: gsp_falcon.read_mailbox1(),
         }
     }
=20
@@ -60,8 +60,7 @@ fn combined_addr(&self) -> u64 {
     /// either condition should stop the poll loop.
     fn lockdown_released_or_error(
         &self,
-        gsp_falcon: &Falcon<GspEngine>,
-        bar: Bar0<'_>,
+        gsp_falcon: &Falcon<'_, GspEngine>,
         fmc_boot_params_addr: u64,
     ) -> bool {
         // GSP-FMC normally clears the boot parameters address from the ma=
ilboxes early during
@@ -71,15 +70,14 @@ fn lockdown_released_or_error(
             return self.combined_addr() !=3D fmc_boot_params_addr;
         }
=20
-        !gsp_falcon.riscv_branch_privilege_lockdown(bar)
+        !gsp_falcon.riscv_branch_privilege_lockdown()
     }
 }
=20
 /// Waits for GSP lockdown to be released after FSP Chain of Trust.
 fn wait_for_gsp_lockdown_release(
     dev: &device::Device<device::Bound>,
-    bar: Bar0<'_>,
-    gsp_falcon: &Falcon<GspEngine>,
+    gsp_falcon: &Falcon<'_, GspEngine>,
     fmc_boot_params_addr: u64,
 ) -> Result {
     dev_dbg!(dev, "Waiting for GSP lockdown release\n");
@@ -88,14 +86,14 @@ fn wait_for_gsp_lockdown_release(
         || {
             // While the PRIV target mask is still locked to FSP, GSP regi=
ster and mailbox reads
             // are not meaningful. Wait until HWCFG2 says the CPU can read=
 them.
-            Ok(match gsp_falcon.priv_target_mask_released(bar) {
+            Ok(match gsp_falcon.priv_target_mask_released() {
                 false =3D> None,
-                true =3D> Some(GspMbox::read(gsp_falcon, bar)),
+                true =3D> Some(GspMbox::read(gsp_falcon)),
             })
         },
         |mbox| match mbox {
             None =3D> false,
-            Some(mbox) =3D> mbox.lockdown_released_or_error(gsp_falcon, ba=
r, fmc_boot_params_addr),
+            Some(mbox) =3D> mbox.lockdown_released_or_error(gsp_falcon, fm=
c_boot_params_addr),
         },
         Delta::from_millis(10),
         Delta::from_secs(30),
@@ -122,13 +120,13 @@ impl UnloadBundle for FspUnloadBundle {
     fn run(
         &self,
         dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<GspEngine>,
-        _sec2_falcon: &Falcon<Sec2>,
+        _bar: Bar0<'_>,
+        gsp_falcon: &Falcon<'_, GspEngine>,
+        _sec2_falcon: &Falcon<'_, Sec2>,
     ) -> Result {
         // GSP falcon does most of the work of resetting, so just wait for=
 it to finish.
         read_poll_timeout(
-            || Ok(gsp_falcon.is_riscv_active(bar)),
+            || Ok(gsp_falcon.is_riscv_active()),
             |&active| !active,
             Delta::from_millis(10),
             Delta::from_secs(5),
@@ -176,9 +174,9 @@ fn boot<'a>(
             false,
         )?;
=20
-        fsp.boot_fmc(dev, bar, fb_layout, &args)?;
+        fsp.boot_fmc(dev, fb_layout, &args)?;
=20
-        wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_para=
ms_dma_handle())?;
+        wait_for_gsp_lockdown_release(dev, gsp_falcon, args.boot_params_dm=
a_handle())?;
=20
         Ok(unload_guard)
     }
diff --git a/drivers/gpu/nova-core/gsp/hal/tu102.rs b/drivers/gpu/nova-core=
/gsp/hal/tu102.rs
index f8a8541704ee..180d47fb8f4e 100644
--- a/drivers/gpu/nova-core/gsp/hal/tu102.rs
+++ b/drivers/gpu/nova-core/gsp/hal/tu102.rs
@@ -62,12 +62,11 @@ impl FwsecUnloadFirmware {
     /// Loads the FWSEC SB firmware, as well as its bootloader if `chipset=
` requires it.
     fn new(
         dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
         chipset: Chipset,
         bios: &Vbios,
-        gsp_falcon: &Falcon<GspEngine>,
+        gsp_falcon: &Falcon<'_, GspEngine>,
     ) -> Result<Self> {
-        let fwsec_sb =3D FwsecFirmware::new(dev, gsp_falcon, bar, bios, Fw=
secCommand::Sb)?;
+        let fwsec_sb =3D FwsecFirmware::new(dev, gsp_falcon, bios, FwsecCo=
mmand::Sb)?;
=20
         Ok(if chipset.needs_fwsec_bootloader() {
             Self::WithBl(FwsecFirmwareWithBl::new(fwsec_sb, dev, chipset)?=
)
@@ -80,12 +79,11 @@ fn new(
     fn run(
         &self,
         dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
-        gsp_falcon: &Falcon<GspEngine>,
+        gsp_falcon: &Falcon<'_, GspEngine>,
     ) -> Result {
         match self {
-            Self::WithoutBl(fw) =3D> fw.run(dev, gsp_falcon, bar),
-            Self::WithBl(fw) =3D> fw.run(dev, gsp_falcon, bar),
+            Self::WithoutBl(fw) =3D> fw.run(dev, gsp_falcon),
+            Self::WithBl(fw) =3D> fw.run(dev, gsp_falcon),
         }
     }
 }
@@ -101,22 +99,20 @@ impl Sec2UnloadBundle {
     /// Load and prepare the resources required to properly reset the GSP =
after it has been stopped.
     fn build(
         dev: &device::Device<device::Bound>,
-        bar: Bar0<'_>,
         chipset: Chipset,
         bios: &Vbios,
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
+        gsp_falcon: &Falcon<'_, GspEngine>,
+        sec2_falcon: &Falcon<'_, Sec2>,
     ) -> Result<KBox<dyn UnloadBundle>> {
         KBox::new(
             Self {
-                fwsec_sb: FwsecUnloadFirmware::new(dev, bar, chipset, bios=
, gsp_falcon)?,
+                fwsec_sb: FwsecUnloadFirmware::new(dev, chipset, bios, gsp=
_falcon)?,
                 booter_unloader: BooterFirmware::new(
                     dev,
                     BooterKind::Unloader,
                     chipset,
                     FIRMWARE_VERSION,
                     sec2_falcon,
-                    bar,
                 )?,
             },
             GFP_KERNEL,
@@ -131,14 +127,14 @@ fn run(
         &self,
         dev: &device::Device<device::Bound>,
         bar: Bar0<'_>,
-        gsp_falcon: &Falcon<GspEngine>,
-        sec2_falcon: &Falcon<Sec2>,
+        gsp_falcon: &Falcon<'_, GspEngine>,
+        sec2_falcon: &Falcon<'_, Sec2>,
     ) -> Result {
         // Run FWSEC-SB to reset the GSP falcon to its pre-libos state.
         // Log errors but keep going if it fails.
         let fwsec_sb_res =3D self
             .fwsec_sb
-            .run(dev, bar, gsp_falcon)
+            .run(dev, gsp_falcon)
             .inspect_err(|e| dev_err!(dev, "FWSEC-SB failed to run: {:?}\n=
", e));
=20
         // Remove WPR2 region if set.
@@ -148,13 +144,12 @@ fn run(
                 return Ok(());
             }
=20
-            sec2_falcon.reset(bar)?;
-            sec2_falcon.load(dev, bar, &self.booter_unloader)?;
+            sec2_falcon.reset()?;
+            sec2_falcon.load(&self.booter_unloader)?;
=20
             // Sentinel value to confirm that Booter Unloader has run.
             const MAILBOX_SENTINEL: u32 =3D 0xff;
-            let (mbox0, _) =3D
-                sec2_falcon.boot(bar, Some(MAILBOX_SENTINEL), Some(MAILBOX=
_SENTINEL))?;
+            let (mbox0, _) =3D sec2_falcon.boot(Some(MAILBOX_SENTINEL), So=
me(MAILBOX_SENTINEL))?;
             if mbox0 !=3D 0 {
                 dev_err!(dev, "Booter Unloader returned error 0x{:x}\n", m=
box0);
                 return Err(EINVAL);
@@ -183,7 +178,7 @@ fn run(
 fn run_fwsec_frts(
     dev: &device::Device<device::Bound>,
     chipset: Chipset,
-    falcon: &Falcon<GspEngine>,
+    falcon: &Falcon<'_, GspEngine>,
     bar: Bar0<'_>,
     bios: &Vbios,
     fb_layout: &FbLayout,
@@ -202,7 +197,6 @@ fn run_fwsec_frts(
     let fwsec_frts =3D FwsecFirmware::new(
         dev,
         falcon,
-        bar,
         bios,
         FwsecCommand::Frts {
             frts_addr: fb_layout.frts.start,
@@ -213,10 +207,10 @@ fn run_fwsec_frts(
     if chipset.needs_fwsec_bootloader() {
         let fwsec_frts_bl =3D FwsecFirmwareWithBl::new(fwsec_frts, dev, ch=
ipset)?;
         // Load and run the bootloader, which will load FWSEC-FRTS and run=
 it.
-        fwsec_frts_bl.run(dev, falcon, bar)?;
+        fwsec_frts_bl.run(dev, falcon)?;
     } else {
         // Load and run FWSEC-FRTS directly.
-        fwsec_frts.run(dev, falcon, bar)?;
+        fwsec_frts.run(dev, falcon)?;
     }
=20
     // SCRATCH_E contains the error code for FWSEC-FRTS.
@@ -286,18 +280,17 @@ fn boot<'a>(
         //
         // If the unload bundle creation fails, the GPU will need to be re=
set before the driver can
         // be probed again.
-        let unload_bundle =3D
-            Sec2UnloadBundle::build(dev, bar, chipset, &bios, gsp_falcon, =
sec2_falcon)
-                .inspect_err(|e| {
-                    dev_warn!(dev, "Failed to prepare unload firmware: {:?=
}\n", e);
-                    dev_warn!(dev, "The GSP won't be able to unload proper=
ly on unbind.\n");
-                    dev_warn!(
-                        dev,
-                        "The GPU will need to be reset before the driver c=
an bind again.\n"
-                    );
-                })
-                .ok()
-                .map(crate::gsp::UnloadBundle);
+        let unload_bundle =3D Sec2UnloadBundle::build(dev, chipset, &bios,=
 gsp_falcon, sec2_falcon)
+            .inspect_err(|e| {
+                dev_warn!(dev, "Failed to prepare unload firmware: {:?}\n"=
, e);
+                dev_warn!(dev, "The GSP won't be able to unload properly o=
n unbind.\n");
+                dev_warn!(
+                    dev,
+                    "The GPU will need to be reset before the driver can b=
ind again.\n"
+                );
+            })
+            .ok()
+            .map(crate::gsp::UnloadBundle);
=20
         // Wrap the unload bundle into a drop guard so it is automatically=
 run upon failure.
         let unload_guard =3D
@@ -308,13 +301,10 @@ fn boot<'a>(
             run_fwsec_frts(dev, chipset, gsp_falcon, bar, &bios, fb_layout=
)?;
         }
=20
-        gsp_falcon.reset(bar)?;
+        gsp_falcon.reset()?;
         let libos_handle =3D gsp.libos.dma_handle();
-        let (mbox0, mbox1) =3D gsp_falcon.boot(
-            bar,
-            Some(libos_handle as u32),
-            Some((libos_handle >> 32) as u32),
-        )?;
+        let (mbox0, mbox1) =3D
+            gsp_falcon.boot(Some(libos_handle as u32), Some((libos_handle =
>> 32) as u32))?;
         dev_dbg!(dev, "GSP MBOX0: {:#x}, MBOX1: {:#x}\n", mbox0, mbox1);
=20
         dev_dbg!(
@@ -328,9 +318,8 @@ fn boot<'a>(
             chipset,
             FIRMWARE_VERSION,
             sec2_falcon,
-            bar,
         )?
-        .run(dev, bar, sec2_falcon, wpr_meta)?;
+        .run(dev, sec2_falcon, wpr_meta)?;
=20
         Ok(unload_guard)
     }
diff --git a/drivers/gpu/nova-core/gsp/sequencer.rs b/drivers/gpu/nova-core=
/gsp/sequencer.rs
index e0850d21adca..13983d42b12b 100644
--- a/drivers/gpu/nova-core/gsp/sequencer.rs
+++ b/drivers/gpu/nova-core/gsp/sequencer.rs
@@ -133,9 +133,9 @@ pub(crate) struct GspSequencer<'a> {
     /// `Bar0` for register access.
     bar: Bar0<'a>,
     /// SEC2 falcon for core operations.
-    sec2_falcon: &'a Falcon<Sec2>,
+    sec2_falcon: &'a Falcon<'a, Sec2>,
     /// GSP falcon for core operations.
-    gsp_falcon: &'a Falcon<Gsp>,
+    gsp_falcon: &'a Falcon<'a, Gsp>,
     /// LibOS DMA handle address.
     libos_dma_handle: u64,
     /// Bootloader application version.
@@ -213,16 +213,16 @@ fn run(&self, seq: &GspSequencer<'_>) -> Result {
             GspSeqCmd::DelayUs(cmd) =3D> cmd.run(seq),
             GspSeqCmd::RegStore(cmd) =3D> cmd.run(seq),
             GspSeqCmd::CoreReset =3D> {
-                seq.gsp_falcon.reset(seq.bar)?;
-                seq.gsp_falcon.dma_reset(seq.bar);
+                seq.gsp_falcon.reset()?;
+                seq.gsp_falcon.dma_reset();
                 Ok(())
             }
             GspSeqCmd::CoreStart =3D> {
-                seq.gsp_falcon.start(seq.bar)?;
+                seq.gsp_falcon.start()?;
                 Ok(())
             }
             GspSeqCmd::CoreWaitForHalt =3D> {
-                seq.gsp_falcon.wait_till_halted(seq.bar)?;
+                seq.gsp_falcon.wait_till_halted()?;
                 Ok(())
             }
             GspSeqCmd::CoreResume =3D> {
@@ -231,35 +231,32 @@ fn run(&self, seq: &GspSequencer<'_>) -> Result {
                 // sequencer will start both.
=20
                 // Reset the GSP to prepare it for resuming.
-                seq.gsp_falcon.reset(seq.bar)?;
+                seq.gsp_falcon.reset()?;
=20
                 // Write the libOS DMA handle to GSP mailboxes.
                 seq.gsp_falcon.write_mailboxes(
-                    seq.bar,
                     Some(seq.libos_dma_handle as u32),
                     Some((seq.libos_dma_handle >> 32) as u32),
                 );
=20
                 // Start the SEC2 falcon which will trigger GSP-RM to resu=
me on the GSP.
-                seq.sec2_falcon.start(seq.bar)?;
+                seq.sec2_falcon.start()?;
=20
                 // Poll until GSP-RM reload/resume has completed (up to 2 =
seconds).
-                seq.gsp_falcon
-                    .check_reload_completed(seq.bar, Delta::from_secs(2))?=
;
+                seq.gsp_falcon.check_reload_completed(Delta::from_secs(2))=
?;
=20
                 // Verify SEC2 completed successfully by checking its mail=
box for errors.
-                let mbox0 =3D seq.sec2_falcon.read_mailbox0(seq.bar);
+                let mbox0 =3D seq.sec2_falcon.read_mailbox0();
                 if mbox0 !=3D 0 {
                     dev_err!(seq.dev, "Sequencer: sec2 errors: {:?}\n", mb=
ox0);
                     return Err(EIO);
                 }
=20
                 // Configure GSP with the bootloader version.
-                seq.gsp_falcon
-                    .write_os_version(seq.bar, seq.bootloader_app_version)=
;
+                seq.gsp_falcon.write_os_version(seq.bootloader_app_version=
);
=20
                 // Verify the GSP's RISC-V core is active indicating succe=
ssful GSP boot.
-                if !seq.gsp_falcon.is_riscv_active(seq.bar) {
+                if !seq.gsp_falcon.is_riscv_active() {
                     dev_err!(seq.dev, "Sequencer: RISC-V core is not activ=
e\n");
                     return Err(EIO);
                 }
@@ -345,9 +342,9 @@ pub(crate) struct GspSequencerParams<'a> {
     /// LibOS DMA handle address.
     pub(crate) libos_dma_handle: u64,
     /// GSP falcon for core operations.
-    pub(crate) gsp_falcon: &'a Falcon<Gsp>,
+    pub(crate) gsp_falcon: &'a Falcon<'a, Gsp>,
     /// SEC2 falcon for core operations.
-    pub(crate) sec2_falcon: &'a Falcon<Sec2>,
+    pub(crate) sec2_falcon: &'a Falcon<'a, Sec2>,
     /// Device for logging.
     pub(crate) dev: &'a device::Device,
     /// BAR0 for register access.

---
base-commit: 9102e655ea7285c1bc329669865ba8a38cdb69e6
change-id: 20260624-drm-bar-refactor-90435f04c9ea

Best regards,
--=20
Tim Kovalenko <tim.kovalenko@proton.me>


