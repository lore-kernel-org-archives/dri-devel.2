Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3434606A336
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dBNkSkHR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2027710F54F;
	Tue, 24 Nov 2026 12:31:10 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ED9C10F54E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:31:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E95E962242;
 Tue, 24 Nov 2026 12:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CBDE1F000D2;
 Tue, 24 Nov 2026 12:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795523462;
 bh=X/pLAvXBjN3peadDekwkzwvrCqHZdu+Q1dzWoZnyZME=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dBNkSkHRmfdGywSSlwnwH0lbT8O498XbSWSv6CR4u2VqdUU3LIszscqE+gOIELPgW
 yKWMunVNGXd1kP4OUQEk19K2qYLmmmG6J0Brm6YR5CcLTrKV/QC4Qcz7Oaq+/+ZiCD
 6ymwN4XkxDkYAZPo1kkJHnkTQ7jd3pFfEzV0wrL/6UKBkjUDLzceKDssSDCGW4sLhh
 yCDCxqm6Q1YRJhv80/FQkLEr8NKsMOzUYcJ6pAcqPQrtzyTAroC5DSh/zLgfZbVLtF
 48cODiW2Wtl6yIKNUcFqBZrwe3A4PgAYvr2IeVsbYsiSe/xXvc3ARxAFnLtVyirO+R
 EdAs12cGjnhXQ==
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
Subject: [PATCH v2 06/10] rust: DmaFence: Replace call_rcu() with
 cond_synchronize_rcu()
Date: Tue, 24 Nov 2026 13:29:48 +0100
Message-ID: <20261124122951.878199-8-phasta@kernel.org>
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

The C dma_fence contract demands that a fence's data disappears no
earlier than 1 RCU grace period after the DriverFence was signaled. So
far, we achieved this with dropping the DriverFence's data in a deferred
manner with a manual, raw binding call to call_rcu().

However, this call_rcu() does not solve one problem: It is conceivable
that some driver data must not drop in atomic context; but call_rcu()'s
payload *can* be executed in atomic context.

Moreover, the current developments in drm::JobQueue, where a DriverFence
is always coupled 1:1 with a Job, allows for dropping job and fence
through a work item.

We can satisfy the grace period requirement in a safe yet performant
manner by using cond_synchronize_rcu(), which only waits for a grace
period if the specified grace period has not yet passed.

We can exactly identify the right grace period by setting a cookie in
DriverFence::signal().

Replace DriverFence::drop()'s call_rcu() with cond_synchronize_rcu().

An implication of this is that fences must for now drop in process
context until someone finds a more elegant solution. Document this
requirement.

Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/dma_buf/dma_fence.rs | 133 +++++++++++++------------------
 1 file changed, 56 insertions(+), 77 deletions(-)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index c04b68fe67fe..20dadbde4eb9 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -21,6 +21,7 @@
 };
 
 use core::{
+    cell::UnsafeCell,
     marker::PhantomData,
     mem::ManuallyDrop,
     ops::Deref,
@@ -42,7 +43,11 @@
             Atomic,
             Relaxed, //
         },
-        rcu::rcu_barrier, //
+        rcu::{
+            cond_synchronize_rcu,
+            get_state_synchronize_rcu,
+            synchronize_rcu, //
+        },
     }, //
 };
 
