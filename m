Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D109E606D81F
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TEhJDiXe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F140E112E01;
	Fri,  6 Nov 2026 14:09:58 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11EF112DF8
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:09:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 51A2660621;
 Fri,  6 Nov 2026 14:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3771F0089F;
 Fri,  6 Nov 2026 14:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793974192;
 bh=kRmDmXo03JPDBNJlf83DysKVeVmaLnergTlCLKoqxx0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TEhJDiXe65gHo0xjdgQeMbh4spwDrQ0RXdtzyYp5DEdhPlTIVvNb4E1tq/I2NkE8H
 rKSUGiPrJnrTLLp4s4eOYFHmMbl6ePOIkfNs5P9UMraea8N14XGkgYHUnEB4PPMSAj
 lcw5SFuTGrbU0MoA9MqsSraEeJYn75ea9+yDOiDJoIG2JS2IGLvIIu8IE1Oyi+i2Fp
 WGWksZjAaK/Zpg9Iu6oLvvPwFtlRurjnl81sq5K9ZibVRnzdxN1q9op6l6gRlmcffB
 XJoVA+twMZj789xV47GgBtnPeW7kgCUdgWsVHDjGiGhfXfNF8oyiqyGrM6yz/D+XWF
 NGzpRI6n9cpCQ==
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
 Matthew Brost <matthew.brost@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [PATCH 5/8] rust: DmaFence: Replace is_signaled() with status()
Date: Fri,  6 Nov 2026 15:07:50 +0100
Message-ID: <20261106140752.520386-7-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106140752.520386-2-phasta@kernel.org>
References: <20261106140752.520386-2-phasta@kernel.org>
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

As it turns out, our dma_fence abstractions lack an essential feature; a
problem which is partially inherited from the C backend:

Despite it being a common pattern in the kernel, you actually cannot
just check whether a fence was signaled and call it a day - it is
crucial that you also check whether a fence was signaled *with an
error*.

To make things more complicated, an error can get modified at any point
in time before a fence gets signaled. Thus, the only robust way of
obtaining the error code is by simultaneously checking the
signaled-state under lock-protection.

Since the fence status is essential information that must not be
ignored, replace Fence::is_signaled() with Fence::status(), making it
impossible to ignore the error code.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/helpers/dma_fence.c         |  4 +-
 rust/kernel/dma_buf/dma_fence.rs | 78 +++++++++++++++++++-------------
 rust/kernel/dma_buf/mod.rs       |  3 +-
 3 files changed, 51 insertions(+), 34 deletions(-)

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
index f74119b4d7f8..b0c0e32462ae 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -504,40 +504,49 @@ unsafe impl Send for Fence {}
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
+    /// # Safety
+    ///
+    /// The caller must only call this on fences that are already signaled.
+    unsafe fn __status(&self) -> Result {
+        // SAFETY: Safe by the function's safety requirements.
+        let res = unsafe { (*self.as_raw()).error };
 
-        // SAFETY: Inner `fence` is valid because `self` is valid.
-        let ret = unsafe { bindings::dma_fence_is_signaled(self.as_raw()) };
+        to_result(res)
+    }
 
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
+    /// Query a fence's status at the moment of the function call.
+    ///
+    /// If it is signaled, return the fence's result, i.e., determine if it was
+    /// signaled with an error.
+    pub fn status(&self) -> FenceStatus {
+        // The C backend provides `dma_fence_is_signaled()`. However, this is
+        // currently racy and could lead to misordering with our reading of the
+        // fence error code. Take the lock to prevent that.
+        let fence = self.lock();
+        // SAFETY: `fence` is valid because `self` is valid. The lock was
+        // taken above.
+        let signaled = unsafe { bindings::dma_fence_is_signaled_locked(fence.as_raw()) };
 
-        ret
+        if signaled {
+            // SAFETY: The fence is signaled.
+            let status = unsafe { fence.__status() };
+
+            return FenceStatus::Signaled(status);
+        }
+
+        FenceStatus::Unsignaled
     }
 
     /// Lock the fence. A helper only to be used internally in this module.
@@ -661,6 +670,7 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 ///         FenceContextOps,
 ///         FenceCallback,
 ///         FenceCallbackRegistration,
+///         FenceStatus, //
 ///     },
 ///     str::CString,
 ///     sync::aref::ARef, //
@@ -712,9 +722,15 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
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

