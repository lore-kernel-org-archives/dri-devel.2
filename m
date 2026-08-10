Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 569EEC5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B251710E18F;
	Mon, 10 Aug 2026 08:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="a22kh4Ru";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ACA310E1F1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 08:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786349510;
 bh=B8ECLxTqX185rBSx7pg5nmBpje5EAUuD31go+NlGAAg=;
 h=From:Date:Subject:To:Cc:From;
 b=a22kh4Ruw8SReUkv9AuGMPJK8/pxLNYO5LzKR7MPIwgwM7sWS3k5VfaVk5RIDbSL/
 gSEGZf+KzvUY8qFKisAwpi4M7Rjih3rXJ52zii6PMC6RNvoXnab71wB4ZGqnVlb2gz
 VCcZEehMDCW00CvWvqE8VzfY9qBYRAQpww7KdG+W57xA8O+SkOMMDWPDJpJQXPChwt
 jF+8YiaV300hPqMdNGEsX2mZiHAtjAa23qGYVHqpLR7eDF9VAzwjqvX0Y9HAxtOF0Q
 KTCrQGGbqZJb5bBzc3kzBLHf7j08elk6zFoMp/K4qc9xCQe1/9wHWxal99IRT78KAE
 HbtQZWPE3S5qw==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B854517E07F5;
 Mon, 10 Aug 2026 10:11:49 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
Date: Mon, 10 Aug 2026 10:11:35 +0200
Subject: [PATCH v5] drm/tyr: add Job IRQ handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-tyr-irq-v2-v5-1-59fd9dea952a@collabora.com>
X-B4-Tracking: v=1; b=H4sIALaHeWoC/23O0QqCMBTG8VeRXbc4O3Pquuo9ogs9zRyYq01GE
 r57K4g0gt18B35/9mDBeGsC22UP5k20wbohDbXJGHX1cDbcntJmCFhAiRUfJ8+tv/GIHBpJChA
 bIyVL4OpNa+/v2OGYdmfD6Pz0bkd8XT8ZvcykJzhhqaAlIU5K78n1fd04X2/JXdgrFeWSr34RZ
 eKadEOKADWpfzz/8grUiueJV6LOSxCFEAS/fJ7nJ1UDFUEmAQAA
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, kernel@collabora.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 Laura Nao <laura.nao@collabora.com>
X-Mailer: b4 0.12.0
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

Add a threaded IRQ wrapper for Tyr interrupt sources and use it to
handle the firmware Job IRQ.

The Job IRQ reports requests from the CSF firmware, including global
interface requests and CSG attention bits. Only the GLB bit is currently
handled, as it will be used to check firmware readiness. CSG bits
handling will be added at a later stage. Add a Job IRQ handler that
masks the interrupt in the primary IRQ handler, processes pending raw
status in the threaded handler, clears the handled bit, and reenables
the mask before returning.
Add a wait queue and a bool flag so the handler can signal firmware
readiness when the GLB bit is set.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
Changes in v5:
- Implement PinnedDrop on TyrIrq to clear the interrupt mask on teardown 
- Link to v4: https://lore.kernel.org/r/20260805-tyr-irq-v2-v4-1-81a4701611c0@collabora.com

Changes in v4:
- Replaced c_str! with C-String in irq.rs
- Moved clear_status() before handle() in handle_threaded(), to avoid 
  losing events if hw re-asserts the bit while handle() is running.
- Only unmask interrupt sources in job_irq_init() when the handler is 
  correctly registered.
- Link to v3: https://lore.kernel.org/r/20260728-tyr-irq-v2-v3-1-9c9bc5c029c5@collabora.com

Changes in v3:
- Propagated request_threaded_irq_by_name safety requirement up the
  call chain, made TyrIrq::request() and job_irq_init() unsafe
- Dropped CSG bits masking, added TODO comment to note this will be
  handled at a later stage. Reworded commit message to reflect the
  change.
- Added documentation for TyrIrqTrait, TyrIrq, JobIrq and job_irq_init()
- Link to v2: https://lore.kernel.org/r/20260729-tyr-irq-v2-v2-1-c2750fc11d59@collabora.com

Changes in v2:
- Dropped Wait custom type in favor of WaitQueue
- Renamed JobIrq lifetime to generic 'a

This patch follows up to [1], which adds support for firmware loading
and MCU booting to the Tyr driver. The changes included here were
originally introduced in its v4[2], then dropped to reduce the scope of
the series, and have been adjusted to work with the HRT (Higher-Ranked
Lifetime Types) driver architecture recently introduced.

The patch adds a threaded IRQ wrapper for the firmware Job interrupts,
used to signal events from the global CSF (GLB) and Command Stream Group
(CSG) interfaces.

These changes will be later used to wait for global CSF interface
readiness after firmware boot, as part of the CSF firmware interfaces
support that will be submitted as a separate series.

