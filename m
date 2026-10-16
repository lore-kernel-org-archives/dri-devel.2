Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92934CCA464
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 08:57:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA7F61126AD;
	Fri, 16 Oct 2026 08:57:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8738B1126AD
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 08:57:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D80643D13;
 Fri, 16 Oct 2026 08:57:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A561F000C4;
 Fri, 16 Oct 2026 08:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792141066;
 bh=QiQ3oCtAQFVoZ8VpJPXCtOe7WLKhJFhUDIDS4+CUyCg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iD7oTkPSnm48xOKqbip2K8Gkm0T0XBIBZZV3DHObvr8og443ILprUuZA2RzwDGY5Y
 X0sANrwFB4oTn1m522ctuKofxTGED3ry5iMTWN4/YYpCvLW51v6Aw9qNeoPkdUf2Bn
 8/RxVDp+gjmpWdjpNB5oPiovMveC0w84+kTer349E1QQAzwahQYoaqzxDTIHL11knH
 kjhgb5Snk0zJ0KWf4WggDqTDewZzBV/mhHjr8cPeRTQfjW9tIU+CEP7FkxAVhTkjNy
 AhzwBitBlDre1z3wCJCvaeRrxmLMOorasyuntNQFI+qpcJdtoz2zUdtAFgFa0NLrjx
 /fNDcg4nfaXBA==
From: Philipp Stanner <phasta@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
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
 Boris Brezillon <boris.brezillon@collabora.com>, John.harrison@igalia.com,
 da.gomez@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: [RFC PATCH v6 1/5] rust: DmaFence: remove static lifetime
Date: Fri, 16 Oct 2026 10:57:20 +0200
Message-ID: <20261016085724.1031766-3-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016085724.1031766-2-phasta@kernel.org>
References: <20261016085724.1031766-2-phasta@kernel.org>
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

