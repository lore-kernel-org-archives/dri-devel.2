Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC43DC9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 08:20:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C9C10E5C3;
	Fri, 25 Sep 2026 08:20:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DMoEKtCl";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02CDC10E5C3
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 08:20:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 91FC943B44;
 Fri, 25 Sep 2026 08:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D581F000FF;
 Fri, 25 Sep 2026 08:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790324415;
 bh=m6nEJDV+7FIzPWlZBY2PWO8zBLW9phOFmTFY7TGKFas=;
 h=From:To:Cc:Subject:Date;
 b=DMoEKtClqfUrXAf8gxB1uXH+FavBAWA7/ecwcgWk2K0X0dqlRUUlYZVjDaTM72uqA
 qnKQaIOtpEvgF+YVzXRKzV0eCERdJb4bxSWXXM6WYUH1pufvwiUlAD2yBrdrOGWduE
 VtxKkXEitLMWE/Y002AFSdJH8i/Q3yPhYsQb04Pbi3PdwGJASwQ5O6hlu2oZaLqJGC
 RCpQYe/Ecll/ZvcPZ9Tdg2g4xCCKHhb+9RpJ0SxPFJ2+ue9zxTYrjzqq+tNoCMfZ9u
 LtyqYysVhHANqJqwVjeXkGmTl2a5gl8/BK7rfKQ9OrB4IDadGKxwvAW0Yc8CLrtnLa
 hTYca8bstVkIw==
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
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rust: DmaFence: Add better warning through Device reference
Date: Fri, 25 Sep 2026 10:19:59 +0200
Message-ID: <20260925081958.3048112-2-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
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

FenceContext::drop() contains a warning print that warns about possible
memory corruptions if there are forgotten fences. However, precisely
speaking, a forgotten fence is undefined behavior.

Moreover, forgotten fences hint at a severe design problem in the
driver. In this context, the used pr_err!() does not provide very useful
text output.

Replace the warning print with a dev_warn!(). To do so, have the
FenceContext carry a reference to a Device, protected by the already
present lifetime.

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/dma_buf/dma_fence.rs | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index 18a43e1bb442..58ba678e91b5 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -32,6 +32,10 @@
 };
 
 use kernel::{
+    device::{
+        Device,
+        Normal, //
+    },
     str::CString,
     sync::{
         aref::{
@@ -59,7 +63,7 @@ pub trait FenceContextOps {
 /// with each other, providing each with raising sequence numbers and a common
 /// identifier.
 #[pin_data(PinnedDrop)]
-pub struct FenceContext<T: FenceContextOps + Send + Sync> {
+pub struct FenceContext<'a, T: FenceContextOps + Send + Sync> {
     /// The fence context number.
     nr: u64,
     /// The sequence number for the next fence created.
@@ -81,12 +85,14 @@ pub struct FenceContext<T: FenceContextOps + Send + Sync> {
     // the lifetime which intends to enforce that all fences disappear before
     // their context.
     nr_of_unsignaled_fences: Atomic<usize>,
+    /// The device this fence context is associated with.
+    dev: &'a Device<Normal>,
     /// The user's data.
     #[pin]
     data: T,
 }
 
-impl<'a, T: Send + Sync + FenceContextOps> FenceContext<T> {
+impl<'a, T: Send + Sync + FenceContextOps + 'a> FenceContext<'a, T> {
     // This can later be extended as a vtable in case other parties need support
     // for the more "exotic" callbacks.
     const OPS: bindings::dma_fence_ops = bindings::dma_fence_ops {
@@ -106,6 +112,7 @@ pub fn new<E>(
         initial_seqno: u64,
         driver_name: &CStr,
         timeline_name: &CStr,
+        dev: &'a Device<Normal>,
         data: impl PinInit<T, E>,
     ) -> impl PinInit<Self, Error>
     where
@@ -122,6 +129,7 @@ pub fn new<E>(
             driver_name: driver_name?,
             timeline_name: timeline_name?,
             nr_of_unsignaled_fences: Atomic::new(0),
+            dev,
             data <- data,
         })
     }
@@ -211,7 +219,7 @@ unsafe fn from_raw_fence(ptr: *mut bindings::dma_fence) -> &'a Self {
 }
 
 #[pinned_drop]
-impl<T: FenceContextOps + Send + Sync> PinnedDrop for FenceContext<T> {
+impl<T: FenceContextOps + Send + Sync> PinnedDrop for FenceContext<'_, T> {
     fn drop(self: Pin<&mut Self>) {
         // Fence ops callbacks can be called on unsignaled fences. Since these
         // callbacks can access the fence context and its data, it needs to be
@@ -596,7 +604,7 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
     /// Callback head for dropping this in a deferred manner through RCU.
     rcu_head: bindings::callback_head,
     /// Reference to access the FenceContext.
-    fctx: &'a FenceContext<T>,
+    fctx: &'a FenceContext<'a, T>,
     /// The API user's data. It is essential that the data only performs
     /// operations legal in atomic context in its [`Drop`] implementation.
     #[pin]
@@ -641,6 +649,7 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 ///
 /// ```
 /// use kernel::{
+///     device::Normal,
 ///     dma_buf::{
 ///         DriverFence,
 ///         FenceContext,
@@ -648,6 +657,7 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 ///         FenceCallback,
 ///         FenceCallbackRegistration,
 ///     },
+///     faux,
 ///     str::CString,
 ///     sync::aref::ARef, //
 /// };
@@ -676,9 +686,10 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 ///
 /// let fctx_data = FenceContextData::new();
 ///
+/// let reg = faux::Registration::new(c"DmaFence-KUnit-Test", None)?;
 ///
 /// let mut fctx = KBox::pin_init(
-///     FenceContext::new(0, c"dummy_driver", c"dummy_timeline", fctx_data),
+///     FenceContext::new(0, c"dummy_driver", c"dummy_timeline", reg.as_ref().as_ref(), fctx_data),
 ///     GFP_KERNEL
 /// )?;
 ///
@@ -934,7 +945,9 @@ fn drop(&mut self) {
         // SAFETY: `guard` is valid until the `call_rcu()` below.
         let signaled: bool = unsafe { bindings::dma_fence_test_signaled_flag(guard.as_raw()) };
         if !signaled {
-            pr_err!("DriverFence drops unsignaled. Danger of memory corruption!\n");
+            // SAFETY: `data` is valid because `self` is valid.
+            let dev = unsafe { self.data.as_ref().fctx.dev };
+            dev_warn!(dev, "DriverFence drops unsignaled.\n");
             // SAFETY: `guard` is valid until the `call_rcu()` below. The fence
             // must not have been signaled yet, which we check directly above.
             unsafe { bindings::dma_fence_set_error(guard.as_raw(), ECANCELED.to_errno()) };

base-commit: 896ed083362758b33c49a1b5e5a3423c5814d87e
-- 
2.55.0

