Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F6AAC44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:15:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3F2710E35A;
	Tue, 21 Jul 2026 15:15:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="NfpHWD+F";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C86D110E35A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784646934;
 bh=btItQEO2+VGINywKdLiJJbQna1oD70XRrKeHl9goPRc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NfpHWD+FlOEjJKHzwS7KUGObW6P4FLggJIApYuU0k5c51VUWvSC1sHXD3+pzdNaks
 VimB4z3BmE8MGx01iVVQRxgGYci6o9nwToWtoq6dOBaSyYb6rZd5LAepbyRjneUKmV
 GaqK48BE910nTNh2XPVtm8UvdRTv6kciMvz+cgwVoZDZxswNLRz4VKacCApGCIPtdq
 dxzV5ZvOuVlDhK78KO/BryVkWr1reXyz4ZDDujdeQN4rhmy7wnL4zWSTKlMb1dqaH6
 on9U7DJtNICoYWJrkuK9cc5jQW4BDPqKdIiaSJ+WyZOdMb3FasI2z5+Rnd+xSJwuKf
 h1fwe977UPE1w==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9F74317E062C;
 Tue, 21 Jul 2026 17:15:33 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: daniel.almeida@collabora.com, aliceryhl@google.com, dakr@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, ojeda@kernel.org
Cc: boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 acourbot@nvidia.com, work@onurozkan.dev, deborah.brouwer@collabora.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, kernel@collabora.com,
 Beata Michalska <beata.michalska@arm.com>
Subject: [PATCH 1/2] drm/tyr: add Wait type for GPU events
Date: Tue, 21 Jul 2026 17:14:22 +0200
Message-Id: <20260721151423.444175-2-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260721151423.444175-1-laura.nao@collabora.com>
References: <20260721151423.444175-1-laura.nao@collabora.com>
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

From: Deborah Brouwer <deborah.brouwer@collabora.com>

Add a Wait convenience type wrapping a CondVar and Mutex for sleeping
until a condition is met or a timeout expires.

The helper centralizes a common wait pattern: check the completion
predicate before sleeping, wait interruptibly with a timeout, retry on
spurious or unrelated wakeups, and perform a final predicate check before
returning ETIMEDOUT.

This will be used for CSF firmware responses and other GPU-driven events.

Also add a new_wait! macro so each Wait instance gets a call-site-specific
lockdep class key for its internal mutex.

Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Beata Michalska <beata.michalska@arm.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/tyr.rs  |   1 +
 drivers/gpu/drm/tyr/wait.rs | 126 ++++++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 drivers/gpu/drm/tyr/wait.rs

diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
index e7ec450bdc9c..3f6fe5fbeb0f 100644
--- a/drivers/gpu/drm/tyr/tyr.rs
+++ b/drivers/gpu/drm/tyr/tyr.rs
@@ -16,6 +16,7 @@
 mod regs;
 mod slot;
 mod vm;
+mod wait;
 
 kernel::module_platform_driver! {
     type: TyrPlatformDriver,
diff --git a/drivers/gpu/drm/tyr/wait.rs b/drivers/gpu/drm/tyr/wait.rs
new file mode 100644
index 000000000000..2a4d691c443c
--- /dev/null
+++ b/drivers/gpu/drm/tyr/wait.rs
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Code to wait on GPU events.
+#![allow(dead_code)]
+
+use kernel::{
+    new_condvar,
+    prelude::*,
+    sync::{
+        lock::{
+            mutex::MutexBackend,
+            Lock, //
+        },
+        Arc,
+        CondVar,
+        CondVarTimeoutResult,
+        Mutex, //
+    },
+    time::msecs_to_jiffies, //
+};
+
+/// Creates a new [`Wait`] instance with a call-site-specific lockdep class key.
+///
+/// Always prefer this macro over [`Wait::new_with_lock`] when the [`Wait`] instance has
+/// unique locking behaviour that could otherwise trigger false-positive lockdep
+/// warnings.
+#[macro_export]
+macro_rules! new_wait {
+    () => {{
+        let lock = new_mutex!(());
+        $crate::wait::Wait::new_with_lock(lock)
+    }};
+}
+
+/// A convenience type to wait for GPU events.
+///
+/// Wraps a [`CondVar`] and [`Mutex`] pair. The mutex synchronizes predicate checks
+/// with wait/wake operations; the condvar provides the sleep/wake mechanism.
+#[pin_data]
+pub(crate) struct Wait {
+    /// The actual wait/signal mechanism.
+    #[pin]
+    cond: CondVar,
+    /// Synchronizes waiters with notifications.
+    #[pin]
+    lock: Mutex<()>,
+}
+
+impl Wait {
+    /// Creates a new [`Wait`] with a caller-supplied lock instance.
+    ///
+    /// Use [`new_wait!`] instead of calling this directly; the macro ensures a
+    /// per-call-site lockdep class key is registered.
+    pub(crate) fn new_with_lock(lock: impl PinInit<Lock<(), MutexBackend>>) -> Result<Arc<Self>> {
+        Arc::pin_init(
+            pin_init!(Self {
+                cond <- new_condvar!(),
+                lock <- lock,
+            }),
+            GFP_KERNEL,
+        )
+    }
+
+    /// Waits until a GPU event condition is met or the timeout elapses.
+    ///
+    /// Calls `on_woken` before sleeping and after each wakeup. If `on_woken`
+    /// returns [`WaitResult::Retry`], the wait continues; [`WaitResult::Done`]
+    /// returns success.
+    ///
+    /// `on_woken` is called while the internal wait lock is held, so it must be
+    /// cheap and must not call back into code that can notify this wait object.
+    ///
+    /// Returns [`ETIMEDOUT`] if the deadline is reached without the condition
+    /// becoming true, or [`ERESTARTSYS`] if interrupted by a signal.
+    pub(crate) fn wait_interruptible_timeout<F>(&self, timeout_ms: u32, mut on_woken: F) -> Result
+    where
+        F: FnMut() -> Result<WaitResult>,
+    {
+        let mut guard = self.lock.lock();
+        let mut remaining_time = msecs_to_jiffies(timeout_ms);
+
+        loop {
+            // Check the condition before sleeping to avoid missing a wakeup
+            // that arrived between the caller's last check and acquiring the
+            // lock here.
+            if let WaitResult::Done = on_woken()? {
+                return Ok(());
+            }
+
+            match self
+                .cond
+                .wait_interruptible_timeout(&mut guard, remaining_time)
+            {
+                CondVarTimeoutResult::Woken { jiffies } => match on_woken()? {
+                    WaitResult::Done => return Ok(()),
+                    WaitResult::Retry => remaining_time = jiffies,
+                },
+                CondVarTimeoutResult::Timeout => {
+                    // One final check before giving up.
+                    if let WaitResult::Done = on_woken()? {
+                        return Ok(());
+                    }
+                    return Err(ETIMEDOUT);
+                }
+                CondVarTimeoutResult::Signal { .. } => return Err(ERESTARTSYS),
+            }
+        }
+    }
+
+    /// Wakes all waiters.
+    ///
+    /// Takes the internal lock so notifications are serialized against waiters
+    /// checking the condition and entering the sleep state.
+    pub(crate) fn notify_all(&self) {
+        let _guard = self.lock.lock();
+        self.cond.notify_all();
+    }
+}
+
+/// The result of a wait operation.
+pub(crate) enum WaitResult {
+    /// The condition was met.
+    Done,
+    /// The wakeup was spurious or for an unrelated event; retry.
+    Retry,
+}
-- 
2.39.5

