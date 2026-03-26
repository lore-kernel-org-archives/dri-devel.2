Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E6FB109E55D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16A0310EA00;
	Thu, 26 Mar 2026 06:56:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="SOHJaEs8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10D9310E9F8
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:55:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 24A8C60131;
 Thu, 26 Mar 2026 06:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA39DC2BCB9;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1774508152; bh=8sG5/4DML5NSTRd6XZj5n+aYKAsS4hPMAZ9HC9w0jjQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SOHJaEs8rv1wcIQRcx+QCq+MndcBSE3rTA345fV0kk2zRD6ZJWcW9V/kqN6jgfIYo
 W/hNi4QOZ5PuIFeWdy1dWfP+6hi7h5Ya7NXf3k0++/2q9aC6VSY3XzbRdWWMit0FTa
 gW5vgN127fpE0ZePLyouqgMbdIDPSZG8mFeKMlTk=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AC8A7109E55A;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 26 Mar 2026 14:52:57 +0800
Subject: [PATCH 04/13] rust: sync: add hazard pointer abstraction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-b4-tyr-debugfs-v1-4-074badd18716@linux.dev>
References: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
In-Reply-To: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774508149; l=4702;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=8sG5/4DML5NSTRd6XZj5n+aYKAsS4hPMAZ9HC9w0jjQ=;
 b=YR1ZJg1z532+Tja18moGSpkoIqzBWqKo/jm8I9c5IQ8WeGEFJV19rZ/ujdzVlcL89QwvcGk7v
 iA2oaLtRZ66CqEofG7egooB/8hhzclgPbpC4s1jWBgvy626lXhpOXOz
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
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

Add C helpers and Rust wrappers for the kernel hazard pointer API,
to be used by revocable and other code.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/hazptr.c           | 13 ++++++
 rust/helpers/helpers.c          |  1 +
 rust/kernel/sync.rs             |  1 +
 rust/kernel/sync/hazptr.rs      | 91 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 107 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 9058b09a016ec..8ace50a3dc104 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -60,6 +60,7 @@
 #include <linux/file.h>
 #include <linux/firmware.h>
 #include <linux/fs.h>
+#include <linux/hazptr.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io-pgtable.h>
diff --git a/rust/helpers/hazptr.c b/rust/helpers/hazptr.c
new file mode 100644
index 0000000000000..aa53fbcd0da1d
--- /dev/null
+++ b/rust/helpers/hazptr.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/hazptr.h>
+
+__rust_helper void *rust_helper_hazptr_acquire(struct hazptr_ctx *ctx, void *const *addr_p)
+{
+	return hazptr_acquire(ctx, addr_p);
+}
+
+__rust_helper void rust_helper_hazptr_release(struct hazptr_ctx *ctx, void *addr)
+{
+	hazptr_release(ctx, addr);
+}
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index f1ac40b0bd1a4..ed8cb74d394a3 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -34,6 +34,7 @@
 #include "err.c"
 #include "irq.c"
 #include "fs.c"
+#include "hazptr.c"
 #include "io.c"
 #include "jump_label.c"
 #include "kunit.c"
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 993dbf2caa0e3..45da761eaee05 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -15,6 +15,7 @@
 pub mod barrier;
 pub mod completion;
 mod condvar;
+pub mod hazptr;
 pub mod lock;
 mod locked_by;
 pub mod poll;
diff --git a/rust/kernel/sync/hazptr.rs b/rust/kernel/sync/hazptr.rs
new file mode 100644
index 0000000000000..f94ae45dd3d66
--- /dev/null
+++ b/rust/kernel/sync/hazptr.rs
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Hazard pointer support.
+//!
+//! C header: [`include/linux/hazptr.h`](srctree/include/linux/hazptr.h)
+
+use crate::{
+    bindings,
+    ffi::c_void,
+    prelude::*,
+    types::Opaque, //
+};
+use core::{
+    ops::Deref,
+    ptr::NonNull, //
+};
+
+/// Per-thread context for one hazard-pointer acquire/release pair.
+#[repr(transparent)]
+pub struct HazptrCtx(Opaque<bindings::hazptr_ctx>);
+
+impl HazptrCtx {
+    /// Creates a new zero-initialized context for one acquire/release pair.
+    #[inline]
+    pub const fn new() -> Self {
+        Self(Opaque::zeroed())
+    }
+
+    /// Get the raw pointer.
+    #[inline]
+    pub fn as_raw(self: &Pin<&mut Self>) -> *mut bindings::hazptr_ctx {
+        self.0.get()
+    }
+}
+
+impl Default for HazptrCtx {
+    fn default() -> Self {
+        Self::new()
+    }
+}
+
+/// Guard holding a hazard-pointer-protected reference.
+pub struct Guard<'a, T> {
+    ctx: Pin<&'a mut HazptrCtx>,
+    ptr: NonNull<T>,
+}
+
+impl<'a, T> Guard<'a, T> {
+    #[inline]
+    fn new(ctx: Pin<&'a mut HazptrCtx>, ptr: NonNull<T>) -> Self {
+        Self { ctx, ptr }
+    }
+}
+
+impl<T> Deref for Guard<'_, T> {
+    type Target = T;
+
+    #[inline]
+    fn deref(&self) -> &T {
+        // SAFETY: hazptr protocol keeps the pointer valid until release.
+        unsafe { self.ptr.as_ref() }
+    }
+}
+
+impl<T> Drop for Guard<'_, T> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: `self.ctx` and `self.ptr` are the same as the ones used in `acquire`.
+        unsafe { bindings::hazptr_release(self.ctx.as_raw().cast(), self.ptr.as_ptr().cast()) };
+    }
+}
+
+/// Acquires a hazard pointer for the pointer at `addr_p` and returns a guard.
+///
+/// Returns `None` if the loaded value is null.
+#[inline]
+pub fn acquire<'a, T>(
+    ctx: Pin<&'a mut HazptrCtx>,
+    addr_p: *const *const T,
+) -> Option<Guard<'a, T>> {
+    // SAFETY: ctx is valid and pinned, addr_p is a valid pointer to a pointer.
+    let ptr = unsafe { bindings::hazptr_acquire(ctx.as_raw().cast(), addr_p.cast()) };
+    NonNull::new(ptr.cast()).map(|p| Guard::new(ctx, p))
+}
+
+/// Waits until no slot holds `addr`.
+#[inline]
+pub fn synchronize(addr: usize) {
+    // SAFETY: addr is only compared with slot values, not dereferenced.
+    unsafe { bindings::hazptr_synchronize(addr as *mut c_void) };
+}

-- 
2.43.0


