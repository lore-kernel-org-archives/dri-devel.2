Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E5FCA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D95010E573;
	Wed, 30 Sep 2026 12:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZW7CboBu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04CA810E573
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:28:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B2C1B43BED;
 Wed, 30 Sep 2026 12:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4421F000FF;
 Wed, 30 Sep 2026 12:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790771301;
 bh=3homTzU0A5b5rw9eK11AZ6XdME+l9JWLnwxZWPVmGdc=;
 h=From:To:Cc:Subject:Date;
 b=ZW7CboBubk39tvnYuGIZ5tXL+A0YFTPJJ2igNcxtbe8dp9Kh5SjalN1XLxq+NljCt
 3P78bGnK4azx8QEdlT+glzg356U4xxF0CSLLQqo0+f5A/stM8VfMNwMSwKI36T2oZt
 7aXL1FWA8l0ZwioPGA2ugwMIYKFQOFqlPiFuv0KZVBZekXPlAa/h8EnAxL8CcljzkC
 zt8H/MDI7YHtHwBSCpjpxpfq72fBkDmhQTbsQyw3Yt5G20YFXfNw6DT8W/4exY2rET
 ya5edFpNyiAXfkUNNoaihAjxXu5FWqhznT7HFyx8iO5U80og+97E4rUt9Zd+1m8lxL
 DvMTQWREcqLag==
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
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rust: DmaFence: Remove static lifetime
Date: Wed, 30 Sep 2026 14:27:56 +0200
Message-ID: <20260930122755.1657820-2-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

A FenceCallbackRegistration can stem from another party than the one
that has created a Fence. Should that party forget the registration
object (for example through a refcount cycle) and then unload the
module, a fence signaling would run into the unloaded module, causing
UAF bugs.

So far, this has been solved by demanding that the payload data of the
registration object demanding static lifetime.

It turns out, however, that this is harmful because the static lifetime
bubbles up to all users, ultimately potentially causing a large amount
of driver data to be static, which renders the lifetime obsolete.

Solve this issue instead through an unsafe requirement which demands
that the user does not forget the registration object. This is also the
solution chosen by ScopedWork.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Onur Özkan <work@onurozkan.dev>
---
Changes in v2:
  - Safety Docu: Be more precise about what must not be forgotten.
    (Gary)
---
 rust/kernel/dma_buf/dma_fence.rs | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index 18a43e1bb442..a1d851656562 100644
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
@@ -326,7 +326,14 @@ impl<T: FenceCallback> FenceCallbackRegistration<T> {
     /// On success the callback is pinned in place and will fire when the fence
     /// signals. On `AlreadySignaled` the callback is returned to the caller so
     /// that owned resources can be reclaimed.
-    pub fn new<'a>(fence: &'a Fence, callback: T) -> impl PinInit<Self, CallbackError<T>> + 'a
+    ///
+    /// # Safety
+    ///
+    /// The callback registration must not be forgotten.
+    pub unsafe fn new<'a>(
+        fence: &'a Fence,
+        callback: T,
+    ) -> impl PinInit<Self, CallbackError<T>> + 'a
     where
         T: 'a,
     {
@@ -693,7 +700,8 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 ///
 /// let cb_data = CallbackData { };
 /// let waiting_fence = ARef::from(fence.as_fence());
-/// let cb_reg = FenceCallbackRegistration::new(&waiting_fence, cb_data);
+/// // SAFETY: `cb_data` is not forgotten.
+/// let cb_reg = unsafe { FenceCallbackRegistration::new(&waiting_fence, cb_data) };
 /// let cb_reg = KBox::pin_init(cb_reg, GFP_KERNEL)?;
 ///
 /// // TODO signalling guards

base-commit: 6bd5eaeb9827ca7ba953b68fb27948fdb3e40630
-- 
2.55.0