@@ -58,6 +63,8 @@ pub trait FenceContextOps {
 /// A dma-fence context. A fence context takes care of associating related fences
 /// with each other, providing each with raising sequence numbers and a common
 /// identifier.
+///
+/// A FenceContext must drop in non-atomic context.
 #[pin_data(PinnedDrop)]
 pub struct FenceContext<T: FenceContextOps + Send + Sync> {
     /// The fence context number.
@@ -65,7 +72,7 @@ pub struct FenceContext<T: FenceContextOps + Send + Sync> {
     /// The sequence number for the next fence created.
     seqno: Atomic<u64>,
     // The name parameters can be accessed by the dma_fence backend_ops. UAF
-    // errors are prevented by the `call_rcu()` in `drop_driver_fence_data()`.
+    // errors are prevented by `synchronize_rcu()`.
     /// The name of the driver this FenceContext's fences belong to.
     driver_name: CString,
     /// The name of the timeline this FenceContext's fences belong to.
@@ -149,20 +156,17 @@ fn next_seqno(&self) -> u64 {
     ///
     /// This is needed because many times, creation of a [`DriverFence`] must not
     /// fail, and allocating might deadlock in some situations.
-    ///
-    /// The `data` you pass here must not perform any operations that are illegal
-    /// in atomic context in its [`Drop`] implementation.
     pub fn new_fence_allocation(
         &self,
         data: T::FenceDataType,
     ) -> Result<DriverFenceAllocation<'_, T>> {
         let fence_data = DriverFenceData {
-            rcu_head: Default::default(),
             // `inner` remains uninitialized until a `DriverFence` takes over.
             inner: Fence {
                 inner: Opaque::uninit(),
             },
             fctx: self,
+            synchronize_rcu_cookie: UnsafeCell::new(0),
             data,
         };
 
@@ -243,15 +247,10 @@ fn drop(self: Pin<&mut Self>) {
             panic!("Forgotten fences in FenceContext.");
         }
 
-        // Ensure that the driver cannot unload while there are still dma_fence
-        // callbacks running. At the same time, the RCU barrier addresses the
-        // problem inherited by the C backend, in which backend ops callbacks
-        // might be accessing the fence while it is being signaled (or shortly
-        // after). This could cause UAF access on the fence context's
-        // `fctx.driver_name` and `fctx.timeline_name`.
-        //
-        // Wait for the RCU callbacks in `DriverFence::drop`.
-        rcu_barrier();
+        // If a DriverFence signals without doing a synchronize_rcu(), and a
+        // fctx drops immediately afterwards, then backend_ops still accessing
+        // the fctx might run into UAF if we don't wait for them here.
+        synchronize_rcu();
     }
 }
 
@@ -615,12 +614,14 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
     // necessary so that the C backend can free the allocation (coming from our
     // Rust code) with kfree_rcu().
     inner: Fence,
-    /// Callback head for dropping this in a deferred manner through RCU.
-    rcu_head: bindings::callback_head,
     /// Reference to access the FenceContext.
     fctx: &'a FenceContext<T>,
-    /// The API user's data. It is essential that the data only performs
-    /// operations legal in atomic context in its [`Drop`] implementation.
+    /// A cookie that helps with reducing the number of costly calls to
+    /// `synchronize_rcu()` in [`DriverFence::drop()`].
+    ///
+    /// This [`UnsafeCell`] is protected by `inner`'s spinlock.
+    synchronize_rcu_cookie: UnsafeCell<usize>,
+    /// The API user's data.
     #[pin]
     data: T::FenceDataType,
 }
@@ -659,6 +660,8 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
 ///
 /// In the unlikely case of such violations, a panic is thrown.
 ///
+/// A DriverFence must drop in non-atomic context.
+///
 /// # Examples
 ///
 /// ```
@@ -831,7 +834,6 @@ pub fn signal(&self, res: Result) {
                 // must not have been signaled yet, which we check directly above.
                 unsafe { bindings::dma_fence_set_error(fence.as_raw(), err.to_errno()) };
             }
-
             // SAFETY: `self.data` is valid because `self` is valid.
             let fctx = unsafe { self.data.as_ref().fctx };
             let _ = fctx.nr_of_unsignaled_fences.fetch_sub(1, Relaxed);
@@ -839,6 +841,11 @@ pub fn signal(&self, res: Result) {
             // SAFETY: `fence` is valid because `self` is valid. The lock must
             // be held, which we acquired above.
             unsafe { bindings::dma_fence_signal_locked(fence.as_raw()) };
+
+            // SAFETY: `self.data` is valid because `self` is valid.
+            // The lock guarantees exclusivity.
+            let rcu_cookie = unsafe { &mut *self.data.as_ref().synchronize_rcu_cookie.get() };
+            *rcu_cookie = get_state_synchronize_rcu();
         }
     }
 }
