Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D357AF8D763
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 17:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8F110E915;
	Thu, 16 Apr 2026 17:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="dtyJWmo2";
	dkim-atps=neutral
Received: from mail-244103.protonmail.ch (mail-244103.protonmail.ch
 [109.224.244.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B89310E90C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 17:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=protonmail; t=1776359856; x=1776619056;
 bh=S06/EVhCdh2ykRydN97Ks1++Kvn05jz83YXtgIhvQ7M=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=dtyJWmo2/DrcFXe8rvUguNNVYwZeUJWzxHa33zeckT/y1WRxONahKn91SthI2utbN
 0To0m7NGklX6RTZVAUPWkVo81df5eFiaREGHM9iQKqOWnKx0K+EElE1PhiD0POeNaR
 wwUoawFnuOVgXmUfENx39ga9rXLf6n8sPyWZhiiMe/7sJfDon+cvkTUzXUjw46261f
 q/E6YjNSjiBNFMVHFDKswFunmgWt6CdzB1Hj7hLfMbrBIJubqffXQSdCs6x1pbDl3a
 W1srqk2osXEBcWLiIMkGXGRjc6F0uCYlCwrgNxNJJ53O46OHWxbo/Da+Y6TiWB09am
 u3kS9n/zXx30w==
X-Pm-Submission-Id: 4fxPpR1VvHz1DDrM
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2 4/4] drm/tyr: add reset management API
Date: Thu, 16 Apr 2026 20:17:28 +0300
Message-ID: <20260416171728.205141-3-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260416171728.205141-1-work@onurozkan.dev>
References: <20260416171728.205141-1-work@onurozkan.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add Tyr reset handling on top of the Rust SRCU abstraction and use
a hardware gate to serialize reset-sensitive accesses against asynchronous
reset work.

This introduces `ResetHandle`, `HwGate`, and `HwGuard`, runs reset work
on a dedicated ordered workqueue and drains in-flight accesses before
running the reset sequence.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 drivers/gpu/drm/tyr/driver.rs        |  40 +---
 drivers/gpu/drm/tyr/reset.rs         | 293 +++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/reset/hw_gate.rs | 155 ++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs           |   1 +
 4 files changed, 459 insertions(+), 30 deletions(-)
 create mode 100644 drivers/gpu/drm/tyr/reset.rs
 create mode 100644 drivers/gpu/drm/tyr/reset/hw_gate.rs

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 246bc3cb8580..178e48ccd434 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -6,11 +6,8 @@
         OptionalClk, //
     },
     device::{
-        Bound,
         Core,
-        Device, //
     },
-    devres::Devres,
     dma::{
         Device as DmaDevice,
         DmaMask, //
@@ -21,10 +18,6 @@
         ioctl,
         UnregisteredDevice, //
     },
-    io::{
-        poll,
-        Io, //
-    },
     new_mutex,
     of,
     platform,
@@ -37,17 +30,16 @@
         Arc,
         Mutex, //
     },
-    time, //
 };
 
 use crate::{
     file::TyrDrmFileData,
     fw::Firmware,
     gem::BoData,
-    gpu,
     gpu::GpuInfo,
     mmu::Mmu,
-    regs::gpu_control::*, //
+    regs::gpu_control::*,
+    reset, //
 };
 
 pub(crate) type IoMem = kernel::io::mem::IoMem<SZ_2M>;
