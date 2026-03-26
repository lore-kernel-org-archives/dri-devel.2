Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02BFB109E55D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F6EF10E9F5;
	Thu, 26 Mar 2026 06:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="HzcOaDlW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6AC10E9E9
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:55:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B5B314448F;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B904C2BC87;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1774508152; bh=nS0GufUfvXxDa4kFrf9OO8gI4KuETIxkK6IuHNVkZhs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=HzcOaDlW9Otc1cya9wt98CuMl6bR1Sv5Yb3MBd8TAcUYEh4HQhi7H1ksBZR8Mt+mo
 iC9Ldlktqua9IYbxCBvySV1sUgFjxRQ5OJUDLoPl+TvZ/BhJP3H3abj4ZrvqzPgFg9
 1fBBNVdCVlDxwh9d/PCiHb/zX2s0v0k0igMaxlUg=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 77FA2109E55D;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 26 Mar 2026 14:52:54 +0800
Subject: [PATCH 01/13] rust: sync: support [pin_]init for `SetOnce`
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-b4-tyr-debugfs-v1-1-074badd18716@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774508149; l=6987;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=VFdTtaWWr68iX6gfsDxBRXDRn2N0TRXehh4KrqY/38I=;
 b=/o3V32QCp2CR+Jn1WHwoRnaw9uA8+jsE/N7LshGopcDzQyJ3X678/PGrdMj46O5bSESw36mXh
 Z7aRjKaSUQeDFPm6E0kn4KPejXPYLVCn94+I9zLaJOAP6fOehrzwrKG
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

From: Gary Guo <gary@garyguo.net>

Make `SetOnce` support initialization via `impl Init` or `impl PinInit`.

This adds a possible failing path if an initializer fails. In such case,
the state is dropped back to 0 instead of keep increasing; so the monotonicity
invariant is dropped. The order for initialization is upgraded from Relaxed
to Acquire so it can observe the effect of a previously failed initialization.

Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/sync/set_once.rs | 120 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 99 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/sync/set_once.rs b/rust/kernel/sync/set_once.rs
index 139cef05e935f..db9c5423fade3 100644
--- a/rust/kernel/sync/set_once.rs
+++ b/rust/kernel/sync/set_once.rs
@@ -2,11 +2,23 @@
 
 //! A container that can be initialized at most once.
 
+use core::{
+    cell::UnsafeCell,
+    mem::MaybeUninit, //
+};
+use pin_init::{
+    Init,
+    PinInit, //
+};
+
 use super::atomic::{
-    ordering::{Acquire, Relaxed, Release},
-    Atomic,
+    ordering::{
+        Acquire,
+        Release, //
+    },
+    Atomic, //
 };
-use core::{cell::UnsafeCell, mem::MaybeUninit};
+use crate::prelude::*;
 
 /// A container that can be populated at most once. Thread safe.
 ///
@@ -15,13 +27,13 @@
 ///
 /// # Invariants
 ///
-/// - `init` may only increase in value.
 /// - `init` may only assume values in the range `0..=2`.
 /// - `init == 0` if and only if `value` is uninitialized.
 /// - `init == 1` if and only if there is exactly one thread with exclusive
 ///   access to `self.value`.
 /// - `init == 2` if and only if `value` is initialized and valid for shared
 ///   access.
+/// - once `init == 2`, it must remain so.
 ///
 /// # Example
 ///
@@ -51,6 +63,35 @@ fn default() -> Self {
     }
 }
 
+/// Error that can occur during initialization of `SetOnce`.
+#[derive(Debug)]
+pub enum InitError<E> {
+    /// The `Once` has already been initialized.
+    AlreadyInit,
+    /// The `Once` is being raced to initialize by another thread.
+    RacedInit,
+    /// Error occurs during initialization.
+    DuringInit(E),
+}
+
+impl<E> From<E> for InitError<E> {
+    #[inline]
+    fn from(err: E) -> Self {
+        InitError::DuringInit(err)
+    }
+}
+
+impl<E: Into<Error>> From<InitError<E>> for Error {
+    #[inline]
+    fn from(this: InitError<E>) -> Self {
+        match this {
+            InitError::AlreadyInit => EEXIST,
+            InitError::RacedInit => EBUSY,
+            InitError::DuringInit(e) => e.into(),
+        }
+    }
+}
+
 impl<T> SetOnce<T> {
     /// Create a new [`SetOnce`].
     ///
@@ -76,31 +117,68 @@ pub fn as_ref(&self) -> Option<&T> {
         }
     }
 