This patch is based on drm-rust-next and depends on:
- [PATCH v2] rust: irq: make Registration compatible with lifetime-bound drivers[3]
- [PATCH 0/5] rust: sync: add WaitQueue infrastructure[4]

Note: [4] doesn't apply cleanly on drm-rust-next at the moment, due to
missing changes in rust/kernel/sync/lock/spinlock.rs[5]. I've applied
all dependencies and fixed conflicts for the purpose of testing this
patch on top of drm-rust-next, a branch with these changes is available
here: https://gitlab.freedesktop.org/laura.nao/linux/-/commits/b4/tyr-irq-v5

[1] https://lore.kernel.org/all/20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com/ 
[2] https://lore.kernel.org/rust-for-linux/20260424-b4-fw-boot-v4-v4-15-a5d91050789d@collabora.com/
[3] https://lore.kernel.org/rust-for-linux/20260719153631.559341-1-dakr@kernel.org/
[4] https://lore.kernel.org/rust-for-linux/20260726223613.1242940-1-dakr@kernel.org/
[5] https://lore.kernel.org/all/20260302232154.861916-1-lyude@redhat.com/
---
 drivers/gpu/drm/tyr/driver.rs | 108 ++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/fw.rs     |   1 +
 drivers/gpu/drm/tyr/fw/irq.rs | 112 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 221 insertions(+)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index d78ad9d292ff..495cc3baa98c 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
+use core::marker::PhantomPinned;
+
 use kernel::{
     clk::{
         Clk,
@@ -21,6 +23,13 @@
         poll,
         Io, //
     },
+    irq::{
+        Flags,
+        IrqReturn,
+        ThreadedHandler,
+        ThreadedIrqReturn,
+        ThreadedRegistration, //
+    },
     new_mutex,
     of,
     platform,
@@ -236,3 +245,102 @@ struct Regulators {
     _mali: Regulator<regulator::Enabled>,
     _sram: Regulator<regulator::Enabled>,
 }
+
+/// Trait describing the operations required to service a Tyr interrupt source.
+pub(crate) trait TyrIrqTrait: Sync {
+    /// Returns the masked interrupt status.
+    fn read_status(&self) -> u32;
+
+    /// Clears all bits in the mask register, disabling the interrupt sources.
+    fn clear_mask(&self);
+
+    /// Sets the mask register to re-enable the interrupt sources.
+    fn reenable_mask(&self);
+
+    /// Returns the raw interrupt status, regardless of the current mask.
+    fn read_raw_status(&self) -> u32;
+
+    /// Clears the given bits in the interrupt status register.
+    fn clear_status(&self, status: u32);
+
+    /// Returns the bitmask of interrupt sources handled by this instance.
+    fn mask(&self) -> u32;
+
+    /// Handles the given pending, unmasked interrupt bits.
+    fn handle(&self, status: u32);
+}
+
+/// A threaded IRQ wrapper shared by all Tyr interrupt sources.
+#[pin_data(PinnedDrop)]
+pub(crate) struct TyrIrq<T: TyrIrqTrait> {
+    /// The interrupt source.
+    irq: T,
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+impl<T: TyrIrqTrait> TyrIrq<T> {
+    /// Requests a threaded IRQ registration for `irq`, using `name` to look up the interrupt.
+    ///
+    /// # Safety
+    ///
+    /// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
+    /// [`Drop`] implementation from running.
+    pub(crate) unsafe fn request<'a>(
+        pdev: &'a platform::Device<Bound>,
+        name: &'static CStr,
+        irq: T,
+    ) -> Result<impl PinInit<ThreadedRegistration<'a, Self>, Error> + 'a>
+    where
+        T: 'a,
+    {
+        let handler = try_pin_init!(Self {
+            irq,
+            _pin: PhantomPinned,
+        });
+
+        // SAFETY: The caller guarantees the resulting registration will not be leaked.
+        Ok(unsafe { pdev.request_threaded_irq_by_name(Flags::SHARED, name, name, handler) })
+    }
+
+    /// Returns a reference to the wrapped interrupt source.
+    pub(crate) fn irq(&self) -> &T {
+        &self.irq
+    }
+}
+
+impl<T: TyrIrqTrait> ThreadedHandler for TyrIrq<T> {
+    fn handle(&self) -> ThreadedIrqReturn {
+        let masked_status = self.irq.read_status();
+
+        if masked_status == 0 {
+            return ThreadedIrqReturn::None;
+        }
+        self.irq.clear_mask();
+        ThreadedIrqReturn::WakeThread
+    }
+
+    fn handle_threaded(&self) -> IrqReturn {
+        let mut ret = IrqReturn::None;
+
+        loop {
+            let raw_status = self.irq.read_raw_status() & self.irq.mask();
+            if raw_status == 0 {
+                break;
+            }
+            self.irq.clear_status(raw_status);
+            self.irq.handle(raw_status);
+            ret = IrqReturn::Handled;
+        }
+
+        self.irq.reenable_mask();
+        ret
+    }
+}
+
+#[pinned_drop]
+impl<T: TyrIrqTrait> PinnedDrop for TyrIrq<T> {
+    fn drop(self: Pin<&mut Self>) {
+        self.irq.clear_mask();
+    }
+}
diff --git a/drivers/gpu/drm/tyr/fw.rs b/drivers/gpu/drm/tyr/fw.rs
index 47d25c901bd0..8162b9806c97 100644
--- a/drivers/gpu/drm/tyr/fw.rs
+++ b/drivers/gpu/drm/tyr/fw.rs
@@ -69,6 +69,7 @@
     vm::Vm, //
 };
 
