Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67222606D832
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TES53Sh1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74A8B10F69C;
	Tue,  3 Nov 2026 15:33:06 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED36910F673
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:32:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71387608FA;
 Tue,  3 Nov 2026 15:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220AC1F00A20;
 Tue,  3 Nov 2026 15:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793719979;
 bh=3W8j7zFtflYWYTjA+AqTWaagN78KlnzlFNYuNhHXXvY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TES53Sh1KEJsQz2rq9gCS3RUyUnhbhs3ABj19YBU5f5/x5X5fzO61cWF9Or723LYT
 OEqgMlrLDj4WhIE4qKE+qBhun/h+cx2kyFB80wo+lsgGK/govY1hdytfcgLimogg+O
 tlSme8qftEw+FJTz2JT7HJKp4canHMNRVNF1VvYVscj8WzIHS0XdDiSMKl020fSGdg
 zLhhVEumI9IIB2oJO/UTw26O5kDQLM9hYp5oRUVkd9wzLBijTX/ZgEKNeiZ1Sby/g2
 km7Jlv1fL/o0AxuCXkTuIFGDAN8o7tZBVh4Nc/AKvf2v+cxVqSYkSaZhNtvHE1Kvsv
 ag88NJrjBk64g==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v7 5/8] rust: DmaFence: Replace is_signaled() with status()
Date: Tue,  3 Nov 2026 16:31:35 +0100
Message-ID: <20261103153138.1087330-7-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103153138.1087330-2-phasta@kernel.org>
References: <20261103153138.1087330-2-phasta@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As it turns out, our dma_fence abstractions lack an essential feature
that is partially derived from the C backend:

Despite it being a common pattern in the kernel, you actually cannot
just check whether a fence was signaled and call it a day - it is
crucial that you also check whether a fence was signaled *with an
error*.

Making things more complicated, an error can get modified at any point
in time before a fence gets signaled. Thus, the only solid way of
obtaining the error code is by simultaneously checking the
signaled-status under lock-protection.

Since the fence status is essential information, replace
Fence::is_signaled() with Fence::status(), making it impossible to
ignore the error code.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/helpers/dma_fence.c         |  4 +-
 rust/kernel/dma_buf/dma_fence.rs | 70 +++++++++++++++++++-------------
 rust/kernel/dma_buf/mod.rs       |  3 +-
 3 files changed, 45 insertions(+), 32 deletions(-)

diff --git a/rust/helpers/dma_fence.c b/rust/helpers/dma_fence.c
index 549f6b6a7171..9d8eb7db19bf 100644
--- a/rust/helpers/dma_fence.c
+++ b/rust/helpers/dma_fence.c
@@ -22,9 +22,9 @@ __rust_helper void rust_helper_dma_fence_end_signalling(bool cookie)
 	dma_fence_end_signalling(cookie);
 }
 
-__rust_helper bool rust_helper_dma_fence_is_signaled(struct dma_fence *f)
+__rust_helper bool rust_helper_dma_fence_is_signaled_locked(struct dma_fence *f)
 {
-	return dma_fence_is_signaled(f);
+	return dma_fence_is_signaled_locked(f);
 }
 
 __rust_helper bool rust_helper_dma_fence_test_signaled_flag(struct dma_fence *f)
diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index d26cf9e8e4b1..71965b26e148 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -502,40 +502,48 @@ unsafe impl Send for Fence {}
 // SAFETY: Fences are literally designed to be shared between threads.
 unsafe impl Sync for Fence {}
 
