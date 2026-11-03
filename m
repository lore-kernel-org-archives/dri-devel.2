Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EFF606A33C
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rgon7FVn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B13C310F69F;
	Tue,  3 Nov 2026 15:33:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D1D10F69A
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 15:33:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9305A42B35;
 Tue,  3 Nov 2026 15:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1A41F00A23;
 Tue,  3 Nov 2026 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793719984;
 bh=vVa2LUvdBpdByYvpnwtRSMfp/8FgFZVL6sNFqsj3PfI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Rgon7FVnYEIWjzhIW9EmBLM1fvkOQj3UBG/z8F5dL4E6WMLKerC1MqVKXHYscU3X0
 uNEwBPiiBGfKMUGiaXrSOhwZ21UgT1Wmqg3Z4sH1/QgkJm5RtxuU56Cx7jE7E2ELym
 Iq11ODcYtJBoGvuoBoDbR6Q1sr2WqyjJC96IHeyAz92Nj3wKD1mCFKQyGzE+Qp5bz2
 8eY2RYZV5GmI7Btwr/YzWiHKujYMOzyZ/s8bQxEVgpLVjHDkMscCit3Dx4J+uknPgf
 QxgrYuGQ7uS8rMxBmM/AouLmAxX4DYwSjfDRIQuihn5rxcxYK5uSU0oiTZNFVr4NHg
 eUKCsuvb3ZcAA==
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
Subject: [RFC PATCH v7 6/8] rust: DmaFence: Tell results in signaling callbacks
Date: Tue,  3 Nov 2026 16:31:36 +0100
Message-ID: <20261103153138.1087330-8-phasta@kernel.org>
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

A FenceCallbackRegistration invokes the on_signal() trait functions
specified by the user.

These callbacks always get executed, even if the fence was signaled with
an error. The user must then be able to react accordingly.

Since the fence->error must only be set before a fence signals, and must
not change after it signaled, we better acquire it with the lock.

Change the on_signal() trait function so that the user always gets
passed the fence's actual state.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/dma_buf/dma_fence.rs | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index 71965b26e148..c8856dbed0a2 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -291,9 +291,12 @@ fn from(e: AllocError) -> Self {
 /// }
 ///
 /// impl FenceCallback for MyCallback {
-///     fn on_signal(&mut self) {
-///         pr_info!("Fence signaled!\n");
-///         // Handle fence completion
+///     fn on_signal(&mut self, status: Result) {
+///         if status.is_ok() {
+///             pr_info!("Fence signaled!\n");
+///         } else {
+///             pr_err!("Fence signaled with an error!\n");
+///         }
 ///     }
 /// }
 /// ```
@@ -308,7 +311,7 @@ pub trait FenceCallback: Send {
     /// An implementation likely wants to inform itself (e.g., through a work item)
     /// within this callback that the associated [`FenceCallbackRegistration`]
     /// can now be dropped.
-    fn on_signal(&mut self);
+    fn on_signal(&mut self, status: Result);
 }
 
 /// A callback registration on a fence.
@@ -395,11 +398,18 @@ pub unsafe fn new<'a>(
         // embedded into a `FenceCallbackRegistration`.
         let reg: *mut Self = unsafe { container_of!(ptr, Self, callback_foreign) };
 
+        // SAFETY: The lock is being held by the C backend.
+        let fence_result = match unsafe { (*reg).fence.status_locked() } {
+            FenceStatus::Signaled(result) => result,
+            // Can never happen.
+            FenceStatus::Unsignaled => Err(ENOENT),
+        };
+
         // SAFETY: `reg` is a valid `Self` pointer.
         //
         // The backend ensures synchronisation so whoever holds the registration object cannot drop
         // it while this code is running. See `FenceCallbackRegistration::drop`.
-        unsafe { (*reg).callback.on_signal() };
+        unsafe { (*reg).callback.on_signal(fence_result) };
     }
 
     /// Returns a reference to the fence this callback is registered on.
@@ -678,8 +688,12 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 /// struct CallbackData { }
 ///
 /// impl FenceCallback for CallbackData {
-///     fn on_signal(&mut self) {
-///         pr_info!("DmaFence callback executed.\n");
+///     fn on_signal(&mut self, status: Result) {
+///         if status.is_ok() {
+///             pr_info!("DmaFence callback executed.\n");
+///         else {
+///             pr_err!("DmaFence callback executed, but fence has an error.\n");
+///         }
 ///     }
 /// }
 ///
-- 
2.56.0

