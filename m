Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C810CD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85D9D112874;
	Sat, 30 May 2026 14:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k3TVWN3V";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E18112874
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:36:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4858600BB;
 Sat, 30 May 2026 14:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1761F00893;
 Sat, 30 May 2026 14:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780151797;
 bh=dNbTGAbme9kt3YqMUKN2FspzxRjZvUcj7K7J7y2iZ3U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=k3TVWN3Vqh1wLDUNxAj0ciKt0MCWTe82+l/lyquU2HNALCAGyRjrd2Xz6kK7zpwJV
 ySoA8kHlSDWUeJxlZGDcXicjcv6GuBeLeV9QkJiyDySp4xSl3rrQ5I8t/01AZcESwU
 tWBGeHGmS7URJ+u1p5877i19c+WZP+jTULHzT2KvFTH9cE264BgBxNT6AEVtApJ7rV
 tZdmicfQSQPD7FuBVjkF0sPW2PmjOFlFSCQCzmbZtWM8q1kWRoHJyAoHRbNQIeX6oA
 eIPgChh/13ZCbSIaad9svInJCGiTgwfoosmrkG2ZnToQjpbJOevEFlDnBbszSy2U+D
 4K0iTTcEsxptg==
From: Philipp Stanner <phasta@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Igor Korotin <igor.korotin@linux.dev>, Lorenzo Stoakes <ljs@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>,
 Shankari Anand <shankari.ak0208@gmail.com>, manos@pitsidianak.is,
 Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, rcu@vger.kernel.org
Subject: [PATCH 2/4] rust: rcu: add RcuBox type
Date: Sat, 30 May 2026 16:35:10 +0200
Message-ID: <20260530143541.229628-4-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260530143541.229628-2-phasta@kernel.org>
References: <20260530143541.229628-2-phasta@kernel.org>
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

From: Alice Ryhl <aliceryhl@google.com>

This adds an RcuBox container, which is like KBox except that the value
is freed with kfree_rcu.

To allow containers to rely on the rcu properties of RcuBox, an
extension of ForeignOwnable is added.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/sync/rcu.rs         |  31 ++++++-
 rust/kernel/sync/rcu/rcu_box.rs | 145 ++++++++++++++++++++++++++++++++
 3 files changed, 176 insertions(+), 1 deletion(-)
 create mode 100644 rust/kernel/sync/rcu/rcu_box.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 446dbeaf0866..2011645c7cfb 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -80,6 +80,7 @@
 #include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/random.h>
+#include <linux/rcupdate.h>
 #include <linux/refcount.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
diff --git a/rust/kernel/sync/rcu.rs b/rust/kernel/sync/rcu.rs
index a32bef6e490b..7234fe3e79ee 100644
--- a/rust/kernel/sync/rcu.rs
+++ b/rust/kernel/sync/rcu.rs
@@ -4,7 +4,16 @@
 //!
 //! C header: [`include/linux/rcupdate.h`](srctree/include/linux/rcupdate.h)
 
-use crate::{bindings, types::NotThreadSafe};
+use crate::{
+    bindings,
+    types::{
+        ForeignOwnable,
+        NotThreadSafe, //
+    }, //
+};
+
+mod rcu_box;
+pub use self::rcu_box::RcuBox;
 
 /// Evidence that the RCU read side lock is held on the current thread/CPU.
 ///
