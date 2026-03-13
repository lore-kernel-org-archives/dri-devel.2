Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D5A105F781
	for <dri-devel@archiver.kernel.org>; Fri, 13 Mar 2026 09:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7D7B10EB61;
	Fri, 13 Mar 2026 09:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="o6V5EXYb";
	dkim-atps=neutral
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net
 [178.154.239.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 717A710EB56
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 09:17:56 +0000 (UTC)
Received: from mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c0f:571a:0:640:23e3:0])
 by forward100a.mail.yandex.net (Yandex) with ESMTPS id 1F36BC0210;
 Fri, 13 Mar 2026 12:17:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id 3HEusrTGkmI0-lTVYqrRv; 
 Fri, 13 Mar 2026 12:17:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
 s=mail; t=1773393474;
 bh=9dj0+25F18WQitVKF1FKkRi87RpcIXAE7se35EAxq/U=;
 h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
 b=o6V5EXYbZIrlufNMT5CY6vcHF7CLZMGWPOQIIQNWOypaP9l6gc+r731hUx6nvR8zA
 1SDMpbmI/bhyJmP/hzKn5QuXQ73NRm+kLVhDQeHKxs7sY/Sj0jJH3z8Sw7bG6kSm5p
 EFx1e4qthJCkZb97tKcrNIBUk9452wNT+ztqElNs=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.vla.yp-c.yandex.net;
 dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: linux-kernel@vger.kernel.org
Cc: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v1 RESEND 4/4] drm/tyr: add GPU reset handling
Date: Fri, 13 Mar 2026 12:16:44 +0300
Message-ID: <20260313091646.16938-5-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260313091646.16938-1-work@onurozkan.dev>
References: <20260313091646.16938-1-work@onurozkan.dev>
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

Move Tyr reset logic into a new reset module and add async reset work.

This adds:
- ResetHandle with internal controller state
- a dedicated ordered reset workqueue
- a pending flag to avoid duplicate queued resets
- run_reset() as the shared synchronous reset helper

Probe now calls reset::run_reset() before normal init. Driver data now
keeps ResetHandle so reset work is drained before clocks and regulators
are dropped.

Tested-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 drivers/gpu/drm/tyr/driver.rs |  40 +++-----
 drivers/gpu/drm/tyr/reset.rs  | 180 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs    |   1 +
 3 files changed, 192 insertions(+), 29 deletions(-)
 create mode 100644 drivers/gpu/drm/tyr/reset.rs

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index f7951804e4e0..c80238a21ff2 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -6,11 +6,8 @@
         OptionalClk, //
     },
     device::{
-        Bound,
-        Core,
-        Device, //
+        Core, //
     },
-    devres::Devres,
     dma::{
         Device as DmaDevice,
         DmaMask, //
@@ -22,10 +19,7 @@
         Registered,
         UnregisteredDevice, //
     },
-    io::poll,
-    new_mutex,
-    of,
-    platform,
+    new_mutex, of, platform,
     prelude::*,
     regulator,
     regulator::Regulator,
@@ -35,17 +29,15 @@
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
-    regs, //
+    reset, //
 };
 
 pub(crate) type IoMem = kernel::io::mem::IoMem<SZ_2M>;
