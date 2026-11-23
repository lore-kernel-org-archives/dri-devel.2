Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C190606A327
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XiUbwmb6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91CED10EC2E;
	Mon, 23 Nov 2026 14:59:08 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31C7B10EECA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1795445940;
 bh=uB7AxCXnP6snebE3RQFdQmWQFCw5EAP/cVbppSNycLM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XiUbwmb6hJzFNosfQmy1vYNrq3y9khMHSdyNBgI/Zz9BNVOZEoguzqIOs16Z2SQfx
 CvQHz62Sah4UOFvQM0bLryoA7S2ur8EcdnunX/kWgiegshYY2hpXsB4vjmkXtzKscf
 A0wFIWRv7+IjbYh0xJ8Kai+Er6CB494BrxxxmtFXdZu10LQAOyhVXZdZ4aSK6JeUdx
 jrmXupT5IrXuLpo0lTngs4IiN8pA6061oQWLXwRdMyg5xsPZfMFyiLfzeqxiV0aAhB
 nuKGnN/dBQf6+pvs1haRa1G9z0sWuTKXDD2K7tJktwsrznsWs/HSFtJ7n96pds965a
 6FSHlhTLzcC3w==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 37D6617E0EB0;
 Mon, 23 Nov 2026 15:59:00 +0100 (CET)
From: Laura Nao <laura.nao@collabora.com>
Date: Mon, 23 Nov 2026 15:58:46 +0100
Subject: [PATCH v7 2/3] drm/tyr: add TyrIrq threaded IRQ wrapper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-tyr-irq-v2-v7-2-4e172e58e28c@collabora.com>
References: <20260728-tyr-irq-v2-v7-0-4e172e58e28c@collabora.com>
In-Reply-To: <20260728-tyr-irq-v2-v7-0-4e172e58e28c@collabora.com>
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

Introduce a generic TyrIrq threaded IRQ wrapper along with the
TyrIrqTrait trait describing the operations required to handle a
Tyr interrupt source.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/gpu/drm/tyr/irq.rs           | 270 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/reset/hw_gate.rs |   1 -
 drivers/gpu/drm/tyr/tyr.rs           |   1 +
 3 files changed, 271 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/irq.rs b/drivers/gpu/drm/tyr/irq.rs