+pub(crate) mod irq;
 mod parser;
 
 pub(super) const CSF_MCU_SHARED_REGION_START: u32 = 0x04000000;
diff --git a/drivers/gpu/drm/tyr/fw/irq.rs b/drivers/gpu/drm/tyr/fw/irq.rs
new file mode 100644
index 000000000000..fcdc0097f2dd
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw/irq.rs
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! IRQ handling for the Job IRQ.
+//!
+//! The Job IRQ signals events from the MCU, including global interface acknowledgements.
+#![allow(dead_code)]
+
+use core::sync::atomic::{
+    AtomicBool,
+    Ordering, //
+};
+
+use kernel::{
+    device::Bound, //
+    io::Io,
+    irq::ThreadedRegistration,
+    platform,
+    prelude::*,
+    sync::{
+        Arc,
+        WaitQueue, //
+    },
+};
+
+use crate::{
+    driver::{
+        IoMem,
+        TyrIrq,
+        TyrIrqTrait, //
+    },
+    regs::job_control::{
+        JOB_IRQ_CLEAR,
+        JOB_IRQ_MASK,
+        JOB_IRQ_RAWSTAT,
+        JOB_IRQ_STATUS, //
+    }, //
+};
+
+// The Job IRQ, signalling requests or notification from the MCU.
+pub(crate) struct JobIrq<'a> {
+    /// GPU MMIO register mapping.
+    iomem: Arc<IoMem<'a>>,
+    /// Flag to signal firmware readiness.
+    fw_ready: Arc<AtomicBool>,
+    /// Wait queue used to signal firmware events to waiters.
+    job_irq_wait: Arc<WaitQueue>,
+}
+
+/// Requests a threaded IRQ registration for the Job IRQ.
+///
+/// # Safety
+///
+/// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
+/// [`Drop`] implementation from running.
+pub(crate) unsafe fn job_irq_init<'a>(
+    pdev: &'a platform::Device<Bound>,
+    iomem: Arc<IoMem<'a>>,
+    fw_ready: Arc<AtomicBool>,
+    job_irq_wait: Arc<WaitQueue>,
+) -> Result<impl PinInit<ThreadedRegistration<'a, TyrIrq<JobIrq<'a>>>, Error> + 'a> {
+    let job_irq = JobIrq {
+        iomem,
+        fw_ready,
+        job_irq_wait,
+    };
+    // Ensure interrupt sources are disabled until the handler is registered.
+    job_irq.clear_mask();
+
+    // SAFETY: The caller guarantees the resulting registration will not be leaked.
+    let registration = unsafe { TyrIrq::request(pdev, c"job", job_irq) };
+
+    // Unmask once the handler has been successfully registered.
+    Ok(registration?.pin_chain(|reg| {
+        reg.handler().irq().reenable_mask();
+        Ok(())
+    }))
+}
+
+impl TyrIrqTrait for JobIrq<'_> {
+    fn read_status(&self) -> u32 {
+        self.iomem.read(JOB_IRQ_STATUS).into_raw()
+    }
+
+    fn clear_mask(&self) {
+        self.iomem.write_reg(JOB_IRQ_MASK::zeroed());
+    }
+
+    fn reenable_mask(&self) {
+        self.iomem.write_reg(JOB_IRQ_MASK::zeroed().with_glb(true));
+    }
+
+    fn read_raw_status(&self) -> u32 {
+        self.iomem.read(JOB_IRQ_RAWSTAT).into_raw()
+    }
+
+    fn clear_status(&self, status: u32) {
+        self.iomem.write_reg(JOB_IRQ_CLEAR::from_raw(status));
+    }
+
+    fn mask(&self) -> u32 {
+        JOB_IRQ_MASK::zeroed().with_glb(true).into_raw()
+    }
+
+    fn handle(&self, status: u32) {
+        // TODO: handle other Job IRQ events (e.g. CSG attention bits) here once
+        // support for them is added.
+        if JOB_IRQ_RAWSTAT::from_raw(status).glb() {
+            self.fw_ready.store(true, Ordering::Release);
+            self.job_irq_wait.wake_up_all();
+        }
+    }
+}

---
base-commit: 0710742e26a06c2c3167e77a8ea82b59632d9f7a
change-id: 20260728-tyr-irq-v2-0b3c5022be33

Best regards,
-- 
Laura Nao <laura.nao@collabora.com>