@@ -62,6 +54,11 @@ pub(crate) struct TyrPlatformDriverData {
 
 #[pin_data]
 pub(crate) struct TyrDrmDeviceData {
+    // `ResetHandle::drop()` drains queued/running works and this must happen
+    // before clocks/regulators are dropped. So keep this field before them to
+    // ensure the correct drop order.
+    pub(crate) reset: reset::ResetHandle,
+
     pub(crate) pdev: ARef<platform::Device>,
 
     pub(crate) fw: Arc<Firmware>,
@@ -90,22 +87,6 @@ unsafe impl Send for TyrDrmDeviceData {}
 // SAFETY: This will be removed in a future patch.
 unsafe impl Sync for TyrDrmDeviceData {}
 
-fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
-    // Clear any stale reset-complete IRQ state before issuing a new soft reset.
-    regs::GPU_IRQ_CLEAR.write(dev, iomem, regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED)?;
-    regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
-
-    poll::read_poll_timeout(
-        || regs::GPU_IRQ_RAWSTAT.read(dev, iomem),
-        |status| *status & regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED != 0,
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
@@ -138,8 +119,7 @@ fn probe(
         let request = pdev.io_request_by_index(0).ok_or(ENODEV)?;
         let iomem = Arc::pin_init(request.iomap_sized::<SZ_2M>(), GFP_KERNEL)?;
 
-        issue_soft_reset(pdev.as_ref(), &iomem)?;
-        gpu::l2_power_on(pdev.as_ref(), &iomem)?;
+        reset::run_reset(pdev.as_ref(), &iomem)?;
 
         let gpu_info = GpuInfo::new(pdev.as_ref(), &iomem)?;
         gpu_info.log(pdev);
@@ -153,6 +133,7 @@ fn probe(
 
         let uninit_ddev = UnregisteredDevice::<TyrDrmDriver>::new(pdev.as_ref())?;
         let platform: ARef<platform::Device> = pdev.into();
+        let reset = reset::ResetHandle::new(platform.clone(), iomem.clone())?;
 
         let mmu = Mmu::new(pdev, iomem.as_arc_borrow(), &gpu_info)?;
 
@@ -178,6 +159,7 @@ fn probe(
                     _mali: mali_regulator,
                     _sram: sram_regulator,
                 }),
+                reset,
                 gpu_info,
         });
         let ddev = Registration::new_foreign_owned(uninit_ddev, pdev.as_ref(), data, 0)?;
diff --git a/drivers/gpu/drm/tyr/reset.rs b/drivers/gpu/drm/tyr/reset.rs
new file mode 100644
index 000000000000..29dfae98b0dd
--- /dev/null
+++ b/drivers/gpu/drm/tyr/reset.rs
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Provides asynchronous reset handling for the Tyr DRM driver via
+//! [`ResetHandle`], which runs reset work on a dedicated ordered
+//! workqueue and avoids duplicate pending resets.
+
+use kernel::{
+    device::{
+        Bound,
+        Device, //
+    },
+    devres::Devres,
+    io::poll,
+    platform,
+    prelude::*,
+    sync::{
+        aref::ARef,
+        atomic::{
+            Acquire,
+            Atomic,
+            Relaxed,
+            Release, //
+        },
+        Arc,
+    },
+    time,
+    workqueue::{
+        self,
+        Work, //
+    },
+};
+
+use crate::{
+    driver::IoMem,
+    gpu,
+    regs, //
+};
+
+/// Manages asynchronous GPU reset handling and ensures only a single reset
+/// work is pending at a time.
+#[pin_data]
+struct Controller {
+    /// Platform device reference needed for reset operations and logging.
+    pdev: ARef<platform::Device>,
+    /// Mapped register space needed for reset operations.
+    iomem: Arc<Devres<IoMem>>,
+    /// Atomic flag for controlling the scheduling pending state.
+    pending: Atomic<bool>,
+    /// Dedicated ordered workqueue for reset operations.
+    wq: workqueue::OrderedQueue,
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
+    /// Creates a [`Controller`] instance.
+    fn new(pdev: ARef<platform::Device>, iomem: Arc<Devres<IoMem>>) -> Result<Arc<Self>> {
+        let wq = workqueue::OrderedQueue::new(c"tyr-reset-wq", 0)?;
+
+        Arc::pin_init(
+            try_pin_init!(Self {
+                pdev,
+                iomem,
+                pending: Atomic::new(false),
+                wq,
+                work <- kernel::new_work!("tyr::reset"),
+            }),
+            GFP_KERNEL,
+        )
+    }
+
+    /// Processes one scheduled reset request.
+    ///
+    /// Panthor reference:
+    /// - drivers/gpu/drm/panthor/panthor_device.c::panthor_device_reset_work()
+    fn reset_work(self: &Arc<Self>) {
+        dev_info!(self.pdev.as_ref(), "GPU reset work is started.\n");
+
+        // SAFETY: `Controller` is part of driver-private data and only exists
+        // while the platform device is bound.
+        let pdev = unsafe { self.pdev.as_ref().as_bound() };
+        if let Err(e) = run_reset(pdev, &self.iomem) {
+            dev_err!(self.pdev.as_ref(), "GPU reset failed: {:?}\n", e);
+        } else {
+            dev_info!(self.pdev.as_ref(), "GPU reset work is done.\n");
+        }
+
+        self.pending.store(false, Release);
+    }
+}
+
+/// Reset handle that shuts down pending work gracefully on drop.
+pub(crate) struct ResetHandle(Arc<Controller>);
+
+impl ResetHandle {
+    /// Creates a [`ResetHandle`] instance.
+    pub(crate) fn new(pdev: ARef<platform::Device>, iomem: Arc<Devres<IoMem>>) -> Result<Self> {
+        Ok(Self(Controller::new(pdev, iomem)?))
+    }
+
+    /// Schedules reset work.
+    #[expect(dead_code)]
+    pub(crate) fn schedule(&self) {
+        // TODO: Similar to `panthor_device_schedule_reset()` in Panthor, add a
+        // power management check once Tyr supports it.
+
+        // Keep only one reset request running or queued. If one is already pending,
+        // we ignore new schedule requests.
+        if self.0.pending.cmpxchg(false, true, Relaxed).is_ok()
+            && self.0.wq.enqueue(self.0.clone()).is_err()
+        {
+            self.0.pending.store(false, Release);
+        }
+    }
+
+    /// Returns true if a reset is queued or in progress.
+    ///
+    /// Note that the state can change immediately after the return.
+    #[inline]
+    #[expect(dead_code)]
+    pub(crate) fn is_pending(&self) -> bool {
+        self.0.pending.load(Acquire)
+    }
+}
+
+impl Drop for ResetHandle {
+    fn drop(&mut self) {
+        // Drain queued/running work and block future queueing attempts for this
+        // work item before clocks/regulators are torn down.
+        // SAFETY: drop executes in a sleepable context.
+        unsafe { self.0.work.disable_sync() };
+    }
+}
+
+/// Issues a soft reset command and waits for reset-complete IRQ status.
+fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
+    // Clear any stale reset-complete IRQ state before issuing a new soft reset.
+    regs::GPU_IRQ_CLEAR.write(dev, iomem, regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED)?;
+    regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
+
+    poll::read_poll_timeout(
+        || regs::GPU_IRQ_RAWSTAT.read(dev, iomem),
+        |status| *status & regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED != 0,
+        time::Delta::from_millis(1),
+        time::Delta::from_millis(100),
+    )
+    .inspect_err(|_| dev_err!(dev, "GPU reset failed."))?;
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
+/// The reset sequence is as follows:
+/// 1. Trigger a GPU soft reset.
+/// 2. Wait for the reset-complete IRQ status.
+/// 3. Power L2 back on.
+pub(super) fn run_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
+    issue_soft_reset(dev, iomem)?;
+    gpu::l2_power_on(dev, iomem)?;
+    Ok(())
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