new file mode 100644
index 000000000000..4a065c6272c5
--- /dev/null
+++ b/drivers/gpu/drm/tyr/irq.rs
@@ -0,0 +1,270 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Threaded IRQ wrapper shared by all Tyr interrupt sources.
+#![allow(dead_code)]
+use core::marker::PhantomPinned;
+
+use kernel::{
+    device::Bound,
+    interrupt::LocalInterruptDisabled,
+    irq::{
+        Flags,
+        IrqReturn,
+        ThreadedHandler,
+        ThreadedIrqReturn,
+        ThreadedRegistration, //
+    },
+    platform,
+    prelude::*,
+    sync::{
+        atomic::{
+            ordering:: {
+                Full,
+                Release, //
+            },
+            Atomic,
+            AtomicType, //
+        },
+        Arc,
+        SpinLockIrq, //
+    }, //
+};
+
+use crate::{
+    driver::IoMem,
+    reset::HwGate, //
+};
+
+/// Trait describing the operations required to service a Tyr interrupt source.
+pub(crate) trait TyrIrqTrait: Sync {
+    /// Returns the masked interrupt status.
+    fn read_status(&self, io: &IoMem<'_>) -> u32;
+
+    /// Clears all bits in the mask register, disabling the interrupt sources.
+    fn clear_mask(&self, io: &IoMem<'_>);
+
+    /// Sets the mask register to re-enable the interrupt sources.
+    fn reenable_mask(&self, io: &IoMem<'_>);
+
+    /// Returns the raw interrupt status, regardless of the current mask.
+    fn read_raw_status(&self, io: &IoMem<'_>) -> u32;
+
+    /// Clears the given bits in the interrupt status register.
+    fn clear_status(&self, io: &IoMem<'_>, status: u32);
+
+    /// Returns the bitmask of interrupt sources handled by this instance.
+    fn mask(&self) -> u32;
+
+    /// Handles the given pending, unmasked interrupt bits.
+    fn handle(&self, status: u32);
+}
+
+/// State shared between a [`TyrIrq`] and its [`TyrIrqRegistration`], used to
+/// coordinate the primary handler, the threaded handler, and teardown.
+#[derive(Clone, Copy, PartialEq, Eq)]
+#[repr(i32)]
+enum IrqState {
+    /// Active and ready to process new events.
+    Active = 0,
+    /// A primary handler has claimed a pending event and the threaded handler is running, or
+    /// about to run, to service it.
+    Processing,
+    // Being deregistered: the mask has been, or is being, cleared, and no
+    // handler may re-enable it.
+    Unregistering,
+}
+
+// SAFETY: `IrqState` and `i32` has the same size and alignment, and it's round-trip
+// transmutable to `i32`.
+unsafe impl AtomicType for IrqState {
+    type Repr = i32;
+}
+
+/// A threaded IRQ wrapper shared by all Tyr interrupt sources.
+#[pin_data]
+pub(crate) struct TyrIrq<'a, T: TyrIrqTrait> {
+    /// The interrupt source.
+    irq: T,
+    /// Shared gate that coordinates hardware access with GPU reset.
+    hw: Arc<HwGate<'a>>,
+    /// Current state.
+    state: Atomic<IrqState>,
+    #[pin]
+    lock: SpinLockIrq<()>,
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+impl<'a, T: TyrIrqTrait> TyrIrq<'a, T> {
+    /// Requests a threaded IRQ registration for `irq`, using `name` to look up the interrupt.
+    /// Returns the shared [`IrqState`] alongside the registration.
+    ///
+    /// # Safety
+    ///
+    /// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
+    /// [`Drop`] implementation from running.
+    unsafe fn request(
+        pdev: &'a platform::Device<Bound>,
+        name: &'static CStr,
+        irq: T,
+        hw: Arc<HwGate<'a>>,
+    ) -> Result<impl PinInit<ThreadedRegistration<'a, Self>, Error> + 'a>
+    where
+        T: 'a,
+    {
+        let state = Atomic::new(IrqState::Active);
+
+        let handler = try_pin_init!(Self {
+            irq,
+            hw,
+            state,
+            lock <- kernel::new_spinlock_irq!(()),
+            _pin: PhantomPinned,
+        });
+
+        // SAFETY: The caller guarantees the resulting registration will not be leaked.
+        let registration =
+            unsafe { pdev.request_threaded_irq_by_name(Flags::SHARED, name, name, handler) };
+
+        // Clear the status and unmask once the handler has been
+        // successfully registered.
+        Ok(registration.pin_chain(|reg| {
+            let handler = reg.handler();
+            let hw_guard = handler.hw.access();
+            let io = hw_guard.iomem();
+            let irq = &handler.irq;
+            irq.clear_status(io, irq.mask());
+            irq.reenable_mask(io);
+            Ok(())
+        }))
+    }
+}
+
+impl<T: TyrIrqTrait> ThreadedHandler for TyrIrq<'_, T> {
+    fn handle(&self) -> ThreadedIrqReturn {
+        // SAFETY: `handle()` is the hard IRQ handler, so interrupts are already
+        // disabled.
+        let token = unsafe { LocalInterruptDisabled::assume_disabled() };
+        let _guard = self.lock.lock_with(token);
+
+        // Only proceed if still `Active`. If `Unregistering`, the IRQ is being
+        // torn down and must not be handled.
+        if self
+            .state
+            .cmpxchg(IrqState::Active, IrqState::Processing, Full)
+            .is_err()
+        {
+            return ThreadedIrqReturn::None;
+        }
+
+        let Some(hw_guard) = self.hw.try_access_atomic() else {
+            let _ = self
+                .state
+                .cmpxchg(IrqState::Processing, IrqState::Active, Full);
+            return ThreadedIrqReturn::None;
+        };
+        let io = hw_guard.iomem();
+
+        let masked_status = self.irq.read_status(io);
+
+        if masked_status == 0 {
+            // Go back to `Active`, unless the IRQ is being torn down.
+            let _ = self
+                .state
+                .cmpxchg(IrqState::Processing, IrqState::Active, Full);
+            return ThreadedIrqReturn::None;
+        }
+
+        self.irq.clear_mask(io);
+        ThreadedIrqReturn::WakeThread
+    }
+
+    fn handle_threaded(&self) -> IrqReturn {
+        let mut ret = IrqReturn::None;
+
+        loop {
+            let hw_guard = self.hw.access();
+            let io = hw_guard.iomem();
+            let raw_status = self.irq.read_raw_status(io) & self.irq.mask();
+            if raw_status == 0 {
+                break;
+            }
+            self.irq.clear_status(io, raw_status);
+            drop(hw_guard);
+            self.irq.handle(raw_status);
+            ret = IrqReturn::Handled;
+        }
+
+        // Only re-enable the mask if still `Processing`. If `Unregistering`, the
+        // IRQ is being torn down and must stay masked.
+        let hw_guard = self.hw.access();
+        let _guard = self.lock.lock();
+        if self
+            .state
+            .cmpxchg(IrqState::Processing, IrqState::Active, Full)
+            .is_ok()
+        {
+            self.irq.reenable_mask(hw_guard.iomem());
+        }
+
+        ret
+    }
+}
+
+// A [`ThreadedRegistration`] for a Tyr interrupt source and its state.
+
+// Unlike a bare [`ThreadedRegistration`], dropping this type is always
+// safe to do while the device remains on a shared IRQ line: its `Drop`
+// implementation masks the interrupt source, and notifies teardown via the
+// shared [`IrqState`], before the inner [`ThreadedRegistration`] is
+// dropped and deregisters the handler.
+#[pin_data(PinnedDrop)]
+pub(crate) struct TyrIrqRegistration<'a, T: TyrIrqTrait> {
+    #[pin]
+    registration: ThreadedRegistration<'a, TyrIrq<'a, T>>,
+}
+
+#[pinned_drop]
+impl<T: TyrIrqTrait> PinnedDrop for TyrIrqRegistration<'_, T> {
+    fn drop(self: Pin<&mut Self>) {
+        // Flag teardown and mask the interrupt source, before
+        // `self.registration`'s own `PinnedDrop` runs next and calls `free_irq()`.
+        // This prevents the hardware from asserting the interrupt again once it is
+        // deregistered. `free_irq()` itself waits for any handler already in
+        // flight to complete, and having already flagged `Unregistering`, such a
+        // handler will not re-enable the mask (see `TyrIrq::handle_threaded`).
+        let handler = self.registration.handler();
+        let hw_guard = handler.hw.access();
+        let _guard = handler.lock.lock();
+        handler.state.store(IrqState::Unregistering, Release);
+        handler.irq.clear_mask(hw_guard.iomem());
+    }
+}
+
+impl<'a, T: TyrIrqTrait> TyrIrqRegistration<'a, T> {
+    /// Requests a threaded IRQ registration for `irq`, using `name` to look up the interrupt.
+    ///
+    /// # Safety
+    ///
+    /// Callers must not `mem::forget()` the resulting registration or otherwise prevent its
+    /// [`Drop`] implementation from running.
+    pub(crate) unsafe fn request(
+        pdev: &'a platform::Device<Bound>,
+        name: &'static CStr,
+        irq: T,
+        hw: Arc<HwGate<'a>>,
+    ) -> Result<Pin<KBox<Self>>>
+    where
+        T: 'a,
+    {
+        // SAFETY: The caller guarantees the resulting registration will not be leaked.
+        let registration = unsafe { TyrIrq::request(pdev, name, irq, hw) }?;
+
+        KBox::try_pin_init(
+            try_pin_init!(Self {
+                registration <- registration,
+            }),
+            GFP_KERNEL,
+        )
+    }
+}
diff --git a/drivers/gpu/drm/tyr/reset/hw_gate.rs b/drivers/gpu/drm/tyr/reset/hw_gate.rs
index 40b38f07c472..2157b4b8ba78 100644
--- a/drivers/gpu/drm/tyr/reset/hw_gate.rs
+++ b/drivers/gpu/drm/tyr/reset/hw_gate.rs
@@ -76,7 +76,6 @@ pub(crate) fn access(&self) -> HwAccessGuard<'_, 'hw> {
     ///
     /// Returns `None` while the reset worker owns the hardware, in which case
     /// the caller must skip its hardware access.
-    #[expect(dead_code)]
     pub(crate) fn try_access_atomic(&self) -> Option<HwAccessGuard<'_, 'hw>> {
         let srcu = self.srcu.read_lock();
 
diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
index 9d995650be81..b112cc8a5573 100644
--- a/drivers/gpu/drm/tyr/tyr.rs
+++ b/drivers/gpu/drm/tyr/tyr.rs
@@ -12,6 +12,7 @@
 mod fw;
 mod gem;
 mod gpu;
+mod irq;
 mod mmu;
 mod regs;
 mod reset;

-- 
2.39.5

