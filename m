Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AEE109C038
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:56:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5195A10E9FD;
	Thu, 26 Mar 2026 06:56:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="vw9/JpcC";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10ECA10E9F9
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:55:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 08DD944594;
 Thu, 26 Mar 2026 06:55:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CAEE3C2BCB4;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1774508152; bh=NNUdlRHkQrwIntdVy79+2nMOBtE/OfNVECY/qXD3kB8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=vw9/JpcC+/1MISiuYRXNPPa0S3Bx5SrWjO98STI9+A0NNpcdM/8wcYkJNUGRVzomC
 UKK0P/c5LSwKHnjMghME4fcmx+VTnO82Ub060KEypk3UCnGt6kRtWZfSkaKnUxLkeF
 At4LnJh9Q8/+CYX8L9l1dNMtx+8FQ2YadRhXNzJY=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BE681109E55D;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 26 Mar 2026 14:52:58 +0800
Subject: [PATCH 05/13] rust: revocable: add HazPtrRevocable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-b4-tyr-debugfs-v1-5-074badd18716@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774508149; l=5072;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=NNUdlRHkQrwIntdVy79+2nMOBtE/OfNVECY/qXD3kB8=;
 b=iz2SPnbLjf4RKaKdCrXMuTOKQNiv60ZRgnJmzYt9rouV7S9kB9AaoMLTZuAKNJsEYt441RFjp
 HSVbCUqmca2C5fsps7OaM5eH12wN4Evc2YLNfDIRRfCRl+Z9c80rcVD
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

Add hazard-pointer-based revocable type and related handle/guard.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/revocable.rs | 127 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 124 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index 70733ff5961cd..eabb76ce92c43 100644
--- a/rust/kernel/revocable.rs
+++ b/rust/kernel/revocable.rs
@@ -10,14 +10,25 @@
 use crate::{
     bindings,
     prelude::*,
-    sync::{rcu, SetOnce},
+    sync::{
+        hazptr,
+        hazptr::HazptrCtx,
+        rcu,
+        SetOnce, //
+    },
     types::Opaque,
 };
 use core::{
     marker::PhantomData,
     ops::Deref,
-    ptr::drop_in_place,
-    sync::atomic::{AtomicBool, Ordering},
+    ptr::{
+        addr_of,
+        drop_in_place, //
+    },
+    sync::atomic::{
+        AtomicBool,
+        Ordering, //
+    },
 };
 
 /// An object that can become inaccessible at runtime.
@@ -292,6 +303,116 @@ fn drop(&mut self) {
     }
 }
 
+/// Revocable protected by hazard pointer instead of RCU.
+#[pin_data(PinnedDrop)]
+pub struct HazPtrRevocable<T> {
+    #[pin]
+    data: Opaque<T>,
+    is_available: AtomicBool,
+}
+
+// SAFETY: HazPtrRevocable<T> only moves ownership of T across threads;
+// revocation/drop follow the hazptr protocol, so T: Send suffices.
+unsafe impl<T: Send> Send for HazPtrRevocable<T> {}
+
+// SAFETY: &HazPtrRevocable<T> may be shared across threads and yields
+// &T via hazptr guards; with T: Send + Sync such shared access is sound.
+unsafe impl<T: Sync + Send> Sync for HazPtrRevocable<T> {}
+
+impl<T> HazPtrRevocable<T> {
+    /// Creates a new hazard-pointer revocable instance.
+    pub fn new<E>(data_pin_init: impl PinInit<T, E>) -> impl PinInit<Self, E> {
+        try_pin_init!(Self {
+            data <- Opaque::pin_init(data_pin_init),
+            is_available: AtomicBool::new(true),
+        }? E)
+    }
+
+    /// Tries to access the wrapped object. Returns `None` if revoked.
+    ///
+    /// `ctx` is moved into the returned guard and released when the guard is dropped.
+    pub fn try_access<'a>(
+        &self,
+        ctx: Pin<&'a mut HazptrCtx>,
+    ) -> Option<HazPtrRevocableGuard<'a, T>> {
+        let data_ptr = self.data.get();
+        let guard = hazptr::acquire(ctx, addr_of!(data_ptr).cast())?;
+        if !self.is_available.load(Ordering::Relaxed) {
+            return None;
+        }
+        Some(HazPtrRevocableGuard::new(guard))
+    }
+
+    /// Revokes access and drops the wrapped object. Waits for readers via hazptr.
+    pub fn revoke(&self) -> bool {
+        let revoke = self.is_available.swap(false, Ordering::Relaxed);
+        if revoke {
+            hazptr::synchronize(self.data.get() as usize);
+            // SAFETY: `synchronize()` ensures no reader still holds the pointer,
+            // and `self.is_available` is false so no new reader can start, so
+            // `drop_in_place` is safe.
+            unsafe { drop_in_place(self.data.get()) };
+        }
+        revoke
+    }
+}
+
+#[pinned_drop]
+impl<T> PinnedDrop for HazPtrRevocable<T> {
+    fn drop(self: Pin<&mut Self>) {
+        // Drop only if the data hasn't been revoked yet (in which case it has already been
+        // dropped).
+        // SAFETY: We are not moving out of `p`, only dropping in place
+        let p = unsafe { self.get_unchecked_mut() };
+        if *p.is_available.get_mut() {
+            // SAFETY: We know `self.data` is valid because no other CPU has changed
+            // `is_available` to `false` yet, and no other CPU can do it anymore because this CPU
+            // holds the only reference (mutable) to `self` now.
+            unsafe { drop_in_place(p.data.get()) };
+        }
+    }
+}
+
+/// A handle to perform revocation on a [`HazPtrRevocable`]. Revokes when dropped.
+pub struct HazPtrRevokeHandle<'a, T>(&'a HazPtrRevocable<T>);
+
+impl<'a, T> HazPtrRevokeHandle<'a, T> {
+    /// Create a revoke-on-drop handle.
+    pub fn new(revocable: &'a HazPtrRevocable<T>) -> Self {
+        Self(revocable)
+    }
+
+    /// Dismiss the handle without revoking.
+    pub fn dismiss(self) {
+        core::mem::forget(self);
+    }
+}
+
+impl<T> Drop for HazPtrRevokeHandle<'_, T> {
+    fn drop(&mut self) {
+        self.0.revoke();
+    }
+}
+
+/// Guard for a [`HazPtrRevocable`].
+pub struct HazPtrRevocableGuard<'a, T> {
+    guard: hazptr::Guard<'a, T>,
+}
+
+impl<'a, T> HazPtrRevocableGuard<'a, T> {
+    fn new(guard: hazptr::Guard<'a, T>) -> Self {
+        Self { guard }
+    }
+}
+
+impl<T> Deref for HazPtrRevocableGuard<'_, T> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.guard
+    }
+}
+
 /// An object that is initialized and can become inaccessible at runtime.
 ///
 /// [`Revocable`] is initialized at the beginning, and can be made inaccessible at runtime.

-- 
2.43.0


