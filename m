Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6937C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:58:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FDBF10F436;
	Tue, 15 Sep 2026 10:58:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="JgX5dGtx";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E34C10F407
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789469930;
 bh=mGyHBUk4Ns0kXI70CLz1ZsEzeBa/vNXnoECqgc6Bdxw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JgX5dGtxYpiMLJkqPwTn9oGAn86BeaHhzgYslHtdbXx6q4rSwYMyS1nA3JaLuBaaB
 TJ0DbqmNODvxhEA5lspXvSs7SbAyiQ7XVW4Qp1hWGBY6iDAi1bCPo2CIR4+q0JdNFw
 mlYCvwTN/WTo6aEChG2w4m6H8+1lLcrTE2HQDq3SAl/A1I0yKgBChEObjLk405gt3w
 K54IzlohmTC12QOCT2Qac8IMyJvdqTVnXgi0VcbuX6Qtxo2WPhpj2TunFtQwUt6uUC
 qU6+cpDUGD8n8aHyHZLexXbn/VgBKymLndqXxxPjQQsj6TKCLwZxWV3JAYMcrYBZJM
 iOcLR88vuQalQ==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C0B4117E0E2F;
 Tue, 15 Sep 2026 12:58:49 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
Date: Tue, 15 Sep 2026 12:57:41 +0200
Subject: [PATCH 8/9] drm/tyr: program CSF global interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-tyr-interfaces-v1-8-5d28f1f75aca@collabora.com>
References: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
In-Reply-To: <20260915-tyr-interfaces-v1-0-5d28f1f75aca@collabora.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 kernel@collabora.com, Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
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

Initialize the CSF global (GLB) interface after firmware boot.

Program the GLB input block with initial configuration:
- enable allocation across all present shader cores
- set power-off, progress, and idle timers

Then update GLB_REQ to enable persistent features and trigger
configuration updates, and ring the global doorbell to notify the MCU.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs        |   2 +-
 drivers/gpu/drm/tyr/fw.rs            |   6 +-
 drivers/gpu/drm/tyr/fw/interfaces.rs | 222 +++++++++++++++++++++++++++++++++--
 3 files changed, 219 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index bf1cb32e374d..2dcf33ec93ea 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -159,7 +159,7 @@ fn probe<'bound>(
         )?;
 
         firmware.boot()?;
