Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015F4FF885E
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3232610F70F;
	Fri, 24 Apr 2026 23:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="MYd7u9/P";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 156B310F703
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:39:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777073981; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mPK6Y2jWagLzq3MvXDDOa4qi9ttQez6SSsRM6S65ydwzQOjSuIr6getQw/t/JA3AUP0T9qrVKNGMKJ/qAyVNXY7IGLMhZ/lpIbpWSKrSI3Uc7TMKhByWJXz4stqhVwdtAsIB9H1x5XzFNIW/kii3hpKteRnUSrnRwUnPn3rnUAM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777073981;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=YFpEwDk265HcDtT2iSrpnnS2CizbAS4fRqC8NvMq/RA=; 
 b=eG/TsPomWOdKmQf8yxy8QaYDoBhGiV+WlVsRmAJbMArkXmtrf2yXp0SjnEL1UJQT1jqWMy5c4Fla+CLRnJP39eH4zykhoQkjOC52zFgY9Eo1B2/vbklSjpuZOUbXYCjbqyybeWsQGWi4aHIn5rpK1IIt5ozbrmgihtxWgtONVbE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777073981; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=YFpEwDk265HcDtT2iSrpnnS2CizbAS4fRqC8NvMq/RA=;
 b=MYd7u9/P3LjsAZGrsakdVMETZ3v+CnNpWvukfqLy5m5Gr7AWaCI8LOxeACmK+eHc
 xBPIdXQ/Y90TwkMGEBl/SGLgyN+LOr3al2FHY7BIVEphcoLfT1uxF3pucakvKK/udp3
 muyBPsOEj/Z45moQ0Sv0LtPFkQHtyYk8ue2XDN1U=
Received: by mx.zohomail.com with SMTPS id 1777073979336487.8899109468525;
 Fri, 24 Apr 2026 16:39:39 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 24 Apr 2026 16:39:14 -0700
Subject: [PATCH v4 20/20] drm/tyr: program CSF global interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-b4-fw-boot-v4-v4-20-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
In-Reply-To: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=13824;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=YJdZvBVt6Gs0/MhLYMLar4r0DRCow0chMhC6y3CR32c=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJmv/yuYH5OZYhlwW/7adivr9eUlOyUP/Q4u/mrZsNNBL
 /W5oaBlRykLgxgXg6yYIstZe6Me8ar3Rrrz/zfDzGFlAhnCwMUpABMpW8vIMInBSHqO9zJVyxlp
 t7ZNZtfICdJt0Vi+98epPL1r1rtiVjD8U/7iNTsx6Dv7mzWC5x6eO+I8UYhv7xeus3/Cdt3M+NO
 ixgkA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

