Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C95CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260F010EE33;
	Tue, 29 Sep 2026 10:50:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SX1F0SwF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A525610EE33
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:50:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6FCCE41610;
 Tue, 29 Sep 2026 10:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0907D1F00893;
 Tue, 29 Sep 2026 10:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790679005;
 bh=QiQ3oCtAQFVoZ8VpJPXCtOe7WLKhJFhUDIDS4+CUyCg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SX1F0SwFPJLo00M9irTamepuy5LaiSxXrDEYcxyysweVW7hIZswSrsrOmbE4q7kxc
 hQsId7ZxjQSLcm2CCFK3VBhe1Q2z8dmuy8qe/qh7BJQM336ih+UN0D12TlKz8yggoD
 xVTG/fYxxffWfiSYp1/lmgX2qIStV65WHqQox8cUOwlBvvo/oWLCTcercxw2T2wgbg
 tPaBzIGN+TKoRDy8z8grg+BIWyLfAIFWU6gfPEp2kZbXFv0M3OSjeRSh1RIN3cnCbC
 NGgGV1OS4UBaNTY4uyUfy3Ay1BaLLgGBJr3jMlmK7CUT02YCC1R2SQniiRx7o4HAQU
 f0uiK897Bo0qA==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Wilcox <willy@infradead.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Janne Grunau <j@jannau.net>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v4 1/3] rust: DmaFence: remove static lifetime
Date: Tue, 29 Sep 2026 12:47:01 +0200
Message-ID: <20260929104703.934128-3-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929104703.934128-2-phasta@kernel.org>
References: <20260929104703.934128-2-phasta@kernel.org>
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

(will be upstreamed separately)

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/dma_buf/dma_fence.rs | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index 18a43e1bb442..eef2b9e93f35 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -291,7 +291,7 @@ fn from(e: AllocError) -> Self {
 ///     }
 /// }
 /// ```
-pub trait FenceCallback: Send + 'static {
+pub trait FenceCallback: Send {
     /// Called when the fence is signaled.
     ///
     /// This is called from the fence signaling path, which may be in interrupt
@@ -310,7 +310,7 @@ pub trait FenceCallback: Send + 'static {
 /// When this object is dropped, the callback is automatically removed if it
 /// hasn't been called yet.
 #[pin_data(PinnedDrop)]
-pub struct FenceCallbackRegistration<T: FenceCallback + 'static> {
+pub struct FenceCallbackRegistration<T: FenceCallback> {
     #[pin]
     callback_foreign: Opaque<bindings::dma_fence_cb>,
     callback: ManuallyDrop<T>,
@@ -326,7 +326,7 @@ impl<T: FenceCallback> FenceCallbackRegistration<T> {
     /// On success the callback is pinned in place and will fire when the fence
     /// signals. On `AlreadySignaled` the callback is returned to the caller so
     /// that owned resources can be reclaimed.
-    pub fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit<Self, CallbackError<T>> + 'a
+    pub unsafe fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit<Self, CallbackError<T>> + 'a
     where
         T: 'a,
     {
@@ -693,7 +693,8 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 ///
 /// let cb_data = CallbackData { };
 /// let waiting_fence = ARef::from(fence.as_fence());
-/// let cb_reg = FenceCallbackRegistration::new(&waiting_fence, cb_data);
+/// // SAFETY: `cb_data`'s content is not forgotten.
+/// let cb_reg = unsafe { FenceCallbackRegistration::new(&waiting_fence, cb_data) };
 /// let cb_reg = KBox::pin_init(cb_reg, GFP_KERNEL)?;
 ///
 /// // TODO signalling guards
-- 
2.55.0