@@ -62,6 +54,11 @@
 
 #[pin_data]
 pub(crate) struct TyrDrmDeviceData {
+    // `ResetHandle::drop()` drains queued/running works and this must happen
+    // before clocks/regulators are dropped. So keep this field before them to
+    // ensure the correct drop order.
+    pub(crate) reset: reset::ResetHandle,
+
     pub(crate) pdev: ARef<platform::Device>,
 
     pub(crate) fw: Arc<Firmware>,
@@ -90,24 +87,6 @@ unsafe impl Send for TyrDrmDeviceData {}
 // SAFETY: This will be removed in a future patch.
 unsafe impl Sync for TyrDrmDeviceData {}
 
-fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
-    let io = (*iomem).access(dev)?;
-    io.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
-
-    poll::read_poll_timeout(
-        || {
-            let io = (*iomem).access(dev)?;
-            Ok(io.read(GPU_IRQ_RAWSTAT))
-        },
-        |status| status.reset_completed(),
-        time::Delta::from_millis(1),
-        time::Delta::from_millis(100),
-    )
-    .inspect_err(|_| dev_err!(dev, "GPU reset failed."))?;
-
-    Ok(())
-}
-
 kernel::of_device_table!(
     OF_TABLE,
     MODULE_OF_TABLE,
@@ -140,8 +119,7 @@ fn probe(
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
         let iomem = Arc::pin_init(request.iomap_sized::<SZ_2M>(), GFP_KERNEL)?;
 
-        issue_soft_reset(pdev.as_ref(), &iomem)?;
-        gpu::l2_power_on(pdev.as_ref(), &iomem)?;
+        reset::run_reset(pdev.as_ref(), &iomem)?;
 
         let gpu_info = GpuInfo::new(pdev.as_ref(), &iomem)?;
         gpu_info.log(pdev.as_ref());
@@ -156,6 +134,7 @@ fn probe(
 
         let uninit_ddev = UnregisteredDevice::<TyrDrmDriver>::new(pdev.as_ref())?;
         let platform: ARef<platform::Device> = pdev.into();
+        let reset = reset::ResetHandle::new(platform.clone(), iomem.clone())?;
 
         let mmu = Mmu::new(pdev, iomem.as_arc_borrow(), &gpu_info)?;
 
@@ -181,6 +160,7 @@ fn probe(
                     _mali: mali_regulator,
                     _sram: sram_regulator,
                 }),
+                reset,
                 gpu_info,
         });
 