@@ -50,3 +59,23 @@ fn drop(&mut self) {
 pub fn read_lock() -> Guard {
     Guard::new()
 }
+
+/// Declares that a pointer type is rcu safe.
+pub trait ForeignOwnableRcu: ForeignOwnable {
+    /// Type used to immutably borrow an rcu-safe value that is currently foreign-owned.
+    type RcuBorrowed<'a>;
+
+    /// Borrows a foreign-owned object immutably for an rcu grace period.
+    ///
+    /// This method provides a way to access a foreign-owned rcu-safe value from Rust immutably.
+    ///
+    /// # Safety
+    ///
+    /// * The provided pointer must have been returned by a previous call to [`into_foreign`].
+    /// * If [`from_foreign`] is called, then `'a` must not end after the call to `from_foreign`
+    ///   plus one rcu grace period.
+    ///
+    /// [`into_foreign`]: ForeignOwnable::into_foreign
+    /// [`from_foreign`]: ForeignOwnable::from_foreign
+    unsafe fn rcu_borrow<'a>(ptr: *mut ffi::c_void) -> Self::RcuBorrowed<'a>;
+}
diff --git a/rust/kernel/sync/rcu/rcu_box.rs b/rust/kernel/sync/rcu/rcu_box.rs
new file mode 100644
index 000000000000..2508fdb609ec
--- /dev/null
+++ b/rust/kernel/sync/rcu/rcu_box.rs
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: GPL-2.0
+
+// Copyright (C) 2026 Google LLC.
+
+//! Provides the `RcuBox` type for Rust allocations that live for a grace period.
+
+use core::{ops::Deref, ptr::NonNull};
+
+use kernel::{
+    alloc::{self, AllocError},
+    bindings,
+    ffi::c_void,
+    prelude::*,
+    sync::rcu::{ForeignOwnableRcu, Guard},
+    types::ForeignOwnable,
+};
+
+/// A box that is freed with rcu.
+///
+/// The value must be `Send`, as rcu may drop it on another thread.
+///
+/// # Invariants
+///
+/// * The pointer is valid and references a pinned `RcuBoxInner<T>` allocated with `kmalloc`.
+/// * This `RcuBox` holds exclusive permissions to rcu free the allocation.
+pub struct RcuBox<T: Send>(NonNull<RcuBoxInner<T>>);
+
+struct RcuBoxInner<T> {
+    value: T,
+    rcu_head: bindings::callback_head,
+}
+
+// Note that `T: Sync` is required since when moving an `RcuBox<T>`, the previous owner may still
+// access `&T` for one grace period.
+//
+// SAFETY: Ownership of the `RcuBox<T>` allows for `&T` and dropping the `T`, so `T: Send + Sync`
+// implies `RcuBox<T>: Send`.
+unsafe impl<T: Send + Sync> Send for RcuBox<T> {}
+
+// SAFETY: `&RcuBox<T>` allows for no operations other than those permitted by `&T`, so `T: Sync`
+// implies `RcuBox<T>: Sync`.
+unsafe impl<T: Send + Sync> Sync for RcuBox<T> {}
+
+impl<T: Send> RcuBox<T> {
+    /// Create a new `RcuBox`.
+    pub fn new(x: T, flags: alloc::Flags) -> Result<Self, AllocError> {
+        let b = KBox::new(
+            RcuBoxInner {
+                value: x,
+                rcu_head: Default::default(),
+            },
+            flags,
+        )?;
+
+        // INVARIANT:
+        // * The pointer contains a valid `RcuBoxInner` allocated with `kmalloc`.
+        // * We just allocated it, so we own free permissions.
+        Ok(RcuBox(NonNull::from(KBox::leak(b))))
+    }
+
+    /// Access the value for a grace period.
+    pub fn with_rcu<'rcu>(&self, _read_guard: &'rcu Guard) -> &'rcu T {
+        // SAFETY: The `RcuBox` has not been dropped yet, so the value is valid for at least one
+        // grace period.
+        unsafe { &(*self.0.as_ptr()).value }
+    }
+}
+
+impl<T: Send> Deref for RcuBox<T> {
+    type Target = T;
+    fn deref(&self) -> &T {
+        // SAFETY: While the `RcuBox<T>` exists, the value remains valid.
+        unsafe { &(*self.0.as_ptr()).value }
+    }
+}
+
+// SAFETY:
+// * The `RcuBoxInner<T>` was allocated with `kmalloc`.
+// * `NonNull::as_ptr` returns a non-null pointer.
+unsafe impl<T: Send + 'static> ForeignOwnable for RcuBox<T> {
+    const FOREIGN_ALIGN: usize = <KBox<RcuBoxInner<T>> as ForeignOwnable>::FOREIGN_ALIGN;
+
+    type Borrowed<'a> = &'a T;
+    type BorrowedMut<'a> = &'a T;
+
+    fn into_foreign(self) -> *mut c_void {
+        self.0.as_ptr().cast()
+    }
+
+    unsafe fn from_foreign(ptr: *mut c_void) -> Self {
+        // INVARIANT: Pointer returned by `into_foreign` carries same invariants as `RcuBox<T>`.
+        // SAFETY: `into_foreign` never returns a null pointer.
+        Self(unsafe { NonNull::new_unchecked(ptr.cast()) })
+    }
+
+    unsafe fn borrow<'a>(ptr: *mut c_void) -> &'a T {
+        // SAFETY: Caller ensures that `'a` is short enough.
+        unsafe { &(*ptr.cast::<RcuBoxInner<T>>()).value }
+    }
+
+    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a T {
+        // SAFETY: `borrow_mut` has strictly stronger preconditions than `borrow`.
+        unsafe { Self::borrow(ptr) }
+    }
+}
+
+impl<T: Send + 'static> ForeignOwnableRcu for RcuBox<T> {
+    type RcuBorrowed<'a> = &'a T;
+
+    unsafe fn rcu_borrow<'a>(ptr: *mut c_void) -> &'a T {
+        // SAFETY: `RcuBox::drop` can only run after `from_foreign` is called, and the value is
+        // valid until `RcuBox::drop` plus one grace period.
+        unsafe { &(*ptr.cast::<RcuBoxInner<T>>()).value }
+    }
+}
+
+impl<T: Send> Drop for RcuBox<T> {
+    fn drop(&mut self) {
+        // SAFETY: The `rcu_head` field is in-bounds of a valid allocation.
+        let rcu_head = unsafe { &raw mut (*self.0.as_ptr()).rcu_head };
+        if core::mem::needs_drop::<T>() {
+            // SAFETY: `rcu_head` is the `rcu_head` field of `RcuBoxInner<T>`. All users will be
+            // gone in an rcu grace period. This is the destructor, so we may pass ownership of the
+            // allocation.
+            unsafe { bindings::call_rcu(rcu_head, Some(drop_rcu_box::<T>)) };
+        } else {
+            // SAFETY: All users will be gone in an rcu grace period.
+            unsafe { bindings::kvfree_call_rcu(rcu_head, self.0.as_ptr().cast()) };
+        }
+    }
+}
+
+/// Free this `RcuBoxInner<T>`.
+///
+/// # Safety
+///
+/// `head` references the `rcu_head` field of an `RcuBoxInner<T>` that has no references to it.
+/// Ownership of the `KBox<RcuBoxInner<T>>` must be passed.
+unsafe extern "C" fn drop_rcu_box<T>(head: *mut bindings::callback_head) {
+    // SAFETY: Caller provides a pointer to the `rcu_head` field of a `RcuBoxInner<T>`.
+    let box_inner = unsafe { crate::container_of!(head, RcuBoxInner<T>, rcu_head) };
+
+    // SAFETY: Caller ensures exclusive access and passed ownership.
+    drop(unsafe { KBox::from_raw(box_inner) });
+}
-- 
2.54.0

