Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A200C5DF9D
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:01:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 997F110EEEC;
	Thu, 27 Aug 2026 08:01:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="l5KJYXne";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86EB10EEE2
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1787817699;
 bh=77OMG1yMlk2S+XLapaAHmA8HLMfeEQjwSs54ZOhvf8k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=l5KJYXneUGFURdYQ8dEXKb9WainViQfpBucw8qMIcVUDwNmkm3dTIBQijvgGMLyhl
 tuSYAT0KMsG08EkYKJ/8b2PJnH0B9Fm6I6uk/W542gkQl4jQYBp8LPPPj5GPDWYDeD
 8swfO4TOt3Kr4F7Lb4r1nra74eP3ArAvWE7SRb1a0uIGnHvqXizDlEncSvb7AyM+XJ
 793BpdctqQ41WS2qWLaCjnvde7xb0IcrEzMea+iR3/YVGZQ3JdF4rFr7k5//91E7mz
 LHXja94/74m+sSTuzmmVrl+OWyW/LDpyUYNjFjWza0Q8jq3cTD749cuEdSO2FmH5i3
 ZRKhOAGJaKHPg==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CA5E417E0566;
 Thu, 27 Aug 2026 10:01:38 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
Date: Thu, 27 Aug 2026 10:01:11 +0200
Subject: [PATCH v6 2/2] drm/tyr: add Job IRQ handling
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-tyr-irq-v2-v6-2-15c90baed949@collabora.com>
References: <20260728-tyr-irq-v2-v6-0-15c90baed949@collabora.com>
In-Reply-To: <20260728-tyr-irq-v2-v6-0-15c90baed949@collabora.com>
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
 Laura Nao <laura.nao@collabora.com>, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
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