After ringing the doorbell, wait for the firmware to acknowledge the
configuration requests before proceeding.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs        |   2 +-
 drivers/gpu/drm/tyr/fw.rs            |  12 +-
 drivers/gpu/drm/tyr/fw/interfaces.rs | 246 ++++++++++++++++++++++++++++++++++-
 3 files changed, 253 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 20ae114a4180..67a5289dd346 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -192,7 +192,7 @@ fn probe(
         firmware
             .wait_ready(1000)
             .inspect_err(|_| pr_err!("Timed out waiting for firmware to be ready.\n"))?;
-        firmware.enable_global_interface()?;
+        firmware.enable_global_interface(&gpu_info, &core_clk)?;
 
         let data = try_pin_init!(TyrDrmDeviceData {
                 pdev: platform.clone(),
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 598e399a58ae..5fe6f47c5d2e 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -20,6 +20,7 @@
 
 use kernel::{
     bits::genmask_u32,
+    clk::Clk,
     devres::Devres,
     drm::{
         gem::BaseObject,
@@ -337,8 +338,15 @@ pub(crate) fn wait_ready(&self, timeout_ms: u32) -> Result {
     }
 
     /// Enable the global interface.
-    pub(crate) fn enable_global_interface(&self) -> Result {
+    pub(crate) fn enable_global_interface(&self, gpu_info: &GpuInfo, core_clk: &Clk) -> Result {
         let shared_section = self.shared_section()?;
-        self.global_iface.lock().enable(shared_section)
+        self.global_iface.lock().enable(
+            &self.pdev,
+            &self.iomem,
+            shared_section,
+            gpu_info,
+            core_clk,
+            &self.ready_wait,
+        )
     }
 }
diff --git a/drivers/gpu/drm/tyr/fw/interfaces.rs b/drivers/gpu/drm/tyr/fw/interfaces.rs
index 07cdb1c76a3f..efea0785b3bd 100644
--- a/drivers/gpu/drm/tyr/fw/interfaces.rs
+++ b/drivers/gpu/drm/tyr/fw/interfaces.rs
@@ -39,11 +39,29 @@
 //! ```
 //!
 
-use crate::fw::Section;
+use crate::{
+    driver::IoMem,
+    fw::Section,
+    gpu::GpuInfo,
+    regs::doorbell_block::DOORBELL,
+    wait::{
+        Wait,
+        WaitResult, //
+    }, //
+};
 use iface::FwInterface;
 use kernel::{
-    io::Io,
-    prelude::*, //
+    bindings::SZ_1K,
+    clk::Clk,
+    devres::Devres,
+    io::{
+        register::Array,
+        Io, //
+    },
+    num::Bounded,
+    platform,
+    prelude::*,
+    time::arch_timer_get_rate, //
 };
 
 /// Offset from GLB_CONTROL_BLOCK start to the first GROUP_CONTROL block.
@@ -1616,9 +1634,94 @@ pub(super) mod output {
 use csg::*;
 use glb::{
     control::*,
+    input::*,
+    output::GLB_ACK,
     *, //
 };
 
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
+struct GlobalInterfaceRequests<'a> {
+    /// Global input block where driver writes requests.
+    input: &'a FwInterface<GLB_INPUT_BLOCK_SIZE>,
+    /// Global output block where firmware writes acknowledgements.
+    output: &'a FwInterface<GLB_OUTPUT_BLOCK_SIZE>,
+}
+
+impl<'a> GlobalInterfaceRequests<'a> {
+    fn new(
+        input: &'a FwInterface<GLB_INPUT_BLOCK_SIZE>,
+        output: &'a FwInterface<GLB_OUTPUT_BLOCK_SIZE>,
+    ) -> Self {
+        Self { input, output }
+    }
+
+    /// Waits for the firmware to acknowledge the given request bits.
+    ///
+    /// The ack condition is `(GLB_ACK & mask) == (GLB_REQ & mask)`.
+    fn wait_acks(&self, reqs_mask: GLB_REQ, event_wait: &Wait, timeout_ms: u32) -> Result {
+        let mask = reqs_mask.into_raw();
+
+        event_wait.wait_interruptible_timeout(timeout_ms, || {
+            let req = self.input.read(GLB_REQ).into_raw() & mask;
+            let ack = self.output.read(GLB_ACK).into_raw() & mask;
+            if req == ack {
+                Ok(WaitResult::Done)
+            } else {
+                Ok(WaitResult::Retry)
+            }
+        })
+    }
+
+    /// Use to make requests, where simply changing the bit value is
+    /// sufficient to make a request; the bit value has no meaning in itself.
+    fn toggle_requests(&self, reqs_mask: GLB_REQ) -> Result {
+        let reqs_mask_val = reqs_mask.into_raw();
+
+        let cur_ack_val = self.output.read(GLB_ACK).into_raw();
+
+        // Calculate which bits to toggle based on ACK state
+        let toggled_bits = (cur_ack_val ^ reqs_mask_val) & reqs_mask_val;
+
+        let cur_req_val = self.input.read(GLB_REQ).into_raw();
+        let preserved_bits = cur_req_val & !reqs_mask_val;
+        let new_val = toggled_bits | preserved_bits;
+
+        self.input.write(GLB_REQ, GLB_REQ::from_raw(new_val));
+        Ok(())
+    }
+}
+
 /// State of the global interface.
 enum GlobalInterfaceState {
     /// Interface is not yet initialized.
@@ -1667,7 +1770,15 @@ pub(super) fn new() -> Result<Self> {
     /// This reads the firmware's control block to set up the global input/output
     /// interfaces; it configures timers and shader core allocation; and it discovers
     /// available CSG interfaces.
-    pub(crate) fn enable(&mut self, shared_section: &Section) -> Result {
+    pub(crate) fn enable(
+        &mut self,
+        pdev: &platform::Device,
+        iomem: &Devres<IoMem>,
+        shared_section: &Section,
+        gpu_info: &GpuInfo,
+        core_clk: &Clk,
+        event_wait: &Wait,
+    ) -> Result {
         let vmap = shared_section.mem.bo.owned_vmap::<0>()?;
         let va_range = shared_section.mem.va_range();
 
@@ -1700,6 +1811,24 @@ pub(crate) fn enable(&mut self, shared_section: &Section) -> Result {
             output_va.value().get().into(),
         )?;
 
+        Self::configure_glb_input(&glb_input, gpu_info, core_clk)?;
+        let ack_mask = Self::configure_glb_requests(&glb_input, &glb_output)?;
+
+        // Ring the global doorbell to notify the MCU.
+        // SAFETY: Called during probe after the device has been successfully bound,
+        // so it is valid to access it as a bound device.
+        let dev = unsafe { pdev.as_ref().as_bound() };
+        let io = iomem.access(dev)?;
+        io.write(Array::at(0), DOORBELL::zeroed().with_ring(true));
+
+        // Wait for the firmware to acknowledge the initial global configuration.
+        let request_field = GlobalInterfaceRequests::new(&glb_input, &glb_output);
+
+        if let Err(e) = request_field.wait_acks(ack_mask, event_wait, 1000) {
+            pr_err!("CSF firmware failed to ACK initial GLB config\n");
+            return Err(e);
+        }
+
         // Read how many CSG interfaces exist.
         let csg_num = glb_control.read(GLB_GROUP_NUM).value().get();
 
@@ -1739,6 +1868,115 @@ pub(crate) fn enable(&mut self, shared_section: &Section) -> Result {
         Ok(())
     }
 
+    /// Programs GLB input-block configuration registers.
+    ///
+    /// Writes shader core allocation and timer values. These settings are applied
+    /// by firmware only after the corresponding GLB_REQ bits are updated.
+    fn configure_glb_input(
+        glb_input: &FwInterface<GLB_INPUT_BLOCK_SIZE>,
+        gpu_info: &GpuInfo,
+        core_clk: &Clk,
+    ) -> Result {
+        // Make all present shader cores available for endpoint allocation.
+        glb_input.write(
+            GLB_ALLOC_EN,
+            GLB_ALLOC_EN::zeroed().with_mask(gpu_info.shader_present),
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
+        glb_input.write(
+            GLB_PWROFF_TIMER,
+            GLB_PWROFF_TIMER::zeroed()
+                .with_timeout(pwroff_timeout)
+                .with_timer_source(pwroff_source),
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
+        glb_input.write(
+            GLB_PROGRESS_TIMER,
+            GLB_PROGRESS_TIMER::zeroed().with_timeout(progress_timeout),
+        );
+
+        // Configure the delay before reporting the GPU as idle.
+        const IDLE_HYSTERESIS_US: u32 = 800;
+        let (idle_timeout, idle_source) = conv_timeout(core_clk, IDLE_HYSTERESIS_US)?;
+        let idle_timeout = Bounded::<u32, 31>::try_new(idle_timeout).ok_or(EINVAL)?;
+        glb_input.write(
+            GLB_IDLE_TIMER,
+            GLB_IDLE_TIMER::zeroed()
+                .with_timeout(idle_timeout)
+                .with_timer_source(idle_source),
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
+        glb_input: &FwInterface<GLB_INPUT_BLOCK_SIZE>,
+        glb_output: &FwInterface<GLB_OUTPUT_BLOCK_SIZE>,
+    ) -> Result<GLB_REQ> {
+        // Firmware updates GLB_ACK (output block) in response to GLB_REQ.
+        // GLB_ACK_IRQ_MASK selects which of these updates trigger a host interrupt.
+        glb_input.write(
+            GLB_ACK_IRQ_MASK,
+            GLB_ACK_IRQ_MASK::zeroed()
+                .with_cfg_progress_timer(true)
+                .with_cfg_alloc_en(true)
+                .with_cfg_pwroff_timer(true)
+                .with_idle_enable(true)
+                .with_idle_event(true)
+                .with_counter_enable(true),
+        );
+
+        // Requests whose value represents the desired persistent state.
+        let cur_req = glb_input.read(GLB_REQ);
+        glb_input.write(
+            GLB_REQ,
+            cur_req.with_idle_enable(true).with_counter_enable(true),
+        );
+
+        let request_field = GlobalInterfaceRequests::new(glb_input, glb_output);
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
2.53.0