diff --git a/drivers/gpu/drm/tyr/reset.rs b/drivers/gpu/drm/tyr/reset.rs
new file mode 100644
index 000000000000..906051a1c667
--- /dev/null
+++ b/drivers/gpu/drm/tyr/reset.rs
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Provides asynchronous reset handling for the Tyr DRM driver via [`ResetHandle`]
+//! which runs reset work on a dedicated ordered workqueue and avoids duplicate
+//! pending resets.
+//!
+//! # High-level Execution Flow
+//!
+//! ```
+//!  User code                  Reset worker
+//!  ----------                 ------------
+//!  schedule()                 reset_work()
+//!    - Idle -> Pending          - Pending -> InProgress
+//!    - enqueue reset work       - synchronize() (wait for older accesses)
+//!                               - pre_reset() on reset managed hardware
+//!                               - run_reset()
+//!                               - post_reset() on reset managed hardware
+//!                               - epoch++, InProgress -> Idle
+//!                               - InProgress -> Idle
+//! ```
+
+mod hw_gate;
+
+use hw_gate::HwGate;
+
+use kernel::{
+    device::{
+        Bound,
+        Device, //
+    },
+    devres::Devres,
+    io::{
+        poll,
+        Io, //
+    },
+    platform,
+    prelude::*,
+    sync::{
+        aref::ARef,
+        atomic::AtomicType,
+        Arc, //
+    },
+    time,
+    workqueue::{
+        self,
+        OwnedQueue,
+        Queue,
+        Work, //
+    },
+};
+
+use crate::{
+    driver::IoMem,
+    gpu,
+    regs::gpu_control::*, //
+};
+
+/// Lifecycle state of the reset worker.
+#[derive(Clone, Copy, Debug, PartialEq, Eq)]
+#[repr(i32)]
+enum ResetState {
+    /// No reset is pending or in progress.
+    Idle = 0,
+    /// A reset has been scheduled but has not started executing yet.
+    Pending = 1,
+    /// The reset worker is actively resetting the hardware.
+    InProgress = 2,
+}
+
+// SAFETY: `ResetState` and `i32` have the same size and alignment, and are
+// round-trip transmutable.
+unsafe impl AtomicType for ResetState {
+    type Repr = i32;
+}
+
+/// Trait for the reset-managed hardware.
+///
+/// [`ActiveHwState`] groups the hardware blocks that implement this trait
+/// and defines their pre-reset and post-reset hook sequence.
+///
+/// Once reset scheduling flips the gate out of [`ResetState::Idle`], the reset
+/// worker first drains any pre-existing SRCU readers before running pre_reset()
+// and post_reset() hooks.
+///
+/// `pre_reset()` is infallible and returning `Err` from `post_reset()` is treated
+/// as a reset-cycle failure.
+pub(crate) trait Resettable: Send + Sync {
+    /// Called before the reset sequence starts and the hardware is reset.
+    ///
+    /// Before this is called, the reset worker waits for all pre-existing
+    /// hardware accesses to complete.
+    fn pre_reset(&self);
+
+    /// Called after the hardware reset completes.
+    ///
+    /// `reset_failed` is `true` if an earlier stage in the current reset cycle
+    /// has already failed. Returning `Err` fails the entire cycle.
+    fn post_reset(&self, reset_failed: bool) -> Result;
+}
+
+/// Reset-managed hardware state coordinated by [`HwGate`].
+///
+/// Groups the driver components that must quiesce before a GPU reset and resume
+/// afterwards. The [`Resettable`] implementation defines the pre-reset and post-reset
+/// hook sequence for those components.
+struct ActiveHwState {
+    // mmu: Arc<Mmu>,
+}
+
+impl Resettable for ActiveHwState {
+    fn pre_reset(&self) {
+        // self.mmu.pre_reset();
+    }
+
+    fn post_reset(&self, _reset_failed: bool) -> Result {
+        // self.mmu.post_reset()?;
+        Ok(())
+    }
+}
+
+/// Internal reset orchestrator that owns the gate and work item.
+#[pin_data]
+struct Controller {
+    /// Platform device reference needed for reset operations and logging.
+    pdev: ARef<platform::Device>,
+    /// Mapped register space needed for reset operations.
+    iomem: Arc<Devres<IoMem>>,
+    /// Access gate for reset managed hardware users.
+    #[pin]
+    hw: HwGate<ActiveHwState>,
+    /// Work item backing async reset processing.
+    #[pin]
+    work: Work<Controller>,
+}
+
+kernel::impl_has_work! {
+    impl HasWork<Controller> for Controller { self.work }
+}
+
+impl workqueue::WorkItem for Controller {
+    type Pointer = Arc<Self>;
+
+    fn run(this: Arc<Self>) {
+        this.reset_work();
+    }
+}
+
+impl Controller {
+    /// Creates an [`Arc<Controller>`] ready for use.
+    fn new(pdev: ARef<platform::Device>, iomem: Arc<Devres<IoMem>>) -> Result<Arc<Self>> {
+        Arc::pin_init(
+            try_pin_init!(Self {
+                pdev,
+                iomem,
+                hw <- HwGate::new(ActiveHwState {}),
+                work <- kernel::new_work!("tyr::reset"),
+            }),
+            GFP_KERNEL,
+        )
+    }
+
+    /// Processes one scheduled reset request.
+    ///
+    /// If the pending reset cannot be claimed, the worker returns immediately.
+    ///
+    /// It first claims [`ResetState::Pending`], then waits for earlier hardware
+    /// accesses to complete before running the pre-reset hook. After that it issues
+    /// the hardware reset, runs the post-reset hooks and finally returns the gate to
+    /// the [`ResetState::Idle`] state.
+    ///
+    /// Panthor reference:
+    /// - drivers/gpu/drm/panthor/panthor_device.c::panthor_device_reset_work()
+    fn reset_work(self: &Arc<Self>) {
+        if !self.hw.start_reset() {
+            // Another reset is already pending or in progress, so we skip this one.
+            return;
+        }
+
+        dev_info!(self.pdev.as_ref(), "Starting GPU reset.\n");
+
+        // Wait for all hardware accesses that started before reset became
+        // visible to finish before running the reset callbacks.
+        self.hw.synchronize();
+
+        self.hw.pre_reset();
+
+        // SAFETY: `Controller` is part of driver-private data and only exists
+        // while the platform device is bound.
+        let pdev = unsafe { self.pdev.as_ref().as_bound() };
+
+        let mut reset_failed = false;
+        if let Err(e) = run_reset(pdev, &self.iomem) {
+            reset_failed = true;
+            dev_err!(self.pdev.as_ref(), "GPU reset failed: {:?}\n", e);
+        }
+
+        if let Err(_e) = self.hw.post_reset(reset_failed) {
+            // TODO: Unplug the GPU.
+            // There is no API for unplugging the GPU and this is unreachable
+            // for now since there are no hardware users for reset API.
+        }
+
+        if reset_failed {
+            dev_err!(self.pdev.as_ref(), "GPU reset cycle failed.\n");
+        } else {
+            dev_info!(self.pdev.as_ref(), "GPU reset completed.\n");
+        }
+
+        self.hw.finish_reset();
+    }
+}
+
+/// User-facing handle for scheduling resets.
+///
+/// Dropping the handle drains any queued or in-flight reset work to ensure a
+/// clean teardown before clocks and regulators are released.
+pub(crate) struct ResetHandle {
+    controller: Arc<Controller>,
+    wq: OwnedQueue,
+}
+
+impl ResetHandle {
+    /// Creates [`ResetHandle`].
+    pub(crate) fn new(pdev: ARef<platform::Device>, iomem: Arc<Devres<IoMem>>) -> Result<Self> {
+        Ok(Self {
+            controller: Controller::new(pdev, iomem)?,
+            wq: Queue::new_ordered().build(c"tyr-reset-wq")?,
+        })
+    }
+
+    /// Schedules a GPU reset on the dedicated workqueue.
+    ///
+    /// If a reset is already pending or in progress the call is a no-op.
+    #[expect(dead_code)]
+    pub(crate) fn schedule(&self) {
+        // TODO: Similar to `panthor_device_schedule_reset()` in Panthor, add a
+        // power management check once Tyr supports it.
+
+        // Keep only one reset request running or queued. If one is already pending,
+        // we ignore new schedule requests.
+        if self.controller.hw.begin_reset() && self.wq.enqueue(self.controller.clone()).is_err() {
+            self.controller.hw.cancel_reset();
+        }
+    }
+}
+
+impl Drop for ResetHandle {
+    fn drop(&mut self) {
+        // Drain queued/running work and block future queueing attempts for this
+        // work item before clocks/regulators are cleaned up.
+        self.controller.work.disable_sync();
+    }
+}
+
+/// Issues a soft reset command and waits for reset-complete IRQ status.
+fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
+    let io = (*iomem).access(dev)?;
+
+    // Clear any stale reset-complete IRQ state before issuing a new soft reset.
+    io.write_reg(GPU_IRQ_CLEAR::zeroed().with_reset_completed(true));
+
+    io.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));
+
+    poll::read_poll_timeout(
+        || {
+            let io = (*iomem).access(dev)?;
+            Ok(io.read(GPU_IRQ_RAWSTAT))
+        },
+        |status| status.reset_completed(),
+        time::Delta::from_millis(1),
+        time::Delta::from_millis(100),
+    )
+    .inspect_err(|_| dev_err!(dev, "GPU reset timed out."))?;
+
+    Ok(())
+}
+
+/// Runs one synchronous GPU reset pass.
+///
+/// Its visibility is `pub(super)` only so the probe path can run an
+/// initial reset; it is not part of this module's public API.
+///
+/// On success, the GPU is left in a state suitable for reinitialization.
+///
+/// The sequence is as follows:
+///   - Trigger a GPU soft reset.
+///   - Wait for the reset-complete IRQ status.
+///   - Power L2 back on.
+pub(super) fn run_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
+    issue_soft_reset(dev, iomem)?;
+    gpu::l2_power_on(dev, iomem)?;
+    Ok(())
+}
diff --git a/drivers/gpu/drm/tyr/reset/hw_gate.rs b/drivers/gpu/drm/tyr/reset/hw_gate.rs
new file mode 100644
index 000000000000..ff304ca127f3
--- /dev/null
+++ b/drivers/gpu/drm/tyr/reset/hw_gate.rs
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! SRCU based hardware access gate.
+//!
+//! This module provides [`HwGate`] which is a generic, SRCU based gate
+//! that serialises hardware access against asynchronous reset cycles.
+
+use super::{
+    ResetState,
+    Resettable, //
+};
+
+use kernel::{
+    prelude::*,
+    sync::{
+        atomic::{
+            Atomic,
+            Relaxed, //
+        },
+        srcu, Srcu,
+    },
+};
+
+use core::ops::Deref;
+
+/// A gate that coordinates hardware access with asynchronous resets.
+#[pin_data]
+pub(crate) struct HwGate<T: Resettable> {
+    #[pin]
+    srcu: Srcu,
+    state: Atomic<ResetState>,
+    epoch: Atomic<u64>,
+    hw: T,
+}
+
+impl<T: Resettable> HwGate<T> {
+    /// Creates a new gate for the given `hw` in [`ResetState::Idle`] state.
+    pub(super) fn new(hw: T) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            srcu <- kernel::new_srcu!(),
+            state: Atomic::new(ResetState::Idle),
+            epoch: Atomic::new(0),
+            hw,
+        })
+    }
+
+    /// Tries to acquire the hardware access guard.
+    ///
+    /// Returns [`EBUSY`] if a reset is pending or in progress.
+    pub(crate) fn try_access(&self) -> Result<HwGuard<'_, T>> {
+        let srcu = self.srcu.read_lock();
+
+        if self.state.load(Relaxed) != ResetState::Idle {
+            return Err(EBUSY);
+        }
+
+        let epoch = self.epoch.load(Relaxed);
+
+        Ok(HwGuard {
+            hw: &self.hw,
+            epoch,
+            _srcu: srcu,
+        })
+    }
+
+    /// Runs `f` with [`HwGuard`], failing fast with [`EBUSY`] if a reset is
+    /// pending or in progress.
+    #[expect(dead_code)]
+    pub(crate) fn with_hw<R>(&self, f: impl FnOnce(&HwGuard<'_, T>) -> Result<R>) -> Result<R> {
+        let guard = self.try_access()?;
+        f(&guard)
+    }
+
+    /// Transitions from [`ResetState::Idle`] to [`ResetState::Pending`].
+    ///
+    /// Returns `true` if the transition succeeded (i.e. no reset was already
+    /// scheduled).
+    pub(super) fn begin_reset(&self) -> bool {
+        self.state
+            .cmpxchg(ResetState::Idle, ResetState::Pending, Relaxed)
+            .is_ok()
+    }
+
+    /// Transitions from [`ResetState::Pending`] to [`ResetState::InProgress`].
+    ///
+    /// Returns `true` if the transition succeeded.
+    pub(super) fn start_reset(&self) -> bool {
+        self.state
+            .cmpxchg(ResetState::Pending, ResetState::InProgress, Relaxed)
+            .is_ok()
+    }
+
+    /// Transitions from [`ResetState::InProgress`] to [`ResetState::Idle`]
+    /// and bumps the epoch.
+    pub(super) fn finish_reset(&self) {
+        self.epoch.fetch_add(1, Relaxed);
+        self.state.store(ResetState::Idle, Relaxed);
+    }
+
+    /// Transitions from [`ResetState::Pending`] to [`ResetState::Idle`].
+    pub(super) fn cancel_reset(&self) {
+        self.state.store(ResetState::Idle, Relaxed);
+    }
+
+    /// Waits for all pre-existing SRCU readers to complete.
+    ///
+    /// This must only be called from the reset worker after the state has left
+    /// [`ResetState::Idle`], so that no new readers can enter.
+    pub(super) fn synchronize(&self) {
+        self.srcu.synchronize();
+    }
+}
+
+impl<T: Resettable> Resettable for HwGate<T> {
+    fn pre_reset(&self) {
+        self.hw.pre_reset()
+    }
+
+    fn post_reset(&self, reset_failed: bool) -> Result {
+        self.hw.post_reset(reset_failed)
+    }
+}
+
+/// A hardware guard that is only present when the hardware is accessible.
+///
+/// Holding a [`HwGuard`] means the hardware is still in use and prevents
+/// the reset path from proceeding. The reset worker waits for all active
+/// guards to be dropped before it continues with the reset.
+#[must_use = "the hardware guard must be kept alive while using reset-sensitive state"]
+pub(crate) struct HwGuard<'a, T> {
+    hw: &'a T,
+    epoch: u64,
+    _srcu: srcu::Guard<'a>,
+}
+
+impl<T> HwGuard<'_, T> {
+    /// Returns the epoch at which this guard was acquired.
+    ///
+    /// This is a snapshot of [`HwGate`]'s epoch counter taken when the guard
+    /// was acquired. The gate increments that counter each time a reset cycle
+    /// completes. Callers can compare epochs from separate access windows to
+    /// detect whether a reset happened in between.
+    #[expect(dead_code)]
+    pub(crate) fn epoch(&self) -> u64 {
+        self.epoch
+    }
+}
+
+impl<T> Deref for HwGuard<'_, T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        self.hw
+    }
+}
diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
index 18b0668bb217..d0349bc49f27 100644
--- a/drivers/gpu/drm/tyr/tyr.rs
+++ b/drivers/gpu/drm/tyr/tyr.rs
@@ -14,6 +14,7 @@
 mod gpu;
 mod mmu;
 mod regs;
+mod reset;
 mod slot;
 mod vm;
 
-- 
2.51.2

