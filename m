Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66825C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 15:33:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AA9A10E1D5;
	Fri,  4 Sep 2026 15:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q9XCxnK+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE09910E1D5
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 15:33:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD6F3600C8;
 Fri,  4 Sep 2026 15:33:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0281F00A3D;
 Fri,  4 Sep 2026 15:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788535982;
 bh=mHQYPGPdzlGxXMNKZnACiaB//jM8t7QwCLZn+xl/ipU=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=Q9XCxnK+Ao/JAb6ul5UFx2KsHLa7LxDBLiAEV5Xqa7+lWsX6U0sRbJ0GHgfuuTKx2
 dnp+mOpB+kmvTDgq2cO5JoBAhVahscyDSVLD+to1VsZkJbCdJ501AGJjyQzsAiMXjf
 1tn9pX5LGpqDjhn9SwTOooDx6nAA4sXg2CmZqaG5b1AM5kMNDSdEDzFFpzbucpSK5h
 dMHKcRChOCGvBaT/nNIYUu0/8hmbrxuGnacDL53b53cYzB7K1GtYfH6gRx1mOkZ6WY
 axoNRnNipTdv/hhdsXHrOoaTQ4oqXegu+ikptbRpK3dyvBMBYRifKzQWFJHChon0sm
 VkrdAlajKogCw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 17:32:55 +0200
Message-Id: <DL6N387CE2AT.1LU4TDUB8QBIU@kernel.org>
Subject: Re: [PATCH v10 1/2] rust: Add dma_fence abstractions
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Yury Norov (NVIDIA)"
 <yury.norov@gmail.com>, "Asahi Lina" <lina+kernel@asahilina.net>, "Burak
 Emir" <burak.emir@gmail.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "FUJITA Tomonori"
 <fujita.tomonori@gmail.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linaro-mm-sig@lists.linaro.org>
To: "Philipp Stanner" <phasta@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260812072217.1971807-2-phasta@kernel.org>
 <20260812072217.1971807-3-phasta@kernel.org>
In-Reply-To: <20260812072217.1971807-3-phasta@kernel.org>
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

On Wed Aug 12, 2026 at 9:22 AM CEST, Philipp Stanner wrote:
> Add abstractions for dma_fence in Rust.

I was about to pick this up, but ended up with too many things to tweak.

  * Fix checkpatch.pl warnings,
  * take &CStr instead of CString in FenceContext::new(),
  * change DriverFenceAllocation::ops to &'static from *const,
  * remove # Safety comment on AlwaysRefCounted::dec_ref() impl,
  * use Opaque::zeroed() instead of __GFP_ZERO,
  * use kernel vertical import style.

Here's the diff I suggest for a v11:

diff --git a/rust/helpers/dma_fence.c b/rust/helpers/dma_fence.c
index 0e08411098fa..549f6b6a7171 100644
--- a/rust/helpers/dma_fence.c
+++ b/rust/helpers/dma_fence.c
@@ -37,7 +37,8 @@ __rust_helper void rust_helper_dma_fence_lock_irqsave(str=
uct dma_fence *f, unsig
 	dma_fence_lock_irqsave(f, *flags);
 }

-__rust_helper void rust_helper_dma_fence_unlock_irqrestore(struct dma_fenc=
e *f, unsigned long *flags)
+__rust_helper void rust_helper_dma_fence_unlock_irqrestore(struct dma_fenc=
e *f,
+							   unsigned long *flags)
 {
 	dma_fence_unlock_irqrestore(f, *flags);
 }
diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fen=
ce.rs
index f22f4a07c152..d82b69f68e61 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -102,21 +102,23 @@ impl<'a, T: Send + Sync + FenceContextOps> FenceConte=
xt<T> {
     /// Create a new `FenceContext`.
     pub fn new<E>(
         initial_seqno: u64,
-        driver_name: CString,
-        timeline_name: CString,
+        driver_name: &CStr,
+        timeline_name: &CStr,
         data: impl PinInit<T, E>,
     ) -> impl PinInit<Self, Error>
     where
         Error: From<E>,
     {
+        let driver_name =3D CString::try_from(driver_name);
+        let timeline_name =3D CString::try_from(timeline_name);
         try_pin_init!(Self {
             // SAFETY: `dma_fence_context_alloc()` merely works on a globa=
l
             // atomic. Parameter `1` is the number of contexts we want to
             // allocate.
             nr: unsafe { bindings::dma_fence_context_alloc(1) },
             seqno: Atomic::new(initial_seqno),
-            driver_name,
-            timeline_name,
+            driver_name: driver_name?,
+            timeline_name: timeline_name?,
             nr_of_unsignaled_fences: Atomic::new(0),
             data <- data,
         })
@@ -141,7 +143,7 @@ pub fn new_fence_allocation(
             rcu_head: Default::default(),
             // `inner` remains uninitialized until a `DriverFence` takes o=
ver.
             inner: Fence {
-                inner: Opaque::uninit(),
+                inner: Opaque::zeroed(),
             },
             fctx: self,
             data,
@@ -154,7 +156,7 @@ pub fn new_fence_allocation(
         //
         // Hence, we need the manage the memory manually. It will be freed=
 by the
         // C backend automatically once the refcount within `Fence` drops =
to 0.
-        let data =3D KBox::new(fence_data, GFP_KERNEL | __GFP_ZERO)?;
+        let data =3D KBox::new(fence_data, GFP_KERNEL)?;

         Ok(DriverFenceAllocation {
             data,
@@ -212,7 +214,7 @@ fn drop(self: Pin<&mut Self>) {
         // Fence ops callbacks can be called on unsignaled fences. Since t=
hese
         // callbacks can access the fence context and its data, it needs t=
o be
         // guaranteed that a context only drops after all associated
-        // `DriverFence`s have been dropped. This is unlikely to ocurr, bu=
t would
+        // `DriverFence`s have been dropped. This is unlikely to occur, bu=
t would
         // result in silent UAF. Throw a panic to prevent that.
         //
         // TODO:
@@ -568,9 +570,6 @@ fn inc_ref(&self) {
         unsafe { bindings::dma_fence_get(self.as_raw()) }
     }

-    /// # Safety
-    ///
-    /// `ptr`must be a valid pointer to a [`DriverFence`].
     unsafe fn dec_ref(ptr: NonNull<Self>) {
         // SAFETY: `ptr` is never a NULL pointer; and when `dec_ref()` is =
called
         // the fence is by definition still valid.
@@ -640,15 +639,17 @@ struct DriverFenceData<'a, T: Send + Sync + FenceCont=
extOps> {
 /// # Examples
 ///
 /// ```
-/// use kernel::dma_buf::{
-///     DriverFence,
-///     FenceContext,
-///     FenceContextOps,
-///     FenceCallback,
-///     FenceCallbackRegistration, //
+/// use kernel::{
+///     dma_buf::{
+///         DriverFence,
+///         FenceContext,
+///         FenceContextOps,
+///         FenceCallback,
+///         FenceCallbackRegistration,
+///     },
+///     str::CString,
+///     sync::aref::ARef,
 /// };
-/// use kernel::str::CString;
-/// use kernel::sync::aref::ARef;
 /// use core::fmt::Display;
 ///
 /// struct CallbackData { }
@@ -674,18 +675,16 @@ struct DriverFenceData<'a, T: Send + Sync + FenceCont=
extOps> {
 ///
 /// let fctx_data =3D FenceContextData::new();
 ///
-/// let driver_name =3D CString::try_from_fmt(fmt!("dummy_driver"))?;
-/// let timeline_name =3D CString::try_from_fmt(fmt!("dummy_timeline"))?;
-///
 /// let mut fctx =3D KBox::pin_init(
-///     FenceContext::new(0, driver_name, timeline_name, fctx_data), GFP_K=
ERNEL)?;
+///     FenceContext::new(0, c"dummy_driver", c"dummy_timeline", fctx_data=
),
+///     GFP_KERNEL,
+/// )?;
 ///
 /// struct FenceData {
 ///     data: CString,
 /// }
 ///
-/// let data =3D CString::try_from_fmt(fmt!("dummy_data"))?;
-/// let fence_data =3D FenceData { data };
+/// let fence_data =3D FenceData { data: c"dummy_data".try_into()? };
 ///
 /// let fence_alloc =3D fctx.new_fence_allocation(fence_data)?;
 /// let mut fence =3D fence_alloc.new_fence();
@@ -718,8 +717,8 @@ pub struct DriverFenceAllocation<'a, T: Send + Sync + F=
enceContextOps> {
     /// Handed over to a [`DriverFence`], or deallocated once the
     /// [`DriverFenceAllocation`] drops.
     data: KBox<DriverFenceData<'a, T>>,
-    /// Pointer for the ops for the associated [`FenceContext`]
-    ops: *const bindings::dma_fence_ops,
+    /// Reference for the ops for the associated [`FenceContext`]
+    ops: &'static bindings::dma_fence_ops,
 }

 impl<'a, T: Send + Sync + FenceContextOps> DriverFenceAllocation<'a, T> {