@@ -955,15 +962,15 @@ fn drop(&mut self) {
         // dma_fence_is_signaled_locked() because the C backend wants to get rid
         // of the latter.
 
-        // SAFETY: `guard` is valid until the `call_rcu()` below.
+        // SAFETY: `guard` is valid.
         let signaled: bool = unsafe { bindings::dma_fence_test_signaled_flag(guard.as_raw()) };
         if !signaled {
             pr_err!("DriverFence drops unsignaled. Danger of memory corruption!\n");
-            // SAFETY: `guard` is valid until the `call_rcu()` below. The fence
-            // must not have been signaled yet, which we check directly above.
+            // SAFETY: `guard` is valid. The fence must not have been signaled
+            // yet, which we check directly above.
             unsafe { bindings::dma_fence_set_error(guard.as_raw(), ECANCELED.to_errno()) };
-            // SAFETY: `guard` is valid until the `call_rcu()` below. The lock
-            // must be held, which we acquired above.
+            // SAFETY: `guard` is valid. The lock must be held, which we
+            // acquired above.
             unsafe { bindings::dma_fence_signal_locked(guard.as_raw()) };
 
             // SAFETY: `self.data` is valid because `self` is valid.
@@ -988,59 +995,31 @@ fn drop(&mut self) {
             return;
         }
 
-        // SAFETY: Valid because `self` is valid.
-        let rcu_head_ptr = unsafe { &raw mut (*self.data.as_ptr()).rcu_head };
+        // SAFETY: `self` is valid. No one can access the cookie anymore because
+        // we are dropping.
+        let rcu_cookie = unsafe { *self.data.as_ref().synchronize_rcu_cookie.get() };
 
-        // SAFETY: `call_rcu()` is always safe to be called. `rcu_head_ptr` was
-        // created validly above. The module must perform a `synchronize_rcu()`
-        // or `rcu_barrier()` call to guard against module unload.
-        unsafe { bindings::call_rcu(rcu_head_ptr, Some(drop_driver_fence_data::<T>)) };
-    }
-}
+        // Make sure none of the fence backend_ops can access fence-data anymore.
+        //
+        // TODO:
+        // This would not be necessary if the C dma_fence backend were using a
+        // spinlock to properly synchronize its signaled state. Fix it in C and
+        // then remove synchronize_rcu().
+        if rcu_cookie != 0 {
+            // SAFETY: The if-else checks whether the cookie was validly
+            // initialized when this fence signaled.
+            unsafe { cond_synchronize_rcu(rcu_cookie) };
+        } else {
+            // The user never signaled this fence. We don't know the grace period.
+            synchronize_rcu();
+        }
 
-// TODO:
-// The entire call_rcu() mechanism in the drop above and the code below would be
-// unnecessary if C's dma_fence_signal() could be reworked in a way that after it
-// ran, the caller knows that no fence_ops callbacks can be running anymore.
-// In other words, if the dma_fence backend would use its spinlock for full
-// synchronization.
-//
-// Then we could move the drop_in_place() and dma_fence_put() upwards into the
-// drop() implementation and call it a day.
+        // SAFETY: Valid because `self` is valid. RCU above ensures that all
+        // accessors are gone.
+        unsafe { drop_in_place(&raw mut self.data) };
 
-/// Finally really drop this `DriverFence<T>`
-///
-/// # Safety
-///
-/// `head` references the `rcu_head` field of an `DriverFenceData<T>`. All
-/// accessors to that `DriverFenceData<T>` must be gone by now. This must be
-/// ensured by signalling the associated `DriverFence<T>` and then waiting
-/// for a grace period until calling this function here.
-unsafe extern "C" fn drop_driver_fence_data<T: Send + Sync + FenceContextOps>(
-    head: *mut bindings::callback_head,
-) {
-    // SAFETY: Caller provides a pointer to the `rcu_head` field of a `DriverFenceData<C>`.
-    let fence_data = unsafe { container_of!(head, DriverFenceData<'_, T>, rcu_head) };
-
-    // SAFETY: `fence_data` was created validly above. All the fence's data will
-    // only drop below, but the raw pointer to the raw C `dma_fence` remains
-    // valid because the reference count is only decremented at the end of the
-    // function.
-    let fence = unsafe { (*fence_data).inner.inner.get() };
-
-    // SAFETY: `fence_data` was created validly above. The user has already
-    // dropped the only conventional accessor to the user data, the `DriverFence`,
-    // one grace period ago. All accessors are gone now.
-    unsafe { drop_in_place(&raw mut (*fence_data).data) };
-
-    // The inner `Fence` explicitly does not get dropped because there may be
-    // many more users / consumers, each holding their own reference.
-
-    // SAFETY: Once a `DriverFence` is initialized, the inner `fence` is valid
-    // and initialized. It is valid until the refcount drops to 0, which can
-    // earliest happen once we drop the `DriverFence`'s reference here.
-    unsafe { bindings::dma_fence_put(fence) };
-
-    // The actual memory the data associated with a `DriverFence` lives in
-    // gets freed by the C dma_fence backend once the fence's refcount reaches 0.
+        // SAFETY: Valid because `self` is valid. This is the initial reference
+        // from when this `DriverFence` was created.
+        unsafe { bindings::dma_fence_put(self.as_raw()) };
+    }
 }
-- 
2.56.0