-        firmware.enable_global_interface()?;
+        firmware.enable_global_interface(&gpu_info, &core_clk)?;
 
         let reg_data = pin_init!(TyrDrmRegistrationData {
                 pdev,
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 5abd50238ca6..1499ffdef51f 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -14,6 +14,7 @@
 //! [`Section`]: crate::fw::Section
 
 use kernel::{
+    clk::Clk,
     device::{
         Bound,
         Device, //
@@ -370,7 +371,7 @@ fn stop(&self) -> Result {
     }
 
     /// Enable the global interface.
-    pub(crate) fn enable_global_interface(&self) -> Result {
+    pub(crate) fn enable_global_interface(&self, gpu_info: &GpuInfo, core_clk: &Clk) -> Result {
         let shared_section = self.shared_section()?;
         let version = interfaces::probe_version(&shared_section.mem)?;
 
@@ -379,7 +380,7 @@ pub(crate) fn enable_global_interface(&self) -> Result {
         match version.major().get() {
             1..=4 => match &mut *self.global_iface.lock() {
                 FwIfaces::V1(iface) => {
-                    iface.enable(shared_section)
+                    iface.enable(&self.iomem, shared_section, gpu_info, core_clk)
                 }
             },
             0 => {
@@ -391,6 +392,5 @@ pub(crate) fn enable_global_interface(&self) -> Result {
                 Err(ENODEV)
             }
         }
-
     }
 }
diff --git a/drivers/gpu/drm/tyr/fw/interfaces.rs b/drivers/gpu/drm/tyr/fw/interfaces.rs
index 1cdfef2340c9..673ebeafb68e 100644
--- a/drivers/gpu/drm/tyr/fw/interfaces.rs
+++ b/drivers/gpu/drm/tyr/fw/interfaces.rs
@@ -96,11 +96,15 @@
 //! version can be read before the layout is known.
 //!
 
-use crate::fw::Section;
-
 mod v1;
 
 mod layout;
+use crate::{
+    driver::IoMem,
+    fw::Section,
+    gpu::GpuInfo,
+    regs::doorbell_block::DOORBELL, //
+};
 
 use iface::{
     FwInterface,
@@ -108,8 +112,17 @@
     IfaceBlock, //
 };
 use kernel::{
-    io::io_read,
-    prelude::*,  //
+    bindings::SZ_1K,
+    clk::Clk,
+    num::Bounded,
+    io:: {
+        io_read,
+        io_write,
+        register::Array,
+        Io, //
+    },
+    prelude::*,
+    time::arch_timer_get_rate, //
 };
 
 /// Offset from GLB_CONTROL_BLOCK start to the first GROUP_CONTROL block.
@@ -280,7 +293,6 @@ pub(super) fn new(view: MappedBoViewMut<'drm>) -> Result<Self> {
         }
 
         /// Returns the write token for this block.
-        #[expect(dead_code)]
         pub(super) fn io(&mut self) -> IoMutToken<'_, 'drm, B> {
             IoMutToken(self)
         }
@@ -761,6 +773,7 @@ fn from(exc_type: CsFatalExceptionType) -> Self {
     }
 }
 
+use glb::*;
 use v1::*;
 
 /// The per-version type profile of the CSF interface.
@@ -860,6 +873,72 @@ pub(super) fn new() -> Result<Self> {
     }
 }
 
+/// Converts a timeout in microseconds to a timeout field value and timer source.
+///
+/// The firmware supports two timer sources:
+/// - System timestamp (arch timer): preferred when available, so the timeout
+///   tracks real elapsed time independently of GPU clock rate.
+/// - GPU cycle counter: fallback when the system timestamp is unavailable.
+///
+/// Returns the encoded timeout value and the selected timer source.
+fn conv_timeout(core_clk: &Clk, timeout_us: u32) -> Result<(u32, TimestampSource)> {
+    // The max timeout is determined by the 31 bit size of the timeout field.
+    let max_timeout = (1u32 << 31) - 1;
+    let core_rate = core_clk.rate().as_hz() as u64;
+
+    let (timer_rate, timer_source) = match arch_timer_get_rate() {
+        Some(rate) => (u64::from(rate), TimestampSource::SystemTimestamp),
+        _ if core_rate != 0 => (core_rate, TimestampSource::GpuCounter),
+        _ => return Err(EINVAL),
+    };
+
+    let timeout_in_cycles = u64::from(timeout_us) * timer_rate;
+
+    // The hardware stores the represented timeout value with a shr(10) to save space.
+    let timeout_shift = u64::from(SZ_1K);
+    let us_per_second = 1_000_000u64;
+
+    let timeout_val = timeout_in_cycles.div_ceil(us_per_second * timeout_shift);
+    let timeout_val = timeout_val.min(u64::from(max_timeout)) as u32;
+
+    Ok((timeout_val, timer_source))
+}
+
+/// Request/acknowledge communication between Tyr and CSF.
+struct GlobalInterfaceRequests<'a, 'drm> {
+    /// Global input block where driver writes requests.
+    input: &'a mut FwInterfaceMut<'drm, GlbInputV1>,
+    /// Global output block where firmware writes acknowledgements.
+    output: &'a FwInterface<'drm, GlbOutputV1>,
+}
+
+impl<'a, 'drm> GlobalInterfaceRequests<'a, 'drm> {
+    fn new(
+        input: &'a mut FwInterfaceMut<'drm, GlbInputV1>,
+        output: &'a FwInterface<'drm, GlbOutputV1>,
+    ) -> Self {
+        Self { input, output }
+    }
+
+    /// Use to make requests, where simply changing the bit value is
+    /// sufficient to make a request; the bit value has no meaning in itself.
+    fn toggle_requests(&mut self, reqs_mask: GLB_REQ) -> Result {
+        let reqs_mask_val = reqs_mask.into_raw();
+
+        let cur_ack_val = io_read!(self.output, .ack).into_raw();
+
+        // Calculate which bits to toggle based on ACK state
+        let toggled_bits = (cur_ack_val ^ reqs_mask_val) & reqs_mask_val;
+
+        let cur_req_val = io_read!(&*self.input, .req).into_raw();
+        let preserved_bits = cur_req_val & !reqs_mask_val;
+        let new_val = toggled_bits | preserved_bits;
+
+        io_write!(self.input.io(), .req, GLB_REQ::from_raw(new_val));
+        Ok(())
+    }
+}
+
 /// State of the global interface.
 enum GlobalInterfaceState<'drm> {
     /// Interface is not yet initialized.
@@ -963,7 +1042,13 @@ pub(super) fn new() -> Result<Self> {
     /// This reads the firmware's control block to set up the global input/output
     /// interfaces; it configures timers and shader core allocation; and it discovers
     /// available CSG interfaces.
-    pub(crate) fn enable(&mut self, shared_section: &Section<'drm>) -> Result {
+    pub(crate) fn enable(
+            &mut self,
+            io: &IoMem<'_>,
+            shared_section: &Section<'drm>,
+            gpu_info: &GpuInfo,
+            core_clk: &Clk,
+        ) -> Result {
         // Drop any previous state first.
         // This lets enable() run again after an MCU reset.
         self.state = GlobalInterfaceState::Disabled;
@@ -986,7 +1071,7 @@ pub(crate) fn enable(&mut self, shared_section: &Section<'drm>) -> Result {
         );
 
         let input_va = io_read!(&glb_control, .input_va).value().get();
-        let glb_input = FwInterfaceMut::<GlbInputV1>::new(mem.try_view_mut(
+        let mut glb_input = FwInterfaceMut::<GlbInputV1>::new(mem.try_view_mut(
             input_va.into(),
             GlbInputV1::ARCH_SIZE as u64,
             core::mem::size_of::<GlbInputV1>() as u64,
@@ -999,6 +1084,14 @@ pub(crate) fn enable(&mut self, shared_section: &Section<'drm>) -> Result {
             core::mem::size_of::<GlbOutputV1>() as u64,
         )?)?;
 
+        Self::configure_glb_input(&mut glb_input, gpu_info, core_clk)?;
+        Self::configure_glb_requests(&mut glb_input, &glb_output)?;
+
+        io.write(Array::at(0), DOORBELL::zeroed().with_ring(true));
+
+        // Wait for the firmware to acknowledge the initial global configuration.
+        GlobalInterfaceRequests::new(&mut glb_input, &glb_output);
+
         // Read how many CSG interfaces exist.
         let csg_num = io_read!(&glb_control, .group_num).value().get();
 
@@ -1041,6 +1134,121 @@ pub(crate) fn enable(&mut self, shared_section: &Section<'drm>) -> Result {
         Ok(())
     }
 
+    /// Programs GLB input-block configuration registers.
+    ///
+    /// Writes shader core allocation and timer values. These settings are applied
+    /// by firmware only after the corresponding GLB_REQ bits are updated.
+    fn configure_glb_input(
+        glb_input: &mut FwInterfaceMut<'drm, GlbInputV1>,
+        gpu_info: &GpuInfo,
+        core_clk: &Clk,
+    ) -> Result {
+        // Make all present shader cores available for endpoint allocation.
+        io_write!(
+            glb_input.io(),
+            .alloc_en,
+            GLB_ALLOC_EN::zeroed().with_mask(gpu_info.shader_present)
+        );
+
+        // Configure power-down delay for shader and tiler domains.
+        // The firmware powers down a domain after it has been idle for this duration,
+        // and cancels the timeout if work arrives before expiry.
+
+        // Power-down delay after idle, in microseconds.
+        const PWROFF_HYSTERESIS_US: u32 = 10_000;
+        let (pwroff_timeout, pwroff_source) = conv_timeout(core_clk, PWROFF_HYSTERESIS_US)?;
+        let pwroff_timeout = Bounded::<u32, 31>::try_new(pwroff_timeout).ok_or(EINVAL)?;
+        io_write!(
+            glb_input.io(),
+            .pwroff_timer,
+            GLB_PWROFF_TIMER::zeroed()
+                .with_timeout(pwroff_timeout)
+                .with_timer_source(pwroff_source)
+        );
+
+        // Configure forward progress timeout.
+        //
+        // Keep this aligned with panthor, which programs a fixed GPU-cycle timeout.
+        // The real-time duration therefore varies with the GPU clock rate (e.g. ~5.24 s
+        // at 500 MHz, longer at lower frequencies).
+        //
+        // The hardware stores the timeout in units of 1024 cycles, so encode the raw
+        // cycle count by shifting right by 10.
+        const PROGRESS_TIMEOUT_CYCLES: u32 = 5 * 500 * 1024 * 1024;
+        const PROGRESS_TIMEOUT_SCALE_SHIFT: u32 = 10;
+        let progress_timeout = PROGRESS_TIMEOUT_CYCLES >> PROGRESS_TIMEOUT_SCALE_SHIFT;
+        io_write!(
+            glb_input.io(),
+            .progress_timer,
+            GLB_PROGRESS_TIMER::zeroed().with_timeout(progress_timeout)
+        );
+
+        // Configure the delay before reporting the GPU as idle.
+        const IDLE_HYSTERESIS_US: u32 = 800;
+        let (idle_timeout, idle_source) = conv_timeout(core_clk, IDLE_HYSTERESIS_US)?;
+        let idle_timeout = Bounded::<u32, 31>::try_new(idle_timeout).ok_or(EINVAL)?;
+        io_write!(
+            glb_input.io(),
+            .idle_timer,
+            GLB_IDLE_TIMER::zeroed()
+                .with_timeout(idle_timeout)
+                .with_timer_source(idle_source)
+        );
+
+        Ok(())
+    }
+
+    /// Programs GLB_REQ and ACK IRQ mask after GLB input registers are configured.
+    ///
+    /// This sets desired persistent states, toggles configuration-update requests,
+    /// and returns the GLB_REQ bits that must be acknowledged by firmware.
+    fn configure_glb_requests(
+        glb_input: &mut FwInterfaceMut<'drm, GlbInputV1>,
+        glb_output: &FwInterface<'drm, GlbOutputV1>,
+    ) -> Result<GLB_REQ> {
+        // Firmware updates GLB_ACK (output block) in response to GLB_REQ.
+        // GLB_ACK_IRQ_MASK selects which of these updates trigger a host interrupt.
+        io_write!(
+            glb_input.io(),
+            .ack_irq_mask,
+            GLB_ACK_IRQ_MASK::zeroed()
+                .with_cfg_progress_timer(true)
+                .with_cfg_alloc_en(true)
+                .with_cfg_pwroff_timer(true)
+                .with_idle_enable(true)
+                .with_idle_event(true)
+                .with_counter_enable(true)
+        );
+
+        // Requests whose value represents the desired persistent state.
+        let cur_req = io_read!(&*glb_input, .req);
+        io_write!(
+            glb_input.io(),
+            .req,
+            cur_req.with_idle_enable(true).with_counter_enable(true)
+        );
+
+        let mut request_field = GlobalInterfaceRequests::new(glb_input, glb_output);
+
+        // Fields that require toggle semantics.
+        let toggle_mask = GLB_REQ::zeroed()
+            .with_cfg_progress_timer(true)
+            .with_cfg_alloc_en(true)
+            .with_cfg_pwroff_timer(true);
+
+        request_field.toggle_requests(toggle_mask)?;
+
+        // All fields we want to wait for completion on (REQ == ACK).
+        let ack_mask = GLB_REQ::zeroed()
+            .with_cfg_progress_timer(true)
+            .with_cfg_alloc_en(true)
+            .with_cfg_pwroff_timer(true)
+            .with_idle_enable(true)
+            .with_counter_enable(true);
+
+        Ok(ack_mask)
+    }
+
     /// Initialize CSG interfaces.
     ///
     /// This uses the previously read CSG count to create and enable each CSG interface.

-- 
2.39.5