The Job IRQ reports requests from the CSF firmware, including global
interface requests and CSG attention bits. Only the GLB bit is currently
handled, as it will be used to check firmware readiness. CSG bits
handling will be added at a later stage. The Job IRQ handler masks the
interrupt in the primary IRQ handler, processes pending raw status in
the threaded handler, clears the handled bits, and reenables the mask
before returning.
Add JobIrqEvents to hold the wait queue and the ready flag used to
signal firmware readiness when the GLB bit is set, and JobIrqMaskGuard
to ensure the Job IRQ is masked before its registration is freed.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/gpu/drm/tyr/fw.rs     |   1 +
 drivers/gpu/drm/tyr/fw/irq.rs | 174 ++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/irq.rs    |   1 -
 3 files changed, 175 insertions(+), 1 deletion(-)

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
index 000000000000..7dd894de18cb
--- /dev/null
+++ b/drivers/gpu/drm/tyr/fw/irq.rs
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! IRQ handling for the Job IRQ.
+//!
+//! The Job IRQ signals events from the MCU, including global interface acknowledgements.
+#![allow(dead_code)]
+
+use kernel::{
+    device::Bound, //
+    io::Io,
+    irq::ThreadedRegistration,
+    new_waitqueue,
+    platform,
+    prelude::*,
+    sync::{
+        atomic::{
+            ordering,
+            Atomic, //
+        },
+        Arc,
+        WaitQueue, //
+    },
+    time::{
+        msecs_to_jiffies,
+        Msecs, //
+    },
+};
+
+use crate::{
+    driver::IoMem,
+    irq::{
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
+/// The firmware events published by the Job IRQ handler, and the queue used to announce them.
+#[pin_data]
+pub(crate) struct JobIrqEvents {
+    #[pin]
+    wait: WaitQueue,
+    /// Set once the firmware has signalled that the global interface is ready.
+    ready: Atomic<bool>,
+}
+
+impl JobIrqEvents {
+    /// Creates a new, empty set of Job IRQ events.
+    pub(crate) fn new() -> Result<Arc<Self>> {
+        Arc::pin_init(
+            pin_init!(JobIrqEvents {
+                wait <- new_waitqueue!(),
+                ready: Atomic::new(false),
+            }),
+            GFP_KERNEL,
+        )
+    }
+
+    /// Clears the firmware-ready state.
+    pub(crate) fn clear_ready(&self) {
+        self.ready.store(false, ordering::Relaxed);
+    }
+
+    /// Waits until the firmware signals readiness via the GLB IRQ bit, or the timeout expires.
+    pub(crate) fn wait_ready(&self, timeout_ms: Msecs) -> Result {
+        self.wait.wait_event_timeout(
+            || self.ready.load(ordering::Acquire),
+            msecs_to_jiffies(timeout_ms),
+        )?;
+
+        Ok(())
+    }
+
+    /// Updates state and wakes up waiters
+    fn signal(&self, status: u32) {
+        // TODO: handle other Job IRQ events (e.g. CSG attention bits) here once
+        // support for them is added.
+
+        // The GLB bit only signals firmware readiness once, at power up
+        if JOB_IRQ_RAWSTAT::from_raw(status).glb() && !self.ready.load(ordering::Relaxed) {
+            self.ready.store(true, ordering::Release);
+        }
+
+        self.wait.wake_up_all();
+    }
+}
+
+// The Job IRQ, signalling requests or notification from the MCU.
+pub(crate) struct JobIrq<'a> {
+    /// GPU MMIO register mapping.
+    iomem: Arc<IoMem<'a>>,
+    /// Firmware events signalled by this IRQ.
+    events: Arc<JobIrqEvents>,
+}
+
+/// Guard that masks the Job IRQ when dropped.
+///
+/// To mask the Job IRQ before it is freed, this guard must be stored in a field declared
+/// before the corresponding `ThreadedRegistration` in the struct that owns both. Since
+/// struct fields are dropped in declaration order, this guarantees the Job IRQ is masked
+/// first, and only then does `free_irq()` run and wait for any in-flight handler to
+/// complete.
+pub(crate) struct JobIrqMaskGuard<'a>(Arc<IoMem<'a>>);
+
+impl Drop for JobIrqMaskGuard<'_> {
+    fn drop(&mut self) {
+        self.0.write_reg(JOB_IRQ_MASK::zeroed());
+    }
+}
+
+/// Requests a threaded IRQ registration for the Job IRQ.
+///
+/// Returns a [`JobIrqMaskGuard`] alongside the registration. The guard must be stored in a
+/// field declared before the registration in the struct that owns both, so that the Job
+/// IRQ is masked before it is freed. See [`JobIrqMaskGuard`] for details.
+///
+/// # Safety
+///
+/// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
+/// [`Drop`] implementation from running.
+pub(crate) unsafe fn job_irq_init<'a>(
+    pdev: &'a platform::Device<Bound>,
+    iomem: Arc<IoMem<'a>>,
+    events: Arc<JobIrqEvents>,
+) -> Result<(
+    JobIrqMaskGuard<'a>,
+    impl PinInit<ThreadedRegistration<'a, TyrIrq<JobIrq<'a>>>, Error> + 'a,
+)> {
+    let mask_guard = JobIrqMaskGuard(iomem.clone());
+
+    let job_irq = JobIrq { iomem, events };
+    // Ensure interrupt sources are disabled until the handler is registered.
+    job_irq.clear_mask();
+
+    // SAFETY: The caller guarantees the resulting registration will not be leaked.
+    let registration = unsafe { TyrIrq::request(pdev, c"job", job_irq) }?;
+
+    Ok((mask_guard, registration))
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
+        self.iomem.write_reg(JOB_IRQ_MASK::from_raw(self.mask()));
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
+        self.events.signal(status);
+    }
+}
diff --git a/drivers/gpu/drm/tyr/irq.rs b/drivers/gpu/drm/tyr/irq.rs
index e6a739532daa..1905fd251ead 100644
--- a/drivers/gpu/drm/tyr/irq.rs
+++ b/drivers/gpu/drm/tyr/irq.rs
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
 //! Threaded IRQ wrapper shared by all Tyr interrupt sources.
-#![allow(dead_code)]
 use core::marker::PhantomPinned;
 
 use kernel::{

-- 
2.39.5

