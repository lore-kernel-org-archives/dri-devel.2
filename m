Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47855606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WaA0L6KM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A713710F54E;
	Tue, 24 Nov 2026 12:31:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2497610F54E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:31:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0A7D742E62;
 Tue, 24 Nov 2026 12:31:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593AD1F000D2;
 Tue, 24 Nov 2026 12:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795523468;
 bh=pyrTI7EpSILhA8ws61oGNffakGmoXMH/KsPExYxBdNY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WaA0L6KMGU2tmPM6N0t45gg9+qEyx2cZ0YUxdn6dmFMAWRmNF1HZU+76uDr3Lz81T
 GFMjD0LCPJh/LyI2zdS6oB2BsbIp5A6qlBT2DPkMoTRPFVVd+RjJ2tLi4fR3C9stDJ
 aWj4Q2nIefwg9BQjeYt/H+ZndK9zwFkhu+/hUXlCAPjaWvhRqDF2OsCJHA2nhqRVDM
 TQWGNutCO/6IH9chFb5/TuDnCbAgyVWRzitPN8eQ1DwpWroUkwF7XzCpBjIujLM8fS
 0+Mw+TPxNyhEbeqgXn4mNpPC78eCmWgVw+49x3i5rfPMauCeoUYbxab1usqUy1cqrB
 qBzVzGT96LsiQ==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH v2 07/10] rust: DmaFence: Replace is_signaled() with status()
Date: Tue, 24 Nov 2026 13:29:49 +0100
Message-ID: <20261124122951.878199-9-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124122951.878199-2-phasta@kernel.org>
References: <20261124122951.878199-2-phasta@kernel.org>
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

As it turns out, our dma_fence abstractions lack an essential feature; a
problem which is partially inherited from the C backend:

Despite it being a common pattern in the kernel, you actually should not
just check whether a fence was signaled and call it a day - it is
important that you also check whether a fence was signaled *with an
error*.

To make things more complicated, an error can get modified at any point
in time before a fence gets signaled. Thus, it must be ensured that the
signaled state is always evaluated before the error code.

Since the fence status is essential information that must not be
ignored, replace Fence::is_signaled() with Fence::status(), making it
impossible to ignore the error code.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/dma_buf/dma_fence.rs | 77 ++++++++++++++++++--------------
 rust/kernel/dma_buf/mod.rs       |  3 +-
 2 files changed, 46 insertions(+), 34 deletions(-)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index 20dadbde4eb9..09bebf9c1e4e 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -510,40 +510,44 @@ unsafe impl Send for Fence {}
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
-    /// Check whether the fence was signaled at the moment of the function call.
+    /// Query a fence's error code and turn it into a [`Result`].
     ///
-    /// Note that this can return `true` for a [`Fence`] whose [`DriverFence`]
-    /// has not yet been dropped. The reason is that the fence ops callbacks can
-    /// cause the fence to get signaled by the C backend.
-    #[inline]
-    pub fn is_signaled(&self) -> bool {
-        // We should not use `dma_fence_is_signaled_locked()` here, because
-        // according to the C backend's recommendations, that function is
-        // problematic and we should avoid calling that function with a lock
-        // held.
-
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
+    /// # Safety
+    ///
+    /// The caller must only call this on fences that are already signaled. It
+    /// must be ensured that this is ordered properly against checking of the
+    /// signaled status (fence->signaled bit).
+    unsafe fn __status(&self) -> Result {
+        // SAFETY: Safe by the function's safety requirements.
+        let res = unsafe { (*self.as_raw()).error };
+
+        to_result(res)
+    }
+
+    /// Query a fence's status at the moment of the function call.
+    ///
+    /// If it is signaled, return the fence's result, i.e., determine if it was
+    /// signaled with an error.
+    pub fn status(&self) -> FenceStatus {
+        // SAFETY: `self` is valid.
+        if unsafe { bindings::dma_fence_is_signaled(self.as_raw()) } {
+            // SAFETY: The fence is signaled. The C backend ensures ordering.
+            let status = unsafe { self.__status() };
+
+            return FenceStatus::Signaled(status);
+        }
 
-        ret
+        FenceStatus::Unsignaled
     }
 
     /// Lock the fence. A helper only to be used internally in this module.
@@ -672,6 +676,7 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 ///         FenceContextOps,
 ///         FenceCallback,
 ///         FenceCallbackRegistration,
+///         FenceStatus, //
 ///     },
 ///     str::CString,
 ///     sync::aref::ARef, //
@@ -723,9 +728,15 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 /// let cb_reg = KBox::pin_init(cb_reg, GFP_KERNEL)?;
 ///
 /// // TODO signalling guards
-/// assert_eq!(waiting_fence.is_signaled(), false);
+///
+/// // TODO: add support for `assert_matches!()`.
+/// if let FenceStatus::Signaled(_) = waiting_fence.status() {
+///      return Err(ENOMSG);
+/// }
 /// fence.signal(Ok(()));
-/// assert_eq!(waiting_fence.is_signaled(), true);
+/// if let FenceStatus::Unsignaled = waiting_fence.status() {
+///     return Err(ENOENT);
+/// }
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