-    /// Populate the [`SetOnce`].
+    /// Populate the [`SetOnce`] with an initializer.
     ///
-    /// Returns `true` if the [`SetOnce`] was successfully populated.
-    pub fn populate(&self, value: T) -> bool {
+    /// Returns the initialized reference if the [`SetOnce`] was successfully populated.
+    pub fn init<E>(&self, init: impl Init<T, E>) -> Result<&T, InitError<E>> {
         // INVARIANT: If the swap succeeds:
-        //  - We increase `init`.
         //  - We write the valid value `1` to `init`.
+        //  - The previous value is not `2`, so it is valid to move to `1`.
         //  - Only one thread can succeed in this write, so we have exclusive access after the
         //    write.
-        if let Ok(0) = self.init.cmpxchg(0, 1, Relaxed) {
-            // SAFETY: By the type invariants of `Self`, the fact that we succeeded in writing `1`
-            // to `self.init` means we obtained exclusive access to `self.value`.
-            unsafe { core::ptr::write(self.value.get().cast(), value) };
-            // INVARIANT:
-            //  - We increase `init`.
-            //  - We write the valid value `2` to `init`.
-            //  - We release our exclusive access to `self.value` and it is now valid for shared
-            //    access.
-            self.init.store(2, Release);
-            true
-        } else {
-            false
+        match self.init.cmpxchg(0, 1, Acquire) {
+            Ok(_) => {
+                // SAFETY:
+                // - By the type invariants of `Self`, the fact that we succeeded in writing `1`
+                //   to `self.init` means we obtained exclusive access to `self.value`.
+                // - When `Err` is returned, we did not set `self.init` to `2` so the `Drop` is not
+                //   armed.
+                match unsafe { init.__init(self.value.get().cast()) } {
+                    Ok(()) => {
+                        // INVARIANT:
+                        //  - The previous value is `1`, so it is valid to move to `2`.
+                        //  - We write the valid value `2` to `init`.
+                        //  - We release our exclusive access to `self.value` and it is now valid
+                        //    for shared access.
+                        self.init.store(2, Release);
+                        // SAFETY: we have just initialized the value.
+                        Ok(unsafe { &*self.value.get().cast() })
+                    }
+                    Err(err) => {
+                        // INVARIANT:
+                        //  - The previous value is `1`, so it is valid to move to `0`.
+                        //  - We write the valid value `0` to `init`.
+                        //  - We release our exclusive access to `self.value` and it is now valid
+                        //    for shared access.
+                        self.init.store(0, Release);
+                        Err(err.into())
+                    }
+                }
+            }
+            Err(1) => Err(InitError::RacedInit),
+            Err(_) => Err(InitError::AlreadyInit),
         }
     }
 
+    /// Populate the [`SetOnce`] with a pinned initializer.
+    ///
+    /// Returns the initialized reference if the [`SetOnce`] was successfully populated.
+    pub fn pin_init<E>(self: Pin<&Self>, init: impl PinInit<T, E>) -> Result<&T, InitError<E>> {
+        // SAFETY:
+        // - `__pinned_init` satisfy all requirements of `init_from_closure`
+        // - calling `__pinned_init` require additional that the slot is pinned, which is satisfied
+        //   given `self: Pin<&Self>`.
+        self.get_ref()
+            .init(unsafe { pin_init::init_from_closure(|slot| init.__pinned_init(slot)) })
+    }
+
+    /// Populate the [`SetOnce`].
+    ///
+    /// Returns `true` if the [`SetOnce`] was successfully populated.
+    pub fn populate(&self, value: T) -> bool {
+        self.init(value).is_ok()
+    }
+
     /// Get a copy of the contained object.
     ///
     /// Returns [`None`] if the [`SetOnce`] is empty.

-- 
2.43.0


