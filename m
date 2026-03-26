Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 160F5109E55C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50B2210E9E9;
	Thu, 26 Mar 2026 06:56:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="PogGYfhg";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1077A10E9F7
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 06:55:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id CC61B44564;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 953B3C2BCB3;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1774508152; bh=FCONyIAtz9r1krwef4xl9DMaJxiE39hUdR/53kVkXkY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PogGYfhgKO88kimc2vTiiBjMEp8BJjrLCLJuQe7A596L6vO3PNXFTMyG6IQLZnneg
 1qefTVGYftb+Mb5Shz8IppN7iWWpOoUiivPbuIozVR10kCqubgFWPeBqud46unK5a0
 KsvN3S6zNWftpwnitiCsclV06olo/CErPZZlwxQk=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB43109E55C;
 Thu, 26 Mar 2026 06:55:52 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 26 Mar 2026 14:52:55 +0800
Subject: [PATCH 02/13] rust: revocable: add lazily instantiated revocable
 variant
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-b4-tyr-debugfs-v1-2-074badd18716@linux.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774508149; l=3394;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=JCy0YveUUx2PxZVI94KUIjqKl/C8px/HZ+jhmQr0Dks=;
 b=/3wc7yexWjygUwGQE3Uq9UvBOv7UVYqCidZ6dkDG/T4jCh7C7NSN54PIOyTvEvIBhdHsuoEmV
 EFCaKay4NliAGoNOCHPfG28dtvIK8pEfICjBJcJdoJp2L9VwdKAzotv
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

Add a `LazyRevocable` type, an variant to `Revocable` where
the data is initialized lazily. This type can be constructed as const and
put into statics.

Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/revocable.rs | 80 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
index 0f4ae673256d5..70733ff5961cd 100644
--- a/rust/kernel/revocable.rs
+++ b/rust/kernel/revocable.rs
@@ -7,7 +7,12 @@
 
 use pin_init::Wrapper;
 
-use crate::{bindings, prelude::*, sync::rcu, types::Opaque};
+use crate::{
+    bindings,
+    prelude::*,
+    sync::{rcu, SetOnce},
+    types::Opaque,
+};
 use core::{
     marker::PhantomData,
     ops::Deref,
@@ -261,3 +266,76 @@ fn deref(&self) -> &Self::Target {
         unsafe { &*self.data_ref }
     }
 }
+
+/// A handle to perform revocation on a [`Revocable`].
+///
+/// The associated `Revocable` is revoked when the handle is dropped.
+pub struct RevokeHandle<'a, T>(&'a Revocable<T>);
+
+impl<'a, T> RevokeHandle<'a, T> {
+    /// Create a revoke-on-drop handle on an existing revocable.
+    pub fn new(revocable: &'a Revocable<T>) -> Self {
+        Self(revocable)
+    }
+
+    /// Dismiss the handle.
+    ///
+    /// This method consumes ownership without revoking the `Revocable`.
+    pub fn dismiss(self) {
+        core::mem::forget(self);
+    }
+}
+
+impl<'a, T> Drop for RevokeHandle<'a, T> {
+    fn drop(&mut self) {
+        self.0.revoke();
+    }
+}
+
+/// An object that is initialized and can become inaccessible at runtime.
+///
+/// [`Revocable`] is initialized at the beginning, and can be made inaccessible at runtime.
+/// `LazyRevocable` is uninitialized at the beginning, and can be initialized later; it can be
+/// revoked in a similar manner to [`Revocable`]. Once revoked, it cannot be initialized again.
+#[pin_data]
+pub struct LazyRevocable<T> {
+    #[pin]
+    once: SetOnce<Revocable<T>>,
+}
+
+impl<T> LazyRevocable<T> {
+    /// Creates a new lazy revocable instance.
+    ///
+    /// The instance starts uninitialized, where all accesses would fail.
+    pub const fn new() -> Self {
+        LazyRevocable {
+            once: SetOnce::new(),
+        }
+    }
+
+    /// Initialize a `LazyRevocable` and obtain a handle to revoke the content if successful.
+    ///
+    /// An error would be returned if the revocable has already been initialized.
+    pub fn init<E: Into<Error>>(
+        self: Pin<&Self>,
+        init: impl PinInit<T, E>,
+    ) -> Result<RevokeHandle<'_, T>> {
+        // SAFETY: `once` is structurally pinned.
+        let once = unsafe { self.map_unchecked(|x| &x.once) };
+        let revocable = once.pin_init(Revocable::new(init))?;
+        Ok(RevokeHandle::new(revocable))
+    }
+
+    /// Tries to access the revocable wrapped object.
+    ///
+    /// Returns `None` if the object has not been initialized, or it has been revoked and is therefore no longer accessible.
+    pub fn try_access(&self) -> Option<RevocableGuard<'_, T>> {
+        self.once.as_ref()?.try_access()
+    }
+}
+
+impl<T> Default for LazyRevocable<T> {
+    fn default() -> Self {
+        Self::new()
+    }
+}

-- 
2.43.0