+/// Fence-Status queried through [`Fence::status()`].
+#[derive(Debug)]
+pub enum FenceStatus {
+    /// The fence is not yet signaled.
+    Unsignaled,
+    /// The fence is signaled. Might have been signaled with an error.
+    Signaled(Result),
+}
+
 impl Fence {
+    /// Require a fence's status while holding the lock.
+    ///
+    /// # Safety
+    ///
+    /// The dma_fence lock must be held when calling this function.
+    unsafe fn status_locked(&self) -> FenceStatus {
+        // SAFETY: Inner `fence` is valid because `self` is valid.
+        let signaled = unsafe { bindings::dma_fence_is_signaled_locked(self.as_raw()) };
+
+        if signaled {
+            // SAFETY: `self` is valid and we acquired the lock above.
+            let err = unsafe { (*self.as_raw()).error };
+
+            return FenceStatus::Signaled(to_result(err));
+        }
+
+        return FenceStatus::Unsignaled;
+    }
+
     /// Check whether the fence was signaled at the moment of the function call.
+    /// If it is signaled, return the fence's status, i.e., determine if it was
+    /// signaled with an error.
     ///
     /// Note that this can return `true` for a [`Fence`] whose [`DriverFence`]
     /// has not yet been dropped. The reason is that the fence ops callbacks can
     /// cause the fence to get signaled by the C backend.
     #[inline]
-    pub fn is_signaled(&self) -> bool {
-        // We should not use `dma_fence_is_signaled_locked()` here, because
-        // according to the C backend's recommendations, that function is
-        // problematic and we should avoid calling that function with a lock
-        // held.
+    pub fn status(&self) -> FenceStatus {
+        let fence = self.lock();
 
-        // SAFETY: Inner `fence` is valid because `self` is valid.
-        let ret = unsafe { bindings::dma_fence_is_signaled(self.as_raw()) };
-
-        // To be as robust as possible for the future we guarantee that an API
-        // caller can 100% rely on the signaling being completed (i.e., all
-        // fence callbacks ran), so we have to take the lock.
-        //
-        // The reason is that the C dma_fence backend currently does not
-        // carefully synchronize the `dma_fence_is_signaled()` function with the
-        // proper spinlock. This can lead to the function returning `true` while
-        // fence callbacks are still being executed. This can be mitigated by
-        // guarding the entire function with the spinlock.
-        //
-        // The fundamental reason is that the C backend currently does guard
-        // setting of the fence's signaled-bit with the fence's spinlock, but
-        // reading is done locklessly.
-        //
-        // See commit c8a5d5ea3ba6a.
-        let _ = self.lock();
-
-        ret
+        // SAFETY: We required the lock directly above.
+        unsafe { fence.status_locked() }
     }
 
     /// Lock the fence. A helper only to be used internally in this module.
@@ -657,11 +665,15 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 ///         FenceContextOps,
 ///         FenceCallback,
 ///         FenceCallbackRegistration,
+///         FenceStatus, //
 ///     },
 ///     str::CString,
 ///     sync::aref::ARef, //
 /// };
-/// use core::fmt::Display;
+/// use core::{
+///     assert_matches,
+///     fmt::Display, //
+/// };
 ///
 /// struct CallbackData { }
 ///
@@ -708,9 +720,9 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 /// let cb_reg = KBox::pin_init(cb_reg, GFP_KERNEL)?;
 ///
 /// // TODO signalling guards
-/// assert_eq!(waiting_fence.is_signaled(), false);
+/// assert_matches!(waiting_fence.status(), FenceStatus::Unsignaled);
 /// fence.signal(Ok(()));
-/// assert_eq!(waiting_fence.is_signaled(), true);
+/// assert_matches!(waiting_fence.status(), FenceStatus::Signaled(Ok(())));
 ///
 /// Ok::<(), Error>(())
 /// ```
diff --git a/rust/kernel/dma_buf/mod.rs b/rust/kernel/dma_buf/mod.rs
index 4764a828642e..b5254144f69e 100644
--- a/rust/kernel/dma_buf/mod.rs
+++ b/rust/kernel/dma_buf/mod.rs
@@ -10,5 +10,6 @@
     FenceCallback,
     FenceCallbackRegistration,
     FenceContext,
-    FenceContextOps, //
+    FenceContextOps,
+    FenceStatus, //
 };
-- 
2.56.0

