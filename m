Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7314CA601F
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 19:14:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 042D410EB3D;
	Fri,  9 Oct 2026 19:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gPVPSvYZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA1C10EB3D
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 19:14:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 90D0060DC8;
 Fri,  9 Oct 2026 19:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03DC1F00893;
 Fri,  9 Oct 2026 19:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791573292;
 bh=YSuqTftzC9l6Q/YRAwBSNw8UGuznU+7WVtVdjF4I7jw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gPVPSvYZNniRMlmQhCJhYioUdOxipshf7LZGO6r3ujvNCBlajybubM3rQBxhmNyiI
 gn/+IwHUH0v8FE+KPSIT9D3FES2VVBpVaRU5dldzRfLF/J2BgkjigKMmH5GbmMpx4t
 VE3sNx0tpegrcMeP3UefIaW6+aqJEMqM0j3AUgghR7aKEV7StHK4SlTCDG8DazImhO
 CV8rKaw4rw8GwJNxQ+goOYSROG7xe9szUzG8/OO8mcWqjcR5aoaTE4niZ9xPROBp3V
 oT5d8N1wuM6f7rfNSOb7+E33ti2Btm6eaHhuLKs8k53dJTCmlRapneFyFdTUPlIIaQ
 Qf3dwiP3HngzQ==
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
Subject: [RFC PATCH v5 5/6] rust: DmaFence: Replace call_rcu() with
 synchronize_rcu()
Date: Fri,  9 Oct 2026 21:11:23 +0200
Message-ID: <20261009191124.1022902-7-phasta@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009191124.1022902-2-phasta@kernel.org>
References: <20261009191124.1022902-2-phasta@kernel.org>
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

The C dma_fence contract demands that a fence's data disappears no
earlier than 1 RCU grace period after the DriverFence was signaled.

So far, we achieved this with dropping the DriverFence's data in a
deferred manner with a manual, raw binding call to call_rcu().

However, this call_rcu() does not solve one problem: It is conceivable
that some driver data must not drop in atomic context; but call_rcu()'s
payload *can* be executed in atomic context.

Moreover, the current developments in drm::JobQueue, where a DriverFence
is always coupled 1:1 with a Job, allows for dropping job and fence
through a work item.

The undesirable blocking behavior of synchronize_rcu() would, thus, not
be annoying any thread anymore. The direct users of DmaFence could
achieve the same by dropping their DriverFences through work items.

The only conceivable other solution, queue_rcu_work(), would, for many
users, schedule a work_item from another work_item, which seems
undesirable.

Additionally, using the existing synchronize_rcu() abstraction has the
advantage of us getting rid of a raw bindings call.

Replace DriverFence::drop()'s call_rcu() with synchronize_rcu().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 rust/kernel/dma_buf/dma_fence.rs | 71 +++++++-------------------------
 1 file changed, 14 insertions(+), 57 deletions(-)

diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_fence.rs
index 4e9b4a6a9471..cefcde80bf09 100644
--- a/rust/kernel/dma_buf/dma_fence.rs
+++ b/rust/kernel/dma_buf/dma_fence.rs
@@ -42,7 +42,8 @@
             Atomic,
             Relaxed, //
         },
-        rcu::rcu_barrier, //
+        rcu::rcu_barrier,
+        rcu::synchronize_rcu, //
     }, //
 };
 
@@ -150,7 +151,6 @@ pub fn new_fence_allocation(
         data: T::FenceDataType,
     ) -> Result<DriverFenceAllocation<'_, T>> {
         let fence_data = DriverFenceData {
-            rcu_head: Default::default(),
             // `inner` remains uninitialized until a `DriverFence` takes over.
             inner: Fence {
                 inner: Opaque::uninit(),
@@ -640,8 +640,6 @@ struct DriverFenceData<'a, T: Send + Sync + FenceContextOps> {
     // necessary so that the C backend can free the allocation (coming from our
     // Rust code) with kfree_rcu().
     inner: Fence,
-    /// Callback head for dropping this in a deferred manner through RCU.
-    rcu_head: bindings::callback_head,
     /// Reference to access the FenceContext.
     fctx: &'a FenceContext<T>,
     /// The API user's data. It is essential that the data only performs
@@ -1022,59 +1020,18 @@ fn drop(&mut self) {
             return;
         }
 
-        // SAFETY: Valid because `self` is valid.
-        let rcu_head_ptr = unsafe { &raw mut (*self.data.as_ptr()).rcu_head };
+        // Make sure none of the fence backend_ops can access data anymore.
+        //
+        // TODO:
+        // This would not be necessary if the C dma_fence backend were using a
+        // spinlock to properly synchronize its signaled state. Fix it in C and
+        // then remove synchronize_rcu().
+        synchronize_rcu();
 
-        // SAFETY: `call_rcu()` is always safe to be called. `rcu_head_ptr` was
-        // created validly above. The module must perform a `synchronize_rcu()`
-        // or `rcu_barrier()` call to guard against module unload.
-        unsafe { bindings::call_rcu(rcu_head_ptr, Some(drop_driver_fence_data::<T>)) };
+        // SAFETY: Valid because `self` is valid.
+        unsafe { drop_in_place(&raw mut self.data) };
+
+        // SAFETY: The `synchronize_rcu()` above ensures all accessors are gone.
+        unsafe { bindings::dma_fence_put(self.as_raw()) };
     }
 }
-
-// TODO:
-// The entire call_rcu() mechanism in the drop above and the code below would be
-// unnecessary if C's dma_fence_signal() could be reworked in a way that after it
-// ran, the caller knows that no fence_ops callbacks can be running anymore.
-// In other words, if the dma_fence backend would use its spinlock for full
-// synchronization.
-//
-// Then we could move the drop_in_place() and dma_fence_put() upwards into the
-// drop() implementation and call it a day.
-
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
-}
-- 
2.55.0

